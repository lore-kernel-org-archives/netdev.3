Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793989074;
	b=RIGFbYepWJ6P3qdTB7lIRr/Qe9KqZrtIB9YiDVHMp9hx/523KzXT2URYT/q15Ke4umYa
	 WRDcgT1uu3X5W5N8RMEPF2g37svDTDBF85UOSik4TRX4auIK75IKYLjGdxpWdrVQyPxRl
	 QQhp1A69sE4UEi3PpL/Y3D+XutFM2DG1ACLNxFLuM4rmmnkn0Dn+ZrMtYAy3MyYuaffnZ
	 t3+qSigWCOU/Vsa9l0nDhce92C2RD9I8HKqUqU6dgoLt+aV6TnUlvyoPKRAEVc4WYLT9S
	 UDksg/eAXxxeU19D+CA1Mmrx5Ve9RD+MUeYn0QzwGmVkH2Lm1gY6nLS/D8EvLsQbvhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BvW3kJ042sHlnHfK0H238m7dXO47goeCrBgoSLkn/eI=;
	b=ef57dxsHmd79IOk9AFrpjVSo8rxkLR35oQdRmzF09E/9/Dk77hfE1lJylEVHN6M7o8uS
	 TPgJ3rQ9cPIW/SXGGOz9SAlj6Jb2jfAsx894hNPBUFeB0/8jO4CwtP7X0iLiNApGt8CNQ
	 JR0iRuDSKGblQACDUhYAIt3Gcc/VMaZp8dFxXKFznLEZ8RC++1wr07tdZR4863NPHGo/K
	 ej/+UqrKQGlpE19AWRHURG7qg4wlJbp/MVnpY4P6Qc1K/xRoyrfAyY+c5b6q8bdl2kC7S
	 kLKwqOSnLYimxSonG/PSEcuaBb4Y7sxGsLAhRGyVIBdDfNy+Y4QgUmyvR+gC6l1E3mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d9MH+D5n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8A606A33A
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF8A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d9MH+D5n
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so4255e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:17:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793989072; cv=none;
        d=google.com; s=arc-20260327;
        b=plwJKUmrrDbPrxJlxjItBvSR9tlpkopaR8gNoBTtokUtQ4TO2K6YAfQcBYgOT1BvwL
         QaR0XsqmJaLLdH4d5q5zTNK61QgcPkeduNSB6FJ7L3K4iOQsCvjVAyJpujy8Q0K6GxtI
         CEFR/Dp91LfSmLp0riL3phX6JBbi3tEUqNmQvkwePIZJDwxoCQRw6ocVfnip+Ei44nfJ
         88L++YjDmONsAHWXzd737Q9lMoW6sPAfmY3w31DVTEKRirORNzs4IN8SesAzxto+6Bsv
         v5cgHW08n7NAGU5v8madIEVHPlC7swsas8rGAo93HkSKaAAU98ylqmyD+VFf8qFCvtAU
         P9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BvW3kJ042sHlnHfK0H238m7dXO47goeCrBgoSLkn/eI=;
        fh=tILiUJUdEkpQBpf4no9m3T+2CELQ1s79pO8n+b4Kgyc=;
        b=nyVFTO82Oc9FXmVyVAvRItAqu0WqvIGedZiN8X37vvRzxlu1IBnI0eV1TEkUuPPbUF
         +8ohpWuDC1mCQ+Us5fYViUfUPyGc8TfO5lfCsX5d7I7cpRSuHL+K09UEHIRRLEwGcWyz
         xd5w6UIoVX0qQm3a8fC7E3fkiSZ58WrNtjIQrH8DKUdwiAghYvIIeN5Vq9Qn3cYOKx4Q
         nY0HpJzo4p9mAIhefSWNQ8ZIKisALfPUGItmOmRfFwaJGONtU4dAT5ZAq/wcvd1P/vkG
         vITyJhHZ7sYFY0fHzeBgBNkqLn6Zg5MeuQvuR+TcwWEd8jzD17PkfPGAkfeeNH5MJt5b
         yzuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793989072; x=1794593872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BvW3kJ042sHlnHfK0H238m7dXO47goeCrBgoSLkn/eI=;
        b=d9MH+D5nZDkkiyCBzZzBx2foYpYJwwmMY5qrYGec0Mx05ts1t8mj5HIZRVV1P3OfUl
         3ZR/GgMz6+7QaBC7goZtDvlsqEcLWgnZr7F2aN6ndUtt8k6ynWLMYCQfjNTYSMchQYWD
         rva24rhSDlMJ3IbwJA4HMX328yWPkco2ESyjfQTgFWSWw/Aivk606yHi1lvoCEC65j5n
         FHSP2Dj3L+UpRkq9asbf+YBHHKsZUVNTnJeNeRfbKGVBZD88jsMPHNZG3oJ+/kfKlhHO
         bRQn6G5Hn9Y9ktTxu4quX8bTVOs9pyyXmSPHrlYrXWv53j5pst5Y8OLoZPp3ycpZfjQE
         KlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989072; x=1794593872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BvW3kJ042sHlnHfK0H238m7dXO47goeCrBgoSLkn/eI=;
        b=Xg42/xWRzofP2xxYUNRzYiogPT7W5lv1z7zr6CObzFi1/4O+vJOBgaDjosUWRi1jsr
         bxEA97394hUhTmprWIhMnkXfJcJRDjqpHqkl++lghkJeDzMvii6L3L8rXyenOYLLTCrB
         GDAqSKaJ+wn000dqEfVhHwwHpORC7otAlnxJpfaocNuH8nSPRZRzJk2hro6o2PATB5AO
         6uMYELh/931HvSttGEoQzR1wFKBxfY4yx0CcadUy8Fr+hrltS96jUB2vq+qMVbZ+Hh6+
         s/rvhVJhtEUstZBtIV6onLm9eEOmVBOd/ff1XFJiWlOypA9QAMRWpOgaAdCb8Kd2Goz/
         UkzA==
X-Forwarded-Encrypted: i=1; AKwUvBwhPH0taOsQ7+Tx/NriDtRq7pXkDWiJ3B6TV+3DqaUQn1w/URCmqeLpJTBA1jluIl/4in34Qyg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/s5XGCaeyjFz7OPOsSlb1U/MWOerZZ7i71/c//wGgVOe/WKaaA
	FZCVog3QdHOgNig5JVJe1IVmRUnS1wUz8yiP4znMtCHBvZJYPpnfhcqfmwkMXfzzYlwe9csg1w8
	Jwl+Prkwiw3DWS7Mbg9AGYvzVDgnQTo66SuH8RIfo
X-Gm-Gg: AYBFou2RxG5VFFlIgbZaHICASYTIMz2KPc8dfZmNkdMwRkMIFozvGdAOJhCvsE+8SCA
	SgiikEgZb/htC89fLMmJnq9ON3f70GkcLRAPZoK6wmCBbpzTF73ZewGUppNBNMOMHgJGG/1UuGp
	FjXGX1MTpw5IrOZ00A6e5PznRehku8G0N0euc8oXmVTGW/q1ImNjgfpUADbKfeItR8VREouBZg4
	51d8oZFBmb1v5Ung4CiB01hDpzN0M/Hk2M+PKmCebstH0bg0jjEfZ5qdr5mdzaELYq5ZleFVtcY
	VvmObu9gBHRWMs60J9sZ8vcSzFO/DE8zazmBUiJSOxGIMTatd/IlgKVuy8bxwEoOWH1slEDehRt
	WemIpwWGaUt9mCE1jLdMd3XiPpPEzzhs9ocOIqsMcoc7ihn8dQeGxFM3Tx2CVWXsUtPcZ9A==
X-Received: by 2002:a05:600c:8b12:b0:4b6:24ca:8848 with SMTP id
 5b1f17b1804b1-4b78a30d377mr98115e9.11.1793989071681; Fri, 06 Nov 2026
 10:17:51 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca> <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca> <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
 <20261106180714.GI663069@ziepe.ca>
In-Reply-To: <20261106180714.GI663069@ziepe.ca>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 6 Nov 2026 10:17:38 -0800
X-Gm-Features: AclHuK-83DU2Twv76ErkJhEGQxs5tivwJ4EGd2AJl7A0D8r5G3Ha6ydUc43L3ns
Message-ID: <CAMP57yW6Y4g-xM9YTB+MpgxPN7RFeEWhAPWvqrfOoMDEuL8HZA@mail.gmail.com>
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

On Fri, Nov 6, 2026 at 10:07=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Nov 06, 2026 at 10:00:35AM -0800, Naman Gulati wrote:
> > On Fri, Nov 6, 2026 at 9:31=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > >
> > > On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> > > > I drafted an implementation [1] for premapped TX and RX buffers on =
top
> > > > of the existing networking page_pool. It is implemented entirely in
> > > > the networking layer and extends page_pool as the default RX
> > > > allocator, to the TX path. There are no hooks in the IOMMU, DMA or
> > > > page allocator code. I wanted to understand if this implementation
> > > > correctly captured the feedback on this thread. Key components of t=
his
> > > > design:
> > > >
> > > > - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but e=
ach
> > > > chunk is mapped once per opted-in device through the DMA API and
> > > > records its IOVA for each device, rather than using a shared IOVA
> > > > window.
> > > >
> > > > - TX: page_pool accepts a memory provider for pools that are not bo=
und
> > > > to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunk=
s
> > > > of their NUMA node; TCP copies sendmsg() data into them through the
> > > > task page_frag and allocates its skb heads from them.
> > > >
> > > > - RX: an instance of the same memory provider, sharing the chunk co=
de,
> > > > backs RX queue page_pools. RX chunks of order-0 pages belong to one
> > > > device and NUMA node, and are shared by that device's queues on the
> > > > node.
> > > >
> > > > [1] https://github.com/torvalds/linux/compare/master...NamanGulati:=
linux:netdev_dma_pool
> > >
> > > IMHO the netstack should never read from shared/decrypted memory. If
> > > you put it in a SKB you have to be sure the only touch after that
> > > point will be a DMA read from an untrusted device on the TX side
> > > (sending it to a trusted device would be a fail) and the final copy t=
o
> > > userspace on the RX side.
> >
> > That's likely a fair callout. TBH I'm not very familiar with CoCo and
> > will spend some time understanding the constraints. I kept CoCo out of
> > my implementation as I approached this solution from the overcommitted
> > VM problem where we are trying to overcommit memory in VMs and use
> > these pre-mapped pages to avoid using bounce buffers.
>
> Why does overcomitted VM use bounce buffers? Do you mean this is
> about getting better memory clustering in page pool since the VM
> paging granule is 2M?

Not exactly, we are trying to use VFIO passthrough NICs in
overcommitted VMs. Since the guest memory is overcommitted we can't
dma-map the entire guest address space (as non-overcommitted VMs do).
So overcommitted VMs can use bounce buffers to have a set of
pre-mapped buffers to bounce traffic in and out. We're trying to use
this solution to map pages dynamically with virtio-iommu and recycle
them via page-pool to avoid traps on each TX/RX and avoid the copy
cost of bounce buffers.

This problem extends to generally reducing IOMMU overhead in
networking - taking the dma map/unmap cost out of the hot-path and
avoiding IOTLB thrashing.

>
> Jason
