Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794557663;
	b=HlCTpZqM2cR6mII5MM1ThFjcgsIKluRLaTxntroOgVMB6DlIxfp5ZMywA7Sz13GnpO33
	 f/AHIEHHG5EMFk0G7ivqT9hygW8201zoiMNwfYxSWsFbtjBG5O9NgERukbIdzJiVxijn9
	 DqiZ4y/LT4qjWz9I/dXvEzDNtByfMTjnMuuQ0mKz7oXZGz+BJmTLJahpKjJUkaZCJMXSB
	 WoUrzlyyfchf1MgKTUpRQzEwVnLCWt2BeCQzbcvIi30tMf9+pD+i5NnpZAqDaZ7ClLHpj
	 3tupbqugACEWOxS64NByvIGlzuNv+zDMba4JdPDOazFxGcRE2CpNmEZMS3aE3HoocRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557663;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=tkSl6xRbwmSIsrOU8lyWX0+XGKsidS9uZOphCGaP2kA=;
	b=IQdRdmkbTD/5qlNSBgmCNqcEQfNeziQ9cxFoblJYUZ4/DNaR9o5Gwlh1YFpXY3oLDY0g
	 YExvP9VaMk6Y8ema7Js4ksdXDfs0oytKfBQ6pfI2D7LHhJaef1Vx+Zs5z8pZKfilJPU4R
	 MFT1IiG5cewhO9IajvxYeoo/N8UDnN1e39KCWahuOLlMZSHmIij8rcWSP2KCZrP2JTzlj
	 OXUv8U9+tlI6q+VLnNS+nzrt8KM2dInq3pRpk1GOrz03HMkmtjED7oPcbVGdv3GLReEl7
	 za0Xh74efJbsj0Td2BhyHd6ttXfC+cfczHGnJXea+SV8UZwhZMRqOI2FvHCEqBeB6Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=rC4WDStS;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCC606A327;
	Fri, 13 Nov 2026 08:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DFCC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=rC4WDStS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794557663; x=1826093663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yYHOkNEk/gB8DRZ1Fof7mixsvil3MZY8OXgbvnNfeG0=;
  b=rC4WDStSBRu8Sv2fK+xc/fNGMJxR6cv2MCHwcydMycbld0jBWzngatTt
   I9D2rpKbf0avS/iXh9oQvhI88Wd93ResCfM4sPIezsWvbwL6ZU7b4cnZl
   BP8D7yBakKiLPZtJcStgARQXKxZprPeg9clAywH93E/A2cP03vnpZqAyJ
   YHrysqVhzT3r0B53N0SwcyWIKpoF/NoNtjtL0Ez2y8lUQANJjuuSgWeO2
   NC0ehFNtJdkZTSnK8GNxHJBxoWAUM9Sa9EcYzhr1lVcJEPP7/OHkQoCyI
   R/cE6aZdeslXJMxJaypY+P0fFHPjzNHpO+LY5dMFmnft8wsQroYPPfUl6
   g==;
X-CSE-ConnectionGUID: BAIz5dV6S/CurbK8hFdEdA==
X-CSE-MsgGUID: kXsKGSs2T4Cj6pdfAga/1g==
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="66696871"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2026 01:14:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 01:14:21 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 01:14:19 -0700
Date: Fri, 13 Nov 2026 09:14:18 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robert.marko@sartura.hr>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>
Subject: Re: [PATCH net-next v2 9/9] net: sparx5/lan969x: add support for
 changing the MTU
Message-ID: <20261113081418.24q3teguhhe2mkik@DEN-DL-M70577.microsemi.net>
References: <20261111-sparx5-mtu-change-v2-9-59c91357e8f6@microchip.com>
 <179450480055.2199510.5195062101976319185@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179450480055.2199510.5195062101976319185@kernel.org>

> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 � High: 1 � Medium: 2 � Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] net: sparx5: lan969x: double free of RX page after
>   lan969x_fdma_rx_get_frame()
> - [Medium] net: sparx5: GFP_ATOMIC RX ring allocation in
>   sparx5_port_change_mtu()
> - [Medium] net: sparx5: sparx5_port_change_mtu() blocks non-FDMA MTU
>   changes
> - [Low] An MTU increase can fail even when the current FDMA buffers
>   already fit the new MTU.
> 
> --
> 
> net: sparx5/lan969x: add support for changing the MTU
> 
> This adds an ndo_change_mtu callback for sparx5/lan969x ports. It
> programs the MAC maximum frame length and resizes the shared FDMA
> buffers, and orders these steps so the MAC never accepts frames larger
> than the RX buffers. MTU changes are only allowed when the FDMA is
> used, and max_mtu is set from the 14000 byte MAC limit.
> 
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> > index b3725cf2dd44c..095925752f5f6 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> > @@ -250,6 +250,44 @@ static int sparx5_port_hwtstamp_set(struct net_device *dev,
> >  	return sparx5_ptp_hwtstamp_set(sparx5_port, cfg, extack);
> >  }
> >  
> > +static int sparx5_port_change_mtu(struct net_device *dev, int new_mtu)
> > +{
> > +	struct sparx5_port *port = netdev_priv(dev);
> > +	struct sparx5 *sparx5 = port->sparx5;
> > +	bool resize = new_mtu > dev->mtu;
> > +	int err;
> 
> [ ... ]
> 
> > +	/* Never let the MAC accept frames larger than the RX buffers */
> > +	if (!resize)
> > +		sparx5_port_max_len_set(sparx5, port, SPX5_HW_MTU(new_mtu));
> > +
> > +	err = sparx5->data->ops->fdma_resize(sparx5, port, new_mtu);
> > +	if (err) {
> > +		if (resize)
> > +			return err;
> 
> [Severity: High]
> This error path isn't new in this patch, but wiring up fdma_resize()
> for MTU changes makes it reachable at runtime. Can the lan969x resize
> double free an RX page?
> 
> Once the page belongs to the skb, lan969x_fdma_rx_get_frame() clears
> the slot with:
> 
> 	rx->page[fdma->dcb_index][fdma->db_index] = NULL;
> 
> This tells lan969x_fdma_free_pages() that the driver no longer owns the
> page. The free_page path is taken when WARN_ON(!port) triggers or
> build_skb() returns NULL. There, the page is handed back with
> page_pool_recycle_direct(), but the rx->page[][] slot still points at
> it.
> 
> lan969x_fdma_napi_poll() then breaks out without advancing dcb_index
> or refilling the descriptor. The next poll processes the same, already
> recycled, page again.
> 
> On an MTU change, lan969x_fdma_resize() -> lan969x_fdma_rx_free() ->
> lan969x_fdma_free_pages() calls page_pool_put_full_page() on every
> non-NULL rx->page[i][j]. That returns the recycled page to
> rx->page_pool a second time.
> 
> Without the resize path, the ring was only freed from
> lan969x_fdma_deinit(). With ndo_change_mtu, a build_skb() failure
> under memory pressure followed by an MTU change is enough to corrupt
> the page pool.
> 
> Should the free_page path also clear the rx->page[][] slot, and reset
> or refill the descriptor so the poll loop moves past it? The
> underlying bug predates this series, so would it make sense to fix it
> separately for net?

Already pending on net (see answer on patch #2).

> 
> [Severity: Medium]
> Does sparx5_fdma_resize() end up allocating the whole replacement RX
> ring with GFP_ATOMIC?
> 
> sparx5_port_change_mtu() runs in process context under RTNL. But
> sparx5_fdma_resize() allocates the new ring through
> sparx5_fdma_rx_alloc() -> fdma_dcbs_init() -> fdma_dcb_add(), which
> calls sparx5_fdma_rx_dataptr_cb() for each of the 64 * 15 = 960
> buffers. That callback always allocates with GFP_ATOMIC:
> 
> 	skb = __netdev_alloc_skb(rx->ndev, fdma->db_size, GFP_ATOMIC);
> 
> With max_mtu now raised to 13982, db_size grows to roughly 14 KB. Each
> skb head becomes an order-2 allocation, and the replacement ring is
> around 15 MB. All of it is allocated while the old ring is still held.
> 
> GFP_ATOMIC can't enter direct reclaim or compaction. On a system that
> has been up for a while, this is likely to fail with -ENOMEM and make
> the MTU increase fail. It can also drain the atomic reserves that NAPI
> and interrupt handlers on all the other ports rely on.

Same as the GFP_ATOMIC comment on patch #6.

> 
> Could the gfp flags be passed down to the dataptr callback? Then the
> resize and init paths could use GFP_KERNEL, and only the refill from
> NAPI would keep GFP_ATOMIC.
> 
> [Severity: Low]
> Can an MTU increase fail here even though the current FDMA buffers
> already fit the new MTU?
> 
> When resize is true, sparx5_port_change_mtu() treats any fdma_resize()
> error as fatal. But sparx5_fdma_resize() skips the reallocation only
> when the size matches exactly:
> 
> drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c:sparx5_fdma_resize() {
>     ...
> 	db_size = sparx5_fdma_get_db_size(sparx5, port, new_mtu);
> 	if (db_size == rx->fdma.db_size)
> 		return 0;
> 
> 	rx_new = kzalloc_obj(*rx_new);
>     ...
> }
> 
> lan969x_fdma_resize() does the same with page_order:
> 
> drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c:lan969x_fdma_resize() {
>     ...
> 	page_order = lan969x_fdma_get_page_order(sparx5, port, new_mtu);
> 	if (page_order == rx->page_order)
> 		return 0;
>     ...
> }
> 
> Take port A at MTU 9000 and all other ports at 1500. Lowering A to 1500
> tries to shrink the buffers. If that allocation fails, the 9000-sized
> buffers are kept and MTU 1500 is published, as intended.
> 
> Then port B is raised to 3000. The needed db_size (or page_order) is
> smaller than the current one, so the driver allocates new, smaller
> rings. If that allocation also fails, the increase returns an error and
> B's MTU stays the same, even though the existing buffers would hold
> 3000-byte frames.
> 
> This doesn't match the commit message:
> 
>     If the buffers cannot be grown, the MTU is not changed.
> 
> Would a "needed > current" check on the grow path avoid this? Treating
> a failed shrink as non-fatal in this case would work too.
> 
> > +
> > +		/* The current, larger, buffers still fit all frames */
> > +		netdev_warn(dev, "Failed to resize FDMA buffers: %d\n", err);
> > +	}
> > +
> > +	WRITE_ONCE(dev->mtu, new_mtu);
> 
> [ ... ]
> 
> > @@ -250,6 +250,44 @@ static int sparx5_port_hwtstamp_set(struct net_device *dev,
> >  	return sparx5_ptp_hwtstamp_set(sparx5_port, cfg, extack);
> >  }
> >  
> > +static int sparx5_port_change_mtu(struct net_device *dev, int new_mtu)
> > +{
> > +	struct sparx5_port *port = netdev_priv(dev);
> > +	struct sparx5 *sparx5 = port->sparx5;
> > +	bool resize = new_mtu > dev->mtu;
> > +	int err;
> > +
> > +	/* Register based extraction sizes its skbs from the MTU at the time
> > +	 * a frame is read, so it cannot handle frames queued before an MTU
> > +	 * decrease.
> > +	 */
> > +	if (sparx5->fdma_irq <= 0)
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Never let the MAC accept frames larger than the RX buffers */
> > +	if (!resize)
> > +		sparx5_port_max_len_set(sparx5, port, SPX5_HW_MTU(new_mtu));
> > +
> > +	err = sparx5->data->ops->fdma_resize(sparx5, port, new_mtu);
> > +	if (err) {
> > +		if (resize)
> > +			return err;
> > +
> > +		/* The current, larger, buffers still fit all frames */
> > +		netdev_warn(dev, "Failed to resize FDMA buffers: %d\n", err);
> > +	}
> > +
> > +	WRITE_ONCE(dev->mtu, new_mtu);
> > +
> > +	sparx5_port_wm_update(sparx5, port);
> > +	sparx5_tas_gb_update(sparx5);
> > +
> > +	if (resize)
> > +		sparx5_port_max_len_set(sparx5, port, SPX5_HW_MTU(new_mtu));
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct net_device_ops sparx5_port_netdev_ops = {
> >  	.ndo_open               = sparx5_port_open,
> >  	.ndo_stop               = sparx5_port_stop,
> 
> [Severity: Medium]
> Doesn't this take away something that works today with register
> based extraction?
> 
> This affects systems where sparx5->fdma_irq <= 0: Sparx5 rev 0, no
> FDMA interrupt in the devicetree, or the fallback to xtr_irq. Without
> an ndo_change_mtu, __netif_set_mtu() just updates dev->mtu. Userspace
> can currently set any MTU in the [68, 1500] range that ether_setup()
> advertises.
> 
> With this patch, every such change returns -EOPNOTSUPP. Meanwhile,
> sparx5_register_netdevs() still leaves min_mtu at 68 and max_mtu at
> 1500 on these ports. Lowering the MTU for a tunnel, for example, used
> to work and now fails.
> 
> For the same reason, the commit message is not quite accurate when it
> says the MTU is currently fixed to 1500.
> 
> That said, lowering the MTU on the register based path isn't safe
> today either. sparx5_xtr_grp() allocates netdev->mtu + ETH_HLEN bytes,
> which already leaves out the FCS and any VLAN tags. It then copies
> extraction words into rxbuf until EOF without checking skb_tailroom().
> With the MAC maximum length still at 1518, a smaller dev->mtu lets a
> full sized frame overrun the skb.
> 
> Which behaviour is intended here? If MTU changes are not supported
> without the FDMA, would it be better to set min_mtu and max_mtu to
> ETH_DATA_LEN for these ports? The core would then reject the change,
> and the advertised range would match what the driver accepts.
> 
> Alternatively, could sparx5_xtr_grp() size its skbs from the MAC
> maximum frame length and bound the copy? Then the register based path
> could follow the MTU as well. Either way, the missing tailroom check
> probably deserves its own fix for net.

This is intended, and the commit message says so. Without the FDMA, a
lower MTU was never applied to the hardware.

> 
> -- 
> Sashiko AI review � https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-sparx5-mtu-change-v2-0-59c91357e8f6%40microchip.com
