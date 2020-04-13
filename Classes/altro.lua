abc = function () table = {1,2,3} return table end

local success, ErrorStatement = pcall( abc )
while not success do
  print("Error: "..ErrorStatement)
  wait() --or a specific time
  success, ErrorStatement = pcall( abc )
end

print(success)
print(abc)
print(ErrorStatement)
print(ErrorStatement[1])