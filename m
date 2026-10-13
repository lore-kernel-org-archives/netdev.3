Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FC48F022;
	Tue, 13 Oct 2026 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870300; cv=none; b=eIORZw4n+LAnwvhPrhtu7pY0RBl9vc2STu1zh7xFGV7NhQnnZxQsfSOcgQr4NyD+jwiNaL4toZb0YPNL2CXddnShTsH4cinG6VWd4mPT0wWSF+q1udGbsKZ6SSGF0uMXaCEr99hMQqMCWk2+MSQBWlHJ5KAwbTROECW3+75ERLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870300; c=relaxed/simple;
	bh=2gUcawCnp6FwIHyjtCutpnyuCvSTjVglyDNOEdgSQCI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p7jbkoJpR6PgjXYE1G4GBTSe3gMIM+8Sxb+yZ0JPcAwVJS3rrV06+ithbUtMRss1opoY3nFoHT0eodWIbENoXmGsGGDlRu1GufwoxTQHjVaeWInTi7w7LTf7iC8U3MhM3KhLOOe50gGMjqtXkaEc496cSTYOcI6NJyW+QHl8Z5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2M4LReO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2M4LReO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09431F000FF;
	Tue, 13 Oct 2026 05:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870298;
	bh=QkhKxBvIrBEXknfY7QBDd71iJ0rLIgjiEN2rQOIW9lc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N2M4LReOz1YyDxpDkoScahpp5TFems4Rs6AM5jdKS0OKWh0x0mrhbO1npDlx9dIsl
	 4rFBrS0ZNM7MTzu2aDiBUaswyJJ+DCY6358pAmTMjC24wuq17ROnEPFgs4sKcHLTgh
	 yfWTUfeI623MRZwL+bAi5ZWna+5qwd+p+p0TPggDppnG3NoelSWiciZpIPlKhAl9Q3
	 ekn6zS3wY69R7e+H+0IqLjo6g84x34c2eCIvEBT1WJ4YMnnXrhju2JQJ0AtcTt2W1U
	 XVioqTKFsQNtDePLBJROVXvGsSbQ2EfZBGbdaOZGOui4vS2CBp5AoIKrkYDiFlE9cU
	 sz4J1qFfui6RQ==
Subject:
 Re: [PATCH net 2/2] bnge: cap RSS contexts and RX rings to the RSS table size
From: netdev-bot+sashiko@kernel.org
To: vikas.gupta@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Date: Tue, 13 Oct 2026 05:44:57 +0000
Message-ID: <179187029731.434549.16806543347969284166@kernel.org>
In-Reply-To: <20261012054325.1782819-3-vikas.gupta@broadcom.com>
References: <20261012054325.1782819-3-vikas.gupta@broadcom.com>
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

- [Low] The commit message says the overflow happens with "577 or more RX
  rings".
- [Low] The commit message says the pad computation "in
  bnge_set_dflt_rss_indir_tbl() and bnge_modify_rss() underflows into a…

--

bnge: cap RSS contexts and RX rings to the RSS table size

This patch caps the value returned by bnge_cal_nr_rss_ctxs() at
BNGE_RSS_TABLE_MAX_TBL. It also limits max_rx in _bnge_get_max_rings() to
BNGE_MAX_RSS_TABLE_ENTRIES, so the RSS context count and the indirection
table size fit the arrays, which hold 8 contexts and 512 entries.

> bnge_cal_nr_rss_ctxs() has no upper bound. The VNIC holds at most
> BNGE_RSS_TABLE_MAX_TBL (8) RSS contexts, in fw_rss_cos_lb_ctx[] and in
> a 512-entry indirection table and DMA buffer. With 577 or more RX rings
> the function returns more than 8, so bnge_setup_vnic() writes past

[Severity: Low]
Is 577 the right threshold here? Here is bnge_adjust_pow_two() in
bnge_resc.h:

    u32 blks = total_ent / ent_per_blk;

    if (!blks)
        return 1;

    return roundup_pow_of_two(blks + 1);

With rx_rings = 512, bnge_cal_nr_rss_ctxs() passes 511, so blks = 7 and
the result is 8 contexts.

With rx_rings = 513 it passes 512, so blks = 8 and roundup_pow_of_two(9)
returns 16 contexts.

So the overflows described here seem to start at 513 RX rings. 577 is
one of the values in the 513..1024 range that also give 16. The code
change caps max_rx at 512, so it covers that whole range. Only the number
in the message looks wrong.

Could the message say 513 instead of 577?

> vnic->fw_rss_cos_lb_ctx[], bnge_set_dflt_rss_indir_tbl() and
> bnge_fill_hw_rss_tbl() write past the indirection table and its DMA
> buffer, and the pad computation in bnge_set_dflt_rss_indir_tbl() and
> bnge_modify_rss() underflows into a huge memset().

[Severity: Low]
Where is bnge_modify_rss() defined? I couldn't find a function by that
name under drivers/net/ethernet/broadcom/. bnge also doesn't seem to have
a set_rxfh or set_channels path where one would live.

The only pad underflow site in bnge seems to be in
bnge_set_dflt_rss_indir_tbl():

    pad = bd->rss_indir_tbl_entries - max_entries;
    if (pad)
        memset(&rss_indir_tbl[i], 0, pad * sizeof(*rss_indir_tbl));

Was this reference carried over from bnxt? Should the message list only
the sites that exist in bnge, i.e. bnge_setup_vnic(),
bnge_fill_hw_rss_tbl() and bnge_set_dflt_rss_indir_tbl()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012054325.1782819-1-vikas.gupta%40broadcom.com
