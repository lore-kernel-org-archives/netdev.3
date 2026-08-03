Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF903B3888
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793491; cv=pass; b=MoQRyvjxvhmuRdqnb4Hq4enbMgIrnpH0goF9+23Q+j3IKJUo9Rlm19LTlQRQkRjI3CB/7FtrQ5yON1IUBpGNEiCAI+hoEU7bc/a9P1LsvGIzO7TsRmlN5sFHFEmoLDSIQqUxMIyWzeu2fzF5WKuZ/wMGQ0vS4LINEw7aY1GXW8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793491; c=relaxed/simple;
	bh=ui/KQY+5dsLrdrQl1iCkW0wwwh4fV+6xqPKYAojmb18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkseie14mLE8QFEAaPBvt7vQpNQUGOUxCLo+bhBx7NjGNs//Ze+Gwq7ZF3qSTG3xBtTsURj3coG6IolL70EOCCz6NJMDIdVzundppCfoM3WrFbUJr4eD0nkDP8AGCgN58X3qoP70HUr6aQIgCnMyvE3O+B2fLzpqFGI1Kkvcl0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=lDg67srm; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="lDg67srm"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-754acc61e10so1476707137.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 14:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785793489; cv=none;
        d=google.com; s=arc-20260327;
        b=W8m/BTkVcXHfM3o5YK0HNiteWpTdnu6vB22Tc4cSuEzTLDEkj7WSe/uzKm3m/6yk+4
         eyNamkp5n6RUnABg63WqNmecQomqLUcb9wN5y1AB2/OOH1epZp2/9XZjHjWYvjAX2hpO
         Lak6Ifz0Rl5bqEEBx7PLQmdz4BQzFys1EeRs02S61GNWV9mBtNJR1CoTXudNdTEoVheW
         TkKq5bgtD5IQnu5Iw2zSiUX6VzWZWhis2zndiCUZuNT5uY5nvknwrgITAy9AG+KETxns
         UeMMXzFE+uPOq2y/eCnHJQz+bMpdc6RkpXOJjczymVbcdNzdlpstUMn/ZvDMsOpGfzuK
         FlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VsZupxfyCeqgkVu86UtlJsHI0OUDWnkzyazFIeS9Xcw=;
        fh=RNRDstDh6/mVTGDTxNOJzVFGFMLrZRCriDHrlRp+koM=;
        b=U4FJ0zwVnRY2WgxADdu/YoA/UY+Ird83VCa2pEPO6oSmjzxo5UjxysMSFvshTtTM+H
         8c/KMQqpoPdt1essUtsSk3M1YL5wbQUfLuWQKXptzTpmHdjM++FvNyxbkiBJdAPC3Eyw
         KiEuEF+H+1AfBKR0nFJE1zZdFrH+PRUVHGqXEtAXi3x0dHws/NXBgqqEPf3injes3Guu
         vFlSiTfhbwmfSTTePTWVAfboDKL4uMrepWwA1Pwav/Ss0qsF054pdMUS7XtdOZiZHLKC
         6Avq8/oKBKxKk8sGR5mxZ5dAm0567Xdw4UAqL0EulaIcDSoGu00chwGJbZyXtCuD6ir9
         1IgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1785793489; x=1786398289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VsZupxfyCeqgkVu86UtlJsHI0OUDWnkzyazFIeS9Xcw=;
        b=lDg67srm89saFkiDv/27VT1pyge5tiFQXXWfgqLaejm0FV2a+R4N59+ldtJyitWOYv
         BuS9lm2rXW/n8+B807z4ALO9XqO9xNKe5QCJ2JZjZZn/JDanCBHuy4hbXh+bkQwptnQ2
         aVRMLeFTyT/zM5WGL/c3kkLwbwaPx+Erf47t492xSg5BxGbn3Rs0vRhvSi05zLP9rfR+
         GZi2+MEGJBF7NAjP+vdsbc3arvBc4HmG18BKuuBPr+UshMyKB01TqR3KUBOXOx324myG
         ZjQCGn2S/5cwcigje9QTFKXNOZLAGzKFQBjbsCtVrCxR8UuUHTRIt3DjuQGaFFzorDie
         V3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793489; x=1786398289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VsZupxfyCeqgkVu86UtlJsHI0OUDWnkzyazFIeS9Xcw=;
        b=DJV2gFtPl1hwjKnCcErjE4N7+pbEdAPTiQJwq4/AaDMVqitjjLl2LMG8EGmaotO+Nk
         eb4qX+9MpPQjGCZbT482U2L03+dr4SSaggZflPufWB1rz8apmcxNWJjSvXf288YtnyDl
         lEnQHB+FcM6abHqaFymh9tp/0hQO4CCWez87j4WoFbjAcfjEzt0I4cEGDBrYn74dIktJ
         lIrbv6gu/ouALdj5hH6lmKordQ6BpdY89TJBkQFUdswWh9wh4z+RnleD1oo/dv+dO+CP
         /4CpfHoVPSGvs2kdicZPia9IBVGt3rPjUHYloDr7kbuUkgslXCUANInufnBKw49W57tu
         SDNQ==
X-Gm-Message-State: AOJu0Ywl7UTvFOgUpa2tvXEoeVqFXL1tS5xSVupOee9euJLThR23zqnq
	p++gUgniCuI4ekwX6NF+hO6Km2FVtRozz/V5dBlOtc22HAgmt3Fvch2zZ45pX2cUWNZUjhajb0F
	o86BvwsIhZOvu1jlal59GAE/1/QH31+SK/rDr9zuIWw==
X-Gm-Gg: AR+sD11YqgY5Zl5M9zDRH4LHQ7qn4nSXNORh4Pi7K+NkM78vy+SLTZ4gi5Yiw0I+e83
	Ub3S9fZS2/vNtl7AIIMTbdF6bDEx2h5cSptEnPve65urCXL4IvjanBzXxYWqsIWOb+ZLg/SJeyL
	im23kGKB/sF4ISb16vOGiObzMES+MTxuPkU4/KZgFyLlLCwp/4DHM9lO4HDs0IusdRzFyqUGzFq
	JJL8UcrPK864Tah7VskXf8lSIjIBUIzpm1fIactaBP6tSCwqXDaoffT0kgp/8LxKkJD9JHcu20q
	F1DoBJ5By9bXUa5C7mQx33Hn2gxIgKVR0P7PmpHPGRMOR4f4gpED8ylhcNOK1srZuq1WrR6zfB0
	xk1YEXBNfFa7KVVpSDM9ijp7g5ZeaA6XFq4BC8rusGJA8gxP6iwLLwevJUAbul9iS1zYGv74RwN
	SY93H0J+78CnzGRUGTJkshHLUAkXqWrqzgx0GnvH+6
X-Received: by 2002:a05:6102:c08:b0:74c:7fd8:73eb with SMTP id
 ada2fe7eead31-75b2196451emr9306219137.1.1785793488812; Mon, 03 Aug 2026
 14:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709205325.1591196-1-rjethwani@purestorage.com>
 <20260709205325.1591196-4-rjethwani@purestorage.com> <e8829e6d-977b-4aa5-b823-9bb723219746@redhat.com>
In-Reply-To: <e8829e6d-977b-4aa5-b823-9bb723219746@redhat.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Mon, 3 Aug 2026 14:44:37 -0700
X-Gm-Features: AUfX_mw2I3l0JRdtjNSf1r-WBNRYRZgA8CT0DvPEA3UasSFhxIEDxQd1bZwg-ZU
Message-ID: <CAKaoeS3PHWk2krOQ6fo1FRotfVdf1KpEytbLhFCm5vjQZBWdkQ@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] tls: add TLS 1.3 hardware offload support
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@google.com, 
	leon@kernel.org, andrew.gospodarek@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 1:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/9/26 10:53 PM, Rishikesh Jethwani wrote:
> > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > index 8c588cdab733..c4c15c0e731a 100644
> > --- a/net/tls/tls_main.c
> > +++ b/net/tls/tls_main.c
> > @@ -714,49 +714,64 @@ static int do_tls_setsockopt_conf(struct sock *sk=
, sockptr_t optval,
> >       }
> >
> >       if (tx) {
> > -             rc =3D tls_set_device_offload(sk);
> > -             conf =3D TLS_HW;
> > -             if (!rc) {
> > -                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE=
);
> > -                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDE=
VICE);
> > -             } else {
> > -                     rc =3D tls_set_sw_offload(sk, 1,
> > -                                             update ? crypto_info : NU=
LL);
> > -                     if (rc)
> > -                             goto err_crypto_info;
> > -
> > -                     if (update) {
> > -                             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLS=
TXREKEYOK);
> > -                     } else {
> > -                             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLS=
TXSW);
> > -                             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLS=
CURRTXSW);
> > +             if (update && ctx->tx_conf =3D=3D TLS_HW) {
> > +                     rc =3D -EOPNOTSUPP;
> > +                     goto err_crypto_info;
> > +             }
> > +
> > +             if (!update) {
> > +                     rc =3D tls_set_device_offload(sk);
>
> This largish chunk changes the whole logic beyond offload update for
> _both_ TLS 1.2 and 1.3 with no obvious reasons and no explaination at
> all, nor in form of code comments nor in the commit message.
>
> Among other things,  tls_set_device_offload() is now called
> conditionally. Is that an optimization? Was the call really unneeded
> even before to this patch? At very least such change should be in a
> separate patch, which reasonable documentation/explaination.
>
> /P
>
These changes explicitly reject rekey attempts on an existing
HW-offloaded connection with -EOPNOTSUPP, since HW KeyUpdate is not
supported yet.
For the SW path, rekeying does not need to call
tls_set_device_offload{,_rx}(). I=E2=80=99ll create a separate prep patch f=
or
this.
