Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA63B05B1;
	Wed, 23 Sep 2026 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176000; cv=none; b=Tn+GtR+7k3+kC5GWXOD7tFqQktHrwga9KND5HovM8HBQHZJXOyeuUQ/eg7lQFxjS1/4T3XUlD2pW1XpCMM/tdF41a2QJv9DcL0dNG2X6f9xLV+h4gSzWqoVDNeU8U66CRxUCoRAxalLu4XB+4Zl1iYnX7oxx+lm+l2hbmA+leb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176000; c=relaxed/simple;
	bh=tEZMWoc7ylzkztYMLYzOBZeVdD+VYdXNX30ZmKqeZoo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tmWI53miG9JJk8EfJL2axh6IgHf3mjZM1ReOSyRiFp9y2mJ/DuKQLFPGGL5qVd3ohl4fDBTljxcRulOlPrwHilrVPJ2tUyqn8ddQfG8LmLT/RSFunSHoi7J7L9npQo04o9/RvOJlkGzg3hUHVGwAWuLFAOLEus1mmdCe6j9nznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDOhmOOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDOhmOOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E571F00893;
	Wed, 23 Sep 2026 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790175999;
	bh=408Z/FRlj+syYL3BVhuVWPfxZ3GtaOTCx3Vpdy4zW+s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BDOhmOOFXJvrzbxeSJFnSlLg9hTfxJJMG+GQkb/SZm4x6jnPD5T1M/SwQld7XOTFY
	 2NNPDsxzusF50ESR/QJyDSHPb7fpvAO4UdOP/tlByVzmdSQBWgT2LGSrZJjWdLbtMl
	 T4cvc6Khy3ch6uPIeeHEIqVvo49iEBj0ib8DvokqXeaJ5wfhwOr8uXHUa4GWXRDP1m
	 PsYOXeIU4uUBxdcKCGWpOLHZAQLuejwVEEyVJ69MkY9xLeyJD5snNH+dhcfh/hdjSJ
	 2/V7c7+HfOSWkyDhJAUgbv0ImFCHHQ/IHIlF8iiMDSMJcqO+Klz+0/kUaD4YdUfH3x
	 q+yq3W5UJW3Uw==
Subject: Re: [PATCH] ipv6: fix payload_len inflation in ip6_xmit() when
 IPV6_RTHDRDSTOPTS is set without IPV6_RTHDR
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 15:06:38 +0000
Message-ID: <179017599817.2160803.12902287847020834080@kernel.org>
In-Reply-To: <20260919210620.3029622-1-benquike@gmail.com>
References: <20260919210620.3029622-1-benquike@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message of "ipv6: fix payload_len inflation in
  ip6_xmit() when IPV6_RTHDRDSTOPTS is set without IPV6_RTHDR"…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but reported for
  completeness of the concern set: the per-socket extension-header…

--

ipv6: fix payload_len inflation in ip6_xmit() when IPV6_RTHDRDSTOPTS is set without IPV6_RTHDR

This normalizes the ipv6_txoptions passed to ip6_xmit() with
__ipv6_fixup_options() so that seg_len and head_room no longer account for
opt->dst0opt when opt->srcrt is NULL, since ipv6_push_nfrag_opts() does not
push dst0opt in that case.  The code change itself looks right and covers
every ip6_xmit() call site.  My questions below are about the changelog
text and about a related accounting mismatch elsewhere.

> ipv6: fix payload_len inflation in ip6_xmit() when IPV6_RTHDRDSTOPTS is set without IPV6_RTHDR
>
> When ipv6_fixup_options() was introduced to ignore destination options
> before a routing header (opt->dst0opt) unless a routing header
> (opt->srcrt) is also present, rawv6_sendmsg(), udpv6_sendmsg(), and
> inet6_csk_xmit() were updated to normalize `opt` via
> ipv6_fixup_options(), while other callers pass `np->opt` directly into
> ip6_xmit() (such as tcp_v6_send_response(), sctp_v6_xmit(), and
> l2tp_ip6_xmit()).

[Severity: Medium]
Could the list of affected callers be revisited?  Three of the four named
functions do not seem to match the code.

inet6_csk_xmit() in net/ipv6/inet6_connection_sock.c does not normalize
opt anywhere:

	res = ip6_xmit(sk, skb, fl6, sk->sk_mark, rcu_dereference(np->opt),
		       np->tclass, READ_ONCE(sk->sk_priority));

A grep for ipv6_fixup_options/__ipv6_fixup_options matches only
net/ipv6/ip6_output.c, net/ipv6/exthdrs.c, net/ipv6/raw.c, net/ipv6/udp.c,
include/net/ipv6.h and net/l2tp/l2tp_ip6.c.  Since inet6_csk_xmit() is the
queue_xmit handler in ipv6_specific, isn't the ordinary IPv6 TCP data path
one of the affected callers rather than an already-fixed one?

tcp_v6_send_response() passes NULL for opt:

		ip6_xmit(ctl_sk, buff, &fl6, fl6.flowi6_mark, NULL,
			 tclass, priority);

so can it inflate payload_len at all?

There is no l2tp_ip6_xmit() in the tree.  l2tp_ip6_sendmsg() already does:

	opt = ipv6_fixup_options(&opt_space, opt);
	ipc6.opt = opt;

and transmits via ip6_append_data(), with no ip6_xmit() call in
net/l2tp/l2tp_ip6.c.

Should the list instead read inet6_csk_xmit(), tcp_v6_send_synack() (which
falls back to rcu_dereference(np->opt) when ireq->ipv6_opt is NULL), and
sctp_v6_xmit()?

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 550965058991..17d6add40864 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -295,6 +295,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
>  	struct in6_addr *first_hop = &fl6->daddr;
>  	struct dst_entry *dst = skb_dst(skb);
>  	struct inet6_dev *idev = ip6_dst_idev(dst);
> +	struct ipv6_txoptions opt_space;
>  	struct net *net = sock_net(sk);
>  	unsigned int head_room;
>  	struct net_device *dev;
> @@ -304,6 +305,9 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
>  	int ret, hlimit = -1;
>  	u32 mtu;
>  
> +	if (unlikely(opt))
> +		opt = __ipv6_fixup_options(&opt_space, opt);
> +

[Severity: Medium]
This isn't something introduced by this patch, but the change makes the
divergence more visible, so I'll mention it here.

With dst0opt suppressed, the extension header bytes ip6_xmit() emits for a
socket that has IPV6_RTHDRDSTOPTS set and no IPV6_RTHDR are
opt_flen + opt_nflen - ipv6_optlen(opt->dst0opt), because
ipv6_push_nfrag_opts() in net/ipv6/exthdrs.c only pushes dst0opt when
opt->srcrt is non-NULL.

The per-socket overhead accounting still uses the raw np->opt counters.
tcp_v6_connect():

	if (opt)
		icsk->icsk_ext_hdr_len += opt->opt_flen +
					  opt->opt_nflen;

tcp_v6_syn_recv_sock():

	if (opt)
		inet_csk(newsk)->icsk_ext_hdr_len = opt->opt_nflen +
						    opt->opt_flen;

do_ipv6_setsockopt() in net/ipv6/ipv6_sockglue.c:

			icsk->icsk_ext_hdr_len =
				psp_sk_overhead(sk) +
				opt->opt_flen + opt->opt_nflen;

and sctp_v6_ip_options_len() in net/sctp/ipv6.c:

	opt = rcu_dereference(np->opt);
	if (opt)
		len = opt->opt_flen + opt->opt_nflen;

Since inet6_csk_xmit() and sctp_v6_xmit() hand that same np->opt to
ip6_xmit(), do these sites overstate the emitted bytes by
ipv6_optlen(dst0opt), clamping the TCP MSS and lowering the SCTP
fragmentation point for bytes that never reach the wire?  The direction is
conservative, so I don't see an under-reservation, but should these be
normalized the same way?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919210620.3029622-1-benquike%40gmail.com
