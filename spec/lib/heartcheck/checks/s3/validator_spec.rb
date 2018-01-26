shared_examples 'validator' do |check, validator|
  let(:validator_class) { validator }
  let(:service)         { { check: check } }

  before do
    allow(validator_class).to receive(:validate!)

    subject.run(connector: connector, service: service)
  end

  it do
    expect(validator).to(
      have_received(:validate!).with(connector: connector, service: service)
    )
  end
end

describe Heartcheck::Checks::S3::Validator do
  describe '.run' do
    let(:connector) { double(Heartcheck::Checks::S3::Connector) }

    context 'when we need to check bucket_access' do
      it_should_behave_like 'validator',
                            :bucket_access,
                            Heartcheck::Checks::S3::Validator::BucketAccess
    end

    context 'when we need to check bucket_permissions' do
      it_should_behave_like 'validator',
                            :bucket_permissions,
                            Heartcheck::Checks::S3::Validator::BucketPermissions
    end

    context 'when we need to check bucket_cors' do
      it_should_behave_like 'validator',
                            :bucket_cors,
                            Heartcheck::Checks::S3::Validator::BucketCors
    end

    context 'when validator do not exist' do
      let(:service) { { check: 'foobar' } }

      subject { described_class.run(connector: connector, service: service) }

      it { expect { subject }.to raise_error(RuntimeError, /Unknown Check/) }
    end
  end
end
