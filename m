Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC353A48C8;
	Sun, 18 Oct 2026 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338538; cv=none; b=GKJ9UBFuvyseTUZSFkegIrFcpdScEq6lNXgJSYT1aQnPfDbxD+vMuESs8Cc6BHu2FJ8NMNWIt1kSq/ZQC3Vc8AMDvrWwJu31q1Sv6UyBI3HKKpGE9xV5NpEOfJ+8aOcPUY2qk85hSUG9/VelkxivFm7+kMvjR8fzPLdIFLlytMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338538; c=relaxed/simple;
	bh=GPCoCYZQtteLZlcwOjGXqBmMG1EEEu/HlmWvQG4yR7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTn5btLDv91qmT/9yOfkbVpD91XvfzKqCyJYCULIFGQuBHIXtJEqc3hsWsUqS1Wxw2oNvIe3kg5ocsD679VIyX9+Jd6pVYqh+TEvGi3FDaXYSBHtSaKdXoKes5R5fs4GKQYOA+vWYx7V7pJv7LoKunWjrVkRqRPGvs/5U1bddV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IhDlV3ZE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IhDlV3ZE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jy49RzWlgkvzIBqKndlJQi4XZ9ezklP+1R+XXKRDsU8=; b=IhDlV3ZEL7Z5Uo1hxwrPPKViB0
	L3BcGrP1nT53MCVrT72Xo9c3cGdi8MBxkroRSe+P4EFWCPleeXkeIEfGwzk4serdWAPKl7lKAejae
	fodueCfUe9b2WdSfi90b84zt23Zqy+SaBLv9B0U5rUvRn1j/3SEacrexpo6ABUejR7O0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIT7n-00BVKs-JN; Sun, 18 Oct 2026 17:48:39 +0200
Date: Sun, 18 Oct 2026 17:48:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Thompson <daniel@riscstar.com>,
	Alexander Duyck <alexanderduyck@fb.com>
Cc: Alex Elder <elder@riscstar.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: pcs: xpcs: select operating mode for
 10G-baseR capable PCS
Message-ID: <fe13016b-ebd6-4a2f-a07b-324f46b456d3@lunn.ch>
References: <20261014223100.304486-1-elder@riscstar.com>
 <20261014223100.304486-3-elder@riscstar.com>
 <f8c01002-da88-4f0f-a02a-7480591f4296@lunn.ch>
 <atI1IK6blP-vumLQ@aspen.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atI1IK6blP-vumLQ@aspen.lan>

On Fri, Oct 16, 2026 at 03:30:56PM +0100, Daniel Thompson wrote:
> On Thu, Oct 15, 2026 at 11:09:14PM +0200, Andrew Lunn wrote:
> > I don't know this PCS driver, so maybe dumb questions....
> >
> > > Currently the XPCS found on Toshiba TC9564 is unable to operate at
> > > 2500base-X and slower with a PHY connected using SGMII/2500base-X
> > > (in our case a Qualcomm QCA8081).
> >
> > Is the PHY actually relevant here? What about SGMII/2500base-X for an
> > SFP?
> 
> No, I don't think the phy is relevant here (the bit in brackets just
> records the specific hardware combination that we observed the problem
> on).
> 
> 
> > Is this purely a PCS problem, or does what the PCS connect to make a
> > difference?
> 
> AFAIK it is purely a PCS problem (but it's all soldered down so I have
> no chance to prove I am right by testing it).

Thanks. Given it was stated i was thinking it could be relevant. But
how can it be relevant? And then i thought that the PCS only supports
10Gbase-R, and the PHY is using rate adaptation to handle slower media
speeds?

That seemed unlikely.
 
> > > The problem arises because this XPCS supports 10Gbase-R. That means
> > > that the reset value of SR_XS_PCS_CTRL2:PCS_TYPE_SEL (0) is valid and
> > > this suppresses the modal switching based on bit 13 of SR_PMA_CTRL1
> > > or SR_XS_PCS_CTRL1.
> >
> > ~/linux/drivers/net/pcs$ grep SR_XS_PCS_CTRL1 *
> > ~/linux/drivers/net/pcs$ grep SR_PMA_CTRL1 *
> > ~/linux/drivers/net/pcs$
> >
> > This is not helping me understand what is going on here.
> 
> These names are exactly as they appear in the technical documentation
> for the TC9564. I assumed these to be inherited from the Synopsis XPCS
> docs and would make sense in the context of the XPCS driver.

I however don't have this documentation, just the driver, and 802.3.

> However, now you mention it I can see that "Speed selection bit (13) of
> PCS control 1" would be considerably clearer for reviewers who take a
> wider view! Will fix this and will also be a bit clearer about how XPCS
> treats PCS_TYPE_SEL.
> 
> 
> > > +	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
> > > +		switch (interface) {
> > > +		case PHY_INTERFACE_MODE_SGMII:
> > > +		case PHY_INTERFACE_MODE_1000BASEX:
> > > +		case PHY_INTERFACE_MODE_2500BASEX:
> > > +			/*
> > > +			 * Why are we writing MDIO_PCS_CTRL2_TYPE + 1? We want
> > > +			 * the modal behaviour that comes when we pick a
> > > +			 * reserved value. XPCS allocates extra bits to this
> > > +			 * field and allocates values from 15 down so
> > > +			 * MDIO_PCS_CTRL2_TYPE + 1 is the value likely to be
> > > +			 * allocated last (and hopefully never).
> >
> > MDIO_PCS_CTRL2_TYPE is 3. Looking at 802.3, the value 4 is
> > 40GBASE-R. The 2022 version of the standard has values defined up to
> > 10011b, for speeds up to 400G,
> >
> > Alex added support for 25G, 50G, 100G.
> >
> > Is this an issue?
> 
> It will probably be an issue when the kernel is first called up on to
> support an XPCS that supports 40GBASE-R.

Which is likely to happen sometime in the future. Maybe Alex's
hardware even supports it, but if you can do 50G, why bother with 40G?

 
> The XPCS (at least in TC956x) handles MDIO_PCS_CTRL2 in a slightly odd way.
> It 4 bits wide and accepts 10GBASE-R, 10GBASE-X, 5GBASE-R and 2.5GBASE-X
> is defined in the standards up to 2018. All other bit patterns are
> reserved and instruct the XPCS to use Speed selection bit (13) of PCS
> control 1 to choose between 10GBASE-X or 1000BASE-X.

We probably need Alex in this thread, what happens for 25G, 50G, 100G?

Maybe there are different revisions of the IP, and later revisions
make this register follow the standard?

> 
> That means we *must* write a reserved value to this register because the
> default value after a reset prevents <=1G modes from working (I think
> automatic switch over between 1G and 2.5G also liked this to a reserved
> value but I don't fully recall right now).
> 
> On that basis the best bit pattern to use one that isn't implemented by
> whatever XPCS we happen to be running on. One simple approach might be
> keep using 40GBASE-R but to check PCS Status 2 to ensure we fail in a
> non-silent manner on hypothesized future XPCS hardware:
> 
> 	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
> 		if (mdio_stat2 & MDIO_PCS_STAT2_40GBR) {
> 			dev_err(dev, "40GBASE-R is *not* a reserved "
> 			              value on this XPCS");
> 			return -ENOTSUP;
> 		}

Maybe. But we need to ensure it does not cause regressions for fbnic,
which might actually support this speed.

	Andrew
