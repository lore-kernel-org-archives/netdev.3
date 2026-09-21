Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E243D0910
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020648; cv=none; b=kkdHVekLw8N8BWEr7in2r/AdVAk8LHbDK8WodRSKh6lldjApXSkj+fiio3Q0s4bTBKVXYO82ZsP1egy/ToUXSMVdqs98TurX8K01DQMlST73+kmPAeuCGJrjzlevbpGkfw1+z6fMBvZlp2dwi2Wk/sEkjgB8DZaHrI8FL/3Fg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020648; c=relaxed/simple;
	bh=XcMcYkQL59BERzh/Og6nblrMCqgaobXxeiExANlIcQU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DH9N3IrPBmWxP51hsaNFGWGoK4RrRhDYaaRqEUjNnX0s3oTcpHqA64o1MEFO0umMZ8kvHqk6KUIb8bnrYMYyK9rnNEibtokaTDzTdScNApJy3TjFRQdVyUGHYC6N1N4TdffhCzxNY43cc5jyZxksiZIIUCWRPSJXYWIQdJTC2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnSefubu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnSefubu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6151F00898;
	Mon, 21 Sep 2026 19:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020645;
	bh=14XcF7mtgOrDd6aUhXQpLGsfpdleE+qdT/B0zgS4Gzw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BnSefubu313D46XIZ5eQLsPnTABvjfeyZtqS+20NzJhiHRR3ruNC9Cf9j3naVJW/y
	 aBjn+Dmr029FAZTXg6830ZR8qsuFqTeLT8kQKlYvmqUBsw1fcR/MZh2JrLztiNldwd
	 xS0LItaXQ2dMpU2z+rFlDB3vaESl/R9SYE4uxuVUf2PCwBWeGdfJxrgpb2LCFrtFuF
	 boFDyu7173rXjDdkg1kHd3lMRlLC9fjmDUN0ECpbNnT6kA72BsharzgVtw1UHR7BCf
	 +6YV46voekMincGTxo7vZ+fpTs4o9Yt5Zd0KBxc2FUVM2JQoj3hlIZP+G9rAGCqod6
	 Ehg6vxmGI7YlQ==
Subject: Re: [PATCH net-next v2 09/12] ice: program ACL entry
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, marcin.szycik@linux.intel.com,
 aleksandr.loktionov@intel.com, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 19:57:24 +0000
Message-ID: <179002064458.2160803.12419481046643015155@kernel.org>
In-Reply-To: <20260917183927.2692068-10-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-10-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 17 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 9 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ice_flow_acl_add_scen_entry_sync() merges two distinct ethtool
  rules (different 'location' slots) onto one ACL scenario entry…
- [High] Replacing an ACL rule with a Flow Director rule at the same
  ethtool location leaves the old ACL TCAM entry programmed and active.
- [Medium] In ice_ntuple_update_list_entry() the new last-ACL-filter
  cleanup calls ice_fdir_rem_flow(hw, ICE_BLK_ACL, old_fltr->flow_type),…
- [Medium] ice_set_fd_vsi_ctx() now unconditionally sets
  ICE_AQ_VSI_PROP_ACL_VALID and programs acl_def_act (hardcoded miss-…
- [Medium] ACL ice_ntuple_fltr objects are inserted into
  hw->fdir_list_head (input->acl_fltr = true) but the teardown paths…
- [Medium] ACL rule placement ignores the ethtool rule-ordering contract.
- [Medium] In ice_acl_add_rule_ethtool(), the new `del_entry` error path
  unconditionally calls ice_flow_rem_entry(hw, ICE_BLK_ACL, entry_h).
- [Medium] ice_flow_rem_prof_sync() iterates prof->entries calling
  ice_flow_rem_entry_sync() and only `break`s on the first failure; the…
- [Medium] ice_acl_rem_entry() only releases the scenario slot
  (ice_acl_scen_free_entry_idx(), i.e. clearing the entry_bitmap bit…
- [Medium] In the in-place action-update branch (do_chg_action) of
  ice_flow_acl_add_scen_entry_sync(), the driver releases the existing…
- [Medium] The new ice_flow_find_entry() converts a struct ice_flow_entry
  pointer into a u64 'handle' and returns it after releasing both…
- [Low] Concern that ACL filters are never reprogrammed after a PF/core
  reset (ice_fdir_replay_fltrs() skips acl_fltr entries and…
- [Low] ice_acl_prof_aq_send() is extended to set LIBIE_AQ_FLAG_RD for
  ice_aqc_opc_program_acl_prof_ranges, but that opcode can never reach…
- [Low] ice_flow_find_entry()'s kernel-doc states it returns
  'ICE_FLOW_ENTRY_ID_INVAL' when no entry is found, but no such macro…
- [Low] The new struct ice_acl_scen.entry_bitmap comment states that a
  set bit means the entry is available, while the allocator and free…
- [Low] ice_flow_acl_find_scen_entry_cond() bounds its action-comparison
  loop with the existing entry's count but dereferences both arrays:…
- [Low] ice_acl_add_entry() programs all cascaded TCAM slices - including
  the leftmost slice that completes the match - before calling…

--

ice: program ACL entry

This completes the ACL filter programming path: the formatted key and the
action set are written into the scenario's TCAM entry and action memories,
scenario entry allocation/removal helpers are added, and the VSI context is
extended with the ACL section.  Masked ntuple rules for tcp4, udp4, sctp4
and ip4 can now be installed through ethtool.

A few questions on the new code below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl.c b/drivers/net/ethernet/intel/ice/ice_acl.c
> index 3179ce33e365e..ed078e30abfab 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl.c
> @@ -156,7 +156,8 @@ static int ice_acl_prof_aq_send(struct ice_hw *hw, u16 opc, u8 prof_id,
>  	cmd = libie_aq_raw(&desc);
>  	cmd->profile_id = prof_id;
>  
> -	if (opc == ice_aqc_opc_program_acl_prof_extraction)
> +	if (opc == ice_aqc_opc_program_acl_prof_extraction ||
> +	    opc == ice_aqc_opc_program_acl_prof_ranges)
>  		desc.flags |= cpu_to_le16(LIBIE_AQ_FLAG_RD);
>  
>  	return ice_aq_send_cmd(hw, &desc, buf, sizeof(*buf), cd);

[Severity: Low]
Can ice_aqc_opc_program_acl_prof_ranges ever reach ice_acl_prof_aq_send()?
The only callers are ice_prgm_acl_prof_xtrct() (extraction) and
ice_query_acl_prof() (query prof).

Also, this helper's buf parameter is struct ice_aqc_acl_prof_generic_frmt *
and it always sends sizeof(*buf) of that type, while 0x0C1E takes a
struct ice_aqc_acl_profile_ranges buffer.  The new
ice_prog_acl_prof_ranges() added by this patch builds its own descriptor
and sets LIBIE_AQ_FLAG_RD itself, so should this branch be dropped?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl.h b/drivers/net/ethernet/intel/ice/ice_acl.h
> index 066665c9d963d..0c8163e585d9d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl.h
> +++ b/drivers/net/ethernet/intel/ice/ice_acl.h
> @@ -69,6 +70,11 @@ struct ice_acl_scen {
>  	 * participate in this scenario
>  	 */
>  	DECLARE_BITMAP(act_mem_bitmap, ICE_AQC_MAX_ACTION_MEMORIES);
> +
> +	/* If nth bit of entry_bitmap is set, then nth entry will
> +	 * be available in this scenario
> +	 */
> +	DECLARE_BITMAP(entry_bitmap, ICE_MAX_ACL_TCAM_ENTRY);

[Severity: Low]
Is the polarity in this comment inverted?  The users treat a set bit as
"allocated":

	if (!test_and_set_bit(i, scen->entry_bitmap))
		return i;			/* allocate */

	if (!test_and_clear_bit(idx, scen->entry_bitmap))
		return -ENOENT;			/* free */

	if (!test_bit(entry_idx, scen->entry_bitmap))
		return -ENOENT;			/* remove */

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> index 6a60da3034cf2..0ee86236bc37a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> @@ -29,6 +34,51 @@ static void ice_acl_init_entry(struct ice_acl_scen *scen)
> +static u16 ice_acl_scen_assign_entry_idx(struct ice_acl_scen *scen,
> +					 enum ice_acl_entry_prio prio)
> +{
> +	u16 first_idx, last_idx, i;
> +	s8 step;
> +
> +	if (prio >= ICE_ACL_MAX_PRIO)
> +		return ICE_ACL_SCEN_ENTRY_INVAL;
> +
> +	first_idx = scen->first_idx[prio];
> +	last_idx = scen->last_idx[prio];
> +	step = first_idx <= last_idx ? 1 : -1;
> +
> +	for (i = first_idx; i != last_idx + step; i += step)
> +		if (!test_and_set_bit(i, scen->entry_bitmap))
> +			return i;
> +
> +	return ICE_ACL_SCEN_ENTRY_INVAL;
> +}

[Severity: Medium]
How is the ethtool rule ordering contract honoured here?
include/uapi/linux/ethtool.h says for struct ethtool_rx_flow_spec:

	 * @location: Location of rule in the table.  Locations must be
	 *	numbered such that a flow matching multiple rules will be
	 *	classified according to the first (lowest numbered) rule.

ice_acl_add_rule_ethtool() passes ICE_FLOW_PRIO_NORMAL for every rule and
uses fsp->location only as the flow entry id, and this function picks the
first free slot of the priority partition without ever seeing the
location.  For two overlapping masked rules, doesn't the hardware match
order end up being the order in which they were added rather than the
location order?

[ ... ]

> @@ -887,3 +937,209 @@ int ice_acl_destroy_tbl(struct ice_hw *hw)
> +int ice_acl_add_entry(struct ice_hw *hw, struct ice_acl_scen *scen,
> +		      enum ice_acl_entry_prio prio, u8 *keys, u8 *inverts,
> +		      struct ice_acl_act_entry *acts, u8 acts_cnt,
> +		      u16 *entry_idx)
> +{

[ ... ]

> +		offset = num_cscd - i - 1;
> +		memcpy(&buf.entry_key.val,
> +		       &keys[offset * sizeof(buf.entry_key.val)],
> +		       sizeof(buf.entry_key.val));
> +		memcpy(&buf.entry_key_invert.val,
> +		       &inverts[offset * sizeof(buf.entry_key_invert.val)],
> +		       sizeof(buf.entry_key_invert.val));
> +		err = ice_aq_program_acl_entry(hw, entry_tcam + offset, idx,
> +					       &buf, NULL);
> +		if (err) {
> +			ice_debug(hw, ICE_DBG_ACL, "aq program acl entry failed status: %d\n",
> +				  err);
> +			goto out;
> +		}
> +	}
> +
> +	err = ice_acl_prog_act(hw, scen, acts, acts_cnt, *entry_idx);

[Severity: Low]
Is there a window here where the entry matches but has no action?  The
loop programs all cascaded slices, including the leftmost one that
completes the match, and only afterwards does ice_acl_prog_act() program
the action memory in a separate AdminQ command.

The action memories are zeroed at table init, and mdid == 0 is documented
as NOP in struct ice_acl_act_entry, so for the duration of that extra
round trip a matching packet gets a NOP instead of the requested
drop/redirect.  If the new entry lands in a higher priority slot than an
existing overlapping rule, does it transiently shadow that rule?
Would programming the action memory first and publishing the completing
slice last avoid this?

> +
> +out:
> +	if (err) {
> +		ice_acl_rem_entry(hw, scen, *entry_idx);
> +		*entry_idx = 0;
> +	}
> +
> +	return err;
> +}

[ ... ]

> +int ice_acl_rem_entry(struct ice_hw *hw, struct ice_acl_scen *scen,
> +		      u16 entry_idx)
> +{

[ ... ]

> +	for (i = 0; i < num_cscd; i++) {
> +		int aq_err = ice_aq_program_acl_entry(hw, entry_tcam + i, idx,
> +						      &buf, NULL);
> +		if (aq_err) {
> +			dev_warn(ice_hw_to_dev(hw), "AQ program ACL entry failed, status: %d\n",
> +				 aq_err);
> +			err = aq_err;
> +		}
> +	}

[ ... ]

> +	if (!err)
> +		err = ice_acl_scen_free_entry_idx(scen, entry_idx);
> +
> +	return err;
> +}

[Severity: Medium]
[Sources: gpt-5-6-sol, gpt-6-astra, opus-5
Can this leak scenario entries?  The bit reserved by test_and_set_bit() in
ice_acl_scen_assign_entry_idx() is only released when every
ice_aq_program_acl_entry()/ice_aq_program_actpair() invalidation above
succeeded.  The loops themselves treat an AdminQ failure as non-fatal
(dev_warn() and continue), so on such a failure the bit stays set and no
other path clears it.

Each such removal would then permanently consume one TCAM slot until
ice_acl_scen_assign_entry_idx() starts returning
ICE_ACL_SCEN_ENTRY_INVAL and all further adds fail with -ENOSPC.

Related, the rollback in ice_acl_add_entry() calls
ice_acl_rem_entry(hw, scen, *entry_idx) and discards the return value
before zeroing *entry_idx, so a failed add can lose the index it just
reserved.

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> index 6313d511398a2..171b7bf8519c6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> @@ -371,6 +371,12 @@ int ice_acl_add_rule_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
>  	flow = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
>  	hw_prof = hw->acl_prof[flow];
>  
> +	/* Look up existing HW entry before adding/replacing, so we can
> +	 * remove it if the new entry has different match data and a fresh
> +	 * TCAM slot was allocated instead of updating in place.
> +	 */
> +	old_entry_h = ice_flow_find_entry(hw, ICE_BLK_ACL, fsp->location);
> +
>  	err = ice_flow_add_entry(hw, ICE_BLK_ACL, hw_prof->prof_id,
>  				 fsp->location, vsi->idx, ICE_FLOW_PRIO_NORMAL,
>  				 input, acts, ICE_ACL_NUM_ACT, &entry_h);
> @@ -379,8 +385,31 @@ int ice_acl_add_rule_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
>  		goto free_input;
>  	}
>  
> +	/* If the match data changed, ice_flow_acl_add_scen_entry_sync()
> +	 * allocated a new TCAM entry rather than updating in place, leaving
> +	 * the old entry still programmed. Remove it.
> +	 */
> +	if (old_entry_h != ICE_FLOW_ENTRY_HANDLE_INVAL &&
> +	    old_entry_h != entry_h) {
> +		err = ice_flow_rem_entry(hw, ICE_BLK_ACL, old_entry_h);
> +		if (err)
> +			goto del_entry;
> +	}
> +
> +	input->acl_fltr = true;
> +
> +	mutex_lock(&hw->fdir_fltr_lock);
> +	/* input struct is added to the HW filter list */
> +	err = ice_ntuple_update_list_entry(pf, input, fsp->location);
> +	mutex_unlock(&hw->fdir_fltr_lock);
> +	if (err)
> +		goto del_entry;
> +
>  	return 0;
>  
> +del_entry:
> +	ice_flow_rem_entry(hw, ICE_BLK_ACL, entry_h);
> +

[Severity: Medium]
Is entry_h always a freshly created resource on this error path?  On the
update path ice_flow_acl_add_scen_entry_sync() can return the
pre-existing entry:

	*entry = exist;

which is still referenced by a live software filter record.  The
failures that reach del_entry include the early returns of
ice_ntuple_update_list_entry():

	if (ice_is_reset_in_progress(pf->state))
		return -EBUSY;

	vsi = ice_get_main_vsi(pf);
	if (!vsi)
		return -EINVAL;

Both happen before old_fltr is touched, so does the unconditional
ice_flow_rem_entry() here tear down the hardware state of a filter that
stays in hw->fdir_list_head?  Afterwards ice_del_acl_ethtool() cannot
find an entry for that id, ice_flow_rem_entry() returns -EINVAL, and
ice_ntuple_update_list_entry() returns before list_del()/kfree(), so the
rule is listed by ethtool -n forever while not being programmed.

[Severity: Medium]
With input->acl_fltr = true the filter is handed to hw->fdir_list_head,
but do the owners of that list free ACL entries?
ice_fdir_del_all_fltrs() starts with:

	list_for_each_entry_safe(f_rule, tmp, &hw->fdir_list_head, fltr_node) {
		if (f_rule->acl_fltr)
			continue;

and ice_deinit_acl() only calls ice_acl_rem_flows()/ice_acl_destroy_tbl()
and frees hw->acl_prof, never walking the filter list.  On unload
(ice_deinit_fdir() -> ice_vsi_manage_fdir(vsi, false) ->
ice_fdir_del_all_fltrs()) does every kzalloc'd struct ice_ntuple_fltr
with acl_fltr set leak?

The same skip also applies to ice_remove_q_channels(), which removes
ntuple filters precisely because queue configuration is changing but only
calls ice_fdir_del_all_fltrs(), so queue-directed ACL rules would keep
pointing at queues that no longer exist.

[Severity: Low]
At this point in the series ACL filters are not reprogrammed after a
PF/core reset: ice_fdir_replay_fltrs() skips acl_fltr records and
ice_rebuild() has no ACL restoration, so the rules stay listed by
ethtool -n while no longer matching in hardware.  This is addressed later
in the same series by the commit adding ice_acl_replay_flows() and
ice_acl_replay_fltrs() to ice_rebuild(), so it is only an issue for the
intermediate state at this commit.  Would folding the ordering
differently avoid the transient?

>  free_input:
>  	kfree(input);
>  

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index f67b6e1c0ffbf..0ac44d38fdbdf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> @@ -1895,17 +1910,43 @@ ice_ntuple_update_list_entry(struct ice_pf *pf, struct ice_ntuple_fltr *input,
>  
>  	old_fltr = ice_fdir_find_fltr_by_idx(hw, fltr_idx);
>  	if (old_fltr) {
> -		err = ice_fdir_write_all_fltr(pf, old_fltr, false);
> -		if (err)
> -			return err;
> +		if (old_fltr->acl_fltr) {
> +			/* ACL filter - if the input buffer is present
> +			 * then this is an update. The caller has already
> +			 * applied the HW change (including removing the old
> +			 * TCAM entry when match data changed), so just update
> +			 * the SW structures. If no input then this is a
> +			 * delete so we should delete the filter from the HW
> +			 * and clean up our SW structures.
> +			 */
> +			if (!input) {
> +				err = ice_del_acl_ethtool(hw, old_fltr);
> +				if (err)
> +					return err;
> +			}

[Severity: High]
Does this assumption hold for all callers?  The comment says the caller
has already applied the hardware change, which is true for
ice_acl_add_rule_ethtool() (it looks up old_entry_h and removes it), but
ice_add_ntuple_ethtool() also calls:

	ret = ice_ntuple_update_list_entry(pf, input, fsp->location);

with a non-NULL input and no ACL hardware removal at all.

So for an ACL rule at location N replaced by a Flow Director rule at the
same location, the "if (!input)" guard skips ice_del_acl_ethtool(), and a
few lines below:

		list_del(&old_fltr->fltr_node);
		kfree(old_fltr);

drops the only record of the ACL entry id.  Does that leave the old ACL
TCAM entry armed (possibly a drop rule) with no way for userspace to see
or delete it, plus a leaked ice_flow_entry, a leaked entry_bitmap slot
and a stale hw->acl_fltr_cnt?

> +		} else {
> +			/* FD filter */
> +			err = ice_fdir_write_all_fltr(pf, old_fltr, false);
> +			if (err)
> +				return err;
> +		}
> +
>  		ice_ntuple_update_cntrs(hw, old_fltr, false);
>  		/* update sb-filters count, specific to ring->channel */
>  		ice_update_per_q_fltr(vsi, old_fltr->orig_q_index, false);
> -		if (!input && !hw->fdir_fltr_cnt[old_fltr->flow_type])
> +		/* Also delete the HW filter info if we have just deleted the
> +		 * last filter of flow_type.
> +		 */
> +		if (!old_fltr->acl_fltr && !input &&
> +		    !hw->fdir_fltr_cnt[old_fltr->flow_type])
>  			/* we just deleted the last filter of flow_type so we
>  			 * should also delete the HW filter info.
>  			 */
>  			ice_fdir_do_rem_flow(pf, old_fltr->flow_type);
> +		else if (old_fltr->acl_fltr && !input &&
> +			 !hw->acl_fltr_cnt[old_fltr->flow_type])
> +			ice_fdir_rem_flow(hw, ICE_BLK_ACL, old_fltr->flow_type);
> +

[Severity: Medium]
Does this ICE_BLK_ACL call do anything?  ice_fdir_rem_flow() resolves the
profile with ice_fdir_get_hw_prof():

	if (blk == ICE_BLK_FD && hw->fdir_prof)
		return hw->fdir_prof[flow];

	return NULL;

and returns immediately on NULL, so for ICE_BLK_ACL it looks like an
unconditional no-op and hw->acl_prof[flow] is never torn down.

Then a later add for the same flow-type still sees the old input set in
ice_acl_prof_add_ethtool():

	if (hw_prof->seg) {
		if (!memcmp(hw_prof->seg, seg, sizeof(*seg))) {
			kfree(seg);
			return 0;
		}

		err = -EINVAL;

So after deleting all tcp4 ACL rules, does adding a tcp4 rule with a
different mask selection fail with -EINVAL for the rest of the
interface's lifetime?  Should this use the ACL API instead, the way
ice_acl_rem_flows() does with
ice_flow_rem_prof(hw, ICE_BLK_ACL, prof->prof_id)?  The two profile types
also differ (struct ice_acl_hw_prof vs struct ice_fd_hw_prof).

>  		list_del(&old_fltr->fltr_node);
>  		kfree(old_fltr);
>  	}

> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> index 192569ff1d6c1..e0a1d8463d6f5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> @@ -1741,6 +1741,16 @@ static int ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block blk,
>  		return -EINVAL;
>  
>  	if (blk == ICE_BLK_ACL) {
> +		int err;
> +
> +		if (!entry->prof)
> +			return -EINVAL;
> +
> +		err = ice_acl_rem_entry(hw, entry->prof->cfg.scen,
> +					entry->scen_entry_idx);
> +		if (err)
> +			return err;
> +

[Severity: Medium]
This makes the ACL branch of ice_flow_rem_entry_sync() fallible for the
first time, and the early return happens before list_del() and
ice_dealloc_flow_entry().  Is the caller prepared for that?
ice_flow_rem_prof_sync() does:

		list_for_each_entry_safe(e, t, &prof->entries, l_entry) {
			status = ice_flow_rem_entry_sync(hw, blk, e);
			if (status)
				break;
		}

	mutex_unlock(&prof->entries_lock);

and the loop's status is then overwritten and execution continues to
ice_rem_prof() and devm_kfree(prof).

So on an AdminQ failure during teardown (for example
ice_acl_rem_flows() -> ice_flow_rem_prof() after a reset), does the
failing entry and everything after it stay linked in prof->entries and
never get freed, while the profile they point to through entry->prof is
devm_kfree()d?

>  		if (entry->acts_cnt && entry->acts)
>  			ice_flow_acl_free_act_cntr(hw, entry->acts,
>  						   entry->acts_cnt);

[ ... ]

> @@ -2211,6 +2260,44 @@ int ice_flow_rem_prof(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
> + * Return: flow entry handle if entry found, ICE_FLOW_ENTRY_ID_INVAL otherwise
> + */

[Severity: Low]
ICE_FLOW_ENTRY_ID_INVAL does not exist anywhere in the tree; the code
returns ICE_FLOW_ENTRY_HANDLE_INVAL (defined as 0 in ice_flow.h), which
is also what the new callers compare against.

> +u64 ice_flow_find_entry(struct ice_hw *hw, enum ice_block blk, u64 entry_id)
> +{
> +	struct ice_flow_entry *found = NULL;
> +	struct ice_flow_prof *p;
> +
> +	mutex_lock(&hw->fl_profs_locks[blk]);
> +
> +	list_for_each_entry(p, &hw->fl_profs[blk], l_entry) {
> +		struct ice_flow_entry *e;
> +
> +		mutex_lock(&p->entries_lock);
> +		list_for_each_entry(e, &p->entries, l_entry)
> +			if (e->id == entry_id) {
> +				found = e;
> +				break;
> +			}
> +		mutex_unlock(&p->entries_lock);
> +
> +		if (found)
> +			break;
> +	}
> +
> +	mutex_unlock(&hw->fl_profs_locks[blk]);
> +
> +	return found ? ICE_FLOW_ENTRY_HNDL(found) : ICE_FLOW_ENTRY_HANDLE_INVAL;
> +}

[Severity: Medium]
What keeps the returned object alive?  The raw struct ice_flow_entry
pointer is published as a handle after both hw->fl_profs_locks[blk] and
p->entries_lock have been dropped, with no refcount and no RCU.

Both new callers then dereference it unlocked, since ice_flow_rem_entry()
reads entry->prof, takes prof->entries_lock and list_del()s
entry->l_entry:

ice_del_acl_ethtool()
	entry = ice_flow_find_entry(hw, ICE_BLK_ACL, fltr->fltr_id);
	return ice_flow_rem_entry(hw, ICE_BLK_ACL, entry);

In ice_acl_add_rule_ethtool() the handle is additionally cached across a
whole ice_flow_add_entry() call, and the only validity test is
old_entry_h != entry_h, which shows identity rather than liveness.  Would
resolving the id again under prof->entries_lock, or removing under that
lock, be safer than caching a bare pointer?

> @@ -2554,6 +2641,346 @@ static int ice_flow_acl_frmt_entry(struct ice_hw *hw,
> +static struct ice_flow_entry *
> +ice_flow_acl_find_scen_entry_cond(struct ice_flow_prof *prof,
> +				  struct ice_flow_entry *e, bool *do_chg_action,
> +				  bool *do_add_entry, bool *do_rem_entry)
> +{

[ ... ]

> +	list_for_each_entry(p, &prof->entries, l_entry) {
> +		if (memcmp(p->entry, e->entry, p->entry_sz))
> +			continue;
> +
> +		/* Now we have the same matching_data */
> +
> +		*do_add_entry = false;
> +		return_entry = p;
> +
> +		if (p->priority != e->priority) {
> +			/* matching data && !priority */
> +			*do_add_entry = true;
> +			*do_rem_entry = true;
> +			break;
> +		}
> +
> +		/* Now we have matching_data && priority */
> +
> +		if (p->acts_cnt != e->acts_cnt)
> +			*do_chg_action = true;
> +		for (int i = 0; i < p->acts_cnt; i++) {
> +			if (memcmp(&p->acts[i], &e->acts[i],
> +				   sizeof(struct ice_flow_action))) {

[Severity: Low]
Can this read past the end of e->acts?  The loop is bounded by
p->acts_cnt but indexes both arrays, and the check just above has already
established that the counts can differ.  e->acts comes from
ice_flow_acl_frmt_entry():

	e->acts = kmemdup(acts, acts_cnt * sizeof(*acts), GFP_KERNEL);

so it is sized exactly to e->acts_cnt.  Today every ACL entry is created
with ICE_ACL_NUM_ACT (1) and ice_flow_add_entry() rejects acts_cnt == 0
for ICE_BLK_ACL, so the counts are always equal, but
ICE_FLOW_ACL_MAX_NUM_ACT is 2.  Should this use
min(p->acts_cnt, e->acts_cnt), or skip the loop when the counts differ?

> +				*do_chg_action = true;
> +				break;
> +			}
> +		}

[ ... ]

> +static int ice_flow_acl_add_scen_entry_sync(struct ice_hw *hw,
> +					    struct ice_flow_prof *prof,
> +					    struct ice_flow_entry **entry)
> +{

[ ... ]

> +	} else {
> +		if (do_chg_action) {
> +			/* For the action memory info, update the SW's copy of
> +			 * exist entry with e's action memory info
> +			 */
> +			if (exist->acts_cnt && exist->acts)
> +				ice_flow_acl_free_act_cntr(hw, exist->acts,
> +							   exist->acts_cnt);
> +			kfree(exist->acts);
> +			exist->acts = kzalloc_objs(*exist->acts, e->acts_cnt);
> +			if (!exist->acts) {
> +				exist->acts_cnt = 0;
> +				err = -ENOMEM;
> +				goto out;
> +			}
> +			exist->acts_cnt = e->acts_cnt;
> +
> +			memcpy(exist->acts, e->acts,
> +			       sizeof(struct ice_flow_action) * e->acts_cnt);
> +
> +			err = ice_acl_prog_act(hw, prof->cfg.scen, acts,
> +					       e->acts_cnt,
> +					       exist->scen_entry_idx);
> +			if (err) {
> +				/* HW programming failed; e's counters were not
> +				 * transferred. Drop exist's new acts so the
> +				 * caller's free_cntrs path does not release IDs
> +				 * still referenced by exist->acts.
> +				 */
> +				kfree(exist->acts);
> +				exist->acts = NULL;
> +				exist->acts_cnt = 0;
> +				goto out;
> +			}

[Severity: Medium]
What describes the hardware state after this error path?  The existing
entry's counters were already released by ice_flow_acl_free_act_cntr()
before any hardware was touched, and ice_acl_prog_act() issues one
ice_aq_program_actpair() per matching action memory in the cascade, so a
failure on the second or later command leaves some action memories
already updated.

This path then sets exist->acts = NULL and exist->acts_cnt = 0 but leaves
the TCAM entry programmed and exist on prof->entries, so the device keeps
executing an action set (old, new, or a mix) that the driver no longer
tracks.

Also, with acts_cnt zeroed, ice_flow_rem_entry_sync() will skip
ice_flow_acl_free_act_cntr():

		if (entry->acts_cnt && entry->acts)
			ice_flow_acl_free_act_cntr(hw, entry->acts,
						   entry->acts_cnt);

so are the counter IDs still referenced by the action memory
unreclaimable, while the ones released earlier can be handed out to
another filter?

> +
> +			/* e's counter IDs are now owned by exist->acts; clear
> +			 * acts_cnt so the trailing ice_flow_acl_free_act_cntr
> +			 * call does not release IDs that exist->acts owns.
> +			 * ice_dealloc_flow_entry still frees the acts memory
> +			 * via kfree(e->acts).
> +			 */
> +			e->acts_cnt = 0;
> +		}

[ ... ]

> +		/* As we don't add the new entry to our SW DB, free its HW
> +		 * counter resources and deallocate its memory, then return
> +		 * the exist entry to the caller. Transfer the new caller's
> +		 * entry_id to exist so that ice_flow_find_entry() can locate
> +		 * it and the caller's handle remains valid for deletion.
> +		 */
> +		if (e->acts_cnt && e->acts)
> +			ice_flow_acl_free_act_cntr(hw, e->acts, e->acts_cnt);
> +		exist->id = e->id;
> +		kfree(e->entry);
> +		kfree(e->range_buf);
> +		kfree(e->acts);
> +		devm_kfree(ice_hw_to_dev(hw), e);
> +		*entry = exist;
> +	}

[Severity: High]
Can overwriting exist->id orphan the rule that previously owned that id?
Two ethtool rules at different locations can end up here with
byte-identical keys:

ice_acl_is_dup_fltr() -> ice_acl_comp_rules() compares raw values and
masks, so rules that differ only in masked-out bits are accepted as
distinct:

		       a->ip.v4.dst_port == b->ip.v4.dst_port &&
		       a->ip.v4.src_port == b->ip.v4.src_port &&

but ice_gen_key_word() emits the fixed don't-care key/invert pair for
every masked bit, ignoring the value, so both rules produce identical
e->entry buffers and ice_flow_acl_find_scen_entry_cond()'s
memcmp(p->entry, e->entry, p->entry_sz) matches.  ethtool always passes
ICE_FLOW_PRIO_NORMAL, so do_rem_entry stays false, do_add_entry becomes
false, and this merge branch runs.

After exist->id = e->id, no flow entry carries the first rule's id any
more, although its ice_ntuple_fltr is still in hw->fdir_list_head and is
still reported by ethtool -n.  Deleting the second rule invalidates the
single shared TCAM entry, so does the first rule remain listed but no
longer enforced?  And does deleting the first rule then fail forever,
since ice_del_acl_ethtool() gets handle 0 and ice_flow_rem_entry()
returns -EINVAL before ice_ntuple_update_list_entry() reaches
list_del()/kfree(), leaving hw->acl_fltr_cnt[] and
hw->ntuple_active_fltr_cnt inflated?

> +out:
> +	kfree(acts);
> +
> +	return err;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d0..8e842b29f84f2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1118,7 +1118,7 @@ static void ice_set_fd_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
>  	    vsi->type != ICE_VSI_VF && vsi->type != ICE_VSI_CHNL)
>  		return;
>  
> -	val = ICE_AQ_VSI_PROP_FLOW_DIR_VALID;
> +	val = ICE_AQ_VSI_PROP_FLOW_DIR_VALID | ICE_AQ_VSI_PROP_ACL_VALID;
>  	ctxt->info.valid_sections |= cpu_to_le16(val);

[Severity: Medium]
Is ICE_FLAG_FD_ENA the right condition for this?  The only call site is
still:

	if (test_bit(ICE_FLAG_FD_ENA, pf->flags))
		ice_set_fd_vsi_ctx(ctxt, vsi);

so the ACL section is now advertised for every PF/CTRL/VF/CHNL VSI
whenever Flow Director is on, with no check that ACL was actually
initialized.  ice_init_features() treats ACL init failure as non-fatal:

	/* Note: ACL init failure is non-fatal to load */
	if (ice_init_acl(pf))
		dev_err(dev, "Failed to initialize ACL\n");

so hw->acl_tbl can be NULL while the VSI context claims the ACL section.
Conversely, for a configuration where ACL is available but the FD flag is
clear, the ACL VSI configuration is never applied even though
ice_add_ntuple_ethtool() routes rules to ACL based only on
pf->hw.acl_tbl.

>  	dflt_q = 0;
>  	dflt_q_group = 0;

[ ... ]

> @@ -1144,6 +1144,14 @@ static void ice_set_fd_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
>  	/* priority of the default qindex action */
>  	val |= FIELD_PREP(ICE_AQ_VSI_FD_DEF_PRIORITY_M, dflt_q_prio);
>  	ctxt->info.fd_report_opt = cpu_to_le16(val);
> +
> +#define ICE_ACL_RX_PROF_MISS_CNTR	\
> +	FIELD_PREP_CONST(ICE_AQ_VSI_ACL_DEF_RX_PROF_M, 2)
> +#define ICE_ACL_RX_TBL_MISS_CNTR	\
> +	FIELD_PREP_CONST(ICE_AQ_VSI_ACL_DEF_RX_TABLE_M, 3)
> +
> +	val = ICE_ACL_RX_PROF_MISS_CNTR | ICE_ACL_RX_TBL_MISS_CNTR;
> +	ctxt->info.acl_def_act = cpu_to_le16(val);
>  }

Where do the miss-counter indices 2 and 3 come from?  They are not
allocated anywhere in the driver and there is no comment explaining the
choice.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917183927.2692068-1-anthony.l.nguyen%40intel.com
