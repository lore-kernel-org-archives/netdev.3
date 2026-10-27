Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062003;
	b=qTMmjVbUhCowYo4Fr1zYUAqST7Gk4aB88vRDPOb4fPbU6OY5ih2En1tT8CB+pJClZGN3
	 zsEsjeeBI61bLfkh4VgD6cLWRHWTh+WCgDxyNKxPc8RVmIkD1GoFBCE7hObQSDPQ1LH6G
	 T9DtnJzBPY29H/sSCj02E/c2bGJs4fbnfleEGAbjiUZdNLq6Ee3dCeejL1f4aEIwO4gBT
	 EiDOokjh2HaUpuEWm/hwqLRKnQfza5SmBdd8EMW9J9g473ZGRKvD821vI+DMtcKso0EkG
	 WwQBGGxrWbIe+lhsTgPqtX8ig5sfNMTgnCn0LjOmfXkDhXIeU5ARoofkU7/ofZMtU+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062003;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1jtOQFXMiYIe8p1UdhLzSWoI3T9JmfNSeYSnRK47cbA=;
	b=crwDpKoNvPTbirTTXbxNTmnVW49dljtGgDJMjI2Mbl4ZrGkn2eN3fPpidEp/55Tr4z4J
	 zJzcryo42/57Kv/WFxY8J8chuE+QLs7ahNnS9+7GicRX0WbkfGqc+xeJslMx2rn6ViWlO
	 40VbtKt0AzBw4DY4wfuEotVjH4iTFd0iyVkuPNWcZKC4IZOvVh48znG4SFGqcSPH6YVEF
	 AccRMaQqeFyUfRzXmWQcy9cm0fYvIEBrSj6JxszJB6ZjbsP+wFq0h/sxH1Hme6oa5oa0N
	 a58Q9/USOfYzakXmAh1iw7oXRPbraFETzR4jXsMTpLrjjEoXT2PxVeTkmVoOB3vCjeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBKKXUeg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADD606A31A;
	Tue, 27 Oct 2026 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBKKXUeg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E531F01825;
	Tue, 27 Oct 2026 00:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793062002;
	bh=1jtOQFXMiYIe8p1UdhLzSWoI3T9JmfNSeYSnRK47cbA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UBKKXUegUSubNaAuLT6kYCzrJCSFAtsFqPGyUFvUIVgJRp73mmJZ1DbPMocEc+n6L
	 RvG/bVQ6M/JbQk/qzm1YCQBjOjjb9gd/KcwdWVggZ2aCMEtiTp1vTDBCvECzQg+Gz1
	 6ELsK0tOVuU2pj/9mlCiYFIfu4lK/egpacmYAHM8Av4Hlikb+8jekwsNjrHtPPfDEr
	 BzmRD51cZ7S67QDxbUyQlw2cGlQVOeyn6bXQn7sL5/2pHuz5pfFknbKSrOGcFgJbNS
	 5QIabMZItOKjDxn069CmCZT8c0R08a3HvAjqA6tY8VJiOCn/nlFvR4YR6OSzlEyr2U
	 jfvTsd1XVHAXQ==
Subject: Re: [PATCH] net: fix self-deadlock when an upper disables a feature
 of its lower
From: netdev-bot+sashiko@kernel.org
To: eva.kurchatova@virtuozzo.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sd@queasysnail.net, sdf@fomichev.me,
 cratiu@nvidia.com, linux-kernel@vger.kernel.org,
 syzbot+c6c86a1c56b5131f2d97@syzkaller.appspotmail.com, netdev@vger.kernel.org
Date: Tue, 27 Oct 2026 00:46:41 +0000
Message-ID: <179306200144.3134.15655132626698865362@kernel.org>
In-Reply-To: <20261023000951.237641-1-eva.kurchatova@virtuozzo.com>
References: <20261023000951.237641-1-eva.kurchatova@virtuozzo.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] If the ops-locked lower's ndo_set_features() keeps failing while
  the lower still has LRO and an upper lacks it, the new deferred-sync…
- [Medium] A NETDEV_WORK_SYNC_UPPERS request can be lost permanently.
- [Low] The kernel-doc for the exported netdev_features_change() still
  says only 'Called to indicate a device has changed features.' After…

Pre-existing issues:
- [Low] Rejected at baseline (preexisting, low impact):
  ethnl_set_features() takes the new_active snapshot from dev->features…

--

net: fix self-deadlock when an upper disables a feature of its lower

In netdev_sync_lower_features(), this patch replaces netdev_lock_ops(lower)
with a trylock. When the lock is already held, it defers the feature
disable to a new NETDEV_WORK_SYNC_UPPERS netdev_work event.
netdev_features_change() then takes that pending event and runs
netif_sync_upper_disables() inline, so the context holding the lower's
lock finishes the job.

Closes: https://lore.kernel.org/all/6a6be82b.77639fcc.3d4fd0.0014.GAE@google.com/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360e..d3945140766fd 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1610,6 +1610,12 @@ int dev_get_alias(const struct net_device *dev, char *name, size_t len)
>  void netdev_features_change(struct net_device *dev)
>  {
>  	call_netdevice_notifiers(NETDEV_FEAT_CHANGE, dev);
> +
> +	/* Uppers reacting to the notification couldn't take our instance
> +	 * lock to disable features they lack, do it now.
> +	 */
> +	if (__netdev_work_core_cancel(dev, NETDEV_WORK_SYNC_UPPERS))
> +		netif_sync_upper_disables(dev);
>  }
>  EXPORT_SYMBOL(netdev_features_change);

[Severity: Low]
This isn't a bug, but the kernel-doc for netdev_features_change() still
says only:

    Called to indicate a device has changed features.

With this change, the function can also modify dev->wanted_features and
call netdev_update_features(dev) through netif_sync_upper_disables().
__netdev_update_features() asserts RTNL and the instance lock for
ops-locked devices, and Documentation/networking/netdev-features.rst
requires both for netdev_update_features().

Should the kernel-doc for this exported function say that it can now
change features and has that locking requirement? The in-tree direct
callers (cxgb4, ixgbe fcoe, mlx4, sfc) are not ops-locked, so nothing
breaks today.

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch, but the
inline run here now makes it reachable for ops-locked lowers.
ethnl_set_features() takes the new_active snapshot and sends the reply
before it calls netdev_features_change():

net/ethtool/features.c:ethnl_set_features() {
    ...
	ethnl_features_to_bitmap(new_active, dev->features);
    ...
		ret = features_send_reply(dev, info, req_wanted,
					  wanted_diff_mask, new_active,
					  active_diff_mask, compact);
	}
	if (mod)
		netdev_features_change(dev);
    ...
}

With this patch, that call can take NETDEV_WORK_SYNC_UPPERS and disable
LRO on the lower after the reply has already reported LRO as active.

The same mismatch already existed for lowers that are not ops-locked,
where netdev_sync_lower_features() changed the lower directly inside the
notifier chain. The nested ETHTOOL_MSG_FEATURES_NTF still reports the
final state.

Is the FEATURES_SET reply meant to reflect dev->features after the
operation, as Documentation/networking/ethtool-netlink.rst describes?

> @@ -10968,6 +10974,28 @@ static netdev_features_t netdev_sync_upper_features(struct net_device *lower,
>  	return features;
>  }
>  
> +/* Disable the features of @dev which any of its upper devices has disabled,
> + * deferred from netdev_sync_lower_features().
> + */
> +void netif_sync_upper_disables(struct net_device *dev)
> +{
> +	netdev_features_t disable = 0;
> +	struct net_device *upper;
> +	struct list_head *iter;
> +
> +	netdev_for_each_upper_dev_rcu(dev, upper, iter)
> +		disable |= ~upper->features;
> +	disable &= NETIF_F_UPPER_DISABLES & dev->features;
> +	if (!disable)
> +		return;
> +
> +	dev->wanted_features &= ~disable;
> +	netdev_update_features(dev);

[Severity: High]
Can this recurse without limit if the lower's ndo_set_features() keeps
failing?

The old code called __netdev_update_features(lower) and only sent
netdev_features_change() on success. This path uses
netdev_update_features() instead, and __netdev_update_features() returns
-1 when ndo_set_features() fails:

	/* return non-0 since some features might have changed and
	 * it's better to fire a spurious notification than miss it
	 */
	return -1;

So NETDEV_FEAT_CHANGE is sent even on failure. With the current task
holding the lower's instance lock, the cycle would look like this:

netif_sync_upper_disables(lower)
  netdev_update_features(lower)
    __netdev_update_features(lower)     ndo_set_features() fails, -1
    netdev_features_change(lower)
      call_netdevice_notifiers(NETDEV_FEAT_CHANGE, lower)
        macvlan_device_event()
          netdev_update_features(upper)
            netdev_sync_lower_features(upper, lower, ...)
              netdev_trylock(lower) fails, LRO still set on lower
              __netdev_work_core_sched(lower, NETDEV_WORK_SYNC_UPPERS)
      __netdev_work_core_cancel(lower, NETDEV_WORK_SYNC_UPPERS) != 0
      netif_sync_upper_disables(lower)
        ... repeats

Nothing limits the depth, and each level logs a netdev_err(). Would this
eventually overflow the kernel stack?

The async path seems to fall into the same loop. netdev_work_proc() holds
the lower's ops lock while netdev_work_run() calls
netif_sync_upper_disables(), so the nested trylock fails there as well.

One way to reach this with netdevsim, which is ops-locked and has LRO on
by default:

1. Enable hw-tc-offload and attach an offloaded TC BPF program.
2. Turn hw-tc-offload off. nsim_set_features() then returns -EBUSY from
   nsim_bpf_disable_tc() on every later update.
3. Put a macvlan with LRO off on top.
4. Attach generic XDP to the netdevsim device. generic_xdp_install()
   calls netif_disable_lro(), which calls netdev_update_features() under
   the nsim lock. That update fails and starts the loop.

On real hardware the same could happen whenever disabling LRO keeps
failing, for example when mlx5e set_feature_lro() gets an error from
mlx5e_safe_switch_params(). Before this patch, that failure caused a
single netdev_WARN() in netdev_sync_lower_features() and nothing more.

> +
> +	if (unlikely(dev->features & disable))
> +		netdev_WARN(dev, "failed to disable %pNF!\n", &disable);
> +}

[ ... ]

> diff --git a/net/core/netdev_work.c b/net/core/netdev_work.c
> index e721a06d58df1..5a608ba403894 100644
> --- a/net/core/netdev_work.c
> +++ b/net/core/netdev_work.c
> @@ -123,6 +123,8 @@ static void netdev_work_run(struct net_device *dev, unsigned long events,
>  
>  	if (core & NETDEV_WORK_RX_MODE)
>  		netif_rx_mode_run(dev);
> +	if (core & NETDEV_WORK_SYNC_UPPERS)
> +		netif_sync_upper_disables(dev);

[Severity: Medium]
Can a NETDEV_WORK_SYNC_UPPERS request get lost for good here?

When an unrelated task holds the lower's lock, netdev_sync_lower_features()
queues the event and skips the lower->wanted_features update. The pending
bit is then the only record of the request.

netdev_work_proc() clears that bit before dispatching:

			core = dev->work_core_pending;
			dev->work_core_pending = 0;

Then netdev_work_run() returns early if the device is detached:

	if (!netif_device_present(dev))
		return;

Nothing queues the event again after that. netif_device_attach() only
wakes the TX queues and restarts the watchdog.

This looks reachable with ops-locked drivers such as bnxt.
bnxt_suspend() and bnxt_io_error_detected() take netdev_lock() without
RTNL, call netif_device_detach(), and drop the lock with the device still
detached. An RTNL holder that updates an upper at the same time would fail
the trylock and queue the work. That work then runs after bnxt unlocks,
finds the device absent, and drops the event.

A later recompute of the lower doesn't seem to fix this either.
netdev_sync_upper_features() checks upper->wanted_features, and
macvtap/macsec keep LRO in wanted_features while masking it out of
features.

Could the lower then keep LRO indefinitely under an upper that lacks it?

The inline run in netdev_features_change() has no presence check, so the
two places that consume this event also behave differently.

>  	if (events && dev->netdev_ops->ndo_work)
>  		dev->netdev_ops->ndo_work(dev, events);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023000951.237641-1-eva.kurchatova%40virtuozzo.com
