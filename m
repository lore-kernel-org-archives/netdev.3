Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622095;
	b=lrvIOHHEfmh8A6C+gGeUWx5Xs1RxuYxUUP7It+8tp/ASp69huF1qlA+3mmLArjFbdQ+j
	 DpjibudGDKZsqXYcoYreyz5owYJ3Ppe3Z96Zfhp6JuHXF46thtp7HhvqdZARpTyp1jo1g
	 zVlNofz3XACmJRLiTbB1foflzT4wXKwIl10MXZbTUE9X32hFIVseDzPcMWJ8M+l6VCxBe
	 J9HjsBm5IOURCmrrwkcQSse7rNywpBMYAIDqKwNMjdgnzQiO+wN4TgSx8t8HRQIb2faw2
	 J4xiqDDSSQMqM2f5h3NuArVxqK6Ezx7rbOCoRdtvr9xsU+oZZHGvgyDkBHxxKXXh2Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622095;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=KyxfxjW/8VDPKJgBAnzu1y19pEFt/f6bAY6Eie7zFQ8=;
	b=pnlBjR6tdbaCFe1uHawg7s0faTz2Ug9S5TUXa7QGItwAqYmgC38hhDEe/B++Ik2KYOPD
	 dgqNzXYBefwpZOlyBAH+ueyryTXf9ke7mYXJHWEZ6ZqbFAze8UMZdMhTiyzXU043tLPa3
	 XZlDk18rbh9Lw6ZhZ7ST0MToA66W/DCgslmZHgQWMphi2NC6t8iFrA+oZ6jsXJzcib3+p
	 TjL4SB48HlUKhxyEqdghdVWmiY6jcfYVpO4/CD5BfuKbtlTzSPkVxNbi9DAm2ZsQi2Jk8
	 FyeheV6VhpECGEDVpJARZSNINbt/PU12i8Hw8GiPIlL6UK/j4iXpIH+mQ8p+yrf3rTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=I80Nnq4m;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F08606A33D;
	Mon,  2 Nov 2026 12:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72F08606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=I80Nnq4m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793622094; x=1825158094;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jbs1hV8RpQNtB6iGB5BNnN+jReoKu4QeubwuJTVpu4I=;
  b=I80Nnq4mHbLeL4E2xUIhOzQ0ZxQtR42lSiZMBEwPvSc/gHJVdq8aEV+e
   HevkN5X0jMrRZmxRALRYa7X8HLoOYj0ntQjMHR/XLLQEIlSdKTmkZIqqi
   zLyWlL38z4zElhlR7wMLl7b5X+lrxZC3aZyIgVE744bXZ2xqZKDsLyD4k
   NgP4v9i9ZF2501VMTEIcF6LzrCUjgMTLX+54TskdyDUDFbyW01yiJlCFU
   XlGniI2Dn86rzh9o0SSE1LQJri9DNXSEoE+OWQUHuFs3r9Lqj8vLVMgcZ
   wD7pcJQZAbG3NkiGDT5MW0AVfepvpiDqt3F1Lomes9PYU5xmfYTAynGZp
   Q==;
X-CSE-ConnectionGUID: bffwQnA3Rnmq0lQzbNJzTA==
X-CSE-MsgGUID: t5yxBdrDRm+gUiLSnXkC3Q==
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="232950949"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2026 05:21:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 2 Nov 2026 05:21:33 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 2 Nov 2026 05:21:31 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 2 Nov 2026 13:21:24 +0100
Subject: [PATCH net-next v2 1/5] net: sparx5: Drop redundant POL_ prefix
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
Message-ID: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-1-3bd47ec1b227@microchip.com>
References: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
In-Reply-To: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
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

