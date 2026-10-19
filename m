Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427646;
	b=pouNwORuUDtTbSjyVGeNz/o60/zZ33qXqKoPFFSsW/H/2Pxi1Mi1ctAI8+d/ZjvHIy7s
	 oaDjCZaXmopqw0HBcCrdVPQJQTRZOtkVsQkI4XneYUbpw5VXzC7HYdRinhGe9B9ucNppt
	 be4GZc5k3IkyNTso4IJx696MIZqjhyjb5vWMyyueNI2m/hzyoTJa7f3W1Sh3jQq40dHw5
	 GkhPyxSoVEtD6s7SLi2vLNVopzn36thOr8J2i5mTYZn9z7aiiHa4QQHBLLAH403K75HLD
	 xU24IydaRexTAJI314aMdpXLbhos/Dlpp8A+cajg/524MAaRleL7pTyEyh1joz/9jYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427646;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PS6ZQS8kXTgxRqgfxQ1kJS2QfBiBG2NGPCiekUyrwzs=;
	b=RMqtPOxMgsanPcz9hoQR/h7ZHY8h5hl12P9gn9CTM0K4xdLIKfB45W1jRpYiIYnwioSb
	 UzyfZ7Stiq/XYxRcp59QMq1zHfX8OrnFaws7Al4cPlhP1e/IKj7SmtjKBG3a2A9XampRq
	 1eu8jB5tS/MWDW2bjqt9mOM4sH5wgoVaY59pLizl8DbaT0Nsyx7R2esHxM7wjs7QePn8s
	 U3ZtdDhYxS5UIwAPwdMvDySFXWP+SriRSj54uEEqc5hNQ9msywx/QoZ1v3+LGNHcapjOK
	 IIfuF6sRSksEnQASpd54GROjUNIBOI3GM0hcw7N5g2YMisCOoerJ8rnMr9s0vO1YJyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqRCxpsL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B0606A31C;
	Mon, 19 Oct 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqRCxpsL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB26C1F000C4;
	Mon, 19 Oct 2026 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427645;
	bh=PS6ZQS8kXTgxRqgfxQ1kJS2QfBiBG2NGPCiekUyrwzs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bqRCxpsLrEiIqKqTY7s/oTtiPNI0ZYzHKXQ4FQVT5c/H1IH0hCexrBCDqWGyoiAeZ
	 NnkVgdReceQ9GSt+xDWmN6RJFBphOgDgqGDv6HZnBM0L2EiMcjUfO+bcJHfRQ2nZ3J
	 od/3za1SuJM886ZQooxrx+wJE09fs/iMLGc4HPExEOe3/iS1csPFhAhbPjA6LOqTmm
	 NQVtj1mPN6CoCQqUeACwsAvRzSYMVEwaYXrtz9L15aKlX2Sg0vwxMyJpFCIqvYoEmL
	 2yxGc/Gp74xB4/dG2ihc9bhxPpYtpx8MHgZ6xuCttRM6DvzrwIwVXHzNeIXxbJ9DAf
	 K2hjsAYypAZxw==
Subject: Re: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
From: netdev-bot+sashiko@kernel.org
To: cbabroski@nvidia.com
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, Raju.Lakkaraju@microchip.com,
 davthompson@nvidia.com
Date: Mon, 19 Oct 2026 16:34:04 +0000
Message-ID: <179242764415.3135.15367182924729818631@kernel.org>
In-Reply-To: =?utf-8?q?=3Cbf487e5d01fe6352069d4314087f680fea717cc5=2E1792008?=
 =?utf-8?q?404=2Egit=2Ecbabroski=40nvidia=2Ecom=3E?=
References: =?utf-8?q?=3Cbf487e5d01fe6352069d4314087f680fea717cc5=2E17920084?=
 =?utf-8?q?04=2Egit=2Ecbabroski=40nvidia=2Ecom=3E?=
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fully close the bug it targets.

Pre-existing issues:
- [Medium] lan743x_tx_open() and lan743x_rx_open() now use the new
  lan743x_dmac_{tx,rx}_reset() helpers, but on -ETIMEDOUT they only call…

--

net: lan743x: reset DMA channels that fail to stop

This patch makes lan743x_tx_close() and lan743x_rx_close() check the
result of waiting for the DMA channel to stop. If the channel is still
stop-pending or still started, they now issue a channel soft reset. The
reset sequence is moved into lan743x_dmac_tx_reset() and
lan743x_dmac_rx_reset(), and the open paths use these helpers and log a
message if the reset times out.

> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 82d3ec20ba259..9e1276cf313c8 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c

[ ... ]

> @@ -2221,11 +2239,22 @@ static int lan743x_tx_ring_init(struct lan743x_tx *tx)
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

[Severity: High]
What happens if this channel reset also times out?

The commit message says the soft reset is issued "and wait for it before
anything is freed". However, if lan743x_dmac_tx_reset() returns -ETIMEDOUT,
the code only logs it, and lan743x_tx_close() goes on with the normal
teardown:

lan743x_tx_close()
    ...
    lan743x_tx_release_all_descriptors(tx);  /* unmap and free skbs */
    ...
    lan743x_tx_ring_cleanup(tx);  /* dma_free_coherent() ring and head */

The commit message describes a wedged channel that may not honour the stop
request. Could that channel ignore the soft reset as well? It would then
keep fetching descriptors from, or writing the head index into, memory that
has already been freed and reused.

lan743x_rx_close() has the same pattern. After a timed-out RX reset,
lan743x_rx_ring_cleanup() unmaps and frees every RX skb, even though their
descriptors still have OWN set. It then frees the descriptor ring and the
head write-back buffer. On RX, the device could write packet data into
freed pages.

Later in the series, "net: lan743x: reset the device on TX timeout" does not
change this. It runs the global DMAC reset (DMAC_CMD_SWR_) from
lan743x_reset_work() only after lan743x_netdev_close() has already freed the
rings. A plain ifdown never reaches that reset at all.

Could the close paths act on the reset failure before freeing anything?
One option is to escalate to the global DMAC_CMD_SWR_ reset or clear PCI
bus mastering. Another is to leak the ring, the head buffer and the mapped
buffers when the channel can't be shown to be quiesced.

[ ... ]

> @@ -2271,11 +2300,11 @@ static int lan743x_tx_open(struct lan743x_tx *tx)
>  			  FCT_TX_CTL_EN_(tx->channel_number));
>  
>  	/* reset tx channel */
> -	lan743x_csr_write(adapter, DMAC_CMD,
> -			  DMAC_CMD_TX_SWR_(tx->channel_number));
> -	lan743x_csr_wait_for_bit(adapter, DMAC_CMD,
> -				 DMAC_CMD_TX_SWR_(tx->channel_number),
> -				 0, 1000, 20000, 100);
> +	ret = lan743x_dmac_tx_reset(adapter, tx->channel_number);
> +	if (ret)
> +		netdev_err(adapter->netdev,
> +			   "TX channel %d reset timed out\n",
> +			   tx->channel_number);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The old
code also discarded the return value of lan743x_csr_wait_for_bit(), and
this change only adds a log message.

After a failed reset, lan743x_tx_open() still programs TX_BASE_ADDR,
TX_HEAD_WRITEBACK_ADDR, TX_CFG_A/B/C and TX_TAIL. It then writes
DMAC_CMD_START_T_ and returns 0.

Can the interface come up on a channel whose soft reset never finished?
If the reset completes late, the register writes made while it was pending
may be lost or wiped.

lan743x_rx_open() handles the reset the same way. There, if RX_HEAD is
non-zero after a failed RX reset, the code takes this path:

	rx->last_head = lan743x_csr_read(adapter, RX_HEAD(rx->channel_number));
	if (rx->last_head) {
		ret = -EIO;
		goto napi_delete;
	}

That reaches lan743x_rx_ring_cleanup() without the stop and reset handling
that this patch adds to lan743x_rx_close().

Should the open paths return an error when the channel reset times out?

>  
>  	/* Write TX_BASE_ADDR */
>  	lan743x_csr_write(adapter,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792008404.git.cbabroski%40nvidia.com
