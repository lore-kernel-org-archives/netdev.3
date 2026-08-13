Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944504334CE
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636949; cv=pass; b=g8+kW7N3ttxr+z/QbGhta2bA7Vh1PEZVy/TcUUjJD10igQh73lriHvy2yu2kw2GR4e1gE5vZhrlwTH/nskF/K4KPEXC85dOeBrhQCf9ma/mu/7IDP6rQtLoZuK2ZKFmHlvVNGGqAAl60mfGtblPTDW1bqP6dpgwGeEpr4va61p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636949; c=relaxed/simple;
	bh=LusldAFnMmM7qmTqLzufb0PiXGZN6J+G3KeX3R8VdUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLh7F/x4ZweaO2cQnbEiHzx9lw5lDrTFoN5tXPJMHLumKA7xdZVKmZhilhOq5bCN7fHePr6qn0++3mkUVr5zu+3ZqSYG9F2PgjLpZHTDm5l1xGvO8Jk2ehrTII3SvjUbXwxzySsFSBYdo7bwgrzcfXIdcLJCvbPpTwt3gDub/2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diNPgpHK; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diNPgpHK"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c5101a984so28167d50.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786636943; cv=none;
        d=google.com; s=arc-20260327;
        b=ZaI6i9LCNbhvnz7fp829mI1iSvWdW2ql0OSsIO48PBI2Jvn6uVQCrIQKgIqiwMGYZ+
         TISU+pdZ2z4MGSF4d9cvM+f6R1ws+wxYOVeZRd3kR3aZOKYEnQ/l/XYMMF769EQexwMt
         KFFOjpmXFLjjZVEOfyQwGmkQquvwxZsyBfiDAgsZaLUzT6iVen2NDTTkIxz9fBq8bysi
         YySxJjssd6K3eU6So8NuS71NDUCN+4bqzlqfw+0BzzXSoaWBZhOuCwK8aZ2fr9heISG5
         PrwMdRWbCkX84c/3U5xs3pUMj3ICjfSJh0nn5Ngv0c45TsDsluCf4LMdp279bmWwP/bY
         EAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A2OUGiXYwe45Et0RgIZSw2gbnW0JK3sYMCGzqxevUt8=;
        fh=2ImNrpMfCroEX9H5Djt1HKjPYluuWbALpIlydT5Lico=;
        b=Ryqm/0dAEvNauwfo+qcWiygxYsexngLZYmkzLdan1+/JZ/S6uNdTlPHAfgJtVnqn+7
         3nfOMTsjvUx+OW6Ccu2sxaFfwZNBAT0o3g21Eyh4S9tPYCvErvcPI4ddyvC2P4ThfFuW
         b+4QITa0zfU4q2yBX+ZMtktJFPKWu0co7XQDmyRPC1qGUiGyikPjKPLG/43lfWXlnw89
         o+CBGDFB9+NzQAQ+9NYUuZbAhhcW+dDRyANh4cGwsLyA6yE+65sRd7Z5B+wR38twU1f4
         XF+lZJqk4s2Yhpy4czxtdp1wnvOsBKIGRQNWyTjCFZrVrHiJXSqn0VzwiomVBsFiR52T
         OBBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786636943; x=1787241743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A2OUGiXYwe45Et0RgIZSw2gbnW0JK3sYMCGzqxevUt8=;
        b=diNPgpHK8LQi4kRmPkVkGjZq8VBkBWQ/uwaS/FEm53Z3fTDXkpL3k2ooU92hRtSAkC
         AwsFuvcmmo5lzd/O2VCOTuCGLZCHh6lrvR0wf+MTLjbXxw3azhhkCf/uZ1+0HXyN5ZsU
         xdQpwUpqq4IyV1IpNkf7Q201NScoMvf7b5gim/Zax09NG58YFIbQXBjSkCVp/jlS4f9i
         ccIAPyNdIv1GUitC9M5Acx93hoD2pz3pTcXUhJbS0FZN+v5cju3DIeoRcYcBQWUIyPs1
         /4Q0FgR4vZiLptDM5/ZMQRavAa+g3E+nNnjuYj++TenWiRTnz+Fxfk9k0W+AP27IoAaG
         wMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636943; x=1787241743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A2OUGiXYwe45Et0RgIZSw2gbnW0JK3sYMCGzqxevUt8=;
        b=p1g9Os5KRee5IqolAKnDyj+TfvnlLoPCquYjIUkzIjwu8rfv0AfA5wH0yyc2NcmEKW
         bkNeFZJvUwMEqhiJekkw5L/DC5gf8OAFlS5/wG2AjbSEO8LHnpu3wZn0PNAv5NfPlPSd
         QWE9WlH69KkGq1is0XXHwkZ8TqY85IhGsDNe0wY4CyhhK44r2tvRo1Gm65pkUsehGh+R
         n6KTYmWmQrASMzoj01rFzDMWJnnyh8sXUCKkgQMcut9iR2a80ROkYDJRK5he5YCrTR9S
         vrQHqKPEN7iCPnGLuFhNIovHeQPh3d0A9avauwGT7VTiH7W8LDSGtSQ82sJQm80N+HN0
         wqUQ==
X-Gm-Message-State: AOJu0Yzafskz5z4DqJPpKQ+EzbLC7JEsq2ij3rwe//qOUA9eDJF9i9V7
	TTOOv3a5YKHhvAGBRHqVg2A9Biq0bGVxPp2AijQtjn4KV23Smsu7sB7qfSZHS37bpz9RTrIJZo0
	edkvgJeardJIYWxC8f5K0++EihPMyYw4=
X-Gm-Gg: AR+sD13fzFNQ+cdvXpO4txWquXh7L5LNQo65u8V9EMTkZ4pVFhBNBLj1/Fzks/esJ7h
	m0mwdXw+fbTyY2AlxAJBmzo4W68VYW7S82K0fwo1Pn9D4MHUM4UNBZNS+nVv7sDR7VDSqG7hIQT
	Ux7IfkzFCsE7MCUadjjN+pqJK6JhBvKuYqt1cKTGITE4MXhVuy28jL6jWImoCjaFssJSQ2EEeph
	Dc6nQyZvNlpiEG3uqn9hIzM35GSH06QsvTHzY0cw5X9WY4eD+dLU8UoPl0awjHJL3Whdz0dWjxK
	tvbMQzAAQWmn6yLa1WYKSpM5NF7XHnVcRnd/JxeuvxUx61jOLn+q1diDx4BBx1vDoES1SAya8DY
	AgS8=
X-Received: by 2002:a53:be48:0:b0:667:e855:ecdb with SMTP id
 956f58d0204a3-66c513971e6mr2265789d50.3.1786636943248; Thu, 13 Aug 2026
 09:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
 <20260813020529.3506539-3-willemdebruijn.kernel@gmail.com> <CANn89iK6O7ujR9zCJzd04MNLQoDi3mA+HWsR-hgQWYzLS3gZfw@mail.gmail.com>
In-Reply-To: <CANn89iK6O7ujR9zCJzd04MNLQoDi3mA+HWsR-hgQWYzLS3gZfw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 13 Aug 2026 12:01:46 -0400
X-Gm-Features: AUfX_mwe3KsOCtK2kwJHRwRiyY5LMJu_yXXTJfeV4k6pqF7aeXCVir53D-mYyuo
Message-ID: <CAF=yD-+Apef70K8n_=R5s5-+dyhYdiTLs1zACEr3=--_A47EeA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/6] net_sched: sch_fq: clear past skb->tstamp
 if offloading pacing
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 1:13=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Aug 13, 2026 at 4:05=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > From: Willem de Bruijn <willemb@google.com>
> >
> > When hardware offload is enabled, FQ will forward packets to the
> > netdevice for pacing. The device has to test that skb->tstamp is
> > in the future.
> >
> > Avoid this cost for packets whose txtime has already passed, by
> > clearing skb->tstamp.
> >
> > Also clear slightly into the future, for EDT timestamps that are
> > so close to now that they fall within a reasonable normal Tx
> > latency. This slack is set to 400 nsec.
> >
> > Also disable timer drift logic when offload is enabled, because
> > time_next_packet can exceed now causing a negative value.
> >
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> >
> > ---
>
> > @@ -828,11 +837,16 @@ static struct sk_buff *fq_dequeue(struct Qdisc *s=
ch)
> >                  * f->time_next_packet was set when prior packet was se=
nt,
> >                  * and current time (@now) can be too late by tens of u=
s.
> >                  */
> > -               if (f->time_next_packet)
> > +               if (f->time_next_packet && f->time_next_packet < now)
> >                         len -=3D min(len/2, now - f->time_next_packet);
>
> IMO this part deserves a patch on its own.
>
> Using a variable adds no cost (compiler will generate the same code),
> but helps to understand what is going on?
>
> commit e51f3936aba0e5887cf5884b18ffa769dcb38523
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Wed Jul 1 08:33:38 2026 +0000
>
>     net_sched: sch_fq: fix pacing delay underflow with pacing offload
>
>     When pacing offload is enabled (q->offload_horizon > 0),
>     FQ can dequeue packets early (now < f->time_next_packet).
>
>     In this case, the drift calculation (now - f->time_next_packet)
>     underflows to a large unsigned value.
>
>     min(len/2, now - f->time_next_packet) then evaluates to len/2,
>     incorrectly halving the pacing delay for the next packet.
>
>     Fix this by only applying drift compensation when now > f->time_next_=
packet.
>
>     This bug was triggered when flow_max_rate was set on the qdisc
>     or for non EDT packets (packets with a zero skb->tstamp).
>
>     Fixes: f26080d47007 ("net_sched: sch_fq: add the ability to offload p=
acing")
>     Reported-by: Willem de Bruijn <willemb@google.com>
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 7cae082a984721215b17fea2d094095155580dcb..f2a65a7a928d5838547285921=
ce0b42c99a96ef4
> 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -828,8 +828,12 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>                  * f->time_next_packet was set when prior packet was sent=
,
>                  * and current time (@now) can be too late by tens of us.
>                  */
> -               if (f->time_next_packet)
> -                       len -=3D min(len/2, now - f->time_next_packet);
> +               if (f->time_next_packet) {
> +                       s64 drift =3D now - f->time_next_packet;
> +
> +                       if (drift > 0)
> +                               len -=3D min_t(u64, len/2, drift);
> +               }
>                 f->time_next_packet =3D now + len;
>         }
>  out:

Sounds good. Indeed clearer as an independent patch with its own
commit explanation.

Do you want to send that separately now?

Else I will add it to the series. But that is likely to slip to the
next release, as the current revision conflicts with other idpf
changes queued for net.
