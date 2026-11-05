Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898718;
	b=OOgyN6J2Q55SOE1LihrzNtN6ab4grpP0vraCa8v2DO7vxGLGZ0+e3UhfLQhycUEyU5+B
	 Ak4PWp1SCGuBZXdprMrVxhU2ExMdmlddiZVdMB8UqhqwLte+MpHBUokhqt8fV3Sy+MqQM
	 BReopd1BYeGyte/sveMtNZip1XObzwuYuAmvI+niP4cKfxatj25E1PR13R0ySkg3LI4DD
	 r5SmR39kwOMglG+kXHqJCFgRFr69r6FMtvnKvlOLXO9QHEUPKmjxBorT5KZ11vsCDt7sO
	 MtZwxf/YLGTwiBIDWBGv0uVi9rD1GIT6kFGaNC7ZFGi/cEJXyhD9xIT+TtRFZgUpFQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898718;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=13d2ij5dViFrjhoQvQxDCRQxF9jfntf8UhmPYjNCyEQ=;
	b=C5/K/pqyejMQ49BWUyaVOcv/s4tfoXdfigdSPrWRJ7P8AD/gwXWSKzt6WBoDEkW9b+zi
	 9SyE8BB85BlrhAc+WJfE0L/QK7KqOT1f0+jvtbgE4WJjOqfeSxOZjoNeiNNxkMl4SpEoQ
	 Dfgj99S0SWdS7e1ysAcFCpZh3w1bVgDJtcwsnccpm2Ca9oMImtY2cQwU2o0dTj3IpMoMq
	 g1ddRRfzt32ZrzKZ5gJXV40LI8a7qx+qlA+x0mwpDi62sOpShHs2pu4EVC8+fiuddowNE
	 87pYikQjf83URLPTKvovLjo8vuZv4MAz1FXkefKENyW3xUC99Kplu9ae3TzbpJCS0Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyEP7z3k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF279606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyEP7z3k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23C31F00919;
	Thu,  5 Nov 2026 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898717;
	bh=13d2ij5dViFrjhoQvQxDCRQxF9jfntf8UhmPYjNCyEQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dyEP7z3kpfZ7VfFti4+PhQ2B4wvDjV1BEc7pf8W+MhVLCGo7Ev9LCqOWkUrFUtcB6
	 x/UbGzplKz6+guqhENf/WWHjduqbIFixV+Xro3rgFJMwDDAoqXw3Ig7T/reSo8ziiV
	 KWi5Qo9j/XOqRLnqVBEhnv8UHhduEc17ZooutLAnWibH9ntBx1aLCTDB+adu1BGA4x
	 5sfDFuojDFn+sXwxLsz/EQ8clA9pMut1exgHgEehCLn0F9KGdAYDnvQoF52DeihLiS
	 EZbWAkvNvUDKU/7x+2/7jHsd9qNiJZE3d64j7qrfXVD9bHObqPjcD3ExN0vFKj/6sF
	 uO5wC/uo40Awg==
Subject: Re: [net PATCH] net: Segment CHECKSUM_UNNECESSARY GSO skbs other than
 fraglist
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com, tactii@gmail.com
Date: Thu, 05 Nov 2026 17:11:56 +0000
Message-ID: <179389871649.994134.5339648334633501825@kernel.org>
In-Reply-To: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
References: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In validate_xmit_skb() (net/core/dev.c), a non-fraglist
  CHECKSUM_UNNECESSARY GSO skb is relabelled CHECKSUM_NONE before…

--

net: Segment CHECKSUM_UNNECESSARY GSO skbs other than fraglist

This commit changes validate_xmit_skb() to relabel any non-fraglist
CHECKSUM_UNNECESSARY GSO skb, such as a hardware LRO aggregate sent out
through tc mirred, as CHECKSUM_NONE. The stated intent is that
netif_needs_gso() then segments these skbs in software. Without the
change, drivers that only set up TSO for CHECKSUM_PARTIAL send one
oversized frame with a bad checksum.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f32353b0467cd..28b4a652d037f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4207,6 +4207,17 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>  	if (unlikely(!skb))
>  		goto out_null;
>  
> +	/* Only fraglist GSO, whose segments already carry valid checksums,
> +	 * can be handed to a device as CHECKSUM_UNNECESSARY. Any other GSO
> +	 * skb has no csum_start for the device to segment from. NONE means
> +	 * the same on transmit, and has netif_needs_gso() segment it in
> +	 * software.
> +	 */
> +	if (unlikely(skb->ip_summed == CHECKSUM_UNNECESSARY &&
> +		     skb_is_gso(skb) &&
> +		     !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)))
> +		skb->ip_summed = CHECKSUM_NONE;
> +
>  	features = netif_skb_features(skb);

[Severity: Medium]

On a TSO-capable egress device, does this path actually reach software
segmentation?

ip_summed is already CHECKSUM_NONE when netif_skb_features() runs, so
the driver's ndo_features_check() sees a non-PARTIAL skb.
i40e_features_check(), ice_features_check() and fbnic_features_check()
all return early in that case and leave NETIF_F_GSO_MASK set:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_features_check() {
	if (skb->ip_summed != CHECKSUM_PARTIAL)
		return features;
    ...
}

harmonize_features() also skips its can_checksum_protocol() test for
CHECKSUM_NONE.

netif_needs_gso() then returns true, and __skb_gso_segment() runs with
NETIF_F_TSO/TSO6 still in features. tcp4_gso_segment() (and
tcp6_gso_segment()) turns the skb back into CHECKSUM_PARTIAL:

net/ipv4/tcp_offload.c:tcp4_gso_segment() {
	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
		...
		th->check = 0;
		skb->ip_summed = CHECKSUM_PARTIAL;
		__tcp_v4_send_check(skb, iph->saddr, iph->daddr);
	}

	return tcp_gso_segment(skb, features);
}

Since the device can do TSO, tcp_gso_segment() then returns NULL:

net/ipv4/tcp_offload.c:tcp_gso_segment() {
    ...
	if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
		...
		segs = NULL;
		goto out;
	}
    ...
}

validate_xmit_skb() treats NULL as "not segmented" and passes the
original skb to the driver as a CHECKSUM_PARTIAL TSO request.

If so, the new comment ("has netif_needs_gso() segment it in software")
and the commit message ("The netif_needs_gso function then segments it
in software") don't match what happens on most real NICs. fbnic
advertises NETIF_F_TSO/TSO6. Did the MSS-sized frames in the QEMU test
come from the emulated device's TSO rather than from software GSO?

A further concern is that the driver's TSO validation never sees the
skb in the form that is finally offloaded. i40e and ice drop GSO when
gso_size < 64 ("We cannot support GSO if the MSS is going to be less
than 64 bytes"). fbnic checks L2/L3 header length, alignment and
csum_offset limits. All of these checks are skipped for these skbs.

mlx5 LRO sets gso_size to an average over the aggregated segments:

drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:mlx5e_build_rx_skb() {
    ...
	skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt - hdrlen, lro_num_seg);
    ...
}

Could a remote peer that sends small segments produce an aggregate that
gets redirected to i40e or ice as a TSO request with an MSS below 64?

DODGY CHECKSUM_NONE GSO skbs already take this bypass. This patch sends
every LRO-style CHECKSUM_UNNECESSARY TCP GSO skb through it as well.

Would one of these options give the documented behaviour?

- Clear NETIF_F_GSO_MASK from features for the converted skbs after
  netif_skb_features().
- Before netif_skb_features(), turn the skbs into proper
  CHECKSUM_PARTIAL skbs (cow the header, set csum_start and
  csum_offset, write the pseudo-header checksum). Then
  ndo_features_check() validates what is actually offloaded.

>  	skb = validate_xmit_vlan(skb, features);
>  	if (unlikely(!skb))

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179372577673.49909.11253315483074546903.stgit%40ahduyck-xeon-server.home.arpa
