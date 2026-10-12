Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848748FF92
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816351; cv=pass; b=j7ZgTYPpihooec6Q+uHD/J06bpjvL3Id6vp4yMCnAL7RkMVtqxnTzhy7ZcrYP3MJ342hWnkCQVBD8HQDVzIriFNyZtdeXc9soZgi3KSazpmCP8OH7KFc93981SgzPCfjVcft2B/xQP4EFCnznsHyOEFx5/Trt8BReD14vsRaZL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816351; c=relaxed/simple;
	bh=gGrNTBjii+g6uIsj6txOBfGumy2pNID11P1zmPmCOWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vsiy8O2aDjNg+/jMFLAeBT0eNlapXD/cdxqSP6S115bTX2J7M80otmgWuwHnQhHlNkpKk0b21iX07FkWoTPdtFO2uzgA71I4k10vBRKNAkAxjl3+uoSdG+2QRp3yAXwb/R+fwYR4mtP0M2/mTWR5RCF6ctlShmZLq8gB9QiYewY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aMDpyKm6; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMDpyKm6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so69785ad.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791816349; cv=none;
        d=google.com; s=arc-20260327;
        b=c36sKr5RVHfojAQs0oKPwHZ1TplSGE5qzbXKS1l3C6kEid+QYv+HTnFPEnYtqnNglS
         /3gP2AKXZ9RHsKrO/oZvMHxuxH7o12IGd86z6zc67WUa/NbTcelN+F0u17Qdx8jq7qYb
         pHIoo0RzjKxZcUxCnLeyFFcbdqGhGyev5WsDAgWKeVVQYst2E/+NbRjvLMaHjAKzjJea
         zsFTCo0QgezKQMH6PACMcMguCv42tJVaUzCBgm2tT7VLqAR55Ox+5Rm/DU1a3yXcAn3Y
         txobGKdwspN+pftzGS6ODZYZl4781yy+JEiGun/BL7oKXlEsg34toYvCu4O7WSUvBbus
         ZhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gGrNTBjii+g6uIsj6txOBfGumy2pNID11P1zmPmCOWs=;
        fh=EKSISYEoqyLRMKpCHz3TtWAsAaCeajTcANXBWRJ0bTo=;
        b=JoQt54yzVBCmKu8YIZGC2KFvBN7doJ2krEtn3dyz7kZQ3pl+Luy7CFOa9TgvWATLsM
         2+Cic18ITMBJZw/tXx1L+fIXlN/7PK99dMkgrSsaF2svE3XX1Vzy4ZOqz23H8IT+5np/
         AiXTXT3DloCULQSeYmDbdFHkXL0UkTSzHUg7y6F0fnzU/AJsn53lIeO1Ki8iXaEySoPV
         k98VDCCmSV9Vj2+zTDoG7mFAGUDrIbVdyLyx6EPtSn3rPAuB7EsGvJtRE05FcUV4qLT/
         3Ja1RLGmUgNVydYsEmpVzFs+CG8qtVrl0IrcZsM476rLGXiynOGHe2S+YmwoJltgu4Wp
         lWFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791816349; x=1792421149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gGrNTBjii+g6uIsj6txOBfGumy2pNID11P1zmPmCOWs=;
        b=aMDpyKm61Dj4iTeFbZKh5kA8qVzqM1Nn/OvWPYweC9o3OrELzTjp10jAUHpq4KKlXo
         pbpIM1+uhrwn4SH4/GO8L3oUMvvy5CS93hjhq07OxeBwqg01lr0wAVRJ5EElJoxsP3Cg
         +9OXX+J99PrFvFcruk13JI6ZPiLvvBFE3a++qf03XNndGVFC67cQRPe45vr33sxdSPrN
         YCX1TalQ6lDvefnd004OJTwBsalkZla3FHqday5Y/7JPzIO+b+/Jj5FJkqJ9bNAyWx6S
         J5/UlKxHI0gthGhLaGikUJmxbayHyqr5jb3Lil17hajiD+trv5jLkm2o9JsWNF8wZGsJ
         H29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816349; x=1792421149;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGrNTBjii+g6uIsj6txOBfGumy2pNID11P1zmPmCOWs=;
        b=d73/92MxzpEvn2ge12PpEnvbPimrCVIxJp6WSmaVOXJHFCgBauY1K9nzYfAlMdnJM2
         wAHbgfqv80be9GZjczKZ4Ds90q7G2IpQwjTbEIXlqvQCmwW679AH+1R1s2FbkiUtOSzb
         FJ2b9D96YRD5wOA0IyzCWvpLPnIwM4P/IUsSYvYSiLbkw46TtZ7roKAX5M6TPKwbDBQb
         qYr9fdIyqCa5bw57z2hlf1UcUwHRWbTtmnN2H3zzlvhEMXi7JA5QR0znJ1gm+PtOpBqB
         1eTbGak6oLClDfj+Vb3FHh2YqXlONJbKloiuCCT9YHnCzm/HZyPrfp83HR7v25N1eoY9
         DUZQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4B6RYTF4OXwXlb5rXlhjuqPYG7bl+7fTf7qPQ9cWyr1EFvPLToZYPx72CLmboP1fk9PoOJ54=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAconpgLMxJHfA/CVi1N/pzUP40SMaeR6fwoJ7dQQkN6OhcfH+
	TeIsoa4WnKAFUJesGL0hWsT/1ketZ6oPpdEDHFp5HQyNF+68NtVHo2bczrof68FTYhni+IO2Maz
	ziWQv3yUlA5fOJBbAXOfBoNzU4tzPc383EQ5OaAMK
X-Gm-Gg: AYBFou2ovjXMYULKooGgQ5Ayhyr44DT09cYtuKB4GmtczqNp10G5UlPozuFBj7H6eTd
	nnMZ1ZYBuwrMSKFNAl3G0LQbU8Vo4CHpcshiuEEKdEb13vcArnQPDaYDEu3dC5QTYdnXqQ+7tC3
	mJ7b+UimadiDaawaaRxeSNDlQWBtPa/E1QXVbL1giN3Syye8aUpZZJqBWmMzh+fcVRTdwqB5ei6
	qN4BudirU9Lmh9hIUpN2oU+0oxbkjpPFwueTMJqUSkfla0D4Lrn46bIutccVIpy9zUR8VSsM7uW
	ptdaQuXu+Setl1M3/d62F1e0zvlA9aLAzrfFi/iWJKCgxa11oU+jAL8l
X-Received: by 2002:a17:902:ebc6:b0:2e2:d665:6ad8 with SMTP id
 d9443c01a7336-2e87bc2190fmr6225715ad.4.1791816347416; Mon, 12 Oct 2026
 07:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
In-Reply-To: <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 12 Oct 2026 16:45:11 +0200
X-Gm-Features: AclHuK-i8fHHmdGq1sG19E58z4J25P_7xaX9lSE-RrDdVmPDw1ep2a8coGIVdbw
Message-ID: <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
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

On Mon, Oct 12, 2026 at 3:51=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/3/26 23:22, Luigi Rizzo wrote:
> > Here is a subsystem called DMA_PMD on which I would like feedback on
> > architecture, possible enhancements, or kernel components that could be
> > reused to avoid duplication.
>
> Here is a feedback to a subsystem called DMA_PMD ;)
>
> Why is basing this on PMDs (and embedding it in the name) the right appro=
ach?
>
> On architctures with large PMDs (512 MiB on arm64 with 64k), would we rea=
lly
> want to use 512 MiB pages, or rather something smaller (e.g., 2 MiB) that=
 might
> possibly also have TLB benefits (cont-pte)?

I had to call it something... an earlier prototype used the name IOMMU_2M,
but I didn't want to suggest that the design was limited to 2M (it is not).

Aside from the name, the _current_ prototype restricts to 2M allocations,
exactly because too large units are expensive and wasteful.

In the code, decoupling the allocation size from the PMD size is trivial.

To enjoy the reduced IOTLB pressure the architecture needs to support
IOMMU leaves with the correct size. Looks like ARM supports a
"Contiguous" hint, but I am not sure how to tell if the hint is honored
(ie the IOTLB actually uses one entry for the full contiguous range)
other than measuring.

cheers
luigi
