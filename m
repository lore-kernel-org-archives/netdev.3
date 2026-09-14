Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CB134EF0C
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366169; cv=pass; b=RH4ZdLhjXrpOHF31MgDkEgJHVQNZDySnxWOptwe0ahOxf5ESKCteSoDrUYLZk7nRy50reSmPQe2lvy6nknMx4oQOGHGkgWKa7CE/CAxOMmmlUQBRLtDpvPFKqxGcG5OrZqtsqhA+N2mcWqqkTXzVzpMLOufAJQ3XS/3dIIAcxh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366169; c=relaxed/simple;
	bh=/3+fKvkuVzZI3yTENHFw9anK9beOsQR+LXpa6CcOy24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raSf2CCO5fhUvzZb0Uy76ti6maTXZgBquZVJEAtI26OOEf7wckWQ+BztRbKClpGUhdHnAxybE8o9g8RScnkRjNpjDe3otVxbQYyexoX7wyRT57EhN9H5YlEfsshSRWfT1S2BtCHq+bqKZrXDh0mw8LcvMXnVJjIEtJ6mxc8IFzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=IFHwZrrI; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="IFHwZrrI"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43db0c17so9446097b3.3
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 23:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789366167; cv=none;
        d=google.com; s=arc-20260327;
        b=P/PfMBVHChhv809NTyIcbCzUvq8dtAcKt1JoU8zJNX7kSm/kN3cnLF+E0z0Z1C3s6W
         RHzHqlcm9JBiWj9P/c6oLC+Q+4KrsapYm/bb07of6Yuqg8qZdLjiROnyyBHuMJb+uYVL
         TNXjovdFV1N0Ob5ru857yk+FYCFQchFGKFXGFOMuDEAmhT7rmYQTF6J0I+lfVcrPv45n
         tGV+4Wb7SkTxeZAlKuK3/FPpPJ1BXfr/CQ90604ovEcceOie76f95HYULZL55rgWWHZu
         VI7tS/Fj/NFN4z5df35bFQoW4ow4AQjwWZVxwu/xSaLj6oa8bkPFi7YZ03M880uw3J4w
         Rl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/3+fKvkuVzZI3yTENHFw9anK9beOsQR+LXpa6CcOy24=;
        fh=RGJJPTPuC3WcsGfcvaEjrBi7t4Vflhuz075kqLTVZes=;
        b=iVFerqAwDpZSf6760XQRyhlTQs51b9D611+XdfA3mg00lTGlJ3SXfxCUGKxQHiHMzh
         FmIfGpp0xSSuhSbEbFBValY4aB2QUp81Sx3BvNVuP1PpTrbh4k9rffpbEhmGx+zsRO5D
         4hkhLZ+c9mznsXL9kQH5+fiik2l6ono0fEqWrSaeHY4im5WXYR0rUP+p4oioTNTiia3n
         umhQArRsdB9qguQP7OvONc4Bbf/9O+qx/jGqvBrU82PZCvEAMCx8OGfRkfJu6r/MuvaM
         0bpHt97rkpeswWFi4vI4rl5bG/p++vnN0Eyj8Y77Y4b7Md3kaPIAmP+3T385BKmvx8ux
         2X7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1789366167; x=1789970967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/3+fKvkuVzZI3yTENHFw9anK9beOsQR+LXpa6CcOy24=;
        b=IFHwZrrI6w7CDDhn9cxAX85WQzrGhGvK5StEiGWzvXWz2FFCeFy70TVAH8gzpUTGsY
         A5Zpne1xXRImQwGKGlvfLgxqmpy6AB8fKR6aIetJXUAWGxPSWs5sDcmLx8yQ53wAsGBr
         g/8UL0mpSaCmKwvx1aqK2PvdAm6FcdH1SFIFxSBkT6OJfHhElKDzugFoy3rxXfuotrMw
         0r7xHc56EUyb5s1iUIPjlmiv6HPuMXt5Zvtgp9gAdhyq47v9f6I026lV2o6bNyborLmY
         o1Nmu3hjqqqDafoeAL2R1zNOQvR6K4J/tLDTlNlZPIYJplDJOZYjX/A4mgyCUT0rktOG
         Sy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789366167; x=1789970967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/3+fKvkuVzZI3yTENHFw9anK9beOsQR+LXpa6CcOy24=;
        b=Olhimd0z4k5Dd9mR/nFSdioTL1gStEnz+KnGst3SMmZkY3zvi3S6PSX9SheQIXybZS
         QwVTMRRFUNZah1pf9A8aCYXJGoFVcMxcfQ9zrEHew190wImcRcrWDQiT8OlGbRQbo7Zs
         L28VjjkHlOCyiZa0LSJRvPNLAy3jKXS5XhWTbF64XXuIk9GjW2nujrtuAwGjWqO5vSay
         9Rbx0Nra50uxlTgBxXECarP4ByRatOE7dj+VIm3UIIlhZhS19IJa3PYIQn3MtLmXLbyK
         VxzmlTUFxi1zjE3KxYrpaTj6NdWKXCYkoCXvcvwDSodIlGAQ4iQ8jgDnJndyR2+g2A9x
         bSrg==
X-Gm-Message-State: AFuF++ml2GvQSbwy5/Bgmm75hkxj7SUxKpy+d00GmFqp96uKlkT6OAJF
	OGrK8VZ0Vg8Ha4pYGj6jKHiE0ZgnJnb9pFv5S4VO9tZxeIYTRvMFp8XsWHX3KOPyCYSXWhS8c3K
	BGPlo9BW7cdQ6Zjwfdzqh19T0cwyE2eISAlU4Mbm8
X-Gm-Gg: AYBFou3t+2kMi69QcXBJQGKfGpPr/ZAlDGkM8JTxKUuPwCR4CJGdJv/zwpPnZtH+p2R
	tEpG4Mt+a4ASSoUceitEQIWKAH00VZlfOMMjPClA2wGw3Hao3YbcC4MTnw5tL9VIUZ/L3LO+MoQ
	rSsRgCMb4nSynKpQPVW16GPste8j803wNukNNc/M1t96DJP/zVnIqu2hD/VG/0+DjC64dBs6yd4
	TNngq4iaYNaHUWnwgkDxa/CMyMudCYUm3hF/KNNypEIF7LoBa8Z0wPi3cGDJ2PvxlXRbVlmKbAt
	6ZRj1IBTnBP82iTqWellpadQwjSFqHzS033TZlXPWukZ0Suz10Ae5J9lT8EUuiWXHauJCRGse1B
	FLqxp0s14Mo+44rQfU3oRE4WSahd278ktN6iIfwzj9+fvgSISI63SjG6tMUcSYk8CjLVPLN3xDM
	cNSl1DVk6BrfpGv3gQBVOAAftFAE4sUsXghWKRfJILGpDqtQ2BDzBsthhJ56qvQ3rOd91IyOKus
	VifPZd0rqznwBqtyZIOuKSbww2jRzSvKd2LwtrPb+8ZHo4R4+U9sH8m8Usd/UdTdKFgZrLEaK/L
	KXxbJM0fngQvNw==
X-Received: by 2002:a05:690c:c4e9:b0:81e:9b09:7210 with SMTP id
 00721157ae682-88d1f213cbcmr2649667b3.16.1789366167145; Sun, 13 Sep 2026
 23:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC1t37+=keDdX7=G+zyPhBx2LgRNEuoB2tonHF5itrN+Lyx2+g@mail.gmail.com>
 <76f93dfb-b5c0-45af-8358-8ddb7f2f560c@oss.qualcomm.com>
In-Reply-To: <76f93dfb-b5c0-45af-8358-8ddb7f2f560c@oss.qualcomm.com>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Mon, 14 Sep 2026 06:08:49 +0000
X-Gm-Features: AcwNN1Wquu6glia9YRcnPuV6nnrlyf9CFu6ebQaAj8Y-YAVJDDanVWkgmH79wGY
Message-ID: <CAC1t37KXBh8qBZLxnft9VPPSyazTmMgLKvuJLOpmC_DvwStUWQ@mail.gmail.com>
Subject: Re: PPE driver: are qdisc or flowtable offloads planned?
To: Jie Luo <jie.luo@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, robimarko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jie,

Thanks for the information!

Julius

Am Mo., 14. Sept. 2026 um 05:54 Uhr schrieb Jie Luo <jie.luo@oss.qualcomm.c=
om>:
>
>
>
> On 9/10/2026 6:11 AM, Julius Bairaktaris wrote:
> > Hi Jie,
> >
> > I am building a PPE flow-offload driver for IPQ8074 in OpenWrt
> > (https://github.com/openwrt/openwrt/pull/24806/) with a DSA switch driv=
er,
> > PPE flow tables, port shapers and queue classifiers.
> >
> > It needs two kernel patches that have no in-tree user, so they are stuc=
k:
> >
> > "net/sched: sch_tbf: carry the queue limit into the offload" adds q->li=
mit
> > to the tbf offload params, so a driver knows how deep the queue behind =
the
> > shaper may get. Not posted yet.
> >
> > "net: dsa: offer a flowtable to the switch before the conduit" offers
> > TC_SETUP_FT to the switch first, so a switch that owns its own flow eng=
ine
> > is offered the flowtable instead of the conduit netdev. Posted and reje=
cted
> > for not having an in-tree user.
> >
> > Is a tc/qdisc or flowtable offload planned for the upstream PPE driver,=
 and
> > on what timescale? If yes it would be wonderful if we could align, so t=
he
> > two patches could go in with it.
> >
> > I read the three-part plan (PPE init, phylink, EDMA + netdev) but did n=
ot find
> > an answer to my question.
> >
> > Julius
>
> Hi Julius,
>
> The PPE functions you mentioned are advanced/enhanced features of the
> IPQ PPE. Support for them will be added once the three components
> mentioned above (PPE init, PHYLINK, and EDMA + netdev) are accepted
> upstream. These enhanced features aren't available internally within
> Qualcomm yet either =E2=80=94 we'll discuss this internally and work on a=
dding
> them.
>
> Thanks.
