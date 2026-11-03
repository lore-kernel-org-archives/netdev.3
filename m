Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723844;
	b=K3YiHdp8MdcRQu1kHtbZjyrYXbILkGlCxKlrW/lry44v2kA44SvZ5dxD9GNN5cE257mw
	 JA8Bu2mpY1gdQch43+Hpt593bWT/YnC0sFuxfr1aFpFERarKjzaXjxsKT2KkV44p+iKhR
	 0tm3ZP7poqKoGhRutV5NZA4cvL//p3EdqLjhCFZ4EX4xwjwZiPHA0qm6F5F0ScElSFJzE
	 iKKeuVaYhLpt1CQiF3bkD9NmzAkvTp+tazYenn+08Kf6AhABd82q+rIeccGyK8+EApb7M
	 mngVvUKZQLdVmSMPlv3WGluVdbOJi3w7tHY7Y3zN9LRxDRqynNflYWVOrdbf7dMuFsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723844;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v5CqxcBKvAvHjHHPxB9ySYgie/HwK72kF8ZKF5b74+M=;
	b=YcKzYErGbQU+cM90xzgL+u1dKvTSqq/8eM3uetPXrKeIl5RkfrL4Xof5EMFYGAOXZ0b9
	 reo25rI0cRgMIQsif2MfVjYiihyfSKFZc8S24ubuHHp2iZrVSHG4cHtsMg64FmiJCuH0e
	 W1QopyUlC3Tf1KxU84YJwka+bwrJd4SsE0GQCUsErK9n5ckdZJr+RvxeXauS9MZGvFQHx
	 3fwqSD20pYa4fCavLjG2U++W0gqGR2FcKzmljuXJyRTeqyF46T5HUTf46oTN/JF1693IB
	 DoRbCj3NaPQsTH9gIFnNSOsATsACgfUMIhD4j6Fy2uOfjZhzLIef6Hdeae5KfGmAAIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F0606EEBC
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B1F0606EEBC
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so599798f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723843; x=1794328643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5CqxcBKvAvHjHHPxB9ySYgie/HwK72kF8ZKF5b74+M=;
        b=TvHzwHMLer4gXJIABlx3OcDc7cA9dXnkhVN02x15BgUIeegdqKQrYfUcUrDzrXHIDx
         YrtgSggox0DuxFUe4+/uqLt6L+C9jSbZ2sIRU1NdsBYIe/aDbHIdrGsCIS63rbtaadYU
         DxylhHbWlL0Lk3JD1hJAzMOvdQwJvZ17D6ojxP0Ogk513OkMtTh5hJiHeZl1VOlm/l3l
         z6GdniZOut222RsB+FCKTeRiWIX4KmfJeaoKStnJednHyaJaWq1NvLKNVupq4h6nHjyF
         uF6+FBOulNhtPMq5QCy5HgtWMvKlIwdj7WMuaqq8xLjGIFLU3rqN/2noxdXL9f83y6H7
         lkzA==
X-Gm-Message-State: APuU4Z8gsRUM2LSYGbwdY21MT3x+RYwIUfpCMl6RwyUuHj8cGCndeLq5
	/i++deHmkpJfXaDFuZ4Calnt5hyo07ATac2iQ/NhFOYvJ2VBJa6iZln0
X-Gm-Gg: AYBFou1HB4qd5f8VST4lOHWatVZhjEyvwrwPfxYQBIRsf9g+wZW8DwRDCfs6pCwgF/r
	nIXYUDvkBL31rBB8c8XQbi/SvzgR9GZepRPUDeKhUqXMRTYL9KohrkLPDbmVmHwmgMkbwwFDahh
	ib+fay9h67vX2Pz84rGZiMTV+x6cNpXYlGExdcLi420wGzwoUIfTazWsBknmGm+UcIiU87gvJjQ
	N0WgqXIMtMQRNb1RLxloU0PjUP4Cykvff1pzZwtXkXrHX/N0lugn6crMS5AzzHbE3D6Tzlhd9OO
	HaknfnZ769YJIwK5MViqATbt9P1txEgSBINTJ94gDw8Co2x2+i7J8mn//zu4zgoJPVHjR2cqbqi
	P9/xPDz4zDU//tTmI2nHcb+YvSxtBUAeav6D2qFbQV+lXmHZlL309u3cSDsmLgpTvNexG6Ia+7I
	cGo/orlnY79SqTLolY7HPncuX+sz5xwsruGLev04CWz9cUA61Uh8m+WqXRYLtnqyHWN8H4+6Z0z
	3aaaA9NY2ZzJ5n1TB130jTGIIGZyq/F4UWDECrv2R6pX0oMUHHVh6wggQxNN3xelGMSJfFa3/gA
	BwbCKoYJPPy9n/PHCClzlT3KNotw6TuiOyqvdfouI2RgG6FCBqnbB+rFwfYCDLefRbCHjzRHyM/
	sZhP2Tp6SvTqz5m6ew2ikqDFHHg==
X-Received: by 2002:a05:6000:2c0d:b0:48e:661e:8766 with SMTP id ffacd0b85a97d-48e661e88c5mr40422568f8f.17.1793723842657;
        Tue, 03 Nov 2026 08:37:22 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm29044772f8f.6.2026.11.03.08.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:37:21 -0800 (PST)
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
Subject: [PATCH v5 5/7] arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
Date: Tue,  3 Nov 2026 16:37:13 +0000
Message-ID: <20261103163715.385394-6-tanure@linux.com>
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

