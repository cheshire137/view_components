# frozen_string_literal: true

require "test_helper"

class PrimerNavigationTabComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_title
    render_inline Primer::Navigation::TabComponent.new do |c|
      c.text { "Title" }
    end

    assert_selector("a") do
      assert_selector("span", text: "Title")
    end
    refute_selector("a[role='tab']")
  end

  def test_renders_role_only_if_with_panel
    render_inline Primer::Navigation::TabComponent.new(with_panel: true) do |c|
      c.text { "Title" }
    end

    assert_selector("button[role='tab']") do
      assert_selector("span", text: "Title")
    end
  end

  def test_renders_octicon
    render_inline Primer::Navigation::TabComponent.new do |c|
      c.icon(icon: :star)
    end

    assert_selector(".octicon.octicon-star")
  end

  def test_renders_counter
    render_inline Primer::Navigation::TabComponent.new do |c|
      c.counter(count: 10)
    end

    assert_selector(".Counter", text: 10)
  end

  def test_full_component
    render_inline Primer::Navigation::TabComponent.new do |c|
      c.text { "Title" }
      c.icon(icon: :star)
      c.counter(count: 10)
    end

    assert_selector("span", text: "Title")
    assert_selector(".octicon.octicon-star")
    assert_selector(".Counter", text: 10)
  end

  def test_renders_custom_content
    render_inline Primer::Navigation::TabComponent.new do
      "Custom content"
    end

    assert_text("Custom content")
  end

  def test_does_not_render_custom_content_if_slots_are_used
    render_inline Primer::Navigation::TabComponent.new do |c|
      c.text { "Title" }
      "Custom content"
    end

    refute_text("Custom content")
  end

  def test_renders_as_button_if_has_panel
    render_inline Primer::Navigation::TabComponent.new(with_panel: true) do |c|
      c.text { "Title" }
    end

    assert_selector("button[role='tab'][type='button']") do
      assert_selector("span", text: "Title")
    end
  end

  def test_renders_aria_current_if_link_and_selected
    render_inline Primer::Navigation::TabComponent.new(selected: true) do |c|
      c.text { "Title" }
    end

    assert_selector("a[aria-current='page']") do
      assert_selector("span", text: "Title")
    end
    refute_selector("a[role='tab']")
  end

  def test_renders_aria_selected_if_button_and_selected
    render_inline Primer::Navigation::TabComponent.new(selected: true, with_panel: true) do |c|
      c.text { "Title" }
    end

    assert_selector("button[role='tab'][type='button'][aria-selected='true']") do
      assert_selector("span", text: "Title")
    end
  end

  def test_renders_icon_with_classes
    render_inline Primer::Navigation::TabComponent.new(icon_classes: "custom-class") do |c|
      c.icon(icon: :star)
    end

    assert_selector(".custom-class.octicon.octicon-star")
  end

  def test_renders_inside_list
    render_inline Primer::Navigation::TabComponent.new(list: true) do |c|
      c.text { "Title" }
    end

    assert_selector("li.d-flex") do
      assert_selector("a") do
        assert_selector("span", text: "Title")
      end
    end
    refute_selector("a[role='tab']")
  end
end
