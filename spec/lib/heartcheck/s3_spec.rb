describe Heartcheck::Checks::S3 do
  describe '#validate' do
    let(:bucket)    { 'bucket_name' }
    let(:aws)       { double('Aws::S3::Resource') }
    let(:connector) { double(Heartcheck::Checks::S3::Connector) }
    let(:errors) { subject.instance_variable_get(:@errors) }

    let(:service) do
      {
        name: 'S3 :: Bucket Access',
        check: :bucket_access,
        connection: aws,
        bucket: bucket
      }
    end

    subject { described_class.new.tap { |c| c.add_service(service) } }

    context 'when its a success' do
      before do
        allow(Heartcheck::Checks::S3::Connector).to receive(:new).and_return(connector)
        allow(Heartcheck::Checks::S3::Validator).to receive(:run)

        subject.validate
      end

      it 'runs validation' do
        expect(Heartcheck::Checks::S3::Validator).to(
          have_received(:run).with(connector: connector, service: service)
        )
      end

      it 'instantiates a connector' do
        expect(Heartcheck::Checks::S3::Connector).to(
          have_received(:new).with(conn: aws, bucket: bucket)
        )
      end

      it { expect(errors).to be_empty }
    end

    context 'when its a failure' do
      let(:error) { 'some error' }

      before do
        allow(Heartcheck::Checks::S3::Validator).to receive(:run)
          .and_raise(RuntimeError, error)

        subject.validate
      end

      it { expect(errors).to include("RuntimeError - #{error}") }
    end
  end
end
