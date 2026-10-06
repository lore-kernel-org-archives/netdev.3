Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF52367B8
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278688; cv=none; b=Xc05JVmv1HKzEQROvhaqnla6BJ6oYsIX6uBt4GM8j19V2O5rLBoqerQvvYN5VhMc/M0PoC9+8ROD5YPKfXjuUaHmkA7LTklmm4vzyrxFldBBYWwFfgIVu/hAj/rg+y3Qm2UQfau28kzq/HZzy8WKD9MCxFhgIFjwZyt8ISwf8aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278688; c=relaxed/simple;
	bh=PbO3I5Wzv6Q0HLNgTgjdCNxGPB2wiMT01lvMSgTu2s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAHaTuWYBvDC+QWfJ6Iu0tvCzzAbndYh5vC2WBsCJ5MUgWQdNO6d600lhrTGSdPosLOUSEoN8gxMVBG7oQwH5kQXwxuKMMCFpVUJjtWzP73gy4260vpODR+3yLcslmpE55+1PCFXBZqxY33IADBZWC4HVU4OIjPMcp3eG6kUF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67694513f2fso284496d50.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 02:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791278686; x=1791883486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jVTxTfkNs+IvzxUmHzgjnWzXGShomJ5y8a1XbauhqO0=;
        b=qVBaFk0OPFX1E/6vbxbXkubWkkp17Wfo96oAfVxu18ATQ5wk96GbfyC+LT2MKSF1Ua
         eamw8iwJ+GEzUGyQPtVW5KookMl3HKE7jnQ8gxYmYEQOnE3lWsLHewym1buY3YkUs8W+
         Iui8e8Jno9pcgXLx+8ZUMNayGD6w4MCW6NyFgwSpmFM+DKDXuy9IKMUz1tegb4yjn5Gf
         zri1DNwDSkTEWaVqp2dThKGbbR12DIpHo7FwgljPONAPvOj8bvhNdjGuI//h54u3Amsl
         qdoL9Mw1UhV5RtG0fbksclOT15GqF1LQCmVAMrFesVpYctHG62C4+6Xd3xd1dEu1RpmP
         +GkA==
X-Forwarded-Encrypted: i=1; AKwUvBxhSvZK8cwFG4dYpDt4/kuHHFXFXYuEm7HYzoHSbTnkReFsfgWZ+E9DUEPxQ/Fk7g/MA00L8V0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjne+abWDv9X2lQiRXUrC1eWHtDdmsa1CbopQWgBURlD/P8uZY
	aqEAQBwG2iOVwQh4bpaKT2PKoS1Kq7oT+XQskXtqNefegBHEP7ZTgq2uCwEYRVSSDnM=
X-Gm-Gg: AYBFou0Jn4PqatEcDW2jjgyDoVXmJQqVMmj2Ana+4FCDZzosRKLEKElpG6n1WmX54L7
	2JrWZWJNEyqdkm0JF/v8pb8JDJ/nG6itL4IcTyflolFwNbUlATaTaxlcGkO1PJu3Ne4ubHsKDW4
	3rTjSzOnajbW30vbA4AW6hJFlULk4saVqIhKJlppjaylJCKlUen+mm9bgPRtXFvPMb9GuPCMTlc
	aGjaQRy3CwRUfUC7lDi+Tw1OnXnuyjr+JMmco6E9RnjMV5i/Lcr7WqzMw1AjZEnorIDscZi6o/p
	2pCDT02XQ3hrIkqs1qNbPDRFZuGpxge7Gy9Rze0EiMzu8yQZpUYa4gUcYHLACK75+UxvlL+sO/+
	qVBo4POig/cyeQAzHewUAyzVL7cTd5yvPtMvFXI3Bb3RTlCFPyL9e0Wzok7O6RPkn3hI0xEbJaN
	kHrPTXobeHc6uZ6LWKbpRz4cng4L6lJPM6Lu6amajgq5LhUOWevbLYyAcIZHWZF43CsAxVVRp0c
	cKMp+KywJBfOuF7NWZsFhpl0HvveD3zjHBVjJ3FBSoD6WL1x5q88iwJ40VGnpUWHjU=
X-Received: by 2002:a05:690e:43c2:b0:676:9144:f15f with SMTP id 956f58d0204a3-678fcde0471mr122785d50.64.1791278685849;
        Tue, 06 Oct 2026 02:24:45 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae2ed25172sm49966237b3.0.2026.10.06.02.24.44
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 02:24:44 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ae8607e8afso4820687b3.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 02:24:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxpTFqKx0EGIAicm/UB/095VpkoWzlKc8PYK5UG8SHt1xpx2b/3/IqUB4hfoVvN6WeT5heCuqM=@vger.kernel.org
X-Received: by 2002:a05:690c:7108:b0:8ae:7fb9:8cb8 with SMTP id
 00721157ae682-8b04f3b6667mr2040067b3.17.1791278683947; Tue, 06 Oct 2026
 02:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004144046.391444-1-tanure@linux.com> <20261004144046.391444-3-tanure@linux.com>
 <asN_-5zalENhkdVA@squawk>
In-Reply-To: <asN_-5zalENhkdVA@squawk>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Tue, 6 Oct 2026 10:24:32 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2hD_LTcimHAVhyzgTnp9jYxKKFD2TK5cv9-wLjDh8+wQ@mail.gmail.com>
X-Gm-Features: AclHuK-bVUCezgDuqipnwl794qiJm9NtCr-yWp4gG5KzmPFjPQMebZJ1Y2LQr9E
Message-ID: <CAJX_Q+2hD_LTcimHAVhyzgTnp9jYxKKFD2TK5cv9-wLjDh8+wQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
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
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 11:46=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sun, Oct 04, 2026 at 03:40:42PM +0100, Lucas Tanure wrote:
> > The T7 has the same ethernet glue as the G12A, but the controller
> > reaches DRAM through a pipeline stage that the hardware design inserts
> > in the bus path. That stage has a gate of its own, which no other membe=
r
> > of the family has. Nothing else in Linux claims the gate, so it is
> > switched off as unused and the port can then no longer complete a
> > transfer.
> >
> > Describing it means a fourth clock, and the fourth clock of the existin=
g
> > list is the one driving the timing adjustment logic. The T7 applies the
> > RGMII RX delay through PRG_ETH1 and never enables that logic, so it has
> > no use for that clock. Give the T7 a list of its own with the pipeline
> > gate as the fourth entry, under the same name the SD/eMMC controllers o=
f
> > this SoC already use for the equivalent stage on their own bus path. Al=
l
> > four entries are required, since the port cannot move data without any
> > of them.
> >
> > The RX delay range is the one the G12A has, since it is the same
> > register field.
> >
> > The compatible pairs the T7 name with the 5.10a Synopsys core the MAC
> > reports, and with the generic fallback.
> >
> > Assisted-by: LLM
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
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
>
> Have you checked that this actually works as a limiter to only 4 clocks?
I have now, and it does limit to four. Adding
a fifth clock to the board gets rejected:

  ethernet@fdc00000 (amlogic,t7-dwmac): clock-names:
    ['stmmaceth', 'clkin0', 'clkin1', 'pipeline', 'bogus'] is too long


> There's an additionalItems: true in the snps,dwmac.yaml that I don't
> know if will permit random additional items here.
There are two checks on clocks and both have to pass: snps,dwmac.yaml
allows 1 to 10 items, the t7 branch allows exactly 4. The
additionalItems: true only relaxes the first one, so the second still
rejects a fifth clock. The "exactly 4" is not something I wrote -
dt-schema's _fixup_items_size() sets minItems and maxItems from the
length of the items list.

>
> Cheers,
> Conor.
>
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
