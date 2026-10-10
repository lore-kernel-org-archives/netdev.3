Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6C44BF920;
	Sat, 10 Oct 2026 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661233; cv=none; b=WZaU14CoLoW+8X7QKXotDe1I1lvbQH4deoCeQUBnWHHHKMW4BKveE0QSA1/yigKuhT37TLKz+MIJqeSgiU5LBkZyh2dyiIIRvVG1Zi0VWZK6BDS67WAE6z0PvxtxugBBoPTA3kxB92jaFR9MKCiK8KV87FKM19K31p1rhdXpBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661233; c=relaxed/simple;
	bh=BsLP0RopXcji/0XF20Jn1bjAE4+zxwajHxgW5JB/kL4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7CzcK1Bosfqzrnj/x65q5rHp8bkpYrOb6BcBUccIBBRXGNB4EfX3TSgn7VphcCmJOra6ZZZ9rYt33wUfQ7MBWOIzSdhuKLu6KXgZIpWZPJeTQko71gwWZZWPaBJhxzT5QEc3qjuNnb9sKl2Yl/hoTjQrxcpExxKlr0uMRIlKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfHI6IY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfHI6IY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5D81F00893;
	Sat, 10 Oct 2026 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661224;
	bh=OhxE1uQbW4GsWxOVNjjoMqfbZFSLZriwZotxwMzUQIU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YfHI6IY37UIL0VuaNNPSs0bWw6v0l3/vJrjookIyR5bIkxAPfHAZkGzho/UCXDxmM
	 8gJyEL88UfZYN5rC/t5scAZ79lXIdofdxVmUSInj3mW0K1nV+j92tF6cl4hQNNDBvO
	 dAgQDEDwdPxxg2W0q446IB6m0ms5DbkXQE7WzsV0btFwyPNDyVr3Z7Z8IF2duq0Ic2
	 fIHOvsVhx+rPq+hPNdA0ilbY+Jc0rqVapGip5FuLgYpGHKVDPOrCY7AfUZyiqvuogH
	 jIQlxp8WSd7HIzxN6dO4VZI3J/6FVuPGW0pJTjGX/Lto9gYnhBVRV81MyM64aeMfh7
	 EXXIwjdXSYkYg==
Subject: Re: [PATCH net-next v9 08/11] onsemi: s2500: Add driver support for
 S2500 MAC-PHY
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sat, 10 Oct 2026 19:40:22 +0000
Message-ID: <179166122244.434549.1856310047736770607@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-8-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-8-dcefe1d0bf0d@onsemi.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 6 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The only driver-private `ethtool -S` counter,
  "rx_mismatch_drops", duplicates a standard uAPI counter.
- [Medium] `s2500_init()` writes `OA_TC6_REG_CONFIG0` with a value built
  from scratch (`SYNC | RXCTE | TXCTHRESH_8 | CPS_64 |…
- [Medium] Teardown ordering in `s2500_remove()` allows uninitialized
  stack data to be delivered as a TX hardware timestamp.
- [Medium] Turning TX timestamping off (`s2500_hwtstamp_set()` →
  `oa_tc6_hwtstamp_set()` → `oa_tc6_set_hwtstamp_settings()`) can race…
- [Medium] `s2500_init()` enables receive cut-through
  (`S2500_CONFIG0_RXCTE`, CONFIG0 bit 8), but the OA TC6 framework never…
- [Medium] net: ptp: max_adj exceeds 32-bit scaled_ppm limit
- [Low] In `s2500_probe()`, the check `if (spi->irq < 0) return -ENODEV;`
  can never be true.
- [Low] In the 1..3-address branch of `s2500_set_multicast_mode()`, each
  slot's `ADDRFILTH(slot)` is written with `S2500_MAC_ADDRFILT_ENABLE`…
- [Low] `s2500_ptp_step_time()` (used by `s2500_ptp_adjtime()`) reads
  PTP_SEC/NSEC in one SPI control transaction, adds `delta` in software,…
- [Low] On 32-bit kernels, `s2500_ptp_set_freq()` rejects the valid
  adjustment `scaled_ppm == LONG_MIN` (-2147483648, about -32768000 ppb).
- [Low] `s2500_probe()` acknowledges STATUS0
  (`oa_tc6_read_register(STATUS0)` then `oa_tc6_write_register(STATUS0,…
- [Low] `s2500_update_stats()` adds the hardware MAC statistic registers
  into `priv->stats_data[]` with `+=`, which assumes they clear on read.

--

onsemi: s2500: Add driver support for S2500 MAC-PHY

This adds a new SPI driver for the onsemi S2500 10BASE-T1S MAC-PHY,
built on the OA TC6 framework. It includes PTP hardware clock and
timestamping support, ethtool MAC/RMON/PHY stats, a register dump, and up
to three multicast address filters.

> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
> new file mode 100644
> index 0000000000000..062cab9460dcf
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
> @@ -0,0 +1,376 @@

[ ... ]

> +static const char s2500_mac_stat_strings[][ETH_GSTRING_LEN] = {
> +	"rx_mismatch_drops",
> +};
> +
> +static const u8 s2500_mac_stat_map[S2500_NUM_MAC_STATS] = {
> +	S2500_MSTRXDROPPED_IDX,
> +};

[Severity: Medium]
Does "rx_mismatch_drops" duplicate a counter that already has a standard
uAPI?

This string maps to S2500_MSTRXDROPPED_IDX (S2500_REG_MAC_STRXDROPPED).
That register counts frames dropped because the destination MAC did not
match. struct rtnl_link_stats64 already has rx_otherhost_dropped, which
include/uapi/linux/if_link.h documents as:

    @rx_otherhost_dropped: Number of packets dropped due to mismatch
      in destination MAC address.

The driver doesn't implement ndo_get_stats64. That means the value is
only visible through ethtool -S and not through ip -s link.

Could this be reported through rtnl_link_stats64.rx_otherhost_dropped
instead, with the private ETH_SS_STATS string dropped?

[ ... ]

> +static void s2500_update_stats(struct s2500_info *priv)
> +{
> +	u64 *data = priv->stats_data;
> +	u32 *regs, *rptr, addr;
> +	int ret;
> +
> +	if (time_is_after_jiffies(priv->stats_read_at +
> +				  S2500_STATS_CACHE_PERIOD))
> +		return;

[ ... ]

> +	/* Rest are 32-bit values until RX bytes register. */
> +	for (rptr += 2; (rptr - regs) < STAT_REG_OFFSET(OCTECTSRXL); ++rptr)
> +		*(data++) += *rptr;

[ ... ]

> +	for (rptr += 2; (rptr - regs) < S2500_NUM_STAT_REGS; ++rptr)
> +		*(data++) += *rptr;
> +out:
> +	kfree(regs);
> +}

[Severity: Low]
Can the 32-bit hardware counters wrap between reads?

s2500_update_stats() adds the clear-on-read registers into
priv->stats_data[] with +=. It only runs when user space calls one of
the ethtool stats callbacks. Nothing collects the counters periodically.

All counters except the TX/RX octet pairs are 32-bit. If nobody reads the
stats for long enough, the hardware counters wrap or saturate and the
64-bit totals silently lose counts. For the frame counters that is about
80 hours of minimum-size frames at 10 Mb/s.

> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_main.c b/drivers/net/ethernet/onsemi/s2500/s2500_main.c
> new file mode 100644
> index 0000000000000..4cd0f5d106665
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_main.c
> @@ -0,0 +1,523 @@

[ ... ]

> +static int s2500_init(struct s2500_info *priv)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/* Configure MAC-PHY's behavior */
> +	val = OA_TC6_CONFIG0_SYNC | S2500_CONFIG0_RXCTE |
> +	      (S2500_CONFIG0_TXCTHRESH_8 <<
> +	      S2500_CONFIG0_TXCTHRESH_SHIFT) |
> +	      (S2500_CONFIG0_CPS_64 << S2500_CONFIG0_CPS_SHIFT) |
> +	      OA_TC6_CONFIG0_FTSS_64BIT_TSTAMP;
> +
> +	ret = oa_tc6_write_register(priv->tc6, OA_TC6_REG_CONFIG0,
> +				    val);

[Severity: Medium]
Is it safe to build CONFIG0 from scratch here instead of doing a
read-modify-write?

Before s2500_init() runs, oa_tc6_init() has already cached CONFIG0.PROTE
in tc6->prot_ctrl. It has also set SYNC with a read-modify-write in
oa_tc6_enable_data_transfer():

drivers/net/ethernet/oa_tc6/oa_tc6.c:oa_tc6_check_ctrl_protection() {
    ...
	tc6->prot_ctrl = FIELD_GET(OA_TC6_CONFIG0_PROTE, regval);
    ...
}

This write clears every bit it doesn't list: PROTE, ZARFE, TXCTE and any
non-zero power-on defaults.

Suppose PROTE is 1 on this device. The hardware would then switch to
unprotected control framing while the framework keeps building and
checking protected frames. Every later control access would fail,
starting with s2500_set_mac_filter().

Also, TXCTHRESH is programmed without TXCTE, so that field has no effect.

The other CONFIG0 updates in the framework all use read-modify-write:
oa_tc6_enable_data_transfer(), the ZARFE helper and
oa_tc6_set_hwtstamp_settings().

[Severity: Medium]
Does enabling RX cut-through with S2500_CONFIG0_RXCTE work with the
current OA TC6 receive path?

In cut-through mode the MAC-PHY starts streaming a frame before it checks
FCS and length. At the end of the frame it sets the FD (frame drop, bit
15) flag in the data footer to tell the host to discard it.

oa_tc6_std_def.h has no definition for FD, and no code under
drivers/net/ethernet/oa_tc6/ checks it. So frames with a bad FCS, runts
and overflowed frames would reach netif_rx() as good frames. They would
also never be counted as RX errors.

lan865x doesn't set RXCTE, so this driver seems to be the first to run
into the missing FD handling.

[ ... ]

> +	} else {
> +		u32 addrh, addrl;

[ ... ]

> +		/* Slot 0 holds the unicast MAC, multicast starts at 1 */
> +		i = 1;
> +		netdev_hw_addr_list_for_each(ha, mc) {
> +			const u8 *mac = ha->addr;
> +			int slot = i++;
> +
> +			addrh = S2500_MAC_ADDRFILT_ENABLE |
> +				get_unaligned_be16(mac);
> +			addrl = get_unaligned_be32(&mac[2]);
> +
> +			addr = S2500_REG_MAC_ADDRFILTH(slot);
> +			ret = oa_tc6_write_register_mms(priv->tc6,
> +							mms, addr,
> +							addrh);
> +			if (ret)
> +				return ret;

[Severity: Low]
Should ADDRFILTH(slot) with S2500_MAC_ADDRFILT_ENABLE be written last,
after the low address and mask registers?

s2500_set_mac_filter() writes the masks, then the low address, then the
high address with the enable bit. This loop enables the slot first.

Take a switch from IFF_ALLMULTI (or more than 3 groups) to a short list.
The earlier loop only zeroes ADDRFILTH, so slot 1 still has ADDRMASKL=0
and ADDRMASKH=0x100 from the wildcard setup. Enabling it again with a
multicast address briefly makes it match all multicast frames.

If one of the later SPI writes fails, the function returns with the slot
enabled on a mix of old and new address and mask values. The hardware
filter then no longer matches the stack's mc list.

[ ... ]

> +static int s2500_hwtstamp_set(struct net_device *ndev,
> +			      struct kernel_hwtstamp_config *cfg,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +
> +	return oa_tc6_hwtstamp_set(priv->tc6, cfg);
> +}

[Severity: Medium]
Can turning TX timestamping off here leave an skb stuck on tx_ts_skb_q?

The call chain is s2500_hwtstamp_set()->oa_tc6_hwtstamp_set()->
oa_tc6_set_hwtstamp_settings(). That function masks the TTSC interrupts,
clears hw_tstamp_enabled and drains tx_ts_skb_q:

	if (ts_cfg->tx_type != HWTSTAMP_TX_ON)
		oa_tc6_cleanup_tx_tstamp_skbs(tc6);

The cleanup doesn't cover tc6->ongoing_tx_skb.
oa_tc6_prepare_spi_tx_buf_for_tx_skbs() reserves a capture slot (tsc)
for that skb under tx_skb_lock and then drops the lock. A frame longer
than the available TX credits stays in ongoing_tx_skb across SPI
transfers.

When the IRQ thread finishes that frame, oa_tc6_add_tx_skb_to_spi_buf()
queues it again based only on the stored tsc:

	if (!oa_tc6_tsinfo_tx(tc6->ongoing_tx_skb)->tsc) {
		kfree_skb(tc6->ongoing_tx_skb);
	} else {
		spin_lock_bh(&tc6->tx_skb_lock);
		list_add_tail(&tc6->ongoing_tx_skb->list,
			      &tc6->tx_ts_skb_q);

The skb and its ts_ttsc_pending slot then stay stuck while the completion
interrupt is masked.

If timestamping is turned back on, the stale STATUS0 capture bit is
cleared without delivering the timestamp. The slot stays reserved until
the next disable or until the driver is removed.

The code involved is the oa_tc6 timestamp support added earlier in the
series. This driver's ndo_hwtstamp_set is the path that reaches it.

[ ... ]

> +static int s2500_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct net_device *ndev;
> +	struct s2500_info *priv;
> +	u32 val;
> +	int ret;
> +
> +	if (spi->irq < 0)
> +		return -ENODEV;

[Severity: Low]
Can this check ever be true?

spi_probe() in drivers/spi/spi.c clamps negative IRQ values to 0 before
it calls the driver's probe:

	if (spi->irq < 0)
		spi->irq = 0;

A device without an interrupt therefore passes this check. It goes
through the whole oa_tc6_init() sequence (reset, MDIO/PHY registration,
SYNC enable) and only fails at devm_request_threaded_irq() with irq 0,
which gives a misleading error.

Should this be spi->irq <= 0?

[ ... ]

> +	priv->tc6 = oa_tc6_init(spi, ndev, NULL);

[ ... ]

> +	/* Acknowledge all IRQ status bits */
> +	ret = oa_tc6_read_register(priv->tc6,
> +				   OA_TC6_REG_STATUS0, &val);
> +	if (!ret) {
> +		/* Clear read only bit */
> +		val &= ~S2500_STATUS0_PHY_INT;
> +		oa_tc6_write_register(priv->tc6,
> +				      OA_TC6_REG_STATUS0, val);
> +	}

[Severity: Low]
Does this STATUS0 acknowledge race with the oa_tc6 IRQ thread?

Before it returns, oa_tc6_init() has already requested the threaded IRQ,
set int_flag and called irq_wake_thread().

The IRQ thread does its own read-then-clear of STATUS0 in
oa_tc6_process_extended_status(). It acts on the bits it reads: RX
overflow recovery, TX protocol, loss-of-frame and header errors, and
timestamp captures:

	value = regs[0];
	...
	if (!value)
		return 0;

Each SPI access takes spi_ctrl_lock, but the read and the write here run
under separate lock sections. If probe reads and clears a bit first, the
thread then reads 0 and the event is lost.

STATUS0 is owned by the framework. Could this acknowledge be removed, or
done before the IRQ thread can run?

[ ... ]

> +static void s2500_remove(struct spi_device *spi)
> +{
> +	struct s2500_info *priv = spi_get_drvdata(spi);
> +
> +	dev_dbg(&priv->ndev->dev, "%s", "s2500_remove\n");
> +
> +	unregister_netdev(priv->ndev);
> +	oa_tc6_ptp_unregister(priv->tc6);
> +	oa_tc6_exit(priv->tc6);
> +}

[Severity: Medium]
Is this teardown order safe for TX timestamps that are still pending?

oa_tc6_ptp_unregister() sets tc6->ptp_clock to NULL. The IRQ stays active
until oa_tc6_exit(), which is also the call that drains tx_ts_skb_q.
s2500_stop() doesn't drain that queue, so timestamped skbs can still be
pending at this point.

Suppose the IRQ thread handles a TX timestamp capture in that window.
oa_tc6_process_extended_status() sees ts_valid == false and reads only
STATUS0 into regs[0]. It still passes the rest of the array to the event
handler:

	bool ts_valid = !!tc6->ptp_clock;
	...
	ret = oa_tc6_read_registers(tc6, OA_TC6_REG_STATUS0, regs,
				    ts_valid ?
				    OA_TC6_STATUS0_TTSC_REG_COUNT : 1);
	...
	if ((value & OA_TC6_STATUS0_TTSCA_MASK) != 0)
		oa_tc6_events_handle(tc6, value &
				     OA_TC6_STATUS0_TTSCA_MASK,
				     &regs[OA_TC6_TTSC_REG_OFFSET]);

oa_tc6_events_handle() then builds the timestamp from uninitialized stack
words:

	ski->hwtstamp = ktime_set(ts[2 * bit_num],
				  ts[2 * bit_num + 1]);

and delivers it to the socket through skb_tstamp_tx().

Could the IRQ be quiesced, or the timestamp queue drained, before the PHC
is unregistered? Could oa_tc6_events_handle() also be skipped when the
TTSC registers were not read?

> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c b/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c
> new file mode 100644
> index 0000000000000..2bcf69c0d6a2e
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c
> @@ -0,0 +1,174 @@

[ ... ]

> +static int s2500_ptp_set_freq(struct s2500_info *priv, long scaled_ppm)
> +{
> +	u32 sign_bit = 0;
> +	long adj;
> +	u32 val;
> +	u64 ppm;
> +
> +	if (scaled_ppm < 0) {
> +		/* split sign / mod */
> +		sign_bit = 1U << 31;
> +		scaled_ppm = ~scaled_ppm + 1;
> +	}

[ ... ]

> +	ppm = (u64)scaled_ppm * 125;
> +	do_div(ppm, 1024);
> +	adj = (long)ppm;
> +
> +	/* check overflow */
> +	if (adj > S2500_PTP_ADJ_MAX)
> +		return -ERANGE;

[Severity: Low]
On 32-bit kernels, what happens here when scaled_ppm == LONG_MIN?

That value is about -32768000 ppb. It passes ptp_clock_adjtime()'s check
against max_adj = S2500_PTP_MAX_ADJ_PPB (33554431).

However, ~scaled_ppm + 1 can't represent +2^31 in a 32-bit long, so the
value stays LONG_MIN. (u64)scaled_ppm then sign-extends, the multiply and
do_div() wrap, and adj ends up as -262144000.

In the adj > S2500_PTP_ADJ_MAX comparison, adj is converted to unsigned
long (4032823296). The function returns -ERANGE even though the correct
magnitude, 262144000, fits in the 28-bit field.

Could the magnitude be computed in a wider unsigned type before the
negation?

[ ... ]

> +static int s2500_ptp_step_time(struct s2500_info *priv, s64 delta)
> +{
> +	struct timespec64 target, now, delta_ts;
> +	struct ptp_system_timestamp sts;
> +	int ret;
> +
> +	memset(&sts, 0, sizeof(sts));
> +	ret = s2500_ptp_get_time64(&priv->ptp_clock_info, &now, &sts);
> +	if (ret)
> +		return ret;
> +	if (delta >= 0) {
> +		delta_ts = ns_to_timespec64(delta);
> +		target = timespec64_add(now, delta_ts);
> +	} else {
> +		delta_ts = ns_to_timespec64(-delta);
> +		target = timespec64_sub(now, delta_ts);
> +	}
> +	/* The subtraction above can take the target below the epoch */
> +	if (target.tv_sec < 0)
> +		return -ERANGE;
> +	return s2500_ptp_write_time(priv, &target);
> +}

[Severity: Low]
Does this read-then-write lose the time spent between the two SPI
transactions?

s2500_ptp_get_time64() latches PTP_SEC/PTPNSEC in one control
transaction. delta is added in software, and s2500_ptp_write_time() sets
the absolute result (bit 31 executes the set) in a second transaction.

The time in between is never added back. It covers two control frames
plus contention with data chunks on the same bus. The pre/post system
timestamps captured in sts are also thrown away.

As a result, every ADJ_SETOFFSET leaves the PHC behind the requested
value by roughly the SPI round-trip latency.

Could the elapsed time measured through sts be used to compensate?

[ ... ]

> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
> + * onsemi's S2500 10BASE-T1S MAC-PHY driver
> + */
> +
> +#include "s2500_hw_def.h"
> +
> +static int s2500_ptp_get_time64(struct ptp_clock_info *ptp,
> +				struct timespec64 *ts,
> +				struct ptp_system_timestamp *ptp_sts)
> +{
> +	struct s2500_info *priv = container_of(ptp, struct s2500_info,
> +					       ptp_clock_info);
> +	u32 data[2];
> +	u32 addr;
> +	int ret;
> +
> +	ptp_read_system_prets(ptp_sts);
> +	addr = FIELD_PREP(S2500_REG_MMS_MASK,
> +			  OA_TC6_PHY_C45_VS_MMS12) |
> +			  S2500_REG_VS_PTP_SEC;
> +	ret = oa_tc6_read_registers(priv->tc6, addr, &data[0], 2);
> +	ptp_read_system_postts(ptp_sts);
> +
> +	if (!ret) {
> +		ts->tv_sec = data[0];
> +		ts->tv_nsec = data[1];
> +	}
> +
> +	return ret;
> +}
> +
> +static int s2500_ptp_write_time(struct s2500_info *priv,
> +				const struct timespec64 *ts)
> +{
> +	u32 data[2];
> +	u32 addr;
> +
> +	lockdep_assert_held(&priv->ptp_adj_lock);
> +
> +	if (ts->tv_sec >= (1ULL << 32))
> +		return -ERANGE;
> +
> +	data[0] = (u32)ts->tv_sec;
> +	/* bit 31 = execute set command */
> +	data[1] = ts->tv_nsec | BIT(31);
> +	addr = FIELD_PREP(S2500_REG_MMS_MASK,
> +			  OA_TC6_PHY_C45_VS_MMS12) |
> +			  S2500_REG_VS_PTP_SETSEC;
> +
> +	return oa_tc6_write_registers(priv->tc6, addr, &data[0], 2);
> +}
> +
> +static int s2500_ptp_set_time64(struct ptp_clock_info *ptp,
> +				const struct timespec64 *ts)
> +{
> +	struct s2500_info *priv = container_of(ptp, struct s2500_info,
> +					       ptp_clock_info);
> +	int ret;
> +
> +	mutex_lock(&priv->ptp_adj_lock);
> +	ret = s2500_ptp_write_time(priv, ts);
> +	mutex_unlock(&priv->ptp_adj_lock);
> +
> +	return ret;
> +}
> +
> +static int s2500_ptp_set_freq(struct s2500_info *priv, long scaled_ppm)
> +{
> +	u32 sign_bit = 0;
> +	long adj;
> +	u32 val;
> +	u64 ppm;
> +
> +	if (scaled_ppm < 0) {
> +		/* split sign / mod */
> +		sign_bit = 1U << 31;
> +		scaled_ppm = ~scaled_ppm + 1;
> +	}
> +
> +	/*
> +	 * Convert unsigned scaled_ppm to atto-seconds per clock cycles.
> +	 * The scaled_ppm format is Qx.16 --> 1 lsb = 1/65536 ppm.
> +	 * The clock period of the S2500 is 8ns (125 MHz), so 1 lsb of
> +	 * adj register LSB is 1 atto-sec / 8ns = 0.000125 ppm.
> +	 * Represented in Qx.16 format, this is 0.000125 * 2^16 = 8(.192)
> +	 * To convert scaled_ppm into a register value we need to divide
> +	 * it by the LSB value, hence adj = (scaled_ppm * 1000) / 8192 to
> +	 * minimize the precision loss due to the integer arithmetic.
> +	 * That further reduces to (scaled_ppm * 125) / 1024.
> +	 */
> +	ppm = (u64)scaled_ppm * 125;
> +	do_div(ppm, 1024);
> +	adj = (long)ppm;
> +
> +	/* check overflow */
> +	if (adj > S2500_PTP_ADJ_MAX)
> +		return -ERANGE;
> +
> +	val = (u32)adj | sign_bit;
> +	return oa_tc6_write_register_mms(priv->tc6, OA_TC6_PHY_C45_VS_MMS12,
> +					 S2500_REG_VS_PTP_ADJ, val);
> +}
> +
> +static int s2500_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct s2500_info *priv = container_of(ptp, struct s2500_info,
> +					       ptp_clock_info);
> +
> +	return s2500_ptp_set_freq(priv, scaled_ppm);
> +}
> +
> +static int s2500_ptp_step_time(struct s2500_info *priv, s64 delta)
> +{
> +	struct timespec64 target, now, delta_ts;
> +	struct ptp_system_timestamp sts;
> +	int ret;
> +
> +	memset(&sts, 0, sizeof(sts));
> +	ret = s2500_ptp_get_time64(&priv->ptp_clock_info, &now, &sts);
> +	if (ret)
> +		return ret;
> +	if (delta >= 0) {
> +		delta_ts = ns_to_timespec64(delta);
> +		target = timespec64_add(now, delta_ts);
> +	} else {
> +		delta_ts = ns_to_timespec64(-delta);
> +		target = timespec64_sub(now, delta_ts);
> +	}
> +	/* The subtraction above can take the target below the epoch */
> +	if (target.tv_sec < 0)
> +		return -ERANGE;
> +	return s2500_ptp_write_time(priv, &target);
> +}
> +
> +static int s2500_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	struct s2500_info *priv = container_of(ptp, struct s2500_info,
> +					       ptp_clock_info);
> +	int ret;
> +
> +	/* Nothing to do */
> +	if (delta == 0)
> +		return 0;
> +
> +	/* The device has no add-delta register, so the offset is applied as
> +	 * a read-modify-write of the time registers.
> +	 */
> +	mutex_lock(&priv->ptp_adj_lock);
> +	ret = s2500_ptp_step_time(priv, delta);
> +	mutex_unlock(&priv->ptp_adj_lock);
> +
> +	return ret;
> +}
> +
> +int s2500_ptp_register(struct s2500_info *priv)
> +{
> +	struct ptp_clock_info *info = &priv->ptp_clock_info;
> +	int ret;
> +
> +	info->max_adj = S2500_PTP_MAX_ADJ_PPB;
> +	info->owner = THIS_MODULE;
> +	info->adjfine = s2500_ptp_adjfine;
> +	info->gettimex64 = s2500_ptp_get_time64;
> +	info->settime64 = s2500_ptp_set_time64;
> +	info->adjtime = s2500_ptp_adjtime;
> +
> +	ret = oa_tc6_ptp_register(priv->tc6, info);
> +	if (ret)
> +		dev_err(&priv->spi->dev, "PTP registration failed\n");
> +	return ret;
> +}
> +

[Severity: Medium]
Can the advertised max_adj be larger than what a 32-bit long
scaled_ppm can carry?

S2500_PTP_MAX_ADJ_PPB works out to 268435455 / 8 = 33554431 ppb. The
PTP core passes the adjustment to ->adjfine() as scaled_ppm in a long,
and 1 ppb is 65.536 units of scaled_ppm. On a 32-bit kernel the largest
positive scaled_ppm is LONG_MAX, which is only about 32767999 ppb.

Take a request for +33000000 ppb. The scaled_ppm value is about
2162688000, which does not fit in a 32-bit long. ptp_clock_adjtime()
passes the 64-bit tx->freq to scaled_ppm_to_ppb() and to ->adjfine(),
both of which take a long, so the value is truncated to a large
negative number.

That negative number still converts to roughly -32.5 million ppb. This
is inside [-max_adj, max_adj], so the range check passes.
s2500_ptp_adjfine() then programs a large negative frequency offset
into S2500_REG_VS_PTP_ADJ.

User space does not get -ERANGE. Instead the servo's correction is
applied in the opposite direction, and the PHC is driven away from its
reference rather than towards it. SPI MAC-PHYs like this one are likely
to end up on 32-bit ARM boards, so this is not just a theoretical case.

Should max_adj be capped at 32767999 so the advertised range always
fits in a 32-bit scaled_ppm? Or is there a reason to keep the full
28-bit hardware range? This also interacts with the LONG_MIN handling
in s2500_ptp_set_freq() mentioned above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d%40onsemi.com
