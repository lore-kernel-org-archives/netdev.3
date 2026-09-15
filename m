Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AFD3A873A;
	Tue, 15 Sep 2026 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462091; cv=none; b=LC+Wvy6KXQlDkGCp/Kkhj+B9x15LrtJMX24GYhZOLfvsRALRY2sLuTe3naaT7FxRDm0bRlFRqvYlK2Gr69EOIis15R2rX2Wgu1vn4xQkw4dSKOVqLDV7Ifz4hV/ZToMiw9q4FAa5YAymQN91Hks4IIXKKKelqkcu5TZWkpCo5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462091; c=relaxed/simple;
	bh=vaqu+SxyfThXMdAFljDGhWZ9rBcUGtYlCvuulCUPt3k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yc51WlYVODKTaVj9/xDJORBBI7QoYm5FAuwozmqsF4u70vYPQatea/hXZXBrRu0opu6/CYUIQljkOx4nYWPHPCIL5eM/jmDyaz/pkZh34NEfbvcqkcqv3Wf2bJNkJ4T9OsNXsRShw0gyNRUBjQagN/MdmB7ND9LfcBviBDAovCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dOvCt94X; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dOvCt94X"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6ZDt3976182;
	Tue, 15 Sep 2026 01:48:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
	aqu+SxyfThXMdAFljDGhWZ9rBcUGtYlCvuulCUPt3k=; b=dOvCt94XFM4DWqxc9
	kZFKlLJvjZKUPhrhc73dnD/XIeN+6ya7migYUNIGt/CoolGWSlURZTnaTRsnPvMb
	LBijWIWal/8W1Z9OiNsQwLFQiYhbVnSOXDb7QJ6GQUIiqvSAD4NsMAlDV2vxk8vy
	G56WkZ0mmxOjRMrU+kt4pimiFHVgStzxcp66ddS+tOAtTmieB5/xPNGSc7roeYpH
	lqnk3+65DQygIIkBM3hk4zhtFXuPQCStdeXNJH8HYHr4PzLCvct3TGygAWb7tsUQ
	SZq9jilcXexqtR4fwwnn/t4mZOW+XO4jDzAWlw9iE59vjZrQef0Vlq7b/Gbc6lON
	+R/Jw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gnu08r5d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 01:48:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Sep 2026 01:48:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 15 Sep 2026 01:48:00 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id DADF73F7080;
	Tue, 15 Sep 2026 01:47:56 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:17:50 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v9 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <aqkGNiu_BWOkA0A9@rkannoth-OptiPlex-7090>
References: <20260911022649.573300-1-rkannoth@marvell.com>
 <20260915081633.GH13683@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915081633.GH13683@unreal>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEyNSBTYWx0ZWRfX+wHlMs0ORp4k
 NpbAC2x4GOnqmF1UY+OzUr5a0PLyz/gWbtcmSXpGnTusaEm16Zh6y5gXfXwAQMiQCuHqrkFk3f5
 FVcLs0jU5tDPHgyJDXkOeXf81nhiXJAo3cVHfT627w1m7qxEPuKUY0xMHDl6uvnmrQqSmPr5Nd1
 ZAuPQUnkcCwlOlakM8hZn8grGKpk9k3O61YxrvpXzxR/5A8AV+Q1r4gd2tmx5rakyoVN/PyQ0xc
 tgk3GErs1t1sl3w7jYomkSQvndcXvay8TlMqYO05fRPRq/wTjMpvoLkeU6Z7BfiahLJyH234io+
 +/yithEdQsIE/0Vbbe4x3OgDpiRjCam/iOllI4xEMKuy1FvvbKqZ3XprJHHPHPkf/8ecmI2pfHi
 7hdqanVZnsYtdipp5ttQ+EE9Mp0BWax0hlVj8iaMtP2bm8m4BN+glGlP1hhcwM5eVeV3Zpjt4GE
 8ga5fcVWkHxtqqvu+VQ==
X-Proofpoint-GUID: AWwiQd0DyDEG7PUrz88WHRD-CDvD7eRY
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6aa90641 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=cAbf1uCxQqeJHfMLl7IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEyNSBTYWx0ZWRfX6lJwQQeUNLxO
 KreTtN3wHDItTyJUJu7UtX5thGizWcBCUr6vD5YKGl7C7S7sRzyVGIq49Pk0D/OKZNxNAdrlmIy
 9YBqOuDP8VGKCMG9knDC7oifC3WCY0I=
X-Proofpoint-ORIG-GUID: AWwiQd0DyDEG7PUrz88WHRD-CDvD7eRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01

On 2026-09-15 at 13:46:33, Leon Romanovsky (leon@kernel.org) wrote:
> On Fri, Sep 11, 2026 at 07:56:49AM +0530, Ratheesh Kannoth wrote:
> > qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
> > allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
> > the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
> > regions (including CN10K LMTST areas that span page boundaries), so
> > consumption grows with enabled interfaces and is hard to provision in CMA.
> >
> > Switch qmem to a streaming-DMA-style path: allocate memory with kmalloc(),
> > then map it for device access with dma_map_single(). Add
> > otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers and wire
> > qmem_alloc()/qmem_free() through them instead of dma_alloc_attrs()/
> > dma_free_attrs().
> >
> > This works on Octeon because the octeontx2 driver is written for
> > DMA-coherent devices: Octeon platforms provide IO coherency (via SMMU), so
> > the driver already uses streaming DMA APIs for packet data while
> > deliberately skipping explicit CPU cache sync (DMA_ATTR_SKIP_CPU_SYNC).
> > The same IO coherency lets qmem use a streaming map of kmalloc-backed
> > memory instead of a dedicated coherent allocator or CMA reservation. That
> > is valid because the platform is DMA-coherent, not because omitting
> > dma_sync_* magically makes memory coherent.
> >
> > cc: Leon Romanovsky <leon@kernel.org>
> > Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
>
> The code itself looks fine now, but the commit message does not explain
> why this patch is needed. It only describes what the patch does, which is
> unnecessary here since the change itself is straightforward.
>
> Also, no bug is described, so neither the Fixes tag nor the "net" target
> is appropriate for this patch.
>

Below commit message is Okay ?

octeontx2-af: switch qmem from coherent DMA alloc to streaming DMA mapping

On platforms with CMA enabled, qmem_alloc() silently drains the CMA pool.
qmem_alloc() calls dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
routes every allocation through the CMA allocator. qmem backs NIX/NPA queue
contexts, admin queues, and LMTST regions (including CN10K LMTST areas that
span page boundaries), so the total footprint scales with the number of
enabled interfaces and SR-IOV VFs. On systems with many active interfaces or
many VF counts, this exhausts the CMA pool and causes qmem_alloc() to fail
at interface bring-up or probe time

Octeon platforms provide full IO coherency via SMMU, so the driver already
uses streaming DMA APIs for packet data while deliberately skipping explicit
CPU cache sync (DMA_ATTR_SKIP_CPU_SYNC). The same IO coherency means qmem
does not need a dedicated coherent allocator or CMA reservation — a
streaming map of ordinary kmalloc-backed memory works correctly.

Fix this by switching qmem to a streaming-DMA path: allocate memory with
kzalloc(), then map it for device access with dma_map_single(). Add
otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers and wire
qmem_alloc()/qmem_free() through them instead of dma_alloc_attrs()/
dma_free_attrs(). This is valid because the platform is DMA-coherent, not
because omitting dma_sync_* magically makes memory coherent.

Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
Signed-off-by: Ratheesh Kannoth rkannoth@marvell.com
