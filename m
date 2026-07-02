Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443FD175A7D
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961775; cv=pass; b=X9/YrwCkypkQhJKy+qP6qzJXcZNowsGdKc8I0VziHhabZLsYDsMjFhBB976bYnxxgD7KWuqJF16Yw/p9+xaSC7icmtXtnrkvh8O80Q4bDILy5Mhiyehxgx2Uo9+ZGSfjg2izPg2jZhhumDVoysXz1WcOzj8E3lnR/jbGzfhkACg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961775; c=relaxed/simple;
	bh=V0f9u5tGhT6810L1V7XYOvqlIJFT7o3KZqXYrtwFTsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gymqpbRb7CARmuIwG7MTh4rn22xiPtLJa7kAyXLhk2L4VShgZcQDw3iBW4kV+PnlsmMHht5S0V2YNctjkLY9hHguVQA/ukExZDyYy2y8AzVs9Sp/r1N5SEXInpoi75+wWzqQDrR7tF2nizK1JRlPqeBsXNUJktnGH7YXcYW8Lw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kldKev9g; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kldKev9g"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8894387780so648966a12.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 20:09:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782961773; cv=none;
        d=google.com; s=arc-20260327;
        b=nW2hZ+xxOBE4BCW7g5YAZnYwC8kCD8RLdzMjDiUBvsyN71al9h/X+LDqCU5dre0YaQ
         Mpkhw1UkS6uVjYx6i039B6VpJ5RhYvsCe0l02b4oW12c2dw1IRLffn3QSzwEwUrvGhcJ
         un58dFtUFRiptvdFPPIPWfDXOCqRELZVprJbPzU9kzWerW8/BqQGCWZUeinX5fprgbiq
         daTGP4cY1agChVc4TH9f64Ps0FFooWfs+QRxk5C3BivcSDHx2A53zdDW4Jlxj5831Xw1
         gQIuzjSAjPr3mYZwRNsNllFYB4DaNq9LnYAwGDMJlKKkRVoltBiWllRQcKYZ0vnL17nE
         SCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ffpVdH41zLEYoKj+/EJIphyKhD6hjMi/txrr3CvfPtQ=;
        fh=VbsLrf2j5BimIGxQSRs3NqjJZXlAxOyLX75KIG0JUoQ=;
        b=TM9bRaP38Cn+shD9m9lWZsfKbhUNgeNnv7IY+XjzHpFFk3ol1niNHXbxZfrx3c+gef
         tg2lTS5TO8xacztv2Vb3p0ttOTdk9Fy/48XaTcloE386q4wvpep+zCNePaOBth8brbX1
         tLsTgrSZF3qeZXfBN0SUC2enjaaWDMyEgX+lRXCwlWEjeBdqHEreC969AedW11ZtvGX4
         EpiX2+DVIU3EGx9jZT/3IgEPAxQp3NnkIDo7/kpYGplfLh7mmK5tP/V4Iwe6wEOXZzqC
         dt94wXZrBL26CgZMWCE5cI9uGlZQvX09lxRHgNfEZvwFTCIJvEXUlKwXW5pnpt4m3IqE
         1Fsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782961773; x=1783566573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffpVdH41zLEYoKj+/EJIphyKhD6hjMi/txrr3CvfPtQ=;
        b=kldKev9gx9GU8KAW8B3nkn/6LjFe1WdryExTuq+3/q1BTkBdacv+g6pO1PeZYtwIHt
         AtEMvzHSnpgLoGCWLI5ofF3kvUYLvTfoQVuhHEc5Vegb24BaQtSVTCh/sixXr+Tqz8EH
         /VelIqCCHaNgvARKBc15YI83Std29MlS/2Bk0iKkprSESZhpmbCJTi75eIHSHgRI22vj
         azANW0zaZ9r7byuvY6c/RjfC7eTeBkChNHFqSInClXQ9G7UP9aFTJdCxyrB2Ki9XDpBl
         J0JkxovXE29APLgTvDxeeZvjnsm6sZtg9AQKeNnPmu1cKqLiCXmNa5cHJSVWAenH60n/
         VWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782961773; x=1783566573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffpVdH41zLEYoKj+/EJIphyKhD6hjMi/txrr3CvfPtQ=;
        b=PSSn2EkySZ9yY3W4rxZ608i6ustASYs4pS4bd5SsYU7AD4J4HhpWZ4cownt6hv0/kv
         QOirBfBZ35crdlWNvy56fSRONIf+IXl5mDFYQMuBtNX3XmYcqEdjyQq71qQOIoxs75Yr
         WbxI9oGXkqRLrp90I28RM/lRXGpaCMvcWZJFsqQ9/5cfGgbhEUqJMGrFBr5NWLQFKkBV
         suZ+u5NSopa8yy9r71r+hvEfMEL7TchFr4MuAWFXMvvKfAMBx4SMmUqopMpIysyMK0WV
         9d2W2M2wTwldCrbDGELc45yuhY1PCyB0mC8N3Pla72YjEpS0sqBtIMbKVNqelztfLCAL
         YHlw==
X-Forwarded-Encrypted: i=1; AFNElJ/4vBEhvPRNpYkd3VxdHZW2duOKUItxW7Io/5E79+0WZPqYGgGCzMxuNz1vJ3/j5BVFoM8ObiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvduMUK+MeM7hcmmUR2l3KAPUPiuVsGp/aWuJOq0my7LUhK3hY
	Ekq9NaXgjz4jTjvHEdE90N6lVqAEpywk2XR3BMbQWiHbzdMgV4Eb/7zrqqlhBKNqZdGUGEpdA33
	de6SJ/UbbzhWFQAicJle40sggcXGke9TwJo6ub6DB
X-Gm-Gg: AfdE7cl36+Gny3bUHnu8H8Ctq4P0vmo3jMi1WcRCkO2VIdFJ5UV6P7raSM5lr8OSpOJ
	MQF3aRlI4FiKuW2HzOc4O/bniZ31ocb7YkUiBaaSFFB4O3f4Xz10gqHsQ85C7FDmteuM9rhHJLz
	EvppKQ2dm0lRkJvG8/xxjPJTi/eJNERUUOtqiWP4H8FmZGWhF+BbXkoOzwElb0WF2MIfl1oPMlC
	wYlarXXzzYSqlvD/FvPOZvTxw5Dew6ybc2rcbCAGvohJLgjnqVIaG8kjYEAaZeHKGbq79UKMOQN
	JAQxksJYrKLC4pWN/e+2i7Xlp87aK9Gog/Bf++TjbgVzS/yclMTV7Sc9h2MJUk7l1rnvSs6F2ts
	hsHg/nJxw2Gp+K44N9ubdLFfR308Yvv7wo2U49TRaFg==
X-Received: by 2002:a05:6a20:7289:b0:3bf:9fe1:c24 with SMTP id
 adf61e73a8af0-3bff4038bf2mr3702514637.2.1782961772768; Wed, 01 Jul 2026
 20:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701125112.3652880-1-edumazet@google.com>
In-Reply-To: <20260701125112.3652880-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 20:09:21 -0700
X-Gm-Features: AVVi8CcDu7qvuQ1BLoii4s_c_zKmNXrFwns-dWvl_QhDX0ARm6pDuzEPirQJ-P4
Message-ID: <CAAVpQUC1UKqqUdQaP+ud_uGkhByxooMvCs1H7i7q=OzQFP7trA@mail.gmail.com>
Subject: Re: [PATCH net-next] tun: no longer rely on RTNL in tun_fill_info()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 5:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Update tun_fill_info() to read device configuration fields (flags, owner,
> group, numqueues, numdisabled) locklessly using READ_ONCE().
>
> Annotate all writes to these fields in the control paths with WRITE_ONCE(=
)
> to prevent data races, as these fields can be modified concurrently via
> ioctls (TUNSETPERSIST, TUNSETOWNER, TUNSETGROUP, TUNSETIFF) or queue
> attaching/detaching.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

I left comments but maybe it's just my preference, not sure
if it's worth a respin :)


> @@ -943,8 +943,8 @@ static int tun_net_init(struct net_device *dev)
>                                NETIF_F_HW_VLAN_STAG_TX);
>         dev->lltx =3D true;
>
> -       tun->flags =3D (tun->flags & ~TUN_FEATURES) |
> -                     (ifr->ifr_flags & TUN_FEATURES);
> +       WRITE_ONCE(tun->flags, (tun->flags & ~TUN_FEATURES) |
> +                              (ifr->ifr_flags & TUN_FEATURES));

WRITE_ONCE() is not needed here as the dev is not yet published.

[...]
> @@ -2814,8 +2818,8 @@ static int tun_set_iff(struct net *net, struct file=
 *file, struct ifreq *ifr)
>                         return 0;
>                 }
>
> -               tun->flags =3D (tun->flags & ~TUN_FEATURES) |
> -                             (ifr->ifr_flags & TUN_FEATURES);
> +               WRITE_ONCE(tun->flags, (READ_ONCE(tun->flags) & ~TUN_FEAT=
URES) |
> +                                      (ifr->ifr_flags & TUN_FEATURES));

READ_ONCE() is not a must here and __tun_chr_ioctl() as all writers
are under RTNL.

> @@ -3213,13 +3217,13 @@ static long __tun_chr_ioctl(struct file *file, un=
signed int cmd,
>                 /* Disable/Enable persist mode. Keep an extra reference t=
o the
>                  * module to prevent the module being unprobed.
>                  */
> -               if (arg && !(tun->flags & IFF_PERSIST)) {
> -                       tun->flags |=3D IFF_PERSIST;
> +               if (arg && !(READ_ONCE(tun->flags) & IFF_PERSIST)) {
> +                       WRITE_ONCE(tun->flags, READ_ONCE(tun->flags) | IF=
F_PERSIST);
>                         __module_get(THIS_MODULE);
>                         do_notify =3D true;
>                 }
> -               if (!arg && (tun->flags & IFF_PERSIST)) {
> -                       tun->flags &=3D ~IFF_PERSIST;
> +               if (!arg && (READ_ONCE(tun->flags) & IFF_PERSIST)) {
> +                       WRITE_ONCE(tun->flags, READ_ONCE(tun->flags) & ~I=
FF_PERSIST);
>                         module_put(THIS_MODULE);
>                         do_notify =3D true;
>                 }
