Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51047884C;
	Fri, 25 Sep 2026 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326024; cv=none; b=I7RVbaNqiAuSRiXffE0VoUZAQfWzNW6BSk++TllDVq/OSLv0S5zyFvTs9c68o+igZKAooEnlVlTMEEKLYUiZnEeYAj39sDR5fy/QY+lbdYVaTdBfV3quOwV+QfuprZMaXvJ7TUFittADh9mxXWayTry5VNAfm3e8N6cZFlSlMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326024; c=relaxed/simple;
	bh=2LvxzzRXqp8MdpE8YrYgXq5fg4BBSAot6myOWNUgFfo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tiroh7Tz45I6m5/XCUr2e6LsB2fi8WUHjXg3begR4JgweUVgHtWNhba9AUvFHseIeOwExG8mWbA8qKeC7xRGaxARA+4RpJCiZXIdeFURzPuThpYQC0sdsBB/bjtu9Yt7UBq48v3b4RoVz2CP9K/lf411sWul9+jJwv+MMvQ25tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYa8wkzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYa8wkzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E521F000FF;
	Fri, 25 Sep 2026 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790326013;
	bh=s4KLH1XDvIcrleuQ3ZvtPkbxw3Pbs8GDDA15S/4Qk10=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EYa8wkzddjCn6sRYib1rycU4bD0H/Ky5P0F+3pCKWO3aOhi66oFk+Gz0UJCxKuwwi
	 965sByk794Lm8Xzx/olHM8fyP8+2kbNQpw3DUH7/91cZA7pWsA19xB9Frd1/i+h8w3
	 lWQGc6eiRt9dO9NTLLoItrh3RDPmO6iYAI7vezDlO6MUhw0x+ccuXPVaVeMwJ/8Mic
	 ElbjXODVI5E21rY0/HDQAIEtfBsRT8NcOhL0ayVZpMpxSRjWR7L9W3KM1oFxfMNdNF
	 Ms2hBm18HrPR0QX7XkHWM1GilPON8aMPvouZvJm8FhFhi9x404VcmTQq4C8wzY66a7
	 leBn15QA+B9qw==
Subject: Re: [PATCH net-next v2] net: phy: marvell: add support for PHY LEDs
 polarity modes
From: netdev-bot+sashiko@kernel.org
To: olek2@wp.pl
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 08:46:52 +0000
Message-ID: <179032601295.2160803.13373677668767022640@kernel.org>
In-Reply-To: <20260923204614.471409-1-olek2@wp.pl>
References: <20260923204614.471409-1-olek2@wp.pl>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The polarity and tristate settings written to page 3 reg 17
  (MII_88E1318S_PHY_LED_POL) are programmed only once.

--

net: phy: marvell: add support for PHY LEDs polarity modes

This commit adds a led_polarity_set callback for the 88E1318 and 88E1510
PHYs. The callback programs the per-LED active-high and high-impedance
bits in page 3, register 0x11.

> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index f71cffa884062..d57fcabfec2b9 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c

[ ... ]

> @@ -3585,6 +3590,36 @@ static int m88e1318_led_hw_control_get(struct phy_device *phydev, u8 index,
>  	return marvell_get_led_rules(index, rules, mode);
>  }
>  
> +static int m88e1318_led_polarity_set(struct phy_device *phydev, int index,
> +				     unsigned long modes)
> +{

[ ... ]

> +	return phy_modify_paged(phydev, MII_MARVELL_LED_PAGE,
> +				MII_88E1318S_PHY_LED_POL,
> +				MII_88E1318S_PHY_LED_POL_ACT_HIGH(index) |
> +				MII_88E1318S_PHY_LED_POL_HIGH_IMP(index), val);
> +}

[Severity: Medium]
Can the polarity and high-impedance settings be lost after the PHY goes
through a hardware reset?

The register is only written once, from probe:

phy_probe()
  of_phy_leds()
    of_phy_led()
      m88e1318_led_polarity_set()

The requested modes are not saved in struct marvell_priv. Neither
m88e1318_config_init() nor m88e1510_config_init() (through
marvell_config_init()) rewrites MII_88E1318S_PHY_LED_POL.

phy_detach() puts the PHY into reset:

drivers/net/phy/phy_device.c:phy_detach() {
    ...
	/* Assert the reset signal */
	phy_device_reset(phydev, 1);
    ...
}

On the next attach, phy_attach_direct()->phy_init_hw() releases reset and
runs config_init, but of_phy_leds() is not called again.

Take a board with a PHY reset GPIO and a MAC driver that connects the PHY
in ndo_open and disconnects it in ndo_stop. Wouldn't each "ip link set
down" followed by "ip link set up" put the LED pins back to their reset
default polarity and drive state?

The same thing looks possible after resume if the PHY lost power, via
mdio_bus_phy_resume()->phy_init_hw().

qca808x avoids this. It keeps led_polarity_mode in its priv structure and
reapplies it from qca808x_config_init(). Would a similar approach work
here, with the per-LED modes saved in marvell_priv and restored from
config_init?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923204614.471409-1-olek2%40wp.pl
