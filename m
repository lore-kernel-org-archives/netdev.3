Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B65964FC;
	Thu, 10 Sep 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070888; cv=none; b=ZLBlJqcRqI5GRezcp8jmO+h1hhJtEeiFZPZnavStyoqHjKacYYNHACoUfKkH15sZHeI6TXTuE9VXBoBn10jJ2mukwrIcDWVrsIDATmw7Wvwym2hTr1XNKrdLNIK/Z6frV6B34lOHsZ3Rl95C5gaqPaumEsrXlOzpz7LUChFMUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070888; c=relaxed/simple;
	bh=1qrFlxzO7uVSYV+A7pC9IgzDmmmbEDeqebhv/suFFpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=krRRbdWtrqsW1bj+L6FdoyPntFt6oMu2uQzsxU+abSpZ7OLMEBw8fJapiUhmYydtl1hrp7L8iU2cTzg7wRxDF3+o7hSiYWddyXp75+9LVQwecEy8zEL1FIaP6ZjegaXZvUUcFFvIlgupohdFK1joBwaFcsnYtQbzQ6rQLkUqvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K74fNNAZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K74fNNAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD57FC2BCFA;
	Thu, 10 Sep 2026 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789070886;
	bh=1qrFlxzO7uVSYV+A7pC9IgzDmmmbEDeqebhv/suFFpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K74fNNAZreu4JUawc5tHLJaHdKYm9+XT1AWZ5QUb+J5t26uGNKV59gvNeNInKmu3G
	 3PDXe2+uTP5tFZJBhYzLAtnXxGs+u7LZ0DN+ZTpoxYrLdMAhRmVAKB6yQN0Z8BfclL
	 ivQemzsQ0N8o5MX8Bkm+9nZFNf3qC348mE2rUehhyWsrdu0GyUhFlnRPVVyDyw0z+4
	 k8vphpf7X1OAAA2EOTrIfm3zS9ZpvZxhwdq09Rq25sN7iHsn8f2AAvC82uImAaIJoy
	 T0XoQIvBpwjfurPBuFEipu8idSLaK0Wyg1qSBKXQWA6XDQbwxh/F1Vxz1C+A6UYp+t
	 d+zTnE3QiidXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C2C88E41;
	Thu, 10 Sep 2026 20:08:06 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Thu, 10 Sep 2026 22:07:55 +0200
Subject: [PATCH v5 5/7] arm64: dts: rockchip: describe PCIe RTL8125
 Ethernet on NanoPi R5S
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-5-c1b9e5f10cd6@pardini.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=d/VG2/chohE7PySQEsZ1Vo0STaN5v4pNoZsUTpZ3M1g=;
 b=owEBiQF2/pANAwAIATteP+Oex+3pAcsmYgBqow4kCugUP6LbCtGv7c4s7FXQL+f7aE/8PYW7I
 E480QLNJCKJAU8EAAEIADkWIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCaqMOJBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQO14/457H7emkLQf+KulPfWTXTsdcSqcM9zVk/ei8U+8OWfF
 AuHnpb6xyjHrTVzhYS7+yYYGaCBe1zStZnnpXVrBS4uAL9qIIOFhHubnjrnT0pbSdVTfOjCT+/O
 0VDl9eRdzW4NTgH48xgZu7Rj4UgcxkDUdtbq/cXVS9V7k3CTKwzRnUUZ3X4YyzDfUm7sMrrJIo4
 BmOLR41o1gV24d7Ys1mzRY/3A6s/Xs/iNkjjYDpRI/UElaufCYs/3AzlM6wYd79jDnavqqbdcxt
 dWY4FcaWTtwFiTZFLiqymZrUa2YqlBCiY9XCGKbdBurcK8MNNj/IsgGjEMwF/Vle2Qt8iiVrL5L
 GsXhGoJpixQ==
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Reply-To: ricardo@pardini.net

From: Ricardo Pardini <ricardo@pardini.net>

The FriendlyElec NanoPi R5S (rk3568) carries two on-board Realtek
RTL8125 NICs behind pcie2x1 and pcie3x1, alongside the existing gmac0
RGMII PHY.

Describe the fixed function nodes and attach ethernet1/ethernet2
aliases (ethernet0 stays mapped to gmac0), so that U-Boot's
fdt_fixup_ethernet() can inject mac-address properties from its
eth1addr/eth2addr env, for stable MACs across boots that both U-Boot
and the kernel agree on.

Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
index 90ce6f0e1dcff..9ed11663c31c9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
@@ -15,6 +15,8 @@ / {
 
 	aliases {
 		ethernet0 = &gmac0;
+		ethernet1 = &rtl_eth1;
+		ethernet2 = &rtl_eth2;
 	};
 
 	gpio-keys {
@@ -107,6 +109,20 @@ &pcie2x1 {
 	num-lanes = <1>;
 	reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x000000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x00 0x0f>;
+
+		rtl_eth1: ethernet@0,0 {
+			compatible = "pci10ec,8125";
+			reg = <0x010000 0 0 0 0>;
+		};
+	};
 };
 
 &pcie30phy {
@@ -119,6 +135,20 @@ &pcie3x1 {
 	reset-gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x100000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x10 0x1f>;
+
+		rtl_eth2: ethernet@0,0 {
+			compatible = "pci10ec,8125";
+			reg = <0x110000 0 0 0 0>;
+		};
+	};
 };
 
 &pcie3x2 {

-- 
2.55.0


