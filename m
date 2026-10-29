Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265432;
	b=PAT4OIUevno2/50xxP5uqPxZEivVi2k/BwxmJRA81DC0DWc9OXkgwFkS/PTCz55gsG+d
	 b5ArCiWrB7YTOUTXr/tl77A+1JQLidH5/9pq/i0CIbOHyvaB0683478HthNyRBe1n/oge
	 BZ1HGRYU1QhaUa5CLOKNM4wkP6TCuAQivhGgIHEzYimsxjAL53ZusZPYCYWAoyaA8oP37
	 INy6XyMTTup+VgU45XoOV1aiPjNr/5wP1UHQbVSgCR8JR2flS5Mwcn+AX4YHO6K71e4jf
	 qzZcDT0tmakBhkXGoD+M92anvMZERYOknWazoLCSeI5CDZ68N5pntt/ZImf9y3mRfMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265432;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=j4AXCr1qkQMPMUXdk2+Nfc8gbN/AQleiHbJ0XtECBWM=;
	b=wAeEIKmmYKopFuj9uysE3pVXZ8Y92WllBQM9eZ85CWb28dOJs128iSep4h5XcsPFN0ez
	 /KETdZMLWz0FwSz7chU/e71ICnDlHuSoHtv4hASYsh+F4XjKSwoqjH8BapOjgoR/Yjt1A
	 CokIBXaGVOZPxGItxJzqgRAnCRv4YCW8c4wqDeJQXKoMK4lKsTLVWu7KQOBU2ua0B5h/g
	 Tuzw2cJeduToOBenGq0Iq5snLHcUXhc5Eevg+yi9YKdTbR4lU1ocSgLlyg9AcJU8efwg6
	 1YKm8IAhnx+eWc3B7Fly2GWYW2Yb8qaSUjaCaon1jFXdAyrllXgRjCq5JzBYNa+Op7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QHJ7LQ4D;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5FC606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E5FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QHJ7LQ4D
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261029091709euoutp02662564fa98ae556d9c3c6237a1c4f888~i9WgsQYf81539715397euoutp02c
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:17:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261029091709euoutp02662564fa98ae556d9c3c6237a1c4f888~i9WgsQYf81539715397euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793265429;
	bh=j4AXCr1qkQMPMUXdk2+Nfc8gbN/AQleiHbJ0XtECBWM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QHJ7LQ4Dw27oX3qv160cTEp4QMeXJV/BB5f0s0kMifgUkxYTp2oRVStWq22+9QImV
	 J2B2rK8QyhUpjpU6HeEHDVZMVk+FrhuTdZwPCZNfwdB1dbPCesbcpk4wRzwrtAzq0H
	 TvpUSMYYauVelduEtADCtBZRZQzyHixCci0w623E=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261029091708eucas1p1eceac71c0d1f0166ae56525ddf6335fb~i9WgPz_By2993829938eucas1p1p;
	Thu, 29 Oct 2026 09:17:08 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261029091708eusmtip1df711fed790269113c0f17caa7dfb4c2~i9WfsHlhP2833428334eusmtip1U;
	Thu, 29 Oct 2026 09:17:08 +0000 (GMT)
Message-ID: <abae1606-cc43-4ad4-b486-3a6e6aeed1b9@samsung.com>
Date: Thu, 29 Oct 2026 10:17:07 +0100
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
Subject: Re: [RFC 07/11] eth: ixgbe: use dma_alloc_coherent_node()
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
Cc: robin.murphy@arm.com, tglx@kernel.org, dave.hansen@linux.intel.com,
	x86@kernel.org, joro@8bytes.org, will@kernel.org, leon@kernel.org,
	mbloch@nvidia.com, iommu@lists.linux.dev, netdev@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <87se1o51wu.fsf@all.your.base.are.belong.to.us>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261029091708eucas1p1eceac71c0d1f0166ae56525ddf6335fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029084721eucas1p20638037770ab8e64e7c25196b49206e0
X-EPHeader: CA
X-CMS-RootMailID: 20261029084721eucas1p20638037770ab8e64e7c25196b49206e0
References: <20261027022528.633359-1-kuba@kernel.org>
	<20261027022528.633359-8-kuba@kernel.org>
	<87ecdb5x8k.fsf@all.your.base.are.belong.to.us>
	<20261027085133.2832f2f5@kernel.org>
	<87wlr33z6z.fsf@all.your.base.are.belong.to.us>
	<20261027112003.330bbded@kernel.org>
	<CGME20261029084721eucas1p20638037770ab8e64e7c25196b49206e0@eucas1p2.samsung.com>
	<87se1o51wu.fsf@all.your.base.are.belong.to.us>

On 29.10.2026 09:47, Björn Töpel wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>> On Tue, 27 Oct 2026 17:06:44 +0100 Björn Töpel wrote:
>>> Jakub Kicinski <kuba@kernel.org> writes:
>>>> On Tue, 27 Oct 2026 10:06:03 +0100 Björn Töpel wrote:  
>>>>> Not really this series, but the fallback here is odd, no? I thought the
>>>>> allocator already did cross-zone fallback?  
>>>> Fair, I was too lazy to check. I'll remove the fallbacks in the same
>>>> patch. Seems obvious enough. LMK if you prefer separate.  
>>> Hmm. Seems like dma_alloc_contiguous() doesn't spill over to other
>>> nodes. It only tries the per-NUMA CMA... so keeping it is bit more
>>> robust. (Then again, I dunno...)
>>>
>>> I'd say keep it.
>> Or we fold the retry into the helper? I tried to write the kdoc:
>>
>> /**
>>  * dma_alloc_attrs_node - allocate coherent memory on a given NUMA node
>>  * @dev: device to allocate the memory for
>>  * @size: size of the allocation
>>  * @dma_handle: returns the DMA address of the allocation
>>  * @flag: GFP flags for the allocation
>>  * @attrs: DMA_ATTR_* flags for the allocation
>>  * @node: NUMA node to allocate the memory on, NUMA_NO_NODE for no preference
>>  *
>>  * Same as dma_alloc_attrs() but places the memory on @node rather than on the
>>  * node of @dev. Like with kmalloc_node() the node is only a preference,
>>  * the page allocator may fall back to other nodes if @node is out of memory.
>>  * The contiguous memory allocator (CMA) does not: only the CMA area of @node
>>  * and the global CMA area are tried. The allocation may fail even though the
>>  * CMA area of another node, e.g. that of @dev, still has free space.
>>  *
>>  * Allocations served from per-device coherent pools or CMA areas, restricted
>>  * or atomic pools, or by dma_map_ops implementations do not take @node into
>>  * account.
>>  *
>>  * Return: the CPU address of the allocation, or NULL on failure.
>>  */
>>
>> This feels like too much explaining of the internals for a commonly
>> used APIs. If we retry in the helper all we have to say is basically
>> "acts like kmalloc_node()".
> Yeah, that's a lot.
>
>> WDYT?
> Agree that it's odd that the caller need to know CMA internals, but I'm
> not sure retrying the entire DMA allocation in the helper is the right
> way. Can the fallback be handled in dma_alloc_contigous()? I would still
> not do that in this series, but keep as is.

Definitely, I would prefer to add such fallback to dma_alloc_contigous().

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

