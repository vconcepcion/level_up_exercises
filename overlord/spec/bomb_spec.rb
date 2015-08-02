require 'spec_helper'

describe Bomb do
  it 'is inactive upon booting' do
    bomb = Bomb.new
    expect(bomb).to be_inactive
  end

  describe 'activation' do
    let(:activation_code) { '4321' }
    let(:wrong_code)      { '1234' }
    let(:bomb)            { Bomb.new(activation_code: activation_code) }

    it 'is activated if the correct activation code is entered' do
      bomb.enter_code(activation_code)
      expect(bomb).to be_active
    end

    it 'remains inactive if the wrong activation code is entered' do
      bomb.enter_code(wrong_code)
      expect(bomb).to be_inactive
    end
 
    it 'does nothing if the correct activation code is entered again' do
      bomb.enter_code(activation_code)
      expect { bomb.enter_code(activation_code) }.
        not_to change { bomb.status }
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
      bomb.enter_code(deactivation_code)
      expect(bomb).to be_inactive
    end

    it 'lowers the number of remaining attempts by 1 if the wrong code is entered' do
      expect { bomb.enter_code(wrong_code) }.
        to change { bomb.num_attempts_remaining }.by(-1)
    end

    it 'remains active if the wrong deactivation code is entered twice' do
      expect { 2.times { bomb.enter_code(wrong_code) } }.
        not_to change { bomb.status }
    end

    it 'explodes if the wrong deactivation code is entered three times' do
      2.times { bomb.enter_code(wrong_code) }
      expect(bomb).to receive(:explode)
      bomb.enter_code(wrong_code)
    end

    context 'has exploded' do
      before { 3.times { bomb.enter_code(wrong_code) } }

      it 'indicates it is out of service' do
        expect(bomb).to be_out_of_service
      end

      it 'does not accept any input' do
        expect { bomb.enter_code(deactivation_code) }.to raise_error
      end
    end

    context 'has been deactivated and reactivated' do
      before do
        bomb.enter_code(deactivation_code)
        bomb.enter_code(activation_code)
      end

      it 'remains active if the wrong deactivation code is entered twice (resets number of attempts)' do
        expect { 2.times { bomb.enter_code(wrong_code) } }.
          not_to change { bomb.status }
      end
    end
  end

  describe 'configuration' do
    it 'has a default activation code of 1234' do
      bomb = Bomb.new
      bomb.enter_code('1234')
      expect(bomb).to be_active
    end

    it 'has a default deactivation code of 0000' do
      bomb = Bomb.new(activation_code: '1234')
      bomb.enter_code('1234')
      bomb.enter_code('0000')
      expect(bomb).to be_inactive
    end
  end

  describe 'input validation' do
    let(:bomb) { Bomb.new }

    ['foo', '1.234', '1234!'].each do |input|
      it "rejects the non-numeric input '#{input}'" do
        expect { bomb.enter_code('foo') }.to raise_error
      end
    end

    it 'validates the configured activation code' do
      expect { Bomb.new(activation_code: 'foo') }.to raise_error
    end

    it 'validates the configured deactivation code' do
      expect { Bomb.new(deactivation_code: 'foo') }.to raise_error
    end
  end
end
