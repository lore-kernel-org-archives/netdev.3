Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208190;
	b=tYseKAeXvHdTAiVljiNB6493LTyDqrvXkqDCxaIbfhg9+eCTZgV4NGIXpzko5XHK/uqG
	 ujqd4Ari4bearL004YHQz87vEdcvWVcxVXwl3xREW73Sz6Y1whVCDyTYEN/DH0yRBCIKD
	 TjdTao1FmM8h2j4Y1ZiTV7pVlOFfvnUzXIa2eajuDHmVKJk+EssZ85xOfgbsICp7ccvMT
	 XOC3w7q7gFvY8NcOkFQdibQ+krOnikWthcqgYzELLbT/REdJC0pKsODsLWcNb3/XOecWF
	 cr7nWqk7BR9zOjvpigmoeLEMuTP1nwUaNb9sdwH28dPYkUJDfpPJWOiQSYFG4ZQmgQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208190;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZggAsEZzDz8Xs5cq1SmLTCdVdYwUDmu3WpWyKwp22Pk=;
	b=VD1mNy4pH0xSlYBYkNZnEcTIxht7VflnCmqNjEt2j51M7vXEjYvhA8bi1ZPE/M+512y+
	 YB3uNbI+XOc+9R8+MibytIIUkIgZ+4iKUYndjx5YHaEbjdUv8JYv6Ir50vxiFghvKarL5
	 iKCcn53It/ZTxPd3P7XYs4Bu00+pmU20v05XXznT8lt8D/2yma9DLYBIxByrOJAOQ2cIu
	 QgYo9Pylf+6MJvofOLb/1BJXC6xZZAB8uNl5QL66lsifa+oMvfjfzuOHmFJLDwbVge0s5
	 9X1LSkRPTTdE8yPi/lHFD+suyW//uxwEDM7xi93XylnX4ZN2cWLFgOoLDsw0n/IEuhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAxceFAm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F6606A31F;
	Wed, 28 Oct 2026 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAxceFAm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE59C1F01828;
	Wed, 28 Oct 2026 17:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793208190;
	bh=ZggAsEZzDz8Xs5cq1SmLTCdVdYwUDmu3WpWyKwp22Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kAxceFAmMtDu1Cg6KSXuYu5ewjTR6OwhSYEjVAJrHB6YYXBBNKLxBnJEuDPe8cJ5c
	 q8uq2384HUh9A/dBqNZM+wv2lVwCofDY5V+cICPoKOtMWfiZSvQI9AEve/AA5SGT6T
	 N0daUJse1XImpoGfJR3VK1nMCY0KZXmDchDDSPwX+yKm7BqrvrgQM2dibaVpStBUGK
	 DAfWmPgOw1mUBgyJSmP1rOIpcCSqq6A8dcLj3icOPgGM74vHBN6lng3IO6VLEDpySR
	 +UQhoBx7kCWt2D9n65f7e4yhSYfFx/261ZaWPm3On097THfojvgGWQrrKSJThLV4rH
	 P75KZ8fAwB1Dg==
Date: Wed, 28 Oct 2026 17:23:05 +0000
From: Simon Horman <horms@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev-bot+sashiko@kernel.org, opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, justin.chen@broadcom.com, f.fainelli@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: bcmgenet: recover from a failed resume
Message-ID: <20261028172305.GB257209@horms.kernel.org>
References: <20261022-nb-genet-fini-dma-net-v3-1-6e9fc89c0156@tipi-net.de>
 <179275652332.3134.3420351260504788140@kernel.org>
 <7a86dc120223465e88cc265a6f597657@tipi-net.de>
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
In-Reply-To: <7a86dc120223465e88cc265a6f597657@tipi-net.de>

On Fri, Oct 23, 2026 at 02:04:34PM +0200, Nicolai Buchwitz wrote:
> On 23.10.2026 13:55, netdev-bot+sashiko@kernel.org wrote:
> > [...]
> 
> > [Severity: Medium]
> > 
> > After a failed non-WoL resume, can the next non-WoL suspend leave an
> > external PHY powered up with its link active?
> > 
> > On the normal non-WoL path, bcmgenet_suspend() halts and suspends the
> > PHY:
> > 
> > bcmgenet_netif_stop(dev, true)
> >   phy_stop()
> >     PHY_HALTED -> phy_suspend()   (BMCR power-down)
> > 
> > The failed resume has already done this before bcmgenet_init_dma()
> > fails:
> > 
> > bcmgenet_resume()
> >   phy_init_hw()          drv->soft_reset() clears BMCR_PDOWN and sets
> >                          phydev->suspended = 0
> >   genphy_config_aneg()   restarts autoneg
> >   bcmgenet_init_dma()    fails -> return ret
> >                          (phy_resume() is never reached)
> > 
> > This new early return then skips any PHY power-down. Calling phy_stop()
> > here would not work either, because the PHY is still in PHY_HALTED.
> > 
> > Nothing else seems to power the PHY down. bcmgenet_mii_probe() sets
> > mac_managed_pm = true, so mdio_bus_phy_suspend() returns early, and
> > bcmgenet_suspend_noirq() only powers down an internal GPHY via
> > GENET_POWER_PASSIVE.
> > 
> > So an external PHY whose driver has both .soft_reset and .suspend (for
> > example genphy_soft_reset with genphy_suspend) would stay powered with
> > its link up through system sleep.
> > 
> > This would not show up with the bcm54xx PHY on CM4, which has no
> > .soft_reset, or with the Generic PHY driver.
> > 
> > Does the !priv->tx_cbs path need a phy_suspend() call (or similar) when
> > WoL is not in use?
> > 
> > > 
> > >  	netif_device_detach(dev);
> > > 
> > >  	if (device_may_wakeup(d) && priv->wolopts) {
> > 
> > [ ... ]
> 
> Same as in v2: pre-existing, phy_init_hw() powers it up in the failed
> resume and nothing starts it again. Fair that it's reachable now, before
> this series that suspend just hung. Nobody seems to have hit it either, it
> needs a failed resume plus a PHY with soft_reset, so pretty much an edge
> case, don't you think?
> 
> I'd rather not add a phy_suspend() I can't test ... the CM4's bcm54xx has
> no soft_reset, so the PHY never gets powered up there anyway. The proper
> fix is to stop leaving the half state behind, that's on my list after the
> MTU series.

FWIIW, I agree that is an appropriate approach here.

Reviewed-by: Simon Horman <horms@kernel.org>

