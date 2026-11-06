Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990629;
	b=ukM6SoS62pYx5udOWln7Up1WIsEn4mK1uxrq7vxWM3OJKJPekQVKVk6mvYSw+B3wBYjD
	 lJwew54jvHxXMxU4mLwglBo542Vx1nFt8OkebkQbTUnSke18dChHCkkoywAkEPb8S2J8z
	 u9UmSZLrKb3315AAtG5NPmxlwxch1/lOoWGRozq7mxIZk7sHK8lxbd/I3sn71BJKcvLKm
	 sX+XG8XmsW8OuBoQHJoTbh6rRCRwmOa5mydo4pXrqLMM3h6MFpJluBxyjw5lQNCepqOdV
	 q4DPRYBDETJXw/vFikRv5N7XBQlQVt1xoE/cICaKFz26mimeheFGhKl2w313+2u7QVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=b7Y85ZMNTmnO5vyHoGmhNUdpyQ1xa3t2s3wZRjsJimY=;
	b=LdkkvGU51iuRraUNylkoedy+IRNEqgLYVZ2iYGPm0f5E8MCjCHiIR/UF91wlAgfYPRol
	 55FDtse/9CrxKufegKzlQANzdClKQF5wCbp7cMobMydcEI5o8OrNZn1Fp97+TQJUHeujF
	 N8+GArE/k1mhWf+vK+SIai66T2wa/qtGqMyMAYY1DW7ac4JhvCebku3WBWBK2HCkBIGLh
	 DXdDCV0rx387BF5Tqcb5U6V7gIJENphja3OnlPw4oPWpxL1aYPQEkoe/onLp4ErOqINKF
	 otFhxlqcjrOpKaNAgI6kcBrMmt+ddSBC7QkRv7zwuYM9Z0WhVqY0WyMUfzf+SQGLgug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HGDygtS8;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8934606A33A
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8934606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HGDygtS8
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5363c8de563so9472471cf.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793990628; x=1794595428; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b7Y85ZMNTmnO5vyHoGmhNUdpyQ1xa3t2s3wZRjsJimY=;
        b=HGDygtS8PIhtf9IE/TizOpDFPkRZ98JXWj8eT4E4Yhq2816KF4cYzaNMNDlA2GUJom
         EwHj/VjdIR7VABdV6Zp2h8871UlmV++e2EY9F4DXOFfJ8S6YfHRSeY1siEWlm6kSEjNb
         WHEVmvE5ym6L4Xbyfhx3R1pGRXcL6Aqfsxb7/Z41VHVoAGWgx2nMjVhtD/9r8VVZEHKV
         fuqENBryhstWSfUkfZL5E2WV6tyiKsE+RaCM7VtpgPf7m8u4rD/SWo3hkc3ArsoY50NQ
         hRIXBkTRQ/dwI/34PymqxrQamBJmjQo3jk08WmMbsEic9zfD+Rz8rL/et2s9wCBYJ+SE
         4TWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990628; x=1794595428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b7Y85ZMNTmnO5vyHoGmhNUdpyQ1xa3t2s3wZRjsJimY=;
        b=KvP/TCoAD+019wlfOzj/7x8Px6zEsHxmVZgQYAb3oT05yHcxkVi9VeNlX7BZlYEYiX
         qgHvN3+27rN8/SBop/5QOPVVl/+Tn54KNfMYh8uJki2ZczlXFtb8hDlq8gy/S3DIsINv
         2e+Toma642JqcmTagYLAsdGEstnts06xGckknYhTXv6GYX3/keMik/VM34H6R940Mkfa
         Ot2X5HKLBkQINDEowxLRaUp9Cb2eTPfpovJyi4eVpVSjVhtPzZLbt5LHXDdEWI6an3Pl
         p5rZ/oJGxwJ2Ic4RDt+PbMiGMpfIsHpHKLpDb/ozpCu6q2wM8Auix5jl/tubiLohrMK+
         s+JA==
X-Forwarded-Encrypted: i=1; AKwUvBwtpb2Wd24RY5plok355n1Uzr3htLbFrMUmzTrjP1IiCWSAMFvY7i0Q/QXzeLg0gWU4B3XD028=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hUTyI6kaqDFQ4I+ymT/9P7dl/G0eTbJJP3KByeLNTmcgsig9A
	MFesImfsZM0Q8l188yPAz74j0RXI+q5WuozfaK7IuJuyulNm/r4fPGOx7abE9zwHrEY=
X-Gm-Gg: AYBFou2pVS6Qxdny2DsaPcIao3AHdeRVvW5Z3oIVbz+rFKumtc80yQ9oHQtFOaNeW2o
	Pzmq5VKCtW2k2JFolLG7L3hKttaxeXyQM5NnmNGMOG+rSRxxFC0x62XXPcq6l+MnudDokz/tNOq
	7XXkAslEOiIENSL8nB1mh6nNfNdrm+q2yiH+tr14SVe+xSM1/GteMCYPtWcl4/BsdIcliOc0YB9
	eOtOpjlAri6eaRP4zi54Pj4QLV4vFgnfUVRNeluyjYJ41suttVvpc404eO0RmctZtVrGwoxWCot
	HoBlEiivXFPPTB/8i/wxm8JjtgNh5FYITJpPA00N0xY1Iyfvhu2fEIycltQu6PgI8yu2AngZn+S
	XvSVPEX1BV9/+O57YqvlKCsRWrl6gkO3J7A+Sr1zOc46hhqum2y/pdvbrm3AmYK1zhD/rb4HpAG
	r6VcP7/WdkN3TwyNz5oNKMblAo1vmYM568ElHEiNSJ3QuMt1uNfRrvBb/qQRkzvloshPx/De7MD
	sRmYoV/tXJtjb7mFzHdAnq7ijblBkOXKum46SVFdnRqWFqGK0cabGQ+a9JhrUp8fBjRnrNyPVW6
	8iq+8b/5ezujk3T8hJAdTuii5+mKrKfq75S+bRVWE+M2M85uD5GFULce7wGB9aK/IYAlndQSHt0
	7iU6qbKbpHQ==
X-Received: by 2002:a05:622a:47cd:b0:536:764e:1527 with SMTP id d75a77b69052e-54e14a6c486mr53004081cf.44.1793990627606;
        Fri, 06 Nov 2026 10:43:47 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e25785f14sm26823821cf.5.2026.11.06.10.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:43:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPOug-00000007JdL-0xGY;
	Fri, 06 Nov 2026 14:43:46 -0400
Date: Fri, 6 Nov 2026 14:43:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Naman Gulati <namangulati@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Luigi Rizzo <lrizzo@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20261106184346.GJ663069@ziepe.ca>
References: <20261023140107.GC3977851@ziepe.ca>
 <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca>
 <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca>
 <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca>
 <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
 <20261106180714.GI663069@ziepe.ca>
 <CAMP57yW6Y4g-xM9YTB+MpgxPN7RFeEWhAPWvqrfOoMDEuL8HZA@mail.gmail.com>
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
In-Reply-To: <CAMP57yW6Y4g-xM9YTB+MpgxPN7RFeEWhAPWvqrfOoMDEuL8HZA@mail.gmail.com>

On Fri, Nov 06, 2026 at 10:17:38AM -0800, Naman Gulati wrote:
> On Fri, Nov 6, 2026 at 10:07 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Nov 06, 2026 at 10:00:35AM -0800, Naman Gulati wrote:
> > > On Fri, Nov 6, 2026 at 9:31 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> > > > > I drafted an implementation [1] for premapped TX and RX buffers on top
> > > > > of the existing networking page_pool. It is implemented entirely in
> > > > > the networking layer and extends page_pool as the default RX
> > > > > allocator, to the TX path. There are no hooks in the IOMMU, DMA or
> > > > > page allocator code. I wanted to understand if this implementation
> > > > > correctly captured the feedback on this thread. Key components of this
> > > > > design:
> > > > >
> > > > > - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but each
> > > > > chunk is mapped once per opted-in device through the DMA API and
> > > > > records its IOVA for each device, rather than using a shared IOVA
> > > > > window.
> > > > >
> > > > > - TX: page_pool accepts a memory provider for pools that are not bound
> > > > > to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunks
> > > > > of their NUMA node; TCP copies sendmsg() data into them through the
> > > > > task page_frag and allocates its skb heads from them.
> > > > >
> > > > > - RX: an instance of the same memory provider, sharing the chunk code,
> > > > > backs RX queue page_pools. RX chunks of order-0 pages belong to one
> > > > > device and NUMA node, and are shared by that device's queues on the
> > > > > node.
> > > > >
> > > > > [1] https://github.com/torvalds/linux/compare/master...NamanGulati:linux:netdev_dma_pool
> > > >
> > > > IMHO the netstack should never read from shared/decrypted memory. If
> > > > you put it in a SKB you have to be sure the only touch after that
> > > > point will be a DMA read from an untrusted device on the TX side
> > > > (sending it to a trusted device would be a fail) and the final copy to
> > > > userspace on the RX side.
> > >
> > > That's likely a fair callout. TBH I'm not very familiar with CoCo and
> > > will spend some time understanding the constraints. I kept CoCo out of
> > > my implementation as I approached this solution from the overcommitted
> > > VM problem where we are trying to overcommit memory in VMs and use
> > > these pre-mapped pages to avoid using bounce buffers.
> >
> > Why does overcomitted VM use bounce buffers? Do you mean this is
> > about getting better memory clustering in page pool since the VM
> > paging granule is 2M?
> 
> Not exactly, we are trying to use VFIO passthrough NICs in
> overcommitted VMs. Since the guest memory is overcommitted we can't
> dma-map the entire guest address space (as non-overcommitted VMs do).

?? I understood you could and this was implemented under the
virtio-iommu by pinning the memory under active DMA?

Where in upstream does the DMA API force bounce buffering for this
case?

> So overcommitted VMs can use bounce buffers to have a set of
> pre-mapped buffers to bounce traffic in and out. We're trying to use
> this solution to map pages dynamically with virtio-iommu and recycle
> them via page-pool to avoid traps on each TX/RX and avoid the copy
> cost of bounce buffers.
> 
> This problem extends to generally reducing IOMMU overhead in
> networking - taking the dma map/unmap cost out of the hot-path and
> avoiding IOTLB thrashing.

Sure, that makes sense, but just having a pool of entirely normal
pre-dma-mapped memory is quite a different problem from what launched
this thread...

Jason
