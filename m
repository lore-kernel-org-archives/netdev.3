Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898733DEFE7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020649; cv=none; b=oPeKrXR+fWEu0zJGSiN7wFa8Jgk0bxnkglDAe4IvKEECOpSwHxDzatbt+XJZo5gAoGiOCvASPUsAC5cyJLCydQoowKl+VF72T5eqEPQkkGxqm4alE40PII/iBaFiw40KodStxoWdfb6Za7CyhhR1WjED7rQeWsvE51CfmE16d64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020649; c=relaxed/simple;
	bh=G0NpM7AmUtqsH7CMyFrmpIhMtURD3B3b1WIo3eLu18k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m87+AR4DNEPec74RaD/4cUqBZyKHYUtrB8374ybQjuhzIrPeWzGVZgMT03VDvwoE4z2HKkldrQyTSFlAPxHkfOP7aGXh3V3GIjmtUcTzdNN8xNYcwFrfc24rQ6zwFxOwficRbb8yjaejIokjDjOowSCewm+FFnuGjsferu3xbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gopmXBJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gopmXBJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6CB1F00893;
	Mon, 21 Sep 2026 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020647;
	bh=gQm1fBKZEE9wNTU/WdgPWhM90UoPadSOjqZl7TNd3Us=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gopmXBJHQhOoa/ZnZ5SZYBOFxZ8j6CAOMQ23yPT46znU4Qdlj65ogzcItBWBCbQqw
	 cTuzTcOlNqUzo/lzCIzs94lJObb9DWqE3eTR6tp2MPLNI2r3wgEjN777p4dor9SUTm
	 7TuCB8/CjIhZ9xEnLE1VatovJbGAq6u/GBKY9j0/5MBAthEcMDyWykVAvITPy1vLxf
	 fTa/AkVEOyrMRoqIe5OScEOyto95Xlvnje2UTN7m4oEUYFfDRthL1hsAXH635Rdw03
	 5CN4FVrYEpJTGKNMPtqXiZ7UvXKHDd1Ybtb2f42kFBsacZCatFspTiaaVF5jJfyxql
	 6AZtwE5VSIVBg==
Subject: Re: [PATCH net-next v2 10/12] ice: add ACL reset recovery and NTUPLE
 feature toggle
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, marcin.szycik@linux.intel.com,
 aleksandr.loktionov@intel.com, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 19:57:26 +0000
Message-ID: <179002064606.2160803.13242183804176202091@kernel.org>
In-Reply-To: <20260917183927.2692068-11-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-11-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 13 potential
issue(s) to consider.

Critical: 0 · High: 6 · Medium: 5 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ICE_FLAG_ACL_ENA does not gate ACL rule programming, so the
  commit's stated purpose ('Use the new flag to track the NTUPLE ethtool…
- [High] ice_rebuild() creates the ACL HW table whenever ICE_FLAG_ACL_ENA
  is set, but ice_set_pf_caps() (ice_main.c:3952) now sets that flag…
- [High] In the new per-profile reset loop in ice_acl_create_hw(), the
  return value of ice_prog_acl_prof_ranges() is discarded and the…
- [High] ice_acl_create_hw() unconditionally reprograms the extraction
  sequence and range checkers of all 128 ACL HW profiles with zeroed…
- [High] ice_acl_prof_add_ethtool() reuses the ice_acl_hw_prof already
  published in hw->acl_prof[fltr_type], but its `free_acl_prof:…
- [High] The new reset-replay code walks and mutates state that every
  other accessor protects with hw->fdir_fltr_lock, without taking it.
- [Medium] Per-profile and per-filter replay failures leave ACL rules
  present in software but absent from hardware after a reset.
- [Medium] A PF reset taken while NTUPLE is disabled leaves no usable ACL
  hardware table after the feature is re-enabled.
- [Medium] ice_acl_replay_flows() only updates prof->prof_id for flow
  types whose ice_flow_add_prof() succeeded; on a per-flow failure it…
- [Medium] ice_acl_destroy_tbl()'s new kernel-doc promises that SW state
  is always cleaned up even when the AQ calls fail ('e.g. after a reset,…
- [Medium] ice_rebuild()'s new ACL failure branch does
  mutex_lock(&hw->fdir_fltr_lock), but that mutex is initialized only…
- [Low] ice_acl_replay_flows() applies the ethtool uAPI modifier bit
  FLOW_EXT to a loop variable of type enum ice_fltr_ptype (`flow &=…
- [Low] The new ice_acl_replay_fltrs() documentation block is written in
  kernel-doc form (summary line `ice_acl_replay_fltrs - replay ACL…

--

ice: add ACL reset recovery and NTUPLE feature toggle

This adds ice_acl_replay_flows() and ice_acl_replay_fltrs() to rebuild ACL
HW profiles and TCAM entries after a PF reset, wires them into
ice_rebuild(), resets per-profile HW extraction sequences and range
checkers in ice_acl_create_hw(), and introduces the ICE_FLAG_ACL_ENA PF
flag tied to the ethtool NTUPLE feature.

A few questions about the new code below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> index 0ee86236bc37a..4ea08bd9784c0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> @@ -877,9 +877,10 @@ static int ice_acl_destroy_scen(struct ice_hw *hw, u16 scen_id)
>   * ice_acl_destroy_tbl - Destroy a previously created LEM table for ACL
>   * @hw: pointer to the HW struct
>   *
> - * Return: 0 on success, negative on error
> + * Continue on AQ errors so SW state is always cleaned up - e.g. after a reset,
> + * where the HW tables might be already gone.
>   */
> -int ice_acl_destroy_tbl(struct ice_hw *hw)
> +void ice_acl_destroy_tbl(struct ice_hw *hw)

[ ... ]

>  		err = ice_acl_destroy_scen(hw, pos_scen->id);
>  		if (err) {
> -			ice_debug(hw, ICE_DBG_ACL, "deletion of scenario failed. status: %d\n",
> +			ice_debug(hw, ICE_DBG_ACL, "deletion of scenario failed, status: %d\n",
>  				  err);
> -			return err;
>  		}
>  	}
>  
>  	err = ice_aq_dealloc_acl_tbl(hw, hw->acl_tbl->id, &resp_buf, NULL);
>  	if (err) {
> -		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of ACL failed. status: %d\n",
> +		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of ACL failed, status: %d\n",
>  			  err);
> -		return err;
>  	}
>  
>  	kfree(hw->acl_tbl);
>  	hw->acl_tbl = NULL;
> -
> -	return 0;
>  }

[Severity: Medium]
The new comment says SW state is always cleaned up, but does
ice_acl_destroy_scen() still return early before removing the scenario from
the list?

ice_acl_destroy_scen() {
	...
	err = ice_aq_dealloc_acl_scen(hw, scen_id, NULL);
	if (err) {
		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of scenario failed. status: %d\n",
			  err);
		return err;
	}

	/* Remove scenario from hw->acl_tbl->scens */
	list_for_each_entry_safe(scen, tmp_scen, &hw->acl_tbl->scens, ...
			list_del(&scen->list_entry);
			devm_kfree(ice_hw_to_dev(hw), scen);
	...
}

The scenario stays on hw->acl_tbl->scens, and ice_acl_destroy_tbl() then does
kfree(hw->acl_tbl), which owns that list head.

Does this leak the struct ice_acl_scen (including its
DECLARE_BITMAP(entry_bitmap, ICE_MAX_ACL_TCAM_ENTRY)) once per failing
teardown?  Since ice_rebuild() calls ice_acl_destroy_tbl() exactly when the
firmware allocation is expected to be gone, this looks like the normal case
on reset rather than a rare one.

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> index 171b7bf8519c6..d13e8bc1b7019 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> @@ -236,6 +236,53 @@ static void ice_acl_set_act_fwd_queue(struct ice_flow_action *action,
>  	action->data.acl_act.value = cpu_to_le16(queue_index);
>  }
>  
> +/*
> + * ice_acl_replay_fltrs - replay ACL filters from the SW filter list
> + * @pf: board private structure

[Severity: Low]
This isn't a bug, but the block is kernel-doc formatted (summary line plus
@pf) while opened with /* instead of /**, so scripts/kernel-doc skips it.
Other documented functions in ice_acl_main.c use /**.

> + *
> + * Reprograms ACL TCAM entries after a reset using data preserved in the
> + * SW filter list. Relies on ice_acl_replay_flows() having been called first
> + * to restore the flow profiles.
> + */
> +void ice_acl_replay_fltrs(struct ice_pf *pf)
> +{
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> +	struct ice_hw *hw = &pf->hw;
> +	struct ice_ntuple_fltr *f_rule;
> +
> +	if (!vsi)
> +		return;
> +
> +	list_for_each_entry(f_rule, &hw->fdir_list_head, fltr_node) {

[Severity: High]
Should this traversal hold hw->fdir_fltr_lock?

Every other accessor of hw->fdir_list_head takes that mutex, and the patch
itself documents ice_acl_del_all_fltrs() as "needs to be called while holding
hw->fdir_fltr_lock".  ice_del_ntuple_ethtool() does list_del() + kfree() on
these nodes under the mutex.

The same question applies to ice_acl_replay_flows(), which reads prof->seg
and writes prof->prof_id unlocked while ice_vsi_manage_acl(vsi, false) ->
ice_acl_rem_flows() kfree()s prof->seg under the mutex.

ice_rebuild() runs from the service task / ice_do_reset() without rtnl_lock,
and the ice_is_reset_in_progress() test at the top of the ethtool handlers is
taken before any lock, so a task that passed it can still be inside
ice_del_ntuple_ethtool() or ice_acl_prof_add_ethtool() while the replay walks
the same objects.  Can that traverse a freed list node or call
ice_flow_add_prof() on a freed prof->seg?

Note the failure branch added to ice_rebuild() a few lines below does take
the mutex for the same data, which makes the success path look inconsistent.

> +		struct ice_flow_action acts[ICE_ACL_NUM_ACT];
> +		struct ice_acl_hw_prof *hw_prof;
> +		u64 entry_h = 0;
> +		int err;
> +
> +		if (!f_rule->acl_fltr)
> +			continue;
> +
> +		if (!hw->acl_prof || !hw->acl_prof[f_rule->flow_type])
> +			continue;
> +
> +		hw_prof = hw->acl_prof[f_rule->flow_type];
> +
> +		memset(&acts, 0, sizeof(acts));
> +		if (f_rule->dest_ctl == ICE_FLTR_PRGM_DESC_DEST_DROP_PKT)
> +			ice_acl_set_act_drop(&acts[0]);
> +		else
> +			ice_acl_set_act_fwd_queue(&acts[0], f_rule->q_index);
> +
> +		err = ice_flow_add_entry(hw, ICE_BLK_ACL, hw_prof->prof_id,
> +					 f_rule->fltr_id, vsi->idx,
> +					 ICE_FLOW_PRIO_NORMAL, f_rule, acts,
> +					 ICE_ACL_NUM_ACT, &entry_h);

[Severity: Medium]
Can hw_prof->prof_id be stale here?

ice_acl_replay_flows() only assigns prof->prof_id when ice_flow_add_prof()
succeeds; on failure it logs and continues, so the ice_acl_hw_prof keeps the
pre-reset ID.  Profile IDs come from a recyclable bitmap:

ice_flow_add_prof_sync() {
	ids = &hw->blk[blk].prof_id;
	prof_id = find_first_zero_bit(ids->id, ids->count);
	...
}

and that bitmap is cleared during reset prep by ice_clear_hw_tbls().  So a
later flow in the same replay loop can be handed exactly the numeric ID a
failed flow still stores, and ice_flow_find_prof_id() will resolve it to a
valid but different profile.

Would that program the filter's match data into another flow type's
extraction sequence without any error being reported?

> +		if (err)
> +			dev_warn(ice_pf_to_dev(pf), "Could not reprogram filter %d, status %d\n",
> +				 f_rule->fltr_id, err);
> +	}
> +}

[Severity: Medium]
The commit message says "On failure, don't fail reset, rather delete all ACL
filters from the SW list."  Does that happen for replay failures?

Both ice_acl_replay_flows() and ice_acl_replay_fltrs() return void and only
log, so ice_rebuild() only calls ice_acl_del_all_fltrs() when
ice_acl_create_hw() itself fails.  After a per-filter ice_flow_add_entry()
error (-ENOSPC on TCAM/scenario exhaustion, -ENOMEM, an AQ error), the reset
completes, the netdev is reattached, and the filter list plus
hw->acl_fltr_cnt[] still report the rule as installed while hardware has no
entry.

Such a rule also looks undeletable afterwards: ice_ntuple_update_list_entry()
calls ice_del_acl_ethtool(), ice_flow_find_entry() returns
ICE_FLOW_ENTRY_HANDLE_INVAL, ice_flow_rem_entry() returns -EINVAL, and the
error is propagated before the SW rule is unlinked.  Can the user still
remove the rule without reloading the driver?

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index 0ac44d38fdbdf..fef8640d23fb6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> @@ -527,6 +527,37 @@ void ice_fdir_replay_flows(struct ice_hw *hw)
>  	}
>  }
>  
> +/**
> + * ice_acl_replay_flows - replay HW ACL flow profiles
> + * @hw: pointer to HW instance
> + */
> +void ice_acl_replay_flows(struct ice_hw *hw)
> +{
> +	if (!hw->acl_prof)
> +		return;
> +
> +	for (enum ice_fltr_ptype flow = ICE_FLTR_PTYPE_NONF_NONE;
> +	     flow < ICE_FLTR_PTYPE_MAX; flow++) {
> +		struct ice_flow_prof *hw_prof;
> +		struct ice_acl_hw_prof *prof;
> +		int err;
> +
> +		flow &= ~FLOW_EXT;

[Severity: Low]
This isn't a bug, but FLOW_EXT is an ethtool uAPI modifier bit and flow here
is an already-converted enum ice_fltr_ptype.  Since the loop only takes
values below ICE_FLTR_PTYPE_MAX, masking with ~FLOW_EXT (0x7fffffff) clears
nothing, and it writes to the loop counter.

Peer sites strip FLOW_EXT before conversion, e.g. in
ice_acl_prof_add_ethtool():

	fltr_type = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);

and the structurally equivalent ice_fdir_replay_flows() has no such mask.
Can this statement be dropped?  The same line was added earlier in the series
in ice_acl_rem_flows().

> +		prof = hw->acl_prof[flow];
> +		if (!prof || !prof->seg)
> +			continue;
> +
> +		err = ice_flow_add_prof(hw, ICE_BLK_ACL, ICE_FLOW_RX,
> +					prof->seg, 1, false, &hw_prof);
> +		if (err) {
> +			dev_err(ice_hw_to_dev(hw), "Could not replay ACL, flow type %d\n",
> +				flow);
> +			continue;
> +		}
> +		prof->prof_id = hw_prof->id;
> +	}
> +}

[ ... ]

> @@ -1825,6 +1856,28 @@ static int ice_del_acl_ethtool(struct ice_hw *hw, struct ice_ntuple_fltr *fltr)
>  	return ice_flow_rem_entry(hw, ICE_BLK_ACL, entry);
>  }
>  
> +/**
> + * ice_acl_del_all_fltrs - Delete all ACL filters from the filter list
> + * @vsi: the VSI being changed
> + *
> + * This function needs to be called while holding hw->fdir_fltr_lock
> + */
> +void ice_acl_del_all_fltrs(struct ice_vsi *vsi)

[ ... ]

> +/**
> + * ice_vsi_manage_acl - turn on/off ACL
> + * @vsi: the VSI being changed
> + * @ena: boolean value indicating if this is an enable or disable request
> + */
> +void ice_vsi_manage_acl(struct ice_vsi *vsi, bool ena)
> +{
> +	struct ice_pf *pf = vsi->back;
> +	struct ice_hw *hw = &pf->hw;
> +
> +	if (ena) {
> +		set_bit(ICE_FLAG_ACL_ENA, pf->flags);
> +		return;
> +	}
> +
> +	mutex_lock(&hw->fdir_fltr_lock);
> +	if (!test_and_clear_bit(ICE_FLAG_ACL_ENA, pf->flags))
> +		goto release_lock;
> +
> +	ice_acl_del_all_fltrs(vsi);
> +	ice_acl_rem_flows(hw);
> +
> +release_lock:
> +	mutex_unlock(&hw->fdir_fltr_lock);
> +}

[Severity: High]
Does ICE_FLAG_ACL_ENA actually gate ACL rule programming?

The commit message says "Use the new flag to track the NTUPLE ethtool feature
flag ... Like with Flow Director, disabling the flag deletes all filters".
After ethtool -K ethX ntuple off, existing filters are deleted here, but the
add path still dispatches on hw->acl_tbl alone:

ice_add_ntuple_ethtool() {
	/* ACL filter */
	if (pf->hw.acl_tbl && ice_is_acl_filter(fsp))
		return ice_acl_add_rule_ethtool(vsi, cmd);

	/* Only fdir filters below */
	if (!test_bit(ICE_FLAG_FD_ENA, pf->flags))
		return -EOPNOTSUPP;
	...
}

So a new ACL-class rule is still accepted and programmed with NTUPLE off,
while the equivalent Flow Director rule returns -EOPNOTSUPP.  Those rules are
also invisible to the new replay, since ice_rebuild() only enters the ACL
block when ICE_FLAG_ACL_ENA is set.  Should the ACL dispatch test the new flag
too?

[Severity: Medium]
What restores the ACL hardware table if a reset happens while NTUPLE is off?

ethtool -K ethX ntuple off clears the flag here but leaves hw->acl_tbl set.
A PF reset then skips the whole ACL block in ice_rebuild(), so the SW
hw->acl_tbl object survives while its firmware table and scenario allocation
are gone.  Re-enabling only does set_bit(ICE_FLAG_ACL_ENA, pf->flags) with no
hardware reconstruction, and ice_add_ntuple_ethtool() treats the stale
non-NULL hw->acl_tbl as proof the ACL hardware exists.

Can rules then be programmed against a table and scenario that no longer
exist in hardware until the driver is reloaded?

[Severity: High]
Does the ice_acl_rem_flows() call here leave a wrapper in hw->acl_prof[] that
a later error path can free twice?

ice_acl_rem_flows() frees prof->seg and sets it NULL but keeps the
ice_acl_hw_prof installed in hw->acl_prof[flow]:

ice_acl_rem_flows() {
	...
	kfree(prof->seg);
	prof->seg = NULL;
	...
}

Since the add path stays open after the disable (it is gated on hw->acl_tbl),
a following ACL rule add reuses that retained wrapper in
ice_acl_prof_add_ethtool(), skips the if (hw_prof->seg) branch, and on any
ice_flow_add_prof() failure takes:

free_acl_prof:
	kfree(hw_prof);
free_seg:
	kfree(seg);

without clearing hw->acl_prof[fltr_type].  ice_acl_replay_flows() then
dereferences prof->seg/prof->prof_id on the next reset, and ice_deinit_acl()
does kfree(hw_prof->seg) followed by kfree(hw_prof).  Is that a
use-after-free plus double free?  Before this patch,
ice_acl_rem_flows() was only reachable from ice_deinit_acl(), so the
"wrapper retained, seg == NULL" state did not exist at runtime.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 3a10b2c2a44ae..8a81d3e475a72 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3947,6 +3948,9 @@ static void ice_set_pf_caps(struct ice_pf *pf)
>  				       func_caps->fd_fltr_best_effort);
>  	}
>  
> +	/* ACL is always initially available */
> +	set_bit(ICE_FLAG_ACL_ENA, pf->flags);
> +

[Severity: High]
Is the flag safe to set unconditionally here, given ice_rebuild() uses it as
the sole gate for creating the ACL HW table?

ice_set_pf_caps() is called from ice_init_dev() regardless of safe mode, but
hw->acl_prof is allocated only by ice_init_acl(), which:

  - is never called in safe mode (ice_init_features() returns early), and
  - may fail: "Note: ACL init failure is non-fatal to load".

In both cases hw->acl_prof stays NULL.  After a PF reset the new block calls
ice_acl_create_hw(), which on success sets hw->acl_tbl while nothing in the
rebuild path allocates acl_prof (ice_acl_replay_flows() just returns on
!hw->acl_prof).  An ethtool ACL rule then passes the hw->acl_tbl gate and
reaches:

ice_acl_prof_add_ethtool() {
	...
	hw_prof = hw->acl_prof[fltr_type];
	if (!hw_prof) {
	...
}

Can this dereference a NULL hw->acl_prof array?

[Severity: Medium]
Related to the unconditional set_bit: hw->fdir_fltr_lock is initialized only
in ice_init_fdir(), after ice_ctrl_vsi_setup()/ice_vsi_open_ctrl(), and never
in safe mode since ice_init_features() returns before ice_init_fdir().  With
ICE_FLAG_ACL_ENA always set, the new mutex_lock(&hw->fdir_fltr_lock) in
ice_rebuild()'s ACL failure branch can run on a mutex that was never
mutex_init()ed.

Would that trip the CONFIG_DEBUG_MUTEXES magic check, or produce a lockdep
"trying to register non-static key" splat?  ice_vsi_manage_fdir() has the same
pre-existing exposure, but this patch adds a new reachable site and decouples
the ACL paths from the FD init that creates the mutex.

> @@ -4369,6 +4373,30 @@ static int ice_acl_create_hw(struct ice_pf *pf)
>  	if (err)
>  		goto destroy_table;
>  
> +	/* Reset profile extraction sequences and range checkers for all
> +	 * possible HW profile IDs. The TCAM entries are already zeroed by
> +	 * ice_acl_init_tbl() inside ice_acl_create_tbl(), but profile
> +	 * extraction and range checker state is separate per-profile HW state
> +	 * that survives PF reset, therefore must be brought back to default
> +	 * state.
> +	 */
> +	for (u8 prof_id = 0; prof_id < ICE_ACL_MAX_PROF; prof_id++) {
> +		struct ice_aqc_acl_prof_generic_frmt xtrct_buf = {};
> +		struct ice_aqc_acl_profile_ranges range_buf = {};
> +
> +		memset(xtrct_buf.pf_scenario_num, ICE_ACL_INVALID_SCEN,
> +		       sizeof(xtrct_buf.pf_scenario_num));
> +		err = ice_prgm_acl_prof_xtrct(hw, prof_id, &xtrct_buf, NULL);

[Severity: High]
Is this per-profile state shared between PFs?

struct ice_aqc_acl_prof_generic_frmt carries one scenario slot per PF, and the
existing code treats the record as device-global:

ice_flow_acl_set_xtrct_seq() {
	...
	if (!ice_flow_acl_is_prof_in_use(&buf)) {
		/* Program the profile dependent configuration. This is done
		 * only once regardless of the number of PFs using that profile
		 */
	...
}

ice_flow_acl_disassoc_scen() {
	/* Clear scenario for this PF */
	buf.pf_scenario_num[hw->pf_id] = ICE_ACL_INVALID_SCEN;
	...
}

This loop writes a zeroed extraction buffer and sets ICE_ACL_INVALID_SCEN for
every PF slot of all 128 profiles, without querying first and without
restricting the change to hw->pf_id.

Since ice_acl_create_hw() now also runs from ice_rebuild() on every PF reset,
and ICE_FLAG_ACL_ENA is set unconditionally even for a PF that never
programmed an ACL rule, can a probe or reset on one PF clear the key
extraction, range checkers and scenario association of ACL rules belonging to
other PFs on the same adapter while their TCAM entries stay programmed?

> +		if (err)
> +			dev_warn(ice_pf_to_dev(pf), "Failed to reset profile extraction for profile %u\n",
> +				 prof_id);
> +
> +		ice_prog_acl_prof_ranges(hw, prof_id, &range_buf, NULL);
> +		if (err)
> +			dev_warn(ice_pf_to_dev(pf), "Failed to reset range checkers for profile %u\n",
> +				 prof_id);
> +	}
> +
>  	return 0;

[Severity: High]
Should the return value of ice_prog_acl_prof_ranges() be assigned to err?

As written, err is only ever set by ice_prgm_acl_prof_xtrct(), so the second
if (err) re-tests the previous status:

  - a real range-checker failure is never reported, and
  - an extraction failure prints a second warning claiming the range checkers
    failed.

Neither failure is propagated either, since the function returns 0 after the
loop, so ice_rebuild() takes the success path and replays profiles and filters
even though the state this loop exists to clear may still hold pre-reset
values.  Does that contradict "Explicitly clearing it ensures that the old
configuration is erased"?

Also, with 128 profiles and a dev_warn per iteration, a device or firmware
that rejects high profile IDs would emit up to 256 warnings and 256 AQ
commands on every probe and every reset.  Would rate-limiting or a single
summary message be preferable?

> @@ -7911,6 +7940,24 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>  		ice_rebuild_arfs(pf);
>  	}
>  
> +	if (test_bit(ICE_FLAG_ACL_ENA, pf->flags)) {
> +		/* Clean up the stale HW table SW state left by the reset,
> +		 * recreate the HW table and scenario, then replay flow profiles
> +		 * from preserved SW state.
> +		 */
> +		ice_acl_destroy_tbl(hw);
> +		if (!ice_acl_create_hw(pf)) {
> +			ice_acl_replay_flows(hw);
> +			ice_acl_replay_fltrs(pf);
> +		} else {
> +			dev_err(dev, "Failed to rebuild ACL\n");
> +			mutex_lock(&hw->fdir_fltr_lock);
> +			if (vsi)
> +				ice_acl_del_all_fltrs(vsi);
> +			mutex_unlock(&hw->fdir_fltr_lock);
> +		}
> +	}
> +
>  	if (vsi && vsi->netdev)
>  		netif_device_attach(vsi->netdev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917183927.2692068-1-anthony.l.nguyen%40intel.com
