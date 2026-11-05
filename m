Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873013;
	b=XZyznBgU7ae+vsyse0jG4CqqdKamTHaS/kQn6vaiyDUTL4vDjm+eKcF2d/JjWaRZnX+2
	 We7LOoiXASBqLhff33gTdYhF53+L8Jkd1B45DNwu42TaaJZpBanmCaFvJw5lC6Vhvflej
	 /hoB6S86OnkVnk/YkR0Wxi+RqoO+f5R538io665XwalMxGMkr3pSujoUUvx4+5nPSjNvI
	 DCltPP+SoVrn1aDeiRVOSfrRcBVD+ZvfFhrpjibXp5FVTKw9NGqZbKAA3ukTQD6YgTUmg
	 5+MNl0R1KDFsy9vDcUyb1VeiTnVd4uOareXe9k5QK2DK03ULbofW0ez04C1vNDBcIAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873013;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v5CqxcBKvAvHjHHPxB9ySYgie/HwK72kF8ZKF5b74+M=;
	b=HAu/L763n3IsV5+QEWQvnrtxOZYoFbTaSipBNhK3O3gizAvTYM4qSegmWEjKf9mqOQil
	 zPN8wuC6ijxkeBIk84Va344FiAfykTuOyB1BhQIL10B1PblHAI57DfloJydNeUTa8Q0cg
	 KyRHtroLyAtTuQcDM84R7ud1PKJh3vcpMVMhp00y1NRaN1u1hLXKvhjBCxB+amfINsG/q
	 HKk6mDPXZfmFtbOFmcyktk9kq1opyMWlkLM9BzQQn1vWVexqtfsldr8YV2J3iZK3AzflS
	 xsw/lbqW2w3oW1Guyl4PKPzbXvKuE1C7fvNbmW6OHUjwqdQzgMpR4VMO3zfNR96ZHxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B2606EE85
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 365B2606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so12826985e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873011; x=1794477811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5CqxcBKvAvHjHHPxB9ySYgie/HwK72kF8ZKF5b74+M=;
        b=C6YVtHRw0QLDB7Bwa8+Fk640sSbHJBnJvokPV/EOr5vCds/1zTouHFKYuaYcOjpNPi
         kxhVMdrXlONRE6eARV7G9HJcHv8EHIJelgkAizegWiYBS+8XH8cDcliMkkm8wUT18pfX
         qYXmp8Bam1r7Xnb+o2mjwjGkPgpd/l3HnrtH7XhNxmRQs/Y3lLmrV3zRktvPFjmr7eN6
         Zyg0jumY1rySSMNRNrk/8vLb5Th52gn2VuqZ2ntD3bIIb+Mcc7uZxJnCyWn+X9KshxPO
         jg3GMQlhq8RA4DiSZgq3Zi/KAzd3tSKEZNXZemTNzrsjtY+dUMl1ypOL1EKck8hZKzqO
         WK8A==
X-Gm-Message-State: APuU4Z/HVjVc/p7d3E9c5RriexHLknO8t9w9kwi15CoWSIKanwP/MpCd
	1w842IplbwOL9Los13myVYGham2mritguXVYCBIt5jAfjAaVY/l0y2j8
X-Gm-Gg: AYBFou1s26cexuPl7FcWN8j/EeK2xOdEyiajpJ2YnpdK6DW+CkuKNEw3oubwy0UFjeu
	pGPMGBzwv/1PAkjF6Bda3IABXBruQ04vN8Qwzuh2qk0SZxENerA3tolBzSghAgrD5R3crufF+fC
	bN4F+qRF5fH7Ufehcd+DlfTiDNijeKo7tsbK7qzHTb1u18usoV2cjphUgs+3k8Gc98H8NxiDR98
	uSn1ruCkToQyVp/E7dNSuDU/6yWlqNs1XfJMPckFHXsIydi1wijd855rFgkqGunR2fMUvdL7WJg
	5a58GvupWIqCLJtR9p+we1H5umq6wRk89SnVHA/d/iO0oxPoNFCY+4fNkGFJiL8889ABFS5EWUc
	RKeYfzKOQbSwIv3mgMUdjjYYicHriUmAME/ZrXwQTuiq0CsKQWvcZ5Nhdzj4DVVXUMfHroiHs5N
	c14MhKRXp3soZV4OWix4cpBPr8dKrssUwaAjnYVbEBrpeXzxAiOippC2S6qx6a1CPSM+VUbUUuy
	7/k0fMKCzVR6twdbzzDNiH3rBSd/4XJ5SYA80WpVXcWcKe3TEWEtC8Q/3B0HyNzA4YVjUQbFx82
	ie4cumdsZ17Ky63bAOnoldD/nsMJFBMKPVzoFGVBaiAs8JILAl8mhJlCSs85FbhUTWXryLTy+c2
	9XFSbEth6TL1Y1AAmLrfKDDHlfg==
X-Received: by 2002:a05:600c:1f93:b0:4a5:87b3:ddc1 with SMTP id 5b1f17b1804b1-4ac180f1ec7mr430949735e9.13.1793873011464;
        Thu, 05 Nov 2026 02:03:31 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43342773esm53455775e9.4.2026.11.05.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:03:31 -0800 (PST)
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
Subject: [PATCH v6 5/7] arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
Date: Thu,  5 Nov 2026 10:03:20 +0000
Message-ID: <20261105100322.37816-6-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105100322.37816-1-tanure@linux.com>
References: <20261105100322.37816-1-tanure@linux.com>
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

