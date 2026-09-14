Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C8377A86;
	Mon, 14 Sep 2026 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360643; cv=none; b=YgmxwJ8+SSRo3TfUm08fyFj7WErZQjD16jM+YvfEF4AMG7cgTe+osO9emJhu9mn9OrVpdwtjZy9UUPEOv4E1iCTIWZlrHgCxn15eTgfKoaUYj6gk7FVGaM0qkIGr0iy1AtD5PstQ384L2hKOb8nPsILxpt1JtYoJgv4kC3lBZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360643; c=relaxed/simple;
	bh=vO2ZQzXEQJv33bbCB0CcbG/Xr5QuZmBi3QXnaDGrMQ8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tlh54i935DPUi2RZonPQhMzWnrNaQZDg6lpFkLB3m1zUq7FdTFE/Cuks0mMSCBP4rHIcnTQZRfrki4OWV7jvVLu2tr4A5oaiwJRfpTgekGGhNvQkdWnmpEQD3Pwlhe4VICqSCnD8K2st90z66pXhpVrm+wXyUwyozAwRQgSpT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA0LJtqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA0LJtqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E609E1F000FF;
	Mon, 14 Sep 2026 04:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789360642;
	bh=ivB792KgKrRrGp84nJMZ8beKDCmerzkzKUNmH6fi0EY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RA0LJtqMQO3+1zxJancsAhlJ8o6MGwboM3fb2zCz1ofZH5e8NdRCX+f48VyivrtF9
	 +RpAraSSpUoQffjY1TcKzJXwufOiAWEFz2ofIRz2PRhtxy4fK+ru1EenSXpmJwM4ua
	 +Iz7GFt5aUKpP9W1fb2TW1jeM3WWQKih70qPbmTw5Upwg+/sxUApfqBobgVnAgE33J
	 USgH+cf/KYTprxC2X0RjSMJnQok1eOQoCoUbV0FBYrVpTn30vK72t0IGIfheEtRYQ1
	 TrmKVPu3gQbExezCRJrLNGMN38tV1L+C6vg5H2T9k5kJaqDulBm550zl3QUHGCfxZh
	 zTAcnD4r8chPA==
Subject: Re: [PATCH net-next v2 4/8] ip_gre: add drop reasons to the RX path
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 04:37:21 +0000
Message-ID: <178936064149.22033.6297126483259038338@kernel.org>
In-Reply-To: <20260913034937.875068-5-littlesmilingcloud@gmail.com>
References: <20260913034937.875068-5-littlesmilingcloud@gmail.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1 (1)

- [Low] Claim: labelling GRE RX pull failures SKB_DROP_REASON_HDR_TRUNC
  misattributes allocation failures, both for the two new `if…

Pre-existing issues:
- [Low] Claim: the new family-agnostic
  SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND is wired up only in…

--

ip_gre: add drop reasons to the RX path

This adds SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND and threads a drop reason
output parameter through erspan_rcv(), __ipgre_rcv() and ipgre_rcv() so
that gre_rcv() can pass a specific reason to kfree_skb_reason().  Header
pull failures are reported as SKB_DROP_REASON_HDR_TRUNC and metadata dst
allocation failures as SKB_DROP_REASON_NOMEM.

A couple of small questions below, both about the reason values rather
than the plumbing.

> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 6ae7a604722d3..fa8bd552122ff 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h

[ ... ]

> @@ -637,6 +638,11 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_GRE_INVALID_HDR,
>  	/** @SKB_DROP_REASON_GRE_CSUM: GRE checksum error */
>  	SKB_DROP_REASON_GRE_CSUM,
> +	/**
> +	 * @SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND: no GRE tunnel found for the
> +	 * endpoints and the key the packet carries.
> +	 */
> +	SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND,

[Severity: Low]

This isn't an issue introduced by this patch, but the new reason is
documented in family-neutral wording ("no GRE tunnel found for the
endpoints and the key") while only net/ipv4/ip_gre.c sets it in this
commit.  Until the IPv6 side is converted, a GRE-over-IPv6 packet with no
matching tunnel still takes:

net/ipv6/ip6_gre.c:gre_rcv() -> ip6gre_rcv() -> kfree_skb_reason(skb,
SKB_DROP_REASON_NOT_SPECIFIED)

so ip6gre, ip6gretap and ERSPAN-over-IPv6 lookup failures are still
indistinguishable from unspecified drops.

For the record, this is closed later in the same series: the following
patch, "ip6_gre: add drop reasons to the RX path", converts
__ip6gre_rcv()/ip6gre_rcv() and ip6erspan_rcv() to the same output
parameter scheme and ends both lookup-failure paths with
*reason = SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND.  Would it be worth
mentioning in this changelog that the IPv6 counterpart follows, so the
intermediate state is not read as a scope gap?

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 1894c5746a737..4d9bb6d186ae5 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c

[ ... ]

> @@ -356,15 +362,17 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>  		ip_tunnel_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
>  		return PACKET_RCVD;
>  	}
> +	*reason = SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
>  	return PACKET_REJECT;
>  
>  drop:
> -	kfree_skb(skb);
> +	kfree_skb_reason(skb, SKB_DROP_REASON_HDR_TRUNC);
>  	return PACKET_RCVD;
>  }

[Severity: Low]

The only way to reach this drop label in erspan_rcv() is the
__iptunnel_pull_header() failure, and that helper does not only fail on
truncation:

include/net/ip_tunnels.h:iptunnel_pull_offloads() {
	if (skb_is_gso(skb)) {
		int err;

		err = skb_unclone(skb, GFP_ATOMIC);
		if (unlikely(err))
			return err;
	...
}

So for a cloned GSO skb under memory pressure the drop is an allocation
failure but gets reported as SKB_DROP_REASON_HDR_TRUNC.  The commit
message says "The header pull failures reuse SKB_DROP_REASON_HDR_TRUNC",
which covers the pskb_may_pull() cases well, but does it also intend to
cover the skb_unclone() case?

Note the errno cannot be used to tell the two apart, since
__iptunnel_pull_header() returns -ENOMEM for every failure mode, and
there is precedent for the coarse label in the other direction:
vxlan_rcv() tags every __iptunnel_pull_header() failure, truncation
included, as SKB_DROP_REASON_NOMEM.  The two new
*reason = SKB_DROP_REASON_HDR_TRUNC assignments on the pskb_may_pull()
branches above match the HDR_TRUNC kernel-doc exactly, so this question
is only about the drop label.

> @@ -400,22 +408,25 @@ static int __ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi,
>  
>  			tun_id = key32_to_tunnel_id(tpi->key);
>  			tun_dst = ip_tun_rx_dst(skb, flags, tun_id, 0);
> -			if (!tun_dst)
> +			if (!tun_dst) {
> +				*reason = SKB_DROP_REASON_NOMEM;
>  				return PACKET_REJECT;
> +			}
>  		}
>  
>  		ip_tunnel_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
>  		return PACKET_RCVD;
>  	}
> +	*reason = SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND;
>  	return PACKET_NEXT;
>  
>  drop:
> -	kfree_skb(skb);
> +	kfree_skb_reason(skb, SKB_DROP_REASON_HDR_TRUNC);
>  	return PACKET_RCVD;
>  }

The same question applies here: this drop label is reached only from
__iptunnel_pull_header(skb, hdr_len, tpi->proto, raw_proto, false) < 0,
so the skb_unclone(GFP_ATOMIC) failure inside iptunnel_pull_offloads() is
also reported as SKB_DROP_REASON_HDR_TRUNC on the main IPv4 GRE receive
path.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913034937.875068-1-littlesmilingcloud%40gmail.com
