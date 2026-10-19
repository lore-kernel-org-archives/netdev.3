Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5684E50A2;
	Mon, 19 Oct 2026 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417743; cv=none; b=l5SPxUBzBjR4leeGI0BE0Ck3pWFFYylvRjWYSFbAPG1pkcYd7tOOUXPVn0nYXpMHWhjH4ZT7YMU1NmW0FFyaQm+BamsJGaambJFbuZ7L0Ccch02Jef78GS8bJ1Pn9xjsk6xVbtp8lv3GHv/sNjgNiU7RypBTSgY7ZiXDP6Fq6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417743; c=relaxed/simple;
	bh=cqdLXFhuww1KgOoAVAg2e9HLgfbhCysFELTyzFav+qk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OI19f16/Gk0DoXuZY5kjAu0jAdNcLxRuRGNY1YKyOpZCcNwrPO3cIcLBnOFNxS/gs/THnsrcgyWB5JrsGgn2v8Ha9SXIj9RLIuCjYdrkHhLi30jOBUqZf/U8HJLJD8nRoXYO2FnO/jJCyZwMEbmEzlie65mhR4CHwL8fdede8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksuXrVuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksuXrVuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172AA1F000C4;
	Mon, 19 Oct 2026 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792417741;
	bh=DzzazkH/k9ZrkwaSK0aEoU+TFDj8776wgSCTlVdweNI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ksuXrVuCbzOg7V4QIHbQy/H1nHB5IJaVc+t0G+APxBA/AK/Z/YWVx636it68foAf6
	 s6tOtJl7GN6ooIVqedSW2hmTTP4VIjPokFvGfFy80KUhBHpfbkVVgZxwS/LkrELarV
	 wlVJqfcywAvgSmaO1p2JI8uTKhsudt9YzbEiKkfioVtPYKaNPcZ1aNGRxdhlDIxKV5
	 F+UUecD83Mcxlv9lICQwM7A/apVPK+FKmu3DkYlGvUvqY3vu68DvNgI/4w7Vx0r+3s
	 lqV25y7Bl+LymUVPW1wW+ax7+5G5EGsc7xMXuyhf1efG3/dtahdyfrJqyaR9nMtMh5
	 Z50HTkMBzKcvw==
Subject: Re: [PATCH net-next] net: gso: validate transport header before
 computing segment length
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemb@google.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Date: Mon, 19 Oct 2026 13:49:00 +0000
Message-ID: <179241774059.3135.1824255217664274444@kernel.org>
In-Reply-To:
 <b714fa38ab650b313ca3121cd4cb3ee847d06a0d.1792327180.git.mst@redhat.com>
References:
 <b714fa38ab650b313ca3121cd4cb3ee847d06a0d.1792327180.git.mst@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says that when the TCP header is unset or
  outside the linear data, the patch will "drop it".
- [Medium] The bound check in skb_gso_transport_header_ok()
  (net/core/gso.c:165), `thoff + sizeof(struct tcphdr) <=…
- [Low] The kernel-doc for skb_gso_validate_network_len() ("Will a split
  GSO skb fit into a given MTU?", gso.c:279-286) and…
- [Low] Concern: skb_inner_transport_header_was_set()
  (`inner_transport_header > 0`, skbuff.h:3050-3053) is an unreliable…

--

net: gso: validate transport header before computing segment length

This commit adds skb_gso_transport_header_ok(). It checks that the TCP
(or inner TCP) header of a TCP GSO skb is set and lies within the linear
data, and makes skb_gso_validate_network_len() and
skb_gso_validate_mac_len() return false when that check fails. A new
skb_inner_transport_header_was_set() helper is added to skbuff.h.

> But as a defence in depth measure, let's also check before we read: if
> the TCP header is unset or outside the linear data, drop it.

[Severity: Medium]
Is "drop it" an accurate description of what happens here?

skb_gso_transport_header_ok() only makes the two validators return false.
Nothing frees the skb, and every caller reads false as "the segments are
too big", so the outcome depends on the caller.

ip_finish_output_gso() and ip6_finish_output_gso() take the software
segmentation slowpath through skb_gso_segment(). inet_gso_segment() then
resets the transport header, so the malformed packet gets segmented and
transmitted.

ip_forward()->ip_exceeds_mtu() bumps FRAGFAILS and sends ICMP_FRAG_NEEDED
with the route MTU, even when the segments would fit.

tcf_police_mtu_check() applies the policer's exceed action.

__bpf_skb_check_mtu() returns BPF_MTU_CHK_RET_SEGS_TOOBIG to the program.

The skb_headlen() requirement does not seem to penalise valid packets
from the stack's own GSO producers. On egress, qdisc_pkt_len_segs_init()
already does pskb_may_pull() of the TCP header into the linear area.

Could the commit message describe these outcomes, or is the intent for
the malformed case to really be dropped?

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index af1cbc2799b77..8417096323ea6 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3047,6 +3047,11 @@ static inline bool skb_inner_network_header_was_set(const struct sk_buff *skb)
>  	return skb->inner_network_header > 0;
>  }
>  
> +static inline bool skb_inner_transport_header_was_set(const struct sk_buff *skb)
> +{
> +	return skb->inner_transport_header > 0;
> +}

[Severity: Low]
How reliable is a zero inner_transport_header as the unset marker?

skb_reset_inner_headers() can copy the outer 0xffff sentinel into it:

	skb->inner_transport_header = skb->transport_header;

skb_headers_offset_update() also adjusts it unconditionally, which can
turn a zero marker into a nonzero value:

	skb->inner_transport_header += off;

In both cases the range check in skb_gso_transport_header_ok() still keeps
the read inside the linear data on 64-bit. The > 0 convention also matches
skb_inner_network_header_was_set(). No runtime path to either state was
found, so this may be fine as is.

> diff --git a/net/core/gso.c b/net/core/gso.c
> index b5bd269e56e4e..60cb28964c1c4 100644
> --- a/net/core/gso.c
> +++ b/net/core/gso.c

[ ... ]

> +static bool skb_gso_transport_header_ok(const struct sk_buff *skb)
> +{
> +	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	unsigned int thoff;
> +
> +	if (likely(!(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))))
> +		return true;
> +
> +	if (skb->encapsulation) {
> +		if (!skb_inner_transport_header_was_set(skb))
> +			return false;
> +
> +		thoff = skb_inner_transport_offset(skb);
> +	} else {
> +		if (!skb_transport_header_was_set(skb))
> +			return false;
> +
> +		thoff = skb_transport_offset(skb);
> +	}
> +
> +	/* A negative offset converts to a huge value and fails. */
> +	return thoff + sizeof(struct tcphdr) <= skb_headlen(skb);

[Severity: Medium]
Does this comment hold on 32-bit kernels?

thoff is an unsigned int, and on ILP32 size_t is also 32 bits, so the
addition wraps. A transport offset of -k, for k in [1, 20], gives 20 - k.
That passes for any skb with that much linear data. On 64-bit the sum is
computed as a 64-bit size_t and the check fails as the comment says.

A negative transport offset on a TCP GSO skb looks reachable from a
privileged tc BPF program through a MAC-mode shrink:

bpf_skb_adjust_room(BPF_ADJ_ROOM_MAC, shrink)
  bpf_skb_net_shrink()
    bpf_skb_net_hdr_pop()

net/core/filter.c:bpf_skb_net_hdr_pop() {
    ...
	ret = bpf_skb_generic_pop(skb, off, len);
	if (likely(!ret)) {
		skb->mac_header += len;
		skb->network_header += len;
		if (trans_same)
			skb->transport_header = skb->network_header;
	}
    ...
}

This leaves a distinct transport_header unchanged. For Ethernet/IPv4 TCP
GSO with a transport offset of 34, a shrink of 50 bytes leaves the offset
at -16.

If bpf_skb_check_mtu(BPF_MTU_CHK_SEGS), act_police or tbf then calls
skb_gso_validate_*_len(), the guard passes. skb_gso_transport_seglen()
then reads tcp_hdrlen() from stale headroom bytes.

The read stays inside the head allocation, because transport_header is a
u16 offset from skb->head. The computed segment length and the resulting
verdict are still wrong.

Would a signed thoff with an explicit thoff < 0 check, or widening the sum
to u64, close this?

> +}

[ ... ]

> @@ -257,6 +287,9 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
>   */
>  bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu)
>  {
> +	if (unlikely(!skb_gso_transport_header_ok(skb)))
> +		return false;
> +
>  	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
>  }
>  EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);

[Severity: Low]
The kernel-doc above this function, and the one above
skb_gso_validate_mac_len(), still describe a pure size check:

 * skb_gso_validate_network_len - Will a split GSO skb fit into a given MTU?

A false return can now also mean that the TCP or inner TCP header is
unset or not linear. Callers have no way to tell the two cases apart.

__bpf_skb_check_mtu() already reports the malformed case separately:

		if (flags & BPF_MTU_CHK_SEGS) {
			if (!skb_transport_header_was_set(skb))
				return -EINVAL;
			if (!skb_gso_validate_network_len(skb, mtu))
				ret = BPF_MTU_CHK_RET_SEGS_TOOBIG;
		}

Two cases would now reach BPF programs as BPF_MTU_CHK_RET_SEGS_TOOBIG:
an encapsulated skb with an unset inner transport header, and a negative
transport offset after a bpf_skb_adjust_room() shrink.

ip_exceeds_mtu(), act_police and ip_finish_output_gso() also treat this
as an oversize condition.

Should the kernel-doc be updated, or should the malformed case be
reported separately?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/b714fa38ab650b313ca3121cd4cb3ee847d06a0d.1792327180.git.mst%40redhat.com
