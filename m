Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524854;
	b=KJ95ZNqSKYiVrwqalgwvyLNzijqNce1qD9Uepb+XnE7lrhE2/7Kc0jLFj7DKrauv8svv
	 wXdPn9Ihr1h/l/uF5oAxW3EpT/0FOi54/zgTYor65pkwBwmzLJQvhE6r6t5lwLl97BCk5
	 EQRpdNl7oFwvyPZxg6WMc2q8HYj3XjhhwZ7VVkYiJ2xdAsovy8fHLh1r2QuPngUo2ykyL
	 F8YyGyeKTnsVD2EyoMMhJtidWjoPqkYa0E5aLn3m1atwtzKusDpaCFggcuoBvYwFluSE7
	 gwFWxjWVohxvRdVdueipw7hhdpLfnpcfb8NX//niT4xdLMGp5zlJrqUnBg2rH9TV+wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524854;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/R/84az7ImvoTqbuql02WbLDAfa7zqRKeA3jhAGRJNE=;
	b=QruWoXvrGf28MV18Gg3PDJdBOosa9W2ePnQv2L9aiXZtBaRA7y8a6jeyQ6eOYrAQAsVG
	 wAAYe2zuEhNmABjP3QV44+YCvHso5a/d/WupYqdzsVpT2sPHBLZMWMAYtSJ72UukTfSkJ
	 rHh/jH1EJOqibrS7MKU7/CUlwV7q2eHgkO/Fpecb1veQI+H5cfMb9qrzcLWST7q1Kzv//
	 QQzd7Nm4TberNkJbj4JBU9dVYh0gWNK9wWDGJ2w2/u371GCfSJf3IB6HD37bvHIXQz4e6
	 5An27FyyrxApCgmFZEPyrZxIPeHn+bol+JVZI6V5C8e9s1JdLef53qt/uc7o9ISfBEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXbCjhEM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5C606A334
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXbCjhEM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE6D1F000C4;
	Thu, 12 Nov 2026 23:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524854;
	bh=/R/84az7ImvoTqbuql02WbLDAfa7zqRKeA3jhAGRJNE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oXbCjhEMFhnhcCLMnrPkCjmaqMexH0pEsULQSbciidyc6E93rwAT/bZ6Ha5qsh6g8
	 u519NBOhRdVUPqg0AuTxRwfTLETp9Ln/0ahC4Bo7R4thTZaNb3SDl5aQsGjtPE+cLI
	 Sj/po2G3+wIS84vsny1AERN3+QcCTUGIXg2N8WnmBumU99Jn0Uo9cy8wo5DKjcvgVS
	 jwQFGlzt+Y4Y0cVJpG+lI8CAoVPQW/SU+95qctcDbkO1UuffaObj54kRXvLZXm5Vgd
	 lusY/tgBOYmwZMWnRGFC+17zGbr6u1NrqvLVNw795LrtOeKg7uieClUvA0mJQtw8gl
	 q/IYF2zx9Y8Gg==
Subject: Re: [PATCH net-next v5 06/15] ice: bump to 256qs for VF
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
Date: Thu, 12 Nov 2026 23:07:32 +0000
Message-ID: <179452485231.2199510.10387797105475851368@kernel.org>
In-Reply-To: <20261110141534.95614-7-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-7-przemyslaw.kitszel@intel.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new ice_lag_cfg_lan_txq() helper splits the cfg_txqs
  (ICE_AQC_Q_CFG_TC_CHNG) admin command into chunks of at most U8_MAX…
- [Low] The commit body describes the patch only as resizing
  bitmaps/arrays, widening num_req_qs and raising limits.
- [Low] The commit body leaves out several behavioural changes.
- [Low] The commit message says the patch raises 'the limits for the
  default VF queue count ... to 256'.

Pre-existing issues:
- [High] ice_lag_aa_move_vf_qs() in
  drivers/net/ethernet/intel/ice/ice_lag.c can read and write…
- [High] ice_init_lag() can leave a freed notifier_block registered on
  the global netdev notifier chain (use-after-free).

--

ice: bump to 256qs for VF

This commit raises the per-VF queue limit in ice from 16 to 256. It
resizes the VF bitmaps, the qs_bw[] array and the LAG q_home[] table, and
widens num_req_qs. It also adds ice_lag_cfg_lan_txq(), which splits the
LAG cfg_txqs admin command into chunks of up to U8_MAX queues, and it
reworks the rollback in ice_vc_cfg_qs_msg().

> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index 08a17ded0ad55..4bb28564c0d65 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -549,6 +549,41 @@ ice_lag_qbuf_recfg(struct ice_hw *hw, struct ice_aqc_cfg_txqs_buf *qbuf,

[ ... ]

> +static int
> +ice_lag_cfg_lan_txq(struct ice_hw *hw, struct ice_aqc_cfg_txqs_buf *qbuf,
> +		    u16 numq, u8 oldport, u8 newport)
> +{
> +	while (numq) {
> +		int num = min(numq, U8_MAX);
> +		int err;
> +
> +		err = ice_aq_cfg_lan_txq(hw, qbuf,
> +					 struct_size(qbuf, queue_info, num),
> +					 num, oldport, newport,
> +					 ICE_AQC_Q_CFG_TC_CHNG, NULL);
> +		if (err)
> +			return err;

[Severity: Medium]
If a later chunk fails here, firmware has already applied the earlier
chunks. Does anything undo them?

All three callers, ice_lag_move_vf_node_tc(), ice_lag_reclaim_vf_tc() and
ice_lag_move_vf_nodes_tc_sync(), treat any error as a total failure. They
jump to qbuf_err / reclaim_qerr / sync_qerr, which skip
ice_aq_move_sched_elems() and ice_sched_update_parent() for the VSI node,
and then resume traffic.

Take a VF TC with more than 255 queues where the second
ice_aq_cfg_lan_txq() call fails. Wouldn't the first 255 Tx queues end up
on newport while the VSI scheduler node stays on oldport? Before this
patch it was a single AQ command, which firmware either applied or
rejected as a whole.

> +
> +		numq -= num;
> +		memmove(qbuf->queue_info, &qbuf->queue_info[num],
> +			numq * sizeof(*qbuf->queue_info));
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -2651,7 +2683,7 @@ int ice_init_lag(struct ice_pf *pf)
>  	ice_free_hw_res(&pf->hw, ICE_AQC_RES_TYPE_RECIPE, 1,
>  			&lag->pf_recipe);
>  lag_error:
> -	kfree(lag);
> +	kvfree(lag);
>  	pf->lag = NULL;
>  	return err;
>  }

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but this
patch edits these error lines. Can this path free lag while
lag->notif_block is still registered on the netdev notifier chain?

ice_init_lag()
  ice_register_lag_handler(lag)
    register_netdevice_notifier(&lag->notif_block)
  ice_create_lag_recipe() fails
    goto lag_error / free_rcp_res / free_lport_res
  kvfree(lag);
  pf->lag = NULL;

None of these labels call ice_unregister_lag_handler(). ice_init_features()
only warns when ice_init_lag() fails and then carries on. Because pf->lag
is NULL, ice_deinit_lag() returns early and never unregisters the notifier
either.

Wouldn't the next netdev event call through the freed notifier_block?

The notes below the --- line mention an existing error handling issue in
ice_init_lag() that will be fixed separately. If this is that issue, it
still applies after this patch, and ice_lag.c is not changed again in the
rest of the series.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
> index 4bfffecbdc975..39f6a6cc844d8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.h
> @@ -52,7 +52,7 @@ struct ice_lag {
>  	u8 bond_lport_sec; /* lport values for secondary PF */
>  
>  	/* q_home keeps track of which interface the q is currently on */
> -	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_QS_PER_VF_VCV1];
> +	u8 q_home[ICE_MAX_SRIOV_VFS][ICE_MAX_QS_PER_VF];
>  
>  	/* placeholder VSI for hanging VF queues from on secondary interface */
>  	struct ice_vsi *sec_vf[ICE_MAX_SRIOV_VFS];

[Severity: High]
This isn't a bug introduced by this patch, but does anything make sure a
VF has at most ICE_MAX_QS_PER_VF queues before q_home[vf_id][] is indexed?

ice_sriov_set_msix_vec_count() (the sriov_vf_msix_count sysfs path) does:

	queues = msix_vec_count;
	...
	if (queues > min(ice_get_avail_txq_count(pf),
			 ice_get_avail_rxq_count(pf)))
		return -EINVAL;
	...
	vf->num_vf_qs = queues;
	...
	vsi->req_txq = queues;
	vsi->req_rxq = queues;

There is no clamp to ICE_MAX_QS_PER_VF there. So alloc_txq, and with it
num_lan_q_entries[0], can be more than 256 for the VF VSI.

During an active-active failover, ice_lag_aa_move_vf_qs() loops over
num_q = pv_ctx->num_lan_q_entries[0] and does:

		    lag->q_home[vf_id][i] == dest)
	...
		lag->q_home[vf_id][i] = dest;

It never checks i against the row size. Could this write into the next
VF's row? For the last VF, could it run past q_home into the sec_vf[]
pointers, which are later dereferenced via lag->sec_vf[vf_id]->idx?

With the old 16-entry rows, 17 queues were enough to overflow. This patch
raises that threshold but adds no bound, and nothing later in the series
adds one.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index e18128bce959a..f81b310a98c3e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1026,7 +1026,7 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
>  		 * For VSI_LUT, LUT size should be set to 64 bytes.
>  		 */
>  		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
> -		vsi->rss_size = ICE_MAX_QS_PER_VF_VCV1;
> +		vsi->rss_size = ICE_MAX_QS_PER_VF;
>  		vsi->rss_lut_type = ICE_LUT_VSI;
>  		break;

[Severity: Low]
The commit message says:

  Adjust all bitmaps and arrays in ice to accept 256 VF queues.

This hunk is more than a resize, though. It raises the VF VSI rss_size
from 16 to 256 while the VF still uses the 64-entry ICE_LUT_VSI table. At
this commit, wouldn't a VF with more than 16 Rx queues get a default LUT
filled with queue indices >= 16? A later patch in the series clamps
rss_size by LUT type in ice_vsi_cfg_rss_lut_key().

Two other changes are explained only in the changelog below the --- line,
which git am drops: the U8_MAX chunking in ice_lag_cfg_lan_txq(), and the
switch of struct ice_lag to kvzalloc_obj()/kvfree().

Could the commit message mention all three changes?

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index dcd6d48ea38dd..d7c4a65400083 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -398,7 +398,7 @@ static int ice_set_per_vf_res(struct ice_pf *pf, u16 num_vfs)
>  	}
>  
>  	num_txq = min_t(u16, num_msix_per_vf - ICE_NONQ_VECS_VF,
> -			ICE_MAX_QS_PER_VF_VCV1);
> +			ICE_MAX_QS_PER_VF);

[Severity: Low]
The commit message says:

  Raise also the limits for the default VF queue count and for
  VIRTCHNL_OP_REQUEST_QUEUES to 256.

Does this change the default count at all? num_msix_per_vf comes from the
MSI-X tiers, and the largest tier is ICE_NUM_VF_MSIX_MED (17). With
ICE_NONQ_VECS_VF at 1, the first argument to min_t() is never more than
16.

Default VFs would still get at most 16 queues, and the series doesn't
change the tiers later. Could the commit message be adjusted to match?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
> index 2667634e3c8c3..7f2b459dbc836 100644
> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c

[ ... ]

> @@ -967,13 +968,14 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>  				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
>  error_param:
>  	/* disable whatever we can */
> -	for (; i >= 0; i--) {
> -		if (ice_vsi_ctrl_one_rx_ring(vsi, false, i, true))
> +	for (; last_valid >= 0; last_valid--) {
> +		q_idx = qci->qpair[last_valid].rxq.queue_id;
> +		if (ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true))

[Severity: Low]
This isn't a bug, but this hunk quietly fixes a pre-existing rollback bug
that the commit message doesn't mention.

The old loop disabled queues by qpair array index i, not by
qci->qpair[i].rxq.queue_id. It also reused the i left over from the
crc_disable pre-check loop, so a failure there disabled queues 0..i that
the message never touched. This could happen even under the old 16-queue
limit.

The fix is described only in the v3 changelog below the --- line, and
there is no Fixes: tag. Would it work better as a separate patch with a
Fixes: tag, or at least with a note in the commit message?

>  			dev_err(ice_pf_to_dev(pf), "VF-%d could not disable RX queue %d\n",
> -				vf->vf_id, i);
> -		if (ice_vf_vsi_dis_single_txq(vf, vsi, i))
> +				vf->vf_id, q_idx);
> +		if (ice_vf_vsi_dis_single_txq(vf, vsi, q_idx))
>  			dev_err(ice_pf_to_dev(pf), "VF-%d could not disable TX queue %d\n",
> -				vf->vf_id, i);
> +				vf->vf_id, q_idx);
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110141534.95614-1-przemyslaw.kitszel%40intel.com
