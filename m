Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9923BB110
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722826; cv=pass; b=Jojwa39BP6ILgJMtwYugdyUieu5J0L+kRVQ+aKZr5htpMStWYt6oB4lC3ApVFYNiyPtdany7bKgc2gqlcLZ02eh7KZTytfEH9scoDA3EpoJ34L056L2IlSbcHVJPBewXaAmUPTL3jFJcQ6861/f7g5j1hSfzBtXjLU1AcyDEFWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722826; c=relaxed/simple;
	bh=P2CfZ/eVooz8ByYMc/X83GhAycu5z9o7K3QZsj854og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wzxipk7JmUjbiuxt8lVKesJ4IKRXkEcI3KoNe/8bx/qQjXEz47U5WxdOZNj3Zxl/FnkouSbRzA9A5c5Mz7T61QZquE0xBCxhtrGdsCe7WVoyp/TN6OhcDm8n0sgCg9Ycip5FHFCuT7tNhj8CAFDwV4LIU7LO9C38jGTaoLf1Mhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=FzuzfCo6; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="FzuzfCo6"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487b7b4066so1056091b3a.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783722823; cv=none;
        d=google.com; s=arc-20260327;
        b=LjET3ZbDoDr0hLdMTZ6PnzdBEeAvO/beJ+xn8zcEzfoEWGPTMZYsclR3qH1X+MBO09
         w2bgq9aFsiDUd7OqWOQlxKmuZKM4LQcUoI7KNmQKQ7k9S4hp3Zh9z+GcC/XDO5IvXUrM
         YClFN1jqvJN1ExzTZfJ1ExdLoQXyBuYxlsPU+1Kd/DecW0fNkiFWodhjRxK/pMhdfzaY
         PH0xdJTgw274say/0zIHgVi1ijrtMXKCNb4980s914zvXCkdfmSnJ5FORFDRahByg0+l
         5gIRfT9teZ5vU5GYk2ip+JRNjdaZKyopoO9/kNq/J4vOwOGnxX0m8/Yn64l5M0epJWXm
         hhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xyKVX/uPhGkx9zXyKF8UrRvoqCkGwrtRinUkfLWvnaE=;
        fh=o3sXkhCzXvUOiP6QQPYcNpcioiJv2ISz/ivZQyfq4gg=;
        b=p3ETSnlAmZzR8K82bC7SMEDJPmxcexUGKz5zoOClUVvbXAdnCbtZJtHuQN5nvEV38b
         hOPSPJyzMcJEOqSLSrKErtXyB1ZNijfUGwXjAEXcuAzfcexj5rSDhl8uL9Wuq5oHGG01
         WZUhM0nH7134ESZHRM7xJOX7YaHj12yaaRcdrqtLTb4XBeF09fpoz5w3kKxx3rMvuz73
         YwQ/faZxYxD2oc7XLJqQdXutuqDZPgF+wHmITebH8EKWSU2YdPF4EfjFpSgkSC78z8a1
         1UkumpdXe8o7pylRpJr5pLcq6sx8umUJJf/0nXfGxcm1IPY9b/ogaSGt5YnWWEa+gV7z
         93Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783722823; x=1784327623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyKVX/uPhGkx9zXyKF8UrRvoqCkGwrtRinUkfLWvnaE=;
        b=FzuzfCo67EgWdapvV0PsTD+8qfTUblpwmqTE7rUgQr6rjHsdVeB3xfzqB171fJHtbZ
         ILHlxjbztGtF2GkH6E2vqrL4m1iIZ9or3XXirhXjewT2rabVrZlIN/oEbpDxV01W2C0f
         qOIlu5dWzFJiAIqifY75QufZX8E0O2seuXhpcPTEtxBIlMMeFHzEzdQC3aSdChUhZ0lg
         DM0QyMXQA8SpsWqD4drTkiCWP4PCj4sIQyoVtMGgDrBqNct5W09eaLDDxMszHcOgqxmp
         8UusduZ0PPLBqdApQg6Qx9tutu3E9jbN8raJGjiBQnRu7sIQb2cjRkkf8/mgkW4pl62k
         NU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783722823; x=1784327623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyKVX/uPhGkx9zXyKF8UrRvoqCkGwrtRinUkfLWvnaE=;
        b=TTCMa+1+wZPZP5R7yPPbNLw6OIQqUEgkiBd0/Z8JR0a+JM7nHotawnNYoEM68QssjS
         8WS7meHWF520JKJiivYb11d0QeezcHNj+VNtXclFmMzARcptC7UhiKnKy3pyUATUWwCB
         iS2vd3upJDL/MFr/OnUkngvyTIoBTkX6aQtCouCRAqvC6KbgEVecxVmBQGjQYVIA8zhd
         BXxPGj2DNc4lRD62EjGA0+Sae1QuGKAp58PySg5ayRt/yX4eq1Q6kWSOHo8FQwO7Q/+h
         pgWMUblr3q+HB5CDIov0TYhY+iiwlL8k16yAb8aeKm5wmLsI8mWV7TfCbz7LTjAjKpYh
         5caw==
X-Forwarded-Encrypted: i=1; AHgh+RqAuUlG+MJSwJTkz9ImXXpS+JbyVhtfKBPovfIYaNaTBo/GnKh5eqdDwppNOcoudHE/+uJYsxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0isNaG2X6WszDIZWAuXA5cNw0cmS9H/Rf/Wqk3wcrpYYSMYD
	QgD5nc6bruRXp7K+BPkelCXDrTXOOzuMbmn7I/P9Wrnq2bGr7yp0n/2lUjtdhOMh1kQR7syBCir
	+468Nm0xywbQVkX7nY4gcmsyliBz0+GXpfkUeJezJ
X-Gm-Gg: AfdE7cm1kVL1DGFTVMFItMba3onxch4LKqXIsXZd9Zi2V0Wi3hlt7cOOiG1kSncjJHV
	XTLF57NnJeWN9tmglaKLr3tDGDSDrfnD4HUL3FtUAPj5jdaXP6+GOIksZgZTqH+wp77elFGf/oT
	33HjDFbv2dDdWozCryQ1kxPao1khpMv9E+t1teewoh+Rpjg2O7TdjR8MxenAvoSTauPFV/RRrw+
	XwwSDDTHpGLcR0n89G1m2UQMwrZdXyZQdmx1RfKCqfHIKsTwDjj+vnrlV91ES0WER+Ek3S3GlQJ
	86CIX1Ehc4NmmpGMfIuJ1Zz/8v9GGNNPDJfhZ8Q=
X-Received: by 2002:a05:6a00:1486:b0:848:77b3:579a with SMTP id
 d2e1a72fcca58-848896098c0mr762210b3a.17.1783722822748; Fri, 10 Jul 2026
 15:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709074459.326345-1-xmei5@asu.edu> <e7c19015d10439cea2ff78e57a93a610c12e52b0.camel@kernel.org>
In-Reply-To: <e7c19015d10439cea2ff78e57a93a610c12e52b0.camel@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 10 Jul 2026 15:33:31 -0700
X-Gm-Features: AVVi8CdSFO9ZEsWQZZfn_huEKkXHjvc00YHbFCenmr4jUMQsH-cbKpDjfXyjcI0
Message-ID: <CAPpSM+QyU8YK1EywyAAjeW7ynYYVHVrDp9JHhUdFh7=-B3hcUw@mail.gmail.com>
Subject: Re: [PATCH net] rds: tcp: hold the net_device across ipv6_chk_addr()
 in rds_tcp_laddr_check()
To: Allison Henderson <achender@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, Ka-Cheong Poon <ka-cheong.poon@oracle.com>, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 9:42=E2=80=AFPM Allison Henderson <achender@kernel.o=
rg> wrote:
>
> On Thu, 2026-07-09 at 00:44 -0700, Xiang Mei wrote:
> > rds_tcp_laddr_check() looks up a scoped IPv6 interface with
> > dev_get_by_index_rcu(), drops the RCU read-side lock, and only then
> > passes the bare struct net_device * into ipv6_chk_addr().
> >
> > dev_get_by_index_rcu() only keeps the device alive within the same RCU
> > read-side section. After rcu_read_unlock(), a concurrent RTM_DELLINK ca=
n
> > free the net_device; ipv6_chk_addr() then dereferences the stale pointe=
r
> > in __ipv6_chk_addr_and_flags() (e.g. l3mdev_master_dev_rcu(dev)), readi=
ng
> > freed memory.
> >
> > Take a reference with dev_hold() before dropping the RCU lock and relea=
se
> > it with dev_put() after ipv6_chk_addr(), so the device cannot be freed
> > while in use. dev_put(NULL) is a no-op, so the scope_id =3D=3D 0 path i=
s
> > unaffected.
> >
> >   BUG: KASAN: slab-use-after-free in __ipv6_chk_addr_and_flags (... net=
/ipv6/addrconf.c:1998)
> >   Read of size 8 at addr ffff8880106ec000 by task exploit/153
> >   Call Trace:
> >    ...
> >    kasan_report (mm/kasan/report.c:595)
> >    __ipv6_chk_addr_and_flags (... net/ipv6/addrconf.c:1998)
> >    ipv6_chk_addr (net/ipv6/addrconf.c:2031 net/ipv6/addrconf.c:1972)
> >    rds_tcp_laddr_check (net/rds/tcp.c:370)
> >    rds_bind (net/rds/bind.c:248)
> >    __sys_bind (net/socket.c:1920)
> >    __x64_sys_bind (net/socket.c:1956)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:63)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >
> > Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation =
to struct in6_addr")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/rds/tcp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> > index a1de114d5e2e..204dcdc33c27 100644
> > --- a/net/rds/tcp.c
> > +++ b/net/rds/tcp.c
> > @@ -363,12 +363,16 @@ int rds_tcp_laddr_check(struct net *net, const st=
ruct in6_addr *addr,
> >                       rcu_read_unlock();
> >                       return -EADDRNOTAVAIL;
> >               }
> > +             dev_hold(dev);
> >               rcu_read_unlock();
> >       }
> >  #if IS_ENABLED(CONFIG_IPV6)
> >       ret =3D ipv6_chk_addr(net, addr, dev, 0);
> > +     dev_put(dev);
> Hi Xiang,
>
> Thanks for working on this.  It looks like this patch generated
> some CI warnings for dev_hold/put that should be addressed:
> https://patchwork.kernel.org/project/netdevbpf/patch/20260709074459.32634=
5-1-xmei5@asu.edu/
>
> Per the comments from include/linux/netdevice.h:4546, netdev_hold/put
> replaced dev_hold/put, which takes a netdevice_tracker pointer.  But I
> think the easier way to do this may be just to widen the rcu locks alread=
y
> in this function.  Just move rcu_read_lock(); above the scope_id check,
> and make sure it's released before any returns.  That should get away fro=
m
> having to use the hold/puts all together.
>
>         rcu_read_lock();
>         if (scope_id !=3D 0) {
>                 dev =3D dev_get_by_index_rcu(net, scope_id);
>                 if (!dev) {
>                         rcu_read_unlock();
>                         return -EADDRNOTAVAIL;
>                 }
>         }
> #if IS_ENABLED(CONFIG_IPV6)
>         ret =3D ipv6_chk_addr(net, addr, dev, 0);
>         if (ret) {
>                 rcu_read_unlock();
>                 return 0;
>         }
> #endif
>         rcu_read_unlock();
>         return -EADDRNOTAVAIL;
>
> Also, this patch conflicts with another submitted patch:
> [net,v2] rds: Fix inet6_addr_lst NULL dereference when IPv6 is disabled:
> https://patchwork.kernel.org/project/netdevbpf/patch/20260709162723.36752=
3-1-Ilia.Gavrilov@infotecs.ru/
>
> So, please rebase on Ilia's v2, and mention the dependency in your change
> log so the stable folks pick them up in the right order.  Both fixes carr=
y
> the same Fixes: tag so they should travel together.
>
> Thank you!
> Allison

Thanks so much! Your version is better!
I have sent v2, which rebase on Ilia's v2:
https://lore.kernel.org/netdev/20260710223029.1307043-1-xmei5@asu.edu/T/#u

Xiang


Xiang
>
> >       if (ret)
> >               return 0;
> > +#else
> > +     dev_put(dev);
> >  #endif
> >       return -EADDRNOTAVAIL;
> >  }
>
