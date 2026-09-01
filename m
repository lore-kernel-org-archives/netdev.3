Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0E412BF1
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275205; cv=pass; b=oHLldwHavZgDSI9IAG47iKILTBlpmOU6uMUXb+XJNVVdJiqO43anw/Djcb6T4VDLqIC/HcRTWXrPuM0IkkuJmzhT72nR+oLLVOkFE0JK4ElOvEiNEZhOfdHC9QrJ4IctZYc8+8MMRUPk+OBhueE2O5Ky/gy1GAp9j4sCuENih0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275205; c=relaxed/simple;
	bh=4+HIZ4Q5IIrpnindsFnWn35HmY9FmNfg/yZtpPmaAQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbSF0wnsqEiECi1b/s1X7V4lj+5Roy88XSGIt9ccaNYPoEUO9F5E1mjigVV9QCpCzT+lL/caygXJbJxWSA+bn/VY7dx7U9Qwntnzrp11aVn1ZINd0e0Ds57gixni872APH2LXLDgMtwUjdq+BYWMQS4u3UpM1LHKt+mBWBrzIkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY2Abr0o; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY2Abr0o"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-851cbd64814so2425872b3a.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788275203; cv=none;
        d=google.com; s=arc-20260327;
        b=latwncUu4VONYCv18wMOWI8uRl2xsgGGDwhqoxmJyQw10+2XHZEOIVhzES9SAKJuhv
         rhgLyRN5X8TFiVUUt5ZBKZMG2GRVzra5Ui+ntjvSply37WBkRcL2x1vxk5vmqGsZJh/B
         ZClrgEbtVyM5ds7WVE+Sw7C4IgI/tfkEvAjPyQT7ef1iDBYwu+3DZH4+3eKrilOl5oh5
         9PWctzdSPE2n0wgmplTkHYEXqwfvKOVJ/BJNJAqDeHQHWl1NSaEiE9QoIjnuYM4WS9Ru
         nWEbWSFfBxhZgWcgmQwPI1UujhJYemmgv6jj9iVKizujRccfRWg9urv3cfJdn9ysR5v+
         L8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5uGLU8oCfbV8VIHqIo2ClQTYY5+lTlorDlDnLTyOTzY=;
        fh=1p6QMqUqFAnQ6Yi9036ou4SHMaX6kUndTMfruuKs/9w=;
        b=d0DgGeI1n4+6UdPGrxaW9WTsypVqJDzDr+csyQlPPG8ZTWvQ7+9Ah0cM9MsbZ8loIe
         D6+UoZ3NHDaIUGAQcmUCIDQL6/XOcl1ZMQxryOINNBhPDkhro1DYFYPMvOkJbcSYrmJT
         1tlYsboif7sQz0pjf+XfL9KDBrGOh44a+ZJS+ELRg5ocRz9njLa246PCPjUSa3blS00d
         VoYfKpO8r6ZpRJvPcLAez5Vl6d68XGMFqSehirPUpsfpQppWFgbDu1Q5Jb3QeSLt2rJA
         XIGZw4klXwKvZgmAnasN7cqAo9WUUnOQtZWQW+GyTGA3kbbBnjRiD9HZXkUjK5IKxUMX
         hiMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788275203; x=1788880003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5uGLU8oCfbV8VIHqIo2ClQTYY5+lTlorDlDnLTyOTzY=;
        b=TY2Abr0oQout+xARnahnvunuRPGpdGWoItGL/AvegbvEOWMuvEODSewe4nwRgoZpia
         94FYxkhKX06v6x8jzko0+9MBTPZ0zhZgGYk4qDBJKBrxvaF1TdsTOfV6JtWJ3flI3zRr
         NyDnHVegkDOgLnKuj8WPzSgad4PqW6msi4JO7lc2EVOa6s3XGLFuDvIa71bVSl3pSaI2
         Dm8geBAE0JAXt488GA3daN8tJ2ET6ZcTPQsDBtySXVl7/Ugq89TIExsbLG2BlqU1FJTe
         V7ZuM6wepKCsrrL/z4+5dxA0YP3TKCYVV47fI4jhGN2sQpy6WRh2wv0F2dIOF3DxPqQ6
         OJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275203; x=1788880003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5uGLU8oCfbV8VIHqIo2ClQTYY5+lTlorDlDnLTyOTzY=;
        b=A+3Q6pl8C34smjgxGoJWssfPZL1qAmjrsLTacc9+Yyl2Wge49ypRBj1PbJXWTfxknS
         9JVk97aQNX40K8FT8egf4KYuF98LM8z6wLnn7LWOVooKefabi1ATjz4j7B12L3u1IUli
         SG6bH/QiwhfW2hi7YBp4Cu0LZgnT5W3RpRBt2ZgFKLPp6dW2xL5oMfn3drhym7dDOvrv
         FFYyrzkf50iW6hAJceeAxH72cWCKmjbrKHZByt9gAQlroYcMailti+n8SLHcs35WvMLg
         Ogfq8gMWAGz4izo3eorhahPflwewbesbcVwcdWa9EhbMpHzQDPNdRU2GoP7PPbl4FkKS
         NKdw==
X-Forwarded-Encrypted: i=1; AHgh+Rpln94bnv4EriZb6sl9UqP4HSqNB0yDfHkyO3MjfK5WKjWms6F4DTudU0jiHBd3ij0l5MExhTo=@vger.kernel.org
X-Gm-Message-State: AFuF++lbgv7xzNkU5LYhxMHDmxlp5Y0I8N8hAW9L7OaWLqHgDa54Uze0
	sxuxLciLeGoa5YZmy6Q8zOHSgQ2XzQrRiFXO/YMH8AScuYgbL7vJfSQfRCJYnxhrq2RnOtlfjpR
	GZ9+c4Z4DFgVZ7Xa4uPXYVqggjbCNZDYMtCMR
X-Gm-Gg: AR+sD13LtHr3twR3UM3GdeOarLnI5bXu38+Y7N7NNN3PoilAYfNBGc6mcqxYWrGdD1A
	uPsT0+D5p5nv7C2hY3dQLUNW3TBzuM7YSYsn9n5BW8bHgydpEPeWcthYrSXC9nvK28YMoyk3iue
	8IJACjO+VN1YUxcAJs+y3ChQ9IsAoTkCola3WKdYr1Wg+QQE843IW7EtLznMp/2XzUftz3sJBMQ
	xg2dpo5rP46x1iuvcY5194s7efiIpWIZSkFoQxz7/DAnl3DIQY9ifuKUsbhgChgFeLaHAElmWeW
	lfZqYnj0NSGNVUlPYhrCwXujnZRCoDsmLX4JQGNwaZOvcLPwJGAG75kkGS1XzWSceSdFrbrmdF4
	OVTe+NiRnJUqbEGgmzNx1Jtfmnb8324c8eAyMu6Qz4GSQ
X-Received: by 2002:a05:6a00:1143:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-8562a1f7635mr48366362b3a.7.1788275202771; Tue, 01 Sep 2026
 08:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a7d8773.c5ad36c8.12f49d.002e.GAE@google.com> <68cb4941-3668-44f1-a889-6b2f023b2a08@h-partners.com>
 <CADvbK_eY4S1HbdNHuNq9b=Va-TA_6rNFvnCvtOUZ0sF-AWN67A@mail.gmail.com> <20260901153524.3e92df3a@pumpkin>
In-Reply-To: <20260901153524.3e92df3a@pumpkin>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 1 Sep 2026 11:06:31 -0400
X-Gm-Features: AcwNN1U9hNLddzkdHknmS9iBL9g_3nFvkL-mCp26Qy2kZ2_LJCi6sU3R5oK_nX8
Message-ID: <CADvbK_esKpvPWK0xipKeiDr6KDiAL2_uPOhrREOMMVjJ_ndK7A@mail.gmail.com>
Subject: Re: [syzbot] [sctp?] WARNING: refcount bug in sctp_transport_put (6)
To: David Laight <david.laight.linux@gmail.com>
Cc: xietangxin <xietangxin@h-partners.com>, 
	syzbot+80dfcb1a2235b3efc877@syzkaller.appspotmail.com, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, marcelo.leitner@gmail.com, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, gaoxingwang <gaoxingwang1@huawei.com>, 
	huyizhen2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:35=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 1 Sep 2026 09:45:42 -0400
> Xin Long <lucien.xin@gmail.com> wrote:
>
> > On Mon, Aug 31, 2026 at 11:47=E2=80=AFPM xietangxin <xietangxin@h-partn=
ers.com> wrote:
> > >
> > > Hi,
> > >
> > > I have analyzed this issue and successfully reproduced locally.
> > > The race occurs between the timer callback (`sctp_generate_heartbeat_=
event`) and
> > > the transport cleanup path (`sctp_transport_free`):
> > >
> > > Task 1(Timer Softirq)               Task 2(sctp_transport_free)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D              =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > sctp_generate_heartbeat_event()
> > >   refcnt =3D 2
> > >
> > >   bh_lock_sock(sk)
> > >   sock_owned_by_user(sk)
> > >   mod_timer(&hb_timer) -> returns 0
> > >                                           sctp_transport_free()
> > >                                             transport->dead =3D 1
> > >                                             del_timer(&hb_timer) -> r=
eturns 1!
> > >                                               sctp_transport_put() (2=
 -> 1)
> > >                                             sctp_transport_put() (1 -=
> 0)
> > >                                               sctp_transport_destroy(=
)
> > >
> > >   sctp_transport_hold()
> > >     -> refcnt is 0, increment fails
> >
> > This should not be 0, as the transport must hold a refcnt to start the
> > hb_timer.
>
> Isn't there one hold sctp_generate_heartbeat_event() and a second for
> whatever 'task 2' is doing.
Right,

> When hb_timer is started it is given another hold (does it actually need =
one??).
You mean mod_timer() in sctp_generate_heartbeat_event()?  Yes, as it will
release the last one in out_unlock, it must hold a new one.

> So when hb_timer is deleted it's hold is removed.
> But the del_timer() is happening before the the extra hold is obtained.
>
Ahh, I can see the race now.

I remember you mentioned holding it before mod_reduce() in a previous
patch, maybe it will work here, like:

                sctp_transport_hold(transport);
                if (mod_timer(&transport->hb_timer, jiffies + (HZ/20)))
                        sctp_transport_put(transport);

Does it make sense?

Thanks.

> The RHS (task 2) would need to hold bh_lock_sock().
>
> Try giving sctp_generate_heartbeat_event() two holds.
>
> David
>
>
> >
> > Also, the delay below is under bh_lock_sock(), so it should not be the
> > real cause of the issue.
> >
> > Could you share the PoC for this issue?
> >
> > Thanks.
> >
> > >   out_unlock:
> > >     sctp_transport_put() (0 -> -1)
> > >     -> refcount underflow warning!
> > >
> > >
> > >
> > > Adding a small delay  after `mod_timer()` increases the reproduction =
rate:
> > >
> > > --- a/net/sctp/sm_sideeffect.c
> > > +++ b/net/sctp/sm_sideeffect.c
> > > @@ -373,8 +373,10 @@ void sctp_generate_heartbeat_event(struct timer_=
list *t)
> > >                 pr_debug("%s: sock is busy\n", __func__);
> > >
> > >                 /* Try again later.  */
> > > -               if (!mod_timer(&transport->hb_timer, jiffies + (HZ/20=
)))
> > > +               if (!mod_timer(&transport->hb_timer, jiffies + (HZ/20=
))) {
> > > +                       mdelay(1);
> > >                         sctp_transport_hold(transport);
> > > +               }
> > >                 goto out_unlock;
> > >         }
> > >
> > > Any feedback or guidance would be greatly appreciated.
> > >
> > > --
> > > Best regards,
> > > Tangxin Xie
> > >
> >
>
