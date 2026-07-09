Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA13AC0C9
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623843; cv=none; b=Z/1CNWna1HtJLhhAyDbmj63IISqAq6eagurZmgTXSjdwyJ7sYFyKHJwMOPjWsXHOee1UHITNa9ha4zosbmVvUtw/9mLUIkM0cOnXYB7eA13ZCsU3jNkORfDY9mCoa2MQZLPmQhkudVlqW6vSdFCWCzdlPECHIsXQbyMAlrH4GJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623843; c=relaxed/simple;
	bh=CxPMzaITnPkkWGGN055P4Bv2uTyYJu0CR569f0T/KzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmZyb2nP06OB6PmaJCijz+POvdv5yCUfBqW4TWDyFps+JyMtqP2GPb6NAwAQCCa5JQhytNGvTjcljdl6xSoEqBEzr0qlQ4IEHP7DyfLCk9PVBL50q+3+nBiwULwNjt3kLLUEjEA0WzwsOEG/Ri72uUigTBZbf4RxWgwTmSRaiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=j4a/Alaz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breiti.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b="j4a/Alaz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c59f740cso1025925e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1783623840; x=1784228640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1cFyhFd1WTGzP7I6nzPK+Il5As21ayHbm0nJT4NpM4=;
        b=j4a/Alaz0eV+smwIF91VVKlFveTQf33JpVT5EiMVUUw62ZBpMzPmhVPpVVG+t4bHQF
         qEimVUkIiuLykCTQ+e5U2oqBoZa+SjbPm+1nKWQVlMXwlpgBrj1FpPCj+UDWwo9HLM+L
         7m4Fbrh9y+47DoMXX4/3Uo0fDLUSVB+G8baFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623840; x=1784228640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1cFyhFd1WTGzP7I6nzPK+Il5As21ayHbm0nJT4NpM4=;
        b=PSzKbxn8aG3+qSOMCw76rZwbSsMGSOY10oceuTRhYkJm6MlmDB/jImTglToRWRYE8v
         A6qoUR6v1WnT+DreuRXc4yVfUSi26jkg+mhPsfGLZLozzy3HXqU+hSax+Xbitsv/Juqd
         ocqMxmbuYZEN/xQZZ06UXTecKOUI8Ti3YMAo2J5S4SCXk718I7s/9ijmmQ+Hi+OqhY9y
         6qYsOyI2DNg7vMAmjlwtLoRfBHtLZrxiUmYK3F/enzLR9uOF8kIA6FMUmeY+leA2WMS6
         eqSj8+6kssB38u7Xs0JOyjc6my0ZTrlrkQfFCW+5V3HpIi2qkLY8daR4gwxDC18DB7oK
         w2FA==
X-Gm-Message-State: AOJu0YyPoSh3mMmx7tEVjJBQkdguSFb9WR71XINm9dY14tXycV+zHwU0
	gF3Cq+BpWFLhLqq/WaavksOKr/mJWiajlxlthePGcdAZnJORYFiYSquRvtJuwZkcPNq+HScMHSu
	0NVYn1+iu
X-Gm-Gg: AfdE7clWqDU2pt7afPIAaSW2hffZYRwEPuHoSf5eiQ2KO4B7qH7dFIDQliJ6FDDv8N5
	OfMCWetkcY0ICZVufHPpTh3EkETkAZm2VJ0bM51bKA2+eFb743yniyJisvKIhEkBP1HPVPaZGXj
	vj6uo7ZBGK/j6PWX3ULuCGh9y5F8bDl+hW0OLGuZzf5zZX7+GCy2Lq2RSXWiUizSDhlm/SWq6eB
	YfN9cFfkRFiFsCnoi9FXviT9gcgn01bItWhZaPmNcTAj/6Mm4pD3l+JBCnYT2D/nKAGYNEiG/Si
	+CaDOIdpp80vl8fJKvzDrRgiSsVN8IrnZv/O3LoIkom88T1atB529kUNdXN6WZ7mlTrofrX7AcS
	EWWePAXfZuq84ZAusoq4YeYRIKnBSl8T7dQhSU6fnNxgKB/hK+KZqj4yCOQiGleUJZcc1ARH3PP
	l2VQ1YbDfJO/cqGPWO23WzVxEgtFPbR23toABI4RFGxnm9pYGMxw==
X-Received: by 2002:a05:600c:4e0e:b0:490:e60b:6860 with SMTP id 5b1f17b1804b1-493e6892ea6mr77245815e9.7.1783623839625;
        Thu, 09 Jul 2026 12:03:59 -0700 (PDT)
Received: from framework.casa.breiti.cc ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3c42sm81810125e9.1.2026.07.09.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:03:59 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Markus Breitenberger <bre@keba.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: intel: gate SerDes reconfig on rate
Date: Thu,  9 Jul 2026 21:03:29 +0200
Message-ID: <20260709190329.124432-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Breitenberger <bre@keba.com>

intel_mac_finish() is registered as the phylink mac_finish()
callback for the Elkhart Lake SGMII ports. phylink calls it at
the end of every major link reconfiguration, including the
initial one during probe.

The callback selects the PMC ModPHY LCPLL programming for the
requested MAC-side interface and then power-cycles the SerDes.
On Elkhart Lake that ModPHY is also used by the on-die AHCI
SATA PHY. Reapplying the programming during the initial
boot-time link-up disturbs the shared analog block while it is
still driving SATA, so the SATA link fails to train:

  ata1: SATA link down (SStatus 1 SControl 300)

The disk carrying the root filesystem is never detected and the
system hangs at rootwait. Ethernet itself comes up normally,
which makes the failure look unrelated to the network driver.

Before mac_finish() runs, the legacy SerDes power-up path has
already programmed SERDES_GCR0 for the current interface. The
1G and 2.5G ModPHY tables selected by mac_finish() correspond
to the SerDes lane rate, so read that rate back from SERDES_GCR0
and skip the PMC reprogramming and SerDes power-cycle when it
already matches the selected interface.

This keeps the disruptive reprogramming out of the boot path
when the SerDes is configured correctly, while preserving the
previous behavior when a real SGMII/1000BASE-X to 2500BASE-X
rate change is needed. If the register read fails, reconfigure
as before.

Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Markus Breitenberger <bre@keba.com>
---
v2:
  - Read the current SerDes lane rate from SERDES_GCR0 instead of
    comparing against cached phy_interface state.
  - Rework the commit message to clarify the SerDes power-up path and
    the rate readback check.
  - Keep the previous reconfiguration behavior if the SERDES_GCR0 read
    fails.

v1: https://lore.kernel.org/netdev/20260706061954.94842-1-bre@breiti.cc/

 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index b8d467ba6d72..fa0113597c97 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -525,6 +525,31 @@ static int intel_set_reg_access(const struct pmc_serdes_regs *regs, int max_regs
 	return ret;
 }
 
+/* Return true if the SerDes lane rate must change to serve @interface.
+ * If the current rate cannot be determined, reconfigure as before.
+ */
+static bool intel_serdes_needs_reconfig(struct stmmac_priv *priv,
+					struct intel_priv_data *intel_priv,
+					phy_interface_t interface)
+{
+	u32 cur_rate, want_rate;
+	int data;
+
+	if (!intel_priv->mdio_adhoc_addr)
+		return true;
+
+	data = mdiobus_read(priv->mii, intel_priv->mdio_adhoc_addr,
+			    SERDES_GCR0);
+	if (data < 0)
+		return true;
+
+	cur_rate = (data & SERDES_RATE_MASK) >> SERDES_RATE_PCIE_SHIFT;
+	want_rate = interface == PHY_INTERFACE_MODE_2500BASEX ?
+			SERDES_RATE_PCIE_GEN2 : SERDES_RATE_PCIE_GEN1;
+
+	return cur_rate != want_rate;
+}
+
 static int intel_mac_finish(struct net_device *ndev,
 			    void *intel_data,
 			    unsigned int mode,
@@ -536,6 +561,9 @@ static int intel_mac_finish(struct net_device *ndev,
 	int max_regs = 0;
 	int ret = 0;
 
+	if (!intel_serdes_needs_reconfig(priv, intel_priv, interface))
+		return 0;
+
 	ret = intel_tsn_lane_is_available(ndev, intel_priv);
 	if (ret < 0) {
 		netdev_info(priv->dev, "No TSN lane available to set the registers.\n");
-- 
2.55.0

