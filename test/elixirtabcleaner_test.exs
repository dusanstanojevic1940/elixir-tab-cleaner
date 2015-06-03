defmodule CleanTabsTest do
  use ExUnit.Case

  test "clear_tab" do
  	assert {:ok, "  sasa"} == CleanTabs.clear_tab("\tsasa")
    assert {:ok, "sasa  "} == CleanTabs.clear_tab("sasa\t")
    assert {:ok, "  sasa  "} == CleanTabs.clear_tab("\tsasa\t")
    assert :error == CleanTabs.clear_tab("sasa")
  end
end
