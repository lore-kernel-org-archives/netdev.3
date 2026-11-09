Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235754;
	b=U0rDKDRxJTPBOWQxqpKVa7Z5rR/LBVQnj6Xy9P0+2+IWnRzDry2ZaqTIufbMBMR1aSx7
	 4FrPSWKKdCFhFwGkxmpiuvBrDJJwNrk9XE9iy4kXF2yQTszim6xl/TIv9Gx+jgMrigLkK
	 ywhyaieJdX7YpdgiqsO118kCiqjB5tLrMhI/c1IbkrY9WSucmJ9Jkp8Ilh05U1xVGL8U/
	 wmYZoE6s++CtGDjVCp9pIrK6hZj7EspYGNT5OJ5NfMdiCFvoGuScGHiGvYugssua3lIsT
	 4bEl5tjxxPCUvFStQWVPTIjS/mIODatuKqC00mYbz1qZlz+dr8GfTMma6qA9PSlnpCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235754;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5YgZ9DsB3zSM/Trq6vFjN0hFNxSxLNqKUjoqOa8muPg=;
	b=gaYbCjrfKODQnrkF+WrQx/nxVSHHYN86Gd759AkGg/7vJgllX4QP9dXzEUfIRB9QpxrY
	 uLZo4DkdoFP0n8EQbOt88CwC2BlLq9UXZOAfejG7pHvfi/4pTcCJGG0A+idIpzi5pJ5Qe
	 xx4o6O7UU5Y2GL/WwFfoVJpdS1oiYlAjds8/S3wjOhxY3pCOOZKeNFJ+tqr0QGXL59bq+
	 AEJyMmS72K28eeLzjzIU0HPpzdVEmRKILYpF6OO3QHdNpmLHlgKvZjqgOMajoGJuOvyGW
	 e8r1gmUUoAz478afCZYEZMj8iLL0YuPkXdkT5ZhRVgTWDt7dujT30tKH+oU30eZrdNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=A3479sUD;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=XW1AEf7a;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C6606A321;
	Mon,  9 Nov 2026 14:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF3C6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=A3479sUD;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=XW1AEf7a
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9EN34g957267;
	Mon, 9 Nov 2026 09:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=5YgZ9DsB3zSM/Trq
	6vFjN0hFNxSxLNqKUjoqOa8muPg=; b=A3479sUDLkegaxxJiglwXrQOIwKvqloI
	zIUW5OV5+I75WuPvNrKOdQTYgNjImlkFq+SBHS5xRFxY39sWOuxs6A0yBt8UxlEa
	r5/54vdszYPWx/ndVbDXS0Oyp5i6ZKxoa7NrEEFF1S0IgAaGEf7WMaBewPlEqL+E
	3+JfzpoiDF2JJK/O8OFA6Kv8iNfl2OjHw0miWR8nx6EBBhx+4zi7Mb2GLf6JlOvM
	kqkPJN3kJWtUUOPyfoNik9xxrgC7KL0Aedlbj0SLxsoGPLO0Sg2QFFIfxOPbBNmD
	41pFLVUKWVL51Uz9DKF1GUw1exqn8wytjIbF/oHWHCo+mSCsvnQMKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5YgZ9DsB3zSM/Trq6vFjN0hFNxS
	xLNqKUjoqOa8muPg=; b=XW1AEf7aLWs1lg0LSqvGp8HrgpUpNCxSd9+Qa88i8Uq
	7tzoof/s6DmqTEcjjIIdoQgWPyMYoe9Uz/+j7vGHii6AdSvGvFQ05DQXahWMpsCQ
	YCseMq8uztfgoigSOz1GXE8tIeMPqo/alvxCZUeEFdT8C5oTEFKPEULsRSHRvm3Z
	tw+sx5fUUvQ2VFXOTv9bpqEPb7xMwP2D5ifVBA7mv5myPmWy6bFcLgf66AwB8se9
	HTx2i+7MgLPlwVSFZ16FpKzpnDF5k7qCYzY5SkEiuk3OW12gDLjH+yCojl6uWhBv
	jr/x8KoOlfZCZurQoZoZL8gg2xP18A0gM1qamE5BPzQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hufw007yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 09:48:57 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A9EmuCu027042
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 09:48:56 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 09:48:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 09:48:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 09:48:56 -0500
Received: from HYB-6AVb5If9qTU.tail230d3d.ts.net (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.41])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A9EmcNM025728;
	Mon, 9 Nov 2026 09:48:43 -0500
From: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefan Eichenberger
	<eichest@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Subject: [PATCH net v2] net: phy: c45: select BASE-T1 type for the forced speed
Date: Mon, 9 Nov 2026 16:48:37 +0200
Message-ID: <20261109144837.738619-1-iustin.stolniceanu@analog.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: RpdlgAug7x65dcsCCOoibpGE4bl8IhcJ
X-Proofpoint-ORIG-GUID: RpdlgAug7x65dcsCCOoibpGE4bl8IhcJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX5tU0zs4cfid6
 1thA+BNU6NHa4rLZg0rxnVi4nmC1N291oJZ2AEEK0ZSTEwl82axvQvR4JLUJsFm5wGvtLHi6MSc
 WU27j6iTYUi+B/4UWggMp9z/n3IJ7JcWuCAppjjK690EWePdW0s1R4bK63mJY3EzpWUg/Kb3G1i
 zyA1hIQbql+S/jnniKnyQiz6xwYEJIyF13OH72J6h7yUGRCMug+yC8NXjIS7gqLK3wIxIFcll7u
 5PACTvhdhQO52xJfj6mKx+DT1jyoN+47OPLLUs6TE7G2FYaNvX89wOTpgl47518IPDdxXoXECKY
 q+v6J11z4CJqyBPrtN1wRo6nPYfUQTPeqbDGUghzzst16mLF7iGrWmTDQmZlHwHvHMlpiHLtHwO
 4bTH/2H3TNguS9jiyxOr3IWhD4eQrWbFa2qVpKHeljO7FmpczmsO8YGT0N15Sn/nWYHC+tsiqCv
 5+CrIZjdma2Ht9g6xug==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX0fXogKLOAdf5
 tUb0Ym6tXUIeMuPE2ASBDHQm9qGJJrCLcJAVpWSQhp+m15j9+AQ60KoHLbcmCZdDwYD7VtFDVxm
 wQfJNXM+erJDXVuFXkJvUnsN+swZfZfiwyehxtk3Huk6SLNjsbKf
X-Authority-Analysis: v=2.4 cv=IuiL47/g c=1 sm=1 tr=0 ts=6af1dd59 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=kTs4aKTdxJRZGFSXfREA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090058

Commit 25108a834e14 ("net: phy: c45: add support for 1000BASE-T1 forced
setup") made genphy_c45_pma_setup_forced() write the type selection
field (bits 3:0) of the BASE-T1 PMA/PMD control register (1.2100) on
every forced setup: 1000BASE-T1 for SPEED_1000, and 0 for everything
else. 0 selects 100BASE-T1, so forcing a 10BASE-T1L PHY to 10 Mbit/s
now also switches its PMA to 100BASE-T1, a mode it does not implement.

Seen on an ADIN1110 (internal ADIN1100 PHY): after

  ethtool -s ethX autoneg off speed 10 master-slave forced-master

1.2100 reads 0xc000 instead of the 0xc002. Since the field is not
restored by re-enabling autoneg, the PHY keeps the wrong type until
the next forced setup or reset.

Add a helper that returns the type selection value for the forced speed
and the supported link modes: 100BASE-T1, 1000BASE-T1, and 10BASE-T1L or
10BASE-T1S for SPEED_10 depending on the supported 10 Mbit/s modes. Fail
with -EINVAL when no type matches instead of writing 100BASE-T1. This
also applies to forced 2.5G, 5G and 10G on BASE-T1 capable PHYs, for
which there are no link modes yet.

The field is called "type selection" in IEEE 802.3-2022 (45.2.1.214,
Table 45-178). Keep the old STRAP names as aliases.

Tested on EVAL-ADIN1110EBZ: with this change, forcing 10 Mbit/s writes
1.2100 = 0xc002 (10BASE-T1L) instead of the invalid 0xc000.

Fixes: 25108a834e14 ("net: phy: c45: add support for 1000BASE-T1 forced setup")
Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
Changes in v2 (review by Andrew Lunn):
- Name the type selection values after 802.3-2022 (Table 45-178) and
  define all of them, including 2.5GBASE-T1, 5GBASE-T1 and 10GBASE-T1.
  The old STRAP name comes from 6f1c646d88c5 and is kept as an alias
  for userspace.
- Add a helper that returns the type selection for the forced speed and
  the supported link modes, also covering 10BASE-T1S. It returns
  -EINVAL when no type matches instead of writing 100BASE-T1, which
  also applies to forced 2.5G, 5G and 10G on BASE-T1 capable PHYs.
- Resolve the type before the first register write, so a failure leaves
  the PHY untouched (reported by the Sashiko review bot).
- Retitle the patch, as it is no longer specific to 10BASE-T1L.
- Link to v1: https://lore.kernel.org/r/20261104152534.1425241-1-iustin.stolniceanu@analog.com

 drivers/net/phy/phy-c45.c | 46 ++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/mdio.h | 13 +++++++++--
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 870920311f9a..8334678df841 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -104,6 +104,36 @@ int genphy_c45_pma_baset1_setup_master_slave(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_pma_baset1_setup_master_slave);
 
+/* Type selection value for the BASE-T1 PMA/PMD control register (1.2100,
+ * 802.3-2022 Table 45-178) matching the forced speed. 10 Mbit/s is ambiguous
+ * between 10BASE-T1L and 10BASE-T1S, so the supported link modes decide.
+ * 2.5G, 5G and 10GBASE-T1 are not handled as there are no link modes for them
+ * yet.
+ */
+static int genphy_c45_baset1_type_sel(struct phy_device *phydev)
+{
+	switch (phydev->speed) {
+	case SPEED_100:
+		return MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_100BT1;
+	case SPEED_1000:
+		return MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_1000BT1;
+	case SPEED_10:
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
+				      phydev->supported))
+			return MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_10BT1L;
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1S_Full_BIT,
+				      phydev->supported) ||
+		    linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1S_Half_BIT,
+				      phydev->supported) ||
+		    linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT,
+				      phydev->supported))
+			return MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_10BT1S;
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
 /**
  * genphy_c45_pma_setup_forced - configures a forced speed
  * @phydev: target phy_device struct
@@ -166,6 +196,16 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
 		return -EINVAL;
 	}
 
+	/* Resolve the type before the first write, so a speed without a
+	 * matching type leaves the PHY untouched.
+	 */
+	bt1_ctrl = 0;
+	if (genphy_c45_baset1_able(phydev)) {
+		bt1_ctrl = genphy_c45_baset1_type_sel(phydev);
+		if (bt1_ctrl < 0)
+			return bt1_ctrl;
+	}
+
 	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, ctrl1);
 	if (ret < 0)
 		return ret;
@@ -179,12 +219,8 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
 		if (ret < 0)
 			return ret;
 
-		bt1_ctrl = 0;
-		if (phydev->speed == SPEED_1000)
-			bt1_ctrl = MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000;
-
 		ret = phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1_CTRL,
-				     MDIO_PMA_PMD_BT1_CTRL_STRAP, bt1_ctrl);
+				     MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL, bt1_ctrl);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 06f4bc3c20c7..2806f60ed105 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -417,8 +417,17 @@
 #define MDIO_AN_10BT1_AN_STAT_LPA_EEE_T1L	0x4000 /* 10BASE-T1L LP EEE ability advertisement */
 
 /* BASE-T1 PMA/PMD control register */
-#define MDIO_PMA_PMD_BT1_CTRL_STRAP		0x000F /* Type selection (Strap) */
-#define MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000	0x0001 /* Select 1000BASE-T1 */
+#define MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL		0x000F /* Type selection */
+#define MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_100BT1	0x0000 /* Select 100BASE-T1 */
+#define MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_1000BT1	0x0001 /* Select 1000BASE-T1 */
+#define MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_10BT1L	0x0002 /* Select 10BASE-T1L */
+#define MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_10BT1S	0x0003 /* Select 10BASE-T1S */
+#define MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_2P5GBT1	0x0004 /* Select 2.5GBASE-T1 */
+#define MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_5GBT1	0x0005 /* Select 5GBASE-T1 */
+#define MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_10GBT1	0x0006 /* Select 10GBASE-T1 */
+/* Legacy names, kept for userspace */
+#define MDIO_PMA_PMD_BT1_CTRL_STRAP		MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL
+#define MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000	MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_1000BT1
 #define MDIO_PMA_PMD_BT1_CTRL_CFG_MST		0x4000 /* MASTER-SLAVE config value */
 
 /* 1000BASE-T1 PCS control register */

base-commit: 241dec6f9ab74d8c3ef246764f3611666b96b9e1
-- 
2.43.0

