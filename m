Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294773F9265
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100190; cv=none; b=BQjoDxQRK5yXq+5vwI3rmS5q5oIBfGHR1HK7CHXBIZz5K3bM9eTc4r6tuJ2CMgIEmGktvi53ZHfrfNp6cY0JEqIO4tnzDGLkzkDyHe0RnJffxI5vYKMtmvW+7u7F6XnDxhv33rwhm1J6PMCnBh8cUgaDfgU28cotnWjuizhbBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100190; c=relaxed/simple;
	bh=wemwpFs1mYJyuVOJx8nc6sN6Gb1UaW0veHUuGeHfNoE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ul5m0uh+cQBgCc3QFJ/g+JXbJoZ027y0xwtMPLqIOiVHtHpK6Z8mHDf48O5gWjYfQBnjlYNfHPsqDV6qZ1XDYg2Sk6SXHEV076qSi97FUxUl726Y9UJZ6io/wlsmTwqtBczhMLgXdJn/nQrmYHtQ+wqNjTrBHvVCYp3eGNa5Eh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv7oU9TF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv7oU9TF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C8C1F000FF;
	Tue, 22 Sep 2026 18:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790100188;
	bh=Crsx38mTHen7xJzorKNfxP88EFcin9v08rMRHsR4QDI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hv7oU9TFBngxj4M+S5YAgQIXpe7I4Wz9OwNC5UuAm2G3VwcR37rdosta+NUXQXpFt
	 l6w8V67oM6P3nGzBvJTEWTXpgRZIFKOv+Rp0OQORXMkubejXMQF465gHtnJ/jfRSsd
	 eg7Y+roTdwih3gtwEPouN+LKkKNgFvsjK96UmTnSYdI4uhvjF0YRBrjLIS9ciW1Brl
	 k383KkzKGMG6ya+l5mSTZPjl4Mg6TGLVZZi+zwy0EveCLCVOp7Gl79ESnECbwqz0T9
	 QEnp2utJITRG/ELe2/Fxur8v8Xi88Qwrg6Te3+WTBKHWB3hX+tLoi4VC2tgK0oKZCP
	 M/jx7ZPh98r0A==
Subject:
 Re: [PATCH net] net: gro_cells: prevent enabling threaded NAPI on gro_cells
From: netdev-bot+sashiko@kernel.org
To: namangulati@google.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 kuniyu@google.com, syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
Date: Tue, 22 Sep 2026 18:03:07 +0000
Message-ID: <179010018769.2160803.17947060509273769964@kernel.org>
In-Reply-To: <20260918173413.3222413-1-namangulati@google.com>
References: <20260918173413.3222413-1-namangulati@google.com>
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

- [High] NAPI_STATE_NO_THREADED is only consulted at the two uAPI entry
  points, not where threaded mode is actually turned on, so the new per-…
- [Medium] The Fixes: tag (25718fdcbdd2 "net: gro_cells: Use nested-BH
  locking for gro_cell") only covers the lockdep DEBUG_LOCKS_WARN_ON()…
- [Medium] Both new guards reject the *presence* of a threaded request
  rather than a request to *enable* threading, which silently narrows…
- [Low] The commit message states that threaded NAPI is enabled on a
  gro_cells-backed device "via sysfs or Netlink", but the Netlink path…

--

net: gro_cells: prevent enabling threaded NAPI on gro_cells

This adds a new NAPI_STATE_NO_THREADED state bit, sets it on every
per-CPU gro_cell NAPI in gro_cells_init(), and returns -EOPNOTSUPP from
the sysfs threaded attribute and from the netdev netlink napi-set
handler when the bit is present.

Closes: https://lore.kernel.org/netdev/6aad6d7b.0c43d342.320d00.0001.GAE@google.com

A couple of questions on the commit message first, then some questions
on the code.

> When threaded NAPI is enabled on a device backed by gro_cells (e.g.
> gre0, vxlan, geneve) via sysfs or Netlink, unbound kernel threads are
> created for each per-CPU NAPI.

[Severity: Low]
Is the Netlink half of this sentence reachable today?  gro_cells_init()
sets NAPI_STATE_NO_BUSY_POLL before netif_napi_add() and napi_enable(),
and napi_hash_add() bails out for such NAPIs:

net/core/dev.c:napi_hash_add() {
	if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
		return;
	...
}

So gro_cell NAPIs never enter napi_hash and keep napi_id == 0.
NETDEV_CMD_NAPI_SET requires NETDEV_A_NAPI_ID and resolves it through
netdev_napi_by_id_lock() -> napi_by_id(), which only walks napi_hash, so
netdev_nl_napi_set_doit() returns -ENOENT before
netdev_nl_napi_set_config() ever runs.

Would it be clearer to say that only the sysfs path reproduces the
reported splat and that the netlink check is a forward-looking
restriction?

> On !CONFIG_PREEMPT_RT kernels without lockdep, concurrent execution of
> __skb_queue_tail() on CPU A and __skb_dequeue() on CPU B without
> cross-CPU locks leads to silent queue corruption.
[ ... ]
> Fixes: 25718fdcbdd2 ("net: gro_cells: Use nested-BH locking for gro_cell")

[Severity: Medium]
Does the Fixes: tag match the second failure mode described above?

At the parent of 25718fdcbdd2, gro_cells_receive() called a bare
__skb_queue_tail(&cell->napi_skbs, skb) and gro_cell_poll() a bare
__skb_dequeue(&cell->napi_skbs) with no lock at all, and that commit
states it adds lockdep coverage only and does not change functional
behaviour for !PREEMPT_RT.

So the lockdep DEBUG_LOCKS_WARN_ON(l->owner) splat is new with
25718fdcbdd2, but the cross-CPU sk_buff_head access that the message
calls silent queue corruption predates it, and trees older than that
commit will not pick this up via the tag.

Would it make sense to separate the two claims in the message, or to
point the tag at the commit that first made threaded NAPI settable on
these devices?

> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index d8c0a2867120..9f8884d56f59 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c
> @@ -92,6 +92,7 @@ int gro_cells_init(struct gro_cells *gcells, struct net_device *dev)
>  		local_lock_init(&cell->bh_lock);
>  
>  		set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
> +		set_bit(NAPI_STATE_NO_THREADED, &cell->napi.state);
>  
>  		netif_napi_add(dev, &cell->napi, gro_cell_poll);
>  		napi_enable(&cell->napi);

[Severity: High]
Since the new bit is only tested in the two userspace front ends and not
in the code that actually turns threading on, can threaded mode still be
armed on these NAPIs?

The two calls right below the set_bit() do not test it.
netif_napi_add() -> netif_napi_add_weight_locked() consults
napi_get_threaded_config(), which falls back to dev->threaded when
napi->config is NULL - always the case for gro_cell NAPIs added with
netif_napi_add():

net/core/dev.c:netif_napi_add_weight_locked() {
	...
	if (napi_get_threaded_config(dev, napi))
		if (napi_kthread_create(napi))
			dev->threaded = NETDEV_NAPI_THREADED_DISABLED;
	...
}

and napi_enable_locked() then sets the bit purely from dev->threaded:

net/core/dev.c:napi_enable_locked() {
	...
		if (n->dev->threaded && n->thread)
			new |= NAPIF_STATE_THREADED;
	...
}

The in-kernel setters do not test it either: napi_set_threaded(),
netif_set_threaded(), netif_threaded_enable() and the exported
dev_set_threaded() all reach napi_set_threaded() without looking at
NAPI_STATE_NO_THREADED.

Would moving the test into napi_set_threaded() (and the per-NAPI loop of
netif_set_threaded()) make the bit self-enforcing instead of advisory?

> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 352173df7578..296fdc007862 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -743,9 +743,11 @@ static ssize_t threaded_show(struct device *dev,
>  
>  static int modify_napi_threaded(struct net_device *dev, unsigned long val)
>  {
> +	struct napi_struct *napi;
>  	int ret;
>  
> -	if (list_empty(&dev->napi_list))
> +	napi = list_first_entry_or_null(&dev->napi_list, typeof(*napi), dev_list);
> +	if (!napi || test_bit(NAPI_STATE_NO_THREADED, &napi->state))
>  		return -EOPNOTSUPP;
>  
>  	if (val != 0 && val != 1)

[Severity: Medium]
Does this change the result of writing 0 to the attribute?

The new test runs before val is inspected, so on a gro_cells-backed
netdev:

  echo 0 > /sys/class/net/gre0/threaded

now returns -EOPNOTSUPP.  Before the patch the only rejection here was
list_empty(&dev->napi_list), which is never true for a gro_cells device,
so the write reached netif_set_threaded(dev, 0) and succeeded as a
no-op.

threaded_show() still reports 0 for the same device:

net/core/net-sysfs.c:threaded_show() {
	...
	ret = sysfs_emit(buf, fmt_dec, READ_ONCE(netdev->threaded));
	...
}

so a value that can be read back can no longer be written to this RW
attribute.

The netlink side has the same ordering: the test_bit() sits before
nla_get_uint(), so NETDEV_A_NAPI_THREADED carrying "disabled" is also
refused, and the early return happens before
NETDEV_A_NAPI_DEFER_HARD_IRQS, NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT and
NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT are applied.  Since napi-get always
emits threaded via nla_put_uint() in netdev_nl_napi_fill_one(), a
get-modify-set round trip would apply none of the other requested
settings.

Should both checks be gated on the requested value being enabled, so
that disabling threading keeps working and the other attributes in the
same request are still honoured?

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index cb18db681640..661f87e2f015 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -334,6 +334,9 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
>  	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
>  		int ret;
>  
> +		if (test_bit(NAPI_STATE_NO_THREADED, &napi->state))
> +			return -EOPNOTSUPP;
> +
>  		threaded = nla_get_uint(info->attrs[NETDEV_A_NAPI_THREADED]);
>  		ret = napi_set_threaded(napi, threaded);
>  		if (ret)

One more question on the sysfs guard: modify_napi_threaded() only tests
the first entry of dev->napi_list, while the operation it gates,
netif_set_threaded(), walks the whole list and also stamps every
napi_config entry:

net/core/dev.c:netif_set_threaded() {
	...
	list_for_each_entry(napi, &dev->napi_list, dev_list)
		WARN_ON_ONCE(napi_set_threaded(napi, threaded));

	/* Override the config for all NAPIs even if currently not listed */
	for (i = 0; i < dev->num_napi_configs; i++)
		dev->napi_config[i].threaded = threaded;
}

netif_napi_dev_list_add() orders entries by napi_id, and a config-less
NAPI gets new_id = UINT_MAX, so it lands at the head:

net/core/dev.c:netif_napi_dev_list_add() {
	new_id = UINT_MAX;
	if (napi->config && napi->config->napi_id)
		new_id = napi->config->napi_id;
	...
		if (pos_id <= new_id)
			break;
	...
}

If a device registers such a NAPI after gro_cells_init(), does the guard
then pass while every gro_cell NAPI still gets NAPIF_STATE_THREADED?
And in the other direction, does a gro_cell NAPI at the head refuse
threading for a device's real NAPIs?  I did not find an in-tree
gro_cells user that registers an extra NAPI today, so this looks latent
rather than immediately triggerable.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918173413.3222413-1-namangulati%40google.com
