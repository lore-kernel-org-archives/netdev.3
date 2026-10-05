Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161D73793B8;
	Mon,  5 Oct 2026 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205496; cv=none; b=PGbRlGoFbangnZVuvpa0lNIow8khFTRmqDrmrfLfIebhZFYLmb92t1Ln23Z3QYNfRTm2L5XMwVOJEVP/2wUNLdklcUm8x4o+cjoi8raaa9w0S9Fr+9Xp4eLWdSsJ9EzmoKhDZGC9O7n7ajgf8bUwkzz3GQWB3grbT3UrBDLx0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205496; c=relaxed/simple;
	bh=94+z4cGXQL9A6MjlyMtlrGBprxcpro9Vp4TbCoQS/Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko0zDRNdnloVmsJnDl/ZmK6ibDn4XdfnmnyywNT/dwcdLhsx2JX9sPGgfFpOPka5W3kmf4wMdyeql+IPXtMrskoapr6nQNBKekBiFPo6pZM/xEfp+KNSFOqApvHicE1XXu/ltT9tvsZ0AjSD6Qqxl6if/9iARBOrQ5MCgU7KWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zzj35JwN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zzj35JwN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=enkOh/4XAAsSxvaxQuz2Eieb6w9s8itW27Yls9AB9uc=; b=zzj35JwNPjJPW50O83ZbH9kDaX
	UzytZYDILGxuWa59vHfMchowgQZMKiqiIh5GdoB50Pwsl1d+euPxEaeOTg4zfzv0mKP8fy12jUW9m
	pd/ivMZIe1zl5uUrc5KuX3gnYveaD2+ta2vf/uoyt6qU/zFTEm7tiloykAoq6ZzQikQc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDiMx-0092gq-OL; Mon, 05 Oct 2026 15:04:39 +0200
Date: Mon, 5 Oct 2026 15:04:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Stapelberg <michael@stapelberg.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
Message-ID: <eaef571a-4c07-42d4-913e-5deec16f4a59@lunn.ch>
References: <20261004204516.281201-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004204516.281201-1-rosenp@gmail.com>

> +static irqreturn_t m88e1318_handle_interrupt(struct phy_device *phydev)
> +{
> +	int irq_status;
> +
> +	irq_status = phy_read(phydev, MII_M1011_IEVENT);
> +	if (irq_status < 0) {
> +		phy_error(phydev);
> +		return IRQ_NONE;
> +	}
> +
> +	/* Claim events from the IMASK_INIT set as well as the WoL event
> +	 * mirrored from WOL_EIE in the enable register.
> +	 */
> +	if (!(irq_status & (MII_M1011_IMASK_INIT |
> +			    MII_88E1318S_PHY_CSIER_WOL_EIE)))

The existing naming in this driver is not nice. We have:

#define MII_M1011_IMASK			0x12

/* Copper Specific Interrupt Enable Register */
#define MII_88E1318S_PHY_CSIER				0x12

So the same register has two macros/names.

And then

#define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)

So this is one bit in that register. Combing MII_M1011_IMASK with
MII_88E1318S_PHY_CSIER_WOL_EIE is technically correct, but looks wrong
because they have different prefixes.

Marvell has an SDK called DSDT. It is GPL v2 licenses, so if you can
find a copy anywhere on the Internet, it is fine to use as
reference. It does not treat bit 7 special between different devices,
those with and without WoL. So i don't think we need a special
interrupt handler, the existing one can be extended for WoL.

Can we sort out the naming for the interrupt registers and the bits.

DSDT has:

#define MAD_COPPER_AUTONEGO_ERROR        MAD_BIT_15
#define MAD_COPPER_SPEED_CHANGED         MAD_BIT_14
#define MAD_COPPER_DUPLEX_CHANGED        MAD_BIT_13
#define MAD_COPPER_PAGE_RECEIVED         MAD_BIT_12
#define MAD_COPPER_AUTO_NEG_COMPLETED    MAD_BIT_11
#define MAD_COPPER_LINK_STATUS_CHANGED   MAD_BIT_10
#define MAD_COPPER_SYMBOL_ERROR          MAD_BIT_9
#define MAD_COPPER_FALSE_CARRIER         MAD_BIT_8
#define MAD_COPPER_WOL_EVENT             MAD_BIT_7
#define MAD_COPPER_CROSSOVER_CHANGED     MAD_BIT_6
#define MAD_COPPER_DOWNSHIFT_DETECT      MAD_BIT_5
#define MAD_COPPER_ENERGY_DETECT         MAD_BIT_4
#define MAD_COPPER_FLP_EXCH_COMP_NO_LNK  MAD_BIT_3
#define MAD_COPPER_DTE_DETECT_CHANGED    MAD_BIT_2
#define MAD_COPPER_POLARITY_CHANGED      MAD_BIT_1
#define MAD_COPPER_JABBER                MAD_BIT_0

Which would make:

#define MII_M1011_IMASK_INIT		0x6400

link status change, duplex change and speed change.

Probably MII_88E1318S_PHY_CSIER should go away, keep with IEVENT,
IMASK, and name the bits MII_M1011_I_JABBER, MII_M1011_I_SPEED_CHANGE?

       Thanks
	Andrew
