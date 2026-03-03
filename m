Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D430377ECF;
	Tue,  3 Mar 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561087; cv=none; b=CXofOZtW0uGYLGmNYJ2Je6Bc2yKBcSrZY5+lmy/2msfQ1qiTkfC0jfi37e+rajkeO5hoore7UlRSlmh+q1rgSvbd6vOBuOeo6XNl4xLw6NHTAIL3LKleKUmdfIUJCI/bQyXLQ/A9aC3WphPEENYfgdQJWYxUCvA4PEWOb4X/ruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561087; c=relaxed/simple;
	bh=+i9ihgXemK48xPtyH3jRV9tFKsdf3S6xcB93Mt8ECU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAJxQ86VMIEOmENzsU5xw6r8m6NuUtdnk/OqvXA+VpmtI+ANN7NG+MlpetDAPxl+ggBkkjPaugtkv4rvycs72a40Zh4y55FJb7lacgpla+uXXkDhEiY64MpXlXqoiuGDy+HUj+NemzsERs46beD59/Fr0huQt6pwpxElLzRFgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GsjfN1zZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GsjfN1zZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772561086; x=1804097086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+i9ihgXemK48xPtyH3jRV9tFKsdf3S6xcB93Mt8ECU8=;
  b=GsjfN1zZbQkYWW7LsgipsGJYc/Js56rV4WmVTHgmsC2XTx8gnE5ByWAZ
   +VF9aSRyjAhmcdWpd04q+PAh73/mMBxeTSqSqvx/CufPWrj9bSYuZRpuK
   gMe51dOvUcOTbMqOW55l9dlgHOkMfinS6ul6KKFG1FybFFu1wBQZlHxaW
   LyEHf04XrLUQECyb47dKxmWb7vAm7L655Tda4xy/a0gxofxHj5NFuCcNG
   EkLMQ/2dWGzH9KDFGUtr65ZjHqOjQs41dNdopYhsvzNM06/41Rvv+LQvl
   2MeSCwbJp20nFuRScZVC0L+xhin5Hyei369FnD8jcMsuemQTQAAbH+E9A
   A==;
X-CSE-ConnectionGUID: GMMSakTvRG+HtI9KzbPdDQ==
X-CSE-MsgGUID: a4rAmyeaQdOEHzryB9Ha9A==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="221432062"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 11:04:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 3 Mar 2026 11:04:24 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 11:04:23 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 4/4] net: macb: add support for Microchip p64h ethernet endpoint
Date: Tue, 3 Mar 2026 10:03:18 -0800
Message-ID: <20260303180318.1814791-5-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260303180318.1814791-1-charles.perry@microchip.com>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

p64h doesn't have the USRIO register so MACB_CAPS_USRIO_DISABLED is
used.

p64h does support PTP and has the timestamping unit so
MACB_CAPS_GEM_HAS_PTP is used.

jumbo_max_len is set to 16383 (0x3FFF) as reported by the DCFG2 register
bits 0..13. The JML register also has a default value of 0x3FFF.

dma_burst_length is set to 16 because that's what most other platforms
use and it worked for me so far. There is one other mode where bursts of
up to 256 are allowed but this might impact negatively other masters on
the NOC.  The register default value is 4 (bursts up to 4).

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index cc48fd494458..d32a16e54214 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5408,6 +5408,15 @@ static const struct macb_config raspberrypi_rp1_config = {
 	.jumbo_max_len = 10240,
 };
 
+static const struct macb_config p64h_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_USRIO_DISABLED,
+	.dma_burst_length = 16,
+	.clk_init = macb_clk_init,
+	.init = init_reset_optional,
+	.jumbo_max_len = 16383,
+};
+
 static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,at91sam9260-macb", .data = &at91sam9260_config },
 	{ .compatible = "cdns,macb" },
@@ -5426,6 +5435,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,zynq-gem", .data = &zynq_config }, /* deprecated */
 	{ .compatible = "sifive,fu540-c000-gem", .data = &fu540_c000_config },
 	{ .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
+	{ .compatible = "microchip,p64h-gem", .data = &p64h_config},
 	{ .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
 	{ .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
 	{ .compatible = "mobileye,eyeq5-gem", .data = &eyeq5_config },
-- 
2.47.3

