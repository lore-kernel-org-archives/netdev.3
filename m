Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9427E06C;
	Thu, 29 Jan 2026 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681915; cv=none; b=lln02GwpB8t2VeDB0xaqs1D4S5q2egUGQ36/dfPgSIXGEm1iRo2P6bAIdXXMQonGIasEfPK/PygLkF9NN1c+wh/DS3Q0QNXQmgzodhXcCWMT39LFf6dJ+fWUYcHJL0PNGnehQSDrjdURxMn+qXu01ZoJ1rhYNs+7F59/RMsPstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681915; c=relaxed/simple;
	bh=T3K7BsW/Rl4mSAgzOey2w/umeu5JGQIl3iB/xf9eI40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suFsCBGbZ3rVpRoFGZzC0fxnM2x8OWWaxEnIu849BLoIGqs+3TMz3Ehk0uGBsQl8P0FYWgqSR0KSE/EitJ3ojV1h13MSHhUV95t+E0zF1JdkqxtTb1DrD+OQeTOfZevG3ZwZAIHkv2kRR2mNetrKWuxT0AW59jVL4vJ2zKsCG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E2x31sOl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E2x31sOl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 779CC1A2AF6;
	Thu, 29 Jan 2026 10:18:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45119606B6;
	Thu, 29 Jan 2026 10:18:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 346DB119A881F;
	Thu, 29 Jan 2026 11:18:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769681905; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TbJMEGZwcFNnfaRsspvH0dL23B5b+uOLCsi4lQI3lk4=;
	b=E2x31sOlP+YaFA2YW+Uhv2SQ0HopGl1KB9INEEV+7v5yeIMI3eQzME/0RPK/Z7+WI4uv0A
	mvjytgurXu8mBulPntbWyu1ToBEA750Pqh1jsXVVuYM9NATXxpnUEZO890lDA4leTxDYmG
	Tl8WUK8mkvgfcIxmA6r6OuhYYmGw/wcPlNL2EvJ+ez+3JLcNU9E7425zRO5feDxiCG/Wsk
	cld5vsBwUHYophiOaY57oHWbZynE4x/C50dUTPPi4KouzK6ZtwN/nCjNYYJkpRjKQsW4LL
	fFYS0uTHpI7OXoTq1NYvypQRtGFNdCo751+ObGerBT2sWt/njNjBx3YMPrGQdg==
Message-ID: <7c37c518-fb6d-4f78-8e83-663e2518e5fd@bootlin.com>
Date: Thu, 29 Jan 2026 11:18:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: add device link between MAC device and MDIO
 device
To: Wei Fang <wei.fang@nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "andrew@lunn.ch" <andrew@lunn.ch>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>,
 "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
 "xiaolei.wang" <xiaolei.wang@windriver.com>,
 "quic_abchauha@quicinc.com" <quic_abchauha@quicinc.com>,
 "quic_sarohasa@quicinc.com" <quic_sarohasa@quicinc.com>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
 <7df10272-a06b-4509-ab8a-519d43944424@bootlin.com>
 <PAXPR04MB85100B7C2C6738CEA80C3C7D889EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <PAXPR04MB85100B7C2C6738CEA80C3C7D889EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 29/01/2026 11:00, Wei Fang wrote:
>>> @@ -1768,12 +1768,21 @@ int phy_attach_direct(struct net_device *dev,
>> struct phy_device *phydev,
>>>
>>>  	/**
>>>  	 * If the external phy used by current mac interface is managed by
>>> -	 * another mac interface, so we should create a device link between
>>> -	 * phy dev and mac dev.
>>> +	 * another MDIO controller, which means that the MAC and MDIO are
>>> +	 * separated devices, then we should create a device link between
>>> +	 * the MAC device and the MDIO device.
>>>  	 */
>>
>> I was confused by the use of the "MDIO device" terminology here, which
>> refers to a device sitting on an mdio bus, such as a PHY. I think though
>> that what you actually refer to is the MDIO controller itself, right ?
> 
> Yes, you are right, I was referring to the MDIO controller.
> 
>>
>>> -	if (dev && phydev->mdio.bus->parent && dev->dev.parent !=
>> phydev->mdio.bus->parent)
>>> -		phydev->devlink = device_link_add(dev->dev.parent,
>> &phydev->mdio.dev,
>>> -						  DL_FLAG_PM_RUNTIME |
>> DL_FLAG_STATELESS);
>>> +	if (dev && phydev->mdio.bus->parent &&
>>> +	    dev->dev.parent != phydev->mdio.bus->parent) {
>>> +		if (!device_link_add(dev->dev.parent, phydev->mdio.bus->parent,
>>> +				     DL_FLAG_PM_RUNTIME |
>>> +				     DL_FLAG_AUTOREMOVE_SUPPLIER)) {
>>
>> Don't we have the same problem with SFP ? The struct mii_bus for SFP
>> PHYs also completely disappears when you remove the module.
> 
> Sorry, I'm not familiar with SFP and I do not have a board with SPF
> module. So I'm not sure whether the MDIO bus will be removed if
> the SFP module is unplugged. But if the multiple SPF modules share
> the same MDIO controller, unplugging one SFP module will cause the
> MDIO bus to be removed. Won't this cause the other SFP modules to
> stop working?

For SFP, it's not a physical mdiobus that connects to the SFP module, but
rather an i2c bus. When the module is inserted, we create an mdiobus that
will perform the mdio transfers over i2c :

https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/net/mdio/mdio-i2c.c#L461

The mdio bus is created when the SFP module is inserted, and we found a
PHY device in it :

https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/net/phy/sfp.c#L791

It is dynamically created and destroyed, its lifetime isn't correlated to
the netdevice.

> 
>>
>> That being said, I ran some tests with SFP and this patch, and the
>> netdev actually didn't dissapear under my feet.
>>
>> I'm a total noob with fw_devlink, but I can see there seems to already
>> be a link between MAC devices and the associated SFP bus :
>>
>> on cyclone V :
>>
>> # ls /sys/class/devlink
>>  [...]
>> platform:sfp--platform:ff702000.ethernet
>>
>> on macchiatobin :
>>
>> # ls /sys/class/devlink
>>  [...]
>> platform:sfp-eth3--platform:f4000000.ethernet
>>
>> So I guess this is what's preventing the netdev from going away.
>>
>> Now, these seems to be automagically populated based on DT, but I don't
>> know if it also works with non-DT platforms. If this is DT-specific,
>> then I guess we still can't use DL_FLAG_AUTOREMOVE_SUPPLIER.
>>
> 
> Previously, when Sorash attempted to add
> DL_FLAG_AUTOREMOVE_SUPPLIER to the devlink between the MAC
> controller and the PHY, you reported that unplugging the PHY would
> cause the MAC to be removed as well, resulting in system hangs.
> 
> https://lore.kernel.org/imx/20250704142138.3f1a4ec1@fedora.home/
> 
> If your guess is correct, removing the SPF module will cause the
> MDIO bus to be removed, then I think the MAC driver should also
> be removed. Therefore, based on this patch, you should be able
> to reproduce the same problem caused by the Sorash's patch.
> However, your current results seem different from before. Perhaps
> the MDIO bus was not removed along with the SFP module.
> 
It is removed :

https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/net/phy/sfp.c#L2648

This line above is called when we unplug the SFP module.

What I am seeing is that there are other devlink links that apply to
the net_device, unrelated to the MDIO bus, at least on the devices I am 
testing this on, and they prevent the net_device from going away.

One of these devlinks is a link between the sfp cage (compatible "sff,sfp") and
the netdev. This devlink seems to be automatically populated when OF is
parsed.

To solve this, I think we need something more granular that this approach,
and make a distinction between when it's OK for a phy_device to dissapear
when attached to a MAC (SFP phys), and when it's not (PHYs hardwired to
the MAC).

Adding this devlink in phy_attach_direct() is too generic IMO. It's likely
that this link should be populated by phylink then.

Maxime

