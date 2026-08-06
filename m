Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5AE456DF9;
	Thu,  6 Aug 2026 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030034; cv=none; b=Yg3VF//NOrV2RvoxCvtmlwqhTryPcRC3yJNSzabQ476WUjEDQ0cJ5uMhdN8AVsF8lvFfpcV32CCXuDLqkDCwDE4NNJ9UrZZnculYUqclFL0G/+wg3u17mzvLSETD9PHf01HvnkMK+Eo4BdlzbgsyIuxJkXc7bwgzg4/0xvDHzss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030034; c=relaxed/simple;
	bh=qPON/Z5uhcnHqiSm1l0Tz9oy70F6ScFRp3jeb7jaUsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk49/06zJEBKB/PquA7rBZo/QKOXYLlK8cDBQobphajD49GvJJw2ZTbZ/DRVV3kS4XAat2vY9PSydd3BlUnM5zdpM5g5sw8157zLb1h5vlhGdsTere7FDAOP71ekpC/lurUlGKOuBE3K2X4xfd+qdR7F5c+WUsjuts6CAqanwUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuqsVscH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuqsVscH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40B61F00A3D;
	Thu,  6 Aug 2026 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030032;
	bh=F5zMoDFasjiGamJ8wX9BDOmshsSWACcBGG/zQJF3YAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PuqsVscHHC2LNjC/w6Lc63cO5IU7UpvCSpzb0nbliD3q9FmMLsu5kuMtOH0QIY1dg
	 xoWQtGPlR/yTYLSdncbRsgUu/2pjM+L18Y+sOUyeWK2AunNgFUC7Cc5Cu7mVS4VYKd
	 3CpL9r2CjC6NuYDr/gDpZXLmvWr9ckks8GoY7KWYHwVsqHhmn81bJ+14mW+luC9qJH
	 ybbQx3HiOnr7YAt8gIAXsC8R8clKzTOiTGdAnSPcRrVUvzFbDmJFqIYWASzHujZ4YC
	 dJPoJWLaUG9/8RtOInn2IxVd3AnXlz0dP//HO3d7SGhAz2q+KplVOYo+O4nwDwHQm4
	 jTrK2ARvdnUVQ==
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
Subject: Re: [PATCH net v2 2/2] octeontx2-af: mcs: Fix SC resource cleanup loop
Date: Thu,  6 Aug 2026 08:27:11 -0700
Message-ID: <20260806152711.2563373-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731055310.1229213-3-subratp@marvell.com>
References: <20260731055310.1229213-3-subratp@marvell.com>
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

The SC cleanup loop in mcs_free_all_rsrc() was bounded by map->secy.max
while indexing the SC arrays, and this changes the bound to map->sc.max.
Since mcs_alloc_rsrc_bmap() sets secy.max = secy_entries - MCS_RSRC_RSVD_CNT
and sc.max = sc_entries, the two bounds differ by one.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> index a07e0b3d8d000..88658c07c391f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> @@ -738,7 +738,7 @@ int mcs_free_all_rsrc(struct mcs *mcs, int dir, u16 pcifunc)
>  	}
>  
>  	/* free sc entries */
> -	for (id = 0; id < map->secy.max; id++) {
> +	for (id = 0; id < map->sc.max; id++) {

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but the same
wrong bound still exists in mcs_clear_all_stats() in the same file, where the
"Clear SC stats" loop indexes map->sc2pf_map[] and clears MCS_SC_STATS:

	/* Clear SC stats */
	for (id = 0; id < map->secy.max; id++) {
		if (map->sc2pf_map[id] != pcifunc)
			continue;
		mcs_clear_stats(mcs, MCS_SC_STATS, id, dir);
	}

With mcs_alloc_rsrc_bmap() setting:

	res->secy.max = hw->secy_entries - MCS_RSRC_RSVD_CNT;
	...
	res->sc.max = hw->sc_entries;

and MCS_RSRC_RSVD_CNT == 1 with secy_entries == sc_entries (128/128 on
CN10K-B, 64/64 on CNF10K-B), secy.max == sc.max - 1, so SC id
sc_entries-1 is never visited by the stats loop.

Should this hunk also change the bound in mcs_clear_all_stats() to
map->sc.max?

Before this patch, SC id sc_entries-1 was never freed by
mcs_free_all_rsrc(), so no other function could take it over. Now that it
is freed and re-allocatable, can the next owner of that id read the
previous owner's pkt/octet counters?

The teardown path in cn10k_mcs_free_rsrc() always sends the clear-stats
request with the same "all" flag just before the free-resources request:

	clear_req = otx2_mbox_alloc_msg_mcs_clear_stats(mbox);
	...
	clear_req->all = all;
	...
	if (all)
		req->all = 1;

so with the stats loop still bounded by secy.max, MCS_GET_SC_STATS on the
re-allocated id would return the departing owner's values.

[Severity: Low]
Would a Fixes: tag be appropriate here? git blame on the pre-patch line
shows the secy.max bound came from:

	Fixes: cfc14181d497 ("octeontx2-af: cn10k: mcs: Manage MCS block hardware resources")

which is in released kernels since v6.1, so stable tooling can pick it up.

Could the changelog also state the user-visible impact? With the old bound,
the sc bitmap bit and map->sc2pf_map[] ownership for id sc_entries-1 leak
permanently (rvu_mcs_flr_handler() is the only other teardown path and
calls nothing else), making that SC id unallocatable, and on RX the SC CAM
entry stays enabled because mcs_ena_dis_sc_cam_entry(mcs, id, false) is
skipped.

One wording note on the changelog:

> The SC resource cleanup loop was incorrectly iterating over secy.max
> instead of sc.max. This patch fixes to use correct value.

Documentation/process/submitting-patches.rst asks for imperative mood and
discourages "This patch"; something like "Use sc.max as the loop bound"
would match.
