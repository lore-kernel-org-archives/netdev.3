Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9291337AA65;
	Mon,  3 Aug 2026 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752124; cv=none; b=siLOm9h0zoTlK+/+FkWARIe345dDOo1G2slr4iIDH6LzYnE5gCncdn+T/ZBXhWwDyd+Mk5N0XRG8ZINSReP0BfpSFjI83M8zSqbckPWmwWHpQ850n/EhW+rdGTI7FGUj2riQSp3d3vTSrxys+mgLoct8XvWEqwi7H6Nfa56CBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752124; c=relaxed/simple;
	bh=7wKHyfp4niHGBBx0/iWDlvVSkvWtxK1CYYaYiNUVvDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLH1ICtEYSchNwvRRpB5IATY038CnOqnUjc1lDyUAz+7SDwLEnvhDZucJl/Ze6GAuCW8L7P5mslvTFI32R70Enk0vCvaJqqCVighNJ8dBp5uGriLap+h3MhlnC7vh0sxZSjHoZ4cGv6e6JTkl1WmUyNANnu+SdKB3ckkW/TUZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XDWWD/OJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XDWWD/OJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDEE11655;
	Mon,  3 Aug 2026 03:15:17 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 751373F632;
	Mon,  3 Aug 2026 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785752121; bh=7wKHyfp4niHGBBx0/iWDlvVSkvWtxK1CYYaYiNUVvDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XDWWD/OJndvPR8SzBLqtBJSfQWqYWHAxOTSwNBeMSeavGzEJqsl7s+PzFZtwarv9l
	 InZ866CijNYmiuH8ktqG3li09BXIwWHlVuOOdG8Jt6NsGheDlNsfjNerQ2YkviUQby
	 7d18+vROmKDOiGSrdSxECO3d5+cfx3I7netYF9Ck=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Liu Changjie <liucj1228@outlook.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] arm64: dts: allwinner: a523: add EPHY 25MHz clock fanout pins
Date: Mon,  3 Aug 2026 12:14:51 +0200
Message-ID: <20260803101452.2993721-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803101452.2993721-1-andre.przywara@arm.com>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner A523 SoC family provides two clock fanout pins, which are
backed by gated clocks fixed to 25 MHz, divided down from the main
peripheral PLL. Those are meant to clock an Ethernet PHY, and allow to
save an external crystal oscillator typically employed for that purpose.

Add the pin descriptions of the two pins for those clocks, one is within
the RGMII0 pins, the other within the RGMII1 pins, although the clock
fanout works completely independently from the two MACs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index ca6a16807049..1a95c0a21509 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -147,6 +147,20 @@ pio: pinctrl@2000000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			/omit-if-no-ref/
+			ephy0_25m_pin: ephy0-25m-pin {
+				pins = "PH13";
+				allwinner,pinmux = <5>;
+				function = "ephy_25m";
+			};
+
+			/omit-if-no-ref/
+			ephy1_25m_pin: ephy1-25m-pin {
+				pins = "PJ10";
+				allwinner,pinmux = <5>;
+				function = "ephy_25m";
+			};
+
 			/omit-if-no-ref/
 			i2s2_pi_pins: i2s2-pi-pins {
 				pins = "PI2", "PI3", "PI4", "PI5";
-- 
2.43.0

