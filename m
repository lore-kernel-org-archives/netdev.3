Received: from out-93wp-a36.jellyfish.systems (out-93wp-a36.jellyfish.systems [104.207.68.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBEC36EAB0
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069006; cv=none; b=PFpVEeEGIVgdrQkIHzSPRsRYOlzscTQMfo1J31/8DJYIJqJPwvNyFpCs2jMwEvpIjoDllY09BEfojN5KOhtBK1CQR+ZsFMtwNsy4yLmu0YolUus6Ec+koF9yO8wO5hRExfe45R/+7rw0H34QjC4J6Txab+XLIqSWe9bEyV12oY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069006; c=relaxed/simple;
	bh=hpay0Z4iP5WI8jafOAYJU7/3eg/US0fygLBZi8IsOVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnhFt4xWFJG3C9b8zyB0PFSMD6rvIEIl769Mx1niS2aqJ0UbUxGHatMDp+tA7W4tQrrKOVyLAvI4ED+htULst5an4yET7awt7a6X1ISkbiZjaxEW4mF5YZiz3U8OUaEBf34zjTsuo/b0epMBMZA2LVT9IUe3XUdjtvj/FlRAmG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=104.207.68.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hGSLS68Qtz2x9B;
	Fri, 07 Aug 2026 02:11:12 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH v4 6/6] arm64: dts: qcom: milos-fairphone-fp6: Add NFC
Date: Fri,  7 Aug 2026 04:10:01 +0200
Message-ID: <20260807021001.239389-7-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807021001.239389-1-jorijnvdgraaf@catcrafts.net>
References: <20260807021001.239389-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

Add the Samsung S3NRN4V NCI NFC controller on i2c1. Its XI clock comes
from the PMK7635 CLK7_LN buffer (RPMH_LN_BB_CLK2), and the reference is
load-bearing: with no clocks reference at all the chip polls but never
activates a tag, while a held rpmh clock vote lets it read (verified on
hardware).

PVDD is fed from PM7550 LDO20, the rail the downstream driver switches
for this chip.

The enable line is routed to the chip's power-down input. The driver
drives its "en" descriptor to logical 1 to hold the chip powered down,
and on this board the chip is off while the pin is physically high, so
the line is GPIO_ACTIVE_HIGH. The pin is pulled up so the chip stays
off while the line is not driven.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 .../boot/dts/qcom/milos-fairphone-fp6.dts     | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index ebdca0e2d2f3..bdba848275db 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -601,9 +601,22 @@ &gcc {
 };
 
 &i2c1 {
-	/* Samsung NFC @ 0x27 */
-
 	status = "okay";
+
+	nfc@27 {
+		compatible = "samsung,s3nrn4v";
+		reg = <0x27>;
+
+		interrupts-extended = <&tlmm 31 IRQ_TYPE_EDGE_RISING>;
+		en-gpios = <&tlmm 56 GPIO_ACTIVE_HIGH>;
+		wake-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+		clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
+
+		pvdd-supply = <&vreg_l20b>;
+
+		pinctrl-0 = <&nfc_default>;
+		pinctrl-names = "default";
+	};
 };
 
 &i2c3 {
@@ -825,6 +838,22 @@ &tlmm {
 			       <13 1>, /* NC */
 			       <63 2>; /* WLAN UART */
 
+	nfc_default: nfc-default-state {
+		irq-pins {
+			pins = "gpio31";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		pd-pins {
+			pins = "gpio56";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio65";
 		function = "gpio";
-- 
2.55.0

