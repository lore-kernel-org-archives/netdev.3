Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1693DA7D2
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020644; cv=none; b=BXtqYe/2JghWZ04UyTYHKLCFr4ne6kodhWonJnolIdn2m4Z2PYcicXwPJyEeCFvVFxGNw1L4dLvWma5RdYhMNP5svxPOKhP/+Yg/xhKki+H2pFMEiYAmadx0PblCsNnBxIiBzLQQCtAafJmB1pxeV7n93i4dJsPnfe/08WClz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020644; c=relaxed/simple;
	bh=v7QTPMhpNSeLc2zTahfYngM1LxuOh7s74TbiL7e0gSk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jJkGPKjd+v8udMWzCHmYDePrJCVHmBtQihNoWMp+5DUGlXA4FvhDRVS9J8Z/WQ1u/bdelHdSwruaKyfEQ129iIPOwOs/D5RrqtCzD40dIAfFdynf395KF1E7WFTlZKUGMy5HFHStDam7L8hJ44Li+eqe3k2MJnJBgKUl6XlsGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbmuSH2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbmuSH2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEA91F00899;
	Mon, 21 Sep 2026 19:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020641;
	bh=9SJkDu3TRukoE3OJXHFtFTKjmpJx0e3tR5eaqgnGbGI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cbmuSH2z1dtcbgzVH0VV0LrfoC8h7RCC1FpCBUmZmpGYjqkHLvUcmU+h1aNRNSPG5
	 XnMidTSFSSrI2NV3H68O0nkNzoKRYHCqqu3w/cprt30XU8/m3M7UG2qns2lgmsDTn6
	 1PCiwk5d7Rzlimo/C8/1i3dq3LT0d9sx/eq9bOMMVuJPiKUsvoGylV3cDBAvz6CB4G
	 sStSrhrKHUkB+rWwjWSfwBvcQvZaQRn+99Y1H1Kvl4bktHZk9bVH+AC1Om6ppFYlhg
	 D4MemlxTqXIZ7hW9aD98PScKYYWiy3C9GeWZUMplrFaTQySqHb8Auc57ZfzWlesUCS
	 q+KgCCXgGm+rg==
Subject: Re: [PATCH net-next v2 05/12] ice: create flow profile
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, marcin.szycik@linux.intel.com,
 aleksandr.loktionov@intel.com, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 19:57:20 +0000
Message-ID: <179002064045.2160803.2172434223465233925@kernel.org>
In-Reply-To: <20260917183927.2692068-6-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-6-anthony.l.nguyen@intel.com>
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
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new ethtool ACL path publishes and consumes the shared ACL
  state hw->acl_prof[] and hw->acl_tbl with no lock, while the teardown…
- [High] (Validated as NOT a defect in the final series state.) Concern:
  the ACL profile bookkeeping (hw->acl_prof[fltr_type]->seg/->prof_id)…
- [Medium] ice_flow_acl_def_entry_frmt()
  (drivers/net/ethernet/intel/ice/ice_flow.c:1407) copies the 64-bit…
- [Medium] (Validated as NOT a defect in the final series state.)
  Concern: at this commit ice_add_ntuple_ethtool() diverts partial-mask…
- [Low] The comment added immediately above the ice_flow_add_prof() call
  in ice_acl_prof_add_ethtool()…
- [Low] The kernel-doc added for ice_flow_xtract_pkt_flags()
  (drivers/net/ethernet/intel/ice/ice_flow.c:993-1003) misdescribes both…

--

ice: create flow profile

This adds an ACL path to the ethtool ntuple code: partial-mask rules are
diverted to a new ice_acl_main.c which builds an ice_flow_seg_info from the
ethtool mask and creates an ICE_BLK_ACL flow profile.  Supporting bits are
added to ice_flow.c (packet-flags extraction, ACL entry format, scenario
selection) and hw->acl_prof is allocated in ice_init_acl().

A few questions below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> new file mode 100644
> index 0000000000000..db8137e6f8706
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018-2026, Intel Corporation. */
> +
> +#include "ice.h"
> +#include "ice_lib.h"
> +#include "ice_acl_main.h"

[ ... ]

> +static int ice_acl_prof_add_ethtool(struct ice_pf *pf,
> +				    struct ethtool_rx_flow_spec *fsp)
> +{
> +	struct ice_flow_prof *prof = NULL;
> +	struct ice_acl_hw_prof *hw_prof;
> +	struct ice_flow_seg_info *seg;
> +	enum ice_fltr_ptype fltr_type;
> +	struct ice_hw *hw = &pf->hw;
> +	int err;
> +
> +	seg = kzalloc_obj(*seg);
> +	if (!seg)
> +		return -ENOMEM;

[ ... ]

> +	fltr_type = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
> +
> +	hw_prof = hw->acl_prof[fltr_type];
> +	if (!hw_prof) {
> +		hw_prof = kzalloc_obj(**hw->acl_prof);
> +		if (!hw_prof) {
> +			err = -ENOMEM;
> +			goto free_seg;
> +		}
> +	}
> +
> +	if (hw_prof->seg) {
> +		/* This flow_type already has an input set.
> +		 * If it matches the requested input set then we are
> +		 * done. If it's different then it's an error.
> +		 */
> +		if (!memcmp(hw_prof->seg, seg, sizeof(*seg))) {
> +			kfree(seg);
> +			return 0;
> +		}

[Severity: High]
Does this short-circuit survive a PF reset?  The bookkeeping in
hw->acl_prof[fltr_type] (seg and prof_id) is not invalidated on reset, but
ice_prepare_for_reset() drops the hardware state for this block:

ice_prepare_for_reset()
    ice_clear_hw_tbls(hw);      /* clears ICE_BLK_ACL profile map, ES and
                                   profile TCAM shadow tables */

After that, a second identical request would match here and return 0 while
no ACL profile exists in hardware, and a later ice_acl_rem_flows() would
call ice_flow_rem_prof() with a stale profile ID.

For the record, this appears to be addressed later in the same series by
"ice: add ACL reset recovery and NTUPLE feature toggle", which makes
ice_rebuild() do:

	ice_acl_destroy_tbl(hw);
	if (!ice_acl_create_hw(pf)) {
		ice_acl_replay_flows(hw);
		ice_acl_replay_fltrs(pf);
	}

so the concern is limited to the intermediate state of the series.

> +
> +		err = -EINVAL;
> +		goto free_seg;
> +	}
> +
> +	/* Adding a profile for the given flow specification with no
> +	 * actions (NULL) and zero actions 0.
> +	 */

[Severity: Low]
This isn't a bug, but does this comment still match the callee?
ice_flow_add_prof() takes no action arguments:

int ice_flow_add_prof(struct ice_hw *hw, enum ice_block blk,
		      enum ice_flow_dir dir, struct ice_flow_seg_info *segs,
		      u8 segs_cnt, bool symm, struct ice_flow_prof **prof);

The call below passes segs_cnt = 1 and symm = false, so the trailing false
is the symmetric-hash flag rather than an action count.  The text looks
carried over from the older ice_fdir_set_hw_fltr_rule() comment.

> +	err = ice_flow_add_prof(hw, ICE_BLK_ACL, ICE_FLOW_RX, seg, 1, false,
> +				&prof);
> +	if (err)
> +		goto free_acl_prof;
> +
> +	hw_prof->seg = seg;
> +	hw_prof->prof_id = prof->id;
> +	hw->acl_prof[fltr_type] = hw_prof;
> +	return 0;

[Severity: High]
What serializes this read-check-allocate-publish of hw->acl_prof[] against
ACL teardown?  ice_add_ntuple_ethtool() returns into
ice_acl_add_rule_ethtool() before mutex_lock(&hw->fdir_fltr_lock) is ever
taken, and ice_deinit_acl() frees the same state without any lock:

ice_remove()
    devl_lock()
    ice_unload()
        ice_deinit_features()
            ice_deinit_acl()
                ice_acl_rem_flows(hw);     /* kfree(prof->seg) */
                ice_acl_destroy_tbl(hw);   /* kfree(hw->acl_tbl) */
                kfree(hw_prof->seg); kfree(hw_prof);
                devm_kfree(dev, hw->acl_prof);
        ice_unregister_netdev(vsi);         /* only afterwards */

The ethtool path holds rtnl, ice_unload() holds devl_lock, so there is no
common lock and the netdev is still registered while the free happens.  Can
an ethtool -N with a partial mask racing device removal or a devlink reload
store hw_prof into the already freed hw->acl_prof array, or walk a freed
hw->acl_tbl->scens list in ice_flow_sel_acl_scen()?

The equivalent FDIR state is protected by hw->fdir_fltr_lock (taken by
ice_vsi_manage_fdir() and ice_vsi_manage_acl()); should the ACL profile
path and ice_deinit_acl() take that mutex too?

> +
> +free_acl_prof:
> +	kfree(hw_prof);
> +free_seg:
> +	kfree(seg);
> +
> +	return err;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index 272b3d54f6e47..afeda21109409 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c

[ ... ]

> @@ -1846,7 +1933,7 @@ int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
>  	struct ice_hw *hw = &pf->hw;
>  	int val;
>  
> -	if (!test_bit(ICE_FLAG_FD_ENA, pf->flags))
> +	if (!test_bit(ICE_FLAG_FD_ENA, pf->flags) && !pf->hw.acl_tbl)
>  		return -EOPNOTSUPP;

[ ... ]

> @@ -2102,6 +2239,18 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
>  		return -ENOSPC;
>  	}
>  
> +	/* ACL filter */
> +	if (pf->hw.acl_tbl && ice_is_acl_filter(fsp))
> +		return ice_acl_add_rule_ethtool(vsi, cmd);

[Severity: Medium]
At this commit, does this report success for a rule that does not filter
anything?  ice_acl_add_rule_ethtool() only reaches
ice_acl_prof_add_ethtool(), which creates the flow profile and returns 0
with no flow entry, no action, no VSI association and no insertion into
hw->fdir_list_head.

So ETHTOOL_SRXCLSRLINS would succeed while the rule is invisible to
ETHTOOL_GRXCLSRULE and ETHTOOL_GRXCLSRLALL and cannot be deleted, even
though the delete gate in ice_del_ntuple_ethtool() is relaxed for acl_tbl
devices in the same patch.

This is completed later in the series ("ice: program ACL entry"), where
ice_acl_add_rule_ethtool() builds the ice_ntuple_fltr, sets the action,
programs the TCAM entry with ice_flow_add_entry() and links the filter into
hw->fdir_list_head under hw->fdir_fltr_lock, so the gap is confined to the
intermediate patches.  Would it be worth folding the dispatch into the
patch that actually programs the entry?

> +
> +	/* Only fdir filters below */
> +	if (!test_bit(ICE_FLAG_FD_ENA, pf->flags))
> +		return -EOPNOTSUPP;
> +
> +	ret = ice_cfg_fdir_xtrct_seq(pf, fsp, &userdata);
> +	if (ret)
> +		return ret;
> +

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> index 121552c644cdb..855d296aeed81 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> @@ -989,6 +990,43 @@ static int ice_flow_proc_seg_hdrs(struct ice_flow_prof_params *params)
>  	return 0;
>  }
>  
> +/**
> + * ice_flow_xtract_pkt_flags - Create an extr sequence entry for packet flags
> + * @hw: pointer to the HW struct
> + * @params: information about the flow to be processed
> + * @flags: The value of pkt_flags[x:x] in Rx/Tx MDID metadata.
> + *
> + * Allocate an extraction sequence entries for a DWORD size chunk of the packet
> + * flags.

[Severity: Low]
This isn't a bug, but does the kernel-doc match the code?  The parameter type
is enum ice_flex_mdid_pkt_flags, whose members select successive 16-bit
packet-flag ranges rather than carrying a value:

enum ice_flex_mdid_pkt_flags {
	ICE_RX_MDID_PKT_FLAGS_15_0	= 20,
	ICE_RX_MDID_PKT_FLAGS_31_16,
	ICE_RX_MDID_PKT_FLAGS_47_32,
	ICE_RX_MDID_PKT_FLAGS_63_48,
};

And the body fills exactly one field-vector word, not a DWORD chunk:

	params->es[idx].prot_id = ICE_PROT_META_ID;
	params->es[idx].off = flags;
	params->es_cnt++;

> + *
> + * Return: 0 on success, negative on error
> + */
> +static int ice_flow_xtract_pkt_flags(struct ice_hw *hw,
> +				     struct ice_flow_prof_params *params,
> +				     enum ice_flex_mdid_pkt_flags flags)
> +{

[ ... ]

> @@ -1308,6 +1356,123 @@ ice_flow_create_xtrct_seq(struct ice_hw *hw,
>  	return status;
>  }
>  

[ ... ]

> +static int
> +ice_flow_acl_def_entry_frmt(struct ice_flow_prof_params *params)
> +{
> +	u16 index, range_idx = 0;
> +
> +	index = ICE_AQC_ACL_PROF_BYTE_SEL_START_IDX;
> +
> +	for (int i = 0; i < params->prof->segs_cnt; i++) {
> +		struct ice_flow_seg_info *seg = &params->prof->segs[i];
> +		unsigned long match = seg->match;
> +		int j;
> +
> +		for_each_set_bit(j, &match, ICE_FLOW_FIELD_IDX_MAX) {

[Severity: Medium]
Can this read past the match local on 32-bit builds?  seg->match is declared
u64 in struct ice_flow_seg_info, and ICE_FLOW_FIELD_IDX_MAX is 58, so with
BITS_PER_LONG == 32 the copy into unsigned long drops match bits 32 through
57, and find_next_bit() is told the bitmap is 58 bits wide while only 4
bytes of storage exist, so it dereferences (&match)[1].

The sibling loop in ice_flow_create_xtrct_seq() keeps the u64 and casts the
address instead:

		u64 match = params->prof->segs[i].match;
		...
		for_each_set_bit(j, (unsigned long *)&match,
				 ICE_FLOW_FIELD_IDX_MAX) {

Besides the out-of-bounds read, would stale stack bits picked up above bit 31
be treated as real match fields here, inflating index and range_idx and so
producing a spurious -EINVAL or a wrong params->entry_length that
ice_flow_sel_acl_scen() then uses for scenario selection?  ICE has no 64BIT
dependency in drivers/net/ethernet/intel/Kconfig, so i386 builds reach this.

> +			struct ice_flow_fld_info *fld = &seg->fields[j];
> +
> +			fld->entry.mask = ICE_FLOW_FLD_OFF_INVAL;
> +

[ ... ]

> +	/* Store # bytes required for entry for later use */
> +	params->entry_length = index - ICE_AQC_ACL_PROF_BYTE_SEL_START_IDX;
> +
> +	return 0;
> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 952e6167517f4..df58bd72301ec 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4394,10 +4413,27 @@ static int ice_init_acl(struct ice_pf *pf)
>   */
>  static void ice_deinit_acl(struct ice_pf *pf)
>  {
> +	struct device *dev = ice_pf_to_dev(pf);
>  	struct ice_hw *hw = &pf->hw;
>  
>  	ice_acl_rem_flows(hw);
> -	ice_acl_destroy_tbl(&pf->hw);
> +	ice_acl_destroy_tbl(hw);
> +
> +	if (!hw->acl_prof)
> +		return;
> +
> +	for (int i = 0; i < ICE_FLTR_PTYPE_MAX; i++) {
> +		struct ice_acl_hw_prof *hw_prof = hw->acl_prof[i];
> +
> +		if (!hw_prof)
> +			continue;
> +
> +		kfree(hw_prof->seg);
> +		kfree(hw_prof);
> +	}
> +
> +	devm_kfree(dev, hw->acl_prof);
> +	hw->acl_prof = NULL;
>  }

This is the teardown referenced in the locking question on
ice_acl_prof_add_ethtool() above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917183927.2692068-1-anthony.l.nguyen%40intel.com
