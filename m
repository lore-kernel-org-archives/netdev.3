Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95C456E15
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784918028; cv=pass; b=Dya7vD2ipdfpxOBI0x5ay4mk3XjTG4hVlQzq9DtlFy3o9tsDozHdrpBXgoidXO5D1Wrh1capSQzVwev9T30Hud2hwKj9wo4FzfPtaI+Vu9a6ph+8og2cdmY1W0Bbtty+8OI9gqL1PDNN6xK53ydmoKc6v5Sed5byimMs/EOc1HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784918028; c=relaxed/simple;
	bh=nyO2WQb9heSdBUPwWL1w9fhsS5DDbwSzUZIB4XErczo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHhHPRMVwkqS6PIEmm/H/1/K3UUbzKACJ0SE2AcphNC0KxvrZT1SrFfgW13T0ekjCVypUn4q+sjnarEG6R9Ve/anpE0w16dYnTB7B8m6qiBqZ0/S4SjrfKYG4SgpyyW6TznkNQfx/Zh5kUKPWdLT5qBMDaKR/UbctalCRpJozJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ut9E4iMp; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ut9E4iMp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacef7d299so15705ad.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 11:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784918026; cv=none;
        d=google.com; s=arc-20260327;
        b=NWHr2StQ05GfMKXnCgNTWnGioZhL9BrnkWRi2dnV6POsZaZTeUfSpOrFia+ZG2sVHo
         //xDSq/Q27ETcX+iLdy+ygaRGcpsjLp7VDUidtdvjfWiGZDsaffB9K1FLcrwgGdH+LhX
         vxQYkAOX2jNhF5Pfijd7QQTsRvg6c8U4OjRjyxWp/MFU0Px5A9hK7fTHJm9OpxYpi1YI
         /Df+PDWPqwPUh7L6LTCJOBxdHX1oI/PuyrnIhv8eCYnpI9PeVa+lBJWqDIghvl4FV7LT
         eFBU/7RWhKmxRpn/QNbnkSTYK0h9vRoFgDJScOMJUnKGUXG3EWd+ipIQphwrjYalEZjy
         M2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1SxTiikWYVO7sCnmBkQJt0xYGpkxfS6HvfLOOO5nxqU=;
        fh=/QGL1yUqLigAAjFZGK85BAs3iS6J/StEtL/B5AosdPs=;
        b=AB9sL80lmH3Kkv0E1EhvmxKI4p4LXhjb1DO3rYelaa16lSRTF0OWSKJIqvUEPaHFRe
         XIBoIOvDFp8V8Hf5lz7Xx6qw3U/d4p5lvHtR8bijYp/E7jSZhE42UXfbPPscero9cTXQ
         5uQifDJl30zbugJ+mmh0WoBiN3qrIZkKpyIWDoZjymQZEoeWjUJwxgTnj9VNL5zNs63S
         LO3ow4WFpGGysQ/cvh/X412KdBnrfCGQjBsvqnshj1z/s1KaSBrWC5bnhvtCpuVVBrQu
         fCAJ/X8SowXtLSyQp5DjQZFnLwkYU2KEmKWPGD4anTY08eO4JPrWURjZ/E+hZGTvym6U
         0EFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784918026; x=1785522826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1SxTiikWYVO7sCnmBkQJt0xYGpkxfS6HvfLOOO5nxqU=;
        b=Ut9E4iMpuUXk79SGSfXDJPFhfh98XsdjsIsE66MmyO5GobtacvpvKjrlvylWPTxKKo
         RaUJkUER0hdUeJxhSaqv4b+7tSQoG4DSNtVx6ECbr/+zY20MTvIEq0IoO0Gdfrk/ryrC
         BpO+FxeUDCDLWiTXGVfDOrnOwpZuRMtUhdxnHosIxgKp6ZFy4JKky/vEWwR42ZahkRk9
         pXVrEqF8x3+RzrEgg6N6eeun5PTSHW5I61CSveVMLxWTTVpmeBwrRI03ymv1bcNnfI1+
         K327nR4t8YeaVjI8sepByplfpz/UN+9WifHoJabvekswOIeOjrv2ca0cHJzg2BHn3ySq
         3IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784918026; x=1785522826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1SxTiikWYVO7sCnmBkQJt0xYGpkxfS6HvfLOOO5nxqU=;
        b=YgApEcn9LFohI2gkgYnzmAkmVnGBFB02a8Ew6HqFRVlGTTONmxOcG3hCByNbK5vTur
         piDZd5Af8qErosTMRbLGoj+/wB4cL7tEVXyjFXOXsQLhz/rPkHzlppw4/Ae+dSPM/K2B
         n4j+oXNOh8w5PjtjaJkZL8UszpWvN7Ibzm4pnKnOQJIwJHDOdtFYPDCIuiShMyoUcAUk
         G+PLFZFEWbyoVTI7tFFpHEctHELWnI5GOd5hQpDitfnU83acmVBkISbL20gcrhoUF/FT
         joCaXBpbh+FMRPruPR5DK07Trph7sFl1ynP8WaprheE0tTAKEnqPe9OPNuG1cD6Igjjf
         JwCg==
X-Forwarded-Encrypted: i=1; AHgh+RoLUK02BiRYeXsAkFPyp6XlgYlW4pFCvP6ct8ly5Ezzq6dv6Dv/k512+wpKErufQxvPaP+0g5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDBt5XFBTCFaJGzjpcuu7j47Lr0XHs9FLqfXzMxYm6afWQPka
	ypTkRv4ycBlUDUiYzVA9KMgDYm0jZoIY1j9PnN+jGY2zkXwhO+s57duQ2kC5+4VgZf/juV+bwxX
	xxTgpyg7VYUXTPxrfM0jxfRSV/RHM/aZMWiK+qMHl
X-Gm-Gg: AR+sD117jRN89WHqvh/xue/GI8qkAgxSivwpOtQ5APDfaZpdojgG71VB/J8JP2ErHZO
	NcP+WDaJbjr3yLBj2JwWqVdaczS7pC+aM0ewKd3nwvVQawSW9NWMyt4lqoQebug90o6X6eV7vl3
	cfM63m/Af1pgZh8IwSeqDAG/2wm0UHLU722T/ATHwhbHT+2lLqn2Y4ww7ksPvoekKJHFmuOum9v
	O4MDHioLiOixS2QTttOyLMGladbFae90UmXyApfD1n78C5h3jRyd61yHoqoRHapgv3OHBwedbcq
	qAXqMyTCdtjCs0jqQd+t/xXuIQ==
X-Received: by 2002:a17:902:c40f:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2cfdb8b9655mr917835ad.1.1784918025499; Fri, 24 Jul 2026
 11:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724092135.414699-1-shaojijie@huawei.com>
In-Reply-To: <20260724092135.414699-1-shaojijie@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 24 Jul 2026 11:33:29 -0700
X-Gm-Features: AUfX_mzOBNjgkxUG2t378AeWOh7N2eFoWiWABkIjGfKQRiESjNE63Q3hNh2oMbs
Message-ID: <CAHS8izPTQ5rOXs5rfVc3tnWcaeQ8wJ1qJqSXEfboe0OTGNkLkA@mail.gmail.com>
Subject: Re: [PATCH net] net: page_pool: fix DMA index not cleared on
 xa_cmpxchg race
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, toke@redhat.com, shenjian15@huawei.com, 
	liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 2:22=E2=80=AFAM Jijie Shao <shaojijie@huawei.com> w=
rote:
>
> page_pool_release_dma_index() uses xa_cmpxchg() to atomically remove a
> page from pool->dma_mapped.  When the cmpxchg loses the race (the entry
> was already removed by a concurrent release path, e.g. page_pool_scrub()
> during page_pool_destroy()), the function returns -1 *without* clearing
> the DMA index bits stored in pp_magic.  Its caller then skips dma_unmap
> based on that -1, which is correct, but the stale DMA index bits left
> in pp_magic are wrong: the xarray entry they index no longer exists.
> A page recycled back into the pool then carries a dangling DMA index,
> and kernels that validate pp_magic in the return path surface this as
> a WARN.
>
> Move netmem_set_dma_index(netmem, 0) to execute unconditionally before
> return, so both the winner and the loser of the xa_cmpxchg race clear
> the DMA index bits.  The return value still distinguishes the two
> cases (-1 loser / 0 winner), preserving the contract that exactly one
> side performs dma_unmap.
>
> The race window opens when page_pool_destroy() runs concurrently with
> late page returns from SKBs held in per-CPU defer lists, TCP receive
> queues or GRO hashes -- e.g. a driver reconfiguring channels/ring
> depth while traffic is flowing.
>
> Observed on arm64 (7.2.0-rc1) with the hns3 driver:
>
>   WARNING: net/core/netmem_priv.h:18 at page_pool_clear_pp_info+0x20/0x38=
,
>            CPU#83: iperf/3874878
>
> Return path (CPU_B, process context, triggering the WARN).  The page
> was held in a per-CPU SKB defer list and is being released through
> tcp_recvmsg():
>
>   page_pool_clear_pp_info+0x20/0x38
>   page_pool_put_unrefed_netmem+0x11c/0x2e8
>   napi_pp_put_page+0xf0/0x120
>   skb_release_data+0x170/0x228
>   skb_attempt_defer_free+0x7c/0x1f0
>   tcp_recvmsg_locked+0x710/0x9a0
>   tcp_recvmsg+0x74/0x1c8
>   inet_recvmsg+0x2c/0xf0
>   __sys_recvfrom+0xdc/0x198
>   __arm64_sys_recvfrom+0x2c/0x48
>   invoke_syscall+0x5c/0x120
>   el0_svc_common.constprop.0+0xc8/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x34/0x1e0
>   el0t_64_sync_handler+0xa0/0xe8
>   el0t_64_sync+0x1ac/0x1b0
>
> Scrub path (CPU_A, racing with the return path, derived from code):
>
>   page_pool_destroy
>   -> page_pool_scrub
>      -> xa_for_each(dma_mapped)
>         -> __page_pool_release_netmem_dma
>            -> page_pool_release_dma_index   <- race window
>
> Debug approach and evidence:
> Reproduced with a stability test that repeatedly reconfigures the hns3
> channel count and ring depth (ethtool -L/-G) while running iperf3 with
> multiple parallel streams, then closes the iperf3 sockets to release
> the SKBs held in TCP receive queues and per-CPU defer lists.
>
> On the unmodified kernel the WARN reproduces after hours to tens of
> hours. To make the race window observable, a debugfs knob injects a
> controlled udelay() right after the winning xa_cmpxchg() in
> page_pool_release_dma_index(), widening the gap between the xarray
> entry removal and the pp_magic cleanup.  With the delay injected the
> WARN reproduces 4-5 times within about half an hour.
>
> Instrumentation added to page_pool_release_dma_index() logs the per-
> page pp_magic, DMA index, refcount and dma_addr at release time.  A
> representative log line from a WARN-triggering page:
>
>   PP_DMA_IDX: magic=3D0xdead0000000cbec0 idx=3D6525 refcnt=3D1 dma_addr=
=3D0x0
>
>   magic=3D0xdead0000000cbec0  -> PP_SIGNATURE | (6525 << shift)
>   idx=3D6525                  -> DMA index bits still set in pp_magic
>   dma_addr=3D0x0              -> scrub already did dma_unmap + cleared ad=
dr
>   refcnt=3D1                  -> inflight page, unrefed release path
>
> The combination "dma_addr =3D=3D 0 but DMA index !=3D 0" is the signature=
 of
> the race: CPU_A (scrub) won the xa_cmpxchg, performed dma_unmap and
> cleared dma_addr; CPU_B (return) lost the cmpxchg, returned -1 and
> skipped netmem_set_dma_index(0), leaving the DMA index bits stale --
> exactly the gap this fix closes.
>
> With this fix applied the WARN no longer triggers under the same
> workload (verified overnight), both with and without the debugfs
> delay knob enabled.
>
> Fixes: 95920c2ed02b ("page_pool: Fix PP_MAGIC_MASK to avoid crashing on s=
ome 32-bit arches")
> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them wh=
en destroying the pool")
> Assisted-by: OhMyOpenCode:GLM-5.2
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

If at all possible, when generating fixes via LLMs, spend time
reviewing the patch yourself before sending to make sure the patch
makes sense. In this case, I was taken back that this 10+, 3- fix came
with such a huge huge commit message.

I did not review my self but my LLM - which does not tire in reading
the long commit message - came up with this review. It looks like it
may be correct. I think the fact that we do not touch the netmem at
all if we lose the race is intentional, because the netmem may not be
allocated:

```
  While this fixes the WARN_ON_ONCE, it introduces a critical
Use-After-Free (UAF) and memory corruption bug in the scrub path.

  page_pool_scrub() iterates over pool->dma_mapped without holding a
reference to the page. If the scrub path races with the normal unref
path and wins xa_cmpxchg(), the unref path will proceed to free the
page.

  If the scrub path is preempted immediately after xa_cmpxchg(), the
page will be freed before the scrub path can continue. When the scrub
path resumes, it will execute your new netmem_set_dma_index(netmem,
0), read the dma_addr,
  and clear it=E2=80=94all on a freed page that may now belong to another
subsystem. This will corrupt memory and unmap garbage DMA addresses.

  To safely fix this:

  1. __page_pool_release_netmem_dma() must cache dma_addr to a local
variable before calling xa_cmpxchg().
  2. The scrub path (winner) must not touch netmem after a successful
xa_cmpxchg().
  3. The unref path (loser), which safely holds the page reference,
should handle clearing the DMA index and dma_addr to satisfy the WARN,
regardless of the race outcome.
```

--=20
Thanks,
Mina
