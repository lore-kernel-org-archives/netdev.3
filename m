Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3064E0B89;
	Thu, 17 Sep 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670310; cv=none; b=czBDE9QdGfjLi4Mr4gce3jC6KnUqauflhaZ1F9RZ1qeKgUyoaKxRzcDuFJUPUsX7QeFJEnP2ceSa3O5831NHxvwZRcKld86lARIVG7nmsnXQYWdxFBRdUBss4cKtNYM+uUej049Ub8Wktqp1h4sypxUOM8W74pZEsSiNNV7jJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670310; c=relaxed/simple;
	bh=2mVDnaJIPeovkXrvGjDxfyKL0LGu+hQSbYN+BezWTWs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EsJRZGh+wxYC9sXOkMElemR/TvVpBrBJZuoVKgKJhPEI7htZ7uZoZk6wqdyvhFnEMZeLUpmWIkZHF6CmHczf5io+Va9kZefsgKJB/JuBxoPqahS1Q588c4hyIzvjSmylt/HLhMtFyC0TTeAbwp2XAElKaSrE/S+bH4aoRcf++JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPWK5qc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPWK5qc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8754B1F00893;
	Thu, 17 Sep 2026 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670306;
	bh=oKmKsOz0rmPsjSmLJwkcoCz4Udwn6GVMn7bxI6KVIZ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FPWK5qc8ZUfZACfSRpN3e+20j29nrCMV1H2aePYIWBQfBiu/GnECo1fWXjEfE39II
	 dG+JcgvRShPb51sTZDQy3KYaiaMRsO/fQEfMVqr9kA6il98ubGEFopVeIaISBJ7n+7
	 cn3iDXBafqYnoBBizRwr7/zjE0jydr49PqbQDFypuqkeKzJ6r0LINKBnQp708lFr8D
	 u/l12cMd04ujVlhWN9vFLcNwVmGNCeL/frrLY/XrtdXx2SzcWHOU7rjANGCbOdFML4
	 ozXhWTMAXAV7jZK4Ywkyez+kmCZFVpJW5GV6ElzDIrqciwKzUyaeU5GAHjx2uJOUd3
	 nnVCiQwhSW4yA==
Subject: Re: [PATCH net-next v6 10/11] arm64: dts: rockchip:
 rk3568-photonicat: enable SGMII LAN port
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
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
Date: Thu, 17 Sep 2026 18:38:24 +0000
Message-ID: <178967030410.22033.9337863064862932142@kernel.org>
In-Reply-To: <20260915123802.1561724-11-coiaprant@gmail.com>
References: <20260915123802.1561724-11-coiaprant@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] DT binding and SoC dtsi disagree:
  Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml…

--

arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port

This enables the SGMII LAN port on the Ariaboard Photonicat by turning on
gmac0, the xpcs node and its port 0 sub-node, adding the YT8521SC PHY on
mdio0, and adding PHY LED nodes for both the new and existing PHYs.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> index 58c1052ba8ef3..fdaa4a2a4328b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts

[ ... ]

> @@ -586,3 +646,13 @@ &xin32k {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&clk32k_out1>;
>  };
> +
> +&xpcs {
> +	phys = <&combphy2 PHY_TYPE_SGMII>;
> +	phy-names = "serdes";
> +	status = "okay";
> +};

[Severity: Medium]

Should phys/phy-names live in the board file rather than in rk3568.dtsi?

Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml lists
both of them as mandatory:

    required:
      - compatible
      - reg
      - "#address-cells"
      - "#size-cells"
      - clocks
      - clock-names
      - phys
      - phy-names
      - power-domains

    additionalProperties: false

But the SoC node in arch/arm64/boot/dts/rockchip/rk3568.dtsi supplies
neither:

    xpcs: ethernet-pcs@fda00000 {
            compatible = "rockchip,rk3568-xpcs";
            #address-cells = <1>;
            #size-cells = <0>;
            reg = <0x0 0xfda00000 0x0 0x200000>;
            clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
            clock-names = "csr", "eee";
            power-domains = <&power RK3568_PD_PIPE>;
            status = "disabled";
            ...
    };

Since dtschema selects on compatible regardless of status = "disabled",
doesn't every other rk3568 board DTB now fail make CHECK_DTBS=1 with
"'phys' is a required property" and "'phy-names' is a required property",
with rk3568-photonicat being the only board that happens to satisfy the
binding?

The SerDes here also looks SoC-internal rather than board-specific: it is
combphy2 in SGMII mode, the glue driver asks for devm_phy_get(dev,
"serdes"), and the binding's own example already uses
phys = <&combphy2 PHY_TYPE_SGMII>.

Would it be better to put phys/phy-names in rk3568.dtsi, so board files
only flip status and set rockchip,sgmii-mac-sel, or alternatively to drop
the two properties from the binding's required: list?

I checked the following commits in the series and did not find a patch that
adds these properties to rk3568.dtsi or relaxes the binding, and the
baseline has no xpcs node at all, so the disagreement appears to come from
this series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915123802.1561724-1-coiaprant%40gmail.com
