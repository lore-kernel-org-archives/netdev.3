Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8675CA4E;
	Tue, 28 Apr 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777411847; cv=none; b=ezLyx/BEimBIXbkqdG6SffE1xqEtY/XmDLkQSPm9xPQbywQxzIpPbRIpcdGtblnyiruqFnXDWKVrXllz2M8ch7Ry5CXfhtdcQjVdOWryRW5LrxeT5DkN0SQC4vpxGbV2VWQB3d5uyyqelaYreyfOVdoU69BhbUWi3tRNyoqQYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777411847; c=relaxed/simple;
	bh=l+mYWEIsEsFN2j03M5rkEtfUsQ7PoN150KHUnyMeyhY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ld1Fr1eqdDM5pAHWDLwdN2kG151ns97bwiN1NA0FOJLsM6FLFgkQspPjqVNhZJSrqc8gpPymI51gzGror8GaQZo/OBohIX8MESS2Z2uymGAnZa95waIK6waf8F8hBBNGYGRqliF36NZZ3nEVMnGGHnEOdiPkF6jccE2pQMA3Ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=TiY3tRny; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="TiY3tRny"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 746D4A20CB;
	Tue, 28 Apr 2026 23:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777411839; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DJMsEw7YaGuZ6jbexhTWcloQuxI5wDaf6cXglbJgxak=;
	b=TiY3tRnyPRs7irWHFiApXM4y8x1OYZccVnfs6afzzOjErnQQKxYCBJ2UrWVT3CYtomTiO2
	N1bPlxRS9qHlAsTQLj8xz/zqmPOxEFGT/R7bMYopJP+Txs1nTD7jLF32D4zFpqDVgudA60
	OHsGNR0KaxeaVVkayR6mPMp2WSVGpNlO6uioi+wVZt/4VAODmE9d05Zsveq2dSd2jNAY5P
	FIDLY8f3mIjX1iXzrGoz8f49oIhhpw2u5lIV4lNeBguqdkere8fmF6Yf+qmbsmGn2nk4W7
	rqzGy0P1E0+YAuzEqTc7iQ85o5rmx6bDO60Yvi3Z88w/4+C5f7vUJtXoeIBSkw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Apr 2026 23:30:34 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haavard
 Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>, Paolo
 Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/4] net: macb: drop in-flight Tx SKBs on close
In-Reply-To: <20260428-macb-drop-tx-v2-2-647f5199d8df@bootlin.com>
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
 <20260428-macb-drop-tx-v2-2-647f5199d8df@bootlin.com>
Message-ID: <75229fab491465e06a98ee580a51f0b4@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 28.4.2026 18:32, Théo Lebrun wrote:
> The MACB driver has since forever leaked the outgoing SKBs that
> have not yet been marked as completed. They live in queue->tx_skb
> which gets freed without remorse nor checking.
> 
> macb_free_consistent() gets called in a few codepaths, but only
> close will trigger the added expressions. In macb_open() and
> macb_alloc_consistent() failure cases, tx_skb just got allocated
> and is empty.
> 
> Use the new macb_tx_unmap() prototype to report our error as
> SKB_DROP_REASON_NOT_SPECIFIED rather than SKB_CONSUMED which makes it
> sound like no error occurred. Equivalent to dev_kfree_skb_any().
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 9caae1ef52b1..5a2500bd59a6 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2678,8 +2678,26 @@ static void macb_free_consistent(struct macb 
> *bp)
>  	dma_free_coherent(dev, size, bp->queues[0].rx_ring, 
> bp->queues[0].rx_ring_dma);
> 
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -		kfree(queue->tx_skb);
> -		queue->tx_skb = NULL;
> +		if (queue->tx_skb) {
> +			unsigned int dropped = 0, tail;
> +
> +			for (tail = queue->tx_tail; tail != queue->tx_head;
> +			     tail++) {
> +				if (macb_tx_skb(queue, tail)->skb)
> +					dropped++;
> +				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0,
> +					      SKB_DROP_REASON_NOT_SPECIFIED);
> +			}

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Side note, not blocking: macb_close() doesn't cancel tx_error_task,
so the workqueue handler can race with this loop on tx_skb[]. The
exposure is pre-existing, but maybe worth a follow-up adding
cancel_work_sync() between napi_disable() and macb_free_consistent().

> [...]

Thanks,
Nicolai
