Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524858;
	b=5ItA2CQLJpHhOAeyVMSWC5cTWKLhNX13uygk5ND+SrNydiz8eIQeO4iznOu4AZarc4fX
	 Hw0+s7717p/tdTWvVdAOHXfVXi2SjkrkKyQlwtG3bJKykzfa9KR8EQ19r3hfzbF8REt+3
	 68+1Bsa1S3bEBsVbHG9zc1K2Jb5OjoRiyu8dxJbE80+WyikWxZfU2ISS0JLQCcjgq8+Ma
	 rJmp/rQ2bJSEkB5mVGafJ4BD12e/CxKvKrUgVXGR92SYQdOtfNlEJZdsBlvLJ/vBFsCY2
	 2EMnreZ9YjfixG1xTd7wQevjrJg5S+pIZiw2urgWVcBWky5kFyDgApwAy9VaSZyilww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524858;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rUYzyoGiUz2DrASPVAxj8yJz9YDh6Cjgvn7S2l7eUxg=;
	b=R1DiTZbyCXDoIxdzZmr4bH5vu0BvByTOegC17f28BoTQUOz8AhKEkwdVeLInHphAEotA
	 43HBkNZ6oavVD17obXZ1MjdQ7BK/nC72v8/XBkGCDt6Z3DqGDiE5QaaRa3anRzNcFfOQs
	 GlMRx/XGQrmA8PVNT5316QCE/nJwaAJYz+F0ogMRDjXuGoRHm3TdOEurTW2AsOVFRaMV0
	 vbk94gNI6aL4wl7D3Yf5yECs0dGe3Vvx5UQt0Ta6yW4FXAhKZ5Eei5lqqGYtKgV2Y1WzE
	 j4wJlrf8EH8oR3az23qV2qb9RxlaAcu4OoWKx/6xo4rMb0w1w+XZ/50w+gODEaVJqlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ur0rR+0I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E6606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ur0rR+0I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F411F000C7;
	Thu, 12 Nov 2026 23:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524858;
	bh=rUYzyoGiUz2DrASPVAxj8yJz9YDh6Cjgvn7S2l7eUxg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ur0rR+0I+jcURTkxRjMFK08sIUE7986IhjkGURmhHpVXQjNXwl3jhwSi7GaMwmWeW
	 nU8029yZampsXKhoS+S94mMTWf3ZwU3gP0jGOPANWcd+E4kzyvvP4ntvKxc/SeTHCN
	 z2cYkFpXro70peWZB+HpPutUoMERvON/DoDJiLUAqi9kQJZvBlsALtTFKDxNtvEMCG
	 s0A5wK0TZ1nWOr7DG8eb//ntZyXH/BDRV7CRtIGSqO/hUlHPkBWt+0TqbNQWsBQowy
	 m6OT9pnk1/P4kWFq/9JM5WPIPYVnfy/lznbPNp+/X/ukzrL1SFK9X46ru/0g0TLXil
	 /Xb4trCYO3ruA==
Subject:
 Re: [PATCH net-next v5 09/15] iavf: increase max number of queues to 256
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
Date: Thu, 12 Nov 2026 23:07:36 +0000
Message-ID: <179452485639.2199510.8049472487475693211@kernel.org>
In-Reply-To: <20261110141534.95614-10-przemyslaw.kitszel@intel.com>
References: <20261110141534.95614-10-przemyslaw.kitszel@intel.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit (intermediate state of the series),
  iavf_validate_num_queues() in…
- [Medium] The patch turns iavf_q_vector::ring_mask into a fixed
  DECLARE_BITMAP(ring_mask, IAVF_MAX_REQ_QUEUES) (256 bits, 32 bytes).

--

iavf: increase max number of queues to 256

This raises the iavf queue limit to 256, turns q_vector->ring_mask into a
256-bit bitmap and allocates the netdev with 256 Tx/Rx queues. The legacy
virtchnl enable/disable/IRQ map messages stay capped at 16 queues. The
number of queue vectors is limited to 64, and ITR for vectors 16..63 is
programmed through VFINT_ITRN_64.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
> index 053f34c4f710f..60ee3a195567a 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h

[ ... ]

> @@ -108,9 +110,9 @@ struct iavf_q_vector {
>  	struct napi_struct napi;
>  	struct iavf_ring_container rx;
>  	struct iavf_ring_container tx;
> -	u32 ring_mask;
> +	DECLARE_BITMAP(ring_mask, IAVF_MAX_REQ_QUEUES);
>  	u8 itr_countdown;	/* when 0 should adjust adaptive ITR */
> -	u8 num_ringpairs;	/* total number of ring pairs in vector */
> +	u16 num_ringpairs;	/* total number of ring pairs in vector */
>  	u16 v_idx;		/* index in the vsi->q_vector array. */
>  	u16 reg_idx;		/* register index of the interrupt */
>  	char name[IFNAMSIZ + 15];

[ ... ]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 822d6e692d495..db769eead68f3 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

[ ... ]

> @@ -439,8 +448,8 @@ iavf_map_vector_to_rxq(struct iavf_adapter *adapter, int v_idx, int r_idx)
>  	q_vector->rx.count++;
>  	q_vector->rx.next_update = jiffies + 1;
>  	q_vector->rx.target_itr = ITR_TO_REG(rx_ring->itr_setting);
> -	q_vector->ring_mask |= BIT(r_idx);
> -	wr32(hw, IAVF_VFINT_ITRN1(IAVF_RX_ITR, q_vector->reg_idx),
> +	set_bit(r_idx, q_vector->ring_mask);

[Severity: Medium]
ring_mask now has a fixed size of IAVF_MAX_REQ_QUEUES (256) bits. r_idx
here can be as large as adapter->num_active_queues - 1, coming from
iavf_map_rings_to_vectors(). Is num_active_queues guaranteed to stay at
or below 256?

iavf_validate_num_queues() rewrites vsi_res[i].num_queue_pairs only when
vf_res->num_queue_pairs is too large:

    if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
        ...
            vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;

Suppose the PF reports vf_res->num_queue_pairs <= 256 but an SRIOV
vsi_res->num_queue_pairs above 256. The per-VSI value is then kept as is,
and iavf_alloc_queues() uses it:

    num_active_queues = min_t(int,
                              adapter->vsi_res->num_queue_pairs,
                              (int)(num_online_cpus()));

The same applies to num_req_queues from ethtool -L. iavf_set_channels()
bounds that only by vsi_res->num_queue_pairs.

iavf_init_config_adapter() calls iavf_map_rings_to_vectors() before
netif_set_real_num_tx_queues() gets a chance to reject the count. Could
set_bit() then write past the 32-byte ring_mask? That would corrupt the
following q_vector fields (itr_countdown, num_ringpairs, v_idx, reg_idx,
name[]) and, for larger r_idx, memory after the q_vector array.

Before this patch, the same gap only caused an out-of-range shift in
BIT(r_idx), not a write to memory. The in-tree PFs (ice, i40e) report
consistent values, so this needs a buggy or malicious PF. The gap is
still there at the end of the series.

Would it make sense to clamp vsi_res->num_queue_pairs unconditionally, or
to bound num_active_queues by IAVF_MAX_REQ_QUEUES?

>  	     q_vector->rx.current_itr >> 1);
>  	q_vector->rx.current_itr = q_vector->rx.target_itr;
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 69241cb146e0b..1296ea0f1716a 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -260,19 +260,19 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
>   **/
>  static void iavf_validate_num_queues(struct iavf_adapter *adapter)
>  {
> -	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES_VCV1) {
> +	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
>  		struct virtchnl_vsi_resource *vsi_res;
>  		int i;
>  
>  		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
>  			 adapter->vf_res->num_queue_pairs,
> -			 IAVF_MAX_REQ_QUEUES_VCV1);
> +			 IAVF_MAX_REQ_QUEUES);
>  		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
> -			 IAVF_MAX_REQ_QUEUES_VCV1);
> -		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
> +			 IAVF_MAX_REQ_QUEUES);
> +		adapter->vf_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
>  		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
>  			vsi_res = &adapter->vf_res->vsi_res[i];
> -			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES_VCV1;
> +			vsi_res->num_queue_pairs = IAVF_MAX_REQ_QUEUES;
>  		}
>  	}
>  }
> @@ -456,7 +456,8 @@ void iavf_enable_queues(struct iavf_adapter *adapter)
>  	}
>  	adapter->current_op = VIRTCHNL_OP_ENABLE_QUEUES;
>  	vqs.vsi_id = adapter->vsi_res->vsi_id;
> -	vqs.tx_queues = BIT(adapter->num_active_queues) - 1;
> +	vqs.tx_queues = BIT(min(adapter->num_active_queues,
> +				IAVF_MAX_REQ_QUEUES_VCV1)) - 1;
>  	vqs.rx_queues = vqs.tx_queues;
>  	adapter->aq_required &= ~IAVF_FLAG_AQ_ENABLE_QUEUES;
>  	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_QUEUES,

[ ... ]

> @@ -526,8 +528,9 @@ void iavf_map_queues(struct iavf_adapter *adapter)
>  
>  		vecmap->vsi_id = adapter->vsi_res->vsi_id;
>  		vecmap->vector_id = v_idx + NONQ_VECS;
> -		vecmap->txq_map = q_vector->ring_mask;
> -		vecmap->rxq_map = q_vector->ring_mask;
> +		vecmap->txq_map = bitmap_read(q_vector->ring_mask, 0,
> +					      IAVF_MAX_REQ_QUEUES_VCV1);
> +		vecmap->rxq_map = vecmap->txq_map;

[Severity: Medium]
After this change, iavf_validate_num_queues() accepts up to 256 queue
pairs without checking any capability. iavf_alloc_queues() can then set
num_active_queues above 16. iavf_configure_queues() configures all of
them, and the stack is told about all of them through
netif_set_real_num_{rx,tx}_queues().

At this point in the series, though, the only enable/disable and IRQ map
messages are the legacy ones, and they are capped at 16 queues.

iavf_enable_queues() and iavf_disable_queues():

    vqs.tx_queues = BIT(min(adapter->num_active_queues,
                            IAVF_MAX_REQ_QUEUES_VCV1)) - 1;

iavf_map_queues():

    vecmap->txq_map = bitmap_read(q_vector->ring_mask, 0,
                                  IAVF_MAX_REQ_QUEUES_VCV1);

Are queues 16 and above then never enabled in HW, and left with no
interrupt cause mapping? That would seem to cause Tx timeouts on those
queues and lose Rx traffic that RSS steers to them.

This looks reachable with the intermediate ice change "ice: bump to 256qs
for VF" when the admin raises sriov_vf_msix_count for a VF.

The later commit "iavf: use new opcodes to request more than 16 queues"
seems to resolve this. It clamps to IAVF_MAX_VSI_QP unless
LARGE_NUM_QPAIRS_SUPPORT() is set, and moves enable/disable/map to the V2
opcodes. Could the 16 queue clamp in iavf_validate_num_queues() stay
until that patch, so there is no broken window for bisection?

Also, the commit message says:

  "Use old legacy limit in the virtchnl handling of iavf_map_queues()."

The ENABLE/DISABLE cap is only mentioned in the changelog below the ---
line. The message also doesn't say that queues above 16 stay unusable
until later patches. Could the commit message mention both?

>  		vecmap->rxitr_idx = IAVF_RX_ITR;
>  		vecmap->txitr_idx = IAVF_TX_ITR;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110141534.95614-1-przemyslaw.kitszel%40intel.com
