Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44AD4BD780;
	Sat, 10 Oct 2026 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661225; cv=none; b=W0fWCMkKYwJtkUmwiCIzHPAONPfT+RVFUdldmytDTPv1XLW9bYp2TGrk9gHjUS7qMxELSecIcCdgLKTooHFvU2ACdxD2ez42QvCaBM3FIRgkcfVZNNPUevtCGDLzNec4M5uL1qRisOs+QGl4GovjVBp21tcHFIevjoE4fmvYjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661225; c=relaxed/simple;
	bh=YC6Ii+gjuimM6P1SK0Wm2v6lhhfy9XB8nXKAFEp0Zco=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmIgh9p4flW0gDwpgxetbVtBL1Kf/W4J2ecww3bb5FWu3PAaCK/p5uAlYMIt7bCKGxsDEXJoZa7WfKWAEEnKYyixCv2Xw1c8XSDV9JHoKEwdJi5Hw1BDHQr3wR5ME5LVSKmLTEx0IjH3yCc39P8XllqCWU9wifNtUIInDulCrNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COiJX8d3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COiJX8d3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603031F00899;
	Sat, 10 Oct 2026 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661218;
	bh=VLSX4oKA1+zX7MDJkV5AxbmlyoprxKA2wG6+E+9EQ/s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=COiJX8d343rt0jTJgGoovxhTym7zt+Fkgee49Zbn9xI0pmMBPQM/m3kfqotuQJrr6
	 6vCRi9sXsY8xYLr9/QUI4q338ayKcMo09RoNykhiHNuRNGHNOB53IaF3+vIeLl8Pw5
	 g1l8Ivdo0C96PR8Xkt05bp7EhZT0m87HELKU8gqUetCGG+qjV1v4mKIGN+JYteis7Z
	 Rd0BerurEH+DXPeqKNAey9e/Dqj5lGriDwrYQkDtFLXyqJAfsXvhDGwf8UaFIRLP1b
	 Z8sCjwNLMUFevgQp7SFwEKuDL3FOKk9+4l/0HzQigRGK0LPQ0O+SpEsYXyPqnrs7Fz
	 qdN/16ZucedDw==
Subject: Re: [PATCH net-next v9 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
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
Date: Sat, 10 Oct 2026 19:40:15 +0000
Message-ID: <179166121588.434549.8045630710790753700@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-5-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-5-dcefe1d0bf0d@onsemi.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 5 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] oa_tc6_process_extended_status() declares 'u32
  regs[OA_TC6_STATUS0_TTSC_REG_COUNT]' (14 entries) without initialising…
- [High] net/oa_tc6: TOCTOU race in HWTSTAMP settings unmasks interrupts
- [Medium] A TX timestamp capture slot that never completes is never
  reclaimed.
- [Medium] oa_tc6_req_tx_hwtstamp() puts two cases into tx_hwtstamp_lost,
  which oa_tc6_get_ts_stats() reports as ethtool_ts_stats.lost.
- [Medium] When tc6->ptp_clock is NULL, oa_tc6_get_ts_info() returns
  ethtool_op_get_ts_info().
- [Medium] A TX ON->OFF hwtstamp change races with an in-flight skb that
  already holds a slot.
- [Medium] When all three TTSC slots are pending,
  oa_tc6_req_tx_hwtstamp() returns true and…
- [Low] Concern: the six exported APIs (oa_tc6_ptp_register/unregister,
  oa_tc6_hwtstamp_set/get, oa_tc6_get_ts_info, oa_tc6_get_ts_stats) have…
- [Low] The comment in oa_tc6_process_extended_status() says that when
  timestamping is disabled only STATUS0 is read, and that the TTSC…
- [Low] oa_tc6_set_hwtstamp_settings() makes three dependent control
  writes in order: STATUS0 W1C (line 69), INT_MASK0 (line 78), CONFIG0…
- [Low] tx_hwtstamp_pkts, tx_hwtstamp_lost and tx_hwtstamp_err in struct
  oa_tc6 are plain u64 fields.

--

net: ethernet: oa_tc6: Support for hardware timestamp

This adds hardware timestamping support to the OPEN Alliance TC6
framework: PTP clock register/unregister helpers, hwtstamp get/set, and
ethtool ts_info/ts_stats helpers for vendor drivers. TX frames that
request a timestamp get one of three TTSC capture slots, and RX
timestamps are taken from the frame prefix.

> Interface for ndo_hwtstamp_set/get, control and status
> callback for ethtool are provided to support hardware timestamp
> feature. ioctl interface passes the request to PHY.

[Severity: Low]
This isn't a bug, but does the last sentence apply to this patch? I
couldn't find any ioctl handling added here. It looks like it describes
the vendor driver's .ndo_eth_ioctl = phy_do_ioctl_running instead.

The rest of the paragraph holds up. The exported helpers are used by the
later "onsemi: s2500: Add driver support for S2500 MAC-PHY" patch in this
series. The new PTP_1588_CLOCK_OPTIONAL dependencies on LAN865X and
ADIN1140 are also needed, because both select OA_TC6.

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6.c
> index f8e9309a72f11..0b6e216de8a1b 100644
> --- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c

[ ... ]

> @@ -50,6 +61,193 @@ static int oa_tc6_get_parity(u32 p)
>  	return !((p >> 28) & 1);
>  }
>  

[ ... ]

> +static bool oa_tc6_req_tx_hwtstamp(struct oa_tc6 *tc6, struct sk_buff *skb)
> +{
> +	u8 tsc;
> +	u8 i;
> +
> +	lockdep_assert_held(&tc6->tx_skb_lock);
> +
> +	if (!skb || !(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> +		return false;
> +
> +	if (!tc6->hw_tstamp_enabled)
> +		return false;
> +
> +	if (tc6->ts_config.tx_type != HWTSTAMP_TX_ON) {
> +		tc6->tx_hwtstamp_lost++;
> +		return false;
> +	}

[Severity: Medium]
Should this count as err rather than lost? The kernel-doc for struct
ethtool_ts_stats in include/linux/ethtool.h defines @lost as requests
where the hardware timestamp never arrived. It puts resource exhaustion
and unavailability under @err.

Here TX timestamping is just not enabled (only the RX filter is). The
slot exhaustion case below never asks the hardware for a timestamp
either. Only the increment in oa_tc6_cleanup_tx_tstamp_skbs() seems to
fit the @lost definition.

> +
> +	tsc = tc6->ttsc_current_id;
> +	for (i = 0; i < OA_TC6_TTSCC_REG_ID; i++) {
> +		if (!(tc6->ts_ttsc_pending &
> +		    BIT(tsc - OA_TC6_TTSCA_REG_ID)))
> +			goto slot_found;
> +		tsc = oa_tc6_next_tsc(tsc);
> +	}
> +
> +	/* All the three slots are waiting for its event. This skb
> +	 * can't request timestamp. Marking it to be dropped.
> +	 */
> +	tc6->tx_hwtstamp_lost++;
> +	return true;

[Severity: Medium]
What frees a slot if its capture event never arrives?

During normal operation, a bit in ts_ttsc_pending is cleared only in
oa_tc6_events_handle(). That happens when STATUS0 reports TTSCAx and a
matching skb is already on tx_ts_skb_q. Otherwise only teardown or a TX
ON->OFF change clears it. There is no timeout, and STATUS1, where missed
or overflowed captures are reported, is never read.

A capture can also be acknowledged without being delivered. One way is
the STATUS0 write-one-to-clear in oa_tc6_set_hwtstamp_settings(). Another
is the ON->OFF race described further down.

Once three slots are stuck, every SKBTX_HW_TSTAMP frame takes this path
and oa_tc6_prepare_spi_tx_buf_for_tx_skbs() drops it. The skbs stay
pinned on tx_ts_skb_q. PTP traffic would stop until TX timestamping is
toggled off or the device is torn down.

The commit message says three capture registers "are plenty". Does that
assume slots are always returned?

[ ... ]

> @@ -686,15 +897,28 @@ static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
>  
>  static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
>  {
> +	u32 regs[OA_TC6_STATUS0_TTSC_REG_COUNT];
> +	bool ts_valid = !!tc6->ptp_clock;
>  	u32 value;
>  	int ret;
>  
> -	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &value);
> +	/* When timestamp is disabled, there is no behavior change
> +	 * as it reads only STATUS0 register. When enabled,
> +	 * TTSCA_HIGH..TTSCC_LOW are fetched together with STATUS0
> +	 * to avoid having to make second SPI transaction. Reading few
> +	 * extra registers, even it may not be needed every time this
> +	 * function is called, it is more efficient than making second
> +	 * SPI transaction, when needed.
> +	 */
> +	ret = oa_tc6_read_registers(tc6, OA_TC6_REG_STATUS0, regs,
> +				    ts_valid ?
> +				    OA_TC6_STATUS0_TTSC_REG_COUNT : 1);

[Severity: Low]
Does this comment match the code? ts_valid comes from tc6->ptp_clock,
which is set once in oa_tc6_ptp_register(). It doesn't depend on the
hwtstamp configuration.

With a PHC registered and hwtstamp left at the default OFF, every
extended status event reads all 14 registers from STATUS0 through
TTSCC_LOW, including the reserved ones in between.

>  	if (ret) {
>  		netdev_err(tc6->netdev, "STATUS0 register read failed: %d\n",
>  			   ret);
>  		return ret;
>  	}
> +	value = regs[0];
>  

[ ... ]

> @@ -703,6 +927,11 @@ static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
>  	if (!value)
>  		return 0;
>  
> +	if ((value & OA_TC6_STATUS0_TTSCA_MASK) != 0)
> +		oa_tc6_events_handle(tc6, value &
> +				     OA_TC6_STATUS0_TTSCA_MASK,
> +				     &regs[OA_TC6_TTSC_REG_OFFSET]);

[Severity: High]
Can this pass uninitialized stack to oa_tc6_events_handle()? regs[] is
not initialized, and when ts_valid is false only regs[0] is read. This
call checks only the STATUS0 bits, not ts_valid.

oa_tc6_ptp_unregister() clears ptp_clock but leaves the rest alone. FTSE
stays enabled, the TTSC interrupts stay unmasked, ts_config is unchanged,
and tx_ts_skb_q is not drained:

void oa_tc6_ptp_unregister(struct oa_tc6 *tc6)
{
	if (tc6->ptp_clock) {
		ptp_clock_unregister(tc6->ptp_clock);
		tc6->ptp_clock = NULL;
	}
}

The s2500 driver later in this series calls unregister_netdev(), then
oa_tc6_ptp_unregister(), then oa_tc6_exit(). The IRQ thread keeps
running until oa_tc6_exit() calls disable_irq(). ptp_clock_unregister()
can sleep, which makes that window wider.

If a TTSCAx event arrives in that window for an skb still on
tx_ts_skb_q, oa_tc6_events_handle() does:

	ski->hwtstamp = ktime_set(ts[2 * bit_num],
				  ts[2 * bit_num + 1]);
	...
	skb_tstamp_tx(skb, &tstamp);

Here ts[] points into the uninitialized part of regs[]. That value then
reaches the owning socket's error queue. The socket only needs
SOF_TIMESTAMPING_TX_HARDWARE, which requires no privilege.

Would zero-initializing regs[], or gating this call on ts_valid, fix it?

[ ... ]

> @@ -1100,10 +1360,21 @@ static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(struct oa_tc6 *tc6)
>  	for (used_tx_credits = 0; used_tx_credits < tc6->tx_credits;
>  	     used_tx_credits++) {
>  		if (!tc6->ongoing_tx_skb) {
> +			drop_skb = NULL;
>  			spin_lock_bh(&tc6->tx_skb_lock);
>  			tc6->ongoing_tx_skb = tc6->waiting_tx_skb;
>  			tc6->waiting_tx_skb = NULL;
> +			if (oa_tc6_req_tx_hwtstamp(tc6,
> +						   tc6->ongoing_tx_skb)) {
> +				drop_skb = tc6->ongoing_tx_skb;
> +				tc6->ongoing_tx_skb = NULL;
> +				if (!tc6->disable_traffic &&
> +				    netif_running(tc6->netdev) &&
> +				    netif_queue_stopped(tc6->netdev))
> +					netif_wake_queue(tc6->netdev);
> +			}
>  			spin_unlock_bh(&tc6->tx_skb_lock);
> +			oa_tc6_drop_tx_skb(tc6, drop_skb);

[Severity: Medium]
Would it be better to send the frame without a timestamp here, rather
than drop it?

Every socket on the device shares the three slots. Once an admin enables
TX timestamping, any local process can set SOF_TIMESTAMPING_TX_HARDWARE
on its own socket and keep the slots busy with small frames. Several
timestamping applications running together could also do this by
accident.

Other users' timestamped frames, such as ptp4l event messages or chrony's
hardware-timestamped NTP, would then not be sent at all. They would not
just lose their timestamp.

[ ... ]

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c b/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c
> new file mode 100644
> index 0000000000000..539cbd36a1d04
> --- /dev/null
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c
> @@ -0,0 +1,224 @@

[ ... ]

> +static int oa_tc6_set_hwtstamp_settings(struct oa_tc6 *tc6,
> +					const struct hwtstamp_config *ts_cfg)
> +{
> +	u32 regs[CFG0_TO_IMASK0_REG_COUNT];
> +	u32 cfg0, irqm, status0;
> +	bool disabled;
> +	int ret;
> +
> +	if (tc6->ts_config.flags == ts_cfg->flags &&
> +	    tc6->ts_config.tx_type == ts_cfg->tx_type &&
> +	    tc6->ts_config.rx_filter == ts_cfg->rx_filter)
> +		return 0;

[ ... ]

> +	ret = oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, irqm);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "failed to write IRQM register\n");
> +		goto out;
> +	}
> +
> +	ret = oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, cfg0);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "failed to write CFG0 register\n");
> +		goto out;
> +	}

[Severity: High]
Can oa_tc6_disable_traffic() run in the middle of this sequence?

The disable_traffic check above is done under tx_skb_lock. That lock is
dropped before the CONFIG0..INT_MASK0 block is read.
oa_tc6_read_registers() and oa_tc6_write_register() each take
spi_ctrl_lock only for their own transfer. So the read-modify-write of
INT_MASK0 is not atomic against the SPI thread.

Suppose the SPI thread hits a fatal error in that window.
oa_tc6_disable_traffic() then sets disable_traffic and writes
OA_TC6_INT_MASK0_ALL_INTERRUPTS to stop an interrupt storm. After that,
this function writes its own irqm back, and there are two cases:

- irqm was read before the emergency mask, so it is stale.
- irqm was read after the emergency mask, and then the TTSC mask bits
  were cleared for TX ON.

Either way, interrupts are unmasked on a device that was deliberately
silenced. The IRQ is requested with IRQF_TRIGGER_LOW, so this could
bring back the interrupt storm that oa_tc6_disable_traffic() is meant
to prevent. The CONFIG0 write and the ts_config/hw_tstamp_enabled
update also land after the device has already been given up on.

Could this whole sequence be serialized against
oa_tc6_disable_traffic(), for example with a mutex taken on both paths?
Rechecking disable_traffic after the writes and re-masking everything
would narrow the window, but would it close it?

[Severity: Low]
What happens if the CONFIG0 write fails after INT_MASK0 has been written?

On an ON->OFF request, the TTSC interrupts are now masked. FTSE is still
set, ts_config.tx_type is still HWTSTAMP_TX_ON, and hw_tstamp_enabled is
still true. Nothing restores INT_MASK0.

oa_tc6_req_tx_hwtstamp() would keep handing out slots whose completions
can no longer raise an interrupt. A later request for the old ON
configuration hits the cached-config early return at the top of this
function. It returns 0 without fixing INT_MASK0.

Should the earlier writes be rolled back on failure?

> +	spin_lock_bh(&tc6->tx_skb_lock);
> +	tc6->ts_config = *ts_cfg;
> +	if (cfg0 & OA_TC6_CONFIG0_FTSE_ENABLE)
> +		tc6->hw_tstamp_enabled = true;
> +	else
> +		tc6->hw_tstamp_enabled = false;
> +	spin_unlock_bh(&tc6->tx_skb_lock);
> +
> +	/* The TX timestamp completion interrupt is masked now. Time
> +	 * to release the queued skbs.
> +	 */
> +	if (ts_cfg->tx_type != HWTSTAMP_TX_ON)
> +		oa_tc6_cleanup_tx_tstamp_skbs(tc6);

[Severity: Medium]
Does this miss an skb that already holds a slot but is still in
tc6->ongoing_tx_skb?

When TX credits run out, a multi-chunk frame can stay in ongoing_tx_skb
across several SPI transfers. If this ON->OFF change runs during that
time, oa_tc6_cleanup_tx_tstamp_skbs() drains only what is already on
tx_ts_skb_q.

Later the SPI thread finishes the frame in oa_tc6_add_tx_skb_to_spi_buf()
and queues it based only on its cached tsc:

		if (!oa_tc6_tsinfo_tx(tc6->ongoing_tx_skb)->tsc) {
			kfree_skb(tc6->ongoing_tx_skb);
		} else {
			spin_lock_bh(&tc6->tx_skb_lock);
			list_add_tail(&tc6->ongoing_tx_skb->list,
				      &tc6->tx_ts_skb_q);
			spin_unlock_bh(&tc6->tx_skb_lock);
		}

Its completion interrupt is now masked. On the next OFF->ON change, the
STATUS0 write clears any latched TTSC bit without delivering it. The skb
pins its socket memory until the next ON->OFF change or teardown. Only
two slots stay usable while TX timestamping is ON.

Each later OFF transition drains it, so this alone strands at most one
skb and slot at a time. It can still combine with the missing slot
reclaim mentioned above.

[ ... ]

> +void oa_tc6_get_ts_stats(struct oa_tc6 *tc6,
> +			 struct ethtool_ts_stats *stats)
> +{
> +	stats->pkts = tc6->tx_hwtstamp_pkts;
> +	stats->err = tc6->tx_hwtstamp_err;
> +	stats->lost = tc6->tx_hwtstamp_lost;
> +}

[Severity: Low]
Can these reads tear on 32-bit architectures? These are plain u64 fields
in struct oa_tc6. The SPI thread updates them mostly under tx_skb_lock,
but this function reads them without the lock or a u64_stats_sync.

Separately, oa_tc6_events_handle() updates tx_hwtstamp_err after
spin_unlock_bh():

	if (val & ~handled) {
		tc6->tx_hwtstamp_err += hweight32(val & ~handled);

The other updates to the same field are done under the lock. All writers
are in the SPI thread, so writers can't race each other, but the locking
is inconsistent.

[ ... ]

> +int oa_tc6_get_ts_info(struct oa_tc6 *tc6,
> +		       struct kernel_ethtool_ts_info *info)
> +{
> +	if (!tc6->ptp_clock)
> +		return ethtool_op_get_ts_info(tc6->netdev, info);

[Severity: Medium]
Does this fallback advertise something the driver doesn't do?
ethtool_op_get_ts_info() sets SOF_TIMESTAMPING_TX_SOFTWARE, but neither
oa_tc6_start_xmit() nor oa_tc6_add_tx_skb_to_spi_buf() calls
skb_tx_timestamp().

This path is taken when STDCAP lacks the timestamp capability. It is
also taken with PTP_1588_CLOCK=n, because the ptp_clock_register() stub
returns NULL. Tools such as ptp4l -S would then wait for software TX
timestamps that never arrive.

The core default in net/ethtool/common.c reports only RX_SOFTWARE and
SOFTWARE. Would falling back to that default work here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d%40onsemi.com
