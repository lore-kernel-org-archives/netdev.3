Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB74483A3
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423314; cv=pass; b=aOIIB664hv+zIaagKVoNHhoHDYSJM1ank7AAOiTv0WV1IP74bvBSGT84Nuw3RfaKVTy24OakIu9XaWhBWmzsv+Yz3UjfS5nkvuHRfJGImY381CSBY8MrgnlMy2jYg92Us+XDju9De1p5G3Zi2qCJCuL3joyblkVi/15Di/eVg6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423314; c=relaxed/simple;
	bh=OlQ0YAVC6ujdBBFpljayXmVKSTR3LjTuNS8fAxNdB4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbNBuYc4NtV+Q2iWFYdK9LIsiICn8Q9kWFiKfP/gvXTR/99HqwcG+d+qBpsXghmCdwuurOcz0XdRZSqfk/CR9A+X5n6gX3L8zxyz/ViAuT9nAvlqo4ioJqya5bH8GXoYZKad8IvsHC5zNvJEVLWbudPNanLxSUkEX+PIc3Xbr44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJFJdIQB; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJFJdIQB"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52fa6005224so18230631cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788423311; cv=none;
        d=google.com; s=arc-20260327;
        b=dxVa/GU9zM1VakTzlbJLeHxxk0l05+8sWSLnhpmnayzdJ70nhfOc2d1E+2XObj5heA
         Y9TvSV/siAKk0MOoJyCJ0fZLRUrQLa+v2BCGMm9edYmhrgJ1UV83VdujSuIAyWLDgvGs
         EzwUSeo3wSJWwRyHvFo27lkao+/gN4x0qQgEBOW7qhRrRMPt2Wr7hM8p+IiHescDg7op
         IxyNRtcqgQdBjC9ty0ShdOPOIk5MUK1v4RAfNNnlT15zZSRvED93RW0YM7HKRy5QQFJL
         0jZSw7ZjbS3RtSAZAnRyXmNWXzbFGmr7skDjvyPFnEtdet9fr1egfTVnpbTlfP1GNiD7
         4yDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7KdfSLURFL5msCoh/intCikQgtAh5MxrzCcW7QWmj0w=;
        fh=G/Vf78Ej4cbQLZeZtPXmxwtadvD3+xyK+lDgqt1zCak=;
        b=f2rqvRSwjjm8egwUzAN0w4pkan9dNc5K85Wa6/j9PLb8CciOJXCgI0tZzugDPL54UK
         wNWJHJNDbutqcUnYYx4NuajqTrpenYnvO4KcN7/RSRvsgnpGNzbLJpr1hhXACBGFyw8h
         2xFHffBX8808/VpkBnmKzkG7vDTcYYnNzbFwsydX93aQwRWGYyXKSrd40IHZ8HzGFYBH
         xzQA+mcyLFvUqmXET6UY4m1PicMk/jzIA6U/vGZJOed3u7NOJg4HnefkfXbQy8FunUV0
         MqDs4VkcZfec+OEuiKIT32XxPP2dNGBxva4LPoee3LezBnxcUcimty8DlfMBlyufqodr
         4RYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788423311; x=1789028111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7KdfSLURFL5msCoh/intCikQgtAh5MxrzCcW7QWmj0w=;
        b=SJFJdIQByRJ5Jbqcctl9eDeLipgCswwV5D9CWNRgofsarkfljSbzUmE5Q4uHoGoE5n
         0QWqPGMmQ7stEZ9XPHoH5GTOhiaabS/jk+d6aaQCmBBPOMZHKVEtjbJSV+ExB0sCCkSz
         Mo00ck1XILRS/jfkFbc57JLi9Zad0q9LzmFEd6RG7PkrqXU9lBYwXgpcrbdARS1yog6N
         De4fNWmCuIwlboectm2iHuLAE/DvgSz2Tb5rn7qwr3upRkMf7CJ9UnIvHWLoakqil+sD
         AkfP4OlTSOVHPetoIlsu1oSynfw+I9fZCTAGSod4faXr0OV8cNvCmg88r0zaJbOs8sCt
         5HTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423311; x=1789028111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7KdfSLURFL5msCoh/intCikQgtAh5MxrzCcW7QWmj0w=;
        b=o40sUqXJuhzoNAy1gMRL6ygSwW9YdCA5J5FktM3MsOi5kd9ZsSEs6/YGJ5GogSP9nn
         AXT8QKxcrvUlo11q3m1RMo8Ox9DRPjEJiUDQI9MtOS94uPycRlatKlkrFbnHCPLBxdJb
         P7HmTC+PfL4NPSWMaA2bRPEncvG/JtApxmINrspUuk4hud/NS43Z+WmRHtK40ijxHYU/
         2dXQNVs9mEbhU9rmCHIRcNeVYiV9qmlk0Oj8MJgVVSBToqnkvZCORT2bANzDIowGGpQC
         nSp7QW7tvukeDrP1Oja+C1++Rlwc5HQ1bVdGhwWi8RUe8oudsIJIjeo/3ymDDpbutc3l
         9HQQ==
X-Forwarded-Encrypted: i=1; AKwUvByKNjj2z++p8OSzMIhfu6XwKaTIrhHui7rl/mCR9oM1TIQdIuWhL2kvbq4jtHqFawUww8QtJ1c=@vger.kernel.org
X-Gm-Message-State: AFuF++kVKcDIGiaKiew0cIXIWJicE3TGcjFtFNqxnzM4zESLfyZg9B8r
	KGkG+L5oydNCc7g9C+dkUbs41kIxtc4ymCZ+HCvr7sX9IxRW2ZR3W11XbkXwnY4ejICzLsImZQ8
	52C1PTtolUWfQv0RfD23LsStBED7AoL49n4fhHWNN
X-Gm-Gg: AYBFou3fU5mpfYC+A8ZXdHdXCJLqU++lhA96luVvCuY8NEhCHJU6PYHtUfZAGADe4iO
	MSLo+JEr5LdFRYScebd0jzThwP0QLq3KN2+6G7bOYyt789744JB7c39tzaf9iDL9zJAl3WnMMIs
	Kcdpl4yVAiypDZn0Hho14nJybPwU3sKIqET17BhCoNc3qpeLpX3HJ+WdToAfPAEid25rUFYKUye
	rNxLwHm1+BlRjDObSNkCcpwGlXkJe/3eQ0vqPGiH6mKNzEcOeNBL4XCwWpgupYR7CMvZZQNvQon
	HelTjONvwK16JTDlSlDn1LXCPh8N++8AUwrD+UDEbvxYAkES1A9bn/s6JxInj2UB2SKA++0+OEA
	O6XKv2UhbhgVR3MZTpa2xU3VVOLLGqDMbLcuiBiEUSzyaQ91yvDtehW5ekA==
X-Received: by 2002:a05:622a:303:b0:530:430f:630a with SMTP id
 d75a77b69052e-530430f77d7mr49522131cf.48.1788423310957; Thu, 03 Sep 2026
 01:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901023539.6986-1-zhangcoder@yeah.net> <da990dc8-a7c5-4870-89f0-ad8e7dad0e0a@redhat.com>
In-Reply-To: <da990dc8-a7c5-4870-89f0-ad8e7dad0e0a@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Sep 2026 10:14:59 +0200
X-Gm-Features: AcwNN1WMWij821xOv26UsqrEoLcMh-Z44UxeGO9PCnqsEdYxBlY9DRaWPIqH9qA
Message-ID: <CANn89iLzwR40o3VmPuz+6GD62ndJFMo=gv5cyVEuTYdCmFSutg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: fix mdev comment in tcp_rtt_estimator()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Ziran Zhang <zhangcoder@yeah.net>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 10:08=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/1/26 4:35 AM, Ziran Zhang wrote:
> > The old comment "mdev =3D 3/4 mdev + 1/4 new" only describes the
> > common case. However, when RTT drops sharply, the code applies
> > a finer gain of 1/32 instead of 1/4, resulting in:
> > mdev =3D 31/32 mdev + 1/32 * new.
> >
> > Express both cases with a unified formula using variable
> > gain g.
> >
> > Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
> > ---
> >  net/ipv4/tcp_input.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 0f60a1dbf..2c9feb181 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -1108,7 +1108,10 @@ static void tcp_rtt_estimator(struct sock *sk, l=
ong mrtt_us)
> >               } else {
> >                       m -=3D (tp->mdev_us >> 2);   /* similar update on=
 mdev */
> >               }
> > -             tp->mdev_us +=3D m;               /* mdev =3D 3/4 mdev + =
1/4 new */
> > +             tp->mdev_us +=3D m;               /*
> > +                                              * mdev =3D (1-g)*mdev + =
g*new, g=3D1/4 normally,
> > +                                              * g=3D1/32 on sharp RTT =
drop
> > +                                              */
>
> I'm sorry, I have the feeling the above does not clarify much. Also
> AFAICS it's not a 'sharp' drop but any negative delta.

I agree, this is a 'legacy comment' that should probably stay for one
more century :)
