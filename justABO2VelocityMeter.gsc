#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;			

// Just a velocity meter script for BO2 Zombies
// Copy paste from https://github.com/Fraagaa/Fraga-Bo2

Init()
{	
    level thread OnPlayerConnect();
}

OnPlayerConnect()
{
    for(;;)
    {
        level waittill("connecting", player);
        player thread onPlayerSpawn();
    }
}

onPlayerSpawn()
{

	self endon("disconnect");
	level endon("end_game");
	
    while(1)
    {
		self waittill("spawned_player");
        self thread velocity_meter();
    }
}

velocity_meter(vel)
{
    self endon("disconnect");
    level endon("end_game");

    self.hud_velocity = createfontstring("default" , 1.2);
	self.hud_velocity.hidewheninmenu = 1;
	self.hud_velocity.y = 350;

	self thread velocity_watcher(vel);

    while (true)
    {
		velocity = int(length(self getvelocity() * (1, 1, 0)));
		velocity_meter_scale(velocity, self.hud_velocity);
        self.hud_velocity setValue(velocity);

        wait 0.05;
    }
}

velocity_meter_scale(vel, hud)
{
	hud.color = ( 0.6, 0, 0 );
	hud.glowcolor = ( 0.3, 0, 0 );

	if ( vel < 330 )
	{
		hud.color = ( 0.6, 1, 0.6 );
		hud.glowcolor = ( 0.4, 0.7, 0.4 );
	}

	else if ( vel <= 340 )
	{
		hud.color = ( 0.8, 1, 0.6 );
		hud.glowcolor = ( 0.6, 0.7, 0.4 );
	}

	else if ( vel <= 350 )
	{
		hud.color = ( 1, 1, 0.6 );
		hud.glowcolor = ( 0.7, 0.7, 0.4 );
	}

	else if ( vel <= 360 )
	{
		hud.color = ( 1, 0.8, 0.4 );
		hud.glowcolor = ( 0.7, 0.6, 0.2 );
	}

	else if ( vel <= 370 )
	{
		hud.color = ( 1, 0.6, 0.2 );
		hud.glowcolor = ( 0.7, 0.4, 0.1 );
	}

	else if ( vel <= 380 )
	{
		hud.color = ( 1, 0.2, 0 );
		hud.glowcolor = ( 0.7, 0.1, 0 );
	}
	
	return;
}

velocity_watcher(vel)
{
	self endon("disconnect");
	level endon("end_game");

	while(1)
	{
		while(GetDvarInt("velocity") == 0)
		{
			wait(0.1);
		}

		self.hud_velocity.alpha = 0.75;

		while(GetDvarInt("velocity") >= 1)
		{
			wait(0.1);
		}
		
		self.hud_velocity.alpha = 0;	
	}
}