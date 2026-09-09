Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD425FA29
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927197; cv=pass; b=kSk81XJIjlRpa5cUsQD4vViuhUgW12lmPtQT/926usAafL6WCxaiH8lXEJ85ae0/YDVo2H6Me0OOKJOOE+wKjgKWAnCQhkNcTwnV8CgJWxLPlDpVgc4dD3p4TDzEjKU8IN/ktQ745IzuHtgphuzDnIN6B3leN6Xr+UIaY0MR/Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927197; c=relaxed/simple;
	bh=Q7zOJ0c1P92kOGUd/bgdxzZnAXW4atFbwy/pp+M9xCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4vmkcs1UO4gZef80za+ibQkANALITqzTOJFc8N3aTjqAjN/XbhBG5E/BqsXB5P3Pt2+ga8EgnuIce902KBnjlhTz6DlW/mgBKtA9OLPe/JeX3T3rEnDhvv3L8sCoc9/8khr0aN4yo1sA7aw7qoeawBt383seDXsQpNo3refpOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZbbmEiSZ; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZbbmEiSZ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso4184918a12.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788927195; cv=none;
        d=google.com; s=arc-20260327;
        b=k/56ugT2fsy7PESM6mFcGm5x0mnfZ2nlxa9V+on1aE8XOiitaLI22Ps1fFtnSuaXIN
         xidNt8xBnZng3Gc0yMG4zRRM8Ncn8VbpokeN1SJ5NT5Nfo/YBkkkhAaY/CYtx+dAXfpQ
         KZ9Q1RBVau3gAzl9HdifjJxBRgtdM+d3oSQo1HFKc03+GSdame3cEWFohG+wiFLzHdJY
         2scI2EfQAfAcgfGSczTomt+Lq009ws80JrTiP8SH7XZ+k9nkt6bUEZqW3v4QuRfpEZin
         m9Ibm6eBeYJ6ZLpuar+0z1OFgMQySz91HT402VuQrd9aTbYMyOUR10O42YPEWR1S/68p
         witQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s2V3FE9SxU0SyTyx3R7UqzZLvmKW4nOi/nsjItk4c/o=;
        fh=o3So41F1gotqTy0+tC14ZajNJwYfA9LsuAhCO/xOGIw=;
        b=rIoCjyBCJKi8YUN0GRpLPYNisJDm3ti6Eeet0VgrbmTq1cqgsASIyl5NAkMmc996Zk
         pLgwud8yXWBy5sukhSeIKs8PonNBTn0oxkUxhfbk+a3LkTxTswtM4KlL66dXzGdndACm
         HJ+UGntM1PxS6ZNiVZnSpzcrLNQFyLtlFScnnFcmdUfsef1wG1ZvVO0sYKiWgpBwYTt6
         sP7Yr49CJ14G4nF6aqGiolIYB4jdpS8Gl4wUn0Ycp3mTqoeTBStqq17JYOOTQjVYElbU
         lApKIq1X9IL/UyHetn6Yqrp2ek+6hXfBDX/3kND5Qdd8h9EFqLMUK0tUAaO+UyY6Gh/N
         AbaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788927195; x=1789531995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s2V3FE9SxU0SyTyx3R7UqzZLvmKW4nOi/nsjItk4c/o=;
        b=ZbbmEiSZpfSJWmOYnVxl4mXNbDTV5X9Krpdlb0/IKAu8EJBEzQVM7ZTPQCUeHV1GLw
         fkHX1Tpa27zaittSH0VCPdp1+M6rn3w/UwBkpzq4hY4h6gs0ud9wr0Lsp8FOgTbltfTr
         d8tju9vT8jol8tHTmR0dLRu7kf5eKm8Q3r7DBrS79D5XYkEDqkRvqssOPUz3Xmms3nlf
         m5I3OchoIw4LXxSeEC76mmlencRjK+KZUXfy5al4y938JmeO4f/9Z35ODD6zUC4LkdeG
         JTdO6I5z2Kd5bALMZ6/Hd0lutmcFBve1wQsw/0RFvpNZ8O0K7AUVuK6gDWmgP+LDjIDk
         S3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788927195; x=1789531995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s2V3FE9SxU0SyTyx3R7UqzZLvmKW4nOi/nsjItk4c/o=;
        b=bZ3E1SyIyzXNKkHwE2B+sp9QHAmDQCI/5Zw1g9Jah9YFebDZpVlhlVpaaY6AtmHFw/
         KXwutS48ZdkvYGwwSr7VJNw0BOBqJiwLJomub5zX+CHfYtDOrPDyZQIoGSukrsAUx44l
         rXFIVrw4b4h40ihEvrjE2cSsvWCUHcBNfgXGV8b3t3FPl2ejqCTUecyIOXhr5+jGHldi
         TJvSKWRILbWhpMoV7fac8ltS1rx1n9XO/sIqQY3949rMBI15vJYfxxuGWZ5JALdVfC4z
         RfCxVgq8ePTUT63/zmeEMsibtcwZApUBq4pcSYUJG48tpP/6vfRl1JPC7pLbdBEe4o7Y
         q/hw==
X-Forwarded-Encrypted: i=1; AKwUvBxgETpUvMPXscWwsfUmczNFFTY73j44SI2WqVMt8+i8HUWulGaAMkLpAJPIdQEb5otbfjIR9w8=@vger.kernel.org
X-Gm-Message-State: AFuF++khDKZAtomEh/kU5pa93Zy+dUyY5FD/TUOaWsakQGRSoegaUjff
	XKlQjt6k1An2+mk7anxxuuDGAPw2QxEhh/wB/r3HCygizRVpU6/I2hnfbssaBRYgkclAauiJBMP
	1juNtmftZ516xHhW0ZO8Fn9gSESLA07SAuvErWGzr
X-Gm-Gg: AYBFou3TPWEEqZB2qAcvqn/Y+n9MzLkDlkMiR5z+ZdtMiYMGBRL7oc6DBZWmYgo5M6g
	0U0aah9vEh3oo2Lz3mXEhNyKMaTKthsUec69GzP5oOd1R9xC5ucl2uTP4CFBEFx1B4tgwT4xEy7
	9xTU22azW2CZn6zI8W+RDBG/KxiAY+CGCPTHYM3kRPdmhFFyo7qZgecgeUFERcIpggptfvH4bPJ
	cRaYJ0ptQK2P4mGxelGdvsLsU1+jLSGlBHS0nEdBSGcrYYjOLKYXPq6rpwnMuStOxdFDysIfCN2
	vTuYdV/Z6m5gL2nlZHj5EatTJizAeaTJ9OlPjai8ueKTRLy4TIN8GVuUqLLkWp/2pqPID8s/ye+
	0btfCkMdb9TZTc27I3FnOIHU1Nj/qFyQSQBBHVWcIs8XMY5M6x11H08tLcfDk2K3lQ2brKB9b3K
	3Bjg==
X-Received: by 2002:a17:90b:35cb:b0:398:a486:81ec with SMTP id
 98e67ed59e1d1-39b261ae617mr56777222a91.11.1788927194799; Tue, 08 Sep 2026
 21:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907225846.3787676-3-kuniyu@google.com> <178891912049.219967.11126712848920219064@kernel.org>
In-Reply-To: <178891912049.219967.11126712848920219064@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 8 Sep 2026 21:13:02 -0700
X-Gm-Features: AcwNN1VeqYB_2dPNmfPI8RZi86TX95nY5G-EOScBiM_N5g4r4a0t-TdVX59Hxl0
Message-ID: <CAAVpQUBmrK8vQKj+WWkcHg66Q-KY6+zoJ+KJxvH6zUMCc4j25Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/7] ip_tunnel: Set itn->fb_tunnel_dev to NULL
 in ip_tunnel_delete_net().
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, kuni1840@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:58=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> - [Low] Claim (INVALIDATED by verification): 'ip_tunnel_delete_net() no
>   longer uses its struct rtnl_link_ops *ops argument yet the prototype=E2=
=80=A6
>
> --
>
> ip_tunnel: Set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net().
>
> This clears itn->fb_tunnel_dev at the start of ip_tunnel_delete_net() so
> that the fallback device is treated like any other tunnel device, drops
> the for_each_netdev_safe() scan that matched dev->rtnl_link_ops =3D=3D op=
s,
> and removes the now redundant fb_tunnel_dev clearing from
> ip_tunnel_uninit().
>
> No Link: tags present in the commit header.
>
> > diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> > index e6bcf01411d0b..d29e2ba7cdd3a 100644
> > --- a/net/ipv4/ip_tunnel.c
> > +++ b/net/ipv4/ip_tunnel.c
> > @@ -1155,26 +1155,19 @@ void ip_tunnel_delete_net(struct net *net, unsi=
gned int id,
> >                         struct list_head *head)
> >  {
> >       struct ip_tunnel_net *itn =3D net_generic(net, id);
> > -     struct net_device *dev, *aux;
> >       int h;
> >
> >       ASSERT_RTNL_NET(net);
> >
> > -     for_each_netdev_safe(net, dev, aux)
> > -             if (dev->rtnl_link_ops =3D=3D ops)
> > -                     unregister_netdevice_queue(dev, head);
> > +     WRITE_ONCE(itn->fb_tunnel_dev, NULL);
>
> [Severity: Low]
> With the for_each_netdev_safe() scan gone, is the ops argument of
> ip_tunnel_delete_net() still used anywhere in the function?

This is removed in the next patch.


>
> The prototype in include/net/ip_tunnels.h and all five callers
> (ipgre_exit_rtnl_net(), ipgre_tap_exit_rtnl_net(),
> erspan_exit_rtnl_net(), vti_exit_rtnl_net(), ipip_exit_rtnl_net()) still
> pass their link ops:
>
>         void ip_tunnel_delete_net(struct net *net, unsigned int id,
>                                   struct rtnl_link_ops *ops,
>                                   struct list_head *dev_to_kill);
>
> The follow-up patch in this series, "ip_tunnel: Don't pass rtnl_link_ops
> to ip_tunnel_delete_net().", removes the argument from the declaration
> and from all five call sites, so the unused parameter only exists for one
> commit and does not produce a compiler warning. Would it be simpler to
> fold that removal into this patch, or to note in the changelog that the
> argument becomes unused here?
>
> A second, related observation about coverage: the removed loop was the
> only place that picked up devices by netns membership, so after this
> change ip_tunnel_delete_net(net) only walks the itn hashes of net. A
> device that lives in the dying netns but is hashed in another netns' itn
> (created with link-netns, e.g. "ip -n nsB link add gre1 link-netns nsA
> type gre ..." followed by "ip netns del nsB") is no longer queued here.
>
> Tracing that case, it still gets destroyed by default_device_exit_batch()=
:
>
> net/core/dev.c:default_device_exit_batch() {
>         ...
>         for_each_netdev_reverse(net, dev) {
>                 if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
>                         dev->rtnl_link_ops->dellink(dev, &dev_kill_list);
>                 else
>                         unregister_netdevice_queue(dev, &dev_kill_list);
>         }
>         ...
> }
>
> which reaches ip_tunnel_dellink() and, since fb_tunnel_dev !=3D dev there=
,
> does ip_tunnel_del() plus unregister. So nothing appears to be stranded.
> Could the changelog mention this change in which devices
> ip_tunnel_delete_net() queues, since the last patch of the series
> ("ip_tunnel: Support per-netns device unregistration.") is where that new
> behaviour is finally described?
>
> >
> >       for (h =3D 0; h < IP_TNL_HASH_SIZE; h++) {
> > -             struct ip_tunnel *t;
> > -             struct hlist_node *n;
> >               struct hlist_head *thead =3D &itn->tunnels[h];
> > +             struct hlist_node *n;
> > +             struct ip_tunnel *t;
> >
> >               hlist_for_each_entry_safe(t, n, thead, hash_node)
> > -                     /* If dev is in the same netns, it has already
> > -                      * been added to the list by the previous loop.
> > -                      */
> > -                     if (!net_eq(dev_net(t->dev), net))
> > -                             unregister_netdevice_queue(t->dev, head);
> > +                     unregister_netdevice_queue(t->dev, head);
> >       }
> >  }
> >  EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260907225846.3787676-1-kuniyu%40google.com
