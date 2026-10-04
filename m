Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7923FA5FA
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791154945; cv=none; b=BCkYvhYpa9Yp8y+ZJKb0+ohElFH0kVbvyaDiOk4X/QL8WND9+c28t4ex9NqBOqELuG/wBDHQvkOyNMIidphv12DIzP+WRU0qlhpX3/OiOTmjHvYiuCTHZ+oqZSYE4XWu9cg2ryyDjBSFskXLJk8P/r+IsxedQBootaGQSS1MOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791154945; c=relaxed/simple;
	bh=LZ+FqyNC3O6mtQ30MMKLRse3Ec+vVoF6V/gc/KOpqyc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cN8LumSqXCSv6BxHzD+g9IfskK9wyzjgS/Z5co2JS/kYXF2Eb2tn/s0GQWcqGIDDBZGZLHNJbmZ3cES7DfKyPYVU02cHuf1pGFQJVbWZFaXBDOAk4MzaUPIdBSlf7iJs7JjGip2f1A+Kc9Vs5wI5LTOroMgIiglCYKXvVVCywiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvwUxXyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvwUxXyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD1D1F00898;
	Sun,  4 Oct 2026 23:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791154943;
	bh=j6Us5E1zgu2M4T+QZYn5kY9rJl8tOSaM/k5SKdjLtW4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZvwUxXyQr9l2MQHM2dHZ6UtZbHqhdk+tXqX/GebNTuuSeyRXLFdOE2SEjjmXlP4uc
	 ssij248W/5iGeF3xI0jBMDW83WWtsyR0GBoYbCi1j+hGCqco9boSBIeqtEt119h7V7
	 YK8EOOzLYAnBqAuLYBdTFt9QDRXT+cSf/E2yJSGj5Z2ABlM9Q7sB44GroAVquDZY+5
	 szlgoz1WB2C79rgvDyG9I2RVj+2b9+nPvPbCUkNV9kl1fEYdiB0RUkbrO+kjw10eAK
	 1sTtuV1TQnqYxMPkO4U6kNBf0EelWrAul0UHPimmgZqe2jb7nmwZWdR6E0SPsQbgWZ
	 Q9myfVbHQ0GVQ==
Subject:
 Re: [PATCH v3 net-next 5/6] ipv4: Batch rt_flush_dev() in netdev_run_todo().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, carges@cloudflare.com, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Sun, 04 Oct 2026 23:02:22 +0000
Message-ID: <179115494261.434549.1774667236869169411@kernel.org>
In-Reply-To: <20261001204752.2572265-6-kuniyu@google.com>
References: <20261001204752.2572265-6-kuniyu@google.com>
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

- [High] Missing RCU grace period between the device-pointer swap in
  rt_flush_dev(NULL) and freeing the net_device.

--

ipv4: Batch rt_flush_dev() in netdev_run_todo().

This patch takes the IPv4 uncached route flush out of the per-device
unregister path. netdev_run_todo() now calls rt_flush_dev(NULL) once per
batch, without RTNL. With a NULL dev, rt_flush_dev() moves every uncached
route whose device has reached NETREG_UNREGISTERED over to
blackhole_netdev.

Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0f87fd8c68923..4658e4e16d9dd 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -11871,6 +11872,9 @@ void netdev_run_todo(void)
>  		linkwatch_sync_dev(dev);
>  	}
>  
> +	if (!list_empty(&list))
> +		rt_flush_dev(NULL);
> +

[Severity: High]

Is there still an RCU grace period between the rt->dst.dev swap and
freeing the old net_device?

Before this patch, fib_netdev_event()->rt_flush_dev(dev) did the swap
during NETDEV_UNREGISTER. That was before the second synchronize_net() in
unregister_netdevice_many_notify(), and before the rcu_barrier() at the
top of netdev_run_todo(). So any RCU reader that had already loaded the
old rt->dst.dev was done before the device could be freed.

With this patch, the swap and the reference drop both happen after those
calls:

net/ipv4/route.c:rt_flush_dev() {
    ...
	rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
	netdev_ref_replace(rt_dev, blackhole_netdev,
			   &rt->dst.dev_tracker, GFP_ATOMIC);
    ...
}

If that drops the last extra reference, netdev_wait_allrefs_any() returns
from its first check, before any rcu_barrier() or msleep():

	list_for_each_entry(dev, list, todo_list)
		if (netdev_refcnt_read(dev) == 1)
			return dev;

netdev_run_todo() then goes straight on to priv_destructor, free_netdev()
and kobject_put(). Some drivers instead call free_netdev() right after
unregister_netdev() returns. Either way, netdev_release() frees the
device without waiting:

	/* no need to wait for rcu grace period:
	 * device is dead and about to be freed.
	 */
	kfree(rcu_access_pointer(dev->ifalias));
	kvfree(dev);

The only synchronize_net() left on this path is in netdev_napi_exit(). It
runs only when dev->napi_list is not empty, so most virtual devices skip
it.

Meanwhile, a sender whose socket has an uncached IPv4 route to this device
in sk_dst_cache can be in sk_dst_check()->ipv4_dst_check()->rt_is_expired():

	rcu_read_lock();
	res = rth->rt_genid != rt_genid_ipv4(dev_net_rcu(rth->dst.dev));
	rcu_read_unlock();

rt_flush_dev() does not mark the dst obsolete, so this check still runs.
If the reader loads the old rth->dst.dev and is then preempted (under
PREEMPT_RCU) or delayed while unregistration finishes, can it read
dev->nd_net from freed memory? Other readers that use dst_dev_rcu() rely
on RCU to keep the device alive in the same way.

Deleting the device needs only CAP_NET_ADMIN in a user namespace's netns
(for example "ip link del"), so an unprivileged user with userns can
reach this path.

The later patch "ipv6: Batch rt6_uncached_list_flush_dev() in
netdev_run_todo()" seems to follow the same pattern for IPv6. At the end
of the series, netdev_run_todo() still calls rt_flush_dev(NULL) and
rt6_uncached_list_flush_dev(NULL) and goes directly into the free loop.

Would a synchronize_net() after the flush calls in netdev_run_todo() be
needed here, or is there something else that guarantees a grace period
before the device is freed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001204752.2572265-1-kuniyu%40google.com
