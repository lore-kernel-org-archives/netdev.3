Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D147ACE9
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947241; cv=pass; b=IQrEJe5vp70+AlUlJG4qryNrYJdSrEwKz0V9/GlqMZBamkDBDEYzpX9OlQPgbd9jfvs2YTCULUJ9r5x98vf1j/y4v49RylkY4YPiX7oUkITaxDhglPxt5xCs9LWj4Hxdxz8RpEIAqVFTzv9XM7W5hYAkQIqA1WRFYwIxJ5WAQKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947241; c=relaxed/simple;
	bh=SdNoYP4kfEK8orMVcUiXp7J4eXyxN8hmPOSUqD1HSFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlS/XzKOcFSvmXvClo1TqfbcCWnu5tOattsExVChDflM43Uip8Yh5VXTNuoFwStiYBZ6qowTyiUAfbvVHzgCylPiyHZgJChtAx1VtgDkvqDB89GCJfzNBad1Gk1jYeYDprVJ6cUA41IKBlL9RXxzHZt6h1jjeSdMdsDhi9SdCVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CdJzmSPn; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdJzmSPn"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1113421a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 09:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785947239; cv=none;
        d=google.com; s=arc-20260327;
        b=AcIvGzcI2kWFSGSZYyrCkfOsz7qTZFSFNoKduj0RWZM4zO9cMguF9/arF0FVB4m5hG
         rMqiokcaM9JwE5Qp2UruyPX1rGEGH5Ypy9JU5n7Q6VScD8ud/FvUk8MeGjHLDX2c9nCz
         zLQ9xyJCXJ+/h2iyKdhYXGCCG94upPr0PdTSbAiNppjZId7xwUQp9u0Z2l/noLsbI9zd
         Upw1dgYWXnEWNCQxRtMRFlAEpO4IzGPRdCKe+SvPNF7seB87fX7TSuP/8pDxR5NpjMhz
         g+BfmNsm+qbGHgfGkMJY344bjXNoJTBKPOmP91YjX/Hk95GcQbCX1g3xVb8pHmRnR/kl
         virw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iCFCFzMiEWF4C2Y6A8wT17S8wnGmqWmDkHPtF1Szg2g=;
        fh=CUL4y2n5JHRW/WQ/+1eo68ofIBCccb/kqJwTWIm2lxI=;
        b=B4lQw3jYdKpDETZJhLi1hKJHzezo9wkBJ4NqZYXoaI6Lz2MsvFYBlq1Av22k3kCTs/
         13cJJmdzOaJP4WLVeHterG2AL1am/0gwIeZGDsrVoUFOwNSuy6hnoen1O2WEQdVRr+M2
         zBGoJSDBTSRwTYfGBQJpLSTG8WlBaxE6m0Sr4um8AzCZRpWmid0vgs7sxPN9vwX62A4Z
         LCevsYMe7v6WZZC76nmcgdaBcuhZMGcg9Ho2gSvNMwCJCaMVs+gNxyYnrTcKRHu58cXD
         x/k13UjDvxSC91VReeHgfY44Dx2/+gBOuth5c+DeafxC+3ZyJhtDnh5TaRIC3/TZeNwt
         xpgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785947239; x=1786552039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iCFCFzMiEWF4C2Y6A8wT17S8wnGmqWmDkHPtF1Szg2g=;
        b=CdJzmSPnUvsVahhSFyUPXvokg1E6P0dZwenloYNUwgXUKgXupamvJEpZLbKOdi1GwS
         g4Gukm0Ccv+Ct2t9bzDUyAswGO1fqM6fwbqWc2aF45xMkbMecuNcQmcn+BJD8Gbklpi+
         427HR5Sl5fD/4ry5a7mWeaRCKGXzkKJ68uhS98EYmG3SUsAKrtPGYGDB9baJy5p8hfnR
         S65yBdxCgQ0orW/IZk7jiPfLZpDlMuKFtBpL6vz5SbD2iYRR79k7JQ9+9RVwSi/RahdD
         +Hs3N922oEeYFvgK+tCCXWmWZLhj7ZwF0mp/KzWmtbicDGWfJ1Rm4dkX1G5Xy63x5dXo
         5jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785947239; x=1786552039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCFCFzMiEWF4C2Y6A8wT17S8wnGmqWmDkHPtF1Szg2g=;
        b=QrgcauzY1iihBDDzvLxys0aY69XAq26/sY4f4TE5uJv4wfHbNwwRymCe+kBR3HA9Ov
         hBMU6q6sE5UPsAXY9m6y37mNmjCSfgroXz/oh164hJNNQSk4Yk7pJ6rcjjHj1qRj8+WZ
         2wuvrGhnZXyogFe4GeseNiztjMPnqGVCSPLwzYkcWtQAALEHj36D5CUBsnlTZMRY775x
         NdnncCrwH4IB53iA1iqjdzdsLD45DYH8JINQ0jIqJUhveWqLOpcUVWEvS0ePxqdXOpkw
         1Rm8FPLpo04sgEPuLpsSwZRWnC1vv67aOrZYhAFIMSvTnc2eHEdgOLa97pXRcZHxpESu
         Qpxw==
X-Forwarded-Encrypted: i=1; AHgh+RrZRiUAt2AfmyWWtmWvFPQhHaJd0/e3XBVWNnXWu6+apo7eEUXmxHrcTI1zGwSqg4fe6M4ZwXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OFMiLxY5Bzqszh9mgmhkChcF7+5yZo4cW3HoSVfnuCye2p4z
	LWbWZ6eNjL7y/BmuDVa3IswDUWfCkAztl2JkoqeyDSYwUaL+9NZM3nx/2SrzGrnn3Dwzcy/jgD9
	02vCrqQK0kRI6L+M5rmeubB0wEAZEmOFdLNxu0YKP
X-Gm-Gg: AR+sD12IzZqd4EK8Fg+vQXWTNDOHUZy1FV+ymCRR2WW6skJaIO+VKX1CIbcloKsLD7O
	AjEPCMXQREaZ5bkqzhxbRhOTFywXbPeqVeqLyegRsa1UZOUKqXuZUedAOvSPsrLMe55IcmfCiZl
	hgsH3AoezanoAMXFM8jN4oOG5yO9L+mMRPFlPIjrS1e+tYq5FCLTM7EUuQhNPmTjJ1Cq2xRkAv8
	2YoXAyEsKkEi8Az2fTzkArutm4YBp2GeKqMbWAuXVvUw6P1aRfRCM0tWDV4m2gMBoadAhEFnx8b
	M3VsBJl4tS3Vt4kY4acvyCSIO2nEo/5QUkLvgTKGIYsqAX2v7yBhNwDE++gk68e+2QT730boz4D
	B+RO7i4TMnIYwbzeyQI03Ewm7AdiZMo3JHanSyiNaDtcqsCoQCHUOj19cYq8fmoOo/3fEz1p4Rd
	ozKrWZfo3zbLwQr/ejdSLnGQ==
X-Received: by 2002:a17:90b:1d02:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-3903c599356mr8358635a91.2.1785947237778; Wed, 05 Aug 2026
 09:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl> <20260802151212.3294591-4-jkoolstra@xs4all.nl>
 <CAAVpQUCo0r+DDRJ9BT1_2JYmPcsUNnk6aS+oqPvOrO9ruCPUKw@mail.gmail.com> <728282285.265641.1785924552245@kpc.webmail.kpnmail.nl>
In-Reply-To: <728282285.265641.1785924552245@kpc.webmail.kpnmail.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 5 Aug 2026 09:27:04 -0700
X-Gm-Features: AUfX_mxhQohYzWGfA7Lqq8SfvJ6zGLNz0BQh7tQjxZv2kLYVFkg8ueyPbUMcRU4
Message-ID: <CAAVpQUAeNx-_tn7DX8Ah35zv6nzHruSxHcujqSY3r4xS6shcoA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 3:09=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
>
> > Op 04-08-2026 19:16 CEST schreef Kuniyuki Iwashima <kuniyu@google.com>:
> >
> >
> > On Sun, Aug 2, 2026 at 8:11=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.=
nl> wrote:
> > >
> > > Right now if some LSM such as Smack denies an AF_UNIX socket peer to
> > > receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short a=
t
> > > that point, and MSG_CTRUNC is set on return of recvmsg(). This is
> > > highly problematic behaviour, because it leaves the receiver
> > > wondering what happened. As per man page MSG_CTRUNC is supposed to
> > > indicate that the control buffer was sized too short, but suddenly
> > > a permission error might result in the exact same flag being set.
> > > Moreover, the receiver has no chance to determine how many fds got
> > > originally sent and how many were suppressed.[1]
> > >
> > > Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
> > > handling of LSM denials when receiving SCM_RIGHTS messages: instead o=
f
> > > truncating the message at the first blocked fd, keep every fd slot
> > > and store the LSM errno in the blocked slot. The socket option is
> > > inherited by the child accept() socket if set on the listen() socket.
> > >
> > > [1]: https://github.com/uapi-group/kernel-features#useful-handling-of=
-lsm-denials-on-scm_rights
> > >
> > > Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > ---
> > >  arch/alpha/include/uapi/asm/socket.h  |  2 ++
> > >  arch/mips/include/uapi/asm/socket.h   |  2 ++
> > >  arch/parisc/include/uapi/asm/socket.h |  2 ++
> > >  arch/sparc/include/uapi/asm/socket.h  |  2 ++
> > >  include/net/af_unix.h                 |  1 +
> > >  include/net/scm.h                     | 13 +++------
> > >  include/uapi/asm-generic/socket.h     |  2 ++
> > >  net/compat.c                          |  4 +--
> > >  net/core/scm.c                        | 38 +++++++++++++++++++++++--=
--
> > >  net/unix/af_unix.c                    | 12 ++++++++-
> > >  10 files changed, 61 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/includ=
e/uapi/asm/socket.h
> > > index 5ef57f88df6b..946a5fad2691 100644
> > > --- a/arch/alpha/include/uapi/asm/socket.h
> > > +++ b/arch/alpha/include/uapi/asm/socket.h
> > > @@ -155,6 +155,8 @@
> > >  #define SO_INQ                 84
> > >  #define SCM_INQ                        SO_INQ
> > >
> > > +#define SO_RIGHTS_NOTRUNC      85
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > >  #if __BITS_PER_LONG =3D=3D 64
> > > diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/=
uapi/asm/socket.h
> > > index 72fb1b006da9..f1641dde135f 100644
> > > --- a/arch/mips/include/uapi/asm/socket.h
> > > +++ b/arch/mips/include/uapi/asm/socket.h
> > > @@ -166,6 +166,8 @@
> > >  #define SO_INQ                 84
> > >  #define SCM_INQ                        SO_INQ
> > >
> > > +#define SO_RIGHTS_NOTRUNC      85
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > >  #if __BITS_PER_LONG =3D=3D 64
> > > diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/incl=
ude/uapi/asm/socket.h
> > > index c16ec36dfee6..f3a3815c7dc2 100644
> > > --- a/arch/parisc/include/uapi/asm/socket.h
> > > +++ b/arch/parisc/include/uapi/asm/socket.h
> > > @@ -147,6 +147,8 @@
> > >  #define SO_INQ                 0x4052
> > >  #define SCM_INQ                        SO_INQ
> > >
> > > +#define SO_RIGHTS_NOTRUNC      0x4053
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > >  #if __BITS_PER_LONG =3D=3D 64
> > > diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/includ=
e/uapi/asm/socket.h
> > > index 71befa109e1c..7907f3b1f0ee 100644
> > > --- a/arch/sparc/include/uapi/asm/socket.h
> > > +++ b/arch/sparc/include/uapi/asm/socket.h
> > > @@ -148,6 +148,8 @@
> > >  #define SO_INQ                   0x005d
> > >  #define SCM_INQ                  SO_INQ
> > >
> > > +#define SO_RIGHTS_NOTRUNC        0x005e
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > >
> > > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > > index 34f53dde65ce..bb1b3dee02e8 100644
> > > --- a/include/net/af_unix.h
> > > +++ b/include/net/af_unix.h
> > > @@ -49,6 +49,7 @@ struct unix_sock {
> > >         struct scm_stat         scm_stat;
> > >         int                     inq_len;
> > >         bool                    recvmsg_inq;
> > > +       bool                    scm_rights_notrunc;
> > >  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> > >         struct sk_buff          *oob_skb;
> > >  #endif
> > > diff --git a/include/net/scm.h b/include/net/scm.h
> > > index c52519669349..86ae6bc109ec 100644
> > > --- a/include/net/scm.h
> > > +++ b/include/net/scm.h
> > > @@ -50,8 +50,8 @@ struct scm_cookie {
> > >  #endif
> > >  };
> > >
> > > -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
> > > -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *sc=
m);
> > > +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool=
 notrunc);
> > > +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *sc=
m, bool notrunc);
> > >  int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_c=
ookie *scm);
> > >  void __scm_destroy(struct scm_cookie *scm);
> > >  struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
> > > @@ -107,13 +107,8 @@ void scm_recv(struct socket *sock, struct msghdr=
 *msg,
> > >  void scm_recv_unix(struct socket *sock, struct msghdr *msg,
> > >                    struct scm_cookie *scm, int flags);
> > >
> > > -static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
> > > -                                 unsigned int flags)
> > > -{
> > > -       if (!ufd)
> > > -               return -EFAULT;
> > > -       return receive_fd(f, ufd, flags);
> > > -}
> > > +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int fl=
ags,
> > > +                   bool notrunc);
> > >
> > >  #endif /* __LINUX_NET_SCM_H */
> > >
> > > diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-gen=
eric/socket.h
> > > index 53b5a8c002b1..84ea7b92936e 100644
> > > --- a/include/uapi/asm-generic/socket.h
> > > +++ b/include/uapi/asm-generic/socket.h
> > > @@ -150,6 +150,8 @@
> > >  #define SO_INQ                 84
> > >  #define SCM_INQ                        SO_INQ
> > >
> > > +#define SO_RIGHTS_NOTRUNC      85
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > >  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__I=
LP32__))
> > > diff --git a/net/compat.c b/net/compat.c
> > > index d68cf9c3aad5..6bdf4a2c9077 100644
> > > --- a/net/compat.c
> > > +++ b/net/compat.c
> > > @@ -286,7 +286,7 @@ static int scm_max_fds_compat(struct msghdr *msg)
> > >         return (msg->msg_controllen - sizeof(struct compat_cmsghdr)) =
/ sizeof(int);
> > >  }
> > >
> > > -void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *sc=
m)
> > > +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *sc=
m, bool notrunc)
> > >  {
> > >         struct compat_cmsghdr __user *cm =3D
> > >                 (struct compat_cmsghdr __user *)msg->msg_control_user=
;
> > > @@ -296,7 +296,7 @@ void scm_detach_fds_compat(struct msghdr *msg, st=
ruct scm_cookie *scm)
> > >         int err =3D 0, i;
> > >
> > >         for (i =3D 0; i < fdmax; i++) {
> > > -               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i=
, o_flags);
> > > +               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i=
, o_flags, notrunc);
> > >                 if (err < 0)
> > >                         break;
> > >         }
> > > diff --git a/net/core/scm.c b/net/core/scm.c
> > > index a73b1eb30fd2..f0d44ecdb11f 100644
> > > --- a/net/core/scm.c
> > > +++ b/net/core/scm.c
> > > @@ -351,7 +351,31 @@ static int scm_max_fds(struct msghdr *msg)
> > >         return (msg->msg_controllen - sizeof(struct cmsghdr)) / sizeo=
f(int);
> > >  }
> > >
> > > -void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
> > > +int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int fl=
ags,
> > > +                   bool notrunc)
> > > +{
> > > +       int error;
> > > +
> > > +       if (!ufd)
> > > +               return -EFAULT;
> > > +
> > > +       error =3D security_file_receive(f);
> > > +       if (error)
> > > +               return notrunc ? put_user(error, ufd) : error;
> > > +
> > > +       FD_PREPARE(fdf, flags, get_file(f));
> > > +       if (fdf.err)
> > > +               return fdf.err;
> > > +
> > > +       error =3D put_user(fd_prepare_fd(fdf), ufd);
> > > +       if (error)
> > > +               return error;
> > > +
> > > +       __receive_sock(fd_prepare_file(fdf));
> > > +       return fd_publish(fdf);
> > > +}
> > > +
> > > +void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool=
 notrunc)
> > >  {
> > >         struct cmsghdr __user *cm =3D
> > >                 (__force struct cmsghdr __user *)msg->msg_control_use=
r;
> > > @@ -365,12 +389,12 @@ void scm_detach_fds(struct msghdr *msg, struct =
scm_cookie *scm)
> > >                 return;
> > >
> > >         if (msg->msg_flags & MSG_CMSG_COMPAT) {
> > > -               scm_detach_fds_compat(msg, scm);
> > > +               scm_detach_fds_compat(msg, scm, notrunc);
> > >                 return;
> > >         }
> > >
> > >         for (i =3D 0; i < fdmax; i++) {
> > > -               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i=
, o_flags);
> > > +               err =3D scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i=
, o_flags, notrunc);
> > >                 if (err < 0)
> > >                         break;
> > >         }
> > > @@ -542,8 +566,12 @@ void scm_recv_unix(struct socket *sock, struct m=
sghdr *msg,
> > >         if (!__scm_recv_common(sock->sk, msg, scm, flags))
> > >                 return;
> > >
> > > -       if (scm->fp)
> > > -               scm_detach_fds(msg, scm);
> > > +       if (scm->fp) {
> > > +               struct unix_sock *u;
> > > +
> > > +               u =3D unix_sk(sock->sk);
> > > +               scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notr=
unc));
> > > +       }
> > >
> > >         if (sock->sk->sk_scm_pidfd)
> > >                 scm_pidfd_recv(msg, scm);
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index 51cbf920130d..03ce23a4ebee 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -922,6 +922,7 @@ static bool unix_custom_sockopt(int optname)
> > >  {
> > >         switch (optname) {
> > >         case SO_INQ:
> > > +       case SO_RIGHTS_NOTRUNC:
> > >                 return true;
> > >         default:
> > >                 return false;
> > > @@ -957,6 +958,14 @@ static int unix_setsockopt(struct socket *sock, =
int level, int optname,
> > >
> > >                 WRITE_ONCE(u->recvmsg_inq, val);
> > >                 break;
> > > +
> > > +       case SO_RIGHTS_NOTRUNC:
> > > +               if (val > 1 || val < 0)
> > > +                       return -EINVAL;
> > > +
> > > +               WRITE_ONCE(u->scm_rights_notrunc, val);
> > > +               break;
> > > +
> > >         default:
> > >                 return -ENOPROTOOPT;
> > >         }
> > > @@ -1746,9 +1755,10 @@ static int unix_stream_connect(struct socket *=
sock, struct sockaddr_unsized *uad
> > >         init_peercred(newsk, &peercred);
> > >
> > >         newu =3D unix_sk(newsk);
> > > +       otheru =3D unix_sk(other);
> > >         newu->listener =3D other;
> > > +       newu->scm_rights_notrunc =3D otheru->scm_rights_notrunc;
> >
> > nit: READ_ONCE() is needed here.
> >
>
> Yeah, I was thinking whether to add that or not. We have
>
>         newsk->sk_scm_recv_flags =3D other->sk_scm_recv_flags;
>
> earlier, so without READ_ONCE(), and earlier there is
>
>         unix_state_lock(other);
>
> which should make this assignment safe.

unix_setsockopt() is called without any lock, and unix_state_lock()
does not protect the values, so that's why we need WRITE_ONCE()
and READ_ONCE().

> However, that does not protect necessarily
> against compiler mangling. Then again, we are reading a bool here, so isn=
't this
> a theoretical concern mostly?

Yes, but KCSAN will detect it (and syzbot will complain).


>
> I am happy to change it though (if only to signal intent), but then the a=
ccess to
> sk_scm_recv_flags should also be READ_ONCE(),

This has a bit different context as its actual value, each
sk_scm_XXX in union, is a bit field, so we don't need to care
about any load-tearing even though the writer is under yet another
lock, lock_sock().


> I believe, or it will be needlessly
> confusing why it is there for one access but not the other.
>
> Thanks,
> Jori.
>
> >
> >
> > >         RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
> > > -       otheru =3D unix_sk(other);
> > >
> > >         /* copy address information from listening to new sock
> > >          *
> > > --
> > > 2.55.0
> > >
