Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B14334C5
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442933; cv=none; b=PEITdcHDebyMXDLqmUH4ZMkkt3LnBB4hdHrHSUe1jODtYy9dHaw3Yt4irbVHN0Gosj2gANnxywqKMgeRIrvB7wZtNtSIqZe8PiBXWwPpAUADmbmPgmKrDdWcw7cJD7Wg04RL4d1RJX7MKOsmw+3GubqYmtt4yE8cftMyqNYL/rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442933; c=relaxed/simple;
	bh=/6AUMIZeRBxlDUEZRogfSOe948t0zelhB9ITgCs98To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlvBzMEKIcpRcT0ZNpt1Q45R1X+hD9R4IyabdpSfNU8VF29LIqLzDjG1v05hwe9sRzmhKoO0YsXIv42vH2sJ9rb9u+bXVSATvW+iBb4Z1JPk73jhlIfj1jS4f8IoYd+P7lhAKsFZJj7vnpHKgzHY8xS2kSwMzDBPaU8zXG5Y9fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lHndeW7Q; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lHndeW7Q"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4654E4E41104;
	Tue, 11 Aug 2026 10:08:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 08A576033C;
	Tue, 11 Aug 2026 10:08:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D39FF11C4BE4F;
	Tue, 11 Aug 2026 12:08:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786442912; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=m9/67X/LTqY7+uC3dFrJVHFQgK16jDeYcGuHeHobhes=;
	b=lHndeW7QJdEGn4ZG//J7fO4qbmQ90K8+WMK73B6JHfnlhc800us7XKEmPwV0UJbQVOhMld
	aBsc2APDG5U/g2UZBQTES/0rByUDKlJWCKgWIRprK3lFt+JsIfENdmqR9BCFGmn+L7MoST
	nVFc7O7r/1Y0U8dEJCEM2UPotuad7C9EqFcktw6nwlbi5zpIi+zqKBRNLlab2RjEYCrwjm
	dHbu0mDuOUA3UvuhE1ulF8vckJblz0SSMuH1fSJGmDknJAH1unfLz+XZd81ScolRV2rThS
	Mgdh7cRmUxsax7proZmq2PfmnpdP0Dh6QRmuYkUOze/BVW2+rjz+BKw+WaZzPg==
Message-ID: <16c11b73-7d38-4856-9100-d27993ae0fa3@bootlin.com>
Date: Tue, 11 Aug 2026 12:08:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: keep gso_enabled_types in sync with
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
References: <20260808-stmmac-fix-tso6-features-v1-1-f82b17595052@oss.qualcomm.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260808-stmmac-fix-tso6-features-v1-1-f82b17595052@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 8/8/26 20:00, Lorenzo Bianconi wrote:
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

Thanks for tackling this :)

> 
> Fixes: 2e4082e4b739 ("net: stmmac: simplify GSO/TSO test in stmmac_xmit()")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 24 ++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a71f0df26378..3d3042afcdf4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4371,16 +4371,18 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
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
> +	priv->gso_enabled_types = 0;
> +
> +	if (features & NETIF_F_TSO)
> +		priv->gso_enabled_types |= SKB_GSO_TCPV4;
> +	if (features & NETIF_F_TSO6)
> +		priv->gso_enabled_types |= SKB_GSO_TCPV6;
> +	/* Manage oversized UDP frames for GMAC4 devices */
> +	if (features & NETIF_F_GSO_UDP_L4)
> +		priv->gso_enabled_types |= SKB_GSO_UDP_L4;
>  }

Sashiko says this could be racy, as there's a short window where the enabled_types is 0.

Maxime

