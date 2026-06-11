Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFEE2874E3
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191128; cv=none; b=AAxKhCd/jYxCAIZgAQwLa+piNVlWDSkmXod96WXwFE+Y95DUeBNnGLenvzfZdXOAnvKGM8ORdjcW/H6v08pH+w/J3YGaqtoxXV/KB6bZ7tKSoGu27Zjq0uvcB96QoiYOopVEDHDJds6OsHCWO+sS/FQuSvaA+cgJCzGLFTPFoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191128; c=relaxed/simple;
	bh=9BOfNwNrpLpokmhqH2nCi7oW+bcQhdiY+nEjbBFPqDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVP1POuwtdmC9zbe+2gXRkjXrvblgN1IfEmb3Ay5iDNKPqSiu25a1REpfWPzSRcid3zJCMGjrqGK4NLBhjs7ak3UxLcNM8l9tf3giBobEOp5ybNW6Xuny4qZhkFaRMTx1wDRQ1VApEQrJZ3crGxb985QQqeGJkKe/rNgqwEzarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw2gSCTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw2gSCTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D021F00893;
	Thu, 11 Jun 2026 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191126;
	bh=luPk7XtTdF63BSGXgqfrXl0bkhM4xLkZXbzQ1qNiBRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zw2gSCTYdt7lXVgDEx5Bqzwq5BFIEXkss4X+FDcWSJq8ONdbWAC9GQKOymq43D0fM
	 xBDmgA6baUPNwdpQj9gSTGiSlMyUJeJq70/lW08Rr7GBnt3UPKeHSx7hnKGhw/yOhD
	 4pxU/I7dJLm4I9Fg85quaGcGaZrbxLei1mGS4xb/GJZOWu+W5/qoWZZYzwqRa6TBG1
	 mpsaIadSawP7YyhfevDD310B4nHuXHMgboU4EjZ2tOdzU43ylPhNXNUU/8lFoEoGtk
	 VDFLpqUM4n1f2EQcXkMRApK5mFohLdxuwld+Ba6PsflICa4R71m6PQYWBuprikcfCW
	 ib5F+8XJ2kZ0A==
Date: Thu, 11 Jun 2026 16:18:43 +0100
From: Simon Horman <horms@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com, kuba@kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: libwx: support vf per-queue
 statistics via ethtool -S
Message-ID: <20260611151843.GS3920875@horms.kernel.org>
References: <20260608103946.25786-1-mengyuanlou@net-swift.com>
 <20260608103946.25786-4-mengyuanlou@net-swift.com>
 <20260611064859.GP3920875@horms.kernel.org>
 <F78E77E5-D224-41D2-886B-04989C054219@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F78E77E5-D224-41D2-886B-04989C054219@net-swift.com>

On Thu, Jun 11, 2026 at 04:46:08PM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2026年6月11日 14:48，Simon Horman <horms@kernel.org> 写道：
> > 
> > On Mon, Jun 08, 2026 at 06:39:46PM +0800, Mengyuan Lou wrote:
> >> Add per-queue TX/RX packet and byte counters to the VF ethtool stats
> >> table.
> >> The stats length is now dynamically determined based on whether the
> >> device is a VF or PF via wx_stats_len().
> >> 
> >> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> >> ---
> >> .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 48 +++++++++++++++----
> >> drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  4 ++
> >> .../net/ethernet/wangxun/libwx/wx_vf_common.c |  2 +
> >> 3 files changed, 44 insertions(+), 10 deletions(-)
> >> 
> >> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> >> index 30c6ef6103ac..86f6ac63acf7 100644
> >> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> >> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> >> @@ -48,6 +48,10 @@ static const struct wx_stats wx_gstrings_stats[] = {
> >> WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
> >> };
> >> 
> >> +static const struct wx_stats wx_gstrings_stats_vf[] = {
> >> + WX_STAT("non_eop_descs", non_eop_descs),
> >> +};
> >> +
> > 
> > The AI-generated review available at https://netdev-ai.bots.linux.dev/sashiko/
> > flags that this is user-exposed and probably could benefit from a bit
> > more explanation in the patch description.
> > 
> >> static const struct wx_stats wx_gstrings_fdir_stats[] = {
> >> WX_STAT("fdir_match", stats.fdirmatch),
> >> WX_STAT("fdir_miss", stats.fdirmiss),
> >> @@ -69,15 +73,26 @@ static const struct wx_stats wx_gstrings_rsc_stats[] = {
> >> #define WX_QUEUE_STATS_LEN ( \
> >> (WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
> >> (sizeof(struct wx_queue_stats) / sizeof(u64)))
> >> -#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
> >> #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
> >> #define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
> >> -#define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
> >> +
> >> +static inline unsigned int wx_global_stats_len(const struct wx *wx)
> >> +{
> >> + return wx->pdev->is_virtfn ?
> >> +        ARRAY_SIZE(wx_gstrings_stats_vf) : ARRAY_SIZE(wx_gstrings_stats);
> >> +}
> > 
> > Please don't use the inline keyword in .c files unless there is a
> > demonstrable - usually performance - reason to do so. Rather, please
> > let the compiler inline code (or not).
> > 
> > It is of course fine to use the inline keyword in .h files.
> 
> Ok，I will drop it.
> > 
> >> +
> >> +static inline unsigned int wx_stats_len(const struct wx *wx)
> >> +{
> >> + struct net_device *netdev = wx->netdev;
> > 
> > netdev seems unused.
> > 
> > Flagged by AI-generated review on sashiko.dev 
> 
> 
> #define WX_NUM_RX_QUEUES netdev->num_tx_queues
> #define WX_NUM_TX_QUEUES netdev->num_tx_queues
> 
> #define WX_QUEUE_STATS_LEN ( \
> (WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
> (sizeof(struct wx_queue_stats) / sizeof(u64)))
> 
> netdev is used.

Thanks, sorry for missing that.

Perhaps it would clearer if WX_NUM_RX_QUEUES and WX_NUM_TX_QUEUES took
arguments. And in that case, perhaps were functions rather than macros.
But maybe that is orthogonal to this patch-set.

> 
> > 
> >> +
> >> + return wx_global_stats_len(wx) + WX_QUEUE_STATS_LEN;
> >> +}
> >> 
> >> int wx_get_sset_count(struct net_device *netdev, int sset)
> >> {
> >> struct wx *wx = netdev_priv(netdev);
> >> - int len = WX_STATS_LEN;
> >> + int len = wx_stats_len(wx);
> >> 
> >> switch (sset) {
> >> case ETH_SS_STATS:
> >> @@ -100,8 +115,11 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
> >> 
> >> switch (stringset) {
> >> case ETH_SS_STATS:
> >> - for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
> >> - ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
> >> + for (i = 0; i < wx_global_stats_len(wx); i++)
> >> + if (wx->pdev->is_virtfn)
> >> + ethtool_puts(&p, wx_gstrings_stats_vf[i].stat_string);
> >> + else
> >> + ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
> > 
> > The AI-generated review at https://netdev-ai.bots.linux.dev/sashiko/ also
> > flags that these seem to cover statistics that can be exposed via
> > netdev_stat_ops, which is preferred.
> > 
> > If consistency with the PF stats is desired for VF stats, then perhaps
> > netdev_stat_ops can also be implemented for PF queues.
> 
> Netdev_stat_ops will add in another. changlogs v3 just remove it.
> > 
> >> if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
> >> for (i = 0; i < WX_FDIR_STATS_LEN; i++)
> >> ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
> > 
> > ...
> 
> 
