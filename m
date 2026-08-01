Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E4271456;
	Sat,  1 Aug 2026 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601730; cv=none; b=gb8kRJ9oPNU7JJhoG56E51ueIwAt6O7vcC1JLveinx1sAjLgL+eFuQsVIQPUUJ/KS0R7FKqxMPExx3MCuyHwsCPYiMo56VzP3Ou87exQZbR5PkrX4LBEumlgOdFiNSSyOEiJMLYBE/he/SUU98TMDim47Is8l5TdKlYRMQNGsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601730; c=relaxed/simple;
	bh=IkVjWSBBiuOLsbPEFfnehNUTyZsRPGGxxctkNh5DZAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ttnz6mCExjYd5BE8upRGfqDNOQzAPMrMUGzVmGi+Oghk3teRC0oog+eDAAD2w3XrXNUhzKVqCxd8+RGjwgYC6oPj4q6DayyUHkOifRO2ePT/NFRhr0QFs+cdFAr1wT3S7CA5lOn4tmsBp93yDr7feHGD0hFpD6fI01mtFcCp7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GkspQDxI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GkspQDxI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=V06eygovF9pqY3vHyXKEpDH3PhLpNuC5Yjsi32fVPNY=; b=GkspQDxIH8XQuNGEPi3OaHsWVb
	MWqmQLy8kUKXVbYdQCn+ie/STVzV3V1s7aPOK5PK5RjrA5Wiyz8hXdbdIEgc6WcPFfAa21KBC40+n
	tiyw0Mn+j6oxgkEwMCeuve4BVeBfqLtB2EPeZ7wTyUU4mSmU1sLPii9wSHsjQ5BuPbhAuQtRTEjA5
	n8pZMtkAH/FxaT++U1I8L6londMFmfOBCEtEEp2HcNsc6P3S1esk+oUHFDqac/TtiB/qTngEgeWVx
	vxh6+0AgQRrVMtC7TkoRzlWwcomWycXXPeveXnhe6HMtGaMMJNgHU/uwXIYS2D1qggPlKOWmYdUmd
	HqiZeHug==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Coia Prant <coiaprant@gmail.com>,
 Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>,
 David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org
Subject:
 Re: [PATCH v2 05/10] arm64: dts: rockchip: rk3568: add XPCS and fixed-clock
 nodes
Date: Sat, 01 Aug 2026 18:28:11 +0200
Message-ID: <2847036.GUH7pLUipS@diego>
In-Reply-To: <20260801142244.679437-7-coiaprant@gmail.com>
References:
 <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-7-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Samstag, 1. August 2026, 16:22:29 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Coia Prant:
> The RK3568 SoC integrates a Synopsys DesignWare XPCS that provides
> the Physical Coding Sublayer for 1000BASE-X, SGMII, and QSGMII
> interfaces via its four MII ports.  Add the XPCS device node and
> its pcs-mii sub-nodes to the SoC device tree.
>=20
> The XPCS device is accessed via the APB3 bus at 0xfda00000 and
> requires the CSR clock (PCLK_XPCS) for register access and the EEE
> clock (CLK_XPCS_EEE) for Energy Efficient Ethernet operation.  The
> PD_PIPE power domain must be enabled before any register access.
>=20
> Also add two fixed-clock nodes (xpcs_gmac0_clk and xpcs_gmac1_clk)
> providing the 125 MHz reference clock for the GMACs when operating
> with XPCS.  These clocks are used as the assigned-clock-parents
> for the respective GMAC nodes in board-level device trees.
>=20
> The XPCS node and its pcs-mii sub-nodes are disabled by default and
> must be enabled at the board level when 1000BASE-X/SGMII/QSGMII is
> in use.  The fixed-clock nodes are always present and do not have a
> status property, as they are static clock sources.
>=20
> The XPCS node also requires a reference to the appropriate Naneng
> Combo PHY via the phys property at the board level.
>=20
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 45 ++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3568.dtsi
> index 3bc653f027f1f..989e164c0eb39 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -110,6 +110,51 @@ sata0: sata@fc000000 {
>  		status =3D "disabled";
>  	};
> =20
> +	xpcs: pcs@fda00000 {
> +		compatible =3D "rockchip,rk3568-xpcs";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		reg =3D <0x0 0xfda00000 0x0 0x200000>;
> +		clocks =3D <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
> +		clock-names =3D "csr", "eee";
> +		power-domains =3D <&power RK3568_PD_PIPE>;
> +		status =3D "disabled";
> +
> +		xpcs_mii0: pcs-mii@0 {
> +			reg =3D <0>;
> +			status =3D "disabled";
> +		};
> +
> +		xpcs_mii1: pcs-mii@1 {
> +			reg =3D <1>;
> +			status =3D "disabled";
> +		};
> +
> +		xpcs_mii2: pcs-mii@2 {
> +			reg =3D <2>;
> +			status =3D "disabled";
> +		};
> +
> +		xpcs_mii3: pcs-mii@3 {
> +			reg =3D <3>;
> +			status =3D "disabled";
> +		};
> +	};
> +
> +	xpcs_gmac0_clk: xpcs-gmac0-clock {
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <125000000>;
> +		clock-output-names =3D "clk_gmac0_xpcs_mii";
> +		#clock-cells =3D <0>;
> +	};
> +
> +	xpcs_gmac1_clk: xpcs-gmac1-clock {
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <125000000>;
> +		clock-output-names =3D "clk_gmac1_xpcs_mii";
> +		#clock-cells =3D <0>;
> +	};

I don't fully believe those clocks are "just there" inside the SoC.
Instead I _assume_ they are generated by some oscillator on the
individual boards?

Because as described there, they would be just magically be there.

So please aim for a real clock description (likely on a board-level)


Heiko



