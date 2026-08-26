Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76C1274650;
	Wed, 26 Aug 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787710878; cv=none; b=usLQj9Kh+OADqPDZe1Q4brhiJALv9I7v0R44BhG+8nRlJYwgkBspKR7+nacK0SJoEnhADrLlfWeBT5K1sx+jkD5OV3zTSyOOHnDxazD5nQZBoHNrwXLGfecum8TEX3rp8cJ0VGUcj3TT9awNL30Zv3SH/F7iVLLcaHqViZ5XCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787710878; c=relaxed/simple;
	bh=VzAx6tpSKJZxYZxhOZ3vcmVfnywvtxWQuulVY0x57Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE7giMSeftS27INlLVvqdWbKY4vTcJWWMDZMCVc72rvb2l4nfNPlVSaEa5kTP1sff0ntzPY6ReZG2Bzxx15U6+Y9XwY3ZorHtNDNsPNEM/KVweIJNRACY1OxTPALc7KAB2yyFeQpJSPcVdIgem8EBu1k8sjcQ5a89hn3c4XCm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WRwlmjuZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WRwlmjuZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hWsnbWpreJ6QQ54ZCcdko66WA2cZH6mL0rv/WMd4xzM=; b=WRwlmjuZwzClxNAerr3bu0Fou9
	Y0KlUS7/WtkYxouTGfteL+fm8tUgDZu8sW7zv95AiS2ou7QuOpl/5jljBxp3uk0CBFzwTOfDMQk+n
	ju29mePgaMlRyND98vyj8ge1NjbGosHwlH0YRy5cjOhb++EMtqmhDahUrWtUjvUvV+R0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wz3G8-001SUU-Fm; Wed, 26 Aug 2026 04:21:00 +0200
Date: Wed, 26 Aug 2026 04:21:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: ansuelsmth@gmail.com, netdev@vger.kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, daniel@makrotopia.org,
	dqfext@gmail.com, SkyLake.Huang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: support EcoNet EN751221
 gbit SoC PHY
Message-ID: <4d594c62-2ceb-43c1-a3d2-731b80493787@lunn.ch>
References: <20260825193456.1823985-1-cjd@cjdns.fr>
 <20260825193456.1823985-4-cjd@cjdns.fr>
 <d7d86078-8a29-4e7f-a62e-91f6b266bea1@lunn.ch>
 <a75b6b15-f86b-4cb2-934c-87583b5bb02c@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a75b6b15-f86b-4cb2-934c-87583b5bb02c@cjdns.fr>

> > Does this need a change to the binding document?
> 
> 
> Not as far as I know. econet,en751221-chip-scu is defined in mfd/syscon.yaml
> because it's a catch-all for configuration that the engineers didn't know
> what to do with.

Do you need a property in the PHY node to make this work?

> > > +static int en751221_gphy_config_init(struct phy_device *phydev)
> > > +{
> > > +	phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
> > Why is the EEE register being cleared?
> 
> 
> From reading the reference implementation, I get the impression that this
> hardware is something of a basket case. There was a certain amount of "write
> three times and then read back" type magic that I just omitted because it
> really looks like they were actively debugging and as soon as it started
> working they shipped the code exactly as it was.
> 
> 
> In the case of disabling EEE, I thought it more prudent to follow them
> because I don't have every SoC that this PHY ever appeared on and I would
> rather not diverge too greatly and risk it being unreliable on some devices.

Is EEE broken? If it is, this is not the correct way to disable
it. You should call phy_disable_eee(phydev); This will also prevent
user space enabling it again.

> > > +	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
> > > +	__mtk_tr_write(phydev, 0x1, 0xf, 0x00, 0x00002b);
> > > +	__mtk_tr_write(phydev, 0x1, 0xf, 0x03, 0x082422);
> > > +	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
> > > +
> > > +	ret = phy_write(phydev, MII_CTRL1000,
> > > +			ADVERTISE_1000FULL | CTL1000_PREFER_MASTER |
> > > +			CTL1000_AS_MASTER | CTL1000_ENABLE_MASTER);
> > What does this default to?
> It starts with only ADVERTISE_1000FULL. I don't know why the engineers
> wanted to set it to master, but its definitely intentional.

Generally, switches take the master role, and client take the slave
role. So this does make sense for a PHY used in a switch.

	Andrew
