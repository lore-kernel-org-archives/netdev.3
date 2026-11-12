Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490143;
	b=ZWQDoeYvKoei/KIyhPIi2nyR461Fu8HmXsQwKckkcGt6KPczsY1QWVbIqW5iaLVOOqu5
	 lXq2+0+fs/CkrjYJkUTMrNcn+28CQQ1TdZJ5Xrhgw4fehEjdYPD2K/3LwLv8omE9fuyiq
	 ayoWDP0h5S7j0jG09psT8h7OZdLkrSt2p7iIhnlYV20FgfKWYu954gT1RMPhm4cHsPbA1
	 S1/K/UGnU/1AVP1XA2aNJzzwVfqwUOdUIL+6p2iWIdPMnk70CXZ4maGJjCfGZOlHtCmaJ
	 fjFXAMYFobWsZIFdS04Tboxl646iqcbGR0yZNLE8gn2Nh+kEr86a1FHvl/P+X0BDIiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490143;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gy/PKz1d5ixzrcpFIizQmpzhOaryY3xxJM1z73yskEg=;
	b=yNah+MP/2SwWg7Dkv2lDlhI+VhnSdJYVw6biIOk/fFgiFtMBNcasqOLKNNaEKY/6qmX8
	 ObAoGiN0En0koP9YUfeI94b5WFvsElpLh5fP1ssbnSQmLf9Nm9lvchvIQT8ev9bbdpFUV
	 hWcyIyY5+1QHv+sPIEB+sQsgXuRenUDeoBSdOmG9kWV70AG7nFZZGQregCMQqLFKkcEJ+
	 kJWkmR5hoMa2cS81k4i3Qtcol8/lRnODsc0R8SzLt+TaxqACc/6ESocnAV3fBA4+GkR9M
	 2wbcqiSzGZde/OGa/MYVqD158YHSrdGqzEE8aP1GnlQ4Kcwk7ZEhsaPxcUt7c0qOJHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KJFlzHPo;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70760606A886
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70760606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KJFlzHPo
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8BB11477;
	Thu, 12 Nov 2026 05:28:59 -0800 (PST)
Received: from [10.57.89.53] (unknown [10.57.89.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FCBE3F632;
	Thu, 12 Nov 2026 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794490142; bh=PsO/9ilVImQiMNmG3gCp6rdWfB3zLayHl7GRSKsuGos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KJFlzHPovRGZbmWSNCjPwJ/WawxTcWt8qQg/Q8Qf/oMZRh4qcXiPJQyg/sZQJILZJ
	 HRNuW2kEyrQre5oCEckwkwHKYusPG6WPWdb+TUQqBPBtkLE2g9751Sysb8QC7Y6OzY
	 dnPxZe5aetEC5e+0qUgYA052moUGkYYf5MZr7X5s=
Message-ID: <d00d3435-fcce-4c0f-8ed5-a672b5b85dfb@arm.com>
Date: Thu, 12 Nov 2026 13:28:53 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] dma-contiguous: pass the NUMA node to
 dma_alloc_contiguous()
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
 <20261106184433.761422-5-kuba@kernel.org>
 <c83426a5-d21c-4f0d-b13e-099b6f96df6f@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <c83426a5-d21c-4f0d-b13e-099b6f96df6f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-12 9:53 am, Paolo Abeni wrote:
> On 11/6/26 19:44, Jakub Kicinski wrote:
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -642,6 +642,13 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
>>    * Same as dma_alloc_attrs() but places the memory on @node rather 
>> than on the
>>    * node of @dev. Like with kmalloc_node() the node is only a 
>> preference,
>>    * the page allocator may fall back to other nodes if @node is out 
>> of memory.
>> + * The contiguous memory allocator (CMA) does not: only the CMA area 
>> of @node
>> + * and the global CMA area are tried. The allocation may fail even 
>> though the
>> + * CMA area of another node, e.g. that of @dev, still has free space.
>> + *
>> + * Allocations served from per-device or global coherent pools, per- 
>> device CMA
>> + * areas, restricted or atomic pools, arch_dma_alloc() or dma_map_ops
>> + * implementations do not take @node into account.
> I'm possibly over-thinking here, but AFAICS there are a bunch of 
> dma_map_ops that
> are using dev_to_node():
> 
> dma_iommu_alloc_coherent() in arch/powerpc/kernel/dma-iommu.c
> vio_dma_iommu_alloc_coherent() in arch/powerpc/platforms/pseries/vio.c
> gart_alloc_coherent() in arch/x86/kernel/amd_gart_64.c
> 
> With this series they will stop using the driver provided numa node.
> Probably not a blocker but possibly worth to call out?

Nothing "stops" - this series adds a *new* interface by which drivers 
can now indicate a specific preferred node, but DMA API backends are 
still free to ignore the caller-provided hint and continue doing 
whatever they want. This is already called out all over the series in 
commit messages, documentation and comments including the one above.

If anyone does want to do the additional work to wire this up through 
dma_map_ops for powerpc's benefit (I doubt the rest of the 
legacy/embedded architectures will ever care), they will be welcome to 
do so. But as-is, all that happens is that the driver changes here have 
no effect on those systems and will keep working just as they did before.

Thanks,
Robin.
