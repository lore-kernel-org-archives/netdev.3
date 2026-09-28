Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F484C14F7;
	Mon, 28 Sep 2026 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602298; cv=none; b=BHrTuAJ/QTrI0fW1wELTdki0KKTvVPSBHmWI0BlwXynpPIs4eiswGpcg/7ibCof8hm8HK8ghw2gdg0WBFdlUjivC4cWjKBi/QmInDSEi4SCbbrciXsmeBs+BR9zxvvR3RAyiMJ7MxjBundD5YuA2NZAEJiGTAa16RYgOklnSm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602298; c=relaxed/simple;
	bh=Co39FX66n1TKtlJA6qITPYWo52xqa8IgtNllIU9g5Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7nCC3ytklnwcrevfLj+A29taWiki78YumBugVfg3UBc4irYnbEnlHPvPOCoEzAd+zj5J6I/H53oA6ibdqnL7DDVzXT9R5Oi2+e1bl+FrYn/unum6oYIf4jSnomcpuklV3g54XV5e1ThQZxOm+MRoiSOet23R8XLxZqffXXlZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEi4oOfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEi4oOfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84FB1F000FF;
	Mon, 28 Sep 2026 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790602296;
	bh=XAP4wbXVYf7FTv6tzFL46yM9iBA7bPInQGYljFmtHqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aEi4oOfP0YFUz/ZFs92pOCD/UST1Nfs1WD3m/eue89LC7eqYC/n/Lifmp3GvrgmyW
	 QoYUJLyvihmczUEE5R6XjpZuLh2QkHiGxkM1Y1sK2qA4slVtgzEbhFOWlAXv5AvV3G
	 nz8qskmkfXPeHZws97X1XVeGXOrMRsGCLVq07I2fLasmLndl3F4+oOgy5bscPr3iKO
	 g36ayHobaGgOh9xhhvY6RVlneuZXZXQ0KwYAzyWcU+3qz17b7YHseCBm2hMyiWa1+K
	 dufVq0UO4dbCzv0PyZuSisHEn64K1mG0B7YSmhEYHWJ2eXLDsx3ttcONojHn224+pI
	 T6RXFFtYFPhzg==
Date: Mon, 28 Sep 2026 14:31:31 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: florian.fainelli@broadcom.com, netdev@vger.kernel.org,
	opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, zakkemble@gmail.com,
	ryotkkr98@gmail.com, linux-kernel@vger.kernel.org, nb@tipi-net.de
Subject: Re: [PATCH net 1/6] net: bcmasp: fix mib counters struct alignment
 with ethtool stats
Message-ID: <20260928133131.GR13925@horms.kernel.org>
References: <20260922221630.3864427-2-florian.fainelli@broadcom.com>
 <179027136810.2160803.5519251364954584171@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179027136810.2160803.5519251364954584171@kernel.org>

On Thu, Sep 24, 2026 at 05:36:08PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message overstates what the bug did.
> 
> --
> 
> net: bcmasp: fix mib counters struct alignment with ethtool stats
> 
> This commit removes the leftover edpkt_* fields from the start of struct
> bcmasp_mib_counters. They were left in place when the matching
> bcmasp_gstrings_stats[] entries were removed for asp-v3.0. Since then the
> struct layout has not matched the order the ethtool code indexes by.
> 
> > Because bcmasp_update_mib_counters() and bcmasp_get_ethtool_stats() index
> > into struct bcmasp_mib_counters sequentially based on the order of
> > bcmasp_gstrings_stats, this 16-byte offset caused hardware statistics
> > to be written to the wrong struct members and software counters to be
> > read from incorrect offsets (and reading out-of-bounds at the end of the
> > struct).
> 
> [Severity: Medium]
> Is the out-of-bounds part of this description accurate?
> 
> Before this patch, struct bcmasp_mib_counters had 17 u32 members (68
> bytes), and bcmasp_gstrings_stats[] has 13 entries. Both loops stop at
> BCMASP_STATS_LEN:
> 
> drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c:bcmasp_get_ethtool_stats() {
>     ...
> 	for (i = 0; i < BCMASP_STATS_LEN; i++) {
> 		p = (char *)(&intf->mib) + (i * sizeof(u32));
> 		data[i] = *(u32 *)p;
> 	}
> }
> 
> So the highest offset either loop touches is 12 * 4 = 48 bytes, which is
> inside the 68-byte struct.
> 
> The hardware values also appear to have reached userspace correctly.
> bcmasp_update_mib_counters() writes them to raw slots 0-4, and
> bcmasp_get_ethtool_stats() reads them back from the same slots. The only
> members overwritten were edpkt_* and umac_frm_cnt, and no code uses those
> by name.
> 
> The part that looks broken is the software counters. Code increments them
> by name (intf->mib.alloc_rx_skb_failed++, tx_dma_failed++, and so on).
> They sit in raw slots 9-16, but ethtool read slots 5-12. As a result:
> 
>   - "RX SKB Alloc Failed", "TX DMA Failed", "Multicast Filters Full" and
>     "Unicast Filters Full" read fb_* members that are never written, so
>     they always showed 0.
> 
>   - The next four strings showed the values of the first four software
>     counters.
> 
>   - filters_combine_cnt, promisc_filters_cnt, tx_realloc_offload_failed
>     and tx_timeout_cnt were never shown at all.
> 
> Could the commit message describe this as shifted or mislabeled software
> counters, rather than as an out-of-bounds read at the end of the struct?

I've looked over the above. And while perhaps this alone doesn't warrant
a re-spin. The analysis does seem to be correct to me.
