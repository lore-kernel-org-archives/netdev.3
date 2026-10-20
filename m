Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498662;
	b=gz37Bxb2bqKKlcqVhDusvRH4nIZcunqT/2NPHPPyzP8wFXLsDAOvXW6JlM429r8nkXTf
	 7YcwZEUytn83iSgnzn9Wu+hVqs3Jdu7wWD8BW2X4MbinkkMLDnPP9f4ktT2d10gk3Cnht
	 kHBOvN2puaMSqQ+M3t6PYYJqLk2Wc5K2l4nEMqU4p0KIPmG//ikgl7axWtiVCpBRGTQbI
	 hUVBuRB/Dt74iiV8IZKZW4fNbFycg/PJkNlBgSqFBQyWCf95tMX4tASZ3Qe9WdUJ9PqoF
	 epSPFOV0ZPmktQL4sG9+3NH4iirgi5QRtYCHScE+1BYI+55J6MOJUWU9p//rcQX9G/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498662;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=TQCzSCnGOaVxSul1Ib03g+n3z4QSIZt1e/MKG68ekUY=;
	b=3ihVUOfQwWeRwP72iGJJc77r13G+AgXMfoYKa522LoT5A994mmUvFEiRRVgv2J0APt+B
	 J36JsNd0s5W+QEU3oeqnpfsmvD1DLzTK0huD7UyscQ/pkfBoPNHmrSphQbvoAWpCY88hu
	 R+ve3Bof9HPCuEdyMLoQTjLNQ8bZJJC+AqFjWh1PvZgFh3Ua6NsJsPd5c27OsTAUdkFQB
	 CtR0Ojcb8oeiQfK/4po2zyj1GuH1CbnZIMDckNoRY67/yGNjmgnN6NuyyYrBvFdtZrX8g
	 Jt6HEtkLW2t0CgHOq1uo4xA8x7MrsScaybYcGoPf2LNMLNrT3+hDFARAwM179p++yCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=OzU4Kzup;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63962606A319;
	Tue, 20 Oct 2026 12:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63962606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=OzU4Kzup
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TQCzSCnGOaVxSul1Ib03g+n3z4QSIZt1e/MKG68ekUY=; b=OzU4Kzuph/mTybi9iJzjDR/Doo
	nJtOprj56/DAD6eMpCOPj22KUSrMizAe4RECJa7OsjT4zwTf4qMQzkiels3v3iGPmWaJWQnw/QkZ8
	bn0PJNrfTmZRnT4nNInS5qG+qlIz9yZ96BPq8Y3xYvFVKGeyAyn3+Czl9us+14IJzcWc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJ8me-00BqSO-8c; Tue, 20 Oct 2026 14:17:36 +0200
Date: Tue, 20 Oct 2026 14:17:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prashant Sengar <prashantsengar25031@gmail.com>
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v2] net: usb: lan78xx: avoid NULL PHY dereference in
 WoL setup
Message-ID: <7bff1292-9371-4e3e-8062-31a554aeee17@lunn.ch>
References: <20261019193148.1381545-1-prashantsengar25031@gmail.com>
 <d9177176-75c2-4273-b5ba-d0c6afdad6c5@lunn.ch>
 <CABW1sBkKtBt0gipBNsNRWbwYy3GSDbe2d0TMBX8=whwu4WQmJg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABW1sBkKtBt0gipBNsNRWbwYy3GSDbe2d0TMBX8=whwu4WQmJg@mail.gmail.com>

On Tue, Oct 20, 2026 at 12:35:04PM +0530, Prashant Sengar wrote:
> Hi Andrew,
> 
> While testing the unconditional phylink_ethtool_set_wol() call, I
> noticed that it returns -EOPNOTSUPP for the PHY-less LAN7801
> fixed-link configuration in my QEMU USB Raw Gadget setup.
> 
> The NULL dereference is avoided, but lan78xx_set_wol() updates
> pdata->wol and the USB wakeup policy before calling phylink. I
> observed the following when disabling WoL:
> 
> Before SET: WoL = 0x20, USB wakeup enabled
> SET WoL=0:  -EOPNOTSUPP
> After SET:  WoL = 0x00, USB wakeup disabled
> 
> LAN78xx currently doesn't register a mac_wol_set callback with
> phylink, although it has its own controller-side WoL handling during
> suspend.
> 
> I wanted to share this observation while investigating the WoL path.
> Is this behavior expected for the fixed-link configuration, or am I
> overlooking some existing handling?

WoL with fixed link is not the usual setup developers have, so it is
probably untested. There might be issues here.

So the first question is Why does it return EOPNOTSUPP?

With phylink, it splits into two parts. The MAC driver needs to
indicate it supports WoL by providing mac_wol_set() in its
phylink_mac_ops, and indicating what WoL modes the MAC supports. Does
the lan7801 have that?

https://elixir.bootlin.com/linux/v7.3/source/drivers/net/usb/lan78xx.c#L2608

suggests it does not. Try implementing it. Look at what stmmac does.

The second part is what does the PHY provide?
phylink_phy_supports_wol() does check for a NULL phydev, so it looks
O.K.

	Andrew
