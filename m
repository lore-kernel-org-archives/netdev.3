Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955F3D647A
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020643; cv=none; b=U6neWkD9bYZhbiyPqcohfGUk5n5N3XwIZmaWUIb78vPyy05JJP3kSyD0Qf6RNkw+cjCYKU9K39cR2z+31FrEZtgbsDf2VA8jaNguChTKJHjkyPnsJK8qOXvtjIf6y7Ti4dXg+R1xYrNj6U95yPIR7PzF2yvN+yKabfY0tiXD5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020643; c=relaxed/simple;
	bh=46EPxSkZz9L5z0r3WnPbG9vyBiqqo0K2apd00cgTaBU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHdXPXhtHHgMgTJrO+hnuX3OTYebVJfg+rcUUGEBb0J8nUdTxGxj7lNRlGWF7yJCPiBl9P8FnaDXKPy4tc3g2yI5f8bzAF/DD2jISS+ZWUemQs+zKoclo0bOkEwh20Gighi+66r4cUgt2nSld6/66ki8lKxRM6JIgWfg4qBDMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkzwFrkF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkzwFrkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665C01F00893;
	Mon, 21 Sep 2026 19:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020640;
	bh=4A7avrB0FIF1qb3CV+V6wZY1RMBCq2mEZSR3UGULAWQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bkzwFrkFqVSFDG4bOYjcP4LPBN8/P61l1e81Eg30t81G3Uduu9sU4dTQsl67ZU6SV
	 BgzP+vwI30AJyXv1rOLvPkOab9WAQvNGUB84WETQQn85wU10VrR8MPRANrKm7t5H7c
	 TGRKbp3u/wbffK6OkWsfTGEJ9+PGNPbXrydJFj9LhPOAQq0BagAc33COHs2LcRFAmE
	 rgWwhnDrX79C/PoP6nRR8BScfASu/M5g0WfZvfjxqMd+YipaFB1dx+zW4/+caaujoh
	 FMZnHUxyDyVBxwUfLw9BKwuaveiT8yj8oE+fiIqASmYPRunG6bi0E/XT0Li32FqKwz
	 cpLJAD/QUdYJA==
Subject: Re: [PATCH net-next v2 04/12] ice: initialize ACL scenario
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, marcin.szycik@linux.intel.com,
 aleksandr.loktionov@intel.com, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 19:57:18 +0000
Message-ID: <179002063894.2160803.5462702618092825022@kernel.org>
In-Reply-To: <20260917183927.2692068-5-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-5-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 14 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 10

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ice: unprotected list traversal in ice_acl_destroy_scen
- [Medium] In ice_acl_alloc_partition()
  (drivers/net/ethernet/intel/ice/ice_acl_ctrl.c) the contiguous-chunk…
- [Medium] ice_fdir_del_all_fltrs() is changed here to skip every filter
  with acl_fltr set ('if (f_rule->acl_fltr) continue;'), removing ACL…
- [Medium] ice_acl_destroy_tbl() declares 'struct ice_aqc_acl_scen buf;'
  without initialization and hands it to ice_aq_query_acl_scen().
- [Low] ice_ntuple_get_max_fltr_cnt()
  (drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c) unconditionally…
- [Low] The ACL table and its scenario are programmed into the device
  only from ice_acl_create_hw() at probe (ice_init_features() ->…
- [Low] ice_adminq_cmd.h documents opcodes 0x0C1B and 0x0C23 as 'direct'
  commands above struct ice_aqc_acl_update_query_scen, while the…
- [Low] The kernel-doc added for ice_aq_dealloc_acl_scen() describes
  '@scen_id: scen_id to be deallocated (input and output field)', but…
- [Low] The worked example in the comment of ice_acl_tbl_calc_end_idx()
  (drivers/net/ethernet/intel/ice/ice_acl_ctrl.c) contradicts the…
- [Low] ice_acl_commit_partition()'s kernel-doc reads '@commit: true if
  the partition is being commit', but the true branch calls set_bit(b,…
- [Low] In ice_acl_alloc_partition(), after advancing to the next row
  ('row = dir > 0 ?
- [Low] ice_acl_create_scen() derives first_tcam/last_tcam from
  scen->start/scen->end and uses them to index…
- [Low] ice_acl_destroy_tbl() as introduced by this patch gained three
  early 'return err' paths (ice_aq_query_acl_scen(),…
- [Low] ice: dangerous modification of loop control variable in
  ice_acl_rem_flows

--

ice: initialize ACL scenario

This completes ACL table initialization by allocating and programming an
initial scenario, adds the AQ wrappers for scenario alloc/dealloc/update/
query, and extends the ntuple filter accounting and reporting to cover ACL
filters.

A few questions below about the new scenario code, the teardown path and
some of the new comments.

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl.c b/drivers/net/ethernet/intel/ice/ice_acl.c
> index 1c9ae47d9efc1..7821ca247c829 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl.c
> @@ -134,3 +134,119 @@ int ice_aq_program_actpair(struct ice_hw *hw, u8 act_mem_idx, u16 act_entry_idx,

[ ... ]

> +/**
> + * ice_aq_dealloc_acl_scen - deallocate ACL scenario
> + * @hw: pointer to the HW struct
> + * @scen_id: scen_id to be deallocated (input and output field)

[Severity: Low]
Is scen_id really an output field here?  It is passed by value as a u16 in
ice_aq_dealloc_acl_scen(), so nothing can be written back to the caller:

int ice_aq_dealloc_acl_scen(struct ice_hw *hw, u16 scen_id,
			    struct ice_sq_cd *cd)

The header comment added for struct ice_aqc_acl_dealloc_scen in the same
patch says the opposite, "nothing to be returned as a response except
status".

> + * @cd: pointer to command details structure or NULL
> + *
> + * Deallocate ACL scenario (direct 0x0C15)
> + *
> + * Return: 0 on success, negative on error
> + */
> +int ice_aq_dealloc_acl_scen(struct ice_hw *hw, u16 scen_id,
> +			    struct ice_sq_cd *cd)
> +{
> +	struct ice_aqc_acl_dealloc_scen *cmd;
> +	struct libie_aq_desc desc;
> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_dealloc_acl_scen);
> +	cmd = libie_aq_raw(&desc);
> +	cmd->scen_id = cpu_to_le16(scen_id);
> +
> +	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> index 9984c07b53f0d..6a60da3034cf2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> @@ -6,6 +6,80 @@
>  /* Determine the TCAM index of entry 'e' within the ACL table */
>  #define ICE_ACL_TBL_TCAM_IDX(e) ((e) / ICE_AQC_ACL_TCAM_DEPTH)
>  

[ ... ]

> +static u16 ice_acl_tbl_calc_end_idx(u16 start, u16 num_entries, u16 width)
> +{
> +	u16 end_idx, add_entries = 0;
> +
> +	end_idx = start + (num_entries - 1);
> +
> +	/* In case that our ACL partition requires cascading TCAMs */
> +	if (width > 1) {
> +		u16 num_stack_level;
> +
> +		/* Figure out the TCAM stacked level in this ACL scenario */
> +		num_stack_level = (start % ICE_AQC_ACL_TCAM_DEPTH) +
> +			num_entries;
> +		num_stack_level = DIV_ROUND_UP(num_stack_level,
> +					       ICE_AQC_ACL_TCAM_DEPTH);
> +
> +		/* In this case, each entries in our ACL partition span
> +		 * multiple TCAMs. Thus, we will need to add
> +		 * ((width - 1) * num_stack_level) TCAM's entries to
> +		 * end_idx.
> +		 *
> +		 * For example : In our case, our scenario is 2x2:
> +		 *	[TCAM 0]	[TCAM 1]
> +		 *	[TCAM 2]	[TCAM 3]
> +		 * Assuming that a TCAM will have 512 entries. If "start"
> +		 * is 500, "num_entries" is 3 and "width" = 2, then end_idx
> +		 * should be 1024 (belongs to TCAM 2).
> +		 * Before going to this if statement, end_idx will have the
> +		 * value of 512. If "width" is 1, then the final value of
> +		 * end_idx is 512. However, in our case, width is 2, then we
> +		 * will need add (2 - 1) * 1 * 512. As result, end_idx will
> +		 * have the value of 1024.
> +		 */

[Severity: Low]
Do the numbers in this example match what the function computes?

For start = 500, num_entries = 3, width = 2:

	end_idx = 500 + (3 - 1)			= 502	(comment says 512)
	num_stack_level = DIV_ROUND_UP(500 % 512 + 3, 512) = 1
	add_entries = (2 - 1) * 1 * 512		= 512
	return 502 + 512			= 1014	(comment says 1024)

Since ice_acl_create_scen() derives last_tcam = ICE_ACL_TBL_TCAM_IDX(scen->end),
1014 maps to TCAM 1, not TCAM 2 as the comment states.  Could the example be
adjusted to the values the code actually produces?

> +		add_entries = (width - 1) * num_stack_level *
> +			ICE_AQC_ACL_TCAM_DEPTH;
> +	}
> +
> +	return end_idx + add_entries;
> +}
> +
>  /**
>   * ice_acl_init_tbl - initialize ACL table
>   * @hw: pointer to the hardware structure
> @@ -288,6 +362,467 @@ int ice_acl_create_tbl(struct ice_hw *hw, struct ice_acl_tbl_params *params)
>  	return err;
>  }
>  
> +/**
> + * ice_acl_alloc_partition - Allocate a partition from the ACL table
> + * @hw: pointer to the hardware structure
> + * @req: info of partition being allocated
> + *
> + * Returns: 0 on success, negative on error
> + */
> +static int ice_acl_alloc_partition(struct ice_hw *hw, struct ice_acl_scen *req)
> +{
> +	u16 start = 0, cnt = 0, off = 0;
> +	u16 width, r_entries;
> +	bool done = false;
> +	int row;
> +	int dir;

[ ... ]

> +		if (cnt >= r_entries) {
> +			req->start = start;
> +			req->num_entry = r_entries;
> +			req->end = ice_acl_tbl_calc_end_idx(start, r_entries,
> +							    width);
> +			break;
> +		}
> +
> +		row = dir > 0 ? row + width : row - width;
> +		if (row < 0)
> +			return -EINVAL;

[Severity: Low]
Should a negative row here abort the search, or should it be treated the
same way as "all rows have been checked" and fall into the off++ branch
below?

For the upward scan (width > 1) with first_tcam = 0, last_tcam = 5 and
width = 3, the sequence is:

	row = 3		scanned
	row = 0		scanned
	row = -3	return -EINVAL

while off = 1 would still have yielded the valid row 2, so the multi-pass
search described in the comment above is cut short.  The caller chain
ice_acl_create_scen() -> ice_acl_create_hw() also gets -EINVAL for what is
an out-of-space condition.  The same unconditional return appears again
inside the off++ branch.

> +
> +		if (row > hw->acl_tbl->last_tcam ||
> +		    row < hw->acl_tbl->first_tcam) {
> +			/* All rows have been checked. Increment 'off' that
> +			 * will help yield a different TCAM configuration in
> +			 * which adjacent TCAMs can be alternatively in the
> +			 * same row.
> +			 */
> +			off++;
> +
> +			/* However, if the new 'off' value yields previously
> +			 * checked configurations, then exit.
> +			 */
> +			if (off >= width) {
> +				done = true;
> +			} else {
> +				row = dir > 0 ? off :
> +					hw->acl_tbl->last_tcam + 1 - off -
> +					width;
> +				if (row < 0)
> +					return -EINVAL;
> +			}
> +		}
> +	} while (!done);

[Severity: Medium]
Can cnt survive across passes here and describe a partition that is not
contiguous?

cnt is declared once outside the do/while and is only reset when an
unavailable chunk is found:

	if (!avail) {
		cnt = 0;
	} else {
		...
		cnt += ICE_ACL_ENTRY_ALLOC_UNIT;
	}

When the pass ends on a row that contributed chunks, the off++ branch
restarts the scan at a different, non-adjacent row without clearing cnt,
so chunks from the new row are added to the leftover count and the

	if (cnt >= r_entries) {
		req->start = start;
		req->num_entry = r_entries;

path can accept a partition spanning chunks that are neither contiguous
nor all free.  ice_acl_commit_partition() then clears 'avail' bits and
ice_acl_set_scen_chnk_msk() programs chnk_msk for chunks belonging to
another scenario.

The single in-tree caller (ice_acl_create_hw() with match_width 15 and a
table whose TCAM count equals the scenario width) always succeeds on the
first row, so this looks latent today, but ice_acl_create_scen() is
exported in ice_acl.h.  Should cnt be reset when a new pass starts?

The same off++ branch also recomputes row without re-checking
row >= hw->acl_tbl->first_tcam.

> +
> +	return cnt >= r_entries ? 0 : -ENOSPC;
> +}

[ ... ]

> +/**
> + * ice_acl_commit_partition - Indicate if the specified partition is active
> + * @hw: pointer to the hardware structure
> + * @scen: pointer to the scenario struct
> + * @commit: true if the partition is being commit
> + */
> +static void ice_acl_commit_partition(struct ice_hw *hw,
> +				     struct ice_acl_scen *scen, bool commit)
> +{

[Severity: Low]
Is the documented polarity of @commit inverted?  The true branch does

	if (commit)
		set_bit(b, hw->acl_tbl->avail);
	else
		clear_bit(b, hw->acl_tbl->avail);

and struct ice_acl_tbl documents 'avail' as "Keep track of available
64-entry chunks in TCAMs", so commit == true marks the chunks free again.
That matches the call sites, where ice_acl_create_scen() passes false
after a successful allocation and ice_acl_destroy_scen() passes true while
tearing the scenario down, but not the kernel-doc.

> +	u16 tcam_idx, off, num_cscd, units;

[ ... ]

> +int ice_acl_create_scen(struct ice_hw *hw, u16 match_width, u16 num_entries,
> +			u16 *scen_id)
> +{
> +	u8 cascade_cnt, first_tcam, last_tcam, i, k;
> +	struct ice_aqc_acl_scen scen_buf = {};
> +	struct ice_acl_scen *scen;
> +	int err;
> +
> +	if (match_width > ICE_ACL_MAX_WIDTH_BYTES)
> +		return -EINVAL;

[ ... ]

> +	/* Determine the number of cascade TCAMs, given the scenario's width */
> +	cascade_cnt = DIV_ROUND_UP(scen->width, ICE_AQC_ACL_KEY_WIDTH_BYTES);
> +	first_tcam = ICE_ACL_TBL_TCAM_IDX(scen->start);
> +	last_tcam = ICE_ACL_TBL_TCAM_IDX(scen->end);

[Severity: Low]
Would it be worth bounding first_tcam/last_tcam before they are used to
index scen_buf.tcam_cfg[ICE_AQC_ACL_SLICES]?  They are derived from
scen->start/scen->end, which in turn come from ice_acl_alloc_partition()
and from num_entries, and num_entries is not validated:

	r_entries = ALIGN(req->num_entry, ICE_ACL_ENTRY_ALLOC_UNIT);

For num_entry == 0, ice_acl_tbl_calc_end_idx() evaluates
start + (0 - 1) in u16 and last_tcam becomes 127, which would index past
the 16-element tcam_cfg[] array on the stack.  Similarly,
ice_acl_alloc_partition() and ice_acl_commit_partition() build

	b = (w * ICE_AQC_MAX_TCAM_ALLOC_UNITS) + p;

from the firmware-supplied first_tcam/last_tcam and pass it to
test_bit()/set_bit()/clear_bit() on the 128-bit 'avail' bitmap without a
range check.

The only caller today is ice_acl_create_hw(), which always passes depth
512 or 256, so this is a hardening question rather than a reachable path.

> +
> +	/* For each scenario, we reserved last three bytes of scenario width for
> +	 * packet direction flag, profile ID and range checker. Thus, we want to
> +	 * return back to the caller the eff_width, pkt_dir_idx, rng_chk_idx and
> +	 * pid_idx.
> +	 */

[ ... ]

>  /**
>   * ice_acl_destroy_tbl - Destroy a previously created LEM table for ACL
>   * @hw: pointer to the HW struct
> @@ -296,12 +831,50 @@ int ice_acl_create_tbl(struct ice_hw *hw, struct ice_acl_tbl_params *params)
>   */
>  int ice_acl_destroy_tbl(struct ice_hw *hw)
>  {
> +	struct ice_acl_scen *pos_scen, *tmp_scen;
>  	struct ice_aqc_acl_generic resp_buf;
> +	struct ice_aqc_acl_scen buf;
>  	int err;

[Severity: Medium]
Does this expose uninitialized stack bytes to the device?  buf is not
initialized here, unlike scen_buf in ice_acl_create_scen() which uses
"= {}", and ice_sq_send_cmd() copies the caller buffer into the DMA-mapped
AQ buffer for every indirect command regardless of direction:

drivers/net/ethernet/intel/ice/ice_controlq.c:ice_sq_send_cmd() {
	/* if buf is not NULL assume indirect command */
	if (buf) {
		dma_buf = &cq->sq.r.sq_bi[cq->sq.next_to_use];
		/* copy the user buf into the respective DMA buf */
		memcpy(dma_buf->va, buf, buf_size);
	...
}

so roughly 132 bytes of stack become visible to firmware on the
ice_aq_query_acl_scen() call below.

On completion only the firmware-reported length is copied back:

	u16 copy_size = le16_to_cpu(desc->datalen);

	if (copy_size > buf_size) {
		...
	} else {
		memcpy(buf, dma_buf->va, copy_size);
	}

Since the disable loop below only rewrites chnk_msk, start_cmp_set and
act_mem_cfg, a short-but-successful response would leave stack residue in
tcam_cfg[].tcam_select[], which ice_aq_update_acl_scen() then programs
back into the scenario.  Would "struct ice_aqc_acl_scen buf = {};" be
appropriate?

>  
>  	if (!hw->acl_tbl)
>  		return -ENOENT;
>  
> +	/* Mark all the created scenario's TCAM to stop the packet lookup and
> +	 * delete them afterward
> +	 */
> +	list_for_each_entry_safe(pos_scen, tmp_scen, &hw->acl_tbl->scens,
> +				 list_entry) {
> +		err = ice_aq_query_acl_scen(hw, pos_scen->id, &buf, NULL);
> +		if (err) {
> +			ice_debug(hw, ICE_DBG_ACL, "ice_aq_query_acl_scen() failed. status: %d\n",
> +				  err);
> +			return err;
> +		}

[Severity: Low]
Do these three new early returns leak the struct ice_acl_tbl allocation?
They return before ice_aq_dealloc_acl_tbl() and before the
kfree(hw->acl_tbl) / hw->acl_tbl = NULL at the end of the function, and
both callers (ice_deinit_acl() and the destroy_table unwind in
ice_acl_create_hw()) discard the return value, so a single AQ error during
unload leaves hw->acl_tbl set and the firmware resources allocated with no
retry.

This is addressed later in the series by "ice: add ACL reset recovery and
NTUPLE feature toggle", where ice_acl_destroy_tbl() becomes void, only
logs each AQ failure and always ends with kfree(hw->acl_tbl) followed by
hw->acl_tbl = NULL.  Could that cleanup ordering be used from the start?

> +
> +		for (int i = 0; i < ICE_AQC_ACL_SLICES; i++) {
> +			buf.tcam_cfg[i].chnk_msk = 0;
> +			buf.tcam_cfg[i].start_cmp_set =
> +					ICE_AQC_ACL_ALLOC_SCE_START_CMP;
> +		}
> +
> +		for (int i = 0; i < ICE_AQC_MAX_ACTION_MEMORIES; i++)
> +			buf.act_mem_cfg[i] = 0;
> +
> +		err = ice_aq_update_acl_scen(hw, pos_scen->id, &buf, NULL);
> +		if (err) {
> +			ice_debug(hw, ICE_DBG_ACL, "ice_aq_update_acl_scen() failed. status: %d\n",
> +				  err);
> +			return err;
> +		}
> +
> +		err = ice_acl_destroy_scen(hw, pos_scen->id);
> +		if (err) {
> +			ice_debug(hw, ICE_DBG_ACL, "deletion of scenario failed. status: %d\n",
> +				  err);
> +			return err;
> +		}
> +	}
> +
>  	err = ice_aq_dealloc_acl_tbl(hw, hw->acl_tbl->id, &resp_buf, NULL);
>  	if (err) {
>  		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of ACL failed. status: %d\n",
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index f98780afa1399..d28594eda14f7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -2071,6 +2073,33 @@ struct ice_aqc_acl_generic {
>  	u8 act_mem[ICE_AQC_MAX_ACTION_MEMORIES];
>  };
>  

[ ... ]

> +/* De-allocate ACL scenario (direct 0x0C15). This command doesn't need
> + * separate response buffer since nothing to be returned as a response
> + * except status.
> + */
> +struct ice_aqc_acl_dealloc_scen {
> +	__le16 scen_id;
> +	u8 reserved[14];
> +};
> +
>  /* Update ACL scenario (direct 0x0C1B)
>   * Query ACL scenario (direct 0x0C23)
>   */

[Severity: Low]
Are 0x0C1B and 0x0C23 direct commands?  The new code in ice_acl.c treats
both as indirect, passing a struct ice_aqc_acl_scen buffer and setting
LIBIE_AQ_FLAG_RD for the update case:

	return ice_aq_send_cmd(hw, &desc, buf, sizeof(*buf), cd);

and the kernel-doc added for the wrappers says "Update ACL scenario
(indirect 0x0C1B)" and "Query ACL scenario (indirect 0x0C23)".  The
struct's own addr_high/addr_low fields also suggest indirect, so should
this comment say indirect?

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index 516b57ff3b1ca..272b3d54f6e47 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> @@ -228,6 +228,24 @@ int ice_get_ethtool_fdir_entry(struct ice_hw *hw, struct ethtool_rxnfc *cmd)
>  	return ret;
>  }
>  
> +/**
> + * ice_ntuple_get_max_fltr_cnt - get max number of allowed filters
> + * @hw: hardware structure containing filter information
> + *
> + * Return: maximum number of allowed filters
> + */
> +u32 ice_ntuple_get_max_fltr_cnt(struct ice_hw *hw)
> +{
> +	int acl_cnt;
> +
> +	if (hw->dev_caps.num_funcs < 8)
> +		acl_cnt = ICE_AQC_ACL_TCAM_DEPTH / ICE_ACL_ENTIRE_SLICE;
> +	else
> +		acl_cnt = ICE_AQC_ACL_TCAM_DEPTH / ICE_ACL_HALF_SLICE;
> +
> +	return ice_get_fdir_cnt_all(hw) + acl_cnt;
> +}

[Severity: Low]
Should this check hw->acl_tbl before adding the ACL capacity?  ACL init is
explicitly non-fatal in ice_init_features():

	/* Note: ACL init failure is non-fatal to load */
	if (ice_init_acl(pf))
		dev_err(dev, "Failed to initialize ACL\n");

so when ice_acl_create_hw() fails, hw->acl_tbl stays NULL while this value
is still reported to user space as the rule table size for
ETHTOOL_GRXCLSRLCNT and ETHTOOL_GRXCLSRLALL (cmd->data) and used as the
only bound on fsp->location in ice_add_ntuple_ethtool().  User space then
sees 256 or 512 extra locations that can never be programmed.

The depth formula is also re-derived from ICE_ACL_ENTIRE_SLICE /
ICE_ACL_HALF_SLICE here rather than taken from the table/scenario geometry
that ice_acl_create_hw() obtained from firmware, so the two can drift.
Later patches in the series add an hw->acl_tbl test in
ice_add_ntuple_ethtool(), but this helper keeps the unconditional ACL term.

> +
>  /**
>   * ice_get_fdir_fltr_ids - fill buffer with filter IDs of active filters
>   * @hw: hardware structure containing the filter list

[ ... ]

> @@ -1654,8 +1713,11 @@ void ice_fdir_del_all_fltrs(struct ice_vsi *vsi)
>  	struct ice_hw *hw = &pf->hw;
>  
>  	list_for_each_entry_safe(f_rule, tmp, &hw->fdir_list_head, fltr_node) {
> +		if (f_rule->acl_fltr)
> +			continue;
> +
>  		ice_fdir_write_all_fltr(pf, f_rule, false);
> -		ice_ntuple_update_cntrs(hw, f_rule->flow_type, false);
> +		ice_ntuple_update_cntrs(hw, f_rule, false);
>  		list_del(&f_rule->fltr_node);
>  		devm_kfree(ice_pf_to_dev(pf), f_rule);
>  	}

[Severity: Medium]
Does skipping acl_fltr entries here leak the struct ice_ntuple_fltr
objects on driver unload?

This is the only walker of hw->fdir_list_head that unlinks and frees
filter nodes, and no ACL equivalent is added to the removal path.  At the
end of the series, device removal runs:

	ice_deinit_features()
	  ice_deinit_acl()		/* ice_acl_rem_flows(),
					   ice_acl_destroy_tbl(), frees
					   hw->acl_prof - no filter walk */
	  ice_deinit_fdir()
	    ice_vsi_manage_fdir()
	      ice_fdir_del_all_fltrs()	/* continues on acl_fltr */

while the new ice_acl_del_all_fltrs() is only reached from
ice_vsi_manage_acl() (ethtool -K ntuple off) and from the ice_rebuild()
failure branch.  Since "ice: use plain alloc/dealloc for ice_ntuple_fltr"
switched these nodes to kzalloc/kfree, every ACL rule present at unload
would be leaked and hw->ntuple_active_fltr_cnt / hw->acl_fltr_cnt[] never
decremented.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 981c105e1d3a2..952e6167517f4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4359,7 +4361,20 @@ static int ice_acl_create_hw(struct ice_pf *pf)
>  	params.concurr = false;
>  	params.num_dep_tbls = 0;
>  
> -	return ice_acl_create_tbl(hw, &params);
> +	err = ice_acl_create_tbl(hw, &params);
> +	if (err)
> +		return err;
> +
> +	err = ice_acl_create_scen(hw, params.width, params.depth, &scen_id);
> +	if (err)
> +		goto destroy_table;

[Severity: Low]
What happens to this table and scenario across a PF reset?  At this commit
ice_acl_create_hw() is only reachable from probe via ice_init_features()
-> ice_init_acl(), and ice_rebuild() replays Flow Director profiles and
filters but has no ACL re-creation, while ice_fdir_replay_fltrs() is
changed here to skip acl_fltr entries.  After a PFR/CORER/GLOBR the
software state (alloc ID, first/last TCAM, the 'avail' chunk bitmap, the
firmware scen_id) would describe hardware state that no longer exists.

This is closed later in the series by "ice: add ACL reset recovery and
NTUPLE feature toggle", which adds to ice_rebuild():

	if (test_bit(ICE_FLAG_ACL_ENA, pf->flags)) {
		ice_acl_destroy_tbl(hw);
		if (!ice_acl_create_hw(pf)) {

so this is only about the intermediate state within the series.

> +
> +	return 0;
> +
> +destroy_table:
> +	ice_acl_destroy_tbl(hw);
> +
> +	return err;
>  }

[ ... ]

> @@ -288,6 +362,467 @@ int ice_acl_create_tbl(struct ice_hw *hw, struct ice_acl_tbl_params *params)
>  	return err;
>  }
>  
> +/**
> + * ice_acl_alloc_partition - Allocate a partition from the ACL table
> + * @hw: pointer to the hardware structure
> + * @req: info of partition being allocated
> + *
> + * Returns: 0 on success, negative on error
> + */
> +static int ice_acl_alloc_partition(struct ice_hw *hw, struct ice_acl_scen *req)
> +{
> +	u16 start = 0, cnt = 0, off = 0;
> +	u16 width, r_entries;
> +	bool done = false;
> +	int row;
> +	int dir;
> +
> +	/* Determine the number of TCAMs each entry overlaps */
> +	width = DIV_ROUND_UP(req->width, ICE_AQC_ACL_KEY_WIDTH_BYTES);
> +
> +	/* Check if we have enough TCAMs to accommodate the width */
> +	if (width > hw->acl_tbl->last_tcam - hw->acl_tbl->first_tcam + 1)
> +		return -ENOSPC;
> +
> +	/* Number of entries must be multiple of ICE_ACL_ENTRY_ALLOC_UNIT's */
> +	r_entries = ALIGN(req->num_entry, ICE_ACL_ENTRY_ALLOC_UNIT);
> +
> +	/* To look for an available partition that can accommodate the request,
> +	 * the process first logically arranges available TCAMs in rows such
> +	 * that each row produces entries with the requested width. It then
> +	 * scans the TCAMs' available bitmap, one bit at a time, and
> +	 * accumulates contiguous available 64-entry chunks until there are
> +	 * enough of them or when all TCAM configurations have been checked.
> +	 *
> +	 * For width of 1 TCAM, the scanning process starts from the top most
> +	 * TCAM, and goes downward. Available bitmaps are examined from LSB
> +	 * to MSB.
> +	 *
> +	 * For width of multiple TCAMs, the process starts from the bottom-most
> +	 * row of TCAMs, and goes upward. Available bitmaps are examined from
> +	 * the MSB to the LSB.
> +	 *
> +	 * To make sure that adjacent TCAMs can be logically arranged in the
> +	 * same row, the scanning process may have multiple passes. In each
> +	 * pass, the first TCAM of the bottom-most row is displaced by one
> +	 * additional TCAM. The width of the row and the number of the TCAMs
> +	 * available determine the number of passes. When the displacement is
> +	 * more than the size of width, the TCAM row configurations will
> +	 * repeat. The process will terminate when the configurations repeat.
> +	 *
> +	 * Available partitions can span more than one row of TCAMs.
> +	 */
> +	if (width == 1) {
> +		row = hw->acl_tbl->first_tcam;
> +		dir = 1;
> +	} else {
> +		/* Start with the bottom-most row, and scan for available
> +		 * entries upward
> +		 */
> +		row = hw->acl_tbl->last_tcam + 1 - width;
> +		if (row < 0)
> +			return -EINVAL;
> +
> +		dir = -1;
> +	}
> +
> +	do {
> +		/* Scan all 64-entry chunks, one chunk at a time, in the
> +		 * current TCAM row
> +		 */
> +		for (u16 i = 0;
> +		     i < ICE_AQC_MAX_TCAM_ALLOC_UNITS && cnt < r_entries;
> +		     i++) {
> +			bool avail = true;
> +			u16 p;
> +
> +			/* Compute the cumulative available mask across the
> +			 * TCAM row to determine if the current 64-entry chunk
> +			 * is available.
> +			 */
> +			p = dir > 0 ? i : ICE_AQC_MAX_TCAM_ALLOC_UNITS - i - 1;
> +			for (u16 w = row; w < row + width && avail; w++) {
> +				u16 b;
> +
> +				b = (w * ICE_AQC_MAX_TCAM_ALLOC_UNITS) + p;
> +				avail &= test_bit(b, hw->acl_tbl->avail);
> +			}
> +
> +			if (!avail) {
> +				cnt = 0;
> +			} else {
> +				/* Compute the starting index of the newly
> +				 * found partition. When 'dir' is negative, the
> +				 * scan processes is going upward. If so, the
> +				 * starting index needs to be updated for every
> +				 * available 64-entry chunk found.
> +				 */
> +				if (!cnt || dir < 0)
> +					start = (row * ICE_AQC_ACL_TCAM_DEPTH) +
> +						(p * ICE_ACL_ENTRY_ALLOC_UNIT);
> +				cnt += ICE_ACL_ENTRY_ALLOC_UNIT;
> +			}
> +		}
> +
> +		if (cnt >= r_entries) {
> +			req->start = start;
> +			req->num_entry = r_entries;
> +			req->end = ice_acl_tbl_calc_end_idx(start, r_entries,
> +							    width);
> +			break;
> +		}
> +
> +		row = dir > 0 ? row + width : row - width;
> +		if (row < 0)
> +			return -EINVAL;
> +
> +		if (row > hw->acl_tbl->last_tcam ||
> +		    row < hw->acl_tbl->first_tcam) {
> +			/* All rows have been checked. Increment 'off' that
> +			 * will help yield a different TCAM configuration in
> +			 * which adjacent TCAMs can be alternatively in the
> +			 * same row.
> +			 */
> +			off++;
> +
> +			/* However, if the new 'off' value yields previously
> +			 * checked configurations, then exit.
> +			 */
> +			if (off >= width) {
> +				done = true;
> +			} else {
> +				row = dir > 0 ? off :
> +					hw->acl_tbl->last_tcam + 1 - off -
> +					width;
> +				if (row < 0)
> +					return -EINVAL;
> +			}
> +		}
> +	} while (!done);
> +
> +	return cnt >= r_entries ? 0 : -ENOSPC;
> +}
> +
> +/**
> + * ice_acl_fill_tcam_select - fill key byte selection for scenario's TCAM
> + * @scen_buf: Pointer to the scenario buffer that needs to be populated
> + * @scen: Pointer to the available space for the scenario
> + * @tcam_idx: Index of the TCAM used for this scenario
> + * @tcam_idx_in_cascade: Local index of the TCAM in the cascade scenario
> + *
> + * For all TCAM that participate in this scenario, fill out the tcam_select
> + * value.
> + */
> +static void ice_acl_fill_tcam_select(struct ice_aqc_acl_scen *scen_buf,
> +				     struct ice_acl_scen *scen, u16 tcam_idx,
> +				     u16 tcam_idx_in_cascade)
> +{
> +	u16 cascade_cnt, idx;
> +
> +	idx = tcam_idx_in_cascade * ICE_AQC_ACL_KEY_WIDTH_BYTES;
> +	cascade_cnt = DIV_ROUND_UP(scen->width, ICE_AQC_ACL_KEY_WIDTH_BYTES);
> +
> +	/* For each scenario, we reserved last three bytes of scenario width for
> +	 * profile ID, range checker, and packet direction. Thus, the last three
> +	 * bytes of the last cascaded TCAMs will have value of 1st, 31st and
> +	 * 32nd byte location of BYTE selection base.
> +	 *
> +	 * For other bytes in the TCAMs:
> +	 * For non-cascade mode (1 TCAM wide) scenario, TCAM[x]'s Select {0-1}
> +	 * select indices 0-1 of the Byte Selection Base
> +	 * For cascade mode, the leftmost TCAM of the first cascade row selects
> +	 * indices 0-4 of the Byte Selection Base; the second TCAM in the
> +	 * cascade row selects indices starting with 5-n
> +	 */
> +	for (int j = 0; j < ICE_AQC_ACL_KEY_WIDTH_BYTES; j++) {
> +		/* PKT DIR uses the 1st location of Byte Selection Base: + 1 */
> +		u8 val = ICE_AQC_ACL_BYTE_SEL_BASE + 1 + idx;
> +
> +		if (tcam_idx_in_cascade == cascade_cnt - 1) {
> +			if (j == ICE_ACL_SCEN_RNG_CHK_IDX_IN_TCAM)
> +				val = ICE_AQC_ACL_BYTE_SEL_BASE_RNG_CHK;
> +			else if (j == ICE_ACL_SCEN_PID_IDX_IN_TCAM)
> +				val = ICE_AQC_ACL_BYTE_SEL_BASE_PID;
> +			else if (j == ICE_ACL_SCEN_PKT_DIR_IDX_IN_TCAM)
> +				val = ICE_AQC_ACL_BYTE_SEL_BASE_PKT_DIR;
> +		}
> +
> +		/* In case that scenario's width is greater than the width of
> +		 * the Byte selection base, we will not assign a value to the
> +		 * tcam_select[j]. As a result, the tcam_select[j] will have
> +		 * default value which is zero.
> +		 */
> +		if (val > ICE_AQC_ACL_BYTE_SEL_BASE_RNG_CHK)
> +			continue;
> +
> +		scen_buf->tcam_cfg[tcam_idx].tcam_select[j] = val;
> +
> +		idx++;
> +	}
> +}
> +
> +/**
> + * ice_acl_set_scen_chnk_msk - set entries chunk masks
> + * @scen_buf: Pointer to the scenario buffer that needs to be populated
> + * @scen: pointer to the available space for the scenario
> + *
> + * Set the chunk mask for the entries that will be used by this scenario
> + */
> +static void ice_acl_set_scen_chnk_msk(struct ice_aqc_acl_scen *scen_buf,
> +				      struct ice_acl_scen *scen)
> +{
> +	u16 tcam_idx, num_cscd, units;
> +	u8 chnk_offst;
> +
> +	/* Determine the starting TCAM index and offset of the start entry */
> +	tcam_idx = ICE_ACL_TBL_TCAM_IDX(scen->start);
> +	chnk_offst = (u8)((scen->start % ICE_AQC_ACL_TCAM_DEPTH) /
> +			  ICE_ACL_ENTRY_ALLOC_UNIT);
> +
> +	/* Entries are allocated and tracked in multiple of 64's */
> +	units = scen->num_entry / ICE_ACL_ENTRY_ALLOC_UNIT;
> +
> +	/* Determine number of cascaded TCAMs */
> +	num_cscd = scen->width / ICE_AQC_ACL_KEY_WIDTH_BYTES;
> +
> +	for (u16 cnt = 0; cnt < units; cnt++) {
> +		/* Set the corresponding bitmap of individual 64-entry
> +		 * chunk spans across a cascade of 1 or more TCAMs
> +		 * For each TCAM, there will be (ICE_AQC_ACL_TCAM_DEPTH
> +		 * / ICE_ACL_ENTRY_ALLOC_UNIT) or 8 chunks.
> +		 */
> +		for (u16 i = tcam_idx; i < tcam_idx + num_cscd; i++)
> +			scen_buf->tcam_cfg[i].chnk_msk |= BIT(chnk_offst);
> +
> +		chnk_offst = (chnk_offst + 1) % ICE_AQC_MAX_TCAM_ALLOC_UNITS;
> +		if (!chnk_offst)
> +			tcam_idx += num_cscd;
> +	}
> +}
> +
> +/**
> + * ice_acl_assign_act_mem_for_scen - associate action memories to new TCAM
> + * @tbl: pointer to ACL table structure
> + * @scen: pointer to the scenario struct
> + * @scen_buf: pointer to the available space for the scenario
> + * @current_tcam_idx: theoretical index of the TCAM that we associated those
> + *		      action memory banks with, at the table creation time
> + * @target_tcam_idx: index of the TCAM that we want to associate those action
> + *		     memory banks with
> + */
> +static void ice_acl_assign_act_mem_for_scen(struct ice_acl_tbl *tbl,
> +					    struct ice_acl_scen *scen,
> +					    struct ice_aqc_acl_scen *scen_buf,
> +					    u8 current_tcam_idx,
> +					    u8 target_tcam_idx)
> +{
> +	for (int i = 0; i < ICE_AQC_MAX_ACTION_MEMORIES; i++) {
> +		struct ice_acl_act_mem *p_mem = &tbl->act_mems[i];
> +
> +		if (p_mem->act_mem == ICE_ACL_ACT_MEM_ACT_MEM_INVAL ||
> +		    p_mem->member_of_tcam != current_tcam_idx)
> +			continue;
> +
> +		scen_buf->act_mem_cfg[i] = target_tcam_idx;
> +		scen_buf->act_mem_cfg[i] |= ICE_AQC_ACL_SCE_ACT_MEM_EN;
> +		set_bit(i, scen->act_mem_bitmap);
> +	}
> +}
> +
> +/**
> + * ice_acl_commit_partition - Indicate if the specified partition is active
> + * @hw: pointer to the hardware structure
> + * @scen: pointer to the scenario struct
> + * @commit: true if the partition is being commit
> + */
> +static void ice_acl_commit_partition(struct ice_hw *hw,
> +				     struct ice_acl_scen *scen, bool commit)
> +{
> +	u16 tcam_idx, off, num_cscd, units;
> +
> +	/* Determine the starting TCAM index and offset of the start entry */
> +	tcam_idx = ICE_ACL_TBL_TCAM_IDX(scen->start);
> +	off = (scen->start % ICE_AQC_ACL_TCAM_DEPTH) /
> +		ICE_ACL_ENTRY_ALLOC_UNIT;
> +
> +	/* Entries are allocated and tracked in multiple of 64's */
> +	units = scen->num_entry / ICE_ACL_ENTRY_ALLOC_UNIT;
> +
> +	/* Determine number of cascaded TCAM */
> +	num_cscd = scen->width / ICE_AQC_ACL_KEY_WIDTH_BYTES;
> +
> +	for (u16 cnt = 0; cnt < units; cnt++) {
> +		/* Set/clear the corresponding bitmap of individual 64-entry
> +		 * chunk spans across a row of 1 or more TCAMs
> +		 */
> +		for (u16 w = 0; w < num_cscd; w++) {
> +			u16 b;
> +
> +			b = ((tcam_idx + w) * ICE_AQC_MAX_TCAM_ALLOC_UNITS) +
> +				off;
> +			if (commit)
> +				set_bit(b, hw->acl_tbl->avail);
> +			else
> +				clear_bit(b, hw->acl_tbl->avail);
> +		}
> +
> +		off = (off + 1) % ICE_AQC_MAX_TCAM_ALLOC_UNITS;
> +		if (!off)
> +			tcam_idx += num_cscd;
> +	}
> +}
> +
> +/**
> + * ice_acl_create_scen - create ACL scenario
> + * @hw: pointer to the hardware structure
> + * @match_width: number of bytes to be matched in this scenario
> + * @num_entries: number of entries to be allocated for the scenario
> + * @scen_id: holds returned scenario ID if successful
> + *
> + * Return: 0 on success, negative on error
> + */
> +int ice_acl_create_scen(struct ice_hw *hw, u16 match_width, u16 num_entries,
> +			u16 *scen_id)
> +{
> +	u8 cascade_cnt, first_tcam, last_tcam, i, k;
> +	struct ice_aqc_acl_scen scen_buf = {};
> +	struct ice_acl_scen *scen;
> +	int err;
> +
> +	if (match_width > ICE_ACL_MAX_WIDTH_BYTES)
> +		return -EINVAL;
> +
> +	scen = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*scen), GFP_KERNEL);
> +	if (!scen)
> +		return -ENOMEM;
> +
> +	scen->start = hw->acl_tbl->first_entry;
> +	scen->width = ICE_AQC_ACL_KEY_WIDTH_BYTES *
> +		DIV_ROUND_UP(match_width, ICE_AQC_ACL_KEY_WIDTH_BYTES);
> +	scen->num_entry = num_entries;
> +
> +	err = ice_acl_alloc_partition(hw, scen);
> +	if (err)
> +		goto out;
> +
> +	/* Determine the number of cascade TCAMs, given the scenario's width */
> +	cascade_cnt = DIV_ROUND_UP(scen->width, ICE_AQC_ACL_KEY_WIDTH_BYTES);
> +	first_tcam = ICE_ACL_TBL_TCAM_IDX(scen->start);
> +	last_tcam = ICE_ACL_TBL_TCAM_IDX(scen->end);
> +
> +	/* For each scenario, we reserved last three bytes of scenario width for
> +	 * packet direction flag, profile ID and range checker. Thus, we want to
> +	 * return back to the caller the eff_width, pkt_dir_idx, rng_chk_idx and
> +	 * pid_idx.
> +	 */
> +	scen->eff_width = cascade_cnt * ICE_AQC_ACL_KEY_WIDTH_BYTES -
> +		ICE_ACL_SCEN_MIN_WIDTH;
> +	scen->rng_chk_idx = (cascade_cnt - 1) * ICE_AQC_ACL_KEY_WIDTH_BYTES +
> +		ICE_ACL_SCEN_RNG_CHK_IDX_IN_TCAM;
> +	scen->pid_idx = (cascade_cnt - 1) * ICE_AQC_ACL_KEY_WIDTH_BYTES +
> +		ICE_ACL_SCEN_PID_IDX_IN_TCAM;
> +	scen->pkt_dir_idx = (cascade_cnt - 1) * ICE_AQC_ACL_KEY_WIDTH_BYTES +
> +		ICE_ACL_SCEN_PKT_DIR_IDX_IN_TCAM;
> +
> +	/* set the chunk mask for the tcams */
> +	ice_acl_set_scen_chnk_msk(&scen_buf, scen);
> +
> +	/* set the TCAM select and start_cmp and start_set bits */
> +	k = first_tcam;
> +	/* set the START_SET bit at the beginning of the stack */
> +	scen_buf.tcam_cfg[k].start_cmp_set |= ICE_AQC_ACL_ALLOC_SCE_START_SET;
> +	while (k <= last_tcam) {
> +		u8 last_tcam_idx_cascade = cascade_cnt + k - 1;
> +
> +		/* set start_cmp for the first cascaded TCAM */
> +		scen_buf.tcam_cfg[k].start_cmp_set |=
> +			ICE_AQC_ACL_ALLOC_SCE_START_CMP;
> +
> +		/* cascade TCAMs up to the width of the scenario */
> +		for (i = k; i < cascade_cnt + k; i++) {
> +			ice_acl_fill_tcam_select(&scen_buf, scen, i, i - k);
> +			ice_acl_assign_act_mem_for_scen(hw->acl_tbl, scen,
> +							&scen_buf, i,
> +							last_tcam_idx_cascade);
> +		}
> +
> +		k = i;
> +	}
> +
> +	/* We need to set the start_cmp bit for the unused TCAMs. */
> +	i = 0;
> +	while (i < first_tcam)
> +		scen_buf.tcam_cfg[i++].start_cmp_set =
> +					ICE_AQC_ACL_ALLOC_SCE_START_CMP;
> +
> +	i = last_tcam + 1;
> +	while (i < ICE_AQC_ACL_SLICES)
> +		scen_buf.tcam_cfg[i++].start_cmp_set =
> +					ICE_AQC_ACL_ALLOC_SCE_START_CMP;
> +
> +	err = ice_aq_alloc_acl_scen(hw, scen_id, &scen_buf, NULL);
> +	if (err) {
> +		ice_debug(hw, ICE_DBG_ACL, "AQ allocation of ACL scenario failed. status: %d\n",
> +			  err);
> +		goto out;
> +	}
> +
> +	scen->id = *scen_id;
> +	ice_acl_commit_partition(hw, scen, false);
> +	ice_acl_init_entry(scen);
> +	list_add(&scen->list_entry, &hw->acl_tbl->scens);
> +
> +out:
> +	if (err)
> +		devm_kfree(ice_hw_to_dev(hw), scen);
> +
> +	return err;
> +}
> +
> +/**
> + * ice_acl_destroy_scen - destroy an ACL scenario
> + * @hw: pointer to the HW struct
> + * @scen_id: ID of the remove scenario
> + *
> + * Return: 0 on success, negative on error
> + */
> +static int ice_acl_destroy_scen(struct ice_hw *hw, u16 scen_id)
> +{
> +	struct ice_acl_scen *scen, *tmp_scen;
> +	struct ice_flow_prof *p, *tmp;
> +	int err;
> +
> +	/* Remove profiles that use "scen_id" scenario */
> +	list_for_each_entry_safe(p, tmp, &hw->fl_profs[ICE_BLK_ACL], l_entry)
> +		if (p->cfg.scen && p->cfg.scen->id == scen_id) {
> +			err = ice_flow_rem_prof(hw, ICE_BLK_ACL, p->id);
> +			if (err) {
> +				ice_debug(hw, ICE_DBG_ACL, "ice_flow_rem_prof failed. status: %d\n",
> +					  err);
> +				return err;
> +			}
> +		}
> +
> +	err = ice_aq_dealloc_acl_scen(hw, scen_id, NULL);
> +	if (err) {
> +		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of scenario failed. status: %d\n",
> +			  err);
> +		return err;
> +	}
> +
> +	/* Remove scenario from hw->acl_tbl->scens */
> +	list_for_each_entry_safe(scen, tmp_scen, &hw->acl_tbl->scens,
> +				 list_entry)
> +		if (scen->id == scen_id) {
> +			ice_acl_commit_partition(hw, scen, true);
> +
> +			list_del(&scen->list_entry);
> +			devm_kfree(ice_hw_to_dev(hw), scen);
> +		}
> +
> +	return 0;
> +}
> +
>  /**
>   * ice_acl_destroy_tbl - Destroy a previously created LEM table for ACL
>   * @hw: pointer to the HW struct

[Severity: High]
Should this walk of hw->fl_profs[ICE_BLK_ACL] hold
hw->fl_profs_locks[ICE_BLK_ACL]?  Every other accessor of that list
takes the mutex, including the function called from inside this very
loop:

ice_flow_rem_prof() {
	mutex_lock(&hw->fl_profs_locks[blk]);
	prof = ice_flow_find_prof_id(hw, blk, prof_id);
	...
	status = ice_flow_rem_prof_sync(hw, blk, prof);
out:
	mutex_unlock(&hw->fl_profs_locks[blk]);
}

So the traversal in ice_acl_destroy_scen() reads and caches the 'tmp'
pointer with no serialization, while ice_flow_rem_prof_sync() unlinks
and frees profiles on the same list; an add/remove from another context
(the ethtool ntuple paths reach ice_flow_add_prof()/ice_flow_rem_prof())
can then make the cached 'tmp' stale.

Simply wrapping the loop in mutex_lock(&hw->fl_profs_locks[ICE_BLK_ACL])
would deadlock, since ice_flow_rem_prof() acquires it unconditionally,
which suggests the shape of this loop is wrong rather than just the
missing lock.  Would it make sense to collect the matching profile IDs
under the lock and then call ice_flow_rem_prof() for each ID after
dropping it, or to add a helper that walks the list and calls
ice_flow_rem_prof_sync() while holding the mutex?  What serializes this
path against concurrent ACL profile add/remove today?

[ ... ]

> @@ -415,6 +433,37 @@ ice_fdir_rem_flow(struct ice_hw *hw, enum ice_block blk,
>  	prof->cnt = 0;
>  }
>  
> +/**
> + * ice_acl_rem_flows - remove ACL flow profiles and all their entries
> + * @hw: hardware structure containing the filter list
> + */
> +void ice_acl_rem_flows(struct ice_hw *hw)
> +{
> +	if (!hw->acl_prof)
> +		return;
> +
> +	for (enum ice_fltr_ptype flow = ICE_FLTR_PTYPE_NONF_NONE;
> +	     flow < ICE_FLTR_PTYPE_MAX; flow++) {
> +		struct ice_acl_hw_prof *prof;
> +		int err;
> +
> +		flow &= ~FLOW_EXT;
> +		prof = hw->acl_prof[flow];
> +		if (!prof || !prof->seg)
> +			continue;
> +
> +		err = ice_flow_rem_prof(hw, ICE_BLK_ACL, prof->prof_id);
> +		if (err) {
> +			dev_err(ice_hw_to_dev(hw), "Could not remove ACL profile, flow type %d\n",
> +				flow);
> +			continue;
> +		}
> +
> +		kfree(prof->seg);
> +		prof->seg = NULL;
> +	}
> +}
> +
>  /**
>   * ice_fdir_release_flows - release all flows in use for later replay
>   * @hw: pointer to HW instance

[Severity: Low]
Is masking the loop control variable here intentional?  'flow' is the
iteration variable of the enclosing for loop, and rewriting it in the
body means the loop counter itself can be moved backwards - here
FLOW_EXT (0x80000000, an ethtool uapi flow_type bit) is never set in the
enum ice_fltr_ptype values being iterated, which are bounded by
ICE_FLTR_PTYPE_MAX, so today the mask is a no-op and the loop still
terminates.  It is still a fragile pattern: if the enum ever grows or
the bound changes, a body that clears a bit of the counter turns into a
non-terminating loop, and it obscures what the loop is actually walking.

ice_fdir_rem_flow() does the same masking but into a separate local:

	int flow = (int)flow_type & ~FLOW_EXT;

Could the mask simply be dropped here, or applied to a separate local
used for the hw->acl_prof[] index so the loop counter is never touched?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917183927.2692068-1-anthony.l.nguyen%40intel.com
