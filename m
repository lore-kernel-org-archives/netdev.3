Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724F3E1D16
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404456; cv=pass; b=X/bpOW9qWb+kqQ8tQQhHanikP9yN+px+G4ym9a3FKljfI6MdLLpymqPEEvBBxY/QALNzdzdNdjhwqBpa66aMCjWSS+aTMbcqI3N+176e6AX4xbiMd/NRNlDK6e6ZUOr/1HMjC8eUzE97zbaoacIoHEn+E8C4U2UEarwnxyqveCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404456; c=relaxed/simple;
	bh=IW0Xt+hApMlOhGtjEXVRrlgdm4ocYEF7pne/nK/i6ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p95DnNzMlG7MscNxWSw9QVEJrqRTSAY/4AoBBd9iwSAUa10l5FXfFXF+W7NtjBlamYmym+CW2J58hjcgSbgvMzSXve8Mn9xBR+HaND4TLHxntIySlIfGEoikcCDiae/imlYn54XaTRd/o10MJIRlFw9p1mRcir+6SMHuRULwJCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qe2a51dj; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qe2a51dj"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91550fe1619so309025285a.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 05:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780404454; cv=none;
        d=google.com; s=arc-20240605;
        b=hS7ixLceQKpRzA/xyqRz9EMET5c6FLsBxydU8WmyuXjvX1+h4BJmb4jfi1tx6P0ARj
         2Kej8CXSxnEJ/uj25DYRQGQiJWE5qIdkNnyAO889OgxJEGIPPM92uh2AA9Prg5xd9aiQ
         L0AwCD4Ltvp/CZ7UudlQ2coC2rH3EgPx5O9J9SS0/1ku32KIA8ioL8BnUsS/x0zH95pl
         pubjP5XPK8QmoAkPjFhBFXpRWpNy8fJDWdfatYm66cragst1tHe+FV4SZ8RcHCW7YRu8
         bCfd9wpRvCAU97WG/sl0QKRdQX+d9W/7rtLmxfuWCxh1b5kRshhKRkY/wwN9hzw4M2Fr
         gZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hzeds21HbhisGzFrzxMWf9vAL+t1omM0n/LjfdVx0rU=;
        fh=IUqHDmZx4F3C47+oTyvd/OIuQ1/YVeUU4OkJP/cK6aU=;
        b=VTEdO2XXk5OFlrF0M5eseQJB0d9Y+aAPRtI1EIAY051ngjPoryJX7gRz+Q8YJZ55h2
         NmEE0wXM+ZaBgkXsX0Q6RsCxqZKU2lWb9O5RT/LFVoIuoOAx/V8EG2rq2k+I4249DN6B
         dadNnCCpFy6jCkyDnU2X8OSW42xNbsENdIMSNOeLN1FsIkimssHb8VGjYZ5MMOe0y6Yv
         tXA1Y5ceZlp12ID4zxVeFVIfZglEC2dYh40zyFyilSPUDtY40k1bzO/R9aml9UZ5FsWY
         3U2AAjZYb7pDfJoWNkli1f4zrnd8jLVvcIMu7mGHcvXlIm2cP+Gc/PTUhucfAAn1vnGw
         57pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780404454; x=1781009254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hzeds21HbhisGzFrzxMWf9vAL+t1omM0n/LjfdVx0rU=;
        b=Qe2a51djH51Pha1JjqumEODC7rg3zDJVaw9J5a9PtZgRKFgJFWWcaSxGfxSVOMhjSk
         o/61b78OPydmd4kKzyOJVkUR6PbpDFQSwLSfSnAlSsJGnjzn4zKi4fljTYZBxokymAQX
         qRnrc+GzMNgAvdmYLx9/cW+gAs7nkZN39sCA4zBOrZR5Fr8Qpq3NFLpY7KQajBt+WR5+
         A9+sZXIQw5sc6M4j1j34eCT7oJZ7KCESK06dT37rRxkqYnF+R05cGDiD9DOk35BW++wm
         S9RiZIsAt0MoIJikBOP3bjpcIpia0a0cQg8yrZ/4jnjNSiyW4AhejS5LV2Ua2TpxQfQS
         TO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780404454; x=1781009254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hzeds21HbhisGzFrzxMWf9vAL+t1omM0n/LjfdVx0rU=;
        b=Ia/ed3U3BviyT/afJ8c2mFaoTYt3D6z/dtBRmMRZ8HI6250OfNUheNoMlhxz2SKX9O
         2w+5dTjn+QiMpvJxzC+NFzAhllEDIA6sHLqxmQ7in4WBmXySbpa0He+nsA1u9PMs+FFB
         wFOIODqeB3XyQ+nKtUNZECXqdguZgWw6qUlJSUypB6YXUlAZAGA77XfuZIaHhnAeBfeQ
         tgXAEZSsHKepOcoZndYzLRVBRXfVYP88BQECdxeqWBotYMYhMPKTPZr/RMx4bPKTq2EQ
         X33Zr/Y5Nm2ZBYpchQsBqA9azAHM9lgWxWpZTfgPERjQ5/Gf4lZBn/hvD4oo7ZaCrigN
         NR8A==
X-Forwarded-Encrypted: i=1; AFNElJ8+HJc1mLf/cgMpU3ASgY9tPJqma7OQpFgslKUqJceC+SgLdKxikX5CnnVgwLIY/ZMlids4mUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu45qX1+YfzexQzyUYp5v0sp0aQql1s9R0VgYa16fSVnsgrMyx
	0qS/EbUy56JMQlDxnvdq1TVI4ItZ4irf27jBze5BbllaGJvaX6EsG2kmaleRwzwRp7pw/+5ucNZ
	LI8iSEqGR5DEbqKERHnIZmxEpEzHe4QoV01O6Cizg
X-Gm-Gg: Acq92OGm72PcYTM+kLrKUxwwbVWaeMgSXEvg2gXZRE66VkyemmpzjS5GzJkV8zQ5AkS
	wT1qGRB0VpS6cz+o1Og7z+NIQYXttl5jyqbIjeCfDvkptsGDHCBC2i0zRznbZV+SMmHie2Zb22V
	fYXUJzmtUfchHJOazpL78dqwX1u9KOhviaFATSUCT8vDU6HlchHL5gmg+SJGB6gcFprNndmBEFU
	jSrliUujPO4x52h7jutSsA3U9h97mcTQNC9ayUmdHyD7vXxP8/JvVupfzWym3dVt9UOLygjDjZZ
	t9UVqGXtMzCsSrPWTzsiIreqn6kQIV0uQVcIBrIyv9Vqj/JKbvwFTDFLlmcSfk0mOg/o+s75Ewq
	6IliIMx4iUNA6FI36KpgjCsDRr2zf
X-Received: by 2002:a05:620a:268f:b0:914:bfca:7d2e with SMTP id
 af79cd13be357-9153dcba047mr2432383885a.60.1780404453831; Tue, 02 Jun 2026
 05:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602091319.1753654-1-edumazet@google.com> <319850b8-1374-44db-93a6-1203853de498@linux.dev>
In-Reply-To: <319850b8-1374-44db-93a6-1203853de498@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jun 2026 05:47:21 -0700
X-Gm-Features: AVHnY4J4K6C_y-8XI2_UE5fPdMyio8-6GP1qp4oiE2l-bPPNWAU7f7HFzT5bcI0
Message-ID: <CANn89iJztMAfeK7K4T_fvCSYfnUQxYRyvK=d0oiMQwj19AMKig@mail.gmail.com>
Subject: Re: [PATCH net-next] rtnetlink: use dev_isalive() in rtnl_getlink()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 5:23=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> On 6/2/26 5:13 PM, Eric Dumazet wrote:
> > rtnl_getlink() uses an RCU lookup to get the netdevice pointer.
> >
> > When/If rtnl_lock() is used, we should check if the netdevice is not
> > being dismantled before potentially perform illegal actions.
> >
> > Move dev_isalive() out of net/core/net-sysfs.c and make it available
> > in include/linux/netdevice.h
> >
> > Return -ENODEV if rtnl_getlink() finds a device which is currently
> > being dismantled and RTNL is requested.
> >
> > Fixes: e896e5c0734b ("rtnetlink: do not acquire RTNL in rtnl_getlink() =
with RTEXT_FILTER_NAME_ONLY")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >   include/linux/netdevice.h | 6 ++++++
> >   net/core/net-sysfs.c      | 6 ------
> >   net/core/rtnetlink.c      | 5 +++++
> >   3 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 74507c006490f180d2fac6594f6dcf2c86d53919..bfc847bc47fd957b58174dc=
4d2b82e2e8b461405 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -5660,6 +5660,12 @@ static inline const char *netdev_name(const stru=
ct net_device *dev)
> >       return dev->name;
> >   }
> >
> > +/* Caller holds RTNL, netdev->lock or RCU */
> > +static inline bool dev_isalive(const struct net_device *dev)
> > +{
> > +     return READ_ONCE(dev->reg_state) <=3D NETREG_REGISTERED;
> > +}
> > +
> >   static inline const char *netdev_reg_state(const struct net_device *d=
ev)
> >   {
> >       u8 reg_state =3D READ_ONCE(dev->reg_state);
> > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > index 3318b5666e438fe5bab2bcfed2bb260c7b4d5a63..0e71c9ed41e81d85af33a43=
39f556a0c5d760243 100644
> > --- a/net/core/net-sysfs.c
> > +++ b/net/core/net-sysfs.c
> > @@ -37,12 +37,6 @@ static const char fmt_uint[] =3D "%u\n";
> >   static const char fmt_ulong[] =3D "%lu\n";
> >   static const char fmt_u64[] =3D "%llu\n";
> >
> > -/* Caller holds RTNL, netdev->lock or RCU */
> > -static inline int dev_isalive(const struct net_device *dev)
> > -{
> > -     return READ_ONCE(dev->reg_state) <=3D NETREG_REGISTERED;
> > -}
> > -
> >   /* There is a possible ABBA deadlock between rtnl_lock and kernfs_nod=
e->active,
> >    * when unregistering a net device and accessing associated sysfs fil=
es. The
> >    * potential deadlock is as follow:
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index 652dd008955a90691403de9a54d8693d64ea7799..9e90d02b73c2909409e12ad=
fcec3940b49dcbaa1 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -4265,6 +4265,10 @@ static int rtnl_getlink(struct sk_buff *skb, str=
uct nlmsghdr *nlh,
> >   retry:
> >       if (need_rtnl) {
> >               rtnl_lock();
> > +             if (!dev_isalive(dev)) {
> > +                     err =3D -ENODEV;
> > +                     goto unlock;
>
>
> This does fix the macvlan UAF, thanks.
>
> But 'nskb' is used uninitialized, so the kfree_skb(nskb) below frees an
> uninitialized pointer.
>
> +unlock:
>      if (need_rtnl)
>              rtnl_unlock();
>
>      if (err < 0) {
>              kfree_skb(nskb);   /* nskb is uninitialized when reached
> via goto unlock */
>              ...
>      }

Oh right, last minute refactoring change, I will send a V2,
