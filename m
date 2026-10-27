Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114690;
	b=iDx+LXjG60FtOa1K3VTGaUH9Abvgi2iw5KoBvS/ukZcfCCC6DdcEtkIsQHSy91AgllX2
	 tvf9mMHtZ7p9BDN1To56KczMD9d/bJS/g1bQqFNeLnjECytaaQU3ZmaafJFY4LW7Kfo8k
	 0u9N4WpavRGvwm+tNpMsWBbgaKMX32TgAsNqg9LetwCj/pyqSy3GWl50VbKE0aqaQXDCz
	 8/2uo6wqZBsmZZSEl5+bURmjty1T2vHjsi7yk0jvSvvdJeAQ0x51DXCGu4Kj5BeMdJ2zC
	 Uxbn1j0UJ6G3sOiDqiGWddFhEsek7ClAv+oPaXYHWL7lQHBdwvmiGKct5LuoV0zfnDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114690;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=QEgh9eh5g6W6GXWQ1QQ3Xt0fKEwFk4G9JAyEdOnqR+M=;
	b=GO5UNtfLEEx+jA/SRcfNyJQHyHFM5kgSwUW92jLFFfC/NGvXPwAYCHoloPo/GKjrTXjZ
	 OaAijtuoKjy18Jj7VOv8/rT7Yvtm1XWQaG/8KJDOG+zhPFxmPNh9kqbJ4uloM+/kGhurQ
	 ARSjpdZXtO5zliGYmf3U2+Db4j4V7AZDca1ZUUOE6GNn+DGCmkOPV971caPhqivlebDa7
	 e9tQyV8zZFsLby3Tr7Q58ubdkdAoKf7/Xp7E40k0pqNoe0+sO7Tgf6Kvwpd2MxALtxFRs
	 KBVGYs8zOGDuoBa4x954T1mEg20WWNiW3DbNIhersx9jFvaQZoisbiolspT1s5ABW5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rbq1uqyZ;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E493606A323
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E493606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rbq1uqyZ
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261027152446euoutp026f4d6c402c39efc4dd8c9172cd0cd011~ibE6tdUX_2628426284euoutp02t
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:24:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261027152446euoutp026f4d6c402c39efc4dd8c9172cd0cd011~ibE6tdUX_2628426284euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793114686;
	bh=QEgh9eh5g6W6GXWQ1QQ3Xt0fKEwFk4G9JAyEdOnqR+M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rbq1uqyZTdoGXCP7Mo0oUNeIs8LO+BRKIePBoOznJLcp6KC1T2OiviX2JIrR8ygnU
	 Trhgd5SRQSx4O3ejpiCIPINvr66WkWFTtbsSmvfcu6zJRq023NkYS6cuVQ2UgRIswj
	 YtobIFTCQG0+eb5wdZN1F67COhGj7VEBYOVf6wnc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261027152446eucas1p1f6f2fc77458a940b8f16a1cdccc472c7~ibE6W2W502838028380eucas1p1Q;
	Tue, 27 Oct 2026 15:24:46 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261027152445eusmtip12170894aa2434d3e5d5b03464e715d9a~ibE5bvapZ2424124241eusmtip1x;
	Tue, 27 Oct 2026 15:24:45 +0000 (GMT)
Message-ID: <008d1317-223e-4265-a5a4-4d2a602a2661@samsung.com>
Date: Tue, 27 Oct 2026 16:24:44 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [RFC 04/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com
Cc: tglx@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
	iommu@lists.linux.dev, netdev@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261027022528.633359-5-kuba@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261027152446eucas1p1f6f2fc77458a940b8f16a1cdccc472c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261027022613eucas1p2ac05630160507ff3a887186416e98c30
X-EPHeader: CA
X-CMS-RootMailID: 20261027022613eucas1p2ac05630160507ff3a887186416e98c30
References: <20261027022528.633359-1-kuba@kernel.org>
	<CGME20261027022613eucas1p2ac05630160507ff3a887186416e98c30@eucas1p2.samsung.com>
	<20261027022528.633359-5-kuba@kernel.org>

On 27.10.2026 03:25, Jakub Kicinski wrote:
> @@ -683,6 +699,14 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
>  	return cpu_addr;
>  }
> +EXPORT_SYMBOL_GPL(dma_alloc_attrs_node);
> +
> +void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t flag, unsigned long attrs)
> +{
> +	return dma_alloc_attrs_node(dev, size, dma_handle, flag, attrs,
> +				    dev_to_node(dev));
> +}
>  EXPORT_SYMBOL(dma_alloc_attrs);

Do we really need two exported symbols for dma_alloc_attrs()? I would prefer
to make dma_alloc_attrs() a static inline calling dma_alloc_attrs_node().

Did I missed something obvious against that?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

