Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E5192D97;
	Tue, 17 Mar 2026 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734577; cv=none; b=McvUrhSCoPRStmKudZwR6mk/YRe0UknZrqCGSsqOTk+CPjsol00StI+G2oQ+92j+J3zAjDF6cZjtD7vAU3QXWHRzi0FalMgupt8Hc7YYmAd01r1a4oxX+dLCqKFaMyTm4fa9BWcjDvFjB/CKXd5JoQoajYxPifnCW99tQLQ4EMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734577; c=relaxed/simple;
	bh=Fs6kGPlYcuRPzQ4A1YkvjL1EjGLW9fewcz/aUiikuys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5N0+WUuwtqzMZ4Lo+SlCmFL/9kT0r/xgmwHB6JipSskCGdu2xuoEpmXy8ZgA9J8xGFxCR9Qv2Uih+cznRN+y+YU92tbdGT73QYQ4I8h29uHrlukp2DwmWY/7m7wXjHZ6hXJCFudYGF2lsmq0rlNJLlmErz+w4WDV4MoBRTKlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D613FC2BCAF;
	Tue, 17 Mar 2026 08:02:54 +0000 (UTC)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/2] dt-bindings: net: micrel: KSZ8041RNLI supports LED mode
Date: Tue, 17 Mar 2026 09:02:46 +0100
Message-ID: <efad6c7e024b3a9aa2882db65909ee5bbbcbdc45.1773734298.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773734298.git.geert+renesas@glider.be>
References: <cover.1773734298.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Micrel KSZ8041RNLI supports LED mode, just like KSZ8041.

This fixes (a.o.) the following "make dtbs_check" warning:

    arch/arm/boot/dts/renesas/r8a7791-koelsch.dtb: ethernet-phy@1 (ethernet-phy-id0022.1537): False schema does not allow 1
	    from schema $id: http://devicetree.org/schemas/net/micrel.yaml

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v2:
  - Add Reviewed-by, Acked-by,
  - Fix KSZ8041RLNI typo.
---
 Documentation/devicetree/bindings/net/micrel.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
index 5d25f0d0a508a6df..6fa568057b927182 100644
--- a/Documentation/devicetree/bindings/net/micrel.yaml
+++ b/Documentation/devicetree/bindings/net/micrel.yaml
@@ -54,6 +54,7 @@ properties:
       KSZ8021: register 0x1f, bits 5..4
       KSZ8031: register 0x1f, bits 5..4
       KSZ8041: register 0x1e, bits 15..14
+      KSZ8041RNLI: register 0x1e, bits 15..14
       KSZ8051: register 0x1f, bits 5..4
       KSZ8081: register 0x1f, bits 5..4
       KSZ8091: register 0x1f, bits 5..4
@@ -80,6 +81,7 @@ allOf:
             contains:
               enum:
                 - ethernet-phy-id0022.1510
+                - ethernet-phy-id0022.1537
                 - ethernet-phy-id0022.1550
                 - ethernet-phy-id0022.1555
                 - ethernet-phy-id0022.1556
-- 
2.43.0

