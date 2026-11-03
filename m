Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723847;
	b=ZNVTJlvR5w9NPcc6bIfhLZlOZOyPbpywD9F8qTJ6m5/vfJTbT+BWwULkjISHvnpf7Y8O
	 d6DfYCrtFNxLDM9zJWTq939gn+j08yxCMvxi1dWtk3qOakvJOBErb9inC7Cb4WQzV7B5x
	 HDM/xV5BlnY8N99768SHvfCDViw1wYGlrGt9srw25P0mepaDECaXKuFNA+yEDEtAhViZH
	 a+YZWMZp/th79dNnuREyxIfJlqPE3Gs1pgeBrWIdVHcPvkZ0fxRdCjjP/Cl38bGeszSAR
	 FdMkr6rAOVPYNOKaS8TphChz93dX+mNHVHn1hqp9zdLgiI5Qk5YVDImOfHGvq05NzUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723847;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rvhYGG2+F5DLhHvBXxyAZN8hokDea2WGLIFovieWgBM=;
	b=EDkXSXD5jAjenToCHyo8NA9QbtBmhczHq0lZeLESX5yiKWDnfA39O13FtDtoI2wDIfXh
	 T7EiIADdc96sIwzFvi2tGTLzqzYPmo6j5ubnH/UEDP14r4PviY7q5ig0HV5xQ6x6qP8Gh
	 j/Js7mLHzkWFQEcQEI0AgGvFOkIjc0BYWVoRxyFF9n4JWZT87ult0763WClErtZgSXH91
	 Ow8E5Md5nIxV2+dZM+8IwASyyJCAsct+QS4Wi/ALEOHX2Cw+Upq97G9Sh59s2/VwIALwM
	 UKuS72mAec4PdrlpHaUnKevdZGpyiQTM+HKQFmlrZchqG4j04yGnMxCccIQab7yXl3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF916082BFA
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF916082BFA
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso3867104f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723845; x=1794328645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rvhYGG2+F5DLhHvBXxyAZN8hokDea2WGLIFovieWgBM=;
        b=u71ic/HXslRbhff3IWO0ANE9BBYM93GH31zqb0nAY8v6Q02Q7eSuCzy12SSgc/zIl8
         cWh1sM7Fz/rzxovp2hd9jzkp3bR4MjqiMJF4e8gy7ajeB6Z48+881xijpQ0C728J8A+W
         DenrNSmxxcwxNM6p7WC7oBUDeuDqoHMv7bCxyyh1L5UdJZLuywcTDFvXkWkBRMn4xo1S
         FikDRIsnPKmK7HruVDQ/VANK7GEL/nSRpGuZdV9bh0W7Ravwz2ZXb/Cj9g9IKoW9viqs
         s61rRS4vjcjtOtd0RhI3g8oV6M2bqvZPH0dKL9LcAQ+EG8nxIgBHC3gwVbBLIH/Ets4E
         d9LA==
X-Gm-Message-State: APuU4Z8WKJld39a9nBpgW+Hpf7vNjhcKz5p/zB+C+cT32harcNpcY2w0
	J1ZQ8ukImsAA+EJQkh3KcZ2RydcHc4PFApJEgNtJYtf17OL9Aj1ydWEj
X-Gm-Gg: AYBFou2x9Jd5LwqrjKP0ibRj0CsXkEJFJfUZkwaJrh50WhmrClULXFWMw5CwA1jO8cm
	jNfaiYaQZppe0YCtoVMn9a2z+9ikjcxv0Mx7yuK+9BOhDdY4ps+hr7caVJ9ft4MH8icIgmO22KS
	3rFOSEHAJkDoOeCSJxugkX3O3kiGQRjuT9bDxwHMEvlB+/P7Z6sBY1j/ZhHuZswV0Ji3vTA1P2X
	EtxvdIjjf5Vq2HuMjdkEc8+WDf1wDbBXEyGzVzMn9yccapxw7btsTgZtvktWGL9jP4c7ukhZwNT
	EpQugsFlJG2vkte07w7HEeFh5stVRkwX8nKiDbEAs3oDmaMrIyslr/to2iSAXplH7rSK+dcjEMg
	tF3jTH3b+KgSzcLf+BFJW2LqvjB5Ku77fK4SPB3sgswoANi6+6ie6q4Z7li+eWMWg76WuYUoFxm
	cQDIE2RuA3B2H+qxdbUzSl67gjkGK2aqCWEZSdVjq5GptgbTh95PcE2hmg+VQzdblj7/6a4xZFs
	xDIqIaC53rhsIUtqTaqqQFocBX3itHnDDVC03eDgrk8tfiJcLi1cAA1bufet5oPALqPwKuq2RyF
	h1Q5SuJNJ/EWe8lBGopX6vMfwklwoasxmJheTN76/848uBf20bnnThKr+7Wjchx2dP6pvVYTk3g
	EiSVoYXU9ddbH6AJHGAVzNrkiu7srAfhOLOn62PnopBqKO8I=
X-Received: by 2002:a05:6000:2611:b0:48e:4e00:b72f with SMTP id ffacd0b85a97d-48e6e50c8ecmr28996710f8f.32.1793723844739;
        Tue, 03 Nov 2026 08:37:24 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm29044772f8f.6.2026.11.03.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:37:24 -0800 (PST)
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
Subject: [PATCH v5 7/7] arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port
Date: Tue,  3 Nov 2026 16:37:15 +0000
Message-ID: <20261103163715.385394-8-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103163715.385394-1-tanure@linux.com>
References: <20261103163715.385394-1-tanure@linux.com>
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

The board carries a Realtek RTL8211F gigabit PHY on the external
management bus, connected to the MAC over RGMII.

Enable the controller and the management bus multiplexer, hand the
controller the ethernet pins and point it at the PHY on the external
bus. RGMII needs a delay on each of its two clocks. The board traces
add none, so the PHY adds both, which is what rgmii-id asks of it.

The PHY interrupt output is wired to GPIOH_6, so link changes are
reported instead of polled. The PHY reset is an RC network on the
board, not a SoC pin, so there is no reset line to describe.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index 0fa83362b417..93327b993d39 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -14,6 +14,7 @@ / {
 	compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
 
 	aliases {
+		ethernet0 = &ethmac;
 		serial0 = &uart_a;
 		mmc0 = &sd_emmc_c;
 		mmc1 = &sd_emmc_b;
@@ -256,6 +257,28 @@ xtal: xtal-clk {
 	};
 };
 
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	phy-mode = "rgmii-id";
+	phy-handle = <&external_phy>;
+};
+
+&eth_phy {
+	status = "okay";
+};
+
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211FD-CG */
+		reg = <0>;
+
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <GPIOH_6 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &i2c_m_ao_a {
 	status = "okay";
 	pinctrl-0 = <&i2c0_ao_d_pins>;
-- 
2.56.0

