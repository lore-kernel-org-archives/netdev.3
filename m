Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716766;
	b=fIQxzccld53Uh2PdMmxrW2zLwAj+4BaglYx0qZ0yRPahaUKipfJYozYp3p0dgKj1iY6Q
	 RpznsQjwulLpgV775fB028GT+GYY+D6h5cvXS3ehPEowiDMPdc2mq+Hm5sGDTJCtzgMkk
	 0g2lXnNEJWoomFfvmepmUvnKue/MyXMUIMvfdfzlb+WaZq2RXk9ihsVPknUuUce5k26A4
	 gV8+ZS7Od6FS7ykPZgqN25nAbZw/53/4FLBi/bHjt1zBLEYzruCVCScJaClcf5X9LrvDx
	 7cf7mVWlJ5YDinvd1KBxi/5CXtusOsSEIRDwcX19wvj96xCSSP/y48xYo16J8OREnnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716766;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZvTmdzQJQ43oJnpvkWJ5Ha/sqUIEicvQIILfKh9iJY8=;
	b=Ah5U4b4XkuIFhcrSiEcN2Wpzt7eb+gPAm7FdCekoeZCo+iCbyOn5w1BrRLRh+ncPpp34
	 dYiXgxOfwh5mBnLr6XrO1RRWc1b2VjPk8H+8wN+1w9qjUYOCcrV7yKDeje5Qmhtmp0lqW
	 tkEqzIIxVQdNRYzeXeOHzy7rX9nX3irTQjoK4DCyw2DvgFX2WRZR6/eI5C3aAeK4YvAqz
	 6zzXSL+VwLa60tGYiiAhly1l1Ucgr5dQ4cGFCHChxg9AColXcLv2ayrA4FqgRgmdEY3kd
	 8oBrA433n9zSZQvhmmv1Gr/tYqVwUB4knvSqLq1zvGooFqbnxipUTDB5L7zePAP081w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LaByCU3w;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD013606A32F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD013606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LaByCU3w
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B56521595;
	Tue,  3 Nov 2026 06:39:20 -0800 (PST)
Received: from [10.57.17.5] (unknown [10.57.17.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3A093F628;
	Tue,  3 Nov 2026 06:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793716763; bh=RYow06Eosvjwu34uA+SyftMMj7+vHJ5DcRL0r3RV7Og=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LaByCU3wRJGLEndoTh2zoMl7+mZ3Q589iKCQ6NhRuNT32KH4J00zXQpqOegL/GyoK
	 GRPzTmxO22giYyRXfWmLX7U0+lrOBEer0UPD6aN7Eytd5dYxANlMjBw5TA7KDfxhmI
	 a4q/jhxhAhHSlxwmxqXGjYzSQ5tj9g1thQHv+9Wo=
Message-ID: <43ba7b3e-d3fe-4aa6-b689-61c2a0ff7226@arm.com>
Date: Tue, 3 Nov 2026 14:39:11 +0000
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
Subject: Re: [RFC 07/11] eth: ixgbe: use dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, tglx@kernel.org,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, leon@kernel.org, mbloch@nvidia.com, iommu@lists.linux.dev,
 netdev@vger.kernel.org
References: <20261027022528.633359-1-kuba@kernel.org>
 <20261027022528.633359-8-kuba@kernel.org>
 <87ecdb5x8k.fsf@all.your.base.are.belong.to.us>
 <20261027085133.2832f2f5@kernel.org>
 <87wlr33z6z.fsf@all.your.base.are.belong.to.us>
 <20261027112003.330bbded@kernel.org>
 <CGME20261029084721eucas1p20638037770ab8e64e7c25196b49206e0@eucas1p2.samsung.com>
 <87se1o51wu.fsf@all.your.base.are.belong.to.us>
 <abae1606-cc43-4ad4-b486-3a6e6aeed1b9@samsung.com>
 <20261029084756.06a2a827@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261029084756.06a2a827@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-29 3:47 pm, Jakub Kicinski wrote:
> On Thu, 29 Oct 2026 10:17:07 +0100 Marek Szyprowski wrote:
>>> Agree that it's odd that the caller need to know CMA internals, but I'm
>>> not sure retrying the entire DMA allocation in the helper is the right
>>> way. Can the fallback be handled in dma_alloc_contigous()? I would still
>>> not do that in this series, but keep as is.
>>
>> Definitely, I would prefer to add such fallback to dma_alloc_contigous().
> 
> Alright, so to be clear the plan is to stick to the "may or may not,
> good luck" semantics.

Yeah, given the number of different allocation paths and conditions even 
in dma-direct and iommu-dma, let alone the omission of all the 
dma_map_ops implementations, I think we have no choice but to consider 
the node as a hint rather than a hard requirement anyway. It's just an 
explicit hint for callers to optimise for CPU access, rather than the 
implicit default hint of "local to the device" to optimise for device 
access.

To that end, I'd be inclined to introduce the top-level API (i.e. patch 
#4) first, then start wiring up the propagation through implementations 
underneath it - might save a tiny bit of churn, and make the intent 
clearer IMO.

Thanks,
Robin.
