Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793992308;
	b=htv1xZlsQqGhBElX7TB7VKoGo2BUogzAAzfgxTmtonX9iDxW1IhAF8hSbSIPNIlmEH69
	 1uATpP/L7aUNQL6NnM4/RjpEps4Bei0E81sIABTZo0c5yP5ceBNQ3RlaXhuDqYAVA1145
	 sq/+i6Z5hxeGMlRluJaAbLzRKObeTzFewC7/udIaY8xi94zFmiE2ksgyi1Yg492syW/wp
	 lsONvb65boL8eaQ39E2m57wgFmuALiMaGdYzhWzK18ooiDmEnQO+XT5qUMxqCUGNzi/Hh
	 Rja72F2YF/wzlsZ9ds+I+E+76GBgD2rN8EL43xZVNS7Atx41WPuzd7QU1EXTO/12rmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=h2A6aCl8kyfujglJb3VkwVgvWA7M4CaDd0+96AnNPHA=;
	b=kRzEcuqg4i1kEQw9mrSGd97uqHYRzb5NkrYdFCWnU3fHrRxzxcBOpqNhhDu15rwuwYaT
	 /u885G/gTzw1LO7dvURvzra+hva/MJh4sSa2dL2XG6zUHZWy+dajKcj9wVuLhFB2ykU6i
	 ateM1jZGCB5uJG/3pEUpqZzBsw947sK7P0zOLMg0RRQ3LF20J7v9hAIytmrkdOGuoXSCN
	 5LxRrCa65Or14p1mRm1wa22K4aZ6e1nlwxhyL/u/nQRQItl8SpGGW4RT1oYl9ohQtwK4Y
	 iXfeqwgx0aViyMif69tg+OWDbSKkoRY2kLhvIZEurTANCu9ekwUFfd45je4llLlFO4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cW3STcxX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AA606A338
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B19AA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cW3STcxX
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5383c97c8cfso43451cf.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:11:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793992307; cv=none;
        d=google.com; s=arc-20260327;
        b=s5Uwe7MuXiHvPz8sX/TzUhZAfnA3E0KFZMF/nRwFBma/Zn7TbWwxeN6Xwno/lrocSX
         4qmmUDM+E85xa7C6kxt4KouBpY5PQ9nYOHvJ1sof7IlV7H1mBpF/k6SggFdaqNSnwhU7
         GnV+PDFSzThXMo9N3RkLin0kwDrxr9acgozlAT0NhrJrfGYj4Klx+h1ZnAEUnV96ZSBk
         dRhpMH6EcFyBDGufmPJLzyLONppdCuBsGS2bm7fXdxzTh8K2YUY4AncQU8IwiuDCTlvz
         4tNuTgRvWpNP2s32rj7NCjcsPrP+NUDzkY2wALVHvDojvCEtjVG69+YN2FAOxvYcJ3Qg
         hxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h2A6aCl8kyfujglJb3VkwVgvWA7M4CaDd0+96AnNPHA=;
        fh=sxSH35HRM3c9a4W6FhV103e3W0J3vljmPQ/9bXPfig0=;
        b=kgTbZkSr51U8bNEOtPIiysKNXMYoIAlCDITw9qXTUmJH+XkNrdEa7e3Rw7YS5Oio9t
         0Bg/MxrmTCDghIKpAyra4oFGCVIJPVXL+nJ64+DvuCz+V1KbjfIYN6eh/Dj+xkiVLG5J
         NPLsxGbwlTT/8T1rldvNGEF+TPlvS5le9L37tx+cHVCq2S1lG7NfWxSiaesuE+rHpkDl
         QYkgMoaxlloc9OFagOJn0qKch8mewquRcLAZugRgcgVy1gXjlM5kWbWhjiDRKdIPvQn8
         i6klR0cvERhBsEGKozPABwwiTWWswk52OUD+ag72ZjZ/19i73lOdRJnqwRRpngMpA+eV
         YA5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793992307; x=1794597107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h2A6aCl8kyfujglJb3VkwVgvWA7M4CaDd0+96AnNPHA=;
        b=cW3STcxXnYNSuqGRn+QlFzxd7OWsmJ4iP0YchaBVX+Fn90tmwSR9Ig+htbKTNPlwbe
         zDR4nv0Zln0XJD2lbe77KotnoteJPOBQ1XVLQAl4512CVsnszBKeqCPb/Gp9EeA2omuI
         H4o1VOfWNsQh1UweHWUVw35Wz6UWQRrylIEQNIkd+oPedbQCacpfWc1Khb2NcioZz3Ta
         ftwLwOl2M8sCGrs9ydOPBv/Fa5aDq8gbbm5/OMkB8z1ctC0bNmB/Z3wDbTJ2NsAB0iAT
         XlmaA+0wbc6gtMIvNJs8VwHmiMuBZhJb31taEkBA+5N7r42oF0ehn5aNyfneUn9ttDb/
         +JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992307; x=1794597107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2A6aCl8kyfujglJb3VkwVgvWA7M4CaDd0+96AnNPHA=;
        b=kpwnpwo+Z57ZKVrjmjnYRqgUXMknvVeA/owXkqiZ/WiByL7jkMGgsMso5CIj3zTmZM
         zXytWp3oD5hKegK0hR0+NOmYhLdFS0lQm+MY30h9C8+JEp84iVzC1n7Gtv6TPyyUGGCp
         iJIpxXds/ZpCPuPi2U4sVQmySgV0KAC+0psrHK/UUymo4xfMQkjuYex6mJ6UUgGhp3X1
         DkBdVKMHtCYytsYriAY3kDtm2CSlmu5ksS6DzcX5/wSgz87RkxsZ2/F+bm/o1nLTxZcR
         s8vO+v5q+pRYuLZs12BDEQMvP/UWs5FxfUtWNf97cBNngR6a6R9MYQGSRNLT7QRgxk0E
         JKeg==
X-Forwarded-Encrypted: i=1; AKwUvBzeOeaqFl7Gir5f4kQWBizn4DttSuPOg6u4AQl52FTDNoKReEO7tyMI6K2iUQXYe6sEsZfgGxc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ksTPNKjQ7UrAns3n7mPPijYT2MOtFfBgc8o5+pksl9mWljR12
	2SGO5ewZyW6/Dg/uIEzki2IXnAID1CE7BUmNa6YmynfWOLY31O5FE1d0O+6cklG5N0X9xpx74pB
	c5I3RekRvkio7S3cjqNArRzdiCFJ5++M5DNFVVAie
X-Gm-Gg: AYBFou24QSv6A0+32qZcKRkp5Ll6G/HIOYEYKDfUiiKPOmcEgodX2iuNDcr0DjCTyfD
	Yl46+wkWc3mBy1eEBxWFim2VvoExrzxpAZiJ1fkT+nFQa0v/IdPrRFrsEWoE24AgoNpKv+tAIZG
	dY8ruGJK9eWHBvyVQFhXG7wxf5Wu8R4INpkEI4s7L+AMb93klhSpo4UeQIBOBM4ka29QyxpkDNB
	s7UBdZksuoAEYaT1u0PnjFppVu3I2WXV0t+DCfAW7+2kfgP2oktyqzu8K3yc5Xz0yS4yWd6MNQw
	o/FHpqsgzY5/r7Kvw8XDiHJ5TSb+ulh7OVNO278C3RPu+FxSF17dtajLdWT1BlUegiIloaNDZxL
	aC5DUZWCvEa92PGRKCLVzMuiYLSwehxc8XVqW2okTEowhuCzT2MsSMhR98wBUsC3UHh3CyA==
X-Received: by 2002:a05:622a:2297:b0:532:eff9:ca08 with SMTP id
 d75a77b69052e-54f82d870e1mr1932401cf.12.1793992305834; Fri, 06 Nov 2026
 11:11:45 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca> <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca> <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
 <20261106180714.GI663069@ziepe.ca> <CAMP57yW6Y4g-xM9YTB+MpgxPN7RFeEWhAPWvqrfOoMDEuL8HZA@mail.gmail.com>
 <20261106184346.GJ663069@ziepe.ca>
In-Reply-To: <20261106184346.GJ663069@ziepe.ca>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 6 Nov 2026 11:11:28 -0800
X-Gm-Features: AclHuK9JPUckmOeUyc8sSIbL-A7oi1CB3RcBM1vHWdycPuPf0ms-UPAYg2zqwxM
Message-ID: <CAMP57yU7RoWXkvOfx3ksX8kaO+0h8WPefpjnY2DH9WR_TYGJog@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Luigi Rizzo <lrizzo@google.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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

On Fri, Nov 6, 2026 at 10:43=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Nov 06, 2026 at 10:17:38AM -0800, Naman Gulati wrote:
> > On Fri, Nov 6, 2026 at 10:07=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Fri, Nov 06, 2026 at 10:00:35AM -0800, Naman Gulati wrote:
> > > > On Fri, Nov 6, 2026 at 9:31=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.c=
a> wrote:
> > > > >
> > > > > On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> > > > > > I drafted an implementation [1] for premapped TX and RX buffers=
 on top
> > > > > > of the existing networking page_pool. It is implemented entirel=
y in
> > > > > > the networking layer and extends page_pool as the default RX
> > > > > > allocator, to the TX path. There are no hooks in the IOMMU, DMA=
 or
> > > > > > page allocator code. I wanted to understand if this implementat=
ion
> > > > > > correctly captured the feedback on this thread. Key components =
of this
> > > > > > design:
> > > > > >
> > > > > > - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, b=
ut each
> > > > > > chunk is mapped once per opted-in device through the DMA API an=
d
> > > > > > records its IOVA for each device, rather than using a shared IO=
VA
> > > > > > window.
> > > > > >
> > > > > > - TX: page_pool accepts a memory provider for pools that are no=
t bound
> > > > > > to an RX queue. Per-CPU page_pools take 32 KiB pages from the c=
hunks
> > > > > > of their NUMA node; TCP copies sendmsg() data into them through=
 the
> > > > > > task page_frag and allocates its skb heads from them.
> > > > > >
> > > > > > - RX: an instance of the same memory provider, sharing the chun=
k code,
> > > > > > backs RX queue page_pools. RX chunks of order-0 pages belong to=
 one
> > > > > > device and NUMA node, and are shared by that device's queues on=
 the
> > > > > > node.
> > > > > >
> > > > > > [1] https://github.com/torvalds/linux/compare/master...NamanGul=
ati:linux:netdev_dma_pool
> > > > >
> > > > > IMHO the netstack should never read from shared/decrypted memory.=
 If
> > > > > you put it in a SKB you have to be sure the only touch after that
> > > > > point will be a DMA read from an untrusted device on the TX side
> > > > > (sending it to a trusted device would be a fail) and the final co=
py to
> > > > > userspace on the RX side.
> > > >
> > > > That's likely a fair callout. TBH I'm not very familiar with CoCo a=
nd
> > > > will spend some time understanding the constraints. I kept CoCo out=
 of
> > > > my implementation as I approached this solution from the overcommit=
ted
> > > > VM problem where we are trying to overcommit memory in VMs and use
> > > > these pre-mapped pages to avoid using bounce buffers.
> > >
> > > Why does overcomitted VM use bounce buffers? Do you mean this is
> > > about getting better memory clustering in page pool since the VM
> > > paging granule is 2M?
> >
> > Not exactly, we are trying to use VFIO passthrough NICs in
> > overcommitted VMs. Since the guest memory is overcommitted we can't
> > dma-map the entire guest address space (as non-overcommitted VMs do).
>
> ?? I understood you could and this was implemented under the
> virtio-iommu by pinning the memory under active DMA?
>
> Where in upstream does the DMA API force bounce buffering for this
> case?

Sorry, should have been clearer: the DMA API does not enforce this,
bounce buffering is typically implemented by the drivers in this case.
Such as QPL mode in the GVE driver.

>
> > So overcommitted VMs can use bounce buffers to have a set of
> > pre-mapped buffers to bounce traffic in and out. We're trying to use
> > this solution to map pages dynamically with virtio-iommu and recycle
> > them via page-pool to avoid traps on each TX/RX and avoid the copy
> > cost of bounce buffers.
> >
> > This problem extends to generally reducing IOMMU overhead in
> > networking - taking the dma map/unmap cost out of the hot-path and
> > avoiding IOTLB thrashing.
>
> Sure, that makes sense, but just having a pool of entirely normal
> pre-dma-mapped memory is quite a different problem from what launched
> this thread...
>
> Jason
