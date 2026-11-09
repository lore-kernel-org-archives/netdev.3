Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231372;
	b=10Rx7xlvxjsVjwHrqkVfRWL9ER5wjX2PL6rzrt2vU0AN7wnQUwM25nIAkvBDajWBdTjB
	 P5ww8Um4KUs7XwTi4ZWbM/Z3VsCtx9D230vMtKfcEAPp/BJDWkqEXkAtkEsWncIkdG2B1
	 K8b3SMFk/2N4Yra3Pm3emIWDqTvTjfMwlaPP3huykJZdCzstviOD0t5IJkvqj4TAxZhPJ
	 R2leqV7cLxoXR9XhAZKwLiKRtFMzMIxO+xZ3kWnvGA1klHt3nDVE17h50r8WynYOO45bY
	 H0LVrCJvjtk/yXTY8iQMGNWUZ2UfibpWribMBJoUT4iU7JnT2PSb5kA1uqP5o7iEpaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231372;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wTqBncIUnc8tR3XE8IcTGYzNQWttldS49cqpWoklZaI=;
	b=JLtKe/sUkb1Ib/2Q+gjTAGaOqKbp4aRujaQ2N012BupuyCMfpZR4uPiZ+Om+0fjQSY8J
	 ro2Z6hevBufRckqFCyXaaP+6D4kQZchgMcEp/EemJcEbRfhE30CADPe1HCFLLJKVm0yvi
	 LbEO8N8fPJyakLxiebXno3cskzPLb4HvhGCIvIUCY0PkpwzzXR+BuQHtHIb0pLyij13mW
	 0+CIKQB3Os5Oe2msyccXdlGAu3TbvJ2R1G6BWdaMpicmMJ+w81Dty8XnjQCo73fAoZ50g
	 +8t8DmnCszx8//KbuPOZxo2dJx0E8U6aAt2g1y+KwBWxWu2pi5ALW7tBpZ6IvjorD2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=NhcxLUfQ;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D7606A338
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE9D7606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=NhcxLUfQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794231371; x=1825767371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d2Dgy8//LT9A91So3+JO5x6Bdp/V4ZGIuAh31O8DpkY=;
  b=NhcxLUfQZByD+itpc6iAUufkNVCXaemrrnbXqd/KO2VmDIHIi2s42Kx9
   Oe3u42CT2i/LJoZYQvR2vUpnRUg1bDg1ZIjNrd7lt+XLP5E8O5BwUi3cG
   ZHQJVlekafIJvS0BZno5h0tAJQ+Tps6OUzW+cHeBxcDJ0nL3QPuxnXXye
   3/U2B9TkvC9XC4fMyD7u2eEzT0QLPW/tZpYB/qgb9h20zZRti4ZDY+G+d
   K5VccZtoKID/XzABLM/lshBOeMGUJjf7TBYKhA3E9Ev92QNzPoWXULh86
   TkvQ159ShbmvyD83RAv3rfe1QBDTBwwx6uZfN9DoGsFsRBqS4SqWbzfP8
   g==;
X-CSE-ConnectionGUID: 00kh2yahTsyi00Bn8ABIzA==
X-CSE-MsgGUID: apP2rGImQRSVqcNl+ZQgEw==
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="233293482"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2026 06:36:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 9 Nov 2026 06:36:10 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 9 Nov 2026 06:36:09 -0700
Date: Mon, 9 Nov 2026 14:36:09 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <memoriaru@foxmail.com>
CC: <netdev@vger.kernel.org>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2 2/2] net: lan969x: fix RX ring stall on frames
 from inactive ports
Message-ID: <20261109133609.yjijrqwdynmacc75@DEN-DL-M70577.microsemi.net>
References: <20261109080254.92305-1-memoriaru@foxmail.com>
 <tencent_D6697325D37592ADABE50686370A7D208907@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_D6697325D37592ADABE50686370A7D208907@qq.com>

Hi,

> From: Zhang Hewei <memoriaru@foxmail.com>
> 
> When a received frame's source port does not map to an active netdev,
> lan969x_fdma_rx_get_frame() recycles the page via the page pool and
> returns NULL, which makes lan969x_fdma_napi_poll() break out of the RX
> loop without advancing the FDMA software cursor.
> 
> As on sparx5, the DCB still carries its hardware DONE bit, so every
> following NAPI poll picks the same DCB, hits the same inactive-port
> branch and breaks again: RX traffic stalls on all ports until the
> module is reloaded.
> 
> A NULL return currently covers two different situations: a failed
> build_skb() (allocation failure - breaking out and retrying the same
> DCB later is correct) and a bogus frame (which must be dropped and
> skipped). Split the two: recycle the page and return ERR_PTR(-EINVAL)
> for a bogus frame, and advance past such a DB in the poll loop.
> 
> Found by code inspection; the stall needs the hardware to emit a frame
> with an invalid source port, which cannot be triggered without hardware.
> 
> Fixes: d84ad2c0d80c ("net: lan969x: add FDMA implementation")
> Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
> ---
>  .../microchip/sparx5/lan969x/lan969x_fdma.c   | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> index 053d125..7234474 100644
> --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (c) 2025 Microchip Technology Inc. and its subsidiaries.
>   */
> +#include <linux/err.h>

I think this can be omitted.

>  #include <net/page_pool/helpers.h>
>  
>  #include "../sparx5_main.h"
> @@ -113,8 +114,15 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
>  	sparx5_ifh_parse(sparx5, page_address(page), &fi);
>  	port = fi.src_port < consts->n_ports ? sparx5->ports[fi.src_port] :
>  					       NULL;
> -	if (WARN_ON(!port))
> -		goto free_page;
> +	if (WARN_ON(!port)) {

src_port comes from the hardware, and now every bad frame dumps a backtrace. In
my testing the splats slowed RX to a crawl and wedged the serial console. Please
use dev_err_ratelimited(), like in 1/2.

> +		page_pool_recycle_direct(rx->page_pool, page);
> +		/*
> +		 * Signal a bogus frame so the caller advances past this
> +		 * DB. Returning NULL would make the poll loop break
> +		 * without advancing, stalling the RX ring forever.
> +		 */
> +		return ERR_PTR(-EINVAL);
> +	}
>  
>  	skb = build_skb(page_address(page), fdma->db_size);
>  	if (unlikely(!skb))
> @@ -258,6 +266,18 @@ int lan969x_fdma_napi_poll(struct napi_struct *napi, int weight)
>  			break;
>  
>  		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
> +		if (IS_ERR(skb)) {
> +			/* Bogus frame, buffer already recycled: advance past
> +			 * this DB, or the same DCB stalls the ring forever.
> +			 */
> +			fdma_db_advance(fdma);
> +			counter++;
> +			if (fdma_dcb_is_reusable(fdma))
> +				continue;
> +			fdma_db_reset(fdma);
> +			fdma_dcb_advance(fdma);
> +			continue;
> +		}

This block is a copy of the advance at the end of the loop. I think you can get
away with just:

		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
		if (skb)
			napi_gro_receive(&rx->napi, skb);

That should also make the ERR_PTR(-EINVAL) change go away.

>  		if (!skb)
>  			break;
>  
> -- 
> 2.39.5 (Apple Git-154)
>

/Daniel
