Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951136B93B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886007; cv=pass; b=qWRAP+1S/URCH92cY4qR/RUk5QW1jb7MKgOexVTbe/ZylJ2BvXG/BKIfTqmFJh5mKINXYkA4Mzp+HGVZ3eyV/p71n6YOvn5UNNnSjC8mViILzBrWJNaUZ4PRBOFyrkO5/eQsKOED9Fv4cXyEHGJjdS2gydfKkNGHeS5Bplwyc6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886007; c=relaxed/simple;
	bh=CYO0e876YQQP+3+Kb0juD0dpf5O8hM2c/xFtgaUsfYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ypgg0Q0WmDV6q5NAO/vS6bU3PSIkEuNv8Q/xvGUJ3POQz/BXSw632P3IuYOvcmY9XHk37416/dWH80UznjmcinYro51bbeZh8BtSFsr8CH3zlQLWqQROe+fHL5CkcoQNR6BxdVo0lFpHGr/KOzr1YVNsqoNUJEEgpr0b6ynsvNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PEW8Bt1Y; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PEW8Bt1Y"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc147d86bebso3944326a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 09:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886005; cv=none;
        d=google.com; s=arc-20260327;
        b=E63P6Q/pu2mg2OT6mf3QiRkgj3IPJxOrnAkmZgaa6g/UasGvaFNFHi82kfrCDBeGAC
         Wx4tAZspYm6CWAR9/LV2DpZohOIxhH+Mat5Ers0c5G40cr1WrlIlhvDb5VXaIRDMjnpw
         TdEVBda1TuRsMAooD+R9Si818r6GWUtmJ+IalIje7xa9S8MNW5dTGrWbAlaexKruU81v
         JjxbRf1ZkR4FhVh/d/pSQoRVkAI14bYpN0lwtWcGqXmHjvohlmlI7e8xqfQ1rTjfmI4m
         Snv0t7Gyl9V3AojDlAW4JakJSAZcb4Q0TUur1P0+bWI7yOhe8erJV/h2gSNihKEOijMH
         USaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oyJ/m8tG1ulzhQiaRek2q+ra3Crt3sAr7Hc6B+JxQtc=;
        fh=LRhla3A66Z1LArKJN1khvrODNJbdPhtEhKMNCbENjBo=;
        b=n4EVh+CnKK3wwO7Sh+8xpWMdAZXnQCwAX6z4UAdTra+0NjQKwjE+/3Xtl9HigaFtaF
         DMFCoOD5oMBpNifLtyDksSM7DqmZYjD1MWHuW6/zuNwTk8MS1pPD9qCMLXgWgc/RP2MG
         Iw5DIgsiIBWt7vDMRWdN3c9p+USXh8l0rTSboQMRpoXYus1Q3rPpG/NJdVtO0TOaGmI5
         b3stsMIW0zSEMxaNHd5HrB919ISmswl5rGO+KYOOPxYUJISFqPw+mrRd2FkgtiLDxn5D
         yhPEgZjJqZqgCnjRJjgjgZ7O703N8pxwHRgHBZrnHO8h1dFOPPHgsfCXbOvwM7FFwYpV
         5rIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788886005; x=1789490805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oyJ/m8tG1ulzhQiaRek2q+ra3Crt3sAr7Hc6B+JxQtc=;
        b=PEW8Bt1YydtwuO+8BM99+DEaiJMf8ui/oasFCbPppwObWeXE9+1xm3eahr0PMNIC5m
         mAGJsLpQciSUbZ0310G1y77wY4PSzIRLcx5MEzylZJ+gx1szgDMUgdJMzf1MBP+KiEvM
         C7CSOs+8hRG4LhE3SFFiCEJ//MQVA9BbWFAlLNOmV3k1rq0Dj/3t7/j7NBPm+4xHVn5d
         QXDxj8i9Oivu1s0Ny3xVOZ5wcEJWQgXE7cZknwQMogVbAcDA9aVnETyLXuSK12Z3vqTp
         umts4e7nXBppelieLIuppg5nbs3tb6Ycp3rUTlqpwo6NqyVUd45xQSBJc1JYSGZsHVuc
         GxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886005; x=1789490805;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oyJ/m8tG1ulzhQiaRek2q+ra3Crt3sAr7Hc6B+JxQtc=;
        b=XOgeGBS0/GZ+h5y6ucnROwso/k+7y+Nhkz5SJ4lopfYLfj65N4Xwq2tjMeRUhD1lok
         52ruO4uAy+Veyso66M+jjxEsUPz7fK2t97Unr0lMkovygYYVrZQzHtBMNlN+fSjfa4j/
         J/vDnpDp5Bec0Uo9veifI3SoN/t3H8JHek0mAjy7SGDT1Yj+jP7zCjIjtzKg5u4L9NOV
         0NNa/uM1KsjPkDhd55n8f5x6LC0C8eQ0v2klAWy3/NGuj9vWY3l5+FtjED4mxPrQGiLc
         9ummIkBdYBHra8EfE6HTQAxthcrLHsNJ6Uw2IXz+3/T0HHdvcTUpCJEx3t2LgDqICevz
         7qlA==
X-Forwarded-Encrypted: i=1; AKwUvBxoogVZAIeIOO0qVwoRQyI+DFJcJgclhpWs4ktLD11uRyfGVdd3jj52IJcgvXLenzBrQrrCgYA=@vger.kernel.org
X-Gm-Message-State: AFuF++nF5sKHOrBXPu2IK5S2efw93zVWYV1Kp9gkcPSvVKHuaxI+jmhM
	rtBy6dKrgehCmj1L7wTK4ajupVIkx0jvzyqvQNzIvKavTKIFKRC7yvBfJnP/Jl9sPdRWzEbas/Y
	4O5HhbLgOqH+tdxZb+lWvhYu6FCVmk8cUPl5AlKIA
X-Gm-Gg: AYBFou15DqinpqKJfs5OqXd/TViCmJpFAgq5L7tv/i4NnD1+zmWPuZjPHp64vpnOkye
	reBIkfa1tW8bTBjpqxmmtAhinRvXF8fGh95aBLPXY9VhkjPGIvEJpboZOf/50ww0CRxIzP/BJU4
	KZTz7KhImDuoL5xb5kgZJ16x4YxG7R7sUkhb7t2d0pdaLoGKkjG32J7vL2nxN5Ua7kEcJuPmhPl
	meDTbl6OzuFrMpVTGcq4nNjNa/h3CGKUXdZpljoiO8sGgF5SFTiK3E4DGhWG5cHsDd5JiQexl0u
	b5H4aLh6xWSoSOO0pxLmZlrtssn6GqMRuhnB1eO4K8SSHtVjo9NEC4RQlbDbn3Rm4OeENmCVz6K
	erT2h0utZh/hSWkH5Sw6wjLbFoCXbmjs5r0CxBy3jLbvU4SAqvKwpRDM2NMt65FC0PLVniRuOQn
	0u5nEmGys6wmVUEQ==
X-Received: by 2002:a17:90b:5242:b0:381:10a3:8b10 with SMTP id
 98e67ed59e1d1-39b08046aaamr40312197a91.14.1788886004363; Tue, 08 Sep 2026
 09:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907215853.3709987-1-kuniyu@google.com> <20260907215853.3709987-2-kuniyu@google.com>
 <20260908100522.GA903218@shredder>
In-Reply-To: <20260908100522.GA903218@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 8 Sep 2026 09:46:32 -0700
X-Gm-Features: AcwNN1UQwao5FL0ldpRGwCwvZ3lV-YVlHdwZ-6BKYPnsw36D-wwOs1b74D86Pl8
Message-ID: <CAAVpQUBOj9KAdqgafESVi+5sg8uAKcw26L2cfhQDs0FWUJZd7w@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/4] neighbour: Add missing RCU annotation for neightbl_dump_info().
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 3:05=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Mon, Sep 07, 2026 at 09:57:52PM +0000, Kuniyuki Iwashima wrote:
> > neightbl_dump_info() fetches the first non-default neigh_parms
> > with list_next_entry(&tbl->parms, ...) and iterates through the
> > list with list_for_each_entry_from_rcu().
> >
> > However, list_next_entry() does not use RCU helper.
> >
> > Let's fetch the default parms with list_first_entry() and
> > use list_for_each_entry_continue_rcu() for iteration.
> >
> > Note that the first entry is always tbl->parms, which never goes
> > away, so list_first_entry(&tbl->parms_list, ...) is safe.
> >
> > Fixes: 4ae34be50064 ("neighbour: Convert RTM_GETNEIGHTBL to RCU.")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/core/neighbour.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 1349c0eedb64..4b17c2a15594 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -2611,8 +2611,9 @@ static int neightbl_dump_info(struct sk_buff *skb=
, struct netlink_callback *cb)
> >                       break;
> >
> >               nidx =3D 0;
> > -             p =3D list_next_entry(&tbl->parms, list);
> > -             list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
> > +
> > +             p =3D list_first_entry(&tbl->parms_list, struct neigh_par=
ms, list);
> > +             list_for_each_entry_continue_rcu(p, &tbl->parms_list, lis=
t) {
> >                       if (!net_eq(neigh_parms_net(p), net))
> >                               continue;
>
> I find this more readable:

It's cleaner indeed.  Will change in v2.

Thanks !

>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 1349c0eedb64..3af539f5fd4b 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2611,11 +2611,13 @@ static int neightbl_dump_info(struct sk_buff *skb=
, struct netlink_callback *cb)
>                         break;
>
>                 nidx =3D 0;
> -               p =3D list_next_entry(&tbl->parms, list);
> -               list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
> +               list_for_each_entry_rcu(p, &tbl->parms_list, list) {
>                         if (!net_eq(neigh_parms_net(p), net))
>                                 continue;
>
> +                       if (!p->dev)
> +                               continue;
> +
>                         if (nidx < neigh_skip)
>                                 goto next;
>
> Then patch #3 becomes:
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 3af539f5fd4b..b4d8e5b6832c 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2615,7 +2615,7 @@ static int neightbl_dump_info(struct sk_buff *skb, =
struct netlink_callback *cb)
>                         if (!net_eq(neigh_parms_net(p), net))
>                                 continue;
>
> -                       if (!p->dev)
> +                       if (!p->dev || p->dev =3D=3D blackhole_netdev)
>                                 continue;
>
>                         if (nidx < neigh_skip)
