require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @account = accounts(:one)
  end

  test "should get index" do
    get accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_account_url
    assert_response :success
  end

  test "should create account" do
    assert_difference("Account.count") do
      post accounts_url, params: { account: { name: @account.name, kind: @account.kind, currency_id: @account.currency_id } }
    end

    assert_redirected_to account_url(Account.last)
  end

  test "should show account" do
    get account_url(@account)
    assert_response :success
  end

  test "should get edit" do
    get edit_account_url(@account)
    assert_response :success
  end

  test "should update account" do
    patch account_url(@account), params: { account: { name: @account.name, kind: @account.kind, currency_id: @account.currency_id } }
    assert_redirected_to account_url(@account)
  end

  test "should destroy account" do
    unused_account = Account.create!(
      user: users(:one),
      name: "Unused Account",
      kind: "asset",
      currency: currencies(:one)
    )
    assert_difference("Account.count", -1) do
      delete account_url(unused_account)
    end

    assert_redirected_to accounts_url
  end
end
