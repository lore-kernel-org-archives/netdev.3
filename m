Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792741006;
	b=fhSnMj1vBJUq4jEu6C2oq/46/gUyPV+UfeuXSY4gln2HuOXwQHpcI1BFPsYBSiRMCXJL
	 P9xy9DgzOfT8fNJRvEkTx48yQ+T2n+IcgbCDIrE44tgn/Zk/QYEFKgC+YMBLwv8Rt61Es
	 pMLZXpTa9IDDcX+vxf0JQaWcb2u+jE0UieoImgbs3cVYFLJblQu+QbndftDJFBXcqr4L3
	 pysuJ4hWg1ouLDigGBkKjiOMvj+XLrPxhfE33tsyeyuvqWh3nm7WjhQRBgRwJcdJ6mGYV
	 OxiAqKIXZi/dAyiwW0gGo1DfcqTz5u8ebf7lneT8GNxmlB3tjboxGtzwQnEOMw1624w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LEwT0YhXrskx2vnf/jESb/aGipGf5XisCm0pn5WijMA=;
	b=Xii4ADVdffI9RN+44kprAGGMDZD9agPOeoniasV4tC8DyHDNgRV2x+41a1QxgyTRGoQA
	 K1vBXDo1eRuzNUUMz2buUEBeXBSpqRzj1Cn7mfo94+gwPkVCQhu5InXJBR8Dtw+UqTS94
	 tlt0Q3U95rziNGtvrndo9wD8zZPS1V9RGzYNw2vtDuxaYsUvoA7fW5DF9Xoxagp+ekByk
	 uEyfoSkpydzlHiI5dmavs1iUMUQwDkDVlnpR69i2sMpVZM45PcFMfmK4HqDHox2k4PD/w
	 NHizpxe2CT4NC513/WGy7Qu6AKM8/4tWFaMmtk1QLY6LKcow9l1Vk/3K1+6TWNhvfQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gSRiq3LB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF52606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FF52606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gSRiq3LB
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba3fba0080so404980e87.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792741004; cv=none;
        d=google.com; s=arc-20260327;
        b=ZBGU4GhCg+CGD/Qu12ge9xwU+QGh9tvcfv/CNVpGkWGE4tUAiCMC9SNCTEgM44cSIi
         7NsZxb7b4ZiLiWiO2JWfLv89EBbmX8F7RiSRg/rQWN2SYIPMnyTDlDL/9qa6v4dW/GL0
         ylzsz3jbpErLAchGlmfuT49rovmdUZWp7Ke2mSnlPqKH2bwFWpU3ONMuqZ89H3XGMQSI
         fwM1wJuZ1UNWKCc/IxV0l1JgUwsKYZcjWm1hrBzwAtj5qMWoVsAiMgD0ekAn0t74ThHr
         HmbBiL7woaTL3I/GQaMJDS6cj62jZHvP1NdCShc+gyA5nfnHLNOxOXvZh3BEs/2KgV39
         Hh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LEwT0YhXrskx2vnf/jESb/aGipGf5XisCm0pn5WijMA=;
        fh=zCH6BV5qTZdebWtQ54Bt/oHrSpF7jnJEMPh5LYl//do=;
        b=HDijJNiOE2+4fLWqveHUGBqVZnWA6Ar05NJ5oU+0wjSOb0XbFOm2TRIpeBpNrb6dW6
         QhHANvhkwZmIqlNBKe6NXqYsPUsYZdFOPcg1BxCc9R49Ib/+QbnPNDLCoWnJdGjt+eRF
         4tcNgeOwW3MORUYxuAjXPfdqTU2Vb1/CEQLyTJ5oXsyucamiRzUew7EyJC6z7cWElSEB
         y3u25pln1cVe5OAx1KnpXV4USz3WIIBagk+AUqFAN1nDRtRF6g0rER7clAKAoaVVc0bS
         8W2/eotTo/njirHGwvR/1e429ODoHWoDfDCeAsi+eWMtMqqQaXEv4jFrOr1j0Zb2IY4Y
         DrEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741004; x=1793345804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LEwT0YhXrskx2vnf/jESb/aGipGf5XisCm0pn5WijMA=;
        b=gSRiq3LB1p025Dt8CY+r6baTbk/WIx+K8TCoKBHZY8hVC9FCWTwoFwJS5/Az9iXymF
         c0PBJZSB/h4meUizqJzhevVx7Q/XzFq7VEvoWByLHEszgyVn31JaoOPlEXkTqT9zOGQ5
         rDCUC2NzF7dCVm2USErYluhZWRZffLzh0uiMmCErA9D6JGqzwQt2eHQoC7eoG6vJ4v1E
         BLXtTDN21SXzSBYmeTu2VPmu/YfrFB86Nc2/+eWE9S9UXaGiao3cNl1LImzQHXQO60mc
         zhar0mJPE4qo/+makKthGu5QPx49qN61sgixoNlD8jlnlPRdhdit2a44VW4KtscmDpBt
         O7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741004; x=1793345804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEwT0YhXrskx2vnf/jESb/aGipGf5XisCm0pn5WijMA=;
        b=XL7+bGUTwCZxKDG29OUlRkKGW6X1C08JghPhGwN54Y1QwqVtrAjfhePHW/L3Sm2Dn+
         ptGkLOkSqeL2gNGw412rhXDPHqYxSRqsuoSTfOWGogyLgyOSmHFLu4NUqTP0PpwSRuU0
         DMZf6wM3HnSFQa+34VCygvH0xb7ZamuLW3ZrAbf/SWjFx2HZkKm8oimE4qflLzkesmhQ
         8IgksK+eFDSnF7VEViGoCVJ/FAjLnCAT4vSsrHph7L84vYfhM+p1WRN02r7jfnFiTYqv
         X97VDMJJpgqWQGpjCWBOyzKD1Ky6URd5cYGf/n2JeI/dLIbAlcqPQ1NuvKU13k2dwDhM
         XQ5A==
X-Forwarded-Encrypted: i=1; AKwUvBzfUQsApLWmMZ83itGCZCeBZr+jy0Eu6Z9pTxhLCqmZ5z/O7Uk73AWkyI/iu0MyYDsDFhzRrGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPfLag1prMaO2M6GhSc/A7A7FcxwMxN+cQo2fIDkSBY0R82ql6
	D+szusD4Pf1UR7Rv3iw9zgeacS1rtsp+fpgsLrqQ31uJGlo05R4QNLAkE4JeXHLPd5ytz+ptpOf
	bw3uFgANkOI0qMcUFzsuBolUn8v2z5d8=
X-Gm-Gg: AYBFou0n/M53pgZYdMlyYKoy9GbA2MLE0aEzeGLvsnxdq8ymB0WnIX79gwXM7GQV4tX
	8yF30WO3JhIXKOUFauO/FZTyDjeakfuLU3Ql2hJ4ahZwELCbb9bbV/ru32dnFsVxPR5qRy+kI67
	fR4N5oODlYieGjqX885GQcGpF7FosUCjQXd55AQFfWnracAnBNsaPwwY0VlRGczXt2sjJWNHmwe
	UehHoTLkpYZGRkyLd9nF3MtyOIFNUpA2ZEDJhAKevwJdF4IKPeDFUeEfZP+/o+JYHTMg3R0AbG4
	sm5lofKqqORlige5c7iAVP+sr6fPjlYs3jiD0ArT6FQoIpl5em0l9fVFrWvEtJHm+dkYE2Pelzz
	J9vH6hYhgXuKsU7m8fyQoOHQMqGPztxIMPZ3+
X-Received: by 2002:a05:6512:1195:b0:5bf:a8fa:2dcd with SMTP id
 2adb3069b0e04-5bfb0b41ec2mr393486e87.43.1792741003205; Fri, 23 Oct 2026
 00:36:43 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021065750.2069795-1-anilkaushikwireless@gmail.com> <179273868210.3134.12145105670992560597@kernel.org>
In-Reply-To: <179273868210.3134.12145105670992560597@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Fri, 23 Oct 2026 13:06:30 +0530
X-Gm-Features: AclHuK_55cXWNO0jBsFGdH-QWTewaPnfJE6BaXbTxgMV5nW5-2xen-3RddkOEo4
Message-ID: <CAG0Mgm-T=n2Zq_bqMNNY3Bc9w7yUg-NMcEjzkHOKM3+9yJjfTQ@mail.gmail.com>
Subject: Re: [PATCH net] gtp: Require 'CAP_NET_ADMIN' when joining the gtp
 multicast group
To: netdev-bot+sashiko@kernel.org
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, nicolas.dichtel@6wind.com, 
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 12:28=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] After this patch, the multicast group and GETPDP carry the
>   same PDP-context data but are guarded by different checks.
>
> --
>
> gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group
>
> This commit marks the gtp generic netlink "gtp" multicast group with
> GENL_MCAST_CAP_NET_ADMIN, so joining it requires CAP_NET_ADMIN in the use=
r
> namespace owning the network namespace. The goal is to stop unprivileged
> users from reading PDP context notifications that GETPDP restricts to
> CAP_NET_ADMIN holders.
>
> > diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> > index 69fe5717846b5..e5ff1621ed620 100644
> > --- a/drivers/net/gtp.c
> > +++ b/drivers/net/gtp.c
> > @@ -118,7 +118,8 @@ enum gtp_multicast_groups {
> >  };
> >
> >  static const struct genl_multicast_group gtp_genl_mcgrps[] =3D {
> > -     [GTP_GENL_MCGRP] =3D { .name =3D GTP_GENL_MCGRP_NAME },
> > +     [GTP_GENL_MCGRP] =3D { .name =3D GTP_GENL_MCGRP_NAME,
> > +                          .flags =3D GENL_MCAST_CAP_NET_ADMIN, },
>
> [Severity: Medium]
> Does this make the multicast group check the same as the one on GETPDP?
> The commit message says:
>
>   GETPDP requires CAP_NET_ADMIN, but generic netlink lets any user join a
>   multicast group by default
>


> All of gtp_genl_ops (NEWPDP, DELPDP, GETPDP doit/dumpit, ECHOREQ) use
> GENL_ADMIN_PERM. genl_family_rcv_msg() checks it like this:
>
> net/netlink/genetlink.c:
>         if ((op.flags & GENL_ADMIN_PERM) &&
>             !netlink_capable(skb, CAP_NET_ADMIN))
>                 return -EPERM;
>
> netlink_capable() ends up in netlink_ns_capable(skb, &init_user_ns, cap),
> so it needs CAP_NET_ADMIN in the initial user namespace.
>
> genl_bind() checks the new flag against the netns owner instead:
>
> net/netlink/genetlink.c:genl_bind() {
>     ...
>                 if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
>                     !ns_capable(net->user_ns, CAP_NET_ADMIN))
>                         ret =3D -EPERM;
>     ...
> }
>
> Take a gtp device in a netns owned by a non-init user namespace, where an
> init-ns daemon installs PDP contexts through GTPA_NET_NS_FD (gtp_find_dev=
()
> calls get_net_ns_by_fd()). gtp_tunnel_notify() multicasts to
> dev_net(pctx->dev):
>
>         ret =3D genlmsg_multicast_netns(&gtp_genl_family, dev_net(pctx->d=
ev), msg,
>                                       0, GTP_GENL_MCGRP, GFP_ATOMIC);
>
> Root inside that container would get -EPERM from GETPDP and the dump. It
> could still join the "gtp" group and receive every NEWPDP, DELPDP and ech=
o
> response notification. These carry the MS and peer addresses, the TEIDs,
> and the TID and flow label.
>
> When the UDP socket lives in the host netns, container root has no other
> way to see the TEIDs and peer addresses.
>
> Genetlink has no init_user_ns scoped GENL_MCAST_* flag. Making the two
> checks match would need a core change, or moving the ops to
> GENL_UNS_ADMIN_PERM if userns scope is the intended policy.
> net/ipv6/ioam6.c already pairs GENL_ADMIN_PERM ops with a
> GENL_MCAST_CAP_NET_ADMIN group in the same way.
>
> This patch does block fully unprivileged users. The commit message also
> says "in the user namespace owning the network namespace".
>
> Could the commit message say that the multicast check is still weaker tha=
n
> the GETPDP check?
>
Right, it should. v2 says it: the group check is still weaker than the
one on GETPDP, as genetlink has no multicast group flag for the initial
user namespace, and this fix blocks the unprivileged users.

pw-bot: cr
> >  };
> >
> >  static void pdp_context_delete(struct pdp_ctx *pctx);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261021065750.2069795-1-anilkaushikwireless%40gmail.com
