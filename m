Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884791;
	b=1mdR0iX4/o+4DT6gtoUmZiZnAQYak5ANWVZie2WzmyVySPprNxHqZzUHGH2SS1hRWwAz
	 sOzY99wGR61yvpGqyWmlH0ooXYFiWyrcOFVbtmKZjjHWIR/DkjwCFJd/HDEmfwh3G4hNP
	 2kFDjUQI+tDWZjReq606FOmfSftDPdsu0u+V/nL3kH/hVRSC2+jHE9GKR1iu/AnvV3ikf
	 0eVWycWiXYNIBvkN+zh0bf5cPogn/57CN7nTrxvDEJpSg27oL9b88hUDCY1PfCD7ykTWW
	 9Xwg3DzhktUaTU7nF8KHs8sXp8T0d12ukLmlRXQcHwIFMY+/UDfCOnCXK3wd9jWUyyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884791;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=KyxfxjW/8VDPKJgBAnzu1y19pEFt/f6bAY6Eie7zFQ8=;
	b=QVrrWgO84rx2ZJrCsp4fVE6xtGB0ZGs+X0MApdhpHCZZHGyWN7WPqd5y9XlV29w9eMqj
	 +rbZ/9Zx6zTszkOBxrCX5/278l4tcfdqte/Bb7aQFFT7p8v1vVprF2Bh5ZMLvRpzlL1NI
	 ytkvSJdAx/bSjkMcaoM0SQXaAC+D9D4Hvv2P3wfNN+RITZn1TinDEaUTTUD75vTSV5iZu
	 vsa2bLz4J7jG91vUb0NcxAX/Dv/hBLfwM0EB1+hiH3ZH7n0JkUtI0I4434rJNsm6qTl1a
	 /ejW7QWuFuZVk810Im6aLHJraBPhHYFmwlE68qHbnzdfAtp8FuoN5PSt54A5j1Te3fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=umQULWz2;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21083606A331;
	Thu,  5 Nov 2026 13:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21083606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=umQULWz2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793884798; x=1825420798;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jbs1hV8RpQNtB6iGB5BNnN+jReoKu4QeubwuJTVpu4I=;
  b=umQULWz2yt1oc30ba7YBY4yBJ4nfu59lScFT5LPybr1B+dbRmWwdQnTk
   LZnJwObOpJfRKLuBOm5MQHicQgwWzd//C2DWmBMwrG3S/EQPC6RvIyHkd
   E8qIOA+3Qo5eTDNUF3Grx+trInxcAoxEl9mg2TScIn0DISe6/hr1DR3Dz
   duKzGrSx7agMrJIkonkh7JTrRGI1aIdKvcj8W4zmFSEzyxYLdaRSfrGxt
   hrCinJ3o1om+HuOs4Fu93PovuEgoyiQXtLzwuXKXwz6IWdNPj+WVfUNGo
   r5lLx5O8Rt1Yu/63r+V6IFBX27GgVLuaMBdOaFZtWlidpH9LxymA/7Wbz
   g==;
X-CSE-ConnectionGUID: l3viPxNyQEyhuYbassbLqA==
X-CSE-MsgGUID: u9Ad0Q3eSLm1K1O6penkeg==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="76685348"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2026 06:19:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 5 Nov 2026 06:19:49 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Nov 2026 06:19:47 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Nov 2026 14:19:35 +0100
Subject: [PATCH net-next v3 1/5] net: sparx5: Drop redundant POL_ prefix
 from POL_UPD_INT_CFG
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-1-b45a3a26bed5@microchip.com>
References: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
In-Reply-To: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <robert.marko@sartura.hr>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

The macros for the ANA_AC_POL:POL_UPD_INT_CFG register are named
ANA_AC_POL_POL_UPD_INT_CFG*, repeating the POL_ prefix that is already
part of the target name.

Rename them to ANA_AC_POL_UPD_INT_CFG*, so that the port policer
registers added in the next patch can use the same short form.

No functional change.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c      |  6 +++---
 drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index e039f5369b95e..68c80c63f9087 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -616,10 +616,10 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
 		 sparx5,
 		 HSCH_TAS_STATEMACHINE_CFG);
 
-	spx5_rmw(ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT_SET(pol_upd_int),
-		 ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT,
+	spx5_rmw(ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT_SET(pol_upd_int),
+		 ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT,
 		 sparx5,
-		 ANA_AC_POL_POL_UPD_INT_CFG);
+		 ANA_AC_POL_UPD_INT_CFG);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index 1464fd1a1d447..219c7f0e516e9 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -939,15 +939,15 @@ extern const struct sparx5_regs *regs;
 	FIELD_GET(ANA_ACL_SEC_LOOKUP_STICKY_SEC_TYPE_MAC_ETYPE_STICKY, x)
 
 /* ANA_AC_POL:POL_ALL_CFG:POL_UPD_INT_CFG */
-#define ANA_AC_POL_POL_UPD_INT_CFG                                             \
+#define ANA_AC_POL_UPD_INT_CFG                                                 \
 	__REG(TARGET_ANA_AC_POL, 0, 1, regs->gaddr[GA_ANA_AC_POL_POL_ALL_CFG], \
 	      0, 1, 1160, 1148, 0, 1, 4)
 
-#define ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT   GENMASK(9, 0)
-#define ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT_SET(x)\
-	FIELD_PREP(ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT, x)
-#define ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT_GET(x)\
-	FIELD_GET(ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT, x)
+#define ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT       GENMASK(9, 0)
+#define ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT_SET(x)\
+	FIELD_PREP(ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT, x)
+#define ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT_GET(x)\
+	FIELD_GET(ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT, x)
 
 /* ANA_AC_POL:COMMON_BDLB:DLB_CTRL */
 #define ANA_AC_POL_BDLB_DLB_CTRL                                               \

-- 
2.34.1

