Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3899443E40
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971406; cv=none; b=GCoGzVNqJtmLGH7knQNh2gCLtKRrzxCIwyuipL8Lmj7tSzTJ6oxslgERxx9vScB1dWw9nprFjwya4hBlCN1qTOI/nyfV1BybXvndh45ORnYphiWXBcLov5U8n2/zMItQEuRgL1ivtoopydWjT0z00TP5pKcRzUU8QNJnDnPsP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971406; c=relaxed/simple;
	bh=NrG1nnRTwlZKdJjWqDvmKJtjkHGScz26yiUPJbmO1Yk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mSWb7rHVfCwVDIsfemtEewQcCmmzbJ6DDff0obHC8erkNnqyz70mszcbAKK+taR5ndhoxhBaDtmcsbAldNZz17oCXe/o+anJTecanZMFOvsdcsnbGsw5/TwErV+lEISPQY1/uiTgTeb8LGovDU5klNLxJ+TlW54tYYg4rA7HRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSzCJXSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSzCJXSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7D11F00893;
	Fri,  2 Oct 2026 20:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971404;
	bh=ewuMe0JuctQ5k34pyEBonEEQMEMYO1cxgMXFEjASxDA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NSzCJXSGll4TUrpRS5bH0+hs/VKM6e3s+/6nmKUANv90T2go3QRAik/MqIX0V4L2C
	 3yzbK7czGYdc5/BiLPxEO5viTLsw6uwhZZvBSfKUEX/Da6xhk50G9X7xBXZx6d76ll
	 YL43Zh9sVWp17+OIGwE9TOMPac7gWmsG85l4OE/FfiR5D02DTzPPmDGm9gOpgvDULi
	 23SU7pmkkcsAF8S63sNJFedyoKmavbzZRn8ACLLkBix7DB6IKFykyBn++xrezp+9M/
	 gztwQTUv1jBWM3ZEmbUaVORwLCGhXTfB8EvwqVh8nxjQ+v+TJqSMilAAtYVH0cVkpi
	 l/gLgr8u3kSBw==
Subject:
 Re: [PATCH net-next 07/10] ice: parser: use kcalloc for table allocation
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, marcin.szycik@intel.com,
 jacob.e.keller@intel.com, przemyslaw.korba@intel.com, xiongwm2026@163.com,
 ynorov@nvidia.com, horms@kernel.org
Date: Fri, 02 Oct 2026 20:03:23 +0000
Message-ID: <179097140339.434549.12084701327448249572@kernel.org>
In-Reply-To: <20260929224153.1455466-8-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-8-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ice_parser_create_table() still allows a heap out-of-bounds
  write controlled by firmware data.
- [Medium] The commit message says kcalloc() is used so that "an overflow
  in the firmware-provided item dimensions is detected before…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a high-
  severity bug on the same allocation-failure path.
- [Medium] This problem wasn't introduced by this patch.

--

ice: parser: use kcalloc for table allocation

This commit changes the allocation in ice_parser_create_table() from
kzalloc(item_size * length) to kcalloc(length, item_size). The goal is
to catch multiplication overflow before the allocation.

> Use kcalloc() when calculating the parser table allocation size so an
> overflow in the firmware-provided item dimensions is detected before
> allocation.

[Severity: Medium]
Is this description accurate? In ice_parser_create_table(), neither
item_size nor length comes from firmware.

All of the *_table_get() callers pass a sizeof() and an ICE_*_TABLE_SIZE
constant. For example, ice_pg_cam_table_get() does this:

	return ice_parser_create_table(hw, ICE_SID_RXPARSER_CAM,
				       sizeof(struct ice_pg_cam_item),
				       ICE_PG_CAM_TABLE_SIZE,

The largest length is ICE_PG_CAM_TABLE_SIZE (2048). The multiplication
cannot overflow, so the kcalloc() overflow check can never fire.

Could the commit message describe this as a cleanup, not as hardening
against firmware input?

> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> index 3ede4c1a5a8a5..d239102c52ffd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -102,7 +102,7 @@ ice_parser_create_table(struct ice_hw *hw, u32 sect_type,
>  	if (!seg)
>  		return ERR_PTR(-EINVAL);
>  
> -	table = kzalloc(item_size * length, GFP_KERNEL);
> +	table = kcalloc(length, item_size, GFP_KERNEL);

[Severity: High]
The table holds length entries. Can the fill loop right after this still
write past the end of it?

In ice_parser_create_table(), the index comes from the package section
header, and nothing compares it with length:

		if (data) {
			struct ice_pkg_sect_hdr *hdr = state.sect;

			if (!no_offset)
				idx = le16_to_cpu(hdr->offset) +
					state.entry_idx;

			item = (void *)((uintptr_t)table + idx * item_size);
			parse_item(hw, idx, item, data, item_size);

			if (no_offset)
				idx++;
		}

ice_parser_sect_item_get() only checks the entry index against the
package's own hdr->count. In no_offset mode (bst_tcam, bst_lbl,
ptype_mk_tcam), idx goes up once for every entry in every section of
that type, with no limit.

For example, the flg_rd table has ICE_FLG_RD_TABLE_SIZE (64) entries. A
section with count = 1 and offset = 64 would make ice_flg_rd_parse_item()
write to table[64]:

	rdi->idx = idx;
	rdi->expose = FIELD_GET(ICE_FRT_EXPO, d8);
	rdi->intr_flg_id = FIELD_GET(ICE_FRT_IFID, d8);

The source data is hw->seg, which comes from the DDP package in
/lib/firmware. A VF request can trigger the table fill at runtime:

ice_vc_fdir_parse_raw() / ice_parse_raw_rss_pattern()
  ice_parser_create()
    ice_flg_rd_table_get()
      ice_parser_create_table()

The commit message is about guarding this table against firmware input.
Would it make sense to compute idx in a type wide enough not to wrap, and
to reject or skip entries with idx >= length before computing item and
calling parse_item()?

>  	if (!table)
>  		return ERR_PTR(-ENOMEM);

[Severity: High]
This isn't a bug introduced by this patch, but what happens to this
ERR_PTR(-ENOMEM) once it gets back to ice_parser_create()?

Each sub-table result is stored in the struct before the IS_ERR() check,
and the field is not cleared before the jump to the error label:

	p->imem_table = ice_imem_table_get(hw);
	if (IS_ERR(p->imem_table)) {
		err = p->imem_table;
		goto err;
	}
	...
err:
	ice_parser_destroy(p);
	return err;

ice_parser_destroy() then calls kfree() on every field without checking
IS_ERR():

	kfree(psr->imem_table);
	kfree(psr->mi_table);
	...

kfree() only returns early for ZERO_OR_NULL_PTR(). An ERR_PTR value goes
on to virt_to_page() and the slab free path with a bogus address.

A failed kcalloc() here can cause this. The pg_cam table has 2048
entries, so that is a multi-page GFP_KERNEL allocation. Other sources
are ERR_PTR(-EINVAL) when hw->seg is NULL, and ice_xlt_kb_get()
returning ERR_PTR(-EINVAL) for a missing key builder section or
ERR_PTR(-ENOMEM) when its kzalloc fails.

ice_parser_create() can be reached from VF raw FDIR and RSS requests.
Can a VF keep triggering an invalid free on the host this way?

Would it help to keep each result in a local variable and assign it only
on success, or to set the field to NULL before goto err?

>  

[Severity: Medium]
This is a pre-existing issue, but can the data pointer passed to
parse_item() point past the end of the package section?

ice_parser_sect_item_get() only checks the index against the section's
own count:

	hdr = section;
	if (index >= le16_to_cpu(hdr->count))
		return NULL;

	return section + data_off + index * size;

ice_pkg_enum_section() checks that the section's offset and size fit in
ICE_PKG_BUF_SIZE. Nothing checks that data_off + count * size fits
inside the section.

Counts can be as high as 65535, and entries as large as
ICE_SID_LBL_ENTRY_SIZE bytes. With a large count, the returned pointers
would go past the 4 KB package buffer. Each parse_item callback then
reads size bytes from there into the parser tables.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929224153.1455466-1-anthony.l.nguyen%40intel.com
