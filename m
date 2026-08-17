Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27344E678
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997658; cv=none; b=DIDlhS0aaHhzMSYoi92crNnO6ilPGvRT0NQGSK2gMIdXMOVNavPwW9afO4pjNece/sc5agtZ8Rgb0rrGQFP6SQGwCyid12ylvfmfpQ4Q4N0m77npApRPExzfIQn10yj8nEK1ujZE04Q2vp1TVXGC9M79JuUTcqk/LZoX645HMTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997658; c=relaxed/simple;
	bh=939WFhqiOSa1udq2lJAIxWRChOZNkmSro8FEgNH8jGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXfa7Vvr+1adwzDpwIYnXiMb9arlzFq943XjU/AwMBxMrjFRjSKNu93d/bLy+DsMINenbwsH2k4EpgYH7wxzHkaPZjn67RhaZvqHx1BVnSPuyGkGbPe+FkwA0knlWKW0FZRo/e/4rzmgU5LBSO+CMLRm/73E5SjYq/ZRuYS/ZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlF9qY+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlF9qY+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EA01F000E9;
	Mon, 17 Aug 2026 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786997657;
	bh=LzDo4tCip7tML0cOu39bcJDTCn2tQGOUfV7WiNPRYwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RlF9qY+1mkQtzswGYaVaeetdd3Yn0Bb8KP+3jj04RD3M5/I1r+reUT7OnViAjSLYZ
	 56DeVM4GTu8eKILOcJEkE2/zB1sKe8y5RVSccGxVl/3pgq7Qn+lYGgz2l1zq+U0RWp
	 v1AyrLVvm6eNc8dRy6tFMbjwT2oVLhksronzmSTB51EpTSwp+rop+q2BKivp2LT8gG
	 eM+wwCLpQ/w6aescpANkRdOn+SO5qU8qUOsyTa1Dyn1dZpgSJCYMqTc6a/ruFaf+jS
	 jYSiMFKfJqcyJM98ok/H5Iwh1DeVBKS7rwdR9Y/eXPyyh258/tI71jgmvjAJy7o+NT
	 4WD4jZ5kkGM8w==
Date: Mon, 17 Aug 2026 13:14:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: keep gso_enabled_types in sync with
 netdev features
Message-ID: <20260817131416.409fc7fc@kernel.org>
In-Reply-To: <20260812-stmmac-fix-tso6-features-v2-1-72c3b06eb8d4@oss.qualcomm.com>
References: <20260812-stmmac-fix-tso6-features-v2-1-72c3b06eb8d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 06:38:13 +0200 Lorenzo Bianconi wrote:
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

Maybe I'm missing something but I don't see any device configuration
based on gso_enabled_types. Why does this mask exist in the first place?

Right now AFAICT packets which miss the mask check get chucked on the
wire as one giant frame, without segmentation.

Can we just delete gso_enabled_types completely? Stack should obey the
features for future frames, and avoiding races here may be hard.

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
-- 
pw-bot: cr
