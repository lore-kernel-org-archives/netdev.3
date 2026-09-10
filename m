Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC07C59650D;
	Thu, 10 Sep 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070888; cv=none; b=Uh9/27AqbekDZVT+ajpN8QSIAXTiflyzgd9GMTqXw2kAAtDQ4i4iI36OgP0kWOrEhsytRFe4EirZh+Uj00LCDThLRuxlRoF+YibfwlDiizDeYr5szg5TsjfuwWHqtvSC1HkUhYFYA74JfMzN2WO7ynQ+a0Rrwg3ihiwRtBDi9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070888; c=relaxed/simple;
	bh=9VN3bwZka3S+tTg96FmOIUV3qYPE1M05k5Wl+t8sisQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZ5C+S8g97V+fOsPVt/2qAvBxXQXi1SzF6eOd2two3rhzuYkDXJDyy4fn9/ttRUtDzjaoE6VZNmWaRP6TcHjDp1/gorodLfk0NHQk/SKOqqlw7Jtfy0zabqASe00ZitK+7wn2x2BDCbNga/2DKWm5hm3K+/yhPXQ8KHEkNz5Am0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYykwd/d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYykwd/d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF537C2BD05;
	Thu, 10 Sep 2026 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789070886;
	bh=9VN3bwZka3S+tTg96FmOIUV3qYPE1M05k5Wl+t8sisQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fYykwd/dQWxc1GcfAUYzHz9vvAfD6xQW5Or+3/9qU8kwWRQe3SeWqZpWKXgJvOMdI
	 DbIba7rbihNAjtl4IPRiSnliZ2nR3T9gnGQhBeYwSNgkRqHnjHkswVpEkkMc1wntdC
	 gbHdGfwwoa/H+3vD5PCFCS7MZ3YiC2UFhEwpvgENZq3VtZZA95NFPKVnFgYtewbFQT
	 u0yVDLFZkZ+7qR0p068MCjIKhO0VQ/Xl9v0Td1fo5G3bbOO0lRfV5oCjmI/T+axvLp
	 9A68gokm4SdW1gI7LcMVj8UjxnJ+kMPN/l0ESZB+QBW+f3SZxz1luV2yJH9G4gIMqd
	 aTi2oGqEBhOBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3BCC88E42;
	Thu, 10 Sep 2026 20:08:06 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Thu, 10 Sep 2026 22:07:57 +0200
Subject: [PATCH v5 7/7] arm64: dts: rockchip: describe PCIe RTL8125
 Ethernet on ROCK 5 ITX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-7-c1b9e5f10cd6@pardini.net>
References: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
In-Reply-To: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Ricardo Pardini <ricardo@pardini.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=6JENscbgGnnWW/4PaIbc3X/OTv8wHFKHVCvXFVsCaGI=;
 b=owGbwMvMwMFoHWf/eN7xty8ZT6slMWQt5lM5Z/zure0WD5bAba2XA91+FL/82syq2fdTRU/S1
 OhlhOifTkZ/FgZGDgZLMUWWNRLKPN/Wvzp1x6NjMswgViaQKdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6BjzMDFKQBTnXaWg6GVjcWSZZrtF86duUf1exXWOm3Ze1yT98wrA/WzkXNr87relftXt9U
 tDJIucr7PmfsnZvlKW8elQk1/rrMXXjmTZnbuhoDaZtNzdx0UOh0shY2ML0yZGxFzpCHxXY1Ua3
 ifw5cmo87VT1vffprCfOZpc2eO4Iy8b9HznTOKN7IyhLZMauwwO7Qla5qW/8my3weNpNcZPD2z3
 2GeoGW5X7juh6YehrULPG8ZTDa1kBLuOTCtJXxphtXGK9sknP9eUtTz/6FxuHPqTQEudfHDiU8r
 Ln851t1dev2nxaJveZ86fy/ii47Ksunoepd23kwi+YW9b3C02s+m1QeyJprMPMD6cMfR1jM+0wy
 EWSI1AQ==
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Reply-To: ricardo@pardini.net

From: Ricardo Pardini <ricardo@pardini.net>

The Radxa ROCK 5 ITX carries two on-board Realtek RTL8125 NICs behind
pcie2x1l1 and pcie2x1l2.

Describe the fixed function nodes and attach ethernet0/ethernet1
aliases, so that U-Boot's fdt_fixup_ethernet() can inject mac-address
properties from its ethaddr/eth1addr env, for stable MACs across
boots that both U-Boot and the kernel agree on.

Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
index 6f25e088f3189..f1d6647c57bf9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
@@ -20,6 +20,8 @@ / {
 	compatible = "radxa,rock-5-itx", "rockchip,rk3588";
 
 	aliases {
+		ethernet0 = &rtl_eth0;
+		ethernet1 = &rtl_eth1;
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
 		mmc2 = &sdio;
@@ -631,6 +633,20 @@ &pcie2x1l1 {
 	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_lan>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x300000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x30 0x3f>;
+
+		rtl_eth0: ethernet@0,0 {
+			compatible = "pci10ec,8125";
+			reg = <0x310000 0 0 0 0>;
+		};
+	};
 };
 
 /* RTL8125B_2 */
@@ -640,6 +656,20 @@ &pcie2x1l2 {
 	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_lan_phy2>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x400000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x40 0x4f>;
+
+		rtl_eth1: ethernet@0,0 {
+			compatible = "pci10ec,8125";
+			reg = <0x410000 0 0 0 0>;
+		};
+	};
 };
 
 &pcie30phy {

-- 
2.55.0


