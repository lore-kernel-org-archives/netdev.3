Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6292E06EF
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861341; cv=pass; b=AAmUkXcylpOt0BIB2t4uyUXksapI+m98Yj5g8WjdGLleIEkQJnOMGu6DUERlzD6c2w61eU821hlYyFr12COVhPAqysJjtwPchHhSBWOmmv+BZGh7UI7UTQ6z0cMu+Uwbw7dfHArt5fb50i2SiI1seAplYh46nRXGEAqzjRbT3/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861341; c=relaxed/simple;
	bh=x4BbDl/A9we6rVBF2YiQ7ctBxlabzS/pyjjIs2noB+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAaohKIEoqWi1LCH8dRxRZff3WYpLQCLeBOuEkESH89S3qVZRzDch+OSmblAPp7EFHT5iDMSi9Y+gSwjdjkwyoBh1wYndRNwKojj13PjY8uVSiLzR6+fKvdwYo7IHy7As44644XminFRpVAscf0td7sUDCrS/+6gWqGipeCBDEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJJnMNga; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJJnMNga"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a9e87ba696so10126371fa.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791861338; cv=none;
        d=google.com; s=arc-20260327;
        b=SXHljeV4Tc7cT8MeL6nnDsvc8nupEsqym33PT3eE2GEPtF05n/2a0smuCyysVoqtng
         9KbUMmwMJQvLzz6CKOJKmFbiHfQswVELcJ2Iz36KQuSrHshM2w/PJV7IvgD48X/mPOrl
         ySgRHxame1MMy9flPBxadq1G5fXg1vZMx23g66EfJROV/hfgRa+6/EXqAEBNhRpX4MYd
         mweq21Fnn5VBU2cJ/XR7TkmZvXYdurbD+MeFMbV219jhCArpLM0qlhmXYU1c2USU8Nxw
         pq4QIizHlQ08pFOXHOBRunr1fUnZYNtf1tjmL/HLrr44r8ujgwroGspyd9zNNbOV1zsp
         K53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xIZjqcXlZ80U44kw42BFZZRn2DcXYrBGZLcIp8kFrj4=;
        fh=OtRWofodZNiVArS2fRN0wYluiJPegYdXzIbFjxHok48=;
        b=j9tjvQqQxmUQhliJFMc09YOXe8YkI466xm5onlGRg+sRvJpND0Y9sf0o3FfQSA1lui
         wB0HkNtp0FQd/E0UVD5y+YM1tvU1Ecnxtj6OxauL3JydedymiemerUYOCyMwaPFejCJm
         D2/xckZKg5q84QxuWb4yscsdlGBeOHBxIYNstzCmADDK+epARYcK3GZJ3cMCumt4lQ2t
         L2C8ElQf2bl5Jkj8+TM4g288dE0j34h3ZN0Db7JG1ZGjqts5QQ8bjb+wkABhIC9VgOmK
         922JDXjG/R7+fEAQQyMWvSrSjJcD+Mq3mSSvhUDS3Yp9ouuGgXmb8pFcgoCj85Gm8M6X
         H3bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791861338; x=1792466138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xIZjqcXlZ80U44kw42BFZZRn2DcXYrBGZLcIp8kFrj4=;
        b=YJJnMNgaqhLSXPG2YTWImu8Cpo0T/FCzmQYTsXuZ96eyUrD96bmwHLzOUxISq1WtM0
         y6KMxCVnliozTLnmolrxJke3EPZmTifhlSTwAcnxaT4FIpiQ0/MAxe9RWhd8snrH1Pnb
         PYPPcg7Aml8HxA+Lnc5dHcgLqPkrNM4smOy6cfqtGsAIi7Kcumxd3IMvO++MsrBNSH1n
         f/flUGIGRCYneriv9Dzrh3nDzUDvRylZfW+AeyC/ZQH6VhA8D7DGCJftog1GxXDvBFmd
         Tr/66ZiIXoYeQTJ6AWnPNhbdzID7ib0+6dL7rCdUizbZVk4aSfNt3PSufmlMNnq04HhK
         k2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791861338; x=1792466138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIZjqcXlZ80U44kw42BFZZRn2DcXYrBGZLcIp8kFrj4=;
        b=kB3y5S0iVdTcYSyfsLlCob4mrVnop8bBxPA1TG5xLNHfVZjC2W1K/tZODejW8x9JUD
         pslWBmYfhzjkimPut2Do6W3JUq9Yp4CE50rQJRX2waq/zlkKXrwEKvmLlLfcRzPnxCfy
         thumod2n29gCfxPis1yXJix3fWeGf+KiFBGqzp/SRB/Zi0WpBg8HcZuUA8s3AcLUEpIG
         y+l4bZPwg5DSBN6ylch5nIFBG39y/YOgcODHYMZIED3STE4qCss40+gnYKVjUWM6lt4z
         w5q1SUdt85MR+Ed974auKzKEs34OPyTps08NTyHlC77I2eP921p44595EGXKKpSpv1HI
         O4og==
X-Forwarded-Encrypted: i=1; AKwUvBwgIitazN2ZwqNbBiGauTXXAknKO4wTarM5ouUz3dUgcJKw4V7FJPjmtTKJ5IFw7NC7y8WGlJI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrYOXCTV+/2zNo6xZmW/qWDkXGI3IozvMRoF+bg1jAXA4qPD3G
	29XDzA7ohLOAVyhzZMlQtq14MjJSGXtZYgjEFIb7pM7tdj7+fN4Nc2ktrj4yfyd8uO5ZtgEKoQf
	fqOXa2G7CEPJgLo1D733Z4iX1k1D7GZU=
X-Gm-Gg: AYBFou0M29K6Yop6UHTZfkiFpp/rha8EkyYU7SMVoZXdwZ6PB6ZM0PfgzwE0mx5r++6
	DICjRXnMu5DtCxAyBH8DeC0olZ8f+TZLeqpnEpvMXyXKazPlzUjF+rLWtk7Z01IvYzqPPHPbEDh
	mXZfXg82uiR8QdN4PuU9I1TeE9Ix8PragdeCpPR11/ABmrwkM3FU3FkK4UUCosZ+dHm7Zo1ykfu
	lJIh3ccZTJUztA9owkmhsAz00gF5AP4QmUZADT04rgG8/JB+jhjsNFek1Hx53/hmFoNHIxjNxMZ
	1CVHutVlgy9NWz3rbitQ1zpkE0t6YjcvAen0MzlfbxO0VoulK8REko4=
X-Received: by 2002:a05:651c:144c:b0:3a9:707e:ad9c with SMTP id
 38308e7fff4ca-3a9c5399cb7mr27283991fa.4.1791861337759; Mon, 12 Oct 2026
 20:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002134002.3529706-1-anilkaushikwireless@gmail.com> <asCZbsGo90ROQIS6@nataraja>
In-Reply-To: <asCZbsGo90ROQIS6@nataraja>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Tue, 13 Oct 2026 08:45:26 +0530
X-Gm-Features: AclHuK8I_-nCKtduVXU6hQzfYu-S0VawR6OE0DOw_g-Y6WmRACVM-_rryrWj5PA
Message-ID: <CAG0Mgm8tpnF1wTGc9GRU4QYz2GqkWqVN5zbTpNh=A6pQziU+cA@mail.gmail.com>
Subject: Re: [RFC] gtp: add 5G PDU Session Container (QFI) support?
To: Harald Welte <laforge@gnumonks.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harald,

 Just wondering if we are pursuing this further?

Regards
Anil

On Sat, Oct 3, 2026 at 11:28=E2=80=AFAM Harald Welte <laforge@gnumonks.org>=
 wrote:
>
> Hi Anil,
>
> On Fri, Oct 02, 2026 at 01:40:02PM +0000, Anil Kaushik wrote:
> > 1) Is this something you'd welcome in mainline gtp.c?  I'm aware a lot =
of
> >    5G user-plane work lives in out-of-tree datapaths (gtp5g, the eBPF
> >    eUPF), so I don't want to add datapath complexity you'd rather not
> >    carry here.
>
> I think the big question is about the use case.  Do you yourself have a u=
se case
> for this? Which userspace programs (ideally open source ones) will be usi=
ng your
> proposed mechanism? For the existing GTPv0/v1 code we have a couple of di=
fferent
> FOSS applications (osmo-ggsn and ergw) as well as know of a number of pro=
prietary
> applications using it.
>
> So I'm wondering if this proposed enhancement is "just for the sake of co=
mpleteness",
> or if you have any application (or will contribute patches to existing ap=
plications) so
> they will make use of this feature.
>
> > 2) If yes: on RX, once the QFI has been parsed out of the PSC, what wou=
ld
> >    you like the driver to do with it?  The options I see are:
> >      - stash it in skb->mark, so tc/nftables can classify uplink traffi=
c
> >        by QoS flow;
> >      - attach it as skb metadata (tc_skb_ext / metadata_dst); or
> >      - just validate it and otherwise ignore it.
> >    The shape of the RX patch depends on this, so I'd rather ask than
> >    guess.
>
> I would say skb->mark would make sense to me.
>
> Regards,
>         Harald
>
> p.s.: Answers might be slow, I'm just about to go on a motorbike tour in =
remote
> mountainous areas with limited connectivity and/or time for e-mails
>
> --
> - Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.o=
rg/
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. =
A6)
