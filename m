Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2747DF84;
	Tue,  1 Sep 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255837; cv=none; b=s87hiB975z6fJ7O57eiWh0k16M6aFwfKRwOEV1ILAkGgQ/jKH7VZ0S4fPMlAoPN5HpWfQvfdLk686yRNWCDR9gPnqcrzscZfHyYatd2KK07Vd3uDzO0uVOBtVK5NcVGS1atf811xuybsJU++SpLWyrTbF3XvwMZ7171GMUCTWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255837; c=relaxed/simple;
	bh=TT8ytgeQNFbfItaG3H6JI0HNZJJDURAAqlJT7GfiwuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mKikwF+6v/DLiu5R1K4rb45ZDrbTx3gq9JuHRWYLXU522X7JuDbostFPEy5ZQUniRaSV+JWhZ+DmG+6ZF3Ff7BJs4FwLVzgCaUQns/OQ554tdmzGZGj5wgbJe4BFbJLDu4sIlhbsKVeTCbBol1uyzojKwfQjMcnesaE3GV/64n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LoWsgHDq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LoWsgHDq"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817Cgcd2833071;
	Tue, 1 Sep 2026 02:43:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=z3j+QQ6TUFD75XCFp3GSs5M
	ycaCILNwA+w6md5MDGU4=; b=LoWsgHDqaL58YxU3MkuY/Vh+5g/rM5cAhUjLZI3
	siQ88mcnBqwjtj5NIkZXsR15kbY3zMXlxfcowf9T7qyRlv24ISbpKqm4Epzf3lS9
	TurIBEIYxXWHYHLfQv2SUDcX61cjBigQ2OkouzbhzGEKuHheVPs02Fa3Gf3+VIcJ
	S5N1qQDanJAmqOpm4JwhwiNC40iF0b9qmNzKx9nQVcTGp/wAgnnmxO1loDJaqNOB
	O+OB+r63TNrsy/ulwq4K3dQm4B5tqWmg2nFHwMLcrSW2lAltM0e32siX1HQ7IDz+
	xkF+HRxrhYwLRXhvf12et8siLpZIA0SDPZTpGLEUl0pWt7w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gdmvqs97s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 02:43:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Sep 2026 02:43:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 1 Sep 2026 02:43:27 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 529995B6928;
	Tue,  1 Sep 2026 02:43:23 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Viswajith Murali <viswajithm@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Vamsi
 Attunuru" <vattunuru@marvell.com>
Subject: [PATCH net] octeontx2-af: mcs: Clear stale X2P calibration state before calibration
Date: Tue, 1 Sep 2026 15:13:17 +0530
Message-ID: <20260901094318.1395356-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NiBTYWx0ZWRfX07ekvOFvu0A9
 PVXgoHGrt5QZH8VXsgt2Ns5SNiV45oNtbbvbLTzIwSTBqZAEiAO9kmS7jUNUr+rZlLrxiwyvTYJ
 G7YHX8DKHwrMs/w5Ol9Ey1gG8a3TIWFSqNX87SrLDHrzuby6iwpewL+uTFh9byUiQbf299OG6Ta
 eT/UnipjtP8+5Lh6qx+zR7LuXPUUR9k8aHLu7lsBiQ8GHnitTYyy7MZ6pyMEPXe+Id3GfBhC5AV
 gD7qb4sHtkqn80z+A3ZiG257Bot0Jt92a92roK0Z1PV0xPhD6nq0AD5nf0vlNN2J216ol3x4vsU
 S6472HT1bGblJm95Nx3tTj6D1QhpKO3v4g3wNYO1A771Bc6r2BQPYaKdLuASpGUv839zSb/rLk+
 yJKRPPC+p159+WlupJA9KhZKvGGrMU/TIhzzxyPnrkuEosvgm4BNmDaPnwDKGxV9FrYi2aGZPhG
 ehBkvwTlouvTEVx5Ieg==
X-Authority-Analysis: v=2.4 cv=HYQkiCE8 c=1 sm=1 tr=0 ts=6a969e40 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=z7qG03HmhJMYOIuxF80A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: aX8XOteanw9NAVXe1ClDkZStSdv13aU4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NiBTYWx0ZWRfX3696O8RsQX+H
 aLXLxnLWbxyFw6CsnRoKnaFC8aBvHNgp4FGrzfEfPv1lNv9iPb4Yw4Q74tD+Ui7BeNeQlJbdFIC
 B9L1LzaE2AmAP7J9w9BwFfToV4MltlM=
X-Proofpoint-GUID: aX8XOteanw9NAVXe1ClDkZStSdv13aU4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01

From: Viswajith Murali <viswajithm@marvell.com>

Some firmware versions leave MCSX_MIL_GLOBAL bit 5 set on boot.
If the bit is already set when the driver attempts X2P calibration,
the hardware sees no rising edge and calibration never triggers.
Clear the bit and wait briefly before starting calibration to ensure
a clean rising edge.

Fixes: ca7f49ff8846 ("octeontx2-af: cn10k: Introduce driver for macsec block.")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Viswajith Murali <viswajithm@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index a07e0b3d8d00..211c10aa5880 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
@@ -1417,6 +1417,16 @@ static int mcs_x2p_calibration(struct mcs *mcs)
 	int i, err = 0;
 	u64 val;
 
+	/* Clear any stale calibration state left by firmware/bootloader.
+	 * Some firmware versions may leave MCSX_MIL_GLOBAL bit 5 set,
+	 * preventing the hardware from detecting the rising edge needed to
+	 * trigger X2P calibration.
+	 */
+	val = mcs_reg_read(mcs, MCSX_MIL_GLOBAL);
+	val &= ~BIT_ULL(5);
+	mcs_reg_write(mcs, MCSX_MIL_GLOBAL, val);
+	usleep_range(100, 200);
+
 	/* set X2P calibration */
 	val = mcs_reg_read(mcs, MCSX_MIL_GLOBAL);
 	val |= BIT_ULL(5);
-- 
2.48.1

