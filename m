Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B623DD875
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792363263; cv=pass; b=FuTBJiyP7ocqi0XfzbpB3hSlFXxFBEsQf2ft1WClu+RjmnEkKqUXgZZ2/UHyOCNs5pUQfVsf7vaa/qeIZBfHtow76c1GuNsqwWACbg3jRxshD/xbZzPsDKAOVN3zEhjD1c56bdgLW6en6+fLTbIQA9r1pxgpWsHtCfwZZEdONAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792363263; c=relaxed/simple;
	bh=p++ZSyJFCuxLqjeASFcIbsbXuay+O3EngKkGXMu53oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUH+XMhwQkItbkOToQFG1qHX8TaCSXwDzGcuLdRsXwSh14Nd9QhgbMKpsGZ9porndDXzHamToU47rPGwYFQNU2u7S96wVbKhfPSD5ump0+T/BtZqkM9Ts7a/LJQHVl2pCvED9hFixQHaalA/2ZQ2PGm1nyZSw+TeZBHNkewgmyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPsCo8XW; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPsCo8XW"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c40e30c26a4so339066266b.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792363260; cv=none;
        d=google.com; s=arc-20260327;
        b=Oifs6QD8AkDwe4d+95757z9UATXj66ne5/2XWw3WDOO2z2MhIQsW5JnLaJ8uzl9yv9
         IZ94m/Oq0X6IxYR6PZIPYV8qQt08IzR1pOIg8O8SSMz8vqq5kRRlaknxexTjbBsuV2Tp
         wlursmfD2KXVws5oRJCi1oDNAk4oym6lfc9noYS1gTXZlWGxEqLU6RhJ+ZBUl5BWwCRg
         ko2L+NJtq0ir9MOkI+G8Q90Yax6XISdCMCR028rPhlVJQ0W6FRvltOfIWcPojBBx7DVn
         5KL34jVfBscx89KjQpL+uQB+Otav+wRiLaAeTA3pWiUaanQ8Rs7tXCh6OV2/zWtrEm+O
         5ZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UXdVaZ0BdL2p1RhzEOoM8EGu2ZUXiAFHTy0xisS2uiQ=;
        fh=YAzGysVCi72nJRe2lQw4J0o3Ldj5Xgy8/mRjYhW605s=;
        b=Kofy39g+rRZbpeM3KzCDTvrCh9VpuVQXOqdN733VojrTPmTOunnkg4ipEK8ZWqRjU1
         dvA+76LbC1djh2UkOKR/qBIyWp848J17tITNx98ymVDWPvyaIRSxN7DM6IKQ/yGv+HTD
         0H62KdPdYjscyFHyl9z8u5HAfUPeQAOndA3jfh/jUM4DI/SljBnVtfQZpWTySGSnHBtP
         pC3U0eoJJEYK4yOHVzMGfCs5sv9hW0MWRtr9b5VGDsAEH9mlD769aVlLRxk9/inMhjLf
         799oY47KqNwLJVLBiSkltMQLQvkg3wVSYXcaRqmljw9oZYVxU+mqa0iggLGEHjR2NOuk
         g2IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792363260; x=1792968060; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UXdVaZ0BdL2p1RhzEOoM8EGu2ZUXiAFHTy0xisS2uiQ=;
        b=jPsCo8XW+wvKpLS9nBsIw6+rkUGeQluqYEw8DePGqY0Y5jAcuT/TdulMB/U45i3BXI
         1CRsJQmpTDJxS0tQlito624pT3dzG+Gfpy8KK4N7M02DWmDTzRw7bCCNzrQu7ZCjZ8AP
         pU+BgIBh8zFB59HmjienrYMLWsjcgbCzi/X+qNI/NKKrYwm3sJW9eLsEjVgkXZYIAr9T
         fsoUNcfeTXEN3sq6a10kqfkANfs9y6OTDn8Tcc7NizYDSZVbyeoP5tPb7j3tNp0yLqXr
         tRSI5PUIQlEsG3TwrfnlyyADNNlJ4DypVoLR1gwQH/B81asgKrDGNDKavVxF09y0G5Iq
         SN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792363260; x=1792968060;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UXdVaZ0BdL2p1RhzEOoM8EGu2ZUXiAFHTy0xisS2uiQ=;
        b=qfo6ZQUx3dLa46qo35GT2I1HtEtdZMDoiwG2s6QePHx3mU1Ed9pG8opKHwjHfEoop+
         yf//lou85cewmon9s/kZeMdd9I8fEfJVazUUkbTkdtuQlqEFIyUyqvUXcV6D7judLMIS
         6egFvPmtlDJIQ57m8N4eNFIzXPx9YAeZ6M3jzmq0GfZZ5kkGk5AdZq0K1r4qcCsuF4/x
         WRq2Jn6j411sWnsBIULtibui2qHaniolotrfCyw+KdTm8CPJnHffuQW5MAiX6aSOf/CE
         lF0e7CygQ+n/cNKVASbbWMfcEgcsL/bJ7HOYtLa1oU5y9Uy6hAMwtM6lb/Hos1t6JnsC
         X73A==
X-Forwarded-Encrypted: i=1; AKwUvBwrcJqgOrpK3XS2tiI10EROH1sgFz72qZWWn1tdmZoCXfN38YT/2tLpm6JhasIQWG9i+jXQfwU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWLhjLih5KoZDQA3+T34xbNyk362EDa6boXQQ9D82yovWAKnX/
	ZyqU3vjJE5sCg/MImxPHCnpi2MMiwcdaK+ITV7b3KlV2NBgVI/Cc0yO7ZXRC5wGshHG1fwYebo4
	/eyqxlaEvpXUsmWikEejZAoTGezDdWhELfXP8D7g=
X-Gm-Gg: AYBFou2Y6srzM1BbRQim6Utuq+hFBZrG5LhzRQPZ3CmEoc6dV62+VPfvvlcC9dr+PHD
	ebrKavTp2Jd5JPr4GO0BF0JO0MDUPytGtOJGP0YELO9rWvpHHoGp0QWz4RU22P36zwtd4ORUn/E
	6bSaLW/y60voJID3O3t9hBV3O0cfbm5WkGG5NGIlV+l1k3kPERNFdnOgNAyPyF6tA4mgZ1lx3MW
	f0p3pRL2tz/xcuqcFQFh3uQNa9q1uE+Z8/jR3j3hAbGS3EZIKw082Ee0/mJrsOWXTn07HPBBxQg
	VFE4S9ysJFE+Ed7bM5uUZ3QimcV1dWMS68GmDre9vJ8yevBnSLAj4TOedEH7TMl5uyIGdJmkN0K
	2kzoAtz6JvFI=
X-Received: by 2002:a17:906:9f8e:b0:c31:7a83:bd78 with SMTP id
 a640c23a62f3a-c40226d038bmr717199866b.27.1792363259952; Sun, 18 Oct 2026
 15:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com> <75829f0c-69d4-4c16-8300-142023f840d7@yahoo.com>
In-Reply-To: <75829f0c-69d4-4c16-8300-142023f840d7@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 18 Oct 2026 19:40:47 -0300
X-Gm-Features: AclHuK8japrQSasiuuB5p9BbdGCAzRqaG209BBF3f-flurqGY0prkkCGGbMOCzE
Message-ID: <CAJq09z5ZAxca0rRT0mSiU_3xp2wxEU4qahbDM3SBGpwe1vbMRw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/9] net: dsa: realtek: rtl8365mb: set speed
 for family D
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 840db5a..2dabc4d 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -344,6 +344,7 @@
>  #define RTL8365MB_PORT_SPEED_10M       0
>  #define RTL8365MB_PORT_SPEED_100M      1
>  #define RTL8365MB_PORT_SPEED_1000M     2
> +#define RTL8365MB_D_PORT_SPEED_2500M   5

I also used the same _<FAMILY>_ tag trick previously, but it gets
confusing quickly. Does RTL8365MB_D_xxx mean something exclusive to
family D, or family D and later? I hope a more seasoned reviewer can
weigh in on this.

When I implemented support for the RTL8367R (pre-family B), I ran into
this exact problem of macro definitions (and code conditions) turning
into unmaintainable spaghetti.

In this particular case, as 5 does not exist in Family C and the
semantics of the existing values still hold, you can omit the _D_. A
simple comment will be enough if the semantics change for a future
family.

>  /* External interface force configuration registers 0~2 */
>  #define RTL8365MB_DIGITAL_INTERFACE_FORCE_REG0         0x1310 /* EXT0 */
> @@ -361,6 +362,28 @@
>  #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_LINK_MASK          BIT(4)
>  #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK                BIT(2)
>  #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK         GENMASK(1, 0)
> +/* Width of the FORCE_SPEED field, bits[1:0] */
> +#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_WIDTH                2

This is what bitfield masks/macros are for; there is no need for an
explicit WIDTH define. More comments below on the code using it.

> +/* bits[13:12]; bit 13 reserved, no defined speed value uses it yet */
> +#define   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_SPEED2_MASK      GENMASK(13, 12)
> +
> +#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_BASE           0x12c0
> +#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG(_port) \
> +               (RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_BASE + (_port))
> +
> +#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_BASE            0x12c8
> +#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_EN(_port) \
> +               (RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_BASE + (_port))
> +
> +/* Per-port force-mode enable. The vendor RTL8367D API
> + * (dal_rtl8367d_port_macForceLink_set()) treats it as an on/off switch for
> + * the whole forced configuration: all bits set when the MAC is forced, zero
> + * when it is not. The meaning of the individual bits is not documented.
> + * This driver always forces the MAC, as on family C, so all bits are set
> + * on every call, including link down.
> + */
> +#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_ALL_MASK        GENMASK(15, 0)
>
>  /* CPU port mask register - controls which ports are treated as CPU ports */
>  #define RTL8365MB_CPU_PORT_MASK_REG    0x1219
> @@ -1646,23 +1669,32 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
>         u32 r_duplex;
>         u32 r_speed;
>         u32 r_link;
> +       bool is_d;

Thinking about future families like E, F, G..., a boolean flag like
is_d might not scale well.
You can still keep the family id in a variable to keep lines short and clean:

        enum rtl8365mb_family family;

>         int val;
>         int ret;

[...]

>               FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_LINK_MASK, r_link) |
>               FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK,
>                          r_duplex) |
> -             FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK, r_speed);
> -       ret = regmap_write(priv->map,
> -                          RTL8365MB_DIGITAL_INTERFACE_FORCE_REG(extint->id),
> -                          val);
> -       if (ret)
> -               return ret;
> +             FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK,
> +                        r_speed &
> +                        RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK);

Isn't the point of FIELD_GET/FIELD_PREP to avoid bitwise operations
like this? For fields split between bit ranges, you can use the same
trick as in RTL8365MB_CVLAN_MBR_LO_MASK, RTL8365MB_CVLAN_MBR_HI_MASK.

> +
> +       if (is_d) {

For multiple/bigger differences, we will need to have different
functions for each family. In this case, for small differences, I
think is_d, is_e, is_f... are better handled by a switch statement
with the same indentation cost as an if:

            switch (family) {
            case RTL8365MB_FAMILY_D:
                 ...
                break;
            case RTL8365MB_FAMILY_C:
                 ...
            }

And, by omitting the default clause, when we add a future FAMILY_E and
forget to add a case for it, the compiler will warn us of the missing
check. You can even use a (commented) fallthrough when a family
incrementally expands a feature.

> +               /* Speed is 3 bits on family D: bits[1:0] go into FORCE_SPEED,
> +                * bit[2] goes into FORCE_SPEED2 (bit 12); only 2500M sets it,
> +                * bit 13 of the field is unused.
> +                */
> +               val |= FIELD_PREP(RTL8365MB_D_DIGITAL_INTERFACE_FORCE_SPEED2_MASK,
> +                                 r_speed >>
> +                                 RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_WIDTH);

Here is where FIELD_GET() with a HI/LO mask avoids the manual shift
and makes the WIDTH definition unnecessary.

Best regards,

Luiz
