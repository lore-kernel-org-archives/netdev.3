Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793988051;
	b=0m8ib+AhXfoieshU8QMOPZwqt6WNyTy0nuhc5jQtcPIfX+hUzdDeRvHR81pEvCcr+SHk
	 WGGrXC9hwUhPh/dYLMHL4d5bh7mjQj2PttLDf7yO6y57VQeg2SLzYkayPrt1uHO92w2v0
	 Wgvl9sA0sO1WAOdOUPVxrMlrzGxiId6KEqOETOQPcmzB9gRhTpWXqA/s4xWKMI2DzZ9oj
	 0cF8duF2YPDBih1jwgFPiP/QsyFMgqagSFd7mZiJ4gOHD7pb9/3npPlY5yUE3FHOQtEpd
	 KGrja0aSN1ioaV2FzKUag5iZLkf4yIKDDqc90Kl8IFk6Hww2VA5dhHStDwnb33Re0OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YnPe9jMocBvynbA9CNTJ1Pl6eniz/8su5Gj2vJyxmpg=;
	b=ICJ1K2SvO9/Xf5TSoMpGuLHnhasf9GHuNeZJu6BhioL2T+n/UGjWrXa7uYT0IpZsG9vt
	 5fMic8wMYjawQQu/4UN0zS5hUIBjgpNQNcbaJiVkTtlYADGQlUuZ8OYrqP7c8aDaL9XoH
	 aNPA8WKOkO7184XLv1jWKD/Uccir8qLzdU02Mt7l86eaLFwRU8Xp0JlOgmvm55JyV11QC
	 Gjij+FOW+Mi9aczeWxbVgmXSW8s1F1OqheXBum7wrXeNZeZn6mKJzYuDSSjnQg98fKmQ9
	 aaTUU8+fZcPcz1ZXnEbGVikVT6gofyza175SXBzLTaWMGqj6/eCRgvbFyRRADyVJadQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QoecesZE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329F606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5329F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QoecesZE
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so3245e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:00:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793988050; cv=none;
        d=google.com; s=arc-20260327;
        b=QN6hge5hE/6bIZnq81BgFwd/ucxXekqVCnQAfBB7gP0pyTqIR1x3tRFe9JSrrB0PQ6
         ii5H2i29BF5AHLR8/eH4RjIQx/ElQkjr/l3nMAnrJtJHwTZWzpTwExD8gapYS0uRKONR
         +rWCDIw+cOhSgujPYzlpBnlwfblQzXPyK0SOlZDovCFNNVe5/3vadN2lRtaezAmgZhdH
         khRKaL3nBQBs/9TT8dleAXM210QlLrQ0lNhI+7Q7KyysS8i/88LW7qDGB7RaubPcldqV
         XBoIfJ5+I11RLIK/8teok4rEi1AMGyZ8kd41iNPnP28OHH+4eqp/SRAr1pZfkNdqDqeY
         0I7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YnPe9jMocBvynbA9CNTJ1Pl6eniz/8su5Gj2vJyxmpg=;
        fh=hepLqXJ4uAE6wAiYeglNGidXa/vn/rL2uuWLiLpGYf4=;
        b=qmJRAQVjcZBK8T7D1CmW2oXKajWCzcOR2dQYAOrL6gX+LMaq/i/71Zt5iWqxNEyKeB
         B20YdDauOUlZdAbLpSMk7lFenMuXoh/+P8Ae9DmUJHNVokSI0Tz23ZqlY9tfwUm6BSo+
         eLePBtwuHGps/geZB6hb82OM0JFS7GqK+CgCUcnHxYa9ueCOpagk1RnIc0Sgftp8UQF2
         T6yBRe8ohPVS2oxT6nlVjofHskMlFwWhZTYsTyijFdq7SDW8cDQYPgl5lyCUyD2ukPQ1
         9jD8N3lFST70+J8B4YXp0zKsslRmffi1zg08yvlhviMJ28XXLYYe8oNhJJ8FNSCpqHiN
         Xezg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988050; x=1794592850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YnPe9jMocBvynbA9CNTJ1Pl6eniz/8su5Gj2vJyxmpg=;
        b=QoecesZEWdYh3VkL5qejF7mvJeTIRcWMeBzM7OpHnLqetsCHZK3GbCb4NGmtB8nhMW
         2GjUkRjQdN2500zoQiAqGqwF23J3T/2CHnerTz9RVr6QAUZgl+7r5vDGroRMzWI0jlrB
         8CriSf8HgaZn7WcDdIwuhMGmKtVOP0ATgA/mdAXS/Q36ZtmwST7JHinv5NS4feWIjfKH
         aEY7TmDxa0fVv+OxA5nKSDUpPZFrvNz8ky9qr9+I4JUMhbKKOIS5bKCfm9UGE3vTupcL
         eMNRQBsbdVMRtNrGOpudi4H+DFAwNJX6aTunShMWsRuI842LARoXphuXJ+Y1RamLrtkb
         vadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988050; x=1794592850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YnPe9jMocBvynbA9CNTJ1Pl6eniz/8su5Gj2vJyxmpg=;
        b=e5HNSytK1f3hs+DKVU43M4Qnt/POrBuvnbdG/Na4VcLldahz+mgOFG9Jsr83uqhc/f
         uaXxrPasZ/3T1sxDSsmSYFuxAj9EI4I3IfwByHqsj+RQFqixcYfmi6cmA3VyWIGIcsPP
         VgBYaCGNEF2RLGHxR3W2HrIrgNySrfi3ww1UwAxoEjPpreqAb8T9bf+fsYOy+M1dcOsU
         6UKGDy+UbOauMejozRgoPUE9hI1P52JNYr3tlgvViivCrrFHjRoo3vpqb+oo0Ge/Ez0B
         /8JQk/8JUgd5yjIRMthOxDPa/PkBUCjSZE0CZT1BZFjqR7zhSZfRWMy3raTiPqIEKjPO
         ifbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzk30bKr6jI2gZF9yIrCTDnJqn6yMy0ZhsvVn4lriVaOOwuxLEvtgB2eGk9QUafXCl11QiD3SU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dTOF9CuKJzgFGJv0/R5NTMYXi9kAmCzUjPdkt3QFCrTxPFB0Q
	h7RrOie9/Z+BDw66ASLABgZEKzB2Qm5KAlcUO2G3GmHrWDeHir2QfDQ1x+Cb9b6+THO+qN2CAwN
	99JotqT6VWDxQLQQS30TPhpZmP+Xbjv0SSIGQTCg7
X-Gm-Gg: AYBFou3HNJDMlqS/cY1toc+PwdLPzdzG2f/g7JFT6jiuEf801W3eU4bjLcV2Bhp5dg1
	iasDNtmtyD/G9rzMVFM7MrOPEiW6iTn2c72GEdZtndGj2Iq1iReq5HX6K3XJ0IbJ3qwy7q7b7Xy
	dHrsstFWtlatPlYUa5VQqeErl4lsprndadZQ5tqLEAJhjj6MBiwJ+4n4Vh6HUseAcgisJDnSq2b
	Gi7/FCegTjzXDeqo4Cgntq6eIvDEE6FMQLUJR5amQ9RL7F1q5RmcUjYhchNPeanm8v0gVKVABBP
	YkbQH0OVvmOZfLSNfNrCRjXu3+9ZikFxzY8fqkuvl3fjmTOr2PZvtWZFpualsoVKyPUFQoeIUd9
	x3Fgit1V7bjrP1pZKAioxgNg6MiMcLMttnCh+pgat/oTdfZLWTUFQlJpS4fELwE37mAdZOw==
X-Received: by 2002:a05:600c:c3db:20b0:4a1:fb0b:1c9c with SMTP id
 5b1f17b1804b1-4b78a30d10emr50205e9.10.1793988049366; Fri, 06 Nov 2026
 10:00:49 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca> <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca>
In-Reply-To: <20261106173054.GH663069@ziepe.ca>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 6 Nov 2026 10:00:35 -0800
X-Gm-Features: AclHuK8x57W7AnFw360PBbTWaHMwGgtNX68cpPd5ipqmMu4tcyLJQyWTDt3UxIA
Message-ID: <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
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

On Fri, Nov 6, 2026 at 9:31=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> > I drafted an implementation [1] for premapped TX and RX buffers on top
> > of the existing networking page_pool. It is implemented entirely in
> > the networking layer and extends page_pool as the default RX
> > allocator, to the TX path. There are no hooks in the IOMMU, DMA or
> > page allocator code. I wanted to understand if this implementation
> > correctly captured the feedback on this thread. Key components of this
> > design:
> >
> > - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but each
> > chunk is mapped once per opted-in device through the DMA API and
> > records its IOVA for each device, rather than using a shared IOVA
> > window.
> >
> > - TX: page_pool accepts a memory provider for pools that are not bound
> > to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunks
> > of their NUMA node; TCP copies sendmsg() data into them through the
> > task page_frag and allocates its skb heads from them.
> >
> > - RX: an instance of the same memory provider, sharing the chunk code,
> > backs RX queue page_pools. RX chunks of order-0 pages belong to one
> > device and NUMA node, and are shared by that device's queues on the
> > node.
> >
> > [1] https://github.com/torvalds/linux/compare/master...NamanGulati:linu=
x:netdev_dma_pool
>
> IMHO the netstack should never read from shared/decrypted memory. If
> you put it in a SKB you have to be sure the only touch after that
> point will be a DMA read from an untrusted device on the TX side
> (sending it to a trusted device would be a fail) and the final copy to
> userspace on the RX side.

That's likely a fair callout. TBH I'm not very familiar with CoCo and
will spend some time understanding the constraints. I kept CoCo out of
my implementation as I approached this solution from the overcommitted
VM problem where we are trying to overcommit memory in VMs and use
these pre-mapped pages to avoid using bounce buffers.

>
> Everything else is very security questionable.
>
> It is unclear to me how any of these page pool proposals meet that
> requirement since page pool typically provides memory that ends up
> widely used in the netstack.
>
> Jason
