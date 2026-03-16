Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530EE3603C8
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773649359; cv=none; b=uAOTi6QJ4tCNjrgUtv+IL1MjVGbunqK7RqPAkySXtFknsWQllvMqoZvfwQA3YCU/mhW0uGXRJChYP3jvDBlo9RN1VSfgFNHoqxahvlk1wFjMTpLI3NMgxnC2zcJLwPBw25kpBImMWtkEdZq8ugzdueGRYZogu7e7UMsH/FaXEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773649359; c=relaxed/simple;
	bh=K4PRTP6RiXe4ekfnxbKijRsel6dDC+QKM/gt9YizooE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3ogSdQswRWhvJYhP5ghCeBGgcoFBZ1mbRRT9/EiyEiqlSZn2ulTsNEfoLEFb33nFLwcGXPaF95OrQrxvjiMhhvHtwv/Uon9UPMqKam3vTzlMARWYtqxUm0y+OX40VDg7I4SSYRTzv+sVusHzPfceOt747kNWOZUOTuf5cSTCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56b069fed64so1676653e0c.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 01:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773649352; x=1774254152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHPoB6LHBRts05kAm+HAniBgww0f16o7iYE+d6aW+Hw=;
        b=sGPXb97yzF0rFztBdUfmU/tjZB9SVz8KdQaWYNnSVng60PUSSn/EGpxf82NnIa4YF7
         QOYsXGxJ24dK9dfbF7YB/gKh5ckeZqBdSUoWbmNe9m/6/UzcBcMWqxoGCCb5Np+7eR0N
         aUY703NDwT17vt2CS3b/CwrUbnqjI3ititNMV2FIB+eQEKOhJz8GKHBDU2l0fgOYS5TD
         VpufXcc31wsTfS4fyVBSPBKbsBnQNwBFTWZTVtQQXjQIuTAKR8RIqf91WEGaEs8Zi+JG
         imBy8wsOWsIN6L8wOp9TrZ8mSGW59tIcSt8l+KDtKjRGcylNUE3gc0tIPYLCN+y38ezw
         32xw==
X-Forwarded-Encrypted: i=1; AJvYcCUmcMbLllNxKujUX+2VLjpmxaWf5TuxxGAZTvysBjKeGmd/HlAisaQUrX3W4ii/SKnifR0ilvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hs8cVFwKNxrr/dD3A3t+sCNvzrCIj1LU4ZLlO6K8myLLo5Qm
	fZ+/X4qN1hzZggtrjtusU1N+XPC0w4Q8HXM7lhnFO+Iw45g1HAi/iQGgQZvdCvop
X-Gm-Gg: ATEYQzxpRjZA5sRLONt82b/FisBbPF6uJkSQ8xnWM2btZBrFK++novQ3t9FQ7TMMdMF
	gC5zx3ignfVLj9k+J+7KGsvLZkcCmeN1PFdTeQJRAsQwWz7n5r6cmlC+sRWIAxzvsAIRMe3FPwq
	WT/QPLQOR+80/croz2/1Ig8ioECg27OS/ygrMsvlBFBAlydc8T4HcPe9QnVtHFrAvfRUvhLlR7E
	XEDRU9bL2ih5SO3iS2JlGLNEHAGIVp0WrzkFF174mb62Zo4keMHpw397LZNXlUogsAiRcaRWuTi
	dO4OoU20J59DGnJzJnWBDe0frGqpF+oZXNZRU6UPjsqsoZ/CuCi8YHCh5orxnYcaVVKpkchPtrO
	heYlI4vWfe6kak0aJsnkTuhzVgNp29mDtMhPE7ekd53IeHNz3VC0bmCYQQIRYLAhrhytTGaDCBc
	SgyGmSn9ipPCx1kwfvriYtkm2FxZF8+FRaGqUvO2bzzpBF9oEQH493h0SqLrENgeljAjq8rg8pe
	as=
X-Received: by 2002:a05:6122:46a5:b0:56a:ef89:34fc with SMTP id 71dfb90a1353d-56b6283ef7dmr3882416e0c.6.1773649352112;
        Mon, 16 Mar 2026 01:22:32 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b8eef9178sm350483e0c.2.2026.03.16.01.22.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 01:22:31 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56b069fed64so1676644e0c.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 01:22:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTUY3TngPI6zh/8SAabvRCek3z+8aQaWSBB/ObM+GoS3ljl3wJFYVvfQcYRBZt1Is9FWJsFSI=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0e:b0:5fd:f744:660e with SMTP id
 ada2fe7eead31-6020e60078dmr4136686137.28.1773649350869; Mon, 16 Mar 2026
 01:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ccda7a00f250e87b0457e276ac1070cb0708d71.1773321267.git.geert+renesas@glider.be>
 <20260314020107.2241383-1-kuba@kernel.org>
In-Reply-To: <20260314020107.2241383-1-kuba@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Mar 2026 09:22:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW7TJoDTYRtca1Y86pVuvUbnDX_x3MUYtvEbgPu915Yhg@mail.gmail.com>
X-Gm-Features: AaiRm50TKdino7hX__Fr8XbUbMY5_IOg8mWiIXEhr4B3B1Mph0NJ-Pgqg-orWL8
Message-ID: <CAMuHMdW7TJoDTYRtca1Y86pVuvUbnDX_x3MUYtvEbgPu915Yhg@mail.gmail.com>
Subject: Re: [2/2] dt-bindings: net: micrel: KSZ8041RNLI supports LED mode
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	eichest@gmail.com, conor+dt@kernel.org, krzk+dt@kernel.org, 
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch, robh@kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub(ot ;-),

On Sat, 14 Mar 2026 at 03:01, Jakub Kicinski <kuba@kernel.org> wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> dt-bindings: net: micrel: KSZ8041RNLI supports LED mode
>
> Micrel KSZ8041RNLI supports LED mode, just like KSZ8041. This fixes (a.o.)
> the following "make dtbs_check" warning for the r8a7791-koelsch device tree.
>
> > diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
> > --- a/Documentation/devicetree/bindings/net/micrel.yaml
> > +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> > @@ -54,6 +54,7 @@
> >        KSZ8021: register 0x1f, bits 5..4
> >        KSZ8031: register 0x1f, bits 5..4
> >        KSZ8041: register 0x1e, bits 15..14
> > +      KSZ8041RLNI: register 0x1e, bits 15..14
>                   ^^^^
> This isn't a bug, but there's a typo here. Should this be KSZ8041RNLI
> instead of KSZ8041RLNI?

Yes, it is a typo. Shall I send a v2 with this fixed?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
