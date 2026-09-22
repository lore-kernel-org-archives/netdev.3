Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465784A093F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107456; cv=none; b=r/WGiRIdASgKHHrIm86U8SPrXE5eF5zTfCktmUYpZIrihutUxwZf2pwLhLrAUJz+zAqo2ZN3TRVfohjzpBTmzZ2BF8E+EEeBZWEoNUIpuOhFT9XUy65cN063r6AGZj+T2YIqDBMz74TdJ0vZEj/4xGXjcCLl0uCmi4luhqhfx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107456; c=relaxed/simple;
	bh=RQ8/bIf5S9U/FiX3uQoU1u6/FV6K7LLD2uqZys3J7EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPK6XXDlEIBP6Kr9g3J35H83IH+WRiF0ucN8wgAS/OL7Se8s9mFFR6zz/GW2KsYd5Gm+H5RsdpWVxP8z/qhC7jTb8Kb9vzzwi+2uHN/1z96XrQAT33KxKc9u6+rdth87HABwV9pyTIOZHC7E1HSVCIof0Ts/tx1ldgwfHafFIdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7aTeVc/; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7aTeVc/"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf5e516e67so453925ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107443; x=1790712243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2tJApUzC1LEzp8M/eTL2SHChylQhCDDbwAQQxkGsv0=;
        b=d7aTeVc/rk4js/lhi6D2RU1PbGqx6YqBvY1FyIV+qBrBrNci13RLNSCH6AAxKUfcYu
         eYlZSXIjycIoUCL9bVE6qk235DIIXtBYJbkbVXKQS/60OX5eeUbHhI6OZTs/MCxEMAcy
         plpBCqvGEmu9Aq8IzAG4RW1eJVxAUvfdoF74lfQvvSFZ8oSz8VeQ5RLGqub75CJ0dnDr
         Z8RkzeRFwgiuxVwSWhnadv2HGkzyI7c2x1bHWRWfiFlT/osiGJLOrCyhKxlyv1w8E3FT
         vguKvMyZrVMnBVDOk6UoW95lgEN8v9eRkLffkrzVt033KdumaYvTD2YgdJ7xvYqAPYT8
         p7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107443; x=1790712243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2tJApUzC1LEzp8M/eTL2SHChylQhCDDbwAQQxkGsv0=;
        b=UUe2j1BPkSfLjJcaNCAt1LqLJ2aSoZzF+CaYWyuZ+DGq0E4wfzQpGhNPupRv+eYOqK
         uwq1DkokoedW1KPCkseLPXYuCEOx0oFg6PTY5h/MUNBGh09oGkyaha1t7CyEsHXOOfDv
         BvBBQxO7sFr31rgvXXCFJO7K1BFp2vs/pYgBl5c+V52auiSdCX9pcOwdP10VDdkJeJ1h
         +nO7qTyKCUM0K9aFlE9oGcFq6o2rpFC23KvOH+jHDUozOkgmHLkYNLET2AZG4WlLMS4i
         vFaUGtewSJ+GY2WCIpi2LTVw0vmNquEoCClyuLyy3dn3IjqvKgTrlRAnXfwV7AQD61uH
         j84Q==
X-Forwarded-Encrypted: i=1; AKwUvByplvxu0Xy+eGQmpfceBSlahh2H1//tcExdHi+xOP5j1pkrfJWawDoQs+lEocyjfvt1hqEVp2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kPKzjROlQqFg6WI8VxFQKqzThJemNt0oQXjIsoLkxVxLa8Doxo
	ssU4EUrnDNitRYkhyPbtk0rbkkYGWbghweM2ppctbC7gmkOOmsGWGvhgH1Q32spbJcNXkg==
X-Gm-Gg: AYBFou1AwID6HydIuAegdzdLvZ3abCmmtqkRNS9T7DgL8ZabWsgmIyYVvHzyPaLR4pW
	e4dgmb/Hd7lDeuZWygnGNEAyBPFKxyfMpfkX8wNO3fiIhzAtZpXUSOC/6GA3Z9JfxgCNPY7IloH
	dbg8DwmCabIrE8VLiffk0gtFZwCbwjFfez2F4Gf6Z/ieueEqOHtjtLaH01CQw9Z2r627aqVr5Ns
	cwcr1f3iNARz6GaUSvXVzg0C/AqxPaIhODtX6d7KGv6lzMJciXCQKbxVDVB4OkFSZM/gmxqcaQf
	GQrG/83EmbrV/M8LEf9/J5JZYFW0ipCYiI+90sEGe41U2Kbq34U9E8T/Tqm6tzJXY9Q88/i+G3I
	Ag2teG9mW2PN4/A09VrraeCj6dGkW6zzMoaJL3n9nhQgJ0gFq3QMJWyzfxCURaahuYJE1OiWwxH
	2xbhy0BLbwHOoDmE73y2krREXjL+kU7nMZAkXGJuZzXWBwtYOddQb2sQaU+MExgX8OQ4G7yw==
X-Received: by 2002:a17:902:d4c5:b0:2d9:68b7:c324 with SMTP id d9443c01a7336-2df69d368e1mr4567765ad.3.1790107443277;
        Tue, 22 Sep 2026 13:04:03 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm654515ad.64.2026.09.22.13.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:04:02 -0700 (PDT)
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
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v10 02/11] dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel property
Date: Wed, 23 Sep 2026 04:03:26 +0800
Message-ID: <20260922200336.2201212-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922200336.2201212-1-coiaprant@gmail.com>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
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

