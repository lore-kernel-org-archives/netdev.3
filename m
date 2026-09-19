Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4213812DE;
	Sat, 19 Sep 2026 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789801650; cv=none; b=q04AJJbR5S+h2qBhdzcSxcDUm0ysVRfL2E06KKPth8B50dWZ9u27AOVq0BYb59CCudoTNrT1zfU8WF2u1iY8jC5ro8h7RiCTOrJXZG6r/yyPNZtdATc8q/FcfTrCIkcQ2VpKFgSh1+2V/SjZi3WAFEpI50exLvTSXBgWdnhftKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789801650; c=relaxed/simple;
	bh=8Vp2ZJCcLCwpL0RKsgNVkhqpqvwmGPcXlA49NlnMDsA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sTAxi3UKWc81fk5ReJ6RTyL3oRpGdEDzoW6gpdC8Wll6ybg8EZnMTKaS1dlz4ZfsAhePTMIXJenNeGj4/YIKRDexB0A9Vc34BOl1PNhPSIEgi4zuhLjASFqQIKj1KXBueqtlMjswWpFHWfaniOPpx0kwWFIoSjoAtxeEMAf6OJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2W3USAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2W3USAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714761F00898;
	Sat, 19 Sep 2026 07:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789801645;
	bh=h5inKVcc7b2yeVLU9GhFHj0zEGu8yv3b/rV1ccxh99g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B2W3USAElpJzjKGZmI4irdLNQPSPe3AeT2/imu2tzSBkvgCicLNc2DXHv9dok0edn
	 zXM9i2Kh7pXLIz9305Zzt+Vj3szGWNHdLON3WUXImsknGLqxAXo6drYZ84LeG38mZw
	 MjWFm1B1Z3rh0a47eb29mK4ghea6CicGy6BI92uUihC2cRrAZgY1Gff3yQBg9aq0EU
	 cJKo1UwKszDE2eG3KkdNrh9lOJgGz0fatCv1tWAGwdlch/LA1eMdRVP5r/pP6HWOdu
	 j0yx4AVpT0LnTgSVGziryuTyPNMdVpMcq/0zv2/tToSEX0Z6MycDWaHoX2UuYB6CFX
	 Y0Xyh1NQRULEA==
Subject: Re: [PATCH net-next v8 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
From: netdev-bot+sashiko@kernel.org
To: m-malladi@ti.com
Cc: elfring@users.sourceforge.net, philippe.schenker@impulsing.ch,
 vadim.fedorenko@linux.dev, haokexin@gmail.com, devnexen@gmail.com,
 horms@kernel.org, jacob.e.keller@intel.com, arnd@arndb.de, afd@ti.com,
 parvathi@couthit.com, basharath@couthit.com, vladimir.oltean@nxp.com,
 danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com
Date: Sat, 19 Sep 2026 07:07:24 +0000
Message-ID: <178980164403.22033.14823088508390223417@kernel.org>
In-Reply-To: <20260915063052.2274986-3-m-malladi@ti.com>
References: <20260915063052.2274986-3-m-malladi@ti.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 (1) · Low: 2

- [High] emac_set_mm()
  (drivers/net/ethernet/ti/icssg/icssg_ethtool.c:378-386) restores all…
- [Medium] emac_set_mm() stores cfg->tx_min_frag_size verbatim
  (icssg_ethtool.c:374) and icssg_config_ietfpe() programs…
- [Medium] The commit message justifies the emac_get_stat_by_name()
  signature change as preventing "invalid stat lookups from corrupting…
- [Medium] iet->verify_status is never initialized to
  ICSSG_IETFPE_STATE_DISABLED.
- [Low] The patch inverts the header dependency to make the stat counts
  ARRAY_SIZE()-derived: icssg_stats.h drops its `#include…
- [Low] The shared teardown helper prueth_netdev_exit()
  (icssg_common.c:1757) unconditionally calls…

Pre-existing issues:
- [Medium] emac->stats[]/emac->pa_stats[] are 64-bit accumulators written
  by icssg_stats_work_handler() -> emac_update_hardware_stats() under…

--

net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge

Adds .get_mm(), .set_mm() and .get_mm_stats() to the icssg ethtool ops,
along with new PA stats registers for the preemption counters. Also
changes emac_get_stat_by_name() to return u64 and 0 instead of -EINVAL,
and moves the stat table sizes to ARRAY_SIZE().

No Link: tags present in the commit header.

A few questions on the new code below.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index b715af21d23ac..dc25361afe989 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c

[ ... ]

> @@ -114,7 +116,8 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
>  
>  	if (emac->prueth->pa_stats)
>  		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
> -			*(data++) = emac->pa_stats[i];
> +			if (!icssg_all_pa_stats[i].standard_stats)
> +				*(data++) = emac->pa_stats[i];
>  }

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but the
new emac_get_mm_stats() added further down takes prueth->stats_lock for
the pa_stats[] reads and documents why, while emac_get_ethtool_stats()
here, icssg_ndo_get_stats64() and emac_get_rmon_stats() read the same
accumulators with no lock held (emac_update_hardware_stats() has already
dropped it by then).

The writer accumulates under the lock:

drivers/net/ethernet/ti/icssg/icssg_stats.c:emac_update_hardware_stats() {
	spin_lock(&prueth->stats_lock);
	...
		emac->stats[i] += val;
	...
			emac->pa_stats[i] += val;
	...
	spin_unlock(&prueth->stats_lock);
}

and icssg_stats_work_handler() runs that from system_long_wq on another
CPU. Can ethtool -S or ip -s link observe a torn u64 on 32-bit ARM, or a
multi-term sum such as the rx_dropped accumulation in
icssg_ndo_get_stats64() built from two different update generations?

Would it make sense to give these readers the same one-line treatment as
emac_get_mm_stats(), or to convert the accumulators to u64_stats_t?

> @@ -294,6 +297,126 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
>  	return 0;
>  }
>  
> +static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	enum icssg_ietfpe_verify_states verify_status;
> +
> +	if (emac->is_sr1)
> +		return -EOPNOTSUPP;

[Severity: Low]
This asymmetry comes from the earlier patch in the series, "net: ti:
icssg-prueth: Add Frame Preemption MAC Merge support", rather than from
this one, but fpe_lock is initialized only by icssg_qos_init(), whose
sole caller is the SR2 prueth_netdev_init(). The SR1 prueth_netdev_init()
in icssg_prueth_sr1.c never calls it, yet both teardown paths land in the
shared helper:

drivers/net/ethernet/ti/icssg/icssg_common.c:prueth_netdev_exit() {
	mutex_destroy(&emac->qos.iet.fpe_lock);
	pruss_release_mem_region(prueth->pruss, &emac->dram);
	free_netdev(emac->ndev);
}

Nothing observable happens, since mutex_destroy() on a zeroed, never
locked mutex only does DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock)) and
clears magic, and SR1 never takes fpe_lock because the three new ops all
return early on emac->is_sr1.

Would it be cleaner to pair the two, either by calling icssg_qos_init()
from the SR1 netdev init or by skipping the destroy when emac->is_sr1?

> +
> +	mutex_lock(&iet->fpe_lock);
> +	state->tx_enabled = iet->fpe_enabled;
> +	state->tx_min_frag_size = iet->tx_min_frag_size;
> +	state->verify_enabled = iet->mac_verify_configure;
> +	state->verify_time = iet->verify_time_ms;
> +	state->tx_active = iet->fpe_active;
> +	verify_status = iet->verify_status;
> +	mutex_unlock(&iet->fpe_lock);
> +
> +	state->rx_min_frag_size = ETH_ZLEN;
> +	state->pmac_enabled = true;
> +
> +	switch (verify_status) {

[ ... ]

> +	default:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
> +		break;
> +	}

[Severity: Medium]
Is iet->verify_status ever given an initial value? icssg_qos_init() seeds
the other fields this function reads, but not this one:

drivers/net/ethernet/ti/icssg/icssg_qos.c:icssg_qos_init() {
	mutex_init(&iet->fpe_lock);
	/* Set default values to prevent garbage values during .get_mm() */
	iet->verify_time_ms = ICSSG_IET_MAX_VERIFY_TIME;
	iet->tx_min_frag_size = ETH_ZLEN;
}

so it stays at the zero value ICSSG_IETFPE_STATE_UNKNOWN from the
zero-filled netdev private area. It is only assigned in
icssg_config_ietfpe()/icssg_iet_verify_wait() and in the link-down branch
of icssg_qos_link_state_update(), and simply bringing a fresh interface up
returns before any of them:

icssg_iet_change_preemptible_tcs() {
	if (!iet->fpe_enabled && !iet->preemptible_tcs) {
		mutex_unlock(&iet->fpe_lock);
		return 0;
	}
}

Does ethtool --show-mm on a freshly probed interface then report
verify-status UNKNOWN together with verify-enabled off, where other MM
implementations report DISABLED?

> +
> +	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
> +	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
> +	 */
> +	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
> +
> +	return 0;
> +}
> +
> +static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
> +		       struct netlink_ext_ack *extack)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +	u32 old_verify_time_ms, old_tx_min_frag_size;
> +	bool old_fpe_enabled, old_mac_verify_configure;
> +	int err;
> +
> +	if (emac->is_sr1)
> +		return -EOPNOTSUPP;
> +
> +	if (!cfg->pmac_enabled) {
> +		NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	mutex_lock(&iet->fpe_lock);
> +	old_verify_time_ms = iet->verify_time_ms;
> +	old_tx_min_frag_size = iet->tx_min_frag_size;
> +	old_fpe_enabled = iet->fpe_enabled;
> +	old_mac_verify_configure = iet->mac_verify_configure;
> +
> +	iet->verify_time_ms = cfg->verify_time;
> +	iet->tx_min_frag_size = cfg->tx_min_frag_size;

[Severity: Medium]
Should cfg->tx_min_frag_size be run through
ethtool_mm_frag_size_min_to_add() before being stored? The netlink policy
only range checks it:

net/ethtool/mm.c:
	[ETHTOOL_A_MM_TX_MIN_FRAG_SIZE]	= NLA_POLICY_RANGE(NLA_U32, 60, 252),

so a value like 61 reaches the driver, icssg_config_ietfpe() writes
tx_min_frag_size + ETH_FCS_LEN, i.e. 65 octets, into
PRE_EMPTION_ADD_FRAG_SIZE_LOCAL, and get_mm() echoes 61 back as the
effective setting with no extack error.

The sibling TI driver validates the same field:

drivers/net/ethernet/ti/am65-cpsw-ethtool.c:am65_cpsw_set_mm() {
	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size,
					      &add_frag_size, extack);
	if (err)
		return err;
}

whose kernel-doc states only the addFragSize-representable values
60/124/188/252 are accepted.

The commit message also says:

    The minimum size of non-final mPacket fragments supported by the
    firmware without leading errors is 64 Bytes (including FCS).

Should sizes the firmware cannot honour be rejected with an extack
message rather than silently programmed?

> +	iet->fpe_enabled = cfg->tx_enabled;
> +	iet->mac_verify_configure = cfg->verify_enabled;
> +	err = icssg_config_ietfpe(ndev, cfg->tx_enabled);
> +	if (err) {
> +		/* icssg_config_ietfpe's fallback path already cleared fpe_active.
> +		 * Restore all config fields so get_mm() reports the configuration
> +		 * that is actually reflected in hardware.
> +		 */
> +		iet->verify_time_ms = old_verify_time_ms;
> +		iet->tx_min_frag_size = old_tx_min_frag_size;
> +		iet->fpe_enabled = old_fpe_enabled;
> +		iet->mac_verify_configure = old_mac_verify_configure;
> +	}

[Severity: High]
Does this restore really leave get_mm() reporting the configuration that
is in hardware?

icssg_config_ietfpe() programs the new fragment size before any failure
point:

drivers/net/ethernet/ti/icssg/icssg_qos.c:icssg_config_ietfpe() {
	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
	writew(iet->tx_min_frag_size + ETH_FCS_LEN,
	       config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
	...
}

and neither error exit puts that register back:

disable_tx:
	icssg_set_port_state(emac, ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
fallback:
	writeb(0, config + PRE_EMPTION_ENABLE_TX);
	writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
	iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
	iet->fpe_active = false;
	icssg_iet_set_preempt_mask(emac);
	return ret;

So after a failed set_mm, PRE_EMPTION_ADD_FRAG_SIZE_LOCAL keeps the
rejected size while get_mm() reports old_tx_min_frag_size, and TX
preemption has been switched off in hardware while iet->fpe_enabled is
republished as true whenever FPE was previously running.

Can that also turn an identical retry into a silent no-op? ethnl_set_mm()
seeds cfg from get_mm() and skips the driver when nothing changed:

net/ethtool/mm.c:ethnl_set_mm() {
	ret = dev->ethtool_ops->get_mm(dev, &state);
	...
	mm_state_to_cfg(&state, &cfg);
	...
	if (!mod)
		return 0;
}

so re-running ethtool --set-mm <dev> tx-enabled on returns success with
PRE_EMPTION_ENABLE_TX still 0.

And can the restored fpe_enabled == true be consumed later without any
user request, on the next link event?

drivers/net/ethernet/ti/icssg/icssg_qos.c:icssg_iet_change_preemptible_tcs() {
	mutex_lock(&iet->fpe_lock);
	if (!iet->fpe_enabled && !iet->preemptible_tcs) {
		mutex_unlock(&iet->fpe_lock);
		return 0;
	}
	ret = icssg_config_ietfpe(emac->ndev, iet->fpe_enabled);
}

The failure paths are ordinary runtime conditions: verification rejected
by the link partner or timing out, firmware not setting
PRE_EMPTION_ACTIVE_TX, or the port state command failing.

> +	mutex_unlock(&iet->fpe_lock);
> +
> +	return err;
> +}
> +
> +static void emac_get_mm_stats(struct net_device *ndev,
> +			      struct ethtool_mm_stats *s)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +
> +	if (emac->is_sr1)
> +		return;
> +
> +	if (!emac->prueth->pa_stats)
> +		return;
> +
> +	emac_update_hardware_stats(emac);
> +
> +	/* Hold stats_lock to prevent icssg_stats_work_handler from updating
> +	 * pa_stats[] between reads, which could yield a torn u64 value on
> +	 * 32-bit architectures.
> +	 */
> +	spin_lock(&emac->prueth->stats_lock);
> +	/* MACMergeHoldCount stats is not tracked by the firmware */
> +	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
> +	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
> +	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
> +	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
> +	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
> +	spin_unlock(&emac->prueth->stats_lock);
> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index f73b8f5fca956..ad9061408050e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -45,6 +45,7 @@
>  #include "icss_iep.h"
>  #include "icssg_switch_map.h"
>  #include "icssg_qos.h"
> +#include "icssg_stats.h"
>  
>  #define PRUETH_MAX_MTU		(2000 - ETH_HLEN - ETH_FCS_LEN)
>  #define PRUETH_MIN_PKT_SIZE	(VLAN_ETH_ZLEN)
> @@ -58,12 +59,16 @@
>  
>  #define ICSSG_MAX_RFLOWS	8	/* per slice */
>  
> -#define ICSSG_NUM_PA_STATS	32
> -#define ICSSG_NUM_MIIG_STATS	60
> +#define ICSSG_NUM_PA_STATS	ARRAY_SIZE(icssg_all_pa_stats)
> +#define ICSSG_NUM_MIIG_STATS	ARRAY_SIZE(icssg_all_miig_stats)

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> index 7159baa0155cf..cfdb6f5dc5da1 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> @@ -74,7 +74,7 @@ void icssg_stats_work_handler(struct work_struct *work)
>  }
>  EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
>  
> -int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
> +u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
>  {
>  	int i;
>  
> @@ -91,5 +91,5 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
>  	}
>  
>  	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
> -	return -EINVAL;
> +	return 0;
>  }

[Severity: Medium]
The commit message describes this hunk as:

    Fix emac_get_stat_by_name() to return u64 instead of int and return
    0 on error instead of -EINVAL. This prevents invalid stat lookups
    from corrupting output stats with signed error codes cast to u64.

Is that path reachable? Every caller passes a literal name that exists in
icssg_all_miig_stats[] or icssg_all_pa_stats[], and each caller that uses
PA names is guarded, e.g. in emac_get_mm_stats():

	if (!emac->prueth->pa_stats)
		return;

so the netdev_err()/-EINVAL branch never runs.

The change does look like it fixes something else that the message does
not mention: the old int return truncated the u64 accumulators built by
emac_update_hardware_stats() and sign-extended them into the u64 fields
of rtnl_link_stats64 and ethtool_rmon_stats:

drivers/net/ethernet/ti/icssg/icssg_common.c:icssg_ndo_get_stats64() {
	stats->rx_bytes       = emac_get_stat_by_name(emac, "rx_bytes");
	...
}

Once rx_bytes or tx_bytes crosses 2^31, would ip -s link have reported
roughly 1.8e19 before this patch?

Should this be split out as its own patch with a Fixes: tag and a
description of the truncation, so that it can be picked up for stable,
rather than being bundled into the MAC Merge feature patch?

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> index 5ec0b38e0c67d..b86da8da23a18 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> @@ -8,8 +8,6 @@
>  #ifndef __NET_TI_ICSSG_STATS_H
>  #define __NET_TI_ICSSG_STATS_H
>  
> -#include "icssg_prueth.h"
> -
>  #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */

[Severity: Low]
With this include gone, icssg_stats.h has no includes of its own, yet it
still uses ETH_GSTRING_LEN, offsetof() and the FW_* offsets from
icssg_switch_map.h. It compiles today only because icssg_prueth.h
includes linux/ethtool.h and icssg_switch_map.h ahead of the new
"#include icssg_stats.h".

Would it be worth making icssg_stats.h self-contained by including
linux/ethtool.h and icssg_switch_map.h directly, so a future .c file that
includes it first still builds?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915063052.2274986-1-m-malladi%40ti.com
