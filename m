Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD25429827
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301744; cv=pass; b=LNCmF5jKLXwn3tBrCF717fySQgt5iACO7gHN44gQo9dGNFK7fCDLLd1nfwWA/ZnJAsDYQcrOZuG2O+fhNUjZdLAoKyzxQPsG+RkdUkFqnkIhegnhrWg52dOcUVp4bD86Ca0J1aI825sO/HkTJARGoJ/x3XVSO0yceE1JipeFwCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301744; c=relaxed/simple;
	bh=kA7ivsnxmQuG9r0ALpR4FjXxJUi+eVbNq12z6dThsUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfElzdnUJgocXyk4pdrKiodvc/ehoPzj4kk4hbDIntsD4UK8BAU4u6mezp+I/9OkYaCsbDHg/9CV5MQsN/ZWJ4qZcZvkFAIR/7+5Fc7dBzGWnOCARHUwHUBWLGMMiON/JM8XJpfCzhVyrmQv9mzlgjO4teRdJTbYA6cGGlYn8dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sxSiUHYh; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxSiUHYh"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84830c774a0so3820201b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784301742; cv=none;
        d=google.com; s=arc-20260327;
        b=hgBnXxY0ZmaciMuFzWkiZ5tDRhBT+CS033pqeQQmqUxYA8l+d2CVXwLZcr1nQj1/r/
         oETS2LNwpQThcnKj3GIjhGb7eHK9EP6INIdDTR5g76NnGzQbEvkxZDJxtCnow0kpyp4X
         SeAoquxo4uM/n4syecoNBoxXnydFn1zxQUgmtkMSY1BGEfZuL/YA8Xnk1dzUoQAbQ9Eg
         kXmqBTnmhE+dO4ZFZdlOEOhjrFtTc4dd5mwBeMzukbWht5Z0DaoeSPfcZwigIqFm4i00
         Ttz+hmYxhlNUjUSIXCyu4s1WpwY0KOOJqU2G7z91oTVOIbyAeGmjcMIq9vU+eGtwWBNH
         PKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sQf1F+DANpDFwvUPWLrBF8zRnvP9oHHYMaURhb1ah2c=;
        fh=d/qxuJ9fO6gCk2N7SKHLYJ4wzrCFnooKHwybZnsKLoI=;
        b=HRa782KJEunj+gMRpBt8Vhr20R0dFNuR0SpFFwEtRLzFjsr/Z+pABPWVwoeigL/cAC
         RyCDyK/GYXuRkeg1NFBUL8pOEKpn8Fx8shY3mZl6Fz8x9wtd9f7oG8eGUiz5pVq2f1Tf
         UZj3DTrlp5OFiTq/GWt9M4Ry0LzKnQ5dzuoiDsx28rXmIPz6/jSC9NVDzY1Jy7PASQ/m
         LW7Kp9EenfgRGC7CF7QbU+kXhTkIxDLt8bGOjFV7MaI9h86FaW7+PVAdlEHYZfE40pAB
         hZYbDDytBiAWCoeUgmfJtVygEcyGEnm2N63thA2Zy7f0620lNL9G1uT9bIF4fuQRFG6v
         Oi7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301742; x=1784906542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sQf1F+DANpDFwvUPWLrBF8zRnvP9oHHYMaURhb1ah2c=;
        b=sxSiUHYh2zXgIxbNp4RrzAidSpaZjpNXpwXQNrc6U7I1Stf68oQrCXm6ltjZ28Mkpt
         6w+HcPUntv3L+4VUOb/0IlomIghYiM2nfbTlyB4t7Fjs1IH7kJ9XkOkLsDTCi5hgugQU
         9k7d5RoNmtoc6nJR4sCmW0lEK1WU11nMj0QVFarMdm3tFCkBflGhm8P4bgjjlsgd0MNH
         7Ezrw22baSDesqmtJEqZyzGSTx8FwoObywwObUYc3/HHG/o9kimVNvZ+95o7IX1+2kYG
         ogfVhuUKQWjpFEyu6TVlOFML53GPR3jiB5ADnLyR8stKRM9gIJnU2961YesKD2FWsDOd
         R0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301742; x=1784906542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sQf1F+DANpDFwvUPWLrBF8zRnvP9oHHYMaURhb1ah2c=;
        b=V51HhgJNIbcFBvzBaw1RIwtC/ael0SKPTkEcgy2NVqbyJ0W+dWls6I9xY4uyj0iPO4
         0aoueae6+FRs7QzJpgFoLw/kntxPMcGUqaSfUCxqVVfp8GPuHDPYvRk7w/08AI0ZT6m/
         lsRSdg2ELU4IhUAiSg60/Goxds/Ul+GfSv0kk/LbNh1NU+mMIOTAl6gSd6iin165GXmC
         lORNCckwW7jwbkK1CLBAo3r5M/dn0H2FwF90hlW6mgqe1nWDs7NbYVzzf7bL6axcqY1t
         6WYyYowxoGhSuycvKX6buIeIT2jxE6Xx6ibTWaZIX0fwnf7JywoKneY072WFsQrk0ph7
         HIPw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7cvt3eeCykzwErHKG28F0i7UnUpM7qsLBbmkM62aYDX+8YoiUUlPJvX4QHut5ZrHB+L/ud04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqPbaaIx91pKOecjuE2kghKqeSnkwzxcI+EZecRTFiTe/eu5OD
	fcDvHc78xzaUq7pjoPLttDH6pjclE7MMShATEPo0+B7VnMvVTgJ7eNWx7s0BR1+Oyw3HVRyaVcS
	ygZJNtlUnEOtkVPaI+yVS47V8oYQU7Yw=
X-Gm-Gg: AfdE7clvyZrglxVIB/RgxpV/m2cLzrv3LGz9HXQ9sTnnumgoD8vhcvvIvbdFaepYzsI
	Oldri7iQhvCu31pfDYEf+xnl2sy/uG5tphBPAlDwlXMw/R+ZmgzptZD6fAnMs5B6W9m654YT9v5
	juojL/yHAUs6Seo2/xSLHK8EKx7TS9JfQReIYTy4H268oZ3rgRfU5BizPyQlZmH71j7ClrJrD1q
	ljfdMqMOsVnzXwJOcAg0nNxQxNJPJN0ICPYCMOUgwNJf4kN/kJK7xtanWYB+KyD1AI/83xVbjMc
	N1zK1zdBqLOTRBSO5OjxkKJLWtNTN9QmynQkCIArDqaDTaDcbcBh9uHSb14o0FQ=
X-Received: by 2002:a05:6a00:12e6:b0:848:2f74:d8d0 with SMTP id
 d2e1a72fcca58-84c29496996mr3254876b3a.65.1784301741614; Fri, 17 Jul 2026
 08:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716100407.1490724-1-l1138897701@163.com> <20260716100407.1490724-2-l1138897701@163.com>
 <CADvbK_fxLnyyx7kuuHr3_Vu9Wp9AenxAZYM7rO5kDwR=eXjd3w@mail.gmail.com>
In-Reply-To: <CADvbK_fxLnyyx7kuuHr3_Vu9Wp9AenxAZYM7rO5kDwR=eXjd3w@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 17 Jul 2026 11:22:09 -0400
X-Gm-Features: AUfX_mwmODfQ66DD2J9PHGPlcj4Eo_8HVK5B7IK-urXqMNQ_FeXbGIxny2Dqgww
Message-ID: <CADvbK_e7rFqpWzDLvP2KPucbFzr1CwX9JotMoBE=HK4H_uOLpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: sctp: auth: Fix safety issue when skb_clone
 fails in auth_chunk handling
To: luoqing <l1138897701@163.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luoqing@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 11:01=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Thu, Jul 16, 2026 at 6:05=E2=80=AFAM luoqing <l1138897701@163.com> wro=
te:
> >
> > From: luoqing <luoqing@kylinos.cn>
> >
> > When processing AUTH + COOKIE-ECHO packets, if skb_clone fails due to
> > memory pressure, chunk->auth_chunk is set to NULL but chunk->auth is
> > still set to 1. This causes sctp_auth_chunk_verify to skip the AUTH
> > validation (since auth_chunk is NULL), allowing unauthenticated
> > COOKIE-ECHO packets to be accepted.
> >
> > Fix this by only setting chunk->auth =3D 1 when skb_clone succeeds.
> >
> > Fixes: 59d8d4434f429b ("sctp: delay the authentication for the duplicat=
ed cookie-echo chunk")
> >
> > Signed-off-by: luoqing <luoqing@kylinos.cn>
> > ---
> >  net/sctp/associola.c   | 3 ++-
> >  net/sctp/endpointola.c | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> > index 62d3cc155809..e54068305396 100644
> > --- a/net/sctp/associola.c
> > +++ b/net/sctp/associola.c
> > @@ -999,7 +999,8 @@ static void sctp_assoc_bh_rcv(struct work_struct *w=
ork)
> >                         if (next_hdr->type =3D=3D SCTP_CID_COOKIE_ECHO)=
 {
> >                                 chunk->auth_chunk =3D skb_clone(chunk->=
skb,
> >                                                               GFP_ATOMI=
C);
> > -                               chunk->auth =3D 1;
> > +                               if (chunk->auth_chunk)
> > +                                       chunk->auth =3D 1;
> >                                 continue;
> >                         }
> >                 }
> > diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
> > index dfb1719275db..3419748c66bc 100644
> > --- a/net/sctp/endpointola.c
> > +++ b/net/sctp/endpointola.c
> > @@ -368,7 +368,8 @@ static void sctp_endpoint_bh_rcv(struct work_struct=
 *work)
> >                         if (next_hdr->type =3D=3D SCTP_CID_COOKIE_ECHO)=
 {
> >                                 chunk->auth_chunk =3D skb_clone(chunk->=
skb,
> >                                                                 GFP_ATO=
MIC);
> > -                               chunk->auth =3D 1;
> > +                               if (chunk->auth_chunk)
> > +                                       chunk->auth =3D 1;
> >                                 continue;
> >                         }
> >                 }
> > --
> > 2.25.1
> >
> The patch does not fully address the issues reported by Sashiko in the
> following two cases (I will interpret them below):
>
> 1. [sashiko-gemini]:
>
> When skb_clone() fails, chunk->auth_chunk is set to NULL and chunk->auth
> remains 0. In this case, the chunk will be dropped/skipped in
> sctp_assoc_bh_rcv() by the following check:
>
>         if (sctp_auth_recv_cid(subtype.chunk, asoc) && !chunk->auth)
>                 continue;
>
> This works as expected because the chunk is skipped. However, in
> sctp_endpoint_bh_rcv(), asoc is NULL for new connections, so the above
> condition is always false. As a result, the COOKIE-ECHO chunk can still b=
e
> processed with chunk->auth_chunk =3D=3D NULL.
>
> 2. [sashiko-claude]:
>
> When the association requires authentication for the COOKIE-ECHO chunk, b=
ut
> the packet does not contain an AUTH chunk, skb_clone() is never called an=
d
> chunk->auth_chunk remains NULL. Since the new association is also NULL in
> sctp_endpoint_bh_rcv(), the check above cannot catch this case either. Th=
e
> COOKIE-ECHO chunk will still be processed with chunk->auth_chunk =3D=3D N=
ULL.
>
> A better fix would be:
>
> Add a check in sctp_auth_chunk_verify() at the point where the COOKIE-ECH=
O
> chunk is actually being processed:
>
>
>         if (!chunk->auth_chunk)
>                 return !sctp_auth_recv_cid(chunk->chunk_hdr->type, asoc);
>
> This ensures that if chunk->auth_chunk is missing while authentication is
> required for the COOKIE-ECHO chunk, the verification fails and the chunk =
is
> dropped. Otherwise, when authentication is not required, processing can
> continue normally.
>
> Please give it a try.
>
Also, please add a extra Fixes tag in your next post:

Fixes: bbd0d59809f9 ("[SCTP]: Implement the receive and verification
of AUTH chunk")

which introduces chunk->auth_chunk and calls skb_clone() in
sctp_endpoint_bh_rcv().

Thanks.
