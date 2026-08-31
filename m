Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDEC3FE650
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170388; cv=none; b=quCSWKVGhkKEyDraG/3VWjzt7eGOSXUc2+aKIrZ6k1jqpf4M18iEi/IdpoNW7Fn9OrE4d41BKmlFf7fUT0LN2e19WImjR0vLzUlkCsfZbm9867cZe5cb3ZDjV7paAo5lqQaH+azW8lMwX2UJwIgUFJBxulBrFVu50GvRNzIkeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170388; c=relaxed/simple;
	bh=X0lpMEawYdoHd9GcTJnYnzpmyil88Zxw8vihmUSzgXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zlct9ztSbjjkbtQSsGyd58HmjgaeejrbevbXXban7UgDW5MHKYMmN/m3ZOMjG7UJL072QkKa5NmmVDiWquH/BYEpKzTSBiTphBZR8A81g6IaMBVxcp4GDsrWgda+Ks/eTSr5Aet1WnC2nnqtr03RSuc5xCEyeqJYiAleTwBxeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2owBSYIG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2owBSYIG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E43224E41441;
	Mon, 31 Aug 2026 09:59:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B02CA60231;
	Mon, 31 Aug 2026 09:59:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 327E311C78AE0;
	Mon, 31 Aug 2026 11:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788170382; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Fwbh1BauoCb6UctKkvdsUX/G9J4v4lYocRurXVp5kIo=;
	b=2owBSYIG8csu/XHdXVOEV3A3VNcK+7wcll8Mn/J3qLuURYicsk2zVyfIdpaDDjPcUmV6JN
	XEV6SQkh+YOhvhnVVLwz6rZB347mvWz7kKAQrwb2puAmuNa+GvgCwUp57lKT0UhERTMP92
	HdAYtmbA84jgj6CESrFcLtyq9FQ8CsfdnGHj2ghfOY41tRVNz2szpUknTC0X0v8TnlQESl
	U66NgVjUhYeZSm9NuE4VqfOL6MNoLET5xM6c72N4GFGxmVkJqfB9VQRVPO8UsD5/WpPZFf
	/haFarr/vJ4WlW18fIK2celBXPq1UWXg5mI2wp0iuorBYjXfS8/X60+W827X6g==
Message-ID: <e08b8438-e936-4575-a8b3-f33a1e4f9a37@bootlin.com>
Date: Mon, 31 Aug 2026 11:59:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: hold runtime PM reference in setup_tc
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260827-stmmac-setup-tc-enable-pm-v2-1-a9b8a5948f41@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260827-stmmac-setup-tc-enable-pm-v2-1-a9b8a5948f41@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/27/26 09:12, Lorenzo Bianconi wrote:
> The qdisc offload callbacks invoked by stmmac_setup_tc() program
> MTL/MAC registers, but they can be reached while the interface is down,
> when stmmac_release() has dropped the runtime PM usage counter and the
> device may be suspended with its clocks gated. Accessing the registers
> in that state can trigger a bus error.
> 
> Hold a runtime PM reference while configuring the register-touching
> qdisc offloads (mqprio, cbs and taprio) so the device is active, and its
> clocks enabled, whenever the MTL/MAC registers are programmed.
> 
> The TC block callback stmmac_setup_tc_block_cb() programs the MTL/MAC
> registers as well, but it runs asynchronously from stmmac_setup_tc(),
> outside the runtime PM reference held there. Hold a runtime PM reference
> for the whole stmmac_setup_tc_block_cb() call as well, covering the
> cls_u32/cls_flower setup and the queue enable/disable accesses.
> 
> No reference is held for the TC_SETUP_BLOCK bookkeeping itself, the
> TC_QUERY_CAPS query or the tc-etf path, since none of them touch the
> registers synchronously. In particular the block bind/unbind must reach
> flow_block_cb_setup_simple() even when the device is suspended, so the
> driver never leaves a stale flow_block_cb on its block list.
> 
> Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> Fixes: 4dbbe8dde848 ("net: stmmac: Add support for U32 TC filter using Flexible RX Parser")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> Changes in v2:
> - Return -EOPNOTSUPP in stmmac_setup_tc_block_cb() for unsupported TC
>   blocks.
> - Link to v1: https://lore.kernel.org/r/20260824-stmmac-setup-tc-enable-pm-v1-1-45172d241a4b@oss.qualcomm.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index efa35cfecc4f..90753d5af6d6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6393,9 +6393,13 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
>  				    void *cb_priv)
>  {
>  	struct stmmac_priv *priv = cb_priv;
> -	int ret = -EOPNOTSUPP;
> +	int ret;
>  
>  	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
> +		return -EOPNOTSUPP;
> +
> +	ret = pm_runtime_resume_and_get(priv->device);
> +	if (ret < 0)
>  		return ret;
>  
>  	__stmmac_disable_all_queues(priv);
> @@ -6408,10 +6412,13 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
>  		ret = stmmac_tc_setup_cls(priv, priv, type_data);
>  		break;
>  	default:
> +		ret = -EOPNOTSUPP;
>  		break;
>  	}
>  
>  	stmmac_enable_all_queues(priv);
> +	pm_runtime_put(priv->device);
> +
>  	return ret;
>  }
>  
> @@ -6421,26 +6428,46 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  			   void *type_data)
>  {
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int ret;
>  
>  	switch (type) {
>  	case TC_QUERY_CAPS:
>  		return stmmac_tc_query_caps(priv, priv, type_data);
>  	case TC_SETUP_QDISC_MQPRIO:
> -		return stmmac_tc_setup_mqprio(priv, priv, type_data);
> +		ret = pm_runtime_resume_and_get(priv->device);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = stmmac_tc_setup_mqprio(priv, priv, type_data);
> +		break;
>  	case TC_SETUP_BLOCK:
>  		return flow_block_cb_setup_simple(type_data,
>  						  &stmmac_block_cb_list,
>  						  stmmac_setup_tc_block_cb,
>  						  priv, priv, true);
>  	case TC_SETUP_QDISC_CBS:
> -		return stmmac_tc_setup_cbs(priv, priv, type_data);
> +		ret = pm_runtime_resume_and_get(priv->device);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = stmmac_tc_setup_cbs(priv, priv, type_data);
> +		break;
>  	case TC_SETUP_QDISC_TAPRIO:
> -		return stmmac_tc_setup_taprio(priv, priv, type_data);
> +		ret = pm_runtime_resume_and_get(priv->device);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = stmmac_tc_setup_taprio(priv, priv, type_data);
> +		break;
>  	case TC_SETUP_QDISC_ETF:
>  		return stmmac_tc_setup_etf(priv, priv, type_data);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> +
> +	pm_runtime_put(priv->device);
> +
> +	return ret;
>  }
>  
>  static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *skb,
> 
> ---
> base-commit: f967455fb2a5a2079b9eb5823e9ccf359174bf9f
> change-id: 20260824-stmmac-setup-tc-enable-pm-149aa563d797
> 
> Best regards,

