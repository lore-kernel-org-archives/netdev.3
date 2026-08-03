Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4388D42E8F4
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783200; cv=pass; b=AX/5ddHuJJtfJpBwv/uujXfruABeTyxQAOxY0YiP6A3eBzsyNEcAcMqxpk05QaOwyB2xjt++aL5t+FfhJ7teDIa+P965wglsEUd0CIEGSFfQrVxI5hidzSkwe9RmirmklXETrnFY8iQT3njViR+uH0CgLSkHRdvkqSoD8z+Jj7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783200; c=relaxed/simple;
	bh=d1GdJzffowGAnX7SgkQLsLTnYKo3xtqP/dyMoi66AaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OInqkuLJrbMmGW7UUg8d7UINrgICisCNFMbbCUrBwEmYmKYSoNSGQ9pfPrRnEmRpMIZqL0KINRqpXFxkUe+R7YhhcUycNvN04Skjr0rd4EiH2hjga7xy847tIJ4oZZEISuWXAlwsKMYCug6nn2nA9u+RQDY2l3ZneRp1h3pSwZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAreKfbx; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAreKfbx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdf36f63dso29365ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785783198; cv=none;
        d=google.com; s=arc-20260327;
        b=n93OSfHdQfpPn9irMNun73zfG/hdMAauF/Bf0z3WbbM9nZYNgV5u83yEy7OhgDOUjg
         GoP1XAACwvlfcoQ8mHAMqEnGC2jwLD89uM59w8eGSs3SSQY4D/1hHieLwFNzvrTEg8ml
         9RHj7JO7U56H+2ExROQA8boYllFS58zbpTIRj0EVNgCKnKnwDllWxXqHXx0XPI3AQ6rf
         7KQnObeBr8akoaRCnUL8GQDxXuFtu7XHYyf+SjOl78GiJBMvw92ug4NS79X0EHChzpNN
         PKG7gknbVlDcimzRN+41jmSL0LuYvIvqBf0IFA5e6TO9dkGDgi+6TmBJwZ0gKr7BuyAs
         META==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YEGYHAhaI5Y4Bh50/L1Jde5LSR6VhkVNUjGLHvvRFMg=;
        fh=DcgEIyTaXtgUmagKo2rAT1NkxpYhFWczbYZkg7dlTcs=;
        b=sytAe4C05Vb5cmFANnxPKO73nIryDIfUxQBnntadqAfYUUom4o9sOmcUT6GzMm13iL
         hnJ4r5RLjPD3Y3cg5QXBwZR27Hu/gf5NSO8pFMXbBSE6aeCJhWnuc6gzZNjGXz7gSr93
         DEk1Mkg1CVZWL2BcqslvtDKmWHjK+XfO5kyAPfjcbeNNbDLJTv0VPQcBJ4+jQGFzgAvm
         gOtD0uF8s8uPUnItnibhTIExxnm1QcPAdLcsTSE7juYpErEpFLYO3RXa1c6pXBSQZq4Y
         U6Uo50bj9vmbTUCyCSUNLECysBsRwfk3/xMDzSg4aKi1FG5f84nHhxjCNC0rBXhwuIWn
         T+rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785783198; x=1786387998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YEGYHAhaI5Y4Bh50/L1Jde5LSR6VhkVNUjGLHvvRFMg=;
        b=cAreKfbx24pEd9QkWLjY2iIsA0X8yGOoCWK6phpeKAJOIBUUvuC9GzezY06m5ClYwj
         7QuSB17MySUupo2bLoeYmVweNa/uNQNEqw+PNnK43YyXgLKrKG1K/l3g6TLAu/Gkt05F
         /C3cmIDHHFEMa1gvP3I26SI0AoLwIlgW5ODyGYI3UzBzB/CYs2a3u1hicmny74gzwDst
         POm2yDv72h/69n82VUFVNMDpCW/cRhCvddXTRuEPIyQkcc76jUgKycyPxOpcrxTDvMk8
         Cqq0+5XGOEojPOpe18EqqlCEwJ/3ZON8EIzPKYsQCPrdoUkKG6NjCZFBFeAuPhOOoKig
         QVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785783198; x=1786387998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YEGYHAhaI5Y4Bh50/L1Jde5LSR6VhkVNUjGLHvvRFMg=;
        b=G/2TE5OCiUmSUIiyAfVhfuIxrL7aXeki/Ej6xRMqVmuxmlfMPiX0Liz7kHDjXC0td2
         o/NHDa6JaM40J6TSzYerzf9CVlP2+WZ5ND5XLYTfD02aNb6oBw4n2AZIC6Sgi2PDFzTX
         y/BJEb3urhjvBF2o9aZRIDY3j0b5NihNPLwbssm9RYLpduzqJySzC+hGWDrdfDi8cbpq
         GcY5rFQYcpBlBAfOOwk65RjVlY+3eHTm9p/UC9lKATgXckeOKBHSnMnLZHTnxDUGUSPY
         CNU4kdb8jDfIHAl+4fNjfq9E1rRpHL3P0h8UykBsxmhafmS3rPyijGF1xRM5+ItxABNx
         lR6g==
X-Gm-Message-State: AOJu0Yw3ogRxfP5woZRhs/gCgs0zqLz19aPZadHCbU+ErECPlNTfjpz8
	is+7goSUcrHY9DF/VwBCvLcIXLyT1TlQFASkbZO3zWoPIydhIpKb26XAUU9bSPMNrRlcKVRWaQd
	zpf/gKllsxr4B2aQDkokFvfWa9xvQyHyvXYYR8AS0
X-Gm-Gg: AR+sD12K+echGz5EAIDqOrr5IRtjJM4q2tqrno1vir4UnGsOAM30jgn2bLTeRBcHXrb
	XufiNKFCnGfRq6wbKmUsF3lxDxtEzNZqkFDbZYsjQpAoYMtn/mPLjXC4k6Lb0gbZwsCaPgR3VLi
	pjp/MFN0jqZTYbVPpTIngbF/z+8yDz+/MilUjfb8FF8uTAk2jLWXY6A8ekpjzBeltOhClP3o242
	1mTcwXw6sggOmzPG7zQz/f6Em76U3O6rWSWcJ4Iuz1Fv8kxKxD58zSE229wbExKKGc+n7B7Y6YI
	XEdR4PfCrRjtN0byzVF5BT7CUdYnSgJkv5PKFtSHph1ybcrkfqmATo8=
X-Received: by 2002:a17:902:d60f:b0:2ca:be81:b469 with SMTP id
 d9443c01a7336-2d08c64e00bmr2176265ad.0.1785783197790; Mon, 03 Aug 2026
 11:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803070513.4657-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260803070513.4657-3-muhammad.nazim.amirul.nazle.asmade@altera.com> <CAHS8izN1mCBH5=ERy9OKaeC4Wz2-v2N2oGDW34P=ZoS7oo2aOw@mail.gmail.com>
In-Reply-To: <CAHS8izN1mCBH5=ERy9OKaeC4Wz2-v2N2oGDW34P=ZoS7oo2aOw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Aug 2026 11:53:05 -0700
X-Gm-Features: AUfX_mxKt7Hw3ljuyeXscU2rYJEdlvkjRCcwEfsOQmBdLq4h2KD5KKl3NZxDn60
Message-ID: <CAHS8izO_wq4GRmbej=A0zQymB+mBrruD8zGtS5Afa2OGuSN9Qw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: stmmac: Use pagepool instead of
 streaming buffers for Tx
To: muhammad.nazim.amirul.nazle.asmade@altera.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, dinguyen@kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, 
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:39=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Mon, Aug 3, 2026 at 12:08=E2=80=AFAM
> <muhammad.nazim.amirul.nazle.asmade@altera.com> wrote:
> >
> > From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> >
> > Use page pool buffers instead of streaming skb buffers in stmmac_xmit
> > when snps,pagepool-tx-buf-quirk is enabled. As page pool buffers are
> > recycled, the overhead of dma map/unmap for each transmit can be
> > avoided. There is a trade-off of copying from the skb into the page
> > pool buffer, but this helps where the copy is cheaper than dma
> > map/unmap (for example with IOMMU invalidate cost).
> >
> > Currently page pool buffers are only used for single-fragment transmit
> > in the non-TSO path.
> >
> > Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.=
com>
>
> Whoa!
>
> I haven't looked at the patch deeply to be honest, but using the
> page-pool for tx is a bit interesting. There is no other code that
> uses it like that I think. I can't think of any blockers off the top
> of my head, but I think there are places where we keep a global list
> of created page_pools on the system/netdev and the code parses those
> lists may be assuming it's a normal page-pool, which is a pp used for
> rx and attached to the an rx queue.
>
> Just Ccing the maintainers of pp to know about this use case. I can't
> think of issues again, but I wonder if a more-expert has thoughts.
>

Ah, yes, gemini reminded me of the most critical bit. The page_pool
actually doesn't do concurrency checks on allocation because it
assumes allocations only-ever come from the napi, and can't race with
allocations coming from another napi. Does your patch account for that
somehow? Or can allocations in tx come from multiple cpus in parallel?

Full feedback:

```
  ### 1. Concurrency & Memory Corruption (The Lockless Fast-Path)

  page_pool allocations (page_pool_alloc_pages()) are lockless in the
fast path (pool->alloc cache). They inherently assume exactly one
allocator context (which natively maps to a single
  RX NAPI softirq).
  If this driver allows multiple CPUs to concurrently enter the TX
routine and allocate from the same page_pool, the lockless cache will
immediately corrupt. To use it in TX, they must
  guarantee:

  =E2=80=A2 They allocate 1 dedicated page_pool per TX ring.
  =E2=80=A2 The TX ring is strictly protected by a spinlock (e.g.
__netif_tx_lock) during all allocations, or they are utilizing strict
CPU-bound XPS.

  ### 2. Slow-Path Contention (ptr_ring Thrashing)

  Even if the locking is safe, performance will likely tank due to
NAPI mismatches.
  page_pool keeps its speed because pages freed by the NAPI context
are dropped directly back into the lockless alloc array. If a page is
freed by a remote CPU or an unbound context, it
  falls back to a spinlock-protected ptr_ring.
  In a TX flow, if CPU A injects the packet (ndo_start_xmit) but CPU B
handles the hardware TX-completion IRQ, CPU B will constantly push
pages into the locked ptr_ring, and CPU A will
  constantly pull from it. You lose all the lockless benefits of
page_pool and just burn cycles on cross-CPU spinlocks.

  ### 3. Memory Waste (Page Splitting)

  TX injections are usually small (e.g., bouncing a fragmented
header). page_pool allocates strictly in PAGE_SIZE chunks unless you
heavily orchestrate page_pool_alloc_frag(). Standard
  SLUB kmalloc() or skb_alloc() is almost always cheaper, more memory
efficient, and more cache-friendly for TX bounce-buffers than spinning
up dedicated page pools.

  TL;DR: Unless the TX allocations and the TX completions are strictly
pinned to the identical NAPI context/CPU, and they are allocating
massive buffers, throwing page_pool at the TX
  path usually results in lock contention and memory inefficiency.
They are almost certainly better off using standard kernel allocators,
or at minimum mapping DMA_TO_DEVICE correctly
  over standard per-CPU locked pools.
```

--=20
Thanks,
Mina
