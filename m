Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238945;
	b=jxhP3wSoqa97Qo3Qqry1O7uG+mYiJOFiSkpaNCRn4X1xvQJaPkBnLK0Lypv/ohLPI96Y
	 hCT4aPVJo/wlQugwyRBedwEI3mHlKJaWaoAf7LCMoIagdN78cqQdqcOJ0ohmQZMWuPNE4
	 l1nhuDQL0zj4HUbBWgN53bqIgQ/Yb7f+Xcm7iqQP9/J/dVzoeo/u0mMV9OOcuHMbK1wg7
	 kOEhU3sIkOF8qytWHwNC/0GeSoiWDGym3n5LmBDKEVzq+IvGaKhkwfzXFlqz8OZIP7hWu
	 4ynp2vC9Md7FzXYE6aKmjHMbXBEklVY8iLlKVOBp3+s/AKwXVve/CbyIHP88ZTZnHQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238945;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xG4pMlSywf90fG++ZmuGwd6o+rUWkZppXqxcs9JhM2Y=;
	b=fAEnCjtDhx4nTqzgKcd7MReQ6suvAMo22c14bBe7bagRc2NPENco+2M+dG92ZoUfKNDc
	 ET0auuOMNuohNuDu3gI7hE4kYproMXrhIyOaq/yDmUe+nJ8Te6gKgLYUgp5GHApe/21eF
	 abSIoYr5+uKxgFtqdrA8XBXbtYuGu1mR8DiBL5+RZsv9x1LrPiGFhUgdSKFlXMCmZum9E
	 Zg22TrovOadn9TrP9ACCj1/sRtdbBH6Q47LQjqQcM/+cDPx+Q+0vZL0yEnBsPAbkmCp/7
	 CsAyE1nvgp09vNiHk2UBe1IwDjknCEsp1rTKqoFlH6d2g2KUly3HMCWWEn61TRQCCuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79717606A325
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 15:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79717606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b305d38bafso7065017b3.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 07:42:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238944; x=1794843744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xG4pMlSywf90fG++ZmuGwd6o+rUWkZppXqxcs9JhM2Y=;
        b=lS24U8jbY/KtpOOm7jFy5oVZZExxCYgeDJZrxoYniIhiq0B847ZzPxbiBH7d4DnJCJ
         LAmkBkL9HSCLyUStkD6To9Ymxt6y2cksOmK/BOB8LM2Qf3GGn1APoOj574dJVhuMG4GO
         9LYzqTrKjqSrQhf0aT2p7y/WWePPu4Q6GHNgCaNAmGryQo7KD+vybvFMLDaViNI8CUlx
         ojA/06pT/LZbbVtJ1nnJ5jBw031kRsgVFXavJmrV84xGe9uoXEl+n54awMXVAOrmMy0M
         yW5fyvSwjva3jMBPVQwx4I32YtI7QhuB6zbiwF0ZfAtTxbHzjzFWrsVI4nZ5DehrC87Q
         foPA==
X-Forwarded-Encrypted: i=1; AL+hErFWI3SjksyNzWwZE4w7GQr+1A30C26xmIMKNJ/12FogD7pXuWxD72A42QjFX3/nST9IZ/W6Y5w=@vger.kernel.org
X-Gm-Message-State: APuU4Z91ERjxNO2jfT0YqgM0U6gJI3vMn3sVYW4AR0SjkwzQAbq6IhBa
	0HVseUP981aFaXHfOt0PPxTZWNHNeZIgPcL93veAj893EXka/HRqzPAbhy/2yaD2xRg=
X-Gm-Gg: AYBFou2RncEgE34+YjBXuhqCVCWQMPBXOIJ5vSH7FkzRckyMjbBCX/w/98CQXh5stDF
	/Md5fJkJcF5pQFXijs9pg0faaJcKQCYwf17f10+I+Zh0JnzfSCL4tw8oL8IAUZN3AoXlEXno6eU
	CwCYG0/oj4NaApcw4g3vOc2tNmPQnGG7ZrInxe56Bp5Svz0L+2fGH5HvH4NVUn/ZsRsz90G21vp
	aIFRNQU8Fueqmkz+JKIL+HpflMMIiNeIm8+xWda3PrZW0P8Tk1HExImx9KWN/3AmoEbGQFWWbTv
	4hae93GnozKE8zkPGxE38WSh5H+yT9avNGHUDibnf0/r4myLLRllWNvGm20Q/raJsloMYcbl7Uz
	XSZ2o5bpXTZ6XSsAvLVE6D1xJXHwRxJp+aDL/caznhj4Yyi0TcTWf/IcW+X7kW95iu3yDJLABgo
	LRh/sL1QPTS2oA3Owv0HMQ4A3oF4eraV8EI8l1HNrtXWzFCJ2FfbBbnYelUGMGx/un6ZWdiI2iJ
	CfJ+Xnj75gXeQAD8mxXMMyE/g74wqondLgm28EU8cWLFJ2a6x71kuub2aTKW4NbfrLkFXEglgBk
	3tsND+/frUElEhfSf1AgBs93TIFsB92T91IhH16ZHSL1YWWuUdR/CamjDag4xAfRt5zWhRaiOCe
	lLfk2GOmYQcqAzQs+iU/YRPaGj0BJR0OT66wbrHSb0uixAdi1ZJlDl3Y4Rw==
X-Received: by 2002:a05:690c:5c0a:b0:8a4:aeb2:acfa with SMTP id 00721157ae682-8b36caecfbdmr21899997b3.54.1794238944248;
        Mon, 09 Nov 2026 07:42:24 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b36bbe3575sm37914067b3.23.2026.11.09.07.42.23
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:42:23 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b354d27917so7758337b3.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 07:42:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFG8tlW0H5CgM+T7/PgyzGPGipZ09XoyGCuF0wOrSMAP7JVxTnxjy+SVKLE2hlVUApa+Wczoc0=@vger.kernel.org
X-Received: by 2002:a05:690c:c4e6:b0:8ae:8d28:77be with SMTP id
 00721157ae682-8b36c8542c6mr28200577b3.1.1794238943160; Mon, 09 Nov 2026
 07:42:23 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103163715.385394-1-tanure@linux.com> <20261103163715.385394-3-tanure@linux.com>
 <20261105-stoic-cricket-of-tolerance-cb3014@quoll>
In-Reply-To: <20261105-stoic-cricket-of-tolerance-cb3014@quoll>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Mon, 9 Nov 2026 15:42:11 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+1OMHo_VWD2+0RUfF6EUNbLLNZafDuHxCBzU_qALBa2hQ@mail.gmail.com>
X-Gm-Features: AclHuK81wJVzU4rFeRI7sUHF0-2FEAkn5jMEtF1UQ-EscSMzMfyyODCM_UAkaVg
Message-ID: <CAJX_Q+1OMHo_VWD2+0RUfF6EUNbLLNZafDuHxCBzU_qALBa2hQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 11:57=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Nov 03, 2026 at 04:37:10PM +0000, Lucas Tanure wrote:
> >
> > Assisted-by: LLM
>
> Drop this one.
>
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> >  .../bindings/net/amlogic,meson-dwmac.yaml     | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.=
yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> > index e769c9bb70d8..6de013e3e8f6 100644
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
> > @@ -57,6 +58,59 @@ allOf:
> >              - const: clkin1
> >              - const: timing-adjustment
> >
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
> > +            - description:
> > +                clock of the register block holding PRG_ETH0 and PRG_E=
TH1.
> > +                Without it, the block reads as zero and ignores writes=
.
>
> This sounds like you take clock from other block. That's wrong, that
> device should take its own clock.

It is this device's clock, the description is misleading. PRG_ETH0 and
PRG_ETH1 are the glue registers of this controller, the second reg
entry of the node. The gate is named after the PHY block at
0xfe028000, which the mdio multiplexer node lists too, but it also
feeds these registers: with it off they read as zero and ignore
writes, and no other gate brings them back. The stmmac core enables
"pclk" before touching them. v7 will say:

            - description:
                APB clock of the glue registers PRG_ETH0 and PRG_ETH1.
                Without it, they read as zero and ignore writes.

Thanks,
Lucas

>
>
> > +
> > +        clock-names:
> > +          items:
> > +            - const: stmmaceth
> > +            - const: clkin0
> > +            - const: clkin1
> > +            - const: pipeline
> > +            - const: pclk
> > +
> > +        # The PHY adds the 2ns RGMII delays, see ethernet-controller.y=
aml.
> > +        # The RX delay line of this glue is fine tuning in 200ps steps=
,
> > +        # added on top of what phy-mode describes. The TX side has no =
fine
> > +        # tuning: its only step is a quarter of the clock period, the =
full
> > +        # 2ns at 1Gbit/s, so the TX property is not accepted.
> > +        tx-internal-delay-ps: false
> > +
> > +        # Deprecated: new SoCs use the standard *-internal-delay-ps
> > +        # properties instead.
> > +        amlogic,tx-delay-ns: false
> > +        amlogic,rx-delay-ns: false
> > +
> > +  # Delay definitions for Meson8b and newer
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
> > +    then:
> > +      properties:
> >          amlogic,tx-delay-ns:
> >            enum: [0, 2, 4, 6]
> >            default: 2
> > @@ -106,6 +160,7 @@ allOf:
> >            contains:
> >              enum:
> >                - amlogic,meson-g12a-dwmac
> > +              - amlogic,t7-dwmac
> >      then:
> >        properties:
> >          rx-internal-delay-ps:
> > @@ -142,6 +197,10 @@ properties:
> >        - items:
> >            - const: amlogic,meson6-dwmac
> >            - const: snps,dwmac
> > +      - items:
> > +          - const: amlogic,t7-dwmac
> > +          - const: snps,dwmac-5.10a
> > +          - const: snps,dwmac
>
> I see no such hunk in the code, so not sure how to review this.
>
> Best regards,
> Krzysztof
>
