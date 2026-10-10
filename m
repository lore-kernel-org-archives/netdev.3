Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56544119E3
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629959; cv=none; b=eSD/aetxdPJ577KxyJXKZ7HmGt3uGVQYPVZrWNY7JMjg6vixGt+iUmfviQanXC95gFq2d20gc/ufL3vSAheh1ARXAuUPN9Mu6ntZUtxJ66wesIqI3023P6/c//gxqKko/AWOBjScx49fp80FlL2WW4tgY9wVew/pnSoxYw0Wy3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629959; c=relaxed/simple;
	bh=7MCaBFOuVYPL3cfUtOVX6nxdRkEKoiQe3MsLZtFLwkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqXQAjHLpkDMPu3yEjKYXy1n76WoL02eTKun9gSAWXd+lbJ6vmgyVfkViwcFTcMPkNmC0v21+wphvOvWgqiy7FIeBfu6CJB3fwdjOc/TWSMHcEVNCX5Ldt0W8ynQFHMbP6cQcw8C2uT3T9+84yqP0Teq+dl3o+tDeKfaxWIYTvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c45111bebso288935f8f.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629949; x=1792234749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5CqxcBKvAvHjHHPxB9ySYgie/HwK72kF8ZKF5b74+M=;
        b=A6LNA/izUXxQsd6uys4Wanxgy2tcdtgaxrN1bBukfjbCZoMx/mkoBonCJ5eZBtIsID
         WZ/wZJxNvTU1YYooPD4xP6xNX5GUDgifvvBR0nmRG8t2Wr6CrGqsQK53bxRKBVpyaKQf
         RG6eCkIoWCsyiVZD+sS+rfq2VoSdVsC5adiYcRhrEzngKLHcwQVbHBs5MRE2fMmqN2Zu
         JFksUqQMweVwiCPOrZzCZGG6jNpWcaRCcbfZw+/TIrifKbN3BjgyfDih+5vtfY42ecfl
         0f5gtZ/4jeGyQlwX+5w5hjefrSdiCSb8xsTwWnVRSIRYXQ4zmD9OPjhfb3KrOZ9Q4xhm
         S1bQ==
X-Gm-Message-State: AFq9FYJ8UW0Y/0HAPZGTI0Sn+aqm53NZ83RJn+pd7JQChOUH1X4TPGij
	Ejye6G75x+oDqQx0sVU+DeHFKzZnacPEOYSY65eunkAX6kLXck/lfTTV
X-Gm-Gg: AYBFou1+M2wm6TaRDVR+4GgVrjzzJKul+Ny6wMC9lyavjJLN4yLhZ4okDSOR5EuLI8g
	5halhqdsW3L0TPrhmQFJBMOVOfIMiKvTAkMdS8N2TqMbwhyuZjfEsemvka/zpcSL5vdfwa4O1Vf
	QJDkIVnbhpWwy87VQTqCf7LvjnP9u4HQAHQDM6wx0ZcvL1UnCIpkDzLt/vax87JC25iJv9viHNz
	erKPsBI51BDpfwIfUwsQhw1Q+Z6MhxTR47tOjExyVuvYEL6trqpBIN4/Cy/L4IotdrIo6bV5y6c
	QehnTTLxS1ylD4GuPU7VEIkRS5+ZnojebUaF+8R2oTszyMcKbsMaaQJGmTbrvLMmxNRH+LyYtTR
	mZOQxumVJWobb+fPRkJvAgItbp6HyPqrOOHl54Y4PWsLjLbur+GjNYArXN0UH29CIu2xH/edt86
	PkjjvqqwYa03VD+c29jdmmJ3/E7INSsX8jcbIfdkzAQUfnV2v9dD5y4E9o3qKJ/y3N8BCUVgT9c
	57QW5ejI1YrhymfU//j75MKGb/Y9smeE6g=
X-Received: by 2002:a05:6000:22c2:b0:48b:1a0:5630 with SMTP id ffacd0b85a97d-48dbacf3275mr7157743f8f.41.1791629949021;
        Sat, 10 Oct 2026 03:59:09 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ae17e9sm8709526f8f.57.2026.10.10.03.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:59:07 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
Date: Sat, 10 Oct 2026 11:58:57 +0100
Message-ID: <20261010105900.247342-6-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010105900.247342-1-tanure@linux.com>
References: <20261010105900.247342-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SoC brings its ethernet interface out on bank Z, but no pin groups
were described, so a board had no way to hand those pins over to the
MAC.

Describe them as the two sets a board actually needs: the nine pins the
interface always uses, and the five extra ones RGMII adds for its wider
data path.

Assisted-by: LLM
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 30 +++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 6894c06a836b..7bd53ec16607 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -376,6 +376,36 @@ mux {
 					};
 				};
 
+				eth_pins: eth {
+					mux {
+						groups = "eth_mdio",
+							 "eth_mdc",
+							 "eth_rgmii_rx_clk",
+							 "eth_rx_dv",
+							 "eth_rxd0",
+							 "eth_rxd1",
+							 "eth_txen",
+							 "eth_txd0",
+							 "eth_txd1";
+						function = "eth";
+						drive-strength-microamp = <4000>;
+						bias-disable;
+					};
+				};
+
+				eth_rgmii_pins: eth-rgmii {
+					mux {
+						groups = "eth_rxd2_rgmii",
+							 "eth_rxd3_rgmii",
+							 "eth_rgmii_tx_clk",
+							 "eth_txd2_rgmii",
+							 "eth_txd3_rgmii";
+						function = "eth";
+						drive-strength-microamp = <4000>;
+						bias-disable;
+					};
+				};
+
 				i2c0_ao_d_pins: i2c0-ao-d {
 					mux {
 						groups = "i2c0_ao_sck_d",
-- 
2.56.0

