require("models.BaseModel")

BaseModelController = {}
BaseModelController.__index = BaseModelController

function BaseModelController:create()
    local bmController = {}
    setmetatable(bmController,BaseModelController)
    return bmController
end

function BaseModelController:test()
    local baseModel = BaseModel:create()
    local _table = baseModel.getAll(baseModel)

    for key, value in pairs(_table) do
        print('Name: '..value.name)
    end
end

function BaseModelController:new()

end