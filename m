Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34D493D3C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817372; cv=pass; b=LqxZHpVpqjLwhIRhEzaeYzMeqckmVYbNqMiMmWGB8JurAQhw/rWaf+TrgzynwbMqpckBrmwJSuq1raftXUrEpm7UyRWsd06Flzp/giAv3TvNzbwMzlW4N08wg2KSnZSnCV4XLxTfRtcQT6Jwc7houvgKQt0bSTGAyyF/SavFQW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817372; c=relaxed/simple;
	bh=9p0AqvEckCKKmioWpbl9ub4ZG0q2KitJ6iNWSAzwTY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/nv6Hy7/KF95jRz6IaDuFcXHpKKVas16SjEwAAUYFHkShwbE4XUoEvR+8HGHihpXsRrXjb1r4OUxM5L+gPFB4NGRabgey0nRxU7+9OnwxxhbXA7Pn8vkbcFC6ePuQzHCUQ1X/XWoFe/f2bI8x6Ap+tn5+cJnOIiok9B+L2BoXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egpQtRhz; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egpQtRhz"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so883631a91.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791817370; cv=none;
        d=google.com; s=arc-20260327;
        b=rlLw3achRlbFRFbZCmD2B3dOBMymRLMKxU5Goc39gJBCl1lzTD2ERYZgWC5mV2QyyU
         7j4efmGDmbXPLnLlpU3VQmV/XX9h1+AE30bD5XR9ZmJcfPgFnpeI9mYeQR2z7AzRn3Hi
         CymI0pfQ6dmiIhu3HfNoIerdyCLyyu0O2SqrEgYGT0jaeDT2TJyyKTbaipCm6/oexc+5
         UBnY/nX4WEedKAKGvkzQufnW6nQjrZEHi6m/byMcAItkHcbCwVMaPX3tLqFkvw+ap735
         6tSMyZXQikIOhqbRPzXi8Lj+QQNReyx+BKlADZaY3nqBdaYlfvN8xhkQBW34kaPNvksZ
         Gw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rhIDuBLHbJsBmFiUrtUWW1GlGqZnHdg0lmt6NThkZTI=;
        fh=EMZc/4l00d6JHG23pATHQf1wcJITpRyyikasx7kDN1o=;
        b=FQPDTKEVBQYwRiqEDDbxtUP0DSvfO4YQxjMoBTPKJ0PLLahBVNnr2ttdvGbHZ7vENq
         sfe1VdNRrKlNj3ZkU7oQgt6Y7U6JoC+MFBhU8yjFO2uY6wb7+Pugwcaw0cNI9UqANXLn
         poZscwe2ZFAGuvM1nBw577x2xN4PT50dM1XdSzbRmf8EJdcIsTjvF16cYV8/BoEHV7xL
         Ep5CerAnN91we5O1a0UBUj8AgLNf7Flp7GC6GbQFAYvwPgpzgu6nkkXllatAZ2q0clp5
         K+Q2gIEkOzheobxNouQBlRlGywai00U9cWtUny4uIntm68SMwsif1JIAPHIIzEfnVN+L
         cSWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817370; x=1792422170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rhIDuBLHbJsBmFiUrtUWW1GlGqZnHdg0lmt6NThkZTI=;
        b=egpQtRhzSGqWQW7AvRR7AXcGqp+Yyymm/Cc75KZEWZvkOkG3Y7SPX8itba5G1RWlBx
         Ac3cNVJUlnZWf7wU6NP1rzxp0hcNxLZvMQYcaYLWuI2XSXFXYSQaGfFHzrvuNK3nACdP
         7fJJnxzLHQXwI1+alUrzlrl27tg4MKJac6zprntWGnclMlMZUbcKdOszLyPmuYQ+fmWq
         3oiS6q0WuLSpnb8dTCl1wfiqSlbPv2Dw3PkD5AUNVJ/a4O3m4GcApMs8k/q9BjOiyR8D
         2AtiNMhxAuuxBRXclHQPST/iIlvqBBjTToFYuLal7IBLTRtU2PZPER10S/X/ZC1cV0pd
         6Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817370; x=1792422170;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhIDuBLHbJsBmFiUrtUWW1GlGqZnHdg0lmt6NThkZTI=;
        b=dGLLxY6yTvFmtvsUcFw2tYp57xGOLPzN0/vYUoXpMxetaNSd9uCxLcbid++CkAChTV
         ixT0XltnQWEzqdl35sBU03P6trRaeE1W8wPJbY559/ekMDc38Qgv7VoBVebHmRXg2DE3
         rXGguiNnk4Ei9KQLqc7Be5BLNtGgb9bTX2wX9b9x9S9ZNF2AG/6urR8Sp4v4ImppD4uD
         mlPRssOATfPV4ai/WILkZ6+tixXj/42/1LFRPIFJoQCKormfuRta5pYI6BgOZlSjMBDZ
         KP2NGr1PTGCpqQ93ADEkJ5kCOQn+Yn5mWEPB6Od28wetk9lBZfV6LfXIIJsxj5tHmGJC
         qQlQ==
X-Forwarded-Encrypted: i=1; AKwUvByCe0cMqdErdOoKVOo9gcSTsMPj7fst86q5hp+O0RxwyOcOuJsTMnZGhwM5ZU8HpPwH8WMTNHs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrSjSN+S/kf3GDBKD+fptH7wHnJfCpdx5jyx89XCw+GposgibS
	GzjUtntsCsm9/sGOMON7MUULE9Ajj3P171rblafUVM6gMR3KhpqCaRkcs9/vVquBRBAQOt1gcJS
	8mTrIUoVPwN4FND7yd3Nck7+P0adDmYw=
X-Gm-Gg: AYBFou0Kk83TkilvdvyRcPdBx+IvNFG5zxvj8KeD/2w3sHaQUk1xpm/LYuDsNcc0Y2o
	Trvb8xll7+tp+eWKmvrbyg23OP3paQ3ly9mVmfsa1FJ9GWOVj3opXdP7yEyBXlv9zQGlNPga3E0
	rK+ttPhPqrdaI2KQswpL23CEGmut1gcyu79lQn06gnNYc7fFEzz5c3FYFcJwQsEfx6BLxCqiSyH
	sLtwgNwuWFqLuRqz3kkg1351MceOsjgSGgCClrIU0dhCsoIQsVF1hBvV7r9LMKOm+ECQkAOvOJN
	NpGbqA63edVWG6D+0eTaGCazO2BsmtPn1c7YZsOayBsGo3x9eWVLrAYnCw==
X-Received: by 2002:a17:90b:1d4f:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3ab3a94ff23mr7233060a91.18.1791817370093; Mon, 12 Oct 2026
 08:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <aszzcpW6fJWGcQCZ@google.com>
In-Reply-To: <aszzcpW6fJWGcQCZ@google.com>
From: Luigi Rizzo <rizzo.unipi@gmail.com>
Date: Mon, 12 Oct 2026 17:02:38 +0200
X-Gm-Features: AclHuK_RuYPmfWCEef8B345PmPnIk-csUIxQogHwwsigc85_8kdg-6GHSEnG77s
Message-ID: <CA+hQ2+gMGJH7J0yAx0ooTpWYfC50FnDXvCRRwRaJ_8bJ4b=QDQ@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Mostafa Saleh <smostafa@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <lrizzo@google.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
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

On Mon, Oct 12, 2026 at 4:49=E2=80=AFPM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> On Mon, Oct 12, 2026 at 03:51:39PM +0200, David Hildenbrand (Arm) wrote:
> > On 10/3/26 23:22, Luigi Rizzo wrote:
> > > Here is a subsystem called DMA_PMD on which I would like feedback on
> > > architecture, possible enhancements, or kernel components that could =
be
> > > reused to avoid duplication.
> >
> > Here is a feedback to a subsystem called DMA_PMD ;)
> >
> > Why is basing this on PMDs (and embedding it in the name) the right app=
roach?
> >
> > On architctures with large PMDs (512 MiB on arm64 with 64k), would we r=
eally
> > want to use 512 MiB pages, or rather something smaller (e.g., 2 MiB) th=
at might
> > possibly also have TLB benefits (cont-pte)?
>
> +1 I raised the same point in the LPC talk.

See my other reply, he code makes it clear that the target is
reasonably-sized chunks (2M being the obvious choice with 4K PTE/2M PMD,
for other cases we need hw support, and it is relatively simple to
decouple page size and chunk size.

> AFAIK, this series tries to solve both IOTLB pressure and CoCo bouncing
> at the same time which might be too strict; as for CoCo there is no
> actual IOMMU, so there is no sizing constraint.
>
> Also to reduce bouncing, I think it is sufficient to use the SWIOTLB
> instead of having a new pool + recycling, the tricky part is how to
> abstract that to client drivers as this would be needed beyond SKB.

I did have another series to build buffers out of the swiotlb pool
https://lore.kernel.org/all/20260824152932.1583506-1-lrizzo@google.com/
but I found it does not scale well under pressure: the existing swiotlb
pools use linear search to find an empty region of suitable size,
linear scanning when one pool is full, which quickly degrades to
O(N) on each allocation.
I had some other (not posted) changes to build a buddy allocator
on top of the pool (so searching for a slot becomes O(1)) and
to spread the search order when a pool is full (avoiding O(N)
locking conflicts), but there is a bit of extra overhead in the
light-load case. Also it felt like reimplementing the wheel.

Overall I think DMA_[NOT_JUST_]PMD is cleaner and superior.

cheers
luigi
> Thanks,
> Mostafa
>
> >
> > --
> > Cheers,
> >
> > David
> >



--=20
-----------------------------------------
Luigi RIZZO, rizzo.unipi@gmail.com
 http://www.iet.unipi.it/~luigi/
 Mobile   +39-338-6809875
-----------------------------------------
