Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39A2E06EF
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029335; cv=none; b=Xzh5jpQMEvpTvXvr+4ixEiKLmGul3vXhS7ykOpgQkPI4MRTF6pFYkQIe4IzhmS7LkmeNOGi+XhJzA3+JwVhtBfhdBn21nxaZW2xuspx6EV39QBT/qH8mS98AXDN4HJBmrLFxQa//aj9g7TN9Ap37u2RcaKvVnQQRTlL5ZtPqZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029335; c=relaxed/simple;
	bh=omeWshwr8teoYM4DAKXNSFFfci8Xy08FvnAKbjN9YzA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pO/1CNcVz5SsJ0vgGtYlODqx8bZX8AZNqk03DIqrKj4iqfI0bQvyAiDrlHOEGzLG7EhdaGDooURy+S+lmcOM9G4EcMv2Osh12+HB+cuDrwZLOzMotQfuZaTLzONyORz3qXg3cgKT6jpeovZmfeu5XtAP8INhND4X06x+I3aF98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1273A0304;
	Wed,  1 Apr 2026 09:41:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775029274; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Xoi/+TPhDDN/NKwq5I85OXvtTwNxhwe0eRy/nEKKAT8=;
	b=0zdLQ7blBmk6kFPReZJwDjei8coFpsHTU4MMSRqBwo0z/2RJ97W1XolvNBqWMhheCTo3bK
	8NIW1B0Gbb6YZSYpUVXQrYrUVqQF1GucznqB8lsBmlSnzEJ3iYBdAigWWQWo1EHv/VH6bu
	BwsZ0w39cWdrJJCcy6hG1l882+RzvwCiLvM8/1hePRMiGq6+bCFwsSJ2skGaICEBTtT5Ik
	sHWSH9QpG+ipfU7wn3S37kwzUUpblcgweGuBSJbSohQ8HDmxG4wWVmr+yYWsmS5ZngLpIf
	DftPJRSPpC43RF/QDPXK0AjMzeMYVti+ZaQ1OfsCI3RenYt6A4uUpEtdG8ytbA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Apr 2026 09:41:10 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com
Subject: Re: [PATCH net v2 1/4] net: bcmgenet: fix off-by-one in
 bcmgenet_put_txcb
In-Reply-To: <20260401003840.3112454-2-justin.chen@broadcom.com>
References: <20260401003840.3112454-1-justin.chen@broadcom.com>
 <20260401003840.3112454-2-justin.chen@broadcom.com>
Message-ID: <59b90453a26318d478cf8890b53afcce@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 1.4.2026 02:38, Justin Chen wrote:
> The write_ptr points to the next open tx_cb. We want to return the
> tx_cb that gets rewinded, so we must rewind the pointer first then
> return the tx_cb that it points to. That way the txcb can be correctly
> cleaned up.
> 
> Fixes: 876dbadd53a7 ("net: bcmgenet: Fix unmapping of fragments in 
> bcmgenet_xmit()")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 482a31e7b72b..0f6e4baba25b 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -1819,15 +1819,15 @@ static struct enet_cb *bcmgenet_put_txcb(struct 
> bcmgenet_priv *priv,
>  {
>  	struct enet_cb *tx_cb_ptr;
> 
> -	tx_cb_ptr = ring->cbs;
> -	tx_cb_ptr += ring->write_ptr - ring->cb_ptr;
> -
>  	/* Rewinding local write pointer */
>  	if (ring->write_ptr == ring->cb_ptr)
>  		ring->write_ptr = ring->end_ptr;
>  	else
>  		ring->write_ptr--;
> 
> +	tx_cb_ptr = ring->cbs;
> +	tx_cb_ptr += ring->write_ptr - ring->cb_ptr;
> +
>  	return tx_cb_ptr;
>  }

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks

Nicolai
