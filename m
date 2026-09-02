Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00C38888C
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332738; cv=none; b=t9vHHMywGuDy5IZ6cRixix5B28CwcAUR/L+8AbGkFoSVdtvYvdgH/6+LWk++U9eDO61WnaILS5PgwBm2HpKeXpWT44cTZK6M4rY/bbN7PAW2LxUDQBTyxX84BX4W2cw+x60jentO3rbd1IsxHQSRcG7CRtt84cvUuGEui3akjlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332738; c=relaxed/simple;
	bh=fzDpYNuECOcmrly29xrZFaME995vWnsllDCrIFhx8dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XE8Ye/0zidFPysdOARYSszzQmLw7mQs2pCaKiHa7BYbedXp35JAn5bac96IUkq+nwrPQt3qMnL2sm7kXeLRmeOvC1Bf0ZrXUK9VZHTFdY3YRYDWmF6thZIFN+qhFGFMHJ4dv/JCoZLLeKJSGWSQlu04/dLAZnTQktLhmRQBgIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9773c6ea885so250992241.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 00:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332736; x=1788937536;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=34YhfY3hqkRc1EY3EtPWnzhtL96VmHVIc4hAuYVzERo=;
        b=C+Zpnm7jKTdeAv5vPrx1ss5Jsw9eT6Twwu1IaY/BrAQsgzhzdobiECgH0Qgy/6yg/I
         avZEkCC4bWwtiZokXpRBy/E0Y/2zQGjTA7RbmNJyePd4wu3S6/QV3xPubTsmpAKrQW4A
         zT+Nw26V4kUMTjuhrRZq3Q6OvusEnPTSs6zlgHiPN7TRi5xeV0YEYC3gQpSA4wYu3PNV
         p48M07NaTfX8N+vpJO37wHuv364xtP2XSVblLjUodPl4QduYeTuo8fv1MA8Ektkphf/i
         Vx2ZrWV/VcWQi60zEOhhek2G70bOuvOXxKJWMczi/3AMx3YSt4iBF9J2cMT7G9Txhh3a
         LCIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxntBzJYsQZCjB7CTcbn7Lb/xbVei/TywOHFTAE1ikgA6HTgHXVWxm6AfG0VJr3H5Py+4HQe3g=@vger.kernel.org
X-Gm-Message-State: AFuF++k6jtMdZEqxFCwUtNt6q52YRa4teYklNT9IvWTDl223ghPfqtcl
	xUajPt2314glcrRMVM/6sijdyuGdb99AbPzZa6Tc9bCR3sibyBwjQMpExknfryM1
X-Gm-Gg: AYBFou1dmpUgP0d+OyvW8coi6Amoe9LNwghTFL7jcsEsHqlzeIJQTD7IvKbNkJnrU/y
	BI6hGGKfiWoRgipcg/aQz/AAjBx5fUET9qbgA3ansukmNX4GhbnL55yr+KywRq9qbWxr3q5gJVm
	JMzBxUwvEHsXf9YtGfSGl4XX9YI9a+JTEdqI5oaP2s8Ek5Qh9OgfbX4r68/eODi32s8xLzlgBmH
	S+ekIOTECK0aiDV8svmN4pVvd8V7zpCjPAKMlsGr2p/1Xj+AG4OjPrBxFLDI2yzk3Qfz51WpsZf
	Xz3BYhEFkpm35da+LuBarn80YlzxUYPJhwvmUns5m9OVzHC8UjfxJjnYL+Rugzv4l638rrthiZf
	pXI5gOy6O8zLULeNANuso/k5RI8/3bVHcmdVWJgiypxPhrcehatdiSGk7hUDzOUG45/lHTrUPjD
	frS1QE7T1j2iHpqbTfFr4Bw7wMd07csYF/CIchLKOPXIeWmXAmfph+OP/QJU9I1M4GC8fhrGxgq
	5SbrANfbuYDo5WfbLTtP4UEAokgfedO4aXx
X-Received: by 2002:a05:6102:c12:b0:785:35cb:e64a with SMTP id ada2fe7eead31-78a1f192bcemr733005137.3.1788332735661;
        Wed, 02 Sep 2026 00:05:35 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a1a51326asm1492123137.12.2026.09.02.00.05.35
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 00:05:35 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97bf91b2e6eso167676241.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 00:05:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzj6sQVcx3X0m8nk4e44xyF4ptPjvfURPXwp0HQwobAF/0GYdy2q/i6F3hSvtkN4tDGb+F3R58=@vger.kernel.org
X-Received: by 2002:a05:6102:e0d:b0:789:5f54:2367 with SMTP id
 ada2fe7eead31-78a1f1f13e9mr820442137.4.1788332734870; Wed, 02 Sep 2026
 00:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com>
 <20260901-rzn1-miic-fix-array-v2-1-3e907049e770@reliablecontrols.com>
In-Reply-To: <20260901-rzn1-miic-fix-array-v2-1-3e907049e770@reliablecontrols.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Sep 2026 09:05:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVs4Y+=_Q72QwdHbO=V_Y_-wS2vMzX=Qw5RYoZeXYT94w@mail.gmail.com>
X-Gm-Features: AcwNN1VbxvsNj-N5m50LAojrEK604jhD7foSU4OSV3X2c4XmawrkeMppBtuO5-Q
Message-ID: <CAMuHMdVs4Y+=_Q72QwdHbO=V_Y_-wS2vMzX=Qw5RYoZeXYT94w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: pcs: rzn1-miic: Fix config array initialization
To: khendry@reliablecontrols.com
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Kyle,

CC Prabhakar

On Tue, 1 Sept 2026 at 17:53, Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
>
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> Fix memset parameters to initialize the entire DT value array
>
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

Thanks for your patch!

You forgot to add
Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data
to SoC-specific struct")
as requested in my review of v1.

> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -683,7 +683,7 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
>         if (!dt_val)
>                 return -ENOMEM;
>
> -       memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val));
> +       memset(dt_val, MIIC_MODCTRL_CONF_NONE, sizeof(*dt_val) * miic->of_data->conf_conv_count);
>
>         if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
>                 dt_val[0] = conf;
>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
