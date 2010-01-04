# upload an attrachment (from features/assets folder)
When /^I attach the file "([^\"]*)" to "([^\"]*)"$/ do |filename, field|
  When %{I attach the file at "#{File.join(RAILS_ROOT, "features", "assets", filename)}" to "#{field}"}
end

# example:
# Then the "vote_for_count" of the idea which content is "read some jokes" should be 1
# Then the "vote.count" of the idea which content is "read some jokes" should be 1
Then /^the "([^\"]*)" of the (\w+) which (.+) is "([^\"]*)" should (not )?be (.+)$/ do |attr_name, model, attr, value, is_not, expected|
  model = model.classify.constantize
  model.should_not be_nil
  record = model.first(:conditions => {attr.to_sym => value})
  record.should_not be_nil
  result = attr_name.split(".").inject(record) { |result, attr| result = result.send(attr) }
  if /(blank|false|true)/ =~ expected
    result.send((is_not ? :should_not : :should),  send("be_#{$1}".to_sym))
  else
    unless /^\d+$/ =~ expected
      expected = expected.scan(/^"(.*)"$/).first.to_s
    end
    result = result.to_s
    if is_not
      result.should_not  == expected
    else
      result.should == expected
    end
  end
end