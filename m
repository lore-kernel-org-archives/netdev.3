Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9E4D2ED7;
	Thu,  1 Oct 2026 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846018; cv=none; b=qWS05930ebTA/aRllvImXlORQqzIuYMlJ4/VkXgAoL/o0EZpLNvFs/0ZWomYR5g7P3UjjHwm9aixdBTsCNDUOs9PgGR2DSmfkNQzsVfsAZ4uvoChK81NHrqlRZm7e4adcY6+cTUm+LWQHm+RGHiQcZxcFU/9gacOCLx150Mt8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846018; c=relaxed/simple;
	bh=4pZyqCJ5YhsQIyVSiYBsOGWYzPqKgYa4HiND+uLIDtU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHGukXfmW+ELJIvUWQIvB0pChYkbz8oEcgr42tLgZY2F1dcuVWhzN2bxcSdGQFe0v5vJBeIReAeEIWRRyFMTi2sldKYrERzXZ0B2CQB7GiwmCnG0ZsDvOxB+zwxT1rFqsRjzbqpRYlyuuNtdeGDa2Y0Bli/9LPubB3oaTEA2odk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HreUikyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HreUikyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69B01F000FF;
	Thu,  1 Oct 2026 09:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846012;
	bh=MqS1QtIJieQo69+yO6R1p5ROhvTTvH62rYXwYuKa3TU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HreUikyPOcfKbhSlFiDEScvPOiu1g7PNaeBWsK8CJGfYYG1oO3guRXSzSVS3pErXG
	 cNv1X40h9gMif9oCDCqWHqDrWzl4ovM6mIMZxUliEjXjNpCwFg3V9VF2X7IQ2GDJEQ
	 7GnFJf1qmBhY/fqQLnwvENlBKxHLLcS0YvgenyLiBY/rytWooEgqOlmd1wb47zwlX0
	 eM8gaYO8IpnpefBeGLcuGfmNtyaPKFgYCdJZvTUMwJeXSoa5DH9Q1LELyoCOazi0Xb
	 F9GdTl5K2kXsHhsHDVCl7hZTXH7mnDroKlusIyKHiefqYhhP9gb4yoi1Vk+wlZqNt3
	 15HUuo+D3l7bg==
Subject: Re: [net-next, v4 01/10] bnge: restructure VNIC and filter code
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Thu, 01 Oct 2026 09:13:31 +0000
Message-ID: <179084601149.434549.2509756647246460199@kernel.org>
In-Reply-To: <20260928061307.1172344-2-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-2-vikas.gupta@broadcom.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not describe everything the patch
  changes.

Pre-existing issues:
- [Medium] The RSS arrays are sized for at most 8 contexts, but the
  context count that indexes them has no upper bound.
- [Medium] bnge_cal_nr_rss_ctxs() returns too few RSS contexts for some
  ring counts, so some receive queues never appear in the default…
- [Medium] At this commit, a duplicate unicast MAC shares one refcounted
  filter, which causes a firmware filter leak and a double firmware free.

--

bnge: restructure VNIC and filter code

This patch moves the VNIC and L2 filter code out of bnge_netdev.c, and the
default RSS indirection table helper out of bnge_resc.c, into new
bnge_vnic.c/h and bnge_filter.c/h files. The commit message describes it
as a reorganization with no functional change, in preparation for
multi-VNIC, RSS context and NTUPLE filter support.

> Move VNIC and L2 filter code out of bnge_netdev.c into dedicated
> bnge_vnic.c/h and bnge_filter.c/h files in preparation for multi-VNIC,
> RSS context, and NTUPLE filter support.
>
> This is a code reorganization with no functional change, which helps
> centralize the functions into their respective modules.

[Severity: Low]
This isn't a bug, but does this description cover everything the patch
changes? Besides moving code out of bnge_netdev.c, the patch also:

- renumbers constants while turning them into enums: BNGE_FLTR_TYPE_L2
  goes from 2 to 1, BNGE_FLTR_FW_DELETED from 2 to 1,
  BNGE_VNIC_MCAST_FLAG from 4 to BIT(1) and BNGE_VNIC_UCAST_FLAG from 8
  to BIT(2)

- renames the struct bnge_filter_base members hash and list to hlist and
  list_node

- renames bnge_rss_ctxs_in_use() to bnge_get_total_rss_ctxs() and drops
  the rx_rings argument of bnge_get_total_vnics()

- narrows types: j in bnge_fill_hw_rss_tbl() goes from u32 to u16, the
  ring ids now go through a u16 temporary, and the loop counter in
  bnge_set_dflt_rss_indir_tbl() goes from int to u16

- makes bnge_set_dflt_rss_indir_tbl() and bnge_hwrm_vnic_rss_cfg()
  non-static, and moves bnge_set_dflt_rss_indir_tbl() out of
  bnge_resc.c, not bnge_netdev.c

All of these values seem to stay inside the driver, so runtime behaviour
looks unchanged. Even so, the removed and added lines can't be checked
against each other as a pure move.

Could the commit message list these changes? Another option is to split
the patch into a pure move followed by a cleanup.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> new file mode 100644
> index 0000000000000..a8bb441ebef9a
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> @@ -0,0 +1,113 @@

[ ... ]

> +static struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
> +						    struct bnge_l2_key *key,
> +						    u32 idx)
> +{
> +	struct bnge_l2_filter *fltr;
> +
> +	rcu_read_lock();
> +	fltr = __bnge_lookup_l2_filter(bn, key, idx);
> +	if (fltr)
> +		refcount_inc(&fltr->refcnt);
> +	rcu_read_unlock();
> +	return fltr;
> +}

[ ... ]

> +int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
> +			      const u8 *mac_addr)
> +{
> +	struct bnge_l2_filter *fltr;
> +	struct bnge_l2_key key;
> +	int rc;
> +
> +	ether_addr_copy(key.dst_mac_addr, mac_addr);
> +	key.vlan = 0;
> +	fltr = bnge_alloc_l2_filter(bn, &key, GFP_KERNEL);
> +	if (IS_ERR(fltr))
> +		return PTR_ERR(fltr);
> +
> +	fltr->base.fw_vnic_id = bn->vnic_info[vnic_id].fw_vnic_id;
> +	rc = bnge_hwrm_l2_filter_alloc(bn->bd, fltr);

[Severity: Medium]
This is a pre-existing issue that this patch only moves. What happens when
a unicast address matches a filter already in bn->l2_fltr_hash_tbl?

For example, "bridge fdb add <own-mac> dev X self" ends up in
dev_uc_add_excl(). At this commit, bnge_cfg_rx_mode() copies every uc
entry and does not skip dev_addr.

In that case bnge_alloc_l2_filter() returns the existing object, with an
extra reference taken in bnge_lookup_l2_filter().
bnge_hwrm_set_vnic_filter() still calls bnge_hwrm_l2_filter_alloc() on
that object, and this overwrites its only firmware handle:

bnge_hwrm_l2_filter_alloc() {
    ...
    fltr->base.filter_id = resp->l2_filter_id;
    ...
}

l2_filters[0] and l2_filters[i] then point to the same object. On
teardown, is the same filter_id freed twice in firmware while the first
firmware filter leaks?

This appears to be fixed later in the series by "bnge: remove refcount
from L2 filter". That commit makes bnge_alloc_l2_filter() return
ERR_PTR(-EEXIST) on a lookup hit. The final bnge_cfg_rx_mode() also
skips entries equal to dev->dev_addr.

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
> new file mode 100644
> index 0000000000000..3a6c8f0a59541
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
> @@ -0,0 +1,100 @@

[ ... ]

> +void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd)
> +{
> +	u16 max_entries, pad;
> +	u32 *rss_indir_tbl;
> +	u16 i;
> +
> +	max_entries = bnge_get_rxfh_indir_size(bd);
> +	rss_indir_tbl = &bd->rss_indir_tbl[0];
> +
> +	for (i = 0; i < max_entries; i++)
> +		rss_indir_tbl[i] = ethtool_rxfh_indir_default(i,
> +							      bd->rx_nr_rings);

[Severity: Medium]
This isn't a bug introduced by this patch, since the logic is unchanged.
Still, can max_entries be too small for some ring counts?

bnge_get_rxfh_indir_size() returns bnge_cal_nr_rss_ctxs(rx_nr_rings) * 64.
bnge_cal_nr_rss_ctxs() calls bnge_adjust_pow_two(rx_rings - 1, 64):

bnge_resc.h:bnge_adjust_pow_two() {
	u32 blks = total_ent / ent_per_blk;

	if (blks == 0 || blks == 1)
		return ++blks;

	if (!is_power_of_2(blks))
		blks = roundup_pow_of_two(blks);

	return blks;
}

The extra block is added only when blks is 0 or 1. With 129..192 rings,
blks is 2 and comes back unchanged, which gives a 128-entry table. The
same thing happens for 257..320 rings (256 entries) and 513..576 rings
(512 entries).

With 160 RX rings, would queues 128..159 never get default RSS traffic,
both here and in bnge_fill_hw_rss_tbl()? For comparison, the bnxt helper
bnxt_calc_nr_ring_pages() always adds one before rounding up.

bnge_net_init_dflt_rings() sets rx_nr_rings to the minimum of
netif_get_num_default_rss_queues() and the firmware limits, so it does
not have to be a power of two.

> +
> +	pad = bd->rss_indir_tbl_entries - max_entries;
> +	if (pad)
> +		memset(&rss_indir_tbl[i], 0, pad * sizeof(*rss_indir_tbl));
> +}

[ ... ]

> +int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int rc, i, nr_ctxs;
> +
> +	nr_ctxs = bnge_cal_nr_rss_ctxs(bd->rx_nr_rings);
> +	for (i = 0; i < nr_ctxs; i++) {
> +		rc = bnge_hwrm_vnic_ctx_alloc(bd, vnic, i);

[Severity: Medium]
This is a pre-existing issue, but is nr_ctxs checked against
BNGE_MAX_CTX_PER_VNIC anywhere?

bnge_hwrm_vnic_ctx_alloc() writes vnic->fw_rss_cos_lb_ctx[ctx_idx], and
that array has BNGE_MAX_CTX_PER_VNIC (8) entries. bd->rss_indir_tbl is
always allocated with BNGE_MAX_RSS_TABLE_ENTRIES (512) entries, and
vnic->rss_table is sized by BNGE_MAX_RSS_TABLE_SIZE.

With 577 or more RX rings, bnge_cal_nr_rss_ctxs() returns 16. Then:

- this loop writes past fw_rss_cos_lb_ctx[] for i >= 8

- bnge_set_dflt_rss_indir_tbl() writes 1024 entries into the 512-entry
  rss_indir_tbl, and the u16 pad subtraction wraps

- bnge_fill_hw_rss_tbl() overruns vnic->rss_table

The only limit on rx_nr_rings seems to be in bnge_net_init_dflt_rings().
It comes from netif_get_num_default_rss_queues() and the firmware ring
limits, not from BNGE_MAX_RSS_TABLE_ENTRIES. Triggering this needs a very
large host and matching firmware limits.

Should rx_nr_rings be capped to what these arrays can hold?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com
