Received: from mail-ej2-f6.google.com (mail-ej2-f6.google.com [74.125.228.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F403603DB
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789314447; cv=pass; b=YSvbJXu3bTfxjQZM9LZG1aPNDgfZ8J9andS2Lwsna4sU5UaR+hYYYDT1dhg0pvVIWcZ4pNnpKLYHqc+m+x1OIHSdxuyfHihA3iMCY/uNk6O0enDROhoiHV58Og3/Sa7QZQ29NjXcQPSNUXyVbaTsOOrt6WCJmMGDTpRSMpu3FUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789314447; c=relaxed/simple;
	bh=0J4H18xBnaTXwWA0eFc908GPhTPH1AfqEK/WH2weBo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+h6scLcVeJ3XUMdA+RW4THiwuX6dHww4Fv5466FZJyYDfGOTeKJTvfwDol11d5fNxuVOVrTCHa6UHAPMbTwEMcjuH2LoPKf8uqAwy8e5pJO3H23OyW23g0xHtfv4OJ/Vqhy+/iy3kWkMcsYMXtk6ewdSXf6OEhPVhxaBvpZN1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQao12pB; arc=pass smtp.client-ip=74.125.228.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQao12pB"
Received: by mail-ej2-f6.google.com with SMTP id a640c23a62f3a-c294716dbf3so186855866b.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 08:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789314444; cv=none;
        d=google.com; s=arc-20260327;
        b=jmcs3NCqYGijoJAwIxFo3TAetOeXfANdylFTg7aIwzgHr6KwblGXXjJ1NFSNBPGLkI
         /Rb7Sh9OT6u3QOPs9j5Mr6dDXXhXWxPAZAlGO5iXPXVG0lKRroV6jJtz0S4hFT2T2bzj
         +iWxB/AVlUz3c3NdteIp1YGdlou2QsDsjp8tQvRjvW/ohjUqbzcSbCVSD/0e/9EAywJR
         5eSpoXyelnS7yn654i+z+8dimV5smfLCu0D9X8MKQtlGjGr/sLd3GaCHPsLHo04z4Jq3
         /mAbWjfaH4PVFguGZTV6Q4wlkM/Kq/30C2PRTm9wfjDAHk+OfdkX/Ok7s3qzKx/z/8JX
         5tUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xd4RtXYSQe4fX2yQzgQaQhaAGqt8/5t2s9pKA9e2Z/M=;
        fh=sDsqnBe86+pd8Kd3vKDLug5K6ZGgXEGhs5vb1A3Ilbo=;
        b=bqY0qZsA8R7K23cZZUMAvCRPtOFfLJEZebr/Akh5Z90dw+mdOKoTwm/B3Ew9aqchQx
         c/oSXULumFZpf7oz3183M44IjOZkflzsJzYPRbffrCHIjQauUUGbYkqBUieFlmnsK5bU
         eU6huVvw5+1B3sgm488eFIz+kpxj2Ckf7N4Mz7CDQQ0ax2YB5j7oNWsiKqJU4WkmppyP
         96K1BhtdrqNzUgmecBGj4PaUvMVqhfVyE4ECoQS8tZ0pduhO0SjQN5WOLR/8G3NmouIr
         FhQ8X+viHYWk/0NgmlOBbJJv9ZIgxDGZi8rKwaEWQ0Y9lvPsWdJbdThM7KABmffSb3VH
         g3UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789314444; x=1789919244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xd4RtXYSQe4fX2yQzgQaQhaAGqt8/5t2s9pKA9e2Z/M=;
        b=GQao12pBWJj5yV02h/hWeLD1RM4nG2jHYtiTAKgXq3mc7t5SVXc8G1cNXJ9BfvNK1G
         lUH0HSbIak1kHn22z/2CBwBbQoZZExeYqs5ckO06cyLATQNssR3E08fiM6GQvtMfHm2H
         B+5sh9rueSIYKHdctZRkfyedkAiYp4PFP7v34v4Uri9+d9TS+7lExh/VT409KOUe8l9v
         yPAgr89qVQXQO+zOk3NrR+ezBcxjWQnP9KUFLi3R3DNarGQFFOwZPywJ5PWUegvU+zAr
         sPIY8Mt6J4ljACadBSYeEfLIPNX9FQGJy2KVDoauIMLdUQxBNXHO1mWR7FJgAa/p2IjK
         GvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789314444; x=1789919244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xd4RtXYSQe4fX2yQzgQaQhaAGqt8/5t2s9pKA9e2Z/M=;
        b=WZlFMMfIJI35OodYzo6vDmQR4c3PM/GOnaQ8qCAbqHB3+ByQtWPekaTVdztA+5tfZt
         yI6PKbxrZCTppfDqDd7n5DiQBrnUgRFiT2B50225AWMTvBhP99BOcSjQaA+Jy1bfzq68
         2mm8uLR1TwSKU1M7iiaKRE6giAaBFCE1c8YJ7SUal8oqZsKolK9fZRwE4yxgBZXoaEhc
         weP+WqMxmwWaSuUItNkhmsXWmTTZkjpaACmQgEBzLDhQ7pNT0LTQf6EXPFUZQ4aGJxm1
         /c4u73dz+uPf1VAP/yD42U78M9qmm0ycmxutaiW1GqDeB1+W29flB2gSB7Cd75xusIOV
         eDqw==
X-Forwarded-Encrypted: i=1; AKwUvByC2bYIOcWhwJanumAXTHTtN80bhKswvH9ON3P3d6JK9NSWfwVAtP+pSKuThA9+MIc91F+98fs=@vger.kernel.org
X-Gm-Message-State: AFuF++lDrt/DwETvSZJZBPLNDBypb2OcfIKbQQzTGF2JK7IGioc7eZBF
	eQemBhooih3L7aQ51Enk3hL6FNeR2peKq+R1PQ6emjIxEBm2LEyL4SAjmIHjYsppO9TmT3Cjt2/
	5DDUu92LqIP5UB+oJ8pGRsOhjwdUcFWM=
X-Gm-Gg: AYBFou3SMjXsogfbZxsPXFHmjMMazUaUGgEr36QR02ZdjHZRfGv8vj0uTEGsnw+ir1t
	gyNbyA220L7LZWELE4R3Vm53JA1+D3duSgL5RrM/Ndqst6MItMGOEVWO4u8tgsGRP5etZ4I6JTG
	KQfDOkppPgQ65Ujmaj8aR2ASHwE152AIUBFUHnPXL34e0C7qzP2Ydg4kf/2Z7DhchQx63QbQ6xP
	RqamqATywnGSBKQMI9CyWrDSV8M8DjzFGPTfzXUy8/9orKjAVA3MBNda3LYL2blnjdU2f94mnnr
	9PR91JKH8/CWlqnkldAWy4IKnSzoKeUoK43htxfBKCp0L8513/SmDZnVHsT5M+BCTpIe
X-Received: by 2002:a17:907:b049:20b0:c26:2f5e:29c7 with SMTP id
 a640c23a62f3a-c29856af6e3mr248244566b.7.1789314443704; Sun, 13 Sep 2026
 08:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907153713.2572547-7-coiaprant@gmail.com> <20260912201325.127009-1-kuba@kernel.org>
In-Reply-To: <20260912201325.127009-1-kuba@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Sun, 13 Sep 2026 23:47:12 +0800
X-Gm-Features: AcwNN1UukBh9R-kSgJT1DSG6HaucuFjaf0b71SnVjdkjmimZTMpjLzcMh3JEWAU
Message-ID: <CALj3r0h7ZQKPvMZbjpy0Cc=u0LvS+WAXUFNcsi+gWY9OxL+jfg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 05/10] arm64: dts: rockchip: rk3568: add XPCS
 and fixed-clock nodes
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	heiko@sntech.de, vkoul@kernel.org, maxime.chevallier@bootlin.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, romain.gantois@bootlin.com, 
	hkallweit1@gmail.com, neil.armstrong@linaro.org, linux@armlinux.org.uk, 
	shawn.lin@rock-chips.com, david@ixit.cz, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8813=E6=97=
=A5=E5=91=A8=E6=97=A5 04:13=E5=86=99=E9=81=93=EF=BC=9A
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
>
> This adds the RK3568 Synopsys DesignWare XPCS node (with four pcs-mii
> sub-nodes) plus two 125 MHz fixed-clock nodes used as GMAC reference
> clocks.  The XPCS node and its sub-nodes are disabled by default and are
> meant to be completed and enabled at the board level.
>
> A couple of questions about the new nodes below.
>
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot=
/dts/rockchip/rk3568.dtsi
> > index 3bc653f027f1f..989e164c0eb39 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > @@ -110,6 +110,51 @@ sata0: sata@fc000000 {
> >               status =3D "disabled";
> >       };
> >
> > +     xpcs: pcs@fda00000 {
> > +             compatible =3D "rockchip,rk3568-xpcs";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             reg =3D <0x0 0xfda00000 0x0 0x200000>;
> > +             clocks =3D <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
> > +             clock-names =3D "csr", "eee";
> > +             power-domains =3D <&power RK3568_PD_PIPE>;
> > +             status =3D "disabled";
>
> [Severity: Medium]
> Does this node validate against the binding added earlier in the same
> series?  Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
> lists phys and phy-names unconditionally:
>
> required:
>   - compatible
>   - reg
>   - "#address-cells"
>   - "#size-cells"
>   - clocks
>   - clock-names
>   - phys
>   - phy-names
>   - power-domains
>
> The node here supplies neither, and dt-validate does not skip nodes with
> status =3D "disabled", so dtbs_check should report "'phys' is a required
> property" and "'phy-names' is a required property" for every rk3568 dtb
> that includes this dtsi.
>
> At the tip of the series only rk3568-photonicat.dts fills them in:
>
> &xpcs {
>         status =3D "okay";
>         phys =3D <&combphy2 PHY_TYPE_SGMII>;
>         phy-names =3D "serdes";
> };
>
> so rk3568-evb, rk3568-rock-3a, rk3568-roc-pc, rk3568-radxa-cm3j,
> rk3568-wolfvision-pf5 and friends would still be missing them.
>
> If which combphy carries SGMII is genuinely a board-level choice, should
> phys/phy-names be moved out of the unconditional required: list in the
> binding instead, or should the dtsi provide a default?

As I replied in the earlier patch, dtbs_check and CHECK_DTBS only
validate required properties for enabled nodes, as confirmed by Rob
Herring. The xpcs node in rk3568.dtsi is status =3D "disabled", so
boards that include rk3568.dtsi without enabling XPCS will not trigger
any validation warnings. Only boards that enable it need to provide
phys and phy-names, and they do so at the board level.

The phys/phy-names properties cannot be moved into rk3568.dtsi anyway,
because the SerDes connection is board-specific: some boards use
combphy1 for SGMII, others use combphy2 (like Photonicat).

> > +     xpcs_gmac0_clk: xpcs-gmac0-clock {
> > +             compatible =3D "fixed-clock";
> > +             clock-frequency =3D <125000000>;
> > +             clock-output-names =3D "clk_gmac0_xpcs_mii";
> > +             #clock-cells =3D <0>;
> > +     };
> > +
> > +     xpcs_gmac1_clk: xpcs-gmac1-clock {
> > +             compatible =3D "fixed-clock";
> > +             clock-frequency =3D <125000000>;
> > +             clock-output-names =3D "clk_gmac1_xpcs_mii";
> > +             #clock-cells =3D <0>;
> > +     };
>
> [Severity: Low]
> These two node names take the deprecated branch of the fixed-clock
> $nodename schema.  Documentation/devicetree/bindings/clock/fixed-clock.ya=
ml
> has:
>
>   $nodename:
>     anyOf:
>       - description:
>           Preferred name is 'clock-<freq>' with <freq> being the output
>           frequency as defined in the 'clock-frequency' property.
>         pattern: "^clock-([0-9]+|[a-z0-9-]+)$"
>       - description: Any name allowed
>         deprecated: true
>
> xpcs-gmac0-clock and xpcs-gmac1-clock do not match the preferred
> pattern, so they land on the "Any name allowed" branch.  Newer Rockchip
> dtsi files use the preferred form already, for example rk3528.dtsi with
> xin24m: clock-xin24m and gmac0_clk: clock-gmac50m.
>
> Could these be named clock-xpcs-gmac0 and clock-xpcs-gmac1?  The labels
> xpcs_gmac0_clk / xpcs_gmac1_clk and all references would stay the same.

You're right, xpcs-gmac0-clock and xpcs-gmac1-clock do not match the
preferred clock-<freq> pattern in fixed-clock.yaml. I'll rename them to
clock-xpcs-gmac0 and clock-xpcs-gmac1. The labels xpcs_gmac0_clk and
xpcs_gmac1_clk will be match clock-output-names.

Best,
Coia
