Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792980775;
	b=jta3olIlenTiaFyTcoElxyIQDz94xvbfSShbJyenMqxRxh1ipEvd8d08t4LiXai8ZQcB
	 0T5iwlm6WSJWLQVc8lvzcLMQqNwryTgrJPD5LuZfvoNcXe3+ffs3vwsWcNFA+UXs9FJD4
	 1CiaJproNyPEtgu9kI3PZM28AWUJkmSNwXexlKVFvkwVN6dGtJjEBgyGQNOBBHQD7ZC+k
	 jcmLS30wYljhQBvsxGJveHF4jH+yqEjpqD+kuXk8f9nwWZp8Xsyipf+PJicvJlLUtQyAY
	 7OLJCUcK2yTxZX/o6HQC48vDIkJpS7weOEmqw8BLYOnmqFJbMGlVnhNmNQyiaa7KlvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980775;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wA0s9Pk+9rLFk9wkxBrpyy+oHH+/3hP5iv6M0DHJMLk=;
	b=Sg81MHBWBm7iNg/Pnzw6sYItaFjC+mfkwsNpxZZsnTPD2svVqNckCPfg7YdNQsb4J0RH
	 7Bo+TSAZVwklS8qcDU6HJeII1Hm/KlqNT5ELNTfwS9QczINmBIS69tfJP773O/Y35FF15
	 VVNYs85bcSVbb4l4sEdhC26AU5zqFe44uP6YnynDW+GXBMZl+ePCXVxS23/EwBYHgkpIn
	 h1ZBySZSz1hqzwwHk/1s/IitDdSmhsoyQvMiyll/voQl/5PEe9WG+oXbS1nAL56B+/P8J
	 eEgk8Sfxq/ya3gTC3Mcbcncvqn/dSGJqAU4tc8nkbvXKSt9gJl3aMLjsK71H6GYS14A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBUgq+aG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF58606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBUgq+aG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA261F01825;
	Mon, 26 Oct 2026 02:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792980775;
	bh=wA0s9Pk+9rLFk9wkxBrpyy+oHH+/3hP5iv6M0DHJMLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mBUgq+aGfc5XnStPVJuJmpqlVqNa5infrwJa+Vj2cl/DO8M0PtrEV5HgWdQyqaIN4
	 qN9qM7otZbVrDpusO7CPEoL0L+cg1eBQLIdxe4muZ/6FzVPzmMHXJaSU4ln+5thLCI
	 GS3EZj/B7XxHkr8vmmpslTvje+vxeRvhBZICdfEY1pJvnX13sCTkZIbdLIwr6rz/JG
	 3jHfrZpN5vZYOILUGRn61th2X/QfcpNTUbyra3rN0OjcBgwJWokxyfsSrYn6rE1R2A
	 4A70GoA5TvnF0zkmWADkKvX393p6ziCBNOKQzeqn4k+tSPza04MhKbSvtjCeMgwMy0
	 asEpBapzPw07w==
Subject:
 Re: [PATCH net] ppp: linearize and segment bridged packets when required
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 sashiko-bot@kernel.org, qingfang.deng@linux.dev, nbd@nbd.name,
 pablo@netfilter.org
Date: Mon, 26 Oct 2026 02:12:54 +0000
Message-ID: <179298077411.3134.13996743419397228298@kernel.org>
In-Reply-To: <20261022111039.85112-1-edumazet@kernel.org>
References: <20261022111039.85112-1-edumazet@kernel.org>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] ppp_bridge_gso_segment() in drivers/net/ppp/ppp_generic.c
  calls skb_gso_segment() on PPPoE-received GSO skbs whose skb->dev is…
- [High] ppp: WARN_ONCE and packet drop in ppp_bridge_xmit() on negative
  csum_start
- [Medium] ppp_bridge_xmit() in drivers/net/ppp/ppp_generic.c finishes
  every CHECKSUM_PARTIAL skb with skb_checksum_help(), which always…

--

ppp: linearize and segment bridged packets when required

This patch adds an xmit_offload flag to struct ppp_channel and sets it
only for PPPoE. For bridged channels without the flag, the bridge now
segments GSO packets in software and finishes CHECKSUM_PARTIAL checksums.
Packets going to channels without direct_xmit are also linearized.

> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 1a610a18893ba..68e2ccfb17518 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c

[ ... ]

> @@ -2278,6 +2279,61 @@ static bool ppp_decompress_proto(struct sk_buff *skb)
>  	return pskb_may_pull(skb, 2);
>  }
>  
> +/* Segment a GSO packet (built by PPPoE GRO, or injected with a
> + * virtio_net_hdr) before sending it to a bridged channel that does
> + * not accept GSO packets.
> + * skb->data points to the PPP protocol field, which is replicated
> + * in front of each segment.
> + * Returns a list of segments, or NULL if the packet was dropped.
> + */
> +static struct sk_buff *ppp_bridge_gso_segment(struct sk_buff *skb,
> +					      netdev_features_t features)
> +{
> +	struct sk_buff *segs;
> +
> +	if (!pskb_may_pull(skb, PPP_PROTO_LEN))
> +		goto drop;
> +
> +	switch (get_unaligned((__be16 *)skb->data)) {
> +	case htons(PPP_IP):
> +		skb->protocol = htons(ETH_P_IP);
> +		break;
> +	case htons(PPP_IPV6):
> +		skb->protocol = htons(ETH_P_IPV6);
> +		break;
> +	default:
> +		goto drop;
> +	}
> +	skb_set_network_header(skb, PPP_PROTO_LEN);
> +
> +	/* No checksum offload: skb_segment() computes the checksums. */
> +	segs = skb_gso_segment(skb, features);

[Severity: Critical]

Can skb->dev be NULL at this point?

On the PPPoE receive side, pppoe_rcv() passes the skb to
__sk_receive_skb(), which clears the device before the backlog handler
runs:

net/core/sock.c:__sk_receive_skb() {
    ...
	skb->dev = NULL;
    ...
}

The skb then gets here through:

pppoe_rcv()->__sk_receive_skb()->sk_backlog_rcv()->pppoe_rcv_core()->
  ppp_input()->ppp_channel_bridge_input()->ppp_bridge_gso_segment()

Nothing on that path sets skb->dev again.

For tunnelled GSO packets, the software GSO handlers dereference skb->dev
with no NULL check. For IP-in-IP, ipip_gso_segment() calls the inner
inet_gso_segment(), which does:

net/ipv4/af_inet.c:inet_gso_segment() {
    ...
	if (encap)
		features &= skb->dev->hw_enc_features;
    ...
}

gre_gso_segment(), __skb_udp_tunnel_segment() and ipv6_gso_segment()
dereference skb->dev the same way.

Remote traffic can build such skbs. pppoe_gro_receive() hands off to
inet_gro_receive(), which can stack ipip_gro_receive() without any local
tunnel device. ipip_gro_complete() then sets:

	skb->encapsulation = 1;
	skb_shinfo(skb)->gso_type |= SKB_GSO_IPXIP4;

Before this patch, bridged GSO skbs went unchanged to start_xmit(). Only
PPPoE segmented them, and it sets skb->dev before dev_queue_xmit().

Take a LAC that bridges PPPoE to L2TP or PPTP with PPPIOCBRIDGECHAN.
Could a remote PPPoE peer that sends GRO-merged IPIP-encapsulated TCP
cause a NULL pointer dereference in softirq here, with pchb->downl held?

Should this path either set skb->dev or reject skbs with
skb->encapsulation or tunnel gso_type bits before calling
skb_gso_segment()?

> +	if (IS_ERR_OR_NULL(segs))
> +		goto drop;
> +
> +	consume_skb(skb);
> +	return segs;
> +
> +drop:
> +	kfree_skb(skb);
> +	return NULL;
> +}
> +
> +static void ppp_bridge_xmit(struct ppp_channel *chan, struct sk_buff *skb)
> +{
> +	if (!chan->direct_xmit && skb_linearize(skb))
> +		goto drop;
> +
> +	if (!chan->xmit_offload && skb->ip_summed == CHECKSUM_PARTIAL &&
> +	    skb_checksum_help(skb))
> +		goto drop;

[Severity: High]
Can skb->ip_summed still be CHECKSUM_PARTIAL here while csum_start
points before skb->data?

Consider PPPoL2TP over UDP as the bridge source. Suppose the L2TP packet
was generated locally and is received over veth, loopback or virtio-net
with UDP checksum offload. It then arrives in udp_rcv() or udpv6_rcv()
as CHECKSUM_PARTIAL, with csum_start at the outer UDP header.
udp4_csum_init() and udp6_csum_init() see skb_csum_unnecessary() and
leave ip_summed unchanged.

The skb then gets here through:

udp_queue_rcv_one_skb()->l2tp_udp_encap_recv()->l2tp_recv_common()->
  pppol2tp_recv()->ppp_input()->ppp_channel_bridge_input()->
  ppp_bridge_xmit()

l2tp_udp_encap_recv() and l2tp_recv_common() strip the UDP and L2TP
headers with __skb_pull(). pppol2tp_recv() strips the address and
control bytes with skb_pull(). None of these update the checksum state,
so skb_checksum_start_offset(skb) is negative by the time we get here.

The non-bridged path handles this case in ppp_receive_nonmp_frame()
through skb_pull_rcsum(). Its skb_postpull_rcsum() turns
CHECKSUM_PARTIAL into CHECKSUM_NONE when the start offset goes
negative. The bridge path never reaches that code.

For a destination channel without xmit_offload, skb_checksum_help()
then does:

net/core/dev.c:skb_checksum_help() {
    ...
	offset = skb_checksum_start_offset(skb);
	ret = -EINVAL;
	if (unlikely(offset >= skb_headlen(skb))) {
		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
		WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n",
			  offset, skb_headlen(skb));
		goto out;
	}
    ...
}

The negative int offset is converted to unsigned int in the comparison.
That fires the WARN_ONCE() and skb_dump(), and every such packet is
dropped. With panic_on_warn this is a panic.

Before this patch the skb went to start_xmit() unchanged. So bridging
L2TP to PPP Async, Sync, PPTP or L2TP looks like a new regression
here.

PPPoE as the destination sets xmit_offload and skips this check, but
the stale state remains. pppoe_xmit() then pushes the PPPoE and
Ethernet headers, which can bring the start offset back to zero or
above. Could the output device then write a checksum into the wrong
bytes of the frame?

Should ppp_channel_bridge_input() drop the stale state before the GSO
and ppp_bridge_xmit() paths? It could reset ip_summed to CHECKSUM_NONE
when skb_checksum_start_offset(skb) < 0, as skb_postpull_rcsum() does.
Or should the L2TP receive path use the _rcsum pull helpers instead?

[Severity: Medium]

Are SCTP CRC32c requests handled correctly here?

skb_checksum_help() always writes a 16-bit Internet checksum and then sets
CHECKSUM_NONE. It does not check skb->csum_not_inet. The core dispatcher
handles that case separately:

net/core/dev.c:skb_csum_hwoffload_help() {
    ...
	if (unlikely(skb_csum_is_sctp(skb)))
		return !!(features & NETIF_F_SCTP_CRC) ? 0 :
			skb_crc32c_csum_help(skb);
    ...
}

sctp_packet_pack() sets CHECKSUM_PARTIAL with csum_not_inet = 1 when the
route device has NETIF_F_SCTP_CRC, as veth does. Such a packet can be
wrapped in PPPoE, for example with bpf_skb_change_head() in a tc program,
which keeps ip_summed and csum_start. If PPPoE then receives it on the
peer, neither PPPoE receive nor skb_scrub_packet() clears that state.

If the packet is bridged to a channel without xmit_offload, a 16-bit
Internet checksum is written into the 32-bit SCTP checksum field. The
receiver will then drop the packet.

Take L2TP over IPv4 with the default of no UDP checksum. Before this
patch the skb kept CHECKSUM_PARTIAL and csum_not_inet, and
validate_xmit_skb()->skb_csum_hwoffload_help() on the output device
computed a correct CRC32c. So this looks like a regression for that
setup. It also does not match the commit message, which says the patch
will "finish CHECKSUM_PARTIAL checksums".

Would skb_csum_hwoffload_help(skb, 0) work better here?

> +
> +	if (chan->ops->start_xmit(chan, skb))
> +		return;
> +drop:
> +	kfree_skb(skb);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022111039.85112-1-edumazet%40kernel.org
