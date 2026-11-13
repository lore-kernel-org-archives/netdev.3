Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572342;
	b=R0vSXUxoZX+U9gQ//oCiUOmSAyjuJXlo9JvHom799wreQu+2bwO9z2ECSbVbEAx8JLpV
	 gN4stop+IrDR1uWumjBbi+dXWKVYJStR+RODb5zkZDV8SxSQFxyWcZ2XO+nP+HN+r9kyH
	 aKmLzbZTRhb7QDF6vziEJMbMPLO4J39zB2WjuZ95rEJplY8nDjBvXrUCh/qBHKzRraBz0
	 zeEoDBZLW6igKIh5Fvvpw1N2f9xXmpp8gp93wOM2S8L7LE3+FO/tdtNlURtvXJPSi1Xga
	 8LiKf695YVBAg1NEp2/X0vj7zndrYoqzGSkSkLfzKnUuh0eu5x1lpIz8ceP6zVqOYUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572342;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2m5S/wNdPReWyWmhpeHcOzCcQyN3wK0mfC0jmWIgfok=;
	b=KJDv7boS5dO3Kic7iXDCH5NlKHTGgpnYS45GpwInGYijV1UFHUiBgL0LbxDgNuB6xUkF
	 eMMpd7BXzx72e6i1DTju9+ZGkIkDBsUF3M+/hpPynJWCC+/+bRDyy0OwZIP+ZDtgF/fsI
	 IyywdUo5Oluj/25S5vTHifi5KD4qGal5Li7VDkaSR9D8qlWX7jeJf4jDUAcPO83Zyy4lo
	 PEbn7t7Jr5zIPbM3I/9eqI43ZbA6v4WVO/TZQ+jFogzSVEpnlyVmTJD5bnKtsdiaGIgTW
	 VfAcc0XP6jR/iIeqZxyYf1MD1sxn5mzH9a/C1ZH/lUgeNo4asgK/Q57q2bfaIsjVEqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98F60A3835
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD98F60A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so375797f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572340; x=1795177140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2m5S/wNdPReWyWmhpeHcOzCcQyN3wK0mfC0jmWIgfok=;
        b=URix9BTLUQGntR1zoV37FfxPC5PLC3IWSRXIO/yLrenFCavsxTTc1BNo2xJ4kK8Ne1
         ZGel4C7c6nlHMFoxQd3HkiX2OTOq4C7V+t0KKtQn6rIp5x2opNOUKueZS0D5vTB2qvsA
         w2zjRhitYj2z2DXJbqV7R/i+3bOFS0rF/JoOGQZsIFiCEKzeWwpdPNqnMGQ9IfQ8cZ3j
         U9JgYCaZUxKRmXLOroY6FHyy8TZZhu+lPMiMF7tLiDu4cpRQCxvCNk75TjAWeEu1ShrF
         wS9l6K8ntTcEbcTtcciV3vMn9m8SJgl+hfAsnNa+nAge5vdIVYuykedIegaQulEo3CFD
         YyBg==
X-Gm-Message-State: APuU4Z/VIDMrimnxqoSLdHAwM/m6GMAQbZb6kFdOohfJT5a4LIPvMDHf
	4g0gaSXbHwKEmS3NRelAs+vGodEyvzcn08msdkX+mualmMBtwuDE49lk
X-Gm-Gg: AYBFou25HENHuSvxp2fsbd68mDDnm7DngHJDYuiUfbbP9OUd+RuEbgwzisf0vZbG00a
	E1+MuUVKrWKlMTsQvveKcvdRAGDKhv4Et/gzLLIWXU8oFTD1ExnitSfX08aHMcWZlwqYttzcCkd
	uFvTb0SIKtHtLJQSVKpd6EAOaTjA/Btl0B7gGKH+JzmuUBVTC9CM+1beE1/rbNcTlwTFjxpJzI2
	4sY7loa2iUjy+tREFMUpLtILzu/NGWwJkAcAbzdCIhx7dKxau71YzwgbQYQOQJbbWNV1HR9E3Sf
	I74xdF44W8iI484QojEeHWpP55tnAHBKiVyT+2UpTRx+Zsk2pacTW3t53MCmtGejOGs+yU5Vpx0
	U5PSTH5XvFhh25o1eNsZ/Zj1OI3uvJkqa9HEJpCbenPU+k4mRH6jqB9ysuaKA5TZY1xsrNbUZva
	fsRT+KMbfDoKcwJeLPWJCze23hHiSvvnBRfBSb3SNH+g0Pf9Z7NUriOhk7ymeAYZjE68ITwU/Ht
	anrqMEkpU7rHN64l/yT0jNsfEQfMcnv/w09z1AG1AkW/kGuOxljKDuQbMowEr9FrD9oifu4jp7N
	podsWxWu9Aby8pugTKA8f2odVo5QKnGZpIqqjWAD0thWGd5G3VmKvN8WBR/ismnuk7uPMoQkeTq
	M6w4vVXT6cIZYhyn7TEmdhSyj2g==
X-Received: by 2002:a5d:584c:0:b0:493:c0a:5087 with SMTP id ffacd0b85a97d-49c72e85557mr6076606f8f.51.1794572340085;
        Fri, 13 Nov 2026 04:19:00 -0800 (PST)
Received: from threads.localdomain ([84.70.166.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e5b2fsm5167103f8f.40.2026.11.13.04.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:18:59 -0800 (PST)
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
Subject: [PATCH v7 7/7] arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port
Date: Fri, 13 Nov 2026 12:18:52 +0000
Message-ID: <20261113121852.334604-8-tanure@linux.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113121852.334604-1-tanure@linux.com>
References: <20261113121852.334604-1-tanure@linux.com>
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
2.56.1

