function table_contains(tab,elem)
	for _,v in pairs(tab) do
		if v == elem then
			return true
		elseif type(v) == "table" then
			if table_contains(v,elem) then
				return true
			end
		end
	end
	return false
end