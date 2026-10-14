Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0C38F230;
	Wed, 14 Oct 2026 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008178; cv=none; b=u77OXvgXYUUQNqSYJJv0DQRpAgNOhFGnSbI+90YHrtNgMYjBP4nBJRq1cpyB0rzxizj6bDbi+ucs/kBGtdDAaVQaO+dYae0nosYLMKxddosHij7NtCBHE9iM7OGdYnbHuAfupFjX+RV4N3HAl0Q877Jl4l3418qEwSqIFLE4H3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008178; c=relaxed/simple;
	bh=herUBcKN5sV6lWEohmV4av5FMJDC4ZqTgDybP/BD1Bc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2h226q+2ZN/W1elhqeT3RiXYhZ0tH77abOFQk8++eWxv0UJ/wdsVUsJQY9Tmi2TtoQNzNFYqkLPSEJLHduICCMP1GlFkga427u1OFg2IZs21MHt4NnYDpaZEOjOsNdEWD12shxBbW+FlilMMRkzKtqsek6rAD8FIj3DVOEddX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1p/SYUoi; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1p/SYUoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792008177; x=1823544177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=herUBcKN5sV6lWEohmV4av5FMJDC4ZqTgDybP/BD1Bc=;
  b=1p/SYUoiB3Z7uapZQ4ObkkBvM/hVumlZ6uCqEuuQk+VimPPWN7UqVSE9
   zsCSjmiS/ah1AeD92R3WX3x1ykMjZLR/sr/JA56GuMSMqISZOh6ssEfN/
   aXAuJnRMlJ1DLvvyeUO/qMzI3DQCpBLNH4S4Onwit81pbGBXprI9XKqfu
   qU21rpggbcBGXFmC5NUQmRS30WnEzKyAeiMuR/vW5KTlQBL/fLT4rPehm
   tT7v6bvl0Hdh9Cn/j/s+59lfSZ6CEn1xB+hCwmElvFTDXwYz08VjV+Zz6
   otYK670JaxDSArDL1lJN6Kj8sbDOeFFKgL1E/CFOM9y04EvTqDXCqxLbf
   Q==;
X-CSE-ConnectionGUID: RLfPQW6IQ1eYbMesvt4Z2w==
X-CSE-MsgGUID: KEuVrUxjROSB5VwviA3vjw==
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="64109435"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 13:02:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 13:02:56 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 13:02:53 -0700
Date: Wed, 14 Oct 2026 22:02:53 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
CC: Iyappan Subramanian <iyappan@os.amperecomputing.com>, Keyur Chudgar
	<keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "open list:NETWORKING DRIVERS"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] drivers: net: xgene: Fix dma_unmap_single() size
Message-ID: <20261014200253.boklssmfbnwairjy@DEN-DL-M70577.microsemi.net>
References: <20261014084817.41805-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014084817.41805-2-fourier.thomas@gmail.com>

Hi Thomas,

> In xgene_enet_refill_pagepool(), the skb->data is dma-mapped with length

To me, it looks like the mapping happens in xgene_enet_refill_bufpool() and not
xgene_enet_refill_pagepool().

> len which is set to XGENE_ENET_STD_MTU which equals 1536. However, in
> xgene_enet_delete_bufpool(), the same buffer is unmapped with length
> XGENE_ENET_MAX_MTU which is 9600. This may erroneously unmap other
> DMA buffers or cause other issues.
> 
> Change unmap length to XGENE_ENET_STD_MTU.
> 
> Fixes: 6e434627bce2 ("drivers: net: xgene: fix: Add dma_unmap_single")

That commit mapped and unmapped with XGENE_ENET_MAX_MTU. At that point, there
was no mismatch. I think the mismatch came with:

Fixes: a9380b0f7be8 ("drivers: net: xgene: Add support for Jumbo frame")

> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
> index 507db46daf2b..2ddcbf27014e 100644
> --- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
> +++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
> @@ -185,7 +185,7 @@ static void xgene_enet_delete_bufpool(struct xgene_enet_desc_ring *buf_pool)
>  
>  			raw_desc = &buf_pool->raw_desc16[i];
>  			dma_addr = GET_VAL(DATAADDR, le64_to_cpu(raw_desc->m1));
> -			dma_unmap_single(dev, dma_addr, XGENE_ENET_MAX_MTU,
> +			dma_unmap_single(dev, dma_addr, XGENE_ENET_STD_MTU,
>  					 DMA_FROM_DEVICE);
>  		}
>  	}
> -- 
> 2.53.0
> 

/Daniel
