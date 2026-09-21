Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D43D0939
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020641; cv=none; b=ej9VTjiB8yGd2uPTFjzGakwL/nvcutRJFmC8n13mGWouF3BZrCiGWqOJivM0L8bNYQrwWzIqy/6ndpJlfgHKVkmaSiJiTtNJfSCPszTGJB+RgE0s+qN3GdlU9l91RjZ/O6927d1c01diNFBdG3VqnMrpgZcrL2/EVEai6eSj2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020641; c=relaxed/simple;
	bh=Yo+xi9fiJrFrFdRRKE6BHYqELfm2pPA23eOAoK+pqqY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgyvgDFyVicmftpCrXkYJFZDrRmYXIyP9yJoYrrmFcuzAdioapf1k9fyTfrsDd/zmm6tywRgdgZwjn6ozcNKsJ9nLfqgw9bCBn0Imufh07hag9+v4S8ux1aIC3Xty7tojGUu0FSdkx+kJY0psi5F2jbU3dJICghLl4DMdwzOfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N606br+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N606br+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA4A1F00898;
	Mon, 21 Sep 2026 19:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020638;
	bh=u2vadRgA4Kf/k2Cn1ntg0ZuEG2mDkGIJLHRyYemq/WM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N606br+sDEsL/fRVqCImlDrEZ9PZeYTN+P+w8YpcRgvA+sKUrCEkPR+NjhaxjeHFg
	 pJZhNBtccFPHKVVnqt1EH5DQlqcQRgjjPJc0Zi662K3Aw137HslC8ezjcu3Q6L6ufP
	 2gWauP7EwCpk/hu80s3wpSg3mt16EG5pAIyRHzY9Y6goJmwqE/r9Nxk889z48MOzv1
	 2MsVjcqZnwt/FKEHku6Ib+6s37Ec1rHti6vFeWiMl9767YthaxC8Eb4lXDgmKHk2ve
	 QdgybEb9ZDZ1TP6IO0l5+iqx9obNIkwOCvVZz9fqlcSjU+Y7GwaRW3TkFgTiLIV2+h
	 Qfo1SA98uotYw==
Subject: Re: [PATCH net-next v2 03/12] ice: initialize ACL table
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, marcin.szycik@linux.intel.com,
 aleksandr.loktionov@intel.com, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 19:57:17 +0000
Message-ID: <179002063750.2160803.9929345142245321862@kernel.org>
In-Reply-To: <20260917183927.2692068-4-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-4-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 7

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ice_acl_create_tbl() validates only alloc_id from the 0x0C10
  response and then uses resp_buf->ops.table.first_tcam/last_tcam and…
- [Medium] The ACL table is allocated and fully zero-initialized entry-
  by-entry at probe for every PF, unconditionally and regardless of…
- [Medium] The available-chunk bitmap is filled with one contiguous
  bitmap_set() from (first_tcam,first_entry) to (last_tcam,last_entry)…
- [Low] ACL table is created only in ice_init_features() and destroyed
  only in ice_deinit_features(), so a PFR/CORER/GLOBR (or…
- [Low] ice_acl_create_tbl() mutates the caller-owned `params` struct
  asymmetrically: params->entry_act_pairs is overwritten with…
- [Low] In ice_acl_create_tbl() the concurrent-table branch
  (ice_acl_ctrl.c:206-218) copies params->num_dep_tbls entries into the…
- [Low] In struct ice_aqc_acl_scen the 64-entry chunk-mask bit
  description ("Bit 0 : masks TCAM entries 0-63 / Bit 1 : masks TCAM…
- [Low] ICE_AQC_TBL_MAX_ACTION_PAIRS (4, documented as "The ACL block
  supports up to 8 actions per a single output",…
- [Low] ice_acl_destroy_tbl() declares `struct ice_aqc_acl_generic
  resp_buf;` (ice_acl_ctrl.c:299) without an initializer and passes it…
- [Low] ice_acl_destroy_tbl() returns early on AdminQ de-allocation
  failure (`ice_debug(...); return err;`, ice_acl_ctrl.c:306-310)…

--

ice: initialize ACL table

This adds the structures, AdminQ command wrappers and table allocation for
the E8xx Ternary Classifier ("ACL") block, and creates the ACL table at
probe time from ice_init_features(). A few questions below about the
firmware response handling, the chunk bitmap geometry and the teardown
path.

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl.c b/drivers/net/ethernet/intel/ice/ice_acl.c
> new file mode 100644
> index 0000000000000..1c9ae47d9efc1
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_acl.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018-2026, Intel Corporation. */
> +
> +#include "ice_acl.h"
> +
> +/**
> + * ice_aq_alloc_acl_tbl - allocate ACL table
> + * @hw: pointer to the HW struct
> + * @tbl: pointer to ice_acl_alloc_tbl struct
> + * @cd: pointer to command details structure or NULL
> + *
> + * Allocate ACL table (indirect 0x0C10)
> + *
> + * Return: 0 on success, negative on error
> + */
> +int ice_aq_alloc_acl_tbl(struct ice_hw *hw, struct ice_acl_alloc_tbl *tbl,
> +			 struct ice_sq_cd *cd)
> +{
> +	struct ice_aqc_acl_alloc_table *cmd;
> +	struct libie_aq_desc desc;
> +
> +	if (!tbl->act_pairs_per_entry)
> +		return -EINVAL;
> +
> +	if (tbl->act_pairs_per_entry > ICE_AQC_MAX_ACTION_MEMORIES)
> +		return -ENOSPC;

[Severity: Low]
Should this bound be ICE_AQC_TBL_MAX_ACTION_PAIRS (4) rather than
ICE_AQC_MAX_ACTION_MEMORIES (20)?

ICE_AQC_TBL_MAX_ACTION_PAIRS is documented in ice_adminq_cmd.h as the
per-entry action-pair maximum, and ice_acl_create_tbl() only applies that
clamp inside the branch that raises the value:

	if (params->entry_act_pairs < width / ICE_AQC_ACL_KEY_WIDTH_BYTES) {
		params->entry_act_pairs = width / ICE_AQC_ACL_KEY_WIDTH_BYTES;

		if (params->entry_act_pairs > ICE_AQC_TBL_MAX_ACTION_PAIRS)
			params->entry_act_pairs = ICE_AQC_TBL_MAX_ACTION_PAIRS;
	}

So a caller-supplied entry_act_pairs of 5..20 skips the clamp entirely and
is accepted here. The only in-tree caller passes 1, so nothing misbehaves
today, but the two limits contradict each other. An out-of-contract value
would also feed ice_acl_divide_act_mems_to_tcams(), which divides
tbl->info.entry_act_pairs across num_cscd TCAMs.

> +
> +	/* If this is concurrent table, then alloc_ids buffer shall be valid and
> +	 * contain AllocIDs of dependent tables. 'num_dependent_alloc_ids'
> +	 * should be non-zero and within limit.
> +	 */
> +	if (tbl->concurr) {
> +		if (!tbl->num_dependent_alloc_ids)
> +			return -EINVAL;
> +		if (tbl->num_dependent_alloc_ids >
> +		    ICE_AQC_MAX_CONCURRENT_ACL_TBL)
> +			return -ERANGE;
> +	}
> +

[ ... ]

> +/**
> + * ice_aq_dealloc_acl_tbl - deallocate ACL table
> + * @hw: pointer to the HW struct
> + * @alloc_id: allocation ID of the table being released
> + * @buf: address of indirect data buffer
> + * @cd: pointer to command details structure or NULL
> + *
> + * Deallocate ACL table (indirect 0x0C11)
> + *
> + * NOTE: This command has no buffer format for command itself but response
> + * format is 'struct ice_aqc_acl_generic', pass ptr to that struct
> + * as 'buf' and its size as 'buf_size'
> + *
> + * Return: 0 on success, negative on error
> + */
> +int ice_aq_dealloc_acl_tbl(struct ice_hw *hw, u16 alloc_id,
> +			   struct ice_aqc_acl_generic *buf,
> +			   struct ice_sq_cd *cd)
> +{
> +	struct ice_aqc_acl_tbl_actpair *cmd;
> +	struct libie_aq_desc desc;
> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_dealloc_acl_tbl);
> +	cmd = libie_aq_raw(&desc);
> +	cmd->alloc_id = cpu_to_le16(alloc_id);
> +
> +	return ice_aq_send_cmd(hw, &desc, buf, sizeof(*buf), cd);
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl.h b/drivers/net/ethernet/intel/ice/ice_acl.h
> new file mode 100644
> index 0000000000000..7446be5d1edbe
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_acl.h
> @@ -0,0 +1,118 @@

[ ... ]

> +struct ice_acl_tbl {
> +	/* TCAM configuration */
> +	u8 first_tcam;
> +	u8 last_tcam;
> +	u16 first_entry; /* Index of the first entry in the first TCAM */
> +	u16 last_entry; /* Index of the last entry in the last TCAM */
> +	u16 id;
> +
> +	/* List of active scenarios */
> +	struct list_head scens;
> +
> +	struct ice_acl_tbl_params info;
> +	struct ice_acl_act_mem act_mems[ICE_AQC_MAX_ACTION_MEMORIES];
> +
> +	/* Keep track of available 64-entry chunks in TCAMs */
> +	DECLARE_BITMAP(avail, ICE_AQC_ACL_ALLOC_UNITS);
> +};

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> new file mode 100644
> index 0000000000000..9984c07b53f0d
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> @@ -0,0 +1,316 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018-2026, Intel Corporation. */
> +
> +#include "ice_acl.h"
> +

[ ... ]

> +static int ice_acl_init_tbl(struct ice_hw *hw)
> +{
> +	struct ice_aqc_actpair act_buf = {};
> +	struct ice_aqc_acl_data buf = {};
> +	struct ice_acl_tbl *tbl;
> +	u8 tcam_idx;
> +	int err = 0;
> +	u16 idx;
> +
> +	tbl = hw->acl_tbl;
> +
> +	tcam_idx = tbl->first_tcam;
> +	idx = tbl->first_entry;
> +	while (tcam_idx < tbl->last_tcam ||
> +	       (tcam_idx == tbl->last_tcam && idx <= tbl->last_entry)) {

[Severity: Medium]
Can this loop terminate if firmware returns the documented failure values
for last_tcam and last_entry?

ice_acl_create_tbl() only validates alloc_id from the 0x0C10 response and
then stores the rest verbatim:

	tbl->first_tcam = resp_buf->ops.table.first_tcam;
	tbl->last_tcam = resp_buf->ops.table.last_tcam;
	tbl->first_entry = le16_to_cpu(resp_buf->first_entry);
	tbl->last_entry = le16_to_cpu(resp_buf->last_entry);

struct ice_aqc_acl_generic, added by this same patch, documents 0xFF as the
sentinel for exactly those four fields, and the hardware has 16 TCAM blocks
of 512 entries. With last_tcam = 0xFF, tcam_idx is a u8 and wraps at 255,
so the loop above keeps issuing 0x0C20 writes against TCAM blocks the PF
does not own.

The same unvalidated values also feed the chunk bitmap at the end of
ice_acl_create_tbl():

	last_e = (tbl->last_tcam * ICE_AQC_MAX_TCAM_ALLOC_UNITS) +
		(tbl->last_entry / ICE_ACL_ENTRY_ALLOC_UNIT);
	bitmap_set(tbl->avail, first_e, last_e - first_e + 1);

Can that write past the 128-bit avail bitmap, which is the trailing member
of the kzalloc'ed struct ice_acl_tbl? Would it make sense to check
first_tcam <= last_tcam < ICE_AQC_ACL_SLICES and the entry indices against
ICE_AQC_ACL_TCAM_DEPTH before using them?

> +		/* Use the same value for entry_key and entry_key_inv since
> +		 * we are initializing the fields to 0
> +		 */
> +		err = ice_aq_program_acl_entry(hw, tcam_idx, idx, &buf, NULL);
> +		if (err)
> +			return err;
> +
> +		if (++idx > tbl->last_entry) {
> +			tcam_idx++;
> +			idx = tbl->first_entry;
> +		}
> +	}
> +
> +	for (int i = 0; i < ICE_AQC_MAX_ACTION_MEMORIES; i++) {
> +		u16 act_entry_idx;
> +
> +		if (tbl->act_mems[i].act_mem == ICE_ACL_ACT_MEM_ACT_MEM_INVAL)
> +			continue;
> +
> +		for (act_entry_idx = tbl->first_entry;
> +		     act_entry_idx <= tbl->last_entry; act_entry_idx++) {
> +			/* Invalidate all allocated action pairs */
> +			err = ice_aq_program_actpair(hw, i, act_entry_idx,
> +						     &act_buf, NULL);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return err;
> +}

[Severity: Medium]
How much probe time do these two loops add?

For the configuration set up by ice_acl_create_hw() with num_funcs < 8
(3 slices, 512 entries) this is 3 * 512 = 1536 synchronous 0x0C20 commands,
plus one 0x0C1C per valid action memory per entry, i.e. roughly another
1536 with 3 valid act_mems. Each one is a separate firmware round trip
serialized inside ice_aq_send_cmd().

This runs unconditionally on every PF at probe, and ice_acl_create_hw()
also claims 3 of the device's 16 TCAM slices permanently, even when no
masked ntuple rule is ever configured. Would allocating the table lazily on
the first masked ntuple rule, or gating it behind a user knob, be
preferable?

[ ... ]

> +int ice_acl_create_tbl(struct ice_hw *hw, struct ice_acl_tbl_params *params)
> +{
> +	struct ice_acl_alloc_tbl tbl_alloc = {};
> +	struct ice_aqc_acl_generic *resp_buf;
> +	u16 width, depth, first_e, last_e;
> +	struct ice_acl_tbl *tbl;
> +	u16 alloc_id;
> +	int err;
> +
> +	if (hw->acl_tbl)
> +		return -EEXIST;
> +
> +	/* round up the width to the next TCAM width boundary. */
> +	width = roundup(params->width, (u16)ICE_AQC_ACL_KEY_WIDTH_BYTES);
> +	/* depth should be provided in chunk (64 entry) increments */
> +	depth = ALIGN(params->depth, ICE_ACL_ENTRY_ALLOC_UNIT);
> +
> +	if (params->entry_act_pairs < width / ICE_AQC_ACL_KEY_WIDTH_BYTES) {
> +		params->entry_act_pairs = width / ICE_AQC_ACL_KEY_WIDTH_BYTES;
> +
> +		if (params->entry_act_pairs > ICE_AQC_TBL_MAX_ACTION_PAIRS)
> +			params->entry_act_pairs = ICE_AQC_TBL_MAX_ACTION_PAIRS;
> +	}

[Severity: Low]
This isn't a bug, but is the mutation of the caller-owned params intended to
be this asymmetric?

params->entry_act_pairs is written back here, while the rounded width and
the aligned depth are kept private to tbl->info:

	tbl->info = *params;
	tbl->info.width = width;
	tbl->info.depth = depth;

The kernel-doc describes @params only as "parameters for the table to be
created", so after the call params describes neither the requested nor the
created table consistently. Later in the series ice_acl_create_hw() re-reads
params.width and params.depth after this function returns; with the current
values (width 15, depth 512/256) the stale values happen to match, but a
non-aligned request would not. Either normalizing all three fields or none
of them, and documenting it, would avoid that.

> +
> +	/* Validate that width*depth will not exceed the TCAM limit */
> +	if ((DIV_ROUND_UP(depth, ICE_AQC_ACL_TCAM_DEPTH) *
> +	     (width / ICE_AQC_ACL_KEY_WIDTH_BYTES)) > ICE_AQC_ACL_SLICES)
> +		return -ENOSPC;
> +
> +	tbl_alloc.width = width;
> +	tbl_alloc.depth = depth;
> +	tbl_alloc.act_pairs_per_entry = params->entry_act_pairs;
> +	tbl_alloc.concurr = params->concurr;
> +
> +	if (params->concurr) {
> +		int i;
> +
> +		tbl_alloc.num_dependent_alloc_ids = params->num_dep_tbls;
> +
> +		for (i = 0; i < params->num_dep_tbls; i++)
> +			tbl_alloc.buf.data_buf.alloc_ids[i] =
> +				cpu_to_le16(params->dep_tbls[i]);

[Severity: Low]
Can this loop overrun tbl_alloc.buf.data_buf.alloc_ids[]?

num_dep_tbls is a u8, and both params->dep_tbls[] and alloc_ids[] hold 15
entries, but there is no bound check before the copy. The only range check
lives in ice_aq_alloc_acl_tbl(), which runs after the buffer has already
been filled:

	if (tbl->num_dependent_alloc_ids > ICE_AQC_MAX_CONCURRENT_ACL_TBL)
		return -ERANGE;

With num_dep_tbls > 15 that leaves an out-of-bounds read of the caller's
dep_tbls[] and an out-of-bounds write into the on-stack ice_acl_alloc_tbl
union. The only caller today sets concurr = false and num_dep_tbls = 0, so
the path is latent, but would it be better to validate num_dep_tbls here
before filling the buffer?

> +
> +		for (; i < ICE_AQC_MAX_CONCURRENT_ACL_TBL; i++)
> +			tbl_alloc.buf.data_buf.alloc_ids[i] =
> +				cpu_to_le16(ICE_AQC_CONCURR_ID_INVALID);
> +	}
> +
> +	err = ice_aq_alloc_acl_tbl(hw, &tbl_alloc, NULL);
> +	if (err) {
> +		dev_err(ice_hw_to_dev(hw), "ACL table allocation failed with error %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	alloc_id = le16_to_cpu(tbl_alloc.buf.resp_buf.alloc_id);
> +	if (alloc_id < ICE_AQC_ALLOC_ID_4K) {
> +		dev_err(ice_hw_to_dev(hw), "ACL table allocation failed due to unavailable resources.\n");
> +		return -ENOMEM;
> +	}
> +
> +	resp_buf = &tbl_alloc.buf.resp_buf;
> +
> +	tbl = kzalloc_obj(*tbl);
> +	if (!tbl) {
> +		err = -ENOMEM;
> +		goto err_dealloc_tbl;
> +	}
> +
> +	/* Retrieve information of the allocated table */
> +	tbl->id = alloc_id;
> +	tbl->first_tcam = resp_buf->ops.table.first_tcam;
> +	tbl->last_tcam = resp_buf->ops.table.last_tcam;
> +	tbl->first_entry = le16_to_cpu(resp_buf->first_entry);
> +	tbl->last_entry = le16_to_cpu(resp_buf->last_entry);
> +

[ ... ]

> +	first_e = (tbl->first_tcam * ICE_AQC_MAX_TCAM_ALLOC_UNITS) +
> +		(tbl->first_entry / ICE_ACL_ENTRY_ALLOC_UNIT);
> +	last_e = (tbl->last_tcam * ICE_AQC_MAX_TCAM_ALLOC_UNITS) +
> +		(tbl->last_entry / ICE_ACL_ENTRY_ALLOC_UNIT);
> +
> +	/* Indicate available entries in the table */
> +	bitmap_set(tbl->avail, first_e, last_e - first_e + 1);

[Severity: Medium]
Is a single contiguous bitmap_set() the right encoding when depth is less
than a full TCAM?

ice_acl_init_tbl() shows that the entry window [first_entry..last_entry]
repeats inside every TCAM of the table:

		if (++idx > tbl->last_entry) {
			tcam_idx++;
			idx = tbl->first_entry;
		}

but the bitmap index here is tcam * ICE_AQC_MAX_TCAM_ALLOC_UNITS(8) +
entry/64, so the owned chunk set is non-contiguous whenever depth < 512.

For the shared-slice case that ice_acl_create_hw() selects when
num_funcs >= 8 (depth 256, 3 cascaded slices), first_tcam = 0,
last_tcam = 2, first_entry = 0, last_entry = 255 gives first_e = 0 and
last_e = 19, so bitmap_set(avail, 0, 20) also marks chunks 4-7 (slice 0
entries 256-511) and 12-15 (slice 1 entries 256-511) as available. Those
halves belong to the peer PF according to the comment in
ice_acl_create_hw(). The PF whose first_entry is 256 gets the mirror-image
error.

Later in the series ice_acl_alloc_partition() converts a set bit back to a
hardware entry index, so should this be set per TCAM instead of as one
range?

> +
> +	INIT_LIST_HEAD(&tbl->scens);
> +
> +	return 0;
> +
> +err_free_tbl:
> +	hw->acl_tbl = NULL;
> +	kfree(tbl);
> +err_dealloc_tbl:
> +	ice_aq_dealloc_acl_tbl(hw, alloc_id, resp_buf, NULL);
> +	return err;
> +}
> +
> +/**
> + * ice_acl_destroy_tbl - Destroy a previously created LEM table for ACL
> + * @hw: pointer to the HW struct
> + *
> + * Return: 0 on success, negative on error
> + */
> +int ice_acl_destroy_tbl(struct ice_hw *hw)
> +{
> +	struct ice_aqc_acl_generic resp_buf;

[Severity: Low]
Should resp_buf be initialized here, as the other AdminQ buffers in this
patch are?

ice_aq_dealloc_acl_tbl() passes it with a non-zero size, and
ice_sq_send_cmd() copies the caller buffer into the DMA-mapped send buffer
unconditionally, regardless of LIBIE_AQ_FLAG_RD:

drivers/net/ethernet/intel/ice/ice_controlq.c:ice_sq_send_cmd() {
	if (buf) {
		dma_buf = &cq->sq.r.sq_bi[cq->sq.next_to_use];
		memcpy(dma_buf->va, buf, buf_size);
	...
}

So 28 bytes of uninitialized stack are copied into device-visible memory on
every ACL teardown. Would "= {}" be enough here?

> +	int err;
> +
> +	if (!hw->acl_tbl)
> +		return -ENOENT;
> +
> +	err = ice_aq_dealloc_acl_tbl(hw, hw->acl_tbl->id, &resp_buf, NULL);
> +	if (err) {
> +		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of ACL failed. status: %d\n",
> +			  err);
> +		return err;
> +	}
> +
> +	kfree(hw->acl_tbl);
> +	hw->acl_tbl = NULL;
> +
> +	return 0;
> +}

[Severity: Low]
Does this early return leak the kzalloc'ed hw->acl_tbl?

When the 0x0C11 command fails (surprise removal, dead device, firmware
error, reset in flight) the function returns before kfree(hw->acl_tbl) and
leaves the pointer set, so the object is never freed and any later
ice_acl_create_tbl() returns -EEXIST. The only caller discards the return
value:

static void ice_deinit_acl(struct ice_pf *pf)
{
	ice_acl_destroy_tbl(&pf->hw);
}

Later in this series the commit "ice: add ACL reset recovery and NTUPLE
feature toggle" makes ice_acl_destroy_tbl() void, drops the early returns
and always reaches kfree(hw->acl_tbl) with the comment "Continue on AQ
errors so SW state is always cleaned up", so the final state of the series
is fine; would it be worth doing that here so the intermediate commits do
not carry the leak?

> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 42878abac9eb1..f98780afa1399 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h

[ ... ]

> +#define ICE_AQC_ACL_ALLOC_SCE_START_CMP		BIT(0)
> +#define ICE_AQC_ACL_ALLOC_SCE_START_SET		BIT(1)
> +
> +#define ICE_AQC_ACL_SCE_ACT_MEM_EN		BIT(7)
> +
> +/* Input buffer format in case allocate/update ACL scenario and same format
> + * is used for response buffer in case of query ACL scenario.
> + * NOTE: de-allocate ACL scenario is direct command and doesn't require
> + * "buffer", hence no buffer format.
> + */
> +struct ice_aqc_acl_scen {
> +	struct {
> +		/* Byte [x] selection for the TCAM key. This value must be set
> +		 * to 0x0 for unused TCAM.
> +		 * Only Bit 6..0 is used in each byte and MSB is reserved
> +		 */
> +		u8 tcam_select[5];
> +		/* TCAM Block entry masking. This value should be set to 0x0 for
> +		 * unused TCAM
> +		 */
> +		u8 chnk_msk;
> +		/* Bit 0 : masks TCAM entries 0-63
> +		 * Bit 1 : masks TCAM entries 64-127
> +		 * Bit 2 to 7 : follow the pattern of bit 0 and 1
> +		 */
> +		u8 start_cmp_set;

[Severity: Low]
Is the 64-entry chunk-mask description attached to the wrong field? It
describes chnk_msk, but sits on start_cmp_set, whose bits are defined 20
lines above as ICE_AQC_ACL_ALLOC_SCE_START_CMP = BIT(0) and
ICE_AQC_ACL_ALLOC_SCE_START_SET = BIT(1). Later code in this series
confirms that, writing the per-64-entry bits into chnk_msk and the
START_CMP value into start_cmp_set.

While in the area, the kernel-doc of ice_aq_dealloc_acl_tbl() says to pass
"ptr to that struct as 'buf' and its size as 'buf_size'", but the function
has no buf_size parameter; it hardcodes sizeof(*buf).

> +	} tcam_cfg[ICE_AQC_ACL_SLICES];

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 707c7431b91a6..981c105e1d3a2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c

[ ... ]

> @@ -4748,6 +4802,10 @@ static void ice_init_features(struct ice_pf *pf)
>  	if (ice_init_fdir(pf))
>  		dev_err(dev, "could not initialize flow director\n");
>  
> +	/* Note: ACL init failure is non-fatal to load */
> +	if (ice_init_acl(pf))
> +		dev_err(dev, "Failed to initialize ACL\n");
> +

[Severity: Low]
What happens to hw->acl_tbl across a reset at this point in the series?

The table is created only from ice_init_features() and destroyed only from
ice_deinit_features(), so after a PFR/CORER/GLOBR (or after ice_resume(),
which schedules a PFR) hw->acl_tbl still describes a firmware allocation
that no longer exists, and:

	if (hw->acl_tbl)
		return -EEXIST;

in ice_acl_create_tbl() prevents re-creating it, while a later teardown
would deallocate an alloc_id firmware may have reassigned.

The later commit "ice: add ACL reset recovery and NTUPLE feature toggle"
wires ice_acl_destroy_tbl() plus ice_acl_create_hw() into ice_rebuild(),
which closes this for the end of the series; is it worth handling the
rebuild path from the start so the intermediate commits are not exposed?

>  	/* Note: DCB init failure is non-fatal to load */
>  	if (ice_init_pf_dcb(pf, false)) {
>  		clear_bit(ICE_FLAG_DCB_CAPABLE, pf->flags);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917183927.2692068-1-anthony.l.nguyen%40intel.com
