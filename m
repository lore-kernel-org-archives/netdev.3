Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FE85221DC;
	Wed, 30 Sep 2026 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805097; cv=none; b=CvbEPT6yN6r7hEiAmAaMCP1LCk6FkDIjp38CfE1/7qgdYOyXJ8+Wbum/2C+rhsA1M021OUNe5YR9x01HeH3zWsjV0mzo6v4nZzyyA/wv64j0b03wgPz9bNrjO+EI3tMQIbi1RhXB96NyTSJSx64H8HVhUqATblCX2/TVIv3UhZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805097; c=relaxed/simple;
	bh=exmeiMuuq+vo1S+JtVvCfGPRaAN3bi+jqUDLwbtc2NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTePOPYCoNovbbkkYkybfaztS09iqhhAiOOl0IxLfcmrYofzLIVS7WS2dwmIWLGeMkJjfpzmbueDFZO8TaJYpB7fyDkZ5PT/XTGJYYzWDJljXGdOdscyr5Dz20SehQt7P9XtqrULi066g+l2TlUcwofkq9Okq9HAnOLgkODmHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WYNB4EVj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WYNB4EVj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A16441A1088;
	Wed, 30 Sep 2026 21:51:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6248160749;
	Wed, 30 Sep 2026 21:51:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0101A103298BA;
	Wed, 30 Sep 2026 23:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790805089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vzOGn7kFlOHjQR1OKolnS+9aTa51YUymd+DOFjdZtfU=;
	b=WYNB4EVjUV26HzXoImOdERlNMCi/1F9FbbLdz0J/n2iIQHFWJkLmVhws7pZFdkoirpeMeE
	WHtF1qJ5uvZFz1Kd/bEIUbw2wsw1ccZIe6g9UfGBMwSW6L4T4Caj1jEyHxUWd8Oc02Mrqh
	NGa//iMhbHpvs0aMbrwvmBMrfjKsO/fDcFmdBI8dhYo54rNcY3NoZbl9Nt3zfFzwONIW7f
	ESdHMirkK90aVAJo+ssgPAb+VNSYYyNjIbgc3KGTKRwT+4ixZiflaXi0UXzGo2IzgiSMW2
	Cms65QhZENJcWqxNEz61EDnq/Wlzlcdv18z9/Th+haP4PFQyB9eb7ZH0FL9XAQ==
Message-ID: <f99b6e1c-c37e-4356-b6cb-e13a4eab059d@bootlin.com>
Date: Wed, 30 Sep 2026 23:51:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 5/5] net: stmmac: Disable S-Tag processing on
 dwmac4
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, recv.jo@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, jun.ann.lai@intel.com,
 yi.fang.gan@intel.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260928203441.34876-1-ovidiu.panait.rb@renesas.com>
 <20260928203441.34876-6-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260928203441.34876-6-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/28/26 22:34, Ovidiu Panait wrote:
> Currently, hardware VLAN stripping is broken for 802.1ad tags. vlan_rx_hw()
> hardcodes ETH_P_8021Q when putting the hardware tag into the skb, rather
> than using the actual protocol from the packet. Because of this, packets
> that contain a 802.1ad outer tag are incorrectly passed up the stack as
> having an 802.1Q tag. This causes QinQ ping between two hosts to fail.
> 
> vlan_rx_hw() is shared by dwxgmac2 and dwmac4: on dwxgmac2 the tag type
> is available in the RDES3 write-back descriptor (the ET_LT field), so the
> outer tag type can be determined based on that info. However, dwmac4
> doesn't seem to provide the tag type. The Length/Type field in RDES3 only
> indicates whether the packet is single or double-tagged, not which tag
> type was stripped.
> 
> Since dwmac4 cannot report the stripped tag type, it cannot support
> hardware S-Tag stripping correctly. Therefore, restrict the
> NETIF_F_HW_VLAN_STAG_RX and NETIF_F_HW_VLAN_STAG_FILTER advertisement
> to dwxgmac2 only.
> 
> With this, 802.1ad tags are left in place and handled by the software
> VLAN path.
> 
> Fixes: 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN stripping")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

I ran your proposed QinQ selftests on stm32mp157a (dwmac4), and it correctly
fixes the problem on that core.

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> v6 changes: None.
> 
> v5 changes:
> - Rebased on top of latest changes.
> - Added Reviewed-by tag from Maxime.
> 
> v4 changes:
> - Dropped all "double VLAN" references from the commit title/message.
> - Rebased on top of the S-VLAN rework.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b007ff120471..5af245fd9ba0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6211,7 +6211,7 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
>  	if (priv->plat->bugged_jumbo && (dev->mtu > ETH_DATA_LEN))
>  		features &= ~NETIF_F_CSUM_MASK;
>  
> -	if (dwmac_is_xmac(priv->plat->core_type)) {
> +	if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
>  		if (features & NETIF_F_HW_VLAN_CTAG_RX)
>  			features |= NETIF_F_HW_VLAN_STAG_RX;
>  		else
> @@ -7990,14 +7990,18 @@ static int __stmmac_dvr_probe(struct device *device,
>  	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
>  #ifdef STMMAC_VLAN_TAG_USED
>  	/* Both mac100 and gmac support receive VLAN tag detection */
> -	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
> +	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
> +	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
> +		ndev->features |= NETIF_F_HW_VLAN_STAG_RX;
> +
>  	if (dwmac_is_xmac(priv->plat->core_type)) {
>  		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
>  		priv->hw->hw_vlan_en = true;
>  	}
>  	if (priv->dma_cap.vlhash) {
>  		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> -		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
> +		if (priv->plat->core_type == DWMAC_CORE_XGMAC)
> +			ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
>  	}
>  	if (priv->dma_cap.vlins)
>  		ndev->features |= NETIF_F_HW_VLAN_CTAG_TX;

