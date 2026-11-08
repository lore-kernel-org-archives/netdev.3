Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794161455;
	b=ROlqkX1hhHhl9IbzjCmB4D5GgIwoiBuEIoVtTeP9bslhLy6rMc9Gmpt0YLCJqflJ5kZ0
	 k3iTsst4PA7D2KBohYmf07PFlVSjKZgN/TJRDrVIrgLiTV6fv8NzQwXyqCmAfWCy15rR6
	 Ihr8Qdpk2sX4HtKw6cCKBA/qxoO4gIhvy0hFpO7U+LVbIdxFgxthsy3obU9tvEGMiVt70
	 JHf9o7p3VU9KQrLRsnTappZETBr46hd6ghCJD6TlzLikdQJHFrcDiHJvilVkjXjRxWHvq
	 5l/DyVGx2gYMK8wJWzybtV+5h4ex3WccyWDUnSIRq849jF/oLyCbTudvZza5I0Jx1UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794161455;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mWlw/ViMWFPCs+qMA43hWXn+bbri2664QL/7yWSVSy0=;
	b=BIhWhNXiL60CSI/HEz2m7e3n9Zh6TMweRbH0TRD/cfUJuUzrX1NyQzHtPamMPAJcX8rz
	 ONHD9tkGBLIIHtlFZTchn9v6Dyb5Dh60ug1QJbVexMnVus0UEvqHmezpM1sNXB8c7WsgK
	 UInSGAavxye0rem0fO99Uw2Nkr2Ff/PMObpcQevoWsnLPLCBCt4rp62ydBvqv++ewLl8j
	 11y2L+8slwj/7OEgLbIdTtrA4l2U+uTl+HZz8YocctvCBh7FFvwC1DqqJrZiLhZoQe+9W
	 Qp3VG7zZ5Xxjfk3e15L5aGg3JnG3TYgoozIeyeXTIV0HNukt7ay7GzYwNCh1WVfPc7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDZ+Xu6z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D162606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDZ+Xu6z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53FF1F008A5;
	Sun,  8 Nov 2026 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794161454;
	bh=mWlw/ViMWFPCs+qMA43hWXn+bbri2664QL/7yWSVSy0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GDZ+Xu6zUqO/w+9Iy3cMwjVNWVbgh5MMOQKUsQoGlVzFsDg49Cv+fo8zM6pBpmsFO
	 ku1oQHUyw4ZajxCGz3aBNv9RDipg02SQQcuI50aZNIQThdfIZ9p1GexxvfFSZok1lO
	 1iJ7UvC6GcIgIZTi5JLhYcFyppNLAcVWtNKtBhbh5uTdYpQzbeQMNO1u+/Lo1+RAGk
	 gzZL3euBNsyWrrRwujFzrFg8cyHu8MHn0skYgDJFU0jXC885+gJA0NQk4foi9NtP7Q
	 3hAp93QFltTgFsh1/IV57MichPlcqGK0wiD5RigPEQbEkvkh1tvLs0QIxe3Z0W6Ymx
	 /jN4E04r0ghjg==
Subject: Re: [PATCH net] net: reset transport_header for ndo_features_check
From: netdev-bot+sashiko@kernel.org
To: tactii@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 alexanderduyck@fb.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Date: Sun, 08 Nov 2026 18:10:53 +0000
Message-ID: <179416145321.994134.5211085786998602067@kernel.org>
In-Reply-To: <20261104175517.2395704-1-tactii@gmail.com>
References: <20261104175517.2395704-1-tactii@gmail.com>
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

- [Medium] The patch moves the csum_start-based transport_header reset in
  validate_xmit_skb() (net/core/dev.c) above netif_skb_features(), so it…

--

net: reset transport_header for ndo_features_check

This patch moves the csum_start based transport_header (or
inner_transport_header) reset in validate_xmit_skb() so it runs before
netif_skb_features(). ndo_features_check() then sees the same L4 header
offset that ndo_start_xmit() sees. The motivation is drivers such as i40e,
whose features_check hook bounds header lengths using a transport_header
that can be stale after IPv6 forwarding with extension headers, bridged
IPv6, or seg6/rpl/ioam6.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index df1a840b03343..155be1f51494c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4207,6 +4207,15 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>  	if (unlikely(!skb))
>  		goto out_null;
>  
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		if (skb->encapsulation)
> +			skb_set_inner_transport_header(skb,
> +						       skb_checksum_start_offset(skb));
> +		else
> +			skb_set_transport_header(skb,
> +						 skb_checksum_start_offset(skb));
> +	}
> +
>  	features = netif_skb_features(skb);
>  	skb = validate_xmit_vlan(skb, features);
>  	if (unlikely(!skb))

[Severity: Medium]

The reset now runs before the netif_needs_gso() branch, so the GSO path is
affected too. Is the commit message's statement that "Software segmentation
parses the headers itself" accurate for that path?

On the GSO branch, validate_xmit_skb() calls skb_gso_output_max_segs()
before __skb_gso_segment() when gso_within_dev_limits() fails:

	if (netif_needs_gso(skb, features)) {
		...
		if (unlikely(!gso_within_dev_limits(skb, dev)))
			max_segs = skb_gso_output_max_segs(skb, dev);

skb_gso_output_max_segs() reads transport_header, and it has a guard
written for stale headers:

net/core/dev.c:skb_gso_output_max_segs() {
    ...
	/*
	 * The transport offset can be unset or stale, so hdr_len is only taken
	 * from a header at the checksum start.
	 */
	if (!skb_transport_header_was_set(skb) ||
	    skb_checksum_start(skb) != skb_transport_header(skb))
		return 0;
    ...
}

Commit 32bfd220cd6f ("net: core: re-segment oversized TCP GSO skbs") added
this guard. Its message says that an skb whose transport header is unset or
stale keeps today's segmentation.

After this patch, every non-encapsulated CHECKSUM_PARTIAL skb that reaches
this point has transport_header == csum_start. The guard can no longer fire
for those skbs on this path.

That changes behaviour for over-limit TCP GSO skbs whose header used to be
stale. Examples are forwarded GRO or BIG TCP IPv6 skbs with destination
options or a routing header, and seg6 inline, rpl or ioam6 skbs.

Before this patch they were fully segmented to MSS (max_segs = 0). Now they
are re-segmented into smaller GSO skbs. hdr_len is computed from the reset
header, and __netif_skb_features() is evaluated again.

The new behaviour looks correct, since the header is no longer stale. Could
the commit message mention this change?

Should the comment and the now redundant check in skb_gso_output_max_segs()
also be updated for this caller?

32bfd220cd6f appears to be in mainline only, so this should not affect the
stable backport.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104175517.2395704-1-tactii%40gmail.com
