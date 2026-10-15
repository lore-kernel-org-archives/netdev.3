Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE426D4CA
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066454; cv=none; b=R052edvbYu3ZnhIAeALkLjLeNr2vRx0LPcd4ZEMBO+J2nazKI9/8szJxoRKoiyrO/uHmyUBkrqMYZNy7YbfAmYN/NWcCyq/bUG+iFP85RYGY99J3PC8O6NHKK1K8Hy7K3TpiNl9nnv4DAhpOBodGoj8jaapJEfj3aGJq9thi8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066454; c=relaxed/simple;
	bh=CBSujmphNDQCFVF2Cp3TI/J45ZYgqjq09qGMCcpsInE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtZRw04X4APjXz4EBZDXH8WnvA7Vo9TytseLdLFcyjf1dNHo6u+zoiN3pzFheedjtc6jaIe1FN1rc8PS+kbXk/GjTkrzdnwkl8mlOlHTTizO39m4miC5Ze/lJvj1qbh3X5X97TjoHNT9+wm0x+OU1G+yb35wTDxTNiC9JDWoBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ifd3weqB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ifd3weqB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A1848C63455;
	Thu, 15 Oct 2026 12:15:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3666C60360;
	Thu, 15 Oct 2026 12:14:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 088BA10328BC6;
	Thu, 15 Oct 2026 14:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792066447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1gJALexW05XL2Pb5Fq3PqAp03mD7NtGawsGCWpwRmHU=;
	b=Ifd3weqBL4dZA0MqbkFF6C1lVmZFL0nzM8MZMHA0eL16k/mOcv6E2MdHPf+LP5Dc4+sXdV
	ygypA+PGRWQvkyiY0pAMcGEFaC7Rvqve5eIsLePBC0HXvoRZgUm/U9JTRHWwFqTjlA7WDE
	jAmoVj/isy17n/rOndSPQO3DgCctO5lXH2zCSU8zV1mkbmsdkn8bET33npg4fLrzeEzg9I
	J4WqRzvtsnMZdcTXYsUiHJA/LeksZJGP5RqFoESXDJPKuMx8cBI5syhWVcynEMBDGeZcnH
	tjzP3neVJnw4LN2GRYQ9psSJNGjeIWK8mzxtxl07E6XN+Cgc9vwbDO3DgMKrdA==
Message-ID: <020aa4b3-3f18-4a04-92b7-81cd21b07f7d@bootlin.com>
Date: Thu, 15 Oct 2026 14:13:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: remove STMMAC_DOWN check to avoid irq storm
To: Xiaochuan Li <chuanx2070@163.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20261015112415.437900-1-chuanx2070@163.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261015112415.437900-1-chuanx2070@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

First thing first, you're missing the target git tree, net or net-next. It's
likely net-next, unless this is a real crash you're facing.

On 10/15/26 13:24, Xiaochuan Li wrote:
> The stmmac interrupt handlers return IRQ_HANDLED immediately when
> STMMAC_DOWN is set, without reading or clearing any device status
> register.
> 
> STMMAC_DOWN is set by stmmac_reset_subtask() before dev_close(). The
> device interrupt is level triggered, so if it fires after STMMAC_DOWN
> is set and before the IRQs are masked/freed in __stmmac_release(), the
> pending status is never cleared, the line stays asserted and the handler
> is re-entered forever. Since the handler returns IRQ_HANDLED,
> note_interrupt() never flags the IRQ as spurious and never disables it,
> resulting in an interrupt storm.
> 
> Signed-off-by: Xiaochuan Li <chuanx2070@163.com>

This STMMAC_DOWN flag is quite misleading :( it's only set in the
stmmac_reset_subtask() and there's no explanation at all in the git history about
why this flag is even here...

How did you find that problem ? Do you have a use-case that triggered the
storm ?

I'm wondering if the right move isn't just to get rid of the flag entirely, I'm
failing to see what it brings.

> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 33 ++++++++-----------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 56d89a696272..520c1b8d736c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3091,6 +3091,13 @@ static bool stmmac_safety_feat_interrupt(struct stmmac_priv *priv)
>  
>  	ret = stmmac_safety_feat_irq_status(priv, priv->dev,
>  			priv->ioaddr, priv->dma_cap.asp, &priv->sstats);
> +
> +	/* Status is read/cleared; do not escalate to a global error reset
> +	 * while the interface is going down.
> +	 */
> +	if (test_bit(STMMAC_DOWN, &priv->state))
> +		return false;
> +
>  	if (ret && (ret != -EINVAL)) {
>  		stmmac_global_err(priv);
>  		return true;
> @@ -3113,6 +3120,12 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan, u32 dir)
>  	rx_napi = rx_q->xsk_pool ? &ch->rxtx_napi : &ch->rx_napi;
>  	tx_napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
>  
> +	/* Status was already read (and clear) above, so the irq line is
> +	 * deasserted, Drop the event while the interface is going down.
> +	 */
> +	if (test_bit(STMMAC_DOWN, &priv->state))
> +		return 0;
> +

I don't quite understand why this is added here, can you elaborate ?

Maxime

