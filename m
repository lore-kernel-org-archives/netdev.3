Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2444E0B8B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676156; cv=pass; b=rEgtnjnYAtigrXReYezVkh/1Bxa/5lCEq9c4/FlVmfDPnGWyPzJaJ52APnx4d7IGA5Ig3f8yTVj3GdZpNqjevtBJiOd1lbaOUCUTCdfkRyjj3+Jfjl9IydlM9cqbNYZWMT92C2C6kFNt2Do4vlNCPGW012Aq+axqNCIxltJIUhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676156; c=relaxed/simple;
	bh=2zAdLw8hI+hvbCzK1kKxzmewyLB7LCVzFQ6WaVowWnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVZvAVqhil4dDVTdnvZoQsTYeHd5Vonzvd9BQi3dflGlw23EWPVIVjIRw8R11WtjbDNYbT7jXR7J/MKDF0josV+ZuJcFGP9DHYZz8UGHQwpX18KtzMVKmMjWfvoW/zQBRff2vBjAPek43SqSrVzVoQBuXg6SNDGCMSeRi9Ae3Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h01CHJb1; arc=pass smtp.client-ip=74.125.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h01CHJb1"
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6aa13e192bcso3213a12.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789676150; cv=none;
        d=google.com; s=arc-20260327;
        b=c9MOIbbl44p9LhOUAv72OFjC/Vq3tCGVS1zjO1SbLfPEu3UYcBAq/2mtHkkaPgmD4I
         RDj3jPyGjRqWWUYuf3gX63W18CiSfj+ktAUufPD/oz/xHhWZ7mT15OmxEuMPQJYJCU64
         7mX9nEYSpilRw1UcvG1P2FeYgmUWm3re6dzbAzm7Z10aU8+vI1hxHnmNH5IhgjEfPivJ
         1bvUI5/DueTNBkKGefG7ocdCmYlLZoqQXORqRPla3RWzBT9lx/awlIC7xAJWt8a5WGPV
         yjd0R4Rlhhm2AZFLpzMMLaQ+RKkkFB0z8DuHWJ3Cuue7DKAA0fzxCtN5qzhsKqWRtBPP
         iLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zCPgAIlGTr5u1ukHAetOMBXtOrNSCf5qagcxmn2ADog=;
        fh=9ydzqPFiU8Rsa4yK70Mn1xtryqXsz7ZAVEQlUWTEDdQ=;
        b=LtqVcDUChg3EWyWELRlFsMOj/wsmoSrq2Y4yq7dtzpGFou0y0NpHNI4ZKXpWkuBoPk
         wTpsawoTbBkChfb69M44ZZgZjsHO0toPss+HtV+WMieK8TntZlHtlfiZqJMmgVrnOFXF
         VANYDt3ybqfSvdz0xHxKLBgZq51tMCPXf8JF0a8k9HAWajoht5iV12u8VeaonWAlm1dQ
         RuSq4Mjl+uhKJWBKie6m3mB3MR0bBZHnkH2kRv/pdzdG4rW4Mf8ukS0NEvqzCFne9rHZ
         AV00kZd2+kffhIPvrdKcFTpUCGh9QJNKzUgPxm0G5R0ZlphxEJ3xaHWua5MZYHPJiSGw
         QhSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789676150; x=1790280950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zCPgAIlGTr5u1ukHAetOMBXtOrNSCf5qagcxmn2ADog=;
        b=h01CHJb14DpQ7CXHYZVR9EP4hDn9yBLLagtAWEcMbY3oc4/cexpRW7vkT8TTFKeUft
         9ryoPI083/IWMHBc8YycRJMP0oVHad9ypMpp/IyLTR6DXoQ7cmYDzyKvsIu2g0ytunvH
         cuoydnQO6GDPpRXGX4rdJIvYg6gB4t5qQ9OLJuNfDUocSttQia77KSebQKrXMyiBIe4+
         Ian+N32b9cpJn4mI8snykOFcyz/BQc5DQ3Ej/XyEyi76gP7IleSgaULXjFyr9cHPv3yq
         FhTUSxtLfOZ5EpMceS+s3gECOgzzbOjkz8pgeR2adqV58Ac90x+pUANLmGdviyMqT84l
         /VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789676150; x=1790280950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCPgAIlGTr5u1ukHAetOMBXtOrNSCf5qagcxmn2ADog=;
        b=uljuWdsyaewA8xvnwN5MfMfhZxXBrFurFLiRdgw3lbeK7Z7KIYe8j+AUHq+spxZVhT
         XBNk7ailj2i84kchmq7MOilbrbSoSlXxiGg86XPW2KbhEoB7sDsRNQLWG1094VIp/7jU
         uuiOyNHQXB7X0CesG96R9ES5bg3Us9u7hvNz090/2+xDefmdXjQOIOVNSH5b2pG8Ru2+
         gvkJwIkvxBILnbetVkCKUphenZDAbTBoX240EYSeNenpozqTc+a5MxAlsbuNkzfLG4X+
         zqH/8LSP/8FbVmF+jvrGJkqfe/3OgTJny5slbhIowwlq5wUDCysGPzSAAQBlTfR1J5YW
         Cgvw==
X-Forwarded-Encrypted: i=1; AKwUvBzKmETKSZiKhk6otoLiWyLjHjI6PCMq7MPb1zz9kPbhDePv71doH8nO34+fVSj+r8a8ba26qp8=@vger.kernel.org
X-Gm-Message-State: AFuF++mE4VN7+sR0zLXu52Vt6YFFe0WwmvuzYSxITlI8gU0c1tDMERX6
	hyVtoPgTBSeU9EuTY65oQiVcBKoskn/kV7bYmXgsmCqyorLHPYYYpzcQAYOj0xnXtV5QwCQ6y11
	NLFdS33/XVYCjZ2CQXKqQELwC30Txz2U=
X-Gm-Gg: AYBFou3KXTIFZ4afmaiB3UuJUCUIpeYR2k36bn9KxVnjY3vs/U/478KM8JA1JHebGGn
	gA36LdkexE8DWFz2/WZyKMULKq2Cj/dkblpd5NhNTHCCHtCo1Cz5lJ6/xdWUF3KZ+NDXQ6Shuw6
	Qd/C/t78O0bDgghRn++Y02TZGJf956iJ52Ijo/ywZTsJCrAzAFhe7WuSGJOjPQb14u7JQ+HIoQl
	8+Z8cihAjYDv2ztUQ5ittb3BGx4jW88t8lEUCmvpb7fBCpwBax7AyFGU2kpyeJp/iQdHYw5n2BW
	qhcnfLNStqigfrLaPT2SGXruSIgug7NWyUjRMGQLuo+Mbu0bNo/rnwwPhg==
X-Received: by 2002:a17:907:7b8a:b0:c15:f598:60c0 with SMTP id
 a640c23a62f3a-c2a1581915cmr30112766b.4.1789676149887; Thu, 17 Sep 2026
 13:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915123802.1561724-6-coiaprant@gmail.com> <178967029365.22033.1005706659427633436@kernel.org>
In-Reply-To: <178967029365.22033.1005706659427633436@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Fri, 18 Sep 2026 04:15:39 +0800
X-Gm-Features: AcwNN1XbjpFu6nolR2hwxu8hiEjSxd-JBBWVCJNN3qMYqxrhw7mXPkQuGTH5DI8
Message-ID: <CALj3r0i4Dg2jq_4WPQ6Q4t6gbJd6CTV9Y0iP0GssAwy_AVY0xQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/11] arm64: dts: rockchip: rk3568: add XPCS
 and fixed-clock nodes
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org, 
	maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org, 
	linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz, 
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=94 02:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 2
>
> - [Medium] The new `xpcs: ethernet-pcs@fda00000` node in
>   arch/arm64/boot/dts/rockchip/rk3568.dtsi (line 113) omits `phys` and=E2=
=80=A6
> - [Medium] dts: incorrect fixed-clock modeling for XPCS generated clock
> - [Low] Concern (invalidated by later patches in the same series):
>   `compatible =3D "rockchip,rk3568-xpcs"` matches no driver, the `eee`=E2=
=80=A6
> - [Low] The commit message states it adds "two fixed-clock nodes
>   (xpcs_gmac0_clk and xpcs_gmac1_clk)".
>
> --
>
> arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
>
> This adds an ethernet-pcs node at 0xfda00000 for the RK3568 Synopsys
> DesignWare XPCS, along with four ethernet-pcs-mii child nodes, all disabl=
ed
> by default.  It also adds two fixed-clock nodes providing a 125 MHz
> reference for the GMACs when running through the XPCS.
>
> No Link: tags present in the commit header.
>
> Two remarks on the changelog first:
>
> > Also add two fixed-clock nodes (xpcs_gmac0_clk and xpcs_gmac1_clk)
> > providing the 125 MHz reference clock for the GMACs when operating
>
> [Severity: Low]
> Could the names here be updated to match the patch?  The nodes added are
> clock-xpcs-gmac0 and clock-xpcs-gmac1, labelled clk_gmac0_xpcs_mii and
> clk_gmac1_xpcs_mii, and there are no xpcs_gmac0_clk / xpcs_gmac1_clk
> identifiers anywhere in the diff.
>
> The exact strings matter for anyone cross-checking the reparenting, since
> clock-output-names has to match the CRU mux parent names in
> drivers/clk/rockchip/clk-rk3568.c:
>
>   PNAME(mux_gmac0_rx_tx_p) =3D { "clk_gmac0_rgmii_speed", "clk_gmac0_rmii=
_speed", "clk_gmac0_xpcs_mii" };
>   PNAME(mux_gmac1_rx_tx_p) =3D { "clk_gmac1_rgmii_speed", "clk_gmac1_rmii=
_speed", "clk_gmac1_xpcs_mii" };

Fixed in v7. The commit message now uses clock-xpcs-gmac0 and
clock-xpcs-gmac1, and mentions that clock-output-names matches the CRU
mux parent names in clk-rk3568.c.

> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot=
/dts/rockchip/rk3568.dtsi
> > index 3bc653f027f1f..227d03e336043 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > @@ -110,6 +110,51 @@ sata0: sata@fc000000 {
> >               status =3D "disabled";
> >       };
> >
> > +     xpcs: ethernet-pcs@fda00000 {
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
> Does this node validate against its own binding?  The schema added earlie=
r
> in this series, Documentation/devicetree/bindings/net/pcs/rockchip,rk3568=
-xpcs.yaml,
> lists phys and phy-names unconditionally:
>
>   required:
>     - compatible
>     - reg
>     - "#address-cells"
>     - "#size-cells"
>     - clocks
>     - clock-names
>     - phys
>     - phy-names
>     - power-domains
>
> The node here supplies neither.  At the tip of the series only
> rk3568-photonicat.dts fills them in via an override:
>
>   &xpcs {
>         phys =3D <&combphy2 PHY_TYPE_SGMII>;
>         phy-names =3D "serdes";
>         status =3D "okay";
>   };
>
> Since dt-validate matches by compatible regardless of status, wouldn't
> every other rk3568 board DTB now report "'phys' is a required property" a=
nd
> "'phy-names' is a required property" under make CHECK_DTBS=3Dy?
>
> Would it make sense either to drop phys/phy-names from the binding's
> required list (the SerDes phandle is board specific), or to give the dtsi=
 a
> default combphy phandle here, given combphy is an on-SoC block?

dtbs_check only validates required properties for enabled nodes, so the
disabled XPCS node in rk3568.dtsi does not trigger a validation warning.
The SerDes link is a board-level design choice (combphy1 on some boards,
combphy2 on others), so phys/phy-names cannot be provided by the SoC
dtsi. Boards that enable the XPCS must supply them at the board level,
as Photonicat does.

> > +
> > +             xpcs_mii0: ethernet-pcs-mii@0 {
> > +                     reg =3D <0>;
> > +                     status =3D "disabled";
> > +             };
>
> [Severity: Low]
> At this commit alone, compatible "rockchip,rk3568-xpcs" matches no driver=
,
> the eee clock, the PD_PIPE power domain and the four MII children have no
> consumer, the two fixed clocks have no user, and dwmac-rk provides no
> pcs_init()/select_pcs().
>
> Checking the rest of the series, all of those do land: pcs-xpcs-rk.c adds
>
>   static const struct of_device_id xpcs_rk_of_ids[] =3D {
>         { .compatible =3D "rockchip,rk3568-xpcs" },
>         { /* sentinel */ },
>   };
>
> xpcs_rk_init_clk() consumes both csr and eee, xpcs_rk_serdes_phy_poweron(=
)
> consumes the power domain, xpcs_rk_create() reads the child reg and calls
> xpcs_create_mdiodev(), dwmac-rk sets pcs_init/pcs_exit/select_pcs with
> rk_pcs_init() parsing pcs-handle, and rk3568-photonicat.dts uses both
> assigned-clock-parents =3D <&clk_gmac0_xpcs_mii> and pcs-handle =3D <&xpc=
s_mii0>.
>
> So this looks like the usual DT-before-driver split, and the disabled nod=
e
> is inert at this commit.  Is that ordering intentional, so that a bisect
> landing here stays functional?

This is the usual DT-before-driver ordering. The driver lands later in
the same series, and the node is disabled until a board enables it.

> > +
> > +     clk_gmac0_xpcs_mii: clock-xpcs-gmac0 {
> > +             compatible =3D "fixed-clock";
> > +             clock-frequency =3D <125000000>;
> > +             clock-output-names =3D "clk_gmac0_xpcs_mii";
> > +             #clock-cells =3D <0>;
> > +     };
>
> [Severity: Medium]
> These two are not board oscillators.  Per the changelog the 125 MHz
> is the MII reference produced by the XPCS/SerDes block itself, i.e. by
> the very node added above, which lives behind RK3568_PD_PIPE and only
> runs once that domain is up.  Describing it as a root-level fixed-clock
> tells the clock framework something different: of_fixed_clk_setup()
> registers clk_gmac0_xpcs_mii and clk_gmac1_xpcs_mii at of_clk_init()
> time, unconditionally (the nodes deliberately carry no status), and
> from then on they always look present, enabled and at rate, with no
> link to the XPCS provider or to its power domain.
>
> Where that bites is the reparenting path this patch exists to serve.
> A board that sets assigned-clock-parents =3D <&clk_gmac0_xpcs_mii> on
> the GMAC has it applied by of_clk_set_defaults(), which platform_probe()
> calls before the GMAC driver's probe() body runs.  So mux_gmac0_rx_tx_p
> in drivers/clk/rockchip/clk-rk3568.c gets parked on the XPCS leg before
> dwmac-rk, and therefore before pcs-xpcs-rk and
> xpcs_rk_serdes_phy_poweron(), has touched PD_PIPE.  Because there is no
> clock provider/consumer relationship to the xpcs node, there is also
> nothing for the driver to defer on: -EPROBE_DEFER is not reachable from
> of_clk_set_defaults(), and the mux is switched regardless of whether
> the XPCS is powered.  At best the GMAC is briefly clocked from a dead
> source; at worst a CRU mux switch to a stopped parent is not something
> I would assume is harmless.
>
> Was the intent to have the xpcs node (or the combphy) be the clock
> provider here, with #clock-cells and an entry in the binding, so the
> framework tracks the PD_PIPE lifecycle and consumers defer until the
> source exists?  If instead you have measured that the RK3568 CRU
> tolerates being parked on the XPCS leg with PD_PIPE gated, could you
> say so explicitly in the changelog and state what keeps the 125 MHz
> alive before pcs-xpcs-rk probes?  Modelling a generated on-SoC clock
> as fixed-clock is the kind of shortcut that tends to be noticed only
> when probe order changes.

The XPCS block is not a clock controller: it has no register interface
to configure or control the 125 MHz output, so there is no way to
implement a proper clock provider for it. fixed-clock is the correct
description of a fixed-rate on-SoC clock.

On the reparenting concern: the GMAC probe is serialized behind the
XPCS probe by the EPROBE_DEFER chain. rk_pcs_init() calls
xpcs_rk_create(), which returns -EPROBE_DEFER until the XPCS device has
probed and its MDIO bus is up. Until then, the GMAC probe never reaches
the point where the clock is used, so there is no window where the GMAC
runs from an unpowered source.
