Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBD2FFFB5;
	Mon, 15 Jun 2026 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566775; cv=none; b=H7fjPrRi9Ez9tzjluwdCu9PxUS6vg1OfdXW3ic6dAwQPQhEaOc4udd3s6fvkns/+OFYGKiE/sfNH3yjXr2HZfagbm8Q4dwS9gAbd4Md9afPB5Y6T+HBGazuK6eKcdVymNqsOHTfP7Jo0xo4J+u/hnR3mo2h+TPbimH9Lbw5i4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566775; c=relaxed/simple;
	bh=SHvzDj1OR4GhwL93Bhi84vBiepAvE9mnwY/OVp9q5C8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mImKiBDg0CiOvQ79L0fQdmyDdcbwEoMEh91bS51aCtlqe1CwmcKXyv5I96AriA9+oIoJQolf9OYihOckv105KjBeQeMErrEPwQrH0P72qQc3FNxFb19spkOt2SFxKNA0yL7Wsc5r9wEBaywD9t+rQgntBNduduPn5xVNTxFLGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPMgCvK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPMgCvK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22CE1F000E9;
	Mon, 15 Jun 2026 23:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566773;
	bh=GNNjaKv8UKkb1Uz9SG65/M2zLsNI/nbiv3MfshiBmYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fPMgCvK7zvSL4WN+HNIYzac/rPEKPktiZXucF3h+37Mi/U3iHhUDcNhLa9Bosi/tv
	 TeKaUwtOBb/2PMAi03rA7P4e7G6dhuypbZBjhed7nXw2X+HW2EuGZpKn8YaVytsRXS
	 SHdI3+j8ZnBMaPU4A48Zn9LCpTU5o6M7Tv9fZZsSBbBTYd8e3ZDTxsrp3DQymXcwDG
	 d2wZGS/hUyPO34lKU7UEvGyfYCf8LQZAiZa2WJ6UuPkU6zs6O4tNjI+xG5RRMVaq2W
	 y81Z5ydhoCC1OETektoFclEiL56hniyMI5KuoUAJxCsTwbjdHEOJ1XCerXGkPbSNK5
	 V0YePBhj6n4DA==
Date: Mon, 15 Jun 2026 16:39:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: m-malladi@ti.com
Cc: elfring@users.sourceforge.net, haokexin@gmail.com,
 vadim.fedorenko@linux.dev, devnexen@gmail.com, horms@kernel.org,
 jacob.e.keller@intel.com, arnd@arndb.de, basharath@couthit.com, afd@ti.com,
 parvathi@couthit.com, vladimir.oltean@nxp.com, rogerq@kernel.org,
 danishanwar@ti.com, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com, vigneshr@ti.com
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
Message-ID: <20260615163932.50bb3df0@kernel.org>
In-Reply-To: <20260615231041.1007484-1-kuba@kernel.org>
References: <20260610052511.781752-3-m-malladi@ti.com>
	<20260615231041.1007484-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 16:10:41 -0700 Jakub Kicinski wrote:
> > diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> > index 5ec0b38e0c67..8073deac35c3 100644
> > --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> > +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> > @@ -189,6 +187,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
> >  	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
> >  	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
> >  	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
> > +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
> > +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
> > +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
> > +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
> > +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
> >  	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
> >  	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
> >  	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),  
> 
> [Medium]
> Are these five new entries duplicating values that already have a
> standard uAPI?
> 
> The same five firmware counters are exposed through the new
> .get_mm_stats callback as the standardized MAC Merge stats
> (MACMergeFrameAssOkCount, MACMergeFrameAssErrorCount, MACMergeFragCountRx,
> MACMergeFragCountTx, MACMergeFrameSmdErrorCount in struct
> ethtool_mm_stats), and adding them to icssg_all_pa_stats[] also
> publishes them via emac_get_strings() / emac_get_ethtool_stats() as
> ethtool -S strings.
> 
> Documentation/networking/statistics.rst describes ethtool -S as the
> private-driver-stats interface; counters that have a standard uAPI are
> expected to flow only through that uAPI.
> 
> Could the firmware-register lookup table used by emac_get_stat_by_name()
> be separated from the ethtool -S string table, so the new preemption
> counters feed get_mm_stats without also showing up under ethtool -S?

This -- not sure about the other complaints but this one looks legit.
