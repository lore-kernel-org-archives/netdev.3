Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7430E3CC337
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822322; cv=none; b=fD7TN7SrKA9ufVTsJCodyAv/mAC9mI9ECKBD0Lkc8/fb7W3Lww1CtRxpKsghZ+P4IvQBnxQNmo7lQVIe4+GtDjJ1oBEOkVE8xSaJPaYCwYz5/0/KVVaAcapjDpAug6rG4/uYZeWTN4efRuJlW5v93HOL1FAWDi6mAN/veJ8snCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822322; c=relaxed/simple;
	bh=RQ8/bIf5S9U/FiX3uQoU1u6/FV6K7LLD2uqZys3J7EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i812/XRQe9uRbV2yZS/VitAczcC1Ds6ma0JVEJjJ9oW0f159CGOTrKBjNT6z0TofqlqiQMM9jdcZyRmbjKwuwiQ9SrCPGrQrf3BzSDMBiYGt9JOAEv0r5xXz6Ogwf6KFvqGlRr3tgVGEqy+ovr2f7n7eI3DrNDED7KqU6mkEZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuWINVYZ; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuWINVYZ"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc53988d9f3so807376a12.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 05:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789822321; x=1790427121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2tJApUzC1LEzp8M/eTL2SHChylQhCDDbwAQQxkGsv0=;
        b=iuWINVYZQOlRIsm5MQpniniXdaMMKlIDbcdiL2joT++n2t0GU//Ojqx4KQoIp1Y4eu
         9vyYPxwDHT9ASrHGCZFi7EbCfORmR7gUBwsr238FIBhRGk2PjL5OZQJ9idBmLfuhw538
         oYclFqhOlmE/8JtxKzog9GeCP/xlapJlRMmJTgrhzdvmSFCo3JygnG3IaBQtJ9SRDGkW
         7NLX3oSECRgndTyKgduwk+gj11qXuQ+SZNcYZRpNMUB7uBVKXOlAXzB2C787B6gZek7b
         x8Swonb/HdXDVtk4eWqKHYv+9e1sIk5gDuQ6NKsE91D4yu3WR3Nonw1nrwvxCi4pxrN9
         Kg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789822321; x=1790427121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2tJApUzC1LEzp8M/eTL2SHChylQhCDDbwAQQxkGsv0=;
        b=GYiiHjVc2F/M8zGlXB+f6HTcFGyDIRy8j9y7wY9Tt6641nrEnDe7BojnJEvk4iEWwI
         XR77wpFj8tR8fw1n/U6O8Qsc9kT0063g/a9oqRFCWaMrWWugIsmObSc1JwGgBscpP9Qd
         EOocddFSRsDd3FhUvIrYEamhfxeyRq/xrmgwfj8PetRosjesEeLCAbsDQ6ko877Ts2U4
         Xi6qcFbHtggvMSlGxD1l/cAg6MNN3WO0sELKe8IcKd6r5rzNQhnDmmwReli3HN3qub3t
         PiAf+l7fZSspYbfxvvEMpi0bIwwgNTZ7AAr4tR09Jbw1D2Iqlizg/FiOQ6tCCzIQX4sE
         9q6Q==
X-Forwarded-Encrypted: i=1; AKwUvByYKcGDZlS7+zdFiydtNiBzQU+F3v+ULBemXpbeeQKPmlKJTtH5J0D+xq0GsH+cxVKcP6hZ5Pw=@vger.kernel.org
X-Gm-Message-State: AFuF++ltltJm8W2TD8XBp0lkMm4YlUsEAfmi9RXB0LSe0kBvlCgMmaIN
	yWz0pKvd6LxzosxFScJ65CIuVcUdnx7VngAXwlRLcTJrH2mqpyZgkI5y
X-Gm-Gg: AYBFou3L28hcapolVreA/1Ya6mDSGfe3fT1R4G79zgqc/CfXXThsVwQczgm58DDSwGS
	zWlBd8esh8uc8GbskIye0cxUdiiAm3dunn9D4ui2pQOJFDbFZlBcT29LXLdZchVyugRBqcpUtq3
	i5eQSgRXDcv0aNWb7S1eVN8tqzOpCBT4wjJimpDsMa95Q5wocuxx0XqKw7rljryIjt/4t4RSwyY
	XlFLymFwodux7s/kHnIUbK22bkF7P5e2PYJkoxtZsJiKLRX2jLM7jGBtvSNxyplOcmt0NxXYucx
	bZKBji0uA4x9ALY5VQcYM0/StfVwkirFfUbYeot/T21ZmkYCyYXf2UyZu9uX1G9DzlI/qCCJkEn
	FtuGgt9j7ehztbGp7kIlkwo7zZvqRSlOh23ePw6m6cFvMMfHaG3bxW5PYkT7tlRrZ4RvsI+f3Ag
	mP5qRCrUQXnhQhcWjKixAqpmt5g8xktnL6yVKRs4SozqZ/NPEZtfaaO+ENVNaIUIet+8y+rA==
X-Received: by 2002:a05:6a00:9086:b0:878:3783:8a82 with SMTP id d2e1a72fcca58-8783783932bmr1483263b3a.52.1789822320744;
        Sat, 19 Sep 2026 05:52:00 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa0026b2sm991805b3a.44.2026.09.19.05.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:51:59 -0700 (PDT)
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
Subject: [PATCH net-next v8 02/11] dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel property
Date: Sat, 19 Sep 2026 20:51:09 +0800
Message-ID: <20260919125119.2107089-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919125119.2107089-1-coiaprant@gmail.com>
References: <20260919125119.2107089-1-coiaprant@gmail.com>
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

