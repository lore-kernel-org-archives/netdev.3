Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6E568529;
	Wed,  9 Sep 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966979; cv=none; b=SPlKkbB52aBBS//k4XW2AC1mczP6/knzLiSmU7GVYOCE8uMrzUy6DYPYbfbycep/7hFatgyE840uTxTJ9Ln2AuyGwcGqVBRInwtQ8Y4G7GRebMvUX1rIMA4018iBaEjMWusB/pKlijfUgroisaa2+t9r+yuZjh5sd6OsJ6jRQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966979; c=relaxed/simple;
	bh=1oNlO/pdxVnZK3WO1ugqPI7O8C8gRCX5Uugg4zRWOrY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gAQvyV3L6ZeMDRihZALacn8WdPPws/qavDueFYpekSfBFVGH0M2s4b4O0hGhwWk1WrP0azJKPFGDaFPRVJvxGJxLnS7il2oB0ZiUk8KewjOZSLqZ34OR21NOa9ZkejrZLcuD0jT5es7SBJ0IxQONGmI3wqm3lwMLJfIEjKiuDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/dBQe/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/dBQe/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4C51F00A3A;
	Wed,  9 Sep 2026 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966977;
	bh=RYCj0qVi0KRXRmjzBIgWLJbkPgDul1mC0C/ixzHQEA8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D/dBQe/6ZgUi2lyh2XvcW5Yd4FfTTF5D1RKtjeQV+/l5Oqz6yDlrA3iQ/6reu5nsT
	 xduFUjSVJL8bPzYoaBFN8MVZXtAHaQT2sIgLZ+X1xu6SbrLuPe4f7hy4OGTcPL6PL3
	 /NSI6JqoMX+K2YRf2vavgET35uQAfKwsYVoepeR5Cs5Oa2ucJNQEV4KmQ7jaiHqMJB
	 QteZ+FVhgVyiSwg5wXcu3hXB4L62FBi/ZPx6wA6WiCMlaqBIJkcsN/PjYzZZrB6V8R
	 SwKKo1z2E9WSvPNIgX4p6ZgjLXHFJIZpFVl5U2pFMgU9GKfXpVyjTTwxfdbXKIzDQB
	 MeRyYKX5Wzx6g==
Subject:
 Re: [PATCH net-next v3 5/6] net: dsa: motorcomm: Fix MIB synchronization
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 15:16:17 +0000
Message-ID: <178896697703.219967.8447526738608779891@kernel.org>
In-Reply-To: <20260906131414.2683362-6-mmyangfl@gmail.com>
References: <20260906131414.2683362-6-mmyangfl@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 (2) · Low: 1 (1)

- [High] u64_stats_sync write side in yt921x_mib_read() runs with
  preemption enabled.
- [Medium] Per-port MIB delayed work is permanently disabled after a port
  teardown/setup cycle.
- [Medium] The commit fixes a real data-race/tearing defect in already-
  merged driver code (the unsynchronized 64-bit MIB accessors and…
- [Low] The layout invariant tying yt921x_mib_descs[] to the u64_stats_t
  fields of struct yt921x_mib_stats is documented against the wrong…

Pre-existing issues:
- [Medium] In yt921x_dsa_get_rmon_stats() the ethtool RMON field
  `fragments` is filled from the alignment-error counter instead of the…
- [Medium] yt921x_chip_setup() unconditionally zeroes all hardware MIB
  counters (drivers/net/dsa/motorcomm/chip.c:4203, YT921X_MIB_CTRL_CLEAN…
- [Low] At the reviewed commit, the 64-bit MIB counters (RX_GOOD_BYTES
  0x3c/0x40, RX_BAD_BYTES 0x44/0x48, TX_GOOD_BYTES 0x84/0x88 — the…

--

net: dsa: motorcomm: Fix MIB synchronization

This converts the yt921x MIB accounting to u64_stats_sync for the
.get_stats64() path and extends priv->reg_lock coverage over the other
statistics callbacks.  A new per-port u64 data[] buffer collects register
reads so the counters can be published in one short write section.

(no Link: tags in the commit header)

> net: dsa: motorcomm: Fix MIB synchronization
>
> The previous MIB sync was based on the false assumption that 64-bit
> variables are always atomic. To fix that:

[Severity: Medium]
Should this carry a Fixes: tag?  The unsynchronized 64-bit MIB accessors
and .get_stats64() came in with 186623f4aa724c ("net: dsa: yt921x: Add
support for Motorcomm YT921x"), so this is a fix to already-merged driver
code.

Related to that, the fix does not look self-contained: the counter type
conversion lives in the preceding patch "net: dsa: motorcomm: Use
u64_stats_t for MIB stats", whose changelog says "u64_stats_sync will be
equipped in the next commit", and this commit also builds on "Rename MIB
stuffs", "Split MIB buffers" and "Split MIB module".

Since neither commit alone closes the tearing window, how would a stable
backport of this fix be done without pulling in the whole refactor series?

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index e9730b9f8c629..392bf44d409e0 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -3778,6 +3779,7 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
>  		pp->mib = pm;
>  
>  		pm->port = pp;
> +		u64_stats_init(&pm->syncp);
>  		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
>  	}
>  

[Severity: Medium]
Does the MIB delayed work ever become schedulable again after a port
teardown?  yt921x_dsa_port_teardown() does:

	if (pm)
		disable_delayed_work_sync(&pm->work);

which increments the work item's disable count, and enable_work() documents
that "@work can only be queued if its disable count is 0".  There is no
enable_delayed_work() call anywhere in drivers/net/dsa/motorcomm/.

The initialization above (now including u64_stats_init()) sits inside the
"if (!pm && ...)" guard, and pm is devm_kzalloc()'d, so it survives a DSA
tree teardown/re-setup while the switch stays bound:

dsa_switch_remove() -> dsa_tree_teardown() -> yt921x_dsa_port_teardown()
dsa_register_switch() -> dsa_tree_setup() -> yt921x_dsa_port_setup()

On the second setup pp->mib is non-NULL, so the guarded block is skipped and
the disable count stays at 1.  Would schedule_delayed_work(&pm->work, 0) in
yt921x_phylink_mac_link_up() then silently do nothing, leaving the 32-bit
wraparound accumulation in yt921x_mib_read() stopped and .get_stats64()
returning frozen values?

The asymmetry was introduced by the earlier patch in this series, "net: dsa:
motorcomm: Split MIB buffers", which moved disable_delayed_work_sync() out
of yt921x_mdio_remove() into the new .port_teardown callback, and it is
still there at the series tip.

[Severity: Medium]
This isn't a bug introduced by this patch, but on the same teardown/re-setup
path, is the software shadow ever resynchronized with the hardware
counters?  yt921x_chip_setup() unconditionally clears them:

	/* Clear MIB */
	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);

while pm (and now pm->data as well as pm->stats) is only zeroed at
devm_kzalloc() time above.  After the hardware counters go back to zero, the
wrap heuristic in yt921x_mib_read():

		u64 old_val = buf[i];

		val = (old_val & ~(u64)U32_MAX) | val0;
		if (val < old_val)
			val += 1ull << 32;

would see a small val0 against a large old_val and add 2^32, so every
32-bit counter would over-report by up to ~4.29e9 for the rest of the
driver's lifetime.  The comment "MIB buffer must be zeroed before" in mib.c
only holds for the first allocation.

> diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
> index f5d39d22215d4..8601d25fe9887 100644
> --- a/drivers/net/dsa/motorcomm/mib.c
> +++ b/drivers/net/dsa/motorcomm/mib.c

[ ... ]

> @@ -110,7 +110,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  			break;
>  
>  		if (desc->size <= 1) {
> -			u64 old_val = u64_stats_read(valp);
> +			u64 old_val = buf[i];
>  
>  			val = (old_val & ~(u64)U32_MAX) | val0;
>  			if (val < old_val)

[Severity: Low]
This isn't a bug introduced by this patch, but the MIB_DESC(2, ...) counters
(RX_GOOD_BYTES 0x3c/0x40, RX_BAD_BYTES 0x44/0x48, TX_GOOD_BYTES 0x84/0x88)
are still composed from two independent SMI reads in the else branch just
below:

		} else {
			u32 val1;

			res = yt921x_reg_read(priv, reg + 4, &val1);
			if (res)
				break;
			val = ((u64)val1 << 32) | val0;
		}

If the counter crosses a 2^32 boundary between the two transactions, does
the stale low word get combined with the already incremented high word,
giving a ~4 GiB jump in rx_bytes/tx_bytes and Octets*OK?

The later patch in this series, "net: dsa: motorcomm: Use safe 64-bit
counter reader", replaces this with yt921x_counter_read(), which re-reads
the low word and retries until lo >= old_lo, so the concern does not survive
to the end of the series.

> @@ -124,9 +124,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  			val = ((u64)val1 << 32) | val0;
>  		}
>  
> -		u64_stats_set(valp, val);
> +		buf[i] = val;
>  	}
>  
> +	u64_stats_update_begin(&pm->syncp);
> +	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++)
> +		u64_stats_set(&((u64_stats_t *)mib)[i], buf[i]);

[Severity: High]
Should this write section run with preemption disabled?  yt921x_mib_read()
is only ever called with priv->reg_lock held, which is a sleepable mutex, and
all callers are fully preemptible process context:

yt921x_mib_poll()
    mutex_lock(&priv->reg_lock);
    yt921x_mib_read()
        u64_stats_update_begin(&pm->syncp);

include/linux/u64_stats_sync.h states as constraint (2) that the "Write side
must disable preemption, or a seqcount reader can preempt the writer and
also spin forever".

On BITS_PER_LONG==32, __u64_stats_update_begin() uses preempt_disable_nested(),
which does not disable preemption on non-PREEMPT_RT builds:

	if (IS_ENABLED(CONFIG_PREEMPT_RT))			\
		preempt_disable();				\
	else							\
		lockdep_assert_preemption_disabled();

So on 32-bit with CONFIG_PROVE_LOCKING, would this warn on every poll (every
YT921X_STATS_INTERVAL_JIFFIES, 3 s)?

And without lockdep, the sequence stays odd across the ~40 u64_stats_set()
stores plus the two histogram summations while preemption is enabled.  The
reader takes no mutex and can run with preemption off, for example:

bond_get_stats()
    spin_lock_nested(&bond->stats_lock)
    dev_get_stats() -> dsa_user_get_stats64() -> yt921x_dsa_get_stats64()
        u64_stats_fetch_begin(&pm->syncp)

If that reader lands on the same CPU as a preempted, CPU-bound kworker
writer, does it spin indefinitely in __read_seqcount_begin()?  Would
u64_stats_update_begin_irqsave()/u64_stats_update_end_irqrestore(), or an
explicit preempt_disable() around the write section, be the right form here?

>  	rx_frames = u64_stats_read(&mib->rx_64byte) +
>  		    u64_stats_read(&mib->rx_65_127byte) +
>  		    u64_stats_read(&mib->rx_128_255byte) +
> @@ -143,6 +146,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  		    u64_stats_read(&mib->tx_jumbo);
>  	u64_stats_set(&pm->rx_frames, rx_frames);
>  	u64_stats_set(&pm->tx_frames, tx_frames);
> +	u64_stats_update_end(&pm->syncp);
>  
>  	if (res)
>  		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",

[ ... ]

> @@ -320,8 +330,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
>  	mib = &pm->stats;
>  
>  	mutex_lock(&priv->reg_lock);
> +
>  	yt921x_mib_read(priv, port);
> -	mutex_unlock(&priv->reg_lock);
>  
>  	*ranges = yt921x_rmon_ranges;
>  

[Severity: Medium]
This is a pre-existing issue and not something this patch introduced, but a
few lines below in yt921x_dsa_get_rmon_stats() the RMON fragments field is
fed from the alignment error counter:

	rmon_stats->undersize_pkts = u64_stats_read(&mib->rx_undersize_errors);
	rmon_stats->oversize_pkts = u64_stats_read(&mib->rx_oversize_errors);
	rmon_stats->fragments = u64_stats_read(&mib->rx_alignment_errors);
	/* rmon_stats->jabbers */

struct ethtool_rmon_stats defines fragments as etherStatsFragments, and the
driver has a dedicated rx_fragment_errors counter (fed from
YT921X_MIB_DATA_RX_FRAG_ERR) which is only used in yt921x_dsa_get_stats64():

		stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
					  u64_stats_read(&mib->rx_fragment_errors);
		...
		stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);

Should rmon_stats->fragments read rx_fragment_errors instead?

> @@ -345,6 +355,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
>  	rmon_stats->hist_tx[4] = u64_stats_read(&mib->tx_512_1023byte);
>  	rmon_stats->hist_tx[5] = u64_stats_read(&mib->tx_1024_1518byte);
>  	rmon_stats->hist_tx[6] = u64_stats_read(&mib->tx_jumbo);
> +
> +	mutex_unlock(&priv->reg_lock);
>  }

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/mib.h b/drivers/net/dsa/motorcomm/mib.h
> index d84ae2f449ac8..33992a5f9bdc1 100644
> --- a/drivers/net/dsa/motorcomm/mib.h
> +++ b/drivers/net/dsa/motorcomm/mib.h
> @@ -125,13 +125,19 @@ struct yt921x_mib_stats {
>  	u64_stats_t tx_oam;
>  };
>  
> +#define YT921X_MIB_NUM	(sizeof(struct yt921x_mib_stats) / sizeof(u64_stats_t))
> +
>  struct yt921x_mib {
>  	struct yt921x_port *port;
>  
>  	struct delayed_work work;
> +	struct u64_stats_sync syncp;
> +	/* protected by syncp OR priv->reg_lock */
>  	struct yt921x_mib_stats stats;
>  	u64_stats_t rx_frames;
>  	u64_stats_t tx_frames;
> +	/* protected by priv->reg_lock */
> +	u64 data[YT921X_MIB_NUM];
>  };

[Severity: Low]
Could a static_assert() be added here to tie YT921X_MIB_NUM to
ARRAY_SIZE(yt921x_mib_descs)?  Both loops in yt921x_mib_read() are bounded
by ARRAY_SIZE(yt921x_mib_descs) while data[] is now sized from
sizeof(struct yt921x_mib_stats), and data[] is the last member of the
devm_kzalloc()'d struct yt921x_mib.

Both counts are 39 today, so nothing overruns at this commit, and no such
assertion appears later in the series.  Adding a descriptor without a
matching u64_stats_t field would turn what used to be an in-struct overrun
into a write past the end of the allocation.

Also, the invariant comment above yt921x_mib_descs[] in mib.c says:

/* Must agree with yt921x_mib
 *

Should that name yt921x_mib_stats, which is the struct YT921X_MIB_NUM
measures and the one the descriptor table actually indexes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906131414.2683362-1-mmyangfl%40gmail.com
