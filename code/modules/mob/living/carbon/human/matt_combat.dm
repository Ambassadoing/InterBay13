//Commented out debugging shit.
/*
/mob/living/carbon/human/verb/toggle_combat_mode()
	set name = "Toggle Combat Mode"
	set category = "Combat"

	if(combat_mode)
		combat_mode = 0
		to_chat(src, "You toggle off combat mode.")
	else
		combat_mode = 1
		to_chat(src, "You toggle on combat mode.")

/mob/living/carbon/human/verb/toggle_dodge_parry()
	set name = "Toggle Defense Intent"
	set category = "Combat"

	if(defense_intent == I_DODGE)
		defense_intent = I_PARRY
		to_chat(src, "You will now parry.")
	else
		defense_intent = I_DODGE
		to_chat(src, "You will now dodge.")
*/

//Going here till I find a better place for it.
/mob/living/proc/handle_combat_mode()//Makes it so that you can't regain stamina in combat mode.
	if(combat_mode)
		if(staminaloss < 25)
			adjustStaminaLoss(1)

/mob/living/proc/attempt_dodge()//Handle parry is an object proc and it's, its own thing.
	if(combat_mode && (defense_intent == I_DODGE) && !lying)//Todo, make use of the check_shield_arc proc to make sure you can't dodge from behind.
		if(staminaloss < 50 && statscheck(dex, 20))//You gotta be the master of dexterity to dodge every time. 
			do_dodge()
			return	1
		else if(staminaloss >= 50 && prob(10))
			do_dodge()
			return	1

/mob/living/proc/do_dodge()
	var/lol = pick(cardinal)//get a direction.
	adjustStaminaLoss(15)//add some stamina loss
	playsound(loc, 'sound/weapons/punchmiss.ogg', 80, 1)//play a sound
	step(src,lol)//move them
	visible_message("<b><big>[src.name] dodges out of the way!!</big></b>")//send a message
	//be on our way


/mob/proc/surrender()//Surrending. I need to put this in a different file.
	if(!incapacitated())
		Stun(5)
		Weaken(5)
		visible_message("<b>[src] surrenders!</b>")
		playsound(src, 'sound/effects/surrender.ogg', 50, 1)