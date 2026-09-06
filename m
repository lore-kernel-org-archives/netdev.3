Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CE4CCDE5
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709267; cv=pass; b=CK9gYzTdu3mHgQGMwpgNem85kMcroERyS/aegmIKgNuNVF9045f/8qfJVyJBEphSTXWhvIoGQPi1n0g3BSe94JCH7Oa5xWX64oXdbPi8uYiSJE94WMv5HC3seDOWgCCVY2B5qsGmHcLHNBpnSw9W7K4yv4shnB/dJtZ4pMccKus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709267; c=relaxed/simple;
	bh=Q6WoKeShd1Pdex65m4287ETebem1B+r0qGMcvBxIg5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoOHy+YtHCycEIWRqxReT26MFQESPpFWVlGmoXgqkzciKgbpHVcicQzCKtmFiepbTGRUgu0Wn+W9kKCirQDOuNlldRC19VdmvaavVxjieCvAE9ekigwWF2AOsxeizSpbsMEn2UC809Sw+0FIvzQvAxkpYl5awYQiP3kwEs6/4E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knV70u60; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knV70u60"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90e7c71f86eso18947896d6.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 08:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788709265; cv=none;
        d=google.com; s=arc-20260327;
        b=qoUF7KlPTWWt6HEfnwkrpGFPrm3X54J5hIik1pJqgr14ZCtQZlS4wkvHJT7ICHLcSK
         OEnVZATzdnltsh/2YKXm4aIhN/PM/EX4wzzoeDXG4rZHPFPHr4dLOzJPUum5mZ/YUWht
         CSTXjKxaqqmVYRVMtjA5NHHKWeAJ/N35Gzt5pGDdJ0nRSx40w1sDSWQNykIPHYw0o2yb
         PgaJksIeeZqXFZST4SAlysfCW8ErgszK+oLhyJmVWJdWDpaYrBOpHpqcc3lDSE+ZxAjV
         NNC2FvNLBpEMuZm86bDrWTmcNg5oVuXTI5mbPC6teHIjrA41V+xmQn1NmWzkn/Ugqg6/
         3qRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UrOVzk35f8NZkFEVJGXTvHEU4Z8nVv7T9wq6ezeDgeQ=;
        fh=pqQMkZtCM9aV1tjHL3jMM5OJ4G3ldAHYNzxxPzs8v1c=;
        b=sACkNnHeM5oDo8L58+6AMJz4jaqAtU9ei25u1Ixvx6B2gazmQxUH0ScquU3SlWShW/
         TvQyJ7Xcq+Ffa/Z5kTTtNn98Sz0a3Nz7g43/1cF/34wn3TcEKsH0W7n+l5+LklOqbpcW
         i9lhY9ZqxyC/i9oA8X1lf3oItRP3vuylaotdJtwnazzViknQlenCQiWFDJuQUsKer0vW
         M4HHPkqEln9YQjo20MXHYa/+lI2y1WfDpTr3QQLCFNZ1o02QTsEfUeXln0UjmcQ/PvZ5
         6g74iN6DkU1dTJ9cgDdX9MgcxoEoydPdEDLJV1viMaOFSw6hOVbUI3sxdGqXet00PMMS
         KEsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788709265; x=1789314065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UrOVzk35f8NZkFEVJGXTvHEU4Z8nVv7T9wq6ezeDgeQ=;
        b=knV70u6010AaQog6OrxbCDwuWKY3ilWpAHH9zQFgn3oAj1MMaQE4TsEAvNwjkC6C7m
         Ad/sW2SQ/LUsHrDihXf5hUmrOwH+1Rv+wJkedfW1cKwTQB5p3XdPNd+Cnog5HsJs/YVN
         QdRd0JwxUSS+7RD/M6tYHb0bHFVYhhZyzcV/eXIBUmggxBYe8fHw00wYvyJxpjTYdgRD
         XgHc5qQlQtP5gT/8zEnDsnXY/I7xUlkIncXPVcxRPdEIoSyoIOe+vSt2u6M4o/avMuP+
         x8udyn4hiG3tPXnJMXFcz9/Wllnd8qIvP+wFsC05iFFIaqWVNZx6gX1LjvQr4b3xu7vX
         +2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788709265; x=1789314065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrOVzk35f8NZkFEVJGXTvHEU4Z8nVv7T9wq6ezeDgeQ=;
        b=sa55f5Wwz+ph++57fLTtSae3W/RXD6vDrApapL7DDBno08M5s6xhGrqpg2YFVht7OM
         4HeL25hL1IIo4Xa13XbdyyQl6hcxDZWoaNr7LGr/p76tXEyiwCoxyGg5WBSY4NYJqlFY
         4h9rpwy8rkqIeMklZYkhk3tbVwnjM4LjJ4YBm9umrM6oI0QHiRmgl6n+XC2xZi3BswAp
         plpCfht48YoKYWr1UG62A4JEye96Zv0+Zqmfb21vwcNku2jxcRG/AP5EqvmK0eIgenvQ
         AzQ6/dBr6hCLlGX7FYheNwQuQeTdg9xnoHiESi6HrcusLbSXJw5atM1A7wqYZkXhGXhb
         kJxg==
X-Forwarded-Encrypted: i=1; AKwUvBwdHlptUCWCNvWvRa/uzZUtVaAP3donfGA+PuK4h+3+sAx6WxtCU46YahnPioFd1NrTApJWS9w=@vger.kernel.org
X-Gm-Message-State: AFuF++nsj6Z5B4OJr3H02uupWZjkgXzXXyjXkghjM9xAXAh2jo5lTlsb
	0njJiNEEPSx15dEEYmJ5Iii9latpVQnJFRmvtDbC146q3PAX3jTTLns9YRSh/vHAcbSDt5bH09A
	uZ5wsxx+FLRVVmNvY8p/O26MGjBNoPGbpWI8eiu+D
X-Gm-Gg: AYBFou2y+QFUKLwa97drYLfEG/GZ8WiQjFYQN9C80ZqiJM9soN7gRq6he4tA3YrDna3
	9A2UOzduT9BRWQz090R75MCD7ndignBkwZVKed+7CbEJwQCgUG0B96UsnyJYxqUa9ZgghwOrSIL
	Gk6EPS1THkqrZLi2Sz/ijBArjdVnLTW8gp3HLiPSwGjj/qTemNuG0gBeGpsNSK5MGHy1pOSn0zZ
	TdSlB761EnD4tFt4REfWMWcobmuQDAzAjm5uRFSg0P6NB8r7olQH8jtuGj4Ti7UOblQUHCp6Fpi
	uKPmLc7N2lvEmTz3doK+GBOUh/OQEs9cPes8RJe0xk4cgVykjr7FNCelXVhbFTvFP1xdyu38Jyi
	W5T+JO6jOEsWVXODwDNFvNho9ZYC8vygH8QuK4uoK/4SDQ+p+/0tcnn/y7S8KVqCzjZsA
X-Received: by 2002:a05:622a:11d6:b0:530:4fc6:edc1 with SMTP id
 d75a77b69052e-530549cad8cmr186239331cf.40.1788709264023; Sun, 06 Sep 2026
 08:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com> <20260903120840.1024153-3-edumazet@google.com>
 <CAAVpQUBdXcxpGob6roJn=MbV+AZHmUKPE0=ferg9a4jGpc2ouA@mail.gmail.com>
In-Reply-To: <CAAVpQUBdXcxpGob6roJn=MbV+AZHmUKPE0=ferg9a4jGpc2ouA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 6 Sep 2026 17:40:52 +0200
X-Gm-Features: AcwNN1WEBUloIKJwfG0hY0VOrdni9OHlGq9VKwlarQ-SiqQiQkKEbtU_oQdDXMs
Message-ID: <CANn89i+P0_yabKqvLhAYv0LW1A0tN_YnxBA3YB1kWedHcBwLdg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/9] vxlan: vnifilter: free vxlan_vni_group via
 RCU in vxlan_vnigroup_uninit()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 6:52=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Thu, Sep 3, 2026 at 5:08=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > vxlan->vnigrp is an RCU-protected pointer accessed locklessly under
> > rcu_read_lock() in vxlan_vnifilter_dump_dev().
> >
> > Currently, vxlan_vnigroup_uninit() frees struct vxlan_vni_group
> > synchronously via kfree(vg). If a VXLAN device is deleted concurrently
> > with an RTM_GETTUNNEL dump, vxlan_vnifilter_dump_dev() can suffer a
> > use-after-free when reading vg->num_vnis or walking vg->vni_list.
>
> In unregister_netdevice_many_notify(), does synchronize_net() after
> unlist_netdevice() wait for the reader to complete before ->ndo_uninit() =
?
>

Good point. I added this patch after sashiko had a false positive:

<quote>
 @@ -2979,10 +3007,13 @@ static int vxlan_init(struct net_device *dev)
>  static void vxlan_uninit(struct net_device *dev)
>  {
>   struct vxlan_dev *vxlan =3D netdev_priv(dev);
> + const struct vxlan_config *cfg;
> +
> + cfg =3D rtnl_dereference(vxlan->cfg);
>
>   vxlan_mdb_fini(vxlan);
>
> - if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
> + if (cfg && (cfg->flags & VXLAN_F_VNIFILTER))
>   vxlan_vnigroup_uninit(vxlan);
This is a pre-existing issue, but does this synchronous cleanup cause a
use-after-free for concurrent RCU readers?
Looking at vxlan_vnigroup_uninit() in drivers/net/vxlan/vxlan_vnifilter.c
around line 925, it destroys and frees the RCU-protected vxlan_vni_group
synchronously:
drivers/net/vxlan/vxlan_vnifilter.c:vxlan_vnigroup_uninit() {
    ...
    rhashtable_destroy(&vg->vni_hash);
    kfree(vg);
}
Concurrently, a netlink dump for RTM_GETTUNNEL could call
vxlan_vnifilter_dump_dev(), which retrieves the device under RCU and
accesses vxlan->vnigrp via rcu_dereference(). If the vxlan device is
deleted at the same time, unregister_netdevice_many() calls ndo_uninit() ->
vxlan_uninit() -> vxlan_vnigroup_uninit(), which frees vg without waiting
for an RCU grace period.
Could this lead to memory corruption, and should it be using kfree_rcu()
or synchronize_rcu() instead?

</quote>

Sashiko saw vxlan->vnigrp annotated as __rcu and read under
rcu_read_lock() in vxlan_vnifilter_dump_dev(),
and assumed that because vxlan_vnigroup_uninit() directly does
kfree(vg) without an RCU grace period,
a concurrent netlink dump could hit a UAF.

However, Sashiko missed the netdevice unregistration sequence in
net/core/dev.c: unlist_netdevice(dev)
unlinks the device from lookup structures and synchronize_net() waits
for all active readers to complete
before dev->netdev_ops->ndo_uninit() is ever called.

I will drop this patch from V2 then.

Thanks.
