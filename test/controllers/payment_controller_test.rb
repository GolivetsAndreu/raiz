require 'test_helper'

class PaymentControllerTest <  Capybara::Rails::TestCase
  test "doesn't do transaction when blank form" do
    # post root_path, params: { from_score_id: '', to_score_id: '', amount: '' }
    visit root_path
    click_on 'Transfer'

    assert page.has_content?('From score must exist')
    assert page.has_content?('To score must exist')
    assert page.has_content?("From score can't be blank")
    assert page.has_content?("To score can't be blank")
    assert page.has_content?("Amount can't be blank")
  end
end
