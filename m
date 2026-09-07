Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCCE2F8E8E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754762; cv=none; b=mG7QxzgYceL6KYYYp1cB+peiZz5KRIQdiaqU0tqYDMLC2CxaeJf1/GsWCP51a0rVUShxpml9OiXrhy9SpkdYvCrGdZ/Q+AfSOkJOMnHpxBBdYElYGcP7GFTqfhVUAcGzKOn/YUlcaLjj8WOEc6emQob4gTj40NirCOdjetFuBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754762; c=relaxed/simple;
	bh=curmL2RhS383SYSz47R75n25GiYfsuiC1H84FoNweEo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XiwOIJrR/XzkI3oTg6RgmMiOGK371+dD2ZN2jBUP3QvOyGt+PSv6+mISXMiU36+uxvcylet8P7M2hKDUDIeKZbcXN/vutzSN8D/8KY9nEVhGk44RU32vTX1UZj4bAqk0H7JJdKFDWo7iJz0Qt/SNLYqVwusVPLtdOpvLNQO2dhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoSd91oT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoSd91oT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B141F00A3D;
	Mon,  7 Sep 2026 04:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788754761;
	bh=am67LiFwOcT5w/XxvfUiyOdZjGhG3DG1nqcu6vUOlAM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VoSd91oTOmHF4u08mCuOSsp/Y3QW0wdKc7WbOralOELl12yZrHp/ncH4y3NmBgn3s
	 eiF9ud9XoOAs8OE0atsKKEUIebjyfuVluA2PSDXE9oNum4jSIiwY7Q4hBPnEkoYeRv
	 +JMwygJx5UCsPemuxYdtjRUsna2gVTrpZE3SBsEjhd23oy+rwhErlac90elk1nje6n
	 fduwS/w5xYTaF7LvENFMsN5qbTazKDLqrJCup6A1Ab21uG/KrnJ8JUJKi9b28e44ht
	 +5Qfu0DTbWyzlQTEQ2PKanj59ToI9PAeFrit2HmXS+P2taXR08ADWS/9qhJcV6zmPN
	 k92ijAlQSfcuQ==
Subject:
 Re: [PATCH v2 3/5] net: ethernet: cortina: Count dropped frames as NAPI work
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, netdev@vger.kernel.org, joe@dama.to
Date: Mon, 07 Sep 2026 04:19:20 +0000
Message-ID: <178875476002.219967.18441005738647136926@kernel.org>
In-Reply-To: <20260903-gemini-ethernet-fixes-v2-3-2bbbd598ca6e@kernel.org>
References: <20260903-gemini-ethernet-fixes-v2-3-2bbbd598ca6e@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incomplete fix: in gmac_rx()
  (drivers/net/ethernet/cortina/gemini.c) the new common accounting…

--

net: ethernet: cortina: Count dropped frames as NAPI work

This moves the budget-- and received++ accounting in gmac_rx() out of the
successful delivery path and into a new common next_desc label, so that
frames which are dropped also consume NAPI budget. The error paths now
jump to next_desc instead of using continue.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 6502220362cbd..33e9763b32fe8 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -1523,7 +1523,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  
>  		} else if (!skb) {
>  			put_page(page);
> -			continue;
> +			goto next_desc;
>  		}
>  
>  		if (word3.bits32 & EOF_BIT)
> @@ -1546,10 +1546,8 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  			napi_gro_frags(&port->napi);
>  			skb = NULL;
>  			frag_nr = 0;
> -			budget--;
> -			received++;
>  		}
> -		continue;
> +		goto next_desc;
>  
>  err_drop:
>  		if (skb) {
> @@ -1562,6 +1560,13 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  			put_page(page);
>  
>  		port->stats.rx_dropped++;
> +
> +next_desc:
> +		/* Final or single-descriptor fragment, advance things */
> +		if (word3.bits32 & EOF_BIT) {
> +			budget--;
> +			received++;
> +		}

[Severity: Medium]
Since the accounting is gated on EOF_BIT, does this fully close the case
described in the commit message ("a stream of bad frames can process the
entire receive ring in one poll")?

The loop guard is the only per-descriptor limiter:

	while (budget && w != r) {
		...
		r++;
		r &= m;

so any descriptor that reaches next_desc with EOF_BIT clear still advances
r at no cost to budget. Paths that can do that in gmac_rx() are:

	if (!mapping) {
		netdev_err(netdev,
			   "rxq[%u]: HW BUG: zero DMA desc\n", r);
		goto err_drop;
	}

Here the driver has just concluded the device never wrote the descriptor,
and word3 comes from the same dma_alloc_coherent()-zeroed slot, so EOF_BIT
is clear and err_drop falls through to next_desc. Each such descriptor also
emits one unratelimited netdev_err() from softirq context.

The other uncharged paths are the "could not find mapping" gpage failure on
a non-final fragment, the orphan-continuation case:

		} else if (!skb) {
			put_page(page);
			goto next_desc;
		}

and the frag_nr == MAX_SKB_FRAGS drop when the descriptor is not the final
fragment.

Also, is the frame abandoned by an unexpected SOF counted anywhere?

		if (word3.bits32 & SOF_BIT) {
			if (skb) {
				napi_free_frags(&port->napi);
				port->stats.rx_dropped++;

That bumps rx_dropped and frees the partial frame, so a frame was
definitively dropped, but neither budget nor received changes, which reads
differently from "counts each completed frame as NAPI work whether it was
delivered or dropped".

For a descriptor stream that never presents EOF (zeroed or never-written
descriptors, repeated SOF without EOF), one poll can still walk the whole
snapshot, up to 1 << port->rxq_order entries: 512 with
DEFAULT_GMAC_RXQ_ORDER of 9, and up to 32768 after

		port->rxq_order = min(15, ilog2(rp->rx_pending - 1) + 1);

in gmac_set_ringparam(). The loop does terminate since r converges on the
snapshotted w, and received == 0 lets gmac_napi_poll() call
napi_complete_done(), so this is softirq residency and log flooding rather
than a hang.

Would charging work per descriptor consumed be more robust than inferring
frame completion from a field of a descriptor that may itself be invalid?
Note the later patch in this series that adds the freeq_consumed counter
already tracks a per-descriptor count, and the EOF_BIT gating at next_desc
is still present at the end of the series (230757ee03c5).

The related concern about port->freeq_refill += received diverging from the
number of descriptors the MAC consumed is addressed by the later commit
"net: ethernet: cortina: Count RX descriptors for freeq refill", so that
part is not raised here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e%40kernel.org
