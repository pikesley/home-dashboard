Given /^I accept CSV$/ do
  add_headers(
    {
      'Accept' => 'text/csv'
    }
  )
end
