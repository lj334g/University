require "test_helper"

class FacultyTest < ActiveSupport::TestCase
  # Matchers
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_inclusion_of(:rank).in_array(['Assistant Professor', 'Associate Professor', 'Professor'])
  should belong_to(:department)
  should have_many(:assignments)
  should have_many(:courses).through(:assignments)

  # Context
  context "Given context" do
    setup do 
      create_departments
      create_faculties
    end

    should "order faculties alphabetically by last name then first name" do
      faculties = Faculty.alphabetical
      assert_equal ["Kaufer", "Kosbie", "Quesenberry"], faculties.map(&:last_name)
    end

    should "return only active faculties with active scope" do
      active_faculties = Faculty.active
      assert_equal 2, active_faculties.count
      assert_equal ["Kosbie", "Quesenberry"], active_faculties.alphabetical.map(&:last_name)
    end
  end
end