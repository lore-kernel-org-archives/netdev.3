Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14803A1681;
	Thu,  3 Sep 2026 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479069; cv=none; b=qvEHbrpeYAyf9NA0ryjg42Nc+m66y8PDEy7Sp6s39PLKs11SBb8pmp6Z1clSHvY2RlxeHugzpC6f0Ru1iDjF2MCNrBQ/vQx1nTUoFXdSHdWVgln/yfi4/6lBsHGRmNxd/CvHK4P1uqF3e8DLL7p9GBvnPud+KVnqz6hjFDUlKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479069; c=relaxed/simple;
	bh=jWfbaWIuKuBt41Xw/ilNcUSrY5c2RDlejX5qfDZWfhs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUjUVTV4rgfQ/U0MXf4Z7wJVwW2Gtnd2ZG9NgZYrYPx6wkl0x78L5m4BDVGQxf2F7/5c6tMBJ4H76X2ADblV4aS05tEGBV+sQyVJkDvkffXCfa1WU1tjWT3jPR1CrXkZ5Cso3/wkLYJ821o4xAllcLosvsUo6cfaiwRvcyBXx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOqVWTBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOqVWTBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95CA1F00A3D;
	Thu,  3 Sep 2026 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479067;
	bh=yw8lPJfec8tBYCcxBlZc+vMXTQhcPReHCDbeH7u0TEs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NOqVWTBGuLNDTFecmsgUUTdd600wDvEDAwWJWucQufBdgbj3loWj0GKF3BkfBVUXY
	 Q/2oP/4neEp/dxtra0KPIkGXuXLbkf4R3+RF4zWJpVQlG7QsFFt4bGzKMSnGNxGY4H
	 /joZbRuiV2RTA5UXpMx4Wb839s9wf4nABAHSUwbkT5Ayk47l3IX7/gRVb1T2CppTlT
	 G0isqx7+PnQkirc/Z2SLunf5ehwXmCP2aLQT/XVmA37PUbGXOrNL2T97raMcdsgiFM
	 PefBhLyoy5J48YA4qEdVGkt4Qx5weqwieyslfpts8PH0aFrEEpz62wgfuZObTjDePw
	 MY0GEpdakcezA==
Subject: Re: [PATCH v3 net-next 09/15] net: enetc: add MAC address filtering
 support for VFs of ENETC v4
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 23:44:26 +0000
Message-ID: <178847906626.4131868.15091552349852478044@kernel.org>
In-Reply-To: <20260831025441.635045-10-wei.fang@oss.nxp.com>
References: <20260831025441.635045-10-wei.fang@oss.nxp.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 · Low: 1

- [Medium] Commit message mischaracterizes the privilege model of
  ENETC_MSG_SET_MAC_HASH_TABLE.
- [Medium] The patch lets a VF arm PF-owned hardware filtering state
  (PSIPMMR unicast/multicast promiscuous bits and the per-SI…
- [Medium] pf->msg_lock is now used for two incompatible purposes: (a) as
  the mailbox transaction lock, held across a sleeping hardware poll -…
- [Low] Concern that the patch adds the PF-side mailbox protocol
  (ENETC_MSG_SET_MAC_HASH_TABLE, ENETC_MSG_SET_MAC_PROMISC_MODE) without…

--

net: enetc: add MAC address filtering support for VFs of ENETC v4

This adds two VSI-to-PSI mailbox commands so an ENETC v4 VF can ask the PF
to program its per-SI MAC hash filter tables and to change its unicast and
multicast promiscuous mode bits in PSIPMMR.  The PF-owned PSIPMMR
read-modify-write is now serialized with pf->msg_lock, and losing trusted
status clears part of the VF's filtering state.

A few questions below.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 363ec562934e..a4ffe1100bd7 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c

[ ... ]

> @@ -528,8 +523,10 @@ static int enetc4_pf_set_rx_mode(struct net_device *ndev,
>  		type = ENETC_MAC_FILTER_TYPE_ALL;
>  	}
>  
> +	enetc_pf_msg_lock(pf);
>  	enetc_set_si_uc_promisc(si, 0, uc_promisc);
>  	enetc_set_si_mc_promisc(si, 0, mc_promisc);
> +	enetc_pf_msg_unlock(pf);

[Severity: Medium]

Is pf->msg_lock the right lock to reuse for the PSIPMMR read-modify-write
here?  It looks like msg_lock is also the mailbox transaction lock, and it
is held across a sleeping hardware poll:

drivers/net/ethernet/freescale/enetc/enetc_msg.c:
enetc_msg_register_link_status_notifier() {
	mutex_lock(&pf->msg_lock);
	...
	enetc_msg_notify_vf_link_status(pf, PSIMSGSR_MS(vf_id));
msg_unlock:
	mutex_unlock(&pf->msg_lock);
}

which ends in:

enetc_pf_send_msg() {
	...
	return read_poll_timeout(enetc_rd, val, !(val & ms_mask), 1000,
				 200000, false, hw, ENETC_PSIMSGSR);
}

enetc_pf_notify_vf_link_status() takes the same mutex around the same poll.

enetc4_pf_set_rx_mode() is the ndo_set_rx_mode_async callback, which runs
with rtnl held (netif_rx_mode_run() asserts it for a driver that sets none
of request_ops_lock/queue_mgmt_ops/net_shaper_ops, and netdev_work_proc()
takes rtnl_lock() unconditionally).  Can a VF that never drains its mailbox
reply then keep the PF's address-list/promiscuity update, and the global
rtnl mutex, waiting up to 200 ms per poll?  The same helper is now taken by
the mac_filter debugfs reader in enetc_mac_filter_show().

Would a small dedicated lock for the PSIPMMR read-modify-write, separate
from the mailbox transaction mutex, avoid coupling a couple of register
writes to a guest-controlled sleeping poll?

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> index c3ae4c024f34..d58fbaeaf46c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c

[ ... ]

> @@ -108,6 +110,132 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
>  	return pf_msg;
>  }
>  
> +static u16 enetc_msg_set_vf_mac_hash_filter(struct enetc_pf *pf, int vf_id,
> +					    void *vf_msg)
> +{
> +	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
> +	struct enetc_msg_mac_hash_filter *msg = vf_msg;
> +	u16 pf_msg = ENETC_PF_MSG_SUCCESS;
> +	struct enetc_si *si = pf->si;
> +	int si_id = vf_id + 1;
> +	u64 uc_hash, mc_hash;
> +	bool trusted;
> +	int type;
> +
> +	/* Currently, hardware only supports 64 bits table size */
> +	if (FIELD_GET(ENETC_MSG_MAC_HASH_SIZE, msg->sz_type) !=
> +	    ENETC_MAC_HASH_TABLE_SIZE_64)
> +		return ENETC_PF_MSG_NOTSUPP;
> +
> +	mutex_lock(&vf_state->lock);
> +
> +	/* For an untrusted VF, unicast MAC hash filtering is not permitted.
> +	 * For multicast, the MAC hash filter is strictly limited to a maximum
> +	 * of 8 bits to satisfy its basic multicast communication requirements
> +	 * while preventing potential network abuse.
> +	 */
> +	trusted = !!(vf_state->flags & ENETC_VF_FLAG_TRUSTED);
> +	type = FIELD_GET(ENETC_MSG_MAC_TYPE, msg->sz_type);
> +	switch (type) {
> +	case ENETC_MAC_FILTER_TYPE_UC:
> +		if (!trusted) {
> +			pf_msg = ENETC_PF_MSG_PERM_DENY;
> +			goto vf_state_unlock;
> +		}
> +
> +		uc_hash = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
> +		enetc_set_si_uc_hash_filter(si, si_id, uc_hash);
> +		break;
> +	case ENETC_MAC_FILTER_TYPE_MC:
> +		mc_hash = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
> +		if (!trusted &&
> +		    hweight64(mc_hash) > ENETC_VF_MC_HASH_BITS_MAX) {
> +			pf_msg = ENETC_PF_MSG_PERM_DENY;
> +			goto vf_state_unlock;
> +		}
> +
> +		enetc_set_si_mc_hash_filter(si, si_id, mc_hash);
> +		break;

[Severity: Medium]

Does the changelog match the policy implemented here?  It says:

  "1. ENETC_MSG_SET_MAC_HASH_TABLE (cmd_id 3): allows a trusted VF to
  program its unicast and/or multicast MAC hash filter table. The PF
  validates that the hardware-supported 64-bit table size is requested
  before applying the configuration via the per-SI hash filter registers."

The ENETC_MAC_FILTER_TYPE_MC case does not test ENETC_VF_FLAG_TRUSTED at
all.  An untrusted VF gets its multicast hash filter programmed as long as
no more than ENETC_VF_MC_HASH_BITS_MAX of the 64 buckets are set.

The TYPE_ALL case below does the same: for an untrusted VF it applies the
multicast half of the request and then reports UCF_DENY.

Neither the new ENETC_VF_MC_HASH_BITS_MAX constant nor the "up to 8 buckets
for untrusted VFs" rule appears in the changelog.  Could the commit message
describe this rule, and where the value 8 comes from?

> +	case ENETC_MAC_FILTER_TYPE_ALL:
> +		if (!msg->hdr.len) {
> +			pf_msg = ENETC_PF_MSG_INV_LEN;
> +			goto vf_state_unlock;
> +		}
> +
> +		uc_hash = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
> +		mc_hash = (u64)msg->hash_tbl[3] << 32 | msg->hash_tbl[2];
> +
> +		if (!trusted &&
> +		    (hweight64(mc_hash) <= ENETC_VF_MC_HASH_BITS_MAX)) {
> +			enetc_set_si_mc_hash_filter(si, si_id, mc_hash);
> +			pf_msg = ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_UCF_DENY);
> +			goto vf_state_unlock;
> +		}

[ ... ]

> +static u16 enetc_msg_set_vf_mac_promisc_mode(struct enetc_pf *pf, int vf_id,
> +					     void *vf_msg)
> +{

[ ... ]

> +	mutex_lock(&pf->msg_lock);
> +
> +	if (type & ENETC_MAC_FILTER_TYPE_UC)
> +		enetc_set_si_uc_promisc(si, si_id, promisc);
> +
> +	if (type & ENETC_MAC_FILTER_TYPE_MC)
> +		enetc_set_si_mc_promisc(si, si_id, promisc);
> +
> +	mutex_unlock(&pf->msg_lock);

[Severity: Medium]

This arms PSIPMMR_SI_MAC_UP/MP for the VF's SI, and the hash filter paths
above write PSIUMHFR/PSIMMHFR for that SI.  Those registers live in the PF
port register space, so a VF-level reset does not clear them.

What clears them when a single VF goes away while SR-IOV stays enabled, for
example on VF driver unbind or guest reboot?  The only disarm paths added
here are enetc_pf_set_vf_trust(ndev, vf, false) and
enetc_msg_clear_vf_config(), and the latter only runs from
enetc_msg_psi_free(), i.e. full SR-IOV teardown.

If neither runs, does the SI stay in promiscuous mode with the previously
programmed hash buckets, so that the next driver bound to that VF inherits
filtering scope it never asked for?  An untrusted VF can also leave up to
ENETC_VF_MC_HASH_BITS_MAX multicast buckets armed this way.

The later patch "net: enetc: restore VF MAC promiscuous mode after FLR for
ENETC v4" adds enetc4_pf_vf_flr_handler(), but that re-applies the tracked
ENETC_VF_FLAG_UC_PROMISC/MC_PROMISC state instead of clearing it and does
not touch the hash filter tables, so the gap seems to remain at the end of
the series.

[ ... ]

> @@ -582,6 +720,31 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
>  	return err;
>  }
>  
> +static void enetc_msg_clear_vf_config(struct enetc_pf *pf, int vf_id)
> +{
> +	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
> +	struct enetc_si *si = pf->si;
> +	int si_id = vf_id + 1;
> +
> +	/* For ENETC v1, we only support setting the VF's MAC address via
> +	 * VSI-to-PSI messages, so there is no configuration to clear.
> +	 */
> +	if (is_enetc_rev1(si))
> +		return;
> +
> +	mutex_lock(&vf_state->lock);
> +
> +	mutex_lock(&pf->msg_lock);
> +	enetc_set_si_uc_promisc(si, si_id, false);
> +	enetc_set_si_mc_promisc(si, si_id, false);
> +	mutex_unlock(&pf->msg_lock);
> +
> +	enetc_set_si_uc_hash_filter(si, si_id, 0);
> +	enetc_set_si_mc_hash_filter(si, si_id, 0);
> +
> +	mutex_unlock(&vf_state->lock);
> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> index 06dc47164dc5..12e67f611f77 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> @@ -6,6 +6,7 @@
>  
>  #define ENETC_PF_NUM_RINGS	8
>  #define ENETC_VLAN_HT_SIZE	64
> +#define ENETC_VF_MC_HASH_BITS_MAX	8 /* For untrusted VFs */

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index 7a11370d2b8e..8007dce90195 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c

[ ... ]

> @@ -600,11 +620,39 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
> +		/* Disable unicast and multicast promiscuous modes */
> +		mutex_lock(&pf->msg_lock);
> +		enetc_set_si_uc_promisc(si, si_id, false);
> +		enetc_set_si_mc_promisc(si, si_id, false);
> +		mutex_unlock(&pf->msg_lock);
> +
> +		/* Clear unicast hash filter */
> +		enetc_set_si_uc_hash_filter(si, si_id, 0);
> +
> +		/* Clear multicast hash filter if its set bits exceed
> +		 * ENETC_VF_MC_HASH_BITS_MAX.
> +		 */
> +		hash = enetc_get_si_mc_hash_filter(si, si_id);
> +		if (hweight64(hash) > ENETC_VF_MC_HASH_BITS_MAX)
> +			enetc_set_si_mc_hash_filter(si, si_id, 0);
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
> index 1d35e906fc3a..91a9c339245a 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
> @@ -30,6 +30,18 @@ static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
>  	return enetc_global_rd(hw, ENETC_G_EIPBRR0) & EIPBRR0_REVISION;
>  }
>  
> +static inline void enetc_pf_msg_lock(struct enetc_pf *pf)
> +{
> +	if (pf->total_vfs)
> +		mutex_lock(&pf->msg_lock);
> +}
> +
> +static inline void enetc_pf_msg_unlock(struct enetc_pf *pf)
> +{
> +	if (pf->total_vfs)
> +		mutex_unlock(&pf->msg_lock);
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831025441.635045-1-wei.fang%40oss.nxp.com
