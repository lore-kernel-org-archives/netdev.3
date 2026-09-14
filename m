Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B45331ED6;
	Mon, 14 Sep 2026 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360641; cv=none; b=WEvJIXmjYp8uYcgAbiAPad2QF4zS+tgKTLd3wr6NBHVShmBObQ9wMCzHMOeV6aG2Xw7JJv15IcG/rmZEvZKoQBKskdAHgzIZto+snlrf4Nve/D5me6zdssoV5tW+gRxZyr8uegOaEQdIilNFb1oOiFbvGwS+S6SMQzSo3zjukCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360641; c=relaxed/simple;
	bh=nxVyttJfEl9QvraQXRCJnEoProvADVOCsaOIbVBegDY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hRY9RaP5b8D9A/z76x/gr61SCcOAs67L23Jp1i33zCIto0JKjbbQbUPcglt/nf8iBAjb/wCqSKVfp5MV6IMSKdDBnwzzDs9p0QmKXfGXN5HuBmIZ8vesRvWsgux3yvCGhxEBzq+Kth0BM4Y1TdFYlkpatdLP9SkPR9wBPIl15BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4SyTnhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4SyTnhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B155B1F000FF;
	Mon, 14 Sep 2026 04:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789360640;
	bh=Czvdqpjf9KYvoRvNASNtEwExPz7Frlg7DuFJ+AO6O0c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h4SyTnhetpGFj4xK6zp4OB9/b2t42ORq0SaG9cHMeQj5/GK5ApabkBBKMgmV5L4qy
	 tCJJfxfvGIb9Pf9j+c3xjK+gVAehpR82IXuiYKvuCZL6na7yRW95RTlTwBy1LyxuZd
	 qkX859k95UMc2r47xPy2+tEB+/kNfp3W6toJW+7xoyDUpItdUHTMrNGDhKN7fymHFt
	 LWyVbhVyaCJZRnPxO9fuJbSlEHtQDD9h95GnR108GMRmvyHtzh9i5M3qbCaNRUPERo
	 nMAeVTxFV0Z3tIvYzYsW4vtrX+iRs41R2wUHggeP6xBHNz0mNcL8BQtt/M+9PIlTB/
	 d5ypaAGv05/8w==
Subject: Re: [PATCH net-next v2 2/8] ip6_tunnel: add drop reasons to the
 generic RX path
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 04:37:19 +0000
Message-ID: <178936063923.22033.2072645913150981969@kernel.org>
In-Reply-To: <20260913034937.875068-3-littlesmilingcloud@gmail.com>
References: <20260913034937.875068-3-littlesmilingcloud@gmail.com>
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Commit message call-graph claim is inaccurate.

--

Verified. Report follows.

ip6_tunnel: add drop reasons to the generic RX path

This converts the five drop paths in __ip6_tnl_rcv() from a plain
kfree_skb() to kfree_skb_reason(), splitting the combined sequence number
check into two cases so the option mismatch and the old sequence number
failures can be distinguished, and propagating the reasons already returned
by pskb_may_pull_reason() and skb_vlan_inet_prepare().

The only comment below is about the changelog, so the diff hunks are not
quoted.

[Severity: Low]
Is this description of the call graph accurate?

> __ip6_tnl_rcv() is reached through ip6_tnl_rcv() from both ip6_tunnel
> (ip4ip6, ip6ip6) and ip6_gre (ip6gre, ip6gretap, erspan).

In net/ipv6/ip6_tunnel.c, the exported ip6_tnl_rcv() only has callers in
net/ipv6/ip6_gre.c (the ip6gre_rcv() and ip6erspan_rcv() paths).  The
ip6_tunnel-native encapsulations do not go through it; they call
__ip6_tnl_rcv() directly from the static ipxip6_rcv():

net/ipv6/ip6_tunnel.c:ipxip6_rcv() {
	...
		ret = __ip6_tnl_rcv(t, skb, tpi, tun_dst, dscp_ecn_decapsulate,
				    log_ecn_error);
	...
}

with ip4ip6_rcv()->ipxip6_rcv(), ip6ip6_rcv()->ipxip6_rcv() and
mplsip6_rcv()->ipxip6_rcv().

That also makes mplsip6 a third ip6_tunnel encapsulation that starts
reporting these reasons, which the changelog does not mention.

The conclusion drawn afterwards does still hold, since tpi_v4, tpi_v6 and
tpi_mpls are static descriptors with only .proto set:

net/ipv6/ip6_tunnel.c
static const struct tnl_ptk_info tpi_mpls = {
	/* no tunnel info required for mplsip6. */
	.proto = htons(ETH_P_MPLS_UC),
};

so no checksum or sequence bit is ever set on the ipxip6 path.  Could the
entry point description be adjusted to name ipxip6_rcv() and include
mplsip6?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913034937.875068-1-littlesmilingcloud%40gmail.com
