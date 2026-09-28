Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9449D581;
	Mon, 28 Sep 2026 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591962; cv=none; b=VpS7qmGyQeutyCKooKqRNOtcOFkKm4wTC9HNr5QYBQ2wJMQHESyrENGRBq80C4jfbffJTu+7odntcbg5OJIJty10HW9WYoh27hHTcolnS15gSW2uhoyNnpDhGhOth82AW1qUB38Taj2g5UxTPN/EIET6RccxgNdewZIlfp6cdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591962; c=relaxed/simple;
	bh=etlCLVfnBDRr8JxPZTEImAn2+psRTTxkPqXODuX7HVM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JuTqADXmrsRiZrYB7DzmMep4KjUhJLiSY5bresFCCgdCzQIHWJGFwdw3fsXCqWdRkQTSRUfASJzp2n30XRy7dOOlz5JIiC00Y7s3sreVLSczd5KfYmGYcFM2kH3Albng4dUdtXA9ja7qHD/a/R0eZikMe4842F0wjv0RvDyPvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOqdgRW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOqdgRW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B0D1F000FF;
	Mon, 28 Sep 2026 10:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790591960;
	bh=l+dKjIJlVhm0CLLo6vx/VfOAlkTVXEhhwc2GDqlOFRA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dOqdgRW9qVrhIgnRhIIdeuKrOssskckuj/V0pt3JB7bP63ggbPVjuU055ahHftX91
	 YSWkga/S7/SvDVU79fT+/VLq6Hb4oBG7kafiJRuGZA2NjVrbzxR8o7A2xlFOGfN7MF
	 79iKbcCYNP4FKgHE7BnVG+sGq4wbjcxTmoKJvsMho72DswNONzr+biz6KzYy4dJYIH
	 5KWNx+72Vy3lRNSO45Ye/SQz5XvW+2aHFZ1e0laKc04mMUJWh2CpxaVeujXarbGqdc
	 UaktVJ1FFEoDTTw3ZNqRStbLA5eIHh2zwieFKUuIaBNKsRjVolo0ktNxy1dx72TJ9v
	 2PcAwU6NLKrMg==
Subject: Re: [PATCH net-next v9 4/7] net: dsa: motorcomm: move mib start from
 probe() to dsa_setup()
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 28 Sep 2026 10:39:19 +0000
Message-ID: <179059195948.3145.3661263680242353883@kernel.org>
In-Reply-To: <20260924094146.4128703-5-kyle.switch@motor-comm.com>
References: <20260924094146.4128703-5-kyle.switch@motor-comm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] With this patch, INIT_DELAYED_WORK() runs on every
  yt921x_dsa_setup() call.
- [Medium] After this patch, INIT_DELAYED_WORK(&pp->mib_read,
  yt921x_poll_mib) runs only in yt921x_dsa_setup() (chip.c:4556-4562).
- [Low] The subject line, "move mib start from probe() to dsa_setup()",
  does not describe the change.

Pre-existing issues:
- [Medium] yt921x_dsa_setup() hard-resets the chip (yt921x_chip_reset)
  and yt921x_chip_setup() then clears all hardware MIB counters…
- [Low] yt921x_phylink_mac_link_down() stops MIB polling with non-sync
  cancel_delayed_work(&priv->ports[port].mib_read) (chip.c:3962).

--

net: dsa: motorcomm: move mib start from probe() to dsa_setup()

This patch moves the per-port pp->index assignment and the
INIT_DELAYED_WORK() of the MIB polling work out of yt921x_mdio_probe()
and into the DSA .setup() callback, yt921x_dsa_setup(). The works are
now initialized once per .setup() call rather than once per probe.

> net: dsa: motorcomm: move mib start from probe() to dsa_setup()

[Severity: Low]
This isn't a bug, but does the subject line match the change? Neither
probe() nor .setup() starts MIB polling. The patch only moves
INIT_DELAYED_WORK(). Polling starts in yt921x_phylink_mac_link_up(),
which this patch leaves alone:

	schedule_delayed_work(&priv->ports[port].mib_read, 0);

> Move the delayed work initialization of the per-port MIB polling
> from yt921x_mdio_probe() into the DSA .setup() callback, changing
> its lifetime from once per probe() to once per DSA .setup().

The body repeats what the diff does but doesn't say why the change is
needed. It also doesn't mention that yt921x_mdio_remove() still expects
the works to be initialized at probe time until the next patch in the
series.

Could the message give the reason for the change, and either mention
that dependency or squash this with "net: dsa: motorcomm: move mib stop
from remove() to teardown()"?

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 6f2606fd7807..d9d73bb7cb23 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -4553,6 +4553,14 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
>  	struct device_node *child;
>  	int res;
>  
> +	/* mib polling init */
> +	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
> +		struct yt921x_port *pp = &priv->ports[i];
> +
> +		pp->index = i;
> +		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);

[Severity: High]
Now that this runs on every yt921x_dsa_setup() call, can it
re-initialize a mib_read work that is still armed or queued?

In a multi-switch tree, removing one member goes through
dsa_switch_remove()->dsa_tree_teardown() for the whole tree. When that
member registers again, ds->ops->setup() runs again on the switches
that stayed.

At this commit, nothing on the teardown side stops mib_read
synchronously. yt921x_dsa_teardown() doesn't touch the work.
yt921x_phylink_mac_link_down() only does a non-sync cancel:

	/* No need to sync; port control block is hold until device remove */
	cancel_delayed_work(&priv->ports[port].mib_read);

yt921x_poll_mib() also always re-arms itself:

	schedule_delayed_work(&pp->mib_read, delay);

If the work is still pending when .setup() runs again,
INIT_DELAYED_WORK() resets timer->entry.pprev, work->entry and
work->data while they are still linked into the timer wheel or the pool
worklist. Could that corrupt those lists?

The next patch, "net: dsa: motorcomm: move mib stop from remove() to
teardown()", adds disable_delayed_work_sync() for every port to
yt921x_dsa_teardown(). That fixes this in the final state of the
series, but this intermediate commit is still affected.

[Severity: Low]
This is a pre-existing issue, and this patch doesn't introduce it.
Related to the above, can MIB polling keep running on a port whose link
is down?

If yt921x_phylink_mac_link_down() runs while yt921x_poll_mib() is
executing, the pending bit is already clear, so cancel_delayed_work()
does nothing. The handler then re-queues itself with
schedule_delayed_work() after dropping reg_lock. It never checks link
state first.

Polling on that port would then go on until the next teardown or
remove.

> +	}
> +
>  	mutex_lock(&priv->reg_lock);
>  	res = yt921x_chip_reset(priv);
>  	mutex_unlock(&priv->reg_lock);

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens to the
software MIB counters on a second .setup() for the same probe?

yt921x_chip_reset() is followed by yt921x_chip_setup(), which clears
the hardware counters:

	/* Clear MIB */
	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;

pp->mib, pp->rx_frames and pp->tx_frames are only zeroed once, by
devm_kzalloc() in probe. yt921x_read_mib() says "MIB buffer must be
zeroed before", and it extends 32-bit counters like this:

			val = (old_val & ~(u64)U32_MAX) | val0;
			if (val < old_val)
				val += 1ull << 32;

Would the first poll after re-setup read the hardware clear as a wrap
and add 2^32 to each 32-bit counter? The 64-bit counters would go
backwards instead.

Since this loop now runs on every .setup(), could it also reset the
software accumulators?

> @@ -4810,13 +4818,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  	priv->reg_ops = &yt921x_reg_ops_mdio;
>  	priv->reg_ctx = mdio;
>  
> -	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
> -		struct yt921x_port *pp = &priv->ports[i];
> -
> -		pp->index = i;
> -		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
> -	}
> -

[Severity: Medium]
With this loop gone from yt921x_mdio_probe(), can yt921x_mdio_remove()
run on delayed works that were never initialized?

dsa_register_switch() can succeed without ever calling
ds->ops->setup(), because dsa_tree_setup() returns early when the tree
is incomplete:

net/dsa/dsa.c:dsa_tree_setup() {
    ...
	complete = dsa_tree_setup_routing_table(dst);
	if (!complete)
		return 0;
    ...
}

yt921x_mdio_remove() still does this for every port:

	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
		struct yt921x_port *pp = &priv->ports[i];

		disable_delayed_work_sync(&pp->mib_read);
	}

If the device is unbound in that state, the path
disable_delayed_work_sync()->__cancel_work_sync()->__flush_work() would
hit WARN_ON(!work->func) once for each port.

The follow-up patch, "net: dsa: motorcomm: move mib stop from remove()
to teardown()", moves this loop into yt921x_dsa_teardown(). DSA skips
that callback when ds->setup is false, so the final state of the series
doesn't have this problem. Only this intermediate commit breaks
bisection.

Also, in that follow-up patch, yt921x_dsa_teardown() seems to use priv
outside the #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS) block where priv
is declared. Does it build with CONFIG_NET_DSA_YT921X_LEDS=n?

>  	ds = &priv->ds;
>  	ds->dev = dev;
>  	ds->priv = priv;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924094146.4128703-1-kyle.switch%40motor-comm.com
