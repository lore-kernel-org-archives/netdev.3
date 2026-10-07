Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E1F449EA9
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361603; cv=none; b=qOwDzMaft1c+D57jbCkwgvDKqsTHoocbLkoLAK+kg2IxnG8iD8bp1fPAnPDGdPq5SgHZHygVXh1uqRX8BWMLrjzWNvigRgvzSf5p4oS92X8LiwhldPaBqw4rzRZdWctgqfaqJdk2nYR5N/eIzb820lOOYe5d7zfi+caY9kysFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361603; c=relaxed/simple;
	bh=7MCaBFOuVYPL3cfUtOVX6nxdRkEKoiQe3MsLZtFLwkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHqaVqv3C4Bz8frwFx0twi/nPjy1I3baglewmI4oxvq0ernzOtY+4tenXV04zHOcrvcuyM5jsiXXB2St29v8yOznUOolJ1DSiKePYKj7inb29TRUunDH8XZs68wS9qERnv+qHqYxFuStoLmzqXeEb7hCkvVrbM65/oHT0pfZBx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48afe75f055so3324961f8f.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791361593; x=1791966393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5CqxcBKvAvHjHHPxB9ySYgie/HwK72kF8ZKF5b74+M=;
        b=BidJ027ym/ZhNlMqV1XPMTijiHSF4cRmewLpZmAI4PTkm3lWJpdy3qH9tFv1b9rtIy
         rsfZ1f6i70ugiMdA49kZo/eB9MWw9hcF9MN/fSMANkHzUOTJ8NaHksLfAcUoDzmrhcwv
         2qOJAhVd8RxY8vI4J0e8+a4FrgJ9wYSmrsbr/dKXIUsLtvQumJ7A8WS01WzjxRtExShS
         +Zu8Fb/pCaRn7hTD35pqreLNdVt9liJ3+YlTN8FfocW9PyT9r5wwRblclDvWy+r42Syu
         Ta0nlAzCL2NXxi5HQLKs7G/7fELUA0TLWl+97HhL/b85EvNG6e96AQgbXIdSEyw3qxNr
         1gtQ==
X-Gm-Message-State: AFq9FYI39ePKTUGOGepdPzh2Uw5pV2zn5i8EJ3V5X0o0tSvFz1o4UiwL
	Fx0/O/nWz7b29grHLWD38qQbGwwp1NIBIZrg1JKlq/YeJRVYY6+exgvT
X-Gm-Gg: AYBFou2xi/qOkNYGc3CSdx9Eew2IVM+WGCydHUUQ3diyiWlc1yOWcRiYtf6B8Aa7G91
	Rx+frl054QFZWaw0FL44n5ryq48MH+2Q2G01KYwZnwgZizy7s8lGdS4xKUKQhzQyi1lys9nL5fc
	lYRGm5sdBaLcx3d0X6vYnuF982+ZTKGXexhg0ok39GW/d5/ik5CKJQ9BxEISAabk868q98CxFsJ
	rll/nRbehFRzQqKXHCZpuXj3jbTlSMKESDryl1xJn2qmIml2XdwPELc8sBfC5hASD3zGyVJKtI4
	r8C41/I48g82Jp0FZqzvePeiHm+2Xu0PyaCW5AmQhM5p5kqLYWIkizK862PVhIN1UT86yq9/7to
	66w1/1VzuEv4wSuGjrKdCH4FYCI7LRKTKxjtfeHff/coSb0OFm8cTqtejMzGJmKeO1QU5U0Qxyi
	KD1OK3GVNuPkNXLf6W9OQR8bx9AMRqAApmT77upLY+nomnYksL5GLuufz1bhjTM8LQiTTOkAp3v
	8FUb/nlBMCe5CQwrsS4MZV0isalsSAz9X4=
X-Received: by 2002:a05:6000:989:b0:48c:6955:a603 with SMTP id ffacd0b85a97d-48c7278fd23mr2475124f8f.13.1791361593220;
        Wed, 07 Oct 2026 01:26:33 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3b502sm4251370f8f.52.2026.10.07.01.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:26:32 -0700 (PDT)
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
Subject: [RFC PATCH v2 5/7] arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
Date: Wed,  7 Oct 2026 09:26:25 +0100
Message-ID: <20261007082627.63807-6-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007082627.63807-1-tanure@linux.com>
References: <20261007082627.63807-1-tanure@linux.com>
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

