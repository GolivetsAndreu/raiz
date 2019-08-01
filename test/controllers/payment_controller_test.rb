require 'test_helper'

class PaymentControllerTest <  Capybara::Rails::TestCase
  test "doesn't do transaction when blank form" do
    visit root_path
    click_on 'Transfer'

    assert page.has_content?('From account must exist')
    assert page.has_content?('To account must exist')
    assert page.has_content?("From account can't be blank")
    assert page.has_content?("To account can't be blank")
    assert page.has_content?("Amount can't be blank")
  end
end
