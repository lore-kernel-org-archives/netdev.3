Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684751A733
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863981; cv=pass; b=mdx4i6R8FRFYDFY1T9pGiUr72xX+Cfq+uTsX49H3jwEMNs1ooZvlsgAJRQo4B3oFdyafnOy7axR2bzQBVA/mUeNSilbezXn4gkA21DfqOJ6pgUj2/dq/SAzFz6WDCcQAdFAt0grtsGAxL56ln6IW9z2bEvQMSWKFqCc9jEBAt7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863981; c=relaxed/simple;
	bh=tt+pGvMYz1FVN4+bRmcox4/aVEQq4bCQPvkvBGNFnW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRmVYiCJe+Ghm/a/kOE0D/JOzi9jcL5oPQdMqBwRND+3IGNofOKoBvNNYGMq3P4MheVxZPEeqF4H53UJ79ZKfUc68nTHhyKtN06OVnmFjlgE5+h8y7RRuAio9Ed3Ze/flNzxLgyl+0MpMJKpo1SfZRc2bEB/pEZ6+KVgvrh+SqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaeuMiFe; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaeuMiFe"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e27035206so4073834b3a.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 03:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788863979; cv=none;
        d=google.com; s=arc-20260327;
        b=VUkaId/5P70y0JXJETIEEi5geoHLPF/hNalJnsD7WJKtXtdJkQr6Y461gwm2HjwnuJ
         L/glR5tIBRZjpVebI33cIN/2Pe5V2TX9a/4kYxCY0ujm6TQVlSsN/31DLBXUGrIsfdWk
         FtAgnFG8Z7vW8LGDrqfkR6rLUMeKciP3e8khwHn33lJ2w3P/7S9gkcxY5FSr8Cnz40cp
         mzhe5gYyqu25i2i6mAR/sIGPbHnEpTBTyAa5RUg/Nn/yOXuRF1YSzzX58IZvs7hPI6uN
         cu7RH6qO9GlfYeHGFlpdTcm8nP/r6bgHBw0X3+2ometi8ovF23R16zeHz+Vhj0wRRuQP
         dqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jl3T9yA5icn0kDud2YKhOUFI5zpsByTY26KMtyiXHpU=;
        fh=wLAov+IsuPQKien1MJOCpW/WWGNAjAnudshO2/oL5QM=;
        b=bydExWleD2pJpEzwWz3RfPAOQEJdlo45M5SFKYOJL5Ju/rtw6FuoFQa59z/l/Z+ypy
         vJRHnAd2Q/cLIWaH2c0go3wUUgScYaByrhzzBuYlIUcFuQ48pHrqFvpmeHFJR9jyuj4k
         CwZ/0b3MnOiTeIRV0biwsNSdEEQsOguIc7QQPVYhbWl6HCeU8N0zKxtpk/cx/reGWCR4
         DIKw6c7J5DF1zUNRU7EGtK4dXz/8AwA5lsAZ9BdsCi9SHaIiwpXVInP3S5TvrnKhobzN
         fIaS4QoIrdTcIsOkdnhCJH29ezcoaK4medRr6UavS+f9fIWVDdM1K8UbNdZfyLxSZiUX
         4M1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863979; x=1789468779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jl3T9yA5icn0kDud2YKhOUFI5zpsByTY26KMtyiXHpU=;
        b=qaeuMiFeZ6gorAS/l9kOotuRrGXyP1K30N0J9ziMvCVKvHiYBt5am2ORgPTzOFC7UD
         nGXcdkQkfobSIhW0z9zy42lDFW240VrasF71CW+rkMKJ+bsQkkFOXF0SzwTwC3CAdov1
         PAbh3QzvMQ/fdzoTVxLdSrSPU5EnYb58drW/eonBT/fS6ctvdG6qHho03fl1xRhQRwRf
         Qji4NrdVhuJOpPA9L8gxxlsmfn5WksC5thP+3vdtPih9Xs8hMANlmDIdVCaqbKAM0iWW
         2G0em4gDehh+wi6IgTsT55egea4iVrOXU+Stcs8WHz05vM5S160AadyW0bqAyMf3J1gl
         /8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863979; x=1789468779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jl3T9yA5icn0kDud2YKhOUFI5zpsByTY26KMtyiXHpU=;
        b=KfmBT8zC1tx83841chs+MwRFybMB9wIAqFt1bzGUOq5iqMKHVi/4ZMJ9SfehGIqcyV
         WjnaaeaW2j1uN1NcBqURMQxTLxkNjc4CF0cZST+HV4eJG7LlMc4UYINqiCR4M56amoP+
         ZfkYzNk0nTYQW6UxFyxBPHFHVUhyujTjTTtPe9Xn/bu+RYKp4/0yjEtvVFdZaUKcptom
         bvpzZp3jD0O9QzaTJxZYQE9aei7z4CLWdwzVuq9kB91iHWjZNF+DWQ3ThGQ/AxO9Q0cr
         ptfLH+yc2+Wxnvx+4UMrg52F16qD7z+RVQeo7riKqqzDnybSseoKoyigAdu/vDuXBljm
         a25w==
X-Forwarded-Encrypted: i=1; AKwUvByfkbZSQM0+623r1Wx/i1oP1qTqVcx4DwRA7dKLRXRbdqMGB32m7qhFHPG3fK7ybGvfNawG0L8=@vger.kernel.org
X-Gm-Message-State: AFuF++n5a8qNH4ooGUuS7xZ9CkSv4cPxw4uC32nH8uNQZSaZebEqZneV
	Cl8Jxe9YJsQePln3MCYpafrbdrDkLHcLaH4rGv3JOYZ/UBBfxrk6tmBp4AbCdcRG5gxxxOed2po
	InwJ35cbtFso1NePiypNj8xNG87y5nC4IkmwM
X-Gm-Gg: AYBFou044waiCsbMVePAY5hYWpNpbQDnH/VSmbbq+/bJmBOTGChX2ubSn2gmBDNfxbb
	xkcJrYQBf4VVb8Eomi4dM5amaVReCmF2Qxbv7oVHNOAyMsDCXzBxxrXINR17dX+4kD0YfV0iHyy
	v4xhVw+c3SpcLhrTL702DHvpna0a+AIZig5Vbf2KBlBpyDcRF86SfTrij6zRQyzHgy/fzHI+CIw
	Sh3rmI0fXISstBV+7qRsXWfBi5jHNal2W9LXGcQPZDYnMuQMGnWn6JzMjTcT7wyREiIR5MAXobb
	aiHwntZVWAVoBlWzVy+JDMlOrodmL2SsW/hZbeCBx6WaKMl1LpREzLnlZdOC6tILnjOuFqcJOZR
	zyC1pv8sy0HwCzEQ0HtoHZGxS+ClFR/SDWky4rxcVUIlyYEJ7LcI+QesO
X-Received: by 2002:a05:6a00:c1c6:10b0:847:8449:2ba6 with SMTP id
 d2e1a72fcca58-866b2eace9bmr6165210b3a.8.1788863978907; Tue, 08 Sep 2026
 03:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc>
 <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc> <CAABR9nG49YgFejWRAkJrCcXF8p03A=HwWhbetmoHSjk_L3h9Gg@mail.gmail.com>
In-Reply-To: <CAABR9nG49YgFejWRAkJrCcXF8p03A=HwWhbetmoHSjk_L3h9Gg@mail.gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 8 Sep 2026 17:39:27 +0700
X-Gm-Features: AcwNN1UgTF6tGEUV4riCUxY5ZHDu-I4a8KfbZKcCu4UtgQm8VpsUF5cE-CTt_a8
Message-ID: <CAABR9nFg-V9XoNTt=dKCeAmXLECrZT0hPdxwEB4ONKV3kB1BHA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
To: Shengzhuo Wei <me@cherr.cc>
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
	Fugang Duan <fugang.duan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Simon Horman <horms@kernel.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I got this wrong.
Please disregard my previous comment.

On Tue, Sep 8, 2026 at 5:13=E2=80=AFPM Bui Duc Phuc <phucduc.bui@gmail.com>=
 wrote:
>
> > @@ -861,6 +865,12 @@ void fec_ptp_stop(struct platform_device *pdev)
> >
> >         cancel_delayed_work_sync(&fep->time_keep);
> >         hrtimer_cancel(&fep->perout_timer);
> > +
> > +       if (fep->pps_irq >=3D 0) {
> > +               devm_free_irq(&pdev->dev, fep->pps_irq, ndev);
> > +               fep->pps_irq =3D -1;
> > +       }
> > +
>
> I noticed that fec_ptp_stop(pdev) is called only from the failed_init
> error path in fec_probe():
>
> failed_init:
> fec_ptp_stop(pdev);
> failed_reset:
> ...
> failed_ioremap:
> free_netdev(ndev);
>
> There are several other error paths below failed_init that eventually
> reach free_netdev(ndev) without calling fec_ptp_stop().
>
> Since fec_ptp_stop() is currently responsible for calling
> devm_free_irq(&pdev->dev, fep->pps_irq, ndev),
> could this result in a use-after-free if the PPS IRQ has already been
> registered and one of these lower error paths is taken?
>
> Would it make more sense to handle the PPS IRQ cleanup separately on
> these error paths, or,
> use a devm-based approach so that the IRQ lifetime is managed automatical=
ly?
