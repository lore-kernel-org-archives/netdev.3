Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504796;
	b=bVeWMBTokSqUAoKviaauzk956OzAKUCFQ02CzFkTv3S1q8ip7z9VQC2mJ/QN03uxmU5A
	 J0hdTQKBl4fxVA8AnMKwyxsZ9JtNwwwh3U5S0itnOM8oYe8t5hlZ54YDo4m8W9FEylyhG
	 Ftt4h1ZMvH1/pgHtH0zyLRYMSSFMSzgfCial3NvdsxOt6bUsxlBJiWICac+p0R9kTKHdM
	 b0rcZPSCLKxfNd9qr82DsN1o3LDVIqLjTfxW2Oc8a15MPER2b2sa76ZMx0wDZVPlAsjQ3
	 xbVr6rVCPGJJ3pkO1qN1IWgGYVx4gtr3ZGWuMxEIZeqVRffd3uy9NFghxG0sqqo8Ijg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504796;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kLqQj0fPXIjHp2jTl7IwJO//6P6zW5QHVSed10H8W/w=;
	b=xXb+2mwyJdC0aE3FR959apm7Y6nC4gUcIph6K3YY8vQRAejvVV85dPeEh0wpyHAmTXaZ
	 K3ty0jCRuSE9YBXbdzxLXwdd/QZKOwSVejbpy4NHup7SmeSpGGZfDqcMw5+9kOwFh7sGh
	 DH6XCKC/9NSNRpLAxzTDZGrJ/x4NK40yomBq2n8t2dhcS28JLahErGlm3OgSYRTy84c3s
	 W0YmHbVoAewwhUfYQRq1VagoJJxV/k9L8FJz07+oFhkFENp83Ji+sxSzPMZJjtheSfCXQ
	 X0ibKh3UUNDJn8UQI+zOpyJYh5fuAYmbVVsKeQmMm02rcs2BsxeAmvWvr5UgHpwKzdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzzxEmNf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E9606A8A0;
	Thu, 12 Nov 2026 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzzxEmNf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD761F000C5;
	Thu, 12 Nov 2026 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504796;
	bh=kLqQj0fPXIjHp2jTl7IwJO//6P6zW5QHVSed10H8W/w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nzzxEmNfsOO+sjTDRk9YkiRVjwgqlpFBNsjFxlhC2Lfe7bQNWc1pq4I+C3hKreA0W
	 kf2bZnKqfwNleY4H8ePgIqEFgef60qD4cr6J4E5iyO1ZgrMlX1cDRT2rsrL22yViFk
	 l+owVvmVZ/9KMWdFpM2mfV/kKRpDQcPyV3IlJq3bInDAMK0FJs9ItTrMFrTVZgG8zh
	 XA/NmPJk2QNJiShKMmjT7hSyrPmDH8d52jVB4q+aXeaV/50xliYJ/Xyi6yWtSPMsTl
	 x+g4OqeL0mrANifP+WT58rjoOO+Yvxjo5+njkGUITKy1YgbGycKwmjm83zWXbHA4r5
	 ajeG8ofuUfskA==
Subject: Re: [PATCH net-next v2 1/9] net: sparx5/lan969x: stop the FDMA
 channels properly
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robert.marko@sartura.hr,
 horatiu.vultur@microchip.com, jensemil.schulzostergaard@microchip.com
Date: Thu, 12 Nov 2026 17:33:14 +0000
Message-ID: <179450479493.2199510.4440156833220844993@kernel.org>
In-Reply-To: <20261111-sparx5-mtu-change-v2-1-59c91357e8f6@microchip.com>
References: <20261111-sparx5-mtu-change-v2-1-59c91357e8f6@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] If the FDMA_CH_ACTIVE poll in sparx5_fdma_stop()
  (sparx5_fdma.c:486-493) times out, the function only calls…
- [Low] In sparx5_fdma_stop()
  (drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c:472-509), the…

--

net: sparx5/lan969x: stop the FDMA channels properly

This commit changes sparx5_fdma_stop() to disable the FDMA channels
through FDMA_CH_DISABLE and to poll the new FDMA_CH_ACTIVE register until
they are inactive. It also stops the injection port through INJ_STOP. The
XTR_BUF_IS_EMPTY poll now waits for the buffer to be empty instead of
non-empty.

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
If this FDMA_CH_ACTIVE poll times out, what stops the channels from
continuing to DMA into memory that the callers free right afterwards?

In that case sparx5_fdma_stop() only warns and still returns 0. Both
deinit callers ignore the return value anyway, and free the DMA memory
without resetting the FDMA:

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

A channel that is still active keeps the DCB addresses in its LLP
registers. Could it then fetch DCBs from the freed coherent rings, or
write extracted frames into RX pages or skbs that have already gone back
to the allocator? Unbind/remove reaches this through
sparx5_frame_io_deinit()->ops->fdma_deinit()->sparx5_fdma_stop().

The code alone doesn't show whether a channel can really stay active
longer than SPX5_FDMA_STOP_TIMEOUT_US after CH_DISABLE. Still, the timeout
branch exists, and the frees after it run no matter what the stop returns.

Later in this series, "net: sparx5/lan969x: add support for resizing the
FDMA buffers" adds sparx5_fdma_pause(). It follows sparx5_fdma_stop() with
an FDMA_CTRL NRESET before the buffers are freed. That covers the resize
path, but the deinit paths still have no reset.

Would it make sense to return -ETIMEDOUT from sparx5_fdma_stop(), or to
assert FDMA_CTRL NRESET in the deinit paths before releasing the DMA
memory, or both?

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

[Severity: Low]
Can this poll still time out while RX traffic is arriving?

The extraction channel is disabled and polled inactive first, while the
extraction port is still running. XTR_STOP is only set after that, in
sparx5_fdma_rx_deactivate():

	/* Stop RX fdma */
	spx5_rmw(FDMA_PORT_CTRL_XTR_STOP_SET(1), FDMA_PORT_CTRL_XTR_STOP,
		 sparx5, FDMA_PORT_CTRL(0));

Frames may keep reaching the CPU extraction queue during that window, and
CPU forwarding (QFWD_SWITCH_PORT_MODE_PORT_ENA) stays enabled on the
deinit path. If so, there may be no active channel left to move data out
of the extraction buffer, and XTR_BUF_IS_EMPTY might never become 1.

The result of this read_poll_timeout() is also discarded and nothing is
printed. A non-empty buffer therefore looks the same as a clean stop.

The commit message says the old wait "always runs until it times out".
Could the new wait still do that in this case?

Later in the series, sparx5_fdma_pause() disables CPU forwarding and
drains the CPU queues before it calls sparx5_fdma_stop(). That suggests
the stop sequence alone does not handle extraction that is still in
progress.

Would it help to set XTR_STOP before disabling the channel and poll
XTR_BUF_IS_EMPTY while the channel is still active? Another option is to
flush the buffer with FDMA_PORT_CTRL_XTR_BUF_RST, which is defined in
sparx5_main_regs.h but never used. At the very least, checking and
reporting the poll result would keep the diagnostic.

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-sparx5-mtu-change-v2-0-59c91357e8f6%40microchip.com
