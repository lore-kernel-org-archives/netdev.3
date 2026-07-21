Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743C332EBB
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639875; cv=none; b=WkTvTed/2UudaqoCmxg0NY8Nck43+hrTKyStbTwfpYn3fLHmxvB4G/S7Q4n6eftK4AXSMbld17VNon3K1CH+SZip3SXfK1pzmPqCjny7hIOB8QeMnfLT6fnBTP0XawDyw21WoXCAN2w5G0HCAbN/ypui4/ef7psRFWjHdZ2cPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639875; c=relaxed/simple;
	bh=5RFn7v5QUR8GNDXctVy/lEodgrmgk7KvopC/QYo57ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8mBb4kl+kcH0pqHSNTxKOm4sDftkxN86WZGXRmI8e7CZbNxm9enM7TDdG3bWmAaoU3o32C+XA/1IVzREgB1/bFs+LVvXd3/2D3KUQOInajfeuJsoyUlZ93qwaSfDHK74vEy5KAj0PUeftuTuuWz3KHcaWs7iS7nb0mECnbMZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayUtIvoc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayUtIvoc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784639873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HE2snwmNZhwwdbdZLQ/1vhOr0C0OXaSTwQ1XFnBOH58=;
	b=ayUtIvoc9+qmvmsO7Y9Hr/ByVRUfxxrOHMt08lfu6rxqx1fnszOQXKji2avaVhqlOvxhpW
	SAcg9PWYf14bCcS0tDBpsdwGp08OvgWFVUqdl7ITALQqZOYbAVnJvnu33QBwD364QSKbK2
	kmkT/5rRROR7g+Ujcc0a8gOq0SUgRLQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-_CeHCgRbNiiSTHMmDQUA_A-1; Tue,
 21 Jul 2026 09:17:47 -0400
X-MC-Unique: _CeHCgRbNiiSTHMmDQUA_A-1
X-Mimecast-MFC-AGG-ID: _CeHCgRbNiiSTHMmDQUA_A_1784639863
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0981C19774E9;
	Tue, 21 Jul 2026 13:17:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.106])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24EF2424;
	Tue, 21 Jul 2026 13:17:32 +0000 (UTC)
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
Subject: Re: [PATCH net-next v7 08/15] net: ethernet: oa_tc6: Support for hardware timestamp
Date: Tue, 21 Jul 2026 15:17:22 +0200
Message-ID: <20260721131730.233755-1-pabeni@redhat.com>
In-Reply-To: <20260708-s2500-mac-phy-support-v7-8-478c877aa1a9@onsemi.com>
References: <20260708-s2500-mac-phy-support-v7-8-478c877aa1a9@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: ethernet: oa_tc6: Support for hardware timestamp

This adds hardware timestamping support to the OA TC6 MAC-PHY framework,
splitting PTP registration and hwtstamp helpers into new oa_tc6_ptp.c and
oa_tc6_tstamp.c files, and wiring TSC handling into the TX and RX chunk
paths.

Thanks for the patch; a few questions inline.

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6.c
> index bf96e8d1ccb9..939935cb170d 100644
> --- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c

[ ... ]

> +static void oa_tc6_defer_for_hwtstamp(struct oa_tc6 *tc6,
> +				      struct sk_buff *skb)
> +{
> +	if (!tc6->hw_tstamp_enabled)
> +		return;
> +	if (!skb || (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) == 0)
> +		return;
> +	if (tc6->ts_config.tx_type != HWTSTAMP_TX_ON) {
> +		tc6->tx_hwtstamp_lost++;
> +		return;
> +	}
> +
> +	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +	u8 ret = tc6->tx_ts_idx++;
> +
> +	if (ret == OA_TC6_TTSCC_REG_ID)
> +		tc6->tx_ts_idx = OA_TC6_TTSCA_REG_ID;
> +	oa_tc6_tsinfo_tx(skb)->tsc = ret;
> +
> +	list_add_tail(&skb->list, &tc6->tx_ts_skb_q);
> +}

[High]
The hardware exposes three timestamp capture slots (TTSCA, TTSCB, TTSCC),
but tx_ts_idx cycles through them unconditionally, with no check that
the previous capture in a given slot has already been drained by the
TTSCA/B/C completion IRQ.

When tx_credits allows more than three timestamped skbs to be pipelined,
the same tsc value is assigned to two skbs.  The earlier skb's TTSCx
register is then overwritten by the later capture before
oa_tc6_process_deferred_skb() reads it, and two skbs end up on
tx_ts_skb_q with an identical tsc.

Should this scheme track per-slot in-use state and either back-pressure
or fall back to software timestamping when all three slots are pending?

[High]
tc6->hw_tstamp_enabled and tc6->ts_config are written from the ioctl
path through oa_tc6_hwtstamp_set()->oa_tc6_set_hwtstamp_settings() and
read here on the threaded IRQ path with no lock, RCU, WRITE_ONCE, or
memory barrier.  Is there some serialization not visible here?

On the disable path, oa_tc6_set_hwtstamp_settings() programs the
hardware first and only afterwards clears hw_tstamp_enabled.  Can this
happen:

  CPU0 (ioctl disable)          CPU1 (threaded IRQ)
  write CONFIG0 (clear FTSE)
  write INT_MASK0 (mask TTSCA)
                                if (!tc6->hw_tstamp_enabled) /* still true */
                                ...
                                skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
                                list_add_tail(&skb->list, &tc6->tx_ts_skb_q);
  tc6->hw_tstamp_enabled = false;

At that point the TTSCA/B/C interrupts are already masked, so
oa_tc6_process_deferred_skb() will never run for that tsc; the skb is
stuck on tx_ts_skb_q, and because SKBTX_IN_PROGRESS was set the socket
TX completion is also blocked.

Would a mutex around the reconfiguration (plus draining tx_ts_skb_q)
be more appropriate than the plain flag read?

> +static int oa_tc6_process_deferred_skb(struct oa_tc6 *tc6, u8 tsc)
> +{
> +	struct skb_shared_hwtstamps tstamp;
> +	struct oa_tc6_ts_info_tx *ski;
> +	struct sk_buff *skb, *tmp;
> +	bool found = false;
> +	int ret = 0;
> +
> +	/* Size of data must match OA_TC6_TSTAMP_SZ */
> +	u32 data[2];
> +
> +	list_for_each_entry_safe(skb, tmp, &tc6->tx_ts_skb_q, list) {
> +		ski = oa_tc6_tsinfo_tx(skb);
> +		if (ski->tsc != tsc)
> +			continue;
> +		if (found) {
> +			dev_warn_ratelimited(&tc6->spi->dev,
> +					     "Multiple skbs. tsc = %d\n",
> +					     tsc);
> +			tc6->tx_hwtstamp_err++;
> +		}
> +		found = true;
> +		list_del(&skb->list);
> +
> +		/* Retrieve the timestamping info */
> +		ret = oa_tc6_read_registers(tc6,
> +					    OA_TC6_REG_TTSCA_HIGH +
> +					    2 * (tsc - 1), &data[0], 2);
> +
> +		if (!ret) {
> +			tstamp.hwtstamp = ktime_set(data[0], data[1]);
> +			skb_tstamp_tx(skb, &tstamp);
> +			tc6->tx_hwtstamp_pkts++;
> +		}
> +
> +		dev_kfree_skb(skb);
> +	}
> +	return ret;
> +}

[Medium]
When more than one skb matches the same tsc, this loop still calls
skb_tstamp_tx() with the identical hardware timestamp for every match
and increments tx_hwtstamp_pkts on each.

Should only the first match report a timestamp, with the remaining
matches freed as errors and neither reporting a bogus duplicate to
userspace nor inflating tx_hwtstamp_pkts?

> +static void oa_tc6_update_ts_in_rx_skb(struct oa_tc6 *tc6)
> +{
> +	struct sk_buff *skb = tc6->rx_skb;
> +	struct oa_tc6_ts_info_rx *ski;
> +	__be32 ts_val[2];
> +	u32 ts[2];
> +
> +	if (!tc6->hw_tstamp_enabled)
> +		return;
> +	ski = oa_tc6_tsinfo_rx(skb);
> +	if (!ski->rtsa)
> +		return;
> +
> +	memcpy(&ts_val[0], skb->data, 4);
> +	memcpy(&ts_val[1], (u32 *)skb->data + 1, 4);
> +
> +	ts[0] = be32_to_cpu(ts_val[0]);
> +	ts[1] = be32_to_cpu(ts_val[1]);
> +
> +	/* Check parity */
> +	if ((oa_tc6_get_parity(ts[0]) ^ oa_tc6_get_parity(ts[1])) ==
> +	    !ski->rtsp) {
> +		struct skb_shared_hwtstamps *hw_ts;
> +
> +		/* Report timestamp to the upper layers */
> +		hw_ts = skb_hwtstamps(skb);
> +		memset(hw_ts, 0, sizeof(*hw_ts));
> +		hw_ts->hwtstamp = ktime_set(ts[0], ts[1]);
> +	}
> +	skb_pull(skb, sizeof(ts));
> +}

[Medium]
The two 4-byte memcpys and the skb_pull() assume the linear region
holds at least 8 bytes, but skb->len is never checked.  If a short
frame arrives with RTSA_VALID set in the footer, the memcpys read past
the received payload (still inside the allocated buffer, so no OOB,
but garbage becomes a "hardware timestamp"), and skb_pull() returns
NULL without advancing skb->data.

The return value is ignored, so eth_type_trans() then parses the
would-be timestamp bytes as the Ethernet header and delivers a corrupt
frame upstream.

Should this bail out early if skb->len < OA_TC6_TSTAMP_SZ, and check
the return of skb_pull()?

[ ... ]

> @@ -887,12 +1060,18 @@ static void oa_tc6_add_tx_skb_to_spi_buf(struct oa_tc6 *tc6)
>  		tc6->tx_skb_offset = 0;
>  		tc6->netdev->stats.tx_bytes += tc6->ongoing_tx_skb->len;
>  		tc6->netdev->stats.tx_packets++;
> -		kfree_skb(tc6->ongoing_tx_skb);
> +
> +		/* Free the ones that are not saved for later processing,
> +		 * like timestamping.
> +		 */
> +		if (!(skb_shinfo(tc6->ongoing_tx_skb)->tx_flags &
> +		    SKBTX_IN_PROGRESS))
> +			kfree_skb(tc6->ongoing_tx_skb);
>  		tc6->ongoing_tx_skb = NULL;
>  	}

[High]
When SKBTX_IN_PROGRESS is set the ongoing_tx_skb reference is dropped
without a free, leaving the skb owned solely by tx_ts_skb_q.  The only
path that removes and frees these skbs is oa_tc6_process_deferred_skb()
driven by the TTSCA/B/C interrupt.

Two lifetime questions:

On module unload/unbind, oa_tc6_free_pending_skbs() only touches
ongoing_tx_skb, ongoing_rx_skb, and waiting_tx_skb.  What frees the
skbs still linked on tx_ts_skb_q?

When hwtstamp is disabled via SIOCSHWTSTAMP,
oa_tc6_set_hwtstamp_settings() masks INT_MASK0_TTSCA_MASK.  Any skb
already queued for a pending capture will not receive its completion
IRQ.  What drains tx_ts_skb_q in that case?

Because SKBTX_IN_PROGRESS is set on these skbs, their socket-level TX
completion is also blocked until skb_tstamp_tx() or free happens, so a
leak here stalls sockets in addition to leaking memory.

[ ... ]

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c b/drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c
> new file mode 100644
> index 000000000000..0cde5545ee27
> --- /dev/null
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c

[ ... ]

> +int oa_tc6_ptp_register(struct oa_tc6 *tc6, struct ptp_clock_info *info)
> +{
> +	/* Not supporting hardware timestamp isn't an error */
> +	if (!tc6->hw_tstamp_supported)
> +		return 0;
> +
> +	snprintf(info->name, sizeof(info->name), "%s",
> +		 "OA TC6 PTP clock");

[Low]
This unconditionally overwrites the caller-provided info->name with a
fixed string.  If a board hosts more than one OA TC6 MAC-PHY, all PTP
clocks register under the identical name "OA TC6 PTP clock", making
ptp4l/phc2sys logging and pinning ambiguous.

Could the name be derived from dev_name(&spi->dev) or the netdev name,
or left untouched so the vendor caller can set a unique value?

> +	tc6->ptp_clock = ptp_clock_register(info, &tc6->spi->dev);
> +	if (IS_ERR(tc6->ptp_clock)) {
> +		dev_err(&tc6->spi->dev, "Registration of %s failed",
> +			info->name);
> +		return -EFAULT;
> +	}

[High, Low]
Two questions about this failure path:

On failure, tc6->ptp_clock retains the ERR_PTR value from
ptp_clock_register().  oa_tc6_ptp_unregister() later guards on
`if (tc6->ptp_clock)` and oa_tc6_get_ts_info() on `if (!tc6->ptp_clock)`.
Both checks pass for an ERR_PTR, so ptp_clock_unregister() and
ptp_clock_index() end up dereferencing an ERR_PTR.  Should tc6->ptp_clock
be reset to NULL before returning here?

-EFAULT is documented for bad userspace addresses.  Would returning
PTR_ERR(tc6->ptp_clock) preserve the real errno from ptp_clock_register()
(typically -ENOMEM, -EBUSY, or -EINVAL)?

[ ... ]

> +MODULE_DESCRIPTION("OPEN Alliance 10BASE‑T1x MAC‑PHY Serial Interface Lib");
> +MODULE_AUTHOR("Selva Rajagopal <selvamani.rajagopal@onsemi.com>");
> +MODULE_LICENSE("GPL");

[Low]
All three .c files (oa_tc6.c, oa_tc6_ptp.c, oa_tc6_tstamp.c) link into
the single oa_tc6_mod.ko per the Makefile change, yet each translation
unit declares its own MODULE_DESCRIPTION/MODULE_AUTHOR/MODULE_LICENSE.
This produces duplicate __UNIQUE_ID_license sections and duplicate
modinfo strings.

Would keeping the module metadata only in oa_tc6.c be cleaner?

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h

[ ... ]

> @@ -127,6 +147,17 @@ struct oa_tc6 {
>  	bool rx_buf_overflow;
>  	bool int_flag;
>  	bool disable_traffic;
> +	struct ptp_clock_info ptp_clock_info;

[Low]
This ptp_clock_info field does not appear to be assigned or read
anywhere in the series.  oa_tc6_ptp_register() takes a struct
ptp_clock_info * argument and forwards it to ptp_clock_register()
directly, and vendor drivers embed their own ptp_clock_info in their
own state.  Is this field intended for future use, or can it be
dropped?

> +	struct hwtstamp_config ts_config;
> +	struct list_head tx_ts_skb_q;
> +	struct ptp_clock *ptp_clock;
> +	bool hw_tstamp_supported;
> +	bool hw_tstamp_enabled;
> +	u32 tx_hwtstamp_pkts;
> +	u32 tx_hwtstamp_lost;
> +	u32 tx_hwtstamp_err;
> +	int vend1_mms;
> +	u8 tx_ts_idx;
>  };

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c b/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c
> new file mode 100644
> index 000000000000..f80f1a4916a3
> --- /dev/null
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c

[ ... ]

> +static int oa_tc6_set_hwtstamp_settings(struct oa_tc6 *tc6)
> +{
> +	u32 cfg0, irqm, status0;
> +	int ret;
> +
> +	ret = oa_tc6_read_register(tc6, OA_TC6_REG_CONFIG0, &cfg0);
> +	if (ret) {
> +		dev_err(&tc6->spi->dev, "Failed to read CFG0 register\n");
> +		goto out;
> +	}
[ ... ]
> +	ret = oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, cfg0);

[Medium]
oa_tc6_read_register() and oa_tc6_write_register() each take
spi_ctrl_lock individually, but the read-modify-write pair on CONFIG0
(and on INT_MASK0) is not atomic across the two calls.
oa_tc6_zero_align_receive_frame_enable() also RMWs CONFIG0.  Today
that call comes only from vendor probe (single-threaded), but this
function runs at runtime from ioctl.

Would a dedicated register-state mutex covering the whole RMW sequence
protect against a future runtime user of a different CONFIG0 bit
losing an update?

[ ... ]

> +int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6,
> +			struct kernel_hwtstamp_config *cfg)
> +{
[ ... ]
> +	switch (cfg->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +	case HWTSTAMP_FILTER_ALL:
> +	case HWTSTAMP_FILTER_SOME:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
[ ... every PTP filter accepted ... ]
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +	hwtstamp_config_from_kernel(&tc6->ts_config, cfg);
> +
> +	/* Supports timestamping all traffic */
> +	if (cfg->rx_filter != HWTSTAMP_FILTER_NONE)
> +		tc6->ts_config.rx_filter = HWTSTAMP_FILTER_ALL;
> +	return oa_tc6_set_hwtstamp_settings(tc6);
> +}

[Medium]
The coerced filter is written to tc6->ts_config.rx_filter but not
back into the caller-supplied *cfg.  When this is wired to
ndo_hwtstamp_set(), dev_set_hwtstamp() copies kernel_hwtstamp_config
back to userspace unchanged, so userspace sees its original request
(for example HWTSTAMP_FILTER_PTP_V2_L2_EVENT) reported as accepted
while the hardware silently applies HWTSTAMP_FILTER_ALL.

Should cfg->rx_filter be updated to HWTSTAMP_FILTER_ALL before returning,
so userspace can observe the coercion the way other drivers signal it?

[Medium]
oa_tc6_get_ts_info() advertises rx_filters = BIT(HWTSTAMP_FILTER_ALL)
alone, while this switch accepts every PTP-related filter and
HWTSTAMP_FILTER_NTP_ALL.  ethtool -T therefore describes a different
set of accepted filters than what oa_tc6_hwtstamp_set() actually takes.

Additionally, cfg->flags is not validated on this path; only the ioctl
wrapper oa_tc6_tstamp_ioctl() rejects a non-zero tscfg.flags.  Any
HWTSTAMP_FLAG_* bits arriving via ndo_hwtstamp_set() are silently
swallowed.

Should the advertised rx_filters mask reflect what is actually accepted
here, and should cfg->flags be validated in this function too?
-- 
This is an AI-generated review.

