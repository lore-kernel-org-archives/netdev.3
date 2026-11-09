Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231026;
	b=OokGPRjy2dlFe+T2drUC6YzPb2NNq/gOLiIZvXCZ96YnjzfTYRIITsSOT3i3FwuGQXDN
	 gCOXYAuTvoRVxFt7L/RDnH+PdKimO2LGXDC6kokf9wQeDGMgqvrM6TDEr+vj4cp2P+Kjx
	 Pg5Exj+ILyNRMSu9PsP8stpwExZEI9ugTxJag/cG0jmQDCDlfuUxEWEL1L88F+T9b+5Dg
	 ZtZC3xHgUak+VqPXFn7iC29ZxFt6eUxZKb7gPtfdNxYLD2xwM5pePLmMP1uAvd76bJNEw
	 BfIJAjNN+Htox3IwGs0DcakbiiUgKCIJatRf/wkwoKLAhEBqmptV+27LTW8mHFiAkbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231026;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/YIEa9l3jcw4IpWtTJZsWq0EUx5wNEMNCu0m5vYuAkM=;
	b=ARkPoRSpm/ZCQC8LWaSDnMgcmY9F6OhfnkL8I18NpEJ0Lm2oN9PqCxNgVJ4djxGpHRM5
	 geMuxL/jwEnPwlZ0MgUVkD7oOrHQaPHmzO8F3o3/4KZ2caeorw9kht35sxMnjTTfyjZl+
	 qLjndkR6P3tU2glBkWXa+PNd9x/Ghq2wU7P7K1QXG328B2z5vHWzAwqEHfYLMcQL6ap7B
	 eB7AD8leHeCtqgNVSt30Yq8xaNdyPNEOP8gK6iyjJF210NSm4ysNXtS9mFE5YHnHHLm/k
	 wO3dnCY/IHUB/OlWrih5sZJ/dYkwNN5VFldCF9DZE1DNiadRwgYj4uaZ0FxoCgEXOUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="Om/UDzaH";
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FC606A323
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 339FC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Om/UDzaH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794231026; x=1825767026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ycDxRUmPKS9i4DLIktrknRBJorpI94QLeet3Rhmlb0Y=;
  b=Om/UDzaHnK3zT35T1x7/kcpHsetG0Lr14ZA/od5HyWPYJOS9luC5aONr
   fhaaXyJa9K5S1C83MyCmiHalx840yQDO7Kua0OqAUdFDri/IWeQpwmrBL
   P9pv3/rHBN75wnrWd2FnI2SZHAIzFspV/kKML+SfZHtX9TC2GBUcVQjQx
   aVywGWFhnaYuBx6kcjO65OSmkVosL9GZugIjk9uXc83FEs1Q2b9HbBpLg
   y1zkOTdxH9j9g7UOWxCGkNFMzijRI9nIfskcU0ptnOHPwO8rI2usOhHpI
   uzg86KHhuAP0AgYRzBQdU+TG1DGWSZ4c0i1QbcNdIhAP8rDHygdiqHrhX
   g==;
X-CSE-ConnectionGUID: oAyJJx9iSd2xhgHihhUd0w==
X-CSE-MsgGUID: A1Vg3oo5Rb6s3lGjeDeBHg==
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="233293193"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2026 06:30:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 9 Nov 2026 06:30:25 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 9 Nov 2026 06:30:24 -0700
Date: Mon, 9 Nov 2026 14:30:23 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <memoriaru@foxmail.com>
CC: <netdev@vger.kernel.org>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2 1/2] net: sparx5: fix RX ring stall on frames from
 inactive ports
Message-ID: <20261109133023.n2lttn5vtnp33727@DEN-DL-M70577.microsemi.net>
References: <20261109080254.92305-1-memoriaru@foxmail.com>
 <tencent_0F653806680A4CA083E923A5AFF5982DC307@qq.com>
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
In-Reply-To: <tencent_0F653806680A4CA083E923A5AFF5982DC307@qq.com>


Hi,

> From: Zhang Hewei <memoriaru@foxmail.com>
> 
> When the FDMA RX path receives a frame whose source port does not map
> to an active netdev, sparx5_fdma_rx_get_frame() logs an error, flushes
> the extraction FIFO and returns false - without advancing the FDMA
> software cursor and without releasing the skb, which has already been
> extended with skb_put().
> 
> The DCB for this frame still carries its hardware DONE bit, so the next
> NAPI poll picks up the same DCB, takes the same inactive-port branch and
> returns false again. The software cursor never moves past this DCB, so
> RX traffic on all ports stalls until the module is reloaded. The
> sparx5_xtr_flush() call only drains the QS_XTR hardware FIFO and does
> not touch the DCB ring or the software cursor, so it does not clear the
> stall.
> 
> Treat a bogus frame as consumed: free the skb, clear its slot in the
> rx->skb[][] array and return true, so the NAPI loop advances past the
> DB the same way it does for any other received frame. The slot is
> refilled by sparx5_fdma_rx_dataptr_cb() when the DCB is recycled.
> 
> Found by code inspection; the stall needs the hardware to emit a frame
> with an invalid source port, which cannot be triggered without hardware.
> 
> Fixes: 10615907e9b5 ("net: sparx5: switchdev: adding frame DMA functionality")
> Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
> ---
>  drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> index 15ec9b0..bd021df 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> @@ -159,7 +159,14 @@ static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx
>  	if (!port || !port->ndev) {
>  		dev_err(sparx5->dev, "Data on inactive port %d\n", fi.src_port);
>  		sparx5_xtr_flush(sparx5, XTR_QUEUE);

This now runs for every bogus frame. You can omit the flush above, since the
frame is already in the DB. Also, with this change, we want to use
dev_err_ratelimited() instead of dev_err.

> -		return false;
> +		/*
> +		 * The frame is bogus: free it and let the caller advance
> +		 * past this DB. Returning false here would stall the RX
> +		 * ring, as this DCB is never consumed by the software.
> +		 */

The last part describes the old behaviour - no point in that. Actually, ditch
the comment altogether, it is already documented in commit description.

> +		dev_kfree_skb_any(skb);
> +		rx->skb[fdma->dcb_index][fdma->db_index] = NULL;
> +		return true;
>  	}
>  	skb->dev = port->ndev;
>  	skb_pull(skb, IFH_LEN * sizeof(u32));
> -- 
> 2.39.5 (Apple Git-154)
> 
