Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B181724
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318302; cv=pass; b=UEG/MLDpvE8n6VaBP3wAlVWmiV/rRMvskQ75MmWDnvcyA8HLcP1iQxmABvXOOA2+fXU6KYlaVVXTCpoVKr9MqcS1PgUNvcjZpCqxID+Gk9mWahoXWgyP9UKZlViuQkynFa6Qn51rbKUpUdFboEqejsgMHslqJXexTO7iUh+fb8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318302; c=relaxed/simple;
	bh=tKlFUl4gO64Nt8r+Br00nQwMqLEN+ESm9GrlMMPNTqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4WDwYx/GMCrFvLLTgS5YENJcMzHDtKw9430NcvdqWsHSLwBJlENw5PWgihGBKVzWQ563zG5M7ZzoGRnp313iXYgYgCAA97VLfBuexB1YXd7g84k1Fpu9r7vfyYNLeuZS0ZsEzIWpvY/gScfD9A0fETjl/biOgaybvmcfSOi0uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9ZH6zSJ; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9ZH6zSJ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f57db8b5a4so398584a34.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 20:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788318300; cv=none;
        d=google.com; s=arc-20260327;
        b=GGJphAjy5jcGsikycElQxL8YCVB/XwAzuLgOZ9GSKFHh3Ap3P/EqzaGW+bxfMqmGI4
         KsDckRLcZBu1IXSOaWiM00z6piwxNAMReLyD06pEEkLHJG9sh68e+7vJL9czQCOeB9r2
         +eTKuqCEvUSn8vEz8gpAmECBCR/Lh0+dosebzPRtdSFzOONpAA0MbMSgbZyXvcKmCENR
         95yWSX1jC0RZuglpLwb+rL4Syw8jD1bcsfLfJUqhoKRgeE72UJgjUJ7t3mP+Irp2+dc/
         K8179heox6yzrBTbLC3gj8HSO6qqi8Rg0l1ETtCYQuwn0ybqkfMFYja7mApIBMOOZpxO
         uRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHsS7SbgSrvO8RKwHoQeoMibGdls6Is6EtcCRwB7f3o=;
        fh=bxZ081wJLGjn4u/SZa0pa3SPoKO2tzqY0owMYQWl03c=;
        b=WuWstZKomkQyw0qsBoZ05F8DPD6vkGJ8+ldYr38B3eic+zLFMB0GcOL49wEeepuyWv
         oDijsEFlpLLgNbdOVPkPAg72+DxWLQyc8ouZnjzeBcDf9l1GZMUFQzYIbQh81XMXYpJg
         P1wgh8rbzll76KvvF56Ue0gWnCDal9kOD66UivArMmwX7/xoNU5fkMQt8+gKDpImlf6+
         zK2ng4Yu1GVZu/K7fo8bvfB9hAyuszFZBRDKb7Ge1Q2NZjEADTuhD6EoVVQHlD+1KFLd
         lQ3/oGwL/qvGJF2EvTFw2W9rQKaGsYmVJsy5khc5rnWfi2IM5Fcav1DX1UGlWlha51FQ
         H8Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788318300; x=1788923100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHsS7SbgSrvO8RKwHoQeoMibGdls6Is6EtcCRwB7f3o=;
        b=N9ZH6zSJgNaybLGiwil7uk/6iZR8azlt786fvE1Whe3x3ia4qYUyqrKoaYagWOv4k7
         J3GGGFjIduze698hR3sLOAXled4Lio0C6rK10Gx8ZwRLIGOdoiylo08gp6GQdZYoDGaf
         jMiayf1tor1I4NQyziEJV59RuLuzz45KdQXJumYaZ58xTG2sb5YUae8Zimh/8UNU8Izm
         +XjWSTuLqhUSE22WYSPpBqW7/i2YmIUVCHH9/7hKFN7l84WGi9qwoa9RLj6bvnIKuQPW
         nXU/E0c0JccxP2YOKzR3YLdOj3b0x5Gq5S7vE75Y/7T004Kmp//AOgjFmT4kXUQYmXgM
         GE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788318300; x=1788923100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHsS7SbgSrvO8RKwHoQeoMibGdls6Is6EtcCRwB7f3o=;
        b=Ic0As/bGXIZo8X9sfJGkOScoYvzl2pdqkoc3KZylakDiA+4a1UJ4UkOIdiz5Xl84/1
         lvW/QRdbMDqPFM7gfEMFppm+bf1z/LZbuYpFhAv2G8ult0Mt0Kfnf+s+ImCx5F7VAuho
         yLc7AdKciaRjEHS/LTGbEtqxl+xt8etjOXDXlB5ZmnMNCDtgNjK8yxtJd7cTlyX0WTbf
         6JAp+0C4FAePs9WfvxdUosu+fogXN73exrgppUmvVD+e42mzvSf5QllnxKpyWumkJpki
         9lFQpHWoQDhk/o7ADvm7fHCdp/bqU9W9qgEVrCrBd0kQ60KlyRVGMOpeFTn8f7BoXE/f
         2gww==
X-Gm-Message-State: AFuF++nq8HVluFU6nSgtWCh6x36OOUk1ZW7QXTrsTSfaV/BvXyIuolWr
	ybL1wWuitEhXKTc3nNSVB6hUu46brEFTLPBKgA4tOn50OUjtGX9oWnbdQY+HUu2pj9eK9HBAsyM
	glPPUYjj8oRNXWExC2/qt8XJnIMkdJ7U=
X-Gm-Gg: AR+sD10AzIjAH2GuWos0W9Oq/z0buuMsISQx8isUw1U7+21RMuYUn0VaIYk5oUuKRBa
	egdAXl9WklG7G9+lyx0q6GBU5tvnelWb9QE9MOxwtTQycgD0G67hYqDG2qDmNh6KrB9nv2YGb6X
	7bwlmwfrOBMr+N7guZE7Finavy6ptKW8m5kKJXyvaKIbNGGonGuK/cupeI2g/l96N2GNakXCsob
	arU1iiZVF6Ya+9KiWYJoNVwgUUCEFJIRqKrPCxDHZFLlIJ5/xon8zHu8WXiSIKrBR2hSgLqChzC
	cemwl6cLMRsOgyxtdd9x2T11xKRzqifMGSTgfKC/6RYhoLjY6fn2Oqd17WoNMA2UREMrCxwYNNC
	NlYCXgZGYz7oJiIe1mA==
X-Received: by 2002:a05:6820:810:b0:6b1:a667:f0f5 with SMTP id
 006d021491bc7-6b47e0b1e95mr1246806eaf.20.1788318299846; Tue, 01 Sep 2026
 20:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831044818.4103477-1-mmyangfl@gmail.com> <20260831044818.4103477-5-mmyangfl@gmail.com>
 <20260901175618.28d81bd6@kernel.org>
In-Reply-To: <20260901175618.28d81bd6@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 2 Sep 2026 11:04:22 +0800
X-Gm-Features: AcwNN1X2ftXlE08zeXRlOv05TQkIJ2IrYAQHyYXEutFuNo5QfdhKFQNOaMCGn_0
Message-ID: <CAAXyoMOQf8oK3Z_TQKDmLvCQmgAjUR29VnFSFi+np4RtNNw_bg@mail.gmail.com>
Subject: Re: [PATCH net-next v11 4/5] net: dsa: motorcomm: Add LED support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
> > @@ -4225,6 +4224,15 @@ static int yt921x_edata_read(struct yt921x_priv =
*priv, u8 addr, u8 *valp)
> >       return yt921x_edata_read_cont(priv, addr, valp);
> >  }
> >
> > +static void yt921x_dsa_teardown(struct dsa_switch *ds)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +
> > +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> > +     yt921x_leds_remove(priv);
> > +#endif
> > +}
> > +
>
> [Severity: Medium]
>
> Can removing the LEDs only from the DSA teardown callback leave the LED
> class devices registered after the port netdevs have been freed?
>
> net/dsa/dsa.c tears the tree down in this order:
>
> dsa_tree_teardown()
>     dsa_tree_teardown_ports()
>         dsa_port_teardown()
>             dsa_user_destroy(dp->user);   /* ends in free_netdev() */
>             dp->user =3D NULL;
>     dsa_tree_teardown_switches()
>         dsa_switch_teardown()
>             ds->ops->teardown(ds)        /* yt921x_leds_remove() */
>
> So between free_netdev() and the dp->user =3D NULL assignment, dp->user i=
s a
> dangling pointer while the LEDs are still registered and reachable from
> sysfs.
>
> yt921x_cled_hw_control_get_device() reads dp->user / dp->conduit with no
> rtnl_lock, no RCU and takes no reference:
>
>         if (dsa_port_is_user(dp))
>                 return !dp->user ? NULL : &dp->user->dev;
>
> and ledtrig-netdev dereferences the returned device immediately, with
> dev_name() in netdev_trig_activate() and to_net_dev() in
> validate_net_dev().
>
> Would an "echo netdev > /sys/class/leds/<led>/trigger" racing with switch
> unbind, or with the dsa_tree_setup() error path, touch a freed
> net_device here? Would removing the LEDs per port before the netdevs go
> away, or validating dp->user under rtnl_lock, avoid that?
>
> > @@ -4581,6 +4589,12 @@ static int yt921x_dsa_setup(struct dsa_switch *d=
s)
> >       if (res)
> >               return res;
> >
> > +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> > +     res =3D yt921x_leds_setup(priv);
> > +     if (res)
> > +             dev_warn(dev, "Failed to setup LEDs: %d\n", res);
> > +#endif
> > +

Just a question: I don't see any protection against this in other DSA
led drivers, like mv88e6 or qca8k.

> [Severity: Low]
>
> Can this dev_warn() ever be reached? yt921x_leds_setup() in leds.c ends
> with an unconditional return 0 and drops the result of
> yt921x_leds_setup_port():
>
>         dsa_switch_for_each_port(dp, ds) {
>                 ...
>                 yt921x_leds_setup_port(priv, port);
>                 /* Allow partial configuration: LEDs are optional */
>         }
>
>         return 0;
>
> yt921x_leds_setup_port() in turn discards every yt921x_led_setup() return
> value, so the -EINVAL it produces for port >=3D YT921X_LED_PORT_NUM is al=
so
> thrown away.
>
> Should the error be propagated, or should this branch in yt921x_dsa_setup=
()
> be dropped?

Intended, explained in the response for the previous version.

> [Severity: Low]
>
> Is yt921x_led_trigger_get() intended to be the inverse of
> yt921x_led_trigger_set()?
>
> TRIGGER_NETDEV_LINK is encoded as the union of the two duplex masks, and
> this read-back loop ORs in the flags of every entry whose mask bits are a=
ll
> set, with no early break. yt921x_led_trigger_set() instead matches the LI=
NK
> entry first and breaks once the flags are consumed.
>
> So a LED programmed with only BIT(TRIGGER_NETDEV_LINK) appears to read ba=
ck
> as LINK | HALF_DUPLEX | FULL_DUPLEX. ledtrig-netdev keeps that value as t=
he
> trigger state at activation:
>
>         rc =3D led_cdev->hw_control_get(led_cdev, &mode);
>         if (!rc)
>                 trigger_data->mode =3D mode;
>
> Would /sys/class/leds/<led>/half_duplex and full_duplex then report 1 eve=
n
> though only link indication was requested?

Yes.

> > +     if (group >=3D YT921X_LED_GROUP_NUM) {
> > +             dev_err(dev, "Invalid LED reg %u for port %d\n", group, p=
ort);
> > +             return -EINVAL;
> > +     }
>
> [Severity: Low]
>
> This isn't a bug, but the device tree contract introduced here (a per-por=
t
> leds child node, a per-LED reg in 0..2, LEDs only on ports below
> YT921X_LED_PORT_NUM) is not described in
> Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml by this
> commit.
>
> The follow-on patch in the same series, "dt-bindings: net: dsa: yt921x: A=
dd
> LEDs definition example", adds the description text and a worked leds
> example, so this is only a question about ordering within the series.
>
> What the schema still does not express is a maximum for reg, so a device
> tree with led@3 validates cleanly and is rejected only at probe time by t=
he
> dev_err() above. Would adding that constraint to the binding be worthwhil=
e?

I don't see a good notation to impose the constraint (from sibling DSA
bindings).

> > +int yt921x_leds_setup(struct yt921x_priv *priv)
> > +{
> > +     struct dsa_switch *ds =3D &priv->ds;
> > +     struct dsa_port *dp;
> > +
> > +     /* LEDs are always enabled. There is no way to disable them altog=
ether
> > +      * (as far as I know).
> > +      */
>
> [Severity: Low]
>
> This isn't a bug, just a question about scope: the driver programs only t=
he
> per-port registers (YT921X_LED0/1/2_PORTn) and YT921X_LED_PAR_INV, and
> never reads YT921X_LED_CTRL, YT921X_LED_PAR_PORTS or the parallel/serial
> mapping registers declared in leds.h.
>
> As far as I can tell that is fine, since yt921x_dsa_setup() runs
> yt921x_chip_reset() (which writes YT921X_RST_HW, described in the code as
> almost the same as a GPIO hard reset) before yt921x_leds_setup(), so the
> LED block is back at the parallel mode plus 1:1 mapping default that the
> commit message names.
>
> Is a check of YT921X_LED_CTRL_MODE_M worth adding anyway, or is the reset
> considered sufficient?

Reset is sufficient.
