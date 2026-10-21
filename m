Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576358;
	b=ehOOzMXNalNs/6nRHzIl24V/D3+J+IHoWYlvm+cDo6H/U0E14J93LSeSGfUP8ZiQZDWX
	 gYiDRiZaZDvNULN38pRt3cSWr0tyT2kDZmytHC5JwRA9nLfVsv8JDRvwtAEhXzUx4Eljj
	 yMNxKrBFsqbBmPDgfT/osqIkVpH7Jooo/QS+mJOouJCQ/JpsmYOtCNG9Rw0kaYElliXV/
	 byMeS8Tfk2JZfYleV/uFp0p5UBD3ApXh5juczcpp03YvJwfwH7jfBxjzb+W4ezT6knDOl
	 jTrIPKFtOMdZlZwnyjg0kRm+ApgCVlkplbb3kFy+d6AaO18IP8t0zAWyiBPlMWeCQ8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576358;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Jh8LWRqw7DncpLM61emszsrjL10lzFZXGuGfzebDIgs=;
	b=YVsmW0dO2zSwjqvD14yWZL9sngJdqtxQkqo9xMsO9TCp8EZpL0prViP6Yun/PcTy6U3z
	 xQjEw8j160xwKOWMkWUwIUc9Cu+RTljTfhNnzwjpEi/e9g0IKuew+wKOulI6ExWyg3B1X
	 Sf86gTNPBwMutgmigP3wWkCvaHO6mYDjA6v1JPPefN1Zf+PUlThYxlUQYVX/Pki9PaL2C
	 0q+wUPBYL06yg6oGeu8Pset8+iI9KGLkUuEXJeYFqOX0C+ScwVqpGvwavE1eSL3nqAfsP
	 BTrU2JSdECB4ocrT4XE1vllug8t0cI56x7lnoVfOIIVHgqou2s30uPEHa/F1H2gd0Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZqkc8zU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7CE606A319;
	Wed, 21 Oct 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZqkc8zU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520C51F000C9;
	Wed, 21 Oct 2026 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792576358;
	bh=Jh8LWRqw7DncpLM61emszsrjL10lzFZXGuGfzebDIgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kZqkc8zUyjzFXA7B/p0KIOS2HwclJEbuItJ8ll5qV1ajq+85AHwHEMeqOBtuxN8PC
	 m1I/PfMVpGUfH+fA4Xq2dEBkQxGwbauGNf3LCUk71iDdpqYXf9KaANCAiWaFZcBN7B
	 sNa1r2e+ce5ZYE37tTORR7TIfowh6t1nZL0CwpSxz7hWtiAZmSNDDVJXmOi/9GlgjV
	 ODYRvSb82KJz7brGR6Zizid+HYEuQMhTAI+8wnbf4n1+O24t85biAOd3bTPPFxECjO
	 xMHrkwW7KopACTixVN7yQBbfrk+EhVU2AbWxQOYwOYNpteYmFccJ7YRxG+Nv+3SfoC
	 7+g94nh5J2tnA==
Subject: Re: [PATCH net] net: sparx5: don't reuse the last DCB in fdma xmit
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, jensemil.schulzostergaard@microchip.com,
 horatiu.vultur@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Oct 2026 09:52:36 +0000
Message-ID: <179257635682.3135.3561272765367316822@kernel.org>
In-Reply-To: <20261020-sparx5-fdma-last-dcb-v1-1-fb9a956196dd@microchip.com>
References: <20261020-sparx5-fdma-last-dcb-v1-1-fb9a956196dd@microchip.com>
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

Critical: 0 (1) · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: sparx5: unguarded fdma_dcb_advance() in sparx5_fdma_xmit()
  breaks tx ring

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the patch
  adds a new way to reach it.

--

net: sparx5: don't reuse the last DCB in fdma xmit

This patch adds a check to sparx5_fdma_xmit() so it rejects the next tx
DCB when that DCB is fdma->last_dcb. This uses the same !fdma_is_last()
guard as lan966x and lan969x, so the tail of the chain is never re-added
and the frame is not lost.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> index dbe86f937b21..221b2f1932f6 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> @@ -218,7 +218,8 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
>  	void *virt_addr;
>  
>  	fdma_dcb_advance(fdma);
> -	if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)))
> +	if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)) ||
> +	    fdma_is_last(fdma, fdma_dcb_next_get(fdma)))
>  		return -EINVAL;

[Severity: High]
Does this fully fix the drift described in the commit message? The
underlying problem looks like it is still there: fdma_dcb_advance() runs
before the done check, and fdma->dcb_index is not restored when
sparx5_fdma_xmit() returns -EINVAL. The new fdma_is_last() test only
covers the moment dcb_index lands exactly on last_dcb.

When the ring is full, a failed xmit leaves dcb_index on the oldest
in-flight DCB. The next call advances again before checking anything,
so if the FDMA has completed that DCB in the meantime it is skipped and
we test a newer DCB that is still in flight. Each failure moves
dcb_index one step further, so a burst can keep dropping frames while
completed DCBs sit unused behind dcb_index.

If dcb_index ends up just behind last_dcb and the FDMA then drains the
chain, every DCB is done and the ring is idle. The next xmit advances
onto last_dcb, hits the new fdma_is_last() check and returns -EINVAL,
which sparx5_port_xmit_impl() treats as a drop:

	if (ret == -EBUSY)
		goto busy;
	if (ret < 0)
		goto drop;

The lost frame becomes a counted drop, but it is still a drop on an
empty ring. lan966x_fdma_get_next_dcb() and lan969x_fdma_get_next_dcb()
don't hit this because they use !fdma_is_last() inside a loop over all
DCBs and pick another free one, rather than failing on a single index.

The previous tail is also still unsafe. Say the FDMA has halted on
last_dcb at index L and dcb_index is at L - 2. The first frame advances
to L - 1, which is done and not last, so it is linked from
dcbs[L].nextptr and becomes the new last_dcb. __fdma_dcb_add() does not
clear the done bit on dcbs[L], so if a second frame comes in before the
FDMA has fetched dcbs[L].nextptr after the reload, it advances onto L,
which is still done and no longer last. Re-adding it rewrites
dcbs[L].nextptr to FDMA_DCB_INVALID_DATA, so dcbs[L - 1] is cut out of
the chain. Its frame is lost, and since the FDMA never visits it again
its done bit stays clear, so later xmits that land on it fail too.

The drift itself dates back to f4aa7e361ae2, but since this patch is
meant to fix it, would it be cleaner to fix it at the source, by only
committing the dcb_index advance once the DCB has been accepted (or
rolling it back on failure)? Then dcb_index always follows last_dcb,
the next DCB is always the oldest one, and the fdma_is_last() check
should not be needed. Alternatively, sparx5 could search the ring the
way lan969x_fdma_get_next_dcb() does.

[Severity: Critical]
This is a pre-existing issue, but this patch adds a new way to reach it.
What happens to a two-step PTP skb when this returns -EINVAL?

For a two-step PTP skb, sparx5_port_xmit_impl() first calls
sparx5_ptp_txtstamp_request(). That function links the skb onto
port->tx_skbs and does not take an extra reference:

drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c:sparx5_ptp_txtstamp_request() {
    ...
	skb_queue_tail(&port->tx_skbs, skb);
	SPARX5_SKB_CB(skb)->ts_id = port->ts_id;
	SPARX5_SKB_CB(skb)->jiffies = jiffies;

	sparx5->ptp_skbs++;
    ...
}

When ops->fdma_xmit() returns -EINVAL, the caller jumps to the drop label.
Only the busy label calls sparx5_ptp_txtstamp_release():

drivers/net/ethernet/microchip/sparx5/sparx5_packet.c:sparx5_port_xmit_impl() {
    ...
drop:
	stats->tx_dropped++;
	sparx5->tx.dropped++;
	dev_kfree_skb_any(skb);
	return NETDEV_TX_OK;
busy:
	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
	    SPARX5_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
		sparx5_ptp_txtstamp_release(port, skb);
	return NETDEV_TX_BUSY;
}

That leaves the freed skb linked on port->tx_skbs. On the next two-step
request, sparx5_ptp_txtstamp_old_release() reads the freed skb's cb and
then frees it a second time:

drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c:sparx5_ptp_txtstamp_old_release() {
    ...
		if time_after(SPARX5_SKB_CB(skb)->jiffies + SPARX5_PTP_TIMEOUT,
			      jiffies)
			break;

		__skb_unlink(skb, &port->tx_skbs);
		dev_kfree_skb_any(skb);
    ...
}

sparx5_ptp_irq_handler() walks the same queue. It also reads
SPARX5_SKB_CB(skb)->ts_id from the freed skb. On this path the ptp_skbs
slot is never given back either.

The drop path has been like this since commit 121c6672b0191. Until now it
could only be reached through the !fdma_db_is_done() (ring full) case.
Before this patch, the case where dcb_index landed on last_dcb returned
NETDEV_TX_OK, so the PTP skb stayed queued safely. With the new
fdma_is_last() rejection, that case now goes through the same drop path.

Could the drop path call sparx5_ptp_txtstamp_release() for two-step PTP
skbs, the same way the busy path does?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-sparx5-fdma-last-dcb-v1-1-fb9a956196dd%40microchip.com
