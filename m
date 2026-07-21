Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594A30BF6D
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639882; cv=none; b=u0FV8Ar48FsgT8r5YkPpCy5m18hIpP/WDp+qsBOxFBV+6VHBg/76WDRiX3k/p78bOR7tFn817J+9Ka2w4J+Knwo3O+VnAgmgxVtu9BbgYf6igw0AhyA9v/7fkd5Fx/SIxsGr+TYyfIeT/w7O0hHLLKRv24e1HP4D/cMtdiehvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639882; c=relaxed/simple;
	bh=M7Q90cINlErpjYbTDf3+5FxyvKM0NvYQtkBRbNMMfQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMf01pjyUQC4cQU5fwY3FHvmQM/W2G95hxEDQc0hFKfkhorz5YsPA/F5jblKuIkkdWKQNQJ0wmB2gSXuq2HGJd4Lv+M9QGWLSyYmlY8xOuVdtWc/n/2hortU3qErc+GVhpUnblu7mAXQom+Fg3XGHJJLPxaE2oHZcy9KVB+o/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONuVk86g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONuVk86g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784639879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctx4sjKDsVdSTnLDSoEtBNzrROWciIBUn40tQvWEcIw=;
	b=ONuVk86gKMZYN/XIAAylZGUwQZcFMMrXx4TcOo4kPcLe3ber3SsSP6mr7QrwZERzFmL1Ho
	VKs8oe8yHwIyT7FvWcrq4VLCCzYQOlf4Ckks7bgQxbPiC6cotQDlZycrGiSXK9qhVHlFiZ
	pPVGZJs+Zm2UvKUFel25RDuAoYa28c0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-ZnocnqjyOKmloaSFyQ6oZQ-1; Tue,
 21 Jul 2026 09:17:56 -0400
X-MC-Unique: ZnocnqjyOKmloaSFyQ6oZQ-1
X-Mimecast-MFC-AGG-ID: ZnocnqjyOKmloaSFyQ6oZQ_1784639873
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06AAB19774FB;
	Tue, 21 Jul 2026 13:17:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.106])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6F3A180029F;
	Tue, 21 Jul 2026 13:17:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew@lunn.ch,
	pier.beruto@onsemi.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	parthiban.veerasooran@microchip.com,
	selvamani.rajagopal@onsemi.com,
	richardcochran@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	jerry.ray@microchip.com
Subject: Re: [PATCH net-next v7 14/15] onsemi: s2500: Add driver support for TS2500 MAC-PHY
Date: Tue, 21 Jul 2026 15:17:42 +0200
Message-ID: <20260721131742.233773-1-pabeni@redhat.com>
In-Reply-To: <20260708-s2500-mac-phy-support-v7-14-478c877aa1a9@onsemi.com>
References: <20260708-s2500-mac-phy-support-v7-14-478c877aa1a9@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
onsemi: s2500: Add driver support for TS2500 MAC-PHY

This patch adds a driver for onsemi's S2500 10BASE-T1S MAC-PHY, built on
top of the Open Alliance TC6 framework. It provides ndo_* callbacks,
ethtool statistics/regdump/RMON support, and a PTP clock implementation
including an in-driver adjtime that mixes adjfine-based slewing with
settime.

A few questions and observations below.

> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
> new file mode 100644
> index 000000000000..7e96d9ad563f
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c

[ ... ]

> +static const char s2500_mac_stat_strings[][ETH_GSTRING_LEN] = {
> +	"tx_bytes",
> +	"tx_frames",
> +	"tx_broadcast_frames",
> +	"tx_multicast_frames",
> +	"tx_underflow_errors",
> +	"tx_single_collisions",
> +	"tx_multiple_collisions",
> +	"tx_excessive_collisions",
> +	"tx_deferred_frames",
> +	"tx_carrier_sense_errors",
> +	"rx_bytes",
> +	"rx_frames",
> +	"rx_broadcast_frames",
> +	"rx_multicast_frames",
> +	"rx_runts",
> +	"rx_oversize_frames",
> +	"rx_crc_errors",
> +	"rx_symbol_errors",
> +	"rx_alignment_errors",
> +	"rx_busy_drops",
> +	"rx_mismatch_drops",
> +};

[Medium]
Do these ethtool -S entries duplicate counters that have a standard uAPI?

tx_bytes, tx_frames, rx_bytes, rx_frames, rx_broadcast_frames,
rx_multicast_frames, rx_crc_errors, rx_alignment_errors (=rx_frame_errors),
tx_carrier_sense_errors (=tx_carrier_errors), tx_underflow_errors
(=tx_fifo_errors), tx_excessive_collisions (=tx_aborted_errors),
rx_oversize_frames and rx_runts (=rx_length_errors) all appear to fall
into rtnl_link_stats64 categories exposed via ip -s link show.

The driver also does not implement ndo_get_stats64, so those standard
counters are reported as zero.  Would it make sense to route these
through ndo_get_stats64 and keep ethtool -S only for the truly
driver-private counters (rx_busy_drops, rx_mismatch_drops, symbol
errors, single/multiple collisions, deferred frames)?

Documentation/networking/statistics.rst describes the expected hierarchy.

[ ... ]

> +static void s2500_rmon_stats(struct net_device *ndev,
> +			     struct ethtool_rmon_stats *rmon_stats,
> +			     const struct ethtool_rmon_hist_range **ranges)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +	u8 offset;
> +	int i;
> +
> +	s2500_update_stats(priv);
> +
> +	memset(rmon_stats, 0, sizeof(*rmon_stats));
> +	rmon_stats->src = ETHTOOL_MAC_STATS_SRC_AGGREGATE;
> +	rmon_stats->undersize_pkts = priv->stats_data[S2500_MSTRUNTSERR_IDX];
> +	rmon_stats->oversize_pkts = priv->stats_data[S2500_MSTRXTOOLONG_IDX];
> +	rmon_stats->fragments = priv->stats_data[S2500_MSTFCSERRS_IDX];
> +	rmon_stats->jabbers = priv->stats_data[S2500_MSTALIGNERRS_IDX];

[Medium]
Do fragments and jabbers here match the RFC 2819 / RMON MIB definitions?

RMON defines fragments as undersized frames with a bad FCS/alignment and
jabbers as oversized frames with a bad FCS/alignment, not the raw FCS or
alignment error counters.

If the hardware does not have dedicated fragment/jabber counters, would
leaving these at zero avoid producing misleading data when compared
across devices?

[ ... ]

> +static void s2500_get_regs(struct net_device *ndev,
> +			   struct ethtool_regs *regs, void *p)
> +{
[ ... ]
> +	for (i = 0; i < S2500_NUM_REGS; i++) {
> +		val = 0;
> +		reg = s2500_reg_map[i].reg;
> +		mms = s2500_reg_map[i].mms;
> +		ret = oa_tc6_read_register_mms(priv->tc6, reg, mms,
> +					       &val);
> +		if (ret)
> +			continue;
> +		*pbuff++ = cpu_to_be32(((u32)mms << 16) | reg);
> +		*pbuff++ = cpu_to_be32(val);
> +	}
> +}

[Medium]
Why is the regdump written as big-endian u32 values via cpu_to_be32()?

The ethtool -d convention (and every other in-tree driver's regdump) is
to write host-native u32 values.  On little-endian hosts the current
code produces byte-swapped mms/reg headers and register values, which
generic decoders would misinterpret.  Would writing the values without
the byte swap be more consistent with existing drivers?

[ ... ]

> +const struct ethtool_ops s2500_ethtool_ops = {
[ ... ]
> +	.get_sset_count = s2500_get_sset_count,
> +	.get_strings = s2500_get_strings,
[ ... ]
> +	.self_test = net_selftest,
> +};

[Low]
Since .self_test = net_selftest is wired up here, should get_sset_count
also return net_selftest_get_count() for ETH_SS_TEST and should
get_strings populate the strings via net_selftest_get_strings()?  Without
those, ethtool cannot enumerate the tests.  The follow-up patch in the
series adds this handling, but each patch typically needs to be
self-contained.

> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_main.c b/drivers/net/ethernet/onsemi/s2500/s2500_main.c
> new file mode 100644
> index 000000000000..2d81b44f8c76
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_main.c

[ ... ]

> +static int s2500_init(struct s2500_info *priv)
> +{
[ ... ]
> +	/* Program the source MAC address into the device */
> +	ret = s2500_set_mac_filter(priv->ndev, priv->ndev->dev_addr);
> +
> +	val = S2500_MAC_CTRL_ADRF_BIT | S2500_MAC_CTRL_FCSA_BIT;
> +
> +	return s2500_mac_ctrl_modify_bits(priv, val, false);
> +}

[Medium]
Is the return value of s2500_set_mac_filter() intentionally discarded
here?  It is assigned to ret but then overwritten by
s2500_mac_ctrl_modify_bits().  If any of the four SPI writes inside
s2500_set_mac_filter() fails, the driver will still enable address
filtering with a mis-programmed FILT0 register, which would silently
drop all traffic.  Should the error be propagated?

[ ... ]

> +/* Deferred function for applying RX mode flags in non-atomic context */
> +static int s2500_rx_mode_update(struct s2500_info *priv)
[ ... ]

> +static void s2500_set_rx_mode(struct net_device *ndev)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	priv->rx_flags_upd = true;
> +	priv->ndev_flags = ndev->flags;
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	if (priv->thread)
> +		wake_up_process(priv->thread);
> +}

[High, High]
Can priv->thread be dereferenced when it is an ERR_PTR or a freed task?

In s2500_open() on failure of kthread_run(), priv->thread is left as
ERR_PTR(-errno):

    priv->thread = kthread_run(s2500_thread_fun, priv, ...);
    if (IS_ERR(priv->thread)) {
        ret = PTR_ERR(priv->thread);
    } else {
        ...
    }
    return ret;

An ERR_PTR is non-NULL, so a later s2500_set_rx_mode() would pass the
if (priv->thread) check and hand the ERR_PTR to wake_up_process() as a
task_struct pointer.  Would setting priv->thread = NULL on the failure
branch be safer?

There is also a window in s2500_stop():

    kthread_stop(priv->thread);
    priv->thread = NULL;

kthread_stop() internally does put_task_struct() before it returns, so
between the two statements priv->thread references freed memory.

s2500_set_rx_mode() reads priv->thread without holding priv->lock, and
ndo_set_rx_mode can be invoked from BH context via dev_mc_sync-like
paths rather than under rtnl.  Would clearing priv->thread under
priv->lock before calling kthread_stop() (or performing the check under
priv->lock) close this race?

[ ... ]

> +static netdev_tx_t s2500_start_xmit(struct sk_buff *skb,
[ ... ]
> +static void s2500_process_events(struct s2500_info *priv)
> +{
> +	u32 val;
> +	int ret;
> +
> +	if (!priv->event_pending)
> +		return;
> +
> +	priv->event_pending = false;
> +
> +	ret = oa_tc6_read_register(priv->tc6, S2500_REG_SPI_ST0, &val);
> +	if (ret) {
> +		dev_err(&priv->spi->dev, "Error reading ST0 register");
> +		return;
> +	}
> +}

[High]
Should this handler write back the observed ST0 bits to acknowledge
them?

The probe path treats ST0 as write-1-to-clear:

    /* Acknowledge all IRQ status bits */
    ret = oa_tc6_read_register(priv->tc6, S2500_REG_SPI_ST0, &val);
    if (!ret) {
        u32 mask = S2500_STATUS0_MASK;

        val &= mask;
        oa_tc6_write_register(priv->tc6, S2500_REG_SPI_ST0, val);
    }

At runtime the read value is discarded and never written back, so any
status bits latched later (TX FCS errors, buffer over/underflow, LOFE,
header errors, reset-complete, timestamp captures) would remain set
indefinitely.  Does the device gate further status changes or IRQs when
bits are already asserted?

[ ... ]

> +static int s2500_thread_fun(void *data)
[ ... ]

> +static int s2500_open(struct net_device *ndev)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +	int ret = 0;
> +	u32 val;
> +
> +	dev_dbg(&ndev->dev, "%s", "s2500_open");
> +	phy_start(priv->ndev->phydev);
> +
> +	priv->thread = kthread_run(s2500_thread_fun, priv,
> +				   DRV_NAME "/%s:%d",
> +				   dev_name(&priv->spi->dev),
> +				   spi_get_chipselect(priv->spi, 0));
> +
> +	if (IS_ERR(priv->thread)) {
> +		ret = PTR_ERR(priv->thread);
> +	} else {
> +		val = S2500_MAC_CTRL_TXEN_BIT | S2500_MAC_CTRL_RXEN_BIT;
> +		ret = s2500_mac_ctrl_modify_bits(priv, val, false);
> +
> +		netif_start_queue(priv->ndev);
> +	}
> +	return ret;
> +}

[Medium]
If s2500_mac_ctrl_modify_bits() fails, should netif_start_queue() still
be called and should ret still be returned as failure?

Right now the queue is started even when the MAC-CTRL write returned an
error, and the function returns the error to the network stack.  Since
ndo_open returned failure, s2500_stop() will not be called by the stack
to unwind, leaving the kthread running and the queue started.

[Medium]
Is phy_start() balanced on every failure path from s2500_open()?

phy_start() is called unconditionally at the top.  If kthread_run() or
s2500_mac_ctrl_modify_bits() fails, s2500_open returns an error without
a matching phy_stop(), and because ndo_open failed the stack will not
call s2500_stop().  Would a goto-based unwind be more appropriate?

[ ... ]

> +static int s2500_probe(struct spi_device *spi)
> +{
[ ... ]
> +	spi->dev.platform_data = priv;
> +	spi_set_drvdata(spi, priv);

[Low]
Is overwriting spi->dev.platform_data intentional?

platform_data is normally a channel for the platform layer to hand
pre-populated data to a driver; drivers overwriting it can clobber data
the DT/platform code placed there.  spi_set_drvdata() is already called
on the next line, so s2500_remove() could use spi_get_drvdata() /
dev_get_drvdata() instead of reading spi->dev.platform_data.

[ ... ]

> +	priv->tc6 = oa_tc6_init(spi, ndev);
> +	if (!priv->tc6) {
> +		dev_err(&spi->dev, "OA TC6 init failed");
> +		return -ENODEV;
> +	}
> +	oa_tc6_set_vend1_mms(priv->tc6, OA_TC6_PHY_C45_VS_MMS12);
> +
> +	/* Clear RSTS, if set */
> +	oa_tc6_read_register_mms(priv->tc6, S2500_REG_VS_MIIMIRQS,
> +				 OA_TC6_PHY_C45_VS_MMS12, &val);
> +	val &= MIIM_IRQ_STATUS_RSTS;
> +	if (val != 0)
> +		oa_tc6_write_register_mms(priv->tc6,
> +					  S2500_REG_VS_MIIMIRQS,
> +					  OA_TC6_PHY_C45_VS_MMS12,
> +					  MIIM_IRQ_STATUS_RSTS);

[Medium]
Is val guaranteed to be initialized before the val &= ... read here?

val is declared uninitialized above and oa_tc6_read_register_mms()'s
return value is discarded.  If the underlying read returns early
(e.g. -EINVAL) or fails on the SPI bus, *value is not written and the
subsequent test acts on stack garbage, which could produce an
unintended write to MIIMIRQS or skip a required RSTS acknowledgement.

[ ... ]

> +	ret = s2500_init(priv);
> +	if (unlikely(ret)) {
> +		dev_err(&spi->dev, "failed to s2500_init the device");
> +		goto err_reg_read;
> +	}
> +
> +	/* Configure PTP if the model supports it */
> +	ret = s2500_ptp_register(priv);
> +	if (unlikely(ret))
> +		goto err_reg_read;
> +
> +	ret = register_netdev(ndev);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to register netdev\n");
> +		ret = -ENODEV;
> +
> +		goto err_reg_read;
> +	}
> +	return 0;
> +
> +err_reg_read:
> +	dev_err(&spi->dev, "could not initialize macphy");
> +	return ret;
> +}

[High]
Does the err_reg_read path leak the resources acquired earlier in probe?

oa_tc6_init() installs a threaded IRQ, initializes the PHY and enables
data transfer, and s2500_ptp_register() calls ptp_clock_register(),
which is not devm-managed.  If register_netdev() fails after PTP
registration, the ptp_clock (with its posix_clock device, debugfs
entries and aux kworker) has no owner.

Would the error path benefit from oa_tc6_ptp_unregister() and
oa_tc6_exit() to unwind these in reverse order?

> +static void s2500_remove(struct spi_device *spi)
> +{
> +	struct s2500_info *priv = spi->dev.platform_data;
> +
> +	dev_dbg(&priv->ndev->dev, "%s", "s2500_remove");
> +
> +	oa_tc6_ptp_unregister(priv->tc6);
> +	unregister_netdev(priv->ndev);
> +	oa_tc6_exit(priv->tc6);
> +}

[Medium]
Is the teardown order in s2500_remove() safe against concurrent user
API access?

While the netdev is still registered, userspace can still invoke
ndo_hwtstamp_get/set via SIOCSHWTSTAMP and the ethtool get_ts_info /
get_ts_stats callbacks, which reach into the OA-TC6 PTP state.  Calling
oa_tc6_ptp_unregister() before unregister_netdev() looks like the
reverse of registration order (oa_tc6_init -> s2500_ptp_register ->
register_netdev).  Would unregister_netdev() first (which quiesces
user-visible ops through rtnl) close this window?

> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c b/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c
> new file mode 100644
> index 000000000000..7da660cb5b19
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c

[ ... ]

>     adjtime callback is implemented using adjfine. If time
>     delta is too big, bigger than 1 second, using adjtime
>     would take long to reduce the delta. In those cases,
>     settime callback is used to reduce the delta. Once delta
>     becomes less than a second, it uses adjfine to reduce
>     the drift further.

[Medium]
Does the implementation match this description?

For |delta| > 1s the code calls s2500_use_settime() which computes
target = now + rem and calls ptp->settime64(target) - a full step, not
a partial reduction down to below 1s followed by adjfine.  The claimed
coarse-then-fine hybrid does not appear to be implemented.

Beyond the mismatch, is hiding a time step inside adjtime consistent
with the PTP uAPI?  Step and slew are exposed as different ops so
userspace daemons like phc2sys / ptp4l can choose the policy and audit
time steps; conflating them inside a driver can confuse those consumers.

[ ... ]

> +static int s2500_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
[ ... ]
> +	if (mutex_lock_interruptible(&priv->ptp_adj_lock))
> +		return -EINTR;
> +
> +	/* Try to slew the clock using adjfine for better accuracy.
> +	 * For large adjustments fall back to setting time directly.
> +	 */
> +	rem = delta;
> +
> +	while (rem != 0 && max_iters--) {
[ ... ]
> +		/* Choose a slewing period depending on magnitude */
> +		if (abs_delta <= 1000000LL) /* <= 1ms */
> +			period_ms = 1000; /* 1 s */
> +		else if (abs_delta <= 100000000LL) /* <= 100ms */
> +			period_ms = 10000; /* 10 s */
> +		else
> +			period_ms = 60000; /* 60 s */
[ ... ]
> +		/* Apply frequency adjustment */
> +		ret = ptp->adjfine(ptp, (long)scaled_ppm);
> +		if (ret)
> +			break;
> +
> +		/* Sleep for the slew period (interruptible). If
> +		 * interrupted, clear the adjfine and return -EINTR.
> +		 */
> +		if (msleep_interruptible(period_ms)) {
[ ... ]
> +	mutex_unlock(&priv->ptp_adj_lock);
> +	return ret;
> +}

[High]
Should priv->ptp_adj_lock be held across msleep_interruptible() for up
to ~180 seconds (3 iterations at 60s)?

adjtime is invoked from userspace via PTP_CLOCK_ADJTIME, and the PTP
core does not serialize adjfine/settime64/gettimex64 with adjtime.
Holding the mutex across long sleeps blocks the calling task and any
other adjtime caller for minutes.

Also, s2500_ptp_adjfine() and s2500_ptp_set_time64() do not take
ptp_adj_lock, so a concurrent userspace adjfine or settime64 can
clobber (or be clobbered by) the writes to S2500_REG_VS_PTP_ADJ and the
PTP SEC/NSEC registers that this loop performs.

More broadly, would it be preferable to expose only the primitive ops
(adjfine, settime64, adjphase where supported) and let userspace
daemons implement any coarse-then-fine discipline?
-- 
This is an AI-generated review.

