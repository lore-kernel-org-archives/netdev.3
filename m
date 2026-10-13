Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7652E076
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923475; cv=pass; b=NML++fH/s2x6FGIXKRByD2nz1J/6rjRXi62W4/bXi9F3Nthk0GGisFQAirwaozGGPAPWBla8vRXNXZjN9oXbRtAmrCukNIC6vjGlIcIXSxBrt9O+VWwwpjHaBA7Q9cgml+aQ/xg3uJMDYy4MwDOpZG37KgrSb7hP5cmyPuBNkIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923475; c=relaxed/simple;
	bh=jQV8f6i1LrDMlYQzUwRfPWZE8XyJmhT8aZCyquv82Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nm964MNNMEOPdcodV6gBN81b/KrGKPyeRK/tomyBg2E407OmBwBlKPpYCFrRhkuOO2u5uoJk6rUgzDgjbxaF44SkEi64Y1qXAdiznNeMqinevCoPm+XJQWuCSvbq3agxIR3GeYFNbZyb/XgbXWsuoirN1SKHQQx+WV+EcQpisDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R03wVuUW; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R03wVuUW"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-154e9d2d979so147992c88.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791923473; cv=none;
        d=google.com; s=arc-20260327;
        b=T8VVZCZxf4GmXNURfBUYehX3zT7XID6B8TPzeTIGrzJ4M+W80WcVFddrEgtEktyqVm
         IeNPKh7XefMU72nqdbbihKnpw77hQs8Vj1ksohJJ3TZtZZuLTg6koCz0gOjpxn0i/ktg
         BK7SeMTT3/yJJyrdIRVBQXt1qX5BFLN/N6Tgg0Ra3PVKza0tpZ0F3zK9Cf28YKoKT/Sy
         N5OIbSIjOqg7z46pAF4lTXR0XQ9u35C7uwTjvkS2e2FrRzYpDPtiY7tHK2DGr1Qo1IoB
         C1GSXWpqeAiWd8kmoezFOeHth2uIb4BFwJnd9bAAgfv6d6H0DZQW6TrO0zl0aGIoZl2c
         wzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=atvUm2yLlESoxli2CrXR09rac0lrN3Yfj/NESXu0zIc=;
        fh=bFEVG3XKPUQz6UYkdeYMeM0reCwhKuL8P/202W8loFE=;
        b=qITMM3iA4ezg5riKRaHlSwgtfBlE+x0ktOsxixG/mEFs3Qq4jCJUjOdhMcDCh0llGG
         IKdJhtNnnsiTsVFXDECipTMroUfBu/goESdazQvzk071vvGTcyBBNvvPVjJRLRkRXiia
         jgGtx0SqWkgl0gGKT3A/Jpo/Tvuhw+YBr+/2RoJAJ0bpz1pIpuObnXiNqdngvygfMPQu
         +4b+7dFaeHWGmX+xusIlPYhGc8USE36y9ZBYS9wkZaX1dFSc+NaD5pR+waGWFsiuydJu
         8ZMiSbRh3PrA0Er2QbJj2lxIctJdfTNXSdP5fJRK6buvXgCkPEWaMKNAgMpCuavhyElP
         wHnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791923473; x=1792528273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=atvUm2yLlESoxli2CrXR09rac0lrN3Yfj/NESXu0zIc=;
        b=R03wVuUWPrkiaZicAA69OxapLyICPF4TFEJ5flS+8XLH45tytkygMENPlB1teY8AeP
         6lN4oTPQlftR/+NiJcpCdCbYZwJL7zKWo7LRGe4yxt8RKKWAEpooC+4CzCMAlhtLRKXA
         rJuxCpNW4CijLKmXFQMwIRgOqUf2wa7lexXwnTjazPUhjuOiG95g4geShfZZAJyvnu/n
         8mJiahI2P+5948YaEilqs456XiO06yAtXp+7MRLH5HTELMr4/JQsCCg/sAHXkRkbrhmH
         SPyGOzYOiutM7gLT1/Jx/WLJVTpPQULULIH5+akavlHIsotaWw9d/xEi6+QXdA+pxm03
         UQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923473; x=1792528273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atvUm2yLlESoxli2CrXR09rac0lrN3Yfj/NESXu0zIc=;
        b=c7BqL6QuoB/sAnHRb1PNqOjBgNLvRcQUJKQ9jg4tqbFFEXIGGV9cuOcmYI5tgO9jE0
         WxJ0VmsRJiVWYbVzeckDSAi/44EOLkEJh2HD/3CVBfKUQcELYFI1xHYL9s7k8QFlcfKI
         HHjv2kTGKkWtFUe8yoqSyTmhAQLv0e2MdYuqEzzXG4bIDbO7MtcqZiWj4slzUXMUXACr
         97Uz84C34ivUCjfHE8xZNvvupbF0Kojmlxor5QT5dODB8uFDAvboa3MvqEkdu+TfulTX
         +vhMnkyQoXpN6sbvJicmGwOafLRxtHR9BerS3S+2/8VpfU+MiuOJ4c2Spubo9DZGXeeF
         eaVA==
X-Forwarded-Encrypted: i=1; AKwUvBz71iNfEgbgSDLZCFVo/SzbfeOkoikdii9xcLRL30RlQcRpTVUR/BlIUHD0ttk0ibsj3HPpWIk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwdLTvwq1+2X/MtFtJSQ7vJrqp9piQgC5oiMtzm1ESeebE7Uj+
	Aq1dovdhTfRotvubepGiA/U3tdrCcswQHbaD+6zG32wx+FPdIcqk8LVwl/7lJEqdM+qmjruvT+3
	aI/O8Xnb5dzxyut73PuB37DnxfQm6vfyHj55cUS0q
X-Gm-Gg: AYBFou2q4NLId/Y/zj/ONnL74VgfggC01sxbtiXBboU/Sd9hrniEpNNMFAnXXQ0uD8u
	VytHL4nBrtFLbV4cxElHkV3YazNxQ/YslUmWHCUES0ItlbAsyDNXjr3xK8dQnZuhTTi9MUpKW0o
	456VWDG1BZ2NwhBMZVsIC4zWAhm44GfgDgAozWwLdLSskp8N0kAVotlZFFWIJFAoH1aMeaqnPLB
	Qc2ceKUNxgqjKDOdyM6fHlHS2j3E6us+D82O7Y6dPihvnJqj5bWABIJU8pe7F35jF3gNv8/5H/H
	pj8GNC0j+NJFKzmcQdmdzz/PgeXuNR3F4b42s7S49rfmKEZ3cqdFU5g2wVIx6sc8s/r/mdRTCD1
	40cFNv9mR80tqFq8Yh8hqzP0OO9yJ2IW4ZkJIsbkxwX1IsPUxm09oKB3j6sjqc8ydEmSus0398f
	m6RCjebvCT+JlhZKBMA5Hpiw==
X-Received: by 2002:a05:7022:b048:20b0:158:b944:b15 with SMTP id
 a92af1059eb24-16a5ec48b20mr19562390c88.22.1791923472284; Tue, 13 Oct 2026
 13:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012194530.3751034-5-kuniyu@google.com> <179192161164.434549.2046952979938439215@kernel.org>
 <CAAVpQUAB9ndSQqBwz=QFhD69wa+57+m+QVN8GX7vm+1Ko-ncsA@mail.gmail.com>
In-Reply-To: <CAAVpQUAB9ndSQqBwz=QFhD69wa+57+m+QVN8GX7vm+1Ko-ncsA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 13 Oct 2026 13:30:59 -0700
X-Gm-Features: AclHuK8YP_0JjTtRr3sgBb2RZ5l79Ibv0v9PH8o018AAJIhm0rU_MxurfvcMGKI
Message-ID: <CAAVpQUCCW+4BGLGO1EdmgoigbPT1Ki1Eq-7e76jK_S9O9GWW=w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/4] neighbour: Floor INTERVAL_PROBE_TIME_MS
 at 1000.
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 1:29=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Oct 13, 2026 at 1:00=E2=80=AFPM <netdev-bot+sashiko@kernel.org> w=
rote:
> >
> > Thank you for your contribution! Sashiko AI review found 3 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 2
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] The patch narrows the accepted uAPI range for
> >   interval_probe_time_ms in every netns, including init_net.
> > - [Low] The commit message describes a bug fix: a namespaced user can h=
og
> >   CPU because neigh_table is now per-netns and the interval floor was 1=
=E2=80=A6
> > - [Low] The sysctl and netlink paths now accept different minimums for
> >   the same parameter on kernels with HZ < 1000.
> >
> > Pre-existing issues:
> > - [Medium] This problem wasn't introduced by this patch, but the patch
> >   makes it easier to hit.
> >
> > --
> >
> > neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.
> >
> > This patch raises the minimum of NDTPA_INTERVAL_PROBE_TIME_MS from 1 ms=
 to
> > 1000 ms, both in the netlink range policy and in the sysctl handler. It
> > also updates the YAML spec and ip-sysctl.rst to match. The reason given=
 is
> > that neigh_table is now per-netns, so a small interval could be used to
> > hog the CPU.
> >
> > Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
> >
> > > neigh_table is now per-netns, and a user could hog CPU by setting
> > > INTERVAL_PROBE_TIME_MS to a small value.
> > >
> > > Let's floor the value at 1 second.
> > >
> > > Suggested-by: Ido Schimmel <idosch@nvidia.com>
> > > Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredde=
r/
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > [Severity: Low]
> >
> > Should this have a Fixes: tag?
>
> No, both the commit and this change targets to net-next of this cycle.
>
>
> > The message describes a CPU hogging problem
> > caused by the per-netns conversion, which looks like this commit:
> >
> > cda2962b6e2b ("neighbour: Namespacify neigh_tables.")
> >
> > That commit lets RTM_SETNEIGHTBL set the default table params
> > (ifindex =3D=3D 0) per netns.
> >
> > The message mentions 211da42eaa45 and 6d79b223ec44, but it never names
> > cda2962b6e2b, and there is no trailer for tooling to pick up.
> >
> > cda2962b6e2b seems to be in net-next only, so stable is probably not
> > affected.
> >
> > [ ... ]
> >
> > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > index 6b0569aa5d643..92e3c83c0fe50 100644
> > > --- a/net/core/neighbour.c
> > > +++ b/net/core/neighbour.c
> > > @@ -2438,7 +2438,7 @@ static const struct nla_policy nl_neightbl_poli=
cy[NDTA_MAX+1] =3D {
> > >  #define NTBL_PARM_MS_MAX     (24 * 60 * 60 * MSEC_PER_SEC)
> > >
> > >  static const struct netlink_range_validation nl_ntbl_parm_ms_range =
=3D {
> > > -     .min =3D 1,
> > > +     .min =3D 1000,
> > >       .max =3D NTBL_PARM_MS_MAX,
> > >  };
> >
> > [Severity: Medium]
> >
> > Is the intent to reject these values rather than clamp them?
>
> Yes.
>
> >
> > With .min =3D 1000, the range policy now rejects NDTPA_INTERVAL_PROBE_T=
IME_MS
> > values of 1..999 with -ERANGE. This applies in every netns, including
> > init_net.
> >
> > In the same way, min =3D HZ in neigh_proc_dointvec_ms_jiffies_positive(=
)
> > makes proc_int_conv() return -EINVAL for sysctl writes below about one
> > second.
> >
> > So commands like these used to work and now fail:
> >
> >   ip ntable change ... interval_probe_time_ms 500
> >   sysctl -w net.ipv4.neigh.default.interval_probe_time_ms=3D500
> >
> > This removes the sub-second managed probing that 211da42eaa45 added. It
> > does so even for CAP_NET_ADMIN in init_net.
> >
> > The commit message says "Let's floor the value at 1 second.", which rea=
ds
> > like clamping. Could the message say that values which used to be accep=
ted
> > are now rejected?
> >
> > Another option would be to restore the rearm-time clamp from ed6cd6a178=
96.
> > neigh_managed_work() currently uses the configured value directly:
> >
> >         if (!list_empty(&tbl->managed_list))
> >                 queue_delayed_work(system_power_efficient_wq, &tbl->man=
aged_work,
> >                                    NEIGH_VAR(&tbl->parms, INTERVAL_PROB=
E_TIME_MS));
> >
> > > @@ -3701,7 +3701,7 @@ static int neigh_proc_dointvec_ms_jiffies_posit=
ive(const struct ctl_table *ctl,
> > >       struct ctl_table tmp =3D *ctl;
> > >       int ret, min, max;
> > >
> > > -     min =3D msecs_to_jiffies(1);
> > > +     min =3D HZ;
> > >       max =3D msecs_to_jiffies(NTBL_PARM_MS_MAX);
> >
> > [Severity: Low]
> >
> > On kernels with HZ < 1000, does the sysctl path enforce the same minimu=
m
> > as netlink?
> >
> > The range check runs after msecs_to_jiffies() has already rounded the u=
ser
> > value up to jiffies:
> >
> > proc_dointvec_ms_jiffies_minmax()
> >   -> do_proc_int_conv_ms_jiffies_minmax()
> >     -> proc_int_conv()
> >
> > kernel/sysctl.c:proc_int_conv() {
> >     ...
> >                 ret =3D user_to_kern(negp, u_ptr, &tmp_k);
> >                 if (ret)
> >                         return ret;
> >                 if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
> >     ...
> > }
> >
> > With HZ=3D100, a write of 991 becomes (991 + 9) / 10 =3D 100 jiffies. T=
hat
> > equals HZ, so it is accepted. With HZ=3D250, any value from 997 ms up i=
s
> > accepted.
> >
> > RTM_SETNEIGHTBL rejects those same values with -ERANGE. Both ip-sysctl.=
rst
> > and rt-neigh.yaml now give the minimum as 1000.
> >
> > Before this patch the two paths agreed: 1 jiffy for sysctl, 1 ms for
> > netlink.
> >
> > Would a shared constant, for example msecs_to_jiffies(NTBL_PARM_MS_MIN)=
,
> > keep the two paths consistent?
>
> I'll use msecs_to_jiffies(HZ).

of course s/HZ/1000/ :p


>
>
> >
> > [Severity: Medium]
> >
> > This is a pre-existing issue and was not introduced by this patch, but =
the
> > new floor makes it easier to hit.
> >
> > neigh_proc_dointvec_ms_jiffies_positive() calls neigh_proc_update() whe=
ther
> > or not the write was accepted:
> >
> >         ret =3D proc_dointvec_ms_jiffies_minmax(&tmp, write, buffer, le=
np, ppos);
> >         neigh_proc_update(ctl, write);
> >         return ret;
> >
> > neigh_proc_update() then marks the parameter as explicitly set on any
> > write attempt:
> >
> >         if (!write)
> >                 return;
> >
> >         set_bit(index, p->data_state);
> >
> > For a per-device entry, neigh_copy_dflt_parms() then skips that device:
> >
> >                 if (dst_p && !test_bit(index, dst_p->data_state))
> >                         dst_p->data[index] =3D p->data[index];
> >
> > So consider a rejected write such as this one:
> >
> >   echo 500 > /proc/sys/net/ipv4/neigh/eth0/interval_probe_time_ms
> >
> > It returns -EINVAL, but eth0 also stops following later changes to the
> > default. Writes of 1 to 999 ms used to succeed, and now they end up on
> > this path.
> >
> > Would it make sense to skip neigh_proc_update() when the handler return=
s
> > an error? The other neigh_proc_* handlers make the same unconditional
> > call.
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20261012194530.3751034-1-kuniyu%40google.com
