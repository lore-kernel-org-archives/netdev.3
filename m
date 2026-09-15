Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AFC39E6EB;
	Tue, 15 Sep 2026 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473521; cv=none; b=H9kp2IWTjM+vBiFS/+mSTtNmIpJPqBmvzWwwsLiOO7nsrH3RWokXdWvxoFR03KpWxGBQlPWAhiThD+NpRkDg7RB1sMio/pIIgJ55rAN9yUzVoX4yNGOl2RPIG7VFZy/rvcUhnU3up2yOy/6ggeEBrTupidA/Fowj/tv5cCYVpiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473521; c=relaxed/simple;
	bh=a6BeIQkyBXeFZQqSm2GDwlOuCTRWkkmfEGCNEf3KJ54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP2cgPLyDuaQtWIEsS7Oy8zIH2Qr+5A60S9SnjeK9V7/Zkzq7oVxPH1ewgJGq1ld24Ewa9XJhHjk2sm6FcM9TywwKt8ecX7rs2Ip98vPhMhbyaReHI4slB3mzs5hfaZBvZpSYNxRY71flkOVLKNgufZnO8G+Ml05cRTAgfvWhRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/Fm9y/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/Fm9y/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7865D1F000FF;
	Tue, 15 Sep 2026 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473520;
	bh=G81COMtQNhYX0zALp20voZ321dKl8PDyZRagFYkHh1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C/Fm9y/hK6rlSZdEGpKbT1jnv9paCGDvoSpb8618BD4yppO9A1nAYbp3VvMWM7br0
	 b7ND7V1FJjbe05XBFNu6PyyR6AfCem1seXzqB1XuLnqqp5P2Q8nUJbdZHs9YQ9Wf1y
	 C1DyeWSMoFUiH9ZDN8oiZ9VnKoAOB2zEEiDTCbnBw/eHUWFfvL7XwF0r7HiACNkceh
	 ZTObiOIcF1/SjEmZOoifoOngOVts0tdfVHnKJifSpYqsaWG6YOc4ts+vDB8ULp7OVP
	 Fz/LJIXyKA0NjBkGl5mJQx9LopYnq/xEGSjvn5DlerLiraJQZcw4pjvZIcKaLbr33A
	 m6dqV8Srdaeaw==
Date: Tue, 15 Sep 2026 14:58:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v9 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <20260915115836.GN13683@unreal>
References: <20260911022649.573300-1-rkannoth@marvell.com>
 <20260915081633.GH13683@unreal>
 <aqkGNiu_BWOkA0A9@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqkGNiu_BWOkA0A9@rkannoth-OptiPlex-7090>

On Tue, Sep 15, 2026 at 02:17:50PM +0530, Ratheesh Kannoth wrote:
> On 2026-09-15 at 13:46:33, Leon Romanovsky (leon@kernel.org) wrote:
> > On Fri, Sep 11, 2026 at 07:56:49AM +0530, Ratheesh Kannoth wrote:
> > > qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
> > > allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
> > > the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
> > > regions (including CN10K LMTST areas that span page boundaries), so
> > > consumption grows with enabled interfaces and is hard to provision in CMA.
> > >
> > > Switch qmem to a streaming-DMA-style path: allocate memory with kmalloc(),
> > > then map it for device access with dma_map_single(). Add
> > > otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers and wire
> > > qmem_alloc()/qmem_free() through them instead of dma_alloc_attrs()/
> > > dma_free_attrs().
> > >
> > > This works on Octeon because the octeontx2 driver is written for
> > > DMA-coherent devices: Octeon platforms provide IO coherency (via SMMU), so
> > > the driver already uses streaming DMA APIs for packet data while
> > > deliberately skipping explicit CPU cache sync (DMA_ATTR_SKIP_CPU_SYNC).
> > > The same IO coherency lets qmem use a streaming map of kmalloc-backed
> > > memory instead of a dedicated coherent allocator or CMA reservation. That
> > > is valid because the platform is DMA-coherent, not because omitting
> > > dma_sync_* magically makes memory coherent.
> > >
> > > cc: Leon Romanovsky <leon@kernel.org>
> > > Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> >
> > The code itself looks fine now, but the commit message does not explain
> > why this patch is needed. It only describes what the patch does, which is
> > unnecessary here since the change itself is straightforward.
> >
> > Also, no bug is described, so neither the Fixes tag nor the "net" target
> > is appropriate for this patch.
> >
> 
> Below commit message is Okay ?

How about a simpler message?

octeontx2-af: Fix memory scaling limitation in SR-IOV mode

The original code used DMA_ATTR_FORCE_CONTIGUOUS, which could exhaust
the CMA pool when a large number of VFs were requested.

Fix this by switching to the DMA streaming API. This is equivalent on
Octeon platforms, which provide full I/O coherency via the SMMU.

Thanks

> 
> octeontx2-af: switch qmem from coherent DMA alloc to streaming DMA mapping
> 
> On platforms with CMA enabled, qmem_alloc() silently drains the CMA pool.
> qmem_alloc() calls dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
> routes every allocation through the CMA allocator. qmem backs NIX/NPA queue
> contexts, admin queues, and LMTST regions (including CN10K LMTST areas that
> span page boundaries), so the total footprint scales with the number of
> enabled interfaces and SR-IOV VFs. On systems with many active interfaces or
> many VF counts, this exhausts the CMA pool and causes qmem_alloc() to fail
> at interface bring-up or probe time
> 
> Octeon platforms provide full IO coherency via SMMU, so the driver already
> uses streaming DMA APIs for packet data while deliberately skipping explicit
> CPU cache sync (DMA_ATTR_SKIP_CPU_SYNC). The same IO coherency means qmem
> does not need a dedicated coherent allocator or CMA reservation — a
> streaming map of ordinary kmalloc-backed memory works correctly.
> 
> Fix this by switching qmem to a streaming-DMA path: allocate memory with
> kzalloc(), then map it for device access with dma_map_single(). Add
> otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers and wire
> qmem_alloc()/qmem_free() through them instead of dma_alloc_attrs()/
> dma_free_attrs(). This is valid because the platform is DMA-coherent, not
> because omitting dma_sync_* magically makes memory coherent.
> 
> Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> Signed-off-by: Ratheesh Kannoth rkannoth@marvell.com
