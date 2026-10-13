Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0265D390CB7
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886237; cv=none; b=DPcC18lk1gc4otmKzYM4nJbRF1MS+8dMtGSsJi9NKDANY3GNpENJOGulT+znEEM/AEJMMQApLAUootJOpmmbzOUymKf88oTF0w0m27cUU548bzP9+u9Pnld9cfonFF1Bq3LNPYXFmQrQi/f5lxWJQlOmK1RPQ2fWrfklXFqKsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886237; c=relaxed/simple;
	bh=qypXU8l+IYxIJuy8OiLCdws+Ijm1skroyyk0l/KNgCc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPIQ855sQQJGxtjmf0cLfX1VASgrc+JaYXKLuvHL1gjVuaExo4B/HjDQbvm2AuhlmIP3bcRUKPM/nh8PjJ4jBUSxvzfrzzUCEaQE+CxDsLEcxxo0ZPXrwIRHiCitiXnxoRYUmyWS+iIBrQ/SK398nFD8kh4wTHIjrwSbz/IFIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aW0FgYsW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aW0FgYsW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791886235; x=1823422235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qypXU8l+IYxIJuy8OiLCdws+Ijm1skroyyk0l/KNgCc=;
  b=aW0FgYsWO5Ws+25PAZXVb75NreOeNpqezLitx25P6uPPlC+/hAus2gO8
   Y0DCNXFQkKC9v1ryrb/s8MqlqXyo51z78Cji4elMvvwGY6PQl7aB412KU
   wCb20nPDBT95+IM+2WjlnlsesVdl6hFulX7xz0creFjPbyvYv86BT3zDc
   dku7twb+kjmo5aax2qmycgHTKVgImp+5wZ4clfre0/7ImY/LTJ1bGz8sJ
   T2xYI8Wd8C55qYLprk15R/+b+zFnuDhMPdm2blCmmzLZZFHZvGQFMzdcC
   wk2rNMMrmb+bx49eIU454AR+n5ZY+Bgds1cVqwWeoAiw+kZ5LwDjHe53s
   g==;
X-CSE-ConnectionGUID: iW/JPDAwQJeXFemJYbeI2w==
X-CSE-MsgGUID: IaLE7yBiQH+fVeO0+HD9zA==
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="64006529"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:10:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 13 Oct 2026 03:10:34 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 03:10:32 -0700
Date: Tue, 13 Oct 2026 12:10:31 +0200
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
Message-ID: <20261013101031.42ilxihghwsivccm@DEN-DL-M70577.microsemi.net>
References: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>

Hi Lorenzo,

Just a question:

> The channel-mode mqprio offload and the CBS offload can currently not be
> enabled at the same time. tc_mqprio_validate_chan_mode() refuses the
> mqprio offload as soon as any TX queue is configured in AVB mode, and
> tc_setup_cbs() refuses to enable CBS while the strict-priority scheduler
> is active. As a result the combination is rejected whichever order the
> two are configured in.
> 
> The strict-priority scheduler selected by the channel-mode mqprio
> offload and the per-queue CBS shaper are independent MTL settings and do
> not conflict, so drop the checks and let the combination be offloaded.
> The following configuration, which was previously refused, now works:

Looks to me like these checks are shared by multiple cores. Are the MTL settings
independent on all of them?

> 
>   $ tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc 4 \
>         map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
>         queues 1@0 1@1 1@2 1@3 mode channel hw 1
>   $ tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
>         idleslope 800000 sendslope -1700000 hicredit 494 locredit -1049 offload 0
>   $ tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
>         idleslope 400000 sendslope -2100000 hicredit 247 locredit -1296 offload 1
>   $ tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
>         idleslope 200000 sendslope -2300000 hicredit 124 locredit -1419 offload 1
> 
> Fixes: 47891d501e34 ("net: stmmac: add tc mqprio hw queue priority offload")
> Tested-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  8 --------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 16 ----------------
>  2 files changed, 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 56d89a696272..51d502930219 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7740,14 +7740,6 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
>  	    tx_cnt < priv->xmit_qdisc.num_tx_queues)
>  		return -EINVAL;
>  
> -	if (priv->xmit_qdisc.prio_offload) {
> -		for (i = priv->plat->tx_queues_to_use; i < tx_cnt; i++) {
> -			if (priv->plat->tx_queues_cfg[i].mode_to_use ==
> -			    MTL_QUEUE_AVB)
> -				return -EINVAL;
> -		}
> -	}
> -
>  	if (netif_running(dev))
>  		stmmac_release(dev);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index ea1f97d6f0bd..175236ba379d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -346,9 +346,6 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  	if (!priv->dma_cap.av)
>  		return -EOPNOTSUPP;
>  
> -	if (qopt->enable && priv->xmit_qdisc.prio_offload)
> -		return -EOPNOTSUPP;
> -
>  	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
>  
>  	if (qopt->enable) {
> @@ -1340,7 +1337,6 @@ static void tc_mqprio_config_queue_prio(struct stmmac_priv *priv,
>  static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
>  					struct tc_mqprio_qopt_offload *mqprio)
>  {
> -	struct plat_stmmacenet_data *pdata = priv->plat;
>  	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
>  	int i;
>  
> @@ -1350,18 +1346,6 @@ static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	/* Forcing strict priority conflicts with the CBS algorithm
> -	 * of AVB queues, so reject the offload when any queue is
> -	 * configured as AVB.
> -	 */
> -	for (i = 0; i < pdata->tx_queues_to_use; i++) {
> -		if (pdata->tx_queues_cfg[i].mode_to_use == MTL_QUEUE_AVB) {
> -			NL_SET_ERR_MSG_MOD(mqprio->extack,
> -					   "SP conflicts with AVB queues");
> -			return -EOPNOTSUPP;
> -		}
> -	}
> -
>  	for (i = 0; i < qopt->num_tc; i++) {
>  		/* The offload switches the MTL scheduler to strict
>  		 * priority, which only supports a 1:1 TC to TX queue
> 
> ---
> base-commit: d0bd617658ddfa5a115e64d1ab687bf155f6331f
> change-id: 20261012-stmmac-mqprio-cbs-combo-341f12749ce2
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> 

/Daniel
