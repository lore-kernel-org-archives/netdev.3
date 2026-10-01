Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDF4EF14B;
	Thu,  1 Oct 2026 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846018; cv=none; b=WzjauIg67UZ2biZZoE5mRJ2rBPT5woty1oasawXdhZECmuHQbWpO5pNRxovt62R9OBt31SZ7lZVeeXPj44I/hdGIfOj2QPCzeA+FF0K4euLPLTAtPo9tfZ4tXYU7ETBGmqei0GY5wMGENJ4Mu000alKeKnJlEsXBA1kyhjD1PH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846018; c=relaxed/simple;
	bh=tsPZb/Jor7Mv2MoJ0siSZBZKbbmPFn61DWoKEQwfu0g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hyLeeFpsmg0r96uKY0K7jkFnZ2xYtW1VUNzkmyCubFSc3Vrs65TZj+vIOyqecGgFcyL0cqiZMn0V5egTpjyGuxmtRSGODwsOv1GYv7Y54TSK/3rS4xW4D0VDigM+GkWlxlfymwiGFKiXBR1j065duEdVF1xoNJOkwGpshz5iRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPzNAIRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPzNAIRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EBE1F00898;
	Thu,  1 Oct 2026 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846014;
	bh=dCdcbtPrUPPEA62rE4AhM2/O/gSL+NYG2hz9IXm35BQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UPzNAIRwMBJrGutCBFZG+Tlke2HnvcmQs6z+O6Fh5PqNzUBkJa+SSnF+dDsLJlfRN
	 m2fSmZz7mWKVdBt/JbOuaq8ZBv31ShEb9FGsluuGIJsqKx+JfIW0b4lWymm0+FknYy
	 SuaoOoqd7LFyLr1E1cbPq1sdhCaWLIfGOfIl/7b/CpjoecMWu/u0sK4oW6hfSxRHv0
	 QovQ9PLtzcymCweW5MYx+DBzvh9i6kf028W1WQO4SZUJwKfnZsmchAfHDjenjztATc
	 QGnizKLyGFIyWnC+G+OVVM9GnpqAnD9EkcLRDig1TvMar9Pn6OOUUXEz9QkpbXSk+2
	 1mzPVWF8XQXpw==
Subject: Re: [net-next, v4 02/10] bnge: add NTUPLE/ARFS VNIC
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Thu, 01 Oct 2026 09:13:32 +0000
Message-ID: <179084601290.434549.17111390596408514056@kernel.org>
In-Reply-To: <20260928061307.1172344-3-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-3-vikas.gupta@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] bnge_alloc_and_setup_vnic() (bnge_vnic.c) allocates the NTUPLE
  VNIC in firmware with bnge_hwrm_vnic_alloc() and then calls…
- [Medium] Any bnge_alloc_rfs_vnic() failure during open, including a
  transient HWRM or firmware error, makes bnge_init_chip() clear…
- [Low] At this commit, bnge_set_dflt_rfs() adds NETIF_F_NTUPLE to
  hw_features and features, and ndo_fix_features/ndo_set_features let…
- [Low] The reservation side and the allocation side use different
  conditions.
- [Low] On aRFS VNIC allocation failure, bnge_init_chip() writes directly
  to bn->netdev->features (&= ~NETIF_F_NTUPLE) from the ndo_open path.
- [Low] The patch adds the first runtime read-modify-write of bd->flags
  on the ndo_open path: 'bd->flags &= ~BNGE_EN_ARFS_CAP' in…
- [Low] bnge_arfs_capable() (bnge_resc.c) sends HWRM_FUNC_CFG through
  bnge_hwrm_reserve_rings() with only vnic and rss_ctx set, so…

--

bnge: add NTUPLE/ARFS VNIC

This commit adds a second VNIC for NTUPLE/aRFS. On aRFS-capable devices
it reserves the extra VNIC and RSS contexts and turns NETIF_F_NTUPLE on
by default. It also adds ndo_fix_features and ndo_set_features, so
NTUPLE can be changed only while the interface is down.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index 9e64b1933c023..c6b9048586b36 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -2546,6 +2548,18 @@ static int bnge_init_chip(struct bnge_net *bn)
>  	if (rc)
>  		goto err_out;
>  
> +	if ((bn->priv_flags & BNGE_NET_EN_NTUPLE) && bnge_is_arfs_cap(bd)) {
> +		rc = bnge_alloc_rfs_vnic(bn);
> +		if (rc) {
> +			netdev_warn(bn->netdev,
> +				    "Failed to allocate aRFS VNIC (%d), disabling ARFS\n",
> +				    rc);
> +			bd->flags &= ~BNGE_EN_ARFS_CAP;

[Severity: Medium]
Does clearing BNGE_EN_ARFS_CAP here turn a transient firmware error into
a permanent loss of the feature?

The only code that sets this bit is in bnge_net_init_dflt_config(), and
that function is only reached from bnge_probe_one():

    if (bnge_arfs_capable(bd, false))
        bd->flags |= BNGE_EN_ARFS_CAP;

After one failed open, bnge_fix_features() drops NTUPLE from every later
request:

    } else if ((features & NETIF_F_NTUPLE) && !bnge_is_arfs_cap(bn->bd)) {
        features &= ~NETIF_F_NTUPLE;

hw_features still advertises NETIF_F_NTUPLE. So "ethtool -K <dev> ntuple
on" silently does nothing until the driver is reloaded.

This fallback also leaves bn->nr_vnics at 2, and vnic_info[1] may be only
half configured. Later in bnge_init_chip(), bnge_set_tpa() still walks
that VNIC. If HWRM_VNIC_TPA_CFG fails there, the code takes goto err_out.

Could that fail the same open this fallback is meant to save? That part
depends on how the firmware treats the half-configured VNIC.

[Severity: Low]
Can this read-modify-write of bd->flags race with
bnge_rdma_aux_device_add()?

bnge_probe_one() registers the netdev in bnge_netdev_alloc() before it
calls bnge_rdma_aux_device_add(). If auxiliary_device_add() fails, that
path does this with no lock held:

    auxiliary_device_uninit(aux_dev);
    bd->flags &= ~BNGE_EN_ROCE;

The update here runs under rtnl and the netdev instance lock, so the two
writers share no lock. Userspace can open the new netdev at the same
time. If both paths fail together, one of the two plain u64 updates can
be lost. For example, BNGE_EN_ARFS_CAP could reappear after open decided
to disable aRFS.

Before this patch, bd->flags was only written during probe or on that aux
path, so this race is new. The window is small and needs two failures at
the same time.

> +			bn->priv_flags &= ~BNGE_NET_EN_NTUPLE;
> +			bn->netdev->features &= ~NETIF_F_NTUPLE;

[Severity: Low]
Is it fine to write netdev->features directly from the ndo_open path?

Documentation/networking/netdev-features.rst says netdev->features
"should be changed only by network core or in error paths of
ndo_set_features callback".

The direct write skips the feature recalculation and the
NETDEV_FEAT_CHANGE notification. The netdev_update_features() call added
to bnge_close() then computes the same set, which is already cleared. So
no notification is ever sent for this on-to-off change.

Would calling netdev_update_features() here work instead? ndo_open
already holds rtnl and the instance lock.

> +		}
> +	}
> +

[ ... ]

> @@ -3233,6 +3285,18 @@ static void bnge_init_ring_params(struct bnge_net *bn)
>  	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
>  }
>  
> +static void bnge_set_dflt_rfs(struct bnge_net *bn)
> +{
> +	bn->netdev->hw_features &= ~NETIF_F_NTUPLE;
> +	bn->netdev->features &= ~NETIF_F_NTUPLE;
> +	bn->priv_flags &= ~BNGE_NET_EN_NTUPLE;
> +	if (bnge_is_arfs_cap(bn->bd)) {
> +		bn->netdev->hw_features |= NETIF_F_NTUPLE;
> +		bn->netdev->features |= NETIF_F_NTUPLE;
> +		bn->priv_flags |= BNGE_NET_EN_NTUPLE;
> +	}
> +}

[Severity: Low]
With this patch, NETIF_F_NTUPLE is advertised and on by default, and it
can be toggled through ndo_fix_features and ndo_set_features. Is the code
behind the feature there yet?

At this commit:

- bnge_netdev_ops has no ndo_rx_flow_steer.
- rx_cpu_rmap is never allocated.
- bnge_ethtool_ops has no get_rxnfc or set_rxnfc.

So "ntuple-filters: on" is reported and "ethtool -N" returns -EOPNOTSUPP.
An extra firmware VNIC and extra RSS contexts are also reserved for a
feature that does nothing yet.

Later patches in the series fill this in:

- "bnge: add NTUPLE filter support in ethtool" adds get_rxnfc and
  set_rxnfc.
- "bnge: add aRFS flow steering ndo support" adds ndo_rx_flow_steer.
- "bnge: add cpu_rmap support for IRQ affinity" allocates rx_cpu_rmap
  after that.

Since rx_cpu_rmap only shows up after ndo_rx_flow_steer exists, nothing
can crash in the meantime. Would it make sense to advertise
NETIF_F_NTUPLE only once that code is in place?

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> index 69a894b52485e..c7024e75f9257 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c

[ ... ]

> @@ -190,11 +200,18 @@ int bnge_cal_nr_rss_ctxs(u16 rx_rings)
>  static u16 bnge_get_total_rss_ctxs(struct bnge_dev *bd,
>  				   struct bnge_hw_rings *hwr)
>  {
> -	return bnge_cal_nr_rss_ctxs(hwr->grp);
> +	u16 rss_ctx = bnge_cal_nr_rss_ctxs(hwr->grp);
> +
> +	rss_ctx *= hwr->vnic;
> +
> +	return rss_ctx;
>  }
>  
>  static u16 bnge_get_total_vnics(struct bnge_dev *bd)
>  {
> +	if (bnge_is_arfs_cap(bd))
> +		return 2;
> +
>  	return 1;
>  }

[Severity: Low]
Should this check BNGE_NET_EN_NTUPLE rather than BNGE_EN_ARFS_CAP?

The reservation side keys on the capability. On capable devices,
bnge_reserve_rings() and bnge_need_reserve_rings() always ask for 2
VNICs, and bnge_get_total_rss_ctxs() doubles the RSS context count.

The allocation side keys on the flag the user controls:

bnge_alloc_vnics():
    if (bn->priv_flags & BNGE_NET_EN_NTUPLE)
        num_vnics++;

After "ethtool -K <dev> ntuple off" with the interface down, the next
open still reserves 2 VNICs and twice the RSS contexts in firmware, but
uses only one VNIC. For comparison, bnxt_get_total_vnics() keys on the
enabled flag BNXT_FLAG_RFS.

[ ... ]

> @@ -563,6 +580,44 @@ static int bnge_alloc_rss_indir_tbl(struct bnge_dev *bd)
>  	return 0;
>  }
>  
> +/* If runtime conditions support RFS */
> +bool bnge_arfs_capable(struct bnge_dev *bd, bool new_rss_ctx)
> +{

[ ... ]

> +	if (hwr.vnic <= bd->hw_resc.resv_vnics &&
> +	    hwr.rss_ctx <= bd->hw_resc.resv_rsscos_ctxs)
> +		return true;
> +
> +	bnge_hwrm_reserve_rings(bd, &hwr);
> +	if (hwr.vnic <= bd->hw_resc.resv_vnics &&
> +	    hwr.rss_ctx <= bd->hw_resc.resv_rsscos_ctxs)
> +		return true;
> +
> +	dev_warn(bd->dev, "Unable to reserve resources to support NTUPLE filters\n");
> +	return false;
> +}

[Severity: Low]
If firmware grants only part of this request, does anything release the
extra resources?

bnge_hwrm_reserve_rings() is called with only vnic and rss_ctx set, and
its return value is ignored. Suppose firmware grants fewer than 2 VNICs
but all the RSS contexts. This function then warns and returns false,
and the partial grant stays in place.

bnxt_rfs_capable() re-reserves with vnic = 1 on this path. Here,
bnge_need_reserve_rings() checks resv_vnics but never resv_rsscos_ctxs:

    if (hw_resc->resv_rx_rings != rx || hw_resc->resv_cp_rings != cprs ||
        hw_resc->resv_vnics != vnic || hw_resc->resv_stat_ctxs != stat)

So the extra RSS contexts seem to stay reserved to this function
indefinitely.

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
> index 3a6c8f0a59541..d98a6196c859c 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c

[ ... ]

> +static int bnge_alloc_and_setup_vnic(struct bnge_net *bn,
> +				     struct bnge_vnic_info *vnic,
> +				     u16 rx_rings)
> +{
> +	int rc;
> +
> +	rc = bnge_hwrm_vnic_alloc(bn->bd, vnic, rx_rings);
> +	if (rc) {
> +		netdev_err(bn->netdev, "hwrm vnic %u alloc failure rc: %d\n",
> +			   vnic->vnic_id, rc);
> +		return rc;
> +	}
> +
> +	/* If bnge_setup_vnic() fails, the VNIC allocated above is not freed
> +	 * here; the caller (bnge_init_chip) unwinds via its err_out path.
> +	 */
> +	return bnge_setup_vnic(bn, vnic);
> +}

[Severity: Medium]
Is this comment accurate? In the bnge_init_chip() hunk above, a failure
from bnge_alloc_rfs_vnic() only logs a warning and clears
BNGE_EN_ARFS_CAP, BNGE_NET_EN_NTUPLE and NETIF_F_NTUPLE. Then it carries
on without jumping to err_out.

Suppose bnge_hwrm_vnic_alloc() succeeds and bnge_setup_vnic() fails
partway. The firmware VNIC and any RSS contexts already allocated by
bnge_hwrm_vnic_ctx_alloc() then stay in firmware while the interface is
up.

bn->nr_vnics stays 2, so bnge_set_tpa() still sends HWRM_VNIC_TPA_CFG to
the half-configured vnic_info[1]:

    for (i = 0; i < bn->nr_vnics; i++) {
        rc = bnge_hwrm_vnic_set_tpa(bn->bd, &bn->vnic_info[i], tpa_flags);

bnge_hwrm_vnic_set_tpa() skips a VNIC only when its fw_vnic_id is
INVALID_HW_RING_ID, and this VNIC has a valid ID.

Meanwhile, bnge_get_total_vnics() now returns 1, while firmware holds 2
VNICs and their contexts. bnge_clear_vnic() frees them at close, so they
are not held forever.

Should this function free the VNIC when setup fails, or should
bnge_init_chip() unwind it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com
