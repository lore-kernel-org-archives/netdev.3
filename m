Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4D406834
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442639; cv=pass; b=UURpEkjL/b31f/6gNaINU5qZ8Yhqcd3iESfMqt+Wgs/Sw+E2RZbZ+/OBUJF9iZ719gIcOQA5dNM3IxQmHy4RhZPNKYrEkJhkLwYZ9mkRWY2O9VSNG2tNxNS8EcrN2XmV33bvWFDGfQN4p3/S4PWXwI3ZnbN4p8CIXv8Ft8swpow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442639; c=relaxed/simple;
	bh=hrlqEHIst1+X+TMWk/G28Uq0LlSGdUaoK7pgCo9bqCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTCZPnDQ+2brnGKPXVvDeMh/QPHQTXoQYzTdINjWNNAMPsjsGHySBqSG1jG9UoUPgzXWmLGcbg+TF7gW1xCfk+0H+lhaR9bEPFZx/uEm5S+PfKsb45sSFEkvYqn4dWH2pnkUUwAQO78inNsHsFat9+zhX/DFVZWuqwniN/uiYqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+S9KbHQ; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+S9KbHQ"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309ce58730so46963791cf.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 20:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789442634; cv=none;
        d=google.com; s=arc-20260327;
        b=qn9BO8VsRBh2cblSOgDk9/03Nb+U6JMH8cQTJ7lM4m+dzvHWYhiXcCFEVSUheGEGWh
         F4aKJcesX+P/36n2a4m03J98806YpnPwhyBZxof10aR0vycFQlY1ZA9DyJsR4ODjIdXi
         yYr+ZFLAZLx48MwrHeN1g0lVDR8k0R2sYLNAybODv8wGAJgxP2vZtlGTt8sVqzydiKsy
         +qsuDlzyvfovM0eEi9+/25Wj6aiqoPOUY5yuO+2+q3qCrllUPDx7kmK3UViFBQqFI3KM
         XixMj/9qbFRAdWXVd27BkKQWW816GcZhKY//OjX3J4p1reMjpc0SsiVunlo6tZx+6ZQg
         p9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m2EsZhkDukapRbXUxImFy1u31FPKcjz83SS6cNGFy7U=;
        fh=zX1UkrfBrhShjCci2cMBSFiauI3jFNGW9S7NABItTQM=;
        b=rzsIFJeT0d170roR00+TCxGeXE+9BcsukUYvUJ57MZ7YvA1CNdGevcbJjjiQVTOji1
         0WDpLnbfQCeLigOLzgB/FR8MdCCbW/qpQlpP9/bT3ZrokIujlJpjLFhv9V+UajDetTde
         kc/+CiJNZMT6Es6S17CG9lPdED4qws8X6qW+wZfT5wibz9sVFGN7AYSicRQFH6RFPxxt
         BDYkbhlVHZGTiG2uoUyHQcf9jdQd/gt+un2J4da8cVypofRRLmG+STVZYJUPS+zWD0ny
         OiATA2Ibm+v/vb7GakD3e8dmjOKnsvb9HcrmAucALdrEKHjfQM2MvL8tKb/ZLHbCP4Oi
         WVEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789442634; x=1790047434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m2EsZhkDukapRbXUxImFy1u31FPKcjz83SS6cNGFy7U=;
        b=J+S9KbHQkhc8Wuy3uBKOw2ZZjCiK5jHRfY+HRx1LYECYkHL8KGu1neRZhCeq2G8Ixc
         85vDh1FwYQ17xgYR6oe5rUT/BXogMU3ZS3JbUPWan+VNjV6MCeIYn/QR1iu6A3OtvGut
         wenUevD91b7hpGDeEYVjtQ4n+j1etPnaP6+hsWZxL06fGAK1j3yxP0YHWQgEJT0jdPDi
         T4dHvR4/4GEWmDAxIYwp4GcDWp1kL5TR2Qbvt3r5lVNPlIGhuNmH6gkrImTgGs56bzpL
         l496FFyZZd0kwiqrVASlMsn9w+fZKrw7MZ0jnlGZTkGqayjfBd8An0TZoYqjQqJbbhFg
         wgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789442634; x=1790047434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2EsZhkDukapRbXUxImFy1u31FPKcjz83SS6cNGFy7U=;
        b=XexRw0o/JQSDownYo8Bj/4l7CNtoliJv5FoNyXLRd8qj2apsCyhNCDU16WFF2MH1NR
         +h7NmKSnwgXwb0LWO31YYVRW0ZAxgUXsopA0elThFd8l9tsII8E6UtFoBLVN+9LYdVqo
         1iJ7MU0fVpE0z5SzaBUo1cakDt1c05bnNI2RawMnDuaKuqc0kXkdNvk2VPd8L+6g2qOr
         1chII590qoutZhdQPyZHJxof0PgH5oTF10T/jnCgpEnNiJwTmt738z29eGrv2gYOtwHu
         oJn1Mx4EOJLpK6Z8QFAZEmtsqUGeaE6wzdcQz0MivMGLi/vCBx9JbdpVewLKlY3Lxt4d
         nWFw==
X-Forwarded-Encrypted: i=1; AKwUvBy6QyWTu+GnuYPjN3SAP1/4LvozkDFRUWbtF77ZBRw8/oeRgaivpapzabHFY6E71IUHPISoOjU=@vger.kernel.org
X-Gm-Message-State: AFuF++nSCkzSz5Wchiyzz0VYntTYsYNcpF0dl/ps1cpdwtkBRaLFk1y/
	vUa3auZbFBw0hFA8fjuGDK1KzQuguwaZFLdgHi1+xGlAHqNLa2H0snatmMDFXefAq11rWs8dt1t
	OZUy2ruzKW6MDPcEgvtpFnhOBzFmXPwrL50qJXC6R
X-Gm-Gg: AYBFou1XqSXEqNfjALurw32A6OJNj0A7JpPbp0nSDw7WSfb1h/AdZlP//MWjuarwg/E
	YnuXq6GSCEWYwutow4KiPwc3uh5z4hHyTj6QQkBcWLaJnk4GPKVBGXGNmAfgeo+/xN+yPuz8LRU
	a0a8WE3ygnSBiJ7TCKDRN+AoqHa6o4dqc3dckZpOkYUj4FyUyEEkuhuHOg0tEo3e+EXaF/LDTP2
	xCn+pCVbKnRuag5vf4ds0c9m/7pQo6uwcnwRj+XOzjyVPC9ilhRe0dFtAub/EXiPcT6SrsGguVD
	gCVi8kyler5XqqDlsYOUNQRaMGUE4zK57gaUhQQW+eoBlW9wRt3tVji6BX2G9CuPqXjfMiZm/zj
	CW5PcLiXjs7r+1kwzg8iEThzcTH0dWeTALoo5r0Fjc3HjCo9oUyMC+FRGs9ZX3G18Cdp0RtrbYZ
	STzg==
X-Received: by 2002:a05:622a:15c5:b0:530:d1d6:792d with SMTP id
 d75a77b69052e-5310cf42260mr79871191cf.15.1789442633858; Mon, 14 Sep 2026
 20:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911073758.2714564-1-xiaolinkui@126.com> <CAAVpQUAUAgAVutpQgMu4LjG1KOpm9Du0Kw1kbp2vHtHqQ5USZw@mail.gmail.com>
 <CANn89iJTMxWERqz1tdxuQ2jW6Rr7xN_ceh_yejtrBTPwN_YEeg@mail.gmail.com>
 <CANn89iJfphTDBFKdNkgmBHDybc8wV2EGSJoiHvzR0ht4V2bMAA@mail.gmail.com> <182acfbd-d03a-4847-8fb8-4d0d29f22107@126.com>
In-Reply-To: <182acfbd-d03a-4847-8fb8-4d0d29f22107@126.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 20:23:41 -0700
X-Gm-Features: AcwNN1W3r4K_dqI2PDFpl2Z4moprvaKFdCce3ABAcBP6EBshrMSO52lUYdXu3_g
Message-ID: <CANn89iJhFL2LNQCXTANQAx8B1GVdGTJgrDwPTZOjbH8k1ygtsg@mail.gmail.com>
Subject: Re: [PATCH] ipv4: fib: annotate data-race around nh->nh_saddr
To: Linkui Xiao <xiaolinkui@126.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 7:37=E2=80=AFPM Linkui Xiao <xiaolinkui@126.com> wr=
ote:
>
>
>
> On 2026/9/15 04:21, Eric Dumazet wrote:
> > On Mon, Sep 14, 2026 at 12:57=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> >>
> >> On Mon, Sep 14, 2026 at 12:51=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> >>>
> >>> On Fri, Sep 11, 2026 at 12:38=E2=80=AFAM Linkui Xiao <xiaolinkui@126.=
com> wrote:
> >>>>
> >>>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> >>>>
> >>>> fib_select_multipath() compares nexthop_nh->nh_saddr against the flo=
w
> >>>> source address with no lock held, while fib_info_update_nhc_saddr()
> >>>> stores a new value from another CPU as soon as the preferred source
> >>>> address of the egress device changes.
> >>>>
> >>>> Commit 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_=
genid
> >>>> and nh->nh_saddr") added WRITE_ONCE() on the store side and READ_ONC=
E()
> >>>> in fib_result_prefsrc() after syzbot reported
> >>>>
> >>>>          BUG: KCSAN: data-race in fib_select_path / fib_select_path
> >>>>
> >>>> but it only covered that reader. fib_select_multipath(), reached fro=
m
> >>>> fib_select_path(), is a second lockless reader of nh->nh_saddr and w=
as
> >>>> left bare.
> >>>
> >>> 32607a332cfe added the reader after 195374d89368.
> >>>
> >>
> >> Indeed, please put in V2:
> >>
> >> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches
> >> source address")
> >
> > Adding Willem
> >
> > It seems that this code also lacks a check against genid?
> Thanks Eric and Kuniyuki for the correction. I'll send a V2 with Fixes:
> 32607a332cfe.
>
> Kuniyuki, good catch on the missing genid check. nh_saddr is only
> meaningful when nh_saddr_genid matches dev_addr_genid, and
> fib_select_multipath() currently skips that validation. I'll fold the
> genid check into V2 along with the READ_ONCE annotations, unless you'd
> prefer to send it as a separate patch. Let me know.
>

I (Eric) was the one who mentioned the genid thing :)

Send a V2 with both bugs fixed.
Thanks

> Best regards,
> Linkui Xiao
> >
> > diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> > index 50e96f86ca59ab164f764f5d2185d158c14a4a6a..5a8bbcb65daaada1c3ae963=
39cabc2e801653dac
> > 100644
> > --- a/net/ipv4/fib_semantics.c
> > +++ b/net/ipv4/fib_semantics.c
> > @@ -2185,6 +2185,7 @@ void fib_select_multipath(struct fib_result
> > *res, int hash,
> >          bool use_neigh;
> >          int score =3D -1;
> >          __be32 saddr;
> > +       int genid;
> >
> >          if (unlikely(res->fi->nh)) {
> >                  nexthop_path_fib_result(res, hash);
> > @@ -2193,6 +2194,7 @@ void fib_select_multipath(struct fib_result
> > *res, int hash,
> >
> >          use_neigh =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_use_nei=
gh);
> >          saddr =3D fl4 ? fl4->saddr : 0;
> > +       genid =3D saddr ? atomic_read(&net->ipv4.dev_addr_genid) : 0;
> >
> >          change_nexthops(fi) {
> >                  int nh_upper_bound, nh_score =3D 0;
> > @@ -2205,7 +2207,9 @@ void fib_select_multipath(struct fib_result
> > *res, int hash,
> >                      (use_neigh && !fib_good_nh(nexthop_nh)))
> >                          continue;
> >
> > -               if (saddr && nexthop_nh->nh_saddr =3D=3D saddr)
> > +               if (saddr &&
> > +                   READ_ONCE(nexthop_nh->nh_saddr_genid) =3D=3D genid =
&&
> > +                   READ_ONCE(nexthop_nh->nh_saddr) =3D=3D saddr)
> >                          nh_score +=3D 2;
> >                  if (hash <=3D nh_upper_bound)
> >                          nh_score++;
>
