Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764070;
	b=WO7BwMIy6KIwObzt1/cop1It/RzXXdnYr0sxw5WRY1j8BU9367299hL+IQ9jXVKYCSSp
	 cyUeptZZzBjWdBfovlOxhgm6VQbblkH8wydqapc1ys+/ujyl9v9tpWbCG8mwfhLI20DYb
	 aUY5E4x7SZWBfmQlnC2Kz4zimcIVVzQw2Qw+s99IWXVJltfl+W0peKGW6VzSmf9KU1mbt
	 oZaDwXu9hj5ALApl01f//aOUx5yOs+8lDhLjSheTTKu3LpvnJsVQIco5wYvu27s02D9Pd
	 L+BTHl6c2NGcmBcadgmMiGynCODazmIg5igC0NnNQqlnELqVhXzpOrLc4ZF+cuRzdkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=EtyMFPm1AoXY1rEO0WfbSM6JxPHkULRdHaFEkgfjDaI=;
	b=t0PQ11jh9uxl8o6p5+1Av5f/B9LnFfwJoH2c0VaXU0+zZwRLbkk/CljZOTlA6SZobqJM
	 j/78jxjfzPP+0guD41HxrSYM9dMYNy6iPUxEglrVyoLMWCIF+vCM0pEBY7X0Hfud2WURr
	 O7Iyi2Y1pn2eVqQ9KhYNiAzC4gZcP4yLNpKXCTMcVmKaXfyqhyjMMVUJ+P0yFPPpTnzo1
	 qC7CiGOSPOKj6i0/Ka++nDjdDWcxRx1Skvl0kd3Q9IRKYqcOsKWD+TO2XeBFK9HoL8Gym
	 w4taEvjDRNqyCV0DE/3EKka8MxsSbf6u0MLxIT8A8PL6PJgWPswD7Jf9wm6MEENYqEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mzYjbkFo;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BAD606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3BAD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mzYjbkFo
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53669f7b518so8415091cf.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792764069; x=1793368869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EtyMFPm1AoXY1rEO0WfbSM6JxPHkULRdHaFEkgfjDaI=;
        b=mzYjbkFoH6r724WPm/kXQ6ge9X2YwG+qpFuc3lHImh22xtkYstDlgLGCF6igOVXyVH
         igWBmzjfAxtgNqw7ITiDKdBPm9Zxia+0AYM1O3ZhFJmYUwndaMHSXQmNlRdF7FOVl428
         N1nli7/p93pndNCjRa5x/azr5xBOWCZN8cCLpO/JC4aybvA9bDWRpITOSpyfU7QlPmOE
         SW1f7jhj+6LdNxEekfmdyjtM3NvHFQ3PQJ+/uvufZVJaHBqRj6+IgEPV8rJKj6fBE1mC
         MTT2PunYI9fAUEUg6ljDDMNi8/AOycgUwdW5mdjtisMa2XstIjgSEtZajFKxMFDHZ5vc
         VtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764069; x=1793368869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EtyMFPm1AoXY1rEO0WfbSM6JxPHkULRdHaFEkgfjDaI=;
        b=yl8RUVlHpzMrtapJ1laXE12eWkZT3YnAmKYlM6RrmRojg51lX9uBWQqrVIYa+/BfmE
         8ErtAMYFkA2OpqeDVpqkfJWiX0dh2fJyvdGh0QI8dS7MAK7N12xVT4qHzJ0C2y/pTy7h
         kH7h5jcW/RAS+U9wvMZ3M/4o3CChbjRa/38y+vQP0BLuuIpvYj+J8Fw2QcUGpIVRbbaF
         Z4U71mzGQ9LpHQ1tBEJ6Hxxkj1HljZRvizV4G8wANz6CflC4Otw9oMWPOR5PPGP6Hohy
         afluVdkHoHZub8qNSlcAk2V5SAodSt3MCnmD2TmQsEgHnar3qTGap1ivSS1CirBlJanH
         X87Q==
X-Forwarded-Encrypted: i=1; AKwUvBw3Q9RFHue1ljSnlSqwrmxu9a0npVDTr3T9UQN3IriKB3YxrauLlK/uB6ILoMtIrpHt5ZYhKY0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFS7rXgytucvNHMrBoX2ULH241+txki+w/IDsQQh03zWagjK2+
	4CNvZPy3LtPM59vzalaIMCt/A/rJIQsQoDO46rzptj0CYYsyv4TPqN5aza93S81BmpE=
X-Gm-Gg: AYBFou1P/hu2BreAh4ett7zeZFMp53KQQDd7N5ch1O79uXUIO8UhHS7qstksV6pzLDR
	ll5xBTIjUSZYTN3AU2V9JqqQriiPvmTESfT3/mNt40luA0dQLJhhs4+0/9sHgxz1wKuXaymNKr/
	lYYP+YFV6hZlUUzF1L92xHbEqVIm3KKIDRUPrR9r4QXTyYfLMza0eeJbqiEIRaOhsXihkrvo0Sy
	SAnTq9l5CzEmsyT02nzN8FCiSSdYqhh0Mjhg02ic0NtH2rQ1qGV7ERsOEz/BbRda4q5xs77HqnE
	nyJ4EA5ypmoqU1J4ScWwSFeGcty5YgkpZixusDqnvEGkdSL4OsqN/5+J47Hej472d+xPOPUS8Wf
	+2ObvrnOZ0gQ0YfcSgg9O3Gw81gaO7K2w2zpWbs1HcXRQ/ZrEfG8BWtk5h/o/x3wnKGbmbo5UoC
	ial9EAWlpYqqY9q+YYA9UeQG2qKynehUgva0a4a9cydln3aG6VRQLlkZwkcBRBpmnJy2hmO1OqP
	4TCgGx+gv8iyKZ1I0Rfkk93Vv7NpCZX7hgZLfLdoARWp1L+T6HtJnzPOfBoC5lztLPBs3nTYyrR
	AXBJzgGP2CYZhvuljjxdyzb8KofFE+0C+NC3ug==
X-Received: by 2002:a05:622a:4d88:b0:535:92a6:22ec with SMTP id d75a77b69052e-536c263076fmr30716841cf.29.1792764068500;
        Fri, 23 Oct 2026 07:01:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940479fc830sm24750685a.21.2026.10.23.07.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:01:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKFpT-0000000Ghww-1SWZ;
	Fri, 23 Oct 2026 11:01:07 -0300
Date: Fri, 23 Oct 2026 11:01:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Luigi Rizzo <lrizzo@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
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
Message-ID: <20261023140107.GC3977851@ziepe.ca>
References: <20261003212241.3432303-1-lrizzo@google.com>
 <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca>
 <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>

On Thu, Oct 22, 2026 at 11:51:40PM +0200, Luigi Rizzo wrote:
> On Thu, Oct 22, 2026 at 10:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sat, Oct 17, 2026 at 07:11:28PM +0200, Luigi Rizzo wrote:
> > > > We should probably just find a way to describe that this is a POOL that focuses
> > > > on physical contiguity in some configured granularity.
> > >
> > > Before embarking in a global renaming, I would like to get opinions on
> > > acceptable alternative names (possibly with a short prefix usable for
> > > identifiers in the code). I could think of the following
> > >
> > > DMA_PMAP (for PreMapped or Persistent Mapped)
> > > or, ahemm...
> > > DMA_PISA (Pooled IOMMU Superpage Allocator)
> > > both using dmap_ for internal name prefixes
> >
> > Can someone explain what outside netdev would use this? And why you
> > couldn't do this in the netdev page pool?
> 
> I can try.
> 
> Regarding users, the next target is disks (not included in this series)

Disks don't use a memory pool, they do IO to folios allocated by the
page cache.

The only other candiates I know of besides page pool would be the
existing dma pool users. I don't think they are so performance
sensitive as netdev.

IOW I think this entire series is only useful to netdev.

> > It is not a common workload to have the DMA allocator be the one that
> > allocates the memory. Usually we are DMA'ing from memory that was
> > allocated someplace else.
> 
> Aside from the fact that dma_alloc_attr()/dma_alloc_coherent()
> does memory allocation + iova allocation/mapping,
> this is not what happens here.
> Maybe the confusion comes from one function name
> (dma_map_alloc_pages()), but it doesn't map any thing.

> My code (in this version, and more in the upcoming release)
> mainly implements a specialized memory allocator with an
> API equivalent to alloc_pages() and variants, but ensures that
> the order-N blocks come from contiguous 2MB blocks reserved on the fly.
> 
> The physical addresses of these blocks are recognized by the
> "dma allocator" (I suppose you meant the entity that allocates the IOVA range)
> so that it can apply specialized IOMMU mappings backed by 2MB IOMMU leaves.

Why? This seems completely divergent from how anything else works in
DMA mapping, and I don't see a reason for it to be anything like
this. Other than it makes page pool work a bit easier

Frankly this looks like you had AI to transpose a bunch netdev page
pool into iommu.

> Note that just feeding the pagepool with 2MB pages is not efficient because
> the fragmentation in pagepool is done with a bump
> allocator, so recycling blocks from a 2MB page is difficult
> (it has to wait until all 512 blocks to become idle). My code
> has a bitmap to track usage, so it naturally recycles at the block level.

It doesn't seem like this little issue should motivate all this
 
> Then there is the transmit path.
> 
> For skb heads, one simple solution is to use tx head bounce buffers
> some of the patches in the series show that option (the next version
> implements a proper tx-copybreak).

> Otherwise we need to populate skb heads with pre-mapped
> memory. In the next version I have a simple modification to
> the slub code to accept an opt-in alternative to alloc_pages().
> I considered using the pagepool, but the changes would be
> similar and the layering seemed really odd, with a cache on top
> of a cache.

With AI there is no limit to the layering violations one can make :(

> For transmit, there is a bit of impedance mismatch as well:
> skb_page_frag_refill() does not know which device
> we want to use (in fact, it is a per-task so there may be
> many netdevs used by a task). We could tweak the pagepool
> to be device-agnostic, but that would be a bit more
> intrusive (more architecturally than in terms of code);
> also we need to make sure dma_map() on those pages does the right thing
> without trying to map/unmap the individual 4K fragments,
> and we need to make sure the skb_free() etc does
> not leak those pages into free_pages().

This is all a page pool problem, has nothing to do with iommu or the
common dma layer.

You can already get optimally mapped 2M IOVA and memory out of the
APIs we have. I can see no justification for the intrustive mess under
this beyond it makes netdev page pool easier to hack on top.

Every thing you listed boils down to 'netdev page pool work the way I
want'

Jason
