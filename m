Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F13E0C59
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464661; cv=pass; b=hH/qH+4LLKruzB2A9BAxxYDJrTc4sx5COpyaTkbIy3odaAB+l6oZCVM4IS4CFWBDHjr+NTwBZeKXAxXDjMAga665zjlB2aNzc62ykiDKv52r8jxd8x3JLQcNPwAvqYZdNjvAYioygJ2PMHjThAIRZ6KYMM/G0aLpOhUTyJ8e/YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464661; c=relaxed/simple;
	bh=5uwxxeZPYN4Ij6akn4bwbxGcDtLNY+69BXfmEyQCBcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMsPkg8QBHFuaY94gExze4b/Q/fUCHh3p/B59cfzNifi1bbvXdcwLq17mkYJseIvmf9czlHx2MumrpDFiGv0AZHrw3Uv8wFDxPjPxli1wopCsZ71DMdM7Sw4UcUQBXcvpEKMttXlCd+inVN3CmIejn4dxMV2rp5y1kf0YdDtnoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfTP3BHC; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfTP3BHC"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a5f5d37778so18976a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 12:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788464647; cv=none;
        d=google.com; s=arc-20260327;
        b=riShsBR654tSnRpxHZSweS24fKRPHECxttSlY5PVzbHGcaCgk/b5RnOgPhN0aZrV30
         Ya9h75f2A4HUbNDio1aG3bNqgQevVyju4Ou5RSxOgqEssvIF9gGtgUEzEATCe1bLkxnE
         aVuHYoZ9yMZ4pasZdT+YqHQI8QeTyjRJrqeidEV2/COyqSK3chVnfZF8NxgQcughWA4g
         y1V3T6fncbx9LdQvlFlQ1trd4pvshB06EzwS4KpprzGeaf083+qQkWoDoXo4fSjoCx3q
         fep57rYC4CVZtRSkiM9WYNCz5JJQmWq7KwFXdTLS2oXUsJc9kgmoHY99OruAkOEy/3AF
         DQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7nTSGhWAmSp7STouxjDPpEdLgNOmqXAwprS+AGG4sBg=;
        fh=7cRa1ewAOMIrKSIiV0jp2kNCO4ef4m60ChpskQ40IPI=;
        b=Qf/+1Peiqj7vrmxgvMKr0b/Db3BiGdgZ+5TmwmESdFLATzZ3DA5XNKhsIjoSwsXtHO
         cfoKmVbM/PHO6LsB7LZgQkE7spk2+B94csKcNOJCUyPfBAOwboCx2xSgwdh00ODzlG71
         Dk4AYQzZ2Db6iMuDD+55oBtxC/keQyOdO49jOBLCzeX8D/5QRjKch3zgv067/IWNlyal
         ZgwtiyLnca2R9lbwRqBggMbg1W8ci3o1OuLpH86IagIIjBOdvhPjVpa6V0qN2ccyZsiN
         N4un4rDjyMGvhvDb6z49LgsxSSg6zil5UDased68uqh7DRSuUT92Dv5VOS2oXHiwTHur
         i9cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788464647; x=1789069447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7nTSGhWAmSp7STouxjDPpEdLgNOmqXAwprS+AGG4sBg=;
        b=IfTP3BHChN+WgwQWFEhAvkOCgDBJV5XK0HWHz1E3oaOmWI5qtksAUxUuH807T0ivCW
         yyLlpKb7GLWb/SJy4iiM4/BtIkgPPHLPB3sjP35X7RZsf6Cnv1IgV7TbXDQb6YQIoTAc
         TYMx1TiI8II4jd5M1DuaIV1QagmeNgDmci1T3qbE40yyfZJ5LekJ7rsUbm0LtO7wYkZH
         rABDQ5tRhk96rMoQC8H1VyoqjGERJW3E/2S+leBO0RiYLVREN5NHKSogpKfZQxakCcIk
         IUK4OPzGB0WSZJl4S97smVosq7IayejGyf2V4npgo5p9JTMNHZnAGOv0JIK6qOU91qvq
         II0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464647; x=1789069447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nTSGhWAmSp7STouxjDPpEdLgNOmqXAwprS+AGG4sBg=;
        b=gosocQibwvr+jK3/bG0V8QiPnVu0mxBN5hnICV4b6kUgKuERy8MN+XtfXbrGFNJE6/
         RZda6m4NZBjqcsabZ8PgT17HqNMAvxKoaj3vkUNiWsMi7/z96d9UvesO2ibilWSeX60w
         mKFtw3RGP7BHgiKBLf2r2rEcGL1298NuEGz+XIJmMogfOt1aEHm9Gb8b0UxxFvi3J2dq
         hAfIa4VaGCGxl0yHF5FK9GN/+/rP8AdQb/STmirlEEE4MjNNW0gwn34tHC+meNOnOF9f
         Y00AWSBbMgwbZtvnrtqGZ0Y9EgBGCFM928NiSxwDOOY90Ue/9W0YAz4RgQUsV+sizWdZ
         Yhmw==
X-Forwarded-Encrypted: i=1; AKwUvByYjpyx5TnfHdPVadFSx6mY9RWBRKy22NiqNes8uUJNNR5/WTI+DFakd/RtU5KBJa0q7eMdDVA=@vger.kernel.org
X-Gm-Message-State: AFuF++l4+oxWNpI69qvdrgGNnn8ss7aIeucryfT740mdAEtX8rrMNdtx
	ac5Yw9emCVn8U5YHIyGYjSsNRgc3TXODh92VShDuX1D3A6nzWW/DZinAfVPF2b2G5IGHrWduDtZ
	EXq7SirdZqRc1/IsUBAxGXMeTexf5bYs=
X-Gm-Gg: AYBFou0YuobIFhXTbTYWgrT5F42uFhWjTQfxebif6H2sAxtBNkAMK5jmgj19gobpESc
	Jy9STCl38jfZfNpshl98pKED/f86kM9EitwUWfR+/LI+jun5CBkVlQPWrXemOXNVZ4z03OgKc1z
	J9Wz14r5ZDixNwGIH/f4e3NIWb5BukBD1mV+GyuU6gPz8W/4rmMJf0wksXP5s1Fj5Z3XA1UqF34
	88YU21jnDn3yt4BGh9Lyx/nkH/3IjZD8QQleNdFX2JnXCNTYs4NH61HwrAA+OFE6Hz0Yk1shp/H
	fpxC+fgrRkdTCTpCYdMUm8kD4XM31yyFWxZCiH6cjJiPvGEIlGf4FBKZ9LyzPK6bbzdamGi5TNI
	rFA==
X-Received: by 2002:a05:6402:4585:b0:6a6:32f6:ee8e with SMTP id
 4fb4d7f45d1cf-6a7e8e9c97bmr78640a12.3.1788464647094; Thu, 03 Sep 2026
 12:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-ti-davinci-emac-v3-1-db41e32f3f6d@gmail.com> <178844863252.3394541.10006643092711574384@kernel.org>
In-Reply-To: <178844863252.3394541.10006643092711574384@kernel.org>
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Fri, 4 Sep 2026 01:13:54 +0530
X-Gm-Features: AcwNN1VED6faEgcpjoUkRbm5zQtgZu9zqcqs2cQMMmJnQoBHnsr_ZAdYEEo-k3k
Message-ID: <CAOWyW_6qRhoUts2MtvDL3JiBx74UOBs73Fye=1FKrky-brmS8Q@mail.gmail.com>
Subject: Re: [v3] dt-bindings: net: ti,davinci-emac: Convert to DT schema
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tony@atomide.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
	simona.toaca@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 3, 2026 at 8:47=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> - [Medium] The new schema lets `ti,dm816-emac` nodes carry either 1 or 2
>   `reg` entries with no further constraint, while the driver derives=E2=
=80=A6
> - [Low] The schema makes `clocks` required (justified in the commit
>   message by 'driver probe fails without it') but leaves `power-domains`=
=E2=80=A6
>
> --
>
> dt-bindings: net: ti,davinci-emac: Convert to DT schema
>
> This converts the DaVinci EMAC text binding to YAML, documents clocks,
> clock-names, syscon, power-domains and ti,hwmods, and adds per-compatible
> conditionals restricting reg, syscon and clock-names.  clocks becomes a
> required property and ti,hwmods is marked deprecated.
>
> > diff --git a/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml=
 b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
> > new file mode 100644
> > index 0000000000000..f0c539d1bac79
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
> > @@ -0,0 +1,127 @@
>
> [ ... ]
>
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,davinci-dm6467-emac
> > +      - ti,am3517-emac
> > +      - ti,dm816-emac
> > +
> > +  reg:
> > +    minItems: 1
> > +    items:
> > +      - description: EMAC core
> > +      - description: EMAC control module
>
> [Severity: Medium]
>
> For ti,dm816-emac this leaves reg free to be either 1 or 2 entries, but t=
he
> driver derives hardware semantics from the entry count.  In
> davinci_emac_probe() the presence of the second region is the only signal
> used, both for the control module base:
>
>         res_ctrl =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>         if (res_ctrl) {
>                 priv->ctrl_base =3D
>                         devm_ioremap_resource(&pdev->dev, res_ctrl);
>                 ...
>         } else {
>                 priv->ctrl_base =3D priv->remap_addr + pdata->ctrl_mod_re=
g_offset;
>         }
>
> and for the SCM eFuse MAC-ID instance:
>
>         rc =3D davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1, priv->mac=
_addr);

This driver logic relies on the reg entry count to determine the port
instance. This is a software implementation detail and not hardware
detail. I believe it is bad idea to rely on the number of reg entries to
get instance, It's better to use of_alias_get_id() to get instance of port.

From a hardware perspective, eth0 requires 2 reg entries because MDIO
node occupies the 0x800 to 0x8FF.

>
> which flows into ti_cm_get_macid()/cpsw_am33xx_cm_get_macid() and selects=
 the
> register pair at offset + slave * 8.
>
> Given that, can a schema-valid DM816x node land on the wrong hardware?  T=
wo
> cases seem possible:
>
> A single-reg EMAC0 node with a 0x800 core window (as in dm816x.dtsi, wher=
e
> MDIO at 0x4a100800 is a separate node) plus ti,davinci-ctrl-mod-reg-offse=
t =3D
> <0x900> would make ctrl_base point 0x900 past the end of the ioremap.
>
To resolve this I can either:

Use nodename to hardcode exact address for eth0 and eth1 something like
  if:
      properties:
        $nodename:
          pattern: "^ethernet@4a100000$"
  then:
      properties:
        reg:
          minItems: 2
or
Enforce 2 reg for both eth0 and eth1, For eth1, even though there is no
MDIO, the base+0x800 to 0x8FF is simply unused, so describing it as
split regions is still accurate. But this will require a driver fix
for getting port
instance.

> An EMAC1 node written with two reg entries would be passed instance 0 and=
 get
> EMAC0's factory MAC address, putting two interfaces on the wire with the =
same
> address.
>
> In-tree, arch/arm/boot/dts/ti/omap/dm816x.dtsi happens to pair these
> correctly (eth0 has two reg entries, eth1 has one), but nothing here requ=
ires
> that pairing.  Would it make sense to constrain this per instance, or at
> least document that the presence of the second reg entry also selects the
> MAC-ID instance?  The commit message line:
>
>     - Allow 1-2 reg entries for DM816.
>
> reads as though the choice is free.
>
> [ ... ]
>
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - ti,davinci-ctrl-reg-offset
> > +  - ti,davinci-ctrl-mod-reg-offset
> > +  - ti,davinci-ctrl-ram-offset
> > +  - ti,davinci-ctrl-ram-size
> > +  - clocks
>
> [Severity: Low]
>
> clocks is required here, but power-domains stays optional.  For
> ti,davinci-dm6467-emac, is clocks alone enough to describe an enabled mod=
ule?
> davinci_emac_probe() only queries the rate and immediately drops the cloc=
k:
>
>         emac_clk =3D devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(emac_clk)) { ... }
>         emac_bus_frequency =3D clk_get_rate(emac_clk);
>         devm_clk_put(&pdev->dev, emac_clk);
>
> There is no clk_prepare_enable() in probe, so the LPSC gate and local res=
et
> appear to be handled by the genpd reached through power-domains.  In
> drivers/clk/davinci/psc.c each LPSC registers a domain with
> GENPD_FLAG_PM_CLK and davinci_psc_genpd_attach_dev() adds the LPSC clock =
to
> the device's pm_clk list:
>
>         lpsc->pm_domain.attach_dev =3D davinci_psc_genpd_attach_dev;
>         lpsc->pm_domain.flags =3D GENPD_FLAG_PM_CLK;
>         pm_genpd_init(&lpsc->pm_domain, NULL, is_on);
>
> That matches da850.dtsi, the only in-tree user of this compatible, which
> carries both clocks =3D <&psc1 5> and power-domains =3D <&psc1 5>, and it=
 matches
> the example added below.
>
> > +allOf:
> > +  - $ref: ethernet-controller.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ti,davinci-dm6467-emac
> > +    then:
> > +      properties:
> > +        syscon: false
> > +        clock-names: false
> > +        reg:
> > +          maxItems: 1
>
> Since this conditional already narrows reg, syscon and clock-names for
> ti,davinci-dm6467-emac, would adding power-domains to a required list her=
e be
> appropriate?  Without it, a conforming node describes a module that is ne=
ver
> ungated, while probe continues and later register access in emac_dev_open=
()
> and the cpdma setup targets a gated, reset-asserted module.

Yes, I will fix this in the next version.

Best regards,
Bhargav
