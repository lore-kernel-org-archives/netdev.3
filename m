Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF1377ECC
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519858; cv=none; b=fU+JonEdflJkmZu5jI7pGzVMWzzj3TaGU3gMJB2m7wFUs9nCSmaRlC9oJmvwO53DUQkfyAtwKtztifakhffS6L6EkdK6bQAYS+B/zOgJE5u5cGfnuy4P6h30n+YABmlhUILiz48eP6jCmC3E7b/B0OLp+KYrOUtSieCgpkDIJQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519858; c=relaxed/simple;
	bh=KFbP0ooGlRqFVs3NI6cxCcVWJW83FDOnN3Pc6sQclP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ch5NfkUZmf4skaZ41po4+l3Jz2kplEHFwfZdv45KlkWQn7u7uEPx3PBMJo5A40i3FGgUrO/fdyOb/X3vGhiu3jZtyUY4oRasKEc+sGRXwgkNmmeCAbyh/9/EQkNu705EhDVc7+cSnsnCDVHBe0RZ4TSbhx67w9eQ6u+F8G5q8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J19Y8uMc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J19Y8uMc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BB03F4E411D0;
	Wed, 12 Aug 2026 07:30:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E8656045E;
	Wed, 12 Aug 2026 07:30:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2DE011C4C8B6;
	Wed, 12 Aug 2026 09:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786519848; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=C263u9rVLW8LQm4gcIcoHLPBvXCdecVgr7UYaLA8USY=;
	b=J19Y8uMc8ZKcZpGlUAeQlNxM8ln6fgX7p1MmWs4xAPL0bMXd0OqQSz3fC5WBVt2NeJdPWx
	RAau+9Zjyt/NsfiKRCM84x6PeZj/UO6Kd6elSv5y12OthuXBeGNNJ3D9qGesJ6Eq84mlIv
	55rfky5D2Ig+K/KFGw5God0uOOXQnGeV+5kb1TspCH6gwqX7QM2ZEAeFhfdt9OCq94MmTv
	4lXGXVR3PqWRtPM5QsT2Wph2eB8kbgbw324T8ZM/XzeCem/0lvOa2HqZNpsKA/dz1agsSa
	ZcXBo18Z3EihV7e0Jn9/Q1zX3gYdzy/lKHRl55qXDWX6T/h/KGCy+kjVTlcxwA==
Message-ID: <8cbbe252-3339-47aa-be30-7415b47208f1@bootlin.com>
Date: Wed, 12 Aug 2026 09:30:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: keep gso_enabled_types in sync with
 netdev features
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260812-stmmac-fix-tso6-features-v2-1-72c3b06eb8d4@oss.qualcomm.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260812-stmmac-fix-tso6-features-v2-1-72c3b06eb8d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 8/12/26 06:38, Lorenzo Bianconi wrote:
> stmmac_set_gso_types() derives priv->gso_enabled_types all-or-nothing
> from NETIF_F_TSO, but stmmac_set_gso_features() advertises NETIF_F_TSO,
> NETIF_F_TSO6 and (on GMAC4) NETIF_F_GSO_UDP_L4 as independently
> toggleable features. Since netdev_fix_features() only ties TSO6 to the
> checksum features, disabling TSO (ethtool -K ethX tx-tcp-segmentation
> off) leaves TSO6 enabled in dev->features while gso_enabled_types
> becomes 0.
> 
> For a TCPv6 GSO skb the stack then keeps the frame unsegmented
> (NETIF_F_TSO6 is still set), stmmac_features_check() does not clear the
> GSO mask, and the stmmac_xmit() gate (gso_type & gso_enabled_types) is
> false, so the multi-MSS skb is transmitted through the ordinary
> descriptor path as a single oversized frame.
> 
> Derive each GSO type from its own feature bit instead, so the mask stays
> in sync with dev->features and TCPv6 (or UDP L4 on GMAC4) segmentation
> keeps working when only TSO is disabled.
> 
> Fixes: 9edfa7dab811 ("net: stmmac: enable TSO for IPv6")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> Changes in v2:
> - Fix possible race between stmmac_set_gso_types() and stmmac_xmit().
> - Fix fixes tag.
> - Link to v1: https://lore.kernel.org/r/20260808-stmmac-fix-tso6-features-v1-1-f82b17595052@oss.qualcomm.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++++++++++----------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a71f0df26378..df3549f55741 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4371,16 +4371,20 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
>  	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
>  }
>  
> -static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
> +static void stmmac_set_gso_types(struct stmmac_priv *priv,
> +				 netdev_features_t features)
>  {
> -	if (!tso) {
> -		priv->gso_enabled_types = 0;
> -	} else {
> -		/* Manage oversized TCP frames for GMAC4 device */
> -		priv->gso_enabled_types = SKB_GSO_TCPV4 | SKB_GSO_TCPV6;
> -		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
> -			priv->gso_enabled_types |= SKB_GSO_UDP_L4;
> -	}
> +	unsigned int gso_types = 0;
> +
> +	if (features & NETIF_F_TSO)
> +		gso_types |= SKB_GSO_TCPV4;
> +	if (features & NETIF_F_TSO6)
> +		gso_types |= SKB_GSO_TCPV6;
> +	/* Manage oversized UDP frames for GMAC4 devices */
> +	if (features & NETIF_F_GSO_UDP_L4)
> +		gso_types |= SKB_GSO_UDP_L4;
> +
> +	WRITE_ONCE(priv->gso_enabled_types, gso_types);
>  }
>  
>  static void stmmac_set_gso_features(struct net_device *ndev)
> @@ -4416,7 +4420,7 @@ static void stmmac_set_gso_features(struct net_device *ndev)
>  	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
>  		ndev->hw_features |= NETIF_F_GSO_UDP_L4;
>  
> -	stmmac_set_gso_types(priv, true);
> +	stmmac_set_gso_types(priv, ndev->hw_features);
>  
>  	dev_info(priv->device, "TSO feature enabled\n");
>  }
> @@ -4766,7 +4770,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  		stmmac_stop_sw_lpi(priv);
>  
>  	if (skb_is_gso(skb) &&
> -	    skb_shinfo(skb)->gso_type & priv->gso_enabled_types)
> +	    (skb_shinfo(skb)->gso_type & READ_ONCE(priv->gso_enabled_types)))
>  		return stmmac_tso_xmit(skb, dev);
>  
>  	if (priv->est && priv->est->enable &&
> @@ -6198,7 +6202,7 @@ static int stmmac_set_features(struct net_device *netdev,
>  			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
>  	}
>  
> -	stmmac_set_gso_types(priv, features & NETIF_F_TSO);
> +	stmmac_set_gso_types(priv, features);
>  
>  	if (features & NETIF_F_HW_VLAN_CTAG_RX)
>  		priv->hw->hw_vlan_en = true;
> 
> ---
> base-commit: 7b53449540502cb21b32bca62a6258e22cd97bbe
> change-id: 20260808-stmmac-fix-tso6-features-7fdc5e9448e2
> 
> Best regards,

