require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "alex", email: "alex@example.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "chefname should not be too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email length should be wihtin bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end

  test "email address should be unique (incl case sensitivity)" do
    dup_chef = @chef.dup                  # make shallow copy of @chef
    dup_chef.email = @chef.email.upcase   # make it harder --> add case sensitivity
    @chef.save                            # save chef to database
    assert_not dup_chef.valid?            # chef with same email address but uppercase should not be allowed
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@blabla.au peter+miller@super.cn]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@eee+aar.com]
    invalid_addresses.each do |iva|
      @chef.email = iva
      assert_not @chef.valid?, '#{iva.inspect} should be invalid'
    end
  end

end