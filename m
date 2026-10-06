Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3634466AEF;
	Tue,  6 Oct 2026 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294694; cv=none; b=byRhPryEJ/PtrLvo7ZeSiFt9SZclLgefk8spivduL1hRY28hXC3+DFjdpO79jqPnJVGH7lUMVdwr/X+7vdVXqM0nGN+2lLmeDEm8EMVTJKs9H+dqEEjizIT1HwjO059Ody1Ok03XuYz2yV3RFms9Hmq3YbXFn320Nk4UEB6yf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294694; c=relaxed/simple;
	bh=EmJMagxo52eNRrqh62LCxmNSKdkejMZ+JW2o+3bzEVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=U3MfkB/9f7iHKtE97Vo5sChj3JRdYlkN34o3nR0/U+d//CYt6Y+ML7WPryGLX5X3WTA7grV4sPD6wn6jRHhr/N8suFyoUTX6NdYsAlxlWSd5c8I5qRPP8alLGJiipugonrkXVclFUM8oKBqXHoRpXGO291/Xcx0C+2TRwcgwS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y06Dewo+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y06Dewo+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791294693; x=1822830693;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EmJMagxo52eNRrqh62LCxmNSKdkejMZ+JW2o+3bzEVo=;
  b=Y06Dewo+zfiI1AJ7SqtYa1bnd9Y8bHsE2zTp8nq1p+2fugAbnvdT1K4X
   RampsOt1eh7baqwi/pfhvFQRhPTX4PVTUWBxFXAYQKvI9VxoHd4OWzCDf
   y6bkiD2i5FohHrRI6oWF3pUq98H0zrcOu1iPYZw+3NN8Q0FeWioMTcsO8
   2tY3ovFWD5JPBnr9v66thN08awzIsOgKhxDkWdM3iN7YAwBuEjKkZ1GW5
   +refRDeVEUDqK38tis6r8kwMdVLeVltqxESqVn1RlI5Z2VtlRA6US1OEH
   zIbiATtoOWRDRsXigJxjSD+zCx4WbGNuBoT1f6GT4BdbfOqyZjyRiNiTS
   Q==;
X-CSE-ConnectionGUID: tJGzYeDVTyGjXQCFJvwVNA==
X-CSE-MsgGUID: XW8Cd2mhRriVpGBiwm4A4w==
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="296059985"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2026 06:51:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 6 Oct 2026 06:51:29 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 6 Oct 2026 06:51:27 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 6 Oct 2026 15:51:07 +0200
Subject: [PATCH net-next 2/3] net: sparx5: Move TAS link speed
 configuration to sparx5_tas.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-sparx5-tas-v1-2-5eef1126dfd5@microchip.com>
References: <20261006-sparx5-tas-v1-0-5eef1126dfd5@microchip.com>
In-Reply-To: <20261006-sparx5-tas-v1-0-5eef1126dfd5@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Richard Cochran <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>
X-Mailer: b4 0.14.3

Move sparx5_tas_speed() and its link speed enum from sparx5_qos.c to a
new sparx5_tas.c, which the following TAS offload patch builds on.

No functional change.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/Makefile     |  2 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  3 ++
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c | 49 -------------------
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h |  1 -
 drivers/net/ethernet/microchip/sparx5/sparx5_tas.c | 56 ++++++++++++++++++++++
 5 files changed, 60 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
index d447f9e84d92..06cf583effdb 100644
--- a/drivers/net/ethernet/microchip/sparx5/Makefile
+++ b/drivers/net/ethernet/microchip/sparx5/Makefile
@@ -11,7 +11,7 @@ sparx5-switch-y  := sparx5_main.o sparx5_packet.o \
  sparx5_ptp.o sparx5_pgid.o sparx5_tc.o sparx5_qos.o \
  sparx5_vcap_impl.o sparx5_vcap_ag_api.o sparx5_tc_flower.o \
  sparx5_tc_matchall.o sparx5_pool.o sparx5_sdlb.o sparx5_police.o \
- sparx5_psfp.o sparx5_mirror.o sparx5_regs.o
+ sparx5_psfp.o sparx5_mirror.o sparx5_regs.o sparx5_tas.o
 
 sparx5-switch-$(CONFIG_SPARX5_DCB) += sparx5_dcb.o
 sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 0f7d8440f614..41e0597a8d48 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -707,6 +707,9 @@ void sparx5_psfp_init(struct sparx5 *sparx5);
 void sparx5_new_base_time(struct sparx5 *sparx5, const u32 cycle_time,
 			  const ktime_t org_base_time, ktime_t *new_base_time);
 
+/* sparx5_tas.c */
+void sparx5_tas_speed(struct sparx5_port *port, int speed);
+
 /* sparx5_mirror.c */
 int sparx5_mirror_add(struct sparx5_mall_entry *entry);
 void sparx5_mirror_del(struct sparx5_mall_entry *entry);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
index 972da8a71f5a..e580670f3992 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
@@ -9,17 +9,6 @@
 #include "sparx5_main.h"
 #include "sparx5_qos.h"
 
-enum sparx5_tas_link_speed {
-	TAS_SPEED_NO_GB,
-	TAS_SPEED_10,
-	TAS_SPEED_100,
-	TAS_SPEED_1000,
-	TAS_SPEED_2500,
-	TAS_SPEED_5000,
-	TAS_SPEED_10000,
-	TAS_SPEED_25000,
-};
-
 /* Calculate new base_time based on cycle_time.
  *
  * The hardware requires a base_time that is always in the future.
@@ -592,41 +581,3 @@ int sparx5_tc_ets_del(struct sparx5_port *port)
 
 	return sparx5_dwrr_conf_set(port, &dwrr);
 }
-
-void sparx5_tas_speed(struct sparx5_port *port, int speed)
-{
-	struct sparx5 *sparx5 = port->sparx5;
-	u8 spd;
-
-	switch (speed) {
-	case SPEED_10:
-		spd = TAS_SPEED_10;
-		break;
-	case SPEED_100:
-		spd = TAS_SPEED_100;
-		break;
-	case SPEED_1000:
-		spd = TAS_SPEED_1000;
-		break;
-	case SPEED_2500:
-		spd = TAS_SPEED_2500;
-		break;
-	case SPEED_5000:
-		spd = TAS_SPEED_5000;
-		break;
-	case SPEED_10000:
-		spd = TAS_SPEED_10000;
-		break;
-	case SPEED_25000:
-		spd = TAS_SPEED_25000;
-		break;
-	default:
-		netdev_err(port->ndev, "TAS: Unsupported speed: %d\n", speed);
-		return;
-	}
-
-	spx5_rmw(HSCH_TAS_PROFILE_CONFIG_LINK_SPEED_SET(spd),
-		 HSCH_TAS_PROFILE_CONFIG_LINK_SPEED,
-		 sparx5,
-		 HSCH_TAS_PROFILE_CONFIG(port->portno));
-}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
index a92a699c551f..04f76f1e23f6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
@@ -60,7 +60,6 @@ struct sparx5_dwrr {
 };
 
 int sparx5_qos_init(struct sparx5 *sparx5);
-void sparx5_tas_speed(struct sparx5_port *port, int speed);
 
 /* Multi-Queue Priority */
 int sparx5_tc_mqprio_add(struct net_device *ndev, u8 num_tc);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c
new file mode 100644
index 000000000000..3637d4b48ad6
--- /dev/null
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip Sparx5 Switch driver
+ *
+ * Copyright (c) 2026 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include "sparx5_main.h"
+
+enum sparx5_tas_link_speed {
+	TAS_SPEED_NO_GB,
+	TAS_SPEED_10,
+	TAS_SPEED_100,
+	TAS_SPEED_1000,
+	TAS_SPEED_2500,
+	TAS_SPEED_5000,
+	TAS_SPEED_10000,
+	TAS_SPEED_25000,
+};
+
+void sparx5_tas_speed(struct sparx5_port *port, int speed)
+{
+	struct sparx5 *sparx5 = port->sparx5;
+	u8 spd;
+
+	switch (speed) {
+	case SPEED_10:
+		spd = TAS_SPEED_10;
+		break;
+	case SPEED_100:
+		spd = TAS_SPEED_100;
+		break;
+	case SPEED_1000:
+		spd = TAS_SPEED_1000;
+		break;
+	case SPEED_2500:
+		spd = TAS_SPEED_2500;
+		break;
+	case SPEED_5000:
+		spd = TAS_SPEED_5000;
+		break;
+	case SPEED_10000:
+		spd = TAS_SPEED_10000;
+		break;
+	case SPEED_25000:
+		spd = TAS_SPEED_25000;
+		break;
+	default:
+		netdev_err(port->ndev, "TAS: Unsupported speed: %d\n", speed);
+		return;
+	}
+
+	spx5_rmw(HSCH_TAS_PROFILE_CONFIG_LINK_SPEED_SET(spd),
+		 HSCH_TAS_PROFILE_CONFIG_LINK_SPEED,
+		 sparx5,
+		 HSCH_TAS_PROFILE_CONFIG(port->portno));
+}

-- 
2.34.1

