Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951492E7380;
	Sun, 11 Oct 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791708773; cv=none; b=kpoWyb3ubqiuColn4CRxwGBp2khAbQPMfuxJONOUxIR/QkG0KvW3SwJnu6KyQ3+9NFZwhoz6en+HWtmJV4k0/lAhGaf0l9Ni+k5MnuujRdFEdDo+oWdEIueXHdyyabVObkHR7OxOoH68G4onErwKvfEtTQQHPJSLs2AQGz5FHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791708773; c=relaxed/simple;
	bh=2gAU2RufrR2VibsPn3XzzwinjFYiRO/hCoD5MEP3bDg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8UVDzexg1i6/SmxUOrI5qA4gAs4d6H6x+xaR8Vw0VolgpvHz67QjVK1eEZTkIRj4PCD1W/MgSIb1UL0mNKxD9K6v4gWvFdgUQyzjYRJklu1o/sLTT/YtQ/U70R4QFRRr7+IMw3eKvLKfnmzfFaPse1yMVUHKboWW1xpShxy+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1+H5s0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1+H5s0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FE11F0089B;
	Sun, 11 Oct 2026 08:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791708772;
	bh=tShwXReFz01yr5hRSobcAxHY5yfXsyBB91ysep87c2A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F1+H5s0EcOnrPUaqk9vVnSMcWr2+Y09Z2tlMl2nW1LDfOvsZMRC8UJBo5h4bnXdpG
	 aU9/dIzY25KVs4iazvzinpokeB7Hr0YUZCrd5KW84vPk/5QVbRt/O5WoY/BeCTHSAE
	 JfOw56emEDeLPF3av2YLzZ4n6H2wx+eXJnH+N/5WF8IGFz672syIMWuz+u9wDZol7e
	 SUpjT4vH60iE9e6zMdcXzQbD5+ZyrBhpZnaHR9CNtGfeMAJyPuPtF5OnLuO8Yaj1+X
	 e5IrwzN1Fv5BPYAxbwJJNoEiZ36AsgXJlEqIbyamXRm2QaXMyDMBpigem9HotyCqhJ
	 d5NeEgcLxHvlg==
Subject:
 Re: [PATCH net v2] ncsi: Fix use-after-free in the device unregister path
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 08:52:51 +0000
Message-ID: <179170877129.434549.9347909556499699251@kernel.org>
In-Reply-To: <20261010075828.5724-1-18983559317@163.com>
References: <20261010075828.5724-1-18983559317@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After this patch, ftgmac100 removal still uses freed memory
  every time it runs with the interface up.
- [High] Switching to kfree_rcu() does not protect the NCSI netlink
  readers, yet the commit message names a concurrent netlink query as a…
- [High] ncsi_unregister_dev() never cancels the per-request timers
  embedded in ndp->requests[] before kfree(ndp).
- [High] ncsi_unregister_dev() still unlinks ndp from the global
  ncsi_dev_list with list_del_rcu(&ndp->node) (line 1969) and then frees…
- [Medium] ncsi_remove_channel() frees the channel's filter arrays at
  once, before the channel is even unlinked, and only defers freeing the…
- [Low] The commit message says candidate sites came from a Coccinelle
  rule and that the reader/writer paths were confirmed by LLM-assisted…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  ncsi_unregister_dev() never frees the vlan_vid entries that…

--

ncsi: Fix use-after-free in the device unregister path

This commit moves disable_work_sync() to the start of
ncsi_unregister_dev(), so the NCSI state machine work stops before the
packages and channels are freed. It also changes ncsi_remove_package()
and ncsi_remove_channel() to free with kfree_rcu() instead of kfree().

> Found during a static-analysis-assisted audit: candidate sites were
> surfaced by a Coccinelle rule, and the reader/writer paths were
> confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
> not observed at runtime; it is identified by code inspection only.
>
> Fixes: e6f44ed6d04d ("net/ncsi: Package and channel management")
> Signed-off-by: Binbin Deng <18983559317@163.com>

[Severity: Low]
This isn't a bug, but Documentation/process/coding-assistants.rst and
Documentation/process/submitting-patches.rst ask AI-assisted
contributions to carry a tag of the form "Assisted-by: LLM [TOOL1]
[TOOL2]".

Should the trailers include something like "Assisted-by: GLM-5.3
coccinelle"?

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..05dcd732effa2 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -263,7 +263,7 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
>  	np->channel_num--;
>  	spin_unlock_irqrestore(&np->lock, flags);
>  
> -	kfree(nc);
> +	kfree_rcu(nc, rcu_head);

[Severity: High]
The commit message gives a concurrent netlink query as one trigger. Do
any of the NCSI netlink readers actually run inside an RCU read-side
critical section?

ndp_from_ifindex() in net/ncsi/ncsi-netlink.c looks the device up
without rcu_read_lock(). It then returns ndp without holding any
reference:

	nd = ncsi_find_dev(dev);
	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;

	dev_put(dev);
	return ndp;

ncsi_pkg_info_nl(), ncsi_pkg_info_all_nl() and
ncsi_write_package_info() then walk ndp->packages and np->channels with
NCSI_FOR_EACH_PACKAGE() and NCSI_FOR_EACH_CHANNEL() in preemptible
process context. Only genl_mutex serializes them, and
ncsi_unregister_dev() doesn't take it.

A process-context walker outside rcu_read_lock() doesn't hold off a
grace period. Can this sequence still read freed memory?

CPU0 (NCSI_CMD_PKG_INFO)              CPU1
ncsi_write_package_info()
  NCSI_FOR_EACH_PACKAGE(ndp, np)
  <preempted>
                                      ncsi_unregister_dev()
                                        ncsi_remove_package()
                                          list_del_rcu(&np->node)
                                          kfree_rcu(np, rcu_head)
                                      <grace period ends>
  <resumes, reads np->id, nc->...>

NCSI_CMD_PKG_INFO has .flags = 0 in ncsi_ops, so an unprivileged user
can run the reader side.

The same applies to kfree_rcu(np, rcu_head) in ncsi_remove_package().
Do the netlink handlers need rcu_read_lock() plus a lifetime guarantee
for ndp, or a lock they share with teardown?

[Severity: Medium]
Even for a reader under RCU protection, are the channel's filter
arrays still freed too early? Earlier in ncsi_remove_channel():

	spin_lock_irqsave(&nc->lock, flags);

	/* Release filters */
	kfree(nc->mac_filter.addrs);
	kfree(nc->vlan_filter.vids);
	...
	/* Remove and free channel */
	spin_lock_irqsave(&np->lock, flags);
	list_del_rcu(&nc->node);

These arrays are freed at once, before nc is unlinked. The vids
pointer, bitmap and n_vids are left unchanged. kfree_rcu() defers only
the free of nc itself.

ncsi_write_channel_info() reads the VLAN array through nc without
nc->lock and copies it into the reply:

	while ((i = find_next_bit((void *)&ncf->bitmap, ncf->n_vids,
				  i + 1)) < ncf->n_vids) {
		if (ncf->vids[i])
			nla_put_u16(skb, NCSI_CHANNEL_ATTR_VLAN_ID,
				    ncf->vids[i]);
	}

Can this read freed vids[] when a reader is at or past nc in
NCSI_FOR_EACH_CHANNEL()? Should the arrays be freed together with nc
from an RCU callback?

>  }

[ ... ]

> @@ -1958,6 +1958,8 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  	struct ncsi_package *np, *tmp;
>  	unsigned long flags;
>  
> +	disable_work_sync(&ndp->work);
> +
>  	dev_remove_pack(&ndp->ptype);

[Severity: High]
disable_work_sync() waits for ndp->work to return. Does anything cancel
the per-request timers in ndp->requests[] before kfree(ndp)?

ncsi_xmit_cmd() arms one timer for each outstanding command:

	nr->enabled = true;
	mod_timer(&nr->timer, jiffies + 1 * HZ);

The only timer_delete_sync(&nr->timer) is in ncsi_free_request(). That
runs when a response arrives or when the timer fires. After
dev_remove_pack(), no more responses arrive to release these requests.

The channel monitor timer is stopped only later, in
ncsi_remove_channel(). Until then, ncsi_channel_monitor() can still
send a GLS command through ncsi_xmit_cmd(), which arms a new request
timer.

If one of these timers fires after kfree(ndp), ncsi_request_timeout()
does this:

	struct ncsi_dev_priv *ndp = nr->ndp;
	...
	spin_lock_irqsave(&ndp->lock, flags);

For netlink-driven requests it also walks ndp->packages through
ncsi_find_package_and_channel() before it calls ncsi_free_request().

Can this cause a use-after-free in timer softirq, with a timer_list
still pending inside the freed ndp?

>  
>  	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
> @@ -1967,8 +1969,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  	list_del_rcu(&ndp->node);
>  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
>  
> -	disable_work_sync(&ndp->work);
> -
>  	kfree(ndp);

[Severity: High]
The commit message describes the bug like this:

    list_del_rcu() removes the entry for subsequent readers, but the
    following bare kfree() is not covered by any grace period

Isn't the same pattern still here for ndp? ndp is removed from
ncsi_dev_list with list_del_rcu() and then freed right away.

ncsi_dev_list has RCU readers. ncsi_rcv_rsp() runs in RX softirq and
calls ncsi_find_dev(), which walks the whole global list:

	NCSI_FOR_EACH_DEV(ndp) {
		if (ndp->ndev.dev == dev)
			return &ndp->ndev;
	}

With two NCSI-enabled MACs, RX on device B can walk past device A's
ndp while A is being torn down. The synchronize_net() in
dev_remove_pack(&ndp->ptype) only covers A's own handler. It also runs
before list_del_rcu(&ndp->node).

ndp_from_ifindex() also passes the unreferenced ndp to the netlink
handlers.

ndp itself is freed with no grace period. Does the kfree_rcu() on the
packages and channels then help any reader that reached them through
ndp->packages?

[Severity: High]
The commit message says:

    The ordering is reachable on BMC systems: ftgmac100_remove() calls
    ncsi_unregister_dev() before unregister_netdev(), i.e. before
    ncsi_stop_dev() has stopped the state machine

With that ordering, is ndp still used after this kfree()?
ftgmac100_remove() in drivers/net/ethernet/faraday/ftgmac100.c does:

	if (priv->ndev)
		ncsi_unregister_dev(priv->ndev);
	unregister_netdev(netdev);

It doesn't clear priv->ndev. If the interface is up,
unregister_netdev() calls ftgmac100_stop() as .ndo_stop:

	if (priv->use_ncsi)
		ncsi_stop_dev(priv->ndev);

ncsi_stop_dev() then:

  - walks the freed ndp->packages;
  - calls ncsi_stop_channel_monitor(), which runs timer_delete_sync()
    on timers in freed channels;
  - calls ncsi_report_link(ndp, true), which makes an indirect call
    through nd->handler in the freed object.

The call chain is:

ftgmac100_remove()->ncsi_unregister_dev()->kfree(ndp)
ftgmac100_remove()->unregister_netdev()->...->ftgmac100_stop()
    ->ncsi_stop_dev()

The error path in ftgmac100_probe() sets priv->ndev = NULL after
ncsi_unregister_dev(), but ftgmac100_remove() does not.

This path needs no race. Does every removal with the interface up
still hit a use-after-free here?

[Severity: Low]
This isn't a bug introduced by this patch, but ncsi_unregister_dev()
never frees the entries on ndp->vlan_vids. ncsi_vlan_rx_add_vid() adds
them with list_add_rcu(), and only ncsi_vlan_rx_kill_vid() frees them.

With the ftgmac100_remove() ordering, ndp is already off ncsi_dev_list
when unregister_netdev() tears down the VLANs. So
ncsi_vlan_rx_kill_vid() returns early:

	nd = ncsi_find_dev(dev);
	if (!nd) {
		netdev_warn(dev, "NCSI: no net_device?\n");
		return 0;
	}

Does this leak the vlan_vid entry for each configured VLAN ID on
removal?

>  }
>  EXPORT_SYMBOL_GPL(ncsi_unregister_dev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010075828.5724-1-18983559317%40163.com
