Received: from MTA-15-3.privateemail.com (mta-15-3.privateemail.com [198.54.122.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AE3DBD43;
	Sun, 26 Jul 2026 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785104785; cv=none; b=e3A1/QgLdIFwpiydGkBMe+p2TLSF0bfgdDBWqlRAQuvCWZYCsBZDtLnPtlYumJg8sUlK32Y78dWQiWeUwRzqSTPCV18ujAw4UX4CL0szAWQmMjIC8DWSH3BRAOydCj29L9d85wh8xnP+iUeH2TmW1qXbOj8l7UsE5sWW4mf2N7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785104785; c=relaxed/simple;
	bh=NLMy/p3KLSGReDGVnDs2Fffcwg+aJk4Wv1VskdBNtIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgiyBTH/X7+In3cKaDVHecFsSLF5osTS0g5OGLxrM+WrarAz/xcH6d8CJ39FAc0CcXSIvIsxnu3Lr3hVArAYMx8t4dBnUbCftN8ISmm8xLyoCBsutg0+LMozqD1pNhbVykhKn3TVSPcbyGaRJbA8U1w1fe/AQzDOStXYlx0JUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-10 [87.215.145.39])
	by mta-15.privateemail.com (Postfix) with ESMTPA id 4h7bsk04grz3hhTF;
	Sun, 26 Jul 2026 18:26:00 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: qcom: milos-fairphone-fp6: Add NFC
Date: Mon, 27 Jul 2026 00:24:05 +0200
Message-ID: <20260726222405.153008-6-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726222405.153008-1-jorijnvdgraaf@catcrafts.net>
References: <20260726222405.153008-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Samsung S3NRN4V NCI NFC controller on i2c1. Its XI clock is
provided by the RF_CLK2 PMIC buffer and gated through the controller's
CLK_REQ line on tlmm GPIO6. PVDD is fed from PM7550 LDO20, the rail the
downstream driver switches for this chip.

The enable line is routed to the chip's power-down input, which is
asserted high to turn the chip off (the downstream driver treats VEN as
active-low on this design) -- hence GPIO_ACTIVE_HIGH, unlike the
exynos5433-tm2 wiring of the same driver. The pin is pulled up so the
chip stays off while the line is not driven.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 .../boot/dts/qcom/milos-fairphone-fp6.dts     | 49 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
index ebdca0e2d2f3..a1b86e4092fe 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -601,9 +601,29 @@ &gcc {
 };
 
 &i2c1 {
-	/* Samsung NFC @ 0x27 */
-
 	status = "okay";
+
+	/*
+	 * Samsung S3NRN4V NFC controller. XI is driven by the RF_CLK2 PMIC
+	 * buffer; the chip has no oscillator of its own and gates the clock
+	 * via its CLK_REQ line, so the clock must be voted on in response
+	 * to it.
+	 */
+	nfc@27 {
+		compatible = "samsung,s3nrn4v";
+		reg = <0x27>;
+
+		clk-req-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		clocks = <&rpmhcc RPMH_RF_CLK2>;
+		en-gpios = <&tlmm 56 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <31 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-0 = <&nfc_clk_req_default>, <&nfc_irq_default>,
+			    <&nfc_pd_default>;
+		pinctrl-names = "default";
+		pvdd-supply = <&vreg_l20b>;
+		wake-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &i2c3 {
@@ -825,6 +845,31 @@ &tlmm {
 			       <13 1>, /* NC */
 			       <63 2>; /* WLAN UART */
 
+	nfc_clk_req_default: nfc-clk-req-default-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	nfc_irq_default: nfc-irq-default-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	/*
+	 * Pulled up so the NFC chip stays powered down while the line is
+	 * not driven (it is the chip's active-high power-down input).
+	 */
+	nfc_pd_default: nfc-pd-default-state {
+		pins = "gpio56";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio65";
 		function = "gpio";
-- 
2.55.0

