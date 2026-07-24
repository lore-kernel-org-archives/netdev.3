Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCF466B7C;
	Fri, 24 Jul 2026 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921794; cv=none; b=aLxFzr52qxa47dm+OP6R/AavTw71P1X8MtQ8TJKwkgMo7u6b3dvPexMC3lDbzknBNnLA/e20CDpxyIupJzDz2U2z+wdiaNXEFbz3DDSS4XcAtLzf592N7pD4rQTYE9PCQa7M1I2P1qXstcI+6SOtZISGHWUZfVQra2Aw0XO5aDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921794; c=relaxed/simple;
	bh=oUOQtwy133EPNSsqt1C6WaSbBva3pFYYbsmpwnNUfXw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XJBxa16ExF/+sKoVWoQdDpHq41wOu/7hzs/EOZvSIykaOuqhHCayYt6szRbCEH016Ne9+y9iC4jj362QjlXsIBfF1JmG3kNUwQBpktlJLXJ8zpAz4nSxNsY0IFBcz5DE9GFn46/dzwWglFOb9hIv1oMhyFbv1y7zW+LjIavlmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=sQMXSUOn; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="sQMXSUOn"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12AADA6942;
	Fri, 24 Jul 2026 21:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784921781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qgXH9Ry4HZWhzVO2PkfwqTUXJwFAPUGfQaASSUFCgxE=;
	b=sQMXSUOnt4HDpd2etDlTIy/tIgkLtpouDWOOoZqSHBCcF7qhkYAczInZ6TqbcQ3DR4lR7T
	iCd8OmUuN0pwijarDc6Hh4e7WhoWtGGQuLz1zKCDUqqCSMDbtl6CvlLFc9EJkhbq/xU4Nt
	PPr/zFZhAidHs2/7DjCn7wW+PH7pjapq15K0Y5vqaML83IypZv+/rjD6vUJIozYmZNEowi
	JaUssRmE173Val29E2W33zyRgg2+XQDc4jMvUT921vCeGk422uRayc1965QRpk24IJrpcP
	UMa6fHP+Dt3SNYvXO7E+06hasHxSnd46x2Dqo/tt/4yrfRq9VYKRO8BJC/gugQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 21:36:20 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 11/15] net: macb: change function signatures
 to take contexts
In-Reply-To: <20260724-macb-context-v5-11-569b1852bc7f@bootlin.com>
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
 <20260724-macb-context-v5-11-569b1852bc7f@bootlin.com>
Message-ID: <bb79e3e2fd3575e58d4c1a197d1b954f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 24.7.2026 17:29, Théo Lebrun wrote:
> For parallel MACB context to start become a reality, many functions 
> need
> to stop operating on bp->ctx (the currently active context) and instead
> work on a context they get passed. That context might be
> (1) the new one that is getting allocated and initialised, or,
> (2) the old one to be freed.
> 
> To reduce bug surface area, taint those functions to *only* take a
> context `struct macb_context *ctx` and no `struct macb *bp`. That way,
> no bug of using `bp->ctx` instead of `ctx` will ever occur.
> 
> We also convert functions that take a `struct macb_queue *queue` to
> instead take `struct macb_context *ctx, unsigned int q`, with q
> indexing ctx->txq[] and ctx->rxq[].
> 
> Full list:
> 
>    macb_adj_dma_desc_idx()
>    macb_tx_ring_wrap()
>    macb_tx_desc()
>    macb_rx_ring_wrap()
>    macb_rx_desc()
>    macb_get_addr()
>    gem_rx_refill()
>    macb_init_rx_ring()
>    gem_free_rx_buffers()
>    macb_free_rx_buffers()
>    macb_tx_ring_size_per_queue()
>    macb_rx_ring_size_per_queue()
>    macb_free()
>    gem_alloc_rx_buffers()
>    macb_alloc_rx_buffers()
>    macb_alloc()
>    gem_init_rx_ring()
>    gem_init_rings()
>    macb_init_rings()
> 
> Note about gem_rx_refill(): it ends with a netdev_vdbg() that prints 
> the
> queue pointer. Change to print the queue index because we do not have
> access to the queue anymore.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
