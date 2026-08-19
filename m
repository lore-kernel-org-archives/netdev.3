Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65236894B
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106201; cv=pass; b=hTD/kEsnZx7Ayss6QG6LlsNHY4+HfFZhqBhf4ZTbACQCwYwIoYEFdDG9mZt2pO6z+KZD5OzU+8Gyx284yunRZCvIzLuoYoaA5pPKC++kdZm97F/8zjg4clrwBYhS4kLUatzrwuoWut+eMBpllQoics4zDTtv04cSu7HWKW0V1YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106201; c=relaxed/simple;
	bh=dXxaLEpOPhfn0XeX94XTzwQwmyuh0t8Id6A00f/vSts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Id5fU9WB048cCRA+COsea6c6mUUXRbR7fhsVuge23yHpIQNVCPkouIqOkTZ/Oipd6vFb0DwjFaiZpTuXWtpOaDiiUhplwph18taje1yUIhpPlIgBiGGqoiRBEOuMjcMjmug9bRToqyeEmW7pk9iJEcUrER7LcmZ0W3fDeJiTtFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo7qkUFm; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo7qkUFm"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93703cc9e2dso34578385a.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 19:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787106199; cv=none;
        d=google.com; s=arc-20260327;
        b=mkHrUNtmi8ciNtZ/2enh6iHO0a6PPh418aQrgFMOUB77MaxSFDe6SfQU2czFyiBxIh
         u8hb+1vJh3xSYucJYWLxJH09HdCidQaZ6c6Dic8ey45LUIHHrL3aFu3pi0wZCk4X3CBG
         0LOwuD3uHSmIQ9VjfQlCOAVT7dg9EnjJPBIhEcaNjpWltqm9EQs4HYOKcQiQ+dZtw5Jw
         JzOg8MHct3/4Cg4YvKG51MKzdwpTOlvryrg9PeGsRx2AxcS6CDwz1ncGEF1pISTU1O3F
         CoOPd/tAsrHXn7CP9AE0Y9HDCzNceYW74HkX/QnT8wRjLdelioCoxf36ujJVcFcMeaeA
         gNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XlDge6YxBATGKL1stOyDVziDJiwE9SDryv9ROT1M1Ao=;
        fh=zvdtJ3sUgDONwF75c17CENXbGVcBK2blRudxGH4n8ds=;
        b=STQ4vjTFWkHU1BWi0F41ky1/UJGib85+zE84SAC7N2PZTN7puicJM8UgzmR0QMEFln
         gdT7PyOmXQ47tu06ZE7BfKk0sesxeROZO6c8l5JlUZ4gK+p9ywy7zfur7pySZUrDN9GG
         E2azgFqqEIRKTrPsa76Od9qkeyoncdEyU4uW86F5A8Z2UnACBso3aTzPwVlI6qPGkCI8
         /ctD1CLpY7HUWIzkpuzG40u2yHt91+YRDN+5A/g+PkSzbTmnhaTSHMMtmCbxVc7WJZGs
         q0mhowzoKeBlU5kwvZRXpPfDrtKGL06RYappBTrPO28b70MUokOkeqphYSyGUrbElg5X
         m3xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787106199; x=1787710999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XlDge6YxBATGKL1stOyDVziDJiwE9SDryv9ROT1M1Ao=;
        b=Bo7qkUFmxF/WQaminUlWNelU7qZRxaORdYZeupGFl4brFVoudZDY5YmIGlTAQA0Jxc
         RAkFUFEELZFRAHAio68uHO2loMRBLXJniIcYXQSjndPIwyXMVGlWzmN1RHtG2FuLujbe
         yx8WwPMLlCEKcFJ5s04o5D468cnytCcSmr4DyuXoPukLK6irfljWdNYx/QT4UOruip1R
         XjyWHCsrxBGLfjHjiUlmeNpzXgIYmGjruXQtYC8fE1ePU72+Ud8NZ43GlDfSuNWbBSdJ
         5uXphbSSGNq5tSGLWgo9vR3oeOAotkVwJihRAJf+0TvEfdaJ19tOGDsrHShHpavoZc5+
         PaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787106199; x=1787710999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XlDge6YxBATGKL1stOyDVziDJiwE9SDryv9ROT1M1Ao=;
        b=XLiBLZDTXt0mxsc0roULgdAx0DoMl7mU7w6vWHIup5+Exs0CZPUrn2zbVcKRrctxOH
         f8fnRRXC1bfXGp11ChFIytGz+Zln4TQadfn/HpTw9fqTK3MZP9DT4pMzvBBWZ6w8EFdL
         lfSY4DoMmSWrjiozuAhhV9Eu7MWz/fsQcI4HHhYzUydV8nR8a6FLL68nNXENiv+/25Ie
         5W6UlwpYhkgBy9jtJCYON26D22QnTuahHBMktwra0wZTZ9JTpyGg5O4b7qcCRsu4Jc2w
         +hBdp49GIVPWm6Hl0FxdJP/C0merHdhmEi+IqAfET5G9mBRwBJBURM9NkKz3BLP7eeTS
         s+Vw==
X-Forwarded-Encrypted: i=1; AHgh+RovOrdvV4lFNSn4Nu4FVLaRiljlqLH4bT/gGyUr8KEO3tPbHeVmKGRJ2dJl0C6cfBp2txhO0Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0O4nb8dq9+oY78kSqMeSR2XyqWb5sb91wHzZXwwDXP6w8D53
	PxILGp9AUhzbLjVokW11EfhLFmgw4SmdSmE6iKX8HqzPUQJy1Ml0ALsITwNfh6iEXEPPBTBXMj8
	EMhDhJZCZJGOtU75O9RXqB1+fbCTPU5Q=
X-Gm-Gg: AR+sD10DWQz20/NoFffem1AzRw8sCG8DbVEfJnaI0zy+/ytR34nUf3saDz09yyihfG0
	lqMi/K71HZqwzfug6g33QQum8B+S3smHl5MwSmXlwx9YqJPdySMKqWsR6y6HwW2KTcuhXj3qYxK
	JFJE9mM7cow9HxvdpxidQa86vOKpGSClke+Lt23S4XGHU61y/Gfq8M0V1JdPFyg5FA+QvokHS8W
	lG6bxti0MFiIRk3w6ROnMW4yLoY3N6w3za5fNeBp6PCnEOEa/3xX+0DZyYbCzAm9OqES1+8xdUy
	j3Mo4pr6Q3vLAcn25UxXkKUGKXxZ9uO6ChWHDXQ1aA1JsZGGw1GVaWE=
X-Received: by 2002:a05:620a:2683:b0:915:fb92:d599 with SMTP id
 af79cd13be357-9371e309098mr170749285a.25.1787106198915; Tue, 18 Aug 2026
 19:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818132722.1852876-1-zxyan0222@gmail.com> <20260818132722.1852876-3-zxyan0222@gmail.com>
 <b53e9ebc-64c3-4291-a691-5b7ddd118cc5@lunn.ch>
In-Reply-To: <b53e9ebc-64c3-4291-a691-5b7ddd118cc5@lunn.ch>
From: zhu xin <zxyan0222@gmail.com>
Date: Wed, 19 Aug 2026 10:23:07 +0800
X-Gm-Features: AcwNN1VYxdQMqp_qsHCI7ov2YZB4D2SmRdcSpzWMh4qV3ou34Io6V35sVxe_n4A
Message-ID: <CAP7veT+OwAT15f==wqmKumZnc_Q12NYtS4fJFN9X1cTRm=+e0A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: dwmac-socfpga: mask
 XGMAC_TSIE during cross-timestamp
To: Andrew Lunn <andrew@lunn.ch>
Cc: maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch, richardcochran@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	muhammad.nazim.amirul.nazle.asmade@altera.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andrew

On Tue, Aug 18, 2026 at 11:07=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Tue, Aug 18, 2026 at 09:27:22PM +0800, Zxyan Zhu wrote:
> > The Agilex5 smtg_crosststamp() handler arms an internal auxiliary
> > snapshot, toggles GPO0 and then polls XGMAC_INT_STATUS for TSIS in
> > process context to learn that the snapshot is ready.
> >
> > Once XGMAC_TSIE is unmasked (done by a companion change that enables it
> > in XGMAC_INT_DEFAULT_EN), the DWXGMAC2 timestamp interrupt handler runs
> > from hardirq on every timestamp event and clears TSIS by reading
> > XGMAC_TIMESTAMP_STATUS.  That read can win the race against the poll
> > loop, which then times out and makes PTP_SYS_OFFSET_PRECISE fail with
> > "Wait for time sync operation timeout".
> >
> > Mask XGMAC_TSIE around the snapshot trigger and FIFO read so the hardir=
q
> > handler cannot clear TSIS while smtg_crosststamp() owns it, and restore
> > it on every return path.
>
> Did you look at the other system which implement crosststamp?
> dwmac-intel.c? Does it need similar changes?

Yes, I looked at dwmac-intel.c.  It does not need the same change.

intel_crosststamp() sets STMMAC_FLAG_INT_SNAPSHOT_EN and waits on
tstamp_busy_wait for the interrupt:

  priv->plat->flags |=3D STMMAC_FLAG_INT_SNAPSHOT_EN;
  ...
  wait_event_interruptible_timeout(priv->tstamp_busy_wait,
                                   stmmac_cross_ts_isr(priv), HZ / 100);

and the generic timestamp_interrupt() early-returns when that flag is
set:

  if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
          wake_up(&priv->tstamp_busy_wait);
          return;
  }

so the Intel handler never reads GMAC_TIMESTAMP_STATUS and does not
clear TSIS.  Intel is interrupt-driven, so it depends on TSIE being
enabled; masking it would break the wake-up.

socfpga is the odd one: it does not set INT_SNAPSHOT_EN, polls
XGMAC_INT_STATUS for TSIS in process context, and sits on
DWMAC_CORE_XGMAC -- the core type this series newly enables TSIE on.
So only socfpga needs the mask.

That said, the cleaner long-term fix is to align socfpga with the
Intel approach: set INT_SNAPSHOT_EN and wait_event instead of polling.
The trade-off:

  - Masking TSIE (this series): minimal, keeps the poll loop, but a
    local workaround for the XGMAC hardirq-vs-poll race only.
  - Intel pattern: no per-platform masking, similar across XGMAC and
    GMAC4; but a bigger rewrite -- stmmac_cross_ts_isr() reads
    GMAC_INT_STATUS (wrong offset for XGMAC), needing an XGMAC variant,
    and the poll becomes wait_event.

I went with the mask as the minimal regression fix, and can do the
Intel-style conversion as a separate follow-up if preferred.

Best regards,
Zxyan Zhu

>
>         Andrew
