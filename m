Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D89330B11
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697190; cv=none; b=s4qokSVt6t6/Txoxx5mDu9Z6UssCTf2bmQ3g/LJX1g1EVRfZJ0RrxPMo4LSE3Q+i6ShR5wuza/DjC8WBhnTTZBTkdvfAUntAVNImdpWgT6x3BVrJt2JVzw0SqKmxz00OMqgpmk+GoqHVzEXdTJiudCLdeN1sNimxX62Of4m/Bqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697190; c=relaxed/simple;
	bh=urVD1xPdaF3hV5GqXqVqTidMinFWi7P2lc2J0G3o7gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRiosNg0m7nZ5x+jemDLfstXeKNlJAI5cSvO243AaROg1jAd7d/GBb7InOUC3ghinuamyFxEdTKGY9is8m1mHG4ctIBI+1D+5KdjMlZbK3RrhCoSNQTej9j8W4NchHPTLgbu/n3UA46NJQKaHbWHUG/Q3fLexnKEldt9ApLLYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d513bc15c7so9379577a34.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 23:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772697188; x=1773301988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xyHjzGnphi32H4Bte19x6wQV76UaiJqzbc3zMkJKs8=;
        b=DhtmWGjWHV/1kdl91jDodXcdr1AhLuIrH1n+bQ29/udNMI7/u/buS2duPEjrRX3AwO
         BAU8+hdgJKchvAh6c4OfEZfGR96BmymWl7kTgsoxoQKOV9MEq9KP88C6DiqlO2bctIsc
         1nsWStLOscHfAbKaOGra7fgsGgxmo70wUbv6k/MQb9sM5R66xgfuemSqN/U0FefJ7ZJu
         Dfclsl+qBRsdGJoEMWx/nJMRBcM0D/YzWAuHt6/0v0SmglkRKFNm7Zi2xgPIaKBisFSd
         sTCGFPW5qqqkZBAVmPFckCdU4WLqYGxAutJTfOQ0RyVHlYJSoEne2MX4MEVNj32O0hRZ
         q2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXDJUEriDr3HM7OKORUL3Tt1NjVyl0/oiYuYdnzcvtWfXSpmXpIZbiCqdH3lJwHRBtmKD5cWfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmW+Q0RpodAbIgjbuHhQcwPgBS25rI0F3/mD77rPUyHvFMdYr
	7f+6Tpv3lI8ABv0CJkBhAr8Io3xgYm7eCiodjfKFJoSHWJ7JD8c+Wfhh4fHpSY1z
X-Gm-Gg: ATEYQzxws/Md8fWTCdnw+aIXeAPQfBrM0rNl0xV/dnKTNxckVX1Ylz/ZvXMNTdMpgI5
	DC4GjsK4LnVu+1bOpM6GcLS3ONFsaAVyagWJvPab2ZI8phuQjNT6gK9k/T+J6RnFfi7AzE6GPsh
	54wxnWabsfVG4qjNQEDS8QbO9nLzM8+03UdWn+E7msd7bttM+A3OjrPThNo292vVxp5wQLiMOt0
	lc7HTzgtWjp6q3BBUk9TKwHfo0sD7dvWvRcmujkG0qR/EG0nj5UWQ/7v7QuK+nkoE2fwynWsQlS
	ix+06Tfw+HyYdigIjophrA+586OVd/C0PDoRcqFmFE5mmJgN8t3Vg6FE72HYqvUAyVjE4Csuid8
	boa5Hs0pxFEmWSceozodVlkVtU8VQqXTH69VebAEU8oJ3rL6LnNBmAW0QShTxRaGo52Eblernac
	i2MkZkK9XBBl7xdTsaFNh+M+TkGHL+WImaiSDMQb3PmJVxHjzeD0SLsA/gRlxlYm4r
X-Received: by 2002:a05:6830:4709:b0:7cf:d2f3:af8a with SMTP id 46e09a7af769-7d6d39ef3cfmr3239338a34.28.1772697187950;
        Wed, 04 Mar 2026 23:53:07 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5910039f9sm15579728a34.7.2026.03.04.23.53.07
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:53:07 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-463f00cda04so5010946b6e.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 23:53:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWco16zh8Z+nTC4k4z9IIubvpewzw6rQgWAsNKtvaAqiTW4TztqDyxvmT2fUD15tuzNFlrno68=@vger.kernel.org
X-Received: by 2002:a05:6102:32c1:b0:5ff:a16b:93f9 with SMTP id
 ada2fe7eead31-5ffaae2d5b0mr1883200137.21.1772696877960; Wed, 04 Mar 2026
 23:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-14-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-14-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 08:47:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNtqsui3ek1RYCTyiuDLRajpSBMnrdzED6wu6i7-QcuA@mail.gmail.com>
X-Gm-Features: AaiRm514iMGAdfTBAVsgfVfK-GGHy9jHY4ezK-Lp3w09-JWpnENLQ0I4lkIFgvE
Message-ID: <CAMuHMdUNtqsui3ek1RYCTyiuDLRajpSBMnrdzED6wu6i7-QcuA@mail.gmail.com>
Subject: Re: [PATCH phy-next 13/22] phy: introduce phy_get_max_link_rate()
 helper for consumers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andy Yan <andy.yan@rock-chips.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> Consumer drivers shouldn't dereference struct phy, not even to get to
> its attributes.
>
> We have phy_get_bus_width() as a precedent for getting the bus_width
> attribute, so let's add phy_get_max_link_rate() and use it in DRM and
> CAN drivers.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for your patch!

>  drivers/net/can/rcar/rcar_canfd.c                   | 2 +-

For the Renesas part:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -640,6 +640,12 @@ void phy_set_bus_width(struct phy *phy, int bus_width)
>  }
>  EXPORT_SYMBOL_GPL(phy_set_bus_width);
>
> +u32 phy_get_max_link_rate(struct phy *phy)
> +{
> +       return phy->attrs.max_link_rate;
> +}
> +EXPORT_SYMBOL_GPL(phy_get_max_link_rate);

Any specific reason you are not making this a simple static inline
function, like phy_get_bus_width()?

> +
>  /**
>   * _of_phy_get() - lookup and obtain a reference to a phy by phandle
>   * @np: device_node for which to get the phy

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
