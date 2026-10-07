Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD646A611
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369341; cv=none; b=JXabJbaKbMeyQpYb11WDhB1eq/3n/iUKU4ec+VehTFBBhmqT8wN3pfTF6aPsBCXAa2PCNBpXGYBZIcnX1nqApqWV++ErtIXE8VjyuxvGbn4ukKa3w8vEa0f8wr8IfDFH1C9gSk+61TkKeSsEsBQO8YDqv+6qITmkAMSdJiAzm74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369341; c=relaxed/simple;
	bh=VfWUNXmqwxTTUICoAFmFvG8CY3df8em8roJTzWczRys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVfbmIC2nxix1bHknEhUPEfykG2KGZpa9D0Fft8F8vK1BwtUljjuc3dDjYdBYoUu10ZCz8s9qIgPy6gSwTKjCWrjihJrPQzzI20bTIC3ujvJygHuH2tTid9N8ofJuNCcWsayBVfbkgZ8Yxt1o0VkVyu7t28ib9XNLKDlR62ir2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab35bb67bbso3604717b3.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 03:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791369308; x=1791974108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/WbqPTpVsUSqxzGbhEjJKYLBCr4VtJGNv2jZWAZtG8M=;
        b=ipx/4OjoFoTCthQ9jc5x/bJDLpHt8+ujks16WuHVfYR5a8YtE7797GW5YRBizYD96t
         D5uXTVZGAA+YFDIYkYjc35m8lUL5xbga/JG7Zh/OKwqO5ip7jGMdT0IxYUJy8VeTl4Oy
         KNZP8r1F3xmymvRxfS0y8I6OlegDKjt9IYvMrmslI2TMFvX8i3RT6+I77ecErQZnun7L
         ljwSHlnMZfFxp2qPh129dz4BlqeMDNhynmQ4fBuse0SqYVoRWlJAV1MmqCQH7UlAbgbh
         LEpz5FUq+A8n6cRuyfKh/Yqs7gNHMX5SH5g16zpmmI1nZqnic9wOv4izC8L+XFSMxh0Z
         uV8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzO8Q5YO/sMKnZXVsl8SA9mugeoZ0Nku3HslvPo6BwUJFdBgQKcvA9rirYRWWuuUeJhaBJEwxI=@vger.kernel.org
X-Gm-Message-State: AFq9FYInUZNPIo51oNc7Ju4ATkBDcNIjwjCvsx9f36zUCoVvPzVZkaks
	1BH4YLiTbWPfOadDuZvcHnWYkbuBZgcCkHjOQo6ZrgvPHfla3XOPiydIMOC7DFC3AC2lMQ==
X-Gm-Gg: AYBFou0wbH/YcG+QBGDxjHKI0er5jQvbD1bHAtEe36V/QA3A1eWFE7G4NCTPbUZEEfV
	hyIrcjNoPk/zMriVM2g5GjauGd0cKjasXkt2yq4UfjoLnyTRw+hKim2f1obcJCiNchh1RG0ALIZ
	w2muImUMpts8zCm4OUw9F+bEIFzSQFGRVhZO383uFLy/9sKknyKlTgLWybUKx3sol9is+W1cXG+
	G6z/N/o11fvlaKvEpPTOEIqtG8AsDq4XK9It5blhpvO+uxLarQ0TLdfAJAkhEF/W+5qyafmeJ/v
	Xhwr1dMmONrk4143V7xCIUHzMnXvbfPLl1JLyVblDNMWQF+Z6gjpQzb9Hn/s+pRLER5g94k/+VG
	nGZ7KTMAZVwY6NB/9ZCvohY/hCELig3+hlDtoZ8q4wRzu3x9BQ1/oWPbgDouZ4VhI8BCJqvtuCT
	OQJ9W/u5Q/clfxGRzl1UzKMVgLKxN9XfAMNOw/edvtedJX+HJDamM2U5gHsa1syUiG8yd9g3N+v
	Kk8NVgTFTAS7RHeswQUBQufF3z92udbpZ7Cx798FWj483LFyAXzZBaRbRngYlIw4C1jTdcB4Ksr
	JA==
X-Received: by 2002:a05:690c:6b12:b0:8ab:ce6d:e071 with SMTP id 00721157ae682-8b05af7278dmr17593677b3.35.1791369307764;
        Wed, 07 Oct 2026 03:35:07 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05abb19a9sm6951657b3.29.2026.10.07.03.35.06
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 03:35:06 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ab35bb67bbso3604587b3.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 03:35:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz9SYhTXo7gtDd3tzKkTpqIyStS50cLYc+YZqKxjPJTZfZz1NoUAUZMeiuGbn3XAD7/GymIY6c=@vger.kernel.org
X-Received: by 2002:a05:690c:c748:b0:8ae:c60c:57ec with SMTP id
 00721157ae682-8b05b04e271mr11794257b3.61.1791369305826; Wed, 07 Oct 2026
 03:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007082627.63807-1-tanure@linux.com> <20261007082627.63807-4-tanure@linux.com>
 <asYWEwjFO8g50o1i@squawk>
In-Reply-To: <asYWEwjFO8g50o1i@squawk>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Wed, 7 Oct 2026 11:34:54 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+3nHRH--pJHxv6PqwpVYTdFAqG1bQdB5=DT6jgLsFKO=Q@mail.gmail.com>
X-Gm-Features: AclHuK_YBbfO7x4D_vDdU1kkRmRoPOMNGgSI5fmJQcVUylonsGY7I5HRmHvp2sU
Message-ID: <CAJX_Q+3nHRH--pJHxv6PqwpVYTdFAqG1bQdB5=DT6jgLsFKO=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/7] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
To: Conor Dooley <conor@kernel.org>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 10:51=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Oct 07, 2026 at 09:26:23AM +0100, Lucas Tanure wrote:
> > The T7 has the same ethernet glue as the G12A, but the controller
> > reaches memory through a pipeline stage that this SoC inserts in the
> > bus path. That stage has a gate of its own, which no other member of
> > the family has, and nothing else in Linux claims it. It is therefore
> > switched off as unused, and the port can then no longer finish a
> > transfer.
> >
> > Describing it needs a fourth clock, and the fourth clock of the
> > existing list drives the timing adjustment logic, which the T7 never
> > uses. So the T7 gets a list of its own with the gate in that place,
> > under the name the SD and eMMC controllers already use.
> >
> > Assisted-by: LLM
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
>
> Didn't I ack the previous version?
Sorry, I didn't receive one.
>
> What changed?
Nothing.
>
> Thanks,
> Conor.
>
> > ---
> >  .../bindings/net/amlogic,meson-dwmac.yaml     | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.=
yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> > index 90ef79161ab1..96118b4d1560 100644
> > --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> > @@ -23,6 +23,7 @@ select:
> >            - amlogic,meson-gxbb-dwmac
> >            - amlogic,meson-axg-dwmac
> >            - amlogic,meson-g12a-dwmac
> > +          - amlogic,t7-dwmac
> >    required:
> >      - compatible
> >
> > @@ -57,6 +58,47 @@ allOf:
> >              - const: clkin1
> >              - const: timing-adjustment
> >
> > +  # The T7 applies the RGMII RX delay through PRG_ETH1 and never enabl=
es the
> > +  # timing adjustment logic, so it has no timing-adjustment clock. Wha=
t it does
> > +  # need is the gate of the pipeline stage the controller reaches DRAM=
 through.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: amlogic,t7-dwmac
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: GMAC main clock
> > +            - description: First parent clock of the internal mux
> > +            - description: Second parent clock of the internal mux
> > +            - description:
> > +                clock of the pipeline stage inserted in the bus path b=
etween
> > +                the controller and the DRAM. Without it, the controlle=
r cannot
> > +                complete DMA transfers.
> > +
> > +        clock-names:
> > +          items:
> > +            - const: stmmaceth
> > +            - const: clkin0
> > +            - const: clkin1
> > +            - const: pipeline
> > +
> > +  # Delay definitions for Meson8b and newer (including T7)
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - amlogic,meson8b-dwmac
> > +              - amlogic,meson8m2-dwmac
> > +              - amlogic,meson-gxbb-dwmac
> > +              - amlogic,meson-axg-dwmac
> > +              - amlogic,meson-g12a-dwmac
> > +              - amlogic,t7-dwmac
> > +    then:
> > +      properties:
> >          amlogic,tx-delay-ns:
> >            enum: [0, 2, 4, 6]
> >            default: 2
> > @@ -106,6 +148,7 @@ allOf:
> >            contains:
> >              enum:
> >                - amlogic,meson-g12a-dwmac
> > +              - amlogic,t7-dwmac
> >      then:
> >        properties:
> >          rx-internal-delay-ps:
> > @@ -143,6 +186,10 @@ properties:
> >                - amlogic,meson6-dwmac
> >                - amlogic,meson8m2-dwmac
> >            - const: snps,dwmac
> > +      - items:
> > +          - const: amlogic,t7-dwmac
> > +          - const: snps,dwmac-5.10a
> > +          - const: snps,dwmac
> >
> >    reg:
> >      items:
> > --
> > 2.56.0
> >
