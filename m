Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B222B3AFD1F
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784689915; cv=pass; b=nIo6B6jhKLTmX7VaFEIGZ9kX8clOyZtr/GGHcJxcMLmRJ0iXYmukH96gSYgUd19rUuCgeNElPtp/27no6iX2n8hbX9T6RT4eRnXz8B+8ihSCQ6mriQzaXdyfAholaVnOnec4rNYU5Jk8kJhBedt4i7oIvDwyWQic1CK7Iw2jwdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784689915; c=relaxed/simple;
	bh=2IKvzXaO9uMpxyS1C2Npnq+DgtbmEtwf3e+KCWvU/fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAEi3CVREnbHhiv4GWUz//UbHFbLq4wj1GMlwYRqbYTkOk9VT4JvngB9Q0jx8/+/GxYDUF9l5QgV2WsFpKSMQ5+0JmbGdvBvv0H09cT0Znkmnun7FSW4+xv39v8JpF0qmEkQD0TivzBUiYJ+TqEc0Y/zQRF+WYWmoS9G71LO1tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oehEKalf; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oehEKalf"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4a4cb36ae00so3475357b6e.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 20:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784689912; cv=none;
        d=google.com; s=arc-20260327;
        b=g/EYgXYEgZz7PbATH0z407SRuKugYGYNewl0B06YLpLU8+nwwooK7yXjUeW7Aukhkg
         PRleQJ1OgCoNrlEqevMyUKjyLWXrD6YyGiKSghrtEXQ0USvuFvu3G6kdmX3uevn46s3a
         YFBDwSMEcB6bx+nxB1JWDbuF9HqWhYOzB1LvOE7GQae+A9MVOB0htInuklvqo5aI/kHv
         pynrdo9rdlSe8qQo4fMP3P5CJ8B7aaslFEbfauYifqikRW0V1jmMRYRY4DZdkQLYVxdC
         WY9rx8h6fQ5CeBlj/vn7KUx9kadt0b+8hGkPLCi6ECyiSGVqYynJ+G7juLXPOxAuoyJs
         3Lhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=chfUw9fqz9z6+LOUntyqRjPEpkeMy95z4PB5Hlq+4fI=;
        fh=hpSyv81AGHSohZYPanwOHB7hcXmy9jkbnNXTwfWlpb0=;
        b=gThCw3+hZop1Cdbmbjp54Xr9/7OTvrw7sljZmZsTLbicQMsL/jENiO6IMXpVZBO9Xa
         GvO7vg5w0mwNWIgN3wum7kX2AHL4j5maB5IA4UdMrokPGdwPF0soq/Hq5XpsfQ4yWmAj
         apDMjp28S+b92WWgbHLIMguFFNf6RxPDlcW9W3whwJcOr3nliChg32OCQniUKPgPRGGD
         IbOZi9XQXCWxOetbjSHRtPQabqGIQ2kYJuuuHbaEVhn1xChLxgQugQOeJK5aUC8j50ZS
         IC/Gsr54vGfWzK0Jwc5R3gtVyLnWgyV6+p2ps5AOUzCw4+CCJh0JOnB3LF37BIt9T3KS
         GKUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784689912; x=1785294712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=chfUw9fqz9z6+LOUntyqRjPEpkeMy95z4PB5Hlq+4fI=;
        b=oehEKalf8EzJQZIgdWFQaAMuX36xllrD4TX9zHr3xMKea8KxsqIDYCZ6/WA7BUuVXa
         UtFSn6qf0ROZ8uaG2IzLPQYadhBmmmX46Q35ksRPndta1h1KGRmJ85Hsc/j2pQ00TTeP
         dQhrCoiXJQEQQbQBRQzIdx9CJlEe5lWE2pCXe4OfW11SIaUGMQq5mX7kgS6c5DkjT1Ut
         BaT123uGeLkhEBjSnQxFgawwFSzCtNMGuNI3jGnb47aksaPRX1EHlkAQNGRGp1nCdkH3
         n3A/kaLA/vzo+xkSO6HkpT9XvxXuGBP4XNOFZJRqEKqhsFYcKzJyZ1TME5Vsj3K/XaZJ
         YXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784689912; x=1785294712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=chfUw9fqz9z6+LOUntyqRjPEpkeMy95z4PB5Hlq+4fI=;
        b=BjBfpni0lEz2JR6iOcwOYVEB+xdyAXN3YsjA8heFo8BXOggoLQqi6L8cbsbZUPYpoc
         dZfnKBU32LHk/8HN2sx4GeFwQzfUI1FNG3UGTGG4oGiH7XWSrMvc/Jw6RonQPNTI8tmX
         NN9ygSFXPOIJzvxJA5bqEHTE+NIFVKzNdbgo3cAkR1sRBqkA2e/sPC9Yzp7nSDqXzitD
         P4D+5ebPUfbqjgCyJmZgNyDAjOHQ5+jEa7pfOYy2zuYDkTxyC188wZIgvlhacM7fsXQG
         B9MMX/pSHQXTLUy/xbRsI1HTDC/kdeYoPzNpqktt9mgNLmFCp9yLxZdfUa4EPP7fL+6H
         2G8A==
X-Gm-Message-State: AOJu0Yw2D56sykJ3vLoDoYqS4WsVLFv0STwxdt9HX1ga6q1X8l0qKN82
	hKKtOLOwryQJW0t0rPMeZspaKLZ7wE3YymU+WqQrMIM2PuOvBwob+Shnv3loUVTVXv9YMHxldbL
	xbhZb2dT2qaGlh095c397usdLUbawC6g=
X-Gm-Gg: AR+sD13deJnGUECno+otj4SrVNShddAgWpK2Wr3lA6BTr38GvnFGf5Ts15/ZIOsClX5
	3fj8pzfTPy9++o1uQ4Ho4ePx5kTcq2YRirRIyj1O/bd3ZZd0zXN3iJgmR/4HSkICHgUoLg6NsQZ
	gHhT5NetUwktfNqUFCoVb5koaJ27zstnul2bsNFup6CDHOkp1KP03RiNQnh7wzSIB+dVWczsl5k
	hxllw9rTfhwgf7sll1i3fw9VL6Bc7LlNoXuTwFb7K7I/gZeCNVJw2ys4Ho0ACkvlaEDkUZY9WlU
	X49/vNQL8t3pS2Cv6Us=
X-Received: by 2002:a05:6808:4f20:b0:496:2b3:ae70 with SMTP id
 5614622812f47-4a4d0461b89mr13222288b6e.25.1784689912416; Tue, 21 Jul 2026
 20:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709014812.1158178-1-mmyangfl@gmail.com> <20260709014812.1158178-4-mmyangfl@gmail.com>
 <20260721103228.0a90ace6@kernel.org>
In-Reply-To: <20260721103228.0a90ace6@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 22 Jul 2026 11:11:16 +0800
X-Gm-Features: AUfX_mxgoketuqRrY4TwVsn8zvXNyRmSLDyl9gTeF6HV5Up0uFGXgYaY3uJmE_I
Message-ID: <CAAXyoMNEffojiBqWktPB57ohzAiMGfVo8beyazONzK2N2m+2=w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] net: dsa: motorcomm: Add LED support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:32=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu,  9 Jul 2026 09:47:47 +0800 David Yang wrote:
> > LEDs can be described in the device tree using the same format as qca8k=
.
> > Each port can configure up to 3 LEDs.
> >
> > Currently, only parallel mode and strict 1:1 mapping are supported.
>
> > +config NET_DSA_YT921X_LEDS
> > +     bool "LED support for Motorcomm YT9215"
> > +     default y
> > +     depends on NET_DSA_YT921X
> > +     depends on LEDS_CLASS=3Dy || LEDS_CLASS=3DNET_DSA_YT921X
>
> is it really useful to prompt the user with this option?
> Shouldn't this be a hidden option which gets auto-enabled
> when dependencies are met?

NET_DSA_MV88E6XXX_LEDS, NET_DSA_QCA8K_LEDS_SUPPORT, and
NET_DSA_REALTEK_RTL8366RB_LEDS. Better to align with others.

> > +static bool
> > +yt921x_led_trigger_is_supported(const struct yt921x_priv *priv, int po=
rt,
> > +                             int group, unsigned long flags)
> > +{
> > +     if (!flags)
> > +             return true;
> > +
> > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(yt921x_led_trigger_maps=
); i++) {
> > +             const struct yt921x_led_trigger_map *map =3D &yt921x_led_=
trigger_maps[i];
> > +
> > +             if ((flags & map->flags) =3D=3D map->flags) {
> > +                     flags &=3D ~map->flags;
> > +                     if (!flags)
> > +                             return true;
> > +             }
>
> Isn't this conditions simply:
>
>                 if (flags =3D=3D map->flags)
>                         return true;
>
> ?

LED_PORT_ACT are bit-masks, so we can have any additive combinations
of trigger_map.flags.

> > +     }
> > +
> > +     return false;
>
>
> > +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> > +
> > +void yt921x_leds_remove(struct yt921x_priv *priv);
> > +int yt921x_leds_setup(struct yt921x_priv *priv);
> > +
> > +#else
> > +
> > +static inline void yt921x_leds_remove(struct yt921x_priv *priv) {}
> > +
> > +static inline int yt921x_leds_setup(struct yt921x_priv *priv)
> > +{
> > +     return 0;
> > +}
>
> There are static inlines but I think you still protect the calls to
> these functions with itdef?
>
> +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> +       res =3D yt921x_leds_setup(priv);
> +       if (res)
> +               dev_warn(dev, "Failed to setup LEDs: %d\n", res);
> +#endif

Sure, but I want to play it safe since conditional availability of
functions is kind of error-prone.

> > +#endif
> > +
> > +#endif
>
