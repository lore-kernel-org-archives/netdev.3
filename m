Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025573815D8;
	Sat, 26 Sep 2026 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790448127; cv=none; b=hADq07YwMFZsyTqaf6kDzPaqT05kyYV1ARxV0Ce7su1PIr/ZA5f8CQo3/USZ3tmfBvHiWQ3DXSOcI8iyoGxXtn3LDzXqCjhfwiiy1DOgwBhgAIXq8ThDQ+ql/TbXg5IzimlEOb8d22alycWg21+G1AaMmNmi4lQ5TyFwCPXi0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790448127; c=relaxed/simple;
	bh=ZIn32NzRI1VK5eJrUKfPmD5egeEgzS7+iYpgvBHxN3g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nhwXrB6BxenWVdSZhhCPEJeDa+E1fvdxf3HtD2aQs8ALxWgWSctm5Q27ryharALMcqjJfr29LUqdBvEoE3p8s1ukNholnhVJ7czlsF1kJi7xn9VQmwfVA8rACIfXo1Im5+ebAho2heRSQjrJTkb/YZQG6iXQpYeTgCBUi0/aFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=1dsdev+J; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="1dsdev+J"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09A4AA4AA2;
	Sat, 26 Sep 2026 20:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790448121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iL7bExJVs925q9yLa7sDRxI7vyv/YZQ4FfCbe5s6qaw=;
	b=1dsdev+JmRZnw3115yp6qfis+T3iSQGzi3JYZ/7T6qiCS/Wsv/VVMsrvfWvE9xE5y19uLk
	z9ze0EH3Kc4/u+mxFNkI8mfo8/D6bbAvdLqKZCDtw2XGmkk+5oiBjRXMCI5svDDjOJjBxr
	+/PP5B87RQGztnx+m1pCJNAYyDzH29dHMRkAyraodZdGodWR2StIsLmwj+nYfvyEsH+NjU
	xQCDQHYQySYJUm4uVbDeqJclmabSctGSqxeEs168ouEHRDtBFVZIpIIQso4liqOX+h9Fas
	73m90TEPNJNvyCDwPyU3ag942wotJxybVa1N67ueMki1Nj5v3FZDXRf0boLmew==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Sep 2026 20:41:55 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
 thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net] net: stmmac: Don't set or get RSS parameters when not
 supported
In-Reply-To: <20260926093343.292181-1-maxime.chevallier@bootlin.com>
References: <20260926093343.292181-1-maxime.chevallier@bootlin.com>
Message-ID: <250ecb58e80b191865bcf03f7146f7c2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime

On 26.9.2026 11:33, Maxime Chevallier wrote:
> The RSS kselftests fail on stmmac, and this is partly due to the driver
> reporting bogus data for the RSS ops :
> 
>  - ethtool -x reports an indirection table and a key while the hardware
>    doesn't have any of that
>  - ethtool -X fails with -EINVAL.
> 
> Let's return early in the rss ops if we know the hardware and platform
> don't support RSS.
> 
> Note that RSS is currently not supported on any devices upstream, so
> code that was already useless is now effectively dead. It has been the
> case since 2019 when the code was added, as platforms need to set 
> rss_en
> in their plat data, and no glue ever did that.
> 
> Russell King ran a poll in february 2026 [1] asking if the code should
> be dropped, without any reply going in either direction.
> 
> Jitendra Vegiraju from Broadcom sent 9 iterations of a Broadcom PCIe 
> glue
> driver [2] that actually sets rss_en = 1, so there's some hope that 
> this
> may be used in the future.
> 
> [1] : 
> https://lore.kernel.org/netdev/aYd4BkAeNW6d0iIC@shell.armlinux.org.uk/
> [2] : 
> https://lore.kernel.org/netdev/20260402213629.1996133-1-jitendra.vegiraju@broadcom.com/
> 
> Fixes: 76067459c686 ("net: stmmac: Implement RSS and enable it in XGMAC 
> core")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> Jitendra, do you have plans to continue iterating on the BCM8958x glue 
> ?
> 
> Thanks,
> 
> Maxime
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 1be5310ca766..4e917a448271 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -927,6 +927,9 @@ static u32 stmmac_get_rxfh_key_size(struct 
> net_device *dev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
> 
> +	if (!priv->dma_cap.rssen || !priv->plat->rss_en)

Should this pattern become a helper? Counting 6 instances so far.

> +		return 0;
> +
>  	return sizeof(priv->rss.key);
>  }
> 
> @@ -934,6 +937,9 @@ static u32 stmmac_get_rxfh_indir_size(struct 
> net_device *dev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
> 
> +	if (!priv->dma_cap.rssen || !priv->plat->rss_en)
> +		return 0;
> +
>  	return ARRAY_SIZE(priv->rss.table);
>  }
> 
> @@ -943,6 +949,9 @@ static int stmmac_get_rxfh(struct net_device *dev,
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	int i;
> 
> +	if (!priv->dma_cap.rssen || !priv->plat->rss_en)
> +		return -EOPNOTSUPP;

Not a blocker, but a full netlink RSS dump (like the one in rss_ctx.py)
now stops at this device. Naybe rss_dump_one_dev() should skip 
-EOPNOTSUPP
like ethnl_default_dumpit() does?

> +
>  	if (rxfh->indir) {
>  		for (i = 0; i < ARRAY_SIZE(priv->rss.table); i++)
>  			rxfh->indir[i] = priv->rss.table[i];
> @@ -962,6 +971,9 @@ static int stmmac_set_rxfh(struct net_device *dev,
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	int i;
> 
> +	if (!priv->dma_cap.rssen || !priv->plat->rss_en)
> +		return -EOPNOTSUPP;
> +
>  	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
>  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>  		return -EOPNOTSUPP;

Thanks,
Nicolai
