Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F278F3A
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481724; cv=pass; b=oA6oStWvUl4ozv6nxzXNAILL7oRom0ZCQUi6HxfLjCdlIZvvNLI4mcirtALxmC6v25Yvifj/EJEvR7lj7L0vSqE26Hjy9HvE5tL3X7mRxiNeHlDV67QKv3EKgu7mWCGVLB8FnMzoKsFw4B0vIqawfOmvlrQqx/VMdniaecVqaw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481724; c=relaxed/simple;
	bh=/tRnNpAGITtmzfXpF2WkG1bT/GNKfKx5DEcJ0Y3teYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEfqaqXhqu6BXVs7aUaY6ZSI6aHXjzpplvwMBo1oh9vGtxkOkT5YM+BtTvTv6LkiMaI4k2PfMYMxZ6/GDG39uH9GPo+t+50HNh3dxcOFTWEcHveSHpSBAVV6doFpoZ0a9GLPwBTCTeVewWxGaq0pcQMaNyOsMGuefQrcOAXGkao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX4HP+kw; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX4HP+kw"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso400295466b.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 03:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787481721; cv=none;
        d=google.com; s=arc-20260327;
        b=pRDSLvrRGkaiDwq70YdZmwbZQFvK7PfgtoO6OUKD4iwes9NZilYQ2VrWtcR20byhT+
         Y26Xz1rrGS+lGjg/BJ1s4oaykfkaCRv0pyYzr6DnexUDG4qoc+5ugsFBSNKmeSLnlj0Y
         J/uR0b/3wXl0xmMtRsukN8y7A0OkMjif5mHd/QzjGaC1k+wncTlbIF+Fl/KWmIN8tIuj
         zX5TI5FXPbc4tiffhpUFcnfs4F1VUU81v07T5jG6534ax8edFjU5U5cEyq/+il8t13Vd
         4E3ujrcJ9b8hu0/274BkBIa7fEHw5sS4IlH4PCdl/6BixY5iq4lnPiQgD68QqOCBAXLv
         xdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yQUVqT2GsNnO1vNVmJUiz/YI3RE2fLyeDnXMk0gCVEc=;
        fh=uqMRNnpwRM//T1frTOWiJ+AmwRHwpA/5XvrsdIb9JIw=;
        b=Esak16i0VtnZn+VlMlZMuQqfIbHIY7NE8+g3tW83TD+S6JHRkQcGcO8jPP3ObP8rce
         XuiNIQ4qdbFuwsIJg/PRbicOOoLmxtXI2aeOYVwPkBQwIqw6mk+cluaLGoKVhmA1uxmQ
         BDEJyX6D9fP0JZNAyXe7RCw8t9PAToT7bBmd8vZD5c5jSVWv2nokmiwiHfoswx832Hzb
         IEqNJKN6R6EybHeI5fid2pB3o8Tb2oDVtetVRVsNyZ8Qt5BcTHdgo/8LqPjl5KSGkkhd
         wFREeYjSATPZsU9NptocjcEvwiBXWwxWz49UrsfsVfwZfGG8sgVELaLm1ipS29ZodIc3
         nTUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787481721; x=1788086521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yQUVqT2GsNnO1vNVmJUiz/YI3RE2fLyeDnXMk0gCVEc=;
        b=DX4HP+kwkIuK/fkrzn3ok+KYqpbVYFc0dtN3jQ9gyG/KJoiDdWQIh1SLdvx8YV/oAs
         Qbg/Aqk/uxTO43bbLRiaG8GXaD2t4oqchiF8U0AcJdq+c9cEKQcCL9il/RQdeL30ehPx
         IhtaY2njfNm9FJxMMNfw7Y7mbopqg9TgzC6HcUKlq9KKYISnDcFWvNsr6KunIUxa7fWx
         rIn3ywvXBawAjG8234334GfCdci7Wt5EgARpE07Gu4YjbfPjxLZtQ2W1vV9BfoNU6EsP
         o3oClD4vnIGjDtzeQjaG0UUhSppWE2Ry1GsNp89gtwIOj2QAB5g8m/G6X+1IbdOakt0l
         Ijtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787481721; x=1788086521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQUVqT2GsNnO1vNVmJUiz/YI3RE2fLyeDnXMk0gCVEc=;
        b=h42kxfTuUqsY/eqaS0rVMbTScXJSu+pEYec3B219YresuFAJOvw2bLhs2uogfWbJbD
         IHePXpf/ZbDaR5vy5bR4iu0kvaYIdlTPQuKbczTzsKH/3sKLaorqXChcI/Xu0/KoLiNo
         +136+onGrR1ZGNTkX2YuZpomuW6E6g31KnBFZpw7jTbsCZDutQs9P2JN8lR9cZuADiWg
         zmiXdvKp/k+18rzf1KeUyKvt4ltuF+HbTidhC6FKzJmfnqrLfLRKXTKnEC6uQaT63HlX
         YuKSVSL5rlup5lqA/fhQ3/QYnQ6AaN9CFk9lUpYAtSM8ROPwkA24tZ3WDQS6Wzt9YhTz
         j7Hw==
X-Gm-Message-State: AFuF++l93zcxzkrAQauuGsRUbc4LBWQNoKk8LSqM0KqFuueQIWCybi7I
	JnhECsjMgef0tecy8/AVSHt98QLJRGjh7IuwHVoBMp8Efg96YQlkwIfmC1I6Z3HoICtCydjzrEs
	O1z9qY6imzvuLsai82uuAjFfud/ct1H4=
X-Gm-Gg: AR+sD13ZH9zhsjtdR4F0VQwteEm3Bge0XX3ksDVwqmNfk2SsVvoAiJFpVx3tlOaW862
	wC1LKcZv2FvEm2AcTsR985gUTWIwzj+vzPHrAxFICvz0qWJgK7tkL9wHniybyTUvkXD6hTuT4K5
	gIE44EWB8txvZHEjgSqy+sfVRTDJVYOrXdzHDc4xbisSOfg6I0MZzBhO7tc3OO0bkaJOadEUs+t
	Y1DGjlQ6XHFLKrI5LkpDP1SMoAwk9dqmQLWOGAVT/5OVUa8oCjvQuSt3lc2G6FvPQfvdGtFiB1v
	WjbB6pvSwlyPIDZ68zrYbfXBmD00Vq/9TbaYxCpotvYRAGFoiG1Y+0HLbBuzD+ni4h5dvtT1iXV
	ruxe6TjS7WShvkgrMNCGYHhfNAHmMfw==
X-Received: by 2002:a17:907:c706:b0:c20:f913:9337 with SMTP id
 a640c23a62f3a-c246a657f9fmr2290057766b.20.1787481721077; Sun, 23 Aug 2026
 03:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820085941.380401-1-pawlik.dan@gmail.com> <20260822122727.4f437bb5@kernel.org>
In-Reply-To: <20260822122727.4f437bb5@kernel.org>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Sun, 23 Aug 2026 12:41:49 +0200
X-Gm-Features: AcwNN1Whb7yUsS76NaQO16mZ6ya_4eh39L6AFwo6dWX5dJOjIcUnhZ_fwDLV2K4
Message-ID: <CALC2Api8nhePvuUPsw9CE6nX-0pFOMO5qy=4fzqox8_XM4eSqw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] net: airoha: npu: fix missing streaming DMA mask
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, lorenzo@kernel.org, nbd@nbd.name, 
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	yangshiji66@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I tested both patches independently:

- Patch 1 alone (DMA mask): NPU reports version 0.0 - probe fails.
  The streaming mask is correct but 24-byte buffers still bounce
  through swiotlb, and the NPU can't write to that address range.

- Patch 2 alone (cacheline buffers): NPU reports version 0.1111 -
  works. Cache-line-aligned allocations bypass swiotlb entirely.

So patch 2 is the essential fix, but patch 1 is still good to have as
a defensive measure - without a proper streaming DMA mask, any
future sub-cacheline streaming mapping would silently break.

Dan

sob., 22 sie 2026 o 21:27 Jakub Kicinski <kuba@kernel.org> napisa=C5=82(a):
>
> On Thu, 20 Aug 2026 10:59:40 +0200 Daniel Pawlik wrote:
> > The driver calls dma_set_coherent_mask() but never dma_set_mask(),
> > leaving the streaming DMA mask at the bus default. On the non-coherent
> > EN7581 platform (Cortex-A53), this causes the NPU mailbox to hang
> > after approximately 41 calls when using streaming DMA mappings.
>
> Can you confirm if patch 2 is still needed after this fix?



--
Z powa=C5=BCaniem,
Daniel Pawlik
