Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62552AE78
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538185; cv=pass; b=RKQjVHJ4hShRc5/zQYHHQH+KP2V6FUlb2fafbxmacNeB6dW9G2h2Adh2F60sTUHKGl825DTVQcpkpoAZhXZDXxtum05vVRH10K1iNTL5B+sisYM6mP7YxAYhJ1Hy7/Uvh3FtxdiON+4DoMbfzbPzjPLgDuJ7h1MQ3/Z5S8CG4AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538185; c=relaxed/simple;
	bh=I7FTVNlZ0dogb6C0eOyzR1YPRcNP3XiCf/wTZ1Mslsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4dBTWC5QL3llSfYrw9M/FRNuNt8+ZVY0o1iaZ5/k/jMQqjC/J7g8EDVoCad863vLC2ck7pDCxuc+vwdmZEgzvFuKlwjZgo4xLCgK1jpFk+3VwazQHV9eq2OdP2ScJl/S27NAK4MN0E1GHzDx1CA2baIFnPTbIZstLE1agW7cZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=LYJ24fIU; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="LYJ24fIU"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so1757948a12.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788538181; cv=none;
        d=google.com; s=arc-20260327;
        b=Lyv+Rc69iGt6mSJjX96ztvDAQYwjqYYyA1c9KJnOzIZ8sG+Ez40YWGSorqJcMk5HaF
         NSvKKTBJDMOsfhjQYsI32HnvSw8QALVQaFnJfxbJ4bN1qsNQFQwcHXHXkmmjX7x560g2
         AazYvxaj4LHqwND1RLhrvi07XZLHSzgXF16BH1vajnbhRWx3s3b9Hv9CTxq0dwF10nJ+
         Dm4bGnXwsr+hhKGH+tIruJPQaGvkHoNa85JWVJCSL+bKxin43T+F2VQW7MMA/x5fj7SH
         QEI44r3NQPEjrbC9X4pC5OkftQjXRbdaLEZZsbJAggNXKy3c/ZPdU6d0u2rq8ym/xSj/
         1VLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FdR7pQWFNAy0Ig0AuVAHw6qnwdiJsW6s+mbBPNX+ky4=;
        fh=vq1P5bPMZCI4E4x+qeVZKafpxgZSx9Lj5exMwZh0sF8=;
        b=HaQAc4w9ZXNBwCnuV+Og/qDDoOo7VjSv/Z5AKqIsIOhu6ydm7K1PLAoXLpGbpVMgf3
         Zu3hn/Oz+dejNaLm3be/LZRPSsJ7N7suesK/K6ZXb6aLFiYCicFVnq8sFJRDHVaEE255
         Jvm2qek7uTZ9JYxj1yIs6a95Uhz9HrkOH/sVKTqyl+Jw0RxXK9qJRsph+jyq2RBEkSws
         1vJtefaLDusm2BXxBZVWamWavVdJHoX/loDEGEqRAwCKxPcV1GwHflBlZrtrMZBJNXbT
         TOsW/b/2CqBnV+bRTfu/8ivP8qwxpi5aeX6G5NWpB7tw7ZAlkgPTED1WGwe1YRZOsDFM
         l0Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788538181; x=1789142981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FdR7pQWFNAy0Ig0AuVAHw6qnwdiJsW6s+mbBPNX+ky4=;
        b=LYJ24fIUloVu66b4e55n54uMqyxyA2RjXm5FqIxFGM9Cubpp/LXHdFIqU5drYl5M9W
         RIQgYqmO+v2fUkKSbJwCngOh599KmOsNxRziD2G9pYDSrAjHq7jv3TURKSxKhvMNYdDT
         ZeNjbTgzYZTRtNbY1TAykIPkUFUsV7HHw7ofw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538181; x=1789142981;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FdR7pQWFNAy0Ig0AuVAHw6qnwdiJsW6s+mbBPNX+ky4=;
        b=L7FiReYUPzZCItylRadVIravroezUIgkEafOdYNVO7UNRJQsGOLddIc9D+e4vtPIQe
         m8GRnPlivMNde48r21K6ZCOJ8jaid/iDiMaomHnahoBp27RK/QpukTnO+HZy+E4GzCoL
         rTp2QrJ1IppZ0Qf8TO+jjmV1yjMY43wAQYOJN9i4bbl68EivavqkCecbZhNtjfpghs5f
         lJmYZWpRqlM3YpUJdmL4Eq+7ATwCM0qr+bgi0IV4o21WzvVwIJcuyvXTsHPtN0WCl9oB
         uCOHPXiIlAvd+DkeDfvhCP7tVzSUZjukYc5dsX+6vJGl8QpoWM4cuyCkQkpdE0wv5QI8
         RSAA==
X-Forwarded-Encrypted: i=1; AKwUvBw2Tt5L4kbULWirf5mZRQXi5fs3ePCvO8Hcde+hrzfiX3Ui+xgBxzgni2Rlhgxw3aEcqAFeioY=@vger.kernel.org
X-Gm-Message-State: AFuF++lujYWwO9jSN7hpcyWWCWY1cHUi6H92gnDm6o0fhVC4SFFifNTo
	VjXQbPULh7hX4+sPVBCIMAVKB+HQWJyyNSCkwPUlYfy97FGPVwrw5oo2FiuAjSyWtaqCYakTvq2
	bP1n2/zxOF+zmG+ucXY0DtXSfKJYOeFI79lkeOeBxABkLzOnu5EdXTCY=
X-Gm-Gg: AYBFou3Tw51HZI8bZmvlAJerR/fJAXCFrgLbRz0dWs7RedYek4huwfSqTma/q6QIuZT
	HpKJf31sRQD6NAYBl2/a3smCfdM9fN4mbze0ZZISnjJ5Qan8rr74S+tRWYgkbpQJbJs7NVxRHn4
	ZEX+FG+V3F5qxggSDuff94xsThA9E3c5DK++ISAJbntkCp4Ec/0oNDCKn6RjcrxRwl401Cu0rKG
	gUeH2VINZceTI5FBUOS9xXD+lABw3UrUdlO/yR8h2T8M8Mk65kpYLjU2sCeVctckJIF7qbRtMI7
	FYuavwweoMS404x1qRnHerMvqtSm5ZWGCVDGS93xpVqmrf7EziAoNWh7AAIs7ZCF9qBu3aD/r8Z
	t
X-Received: by 2002:a05:6402:c2d1:b0:6a7:ee54:f8a7 with SMTP id
 4fb4d7f45d1cf-6a7ee550028mr1195731a12.43.1788538180182; Fri, 04 Sep 2026
 09:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904144636.3443342-1-maoyixie.tju@gmail.com> <CANn89iJRG6UbnYX2xo1ZJR4k=Jr+PQEb48qELK9gpKp2QATKyg@mail.gmail.com>
In-Reply-To: <CANn89iJRG6UbnYX2xo1ZJR4k=Jr+PQEb48qELK9gpKp2QATKyg@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 4 Sep 2026 18:09:28 +0200
X-Gm-Features: AcwNN1Xq4Tt7rQDO1svcngvMnokM2FJKtX_ipen5pOVe3abVfNjqkDXYytdImE0
Message-ID: <CAJqdLrqGUQ2YFMAg197OrZaHrYg+-ZDkcA3c+wmZs39uxRz78A@mail.gmail.com>
Subject: Re: [PATCH net] netlink: render SCM_CREDENTIALS pid in the receiver's
 pid namespace
To: Eric Dumazet <edumazet@google.com>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, brauner@kernel.org, 
	adobriyan@openvz.org, akpm@linux-foundation.org, leitao@debian.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Fr., 4. Sept. 2026 um 17:48 Uhr schrieb Eric Dumazet <edumazet@google.co=
m>:
>
> On Fri, Sep 4, 2026 at 4:46=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
> >
> > __scm_recv_common() translates uid and gid into the reader's user
> > namespace but copies the pid as is. AF_UNIX gets away with that because
> > unix_skb_to_scm() re-renders the pid with pid_vnr() at recvmsg time.
> > netlink_sendmsg() renders it in the sender's namespace and stores a bar=
e
> > u32, so a reader in another pid namespace sees a number from a namespac=
e
> > it is not in. The sender chooses that number. An unprivileged sender in=
 a
> > child namespace made the receiver see pid 300.
> >
> > Carry the sender's struct pid in NETLINK_CB and hand it to scm_set_cred=
()
> > in netlink_recvmsg(), the way af_unix does. netlink_skb_set_owner_r()
> > takes the reference and netlink_skb_destructor() drops it. A reader in =
a
> > namespace the sender has no pid in now gets 0, like AF_UNIX.
> >
> > I found this with a CodeQL checker. I used Claude to help write the
> > reproducers. The ones that reproduce the bug run unprivileged and need =
no
> > kernel changes. Tested on net with KASAN and lockdep, no reports. The t=
ree
> > has no netlink SCM selftest.
> >
> > Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to us=
er")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5 codeql
> > Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> > ---
> >  include/linux/netlink.h  |  9 +++++++++
> >  net/netlink/af_netlink.c | 30 ++++++++++++++++++++++++++++--
> >  2 files changed, 37 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> > index 882e9c1b6c1dcc..26266754e27c14 100644
> > --- a/include/linux/netlink.h
> > +++ b/include/linux/netlink.h
> > @@ -30,6 +30,15 @@ struct netlink_skb_parms {
> >         struct sock             *sk;
> >         bool                    nsid_is_set;
> >         int                     nsid;
> > +       /*
> > +        * Sender's struct pid.  netlink_sendmsg() stores a borrowed po=
inter
> > +        * taken from its own scm_cookie.  netlink_skb_set_owner_r() ta=
kes a
> > +        * reference when it takes ownership of the skb for a receiver,=
 and
> > +        * netlink_skb_destructor() drops that reference.  A clone star=
ts out
> > +        * borrowing again, because __skb_clone() clears both skb->sk a=
nd
> > +        * skb->destructor.  NULL for a kernel generated skb.
> > +        */
> > +       struct pid              *pid;
> >  };
> >
> >  #define NETLINK_CB(skb)                (*(struct netlink_skb_parms*)&(=
(skb)->cb))
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index e6b1d9758c9c92..170d90d472a0db 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -379,13 +379,24 @@ static void netlink_skb_destructor(struct sk_buff=
 *skb)
> >
> >                 skb->head =3D NULL;
> >         }
> > -       if (skb->sk !=3D NULL)
> > +       if (skb->sk) {
> > +               /*
> > +                * The reference is held for as long as skb->sk is set,=
 taken
> > +                * in netlink_skb_set_owner_r() and dropped here.  The =
pointer
> > +                * is left in place: do_one_broadcast() orphans an skb =
one
> > +                * listener owned and hands it to the next, which takes=
 its
> > +                * own reference, and the sender's scm_cookie keeps the=
 pid
> > +                * alive across the whole broadcast.
> > +                */
> > +               put_pid(NETLINK_CB(skb).pid);
>

Dear friends,

> I really have a bad feeling about this dance and these assumptions,
> maybe this is just me.

completely agree with Eric.

1. We need to start from use-case here, because netlink sockets are
quite special in many ways.
     If you just found this using LLM and now we are going to change a
behavior that was there for more than 22 years
     ( just look
https://github.com/torvalds/linux/blame/d679c5324d9a87c6295f56c2dea52d5f688=
34f41/include/linux/netlink.h#L165
)
2. If you start tracking struct pid (which is a good idea
theoretically, if we ignore 1.), then we should do it a bit smarter
and
    make use pidfs API [pidfs_register_pid() function] like we do it
in unix_maybe_add_creds() to make sure that we properly support
    dead pidfds too.

Kind regards,
Alex

>
> Please include a dedicated selftest in tools/testing/selftests/net/
> exercising SO_PASSCRED / SCM_CREDENTIALS
> over netlink across PID namespaces to demonstrate the issue and
> validate the proposed changes.
>
> Thanks.
>
> >                 sock_rfree(skb);
> > +       }
> >  }
> >
> >  static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *=
sk)
> >  {
> >         WARN_ON(skb->sk !=3D NULL);
> > +       NETLINK_CB(skb).pid =3D get_pid(NETLINK_CB(skb).pid);
> >         skb->sk =3D sk;
> >         skb->destructor =3D netlink_skb_destructor;
> >         sk_mem_charge(sk, skb->truesize);
> > @@ -1880,6 +1891,13 @@ static int netlink_sendmsg(struct socket *sock, =
struct msghdr *msg, size_t len)
> >         NETLINK_CB(skb).dst_group =3D dst_group;
> >         NETLINK_CB(skb).creds   =3D scm.creds;
> >         NETLINK_CB(skb).flags   =3D netlink_skb_flags;
> > +       /*
> > +        * Borrowed here.  scm_destroy() below drops the scm_cookie's o=
wn
> > +        * reference, and every delivery in between is synchronous, so =
the
> > +        * pointer stays valid until netlink_skb_set_owner_r() takes a
> > +        * reference of its own.
> > +        */
> > +       NETLINK_CB(skb).pid     =3D scm.pid;
> >
> >         err =3D -EFAULT;
> >         if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
> > @@ -1971,7 +1989,15 @@ static int netlink_recvmsg(struct socket *sock, =
struct msghdr *msg, size_t len,
> >                 netlink_cmsg_listen_all_nsid(sk, msg, skb);
> >
> >         memset(&scm, 0, sizeof(scm));
> > -       scm.creds =3D *NETLINK_CREDS(skb);
> > +       /*
> > +        * Render the sender's pid in the reader's pid namespace, the w=
ay
> > +        * unix_skb_to_scm() does through scm_set_cred().  A NULL pid g=
ives 0,
> > +        * so a control block that lost its reference reports "unknown"=
 rather
> > +        * than the sender's own untranslated number.  scm_recv() below=
 drops
> > +        * the reference taken here on both of its paths.
> > +        */
> > +       scm_set_cred(&scm, NETLINK_CB(skb).pid, NETLINK_CREDS(skb)->uid=
,
> > +                    NETLINK_CREDS(skb)->gid);
> >         if (flags & MSG_TRUNC)
> >                 copied =3D data_skb->len;
> >
> > --
> > 2.34.1
> >
