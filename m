Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B993C1974;
	Mon, 10 Aug 2026 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366494; cv=none; b=i9Nq0b/hzB+aVyOBZ7gK88q/LhXkkrc/jlGKGuJQ0vAzkAQAES6r0hmeATx/j2d3uvpMwqPRqePdKBUVmBOWkOKAeU28R5akgwTj+FpUNaj9Smw9V+SjJ6hafkwNLAAcy5t9POK7vnYED1sYtngPCWmlSKv2Lgs3XcmsAwdGnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366494; c=relaxed/simple;
	bh=zc/RDvDVK4DufbmJwMGIGnQ3RA75fdRCPw8hS2Yw/9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fK1x61zYBrqqo1j7G20MBy+4p8amIAVXedHq4qEjjye8ljCeZqnQOwSBNp470dIgobOscc3XmqatyYFyrH7HMCB3x7bPaHDFGvn5ucZZLgitS/3hAhYOiOeNJdihL9LS3PwWzV1qRH+XEJxYZtTBP/sOdJbCLNaB6vyu3jUwpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg5nEjGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg5nEjGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499371F000E9;
	Mon, 10 Aug 2026 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786366493;
	bh=wYUL9JULG5KyBd66yTm1qDSHFyVxoNVEIMssJeQFfYk=;
	h=From:To:Cc:Subject:Date;
	b=cg5nEjGm/HKWJmnkQs0GAECTRDh/dBv9X/mR4Zh4rEKHVdF7ObDvQTUWBtK1OWyb9
	 9TJot6apUwToPfsKlUvkfzRbSyHcbao5+8HO09omIxfT44hGAUqcUTVmkueommW4Ej
	 pLWIKHmAkg+ZpfJ7AWIlB3Yy2Fc++a1I8CMkdFvI2PUGzB90Zqqk87jkwU3VwbY4IM
	 S+ldDUDNpW1w1gZFgvFbNTRKZCcNkqmkTu4B/SvZ3mYJSXpFRs5qR3QJz9TdacB4se
	 ZTg4knVAQTnjMrCoZvq77NILb/2cfhvGP9i84pePxYbphOeZoarrBlWgSSkTN4Hbmm
	 GB5PwC4/TwKTQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: netdev@vger.kernel.org
Cc: dinguyen@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH] MAINTAINERS: update entry for socfpga dwmac and gmii/sgmii
Date: Mon, 10 Aug 2026 07:54:15 -0500
Message-ID: <20260810125415.1717893-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mathew Gerlach is no longer at Altera, so remove his entry as a
maintainer for the SoCFPGA DWMAC ethernet glue layer and the GMII/SGMII
dt-bindings files.

Maxime Chevalier has volunteered to maintain the dt-bindgings YAML files
as well.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
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
index 5114e6db7307d..04e7fd1861037 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3597,15 +3597,11 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
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

