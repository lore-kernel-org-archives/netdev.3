Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1763E5A22
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691711; cv=pass; b=aO9jf/FZdHftgtcblAzVDgp353/oa3X9uzY27m5YPHiDaTJq5t2S0u4gZ4q15nlmGzg1NC3yWX5efnJVfZVX6u0OLYFkHE+Ml93XAy0xvVssdo13l1uegkIMTN2RZ+wPuVf1RIWItAYYnAJaiggOMUwYympZWSjtC5QaUgXwZCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691711; c=relaxed/simple;
	bh=XPk4KG2yV1Sq/VT6zvJRSogdN8ZorWtYCAyIVWHe3PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPB3CTimQLTwI/hiTtqRQ2FaPi6B1QidHXqNPQ9TcPApUV+DmIjPFxAaElkR3miJSlR+B4hZFznojSfG7v0kUd5RdpUMvwkIaEFN+vuNT5O58sJQhE66L6TR6KCdjuuZDEiq0AQh8HXiyCKMRLr/s7d+FmGY6yn2Of7QcIUTpvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0Lzvn7+; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0Lzvn7+"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-45171f2f608so4599014fac.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 20:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784691706; cv=none;
        d=google.com; s=arc-20260327;
        b=X2o1LmXruXwT6zqQMMWWCtVXvN5GXmcfBN7qjkl8iUtLBd91b6sAU21wCSUf79bOPx
         D6wR5gYNTCvZGxemHjab2ap58MHy3reyB/Fa/wR38G2CJIVri/VYAbdKE0Komf6t8a+r
         4ADWpjICbvPTCCtcu0mdniqEClKs7+jbdFZleiTuQ9Z42MmYdl2dmmpeBd3EwtioTOBE
         6ttTQBhrOYxxYRZUGM168qUXe4g1S0p0m/Jrs6UDZNlIOFAiuDnahtJJQaPXZmEAOpFk
         +KA1LUKdZHZonaeUmWcXjMnYN/IhEsIxI6/i1eG68Bigt7C32I/1eSfaAve3aSeq0UBJ
         eBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lIw+2wSbqfG24nAMmpJRj7C7axX4e8CQLw+DDu3G1Fc=;
        fh=izd0Zb70QWdhHgL62L1esRUzleqX6U9/1T3I0BSMyIY=;
        b=H50prEDx9MZXJYFy0LEDRXHqAPYoT1BVizSSBmfcJ76u3ZL81k6aUvZ4fpl9aQzHNy
         7RE9D8Mr6j2Gs04xIKZjpPUS4aOT6eNE4jzNaSsxKaBAfzMlsIci32JFGSaUKRoM2BCv
         rkBajwKbCMcFPt3z1qpJcKXEFz28YekLxJU84iLLn1CXQ5t3rrofWf+MZxywKcnkiw/C
         yJ1n49Du5PgHUp19s5xmDTHyvtYapM+ymHWW+kzHTE7sXjWtIxFvxSB9cHi8dx8Ymhkx
         SsuxOJG5/PDY4JD4v2yEQJA9R6HMSnCmZIxGO/Y9ljBYJYbahDd6FmH3Wgn2XPWxJbi8
         y9Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784691706; x=1785296506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lIw+2wSbqfG24nAMmpJRj7C7axX4e8CQLw+DDu3G1Fc=;
        b=Z0Lzvn7+sz7K4gwuvJuuKXvL76YX8ChQvP3snDWvRk398YX4uYXo0LZdvCvSxFj0E3
         7lSMSyZdOlMbgSD5iPJHQLJjdqQELInj4ZZUsBqvva2y5ixVy9X240bw8qpAUk6mykwo
         a67MYBD+JMQ+ypw0VnoLFQXJv8yLTj+Kn/5elGfjVEvxKSIrxKYQ5Qs/i0iKZrmrG1zo
         Q9BwIzFCIkK7aXNw23yXJLCeqaxFxvamUeXiFfgyyhIo2MCCFs1EHoGy8HExGEh+X9eU
         bkwDWEfa9/x3g4TnZctfq30IVY0az4YSNjRirmhjFz5mdtBgYuvbcBgHWiLtjocLKfu3
         09ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784691706; x=1785296506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lIw+2wSbqfG24nAMmpJRj7C7axX4e8CQLw+DDu3G1Fc=;
        b=djaK59mraZOKIFy1k++KeGUA0H2iZ216pAx6/JKGvvZAvm4lz78k7ivj94TLqn9X57
         aAUlMBf+l14INQdd6ICLHJOZ5SKL4Kd2Ep+lm1CiPx5rceHt7dSG8mM83CGKpaeAQUtn
         3QJJllu7ROUYoGCnfo7obQl0nXecXlsO1J3jG5dLYUJFIPftWWF/w9gjmCChnuEfkND2
         yR9u8sOi0mu1UOQjlLJ95Ik5HuZzEM8NWkoc7VwWSkM5drOM4TOY39EeThDK9f1vc0Dq
         T19/5KZ2TmxyWS/2q5ldDqWJL36dA9srn0a9EkekgSUG0F5T5wyNfZjs1l9NxobHTRts
         Ingw==
X-Gm-Message-State: AOJu0YziFZ+MyoNaBbyhviJ0jHv2ZrnRtWKCJG7gptC4ca/DOykZHLr9
	H/kMhNJ51mvubQQ0nbQiX5T9kVGEeKkM4BNllmuhyQuOA8bHi9bEXGGaxBT2qY6f/oImnZI8WxI
	qUo9NF+83+JODxQXUevAjL11ZrcgQzYA=
X-Gm-Gg: AfdE7cmd7StpJv5H14LwvyuB4KZaaL919P2IRwkjTg8XA9du1zoyiq7dfJWj38GhW9m
	Dxr6dQn2Ux7CueTZ2TEnFx3MVyyCu2OGKaZ7o7UmA9lUKRN8YIu0Wrqn4sduT9tNheDXs4Z6iaX
	9uCHCK/UV1xi3zBrnjTrmmSNednyBW7zJjG0qKifRv3wXIhgkvKZiSnMofRcWpU0hbP5MrAWwzG
	S9n9Y5kNweZSz5Gf7ElcI5E2sNM1XdhosT4X1Az18v0XWIrStOs6Fmg48qUHYdqBw9Zf+g1ypI/
	GNFCEy3qErS3kbVpLrtdBqei14Ry0g==
X-Received: by 2002:a05:6809:10c:10b0:4a4:ed9a:e793 with SMTP id
 5614622812f47-4a4ed9aeab2mr6106094b6e.16.1784691706433; Tue, 21 Jul 2026
 20:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709014812.1158178-4-mmyangfl@gmail.com> <20260721173248.815203-1-kuba@kernel.org>
In-Reply-To: <20260721173248.815203-1-kuba@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 22 Jul 2026 11:41:09 +0800
X-Gm-Features: AUfX_my6rTmYDOVe8gL_pDPk5gWZTQI90nD982a1paC3wVRsSYaIiYU-khPjFgo
Message-ID: <CAAXyoMPBD9Y2CMeOaDzdRPmwN=yrbR03ck8mduE8SzXSUwsyVg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] net: dsa: motorcomm: Add LED support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:32=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> > +static int
> > +yt921x_led_trigger_get(struct yt921x_priv *priv, int port, int group,
> > +                    unsigned long *flagsp)
> > +{
> [ ... ]
> > +     *flagsp =3D 0;
> > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(yt921x_led_trigger_maps=
); i++) {
> > +             const struct yt921x_led_trigger_map *map =3D &yt921x_led_=
trigger_maps[i];
> > +
> > +             if ((val & map->mask) =3D=3D map->mask)
> > +                     *flagsp |=3D map->flags;
> > +     }
> > +
> > +     return 0;
> > +}
>
> [Medium]
> Does this iteration over-report the flags for TRIGGER_NETDEV_LINK?
>
> The LINK entry in yt921x_led_trigger_maps sets both DUPLEX_HALF and
> DUPLEX_FULL bits. After yt921x_led_trigger_set(LINK) programs the
> register with those two bits, yt921x_led_trigger_get() scans every map
> entry without breaking:
>
>     /* LINK entry: (val & (HALF|FULL)) =3D=3D (HALF|FULL)  -> match */
>     /* HALF_DUPLEX entry: (val & HALF) =3D=3D HALF         -> match */
>     /* FULL_DUPLEX entry: (val & FULL) =3D=3D FULL         -> match */
>
> So *flagsp ends up as LINK | HALF_DUPLEX | FULL_DUPLEX rather than just
> LINK. Should the map entries with overlapping masks be handled specially,
> or should the loop break/clear after a compound match like yt921x_led_
> trigger_set() does with flags &=3D ~map->flags?

It's semantically consistent. The led will be turned on on LINK or
HALF_DUPLEX or FULL_DUPLEX.

> > +int yt921x_leds_setup(struct yt921x_priv *priv)
> > +{
> [ ... ]
> > +     dsa_switch_for_each_port(dp, ds) {
> [ ... ]
> > +             for_each_child_of_node_scoped(leds_np, led_np) {
> > +                     res =3D yt921x_led_setup(priv, port,
> > +                                            of_fwnode_handle(led_np),
> > +                                            &inv_mask, &inv_ctrl);
> > +                     if (res) {
> > +                             of_node_put(leds_np);
> > +                             goto err;
> > +                     }
> > +             }
> > +
> > +             of_node_put(leds_np);
> > +     }
> > +
> > +     mutex_lock(&priv->reg_lock);
> > +
> > +     mask =3D YT921X_LED_CTRL_MODE_M | YT921X_LED_CTRL_PORT_NUM_M |
> > +            YT921X_LED_CTRL_EN;
> > +     ctrl =3D YT921X_LED_CTRL_MODE_PARALLEL |
> > +            YT921X_LED_CTRL_PORT_NUM(YT921X_PORT_NUM - 1) |
> > +            YT921X_LED_CTRL_EN;
> > +     res =3D yt921x_reg_update_bits(priv, YT921X_LED_CTRL, mask, ctrl)=
;
> > +     if (res)
> > +             goto end;
> > +
> > +     /* Inversion is internal - force on will give low logic.
> > +      * In the rest of the file, treat LEDs as if active-low.
> > +      */
> > +     if (inv_mask)
> > +             res =3D yt921x_reg_update_bits(priv, YT921X_LED_PAR_INV, =
inv_mask,
> > +                                          inv_ctrl);
> > +
> > +end:
> > +     mutex_unlock(&priv->reg_lock);
>
> [Medium]
> The commit message says "strict 1:1 mapping". Where is the port-to-LED
> mapping actually being programmed to identity?
>
> The header defines the field macros for these registers:
>
>     #define YT921X_LED_PAR_MAPn(port)   (0xd01d0 + 4 * (port))
>     #define  YT921X_LED_PAR_MAP_DSTn_PORT_M(grp)  ...
>     #define  YT921X_LED_PAR_MAP_DSTn_PORT(grp, x) ...
>     #define  YT921X_LED_PAR_MAP_DSTn_LED_M(grp)   ...
>     #define  YT921X_LED_PAR_MAP_DSTn_LED(grp, x)  ...
>
> but there is no writer for YT921X_LED_PAR_MAPn anywhere in the driver.
> The 1:1 mapping seems to rely on the reset / bootloader default. If those
> values are not identity for some reason, LED operations for port X would
> end up steering to a different pin.
>
> Should the driver write an identity mapping into YT921X_LED_PAR_MAPn, or
> should the commit message drop the "strict 1:1 mapping" claim?

It's the HW default, and we always perform a hard reset on device init.

> [Low]
> The order in which the LED controller is enabled versus the inversion
> register is programmed looks reversed:
>
>     /* enables LED controller first */
>     res =3D yt921x_reg_update_bits(priv, YT921X_LED_CTRL, mask, ctrl);
>     ...
>     /* programs inversion after */
>     if (inv_mask)
>             res =3D yt921x_reg_update_bits(priv, YT921X_LED_PAR_INV, ...)=
;
>
> Per the comment "force on will give low logic", between LED_CTRL_EN
> being written and YT921X_LED_PAR_INV being programmed, every
> active-high LED with default-state=3Don would be driven low (LED off)
> and only flip to on once the inversion register is written.
>
> If the second write fails, yt921x_leds_remove() is called, which
> unregisters classdevs but leaves LED_CTRL_EN set with the wrong
> polarity on the physical pins.
>
> Would it be cleaner to program per-LED state and YT921X_LED_PAR_INV
> first, and set YT921X_LED_CTRL_EN last?

LED_CTRL_EN is actually kind of no-op, LEDs are always enabled even if
!LED_CTRL_EN.

> [High]
> Are Documentation/devicetree/bindings updates missing for this change?
>
> The existing binding at
> Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml uses
> unevaluatedProperties: false and only references
> dsa.yaml#/$defs/ethernet-ports for the port schema, which does not
> describe a leds subnode. A device tree that uses the new LED feature
> would fail make dtbs_check with unevaluated property errors.
>
> Should the YAML be extended to describe the leds subnode and the
> per-LED properties reg, active-high, active-low, and default-state that
> the driver consumes here?

https://elixir.bootlin.com/linux/v7.1.4/source/Documentation/devicetree/bin=
dings/net/ethernet-controller.yaml#L206
, and such leds subnode can pass dt_binding_check.

> [Medium]
> The driver reads active-high and active-low as boolean properties on
> each LED subnode:
>
>     force_high =3D fwnode_property_read_bool(fwnode, "active-high");
>     force_low =3D fwnode_property_read_bool(fwnode, "active-low");
>
> active-low is a well-established convention used elsewhere (for
> example as a GPIO flag), and the common LED subnode binding in
> leds/common.yaml does not define active-high/active-low booleans on an
> LED node. Since DT properties are ABI once shipped, would it be better
> to reuse an already-standard property, or to invent a driver-namespaced
> one, so the naming does not collide with existing conventions?

Pure slop, https://elixir.bootlin.com/linux/v7.1.4/source/Documentation/dev=
icetree/bindings/leds/common.yaml#L213
