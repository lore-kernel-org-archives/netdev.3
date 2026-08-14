Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8963F075A
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697161; cv=pass; b=Qv34EX+wPaCZ+/Lc7KE8pQFoSGTkghwHd/fkByjOdfuhAi/dr3O5O30eNdcuha5QKfqMM8fU2/+uIQQzhTVSZel8NlVXbydKe/dj1bpSJtaBSUdbFoXEowK+vOQlUxAn1H7H5/gxm6YuXGBZxbRiYo1mTj8YHLQfPTtWisxrnWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697161; c=relaxed/simple;
	bh=JDvctq+PWMMNcRwzPQtWEy+DqPWZ7q2zVjAVgLcx/9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cc++Zi+QW7rA5bYyy6Ch3XLZWHSRHTnmJoRLAOOqVluNhtz196eu42AnXcmGLxDrT446LZxTKBKLrsZpOPpG1OO5ZxLrk5VVleK1ikZh+N3w64LNtX4fOKR5iGH7v8TtTJ0mO3R3e2Pv+cWuekrZmipG8k1Y2Top1VtcmmMPIxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWc94dR+; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWc94dR+"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1671ec8692so117742666b.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786697158; cv=none;
        d=google.com; s=arc-20260327;
        b=OLPacTrLdc5cZxcv165IsspDQtysoO1/IodsqgGsikr0obKgplxhzlsbpVm8ntSyM7
         BRxeFjLwoze/X8yym/EojTp/5NGNKWc21EMrUQypIcLH13/fC+RLv6+i5pGLnKCsqsjt
         uOCh703YB30BxWK2CzVJpNVIgQ850NcwFKBqOWzUsKtZm1VQIRV8tHHz367vcUR+RGfg
         UhPB+yf5Au8ihTokdzfZjJU0AZ+O9AKPxHAAGie0+XPxZ4e+f7GmjO7pjrDAjLSY6ja4
         a65f4U+sZBQamNDPeUF63icGnZKBVdcLOY5w7RrdeT7psPBuz9pmauSbQ2uw5YOyxw6q
         AX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ctpNRt4aHSt0ZiBATXpNUnAiZyBx5JbaM34XCPkr8lI=;
        fh=d5bOL0GeHyVtepyY3nki5+7UVBHkCqjo+KZlUeQCTHA=;
        b=Wbx7GY+TC3lNX9jB5e91pbNWpIeEvB9tjY/zeO6dlafxCOzOLAfpUAAy28zm31nOwZ
         fCVHTdSaPyl71vGJE9Wr+/Q+sYRt+Vym5zA8qMsCc4MEGKZMdBnfpR0qxyueHucNbnmI
         lxBaa3ix5YTjFcLIRAC9vJAvGRv27VLg4VMJLPpPlHU7w4SWF5//P+riUEOcB60XWV+G
         UZoMDzs9Avc3DEa9b+WppYaejl1YMXS+IX9eoXGC6B517OT7bkFg/Il3zFpOECT6wdaZ
         kplRBUieiAVOWzx/nf9uNFzAkgIxKkbEI0fE9tSvNETiO9jDD7E8uvZS92hqI5Cor0e4
         GrLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786697158; x=1787301958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ctpNRt4aHSt0ZiBATXpNUnAiZyBx5JbaM34XCPkr8lI=;
        b=UWc94dR+BxcWt3PIPYG2q9ZfC+kVlzX4t12FvOl89i79us4bufJIr7rHBDQ+wRiPZH
         pnsGTB0/46AFWKdJus6gTFUtiSuBycp2NYC0Sv/ZQ6mbyZv019ildTx4oAybC7fG0c0j
         EYcEPkQhx8gdgNzJwzGxRRrEpLoLlNlelrt1yDbC9xi0xWMeRG8iVIzZjOCKb3aSqHSG
         twoQ963FgcYg5SGN1hkVEqU2EMAHbz+jgEcqnDblHgzCpuIU3sfYHvAMpJSnPjMpFbeV
         X7XQhE6xAOnX2EqXMAmgH09i8ukP3T7CGna8Fv9v0duh/cLTfjCmozpcFKJybm/Tt72a
         DYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786697158; x=1787301958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ctpNRt4aHSt0ZiBATXpNUnAiZyBx5JbaM34XCPkr8lI=;
        b=ZGqRHnKEc6QitneogJMKvpPqvcn2AgzuXc3DAU1IbpednqZOtw9ZuSmVCPq5XOugsg
         Vwk1IGVnBQLQ1hNNLMOVIlrQ8GIyjo+W5OMtqoPC7oanaevT9XcJQgINJKf7RphRYCTT
         CfrgIIfEwH6KYl6mzLI4do+Jl7tMagkgIVPeHegzbxxYnPg8xNMdldxI+3gCyrGGXKP/
         2YJTSVLzYm3QI1BpSd8J/OswwBZGyp0jSjKqVqQ+Psl8JUdpjq1DzqGLtt02qsIlc34w
         w1ftg7kD/vs7k6cz3S0YQpUkz6/bEMW8BBsSnABj2qiYoQ1UThMX7Kor4YMqrxbx/kiH
         ZBIQ==
X-Gm-Message-State: AOJu0Ywq1G3TpJ2AZypxqvGAO+3es3LNTDoW89uC4Sb5CtaObSLlnl7I
	Yj/YGT1pnPGAgRoXtec0KS9OX+m1FTpp+vsAlW31AhPeY8pM9clFM6Hnb6IowOYwBBWzyaACboI
	igD6C7qGuj9azxTM0MVnKBZMFlCOdy8M=
X-Gm-Gg: AR+sD10kyoX11WDMXINMKZtE2AJwoteSu4E1m+UKyz5DsSEx6fCs1xCIaj/Wp54II5d
	IPnByZInjarVqz8erRXYDAC3gNUhTQxmqN5PeNkPonmAwOpkRQb3GwpS0xxw6bYrFtYRd9NUaWb
	4je6cK1rnrk56+6aXJ8ifg51oYjzNYQRVW7nWuB6yoGsKFQdWmM/q9dz1mGEzBVDUUNN/zDE5Oq
	3ulCzjA1lrRx+nt618hB2WPlzDcBuBaPm3ANkx1+IPbvc9cqRVUxAHcFXA+wMuIDt3hPxzjZpjk
	gFjm3IbxxuXaobIguoDxR+gB6QTWvgK5r3c0OGAOf9UP+5WgPALfl5tAqkrf6IWFSaeOEjM/Xo4
	zy7AXqF3oOAN2tDE8wmznzMPyyo5v9A==
X-Received: by 2002:a17:907:c10:b0:c20:899:b8bc with SMTP id
 a640c23a62f3a-c2129ac0d66mr200128566b.6.1786697157566; Fri, 14 Aug 2026
 01:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809152813.585797-1-pawlik.dan@gmail.com> <20260813180532.3683abc7@kernel.org>
In-Reply-To: <20260813180532.3683abc7@kernel.org>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Fri, 14 Aug 2026 10:45:45 +0200
X-Gm-Features: AUfX_mxwIf5bn2G0UM-Vi351-EpN5XsVbICk5ppLvaZ8AB0iHOEQezLAyICIB24
Message-ID: <CALC2ApjREyeKcddOx0TP2AghDs2BVKY6xD6mU6ToSOk2MQ4cqw@mail.gmail.com>
Subject: Re: [PATCH v6] net: airoha: npu: use coherent DMA for mailbox messages
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, win847@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

Thanks for the feedback.

You were right to question the coherent bounce - it likely masked a SWIOTLB
path rather than fixing the underlying issue.

I tried your suggestion on Gemtek W1700K (EN7581 + MT7996, Quantum Fiber):
per-core cacheline-aligned bounce buffer at probe, map
ALIGN(len, SMP_CACHE_BYTES) with DMA_BIDIRECTIONAL, mailbox length register
still uses the original len.

Results on kernel 6.18.44:

    airoha-npu 1e900000.npu: NPU fw version: 0.1111
    mt7996e 0000:01:00.0: NPU version: 0.1111

With 6f884eb alone this board reads 0.0 (mailbox DONE succeeds). The
streaming bounce fix survives two cold reboots; PPE offload comes up
normally. Boot log shows SWIOTLB active (2MB bounce buffer).

I am withdrawing the coherent approach from v6 and sending v7 as a new
thread with the aligned streaming bounce instead. Happy to gather
dma-ranges / device DMA mask data from W1700K if that helps on the
platform side.

Thanks,
Daniel


pt., 14 sie 2026 o 03:05 Jakub Kicinski <kuba@kernel.org> napisa=C5=82(a):
>
> On Sun,  9 Aug 2026 17:28:13 +0200 Daniel Pawlik wrote:
> > Commit 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox
> > buffer") switched airoha_npu_send_msg() to DMA_BIDIRECTIONAL so
> > non-coherent CPUs invalidate caches before reading NPU GET responses.
> >
> > On EN7581 + MT7996 that change regresses probe: the mailbox completes
> > successfully, but WLAN_FUNC_GET_WAIT_NPU_VERSION still reads as 0.0 and
> > mt76 never binds NPU offload. Healthy boards report 0.1111.
>
> This sounds very odd. Is the DMA API broken on the platforms you are
> testing? The code looks correct as is.
>
> FWIW here's what GPT suggests:
>
>   Indeed, HEAD^ uses the DMA API correctly:
>   DMA_BIDIRECTIONAL map/unmap must make the NPU response visible to the C=
PU.
>
>   The important wrinkle is that, on arm64, these small kzalloc() buffers =
are
>   forced through SWIOTLB when mapped bidirectionally. DMA_TO_DEVICE did n=
ot
>   bounce them. HEAD switches to coherent memory and therefore bypasses SW=
IOTLB
>   entirely. That suggests the actual problem is one of:
>
>   - SWIOTLB memory is outside the NPU=E2=80=99s real DMA aperture.
>   - The platform=E2=80=99s dma-ranges/DMA mask does not describe that ape=
rture.
>   - SWIOTLB copyback or cache handling is broken.
>
>   Using coherent memory for a mailbox is reasonable, but this patch masks=
 that
>   underlying problem rather than explaining it. Before accepting it, I wo=
uld
>   test a cacheline-aligned, rounded-size streaming buffer with
>   DMA_BIDIRECTIONAL, while programming the original payload length into t=
he
>   mailbox. If that works, it strongly implicates the SWIOTLB/platform set=
up.
>
> We can take a revert of the patch under Fixes if it's urgent.
> The real fix requires a deeper investigation.
> --
> pw-bot: cr



--
Z powa=C5=BCaniem,
Daniel Pawlik
