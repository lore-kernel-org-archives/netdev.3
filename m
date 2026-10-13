Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA84ED197;
	Tue, 13 Oct 2026 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935943; cv=none; b=RKJMK2nI0XAmL0QU0jUxx7HEr0lIaZVWkZndBuuohXnBFwN6nwx/UdIJoxtXcYKU9AYgUoqUl5s/CY//v3W5t/M+T4xyv6AxfKrnnbwzVa8o6AsAdtxz8E1uOrJXV6gQITn85EXidu2TMl7S92wWZCTOuIhnybt0fZD6NgDgZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935943; c=relaxed/simple;
	bh=7MeNxT151cAEEfd1DzYq4WdQU4e3st0c76cykcFlyFI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RU/Mg5/UTnxxc7lkGIsf/Uo8x67Yi1Sm3+eEk6GFzCYVQwMpIF801oThx0OJ5fGS0D/G0H1WlJAdbuYssrAsXfpRL4MidsByzOkw2bu56S94scmbFLc/i0x8VPz60oFDL/q1Tpk3dnR7n4ERfLTFGjz3yedus4huU9SrXpGYM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=MxqZGNcy; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=wjvu82Wq; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="MxqZGNcy";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="wjvu82Wq"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69DNwOcL003332;
	Wed, 14 Oct 2026 01:58:29 +0200
Received: from lubuntu-18.04 (host-79-32-222-240.retail.telecomitalia.it [79.32.222.240])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id B81B512070A;
	Wed, 14 Oct 2026 01:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1791935899; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV8JLl5mYlAGq7CwtjyL4R/iEcSriUEtAuO49j5t83w=;
	b=MxqZGNcyFEE8pa8IentDa3wccbHhn4rT7BoxHSaWSPHJ2q9FbodcDJkNPAMZ9ZT/X8fQft
	yjR9aqZtkEPCNtCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1791935899; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV8JLl5mYlAGq7CwtjyL4R/iEcSriUEtAuO49j5t83w=;
	b=wjvu82Wqm8Fid2MxwvtVziFn1JRG1G/Q3KR95c6RGHmndV1MkqpcX89y4mLCVNS1lux7GZ
	Sr8kGuL/MGhyekYamTAMb+n0zUi+++freAX03j++CHaYsvKsbrFu9tm6AUEdHb/nJ39XXk
	oSWpa1wMLvM7+6K6u9XrQ0WJ96+qfNDQgwBO7/Lqzvjb/K5K8Xqc2hktnSqQwUcoZnZAsc
	nPikfLEOIKc0WgPd0kZqPZ4WasvQqPEP8tO3PXMJJsmw4KfIwsTvnecrxSJS6R/rzbg7Oh
	zSZLgdRt9TXNoWwOVRYp11dV2UPV33WdZ5GPhntLc+JV36rr52YpHd4oTTxUuQ==
Date: Wed, 14 Oct 2026 01:58:19 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next v2 1/2] seg6: skip the route refcount in
 seg6local IPv6 lookups
Message-Id: <20261014015819.f26040ee1b2adb4a90798df8@uniroma2.it>
In-Reply-To: <20261010-seg6-lookup-noref-v2-1-51c09dd98197@gmail.com>
References: <20261010-seg6-lookup-noref-v2-0-51c09dd98197@gmail.com>
	<20261010-seg6-lookup-noref-v2-1-51c09dd98197@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Sat, 10 Oct 2026 19:10:39 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

Hi Yuya,

Thanks for v2. I re-ran the BPF_PROG_TEST_RUN case from v1 on 32-bit ARM
with the changes of v2, and I could not reproduce the use-after-free
anymore.

> ip6_route_input() attaches the input route to the skb without taking a
> reference, relying on the RCU read-side section of the receive path.
> The seg6local input actions run in that same section, either directly
> from the seg6local input handler or from a netfilter okfn, yet
> seg6_lookup_any_nexthop() takes and drops a route reference for every
> packet.

For a packet queued with NFQUEUE, the okfn runs later from nf_reinject(),
under the rcu_read_lock() of the nfnetlink verdict handler. Is "that same
section" accurate for that case?

> [snip]
>  	if (!tbl_id && !oif) {
> +		flags |= RT6_LOOKUP_F_DST_NOREF;
>  		dst = ip6_route_input_lookup(net, skb->dev, &fl6, skb, flags);
> [snip]
> +		flags |= RT6_LOOKUP_F_DST_NOREF;
>  		rt = ip6_pol_route(net, table, oif, &fl6, skb, flags);

With RT6_LOOKUP_F_DST_NOREF, ip6_pol_route() no longer calls
ip6_hold_safe(). If the route it finds is released on another CPU during
the lookup, the packet can be dropped without an ICMP error. Before the
series, when ip6_hold_safe() did not get the reference on the released
route, the packet went to the next policy rule, or to ip6_null_entry and
its ICMPv6 Destination Unreachable. As far as I can see, only packets that
race with the release are affected. It is still a change in behavior, and
it would be worth at least mentioning it in the commit message.

> [snip]
>  int seg6_lookup_nexthop(struct sk_buff *skb,
>  			struct in6_addr *nhaddr, u32 tbl_id)
>  {
> -	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, false, 0);
> +	int err;
> +
> +	rcu_read_lock();
> +	err = seg6_lookup_nexthop_noref(skb, nhaddr, tbl_id);
> +	if (!skb_dst_force(skb)) {
> +		struct dst_entry *dst;
> +
> +		dst = &dev_net(skb->dev)->ipv6.ip6_blk_hole_entry->dst;
> +		dst_hold(dst);
> +		skb_dst_set(skb, dst);
> +		err = dst->error;
> +	}
> +	rcu_read_unlock();
> +
> +	return err;
>  }

The split works, and the contract is now in the names. One detail is how
seg6_lookup_nexthop() takes its reference: after the noref lookup, with
skb_dst_force(). Because of this, the BPF LWT helpers are affected by this
race too. Before the series, when ip6_hold_safe() did not get the reference
on the released route, seg6_lookup_nexthop() returned 0 if a later policy
rule had a route, or -ENETUNREACH. Now it can return -EINVAL in both cases.
The Sashiko review points out the second one.

It would be good to keep seg6_lookup_nexthop() unchanged for the BPF
helpers, also while a route is being released. One idea, as a refinement of
the split, could be a common lookup function with a noref argument. For
example, seg6_lookup_any_nexthop_noref() would call it with noref set, and
seg6_lookup_nexthop() with noref clear, keeping the refcounted lookup it
had before the series. What do you think?

> [snip]

Ciao,
Andrea
