Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB151DE8AD
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637055; cv=pass; b=DHk899eL4p7VMCAKMxU3p7wybZUznxGJ7eH+3V5N0AqgEZB1oMQw97xdIMun+k8GKcJAgzt8rPrNbEEGSiusOsiIOmHAmVO1yvsa2JsOVNtEjPURQBy0wOyCjOMZk6MVl62oIlL4ilXVREZbDnWN4q4JgQnzZavMc1JgCAFZYXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637055; c=relaxed/simple;
	bh=Vjy16TF3iYfiUMwvlbZBdU1z3tOMwQwKJLy155OPgA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0VW5/18fz22uMT7d0iRKBuH6dP3ay5CT2aTYEVAtbV2vYR1dquw8eUTu/pOPAN/GqVBMMIRE+hZjyoiBD0jXD8Q1b4LwVdHmGpdq6JAj3oZDvjWW6CpZcnOg46h5KlS/bQ9GUva1XKySU2mnDpzVZrHauqwQVEaDFmauzt6AC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/hwbTYA; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/hwbTYA"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-529a1ee0e62so713921cf.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786637053; cv=none;
        d=google.com; s=arc-20260327;
        b=pZE5AEFwhGjq0McunVJJz8Xm1gLTD+c0/RRBPOHAqawiLJy4In3NSfrUwypUXaIkeS
         S3TOpOhsqKG6JaXkMeIz19BGr3iSZyvJ+ONPHTeK7Midkky58Ugu4+SjwNV0beI2RkoU
         7NXzDQ5+qBXGpyurfMTzUHGNh8Jiak6s73mZ1iC7n2b51pjxLb/wG+MUltxeoVeQB3/0
         Wi19u0BqvmsT6/AqX9qF2pi4xRfUYG7QRtI131UW/+GLsvSw6gQcA05H45Lg4LhUXwMT
         99NwcEPjS2xxvIOIpWM9el0Wddyevj1HrHrFdSjkfASlnpa4EMyPC0/dfRrdeF8kJm+c
         Cg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qy/kcyQvveSYr5wHrbyhBZAEI4CKhUnX/Ix6lO1z2p4=;
        fh=zw2Tf0vMtu3hAEFoJbDfCjU/V/Fceeopbv+cwPpkdHc=;
        b=RogIdnvNM2TnUjOaJxpvNUn3Qt+URgal693s8jF6GcqJ5u8ZiKzXaYa+vvCnfAiqLe
         KHyQaev5RAJr4HOeiI48Dt1hdcfObF7dVZaygrGiSi3BS3p8lpzb9Likj3qeIf4Y0XEp
         DGOo1MhFHTzYqav7Nkkcaykft785KkbO7ziOmwFknqHY2fAqLpvYQKOVeJ2HqOURW4k+
         KZpbFWdGBQjeVFHzjfZUTlNQIyMM1yKZr0FFQfN5L7WzwOWKF76jmta9dDbFMUjqZXF4
         BzswqaqrsN3ztJZqdAbmiIWz/anryisZue8K/IDo/YgBOuawY2bposUQkONrmhanhT0L
         FEGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786637053; x=1787241853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qy/kcyQvveSYr5wHrbyhBZAEI4CKhUnX/Ix6lO1z2p4=;
        b=X/hwbTYAT8FXfZgVX9z8Sp7Z7n9tzJMWzTnMr2t5dyuqaQvx1ZN/bhBHH+thrW51NA
         esUSzENLSwTxU7OqUgDB7hvS7m+OXFyRLvTcej8peQbFX863QFmHD6ZN5OfZO7c5mPh3
         pGGNfiumXGxc+RByFLbqC0Dswocxd4cdbIGtD6wF4gX9VWt2KPbpkzwy4/0dIbxq875g
         RksgsVOYDjv0xuahlMKhyR0+ZT+44C547ZfrHJWe+shFnrw3M+dQ/AGrm3IrPm8NYOZV
         /pXUH6i7itqKnvTxVmHG+3hHHdkrQX0gYel5vNQ2CkOPKxFSoBiPx0pkGLN6YCI+UrqZ
         nK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786637053; x=1787241853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qy/kcyQvveSYr5wHrbyhBZAEI4CKhUnX/Ix6lO1z2p4=;
        b=sZRhgFKO1LGvd6NjfRTvnvY/CSDRtz6cTvRDUoyBrhlbrcMTMBvOqfN6VnW6krwezz
         05GPoA9jUoXua3s+Ab74nUJ8V5qhQyc5u7Rx4eKw3JgvGcbD7SGxSKIkxkKCh8QWRmn9
         GUKTLCIrlID2fBOmLXSO0pJHL8R2Dwb/DJI8iGqDlZlPCvv12IYSa9XHr7eprg4GT4W3
         VUJMwAbfrop+KequneGI4Lq+EbA8To/ILDIkdvz+ILn/ogDngUzbUQR4s1QaVcGAfyOa
         FszyxIJUgAsBym51Zk9CzbB4lK+UQ1OuWV/7k0qeeQ+Wc+DhFxf/LhR/9eErjQ3Vn9gp
         V0hg==
X-Gm-Message-State: AOJu0YzLn2HzhgioT728pl4d7twTaIilnzPZr7cHgfGHxpyQsrUh9A2i
	wL/YDwFdmIs9XKoqX1RSY/Z8e0HAHAvWGUH2xk9gamsN4EfS/MwntMVek3+tQB4fzsKRIYfgUWu
	JLOc4ayTe8XrkTn802aHpYuUpORnskQR9hkVRaN/h+/OVuBMa/CXQQyDq
X-Gm-Gg: AR+sD13hapi0eZqG/pKKo/hPwpqJ3Y2lV76rgQChsMxJ6IeIsTNDt7kjX4FG0HcO0U7
	WnTQW3/Ag6oW9N69TF2rjEWoFJoS4XQCF9PI/s4XnXiLUU7SI87THEr6C4KOuOFOMjszEHp1ZCB
	KHYK0L7N18/e/XDPHc5nIQj6+eBzJ1eELAy5vrV0ni7zRR0ylYdf4mqQNP0+fdB/rqoqNukBvt4
	nFxkXG2TbonJbtru6e1cm30JeG86O95BLy8Q4wPm4EisTxmnz0EXsWyatTaRkdeu/RCjMlk2jgJ
	cgsxx4PjX+qX5tewDYr0KBkIiId6xAt1Z2MQdUOO9+Fok2h8o07FhNUFP0csjlNyE09n/6CT0Qc
	+EGVBJFptjAP2DN0qfxV7TEZ9xNleD7xAPP+ppjaY+Ydr0An3lFd8DKvpXRRh7BZRNSih7IWd7/
	LdGiW6uKW4OJ5GhQc=
X-Received: by 2002:ac8:59cb:0:b0:528:3b9b:4f54 with SMTP id
 d75a77b69052e-52d73befa50mr65332581cf.8.1786637052173; Thu, 13 Aug 2026
 09:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
 <20260813020529.3506539-3-willemdebruijn.kernel@gmail.com>
 <CANn89iK6O7ujR9zCJzd04MNLQoDi3mA+HWsR-hgQWYzLS3gZfw@mail.gmail.com> <CAF=yD-+Apef70K8n_=R5s5-+dyhYdiTLs1zACEr3=--_A47EeA@mail.gmail.com>
In-Reply-To: <CAF=yD-+Apef70K8n_=R5s5-+dyhYdiTLs1zACEr3=--_A47EeA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Aug 2026 18:04:00 +0200
X-Gm-Features: AUfX_mwRDWobDF0uukXtIPFdBbxhN8fnEmwjwbt2S0c4NRHkak7k19p-TCMfqT0
Message-ID: <CANn89iLDyr8uiB9dOUzSqsRbawa-xOoD8XcDUz5QYH5K0FoeEA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/6] net_sched: sch_fq: clear past skb->tstamp
 if offloading pacing
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 6:02=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Aug 13, 2026 at 1:13=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Aug 13, 2026 at 4:05=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > When hardware offload is enabled, FQ will forward packets to the
> > > netdevice for pacing. The device has to test that skb->tstamp is
> > > in the future.
> > >
> > > Avoid this cost for packets whose txtime has already passed, by
> > > clearing skb->tstamp.
> > >
> > > Also clear slightly into the future, for EDT timestamps that are
> > > so close to now that they fall within a reasonable normal Tx
> > > latency. This slack is set to 400 nsec.
> > >
> > > Also disable timer drift logic when offload is enabled, because
> > > time_next_packet can exceed now causing a negative value.
> > >
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > >
> > > ---
> >
> > > @@ -828,11 +837,16 @@ static struct sk_buff *fq_dequeue(struct Qdisc =
*sch)
> > >                  * f->time_next_packet was set when prior packet was =
sent,
> > >                  * and current time (@now) can be too late by tens of=
 us.
> > >                  */
> > > -               if (f->time_next_packet)
> > > +               if (f->time_next_packet && f->time_next_packet < now)
> > >                         len -=3D min(len/2, now - f->time_next_packet=
);
> >
> > IMO this part deserves a patch on its own.
> >
> > Using a variable adds no cost (compiler will generate the same code),
> > but helps to understand what is going on?
> >
> > commit e51f3936aba0e5887cf5884b18ffa769dcb38523
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Wed Jul 1 08:33:38 2026 +0000
> >
> >     net_sched: sch_fq: fix pacing delay underflow with pacing offload
> >
> >     When pacing offload is enabled (q->offload_horizon > 0),
> >     FQ can dequeue packets early (now < f->time_next_packet).
> >
> >     In this case, the drift calculation (now - f->time_next_packet)
> >     underflows to a large unsigned value.
> >
> >     min(len/2, now - f->time_next_packet) then evaluates to len/2,
> >     incorrectly halving the pacing delay for the next packet.
> >
> >     Fix this by only applying drift compensation when now > f->time_nex=
t_packet.
> >
> >     This bug was triggered when flow_max_rate was set on the qdisc
> >     or for non EDT packets (packets with a zero skb->tstamp).
> >
> >     Fixes: f26080d47007 ("net_sched: sch_fq: add the ability to offload=
 pacing")
> >     Reported-by: Willem de Bruijn <willemb@google.com>
> >     Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 7cae082a984721215b17fea2d094095155580dcb..f2a65a7a928d58385472859=
21ce0b42c99a96ef4
> > 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -828,8 +828,12 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sc=
h)
> >                  * f->time_next_packet was set when prior packet was se=
nt,
> >                  * and current time (@now) can be too late by tens of u=
s.
> >                  */
> > -               if (f->time_next_packet)
> > -                       len -=3D min(len/2, now - f->time_next_packet);
> > +               if (f->time_next_packet) {
> > +                       s64 drift =3D now - f->time_next_packet;
> > +
> > +                       if (drift > 0)
> > +                               len -=3D min_t(u64, len/2, drift);
> > +               }
> >                 f->time_next_packet =3D now + len;
> >         }
> >  out:
>
> Sounds good. Indeed clearer as an independent patch with its own
> commit explanation.
>
> Do you want to send that separately now?

No, just add it to the series, if a respin is needed.

>
> Else I will add it to the series. But that is likely to slip to the
> next release, as the current revision conflicts with other idpf
> changes queued for net.

No worries, I do not think anyone is using pacing offload yet.

Thanks.
