Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802E03DB326
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020646; cv=none; b=oJe/HIHZfZ3avPfo5HwDx1qgFtzS4jow1HDgfMVggyTgOGGE12U7isBTjdoJuTOsTnDgW90Jj4YCKeY6v8eT5Hl8XRPwStmVsv6T0iz9hF2yF8syRKhaisVRhY3pFheqnOF5Ph4z4N8qW4MlyM8W5pe5DRtqfOIrHUtmpO8gbcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020646; c=relaxed/simple;
	bh=wUWmtBexR8yVaUnZpHN6WS2MPKgw+V+fApBRXLvQ8uI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCMzW3Mg3nF0spWrR1TqKHRGlhTWUt7hCh7MeJSzrbAYWcmAL/HPWOSVHy3dkjI3PggyT2nkLJC72RTmfPV/dhhR5lwAvEsLBjst1sTo1W28SBHOQmdCvOxarkC9Lpz5GtvqPTUb+iRAduiQxlBiZ2B9LSWonoH/hWsOXDgK7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl3qvy0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl3qvy0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D581F00893;
	Mon, 21 Sep 2026 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020644;
	bh=FnR9EvI4OpB6dympuAePTaVbjhy1sef4AOtnL+sHoEo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kl3qvy0/Ri/yv0hDixb0QukWkWIm1LvnMW++GrSaAko9SaX3Yf3JsVVZIyJTmnxnI
	 tj2yfu8a9wS6HXb65fXUwUBoOpnF5gT9Ue9/utwEqyKX/6ZRb4jTk2JMZc2N0UHe6o
	 8pSDj18fXpqu3/o8uh8PkXbdK6DHX635mZwi+BquRv3VEQSARqopcW6wxN8dm1m63X
	 7iRNCo/JL95mX9o+HspXYl8PDqBWIFAFSIP0T/HYCatJwi4RMzEq2hAfv38M+0GLqA
	 9l1KzwpH2qIv25fPcEDkwQ/mBjXgNzfCadfIDz6INFL8fWiQfIBjTCOKWztKm6ePin
	 kmkQOkTDYjZ/Q==
Subject: Re: [PATCH net-next v2 08/12] ice: create ACL entry
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, marcin.szycik@linux.intel.com,
 aleksandr.loktionov@intel.com, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 19:57:23 +0000
Message-ID: <179002064326.2160803.9970333344666606379@kernel.org>
In-Reply-To: <20260917183927.2692068-9-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-9-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 8 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ice_ntuple_set_input_set() strips the wrong ethtool extension
  bit for the ACL block: `else if (blk == ICE_BLK_ACL) flow_mask =…
- [Medium] ice_acl_comp_rules() requires the raw IP/port values to be
  byte-identical in addition to the masks, so two ACL rules whose…
- [Medium] In ice_flow_acl_frmt_entry_range() the 2-byte read of the
  field mask out of the caller-supplied match buffer is performed…
- [Medium] ice_flow_acl_check_actions() allocates one hardware ACL
  counter per counter-type action in a loop and, on failure of a later…
- [Medium] ice_flow_acl_set_xtrct_seq() and ice_flow_acl_disassoc_scen()
  perform a query-modify-program transaction on the ACL profile…
- [Medium] ice_flow_add_entry() releases hw->fl_profs_locks[blk]
  immediately after ice_flow_assoc_prof() but keeps the raw `prof`…
- [Medium] ice_flow_acl_frmt_entry() writes the packet-direction flag
  value into the ACL key (buf[prof->cfg.scen->pkt_dir_idx] =…
- [Medium] net/ice: TOCTOU race allows programming duplicate ACL rules
- [Low] At this commit ice_acl_add_rule_ethtool() formats an ACL entry
  but never programs it into the ACL TCAM, discards the handle returned…
- [Low] At this commit the ACL flow entry created by ice_flow_add_entry()
  is unreachable: for ICE_BLK_ACL it is deliberately not linked onto…
- [Low] ice_flow_rem_entry_sync() ignores the return value of
  ice_flow_acl_free_act_cntr() and then frees entry->acts, discarding…

--

ice: create ACL entry

This adds the ACL entry creation path: the ethtool ACL add helper now
builds an action (drop or forward to queue), formats a TCAM key from the
ethtool flow spec, and programs the ACL profile extraction sequence.
ice_flow_add_entry() gains an action array and a new ICE_BLK_ACL case.

A few questions below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> index db8137e6f8706..6313d511398a2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c

[ ... ]

> @@ -207,6 +210,111 @@ static int ice_acl_prof_add_ethtool(struct ice_pf *pf,

[ ... ]

> +/**
> + * ice_acl_comp_rules - compare two ACL filters
> + * @a: first ACL filter
> + * @b: second ACL filter
> + *
> + * Return: true if a and b values and masks are identical, false otherwise
> + */
> +static bool
> +ice_acl_comp_rules(struct ice_ntuple_fltr *a, struct ice_ntuple_fltr *b)
> +{
> +	bool base_equal;
> +
> +	if (a->flow_type != b->flow_type)
> +		return false;
> +
> +	base_equal = a->ip.v4.dst_ip == b->ip.v4.dst_ip &&
> +		     a->ip.v4.src_ip == b->ip.v4.src_ip &&
> +		     a->mask.v4.dst_ip == b->mask.v4.dst_ip &&
> +		     a->mask.v4.src_ip == b->mask.v4.src_ip;

[Severity: Medium]
Should the value comparison here be done after applying the mask?

ice_acl_comp_rules() requires the raw values to be byte-identical, but
ice_flow_acl_frmt_entry_fld() turns every bit cleared in the mask into a
don't-care bit:

	if (use_mask) {
		tmp_m = (~data[mask++] & 0xff) << disp;
		dontcare[dst] |= tmp_m & 0xff;
	}

So these two rules differ only in mask-cleared bits and produce a
bit-identical TCAM key, yet ice_acl_is_dup_fltr() does not consider them
duplicates:

  ethtool -N ethX flow-type tcp4 dst-ip 10.0.0.1 m 0.0.0.255 action 1 loc 1
  ethtool -N ethX flow-type tcp4 dst-ip 10.0.0.2 m 0.0.0.255 action 1 loc 2

Later in the series, ice_flow_acl_find_scen_entry_cond() then matches the
existing scenario entry with memcmp(p->entry, e->entry, p->entry_sz) and
re-labels it with exist->id = e->id, so location 1 no longer has an entry
of its own.  A subsequent delete of location 1 goes through
ice_del_acl_ethtool() -> ice_flow_find_entry(hw, ICE_BLK_ACL, 1), which
finds nothing, so that filter can no longer be removed.  Is that the
intended behaviour, and does the kerneldoc claim of "identical match
criteria" hold given the don't-care handling above?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index 0c088e6261438..f67b6e1c0ffbf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c

[ ... ]

> @@ -2037,28 +2037,36 @@ ice_update_ring_dest_vsi(struct ice_vsi *vsi, u16 *dest_vsi, u32 *ring)
>  	if (!vsi || !fsp || !input)
>  		return -EINVAL;
>  
> +	if (blk == ICE_BLK_FD)
> +		flow_mask = FLOW_EXT;
> +	else if (blk == ICE_BLK_ACL)
> +		flow_mask = FLOW_MAC_EXT;
> +	else
> +		return -EINVAL;
> +

[Severity: Medium]
Is FLOW_MAC_EXT the right bit to strip for the ACL block?

ice_add_ntuple_ethtool() rejects FLOW_MAC_EXT before the ACL path is ever
reached:

	if (fsp->flow_type & FLOW_MAC_EXT)
		return -EINVAL;

so for ICE_BLK_ACL the mask can never clear a bit that is set, while
FLOW_EXT stays in flow_type.

> @@ -2085,7 +2094,7 @@ ice_ntuple_set_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
>  
>  	input->fltr_id = fsp->location;
>  	input->q_index = q_index;
> -	flow_type = fsp->flow_type & ~FLOW_EXT;
> +	flow_type = fsp->flow_type & ~flow_mask;

Can an ACL add with FLOW_EXT set still succeed after this change?  With
something like:

  ethtool -N ethX flow-type tcp4 dst-ip 10.0.0.0 m 0.0.0.255 vlan 5 action 1

ethtool sets FLOW_EXT, ice_is_acl_filter() (which uses & ~FLOW_EXT) returns
true because the IP mask is partial, ice_acl_prof_add_ethtool() succeeds
and records hw->acl_prof[fltr_type]->seg, and then flow_type here still
carries FLOW_EXT, so ice_ethtool_flow_to_fltr() and the closing switch in
this function hit:

	default:
		/* not doing un-parsed flow types */
		return -EINVAL;

The request is rejected after the profile has already been created.  Every
other ACL decode site (ice_is_acl_filter(), ice_acl_prof_add_ethtool(), and
the ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT) call in
ice_acl_add_rule_ethtool()) strips FLOW_EXT instead.  Would masking both,
~(FLOW_EXT | FLOW_MAC_EXT), be what is wanted here?  Note that simply
stripping FLOW_EXT would silently ignore the VLAN match the user asked
for, so the ACL path may need an explicit decision rather than a different
mask.

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> index e42367853253f..192569ff1d6c1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c

[ ... ]

> +/**
> + * ice_flow_acl_disassoc_scen - Disassociate the scenario from the profile
> + * @hw: pointer to the hardware structure
> + * @prof: pointer to flow profile
> + *
> + * Disassociate the scenario from the profile for the PF of the VSI.
> + *
> + * Return: 0 on success, negative on failure
> + */
> +static int ice_flow_acl_disassoc_scen(struct ice_hw *hw,
> +				      struct ice_flow_prof *prof)
> +{
> +	struct ice_aqc_acl_prof_generic_frmt buf = {};
> +	int err = 0;
> +	u8 prof_id;
> +
> +	err = ice_flow_get_hw_prof(hw, ICE_BLK_ACL, prof->id, &prof_id);
> +	if (err)
> +		return err;
> +
> +	err = ice_query_acl_prof(hw, prof_id, &buf, NULL);
> +	if (err)
> +		return err;
> +
> +	/* Clear scenario for this PF */
> +	buf.pf_scenario_num[hw->pf_id] = ICE_ACL_INVALID_SCEN;
> +	return ice_prgm_acl_prof_xtrct(hw, prof_id, &buf, NULL);
> +}

[Severity: Medium]
What serializes this query-modify-program sequence against the sibling PFs
of the same device?

struct ice_aqc_acl_prof_generic_frmt carries
pf_scenario_num[ICE_AQC_ACL_PROF_PF_SCEN_NUM_ELEMS], one byte per physical
function, so this profile entry is device global.  Both this function and
ice_flow_acl_set_xtrct_seq() below read the whole entry, change only their
own byte (and, on first use, the byte/word/dword selections and the entire
pf_scenario_num array), and write the whole entry back.

The only lock held on the add side is hw->fl_profs_locks[blk], which is
private to one driver instance.  rtnl_lock does not cover the other PF
either, since a reset/rebuild runs from the service task:

ice_reset_subtask()
  ice_rebuild(pf, reset_type)

Can two PFs racing here lose an update, leaving another PF's profile
pointing at a wrong or invalid scenario, or resurrecting an association
that PF just cleared?  The driver already has a cross-function primitive
for shared table updates in ice_acquire_change_lock() /
ice_acquire_res(ICE_CHANGE_LOCK_RES_ID); should these two transactions use
it?

[ ... ]

> +static int ice_flow_acl_set_xtrct_seq(struct ice_hw *hw,
> +				      struct ice_flow_prof *prof)
> +{

[ ... ]

> +	/* Update the current PF */
> +	buf.pf_scenario_num[hw->pf_id] = (u8)prof->cfg.scen->id;
> +	return ice_prgm_acl_prof_xtrct(hw, prof_id, &buf, NULL);
> +}

[ ... ]

> +static int ice_flow_acl_check_actions(struct ice_hw *hw,
> +				      struct ice_flow_action *acts, u8 acts_cnt,
> +				      bool *cnt_alloc)
> +{

[ ... ]

> +	/* Checks if ACL counters are needed. */
> +	for (int i = 0; i < acts_cnt; i++) {
> +		if (ice_flow_acl_is_cntr_act(acts[i].type)) {
> +			struct ice_acl_cntrs cntrs = { 0 };
> +			int err;
> +
> +			cntrs.amount = 1;
> +			cntrs.bank = 0; /* Only bank0 for the moment */
> +
> +			if (acts[i].type == ICE_FLOW_ACT_CNTR_PKT_BYTES)
> +				cntrs.type = ICE_AQC_ACL_CNT_TYPE_DUAL;
> +			else
> +				cntrs.type = ICE_AQC_ACL_CNT_TYPE_SINGLE;
> +
> +			err = ice_aq_alloc_acl_cntrs(hw, &cntrs, NULL);
> +			if (err)
> +				return err;

[Severity: Medium]
Does this return leak the ACL counters allocated by earlier iterations?

ICE_FLOW_ACL_MAX_NUM_ACT is 2 and dup_check only rejects two actions of the
same type, so an array such as {ICE_FLOW_ACT_CNTR_PKT,
ICE_FLOW_ACT_CNTR_BYTES} performs two ice_aq_alloc_acl_cntrs() calls.  If
the second one fails, the counter allocated for acts[0] is still owned by
hardware when the error is returned.

The caller cannot compensate, because the propagation happens before the
label that has the rollback:

	err = ice_flow_acl_check_actions(hw, acts, acts_cnt, &cnt_alloc);
	if (err)
		return err;
	...
out:
	...
	if (err) {
		...
		if (cnt_alloc)
			ice_flow_acl_free_act_cntr(hw, acts, acts_cnt);
	}

Bank 0 only has 4 single or 2 dual counters, and nothing reclaims them
short of a reset.  No in-tree caller requests counter actions yet
(ice_acl_main.c builds only drop and forward-to-queue with
ICE_ACL_NUM_ACT == 1), so this is latent today.

> +/**
> + * ice_flow_acl_frmt_entry_range - Format an ACL range checker for a given field

[ ... ]

> +static void
> +ice_flow_acl_frmt_entry_range(u16 fld, struct ice_flow_fld_info *info,
> +			      struct ice_aqc_acl_profile_ranges *range_buf,
> +			      u8 *data, u8 *range)
> +{
> +	u16 new_mask, offset_val;
> +
> +	/* If not specified, default mask is all bits in field */
> +	memcpy(&offset_val, data + info->src.mask, sizeof(offset_val));
> +	new_mask = (info->src.mask == ICE_FLOW_FLD_OFF_INVAL ?
> +		    BIT(ice_flds_info[fld].size) - 1 : offset_val) <<
> +		   info->xtrct.disp;

[Severity: Medium]
Can this read past the end of the match buffer?

The memcpy() runs before the ICE_FLOW_FLD_OFF_INVAL test in the ternary
that follows, so in exactly the "mask not specified" case it performs:

	memcpy(&offset_val, data + 0xffff, 2);

ICE_FLOW_FLD_OFF_INVAL is 0xffff, and data is the kzalloc'ed struct
ice_ntuple_fltr passed down from ice_acl_add_rule_ethtool() through
ice_flow_acl_frmt_entry(), so that is a 2-byte read 64 KB past the end of
a small slab object.

The sibling helper added in the same patch guards first:

	if (mask != ICE_FLOW_FLD_OFF_INVAL)
		use_mask = true;

Would hoisting the sentinel check above the memcpy() here be equivalent?
No in-tree ACL profile builder creates ICE_FLOW_FLD_TYPE_RANGE fields
today (ice_acl_set_ip4_addr_seg() and ice_acl_set_ip4_port_seg() pass
range == false), so this looks latent rather than reachable from userspace.

[ ... ]

> +static int ice_flow_acl_frmt_entry(struct ice_hw *hw,
> +				   struct ice_flow_prof *prof,
> +				   struct ice_flow_entry *e, u8 *data,
> +				   struct ice_flow_action *acts, u8 acts_cnt)
> +{

[ ... ]

> +	/* Set don't care mask to all 1's to start, will zero out used bytes */
> +	memset(dontcare, 0xff, buf_sz);

[ ... ]

> +	buf[prof->cfg.scen->pid_idx] = (u8)prof_id;
> +	dontcare[prof->cfg.scen->pid_idx] = 0;
> +
> +	/* Format the buffer for direction flags */
> +	dir_flag_msk = BIT(ICE_FLG_PKT_DIR);
> +
> +	if (prof->dir == ICE_FLOW_RX)
> +		buf[prof->cfg.scen->pkt_dir_idx] = dir_flag_msk;

[Severity: Medium]
Should dontcare[prof->cfg.scen->pkt_dir_idx] be cleared here too?

dontcare was pre-filled with 0xff, and pid_idx and rng_chk_idx get their
mask bytes assigned, but pkt_dir_idx does not.  The dontcare buffer is
passed to ice_set_key() as the dc argument, and ice_gen_key_word()
wildcards every bit set there:

	if (ice_gen_key_word(val[i], upd ? upd[i] : 0xff,
			     dc ? dc[i] : 0, nm ? nm[i] : 0,
			     key + off + i, key + half_size + off + i))

The byte at scen->pkt_dir_idx is a real match byte: ice_acl_create_scen()
wires the TCAM byte at ICE_ACL_SCEN_PKT_DIR_IDX_IN_TCAM to
ICE_AQC_ACL_BYTE_SEL_BASE_PKT_DIR and then computes scen->pkt_dir_idx from
it.  So is the direction value written above simply discarded, and does
the entry then also match the other direction and arbitrary values of the
other flag bits in that byte?  The dir_flag_msk name suggests the intent
was dontcare[pkt_dir_idx] = ~dir_flag_msk.

> @@ -2004,6 +2607,7 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
>  	if (status)
>  		goto out;
>  
> +	INIT_LIST_HEAD(&e->l_entry);
>  	e->id = entry_id;
>  	e->vsi_handle = vsi_handle;
>  	e->prof = prof;
> @@ -2013,20 +2617,32 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
>  	case ICE_BLK_FD:
>  	case ICE_BLK_RSS:
>  		break;
> +	case ICE_BLK_ACL:
> +		/* ACL will handle the entry management */
> +		status = ice_flow_acl_frmt_entry(hw, prof, e, (u8 *)data, acts,
> +						 acts_cnt);
> +		if (status)
> +			goto out;
> +		break;

[Severity: Medium]
What keeps prof alive across this call?

ice_flow_add_entry() drops hw->fl_profs_locks[blk] right after
ice_flow_assoc_prof() and then keeps using the raw prof pointer.  The new
ACL branch does a lot of work with it: ice_flow_acl_frmt_entry()
dereferences prof->id, prof->cfg.scen->width, prof->cfg.scen->pid_idx,
prof->cfg.scen->pkt_dir_idx, prof->cfg.scen->rng_chk_idx, prof->segs[] and
prof->dir, plus several allocations and AdminQ commands.

Meanwhile ice_flow_rem_prof_sync() can take that same profile list lock and
free the profile:

		clear_bit(prof->id, hw->blk[blk].prof_id.id);
		list_del(&prof->l_entry);
		mutex_destroy(&prof->entries_lock);
		devm_kfree(ice_hw_to_dev(hw), prof);

ACL profile teardown also runs from the service task, without rtnl_lock,
via ice_reset_subtask() -> ice_rebuild(), and the new entry is not
registered anywhere yet, so removal cannot see it and cannot wait for it.
Using prof after the unlock predates this patch (the FD and RSS paths
re-take prof->entries_lock afterwards), but this widens the window and the
set of prof fields touched considerably.  Would holding the profile list
lock until the entry is registered, or taking a reference on the profile,
be preferable?

> @@ -1957,6 +2211,349 @@ int ice_flow_rem_prof(struct ice_hw *hw, enum ice_block blk, u64 prof_id)

[ ... ]

> @@ -216,12 +324,65 @@ static int ice_acl_prof_add_ethtool(struct ice_pf *pf,
>   */
>  int ice_acl_add_rule_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
>  {
> +	struct ice_flow_action acts[ICE_ACL_NUM_ACT];
>  	struct ethtool_rx_flow_spec *fsp;
> +	struct ice_acl_hw_prof *hw_prof;
> +	struct ice_ntuple_fltr *input;
> +	enum ice_fltr_ptype flow;
> +	struct device *dev;
>  	struct ice_pf *pf;
> +	struct ice_hw *hw;
> +	u64 entry_h = 0;
> +	int err;
>  
>  	pf = vsi->back;
> +	hw = &pf->hw;
> +	dev = ice_pf_to_dev(pf);
>  
>  	fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
>  
> -	return ice_acl_prof_add_ethtool(pf, fsp);
> +	err = ice_acl_prof_add_ethtool(pf, fsp);
> +	if (err)
> +		return err;
> +
> +	/* Add new rule */
> +	input = kzalloc_obj(*input);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	err = ice_ntuple_set_input_set(vsi, ICE_BLK_ACL, fsp, input);
> +	if (err)
> +		goto free_input;
> +
> +	mutex_lock(&hw->fdir_fltr_lock);
> +	if (ice_acl_is_dup_fltr(hw, input)) {
> +		mutex_unlock(&hw->fdir_fltr_lock);
> +		err = -EINVAL;
> +		goto free_input;
> +	}
> +	mutex_unlock(&hw->fdir_fltr_lock);
> +
> +	memset(&acts, 0, sizeof(acts));
> +	if (fsp->ring_cookie == RX_CLS_FLOW_DISC)
> +		ice_acl_set_act_drop(&acts[0]);
> +	else
> +		ice_acl_set_act_fwd_queue(&acts[0], input->q_index);
> +
> +	flow = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
> +	hw_prof = hw->acl_prof[flow];
> +
> +	err = ice_flow_add_entry(hw, ICE_BLK_ACL, hw_prof->prof_id,
> +				 fsp->location, vsi->idx, ICE_FLOW_PRIO_NORMAL,
> +				 input, acts, ICE_ACL_NUM_ACT, &entry_h);
> +	if (err) {
> +		dev_err(dev, "Could not add flow entry %d\n", flow);
> +		goto free_input;
> +	}
> +
> +	return 0;
> +
> +free_input:
> +	kfree(input);
> +
> +	return err;
>  }

[Severity: Medium]
Why is hw->fdir_fltr_lock dropped between the duplicate check and
the hardware programming?

ice_acl_is_dup_fltr() walks hw->fdir_list_head under the lock, but the
lock is released immediately afterwards and the decision is then acted
on without it: ice_flow_add_entry() formats the key, allocates the TCAM
entry and programs it, and only later (in the final form of this
function) is the lock re-taken for ice_ntuple_update_list_entry() to
publish the filter on hw->fdir_list_head.  Between the check and that
insertion nothing prevents a second caller from observing the same
list state, concluding "not a duplicate", and programming a second
scenario entry with identical match data.  The result is two TCAM
entries for one rule, in a resource the driver cannot easily reclaim,
plus the entry-matching logic later in the series keying off identical
keys.

In practice the ethtool ioctl path runs under rtnl_lock, so this may be
unreachable from concurrent ethtool -N today, but then the check-then-
act split buys nothing and hides the real serialization.  The Flow
Director side keeps the lock held across the dup check and the list
update; is there a reason the ACL path cannot do the same, i.e. hold
fdir_fltr_lock from ice_acl_is_dup_fltr() through
ice_ntuple_update_list_entry()?  If the AdminQ work in
ice_flow_add_entry() cannot run under that mutex, please say so in the
commit message and state what actually guarantees exclusion here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917183927.2692068-1-anthony.l.nguyen%40intel.com
