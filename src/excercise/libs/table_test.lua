local function createCounterTable()
  return {
    value = 1,
    increment = function (self)
      self.value = self.value + 1
    end
  }
end

local function summer()
  return {
    a = 1,
    b = 2,
    c = 3,
    sum = function (self)
      self.c = self.a + self.b + self.c
    end
  }
end

return {
  counterTable = createCounterTable,
  summer = summer 
}
