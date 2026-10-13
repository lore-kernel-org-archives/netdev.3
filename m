Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F148E0D9;
	Tue, 13 Oct 2026 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870298; cv=none; b=V7ewEG4f6MC93lTgfVn6pe8eCInrbaj+yVWO3JKTwFA+2iCkWTdZ8OQgdXb7tK4AThYbec9RvKeoYys0rsCrNr4RnQ0vHAyuNGGOAuiHTUbdaOmdGdFeFrlZXYdXp/QGYZbSEvVcK0N4YAxdHOWL5jkfw03nU38NfNj1bYO0Yhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870298; c=relaxed/simple;
	bh=Fdste535rEXvSqyHFYKnVvfyyMxmCpBdeIFAnY46XvI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mi+wCSLTiWVBQuoFV0NppjKJThHoKn/nyP+fQPYlvck+WVrOLS/z+w0aiJAgJ7aAZSr1XrS6k540oNEFTclz7W37T8Vai9lJZarSds/h6u5z7DKwZybpAzjD3qoD9v+LDGqzWSOAkoITMxBT8/ywz4eCF+D/VH1gcuhsohRgtG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+IgWgzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+IgWgzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D001F00893;
	Tue, 13 Oct 2026 05:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870297;
	bh=k6xfCLLC05/lGsRFR0mm2sjp2aJXnkUseNv1rZhAACQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h+IgWgzbspk3IwUWMbYOTaTPPtwwsinpfifl8jvG1I3B0PAm9id02Vjnzg9Lmuxwv
	 Yy5HObmS6pZCs5zkG0iaavt1zfEZ8wrT/lOD7YCLN9rYNJ7xNz2lZEEizc2pZtNhcH
	 JTc96EsnMjma3ZrmHT/hNZEmWIdPS/BWifOxwOAAv+GcqksiLux2ry4c7T0VoDq3oV
	 AmA2Wxhsc46lyRrigroohZSNi5xAcgYEUP1JwII0Z+jXyE1Ni7DH6u2onrd0ExLbRT
	 BdBCSyMKJa8tIBnpray8oqEOQtmzfW59ZA8QnYCSdDLA9RS7w6flN7+k81zLLITe3W
	 pNmIZMxJcEHIA==
Subject:
 Re: [PATCH net 1/2] bnge: fix RSS table sizing for large RX ring counts
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Tue, 13 Oct 2026 05:44:56 +0000
Message-ID: <179187029600.434549.15294077033511744217@kernel.org>
In-Reply-To: <20261012054325.1782819-2-vikas.gupta@broadcom.com>
References: <20261012054325.1782819-2-vikas.gupta@broadcom.com>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This commit opens a heap and DMA out-of-bounds write window for
  513-576 RX rings.
- [Medium] The commit message is wrong about the completion ring.

--

bnge: fix RSS table sizing for large RX ring counts

This changes bnge_adjust_pow_two() to always add one block before rounding
up to a power of two. RX ring counts whose quotient is already a power of
two now get an RSS indirection table that covers all rings. The same
helper also sizes the RX, TX, agg and completion ring pages.

> Always add one block before rounding up. The same helper sizes the ring
> pages; their count only changes when the number of entries divided by
> the entries per page is a power of two of 2 or more, which does not
> happen with the default ring sizes.

[Severity: Medium]
Is this accurate for the completion ring? It holds for the RX, TX and agg
rings at the default depth of 511. The completion ring, though, is sized
from more than the default depths:

bnge_netdev.c:bnge_set_ring_params() {
    ...
	max_rx_cmpl = bn->rx_ring_size;

	if (bn->priv_flags & BNGE_NET_EN_TPA)
		max_rx_cmpl += bd->max_tpa_v2;
	ring_size = max_rx_cmpl * 2 + agg_ring_size + bn->tx_ring_size;
	bn->cp_ring_size = ring_size;

	bn->cp_nr_pages = bnge_adjust_pow_two(ring_size, CP_DESC_CNT);
    ...
}

Take BNGE_PAGE_SIZE of 8192 (for example arm64 with 16K pages), TPA off
and default 511/511 rings. Then ring_size is 2 * 511 + 511 = 1533 and
CP_DESC_CNT is 512, so the quotient is 2. The old code returned 2 pages,
which gives a cp_bit of 1024 (fewer slots than cp_ring_size). The new code
returns 4.

With 4K pages and TPA on, agg_ring_size is 2044 and ring_size is
3577 + 2 * max_tpa_v2. max_tpa_v2 comes from firmware max_aggs_supported.
For values of 260..387, the quotient over a CP_DESC_CNT of 256 is 16, and
the page count goes from 16 to 32.

Could the commit message mention this change to completion ring sizing?

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
> index b62a634669f62..c0b6992d7f828 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
> @@ -81,13 +81,10 @@ bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
>  {
>  	u32 blks = total_ent / ent_per_blk;
>  
> -	if (blks == 0 || blks == 1)
> -		return ++blks;
> +	if (!blks)
> +		return 1;
>  
> -	if (!is_power_of_2(blks))
> -		blks = roundup_pow_of_two(blks);
> -
> -	return blks;
> +	return roundup_pow_of_two(blks + 1);

[Severity: High]
For 513..576 RX rings, bnge_cal_nr_rss_ctxs() calls
bnge_adjust_pow_two(rx_rings - 1, 64), which gives a quotient of 8. The
old code returned 8, but this now returns 16. Nothing clamps the result
to BNGE_RSS_TABLE_MAX_TBL (8):

bnge_resc.c:bnge_cal_nr_rss_ctxs() {
	...
	return bnge_adjust_pow_two(rx_rings - 1,
				   BNGE_RSS_TABLE_ENTRIES);
}

Can this overflow bd->rss_indir_tbl[]? bnge_alloc_rss_indir_tbl()
allocates BNGE_MAX_RSS_TABLE_ENTRIES (512) entries. On the first
reservation, bnge_reserve_rings()->bnge_set_dflt_rss_indir_tbl() gets a
max_entries of 16 * 64 = 1024:

bnge_resc.c:bnge_set_dflt_rss_indir_tbl() {
	...
	for (i = 0; i < max_entries; i++)
		rss_indir_tbl[i] = ethtool_rxfh_indir_default(i,
							      bd->rx_nr_rings);

	pad = bd->rss_indir_tbl_entries - max_entries;
	if (pad)
		memset(&rss_indir_tbl[i], 0, pad * sizeof(*rss_indir_tbl));
}

The loop writes 512 entries past the end. Then the u16 pad wraps to
512 - 1024 = 65024, so the memset() clears about 254 KB beyond that.

The other RSS consumers also look sized for at most 8 contexts:

- bnge_setup_vnic() calls bnge_hwrm_vnic_ctx_alloc(bd, vnic, i) for
  i < 16. That stores into vnic->fw_rss_cos_lb_ctx[], which has only
  BNGE_MAX_CTX_PER_VNIC (8) entries.

- bnge_fill_hw_rss_tbl() uses a tbl_size of 1024. It reads
  rss_indir_tbl[] past 512 entries and writes 4096 bytes into
  vnic->rss_table. bnge_alloc_vnic_attributes() sizes that buffer from
  BNGE_MAX_RSS_TABLE_SIZE (2048 bytes plus the hash key).

- bnge_hwrm_vnic_set_rss() reads fw_rss_cos_lb_ctx[8..15]. It also moves
  ring_grp_tbl_addr past the end of the coherent allocation, so firmware
  would DMA read outside the buffer.

Configurations with 577 or more RX rings already overflowed before this
patch, but this patch lowers the threshold to 513. Hitting it needs at
least 513 default RSS queues from bnge_net_init_dflt_rings() and firmware
that grants that many rings.

The next patch in the series, "bnge: cap RSS contexts and RX rings to the
RSS table size", closes this. It adds a min_t() against
BNGE_RSS_TABLE_MAX_TBL in bnge_cal_nr_rss_ctxs() and caps *max_rx at
BNGE_MAX_RSS_TABLE_ENTRIES in _bnge_get_max_rings().

Could that cap be folded into this patch, or moved ahead of it, so this
commit can be bisected or backported safely on its own?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012054325.1782819-1-vikas.gupta%40broadcom.com
