Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B4472F87
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539790; cv=pass; b=licxNAFXN1QcokH8w4PLPXODyHT7EGxKD5Sm4yhxyYlBR9pohijdfkV/VeMOrl3sSE0A2gWTW0CZOZtcMgHlYy726Zs58UormKoQs/quV7PIJyO8LDwCJRdQGkXWtrUIqqKJvaBHt7hMmErOG2ZFmLWQelQA4mVkLA4SmRyZ6fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539790; c=relaxed/simple;
	bh=cpkS/iR+2JljGBHtKRKBjZUmlWfP5sschNulxrgGRm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXP7+vP20afHJy2oZMon//gyZ43IXU0ogyT1aIiqL+t+9pZEo0vRs3PlgW7D3JWIvzcOy9PeKa/dQcERJ7mYHEd9eJc/laIKjm/6IdEoDX/P/F37LhcnF11Q57ElDiEA8KhMDMD+xR9E5FWR224LjrfKnQbrY3iSF9deCZ+pVyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbyJcOTH; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbyJcOTH"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-495b27007d0so1071492b6e.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788539787; cv=none;
        d=google.com; s=arc-20260327;
        b=L/1sIDfNCVzvGHpK/Zvp3x1z7+L1PtbPKmGEOf8LN9FbxovYdozDy5cGPDQwH/xMg7
         VVBqBR30g9ywChAg6xGCK9iNWMTgjQN2EzlQ4Wm9llTRHvKtEW9GFXSdutdKqH+sC6xK
         j2gFjbE6v0i2Unp0Q1sXsHaF8oNfmkY9X8AOzM7wo3EssoPkxqmsXooYMvvI4fv7DQ3r
         EJ8w0jVnUNGtYtCGrJcr4ill97y+WMqusYmukrkqCGXjtwguSRcqPL68sIU50cma4qZ0
         GAtmKjzMr9MSLYXYKNL5FN325nOOLg3g6usaaJRUXPSOuDtuKHZ5gaEB4C/0r5Ezs2Ku
         HpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3e6DJ/udgPJQWJmYBhE0yZNk1UbRH55dAvVIgnRQMGU=;
        fh=6TzweMH05BvHUKpaPX3Fx7lASet8+dQUoSnd7clsKHg=;
        b=hbhSo9atXhfPEBzgjxpMKKwJDVcNm6CizKkQlhX/1dHupgf0b4BwaBmDrZJCYEKw5s
         0ZMHmcKbY+Wu7JJtC9QdVdyNf2XKXE3zzbDBpVW0xNpG6i59z7lj9p5zdrDF5OhK23B1
         nhFR/cdzE6O2jB6CT6m2n3JNBYaGC6cCnd4GI7z+qoAwVyNyDxhmV0efuaXCyQNPIQ1P
         fWSYZnhG63Mdh16l3efX+uWpSh5LxFmID8PbU15f/doK333/Dsa1srFdk87RarxzuWIk
         9bb24J1QoNm53fJ+hKCMTKMbUp7AK53EEFCvd+lI1RCj+vP5ikvQ/TJvp9JrUiCSYJoN
         E4EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788539787; x=1789144587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3e6DJ/udgPJQWJmYBhE0yZNk1UbRH55dAvVIgnRQMGU=;
        b=jbyJcOTH6Nv4ksgdqBij/+YXhoyvHH7FfQvXLVe9fHcYxRasplTCQM6ic2HeVXwxBT
         V15ZnQwFqLdRz530KUV1rnSk/KVBfyiTfl3bI4b2h4RuOhRM4L7MGaK3AOabwUTG13pm
         zBQ3Hbp2lH02uhokTEP3Fxn2GFXijZazf6GKJ/BkQy1Ju36YDpI7yVP/+kfbdwBh94OM
         qd6SpTYWtILo6jPuvibbdS3p9cJwYJjNmz/o4tzxzPm3tLsOyaERFYBvVmKxKvyDqUmO
         f8bPf1mqYyBEfd0SolviKPrlTQfs9ope+N1JO2/Ih2lpyhMMirOFA9imVhQToMMKOpzh
         99jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539787; x=1789144587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3e6DJ/udgPJQWJmYBhE0yZNk1UbRH55dAvVIgnRQMGU=;
        b=ZeZeZlA70qy08kp+YCO5b70bKfjIpScsb02CQV5ThjfsUM/DYUd0EqTTOo8Qmr+x5c
         TDBpvvsVcKIlcXKQwdCSeTOC9WSFyzBJdke4AkHm9+gQl5qm/nRr02m3N4FnyMw/AOtM
         mXn7dz/MKF0gyuqhCy+eOIzGxhcKfyZeKoz33J1RqapkmT1vI1++jmLRFitY4pdw1U35
         gx/wMkoSpfIyi8D6WDhteQH17i8oM/yAsfrBUwcaTQx4g3CoPBl55L/EcdrxyiKtuZ8e
         bpCaQw/qe9wKpxPCZPFZm4sIkiw5Ei+jscvjcEhVF+V4XoD/Y47oJ74N4jN/7J+sYMWT
         assA==
X-Forwarded-Encrypted: i=1; AKwUvBwho2GZt3Jlrd734P5dRqUlCcjaPG0g5Cim4qOVvYiDTLSVSDvtgkuZoRu30oEGBgNQBJY1LYQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l9ykbpHIlIakdK2+scFRztp68uH5rtL6Z/6uEkBvheAnFizIXq
	9wVRYysPFk7FfzIBeVIJPJ1/lLfcxWWf+82N48OJHyoZtinaAp4VOvt6NOwVGFq8prBCnzwLnw4
	oSfIFAzZJPzt7rDiREl8wZ8pJjNt+9ipqxT6hRyJg
X-Gm-Gg: AYBFou3sLdMfgTnVGjZ4MzQ+RdXCCLPNuuCox8pCvZyCQPgGRZ8WPvaLvBOyDo/Wmn+
	9FXVatlOZG+/p8ArFGeRiKv3K7POF2v6ccWh/kOMk+VvZP5pM4o/YJyS1Qx5ODZBdk8hqOaasbH
	38OLb/7qlKV9/sp6qf814UVu9uZ5D4f2WSOkeskQI0CpORKRQfDrsUQMLhYrkDMM+RNZLqtw6G0
	GYpBEmdlB8Racxh002mR6llvVyfEar5M56mKumjWgBowZ97RMbgnH3k6vQTUwEo5XJ5wXPPSVIx
	h5/xXUHXCvJ3SJpKZ7vkDN1k31AlJez7/4TlAh16RmNiZF8x/es95ECeHDxNC6t/MTT45vHIjou
	q27OZajmTy++GRcGmBWKRyp7INzgTh14ta+eXi29kQ0M6L8fQUEkiYtRZjkYWiKou0osaECLw4X
	fLJgWNNxgtYfEacfzTnk2ntco=
X-Received: by 2002:a05:6820:1f07:b0:6b1:c181:9386 with SMTP id
 006d021491bc7-6b6fd5d0472mr5250164eaf.29.1788539786306; Fri, 04 Sep 2026
 09:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902203722.926528-10-kuniyu@google.com> <178849139948.4131868.2733291067982297494@kernel.org>
In-Reply-To: <178849139948.4131868.2733291067982297494@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 09:36:14 -0700
X-Gm-Features: AcwNN1Xk58BF5dQ_Bb0NcU8sv2x3s8DvZ_RpYfdWZEtS8bNVXLnZXrEePRWK22U
Message-ID: <CAAVpQUDTajCP1qUaShzZia8gat=t1G3uAs6PRXccpkUirX_CYA@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 09/15] ipv6: Replace &nd_tbl with nd_table(net).
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, 
	horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org, 
	razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:10=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 1 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> - [Critical] Calling `nd_table(net)` before `inet6_init()` executes
>   results in a NULL pointer dereference during driver probe.
>
> --
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c b/d=
rivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
> > @@ -17,26 +17,27 @@
> >  #include "fs_core.h"
> >  #include "diag/en_rep_tracepoint.h"
> >
> > -static unsigned long mlx5e_rep_ipv6_interval(void)
> > +static unsigned long mlx5e_rep_ipv6_interval(struct net *net)
> >  {
> >       if (IS_ENABLED(CONFIG_IPV6) && ipv6_mod_enabled())
> > -             return NEIGH_VAR(&nd_tbl.parms, DELAY_PROBE_TIME);
> > +             return NEIGH_VAR(&nd_table(net)->parms, DELAY_PROBE_TIME)=
;
> >
> >       return ~0UL;
> >  }
> >
> >  static void mlx5e_rep_neigh_update_init_interval(struct mlx5e_rep_priv=
 *rpriv)
> >  {
> > -     unsigned long ipv6_interval =3D mlx5e_rep_ipv6_interval();
> >       struct net_device *netdev =3D rpriv->netdev;
> >       struct net *net =3D dev_net(netdev);
> >       unsigned long ipv4_interval;
> > +     unsigned long ipv6_interval;
> >       struct neigh_table *tbl;
> >       struct mlx5e_priv *priv;
> >
> >       priv =3D netdev_priv(netdev);
> >       tbl =3D arp_table(net);
> >       ipv4_interval =3D NEIGH_VAR(&tbl->parms, DELAY_PROBE_TIME);
> > +     ipv6_interval =3D mlx5e_rep_ipv6_interval(net);
> >
> >       rpriv->neigh_update.min_interval =3D min_t(unsigned long, ipv6_in=
terval, ipv4_interval);
> >       mlx5_fc_update_sampling_interval(priv->mdev, rpriv->neigh_update.=
min_interval);
>
> [Severity: Critical]
> Unlike &nd_tbl, which is a statically allocated object that is
> valid from the very first instruction of the kernel, nd_table(net)
> reads net->neigh_tables[NEIGH_ND_TABLE], which is only populated
> once ndisc_init()/inet6_init() has run.
>
> Both of the new dereferences here are on driver probe paths that can
> run before that point: mlx5e_rep_ipv6_interval() (via
> mlx5e_rep_neigh_update_init_interval()) and
> mlxsw_sp_router_neighs_update_interval_init() take
> &nd_table(net)->parms and feed it to NEIGH_VAR(), so a NULL table
> turns into a dereference of offsetof(struct neigh_table, parms)
> rather than a benign zero. For built-in drivers, drivers/ is linked
> before net/, and both the driver module_init() and inet6_init() are
> device_initcall(), so the driver can win that race and oops during
> boot.

I'm a bit surprised that IPv6 uses device_initcall() instead of fs_,
but looking at 309b905deee5, this is for IPv4 dependency.

If such a race occurs, there should be more issues, and the cleaner
way would be to add a new init level between fs and device for IPv6.


> Note that ipv6_mod_enabled() does not help here: it only
> reflects the ipv6.disable boot parameter and returns true well
> before the nd table exists.
>
> The same concern applies to any other conversion in this series that
> can be reached from driver probe or from a netdev notifier that runs
> before inet6_init().
>
> How do you want to handle this? Either nd_table(net) needs to be
> safe to call before ndisc_init() (e.g. by allocating the per-netns
> slots earlier, in a pernet subsys registered ahead of the drivers),
> or these callers need an explicit NULL check on the returned table
> before touching ->parms. Please spell out the ordering guarantee you
> are relying on in the changelog, since it is no longer obvious once
> &nd_tbl becomes an indirection through struct net.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260902203722.926528-1-kuniyu%40google.com
