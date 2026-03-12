Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA623ABAA;
	Thu, 12 Mar 2026 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322066; cv=none; b=moXgrNAkxtAtcnfkwCPtUO+zdpX3fNfX4zxV0TS9WXUq9UXZfjNYATb/Dau+k/GyoQUjJcTOepecfP1hfMqV0wGtSAU/5CCC/xmLgS29eMlPkwKUiaq49wWhPHRctPKg4adeMt1SdRlBfUxT+EiQWma0gTbr9nmOVL+UkpeS0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322066; c=relaxed/simple;
	bh=PMuq0d619zLnf605dOIgYWaoWO3YMKevU3rSbsPzSFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsHjIkRQUOiI2gaSg/xveB1hpVbmqSBwMpIzxqu2wOBzGmEPc8wqBdy51SHGv3Z59aJZzcQcI4MkywOBHcQ4N/+uiV0qQX1DncsmDjUkr65JaBNkAYQdg2VAZru2rt2pBagjnO+ysdcRRokotulXrrNcWzI8S8WDrzcwsmYlQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957E8C19424;
	Thu, 12 Mar 2026 13:27:43 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Stefan Eichenberger <eichest@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] dt-bindings: net: micrel: Sort lists
Date: Thu, 12 Mar 2026 14:27:35 +0100
Message-ID: <013afe74bef9a4d4af8b5a204cb4891518f7274d.1773321267.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773321267.git.geert+renesas@glider.be>
References: <cover.1773321267.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort lists of PHY models and compatible values alphabetically.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/net/micrel.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
index ecc00169ef805dc2..5d25f0d0a508a6df 100644
--- a/Documentation/devicetree/bindings/net/micrel.yaml
+++ b/Documentation/devicetree/bindings/net/micrel.yaml
@@ -51,9 +51,9 @@ properties:
       bits that are currently supported:
 
       KSZ8001: register 0x1e, bits 15..14
-      KSZ8041: register 0x1e, bits 15..14
       KSZ8021: register 0x1f, bits 5..4
       KSZ8031: register 0x1f, bits 5..4
+      KSZ8041: register 0x1e, bits 15..14
       KSZ8051: register 0x1f, bits 5..4
       KSZ8081: register 0x1f, bits 5..4
       KSZ8091: register 0x1f, bits 5..4
@@ -80,9 +80,9 @@ allOf:
             contains:
               enum:
                 - ethernet-phy-id0022.1510
+                - ethernet-phy-id0022.1550
                 - ethernet-phy-id0022.1555
                 - ethernet-phy-id0022.1556
-                - ethernet-phy-id0022.1550
                 - ethernet-phy-id0022.1560
                 - ethernet-phy-id0022.161a
     then:
-- 
2.43.0

