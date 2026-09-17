Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1F3803F9;
	Thu, 17 Sep 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610625; cv=none; b=QKWyvtnobCf6WdAX4SR65dg9i/tGCztoosT688aVyQCXF3FAGc07E6N7Fw+ZmQMeWnoXF1etTT7Yp7JK0b5JUfqyy11crMCO3m49f5V+Umn89ganEOYp7FDDKyUXETRdfaX/+/SiuAkYgeZCWaf+pU1/H27lSwrnhXKkaVNLsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610625; c=relaxed/simple;
	bh=Zz7XYsHRf8QwO/CQGlDSPZ3RfgcgbOoUh1Be8tYvuX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF9rdpUxYnvn3BvX8wQKg8ONw/cO4c3bo8KzctCQUPhJYDURS1/V7XcByDr4cqgFCrbQxMqEmZPSq4t/nnszhWLyqTJkrXHtK7zZHT0A0wdQCJpxNc6pjoY8qjUCjFAZNXBtrESqU4/OYdk2nZgTCYoCXh0VLlFWY/HZNO6jnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebU6BIrH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebU6BIrH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2185F1F00893;
	Thu, 17 Sep 2026 02:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610623;
	bh=w/5YR62Cpr9/wTU+aL3Zj7tdV66cXYGw1O1iYhKy+Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ebU6BIrHkDYr31KAbpHwuNZzt94keP+L7SfQeKYSLfKWTe4CEx8ggJTh3rbnb0fbg
	 57O+KqJBzok/TANt8glaWapDEMiB19ld+hJCk4EDx4NaBOJEwF+AhzIq2oAGb7hPKq
	 UJXKfSRhCp/2O5Vn4s3yy4RyF616Ul3Bu3AY/vUmQvqyDvWfLBUqCV7WdYjJC24YLZ
	 iuSg2/hX8FLIBJRoUq1c/IvTOzdxabyoppV6G5R/brbPt4pzTLojHo1GyuYfC7H30x
	 Sbhbmf51SKvCPI9Esv16I2LrGbS3IyqixR8GYCgOYu7vkJW532czyfNeeiv3QU8yHr
	 yWUoY0B51NaCw==
From: Jakub Kicinski <kuba@kernel.org>
To: subratp@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	sbhatta@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sgoutham@marvell.com
Subject: Re: [PATCH net v6 2/2] octeontx2-af: mcs: Fix SC resource cleanup loop
Date: Wed, 16 Sep 2026 19:03:42 -0700
Message-ID: <20260917020342.2544346-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910062657.3712256-3-subratp@marvell.com>
References: <20260910062657.3712256-3-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
octeontx2-af: mcs: Fix SC resource cleanup loop

This changes the SC loops in mcs_clear_all_stats() and mcs_free_all_rsrc()
to use map->sc.max instead of map->secy.max as the loop bound.  Since
mcs_alloc_struct_mem() sets secy.max = hw->secy_entries - MCS_RSRC_RSVD_CNT
while sc.max = hw->sc_entries, the old bound was one short.

> octeontx2-af: mcs: Fix SC resource cleanup loop
>
>     The SC resource cleanup loop was incorrectly iterating over secy.max
>     instead of sc.max. Use sc.max as the loop bound.

[Severity: Medium]
The message describes a single "SC resource cleanup loop", but the diff
changes two loops in two different functions: the SC statistics loop in
mcs_clear_all_stats() and the SC free loop in mcs_free_all_rsrc().  Could
the message mention both call sites, since one of them is statistics
clearing rather than resource cleanup?

Could the message also state the observable consequence?  The numbers make
this look like an off-by-one that skipped exactly the highest SC id:

mcs_alloc_struct_mem():
	res->secy.max = hw->secy_entries - MCS_RSRC_RSVD_CNT;
	...
	res->sc.max = hw->sc_entries;

with MCS_RSRC_RSVD_CNT == 1, and both HW variants setting
secy_entries == sc_entries (128 for cn10kb, 64 for cnf10kb).  So SC id 127
(63 on cnf10kb) could be handed out by rvu_alloc_rsrc() but was never
freed on teardown or FLR, its sc2pf_map[] entry stayed owned by a dead
pcifunc, its RX SC CAM entry stayed enabled because
mcs_ena_dis_sc_cam_entry() was skipped, and its stats were never cleared
for the next owner.

That information seems useful for anyone deciding whether to backport this.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> index 211c10aa5880f..30c672d526a0c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c

[ ... ]

> @@ -738,7 +738,7 @@ int mcs_free_all_rsrc(struct mcs *mcs, int dir, u16 pcifunc)
>  	}
>  
>  	/* free sc entries */
> -	for (id = 0; id < map->secy.max; id++) {
> +	for (id = 0; id < map->sc.max; id++) {
>  		if (map->sc2pf_map[id] != pcifunc)
>  			continue;
>  		mcs_free_rsrc(&map->sc, map->sc2pf_map, id, pcifunc);

[Severity: Low]
This isn't a bug introduced by this patch, but the new bound now passes
sc_id == 127 into mcs_ena_dis_sc_cam_entry() a few lines below, in the
dir == MCS_RX case.  That helper picks the second register but shifts by
the unmasked index:

mcs_ena_dis_sc_cam_entry() {
	reg = MCSX_CPM_RX_SLAVE_SC_CAM_ENA(0);
	if (sc_id > 63)
		reg = MCSX_CPM_RX_SLAVE_SC_CAM_ENA(1);

	if (ena)
		val = mcs_reg_read(mcs, reg) | BIT_ULL(sc_id);
	else
		val = mcs_reg_read(mcs, reg) & ~BIT_ULL(sc_id);
}

For sc_id in 64..127 (cn10kb sets hw->sc_entries = 128) the shift count is
at least 64, which is undefined in C, so this can produce a UBSAN "shift
exponent too large" report.  On arm64 the variable shift is masked to six
bits and 127 % 64 == 63, so the bit that gets touched happens to be the
intended one, and the enable side via mcs_rx_sc_cam_write() uses the same
idiom, so the two stay consistent.  Would BIT_ULL(sc_id % 64) be a
worthwhile follow-up cleanup here and in mcs_ena_dis_flowid_entry()?

[Severity: High]
This is a pre-existing issue, but this patch widens the region it applies
to from map->secy.max to map->sc.max entries, so it may be worth a look.
Is mcs_free_all_rsrc() safe to call without rvu->rsrc_lock?

The mailbox paths serialize the same bitmaps and ownership arrays:

rvu_mbox_handler_mcs_alloc_resources()
   mutex_lock(&rvu->rsrc_lock);
   ... mcs_alloc_rsrc() -> rvu_alloc_rsrc() -> __set_bit()

rvu_mbox_handler_mcs_free_resources()
   mutex_lock(&rvu->rsrc_lock);
   ... mcs_free_rsrc() / mcs_free_all_rsrc()

The FLR path does not:

__rvu_flr_handler()
   mutex_lock(&rvu->flr_lock);
   ...
   rvu_mcs_flr_handler()
      mcs_free_all_rsrc(mcs, MCS_RX, pcifunc);
      mcs_free_all_rsrc(mcs, MCS_TX, pcifunc);

rvu_alloc_rsrc() and rvu_free_rsrc() use the non-atomic __set_bit() /
__clear_bit(), so the read-modify-write of a bitmap word in the FLR work
item can race with another function's mailbox thread, and both sides also
write the same pf_map[] array.

Can a lost update here hand the same SC/SA/SECY/flowid id to two different
pcifuncs, or leak an id permanently?

[Severity: High]
This is a pre-existing issue and not introduced by this patch, but
mcs_free_rsrc() is the callee whose use this loop widens, so mentioning it
here.  Is req->rsrc_id range checked anywhere before it reaches this
function?

rvu_mbox_handler_mcs_free_resources() validates only req->mcs_id and then
passes the caller-supplied u8 rsrc_id (0-255, struct mcs_free_rsrc_req)
straight through:

	switch (req->rsrc_type) {
	case MCS_RSRC_TYPE_FLOWID:
		rc = mcs_free_rsrc(&map->flow_ids, map->flowid2pf_map, req->rsrc_id, pcifunc);
		mcs_ena_dis_flowid_entry(mcs, req->rsrc_id, req->dir, false);

mcs_free_rsrc() then dereferences it with no bound against rsrc->max:

	/* Check if the rsrc_id is mapped to PF/VF */
	if (pf_map[rsrc_id] != pcifunc)
		return -EINVAL;

	rvu_free_rsrc(rsrc, rsrc_id);
	pf_map[rsrc_id] = 0;

The pf_map arrays are sized from hardware capability in
mcs_alloc_struct_mem(): flowid2pf_map, secy2pf_map and sc2pf_map are 128
u16 entries on cn10kb (64 on cnf10kb), sa2pf_map is 256 (128 on cnf10kb).
So a rsrc_id above the corresponding max reads up to 254 bytes past the
devm_kcalloc() allocation.

If that out-of-bounds slot happens to contain the caller's pcifunc, does
this then also write out of bounds?  rvu_free_rsrc() does
__clear_bit(rsrc_id, rsrc->bmap) on a bitmap allocated as
BITS_TO_LONGS(max) longs by rvu_alloc_bitmap(), which is 16 bytes for
max 127/128, and pf_map[rsrc_id] = 0 stores past the array.  Adjacent slab
allocations make this plausible: flowid2pf_map and secy2pf_map are both
256 bytes and allocated back-to-back, so flowid2pf_map[128 + i] can read
secy2pf_map[i], which legitimately holds the caller's pcifunc after an
"alloc all" request.

Separately, mcs_ena_dis_flowid_entry(), mcs_clear_secy_plcy() and
mcs_ena_dis_sc_cam_entry() are called with the same unvalidated index
regardless of the mcs_free_rsrc() return code, so the index also reaches
the MMIO offset arithmetic.  Should the handler reject rsrc_id >= max for
the requested type before the switch?

[Severity: Medium]
This is a pre-existing gap rather than something this patch introduces,
but since mcs_free_all_rsrc() is the "free everything owned by pcifunc"
helper being touched: should it also release ctrlpktrule resources?

It frees flow_ids, secy, sc and sa, but there is no map->ctrlpktrule /
ctrlpktrule2pf_map loop, and rvu_mcs_flr_handler() calls only
mcs_free_all_rsrc() for RX and TX.  The only release path is the req->all
branch of mcs_free_ctrlpktrule(), which needs an explicit mailbox request
from the function that just went through FLR.

So a rule allocated via rvu_mbox_handler_mcs_alloc_ctrl_pkt_rule() stays
marked allocated in map->ctrlpktrule and stays enabled in hardware, since
MCSX_PEX_{RX,TX}_SLAVE_RULE_ENABLE is only cleared by
mcs_free_ctrlpktrule().  Recovery appears to require a driver reload.

No in-tree consumer allocates these rules today (nothing under
octeontx2/nic/ references ctrl_pkt_rule, and cn10k_macsec.c only uses
FLOWID/SECY/SC/SA), so this needs an out-of-tree or other user of the AF
mailbox to trigger.
