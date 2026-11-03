Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712439;
	b=2v4dUtKXPrfGE5FujUc7gWcgu434wCpQzIOD9PonqF+G3Q2NMoDv/sIB8Iaw/7zU5zLe
	 anXOEKwBONWzBL2PH7Ngq83lq10pDeYlX365Xpa+uA9RdAKimj47PYRwnptA0Xn3YjYvR
	 7SoDCNwle4yijHe21+ngbuO+9hz+1JDOgfo2Ams4w8KQi0xhHYClnrq0jUil1h7LosK8w
	 EdOF+LvNFROu8UMQs66IqerZdPBroBv0DkxQPSzIGYCVh8diU0I13ogk+q8rOuAiY7uIU
	 gS5D+H1UV0/e2EkPwZ7EcVP88U4uwZG/nNx7MrcYBrMHLw5UdZk5BFG8cHzlFFVJMBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712439;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=ABDqe6caApeNw6BhcqtL/ES/kBv7JWUT4r+E6SK+ZTw=;
	b=KjDcb0qp1VMMC+yYfA8BAfvOACfdqvKnPxtfnmeiVCNvsNNJsEUT7WVNXwx8hXbuCaG4
	 WFCLo8+EyGkk9H+s9R1hNCiNOT28e21M96Q29WT9qI9IJHgMV/+3Vv8JnkZten+SvvCy3
	 Avigp33LOgY3NWnIrbsT1deRGKysXiySi0BT2cQGWuIZMkuVs5xtgeBjTss7sugE02whj
	 9CfkBjjCepadNe47k9W1/wlxPiyAhfL+qjQu4/donQuuq+KRGJaYgyOb+953kdQQ+l0+Z
	 7xwvkgib2JAhV2UMmPwbqV1uyochdUrd95ONHbHZvUTiZO3P2uc0pHeNJFZBctdZ1ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="EBy9R/QE";
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014160850A1
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A014160850A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=EBy9R/QE
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261103132717euoutp01015fe0f2d78f3ee4cb9cc896596adf06~ki-U9pg2I2082420824euoutp012
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:27:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261103132717euoutp01015fe0f2d78f3ee4cb9cc896596adf06~ki-U9pg2I2082420824euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793712437;
	bh=ABDqe6caApeNw6BhcqtL/ES/kBv7JWUT4r+E6SK+ZTw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EBy9R/QETP3e4+7vlPkRFet3BCI/LK4YpPm00Wm/MJCoBqbHeJxJFHTEhB8ImMlnX
	 tT4Wztq8/jA5zZDrIk2jxWTOWB876D2IrULSKo/SM4rrkoH+IfoQnO7sHD/ep1q8Eo
	 WwX7gxcpXJh2xuwVoLY3NyWLUiCGy2sDUZk88C7Q=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261103132716eucas1p1e3384deb453a2cb129efd879d757d88b~ki-Uf38D_2105421054eucas1p19;
	Tue,  3 Nov 2026 13:27:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261103132715eusmtip13939e43bf3d107df8b1fcb9d1b36c191~ki-T8pIpM1299412994eusmtip1G;
	Tue,  3 Nov 2026 13:27:15 +0000 (GMT)
Message-ID: <d2c22ebc-99d9-4166-8fa3-5af4c88f4df1@samsung.com>
Date: Tue, 3 Nov 2026 14:27:15 +0100
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
Subject: Re: [RFC 03/11] iommu/dma: pass the NUMA node to iommu_dma_alloc()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com
Cc: tglx@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
	iommu@lists.linux.dev, netdev@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261027022528.633359-4-kuba@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261103132716eucas1p1e3384deb453a2cb129efd879d757d88b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261027022613eucas1p17a0f748d1ef00ff8a1265b5b0345c5cc
X-EPHeader: CA
X-CMS-RootMailID: 20261027022613eucas1p17a0f748d1ef00ff8a1265b5b0345c5cc
References: <20261027022528.633359-1-kuba@kernel.org>
	<CGME20261027022613eucas1p17a0f748d1ef00ff8a1265b5b0345c5cc@eucas1p1.samsung.com>
	<20261027022528.633359-4-kuba@kernel.org>

On 27.10.2026 03:25, Jakub Kicinski wrote:
> iommu_dma_alloc() allocates the pages on the node of the device.
> Pass the node in explicitly, so that a node-aware coherent allocation
> API can be layered on top.
>
> Memory from the atomic pools is not node-aware.
> iommu_dma_alloc_noncontiguous() keeps using the device's node.
>
> Callers pass dev_to_node() for now, no functional change.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>  include/linux/iommu-dma.h |  2 +-
>  drivers/iommu/dma-iommu.c | 28 ++++++++++++++++------------
>  kernel/dma/mapping.c      |  3 ++-
>  3 files changed, 19 insertions(+), 14 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

