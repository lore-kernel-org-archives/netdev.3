Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0284470422
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787142468; cv=pass; b=Hw66HlXHU+cIYDvJRo0cO6COnaRW5FAnsWa1bf9j1TudZL2jXMBdlc1mreDpTRuY1vFpxPaTcnKYH1fL1u7XOCd6VtAZOWvGBdXEgBjSINhLlZpoM5ed9D8ETZrgGsVRj8KcVB35BEPqEbh2PXHcFJf/hSxsR/egx6o8yCJ2s9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787142468; c=relaxed/simple;
	bh=y5EQ9oTQRTQLECZL7FM6kzfKeajJ+yOzeubZW/1l9p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hG1iVlJrhZZ2pSPRbYyemgmYzwM0Wqmr1WkBeUDPTtBgD0y1SEjd1X5ANPhi9hCmh2O6y3ElG2WQhl7M9Lsa2OtzjnyyJGuPAPrXktM7DCf9DsrdI8crh0H7ukf9wFfe6gir3+frhunJTutVdfY0aXa9s0QWDAXP89JiFJHJqpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz/wl3+f; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz/wl3+f"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c20fb91ed0fso145277766b.3
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 05:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787142465; cv=none;
        d=google.com; s=arc-20260327;
        b=Bj8+cmjh+MpZmrGfz/d/bOkzGHOdZSMiIFcbQmDMA7B4Rcr8M6z38ZmIZQvTRxlIE5
         lR2anIurGBD7R4feELN/FdO4tPqK17tITqm1z1KQyIOwhoHUIvCflw4U/BuQPrJlH1/5
         c76XCvUeMUWOVR7vCPPz+FBgnKKWgHxGB0+sP0hAFluBKkQOsbJkIjuZl3rK2HtF/Hip
         XqCIsq6Ul1HTxo0zfDakqOCrd1oDtKWRrSXsETfR43Aj6YBRjkRdo30jdM4J7MX+COOF
         F3F9168cBdOKjZZy1kvRmGe6TOZyEt79JSnaC0sMjVsPsjEInYoQ/9wrnEPnlfBIQ+IM
         4T5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLw7yk5kNbZMeTw+UMLOAwK7lyRv1aw53p64YFqkg7g=;
        fh=d5bOL0GeHyVtepyY3nki5+7UVBHkCqjo+KZlUeQCTHA=;
        b=WBvHgwzD+uo5cQ1qEdc5FPPqJG5ISKMTvitAwfRSFq0QvKISYq5XR7RNTu56c7/YW1
         uWzCv+7TwPIzNJpiN2puw88UDtaoDbCLX6AG6u4bVh+ekScm6E4Z3sqibT/P+KaOfL3R
         eiMU6F1StHfcasVQsXzvO4iLKulxf9yvy2ixNCb3ynNuq/ZwPyvlEnp8XqEgpiFBFJ8M
         q26auAmSWRww+KD2G4mE5ZImB5aiZ4Z6+x94/6J7vQT/KTo1W+QwjBczqb6Waxz89SGD
         KbtF7D41NmMefNH6jmWtlLeb8Wzy7sjw9t1KEGYjtSNQwqx7UlV1QJhT6D0EyUtlJXUk
         pQBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787142465; x=1787747265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLw7yk5kNbZMeTw+UMLOAwK7lyRv1aw53p64YFqkg7g=;
        b=hz/wl3+fctMlBdi/datPxrfDp+A1ShBdiJTad2QncJMSBZxgvJ5XRpYArCrgYB31gT
         RTAep4BTK8dVeqMHaOWCxhdXGmAoYfLPS3+QIkaFxj/E5QBvvHOffQNcAjeqorfh+B/a
         pSThbeGvAxweG73XsObgo4KSYAeaHMc36N+IaHnPmPc5Xvif4/xSV7e3mFAmk3UVr5fL
         avGSAUODaZgCZ0DsKgpGe453MbCB4YEpmyCcpQBzhYaeE4/3TRaQs5v0XuRR7aCmVNqK
         kgHd+5YSZ9FIZ51jtKQOacWCD6G+y4pqsYV1erY+94wgVbeBgX5BJ8X2p1zkXNKHHTyv
         B6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787142465; x=1787747265;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLw7yk5kNbZMeTw+UMLOAwK7lyRv1aw53p64YFqkg7g=;
        b=POWRZEWla98NbCctMTVtn/Knyt0ap2UKU8q2ESK7jbHgus4b7b6Trs+57aewWcumqZ
         3ykz/lXo18m4h9yO7UysLqv+wjFOlEr0XFnROl8BOo8qY1LC4zlEIoxiOe2Mixj8m2tH
         bk03XJTEuFw1d3YbQVVxFGHSDeOqWJsbJA2UfvMVCLUsvRun26/cCAH6FOzST/e0hXl6
         qEVd9DAbBjNCISrxPPg7fY8sI/RSlRGZ1SKxjBGlsfYmrscc2cGf7EjoaGHd/xO5zcoO
         DL6gX94QWIGTEHsMkQ1FWO253QqbvXuQWFs3N7jHbzn/OrDRuvTFQtB1DlKRg6qcVRJE
         MAWA==
X-Gm-Message-State: AOJu0YzjvqCd8VcK+w2M29ErtFuct5qAdnsMZPO5+eQwlqBEh3C/tGvI
	nLh0sq9rFyvuc2WxODt8DeRIrjTxRGMPrARl0NgMxCRx/VwwER9HUWVntrspLPRamHWvxu4qfKR
	2R5GMrBQ0zCUtr/9eungNWZsy4XGdE3Y=
X-Gm-Gg: AR+sD13R0oRWCFKdjEaEhCdEBjEZDD7WHWeKXamR0Npv7kNLCwLU6r0cnSGT1H+94hZ
	zmgGsLPmKT90VPHSYBKO2PGRI3ogw9/rty5aJC5fmoUdEpxaekKeIi+GaN9d73uQDNHIBAmRTcu
	MI9HUJKKTaP7EMu31UNWwSHhgK2JfCYDlu6ihK9GE9MXvsyhMGjtBm+1rXuoKQfhK3FtTte8Ete
	VzfqhXsEBrBCMc+mRsxErH3BJS4HDduxR9ubk4Fr4xrMu76g3z1JUs2PKlH2rUP74JVljnoVmyE
	9euVt9sg3ivFitIN+yu0DIYRxMcJQ5J2uSPCASrThQ1Mc/BXZ//t0J0wLEtCZsPO5gNsIEo4jMK
	9aDciuoigb940rkv9A6dom7CH/KNHNg==
X-Received: by 2002:a17:907:a892:b0:c1c:5c90:1bb0 with SMTP id
 a640c23a62f3a-c23f92d6210mr244553366b.8.1787142464393; Wed, 19 Aug 2026
 05:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817090601.1256389-1-pawlik.dan@gmail.com>
 <20260817161756.5fd2185a@kernel.org> <CALC2Apj7rQv=6uUqaqBjfJ9yO+VCddQqHB=yDhXH7+QUCh2JyA@mail.gmail.com>
 <20260818082933.28b5c9d1@kernel.org>
In-Reply-To: <20260818082933.28b5c9d1@kernel.org>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Wed, 19 Aug 2026 14:27:33 +0200
X-Gm-Features: AcwNN1VrJEfvg5ZvmKtuPToUsD-4XONBWJ61vlul_aZ3nC7ZUbLE5WyISNTim7I
Message-ID: <CALC2Apj-KLB5CVbSvoZWvA4Oan7dmAerK=VP7W86jmErWW8OdQ@mail.gmail.com>
Subject: Re: [PATCH v8] net: airoha: npu: use cacheline-sized buffers for
 mailbox DMA
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, win847@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I instrumented airoha_npu_send_msg() on EN7581 (Gemtek W1700K) with
DMA_BIDIRECTIONAL and the original unaligned 24-byte payload. Here is
what I found.

1) Every dma_map_single() call lands in swiotlb bounce buffers.
   The driver only calls dma_set_coherent_mask(DMA_BIT_MASK(32)) at
   probe but never calls dma_set_mask(). On this non-coherent ARM64
   platform that appears to force all streaming DMA through swiotlb.

2) The NPU permanently hangs after ~41 mailbox calls.
   The first 41 PPE SRAM-init calls succeed (mbox_status=3D0x7, ~10ms
   each). Starting at the 42nd, the NPU never sets the DONE bit =E2=80=94
   every subsequent call times out at 100ms (ret=3D-110,
   mbox_status=3D0x1), including the WLAN version query that triggers
   the "failed getting NPU fw version" probe failure.

3) Response data is never synced back through the bounce buffer.
   post-sync and post-unmap hex dumps are byte-identical to pre-map
   for both successful and timed-out calls.

4) Buffer pointer is 64-byte aligned (p_aligned=3D1), size is 24
   (sub-cacheline, cache_align=3D64). The swiotlb slot size is 2048,
   so the bounce buffer itself is always page-aligned.

5) dma_alloc_coherent mappings (shown by DMA-API debug dump) map
   P=3D=3DD at addresses around 0x91xxxxxx, bypassing swiotlb entirely.
   The mailbox works reliably through that path.

Representative trace (last success / first failure):

  [19.541] func_id=3D0 p=3D...dfc0 size=3D24 cache_align=3D64 p_aligned=3D1
  [19.545] mapped: dma=3D0xff765000 dma_aligned=3D1 is_swiotlb=3D1
  [19.541] mbox done: ret=3D0 mbox_status=3D0x7      <-- last success

  [19.588] func_id=3D0 p=3D...dfc0 size=3D24 cache_align=3D64 p_aligned=3D1
  [19.618] mapped: dma=3D0xff765800 dma_aligned=3D1 is_swiotlb=3D1
  [19.728] mbox done: ret=3D-110 mbox_status=3D0x1    <-- first timeout
  (all subsequent calls also timeout, NPU never recovers)

My working theory is that the missing dma_set_mask() is the root cause.
Without it the kernel bounces every streaming mapping through swiotlb,
and either the bounce-buffer sync path on this non-coherent platform
has a bug with sub-cacheline transfers, or the NPU firmware cannot
handle the latency/address-range change that bouncing introduces.

I plan to test next with dma_set_mask_and_coherent(DMA_BIT_MASK(32))
to see whether that eliminates the swiotlb bounce and restores the
mailbox. If it does, that narrows the bug to either the swiotlb sync
implementation or the platform DMA ops for non-coherent devices.

Debug instrumentation patch (applied on top of OpenWrt's 6.18.44):
https://github.com/openwrt/openwrt/commit/13ea79d9a411dc497882e820e4c881443=
457bd97

Full dmesg from the instrumented boot:
https://gist.github.com/danpawlik/b351e8a06218a3aaf68a2cb31a32ea8f

Thanks for help,
Dan


wt., 18 sie 2026 o 17:29 Jakub Kicinski <kuba@kernel.org> napisa=C5=82(a):
>
> On Tue, 18 Aug 2026 08:23:33 +0200 Daniel Pawlik wrote:
> > v8 does not switch to coherent DMA; it only rounds up mailbox payload
> > allocations (dma_get_cache_alignment() in v9) and maps the same rounded
> > length with DMA_BIDIRECTIONAL, while the mailbox length register still
> > uses the original payload size. On this board, mapping only the payload
> > size regresses probe back to 0.0 even with the larger allocation, so th=
e
> > rounded map length seems required here.
>
> Please trace into the dma API implementation on this platform where the
> alignment makes a difference. The "unaligned length" path must be buggy.
> We should fix it there, not in all the drivers (my concern being that
> this is not the only driver that hits the issue).



--
Z powa=C5=BCaniem,
Daniel Pawlik
