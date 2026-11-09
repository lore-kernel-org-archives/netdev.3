Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266106;
	b=RJp1amrcAENTk22mv6sjAbzV0XaYQN08Y6kfvQRZy0HsBggBnlKl3x7kxq/KEvez1BK5
	 XCCR4m1CJbpzQiLOSDezw/Ie7M7mTy/kEpazbPJSLgNJ/l2er0H8/6maibAuvL+4Ea01X
	 vcogDfxcftyvblHMxcrNYEYk105hdjDaVrnm3wuHc+b93OBETksognUMf2LYRz0T+1/Vi
	 8KOycZ2m381nLnbfabIirE+UFLsq/TvPvE0uqCs5q7P1N31JTxbtCLbvxTYGSc078VfLJ
	 e7NNtgsFrOPxyN9uDW0M7+Dp8/GhdHN0fTqTvyXnOB4rDP3SmBd32YZBmXNvttOAi3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266106;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Y2y8WScowwkJy4kQizvjBIJ/X9P/iFF0EmSPDT9CpKk=;
	b=ffwQ9R8IhQvDDlJeFkm8C/QMix6kv23ikirb/aQuRR4lZiAJZNwdl0uchIGa2BQrUVDv
	 PSv3IN4gipPI9Np92acGP9xZ4xXq7IJTkPsLSGQEeK6NIPJxD/krwyR5GxxpMP8nc76f2
	 jfPVkirZZXJHN7RpMvPeq40lYZudbe1ejJLRQi65QkyWFIguLdg5GwLyYcsJsCdHmA0gH
	 5Hs90o9DH1siZYN481XguCyQ9xnxEcpS3M3NyND1EvpwYhJvsn8CH2/OOkW5VQgBp4TDb
	 Ai4DoIn0BoC7we3u1XTKAyAGSWyaTcnZxc3ZHIiiVSe0G/dVl5ACP9Ai0tOZ5UVEdpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blaoP5kO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D6606A332
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blaoP5kO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5589E1F008A1;
	Mon,  9 Nov 2026 23:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266106;
	bh=Y2y8WScowwkJy4kQizvjBIJ/X9P/iFF0EmSPDT9CpKk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=blaoP5kOCE9KBTPSyaFBDHVqL7UYVaK086g06vx2UgAlTyna5dSyPIy+aRxEGghWY
	 jFekEHTg2EQPRScJgjhTUR4fnZ9KOQu7ZwGegvJBRHB0PSYellOdx1fBypQIzqBcAh
	 eT+RI5p/Dtow4wwuSd+0pg4wKyaydvWas+RxUloFVCBSGAwcvLLD1wvYbBmIaUaQfG
	 oU1o67zeRWatA/nLvzriuo0RAzzrWSQmHQ1+8NbRuw+CXJW7WeMR/zAu7yEZ7E7x/D
	 sXuIQHKCDJKjrUiCw4ClnnCYw+pFcGubmhY1f25AZ/BQTTswq4VJ/rsRvsD/ysCkYD
	 DyeikTDwBrOxw==
Subject: Re: [PATCH net-next 2/4] ipv6: sr: keep transport header after inline
 SRH insertion
From: netdev-bot+sashiko@kernel.org
To: tactii@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, andrea.mayer@uniroma2.it, justin.iurman@gmail.com,
 aahringo@redhat.com, willemb@google.com, alexander.duyck@gmail.com
Date: Mon, 09 Nov 2026 23:15:04 +0000
Message-ID: <179426610491.994134.1159798416281184648@kernel.org>
In-Reply-To: <20261105201309.3182307-3-tactii@gmail.com>
References: <20261105201309.3182307-3-tactii@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a regression users can see but has no Fixes:
  tag.
- [Low] The new save/restore in seg6_output_core() assumes the transport
  header sits at or after offset sizeof(struct ipv6hdr), where…

Pre-existing issues:
- [Low] Concern: the same defect (transport_header left on a newly
  inserted IPv6 extension header) remains in…

--

ipv6: sr: keep transport header after inline SRH insertion

On the output path, this patch keeps transport_header pointing at the L4
header after seg6_do_srh() inserts an SRH in inline mode. Before the
insertion it saves the distance from the transport header to the end of
the packet, and afterwards it restores it. GSO length checks then no longer
read the SRH as a TCP header.

> In inline mode, seg6_do_srh() leaves transport_header at the inserted
> SRH, although the L4 header has not moved. GSO length checks then read
> the SRH as TCP, and since commit 7fb4c1967011 ("net: pull headers in
> qdisc_pkt_len_segs_init()"), a bogus doff below 5 there makes
> __dev_queue_xmit() drop each GSO packet of the flow as SKB_BAD_GSO.

[Severity: Low]
Should this have a Fixes: tag?

On an inline seg6 route, every GSO packet of the flow gets dropped here:

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
		tlen = __tcp_hdrlen(th);
		if (tlen < sizeof(*th))
			return SKB_DROP_REASON_SKB_BAD_GSO;
    ...
}

The commit message mentions 7fb4c1967011 only in prose. Commit
6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection
with lwtunnels"), which placed transport_header at the SRH, appears only
below the --- line, and git-am strips that part.

Without a Fixes: trailer, stable backports may miss this. The other
patches in the series seem to have the same gap.

> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 0d39a38a5dd29..942704eca8db0 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c

[ ... ]

> @@ -684,10 +685,17 @@ static int seg6_output_core(struct net *net, struct sock *sk,
>  	dst = dst_cache_get(&slwt->cache_output);
>  	local_bh_enable();
>  
> +	if (slwt->tuninfo->mode == SEG6_IPTUN_MODE_INLINE &&
> +	    skb_transport_header_was_set(skb))
> +		tail_len = skb->len - skb_transport_offset(skb);
> +
>  	err = seg6_do_srh(skb, dst);
>  	if (unlikely(err))
>  		goto drop;
>  
> +	if (tail_len >= 0)
> +		skb_set_transport_header(skb, skb->len - tail_len);
> +

[Severity: Low]
Does this restore assume the transport header is at or past offset
sizeof(struct ipv6hdr)?

__seg6_do_srh_inline() pulls the 40-byte IPv6 header and pushes 40 + hdrlen
bytes. It then moves the IPv6 header to the new front and copies the SRH in
at offset 40. Only bytes at offset 40 or later keep their distance to the
end of the packet.

rawv6_send_hdrinc() leaves the transport offset at 0:

net/ipv6/raw.c:rawv6_send_hdrinc() {
    ...
	skb->transport_header = skb->network_header;
    ...
}

The packet then goes through NF_HOOK(LOCAL_OUT, ..., dst_output) to
seg6_output_core(). With an inline seg6 route, tail_len becomes skb->len,
and after the insertion transport_header ends up at offset hdrlen:

- With a single-segment SRH (24 bytes), that is inside daddr of the IPv6
  header.
- With 3 segments (56 bytes), it is 16 bytes into the SRH.

Before this patch, seg6_do_srh() left it at offset 40, on a header
boundary.

These packets are neither GSO nor CHECKSUM_PARTIAL. The effect is
therefore limited to egress code that uses skb_transport_offset()
directly, such as act_pedit layered keys or BPF.

Could the guard also require skb_transport_offset(skb) >=
sizeof(struct ipv6hdr) before tail_len is saved?

The later series patches "ipv6: rpl: keep transport header after SRH
insertion" and "ipv6: ioam: keep transport header after inline insertion"
seem to copy the same unguarded check into rpl_output() and
ioam6_output().

[Severity: Low]
This is a pre-existing issue, but the same pattern exists in other places.
In each of them, transport_header is left on a newly inserted extension
header:

- rpl_output()->rpl_do_srh_inline()
- ioam6_output()->ioam6_do_inline()
- input_action_end_b6() in net/ipv6/seg6_local.c:

net/ipv6/seg6_local.c:input_action_end_b6() {
    ...
	err = seg6_do_srh_inline(skb, slwt->srh);
	if (err)
		goto drop;

	skb_set_transport_header(skb, sizeof(struct ipv6hdr));

	seg6_lookup_nexthop(skb, NULL, 0);
    ...
}

The rest of the series appears to fix these cases:

- "ipv6: rpl: keep transport header after SRH insertion" adds the same
  tail_len save/restore to rpl_output().
- "ipv6: ioam: keep transport header after inline insertion" adds it to
  ioam6_output() for inline mode.
- input_action_end_b6() is an input path. "ipv6: fix transport header of
  forwarded GSO packets" corrects transport_header in ip6_forward() for
  forwarded GSO packets, and local delivery parses extension headers
  starting at the SRH.

Is there another caller of these inline insertion helpers that the series
leaves uncovered, or are all of them handled once the remaining patches
are applied?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105201309.3182307-1-tactii%40gmail.com
