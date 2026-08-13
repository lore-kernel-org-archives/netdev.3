Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A512EF66B;
	Thu, 13 Aug 2026 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582564; cv=none; b=pwm+bfJ6PyHwJtVlQi2GRh+scg9sXZiwsuYCQlq+wfOUyPXwDs4EUQOPTeymRh30yUGgt5krWpLtHolggEinJ4pzoMcu4QK5wy16zcfeOfPeuiHXus1J5oQC15lqamXk0daYPNJZU4yEZRS3u1Gl3iT/r7qVeuVxBMIrSwohOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582564; c=relaxed/simple;
	bh=CXHdTJ4g5JRsF/hTak7c81GJX9UKxgx15VK5XK3jtO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InJEIDxCsgs4UltP3GhqOevnaI3uZhsXWXZ6bgT9K6MJmiH5EpleGQzcXPSvCP/eEFe5SpadYbSCr7xGd2Wqu0tI5GWyEKhArlceyXPMf3xh6LrpXR+CT+BqK/XmQepXZ+guV1tjDdYRT6ljfBWONC1rRDk7LA2IAbh0wHX613k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq6qsr2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq6qsr2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8322C1F000E9;
	Thu, 13 Aug 2026 00:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582563;
	bh=sfxtpfCP4GxBgz0G/HgVqMh03qm3bVNokZPi2GnRH+c=;
	h=From:To:Cc:Subject:Date;
	b=fq6qsr2MM9PK5b4qpo+SKQSOH19XtgJypNFjxbs6aIpmCFJep6raWl39eTtG7jn85
	 6Ey4aKeiBk7seTVz0ubAQw4WieSfAaH+/jTVeBJeVvYemUaJ8uP+1iRoWAJHkMlgRv
	 5H4iShi2PsKNJLJORvZ0cyLqP4iKhrpdhY/ZC0d1BGx/MmYB1BRyE5WsMR6qlaMr5c
	 puSlEoXW0MQbEwW6O/D9V6KME8z/3vYi2py61Tq8oXFoCgKf2i5SWq0KRUQ4p7xtTY
	 tgbXpgBsyfM1iqB9mov0+N7i91snvj0eg9yBiFQRpJ/kdLPJAkLte5o+mqyUqzVDRD
	 44ELHrGJMkBRQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: dinguyen@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCHv2] MAINTAINERS: update entry for socfpga dwmac and gmii/sgmii
Date: Wed, 12 Aug 2026 19:55:36 -0500
Message-ID: <20260813005536.2068392-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matthew Gerlach is no longer at Altera, so remove his entry as a
maintainer for the SoCFPGA DWMAC ethernet glue layer and the GMII/SGMII
dt-bindings files.

Maxime Chevallier has volunteered to maintain the dt-bindings YAML files
as well.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: include Maxime Chevallier in message
    s/Mathew/Matthew
    s/Chevalier/Chevallier
---
 .../devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml   | 2 +-
 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml      | 2 +-
 MAINTAINERS                                               | 8 ++------
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
index aafb6447b6c22..cfb53080dba26 100644
--- a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
+++ b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Altera GMII to SGMII Converter
 
 maintainers:
-  - Matthew Gerlach <matthew.gerlach@altera.com>
+  - Maxime Chevallier <maxime.chevallier@bootlin.com>
 
 description:
   This binding describes the Altera GMII to SGMII converter.
diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index fc445ad5a1f1a..8f5d63bb2187a 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Altera SOCFPGA SoC DWMAC controller
 
 maintainers:
-  - Matthew Gerlach <matthew.gerlach@altera.com>
+  - Maxime Chevallier <maxime.chevallier@bootlin.com>
 
 description:
   This binding describes the Altera SOCFPGA SoC implementation of the
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253ed..e5ac94395670c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3588,15 +3588,11 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/clk/socfpga/
 
-ARM/SOCFPGA DWMAC GLUE LAYER BINDINGS
-M:	Matthew Gerlach <matthew.gerlach@altera.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
-F:	Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
-
 ARM/SOCFPGA DWMAC GLUE LAYER
 M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
+F:	Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
 
 ARM/SOCFPGA EDAC BINDINGS
-- 
2.42.0.411.g813d9a9188

