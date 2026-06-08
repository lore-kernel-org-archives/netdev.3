Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955883B42DC
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908140; cv=none; b=pfrl5AptuRcTDgQGJlcEa1NEe40JiT0QXMP62qAixQoi9q1G8y+cHaT/P2OFzBGD9d5wyJs2ARv9R5dQhzsrudbOfKcNm2ohgv3POeSJSVj1HIEfG+LxhN7+mPWwxKoKMsFFJ0aHx7X7sJog4SH06F2/HA086guDYhD6MaTCINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908140; c=relaxed/simple;
	bh=z0v1uWiu8TNvRB/nbLUM//Lso4OwWGNSCYHIQjkF4jY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/HlDP2hsvn6SznJRv4MYMiWMxlkFb5LEloTqALaKHx/D2SO1W7z+cAEVEEsFeHurFsZjIuQLzn28+7DXGsaGRN+XVv0XuFGh6lM7Tjx4ilaXF7qmU2ggtt+UlxSyG4nyHwhiEu5QejRmte0CiLLAHRSvoA7dNMOyrjeAv8JgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTaveqHx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTaveqHx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490af320e2aso44580145e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780908137; x=1781512937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scdbdNwzC/a5GHNDLiCsaeBV57d/4TFPto/ThqOE/Sw=;
        b=cTaveqHxMqwC/9fjHVGiTgIYkwgwFIvIRyjVcN4kBZ3J6FKBB1Vkky2UnfWg2yONwH
         sa0m4YERUbh+QQ8wivwZNQbVFMogSaLs3Je/9O6r1qgAn5+TMuxL3Vjs1pTsbFI1GemI
         Z3erUxw1zdcCYm7Ut9dfN8E2OE/TyaKJxx9oxgRFJSXd9YTNUhFakiKpTKZq+8cWUIUf
         4tZ2Lh/pdGhYWwdpw0SS4+OsVa1djJzRavgkYnPltdFIovhMnZm5AaJsVrJJSDsMiGwR
         XeDsEGpdGFQtBhPEKwy9/pisSyCQHYmaWEpAew/fovSOnTXrFALK8hapsooIeNnQoX4R
         Qftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908137; x=1781512937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scdbdNwzC/a5GHNDLiCsaeBV57d/4TFPto/ThqOE/Sw=;
        b=AWtkAM5AQDjof84MheLeYR0bSJ/6wZaUA3I6fgm//6TON7LFpUdUJbVl5mtTVH/xYd
         LTTPoa0j3r39QLrA2nwEs1cvLIu7IZaucN/SlU6mMqGDe9Wl9y6rET07iFsZoCuYU3t8
         LZQQaCvUQLQcRETeo57YWTGJ31ZWaF7EJUO2obQGdP+gejYgj97voAZseHsP5oYigQ+K
         d8pNLxUGx0553+Y0ZaiBZ1c4JgbZxV57TTsEpmXyQLGKxLifYjjuXb1U5oduDCzSlKL1
         b0oDWLmW/7NcPSz1fTLfXUidAXs3d7hptx1Xeo08wvrUECVWehwtmF+VIvW3jD45u7VE
         dcNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+KLA5KRRqmSv1/XByoEvPxCvQgxSOlDZIKRomnhsVBDwoZwNoP9KIgHo1cHfEqBNtpJ3ug+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6s9aPXAolcfSgX4NoN4oH4wpamjIdlvyM5FKMXAum26F8iuou
	UrbmU5J/typ5O22jkNQybTYODUJxsfNBYHL0XPSjp2OmUi84f2CVDmo4
X-Gm-Gg: Acq92OG8ADIibkjJcBqzS9Y9AqaAe6zVIEkIW3wgb/lFpmcYW292fHLGskegYp4Fhha
	HFOev8fmggp/IwGckSi9LgeL2ljWh9bBIU1Hbagv0d0BmYvjlTmXDLunqRUSKkwhbYs4gWkpV6H
	XpLbN/MnnLn2aeo6p0VAp/wWS4WlQlWK1n2aTHM7zY7D5HSfkOn/Ao0fMZHm6r/qbr5Nk4PhEGR
	myDcVjAFbiYCaOv764Vzd1IhC0tBIQu0SpjgtqU8alcFhgWtl4uZGF6cZ0Vvl0TwlkFhoKMRTOx
	TnfE1zA69cOOHiallBioDWDGPm2/a40HlW56zVPywksdey5OCiaCJRE2Hj5jQWZDXZMWJmc5d7C
	JwaL6l34JCEKmEcfWu3IVSzVLcAXelGTeV8i5V3HgmnuhG0RWLZZKHUqgTHoRQ+4ItAt0OtjJgI
	jA16978ekTtRmr590pzjqOKHQ6p28ca8guIRdrAiQxIGdddFxyzfih0EUjYkWZHpu3fdNqOYo=
X-Received: by 2002:a05:600c:3f10:b0:490:be44:32ea with SMTP id 5b1f17b1804b1-490c2591fcdmr250743905e9.7.1780908136860;
        Mon, 08 Jun 2026 01:42:16 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm50813041f8f.9.2026.06.08.01.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:42:16 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:42:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: Michael Bommarito <michael.bommarito@gmail.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vlad Yasevich
 <vladislav.yasevich@hp.com>, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] sctp: fix uninit-value in
 __sctp_rcv_asconf_lookup()
Message-ID: <20260608094215.4dd984ed@pumpkin>
In-Reply-To: <CADvbK_fn=t8+8cg5hCRUKrO_dF+-ikrzsSPmzgaeMT83jB_T-g@mail.gmail.com>
References: <20260606183821.1688525-1-michael.bommarito@gmail.com>
	<CADvbK_fn=t8+8cg5hCRUKrO_dF+-ikrzsSPmzgaeMT83jB_T-g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jun 2026 19:42:25 -0400
Xin Long <lucien.xin@gmail.com> wrote:

> On Sat, Jun 6, 2026 at 2:39=E2=80=AFPM Michael Bommarito
> <michael.bommarito@gmail.com> wrote:
> >
> > __sctp_rcv_asconf_lookup() in net/sctp/input.c only checks that the ASC=
ONF
> > chunk can hold the ADDIP header and a parameter header, then calls
> > af->from_addr_param(), which reads the full address (16 bytes for IPv6)
> > trusting the parameter's declared length.
> >
> > An unauthenticated peer can send a truncated trailing ASCONF chunk that
> > declares an IPv6 address parameter but stops after the 4-byte parameter
> > header; reached from the no-association lookup path, from_addr_param() =
then
> > reads uninitialized bytes past the parameter.
> >
> > Impact: an unauthenticated SCTP peer makes the receive path read up to =
16
> > bytes of uninitialized memory past a truncated ASCONF address parameter.
> >
> > The sibling __sctp_rcv_init_lookup() bounds parameters with
> > sctp_walk_params(); this path open-codes the fetch and omits the bound.
> > Verify the whole address parameter lies within the chunk before
> > from_addr_param() reads it, the same class of fix as commit 51e5ad549c43
> > ("net: sctp: fix KMSAN uninit-value in sctp_inq_pop").
> >
> > Fixes: df2185771439 ("[SCTP]: Update association lookup to look at ASCO=
NF chunks as well")
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> > ---
> > v2:
> > - Regenerate from net/main so the patch has index lines and applies
> >   cleanly (Xin Long).
> > - Use unsigned int for the decoded length and compare it against the
> >   remaining parameter space after the ADDIP header (David Laight).
> > v1: https://lore.kernel.org/all/20260604175803.2142975-1-michael.bommar=
ito@gmail.com/
> >
> >  net/sctp/input.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/net/sctp/input.c b/net/sctp/input.c
> > index e119e460ccde0..c63d42500aa28 100644
> > --- a/net/sctp/input.c
> > +++ b/net/sctp/input.c
> > @@ -1197,13 +1197,26 @@ static struct sctp_association *__sctp_rcv_asco=
nf_lookup(
> >         struct sctp_af *af;
> >         union sctp_addr_param *param;
> >         union sctp_addr paddr;
> > +       unsigned int param_space;
> > +       unsigned int plen;
> >
> >         if (ntohs(ch->length) < sizeof(*asconf) + sizeof(struct sctp_pa=
ramhdr))
> >                 return NULL;
> >
> > +       param_space =3D ntohs(ch->length) - sizeof(*asconf);
> > +
> >         /* Skip over the ADDIP header and find the Address parameter */
> >         param =3D (union sctp_addr_param *)(asconf + 1);
> >
> > +       /* The whole address parameter must lie within the chunk before
> > +        * af->from_addr_param() reads the variable-length address; oth=
erwise a
> > +        * truncated trailing ASCONF chunk lets it read uninitialized b=
ytes past
> > +        * the parameter.
> > +        */
> > +       plen =3D ntohs(param->p.length);
> > +       if (plen < sizeof(struct sctp_paramhdr) || plen > param_space)
> > +               return NULL;
> > + =20
> I think we don't really need to check plen < sizeof(struct sctp_paramhdr).
> This check is to ensure param->p.length can be safely accessed, but it's
> already guaranteed by the early check:
>=20
> if (ntohs(ch->length) < sizeof(*asconf) + sizeof(struct sctp_paramhdr))
>=20
> I think you can just simplify your patch to:
>=20
> if (ntohs(param->p.length) > ntohs(ch->length) - sizeof(*asconf))
>         return NULL;

To stop having to think about the values wrapping, how about swapping to:
	if (sizeof(*asconf) + ntohs(param->p.length) > ntohs(ch->length))
		return NULL;
so that it is 100% clear they don't.
Even if the earlier test is missing/incorrect that will only read
invalid data and then return NULL.

-- David

>=20
> Also note  ntohs(param->p.length) < sizeof(struct sctp_paramhdr) will be
> caught by af->from_addr_param(sctp_v4/v6_from_addr_param) and return NULL.
>=20
> Thanks.
>=20
> >         af =3D sctp_get_af_specific(param_type2af(param->p.type));
> >         if (unlikely(!af))
> >                 return NULL;
> > --
> > 2.53.0 =20
>=20

