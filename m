Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6453CDBAB
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284122; cv=pass; b=dWzUHtZzqGA+6H1IQBQpdED/UT1lqy/MlFy+MgticpJmWR3isyhb1NiWIWYDZEfEbPK7RoK7VZ0rLiJEAfJk8RUbedZdcqhUeP8bvxHnMrdXQncpZtH/bcMOcsobGBURsbjPzNhzbmgdr22VyHwr266PfOcR5i4q+w0QCUjo8qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284122; c=relaxed/simple;
	bh=VvX00p+OmbwasydX/2eEM6YjZ2BQs2QTjd6bF37qy2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUBjkfHuyzAboDgzeXpuYzxm2TzXYURgCAHJKt1JhwDlYh7nH/VKFSJ0sgtASGUMqoYRQbY3lsSutQ7ldVSjCaAHUd2+T52YwsOgfG/O5cHj2Tz3GncP7KOxpmEHaUwbSVivjpEgcpIp6z9lS/YE1QkRfcKh30qeAIqlfYRF/Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StY3Y6OD; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StY3Y6OD"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1676648c1eso27927766b.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 03:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784284119; cv=none;
        d=google.com; s=arc-20260327;
        b=ONZM5jfzajk1ebRBqtHQR65dR2MHMMAz09kltDo0AyervKKhQixMg5tgB53tMBhhlW
         3fs6taltYk8EKOnNYmaJ/4lcKLGuISLNhsAUhGIQhxFWgldVzjNTXBI+F+GelZnzEiOq
         aOGq/vt+J5tXYQAlwaWx6e22/7ucT2SotRTbPTvooV0ppB/VWNG5JES8tDLw/IXvE4dN
         levdouo8Xl+iHQ6sy6uJJYgQRVIb5BxFNenMkWJZItuSKr9Xpv4AlQHhGS+ka2QxSpiJ
         PGC6JBjFm9gU2a3d1aI4318QytLQ4x8BYah1wIIF/PUtVWqjOMWaJhSfEDLNhn4rzFg3
         zCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0vEbvOqi/OZOD/2MtkSp/KoqLMYWo9EDBG0tK1AnTUs=;
        fh=MhzmHF+05TQ3DvoScPn02/uTgxU6Rg62DLgLgqxCb3Y=;
        b=MaPcSys076FNdQGhYWLpurAWhoKjpS+noTlWIxuATc5aPJRAZvbECRjWQxkrA4+Jqe
         nes/Np/6lqH+7ClN86pxmG11gshM5lTj9+CbBKJ1l3Qd1S9isDi8Ru7jzpQrMnXg0itH
         Toq03TjfCaq1delnXD/K2LXbA8yNsWK7TBfuz/6RTrTaN0KHZSmSF0jYzJXQmv0OZHyC
         MbV3DTM0M8tlOKxxHVrZT+loEBKIskh5SOIes6GTCYGg/Su7ad2mswVNsKwY//yC0tuu
         L54PFVFx2NmBSZluc9mOF0P0zRhtGwrTNIdwxaO3PwCB1XSEE416h2rlV7t8FiS2kObg
         5Opw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784284119; x=1784888919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0vEbvOqi/OZOD/2MtkSp/KoqLMYWo9EDBG0tK1AnTUs=;
        b=StY3Y6ODMHBnjN49DnErcTgWPrG66Yz6YZvFMdO1LT6bDBXG4euVEYhS7xjx9s0QRb
         trtB8IenZG1RSNRJgV273zqBQU8vH55aIecE/gMhybl+gn1kwrn+ABE9KEibS9p+Tq23
         ehpKTnxwG0l0bpFYD6blz4kwBFoK5fVTnDPvACZ0gQ0SSX4L16Kv08pSyq0QqOVun3gC
         Xyny1BnFTT/9fVfzR9jdEOSAG4JtXM54Czk1sQNpEiI/y5sBNtuXk6vr1iSrfWMOe4Hk
         gM8k7disy/h4P6G7atf84jhOIZ1ZOvoKTcu5H0FMmUuU2KW69I8xghQwsglmYZqZd/Y5
         jnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784284119; x=1784888919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0vEbvOqi/OZOD/2MtkSp/KoqLMYWo9EDBG0tK1AnTUs=;
        b=EYL0AMkCdyp8Afxy8Ef0kz06HB8dp2Mpr9XJqvgD38pCyS5iPopWs0PTpjDTguMCC1
         mTkVFsPrVC6zaaQPt9pfQp4WRsl1vwWXwVP9MOInkkh6FocqeP8UifG9LHijJosl0YPf
         3/A1AJGJAwTXCwz9wn3yCaBhqbuwrYkSdECEYxzNhWvFl9XFuQqJZmSip6vD65meNLK3
         We0UB1VvxkCstHY8CFae46oGDkUQ3XnMZZHl3vB6LzRVOICs2pj9GJ++PNcGJQVzNTMo
         pCu1n6KB8MejfuhkfpyaTTCH35plawJKKVqN9ZGh/xENgGx7l2b4CMYzNKDd3GfHAANC
         pQbw==
X-Gm-Message-State: AOJu0Yzsl+I76M/cQiOxs0XJstOb4LhKNNCI0N3yFbP9+pWdNu1vbTZ0
	DDc4cTcwY8rzBAsnqIcPelul5sYCvZ87qBdM/Z9nbtF+nFMuZUWUVckm20Do6T4PdWC/wFM6yJx
	NFOU97BXBHtHXOOwW3d1Q3K1tQJmwtlE=
X-Gm-Gg: AfdE7ck+n4/opNXkI7N/o49Dbi4FjeqMtr/l8TPtdgDKnM9uFLNiDEWYSY7JNAmRwOl
	dF+SZuF4YtpfsRWLrIchkYCV6LwnNQEcD1c2sP5C+EbbOu4UgbKz8lywcGJypc8qfeUjRTleYP9
	4YHl79Vxch06tQlsAXt2VFaPMbgKC+wlrfXr6Flg9KFZQmtUzK0qKxSrIrpbTQIyGT4cNPTmOvD
	CI02gLWSZLfR71asYKXgOee6fQlHW92DeiFuoRlvgVRU0U6ZCc7Flv/4yfn
X-Received: by 2002:a17:906:c147:b0:beb:967f:1ca8 with SMTP id
 a640c23a62f3a-c16b46e2accmr49800666b.2.1784284118801; Fri, 17 Jul 2026
 03:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com>
 <CANn89iLizNO3MZ4jEfkMkLOhrJUzLW=xDocOHR_mUgb+5BycJw@mail.gmail.com>
 <CANn89iK8JzQ9cUf+81yCTqo+AXeJFiKZ1B4xBu34Njaih5+viw@mail.gmail.com>
 <CAOAwikBYp7AAxFAZgyLaOZEG6Eoomq3aqU9ViMS8nrO82PD2rw@mail.gmail.com>
 <CANn89iJ+M_r-c3iGK1o7_pLBTVF-s5_R-8MjL3=Q0Aj=1a4deQ@mail.gmail.com> <CANn89iLziS_XE8oz03VWU47NRzP-G8OexL=-C0mxcMMnOia=Rw@mail.gmail.com>
In-Reply-To: <CANn89iLziS_XE8oz03VWU47NRzP-G8OexL=-C0mxcMMnOia=Rw@mail.gmail.com>
From: Muhammad Ziad <muhzi100@gmail.com>
Date: Fri, 17 Jul 2026 12:28:37 +0200
X-Gm-Features: AUfX_mxW_2uLNsjasCzc3pE4H4vRhKfPI0AEbaaHjPHfGbC8-L5nwmqnDoLDVSQ
Message-ID: <CAOAwikCEwv=9gqpfqfSyQW9_1ZqP5cJKq4oKQaGeuYfPZrPJ6w@mail.gmail.com>
Subject: Re: ipv4: icmp: icmp_route_lookup() relookups pick wrong netdev with
 policy routing + strict rp_filter
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Seems ANYSRC flag is required for ip_route_output_key() to not fail
with an error:

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23e921d313b3..c2428fa21b07 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -548,10 +548,15 @@ static struct rtable *icmp_route_lookup(struct
net *net, struct flowi4 *fl4,
                if (IS_ERR(rt2))
                        err =3D PTR_ERR(rt2);
        } else {
-               struct flowi4 fl4_2 =3D {};
+               struct flowi4 fl4_2 =3D fl4_dec;
                unsigned long orefdst;

-               fl4_2.daddr =3D fl4_dec.saddr;
+               swap(fl4_2.daddr, fl4_2.saddr);
+               swap(fl4_2.fl4_sport, fl4_2.fl4_dport);
+
+               fl4_2.flowi4_oif =3D l3mdev_master_ifindex(route_lookup_dev=
);
+               fl4_2.flowi4_flags |=3D FLOWI_FLAG_ANYSRC;
+
                rt2 =3D ip_route_output_key(net, &fl4_2);
                if (IS_ERR(rt2)) {
                        err =3D PTR_ERR(rt2);


On Thu, Jul 16, 2026 at 2:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 16, 2026 at 1:22=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Jul 16, 2026 at 12:40=E2=80=AFPM Muhammad Ziad <muhzi100@gmail.=
com> wrote:
> > >
> > > Thank you for the fix, Eric. Applying the other selectors from skb_in
> > > makes sense to me, but I'm not sure if instead we should copy them
> > > from fl4_dec?
> > >
> > > The mark param e.g. is gated by IP4_REPLY_MARK() on fwmark_reflect,
> > > which could be different from skb_in->mark.
> > >
> >
> > Yes, sashiko had some remarks.
> >
> > I have been playing with:
> >
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index 23e921d313b36b00d8ae5e14846527220c9db32b..b0eb4f8ff9867499dc3a96c=
92a414440b2d3a115
> > 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -548,10 +548,12 @@ static struct rtable *icmp_route_lookup(struct
> > net *net, struct flowi4 *fl4,
> >                 if (IS_ERR(rt2))
> >                         err =3D PTR_ERR(rt2);
> >         } else {
> > -               struct flowi4 fl4_2 =3D {};
> > +               struct flowi4 fl4_2 =3D fl4_dec;
> >                 unsigned long orefdst;
> >
> >                 fl4_2.daddr =3D fl4_dec.saddr;
> > +               fl4_2.saddr =3D fl4_dec.daddr;
> > +               fl4_2.flowi4_oif =3D l3mdev_master_ifindex(route_lookup=
_dev);
> >                 rt2 =3D ip_route_output_key(net, &fl4_2);
> >                 if (IS_ERR(rt2)) {
> >                         err =3D PTR_ERR(rt2);
> >
> >
>
> Or even better:
>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 23e921d313b36b00d8ae5e14846527220c9db32b..aaaa0e347702c4412ff515a9d=
0589c79c69c62d1
> 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -548,10 +548,13 @@ static struct rtable *icmp_route_lookup(struct
> net *net, struct flowi4 *fl4,
>                 if (IS_ERR(rt2))
>                         err =3D PTR_ERR(rt2);
>         } else {
> -               struct flowi4 fl4_2 =3D {};
> +               struct flowi4 fl4_2 =3D fl4_dec;
>                 unsigned long orefdst;
>
> -               fl4_2.daddr =3D fl4_dec.saddr;
> +               swap(fl4_2.daddr, fl4_2.saddr);
> +               swap(fl4_2.fl4_sport, fl4_2.fl4_dport);
> +
> +               fl4_2.flowi4_oif =3D l3mdev_master_ifindex(route_lookup_d=
ev);
>                 rt2 =3D ip_route_output_key(net, &fl4_2);
>                 if (IS_ERR(rt2)) {
>                         err =3D PTR_ERR(rt2);
