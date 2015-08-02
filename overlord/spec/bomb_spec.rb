require 'spec_helper'

describe Bomb do
  it 'is inactive upon booting' do
    bomb = Bomb.new
    expect(bomb.inactive?).to be_truthy
  end

  describe 'input validation' do
    let(:activation_code)   { '4321' }
    let(:deactivation_code) { '9999' }
    let(:bomb) do
      Bomb.new(activation_code:   activation_code,
               deactivation_code: deactivation_code)
    end

    ['foo', '1.234', '1234!'].each do |input|
      it "rejects the non-numeric input '#{input}'" do
        expect { bomb.enter_code('foo') }.to raise_error
      end
    end
  end

  describe 'activation' do
    let(:activation_code)   { '4321' }
    let(:deactivation_code) { '9999' }
    let(:bomb) do
      Bomb.new(activation_code:   activation_code,
               deactivation_code: deactivation_code)
    end

    it 'is activated if the correct activation code is entered' do
      # TODO custom rspec matcher to_activate(bomb) and to_deactivate(bomb)?
      expect { bomb.enter_code(activation_code) }.
        to change { bomb.active? }.from(false).to(true)
    end

    it 'remains inactive if the wrong activation code is entered' do
      expect { bomb.enter_code(activation_code.reverse) }.
        to_not change { bomb.active? }
    end
 
    it 'does nothing if the activation code is entered again' do
      bomb.enter_code(activation_code)
      expect { bomb.enter_code(activation_code) }.
        not_to change { bomb.active? }
    end
  end

  describe 'deactivation' do
    let(:activation_code)   { '4321' }
    let(:deactivation_code) { '9999' }
    let(:wrong_code)        { '6666' }
    let(:bomb) do
      Bomb.new(activation_code:   activation_code,
               deactivation_code: deactivation_code)
    end

    before { bomb.enter_code(activation_code) }

    it 'is deactivated if the correct deactivation code is entered' do
      expect { bomb.enter_code(deactivation_code) }.
        to change { bomb.active? }.from(true).to(false)
    end

    it 'remains active if the wrong deactivation code is entered twice' do
      expect { 2.times { bomb.enter_code(wrong_code) } }.
        not_to change { bomb.active? }
    end

    it 'explodes if the wrong deactivation code is entered three times' do
      2.times { bomb.enter_code(wrong_code) }
      expect(bomb).to receive(:explode)
      bomb.enter_code(wrong_code)
    end

    context 'has been deactivated and reactivated' do
      before do
        bomb.enter_code(deactivation_code)
        bomb.enter_code(activation_code)
      end

      it 'remains active if the wrong deactivation code is entered twice (resets number of attempts)' do
        expect { 2.times { bomb.enter_code(wrong_code) } }.
          not_to change { bomb.active? }
      end
    end

    context 'has exploded' do
      before { 3.times { bomb.enter_code(wrong_code) } }

      it 'indicates it is not in service' do
        expect(bomb.not_in_service?).to be_truthy
      end

      it 'does not accept any input' do
        expect { bomb.enter_code(deactivation_code) }.to raise_error
      end
    end
  end

  describe 'default configuration' do
    it 'has a default activation code of 1234' do
      bomb = Bomb.new
      expect { bomb.enter_code('1234') }.
        to change { bomb.active? }.from(false).to(true)
    end

    it 'has a default deactivation code of 0000' do
      bomb = Bomb.new(activation_code: '1234')
      bomb.enter_code('1234')
      expect { bomb.enter_code('0000') }.
        to change { bomb.active? }.from(true).to(false)
    end
  end
end
