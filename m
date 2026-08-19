Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDA3FE352
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152551; cv=pass; b=TNMp2wfmjVaXgwW9RTc1wwjlqiIARdP2WnUm059c39RqC+Gi20jfjnMM28+RnqkR+qohpnE3lEV3Lf0zngmADIt5iwTAEP0ZXo63W9jyqq8p/BEHzXhZQi6R5NvqH6JCHagBK3PJ2/ThTK6djjsWMqlAMDbK3dlFo9UEaqgBrow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152551; c=relaxed/simple;
	bh=459KEqF2l7j0bEcBM0KmDs2lcrDu+oIduz2otY4oqsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6VN029htimJfOUjPS32+dGWLqTuerJfypEqEFeD++IkogymRTFEE+pepUXjALm+bAXxgLTj8AsRDzCMXvzPrWJyjeZwW2EzOWDwpR4sB3LA9m2zwcKK013Km8yUoX95uag51u16w/saj0cvSOKO8fs/pMUmG6kpP9G3ikE865o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClPmX9Mh; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClPmX9Mh"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c0006ea8eso7994231cf.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787152546; cv=none;
        d=google.com; s=arc-20260327;
        b=geNEwAPWgTC4I4Y+tbrGhfQSo9nkMXU2NoichAa3Ivi2N8Xq3Dq7oANI9YEOOVIekI
         4GeJ5miBuySqEi89ipk2dL/dWhdDpnm/O/t+QVgNBGpAFiyjpKMWIaCttPLX3Xnh//5h
         fGLqhjRQMTwSCpMYKUpJatr/YpjzLPQi2AE47LJtAdqbabqD+xydPhygzvN+jPk/IIbo
         fPJHlhirm685uYVRquVqpvCl7Is0osXvQvKYGTMQvYvlrKLCT/07zwSv0WHCUNU2AgBp
         v0S9HcyTBrZB+CLqR0/RpFiqXfcwWmoe+uXGfePNMxizdzk/b2sOt+2KiUZrgz1kmUdW
         MW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7N8CbCmVonj0Y0cToVjeMsRxbld7SNQmDP31faW8N18=;
        fh=X8BDq2/KK+aalG3nUimw3vzOLwCn/tnGxVtO1Bv9toQ=;
        b=doJjdC2ze5i0YO6r7vSHivjAQfKe0uywsVEeA4qNZF2RDem99CUeC9M70koOqN2yB7
         qcy2y0ZsSMfgP30BJkRc/PN7aWlTycQQTsLjYHokEpyXdvEsP0uHQk2wQ8w2wMQeWGCS
         IT+gbqHz21SsN1WWOH8YhpKDeCfppfKpyMUflBpOKdyFZrLO866rGSvc+6G5aRVEWi+k
         HNBa0ctz9IpUi3xqtw96yoh+pnDhEnD6QjpDfeJeNw/MLKyRY0DA2YT1NWum54D7GyT/
         RAfuZw3vJ7OUKcFmgRtmxxOZKfQFHlI10crcwoM8U4gwLT92ux+UVqnkhRzVKqYrR2fA
         LDKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787152546; x=1787757346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7N8CbCmVonj0Y0cToVjeMsRxbld7SNQmDP31faW8N18=;
        b=ClPmX9Mhl6mC2Deq5XzVbImDrkfXA1cvYQY76FiM0ycIWp66zVzPQOIH1ZJg/5ybU5
         Pz9lDUVjBmcpe7LFRiTsmJq28b0QGumqzFmIlBDoNdkgAAiqUzidqeWVGvL7a/toNeNE
         vk1r7nZ4fgAMrqJduj2zMf2hwleYp8ugcpd9NYwWhvaKVQmFBfKrqH2beIcUGI38zVEo
         4bpgU4OeLn9jX0lOpbEffh3Zl5l+Skjb1R9lk20R8FeGTn+bvIaSxmbXupeYqEU2iZRf
         zvPqr1q0VGm7MHkm44WV9wXi3PbBnFUiw4Y+9hkR4cibJLFbxGyw3wcNdsCiiMB2BY+R
         pVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152546; x=1787757346;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7N8CbCmVonj0Y0cToVjeMsRxbld7SNQmDP31faW8N18=;
        b=kAzNo9A1ZuCy/kSMq5lObaAYi6fCz4JCkFv0zkOOF208dClyx/qiVXg0wlVHEFkRKF
         wu4neoADU76Cz/SDLwDZR+Rz8aUOtIyWkSghHcFB7qGsvyGkHTmC4ddPqB7LPV+PS062
         yO2SOEQFzaVNg9awYV2Kym8gZ2fgO7XiyM4dsjsXQ8Bb/Y/F6h/TysCy6tuGoJr2yl5V
         AFmZuqREcW6O8MX4y+k6zX2gp58giytimeLsmo52LA0Pn82xoxOj8wacaU0Gh/0HfonP
         +hOqc1BD3Z2poGzJ2FIcC87aQm4/Sm/XA1VGdSANhIkamBSeTiJ7zzaxZYkiZljesbSg
         KjQA==
X-Gm-Message-State: AOJu0Yx0XY0XvtiAjN5nEPXv3SZ/XHiXbuKxtMreYttYutGELjBnQRO/
	3uyEgjJn3f02giXsqWQSJ5T38+Okw9pUXlrJkwkbEA6BvlRQRGgHlUQ3GsPkxBSf5iLnmde09+r
	WuX1WtNSVr/yM2mFxF3MsriD2I9kk+FRTDGEjMQo+
X-Gm-Gg: AR+sD13MzDa7aR/2QikzrXmnc39cXT1YpIjXSpcXO37yBXAV+YGWLv985UGhnariT0T
	GFieJ7++js40t2P1OjmI5dOO84ppp6J50yiwQZSvwXuO3bMxwgxV1bpuXEaWa34myiY70+UD5ce
	0/cMuEfDJdrgKYrFsIrIVBD1/dtSaRXn9riF+ufDfKYtN0Tic1tPG5+HtmnV0+tFyFHBYkSiQ/0
	ylkfQI7l4TkH83gQEHODIR7nSpm37ZUsOID3bbuOicAehAi3CGZSEAZbdniby5kNGHx8WJuRmJM
	M3OqRlw8Hf7rYLDnzpx96DLxMiLfV18J/uY5PzgE/S8GUhNE0G9W44ijYuPgANI20vj5qOWluBx
	62lMQcf5KtgoUe3HI8EYeLgnDJhfsYCLdXCVzZH5HjW09L1HGb8bQFzZmco1wwsRDPfLcs+2qKd
	1BYnUGrtUmB7FpFpivmNEFLQLGnHSmTV8=
X-Received: by 2002:ac8:5a8f:0:b0:517:8d24:64d8 with SMTP id
 d75a77b69052e-52dd57ac078mr45190801cf.13.1787152545797; Wed, 19 Aug 2026
 08:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143213.57401-1-jhs@mojatatu.com> <CANn89iLM1JT7xeANTFYOxaOKuz1qSmM4yugRDg4y=uFwP7bdEw@mail.gmail.com>
 <CAM0EoMkUXGW0WNV4Y3rLUyJUDxFcmd7knYoF3ynHQWjUXHRTQQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkUXGW0WNV4Y3rLUyJUDxFcmd7knYoF3ynHQWjUXHRTQQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 17:15:33 +0200
X-Gm-Features: AcwNN1XA1mkL2GBkrHiZcLtt-FVG_mEYcasRRO-QpOxG4ex4lu5i4fvUlZsq8wc
Message-ID: <CANn89iJSR0kaRWtg+tkC2dfaOnCsG0TEcS=wS6oPOFuY5f0hjA@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc
 soft lockup
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:58=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 10:52=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Aug 19, 2026 at 4:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > qdisc_get_stab() accepts a user-supplied size table, and
> > > __qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
> > > overhead, the size-table data (u16), and size_log (up to
> > > STAB_SIZE_LOG_MAX).  A crafted stab can therefore set qdisc_pkt_len()
> > > to ~1 GiB for an ordinary skb.  Per-flow deficit schedulers such as
> > > DRR and ETS replenish one quantum per loop iteration; with a tiny
> > > quantum (1) they spin billions of times under the qdisc lock,
> > > producing a soft lockup / RCU stall.
> > >
> > > Cap the final qdisc_pkt_len() to GSO_MAX_SIZE so the size-table
> > > amplification cannot drive deficit schedulers into an unbounded loop.
> > > A legitimate size table (e.g. qfq's overhead 999999999, which is
> > > handled by dropping) is still accepted.
> > >
> > > Conditions to recreate the bug:
> > > - CONFIG_NET_SCHED=3Dy, CONFIG_NET_SCH_DRR=3Dy (or CONFIG_NET_SCH_ETS=
=3Dy).
> > > - Attach a DRR (or ETS) root qdisc with a crafted TCA_STAB that
> > >   amplifies qdisc_pkt_len to ~1 GiB (e.g. size_log=3D15, data=3D[3276=
8]).
> > > - Add a class with a tiny quantum of 1 and send one small packet; the
> > >   deficit loop spins billions of times under the qdisc lock and trips
> > >   the softlockup detector (panic with kernel.softlockup_panic=3D1).
> > > - Reachable as root or from an unprivileged user in a fresh user+net
> > >   namespace (unshare -Urn) with namespace-local CAP_NET_ADMIN.
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Reported-by: vega@nebusec.ai
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > > v1 -> v2
> > >
> > > 1. Sigh. The v1 overhead cap broke the existing qfq tdc test 5993, ca=
ught by
> > >    running the whole tdc.sh instead of affected qdiscs reported repor=
ted by
> > >    poc. That test legitimately uses stab overhead 999999999 qfq and e=
xpects
> > >    the qdisc to be accepted (exit 0) with packets dropped.
> > >
> > > 2. Better Fix: cap the final qdisc_pkt_len() to GSO_MAX_SIZE(524280) =
in
> > >    __qdisc_calculate_pkt_len() per sashikos[1][2] suggestions
> > >
> > > 3. Given existence of tdc 5993 we dont need the tdc test created earl=
ier
> > >    since the essence of that test is covered in tdc 5993.
> > >
> > > [1] https://sashiko.dev/#/patchset/20260818101735.16655-1-jhs@mojatat=
u.com
> > > [2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026081810173=
5.16655-1-jhs@mojatatu.com
> > > ---
> > >  net/sched/sch_api.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > > index 65b35528d125..ad4f117ff55a 100644
> > > --- a/net/sched/sch_api.c
> > > +++ b/net/sched/sch_api.c
> > > @@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *s=
kb,
> > >
> > >         pkt_len <<=3D stab->szopts.size_log;
> > >  out:
> > > -       if (unlikely(pkt_len < 1))
> > > -               pkt_len =3D 1;
> > > +       /* A size table can inflate qdisc_pkt_len() beyond any real p=
acket
> > > +        * (via overhead, the data table, or size_log); cap it so def=
icit
> > > +        * schedulers such as DRR/ETS terminate their refill loops.
> > > +        */
> > > +       pkt_len =3D clamp_t(int, pkt_len, 1, GSO_MAX_SIZE);
> >
> > Yeah, although it is a bit strange to mention GSO_MAX_SIZE in a functio=
n which
> > does not take care of GSO packets.
>
> well... there are many many references to gso under net/sched. What
> dont you like about this specific things?

I just mentioned that __qdisc_calculate_pkt_len() never was updated to
deal with GSO packets.

It assumes packets with a single set of headers.

This is fine, I am sure nobody uses this stuff anymore.
