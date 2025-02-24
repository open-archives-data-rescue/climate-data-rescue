require 'rails_helper'

describe StaticPage do
  let(:static_page) { build(:static_page) }
  subject { static_page }
  let(:klass) { StaticPage }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:children) }
    it { is_expected.to belong_to(:parent).optional(true) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:update_positions_and_slug).before(:save) }
  end

  describe 'scopes' do
    describe '.visible' do
      it { expect(klass).to respond_to(:visible).with(1).argument }
    end
    describe '.top_level' do
      it { expect(klass).to respond_to(:top_level).with(1).argument }
    end
    describe '.header_links' do
      it { expect(klass).to respond_to(:header_links).with(1).argument }
    end
    describe '.footer_links' do
      it { expect(klass).to respond_to(:footer_links).with(1).argument }
    end
    describe '.transcriber_links' do
      it { expect(klass).to respond_to(:transcriber_links).with(1).argument }
    end
  end

  describe '#link' do
    it do
      expect(static_page.link).to eq("/#{I18n.locale}#{static_page.slug}")
    end
  end

  describe '.matches?' do
    it { expect(klass).to respond_to(:matches?).with(1).argument }
  end
end
