Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B4136351
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719473; cv=pass; b=NAbO14n2NK0ih8T1avTCtsdS6XYUBDIA7NuvS3HiaO3nUUZoZkiBXPSIjGmDtPpp0ChvXLpt39MvcEp2a+20pE7ja55+YE3oe6cN8pBII4Ix3sXN51vPBnEk+Qtc41+MSmeeAGfF70sMyae4ceSWlOdT6TgvjJ4aqSFSeXxLpio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719473; c=relaxed/simple;
	bh=z2zRx5xIYzBTRZFTx4rfNkA/ccYpqsaQrW2/mbf7wNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndUkmxoe9ZJ9g6k53pp4nx1D7GrU9uHFIArRQ7CsT33A2xQgQ/ueX1mmxFYVvT1j1WiGK3/jiwPJoEd6zfqbj/NAnWenqbzGLecqTaUJhXITjQb5oQMyv5/9LhMhq3kobehSkytoh25XYwPdNYPbUCTxOfcutwyDAtoFfbGkno4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgC3fKf9; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgC3fKf9"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b1497f0453so2177050eaf.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 11:31:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788719469; cv=none;
        d=google.com; s=arc-20260327;
        b=MDbIdJHRvfbHj0GPEiMYIuChBtTj44Lyt4C87n++4GmA+aiMBU1BOcryjmvOQWfwNQ
         jbqyeIZNeOiu1BjkGytemzIBuNyo8zxpFDNJ9zTMwCSED2a37GQraFwmlXZ0yKYkJwDn
         8bnWfNOFDraiEcy9maJ7XxNA0x1vI9NDNoFZIfiHtpiMNgQtBb7cjg7db1wjOEbGG4n9
         +e7GHwrSIU6oNk6O5As5K2w2WRkQv9YuQ4GHmYhP+/FjIn3H1Oy67cpcpVbV880192Ox
         VncFDtHURZ9I60KrbPaKDymxPMx9R7heO0pUoEnhVhILNPOA35CoDnTRh+66Xy84GxNb
         YcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gVW2rYt7tF88/8e8E+2HUuoezaWujAL+SsxCklpr1lc=;
        fh=gndar5MaTc54RX1GeFtywFiZP4118BjFkGpxVhWtc8s=;
        b=P5LEla6TENt7FpiKp+nVB2esBVoVsiRokJXZ5pv4zsZnlu4hO6UZH8YmZ4n/Nmm7ox
         9nUvZOxh4I5hG//rxRzNUgWRYqTsbVcDYX5/UNGd2RcDJF+cILrawgRYp/yuRC7kV59V
         +9WqZtdj9AKcLww7Vz3CFIEYQ7mz0qx59xDkWPYfzzyOOB8A95wIS2VAAzd1iPIh1fnN
         8V/Dzdoztu7KCGvwJKgtpDjALmT0jPmv9ZJYR8SW2ToaMTDGezXz9k5Gv0p2zvtyV1qK
         vYoBU4AmtdR1/DfIgVzEPuE3er+z8zx/dPs3dZICehubc0LgOoJJSQBGRaOgeRDhBkzC
         ml8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788719469; x=1789324269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gVW2rYt7tF88/8e8E+2HUuoezaWujAL+SsxCklpr1lc=;
        b=hgC3fKf9Q2lD71dMzFLPJ2/cVucXzJPmtzHUhRL7M0XxxAroZrsx/He6YEVtvKze1O
         ImeM8Go+plvjQUojcP7oT9PduoWF7krinnlvKgBVzWsMQp6/SV0V41QNH4uj0TuNV/6v
         /BmwAU7RCeBCN2XVzU1nrOIZBE5ErNrSSajDEU3zQ2lqANuPS2dvAp2mneXlnnSq0DEy
         FzI+pWyFpXsoTKrgFQwq2oD5HuU6g22qfWYho+N8u5FF5w9U2GLB0daAppaXjYhGz9bi
         skeb+PDQ09f7Fn/CUTCWKE9W3mUxYbGb5PfFhpfSrRYsCuUUEipcIOSb1meTmC27ANdw
         bLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788719469; x=1789324269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gVW2rYt7tF88/8e8E+2HUuoezaWujAL+SsxCklpr1lc=;
        b=GKG7T5sRAZP5b0AHonyRlu+lqzve1JWUr0Gfw9xF1h2PcdTZPeCyu5mL1kD+Wh2wBz
         H1vEQP/a3+2bNogVegnnU0oNxUr2WI4tyYJ9HNMGRotuYBgnQ3PQu2dWSQi3jM8d7wq1
         Q9f9FUPn8SpACN8Qd0/pnX3cXTfPeL1Zmo3Z4GtpixGO5KjWxNYzOT0flWtBZTL8MvFY
         Rk+GJj6zrGj2Gf5EMAP2uHPsOKA3pmZAbvd7SfyucJIEviE0EgNeOZxqqLt/MaaUods7
         T9dnV7nqNqxkWQjJt/+eaami52lApBrxoFFpy3vlQuKXG/KMAg+WxQBNLBASTYGjc9cW
         ggoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYA/68uFUBLd4utXsY98ENPtg8X2HYxSPabWfvXmL4k1hQ/cilqwgmo1C6L+Jkd3ncPdZDEWE=@vger.kernel.org
X-Gm-Message-State: AFuF++m92wHb3wX12RChEq8vA1RYOrJjMNaAMAO4zhLp1FYouhYqENgE
	+KopSq7lyAJ40WAV8+v+QdyfspX+fi3W7tM0HwDnsIeTD5ltjDrnFKw1VaLk5rGajCFp4btGh0L
	xugBDae72TYBP3CKjVaelxCq4qdbUlLpkTRdO/T4=
X-Gm-Gg: AYBFou1FGWFWdYlalOI+2GnA7dDF3JoUHdt0M1dQqcfg8cazqtrrIqEETgHpd4XYdpt
	iwb9Ag1WGGeyrVXlxhPzEG3z8RnduXAHayK4YlutTr5eBkNm7jmxZNQhX/PCAQVvNeaQ7AGxbNH
	sOuZ2/YKtlw4kcjpZHj8IRfk0bSRaHonoy/JbxPSNrno6udGdS83VrRXa8HqluDNDzXM7SaBcB8
	zCn0rUK7h487eZGk64N8NYIvN1jbuoIhyAtju/DOSeu6CvWCQ6y9jS8UX2Q7EwQek2c4yuPnLMG
	ryUwH3U2AtkTI3gwxgckk745KQCU7JDappKVT7ubhOHa3DRZ38UdsZoNlEnYpHAARmVQLjLo7x8
	9RcI=
X-Received: by 2002:a05:6820:1987:b0:6b7:46fa:16a2 with SMTP id
 006d021491bc7-6b746fa1a6bmr9651192eaf.55.1788719469386; Sun, 06 Sep 2026
 11:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <CAAXyoMN-RX1aY_isyajES5LgiDMp7_YTbM=jiS6d-8o2kKQXqg@mail.gmail.com> <27a16f29-14a9-40d0-941b-f07d5b63ec4a@motor-comm.com>
In-Reply-To: <27a16f29-14a9-40d0-941b-f07d5b63ec4a@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Mon, 7 Sep 2026 02:31:00 +0800
X-Gm-Features: AcwNN1UZ-8BrSMDGVBN5KLRtkn4qqRe-CbA17Xg-DeFLgJqOf9TG7E-yF7aBSzc
Message-ID: <CAAXyoMO0MpXdvRLHow8wfe3vBj=VgQMz8ZFExnQshB8uVNH43A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/6] net: dsa: motorcomm: refactor
 registration path for upcoming switch families
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 10:08=E2=80=AFAM Kyle Switch <kyle.switch@motor-comm=
.com> wrote:
> >>   static const struct of_device_id yt921x_of_match[] =3D {
> >> -       { .compatible =3D "motorcomm,yt9215" },
> >> -       {}
> >> +       {
> >> +               .compatible =3D "motorcomm,yt9215",
> >> +               .data =3D &yt92xx_series_info_table[YT921X],
> > Redundant if you use both runtime identification and the match data.
> > Also I'm concerned with early IO operations, although I didn't see any
> > incorrectness here.
>
> Ans: we have considered this issue before. in the next version, we
>
> will consider whether to do it via chip_detect() or using indexed
>
> assignment. From your suggestion, what are the side effects of each
>
> approach and which of the two approaches do you recommend?

We didn't use compat info since we can do all the probing after the
reset, but I think the compat info here is "just enough". You can
still change your mind in any series later.
