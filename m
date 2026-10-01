Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2739BFED
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790820914; cv=none; b=VLIx25TnpPvW1+IFXiaKuTnvQlL7v86Qn5rj7y0cKTVbYfQwp1JDupc4hcHHSMEcmGhZshrsQqO5OlFxX5lqTAC0E5vXenW0qMXpCeaEmwIm3z5D7uq6xJKA6mo8O3+RxzaJr0RclfN9UJjLsM+y4Z/4o5C6ZKSuLnRuhhmEL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790820914; c=relaxed/simple;
	bh=PhZztQ19S6vmtaofoM4saSVb8k31FU6ssDRmQxQgd7c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dWacO/Celmiq+NqBqzqb6arttQ6DcgHbdhQEjjSrdF7DDrc4AfaAqbcdKuXggivGkxFbkQWUGJ3VvQhnnAJ9LjqrI5IKtN79PeMFwIVb9cUGRLXrSv4tzEeZe+2K/jMJOik3QvXBKkVJsy8qtI221ESPkhNgxejnoD5+D/jodnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9BZmyfK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9BZmyfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426BE1F00899;
	Thu,  1 Oct 2026 02:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790820911;
	bh=MSveZmH8aY++M81YxkdBNaRUYbGiTGF32vrjPMYYzrc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A9BZmyfKj7eWv10Y4L8pM16cf3WlJgepW9hs4rmaIElkzu9JxOuK8qb2MIWm9v4Pk
	 JIgjSWsEwqtzXUVLXucugvDBOBQf5hYVpKLDy8T5zdYKu9r0kSzfHBw6+DwEEOKVSZ
	 XTCsPZC0Kt6b2XW5PZFyUDRzbJwEBEX2m3cLhgfrL3lW3OlsN0T5dhTgr2QqBlbwgv
	 Pe6jU90m17ayYt7V3RgGqKScJLq3/jcxwK08W6Ea2Lil39R/Z9wqLmyfP8m1g2eHdu
	 4CMP0vETYHgJHpKp71ESQBMa0h29MRCwic+J4C8qMYx+kVCVLfAmg5z380bOX+1qDk
	 Rmaw+CPOuR6Pw==
Subject: Re: [PATCH v2 net-next 2/2] ipv6: Batch rt6_uncached_list_flush_dev()
 in netdev_run_todo().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 carges@cloudflare.com, kuni1840@gmail.com, netdev@vger.kernel.org
Date: Thu, 01 Oct 2026 02:15:10 +0000
Message-ID: <179082091084.434549.1540561487678718082@kernel.org>
In-Reply-To: <20260929201546.1533268-3-kuniyu@google.com>
References: <20260929201546.1533268-3-kuniyu@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Moving the IPv6 uncached-route flush into netdev_run_todo()
  removes the RCU grace period that used to follow the device-pointer…
- [Medium] Build failure with CONFIG_IPV6=n.
- [Medium] The batched flush reads dev->reg_state twice per route with no
  consistent snapshot, and another unregister batch can change reg_state…
- [Low] The new initialization guard `if (unlikely(!ul->head.next))
  return;` in rt6_uncached_list_flush_dev() (net/ipv6/route.c:172) is a…

--

ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().

This patch moves the IPv6 uncached route flush out of the per-device
NETDEV_UNREGISTER path. It now runs once per batched unregistration from
netdev_run_todo(), without RTNL. With dev == NULL, a route's device is
matched by reg_state == NETREG_UNREGISTERED.

Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9cedc17b5bdc2..0b3213ff56e70 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11838,8 +11838,10 @@ void netdev_run_todo(void)
>  		linkwatch_sync_dev(dev);
>  	}
>  
> -	if (!list_empty(&list))
> +	if (!list_empty(&list)) {
>  		rt_flush_dev(NULL);
> +		rt6_uncached_list_flush_dev(NULL);

[Severity: Medium]
With CONFIG_IPV6=n, is the new stub for rt6_uncached_list_flush_dev()
visible here?

net/core/dev.c doesn't include <net/ip6_route.h> directly. The only path
seems to be net/udp_tunnel.h -> net/ip_tunnels.h, and that include is
compiled out when IPv6 is off:

include/net/ip_tunnels.h:
#if IS_ENABLED(CONFIG_IPV6)
#include <net/ipv6.h>
#include <net/ip6_fib.h>
#include <net/ip6_route.h>
#endif

So when IPv6 is disabled, dev.c would see neither the prototype nor the
static inline stub added to include/net/ip6_route.h. Would this call then
fail with -Werror=implicit-function-declaration? It would also fail to
link, since net/ipv6/route.c isn't built.

rt_flush_dev() doesn't hit this, because net/route.h always reaches
dev.c through net/ip.h.

Should dev.c include <net/ip6_route.h> directly, or should the
declaration and stub go in a header that dev.c always includes?

> +	}
>  
>  	cnt = 0;
>  	while (!list_empty(&list)) {
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index a76869ff87cd6..38261775e7137 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -158,14 +158,20 @@ void rt6_uncached_list_del(struct rt6_info *rt)
>  	}
>  }
>  
> -static void rt6_uncached_list_flush_dev(struct net_device *dev)
> +void rt6_uncached_list_flush_dev(struct net_device *dev)
>  {
>  	int cpu;
>  
> +	if (dev && dev->dismantle)
> +		return;
> +
>  	for_each_possible_cpu(cpu) {
>  		struct uncached_list *ul = per_cpu_ptr(&rt6_uncached_list, cpu);
>  		struct rt6_info *rt, *safe;
>  
> +		if (unlikely(!ul->head.next))
> +			return;

[Severity: Low]
This isn't a functional bug, but ul->head.next is read here without
ul->lock. Other CPUs can update it concurrently under the lock:
list_add_tail() in rt6_uncached_list_add() when the list is empty, and
list_del_init() in rt6_uncached_list_del().

The list_empty() check just below already uses READ_ONCE(). Should this
be READ_ONCE(ul->head.next) so that KCSAN doesn't report it?

> +
>  		if (list_empty(&ul->head))
>  			continue;
>  
> @@ -175,19 +181,23 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
>  			struct net_device *rt_dev = rt->dst.dev;
>  			bool handled = false;
>  
> -			if (rt_idev && rt_idev->dev == dev) {
> +			if (rt_idev &&
> +			    (dev ? rt_idev->dev == dev :
> +			     READ_ONCE(rt_idev->dev->reg_state) == NETREG_UNREGISTERED)) {
>  				rt->rt6i_idev = in6_dev_get(blackhole_netdev);
>  				in6_dev_put(rt_idev);
>  				handled = true;
>  			}
>  
> -			if (rt_dev == dev) {
> -				rt->dst.dev = blackhole_netdev;
> +			if (dev ? rt_dev == dev :
> +			    READ_ONCE(rt_dev->reg_state) == NETREG_UNREGISTERED) {

[Severity: Medium]
If two netdev_run_todo() instances overlap, can these two reg_state reads
see different values for the same device?

netdev_run_todo() calls __rtnl_unlock() before it sets each device to
NETREG_UNREGISTERED, and that write is done under netdev_lock(), not
ul->lock. So batch A can be scanning while batch B updates a device D
that is on B's todo list. Take a route whose rt6i_idev->dev and dst.dev
are both D:

CPU1 (batch A, flush(NULL))          CPU2 (batch B, owns D)
READ_ONCE(rt_idev->dev->reg_state)
  sees NETREG_UNREGISTERING,
  rt6i_idev is not swapped
                                     WRITE_ONCE(D->reg_state,
                                                NETREG_UNREGISTERED)
READ_ONCE(rt_dev->reg_state)
  sees NETREG_UNREGISTERED,
  dst.dev swapped, handled = true
list_del_init(&rt->dst.rt_uncached)

By the time batch B's own flush runs, the route is off the list. Its
rt6i_idev still points at D's inet6_dev, which holds a reference on D.

The NETDEV_UNREGISTER rebroadcasts can't fix this either.
rt6_disable_ip()->rt6_uncached_list_flush_dev(dev) now returns early on
dev->dismantle, and the route is no longer listed.

Could batch B then sit in netdev_wait_allrefs_any() printing "waiting for
D to become free" for as long as something holds the uncached route? The
window is narrow, but the old code compared pointers under RTNL, so it
could not race this way.

> +				rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
>  				netdev_ref_replace(rt_dev, blackhole_netdev,
>  						   &rt->dst.dev_tracker,
>  						   GFP_ATOMIC);

[Severity: High]
Is there still an RCU grace period between this pointer swap and the
old device being freed?

Before this patch, the flush ran from the NETDEV_UNREGISTER notifier in
unregister_netdevice_many_notify(). That is followed by synchronize_net(),
and later by the rcu_barrier() at the top of netdev_run_todo().

Now the flush runs after that rcu_barrier():

netdev_run_todo()
    __rtnl_unlock();
    rcu_barrier();
    ...
    rt_flush_dev(NULL);
    rt6_uncached_list_flush_dev(NULL);
        rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
        netdev_ref_replace(rt_dev, ...);  /* drops ref on old dev */
    netdev_wait_allrefs_any(&list);       /* returns if refcnt == 1 */
    ...
    free_netdev() / kobject_put()
        -> netdev_release()
            kvfree(dev);

netdev_release() frees the device without waiting for readers:

	/* no need to wait for rcu grace period:
	 * device is dead and about to be freed.
	 */

ip6_output() is one reader of this pointer:

	rcu_read_lock();
	dev = dst_dev_rcu(dst);

It then passes dev on to NF_HOOK_COND(), ip6_finish_output() and
dev_queue_xmit(). Suppose a reader loads the old pointer after the
rcu_barrier() but before this swap. Can it still be using dev, and its
tx queues, after they are freed?

The in6_dev_put(rt_idev) branch above has the same problem.
in6_dev_finish_destroy() drops the netdev reference before its call_rcu().

The previous patch in this series, "ipv4: Batch rt_flush_dev() in
netdev_run_todo().", uses the same ordering for IPv4.

>  				handled = true;
>  			}
> +
>  			if (handled)
>  				list_del_init(&rt->dst.rt_uncached);
>  		}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929201546.1533268-1-kuniyu%40google.com
