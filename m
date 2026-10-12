Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2B383C8F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812453; cv=pass; b=unjBNntx4Erz+71i0DZnzSHc0xIYvF72ft+P7qOpSc9UYD/uXlqVssgl20f+EIjskP6MyzMpH+P7tEIsEwsgD3k1ayqAfdaAyUbrDPsuV4su+7MIr+ooPnNKguTttKOJnNkb9R7EcMjZGnSMh6ARi2RWLgsERurI6v2d7itYClw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812453; c=relaxed/simple;
	bh=tr28fG4ZEXTsiIAwMe0wjF7BnaOQzBQT7Xkb6b/2La0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMyxS5pLNegz6mjIgxwKYFRZfAVXZlRDUhg+2vMlrCnweFeMx3sMbMqABA69VYrJq8WsTwLMBxMNKNi0s8Zf30Q4ZaAhSVt/ia2XxfRuE5RWckd/iWEZeb1bRGomqhun67VuBxDrWc5WDjd8I499Lx+77hE7lbCntgn8asS8Jz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRyjw5dn; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRyjw5dn"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-988c90ee9e8so438957241.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791812450; cv=none;
        d=google.com; s=arc-20260327;
        b=IjGtVBP+WH3IwhQL/ybmlpNgSmSk9T75c7mdvMG2h7jLFcFhsKJd6AVjZMkP8wlL/K
         dVZmnyFOC0u1zOTLwHTn4HNDv7DxlQ9rWOvozfblZhflC+4QRteXABLQVkZjlvExQd9t
         jmpQCFyzSXIvvNh/5wx7/0lEj3O2uynGUzIcPQ/z2N3ikJy90UkNmfF0CkUyem/UhD6E
         MFMV8fOQFbUkLNCvdWTeAdXPikqo/i/Puv4zwUFO6Rx5pOiHst5rRpByCjQ1KmKEaZdE
         HwPoAgLCRFZJ0ausftQAmJ7GYGF6sSMrOGF1XtX6DEuKuk60CWNifpMb2q9ewWgUHfXY
         tPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fISPJgkN0H7LYXqIa8i3iQfM2z/jXKgb3BG/d5Eps08=;
        fh=/pCTdGd1k1AbRjIwudvLe4kPUOX/4Vc1RC5HhyDyosc=;
        b=jRX7hAFEf6yi4T97ckf+Wa2CN8c1if5wUkcSGkl+HEplpYh8Ys2h1Mrtn89/qFUyOW
         bzvwkHsg+5JCbEXYTjRw3LYXH6pwK2Z3TSELjJAwXBO1wa0sCDSf8n8P7H/YiobSr5NN
         QlBISxqyVs/uqqOyfTpV2FfyHdX5FXMBCc7uHPri5u8iANF79J7dfwnnAYGTd/u0iFUq
         K2Iwz/Lqu1R/WMPr4FXsv42ynNEPOAdue+v493G6QTUjb6uKS3X3iOsEQ9HBnDXjp+wI
         +GrSLltrv4qELUmSdelgX5ev9vzuCo51tfDrmw39DEkf1WFXR6YJQxeiezr+SeCKbFFd
         v9ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812450; x=1792417250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fISPJgkN0H7LYXqIa8i3iQfM2z/jXKgb3BG/d5Eps08=;
        b=pRyjw5dn/Kruk86zA3s6mVhdAv8ouj8o7tcJm6whzyn4iWhpQ3HHDSic7Xl1JDla1i
         S93Ivg8rG53EMXchKK2D4dQI+ku4SKe1rMmTJrdsN5woBsaOK1lfMUPsYZuvFzrdiBik
         znZmmtWYeAH/W0Uv9VUm0tgU7kOSG05qmowkKcBohyGzJjyxE4OWMkF9MTSDbASdNUYV
         t/G6TP1PJSahD6Dg8URPLbg+mNMjnHolUiVZQz5FQ6/cuh0lMDaztNBLN8zAc7EJdY9s
         0hPVlflfGWec5E8dbNP5LXf29vF03gaQqlokKoeNX/VuiqwOIWbGMe9raxJNqknwvteZ
         pNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812450; x=1792417250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fISPJgkN0H7LYXqIa8i3iQfM2z/jXKgb3BG/d5Eps08=;
        b=A9RCm6Y9n0j0amWH7UVqChhRhfjnmlwNVxafGy5N341Ipnnds9uS5Vtvr8mT+w6LDM
         2iD98ecwehM7BJ+qPWEJdp3FtSP3FfNapdGX4tlBXcRCp5buOCeZu16Y87TyyGJyNXnf
         zxifqRjAzwyd9DaZ2tHFqLq782AuG4Okd+/woLHC9RlIdfaadx2TYIikaHOcG/eWWDg9
         deDsizQ7TmqePZ8Cr4vI6AXuzYlWYpXsp6o/8JdtfbNIm9LVK2u4Zd8LaNATR3jid4cQ
         5WmzTt775oiMNwf3E9cBLB0kaZwj/Bf/Lr+vz0ObOyC4r03KqImWsAeubj1KSJ+o2Pwv
         uZag==
X-Forwarded-Encrypted: i=1; AKwUvBxrXSH+wGlz1gSMW83/pWAkdnD9TdnvP2TGGte2B61Tm1mVMCRY6ClT5Nx2Xx15Jg1QTD8Bzqk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRfAa83Iq+sn6I5l+b3MKPgg6W7OXgU2CYJpBgkZUtLBMbFI6/
	kECVeQsVqE5ystnXytERv4LQBs5S0Z3Rpku7YGn94CkgnwVz5AFpSb69cRBul2j4J/HlObBqAa/
	SSpN9b7OhBC68fu1p3x69Irs3HKHfyGI=
X-Gm-Gg: AYBFou0ovz+6bNlfiHaaFHjiaxWmUNPH/46EfG+rHlxL1pUsRqEGXJI0K6zo+1b7Mmd
	bT18L9XyP5x+VxzQPeMnA3/w7j45PVutnQkML9hx0cdGEduzb1v/i3b4v096txxSDS185NDiA1M
	lfUaVtasQLzXqXEyrA2PJNY5u7pZiBw5Z84l3vVRNNxpp5lBnm1NqeM9QfXGZM4zKIn9LJ8yFQ+
	NTg0Y+wO4sOOZw3i5Mtlz1Qfv8Kri+dvyF8IZZflH+HA/FNu5Pb9Ve81jsTRBgeojWkz5FOFQ27
	Exx5VXYG/BbZvXT7XxnZkYKXnikma97gYgbxZHbNrUW0CzOLLQu69sG7W3VsQ+3U4vNILWeuamU
	ar5cHZFZs
X-Received: by 2002:a05:6102:f10:b0:7c1:918d:d188 with SMTP id
 ada2fe7eead31-7cb373e9685mr2247621137.35.1791812450478; Mon, 12 Oct 2026
 06:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007182238.1154851-2-peter.hunt@opengear.com>
 <CAFEp6-2QsKyZfEdSotVPhxVNOyRzncUphqLY5cRwHXGJiEbzuA@mail.gmail.com>
 <20261009001714.1078580-1-peter.hunt@opengear.com> <20261010171531.1659006-1-peter.hunt@opengear.com>
 <CAFEp6-0vuU2sy3pfgyprMMiLOaKCoZMQN=nHQ+dQR1ku9dbwkw@mail.gmail.com>
In-Reply-To: <CAFEp6-0vuU2sy3pfgyprMMiLOaKCoZMQN=nHQ+dQR1ku9dbwkw@mail.gmail.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Mon, 12 Oct 2026 15:40:39 +0200
X-Gm-Features: AclHuK99dZi0qD-kjTJ8chj2shsT6zJyFcPaX8IvEYin0Vx-u0gytz2jHkZuBVk
Message-ID: <CAGRyCJFnszYkYbB8fJneue_DgJY_9yOwK2_T1aB-b+RuK7mqjA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/2] net: wwan: core: propagate modem control
 signals to port drivers
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Peter Hunt <peter.hunt@opengear.com>, ryazanov.s.a@gmail.com, 
	johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter and Loic,

Il giorno lun 12 ott 2026 alle ore 14:15 Loic Poulain
<loic.poulain@oss.qualcomm.com> ha scritto:
>
> Hi Peter,
>
> On Sat, Oct 10, 2026 at 7:16=E2=80=AFPM Peter Hunt <peter.hunt@opengear.c=
om> wrote:
> >
> > Hi Loic,
> >
> > A follow-up to my reply, as I overstated one point and would rather ask
> > than argue on both. (Adding Daniele, as the first question touches his
> > recent QCDM ioctl work.)
> >
> > On the AT-only check: I said QCDM has no DTR semantics, but I don't
> > actually know that. I've only verified DTR/RTS on the AT (DUN) port of =
a
> > Sierra EM9291. I don't know whether the DIAG channel behind QCDM ports
> > honours DTR on these modems, or whether libqcdm relies on it now that
> > QCDM ports have the TIOCM ioctls. So I see two options:
> >
> >   a) Keep it AT-only in all four places (open, close, removal, ioctl).
> >   b) Call ->dtr_rts for any port with the TIOCM ioctls (AT and QCDM)
> >      whenever the driver implements it, again in all four places, and
> >      leave it to the driver to ignore ports where it doesn't apply.
> >
> > Which would you prefer? If you or Daniele know that QCDM/DIAG ports
> > care about DTR, that would settle it for b).
>
> I think we can go with option a) for now. The documentation I have
> only references virtual RS-232 control signals for DUN, and we can
> always revisit this later if additional use cases arise.
>

Agree, I don't think control signals are used for diag.

Regards,
Daniele

> >
> > On the locking: I agree the data_lock/ops_lock split is awkward, and
> > it's this series that made the two locks interact. Most of the races
> > found in earlier versions came from it. My only concern is the blocking
> > write case I mentioned, so the options as I see them are:
> >
> >   a) Use only ops_lock, with the whole ioctl handler under a guard and
> >      mutex_lock_interruptible() so a waiting ioctl can be interrupted,
> >      accepting the wait behind a blocking write on rpmsg ports.
> >   b) Keep data_lock for the termios/TIOCM state and take ops_lock,
> >      interruptibly, only around the ->dtr_rts call. v9 already limits
> >      that to when DTR or RTS actually changes.
> >
> > I'm happy to do either in v9, which do you prefer?
>
> I would also lean toward option a). We may want more fine-grained
> locking in the future, particularly given the blocking write path, but
> I think the current approach is acceptable for now.
>
> Regards,
> Loic
