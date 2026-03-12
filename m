Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6A23ABAA;
	Thu, 12 Mar 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322069; cv=none; b=JOAi0nExeV1wUZWXQ2kciwUuTFbYbT2Zbfc9IPBZZFvtJNfUJG/mezbxcJKRykGBO3KTGOTDb9nDCn0M/IrEN6TBZCM7ZoSZePt/PgZjyrc3zIhj7pKZVC6Kp99js3RuuieZNhX7vKMQvNO2uN8qLoLbrrWywMAbhxwZLeSR1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322069; c=relaxed/simple;
	bh=235BRwd3Pxj/NQnpnHqGP0r6TpefiVuAekr1ybYj0d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoUwt78FjZsedfPbpYwimMFB8x1rnnvMv2mZWJKAxg12s7R7nf7HInyPwzSZdd9gzV/Au9cWcLfmE9/R9juECBXunQo/Kv5w2oh5HBp33Y8rgs3EZ6uAuV1bsDWis1qm6B0gQqQWQLXeS3Mnfl43nFKvrf5lKEHyKRr5XzMn5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A73BC19424;
	Thu, 12 Mar 2026 13:27:46 +0000 (UTC)
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
Subject: [PATCH 2/2] dt-bindings: net: micrel: KSZ8041RNLI supports LED mode
Date: Thu, 12 Mar 2026 14:27:36 +0100
Message-ID: <6ccda7a00f250e87b0457e276ac1070cb0708d71.1773321267.git.geert+renesas@glider.be>
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

Micrel KSZ8041RNLI supports LED mode, just like KSZ8041.

This fixes (a.o.) the following "make dtbs_check" warning:

    arch/arm/boot/dts/renesas/r8a7791-koelsch.dtb: ethernet-phy@1 (ethernet-phy-id0022.1537): False schema does not allow 1
	    from schema $id: http://devicetree.org/schemas/net/micrel.yaml

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/net/micrel.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
index 5d25f0d0a508a6df..7fb61c78d16cd801 100644
--- a/Documentation/devicetree/bindings/net/micrel.yaml
+++ b/Documentation/devicetree/bindings/net/micrel.yaml
@@ -54,6 +54,7 @@ properties:
       KSZ8021: register 0x1f, bits 5..4
       KSZ8031: register 0x1f, bits 5..4
       KSZ8041: register 0x1e, bits 15..14
+      KSZ8041RLNI: register 0x1e, bits 15..14
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

