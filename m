Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58492773F7
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790820914; cv=none; b=PdLFW/yN91Vc2QHEbcltCbCy1SO1gYz98eauIV0eMp0XwmKk2yMfMLoCSQYVoqqFNaEElMVnROEBbDSWDsr0N8MAWVP3qEMzayn0rNcbMNEkncmTFT51IZhF6XWBSiuSKsES5pwPzISF7iVPj8fWPT6/LVCF+xr487od9WgzRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790820914; c=relaxed/simple;
	bh=YxF6KjFkdG1/FHMuJnLAYA/zWBsFBcPPhuADX6EiVRM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hxskxpir0wj5Jh1zl6Nl6ZgCFWMKk61ntOWczkrsd1LT5/+VYUfYpIkhnQT9aNu8oTZ2Z27g7H8UQkGCGqjqqPmihTuzU4CEw0WgQ3+KXgNJQVQJjpQEq3GxiNFEj4k9JBwlkI3IVt7Sgp9jXZW2e1bAgJgjj6yMIFBq1HYJBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cunNmf5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cunNmf5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081DA1F000FF;
	Thu,  1 Oct 2026 02:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790820910;
	bh=YJRpmmBJHqRHmbrm9EgJ4cjOlJbXLze3+zfjhjNpi/I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cunNmf5TfrmOFfgp3m0XieEWFVfZSevZRy82I523FDTMrky821ZUDrKs8C+LoUMXC
	 9hmvI1Hwek+yl5dXxuC4+xyF+V0isBE2NJk+xTpAESnAUcXKUNEf8xJ+B+QX9RVtCL
	 zNzmekDHVVsTP9eSf258IunRgt7hYufwAf7Aw7Rys/L0ZuEIOtm4ZSEBBk+ufrnG1E
	 uc30kqQ2DoUWjreTvNRVonPDoc/0ahvZguOQ9w8MdoP4LaK0ClAclagGwttzBD6tzE
	 QOjcjs4oCQnvwrwOFU3I2TFRb7RmY2WGbCGISV/lts0eUG4eUe3gQbC0DLZDP/rifJ
	 4srQpx9ZzFHvw==
Subject:
 Re: [PATCH v2 net-next 1/2] ipv4: Batch rt_flush_dev() in netdev_run_todo().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 carges@cloudflare.com, kuni1840@gmail.com, netdev@vger.kernel.org
Date: Thu, 01 Oct 2026 02:15:09 +0000
Message-ID: <179082090950.434549.10665389618210861393@kernel.org>
In-Reply-To: <20260929201546.1533268-2-kuniyu@google.com>
References: <20260929201546.1533268-2-kuniyu@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Retrying the NETDEV_UNREGISTER broadcast no longer flushes IPv4
  uncached routes.
- [High] Moving the IPv4 uncached-route device swap from the
  NETDEV_UNREGISTER notifier into `netdev_run_todo()` removes the RCU…
- [High] ipv4: NULL pointer dereference in rt_flush_dev() with
  uninitialized list

--

ipv4: Batch rt_flush_dev() in netdev_run_todo().

This commit takes the IPv4 uncached route flush out of the per-device
NETDEV_UNREGISTER path. It now calls rt_flush_dev(NULL) once per batched
unregistration in netdev_run_todo(), without holding RTNL. rt_flush_dev()
returns early for dismantling devices. When passed NULL, it moves every
route whose device is NETREG_UNREGISTERED over to blackhole_netdev.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index a8eb382f40caf..9cedc17b5bdc2 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11838,6 +11838,9 @@ void netdev_run_todo(void)
>  		linkwatch_sync_dev(dev);
>  	}
>  
> +	if (!list_empty(&list))
> +		rt_flush_dev(NULL);
> +
>  	cnt = 0;
>  	while (!list_empty(&list)) {
>  		dev = netdev_wait_allrefs_any(&list);
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index d7da2f1acbb59..1b641901f10dc 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1587,6 +1587,9 @@ void rt_flush_dev(struct net_device *dev)
>  	struct rtable *rt, *safe;
>  	int cpu;
>  
> +	if (dev && dev->dismantle)
> +		return;
> +

[Severity: High]
Can this call reach rt_flush_dev() before ip_rt_init() has set up
rt_uncached_list?

The per-cpu rt_uncached_list entries are only initialised in
ip_rt_init(), which does INIT_LIST_HEAD() and spin_lock_init() for
each possible CPU. That runs from inet_init(), an fs_initcall. Until
then ul->head.next is still NULL.

Before this patch, rt_flush_dev() was only reached through
fib_netdev_event(). That notifier is registered from ip_fib_init(),
which ip_rt_init() calls after it initialises the lists, so the
ordering was implicitly safe.

netdev_run_todo() has no such dependency. It runs from rtnl_unlock()
whenever net_todo_list is non-empty. Any netdev unregistration before
fs_initcall time would now call rt_flush_dev(NULL) on zeroed lists.
One example is an earlier initcall that registers a device and then
unregisters it on a later failure.

In that case list_empty(&ul->head) returns false, because head->next
is NULL rather than &ul->head. The loop then takes the uninitialised
ul->lock and enters list_for_each_entry_safe(). That derives pos from
the NULL head->next and immediately loads pos->dst.rt_uncached.next,
which is address 0. The result is a NULL pointer dereference during
boot.

The IPv6 patch later in the series seems to handle the same case in
rt6_uncached_list_flush_dev() by skipping a list whose head.next is
still NULL. Should rt_flush_dev() get a similar guard? Or should
netdev_run_todo() skip the call until IPv4 routing is initialised?

[Severity: High]
With this early return, does the NETDEV_UNREGISTER that
netdev_wait_allrefs_any() resends still flush any IPv4 uncached routes?

netdev_wait_allrefs_any() resends NETDEV_UNREGISTER about once a second so
protocols can drop late references. That reaches
fib_netdev_event()->rt_flush_dev(dev). dev->dismantle is already set, so
the first notifier call and every retry now return straight away.

The only flush left for a dying device is the single rt_flush_dev(NULL) in
netdev_run_todo(). It runs once, before the wait loop, and no grace period
follows it.

Can an uncached route with the dying device be added after that pass? One
possible path goes through xfrm_bundle_create():

xfrm_bundle_create()
    rcu_read_lock();
    dev = dst_dev_rcu(dst);
    ...
    xfrm_fill_dst(xdst_prev, dev, fl)
        xfrm4_fill_dst()
            netdev_hold(dev, &xdst->u.dst.dev_tracker, GFP_ATOMIC);
            ...
            rt_add_uncached_list(&xdst->u.rt);

Say the sweep moves dst_orig to blackhole_netdev after dev is read but
before the new xdst is linked. The xdst then goes onto rt_uncached_list
after the sweep has already passed that CPU's list, and it still holds a
reference on the dying device.

Before this patch, synchronize_net() in unregister_netdevice_many_notify()
ran after the notifier flush, and each retry ran rt_flush_dev(dev) again.
Nothing now seems to come back to such an entry.

Could unregister_netdevice then loop on "waiting for %s to become free" for
as long as the xdst lives? For a bundle cached on an idle connected socket,
that could be forever.

>  	for_each_possible_cpu(cpu) {
>  		struct uncached_list *ul = &per_cpu(rt_uncached_list, cpu);
>  
> @@ -1595,10 +1598,14 @@ void rt_flush_dev(struct net_device *dev)
>  
>  		spin_lock_bh(&ul->lock);
>  		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
> -			if (rt->dst.dev != dev)
> +			struct net_device *rt_dev = rt->dst.dev;
> +
> +			if (dev ? rt_dev != dev :
> +			    READ_ONCE(rt_dev->reg_state) != NETREG_UNREGISTERED)
>  				continue;
> +
>  			rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
> -			netdev_ref_replace(dev, blackhole_netdev,
> +			netdev_ref_replace(rt_dev, blackhole_netdev,
>  					   &rt->dst.dev_tracker, GFP_ATOMIC);

[Severity: High]
Does moving the swap here remove the RCU grace period between publishing
blackhole_netdev and freeing the old net_device?

Before, rt_flush_dev(dev) ran from the NETDEV_UNREGISTER notifier. Then
unregister_netdevice_many_notify() called synchronize_net(), so any reader
that had loaded the old rt->dst.dev was done before teardown.

The swap now runs after every synchronize_net(), and also after the
rcu_barrier() in netdev_run_todo(). If netdev_ref_replace() drops the last
extra reference, netdev_wait_allrefs_any() returns right away:

	list_for_each_entry(dev, list, todo_list)
		if (netdev_refcnt_read(dev) == 1)
			return dev;

netdev_run_todo() then goes on to free_netdev() and kobject_put(), and
netdev_release() frees the device directly:

	/* no need to wait for rcu grace period:
	 * device is dead and about to be freed.
	 */
	kfree(rcu_access_pointer(dev->ifalias));
	kvfree(dev);

Could an RCU reader that loaded the old device still be using it at that
point? One example is rt_is_expired():

	rcu_read_lock();
	res = rth->rt_genid != rt_genid_ipv4(dev_net_rcu(rth->dst.dev));
	rcu_read_unlock();

Another is xfrm_bundle_create(). It reads dst_dev_rcu(dst) and then calls
xfrm4_fill_dst()->netdev_hold(dev), which would write to the refcount of a
freed device.

The ul->lock spinlock only serializes list writers, not these readers. The
IPv6 patch that follows in the series uses the same pattern
(rt6_uncached_list_flush_dev(NULL) in netdev_run_todo()), so the problem
remains at the end of the series.

Does this need a synchronize_net() after the batched flush?

>  			list_del_init(&rt->dst.rt_uncached);
>  		}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929201546.1533268-1-kuniyu%40google.com
