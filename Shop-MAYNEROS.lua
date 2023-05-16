local component = require("component")
local event = require("event")
local term = require("term")

-- Создаем таблицу товаров
local store = {
  {name = "Книга", price = 10, quantity = 5},
  {name = "Ручка", price = 2, quantity = 10},
  {name = "Бумага", price = 1, quantity = 20}
}

-- Функция для вывода списка товаров
local function printStore()
  term.clear()
  print("Добро пожаловать в магазин!")
  print("Товары в наличии:")
  print("----------------------------")
  for i, item in ipairs(store) do
    print(i .. ". " .. item.name .. " - Цена: " .. item.price .. " - Количество: " .. item.quantity)
  end
  print("----------------------------")
end

-- Функция для покупки товара
local function buyItem(itemIndex, quantity)
  local item = store[itemIndex]
  if item then
    if item.quantity >= quantity then
      local totalPrice = item.price * quantity
      print("Вы купили " .. quantity .. "x " .. item.name .. " за " .. totalPrice .. " монет.")
      item.quantity = item.quantity - quantity
    else
      print("Извините, недостаточно товара.")
    end
  else
    print("Неверный индекс товара.")
  end
end

-- Основной код
printStore()

while true do
  local _, _, _, key = event.pull("key_down")
  if key == 113 then -- Клавиша Q для выхода из магазина
    term.clear()
    print("Спасибо за покупки!")
    break
  elseif tonumber(key) then
    local itemIndex = tonumber(key)
    term.clear()
    print("Сколько " .. store[itemIndex].name .. " вы хотите купить?")
    local _, _, _, quantity = event.pull("key_down")
    quantity = tonumber(quantity)
    buyItem(itemIndex, quantity)
    printStore()
  else
    printStore()
  end
end
