Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424354;
	b=2BuH1ulxOBNG70s0pKI6rAPFwtT1dU1x3YVVntyKQi/HcDgB7NUuHGgvSVbeFNGLOEwM
	 lYgF2s0m7tH7dcXe7azHGTak4Ryw34ENkXzwfNwDYZDHnIX8Os3hMAZjqkNne/Kf3MhD2
	 cXCmtDj/Utfzp0bp1Y66Sl/L8+pdcpcJMuhxgQXUF0eDHGXpiFHFKuD6Div7pb+mL9pX7
	 7Ui0Kq0SUTmQ8Oj/EZuJpVV+E6alJUEkWTsQJfXZ8L/Fw/qFjY19hSTfkygm8PNBo02FB
	 +jS11CcdlCnj2Ma7TjnmpBjvSO8z2HWWai0RameqW3+2+bdTLfMNXdF6Jo3nI4NNZaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424354;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TfrAkDnNRAseKss28vJrgiLPA/uB5YGf7+cWpy0YIgs=;
	b=GZv/onWku7MFZFDVfbtO98dbZhf0CmgUh2jylKHy5OohlZe4+r351FWbMMw8adu0Mwlm
	 1In3gji7DNSs7hNxJ8QoArck3D5Bbw02PvPjBxO2LQBgVZ9DDoLViW8QlGFXtdWkzZ9LY
	 uGalpN/SrZNefAQJH5MvU/vnDm73aV9mUOuDph+sd9T1M+GUXPWjz0IbP5MxUvgjIa4J7
	 qUg0p6fvMuwNQTWJHOuezgAKnlbWWX7lPMBJOOhf23uKRmzV902lNwEkHoYx7Z97SjVHd
	 eR2jdFwkab/jONOCAwk9W60zY9XHa7ssogGncQPRkmVVcg3A0uXfUu0BbktNnANvajA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heeU8wWv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95013606AAF0;
	Mon, 19 Oct 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heeU8wWv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0A41F000C5;
	Mon, 19 Oct 2026 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792424353;
	bh=TfrAkDnNRAseKss28vJrgiLPA/uB5YGf7+cWpy0YIgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=heeU8wWv9OZ0rW8DeGnVkemXhPpMwJC/5i01zI/OGv84NwwBGmBRQ/S29FWL37FAe
	 XSPj6SSXA6G3hIbIIxQfuhkg8XWqOAumTy6Tc7IxMViuYsEEV1116Um2/TDdFPjsSQ
	 yOK9FuezKhOJNxQUMQCxs1cD3lhjtF08IWKoQSmk2Dq1PaaqoopnC0NV2TmmbVBdAR
	 DIfERYI1wSj+vrrk4lRNJtO7GDy4uXfYk4cgb5aXsIm1CNeI/v572z0fqHTopI/lEI
	 3n/jIaE2mI+LgRPqosYPeWyxdE4NoUCwM2S8E5uXhcueV/5PA6BFSbzo9foqxxJHzP
	 oyrG2Ksd1Y1sQ==
Subject:
 Re: [PATCH net-next] net: dsa: qca8k: report port statistics from the MIB
From: netdev-bot+sashiko@kernel.org
To: kuncy7@gmail.com
Cc: ansuelsmth@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 15:39:12 +0000
Message-ID: <179242435208.3135.4308200364249714892@kernel.org>
In-Reply-To: <20261018153658.209999-1-kuncy7@gmail.com>
References: <20261018153658.209999-1-kuncy7@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Once qca8k_sw_shutdown() has run, nothing cancels the self-
  rearming stats_work.
- [High] The new stats worker is an unsynchronized regmap user that runs
  outside rtnl and reg_mutex.
- [Medium] qca8k_stats_read64() builds RxGoodByte/TxByte from two
  independent 32-bit reads, `qca8k_read(reg)` then `qca8k_read(reg +…
- [Medium] The new statistics path assumes qca8k_mib_init() succeeded,
  but qca8k_setup() still treats MIB init failure as non-fatal (`if…
- [Medium] The self-rearming stats_work keeps accessing the switch over
  MDIO/mgmt Ethernet across system suspend and resume, because the…
- [Medium] rx_bytes/tx_bytes are copied directly from the switch's
  RxGoodByte/TxByte MIB counters with no FCS adjustment.

--

net: dsa: qca8k: report port statistics from the MIB

This adds a .get_stats64 implementation to qca8k that reports per-port
counters from the switch MIB. A delayed work polls the MIB every 3 seconds
and adds the deltas into a cached rtnl_link_stats64, which .get_stats64
copies out under a spinlock. qca8k_setup() starts the work and a new
qca8k_teardown() cancels it.

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 07227ae8bc040..9fef54a888502 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1851,6 +1851,156 @@ static void qca8k_setup_hol_fixup(struct qca8k_priv *priv, int port)

[ ... ]

> +static int qca8k_stats_read64(struct qca8k_priv *priv, u32 reg, u64 *val)
> +{
> +	u32 lo, hi;
> +	int ret;
> +
> +	ret = qca8k_read(priv, reg, &lo);
> +	if (!ret)
> +		ret = qca8k_read(priv, reg + 4, &hi);
> +	if (!ret)
> +		*val = ((u64)hi << 32) | lo;
> +
> +	return ret;
> +}
> +
> +static u64 qca8k_stats_delta64(u64 now, u64 *last)
> +{
> +	/* a flushed MIB starts again from zero */
> +	u64 delta = now >= *last ? now - *last : now;
> +
> +	*last = now;
> +	return delta;
> +}

[Severity: Medium]
Can the two reads in qca8k_stats_read64() tear? RxGoodByte and TxByte are
each built from two separate qca8k_read() transactions. There is no
hi/lo/hi re-read and no latch. If the low word carries between the two
reads, the sample comes out about 2^32 too high.

The existing ethtool -S path reads the halves the same way. The code
doesn't show whether the switch latches the high word, so this part may
depend on the hardware.

If a sample ever goes backwards, qca8k_stats_delta64() treats it as a flush
and returns the full absolute value of now. A torn read or a bogus value
from a racing regmap access would both do this. Would the next good sample
then add the whole byte count since setup to s->rx_bytes or s->tx_bytes a
second time?

As far as I can see, the only MIB flush is the QCA8K_MIB_FLUSH in
qca8k_mib_init(). That runs before the worker starts, and
QCA8K_MIB_FLUSH_PORT is never used. So the "flushed MIB" branch has no
legitimate trigger at runtime.

The 32-bit counters in qca8k_stats_read_port() use plain modular
subtraction instead:

    d[i] = raw[i] - ps->last[i];

So the two paths disagree on what a decrease means. In either case, one
bad sample permanently corrupts the cumulative totals.

> +
> +static void qca8k_stats_read_port(struct qca8k_priv *priv, int port)
> +{

[ ... ]

> +	/* all of the slow MDIO reads before the lock */
> +	if (qca8k_stats_read64(priv, base + QCA8K_MIB_RX_GOOD_BYTE, &rx_bytes) ||
> +	    qca8k_stats_read64(priv, base + QCA8K_MIB_TX_BYTE, &tx_bytes))
> +		return;
> +
> +	for (i = 0; i < QCA8K_STATS_MIB_COUNT; i++)
> +		if (qca8k_read(priv, base + qca8k_stats_mib[i], &raw[i]))
> +			return;

[Severity: High]
Is this worker safe against other regmap users? The qca8k regmap is
created in qca8k_regmap_config with:

    .disable_locking = true, /* Locking is handled by qca8k read/write */

However, regmap_read() and regmap_write() both put the formatted register
and value into the shared map->work_buf, through _regmap_bus_read(),
_regmap_raw_read() and _regmap_bus_raw_write().

The mdio_lock and mgmt_eth_data->mutex cover only the bus transaction.
qca8k_bulk_read() reads *(u16 *)reg_buf before taking any lock.
qca8k_bulk_gather_write() also reads reg and *val before locking. And
_regmap_bus_read() parses work_val after the transport has unlocked.

This worker issues about 31 regmap_read() calls per user port every 3
seconds. It holds neither rtnl nor reg_mutex. It can run alongside
rtnl-held paths such as qca8k_get_ethtool_stats(), FDB/VLAN/ATU
programming through qca8k_write() and qca8k_busy_wait(), and port setup.

Could an interleaving give the worker another caller's value, or the 0
from *val = 0 in qca8k_mii_read32()? The delta logic would then add about
2^32, or the whole counter, for good.

Could it go the other way and give an rtnl reader the worker's MIB value?
For example, qca8k_busy_wait() could see a bogus busy bit.

Could it overwrite the register or value of a pending write in work_buf?
The config write could then be lost, land on a MIB register, or write a
MIB value into a config register.

The unlocked regmap design is older than this patch. However, this patch
adds a reader that runs all the time outside rtnl and relies on it.

> +
> +	spin_lock_bh(&ps->lock);
> +
> +	for (i = 0; i < QCA8K_STATS_MIB_COUNT; i++) {
> +		d[i] = raw[i] - ps->last[i];
> +		ps->last[i] = raw[i];
> +	}
> +
> +	s->rx_bytes += qca8k_stats_delta64(rx_bytes, &ps->last_rx_bytes);
> +	s->tx_bytes += qca8k_stats_delta64(tx_bytes, &ps->last_tx_bytes);

[Severity: Medium]
Do RxGoodByte and TxByte include the FCS? In
include/uapi/linux/if_link.h, struct rtnl_link_stats64 says rx_bytes and
tx_bytes:

    For IEEE 802.3 devices should count the length of Ethernet Frames
    excluding the FCS.

The commit message cites rtl8365mb as a model, and
rtl8365mb_stats_update() removes the FCS:

    /* if{In,Out}Octets includes FCS - remove it */

ksz_common.c and ksz8.c also subtract stats->rx_packets * ETH_FCS_LEN.

The 64..1518 size buckets used in this same function count the FCS in the
frame length. That suggests the byte counters include it too. If so,
every packet is overcounted by 4 bytes, which is about 6% for 64-byte
frames.

The test in the commit message shows the netdev now matches the switch's
own TxByte. That is agreement with the hardware number, not with the uAPI
definition.

The code doesn't confirm whether the QCA8K counters include the FCS, and
ar9331 doesn't subtract it either.

[ ... ]

> +static void qca8k_stats_poll(struct work_struct *work)
> +{
> +	struct qca8k_priv *priv = container_of(work, struct qca8k_priv,
> +					       stats_work.work);
> +	struct dsa_port *dp;
> +
> +	dsa_switch_for_each_user_port(dp, priv->ds)
> +		qca8k_stats_read_port(priv, dp->index);
> +
> +	schedule_delayed_work(&priv->stats_work, QCA8K_STATS_INTERVAL);
> +}

[ ... ]

> +static void qca8k_teardown(struct dsa_switch *ds)
> +{
> +	struct qca8k_priv *priv = ds->priv;
> +
> +	cancel_delayed_work_sync(&priv->stats_work);
> +}

[Severity: High]
What stops this work after qca8k_sw_shutdown()? qca8k_stats_poll()
re-arms itself with no stop condition. qca8k_teardown() is the only place
that cancels stats_work, and it is reached only through
dsa_unregister_switch() and the DSA setup error paths.

qca8k_sw_shutdown() calls dsa_switch_shutdown(), which doesn't call
ds->ops->teardown. It then clears drvdata:

    dsa_switch_shutdown(priv->ds);

    dev_set_drvdata(&mdiodev->dev, NULL);

The driver keeps this so that .remove can still come after .shutdown,
when the parent bus driver unregisters its children during its own
shutdown. In that case qca8k_sw_remove() takes the early return:

    if (!priv)
        return;

That skips dsa_unregister_switch(), so qca8k_teardown() never runs. devm
then frees priv, which embeds stats_work and port_stats[].

Wouldn't the still-queued timer then fire on freed memory? And wouldn't
qca8k_stats_poll() dereference priv->ds and priv->regmap and write into
the freed priv->port_stats[]?

Even without a later remove, the worker keeps sending MDIO or management
Ethernet traffic to a switch and conduit that are already shut down.

The commit message cites ar9331 and rtl8365mb. Both cancel their MIB work
in mac_link_down, which runs when dsa_switch_shutdown() closes the
conduit. The global work added here gets no such call.

> @@ -2020,6 +2170,11 @@ qca8k_setup(struct dsa_switch *ds)
>  	/* Set max number of LAGs supported */
>  	ds->num_lag_ids = QCA8K_NUM_LAGS;
>  
> +	for (int port = 0; port < QCA8K_NUM_PORTS; port++)
> +		spin_lock_init(&priv->port_stats[port].lock);
> +	INIT_DELAYED_WORK(&priv->stats_work, qca8k_stats_poll);
> +	schedule_delayed_work(&priv->stats_work, 0);

[Severity: Medium]
Should the poller and .get_stats64 depend on qca8k_mib_init() succeeding?
Earlier in qca8k_setup(), a failure there is still only a warning:

    ret = qca8k_mib_init(priv);
    if (ret)
        dev_warn(priv->dev, "mib init failed");

qca8k_mib_init() flushes the MIB, busy-waits, sets QCA8K_MIB_CPU_KEEP and
then writes QCA8K_MODULE_EN_MIB. It stops at the first error. That can
leave the MIB module disabled, so the counters are frozen. It can also
leave CPU_KEEP unset, so the counters may clear on read.

dsa_user_get_stats64() uses ds->ops->get_stats64 whenever it is set:

    if (ds->ops->get_stats64)
        ds->ops->get_stats64(ds, dp->index, s);
    else
        dev_get_tstats64(dev, s);

So the software tstats fallback is no longer used.

Would every user port then show zero traffic for the life of the device?
That would include the CPU-terminated traffic that was counted before.

With clear-on-read counters, would raw[i] - ps->last[i] wrap to about 2^32
on every decrease?

Before this patch, a MIB init failure only affected ethtool -S. The code
doesn't show the hardware defaults for MODULE_EN and CPU_KEEP, so the
clear-on-read case is speculative.

[Severity: Medium]
Does this work also need to be stopped across system suspend?
qca8k_suspend() and qca8k_resume() are not updated, and qca8k_suspend()
only does:

    qca8k_set_pm(priv, 0);

    return dsa_switch_suspend(priv->ds);

dsa_switch_suspend() doesn't touch stats_work. The work is queued on
system_percpu_wq, which isn't freezable.

The work can still run after the switch is suspended, and later after the
parent MDIO controller or conduit is suspended too. On resume after any
sleep longer than 3 seconds, the timer has already expired. qca8k_stats_poll()
can then run before dpm_resume() reaches the MDIO controller.

Couldn't qca8k_read() then be issued on a suspended bus? Depending on the
SoC, the result ranges from a skipped sample to a bus fault, or a hang on
a clock-gated controller.

ar9331 and rtl8365mb stop their MIB work in mac_link_down, which
phylink_stop() triggers during dsa_switch_suspend(). The global work added
here has no such hook.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018153658.209999-1-kuncy7%40gmail.com
