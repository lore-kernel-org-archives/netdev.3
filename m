Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B846AF10
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857079; cv=pass; b=HDSO904kqFUoRras3VvDVTSvEVrW42RvviWGGCkeY5wgzFxNpjwkS8+Jsoq5gPXKR9X7rw5rvzbtn64Rx93R3JqdICXXeJx4LtINtZYpAgZdDB7rA69/tPJ/mWNJ5i8HPrqVAuEdqzH84f05izMb1CcqR3JE3s0wOd7kwduoCfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857079; c=relaxed/simple;
	bh=Tjm0yDQYlrH8X6N6E9I9ZGiI+Lm92WeCfGZhIDCgUp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWsgthtMYp/FgOkmD9nXL8Y8rm7s4+KSihG/xSK2pWhzPT4L2HTTDzNUtuoc4BdbrhElpxIvb48ojeZ1ZAFU7Fwc9ZeRA7d2Qlqyvo5qzCEcm4pagQT+ZGXbXMQy6EGNhfMu+egwjRUSufGPi2flKpkGg0OlYqCwzRTNFbo4V7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bV/eNJ4J; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bV/eNJ4J"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso5682371b3a.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785857077; cv=none;
        d=google.com; s=arc-20260327;
        b=rCFTTYQzwbAbHqPeyv16ltOcXOzDWupvgzaE3z4e55S4p4NF5BSdhBIhPDkSnp8tNn
         0/SZj5SW/Dw6XugdI2WmMDiKvc4rEkX91AQ/9M6sMS4gfi4Vt3XmSihsohnORaJRsyMC
         IRJ5SB2QvvAxUza08l3lkfCdwwwwRJ1ESjN4Esi1U0sX50eDm0TG374//9BVYIURxqv8
         9cN7kH3S5zlRcvugwQZyj44kt0V5ESzLUsMEWMkhrJLzjZUbUKV/lLki5CMRPxSHoo44
         sh0aicmHloGr9xFZcqXRjkLhx832d99NxrpP4Eo4VQR5p0oxdvYNT8PedF6A2uLntLr+
         4DNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fDD1em8JG1NbNzy8g2mfMsu5ZDnxM+Ezbp7dHoWAl+Q=;
        fh=TDDZIr+F9BgXOOVmnfkSGFAxZ+N9+nmygnveSJnmKE4=;
        b=rrCoVyTaqHdxqpyrMqaqeDjhvoDCB2ysi4+swu4MWV4NWb5IoY/XOQJ9XWlP03DhU8
         nch8s9gSU7osteuZIOy4VjZ69bcX7gemQC8zT2Dkop3Kf2SgtXozanucnmRSf8CiVFfN
         MpR0e7r1sDmVIcHfiMA1YSll8l15ORxov7aaAM6ElP8vKxs9chZ+E5bU3iBvmx2QMCmK
         vWzH/RDWyxlME7oGBA3xyArquZUik1DmQRjvFzeZRVM0H48QOJEajf77cnUNzca0fXbJ
         tXbiZ3PS1aZHuIQdGmQsaLpyGAYxkPpBhPUJBfFWSG7nPaHnLv4dkB90RDwx7KqPoHLt
         suOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785857077; x=1786461877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fDD1em8JG1NbNzy8g2mfMsu5ZDnxM+Ezbp7dHoWAl+Q=;
        b=bV/eNJ4Js24pBwgtvjRNyPhAhBC0MdtgA59ZmSdu3v19joU2W++lYIr44NbXqcCUSs
         ZEXx7v+h1sjmpsgL1Oo/G8tzmAqO3jw4nIjWy3ufuDDNkWAhfq8Hn08+pjoMILMPiZ1+
         mnvgVaJE5LiqKKaCv4j3L7GWFHXexiJBmzQ0XtnAVitLCd6pQRh6VjhiGswbwAoP3cfH
         uS3vC1vL24ft+aSsOaVXy6oDZbuUf+01h+1NGk8kYLHE8Yrq7m17XjtMr2/cdVaspcn5
         MWdVr00/V7bs2y/nA9Q2ASFsMW792LmhPtGmn0qmtbkpldNO/qPtRixtgRQ19jF4BCXL
         2yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857077; x=1786461877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fDD1em8JG1NbNzy8g2mfMsu5ZDnxM+Ezbp7dHoWAl+Q=;
        b=PqlebgtkU+Ajj4H4i75QL+uu+qhTaPhtbVq9hBAZ+UfguaEw5GAufDStBdv/Jw+C/w
         aN+z1jaAcYklLSagPPdfOV3Ta77JXs6DXFp8pWfuZOrvLNbvQb3aIQGYb4spsc15dFgZ
         6YyRRgyW1Edbvefca0jZM5VmhaAAFy0SDtCInhFCbE2Qm8SRsjHbOgnWwUS1uXSEhBkr
         lL2nKxVo7nB+HyX3V0rusxEkfwBC8vP0dvXAv5miwEloLWMbgn6ohh54vrsBR+rilQe4
         ERkuFgJ8yiNj03L2cc9fqbW1q5gorL+eL2o4oIu/f/IcfA4oZCWJheUkacOQ/YKJEVKC
         jJmA==
X-Forwarded-Encrypted: i=1; AHgh+RoMHsnfA+5pfl63OMgVgbemxAMURMoFRE/ppS6670Fv65uObWVvwd/ssUFoLZiwMXpYDwj8IK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+vG+e6biEoj0pi2uX+1NwAV9s9DuqHCeHJcJc5cjHw8ToOnQ
	iG+bXjmeVYMKrk11+m5MY4pEj1eeGaBAwT29Jj47GfmsnAp1wf1Bpdl3JsWymlixvqYjSlTyeZP
	DDgzAnWawkGyC3kXZAv1mjdrllaiOChLTOXJYCMH0
X-Gm-Gg: AR+sD12ZC1OD0wxH17VtiHNqwiQBNzWZJi76Jzvk5sY1r0ErsXm+BEgkZdBQhba6dRV
	HFU00/dE5JgxySvYmq4lYBqmLwvkoH2nlkMml0Kf0FNsSbxETGdZbfNk/HMxjIJLv8cR4hXHqbF
	tvPjftM2S6u9tfzilpVaJ4aUZsGx5+a1ZSc2wMNTU4jH00Vs5WuY7hKkfwvvHSssMOPAu3shf5/
	fI9EQs+qBnTd8viOaAf5rHQc4YzSO0sR1DpZbaR4ASK+WSXZhNk4ngVtZ+mWBuh/NWKgVBbEWC1
	F9MI1PoE+zsG4TlGacbWgNrlKxz5ATkRCoN7N2d29q/h5JRUwmuPR6tp4F8e0qwV2uweNrfJqgU
	TuIXBH+Z6Z9A40uIhfbVZki6cwHtzS/+Arp5Om2ZaeGEBlxdY9KkEGZwb/pQHbGY2EG4=
X-Received: by 2002:a05:6a20:54a1:b0:3b3:f46:1efa with SMTP id
 adf61e73a8af0-3c92a8134eamr15448119637.42.1785857076459; Tue, 04 Aug 2026
 08:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731164612.2148830-1-kuniyu@google.com> <20260731164612.2148830-4-kuniyu@google.com>
 <bfa765c2-a3e7-42b7-90c5-9757d8392687@redhat.com>
In-Reply-To: <bfa765c2-a3e7-42b7-90c5-9757d8392687@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 08:24:25 -0700
X-Gm-Features: AUfX_mwTl5e82BD-5cS-IVeo7O_hExYrG7Q4ypm_qBbMDp6b_IieMMA5_hyL97o
Message-ID: <CAAVpQUDmZEaQNDSySLayqexgTrUbhBaL7XPCt9XNQzh+NGQ=UQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/3] geneve: Support per-netns netdev unregistration.
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, i.maximets@ovn.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 7/31/26 6:45 PM, Kuniyuki Iwashima wrote:
> > geneve_exit_rtnl_net() iterates geneve devices whose sockets
> > are in the dying netns and queues them for destruction.
> >
> > So the devices may reside in different netns.
> >
> > Let's use unregister_netdevice_queue_net() to support per-netns
> > device unregistration.
> >
> > list_del() is changed to list_del_init() to avoid queueing the
> > same device twice.
> >
> > Even after geneve_exit_rtnl_net() queues a cross-netns geneve
> > device, geneve_dellink() can be called concurrently for it.
> > In such a case, __rtnl_net_unlock() will perform the unregistration.
> >
> > Note that geneve uses register_pernet_subsys() instead of _device(),
> > so default_device_exit_batch() guarantees that the async per-netns
> > works are flushed before ->exit().
> >
> > Tested:
> >
> > 1. Create geneve device across two netns.
> >
> >   # ip netns add ns1
> >   # ip netns add ns2
> >   # ip -n ns1 link add geneve0 link-netns ns2 type geneve external
> >
> > 2. Run bpftrace to check that geneve_uninit() is called between
> >    ->exit_rtnl() and ->exit().
> >
> >   # bpftrace -e '#include <linux/netdevice.h>
> >   kprobe:geneve_uninit {
> >       $dev =3D (struct net_device *)arg0;
> >       printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
> >   }
> >   kprobe:geneve_exit_rtnl_net,
> >   kprobe:geneve_exit_net {
> >       printf("PID: %d%s\n", pid, kstack());
> >   }'
> >
> > 3. Remove the netns where the geneve socket resides
> >
> >   # ip netns del ns2
> >
> > Now, we can see geneve0 is unregistered by per-netns work
> > instead of cleanup_net() and it finishes before ->exit() to
> > avoid WARN_ON_ONCE(!list_empty(&gn->sock_list)) there.
> >
> >   PID: 571
> >           geneve_exit_rtnl_net+5
> >           ops_undo_list+702
> >           cleanup_net+1122
> >           process_scheduled_works+2538
> >   ...
> >   PID: 1047 | DEV: geneve0
> >           geneve_uninit+5
> >           unregister_netdevice_many_notify+7129
> >           unregister_netdevice_many_net+1050
> >           rtnl_net_work_func+136
> >           process_scheduled_works+2538
> >   ...
> >   PID: 571
> >           geneve_exit_net+5
> >           ops_undo_list+1064
> >           cleanup_net+1122
> >           process_scheduled_works+2538
> >   ...
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  drivers/net/geneve.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> > index f456a85dca77..a6a8978e3b81 100644
> > --- a/drivers/net/geneve.c
> > +++ b/drivers/net/geneve.c
> > @@ -2502,12 +2502,13 @@ static int geneve_changelink(struct net_device =
*dev, struct nlattr *tb[],
> >       return err;
> >  }
> >
> > -static void __geneve_dellink(struct net_device *dev, struct list_head =
*head)
> > +static void __geneve_dellink(struct net *net, struct net_device *dev,
> > +                          struct list_head *head)
> >  {
> >       struct geneve_dev *geneve =3D netdev_priv(dev);
> >
> > -     list_del(&geneve->next);
> > -     unregister_netdevice_queue(dev, head);
> > +     list_del_init(&geneve->next);
> > +     unregister_netdevice_queue_net(net, dev, head);
> >  }
> >
> >  static void geneve_dellink(struct net_device *dev, struct list_head *h=
ead)
> > @@ -2518,7 +2519,8 @@ static void geneve_dellink(struct net_device *dev=
, struct list_head *head)
> >       gn =3D net_generic(geneve->net, geneve_net_id);
> >
> >       mutex_lock(&gn->lock);
> > -     __geneve_dellink(dev, head);
> > +     if (!list_empty(&geneve->next))
> > +             __geneve_dellink(dev_net(dev), dev, head);
>
> Sashiko noted that the lockdep chain between dev->lock, utn->loc and
> gn->lock is not trivial, possibly a documentation follow-up would be usef=
ul
>
> >       mutex_unlock(&gn->lock);
> >  }
> >
> > @@ -2754,7 +2756,7 @@ static void __net_exit geneve_exit_rtnl_net(struc=
t net *net,
> >       mutex_lock(&gn->lock);
> >
> >       list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
> > -             __geneve_dellink(geneve->dev, dev_to_kill);
> > +             __geneve_dellink(net, geneve->dev, dev_to_kill);
>
> Here sashiko foresees some problem with CONFIG_DEBUG_NET_SMALL_RTNL
> before full conversion to per netns lock even of ovs. Just more
> follow-up, I guess.

Is it Sashiko-nipa output ?
I can't find the comments from patchwork.
https://patchwork.kernel.org/project/netdevbpf/patch/20260731164612.2148830=
-2-kuniyu@google.com/
https://sashiko.dev/#/patchset/20260731164612.2148830-1-kuniyu@google.com

btw, I was hoping this series would land upstream so that
I don't need to care about OVS :)
https://lore.kernel.org/netdev/20260513183559.2141010-1-i.maximets@ovn.org/


>
> /P
>
> >
> >       mutex_unlock(&gn->lock);
> >  }
>
