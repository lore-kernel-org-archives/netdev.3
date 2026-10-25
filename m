Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949522;
	b=YcVPlImyWToOhcAuj8D2igthlySBVm7TVHmJhmaR56gRqGlRbZ7+GZWPH38sViZtB8G8
	 2kWPNYWVTa5HTCOT7WDcJ9U7woTUGaoZmyMFG0YQzVDV5qYfPAkcMLhz0f5vOumPLQIq7
	 bd/clU4Fnhcc1CLyDElFo0iOp3HTgkF75rZ+phX0LQwbOKRQrnzYpRbxkQYhMZXsC0cX2
	 442IXVzDORkU2+aOGHPqG14uBTDFXTCzFUCwUoKrCRaAoJhTkJ3H9rYuVd0tkhPi4PG0X
	 c0A5Pqma190XpvEnz4Z53nq2lnvjJxpIowyYyPb72C23x6FagzxTd00PFam5GRNFD9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949522;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5L6kzLQOGVMgTtlJiH4iYz/6kCVz0ZcYrdnOvzrMyAU=;
	b=RjgNsfVn+dvguk4V8ZdDYoX2iOiQellTgVVXXLZAaWF0WD3AZjtyD5x2fl3iF87nDfbJ
	 Njmf0Lb7Wf0kvnqXx+7XfTcmPlMek3WUBFD1CPaLR1FAenYIhmEIVldruN0QMnyxINu/X
	 IRH1HouHT40s4wIYlawqWYQ87G1Rjsd6Z4eZgaNH4qEanG4Rnt+vD7RDHgu/yFlgQpQCw
	 GVYgJJgglLhjmR1FvKBbk7s4u3lVdVbC4kgf2DELcPM+RRcu0FXgFQwg9vKW6t/U+jk6B
	 lObwoy7R7XZ6GpiDmBcc86gVMrlEAAZSZszYIPA0iJPfm681xtDqKJ7OP5f0DYLz3lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWigPjKz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E2606A326
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWigPjKz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC4E1F031E1;
	Sun, 25 Oct 2026 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792949521;
	bh=5L6kzLQOGVMgTtlJiH4iYz/6kCVz0ZcYrdnOvzrMyAU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZWigPjKzScUQdcGfKkKtQMX09JM3q7gFn/tQwWhNGLjQfzGMX2benw7kAeYVIKJ5l
	 g8NskabuuR+LYq8R4NhUVMjBBGLlyuy38mzGxWkeosyjG0aZBDye1jDleclVEyMKqP
	 7S1tNkYBfAhfbyMeYkbWrIdUJPHJKCIWteuYJyjbqOXidpzqzqnD0uzAh9SdU0PYmo
	 coiBT/v3cnEuj5SRQvOp1OQuVad7+X9x9PzJniXBKSSKVUpLDMBvR94gdnQ5G4hbHP
	 ePMwbkwzbIZrCw9nIimW7Rg18drFcUQj0HIr2VJhP5M9LdFb2+qONf34sMTc2RxVIe
	 cQ5stldiVmSkA==
Subject:
 Re: [PATCH net] net: xps: bound the cleanup loop by the old map's num_tc
From: netdev-bot+sashiko@kernel.org
To: phx0fer@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Date: Sun, 25 Oct 2026 17:32:00 +0000
Message-ID: <179294952071.3134.18316640480877653854@kernel.org>
In-Reply-To: <20261021155538.67867-1-phx0fer@gmail.com>
References: <20261021155538.67867-1-phx0fer@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message names the wrong trigger.
- [Low] The commit message understates the impact and does not mention a
  second behaviour change in the same line.

--

net: xps: bound the cleanup loop by the old map's num_tc

This commit changes the old-map cleanup loop in __netif_set_xps_queue().
The per-row trip count now comes from dev_maps->num_tc instead of the new
num_tc. Before the change, the trip count and the row stride could disagree
when dev->num_tc changed while an old XPS map was still installed.

> Triggering conditions
> ---------------------
> CAP_NET_ADMIN to set the XPS mask.  dev->num_tc is raised in-tree by the
> drivers that implement ndo_setup_tc (the Intel i40e/ice/ixgbe/iavf, mlx5
> and mvneta families, among others) and by the mqprio/taprio qdiscs.  The
> QEMU guest used for the reproducer has no such NIC, so the num_tc change
> was driven through a small module; the defect itself is reached in-tree
> on that hardware.

[Severity: Medium]
Can the drivers and qdiscs named here reach this loop with a stale map?

As far as I can tell, they all change num_tc through netdev_set_num_tc()
or netdev_reset_tc(). Both of those reset XPS on the whole device first:

net/core/dev.c:netdev_set_num_tc() {
    ...
#ifdef CONFIG_XPS
	netif_reset_xps_queues_gt(dev, 0);
#endif
	netdev_unbind_all_sb_channels(dev);

	WRITE_ONCE(dev->num_tc, num_tc);
    ...
}

Removing every tx queue leaves the map inactive. clean_xps_maps() then
calls reset_xps_maps(), which sets dev->xps_maps[type] to NULL. The next
__netif_set_xps_queue() sees dev_maps == NULL and takes:

	if (!dev_maps)
		goto out_no_old_maps;

So it never enters the loop this patch changes.

The in-tree paths that do seem to raise num_tc with an old map still
installed are the sfc Falcon and Siena drivers. ef4_setup_tc() and
efx_siena_setup_tc() write num_tc directly:

drivers/net/ethernet/sfc/siena/tx.c:efx_siena_setup_tc() {
    ...
	WRITE_ONCE(net_dev->num_tc, num_tc);

	return netif_set_real_num_tx_queues(net_dev,
					    max_t(int, num_tc, 1) *
					    efx->n_tx_channels);
}

netif_set_real_num_tx_queues() only resets XPS when the queue count
shrinks:

		if (disabling) {
			synchronize_net();
			qdisc_reset_all_tx_gt(dev, txq);
#ifdef CONFIG_XPS
			netif_reset_xps_queues_gt(dev, txq);
#endif
		}

For example, going from num_tc 0 to 2 leaves a live map with
dev_maps->num_tc == 1. The next XPS write then uses a trip count of 2 with
a stride of 1, and the last row overruns attr_map[].

netif_setup_tc() also writes num_tc = 0 without a full reset, but that is
the shrink direction.

Subordinate-device maps are reset using sb_dev->num_tx_queues as the
count. A macvlan offload (sb_dev) path, for example on ixgbe, might also
leave a stale map behind. That would work differently from what is
described here for the main device.

Could the trigger description be updated to name the sfc Falcon/Siena
paths? This also applies to the claim in the reproducer notes that the
module raises num_tc "the same way an in-tree driver does". Otherwise
stable and security triage will be pointed at hardware where the
described trigger does not seem to fire.

> The loop frees entries in dev_maps, so both the trip count and the stride
> must come from dev_maps->num_tc.  The map is sized
> XPS_CPU_DEV_MAPS_SIZE(old num_tc)/XPS_RXQ_DEV_MAPS_SIZE(old num_tc, ...),
> so iterating the new (larger) num_tc reads past the end.

[Severity: Low]
Is "reads past the end" the full impact here? In the old loop body, each
slot visited is dereferenced, cleared and freed:

			RCU_INIT_POINTER(dev_maps->attr_map[tci], NULL);
			kfree_rcu(map, rcu);

copy is always false when num_tc != dev_maps->num_tc, so the
map == new_map skip never applies. Suppose an out-of-bounds slot holds a
non-NULL value. The old code then writes NULL past the end of
attr_map[]. kfree_rcu() also writes an rcu_head into whatever that
pointer points to, and frees it later.

When the neighbouring slab data is non-zero, that is an out-of-bounds
write plus a free of an arbitrary pointer, not only a read.

The patch also changes behaviour in the other direction, where the new
num_tc is smaller than dev_maps->num_tc. The old loop only visited the
first num_tc slots of each old row, so the xps_map objects in the
remaining slots were never freed.

The later "removes tx-queue from unused" loop walks the new map with
old_dev_maps passed as NULL. kfree_rcu(old_dev_maps, rcu) only frees the
container, so those xps_map objects leaked.

One way to reach this is mqprio in software mode with TC offsets that are
not in ascending order. mqprio_validate_queue_counts() only rejects
overlap, so TC0 can sit at a higher offset than TC1.

Shrinking the channel count then makes netif_setup_tc() set num_tc = 0.
Meanwhile netif_reset_xps_queues_gt(dev, txq) leaves the lower-indexed
TC1 queues mapped.

Would it make sense for the commit message to say that this also fixes a
leak of xps_map objects, and that the overrun includes a write and a free?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021155538.67867-1-phx0fer%40gmail.com
