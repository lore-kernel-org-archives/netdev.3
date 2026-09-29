Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7E3C10BF
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716207; cv=none; b=ntMFjeM6P1S6luHOvtdu75ksoilYXdPvuulMcCauNE2g3XhyKznyknuGmaVx0UIcZzhxCEHWHfY/LICFfRGV3+8ijS+GkgXVJg+4LL0BkZ37e4+wQp2zVIoXK4l9oC2k91mXLnwdprJcAAnnGimDuCNmQfRA/mANFCnH8Q+E/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716207; c=relaxed/simple;
	bh=OHAGTcU81QC5e/48d7MJVqu7pxnUvtE58EI0VYOG570=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kCiQ0QOzufJuys7CJbv2uke195HR008lai0Dsi70FrlXaLOb88DGo8sYe65osMDWjdJ3wJQ5xmSFU4hSThU8nLGkwlijS1TzmXW0D0Nk133lCaVtOxJU6iyISY5uCmLVJPfNvT9WrUAoR9K+asrLH1yrh5DBPQc6LszIGnrqWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=NAiAjxES; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="NAiAjxES"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC71BA4ABD;
	Tue, 29 Sep 2026 23:09:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790716200; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2rAqzsu6pQzAoWfOB8fCjrivk7TXhqFbCo/L91p88x4=;
	b=NAiAjxES3BDwSBr72QRKY5UpES6JrmU4T9AU8xeRYTSYGrovOdVQ3JJlszKvCy6poYHGNV
	XIKY8ZU0Et5Btq8WFpj1yMAwm4rfSeN+dUWEWV8oGiRmPOXcKYgfZcv04X9T0cJbdmjZW4
	qoB0JVWoupzqM8ltIw6K5hTWWc3HCLkcyVCLi1UaWOze8hXBTFJ+dAZpzHb9IpfQZnN33A
	tdKzlCctDDJHtPfJEEhvEQ5qdqCHgesaKfBTzWcptAViJvy11F3RGTov/1h6fFpZe2elnB
	e5K4cFux/DHodLd/1xIIAtJRos6huWP10PNnkkCSLZ8BKZwE27YSdH+OmVijNA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Sep 2026 23:09:58 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com
Subject: Re: [PATCH net] net: bcmgenet: if UMAC was suspended in SW_RESET,
 restore it to SW_RESET
In-Reply-To: <20260929192216.1490017-1-justin.chen@broadcom.com>
References: <20260929192216.1490017-1-justin.chen@broadcom.com>
Message-ID: <27f4423822acfaa3f121e3637ed173e0@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Justin

On 29.9.2026 21:22, Justin Chen wrote:
> When the revised suspend/resume sequence was introduced this led to an 
> edge
> case where the TX is left disabled in the following sequence.
> 
> 1. phy link is down, so UMAC is held in reset and then network 
> interface
>    is WoL enabled
> 2. Enter suspend, bcmgenet_wol_power_down_cfg() enables UMAC_RX since 
> MAC
>    is in SW_RESET
> 4. Enter resume, UMAC_RX is left enabled. Since we only enable UMAC_TX
>    and UMAC_RX in SW_RESET. The UMAC_TX is never enabled again on link 
> up.
> 
> Fixes: 254f3239dd07 ("net: bcmgenet: revise suspend/resume")
> Fixes: 88f6c8bf1aae ("net: bcmgenet: keep MAC in reset until PHY is 
> up")

AFAIU before 254f3239dd07 resume always went through init_umac(), so 
older
kernels shouldn't be affected. If we drop the tag for, it would save 
some
backports to the older LTS kernels.

> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
> index 96d5d4f7f51f..984432952963 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
> @@ -253,6 +253,17 @@ int bcmgenet_wol_power_up_cfg(struct bcmgenet_priv 
> *priv,
>  	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
>  	reg &= ~CMD_CRC_FWD;
>  	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
> +
> +	/*
> +	 * Mirror wol_power_down_cfg(). If only UMAC_RX
> +	 * is enabled, then we must place the UMAC back
> +	 * into SW_RESET.
> +	 */
> +	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
> +	if ((reg & CMD_RX_EN) && !(reg & CMD_TX_EN)) {
> +		reg |= CMD_SW_RESET;
> +		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
> +	}
>  	spin_unlock_bh(&priv->reg_lock);
> 
>  	/* Resume link status tracking */

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
