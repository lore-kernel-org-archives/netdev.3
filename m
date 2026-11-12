Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448944;
	b=eqoQ9AhzaFRRavXbApMafHoyl1dpDSD3vCQS1SPCX/HK8SAsmw0XxN3DgOSrwQhm2fyb
	 UomXu00WLmSoe4/sRJ6BAT1sCky1HxCAZUFPgRrsChbQQSjjLl7noQ0bmKr7rOnU017ny
	 xHamqE5k6iRdBA/1GNuUPCb87GzpZNL7ee/ygQucwwm6cuQP0hNPfeaPetXI0swVxUh+c
	 1FrzwYOQZ6vrYkewxE9bP26yYfVj7sUfE3nWqydQSeoKEf6LE/lg1RXIc2mzDhHPoSUTX
	 CosLpKgoRhx+0MQuu6eNK05wB0rrE3IfE3HdFLQIxrr4wFWnzhk6Hxpq0LPyzfZEGow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448944;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CaypMYIq7JW5NrIElWAE3Yu+I1G+CcNLkm3RP+DaO3Q=;
	b=Ic/yDa08UGjXoDTsCCWbQij6v+BTBamjapM5vd6b7Myivim9xsNwgUvfXUQMqkkJr53s
	 r/LzyPrpozbhL5l7wwA3GLDndgZOh9JfaRql+YFiyaanKo1lbytmqqPshmfQ+71Wd/htR
	 sPayiFvc5t+71a1Xd0MkAJqKMW6wIR4UASk+eghb7zdTRuH120M36RUSIcS5HUKEaLGUI
	 nUI07gOKztFDgub7XgP3bwYkqISWX384GjtQqh8Rbmo+f73bJdZvr7VoL3TiuKEf77xhT
	 i0jsLyuKY8RWuPuw5vT4qtAapg9EWP+0exJ8Z6y9VQs9y9IM7vQ4IeH66nc6+7v1fYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eDh/tFng";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D580606A321;
	Thu, 12 Nov 2026 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDh/tFng
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E922C1F00A05;
	Thu, 12 Nov 2026 02:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448944;
	bh=CaypMYIq7JW5NrIElWAE3Yu+I1G+CcNLkm3RP+DaO3Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eDh/tFngVbM27y7yDuAFIb2HZkUrqng/7qSNokPvFIEKdJ0xmOejplLAS69kveGUc
	 2FdE2WPDX2ta66tT1zdDndajah3QxjRuhz1tZVnS9kcDu14nssXFR8Tqev0lL/B17Y
	 pmKB3+irH9yqyI6ldZdu6EBWg4p0stbUgu/SsUhjrNe5uleKnB+p0gBLr4CIHVkVA3
	 oIgmtQo/gDl8UV2DH+RexRXemNRXhL1xz6pC9HnkfNoT68AIWJGA1LW5XtIMmCv8Hb
	 RMJMXpgBayBD43Z7opNLNhlQN0dgEhqIu9su1IAtkfqRHSy/C+7hasgYuK3+XmLq5O
	 8pC8HO1kyDjuQ==
Subject: Re: [PATCH] net: sfc: run all the packets through GRO
From: netdev-bot+sashiko@kernel.org
To: manpacket@gmail.com
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 02:02:23 +0000
Message-ID: <179444894345.2199510.9267250834999678911@kernel.org>
In-Reply-To: <20261109-sfc-udp-gro2-v1-1-025d385f007f@gmail.com>
References: <20261109-sfc-udp-gro2-v1-1-025d385f007f@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Every frame on a normal EF10 channel now goes into
  efx_rx_packet_gro()/napi_gro_frags(), not just frames the hardware…
- [Medium] Small non-TCP frames on EF10 lose the copy path and pin RX DMA
  pages.
- [Low] The change covers EF10 only, but the submission says otherwise.
- [Low] The patch removes the only reader of EFX_RX_PKT_TCP in the main
  sfc driver but leaves the flag and its producer.

--

net: sfc: run all the packets through GRO

This commit drops the EFX_RX_PKT_TCP check in __efx_rx_packet(). It
partially reverts commit e79255de8581 ("sfc: Do not pass non-TCP packets
into GRO code"), so all packets on EF10 channels without a receive_skb
hook now go through efx_rx_packet_gro(). It was tested on SFC9250 with a
UDP_GRO socket.

Link: https://lore.kernel.org/all/20261018-sfc-gro-udp-v1-1-f7bf378178f8@gmail.com/

> net: sfc: run all the packets through GRO

[ ... ]

> 2. It might add a slight overhead for UDP traffic for e10 drivers.
>    (this bypass only exists for e10 drivers, for e100 (ef100_rx.c:140)
>    packets are passed to GRO unconditionally

[Severity: Low]
Is this scope description accurate? The Siena and Falcon drivers still
have the same TCP-only gate:

drivers/net/ethernet/sfc/siena/rx.c:__efx_siena_rx_packet() {
    ...
	if ((rx_buf->flags & EFX_RX_PKT_TCP) && !channel->type->receive_skb)
		efx_siena_rx_packet_gro(channel, rx_buf,
					channel->rx_pkt_n_frags, eh, 0);
    ...
}

drivers/net/ethernet/sfc/falcon/rx.c:__ef4_rx_packet() {
    ...
	if ((rx_buf->flags & EF4_RX_PKT_TCP) && !channel->type->receive_skb)
		ef4_rx_packet_gro(channel, rx_buf, channel->rx_pkt_n_frags, eh);
    ...
}

Commit e79255de8581 added the gate to a single driver that covered
Falcon, Siena and EF10. That driver was later split into sfc/,
sfc/siena/ and sfc/falcon/, and this patch only changes sfc/rx.c.
SFC9000-series (Siena) users with UDP_GRO sockets would still see no
coalescing.

Could the commit message say the change is limited to EF10, and why, or
should the siena and falcon drivers get the same change?

> diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
> index ffca82207e473..9874093944f8c 100644
> --- a/drivers/net/ethernet/sfc/rx.c
> +++ b/drivers/net/ethernet/sfc/rx.c
> @@ -401,7 +401,7 @@ void __efx_rx_packet(struct efx_channel *channel)
>  	if (unlikely(!(efx->net_dev->features & NETIF_F_RXCSUM)))
>  		rx_buf->flags &= ~EFX_RX_PKT_CSUMMED;
>  
> -	if ((rx_buf->flags & EFX_RX_PKT_TCP) && !channel->type->receive_skb)
> +	if (!channel->type->receive_skb)
>  		efx_rx_packet_gro(channel, rx_buf, channel->rx_pkt_n_frags, eh, 0);

[Severity: Medium]
With the EFX_RX_PKT_TCP test gone, every frame on a normal EF10 channel
now reaches efx_rx_packet_gro()->napi_gro_frags(). Does anything on this
path make sure the frame is at least ETH_HLEN bytes long?

On the EFX_RX_PKT_PREFIX_LEN path, the only length check earlier in
__efx_rx_packet() rejects zero:

	if (unlikely(!rx_buf->len)) {
		efx_free_rx_buffers(rx_queue, rx_buf,
				    channel->rx_pkt_n_frags);
		channel->n_rx_frm_trunc++;
		goto out;
	}

A length of 1 to 13 gets through. efx_rx_packet() skips
efx_rx_packet__check_len() for PREFIX_LEN frames, and that function only
checks for overlength frames anyway.

For such a frame, napi_frags_skb() fails skb_gro_header_slow(skb,
ETH_HLEN), prints "dropping impossible skb" and calls napi_reuse_skb().
napi_reuse_skb() does not reset skb_shinfo(skb)->nr_frags, skb->len or
skb->data_len. The skb goes back into napi->skb with the driver's page
fragment still attached.

The next efx_rx_packet_gro() call gets that skb from napi_get_frags()
with nr_frags already set to 1, and its loop only exits on exact
equality:

	for (;;) {
		skb_fill_page_desc(skb, skb_shinfo(skb)->nr_frags,
				   rx_buf->page, rx_buf->page_offset,
				   rx_buf->len);
		rx_buf->page = NULL;
		skb->len += rx_buf->len;
		if (skb_shinfo(skb)->nr_frags == n_frags)
			break;

		rx_buf = efx_rx_buf_next(&channel->rx_queue, rx_buf);
	}

With n_frags == 1, nr_frags goes to 2, 3, and so on, and never matches.
Could this write frag descriptors past frags[MAX_SKB_FRAGS], and loop
forever in NAPI context while efx_rx_buf_next() wraps around the RX
ring and attaches entries whose page is NULL or still owned by the ring?

Before this patch, only frames the hardware classified as TCP came
here. A short frame went through efx_rx_mk_skb() and eth_type_trans()
instead, where it did no harm.

I could not confirm that EF10 hardware or firmware ever reports a
nonzero length below 14. Possible sources are runts passed by the MAC,
short frames switched internally from a VF, or a stale prefix length
when the known issue mentioned in the comment hits. So reachability may
depend on hardware behaviour.

ef100 already guards this case before calling the same helper:

drivers/net/ethernet/sfc/ef100_rx.c:__ef100_rx_packet() {
    ...
	if (rx_buf->len <= sizeof(struct ethhdr)) {
    ...
}

Should __efx_rx_packet() get the same check now that all traffic goes
through GRO?

[Severity: Medium]
Is the change in RX page lifetime for small non-TCP frames intended?

Before this patch, non-TCP frames went through efx_rx_deliver() and then
efx_rx_mk_skb(). For frames of at most EFX_SKB_HEADERS (128) bytes,
efx_rx_mk_skb() copies the data into a linear skb and releases the page
straight away:

	} else {
		__free_pages(rx_buf->page, efx->rx_buffer_order);
		rx_buf->page = NULL;
		n_frags = 0;
	}

That leaves the still-mapped page in the page ring, where
efx_reuse_page() can recycle it.

Through efx_rx_packet_gro(), small UDP, ICMP, ARP and other frames
always have their RX page attached as a frag. skb->truesize is also
increased by n_frags * efx->rx_buffer_truesize.

When GRO does not coalesce (no UDP_GRO socket, or non-UDP traffic), does
each queued small datagram now pin its RX page until it is consumed?
efx_reuse_page() would then see page_count() > 1 and take this path:

	} else {
		state = page_address(page);
		dma_unmap_page(&efx->pci_dev->dev, state->dma_addr,
			       PAGE_SIZE << efx->rx_buffer_order,
			       DMA_FROM_DEVICE);
		put_page(page);
		++rx_queue->page_recycle_failed;
	}

Refill would then have to allocate and map a fresh page.

Each datagram is also charged a full RX buffer of truesize instead of a
head of about 128 bytes. Would sockets that do not use UDP_GRO hit
sk_rcvbuf sooner? For cloned multicast fan-out skbs, skb_condense() in
the UDP receive path does not help.

The notes mention "a slight overhead for UDP traffic", but not the loss
of page recycling or the truesize change. Was this measured for the
high-rate, small-message multicast case with receivers that do not
enable UDP_GRO?

[Severity: Low]
This isn't a bug, but this removes the last reader of EFX_RX_PKT_TCP in
the sfc driver. The siena and falcon drivers have their own
definitions. efx_ef10_handle_rx_event() still sets the flag for every
TCP packet:

	if (rx_l4_class == ESE_FZ_L4_CLASS_TCP)
		flags |= EFX_RX_PKT_TCP;

Should the definition in drivers/net/ethernet/sfc/net_driver.h and this
producer in ef10.c be removed too?

>  	else
>  		efx_rx_deliver(channel, eh, rx_buf, channel->rx_pkt_n_frags);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-sfc-udp-gro2-v1-1-025d385f007f%40gmail.com
