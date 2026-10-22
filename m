Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699615;
	b=JNTAE+u0F1hNN8bAhsMK7xnKYq+TCriCB/QBuHWsacjtpMePhMIl93eFFd8nAbblP3cZ
	 0BnhQ5g9tY9JmFYjVEc2zO1k8cktKZHhCqHbaZojHBNxD0od2s7c+geMA6FzWC0chENK7
	 xhu7ARqlb0ZGl3YhpzDRKHi7eOJdZ8G4qB/oLob6AoGzlk5WzH7pOV/KWSfzWWdffzKi0
	 HaEhDzmVf2rQ1EDHlwUypy0Yn7XKET3Ht7V+0ktkz9qf++pSOpI29t+NM4rEfdYgmXeBP
	 zyNrgyhRVXGXJzT2WOkqnV74MKhmZFIspoNxsPgt/Bikl2Q8LBzMUlxDL2bmoPUakBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699615;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B88mpadYYWmyEssRGoyIfGe+/tgPvAtSdH5NBRIaaYg=;
	b=tsldIwIr8IhR9p6luoSae9W9H73ffVNhvTeVzSkKclyB9NjexKjSlGsgkNAszr/n46FT
	 8c7sYr7o/EGWZZ30lZonni7eQkyBUmkbEAZBbPhKtL5M4m/UJypjFZ0Ph4t1Pn9a5HLv9
	 aRa5Wf7RaGtEKOcpZz5WcV7czLuDKJvF8hCLMwDr+JBHr7vll9AO8ihXvmHWE5OFakKbv
	 TPhC+T+LKasa6fxbKjId9A6nRZUo7MQyc9kDJzxH81rlL5iDciDCiO6ctPq1rY9HqqGl5
	 WKAk37iTV1OwqLi2QaKQo709NHszkNfcePn18ju27oXYn+MDTncJGZckua/FMHpGBKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069FE60A3838
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 069FE60A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so1324185e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699613; x=1793304413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B88mpadYYWmyEssRGoyIfGe+/tgPvAtSdH5NBRIaaYg=;
        b=K1ghoDVnVGjbW+ecV7koEH8Cpvz6JxHfu43zW/pzHL15sfDUVmO/p4PvN4oT8fSPRq
         JWU6lXR+25h5mx8aVgFfos2zVlqemQps+VxAMuqPA2GVF73T2Kz6I4KiGh5YcsPmbXmK
         zrmlMptp6Du22id0mZ029Y/9Jgi8FXcpy6g0S1My2z7pIMOZjFhQ5cTOjsVuBsR5DuwL
         vEptHW7prQZqaEGVdaQ75QZO034gs0HwEACVOjfj4Ho461MwP27reyG7jEDqz0vKhI/H
         Y4aTCieufBh6+cuQqUiv/4kyqCc5JwumGmSBYO1qUFcPQ1x3akWLVHvRCg9UFWSwLHRK
         U02A==
X-Gm-Message-State: AFq9FYJTB/ImIFJ9T2yfLN/bAz3xOK3rY6GPWyIFqJNidqSsVfvd2MVw
	Csy8CKTiooIvgXBcO+y+eTZeLWb8WMg/A2PazLEFrb2BJCfphoym8xov
X-Gm-Gg: AYBFou2LN25pbwYKAjGnAvr9cQOGswD67pdir5/4OyWCMK86bUwKfIjva0O+rU/vZKn
	oDtI4MJbTHtpqxaVBsWOQPOFBl93ZdVV9Vr/6RWLhE81yHadb/eHa2DxZ4Cto3Oequ8UqpHqu8n
	nUUVNej4tyYCglstbl0lPAmygpcY9e3DkW7ETcM+LurVE9rDiR/WSz66r9ITlYAB+JaE7/DHHTo
	tx4MWD8R8HnvOUy4489d2gdTInslD/nzsrAakOnp+Pt5UAo0FN3+kaK7UCFOviR8/u+bK28Sh1/
	BM7qY5ZKzEIPxrgREosIVUfrx93EUTVosow4G/b3XZOXd+cNhAQ9NCGN4iFPFO4wDTbYOuR9sqd
	s2P950/fgWvD2oMYsnxM4WOe9fW9J6R8Rrv27NoRtTUeL08bNndss33A8t/Nc77DAHQrqp8J25z
	CgmbhrroRxc608sh5YDyul66XGn8XxgKnoANi1VYshoPEQ7BgAJ9wqBDClmCt7h6aQ9f6nGNSL4
	j0MQvFn8vD8QnWeZ39C5/iWT1cs94YB8hkb1UW1AFcb9DA1aWG3Qf02HiYTvG1A6GXG56XGp1Q9
	Fo7oyop39247yEg=
X-Received: by 2002:a05:600c:3b0a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a211c869d9mr2350165e9.16.1792699613390;
        Thu, 22 Oct 2026 13:06:53 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2123a1797sm35965e9.1.2026.10.22.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:06:52 -0700 (PDT)
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
Subject: [PATCH v4 7/7] arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port
Date: Thu, 22 Oct 2026 21:06:40 +0100
Message-ID: <20261022200640.3101932-8-tanure@linux.com>
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

The board carries a Realtek RTL8211F gigabit PHY on the external
management bus, connected to the MAC over RGMII.

Enable the controller, hand it the ethernet pins and point it at the
PHY. RGMII needs a delay on each of its two clocks. The board traces
add none, so the PHY adds both, which is what rgmii-id asks of it.

The PHY interrupt output is wired to GPIOH_6, so link changes are
reported instead of polled. The PHY reset is an RC network on the
board, not a SoC pin, so there is no reset line to describe.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index 0fa83362b417..4914b0dff8a8 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -14,6 +14,7 @@ / {
 	compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
 
 	aliases {
+		ethernet0 = &ethmac;
 		serial0 = &uart_a;
 		mmc0 = &sd_emmc_c;
 		mmc1 = &sd_emmc_b;
@@ -256,6 +257,24 @@ xtal: xtal-clk {
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

