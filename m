Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2CB3ADBA2
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979050; cv=none; b=Rhllo0UPfpUQgm1SPt+iZ/RvcGBYzmQdDqlu8JYwL49wIAl1ikpXtYaCVE++AFuWhgv8AM4nmwEgDsfmpnAP3gYva2kWgbQbBkCobr+JI5ii+2J1EiZwZP0gx1dOEUxo2h0msBjw5jCA8mot33gLsl9ysAAKJCOrrADn1MrINDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979050; c=relaxed/simple;
	bh=lu0pvlwKo1sRiNxVXTsPBO/2O0SafyYrVsFNPBs1jOo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BdbT/HwQQmNplGQvz9I1KPZ2f8SJrjXIcNSPR5zLoC6iGzkVYP2UM4r/sUxCEcj9CFnUtzGq6ZuwfWy10MfiPNwnQ4kS+WIpgxkNszW9qT3/kLVh/0+1UgSKLUMpyMzeLHrldsYxhdCRA9j//n91qZDkmrtmmWdq28iP9TU3M/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDFQKV+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDFQKV+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0611F000FF;
	Mon, 21 Sep 2026 08:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979048;
	bh=2SLFBoiphKCNDN9Gz5JsFZ5RyD/fI6pXih/XF1L1OwE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HDFQKV+UJhsr6xer/ipBKz187RlnuD5E/eh3mzaaP0mTVYveV7S0zTTKwpHFrzo4o
	 ozKL40GlJYV/VDFp3BzKaKov2YQRehWMwelObt/F00lXOUvYE4xNVBpzCN/sqKh/SX
	 jabhJQkGsuOTG1tLJhR/a3vtiPAjgBwyELxZiyQNaK2hzgYGoSavOmVYm+QbGdkHyr
	 odBR6MaTQffuTVKTMxVc6eWfUF+KcAidJX+oC47KSAakofMvLmv+X8Z6po3SN2RqZ5
	 dP5sFOVwH9g7tDMSbHaXhoSfeXRhS+7Lg1DVgo6Mpu0O8ML36MpDnZs1nc8uf7EvQ5
	 ZwLMsq2RvJ0zQ==
Subject:
 Re: [PATCH v1 net] ipv6: Prevent rt6_insert_exception() for dying fib6_info.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 marcharvey@google.com, kuni1840@gmail.com, netdev@vger.kernel.org
Date: Mon, 21 Sep 2026 08:24:07 +0000
Message-ID: <178997904775.2160803.15157410527748919821@kernel.org>
In-Reply-To: <20260918082209.2853582-1-kuniyu@google.com>
References: <20260918082209.2853582-1-kuniyu@google.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new guard in rt6_insert_exception()
  (net/ipv6/route.c:1732) trusts f6i->fib6_destroying, but that bit is…

--

ipv6: Prevent rt6_insert_exception() for dying fib6_info.

This reorders fib6_purge_rt() so that fib6_drop_pcpu_from() runs before
rt6_flush_exceptions(), and adds a f6i->fib6_destroying check in
rt6_insert_exception() so a dying fib6_info can no longer gain a new
exception route.  The goal is to stop the fib6_info<->exception reference
cycle that stalls netdev unregistration.

> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 9ea75703b38d..9ff761962b45 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1043,8 +1043,8 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
>  	struct fib6_table *table = rt->fib6_table;
>  
>  	/* Flush all cached dst in exception table */
> -	rt6_flush_exceptions(rt);
>  	fib6_drop_pcpu_from(rt);
> +	rt6_flush_exceptions(rt);
>  
>  	if (rt->nh) {
>  		spin_lock(&rt->nh->lock);
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 08bd68f1b5bb..884d9ab0d50d 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1729,6 +1729,11 @@ static int rt6_insert_exception(struct rt6_info *nrt,
>  
>  	spin_lock_bh(&rt6_exception_lock);
>  
> +	if (f6i->fib6_destroying) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +

[Severity: Medium]
Can this check observe fib6_destroying == 0 after fib6_purge_rt() has
already set it?

fib6_destroying shares one u8 storage unit with three other bits in
struct fib6_info:

include/net/ip6_fib.h:
	u8				should_flush:1,
					dst_nocount:1,
					dst_nopolicy:1,
					fib6_destroying:1,
					unused:4;

Adjacent bitfields are a single memory location, so every assignment to
any of them is a non-atomic read-modify-write of the whole byte.

The setter in fib6_drop_pcpu_from() runs with only the table's tb6_lock
held:

net/ipv6/ip6_fib.c:fib6_drop_pcpu_from() {
	f6i->fib6_destroying = 1;
	mb(); /* paired with the cmpxchg() in rt6_make_pcpu_route() */
	...
}

One peer writer of the same byte is addrconf_disable_policy_idev(), which
holds only rtnl_net_lock plus idev->lock and ifa->lock:

net/ipv6/addrconf.c:addrconf_disable_policy_idev() {
	...
			rcu_read_lock();
			ifa->rt->dst_nopolicy = val ? true : false;
	...
}

Is there any lock common to both paths?  inet6_rtm_delroute() is
registered with RTNL_FLAG_DOIT_UNLOCKED, and
ip6_route_del()->__ip6_del_rt()->fib6_del()->fib6_purge_rt() takes only
rcu_read_lock() and tb6_lock, so a write to
net.ipv6.conf.<dev>.disable_policy on a host route (ifa->rt) does not
appear to be serialized against the deletion path.

If the disable_policy writer loaded the byte before fib6_destroying was
set and stores its copy back afterwards, the bit is cleared again.  A
third thread in ip6_rt_update_pmtu() or rt6_do_redirect() that still
holds the pre-removal fib6_info would then read fib6_destroying == 0 here
and insert an exception after the final rt6_flush_exceptions(), which
recreates the fib6_info<->exception cycle and the

	unregister_netdevice: waiting for gre6 to become free

stall described in the commit message.  The same lost update also lets
rt6_make_pcpu_route() re-add per-CPU routes after
__fib6_drop_pcpu_from() has run.

Note the load here is a plain bitfield read with no READ_ONCE(), and the
store side is a plain RMW, so this is also visible to KCSAN as a data
race.  rt6_multipath_flush() writes should_flush under tb6_lock, so
dst_nopolicy looks like the one unsynchronized peer.

Would it make sense to give this flag its own storage accessed with
WRITE_ONCE()/READ_ONCE() (or to serialize all writers of the containing
byte), and to document which lock protects it?

The comment above the store in fib6_drop_pcpu_from() still mentions only
rt6_make_pcpu_route() and the cmpxchg() as the counterpart; could it also
mention the new rt6_exception_lock reader added here?

>  	bucket = rcu_dereference_protected(nh->rt6i_exception_bucket,
>  					  lockdep_is_held(&rt6_exception_lock));
>  	if (!bucket) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918082209.2853582-1-kuniyu%40google.com
