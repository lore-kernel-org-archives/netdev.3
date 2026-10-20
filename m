Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518017;
	b=XZxqDr9Q/d2Oq8XkvNWEudCizGP+S6Q/fQP4Fo3ucrwjZIzUMFXOw8l9Kbusaao9UKdV
	 M36dstoY952yRGDpPZl4xmr5IsvX1184SpmZ0vWPQulD5VRYZn8h5eXfpdnsO4w6MaEkE
	 k9i+DYV9+FAku511ZU1QHyWtyNbK3CZsyyUBhKk54XrPmH5NxRgoVSvMF2jy7pUNr7fWN
	 4iDqrkz3IcmLIYsdsg83+O0Hkc09j+Zu920tPrKtPN1i82V0eYZKDseYHE6i+I8g2jfMp
	 kGqXbGVQBT/KrSdwb8v2uPxMmHJ/pD6X1QtPaMxEbLcdFI1JGXNbAO599JQ8bCOm6QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518017;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=hgOzPzOjchrqHomdRvZ+L0A3V2FHRfWcryiGxEDDIww=;
	b=mZdJsRWCxtoJqNZMLK9eYL4UEcjh7AAaghmOBHEuuy9J/AH1Vz2mq6Y8uWonJsS+LCWi
	 Rk4EI07crH04oZ52EYpp6Nw6MuGlRthmbCKI/6fIU3WxViDzKjpLwYbSGWSZiwfEXxUq6
	 M59x/0a5Dvk9c8fA7o49OCVBWThcoSMBa147SBr9rO+uC01gFfda8RqynFC7YRiErvK5G
	 O1KN2UPw8EU1259uZc1wWenEHh8Wu/mxOlreHazhJ1yAoe5jD5jyMcn8vEm8tedhc8ysa
	 d71Qt8d8A6qh1QJX+pnQ6Pbksz535gmvw6z8fae/sxJpdMLsVeEe2QPh1iKgpx3ixmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=q6KhtCmK;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45EF606A322;
	Tue, 20 Oct 2026 17:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D45EF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=q6KhtCmK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=hgOzPzOjchrqHomdRvZ+L0A3V2FHRfWcryiGxEDDIww=; b=q6
	KhtCmK7u1b/zKShsk7MFV/2cNuSrVySbbJzTQnuLzUJjI6WGzmqlM1a0Kw0/nfpIE1CXguoTNP0Tt
	WkQWhSj2EJ80pvaXK05j3xGUDD1U4u0p+CsUNwgrfZK/JTvDSF6oqVc6ya1kmXKOn9JUhV/X9/RH4
	krPi85TTL1TGOhQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJDoa-00BtVN-4J; Tue, 20 Oct 2026 19:39:56 +0200
Date: Tue, 20 Oct 2026 19:39:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev-bot+sashiko@kernel.org
Cc: cyan2254650260@gmail.com, davem@davemloft.net, edumazet@kernel.org,
	hkallweit1@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Add JLSemi JL21xx Gigabit Ethernet
 PHY driver
Message-ID: <26a568ac-d39a-4b8c-aee3-a7fd539976c0@lunn.ch>
References: <20261016161543.444356-1-cyan2254650260@gmail.com>
 <179251652395.3135.9790628596697229408@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179251652395.3135.9790628596697229408@kernel.org>

On Tue, Oct 20, 2026 at 05:15:23PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 6 · Low: 3
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] jlsemi_set_wol() can leave the MDIO bus mutex held permanently.
> - [Medium] Wake-on-LAN cannot work, yet the driver tells userspace it is
>   enabled.
> - [Medium] When WoL is enabled, jlsemi_set_wol() writes JLSEMI_WOL_RMSQ
>   (0x1fff) to page 0xd8a reg 17.
> - [Medium] jlsemi_config_init() always calls
>   jlsemi_disable_autonomous_eee() (clears PHYCR2 bit 5) on every…
> - [Medium] When the LED's three link-speed bits are all set,
>   jlsemi_led_hw_control_get() returns TRIGGER_NETDEV_LINK_10, LINK_100…
> - [Medium] jlsemi_set_wol() ignores every hardware-programming error and
>   always returns 0.
> - [Medium] In the interrupt-disable branch of jlsemi_config_intr(), `err
>   = phy_write_paged(phydev, JLSEMI_INER_PAGE, JLSEMI_INER, 0)` is never…
> - [Low] The register map and most of the logic in
>   drivers/net/phy/jlsemi.c are a near-verbatim copy of the RTL8211F…
> - [Low] jlsemi_config_rgmii_delay() handles rx-/tx-internal-delay-ps
>   inconsistently.
> - [Low] jlsemi_handle_interrupt() reads INSR (0x1d) once.
> 
> --
> 
> net: phy: Add JLSemi JL21xx Gigabit Ethernet PHY driver
> 
> This commit adds a new phylib driver for the JLSemi JL2101, JL2121 and
> generic JL21xx Gigabit PHYs. It covers paged register access, RGMII delay
> configuration, vendor status register parsing, interrupts, hardware LED
> control, magic packet Wake-on-LAN, autonomous EEE disable and
> suspend/resume.
> 
> Link: https://www.jlsemi.com/
> 
> > diff --git a/drivers/net/phy/jlsemi.c b/drivers/net/phy/jlsemi.c
> > new file mode 100644
> > index 0000000000000..c3acff48d4618
> > --- /dev/null
> > +++ b/drivers/net/phy/jlsemi.c
> > @@ -0,0 +1,551 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Driver for JLSemi Gigabit Ethernet PHYs (JL2121 / JL2101)
> > + *
> > + * Copyright (C) 2026 Pufan Jin <cyan2254650260@gmail.com>
> > + */
> 
> [ ... ]
> 
> > +/* Wake-on-LAN settings */
> > +#define JLSEMI_WOL_PAGE			0xd8a
> > +#define JLSEMI_WOL_SETTINGS_EVENTS	16
> > +#define JLSEMI_WOL_EVENT_MAGIC		BIT(12)
> > +#define JLSEMI_WOL_RST_RMSQ		17
> > +#define JLSEMI_WOL_RG_RSTB		BIT(15)
> > +#define JLSEMI_WOL_RMSQ			0x1fff
> 
> [Severity: Low]
> This isn't a bug, but the register map looks identical to the RTL8211F
> support in drivers/net/phy/realtek/realtek_main.c. That covers PHYCR2 0x19
> bit 5, INSR 0x1d, INER page 0xa42 reg 0x12, RGMII page 0xd08 regs
> 0x11/0x15, WoL page 0xd8a regs 16/17 with RG_RSTB BIT(15) and RMSQ 0x1fff,
> MAC page 0xd8c, and LEDCR page 0xd04 reg 0x10 with 5-bit per-LED fields.
> 
> jlsemi_led_hw_is_supported() and jlsemi_led_hw_control_get() also follow
> rtl8211x_led_hw_is_supported() and rtl8211f_led_hw_control_get() closely.
> The same goes for the set_wol, suspend and resume flows.

Interesting. Please see if this really is register compatible. If it
is, please extend the RTL8211F to cover this device.

    Andrew
