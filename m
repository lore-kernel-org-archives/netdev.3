Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524868;
	b=ovTbIpKpTdQCi7dwUUO2K24j+TXdyknYoFbN4dUq9al13HINWyZsqoq59RIjC+ILzU4c
	 WQx2a9S+rUPntDnXN0YujDtPKMkqx/MX9x4GmyIz0+iITaoblViIonZnrNyz9zbbYf8fk
	 wK/gw19gvr+zCQT00u8kAxDqMPDiJzGGrdKE2gkPieZS5i3TqH8XoiylSsLyFqVIkQlFe
	 kPnYy4vc0s/QNc8MiHIx6ba8jME+D2LILspoJKDIy1KHhZWWA7jVffuqtn1cwE+IJKU9Z
	 4hAIZtuCaVp9ICJBlSaeoJRW27JSoYNOwcETNP7DQcJyBG2FKH2NQnfEI8LD/8P4tjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524868;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WXqgErRqipZCtVLJ6C+AdlUlVD3qxuzDceBathVxNH4=;
	b=si87aLeD2BKI8unhTotBxm9almMQT5zbhP4Ie+Bu/gOgvMtpECWRdDCQT0KVRTTgRXFz
	 vNZk3IWAdFry6af/6PjShctaE7cur2NZr/LERzWyx4h92XdAB07WDUGLRYEQClzMPf9Gc
	 JLo1QKN+ernQOsInoUnr97cTLTkX3o/ZLbDvJNh09HavGkK8nFObG9YCqA62gC2ScsUwc
	 Xi+VA5VDT0Y6APMUi06oDCvgWLQ7g6/InOJBf93r46GwEAXXIDUSFED3SVjLVMvF9B0HR
	 rgle4xJ9u3hxUBxe9GGRCxz3p/aT0JljNh0yAtvrB1fbXGBuk11UxfcZRJJpw36Sung==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLrG+JDz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB0606A333
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLrG+JDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24A81F000C4;
	Thu, 12 Nov 2026 23:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524868;
	bh=WXqgErRqipZCtVLJ6C+AdlUlVD3qxuzDceBathVxNH4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kLrG+JDzl5b+w9uUA8wx5wdIBW0d0t3Bjhzldpx1ddC3x1F8ULaztDqiUd2HhlQ04
	 09BPTFwmEPR5ez6+cWYHjIyBIZ+UAiitsB7vjtddIGRuhLkt+cMfDCfKTclZK9IMms
	 WrTji4zLzR77oOm1grb1KuxnIfu2ad4Q+Gmm8O+vQLBDPuKYhIxr2phxynxVWISiY7
	 I8uDhtbOUb4ny5L3QyMyf+oazeGRVwXiMtr8M/senrZLEiprnmyIUqd0SFQ1fYi3Gw
	 IVbfKOrY2/9UbNggifS/M7zi/XEnT8E/YOQiMaXVIDRwYIPusOTbvWiqGJzgjy0kpS
	 FKhxeosSsOXOw==
Subject: Re: [PATCH net-next v5 15/15] ice: support up to 256 VF queues
From: netdev-bot+sashiko@kernel.org
To: przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com, edumazet@kernel.org,
 horms@kernel.org, pabeni@redhat.com, davem@davemloft.net, jiri@resnulli.us,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 mbloch@nvidia.com, jacob.e.keller@intel.com, jedrzej.jagielski@intel.com,
 anzaki@gmail.com, brett.creeley@amd.com, ohartoov@nvidia.com,
 poros@redhat.com
Date: Thu, 12 Nov 2026 23:07:46 +0000
Message-ID: <179452486620.2199510.8043405120181220671@kernel.org>
In-Reply-To: <20261110141534.95614-16-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-16-przemyslaw.kitszel@intel.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Several changes in this patch affect every PF and VF,
  including setups that never use the new devlink LUT resources.
- [Medium] ice_set_vf_state_dis() now ends with
  set_bit(ICE_VF_STATE_DIS).
- [Medium] The new REQUEST_QUEUES admission check is a check-then-act
  race on the PF queue bitmaps.
- [Medium] ice: lock ordering inversion between vfs.table_lock and
  devlink lock
- [Low] The commit message does not say that this patch is the one that
  makes the new LARGE-VF virtchnl opcodes reachable by a VF.
- [Low] In ice_vf_max_contig_qs() (virt/queues.c), if either
  bitmap_alloc() fails, `if (!txqs || !rxqs) goto out;` leaves max_tx =…
- [Low] The VF devlink instance is torn down in a different order than it
  is set up.

--

ice: support up to 256 VF queues

This patch lets a VF use up to 64 queues with a global RSS LUT, or up to
256 queues with the PF LUT. The LUTs are assigned through new per-VF
devlink instances nested under the PF devlink. Changing the LUT of a VF
schedules a deferred VF reset, and the patch also wires the
LARGE_NUM_QPAIRS virtchnl opcodes into the VF message dispatcher.

> Note that VF reset is deferred to service task.

[Severity: Medium]
The pending reset is also run synchronously from ice_vc_process_vf_msg()
when the VF sends any message, and that message gets no reply:

    if (test_and_clear_bit(ICE_VF_STATE_NEEDS_RESET, vf->vf_states)) {
        dev_info(dev, "doing deferred reset of VF %d\n", vf_id);
        ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
        goto finish;
    }

Could the commit message describe this path as well?

Several other changes here affect every PF and VF, including setups that
never use the new devlink LUT resources. They are only described in the
v1..v5 changelog below the --- line, which git am drops.

VIRTCHNL_OP_REQUEST_QUEUES is now granted only if the request fits in the
longest free contiguous range of PF Tx/Rx queues (ice_vf_max_contig_qs()).
This also fixes a bug that is older than this series.
ice_ena_vf_q_mappings() only logs "Scattered mode for VF Tx queues is not
yet implemented" and never writes VPLAN_TX/RX_QBASE. So a grant on a
fragmented queue space left the VF with unprogrammed queues.

REQUEST_QUEUES from VFs without VIRTCHNL_VF_LARGE_NUM_QPAIRS is capped at
ICE_MAX_QS_PER_VF_VCV1 (16) again. This reverses the 256 limit that "ice:
bump to 256qs for VF" set for all VFs. The dev_err for oversized requests
is removed, and the denial reply now carries the contiguous-range limit.

ice_set_vf_state_dis() now sets ICE_VF_STATE_DIS.
ice_prepare_for_reset() calls it for every VF on every PF reset.

PF rss_size is now clamped to the queue capacity of its LUT in ethtool -L
and in ice_vsi_cfg_rss_lut_key(). This corrects "ice: represent RSS LUTs
as devlink resources".

Would it make sense to describe these in the commit message? The
contiguous-range fix could also go into its own commit with a Fixes: tag,
so that stable can pick it up.

> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index 320b393ddaaf0..766936e234c9e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c

[ ... ]

> @@ -1018,6 +1036,8 @@ void ice_set_vf_state_dis(struct ice_vf *vf)
>  {
>  	ice_set_vf_state_qs_dis(vf);
>  	vf->vf_ops->clear_reset_state(vf);
> +	/* until ice_reset_all_vfs() rebuilds the VF */
> +	set_bit(ICE_VF_STATE_DIS, vf->vf_states);
>  }

[Severity: Medium]
Can this leave a VF disabled for good if its VSI rebuild fails during a PF
reset?

ice_prepare_for_reset() calls ice_set_vf_state_dis() for every VF. The only
place that clears the bit again is ice_vf_set_initialized(), reached
through ice_vf_post_vsi_rebuild(). If ice_vf_rebuild_vsi() fails in
ice_reset_all_vfs(), the loop skips that step:

    if (ice_vf_rebuild_vsi(vf)) {
        dev_err(dev, "VF %u VSI rebuild failed, leaving VF disabled\n",
            vf->vf_id);
        mutex_unlock(&vf->cfg_lock);
        continue;
    }

A later guest FLR then goes through ice_process_vflr_event()->
ice_reset_vf(). There ice_is_vf_disabled() is true, so ice_reset_vf()
only stops the rings and returns 0 through out_unlock. It never calls
ice_vf_reconfig_vsi(). ice_vc_process_vf_msg() also rejects every message
from that VF with -EPERM.

Before this patch nothing on this path set ICE_VF_STATE_DIS. A VF whose
rebuild failed for a transient reason (-ENOMEM, an AQ error) could be
recovered by a guest FLR or a VM restart.

Is disabling and re-enabling SR-IOV now the only way to recover such a VF?

>  
>  /* Private functions only accessed from other virtualization files */
> @@ -1064,6 +1084,9 @@ void ice_deinitialize_vf_entry(struct ice_vf *vf)
>  {
>  	struct ice_pf *pf = vf->pf;
>  
> +	ice_free_rss_lut_vf(vf);
> +	ice_deinit_vf_devlink(vf);
> +

[Severity: Low]
Is the VF devlink torn down in the reverse order of its setup?
ice_init_vf_devlink() makes &vf->vfdev->dev the parent of the instance.
However, ice_free_vfs() removes the VF pci_devs before it gets here:

    if (!pci_vfs_assigned(pf->pdev))
        pci_disable_sriov(pf->pdev);
    ...
    mutex_lock(&vfs->table_lock);
    ...
    ice_free_vf_entries(pf);

and only then calls ice_free_vf_entries()->ice_deinitialize_vf_entry()->
ice_deinit_vf_devlink().

In between, user space can still see a registered pci/<VF BDF> devlink
instance whose parent device is gone, and its resource occ get/set
handlers still work. Until the per-VF loop in ice_free_vfs() sets
ICE_VF_STATE_DIS, a devlink resource set can pass ice_vf_is_ready(). It
can then take a global or PF LUT, program it through the AQ, and schedule
a deferred VF reset in the middle of teardown.

This is not a use-after-free. devlink holds a reference on the VF device,
and the devl lock serializes the handlers against devl_unregister().

Would it be cleaner to unregister the VF devlinks before
pci_disable_sriov()?

>  	if (!ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
>  		list_del(&vf->mbx_info.list_entry);
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
> index f87ccf5d370bb..76f2ba7790537 100644
> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
> @@ -986,6 +986,48 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)

[ ... ]

> +static int ice_vf_max_contig_qs(struct ice_vf *vf, struct ice_vsi *vsi)
> +{
> +	struct ice_pf *pf = vf->pf;
> +	unsigned long *txqs, *rxqs;
> +	int max_tx = 0, max_rx = 0;
> +	int b, e;
> +
> +	txqs = bitmap_alloc(pf->max_pf_txqs, GFP_KERNEL);
> +	rxqs = bitmap_alloc(pf->max_pf_rxqs, GFP_KERNEL);
> +	if (!txqs || !rxqs)
> +		goto out;

[Severity: Low]
If either bitmap_alloc() fails, this function returns 0, as if no queues
were free. ice_vc_request_qs_msg() then sets max_allowed_vf_queues to 0.
Every nonzero request is answered with VIRTCHNL_STATUS_SUCCESS and
num_queue_pairs = 0, and the log may say "only 0 are free in one range".

Should the VF get an error for the allocation failure instead, such as
VIRTCHNL_STATUS_ERR_NO_MEMORY?

This function also mixes a goto out cleanup label with scoped_guard(),
which include/linux/cleanup.h advises against.

> +
> +	scoped_guard(mutex, &pf->avail_q_mutex) {
> +		bitmap_copy(txqs, pf->avail_txqs, pf->max_pf_txqs);
> +		bitmap_copy(rxqs, pf->avail_rxqs, pf->max_pf_rxqs);
> +	}

[ ... ]

> @@ -1014,23 +1056,31 @@ int ice_vc_request_qs_msg(struct ice_vf *vf, u8 *msg)
>  		goto error_param;
>  	}
>  
> -	cur_queues = vf->num_vf_qs;
> -	tx_rx_queue_left = min_t(u16, ice_get_avail_txq_count(pf),
> -				 ice_get_avail_rxq_count(pf));
> -	max_allowed_vf_queues = tx_rx_queue_left + cur_queues;
> +	vsi = ice_get_vf_vsi(vf);
> +	if (!vsi) {
> +		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
> +		goto error_param;
> +	}
> +
> +	/* without LARGE_NUM_QPAIRS, VF can only use the v1 queue opcodes */
> +	if (vf->driver_caps & VIRTCHNL_VF_LARGE_NUM_QPAIRS)
> +		max_lut_queues = ice_lut_type_to_qs_num(vsi->rss_lut_type);
> +	else
> +		max_lut_queues = ICE_MAX_QS_PER_VF_VCV1;
> +	max_allowed_vf_queues = min(ice_vf_max_contig_qs(vf, vsi),
> +				    max_lut_queues);

[Severity: Medium]
Is there a window between this check and the queue allocation?
ice_vf_max_contig_qs() copies pf->avail_txqs/avail_rxqs under
avail_q_mutex and then drops the mutex. The grant then runs:

ice_reset_vf()->ice_vf_reconfig_vsi()->ice_vsi_decfg()/ice_vsi_cfg()->
__ice_vsi_get_qs()

and avail_q_mutex is taken again only around the allocation itself.

PF ethtool -L (ice_vsi_recfg_qs()->ice_vsi_rebuild(), which only takes
ICE_CFG_BUSY and rtnl) and sriov_vf_msix_count on another VF
(ice_sriov_set_msix_vec_count()->ice_vsi_rebuild()) share no lock with the
VF reset path. If one of them takes part of the range during that window,
__ice_vsi_get_qs_contig() fails and __ice_vsi_get_qs() falls back to
scatter mode:

    ret = __ice_vsi_get_qs_contig(qs_cfg);
    if (ret) {
        /* contig failed, so try with scatter approach */
        qs_cfg->mapping_mode = ICE_VSI_MAP_SCATTER;

ice_ena_vf_q_mappings() does not implement scatter mode for VFs. Wouldn't
the VF then come up with unprogrammed queues, which is the failure the v5
changelog says this check prevents?

> +	if (req_queues > max_lut_queues) {
> +		vfres->num_queue_pairs = max_allowed_vf_queues;
> +		goto error_param;
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
> index ca8018e3dd428..778637f2868c2 100644
> --- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c

[ ... ]

> @@ -2901,6 +2922,20 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
>  	case VIRTCHNL_OP_GET_QOS_CAPS:
>  		err = ops->get_qos_caps(vf);
>  		break;
> +	case VIRTCHNL_OP_GET_MAX_RSS_QREGION:
> +		err = ops->get_max_rss_qregion(vf);
> +		break;
> +	case VIRTCHNL_OP_ENABLE_QUEUES_V2:
> +		err = ops->ena_qs_v2_msg(vf, msg, msglen);
> +		if (!err)
> +			ice_vc_notify_vf_link_state(vf);
> +		break;
> +	case VIRTCHNL_OP_DISABLE_QUEUES_V2:
> +		err = ops->dis_qs_v2_msg(vf, msg, msglen);
> +		break;
> +	case VIRTCHNL_OP_MAP_QUEUE_VECTOR:
> +		err = ops->map_q_vector_msg(vf, msg, msglen);
> +		break;

[Severity: Low]
This isn't a bug, but the commit message doesn't say that this patch makes
the LARGE VF opcodes reachable from a VF. This patch adds all of the
following:

- the ops table entries
- these switch cases
- ice_sriov_get_q_vector() as the SR-IOV .get_q_vector callback
- the VIRTCHNL_VF_LARGE_NUM_QPAIRS grant in ice_vc_get_vf_res_msg(), which
  puts the opcodes on the allowlist

ice_vc_ena_qs_v2_msg() and ice_vc_map_q_vector_msg() parse guest-controlled
messages, and nothing called them before this patch. Of this wiring, the
earlier "ice: introduce handling of virtchnl LARGE VF opcodes" only added
the get_q_vector member.

Could the commit message say that this patch exposes those handlers to VF
input, so that reviewers look for it in the right commit?

>  	case VIRTCHNL_OP_CONFIG_QUEUE_BW:
>  		err = ops->cfg_q_bw(vf, msg);
>  		break;

[ ... ]

> @@ -1450,3 +1473,52 @@ void ice_vf_update_mac_lldp_num(struct ice_vf *vf, struct ice_vsi *vsi,
>  	if (was_ena != is_ena)
>  		ice_vsi_cfg_sw_lldp(vsi, false, is_ena);
>  }
> +
> +void ice_init_vf_devlink(struct ice_vf *vf)
> +{
> +	struct devlink *pf_devlink = priv_to_devlink(vf->pf);
> +	static const struct devlink_ops noop = {};
> +	struct devlink *devlink;
> +	int err;
> +
> +	lockdep_assert_held(&vf->pf->vfs.table_lock);
> +
> +	/* no VF pci_dev when the VFs were not scanned, e.g. on s390 */
> +	if (!vf->vfdev)
> +		return;
> +
> +	devlink = devlink_alloc_drv(&noop, 0, &vf->vfdev->dev,
> +				    ice_pf_to_dev(vf->pf)->driver);
> +	if (!devlink)
> +		return;
> +
> +	scoped_guard(devl, pf_devlink)
> +		err = devl_nested_devlink_set(pf_devlink, devlink);
> +	if (err) {
> +		devlink_free(devlink);
> +		return;
> +	}
> +
> +	vf->devlink = devlink;
> +	scoped_guard(devl, devlink) {
> +		ice_devlink_vf_resources_register(vf);
> +		devl_register(devlink);
> +	}
> +}
> +
> +void ice_deinit_vf_devlink(struct ice_vf *vf)
> +{
> +	struct devlink *devlink = vf->devlink;
> +
> +	lockdep_assert_held(&vf->pf->vfs.table_lock);
> +
> +	if (!devlink)
> +		return;
> +
> +	vf->devlink = NULL;
> +	scoped_guard(devl, devlink) {
> +		devl_unregister(devlink);
> +		devl_resources_unregister(devlink);
> +	}
> +	devlink_free(devlink);
> +}

[Severity: Medium]
Does this introduce an AB-BA ordering between pf->vfs.table_lock and
the PF devlink instance lock?

ice_ena_vfs() takes pf->vfs.table_lock and calls ice_start_vfs(). That
now calls ice_init_vf_devlink() for every VF, including in the default
legacy eswitch mode. ice_init_vf_devlink() takes the PF devlink lock
around devl_nested_devlink_set(), so the order there is:

    pf->vfs.table_lock -> priv_to_devlink(pf)->lock

ice_tear_down_devlink_rate_tree() takes the two locks in the opposite
order:

    devl_lock(devlink);
    mutex_lock(&pf->vfs.table_lock);

It is reached from two places:

- ice_setup_tc_mqprio_qdisc(), under rtnl and pf->tc_mutex, when ADQ
  is configured
- ice_pf_dcb_cfg(), when DCB is set up with more than one TC

sriov_numvfs_store() holds only the device lock of the PF pci_dev. It
does not hold rtnl or tc_mutex. So writing sriov_numvfs while an admin
configures mqprio or DCB can deadlock. Even if the two operations run
one after the other, lockdep should report a circular dependency.

Both triggers need admin privileges. Still, enabling VFs and setting up
DCB on the same PF is an ordinary configuration, and this can hang the
machine.

In switchdev mode, ice_eswitch_attach_vf() in ice_start_vfs() seems to
take the PF devlink lock under table_lock already. If so, the new code
only extends an existing order to legacy mode, and the rate tree
teardown would be the side to fix. Which ordering is intended here?

Alternatively, could the nested devlink be created after table_lock is
dropped in ice_ena_vfs()? Or could ice_ena_vfs() take the PF devlink
lock before table_lock?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110141534.95614-1-przemyslaw.kitszel%40intel.com
