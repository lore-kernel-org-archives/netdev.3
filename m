Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11C0388396
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888211; cv=none; b=tHIWjo6u3ovuaWF4223kukKdcL+2JjKHtLqPbZOyvf1oa8J5lsOq2HwwArEwWpqNK7zx8aI2pxx3/R0AF98diL6uZFJ/+ZYBVKAk6E5ggfr9eRl/jIm22y29K5VY+gri0ihKK4KlqHOevZ1FYlP4O7OF6xnGgGvkl572+Uj8wao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888211; c=relaxed/simple;
	bh=tgFp567zqoC/vWH4jrI5Tw4AAm+vPbmDSpC84qhGZ0Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFjQ6UGI8F3lhnINzHUheA2reJzWe+DKDLlIflVzDYWb+fgYOS+l3fgB/kBNd8/iDHTdQV0jQdFzAZmplANgnT6xFfIdUz0hfIgy6JFOSCK4GjVcrQqM/E0UGdILQDy47KrMAmxsEaxgvNN82uYLBrb5L2rcmRhf9/o0Y3mqlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ae4N6meB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ae4N6meB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791888209; x=1823424209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tgFp567zqoC/vWH4jrI5Tw4AAm+vPbmDSpC84qhGZ0Q=;
  b=Ae4N6meBIJlkz++lFQ0XMLiBPX0JyO0hoDFZuOBKmMts0uslKBnTWV4Z
   HcaKFbSwRvkehorLk5T9qjtAc0GURuTZSpQMR2vRQvnF8eN37XFwcd0W0
   KxPKWFBCRfchxlkUifIDTqMeB7RQbMPYqbD+TddnouRTP7OQUc7YDsKHF
   8cHyvw/74X0znSPdh4DKPojnyItMuNglQUAhnAAweQo1j0WSVlN4PNDc/
   KjA9NooHPlZkqW7EeHN/hh/8z5MxvflWf+UYfzueJkA5WPkgd+A93NEgr
   5zzH1O1R5tYCdORw5pru/Q7/SdjKz7La4PVhpbFu367wOtIHMCCbb4Jud
   g==;
X-CSE-ConnectionGUID: mdYmmJoFRxys8NdynXBmww==
X-CSE-MsgGUID: rlSoBSxSTK6bcsPGvC9yww==
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="232041531"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2026 03:43:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 13 Oct 2026 03:43:28 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 03:43:26 -0700
Date: Tue, 13 Oct 2026 12:43:25 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Davide Caratti <dcaratti@redhat.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Daniel
 Thompson <daniel@riscstar.com>
Subject: Re: [PATCH net-next] net: stmmac: fix mqprio and cbs combination
Message-ID: <20261013104325.j526p5yurc5zmzhn@DEN-DL-M70577.microsemi.net>
References: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
 <20261013101031.42ilxihghwsivccm@DEN-DL-M70577.microsemi.net>
 <as4GJdF8oD_8FsGI@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <as4GJdF8oD_8FsGI@lore-desk>

> On Oct 13, Daniel Machon wrote:
> > Hi Lorenzo,
> > 
> > Just a question:
> > 
> > > The channel-mode mqprio offload and the CBS offload can currently not be
> > > enabled at the same time. tc_mqprio_validate_chan_mode() refuses the
> > > mqprio offload as soon as any TX queue is configured in AVB mode, and
> > > tc_setup_cbs() refuses to enable CBS while the strict-priority scheduler
> > > is active. As a result the combination is rejected whichever order the
> > > two are configured in.
> > > 
> > > The strict-priority scheduler selected by the channel-mode mqprio
> > > offload and the per-queue CBS shaper are independent MTL settings and do
> > > not conflict, so drop the checks and let the combination be offloaded.
> > > The following configuration, which was previously refused, now works:
> > 
> > Looks to me like these checks are shared by multiple cores. Are the MTL settings
> > independent on all of them?
> 
> Can you please explain what you mean?
> What I mean with this patch is we can have a given queue (e.g. queue X)
> configured in MTL_QUEUE_AVB mode and another one (e.g. queue Y) configured
> in MTL_QUEUE_DCB mode.

Sorry for being vague. I meant the MAC cores. So, dwmac510_tc_ops is being used
by GMAC, XGMAC, XLGMAC. My question was whether the claim that the commit
description gives (per-queue CBS shaper are independent MTL settings) apply to
all of these 3?

> 
> Regards,
> Lorenzo
> 
> > 
> > > 
> > >   $ tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc 4 \
> > >         map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
> > >         queues 1@0 1@1 1@2 1@3 mode channel hw 1
> > >   $ tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
> > >         idleslope 800000 sendslope -1700000 hicredit 494 locredit -1049 offload 0
> > >   $ tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
> > >         idleslope 400000 sendslope -2100000 hicredit 247 locredit -1296 offload 1
> > >   $ tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
> > >         idleslope 200000 sendslope -2300000 hicredit 124 locredit -1419 offload 1
> > > 
> > > Fixes: 47891d501e34 ("net: stmmac: add tc mqprio hw queue priority offload")
> > > Tested-by: Daniel Thompson <daniel@riscstar.com>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  8 --------
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 16 ----------------
> > >  2 files changed, 24 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index 56d89a696272..51d502930219 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -7740,14 +7740,6 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
> > >  	    tx_cnt < priv->xmit_qdisc.num_tx_queues)
> > >  		return -EINVAL;
> > >  
> > > -	if (priv->xmit_qdisc.prio_offload) {
> > > -		for (i = priv->plat->tx_queues_to_use; i < tx_cnt; i++) {
> > > -			if (priv->plat->tx_queues_cfg[i].mode_to_use ==
> > > -			    MTL_QUEUE_AVB)
> > > -				return -EINVAL;
> > > -		}
> > > -	}
> > > -
> > >  	if (netif_running(dev))
> > >  		stmmac_release(dev);
> > >  
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > > index ea1f97d6f0bd..175236ba379d 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > > @@ -346,9 +346,6 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
> > >  	if (!priv->dma_cap.av)
> > >  		return -EOPNOTSUPP;
> > >  
> > > -	if (qopt->enable && priv->xmit_qdisc.prio_offload)
> > > -		return -EOPNOTSUPP;
> > > -
> > >  	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
> > >  
> > >  	if (qopt->enable) {
> > > @@ -1340,7 +1337,6 @@ static void tc_mqprio_config_queue_prio(struct stmmac_priv *priv,
> > >  static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
> > >  					struct tc_mqprio_qopt_offload *mqprio)
> > >  {
> > > -	struct plat_stmmacenet_data *pdata = priv->plat;
> > >  	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> > >  	int i;
> > >  
> > > @@ -1350,18 +1346,6 @@ static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
> > >  		return -EOPNOTSUPP;
> > >  	}
> > >  
> > > -	/* Forcing strict priority conflicts with the CBS algorithm
> > > -	 * of AVB queues, so reject the offload when any queue is
> > > -	 * configured as AVB.
> > > -	 */
> > > -	for (i = 0; i < pdata->tx_queues_to_use; i++) {
> > > -		if (pdata->tx_queues_cfg[i].mode_to_use == MTL_QUEUE_AVB) {
> > > -			NL_SET_ERR_MSG_MOD(mqprio->extack,
> > > -					   "SP conflicts with AVB queues");
> > > -			return -EOPNOTSUPP;
> > > -		}
> > > -	}
> > > -
> > >  	for (i = 0; i < qopt->num_tc; i++) {
> > >  		/* The offload switches the MTL scheduler to strict
> > >  		 * priority, which only supports a 1:1 TC to TX queue
> > > 
> > > ---
> > > base-commit: d0bd617658ddfa5a115e64d1ab687bf155f6331f
> > > change-id: 20261012-stmmac-mqprio-cbs-combo-341f12749ce2
> > > 
> > > Best regards,
> > > -- 
> > > Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > > 
> > 
> > /Daniel


