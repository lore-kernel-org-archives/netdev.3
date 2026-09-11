Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E44A484A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148481; cv=pass; b=PsdzZeRCyMNRxFzgtyzt0mBDlA2OABuyk6Kxth/F48ovDSXMppWU07onMdCd7TGuscfWI9NGjMf9rP4kWwtWbsDM0cRRUDzau6toXPwh9kLnw8opONP1oC3vRlAMZ7K25Ne5g+uqQC2Rqi2V5p6DqCKT7vsKoblfddWYn0xiRsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148481; c=relaxed/simple;
	bh=Wj0MkpD1EPhM67guoEQUvBqOjfyHtcCKH9qHWXfvqk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6nohRM+TcUBBMQEwShW+bgGT2LVwQJ7XHQ5aKlaETSNacrWr6TaSAnpGzjj29Jv/k5sE3aph2PCKRMD6r75usJwUKkFyzv/gOsfd1/MRXb9xaOGXkFsvYV/ai5IOS5s3PYdh69W7vzpIINnD+VJFq7hCvL3Pp287X9GWf0Unko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSxCBtOr; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSxCBtOr"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1185237a91.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789148467; cv=none;
        d=google.com; s=arc-20260327;
        b=kw8cq5H8vSg1MPAb9iBklCN9kbCRoab0QvFuXqoAExKzVcB/zLRbSGvy2s+KI6uXm4
         EOI5rbAjkHM1MxvmWmzaN0XCWT65U2P/14SeksL1hlNPH+FDtuPE41bs1UGIJ3L6/klR
         b/f012gU6vPEjxbB2/jN0b07/j+9Xemck0z3M9jzHGVDVMYuizX8s+quJLmXlXEkXHD2
         PSCMNVHfx29R1GoL6Y6xapGMdrPCfN4ZoHtClJg7xdZP38RXoFEoUWCFRLjdRVVQkFDO
         TcydeRnOmzOC3ANoOfLN8Rg5bQD+9y/Tz8wf6BlJXvZ087XOlaR4n6N2xul+5Z+FhjCD
         oQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JAfkPUxFmoNo4iWfo0h92vjVTWUP8BF6hcyoGxFUl80=;
        fh=JfvO4ob5++18qhZN0MGt5IftSW8gD5XstTvtlMnmnX0=;
        b=QPi3nVI55roXP8s2RpYvPHDQ6iPElefQnlC6t042g3TpJ4DibmGAiHzmSJYzNOR5Fn
         y78pq9/ELiSBGAaDNZOBXyj0Twsb0AdxlD7W4LyQXGNy2Ab0tolsmL6DluG0ttDnVxDs
         fM0s4o+q4B7IenARmAp2Led39R2FOjuWddDdvkyhY+f5bmBu/DUTZ9nPdlx3spD+v4Bz
         93aC1PZWV8XTO8kHzJ1Xikf99pvSED8BYPCnPI07SGk82OSQLnkyjLDRM803hOMmefKG
         1JxYWAPUQ7aSkcpLZb1RvU+VVDK02+f1yPYoKjg9WmcIhfTaLcno270oJSBYvXzbyMKM
         78Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789148467; x=1789753267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JAfkPUxFmoNo4iWfo0h92vjVTWUP8BF6hcyoGxFUl80=;
        b=PSxCBtOrPDHDjQxTEN9sJsgOYnKgh7a238gu2W17EtuU4V6s0YwayP/TlVC5Im8D7M
         GDGGA2pW5nri6UfzbDfFIhDtRqu0E+/Xh2B02/FE6HZ7vUdiTSwDkx0uyVgRlO0WV1pJ
         hP9Bi7dnvY4VrmfoRaTFTrWzXitUbr1fxu7VxA5jaZ+s7KH4nuEmF5TPUhCpuRlJ5VrE
         X0m1I7CfzIAhb8MHSCowBlB76dU3vFaazhGKr/lAtV7dc5yTauywrHuojeB8rag0dkZP
         q2tQeIgKprY/DcYlUXOsXSM2yRWCwn2x+oG/ZwlNGQT4I8U3JZRyLctvuOwvkvRIn+QX
         qqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148467; x=1789753267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAfkPUxFmoNo4iWfo0h92vjVTWUP8BF6hcyoGxFUl80=;
        b=gOTEN9m7SNzgw4QlCEdq/26OTiG/r9GJ252C+EPHb52+yZ/1dwmj0gVf1w+0nvwme3
         7k1ZzGlVlpGHpF643XzLOueA1o9QSDttaAFDgyyKmh07hYmtnBSel2mIOzEFkAsiK84K
         Ich2QztH5pdna3ON876BszRT1rZM1bMwm+A6+6m26yVobrdyvM7vxPHVbiKwVMojFFP4
         bmPZuQZ90eeDeSe9akNI/SQiizxrX1jWkKr8yCLYgqVOi94dX60zRmP6Ea+QlNyEQwmR
         dGzlejnm0eHl0pveE6ZFpmwohO9cTz0NC6dSFysE674bzY9X0jHgeaRMrqNlXEyn5z9g
         NFQA==
X-Forwarded-Encrypted: i=1; AKwUvByIKFVYur4K/z3SFyInArWhw4xgYAnFa4lVkl1kg1TsWUjIFvzHq1Czr965/DuqvgDD210Tsec=@vger.kernel.org
X-Gm-Message-State: AFuF++nCxfNUssNDTs10I/sOh0zTw7xjpbgcPIHHv0xExerfwBTKrLg/
	MPzOveiwxsyeYJZ3bcX4nC+Lcv7dPZLelXkzTyPt4rEeZccfU8zQqC8rvxPC1xojgLoIl1WAieE
	i7A1E/UsfvxYOMiCGunvNqk/rKXKGnUHALIg72ISp
X-Gm-Gg: AYBFou3z3gINZRwQ8tXuwUYYRWmktXx4YEpF7/yBBk4tGgmLaC7q8EMqf71hz3wXXSJ
	Lb/72BxBx7Gzs7Cw8lRIGxtd1rn3BT1lr1jW1VKHCmBWkyZCf6za4YaydJJD2XJOMs9UxK6R2Bv
	GAZaOV/cYnq4DK0UAua5gKUfbwCyrmNvuXeYxhCXndSLyOsF124a9n1b8UCTUhOvQmYC1yk+zLr
	0JHQH5la013P1BL5feXG/0cExoeD3RkCcW/C5i3DwKQCTpDc6MlX4QRu1+YHUTM3a2stx0qT4vO
	hybiAF1jYlJuMyPvJi4wlBND1Wbd2N1ksTUs738coyfjrsuhV295P3xEXG8ERElM6d+Jjak/9ge
	nTZ9CYMPIkE1Y7ndzhiPotopojcn//vqinTIJXmGKq2W3i52PiazxG57rqiZlWjqcuaHwdgKdDC
	VdPt55ydW338ub9wQSzuMJRQ==
X-Received: by 2002:a17:90a:d2cb:b0:38f:efed:5448 with SMTP id
 98e67ed59e1d1-39d9bd971fcmr8628531a91.8.1789148466118; Fri, 11 Sep 2026
 10:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909233143.2401847-3-kuniyu@google.com> <178908932373.219967.4672575432952615722@kernel.org>
In-Reply-To: <178908932373.219967.4672575432952615722@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 11 Sep 2026 10:40:53 -0700
X-Gm-Features: AcwNN1UlwZVfwXMDj-nODvW5GwqdhSUFEu5keN8euf3O18YYu37WvdM8QHgoLxU
Message-ID: <CAAVpQUBJpBnUTm6BS7-Y57ixYf8gM1MebSPK4_gwg09pAGb92Q@mail.gmail.com>
Subject: Re: [PATCH v3 net 2/4] neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, idosch@nvidia.com, horms@kernel.org, kuni1840@gmail.com, 
	netdev@vger.kernel.org, tgraf@suug.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 6:15=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> - [High] The sysctl half of this patch is inert in this tree:
>   `neigh_proc_dointvec_ms_jiffies_positive()`=E2=80=A6
>
> --
>
> neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
>
> The patch replaces the ineffective .min-only policy entry for
> NDTPA_INTERVAL_PROBE_TIME_MS with NLA_POLICY_FULL_RANGE(), bounding it to
> 1..86400000 ms, and adds the same max to the sysctl handler plus the
> netlink spec and ip-sysctl documentation.
>
> One question about the sysctl half of the change below.
>
> > diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/=
netlink/specs/rt-neigh.yaml
> > index 0f46ef3135905..c8e55c98d5649 100644
> > --- a/Documentation/netlink/specs/rt-neigh.yaml
> > +++ b/Documentation/netlink/specs/rt-neigh.yaml
> > @@ -341,6 +341,9 @@ attribute-sets:
> >        -
> >          name: interval-probe-time-ms
> >          type: u64
> > +        checks:
> > +          min: 1
> > +          max: 86400000
> >
> >  operations:
> >    enum-model: directional
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index 208f46967ee59..b05829e44d8fc 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -248,7 +248,7 @@ neigh/default/unres_qlen - INTEGER
> >
> >  neigh/default/interval_probe_time_ms - INTEGER
> >       The probe interval for neighbor entries with NTF_MANAGED flag,
> > -     the min value is 1.
> > +     the min value is 1, and the max value is 86400000 (1 day).
> >
> >       Default: 5000
> >
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 49dd7df149ef3..0db78a0dfb516 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -2359,6 +2359,13 @@ static const struct nla_policy nl_neightbl_polic=
y[NDTA_MAX+1] =3D {
> >       [NDTA_PARMS]            =3D { .type =3D NLA_NESTED },
> >  };
> >
> > +#define NTBL_PARM_MS_MAX     (24 * 60 * 60 * MSEC_PER_SEC)
> > +
> > +static const struct netlink_range_validation nl_ntbl_parm_ms_range =3D=
 {
> > +     .min =3D 1,
> > +     .max =3D NTBL_PARM_MS_MAX,
> > +};
> > +
>
> [ ... ]
>
> > @@ -3672,12 +3680,13 @@ static int neigh_proc_dointvec_ms_jiffies_posit=
ive(const struct ctl_table *ctl,
> >                                                  void *buffer, size_t *=
lenp, loff_t *ppos)
> >  {
> >       struct ctl_table tmp =3D *ctl;
> > -     int ret;
> > +     int ret, min, max;
> >
> > -     int min =3D msecs_to_jiffies(1);
> > +     min =3D msecs_to_jiffies(1);
> > +     max =3D msecs_to_jiffies(NTBL_PARM_MS_MAX);
> >
> >       tmp.extra1 =3D &min;
> > -     tmp.extra2 =3D NULL;
> > +     tmp.extra2 =3D &max;
> >
> >       ret =3D proc_dointvec_ms_jiffies_minmax(&tmp, write, buffer, lenp=
, ppos);
>
> [Severity: High]
> Does proc_dointvec_ms_jiffies_minmax() actually look at extra1/extra2 in
> this tree?  The call chain from neigh_proc_dointvec_ms_jiffies_positive()
> seems to drop the range check:
>
> kernel/time/jiffies.c:
>
>   static int do_proc_int_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr,
>                                                 int *k_ptr, int dir,
>                                                 const struct ctl_table *t=
bl)
>   {
>         return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
>                              sysctl_u2k_int_conv_ms, sysctl_k2u_int_conv_=
ms);
>   }
>
> kernel/sysctl.c:proc_int_conv() only consults the bounds when
> k_ptr_range_check is true:
>
>         if (k_ptr_range_check) {
>                 ...
>                 if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
>                     (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
>                         return -EINVAL;
>                 WRITE_ONCE(*k_ptr, tmp_k);
>         } else
>                 return user_to_kern(negp, u_ptr, k_ptr);
>
> Since the converter passes false, aren't both tmp.extra1 =3D &min and the=
 new
> tmp.extra2 =3D &max dead stores, so a write of 0, of a value well above
> 86400000, or of a negative value to
> /proc/sys/net/ipv{4,6}/neigh/*/interval_probe_time_ms still succeeds?
>
> If so, the failure mode described in the commit message stays reachable v=
ia
> the sysctl entry point, where neigh_managed_work() requeues itself with t=
he
> unvalidated value:
>
>   queue_delayed_work(system_power_efficient_wq, &tbl->managed_work,
>                      NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME_MS));
>
> with 0 meaning no delay and a negative int sign-extending into the unsign=
ed
> long delay argument.
>
> That would also make this sentence in the commit message inaccurate:
>
>     The same max check is applied to sysctl as well.
>
> and likewise the new documentation text:
>
>         the min value is 1, and the max value is 86400000 (1 day).
>
> The netlink half looks fine, so the sysctl path and the range now declare=
d
> in Documentation/netlink/specs/rt-neigh.yaml would disagree: an out-of-ra=
nge
> sysctl write can still be reported back by RTM_GETNEIGHTBL as a value
> outside the declared 1..86400000 range.
>
> The cover note below the --- line points at a separate, not-yet-merged
> sysctl-core fix
> (https://lore.kernel.org/linux-fsdevel/20260905233819.1064529-2-kuniyu@go=
ogle.com/)
> as a prerequisite.  Since that note does not end up in git history,

Good to know Sashiko reads comments under --- :)

The fix was already queued for sysctl-fixes, no need to wait.
https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git/com=
mit/?h=3Djag/sysctl-fixes&id=3D1bb4e0f7a019b6b34228efbcc9c7399e3dbf72a8


> would it
> make sense to order this patch behind that fix, or to mention the depende=
ncy
> in the commit message itself?  Note this commit carries a Fixes: tag, so =
a
> stable backport would carry the documented bound without the enforcement.
>
> I checked the end of this series and do_proc_int_conv_ms_jiffies_minmax()
> still passes false, so nothing later in the series appears to restore the
> check.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260909233143.2401847-1-kuniyu%40google.com
