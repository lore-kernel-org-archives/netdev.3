Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA547A86D
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519464; cv=none; b=iWobeoNj54+z2BNuGhz99WcNt/DgQYTZUtUsIyubkxUY1bgnwBED+PDr5ZkBJ9IkI9jheBflrdzT7ws01VPkV86r3JoORBGjoeAGD/SXnL3Rs/09SsP3X+q5TkAxXd1INZWbNv3yG14ySGDDiLxLNX0dw1ER6Sw7y7yEoeLu8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519464; c=relaxed/simple;
	bh=00600oSvAeA0VSIQ3JfTc3YhhpUAC/9WAAVsFNnp3sw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tH18RgKrYeSJM6DAlna0Ut5EX7r1aPYo0jc7btF2J/0iSNNHuGAFXabqd2LFvC2+W5Y18Oi43sgki4Ysdf8Qsg/+B7pIDtHLMKKI3mQmXeZ6hLQE+SZzHWF9xB6z6BS1fBorJR/jaf2JQDpHmGX3F42togy4f+ZTFCqqXo6Dk74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mebl243v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mebl243v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E6C1F00A3D;
	Fri,  4 Sep 2026 10:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519463;
	bh=gaz3MhUpaOGg06hu3XPmp1a5LT+ir6G1vt7IaHVJyJ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Mebl243v5e+kHWQu/s51SXFR3GSsLGE4xnbA0dpP5NVQSEaHHknWOSCYlgRTIrDbE
	 wJZgnDlcVDC8soqGr8XINTaB4GKhYI38ydCY7efitIoO5+E6zNgwEVhgmpjg8Uvi0g
	 6jsAL0mEIUn1dg4GKe697I4X3Lkg0Wp6eJGbrmB2NUBinNJD8YnYcXXTv74FofoCo/
	 Tc3l6CQmoXBYxtFN7jPLBxRa7qNxupVUp7tpgi6QtjdoteXZ9yUJhywcPcpUt03att
	 k7wCPgqsT8nEvhwzgTYwQ/QMByQ70HqvHnLbylMyqUJbxD6tfrk1pbhOULFNuf7mnL
	 vf62PLWmZqZiQ==
Subject: Re: [PATCH net v5 4/4] net: ipv6: Clamp to IP6_MAX_MTU in
 ip6_dst_mtu_maybe_forward
From: netdev-bot+sashiko@kernel.org
To: alice.kernel@fastmail.im
Cc: willemdebruijn.kernel@gmail.com, dsahern@kernel.org, idosch@nvidia.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, shuah@kernel.org, hannes@stressinduktion.org,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org, alice@isovalent.com,
 willemb@google.com
Date: Fri, 04 Sep 2026 10:57:41 +0000
Message-ID: <178851946185.4131868.17228670653592431625@kernel.org>
In-Reply-To: <20260901195714.673548-5-alice.kernel@fastmail.im>
References: <20260901195714.673548-5-alice.kernel@fastmail.im>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incomplete fix: the clamp value chosen (IP6_MAX_MTU = 0xFFFF +
  sizeof(struct ipv6hdr) = 65575, include/net/ip6_route.h:44) is 40…

--

net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward

This restores an IP6_MAX_MTU upper bound on the value returned by
ip6_dst_mtu_maybe_forward(), which was dropped when the helper was
introduced in commit 427faee167bc. The stated goal is to avoid 16-bit
overflows in forwarding paths, mirroring the IPv4 clamp added by commit
ac6627a28dbf.

> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index c69f1c8719223..b9e8d2b759e9b 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -384,6 +384,8 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
>  	rcu_read_unlock();
>  
>  out:
> +	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
> +

[Severity: Medium]
Does this clamp actually bound the 16-bit store the changelog refers to?

IP6_MAX_MTU in this same header is:

include/net/ip6_route.h:
	#define IP6_MAX_MTU (0xFFFF + sizeof(struct ipv6hdr))

so the bound is 65575, which is 40 above U16_MAX.

The IPv4 precedent quoted in the commit message does not look analogous
here.  include/linux/ip.h has:

	/* IPv4 datagram length is stored into 16bit field (tot_len) */
	#define IP_MAX_MTU	0xFFFFU

That is exactly U16_MAX, so the IPv4 clamp does bound a u16 consumer, while
the IPv6 value chosen here does not.

The forwarding-path consumer that narrows to 16 bits is
flow_offload_fill_route() in net/netfilter/nf_flow_table_core.c:

	case NFPROTO_IPV6:
		flow_tuple->mtu = ip6_dst_mtu_maybe_forward(dst, true);

and the destination field in include/net/netfilter/nf_flow_table.h is:

	struct flow_offload_tuple {
		...
		u16				mtu;

Any returned value in [65536, 65575] truncates to 0..39 there.

Is the new deterministic output worse than the unclamped case for that
consumer?  After this change every egress device with an MTU at or above
65575 yields exactly 65575, which truncates to exactly 39.  Then in
nf_flow_offload_ipv6_forward() in net/netfilter/nf_flow_table_ip.c:

	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
	if (flow->tuplehash[!dir].tuple.tun_num)
		mtu -= sizeof(*ip6h);

	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
		return 0;

With a truncated tuple.mtu of 39 and the peer direction carrying tun_num,
the unsigned int subtraction of sizeof(struct ipv6hdr) wraps to roughly
4294967295, and nf_flow_exceeds_mtu():

	static bool nf_flow_exceeds_mtu(const struct sk_buff *skb, unsigned int mtu)
	{
		if (skb->len <= mtu)
			return false;

then returns false for every packet size, so the fast-path MTU check no
longer fires.

Is a raw MTU above U16_MAX reachable in-tree?  The idev->cnf.mtu6 branch
takes dev->mtu, and vrf_setup() in drivers/net/vrf.c does:

	dev->min_mtu = IPV6_MIN_MTU;
	dev->max_mtu = IP6_MAX_MTU;
	dev->mtu = dev->max_mtu;

Devices that leave max_mtu unset (loopback, for instance) also accept
arbitrarily large values, since dev_validate_mtu() in net/core/dev.c only
enforces an upper bound when max_mtu is non-zero:

	if (dev->max_mtu > 0 && new_mtu > dev->max_mtu) {

Would clamping to U16_MAX, or fixing the narrowing at the flowtable
consumer, be closer to what the changelog describes?

One related note on the reasoning: the locked route metric path does not
appear to be a way to get above 65535, since ip_metrics_convert() in
net/ipv4/metrics.c clamps RTAX_MTU to 65520 and is the only writer for
user-supplied IPv6 route metrics.

>  	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901195714.673548-1-alice.kernel%40fastmail.im
