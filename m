Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5AA558212
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924347; cv=pass; b=GHnpcR7p0Udnm0goihRjAJfgq6CLFlxfL4r3BGCrbl6X/rXrXsXPidONY4DfGFoyM4nuV92s2cUZimNxavB2POL/kyLktT+AqWxGTldUffEnZxODjUmei8cayemJzvtcTCatibMVTqydg4H3zmlaBD6ot8vJD1kn11EKdv0TdVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924347; c=relaxed/simple;
	bh=LOQJGUd0tb6sLwP1Tz4JHSrE5KDQUrXVw/iMmut2Skg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxVXxKecZ357fRsBq6Y0FDl6vY93divDoYhD+hCRreIT0JXS0ValHwUNaeUnitaa8r1gt0AnF1KaCbQqv7PXbfoav4Oa2bagUVep6EjMEKBEDh0IyHPQCJ1VApM48e/We36Vle8MbE6Pwqa9Gla3CxmMvvEOfvStHexHvTc5kFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB/B90oS; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB/B90oS"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-679334baa1fso2820711d50.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924344; cv=none;
        d=google.com; s=arc-20260327;
        b=MFY56Mmgh88ptpzPORDNo5uIxMSvm3echrbnpdPAh2E2tgc8GVMumvTyqb3BLSeBjy
         9KSRMFvrO4VE3lyBDk1ob7fQI7D3MUIzDyglMZRBLO5NdEG9jMSmbFcMZACD0qj+ZqKB
         jWRZhE3VB3y5fsCIlbp+H6YxzUNGYyd2TzCWwuzFwt/fZAJXOeVCBE0QnQ8SQTbn25m5
         cJ/esr41kjoimVzNVYpL6MK7c0w390gaayF97AYtew6etSTOnpuNYnQ+HL/lT4g+DDSi
         2/sceKPenlD2p/hjrmYWPAC8sR9s2tuL1N94X/m2cEviyT1zePFMqZkPzLP1z43h27Of
         zrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fWuW5Tulp1PkJxc5NJ3dJaM8+S2XORNyQfLC7kk9yRk=;
        fh=colA8yOnuajcg1cESNtbTEeoE+VZr9LC/FaBExpmjJI=;
        b=KSxH09PO2srKizrTSBGtOG4K7qAGxE4jdIRqO5pp5C+tUIEaDlHAwgLei5X+YANtcr
         AqeAV9p3lB7WyfGBTuaOoN4V9833PMJFRaHzkKVa80vp9BTicchQ0feDkMTVGyOGmFiY
         Rk30y8AWjNUjBi43bOWF8Cl1ijaah8qnAsQXvwhpMroQVwurog1fXc9AMR7aha5KRSlh
         fPF+4gKOTVYabbAw5gk+qPDx5DqdUq6F8A81ONGh+24hT7AeVFxbZAnCxhnxl0f0IIia
         hsq9Oz6+hWBbFX/Nr0dDDICrkLb2sBTpboBy2Bs8tsZQwP56H+9mY6U7jPlW/ZOoAPRR
         YlgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924344; x=1792529144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fWuW5Tulp1PkJxc5NJ3dJaM8+S2XORNyQfLC7kk9yRk=;
        b=NB/B90oSlA3coXq6rsIfpju1Wy/mGE4vhSI6eACgG5NAXnH3cbMb70Y9IbriHYnNpq
         b2iixFyxyAlQ5kczmgQjPqX3khfTqqX98OfKnWOkjDBxoh1fQ+qjdtzJ8hUsTZy8ZD36
         q4Dt14CnVjIGrKXAkM1224n2Ra4uF/3vNWSPOOcOObXVP9kiwKR1hzOSUOlDtOHCXEho
         T4v1S3rnsKsXpQFK5uVY7Q8kqH8yTpDIUknTaBF43iMMHJ1GNCg/OS9lZWCJqbRtblyN
         AvY1Vl8pqbAzNYsebvLZkMnx1TLjgqNc2IgEQAfJuUPpZgm045rEMjgd16+YwyviDEXR
         mwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924344; x=1792529144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fWuW5Tulp1PkJxc5NJ3dJaM8+S2XORNyQfLC7kk9yRk=;
        b=r6EKWvYfXabIepdqzvfTXWXdgq7RPOPXQNESFOK9Su4Efam4tCIRidzhP87amCX0Ta
         wCJMB/HiJdMBdumoak4lJVYCz/FqwGr0FD++OBKlArIf+be3D3rJe2HGDI6cab4Ri7zv
         A7dj9M+E5fT0ZaJQtUy8/qxGIfIhm5KijJtNwUjufuh+TNW7BqDpNPdJpqybOhy9wd8h
         n7ntkXhM/dr3Mb3+SakKgGHWWwUpQsaMviI2pr43jeowcP/xtVKnxKifrGjYPWKf3xu5
         WDp5LEx8+WeipPdj+20eUynomP51Ql42XOqzUoRtyjZpExRfeugOBichwacW7AMGg0uP
         rypA==
X-Forwarded-Encrypted: i=1; AKwUvBx5imz3dgJLAusMZZxNttGzBxGnMF+lZCi9rjWqjYyJPOGZIEIrlVIsiPiJlfpvbDnMpZ7M9FM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOUi5kNiuTKInBDTK1vr6PB1CiRr06TXVtKEhAD+izVaHH4mrt
	xKnkB6awVTdIEI3xzlcddid0Plpm+Mz3cWwGX3Ft7A74RlUJE9WyZcSs8m/J6nfy4v9+sEdCv5O
	dnYJGWS3QBh9lWOkGWexKwqEj/QzkxG46Mg==
X-Gm-Gg: AYBFou2smVVBihmgIhmvIBv9MnNzNgiwWIPymuSWTDlapdyA4yvgBQ++WcjHU0YChFo
	OFQyMYRU2UsTz1lpDZ4//jqXQ7fhKa6+axB8BmGHMXsnsS/3Ja9czXADW8hAft1T0/AO5pE+vH5
	bHqTMF+n/FK5pOj3c1csys0/4/MMUOiZTQDCxMGzqWjWj8xVzKGIbM7yup7GTm8mk4OSutwIkQD
	9M3dwVoohSwu2Rgir/V83tdCMq+9eZdGDluAcYxwv6w2drKUAZsWlh7TLJ65BmjMAR/4rrHeGZG
	OKzG2eGUlmfcBz/cIrGEFrzdlQh1J6L0q3FwYWkAs7BE7RPmSGuYmO6b97QAWdlW17R0gikmaWn
	YH7jWdLPqavFdwoo2mZtYaI6H6wrHCGVimirBuMdl
X-Received: by 2002:a05:690e:4391:b0:675:3d40:3c34 with SMTP id
 956f58d0204a3-679362b7b92mr2567508d50.68.1791924344382; Tue, 13 Oct 2026
 13:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791887415.git.mst@redhat.com> <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org> <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
 <20261013143335-mutt-send-email-mst@kernel.org> <CAF=yD-Lz92nGVFab1Dq8M9VusDsKf-ioda8KrZoyh28x3Xtg4Q@mail.gmail.com>
 <20261013163706-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261013163706-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Oct 2026 14:45:07 -0600
X-Gm-Features: AclHuK_JpsMMVGA2qpRX99GQPNBQTbwUfDE4ZxrsneX5jMqoFaA9d7dnLCSivEw
Message-ID: <CAF=yD-JKeej85t+sCc_5K0b122uw_LiKWwX1fRL2V-QLrGA8QA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at ingress
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, 
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 2:38=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 13, 2026 at 02:32:26PM -0600, Willem de Bruijn wrote:
> > > > > > +
> > > > > > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_t=
ype, inner_nh,
> > > > > > +                                            inner_proto))
> > > > > > +             return 0;
> > > > > > +
> > > > > > +     if (skb_is_gso(skb))
> > > > > > +             return -EINVAL;
> > > >
> > > > This is a risk the commit message will have to call out.
> > >
> > > I tried with this:
> > >
> > >         > > > We can't easily "complete the checksum" for GSO we don'=
t recognize - GSO
> > >         > > > assumes knowledge of the protocol. We could segment ign=
oring the
> > >         > > > checksum then do whatever csum_start and csum_offset sa=
y, but that
> > >         > > > seems like an overkill for something that should happen=
.
> > >
> > > I guess I can add a more detailed explanation about what the risk is?
> >
> > Let's just explicitly mention the consequence: non-standard GSO
> > packets that previous would be sent may now fail.
> >
> > >
> > > > I don't see a simple way around it. We discussed segmenting here to=
o,
> > > > but that requires intrusive changes to all callers too.
> > > > Alternatively,
> > > >
> > > > 1. call segmentation, but only to see it remove the SKB_GSO_DODGY a=
nd
> > > > thus verify that the TSO/USO packet is valid. Still drop otherwise.
> > > > This also does not add overhead, because it would be called later
> > > > anyway.
> > > >
> > > > 2. a failsafe off-by-default sysctl + static_branch that skips the
> > > > drop when set. Messy, but so is the situation we're dealing with.
> > >
> > > Tack this on top or do you feel it's needed straight away.
> >
> > Not urgent. Can even wait until a report appears. But worth taking a
> > look sooner if either of us gets around to it.
>
> Maybe if people intend all this for stable, I'll feel safer with this in
> there.
>
> Just to make sure, the branch would just short-circuit all checks, yes?

Ah option 2, the failsafe? At least any new failures (GSO) that could
cause regression reports. Operating entirely as before this series
sounds fine too.
