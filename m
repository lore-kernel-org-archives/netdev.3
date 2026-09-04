Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF93E8C44
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510011; cv=none; b=faQ7kbgSPie/AQA0Tks+uSGYcs1sbpbC13JT5M3JnZBV6qRhQbBpXDqwhcNDkm1zVR5A3JNMSQjmPOeAvhTEqKmhoSHSTePuV9AWOYIf75xBCLIna4ecZAyaU9osXda46tJSRqrA5pWsWK6Pr64OQGbmMCQinyhzucFojX55o4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510011; c=relaxed/simple;
	bh=oyDxmpF/0rXv8EzH2b2HV9ktlFAjPfgd1vY1EFEf3Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3s8fhbKZ1waXFMwy13PJDN4/z6KRJZEFRqvNNdwM4jVD8S4pWeGGKiQrtYvxTp6+Zl/wQYXWcMbpiBXiHtjpNSGhT2xp7iEr5U3TJnO8guEPX4E+Ysp66irf+bcCeyLJQ5dgcsmGosBvr1fzK9jB2ayYv2q6sEO0+VqCFbIu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-495c49f8eccso710042b6e.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 01:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510004; x=1789114804;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Hg5enr8UVGmoY4IFaKJm1CFD+8hJCgKWPLT+95rrjA=;
        b=BlNDGQfPoqK+wFwtlohy7msf/FP0BCkf18+TfMzLNbX8Bh2y5VbdzA1ViVhRQ8G6Mx
         DNnqAWsl80bJbQSiXscw7rBBBGKClG0w+BQvKabPkQV/gPkTgShD8h6BC4Df6pERL0TW
         NkmZlb0dhkcyP+Z8ZJxfIztp+V3C+b67ZHhnGtBXmKrfTC1fSWwYQoo5n8ED4AjULmpR
         RvjNVz32fqULQ59cXKmiN5alsedj7UpHTiyif+vLQKuQwU3S/S+qdN/YlJjaCtINOpU5
         Z1VJ5pyMbVvHGq97ivFDxdmt662OkV45lfRrMiObc78WvzIxpYg7Eu4gr0QAVPNpaD9n
         q08w==
X-Forwarded-Encrypted: i=1; AKwUvBwESSHhHJ8SBNKZuvF7BNLlYCtWC25qNRf3ChCGn0YdCZl7KmcMicqDbwr5Rj5sqiUzxACkqNg=@vger.kernel.org
X-Gm-Message-State: AFuF++lvrFBL00dxf9EVqNXUAUNENYVk/FGbhTvLYCZ3vMKT0ivBdBRV
	ve/iueHPl8wO7GL0QJdBbM2N6dCejbpFsOqfXKHSWxrRP9Mumq2ggXBMQ42ZN4VIMGE=
X-Gm-Gg: AYBFou2LcYa/8EYQjlvLdoPWAGzHZ5pWk+S1IU5/PJUUjI/gzcCMUCykOOXoM0o6HyR
	er1xs2XyIPWG0jAwpg4zkIbgj93XTRRzRyhz/YDhkCzXN+pp6qMZDsJnXMgFLksUs0CiZ3eA3mi
	BjeHvmLh+cAaEdz13HUB1IFq8kcLw6+74Wf+mPPERcdeotiuOLbxRaVPaIoSuG8H4EXQyQvNTJI
	IBsfoqjhlMckML3bO7zs5QxBPPtnd1otjC5QHUyzQiaPixc2tFS1Y3q+3X2eLHUo/+17KZJ1mB0
	b5NEy3h4cuLh+R/ZAAuzwEutkJzEvt5CNJBHJjyiQBHIQWSXi165v/qUZ8fGuTRDkbJQVyfg/6U
	Bm+O2/Vvcrz1q6Ps6q/Crcd0JBnFnPpV51dheNtlAenWg+G2Lzv+iVt9imD4/98wnA46rKeIu6K
	L48qnck0JjcC92Zour/8PmaXudbrB//JdLa7Ehfr+Eb9looHj0IYuGjZ7QZMBjfwl0NVS5NFbBH
	DghFRkPZQDuvGr6zTwuaOYYmJelOkDwaj6vVg==
X-Received: by 2002:a05:6808:191c:b0:4b3:1e40:6451 with SMTP id 5614622812f47-4b9612bfac4mr4144128b6e.1.1788510004610;
        Fri, 04 Sep 2026 01:20:04 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971675a96sm1717418b6e.11.2026.09.04.01.20.04
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:20:04 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f4f53975e6so620808a34.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 01:20:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByG/ZcHHtEqcyvAq7uBmI/SYBlSJP/xnB/K6Zo7LOKh2nz43bMP3sg591+4QEWScqas6dMnZUk=@vger.kernel.org
X-Received: by 2002:a05:6102:534e:b0:77f:fb50:8822 with SMTP id
 ada2fe7eead31-78a4a9106f4mr984477137.7.1788509665014; Fri, 04 Sep 2026
 01:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-23-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-23-s-vadapalli@ti.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 10:14:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVXHwWKu_oqNQBR=hytL0JQVzMsnVWyBueds5PHDJWmWg@mail.gmail.com>
X-Gm-Features: AcwNN1UYeUOEoTpTj0vmkU4IKRIpHFGa-g95RrL_FdgZr5R39yo0yU6G4UOZ8vE
Message-ID: <CAMuHMdVXHwWKu_oqNQBR=hytL0JQVzMsnVWyBueds5PHDJWmWg@mail.gmail.com>
Subject: Re: [PATCH net-next 22/33] net: dsa: rzn1_a5psw: Remove comma after
 sentinel-entry in match-table
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de, 
	mailhol@kernel.org, msp@baylibre.com, florian.fainelli@broadcom.com, 
	jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	kurt@linutronix.de, hauke@hauke-m.de, chester.a.unal@arinc9.com, 
	daniel@makrotopia.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com, 
	linusw@kernel.org, luizluca@gmail.com, alvin.sipraga@analog.com, 
	clement.leger@bootlin.com, justin.chen@broadcom.com, dlan@kernel.org, 
	rogerq@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	rjui@broadcom.com, sbranden@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com, 
	andrei.botila@oss.nxp.com, wangruikang@iscas.ac.cn, amadeus@jmu.edu.cn, 
	kees@kernel.org, tmshlvck@gmail.com, c-vankar@ti.com, horms@kernel.org, 
	vadim.fedorenko@linux.dev, daniel.zahka@gmail.com, 
	nora.schiffer@ew.tq-group.com, v-singh1@ti.com, oss@vassilevski.com, 
	haokexin@gmail.com, alex@sverdlin.org, aleksandr.loktionov@intel.com, 
	lgs201920130244@gmail.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sept 2026 at 06:41, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
