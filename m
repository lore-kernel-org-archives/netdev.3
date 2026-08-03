Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C0427FAF
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782389; cv=pass; b=k3xhOdwvM0xnSWcfAWzK1d/meWw/GCmzQP3ecut5LZLqIweDI6Pjvz27yBMePwreLKMswMLEcTi/tsV/mYPGP5rIEp5xWVeVos/R1QrJOpjL34ukbxkP5P1Ak5fjhq+s5ANNIZl/kKNRyjo6oFZ3vyRXiENPhT4/ImRU2c8pOkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782389; c=relaxed/simple;
	bh=ysEVWKF2WWNcsBakZlX2KYejEWt8550NvykEr9wiGg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSh3jC9+yLttwhJPZ60Lx1mwT45JOgwWxrp8YXbDWh/IBNYa+43sSCRzA9k/N+Hp0iVmM9ZFLzwzH/OK8X5bhp6qTb9cwRsYuvEuu4FOoKsUT9CH0d9fTFUE4OhLpkDg82kb6zW2tHXrRbSolQ8BF6hO++bex2Fm/8aodFZt6js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhTEYTAI; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhTEYTAI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cab97c86bdso26005ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785782387; cv=none;
        d=google.com; s=arc-20260327;
        b=gPtV7Ox0e528R1G2NXcWH32cpgPInSNr0HfI+NlptSqPcRhGIySmsesh/YTsRTjS3A
         7AV68TZj1xFnRO/1F7b6tdYu+1lKF8F3U4IN691wv6GDY9EohWfNDXz70PBSBhb23Tur
         0eoifLJH6NG++iAe6KxQYFMYXWsSkIVvUQblZuW57ecZT/6AkL17xwgJziaPKY0KFZ6i
         aPf7n72TmyBMFOP3upgfC8cGxRvIzM0qn+os1hgWiCmysR3/KYAMRbWuRqFh+VCoU3ct
         JQiNuKODn73coGmEUUgL3mEopEx2o6CHMw1ytU6vroD8ykNL42qSt7HB8DOvh4vWHy/S
         jR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ysEVWKF2WWNcsBakZlX2KYejEWt8550NvykEr9wiGg0=;
        fh=DcgEIyTaXtgUmagKo2rAT1NkxpYhFWczbYZkg7dlTcs=;
        b=Q1I2gQPVfPhZEyIy8N1puxyCKjRKsvSk4ssfeFUT/1FpEs2VtxG0iqzj49bJOzhIoH
         ewQszyDnhChnprr+pIatjShqTX9NT5Mol0MeUle7ujGJkMw3QBxdCQV69hA7WmXXuAm6
         fJ7qnCyAhptEZ+QL76dyDw4j1X2fz6wMYFR73FJE7zusiTxUP6/aTNSHehkjnrViWwXb
         Lpt/FftRVt9TWZINOKY4du+i2tdGJaAMm+5tq3hk6cU6y18gWUMY6ql2I2WD9u6Q+i2u
         fdurGYjAGj5O6UOFErgcS8LxONLPqkfbzoxjkPIhogz2U90ajh7/PDKLZ+gcAc4Hmu7G
         iDRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782387; x=1786387187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ysEVWKF2WWNcsBakZlX2KYejEWt8550NvykEr9wiGg0=;
        b=hhTEYTAIsp82823RsktqvjAXf+CdTejZpB5eMTtHRKTXdoxI0wjmKvnJ8jcRxnY/Bb
         bs2ywk/ESUu5eWzL4rPeQso1YlWQmgY9SJ3RdmNp3i3eBFHkpEsR6Ln30GASQCX7HA9H
         0iGbXmS0pyqezHMqsErnWE0+2P/fnLlJDQrjuAOJ/SeL18UfjSsq4Zacmg4vE8wEtGVO
         sSssdbP7TpKs14fTecjxGeCzTGKwNSd3tyQVi7YHDtUAtg/+WJrOv1u4X6wMWUryhHGr
         tjgxgTwMb1iW2h1QM/dl7FBY8zmeGOyJixTlQIMcXqupYhxFI/nSGGHU4Gnyx2XokpmI
         t1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782387; x=1786387187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysEVWKF2WWNcsBakZlX2KYejEWt8550NvykEr9wiGg0=;
        b=OCXWfUsecNAi8ADEhmtTUP8ufr5oLJpySFxVUhtMBjWTeVL4CDsTx6jsQ6V4EJjd5S
         Y76pM5eb0GIkihtfyCUcpNFs0BwnCJeovemLtuxbxcRh6dFr3wYUZ1lT6+APRwCiedbQ
         TIV6hXx4Qhls78+ttpq4bkdDaqJ6hA3Odh0dVcJlUPmhJeE9aFCw0FVbxIbc15H5ork/
         YlVcKtDAuVc3zGA8HnV276IdOCzGOJPELJy79tExY9CM98idUkOkfvRPSTTyT0iTtLuX
         T5lbw6RFDtWE4PtC5iYRzmNKsVc4CD7dEJy0aK6tKFApvP2qgeUTVzLQFCJ5G67wAfIK
         dPBA==
X-Gm-Message-State: AOJu0YwYsqJRqhPDCfoev00Z1IE1BzyxvUxExdORf2Sf9M32oQIXQaqb
	o4zMi2FSQJ1rIOg4mf1VY6rXeld6Lzb+J0Pq7uihg4g5QdBfzfCFtOgH/FcP/2ze19X2EYtNrI7
	tD9aOFFJQVpFaFrO0UaXpo8f0tc/WEYWasPlwrXQe
X-Gm-Gg: AR+sD12lSeIMp4J9aA9EdWcF2Mku4Um1KdGnUg3Bs1KOYavabG1er7mBbJceU/2ClsJ
	/i8ufg9t2PI3SD5xmlIXbzFjGkUSmN8u6zrsBqQgm90YYmWmNUA+0Z2Wq6gSM7Jo8hncKRBGIOM
	AQIOORE1jxZXPWxRPxKvefZjP8nafkSMFhu+0PNRT7NJHO+BmjAstv9YDNHo/vg/ct0JHSQ/tpf
	HxV04VLpv6AuCImGMadPiY+dy9T2r49MvdgmLCGV4fJ3VoS8UaHEGGA8iQD7Mn1xaCDZ0VUDKyz
	woloUwWC/zgHp9f5Mj/6pbOHYQg5yEyZgW83YSWk1i1y
X-Received: by 2002:a17:903:8cd:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2d08cda9b92mr1251285ad.1.1785782386773; Mon, 03 Aug 2026
 11:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803070513.4657-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260803070513.4657-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: <20260803070513.4657-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Aug 2026 11:39:27 -0700
X-Gm-Features: AUfX_my-IXUAAmiOm1dPrWOoSLO_UNWLKoIxVmuwUTZRIKlicpuwAkpUNxi7N9c
Message-ID: <CAHS8izN1mCBH5=ERy9OKaeC4Wz2-v2N2oGDW34P=ZoS7oo2aOw@mail.gmail.com>
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

On Mon, Aug 3, 2026 at 12:08=E2=80=AFAM
<muhammad.nazim.amirul.nazle.asmade@altera.com> wrote:
>
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
>
> Use page pool buffers instead of streaming skb buffers in stmmac_xmit
> when snps,pagepool-tx-buf-quirk is enabled. As page pool buffers are
> recycled, the overhead of dma map/unmap for each transmit can be
> avoided. There is a trade-off of copying from the skb into the page
> pool buffer, but this helps where the copy is cheaper than dma
> map/unmap (for example with IOMMU invalidate cost).
>
> Currently page pool buffers are only used for single-fragment transmit
> in the non-TSO path.
>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.co=
m>

Whoa!

I haven't looked at the patch deeply to be honest, but using the
page-pool for tx is a bit interesting. There is no other code that
uses it like that I think. I can't think of any blockers off the top
of my head, but I think there are places where we keep a global list
of created page_pools on the system/netdev and the code parses those
lists may be assuming it's a normal page-pool, which is a pp used for
rx and attached to the an rx queue.

Just Ccing the maintainers of pp to know about this use case. I can't
think of issues again, but I wonder if a more-expert has thoughts.

--=20
Thanks,
Mina
