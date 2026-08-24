Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078346C821
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589094; cv=pass; b=FjlSr9eDgcPJAAFEYDHYN3wRPhS5NlcqrYKbt8oNxwhk3BFhI3dBfT6nLVXX9ZTljD9KuZePDA85hDei+ZHB1utyWIE0IDY3X/Yip23aqKBuprOGZ7j7qXj1b2fchtNojYBtL3Bi5idTmQihaN7U2MjWf1MA/QIQKSJ5ejef8ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589094; c=relaxed/simple;
	bh=roisqT8iKq+LRB/VLs0WzYDy3i23i29fG7pAUt2iNuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpbikCcGU8VPJ+JtgL5ErZ910CK1LHsfiADPhFb/L3y46R+d/ejRwailQ0D4BOKwnAymuFMk6630ZngpBoz6o3QUg5G0tabRWXhX445o9oHkSK9MBQ8//SH9yGPP9odA5NvA6UZF2weZmEDD1MkBct+uFwAPLFN1awWDpQC8iA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxdzAeNK; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxdzAeNK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cede6375caso195095ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 09:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787589093; cv=none;
        d=google.com; s=arc-20260327;
        b=sfS7bIgf/uYtJWnFtaxz+7WsEFUEX/qd/2y9bScBTwHnCgO3SDSsyq2xeHKVow1gdn
         zodgRv8xDiQLUwQlC1pRzrbU7rY7QJKUnbhE2+/OhkYmDhHs4Le4c6oAF4+0J9RkWzit
         b4/Pad6cl9VKwFKWT/vf/g3DdYGsAe/0eXYYvzkhd+yP17+4sfEb682xrD0C8w8nq7C2
         QPePv7DiWtZ+mK+W0qb7OF/814ScnZbjBeOuJFAQHnwNiBNxLjt3yXBDe6jVdjnsOwgT
         UH31oRqCaEpB+XBvVtCcDzlur8Cp+N4dlc+MwpRo50RcCS4nXug6N1IsYpFMNwssauFn
         78Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q6jDXnJz5bszG8pnLHnZK0KeQdaX8tcSfusG1JTMhO0=;
        fh=HMZXNL2Wshiop0b+27RMVPgo1uVLuq81sUIF3thE+qI=;
        b=LH1iH8EZ2hMuw4mYgXocPsF/wKZwEB6Ca7gVDW+J+pBd6nOsM9pExpvSOKcTYtNlKl
         Gz50jZR5qdj5sitw9faZnUcEUzyai5wt1h8xTIU7PNbQfaqeabNeKYYOFK2oKPjG1ZCL
         6Qa4fAnH2JCQALGMyfdwdWFY9AXOR6ErVNbDioemFgz29BsSgBGvBXf8sKHwGTG83vVB
         ReRemATcgowfL6YReXbKTZ7IIRAmdM38NGb7aVk5PO8SBIgBkHS0SRk/BCdNbJoO1AYL
         n/dlslzlT4vsxGO4WS/D4aXiFkSdoAW6N+MFj0REZSE573pbXYQrNBsPgoKMi/R1X68c
         T86Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787589093; x=1788193893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q6jDXnJz5bszG8pnLHnZK0KeQdaX8tcSfusG1JTMhO0=;
        b=UxdzAeNKyRf4edW2PuPnPr+4wQTlNpmZ63XdBxD8boi7bfOKvnZk9PIFh2dx2Qckre
         NGJagg3bJo8sU9j5EtgyNn6SCepPJgFEMVXcAq6FNCVfivAu6pMQv9wfz2qbxl0oW8rc
         6EZ6nfUojnbDm492Venw4fOXH6PuViXfr73J4ZooDlBOgiLF45Bxe3NbXKGTmlH9mPpH
         kRkFIrmRKRVUdHL3j47p9bws9hopAXwJg4ENTgxCSLbYz9F2+JFbVRrYtLSp+8MEyNjN
         fj4LbR4dT3lVnQisBC8mJr1grIEl3Hmdv/v+UKFMzPBAeuPNFeWpcO0YQtudpEv2eV4N
         /Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787589093; x=1788193893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q6jDXnJz5bszG8pnLHnZK0KeQdaX8tcSfusG1JTMhO0=;
        b=qWAhKR92HVgrF2gXyuVfJZtDUjitV80DQq03XAcJKg6HF/GulAfcSEDt/XE+Sqayio
         FvnyegIoR9GuS5t9O2uIn2w6dKFhY0ZwSuP/ttLviIa9TjctXq1iS8/S9IpzYESN0InF
         rulmTqrgtc0m2yDZ7rXH2VCNzaAJ/HVsG2QisBGSH0hqUAyxy1H8xyBGcOe+Jbdgdivk
         ZFZvnoh4VqpfCXl5uFN9A2YrJUJoUp18o5D6NBfwXUaVG88CYBy2cJi59xnDfviy56aU
         h3wuFN73qmhSTuLo9d/hr+ouFjJRD8pIV4Ndr+GCYwwd3w+mllisXpcB62D6NRhkVG3r
         OyFg==
X-Forwarded-Encrypted: i=1; AHgh+RpIBrqaVqgMoFF4xprgtTdtWt6ciDPfTIpKjfuS9XFQO+3Rwz8gvP1QdWzpeP9HUSFn9LTEfNI=@vger.kernel.org
X-Gm-Message-State: AFuF++kWzqfg/xl77HghQMN/MU1HesZTDA1RPtndjxfKqqvO+kkaY1Kc
	qEf1fODzmG8eZJiRdKFLX3Vns8NYmvI0TZaKea206vhNF+oZ36cuC44Im9b75R46r+dMinksuVV
	vZonoqeZOfLlWrn2x9wgdx3k6t1TM94tYILPruuuN
X-Gm-Gg: AR+sD12gAz4HktV35FCFPo+YQvZBqjEcuFUuVayXgJyALmrDbs+2ypIev/k3ptTut4w
	TkmaPFLCnpgBSmtwhGVeySgdmyANPQQgeH/cedvv4jCA7aD/LqJvJAma4Uww4fBXCsg+wJ9koG8
	VbjxpobevuP7t99UjQo3UgPjLH5TsZmNZtBDcLMXNMqvkzLOsqdNuDzGh2O1Sq9ferD6Y0FnQOP
	a7KH4voYLcYq9Tgyb3FhChM78RQl0xN4FBApxKdF/I/xEmfFfmraQpOd4Q5VaO7kA6HljESd6IP
	WCuJdMDqgz3+O354bkGivOF8EvPKK6D2EW5Zbd43/e5Cmw==
X-Received: by 2002:a17:903:3c4b:b0:2d5:db3d:1a45 with SMTP id
 d9443c01a7336-2d66ffd7057mr11511785ad.18.1787589091990; Mon, 24 Aug 2026
 09:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260824152932.1583506-1-lrizzo@google.com>
 <20260824152932.1583506-3-lrizzo@google.com> <a826c7cb-5e77-4c21-a649-d40a9f0ef564@arm.com>
In-Reply-To: <a826c7cb-5e77-4c21-a649-d40a9f0ef564@arm.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 24 Aug 2026 18:30:55 +0200
X-Gm-Features: AcwNN1XmT87hJkoGkp9jcEKvjnY9kL9lu9ePxKQtYVAUZgS8n1wQenRujPZyI_4
Message-ID: <CAMOZA0JstwiwoWFuFjpoC1W12ir2b=SrWPO9i9tto1rOksKGgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] swiotlb/mm: Implement SWIOTLB nocopy page allocator
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dragos Tatulea <dtatulea@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:06=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2026-08-24 4:29 pm, Luigi Rizzo wrote:
> > Introduce swiotlb_alloc_pages() and swiotlb_free_pages() to allocate
> > and release compound pages directly from the default SWIOTLB pool.
>
> Huh? The sole intended purpose of SWIOTLB is for bounce-buffering data
> which already exists in some other memory that is unsuitable for DMA for
> whatever reason. If you want to allocate directly from some kind of
> pre-shared DMA page pool to avoid bounce-buffering, set up some kind of
> pre-shared DMA page pool and allocate from that in a manner which can
> avoid bouncing entirely (see DMA_ATTR_CC_SHARED). The idea of getting as
> far as calling swiotlb_bounce() to then have a special case saying "haha
> not really" seems entirely absurd. Don't hack stuff into the SWIOTLB
> code which has no business being there.

Ah I see DMA_ATTR_CC_SHARED did not exist when I implemented the
swiotlb allocator. Cool, one less piece, it should be possible to replace
this chunk witth the DMA_ATTR_CC_SHARED.

The other pieces are still relevant though ?

- use these dma-able pages for page pool allocations (small)
- [PATCH v2 3/5] net/swiotlb: Track bounce device per socket
  or one would have to unconditionally allocate from that pool,
  even for e.g. local sockets
- divert socket allocations for eligible sockets to a DMA-able pool

cheers
Luigi
