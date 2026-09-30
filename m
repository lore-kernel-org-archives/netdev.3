Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29131FDA61;
	Wed, 30 Sep 2026 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729903; cv=none; b=gyJJF1RTf72Y1byprjTcTA+pREJZAtV9JojZv8yg8ynJhyk/LR7M/U7mhLHT8oBHORoCNc5Ft8DRVUYZeebiSkSspimVyGRbQtvPS6xWoBVmWl6VUQPwGWPDjxLtM8eEv3dM4a1BjBcRVw2rXcg1lZ+hjYRrpdkVt2kEBZcpPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729903; c=relaxed/simple;
	bh=bNHbQLa+QfRKlmbmlogY5TgmBZuHeIO+HTeCl1q4Dog=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0ZnkcrRQfzbxmwulWI16ba+oU1jr/YeffgWdC38D3GN34x8Z5dKuuVWcLQSeOQjpbl/TfKcCIxq5+bm7JnVP5+7eU3vrewl83ejrhK+IGeAjWVQBDwMA1sved0k8gqow2rA1wNOPS5QAxiHGA0VeU0VDMK0H9GjcUeh/F5gVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P49GxNSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P49GxNSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9991F000FF;
	Wed, 30 Sep 2026 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729901;
	bh=EacJv7PBqlrYdnma8V09fiIDWiRVgyAoQyfIR9WxXfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P49GxNSulMT4US0DXBzume2TkF/7Jsr4oFCNtW+wd4/KWNq+xSJZyLyh6NqlDM3i1
	 U8Nd7Zrj9a0X6j6oPLtkpSzRNXoCpKYmtxvDkaxYI3UNrdcooP6NS+bXBZbpk8Yo1w
	 fUc7VvHLgdqkd+SC73vQ8YO9riJYdJlA4Q9ip1f3UMWcPahogGEDaAIjKI2/ozzlCR
	 IEIqRYO7UKIQ7gu/hqlJaCxHn0HLrMCM+K1VOJRRSkrZMK1uDOwFZtXbqJ63NXU4kz
	 PMT2vzuYy7CFCH6pcx7ngFqDt9qPgyRpjqNINdojskN5/Fpk9he4rumUtonsqFOBUh
	 qA1DIo6CLZE6Q==
Subject: Re: [PATCH net v12 1/4] net: usb: lan78xx: register the PHY interrupt
 with the MDIO bus
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, f.fainelli@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 00:58:20 +0000
Message-ID: <179072990024.434549.9815346887559663757@kernel.org>
In-Reply-To: <20260927235733.2619081-2-f@lex.la>
References: <20260927235733.2619081-2-f@lex.la>
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

- [Medium] In lan78xx_mdio_init() (drivers/net/usb/lan78xx.c:2122-2124),
  the one mapped PHY interrupt (domain_data.phyirq, backed only by…

--

net: usb: lan78xx: register the PHY interrupt with the MDIO bus

This patch moves the lan78xx PHY interrupt out of lan78xx_phy_init(),
where it was written directly to phydev->irq. It now goes into the
mii_bus irq[] table before of_mdiobus_register() is called. Every entry
in the table is set to domain_data.phyirq, so the PHY created by the
scan picks it up through phy_device_create().

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 5655941f14783..522fb4daeb468 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c

[ ... ]

> @@ -2118,6 +2119,10 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
>  		break;
>  	}
>  
> +	if (dev->domain_data.phyirq > 0)
> +		for (i = 0; i < PHY_MAX_ADDR; i++)
> +			dev->mdiobus->irq[i] = dev->domain_data.phyirq;
> +

[Severity: Medium]
On LAN7801, could this mark PHYs that are not wired to the LAN7801 PHY_INT
input as interrupt driven?

The 7801 case in the switch above leaves phy_mask at 0:

	case ID_REV_CHIP_ID_7801_:
		break;

So every PHY the scan finds takes its irq from this table in
phy_device_create():

	dev->irq = bus->irq[addr];

A child of the "mdio" DT node that has no "interrupts" property gets the
same value from fwnode_mdiobus_phy_device_register():

	} else {
		phy->irq = mdio->irq[addr];
	}

But only one interrupt is mapped, in lan78xx_setup_irq_domain():

	irqmap = irq_create_mapping(irqdomain, INT_EP_PHY);

lan78xx_status() also raises it only for the single INT_ENP_PHY_INT
status bit.

Before this patch, only the PHY that phy_find_first() returned in
lan78xx_get_phy() had phydev->irq set to phyirq. Every other PHY on the
bus kept PHY_POLL.

Suppose another consumer attaches a second PHY on a 7801 MDIO bus, for
example a DSA port or another MAC that uses phy-handle. If that PHY's
driver supports interrupts, phylink_bringup_phy() or phy_connect() would
call phy_request_interrupt() on phyirq, and phylib would stop polling
that PHY.

Would link changes on that PHY then go unreported, since its INT pin is
not connected to the LAN7801?

A devicetree author also seems to lose the ability to ask for polling on
such a PHY, because leaving out "interrupts" now gives it phyirq.

The commit message says:

  Fill the whole table rather than one entry: for 7801 the address is not
  known until the scan, and for the other two phy_mask leaves only address
  1 readable, so a loop costs less than a second switch on the chip id.

Does this reasoning cover the PHYs on the bus other than the one lan78xx
attaches itself? The later patches in the series don't seem to touch
lan78xx.c, so this behaviour would still be there once the whole series
is applied.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927235733.2619081-1-f%40lex.la
