Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A044D011
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139796; cv=none; b=fJPBrz6Hj9+YIez7oQz5J9BCXvionK83yZKq0P43k2VPaLb5SNGsO8ON/K2W7xF13CrhGyuoT2o0lARYvG2g9OvvjLzqiLorlsxx8yuoGiDFYAIB26uu7uIXqqNRqQFMtkPAGxu6qE4Ask4zJ54BPLzgeiPkXolAK1jxJIXpU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139796; c=relaxed/simple;
	bh=StJjy0C9BWxK98ZOBNDZhFkflNBlfdLlrrWM6aH5yAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQIn+oRAmhIfYSgfr5zKq8B8ltHQGJs8U4zsX5dMcqMYU0s7qgjv7QG1GgDh1JORH8UI47xb1QGddXJFxX/XrVEh+yreXSVwcdH4SepzMdy0JY63r/jvbDo8sTIEn55pqE5juIC/cf8Zl5AsFS8r67XcO7I6gPfCsUcvBUH0XJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozpvagrX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozpvagrX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47362928f65so834038f8f.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 04:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787139789; x=1787744589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0sUtDWWrBuLBYeXflMrDQ1PrQN1toh5DB1spcY7iwTw=;
        b=ozpvagrXmnJbtiemRsi5ZluD6YZh90qZ0o4ik/gxFIz4HhoXhIGiAQdCKIghhZtnti
         1uw9mVi14Qliefht4jr/qKcy2QvcZ67/2BzODkzulWhc6GEmdLHcncqg4tkjQjEJHeJh
         hR8/gfwl7RCXveEZLf9glhp1uvTMFZIrK2N0jmAXD3L87INALQ4czVtE89HT30E6fMBo
         cGcO+/SWpcMmvLug2e3+H1gK8F4O4Ec9ObLf4MmvDBLOFa4R/v813cwS6hQWSxT02LI8
         rbFpOdu9yp7SoQCmmZTUYu7S8K26fRdYj3CfCu0rz4DCBEjSIyE4Rp3mOREkgGA5RKdx
         KbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787139789; x=1787744589;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0sUtDWWrBuLBYeXflMrDQ1PrQN1toh5DB1spcY7iwTw=;
        b=jio19ku0t1r0hrVwxtGy2aTkwGibWnkv6S2/rrxjbsWbJLuRJ69LkgEEeZCr6RS/ec
         /LBR8Fm1mQ1y7nRgzzTnQ2erIMCXGqpPTqZIdjzGfF17iQsF9AaqjQL84Zy0TqaOEI6x
         ByaltTb9y7BYkuy976jsUDEEbIH3RzQSXBJiEFmAvfvK7ab0KQOd7gI2VvPwbP0cHHSZ
         6TKP2QXcxe8UUasB1RwK5la9nAeA2kRS2p+smXqwiiqxFD9FrSWWecDiK9/hQM2PKHwI
         QgLct9Ch8b6uHbB09Cl0SpqIRBTCI8LeFVE4h25VxVVIsRweO7jYYzNg9wi4DPy6XU6f
         xJIw==
X-Forwarded-Encrypted: i=1; AHgh+RoTwLTsUrqvrUb/1MtaXtT+YpmyUBvkTUZBKaRSXZNwwGYjqpOmfqf3MAspPhyN8iDcOpfavMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKWhT7ae04oVA0eXZepRwQZ7MSDdEYS2vleW0WrwwDWjU0UIEU
	dHTD5b+CrGKruMXeVgfusECSDnqmHSjEH5DLXEnHzYkcdftzkX9KAPTq
X-Gm-Gg: AR+sD102l8zervgKoqS+4uvfwBfd8vUZsYytZU/Ot1DbFw34XvUkbttyyVq/ya19rur
	lTb0M/GhuJ2OvktpyaH/6cItuC5m7lMSB3ReHvRQ4aeO0xtPr5ucTsL6ruPXPlAK84tUS00rThw
	ZdZd/1aJiLHV9aONgI2CwGwhie/GfEvdJ1Tb4tWIwtehi/LjQxAUxN9w/XR5sEOuHP02IqTXLvn
	FvnpEWus6J5rVMJFNAgQCINTu46iNNhnTxfgr90vyvzhQ2n6806ZmOy9BIUXKZpxYIsAlN/Y3uP
	2KF4j6uQPzxZySvxmv0thi/LqA32g3bfuSjQaQBvmX5+plED7kTpuHo0bHlTMQmiSRCupkrKzmk
	RQsfSk90B9IlanHOxnzttdGo/05+FBCNEV23CuEucudZcEEul/4Vgy1IOMCjyiFGDex+kQ4f1qD
	POWP0RJAqlg3YmFww5jqG8Xc6uj/7SF5PkPu1EGtIzMCFA0yStueEXGIcYgwqk2vJqAfs4gCVb+
	vVSDa/3pPuBbnvKbudk2//OZQ==
X-Received: by 2002:a05:600c:37c6:b0:499:9eb7:4558 with SMTP id 5b1f17b1804b1-499aa1e43b7mr77034095e9.10.1787139788723;
        Wed, 19 Aug 2026 04:43:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa175d0fsm57258445e9.9.2026.08.19.04.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 04:43:08 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:43:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: James <aslan.jnn@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, Prashanth Kumar K R
 <PrashanthKumar.K.R@amd.com>, netdev@vger.kernel.org,
 Thomas.Lendacky@amd.com
Subject: Re: [PATCH net] net: amd-xgbe: support receiving packets with bad
 FCS
Message-ID: <20260819124307.7a9ec5e6@pumpkin>
In-Reply-To: <20260812091616.35811-1-aslan.jnn@gmail.com>
References: <20260812091616.35811-1-aslan.jnn@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 09:16:16 +0000
James <aslan.jnn@gmail.com> wrote:

> From: James Nugraha <aslan.jnn@gmail.com>
> 
> The driver currently sets the MAC_RCR.DCRCC bit whenever RX is enabled.
> This disables hardware FCS validation, causing packets with a bad FCS to
> be accepted unconditionally. Users cannot control this behavior because
> the driver does not advertise NETIF_F_RXALL.

What actually happens to packets with bad FCS?
If FCS validation is actually disabled they'd get processed as valid packets.
That would be a serious bug.
OTOH the rx status could contain an 'fcs error' bit that causes the packet
be discarded and the software counts an error.
That would match the historic behaviour of many ethernet chips.

So neither the subject nor that text seems to be accurate.

With the bad packet (including its fcs) you can correct a single 18-bit error
burst - but I don't think anyone ever does that.

	David

> 
> Advertise NETIF_F_RXALL and disable it by default. Update DCRCC when the
> RXALL feature is enabled or disabled, and preserve the selected state
> across RX and link stop/start cycles.
> 
> Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
> Signed-off-by: James Nugraha <aslan.jnn@gmail.com>
> ---
> Tests:
> - Verified invalid-FCS packets are dropped with RXALL disabled.
> - Verified invalid-FCS packets are received with RXALL enabled.
> - Verified invalid-FCS packets are dropped again after RXALL is disabled.
> - Verified the RXALL setting survives RX stop/start.
> - Verified the RXALL setting survives link down/up.
> - Verified RXALL is disabled by default.
> 
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c  |  3 +--
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c  |  7 ++++++-
>  drivers/net/ethernet/amd/xgbe/xgbe-main.c |  7 +++++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index 1f350d3bd..ad2030517 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -3455,7 +3455,8 @@ static void xgbe_enable_rx(struct xgbe_prv_data *pdata)
>  	XGMAC_IOWRITE(pdata, MAC_RQC0R, reg_val);
>  
>  	/* Enable MAC Rx */
> -	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 1);
> +	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC,
> +			   !!(pdata->netdev->features & NETIF_F_RXALL));
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 1);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 1);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 1);
> @@ -3466,7 +3467,6 @@ static void xgbe_disable_rx(struct xgbe_prv_data *pdata)
>  	unsigned int i;
>  
>  	/* Disable MAC Rx */
> -	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 0);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 0);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 0);
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 0);
>  
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index 3a79fd054..5fb81bea1 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -2247,13 +2247,14 @@ static int xgbe_set_features(struct net_device *netdev,
>  {
>  	struct xgbe_prv_data *pdata = netdev_priv(netdev);
>  	struct xgbe_hw_if *hw_if = &pdata->hw_if;
> -	netdev_features_t rxhash, rxcsum, rxvlan, rxvlan_filter;
> +	netdev_features_t rxhash, rxcsum, rxvlan, rxvlan_filter, rxall;
>  	int ret = 0;
>  
>  	rxhash = pdata->netdev_features & NETIF_F_RXHASH;
>  	rxcsum = pdata->netdev_features & NETIF_F_RXCSUM;
>  	rxvlan = pdata->netdev_features & NETIF_F_HW_VLAN_CTAG_RX;
>  	rxvlan_filter = pdata->netdev_features & NETIF_F_HW_VLAN_CTAG_FILTER;
> +	rxall = pdata->netdev_features & NETIF_F_RXALL;
>  
>  	if ((features & NETIF_F_RXHASH) && !rxhash)
>  		ret = hw_if->enable_rss(pdata);
> @@ -2284,6 +2285,10 @@ static int xgbe_set_features(struct net_device *netdev,
>  	else if (!(features & NETIF_F_HW_VLAN_CTAG_FILTER) && rxvlan_filter)
>  		hw_if->disable_rx_vlan_filtering(pdata);
>  
> +	if ((features & NETIF_F_RXALL) != rxall)
> +		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC,
> +				   !!(features & NETIF_F_RXALL));
> +
>  	pdata->netdev_features = features;
>  
>  	DBGPR("<--xgbe_set_features\n");
>  
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
> index 0e8698928..898146b67 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
> @@ -351,7 +351,8 @@ int xgbe_config_netdev(struct xgbe_prv_data *pdata)
>  			      NETIF_F_GRO |
>  			      NETIF_F_HW_VLAN_CTAG_RX |
>  			      NETIF_F_HW_VLAN_CTAG_TX |
> -			      NETIF_F_HW_VLAN_CTAG_FILTER;
> +			      NETIF_F_HW_VLAN_CTAG_FILTER |
> +			      NETIF_F_RXALL;
>  
>  	if (pdata->hw_feat.rss)
>  		netdev->hw_features |= NETIF_F_RXHASH;
> @@ -382,2 +382,4 @@ int xgbe_config_netdev(struct xgbe_prv_data *pdata)
>  	netdev->features |= netdev->hw_features;
> +	/* disable RXALL by default */
> +	netdev->features &= ~NETIF_F_RXALL;
>  	pdata->netdev_features = netdev->features;
> 

