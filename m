Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479395;
	b=HQhhCyQeSsJXIiqOTZmO2ZEYzoXGIeCxuxuWPHRaln2etQOVxKM0ze8AHAO1KscA6qJA
	 ofrQTBNcivumEEAkA0f16epOs19A0aFTMSJWo+W7FXgQtpEN5vBM49DCLI38d3oDn4MPr
	 UkYSqAVmsEwFm5I/7Bll6BTGvutZsh+IXYK6EbcKNCvDvQzh4MLrbS3ETciSJkoJERDc1
	 N3qM6wZOJ3ZJn3fPPoEfKRWcnIhXYTRcy27h/rCnmzFi5S4PSXFn9NNOfr3zATf/qtiPW
	 GwAWsBE36x8YXd2p3gN47YWamgcbjQHcyVwnljl3WxHXuv5aJRh1R2BLDcObLRWw5dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479395;
	h=Received:Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 X-sashiko-severity:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=5tC1oPv5bw067d36adR/tx+nkyFn+JAeQtEauC9q75I=;
	b=finF+pyUDZ4icpq0a2PJri37hGXxwQYfFaHis1I3JfBdaQTt0kCFp8LFTnhNGrP2riuc
	 E85I8Y3ynUHmhZnldYF2kqkYzJf6UA+9OVQsWwdZ+sxP+y41HMumIhweUO3Fo/nTEBMOk
	 /QeuOXz4sPdSBNSKFxAuSiFbg3KEcaj23K9eM++d1poF8oqm+ICtEKM6EHk5P4C4Dq56q
	 f6GvLDhpFhOzgQ1Mk9Cn31kT8iwTY1vpeJx1dl3NUco+9Qif7XYy18Mo6XrP+ypusIie1
	 iYkm+lfeW2+cMyfSI0iofH6Y96IKZaMRyBpti6JLB6miBelBoRveJl71VrZauuKFuHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CE606A31E;
	Tue, 20 Oct 2026 06:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D22D1F000C4;
	Tue, 20 Oct 2026 06:56:33 +0000 (UTC)
Subject: Re: [PATCH net-next 1/3] ipv4: draw rt_genid from a sequence shared
 by all netns
From: netdev-bot+sashiko@kernel.org
To: odys.yuan@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, kuniyu@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 06:56:03 +0000
Message-ID: <179247936363.3135.8282502053822981062@kernel.org>
In-Reply-To:
 <20261016-bug-net-netns-move-rcu-barrier-v1-1-4157d798658f@gmail.com>
References:
 <20261016-bug-net-netns-move-rcu-barrier-v1-1-4157d798658f@gmail.com>
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

- [Medium] The patch says it stops cached routes from matching another
  netns's genid, but that guarantee breaks once the 32-bit counter wraps.

--

ipv4: draw rt_genid from a sequence shared by all netns

This patch takes every IPv4 rt_genid from one global atomic sequence
instead of a per-netns counter starting at 0. That includes the initial
value set in rt_genid_init(). The aim is that a cached route never
matches the rt_genid of another netns after its device moves, which
closes the window before the deferred dst_dev_put() for nexthop-backed
routes.

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 595a3b7f17830..bd52d14476f6f 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -393,6 +393,20 @@ static inline int ip_rt_proc_init(void)
>  }
>  #endif /* CONFIG_PROC_FS */
>  
> +/*
> + * Draw every rt_genid from one sequence shared by all netns. A route keeps
> + * the genid of the netns it was created in, and is checked against the netns
> + * its device is in now. Distinct values make that check fail once the device
> + * has moved to another netns.
> + */
> +static atomic_t rt_genid_seq;
> +
> +void rt_genid_bump_ipv4(struct net *net)
> +{
> +	atomic_set(&net->ipv4.rt_genid, atomic_inc_return(&rt_genid_seq));
> +}

[Severity: Medium]
Does the uniqueness guarantee still hold once rt_genid_seq wraps?

The commit message says:

  "so that a cached route never matches the rt_genid of another netns."

rt_genid_seq is a 32-bit atomic_t shared by every netns. Its values are
only distinct modulo 2^32, and nothing stops it from handing out a value
that a live netns or a cached rtable still holds.

Every rt_cache_flush() in any netns advances the counter. One source is
ipv4_sysctl_rtcache_flush(), which calls rt_cache_flush(net) on every
write to /proc/sys/net/ipv4/route/flush with no rate limit.
sysctl_route_net_init() exposes that sysctl in netns owned by
non-initial user namespaces:

net/ipv4/route.c:sysctl_route_net_init() {
    ...
		/* Don't export non-whitelisted sysctls to unprivileged users */
		if (net->user_ns != &init_user_ns) {
			if (tbl[0].procname != ipv4_route_flush_procname)
				table_size = 0;
		}
    ...
}

After a wrap, can this sequence still happen?

  rt_dst_alloc() stamps a route through dev D in netns A with genid g
  D moves to netns B
  B's latest bump (e.g. a fib_netdev_event() flush on link up) is g
  ipv4_dst_check()
    rt_is_expired()
      rth->rt_genid != rt_genid_ipv4(dev_net_rcu(rth->dst.dev))  /* false */
    route is accepted

If so, a socket in A keeps sending through D until the deferred RCU
teardown reaches dst_dev_put(). The chance per move is small (about
2^-32, and userspace can't see the counter), but the "never" in the
commit message is not strictly true.

The later patch in this series, "net: remove rcu_barrier() from
__dev_change_net_namespace()", removes the barrier because "rt_genid and
fib6_sernum are now unique across netns". After that change, genid
equality modulo 2^32 becomes the only protection for all cached IPv4
routes through a moved device, not just the nexthop-backed ones.

Would it make sense to state the modular limit in the commit message,
widen the genid, or have rt_is_expired() compare the originating netns
directly instead of relying only on genid equality?

> +EXPORT_SYMBOL_GPL(rt_genid_bump_ipv4);
> +
>  static inline bool rt_is_expired(const struct rtable *rth)
>  {
>  	bool res;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f%40gmail.com
