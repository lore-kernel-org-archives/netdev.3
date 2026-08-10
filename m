Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72B30EF9A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377337; cv=pass; b=XOEyHkbLqvFeyQCqZPiexk0ynCHy1Q+g6CXHpBLYBVgNU+wfQB1Qq6DHjanL+tyrhZcmQIK+eXRse1SteqoqQn5wFgNyoFgyUU4I6EFBKy90TSSoYUbloaUSs4ja1HAiIg/lPluNlnbwkac4U1p9WeqzhqGdWtV/GAZimnqXp2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377337; c=relaxed/simple;
	bh=5Uf9/VcM5B9RSVuaqj+cody+JCYqoXGghFsCIUOSork=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6118WDYA1gY8t497hfGtBQBhMsWrpNdhSHM9t9nN2peguZWQgUNaeYsk0gY3bBTGT+xHx6ytk9WiNtumw1O+ay4ryNBsshkDG8gJcA4FDnzOdHB3HudFUo3qn+hLPq3Xv2Bij1fEPNkvcRhNwjGWefwb/XlwZ7Og48xM7V5iok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJVZAclM; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJVZAclM"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a1f8757b4eso13365a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786377334; cv=none;
        d=google.com; s=arc-20260327;
        b=a7ks0J0OFOmcP5qUld3nggNWZCay1PlqgIODFzdLZIkZOhvWBV9i2DPUWwnt54w38V
         9TJur7FMxFTerXF5997Sdcu/HPK1JKrLy/LpVhqLb9NbQVQxQUG2MPDtHjK4Iiaz0IaZ
         dcD2boDm2qD3586BibMvOTEwm3Pf2tzs4xgaiueqap1liX22+c95eo4WZjKKlkBh/Dvz
         F8st7CO2QPn5UCb0AujuxKrOZDpX9L7Y5MG8AgpwXI0c1UhgSv3k6TCpWjcpkrqveP+x
         oIN2wwvszwlqub4j6Z4my4ttF/X9lF2zzLnyhziYUtzglrrZBT5iXjzko6HfhzQKYn8u
         uPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rbA1CHur0GUQ4jEFBypZks8oGwisaoU+6uuW/eNA0YM=;
        fh=WqpL5wU7XYeBorTa8uvSERAcgAPUmoPLlXJewZa986o=;
        b=Zm+zlufNra5sRsQRGlXUHIUcBv67l9Z2npw91/9C89sxfc0bXw61mi42lfHfGgxgge
         DuCiiXe3Mk51DsB9bsXxj/29lsq4iwMevJYtH7fHJ0mbJFkjLSqjSz9Bl68/OrJiLiYj
         iw+InTcVYMVGd8mlBFBq20jBztvCUdNwG3rdpySes/VBcG3A3utVitpMDj3meCZUZU8x
         7hdZBMlhbPgoi6kvcLTVbWuncl3r9A+LNfyEH8DlfwRsCaM4G3c1p7UHRXF21UxUUP+s
         Z82m8xFvBt6pAY6abi5I5nJM1Joj+8MaQ3XcfckJUp7RxUYJZTemnMm/PsMzspysM3sT
         vojg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786377334; x=1786982134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rbA1CHur0GUQ4jEFBypZks8oGwisaoU+6uuW/eNA0YM=;
        b=lJVZAclMckdIv3T/BrhyppoMo0miY300yVILAIfKFNDZMUJpJ9dx49DHg46/4c93eJ
         JUIzQEd+fV8i8RkMTX2Z7ZEpUKDUegsxe70VuFsC7DlcKWSf7sjdq28JstRY3Q2sTe8Q
         XxR+R0OT1PQQBYxAmhK9dOKbkE8pzgoaU98c341ZWynW5TP6NQzuv/NZhvAHSHflyr9P
         fA6f+/99LokJu3FIWr94YFOWv5fo6vnd63bylw1pbPj5W4ruMDmXlrEiy4MXWr54DSLg
         sCdPPrNonC/FgDeaWX4wsdZU1yQz0IhaR0FzeEmpQnznJmfjXaKYj8XnUhwiKWO4shki
         lWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786377334; x=1786982134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbA1CHur0GUQ4jEFBypZks8oGwisaoU+6uuW/eNA0YM=;
        b=OBU9ZouNQtLEUGtM4ehOLUz9uOc5U/kS6aZwvHWdPJZiR6TRS/z2W61pjkH76Shxlh
         ce4yx+aIx+qVibNfHAcvIm9bRm8yn6ewi/aWZzvqAmFMq15ZBiI3vNpc004gFJNlYqv0
         AvNauCgeqNeom6hZGvQKpq3bXQT0FtF9bo5lieMupK3tq+cPcj1m/lyX4VHtobrV6Z3i
         gw9vagNZJdccOqRDE1T8AtGTis8lCc5XUpY6FgbmpMMgMC2KguwxWYNiMQebwZki2q9X
         aH8vED4zyTYO/jOcbPbErS87P8JNSFC7bEIgCdsEt9DHCK2TwIrLABnfEBUEYH+xl/k/
         Lcjw==
X-Forwarded-Encrypted: i=1; AHgh+RpKY00Y3sZEpZ+ZK+9IXoIEC5B2R/sTHGxzFaqFaPUi5cAgww4PFaJ3RgYhKwA5P8uz24Ry/TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kpjVebTam8HRuiqo6Iamj1n9RNI3T2b6hJ08LDZgrMy3XXpr
	eXZb0ySFMxoWjoXWZOpUT3G9nioTIklhNucl986Knd1zxeXs0HN5VpIeGs8sj6c9c8ydJWhAMsH
	hY2YMFMhGM1xcx7v0vcZAkSn8W2HKirsp2eLn3hVW
X-Gm-Gg: AR+sD10f1VJiPBuKx0ZrRMXFImQ/mDyu4FSmPHQSb3wIt96kzH2B6pKgSqijVuTGkfs
	I2oe3tTab1gc/kSVLK/1wuVYngtcHBwhrIgEu4xWNZB7JVkfKjN5wGOUV2JdJGJx4fs8bvoxdsx
	yu33ZdwottRHe1YNM7y1ND3SfT6FBMsgGAoPX71DlPNfBBcgLoMVX4oSf8mg82azhVloSfdLkDh
	SUYFBvN/6uecodczH6GS7Bb1t0qgVcuwqHs+55bnrmwy+TddDWC86stJupqMfrREVyyq3ud9fo+
	2zugmSdpPon5Hnl0mxH4/AtplER9tQUTJCZ+cU+GHZuJ2iS6gkZ5bMt+lGr7IU/hIFGcqXjtL4k
	=
X-Received: by 2002:aa7:ca56:0:b0:69e:98c8:e958 with SMTP id
 4fb4d7f45d1cf-6a1f8abc5f9mr93172a12.7.1786377333065; Mon, 10 Aug 2026
 08:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807224315.234152-1-hramamurthy@google.com>
 <20260807224315.234152-3-hramamurthy@google.com> <724b2c8d-1481-4418-a10a-4331a620cd91@linux.dev>
In-Reply-To: <724b2c8d-1481-4418-a10a-4331a620cd91@linux.dev>
From: Jordan Rhee <jordanrhee@google.com>
Date: Mon, 10 Aug 2026 08:55:21 -0700
X-Gm-Features: AUfX_myD3XTlTxUQqL4tvfBeD_iQAwj02FudsC5BYAQgffmKvKyl1JjnqkX3W50
Message-ID: <CA+mzVttPSW=NKqqBwY9kxdL_r0hKzQfu38eZtmfUB6iaeHcNRw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] gve: fix NULL dereference due to missing ptp adjfine
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	thostet@google.com, ziweixiao@google.com, willemb@google.com, 
	nktgrg@google.com, pkaligineedi@google.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 8:27=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 07/08/2026 23:43, Harshitha Ramamurthy wrote:
> > From: Jordan Rhee <jordanrhee@google.com>
> >
> > Fix NULL dereference due to missing implementation of adjfine, which ca=
n
> > be triggered from usermode as follows:
> >
> > sudo ./testptp -d /dev/ptp0 -f 0
> > [  551.943697] BUG: kernel NULL pointer dereference, address: 000000000=
0000000
> > [...]
> > [  552.061946] Call Trace:
> > [  552.064487]  <TASK>
> > [  552.066681]  ptp_clock_adjtime+0x1c0/0x2c0
> > [  552.070874]  ? get_clock_desc+0x6b/0xb0
> > [  552.074825]  pc_clock_adjtime+0x78/0xc0
> > [  552.078755]  __do_sys_clock_adjtime+0x85/0x110
> > [  552.083293]  do_syscall_64+0xea/0x610
> >
> > Cc: stable@vger.kernel.org
> > Fixes: acd16380523b ("gve: Add initial PTP device support")
> > Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >   drivers/net/ethernet/google/gve/gve_ptp.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/et=
hernet/google/gve/gve_ptp.c
> > index 06b1cf4a5efc..1d6c59f4ead3 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> > @@ -26,6 +26,11 @@ int gve_clock_nic_ts_read(struct gve_priv *priv)
> >       return 0;
> >   }
> >
> > +static int gve_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm=
)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> >   static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> >                             struct timespec64 *ts,
> >                             struct ptp_system_timestamp *sts)
> > @@ -60,6 +65,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info=
 *info)
> >   static const struct ptp_clock_info gve_ptp_caps =3D {
> >       .owner          =3D THIS_MODULE,
> >       .name           =3D "gve clock",
> > +     .adjfine        =3D gve_ptp_adjfine,
> >       .gettimex64     =3D gve_ptp_gettimex64,
> >       .settime64      =3D gve_ptp_settime64,
> >       .do_aux_work    =3D gve_ptp_do_aux_work,
>
> .adjtime has to be implemented as well - neither adjfine nor adjtime are
> checked within ptp_clock_adjtime()

adjtime() can only be reached if gettimex64() succeeds. Since GVE
currently returns -EOPNOTSUPP in gettimex64(), ptp_clock_adjtime()
will short circuit before calling the driver's adjtime callback. We
will need to provide a stub for adjtime() when we implement
gettimex64().

My understanding is that fixes should only address real, reproducible
issues which is why we only sent adjfine in this patch. If the
maintainers would prefer we send adjtime() as well, just let us know.
That said, our preference would be not to delay the other patch in
this series ("gve: fix zero-length skb frag with header-split").
