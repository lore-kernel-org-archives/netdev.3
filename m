Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F7E3C343F;
	Thu,  8 Oct 2026 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454639; cv=none; b=C68TpsladSDUsAI3QLDtZV8noO4AVg5VcDVhUZBC9Yg70E5UX4krfE790DhrU+5qxlJpt8BqvVJZEYn8AGBK0t6ZdDcPTxZOqLkC8uC8nEuR4+fDJMk2Rwj9i2xL8w87dq/Hf/1d0JEyC+vzsMJN3pL13mPWoGqh+fQ38AW37tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454639; c=relaxed/simple;
	bh=SihtaINyOID8uG1KlVLPenKUnOkFdss2+wBjj62iuRE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dg6qxoqh2WuVGL3zUftOMoE8BUrn83Lg/08jScNw6150+gzc0mkBtP0oza4F3BSRxz8zNLQi740HTQqpUCC6+v01g42+lxBU+oB64PpTvkfkF9Qo8x0wZimbYmz+JGx5cJgyW5EY5ZC3jsnbLKPxQjcUx58ktZ/gHJ0RwLYjrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=qdcxXEnp; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="qdcxXEnp"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8210A05A9;
	Thu,  8 Oct 2026 12:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791454634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zwCBy0IQbOWYwtsXLIg8kK2ETq8UBESM6E7yQLafCrE=;
	b=qdcxXEnpWOwAml2Brfo87FZOxIwp5LxF6NI7C1gazr/YQvxNoD0/XfUECJyv3/p7IBXXAp
	UFycvrFrVGi7ZGAceWETBjohJzY07icFjOpTqygQjA7Q4WZK6sz6wPDEJvCJKupKB6rUgN
	YGAzyVqIgHAKTPizJAQ93pQ3sc2h24JiybqTOfTRplYEaU/DWfccBszGFV7DTZJeFqFj5G
	igE//BIKoHRCS4EEetYGi03V5hQxn1v1LjFN+fogF8RmsQS5SdOUPbGnhS6mVZGGZWoa8R
	ubaI6sAffJSWjdjDpc4xK9oX9nU0HzNEUQt2V1PXrMGdgWOIfcay14AjYYFmuQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 12:17:13 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Subject: Re: [PATCH net-next v3 7/8] net: bcmgenet: allow the MTU to be
 changed
In-Reply-To: <179145241567.434549.11505841771363424901@kernel.org>
References: <20261007-nb-genet-mtu-nn-v2-v3-7-74a796c019ce@tipi-net.de>
 <179145241567.434549.11505841771363424901@kernel.org>
Message-ID: <0832d7fb059b25c9a3fab7fb40ee2d18@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 8.10.2026 11:40, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [Medium] bcmgenet_change_mtu() leaves the PHY state machine running,
>   but it needs the MAC disabled while it reprograms the MAC.
> - [Low] At this commit, ENET_MAX_MTU (bcmgenet.c:90) and
>   bcmgenet_pkt_rdy_thld() (bcmgenet.c:2688) size one RX descriptor for 
> 2…
> - [Low] bcmgenet_change_mtu() leaves the PHY state machine running, but
>   bcmgenet_netif_stop() -> bcmgenet_intr_disable() (line 3596) writes…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the new
>   priv->datapath_up flag does not cover it.
> - [Medium] This problem wasn't introduced by this patch, but
>   bcmgenet_netif_stop() ignores the -ETIMEDOUT result of…
> 
> --
> 
> net: bcmgenet: allow the MTU to be changed
> 
> On GENET v2 and later, this commit sets dev->max_mtu from the RX packet
> ready threshold. It also adds an ndo_change_mtu handler that tears down 
> and
> rebuilds the DMA rings in place while the PHY keeps running. A new
> datapath_up flag lets bcmgenet_close() skip the teardown when a failed 
> MTU
> change has already taken the datapath down.
> 
> Link: https://github.com/raspberrypi/linux/issues/5561
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index 17c8318c20388..6d21ac2d78d51 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> @@ -84,6 +84,12 @@
>>  				      ENET_THLD_MAX * ENET_THLD_UNIT, \
>>  				      ENET_THLD_PAGE_LEN)
>> 
>> +/* Largest MTU that fits one descriptor, with room for a VLAN tag so 
>> a VLAN
>> + * interface can use the parent MTU.
>> + */
>> +#define ENET_MAX_MTU		(ENET_THLD_MAX_LEN - GENET_RBUF_ALIGN - \
>> +				 ETH_HLEN - VLAN_HLEN)
> 
> [Severity: Low]
> At this commit, ENET_MAX_MTU and bcmgenet_pkt_rdy_thld() both size one 
> RX
> descriptor as GENET_RBUF_ALIGN + mtu + ETH_HLEN + VLAN_HLEN. Meanwhile,
> bcmgenet_set_mtu_regs() programs the MAC limit with the larger
> ENET_FRAME_OVERHEAD:

Right, and as you have noticed patch 8 removes ENET_MAX_MTU and 
reassembles instead.
I can amend the commit message and mention hat the one descriptor limit 
is intermediate ...

> 
>     bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN(mtu), 
> UMAC_MAX_FRAME_LEN);
> 
> If the MAC accepts a frame that is bigger than one descriptor, for 
> example
> QinQ at the parent MTU, that frame spans two descriptors. Would it then 
> be
> dropped in bcmgenet_desc_rx()?
> 
>     if (unlikely(!(dma_flag & DMA_EOP) || !(dma_flag & DMA_SOP))) {
>         netif_err(priv, rx_status, dev,
>                   "dropping fragmented packet!\n");
> 
> The forwarded FCS case doesn't look reachable here. reset_umac() in 
> open
> clears CMD_CRC_FWD, and bcmgenet_set_features() then reads crc_fwd_en 
> back as
> 0. So only frames longer than the MTU plus one VLAN tag seem to be 
> affected.
> 
> The later patch in this series, "net: bcmgenet: reassemble jumbo frames 
> from
> status block fragments", removes ENET_MAX_MTU and replaces the drop 
> with
> bcmgenet_add_frag() reassembly. That means this only applies to the
> intermediate state at this commit.
> 
>> +
>>  /* Tx/Rx DMA register offset, skip 256 descriptors */
>>  #define WORDS_PER_BD(p)		(p->hw_params->words_per_bd)
>>  #define DMA_DESC_SIZE		(WORDS_PER_BD(priv) * sizeof(u32))
> 
> [ ... ]
> 
>> @@ -3605,7 +3612,11 @@ static int bcmgenet_close(struct net_device 
>> *dev)
>> 
>>  	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
>> 
>> -	bcmgenet_netif_stop(dev, false);
>> +	/* A failed MTU change can have torn the datapath down already */
>> +	if (priv->datapath_up) {
>> +		bcmgenet_netif_stop(dev, false);
>> +		priv->datapath_up = false;
>> +	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does datapath_up cover 
> the
> suspend/resume path?
> 
> Only bcmgenet_open() and bcmgenet_change_mtu() update the flag. The 
> non-WoL
> branch of bcmgenet_suspend() calls bcmgenet_netif_stop(dev, true). That
> disables the NAPIs and frees rx_cbs/tx_cbs in bcmgenet_fini_dma() 
> without
> NULLing the pointers, and it leaves datapath_up set.
> 
> If bcmgenet_resume() then fails in bcmgenet_init_dma():
> 
>     ret = bcmgenet_init_dma(priv, false);
>     if (ret) {
>         netdev_err(dev, "failed to initialize DMA\n");
>         goto out_clk_disable;
>     }
> 
> then the interface is still running, but it has no rings and 
> datapath_up is
> still 1. A later bcmgenet_close() from ifdown, unregister or shutdown 
> would
> call bcmgenet_netif_stop() a second time.
> 
> The NAPIs are already disabled at that point. Can napi_disable() in
> bcmgenet_disable_tx_napi() then spin forever with RTNL held? If it did
> return, bcmgenet_fini_dma() would kfree() rx_cbs and tx_cbs a second 
> time.
> 
> A failed bcmgenet_init_dma() on resume looks realistic. The earlier 
> patch in
> this series, "net: bcmgenet: pad transmit frames out of the packet 
> ready
> window", describes TX DMA refusing to halt so that every later
> bcmgenet_init_dma() fails. The RX buffers also come from
> page_pool_dev_alloc(), which doesn't sleep.
> 
> bcmgenet_change_mtu() adds another way to hit this, because it calls
> bcmgenet_netif_stop() without checking datapath_up.
> 
> Would clearing datapath_up in the suspend teardown, and setting it 
> again only
> after a successful resume, close this gap?

Will do.

> 
>> 
>>  	/* Really kill the PHY state machine and disconnect from it */
>>  	phy_disconnect(dev->phydev);
>> @@ -3853,6 +3864,71 @@ static int bcmgenet_change_carrier(struct 
>> net_device *dev, bool new_carrier)
>>  	return 0;
>>  }
>> 
>> +static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
>> +{
> 
> [ ... ]
> 
>> +	/* The watchdog trips on an idle queue once the rings are gone */
>> +	netif_device_detach(dev);
>> +
>> +	/* Only the buffers and the MTU registers change, leave the PHY up 
>> */
>> +	bcmgenet_netif_stop(dev, false);
> 
> [Severity: Medium]
> This is a pre-existing issue, but bcmgenet_netif_stop() ignores the
> -ETIMEDOUT result of bcmgenet_dma_teardown():

Yes, but can we please fix this in a separate patch / series? I already 
have
list of other issues from the new sashiko bug list, where this would fit 
in.

> 
>     bcmgenet_dma_teardown(priv);
> 
>     /* Disable MAC transmit. TX DMA disabled must be done before this 
> */
>     umac_enable_set(priv, CMD_TX_EN, false);
> 
> If RDMA or TDMA doesn't halt in time, bcmgenet_fini_dma() still returns 
> the
> RX pages to the page pool and destroys the pools. Hardware descriptors 
> may
> still point at those pages. Could the device then DMA into freed pages, 
> or
> read freed skbs on TX?
> 
> MAC RX is disabled before the teardown, so this needs a real halt 
> timeout to
> trigger. This new caller lets an admin run the teardown repeatedly with 
> ip
> link set mtu.
> 
>> +	priv->datapath_up = false;
>> +
>> +	WRITE_ONCE(dev->mtu, new_mtu);
>> +	priv->rx_buf_len = bcmgenet_rx_buf_len(new_mtu);
>> +	bcmgenet_set_mtu_regs(priv, new_mtu);
>> +
>> +	ret = bcmgenet_init_dma(priv, true);
> 
> [Severity: Medium]
> Is the MAC actually disabled at this point if the interface was opened
> without a link?

No, it is not. reset_umac() leaves CMD_SW_RESET set and 
umac_enable_set()
returns early while it is.

But IMHO the window is very narrow, as the MAC is held in reset, and the
link has to come up mid rebuild. Nothing serialises that, agreed.

> 
> After an open with no link, reset_umac() leaves CMD_SW_RESET set.
> umac_enable_set() returns early while that bit is set:
> 
>     if (reg & CMD_SW_RESET) {
>         spin_unlock_bh(&priv->reg_lock);
>         return;
>     }
> 
> So the CMD_RX_EN/CMD_TX_EN disable in bcmgenet_netif_stop() does 
> nothing.
> The PHY state machine keeps running and doesn't take RTNL. If the first
> link-up arrives during the teardown and rebuild,
> bcmgenet_mii_setup()->bcmgenet_mac_config() does:
> 
>     if (reg & CMD_SW_RESET) {
>         reg &= ~CMD_SW_RESET;
>         bcmgenet_umac_writel(priv, reg, UMAC_CMD);
>         udelay(2);
>         reg |= CMD_TX_EN | CMD_RX_EN;
>     }
> 
> bcmgenet_set_mtu_regs() is documented as "Call with the MAC disabled".
> Wouldn't it, along with the RBUF flush in bcmgenet_init_dma(), then run 
> while
> the MAC is receiving?
> 
> Nothing seems to serialize the adjust_link callback against this 
> window.
> reg_lock only covers single read-modify-write sequences.
> 
>> +	if (ret) {
> 
> [ ... ]
> 
>> +	bcmgenet_hfb_restore(priv);
>> +	bcmgenet_netif_start(dev, false);
>> +
>> +	/* bcmgenet_netif_start() only restores the link interrupt */
>> +	if (bcmgenet_has_mdio_intr(priv))
>> +		bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_MDIO_EVENT,
>> +					 INTRL2_CPU_MASK_CLEAR);
> 
> [Severity: Low]
> The PHY keeps running during the MTU change, but
> bcmgenet_netif_stop()->bcmgenet_intr_disable() also masks
> UMAC_IRQ_MDIO_EVENT. It is only unmasked here, after the whole teardown 
> and
> rebuild.
> 
> bcmgenet_mii_wait() depends on that interrupt to wake priv->wq:
> 
>     wait_event_timeout(priv->wq,
>                        !(bcmgenet_umac_readl(priv, UMAC_MDIO_CMD)
>                        & MDIO_START_BUSY),
>                        HZ / 100);
> 
> Would every phylib MDIO access in this window wait the full 10 ms 
> timeout
> while holding phydev->lock? bcmgenet_mii_wait() always returns 0, so 
> the
> effect looks like added latency rather than a failure.

It would, but bcmgenet_mii_wait() returns 0 either way, so it is added
latency during the MTU change and nothing more ...


> 
> [ ... ]
