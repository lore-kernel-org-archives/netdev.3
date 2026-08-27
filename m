Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FE478E2B
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840379; cv=pass; b=hTVISVYyS25/CvLn94Qz/7cfna+lOT/1aEPpcHZ0KKuCJ7CnmcOePPaP8jrntYviymNUs3tcAlvQcuQhUujH3ISmm2u2fV6g9KacGy3pHvK8T7IrIJnDFqdYQD065ouhQupUs2cfoZ746g5FlWuz8/73k9RRTgAyv3vBU07JKqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840379; c=relaxed/simple;
	bh=QtxNEICUuVV2reThy90iPgzc7cB3MRqI07zvy61G5KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsxnW19YPGOV6yvhrU6ZgtGUBQwa7W+2me539HfWXtq8RsogZp/+vhN8wZt7V5Z4enoqbdHjMBRX1c+YTtK3N5fA2NcTYd8FNmIfd03GmBmP1RyWrkboMkf2J9Ff1bflRssnzRkp2Vn+2P87a4BKsDlW1tbaPjorVv6T5Oo2pQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXb+Aa/E; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXb+Aa/E"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-85377c8bc96so2179957b3a.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787840374; cv=none;
        d=google.com; s=arc-20260327;
        b=hvIB9kYEiPwQS9U80ESYPsjB+kEM9ovmDZq4rQz7rpfbfBrXX1sdcMdb1uS1PT29SH
         tF973QZ1hPqG/hUR5elo+DsuwmNzU/pMLeUe7hyowonspWHm9+7cyOKXVtJmV7JnYNrW
         CtSF5FoYofJbg5z+EcGAiCaIvP4nYTc3ayrz21t0s8g7dWaS9mpAuC2cayb463CsFzuP
         Hv+cF6YsTnopxg61ZnmLVwJcr41Ar8MJXnOxB4ePIvNQ/jPkQTU8MBiT4IkOVoU/ptmK
         kdDWNH4nwUAWvUp1VoyKRd1nVHuvOOiIX0KeGKxt/XBUKuX1Z+RbdKQsm1ZK6S/at2Ie
         6A8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4d/vcw+yA61mLR5Pt1YmaCECp8LcVjEoxXcC2sGDmY=;
        fh=Sa9EmvbQXqDmvkWxxxFxf2+DZzroxYaDUr3QBJV5fyU=;
        b=LHdKsaArEaIh1psXf8LGnDrjVSzNY23am0W+mnaLuDXVjkrcLaMrFWAr9uUqccBCly
         HTnYdOvrWd8/yIlcrSvg1dpAN6EwCXFg9jp7Boip+m+r/rhAuz0Lczp1lfmHx0ZfqPF9
         2evXUDnFsqtewcVkHhZ7nNh8UPi9zcrw9HVPkAnL8DUDMKuxwx6v0BCmLAPzh34V28RN
         upbQYs5gf79i+domvj6RkTetn0s46OI+DvITJxgKJqK79jNXYiiNHTIOG5xFRnGEIJsp
         paJEcrFSC/gFn4Th+Kf9nwHww2lELQTzs9LAN3t71xeLLZjeg7tLtnWa7TH1snI74MJs
         QQ1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787840374; x=1788445174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h4d/vcw+yA61mLR5Pt1YmaCECp8LcVjEoxXcC2sGDmY=;
        b=dXb+Aa/EPMm9wmzDkua7QBv/9qOL3GyKrZV6gpnroPrYtnl6gsoEgonTrE5iqcxyF1
         jW7+ZtFE9ndbZJBX6F5tzdVgqSgWFEsUIeMRHLkdcAP9udf3jVTldVYM11WxSYPObtW2
         6DHWt7paaoSEozueeepV0T5QNKlf+fspp7PKcWfWkW6T74c9s2HLm4RnwJ6LFF9AacCB
         EQdjjDuRCzGUDjhKuuFcTJyRlBhrOTRcyfFS7Q9mf+7rGUcB0o3IQ2/Htq4XV136/PmM
         vfGG7Ottj66p6uCeOfkWm5tq2FcuI4017aSLfx+NIw27MLoUzXZcMqtlXEBmtinFjpyW
         fC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787840374; x=1788445174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4d/vcw+yA61mLR5Pt1YmaCECp8LcVjEoxXcC2sGDmY=;
        b=Cm4ofeA2r2B5xIWmVpUUtQ6eyN9h90rrqLaMHacvuZg7omkDO673gyFUum6mAVjITE
         GOTl6Pp2JPTTqctjUV9x+Rjp6X6yggZSJUdy3pivE0a3br0fqm7K7zuauu1L6A525P4I
         nkrpeYSY9Fy8/2gdILCyu6RzVFYOi7YolPGRTGBLcOGtBubgjuew5YYbURVwpwmb7XUp
         BRJQDKmics1tZ3fa71iRMUMpGWdxyxlbyMpbOKn21HUFbpqqKEXBro3FLWaIk82lM+5e
         aSlH1pNbQrtWdb2DrjtLNyS83v65eEywPGXmdvlPPfOsUk6E13ppUx3cCBEKJuu1MAS6
         CeVw==
X-Gm-Message-State: AFuF++k/i7Yx78D6E7TXGLdHrCj0LkMZ94X3Xb4YHQTGRpes7kwuB2bi
	eSQ9H6VnkWyUzbLO6eei3dOYqfNko1j985YcEXHhRQ/nawIUWshmll5ap7VsNHJ1a7wNtHUof+p
	HieyDJIxL56mi55/zvNmAtKep/gmGsf4=
X-Gm-Gg: AR+sD123SXrP779Cxu3Jw/H/zICpwz4xx5pRf5NDArtWHOIlty+tq9q2NB6gKh3Olo4
	krB7DDP3Kw3bKm4Znp0/QSk7+pFd5AVZgY7+USF0Y+e50n/suFke/3mXnmjbx4Uvr+o0jvVZIXW
	wJTGFdQMtHTgOKIB7T6pjPPQWFYI2ya8NAM/izDwkroprp9rKKPvZpWGws5s4w1M/ZTvyWo5fPn
	qV+bPTgLcUDVDLvP9f4bW9CxW7tBik6ojyP3LDTHgrdGHiAFDMjN9swRnUWk0aJjLoNmM38/W4M
	Wt4gwwm4wQRCh3UdVowrAcDEWi1Ljaehzg5hn/So8TrPk9qbhBaT4xhfP96hFW6ilQp31/Ft49L
	OmRq4uGccyUUNsV5xwZIS81OhKij9Lhww0IF7Civ/2kCYj3aqlNT4YbQ=
X-Received: by 2002:a05:6a00:950a:b0:851:bf92:34c9 with SMTP id
 d2e1a72fcca58-85373eb97d7mr24687161b3a.9.1787840374212; Thu, 27 Aug 2026
 07:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9d8f1b5c50329d5ea7c642128d35681abaa9ed20.1787773744.git.lucien.xin@gmail.com>
 <20260827102735.4fa9a5f3@pumpkin>
In-Reply-To: <20260827102735.4fa9a5f3@pumpkin>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 27 Aug 2026 10:19:22 -0400
X-Gm-Features: AcwNN1UANhyaulJdVsY59prG875XDb6OWfc-w6zafGOQOQaIyiyqPi412UfruUc
Message-ID: <CADvbK_cmjQ_B=P2Ahm=xLNTmtAi-RvR8ugFrjqz8pranK4c0HA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START
To: David Laight <david.laight.linux@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:27=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 26 Aug 2026 15:49:04 -0400
> Xin Long <lucien.xin@gmail.com> wrote:
>
> > The SCTP_CMD_TIMER_START handler checks timer_pending() before calling
> > timer_reduce(). The timer can expire and detach between these operation=
s,
> > causing timer_reduce() to rearm the timer without taking the associatio=
n
> > reference required for the newly armed timer.
> >
> > The timer callback later unconditionally drops its association referenc=
e,
> > which can leave the association reference count unbalanced and result i=
n
> > use-after-free during association teardown.
> >
> > Use the return value of timer_reduce() to determine whether the timer w=
as
> > actually armed. Take the association reference only when timer_reduce()
> > successfully starts a new timer, closing the race between checking the
> > timer state and rearming it.
> >
> > This issue was reported by Nico Yip (@_cyeaa_) working with TrendAI Zer=
o
> > Day Initiative.
> >
> > Fixes: 20a785aa52c8 ("sctp: Don't add the shutdown timer if its already=
 been added")
> > Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  net/sctp/sm_sideeffect.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
> > index 94716406d602..0d99b7e8c082 100644
> > --- a/net/sctp/sm_sideeffect.c
> > +++ b/net/sctp/sm_sideeffect.c
> > @@ -1545,17 +1545,8 @@ static int sctp_cmd_interpreter(enum sctp_event_=
type event_type,
> >                       timeout =3D asoc->timeouts[cmd->obj.to];
> >                       BUG_ON(!timeout);
> >
> > -                     /*
> > -                      * SCTP has a hard time with timer starts.  Becau=
se we process
> > -                      * timer starts as side effects, it can be hard t=
o tell if we
> > -                      * have already started a timer or not, which lea=
ds to BUG
> > -                      * halts when we call add_timer. So here, instead=
 of just starting
> > -                      * a timer, if the timer is already started, and =
just mod
> > -                      * the timer with the shorter of the two expirati=
on times
> > -                      */
> > -                     if (!timer_pending(timer))
> > +                     if (!timer_reduce(timer, jiffies + timeout))
> >                               sctp_association_hold(asoc);
> > -                     timer_reduce(timer, jiffies + timeout);
>
> Doesn't that just add a different timing window?
> If the timer expires before the hold() it will release the reference the
> calling code owns.
Yes, but I think it will be harmless, since this path holds the sock lock,
and the timer handler will restart the timer and take another reference to
the asoc before releasing it in sctp_generate_timeout_event().

I've seen similar behavior in the SCTP_CMD_TIMER_RESTART case, so I would
keep it consistent with that for now.

Thanks.

> So you either need:
>                         sctp_association_hold(asoc);
>                         if (timer_reduce(timer, jiffies + timeout))
>                                 sctp_association_release(asoc);
> or to hold two references across all the code.
>
> David
>
> >                       break;
> >
> >               case SCTP_CMD_TIMER_RESTART:
>
