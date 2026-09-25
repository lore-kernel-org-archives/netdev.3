Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3F383C6E;
	Fri, 25 Sep 2026 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301831; cv=none; b=n4XzvTU6wkev/s+e5GteeFXurTffToYcf72Uv3Sm9TWKyg9AB+t+mGzS8qWGvddB27OkT5qnhE46Sey44MD0geeQMw8H/5BgADYfsLMbm+Lqq1KfyRqXaa7qjqnw0FXaJ4jx5owOSJywPr5baxCJ5NQsZgJwwKr5w/eoieTSIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301831; c=relaxed/simple;
	bh=QhUB0YGju87pKNw/PXKi3i0Z9cIClDU+EkYl1/T8Cx0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPKBy7gpkKJSFvX5JRfh3NaYt13/cQ1tspViegRl+p5oPoBqxXFPkISgBRHQ4zB0VDZIU2KVBrONC1Iy4UcKQ85v+BbMi4Z36zofLPEzrMYoUNci/7qXzGYznnrEkGj1jOUkkKyw5xRHlYrjrojrmEGrGiM7QA2fmIWQpZ4Sm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgVAq8bP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgVAq8bP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8564D1F000FF;
	Fri, 25 Sep 2026 02:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301829;
	bh=vHTRX6NVnIzYhl1q0206js2CPkE+VZBEqeQmH9KkdfM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mgVAq8bPAQzYHrRjTciQZUSfWuf81rC3O6ZV9dfxyi/1aqkrqiZzI6GadkzgRL1y3
	 EfWbrkfsBKXOsq/2nZILOap+uN7fn76DwpkmTEuqSCmUJkVacefWLSdpt/Jan7Fcj9
	 QbFw3jA3WubUH5Am32CSY+w3DzEomay3CxSPCB9gPxifSTDWpjwEo2k9gGZ61bBTLb
	 s8ABaQVENxleT9nkB760gh2gDT7d7C+PuKbXGJPHwqEK/HwQdtgJPJCUxuU74Gj0+D
	 62bc75KHESnNyO7I79Ub1iBruwCERlWDJuqU1RnhZAH2fge4mMhSsfHdGJUidZtPrF
	 3OW84fTmqzrEg==
Subject: Re: [PATCH net-next v10 10/11] arm64: dts: rockchip:
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
 linux-renesas-soc@vger.kernel.org
Date: Fri, 25 Sep 2026 02:03:48 +0000
Message-ID: <179030182812.2160803.15624484068208460829@kernel.org>
In-Reply-To: <20260922200336.2201212-11-coiaprant@gmail.com>
References: <20260922200336.2201212-11-coiaprant@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message of "arm64: dts: rockchip: rk3568-photonicat:
  enable SGMII LAN port" describes the combphy2, xpcs/xpcs_mii0 and…

--

arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port

This commit enables the SGMII LAN port on the Ariaboard Photonicat. It
routes combphy2 to GMAC0, enables the xpcs node, configures gmac0 for
SGMII and adds the YT8521SC PHY on mdio0. It also adds LED nodes to both
the new SGMII PHY and the existing RGMII WAN PHY on mdio1.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> index 58c1052ba8ef3..fdaa4a2a4328b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts

[ ... ]

> @@ -260,9 +262,18 @@ &cpu3 {
>  	cpu-supply = <&vdd_cpu>;
>  };
>  
> -/* Motorcomm YT8521SC LAN port (require SGMII) */
> +/* Motorcomm YT8521SC LAN port */
>  &gmac0 {
> -	status = "disabled";
> +	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>;
> +	assigned-clock-parents = <&clk_gmac0_xpcs_mii>;
> +	managed = "in-band-status";
> +	pcs-handle = <&xpcs_mii0>;
> +	phy-handle = <&sgmii_phy>;
> +	phy-mode = "sgmii";
> +	phy-supply = <&vcc_3v3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim>;
> +	status = "okay";
>  };

[Severity: Low]
This isn't a bug, but the commit message describes the combphy2,
xpcs/xpcs_mii0 and mdio0 changes and not this &gmac0 rework. The gmac0
rework is the main functional change in the patch. Could the message
describe it too?

In this hunk, status = "disabled" becomes a full SGMII configuration
that:

  - reparents SCLK_GMAC0_RX_TX to the 125 MHz clk_gmac0_xpcs_mii clock
    through assigned-clock-parents
  - sets managed = "in-band-status". The commit "net: stmmac: dwmac-rk:
    add SGMII support for RK3568" says boards must use it because
    out-of-band SGMII breaks RX at 10/100
  - adds pcs-handle = <&xpcs_mii0>, phy-handle, phy-supply and the
    gmac0_miim pinctrl

The commit message also says:

  "Also add LED configuration for the existing RGMII PHY on mdio1 for
  consistency."

Those LED_FUNCTION_WAN nodes go on rgmii_phy, which drives the separate
WAN port that already works. Could that go in its own patch? As it
stands, reverting or bisecting the SGMII LAN enablement also drops the
WAN LED change.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922200336.2201212-1-coiaprant%40gmail.com
