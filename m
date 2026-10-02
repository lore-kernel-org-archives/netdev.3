Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82B12CDBE
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790904889; cv=pass; b=JCCPu51olShRjEhyaRk5mA1/X6EY0DUkT5pWQLcr6tYWeGmyqnQ2NbRTVBlFXjwVA0wPCvo2jnpsmmx66cLgUnr508ZbVI9EYiJ5WzN+ZuZAcWa6PnLQRgFb3mqkXcBgShynoVoFRtoXNhWxslLqQyIKTHD3qG6vgjntIC6HGrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790904889; c=relaxed/simple;
	bh=LvABtbjvj7A6GJBfnPHbTEIiCb9lcsT113hxSxjNhK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHShfvEXddgyL/724NSFKGOvPRgmPowGKMkqM0rnG9ZcLVmvIxBU3O8D5pnvzT0pZx8PYxVD1iQA9KfCOCoL8v/+5GrmP4lC4QFyA33f9G8eE7EBOWtEuCJWFvGKf+abg1T4gAHV06ERR+QIE+gzXCgwKRUdT7p3GIkGw5719/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWPen6CA; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWPen6CA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a021c28046so16125e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 18:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790904886; cv=none;
        d=google.com; s=arc-20260327;
        b=hPTkyIDaz0RoKAZ9uJvWmEZruz5JncyZ2T4s2TfbXYeGvcipOSy4d7hn46Aj6/fUMh
         uK4+fWm8M24tvGCoOEYSg9HkGVlZ1Gxz4C44afXDhZISFoF28ivJreVlvtIkPrwI75Xi
         uUH4obEQRMYS5XbWFc51O6s1gW0Br++K7+0MyDOK4PEIfbe2P5qmkkhJBlis5X3WZupc
         i0DjTwBOTTFB+AxG49Ab85Np+Qvp47QqJ5Kzt1LBgqkbg0rKrx83TjDNg8xnL/D/zMMl
         REdMeQ+s8mZeqU8ZBmUlsYwvkgy0RjczFY80z3GCXr2wtXOKhWPwbAf7yyaFg2UXB+Eb
         ASNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IsP6Mc/uiY78D8azIU9zdlPefEQI3bhdSDVtTu+Cqlw=;
        fh=npRDV3CRvJOTkbusEvETR+harBBh5KxeCcQa3aiquyI=;
        b=YhZoAH2rjYlV8hD+SR27GPa+MpBkbxG44c4i9Ny9haE0TLkmXIt4a0pBFXmRi6Drgx
         QzjP9c31lgkhdrzssLmezgM/XR0PmkESdn7uVQ418I9Bvq3rynrkFCJAdANSRuH4NovU
         RjREirSI9pmd8X2U8sSgZxyqhafr9K4m3dWTN7oqpswDxOawlH8sP9oB7q5tGWbACUKX
         8tO4IggwTqcUw9O2wPJ3azPSjq8XOOblZUAJNutsn52Rr2UJRHbo/BYUNgYJIvw6SqJs
         0D4m5DIfanQkRPRUKDi1ID+VKprYNQA759siX2vlBhO2aXSp/fx0FHQjOas1lAGXPzRG
         9SSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790904886; x=1791509686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IsP6Mc/uiY78D8azIU9zdlPefEQI3bhdSDVtTu+Cqlw=;
        b=fWPen6CAnkLWSSsYvGyYJraCjZRj+49DldCGh0rC2DWXzXCeaZFxp4MhUn3cu12GdL
         oVlGeXY4g0mTVqEabg6U+q5uXqaffi6APeQnVkDs4deD7oosCEJRSxrHpYAosByxBfTq
         0f+uE5HWnpbcK3A5bOvnlZMbYxKN0E7gq5V97+Pp4NCRSLEnnqGhsrZyD2NGGpPIvHSd
         1XEWA6Pmzd9eaE5ATN2xNGpz1j2jasEK7nmkXcTi2CVcKLWThWjl2JJtamhVnpkU5wAw
         NOQUJBi4/ZKQstXW08QXTXlq5l4P7ztpG3Ce694Bv29sNDAEntuckR8p1jBTiKlS0fpD
         9dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790904886; x=1791509686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IsP6Mc/uiY78D8azIU9zdlPefEQI3bhdSDVtTu+Cqlw=;
        b=UT3BUH1sTYVclL2+OhM9SBXQ4pi/52Jyo5s0WoFljDRBBIrqVbSXF5Cca5ySMn0LNw
         Mx+oWsxdenaM4Wa5DAKOZ+wylLzTZ34Y1QIMD93OmqFLNa2vUabi9hErpVeeopI1hgQB
         sJ4773fW5tR9OUHzqbRD1aoPBoqwQsSvv4W0mBo8qjIGZC/H1HBYNaKxWffPp5G08xKR
         hg+TiQkSE2gZ2Q/QT3lvuAG7OuVVCeh2U1nEMHIrvMbkF8YsXZLhLAo6RsKESVj9+amc
         JhrblIpz91332QwvqGAJvusB4LMVnj9cQ3ngdJ/MVV35AfddNKf1InXf0T/RUJVuW+x4
         zLiA==
X-Gm-Message-State: AFuF++lmwr9SHqaUt4mBpxQU0y7VHSEy605x69FL6lJZd6lPzYc2G0Ac
	mk33zXKNHAku/W8ylm47tYibeqbevOCPI5x3XaqeHZ2OZlyHhGQ0VKr7tx0nyV8Df2h/MSJ2p/x
	DPqSHYaAyqSth4Ez5rYTbj7DqnKJKzix0KyqyzQFmZE6QfsGpv1S9WaCyHrg=
X-Gm-Gg: AYBFou1MURL9rScZFRrQWKNWfGihpXqAURk58ZUaOWPOV1l7yPnuh8mix6uvYNQXnH0
	GAN50yd2vvSMi/4D2XgBVtYb/mo5EsoXJY9baDlrc/Z1IjpUO11O7uWIoCV+KP55NKF+g3M4xk1
	5TloEbKMDLU7Heq1i+bixKLImmObIHQ3RmeuczBrb4UnskxH/IpJsSi7Yt4aZRT5NFfDpY+WrBz
	Abm8rYVxOwso8NGDpLJ3RyPDcVugQpPwLKRoBM8hM8vznRy3EJXNc9uCwVQzfZmvkLWD8Mmgt7E
	riql+dBsZUbq25UCEY/wIzS6gSn7mdCzugXDWYd6IVJzhGsnKDMuFFmGpKGfX3KFITNhIjBJcJB
	iqZwJyMvcNCbC
X-Received: by 2002:a05:600c:581a:b0:4a0:c34:7af3 with SMTP id
 5b1f17b1804b1-4a0394b2159mr291695e9.7.1790904885469; Thu, 01 Oct 2026
 18:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929010058.4063305-1-namangulati@google.com> <179090301201.434549.1629224862256105592@kernel.org>
In-Reply-To: <179090301201.434549.1629224862256105592@kernel.org>
From: Naman Gulati <namangulati@google.com>
Date: Thu, 1 Oct 2026 18:34:31 -0700
X-Gm-Features: AclHuK_xXwCkxLEkQGHa-YCaUZQfm2I2kF5crVbXBZ0Bv8uZsmzgUXCWCMKZa0g
Message-ID: <CAMP57yU6Ghd4AG266kETfq1-o0n86ufRA6+ucZtnMO63YGXfog@mail.gmail.com>
Subject: Re: [PATCH net v2] net: gro_cells: prevent enabling threaded NAPI on gro_cells
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de, 
	kuniyu@google.com, syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:03=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The rewritten modify_napi_threaded() (net/core/net-sysfs.c) uses
>   NAPI_STATE_NO_BUSY_POLL to mean "this NAPI cannot be threaded".
> - [Medium] The commit message says the patch makes the write fail with
>   -EOPNOTSUPP "when trying to enable threaded NAPI via sysfs" on netdevs=
=E2=80=A6
>
> --
>
> net: gro_cells: prevent enabling threaded NAPI on gro_cells
>
> This patch changes modify_napi_threaded() in net/core/net-sysfs.c.
> A write to /sys/class/net/<dev>/threaded now reaches netif_set_threaded()
> only if at least one NAPI on the device lacks NAPI_STATE_NO_BUSY_POLL.
> The goal is to stop threaded NAPI from being enabled on per-CPU gro_cells
> NAPIs, where the local_lock does not provide cross-CPU exclusion.
>
> Closes: https://lore.kernel.org/netdev/6aad6d7b.0c43d342.320d00.0001.GAE@=
google.com
>
> > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > index 352173df75785..286c7b4139df1 100644
> > --- a/net/core/net-sysfs.c
> > +++ b/net/core/net-sysfs.c
> > @@ -743,17 +743,17 @@ static ssize_t threaded_show(struct device *dev,
> >
> >  static int modify_napi_threaded(struct net_device *dev, unsigned long =
val)
> >  {
> > -     int ret;
> > -
> > -     if (list_empty(&dev->napi_list))
> > -             return -EOPNOTSUPP;
> > +     struct napi_struct *napi;
> >
> >       if (val !=3D 0 && val !=3D 1)
> >               return -EOPNOTSUPP;
> >
> > -     ret =3D netif_set_threaded(dev, val);
> > +     list_for_each_entry(napi, &dev->napi_list, dev_list) {
> > +             if (!test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
> > +                     return netif_set_threaded(dev, val);
> > +     }
> >
> > -     return ret;
> > +     return -EOPNOTSUPP;
> >  }
>
> [Severity: High]
> Does this break the threaded control on WireGuard devices?
>
> WireGuard sets NAPI_STATE_NO_BUSY_POLL on every per-peer NAPI. It also
> runs those NAPIs threaded by default:
>
> drivers/net/wireguard/peer.c:wg_peer_create() {
>     ...
>         set_bit(NAPI_STATE_NO_BUSY_POLL, &peer->napi.state);
>         netif_napi_add(wg->dev, &peer->napi, wg_packet_rx_poll);
>         napi_enable(&peer->napi);
>     ...
> }
>
> drivers/net/wireguard/device.c:wg_newlink() {
>     ...
>         netif_threaded_enable(dev);
>         ret =3D register_netdevice(dev);
>     ...
> }
>
> Once a peer has been added, the new loop never finds a NAPI without
> NO_BUSY_POLL. Writing either 0 or 1 to /sys/class/net/wg0/threaded then
> returns -EOPNOTSUPP:
>
> threaded_store()->netdev_lock_store()->modify_napi_threaded()
>
> Before this patch, a non-empty napi_list reached netif_set_threaded().
> A call to netif_set_threaded(dev, 0) succeeded and stopped the kthreads.
>
> Netlink does not offer another way to change this. napi_hash_add() skips
> NO_BUSY_POLL NAPIs, so WireGuard NAPIs never get a NAPI ID. netdev-genl
> exposes threaded only per NAPI, through napi-set.
>
> As a result, threaded_show() still reports 1 on WireGuard, but users can
> no longer turn threaded mode off. The ABI document for this file says:
>
>     User could set this value to enable/disable threaded mode for all
>     napi belonging to this device
>
> The gro_cells problem comes from per-CPU cells protected by a local_lock,
> not from NO_BUSY_POLL itself. Would a dedicated marker for NAPIs that
> cannot be threaded work better here, similar to the NAPI_STATE_NO_THREADE=
D
> approach in v1? The patch carries Fixes: tags, so this change would also
> reach stable kernels.

This and the below finding both stem from not being able to set
threaded =3D 0. I missed handling this. Wireguard setting threaded napi
by default along with NAPI_STATE_NO_BUSY_POLL deffinitely complicates
this further. It might become an overengineered fix to tighten the
loose sysfs interface when netlink already provides stricter control.
It may be a better to just update the gro_cells documentation to state
that it does not support threaded napis. May respin accordingly if I
cannot find a clean way to tighten this interface.

>
> [Severity: Medium]
> Should the NO_BUSY_POLL check apply only when val is 1?
>
> The commit message says:
>
>     Check NAPI_STATE_NO_BUSY_POLL in modify_napi_threaded(), and fail ear=
ly
>     with -EOPNOTSUPP when trying to enable threaded NAPI via sysfs on
>     netdevs where all NAPIs have NAPI_STATE_NO_BUSY_POLL set.
>
> The loop also runs when val =3D=3D 0, though. gro_cells_init() sets the f=
lag
> on every cell NAPI:
>
> net/core/gro_cells.c:gro_cells_init() {
>     ...
>                 set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
>     ...
> }
>
> On gre, vxlan, geneve and other devices backed only by gro_cells, writing
> 0 to threaded used to reach netif_set_threaded(dev, 0) and succeed as a
> no-op. It now returns -EOPNOTSUPP.
>
> The commit message avoids napi_id_valid() because it "can potentially
> break userspace". Could this change also break scripts that write 0 to
> threaded on every interface? If the change is intended, could the commit
> message mention it?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260929010058.4063305-1-namangulati%40google.com
