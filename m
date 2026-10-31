Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793459402;
	b=XGil1yqZwCcIOyY5Gbyeq7GUZKrMsmTG9VzNjke2Pp/Sk7353i8mCOzvfvQBIop/1nYd
	 2Vc28Me9LVmisiJ5WF17bq0BY/fKa7XT0lQ17cwKqhYqghV/4cWGWnqZ11NyLdGPy24sd
	 56s3GqpYCd0gM5Bv7LK+IqYU62vf9lcGGhNuJUA7GYdediFlI+j6wF7kVMJ7LuRzXS7q2
	 TJ8S0JXxB6ehpk97fmEepX5VNZioP5pF/6mHGG0EHYABb7wIHVejTsujxK7WvPbPuunTX
	 ReK01/u8uO0l3sBp/oXAMronGbaLjtg6SuNYjK/iKclu1BBCt2wJGJplaFsV3glWWiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459402;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tUdEIw+Gn+fWQ0tHnZvYlvV9bBy5X27vM3HRMicDgjc=;
	b=jO/xwDToHexuTLHtoZ2gk7FD0qO5IHhhQ/i42tJvpFrkATqHfIQLE2emfPWf4JI6ef1O
	 4DSp8bsR88kLTJxDJpFIBMw39koW2dGIE3HCIEYe4BqrEwsK75+l5ACyIbZ91MYEzuh+L
	 gMVn4HqZ9ozDkvjQMPlpOmLlJkQLS6XE5w03xg/NhieZbzg4+KMVhP5ZPie3pdjjqRIai
	 pM+c2jsHaCPwJJWHIVp6qYelvnF2A4JmAUJHidJfn2+vyk+K8WuJjOC2Nk/Jn7uqFETwN
	 gBOzOMkOOFcoz6oJ65VPr87EH992DJod0j+aWbc3u94Wa8NbUlkcMD5Vq3R8KTKowYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9OcB0dc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E300606A31A;
	Sat, 31 Oct 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9OcB0dc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B591F000C1;
	Sat, 31 Oct 2026 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459402;
	bh=tUdEIw+Gn+fWQ0tHnZvYlvV9bBy5X27vM3HRMicDgjc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D9OcB0dcZJ+FlSj7BG1D0EUKb4/fBWom7iWuezRYJYHq+vgG09+o1guJ+AXAQpmSy
	 8+cFwPo2aaR5vu8L4/MPrBm4G7caFRsZe3vmZX9Am0hx2U9Z8GJ+PTXoXELc10uBm9
	 c5NgrGdoMtsjdKDVScpcNVpsq5OIYBpsIbuillPkWlqb+P2JSanitm8klgZ/9qRBq0
	 67FpgdGSGYjVjDRykrr1EwdNCvpWcJV1DMj9OsuzJL+YlYm7+7hMo+eAQ+NFAgqJ0m
	 hrxfEN/xqjYb2RfU3RCvMpklf/GRp8Pdl8gzs7r0xrPXuv2DsC/7FzQgerw17Fr/0r
	 Kj5WagX3j8hmQ==
Subject: Re: [PATCH net v2] net: fix self-deadlock when an upper disables a
 feature of its lower
From: netdev-bot+sashiko@kernel.org
To: eva.kurchatova@virtuozzo.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sd@queasysnail.net, cratiu@nvidia.com,
 sdf@fomichev.me, linux-kernel@vger.kernel.org,
 syzbot+c6c86a1c56b5131f2d97@syzkaller.appspotmail.com, netdev@vger.kernel.org
Date: Sat, 31 Oct 2026 15:10:01 +0000
Message-ID: <179345940111.3131.17680940160354830709@kernel.org>
In-Reply-To: <20261027140121.1192299-1-eva.kurchatova@virtuozzo.com>
References: <20261027140121.1192299-1-eva.kurchatova@virtuozzo.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] When the trylock fails, the patch moves the 'disable features
  the uppers lack' job into netdev_work, but that worker never holds…

--

net: fix self-deadlock when an upper disables a feature of its lower

This patch fixes a self-deadlock in netdev_sync_lower_features() when the
caller already holds the lower device's instance lock. It now tries to take
the lock with a trylock, and on failure defers the work to netdev_work as
NETDEV_WORK_SYNC_UPPERS. netdev_features_change() steals that work and runs
it inline, and in other cases the worker runs it asynchronously.

Closes: https://lore.kernel.org/all/6a6be82b.77639fcc.3d4fd0.0014.GAE@google.com/

> diff --git a/net/core/netdev_work.c b/net/core/netdev_work.c
> index 1b11bcbeb196e..3859ca9087584 100644
> --- a/net/core/netdev_work.c
> +++ b/net/core/netdev_work.c
> @@ -117,6 +117,10 @@ __netdev_work_core_cancel(struct net_device *dev, unsigned long mask)
>  static void netdev_work_run(struct net_device *dev, unsigned long events,
>  			    unsigned long core)
>  {
> +	/* Not gated on presence: the caller used to wait only for the lock */
> +	if (core & NETDEV_WORK_SYNC_UPPERS)
> +		netif_sync_upper_disables(dev);
> +

[Severity: High]
Does the worker run netif_sync_upper_disables() without RTNL?

netdev_sync_lower_features() only queues NETDEV_WORK_SYNC_UPPERS when
netdev_need_ops_lock(lower) is true. For those devices, netdev_work_proc()
takes only the instance lock:

netdev_work_proc()
    netdev_lock_ops_compat(dev);
    ...
    netdev_work_run(dev, events, core);

include/net/netdev_lock.h:netdev_lock_ops_compat() {
	if (netdev_need_ops_lock(dev))
		netdev_lock(dev);
	else
		rtnl_lock();
}

With only dev->lock held, netif_sync_upper_disables() then does three
things.

First, it walks dev->adj_list.upper with netdev_for_each_upper_dev_rcu()
while holding neither rcu_read_lock() nor RTNL. That should trigger the
lockdep WARN_ON_ONCE() in netdev_upper_get_next_dev_rcu(). A concurrent
RTNL-only __netdev_upper_dev_unlink(), for example from macvlan_dellink(),
can also list_del_rcu() and kfree_rcu() the netdev_adjacent entry while this
preemptible worker is walking it. Could that lead to a use-after-free of
the adjacency entry or of the upper device?

Second, it calls __netdev_update_features(dev), which starts with
ASSERT_RTNL().

Third, it calls netdev_features_change(dev), which reaches
call_netdevice_notifiers_info(). That function has ASSERT_RTNL() and walks
the raw notifier chains, which RTNL protects. Handlers such as
macvlan_device_event() would then call netdev_update_features() on uppers
that are not ops-locked, without RTNL. This also contradicts the new
kernel-doc for netdev_features_change(), which says the caller must hold
RTNL.

The commit message says the work "only runs asynchronously if an unrelated
task held the lock". Several contexts hold the lower's instance lock
without RTNL. One is netdev_work_proc() itself, running rx_mode or
ndo_work for the lower. Another is the netdev-genl ops that take only the
instance lock.

For example, the worker could be running NETDEV_WORK_RX_MODE for an
ops-locked lower while an RTNL holder runs TUNSETOFFLOAD on a macvtap on
top of it. The trylock in netdev_sync_lower_features() then fails and
SYNC_UPPERS is queued on the lower:

netdev_sync_lower_features()
    if (netdev_need_ops_lock(lower) && !netdev_trylock(lower)) {
        __netdev_work_core_sched(lower, NETDEV_WORK_SYNC_UPPERS);
        continue;
    }

The later netdev_features_change(upper) only cancels work pending on the
upper, so nothing steals the lower's job. The worker then runs it while
holding only lower->lock. Before this patch, this caller blocked on the
lock and kept RTNL for the whole operation.

Taking rtnl_lock() inside the worker after the instance lock would invert
the rtnl -> instance lock order. Would this event need to be handled
differently? One option is to take rtnl_lock() before the instance lock
for SYNC_UPPERS. Another is to reschedule the work when rtnl_trylock()
fails.

>  	if (!netif_device_present(dev))
>  		return;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027140121.1192299-1-eva.kurchatova%40virtuozzo.com
