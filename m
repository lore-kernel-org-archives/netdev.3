Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CBA3AE6FC;
	Wed, 29 Jul 2026 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306469; cv=none; b=OX7XlUIM7mLykHMPiTbN0/jFwwqFmUat1jrM4fb9OVtbrHp58V3q6tuX410GUY7/06dym0J4jq85vElWCIzr75Q3g6r5cDH2GOgrg399lIJ80aoP3lNn1SoLJSTt8TO5O7tnzjO9tli61Zynz7jzAo1+4qR0pOJGNEUzDd6vZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306469; c=relaxed/simple;
	bh=SqRZ6p2QaKtWb6QGsdl/z0N60fcEftNeNJlRTUuX6XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOGgMro/snoc2I7ni/yUjorXmc/USexGet5aG2/WJ+qfbLirTThNSJYNrvzADUg7qw/A48+92lxiYKARQIKQTSRG+IOlGictCms1azvTULSSiTgUy9b14O5MM3H5JRb2KYL4Lk3Ws9p6iDgB1LANE1XXOA4XipXlp+PbT4ulnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oqXHB765; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oqXHB765"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 598C71A12E9;
	Wed, 29 Jul 2026 06:27:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2573B6039A;
	Wed, 29 Jul 2026 06:27:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D88011C14996;
	Wed, 29 Jul 2026 08:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785306457; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xpEYzsbGTSVFGj/lSmF+buaqJllHyC8FKf7eTRA+e8E=;
	b=oqXHB765Ps+YvI9XtjAJ5+863C31NdUdn1AF00G2ATvComzFQbjqUeAGeC74OGMqrNivzx
	TlqK/eXCE1pXAyW8ETprps+xRJYL3IGCTabCW1OfEdt9irDIN9xTv2X8Aj5D4JXaQpebKe
	EgC6QrCLN7hwxuVw/0L5lRiYGXc3LVLrWvQYmsi2pd5MsOFueMN6krUL9vb96938hpqxui
	T81LcF1CBeJGZNl45RQ1QKJZmf0tsFP8UXRKdZne0TrsabUuefX0pQ6ytPWa1rqlH2YXiS
	UyvACZyfhpqxPZSHIGnlz8n94tZPH6sCYnTuNeG/L6msWPfidMkVGeoRRq315Q==
Message-ID: <5cc2d491-2f57-4745-8dcd-3f63ba0cbf96@bootlin.com>
Date: Wed, 29 Jul 2026 08:27:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: fpe: Add missing return in
 stmmac_fpe_init()
To: muhammad.nazim.amirul.nazle.asmade@altera.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260729015247.25774-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260729015247.25774-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260729015247.25774-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/29/26 03:52, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> When FPE is not supported by the driver, stmmac_fpe_init() prints a
> warning but falls through into the pmac_enabled initialization, which
> should only be reached on supported hardware. Add the missing return
> to prevent this.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> index 2f880c5e35b0..3436e962a238 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> @@ -174,8 +174,10 @@ void stmmac_fpe_init(struct stmmac_priv *priv)
>  			  &stmmac_mmsv_ops);
>  
>  	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
> -	    priv->dma_cap.fpesel)
> +	    priv->dma_cap.fpesel) {
>  		dev_info(priv->device, "FPE is not supported by driver.\n");
> +		return;
> +	}
>  
>  	/* The preemptive MAC in DWMAC is always enabled, so initialize
>  	 * pmac_enabled to true to reflect the hardware state.

