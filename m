Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699613;
	b=Nf7KwIQfV8UBlStlx7gjyT7QBkL/fD57SshCxVliMQLm1v4aGMoEVvdDgcNGvwL7a+mj
	 ULXUUsymgVqfi6imNmim2K1P5rRu7JRWzztiwd3S8e0gFHAXm4QgtVd5tjs5XqnI2L+u8
	 If37ZIr+Wk+KXlL9wELqBfT3dX/iUV/oHOxDVAJdo1lhINHS93qS/1O61pu2isrULBm0Y
	 5qaSGHf1XXlNqu5H1YsI3if00L8R9Nl3+lDpQlvs1iG92Hp9ovq/gDZHX4d/yi1bLiVjd
	 sIXqa+GVCfuw8pvkmqQbMlW/XPUPwYanDO5ek9iQXsNDlAgBo0FLkttB8dI0h6FxkIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699613;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v5CqxcBKvAvHjHHPxB9ySYgie/HwK72kF8ZKF5b74+M=;
	b=zX03dQlnXlYD07XKmsGv+wCXCFO4zawcURjrsFKEaTB1zfVXdcn6d7awKMLQL8jnmwlJ
	 I5wJya0fDU7rhGSbSkta5SC/x9l5+MDyekIE9Eiq/W/8FobfqkT4xb77hVzfxLI29O6KV
	 1HwDCXaZrfZeomR51atLSbtqGno+m1hsogPwcrYVZt0mtJ59HjoPIHgkSy6UWXy2XUPP1
	 uXLctk0icKyo1CVWyoW7XfAFlIPwJttODOAveq525g6Yso5G05GotjeKxFEBPsX0SyhrS
	 YqrN8xnpinw5V5Sh8FdYKT6ywk7M5x8C2SpLZk5zAkYAWsxOnuDpHB7HcR/yjzZhbOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3EC60A3814
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C3EC60A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so1187075e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699611; x=1793304411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5CqxcBKvAvHjHHPxB9ySYgie/HwK72kF8ZKF5b74+M=;
        b=pVWd9NKnNde0LgpOODZBnNA5ApKpji1ODP+N3/dd7gA6ypCcKaoAEyKZdvqqVnYYYL
         kajEjySdfxw2HzrODd4Y/3mqaovoFMvRifO2NvpSI6seE+SzgdhAI3vnmboQH36a66jG
         jF83orobu6cTU3Yxq4yeC5tLXt7nPSSuLvnUaVPNaLBQCcP/Av1enUC5ZgKLwZP1/FfW
         UqbidxGMLcQtc6VI9sw4gAC8kAC8tprHfuv4TSuIX9WTot4pAbrIbWEFupvLU7PJ/Q6p
         yQMt9t7JhdvKpleJwKISrBuQNLvZ7eyHb43WPURiM7CF2LCmMTtop6vSYkoep2nw0pJ8
         xsqw==
X-Gm-Message-State: AFq9FYIBoZ/R+Tn/gUpYd4zsM1Esm+BuZHgJeVshlhr1aAVUQHffWbLC
	hxud3Ba3caoOSkTgptLqfGqFHIvJgqIcSxdjSfhbAOUR9zX6QVeh0Q9c
X-Gm-Gg: AYBFou3M44HkC5msEWkCVzmA0buGDqWA2e+Z6yipCWBnCf+FhCnNiEHFQfOSB3aBNRH
	oHi1O8JbMnHVMZ2Zvs8DOCf7cjtu7mggWBgTiSGzNZ13FAZNjd/zMNeo2TBTnC7rXcVDCXB/jUM
	wYX/bgVBaLNuOYGgFjAgTsRwg5zAlRrjlxsUDiTmoNmyJlzHhfE/b4CBXrPFT1c9RKYboWHEGPb
	j7ESHu7XDkUA/pokDnML7tJ/aSAhhwKeBp7ru+v/76CFc/ITXQLCDbdHh8fsoQ655RIIqAoQSQ5
	0gWxskwiZ9SWYxv3qIAMCdVzb3oPMMNkRD6ocya5+X/KlER/tSwDfHd/+w2VuSoBPWAvdRMslqW
	nhIkNz2YPPEbUvaKzqhoiD+ge8KEUM7zqo7cExIa2FfKSOFX37jx9E/AH9fIiSP40vnH1svkTwc
	pllBrG/z99C/2Yioa78tU/lv1SKNJQk85ZJ3yoIwES/EkGKc8+pZGvUyf791vdzttnyoLaWJRee
	i5EBM81To7IyyGxxOCaS+HEH6l6XBwxNO+nyyeZRgiANp04w2//VM3huCiLCrAwdM6qbsk/uIKj
	1PM5a3tJAiZtIuwnbqU4S7gbOw0mT0pl2n9n
X-Received: by 2002:a05:600c:1d0a:b0:4a1:f8cb:7d70 with SMTP id 5b1f17b1804b1-4a211f08fedmr1687545e9.24.1792699611517;
        Thu, 22 Oct 2026 13:06:51 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2123a1797sm35965e9.1.2026.10.22.13.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:06:50 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
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
Subject: [PATCH v4 5/7] arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
Date: Thu, 22 Oct 2026 21:06:38 +0100
Message-ID: <20261022200640.3101932-6-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022200640.3101932-1-tanure@linux.com>
References: <20261022200640.3101932-1-tanure@linux.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

