require 'rails_helper'

RSpec.describe "ChatGPTの問い合わせ機能", type: :system, selenium: true do
  include LoginMacro

  let!(:user) { FactoryBot.create(:user) }


  before do
    login_as(user)
  end

  describe '該当する都市区分をChatGPTへ問い合わせる機能' do
    context '都道府県、市町村を入力して、「ChatGPTに尋ねる」をクリックした場合' do
      it '都市区分について、ChatGPTの回答が表示される' do
        find("#branches-index").click
        find("#branches-new").click
        find(".accordion-button").click
        sleep 0.1

        fill_in "ask_prefecture", with: "千葉県"
        fill_in "ask_city", with: "千葉市"
        click_on "ChatGPTに尋ねる"

        expect(page).to have_content "ChatGPTによる回答"
        within all("#chatgpt-response").first do
          expect(page).to have_content "千葉市"
          expect(page).to have_content /大都市|中都市|小都市A|小都市B|町村/
        end
      end
    end
  end
end
