Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100631A23A6;
	Sun, 23 Aug 2026 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787448304; cv=none; b=N92CwhITwkXhE4ZphSAB84SBgGRvgcciwkUi6o+GjC3KYbZiQdaoY9oLiP70V6kGjw9ByHIjptEP9YVrO1mNWzvVkxRAxVo1Bxk6ZmD1UNXNveED2yxL0Duemasz1nkzt+AxGcBHz8aQYEl0kNwlrFTN7mJS/61SAOZMZwRNXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787448304; c=relaxed/simple;
	bh=z6F4tVrcTTTgdabnuXXhg6zWCUz382I96CZfxslnjf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjPzTowG8XqjG+JjRhUTprdi5FQ1mVG1vrIysGA5B9uNJBJrEwZdDQygD9PfKKNQnyqCpW9mlMCdZrxC0dz/r5DK0o51i1zXpdz4lToR7MsJuUgyhSUFbneJqgu8y+ibgNg0XrsI47QppDVNmBsuRcphDYm5HTYog19P6yZYrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CFGKAAQ8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CFGKAAQ8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/pFVgLB2egbbiOgju3ns7KhA9TuQVN0MC655HT5IVfs=; b=CFGKAAQ83dVVAZC1EqUEYK4RFA
	wRWrhMiSXzMJW0eeHjMKdRICDasxR/6S/Vb399IUAzaFTXhKHOqLECwk+xGGxs6CENRM3syunlSvq
	8B5vM7x9kSDlpNifBIy3hgqIlULcAWsR2jAJBb1wewnvTk0UJ280fZj1G+d2YfmWpAes=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wxwx7-0015aB-Sv; Sun, 23 Aug 2026 03:24:49 +0200
Date: Sun, 23 Aug 2026 03:24:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: dsa: connect a late-arriving PHY at
 ifup
Message-ID: <c712cd5d-d4bd-413f-82a8-6303ff3e6526@lunn.ch>
References: <20260822155259.87146-1-f@lex.la>
 <20260822155259.87146-4-f@lex.la>
 <9557daed-f039-434a-ae64-ac849b9860be@lunn.ch>
 <20260823000549.6095-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823000549.6095-1-f@lex.la>

On Sun, Aug 23, 2026 at 03:05:49AM +0300, Aleksei Sviridkin wrote:
> > The problem is, this is not guaranteed to work. The driver might still
> > not be loaded, or it is still downloading firmware to the PHY.
> 
> These are two separate halves, and the driver can only reach one of
> them. When the firmware is late, your scheme works, and I want to do it
> as a follow-up. When the module itself is still on an unmounted rootfs,
> there is no probe to return success from, so the connect at switch
> setup still gets the genphy fallback and the port is gone for good.

How about making the DSA driver depend on the PHY. That would be much
simpler. Both are then builtin or bother are modules, so both should
be available at the same time. You might also be able to use
MODULE_SOFTDEP() to get dracut to put the PHY module in the initramfs.

> > I think you need to look at the PHY driver. Make its probe function
> > return success, but start a thread downloading the firmware. While
> > firmware is downloading, either soft_reset() or config_init() needs to
> > block.
> 
> I would rather not block: config_init runs inside phy_attach_direct, so
> on a DSA switch the blocked port holds up the whole switch probe and
> every other port with it.

Given the poor hardware design, your choices are limited. We really
try hard not to put workarounds for bad designs in core code. We try
to hide it within the drivers. So it might be the whole switch needs
to wait.

> For the follow-up I want to attach with the
> real driver's features immediately and keep the link down until the
> firmware lands, then trigger aneg, the way an SFP port sits linkless
> without a module.

SFPs are different. The Linux code was designed from the ground up to
handle hot plugable devices. phylib itself is much older, and does not
handle hot plugable PHYs. The SFP case is made easier by the fact the
MDIO bus is hot plugged at the same time as the PHY. So from phylibs
perspective, it is not hot plugged.

> aquantia and mscc load firmware from probe too, so a phylib helper
> for this would have three users.

I agree a general solution would be nice, and people have put some
thought into trying to find one, but it is not easy.

	Andrew
