Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4A243964
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034228; cv=pass; b=HghKLePbs7WbxmAGAwcDcUYkU4Oy7hRR3lTnNaVMaS1Oo4rZr0SE9udfCYbCjh1pmF8l1XbDnGQn5RYfaPoJm/GubvVKbhVqvPQHN6aoffsLe81IP/vjunojWuaFDhFeh/whZuvpXwlfkHNFTpgjFMCLhUEHgqdhjpQ4xaMORoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034228; c=relaxed/simple;
	bh=JYviVjsYfQntXFFeGvZpEVL58y1K7JWJvPcF4zznEXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S17dYCALPBTZkwJV1tF9QNmRjtb7kkpb1kvPftJohX7bmT8pdZsF6LhiCNKJ/mX9TqwtCZ4AjiJodKyd3+whQO7GEOvBM2UYVBWvPHYBXiBFTnP3kIhgWIItbc0BpdVfIOoDvGJnrE0868zPD8vlOI1Q0f8LXuh7MpC3vUahCyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2XXpB9F; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2XXpB9F"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so5205233a12.2
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787034225; cv=none;
        d=google.com; s=arc-20260327;
        b=qbv7zeo1FCToMLvOqmIbIhz01Me80faa4JSa6aLTAhHriIEUE8ealnRypC6+KQ8ywb
         xGAHdjFEL5AYJP3dFlm0Wfx3NCV0XnQC5EjVvJY/L9VUWcmNKKpkU/cOVZ5uiEILTslB
         1XYuwUjkZZMJZ7zMuZKAqoWnpiylp+UbrylbifI9vQKKWh2q+PCEO4cmIMIv9gBJ3Ztt
         TkJOeM0tRdzV8gUlExPItTxwAhGmrmntHS+7fnqFmUYTDMJ9Kc6wtEQoYoPU81zbTPTi
         cClr3GxDzjUHcLeC5xfzzQ+1FgF3vKJst3XSk1REXPDa5UunShDeQfQl4KaBeIQ9ijtO
         Tilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JYviVjsYfQntXFFeGvZpEVL58y1K7JWJvPcF4zznEXU=;
        fh=d5bOL0GeHyVtepyY3nki5+7UVBHkCqjo+KZlUeQCTHA=;
        b=fwzXo5879VQAo4WFjIcjlddG/4mHJbxrTX0oY/gPee1ZnOtSLurfNwLoY1hLb0mi3m
         Dqf0c59k6Xsj8FtxlTmloNrm4eYYkL99FIG95FCtA80wtUA1eypjLkaHjkS9d5SLDrtx
         /NOeKwwWu4dxx34mBe+CpQIoQyjOxNKn7AHDahu1pTOMJfftrPUvg2b/mj3oIHWSBk6w
         BqQv6VIgOCnEvzSEnxQpl31EcxXsduAGwJbx+nCROlNcOakTQ9vVu6nuRr/NpstZAuJU
         SfuhqXm3mmNhYIk9V4bD1DY8G/4nAhk8dAVicWISzYZHZ69BFQQA9AGJIb/WBICLZ1+I
         on1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787034225; x=1787639025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JYviVjsYfQntXFFeGvZpEVL58y1K7JWJvPcF4zznEXU=;
        b=M2XXpB9FaWZNoJDPo/Gqix28gTMAsWDJk/0nAUWyazzP35cbh85gVem0SxdPkxutoY
         MbgFO1Zr0T/AD+rZGfiIhB/YmPTJ5XvejMYcrumCM4lEPhI/7TTk0IGsg4G7L4rut5/o
         8aieQj8eVkR6ykuEuk8byIEtETYbGU9dcTp/Hv2iEfZKn2ysoCZil811pAFPqfO7vQy2
         LaAN2b+rDC1bCXZZZIb7hy12a9aECvKjSrJcGJ0iTQMQrWC1GwAbyBDoJEuD98I116ox
         maUp23vtyNY2UxCCccZyf8Spr1UDoMoVARWB0jHAT13fJrna2lgw8s1HAnpTH0c00dbY
         5lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787034225; x=1787639025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYviVjsYfQntXFFeGvZpEVL58y1K7JWJvPcF4zznEXU=;
        b=VMvV5oLwNJiSyzZsWpOOAL2O283jhyOJedNmnZTto/Iz1dR5Rs1zIoDSFMV3FQSC3D
         ClhKsji0dv4mlISi5vIdRSrWtjuRQZhav7sHaSFHKLGQl2NJPSS015DybgqktY2b4gRs
         1Ch6KPtxWbBd4o9Y1PYv+KEDge16fCga1I1tnZ1m26+wxh7qZVUq5jua4ZpsacuJ0Rh+
         eV+/vB9YzFJ0nboKd435o8Ng2dGrgqwb2+ITbXM49L/burpPMcM6YNsTjX7kZeVPbkAa
         O7Hfpvyq49ucZybbHsFYrPoaLmiEcVqXDYxW8bgz3VLScQQ829yv5Ljhz20SkagJ+J4U
         YznQ==
X-Gm-Message-State: AOJu0YyTYcUrrYQ7o3kqSCwMMz2U3uyxv33O07TiDar4UkoN8SPPfAMl
	IQyHZPaVy1fZejUoK7S2IhxRFJfJG++1thR1f7XU00CJ96+Hf4l881K+aLW8897hT6IN3ISuyeM
	e/gOHCMS2qhxLQnyfBSHp6QoMXgEfVTE=
X-Gm-Gg: AR+sD13J4sDNljI/htEvBLsTy03Z+zeL7KcepMC9vfFlDDTE3WTsBkAelyTM3ZLQJYP
	Jg/jxSYXJbh5VtoxakyBbqcSWh+uuO8MAYOlQvMqLadBlhzgYwHYy0YxFe0Q8sQ0um9lV3b+gOo
	e1dLbEi5Iky87/d3szrJ6Xwq6iimxDzPPtIahdnA90j6NsJytIB40pnAp0jfbiTe8oUC1PqEptW
	XxGA7+OaBcNAtwVTsQkZ5VSgZJNrpFuIHW2n79GjnqyKWKJrPqRXNBzQ1vnWW+DDke0vYj7No7B
	mhHYsP9jj7Y2h5sIiqIoDCT8oejCnE5id/zSDLVFCgpb9woCeqVD9WHyNqnvB0DVx+U3khG4KW9
	h4QN6SDzERO+064elNnGsjuey1WMSAz3egnghcUUN
X-Received: by 2002:a05:6402:5d1:b0:6a1:f95b:8cff with SMTP id
 4fb4d7f45d1cf-6a3e0fcc3aamr3228499a12.1.1787034224858; Mon, 17 Aug 2026
 23:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817090601.1256389-1-pawlik.dan@gmail.com> <20260817161756.5fd2185a@kernel.org>
In-Reply-To: <20260817161756.5fd2185a@kernel.org>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Tue, 18 Aug 2026 08:23:33 +0200
X-Gm-Features: AcwNN1VY43fpVsyllKSRAZ5AdHgJn9CS_GzFXYhOAY4pGHpCjZSi42ezqsoQDyw
Message-ID: <CALC2Apj7rQv=6uUqaqBjfJ9yO+VCddQqHB=yDhXH7+QUCh2JyA@mail.gmail.com>
Subject: Re: [PATCH v8] net: airoha: npu: use cacheline-sized buffers for
 mailbox DMA
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, win847@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

You may be right that the underlying issue is the SWIOTLB/bounce path on
EN7581 rather than DMA_BIDIRECTIONAL being wrong in general. W1700K does
show SWIOTLB enabled at boot.

v8 does not switch to coherent DMA; it only rounds up mailbox payload
allocations (dma_get_cache_alignment() in v9) and maps the same rounded
length with DMA_BIDIRECTIONAL, while the mailbox length register still
uses the original payload size. On this board, mapping only the payload
size regresses probe back to 0.0 even with the larger allocation, so the
rounded map length seems required here.

I have not bisected whether that avoids SWIOTLB entirely or just makes
the bounce/sync path behave. I agree a platform fix would be better if
the bounce implementation is broken. For now this restores NPU probe on
W1700K after 6f884eb.

I'm happy to gather more data (dma mapping debug, swiotlb usage, etc.) if
that helps track the root cause.

Thanks,
Daniel

wt., 18 sie 2026 o 01:17 Jakub Kicinski <kuba@kernel.org> napisa=C5=82(a):
>
> On Mon, 17 Aug 2026 11:06:01 +0200 Daniel Pawlik wrote:
> > On EN7581 + MT7996 (Gemtek W1700K), mapping small caller buffers with
> > DMA_BIDIRECTIONAL regresses NPU version probe: the mailbox completes
> > successfully but WLAN_FUNC_GET_WAIT_NPU_VERSION reads as 0.0 instead of
> > 0.1111.
> >
> > Allocate at least SMP_CACHE_BYTES for each mailbox payload and map
> > ALIGN(len, SMP_CACHE_BYTES) with DMA_BIDIRECTIONAL while programming
> > the original payload length into the mailbox length register.
> >
> > Tested on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996), kernel
> > 6.18.44, including two cold reboots and sustained WiFi use.
>
> To me the fact that this patch helps only proves that the swiotlb
> implementation on this platform is wonky, no?
> IOW AFAIU we are avoiding the bounce buffer so things work, but
> the bounce buffer is still broken?



--=20
Z powa=C5=BCaniem,
Daniel Pawlik
