Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300E4848AE;
	Fri,  2 Oct 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937143; cv=none; b=Va5ucvHURj7I6BMWiV1G6spH6FK9PTKMZID3T0u2H4sfpJJ2F9BHSzXmy6w7XPHqRXPdVX1YsZCvdTioxOSXtBX/SZxlg5uZ1XAH9qBS4Bd0EvpBM2aik83leUZz+ZSGgVsqGTChgIaHzrWFZndV4/p/3LB5B7QmGOUqv+UNjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937143; c=relaxed/simple;
	bh=ZYMfdd3xtPZiqzEgBgYVh55FJSIQ6jI0tZE41QyZL6c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a11bRNdBoNEZcA8Bj3xgdvUPmGULb3C5+VPxttHWBRtE2qnfg1nl55lU2O0JUu2tZoOLBSiOFcbERsVd2Cwbk0ZYoXY9f83lgnY9zDZzJWaD/2K6EalR08bnVKqvX6AlvTqksSjQRLOJH2zea3KKL6OvIH+/0m+mQ873YWdWvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6aivVbE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6aivVbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818741F000FF;
	Fri,  2 Oct 2026 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937141;
	bh=2MP/A0+sVTc8LE/C7etB7urBpiREZW6cFNOa22KELkg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d6aivVbE/InADjohAxt12MEkQbVqb0lE9BmcGK6P7I84ySDeVxWSOBr+TWxbHRWan
	 Zyl2XRuKQA9SnSmWNYC1xnJj4nUfaiSPMZ+v8R9I7VUakhv0flkUPnL1LEgUPU2x8o
	 scZKLoBUEqgZZrIVI9qfn2GQ+BTC6ikAMd37azfHWJpxy8OHw3RLLaS00h3ytpyKbL
	 rcErdORTT0yfQAWcLOg415L9eTh9rkaa1L2UjqtwaOkI6WxqVtrM67CRJ4d1rmViIh
	 KW7B07d6BUxGFVH/Mc4+kbkVNYOZN6EpwVDZdnzx4Gr6UbEii+78/mg0YlQvkVSlgL
	 nE8QvaAQSIccw==
Subject: Re: [PATCH 04/16 net-next v2] tcp: move protocol agnostic TCP
 functions out of tcp_ipv4.c
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:20 +0000
Message-ID: <179093714003.434549.10902286539483663007@kernel.org>
In-Reply-To: <20260928193046.6698-5-fmancera@suse.de>
References: <20260928193046.6698-5-fmancera@suse.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message leaves out several behavioural and structural
  changes this patch makes.
- [Low] union bpf_tcp_iter_batch_item and struct bpf_tcp_iter_state were
  file-local to net/ipv4/tcp_ipv4.c.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  moves it verbatim from tcp_ipv4.c to tcp.c.

--

tcp: move protocol agnostic TCP functions out of tcp_ipv4.c

This moves the TCP functions that IPv4 and IPv6 share out of tcp_ipv4.c
into tcp.c, so they still build with CONFIG_IPV4=n. It also renames
tcp_v4_destroy_sock() to tcp_destroy_sock() and adds IPv4 guards to the
IPv4-mapped paths in tcp_ipv6.c. The /proc/net/sockstat and
/proc/net/snmp output is changed as well for CONFIG_IPV4=n.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 96a1a23e47fac..04d487a19b178 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h

[ ... ]

> @@ -2855,6 +2855,20 @@ struct sk_psock;
>  #ifdef CONFIG_BPF_SYSCALL
>  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
>  void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
> +
> +union bpf_tcp_iter_batch_item {
> +	struct sock *sk;
> +	__u64 cookie;
> +};
> +
> +struct bpf_tcp_iter_state {
> +	struct tcp_iter_state state;
> +	unsigned int cur_sk;
> +	unsigned int end_sk;
> +	unsigned int max_sk;
> +	union bpf_tcp_iter_batch_item *batch;
> +};
> +

[Severity: Low]
This isn't a bug, but why do union bpf_tcp_iter_batch_item and struct
bpf_tcp_iter_state move into include/net/tcp.h?

After this patch, net/ipv4/tcp.c is the only user, next to the bpf
iterator code. Could they stay local to that file? The commit message
also doesn't mention this move.

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index cf00386933d67..6c7b0816f950e 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c

[ ... ]

> @@ -2029,42 +2057,24 @@ static int __init inet_init(void)
>  
>  	if (init_inet_pernet_ops())
>  		pr_crit("%s: Cannot init ipv4 inet pernet ops\n", __func__);
> -#if IS_ENABLED(CONFIG_IPV4)
> -	/*
> -	 *	Initialise the multicast router
> -	 */
> -#if defined(CONFIG_IP_MROUTE)
> -	if (ip_mr_init())
> -		pr_crit("%s: Cannot init ipv4 mroute\n", __func__);
> -#endif
> -	ipv4_proc_init();
>  
> -	ipfrag_init();
> +#ifdef CONFIG_PROC_FS
> +	if (ip_misc_proc_init())
> +		pr_crit("%s: Cannot init ipv4 misc proc\n", __func__);
> +#endif
>  
> -	dev_add_pack(&ip_packet_type);
> -#endif /* CONFIG_IPV4 */
> +	if (IS_ENABLED(CONFIG_IPV4))
> +		inet4_late_init();

[ ... ]

> @@ -2078,12 +2088,8 @@ static int __init ipv4_proc_init(void)
>  		goto out_udp;
>  	if (ping_proc_init())
>  		goto out_ping;
> -	if (ip_misc_proc_init())
> -		goto out_misc;
>  out:
>  	return rc;
> -out_misc:
> -	ping_proc_exit();
>  out_ping:

[Severity: Low]
The commit message covers the TCP function move, the tcp_destroy_sock()
rename and the IPv4-mapped guards in tcp_ipv6.c. On procfs, it says only:

  "The implementation now force the inuse attrtibute to be zero when
  CONFIG_IPV4=n but the shared stats are represented correctly."

Should it also describe the other changes this patch makes?

ip_misc_proc_init() registers /proc/net/snmp, netstat and sockstat. It
now runs from inet_init() whenever CONFIG_PROC_FS is set, before
ip_mr_init() and before the raw/tcp4/udp4/ping proc setup. The out_misc
unwind is also gone, so if it fails the other proc entries are no longer
rolled back.

inet_init() is split into inet4_init() and inet4_late_init(). The
CONFIG_IPV4 #if guards around inetsw_array, ip_packet_type and the
ipv4_proc_init() declaration are removed, and the code relies on
IS_ENABLED() and dead code elimination instead.

With CONFIG_IPV4=n, snmp_seq_show() in net/ipv4/proc.c skips the Ip,
Icmp and IcmpMsg sections, so /proc/net/snmp starts with "Tcp:".
sockstat_seq_show() also drops the whole FRAG line, not just the inuse
values.

The later "ipv4: make CONFIG_IPV4 boolean" commit makes CONFIG_IPV4
selectable. After that, tools like nstat and netstat -s will see these
/proc format changes. Could they be documented in the commit message, or
split into a separate patch?

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 3ac4856852794..1f0fc46136ead 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c

[ ... ]

> @@ -1458,6 +1464,1115 @@ int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)

[ ... ]

> +static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
> +				      unsigned int new_batch_sz, gfp_t flags)
> +{
> +	union bpf_tcp_iter_batch_item *new_batch;
> +
> +	new_batch = kvmalloc_objs(*new_batch, new_batch_sz,
> +				   flags | __GFP_NOWARN);
> +	if (!new_batch)
> +		return -ENOMEM;
> +
> +	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
> +	kvfree(iter->batch);
> +	iter->batch = new_batch;
> +	iter->max_sk = new_batch_sz;
> +
> +	return 0;
> +}

[ ... ]

> +static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
> +{

[ ... ]

> +	/* Batch size was too small. */
> +	bpf_iter_tcp_unlock_bucket(seq);
> +	bpf_iter_tcp_put_batch(iter);
> +	err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
> +					 GFP_USER);
> +	if (err) {
> +		iter->cur_sk = 0;
> +		iter->end_sk = 0;
> +		return ERR_PTR(err);
> +	}
> +
> +	sk = bpf_iter_tcp_resume(seq);
> +	if (!sk)
> +		return NULL; /* Done */
> +
> +	expected = bpf_iter_fill_batch(seq, &sk);
> +	if (likely(!sk))
> +		goto done;
> +
> +	/* Batch size was still too small. Hold onto the lock while we try
> +	 * again with a larger batch to make sure the current bucket's size
> +	 * does not change in the meantime.
> +	 */
> +	err = bpf_iter_tcp_realloc_batch(iter, expected, GFP_NOWAIT);
> +	if (err) {
> +		bpf_iter_tcp_unlock_bucket(seq);
> +		return ERR_PTR(err);
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, since the code moves over
unchanged from tcp_ipv4.c. Still, can this path call vfree() while the
listening hash spinlock is held?

The first bpf_iter_tcp_realloc_batch() call uses GFP_USER with the
bucket lock dropped. A batch of more than 512 items is larger than
PAGE_SIZE. For that size, __kvmalloc_node_noprof() falls back to vmalloc
if the __GFP_NORETRY kmalloc attempt fails, so iter->batch can end up
vmalloc backed.

If more listeners join the bucket before it is locked again, the second
fill still doesn't fit. The GFP_NOWAIT realloc then runs with the lock
held:

bpf_iter_tcp_batch()
  bpf_iter_tcp_resume()
    listening_get_first()
      spin_lock(&ilb2->lock);
  bpf_iter_fill_batch()        /* still too small */
  bpf_iter_tcp_realloc_batch(iter, expected, GFP_NOWAIT)
    kvfree(iter->batch)
      vfree()

vfree() only hands off to vfree_atomic() when in_interrupt() is true:

mm/vmalloc.c:vfree() {
    ...
	if (unlikely(in_interrupt())) {
		vfree_atomic(addr);
		return;
	}

	BUG_ON(in_nmi());
	kmemleak_free(addr);
	might_sleep();
    ...
}

A plain spin_lock() does not make in_interrupt() true, so vfree() takes
the synchronous path with might_sleep() and the spinlock held. With
CONFIG_DEBUG_ATOMIC_SLEEP this gives a "sleeping function called from
invalid context" splat.

The established hash path uses spin_lock_bh(), so there vfree() defers
the free.

GFP_NOWAIT only applies to the new allocation. It does nothing for the
free of the old buffer. Could the old batch be freed after
bpf_iter_tcp_unlock_bucket() instead, or the free be deferred when the
lock is held?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
