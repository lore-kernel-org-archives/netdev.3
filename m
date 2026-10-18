Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A0618859B;
	Sun, 18 Oct 2026 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289139; cv=none; b=Gq31sQ85SMIZJV5IQTeyPdyn6h/hb8xUXB5KkzzWG/9CYRNDiUc1LqdS2VzQEoATm0VMEttijmHrfGVHM0XR7b5vr9NM2cXU9kgROe/hLI7wHPbnGkcfffxY6UVQYPBifU87Epf2/xAbwguwz9kea7njMNGchn3KILl1KkSgs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289139; c=relaxed/simple;
	bh=gJtMRRn6kUCo0qsvTSD5G8hd8iqHkT+V2XNuQqER60E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dKcIUvQH8r7BfrQDPySZK+yOn1/T2lFcaWPBFuD1UAC9Gqfjd+2UrHFtC6XWmNQ0kQwJ2rUQ8xRvCaXnzSuuTB8GQvxDiYXt/iqCEPm0v45vT+31PWieLE3ZY185E5c5Nn1swYSGLLCEm2c8UfBKciKR0Ti1mhlWp0EwLPTw970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkk8ziho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkk8ziho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1D81F000C4;
	Sun, 18 Oct 2026 02:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792289138;
	bh=AwH/qJEEpOKdNZ/3RrGAFOIbCIy4tdi4JbgbAzbvt5U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xkk8zihoAbHxCOWcJyr32o0N+MJud5Y/H//NoLr+73B7G/wyuJaxbcFI4swtrUDqw
	 cdRBxgQJ4iJvYjFQzZmoMW+CsJcW7MN2x4cxRtN0i2hFZ6e09I/MZpDwuW33+z4QpT
	 Mp5yPSpMmb3EU0NZWHyv7Mv4s+64do572mkHMNBZWzS5QfGTY5hEF7zM23DUuDuqpX
	 oDei0NUzFzFTGEx257nzSwFNsd4lHXNAB0FgCobHwN1MF462zo2XBYztAnKv7t/VmG
	 1syvUlnY9lyKgVE48BTiyseAQT3wVj1udmthpcgtXZoFKMINhR6Nj4nKtFKLwX2UW0
	 3/0Tv4J5W+SYg==
Subject: Re: [PATCH net v1] net/ncsi: fix use-after-free of ncsi_package in
 ncsi_remove_package()
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 gwshan@linux.vnet.ibm.com, joel@jms.id.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 02:05:36 +0000
Message-ID: <179228913696.3135.535763886243394814@kernel.org>
In-Reply-To: <20261017012431.413648-1-18983559317@163.com>
References: <20261017012431.413648-1-18983559317@163.com>
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

Critical: 0 · High: 3 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] kfree_rcu() only delays the free of np until existing RCU read-
  side critical sections end, and none of the NCSI netlink walkers of…
- [High] The child channels of the package this patch keeps alive are
  still freed with no grace period.
- [High] The netlink readers hold no reference to the parent struct
  ncsi_dev_priv, and the same teardown frees it immediately.
- [Low] The commit message describes the reader code inaccurately: - It
  says the walker does 'nla_put_u8(NCSI_PKG_ATTR_ID, np->id)'.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  ncsi_unregister_dev() frees every package and channel (net/ncsi/ncsi-…

--

net/ncsi: fix use-after-free of ncsi_package in ncsi_remove_package()

This patch adds an rcu_head to struct ncsi_package. It also changes
ncsi_remove_package() to free the package with kfree_rcu() instead of
kfree(). The aim is to stop the generic netlink package info walkers
from reading a freed package when they race with device teardown.

> ncsi_remove_package() unlinks the package from ndp->packages with
> list_del_rcu() and immediately kfree()s it, after having released all
> of its channels the same way.  As with the channels, the generic
> netlink package info walkers iterate ndp->packages with
> list_for_each_entry_rcu() and dereference the package in the loop body
> (nla_put_u8(NCSI_PKG_ATTR_ID, np->id), np->multi_channel,
> np->channels, ...), so an immediate kfree() turns a mid-walk reader
> into a use-after-free the moment a teardown overlaps it.

[Severity: Low]
Is this description of the reader accurate? ncsi_write_package_info() in
net/ncsi/ncsi-netlink.c writes the package ID with nla_put_u32():

	rc = nla_put_u32(skb, NCSI_PKG_ATTR_ID, np->id);

It also never reads np->multi_channel. Only the set/clear interface
handlers write that field.

> Free the package with kfree_rcu() so that it survives the grace period
> the readers rely on.

None of the NCSI netlink readers hold rcu_read_lock(), so do they rely on
a grace period at all? Could the commit message be updated to match the
code?

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..76b2cb9efe4f7 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -326,7 +326,7 @@ void ncsi_remove_package(struct ncsi_package *np)
>  	ndp->package_num--;
>  	spin_unlock_irqrestore(&ndp->lock, flags);
>  
> -	kfree(np);
> +	kfree_rcu(np, rcu);

[Severity: High]
Does kfree_rcu() actually protect the netlink readers here? It only waits
for RCU read-side critical sections that already exist. The walkers in
net/ncsi/ncsi-netlink.c don't seem to enter one:

ncsi_pkg_info_nl()
  ncsi_write_package_info()
    NCSI_FOR_EACH_PACKAGE(ndp, np) {
        if (np->id != id)
        ...
        NCSI_FOR_EACH_CHANNEL(np, nc) {

NCSI_FOR_EACH_PACKAGE() expands to list_for_each_entry_rcu(), but nothing
calls rcu_read_lock() around it. Genl doit and dumpit handlers run under
genl_mutex or cb_mutex, not RCU, and ncsi_unregister_dev() takes neither.

The same pattern shows up in other handlers:

  - ncsi_pkg_info_all_nl() keeps package after the walk and dereferences
    package->id later.
  - ncsi_set_interface_nl(), ncsi_clear_interface_nl() and
    ncsi_set_channel_mask_nl() write multi_channel, channel_whitelist and
    preferred_channel on the package they find.

The testing used a CONFIG_PREEMPT kernel. On such a kernel, a reader that
is preempted mid-walk outside rcu_read_lock() reports a quiescent state.
Can the grace period then finish and kfree(np) run while the reader is
still using np->id and np->channels?

The NCSI_CMD_PKG_INFO op has no GENL_ADMIN_PERM. An unprivileged user can
therefore run the reader while root runs rmmod ftgmac100.

Do the walkers need rcu_read_lock(), or some other serialization against
ncsi_unregister_dev(), to close this race?

[Severity: High]
The package now gets a grace period, but what about its channels? Before
it gets here, ncsi_remove_package() calls ncsi_remove_channel() on each
channel, and that still frees everything immediately:

net/ncsi/ncsi-manage.c:ncsi_remove_channel() {
	spin_lock_irqsave(&nc->lock, flags);

	/* Release filters */
	kfree(nc->mac_filter.addrs);
	kfree(nc->vlan_filter.vids);
	...
	list_del_rcu(&nc->node);
	np->channel_num--;
	spin_unlock_irqrestore(&np->lock, flags);

	kfree(nc);
}

The filter arrays are freed while nc is still linked on np->channels.
nc itself is then freed with no grace period.

The walker named in the commit message reads both without nc->lock or
RCU:

net/ncsi/ncsi-netlink.c:ncsi_write_channel_info() {
	...
	nla_put_u32(skb, NCSI_CHANNEL_ATTR_ID, nc->id);
	...
	if (nc == nc->package->preferred_channel)
	...
		if (ncf->vids[i])
			nla_put_u16(skb, NCSI_CHANNEL_ATTR_VLAN_ID,
				    ncf->vids[i]);
	...
}

Say a PKG_INFO reader on one CPU is inside NCSI_FOR_EACH_CHANNEL(np, nc).
At the same time another CPU runs
ncsi_unregister_dev()->ncsi_remove_package()->ncsi_remove_channel().

Can the reader then access the freed vids[] array, or the freed nc and
nc->node.next? This doesn't depend on preemption, because channels get no
grace period at all.

struct ncsi_channel has no rcu_head. Also, switching nc to kfree_rcu()
alone would still leave the vids and addrs arrays freed immediately.

[Severity: High]
Is the parent struct ncsi_dev_priv open to the same race? The readers get
ndp from ndp_from_ifindex(), which drops the netdev reference and returns
ndp without pinning it:

net/ncsi/ncsi-netlink.c:ndp_from_ifindex() {
	...
	nd = ncsi_find_dev(dev);
	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;

	dev_put(dev);
	return ndp;
}

The same teardown then frees ndp with no grace period:

net/ncsi/ncsi-manage.c:ncsi_unregister_dev() {
	...
	list_del_rcu(&ndp->node);
	spin_unlock_irqrestore(&ncsi_dev_lock, flags);

	disable_work_sync(&ndp->work);

	kfree(ndp);
}

ftgmac100_remove() calls ncsi_unregister_dev() before unregister_netdev(),
so dev_get_by_index() keeps succeeding during teardown.

In ncsi_pkg_info_nl(), the call to genlmsg_new(NLMSG_DEFAULT_SIZE,
GFP_KERNEL) sits between ndp_from_ifindex() and ncsi_write_package_info(),
and it can sleep.

Could ndp be freed during that window? ncsi_write_package_info() would
then read ndp->package_num, walk ndp->packages and read
ndp->package_whitelist from freed memory. This window exists even on
non-preemptible kernels.

[Severity: High]
This isn't a bug introduced by this patch, but ncsi_unregister_dev()
frees all packages and channels before it stops the work item:

net/ncsi/ncsi-manage.c:ncsi_unregister_dev() {
	...
	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
		ncsi_remove_package(np);
	...
	disable_work_sync(&ndp->work);
	...
}

ncsi_dev_work() can still be queued or running at that point. Response
handlers, request timeout timers and ncsi_reset_dev() all schedule it.
ftgmac100_remove() can also call ncsi_unregister_dev() while the interface
is still up.

The work dispatches to ncsi_configure_channel() and ncsi_suspend_channel().
Both load the active package and channel:

	np = ndp->active_package;
	nc = ndp->active_channel;

They then use np->id, nc->id and other channel state.

The work item isn't an RCU reader, and nothing serializes it against
ncsi_remove_package() or ncsi_remove_channel(). Can it use a package or
channel that was just freed? kfree_rcu(np) wouldn't help here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017012431.413648-1-18983559317%40163.com
