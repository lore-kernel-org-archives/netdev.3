Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AD4EDCC5;
	Wed, 30 Sep 2026 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772652; cv=none; b=uplZzE4I7Vlm75PQoqY/EW586YXoPtbO0sa2apUBFhP93zkd1A1w0silPy0tpXr/0gp5iQjm9tk3qCFE/9j9BALu/YSfDtRUmTZWW0ZsynkHO1FC2Cha60O2ehFWXH2M4IfKqJWqE967te6VntgrJwRvY/WPsJmf0Y+rYmszBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772652; c=relaxed/simple;
	bh=ceieZL7mqNYggJrWA2zKrmZBZ486lCIoMlzfH8UkVDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCE6QKC6nh98Ck3cNmSJgjw+SUOY1FcbgMMlWtSVZR8uQ70kDFgoyzSI51+XLZhf1+yRgxW/QybbM0WAoNRTZuz9IHKTJinP75gylyVpDfchxIP9LeZ9/VaKnq5lTyA689lsJtbBRG8KbFQ0dmAhupM/bvRbP4NP95esP0vP2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qeuwnvFr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qeuwnvFr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6KOXvpK/3cB/opsbROnxFM/mbV+G1vUglh78ETzwRb0=; b=qe
	uwnvFrTF7A11FhiLE1B71C0lzOHjETkaD/GxMT9ZMcCJlIdg6jsyyVYNr4hRMFaNLjE7B5fwFvTxK
	8c9mtrbsEqSSL1jROhfK8WFpgE/cnf0sXgrCMRarHURJQhxEpgkf3JR1F8Bm2PwhtgplJJ2oG9aU5
	/WMPgtNK9G9ZO38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBtlW-0089mZ-QV; Wed, 30 Sep 2026 14:50:30 +0200
Date: Wed, 30 Sep 2026 14:50:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev-bot+sashiko@kernel.org
Cc: f@lex.la, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, olteanv@gmail.com, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
	f.fainelli@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v12 1/4] net: usb: lan78xx: register the PHY
 interrupt with the MDIO bus
Message-ID: <cc1778b0-838b-4bc6-914a-c436cde37938@lunn.ch>
References: <20260927235733.2619081-2-f@lex.la>
 <179072990024.434549.9815346887559663757@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179072990024.434549.9815346887559663757@kernel.org>

On Wed, Sep 30, 2026 at 12:58:20AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In lan78xx_mdio_init() (drivers/net/usb/lan78xx.c:2122-2124),
>   the one mapped PHY interrupt (domain_data.phyirq, backed only by…
> 
> --
> 
> net: usb: lan78xx: register the PHY interrupt with the MDIO bus
> 
> This patch moves the lan78xx PHY interrupt out of lan78xx_phy_init(),
> where it was written directly to phydev->irq. It now goes into the
> mii_bus irq[] table before of_mdiobus_register() is called. Every entry
> in the table is set to domain_data.phyirq, so the PHY created by the
> scan picks it up through phy_device_create().
> 
> > diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> > index 5655941f14783..522fb4daeb468 100644
> > --- a/drivers/net/usb/lan78xx.c
> > +++ b/drivers/net/usb/lan78xx.c
> 
> [ ... ]
> 
> > @@ -2118,6 +2119,10 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
> >  		break;
> >  	}
> >  
> > +	if (dev->domain_data.phyirq > 0)
> > +		for (i = 0; i < PHY_MAX_ADDR; i++)
> > +			dev->mdiobus->irq[i] = dev->domain_data.phyirq;
> > +
> 
> [Severity: Medium]
> On LAN7801, could this mark PHYs that are not wired to the LAN7801 PHY_INT
> input as interrupt driven?

Since this is a USB dongle, it is unlikely. However, i agree with the
general principal. The code should only change the one entry the PHY
is actually using. Please look at all the patches in this series.

   Andrew
