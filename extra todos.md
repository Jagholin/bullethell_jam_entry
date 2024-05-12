extra todos:

- move (initial) projectile velocity and direction to the ProjectileSpawner, or may be to another resource(ProjectileSpawnerSettings ?)
	I had some issues creating additional resource scripts. I tried it for the items but then ALL resources stopped working, I was getting "Could not find type in the current scope" for any resource
- see if ItemSettingsResource can be done with some workaround (related to above)
- despawn bullets when they are way outside of the playing field
	I tried, see if the Despawner component makes sense to you
- differentiate between grazes/hits? -> separate collision shapes
	I added a second collision shape child of player to track grazes, the logic to detect that is in the projectiles, not sure if the best place

- sort collision layers
	I saw you had some masks to set collision layers, not sure how you wanted to sort it, I think we need layers for:
		player
		enemies
		player projectiles
		enemy projectiles
		npcs
		powerups
		obstacles
		
		with collisions:
			P	E	PP	EP	N	PW	O
		P				X	X	X	X
		E			X
		PP		Y					X
		EP						Y	X
		N						Y	X
		PW						Y	
		O	Y		Y	Y	Y
		
		
