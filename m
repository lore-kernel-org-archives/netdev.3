Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307969;
	b=IGyBpUlUuj4NTbhE+wkavpV3MHPUSVgPQltE+kHwm/2aUv7WsHcd11fNuvaDPVTJX7jR
	 1z7YVqZw0DGGnwixtM7lgtMG81qDiYOxqIRvxQsbSXXz0BiTdIXJR5ZHg7eELeQHJNXvf
	 P4eURhzA0EfR7ieLcdrQbGlJaJIDniD7QjjS7kLTSTfH+DkbqIZ3oiQwB3sZukLjy8L4P
	 VUUDEKKnXehfFOJap8xugHXRBDukG5jMJ+KPIdPhUwSqMA/WtVsz0O7wIlLsqg2J/9ZyT
	 xirL5vBWQNkzQOIdurQBmtevvjOl7rkrCV0GjnaA0O+ln/gBAI6jEDpftNQ/jZYYyOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307969;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=of3Fz37lAI8kzghi7Thnsh/uOt27wyh82xH8Ye7dxpo=;
	b=L+KWeESMdcsO4LhkFlevsdBAdWmRtPOTSQXMt2dKp+b71sZ4ZdW0r5f/Cpq32+19vutU
	 XbrtVDD491MPDU43Quqs6o0FlAXxXRadzhyB6yKyV+XYUgar6RZvtwhg57VOiw5n9m1bv
	 EazxHAWNrmZDbHYz0WP3I2ESav17w23aZhj2szT6l+XJy1MJksy3faDZP3Kpg8WjYwvrT
	 U4pOWfMAefFSu/bVzmFz5jVNz4I9HySXRVcKFcGtdqd4dw+mUiJpaTQZPq2SXm+vKu1YF
	 xWf2Xwsoq0D0bKx4mBhh9GyudB421tQ7rHuoqElDf1PkUN8r5FckcEPhw4S6LWWk/Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=eIDUeLI4;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDF8606A32A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FDF8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=eIDUeLI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794307975; x=1825843975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UAkpE9AtLFqO/KB1GFIfc4JD6IZEN52pnU5iXG6gWpg=;
  b=eIDUeLI4VRrfGhc5pRSNQs9+7SVxS7n5cYOixN/xA7Z8qjEyTQ2vMyge
   WbNY9WAOKnJhRb56OfHSVU3z1+ICmCvrOOKOpTu2iKii3AZaZumDbVap+
   jxr+xmGli0SwE4yLpOkV26n8Y7IJZmaf6+LW1W7L3CiHpEnbezjwQHXnc
   8IqygKhDli7M9Vhl1m8JpxS2TCqfgi0CWbwd4NSMpCHGuxIrLqZCrPKZS
   gOsHVPNEHQdd5YNV/p9zraDycEWWxIPyIgbJJHzaKuh7CIOwFfyhDTzKv
   ER8rsTLYEcEOpLDSM76grvlc8gnH7TDpQqdW8MQunel3AOI2djqx2Iq+f
   g==;
X-CSE-ConnectionGUID: DrWI6Bi1QzGZSelXmfO6og==
X-CSE-MsgGUID: 1bZ0z09CShuqj/lG0+LhZQ==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="66528672"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 03:52:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 10 Nov 2026 03:52:41 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 03:52:40 -0700
Date: Tue, 10 Nov 2026 11:52:39 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <memoriaru@foxmail.com>
CC: <netdev@vger.kernel.org>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v3 2/2] net: lan969x: fix RX ring stall on frames
 from inactive ports
Message-ID: <20261110105239.5olhrlwa3mck74f4@DEN-DL-M70577>
References: <20261109164100.8947-1-memoriaru@foxmail.com>
 <tencent_95DA7493D2DB7AFE16C0B22A431E45295006@qq.com>
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
In-Reply-To: <tencent_95DA7493D2DB7AFE16C0B22A431E45295006@qq.com>

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
> skipped). Split the two: recycle the page, log a ratelimited error and
> return ERR_PTR(-EINVAL) for a bogus frame, and advance past such a DB
> in the poll loop. The WARN_ON() is also dropped as the backtrace slows
> RX to a crawl on every bad frame.
> 
> Found by code inspection; the stall needs the hardware to emit a frame
> with an invalid source port, which cannot be triggered without hardware.
> 
> Fixes: d84ad2c0d80c ("net: lan969x: add FDMA implementation")
> Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
> ---
>  .../microchip/sparx5/lan969x/lan969x_fdma.c     | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> index 053d125..5f5adb7 100644
> --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> @@ -113,8 +113,12 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
>  	sparx5_ifh_parse(sparx5, page_address(page), &fi);
>  	port = fi.src_port < consts->n_ports ? sparx5->ports[fi.src_port] :
>  					       NULL;
> -	if (WARN_ON(!port))
> -		goto free_page;
> +	if (!port) {
> +		dev_err_ratelimited(sparx5->dev, "Data on inactive port %d\n",
> +				    fi.src_port);
> +		page_pool_recycle_direct(rx->page_pool, page);
> +		return ERR_PTR(-EINVAL);
> +	}
>  
>  	skb = build_skb(page_address(page), fdma->db_size);
>  	if (unlikely(!skb))
> @@ -258,6 +262,15 @@ int lan969x_fdma_napi_poll(struct napi_struct *napi, int weight)
>  			break;
>  
>  		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
> +		if (IS_ERR(skb)) {
> +			fdma_db_advance(fdma);
> +			counter++;
> +			if (fdma_dcb_is_reusable(fdma))
> +				continue;
> +			fdma_db_reset(fdma);
> +			fdma_dcb_advance(fdma);
> +			continue;
> +		}

It is still a copy of the advance at the end of the loop (as pointed out in v2).
Drop it and do:

		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
		if (skb)
			napi_gro_receive(&rx->napi, skb);

and let the loop advance as it does for any other frame. Then NULL always means
"frame dropped, page recycled", which covers both the bad port and the
build_skb() failure, and the ERR_PTR() goes away. I tested exactly this on
lan969x: RX keeps working, and only the bad frames are dropped. With this, the
page_pool_recycle_direct() and ERR_PTR changes further up becomes obsolete.

>  		if (!skb)
>  			break;
>  
> -- 
> 2.39.5 (Apple Git-154)
> 

Also, please wait at least 24 hours before resposting, and populate To and CC
properly.

/Daniel

pw-bot: cr

