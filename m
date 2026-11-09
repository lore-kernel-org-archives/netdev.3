Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239358;
	b=1PkNWaOACaFUG/15IQc3wiPbQNEYt6QKG1Y0SrOUbP2ltiHGPQw71Fa5H5CYGNKNT3Vn
	 5QsjFz5+rCP0ACzeOS1xOcR//YZJKY+5Y8F3rmxpDv3JsGNsJGV2+0TSF+tIZIrs6DcUW
	 h68zWLbvayYpNfdp33l3V041GCOji81/A16xkWgvdYynrD+eodMyfmRuV4TPvQhOn4sRY
	 aIF8FNb7cCem+BPzjMFtDJ110hqTMvOEQXK/YQJUH2oqLoi5fLPHx887xjt20WSwZ8EC0
	 WgcsMBJ1qnAl0DXUEqU/Q8Zy79JfXwaOSfLlON4XyeaYTUaqU9r6KKzWg7LFVH2hIGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239358;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mQ4LVrS7TAycIWuwYP6nLPokX8EbBu04NF8VpAWRnUc=;
	b=dy5+NQ2e6cJLfW5oIHui/QLAOCDvMywXnhz72jr6a3q4HADmw4jBJI4nitSWmyoLzxxw
	 wC9xk3It6/cJcebhktmjDkvAvwU2CVOc4iaYknmkR8WZUQQcFNDaqbtghF8ebt8V/ipLD
	 F2s8uwnawfxqvYtqY3CnOVIxHkAp55uhsUXZxRQAa56llgPXgNux1o+bNiOfdpa2MQmbV
	 M5uZvNaGlwOQNh9RLAlp//stNCbaZSCDlwFclZgWs6auQVDIBrvCTym9mNY9+7CDpMKy6
	 gcVoffrJ8OOOkU7TC5OtTXnJbg9MdPJ69WWYPT1+aFPzzQ5C93Rr094RKjV24keChog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBE606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 15:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2FBE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ee029fd76aso440983e0c.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 07:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239356; x=1794844156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQ4LVrS7TAycIWuwYP6nLPokX8EbBu04NF8VpAWRnUc=;
        b=I/RfqH7yOL14dWSC53qaJcaSPqB0I3B9Uh2Hd5c6M0aV4aw255Tso8WvLNKjHQYFsL
         ueCmSQ5+Ue0QTFSa9Zpw0L5bD/3u5ATpeIGYXRTFpgT+27fywGiGCeltN5WAMtOiLSsT
         GI67cpYfRur+25kDqIl6cWVEC8UCTMeHHpxPdcUPZumGfui5LwARpd/9lvzgpLb/9ZN0
         y0vIiHBRPcN4VF70hqJG21F1UISwHb2ROZhRwwXeRSf+mHGGnurE+wdJSwHbQYerOC5k
         HbxGNrhB/CaUFcyMoCk+OWbrrDPMi779R7HLX+bsrurG7Rs0aoJpNysXtaluyVtcwkQs
         n+Zw==
X-Forwarded-Encrypted: i=1; AL+hErEKUXIIuAYRAfEQcjnvEcJh54kdAgtn+gvdEH9R4zTrMOSqFFVyQHBb+VDhLBgZ42cO9Rb8AqY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cowVo7IiEqn8fgMLcnerX6ezSH5cA+z5hGOCfmEMAlRw0I7MI
	CDMawVivoZ3dakF9Fs3xNIg3mY18rRRsQmi2aCmVQW4VzfXppC7P48HiNE+j7ZWCpPwAAg==
X-Gm-Gg: AYBFou1D+I8pxWQynUcOvUaLnATLQXElJUwT25WrculfvdRXYuZW6SqZsICX9X3ECod
	/laI8IYfSNOocwObEEhBWMBLpMwT1vBwoBPbAz9kbJN1cx6cWRl5+kNv+USBsuYKSz99x7NGcen
	LPbeblvv8CZw45WhSaI9JePpYPSk9gzrTATdm7C/SVIJTVGtby9Ia7pgcdK4HtplPTPqrkN7YZl
	oQd2gkJCCW0vnfVwC2YTG5PT9VYvDQXlkM7u95qWPQ2lR9mQaqR1Mh1+oNMRjjWaJSOrfEBnQ4u
	T32vG037xJWPxAk4IsGnbWGDx7YkU1T9hrA98hfuG1x2wZNPPIzEoo+mQasTKddEHMxXBtJYon9
	EVACVbgM0A8zMCYQvFZm0AE8siQD0BLmrsV/TNzeKz4GEoVB93lUDKhehvmeohlxo3uYSe6gKgX
	suylbDrd6CF8BDDuWj0vZWkdYyW0ZWTBqlUNT9RtCXgfoIs1WlMHfo3RBE+NNWMjGqjywV2QU98
	lqjchBNxDoQD4mQi0iFPIBbUa9oYhP9JnebAFahcbH26HdVRUfC1K+Am0UHTJa8UAFXpzBPt+eF
	x204MlDYm3xd4aAjoDrWtJfIBiQ5//flyePNF5fNRnHrBPOq06SAoNqXamiKqXhrDNw4ub8f8W9
	fsayL/WAlk42s8iUzQ5BIGgE7CO2yrB6jX/ihy56/1hDiDI8a9hSRo8Il
X-Received: by 2002:a05:6122:3c4e:b0:5c7:fbb5:6ea0 with SMTP id 71dfb90a1353d-5ece72073c4mr1527739e0c.4.1794239356574;
        Mon, 09 Nov 2026 07:49:16 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece6682bd0sm4571550e0c.16.2026.11.09.07.49.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:49:16 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5e9528732b4so836715e0c.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 07:49:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGQdmXx6yJ4G+fXbJ9I+5WwOEkt/InQHHQNVslKwW5nuL9kL87BkgpkmmqZKnppcN0J/CKW2CY=@vger.kernel.org
X-Received: by 2002:a05:690c:e3ce:b0:8b3:56f0:38d1 with SMTP id
 00721157ae682-8b36c854704mr28695777b3.3.1794239004423; Mon, 09 Nov 2026
 07:43:24 -0800 (PST)
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
 <20261105-stoic-cricket-of-tolerance-cb3014@quoll> <35dc1ebf-5194-4ec8-adfb-dcc8ea717750@amlogic.com>
In-Reply-To: <35dc1ebf-5194-4ec8-adfb-dcc8ea717750@amlogic.com>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Mon, 9 Nov 2026 15:43:13 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+0QqBHGv-4nfmY8N_xr=KQgUFtwPQTVZBxTK1LHV0jGOQ@mail.gmail.com>
X-Gm-Features: AclHuK8i80yCCEWCPsmXh9g28kddZ8mRpDlp24I5tNty5i0jlojD6mTpEXhkklk
Message-ID: <CAJX_Q+0QqBHGv-4nfmY8N_xr=KQgUFtwPQTVZBxTK1LHV0jGOQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, xianwei.zhao@amlogic.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
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

On Fri, Nov 6, 2026 at 3:16=E2=80=AFAM Chuan Liu <chuan.liu@amlogic.com> wr=
ote:
>
> Hi Krzysztof, Lucas,
>
> On 11/5/2026 7:57 PM, Krzysztof Kozlowski wrote:
> > [ EXTERNAL EMAIL ]
> >
> > On Tue, Nov 03, 2026 at 04:37:10PM +0000, Lucas Tanure wrote:
> >>
> >> Assisted-by: LLM
> >
> > Drop this one.
> >
> >> Signed-off-by: Lucas Tanure <tanure@linux.com>
> >> ---
> >>   .../bindings/net/amlogic,meson-dwmac.yaml     | 59 +++++++++++++++++=
++
> >>   1 file changed, 59 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac=
.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> >> index e769c9bb70d8..6de013e3e8f6 100644
> >> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> >> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> >> @@ -23,6 +23,7 @@ select:
> >>             - amlogic,meson-gxbb-dwmac
> >>             - amlogic,meson-axg-dwmac
> >>             - amlogic,meson-g12a-dwmac
> >> +          - amlogic,t7-dwmac
> >>     required:
> >>       - compatible
> >>
> >> @@ -57,6 +58,59 @@ allOf:
> >>               - const: clkin1
> >>               - const: timing-adjustment
> >>
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: amlogic,t7-dwmac
> >> +    then:
> >> +      properties:
> >> +        clocks:
> >> +          items:
> >> +            - description: GMAC main clock
> >> +            - description: First parent clock of the internal mux
> >> +            - description: Second parent clock of the internal mux
> >> +            - description:
> >> +                clock of the pipeline stage inserted in the bus path =
between
> >> +                the controller and the DRAM. Without it, the controll=
er cannot
> >> +                complete DMA transfers.
> >> +            - description:
> >> +                clock of the register block holding PRG_ETH0 and PRG_=
ETH1.
> >> +                Without it, the block reads as zero and ignores write=
s.
> >
> > This sounds like you take clock from other block. That's wrong, that
> > device should take its own clock.
>
> I see that the clock in the dts patch corresponds to <&clkc_periphs
> CLKID_SYS_ETHPHY>. This clock provides the working clock for the APB Bus
> of the ETH PHY controller, and this clock will affect the register
> reading and writing of the ETH PHY (including the ETH_PLL). See section
> 15.3.4.2 RegisterDescription in A311D2 Datasheet for details.

Thanks. That section is the PHY block at 0xfe028000, the region of the
mdio multiplexer node. The registers in this description are PRG_ETH0
and PRG_ETH1 in eth_top at 0xfe024000. On the VIM4 the same gate feeds
them too: with it off they read as zero and ignore writes. My datasheet
revisions do not say which clock feeds eth_top. Can you confirm it is
this one?

Thanks,
Lucas

>
> >
> >
> >> +
> >> +        clock-names:
> >> +          items:
> >> +            - const: stmmaceth
> >> +            - const: clkin0
> >> +            - const: clkin1
> >> +            - const: pipeline
> >> +            - const: pclk
> >> +
> >> +        # The PHY adds the 2ns RGMII delays, see ethernet-controller.=
yaml.
> >> +        # The RX delay line of this glue is fine tuning in 200ps step=
s,
> >> +        # added on top of what phy-mode describes. The TX side has no=
 fine
> >> +        # tuning: its only step is a quarter of the clock period, the=
 full
> >> +        # 2ns at 1Gbit/s, so the TX property is not accepted.
> >> +        tx-internal-delay-ps: false
> >> +
> >> +        # Deprecated: new SoCs use the standard *-internal-delay-ps
> >> +        # properties instead.
> >> +        amlogic,tx-delay-ns: false
> >> +        amlogic,rx-delay-ns: false
> >> +
> >> +  # Delay definitions for Meson8b and newer
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - amlogic,meson8b-dwmac
> >> +              - amlogic,meson8m2-dwmac
> >> +              - amlogic,meson-gxbb-dwmac
> >> +              - amlogic,meson-axg-dwmac
> >> +              - amlogic,meson-g12a-dwmac
> >> +    then:
> >> +      properties:
> >>           amlogic,tx-delay-ns:
> >>             enum: [0, 2, 4, 6]
> >>             default: 2
> >> @@ -106,6 +160,7 @@ allOf:
> >>             contains:
> >>               enum:
> >>                 - amlogic,meson-g12a-dwmac
> >> +              - amlogic,t7-dwmac
> >>       then:
> >>         properties:
> >>           rx-internal-delay-ps:
> >> @@ -142,6 +197,10 @@ properties:
> >>         - items:
> >>             - const: amlogic,meson6-dwmac
> >>             - const: snps,dwmac
> >> +      - items:
> >> +          - const: amlogic,t7-dwmac
> >> +          - const: snps,dwmac-5.10a
> >> +          - const: snps,dwmac
> >
> > I see no such hunk in the code, so not sure how to review this.
> >
> > Best regards,
> > Krzysztof
> >
> >
> > _______________________________________________
> > linux-amlogic mailing list
> > linux-amlogic@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-amlogic
>
> --
> Best regards,
> Chuan
>
