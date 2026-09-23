Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086DEEB3;
	Wed, 23 Sep 2026 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130367; cv=none; b=gaskuEljKmRrSaMF1M27+F9LRq4fKZ65JQZfQfenKrgLYzUW5HtgmKKR3iRU8fTaDkHXbg84JkuKzGwovKMmrYZK4N+2zEBdato4U/VchVrIMfag+TfLsohAZEfhncfOljdqOY4PDZJXLrlxBOHJ0bn+wUZ3RPKSxSRXqBdWUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130367; c=relaxed/simple;
	bh=tCl4HUPVZ2Hu7QmAeAwQZyr8ueuNKLJA7PzKLTrGl0c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VzkUEvRr7bIArPj88fI3UgPRTHW2mQPM1b1y+ZfDL5zbg7hiTbbkglo4S9aBoZL5/cbYosAWNj0eob5flriLju/UKNZnwtheesV7cQEYDMwRrJ3BcDOhmyEOpx9j7vhnhI0184nmYyZNENqi9//WPqPaFOxCT91srSGGswAsQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ8nbXxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ8nbXxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E8A1F000FF;
	Wed, 23 Sep 2026 02:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790130365;
	bh=fSfHxB6vtn6N4sw+fJbEZmatPa++7pwxwtbQq2xMMQg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OZ8nbXxL+s3z2JtDSfX9yWM/rL1oSitb+r6jcbmJNh8zbru1953wsfNNeppWgLSk/
	 9Jf9ZiQQzW8aZKxjzedu2pm309XbfJSHZ5WRcu/bZ4Wn18CHiZjnn70tUJDAxZ6GPx
	 iSjndVHG8Z4h8/2vD3NH8KQuGQcFCExvPV2W2S/aTKo/HsCk0T/NlS3U6S9hf1nHAH
	 qa3RLyQ4qKmOO+bEkI46Wdy5Rfjo9MRWWyL43fq7izhjI6RaGqUXqh53UM4ZXliyLL
	 RC0ydICFztDqiH1DlKT+wLv8s0AAq9G0dsGxKNU5HlVmhVjjCi099EwRPBuGN8jWWd
	 qoEI+70jThDfQ==
Subject: Re: [PATCH net v9 1/4] net: usb: lan78xx: register the PHY interrupt
 with the MDIO bus
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 02:26:04 +0000
Message-ID: <179013036452.2160803.9091592272745855906@kernel.org>
In-Reply-To: <20260919015326.499479-2-f@lex.la>
References: <20260919015326.499479-2-f@lex.la>
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

- [Medium] Commit message hides a user-visible precedence inversion and
  is factually wrong about it.

--

net: usb: lan78xx: register the PHY interrupt with the MDIO bus

The driver's mapped PHY interrupt number is now written into every entry of
mdiobus->irq[] in lan78xx_mdio_init() before of_mdiobus_register(), and the
later assignment to phydev->irq in lan78xx_phy_init() is removed so that
phy_device_create() seeds the number from the bus table instead.

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index cb782d81d84f..d7472d894c8d 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2092,6 +2092,7 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
>  {
>  	struct device_node *node;
>  	int ret;
> +	int i;
>  
>  	dev->mdiobus = mdiobus_alloc();
>  	if (!dev->mdiobus) {
> @@ -2118,6 +2119,10 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
>  		break;
>  	}
>  
> +	if (dev->domain_data.phyirq > 0)
> +		for (i = 0; i < PHY_MAX_ADDR; i++)
> +			dev->mdiobus->irq[i] = dev->domain_data.phyirq;
> +
>  	node = of_get_child_by_name(dev->udev->dev.of_node, "mdio");
>  	ret = of_mdiobus_register(dev->mdiobus, node);
>  	of_node_put(node);

[ ... ]

> @@ -2892,13 +2897,6 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  		return 0;
>  	}
>  
> -	/* if phyirq is not set, use polling mode in phylib */
> -	if (dev->domain_data.phyirq > 0)
> -		phydev->irq = dev->domain_data.phyirq;
> -	else
> -		phydev->irq = PHY_POLL;
> -	netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);
> -
>  	ret = phylink_connect_phy(dev->phylink, phydev);

[Severity: Medium]
Does moving the number into mdiobus->irq[] change which value ends up in
phydev->irq for LAN7800/LAN7850?

Before this patch the assignment above ran after of_mdiobus_register() had
created and probed the PHY, so the driver's number was written last. Now
the number is present at scan time, and phy_probe() runs after it:

drivers/net/phy/phy_device.c:phy_probe() {
	...
	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;
	...
}

The lan88xx entry in drivers/net/phy/microchip.c deliberately defines no
interrupt callbacks:

	/* Interrupt handling is broken, do not define related
	 * functions to force polling.
	 */

So for the internal PHY at address 1 (phy_mask = ~(1 << 1)) phydev->irq is
seeded from the table, phy_probe() sees a valid interrupt with a driver that
does not support one, and demotes it back to PHY_POLL. The old late write in
lan78xx_phy_init() happened after phy_probe() and defeated that demotion.
Does this move LAN7515 boards such as Raspberry Pi 3B+/4 from the chip's
INT_EP_PHY interrupt to phylib polling?

If so, the post-commit note "Neither in-tree lan78xx PHY node carries an
interrupts property, so nothing in tree changes" does not cover this path,
since the change here comes from phy_probe() rather than from devicetree.

The commit message also says:

	A devicetree PHY node still overrides that.

Is "still" accurate? Previously fwnode_mdiobus_phy_device_register() wrote a
devicetree interrupt into both phy->irq and mdio->irq[addr]:

drivers/net/mdio/fwnode_mdio.c:fwnode_mdiobus_phy_device_register() {
	...
	if (rc > 0) {
		phy->irq = rc;
		mdio->irq[addr] = rc;
	} else {
		phy->irq = mdio->irq[addr];
	}
	...
}

and lan78xx_phy_init() then overwrote phy->irq with the driver's number, so
the devicetree value was discarded. After this patch the devicetree value
wins. That is a precedence inversion rather than unchanged behaviour, so
could the commit body state it directly?

The explanation of all of this currently lives in the notes below the ---
line, which is dropped when the patch is applied. Could the permanent commit
message carry both behaviour changes, and could the "On its own it fixes
nothing" reasoning for omitting a Fixes tag be revisited given that
LAN7800/LAN7850 interrupt handling changes with this patch alone?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919015326.499479-1-f%40lex.la
