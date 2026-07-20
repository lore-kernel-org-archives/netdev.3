Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F973CF1F9
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536006; cv=pass; b=X6IBe8N196WrEbOPs/0MTqAsCYBXVCYB99SbF3YvWf0pTjTBB6NSf4yCJ/2Jy9kvHPzx76L85PeuSr/YtjYsKYAmoANAntXFmYZHMGvj63KUbjQBePWZY7AWqlpyT4MOqfbyD9gM5KBOQ7mXxOsMN7PI5Mt3HgFGBXbA5y7BG5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536006; c=relaxed/simple;
	bh=FE4rE9ZmDHjWh8PzHPlEHvCiDRsHpgN7gW6lJnUuzyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIoJBJ1tAju34YdncaieS2rYzTEM8QF8nNPFvMQi6CZWZcbVaKBOmhAZACKn2vW1eV2ewPpqGPX+M5vxgdtGw5QjQo8FdIqag8ZXR3ZWDoxeNDOqAMWLKPKYH/xpINUCr7j55VPOIEQcegaS58qGncG65BUSVLnzT0UUGy4/S6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mekzi1PL; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mekzi1PL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5218927884fso36364321cf.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 01:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536004; cv=none;
        d=google.com; s=arc-20260327;
        b=KYTlJbQPKmlPtYJ+A44Ww5Dq79CFD5Rv1F5cEcF4sE4JueuKRc3jb+4jUbmYiDHrKK
         ij9gJzxx7owpkdIPnvCH0wHMAmwEYuUhEbpkChGSTi66QdIXxpNXl1uaLb7eFcOc6uOb
         nT/dJGxQlAeXhx+C8ykHUEskp7VPgHOu73D4XtCG9SXAsNcxAqdMorK9urqQgifjSvVE
         oh8E2fV8R7y8knNqgDvlwXipeMaO4JeerqWWz9lfbUEj/2qYgOmXLiPeJjjZAv08yiEf
         71CURuHZrnDezOjUe2s8ZBbO8LhRPt5T0tKDezeaj4iugjHBE0I+CbqJjCsM8TKGV5cu
         Df/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oe0i8b8XRVkHa2TSHijT+USSrZ/Aozb1yDMwFbU6CCk=;
        fh=Sm5QEvh9WqTUJY/6QCWG57lWPYy97/Yai5DytDRrZn0=;
        b=MI7FU7Poz3hek9dyMZrUCSzSA01mzmlmCzPaU8OednnnsauP1ztDSQpikfjgGPdxHO
         IURsbgfRAd1DId3886HYKvexM+ZFsG52GWBg465wskCLeBju9vp1m/l1ejjJF47O00no
         8u+qUuNoDW9SonVRRcnxuau9ru/FrxkJDCQHjtacfBM/8ZjriIPE5CJOD1fUij8yLrP4
         UvbMmnf6XvgWQ7C0lhdFVDIE1z8jCnbeTui6r2jer/ZlLcE6g1vXS6o9gTNQYEkrOt36
         ckHsPVi20bO9KoBo08NnGZhChgUTTyXHqyGfxA6GX8qy96LZCJ0r6O46U1tMc8T2kJzn
         cEHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784536004; x=1785140804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oe0i8b8XRVkHa2TSHijT+USSrZ/Aozb1yDMwFbU6CCk=;
        b=mekzi1PLViErsH21rCkkn6EFaFNxO0zy6C7S6fKDaw9eCW/UHIqiaoqlEsuN18/vA4
         b50bd1tpIG1eKvv0Z5ydUc21p4dCEtANP84w1mc5OtuOyq+dL00ZNgnW6AqL5A7gz3Or
         B2S9gOCAD2BCOXrKoWc1/Xa536tCcc3cN11Ih6iqZWBBFp7kWM0b6nDBhjvIUehsf+zT
         P5GzFmlEpKpLtpQ1CEqpZNvsm/ZNa/F/Wo+CQ2bUXNYK2fz5FwjScdNWQwnZQXZLQh8j
         kPpD+QyM4qkJiwGsznjoL1EshyYd6Xm5QKv1vQ3bMM7NJiOaAS4ra5onyM+mB8L4hjLs
         aVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784536004; x=1785140804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oe0i8b8XRVkHa2TSHijT+USSrZ/Aozb1yDMwFbU6CCk=;
        b=POO93fFSPpAA+IGQmpRZ6o8FKVzOd+1nmp9+yYXLOlm1hYF+XqROF8YdDd1zDmyEZS
         Fq+cHFbYZlZ7RknO/cPiceMFnccqcZ9PfotCqYNgvZ0D6QoBIDNl6/JYY13sV9Xk65Pt
         NL51ZO+y79Om8aWaTgvEuX464m2I9ObMeFjgjgcXQhRtLDzIOzDhFpvDHq73bQSXGsRl
         Lo+m3VzK7L1vX/if/8/8mbF81eT7CMwbGw1YJSViNF22mL8JRyrF6rsNAffuEs6KAgW6
         sB2hCgPBxcdrj9FtKhfctj7Alxvr4W7/Zbh8Ns/i9iU/SuUypjBBVLvnB0QA7wYG5o/G
         VT+w==
X-Forwarded-Encrypted: i=1; AHgh+Rp+rc1yqzkKXLzd0OpHmZ1sNmM/GjImUaAHZW94k4ZBb7DxVq/nM4FVpg16ag+H26ZOKxJLf1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwJWF8FMmdJnAeHvGdt1OPTJzTbQ6fddMR2p3WO+7g2VaaDhH
	6AYf9y5qkLtw7Hhp5l0SNhYi3kSf+5Ttxs8tM90D2ZlGRetvEEGt59knnr2dLIFtp6czk5Ghi6w
	/3ji7XEiLqwLxkCTx1hiz9vtv96UCADC9TFiDiR/R
X-Gm-Gg: AfdE7ckjIVU4XCjCxUV26B2Yq8PIiLZV0CbZygdmIXft0CwArEsyUC277RgDAhVNq4r
	S/EFxgK4HsO/HfrUeMc6DGxTgWHUc2O4xr4H3K9W+8UJOHYCLqK3AC02NKXOyDQaaOEkJp9Pe/h
	Q8/+SiRtXgS6yR6wx8W5Edf+rzAWf+RghV8fR6f0GiVKekmrh5FVAPu3OM1RdyLtS3sd36aQtx4
	NPY9EHWB/t1Z9mbOpG03t8mX0DmxLeMLT/QPsGJ+4p6OS9Dg+I5ZCjv0FQZUxgd6WYbqdkRq+Yz
	hm2qcwerYYx/cro2Qc6NYIqXBj3blHJgmHhMKAbzXfM6NXjO9vV9ELuWgOjAMEKQ88eyj7Rmguv
	mVvxM+LPjyQwSRDO3gKQazdy/OHnykS8=
X-Received: by 2002:a05:622a:1a9f:b0:51c:a70:5ed with SMTP id
 d75a77b69052e-5213ad60752mr119707061cf.30.1784536003526; Mon, 20 Jul 2026
 01:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713151435.1815104-1-yun.zhou@windriver.com> <20260720075352.GA2233846@shredder>
In-Reply-To: <20260720075352.GA2233846@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Jul 2026 10:26:32 +0200
X-Gm-Features: AUfX_mxPpTIeWhK-tBjzcXpFJCGO2ax9DwM-SV2XcPhaD3NA6ncJUkKiHPKL0Oo
Message-ID: <CANn89i+im-_LnJgF3M=fKhstVrZvLb-+BhT3O62cRapFwV-Odg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: erspan: set lltx to avoid sch_direct_xmit deadlock
To: Ido Schimmel <idosch@nvidia.com>
Cc: Yun Zhou <yun.zhou@windriver.com>, dsahern@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 9:54=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Mon, Jul 13, 2026 at 11:14:35PM +0800, Yun Zhou wrote:
> > erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
> > nested acquisition of _xmit_lock on the underlay device while already
> > holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
> > the same lockdep class, creating an ABBA deadlock:
> >
> >   sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
> >   ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
> >
> > Set dev->lltx =3D true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
> > This is safe as erspan_xmit() has no shared mutable state: o_seqno is
> > atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
> > the sibling device with identical xmit structure, already sets lltx.
>
> erspan_xmit() (unlike gre_tap_xmit()) is performing non-atomic
> __clear_bit() on shared tunnel flags and KCSAN will probably flag it.
>
> Eric had a patch [1] that changes erspan_xmit() to use a private copy of
> these flags. I think it's better to wait for Eric's patch to be merged
> before setting lltx.
>
> Eric, can you please submit v2 of your patch to net?

Sure, I can work on it today. Thanks!

>
> Also, doesn't ip6erspan suffer from the same problem? Please try to
> reproduce and fix.
>
> [1] https://lore.kernel.org/netdev/20260615140333.3161072-1-edumazet@goog=
le.com/
>
> >
> > Closes: https://syzkaller.appspot.com/bug?extid=3D9bda1b9fbb7fbdf9b62b
> > Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
> > Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> > Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> > ---
> > v2:
> >   - change subject prefix to [PATCH net]
> >
> >  net/ipv4/ip_gre.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> > index 3efdfb4ffa21..9fbff16cda1d 100644
> > --- a/net/ipv4/ip_gre.c
> > +++ b/net/ipv4/ip_gre.c
> > @@ -1363,6 +1363,8 @@ static int erspan_tunnel_init(struct net_device *=
dev)
> >       dev->features           |=3D GRE_FEATURES;
> >       dev->hw_features        |=3D GRE_FEATURES;
> >       dev->priv_flags         |=3D IFF_LIVE_ADDR_CHANGE;
> > +     /* Skip TX lock: xmit re-enters stack, risking ABBA with underlay=
 */
> > +     dev->lltx =3D true;
> >       netif_keep_dst(dev);
> >
> >       return ip_tunnel_init(dev);
> > --
> > 2.43.0
> >
