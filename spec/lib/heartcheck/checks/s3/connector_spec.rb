describe Heartcheck::Checks::S3::Connector do
  describe '#can_access_bucket?' do
    let(:conn) { double('Aws::S3::Resource') }
    let(:bucket_name) { 'bucket_name' }
    let(:bucket) { double('Aws::S3::Bucket', 'exists?' => true) }

    subject { described_class.new(conn: conn, bucket: bucket_name) }

    before do
      allow(conn).to receive(:bucket).and_return(bucket)
    end

    it { expect(subject.can_access_bucket?).to be true }
  end

  describe '#permissions' do
    let(:conn) { double('Aws::S3::Resource') }
    let(:bucket_name) { 'bucket_name' }
    let(:permissions) { ['READ'] }
    let(:grant) { double('grant', permission: permissions) }
    let(:acl) { double('acl', grants: [grant]) }
    let(:bucket) { double('Aws::S3::Bucket', acl: acl) }

    subject { described_class.new(conn: conn, bucket: bucket_name) }

    before do
      allow(conn).to receive(:bucket).and_return(bucket)
    end

    it { expect(subject.permissions).to match([permissions]) }
  end

  describe '#cors' do
    let(:conn) { double('Aws::S3::Resource') }
    let(:bucket_name) { 'bucket_name' }
    let(:cors_rules) { double }
    let(:cors) { double('cors', cors_rules: [cors_rules]) }
    let(:bucket) { double('Aws::S3::Bucket', cors: cors) }

    subject { described_class.new(conn: conn, bucket: bucket_name) }

    before do
      allow(conn).to receive(:bucket).and_return(bucket)
    end

    it { expect(subject.cors).to eq cors_rules }
  end
end
