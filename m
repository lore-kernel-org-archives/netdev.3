Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3D2459E1
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214024; cv=pass; b=obhIEHP+My6c326KIH7ijymn967RN7rg8YrcRHUBEW4uMPkCMtg9/g3cYubcfN5soIuUfweML6PWW3vSMpE39x1xbB1/g1o7Cdb3CFA2KhSxy4r4JqyuugiHWzVgEL0SYEkRBiNm4/MDeuRBkT9o32E5zVpvPSmETFb7cb1a5xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214024; c=relaxed/simple;
	bh=hhTzucVDroCcD7bmbulLMk7B6vxZMAce2WXgBbNlfU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgryl33dJ0jJN7LATFaQkO0EtlZtrEzI0w6N8Tx4Hza71tjDh0goOvg4CejmlYjT5U37beO88oT1749Mmly+2f64xV3WDK/7uvyI4p7NVWHQXii9AMMGWdgrNCDdjwpIkM2QjMLXzi8Jq5AP4ZK/AOt4dQ8gZT81CQFzy3Rhm3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuAIr/4q; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuAIr/4q"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so3272322a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 01:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787214021; cv=none;
        d=google.com; s=arc-20260327;
        b=gigEfi8deYZ6fxLyBx987noSquunP+HXr60Zz48RJ5w7ewJ36dEKohmpizIrwqGcHv
         cXqfcYBSTs5r31H2e/xw4B+8xn91rm3ynWk9z3aev/sA1bzEiO2w9wpWnD78SN2idkpq
         HwxvxEitv0Zua838eIOm4FqhzXW4CvFqr043UZbeYNBS8fnTnZQi/YLDAU+FQ8Xc6nkN
         TR2SzmMIodAQ2SGX2nqnITRXWqchP36sGwv1zsz6/2Tq2Re9u5alhMiGPEMQJBCkJLOj
         ROJbr2jcB+nsukhKdX6Lga4ftvRAWV20/TXsXzbKfRR82VNqRvvZzdYlEFuPXSSnqYBa
         4IZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MGbsiYWGWZERk5A0Z+rH6uIB88SmPGF9IbaUDZNWXi4=;
        fh=d5bOL0GeHyVtepyY3nki5+7UVBHkCqjo+KZlUeQCTHA=;
        b=Kqo0UQobY6ECQtfnqXDPecuOfASUTSq/ARlrSUCoJZtJBidnvCBsJuMtZbHngh2Fvl
         mgNU3cimj5D2d5r3GS7FfoRmYivzM9WYU1vEKcS2OxE91K2dWwUDGMy2DbmWEVRr69ra
         AQvn7/odu7kYK+mE2m6X2NbvgVANkhHwRp/HdEsSz/OQh2VLxXOpPvcN6VI59VPZ1lU4
         hruTCycUWk6H6kyp8F9b03KVOtDwLSUHSNf4JZbyfYZ3U71vcOtN9RWptOrpxfk8vDjI
         ME+rBolDQ6USxIWZ2VuJKntbd8uoIaamn/IBpbD0iXQ3VZ46+oLnACvfLAd7wmnmU/lD
         enlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787214021; x=1787818821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MGbsiYWGWZERk5A0Z+rH6uIB88SmPGF9IbaUDZNWXi4=;
        b=UuAIr/4qj/aoU+W57D5zR9yAd3be89AmSmP+6KbngI2djhb97pbJ7N8239r9K9O9yE
         cZZtoS72eBNf+KLGPrGzPuq5RG05svZIGF4SqgF7a/xsFrWmbNIz03/o82bn8pnQaMNZ
         qSxZnZHZcWICuMfeSXaRJSA2BvFpgd2OSVhZDObtrOigBgWksoetwzXTw8OycPNiZefz
         QdjJtxTkusuuXR7UjusNP9I8tt3lawKKypwOMVg21EC04yftdYM6sfQOErTgyY2bKyO/
         ObKKeqcBQFTeXlaRSIrHB2j7bkinUOVHUCYiU4rqhRCPRkkGx+/8D+kIjGNRnQ5TyNFO
         B9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787214021; x=1787818821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGbsiYWGWZERk5A0Z+rH6uIB88SmPGF9IbaUDZNWXi4=;
        b=Fj2qSu/z2AlTkwF7edzeBrquhQrfGcYBzUQesQgx+JzzpdaxkFXTEwaCtJhbxakDFL
         TZihsPCIploI4MYQQJcDAAc8rFNt/7H6DSZW/KfGA4IyjTgEaF4J7IZaVE8KQUPdDWI3
         0zzaXLm5i4xAh9hlhu32cUfDmtLbuxZCAyg5DsnR2MsrzZvskgvZR5ZgypV5dlwgdAAx
         ZIRaH1PJ9ECOQyPlCdTCrHmzpfzG17N+l/Wy1JVX0+15GpH1pE0QWPG3XrRVAArRi0Cp
         WDxzR+ZnjCfCSbtH8bUNUNabeD5n/gQwW0UqbPpqjcW9KBtQJLldM/yaBIy3tb4ADMu/
         ccbw==
X-Gm-Message-State: AFuF++mFLEiC1P9yxOT+lI/6sxuaH3df21BS51R/xynzMNgQ7KjOSRzC
	M6fgfBNKz73BSSbpCZ+GqiTS33Ycguu81QBi40yi6QPY82nlN9IEHDrCn4mGwhyYJPQi1QGdJdd
	hAH3ePvYN8TG/dBkZBYM5MewGn5A9hZ4=
X-Gm-Gg: AR+sD11YbDOiByea8t+4mj5ZZvIIf5P22WAsKoApSThFh5CHDcgFOejye+Tnkf+r/Zp
	gXY1rs+ox/lVH9pB9DHMhTBs6L9bv4Qa+wsV1t8qnPAZjpJ2x6PDeSnjhxKLG7cy1Uu8whtdDV5
	DE60EdwNvoi82N1ujYke7gif9ne2ks2Bdm5NBeyd0iHzOKVg+x3leVIX3ahoNDpZauWrNK7M56T
	yTfT9HU+UT7coJJohyMTQyl7Yl3A9H7uHZU8/GGxgP54bpPPYB+OsOxa0JfJbYcZseN2nOONnpd
	sU4hjuVHozLyqWgYwHeqpcowmAasqdVDTPh8j4hJ4WvnY9RFinGSIsBRf0GeU5vO8UMhgyTQSW8
	olj1SgoOJe6WFGLrjujvBCIGraEpqIA==
X-Received: by 2002:a05:6402:5020:b0:6a3:6c99:a5b6 with SMTP id
 4fb4d7f45d1cf-6a40330f52dmr3829731a12.14.1787214020549; Thu, 20 Aug 2026
 01:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817090601.1256389-1-pawlik.dan@gmail.com>
 <20260817161756.5fd2185a@kernel.org> <CALC2Apj7rQv=6uUqaqBjfJ9yO+VCddQqHB=yDhXH7+QUCh2JyA@mail.gmail.com>
 <20260818082933.28b5c9d1@kernel.org> <CALC2Apj-KLB5CVbSvoZWvA4Oan7dmAerK=VP7W86jmErWW8OdQ@mail.gmail.com>
In-Reply-To: <CALC2Apj-KLB5CVbSvoZWvA4Oan7dmAerK=VP7W86jmErWW8OdQ@mail.gmail.com>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Thu, 20 Aug 2026 10:20:08 +0200
X-Gm-Features: AcwNN1UAbW5mRoslcDJeKuGMNRJBvfUzgrdSLmsEfPXWjGmdPxSxk5a_KsgHoA8
Message-ID: <CALC2ApiCSY8DkVpd7puTssbJZMWBHGVtFCnG66fiK0PX7-u3Hw@mail.gmail.com>
Subject: Re: [PATCH v8] net: airoha: npu: use cacheline-sized buffers for
 mailbox DMA
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, win847@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

TL;DR: The kernel forces swiotlb bounce for sub-cacheline-sized DMA on
non-coherent ARM64. The EN7581 NPU cannot write to the swiotlb bounce
buffer region. Cache-line-aligned buffers bypass swiotlb entirely and
streaming DMA works =E2=80=94 NPU version reads 0.1111, WiFi fully function=
al.

Test progression (EN7581 / Gemtek W1700K, kernel 6.18, cache_align=3D64):

Boot 1 - stock (dma_set_coherent_mask only):
  91/91 swiotlb bounce, NPU hangs after ~41 calls, version 0.0

Boot 2 - + dma_set_mask_and_coherent(DMA_BIT_MASK(32)):
  Still 91/91 swiotlb. Hang gone (all 116 succeed), version still 0.0.
  Bounce-direct read via phys_to_virt matches pre-map =E2=80=94 NPU never w=
rote.

Boot 3 - + dcache_inval_poc before bounce read:
  Bounce buffer still matches pre-map after cache invalidation.
  Rules out CPU cache =E2=80=94 NPU genuinely never writes to bounce region=
.

Boot 4 - + phys/mask logging:
  dma_mask=3D0xffffffff, phys fits. size=3D24 fails IS_ALIGNED(size, 64)
  in dma_direct_map_page() =E2=80=94 this is why swiotlb is forced.

Boot 5 - kmalloc(ALIGN(size, 64), GFP_KERNEL):
  is_swiotlb=3D0 on all 169 mappings. Version 0.1111. 0 timeouts.
  mt7996e firmware loaded, WiFi works.

  Version query (size=3D12):
    pre-map:    30 00 00 00 0a 00 00 00 00 00 00 00
    post-unmap: 30 00 00 00 0a 00 00 00 57 04 00 00
    Bytes 8-11 now contain response data (always zeros in boots 1-4).

Root cause:

dma_direct_map_page() forces swiotlb when:

  !dev_is_dma_coherent(dev) &&
  !IS_ALIGNED(phys | size, dma_get_cache_alignment())

size=3D24 < cache_line=3D64 fails this regardless of address alignment.
The swiotlb sync code itself is fine, but the NPU cannot DMA-write to
the bounce buffer address range (it reads commands fine, never writes
responses back). This is probably an EN7581 platform limitation.

Testing a fix:

Align the mailbox DMA buffer to cache line size:

  aligned_size =3D ALIGN(size, dma_get_cache_alignment());
  dma_buf =3D kmalloc(aligned_size, GFP_KERNEL);
  dma_map_single(dev, dma_buf, aligned_size, DMA_BIDIRECTIONAL);

This keeps streaming DMA, eliminates swiotlb, and works. The separate
dma_set_mask_and_coherent() fix is still needed (fixes hang after ~41
calls) but alone does not prevent bounce =E2=80=94 the sub-cacheline size
triggers it regardless of mask.

Debug commit:
https://github.com/openwrt/openwrt/commit/c9363b2597528eb3badef3bb04608c0d2=
1c81b6f

Boot 5 dmesg available if needed.

Regards,
Dan

=C5=9Br., 19 sie 2026 o 14:27 Daniel Pawlik <pawlik.dan@gmail.com> napisa=
=C5=82(a):
>
> Hi,
>
> I instrumented airoha_npu_send_msg() on EN7581 (Gemtek W1700K) with
> DMA_BIDIRECTIONAL and the original unaligned 24-byte payload. Here is
> what I found.
>
> 1) Every dma_map_single() call lands in swiotlb bounce buffers.
>    The driver only calls dma_set_coherent_mask(DMA_BIT_MASK(32)) at
>    probe but never calls dma_set_mask(). On this non-coherent ARM64
>    platform that appears to force all streaming DMA through swiotlb.
>
> 2) The NPU permanently hangs after ~41 mailbox calls.
>    The first 41 PPE SRAM-init calls succeed (mbox_status=3D0x7, ~10ms
>    each). Starting at the 42nd, the NPU never sets the DONE bit =E2=80=94
>    every subsequent call times out at 100ms (ret=3D-110,
>    mbox_status=3D0x1), including the WLAN version query that triggers
>    the "failed getting NPU fw version" probe failure.
>
> 3) Response data is never synced back through the bounce buffer.
>    post-sync and post-unmap hex dumps are byte-identical to pre-map
>    for both successful and timed-out calls.
>
> 4) Buffer pointer is 64-byte aligned (p_aligned=3D1), size is 24
>    (sub-cacheline, cache_align=3D64). The swiotlb slot size is 2048,
>    so the bounce buffer itself is always page-aligned.
>
> 5) dma_alloc_coherent mappings (shown by DMA-API debug dump) map
>    P=3D=3DD at addresses around 0x91xxxxxx, bypassing swiotlb entirely.
>    The mailbox works reliably through that path.
>
> Representative trace (last success / first failure):
>
>   [19.541] func_id=3D0 p=3D...dfc0 size=3D24 cache_align=3D64 p_aligned=
=3D1
>   [19.545] mapped: dma=3D0xff765000 dma_aligned=3D1 is_swiotlb=3D1
>   [19.541] mbox done: ret=3D0 mbox_status=3D0x7      <-- last success
>
>   [19.588] func_id=3D0 p=3D...dfc0 size=3D24 cache_align=3D64 p_aligned=
=3D1
>   [19.618] mapped: dma=3D0xff765800 dma_aligned=3D1 is_swiotlb=3D1
>   [19.728] mbox done: ret=3D-110 mbox_status=3D0x1    <-- first timeout
>   (all subsequent calls also timeout, NPU never recovers)
>
> My working theory is that the missing dma_set_mask() is the root cause.
> Without it the kernel bounces every streaming mapping through swiotlb,
> and either the bounce-buffer sync path on this non-coherent platform
> has a bug with sub-cacheline transfers, or the NPU firmware cannot
> handle the latency/address-range change that bouncing introduces.
>
> I plan to test next with dma_set_mask_and_coherent(DMA_BIT_MASK(32))
> to see whether that eliminates the swiotlb bounce and restores the
> mailbox. If it does, that narrows the bug to either the swiotlb sync
> implementation or the platform DMA ops for non-coherent devices.
>
> Debug instrumentation patch (applied on top of OpenWrt's 6.18.44):
> https://github.com/openwrt/openwrt/commit/13ea79d9a411dc497882e820e4c8814=
43457bd97
>
> Full dmesg from the instrumented boot:
> https://gist.github.com/danpawlik/b351e8a06218a3aaf68a2cb31a32ea8f
>
> Thanks for help,
> Dan
>
>
> wt., 18 sie 2026 o 17:29 Jakub Kicinski <kuba@kernel.org> napisa=C5=82(a)=
:
> >
> > On Tue, 18 Aug 2026 08:23:33 +0200 Daniel Pawlik wrote:
> > > v8 does not switch to coherent DMA; it only rounds up mailbox payload
> > > allocations (dma_get_cache_alignment() in v9) and maps the same round=
ed
> > > length with DMA_BIDIRECTIONAL, while the mailbox length register stil=
l
> > > uses the original payload size. On this board, mapping only the paylo=
ad
> > > size regresses probe back to 0.0 even with the larger allocation, so =
the
> > > rounded map length seems required here.
> >
> > Please trace into the dma API implementation on this platform where the
> > alignment makes a difference. The "unaligned length" path must be buggy=
.
> > We should fix it there, not in all the drivers (my concern being that
> > this is not the only driver that hits the issue).
>
>
>
> --
> Z powa=C5=BCaniem,
> Daniel Pawlik



--=20
Z powa=C5=BCaniem,
Daniel Pawlik
