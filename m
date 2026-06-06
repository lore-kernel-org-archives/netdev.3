Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2593C0625
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780775445; cv=pass; b=OGAV0CnEoiEB1VOtTT5BvL/MoByqJzDuIYacZUaonC6gCB4gnuJYKxo+bhIX7LXY6PIkeRaKmz3mKNfJcctKe+X40e31omYdvyuK/oRZYvQODoD0q0hkoo1dbJJLhSpiaak8dhKDnfaxW1sC/boEG6o8h1gGG7h6pqtmYod0VuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780775445; c=relaxed/simple;
	bh=PoqLWTjEnpXPFiWOEo7QlaBnog59UdJh2kGKh6aLjDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgwBDMfcO/UmDco2OazNOyMANOa+4FbrlQxgoXQ1G0vUnXTntzcheIeRuV6B8V3RMAndLOn0taIRKcAKc87hKPJgDE6Pm1k3pqcGuNDdX/xHjodsmZa2pzpxejebSm+0PWbhm+GbSRRi+92oHeQTXj/aiKhD1GITmByUKrD6TTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrtfXb+S; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrtfXb+S"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccf7b7d188so32160586d6.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 12:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780775442; cv=none;
        d=google.com; s=arc-20240605;
        b=WezrZ38fG3QZ8YKgTWm82icvqUgMPbChHQz002B44qALiPFY5himrdXbvdLcG0JXzf
         sDeOwsOszQHMYDH2msNi7Dxm5MgEqN8zQPZOAas5dHH1zfc7YI/lrvn6PFaKKkK8cZr5
         m6BH+KioQtzecmodIs/qKqlQCBqHvmaxcnxQczWQMd2Q0uJ7WpEbQj1/QKtWpLfwBotL
         zDwSdwMYHgkteV0Gzb9u46Ck57IuBAYs/5GMDMOnI43TpEkmPZrUWR/C+7OXZcho7swZ
         lxGMOv7+J6SmDVBiH5SZIEwVUMvSlNaD/6pDtuOblvHd3zog3Gz/b26rjOWqfgDcqQmP
         IUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A25i6mcyMtjQHOEeeuBAFqnDAgaTUE2Es59JHPZd0DE=;
        fh=GmDy5WTwPR6Ytp+Efi9HdovhNQzwwA8fz+eGRVajEYM=;
        b=MmRvsXqoBWUzJw22ErV4zm8HHfp627OftqN6JoOVX1dYT9OmEKNG+u1n/RuMor4bMq
         KVD9+fHHvmdICdxmgQHwHH8p14mwETolSmI4AHZW+ibrGTZkHgZVB3KCYQVYF+htsiVC
         ICPMtlQqeF8FfZHbsk2g8F2gtUMYGquhbrwQLo5dvCOJ0/PFlba1b51kfsTngLqmnuGT
         p+7/dZCk28GFbevyyFNaOeUObRrXChEHXoe9pvQOwYdNzUDiJMtoyO4jjSwo2KVvbqUK
         zkDd2CmZS77jjeTQXO7JC62G6kCJa/G5RNKzes/8VbpK7YMJf6twp5if+fOYc10KsC0I
         Cajg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780775442; x=1781380242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A25i6mcyMtjQHOEeeuBAFqnDAgaTUE2Es59JHPZd0DE=;
        b=RrtfXb+SOrnlebbnMOqNtjJ7VY6gxWnqbOV7js+LJCUalYTq566DgV94EEtjpUoIXX
         bIs40D/k3Uq4/XYNwV1F29PMOeq2Fny/Z8Q5SqOFjUa5SEdtsDO7wBJMu1hfIA9yovxo
         FP6BON+fFMzBVHFgRWGCjVMjll0HuWPMiE+rdSbg5S1uJRtowEz71+IoguwYxch3kBdJ
         cXYrWVlRFxNV6+GanGE3Q/E2eXpTLPosjkw0Ir0+uqMAs0+PG1RoBRgd5HiHkwTs3fk1
         ZgOuAMFxWYWeSVfZZYcqNefPssMdi1E27WowWflHEBYVKqTntGoHMI0DJYONw4v7YXEI
         E1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780775442; x=1781380242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A25i6mcyMtjQHOEeeuBAFqnDAgaTUE2Es59JHPZd0DE=;
        b=H/AHwdX6fmrmrLVu4Kok48mzIX8+roRa/WSC9259D44d/bR7Czughbe92d8nLNbpMO
         sCjYBUWAyxlld6EuLQUHo5zSgkisLylNRr0Vz43055cKdkFBCCVOnT33TSALEfl2cFlL
         npnbz1ERbfTiRc2p40bW0RmpxfVVrKmeATipzw3Ir/hYSCrQqA4dY3FkUTYLZ4L1JLyz
         SlKRNTYLCatPunYPS4BGOneXOO2C5EzzH2Rnq8Rq6LuoAkxFpXgwPvhdPo30+130OFp+
         75yb7iModuzs8OsipTrWedZmx2Ugyju30bebkWMb3RkHzHPcMKQ/TDyAT4RvIXwMMtzm
         LTHA==
X-Forwarded-Encrypted: i=1; AFNElJ/cbFJjBiMTzrmMFa4xKIlG+eY1XEnTaDa1MeyqC/83su35uyTkKztoZd6f1I8IazdQanQLppw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPv310gjYDpb5P3zB1LhdwHoMCEr4Q0w0IzLkz4t9oTNnPFXv
	pZ9jQsPVEeiVpKWluM+vmJEn16xARw/jAMPHHL8fZigadD84neD5KgQCcPJVqEDKC2pMLvheK+n
	nsRNrXzOo3hFcxO9kVVHPZCMfxveYBzY=
X-Gm-Gg: Acq92OEXdS26UT8IcZH6V6QXG6C47StToy5oTzYnpAZH96GoFpffDQ4qrnhXy+IAi9q
	/R9cofTJV8ulIyQnVxcE9b5JhtnuGLK/g33BVWgocJNyJkcajtWYXowkfLQBA0ERB/ETE+Y9YVA
	m7OkjYYmoY1rIFTU8TBoEq1RZX4EtslJFV/PNInYI0IwhzWmuVAmeZY6bUh/V9se7d68AJ6vPXU
	UCjaMtF5Ze5uAylUMcsFxvNpXRHd0+LM8QFIsagD/95uY3/BF6TouU9rwfZU04swP5jHeg37fmu
	P7u7t3L77hKXDYJsJlpKinkK03/YgYW8vyBq/czW6lXoKKpK6w==
X-Received: by 2002:a05:6214:810c:b0:8ce:3868:6700 with SMTP id
 6a1803df08f44-8cee6252aadmr139372646d6.34.1780775441856; Sat, 06 Jun 2026
 12:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530224646.160777-1-manishbaing2789@gmail.com>
 <20260531101237.13c5580d@pumpkin> <CAJvdc_fwRc8QH=DHPtTNiWEg3bm0qqs_-jOwDQ4frUJLLfCQPQ@mail.gmail.com>
In-Reply-To: <CAJvdc_fwRc8QH=DHPtTNiWEg3bm0qqs_-jOwDQ4frUJLLfCQPQ@mail.gmail.com>
From: Manish Baing <manishbaing2789@gmail.com>
Date: Sun, 7 Jun 2026 01:20:30 +0530
X-Gm-Features: AVVi8Cdkscdkmhq980ON743TeeweTrTz6i_fEZPLE_0W4ffSjJrU6UElNS9B19E
Message-ID: <CAJvdc_fTNPbJcgVv4kTe7VP9ibrzECHkad8Uyan8KrP-=WTyOQ@mail.gmail.com>
Subject: Re: [PATCH v2] mctp: serial: replace memset with zero-initialization
To: David Laight <david.laight.linux@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Just a quick follow-up on this thread. When you have a moment, I would
love to hear your thoughts on my previous email.
Please let me know how you would like me to proceed with this patch.

Thanks & Regards ,
 Manish

On Sun, May 31, 2026 at 3:06=E2=80=AFPM Manish Baing <manishbaing2789@gmail=
.com> wrote:
>
> Hi David,
>
> I understand that this might just be unnecessary churn for the
> networking subsystem, and I am perfectly fine dropping the patch if
> that is the case.
>
> However, for my own learning, I would love to get your perspective on
> this. I was carrying over a pattern from recent cleanups in the IIO
> subsystem [1],
> as empty brace initialization was noted as the preferred approach in
> those discussions (including by Kees Cook [2]).
>
> Is the reasoning behind that recommendation just not applicable to
> netdev,or is the policy here strictly against code churn unless it
> fixes a tangible bug?
>
> Thanks for the guidance.
>
> [1]: https://lore.kernel.org/all/20250611-iio-zero-init-stack-with-instea=
d-of-memset-v1-0-ebb2d0a24302@baylibre.com/
> [2]: https://lore.kernel.org/linux-iio/202505090942.48EBF01B@keescook/
>
> Regards,
> Manish
>
>
> On Sun, May 31, 2026 at 2:42=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sat, 30 May 2026 22:46:46 +0000
> > Manish Baing <manishbaing2789@gmail.com> wrote:
> >
> > > Use empty brace initialization (=3D {}) instead of explicit memset()
> > > to zero-initialize stack memory to simplify the code.
> > >
> > > No functional change.
> >
> > Isn't it also entirely pointless?
> >
> > -- David
> >
> > >
> > > Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Fixed a compilation error caused by a duplicate variable declaratio=
n caught
> > >   by the kernel test robot.
> > >
> > >  drivers/net/mctp/mctp-serial.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-s=
erial.c
> > > index 26c9a33fd636..df721ca4e07b 100644
> > > --- a/drivers/net/mctp/mctp-serial.c
> > > +++ b/drivers/net/mctp/mctp-serial.c
> > > @@ -536,13 +536,12 @@ struct test_chunk_tx {
> > >
> > >  static void test_next_chunk_len(struct kunit *test)
> > >  {
> > > -     struct mctp_serial devx;
> > > +     struct mctp_serial devx =3D { };
> > >       struct mctp_serial *dev =3D &devx;
> > >       int next;
> > >
> > >       const struct test_chunk_tx *params =3D test->param_value;
> > >
> > > -     memset(dev, 0x0, sizeof(*dev));
> > >       memcpy(dev->txbuf, params->input, params->input_len);
> > >       dev->txlen =3D params->input_len;
> > >
> >
