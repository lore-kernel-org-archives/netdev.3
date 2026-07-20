Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281C388392;
	Mon, 20 Jul 2026 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571199; cv=none; b=XtmgmetNoML01KtVXC4TxYtbIrfXlRMuj3QUM6zbkfF8kNwJws2SkoiXQQaVlOoplV8mMp6vlBzeQFOYfPGiobQqgUaGV/4EhNTdNtXz/V97mwLHD6seIy82xyKZikQZrSycpuzep2ecRGpcXGxitZ9XgAk0zeGBW/uNvT/cNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571199; c=relaxed/simple;
	bh=IOKYeviaPAK9TqMrOkjCLBVODOs4vjSACv0V5kgE5GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQOeTRP+iAKy+2DbyH2eO9oyg/S3IJ27QN+TexENXMv7FYFCpLdUErhxSLKmmxpgWalhJ0Nne8FHgM434abd28r2UfP3UBhz5NeUgezdH1tOGxU9T0m6FdyvrY8g3zX9ffFwgGxSxB+SbdmYk7veOvtFNFLZyoFeMW7YY5V4EvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eeoZMPw0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eeoZMPw0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0Pa1fxs7LFxjUuZs14CdRVR603IZ7HZreI70IHbVRSA=; b=eeoZMPw0Gt/Tr6PIqcxghwCERz
	k0wETnu74pcbdTBCFw63/I8cmRgGeGfwAn46iRG/oxluiWjOmp4kVb9rY462LSYS/I+XiK0Ic0cX4
	3e5TNJrWuiHvuesbi8bjIcFEYmlqnU10yPdoRtPF1yZiynhN1sNTfMBtOp4dgx6dfj7A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlsU3-00DIzk-8a; Mon, 20 Jul 2026 20:12:55 +0200
Date: Mon, 20 Jul 2026 20:12:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next] net: stmmac: Simplify ioctl handling
Message-ID: <1e640dcb-43ce-4a3b-a74a-ed8e48706b86@lunn.ch>
References: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
 <ae82997f-537e-4a2d-abce-d163fcf9d868@lunn.ch>
 <6ac12388-60de-45aa-a8d0-62fcfaf7bea2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac12388-60de-45aa-a8d0-62fcfaf7bea2@linux.dev>

On Mon, Jul 20, 2026 at 04:17:32PM +0100, Vadim Fedorenko wrote:
> On 19.07.2026 17:13, Andrew Lunn wrote:
> > > Looking at this, I'm wondering if we can't just get rid of SIOCSHWTSTAMP
> > > handling in phy_mii_ioctl(). Looks like we can ?
> > 
> > I'm not sure about that. We need Richards input.
> > 
> > The code in phy_mii_ioctl() allows the MAC to be bypassed, it goes
> > straight to a PHY based stamper. It could be the MAC has no idea the
> > PHY has this capability, so it has not implemented the .ndo?
> > 
> > It might be we need to hoist the code from phy_mii_ioctl() into
> > dev_{sg}et_hwtstamp()?
> 
> Hi Andrew!
> 
> I think I've converted all phy drivers while removing support for
> SIOCSHWTSTAMP/SIOCGHWTSTAMP from netdev ioctl. I believe it's impossible right
> now to reach SIOCSHWTSTAMP path of phy_mii_ioctl via ioctl on net device.

Lets look at this, using a random example:

drivers/net/ethernet/marvell/mv643xx_eth.c

mv643xx_eth_netdev_ops has nothing about time stamping. However it
does have a mv643xx_eth_ioctl. Which calls phy_mii_ioctl().

Lets say this Marvell MAC driver was paired with a
nxp-c45-tja11xx. nxp_c45_probe() does:

                priv->mii_ts.rxtstamp = nxp_c45_rxtstamp;
                priv->mii_ts.txtstamp = nxp_c45_txtstamp;
                priv->mii_ts.hwtstamp_set = nxp_c45_hwtstamp_set;
                priv->mii_ts.hwtstamp_get = nxp_c45_hwtstamp_get;
                priv->mii_ts.ts_info = nxp_c45_ts_info;
                phydev->mii_ts = &priv->mii_ts;

So it looks like in phy_mii_ioctl(), the conditions:

       case SIOCSHWTSTAMP:
                if (phydev->mii_ts && phydev->mii_ts->hwtstamp_set) {

are fulfilled, and

                        ret = phydev->mii_ts->hwtstamp_set(phydev->mii_ts,
                                                           &kernel_cfg,
                                                           &extack);

will happen.

Now, this combination of MAC and PHY is very unlikely but it proves
the point. As far as i remember, Richard added this code for the
dp83640 PHY device, but i don't remember what MAC driver it was paired
with. He wanted to make PHY support just work without the MAC driver
even caring.

	Andrew
