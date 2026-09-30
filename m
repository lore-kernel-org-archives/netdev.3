Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAD4D797D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804584; cv=none; b=BfTk4UZB9NokwBkIpdwNjn4Ky4sM/bgrd78iLCF433a2x3dsIJ7+vMDk3I5Q0UMaGzQmI0ntmwL3q+VMDsjr2XmzPgK0K63MJnjqKZcmR+qC9gph77GD6LhqkbZdwtTtI0mao0DhKX12RzSZaiaN7UvfRcLT/a3MGwjtKTyF2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804584; c=relaxed/simple;
	bh=GZc8KZekvqxs/WEqCkku5bM6XIO8TsX64V5xkY4tyUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZmtZfgjr4sf1PB+C4ytJUhCsy4QlQk3DnjJt6cAHafkfIL1nj/rMSkkMJfjnIuzBiTauYSpcBJvcZOTJlyqZT+QXCb/qnAI7yErjq/Qt5Sm/YTh/u5X8RN2pRXPecOQHOJLYV2k1axnYz/0wYxKitSIcO0Lls2HBUH+jSnwVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wWq8lA4j; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wWq8lA4j"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C51E21A1088;
	Wed, 30 Sep 2026 21:43:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8F42460749;
	Wed, 30 Sep 2026 21:43:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E477103298BA;
	Wed, 30 Sep 2026 23:42:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790804579; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2tf3AicESXUN6zuzkl4u0tQ13NoG3pfVJBuiqaZBvBM=;
	b=wWq8lA4jkXbXyIYIi/p642+Ci9bSZu3PRIhX4K8SASZRLhSn6gmX4nNtsJm5c07SRvsx/F
	/IWwOfD5fT7y+7zgOqB8p8biMUCxKPV1tnjW/JOnXKiN/GHhr4B4TGzPWK33l8BecRGwMv
	lil80UiHe7VrH5SzyDw8ItgQ7e7O3b9hB0N/m6FK0iUWDIZiEE/lRJTqappRMwuwfdxFGt
	XZjyJSFZf5LLHNybBvis8UnE8viBPnOh3Se18Bpvx4/wYonqvagSM/H9UPKHK/YGc99LSK
	ellb3bQwsrRUhhLVjvWxxgs3PA53tfI2395U0zMnusrA9wMje+vsQXGPMrrDIA==
Message-ID: <87598792-c93d-4e2b-9094-0f3e9c72e2c8@bootlin.com>
Date: Wed, 30 Sep 2026 23:42:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 4/5] net: stmmac: Do not advertise S-VLAN stripping
 when it is disabled
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, recv.jo@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, jun.ann.lai@intel.com,
 yi.fang.gan@intel.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260928203441.34876-1-ovidiu.panait.rb@renesas.com>
 <20260928203441.34876-5-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260928203441.34876-5-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/28/26 22:34, Ovidiu Panait wrote:
> C-VLAN and S-VLAN tag stripping are both controlled by the EVLS bit,
> so disabling rx-vlan-offload also disables S-VLAN tag stripping.
> However, rx-vlan-stag-hw-parse keeps being advertised as enabled:
> 
> root@rzv2h-evk:~# ethtool -K end1 rx-vlan-offload off
> root@rzv2h-evk:~# ethtool -k end1 | grep -i vlan
> rx-vlan-offload: off
> tx-vlan-offload: off [fixed]
> rx-vlan-filter: on [fixed]
> vlan-challenged: off [fixed]
> tx-vlan-stag-hw-insert: off [fixed]
> rx-vlan-stag-hw-parse: on [fixed]
> rx-vlan-stag-filter: on [fixed]
> 
> Fix this inconsistency by making NETIF_F_HW_VLAN_STAG_RX follow
> NETIF_F_HW_VLAN_CTAG_RX.
> 
> Fixes: 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN stripping")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


> ---
> v6 changes: None.
> 
> v5 changes:
> - Rebased on top of the rename patch: used dwmac_is_xmac() instead of
>   the dropped hw_svlan_en flag.
> 
> v4 changes:
> - New patch.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 0d70eb452af7..b007ff120471 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6211,6 +6211,13 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
>  	if (priv->plat->bugged_jumbo && (dev->mtu > ETH_DATA_LEN))
>  		features &= ~NETIF_F_CSUM_MASK;
>  
> +	if (dwmac_is_xmac(priv->plat->core_type)) {
> +		if (features & NETIF_F_HW_VLAN_CTAG_RX)
> +			features |= NETIF_F_HW_VLAN_STAG_RX;
> +		else
> +			features &= ~NETIF_F_HW_VLAN_STAG_RX;
> +	}
> +
>  	return features;
>  }
>  

