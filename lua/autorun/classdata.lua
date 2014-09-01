Class = {}

Class[1] = {}
Class[1]["name"] = "Default"
Class[1]["description"] = "This is the default class. No changes are made."
Class[1]["health"] = 100
Class[1]["armor"] = 0
Class[1]["stamina"] = 20
Class[1]["walkspeedmul"] = 1
Class[1]["runspeedmul"] = 1
Class[1]["jumpmul"] = 1
Class[1]["crouchmul"] = 1
Class[1]["fallmul"] = 1
Class[1]["perks"] = {"none"}
Class[1]["color"] = Color(255,255,255,255)
Class[1]["icon"] = "models/Kleiner.mdl"

Class[2] = {}
Class[2]["name"] = "Juggernaut"
Class[2]["description"] = "Juggernauts are equipped with heavily plated jackets that has a 60% chance to absorb 1-5 points of damage and general 10% resistance to explosives. Juggernauts cannot be healed."
Class[2]["health"] = 100
Class[2]["armor"] = 100
Class[2]["stamina"] = 7
Class[2]["walkspeedmul"] = 0.5
Class[2]["runspeedmul"] = 0.5
Class[2]["jumpmul"] = 0.75
Class[2]["crouchmul"] = 1
Class[2]["fallmul"] = 3
Class[2]["perks"] = {"Shield","Necro","FlakJacketMinor"}
Class[2]["color"] = Color(200,200,0,255)
Class[2]["icon"] = "models/Combine_Super_Soldier.mdl"

Class[3] = {}
Class[3]["name"] = "Assassin"
Class[3]["description"] = "Assassins use special ammunition that is 300% more lethal when used on areas such as the skull, but it's 50% weaker on all other areas."
Class[3]["health"] = 75
Class[3]["armor"] = 0
Class[3]["stamina"] = 20
Class[3]["walkspeedmul"] = 0.8
Class[3]["runspeedmul"] = 1.1
Class[3]["jumpmul"] = 1
Class[3]["crouchmul"] = 1.35
Class[3]["fallmul"] = 0.5
Class[3]["perks"] = {"HeadshotHunter"}
Class[3]["color"] = Color(50,200,50,255)
Class[3]["icon"] = "models/player/t_leet.mdl"

Class[4] = {}
Class[4]["name"] = "Runner"
Class[4]["description"] = ""
Class[4]["health"] = 75
Class[4]["armor"] = 0
Class[4]["stamina"] = 40
Class[4]["walkspeedmul"] = 1.5
Class[4]["runspeedmul"] = 1.5
Class[4]["jumpmul"] = 2
Class[4]["crouchmul"] = 1
Class[4]["fallmul"] = 0.1
Class[4]["perks"] = {"none"}
Class[4]["color"] = Color(255,100,100,255)
Class[4]["icon"] = "models/player/p2_chell.mdl"

Class[5] = {}
Class[5]["name"] = "Grunt"
Class[5]["description"] = "Grunts are equipped with special Kevlar that absorbs 10% of damage from explosions and protects 15% of all damage done to the body, but not the head."
Class[5]["health"] = 110
Class[5]["armor"] = 15
Class[5]["stamina"] = 30
Class[5]["walkspeedmul"] = 0.95
Class[5]["runspeedmul"] = 0.95
Class[5]["jumpmul"] = 0.95
Class[5]["crouchmul"] = 1
Class[5]["fallmul"] = 0.95
Class[5]["perks"] = {"Kevlar","FlakJacketMinor"}
Class[5]["color"] = Color(0,200,200,255)
Class[5]["icon"] = "models/Combine_Soldier.mdl"

Class[6] = {}
Class[6]["name"] = "Zombie"
Class[6]["description"] = "Zombies gain +1 health and armor every 3 seconds and damage enemies based on distance in a 300 unit radius due to their superbacterial flesh. Zombies are also 200% weaker to headshots but 10% resistant to everywhere else. Zombies cannot heal."
Class[6]["health"] = 60
Class[6]["armor"] = 60
Class[6]["stamina"] = 15
Class[6]["walkspeedmul"] = 0.75
Class[6]["runspeedmul"] = 0.75
Class[6]["jumpmul"] = 0.75
Class[6]["crouchmul"] = 1
Class[6]["fallmul"] = 1.25
Class[6]["perks"] = {"DeadLife","BrainDamage","ArcLight","Necro"}
Class[6]["color"] = Color(180,125,125,255)
Class[6]["icon"] = "models/Zombie/Classic.mdl"

Class[7] = {}
Class[7]["name"] = "Vampire"
Class[7]["description"] = "Vampires have the lifesteal ability, which steals 10% of the damage done to another player up to 200% health. If a vampire has more health than his or her maxhealth, then it will drain the health 1% every 3 seconds."
Class[7]["health"] = 75
Class[7]["armor"] = 0
Class[7]["stamina"] = 25
Class[7]["walkspeedmul"] = 1.1
Class[7]["runspeedmul"] = 1.1
Class[7]["jumpmul"] = 1.1
Class[7]["crouchmul"] = 1
Class[7]["fallmul"] = 0.9
Class[7]["perks"] = {"LifeSteal","DoubleJump"}
Class[7]["color"] = Color(200,0,0,255)
Class[7]["icon"] = "models/Humans/Group01/Male_Cheaple.mdl"

Class[8] = {}
Class[8]["name"] = "Soul Catcher"
Class[8]["description"] = "Soul Catchers trade life energy escaped from enemy wounds for bonus movespeed and armor. For every 20 points of damage, 1% point of armor is added."
Class[8]["health"] = 90
Class[8]["armor"] = 0
Class[8]["stamina"] = 15
Class[8]["walkspeedmul"] = 1
Class[8]["runspeedmul"] = 1
Class[8]["jumpmul"] = 1
Class[8]["crouchmul"] = 1
Class[8]["fallmul"] = 0.9
Class[8]["perks"] = {"SoulAbsorb"}
Class[8]["color"] = Color(150,0,150,255)
Class[8]["icon"] = "models/player/skeleton.mdl"

Class[9] = {}
Class[9]["name"] = "Void"
Class[9]["description"] = "Voids reflect 10% of damage done to them at the cost of 25% less base damage. Voids cannot relfect damage done by other methods of damage reflection. Voids cannot be healed."
Class[9]["health"] = 100
Class[9]["armor"] = 0
Class[9]["stamina"] = 15
Class[9]["walkspeedmul"] = 0.9
Class[9]["runspeedmul"] = 0.9
Class[9]["jumpmul"] = 1
Class[9]["crouchmul"] = 1
Class[9]["fallmul"] = 0
Class[9]["perks"] = {"ReflectDamage", "Necro"}
Class[9]["color"] = Color(200,200,200,255)
Class[9]["icon"] = "models/Zombie/Poison.mdl"

Class[10] = {}
Class[10]["name"] = "Phantom"
Class[10]["description"] = "Phantoms have a 10% chance to completely dodge an attack. Phantoms cannot be healed."
Class[10]["health"] = 75
Class[10]["armor"] = 25
Class[10]["stamina"] = 25
Class[10]["walkspeedmul"] = 1
Class[10]["runspeedmul"] = 1.1
Class[10]["jumpmul"] = 1.1
Class[10]["crouchmul"] = 1
Class[10]["fallmul"] = 0
Class[10]["perks"] = {"Evasion","Necro"}
Class[10]["color"] = Color(200,200,225,255)
Class[10]["icon"] = "models/player/corpse1.mdl"

Class[11] = {}
Class[11]["name"] = "Field Medic"
Class[11]["description"] = "Field Medics slow restore all health to himself and to nearby allies on his team."
Class[11]["health"] = 110
Class[11]["armor"] = 0
Class[11]["stamina"] = 20
Class[11]["walkspeedmul"] = 0.90
Class[11]["runspeedmul"] = 1.1
Class[11]["jumpmul"] = 1
Class[11]["crouchmul"] = 1
Class[11]["fallmul"] = 1
Class[11]["perks"] = {"Medic"}
Class[11]["color"] = Color(255,10,10,255)
Class[11]["icon"] = "models/Characters/Hostage_01.mdl"

Class[12] = {}
Class[12]["name"] = "Bomb Squad Soldier"
Class[12]["description"] = "These soldiers have special armor that absorbs 25% of all explosive damage. There is a 15% chance to reflect every point of explosive damage past 50 to it's attacker."
Class[12]["health"] = 100
Class[12]["armor"] = 30
Class[12]["stamina"] = 10
Class[12]["walkspeedmul"] = 0.7
Class[12]["runspeedmul"] = 0.7
Class[12]["jumpmul"] = 1
Class[12]["crouchmul"] = 1
Class[12]["fallmul"] = 3
Class[12]["perks"] = {"FlakJacketMajor"}
Class[12]["color"] = Color(0,100,100,255)
Class[12]["icon"] = "models/player/ct_gign.mdl"

Class[13] = {}
Class[13]["name"] = "Soldier"
Class[13]["description"] = "Soldiers are equipped with Helmets and Kevlar, which block 15% of body damage and 10% of headshot damage respectively."
Class[13]["health"] = 115
Class[13]["armor"] = 15
Class[13]["stamina"] = 15
Class[13]["walkspeedmul"] = 0.90
Class[13]["runspeedmul"] = 0.90
Class[13]["jumpmul"] = 0.8
Class[13]["crouchmul"] = 0.8
Class[13]["fallmul"] = 1.2
Class[13]["perks"] = {"Kevlar","Helmet"}
Class[13]["color"] = Color(150,100,0,255)
Class[13]["icon"] = "models/player/ct_gsg9.mdl"

Class[14] = {}
Class[14]["name"] = "Shredder"
Class[14]["description"] = "10% of damage dealt to an enemy transfers to other enemies in a 1000 radius area."
Class[14]["health"] = 80
Class[14]["armor"] = 10
Class[14]["stamina"] = 15
Class[14]["walkspeedmul"] = 0.85
Class[14]["runspeedmul"] = 0.85
Class[14]["jumpmul"] = 1
Class[14]["crouchmul"] = 1
Class[14]["fallmul"] = 1.1
Class[14]["perks"] = {"Splash"}
Class[14]["color"] = Color(150,200,200,255)
Class[14]["icon"] = "models/player/ct_sas.mdl"

Class[15] = {}
Class[15]["name"] = "Marksman"
Class[15]["description"] = "Gains the ability to grant critical strikes. Critical strikes stun your opponent for 0.25 seconds and do double damage. Crit chance is based on how much base damage you do."
Class[15]["health"] = 100
Class[15]["armor"] = 0
Class[15]["stamina"] = 30
Class[15]["walkspeedmul"] = 0.65
Class[15]["runspeedmul"] = 0.65
Class[15]["jumpmul"] = 1
Class[15]["crouchmul"] = 0.7
Class[15]["fallmul"] = 0.8
Class[15]["perks"] = {"Stunner"}
Class[15]["color"] = Color(255,255,0,255)
Class[15]["icon"] = "models/player/t_guerilla.mdl"

Class[16] = {}
Class[16]["name"] = "Anti-Tank"
Class[16]["description"] = "Turns the enemy against itself by using special armor piercing ammo that does 1% more damage per point of armor. Each attack also steals armor based on 15% of damage dealt, Stacks up to 200 points of armor."
Class[16]["health"] = 75
Class[16]["armor"] = 25
Class[16]["stamina"] = 15
Class[16]["walkspeedmul"] = 0.85
Class[16]["runspeedmul"] = 0.85
Class[16]["jumpmul"] = 1
Class[16]["crouchmul"] = 1
Class[16]["fallmul"] = 1.5
Class[16]["perks"] = {"AP","ArmorSteal"}
Class[16]["color"] = Color(0,100,0,255)
Class[16]["icon"] = "models/barney.mdl"

Class[17] = {}
Class[17]["name"] = "Predator"
Class[17]["description"] = "Gains the cloak ability which drains 1 armor every 3 seconds. Cloak amount is based on movement speed. Each attack also steals armor based on 15% of damage dealt, Stacks up to 200 points of armor."
Class[17]["health"] = 20
Class[17]["armor"] = 40
Class[17]["stamina"] = 30
Class[17]["walkspeedmul"] = 0.75
Class[17]["runspeedmul"] = 1.1
Class[17]["jumpmul"] = 1.25
Class[17]["crouchmul"] = 0.75
Class[17]["fallmul"] = 0.75
Class[17]["perks"] = {"Cloak","ArmorSteal"}
Class[17]["color"] = Color(25,100,200,255)
Class[17]["icon"] = "models/stalker.mdl"

Class[18] = {}
Class[18]["name"] = "Survivor"
Class[18]["description"] = "For every 4 points of health lost, you gain 1% bonus damage. Survivors also regain health slowly over time. Survivors also block 20-50 damage from bullets that hit the back."
Class[18]["health"] = 100
Class[18]["armor"] = 0
Class[18]["stamina"] = 25
Class[18]["walkspeedmul"] = 0.75
Class[18]["runspeedmul"] =0.75
Class[18]["jumpmul"] = 1
Class[18]["crouchmul"] = 1
Class[18]["fallmul"] = 1
Class[18]["perks"] = {"Survivor","LifeRegen","BackDoor"}
Class[18]["color"] = Color(100,100,0,255)
Class[18]["icon"] = "models/monk.mdl"

Class[19] = {}
Class[19]["name"] = "Abandon"
Class[19]["description"] = "Damage dealt to Abandons have a 7% chance to convert damage into health."
Class[19]["health"] = 125
Class[19]["armor"] = 0
Class[19]["stamina"] = 20
Class[19]["walkspeedmul"] = 0.85
Class[19]["runspeedmul"] = 0.85
Class[19]["jumpmul"] = 1
Class[19]["crouchmul"] = 1
Class[19]["fallmul"] = 0
Class[19]["perks"] = {"Reversal"}
Class[19]["color"] = Color(150,100,100,255)
Class[19]["icon"] = "models/player/zombie_fast.mdl"

Class[20] = {}
Class[20]["name"] = "Spirit"
Class[20]["description"] = "Spirits can swap with any random player on the map if the spirit's health is below 50 once every 30 seconds. Spirits cannot be healed."
Class[20]["health"] = 80
Class[20]["armor"] = 20
Class[20]["stamina"] = 15
Class[20]["walkspeedmul"] = 0.90
Class[20]["runspeedmul"] = 0.90
Class[20]["jumpmul"] = 1
Class[20]["crouchmul"] = 1
Class[20]["fallmul"] = 0
Class[20]["perks"] = {"Swap","Necro"}
Class[20]["color"] = Color(200,200,225,255)
Class[20]["icon"] = "models/player/gman_high.mdl"

Class[21] = {}
Class[21]["name"] = "Allah Snackbar"
Class[21]["description"] = "Allah Snackbars are equipped with explosive charges linked with their heartbeat. If their heart is unresponsive, they explode similar to an explosion of a C4 charge. Snackbars also do 10% bonus damage with explosives."
Class[21]["health"] = 100
Class[21]["armor"] = 10
Class[21]["stamina"] = 20
Class[21]["walkspeedmul"] = 0.95
Class[21]["runspeedmul"] = 0.95
Class[21]["jumpmul"] = 1
Class[21]["crouchmul"] = 1
Class[21]["fallmul"] = 1
Class[21]["perks"] = {"Snackbar","Explosive"}
Class[21]["color"] = Color(255,200,225,255)
Class[21]["icon"] = "models/player/t_phoenix.mdl"

Class[22] = {}
Class[22]["name"] = "Blood"
Class[22]["description"] = "Bloods have a 40% chance to inflict bleeding damage that drains health and stamina based on 10% of the damage dealt."
Class[22]["health"] = 100
Class[22]["armor"] = 0
Class[22]["stamina"] = 25
Class[22]["walkspeedmul"] = 1.05
Class[22]["runspeedmul"] = 1.05
Class[22]["jumpmul"] = 1
Class[22]["crouchmul"] = 1
Class[22]["fallmul"] = 1
Class[22]["perks"] = {"Drain"}
Class[22]["color"] = Color(150,0,0,255)
Class[22]["icon"] = "models/vortigaunt.mdl"

Class[23] = {}
Class[23]["name"] = "Spy"
Class[23]["description"] = "Spies can fake their death by creating a holographic corpse while turning invisible. The invisibility lasts until you damage someone. Spies grant a 100% critical strike chance while invisible."
Class[23]["health"] = 50
Class[23]["armor"] = 0
Class[23]["stamina"] = 30
Class[23]["walkspeedmul"] = 1.1
Class[23]["runspeedmul"] = 1.1
Class[23]["jumpmul"] = 1.2
Class[23]["crouchmul"] = 1
Class[23]["fallmul"] = 1
Class[23]["perks"] = {"FakeDeath"}
Class[23]["color"] = Color(200,100,100,255)
Class[23]["icon"] = "models/player/spy.mdl"

Class[24] = {}
Class[24]["name"] = "Leech"
Class[24]["description"] = "Leeches absorb 1 health per person in a 500 unit radius and adds it on to their health up to 200 health."
Class[24]["health"] = 50
Class[24]["armor"] = 0
Class[24]["stamina"] = 15
Class[24]["walkspeedmul"] = 0.9
Class[24]["runspeedmul"] = 0.95
Class[24]["jumpmul"] = 1
Class[24]["crouchmul"] = 1
Class[24]["fallmul"] = 1
Class[24]["perks"] = {"AuraLeech"}
Class[24]["color"] = Color(255,100,100,255)
Class[24]["icon"] = "models/headcrabclassic.mdl"

Class[25] = {}
Class[25]["name"] = "Mystery"
Class[25]["description"] = "Mysteries are difficult to shoot and even kill with their tendencies to confuse attackers who look at them. Mysteries also grant 10% evasion chance. Mysteries cannot heal."
Class[25]["health"] = 40
Class[25]["armor"] = 0
Class[25]["stamina"] = 15
Class[25]["walkspeedmul"] = 1.15
Class[25]["runspeedmul"] = 1.15
Class[25]["jumpmul"] = 1.25
Class[25]["crouchmul"] = 1
Class[25]["fallmul"] = 1
Class[25]["perks"] = {"Mystical","Necro","Evasion"}
Class[25]["color"] = Color(255, 235, 180,255)
Class[25]["icon"] = "models/dog.mdl"

Class[26] = {}
Class[26]["name"] = "NIGGER SLAYER"
Class[26]["description"] = "I am justice incarnate, brought forth to end the lives of those that are wasting breathing air and purge them of their foul presence. I am the NIGGER SLAYER, and you're niggery ends here, now. Drop to your knees and surrender, or you will face a war machine unlike ANY this world has ever seen."
Class[26]["health"] = 300
Class[26]["armor"] = 0
Class[26]["stamina"] = 10
Class[26]["walkspeedmul"] = 0.6
Class[26]["runspeedmul"] = 0.6
Class[26]["jumpmul"] = 1
Class[26]["crouchmul"] = 1
Class[26]["fallmul"] = 3
Class[26]["perks"] = {"Slayer","Necro"}
Class[26]["color"] = Color(255,233,127,255)
Class[26]["icon"] = "models/serioussam/sam_stone_bfe.mdl"

Class[27] = {}
Class[27]["name"] = "Flash the Scatman"
Class[27]["description"] = "Flash's Class. Gain 10% bonus damage at the cost of 20% incoming damage amplification and lost health over time."
Class[27]["health"] = 100
Class[27]["armor"] = 0
Class[27]["stamina"] = 20
Class[27]["walkspeedmul"] = 1.1
Class[27]["runspeedmul"] = 1.1
Class[27]["jumpmul"] = 1.5
Class[27]["crouchmul"] = 1
Class[27]["fallmul"] = 1
Class[27]["perks"] = {"Poop","DamageTrade"}
Class[27]["color"] = Color(127, 111, 63,255)
Class[27]["icon"] = "models/jessev92/player/misc/creepr.mdl"

Class[28] = {}
Class[28]["name"] = "Creed the OP"
Class[28]["description"] = "Creed's Class."
Class[28]["health"] = 100
Class[28]["armor"] = 0
Class[28]["stamina"] = 10
Class[28]["walkspeedmul"] = 1.45
Class[28]["runspeedmul"] = 1.45
Class[28]["jumpmul"] = 1
Class[28]["crouchmul"] = 1
Class[28]["fallmul"] = 3
Class[28]["perks"] = {"Necro"}
Class[28]["color"] = Color(0, 200, 100,255)
Class[28]["icon"] = "models/nikout/carleypm.mdl"






