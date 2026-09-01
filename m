Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD940A924
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274939; cv=none; b=DERcC5QgZnb+5oMZUeHFom6x/bGvDOBLB2OIxdFbZrOMhzdAXsU+JqmMoy8KJNDJT44FH6TCh//x/CRmc/sJN83uaw0HkNFwdpgX8UZjNwo3aWIgHgBdGr7wncM1+PkAChowNZEbJV7ngM0GVXaIqvZ315stqlO0T2thtHYD4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274939; c=relaxed/simple;
	bh=RQ8/bIf5S9U/FiX3uQoU1u6/FV6K7LLD2uqZys3J7EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/8PtmV2xp8utibltKMtbMfoLOFJkYJ6iO3dijSdwSrtRLkcnkv9V9+yJ0mEZvzJ9FERiW57PBhYqZVAdiwhCzxVA7XCm4E7WCaIJeZDTP77sVGYssHyAyOu0xl612lcDDaz45INx0qyuuJRrN2Q6x6gd4qhEMfV7ovaKkxznGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phKMX6yC; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phKMX6yC"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc1ddb3ba3eso3186184a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788274937; x=1788879737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2tJApUzC1LEzp8M/eTL2SHChylQhCDDbwAQQxkGsv0=;
        b=phKMX6yCmRU+sn19V9Ec4B/16hFIG4NwfKpkhwTT656O+VqNUMHUeGgfsu1E2F4Ocd
         cBoBJx0YPgBwdJn4aK0CUhRwvWzI8u0YP2zY8sPa0l870pJOKFyHN695jhRE5RHxgtt8
         nc52IWKZtV//CwtJP9tIvmMZTklH6ZV8moYpHZ1TuhCfPhuUaSBF7i7GeAa6wD3AqpLE
         xu6m2NW0kERdP6yHRufkm8eiqWfWVaf63QRvksR4GU8dTH9jn4p7SyCOFlieqrff4owr
         ElJMHS0dBm+b2AIzB0DNL8l6MuNPbS/2qWr+jzInGij0C8zly5uoz+z9dck3CDFuBA4Z
         /zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274937; x=1788879737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2tJApUzC1LEzp8M/eTL2SHChylQhCDDbwAQQxkGsv0=;
        b=jxGlbPfhGRcRQkZtCPXsChBZWa8ruEcMpxxOJeIBEu6Jogu8jQtaYEyGpVG0dEow90
         10Jli6Qg8odkNZaPENCDhz4UlNdqG3dv/LuyzEDnTkH/5Izm49RZ5Brg1/cc7Fnfrzle
         d+3tjcozZ+luM01tD2R6V47JfwoAsQNaeNj8xXP9QMQ7MLWuRomzOT3XHNL+/XSC4ca7
         92m1p0FTwCDMirAlMZJgDB2PymAsKJL6bVWWazV2NViJM29978s2+S0fpZCBAWFkaQ8B
         30/3/CMuzru8EhGw6EdzW+C8y1NRLH53rJ41EFyWF9qPGHDtcHq3DN0nhUr+h62sbFjx
         HsDA==
X-Forwarded-Encrypted: i=1; AHgh+RrY4I1nnIj29JOX7Oq/UVr2e7vmWGLW90iXCFaeavr2qba7hkkb3jHtdahDmPvYAzLWG2mQlSM=@vger.kernel.org
X-Gm-Message-State: AFuF++lRgPvPMur9uEGguBkdnexEPZlONeLy/uFfl4HTI9xxWFffnmWj
	2KFNZA8/mcF7jiHY2FVpoqsH41KxOz9ObIKgfO6E5GYrb3Vk1rN/CccX
X-Gm-Gg: AR+sD11e8ApJPAi02GqxH75OwvE4ipeC53er82LVxSsJU8C5q8JUCbGv0OOtwWXkDl4
	NE3n4B+1LP3Ldzdu31wdTvYmZ5ADfBNGqiu/JxQNjMw/4dsCyft0QOPNMcmuOM7MKaILSiK+3e1
	UXBRx36BnhPHkjyWxsntl5yT6uYupI3gdib3vXGz3bAwvevRTwoDKoA/BlsFhmmOpkR4dohTDea
	nLTH+ULWnHwVTXXeJODB5hPcsMS7I13jHGdSNGg7qZnOlp319foLYJGmcJZaeaHc8CbI3s3Mocz
	D8JrrbPJNaj1iuPNMHPBrsv+j6d02Ur1ycThdsQ2RV6mJmpZ4OiPiPyomfZegMKGMHLW12exsky
	s3lgzimNwhGuAgAwCXaphqQ8TCojM7Ju/x4FpOdNIBFvb0xkY3mFDzDuvCLfedIHTVwvrI5EeXl
	BwhSC8VRgttOo+WQYSZBOFwTkksQ7ZuTsFU+1p04FrH7YAdavdngIkvKOnNVk=
X-Received: by 2002:a05:6a00:3397:b0:85b:cf16:597 with SMTP id d2e1a72fcca58-85bcf1605c8mr9714948b3a.19.1788274935860;
        Tue, 01 Sep 2026 08:02:15 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0716846sm27914b3a.45.2026.09.01.08.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:02:14 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v3 02/10] dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel property
Date: Tue,  1 Sep 2026 23:01:02 +0800
Message-ID: <20260901150111.141037-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901150111.141037-1-coiaprant@gmail.com>
References: <20260901150111.141037-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On RK3568, the SGMII interface can be routed to either GMAC0 or
GMAC1 via the pipe_sgmii_mac_sel bit in the pipe GRF registers.

Add the optional "rockchip,sgmii-mac-sel" property to allow the
device tree to select which GMAC controller is used for SGMII.

The property takes a value of 0 (GMAC0) or 1 (GMAC1). The hardware
reset value is 1 (GMAC1), but this can be overridden by setting the
property to 0 for boards where SGMII is connected to GMAC0.

This is necessary for boards such as the Ariaboard Photonicat, where
the SGMII interface is connected to GMAC0 and needs to be explicitly
configured.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../bindings/phy/phy-rockchip-naneng-combphy.yaml   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index 379b08bd9e97a..8e898bce9af73 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -80,6 +80,15 @@ properties:
     description:
       Some additional pipe settings are accessed through GRF regs.
 
+  rockchip,sgmii-mac-sel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 1
+    description:
+      Select gmac0 or gmac1 to be used as SGMII controller.
+      The hardware reset value is GMAC1 (1). Set this to 0 to route
+      SGMII to GMAC0.
+
   "#phy-cells":
     const: 1
 
@@ -105,6 +114,10 @@ allOf:
           maxItems: 1
         reset-names:
           maxItems: 1
+        rockchip,sgmii-mac-sel: true
+    else:
+      properties:
+        rockchip,sgmii-mac-sel: false
   - if:
       properties:
         compatible:
-- 
2.47.3

