Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D12347BBD;
	Sat, 10 Oct 2026 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660816; cv=none; b=VQottPz0zVyUVLtZqO5jhPm1KQRHV8gPKggsjl5mPbXXSI/B4UFuL/EpV9y1mO9VmpkiDuwoqPZgk897E9zDEB9bVaaAX/eBuLZ5Nh+MA48ucxMGj39QiT+Pa9V6u9RIIZQpQ/Y9CQFTmi9yS2/L4ZaHAaSlMf6JlFei/iuHn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660816; c=relaxed/simple;
	bh=CpfSA049zXIHBDqUxoWyWE6QWuPEyLZFEqo/eNSJUow=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gO1Ik/rTAQfcGF/z4WRJlCxCGXJFt56cx/UoxPHdfaRckdut+eDQSPLOX01EzNZ92hhyFsiagFkzHD+Bgzi8GmN1uFusWUBsT2EYpM9McOMjvpnUFIExdOfoJFeKwAreFVpdf3zestmPi178Wa8qRSLQSuXDtnlZwe2L+sSPczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqJDpcPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqJDpcPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399181F000FF;
	Sat, 10 Oct 2026 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791660814;
	bh=Fzc8+tRAJ7AEIcgEoxj0qZuy1DL8pWMSDU/7S8WvPk4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JqJDpcPmcKoMq7urKjL/VnW88zg5jigpwinjOujKwXW9hYcO+YPaQWMafgmmfGPJD
	 s3xlpr6B4tc6cynrlMPFTWtZRg6VEmK/U03e4T77SlpphXZc4eW6P96AIYvr2SGJ3v
	 tP4m03+EaH6v8IqsOXHyGXByTmqOaTEh7+XZWk+BrTxTl5/0EIQNxIbs6s8zf9VgtL
	 iZBh83ZgSub1QjYbwymyX0lX4Fyac9lcS4Tinmg22FTE0lYPFKZqF0A9efIH4VxHM3
	 chvMPsclOTkU/lTAlnIfkUfeGmLyTKCBMq6hbS3gPrn2Uz8jLBR4bLUJTZadDHfvYt
	 M3ksjNp85Cr7A==
Subject: Re: [PATCH net-next v3 4/8] ibmveth: step past bad RX correlators
 instead of spinning or oopsing
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, stephen@networkplumber.org
Date: Sat, 10 Oct 2026 19:33:32 +0000
Message-ID: <179166081271.434549.2458181310224040226@kernel.org>
In-Reply-To: <20261009183258.18624-5-mmc@linux.ibm.com>
References: <20261009183258.18624-5-mmc@linux.ibm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 3 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch's short-frame check is incomplete.
- [High] Returning budget - 1 does not make ibmveth_poll()'s schedule-
  and-continue path safe when threaded NAPI and busy polling are both…
- [High] net/ibmveth: TOCTOU double-fetch of RX correlator in
  harvest_buffer

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  ibmveth_rx_csum_helper() calls ip_fast_csum(iph, iph->ihl) whenever…

--

ibmveth: step past bad RX correlators instead of spinning or oopsing

This patch makes ibmveth_poll() advance the RX ring past slots with a bad
correlator, including correlators that name an inactive pool, instead of
breaking out and restarting on the same slot. It counts those slots as
drops and schedules a reset. It also drops frames that do not fit the pool
buffer or are shorter than an Ethernet header, and returns budget - 1 once
napi_schedule() has queued the NAPI.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index cee0e9783b2ab..55c0b5d6e0a9f 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1481,19 +1525,46 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)

[ ... ]

>  		} else {
>  			struct sk_buff *skb, *new_skb;
>  			int length = ibmveth_rxq_frame_length(adapter);
>  			int offset = ibmveth_rxq_frame_offset(adapter);
>  			int csum_good = ibmveth_rxq_csum_good(adapter);
>  			int lrg_pkt = ibmveth_rxq_large_packet(adapter);
> +			u64 correlator = ibmveth_rxq_correlator(adapter);
> +			unsigned int pool, room, off, len;
>  			__sum16 iph_check = 0;

[Severity: High]
The commit message says the bound uses the pool "from the correlator
that was validated, read once, not from a second read of the ring".
Doesn't ibmveth_rxq_harvest_buffer() still do that second read?

ibmveth_poll() now reads the correlator once with
ibmveth_rxq_correlator(). It uses that value to look up skb in
ibmveth_rxq_get_buffer() and to compute room. Every harvest after that
ignores it, though: this call, the copybreak call and the one on the
bad-frame path. ibmveth_rxq_harvest_buffer() loads
queue_addr[rx_queue.index].correlator again with a plain load and
passes that to ibmveth_remove_buffer_from_pool(). Nothing ties the
second value to the one poll validated.

Suppose the entry changes between the two loads, so skb is looked up
from slot A and harvested from slot B. On this reuse=false path:

- rx_buff_pool[].skbuff[B] is cleared and dma_addr[B] is unmapped.
  B goes on free_map, and the skb that was in slot B is leaked.

- skb A goes to napi_gro_receive() while it is still in skbuff[A],
  still DMA mapped and not on free_map. The driver still treats it
  as a posted buffer.

- On close or reset, ibmveth_free_buffer_pool() finds skb A in
  skbuff[A], unmaps it and calls dev_kfree_skb_any() on it after the
  stack has already freed it.

The copybreak and bad-frame paths would recycle slot B instead of A
in the same way.

ibmveth_rxq_correlator_valid() does not catch this, because both
correlators can be in range and name live skbs.

PHYP should not rewrite an entry once the toggle is set. But this
patch treats the correlator as untrusted, and the changelog says it
is read once. Should ibmveth_rxq_harvest_buffer() take the correlator
from its caller, so poll uses one value for lookup, bound check and
harvest? The new KUnit harvest test could read the ring entry itself
before calling it.

[ ... ]

> +			pool = correlator >> 32;
> +			room = min_t(unsigned int, skb_tailroom(skb),
> +				     adapter->rx_buff_pool[pool].buff_size);
> +			off = offset;
> +			len = length;
> +			if (unlikely(len < ETH_HLEN || off >= room ||
> +				     len > room - off)) {
> +				if (net_ratelimit())
> +					netdev_err(netdev,
> +						   "bad RX frame offset %u length %u (buffer %u), dropping\n",
> +						   off, len, room);
> +				ibmveth_rxq_harvest_buffer(adapter, true);
> +				netdev->stats.rx_dropped++;
> +				frames_processed++;
> +				continue;
> +			}

[Severity: High]

The commit message says this check fixes the case where "the checksum
helpers would write past a short frame". Is an ETH_HLEN minimum enough
for that?

Once this check passes, ibmveth_poll() and its helpers assume a full IP
header and TCP header and never look at skb->len:

ibmveth_poll()
    iph_check = iph->check;
    ibmveth_rx_mss_helper()     /* lrg_pkt or iph_check == 0xffff */
        skb_shinfo(skb)->gso_size = ntohs(tcph->check);
        tcph->check = 0;
        hdr_len = offset + tcph->doff * 4;
        skb_shinfo(skb)->gso_segs =
                DIV_ROUND_UP(skb->len - hdr_len, ...);
    ibmveth_rx_csum_helper()    /* csum_good */
        iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
        struct tcphdr *tcph = (struct tcphdr *)(skb->data + iphlen);
        if (tcph->check == 0x0000) {
            tcph->check = ~csum_tcpudp_magic(...);

A frame of about 14 to 92 bytes passes the new check, but these helpers
still read and write past the end of the frame. In
ibmveth_rx_mss_helper(), skb->len - hdr_len can also wrap.

On the copybreak path, those accesses land in the uninitialized tailroom
of new_skb.

On the non-copybreak path, they land in the pool buffer past the frame.
That path runs when the GFP_ATOMIC copybreak allocation fails, or when
rx_copybreak is set at or below the frame length.

The new bound also accepts a short frame at the very end of the buffer.
For pool 0 with room = 512, off = room - 34 and len = 34 leave
skb->tail == skb->end after skb_put(). eth_type_trans() then leaves 20
bytes of IPv4 header, so tcph sits at skb->end.

Wouldn't the tcph->check writes then land in struct skb_shared_info
(hwtstamps, gso_type, tskey or dataref, depending on ihl)?
skb_partial_csum_set() rejects this only after the write has already
happened.

Should there be per-protocol skb->len checks, or pskb_may_pull(), before
the IP and TCP headers are parsed, rather than a fixed minimum?

[Severity: High]

This isn't a bug introduced by this patch, but since this patch hardens
the RX path: should ibmveth_rx_csum_helper() check iph->ihl before it
calls ip_fast_csum()?

    if (iph->check == 0xffff) {
        iph->check = 0;
        iph->check = ip_fast_csum((unsigned char *)iph,
                                  iph->ihl);
    }

On ppc64, ip_fast_csum_nofold() in arch/powerpc/include/asm/checksum.h
documents that ihl "is always >= 5" and does:

    for (i = 0; i < ihl - 1; i++, ptr++)
        s += *ptr;

ihl is unsigned, so with ihl == 0, ihl - 1 wraps to 0xFFFFFFFF and the
loop reads about 16 GiB starting at the RX buffer, in NAPI softirq
context.

The ihl, check and ethertype fields and the IBMVETH_RXQ_CSUM_GOOD flag
all come from the sending partition. Could a single IPv4 frame with
ihl = 0 and check = 0xffff from a peer on the same virtual LAN oops or
stall this partition?

[ ... ]

> @@ -1581,10 +1661,16 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
>  		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
>  				       VIO_IRQ_DISABLE);
> +		rescheduled = 1;
>  		goto restart_poll;
>  	}
>  
>  out:
> +	/* napi_schedule() already queued us. Returning budget would
> +	 * make busy_poll_stop() queue the napi a second time.
> +	 */
> +	if (rescheduled && budget && frames_processed >= budget)
> +		return budget - 1;
>  	return frames_processed;
>  }

[Severity: High]

Does returning budget - 1 cover the case where threaded NAPI and busy
polling are both enabled?

busy_poll_stop() clears NAPI_STATE_IN_BUSY_POLL before it calls the
driver poll. Its own comment says "Unless rc == budget we no longer own
the NAPI instance". From there:

busy_poll_stop()
  ibmveth_poll()
    napi_complete_done()             /* succeeds */
    h_vio_signal(..., VIO_IRQ_ENABLE)
    napi_schedule()
      ____napi_schedule()
        set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
        wake_up_process(thread);
    goto restart_poll;               /* keeps processing the ring */

The woken kthread sees NAPI_STATE_SCHED_THREADED in napi_thread_wait()
and calls __napi_poll()->ibmveth_poll() on another CPU. Meanwhile the
original call is still running from restart_poll.

Can the two pollers then race, with no lock, on rx_queue.index and
toggle, rx_buff_pool[].skbuff[], free_map and producer_index? For
example, one harvest with reuse=false could clear and unmap an skb while
the other poller passes the same skb to napi_gro_receive().

The budget - 1 return only runs after this overlap. Continuing to poll
after napi_schedule() predates this patch, but this patch now reasons
about NAPI ownership after napi_schedule(). Would it be better to stop
processing once napi_schedule() succeeds, instead of jumping back to
restart_poll?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009183258.18624-1-mmc%40linux.ibm.com
