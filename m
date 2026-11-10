Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794336946;
	b=M74AmkHJb8F3kZl+GS7Q0iQk+P8Ihzto0v/K0X+kh81/RuaXy2NN6VsiIN4nUMzOv7NS
	 xiB2TUzN14GHToDCmq6lYJ7UzwHJqAS0SYRMiMDnubsjLbK3hWZsxtM8O7ChCkX52XWAZ
	 3JXC+HFl1drE0gQtqizU70Dij8PoVRUeuM2Qm5821RfkUsg1bvJxhdmxLf+euupouMeK8
	 czPh3K/O+w/CJaYcAZeOOoucdZ+VChaE/hXBEL/U7DKUuqw+BWThSh92+siY50y6POk6l
	 Iu4Aq61zQ6Nptw3jvzvN6jt04ZXg1+9C9uOJY2+KEF7BCDQs5QYyzoCO2uacjAO/MQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0ivlR8Elzr0RKDPKrW6v3vKn86PoX8gbITXKxL4IZh4=;
	b=oVlWxnsQSchwsbnVM8k+Vo74bMujEPJAq7qT7he6RjRjlPjEZhb9XgiJxxhIT0jU2974
	 1+DkLR3qgGIKtLxIZwtj9j21ZVkhL7HLi0oaPnWQGgk2I5rCdZ9CNYHZMDDJMha2Gcdxp
	 UF4kVkyQW4GPz9LAxAiJjRFTaKIG9r81X5mZOTXRDsQwMjchil8GIlvsHSLxEeljGpuyL
	 Nz4HvKSVxKICYMnV7zOEMCQKJS94MvSvW9dhdxBvtsFFtZNy4sN9BOOBgdK/XiiBUMhAG
	 /kCI68sJNedygqUUc/lmp0QlBFhtCOy4tF+1fib7ze9VDKs/fJ3D/uCD/jWujLM/faQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l/tdJwZ5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0704606A323
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0704606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/tdJwZ5
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4d581da0aaso261225666b.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794336944; cv=none;
        d=google.com; s=arc-20260327;
        b=FBamaiNOqWkTjV4BN5MNZD1EibwkXOWGIXSDdT6UWopSFYltUT4IjnrUjf0+irtbfj
         898fvHApe3FOhQw4tVTIpnbq8YdNHbNgYG9j1eRIZk9Kq7CTTTZkouCj63k9OH3H3FJ0
         lr+y2C+7AOfZwWTnARmaey2iQqYTFK7IVNO9BFn3TVyggEtz2xyiuJL2HhSL9V2k67V5
         OgPeKbqerciQE2XviY1QRFsI498btMllgxZB3d+F/eq+LcgEFUWVUp02ygcKfCbE4YOw
         +D2AVq60nFt1iKFP0oFtkMvkoSTwfAenX7ZRymqn9x7UZEmMnmT4vfvS1O01xlThznYB
         8u4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0ivlR8Elzr0RKDPKrW6v3vKn86PoX8gbITXKxL4IZh4=;
        fh=Kqwte+pp6X+Uxjmr3KTKEDz3Hj8a+TRUAaJfF00QfdU=;
        b=pySur6qYvwvslVSM+GKOWofaF6ClPLwv5rYNZV2A3xx90lBGvr8gtOx641aq8kw1of
         ytvXSfBiPQS3q6Izc6ebKjMOjwi00mBOlPk8auQfzH94fYE5fdX4MGla9DWEC0y0pISH
         JoM3bb4RuCiZOSvffeQg04yKdy8otk8yTh8qTgfwxe+fF+ic4ZRmyaHuI3WqI2HEZbCE
         5Ns0Oq4erYC2Gcvlwm9LP+cVrThCufmvx9VQa0c4bBtuFiyhG9PkfeWPfk7WOL/DZYbt
         dqLJPKhE1xFSCsYQtQ3eCkYPwdh+6+q/g9q9dJLeVAaF8qgXUtLH2TvER+Pm/pSqCnax
         ozNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794336944; x=1794941744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ivlR8Elzr0RKDPKrW6v3vKn86PoX8gbITXKxL4IZh4=;
        b=l/tdJwZ5Gq8heVkPaFnu0gamPcOTnxGmnmA5DdZiFtYFbFFIAHvkSZR4QPjxWovkD8
         QkvjaIUBiOPzKt9xLhXpWEZZhZozTKkR5K0r5Mu+L8taj2JSpqXKTvw9RCVgWDOWlLA6
         oQcv2Kz84SKk6rkyb3R1liUJ46fJ6INuzq/I3q9YerALOQYPrj4GdOK2Urk7bL8yUtF8
         s0jB3wTQ5P8t74HTigpazEx034LWZTzDgk2ZUqtbs9Lvg1LTWMV4ciVOxQ/A46rJ3Vzl
         /7aML1Xwcf5NMNn/00bfWd/oHy4h+l7/8evsvjwhA49dIMBUc6bUl2hjF/thtM/d4DPS
         zZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794336944; x=1794941744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ivlR8Elzr0RKDPKrW6v3vKn86PoX8gbITXKxL4IZh4=;
        b=Haa4wSpozPcNKiD9U22bt35Zk+Rl2ois+Co+4VAjsUdCTQu6El0749MDNYh9Yzus1q
         vGUvBoC9y9Dzbkg196CRXhdBoq51HEc9tNiLq0ilSzXyqgJWbG8ABgESr357mECXQwfr
         Djdhiq73SKAtn4mLDghGc0Uiwoh6sPCi8bvO/8OriXosoxJoxhXk2fugLUU8PHG4aOoT
         A4HYkkKXyUmJ1oXMr/LJxsnObuWuqQffysR6/4pjtHwt91/o5hXC5K+lGMkZVA40jNZq
         t7YQeHw20PF2XEzxU/ezYe0oYpD0CkWYXOP+KTf6DZrGcM/iTBlFidxXh5OixasSZ1qm
         kZnw==
X-Gm-Message-State: APuU4Z/YLYqXqs2bzCVtKaTIazrJpl0j8dmlzvY3bvaJ/dSL5loyBoAP
	69zDMCKxBGMdSSeI2a235p6TcUTNBXvOEvAX+PxwEvTFqQ1TV8DERasXsdiJ2eq4gtxcfP2IQHm
	3Q3+rZXjzSQQL4sBESXpRcIV0poPNBqc=
X-Gm-Gg: AYBFou0V6XsA36nuTXDld0/9i1t0yVZ1ID4FgVoCJvdweHT4jPq7mOW6UWrFAM+y4GN
	5jMZ7v2f2OGZqUuLxkGpWmh41x0Cqlbr65xDO3YL+Dg9+Xgsv+EZJuPy6CzEKd2287BBWX2QTP7
	wReVNCuhZ59quSUWRt7y7BOWBAqO+HTwe+bbQcJX2VveM1SAwWZNuW6UtMagKO4GJU2FstZd/8S
	k3t4Zkh82n+BaoKg7WOnQQGh1EkFCOtO9+ahd79RYtWHi4+HZzTTjERCoCtCw7V4irVpyDDsxj2
	2jkNzonJVQM/Jewl8V4sGAeZ7oHxt4CdWOY4X3Sh/fACcWuTtF+OYUOlhEFxzsBZr6TGwq12qEp
	Cyg8qEzcmC9y+A78BQymuQXCyf9IGYrlS1b2v52Q=
X-Received: by 2002:a17:906:ee8d:b0:c46:9ca9:f524 with SMTP id
 a640c23a62f3a-c50495eff36mr325148366b.32.1794336943810; Tue, 10 Nov 2026
 10:55:43 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108180137.3488023-1-prashantsengar25031@gmail.com> <179424981810.994134.1872539285457359260@kernel.org>
In-Reply-To: <179424981810.994134.1872539285457359260@kernel.org>
From: Prashant Sengar <prashantsengar25031@gmail.com>
Date: Wed, 11 Nov 2026 00:25:31 +0530
X-Gm-Features: AclHuK98M_N84PC2kH3NuDC1U2H3UkRk2obUBFc1MTD0OhqStaiBKIsDykdBkP0
Message-ID: <CABW1sB=nc8wC=WNNRKovkHr52BQqk335ykS5Hewjx+=w1BX4Cw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: usb: lan78xx: use phylink for Wake-on-LAN
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, Thangaraj.S@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, linux@armlinux.org.uk, 
	linux-usb@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the detailed review.

The review identified valid concerns with PHY/MAC WoL ownership,
supported modes, and the default configuration. I'll address these in
a v2.

I also noted that the normal phylink resume issue has been fixed
upstream by commit be9587c47db1. I'll account for that fix and check
the remaining reset-resume interaction.

pw-bot: cr

On Tue, Nov 10, 2026 at 12:13=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 2 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] Adding `.mac_wol_set` makes phylink_mac_supports_wol() true, so
>   phylink_suspend() ignores the driver's `mac_wol=3Dfalse` argument and=
=E2=80=A6
> - [Medium] This patch removes WAKE_PHY (`ethtool -s ethX wol p`) for
>   lan78xx devices that have a PHY, and the commit message does not=E2=80=
=A6
> - [Medium] The commit message says probe 'preserves' the default magic-
>   packet configuration, but the behaviour changes.
> - [Low] `pdata->wol` has writers that disagree on what it means.
> - [Low] If phylink_ethtool_set_wol() fails in lan78xx_probe(), for
>   example because an external PHY's set_wol returns an error other than=
=E2=80=A6
>
> --
>
> net: usb: lan78xx: use phylink for Wake-on-LAN
>
> This patch moves the lan78xx ethtool WoL handlers to
> phylink_ethtool_get_wol() and phylink_ethtool_set_wol(). It adds a
> mac_wol_set callback and advertises MAC wake modes through
> phylink_config. At probe, it now sends a default WAKE_MAGIC configuration
> through phylink and sets netdev->ethtool->wol_enabled.
>
> > diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> > index d73002b2c21ac..7d67dd150271b 100644
> > --- a/drivers/net/usb/lan78xx.c
> > +++ b/drivers/net/usb/lan78xx.c
>
> [ ... ]
>
> > @@ -2617,12 +2629,24 @@ static int lan78xx_mac_enable_tx_lpi(struct phy=
link_config *config, u32 timer,
> >       return lan78xx_mac_eee_enable(dev, true);
> >  }
> >
> > +static int lan78xx_mac_wol_set(struct phylink_config *config,
> > +                            u32 wolopts, const u8 *sopass)
> > +{
> > +     struct lan78xx_net *dev =3D netdev_priv(to_net_dev(config->dev));
> > +     struct lan78xx_priv *pdata =3D (struct lan78xx_priv *)dev->data[0=
];
> > +
> > +     pdata->wol =3D wolopts;
>
> [Severity: Low]
> What is pdata->wol supposed to hold? The mac_wol_set kernel-doc in
> include/linux/phylink.h says options the PHY can handle will already have
> been removed from wolopts, so this stores the MAC-only set.
>
> Both callers of phylink_ethtool_set_wol() overwrite pdata->wol right
> afterwards with the merged PHY+MAC set:
>
> lan78xx_set_wol() {
>     ...
>         ret =3D phylink_ethtool_set_wol(dev->phylink, wol);
>         ...
>         phylink_ethtool_get_wol(dev->phylink, &actual);
>         pdata->wol =3D actual.wolopts;
> }
>
> and phylink_ethtool_get_wol() does:
>
>         wol->wolopts |=3D pl->wolopts_mac;
>
> So is this store always dead?
>
> lan78xx_suspend() passes the merged value to lan78xx_set_suspend().
> phylink_suspend() decides from the MAC-only set instead:
>
>         mac_wol =3D !!pl->wolopts_mac;
>
> Take an external PHY on LAN7801 whose driver implements get_wol and
> handles WAKE_MAGIC. There, wolopts_mac would be 0, so phylink calls
> phylink_stop(), and lan78xx_mac_link_down() stops RX/TX and resets the
> MAC.
>
> The driver would still arm MAC magic-packet detection (WUCSR_MPEN_,
> SUS_MODE_3) for a mode the PHY handles. It also would not set
> PMT_CTL_PHY_WAKE_EN_ to pass on the PHY's wake.
>
> Can the driver and phylink end up disagreeing about who handles WoL and
> whether the MAC needs to keep receiving?
>
> > +
> > +     return 0;
> > +}
> > +
> >  static const struct phylink_mac_ops lan78xx_phylink_mac_ops =3D {
> >       .mac_config =3D lan78xx_mac_config,
> >       .mac_link_down =3D lan78xx_mac_link_down,
> >       .mac_link_up =3D lan78xx_mac_link_up,
> >       .mac_disable_tx_lpi =3D lan78xx_mac_disable_tx_lpi,
> >       .mac_enable_tx_lpi =3D lan78xx_mac_enable_tx_lpi,
> > +     .mac_wol_set =3D lan78xx_mac_wol_set,
>
> [Severity: High]
> Does setting mac_wol_set leave the link permanently down after a normal
> system resume?
>
> With mac_wol_set set, phylink_mac_supports_wol() returns true, and
> phylink_suspend() ignores the mac_wol argument from the driver:
>
> phylink_suspend() {
>         ...
>         if (phylink_mac_supports_wol(pl))
>                 mac_wol =3D !!pl->wolopts_mac;
>
>         if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled))=
 {
>                 ...
>                 __set_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_s=
tate);
>         ...
> }
>
> By default, the new probe code sets pl->wolopts_mac =3D WAKE_MAGIC (lan88=
xx
> has no get_wol, so all of it goes to the MAC) and sets wol_enabled to
> true.
>
> So with the interface open, every system suspend through
> lan78xx_suspend()->phylink_suspend(dev->phylink, false) takes this
> branch. It sets PHYLINK_DISABLE_MAC_WOL and turns carrier off, but does
> not stop phylink or phylib.
>
> Only phylink_resume() clears that bit, and lan78xx calls it only from
> lan78xx_reset_resume(). lan78xx_resume() is used when the device keeps
> power across sleep, and it has no phylink call.
>
> After that, phylink_resolve() sees a non-zero phylink_disable_state and
> forces the link down:
>
>         if (pl->phylink_disable_state) {
>                 pl->link_failed =3D false;
>                 link_state =3D pl->link_config;
>                 link_state.link =3D false;
>
> Before this patch, ip link set down/up recovered from this state, because
> phylink_stop() sets STOPPED and phylink_start() clears it. phylink_start(=
)
> only clears PHYLINK_DISABLE_STOPPED, so the MAC_WOL bit now survives
> ifdown/ifup and ethtool wol d.
>
> Won't the interface stay without carrier until a reset_resume or a driver
> rebind?
>
> On the reset_resume path, lan78xx_reset() hard-resets the PHY through
> PMT_CTL_PHY_RST_. Before, phylink_resume()->phylink_start()->phy_start()
> brought phylib back up and re-ran aneg configuration.
>
> Now phylink_resume() takes the MAC-WoL branch (mac_initial_config plus a
> re-resolve). phylib was never halted, so it doesn't reprogram the freshly
> reset PHY.
>
> Are user-configured advertisement or forced link modes lost in that case?
>
> Runtime autosuspend doesn't trigger this, since lan78xx_open() holds a
> usb_autopm reference until lan78xx_stop(). The system suspend path alone
> is enough.
>
> >  };
>
> [ ... ]
>
> > @@ -2848,6 +2872,10 @@ static int lan78xx_phylink_setup(struct lan78xx_=
net *dev)
> >              dev->phylink_config.supported_interfaces,
> >              sizeof(dev->phylink_config.lpi_interfaces));
> >
> > +     pc->wol_mac_support =3D WAKE_MAGIC | WAKE_UCAST | WAKE_BCAST |
> > +                   WAKE_MCAST | WAKE_ARP;
>
> [Severity: Medium]
> Is WAKE_PHY meant to be left out here? The driver still includes WAKE_PHY
> in WAKE_ALL, and lan78xx_set_suspend() still handles it:
>
>         if (wol & WAKE_PHY) {
>                 temp_pmt_ctl |=3D PMT_CTL_PHY_WAKE_EN_;
>
> Before the patch, lan78xx_get_wol() reported supported =3D WAKE_ALL. Now
> the supported mask comes from phylink_ethtool_get_wol(), which is the PHY
> driver's get_wol result OR'd with wol_mac_support.
>
> The internal PHY uses the lan88xx driver in drivers/net/phy/microchip.c.
> It has set_wol but no get_wol, so it adds nothing, and WAKE_PHY is never
> advertised.
>
> ethnl_set_wol() then rejects it:
>
>         if (wol.wolopts & ~wol.supported) {
>
> The new wol->wolopts & ~actual.supported check in lan78xx_set_wol() also
> rejects it with -EINVAL.
>
> So ethtool -s ethX wol p, wol pg, and systemd-networkd WakeOnLan=3Dphy al=
l
> worked before and now fail. The PMT_CTL_PHY_WAKE_EN_ path in
> lan78xx_set_suspend() can no longer be reached.
>
> The commit message doesn't mention this change. The PHY-less LAN7801
> testing wouldn't exercise this path.
>
> Should WAKE_PHY be added to wol_mac_support, since the MAC implements it?
>
> > +     pc->wol_phy_legacy =3D true;
> > +
>
> [ ... ]
>
> > @@ -4803,6 +4835,24 @@ static int lan78xx_probe(struct usb_interface *i=
ntf,
> >       if (ret < 0)
> >               goto free_urbs;
> >
> > +     /* Preserve the default magic-packet wakeup configuration. */
> > +     rtnl_lock();
> > +
> > +     ret =3D phylink_ethtool_set_wol(dev->phylink, &wol);
> > +     if (!ret) {
> > +             struct lan78xx_priv *pdata =3D (struct lan78xx_priv *)dev=
->data[0];
> > +
> > +             wol.cmd =3D ETHTOOL_GWOL;
> > +             phylink_ethtool_get_wol(dev->phylink, &wol);
> > +             pdata->wol =3D wol.wolopts;
> > +             netdev->ethtool->wol_enabled =3D !!wol.wolopts;
>
> [Severity: Medium]
> The commit message says:
>
>   Preserve the default magic-packet wakeup configuration
>
> Does this code change the default PHY power behaviour, though?
>
> Before the patch, lan78xx_bind() only set pdata->wol =3D WAKE_MAGIC. The
> PHY was never told about WoL, and netdev->ethtool->wol_enabled stayed
> false.
>
> With wol_phy_legacy =3D true, phylink_phy_supports_wol() returns true
> whenever a phydev is attached, so this call reaches
> phy_ethtool_set_wol(). lan88xx_set_wol() then sets
> priv->wolopts =3D WAKE_MAGIC, and external PHYs on LAN7801 get their WoL
> hardware programmed.
>
> With wol_enabled forced to true, phy_suspend() returns -EBUSY:
>
>         phydev->wol_enabled =3D phy_may_wakeup(phydev) ||
>                               (netdev && netdev->ethtool->wol_enabled);
>         if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSP=
END))
>                 return -EBUSY;
>
> and lan88xx_suspend() skips genphy_suspend() while priv->wolopts is set:
>
>         if (!priv->wolopts)
>                 genphy_suspend(phydev);
>
> So the PHY would no longer be powered down when
> phylink_stop()->phy_stop() halts it, including on a plain ip link set
> down. In that case the !dev_open branch of lan78xx_suspend() disables all
> wake sources anyway, so keeping the PHY powered doesn't seem to help.
>
> Is this new default intended for every lan78xx device with a PHY?
>
> > +     }
> > +
> > +     rtnl_unlock();
> > +
> > +     if (ret)
> > +             netdev_warn(netdev, "failed to initialize WoL: %d\n", ret=
);
>
> [Severity: Low]
> What happens to pdata->wol if phylink_ethtool_set_wol() fails here? One
> example is an external PHY on LAN7801 whose set_wol returns an error
> other than -EOPNOTSUPP, such as an MDIO or USB control transfer failure.
>
> pdata->wol keeps the WAKE_MAGIC value set in lan78xx_bind(). Meanwhile
> pl->wolopts_mac stays 0 and netdev->ethtool->wol_enabled stays false.
>
> lan78xx_get_wol() would then report no active WoL through phylink, but
> lan78xx_suspend() still does:
>
>         ret =3D lan78xx_set_suspend(dev, pdata->wol);
>
> and arms magic-packet wake (WUCSR_MPEN_).
>
> Should pdata->wol be reset on this failure path so it matches what
> phylink reports? This can't happen with the internal lan88xx PHY, whose
> set_wol always returns 0.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261108180137.3488023-1-prashantsengar25031%40gmail.com
