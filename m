Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805965;
	b=h3mX3qzOMmhtXnFJqtyy2xc97F80KT5OMVwrzIX779bEvdlbHnAzdFWn04dSm+nl6FtQ
	 jOh6ur4jfyF0R3/I2Uc6hHtyBUBws0fTB9kigYWWnWted3t/Ehm4Q9Tj35zHbeWALK0yI
	 VmyGtHQs76nfaE/niytAdLASSasYbjM47w4xutR5Zmvo0dG0OZhKjpjyoK216imFQ1e4J
	 8ascfIl2K9cWoVnYgR1g63wv/6ksUN7ZDJ6XBd/bDR1lVHJyEunASDPcz0c6LX3gzPZKu
	 QbAhhLf5BEZBJOagL7e14KSJrWEW/37/tsnbst/icNqVWU6fbi0NQr2/SmGCLE3vyCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805965;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ayi7JeSxXG24mbdpRWar5qiqQmLO4gc59IBdqvork88=;
	b=LXjLYDKSBHH3mBjLJ+r5G6wWNasd+FVI8uj6WzeZ+lAZgP7FQzT2LJQHOPWqj4QJkA9q
	 T0awE6SaPvOKfRd1wzMYpI6fkFKZ6ByZCmE41qAAqGmWFY0Ky5vFHMWqEyuDWNc6AH2mf
	 OyxHZYmatgOLp3mU2TDus6HkFFgqV19cPwCBI9wM3MieuZ1pa8MYcKxmxqR5xfwCYVbJ0
	 4lsWQngkP+FevLOpSt0VIyUUis/0phTIbCxWPT9huiy9jMvgRl0KTXn9bqwkFvmW4duC6
	 FS7IwsH4J7QWnXO594umIZA3r7/ndRkpVblS2T8n2tWQyukG0Anb7YNvNFaQ8c9nqwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=gRlCeG9E;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ew4g1MRP;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DE606A339;
	Wed,  4 Nov 2026 15:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562DE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=gRlCeG9E;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ew4g1MRP
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4EIUPC2876138;
	Wed, 4 Nov 2026 10:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ayi7JeSxXG24mbdpRWar5qiqQmL
	O4gc59IBdqvork88=; b=gRlCeG9E+03lDfwWCkeT/nS3cBMfOQUJltxPovL1rzp
	HYOXduAuFzJgG5vUhpfn7O9+tn543dOze6yYeLFcrfBz+g28RZ4VRXUsCs446GIo
	cysrjANlBGIwRQ7IhGNKHhvG49YCUHJ42LEzUctWyM0SmhEc3wiYAreJU0JrnDxo
	ywpluEvXDcm14GLOTiXhiCD2MhYnCqjvDF7EJ0PunE4IQamsdOf53oYXnQxkPIRm
	R3ohEufSrzgvSnVkbQnuyDSrAEWg7zsOuH8Lhsn2UqG/gejUaXTN483xZ0iSmjyE
	xjD28fMTg6Yh7otLXCsRw4xXXCZPwi6mJn6+X+JzmoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ayi7JeSxXG24mbdpRWar5qiqQmL
	O4gc59IBdqvork88=; b=ew4g1MRPpQQONAu24W+qGgyRtFuccVRr9rPq/rGtOFz
	V3pvfos6dYg0O4yQW5ebTsez5SZLJua4LEoVotDZ8ECj6ZX/GZK+exiSXOkgvPgH
	pbDKqRFUs0W9MidKUrB/+hts+usvox4wR3LTkHRkmlayVdL2jfzNL0Lz1VRYd3Us
	zQEwM3SNglA1XB5V1gJ/KiCcN7xotzI+Z9ZdPp4UwMCd7ogn7atu8d7pfsmHpeZo
	1vCu718t+1yw1HtiaOLJtIbCv0AjKLS4LUTYz6XONYIdBvYQYh3hjuQgpvDvLXKA
	fvUb/jtPWgJVEz4AXEPTLzYGyEOa6dEWHbFA+nzXU7g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqrk4w2e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 10:25:51 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A4FPoKc017990
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 10:25:50 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 4 Nov
 2026 10:25:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Nov 2026 10:25:50 -0500
Received: from HYB-6AVb5If9qTU.ad.analog.com (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.39])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A4FPY2Q012018;
	Wed, 4 Nov 2026 10:25:39 -0500
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
Subject: [PATCH net] net: phy: c45: select 10BASE-T1L type when forcing 10 Mbit/s
Date: Wed, 4 Nov 2026 17:25:33 +0200
Message-ID: <20261104152534.1425241-1-iustin.stolniceanu@analog.com>
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
X-Proofpoint-ORIG-GUID: IcP6hChgEBx0t-zL9X7e0FFHY_2Pjj0V
X-Proofpoint-GUID: IcP6hChgEBx0t-zL9X7e0FFHY_2Pjj0V
X-Authority-Analysis: v=2.4 cv=Y7RtIReN c=1 sm=1 tr=0 ts=6aeb4e7f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=xprKiDpmGtg8Dz3ZEOAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MSBTYWx0ZWRfX+AcHj6froNue
 EEkyD8nY2CxFGIRohMjvRBx1HjTrJlAV3xoTHM2P/GVzhbbmdKJ1jznQnrWhbASX7aXC/t67jbX
 lUOs1vwQsGwWJ5vCk5W+guQZk6qz0ZXANGNLrzalH+UxH4pnpoLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MSBTYWx0ZWRfX/N6CBG5GOonw
 24MH2c/TLiDLAUDoG34eiYBHJp0YajbH3qU/xLqCwo7SNtxy5IiPS5MGc6lu7wJDEVF5H0lTI/x
 7V5cPE365SvEKxrGVTNvjzAXctTR7hBRZpQO1PrzO7m6k58rva37dQcvxT0roSRuXi/gSDyHs3L
 rmGQACyoplmoyG/8MFmrTRxDsyJSPfsKJKIRoxP0nTWcgWNh1R6NTp6xgufEhjO6NqYhU+JF5Oz
 Dv0oWe+myCKj8v2WYInfmpGICyeUfgGj4SmSNWPKwWOY6uEwOTWuVwItd41VjWQLs7wK815Ib+/
 rJ8Ue7UKsHaUucnpwwK5SiX8mGCyHm2Gxww4wmlWBtc60Ngj6RE3q6xpMBS4Yu3J5xFzDjAzOsa
 RbuYvdxh0cFZEGrLkqReCslC/OmQc+Jcdo9m781P9SIzvm2w+EYvkXrjPFMVW+SZ2JaN2DzDvyN
 r14QbFK0FYkAHiUvz5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040061

Since 25108a834e14, genphy_c45_pma_setup_forced() writes the type
selection field of the BASE-T1 PMA/PMD control register (1.2100) on
every forced setup, using 0 for anything other than 1000 Mbit/s. 0 is
100BASE-T1, which a 10BASE-T1L PHY like the ADIN1100 does not support,
so the forced link never comes up.

Select 10BASE-T1L for SPEED_10 when the PHY reports 10baseT1L_Full
support.

Tested on EVAL-ADIN1110EBZ (ADIN1110 with internal ADIN1100 PHY). After

  ethtool -s ethX autoneg off speed 10 master-slave forced-master

1.2100 reads 0xc002, it was 0xc000 before.

Fixes: 25108a834e14 ("net: phy: c45: add support for 1000BASE-T1 forced setup")
Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 drivers/net/phy/phy-c45.c | 4 ++++
 include/uapi/linux/mdio.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 870920311f9a..8671deda81c9 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -182,6 +182,10 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
 		bt1_ctrl = 0;
 		if (phydev->speed == SPEED_1000)
 			bt1_ctrl = MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000;
+		else if (phydev->speed == SPEED_10 &&
+			 linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
+					   phydev->supported))
+			bt1_ctrl = MDIO_PMA_PMD_BT1_CTRL_STRAP_B10L;
 
 		ret = phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1_CTRL,
 				     MDIO_PMA_PMD_BT1_CTRL_STRAP, bt1_ctrl);
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 06f4bc3c20c7..f46529451cc8 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -419,6 +419,7 @@
 /* BASE-T1 PMA/PMD control register */
 #define MDIO_PMA_PMD_BT1_CTRL_STRAP		0x000F /* Type selection (Strap) */
 #define MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000	0x0001 /* Select 1000BASE-T1 */
+#define MDIO_PMA_PMD_BT1_CTRL_STRAP_B10L	0x0002 /* Select 10BASE-T1L */
 #define MDIO_PMA_PMD_BT1_CTRL_CFG_MST		0x4000 /* MASTER-SLAVE config value */
 
 /* 1000BASE-T1 PCS control register */
-- 
2.43.0

