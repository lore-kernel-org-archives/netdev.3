Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0238E8CB
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252605; cv=none; b=Ur05t2o0NUt5Ecs3JwRVoZqA7WAhVjgYIqTh/yB1P/Wpscy7R6u5vgBdrvQvhhGQNdJLENtJMy9EVlEv+4w5mMJuz7JQhB22vsN990xLNH4r6Mzb/FCgFg88kT8d8Tf7qwL1g6W5bROO80TvBoZ55/nLgDhG207lpCfkfgxqh7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252605; c=relaxed/simple;
	bh=+gDgo39xYHH79ONIwY0ghrlnRzuOANqpHBluZS7BZyM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQULaXljwyN1OpokKJ56EYrJGsVOyO6ZAXoS4vQRN+hdm5J8N2szDL+4GRRPRPtReDL0yeZ/fK7C7ZBemm6VAxNA67K1ROwUzhlzO0F1Vh1WPhmfvK2I8AByElUwzg+bJ/+qHfcQya2gxfV5jMKJBEVTAUKb/MTSLWF39Q9+gx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXC5s7Pi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXC5s7Pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD3D1F000FF;
	Thu, 24 Sep 2026 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790252603;
	bh=Asfm6zvBLcZKQ1pJkJljI/XxbhMDO1tGxCdUVErtmX4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aXC5s7PizKrxScmdE0Yd1Q6WDA+Tslb+j872uBAVNsFp0jhgT5Zrl2k9jHN3JEU+w
	 VEOVASYqD1P7bKCW9DCv3sEi5VxLGiMpchm8VNQKjpk+HRASba+p+EVTyKJF0QBXOF
	 qENQVZ0FojWhHAQ84YTd30BSumvEblJXhD9nvgIFvHneAAjaQJDAjm42YYw3jkliOj
	 qupWIoiDb4QaWYQQ/Gp+DL2xQ0LIPD64rimxz13IyjBX/j4bz5/MmZtodnn6zrooxa
	 3roUkHGn/OvvZRL9Eqs6CV42K2cEK7/mrde5mKmDaRrkFBNZDy69jGFo8piPynd1PD
	 xRWBtrpfi+hJw==
Subject: Re: [PATCH net v4 5/5] ice: fix stats array overflow when VF requests
 more queues
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 mschmidt@redhat.com, przemyslaw.kitszel@intel.com, poros@redhat.com,
 aleksandr.loktionov@intel.com, horms@kernel.org
Date: Thu, 24 Sep 2026 12:23:22 +0000
Message-ID: <179025260231.2160803.16852325862949481208@kernel.org>
In-Reply-To: <20260921182106.1015019-6-anthony.l.nguyen@intel.com>
References: <20260921182106.1015019-6-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the identical stats-array out-of-bounds write
  remains reachable through the PF devlink `driver_reinit` reload path.
- [Medium] The patch introduces a new abort point in the middle of an
  already-started hardware VF reset.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the reader
  the patch now depends on for sizing (`ice_vsi_get_num_qs()`) disagrees…
- [Medium] This problem wasn't introduced by this patch, but the patch
  adds a new concrete failure source to it: `ice_vc_request_qs_msg()`…

--

ice: fix stats array overflow when VF requests more queues

The patch exports ice_vsi_resize_stat_arrays() and calls it from
ice_vf_reconfig_vsi() before ice_vsi_decfg(), so the per-ring stats
pointer arrays are grown before alloc_txq/alloc_rxq are bumped to the
larger VF-requested queue count.  This mirrors what ice_vsi_rebuild()
already does.

Closes: https://redhat.atlassian.net/browse/RHEL-164321

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index c6166ff44fc91..8d462570d1529 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3096,7 +3096,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
>   *
>   * Return: 0 on success and negative value on failure
>   */
> -static int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
> +int ice_vsi_resize_stat_arrays(struct ice_vsi *vsi)
>  {
>  	struct ice_vsi_alloc_queues_params qs;
>  	struct ice_vsi_stats *old_stat;

[Severity: High]
Since the helper is now exported, would it make sense to also cover the
PF devlink reload path, or to put the capacity check inside
ice_vsi_alloc_stat_arrays() instead?  The same overflow looks reachable
without any VF involved.

ice_devlink_reinit_down() tears the main VSI down with:

	rtnl_lock();
	ice_vsi_decfg(ice_get_main_vsi(pf));
	rtnl_unlock();
	ice_deinit_pf(pf);

ice_vsi_decfg() only calls ice_vsi_free_arrays(); it does not free
pf->vsi_stats[vsi->idx], and neither ice_unload(), ice_deinit_pf() nor
ice_deinit_dev() touch pf->vsi_stats (ice_dealloc_vsis() is only reached
from ice_init()/ice_deinit(), i.e. probe/remove).

ice_devlink_reinit_up() then does:

	vsi->flags = ICE_VSI_FLAG_INIT;

	rtnl_lock();
	err = ice_vsi_cfg(vsi);
	rtnl_unlock();

with no ice_vsi_resize_stat_arrays() call, so ice_vsi_set_num_qs() picks a
fresh alloc_txq/alloc_rxq from min(ice_get_avail_txq_count(pf),
netif_get_num_default_rss_queues()), ice_vsi_alloc_stat_arrays() takes its
early return:

	if (pf->vsi_stats[vsi->idx])
	/* realloc will happen in rebuild path */
		return 0;

and ice_vsi_alloc_ring_stats() indexes the retained, smaller arrays:

	ice_for_each_alloc_txq(vsi, i) {
		...
		ring_stats = tx_ring_stats[i];

Can this overflow tx_ring_stats[]/rx_ring_stats[] the same way as the VF
case?  netif_get_num_default_rss_queues() is derived from cpu_online_mask
and ice_deinit_pf()/ice_init_pf() re-allocate avail_txqs/avail_rxqs as
all-free, so sizing the arrays while some CPUs are offline, onlining more
CPUs, then running "devlink dev reload ... action driver_reinit" would grow
the count across the reload.

> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index a54cb2b8d3c76..c56a35b8dd48f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -268,6 +268,10 @@ static int ice_vf_reconfig_vsi(struct ice_vf *vf)
>  
>  	vsi->flags = ICE_VSI_FLAG_NO_INIT;
>  
> +	err = ice_vsi_resize_stat_arrays(vsi);
> +	if (err)
> +		return err;
> +

[Severity: Medium]
Is this a safe place to abort?  By the time ice_reset_vf() reaches
ice_vf_reconfig_vsi(), the hardware reset has already been started:
ICE_VF_STATE_DIS is set, ice_trigger_vf_reset() wrote VFGEN_RSTAT =
VIRTCHNL_VFR_INPROGRESS and toggled VPGEN_VFRTRIG.VFSWR, ice_dis_vf_qs()
disabled the VF's queues and ice_reset_interrupts() dropped its interrupt
mappings.

If ice_vsi_resize_stat_arrays() returns -ENOMEM here, the function returns
before ice_vsi_decfg()/ice_fltr_remove_all()/ice_vsi_cfg(), and
ice_reset_vf() takes:

	if (ice_vf_reconfig_vsi(vf)) {
		dev_err(dev, "Failed to release and setup the VF%u's VSI\n",
			vf->vf_id);
		err = -EFAULT;
		goto out_unlock;
	}

	ice_vf_post_vsi_rebuild(vf);

so ice_vf_post_vsi_rebuild() is skipped.  That is the only caller of
ice_sriov_post_vsi_rebuild():

	static void ice_sriov_post_vsi_rebuild(struct ice_vf *vf)
	{
		ice_ena_vf_mappings(vf);
		wr32(&vf->pf->hw, VFGEN_RSTAT(vf->vf_id), VIRTCHNL_VFR_VFACTIVE);
	}

and the only path that reaches ice_vf_set_initialized(), which is the one
place ICE_VF_STATE_DIS gets cleared:

	clear_bit(ICE_VF_STATE_DIS, vf->vf_states);
	set_bit(ICE_VF_STATE_INIT, vf->vf_states);

Does that leave the VF wedged?  Afterwards VFGEN_RSTAT still reports reset
in progress with no mappings programmed, the VSI keeps its pre-reset
LAN/RDMA scheduler config because decfg was skipped,
ice_vc_process_vf_msg() rejects every virtchnl message with -EPERM while
ICE_VF_STATE_DIS is set, and a subsequent ice_reset_vf() short-circuits on
ice_is_vf_disabled() and returns 0.

Would doing the allocation before the reset is triggered, or treating a
resize failure as non-fatal (ice_vsi_alloc_ring_stats() already tolerates
pre-existing entries), keep the hardware sequence complete?

[Severity: Medium]
This isn't a bug introduced by this patch, but the new -ENOMEM path feeds
an existing unchecked return.  ice_vc_request_qs_msg() in virt/queues.c
discards the ice_reset_vf() result:

		vf->num_req_qs = req_queues;
		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
		dev_info(dev, "VF %d granted request of %u queues.\n",
			 vf->vf_id, req_queues);
		return 0;

When ice_vsi_resize_stat_arrays() fails, ice_reset_vf() converts that to
-EFAULT and goes to out_unlock, skipping ice_vf_post_vsi_rebuild() and
ice_reset_vf_mbx_cnt(), yet the VF is still told the request was granted.
Should the return value be checked now that there is a new failure source?

[Severity: Medium]
This is a pre-existing issue and not something this patch introduces, but
the sizing helper the patch now relies on disagrees with one of its
writers.  ice_sriov_set_msix_vec_count() requests a new VF queue count via:

	vsi->req_txq = queues;
	vsi->req_rxq = queues;

	if (ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT)) {

and restores prev_queues the same way on the unroll path.  However
req_txq/req_rxq are only read under case ICE_VSI_PF in
ice_vsi_get_num_qs() and ice_vsi_set_num_qs(); the VF branch uses:

	case ICE_VSI_VF:
		qs.alloc_txq = vsi->vf->num_req_qs ?: vsi->vf->num_vf_qs;
		qs.alloc_rxq = qs.alloc_txq;

vf->num_req_qs has a single write site, in ice_vc_request_qs_msg(), and is
never cleared, so once a VF has issued VIRTCHNL_OP_REQUEST_QUEUES a later
sriov_vf_msix_count write changes vf->num_msix (and num_q_vectors) while
the queue count stays pinned at the stale value, and the "Changing VF %d
resources to %d vectors and %d queues" message reports the overwritten
count.

Note this does not cause the overflow the patch fixes, since
ice_vsi_resize_stat_arrays() and ice_vsi_set_num_qs() evaluate the same
expression.  Should those four req_txq/req_rxq assignments be dropped or
should the VF branch honor them?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921182106.1015019-1-anthony.l.nguyen%40intel.com
