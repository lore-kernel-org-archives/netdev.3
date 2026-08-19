Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9E3AC0FC
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151528; cv=pass; b=UkSncCSHwlVaHHG8J2GTJRSpaX3+j+3pTuVudOBMZZA8etzln9Yyp26PppaYRmgYI8CZ2yEgT8O7AguF9wz0MygXGmWGFyCLw7CQKyJCJGkdJNrzSPx600rMEPp6GzyZjoGNqsVIHvffQVY1BhSPsorxBp6o8TSZ7913Cm6E4No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151528; c=relaxed/simple;
	bh=NwSTQygdPz1tgY6C0nJJo5fEEmWw2/QVhLE7k9HCDUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yl+7VGs0fk8lew1KanPiHRrN/UBUFcCcXpSdoVp8Fzc/B87k4ypjtKd/qO5Y19qC8GPgAw2owUhMEeFNk90I3Uv9wJe6djBk9IM882sV5gT4AAFLxXZX2ATcoXuXH+J7PGjD0/rMZ/lpM0X72powkurxkY6owVT0+Q25xfflqq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=W6a+A73E; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="W6a+A73E"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbb7926836eso718211a12.3
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787151520; cv=none;
        d=google.com; s=arc-20260327;
        b=Cl3rVqQ0WlIH7+IB08hHhR+Tow8NasC5Ei5wPsroV7JhzJtas+j3kckk5IsaFaFZdx
         xPt14I4/8ua/ydKmUuE7SP4yX4vysc6M+RKdho6jRZuJ1uwx2h8VpmgVxk+QJVlEGqnV
         SHLqlaMoG7aLTvkOsiz9szKO67PShEQX+b6YK0SVIobhILpjouRXLBKA0tvFGr5h2goR
         E6Of7idElTtUOZ+yMIout2Tn+IB9RbzD7OYFmL67mbGa0hoGJT4WSN6/Vzli6PBkFyF3
         GwtpXtqsN3tllIulU+Us8Ro0pXIQ/3OybXwJDlFmJKZYTT2IbVBw6+5Hk+5YkJmYp3GB
         AJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=34/hS36bGgNkv8IoYOmdyqI8EyEJGsQbwzaIsXNW56Y=;
        fh=M7oqS4dhWck/l2Fu3NRPAuwjyyua/Nnn2TtGiZ7CsYo=;
        b=Du76ACd9lvLTiRhbFJPv6DPaxwcPkqgGifKL2+9ueRwM2WipdlQfabbCrdR3lGtU/M
         KNriKORRfa6hcgziAjG6Ue3eBr9iL+q3ONiELdQpJ8Ujkx8X+BXtj/TKkAHzpjGZTO5s
         WzM3ahjgvX8c5kweMslj9mpX2tT0XRkmuY18yZyeRgS79CO/8FY6KIe/P/iCezUUD0pk
         s5kYpEUxt4um9mA6H7e7iBVkksMgiNWYxL3PCB6E7tJur/Kg9t3sCQwh0oNjNSRG4/pY
         qwqc8F16xlUzgB/k3EVgCgXOo24u7rEA5Ez/7G0TWN1cqcMat+Xtsv4114UK2XM3VP7W
         4B4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787151520; x=1787756320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=34/hS36bGgNkv8IoYOmdyqI8EyEJGsQbwzaIsXNW56Y=;
        b=W6a+A73EpLl5nbKsEHEhRAWZzr4OPLC1ByALc4V9mEi44AYYl5oqbKwKYum5QzU5YQ
         xSkGX04J0dJcAbNJMxsKzxr/tQR4wDyumJJnoR4HAzxciboNMmAo2XV/XILehioPF6o5
         I9vFXZBbelh6xSu0OKuXzw2nnCrEYr053PLv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151520; x=1787756320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=34/hS36bGgNkv8IoYOmdyqI8EyEJGsQbwzaIsXNW56Y=;
        b=WEM6XdnPqsCPAD8Xncp7dL90u61XmEQmzmse+S8mlBFOqx6k7aK8O2BabMqjeIeEyG
         ACZqs3HfxiXWbNT84v9FQTUVPN9DtU3vGU4feGMB5YaQXJOoIiWlQwDmoYqqlo8ognlI
         2Fhowu36ErmvcP6Pf4Cf/J4OviPcSEP/Bx9i4KnceeZTbiTuB0QtxSmKjwBfgqY7YnYn
         dCh5T6SGuSWH/VJYgV0LoQOtE6ntjQNp7QKLSdwXVPiJvzNIPIpMDaUNTEIZ8oBD+DKa
         Xce3bVutH6n4/sV6b3fI6/aZ61IdluV8pxukXg2Rtw92Zq/zEz0MIqIie3u2CfXE/xfv
         GmDQ==
X-Gm-Message-State: AOJu0YwLWQm72J7M6DdbKUSyH73rur9hzBSXtDunM29Jks5gFuXC0BFT
	QiveY3uKdcYnfY6HeyFuQhe035/XSUVHjoEJ+jTnfhTAA74p837rP+qXl8b3XA8lSlefTQuUtHO
	NdDbke2xnDZmN8uzxLHD5HO9B8AkBYDBLvJSS+f3E
X-Gm-Gg: AR+sD10Xg5dy49qaI49eDSMv10BaHaMqY9bAeHbgmaNxHpkpJPvFFW9O66OsBy3ix9P
	pJHimeGb58ah2Y9K21mOQL0oeznKc8BsbE7sorLO2HOzx8FJo7C9IlM7Uq6/p2azJ7/yJ7lRxZZ
	+iLNQTniIEOHQ4Y6pvC1mnu0tdV7Zik+r0+hcAXhVZ9xgHh4L2d+k2Lu35QupDr+BassI5ZDzUD
	++7vYdiYWFDqB8SmQ8DNrj9j/55BXY+TzkMLwwbCxXCNTeFT7CxoNOVEkDRGx9Rcl+8xtgz9tht
	+qNxNW1FJ04PNmS8+8aXHZosKyhgzuJb3KGF4CpZzaH3Dg==
X-Received: by 2002:a05:6a00:f8d:b0:846:8b22:4933 with SMTP id
 d2e1a72fcca58-851d3a69eb7mr8869557b3a.17.1787151520239; Wed, 19 Aug 2026
 07:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143213.57401-1-jhs@mojatatu.com> <CANn89iLM1JT7xeANTFYOxaOKuz1qSmM4yugRDg4y=uFwP7bdEw@mail.gmail.com>
In-Reply-To: <CANn89iLM1JT7xeANTFYOxaOKuz1qSmM4yugRDg4y=uFwP7bdEw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 10:58:28 -0400
X-Gm-Features: AcwNN1XQW6l3kg8etJVD8u8e6M6J67YSYFmD43PINaeXh4NmX0JNWYrO4HorUC0
Message-ID: <CAM0EoMkUXGW0WNV4Y3rLUyJUDxFcmd7knYoF3ynHQWjUXHRTQQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc
 soft lockup
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 10:52=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 4:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > qdisc_get_stab() accepts a user-supplied size table, and
> > __qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
> > overhead, the size-table data (u16), and size_log (up to
> > STAB_SIZE_LOG_MAX).  A crafted stab can therefore set qdisc_pkt_len()
> > to ~1 GiB for an ordinary skb.  Per-flow deficit schedulers such as
> > DRR and ETS replenish one quantum per loop iteration; with a tiny
> > quantum (1) they spin billions of times under the qdisc lock,
> > producing a soft lockup / RCU stall.
> >
> > Cap the final qdisc_pkt_len() to GSO_MAX_SIZE so the size-table
> > amplification cannot drive deficit schedulers into an unbounded loop.
> > A legitimate size table (e.g. qfq's overhead 999999999, which is
> > handled by dropping) is still accepted.
> >
> > Conditions to recreate the bug:
> > - CONFIG_NET_SCHED=3Dy, CONFIG_NET_SCH_DRR=3Dy (or CONFIG_NET_SCH_ETS=
=3Dy).
> > - Attach a DRR (or ETS) root qdisc with a crafted TCA_STAB that
> >   amplifies qdisc_pkt_len to ~1 GiB (e.g. size_log=3D15, data=3D[32768]=
).
> > - Add a class with a tiny quantum of 1 and send one small packet; the
> >   deficit loop spins billions of times under the qdisc lock and trips
> >   the softlockup detector (panic with kernel.softlockup_panic=3D1).
> > - Reachable as root or from an unprivileged user in a fresh user+net
> >   namespace (unshare -Urn) with namespace-local CAP_NET_ADMIN.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v1 -> v2
> >
> > 1. Sigh. The v1 overhead cap broke the existing qfq tdc test 5993, caug=
ht by
> >    running the whole tdc.sh instead of affected qdiscs reported reporte=
d by
> >    poc. That test legitimately uses stab overhead 999999999 qfq and exp=
ects
> >    the qdisc to be accepted (exit 0) with packets dropped.
> >
> > 2. Better Fix: cap the final qdisc_pkt_len() to GSO_MAX_SIZE(524280) in
> >    __qdisc_calculate_pkt_len() per sashikos[1][2] suggestions
> >
> > 3. Given existence of tdc 5993 we dont need the tdc test created earlie=
r
> >    since the essence of that test is covered in tdc 5993.
> >
> > [1] https://sashiko.dev/#/patchset/20260818101735.16655-1-jhs@mojatatu.=
com
> > [2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101735.=
16655-1-jhs@mojatatu.com
> > ---
> >  net/sched/sch_api.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index 65b35528d125..ad4f117ff55a 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb=
,
> >
> >         pkt_len <<=3D stab->szopts.size_log;
> >  out:
> > -       if (unlikely(pkt_len < 1))
> > -               pkt_len =3D 1;
> > +       /* A size table can inflate qdisc_pkt_len() beyond any real pac=
ket
> > +        * (via overhead, the data table, or size_log); cap it so defic=
it
> > +        * schedulers such as DRR/ETS terminate their refill loops.
> > +        */
> > +       pkt_len =3D clamp_t(int, pkt_len, 1, GSO_MAX_SIZE);
>
> Yeah, although it is a bit strange to mention GSO_MAX_SIZE in a function =
which
> does not take care of GSO packets.

well... there are many many references to gso under net/sched. What
dont you like about this specific things?

cheers,
jamal
