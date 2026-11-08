Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096940;
	b=c7RG+tgYPnHpSJijABxaJ4+/Y3y1XfmP38ZBvovMkDAFsarPxotPwHrkywYF3PkS5EQA
	 vHIyGaO7fGyjHiA+XjSdqw7+MXAkpUAV3Kx4k0qw7tHPJk4bkXYVSwlDhb/ZL+QYVr5DP
	 s47Ws3i9OvS3ERiXnpl1/DySXtE2Wl/7KKtEoqEiGKkkkx7Ljkcyufc4peFRUQRNiJ1P0
	 +x1Yf4aumeeMQtRdk/IhNiXvnJrSdKQVp5k843OuPbRBXOADhwCsQqRPP4JocRIFd44dk
	 7GCtOU0MJqT8WMoj79ZJXl2tj3q1SSEabuy+nhK465YmcFD35gbVppphJgRnHBh3Hog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096940;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2JbWSjd6Hkyww79Vl6ONVfxoOF9QK8aiuwIQO5AglEY=;
	b=Ca/YfsF3Btt4PCDKD+Zg2YnlqZQnHozAhHfbxEa0J1kNYT3xUT9/cDU1nOJy6tTS65TX
	 VFcfV9osUH373aRsM6hC7ZbcO4QJO3pbdVEvJeh45LY7Jpq9VD/3t2Hcpn39fDT/mr0hl
	 bBahQ3/l7lR5aF61md7btU9rFteOgzAyh6JYUx9RgDOsLBDDe/ZBrLv2ijvq0PBCOWor3
	 Zid6ySgM3H468ILkrvwsrvATO18EBvY0zW/5MycJtSE0XrdtiNthH86g3hCruYvWMa1N2
	 +wBn2YCUhF9Re/3c1G+LMPCrIFoK9V3381b0dqL7p8Ynd76wp0/QChb52D6zq23dDVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A/6nearX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D1606A32F;
	Sun,  8 Nov 2026 00:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A/6nearX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9821F0089F;
	Sun,  8 Nov 2026 00:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096939;
	bh=2JbWSjd6Hkyww79Vl6ONVfxoOF9QK8aiuwIQO5AglEY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A/6nearXJX02pNLacnjl/9a/vt3f++Rof4tRTHohJ8Q8uHKFTj+W4vwXeljq5PTMF
	 W2rsM+5XnPd+UBcARFZ4ZkBIS972k2WVUwRqNwslMAj6rkxFQxyNjZBTOkDlsW7jhE
	 WvcrKJS2dw60OabNJdoLGEhe2PlXF7cMD/bDj83JRglMX+EIPVFh3BVhO+g2/S6cWK
	 I9h1uutqQgwSxJfRaQ4//fsqZ627odH20vrttSOqYlF96ncwfqKotaOnUVuoukwGmB
	 isaFz4bCboZtUsx6+wYtuDJOEzOcRylafxAm+SpeCTwr4mHlDDQKajMbsH+3ZnDRi6
	 gsBIYWkHYNIjw==
Subject: Re: [PATCH net-next v10 05/11] net: ethernet: oa_tc6: Support for
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
Date: Sun, 08 Nov 2026 00:15:37 +0000
Message-ID: <179409693726.994134.240483510639902959@kernel.org>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-5-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-5-31b5a69b85b7@onsemi.com>
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

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] NULL pointer dereference in the oa_tc6_init() error path.
- [Medium] TX timestamp capture slots are never aged out.
- [Medium] oa_tc6_get_ts_info() advertises software TX timestamping that
  the driver never provides.
- [Medium] A failed register write in oa_tc6_set_hwtstamp_settings()
  leaves the hardware and the driver disagreeing about timestamp state,…
- [Medium] oa_tc6_cleanup_tx_tstamp_skbs() marks all three TTSC slots
  free in software (tc6->ts_ttsc_pending = 0) even though the hardware…
- [Low] The commit message does not match the patch.
- [Low] The comment in oa_tc6_process_extended_status() says 'When
  timestamp is disabled, there is no behavior change as it reads only…
- [Low] Documentation/networking/oa-tc6-framework.rst says
  oa_tc6_ptp_register() 'simply registers' and that ptp_clock_info field…
- [Low] The timestamp statistics tx_hwtstamp_pkts, tx_hwtstamp_lost and
  tx_hwtstamp_err are plain u64 fields in struct oa_tc6.

--

net: ethernet: oa_tc6: Support for hardware timestamp

This patch adds hardware timestamping support to the OPEN Alliance TC6
framework. It adds PHC register/unregister helpers, hwtstamp get/set, and
ethtool timestamp info and stats callbacks. TX frames that request a
timestamp get one of three TTSC capture slots and wait until the matching
STATUS0 event arrives; RX frames carry an 8 byte timestamp prefix when
RTSA is set in the footer.

> Interface for ndo_hwtstamp_set/get, control and status
> callback for ethtool are provided to support hardware timestamp
> feature. ioctl interface passes the request to PHY.

[Severity: Low]
Is the last sentence accurate for this patch? No ioctl handler is added
here, and the v8 changelog says "Removed unnecessary ioctl callback".
phy_do_ioctl_running only shows up later in the series, in "onsemi: s2500:
Add driver support for S2500 MAC-PHY".

> Hardware timestamp functions that handle the traffic are generally
> placed in oa_tc6.c. Rest of the timestamp functionalities, mostly

That file was renamed to oa_tc6_main.c earlier in the series.

The commit message also leaves out two user-visible changes.

The first is the new "depends on PTP_1588_CLOCK_OPTIONAL" on LAN865X and
ADIN1140. It is needed because both select OA_TC6, but with
PTP_1588_CLOCK=m these drivers can no longer be built in.

The second affects RX: every RX skb is now OA_TC6_TSTAMP_SZ bytes larger.
Every frame also goes through oa_tc6_update_ts_in_rx_skb(), which drops
frames shorter than ETH_HLEN (or ETH_HLEN + 8 with RTSA). Those drops are
counted in rx_length_errors and rx_dropped whether or not timestamping is
enabled.

Could these be mentioned?

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
> index 45eb896cd986c..e793d7fb0635f 100644
> --- a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c

[ ... ]

> @@ -49,6 +60,212 @@ static int oa_tc6_get_parity(u32 p)
>  	return !((p >> 28) & 1);
>  }
>  

[ ... ]

> +static bool oa_tc6_req_tx_hwtstamp(struct oa_tc6 *tc6, struct sk_buff *skb)
> +{

[ ... ]

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
> +	tc6->tx_hwtstamp_err++;
> +	return true;

[Severity: Medium]
What releases a slot if its capture event never arrives?

During normal operation, a bit in ts_ttsc_pending is only cleared by
oa_tc6_events_handle(), when the matching STATUS0 TTSCAx event shows up.
oa_tc6_cleanup_tx_tstamp_skbs() only runs on a TX_ON to TX_OFF change,
from oa_tc6_disable_traffic(), or at teardown. There is no timeout or age
check. Meanwhile the queued skb stays on tx_ts_skb_q and keeps its socket
reference and wmem charge.

The MAC-PHY can discard a frame that was already sent with TSC set, for
example after excessive collisions. Another case is the S2500 driver
later in the series clearing MAC TXEN in s2500_stop() while frames are
still buffered. The OA TC6 interface sends no per-frame notification for
either.

Once all three slots are stuck like this,
oa_tc6_prepare_spi_tx_buf_for_tx_skbs() drops every SKBTX_HW_TSTAMP frame
whole, not just its timestamp:

	if (oa_tc6_req_tx_hwtstamp(tc6, tc6->ongoing_tx_skb)) {
		drop_skb = tc6->ongoing_tx_skb;
		tc6->ongoing_tx_skb = NULL;

Recovering is also hard. Restarting ptp4l with the same config hits the
early return in oa_tc6_set_hwtstamp_settings():

	if (tc6->ts_config.flags == ts_cfg->flags &&
	    tc6->ts_config.tx_type == ts_cfg->tx_type &&
	    tc6->ts_config.rx_filter == ts_cfg->rx_filter)
		return 0;

So only an explicit TX_OFF/TX_ON toggle, or unbinding the device, frees
the slots.

Does the "three timestamp capture registers are plenty" reasoning in the
commit message still hold if a slot can leak like this?

[ ... ]

> +void oa_tc6_cleanup_tx_tstamp_skbs(struct oa_tc6 *tc6)
> +{
> +	struct sk_buff *skb, *tmp;
> +
> +	spin_lock_bh(&tc6->tx_skb_lock);
> +	list_for_each_entry_safe(skb, tmp, &tc6->tx_ts_skb_q, list) {
> +		list_del(&skb->list);
> +		dev_kfree_skb(skb);
> +
> +		/* The frame was transmitted, only its timestamp is lost. */
> +		tc6->tx_hwtstamp_lost++;
> +	}
> +
> +	/* Also abandons the slot of a frame still being sent. */
> +	tc6->ts_ttsc_pending = 0;
> +	spin_unlock_bh(&tc6->tx_skb_lock);
> +}

[Severity: Medium]
Can an old capture be delivered to the wrong skb after this?

This marks all three slots free in software. But frames already sent over
SPI with TSC=A/B/C in their start chunk may still sit in the MAC-PHY TX
buffer, and their captures can complete later. The same goes for an
ongoing frame whose first chunk carried a TSC, which
oa_tc6_queue_tx_tstamp_skb() then drops as lost.

Take a TX_ON to TX_OFF to TX_ON toggle. oa_tc6_set_hwtstamp_settings()
only clears the TTSC bits that were present in its single
CONFIG0..INT_MASK0 snapshot. A capture that latches after that snapshot
stays set. The TTSC interrupts are then unmasked, and a new skb can be
given the same slot.

oa_tc6_events_handle() matches on slot number only:

	bit_num = tsc - OA_TC6_TTSCA_REG_ID;
	event = OA_TC6_STATUS0_TTSCAA << bit_num;
	if (!(val & event))
		continue;

The new skb would then receive the old frame's TTSCx value as its
hardware timestamp. The new frame's real capture would later be counted
as an "Unexpected event" in tx_hwtstamp_err.

A related case: if TX timestamping stays off while FTSE remains on
(rx_filter ALL), late captures latch while masked. Since ts_valid only
checks ptp_clock, they are counted as unexpected events on the next
unrelated extended status read.

[ ... ]

> @@ -685,15 +915,28 @@ static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
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
This isn't a bug, but the comment doesn't match the code. ts_valid says
whether a PHC was registered, not whether timestamping is enabled
(tc6->hw_tstamp_enabled or ts_config.tx_type).

Once a vendor driver registers the PHC, which S2500 always does at probe,
every extended status event reads OA_TC6_STATUS0_TTSC_REG_COUNT
registers. It also calls oa_tc6_events_handle() for any TTSCA bits, even
when hwtstamp is off and the TTSCA interrupts are masked.

[ ... ]

> @@ -1435,6 +1725,12 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
>  		return ERR_PTR(ret);
>  	}
>  
> +	ret = oa_tc6_update_standard_capability(tc6);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "Failed to read capability\n");
> +		goto phy_exit;
> +	}
> +

[Severity: High]
Can this goto dereference a NULL phydev? It runs before oa_tc6_phy_init(),
so tc6->phydev and tc6->mdiobus are still NULL from devm_kzalloc(). Unless
OA_TC6_BROKEN_PHY is set, the error path does:

oa_tc6_phy_exit()
    phy_disconnect(tc6->phydev)
        phy_is_started(phydev)    <- NULL dereference
    oa_tc6_mdiobus_unregister(tc6)
        mdiobus_unregister(NULL)

So an SPI error while reading OA_TC6_REG_STDCAP would oops during probe.

The other failures before oa_tc6_phy_init() return ERR_PTR(ret) directly.
Should this one do the same? This still looks present at the end of the
series.

[ ... ]

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c b/drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c
> new file mode 100644
> index 0000000000000..7d21c0608ee80
> --- /dev/null
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c

[ ... ]

> +/**
> + * oa_tc6_ptp_register - Registers clock related callbacks
> + * @tc6: oa_tc6 struct.
> + * @info: Describes a PTP hardware clock
> + *
> + * Description: Vendors are expected to set the hardware timestamp
> + * related callbacks before calling this function.
> + *
> + * Return: 0 on success otherwise failed.
> + *
> + */
> +int oa_tc6_ptp_register(struct oa_tc6 *tc6, struct ptp_clock_info *info)
> +{
> +	int ret = 0;
> +
> +	/* Not supporting hardware timestamp isn't an error */
> +	if (!tc6->ftsc_capable)
> +		return ret;
> +
> +	snprintf(info->name, sizeof(info->name), "OA TC6 PTP %s",
> +		 dev_name(&tc6->spi->dev));

[Severity: Low]
This isn't a bug, but Documentation/networking/oa-tc6-framework.rst says
oa_tc6_ptp_register() "simply registers" and leaves ptp_clock_info setup
to the vendor. This code does two things the doc doesn't describe:

It always overwrites info->name.

It returns 0 without registering anything when ftsc_capable is false.
The kernel-doc Return line doesn't mention this case, so callers can't
tell "registered" from "not supported".

The rst also declares oa_tc6_get_ts_stats() with a parameter named
ts_stats, while include/linux/oa_tc6.h and oa_tc6_tstamp.c call it stats.

[ ... ]

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c b/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c
> new file mode 100644
> index 0000000000000..539cbd36a1d04
> --- /dev/null
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c

[ ... ]

> +static int oa_tc6_set_hwtstamp_settings(struct oa_tc6 *tc6,
> +					const struct hwtstamp_config *ts_cfg)
> +{

[ ... ]

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

[Severity: Medium]
What happens to INT_MASK0 if this CONFIG0 write fails? INT_MASK0 has
already been written and nothing restores it. tc6->ts_config and
hw_tstamp_enabled are also left as they were.

For a TX_ON to TX_OFF request, that leaves:

- the TTSCAA/B/C interrupts masked
- CONFIG0.FTSE still set
- ts_config.tx_type == HWTSTAMP_TX_ON

A later TX_ON request, for example from restarting ptp4l after the error,
matches the stale ts_config. It returns 0 from the early check above, so
INT_MASK0 is never unmasked again.

Software still believes TX_ON is in effect, so oa_tc6_req_tx_hwtstamp()
keeps handing out slots. But oa_tc6_events_handle() only runs when some
unrelated unmasked STATUS0 event triggers an extended status read.

Could the slots fill up, so that later timestamp-requesting frames get
dropped?

[ ... ]

> +void oa_tc6_get_ts_stats(struct oa_tc6 *tc6,
> +			 struct ethtool_ts_stats *stats)
> +{
> +	stats->pkts = tc6->tx_hwtstamp_pkts;
> +	stats->err = tc6->tx_hwtstamp_err;
> +	stats->lost = tc6->tx_hwtstamp_lost;
> +}

[Severity: Low]
Can these 64-bit counters tear on 32-bit kernels? They are plain u64
fields, read here from the ethtool path with no lock or u64_stats_sync.
The SPI thread and the hwtstamp_set path write them.

The writers aren't consistent either. Most updates are made under
tx_skb_lock, but the last one in oa_tc6_events_handle() comes after
spin_unlock_bh():

	if (val & ~handled) {
		tc6->tx_hwtstamp_err += hweight32(val & ~handled);

KCSAN would likely report these as data races.

[ ... ]

> +int oa_tc6_get_ts_info(struct oa_tc6 *tc6,
> +		       struct kernel_ethtool_ts_info *info)
> +{
> +	if (!tc6->ptp_clock)
> +		return ethtool_op_get_ts_info(tc6->netdev, info);

[Severity: Medium]
Does this fallback advertise software TX timestamps that the driver never
produces? ethtool_op_get_ts_info() sets SOF_TIMESTAMPING_TX_SOFTWARE, but
nothing in drivers/net/ethernet/oa_tc6/ or the S2500 driver calls
skb_tx_timestamp(). That includes oa_tc6_start_xmit().

This path can be reached in two ways. With CONFIG_PTP_1588_CLOCK=n, the
ptp_clock_register() stub returns NULL, so oa_tc6_ptp_register() leaves
ptp_clock NULL and returns 0. It is also reached on a MAC-PHY without
STDCAP.FTSC.

Applications that rely on it, such as ptp4l -S, would wait for error
queue timestamps that never arrive.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7%40onsemi.com
