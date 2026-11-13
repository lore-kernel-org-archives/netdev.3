Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572340;
	b=ij0k6wfXkz/q8uG02LhsycjSpN3h6qwMd758F+xB7cJKkr6/GIb9y49hO1pSqqP5FBBP
	 AgS9yNaoVeJJFopSNdPz1WRoACkm/Pos1yxojtTsbBvAT9GTTCWQwrx5XxYyoxHuM5qUr
	 B7xaj8mINGO8+wxO47xUXa8Pld11sA9jVLDqqKxABZyehdS3CZJlAMUdmhx4yKNAC4LZi
	 L5KVOIvWllzDTFmATSaS1CYJBCltTpqom4L+eDiS7mN3iJe/GU6oSzoyMgO+vVVheIwR2
	 u8bC6ExB0XLXdWBGBxaFjgaAjopGatfqPuLcDzwXjVaDWSCqcSD7+v4UwHbZtGGeSEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572340;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9GQJLLepWwoaxFgy0WwYMme3cDh2Nvdn33ep+PsXVNo=;
	b=YeKJjpTS39AG7QV+ZhFjMxoRnfSPMODwlPlvovzWeBZllBy9rvbzYZ3kHTwuiojYaBMe
	 1Uxi2ljv2IzoW4ojByP4Z/otrTFLlKeDYjLMAtOe5ZW7sHNmIJCG7GcD9x5/+4RmMU3uf
	 y2PSiyICKLgtZvGwJhVqO4nHdb8cSdnqZ/d+oor4/lirz7pxCQaPOocHjcpC1Pm3xYmxR
	 ZYXuJfbNd64gK0RsDpDFgM9G5ilThrnXX8ZReCin63D59Tzxe/OST/mZK2tAw4Y1LrGu/
	 hW/LciayIfG4jGHEC0T7zougrCG6uGyartsZaXg5MMuuw2sjEaDlGAoZesU5ZBhR+Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1660A2614
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B1660A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso279397f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572338; x=1795177138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9GQJLLepWwoaxFgy0WwYMme3cDh2Nvdn33ep+PsXVNo=;
        b=vAI6wavWNwT4JpEIGEf8MS3ZB/f9j+bhp9p6VXFk5Cn4yZoJs9jr/FDqc/DBN+bVj3
         W/Gnxr4PqPHlbJwZ7NmBgCQH1N5tj3ni94ra8DzNw7FM2A7rZrerZHsc97WmRLnztK/5
         iujlgLzKUItDlybjDyJdJq5vJkT/snh+5hjk23NVmGaoHHLI7zSyX5ywmpUCCycvIsYR
         eiQDXOPJ83OftFX2xOY5Osb3fR7QaAROdsNHzPvBNH4Qfnpn8szGoOrRnolNbp7KTZGH
         XAzRGygpzi4gecg9GSkRlWqenY/ovn0X+Zp7GP3ktTgabFg8BndGlD8N/DfLeUyxjs7f
         WIrQ==
X-Gm-Message-State: APuU4Z/aD+Miwvs1po30Io8x4K38e4YO56aSMG5CGVEAFOvE75Ni+6yI
	TNAlw6mbgZLeV2n4fz5Qg0hOaUXOPejjijCnAmf2850bMVCQFo4jTwXR
X-Gm-Gg: AYBFou333slZvVhqHNeyb+59HS7fNumJchocffAwCbls+MsDehAvnvlU08hz9Z85l58
	TZqCIAMfSVB/gMaP9/ulbLWecc3ETD/5YkeCN1gjsDJ6Mu7F9Of8qkMxwyMLl6pFq5tF8a2Nwq9
	apB7gQm1LHwhjVYIbICW7lrQDePDSBOqEvQlBGCpLC3g2zSzOjleal5JJk7m0Bk8RUjK1y2Hjdr
	+jWr5OM7cFbenv4MbYO4WakkckzXZSME2wsjQUudNzOKUWqkww7+xco7YqkWnifI12m59d8JWEm
	8MABFQmIM3PdvnQUpRn7iIB3KjJYJNuRH41WPIWhYzD5V0mzgw4Yl/iEmIXbK3VVxvV0eKQZxZz
	6O5UKN4WPCI/7pNrgpsBFVUSkNsx2UZygDc4M4FCjcywnrAXJm2lK8Gv40tH87ueh8jiZH6cuuF
	zfSCGAlZUwoQvYaI6IGMnmRaWdCgwi6TWiHee5dyVx+5mXKXgSmoUdZB7wXiJZ85IrFEkaNQ37F
	PHl/rHTbIxbkWFEM9R7Pc/xIpapzl0klKoYtet2IbRbaiPj3Bfmaji74N5B5sfyDAamz4Zei8Pe
	QuXKUqfoWQcNeR7p7sfNlN8gmLiMmDAl2bPtZi6QJnos2MR734XrMbfbsQ4CKsVmdlCwK7kNGk7
	NObsfeigvXajL01jiHWmizr0Q08KYqeZKCSzRjNA7LAZ4L9Y=
X-Received: by 2002:a05:6000:2c04:b0:491:3fdd:af42 with SMTP id ffacd0b85a97d-49c72c9c049mr5208825f8f.37.1794572338269;
        Fri, 13 Nov 2026 04:18:58 -0800 (PST)
Received: from threads.localdomain ([84.70.166.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e5b2fsm5167103f8f.40.2026.11.13.04.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:18:57 -0800 (PST)
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
Subject: [PATCH v7 5/7] arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
Date: Fri, 13 Nov 2026 12:18:50 +0000
Message-ID: <20261113121852.334604-6-tanure@linux.com>
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

The SoC brings its ethernet interface out on bank Z, but no pin groups
were described, so a board had no way to hand those pins over to the
MAC.

Describe them as the two sets a board actually needs: the nine pins the
interface always uses, and the five extra ones RGMII adds for its wider
data path.

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
2.56.1

