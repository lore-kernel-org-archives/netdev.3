Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510682D7DDB;
	Wed, 29 Jul 2026 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306402; cv=none; b=Bh+//4AsoyAsTlg5/YDmRzoO7TQ9zElp1Y1cUFhd1fnSKZm7e3YjugB39paY/UjIlMFsysgr8UKdVqnfRzkyyx9iqSwyEDyAZ9rY+ceQKfXbZZvUQweTdknzgRc7t8cv/xRnNc8EpUerybcQutWY6Ar76KwNsicNsYMx3tehWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306402; c=relaxed/simple;
	bh=XOO3WlEFp4BrInQLNmfEE90essyJsjNwAQ322MsjXbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6RAKm7InQNZBusUoCPOuZrc1epN67ae0pIiA8Su84Hmd7dZuk91D5Uht/4O9Wn+ZNmd77DVpQYalAlDE/AZlJVbGyws+C7toN78gYiHkC8xNoobjavxoi5I2JkHwo2bM5rKF+O4vuoux0ofq4B+9HQLYj3bnMJNNCbGQGB5Fgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y0Z7OUKq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y0Z7OUKq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5C65E4E40FD4;
	Wed, 29 Jul 2026 06:26:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F7366039A;
	Wed, 29 Jul 2026 06:26:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C11DA11C14993;
	Wed, 29 Jul 2026 08:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785306392; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Gvf5TT4THTQo8Vgq5kQVKZIB4tzxRyZ0EIxkRmLPp9c=;
	b=Y0Z7OUKqTitpQC4pDdj2I4WkZwnECbktc3br1Fr8iShkM7wTDbH/k9Kz782dLjGs8OqDZH
	5l5FRhHKhOwT3gj5i5oH1C0Q+VMOstsWQVZwDs4T+j3SKFAfRtuDus45jDSHkkoxTAq3nd
	qpMPIcRSGlVJWYI/3w3lEKBs+qSuVH5M8aw6GJl/51E/LSVYUAm/Se6xPGAS24TlL10P+X
	x5w78hKJJ1wG4xrvUiXVQ0I6LGKZA1otfuXBle0WfTJpgwJcU94/it3tQRnhFDNDo+aCql
	+borfurKAmqo3Srh7VeEwJMSZgIfW7IVxxBsDZZSXE8H4wEDhYvqJJ7VwTtbQA==
Message-ID: <22d95b3a-752f-46fc-be0f-497e78f9f189@bootlin.com>
Date: Wed, 29 Jul 2026 08:26:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: stmmac: fpe: Enforce pmac_enabled in
 set_mm and keep it on at init
To: muhammad.nazim.amirul.nazle.asmade@altera.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260729015247.25774-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260729015247.25774-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260729015247.25774-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/29/26 03:52, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The preemptive MAC in DWMAC is always enabled, meaning DWMAC is always
> ready to receive preemptive mPackets. Initialize pmac_enabled to true
> at init time and reject attempts to disable it via ethtool set_mm.
> 
> Also add a missing fpesel capability check in stmmac_set_mm() to return
> -EOPNOTSUPP early on hardware without FPE support.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 7 +++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c     | 5 +++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 92585d27ab88..8ebdd249e5c8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -1064,6 +1064,13 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>  	if (err)
>  		return err;
>  
> +	if (!priv->dma_cap.fpesel)
> +		return -EOPNOTSUPP;
> +
> +	/* DWMAC always have preemptible MAC enabled */
> +	if (!cfg->pmac_enabled)
> +		return -EINVAL;
> +
>  	stmmac_fpe_set_add_frag_size(priv, frag_size);
>  	ethtool_mmsv_set_mm(&priv->fpe_cfg.mmsv, cfg);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> index c54c70224351..2f880c5e35b0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> @@ -176,6 +176,11 @@ void stmmac_fpe_init(struct stmmac_priv *priv)
>  	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
>  	    priv->dma_cap.fpesel)
>  		dev_info(priv->device, "FPE is not supported by driver.\n");
> +
> +	/* The preemptive MAC in DWMAC is always enabled, so initialize
> +	 * pmac_enabled to true to reflect the hardware state.
> +	 */
> +	priv->fpe_cfg.mmsv.pmac_enabled = true;
>  }
>  
>  int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv)

