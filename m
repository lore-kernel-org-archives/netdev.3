Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45834233942
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538135; cv=pass; b=Qw679ey/F1Sf1GZeHLvpZSrT2Bcoc7OANjhiH4LuKgaU+PWbj1lJ3UXYEiSxbu5PRsyYMufXHwqXgRnZVYd63tI36/ioZW5a++4DWN+1EtlZznvXvcAVGm1YrpGcSnIwzyqlS/f1hBCrDgA7FTKt2ccXn5oxYEnsXFA6Y38NROM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538135; c=relaxed/simple;
	bh=x9l6lRa0LMB54cr7ndM5V4us2FpiCBo6jaUwYUOhzu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzUZKanLs9q3u35G+qylnfmKuuOnW+4XRx01Sh+8XqVytEa1x5dyaNPSMtINYUFibGZ6yoGZdb5OyXxmsTpyQ1Q1o7U1Rng55SeAhwMlFFE1hmEt/hD9xxt30eYE3Fozb+oxiu3ywoIl3jBh4PETsIr6/w5S0F4fnwVDANcmPDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+JFAxx9; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+JFAxx9"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8565d77c277so41126397b3.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 02:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791538133; cv=none;
        d=google.com; s=arc-20260327;
        b=KO/0mpOUxTOa2jWTzNAYqnQ4eGnYNwRvgz/iTqkW0wSkg++bBFwUsX2LMlpOtGLNc6
         DAw1LYB6DHwWVjKkkEDyKmbPeNAfBI6TSPnCevqUvY9sSvLv27m6spdBBAEdkuvmJEzM
         haN06YYxzvRNVUpjQTNEz2gGEbwD7gkWIbxIe/eIzogArAYrcCzm5Qe9yDtuw6pFwS5m
         GtiFXpBDsSqYVp8WllL7Da6cLuq/LKSlmw97ikX6/LDxTkRqpQcfblPXmnVl6yWCiEsq
         KFpivh8scnNv7mDKcQzAYxHK3GvfeOISObMZaFaeRjeVRgucZKZ9XEvEi91dfF9/RbE8
         qvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SoQSQjh6Jm8gBqQ1PDQyGzx+E+R1VRExp+5Jlum5ypA=;
        fh=spiYZb98B7GqjlzziDn3nzDtqwN65qn1DLT1CztHu88=;
        b=h61Uu0miYhCn0LTydUqcgfRUiCODlGtD8e0KNDmnIzO7ngGPAPQ0W6+SoKZTQW7iF0
         YbERJZbNi6jY4JGdE1plVNchtaqeyA+LsF+5bBb6YWzWmJsmcCL4u/cMPkoz7fNT2xGA
         vI8fDUmhXEoLSmRz3/BX0V0eONvFHzdi5vVCFuju+uDaU7yjaOuwe+fHCX5RYqkA5KJE
         R4xsWnvRygP+K2P7lL8Dz98kYyiAQeTM+3aq5dPWmFvn3ZkURDJ9P2DTJstzE76IbKVO
         v9IujTKYHtlEk/YgIdLywbzTwZe4vFN6VyqYQeUQGz/TODOHbNlbr3/WW9Ed3z4yhjKX
         bE1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791538133; x=1792142933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SoQSQjh6Jm8gBqQ1PDQyGzx+E+R1VRExp+5Jlum5ypA=;
        b=E+JFAxx9TNggi939XEeqmD891wyL2VwMWDZOvLjmW7gTClcBTUvigEyK8kqaUtTR1L
         VBGxAfOJ6nkwe+ly6UN6Z27DNv77o0QFM/pf1j0ZkDL/KiRilvIWDaB8v/oST1hlLnOn
         lrrAhYE9GE+r73r1L6w0R851wBWymNHi0AQymDLNMT3mnH+X5mvmsF1SoAHSosKvRJ/G
         RntixrGgeqbmaTEhY5GxQMHRbTomUQr//PD5QQtv93ucbHdpGBmeIzXNnJGqUDmpsc5O
         DBY27b3e5PKn0RE1v186UATZjZyGw6mxM04R54ISIPzvXJRvCPlWE5qEBuyeC+Ni04Ct
         3OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791538133; x=1792142933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SoQSQjh6Jm8gBqQ1PDQyGzx+E+R1VRExp+5Jlum5ypA=;
        b=daNnXiVl5C+9WezQUn15LEyvJtrVjLLBbpEpnqBqIKWdHaeLQeoSdDTpSEKztgiyY9
         aoc+hR8PC4KC+0fDHLixQnpfhiFU0IzJatAZfZSijRR2cnm3NKoLVbeHQDftsDIIkSXr
         A2OLERTDgBTW0FvEnzW1anyt3ltHtt1fioIVGiaXFIa9tjtSNJeRAfTp9qPsdY5/b2UI
         R/aEbnLKc11n/slXtV/B7m1hBKvxXmtvzJzFgn79vI+2DcSVZyn+JiGNYW2r1cSjzX3R
         dI+Y0lAsnQY5KAZkE8tgBcmCNOUZWpeRBNFVe69/iHqiYPDnw51EAoECEQiydrU7NQM0
         6faw==
X-Forwarded-Encrypted: i=1; AKwUvBzIQ4Gd/iHMfECRKfjpE9WloQk3zbxco1HV24jD2UuKNd+N1hLTnLo5UJztuR0xWgFYkVehweg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzjRgNjtQpdPfzgWhDhEisDKBogk373qogVmPNzqggZ89mIKlB
	p8Yu8XjObS9p9siaGixnumSkJA3DiPDlHYm8Y5xH3WkOzAWDutWDb9lnrWhkFq7VS5APbD/VAX+
	ReEr8n1rd/SG9zdjF0iisClFQXQYjFQU=
X-Gm-Gg: AYBFou2l5zwT2tbe53gtaQHmobTE5UH3Gp6c57NYlEeZyse4rfHEXM/DGVJ13IcQ+sl
	ckNVwErIxSAG2zC9rfVg1G+VfPK5ryRTRJwzzE93zrytt72Kw7OiNkA8yggcg80dL0s8lLsGHna
	kjUeq7QWMANoPkgwG4/A169ourVDMMVh2Kf9kHgNLPy0k263yoA+4RHtGOjU9z8PWFN9FdxOUpB
	sZjOHy4mJR0+/CHoG8FxrP/C1R7Ufj6VPx1bysKaDb9THaWZhhbJTpbH6eDURUY95C8Tj/HbB2C
	4L2nC729oCCkFASYyETYktLy1qzORaLSlxAb/MO/wiMbinfitpgJjLKigg==
X-Received: by 2002:a05:690c:ed6:b0:88f:df4:1c7d with SMTP id
 00721157ae682-8b07ed943a7mr3818137b3.14.1791538133235; Fri, 09 Oct 2026
 02:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009074405.727999-1-edumazet@kernel.org>
In-Reply-To: <20261009074405.727999-1-edumazet@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 9 Oct 2026 17:28:42 +0800
X-Gm-Features: AclHuK9mWPUNmKzHBu9GWf-6foC73yMwhOZBxuqNWn3dMRPJc0SGUAtY9CIhFj4
Message-ID: <CAFRLqsVVPWqiWmVScSs+3GLT6XuMQ80KPeo_0HuL1t-sCrB+YA@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: use RCU protection in inet_netconf_get_devconf()
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Baul Lee <baul.lee@xbow.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=BA=94 15:44=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Eric Dumazet <edumazet@google.com>
>
> inet_netconf_get_devconf() runs without RTNL. It uses dev_get_by_index()
> and in_dev_get() to pin the device and its in_device while the reply is
> allocated and filled.
>
> in_dev_get() is not safe for a lockless caller. Since commit 9d40c84cf5bc
> ("net: devinet: Reduce refcount before grace period"), inetdev_destroy()
> drops the final reference before the RCU grace period. A reader can load
> dev->ip_ptr, then call refcount_inc() on a zero refcount after
> in_dev_free_rcu() has been queued, and keep using the in_device once it
> has been freed.
>
> None of these references are needed. An in_device is freed after an RCU
> grace period, ipv4_devconf is embedded in it, and
> inet_netconf_fill_devconf() does not sleep.
>
> Allocate the skb first, then perform the lookup and the fill under
> rcu_read_lock(), using dev_get_by_index_rcu() and __in_dev_get_rcu(),
> like inet_netconf_dump_devconf() already does.
>
> Fixes: bbcf91053bb6 ("inet: do not use RTNL in inet_netconf_get_devconf()=
")
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Closes: https://lore.kernel.org/netdev/20260815172032.79740-1-baul.lee@xb=
ow.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Cen Zhang <zzzccc427@gmail.com>
> ---
>  net/ipv4/devinet.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 5b6b11c943e453742b4893f1c9bd9e70d3d37a6f..f9a361621f74b420276006b13=
de94926e13af18e 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2379,8 +2379,8 @@ static int inet_netconf_get_devconf(struct sk_buff =
*in_skb,
>         struct net *net =3D sock_net(in_skb->sk);
>         struct nlattr *tb[NETCONFA_MAX + 1];
>         const struct ipv4_devconf *devconf;
> -       struct in_device *in_dev =3D NULL;
> -       struct net_device *dev =3D NULL;
> +       struct in_device *in_dev;
> +       struct net_device *dev;
>         struct sk_buff *skb;
>         int ifindex;
>         int err;
> @@ -2392,7 +2392,13 @@ static int inet_netconf_get_devconf(struct sk_buff=
 *in_skb,
>         if (!tb[NETCONFA_IFINDEX])
>                 return -EINVAL;
>
> +       skb =3D nlmsg_new(inet_netconf_msgsize_devconf(NETCONFA_ALL), GFP=
_KERNEL);
> +       if (!skb)
> +               return -ENOBUFS;
> +
>         ifindex =3D nla_get_s32(tb[NETCONFA_IFINDEX]);
> +
> +       rcu_read_lock();
>         switch (ifindex) {
>         case NETCONFA_IFINDEX_ALL:
>                 devconf =3D net->ipv4.devconf_all;
> @@ -2402,36 +2408,29 @@ static int inet_netconf_get_devconf(struct sk_buf=
f *in_skb,
>                 break;
>         default:
>                 err =3D -ENODEV;
> -               dev =3D dev_get_by_index(net, ifindex);
> -               if (dev)
> -                       in_dev =3D in_dev_get(dev);
> +               dev =3D dev_get_by_index_rcu(net, ifindex);
> +               if (!dev)
> +                       goto out_unlock;
> +               in_dev =3D __in_dev_get_rcu(dev);
>                 if (!in_dev)
> -                       goto errout;
> +                       goto out_unlock;
>                 devconf =3D &in_dev->cnf;
>                 break;
>         }
>
> -       err =3D -ENOBUFS;
> -       skb =3D nlmsg_new(inet_netconf_msgsize_devconf(NETCONFA_ALL), GFP=
_KERNEL);
> -       if (!skb)
> -               goto errout;
> -
>         err =3D inet_netconf_fill_devconf(skb, ifindex, devconf,
>                                         NETLINK_CB(in_skb).portid,
>                                         nlh->nlmsg_seq, RTM_NEWNETCONF, 0=
,
>                                         NETCONFA_ALL);
> +out_unlock:
> +       rcu_read_unlock();
>         if (err < 0) {
>                 /* -EMSGSIZE implies BUG in inet_netconf_msgsize_devconf(=
) */
>                 WARN_ON(err =3D=3D -EMSGSIZE);
>                 kfree_skb(skb);
> -               goto errout;
> +               return err;
>         }
> -       err =3D rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
> -errout:
> -       if (in_dev)
> -               in_dev_put(in_dev);
> -       dev_put(dev);
> -       return err;
> +       return rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
>  }
>
>  static int inet_netconf_dump_devconf(struct sk_buff *skb,
> --
> 2.53.0
>

Tested-by: Cen Zhang <zzzccc427@gmail.com>
