module LoginMacro
  def login_as(user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "password65432123"
    find("#sign-in").click
    expect(page).to have_content "ログインしました"
  end
end
