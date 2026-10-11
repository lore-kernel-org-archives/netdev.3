Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244D380FC1
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791709388; cv=none; b=WwhvomNsVzT/1D0Dz+YqI6gj046XyH8bJIq87AOfyn7i9kKFHdshO1BPcG2/bl8E0e5qlP2XeFiFJi/JRzrMXvH8iaAH6xJ0TUiYQ4Rjl9ArIwmtDcnXvuxUtOs7XfagontcHVPpbBfN049Uxcj+TZ4QRg8x9hUYpEEKJ/7BIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791709388; c=relaxed/simple;
	bh=yQNy5NpswkjkGeyFIb6D2Av/9wJgprKZuQYo7hdra8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRs2sFcZeaaaoSIA80JJPEb36hOoiFoMKbGPjKzdiawGHwNxBpb41DSip6zwn+UOkaAK+XJ/F7i0xq9B+yGub3GFZ+yuzfqTTIm7CvA8WJWaCx7tLNDLyxgzl6XTeDW49WXVvDP8AUqVrnLRcoYXUbms+8v9IH+WyacVD8kJPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4xQ8vwC; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4xQ8vwC"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-150ef97e790so3455c88.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791709386; x=1792314186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mnvvNDQ4QSwr11mN2HQofr10EXpSOnRYT1GPrI43QCA=;
        b=j4xQ8vwCkRJ3h+Yq0L5RgGi4wbfxdv4ubSyYVAHIAQIQCvbT/Eab8s+CWlwAa5FaDA
         rQy1qsn7fL+GVTn8PXTUr+cPkRI74Ck55+vjDtVNjeSoxmZgT4865ESmV5GHgJ/w6tWW
         WKtXgSgrY3CciXleoRdGBetatrjC5mgeXGx0Y+hXwRULEjIGYmjceQtIYK0okyQgLSmt
         fDexy9wOOcB1rPrPrcmBaVr2mcKP6+G/qUuIo0LmwSe/jLtY5E5suba+A4/ko9SETbmE
         NOuW6Db/A8Ukdujfn4juL70ZHPxgJI3IgmEIBtdImaW1TAR0nwBftW8O5R9qKto6ebKQ
         GxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791709386; x=1792314186;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mnvvNDQ4QSwr11mN2HQofr10EXpSOnRYT1GPrI43QCA=;
        b=FowIQ05Xk9jCt4lXKPHz0kb5Ot3nhVIU01WGoF8AiY1u8qS2nUYtTlGJxsJn3qmHUE
         PzwAY+C1n5d2lkmLXzKxXkVk9vTcTPutRQyKW2zKC8QLBIPAjJGm0OD32Z1DUY7BN9gJ
         C0qtaI3Gormo2BaloEDNIyy/onvCmOgyTM0rlYCGic/2TJ9WIju7EhMJYUUCMpGXWE5S
         cPttkx5CUv3RMiO5xDN0870hqG7at0sdCMo9N9yoNnnPuKLV+FS2+ndAatCDrJQh1puG
         fNp2xOCAYeeDF/E+WbSxEIwQHyBuXMFIMo72VcYsjq2JtHh1g9tUNABkvRfSqKMoid9G
         D6IA==
X-Forwarded-Encrypted: i=1; AKwUvBxLTYtW5mLmDuLw/WU92CjEvQAC+WigSa6/enmo+h6xrhyKzYDs5cIbinKpa6SGkTM1wlphJaY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0fk70WeTLAfDpXyNEDj0PUgL4WoJPH+ApQ08LU8Y31y/6vEPS
	cWXaR3/v5EfUyik30iKL/f2VqZFvV/QVInhRdl+BQVaJGhDhRmZZsAoYkF3Joe5myQ==
X-Gm-Gg: AYBFou2aXyJSqn78+PkwLwCe8HDHPNyhMW5aIbxzHiDfETpQq6gH9NqILALeUczyxbk
	TPLwxEZFmDCJvSMIdKLAqxVtepT8xNPHu5DYGw71gkuLmUyhHX5+7xFoj5QFSyBfpWluu+Y4Kzy
	8QhPjpTQJrqScfkOht/fCb6wj834rT/gggfLeXNJWSESNDRag2AHgAvsLVY8W/Ku7FsUGalMUib
	d0HQdl/HncF8dUOIjiF3GLBFXLITkFB3uXaQyju0hsl4Po1UeotqlnDAclbKaiJCZXalrMiTk6C
	eKwVQjBEU+faJCuaqncu0W33jm78o4HJPu6DM1rL+N0znhdiSQFilHzmu7X4IL2c1uI/tPff87U
	VXayzi4pcuXj64EPqY0Hld+h5+NypHVccFZAp453T2XKmCqBCAnBm7aPwyHX+A7jwN87OMkoWBK
	yCULHTWKO6YhWgbIFmA74RanNyphdaUP5XHH4pRGY/sEe+zuewU7CpMG7kiTVtDiLwyiD9En3Vt
	7uht5kH8RhTIM+3Wp90HlGqCcmM
X-Received: by 2002:a05:7022:103:b0:144:cad0:b472 with SMTP id a92af1059eb24-16ef25fdbdbmr175230c88.9.1791709384349;
        Sun, 11 Oct 2026 02:03:04 -0700 (PDT)
Received: from google.com (57.45.87.34.bc.googleusercontent.com. [34.87.45.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm28915417eec.9.2026.10.11.02.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 02:03:02 -0700 (PDT)
Date: Sun, 11 Oct 2026 09:02:51 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
Message-ID: <astQu7_kbZRnbwng@google.com>
References: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>

On Sat, Oct 03, 2026 at 09:22:19PM +0000, Luigi Rizzo wrote:

Hi Luigi,

> Here is a subsystem called DMA_PMD on which I would like feedback on
> architecture, possible enhancements, or kernel components that could be
> reused to avoid duplication.
> 

Thanks for posting this series, it solves more than one problems.
I went through the whole series and the following is my take on the
overall design (I might wait before replying to individual patches
hence this might be verbose).

> I think it can be extremely useful for those affected by the HW/SW overhead
> of IOMMU (especially IOTLB thrashing, see [1]), or confidential computing,
> or preemptable VMs.
> 
> The (not too exaggerated) pitch line is
> 
> DMA_PMD has the performance of identity, guarantees that only IO buffers
> can ever have active IOMMU or IOTLB mappings, removes the bounce buffer
> overhead in confidential computing and preemptable VMs, and integrates
> smoothly with existing kernel APIs.
> 
> === ARCHITECTURE
> 
> DMA_PMD was initially designed to address IOTLB thrashing (details in [1]),
> but turned out to also resolve nicely the strict IOMMU overhead, and avoid
> the bounce buffer overhead in preemptible VMs and Confidential Computing.
> 

I'm thinking if we can re-work the dma pools here to fit the needs of
DMA PMD. Apart from that my main concern is the isolation model. 
As implemented:

- dma_unmap_*() of a pooled buffer is a no-op, i.e. unmap doesn't happen
  till the page is retired.
- the whole 2M page is mapped IOMMU_READ | IOMMU_WRITE, regardless of
  the direction of the buffer that triggered the mapping
- the mapping stays in every domain that ever mapped any block of the
  page until the page is retired, which under steady traffic may be
  never
- the TX pools are per-CPU and shared by all sockets and devices.

So, a NIC ends up with long-lived RW access to other sockets' data in
the same 2M pages, including loopback payloads and kTLS SW plaintext
(both come from sk_page_frag), and a DMA after unmap no longer faults
but silently hits whoever owns the block next. For pooled memory this
is identity-like isolation and weaker than DMA-FQ, whose exposure is
bounded by the flush timeout. Thus, I'm not fully sure of the claim:
"security guarantees comparable to strict IOMMU". 

It also isn't opt-in: dma_is_pmd_phys() is checked for every device in
iommu_dma_map_phys(), thus, any device that is handed a pooled page gets
a window, including in domains where the admin asked for strict mode.
I think DMA_PMD has to be an explicit per-group default-domain policy,
like DMA-FQ: selectable through iommu_groups/N/type and/or a boot
option, off by default, decided when the default domain is set up and
recorded in the cookie and the map path can check it before doing any
pool lookup.

That is also the natural place to refuse untrusted devices. Today the
window path runs after the swiotlb decision in iommu_dma_map_phys(),
which for untrusted devices only bounces buffers that aren't
granule-aligned, so a page-aligned pooled block gives an
external-facing device a permanent RW 2M window over unrelated data.
iommu_get_default_domain_type() already forces strict DMA for such groups
DMA_PMD must not undo that.

I'm thinking If pooled memory is going to be shared across opt-in
devices anyway, would an explicit shared domain for opted-in devices
be cleaner?

It removes the per-domain machinery, but those devices then lose 
isolation from each other for all DMA, and the core would need to 
support a default domain shared across groups

Additionally, we should handle edge cases where the dma unmap (or it's
TLB flush) fails for some reason but the page is freed to buddy..

> It works by combining several known techniques:
> 
> - transparently feed allocators of device memory (skb_page_frag_refill(),
>   dma_alloc_attrs(), pagepool, ...) with DMA_PMD pages, i.e. physically
>   contiguous PMD_SIZE (2MB) pages mapped via PDE_SIZE IOMMU entries
> 
> - heavy recycling of DMA_PMD pages (like pagepool) and lazy IOMMU unmapping
>   (like DMA-FQ), BUT:
> 
> - like strict IOMMU (DMA), safely release memory back to the kernel only
>   after destroying all of its IOMMU mappings and a synchronous IOTLB flush
> 

That's one of the strict-mode properties that this series keeps and two
things undermine it today, dma_pmd_unmap_all() ignores the iommu_unmap()
retval after it has already cleared the per-domain bits (for fellow 
reviewers this is in patch 7). And window PTEs outlive driver unbind and
DMA ownership trasnfer because  dma_pmd_domain_release() only runs when
the cookie is freed, if a device is handed back from VFIO, it'll regain
access to live host pages and patch 13 additionally gives up page_pool's
destroy unmap of in-flight pafes.. The mappings need to go when the last
DMA API user of the domain goes away not only at domain free..

> - on allocation, DMA_PMD pages can be configured to be pinned in the host
>   (hence suitable for preemptible VMs) and/or unencrypted (hence suitable
>   for Confidential Computing), removing the need for bounce buffers
> 

In CoCo guests, dma_pmd.decrypt is swtiched on silently and applied to
every pool. inclusing the per-CPU skb_page_frag_refill pools that serve
every socket. Enabling tx_enable_dma_pmd thenmakes loopback payloads and
kTLS plaintext host readable & writable before encyrption. Similarly
decrypted Rx pages lose the private copythat swiotlb had making it
possible for the host to change packets after the stack has looked at
them.. Can we make it much more explicit to the Guest/ Guest user that
they're opting in to sharing their data with host for performance?

> - there are global and per-device optin /sys/device/.../dma_pmd_*
>   and /proc/sys/net/core/tx_enable_dma_pmd
> 

Bools with sysfs files on every device having a dma_mask doesn't seem
too nice.. the iommu policy belongs to the group's default domain..

> NIC drivers can typically use dma_pmd with no modifications for rings,
> tx buffers, rx buffers (if they use pagepool), and rx headers. For tx
> headers, almost all drivers need changes (see later patches in the series)
> to implement cheap bounce buffers and avoid individual 4K mappings.
> 
> The series has the following main components:
> 
> - a sparse array (similar to pageblock_flags) to quickly attach metadata
>   to a 2MB page without fiddling with the struct page. Cost is 128B per 2MB
>   page used as an IO buffer, totally negligible.
> 

IIUC, the entries are 256B and the array is sized from theoretical
phys_addr space rather that from memory: up to 8G of KVA on x86 4-level,
32G on arm64 with 48-bit PA and 512G 52-bit PA, where the chunk bitmap no
longer fits in kmalloc, failing the init. Init also populates metadata
for the entire RAM.. it'd be nice to size it from real memory ranges or
use an xarray or per-section array with lazy population..

> - dma_pmd_pool, a replacement for alloc_pages() that can be instantiated
>   per-CPU or per receive queue. It handles the split of PMD_SIZE pages
>   into order-N blocks, handles dma_map and unmap, and aggressively recycles
>   entries. It is used to feed skb_page_frag_refill(), pagepool, and
>   receive buffers for drivers that do not use pagepool.
>   See [2] for "WHY NOT PAGEPOOL FOR TX AND EVERYTHING"
> 

I am seeing that the recycles page blocks bypass KASAN/KMSAN poisoning,
page owner, alloc tagging and bad_page checks.. which might make a UAF
go undetected. We might have to use it or a similar technique to ensure
the UAF of a polled buffer remains safe in such a case.. IIRC,
kasan_mempool_(un)poison_pages are used for such cache (I'd let the mm
folks chime in on this). 

> - dma_pmd_arena, is another allocator backed by DMA_PMD pages and
>   is used exclusively as the backend for dma_alloc_attrs().
>   Used for longer-lived allocations (descriptor/completion rings,
>   rx and tx header buffers)
> 
> - glue code to hook DMA_PMD into pagepool [2], skb_page_frag_refill(),
>   dma_alloc_attrs(), dma_map/unmap...
> 

On the IOMMU side there are also a few structural limits:

- the domain registry has BITS_PER_LONG entries, and a decline is
  cached in the cookie forever. Default domains are per IOMMU group,
  often one per function (VFs included) on ACS-capable machines, and TX
  pages reach every NIC, so a limit of 64 is reachable, and which 
  devices get to pool would depend on probe order.
- the per-domain window is a multi-TB alloc_iova() carved on the first
  map, under a global IRQ-off lock, sized from iomem_resource.end and
  from whichever device in the group maps firstF
- I'm wondering it iova - base == PA (plus a fixed 16G offset), is safe? 
  As devices learn host physical addresses.

Can we consider giving each PMD page a dense slot number when it
enters a pool, and using iova = base + slot * 2M? That keeps the O(1)
map and the range-check unmap, shrinks the window to cap * 2M, works
with narrower masks and stops exposing PAs, and per-domain tracking of
mapped slots would lift the 64-domain limit as well. The window could
then be reserved in iommu_dma_init_domain() through a dma-iommu helper,
instead of handing the iova_domain to dma-pmd-map.c.

Thanks,
Praan
