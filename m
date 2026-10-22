Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792705938;
	b=wSHCeu/ZKVbEXR2um7nihmmfEBPpFhNs+jhNgww+vox5jqdlBm0ADnu5oQ8AIIu1INdR
	 ptlfjpfGF6a916oLzdEY8zA16PTG3A8dSGFFeVyDVxO6P0DLCQtKntrnAFoeoxCD5HTD5
	 h7JnprDkVKFlc79FD/RyPI14ZGiaaZQgGmCIHDbp9/cMAEMvp46JgOkY6o/fwlisXiZiU
	 PrByujL2JvIZMRaS4Vff+aOY+p+5/mm6V06UccLDMnTKGkB3cABEnXZchZLh+VAF4hCQn
	 L/67F/u12gCBNhXZNLnNRxBYwNJRGTzM9YosXPxGye6bBpURoi05ezYQz2k3e59WAZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=enf2YbTyhYZro8noMVoZG0AyfViHUg43We1xb8wdUb4=;
	b=4uAZDE99vOatFPCD6EkRsG9jEBhhuRWwwvJ5hSFBzD2hKjjiVWzo5SZkX8pWHC2JTeoE
	 C6eQZYY3n7ikRPkFRGbBnFYZj18kA4ZWcIO306ljfwt5qK0jodHtH/gHUefu8rZgaaCqe
	 JUmRfu3UH1U+SwlW4zlmpTaerBwlYR1TXNJh3ly5/SADF6u/qJYBlxrlJNvD3rebtYISH
	 6yCPxrpOf5mhlDk03dKcexv7quZbRpBVQwKEJgRI/HmkstfwJEBXRmHj6YOSP2R4vE9uC
	 YkLPSF20ibwBGJBUfQhCV0AE93MVb6hmw9gjGGPsZAYIXpVpYohmW7fNqFRdiY/rQtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="vR4/0e5/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0E260A2615
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 21:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B0E260A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vR4/0e5/
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9f6a16afcso9735ad.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792705938; cv=none;
        d=google.com; s=arc-20260327;
        b=gwCS8P9xTD+Vs+vmZqK9M/p+f5sH8R0JZiswVPv2z8mJFIybv71w9yETM8HmKrt8Xo
         Er0QfYAl4Yqw/elcax/j+F4Y2XFQj2PX/R/IMYAPCGjeFYwJz1q/BGoYxnR/s2bKwOrp
         rDptHLIXp3Xtarj5iMzMszHus5nW3hAcaJs2pgLZJi3BIfTBaURvfCh+5xXbJeuJtm3y
         DIBfTxKlG1O7iTw8IdANBTzpxgpFz/iG1/j4V2+RHkaOeVEZkGxu+ytpxHQLGSzgdlMV
         I2VWz3L8GL6H/PNtjuMreHMHApefvuKvHJjvoQnD0+kOwJnl0Lz207JT1891+xYqwL4k
         P7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=enf2YbTyhYZro8noMVoZG0AyfViHUg43We1xb8wdUb4=;
        fh=8urZVQXuBsYHf4wiFJFgN0GWYpDnhoAZ2qi4h5fczHY=;
        b=P0AO0cd3V1JmNZInShMHFy5ZK5bT/Ag3bwZC+DofqJw8B/cmSNF10y8jTRLPcc5J/q
         CYbwMXw38eut5ykS+1rbMXQ64XjAgVDqMkfnwCUu1YKIl/Dv6IuZKfHKnudTj1QA8hyS
         3pQwAYF8hYNtC7mUR7d2K03wV/ovJgDBiqwp6Ny+XW+hsjsSgFE5Rj+mbKfbODqLjz4e
         UnOGNIKuUmQQKVs8jBJjJYLLJk5p23cIz/XJs1ZXDPH5KGOQngMmBJgKPr7MZQPL1Tyr
         65Fg0IyD14cRGsRz9Gw/FsAcdM+2m9UPAl96Xg3xmIBRqpKqF9ia1O7WEHSdxb/A91x8
         M94w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792705938; x=1793310738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=enf2YbTyhYZro8noMVoZG0AyfViHUg43We1xb8wdUb4=;
        b=vR4/0e5/JRr2Dvd4ShtgOGqzPoNeNshuP/PbMN+6K27p+PRJxj0xOLZjLQ/0htGd/f
         uxta0kWk2v6K//ugXcRm+sW0jKp0P3QNBL6voAO3LLb4nuRCm4UFAVXfUpOZJywQYAnC
         3btTEhQJA+D19G47JVsMiU1n0aUXjxiQG/VEmTkjvn/pN1ZXsXI/18HpyxiWmc4vSMg6
         U2e62gj9byzpQnohPAaQGDH+cIei+N7NR2J056FqjaB1E1v9J+SP2T/xSC0pagBnoX0G
         3ZXOX8cppcTK/h6fDPvw2QXvsjcpJlPxLdL6RlMJLljJrIh2z9pvnW79r4DpkITY4dUY
         N/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792705938; x=1793310738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=enf2YbTyhYZro8noMVoZG0AyfViHUg43We1xb8wdUb4=;
        b=vVOdFcj67HCPOYDGwEK+kuFucYGPVBe/UHqwfnj3WEvU2kQ3pMOxvI2flvVPWr7gPV
         7/qck+aFi70+VigxWShhWuXLubIlDmvhDDl/IJpvSFzTcQxaovjBbfjRtJAINdaiFa8G
         z++FXN/4qfM5LYPF18w0HrbWGrKvXDENEzio7NaedGLwtviqjtUh1sG2YOyAZ8b+JRGg
         m+hyxoanSnjmXHlJIAbRvX4sXtxuYQ0uTyaqeTd9reVQyk5PW0isjtE1A+Sm1EPbZFtQ
         vIcocruAn4LNiHvmTEc6VikWE4MOgLz60Lcv9Bw5Ihy3jjuwFV9KMLjg6dhhGIIUj+ZK
         SL3Q==
X-Forwarded-Encrypted: i=1; AKwUvBy7+7E/HF1DpOIOLvP7MeFplkCpASp5U37Hd+yyjhSV/3FLpMrxHxA0lXUQ74ZInK9qgewbxcA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoeP7Up6IfkVKllNRdmYrpRSBf8vBioBJUFA8SB8CqcQnZ7NPH
	CXTmid44RdtelObk6PRAGgB/K6BUpogAM+zw49kgiPtlbD0sf7MBIvkXIPlkGm8ji83TYDzbjoK
	8OOutCg276s8GWAsjKL6gFuDM9ozJl2aJGqJ4XlEl
X-Gm-Gg: AYBFou2Lw54sxmtvzdfUes+iLS40GXKoYqH2TZnLrC+6x2eePeqzBEWMunfwycZwN0g
	fTNj5MG2j1JD3WtDW4ckYFU+MVxupNjszTJ3goo+UGQT/yOfGvHrMRlYcIUcqqqSNC4eIMvZz2/
	m8JxTr2xLTAHM2sJ6Pg9M5CYVVnvLx6oZ7M23ZTADg6VJ2pE51CwnqHLNlk/odheR9Kj4Ro7L9y
	jgzg0M/HxbB18jW1P60zSrVNIH47a4Oe6zy7ZCmStPhDjmR8dunUnX7xzK9z/W3g2UoLDh7p2wx
	AGNHqw8Z3qOnoxGxYER2ZnBX/qXs7H3drgiauTEAiOpHS+oV+hX38yCF4LTRcpbI/sNWb8mkjJ1
	t/QS76PP13P3bUEHlUxJNT855cfzXZhf3NE0KHBAcuDd1aT2u70e7D4Vc/uU=
X-Received: by 2002:a17:902:e881:b0:2e6:1917:fa with SMTP id
 d9443c01a7336-2ea7ed0feb4mr728955ad.7.1792705937217; Thu, 22 Oct 2026
 14:52:17 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca>
In-Reply-To: <20261022201229.GH3381610@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 22 Oct 2026 23:51:40 +0200
X-Gm-Features: AclHuK-9aqzBfV-60_dzPgAjNzAFJyPZLZoLZFY0CUqnWbJGyVX0XJhPkps5rLY
Message-ID: <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 10:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Sat, Oct 17, 2026 at 07:11:28PM +0200, Luigi Rizzo wrote:
> > > We should probably just find a way to describe that this is a POOL th=
at focuses
> > > on physical contiguity in some configured granularity.
> >
> > Before embarking in a global renaming, I would like to get opinions on
> > acceptable alternative names (possibly with a short prefix usable for
> > identifiers in the code). I could think of the following
> >
> > DMA_PMAP (for PreMapped or Persistent Mapped)
> > or, ahemm...
> > DMA_PISA (Pooled IOMMU Superpage Allocator)
> > both using dmap_ for internal name prefixes
>
> Can someone explain what outside netdev would use this? And why you
> couldn't do this in the netdev page pool?

I can try.

Regarding users, the next target is disks (not included in this series)

Regarding why not just pagepool, see below.

FWIW when I started this (after the previous work on swiotlb copy elision
https://lore.kernel.org/all/20260824152932.1583506-1-lrizzo@google.com/ )
I thought this would take only some simple tweaks to pagepool and
skb_page_frag_refill, a couple of days with some agents tops.
But the agents did point out that there were a ton of corner
cases to handle (device detach, reconfiguration, memory
reclaiming, reducing locking contention...).

As a reminder my goals are the following:
- reduce DMA map/unmap costs in strict iommu mode without the DMA-FQ
  compromise on security
- address the IOTLB thrashing problem when using 4K mappings
  (very serious even with DMA-FQ)
- help reduce bounce buffer usage in confidential computing and
overcommitted VMs.

With that in mind:

> It is not a common workload to have the DMA allocator be the one that
> allocates the memory. Usually we are DMA'ing from memory that was
> allocated someplace else.

Aside from the fact that dma_alloc_attr()/dma_alloc_coherent()
does memory allocation + iova allocation/mapping,
this is not what happens here.
Maybe the confusion comes from one function name
(dma_map_alloc_pages()), but it doesn't map any thing.

My code (in this version, and more in the upcoming release)
mainly implements a specialized memory allocator with an
API equivalent to alloc_pages() and variants, but ensures that
the order-N blocks come from contiguous 2MB blocks reserved on the fly.

The physical addresses of these blocks are recognized by the
"dma allocator" (I suppose you meant the entity that allocates the IOVA ran=
ge)
so that it can apply specialized IOMMU mappings backed by 2MB IOMMU leaves.

And finally, it hooks into existing kernel subsystem (pagepool,
the skb transmit buffer allocation, dma_alloc_*(), dma_map_*()
so that devices can opt-in to use it without any driver code change.

Regarding pagepool:
For the receive path, I do use my allocator to feed pagepool
(in the next version I have wrapped it into a proper memory provider
interface. Non-pagepool NICs can either use a few trivial changes
to call dma_map_alloc_pages() when filling their rings,
or convert to pagepool (slightly bigger change; anyways
there are options).

Note that just feeding the pagepool with 2MB pages is not efficient because
the fragmentation in pagepool is done with a bump
allocator, so recycling blocks from a 2MB page is difficult
(it has to wait until all 512 blocks to become idle). My code
has a bitmap to track usage, so it naturally recycles at the block level.

Then there is the transmit path.

For skb heads, one simple solution is to use tx head bounce buffers
some of the patches in the series show that option (the next version
implements a proper tx-copybreak).

Otherwise we need to populate skb heads with pre-mapped
memory. In the next version I have a simple modification to
the slub code to accept an opt-in alternative to alloc_pages().
I considered using the pagepool, but the changes would be
similar and the layering seemed really odd, with a cache on top
of a cache.

For transmit, there is a bit of impedance mismatch as well:
skb_page_frag_refill() does not know which device
we want to use (in fact, it is a per-task so there may be
many netdevs used by a task). We could tweak the pagepool
to be device-agnostic, but that would be a bit more
intrusive (more architecturally than in terms of code);
also we need to make sure dma_map() on those pages does the right thing
without trying to map/unmap the individual 4K fragments,
and we need to make sure the skb_free() etc does
not leak those pages into free_pages().

>
> I think Robin is right, this is just a special case of the dma pool,
> and it certainly shouldn't be something as grandiose as a subsystem..
>

dma_pool() could be tweaked to allocate 2MB and return order-N fragments,
so maybe that could be a provider for pagepool, but it has some caveats:
- when fragmenting, the freelist is constructed in-band, ie using
  memory exposed to the IO device. That is really a no-go if we use the IOM=
MU
  because we don't trust the device, so we would also need to
  allocate extra memory for the freelist (no big deal, but
  that is basically what my dma_pmd_meta supports)
- memory is never released until the pool is destroyed,
  so there is a problem of stranded idle memory.

Trying to use dma_pool for the transmit path has all the problems
listed above: lack of device, inefficient release of memory,
coarse grained locking...

In summary: of course we could tweak existing subsystems, trying
to reuse them in ways that were probably not anticipated
(see the above partial list of missing features).

I think that once one addresses the functional and performance
problems, the changes would become quite intrusive and the risk
of penalizing the currently supported code path might become significant.

cheers
luigi
