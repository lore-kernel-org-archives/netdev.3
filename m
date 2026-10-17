Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31E3B6BFE
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257127; cv=pass; b=jg73TwwDFyIVu128V4CmuXMCGNxE741QakOx8BWxFHID09cz5R7Z6+dhZEm51N2Gny0/qBK9zkldv5UH43KsArvBHbPs35R8itmw9YRs48VhKyQeVdCRZd6m5dCWJvqaT7eiUnV/D/pObIEzU12sDorvRBOGiR2+oAk78zWB10o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257127; c=relaxed/simple;
	bh=TQ0S3+GvPqkyCnzw3WaiERWE0gQzxysyRgtfYYbHNSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jf3IIQ2irDVm3RJpWgeBLdZACO0g3lqDDzwXSNAIzPXGSm70SdkLvZracX1Eet1UYH6MFNSICRat0D8nqyi3Cm5Zo1W82+Ie+VmVs/RRhJPaJZGlndr0mg2bT298KLNMqllP+zcgbUG38SrCE72oz1FGPmo3UlxXAWDnJ4qc/N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MLWWHBXQ; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLWWHBXQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so24905ad.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 10:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792257126; cv=none;
        d=google.com; s=arc-20260327;
        b=j6VMsfhsemvOUrvWBZvtW9wrEVgmuq68ZN5b8eP0ER9x0yXdCeshL95n4qlxH/en7J
         AQMX2giwsCrUMrd5UsDap8tvQQTb7PiM+H4RsfUlBkm8YImFH+eCSMAhhtp4cgc4/Hk1
         eJp4Bajo0v81yBBUhmxPerCZnEBD0sW6kocusnmUHY+Q5n8M6tmJ3XhpWUilGx9YPGxz
         1JMd1+IVZIB8b3mtf7+tIa45TFk9fmLlW4oIU8/hmIiqTvzc9rpNhYxc96jRjlsBLvgI
         2DskyXiXAaMXD9WWfevLsVPc+SisY/2PEepOix5OFE0MDX88v3UBdQYNsHtP3iLSA7L7
         v1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TQ0S3+GvPqkyCnzw3WaiERWE0gQzxysyRgtfYYbHNSY=;
        fh=4gYjzoXcgj6uu2VlQIQoRVcP3vGRaigCY0uA6FKqUWM=;
        b=kgraGcLQgz7WMHMPAZqsuy10Qjg/+S71hx+pJIjfDHzdS0Oos21LePFoOQ1nRtau6H
         B2nYU4i5YtPv/jCqpjvJw7sEj5R4WG44gW9slRuvftVIB5RcrYzp9UFPA/xRXFmG2yA3
         +Jnwfex0i9pHJ/bi+H2UGnkCzFJLOHSnawxg60Pya0xL5eFTUxHxOsIjtjh0gxqMnOdM
         UE6ymMhq6AOd6thJ2pWpcnoaeFonCUb6l/SwPAXT7UL+NaUUl9YQHddrX7/gX0GIaTQl
         iKO5wwPsMdGvdDrfvFXqwR04wFbyWT8EMQBv7bWBc1hckWIHTVYFEojuF9tIyx7kag0N
         KXFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792257126; x=1792861926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQ0S3+GvPqkyCnzw3WaiERWE0gQzxysyRgtfYYbHNSY=;
        b=MLWWHBXQq/y8RwIU84GS50PyppI7TkQc6XbV/NDzoY3yGuCiDuq4QBUWs5tAHTwhpN
         QMRdv3VIw/a4fRAF3zmvmDzS7DmLiwK7NhAM3i10FCpVUfr92kia0GQ2l70/ijjOnp27
         p1jtj3BqoNvRPFWjQK6LyTYVsokb+hhfwjI47OT21GRSQmJt62YnP24VmXoXbXKVZ/ls
         hOHWX/OUFxcNyAgahr8COpMSnn/YkkkuOXUAH/UsFdP881sHySIXIrQdM9TRTygPTdR2
         lWaU2+DlgxXyNz9oeHhd+wx3+Z6Bxb+0lk7fcbIVC+8x7eeS34QGVQ542jxGzXR7wsyA
         hXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792257126; x=1792861926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQ0S3+GvPqkyCnzw3WaiERWE0gQzxysyRgtfYYbHNSY=;
        b=tS/BLDB19owFOnBDy6HjTStWyQO8ltlIRzOHEmj026YYgcGLoMouL1XAL3qcG5gulP
         i7uBezYj5S3gJzL7NXMsmDIL2U1tatkelTc12hn/GBi0/1lqR/tcTsgscmysPkegUjUr
         W1iA0Jl2jhgI+VLmB+XZewO0D2B/RT/2107AIr3xQ/PwudbDWUX/RGcBkkj7IOq9Wdka
         GrfVgtmMjOcssHxbs8uDiSgRh++BM0zerl4r49sG5c3AwO2dC0mhOO14WInGkr1OshTz
         +4Ihv9kNYc1FbxjCs2kPTmAs5mkZvrJyyOMrDoz8CH7AssFOfU4H3ZrqZ3MB+WVCYPAl
         suZw==
X-Forwarded-Encrypted: i=1; AKwUvByGOVCc4/pKa/rliFWgWPRJ2+BHIzYCX4+WzasPLvRLoj6+qLL60bd586rpQRDPndQGOGIna4E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDtr/U3EK5H5OtAWSpvGH/1n5aNJnde8kiJ8p4bk1E7/URbRm9
	5P3zU+TrKFWptVIONfItZeSFALimeryiuXjs97qMwlwgbSqI7wULuNsGm4BIP8CbBJsWoB6o5Dv
	xWV14CpNAwy0rddGngYqaUMY/RML3tjtwymwkRrue
X-Gm-Gg: AYBFou0mVGOvKzV8IJEleJUB07+ICK47+6i1UR8WfPQoi6y3qajJ5TVSdZ/jnzgEP0k
	/EarZCHPid0BI265aFb7a8XR0jmLzssoRwIoWOaqyRIYTbF+11E8w/9gW11kdyXvyJOiIEuHQ2e
	ytI9IojxmQQSMl6tfNv6SNStd2QoZx0iePcJrWsqrMmLpql+Y0HJdUSy1ZeYEAW4WHXzL7qXrmD
	nSbVYyhiJJRRKV2iVEhezK8V8DEsBjFf6ebFOPEPkeXOfEGEL+pgnqM68KON1mRebpDkt4e3CKs
	6tFWI68p+WpFuYsSf1fYVDuUWhO7VH91VK7s9YFqjXzfwMGUZImnIPG+
X-Received: by 2002:a17:903:144e:b0:2e3:981:4cc4 with SMTP id
 d9443c01a7336-2e9b3252cdbmr3330175ad.9.1792257125060; Sat, 17 Oct 2026
 10:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com> <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
In-Reply-To: <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Sat, 17 Oct 2026 19:11:28 +0200
X-Gm-Features: AclHuK8222c3YwWa2EndazmJS8Umg9HTADwML-hsKq06OdSigMokkN9A-iBy5wE
Message-ID: <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
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

On Mon, Oct 12, 2026 at 9:44=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/12/26 16:45, Luigi Rizzo wrote:
> > On Mon, Oct 12, 2026 at 3:51=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 10/3/26 23:22, Luigi Rizzo wrote:
> >>> Here is a subsystem called DMA_PMD on which I would like feedback on
> >>> architecture, possible enhancements, or kernel components that could =
be
> >>> reused to avoid duplication.
> >>
> >> Here is a feedback to a subsystem called DMA_PMD ;)
> >>
> >> Why is basing this on PMDs (and embedding it in the name) the right ap=
proach?
> >>
> >> On architctures with large PMDs (512 MiB on arm64 with 64k), would we =
really
> >> want to use 512 MiB pages, or rather something smaller (e.g., 2 MiB) t=
hat might
> >> possibly also have TLB benefits (cont-pte)?
> >
> > I had to call it something... an earlier prototype used the name IOMMU_=
2M,
> > but I didn't want to suggest that the design was limited to 2M (it is n=
ot).
> >
> > Aside from the name, the _current_ prototype restricts to 2M allocation=
s,
> > exactly because too large units are expensive and wasteful.
> >
> > In the code, decoupling the allocation size from the PMD size is trivia=
l.
>
> Yeah, we should do that.
>
> We should probably just find a way to describe that this is a POOL that f=
ocuses
> on physical contiguity in some configured granularity.

Before embarking in a global renaming, I would like to get opinions on
acceptable alternative names (possibly with a short prefix usable for
identifiers in the code). I could think of the following

DMA_PMAP (for PreMapped or Persistent Mapped)
or, ahemm...
DMA_PISA (Pooled IOMMU Superpage Allocator)
both using dmap_ for internal name prefixes

Other suggestions ?

cheers
luigi
