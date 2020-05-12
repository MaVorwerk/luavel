CharacterController = BaseModelController:create()
require("models.Character")


function CharacterController:new(realm, name, class)
    local character = Character:create()
    if(character ~= nil) then
        character.map(character,'realm', realm)
        character.map(character,'name', name)
        character.map(character,'class', class)
        character.save(character)
    end
    return character
end