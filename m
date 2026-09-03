Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43635013B2;
	Thu,  3 Sep 2026 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463513; cv=none; b=fLENVUwuK4G2GK6yGLv58t3bKojzCvs7MCQ9STKzo4milMCnHc2W6s1lLxkMYq8KrqWJfifEWenJvWt/735eerJz9ubK4v/3QNYAaqe3T86qRjsGhxC2cBVZHPy1zfTpVUGatOgJs47O+3Mw8OnerfAGyUqFy2xzvDHaP5Rk/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463513; c=relaxed/simple;
	bh=9erMMYeEp6MhpmeisCTbFBAC2XS6KvR0S9OUdWc35Ow=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ohi0feRi1B6z8qW+cI0svnr91hyabvb/GcGETwSYQqHQlZhZR/+IOx88oalcGuDDPCx8PYeyJlbTyjli9zFPpavb4OWJW9lWHLplq/SgIOCh7QmrFM5alN83kP8eJgwaVLflfAM2fv0d47FJGLmYubGVYCXQNQuAQC6+/pTIjqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA8GJn2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA8GJn2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7221F00ACA;
	Thu,  3 Sep 2026 19:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463490;
	bh=iVQg8Sph/zs009WQV54zYRKBypJ2lrCrIKDHh1aKapo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SA8GJn2wh8HLgbv7Hn+GHRupjzDBeXJoyD/3uYhmRkhn/EBoYa6GbTjbkN5pqE3Xu
	 jw0FAE/pfGy/C7PNADhQKO29juCdiPDxHxm11BwA395MHtaHcxTrwE424jF5ijww02
	 +Ilqeus800aJE8fMfQnbvCkMTziXyqM0Ar2uO4UQaTNVfV7ujbmNUkq3JpvAfYtQAV
	 D8va0GyqXCMWb2sZhnpg/duxS4gatoqnRDFIvPIkPZ9AUt9hZRkJPArNuhbfYHRVmk
	 ciJiyK1stbVbo8ZAB4HQ4phr+rqYantJU5Ukpixqgzy3q3TZi/JHEyoxl5ScGJg0Bf
	 LIp8r8fDY6rrg==
Subject: Re: [v9,net-next,6/8] octeontx2-pf: switch: Register notifiers for
 switch offload
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Thu, 03 Sep 2026 19:24:49 +0000
Message-ID: <178846348905.3394541.7517069116859509457@kernel.org>
In-Reply-To: <20260831131944.2649362-7-rkannoth@marvell.com>
References: <20260831131944.2649362-7-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider:

Critical: 0 · High: 3 · Medium: 3 · Low: 4

- [High] rvu_eswitch_config()
  (drivers/net/ethernet/marvell/octeontx2/nic/rep.c:401) now returns…
- [High] sw_nb_net_event()
  (drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c) casts the…
- [High] Global notifiers blindly cast `netdev_priv()` to `struct
  otx2_nic *` for any Cavium PCI device, leading to type confusion and…
- [Medium] IPv6 interface-address entries are marked as host entries
  (`entry->host = 1`) but carry the interface's subnet prefix length…
- [Medium] rvu_eswitch_config() now reads `priv->netdev` and passes it to
  otx2_sw_nb_register()/otx2_sw_nb_unregister(), which stores it in the…
- [Medium] otx2_sw_nb_registered and sw_nb_pf_netdev are plain globals
  with no synchronisation.
- [Low] At this commit every new notifier handler builds a struct
  fib_entry, logs it with netdev_dbg() and immediately kfree()s it, and…
- [Low] sw_nb_netdev_event() in
  drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c declares…
- [Low] Notifier registration is a process-global singleton:
  otx2_sw_nb_register() returns -EBUSY if otx2_sw_nb_registered is…
- [Low] sw_nb.h declares `int
  otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf, struct…

--

octeontx2-pf: switch: Register notifiers for switch offload

This registers and unregisters the switch notifier blocks (FIB, netevent,
inetaddr/inet6addr, netdevice and switchdev FDB) when the representor
enables or disables switch mode via devlink. It also adds sw_nb_v4.c and
sw_nb_v6.c for the address-family specific handling, and links sw_nb_v6.o
only when the IPv6 symbols are reachable.

A few questions below about the notifier registration path and the new
event handlers.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 257a2ae6a53e5..96ec58c508432 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c

[ ... ]

> @@ -399,22 +400,62 @@ static void rvu_rep_get_stats64(struct net_device *dev,
>  
>  static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
>  {
> +#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +	struct net_device *netdev = priv->netdev;
> +#endif

[Severity: Medium]

Is priv->netdev ever set for the rvu_rep PF?  Grepping the octeontx2 tree
shows only two references: this new read, and the assignment inside
rvu_rep_setup_tc_cb():

	priv->netdev = rep->netdev;

rvu_rep_probe() does not initialise it, so on the first eswitch enable
netdev is NULL.  otx2_sw_nb_register() then stores NULL into
sw_nb_pf_netdev (making the FIB logging fallback dead), and any
register_*_notifier() failure runs netdev_err(NULL, ...).

There is a second concern with the same pointer.  Once a TC flower rule has
been offloaded on a representor, priv->netdev points at rep->netdev, and
rvu_rep_destroy() does:

		unregister_netdev(rep->netdev);
		rvu_rep_devlink_port_unregister(rep);
		free_netdev(rep->netdev);

without clearing priv->netdev.  Can a later switchdev enable then publish
that freed netdev into sw_nb_pf_netdev, where sw_nb_fib_event() logs
through it?  Would taking a netdev_hold(), or simply using priv->dev for
logging, be safer here?

>  	struct devlink_port_attrs attrs = {};
>  	struct esw_cfg_req *req;
> +	int mbox_err;
> +#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +	int err;
> +#endif
>  
>  	rvu_rep_devlink_set_switch_id(priv, &attrs.switch_id);
>  
> +#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +	/* Disable unregisters PF notifiers before ESW_CFG clears rep_mode on
> +	 * the AF.  unregister_*_notifier() removes each block synchronously,
> +	 * so there is no window where the AF considers the eswitch off while
> +	 * sw_nb_* handlers remain registered and could still send mailbox
> +	 * traffic (that race existed only when disable ran after the mailbox).
> +	 */
> +	if (ena) {
> +		err = otx2_sw_nb_register(netdev);
> +		if (err)
> +			return err;
> +	} else {
> +		/* TODO: On disable, notifiers are unregistered before ESW_CFG. If
> +		 * mailbox allocation fails below, restore otx2_sw_nb_register()
> +		 * so software notifiers are not abandoned while hardware remains
> +		 * in eswitch mode.
> +		 */
> +		err = otx2_sw_nb_unregister(netdev);
> +		if (err)
> +			return err;
> +	}
> +#endif

[Severity: High]

These early returns skip the ESW_CFG mailbox entirely, and both callers
discard the return value:

	rvu_rep_create()
		rvu_eswitch_config(priv, true);
		return 0;

	rvu_rep_destroy()
		rvu_eswitch_config(priv, false);
		priv->flags |= OTX2_FLAG_INTF_DOWN;
		rvu_rep_free_cq_rsrc(priv);

Can AF state and driver state diverge in both directions here?

On enable, otx2_sw_nb_register() can fail with -EBUSY (the global
single-registration guard) or with errors from sw_fdb_init(),
otx2_sw_fib_init() or any register_*_notifier().  ESW_CFG is never sent,
so rvu_mbox_handler_esw_cfg() never runs and rvu->rep_mode stays 0, but
otx2_devlink_eswitch_mode_set() still sees success:

	if (!ret)
		pfvf->esw_mode = mode;

so devlink reports switchdev mode with no representor steering installed.

On disable, otx2_sw_nb_unregister() has already unregistered all six
notifier blocks and run sw_fl_deinit()/otx2_sw_fib_deinit()/sw_fdb_deinit()
and cleared otx2_sw_nb_registered before it returns the accumulated error.
rvu_eswitch_config() then returns without sending ESW_CFG(ena = 0), so the
AF keeps rep_mode = 1 and the rep MCAM entries installed, while
rvu_rep_destroy() continues on to rvu_rep_free_cq_rsrc(),
unregister_netdev(), free_netdev() and rvu_rep_rsrc_free().  Does that
leave hardware steering traffic to representor pcifuncs whose NIX/CQ
resources have been freed?

A retry does not repair it either, since otx2_sw_nb_unregister() now
short-circuits on !otx2_sw_nb_registered.

Would it make more sense to send ESW_CFG regardless and propagate the
result to rvu_rep_create()/rvu_rep_destroy()?

> +
>  	mutex_lock(&priv->mbox.lock);
>  	req = otx2_mbox_alloc_msg_esw_cfg(&priv->mbox);
>  	if (!req) {
>  		mutex_unlock(&priv->mbox.lock);
> +#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +		if (ena)
> +			otx2_sw_nb_unregister(netdev);
> +#endif
>  		return -ENOMEM;
>  	}
>  	req->ena = ena;
>  	memcpy(req->switch_id, attrs.switch_id.id, attrs.switch_id.id_len);
> -	otx2_sync_mbox_msg(&priv->mbox);
> +	mbox_err = otx2_sync_mbox_msg(&priv->mbox);
>  	mutex_unlock(&priv->mbox.lock);
> -	return 0;
> +
> +#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +	if (ena && mbox_err)
> +		otx2_sw_nb_unregister(netdev);
> +#endif
> +
> +	return mbox_err;
>  }
>  
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> index 426a420119301..b51d8d2d01b8c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> @@ -4,18 +4,555 @@

[ ... ]

> +const char *sw_nb_get_cmd2str(int cmd)
> +{
> +	return sw_nb_cmd2str[cmd];
> +}
> +EXPORT_SYMBOL(sw_nb_get_cmd2str);

[Severity: Low]

This helper has no in-tree caller, even at the end of the series, and it
indexes sw_nb_cmd2str[] without validating cmd: index 0 returns NULL and
cmd >= OTX2_CMD_MAX reads past the array.  Is the EXPORT_SYMBOL() needed,
and could a bounds check be added?

Related: sw_nb_fib_event_dump() and SWITCH_NB_FIB_EVENT_DUMP() are added as
__maybe_unused with no user and stay that way through the series.

Also, at this commit each new handler builds a struct fib_entry, logs it
with netdev_dbg() and immediately kfree()s it, and sw_nb_fdb_event() is a
no-op:

	case SWITCHDEV_FDB_ADD_TO_DEVICE:
		if (fdb_info->is_local)
			break;
		break;

The later patches in the series replace those kfree() calls with
sw_fib_add_to_list()/sw_fdb_add_to_list(), so this is only noted for the
record.

[ ... ]

> +static int sw_nb_net_event(struct notifier_block *nb,
> +			   unsigned long event, void *ptr)
> +{
> +	struct neighbour *n = ptr;
> +
> +	if (!sw_nb_is_valid_dev(n->dev))
> +		return NOTIFY_DONE;
> +
> +	if (event != NETEVENT_NEIGH_UPDATE)
> +		return NOTIFY_DONE;

[Severity: High]

Should the event check come before ptr is treated as a struct neighbour?
The netevent chain carries a different payload per event, per
include/net/netevent.h:

	NETEVENT_NEIGH_UPDATE = 1, /* arg is struct neighbour ptr */
	NETEVENT_REDIRECT,	   /* arg is struct netevent_redirect ptr */
	NETEVENT_DELAY_PROBE_TIME_UPDATE, /* arg is struct neigh_parms ptr */
	NETEVENT_IPV4_MPATH_HASH_UPDATE, /* arg is struct net ptr */

net/core/neighbour.c passes a struct neigh_parms:

	if (index == NEIGH_VAR_DELAY_PROBE_TIME)
		call_netevent_notifiers(NETEVENT_DELAY_PROBE_TIME_UPDATE, p);

and net/ipv4/sysctl_net_ipv4.c passes a struct net:

	if (write && ret == 0)
		call_netevent_notifiers(NETEVENT_IPV4_MPATH_HASH_UPDATE, net);

offsetof(struct neighbour, dev) is several hundred bytes in (arp_queue,
timer, ha[] and a struct hh_cache precede dev), so reading n->dev from a
neigh_parms object or from the stack-allocated struct netevent_redirect
looks like an out-of-bounds read.  The garbage value is then dereferenced
as a net_device by netif_is_bridge_master() (dev->priv_flags),
sw_nb_is_cavium_dev():

	dev = netdev->dev.parent;
	if (!dev || dev->bus != &pci_bus_type)
		return false;

	pdev = to_pci_dev(dev);
	if (pdev->vendor != PCI_VENDOR_ID_CAVIUM)

and netdev_walk_all_lower_dev_rcu() (dev->adj_list).  Once switchdev mode
is on, a write to /proc/sys/net/ipv4/neigh/*/delay_first_probe_time or to
/proc/sys/net/ipv4/fib_multipath_hash_policy would reach this.  Can that
oops?

[ ... ]

> +static int sw_nb_netdev_event(struct notifier_block *unused,
> +			      unsigned long event, void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct in_device *idev;
> +	struct inet6_dev *i6dev;

[Severity: Low]

i6dev is declared unconditionally but its only use sits inside
#if IS_REACHABLE(CONFIG_IPV6) below.  With CONFIG_OCTEONTX_SWITCH=y and
CONFIG_IPV6=n (allowed, since OCTEONTX_SWITCH only depends on
(64BIT && COMPILE_TEST) || ARM64 and OCTEONTX2_PF), or with CONFIG_IPV6=m
and a built-in driver, this is an unused variable and -Wunused-variable
becomes a build failure with the default CONFIG_WERROR=y.  Should the
declaration move inside the same conditional?

> +
> +	if (event != NETDEV_CHANGE &&
> +	    event != NETDEV_UP &&
> +	    event != NETDEV_DOWN) {
> +		return NOTIFY_DONE;
> +	}
> +
> +	if (!sw_nb_is_valid_dev(dev))
> +		return NOTIFY_DONE;
> +
> +	idev = __in_dev_get_rtnl(dev);
> +	if (idev)
> +		sw_nb_v4_netdev_event(unused, event, ptr);
> +
> +#if IS_REACHABLE(CONFIG_IPV6)
> +	i6dev = __in6_dev_get(dev);
> +	if (i6dev)
> +		sw_nb_v6_netdev_event(unused, event, ptr);
> +#endif
> +
> +	return NOTIFY_DONE;
> +}

[ ... ]

> +int otx2_sw_nb_unregister(struct net_device *netdev)
> +{
> +	int err, ret = 0;
> +
> +	if (!otx2_sw_nb_registered)
> +		return 0;

[ ... ]

> +	sw_fl_deinit();
> +	otx2_sw_fib_deinit();
> +	sw_fdb_deinit();
> +
> +	sw_nb_pf_netdev = NULL;
> +	otx2_sw_nb_registered = false;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(otx2_sw_nb_unregister);
> +
> +/* Concurrent registration from multiple devlink instances cannot occur on a
> + * given RVU: only the RVU_REP netdev devlink reaches this function (see
> + * comment above). The AF and PF/VF devlinks do not call otx2_sw_nb_register(),
> + * and their eswitch_mode_set handlers return -EOPNOTSUPP. devlink core
> + * holds devlink->lock for the full DEVLINK_CMD_ESWITCH_MODE_SET handler,
> + * so two threads cannot enter here concurrently on that single rep devlink.
> + * A second call after successful registration returns -EBUSY before any
> + * notifier or workqueue state is modified.
> + */
> +int otx2_sw_nb_register(struct net_device *netdev)
>  {
> +	int err;
> +
> +	/* Notifier blocks are global and only one RVU_REP may register at a
> +	 * time (switch offload is init_net-wide; see comment at file top).
> +	 * A second RVU card gets -EBUSY here by design.  Concurrent calls on
> +	 * the same RVU_REP cannot happen: only that netdev's devlink reaches
> +	 * this function (otx2_rep_dev()), and devlink core holds
> +	 * devlink->lock for the full DEVLINK_CMD_ESWITCH_MODE_SET handler.
> +	 * No extra lock is needed to protect the notifier chains.
> +	 */
> +	if (otx2_sw_nb_registered)
> +		return -EBUSY;
> +
> +	sw_nb_pf_netdev = netdev;

[Severity: Medium]

devlink->lock is per devlink instance.  With two RVU_REP functions there
are two devlinks, so can two threads run this unlocked check-then-set
concurrently?

	if (otx2_sw_nb_registered)
		return -EBUSY;
	...
	otx2_sw_nb_registered = true;

Both would then run sw_fdb_init()/otx2_sw_fib_init()/sw_fl_init(), which
re-initialise global workqueue pointers (leaking the loser's workqueue),
both would call register_switchdev_notifier() and friends with the same
static notifier_block objects, and sw_nb_pf_netdev would keep whichever
store landed last.

The flag also records no owner.  Since rvu_rep_create() ignores the
-EBUSY, device B enters switchdev mode without registering, and a later
rvu_rep_destroy(B) -> otx2_sw_nb_unregister() sees the global flag set and
tears down device A's notifiers and helpers.  Is that intended?

Finally, is the comment's claim that DEVLINK_CMD_ESWITCH_MODE_SET is the
only entry point accurate?  rvu_rep_remove() reaches the same code with no
devlink lock held:

	otx2_unregister_dl(priv);
	if (!(priv->flags & OTX2_FLAG_INTF_DOWN))
		rvu_rep_destroy(priv);

[Severity: Low]

The commit message describes switch-mode support generally but does not
mention that this registration is a process-global singleton, so switch
offload can be enabled on only one RVU device per host ("A second RVU card
gets -EBUSY here by design").  Could the changelog state that, along with
the other restrictions the comments encode: registration is init_net-wide
with no netns scoping, and register_fib_notifier() is called with NULL
dump/replay callbacks so pre-existing routes are never replayed?

> +
> +	err = sw_fdb_init();
> +	if (err)
> +		goto err_clear;

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
> index 0ba29f76fd41f..39435f23427cf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
> @@ -9,12 +9,41 @@

[ ... ]

> +int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
> +					   struct af2pf_fdb_refresh_req *req,
> +					   struct msg_rsp *rsp);

[Severity: Low]

At this commit this prototype has no definition, and
otx2_process_mbox_msg_up() does not expand
MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES, so MBOX_MSG_AF2PF_FDB_REFRESH is not
routed.  Both gaps are closed by later patches in the same series
(sw_fdb.c defines the handler and otx2_pf.c expands the macro), so this is
only noted for the record - would it be tidier to add the declaration in
the patch that adds the definition?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
> new file mode 100644
> index 0000000000000..3497e60aedbec
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
> @@ -0,0 +1,301 @@

[ ... ]

> +	entry->cmd = sw_nb_inetaddr_event_to_otx2_event(event, dev);
> +	memcpy(entry->dst6, &addr, sizeof(entry->dst6));
> +	entry->dst6_plen = prefix_len;
> +	entry->host = 1;
> +	entry->ipv6 = 1;

[Severity: Medium]

Should host entries carry a full 128-bit prefix here?  This path in
sw_nb_v6_netdev_event(), and the same assignment in
sw_nb_v6_inetaddr_event():

	entry->dst6_plen = ifa6->prefix_len;
	entry->mac_valid = 1;
	entry->host = 1;

use the interface subnet prefix while setting host = 1.  Every other
producer of the same descriptor uses an exact-host length -
sw_nb_v4_inetaddr_event() and sw_nb_v4_netdev_event() use:

	entry->dst_len = 32;
	entry->mac_valid = 1;
	entry->host = 1;

and sw_nb_net_v6_neigh_update() uses the full key length:

	entry->dst6_plen = n->tbl->key_len * 8;

If the consumer honours dst6_plen for host rules, would a typical /64
interface prefix be installed as the local-host entry, claiming the whole
subnet as local?

[ ... ]

> @@ -4,18 +4,555 @@
>   * Copyright (C) 2026 Marvell.
>   *
>   */
> +#include <linux/kernel.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <net/switchdev.h>
> +#include <net/netevent.h>
> +#include <net/arp.h>
> +#include <net/route.h>
> +#include <linux/inetdevice.h>
> +#include <net/addrconf.h>
> +
> +#include "../otx2_reg.h"
> +#include "../otx2_common.h"
> +#include "../otx2_struct.h"
> +#include "../cn10k.h"
>  #include "sw_nb.h"
> +#include "sw_fdb.h"
> +#include "sw_fib.h"
> +#include "sw_fl.h"
> +#include "sw_nb_v4.h"
> +#include "sw_nb_v6.h"
>  
>  #if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
>  
> -int otx2_sw_nb_unregister(void)
> +/* PF netdev for netdev_* logging when notifier info has no device */
> +static struct net_device *sw_nb_pf_netdev;
> +/* Notifier registration is toggled only from rvu_eswitch_config(), which is
> + * reached exclusively when switchdev mode is enabled on the RVU eswitch
> + * representor PF (PCI_DEVID_RVU_REP). The sole call path is:
> + *
> + *   DEVLINK_CMD_ESWITCH_MODE_SET
> + *     -> otx2_devlink_eswitch_mode_set()  [otx2_rep_dev() only]
> + *       -> rvu_rep_create() / rvu_rep_destroy()
> + *         -> rvu_eswitch_config(ena = 1) -> otx2_sw_nb_register()
> + *         -> rvu_eswitch_config(ena = 0) -> otx2_sw_nb_unregister()
> + *
> + * On disable, otx2_sw_nb_unregister() runs before the ESW_CFG mailbox so flush
> + * paths in sw_fdb/fib/fl_deinit() can still reach hardware.
> + *
> + * Other OcteonTX2 netdev PFs/VFs also have a devlink, but their
> + * eswitch_mode_set handler returns -EOPNOTSUPP. The AF rvu_devlink
> + * eswitch_mode_set does not register these notifiers. There is exactly
> + * one RVU_REP PCI function (and netdev devlink) per RVU, and devlink
> + * core holds devlink->lock for the full DEVLINK_CMD_ESWITCH_MODE_SET
> + * handler, so this path cannot run concurrently on the same device.
> + * otx2_sw_nb_registered further ensures at most one active registration.
> + */
> +static bool otx2_sw_nb_registered;
> +
> +static const char *sw_nb_cmd2str[OTX2_CMD_MAX] = {
> +	[OTX2_DEV_UP]  = "OTX2_DEV_UP",
> +	[OTX2_DEV_DOWN] = "OTX2_DEV_DOWN",
> +	[OTX2_DEV_CHANGE] = "OTX2_DEV_CHANGE",
> +	[OTX2_NEIGH_UPDATE] = "OTX2_NEIGH_UPDATE",
> +	[OTX2_FIB_ENTRY_REPLACE] = "OTX2_FIB_ENTRY_REPLACE",
> +	[OTX2_FIB_ENTRY_ADD] = "OTX2_FIB_ENTRY_ADD",
> +	[OTX2_FIB_ENTRY_DEL] = "OTX2_FIB_ENTRY_DEL",
> +	[OTX2_FIB_ENTRY_APPEND] = "OTX2_FIB_ENTRY_APPEND",
> +};
> +
> +const char *sw_nb_get_cmd2str(int cmd)
> +{
> +	return sw_nb_cmd2str[cmd];
> +}
> +EXPORT_SYMBOL(sw_nb_get_cmd2str);
> +
> +bool sw_nb_is_cavium_dev(struct net_device *netdev)
> +{
> +	struct pci_dev *pdev;
> +	struct device *dev;
> +
> +	dev = netdev->dev.parent;
> +	if (!dev || dev->bus != &pci_bus_type)
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +	if (pdev->vendor != PCI_VENDOR_ID_CAVIUM)
> +		return false;
> +
> +	return true;
> +}
> +
> +/* Resolve the Cavium PF netdev used to reach the switch AF for offload.
> + *
> + * For a bridge master netdev, any Cavium netdev enslaved to the bridge is
> + * sufficient: callers only need a PF netdev to obtain the switch AF mailbox
> + * context (pcifunc). Bridge-specific information is tagged separately in
> + * the offload entry (entry->bridge), so walking every lower netdev is not
> + * required here.
> + *
> + * Only a single level of netdev nesting is resolved (bridge lower dev or
> + * VLAN real dev). Nested topologies such as VLAN-over-bridge are not
> + * supported; offload will not work for those configurations.
> + */
> +struct net_device *sw_nb_resolve_pf_dev(struct net_device *dev)
> +{
> +	struct net_device *pf_dev = dev;
> +	struct list_head *iter;
> +
> +	rcu_read_lock();
> +
> +	if (netif_is_bridge_master(dev)) {
> +		iter = &dev->adj_list.lower;
> +		pf_dev = netdev_next_lower_dev_rcu(dev, &iter);
> +		if (!pf_dev)
> +			pf_dev = dev;
> +	} else if (is_vlan_dev(dev)) {
> +		pf_dev = vlan_dev_real_dev(dev);
> +	}
> +
> +	rcu_read_unlock();
> +
> +	if (!sw_nb_is_cavium_dev(pf_dev))
> +		return NULL;
> +
> +	return pf_dev;
> +}
> +
> +static int sw_nb_check_slaves(struct net_device *dev,
> +			      struct netdev_nested_priv *priv)
>  {
> +	int *cnt;
> +
> +	if (!priv->flags)
> +		return 0;
> +
> +	priv->flags &= sw_nb_is_cavium_dev(dev);
> +	if (priv->flags) {
> +		cnt = priv->data;
> +		(*cnt)++;
> +	}
> +
>  	return 0;
>  }
>  
> -int otx2_sw_nb_register(void)
> +/* Switch offload has no network namespace support. The global notifiers
> + * registered below are not scoped to a netns, and sw_nb_is_cavium_dev()
> + * matches any Cavium PCI netdev without checking dev_net(). All netdevs
> + * involved in offload (PF/VF ports, bridge members, VLANs, neighbours,
> + * and routes) must therefore reside in &init_net for offload to work.
> + */
> +bool sw_nb_is_valid_dev(struct net_device *netdev)
> +{
> +	struct netdev_nested_priv priv;
> +	struct net_device *br;
> +	int cnt = 0;
> +	bool valid;
> +
> +	priv.flags = true;
> +	priv.data = &cnt;
> +
> +	rcu_read_lock();
> +
> +	if (netif_is_bridge_master(netdev) || is_vlan_dev(netdev)) {
> +		netdev_walk_all_lower_dev_rcu(netdev, sw_nb_check_slaves, &priv);
> +		valid = priv.flags && cnt;
> +		rcu_read_unlock();
> +		return valid;
> +	}
> +
> +	if (netif_is_bridge_port(netdev)) {
> +		br = netdev_master_upper_dev_get_rcu(netdev);
> +		if (!br) {
> +			rcu_read_unlock();
> +			return false;
> +		}
> +		netdev_walk_all_lower_dev_rcu(br, sw_nb_check_slaves, &priv);
> +		valid = priv.flags && cnt;
> +		rcu_read_unlock();
> +		return valid;
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return sw_nb_is_cavium_dev(netdev);
> +}
> +
> +static int sw_nb_fdb_event(struct notifier_block *unused,
> +			   unsigned long event, void *ptr)
> +{
> +	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
> +	struct switchdev_notifier_fdb_info *fdb_info = ptr;
> +
> +	if (!sw_nb_is_valid_dev(dev))
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> +		if (fdb_info->is_local)
> +			break;
> +		break;
> +
> +	case SWITCHDEV_FDB_DEL_TO_DEVICE:
> +		if (fdb_info->is_local)
> +			break;
> +		break;
> +
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block sw_nb_fdb = {
> +	.notifier_call = sw_nb_fdb_event,
> +};
> +
> +static void __maybe_unused
> +sw_nb_fib_event_dump(unsigned long event, void *ptr)
> +{
> +	struct fib_entry_notifier_info *fen_info = ptr;
> +	struct net_device *log_dev;
> +	struct fib_nh *fib_nh;
> +	struct fib_info *fi;
> +	int i;
> +
> +	fi = fen_info->fi;
> +	log_dev = (fi && fi->fib_nhs) ? fi->fib_nh->fib_nh_dev : sw_nb_pf_netdev;
> +	if (log_dev)
> +		netdev_info(log_dev, "%s: FIB event=%lu dst=%pI4h dstlen=%d type=%u\n",
> +			    __func__, event, &fen_info->dst, fen_info->dst_len,
> +			    fen_info->type);
> +
> +	if (!fi)
> +		return;
> +
> +	fib_nh = fi->fib_nh;
> +	for (i = 0; i < fi->fib_nhs; i++, fib_nh++) {
> +		if (!fib_nh->fib_nh_dev)
> +			continue;
> +		netdev_info(fib_nh->fib_nh_dev,
> +			    "%s: dev=%s saddr=%pI4n gw=%pI4n\n",
> +			    __func__, fib_nh->fib_nh_dev->name,
> +			    &fib_nh->nh_saddr, &fib_nh->fib_nh_gw4);
> +	}
> +}
> +
> +#define SWITCH_NB_FIB_EVENT_DUMP(...) \
> +	sw_nb_fib_event_dump(__VA_ARGS__)
> +
> +int sw_nb_fib_event_to_otx2_event(int event, struct net_device *netdev)
> +{
> +	switch (event) {
> +	case FIB_EVENT_ENTRY_REPLACE:
> +		return OTX2_FIB_ENTRY_REPLACE;
> +	case FIB_EVENT_ENTRY_ADD:
> +		return OTX2_FIB_ENTRY_ADD;
> +	case FIB_EVENT_ENTRY_DEL:
> +		return OTX2_FIB_ENTRY_DEL;
> +	default:
> +		break;
> +	}
> +
> +	netdev_err(netdev, "Wrong FIB event %d\n", event);
> +	return -1;
> +}
> +
> +static int sw_nb_fib_event(struct notifier_block *nb,
> +			   unsigned long event, void *ptr)
> +{
> +	struct fib_notifier_info *info = ptr;
> +
> +	switch (event) {
> +	case FIB_EVENT_ENTRY_REPLACE:
> +	case FIB_EVENT_ENTRY_ADD:
> +	case FIB_EVENT_ENTRY_DEL:
> +		break;
> +	default:
> +		if (sw_nb_pf_netdev)
> +			netdev_dbg(sw_nb_pf_netdev,
> +				   "%s: Won't process FIB event %lu\n",
> +				   __func__, event);
> +		return NOTIFY_DONE;
> +	}
> +
> +	switch (info->family) {
> +	case AF_INET:
> +		return sw_nb_v4_fib_event(nb, event, ptr);
> +#if IS_REACHABLE(CONFIG_IPV6)
> +	case AF_INET6:
> +		return sw_nb_v6_fib_event(nb, event, ptr);
> +#endif
> +	default:
> +		break;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block sw_nb_fib = {
> +	.notifier_call = sw_nb_fib_event,
> +};
> +
> +static int sw_nb_net_event(struct notifier_block *nb,
> +			   unsigned long event, void *ptr)
> +{
> +	struct neighbour *n = ptr;
> +
> +	if (!sw_nb_is_valid_dev(n->dev))
> +		return NOTIFY_DONE;
> +
> +	if (event != NETEVENT_NEIGH_UPDATE)
> +		return NOTIFY_DONE;
> +
> +	switch (n->tbl->family) {
> +	case AF_INET:
> +		return sw_nb_net_v4_neigh_update(nb, event, ptr);
> +#if IS_REACHABLE(CONFIG_IPV6)
> +	case AF_INET6:
> +		return sw_nb_net_v6_neigh_update(nb, event, ptr);
> +#endif
> +	default:
> +		break;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block sw_nb_netevent = {
> +	.notifier_call = sw_nb_net_event,
> +
> +};
> +
> +int sw_nb_inetaddr_event_to_otx2_event(int event, struct net_device *netdev)
> +{
> +	switch (event) {
> +	case NETDEV_CHANGE:
> +		return OTX2_DEV_CHANGE;
> +	case NETDEV_UP:
> +		return OTX2_DEV_UP;
> +	case NETDEV_DOWN:
> +		return OTX2_DEV_DOWN;
> +	default:
> +		break;
> +	}
> +	netdev_dbg(netdev, "%s: Wrong interaddr event %d\n",
> +		   __func__, event);
> +	return -1;
> +}
> +
> +static struct notifier_block sw_nb_v4_inetaddr = {
> +	.notifier_call = sw_nb_v4_inetaddr_event,
> +};
> +
> +#if IS_REACHABLE(CONFIG_IPV6)
> +static struct notifier_block sw_nb_v6_inetaddr = {
> +	.notifier_call = sw_nb_v6_inetaddr_event,
> +};
> +#endif
> +
> +static int sw_nb_netdev_event(struct notifier_block *unused,
> +			      unsigned long event, void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct in_device *idev;
> +	struct inet6_dev *i6dev;
> +
> +	if (event != NETDEV_CHANGE &&
> +	    event != NETDEV_UP &&
> +	    event != NETDEV_DOWN) {
> +		return NOTIFY_DONE;
> +	}
> +
> +	if (!sw_nb_is_valid_dev(dev))
> +		return NOTIFY_DONE;
> +
> +	idev = __in_dev_get_rtnl(dev);
> +	if (idev)
> +		sw_nb_v4_netdev_event(unused, event, ptr);
> +
> +#if IS_REACHABLE(CONFIG_IPV6)
> +	i6dev = __in6_dev_get(dev);
> +	if (i6dev)
> +		sw_nb_v6_netdev_event(unused, event, ptr);
> +#endif
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block sw_nb_netdev = {
> +	.notifier_call = sw_nb_netdev_event,
> +};
> +
> +int otx2_sw_nb_unregister(struct net_device *netdev)
> +{
> +	int err, ret = 0;
> +
> +	if (!otx2_sw_nb_registered)
> +		return 0;
> +
> +	err = unregister_switchdev_notifier(&sw_nb_fdb);
> +	if (err) {
> +		netdev_err(netdev, "Failed to unregister switchdev nb\n");
> +		ret = err;
> +	}
> +
> +	err = unregister_fib_notifier(&init_net, &sw_nb_fib);
> +	if (err) {
> +		netdev_err(netdev, "Failed to unregister fib nb\n");
> +		if (!ret)
> +			ret = err;
> +	}
> +
> +	err = unregister_netevent_notifier(&sw_nb_netevent);
> +	if (err) {
> +		netdev_err(netdev, "Failed to unregister netevent\n");
> +		if (!ret)
> +			ret = err;
> +	}
> +
> +	err = unregister_inetaddr_notifier(&sw_nb_v4_inetaddr);
> +	if (err) {
> +		netdev_err(netdev, "Failed to unregister addr event\n");
> +		if (!ret)
> +			ret = err;
> +	}
> +
> +#if IS_REACHABLE(CONFIG_IPV6)
> +	err = unregister_inet6addr_notifier(&sw_nb_v6_inetaddr);
> +	if (err) {
> +		netdev_err(netdev, "Failed to unregister addr event\n");
> +		if (!ret)
> +			ret = err;
> +	}
> +#endif
> +
> +	err = unregister_netdevice_notifier(&sw_nb_netdev);
> +	if (err) {
> +		netdev_err(netdev, "Failed to unregister netdev notifier\n");
> +		if (!ret)
> +			ret = err;
> +	}
> +
> +	sw_fl_deinit();
> +	otx2_sw_fib_deinit();
> +	sw_fdb_deinit();
> +
> +	sw_nb_pf_netdev = NULL;
> +	otx2_sw_nb_registered = false;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(otx2_sw_nb_unregister);
> +
> +/* Concurrent registration from multiple devlink instances cannot occur on a
> + * given RVU: only the RVU_REP netdev devlink reaches this function (see
> + * comment above). The AF and PF/VF devlinks do not call otx2_sw_nb_register(),
> + * and their eswitch_mode_set handlers return -EOPNOTSUPP. devlink core
> + * holds devlink->lock for the full DEVLINK_CMD_ESWITCH_MODE_SET handler,
> + * so two threads cannot enter here concurrently on that single rep devlink.
> + * A second call after successful registration returns -EBUSY before any
> + * notifier or workqueue state is modified.
> + */
> +int otx2_sw_nb_register(struct net_device *netdev)
>  {
> +	int err;
> +
> +	/* Notifier blocks are global and only one RVU_REP may register at a
> +	 * time (switch offload is init_net-wide; see comment at file top).
> +	 * A second RVU card gets -EBUSY here by design.  Concurrent calls on
> +	 * the same RVU_REP cannot happen: only that netdev's devlink reaches
> +	 * this function (otx2_rep_dev()), and devlink core holds
> +	 * devlink->lock for the full DEVLINK_CMD_ESWITCH_MODE_SET handler.
> +	 * No extra lock is needed to protect the notifier chains.
> +	 */
> +	if (otx2_sw_nb_registered)
> +		return -EBUSY;
> +
> +	sw_nb_pf_netdev = netdev;
> +
> +	err = sw_fdb_init();
> +	if (err)
> +		goto err_clear;
> +
> +	err = otx2_sw_fib_init();
> +	if (err)
> +		goto err_fdb;
> +
> +	err = sw_fl_init();
> +	if (err)
> +		goto err_fib;
> +
> +	err = register_switchdev_notifier(&sw_nb_fdb);
> +	if (err) {
> +		netdev_err(netdev, "Failed to register switchdev nb\n");
> +		goto err_helpers;
> +	}
> +
> +	err = register_fib_notifier(&init_net, &sw_nb_fib, NULL, NULL);
> +	if (err) {
> +		netdev_err(netdev, "Failed to register fb notifier block\n");
> +		goto err1;
> +	}
> +
> +	err = register_netevent_notifier(&sw_nb_netevent);
> +	if (err) {
> +		netdev_err(netdev, "Failed to register netevent\n");
> +		goto err2;
> +	}
> +
> +#if IS_REACHABLE(CONFIG_IPV6)
> +	err = register_inet6addr_notifier(&sw_nb_v6_inetaddr);
> +	if (err) {
> +		netdev_err(netdev, "Failed to register addr event\n");
> +		goto err3;
> +	}
> +#endif
> +
> +	err = register_inetaddr_notifier(&sw_nb_v4_inetaddr);
> +	if (err) {
> +		netdev_err(netdev, "Failed to register addr event\n");
> +		goto err4;
> +	}
> +
> +	err = register_netdevice_notifier(&sw_nb_netdev);
> +	if (err) {
> +		netdev_err(netdev, "Failed to register netdevice nb\n");
> +		goto err5;
> +	}
> +
> +	otx2_sw_nb_registered = true;
> +
>  	return 0;
> +
> +err5:
> +	unregister_inetaddr_notifier(&sw_nb_v4_inetaddr);
> +
> +err4:
> +#if IS_REACHABLE(CONFIG_IPV6)
> +	unregister_inet6addr_notifier(&sw_nb_v6_inetaddr);
> +
> +err3:
> +#endif
> +	unregister_netevent_notifier(&sw_nb_netevent);
> +
> +err2:
> +	unregister_fib_notifier(&init_net, &sw_nb_fib);
> +
> +err1:
> +	unregister_switchdev_notifier(&sw_nb_fdb);
> +
> +err_helpers:
> +	sw_fl_deinit();
> +err_fib:
> +	otx2_sw_fib_deinit();
> +err_fdb:
> +	sw_fdb_deinit();
> +err_clear:
> +	sw_nb_pf_netdev = NULL;
> +	return err;
>  }
> +EXPORT_SYMBOL(otx2_sw_nb_register);
>  
>  #endif

[Severity: High]
Is a PCI vendor ID match a strong enough filter here?  All six
notifier blocks are global (netdev, netevent, fib, inetaddr,
inet6addr, switchdev), so every netdev in init_net reaches
sw_nb_is_valid_dev() -> sw_nb_is_cavium_dev(), and the only test
performed is:

	dev = netdev->dev.parent;
	if (!dev || dev->bus != &pci_bus_type)
		return false;
	pdev = to_pci_dev(dev);
	if (pdev->vendor != PCI_VENDOR_ID_CAVIUM)
		return false;

PCI_VENDOR_ID_CAVIUM (0x177d) is not specific to RVU: liquidio,
thunder nicvf/nicpf and octeon_ep all sit behind the same vendor ID.
If any of those NICs is present in the same host, its netdev passes
the filter, sw_nb_resolve_pf_dev() happily returns it, and the new
handlers then do:

	pf = netdev_priv(pf_dev);
	entry->port_id = pf->pcifunc;

That reads struct otx2_nic fields out of an unrelated driver's
private area - pcifunc lives several hundred bytes into otx2_nic,
well past the end of, say, struct lio or struct nicvf, so this is a
plain out-of-bounds read of whatever follows that allocation.  The
same cast appears in sw_nb_v4_netdev_event(),
sw_nb_v4_inetaddr_event(), sw_nb_v4_fib_event(),
sw_nb_net_v4_neigh_update() and all four v6 counterparts.  It gets
worse later in the series, where these entries are handed to
sw_fib_add_to_list()/sw_fdb_add_to_list(), which take pf->pdev and
pf->mbox from the same bogus pointer and eventually lock
pf->mbox.lock.

sw_nb_check_slaves() inherits the same weakness for bridge and VLAN
lower devs, so a bridge containing a liquidio port would be treated
as a valid offload target too.

What is the intended way to recognise an RVU PF/VF netdev here?
Matching pdev->device against the RVU PF/VF/REP device IDs would be
a minimal fix, but comparing netdev->netdev_ops (or ethtool_ops)
against this driver's own ops table, or looking the netdev up in a
list the driver itself maintains, would make the ownership check
unambiguous.  Could you pick one that cannot alias other Cavium
drivers?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831131944.2649362-1-rkannoth%40marvell.com
