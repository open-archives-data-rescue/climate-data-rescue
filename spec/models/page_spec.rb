require 'rails_helper'

describe Page do
  let(:page) { build(:page) }
  subject { page }
  let(:klass) { Page }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
  end

  describe 'ActiveModel validations' do
  end

  describe 'callbacks' do
    it { is_expected.to callback(:extract_upload_dimensions).before(:save) }
    it { is_expected.to callback(:check_for_delete).before(:destroy) }
  end

  describe 'paperclip attachment' do
    it { is_expected.to have_attached_file(:image) }
    it { is_expected.to validate_attachment_content_type(:image).
                  allowing("image/jpg","image/jpeg", "image/png") }
  end

  describe '#has_page_metadata?' do
    it { is_expected.to respond_to(:has_page_metadata?) }

    context 'when it has page_metadata' do
      it 'returns true' do
        page.page_info = PageInfo.new
        expect(page.has_page_metadata?).to be_truthy
      end
    end

    context 'when it does not have a page_metadata' do
      it 'returns true' do
        page.page_info = nil
        expect(page.has_page_metadata?).to be_falsy
      end
    end
  end

  describe '#has_metadata?' do
    it { is_expected.to respond_to(:has_metadata?) }

    context 'when it has page_days' do
      it 'returns true' do
        page.page_days.new
        expect(page.has_metadata?).to be_truthy
      end
    end

    context 'when it does not have a page_day' do
      it 'returns true' do
        page.page_days = []
        expect(page.has_metadata?).to be_falsy
      end
    end
  end

  describe '#num_rows_expected' do
    context 'when the page has page_days' do
      it 'returns the sum of the page days num_observations' do
        page.page_days = build_list(:page_day, 3)
        expect(page.num_rows_expected).to eq(page.page_days.sum(:num_observations))
      end
    end

    context 'when the page does not have page days' do
      it 'returns 0' do
        page.page_days = []
        expect(page.num_rows_expected).to eq(0)
      end
    end
  end

  describe '#to_jq_upload' do
    it { is_expected.to respond_to(:to_jq_upload) }
    it { expect(page.to_jq_upload).to be_a(Hash) }
    it do
      hash_keys = %w[
        name size url thumbnailUrl deleteUrl deleteType pageId
      ]
      expect(page.to_jq_upload.keys).to contain_exactly(*hash_keys)
    end
  end

  describe '#extract_dimensions' do
    it { is_expected.to respond_to(:extract_dimensions) }

    context 'when the page has no image' do
      it { expect{ page.extract_dimensions }.to_not change{ page.width }  }
      it { expect{ page.extract_dimensions }.to_not change{ page.height }  }
    end

    # context 'when page has an image' do
    #   let(:page) { build(:page, :image) }
    #   it { expect{ page.extract_dimensions }.to change{ page.width }  }
    #   it { expect{ page.extract_dimensions }.to change{ page.height }  }
    # end
  end
end
