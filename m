Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612387;
	b=2xx4WzvPaSvCgF2923J3NINDLuBzBFQZZn4nRw5a4i6wg9jJhH5v/Jd98Y9hiCVGNsFt
	 mlOZgx1In3O95o2KZ/FtQZS7sthtNRxdE2Gm+1jtudTVzgCP0JmXDb0aZyor0nlOuDV8H
	 MhdY2oszkeMVUZR7+CqiwY4n66Z1z43edaHzuD6////m0aoBIrylBbAA/E35qlA6cjvtr
	 UrfWQEZA4j/flnTr4Z++mP0Nm12nf7u96lRWUZssFogfmewQAfVY2JPz0YB7W02V6yIz6
	 JLWo3zUK44dDkMfgtd+kcmhU/WVeVe/VD7dC79aUAVEHju0+2X2nCq/QfLPJvrn2gng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612387;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=vpyYO6t9Oz2alllZ4KA6oNwx4ANakahJVZkjXrVLPyc=;
	b=pTVx2hdtm8CPxbYZhN45rrOwCGVO5nwj375QLk6IFGkiDacldCvJGdBW0Z/jaEmKc/f/
	 /cyT3riPDnvVv2deICK/Z2xbgO0CqKTr+A+E8ne1ISPIjyCUyVoYo+04m/q8H3H0/3fsS
	 ntPv66rG6lcerQRKajGg4W6pmZOi9h+TlFsC9Uagq41dvXfXZPzVdy/d2nofi9fOjN6f+
	 a0PFziE8IgJJYioAEHKeZn2bsowCUcwVwRBJ3Uc5X8DboPlSg+JZDFBl6pbvwSWqzEfl9
	 eoLbK0RUC1MdV9jCBms4XeR/hOgwc/UWryPO9o8nh1z7pGwdQOFfWzbcCYqbmNiVIJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=k4oXrjtR;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA5606A31D;
	Wed, 21 Oct 2026 19:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BEA5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=k4oXrjtR
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C74B9A0064;
	Wed, 21 Oct 2026 21:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792612383; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vpyYO6t9Oz2alllZ4KA6oNwx4ANakahJVZkjXrVLPyc=;
	b=k4oXrjtRsoA2jeQBaAQ4UsGpKRwXldjdGzcTeBEHEx9PDrMonw40wohq1TIJbVZN1d3kED
	GQ4a7DS0WXRhIqhz37WH8ezZ8UNDx97lU2Ex9CBTvBDXfrDgTdzZHXVBDdwSVELlAORbgi
	/QnGIPLbVEwcdhhJ+jBbMs9dRcScW2Zr6fvML8XDYG6HMnppX4KbuKfBcqKpjkQPhxmbc9
	ggik55hXCPHduEeNsAp5bBJrHX3K3iouD92UDa31H0PnV1J8cLhXKnl/thqXUJoYyJlJkW
	RLO7WqHlF9eK03RL9sQs9o66m+jN3vSurjAiToHJniaJY+iFsDlXhqWaPg5e8w==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 21:53:02 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 Raju.Lakkaraju@microchip.com, davthompson@nvidia.com
Subject: Re: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
In-Reply-To: <bf487e5d01fe6352069d4314087f680fea717cc5.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <bf487e5d01fe6352069d4314087f680fea717cc5.1792008404.git.cbabroski@nvidia.com>
Message-ID: <ad9ebf0ebbb05424676b3d80b935f58c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 15.10.2026 17:00, Chris Babroski wrote:
> lan743x_tx_close() and lan743x_rx_close() ask the DMA controller to 
> stop
> the channel and wait for it, but ignore the result. If the channel is
> still stop-pending when the wait gives up, the descriptor ring, the 
> head
> write-back buffer and the packet buffers are unmapped and freed while
> the channel may still be fetching from or writing to them.
> 
> A TX channel has been seen to stop making progress, with its head index
> no longer advancing while DMAC_CMD still reports it as started. A
> channel in that state may not honour the stop request either, and
> closing the interface would then free memory the engine can still
> access.
> 
> If the channel is still stop-pending after the wait, or still reads as
> started, issue a channel soft reset and wait for it before anything is
> freed, and log when that happens.
> 
> Use the same helpers for the channel resets that lan743x_tx_open() and
> lan743x_rx_open() already open-code, and log there too if the reset
> times out.
> 
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x 
> driver")
> Assisted-by: LLM
> Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 64 +++++++++++++++----
>  1 file changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c 
> b/drivers/net/ethernet/microchip/lan743x_main.c
> index 82d3ec20ba25..9e1276cf313c 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c

> [...]

> @@ -2221,11 +2239,22 @@ static int lan743x_tx_ring_init(struct 
> lan743x_tx *tx)
>  static void lan743x_tx_close(struct lan743x_tx *tx)
>  {
>  	struct lan743x_adapter *adapter = tx->adapter;
> +	int ret;
> 
>  	lan743x_csr_write(adapter,
>  			  DMAC_CMD,
>  			  DMAC_CMD_STOP_T_(tx->channel_number));
> -	lan743x_dmac_tx_wait_till_stopped(adapter, tx->channel_number);
> +	ret = lan743x_dmac_tx_wait_till_stopped(adapter, tx->channel_number);
> +	if (ret < 0 || ret == DMAC_CHANNEL_STATE_STARTED) {
> +		netdev_warn(adapter->netdev,
> +			    "TX channel %d failed to stop, resetting it\n",
> +			    tx->channel_number);
> +		ret = lan743x_dmac_tx_reset(adapter, tx->channel_number);
> +		if (ret)
> +			netdev_err(adapter->netdev,
> +				   "TX channel %d reset timed out\n",
> +				   tx->channel_number);
> +	}

While looking something up in the registers for the other thread I
stumbled over this in AN2948 about TX_SWR_x:

"This is an immediate reset and will cause any, in process, PCIe request
to [be] aborted. This may likely result in a corrupt PCIe packet."

A channel that did not stop is the one case where a request is still in
flight, so this resets right when the datasheet says not to. Is there a
sanctioned way to recover a channel that ignores STOP_T?

Woojung, maybe you can say?

> [...]

Thanks,
Nicolai
