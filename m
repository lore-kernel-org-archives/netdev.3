Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD931E8320
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550795; cv=none; b=qR5vphvwYrY9fhoS44WnBNJrIzmv614w92qIZHhDdXH3H727a1v+XYI0wJYJ/8lNLf/bfhylweY/qwN/nARIE9abvIBb3Uxd773kPZgQpKRXCnFkpnf+cKj57HlO57MpAXMgAiFHjKDzaq7GxdgTfZ270IvZW0+rgyOmc85U4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550795; c=relaxed/simple;
	bh=EZZ2E4Hk4P3ioWVMaervDcnw6ADW65oM1zGar71sbpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7c9vPK64dzehJ6+mdSGB+4id26RLvmuirHdxkB9wmHFi+BFASTMfs4CfM4ITWabbYL3/TNlSpy0YAIlR6YrwYuYlph39qagV9CXxoiIhDhZipvhSHDy1gCfNECyTUsPoYqXjt9k3KZgk1KlCiKcWVlLRs4+5M/FPbgG3x6pNHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-47bdee5bfc4so636189b6e.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 05:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550793; x=1778155593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksIL4rip+tLI1Yx6QhQXSN6krUTnsd9SRkVzjQXrZjA=;
        b=WfT0iFiyt0JenzhiELraECanZIOhLtTThQg0rKojmi6dRJT7ohH11vzrPWqDWjtQ0R
         bTidmHSrrfbj6Qdqw3ilCz0L4SFiIiTFW7XymRqafCZHM1Fxr29P2yQxwNC8qaRMQVYz
         DOlg5XIL0BLAXiXSbhTNMcZjObBq+8wNgF7wLmupn6KRyA1XIYOSkmJ4Lg8ZMnn2lSAB
         XLaE3UxVjvi1DnKc477JaJvJQ50teGr+bNB2sT6VmdaHsrL6LnGCpqLKmK0Mn3EkDRhk
         iqAeU/cHZ6eDly2myT/FYJZ3tgBbDAL/UYXFLn2hyZZ7BOz04StiAfVgipxzhshvJWxT
         4Avw==
X-Forwarded-Encrypted: i=1; AFNElJ9C0WC/N/GIaGw+3vT7HiFCPOy41CEH0vdyUwFurSAPgV1XvYMSTJcmyKxFLKwPIAsFXI1mxtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWd6RwmPNlKrQg7OkHBtVuyGDlTFyTgnGCi644E3g20hEJiHD
	wKApLcrdbBW5fsKswYaFTKg7zopQdx44ALiQCAPgJpKc5kAwU5+FxvnjI2KVoH78yZs=
X-Gm-Gg: AeBDieu6bSXTlOVlHK3jzR78GzfBRL4puVKIx3LntJdV64X6IPn0fh/WtdEmjxBNAm+
	SBuWG8BX1R6kEiK8mPrbJjr2xuboHAc3s1HGOiAWxT0jgNDR5/1CUhjZbbin4fe3s6BULW640cA
	iAijdekz/eFsXdLfjOIbdeOqBUb5pkcQ9npDXp5rCWeMtT5LbczQmVBCXupOeSHLCudhuE/0JmT
	pOHk/id+jlUp1uzTkUbcdoSKZYye6VwDJreTVdomSycte9RoZ6U7h6ZDRcyCZAWtWZYcz3wL4aR
	lbHP35kCjsIrYreQ0lES3xudY1AhUrloCP/gW2H6c/pu87pCgs+Nsb69y5vWoFgVx51VuETyqWM
	jXF02KbsSWK9/NHDrXlWopmBcmYPEVZsJe3VxiFYbtw75QxRXvzt3pcjg5QJZEAUheEu8qwfRkk
	xx+OuXpWN2RyV3GW44K41pm0VHqrnQDI2XsSdJkiZpCEyD209Wb39fxp69yjik3HLWcK9N7/Ga6
	NM=
X-Received: by 2002:a05:6808:1a1e:b0:479:eb0e:670a with SMTP id 5614622812f47-47c62147082mr800151b6e.29.1777550792952;
        Thu, 30 Apr 2026 05:06:32 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c4413fb23sm2663778b6e.13.2026.04.30.05.06.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 05:06:32 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479d4df9035so1134368b6e.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 05:06:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9iaj4kimP6ixPg10hqRFVGo3MqbQeeGwjAJUyh/1UsKUvLFsdxBoB0kFsVWyzXL3mkCIGKO7g=@vger.kernel.org
X-Received: by 2002:a67:e708:0:b0:610:347f:9f3b with SMTP id
 ada2fe7eead31-62afc506100mr613209137.3.1777550404889; Thu, 30 Apr 2026
 05:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430110652.558622-1-vladimir.oltean@nxp.com> <20260430110652.558622-18-vladimir.oltean@nxp.com>
In-Reply-To: <20260430110652.558622-18-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Apr 2026 13:59:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
X-Gm-Features: AVHnY4K0yYb6vTu9KdtDciwvAziqboYRX_ITZ386sa6ttixZ1EP_Mzy9gi4Pi0E
Message-ID: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
Subject: Re: [PATCH v7 phy-next 17/27] phy: introduce phy_get_max_link_rate()
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
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Markus Schneider-Pargmann <msp@baylibre.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andy Yan <andy.yan@rock-chips.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Thu, 30 Apr 2026 at 13:07, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> Consumer drivers shouldn't dereference struct phy, not even to get to
> its attributes.
>
> We have phy_get_bus_width() as a precedent for getting the bus_width
> attribute, so let's add phy_get_max_link_rate() and use it in DRM and
> CAN drivers.
>
> In CAN drivers, the transceiver is acquired through devm_phy_optional_get()
> and NULL is given by the API as a non-error case, so the PHY API should
> also tolerate NULL coming back to it. This means we can further simplify
> the call sites that test for the NULL quality of the transceiver.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Acked-by: Markus Schneider-Pargmann <msp@baylibre.com> # m_can

Thanks for your patch!

>  drivers/net/can/rcar/rcar_canfd.c                   | 3 +--

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # rcar_canfd

> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -57,6 +57,7 @@ int phy_notify_disconnect(struct phy *phy, int port);
>  int phy_notify_state(struct phy *phy, union phy_notify state);
>  int phy_get_bus_width(struct phy *phy);
>  void phy_set_bus_width(struct phy *phy, int bus_width);
> +u32 phy_get_max_link_rate(struct phy *phy);

This (and all the existing getters) should take a "const struct phy *".

>  #else
>  static inline struct phy *phy_get(struct device *dev, const char *string)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
