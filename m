Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE73EFD21;
	Fri,  9 Oct 2026 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535357; cv=none; b=TN4RNOes5Y9Hk66KF0dD06JkL1FZU2hvm8R/VHxTjopgh+lOH+6cGFQT9wO3lQLwcTX4aBScbgJY2EA8bqBqEkSMOPZSay91mF7VqVYABGXGiwb+M0rDg6jB28y9BNVl1LkHpHTfDujFm9tNRdc1OxRE3rcNOGRZAQNocSKJS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535357; c=relaxed/simple;
	bh=Bz9AY+qxJJr1b0AqpHOCrjgxoFaiBkp1e1Df34c6qUw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pV9Edh76jh5CHJmfPAvHZhpP8PDKEbqSwdtr2Pt/rrtlGqRAq+MB6DR3Wx3BNzvR+MYtwofNAFckb2T6RWpeO5q03v7esnCZEqJG9qyuk5DLZ1sMeRLOIhLKFs6NFM2SoBSn7bWnQ9P2Hx4fc5h0Z6J8azj+//nOM651JIDzXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=DqPveiNg; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="DqPveiNg"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB7B0A1558;
	Fri,  9 Oct 2026 10:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791535350; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WPuaMsD6xVABkJ054DOeGqqWwtYzRYUwNWpuamQSeGg=;
	b=DqPveiNgKT3kPhd61RopTLdyvRP9hR4r4IJbgg+qpXBhWwTEl9OglU4PmwiqcA/UZUCCan
	EBOlKUtGLnXq2woGpRECrNRUWj4P9Ck+gefPDBnkVI5/K9rlMmM467Rng4axMaALrS/kEU
	2IP/oEEvMjP6g0L6OZkGtv3Ypr/5LhSAdqpufEI99sqXjhOnW5CQ9NWJdBXik8bCSG5qAN
	x+TtK8KdYZE1jECJSEtzFosVvYbYxHGtPRAz8FtfsFjpM+iCXkO7reiehS1ftbq2KECMsQ
	SMvRXF6q5QLcIcD8afdp8RElANm1kCtHbvKXvCc20cjfIQqnUwEb6eQXQAMFHw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Oct 2026 10:42:29 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/6] net: bcmasp: fix mib counters struct alignment
 with ethtool stats
In-Reply-To: <20261008210621.1374785-2-florian.fainelli@broadcom.com>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
 <20261008210621.1374785-2-florian.fainelli@broadcom.com>
Message-ID: <f69600e67aa7af56d0a15d3d59fddedf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 8.10.2026 23:06, Florian Fainelli wrote:
> When EDPKT stats were removed in commit e9f31435ee7d ("net: bcmasp: Add
> support for asp-v3.0"), the corresponding entries were removed from
> bcmasp_gstrings_stats in bcmasp_ethtool.c, but the edpkt_* fields were
> left at the beginning of struct bcmasp_mib_counters in bcmasp.h.
> 
> Because bcmasp_update_mib_counters() and bcmasp_get_ethtool_stats() 
> index
> into struct bcmasp_mib_counters sequentially based on the order of
> bcmasp_gstrings_stats, this 16-byte offset caused ethtool to read from
> shifted offsets: the first four software counters read unused fields 
> and
> reported 0, the next four software counters reported the values of
> alloc_rx_skb_failed, tx_dma_failed, mc_filters_full_cnt, and
> uc_filters_full_cnt, while filters_combine_cnt, promisc_filters_cnt,
> tx_realloc_offload_failed, and tx_timeout_cnt were never reported.
> 
> Remove the obsolete edpkt_* fields from struct bcmasp_mib_counters so
> that it aligns with bcmasp_gstrings_stats.
> 
> Fixes: e9f31435ee7d ("net: bcmasp: Add support for asp-v3.0")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h 
> b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
> index 8c8ffaeadc79..9c9721da1662 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
> @@ -250,10 +250,6 @@ struct bcmasp_intf_stats64 {
>  };
> 
>  struct bcmasp_mib_counters {
> -	u32	edpkt_ts;
> -	u32	edpkt_rx_pkt_cnt;
> -	u32	edpkt_hdr_ext_cnt;
> -	u32	edpkt_hdr_out_cnt;
>  	u32	umac_frm_cnt;
>  	u32	fb_frm_cnt;
>  	u32	fb_rx_fifo_depth;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
