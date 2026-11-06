Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793985686;
	b=B91orf/CDQ9C/rk63zH1BxhA3US1LX5I3zmi1M++J6eHFciq3h1wCHwvbp5mOZ1sHnPJ
	 DWOWAFXaBJQMP3d0qWN4EsT1rR1yiqCGS8RAzDoX03Hhl+5eOks4NyaqQQOYRDZiqjyhb
	 tflrqgziB3GwdFEWJ93kVc/eL9DPgRWLyZh0SdmSERWYapkqt1LX2ZJJbWE3/uO8UFgD/
	 7/JCbYqIKm1nq3C58XxNLQ3ey3zDp66S3Ht5oRtLXwhDZY5vhwHZtJtiKB7uEJVzLXTSr
	 oEMpU0dBmrRgXOQXH3z0d5Nnu4ptAX7owLDWG17HktUO/fvkX5fkHgoP9vFSvfxxDXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3RKt6UkQZGhVMeIsFX1m9xEh639vUr0Dxv9GzpFuH2Y=;
	b=ov6LH+nl5ZZEEL1L72HjO6sl0MO6EXnkrLuD1rCgQzOGiACUhiavulaPJm6qspVKVgb4
	 kZsdZHGFDK41286skANiRw7UTzC1K7vRlnELUxUOgb3/iWErHMkTQK24b+rKly2slxYoO
	 F6Uf+/Ree+sZs3x2eRvcMx1xPiSIYqWErPRDAX3UvlDGtMw/lk/biuf9MfuN7+6ZEmN5/
	 bugSg68SR41eM8PQ97/VRIgENEfUix/L7036+4E3/P0kK3l5kletAWOb9O3g56FnMrq+q
	 H4FQLHrwITu0QAiAViRkygzEFTJHZs7zgfwsPtYo0JNPwwiWYoIr4tLCGJzJCBX1tXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=brHuzBNo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8E606D808
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 17:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5D8E606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=brHuzBNo
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso13855e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 09:21:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793985684; cv=none;
        d=google.com; s=arc-20260327;
        b=bI+S5XI+sQ6AOiz1tSFM6W2+RwtF0c4AJgLuPga3Zve/P19JCCRhPhPp8qFpp+Bi5z
         ANYnbpm02W77euK8ge38VgjTzT0sF6akIHh7jfQ9++srSIO7Bcmx2loYSrsQFqz55HN5
         bI5arl7N0GJQmnCddBMFBS73Nt2Sflm9pvY/K5BeRT6B1mZsHlmN//0QGQ3/zu5ntPXD
         h9Bys/7eKNve8Uhm1pqwUS8ni2/7QzJSVodBzmB2MvjUMZh59R302XKYXy8cffuOwASX
         R6hepPDJiFE8exQlsm2/2zY5VjzyCyLX9EzhD05OYF4pTuZHEE0v/iKbn4W/IIPFTF1B
         8GMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3RKt6UkQZGhVMeIsFX1m9xEh639vUr0Dxv9GzpFuH2Y=;
        fh=ao+57Icqy9TlnijTRycUh/taJyvMrDx5AhR4wrNNwKk=;
        b=Dl0+qwQ7/yoeriXS1GauYmt5tOw4zEqVQzZnCFpg7rqQN5m1gASOHrXGYb7W9fPf3c
         FDpXN/FJU5R/3HAYNTuKF2WCuKjZS+Hifugf7Vv1E6slFs9MtP1iiUUbsjT28sCA/OIo
         t5i3bMsHnYirJpi3a1RBq+NnANssjXQcI6oDoM9b7OxqMH0SFZg1JAJ5oY/EldagIRJA
         AMi9ZTr6aajSV+7TvAQqUdoysVahcVs/QmwyGzBmVCWVhdkGYa0ZKJHjbtMxDsiZNKZt
         49BoI/UiWN0/YXWz7AgPNoX5PfWBaqa1MU04oOAHSxQ24wbnvcSy2HJtl41c91otrPoq
         b81Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793985684; x=1794590484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3RKt6UkQZGhVMeIsFX1m9xEh639vUr0Dxv9GzpFuH2Y=;
        b=brHuzBNooCSZjsSyXSFWMHBwfNjYNTG9a5Q3GfKsZ70yJN94/1w8oJ0YhXFD0HweTI
         c6IcxLxcr92YlN/aRCSw1AAeONF2b2T3QTgT71unjiSJd5fE9tDAasfUf0PvDE/Z6Ilw
         X/g6Cnh0qRbf0n2W6uL7JRiT4hiIN4Ik1e8K6GdO+BwIhEGoPL1NAnA4d+9ktJXdAlh8
         xxgcRU7Ghap1GLjOorZx0V6eGPaWP/d6RiEHe8vigfy9F0RG1ujzhJTCLnKuHDDyRKrf
         tz4kI9F4z4z8kTBYDRkYSH30f819pXVPbKnkddtLpC/W9IwCzgHGM+pPzaIVpPR7zN9m
         wfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985684; x=1794590484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3RKt6UkQZGhVMeIsFX1m9xEh639vUr0Dxv9GzpFuH2Y=;
        b=y0OBFcpg2Ded9444+OqWRsIe3Ev3JMfKi5cy60GmPqWhf0MB31d5buBBFoH15kGS84
         N+FsBKeyW78FTZ/8jdG8uMEagpD7NOi7lD+SeBNhZsGyrgpowyy0/p2m/1Zcm33t2MIX
         Jt8/3HShWJQHQRN5FPRXbHXhyIZyDzvqekDWOxM90cBTC3gpJTGy3EPPVamFnM1dAJRH
         /7nuK52ucv9lE3iEifev4SdQ79uh3uCS5uIFLa8oY1nNa4qGgNPYKowQ2CpMKyiEdVyM
         n/xlzul2bdfEKDkdWSJMk3G4Dp5RSinhuAKj6qU/Eft962jMU1gJ1vxyDMiB5cyqv5q0
         B8eg==
X-Forwarded-Encrypted: i=1; AKwUvBwzWZTOXHmgPoO4NnXPtC4W/SK7ZSFYkxLuGDO98EYHA8xRWOIiPxzCxb/bRHCRph3i+HQGj7U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OYeI1zXGFJ5xloja0OECczhS1R/ySs18bmJQQVz5N8dPe28Xa
	cFaPgiRIf7Lknvxex7BQBIn3S35VRGKGC+ngem5MI+ydBblpVTjvwxUQDMy/ipEteQtjUrWEDRP
	8kSx1z4jAl4Sw9xgAEms1c3UdFqJB04T5iVqV/4sV
X-Gm-Gg: AYBFou2xFufbmWk83GwiSx741Nv6LdrJoHDd5NMvQEoy/t8c53u4eynsPrbDaI9PqXa
	oRxm4MAIa89W5fPXHcjpTngVIhmybQJdSXmEW6skl7WVLYXNtOg3fBdi8QJTKIaS88ZCC8Aa5Ng
	J/2owlu/w1h0YVzO4xH1kSfV3giM+GbtCWeRXYbHmGKZj904F8ViXvNrGHe8S4NR01fdEgkC2Rx
	h6Oo9OB4fB6vN/dnestjPskrpj2chFVrdceJaWfyW8MTQtDLrH4awGE+3bzyfsvwk+AOtBTjs9p
	VTvLNE+Ecz6YesLTHbMn8eHR45cXN3stVf1VxiULdSXuKY3eTrjf3RF62VwOFN00ALjwi8k2Czi
	9lbw9OBBOt9Io2WhLKjgnkxya4XN0b83HbowYWd8wFB6RWtJYUAtNMtMmbwLpWadD60BvPg==
X-Received: by 2002:a7b:c8d7:0:b0:4a1:eb02:37c with SMTP id
 5b1f17b1804b1-4b76cdf14e3mr150235e9.6.1793985683858; Fri, 06 Nov 2026
 09:21:23 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de> <20261103151021.GK3889730@ziepe.ca>
In-Reply-To: <20261103151021.GK3889730@ziepe.ca>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 6 Nov 2026 09:21:08 -0800
X-Gm-Features: AclHuK9QrDyTYpPe0hyDJDnSB0d1jRnWKMXKMwxckIvbaQIWb85nKJEtPirUyxs
Message-ID: <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
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

I drafted an implementation [1] for premapped TX and RX buffers on top
of the existing networking page_pool. It is implemented entirely in
the networking layer and extends page_pool as the default RX
allocator, to the TX path. There are no hooks in the IOMMU, DMA or
page allocator code. I wanted to understand if this implementation
correctly captured the feedback on this thread. Key components of this
design:

- Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but each
chunk is mapped once per opted-in device through the DMA API and
records its IOVA for each device, rather than using a shared IOVA
window.

- TX: page_pool accepts a memory provider for pools that are not bound
to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunks
of their NUMA node; TCP copies sendmsg() data into them through the
task page_frag and allocates its skb heads from them.

- RX: an instance of the same memory provider, sharing the chunk code,
backs RX queue page_pools. RX chunks of order-0 pages belong to one
device and NUMA node, and are shared by that device's queues on the
node.

[1] https://github.com/torvalds/linux/compare/master...NamanGulati:linux:ne=
tdev_dma_pool



On Tue, Nov 3, 2026 at 8:24=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Nov 03, 2026 at 09:09:33AM +0100, Christoph Hellwig wrote:
> > On Fri, Oct 23, 2026 at 11:50:23AM -0300, Jason Gunthorpe wrote:
> > > > Disk I/O is still potentially affected by the same problems
> > > > (cost if io mapping/unmapping, iotlb thrashing, bounce buffers
> > > > in confidential computing...)
> > >
> > > The disk folks already have a proposal to address all of this using
> > > io_uring and preallocated buffers. I really doubt yet another version
> > > is going to be interesting there.
> >
> > Huh?  If you mean the dma-buf I/O it doesn't really have anything
> > to do with disks, except that this is the first user.
>
> Yeah
>
> > The dma-buf iovec can work for every ->read_iter/->write_iter
> > consumer, and should be adopted more broadly.  Including by
> > networking instead of their own totally weird different world.
>
> I'm not holding my breath on that one..
>
> Jason
>
