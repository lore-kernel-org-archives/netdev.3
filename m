Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482BD1DDFE;
	Thu,  8 Oct 2026 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437550; cv=none; b=u04fWTMNY4gESQtQabdMmS4qy8/eE4oUfHI/1XfWfNNJYwIpUWl9PSBDZfAGbEQagH0F8/tOynfCvwZutjEyV1EYCdgFqGMAWoS5nF8gFoJayTodaEOLVmnm4NKf7G8zS+UFr3FlLzb3lc5jC+ijzydra/JBifnP8cmUzfVlkF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437550; c=relaxed/simple;
	bh=2JygiM1G+vO8exb9T5VYnbVLjrDyKoenYUudXz4Vzew=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ud33ULRogEc2+4QbmgXQj6m1lOLU7bPnikkOLIOtNtc3ngfcG08PHsKn9FkPY39hLZtU1jQaf9xcBF7gKuXh5vWG5b6X4eKyFWqm8Ak2JdnCPMvO0Pf1fIyOHI5kf3lYeGzwA7dCTiJstuFivFi1f+vvRnHXFseNXzKVED9aaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pwz7EEo3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwz7EEo3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642FF1F000FF;
	Thu,  8 Oct 2026 05:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791437548;
	bh=W4npfQHU2o6ILTB4UAPnCODJ/YM+ygUK+JIihM2xnzU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pwz7EEo3slvwRrTLftj8pt+6W62SOBTroeFZAeUMdh9LTp70PybXGPHvsg0HnlYMg
	 wP4dWXqLe3f41lYMt/VnA7sBup6pmP7eS2W0MaOBQgIeszOoEgtKc/KDBXGMfIAom4
	 MYIDMcfKptA/SwJOxuK5xlDKU3OmGiYbd+onyUD06cIvGnTlcVhgVZg2P6MwD8iNGG
	 8ydu5phRGjuPXiJTV/Mx3cRz08HjYxb26k3icoYtIcD+8RNXh4mAUrJHR2X9+GnItg
	 hxSoZK3w/H3mVgyE4oI5dDS3O8Mj4nl6BqYH180EtyCpW9p0v9dn/4hAQL0oWRj93h
	 6oThBOZPvuNGw==
Subject: Re: [PATCH net-next 1/2] seg6: skip the route refcount in
 seg6_lookup_any_nexthop()
From: netdev-bot+sashiko@kernel.org
To: yuya.kusakabe@gmail.com
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 05:32:27 +0000
Message-ID: <179143754793.434549.1782243550071194894@kernel.org>
In-Reply-To: <20261005-seg6-lookup-noref-v1-1-092e84774e80@gmail.com>
References: <20261005-seg6-lookup-noref-v1-1-092e84774e80@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After this patch, the exported helper
  seg6_lookup_nexthop()/seg6_lookup_any_nexthop()…

--

seg6: skip the route refcount in seg6_lookup_any_nexthop()

This patch makes seg6_lookup_any_nexthop() look up input and table routes
with RT6_LOOKUP_F_DST_NOREF. When the route is not on the uncached list,
it attaches the result with skb_dst_set_noref(). The commit message
assumes every caller runs inside the receive path's RCU read-side section.

> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 0c3d1be7f1299..4bde3669d0dda 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -342,6 +342,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
>  		fl6.flowi6_flags = FLOWI_FLAG_KNOWN_NH;
>  
>  	if (!tbl_id && !oif) {
> +		flags |= RT6_LOOKUP_F_DST_NOREF;
>  		dst = ip6_route_input_lookup(net, skb->dev, &fl6, skb, flags);
>  	} else if (tbl_id) {
>  		struct fib6_table *table;

[ ... ]

> @@ -372,10 +374,14 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
>  		rt = net->ipv6.ip6_blk_hole_entry;
>  		dst = &rt->dst;
>  		dst_hold(dst);
> +		flags &= ~RT6_LOOKUP_F_DST_NOREF;
>  	}
>  
>  	skb_dst_drop(skb);
> -	skb_dst_set(skb, dst);
> +	if ((flags & RT6_LOOKUP_F_DST_NOREF) && !dst->rt_uncached_list)
> +		skb_dst_set_noref(skb, dst);
> +	else
> +		skb_dst_set(skb, dst);
>  	return dst->error;
>  }

[Severity: High]
The commit message says the helper is called "either directly from the
seg6local input handler or from a netfilter okfn". Does that also hold for
the BPF callers in net/core/filter.c?

bpf_push_seg6_encap() ends with:

net/core/filter.c:bpf_push_seg6_encap() {
    ...
	return seg6_lookup_nexthop(skb, NULL, 0);
}

LWT_IN programs get there through bpf_lwt_push_encap() with
BPF_LWT_ENCAP_SEG6 or BPF_LWT_ENCAP_SEG6_INLINE. lwt_in_prog_ops also sets
.test_run = bpf_prog_test_run_skb. In that path, bpf_test_run() runs the
program on the same skb for every iteration. Between iterations it can
drop RCU and reschedule:

net/bpf/test_run.c:bpf_test_timer_continue() {
    ...
	if (need_resched()) {
		/* During iteration: we need to reschedule between runs. */
		t->time_spent += ktime_get_ns() - t->time_start;
		bpf_test_timer_leave(t);
		cond_resched();
		bpf_test_timer_enter(t);
	}
    ...
}

With RT6_LOOKUP_F_DST_NOREF, ip6_pol_route() no longer takes a reference
on pcpu or exception routes. Either kind can now stay on the skb as a
noref dst through that window.

Suppose the route is released during that window, either by a route
delete or replace (fib6_nh_release_dsts() -> dst_release() -> call_rcu)
or by exception aging. Can the next iteration then read the freed dst
before a new lookup replaces it? A few examples:

bpf_get_route_realm()
    dst_tclassid(skb)
        reads skb_dst(skb)->tclassid

bpf_lwt_push_encap(BPF_LWT_ENCAP_SEG6)
    bpf_push_seg6_encap()
        seg6_do_srh_encap()
            __seg6_do_srh_encap()
                struct dst_entry *dst = skb_dst(skb);
                struct net_device *dev = dst_dev(dst);
                struct net *net = dev_net(dev);

bpf_lwt_push_encap(BPF_LWT_ENCAP_SEG6_INLINE) with an HMAC TLV
    skb_dst_dev_net(skb)

Before this patch, skb_dst_set() always attached a refcounted dst, so the
dst stayed valid across iterations.

The follow-up patch in the series ("seg6: skip the route refcount in
seg6local IPv4 lookups") only changes input_action_end_dx4_finish() and
input_action_end_dt4(). It does not touch filter.c, so the problem is
still there at the end of the series.

Would it make sense to keep a refcounted dst for the BPF callers? One
option is skb_dst_force() in bpf_push_seg6_encap(). Another is to limit
the NOREF lookup to seg6local's own input actions and leave the shared
exported helper alone.

The declarations of seg6_lookup_nexthop() in include/net/seg6.h and
seg6_lookup_any_nexthop() in include/net/seg6_local.h also don't mention
that the attached dst is now valid only inside the caller's RCU read-side
section.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005-seg6-lookup-noref-v1-0-092e84774e80%40gmail.com
