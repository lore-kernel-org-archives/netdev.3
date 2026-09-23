Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43C48A2BC;
	Wed, 23 Sep 2026 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175999; cv=none; b=N3cmdgE+Gv3PfONIjFnN/7lsfnfoq1QRGDjGW7PZfnV6BGg8jhVA4lr5YOommTn44GxdhEV8ByU4cTjIDTD4BK7gvOV3lkwu57T8wFsaWFIehnXwzm0WE/E+HlK5ssKS3vPn1u8wUY41bI8PZvQ+Ob9HoGuz2BDuT2o+BXfJ9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175999; c=relaxed/simple;
	bh=VZu3zFzg5OUy2VEd/K6zWxjpPiOy/+foYzjQg7JwVOE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d5r/8a1cgej86LDKMqkzNG5MnlwdH1AwqvqprGsW41G5gNz2k5kSK+pNDlAmvt6ws14rFFCUQTt5seaUSigTtCkk7F1l2wjRQBVThj4o/8JbuVreOv7+MjpuTugb51gAwldRZSJDkhl04qKmCZTDSLMb+3Zcc+eIXIX4c+MGox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWJDp+Ng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWJDp+Ng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086B41F000FF;
	Wed, 23 Sep 2026 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790175997;
	bh=YW3yWC2QdSON2xhVQNW+HA6LXb2OY7yVJHvi+L2VQCg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hWJDp+NgDQWVJo9sfrpRCMPRd3IBLurI/GDVJCyIKpxRQnJeylmqxBEAGiqbjT+Pn
	 aK5aJ9tsRKspl7M+26GDo2msuFzedUOEtwUeDYAH9xXRSjaMVVNTeD6e4e+gMWTyBh
	 7hG8VLgjFGoqVX2cgJ5tno/Yu2y+PByUZi/ktBs/vIpf5gHWMsIx7mg3CWmKOy89jd
	 Ytipti6wp+Hb/JJdE3NCTa6gGf5xRCqqeIR1ydjCwBuYX2K3gNwv8CV+1sOHvUstma
	 pFc13BhIEdlKdijz9vaK1Y7o8ZmLQCHQ5MFdASXovyoDbNqgaUcrdqg3aJKul9c8Gq
	 AVwPjv3vyshGA==
Subject: Re: [PATCH] ipv6: exthdrs: copy old IPv6 header before
 skb_mac_header_rebuild() in ipv6_rpl_srh_rcv()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, alex.aring@gmail.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 15:06:36 +0000
Message-ID: <179017599653.2160803.10920272565185423743@kernel.org>
In-Reply-To: <20260919210618.3028986-1-benquike@gmail.com>
References: <20260919210618.3028986-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete/inverted fix in ipv6_rpl_srh_rcv()
  (net/ipv6/exthdrs.c): moving `memmove(skb->data, oldhdr, sizeof(struct…
- [Medium] Commit message inaccuracies plus an undisclosed functional
  change.

Pre-existing issues:
- [High] ipv6_rpl_srh_rcv() (net/ipv6/exthdrs.c) mutates the skb data
  area without ever guaranteeing exclusive ownership of it, unlike every…

--

ipv6: exthdrs: copy old IPv6 header before skb_mac_header_rebuild() in ipv6_rpl_srh_rcv()

The patch moves the 40-byte memmove() that restores the saved IPv6 header
in ipv6_rpl_srh_rcv() so that it runs before skb_reset_network_header()
and skb_mac_header_rebuild(), and adds an explicit store of
NEXTHDR_ROUTING into the reconstructed IPv6 header.  The stated goal is
to keep the rebuilt MAC header from clobbering oldhdr before it is
copied.

A few questions on the commit message and the new ordering.

>     When chdr_len - pull_len < skb->mac_len (for example, an 8-byte
>     expansion with a 14-byte Ethernet MAC header), the newly rebuilt MAC
>     header at [skb->data - skb->mac_len, skb->data) overlaps with the old
>     IPv6 header at [oldhdr, oldhdr + 40).

[Severity: Medium]
Is this threshold right?  With e = chdr_len - pull_len and the SRH
directly following the IPv6 header, skb->data after the push is
oldhdr + 40 - e, so the rebuild write region
[skb->data - mac_len, skb->data) intersects [oldhdr, oldhdr + 40)
whenever:

    -mac_len < e < sizeof(struct ipv6hdr)

So e = 30 with mac_len = 14 also clobbers oldhdr, while e <= -mac_len
does not.  The quoted "e < skb->mac_len" appears to be neither necessary
nor sufficient.

Also, the field list:

>     skb_mac_header_rebuild(skb) first overwrites the beginning of oldhdr
>     (version, traffic class, flow label, payload_len, nexthdr, hop_limit,
>     and the start of saddr) with the Ethernet header bytes,

corresponds to e = 40 - mac_len = 26, not to the quoted 8-byte expansion
example.  For e = 48 (the 8-byte growth case) the clobbered bytes are
oldhdr[18..31], i.e. saddr/daddr.  Could the description be adjusted so a
reproducer or a stable backport decision is not based on the wrong
window?

>     Moreover, oldhdr's
>     nexthdr is only updated to NEXTHDR_ROUTING before the pull, which also
>     gets clobbered by the overlapping MAC rebuild.

Where is that pre-existing update?  At the baseline (1e24c4f2ee44) the
only NEXTHDR_ROUTING / nexthdr assignments in net/ipv6/exthdrs.c are in
ipv6_push_rthdr4() and ipv6_push_rthdr(), on the output side.
ipv6_rpl_srh_rcv() never assigned the outer nexthdr, and the diff removes
no such store.  See the inline note on the added assignment below.

> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 09a4552f7f08..f9563294c5b9 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -598,11 +598,12 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  		oldhdr = ipv6_hdr(skb);
>  	}
>  	skb_push(skb, chdr_len);
> +	memmove(skb->data, oldhdr, sizeof(struct ipv6hdr));

[Severity: High]
Does this reordering just swap which of the two overlapping in-place
copies destroys the other?

The two copies alias each other, so ordering alone cannot fix both
directions:

  - recompressed SRH smaller than received (e < 40): skb->data lands
    above oldhdr, and the old order let skb_mac_header_rebuild() clobber
    oldhdr.  The new order fixes that case.

  - recompressed SRH larger than received (e > 40): skb->data lands
    below oldhdr, so this memmove() destination
    [skb->data, skb->data + 40) overwrites the tail of the MAC header
    that skb_mac_header_rebuild() is about to read.

The growth case is reachable with attacker-chosen SRH fields, because
ipv6_rpl_srh_compress() in net/ipv6/rpl.c recomputes cmpri/cmpre against
the post-swap destination:

	cmpri = ipv6_rpl_srh_calc_cmpri(inhdr, daddr, n);
	cmpre = ipv6_rpl_srh_calc_cmpre(daddr, &inhdr->rpl_segaddr[n]);
	...
	seglen = (n * IPV6_PFXTAIL_LEN(cmpri)) + IPV6_PFXTAIL_LEN(cmpre);
	outhdr->hdrlen = seglen >> 3;

For a received header with n = 1, cmpri = 15, cmpre = 0, hdrlen = 3,
pad = 7, segments_left = 1 (srh_len = 32), the swap picks segment[1] as
the new daddr, cmpri and cmpre both recompute to 0, and the recompressed
SRH is 40 bytes.  That is an 8-byte growth, e = 48, so with
mac_len = 14 (set by skb_reset_mac_len() in __netif_receive_skb_core())
skb->data = oldhdr - 8 and this memmove() overwrites the source MAC and
EtherType.  skb_mac_header_rebuild() then copies those bytes, eight of
which are now IPv6 header bytes, into the new MAC header:

include/linux/skbuff.h:skb_mac_header_rebuild() {
	if (skb_mac_header_was_set(skb)) {
		const unsigned char *old_mac = skb_mac_header(skb);

		skb_set_mac_header(skb, -skb->mac_len);
		memmove(skb_mac_header(skb), old_mac, skb->mac_len);
	}
}

The mandatory pskb_expand_head(chdr_len + skb->mac_len) taken for
segments_left == 0 shifts data and all header offsets together, so it
does not break the overlap, and the IFF_LOOPBACK "goto looped_back" path
re-propagates the corruption on every iteration.  The write stays inside
the head buffer, so this is intra-buffer corruption of the rebuilt
link-layer header rather than an out-of-bounds access.

Would it be better to break the aliasing instead of reordering, i.e.
snapshot the 40 bytes into a local struct ipv6hdr before skb_push() and
restore them after skb_mac_header_rebuild(), the way
net/ipv6/rpl_iptunnel.c:rpl_do_srh_inline() already does:

	memcpy(&oldhdr, ipv6_hdr(skb), sizeof(oldhdr));
	...
	skb_mac_header_rebuild(skb);
	...
	memmove(ipv6_hdr(skb), &oldhdr, sizeof(oldhdr));

net/ipv6/seg6_iptunnel.c:seg6_do_srh_inline() uses the same pattern.

[Severity: High]
This isn't a bug introduced by this patch, but the write added here lands
in an skb data area that ipv6_rpl_srh_rcv() never guarantees it owns
exclusively.

The only un-cloning step in this function is conditional on headroom and
on the last segment, not on skb_cloned():

	if (unlikely(!hdr->segments_left ||
		     skb_headroom(skb) < chdr_len + skb->mac_len)) {
		if (pskb_expand_head(skb, chdr_len + skb->mac_len, 0, GFP_ATOMIC)) {

In the fast path (segments_left != 0 after the decrement, typical RX
headroom of roughly 150 bytes against the roughly 62 required) a cloned
skb reaches "hdr->segments_left--", the daddr swap, this memmove(),
skb_mac_header_rebuild() and the memcpy() of the recompressed SRH, all on
shared data.

A clone is produced before the handler runs.  ip6_protocol_deliver_rcu()
in net/ipv6/ip6_input.c calls raw delivery for every nexthdr, including
NEXTHDR_ROUTING:

resubmit_final:
	raw = raw6_local_deliver(skb, nexthdr);
	ipprot = rcu_dereference(inet6_protos[nexthdr]);

and net/ipv6/raw.c:ipv6_raw_deliver() queues a data-sharing clone:

			struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);

			/* Not releasing hash table! */
			if (clone)
				rawv6_rcv(sk, clone);

so a raw socket bound to protocol 43, or an AF_PACKET tap, holds a clone
whose bytes are later copied to userspace.

The sibling handlers in the same file guard against this.  ipv6_srh_rcv()
has:

	if (skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, 0, GFP_ATOMIC)) {

and ipv6_rthdr_rcv() states the rule directly:

	/* We are about to mangle packet header. Be careful!
	   Do not damage packets queued somewhere.
	 */
	if (skb_cloned(skb)) {

Should ipv6_rpl_srh_rcv() get the same skb_cloned() check, and re-derive
hdr/oldhdr afterwards?

>  	skb_reset_network_header(skb);
>  	skb_mac_header_rebuild(skb);
>  	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
> +	ipv6_hdr(skb)->nexthdr = NEXTHDR_ROUTING;

[Severity: Medium]
This store is new rather than a relocation of an existing one, since the
baseline ipv6_rpl_srh_rcv() never assigned the outer nexthdr.  It forces
the outer nexthdr to 43 even when the received RPL SRH followed other
extension headers, for example IPv6 header with nexthdr = HOPOPTS,
hop-by-hop, then RPL SRH arriving via the resubmit loop in
ip6_protocol_deliver_rcu().  Previously the reconstructed packet kept the
original nexthdr value.

Could this behavioural change be described in the changelog, or split
into its own patch?

>  
> -	memmove(ipv6_hdr(skb), oldhdr, sizeof(struct ipv6hdr));
>  	memcpy(skb_transport_header(skb), chdr, (chdr->hdrlen + 1) << 3);
>  
>  	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(struct ipv6hdr));

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919210618.3028986-1-benquike%40gmail.com
