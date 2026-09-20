Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445542475CB
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789930877; cv=pass; b=OV0RSXfEHtZ9u2PaDCKmNK5K1Cg/mg2wTtx52A/GXxsi3FMnmzKC1qGxnhLXnQYkzFBqVww76Pnaif2NSUWLGmY05JMbjmJTQ2r1hDSs6sC/CistQW+zS1hQUceCPn3V/8WNVTcXXPGXAeMckCEVrEaQXZy925VfRzRB3lPYtxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789930877; c=relaxed/simple;
	bh=KgD01zSuJfjV2nWlaxTG2hqU3ee6N7ZLza/SMM/8LaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lG98eu+V0OLbIm6tH2xyMZLPhVrP7iacqXxE7HxJefy2FKN+J1qE+UG1OiiQ0Egl2ssTXOs5UxuGKcKrMdd+VMax7X5mMY/sB80OszeoOLPQUzkhr/KAH397WYSaB07XGkTKhReu/c6ntkpwZeFBID4zy28Mg6ZYc8S/wpTSbHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2ksZCtt; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2ksZCtt"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea50dc1so1324779a12.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789930875; cv=none;
        d=google.com; s=arc-20260327;
        b=sE5P71+xxH5k//cvcvjsmLzZScBzox5xj0p0mOQ26DhY9X5TCPNrXgMhV3gHGmZxJm
         cr45pkTzTFqguLcGIfDeKObnr0rCCVDSiU7KBc94UslkINPnfYudsKDO2fOaTgal/xTA
         gZgkCv1D3jN8AQVmtw/N1Fet4FggmUO1HZLFPgtmgmDdv1T2PyLOngDhuxfheA8NxcOl
         hGIH+n6AXAvOyJgCSt4rTmeK9aLhANM6LThheIRQUSwZgGoyiliDUB5+ecLoa1EuV4Vu
         dL00a+YpBxJw8j+bH0QRJmiCJl2CKNKme4r/adBe90K8SCsqx0HzxeBbHq2K7MC83g1G
         dR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PljSxhRUHDqh9TyuYqWQS4MOxr0jw55SKdU/tGm/gdY=;
        fh=G1gA/r58h8GAK3V4F4bNstLbrM138kVEbcELanyKujk=;
        b=jKR3gtY1FyLyo9EogyIjhYkZZzjdoJcACoEHYVgS6Btfimk1A3AYNhtweGVCMrvGMq
         05nHnIBJHFAx3LfIcZ2DvSR4zm+ucgWbBxJAo0fg66liTGvw/Wije5PmNEZKrd360uui
         2WQYowpjxTfXfeFGK13/+07rkwgmEflbgfpPfo4+/tSjkd41WBxLNAu9WUoRb1jxan08
         9m5E+XbPnpIV/HBBK3HF0fvpNqI4WdKvSQtEnCglXZY83NqJ4ulJqZcZy2lL0TV0nNUx
         y0DiEPY9JqJwb5TKMLPqG2hegXFEqF7XhtVpoqkMtD469AKd/e/vQPKeRDzuBsFkSuvY
         nEDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789930875; x=1790535675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PljSxhRUHDqh9TyuYqWQS4MOxr0jw55SKdU/tGm/gdY=;
        b=o2ksZCttbxy7bAQ31tH7+0TydbCF1hIe5jRrJrgXHhZdPDbk4N6LVl1QpY1dTNFzXP
         k9XGQZqxJelYgC4mgIOObxJ1CF75zgju0v2rxQL/QDLd1huyO6J5hpAJoePRKsQnfiif
         oQeBTWSHVNWRVfBeg3G2oKi/QDLSvF2AO/TrtWC/PTH/hLGt+ENa925T8H6L4Tz08u0e
         V1YBULEnXfeCm8xDkGT2k/E/eqKUIsC69uyNNPVYKaBsqksGeg4Zz47zu6clS0d62PvL
         /K8TY12LQvjNMSuUcMKkts6e62+0OEKqsWx33U6ofx0V/qgGRFMwAdk8wwTDWtVwLzNH
         LbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789930875; x=1790535675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PljSxhRUHDqh9TyuYqWQS4MOxr0jw55SKdU/tGm/gdY=;
        b=Ci6Q3fmds8IPzUlolGX+9bkqJ0136lSD8TmYt3zrII66FHG1g2NSf8LAFeE5oHHBMU
         rmEkRcgX3HD8/c2slmLTnawkDZhiPK3M3Zbn8l/uSpPXU6rfbOJzaLXI0QhjGVw//Koc
         sHAUlia/GPbSRUclHRdRsRTPRINKm8gCkEEQiqDwEdq/Wu6sT7ObHXb5aqT5jPcmUo4s
         /qPF1bd8zKHenLH+5ZlfF8fMUqdtXldIMby8QmfoDeyGOm5uZrySJobqXL9pSVpgJ4Zu
         IXVx0o1J7yp6yvmqtj2KUFyIEPyGS1ad+QIJq5CvOslb9i7a0ZFvawmgmYGXI5ZkHzV2
         CFOw==
X-Forwarded-Encrypted: i=1; AKwUvBwpPXsPdzprn3gvTzh8yxO8w3LX5PmQC2JYEZbwPqkRX5qH8X5nSmjFKTPJa9FjaJ6iVlHQScU=@vger.kernel.org
X-Gm-Message-State: AFuF++l/Y0UQvTkpDFNCCMs5J26/Cbd1nYQDEnQnX0xkV/xLxlU7s+SH
	lsUjDMCZtMZVTZPVS7ZfkKkbwrGgUWv6kpf0/UNgYAYGEcq5nszCWsiV2VOpaIL83/cZjX50sRX
	euD5j9DXtID3SogyAsCqeJdYL/PtX9UE1prNlBIFt/YTrt+7P8aIEVytI+PI0fQ==
X-Gm-Gg: AYBFou0OcgJFmVjMHbVk/IuMm8DIJgLRAYqKjE0GNggWUvUmuBDxMAakos1E8bGbMDU
	x43YuV3vsSPLPnh9TctKjsv/iVFaOg0bNloBJQibIhZuc6K0nKLGrXiVpKn9VbZDKxTtyxKc7My
	Q0uHV7VrQ3uaY1YcPouKESbpvk6dhWVvJmXvYTiMY2b4ABKsG1rJP5yJ7UcfCzVyWDSuso4P0d/
	YMrjgpw0wDmPHnVy5HADEwsvqp84v+OzRE+7Qfm65KRLAz72XrMK4CyelK1gScTpmzaMDpMHatt
	y6TtW8qaulO2yQhpus3IqCXOByt82caO/lo8OQSXknhin+Q9jolMEevIvN4eRy9k5yT5JmCykga
	ghWC6GPQiXpus33ru96vdRCghXA/ObNnTX1CSJ/b9oqvUChAbEXaF5evC6z4EYGuqpDab6EmGt9
	0Y87n8JH6SXx6/kDiTmDhxiVLS
X-Received: by 2002:a17:90a:da83:b0:39e:6c6a:4b68 with SMTP id
 98e67ed59e1d1-39e6c6a546fmr6946753a91.50.1789930874825; Sun, 20 Sep 2026
 12:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918041439.2575935-1-kuniyu@google.com> <20260920172628.GA2051643@shredder>
In-Reply-To: <20260920172628.GA2051643@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 20 Sep 2026 12:01:03 -0700
X-Gm-Features: AcwNN1WTcMD-MOIJb-23v6FLCA1cFpL8QTpcOYlS9WhmuxfwtlL2QAitV3UKKCY
Message-ID: <CAAVpQUCM+71RET3nxE5L6crU=dDL34XVMdXOgHihQ1pHZ-jdaA@mail.gmail.com>
Subject: Re: [PATCH v1 net] ipv6: Fix dst leak for uncached routes.
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Wei Wang <weiwan@google.com>, 
	Marc Harvey <marcharvey@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 10:26=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Fri, Sep 18, 2026 at 04:14:37AM +0000, Kuniyuki Iwashima wrote:
> > ip6_route_output_flags(), ip6_rt_put_flags(), and ip6_dst_check()
> > detect an uncached route by list_empty(&rt->dst.rt_uncached),
> > which replaced the static DST_NOCACHE flag check in commit
> > a4c2fd7f7891 ("net: remove DST_NOCACHE flag").
> >
> > When a device is unregistered, rt6_uncached_list_flush_dev()
> > unlinks uncached routes tied to the device from rt6_uncached_list.
> >
> > Previously, they were moved to another list with list_move()
> > (__list_del_entry() + list_add()), and since commit 98aa546af5e4
> > ("inet: remove (struct uncached_list)->quarantine"), the routes
> > are just unlinked with list_del_init().
> >
> > If list_del_init() runs concurrently, list_empty() evaluates to
> > true; ip6_route_output_flags() calls dst_hold_safe() incorrectly
> > and ip6_rt_put_flags() skips ip6_rt_put(), leaking dst, and thus
> > dev tied via rt->from as well.
> >
> > The same race is partially fixed by commit 9a6f0c4d5796 ("dst:
> > fix races in rt6_uncached_list_del() and rt_del_uncached_list()").
> >
> > Let's check rt6->dst.rt_uncached_list instead.
>
> Please add a comment that we now rely on this field being written once (n=
ever
> NULL-ed). Otherwise it's quite fragile. Something like:

Sure, will add it.

>
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 36e999b22d42..a6b21edbda29 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -139,6 +139,7 @@ void rt6_uncached_list_add(struct rt6_info *rt)
>  {
>         struct uncached_list *ul =3D raw_cpu_ptr(&rt6_uncached_list);
>
> +       /* Set once and never cleared: non-NULL marks an uncached route. =
*/
>         rt->dst.rt_uncached_list =3D ul;
>
>         spin_lock_bh(&ul->lock);
>
> >
> > Note that IPv4 does not have the same issue.
> >
> > Fixes: 7d9e5f422150 ("ipv6: convert major tx path to use RT6_LOOKUP_F_D=
ST_NOREF")
> > Fixes: d64a1f574a29 ("ipv6: honor RT6_LOOKUP_F_DST_NOREF in rule lookup=
 logic")
> > Fixes: a4c2fd7f7891 ("net: remove DST_NOCACHE flag")
>
> The commit message reads as if the problem is only visible since
> 98aa546af5e4 (v6.11), so why blame commits going back to v4.13?

Sorry, I guess I was confused like list_move() could clear
next temporarily.  98aa546af5e4 should be the correct one.


>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/ip6_route.h | 2 +-
> >  net/ipv6/route.c        | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> > index b9e8d2b759e9..2c5ded121f54 100644
> > --- a/include/net/ip6_route.h
> > +++ b/include/net/ip6_route.h
> > @@ -106,7 +106,7 @@ static inline struct dst_entry *ip6_route_output(st=
ruct net *net,
> >  static inline void ip6_rt_put_flags(struct rt6_info *rt, int flags)
> >  {
> >       if (!(flags & RT6_LOOKUP_F_DST_NOREF) ||
> > -         !list_empty(&rt->dst.rt_uncached))
> > +         rt->dst.rt_uncached_list)
> >               ip6_rt_put(rt);
> >  }
> >
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 08bd68f1b5bb..b18cd0d9148c 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -2722,7 +2722,7 @@ struct dst_entry *ip6_route_output_flags(struct n=
et *net,
> >       dst =3D ip6_route_output_flags_noref(net, sk, fl6, flags);
> >       rt6 =3D dst_rt6_info(dst);
> >       /* For dst cached in uncached_list, refcnt is already taken. */
> > -     if (list_empty(&rt6->dst.rt_uncached) && !dst_hold_safe(dst)) {
> > +     if (!rt6->dst.rt_uncached_list && !dst_hold_safe(dst)) {
> >               dst =3D &net->ipv6.ip6_null_entry->dst;
> >               dst_hold(dst);
> >       }
>
> Nit: The comments here and above ip6_rt_put_flags() are now stale given
> that we no longer check for membership in uncached_list. You can change
> to something like:

Will update the two places.

Thanks !


>
> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index 2c5ded121f54..0f9b7a260d25 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -101,7 +101,7 @@ static inline struct dst_entry *ip6_route_output(stru=
ct net *net,
>  }
>
>  /* Only conditionally release dst if flags indicates
> - * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
> + * !RT6_LOOKUP_F_DST_NOREF or dst is uncached.
>   */
>  static inline void ip6_rt_put_flags(struct rt6_info *rt, int flags)
>  {
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 36e999b22d42..515115abe2f0 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2721,7 +2721,7 @@ struct dst_entry *ip6_route_output_flags(struct net=
 *net,
>         rcu_read_lock();
>         dst =3D ip6_route_output_flags_noref(net, sk, fl6, flags);
>         rt6 =3D dst_rt6_info(dst);
> -       /* For dst cached in uncached_list, refcnt is already taken. */
> +       /* For an uncached dst, refcnt is already taken. */
>         if (!rt6->dst.rt_uncached_list && !dst_hold_safe(dst)) {
>                 dst =3D &net->ipv6.ip6_null_entry->dst;
>                 dst_hold(dst);
