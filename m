Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E3342515
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476475; cv=pass; b=S3Myz4yzj1H5mTn1xetQ5QnlC/2CqojdZKbS5msfVKjNbMjAD/9b4DKuHi+EBu9pxXhL//upXma1IfB7Hprrj7S51A4qngd8rBrXi3kij+VtB2JaZaoB5+NFd0xcYEK6QpfeUro8p37Bkin4LTW74XqWH1JxFNy5G+QXEGFW1A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476475; c=relaxed/simple;
	bh=AR27I5Ki3ewVRGo7IJt4MfIlVX+bMBi1Sp0hAYyCRnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWbh5LN/6PtyiEq+ku0QPK0tajNz1y/3HQH/tjcpsVAaZv8e1IU+W+xtv7ugDcfxK5HwQ8tdmZxZJIo589fSy0AT6UL4Jo7dckdgtenu6kr8Z7P9I7FT061mUdz0kVk17rcY9Zu2xNN5RVu+w0DZJNMEVuL98g9DjUIHmjcAMXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PiWdzfKX; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PiWdzfKX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so471288f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 22:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785476472; cv=none;
        d=google.com; s=arc-20260327;
        b=Jlgjz/pNM/EKTjGQQDs6mnu6NjMnJVo/XbwHzCB7vN550hVtGWYK5+WWrtyiokIzJF
         NDC3FxyeAaqO+OckIvmExlPiXzLdceuo1bdSo1OtOaQ7kmBkY964LCuxJ1H5fqZy32BT
         UYx+4db0AfpRVxF5HbC753WdEqRurxMtecMDN75R5zdTihW5En4lS3yKYTeoiEvxhJy3
         n0ye4GMfes6ny5FiP0pMFVF/qOOG44cjzJpdPFuXIy63E1LqPXUjwZ5r3jLVjZ1JwFhe
         p+6kSDMuDdWOW0OH9UaT3XfXiLCLuiOuRj8Z4Oe83R0ceSn3wVs/VpA2jwmPQMtWPnnO
         99vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iDeCsD2jnEkqh+8PhJxykymD/y1w/DGjo4spPTBaDaI=;
        fh=3EMzxCb7HDb0HDCDAX/EvuJZr4ilJ5ooKlw7u8Dg+uc=;
        b=K9NTqY9iXeTfyUpl4VQU7Rj69DpoUjf3JyGvdisBX9AWs6O9J7QWbep3+UQpxNgESV
         ssoOvtt1Dhm4Os4rkgZbOiBHcyymuwhqev4D4dU+5UXHhQ/LbGTsdJzd9dJTOelLaBas
         dT6eUY814PVKuRMWLrW6W4AFGk0pgzDnXlgF5wW6AT3EKvrZQSB+zvw0kd3zFpgnBlXS
         aNepxxhdLEfO3yjq+BXR5zqzpLUKdCqe98jFQtazTUkRV7XdLlnsKSsXyUkO6tI7B20g
         2I7deIYDaKuGq/HoXLl+W0F7dwrt/a82LS2lT+lH5W5I6ixvGzi8ZfBseNwXU4gOKE10
         4AyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785476472; x=1786081272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iDeCsD2jnEkqh+8PhJxykymD/y1w/DGjo4spPTBaDaI=;
        b=PiWdzfKXa4yb2kBe04LLco/91Myt7JsRWFTlSuEdeSxev414MAD8pHOTKoD2b+ec2F
         yX1755FKudBwF1pjaLR9CThMVgBKxZYYDE51r02GEhuRkYRMXnUmClD118hT1GSEiDEU
         OvQeke4WbEUqRgX6gGm+nkiSWEQYSqAsHnsBmNCzQja68sN3d6HYGsEkRpdIHCiudguX
         epYp2fmpK40Ex413q9yiS7a/jp2VgBB4mo5l8V+HhWPj/K9morHryIy5X3ntoSA4fOEZ
         o5YV8un8RIGN2ot558CU73Ky+v+ytmxlNu5xNm6WAhcoHQBQWPt5HXRmDYBBlkKUlDJo
         1V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476472; x=1786081272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDeCsD2jnEkqh+8PhJxykymD/y1w/DGjo4spPTBaDaI=;
        b=YQo/GX7q+y0+TBljVAYbMv4qNncB74oIXXruYy01GqI5FgoOiifrv+xzCWb4gkwhRF
         ZRvM72QysB5hJw4upVCw8+XuBJ9GhzEj+e1xXClHAAggQoh78d5z+CVH0OTpiM+lCrJl
         MWT4JGEwPjgQ8eKsgKHjJBlE76JSGcWBOnCyBj8uoNJCoMtntVUmIqPuW8FRvpJfuEej
         An+jmQzmeF2dMw+MUMwMT9qgogH04pKAXjMtWGT/fxS5t9H/tgCHa0vbbaM45uWnZD7y
         zKs+O9GKG4jcHKoKOgOWdLPKwIobUXin86uNIzJw+AiCT31Ra5Fq0KY+ej3zg1pSaZYw
         hMmw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7AKLziciPxS03uqcRU3ieZk6VrKtb47B/otzmw68UoHGz78Sm+PI70+n25hpEIWPTDAuPsKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIivhfl+WxGn9uBN9HgU0l6XlOoa3fXTDVKxO8zBUxs9f6A8D
	fLjPI4k01VfLj4/IKM4j8MlA5OA2bBfabWJTk7IbWAS5CvPFM5qYxj5sLp3zNSRsitYGfc3xN93
	QGu3qMnsyvxDcpoqkJHxdMW7Cu1Tgds4a0OQMinuVT6eYHskf1yaFzlOi9w==
X-Gm-Gg: AR+sD11s6qe9S5H9/K4XC5Pj5p0besWjnuXNERsxN8WA1sTorVUz/KHN5sfqiqsytfB
	XhQkWpRIaOIUpwCmoGvFZG2l2q881rcwxyEhe5TgOisy6c8T+ZYPGw73+ZTpntNlrSgMwJqG1J4
	/W3Q2LPCD0n+8oOzmqFM8f+Q3FYIcruGUF50tMLtIK9qbHMULkFBlE8tgYKLm+TkyExeZeRCs5O
	2+OLqEILF0+TIA6zAA7/DTLsffehWSzle/nZc9B8iYSqYbbUV9Ru3cMimPcfrcfZs20bdk/Jlis
	nNsTeOq7bW8f5AbJ16qJiGfnoOZLbOHiPzfdatHqfU7Y
X-Received: by 2002:a05:6000:40cf:b0:47f:93b9:b76c with SMTP id
 ffacd0b85a97d-47fd2b6f8c3mr1596378f8f.56.1785476471952; Thu, 30 Jul 2026
 22:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730144652.5715-1-sebastian.chlad@suse.com> <CAAVpQUCkKUa55gJTqObD_6RNLDVdXqaak7Wst8o20X4RDnSmQw@mail.gmail.com>
In-Reply-To: <CAAVpQUCkKUa55gJTqObD_6RNLDVdXqaak7Wst8o20X4RDnSmQw@mail.gmail.com>
From: Sebastian Chlad <sebastian.chlad@suse.com>
Date: Fri, 31 Jul 2026 07:41:00 +0200
X-Gm-Features: AUfX_mzTjTnAkbJkXXV3GmEClRmpSRAUTAD5_3ZjEW0c5ViTuo7k36mqGq5OhGU
Message-ID: <CAJR+Y9J8d2uCN08+VYmsa4tKC7G5joM+DwN+PbskVDjf==A0=w@mail.gmail.com>
Subject: Re: [PATCH net] selftests: af_unix: skip scm_inq tests when SO_INQ is unsupported
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Sebastian Chlad <sebastianchlad@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 8:28=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Thu, Jul 30, 2026 at 4:46=E2=80=AFPM Sebastian Chlad
> <sebastianchlad@gmail.com> wrote:
> >
> > SO_INQ was added in df30285b3670 ("af_unix: Introduce SO_INQ."). On
> > older kernels this returns -ENOPROTOOPT for SOCK_STREAM too, which
> > scm_inq.basic/partial_read currently treat as a failure.
> >
> > Enabling SO_INQ here is only a precondition for the actual test: the
> > SCM_INQ/ioctl(SIOCINQ) consistency checks that follow. SKIP when the
> > precondition itself isn't met, rather than asserting it succeeds.
> >
> > Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> > ---
> >  tools/testing/selftests/net/af_unix/scm_inq.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/test=
ing/selftests/net/af_unix/scm_inq.c
> > index 6268b5bf50be..2868cce61a9a 100644
> > --- a/tools/testing/selftests/net/af_unix/scm_inq.c
> > +++ b/tools/testing/selftests/net/af_unix/scm_inq.c
> > @@ -111,6 +111,9 @@ TEST_F(scm_inq, basic)
> >                 return;
> >         }
> >
> > +       if (err && errno =3D=3D ENOPROTOOPT)
> > +               SKIP(return, "SO_INQ is not supported");
> > +
>
> It seems you missed this in the few lines above.
>
>         if (variant->type !=3D SOCK_STREAM) {
>                 ASSERT_EQ(-ENOPROTOOPT, -errno);
>                 return;
>         }

Isn't that just a guard for not exercising the tests against dgram and
seqpacket?
So the if condition I proposed is for SOCK_STREAM where SO_INQ isn't suppor=
ted.
When I run af_unix against 6.12 with no SO_INQ, I get both
scm_inq.stream.basic and scm_inq.stream.partial_read failing. With the
patch, both tests are skipped.

Albeit I agree, if this test is run for stream af_unix not having
SO_INQ, it should be excluded altogether. After all the point of the
test is to test behaviour of SO_INQ.
Still marking the tests as skipped instead of failed for older kernels
is somewhat useful.

>
> ---
> pw-bot: cr
