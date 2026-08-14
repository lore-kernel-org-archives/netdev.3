Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12F36EA80
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695103; cv=none; b=rBsRhLoolBaB6oElhoTJ7Zo8zGEelOkkZwkUvD9XfAJeH1Hd4IfjljlSFgla8WjMhWrXtkS+26NzSSTCBE2rXTac+e79wPTWRNjs00/aEh6YdK+3iflmytfKegZs1YOU2KyhEwC1vZu43Y5BxfA5bBfOoulogizKcAZUUvEdGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695103; c=relaxed/simple;
	bh=v4T9gW2vRafpBzkxZdBtZpKsNvF0AsQmaXCfNQoj2eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+NXg+8gxFkSBYCcgjC+dCCoOexj23+foLHwjV9+bSBiLuemh3Cy3YNP7QWLynJZgHlm8VjOkeHBUjwQfC7ZKiZKFiIXfrBs3qV34oLvUOsF39q2C0at5ie8wUKRkbKq7U5jTe7UsO7fRfA7jLpszGY7R0SJwZoNceIf1ybE8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-977168e4f3dso427480241.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695101; x=1787299901;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YieQAOiAXoJTqhAtI5XvMETug9uQQrcB1boOOSb1fXw=;
        b=KE/OqdA1xbLucalPyCxgjYp9nyf67p/8/DCiaNjgj9jtK/lo/KZaNJXMTZ488FLFpq
         omWRH5/u+7N3F2rUXZcEHBFwQPQGkfA6qaKjWPW2c0gvkEPlAwUSjOpGJ3mFXFv7Up36
         MdBF4/EwapEhdy4c4eJQxMhgBi5vxPG9emD7OkZguNKOKfByeUlo0hsPlYBtUWwSuXs5
         KvKcb8+u+SM8Oy9ed1XlT6IrgquPc+mQlO4HtdXV+hEn42VgUlLuu+GodJ8Nmfd9cbxz
         KLoU7IGdh4XSxf/ACz8cPD/4zT1qJEIsaEqrblHZ2HWH4A+1C6dckJSTnSd6HsJ1E6wK
         jJCw==
X-Forwarded-Encrypted: i=1; AHgh+RqCQjfMcj3Eoy44COlbMPeuarKs2Bz1fNKOV/kyUGqmRpadwfWbdsqZEGQxlCb6nrahZkpEb0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtoYsf0PhL4DHWuQQyWNNNlIa+NSJVc7Y0Wm9giIM2d/QQea/a
	/X3ZA4hRaf8f8qRdLnfZoXvLaZuDxAIN76phQueenKeZK/TFfuRckKcjWW+U9TPR8CE=
X-Gm-Gg: AR+sD11qSyEpx+YQEbW9zZ1XsjyxgYloN7wv3vnsTrMFbIHzGACabjnlcu+2vZMT4An
	fvw2Zn6atNr5R8e1LXN3Fjh2uxIXgTZ4NgDvNQFiZ1rKdEHVytq+FEF5VtPYCCnGAu7JJno6l2z
	WXokp7h7Knj9jgHzrv34JQHFPTY3vj5H9ql4Z7goh+bc4usLHXdA17ayqEKzEy2I2ohq2AAOXf8
	GzzZjO8GDwYfGm7QsgklITpi8Nwgr5dV6GOQRLMSE0reNMSdDgtFUjMoVFhGDL1Jhi6cfGDWwag
	JomcytbRECYsfk/08imPOEoIF1GISAU8OopcTV+vC3V9Cj4tfXoB0d61J87h5r0o1Ci/MfqFnIn
	5MfMpKwCeJPxcWVVAQe0dWOzaJ5DTXfsXN8W3wBHWzb5SPldZSUGrxPLxKb2cMWK8lcDuyKXlYP
	D0HRyofOYd9dEj+TcLWig5GBnSMmfnxDGHnCc/X9V2uxURnnrbhrDhOTygxQNXblMXywwqH5DaL
	AU2ijJ1fdfLK/oCJHNpWiUQ3rOigg==
X-Received: by 2002:a05:6102:1607:b0:738:fd01:5b60 with SMTP id ada2fe7eead31-76f2a5dc579mr942366137.3.1786695100916;
        Fri, 14 Aug 2026 01:11:40 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97bfbdafba7sm501447241.12.2026.08.14.01.11.39
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 01:11:39 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-59cd803792aso552249e0c.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:11:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqoaPrbb1aT99AckcCZk7YfM4xd+BFOLl/1Bs4/nLCHc3cUe4LTOROqO1TNDycEdiQ07Qj4hvA=@vger.kernel.org
X-Received: by 2002:a05:6122:e183:b0:5bf:ac34:ce26 with SMTP id
 71dfb90a1353d-5c591f2c240mr938238e0c.11.1786695099116; Fri, 14 Aug 2026
 01:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com>
In-Reply-To: <20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Aug 2026 10:11:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWUrabJOWLAiSrSm=r7KbuZn4CrVZiswJsf96U3STaNTw@mail.gmail.com>
X-Gm-Features: AcwNN1VBy68t135CijNHMQtqI6g9Xvn6Re0OoflxL4rb6mgUvwNTcbJNfwwBIdI
Message-ID: <CAMuHMdWUrabJOWLAiSrSm=r7KbuZn4CrVZiswJsf96U3STaNTw@mail.gmail.com>
Subject: Re: [PATCH] net: pcs: rzn1-miic: Fix config array initialization
To: khendry@reliablecontrols.com
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

CC Prabhakar

On Thu, 13 Aug 2026 at 20:09, Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> Fix memset parameters to initialize the entire DT value array
>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data
to SoC-specific struct")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -683,7 +683,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
>         if (!dt_val)
>                 return -ENOMEM;
>
> -       memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val));
> +       memset(dt_val, MIIC_MODCTRL_CONF_NONE, miic->of_data->conf_conv_count);
>
>         if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
>                 dt_val[0] = conf;
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
