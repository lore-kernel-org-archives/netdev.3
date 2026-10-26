Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792984865;
	b=Vm5TYBIt9JAdzgC1Oj2q+VAkYRaKfzTOeBsQyiqK96yh+/nbOR97ZhtmEH5lMjXPRF0Q
	 73aSx1NY87V0DiylvicCcJ88FUAk2DKcLhEeqdfn21YHNRT54upEjHOTKWombYWmRrDRT
	 GO2QG7oloS1s/CDvDb3iDedjSFXfo9aKA3rbeO6ipFnf14OUkoXKrn06GQIb0ZXYHhhLQ
	 5JlRFkeRUnbaUnFzoMNY9xwyDplS7Q5egOcM56K/b5HNd4qQ0Krn/ROaZAKdVHEeii04u
	 239xt/4TOV23ZnOLFeKD3j2O5tPpBtPrWw5FllRymbyTAGyHPTFcSut0seqIB9LOfbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=c2bNxHpBVFwjQWzLjD3Pm497bjuMklPnp7NsPwkLJwg=;
	b=BXrH+CHpSKFPptkULWc7RjYd2M8dngrJVS0erDlip9ygIIMXeGJ2iXmKas17eAEybz4y
	 d33zp1wCBqDmyxJd4smtBezLbI7k/cXSOMmvJC+rGsmNrbVvwXsBOCNk75jNN73LIKlDE
	 O6XIUZ16Ck9bW4XLbpJEbKYbdezWJXLAqJIhDa7KIDvqPrGVdOrpJ4C5gpk0griTD9MZP
	 I6CbuN9fIdaFQafYkkuFOlbRL4VMmeDGcjf9r43VNbMF8F9lSr2XeosKLKwFnNwMZkkdA
	 A2BP1TdUCuBHQydoBmNla0Hb5JPBzohhKCQhZpY1O5Y/1i9v19GtxOi43ve02AmwCRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qY7475o+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
Received: from mail-lr2-f5.google.com (mail-lr2-f5.google.com [74.125.230.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887F606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B887F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qY7475o+
Received: by mail-lr2-f5.google.com with SMTP id 38308e7fff4ca-3ab2a40750fso15811411fa.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 20:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792984863; cv=none;
        d=google.com; s=arc-20260327;
        b=cyL0KSoHHOtQJvDGCJRB8SwU7sgH5O+i18tquExnQXJCFWpRHyq2vC3xuI0pk65DhD
         NHe+QYlevuK45asCSUghQSj0hfd0nP0tFIEsHiySLzgqLl5BDPgfBpQdzBt0ENlLD2f9
         FkOGz+Yl/wFUcSaAmPtiFCz3dkD2wqpbq6ciPT+pPEojVR7m1J1d20CIvCG0TarnkHHC
         weT3GzSEOgRiG6C++wQLYlvbU+OW1CThTbQ4cQzCUb5OF6FWBvBLvbO+5g/K1jCQ+dyf
         tPq/KMrMTJy5z4gBL1C1IQdOyfjiaDIqUwpSZH/ihZInyPDwZditB1r1SD7nQ+2mYHn7
         368w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2bNxHpBVFwjQWzLjD3Pm497bjuMklPnp7NsPwkLJwg=;
        fh=mTrgyLhUK2Pir48xD9hZ4laUOIwH7Uag1rt9kVJMLGQ=;
        b=kJQ9ft29aKFa5N43obwmS7DkiqnpdqYB4Dd6j49MOa+Rh5GoZpRdi+GxqW8V85q8v0
         O7wPjOYXshIdq2iTotl8UwqPJY+nmohQnNmYD7NHN1r7BDy/9f6MfRkFVeMoXUCkE0EE
         4WSsDWK7FL9+J94ldvchDXgpEAo5XK4Nb8dKXtzNoMV7U0ky3JZeIo53WVgSg2ITK3Fw
         XqbibBwTlaYndSRyCzOA19/yPWaraeouwQ5Qm+55Zbiu+aydAcTpdBIewVfdhzd94vM8
         quMm2vLOAg+9Z4ZgvUjKtzpjh0xkWhSJxkvX1NJZmqjimhRJlX7U+9I839RPP5QSBvAX
         CnBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984863; x=1793589663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2bNxHpBVFwjQWzLjD3Pm497bjuMklPnp7NsPwkLJwg=;
        b=qY7475o+AgJu8W6LB8j38bWm/8OZjg2PwUfoqiF/Ul8AKyWFGKzdhBtEpgciOxFtZl
         O6ts8GnGeDdaNEmUj5xRW7lb6pXnu7MCd+SnW991XxAcJiy5QV7cZjef/tj2JHvuysxg
         NPJBKIkdJmG53FvoILyxBH1A/WScIoKojTSMfSxAsE9ra8Vln+lzSorMgNwdgXRdMNBH
         nUFl1o9jZmCi6XUcTI0y6oXT6zsw5+4ObDnCzrGozcNtpXsJlOTWhbvK6plpj88sK4TR
         eC343sSwCCCmS3hVWcGpRFNwLur+Wrh31eiEs3LQwdNSnga48k8CXoLYHfSV9T9DU9pl
         KYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984863; x=1793589663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2bNxHpBVFwjQWzLjD3Pm497bjuMklPnp7NsPwkLJwg=;
        b=1nd/Q/lY0bt2I7nV2jSyoaBHjIL7ViZFCcXq3EfqmjxKZMWZ1EskigZcbrLsJDk4Zy
         OWsQOfXExr7GjJnT0Nrw0C0j+cqX4bSHe3xgv6Q+osolYNnmkbcn66eOblW3iOe/pzoG
         hte8U+XWxlM7ODZphUvrUmhiO16JFfOWKlEfzoeY74vHpOsJ5v3A7TASlNjBYpEEjdDJ
         S8D8qUiwcGnncv4cu8HMWUQYgw5zcSiG+LwFDofO++jichdghn472CUQeGP52VhfXqfj
         pBJa6sA+IPWt3hTcaMv4Nov0dBrDg7vnRgre8qL/0d3AbmAcbP/MtApvucc64CVhE7l5
         +l+g==
X-Forwarded-Encrypted: i=1; AKwUvBwVyTnRF9ApTiXbGsBpB8F7H5LxEWJ7rA0kcoM1ATkoQYhmZyrJaM4KEINmJo3jlE6fGgyxyak=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNfCofnPtVQm9NwBJJ2aYVTxdM7E2ofpUVt7E3y0ATAHNqS4Jf
	nw1gbyv5+J+LuZgKvfyBpxnA47R87nT49ZTyOuw8ALU6KaLA0EcdQA4o5cKAGlen6rEfYwoqlxH
	9SWWvtaP5gs5zEsq54eCKpG4+hqZOzmw=
X-Gm-Gg: AYBFou0hb21oeX77BS8W07bIJIibdQxUUnv+tfFrNLEJOvX932hPeS0D2JHjGJXiXx+
	c7OD5bqXlF3RDU+fxRCROXRx6EMFBFn8qlf6jMoD4k6NNhocNyoNgp6APelZxftA96WTKEzth+A
	qR8SbQ6wbMz4X+PncPH8k1oYxiFs7v7WqszlkX/WeqoEiRZgttMpIzKfx+HulFQO/HZpe6ppNWt
	2T2zdbKuJcmfxfzVPR6zAmV1LDjzqMhugVyyezf1k5YGzQUllbtwOApDhrJgha2yuj5TX/VutgD
	L/DQpIFNOIosG/hwgjzRyzhf3NyGrueT6b1jJzld8QXsVWSns5K6u+gXLXzJ6CiP8u2ytHhdSLc
	pnhP5wPKUdG1wclxi+RXiv32fsyEF/KI5KzGnP/Q=
X-Received: by 2002:a2e:be84:0:b0:3a6:772c:2757 with SMTP id
 38308e7fff4ca-3ac6fcf0290mr12214031fa.12.1792984862553; Sun, 25 Oct 2026
 20:21:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020032119.1334986-1-bsdhenrymartin@gmail.com> <20261023151506.4f5e5b15@kernel.org>
In-Reply-To: <20261023151506.4f5e5b15@kernel.org>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Mon, 26 Oct 2026 11:20:50 +0800
X-Gm-Features: AclHuK_A69ahCShImUhR_EA8i09FMtRchCro8gY1e9OSOiiFRSkbQH70QAM732Q
Message-ID: <CAEnQdOp+K84BhZ_x8OC=vqZNG_CLes1PCbn0Wqm7VF5u_k9AOw@mail.gmail.com>
Subject: Re: [PATCH net v3] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Kees Cook <kees@kernel.org>, 
	Ilya Maximets <i.maximets@ovn.org>, Breno Leitao <leitao@debian.org>, Jeff Layton <jlayton@kernel.org>, 
	Kexin Sun <kexinsun@smail.nju.edu.cn>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed, that's the better place.

Thanks,
Henry

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8824=E6=97=
=A5=E5=91=A8=E5=85=AD 06:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 20 Oct 2026 11:21:19 +0800 Henry Martin wrote:
> > netlink_realloc_groups() sizes nlk->groups to the number of groups
> > that exist at bind/ADD_MEMBERSHIP time.  When more multicast groups
> > are registered later (e.g. a new genl family), existing sockets keep
> > their smaller bitmap.
> >
> > When clearing a multicast group of a departing family,
> > __netlink_clear_multicast_users() runs netlink_update_socket_mc() on
> > each socket on mc_list, which does test_bit()/__assign_bit() on
> > group - 1 with no regard to nlk->ngroups.  Skip groups that lie
> > beyond the socket's bitmap: such a socket could never have joined
> > them.  This is the same guard do_one_broadcast() already applies.
> >
> > The overflow windows differ per architecture, both needing privileged
> > module (un)loading.  On 32-bit kernels the ~54 dynamically allocated
> > genl groups already exceed the initial 32-bit bitmap, so the table
> > can grow there directly.  On 64-bit kernels the same in-tree set
> > fits the initial 64-bit bitmap only while allocation stays
> > contiguous: genl_allocate_reserve_groups() takes the first free
> > contiguous range and unregister does not compact, so an
> > unload/reload sequence can fragment the ~59 free IDs until no
> > fitting range remains, forcing the table past 64 bits and reaching
> > the same stale-bitmap overflow on the next family teardown.
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> >
> > Fixes: 84659eb529b3 ("[NETLIKN]: Allow removing multicast groups.")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >
> > v3: Correct the reachability again (sashiko review): 64-bit is also
> >     reachable - group IDs are allocated in contiguous ranges without
> >     compaction, so fragmentation from an unload/reload sequence can
> >     force the table past the initial 64-bit bitmap too.
> >
> > v2: Correct the Fixes tag (the clear path was added by 84659eb529b3,
> >     not by the dynamic bitmap commit), drop Cc: stable and describe
> >     the actual reachability (32-bit kernels with in-tree families)
> >     instead of implying generic heap corruption.
> >
> >  net/netlink/af_netlink.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index 9fdf964224ab4..8cc655aa927f1 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -1657,6 +1657,12 @@ static void netlink_update_socket_mc(struct netl=
ink_sock *nlk,
> >  {
> >       int old, new =3D !!is_new, subscriptions;
> >
> > +     /* A socket whose bitmap predates this group can never be a membe=
r;
> > +      * don't touch bits beyond its allocation.
> > +      */
> > +     if (group - 1 >=3D nlk->ngroups)
> > +             return;
> > +
> >       old =3D test_bit(group - 1, nlk->groups);
> >       subscriptions =3D nlk->subscriptions - old + new;
> >       __assign_bit(group - 1, nlk->groups, new);
>
> Dunno :/ I would prefer the following fix, otherwise it looks like we
> may silently ignore a netlink_update_socket_mc(..., 1)
>
> @@ -2163,8 +2157,12 @@ void __netlink_clear_multicast_users(struct sock *=
ksk, unsigned int group)
>         struct netlink_table *tbl =3D &nl_table[ksk->sk_protocol];
>         struct hlist_node *tmp;
>
> -       sk_for_each_bound_safe(sk, tmp, &tbl->mc_list)
> +       sk_for_each_bound_safe(sk, tmp, &tbl->mc_list) {
> +               /* bitmap predates the group, can't be a member */
> +               if (group - 1 >=3D nlk_sk(sk)->ngroups)
> +                       continue;
>                 netlink_update_socket_mc(nlk_sk(sk), group, 0);
> +       }
>  }
> --
> pw-bot: cr
