Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570031;
	b=32CMI5S2ERhK4mlLEj/w4cVgEzKgBbBdEftOSYZ5qN9OpSRfXcgRej2TJbJspqegss2h
	 t8BE3+zuaIUvEzo/bx7PAeeuB4LmNtTnZI3+U9roPpL+8WlKDg+4k497K1V5CmwxbwXgp
	 mhH+OTJpqEwF1HLwtWDqnUTK5xLQHyePe5ILLOluB3GDgH3b6TxZWqos4bIEyIERnWe4N
	 C2CGcbHYr2Nwn3qHr7GqVzrvnctz0nEIBDacy/rb6rnlLW/3zB5OvdtfynbYb1R8S9n4p
	 0V9ScV2CJCD1BqgCcDGx4OkVGxQ3N5GTm0fNu5MFEGfYSWLViT3SVk8RkV95qT4TStg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570031;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l1+NgW92VziZf9PgBdzApbIe2BkR1TvVvXtYjUT220A=;
	b=A31WkZoP9EDPd9ATA5vZVoP5zbm0ywJAHNNtExNZ5Qi+bfmbFH9EZ1l4tR/z2wyO28mb
	 hoVZvKPM6Hzq+1KOw9ABsrF3tifpg8OQD3LC3v35A7pTKu9qKw/hbtDeFp++4IeECimf+
	 mXTDC7R+F6Hu57kbJ0LUnuxcXELcLDHLRcdEP1Gt3WJx4lOm/UCJRFknEzw2ePve5RiS9
	 nGwUSJmcAPdse9rsiKDTkEc8coZmITfMtg7uuUBvIRAPHCzk44mjydFhmaKD+9TPOrQXy
	 8f9IWWx6ufNWL4Ozh0GtHP0SNDY7HXQKXvzGgy2lM7u4u/XfIKA5frDVHgeaV0j9yIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C13606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81C13606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so914048d50.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570029; x=1795174829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l1+NgW92VziZf9PgBdzApbIe2BkR1TvVvXtYjUT220A=;
        b=Y1U0GkJO47QZ2g5Tx3SlGRWC/bjeet0O+6ezp7FL+eihl4ICZiC3l/0p02YniHcQUU
         V/FJ9pFXkElZ4KngJM7cpOm7pdUQ0tIzsKUIMReSy6J3ZEo70c92Obq5zwl7bpT0RYsr
         Es/L0BUXrrgfyMuY9O9brlhaIZJl9ChRT9e2BfbarXsvXgLyQtbjbYNw9wfIRFwxexQc
         kcvhFsEJ/CviIqN8AjPh8m2r/JznqL0OBnITGQL1Kkbj6ZGu6oNNyuQtJiXoxLGmtIFt
         XNXxauaTv0SjbY6C2gY8RvAuUD3Kr7ITFogAKtDEy67TPQIdwY7BHUi+VFgypdg3UsOs
         vNzw==
X-Forwarded-Encrypted: i=1; AL+hErHCrvC5+V2rbnK4p1ufZWNDx4xe74OVhTLomxa2EGPafP86I4/FlFgarBbfgz+ee8d3Z9p2ScQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xrc8Lyut5J16qKrth0XfdIe+nAB1AjdjhMxg7JldSq+JalOZd
	saksTLazCQljxvzuvugJTtFdvAnFaJF5AnlwbsA/ecGS6F1HwxRL/I5slmx2qw==
X-Gm-Gg: AYBFou1Tzioasow5Clwb/VBYXF0Of1DfCMhuLK1uhbRuVvf1AgHMHe8Ci6aizHKQhU3
	k2ILoGtY+rTIRoA2MCUZDSvfqTfDt0XgV1fl7eA9d/Ee+DS7wRjNOUrRArrixC+s7nQDY3tt66M
	u3HGdv+b0lpUQDssAn+3SqESBxZ8FDjQBTEzizWijkBtm4QIWUnid+MwIIobxnjU9DSK4zHELg2
	w16YnX1tJsWA8ig9jfwSbW60dhwOljwlUWjwyWxXLguqbi2ebqQWQUqlksG3ghFSXjTIvSxJioo
	ShEtAElfh4R5avxV26FfgGcGXzB+JFdvBjJE1rpKhzHfQakmVYQD2ws+LgBqR6MFg81dJahLWCx
	bWh0ABCBDjJp+p4NNQ2J9iLD9srhR5eKUuSIN8+bG+Ig6lPBjcbEJ6FjFHiBcXU/+cYe/+kx5Kc
	QXkIZK+6KEgHDGnz6m6ZS756wuA8F4XkRuD87vxPzBSpqvFdT9T1LdaslrQyJxcaYD83bdZPH2H
	XQtl1Pp9eSD5br9psRjPsVBCuyYURgDtFWN5I/dA6ULAcI2dgQ7hBFfWzBNSG0BxIHPyuRM7FHR
	jFuq4VHN3M/8XiMp4GKJWfkThZAjK7gXwBuo+Ni8JOFehbvwPFWZrNuDfXnYFQ==
X-Received: by 2002:a05:690e:429c:10b0:67c:12d2:d662 with SMTP id 956f58d0204a3-67d89734f99mr840976d50.84.1794570029496;
        Fri, 13 Nov 2026 03:40:29 -0800 (PST)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com. [74.125.224.46])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a5a4bb4sm1774651d50.11.2026.11.13.03.40.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 03:40:29 -0800 (PST)
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67be9601f31so734403d50.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:40:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG8odDg11g2I7xsGg3GWIkZ4HAgvCiTZzYGZlKirbiJ5OK8BsCA9pgQ8kA6xz1yimYdbFac3/Q=@vger.kernel.org
X-Received: by 2002:a05:690c:f85:b0:8b3:45b:a4f3 with SMTP id
 00721157ae682-8b4aa350595mr13731467b3.83.1794570029115; Fri, 13 Nov 2026
 03:40:29 -0800 (PST)
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
 <CAJX_Q+0QqBHGv-4nfmY8N_xr=KQgUFtwPQTVZBxTK1LHV0jGOQ@mail.gmail.com> <bbe0dedf-4b02-4cc6-97be-accfc06baa10@amlogic.com>
In-Reply-To: <bbe0dedf-4b02-4cc6-97be-accfc06baa10@amlogic.com>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Fri, 13 Nov 2026 11:40:16 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+0seFwDvd6zksLnJjWYJJY1QcLc1gAjr=FN1p+aTdumpw@mail.gmail.com>
X-Gm-Features: AclHuK9I2BMo6FvBmijHWWypkJRsPu48XUE9NXvVmMxUtTJAFVoacoB_pnoFyzs
Message-ID: <CAJX_Q+0seFwDvd6zksLnJjWYJJY1QcLc1gAjr=FN1p+aTdumpw@mail.gmail.com>
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

On Tue, Nov 10, 2026 at 11:43=E2=80=AFAM Chuan Liu <chuan.liu@amlogic.com> =
wrote:
>
> Hi Lucas,
>
> On 11/9/2026 11:43 PM, Lucas Tanure wrote:
> > [ EXTERNAL EMAIL ]
> >
> > On Fri, Nov 6, 2026 at 3:16=E2=80=AFAM Chuan Liu <chuan.liu@amlogic.com=
> wrote:
> >>
> >> Hi Krzysztof, Lucas,
> >>
> >> On 11/5/2026 7:57 PM, Krzysztof Kozlowski wrote:
> >>> [ EXTERNAL EMAIL ]
> >>>
> >>> On Tue, Nov 03, 2026 at 04:37:10PM +0000, Lucas Tanure wrote:
> >>>>
> >>>> Assisted-by: LLM
> >>>
> >>> Drop this one.
> >>>
> >>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
> >>>> ---
> >>>>    .../bindings/net/amlogic,meson-dwmac.yaml     | 59 ++++++++++++++=
+++++
> >>>>    1 file changed, 59 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwm=
ac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> >>>> index e769c9bb70d8..6de013e3e8f6 100644
> >>>> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> >>>> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> >>>> @@ -23,6 +23,7 @@ select:
> >>>>              - amlogic,meson-gxbb-dwmac
> >>>>              - amlogic,meson-axg-dwmac
> >>>>              - amlogic,meson-g12a-dwmac
> >>>> +          - amlogic,t7-dwmac
> >>>>      required:
> >>>>        - compatible
> >>>>
> >>>> @@ -57,6 +58,59 @@ allOf:
> >>>>                - const: clkin1
> >>>>                - const: timing-adjustment
> >>>>
> >>>> +  - if:
> >>>> +      properties:
> >>>> +        compatible:
> >>>> +          contains:
> >>>> +            const: amlogic,t7-dwmac
> >>>> +    then:
> >>>> +      properties:
> >>>> +        clocks:
> >>>> +          items:
> >>>> +            - description: GMAC main clock
> >>>> +            - description: First parent clock of the internal mux
> >>>> +            - description: Second parent clock of the internal mux
> >>>> +            - description:
> >>>> +                clock of the pipeline stage inserted in the bus pat=
h between
> >>>> +                the controller and the DRAM. Without it, the contro=
ller cannot
> >>>> +                complete DMA transfers.
> >>>> +            - description:
> >>>> +                clock of the register block holding PRG_ETH0 and PR=
G_ETH1.
> >>>> +                Without it, the block reads as zero and ignores wri=
tes.
> >>>
> >>> This sounds like you take clock from other block. That's wrong, that
> >>> device should take its own clock.
> >>
> >> I see that the clock in the dts patch corresponds to <&clkc_periphs
> >> CLKID_SYS_ETHPHY>. This clock provides the working clock for the APB B=
us
> >> of the ETH PHY controller, and this clock will affect the register
> >> reading and writing of the ETH PHY (including the ETH_PLL). See sectio=
n
> >> 15.3.4.2 RegisterDescription in A311D2 Datasheet for details.
> >
> > Thanks. That section is the PHY block at 0xfe028000, the region of the
> > mdio multiplexer node. The registers in this description are PRG_ETH0
> > and PRG_ETH1 in eth_top at 0xfe024000. On the VIM4 the same gate feeds
> > them too: with it off they read as zero and ignore writes. My datasheet
> > revisions do not say which clock feeds eth_top. Can you confirm it is
> > this one?
>
> The information I can confirm is:
>    - The base address of eth_phy is 0xfe028000, and its corresponding
> APB clock is <&clkc_periphs CLKID_SYS_ETHPHY>.
>    - The base address of eth_top is 0xfe024000, and the base address of
> eth_mac is 0xfdc00000; their corresponding APB clock is <&clkc_periphs
> CLKID_SYS_ETH>.

That is not what the VIM4 does. The stmmac core enables
CLKID_SYS_ETH before any glue code runs. With that clock on and
CLKID_SYS_ETHPHY off, PRG_ETH0 and PRG_ETH1 read as zero and the
driver's writes are lost: U-Boot's 0xa0000 was still in PRG_ETH1
after the driver had written 0. Enabling CLKID_SYS_ETHPHY right
before the write makes it land. That was the v3 bug, every frame a
CRC error. I repeated it today on the running kernel, toggling only
bit 4 of CLKCTRL_SYS_CLK_EN0_REG0 from user space, every other gate
left on:

  both gates on        EN0=3Dffffffff EN1=3Dffffffff PRG_ETH0=3D00001601
  ethphy off, eth on   EN0=3Dffffffef EN1=3Dffffffff PRG_ETH0=3D00000000
  ethphy restored      EN0=3Dffffffff EN1=3Dffffffff PRG_ETH0=3D00001601

So on this chip CLKID_SYS_ETH alone does not give access to eth_top.
Could the register interface of eth_top sit behind the eth_phy APB
slave? Either way the MAC node has to enable CLKID_SYS_ETHPHY, and
the binding will describe it as the clock of the glue registers.

>
> The CPU reads and writes the registers of these peripheral controllers
> (or Processing Units) via the APB. Consequently, the registers of these
> controllers cannot be read and written properly if the corresponding APB
> clock (sys_clk/clk81) is not enabled.
>
> >
> > Thanks,
> > Lucas
> >
> >>
> >>>
> >>>
> >>>> +
> >>>> +        clock-names:
> >>>> +          items:
> >>>> +            - const: stmmaceth
> >>>> +            - const: clkin0
> >>>> +            - const: clkin1
> >>>> +            - const: pipeline
> >>>> +            - const: pclk
> >>>> +
> >>>> +        # The PHY adds the 2ns RGMII delays, see ethernet-controlle=
r.yaml.
> >>>> +        # The RX delay line of this glue is fine tuning in 200ps st=
eps,
> >>>> +        # added on top of what phy-mode describes. The TX side has =
no fine
> >>>> +        # tuning: its only step is a quarter of the clock period, t=
he full
> >>>> +        # 2ns at 1Gbit/s, so the TX property is not accepted.
> >>>> +        tx-internal-delay-ps: false
> >>>> +
> >>>> +        # Deprecated: new SoCs use the standard *-internal-delay-ps
> >>>> +        # properties instead.
> >>>> +        amlogic,tx-delay-ns: false
> >>>> +        amlogic,rx-delay-ns: false
> >>>> +
> >>>> +  # Delay definitions for Meson8b and newer
> >>>> +  - if:
> >>>> +      properties:
> >>>> +        compatible:
> >>>> +          contains:
> >>>> +            enum:
> >>>> +              - amlogic,meson8b-dwmac
> >>>> +              - amlogic,meson8m2-dwmac
> >>>> +              - amlogic,meson-gxbb-dwmac
> >>>> +              - amlogic,meson-axg-dwmac
> >>>> +              - amlogic,meson-g12a-dwmac
> >>>> +    then:
> >>>> +      properties:
> >>>>            amlogic,tx-delay-ns:
> >>>>              enum: [0, 2, 4, 6]
> >>>>              default: 2
> >>>> @@ -106,6 +160,7 @@ allOf:
> >>>>              contains:
> >>>>                enum:
> >>>>                  - amlogic,meson-g12a-dwmac
> >>>> +              - amlogic,t7-dwmac
> >>>>        then:
> >>>>          properties:
> >>>>            rx-internal-delay-ps:
> >>>> @@ -142,6 +197,10 @@ properties:
> >>>>          - items:
> >>>>              - const: amlogic,meson6-dwmac
> >>>>              - const: snps,dwmac
> >>>> +      - items:
> >>>> +          - const: amlogic,t7-dwmac
> >>>> +          - const: snps,dwmac-5.10a
> >>>> +          - const: snps,dwmac
> >>>
> >>> I see no such hunk in the code, so not sure how to review this.
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >>>
> >>> _______________________________________________
> >>> linux-amlogic mailing list
> >>> linux-amlogic@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> >>
> >> --
> >> Best regards,
> >> Chuan
> >>
>
> --
> Best regards,
> Chuan
>
Thanks,
Lucas
