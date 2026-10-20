Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479426;
	b=G1A3z0aQ+BsgNAFO1h3/wMZs3Efn76SrcIkXAdsJpG6VTqXMxDDOFjbDjRdPvt0pENZO
	 Crxzb48mIworK9HaxEUoTfKxaz6QFCXgzK8w8O9Uo/ZZOqoss/GaqdFOmleJwMUWwsysj
	 0gCY/h8ODfMpQMBiP0L0WsWgwz1XfDVzI25PWoOz7SCCjsE9pAaZRh5Vq0TQRE2tWVpnk
	 MwUuDpuYaQOtNw5N/WDiyKCDx0Zf15+jh4CMQLklF06bxtOX3KiofSL+UwcfRnLVu1taW
	 F66r50UeBgGPJWXOJ34r8+5ZEEYTTGDlLLJB+N3ZccqG1CCnf87SZ24gZo4cVv8uOng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479426;
	h=Received:Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 X-sashiko-severity:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=iG0aUIBeV/zYIg4N92+3vkhTNWz/ar0q70g/y98WEaw=;
	b=VkRiIrG19E7eJ+Gf2NAvDla44UUUVnAO3dbjqvSTM9R42BvH5abFPlvUh8pvdxpJo+s/
	 XF2uGwi/FxiLyNnhNy3XvSaiM0Z5rST0EH7y96gHLB1rKVkji6VoU+jmgLp1PbsNu5iHn
	 5QcylTF48AAGUyThCXBIT4rhmGjTEKoVK+oaDsv7DIyQtWKkQXjTRyvtZJ8vywg+AwnQ7
	 udGBLCy3rmK5wEcg3uqWsy4u6q5RVzAkWJt5fXDVlLo4IKWH+VBRYPgT6LpPJWS1g5uLi
	 1cKNjuRWD5Yzw6DfxIBMMtAGRidIfgyWVrb+SVXHHoe//gJJw7Dpa+OLRa8TG1wOrQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14B60A2617;
	Tue, 20 Oct 2026 06:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ECE1F000C4;
	Tue, 20 Oct 2026 06:57:05 +0000 (UTC)
Subject: Re: [PATCH net-next 2/3] ipv6: take fib6_sernum from a sequence
 shared by all netns
From: netdev-bot+sashiko@kernel.org
To: odys.yuan@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, kuniyu@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 06:56:34 +0000
Message-ID: <179247939485.3135.13096111463721138716@kernel.org>
In-Reply-To:
 <20261016-bug-net-netns-move-rcu-barrier-v1-2-4157d798658f@gmail.com>
References:
 <20261016-bug-net-netns-move-rcu-barrier-v1-2-4157d798658f@gmail.com>
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

- [Medium] The patch makes every netns take fib6_sernum (and fn_sernum)
  from one static counter, fib6_sernum_seq.

--

ipv6: take fib6_sernum from a sequence shared by all netns

This patch replaces the per-netns fib6_sernum counter with one static
sequence, fib6_sernum_seq, that all netns draw from, including for the
initial value. The goal is that a nexthop pcpu route cached against one
netns can no longer match the fib6_sernum of another netns after its
device moves.

> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 0dc6ebee6e568..c66466be64451 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -89,13 +89,21 @@ static void fib6_walker_unlink(struct net *net, struct fib6_walker *w)
>  	write_unlock_bh(&net->ipv6.fib6_walker_lock);
>  }
>
> +/*
> + * Draw every fib6_sernum from one sequence shared by all netns, so that a
> + * route cached against one netns never matches the sernum of another one,
> + * e.g. after its device moved.
> + */
> +static atomic_t fib6_sernum_seq;
> +
>  static int fib6_new_sernum(struct net *net)
>  {
> -	int new, old = atomic_read(&net->ipv6.fib6_sernum);
> +	int new, old = atomic_read(&fib6_sernum_seq);
>
>  	do {
>  		new = old < INT_MAX ? old + 1 : 1;
> -	} while (!atomic_try_cmpxchg(&net->ipv6.fib6_sernum, &old, new));
> +	} while (!atomic_try_cmpxchg(&fib6_sernum_seq, &old, new));
> +	atomic_set(&net->ipv6.fib6_sernum, new);
>
>  	return new;
>  }

[Severity: Medium]
The comment says a cached route "never matches the sernum of another one".
Does the code guarantee that once fib6_sernum_seq wraps?

The shared counter still wraps to 1 at INT_MAX:

    new = old < INT_MAX ? old + 1 : 1;

Nothing checks whether the reissued value is still held by a live netns, a
fib6_node, or a cached dst.

Validation has not changed. ip6_rt_pcpu_alloc() records only the value:

    if (f6i->nh)
        pcpu_rt->sernum = rt_genid_ipv6(dev_net(dev));

rt6_is_valid() then compares it for plain equality against the device's
current netns:

    return rt6->sernum == rt_genid_ipv6(dev_net(rt6->dst.dev));

and ip6_dst_check() returns the dst on a match:

    if (rt->sernum)
        return rt6_is_valid(rt) ? dst : NULL;

After a wrap, couldn't netns B be given the same value S that a socket in
netns A cached? If A's device then moves into B while B holds S, the
original problem comes back in the window before nexthop_free_rcu() runs.

This patch also links netns that used to be independent. Each successful
fib6_add(), fib6_flush_trees(), the link up/down sync paths, and
rt6_insert_exception() (reachable from a received ICMPv6 Packet Too Big)
now advance the shared counter. Any netns can therefore push it through a
full cycle, including one owned by an unprivileged user namespace.

Before this patch, netns N could only reissue an old value after N itself
made about 2^31 draws. Now, once the global counter has wrapped, can a
route add in N draw exactly N's current fib6_sernum, or a value still held
by a stale cookie? In that case the cached dsts that fib6_add() should
invalidate would still pass ip6_dst_check() and keep using the old route.

A hit needs about 2^31 draws plus an exact match, so it is far rarer than
the per-netns collisions this patch removes. The commit message makes the
same absolute claim, though:

    so that a cached route never matches the fib6_sernum of
    another netns.

The later patch in this series, "net: remove rcu_barrier() from
__dev_change_net_namespace()", relies on this as well. It cites that
"rt_genid and fib6_sernum are now unique across netns" as its reason for
dropping the barrier. The end of the series doesn't seem to add a wrap
guard, a wider generation, or a check on the originating netns.

Could the comment and the commit message be reworded so they don't claim
uniqueness? Or, if the rcu_barrier() removal depends on uniqueness, could
the series handle the wrap explicitly?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f%40gmail.com
