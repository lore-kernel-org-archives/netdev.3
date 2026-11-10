Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348282;
	b=VXwsLqT0hCRso91iP0jQ/wEBO7/883wDbLZSTtOIt5hEn87kPDfs5hlF2wg+VgoPS6Vk
	 vZDtkYjAGKW63mNA6QAg+3VLLt4tPS1140yp7JE2RHf7Jr1LN5NLWgQR2IJW2ClAklm8g
	 fFcdIICIeB87JiyZ6QvddH0yZh8ldsXGTf+cWnjgIXcl5Jvg15V72UueuMtcNYGiDOgXj
	 bX9HAff409zipZloXzp5868fX9mtawIeJyzeI9bBvECXyK37Da4uqMn1Q0K1YbDQjUma2
	 yBdhwqnGxWe3fKLKpdkBBv7yVYEtgn4l9YV9P+bm8qJZY+uodIhC4PGh1yIosQqo8Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348282;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=poGwgjpmsxdXo4E2tjeuNJNfqDre4+vtgrUuX7o6vhc=;
	b=mBlf2Y4ck2WD5ilvOraNguB82wZkkEYW3K+XN19971sUSOodNc9BWZwZbU5z7q8Dn5pm
	 4WSYqXu9udcFhGqUM+bUQNoT0PIvMPzaRgrtXdoJN0cQTijWPP0i7pLCJfvV6BBvtK8xl
	 yQO8YWAO6ofJo+uy9lXKPP9+VY9rbZFbqiJDi8H1DFnG2jVPn2/0gKqjWRklLL/oXxz9E
	 OLcWi1XOQ/iTTh6D1y9NO4A9+wuj9UzC2YZUOfAU5FLkTR+9wG+nGKcbCl9MAU45Pzp98
	 zuo4SnPz+kAv8iE4xudGMigaO82CB7l+0V+h8DWAa+Lkd4+ufrbVZPcWyd0jf5buuQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE4pXnNy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1B606A321;
	Tue, 10 Nov 2026 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE4pXnNy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC9B1F0089F;
	Tue, 10 Nov 2026 22:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348281;
	bh=poGwgjpmsxdXo4E2tjeuNJNfqDre4+vtgrUuX7o6vhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EE4pXnNyIftrHc0enzk3tZXvrcDnMaB3850Jq1hDhw7BhvFJRNWrxSN80zX5+PYJr
	 su1cuKScN2RYyyppezHmxcPwK8VdMrSObERWsybzfiGtYSY9xeD/3Fm/6eMKy4Bj0I
	 +/nMGOR2umlQJg76aiQKP8hiPJl06k9fnP/k5Y34TRqVi+3I8M0FxKO4+dVxoymGd8
	 /9BJ0ddQVED+xNBQLYEh+lSg7Vf4qojiRGaLLq8z7gZAum/ta62FlB/qkHgdBVtSUx
	 Gzi8w5hJiesBMQhAJ3SsGx5443Z68bFwH7vfkxyCKDWIMSLwZv0I6PEq3tNU6hcG9S
	 Re+fcNyblNDgw==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.machon@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robert.marko@sartura.hr
Subject: Re: [PATCH net-next 1/9] net: sparx5/lan969x: stop the FDMA channels properly
Date: Tue, 10 Nov 2026 14:04:39 -0800
Message-ID: <20261110220439.2337145-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105-sparx5-mtu-change-v1-1-f27bab580463@microchip.com>
References: <20261105-sparx5-mtu-change-v1-1-f27bab580463@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: sparx5/lan969x: stop the FDMA channels properly

This commit adds the FDMA_CH_ACTIVE register. sparx5_fdma_stop() now
disables the RX and TX channels through FDMA_CH_DISABLE and waits for
them to become inactive. It also sets INJ_STOP and waits for
XTR_BUF_IS_EMPTY to become 1 instead of 0.

> The stop sequence is used by the FDMA deinit, and by the FDMA buffer
> resize added later in this series.

[Severity: Low]
Should this patch carry a Fixes: tag? These three problems all seem to
come from 10615907e9b5 ("net: sparx5: switchdev: adding frame DMA
functionality"):

  - the FDMA_CH_ACTIVATE read-modify-write that does nothing
  - INJ_STOP is never set
  - the inverted XTR_BUF_IS_EMPTY test

lan969x inherits them through the shared sparx5_fdma_stop().

sparx5_fdma_deinit() and lan969x_fdma_deinit() both free the DCB rings
and data buffers right after this stop. Before this patch the channels
could therefore still be active when that memory was freed. The old code
did set XTR_STOP before the free, though, so actual DMA into freed
memory is plausible but not proven.

The commit message presents the change as groundwork for the resize
patch and does not describe any user-visible impact. Would it make sense
to state the impact, add the tag, and perhaps send this to net
separately from the net-next feature series?

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> index 15ec9b053824f..bcae0bbd5e44e 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c

[ ... ]

> @@ -468,20 +471,39 @@ int sparx5_fdma_start(struct sparx5 *sparx5)
>  
>  int sparx5_fdma_stop(struct sparx5 *sparx5)
>  {
> +	u32 channels = BIT(sparx5->rx.fdma.channel_id) |
> +		       BIT(sparx5->tx.fdma.channel_id);
>  	struct sparx5_rx *rx = &sparx5->rx;
>  	struct sparx5_tx *tx = &sparx5->tx;
>  	u32 val;
>  
>  	napi_disable(&rx->napi);
>  
> -	/* Stop the fdma and channel interrupts */
> +	/* Disable the channels, and wait for them to finish the current DCB */
> +	spx5_wr(FDMA_CH_DISABLE_CH_DISABLE_SET(channels), sparx5,
> +		FDMA_CH_DISABLE);
> +
> +	if (read_poll_timeout(sparx5_fdma_ch_active,
> +			      val,
> +			      !(FDMA_CH_ACTIVE_CH_ACTIVE_GET(val) & channels),
> +			      SPX5_FDMA_STOP_SLEEP_US,
> +			      SPX5_FDMA_STOP_TIMEOUT_US,
> +			      false,
> +			      sparx5))
> +		dev_warn(sparx5->dev, "Failed to stop FDMA channels\n");

[Severity: Medium]
If this poll times out, the RX or TX channel may still be active.
sparx5_fdma_stop() only warns and still returns 0, and both callers
ignore the result and free the DMA memory right away:

sparx5_fdma_deinit() {
	sparx5_fdma_stop(sparx5);
	fdma_free_phys(&sparx5->rx.fdma);
	fdma_free_phys(&sparx5->tx.fdma);
	...
}

lan969x_fdma_deinit() {
	...
	sparx5_fdma_stop(sparx5);
	fdma_free_coherent(sparx5->dev, &tx->fdma);
	fdma_free_coherent(sparx5->dev, &rx->fdma);
	lan969x_fdma_free_pages(rx);
	page_pool_destroy(rx->page_pool);
	...
}

Neither deinit path resets the FDMA with FDMA_CTRL.NRESET after the
stop. Later in the series, only sparx5_fdma_pause() does that.

If a channel does not go inactive within 10 ms, can the FDMA keep
fetching DCBs from the freed rings? Can it keep writing frame data and
DCB status into freed memory, or keep transmitting stale buffer
contents?

Should the error be propagated to the callers, or the FDMA be reset
before the memory is released?

> +
> +	/* Stop the fdma and the RX channel interrupt */
>  	sparx5_fdma_rx_deactivate(sparx5, rx);
>  	sparx5_fdma_tx_deactivate(sparx5, tx);
>  
> -	/* Wait for the RX channel to stop */
> -	read_poll_timeout(sparx5_fdma_port_ctrl, val,
> -			  FDMA_PORT_CTRL_XTR_BUF_IS_EMPTY_GET(val) == 0,
> -			  500, 10000, 0, sparx5);
> +	/* Wait for the extraction buffer to be empty */
> +	read_poll_timeout(sparx5_fdma_port_ctrl,
> +			  val,
> +			  FDMA_PORT_CTRL_XTR_BUF_IS_EMPTY_GET(val),
> +			  SPX5_FDMA_STOP_SLEEP_US,
> +			  SPX5_FDMA_STOP_TIMEOUT_US,
> +			  false,
> +			  sparx5);

[Severity: Medium]
The extraction stop order is now the reverse of the old code. The old
code set XTR_STOP in sparx5_fdma_rx_deactivate() first and then polled
the extraction buffer. The new sequence is:

sparx5_fdma_stop()
    spx5_wr(... FDMA_CH_DISABLE)
    read_poll_timeout(... FDMA_CH_ACTIVE ...)     up to 10 ms
    sparx5_fdma_rx_deactivate()
        spx5_rmw(FDMA_PORT_CTRL_XTR_STOP_SET(1), ...)
    read_poll_timeout(... XTR_BUF_IS_EMPTY ...)

XTR_STOP is still clear during the CH_ACTIVE wait. Can the queue system
keep pushing CPU-bound frames into the extraction buffer during that
window?

By the time XTR_BUF_IS_EMPTY is polled, the extraction channel is
already inactive. Is anything left that can move the buffered data to
memory?

If not, this poll will hit its full 10 ms timeout whenever frames arrive
in that window. That is the same "wait always runs until it times out"
symptom the commit message says it fixes. The timeout is also dropped
silently here, while the CH_ACTIVE poll above warns.

No extraction buffer reset or DB discard follows the stop either. The
lan966x driver uses the same FDMA IP and does this in
lan966x_fdma_rx_disable() after the channel goes inactive:

	lan_rmw(FDMA_CH_DB_DISCARD_DB_DISCARD_SET(BIT(fdma->channel_id)),
		FDMA_CH_DB_DISCARD_DB_DISCARD,
		lan966x, FDMA_CH_DB_DISCARD);

Later in the series, sparx5_fdma_pause() drains the CPU queues before
the stop. After it, it pulses FDMA_CTRL.NRESET and calls
sparx5_xtr_flush(), which covers the resize path. The deinit path
(sparx5_cleanup_fdma()->fdma_deinit) gets no reset, though. The
ordering and the ignored drain timeout are still in sparx5_fdma_stop()
at the end of the series.

Would it be better to set XTR_STOP before disabling the extraction
channel, and to warn when this drain poll times out?
-- 
pw-bot: cr
