Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873016;
	b=gZk5BSedqB3JgbCpyAlumJrgmZSUzBEBog/ifqD7I1RMRg0yelhdLUY9rr8qLQR4UWFs
	 3NHeJG8p4ROW1XhLsB63goOclhBrCN67IWNuajP0/XNRRorfgONW3BjV/2o1QltMzcK0f
	 jKhFbnSNYvvWHwBS8FQk7uZuF44Xztki7QwY9Q9O+T3a3sAknM28bfcXkw4M0fufCyRZh
	 48lygz5INB8RrOf7J6jJ5spuzuwKEfH1CtlvNtFJW4o5Y8erwJC9ZgYVJ+l11TF1WeRUd
	 p97dyw4iCElNNis+nYvevbkSmdggsRTERCqePqiNu6DNHpTNf4JQpRchdj7yRfmi2GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873016;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rvhYGG2+F5DLhHvBXxyAZN8hokDea2WGLIFovieWgBM=;
	b=evBxjZT5g4b/4/uojwyBkoCpCUxI1FOjMbry31yczbfTPcMjZi7dOLrct7fB9GzWOoLp
	 P3QaCiOwEWxkkIxF9FfGglMUpktbk/6o9XbopD1EC+B3m45XB5S6hquXhbLJx6/MIBCJ1
	 hTXg8MJB8Ya3cTO4Lk3iXsAhwk3csqi10nFxFM0ZgwmOqRNJWRiE3BCCcXLufApRkvvE/
	 Wha8io11trdhgR1xdX2PA2wJcpWlb1iF3a6qjO+bpHhf+SuvARBQy9KY9XaN1E5GlIrtz
	 Dm5HsgEkUe9u4zJFXqAypZuoi7LB3c1PC41EuWhuZ03JqrJ8k0NLVaL3T86S5vgITLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C256082BC1
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C256082BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so14955075e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873014; x=1794477814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rvhYGG2+F5DLhHvBXxyAZN8hokDea2WGLIFovieWgBM=;
        b=ct7uoYOCQ8MTmJ7BI0CkXn+g2eoFlA7d+Qxasp1ZnOB8RbLyz8kXNr66A5CFJW1Da4
         5rb/GzDBbKGRmHfPQnrm7H6dsM0SjGoMrGyehdEkNLreR/H/RhTPXIPzDxfiVbwFt9bo
         nUZhF6mG+J6PYeE0AEbTSVJWoq6p3qogs87IRrf4JASWLo0no9nm1eTLmPiLmiQKT9gw
         bz74HAIcFsTIiJph9hGbdTaCRCP+yIiQkAHDv3wfBzrkRtn5UcOF6gV22SNcMS7G23ic
         D0iWSv9mcNj84HHpFHQGGapo4LX2rCjyZ1UKljDEgnWgdo3Tg2c+eWnJm/9utA9IIMYU
         IM1Q==
X-Gm-Message-State: APuU4Z9kpS7D5YAk92UpO0Iryk9o3hmFr9SM8YSMtlAJuLVVUBQQl8Jg
	Shhia04Y4okJIEW7WJqS0zhDRj9pafy6/HyQq/wT0Be1ZaHPv7Vn5kuZ
X-Gm-Gg: AYBFou3ZTAe/scMA+4SFpPHrKqpwyzOwiVxb8p0X7syQkxkRQn0wM4u0VnO0qEJ3GJH
	u1X3hK6LF+Vp1pfvrLm5lik52nluekYxviJl8VMY4Dq0f9CsVHfNGGKr9dOukA8QE73NzGJ4ytZ
	G9CmjLrtxJ/EpMqHjjMt6EPkfUe9wTV4yWJhNx7sAPWG1IyZuE/5R9hdEz2zS329ErBbyW5d/nm
	NOuYigk0L3jzRfTJHJIEIYHnrmHI4IdqqAkDf8Y+0x65AbDjJ0VgV3emvXZ1R2psvouHht7bioK
	e06qla0TmeaWOP1cZr2DAv2VuW1tnzL0kbR6hj3zFHl+lC3srZt4DrOROKIxdyVyBYkDz9AZWls
	KW1DeNJ3/UEQUzjiazuRjVl6ykJRribuR9A5To+6WhExHyPTAN4AndbLafTiEWsxhyUeDMhXsgI
	66hAbtMsYFq7fMsRK8DPqJarTm9B2h79GPCelVhdiCakN/0GooXjixvDa0CY6yoWAwRhkfLftSP
	uDgKlbTXoijPJ1utemabIjeptYWAyE1XAtSGJzL0CaU5myj58ZATNi/SQe4Qd0LuEwlVtm8D85s
	yQNt35H13ZALodT2/yjXe4dFM6YpcLkMWrHxVzbg1080pTCSxhd/jmMCmcPZgsWrvinKotHVPtb
	bIGwlDXXtNAgP8xFW4A6Mc+g+lw==
X-Received: by 2002:a05:600c:3ba3:b0:4b5:2c72:651c with SMTP id 5b1f17b1804b1-4b52c7265a8mr45793945e9.5.1793873014390;
        Thu, 05 Nov 2026 02:03:34 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43342773esm53455775e9.4.2026.11.05.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:03:33 -0800 (PST)
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
Subject: [PATCH v6 7/7] arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port
Date: Thu,  5 Nov 2026 10:03:22 +0000
Message-ID: <20261105100322.37816-8-tanure@linux.com>
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

