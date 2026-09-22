Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AE19D8BC;
	Tue, 22 Sep 2026 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044137; cv=none; b=IlUSJp+WxzlDTd+YgK5MliNDWYyO1fgr2s/OVOfz3zxi0VKkY+j79VH9d+MLE0IESePr4SZygWp/2AWiJDk+DGt3+3VN4ftlFmRsmEqF2GTBwTVQSpoHvdqv3gU6AKddVVhOTtN5RLPTM4te2jsFZUgNfDrvEKfkGO/eACComRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044137; c=relaxed/simple;
	bh=kK/Aj1F6iMTrMXpKpc4fmWGXkLXIzxDoESxv6C876kc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvbrT/NOY7bMOXwHvZjr5oVZrO7aaW4ykuryYwfsvS8Tsn5gPmq2Wqzpr0aooeWa+KwXn+MYRYwwAMkyKJiMZltJEDCO/KG/dfLVRomf4gKC4vNqY9V79b/kK3TVcAciyXlRq/mTED8+qyRYxB/dXq9o4KRHi8WJytkj5wy5Ucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxO4pNzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxO4pNzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599BF1F000FF;
	Tue, 22 Sep 2026 02:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790044136;
	bh=9rVJ0/OSdXrtqIbp1Sfa4ag4UMJ8SvJPOvSFZQJF9wo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dxO4pNzVjF5/Ff1BchMs/iJa6bx2Apfrj8K+PVCTaJX+MSlUC8A2WGl2yoyzca0WJ
	 +QJoAC4ttCSVdoYG9CVWnMLRIoBQnEX6AQOrGs2fkPnXotVR2qpCqHdJxMOd2C+rXC
	 PSscKISfo48sGPFXg6cF1mw+0klnN5oyLCz1yWWAwfpfc4hdmk4gbdTRMwST3p9GPf
	 pYZwmT01YSZL/msD88/r6NiKyAH9PT4C/fQyTvFoJ5PFW4UBbUBL/ssGYHGiwGMDcJ
	 YTHLLGl1sE65YBdrCH406QqdWPE83IjO7XwoyktT+K3v63iGBdc3f6o4at2gCQCQFA
	 VK/xWxL8kp+Nw==
Subject: Re: [PATCH net v8 1/4] net: usb: lan78xx: register the PHY interrupt
 with the MDIO bus
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 02:28:54 +0000
Message-ID: <179004413481.2160803.3656796671442512027@kernel.org>
In-Reply-To: <20260918015029.2518425-2-f@lex.la>
References: <20260918015029.2518425-2-f@lex.la>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In lan78xx_phy_init() (drivers/net/usb/lan78xx.c:2895-2898)
  the new store `dev->mdiobus->irq[phydev->mdio.addr] =…

Pre-existing issues:
- [Low] The kernel-doc for lan78xx_get_phy()
  (drivers/net/usb/lan78xx.c:2640-2648) states "If no PHY is found and…

--

net: usb: lan78xx: register the PHY interrupt with the MDIO bus

The patch moves the chip-domain PHY interrupt that lan78xx maps for itself
into the mii_bus IRQ table and then reads phydev->irq back out of that
table, replacing the previous direct assignment to phydev->irq and dropping
the PHY_POLL else branch.

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index cb782d81d84f..d02e4ffcbbc1 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2892,11 +2892,10 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  		return 0;
>  	}
>  
> -	/* if phyirq is not set, use polling mode in phylib */
>  	if (dev->domain_data.phyirq > 0)
> -		phydev->irq = dev->domain_data.phyirq;
> -	else
> -		phydev->irq = PHY_POLL;
> +		dev->mdiobus->irq[phydev->mdio.addr] = dev->domain_data.phyirq;
> +
> +	phydev->irq = dev->mdiobus->irq[phydev->mdio.addr];

[Severity: Medium]
Can this store discard an interrupt that devicetree described for this PHY
address?

lan78xx_mdio_init() registers the bus through OF:

	node = of_get_child_by_name(dev->udev->dev.of_node, "mdio");
	ret = of_mdiobus_register(dev->mdiobus, node);

and for a PHY child with an interrupts property the MDIO core records the
firmware interrupt in both places, in fwnode_mdiobus_phy_device_register():

	if (rc > 0) {
		phy->irq = rc;
		mdio->irq[addr] = rc;
	} else {
		phy->irq = mdio->irq[addr];
	}

lan78xx_phy_init() then writes dev->domain_data.phyirq over that slot. Is
the guard dev->domain_data.phyirq > 0 ever false here? lan78xx_setup_irq_domain()
returns -EINVAL when the mapping cannot be created and lan78xx_bind() gives
up on that return, which the commit message itself notes, so the store looks
unconditional in practice and the devicetree value is gone from the table
with no way to get it back.

The interrupt being written is the chip-internal virq driven from the
LAN78xx endpoint status bit in intr_complete():

	if (intdata & INT_ENP_PHY_INT) {
		...
		if (dev->domain_data.phyirq > 0)
			generic_handle_irq_safe(dev->domain_data.phyirq);

On LAN7801 with an external RGMII PHY whose nINT line is wired to the host
and described in devicetree, that is a different source from the line the
table held. Does this leave the table unable to distinguish "firmware
described an interrupt" from "driver's own chip-domain virq"?

That distinction is what the later patches in the series depend on: with
"net: phy: take the interrupt back from the bus on detach" and "net: phy:
restore the interrupt when the generic bind cycle fails" applied,
phy_detach() and the failed-bind path read bus->irq[addr] back, so from
there on they hand the chip-internal virq to phydev->irq rather than the
devicetree line.

There is also a mismatch with the changelog, which justifies deleting the
else branch this way:

  "this bus is registered with of_mdiobus_register(), so the table may
  already hold an interrupt the devicetree described, and forcing PHY_POLL
  over it would invert what patches 3 and 4 are for"

Does the line immediately above it perform that same inversion for a real
devicetree interrupt, only losing the original value instead of masking it?

Would it work to seed the table only when it still reads PHY_POLL, or to
state the precedence between the devicetree line and the chip-domain virq
explicitly in this patch?

>  	netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);
>  
>  	ret = phylink_connect_phy(dev->phylink, phydev);

[Severity: Low]
This isn't a bug introduced by this patch, but the kernel-doc above
lan78xx_get_phy() does not match what the function does, and the mismatch
touches the code being changed here. It says:

  * This function attempts to find a PHY on the MDIO bus. If no PHY is found
  * and the chip is LAN7801, it registers a fixed PHY as fallback. It also
  * sets dev->interface based on chip ID and detected PHY type.
  *
  * Return: a valid PHY device pointer, or ERR_PTR() on failure.

No fixed PHY device is registered there, and the ID_REV_CHIP_ID_7801_ case
returns plain NULL:

	dev->interface = PHY_INTERFACE_MODE_RGMII;
	/* No PHY found – fallback to fixed PHY (e.g. KSZ switch board) */
	return NULL;

The fixed link is configured later by phylink_set_fixed_link() in
lan78xx_set_fixed_link(). The undocumented NULL return is what the
if (!phydev) early return in lan78xx_phy_init() keys off, and that early
return is what keeps the new phydev->mdio.addr accesses safe. Could the
kernel-doc be updated to mention the NULL return and drop the fixed PHY
registration claim?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918015029.2518425-1-f%40lex.la
