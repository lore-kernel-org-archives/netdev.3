Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933E3803E1;
	Sat, 22 Aug 2026 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435371; cv=none; b=HAQxwAaADjqhn0lAN7x+L/a5ThU+bUzUc6YS4gNVW6f7E9z5wrkgI9phc6oMi6a8pgw2ov8ka8Eu1iG72mtxTMeZcAy5oZyOcYfUgl6splg3Kb1n7+qxPZlyn4uBjoGcfguQxvoRrHH84dl+7kMEKGm1ys68rh5WZfoMBouacyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435371; c=relaxed/simple;
	bh=YTQ1dMOh1s6r91T8gw3jxSG0d41Rqt/ku+IQVi/q7l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7DDxXgxZ8yEkrwNk2gTST6/uWrq5FmqTBY+O+gOsejhOTT2hYMeXyeDRLQmuxx3bbdL/QHUXRAF4JI2hsElgghgbUcjmBU9OsDz2CE+XXqyxZAZojM6b84vgz0mrZfUv4LFZDN00Z70x4RSf7Y57h7z2o+6CqpGtaF2ty+Ud7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fMEvHcPl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fMEvHcPl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=80UgMBvAIwndVclpnLX2WADk5OqrVIX0GJw2yYQPwPI=; b=fMEvHcPl1fB/pyc/wz6XfFlyuo
	YB2BX60p4m0zDlEwcYJWZLx5v+B0V1H4JPS0LY0DqPRQ42O+0RGCqrEzGgrrjN4XTJiSOjfHvtBjW
	TCgDM5G5EXtjOkMoT4KOC10bcXfeNoSdrUJdHGSMTVUuwZWD2L+2KTlcOFWaDuRi59Pk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wxtaC-0014WS-S9; Sat, 22 Aug 2026 23:48:56 +0200
Date: Sat, 22 Aug 2026 23:48:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: "Chester A . Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <olteanv@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 1/2] net: dsa: mt7530: populate lpi_interfaces to fix
 EEE support
Message-ID: <c501d5f8-015c-4ce1-87ee-c4cdaea57f7e@lunn.ch>
References: <20260822195252.2934-1-f@lex.la>
 <20260822195252.2934-2-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822195252.2934-2-f@lex.la>

On Sat, Aug 22, 2026 at 10:52:51PM +0300, Aleksei Sviridkin wrote:
> mt753x_phylink_get_caps() fills in config->lpi_capabilities and
> config->lpi_timer_default, but never populates config->lpi_interfaces.
> phylink only treats a MAC as supporting phylink managed EEE when the
> tx_lpi methods are implemented and both the LPI capabilities and the
> LPI interfaces are non-empty, so EEE is unavailable on every port:
> 
>   # ethtool --show-eee lan1
>   Cannot get EEE settings: Not supported
> 
> even though the driver implements mac_enable_tx_lpi() and
> mac_disable_tx_lpi() and reads the LPI threshold back out of PMEEECR.
> Since the tx_lpi methods are implemented, phylink takes the other
> branch and calls phy_disable_eee(), which fills eee_disabled_modes, so
> userspace cannot enable EEE either.
> 
> Only the first half of what commit 06dfcd4098cf ("net: dsa: mt7530: fix
> enabling EEE on MT7531 switch on all boards") arranged therefore
> survives. It left EEE off out of the box on purpose, by having
> mt7531_setup() clear the switch PHYs' EEE advertisement, and ended
> "With this change, EEE can now be enabled using ethtool". It cannot be,
> any more.
> 
> Copy the supported interfaces into lpi_interfaces. This requires moving
> the mac_port_get_caps() call ahead of the EEE block, since that is what
> populates supported_interfaces - copying it beforehand would copy an
> empty bitmap.
> 
> LPI stays off by default. The driver does not set eee_enabled_default,
> so phylink leaves tx_lpi_enabled false, and phy_check_link_status()
> computes enable_tx_lpi as tx_lpi_enabled && eee_active - nothing
> asserts LPI until userspace enables it with ethtool --set-eee. The EEE
> advertisement is the part that does change: phylink no longer takes the
> phy_disable_eee() branch, so a PHY that advertises EEE out of reset
> advertises it again and the link may negotiate EEE. MT7531's five
> internal PHYs are the exception, as mt7531_setup() zeroes
> MDIO_AN_EEE_ADV before the switch MDIO bus is registered, so
> phy_probe() reads an empty advertisement and records eee_cfg.eee_enabled
> as false. Nothing does that for an external PHY on port 5 or 6, or on
> the other mt753x variants, EN7528 aside - see below.
> 
> This also makes lpi_capabilities take effect for the first time, so
> correct its value in the same change. PMCR only has force bits for
> 100 Mbps (PMCR_FORCE_EEE100) and 1 Gbps (PMCR_FORCE_EEE1G), and PMSR
> only reports EEE state for those two speeds, so the MAC cannot signal
> LPI at 2.5 Gbps: drop MAC_2500FD. Absence from the header is weak
> evidence on its own, so for what it is worth, the Airoha AN8855 DSA
> driver - posted but not merged [1] - describes a PMCR of the same shape
> that does carry AN8855_PMCR_FORCE_EEE2P5G and AN8855_PMCR_FORCE_EEE5G
> next to the 1 Gbps and 100 Mbps bits. Correcting the value here rather
> than in a separate patch changes nothing observable: while
> lpi_interfaces was empty, lpi_capabilities never reached
> phy->advertising_eee, so no state ever claimed 2.5 Gbps LPI.
> 
> 2500BASE-X has to come out of lpi_interfaces as well, because
> lpi_capabilities cannot express it: it masks the PHY's EEE
> advertisement, a media side property, and never gates LPI activation on
> the MAC side speed. phylink raises the MAC speed to the interface
> maximum when the PHY rate matches (RATE_MATCH_PAUSE in
> phylink_link_up()), so a 1 Gbps media link behind a rate matching 2.5G
> PHY would otherwise arm LPI while the MAC runs at 2.5 Gbps. What that
> costs is limited to setups that keep the MAC on 2500BASE-X, where there
> are no LPI bits to use anyway; a PHY that switches the interface down
> to SGMII or 1000BASE-X keeps LPI, as those stay in the mask.
> 
> For the same reason, skip ports that support neither 100 Mbps nor
> 1 Gbps: on MT7988, EN7581 and AN7583, port 6 is 10 Gbps only, and it
> shares PHY_INTERFACE_MODE_INTERNAL with the 1 Gbps user ports, so the
> interface mask alone cannot tell them apart.
> 
> EEE remains unavailable on EN7528, whose GPHYs do not negotiate it
> reliably. Both LPI bitmaps stay empty there, so phylink keeps taking
> the phy_disable_eee() branch and its advertisement stays off.

This is very verbose. Is it AI generated? Please revise it and make it
suitable for a human. The important part of the commit message is
"Why?", since "What?" can be answered by reading the code.

> - mt753x_phylink_mac_enable_tx_lpi() sets the PMCR force-EEE bits
>   without checking the resolved speed or interface, relying entirely on
>   phylink never calling it above 1 Gbps. A check there would make the
>   driver robust independently of lpi_interfaces being right;
>   deliberately not bundled into a fix.

It is normal to assume phylink is correct. Now, if you do find it
doing the wrong thing, we want to know so we can fix it. So if you do
want to validate it here, make it very noisy if the validation fails.

	
    Andrew

---
pw-bot: cr
