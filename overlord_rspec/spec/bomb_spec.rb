describe Bomb do
  it 'is inactive when created', :practice => true, :exercise => 1 do
    bomb = Bomb.new
    expect(bomb.status).to eq(:inactive)
  end

  context 'when it is inactive' do
    it 'is not activated if the wrong activation code is entered' do
      bomb = Bomb.new(activation_code: '1234')
      bomb.enter_code('4321')
      expect(bomb).to be_inactive
    end

    it 'is activated if the correct activation code is entered', :practice => true, :exercise => 2

    it 'does not change status if the correct activation code is entered again', :practice => true, :exercise => 3

  end

  context 'when it has been activated' do
    let(:bomb) do
      Bomb.new(activation_code:   '1111',
               deactivation_code: '2222')
    end

    it 'is deactivated if the correct deactivation code is entered' do
      bomb.enter_code('1111')
      bomb.enter_code('2222')
      expect(bomb).to be_inactive
    end

    it 'lowers the number of remaining attempts by 1 if the wrong deactivation code is entered', :practice => true, :exercise => 4

    it 'does not explode if the wrong deactivation code is entered twice' do
      bomb.enter_code('1111')
      expect(bomb).not_to receive(:explode)
      2.times { bomb.enter_code('6666') }
    end

    it 'explodes if the wrong deactivation code is entered three times', :practice => true, :exercise => 5

    context 'when it has exploded' do
      before do
        # TODO make the bomb explode
        # ...
      end

      it 'indicates that it is out-of-service', :practice => true, :exercise => 6 do
        expect(bomb).to be_out_of_service
      end

      it 'does not accept any input' do
        expect { bomb.enter_code('2222') }.to raise_error(OutOfServiceError)
      end
    end
  end

  context 'when it uses the default configuration' do
    it "has an activation code of '1234'" do
      subject.enter_code('1234')
      expect(subject).to be_active
    end

    it "has a deactivation code of '0000'" do
      subject.enter_code('1234')
      subject.enter_code('0000')
      expect(subject).to be_inactive
    end
  end

  describe 'input validation' do
    it "rejects the non-numeric input 'foo'", :practice => true, :exercise => 7 do
      expect {
        # TODO do something here that will raise an input error
        # ...
      }.to raise_error(InvalidInputError)
    end

    it "rejects the non-numeric input '1234!'", :practice => true, :exercise => 8

    it 'validates the configured activation code' do
      expect { Bomb.new(activation_code: 'foo') }.to raise_error(InvalidInputError)
    end

    it 'validates the configured deactivation code', :practice => true, :exercise => 9
  end
end
