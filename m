Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F94352C28
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 04:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754761; cv=none; b=KBd5qiT3514vVf0FQ1EADGasoxNQrKXEOzKx7J/RW642gE150knIsehXjVRoFg4GFFEepO9rY7EydXvxRtw3mpqVHAMyVS9lu0/st5jxe7U/X+ubvi0AxfrGSfmcRMG3UhGttRLB8w90fXpULgaSXhEJxW+SSho/CWoK2FrtZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754761; c=relaxed/simple;
	bh=8Lp3O2YQA+sr5wmIFXszjCVdBHU0lXzP9lbao0s7/eo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxiSxfTcRLa9wvZ7CjZPRymTHoRiAZcUtXK6ghUlIcdrtxS585e0kjPi6b6Fgg23SQB09fzwF6bXh8PbFNMr/QKBF31/hDGMzZwD+dZYrierRA4VODPfLBNWKmQLZF+AsI1v+v3I0VelkBWeSzWTqBnhifTDL8hV9cvnOV6V+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUD5PkaI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUD5PkaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5B81F00A3A;
	Mon,  7 Sep 2026 04:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788754759;
	bh=b/VzLpeQsucbfiCe5buADMh2osvOrCvujrE4SxUhNhA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LUD5PkaInlluFenOu5TBId5Jzgde07W6v8JTo6RLtXjIN5PY+D6cspeJW/MBvWv4z
	 Hcey04Fjnmt4aqK6XJMT/K3dgz0nPQufVZwmm1/INzfrxJ8yz/tgZRAtxONwOjbuaP
	 15Kqil1cnXCMAfgmFcJD88l86uRia/Zop19cu3xjmaMMJhWaXYn8kJZOaK2iZLJyW1
	 u2MAXc8nsMyB5pUsjFvOGd8XbMUo0yHNsuQuCEBF2UjGrr2TB1iHaMbnUI1N8u1Osc
	 QUb6dR+Zvid8ZTnHtrsO8pxzLrBKnDY7y6HNFuVvuBrOV20w9mNqr16h7Ag7+Ix3sa
	 j/Ee4GBNcrv5Q==
Subject: Re: [PATCH v2 1/5] net: ethernet: cortina: Fix budget accounting
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, netdev@vger.kernel.org, joe@dama.to
Date: Mon, 07 Sep 2026 04:19:18 +0000
Message-ID: <178875475894.219967.17452530891894962234@kernel.org>
In-Reply-To: <20260903-gemini-ethernet-fixes-v2-1-2bbbd598ca6e@kernel.org>
References: <20260903-gemini-ethernet-fixes-v2-1-2bbbd598ca6e@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 (4) · Low: 0

- [Medium] At this commit, gmac_rx()
  (drivers/net/ethernet/cortina/gemini.c:1443-1571) increments the new…

Pre-existing issues:
- [Medium] gmac_napi_poll() at drivers/net/ethernet/cortina/gemini.c:1591
  does `port->freeq_refill += received;` and compares the result against…
- [Medium] gmac_napi_poll()
  (drivers/net/ethernet/cortina/gemini.c:1584-1589) discards the return…
- [Medium] gmac_napi_poll()
  (drivers/net/ethernet/cortina/gemini.c:1581-1598) opens the…
- [Medium] Duplicate view of the same ordering defect from a different
  stage: gmac_napi_poll()…

--

net: ethernet: cortina: Fix budget accounting

gmac_rx() used to return the leftover NAPI budget while gmac_napi_poll()
treated the value as a packet count, so an idle poll reported a full
budget. The patch adds a separate received counter, returns it, and
changes the free queue refill credit to add that count directly.

Link: https://lore.kernel.org/r/20260509-gemini-ethernet-fixes-v1-4-6c5d20ddc35b@kernel.org
Link: https://lore.kernel.org/r/20260512131456.189452-1-pabeni@redhat.com

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 4c762229ce420..1d9824d1716cf 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -1545,7 +1546,8 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  			napi_gro_frags(&port->napi);
>  			skb = NULL;
>  			frag_nr = 0;
> -			--budget;
> +			budget--;
> +			received++;
>  		}
>  		continue;

[Severity: Medium]
Should the drop paths in gmac_rx() also count towards received and
budget?  This is the only site that touches either counter, and it is
inside the successful GRO branch.

Descriptors that end up on a drop path still advance the ring read
pointer r but contribute nothing:

  - gmac_skb_if_good_frame() returning NULL (descriptor status error,
    short frame, RX status or checksum error, fragment allocation
    failure) jumps to err_drop
  - a zero DMA mapping jumps to err_drop
  - gmac_get_queue_page() failure does "continue"
  - a non-SOF descriptor with no in-progress skb does put_page() and
    "continue"
  - frag_nr == MAX_SKB_FRAGS jumps to err_drop

Since the loop condition is:

	while (budget && w != r) {

a sustained stream of malformed frames, or frag allocation failures
under memory pressure, lets one poll walk the whole available RX ring
while returning little or no work.  Does that defeat budget enforcement
in gmac_napi_poll() and allow softirq monopolization?

The later patch f27033c2d9b5 ("net: ethernet: cortina: Count dropped
frames as NAPI work") moves budget--/received++ to a common next_desc
EOF path, which appears to address exactly this, so this is noted for
the record.

> @@ -1565,7 +1567,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  	port->rx_skb = skb;
>  	port->rx_frag_nr = frag_nr;
>  	writew(r, ptr_reg);
> -	return budget;
> +	return received;
>  }
>  
>  static int gmac_napi_poll(struct napi_struct *napi, int budget)
> @@ -1586,7 +1588,7 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
>  		++port->rx_napi_exits;
>  	}
                ^^^

[Severity: Medium]
This is a pre-existing issue and not introduced here, but the branch
above discards the return value of napi_complete_done() and then
re-arms the hardware RX interrupt unconditionally:

	if (received < budget) {
		napi_gro_flush(napi, false);
		napi_complete_done(napi, received);
		gmac_enable_rx_irq(napi->dev, 1);
		++port->rx_napi_exits;
	}

The kernel-doc in include/linux/netdevice.h says "Return: false if
device should avoid rearming interrupts", which is how
defer_hard_irqs / gro_flush_timeout / prefer_busy_poll deferral is
implemented in net/core/dev.c:napi_complete_done().

Does this patch make it more visible?  Before the change the branch was
entered based on the inverted value, whereas now every non-budget
exhausting poll, including a fully idle one, calls
napi_complete_done(napi, 0) and re-enables the IRQ regardless of the
answer.

The conditional form arrives later in the series in 8dd58e3d1305
("net: ethernet: cortina: Finish RX updates before NAPI completion") as
"if (received < budget && napi_complete_done(napi, received))", so this
is for the record.

>  
> -	port->freeq_refill += (budget - received);
> +	port->freeq_refill += received;
        ^^^

[Severity: Medium]
This isn't a regression from this patch since the old expression
evaluated to the same frame count, but are the units on the two sides
of this comparison the same?

	freeq_threshold = 1 << (geth->freeq_order - 1);
	...
	port->freeq_refill += received;
	if (port->freeq_refill > freeq_threshold) {

freeq_threshold is expressed in hardware free queue fragment entries,
and geth_fill_freeq() accounts one fragment reference per entry
("count += 1 << fpp_order").  Meanwhile received counts completed
frames only.

Each loop iteration in gmac_rx() consumes exactly one RX descriptor,
and therefore one free queue fragment, as the read pointer shows:

	r++;
	r &= m;
	...
	writew(r, ptr_reg);

Non-final fragments of multi-descriptor frames (freeq_frag_order is
fixed at DEFAULT_RX_BUF_ORDER, about 2 KB, and does not scale with MTU)
and all descriptors taken by the drop paths credit zero refill.  Can
that make the proactive half-empty refill fire late, or effectively
never during a fragment or drop storm, leaving only the SWFQ_EMPTY
threshold interrupt as a backstop and producing avoidable RX drops plus
"HW BUG: zero DMA desc" errors?

The later patch 230757ee03c5 ("net: ethernet: cortina: Count RX
descriptors for freeq refill") adds a freeq_consumed out-parameter that
counts every consumed descriptor, so this is noted for the record.

[Severity: Medium]
This is also pre-existing rather than introduced here, but the port
state updates around this line run after NAPI ownership has been
released.  gmac_napi_poll() opens the writer section first:

	u64_stats_update_begin(&port->rx_stats_syncp);

	received = gmac_rx(napi->dev, budget);
	if (received < budget) {
		napi_gro_flush(napi, false);
		napi_complete_done(napi, received);
		gmac_enable_rx_irq(napi->dev, 1);
		++port->rx_napi_exits;
	}

	port->freeq_refill += received;
	...
	u64_stats_update_end(&port->rx_stats_syncp);

Once napi_complete_done() clears NAPI_STATE_SCHED and
gmac_enable_rx_irq() unmasks the RX interrupt, can a new interrupt on
another CPU start a second poll for the same port while the first is
still in its epilogue?

CPU0 gmac_napi_poll()
	napi_complete_done()	/* clears NAPI_STATE_SCHED */
	gmac_enable_rx_irq()
	/* still inside the rx_stats_syncp write section */

CPU1 gmac_irq()
	napi_schedule(&port->napi)
	  -> net_rx_action -> gmac_napi_poll()
	       u64_stats_update_begin(&port->rx_stats_syncp);

u64_stats_sync requires writers to be mutually exclusive per syncp, and
this driver runs on 32-bit ARM where u64_stats_update_begin() is a real
write_seqcount_begin().  With two overlapping writers, can
gmac_get_stats64() / gmac_get_ethtool_stats() observe an even sequence
mid-update and return torn 64-bit counters?  And can the non-atomic
read-modify-write on port->freeq_refill lose updates and skip the
refill this patch is trying to preserve?

This patch does not create the structure, but it makes the completion
branch run on every non-budget-exhausting poll, including previously
skipped idle polls.  The ordering is corrected later in the series by
8dd58e3d1305 ("net: ethernet: cortina: Finish RX updates before NAPI
completion"), where the stats section and the freeq_refill block
complete before napi_complete_done().

[Severity: Medium]
Same pre-existing ordering point seen from the NAPI documentation side,
not something this patch introduces: the NAPI documentation asks drivers
not to touch their own data structures after releasing ownership,
because another poll instance or napi_disable() may proceed.  Here
port->rx_napi_exits, port->freeq_refill and the closing
u64_stats_update_end() all run after napi_complete_done() and
gmac_enable_rx_irq().  Would it be safer to finish all per-port
accounting before releasing NAPI ownership, as 8dd58e3d1305 ("net:
ethernet: cortina: Finish RX updates before NAPI completion") later
does?

>  	if (port->freeq_refill > freeq_threshold) {
>  		port->freeq_refill -= freeq_threshold;
>  		geth_fill_freeq(geth, true);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e%40kernel.org
