Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956930;
	b=q7qzg+LbQY/9pVGNgJerw/vlGcizpwJJgy2IgsnP9FKQc1G5uzFdm1j8dsCrUcsyu2/7
	 ZrUy/dLQJ3MWccwrS2XdnHrgdflcXR5C/ng+tRVNztr4BwJhrO6bSJ3jFtMa9Eg/jibQm
	 SM7WbrQSqjnI2BtE5H4x8NubpEmdr9R9fvSrqrcv0vm0Zm7spQyVZVa/OUVXLJlCeBpeJ
	 hKG8mMEZGa7fI3OO1/jBb5rP0/awvyfSC9d1Cq6odPK+77OGfxyEfYpntgSUiF4gNKz6d
	 MbcJgEufW/KaZQaIbPD899MBo6VHXd9hPDcyquuv+TU3xuC6I7vF3Bhei01jQPNc/Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956930;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=H5CjfeVA3mUY0uSq+fsrIIyDJlP0gdm/blQLa1Hn9rU=;
	b=v3z+BAHbvmS7U4MYftSpYZWLOERyIW6N5TC1ySQghTazcYsTfBi5aRkFoo7HRVm7yM6O
	 p1itGX1XU6qvabC46z9W9Xv0qxjflkFqFwxcEoMUxLLqNMbVIMEN5Seu91eD8fb8iHAQs
	 uegfx/zKL4aVS8mNZdhm+5yYCPFLEwmlM6DyM9PpajRFXg2g7uc4D0spE2bHBL/ma4BPi
	 KU6Q4/pmNnMMMZT6TEzrafxJMLVcRoiEomVLCumMKlg0u3Cgn3TZ2Wgtf/RdZbWHRkIUr
	 Vq0HIMwWKvSbYUOSS1KvdjZJ+vdU+lTA7gCIUYk2lMVygtibj9ctE0FaWACLsQ09Mdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Su62/2aQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F0606D80F;
	Fri,  6 Nov 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Su62/2aQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDA81F008A1;
	Fri,  6 Nov 2026 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956929;
	bh=H5CjfeVA3mUY0uSq+fsrIIyDJlP0gdm/blQLa1Hn9rU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Su62/2aQBxnZrr1i6jyzyC3y4e2EW+C8De7AXEVlygdFkravRFfh6wpA/wnep96cO
	 Ll+A+wg2fDo0bD9ftuymAYxAKkUHOtKOn3XHhVeazCKX/tntrQpcSXib0q4vyqkK1Y
	 9arEoew/pfiZbzLlyjFnnhdEE6fCEXCKdnJNDZ7706h/m63w+ZrvmQeLQ0VLRbFhFB
	 aLCuR+J3o00AEBUf9tz8RLWZsfgXjBw/xiIahb1kDQ3QuqCDjv7dPw3JTp1deiEoU/
	 pDu07IESpwZ9CFUEQrJRic4d+phQtZd6D1UHL6cZjFgLY445fiGA1n4LWKHgniesWU
	 GP7bpwYSMA1Fg==
Subject: Re: [PATCH net] net: cancel napi->timer after the grace period in
 netif_napi_del()
From: netdev-bot+sashiko@kernel.org
To: mt4022@columbia.edu
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 mkarsten@uwaterloo.ca, joe@dama.to, dtatulea@nvidia.com, kuniyu@google.com,
 sdf.kernel@gmail.com, sridhar.samudrala@intel.com, cratiu@nvidia.com,
 tariqt@nvidia.com, wang.zhan@smartx.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tz2294@columbia.edu
Date: Fri, 06 Nov 2026 09:22:08 +0000
Message-ID: <179395692828.994134.14864803219795314130@kernel.org>
In-Reply-To: <20261103-napi-timer-cancel-v1-1-55c631ad5286@columbia.edu>
References: <20261103-napi-timer-cancel-v1-1-55c631ad5286@columbia.edu>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only adds the post-grace-period hrtimer_cancel() to the
  inline wrappers netif_napi_del() and netif_napi_del_locked()…
- [Medium] netdev_napi_exit() (net/core/dev.c:12453-12461) runs
  hrtimer_cancel(&p->timer) before __netif_napi_del_locked() and before…

--

net: cancel napi->timer after the grace period in netif_napi_del()

This patch adds a second hrtimer_cancel() of napi->timer after the
synchronize_net() in netif_napi_del() and netif_napi_del_locked(). It
targets a timer re-armed by napi_complete_done(), busy_poll_stop() or
napi_suspend_irqs() after napi_disable() has cancelled it. It also
cancels the timer in netdev_napi_exit(), relying on unregister having
already waited for a grace period.

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 435be7880d7e5..ad3685caf8147 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3013,8 +3013,13 @@ static inline void __netif_napi_del(struct napi_struct *napi)
>  
>  static inline void netif_napi_del_locked(struct napi_struct *napi)
>  {
> +	bool listed = test_bit(NAPI_STATE_LISTED, &napi->state);
> +
>  	__netif_napi_del_locked(napi);
>  	synchronize_net();
> +	/* napi->timer can be started until a grace period after napi_disable() */
> +	if (listed)
> +		hrtimer_cancel(&napi->timer);
>  }

[Severity: High]
Does this close the bug for callers that call __netif_napi_del() or
__netif_napi_del_locked() directly and then run their own grace period?
The new cancel only exists in the two inline wrappers. Those direct
callers can still free or re-initialise the napi while napi->timer is
queued.

The netdevsim driver used by the reproducer is one of them, in
nsim_del_napi():

drivers/net/netdevsim/netdev.c:nsim_del_napi() {
    ...
		napi_disable_locked(&rq->napi);
		__netif_napi_del_locked(&rq->napi);
	}
	synchronize_net();
    ...
}

Nothing cancels the timer after that synchronize_net(). Later,
nsim_queue_free() only cancels rq->napi_timer before kfree(rq). On
reopen, netif_napi_add_config_locked()->hrtimer_setup() runs on a timer
that may still be queued.

The same pattern shows up in veth_napi_del_range() and in
virtnet_free_queues(), which is followed by kfree(vi->rq). It also shows
up in bnxt, enic, bnx2x, myri10ge, dpaa and bnge.

Two callers have no synchronous point after the grace period at all:

net/core/gro_cells.c:gro_cells_destroy() {
    ...
		napi_disable(&cell->napi);
		__netif_napi_del(&cell->napi);
		__skb_queue_purge(&cell->napi_skbs);
	}
    ...
		call_rcu(&defer->rcu, percpu_free_defer_callback);
    ...
}

ixgbe_free_q_vector() is similar: __netif_napi_del() followed by
kfree_rcu(q_vector, rcu). The note below the --- line suggests sending
the same cancel separately, but there is nowhere to put it in these two
paths. Would they need a different approach?

All of these paths share the window described in the commit message.
napi_complete_done() clears SCHED in its try_cmpxchg() before it calls
hrtimer_start(). busy_poll_stop() calls clear_bit(NAPI_STATE_SCHED)
before hrtimer_start(). napi_suspend_irqs() re-arms a napi it found
only through napi_by_id() under RCU.

The kernel-doc for __netif_napi_del() also still says:

 * Warning: caller must observe RCU grace period before freeing memory
 * containing @napi. Drivers might want to call this helper to combine
 * all the needed RCU grace periods into a single one.

That contradicts the new comment above, and the driver comments in
virtio_net, ixgbe and bnxt repeat it. Should the documented contract be
updated as well?

The remaining gap is only described below the --- line, so it won't be
in git history. That note also leaves out ixgbe, enic, bnx2x, myri10ge,
dpaa and bnge.

[ ... ]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f32353b0467cd..6d6384522a1bb 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12450,9 +12450,12 @@ static void netdev_napi_exit(struct net_device *dev)
>  	if (!list_empty(&dev->napi_list)) {
>  		struct napi_struct *p, *n;
>  
> +		/* unregister has waited for a grace period after napi_disable() */
>  		netdev_lock(dev);
> -		list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
> +		list_for_each_entry_safe(p, n, &dev->napi_list, dev_list) {
> +			hrtimer_cancel(&p->timer);
>  			__netif_napi_del_locked(p);
> +		}
>  		netdev_unlock(dev);
>  
>  		synchronize_net();

[Severity: Medium]
Does the premise in this comment hold for every device that reaches
free_netdev()? Here the cancel runs before this function's own
synchronize_net(). That is the reverse of the order used in
netif_napi_del_locked().

unregister_netdevice_many_notify() calls synchronize_net() after close
and after ndo_uninit, so napis disabled in ndo_stop or ndo_uninit are
covered. However, free_netdev() also calls netdev_napi_exit() for
devices that were never unregistered. These include
NETREG_UNINITIALIZED probe-failure unwinds and NETREG_DUMMY devices
from alloc_netdev_dummy().

For example, mal_remove() in drivers/net/ethernet/ibm/emac/mal.c does:

		napi_disable(&mal->napi);
	...
	free_netdev(mal->dummy_dev);

There is no grace period in between. A registered device has the same
gap if its driver calls napi_disable() in the remove path after
unregister_netdev() and leaves the napi listed for free_netdev() to
delete.

On those paths, an in-flight start can arm the timer after this early
cancel:

  napi_complete_done() between its try_cmpxchg() and hrtimer_start()
  busy_poll_stop() between clear_bit() and hrtimer_start()
  a napi_suspend_irqs() reader

The synchronize_net() below then only waits for that start to finish,
and the napi is freed with its timer queued.

In practice, the timeouts default to 0 on unregistered and dummy
devices, and netlink napi-set requires NETREG_REGISTERED. The realistic
trigger is a registered device with gro_flush_timeout, defer_hard_irqs
or irq_suspend_timeout set. I couldn't find an in-tree driver that hits
this today.

Could netdev_napi_exit() do the grace period itself, for example a
synchronize_net() before the loop, instead of relying on the caller?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103-napi-timer-cancel-v1-1-55c631ad5286%40columbia.edu
