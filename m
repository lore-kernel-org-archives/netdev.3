Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277437BE9C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209280; cv=pass; b=QWwGy2S8EixL9JhxkJKtl60PygnAOwBdx5c2s5rcf0jj6prI2pSLIfwya88wFqEg10aibfaQej8NJ/wycNWTenBj+QgNaCof2PR4oWdcYpte+dFAz4htzWHVv1C7gEa3Buyyd6xN2bm1USZHEOkMqWfRWVH6w1OErbTuuOIgy1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209280; c=relaxed/simple;
	bh=hhuWHmcEcxsKvhS9sbtLIGNZf4qLedAC8UG5G9HwubU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdVVBmDcSisRBUPFH7A4HU/IA1EpWCXVx73bg1OzGovrEj0ZjeIkcl5VuiplaYBOoL/dVFKtxiq5GwJwiMAWdWF9N4SiW6pPwsCLp4eD7MWmbV+D8ZPVduNWcUPnEf0lNca7Ol5W+RLZK6FtpRj9SfqwUo8tvqKMMKwDurcJNgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBKhmOG/; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBKhmOG/"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f4df360cc9so386667a34.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788209276; cv=none;
        d=google.com; s=arc-20260327;
        b=ferKqmBqyYAhLbd7bHBs5L7JZkOaC22+ZBJNjPc2YfLByQbhDK2vwpXo6PA1olhN7U
         MvgDVZX/IcPI7YPn/TLkd7Wvb7UxvBSaBYXH4NfqQRq2fl49ddJIiErdU2ynPJxGbUYx
         AJ+9oDm4xGvfMzFjDmkvmw4uijoMzHt0McNjbSM/wu5cFoUSFS+6f3iYu4LWrvWWDYY4
         qpc0vG505yoGndeS5YKtNvAlOKA5V4QP5dF8DYyA3Cd+UGhuU6OeLhznqBeP0NRze/iC
         yxdKKXgWvgGgT/zjESY4Ie1Wu06AdyCBbRLL4cEZ+iWwQEKUc/9dUmcNA1TBekhtjatd
         CtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V8dQN9JA04QBv9tzMHGtm9rt1cTu8L8x+YNvABgQydg=;
        fh=o//pm+XYrLHigqLmIT+6nWxHE1eP76hmKQEXRW2O0WQ=;
        b=IyE9z+rwr7AiHOMpY6bqNZpW+jugu3hHbSRSc2GfEGUCXP9y375ns4woEltOOjUsSj
         bRB8U1eJDMTa+Vr2xeF4iVzoUex8oCRRQ7A3UwjEtiNK5u7Oby7L4TOrai37CP0okhpc
         OJERPwmeO/KkVX6376XZjMj5iUy50nGe65pcM0OxjpXhvwSHwEvAGFHEaG+73bgA5KNE
         MgUmZEhD8Nnj45zSrqFFBpC90uSlqFFhEbmL7qMps5Bd66eE2gnBfTjuRGM9sa/UIxuy
         Ybvnm41tN3Su+NDqtZIS13t94BkDUr8jlqQg7ceUf8n05RWmoSs0gd4sGlYximX8qb2Y
         n0hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788209276; x=1788814076; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V8dQN9JA04QBv9tzMHGtm9rt1cTu8L8x+YNvABgQydg=;
        b=cBKhmOG/2YEh+5O/q7SLvyAV5UPVK6HXERU39eyVVBjSLzes28g8P3UOmnG5Jy44V/
         yUfLjE6lslVclchhzfb+QSS/VUiy6cJ8xD8m+2G6/iKQdF7kGb/d5/qi89PqXN8F6VMb
         Mq9buPJYtg5vAGr17Napd78PJeBo2C9Fh72cerAcdQy8TVn+pxbLn0OuRlU/cSBjvaO6
         i8/iRb8s3YRUyNIBlr1h6/iUCWJhXmRVpb7qjvkS+yv4RfkHiwg/xpPRPmvmj/x+MTqv
         XO+Zq7/Qq7mF9YlhEKvuugGGUGfkiDxYMmGd78kKaHrvxqu4W555hCUwJUKGfgSNKJ81
         10zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788209276; x=1788814076;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V8dQN9JA04QBv9tzMHGtm9rt1cTu8L8x+YNvABgQydg=;
        b=ehyqnYSZnd+5fqJLuAOI+rkOdLPTooB6u7LuyDHJGiKiCg7w0s5VcXPrnnUNQ7GssS
         eJF5dvSaJNgXUwNPFTFYSVHe5VSM2nFsrFKJgOEcfzFtrGt5tHLtYHaW0Ymz2RRsrkJn
         Lr3f8yCkJOO5+p7Hagmg8qbeILrzfpW2aQ1xn+Eu/KC9AD0xoHRJxm35bFQF81tDmNVq
         +11U6z2IiI19TMMJ93rXLKniym5LtATdPoCnzphcJroyWZW8SvkIHeQJADiTYpWY1Cmq
         ZUULePL1lIbIHATN8zYPMeaq5/gLkzrtpnOa9rcHqAm7pqJf6ixVhCTG1vDCugaceJDE
         +urQ==
X-Gm-Message-State: AFuF++mO2lkg90pp//EO0gy6Vzi66KKJPc3gVjZUGNKGOXjFfVbCvmEz
	DoKapEp9gPTRCyRzxvHe1F46REst2PDNyPTdTNtKKCgc4cNSjXlpVnIxGXOxLTbTZaQXPP1g28N
	lthDw7uzgzhL/s0nk+vor2mHpSLxZnb0=
X-Gm-Gg: AR+sD11l5oQWUW34vQhZ/a16aXLxfiWAOes5wAA2Xdtzk4SFVxlicBDaqbgLkxMTEl4
	MysqpNvl35/UtmrTQEgAxXnPTwzkMSabQ9BztfQsIuK3ylNteRJzg1LtV0RjcfzoJcMNDrrdjoJ
	LECTr5NZCSwQVF8sbbrzaZl2clK88GNuLqkPEd+OFmxeECisEVqGqI01K8QyAhIlDQQoQ77/m9h
	vbV6KKr9vT9yLeKzk84HWYxl6+BtK45JNi+d03yEQoS7Z6MN5zm97c+Gjp99pHr/Ds07LbFh8Ft
	uz8Hq57z5hYh35+MIT/O74jNPHO3JtjM+DY7aj5P8MW+D3gElxEEqslZ
X-Received: by 2002:a05:6830:710c:b0:7f4:d6ff:230f with SMTP id
 46e09a7af769-7f68f237948mr1105917a34.0.1788209275964; Mon, 31 Aug 2026
 13:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829170656.15548-1-suruurism@gmail.com> <000101dd3986$7f498b30$7ddca190$@oss.qualcomm.com>
In-Reply-To: <000101dd3986$7f498b30$7ddca190$@oss.qualcomm.com>
From: Suruur <suruurism@gmail.com>
Date: Mon, 31 Aug 2026 23:47:44 +0300
X-Gm-Features: AcwNN1WdwJUhYkjDhm1bi_8r_T2BYnUJatoeA9KvuJJrr0SFc-wEo1WWoQbiCsM
Message-ID: <CAFkjbpACa31H6z3rDYmwB4z1S65soGA730uZj__bS3TXctWXyA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: qualcomm: rmnet: require CAP_NET_ADMIN in the
 real device netns for config ops
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sean.tranchetti@oss.qualcomm.com, horms@kernel.org
Content-Type: multipart/mixed; boundary="000000000000adc348065a5dead1"

--000000000000adc348065a5dead1
Content-Type: multipart/alternative; boundary="000000000000adc348065a5deacf"

--000000000000adc348065a5deacf
Content-Type: text/plain; charset="UTF-8"

Hi Subash,

Thanks for the review. Here is v4 with the comment blocks switched to
the networking style per the netdev FAQ; no other changes.

Thanks,
Abdifatah

On Mon, 31 Aug 2026 at 23:22, <subash.a.kasiviswanathan@oss.qualcomm.com>
wrote:

> > -----Original Message-----
> > From: user.email <suruurism@gmail.com>
> > Sent: Saturday, August 29, 2026 11:07 AM
> > To: netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: subash.a.kasiviswanathan@oss.qualcomm.com;
> > sean.tranchetti@oss.qualcomm.com; horms@kernel.org
> > Subject: [PATCH net v3] net: qualcomm: rmnet: require CAP_NET_ADMIN in
> > the real device netns for config ops
> >
> > From: Abdifatah Suruur <suruurism@gmail.com>
> >
> > An rmnet device may be created with its real device in a different netns
> than
> > the rmnet device itself (rmnet_newlink() resolves it in link_net), and
> the
> rtnl
> > config paths below only check CAP_NET_ADMIN against dev_net(dev), while
> > mutating rmnet port state attached to the real device:
> >
> > - rmnet_changelink() rewrites the endpoint mux table and
> >   port->data_format and, via rmnet_vnd_update_dev_mtu(), can shrink the
> >   MTU of the rmnet endpoint netdevs.
> > - rmnet_add_bridge() and rmnet_del_bridge(), reachable via
> >   ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTER, flip
> >   port->rmnet_mode and port->bridge_ep on the real device's port; with
> >   bridge_ep pointing at a caller-owned device, rmnet_rx_handler() then
> >   forwards real-device ingress frames to it.
> >
> > A caller privileged only in the rmnet device's netns can therefore
> rewrite
> the
> > shared cellular data-path state owned by another netns, and steer its
> ingress
> > traffic.
> >
> > Gate all three with rtnl_dev_link_net_capable(), matching the "require
> > CAP_NET_ADMIN in the device netns for changelink" series (vxlan/geneve,
> > CVE-2026-68432).
> >
> > Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates
> > to existing devices")
> > Fixes: 60d58f971c1077 ("net: qualcomm: rmnet: Implement bridge mode")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> > ---
> > v3:
> > - cover rmnet_add_bridge() and rmnet_del_bridge() with the same gate;
> >   they mutate the same real-device port state via ndo_add_slave/
> >   ndo_del_slave and have no capability check of their own
> > - correct the impact wording: rmnet_vnd_update_dev_mtu() only reads
> >   real_dev->mtu; the MTU store lands on the rmnet endpoint netdevs via
> >   rmnet_vnd_change_mtu(), not on the real device
> > v2:
> > - drop Reported-by: (implied for the author), per Jakub Kicinski
> > ---
> >  .../ethernet/qualcomm/rmnet/rmnet_config.c    | 30
> > ++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> > b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> > index 78d4df55740a1..50c60e553d09f 100644
> > --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> > +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> > @@ -312,6 +312,14 @@ static int rmnet_changelink(struct net_device *dev,
> > struct nlattr *tb[],
> >       if (!rmnet_is_real_dev_registered(real_dev))
> >               return -ENODEV;
> >
> > +     /*
> > +      * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> > +      * but the port state mutated below is attached to real_dev, which
> > +      * may live in a different netns.
> > +      */
> > +     if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
> > +             return -EPERM;
> > +
> >       port = rmnet_get_port_rtnl(real_dev);
> >
> >       if (data[IFLA_RMNET_MUX_ID]) {
> > @@ -440,6 +448,14 @@ int rmnet_add_bridge(struct net_device
> > *rmnet_dev,
> >       struct rmnet_port *port, *slave_port;
> >       int err;
> >
> > +     /*
> > +      * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> > +      * but the port state mutated below is attached to real_dev, which
> > +      * may live in a different netns.
> > +      */
> > +     if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> > +             return -EPERM;
> > +
> >       port = rmnet_get_port_rtnl(real_dev);
> >
> >       /* If there is more than one rmnet dev attached, its probably being
> > @@ -488,7 +504,19 @@ int rmnet_add_bridge(struct net_device
> > *rmnet_dev,  int rmnet_del_bridge(struct net_device *rmnet_dev,
> >                    struct net_device *slave_dev)
> >  {
> > -     struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
> > +     struct rmnet_priv *priv = netdev_priv(rmnet_dev);
> > +     struct net_device *real_dev = priv->real_dev;
> > +     struct rmnet_port *port;
> > +
> > +     /*
> > +      * The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> > +      * but rmnet_unregister_bridge() below clears the bridge state of
> > +      * the real device's port, which may live in a different netns.
> > +      */
> > +     if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> > +             return -EPERM;
> > +
> > +     port = rmnet_get_port_rtnl(slave_dev);
> >
> >       rmnet_unregister_bridge(port);
> >
> > --
> > 2.53.0
>
> The change itself is fine though you might need to update the comment style
> to match the networking convention
>
> https://www.kernel.org/doc/html/v5.7/networking/netdev-FAQ.html#q-is-the-com
> ment-style-convention-different-for-the-networking-content
> <https://www.kernel.org/doc/html/v5.7/networking/netdev-FAQ.html#q-is-the-comment-style-convention-different-for-the-networking-content>
>
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf2..5d0a4a428e97 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -312,6 +312,13 @@ static int rmnet_changelink(struct net_device *dev,
> struct nlattr *tb[],
>         if (!rmnet_is_real_dev_registered(real_dev))
>                 return -ENODEV;
>
> +       /* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +        * but the port state mutated below is attached to real_dev, which
> +        * may live in a different netns.
> +        */
> +       if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
> +               return -EPERM;
> +
>         port = rmnet_get_port_rtnl(real_dev);
>
>         if (data[IFLA_RMNET_MUX_ID]) {
> @@ -441,6 +448,13 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>         struct rmnet_port *port, *slave_port;
>         int err;
>
> +       /* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +        * but the port state mutated below is attached to real_dev, which
> +        * may live in a different netns.
> +        */
> +       if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +               return -EPERM;
> +
>         port = rmnet_get_port_rtnl(real_dev);
>
>         /* If there is more than one rmnet dev attached, its probably being
> @@ -489,7 +503,18 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
>  int rmnet_del_bridge(struct net_device *rmnet_dev,
>                      struct net_device *slave_dev)
>  {
> -       struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
> +       struct rmnet_priv *priv = netdev_priv(rmnet_dev);
> +       struct net_device *real_dev = priv->real_dev;
> +       struct rmnet_port *port;
> +
> +       /* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +        * but rmnet_unregister_bridge() below clears the bridge state of
> +        * the real device's port, which may live in a different netns.
> +        */
> +       if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +               return -EPERM;
> +
> +       port = rmnet_get_port_rtnl(slave_dev);
>
>         rmnet_unregister_bridge(port);
>
>
>

--000000000000adc348065a5deacf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Subash,<br><br>Thanks for the review. Here is v4 with t=
he comment blocks switched to<br>the networking style per the netdev FAQ; n=
o other changes.<br><br>Thanks,<br>Abdifatah</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 3=
1 Aug 2026 at 23:22, &lt;<a href=3D"mailto:subash.a.kasiviswanathan@oss.qua=
lcomm.com">subash.a.kasiviswanathan@oss.qualcomm.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; -----Original Mess=
age-----<br>
&gt; From: user.email &lt;<a href=3D"mailto:suruurism@gmail.com" target=3D"=
_blank">suruurism@gmail.com</a>&gt;<br>
&gt; Sent: Saturday, August 29, 2026 11:07 AM<br>
&gt; To: <a href=3D"mailto:netdev@vger.kernel.org" target=3D"_blank">netdev=
@vger.kernel.org</a>; <a href=3D"mailto:linux-kernel@vger.kernel.org" targe=
t=3D"_blank">linux-kernel@vger.kernel.org</a><br>
&gt; Cc: <a href=3D"mailto:subash.a.kasiviswanathan@oss.qualcomm.com" targe=
t=3D"_blank">subash.a.kasiviswanathan@oss.qualcomm.com</a>;<br>
&gt; <a href=3D"mailto:sean.tranchetti@oss.qualcomm.com" target=3D"_blank">=
sean.tranchetti@oss.qualcomm.com</a>; <a href=3D"mailto:horms@kernel.org" t=
arget=3D"_blank">horms@kernel.org</a><br>
&gt; Subject: [PATCH net v3] net: qualcomm: rmnet: require CAP_NET_ADMIN in=
<br>
&gt; the real device netns for config ops<br>
&gt; <br>
&gt; From: Abdifatah Suruur &lt;<a href=3D"mailto:suruurism@gmail.com" targ=
et=3D"_blank">suruurism@gmail.com</a>&gt;<br>
&gt; <br>
&gt; An rmnet device may be created with its real device in a different net=
ns<br>
than<br>
&gt; the rmnet device itself (rmnet_newlink() resolves it in link_net), and=
 the<br>
rtnl<br>
&gt; config paths below only check CAP_NET_ADMIN against dev_net(dev), whil=
e<br>
&gt; mutating rmnet port state attached to the real device:<br>
&gt; <br>
&gt; - rmnet_changelink() rewrites the endpoint mux table and<br>
&gt;=C2=A0 =C2=A0port-&gt;data_format and, via rmnet_vnd_update_dev_mtu(), =
can shrink the<br>
&gt;=C2=A0 =C2=A0MTU of the rmnet endpoint netdevs.<br>
&gt; - rmnet_add_bridge() and rmnet_del_bridge(), reachable via<br>
&gt;=C2=A0 =C2=A0ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTE=
R, flip<br>
&gt;=C2=A0 =C2=A0port-&gt;rmnet_mode and port-&gt;bridge_ep on the real dev=
ice&#39;s port; with<br>
&gt;=C2=A0 =C2=A0bridge_ep pointing at a caller-owned device, rmnet_rx_hand=
ler() then<br>
&gt;=C2=A0 =C2=A0forwards real-device ingress frames to it.<br>
&gt; <br>
&gt; A caller privileged only in the rmnet device&#39;s netns can therefore=
 rewrite<br>
the<br>
&gt; shared cellular data-path state owned by another netns, and steer its<=
br>
ingress<br>
&gt; traffic.<br>
&gt; <br>
&gt; Gate all three with rtnl_dev_link_net_capable(), matching the &quot;re=
quire<br>
&gt; CAP_NET_ADMIN in the device netns for changelink&quot; series (vxlan/g=
eneve,<br>
&gt; CVE-2026-68432).<br>
&gt; <br>
&gt; Fixes: 2abb5792387e (&quot;net: qualcomm: rmnet: Allow configuration u=
pdates<br>
&gt; to existing devices&quot;)<br>
&gt; Fixes: 60d58f971c1077 (&quot;net: qualcomm: rmnet: Implement bridge mo=
de&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a><br>
&gt; Signed-off-by: Abdifatah Suruur &lt;<a href=3D"mailto:suruurism@gmail.=
com" target=3D"_blank">suruurism@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; v3:<br>
&gt; - cover rmnet_add_bridge() and rmnet_del_bridge() with the same gate;<=
br>
&gt;=C2=A0 =C2=A0they mutate the same real-device port state via ndo_add_sl=
ave/<br>
&gt;=C2=A0 =C2=A0ndo_del_slave and have no capability check of their own<br=
>
&gt; - correct the impact wording: rmnet_vnd_update_dev_mtu() only reads<br=
>
&gt;=C2=A0 =C2=A0real_dev-&gt;mtu; the MTU store lands on the rmnet endpoin=
t netdevs via<br>
&gt;=C2=A0 =C2=A0rmnet_vnd_change_mtu(), not on the real device<br>
&gt; v2:<br>
&gt; - drop Reported-by: (implied for the author), per Jakub Kicinski<br>
&gt; ---<br>
&gt;=C2=A0 .../ethernet/qualcomm/rmnet/rmnet_config.c=C2=A0 =C2=A0 | 30<br>
&gt; ++++++++++++++++++-<br>
&gt;=C2=A0 1 file changed, 29 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c<br>
&gt; b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c<br>
&gt; index 78d4df55740a1..50c60e553d09f 100644<br>
&gt; --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c<br>
&gt; +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c<br>
&gt; @@ -312,6 +312,14 @@ static int rmnet_changelink(struct net_device *de=
v,<br>
&gt; struct nlattr *tb[],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rmnet_is_real_dev_registered(real_dev))=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<=
br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * The rtnl path only checks CAP_NET_ADMIN agains=
t dev_net(dev),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * but the port state mutated below is attached t=
o real_dev, which<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * may live in a different netns.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!rtnl_dev_link_net_capable(dev, dev_net(real_=
dev)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0port =3D rmnet_get_port_rtnl(real_dev);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (data[IFLA_RMNET_MUX_ID]) {<br>
&gt; @@ -440,6 +448,14 @@ int rmnet_add_bridge(struct net_device<br>
&gt; *rmnet_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rmnet_port *port, *slave_port;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * The rtnl path only checks CAP_NET_ADMIN agains=
t dev_net(dev),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * but the port state mutated below is attached t=
o real_dev, which<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * may live in a different netns.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net=
(real_dev)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0port =3D rmnet_get_port_rtnl(real_dev);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* If there is more than one rmnet dev attac=
hed, its probably being<br>
&gt; @@ -488,7 +504,19 @@ int rmnet_add_bridge(struct net_device<br>
&gt; *rmnet_dev,=C2=A0 int rmnet_del_bridge(struct net_device *rmnet_dev,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
truct net_device *slave_dev)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct rmnet_port *port =3D rmnet_get_port_rtnl(s=
lave_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rmnet_priv *priv =3D netdev_priv(rmnet_dev=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct net_device *real_dev =3D priv-&gt;real_dev=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rmnet_port *port;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * The rtnl path only checks CAP_NET_ADMIN agains=
t dev_net(dev),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * but rmnet_unregister_bridge() below clears the=
 bridge state of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * the real device&#39;s port, which may live in =
a different netns.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net=
(real_dev)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0port =3D rmnet_get_port_rtnl(slave_dev);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rmnet_unregister_bridge(port);<br>
&gt; <br>
&gt; --<br>
&gt; 2.53.0<br>
<br>
The change itself is fine though you might need to update the comment style=
<br>
to match the networking convention<br>
<a href=3D"https://www.kernel.org/doc/html/v5.7/networking/netdev-FAQ.html#=
q-is-the-comment-style-convention-different-for-the-networking-content" rel=
=3D"noreferrer" target=3D"_blank">https://www.kernel.org/doc/html/v5.7/netw=
orking/netdev-FAQ.html#q-is-the-com<br>
ment-style-convention-different-for-the-networking-content</a><br>
<br>
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c<br>
b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c<br>
index bed6f63facf2..5d0a4a428e97 100644<br>
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c<br>
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c<br>
@@ -312,6 +312,13 @@ static int rmnet_changelink(struct net_device *dev,<br=
>
struct nlattr *tb[],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!rmnet_is_real_dev_registered(real_dev))<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The rtnl path only checks CAP_NET_ADMIN agai=
nst dev_net(dev),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * but the port state mutated below is attached=
 to real_dev, which<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * may live in a different netns.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rtnl_dev_link_net_capable(dev, dev_net(rea=
l_dev)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 port =3D rmnet_get_port_rtnl(real_dev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (data[IFLA_RMNET_MUX_ID]) {<br>
@@ -441,6 +448,13 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rmnet_port *port, *slave_port;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The rtnl path only checks CAP_NET_ADMIN agai=
nst dev_net(dev),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * but the port state mutated below is attached=
 to real_dev, which<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * may live in a different netns.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rtnl_dev_link_net_capable(rmnet_dev, dev_n=
et(real_dev)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 port =3D rmnet_get_port_rtnl(real_dev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If there is more than one rmnet dev attached=
, its probably being<br>
@@ -489,7 +503,18 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,<br>
=C2=A0int rmnet_del_bridge(struct net_device *rmnet_dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0struct net_device *slave_dev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rmnet_port *port =3D rmnet_get_port_rtnl=
(slave_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rmnet_priv *priv =3D netdev_priv(rmnet_d=
ev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct net_device *real_dev =3D priv-&gt;real_d=
ev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rmnet_port *port;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The rtnl path only checks CAP_NET_ADMIN agai=
nst dev_net(dev),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * but rmnet_unregister_bridge() below clears t=
he bridge state of<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * the real device&#39;s port, which may live i=
n a different netns.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rtnl_dev_link_net_capable(rmnet_dev, dev_n=
et(real_dev)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0port =3D rmnet_get_port_rtnl(slave_dev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rmnet_unregister_bridge(port);<br>
<br>
<br>
</blockquote></div>

--000000000000adc348065a5deacf--
--000000000000adc348065a5dead1
Content-Type: application/octet-stream; 
	name="0001-net-qualcomm-rmnet-require-CAP_NET_ADMIN-in-the-real.patch"
Content-Disposition: attachment; 
	filename="0001-net-qualcomm-rmnet-require-CAP_NET_ADMIN-in-the-real.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mthpmgki0>
X-Attachment-Id: f_mthpmgki0

RnJvbSA3ZTE1YzJkODZmN2Q4ZjEzODNlMGNmYjI2OTljMmYyZTdjYTBiMmZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBYmRpZmF0YWggU3VydXVyIDxzdXJ1dXJpc21AZ21haWwuY29t
PgpEYXRlOiBTYXQsIDI5IEF1ZyAyMDI2IDIwOjAxOjI3ICswMzAwClN1YmplY3Q6IFtQQVRDSCBu
ZXQgdjRdIG5ldDogcXVhbGNvbW06IHJtbmV0OiByZXF1aXJlIENBUF9ORVRfQURNSU4gaW4gdGhl
CiByZWFsIGRldmljZSBuZXRucyBmb3IgY29uZmlnIG9wcwoKQW4gcm1uZXQgZGV2aWNlIG1heSBi
ZSBjcmVhdGVkIHdpdGggaXRzIHJlYWwgZGV2aWNlIGluIGEgZGlmZmVyZW50Cm5ldG5zIHRoYW4g
dGhlIHJtbmV0IGRldmljZSBpdHNlbGYgKHJtbmV0X25ld2xpbmsoKSByZXNvbHZlcyBpdCBpbgps
aW5rX25ldCksIGFuZCB0aGUgcnRubCBjb25maWcgcGF0aHMgYmVsb3cgb25seSBjaGVjayBDQVBf
TkVUX0FETUlOCmFnYWluc3QgZGV2X25ldChkZXYpLCB3aGlsZSBtdXRhdGluZyBybW5ldCBwb3J0
IHN0YXRlIGF0dGFjaGVkIHRvIHRoZQpyZWFsIGRldmljZToKCi0gcm1uZXRfY2hhbmdlbGluaygp
IHJld3JpdGVzIHRoZSBlbmRwb2ludCBtdXggdGFibGUgYW5kCiAgcG9ydC0+ZGF0YV9mb3JtYXQg
YW5kLCB2aWEgcm1uZXRfdm5kX3VwZGF0ZV9kZXZfbXR1KCksIGNhbiBzaHJpbmsgdGhlCiAgTVRV
IG9mIHRoZSBybW5ldCBlbmRwb2ludCBuZXRkZXZzLgotIHJtbmV0X2FkZF9icmlkZ2UoKSBhbmQg
cm1uZXRfZGVsX2JyaWRnZSgpLCByZWFjaGFibGUgdmlhCiAgbmRvX2FkZF9zbGF2ZS9uZG9fZGVs
X3NsYXZlIHRocm91Z2ggUlRNX1NFVExJTksgSUZMQV9NQVNURVIsIGZsaXAKICBwb3J0LT5ybW5l
dF9tb2RlIGFuZCBwb3J0LT5icmlkZ2VfZXAgb24gdGhlIHJlYWwgZGV2aWNlJ3MgcG9ydDsgd2l0
aAogIGJyaWRnZV9lcCBwb2ludGluZyBhdCBhIGNhbGxlci1vd25lZCBkZXZpY2UsIHJtbmV0X3J4
X2hhbmRsZXIoKSB0aGVuCiAgZm9yd2FyZHMgcmVhbC1kZXZpY2UgaW5ncmVzcyBmcmFtZXMgdG8g
aXQuCgpBIGNhbGxlciBwcml2aWxlZ2VkIG9ubHkgaW4gdGhlIHJtbmV0IGRldmljZSdzIG5ldG5z
IGNhbiB0aGVyZWZvcmUKcmV3cml0ZSB0aGUgc2hhcmVkIGNlbGx1bGFyIGRhdGEtcGF0aCBzdGF0
ZSBvd25lZCBieSBhbm90aGVyIG5ldG5zLCBhbmQKc3RlZXIgaXRzIGluZ3Jlc3MgdHJhZmZpYy4K
CkdhdGUgYWxsIHRocmVlIHdpdGggcnRubF9kZXZfbGlua19uZXRfY2FwYWJsZSgpLCBtYXRjaGlu
ZyB0aGUgInJlcXVpcmUKQ0FQX05FVF9BRE1JTiBpbiB0aGUgZGV2aWNlIG5ldG5zIGZvciBjaGFu
Z2VsaW5rIiBzZXJpZXMgKHZ4bGFuL2dlbmV2ZSwKQ1ZFLTIwMjYtNjg0MzIpLgoKRml4ZXM6IDJh
YmI1NzkyMzg3ZSAoIm5ldDogcXVhbGNvbW06IHJtbmV0OiBBbGxvdyBjb25maWd1cmF0aW9uIHVw
ZGF0ZXMgdG8gZXhpc3RpbmcgZGV2aWNlcyIpCkZpeGVzOiA2MGQ1OGY5NzFjMTA3NyAoIm5ldDog
cXVhbGNvbW06IHJtbmV0OiBJbXBsZW1lbnQgYnJpZGdlIG1vZGUiKQpDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBBYmRpZmF0YWggU3VydXVyIDxzdXJ1dXJpc21AZ21h
aWwuY29tPgotLS0KdjQ6Ci0gdXNlIHRoZSBuZXRkZXYgY29tbWVudCBzdHlsZSwgcGVyIFN1YmFz
aCBBYmhpbmF2IEthc2l2aXN3YW5hdGhhbgp2MzoKLSBjb3ZlciBybW5ldF9hZGRfYnJpZGdlKCkg
YW5kIHJtbmV0X2RlbF9icmlkZ2UoKSB3aXRoIHRoZSBzYW1lIGdhdGU7CiAgdGhleSBtdXRhdGUg
dGhlIHNhbWUgcmVhbC1kZXZpY2UgcG9ydCBzdGF0ZSB2aWEgbmRvX2FkZF9zbGF2ZS8KICBuZG9f
ZGVsX3NsYXZlIGFuZCBoYXZlIG5vIGNhcGFiaWxpdHkgY2hlY2sgb2YgdGhlaXIgb3duCi0gY29y
cmVjdCB0aGUgaW1wYWN0IHdvcmRpbmc6IHJtbmV0X3ZuZF91cGRhdGVfZGV2X210dSgpIG9ubHkg
cmVhZHMKICByZWFsX2Rldi0+bXR1OyB0aGUgTVRVIHN0b3JlIGxhbmRzIG9uIHRoZSBybW5ldCBl
bmRwb2ludCBuZXRkZXZzIHZpYQogIHJtbmV0X3ZuZF9jaGFuZ2VfbXR1KCksIG5vdCBvbiB0aGUg
cmVhbCBkZXZpY2UKdjI6Ci0gZHJvcCBSZXBvcnRlZC1ieTogKGltcGxpZWQgZm9yIHRoZSBhdXRo
b3IpLCBwZXIgSmFrdWIgS2ljaW5za2kKLS0tCiAuLi4vZXRoZXJuZXQvcXVhbGNvbW0vcm1uZXQv
cm1uZXRfY29uZmlnLmMgICAgfCAyNyArKysrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdl
ZCwgMjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3F1YWxjb21tL3JtbmV0L3JtbmV0X2NvbmZpZy5jIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvcXVhbGNvbW0vcm1uZXQvcm1uZXRfY29uZmlnLmMKaW5kZXggNzhkNGRmNTU3NDBh
MS4uNzNiZDU0MTljYjEzNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcXVhbGNv
bW0vcm1uZXQvcm1uZXRfY29uZmlnLmMKKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcXVhbGNv
bW0vcm1uZXQvcm1uZXRfY29uZmlnLmMKQEAgLTMxMiw2ICszMTIsMTMgQEAgc3RhdGljIGludCBy
bW5ldF9jaGFuZ2VsaW5rKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCBubGF0dHIgKnRi
W10sCiAJaWYgKCFybW5ldF9pc19yZWFsX2Rldl9yZWdpc3RlcmVkKHJlYWxfZGV2KSkKIAkJcmV0
dXJuIC1FTk9ERVY7CiAKKwkvKiBUaGUgcnRubCBwYXRoIG9ubHkgY2hlY2tzIENBUF9ORVRfQURN
SU4gYWdhaW5zdCBkZXZfbmV0KGRldiksCisJICogYnV0IHRoZSBwb3J0IHN0YXRlIG11dGF0ZWQg
YmVsb3cgaXMgYXR0YWNoZWQgdG8gcmVhbF9kZXYsIHdoaWNoCisJICogbWF5IGxpdmUgaW4gYSBk
aWZmZXJlbnQgbmV0bnMuCisJICovCisJaWYgKCFydG5sX2Rldl9saW5rX25ldF9jYXBhYmxlKGRl
diwgZGV2X25ldChyZWFsX2RldikpKQorCQlyZXR1cm4gLUVQRVJNOworCiAJcG9ydCA9IHJtbmV0
X2dldF9wb3J0X3J0bmwocmVhbF9kZXYpOwogCiAJaWYgKGRhdGFbSUZMQV9STU5FVF9NVVhfSURd
KSB7CkBAIC00NDAsNiArNDQ3LDEzIEBAIGludCBybW5ldF9hZGRfYnJpZGdlKHN0cnVjdCBuZXRf
ZGV2aWNlICpybW5ldF9kZXYsCiAJc3RydWN0IHJtbmV0X3BvcnQgKnBvcnQsICpzbGF2ZV9wb3J0
OwogCWludCBlcnI7CiAKKwkvKiBUaGUgcnRubCBwYXRoIG9ubHkgY2hlY2tzIENBUF9ORVRfQURN
SU4gYWdhaW5zdCBkZXZfbmV0KGRldiksCisJICogYnV0IHRoZSBwb3J0IHN0YXRlIG11dGF0ZWQg
YmVsb3cgaXMgYXR0YWNoZWQgdG8gcmVhbF9kZXYsIHdoaWNoCisJICogbWF5IGxpdmUgaW4gYSBk
aWZmZXJlbnQgbmV0bnMuCisJICovCisJaWYgKCFydG5sX2Rldl9saW5rX25ldF9jYXBhYmxlKHJt
bmV0X2RldiwgZGV2X25ldChyZWFsX2RldikpKQorCQlyZXR1cm4gLUVQRVJNOworCiAJcG9ydCA9
IHJtbmV0X2dldF9wb3J0X3J0bmwocmVhbF9kZXYpOwogCiAJLyogSWYgdGhlcmUgaXMgbW9yZSB0
aGFuIG9uZSBybW5ldCBkZXYgYXR0YWNoZWQsIGl0cyBwcm9iYWJseSBiZWluZwpAQCAtNDg4LDcg
KzUwMiwxOCBAQCBpbnQgcm1uZXRfYWRkX2JyaWRnZShzdHJ1Y3QgbmV0X2RldmljZSAqcm1uZXRf
ZGV2LAogaW50IHJtbmV0X2RlbF9icmlkZ2Uoc3RydWN0IG5ldF9kZXZpY2UgKnJtbmV0X2RldiwK
IAkJICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqc2xhdmVfZGV2KQogewotCXN0cnVjdCBybW5ldF9w
b3J0ICpwb3J0ID0gcm1uZXRfZ2V0X3BvcnRfcnRubChzbGF2ZV9kZXYpOworCXN0cnVjdCBybW5l
dF9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYocm1uZXRfZGV2KTsKKwlzdHJ1Y3QgbmV0X2Rldmlj
ZSAqcmVhbF9kZXYgPSBwcml2LT5yZWFsX2RldjsKKwlzdHJ1Y3Qgcm1uZXRfcG9ydCAqcG9ydDsK
KworCS8qIFRoZSBydG5sIHBhdGggb25seSBjaGVja3MgQ0FQX05FVF9BRE1JTiBhZ2FpbnN0IGRl
dl9uZXQoZGV2KSwKKwkgKiBidXQgcm1uZXRfdW5yZWdpc3Rlcl9icmlkZ2UoKSBiZWxvdyBjbGVh
cnMgdGhlIGJyaWRnZSBzdGF0ZSBvZgorCSAqIHRoZSByZWFsIGRldmljZSdzIHBvcnQsIHdoaWNo
IG1heSBsaXZlIGluIGEgZGlmZmVyZW50IG5ldG5zLgorCSAqLworCWlmICghcnRubF9kZXZfbGlu
a19uZXRfY2FwYWJsZShybW5ldF9kZXYsIGRldl9uZXQocmVhbF9kZXYpKSkKKwkJcmV0dXJuIC1F
UEVSTTsKKworCXBvcnQgPSBybW5ldF9nZXRfcG9ydF9ydG5sKHNsYXZlX2Rldik7CiAKIAlybW5l
dF91bnJlZ2lzdGVyX2JyaWRnZShwb3J0KTsKIAotLSAKMi41My4wCgo=
--000000000000adc348065a5dead1--
