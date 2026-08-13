Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CA31E85B
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601842; cv=pass; b=V3Du6KF0nHCezEiny5MCHye9eDQ6JK/i+zvIEvkayrlQswuNDQKlSDD7yviZewHpRKnykodks9N56QG3MODg0XqDb05Z9fbuL0eeXMo9SL1eOCPP2ILeDxs2lt97HPCCkvo4ylYuvXAYHkjORSJmzyZ+wTQfMFFFTcZuAtLQi5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601842; c=relaxed/simple;
	bh=CrCTv0dGIDD6zL2g6/3JW9pK1H8uJAm37KEpj0m+P+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ND5wVHhjkbtNcfOPd8YpzrSvDiVKUp6B9MCr3+2yDllppNMO3i5kEihbVbvL78i/Q79kRwk0khirMF6D/AIWHGJ+CjeLMBCGQ198K3KPC+lhPq+cOUs4KIeem8rzH2QwcW+N4ldyIk+stCOXc1D9HpphP2Plr4omBHLf7O1NE14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aWdKBSuD; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWdKBSuD"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cab973140bso6331135ad.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 23:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786601841; cv=none;
        d=google.com; s=arc-20260327;
        b=LD8paBw6xG1NOSImdUTVeIbob89ukPHkcuTzGgvAsWyl8TG3hJvqVMEqRZf+9V48gv
         nA2L52fjDj4cKQSdwCrxhdez4kekbEfJMHQnfZEyEraUppJaobKIi9FOWvSOWic4grG5
         s1A+H0VyYJz3HpE96Xjaw7CBSFOF4EACaAQbPcp7zS8gx7L4qJBODk+qgitGe5bb4y+K
         PqbV640C2z5V8ouGqSUwAeHuw/S/tBWziI2sSvlsw7Kps1LTn+wiXAY7xTq/90PlxNqs
         5Tah9NBHK5nb7rr5Le+RWT/qCWvElcXeDG9dhKDUgNFldu9ZEbejymzmtqu18e2cWqP8
         GvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ty4GS818ajmjq7oZICFT1h6LG0nyEUIaJwUwB2TBGqg=;
        fh=0h8I/5YbATyWFBxqW+GJflN2nTMZ89l5CjT1LN+RqQw=;
        b=pO0U9AegY86VEOkUgXc36PVPxh+kMq8bO3V/CqjsEXx9WvvacLrar5z3m2XTdVl1cE
         41jVZsgFp1FTwckUJ1fpp+AGHLpKPCjGwwVPO3+PrHrGn6wteDev9Psc06x9fUYtdX8K
         5HDF319zW+L4Hjh9wlILjqhrRL+eYKDwz5mUK4Jplf/FAju/reAG+Bh2/evdT5E9nmqH
         CAl6+ztz3ow6v9YOJHRhNntOPxHWmfGPFJBkQRzYf0XSAkwYm9hJlN8RmUPH+b2I+13c
         hEqXG7bKNt+VqO3NQFg+tvAAxK2qimAcDHgQQOJjrbP0WDNBpCF0pQO2ZENNcYtIfzGY
         0HAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786601841; x=1787206641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ty4GS818ajmjq7oZICFT1h6LG0nyEUIaJwUwB2TBGqg=;
        b=aWdKBSuDZVCatd+v7rK9ISS5V/uSsf7MC/8S4XqrzHtd0j7ZnrtWj+JPCCkycU4fPn
         cmu5u40grSd6kN/UZhe9g4V2BW/RdGJo9G6u8iXBxEcUN+ENPNDBxpYU8aOj/ywsnVIP
         sfBvSVWMU0IsgxjmbRKpV/4RClJlkvU6ynHewWzAcZzzfXFs6BH4o+/K+bg368+bOTk9
         kApcFh/1UDIs3ji/BwZb1+ugdZ8iJlZS7fWeWubWP9zqnTuPr+xqFlD9UVGm9d55HYcL
         0UzWlKkqWLVkjNhdEQrxqMIiG1Fa9Yk8BLihGqAMDf7l4Ie2lHurQsGGNOFHLpG1LJBg
         QRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786601841; x=1787206641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ty4GS818ajmjq7oZICFT1h6LG0nyEUIaJwUwB2TBGqg=;
        b=mAhHkvuw+x0e+CumLfBxb9+eG4c/SmITOidPIkRLUKFWLq0VYSmo1KWMpeX/qQtQKB
         dvmrRw9MZlqof3w1XU0XHv4NRZ6k/3LYkjMNf8tJnNA16342reltWmd1F09QnDpzTYGf
         z4ZZg33U9A7sS15ybWgnu6UnDXJ/mRjXi+rT5Hue+CbS2R3RU4B6jjs4NVNPo3yift5k
         k6JqgROKwmV8PIzsBZ441a0cLPFaULHrdESS4bUAWG9WCxd6p9p+xjih9TrgCS+J/Ei7
         5FMQzc6hQecXc0zVfaEprNV7KssgLCC8QNyrLTGVqOcVOC6HNJ6OWRx1Deo9o65JNDl0
         2ipQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro17NiRkeeVFac2PXnpyohgsMV2kaQPP3yDkBbUfLgckg5hGuGPxOqlP6JpTbTREJLeHaY2eIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq08R+ZpztB6kR16XQcFdUXdiMoieMfQXZwL/QqdPJjHsGa2Wo
	Zkv1RuN3eJ0CanCBAWQVLpnMM2NHUri733pGZqt0mzNxJ7fBRAD+mYHbe3K2jGEN4T2j5pMKa2F
	i6N9p+cQcZSEZ1Q6tJ3Kmk1rHTsWDEIvf3N1hafAa
X-Gm-Gg: AR+sD10dSUGPU3pKxvjH6AoxcdG25foEJ6+AXoRe9PIObciD0j8esl0+VpfNcGPhu7o
	00kTyBKXc82vPCj9YwcZRLmq3d1eW6c/BaXfEXZnlXeAvd/6E8AafCwPwBtLAUdOrBjDCEJi3u1
	K7V/Nc6ziXXnE3byLgR6RKEV2x0CfLB9C3K0ZXVq6lhnbJPujRXGvCztyEuE74RW7PyMeGTySIK
	EIq6rKFqHaFXYK7rPMYniJd6PB3zIp0kJn+c7hyq1VfXZtXT4syGYeC0CzD08zo9/hhIg06niV5
	GECyWqupyvxZkqOzrc2a8ZtrBsuvvigVoUiWu4NQSUBKeQwpFDeVdbQo9FOokYxlUWYRxJKrLCq
	WLlzmtB8ODYa5JeOt9QbNxlKLQXT/HtdC0CrVaKjvBMQQldIlekfEWqwP
X-Received: by 2002:a05:6a20:94c9:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3cc54f970fbmr4268114637.3.1786601840253; Wed, 12 Aug 2026
 23:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com> <20260811165453.GA3163487@shredder>
 <CAAVpQUCiW3pPVBCXJjtpqmfkiX496YiMwjpQxx3R8oqpupLvCg@mail.gmail.com> <20260812080328.GA3281318@shredder>
In-Reply-To: <20260812080328.GA3281318@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 12 Aug 2026 23:17:08 -0700
X-Gm-Features: AUfX_mz8qrWfXAwr5ZYV8hOMzBNCZROK5ru-pDZUiXiPi6kn7ubbSa12ijXY2ws
Message-ID: <CAAVpQUCRjG0Cs+wXZfzkV2EtGxRjS3N=9zOZ39efORMN8+MhCw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 00/15] neighbour: Namespacify arp_tbl and nd_tbl.
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 1:03=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Tue, Aug 11, 2026 at 11:39:36AM -0700, Kuniyuki Iwashima wrote:
> > On Tue, Aug 11, 2026 at 9:55=E2=80=AFAM Ido Schimmel <idosch@nvidia.com=
> wrote:
> > > Another thing worth a discussion is the policy regarding the initial
> > > values in each namespace. With this patchset, new namespaces all get =
the
> > > same default values instead of inheriting from the initial namespace:
> > >
> > > # sysctl net.ipv4.neigh.default.gc_thresh1
> > > net.ipv4.neigh.default.gc_thresh1 =3D 128
> > > # sysctl -wq net.ipv4.neigh.default.gc_thresh1=3D129
> > > # ip netns add ns1
> > > # ip netns exec ns1 sysctl net.ipv4.neigh.default.gc_thresh1
> > > net.ipv4.neigh.default.gc_thresh1 =3D 128
> > >
> > > Assuming that today people configure the initial namespace before
> > > creating namespaces, changing the policy to inherit from the initial
> > > namespace will probably result in fewer regression reports. There is =
a
> > > knob that controls this policy for other settings (see
> > > devconf_inherit_init_net).
> >
> > I considered adding a new knob like tcp_chlid_ehash_entries to
> > control the behaviour, but I was wondering if it might be rather
> > confusing to people in the future that only GC attributes are inherited=
.
> > But I don't have strong preference here.
>
> Why only GC attributes and not all the default parameters? IOW,
> everything under /proc/sys/net/ipv{4,6}/neigh/default/. Something like
> [1]. With it, I get:
>
> # sysctl net.ipv4.neigh.default.gc_thresh1
> net.ipv4.neigh.default.gc_thresh1 =3D 128
> # sysctl net.ipv4.neigh.default.base_reachable_time_ms
> net.ipv4.neigh.default.base_reachable_time_ms =3D 30000
> # sysctl -wq net.ipv4.neigh.default.gc_thresh1=3D129
> # sysctl -wq net.ipv4.neigh.default.base_reachable_time_ms=3D40000
> # ip netns add ns1
> # ip netns exec ns1 sysctl net.ipv4.neigh.default.gc_thresh1
> net.ipv4.neigh.default.gc_thresh1 =3D 129
> # ip netns exec ns1 sysctl net.ipv4.neigh.default.base_reachable_time_ms
> net.ipv4.neigh.default.base_reachable_time_ms =3D 40000
>
> I think that's closer to the existing behavior. We can add something
> like net.core.neigh_inherit_init_net to make the policy configurable:
>
> 0 - Use default values.
> 1 - Inherit from initial network namespace. Default.

Sounds good, I'll add sysctl and neigh_table_inherit() to patch 12.

Thanks !

>
> [1]
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 07c62268fc3b..0b55baecc55c 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1913,6 +1913,22 @@ static void neigh_table_clear(struct net *net, str=
uct neigh_table *tbl)
>         neigh_table_put(tbl);
>  }
>
> +static void neigh_table_inherit(struct net *net, struct neigh_table *tbl=
,
> +                               int index)
> +{
> +       const struct neigh_table *init_tbl =3D init_net.neigh_tables[inde=
x];
> +
> +       if (net_eq(net, &init_net))
> +               return;
> +
> +       tbl->gc_interval =3D READ_ONCE(init_tbl->gc_interval);
> +       tbl->gc_thresh1 =3D READ_ONCE(init_tbl->gc_thresh1);
> +       tbl->gc_thresh2 =3D READ_ONCE(init_tbl->gc_thresh2);
> +       tbl->gc_thresh3 =3D READ_ONCE(init_tbl->gc_thresh3);
> +
> +       memcpy(tbl->parms.data, init_tbl->parms.data, sizeof(tbl->parms.d=
ata));
> +}
> +
>  int neigh_table_register(struct net *net, struct neigh_table *tbl, int i=
ndex)
>  {
>         int err;
> @@ -1923,6 +1939,9 @@ int neigh_table_register(struct net *net, struct ne=
igh_table *tbl, int index)
>                 goto err;
>         }
>
> +       /* Must be called before neigh_table_init(). */
> +       neigh_table_inherit(net, tbl, index);
> +
>         err =3D neigh_table_init(net, tbl);
>         if (err)
>                 goto free_table;
