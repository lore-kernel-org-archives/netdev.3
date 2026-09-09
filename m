Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B48559C9A;
	Wed,  9 Sep 2026 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966977; cv=none; b=oxPsWrCdU/1RHHsCqbyQWyuE4V3RjNyZm1IPeZzo5SUCjWSb39XkIy+UWGGAtKtCpSGNa3PyMd3xPfIegrqzbw19bTy7jMJR+kIRlOKcA1omw6BVC/Bt4BRtcCW0OCMNqJLMnhJgPOTdrod1b+LusLcIv88ScEfwiRjQrMfiB3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966977; c=relaxed/simple;
	bh=Hqt8pMrgScs9o/prDc54Qc+QqwDXpPYCAVpK5lWOIu8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D4RZns17IHnBY0FjKXLlQRnr/wnCNB3jlT0+nemBnrI7gGLI3gDrZn4qTa7dFauNnswQetgk8fx8EVbjguwx3DrAkHGUuBpLW1qzg+Nsgq7oOzQHPiODh7lfVwkwjySt6ry+UZup+v66P1Dq28BEqjZ9A2SKfXinWIwrrqZB/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLihS9Tr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLihS9Tr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3921F00A3E;
	Wed,  9 Sep 2026 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966975;
	bh=heYJUaP2q9Wh6AOZ0OFZIFgHVrN6J+Ev5xJ9qbx5sPs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hLihS9Tre7WwCy/ceiOWfRy4i9dzgB/gL2dIQRfd3VKULqanNNdms8rjSJ+BVSA5e
	 HbL0JZAt+l5i1OWpSwPBS1oDHU2pJPBdZYLp60EMNFFVb/WhR8SWbhUzYPeT5YfsEJ
	 kqxp8vTkUpFK1XQBCEyWGHYdLfvw9pHqt3MtGKj7kP+iEQ1typYIbI+dwjfEG+bDBZ
	 kuFy5V2lIAjkGc2L0hIo4viEX6j6xoSm/d4AMsdlao2w1SV8e9sRByFenyWukBCjZI
	 8WZXFn41vW19VqkZTqHSl1QSRRyrXoScYk75V+iQeHfYjEeNZ3OWa+bP+fnMBSshmZ
	 zHSQpmWSaiC2w==
Subject: Re: [PATCH net-next v3 3/6] net: dsa: motorcomm: Split MIB module
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 15:16:14 +0000
Message-ID: <178896697478.219967.17798090601969318390@kernel.org>
In-Reply-To: <20260906131414.2683362-4-mmyangfl@gmail.com>
References: <20260906131414.2683362-4-mmyangfl@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

- [Medium] MIB polling work is permanently disabled by
  `yt921x_dsa_port_teardown()`…

Pre-existing issues:
- [Medium] Unsynchronized access to the cached 64-bit MIB counters: at
  this commit `yt921x_mib_read()` (drivers/net/dsa/motorcomm/mib.c)…
- [Medium] Non-atomic read of the 64-bit MIB counter register pairs: for
  descriptors with `size == 2` (RX_GOOD_BYTES 0x3c/0x40, RX_BAD_BYTES…

--

net: dsa: motorcomm: Split MIB module

This moves the yt921x MIB descriptor table, register definitions, stats
structures and all of the ethtool/stats64 callbacks out of chip.c and
chip.h into new mib.c and mib.h files, in preparation for yt922x using a
different MIB scheme. The change is described as pure code motion.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> new file mode 100644
> index 0000000000000..b1296f224cf69
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/mib.c
> @@ -0,0 +1,408 @@

[ ... ]

> +/* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
> +static int yt921x_mib_read(struct yt921x_priv *priv, int port)
> +{

[ ... ]

> +	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> +		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
> +		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
> +		u64 *valp = &((u64 *)mib)[i];
> +		u32 val0;
> +		u64 val;
> +
> +		res = yt921x_reg_read(priv, reg, &val0);
> +		if (res)
> +			break;
> +
> +		if (desc->size <= 1) {
> +			u64 old_val = *valp;
> +
> +			val = (old_val & ~(u64)U32_MAX) | val0;
> +			if (val < old_val)
> +				val += 1ull << 32;
> +		} else {
> +			u32 val1;
> +
> +			res = yt921x_reg_read(priv, reg + 4, &val1);
> +			if (res)
> +				break;
> +			val = ((u64)val1 << 32) | val0;
> +		}

[Severity: Medium]
This is a pre-existing issue carried over by the move, not something this
patch introduces, but can the size == 2 path assemble a torn value?

The two halves come from two independent SMI/MDIO transactions:

	res = yt921x_reg_read(priv, reg, &val0);
	...
	res = yt921x_reg_read(priv, reg + 4, &val1);
	...
	val = ((u64)val1 << 32) | val0;

If the low word wraps between the two reads, the combined value is off by
2^32.  Unlike the size <= 1 branch there is no wraparound correction here,
so the affected counters (RX_GOOD_BYTES, RX_BAD_BYTES, TX_GOOD_BYTES) can
step backwards by about 4 GiB, and stats64 rx_bytes/tx_bytes can underflow
once ETH_FCS_LEN * packets is subtracted.

At 1 Gbps the low word of a byte counter wraps roughly every 34 seconds,
while each register access over MDIO takes tens of microseconds, so the
window is reachable in practice.

For traceability: a later commit in this series, "net: dsa: motorcomm: Use
safe 64-bit counter reader", replaces this open-coded pair read with
yt921x_counter_read() in smi.c, which reads lo, then re-reads hi/lo and
accepts the value only when lo >= old_lo (bounded to 16 attempts,
-ETIMEDOUT otherwise).

> +
> +		WRITE_ONCE(*valp, val);
> +	}
> +
> +	pm->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
> +			mib->rx_128_255byte + mib->rx_256_511byte +
> +			mib->rx_512_1023byte + mib->rx_1024_1518byte +
> +			mib->rx_jumbo;
> +	pm->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
> +			mib->tx_128_255byte + mib->tx_256_511byte +
> +			mib->tx_512_1023byte + mib->tx_1024_1518byte +
> +			mib->tx_jumbo;

[ ... ]

> +void yt921x_mib_poll(struct work_struct *work)
> +{
> +	struct yt921x_mib *pm = container_of_const(work, struct yt921x_mib,
> +						   work.work);

[ ... ]

> +	schedule_delayed_work(&pm->work, delay);
> +}

[Severity: Medium]
Now that yt921x_mib_poll() lives here, is the work item's disable count
ever balanced for a re-used struct yt921x_mib?

In chip.c, yt921x_dsa_port_teardown() does:

	if (pm)
		disable_delayed_work_sync(&pm->work);

which is __cancel_work_sync(&dwork->work, WORK_CANCEL_DELAYED |
WORK_CANCEL_DISABLE), so the disable count stays in work->data until a
matching enable_delayed_work().

On a later setup, yt921x_dsa_port_setup() only re-initialises the work when
the allocation is fresh:

	if (!pm && (BIT(port) & (priv->info->internal_mask |
		    priv->info->external_mask))) {
		pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
		...
		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
	}

pp->mib is a devm allocation that survives a DSA tree teardown/setup cycle,
so pm is non-NULL the second time and neither INIT_DELAYED_WORK() nor
enable_delayed_work() runs.

The teardown callback is reached on ordinary port teardown, not just device
removal: dsa_port_devlink_teardown() calls ds->ops->port_teardown, and
dsa_switch_remove() tears down the whole tree, so a surviving switch's
ports get torn down while its pp->mib stays alive.  A later
dsa_tree_setup() then calls port_setup again on that switch.

After that, the schedule_delayed_work(&pm->work, 0) in
yt921x_phylink_mac_link_up() is silently dropped by
clear_pending_if_disabled(), so MIB polling never resumes for the port and
the 32-bit wraparound accumulation in yt921x_mib_read() stops happening.

Would cancel_delayed_work_sync() in port_teardown, or a matching
enable_delayed_work() in yt921x_dsa_port_setup(), be more appropriate for a
re-usable object?

[ ... ]

> +void
> +yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
> +		       struct rtnl_link_stats64 *stats)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct yt921x_port *pp = &priv->ports[port];
> +	struct yt921x_mib *pm = pp->mib;
> +	struct yt921x_mib_stats *mib;
> +
> +	if (!pm)
> +		return;
> +	mib = &pm->stats;

[ ... ]

> +	stats->rx_packets = pm->rx_frames;
> +	stats->tx_packets = pm->tx_frames;
> +	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
> +	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;

[Severity: Medium]
This isn't a bug introduced by this patch, but how are these cached 64-bit
counters synchronized against the poll worker?

yt921x_mib_read() writes each counter with WRITE_ONCE() on a plain u64 and
stores pm->rx_frames / pm->tx_frames with plain assignments while holding
priv->reg_lock.  yt921x_dsa_get_stats64() reads all of them with no lock at
all, and the other callbacks release the lock before copying out, e.g.:

	mutex_lock(&priv->reg_lock);
	yt921x_mib_read(priv, port);
	mutex_unlock(&priv->reg_lock);

	mac_stats->FramesTransmittedOK = pm->tx_frames;

and in yt921x_dsa_get_pause_stats():

	mutex_unlock(&priv->reg_lock);

	pause_stats->tx_pause_frames = mib->tx_pause;

On 32-bit builds a u64 store is two stores, so a reader can observe
mismatched halves, and derived values can mix fields from different
snapshots.  Can rx_bytes underflow when rx_good_bytes comes from an older
snapshot than rx_frames?

For traceability: later commits in this series, "net: dsa: motorcomm: Use
u64_stats_t for MIB stats" and "net: dsa: motorcomm: Fix MIB
synchronization", convert the counters to u64_stats_t, wrap the write-back
in u64_stats_update_begin()/u64_stats_update_end(), add a
u64_stats_fetch_begin()/u64_stats_fetch_retry() loop in
yt921x_dsa_get_stats64(), and move the remaining field copies inside the
reg_lock section.

> diff --git a/drivers/net/dsa/motorcomm/mib.h b/drivers/net/dsa/motorcomm/mib.h
> new file mode 100644
> index 0000000000000..cfad0665baaea
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/mib.h
> @@ -0,0 +1,159 @@

[ ... ]

> +struct yt921x_mib_stats {
> +	u64 rx_broadcast;
> +	u64 rx_pause;

[ ... ]

> +struct yt921x_mib {
> +	struct yt921x_port *port;
> +
> +	struct delayed_work work;
> +	struct yt921x_mib_stats stats;
> +	u64 rx_frames;
> +	u64 tx_frames;
> +};

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906131414.2683362-1-mmyangfl%40gmail.com
