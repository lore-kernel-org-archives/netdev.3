Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E172D1913
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299414; cv=pass; b=UJm1d7ku7n2RNLe20vHKrvNWYqzHeB1oFRyluG4+g6kSQKtSnRqX4GLaCoG7N5CeWVmqHy7vao8ynLW9bE72wlauPqO0Bk8GBwbJ/Js01zQHkFEgs+1VaD3n80GADvqSqveX/8t/feu5jexhQOBvm60SIq+GiA5yzOFK3fltJgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299414; c=relaxed/simple;
	bh=MR2TZ1Q3N9PhLnZN0PS8nEqWSbuEWQmZN3/O8zlQjok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1Mv3ZohZ1lgL1hpg/b9D7VQ+mg60w7BB3nedq4FUdbgdwbg7Pg4WGY6Wo7fPUlPTelrVH7CNSuDIA6TEfie1WIvPpT7nlGsy6ruJYnSSRMtIZu0Rs7bUBzrA2pziwR1HykG0IAYhL8Lz0dFdJVRmKIMmNt92VicmBImVQc89O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=AsZQyMBI; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="AsZQyMBI"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66de7e0bc85so433541d50.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 14:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788299412; cv=none;
        d=google.com; s=arc-20260327;
        b=I84fFbQKY01D3Lo5smWs+ZpzNApLlJP/qTjCXTL/OF3070Cl2XjGfHi8f1mUdtwf9i
         /5g4dRsgLzkHSZkdim4L4X0QUvAGLTVSN33RKQtoi5M2fNvDWhfEdDdy9gyF2ccYT+cA
         W5ox6rQPTcoTxS7FAQbcYo8fUF2XiIa3+3L1zLH6J3u7hUk99GCmJi28SkjhSiNiV7VR
         GxDRgcMPEyMMqPrlXdJ6nWmbFRs6bksgf+EzJl8kwMl6brlLci9aK7gRG9QfYkU1QThk
         zSqyroyWepU8CX9QDSx6uSAoDRnvz3oE26NyF3rgsciPSUivOWXwGFAQ5GPqRspaI4iV
         IhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjUfvt/GMBgEWoZnN99ClfGt641ZVdtwy9MHd1HRQmg=;
        fh=FfK+5EN3ze+EK37bef0THWCkO3lGAF5N3Q0CeqAkkXQ=;
        b=PTZCAQLpY6GSQxI1Mv3qsDSXVMKOC5GoCU1c9lj4e2FQd2QRRe03RmfW7qqb6oYYnJ
         KScrNALpIzTAXp9XLuJlgLz7UU7Vv/6nFfLF75tapQZBkr5NtFgywwbSzMfLC6zx/cqP
         u2Tr9ozkLDY5WpA9zsoSwh81yKWEq7F4tipPJExBs9xVonJJeQyvc53lIL6E41buZEOF
         COTKPUx5srVBDoF82LL8lXNBHmqN6q7Czok/iLTuLO6BLSsebH3N0imwGpkFiBt1eF/Q
         wcc/ywJzk6/DGASk90VGrBGACmA+1Ea/MReKa58cR2xdzDMRy9rgJ5W+dnsQ/qEs7WcY
         x07w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788299412; x=1788904212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NjUfvt/GMBgEWoZnN99ClfGt641ZVdtwy9MHd1HRQmg=;
        b=AsZQyMBIRerb0oxXPcaypQjvD30tPh/WYrkmJb4GQE68siVIMQUMY8OQieRBWuTxaU
         xlLgkhYd3l1/RgR/ek73oGBqlE/OLlUWYivdMrdkB94xi2M+Cvo2lduswXmdPRlbLJIm
         P7Dk4NUz3XccPRlVH2dWbissFhAyRubYW//sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788299412; x=1788904212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjUfvt/GMBgEWoZnN99ClfGt641ZVdtwy9MHd1HRQmg=;
        b=qaE69+tPddglDWPsx8MYRvRZun+rqNSOvYcY4mNOLxInzHxL8YX1uusiehm/zqhLAg
         48vg5pnnRu8psH+mb2WbCW2Car53q1jnVK5NFqt/O2TGuayig1gZJf+p4BTtUWUebgZU
         2oXY0kLAavNSz6qYLndmosgm4ZOSpfXtRO1dG2/ESJRAuuNiy89sqDqFUtWPaWyhHi7Q
         cyapSUdcGngkfkrRQWocrIfBka0g9+vkrtqtIXN1sf9hTir3wuBKXqGtF0z3byrSLofo
         GApXUjhMuBKfp35jENRP+6WnsVb79QdSd6I8m/QzIvYMq4zbLigYpJ44bafe20wOZPTL
         rnwg==
X-Forwarded-Encrypted: i=1; AKwUvBzUk+PZXL/iJkMBk3GnwqLRwcPhrZYT21AejsHKqEMqFya/KxlIfVASBeD5AGToFF6ECqXUQos=@vger.kernel.org
X-Gm-Message-State: AFuF++mYXgMPGw4oovfNgkAUQNmOA1e2uDygZyemmEBBeB5Ze0kWNm03
	DHmQ8aPtollbRQ7SXHmUXkAcjSo63eg/s44j9RlwWaI8BYVDm4LtsBTfCp1kjl1pKyKDIqImKlW
	13DgAhRUi7Ek6sJPXut2mS/eVPK7GGsCsZx934QbR
X-Gm-Gg: AYBFou1qDw32BfWfmCiK8oIUFhqJcWww7JGW3Shzt+93ETZqgUZabeNu6pU2Ag+toMM
	/YjkIp4BLNomCLiYQrt1Ss3rT0fy+bFGSbY1fMAEJf+mnDWFJjFV4rTeVoMv7etiXxgk1taddz+
	OToyhuDgZ9LVXwiZaLwWUzQCKwJJnZl39qkPpjTkBj36jAk168L8kOeHcEw4xMtTSzM3wcWFlw6
	gpcJk/L54v5E4TEX8kFlXBXbkQVV6wG8ydGlDwfNoRt1dcdSbcn1VfMe/kI7d2OI6zy5iadq4xU
	jHgzMBODe7gArE1xk5gNGA5IqaCaLmIMmAW2wSwDsd0nscjhTIl7Y0CrHBOTGbhaQW2rPg==
X-Received: by 2002:a05:690e:2142:b0:66f:9635:9802 with SMTP id
 956f58d0204a3-66f9bc0aae6mr50284d50.23.1788299411979; Tue, 01 Sep 2026
 14:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829205422.854785-1-victor@mojatatu.com> <20260901095101.124563-1-pabeni@redhat.com>
In-Reply-To: <20260901095101.124563-1-pabeni@redhat.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Tue, 1 Sep 2026 18:50:00 -0300
X-Gm-Features: AcwNN1V1FQzy2lGVtoKJfSL2EAoaYI9J0AGoY4nRQWMDtO4YEfArFz5JcAXTBaM
Message-ID: <CA+NMeC95jnvqA-m7zTyUX4qmuWqDL-w=Ftx4GaAmXig_2uPjxA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_route: free emptied bucket on filter move
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org, vega@nebusec.ai, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 6:51=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> [...]
> > diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> > index 0d1324c90583..17b0ebb76662 100644
> > --- a/net/sched/cls_route.c
> > +++ b/net/sched/cls_route.c
>
> [ ... ]
>
> > @@ -459,6 +452,7 @@ static int route4_set_parms(struct net *net, struct=
 tcf_proto *tp,
> >               if (b =3D=3D NULL)
> >                       return -ENOBUFS;
> >
> > +             refcount_set(&b->filters_ref, 1);
> >               rcu_assign_pointer(head->table[h1], b);
> >       } else {
> >               unsigned int h2 =3D from_hash(nhandle >> 16);
> > @@ -468,6 +462,8 @@ static int route4_set_parms(struct net *net, struct=
 tcf_proto *tp,
> >                    fp =3D rtnl_dereference(fp->next))
> >                       if (fp->handle =3D=3D f->handle)
> >                               return -EEXIST;
> > +
> > +             refcount_inc(&b->filters_ref);
> >       }
>
> [Severity: Medium]
> Should this duplicate scan compare against nhandle rather than f->handle?
> The destination bucket and chain are selected from nhandle:
>
> net/sched/cls_route.c:route4_set_parms() {
>         ...
>         h1 =3D to_hash(nhandle);
>         b =3D rtnl_dereference(head->table[h1]);
>         ...
>                 unsigned int h2 =3D from_hash(nhandle >> 16);
>
>                 for (fp =3D rtnl_dereference(b->ht[h2]);
>                      fp;
>                      fp =3D rtnl_dereference(fp->next))
>                         if (fp->handle =3D=3D f->handle)
>                                 return -EEXIST;
>         ...
>         f->handle =3D nhandle;
> }
>
> but for a change route4_change() has copied the old handle into f before
> calling here:
>
> net/sched/cls_route.c:route4_change() {
>         ...
>         if (fold) {
>                 f->id =3D fold->id;
>                 f->iif =3D fold->iif;
>                 f->handle =3D fold->handle;
>         ...
> }
>
> and f->handle is only set to nhandle further down, after this loop.
>
> Taking the reproducer from the changelog one step further on the patched
> tree:
>
>   tc filter add ... route from 1 to 1     -> handle 0x10001, bucket 1
>   tc filter add ... route from 1 to 2     -> handle 0x10002, bucket 2
>   tc filter change ... handle 0x10001 route from 1 to 2
>
> nhandle becomes 0x10002 and new is false, so the mismatch check under
> "if (handle && new)" is skipped.  Bucket 2 exists, so the scan above walk=
s
> ht[1], finds the filter with handle 0x10002, compares it to f->handle
> (still 0x10001), does not match, and the new refcount_inc() is taken.
>
> Does that leave two filters carrying handle 0x10002 in the same chain?
> [...]
> The comparison itself predates this patch, but this patch is what turns t=
he
> renumbering/bucket-move path into a supported, leak-free operation, and i=
t
> adds code immediately after the faulty comparison.  Would
> "fp->handle =3D=3D nhandle && fp !=3D fold", or rejecting the handle mism=
atch for
> existing filters as well, belong in the same change?

This is a pre-existing issue.
It is a bug, but I think it's more orthogonal than Clashiko suggests.
I see 2 separate issues:

- The leak (which this patch fixes)
- Duplicate handles

I don't think this patch makes the example Clashiko described
"supported", it just fixes the leak but leaves the duplicate handles
issue unaddressed.
I believe fixing both in the same patch would make it look confusing.

> [Severity: Low]
> Could a tdc case be added for the cross-bucket move this fixes?

That makes sense.
I can send a v2 with the tdc test and then send another patchset
(including a tdc test) later to fix the duplicate handles issue.
Would that be ok?

cheers,
Victor
