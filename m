Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB444CAF5
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397299; cv=none; b=tLqyvqPSWGdnElzUb4FeVLGlbHzEc6bu97RFzTMVJFO+NMtuaN8Lzx0jUPDu4bwdtj4ufhlDlVIaPgAs7CKrcMmWKcC7XxNDzc5c9C7MvN+9JKodW2bvshkJCMxA+jB9fKIm3DgRQy88V/fNmQr/bh5gCywUgSHrjMlvz4pjgB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397299; c=relaxed/simple;
	bh=HDHSlk3KLUIPpWplLfl8Wf2wljrrBnVMe8jXLwvhSqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XstIuY7IVPhpp0Sc8e5yf0uILjWGI8yf1GvzDQBl4KheKQFAplBu8/iFoV2UzHhqd7XrfecfIFMAcsi/0+3APOLjaDYuQ5nd/BnmPHF0SDuEKe2ITPfaEPru0vXrKNZhBGUxdOpMtsAZSIZYF7FuZSt38rpbvTd84ip2IALyyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebVff0Ad; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebVff0Ad"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506251815a3so97977021cf.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777397297; x=1778002097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdjqUV89jaR2dHNfUhp+QYSj5dY+OQxHEYWbWKpO/FE=;
        b=ebVff0AdGHoWC08FQ0CctWKGvk7apeIaWk8OBqgEmw6ZoJ2o3/3Eam7q2oFrB0AhGe
         4zr+tH53opazm1KfdjzZ831QTtKgjBc7iENJmqBp33inDjZFjlmnS99BRHOxLH4LFHNs
         bysAypyMv4U3Z5xovnqIeCs/KpbOS+n8QEb4x8qkj1yUtsWKv7Pab3jojwO/5HSkuKoO
         +YH3sqgazV/aoAt7WVQ8kUi74ZEXe0cnKt//JT3lZS4+9utlcjZ6qvIHoc8Z6iaTFb1Y
         Ztu74XoRkbclS69Wd8VKcFEpt9sO3pHrF6WI91RjcDdZ/c+iiojCq4n34W3uGrj8gBt6
         9YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397297; x=1778002097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdjqUV89jaR2dHNfUhp+QYSj5dY+OQxHEYWbWKpO/FE=;
        b=Howfnb4vys5bI0mURWuGCXqOjulgDc282vL7B0ovr4LrSFYwWboHryTEeWhYQ9650C
         5jgDzuJAygC5/zTxt1RniMBVNx1CRp9KlDgRoCj+tcIEixQumuOlCo176vUPGrEx5A3Z
         qAOFbUdKK/xPLsL8wnAcrH1q5GRBq44/zKS08f5Os9+KbU+2vmezVv652IfCB9gb99h6
         yl5HWQbXH/mbV7v5MOt1FV00VIS/WZXYbEcdSKRsKjKFBo838rAzzU79fR3tM1kOn/Md
         JSZV3syEat/6YnIL2yumQqBOEz1zgDKzX6/CmA5KUnRLa3nCkG4dWM2H06XekExZHqxC
         Pf1w==
X-Forwarded-Encrypted: i=1; AFNElJ/JPsoPF9CICjeul1dLyM7b5hyEj8qJJjh7g+FAC25ljlLiYQS29DglJR1N7RMbMDut6qzejhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvpofkoaFoFcqqT4t3A1xGrTydBis8xwM55MNwULPzlEY6E1eg
	JtZ2SJrJnRW5FGf3P3voI6anRzxG/HjYXfqHlH7IOEJcenPRDlbwbHK9
X-Gm-Gg: AeBDiet1Yyqv8K5DDG47MPbi9b1G/SsaAlUEJQlg0jttgkznIaIakYZ00YH0Rxg/Zb0
	sV+cavjlc4rC2oxePe0MHpWRrxm/AugNlgEGToeUkEgL6RBAtjMgU4YpNDdBi3nxJR5GsSqqamR
	BnRnuTsAY5SwaxSCCvS3JvkkMD1566J/ZClfS6Qf5x1cYGtsHOhoZKWiW+mXoZMgA8OksQTBP3+
	WBOfSATVFDmE5JEnZQ4iwb+IeczeQRcRAQ8N60cc/FGxoOtOUy9o1DbyAFdz8Oz1e4b0P5Cn+RW
	P/bQkQXQwfMl+K/Q3gO+T2bxC00Hx/rVoF5AGamolv6uxgXvU2aTRLaA63ui1g8Ld/fBngylV8n
	0a0Nj6CjjuupIdhGQXVSMAmFHIta8s+DI+DNA4vMZTSAt/ctntA1/z5Df4rjROt3MPGGfjFeio0
	ogj8OwoLYLZy80FDw14DzUMoKD2i13jNAtE7mr5NiVOX7/4/wbY6ZmDSh+Fsz3aki3ygk=
X-Received: by 2002:a05:622a:580c:b0:50b:37a1:a012 with SMTP id d75a77b69052e-5100e1c6516mr55040421cf.41.1777397296798;
        Tue, 28 Apr 2026 10:28:16 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e299d76asm26253676d6.48.2026.04.28.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:28:16 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: eth: fbnic: Add pma read and write access
Date: Tue, 28 Apr 2026 13:28:10 -0400
Message-ID: <20260428172810.175077-5-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
References: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Document the MDIO interface topology with an ASCII diagram
showing the MAC, PCS (MMD 3), FEC, Separated PMA (MMD 8), and PMD
(MMD 1) blocks and their interconnects. The diagram illustrates how
4 lanes connect the MAC through PCS, FEC, and PMA, then narrow to
2 lanes at the PMD.

The c45 read and write routines are enhanced to support
read and write of the separated PMA for the fbnic.

Co-developed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h  |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 71 ++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 81794bd326e1..64b958df7774 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -805,6 +805,7 @@ enum {
 #define FBNIC_CSR_END_PCS		0x10668 /* CSR section delimiter */
 
 #define FBNIC_CSR_START_RSFEC		0x10800 /* CSR section delimiter */
+#define FBNIC_RSFEC_CONTROL(n)	(0x10800 + 8 * (n))	/* 0x42000 + 32*n */
 
 /* We have 4 RSFEC engines present in our part, however we are only using 1.
  * As such only CCW(0) and NCCW(0) will never be non-zero and the other
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index 18c12508a0c4..b01ca40e8a44 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -7,6 +7,25 @@
 #include "fbnic.h"
 #include "fbnic_netdev.h"
 
+/* fbnic MDIO Interface Layout
+ *
+ *        +-------------------+
+ *        |        MAC        |
+ *        +-------------------+
+ *            |   |   |   |  <-- 25GMII, 50GMII, or CGMII
+ *        +-------------------+
+ *  MMD 3 |        PCS        |
+ *        +-------------------+
+ *        |        FEC        |
+ *        +-------------------+
+ *  MMD 8 |  Separated PMA    |
+ *        +-------------------+
+ *              |       |     <-- PMD Service Interface
+ *        +-------------------+
+ *  MMD 1 |        PMD        |
+ *        +-------------------+
+ */
+
 #define DW_VENDOR		BIT(15)
 #define FBNIC_PCS_VENDOR	BIT(9)
 #define FBNIC_PCS_ZERO_MASK	(DW_VENDOR - FBNIC_PCS_VENDOR)
@@ -105,6 +124,32 @@ fbnic_mdio_read_pcs(struct fbnic_dev *fbd, int addr, int regnum)
 	return ret;
 }
 
+static int
+fbnic_mdio_read_pma(struct fbnic_dev *fbd, int addr, int regnum)
+{
+	int ret = 0;
+
+	/* We will need access to both PMA instances to get config info */
+	if (addr >= 2)
+		return 0;
+
+	switch (regnum) {
+	case MDIO_PMA_RSFEC_CTRL ... MDIO_PMA_RSFEC_LANE_MAP:
+		ret = fbnic_rd32(fbd, FBNIC_RSFEC_CONTROL(addr) +
+				 regnum - MDIO_PMA_RSFEC_CTRL);
+		break;
+	default:
+		ret = fbnic_mdio_ids(MP_FBNIC_XPCS_PMA_100G_ID, regnum);
+		break;
+	}
+
+	dev_dbg(fbd->dev,
+		"SWMII PMA Rd: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, ret);
+
+	return ret;
+}
+
 static int
 fbnic_mdio_read_c45(struct mii_bus *bus, int addr, int devnum, int regnum)
 {
@@ -116,6 +161,9 @@ fbnic_mdio_read_c45(struct mii_bus *bus, int addr, int devnum, int regnum)
 	if (devnum == MDIO_MMD_PCS)
 		return fbnic_mdio_read_pcs(fbd, addr, regnum);
 
+	if (devnum == MDIO_MMD_SEP_PMA1)
+		return fbnic_mdio_read_pma(fbd, addr, regnum);
+
 	return 0;
 }
 
@@ -149,6 +197,26 @@ fbnic_mdio_write_pcs(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
 	fbnic_wr32(fbd, FBNIC_PCS_PAGE(addr) + regnum, val);
 }
 
+static void
+fbnic_mdio_write_pma(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
+{
+	dev_dbg(fbd->dev,
+		"SWMII PMA Wr: Addr: %d RegNum: %d Value: 0x%04x\n",
+		addr, regnum, val);
+
+	if (addr >= 2)
+		return;
+
+	switch (regnum) {
+	case MDIO_PMA_RSFEC_CTRL ... MDIO_PMA_RSFEC_LANE_MAP:
+		fbnic_wr32(fbd, FBNIC_RSFEC_CONTROL(addr) +
+				regnum - MDIO_PMA_RSFEC_CTRL, val);
+		break;
+	default:
+		break;
+	}
+}
+
 static int
 fbnic_mdio_write_c45(struct mii_bus *bus, int addr, int devnum,
 		     int regnum, u16 val)
@@ -161,6 +229,9 @@ fbnic_mdio_write_c45(struct mii_bus *bus, int addr, int devnum,
 	if (devnum == MDIO_MMD_PCS)
 		fbnic_mdio_write_pcs(fbd, addr, regnum, val);
 
+	if (devnum == MDIO_MMD_SEP_PMA1)
+		fbnic_mdio_write_pma(fbd, addr, regnum, val);
+
 	return 0;
 }
 
-- 
2.43.0

