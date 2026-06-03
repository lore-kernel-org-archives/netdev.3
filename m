Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43556379ED6
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487219; cv=none; b=AB+6VbRy3diXAQBFhXZkApYK0a3mGcZGnGfhHvAIi8CVRgR82t6FFBrzJQ7wjjsToLRciU8OHSNWq2NZeMvuARutaXxoKKLhSSqFDF2t4Ig50vwZUiI7ncWMJ1eH/wU9cEUXYveySAykt/+aaldGs+/BjZLPB/c0+UiU9MCRqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487219; c=relaxed/simple;
	bh=Sg5vOpBLcQZEQWTt1cDzFNBbX41QBEZVeh0M2O3ndKI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Or4M1pGVN2x2Lzsh1sgr4o+1WLZ6OTi4d6eaAFjkTDbRbTwhKhCX491Ki5jE7KYO8Y8gc3HaDfjkZx8mqid91qcOtYdggVU6JoyFLbAc2PSS6gQetpAbTRynYzlg0pNZvM1DTh2qJk/nf2ylllJJix+E+j4O4JigcQ/ltBtB9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TzOYTVTH; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TzOYTVTH"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260603114654euoutp02294ba004196c278b7fdbeaac28eb3f8c~1j7AtmqD92442724427euoutp02n
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 11:46:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260603114654euoutp02294ba004196c278b7fdbeaac28eb3f8c~1j7AtmqD92442724427euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780487214;
	bh=H9vbnWQJPQzIN0K4+Z07cBiAlIHEvHyV1Sid6ldBIIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TzOYTVTH2QVoNrzpIXitfRI91rJsmgDYU49Sq1xGVoTa3yWAiatibiYRxpdgxciVU
	 kInmvYIyOnbQ9jRPIr3B36g3ue0TsmIJKtG5Z7i01Rt433exE88eL5jM7Q9iJDmcPH
	 LvPSKfsCmdZyQIKoMQyD1zLhQ5FAl/ypWbqc840Y=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260603114654eucas1p221cf36265a6e0456c34c8f79352031ed~1j7AYZoCQ2038520385eucas1p2b;
	Wed,  3 Jun 2026 11:46:54 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260603114653eusmtip21cf8adefffc5fc690a7f4f877213aa8c~1j6-yni2P2847028470eusmtip2Y;
	Wed,  3 Jun 2026 11:46:53 +0000 (GMT)
Date: Wed, 3 Jun 2026 13:46:53 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com
Subject: Re: [PATCH net-next v2 1/3] net/stmmac/dwxgmac: Modify DMA
 functions for future hardware
Message-ID: <aiAULX7SlidVGmhq@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260601162537.553512-2-j.raczynski@samsung.com>
X-CMS-MailID: 20260603114654eucas1p221cf36265a6e0456c34c8f79352031ed
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="-----ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_ea055_"
X-RootMTR: 20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28
X-EPHeader: CA
X-CMS-RootMailID: 20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28
References: <20260601162537.553512-1-j.raczynski@samsung.com>
	<CGME20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28@eucas1p1.samsung.com>
	<20260601162537.553512-2-j.raczynski@samsung.com>

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_ea055_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Gonna respond to Sashiko comments.

> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > @@ -97,11 +97,19 @@ static void dwxgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
> >  static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
> >  				   u32 queue)
> >  {
> > +	const unsigned int numtc = hw->priv_data->dma_cap.numtc;
> > +	struct net_device *ndev = hw->priv_data->dev;
> >  	void __iomem *ioaddr = hw->pcsr;
> >  	u32 clear_mask = 0;
> >  	u32 ctrl2, ctrl3;
> >  	int i;
> >  
> > +	if (queue >= numtc) {
> > +		netdev_err(ndev, "%s: invalid TC queue %d, supported %d\n",
> > +			   __func__, queue, numtc);
> > +		return;
> > +	}
> Does this artificially restrict the configuration of valid RX queue priorities?
> It looks like the queue index is being compared against the number of
> traffic classes (numtc), which could prevent mapping priorities on valid
> queues greater than the number of traffic classes.
> [ ... ]

No. These registers just don't exist to support more.
Synopsys seems to have done this this way because there there is no free
space after XGMAC_RXQ_CTRL3.
So if this becomes a thing, we will have big new driver dwxgmac3.

> > @@ -246,8 +263,15 @@ static void dwxgmac2_set_mtl_tx_queue_weight(struct stmmac_priv *priv,
> >  					     struct mac_device_info *hw,
> >  					     u32 weight, u32 queue)
> >  {
> > +	const unsigned int numtc = priv->dma_cap.numtc;
> >  	void __iomem *ioaddr = hw->pcsr;
> >  
> > +	if (queue >= numtc) {
> > +		netdev_err(priv->dev, "%s: invalid TC queue %d, supported %d\n",
> > +			   __func__, queue, numtc);
> > +		return;
> > +	}
> > +
> Because dwxgmac2_set_mtl_tx_queue_weight() returns void and is invoked via
> the stmmac_do_void_callback() macro (which unconditionally returns 0), will
> this early return cause ETS qdisc queue weighting on higher queue indices
> to silently fail? 
> It appears userspace will receive a success code while the hardware is left
> unconfigured.
> [ ... ]

As talked in previous mailing, answer is yes, there will be error in dmesg,
but no fail, for very simple reason that we would need to rewrite A LOT to add
proper error handling.
I just hope that if user misconfigured this stuff they will read this error
and fix it rather than complain.

> > @@ -357,6 +388,8 @@ static void dwxgmac2_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
> >  			       unsigned int fc, unsigned int pause_time,
> >  			       u8 tx_cnt)
> >  {
> > +	const unsigned int numtc = hw->priv_data->dma_cap.numtc;
> > +	struct net_device *ndev = hw->priv_data->dev;
> >  	void __iomem *ioaddr = hw->pcsr;
> >  	u8 i;
> >  
> > @@ -366,6 +399,17 @@ static void dwxgmac2_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
> >  		for (i = 0; i < tx_cnt; i++) {
> >  			u32 value = XGMAC_TFE;
> >  
> > +			if (i >= numtc) {
> > +				netdev_err(ndev,
> > +					   "%s: invalid TC queue %d, supported %d\n",
> > +					   __func__, i, numtc);
> > +				/* This will skip all other wrong channels,
> > +				 * but triggering this is preceded by warnings
> > +				 * from other functions, so limit the spam.
> > +				 */
> > +				break;
> > +			}
> > +
> If the hardware supports up to 16 transmit queues but only 8 traffic classes,
> does breaking this loop at numtc skip TX flow control initialization for
> valid higher queues? 
> The XGMAC_Qx_TX_FLOW_CTRL registers appear to be per-queue rather than
> per-traffic-class.
> [ ... ]

No, queues are in order. If dynamic queues get implemented then maybe?
Depends how this will get implemenented.

> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 3591755ea30be..5917bf47c7de6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -4140,7 +4140,7 @@ static int __stmmac_open(struct net_device *dev,
> >  	u8 chan;
> >  	int ret;
> >  
> > -	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
> > +	for (int i = 0; i < priv->plat->tx_queues_to_use; i++)
> >  		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
> >  			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
> The tx_queue array inside struct stmmac_dma_conf is statically sized to
> MTL_MAX_TX_QUEUES (8). If priv->plat->tx_queues_to_use is dynamically set
> up to 16, does this cause an out-of-bounds access that corrupts adjacent
> memory?
> I see this is resolved later in the series by commit 9cc40baf0739 which
> increases the macro to 16. Could this intermediate step in the series break
> bisectability due to the buffer overflow?

Nah.

BR
Jakub Raczynski

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_ea055_
Content-Type: text/plain; charset="utf-8"


-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_ea055_--
