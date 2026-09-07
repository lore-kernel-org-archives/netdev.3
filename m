Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D1231A23;
	Mon,  7 Sep 2026 04:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755329; cv=none; b=hsI3i3hiJknUzzOfYnTThcOwBQl8AV2dK5i6KRYqkHGw0G1ppkpNEAtB1nS7sHHDli8SN4OtwUKxFcJBQKA0dgo13nqyDpC5gLum1xu1OzmNbONiXMH0xFzFnvVkMDPm4zFHZYfWnTfbT4wws7y1j7vEJB7DyktR753ljB6TLlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755329; c=relaxed/simple;
	bh=pPpYtXfMXgVodbIxxZZdeQJQZoWgx191eTRmsX/L2do=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gP2XreHW6rh71MYKODSVQxUN5PB4BJ1xSjoyXKO5XA52K/miFUIsXD2JtseCsNJrh+X12/Wd+lq2031JCld4KG24S4AvrqR8/W+nkIkwkFDrCZpqDB6rhLABz7p2WEb57/a5k6TkOjjtUCqEf+b/PClVgia8jnZnO3Z5980gl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ff3Wi5YY; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ff3Wi5YY"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6873l40d892708;
	Sun, 6 Sep 2026 21:28:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=LrR593QmkcTbRuS83VwS8b/
	TfrqRGyHf3y5j8b486ak=; b=Ff3Wi5YYUlJhSJQwAc9eJ7cct2DIgm0yNnFfMoc
	+ESCLyC9Mu79r3SEyhVbyNSLLKPvAs+DE5BOs7N91yHuNTFPl4wZ8k3CXb5Q4TsZ
	tUjwLQmQiBkeaB6OEb7asjnE9WVyy7pIMpuAKNU7nH/ZzNjV4F4yFZcsemW6zpxw
	xmXTh3B2kTNMQmrt9TC1mZJ8hmViwVjsIEa8gUkEmRdIW+XUpmLrnJg5DAHeLHa8
	/H8aCKywIev0UmOezrPLUktl/vBhbdfFL881/O06n/GANxdOV5sSBcel6+gkvPvR
	bt7QdPR90/rZgGE+Z9YPySw4oNWC7mOhtVWHTN7s4j/NLPA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gh3u8sfs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Sep 2026 21:28:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 6 Sep 2026 21:28:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 6 Sep 2026 21:28:38 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id DFA6A3F70A1;
	Sun,  6 Sep 2026 21:28:34 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Hariprasad
 Kelam" <hkelam@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net-next] octeontx2-pf: report port connector type in ethtool link ksettings
Date: Mon, 7 Sep 2026 09:58:27 +0530
Message-ID: <20260907042827.4077114-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AjXYdt5eq77DoAS2w3cIPPzPFOWYu4DI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA0NCBTYWx0ZWRfX5gQ9izwqLCyv
 Xl/CrQ+87BFc3ZAsG5gdYS4UjSe8A8cpVa0rOR3yDME7nfzbekek6LCO1yCYnmTAwLFSYojnvOX
 u1FVaYYfXaEogk9kabTm2nDEgDCH4v0=
X-Authority-Analysis: v=2.4 cv=b7+CJNGx c=1 sm=1 tr=0 ts=6a9e3d77 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=AgtXlqFZHbNYGzSk6YMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA0NCBTYWx0ZWRfX6NOO3fo8igyn
 OedWHQnw4mqJLOiYUqGn99UG1+2GpEz0fcW3PnYAL/w/LwrLiGs3+doGpF1anjlHcoblTwzvgi8
 a+pvvhLAWBhGo+Bv5iV8rw0HBPKEuzIZ4ksGMzV9eVJqD0K9OAX4j/2QaCn4lo4AMvSGwj4PKmW
 Zbhaovo4AjfS4LHWCQt+z85K75u8zh+8gz/7eIjoiZQpitoqmsIdw24So5ORDRPsPYIUngigQxb
 NTdMDigUn2mXpF55uDyKu56gdTc65LZwTU99iyJg2rl6FJvuGRdzEG19GAxT7A4kqTjl9Lf1sfi
 HzvhYkjaksvQaj3rcMBibjaJjZtVSA0GOhR7MrbCLEB6xHbdIta9XCTAlwU0da62sSBntQ86B6i
 gFuN/Bu1bTumMjAvHy1McB4EP2wL2/ieKlu2Z78kInLxYrvqfhcK6/dw4dMMDfGcVC1CDW7ArT8
 bPc51QhFpb1anDFdDRQ==
X-Proofpoint-ORIG-GUID: AjXYdt5eq77DoAS2w3cIPPzPFOWYu4DI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01

From: Hariprasad Kelam <hkelam@marvell.com>

otx2_get_link_ksettings() already fills speed, duplex, autoneg, link
modes and FEC from CGX firmware data, but leaves cmd->base.port unset.
As a result, ethtool does not show the physical connector type even
though the firmware provides it in fwdata.port.

Populate cmd->base.port from rsp->fwdata.port so users can see values
such as PORT_TP or PORT_AUI via ethtool.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v1 -> v2: Addressed sashiko comments.
	https://lore.kernel.org/netdev/20260904154833.3b32ea6a@kernel.org/
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 9bee1b91eeaa..9b4c151b4d7d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1231,6 +1231,8 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 				OTX2_MODE_SUPPORTED, cmd);
 	otx2_get_fec_info(rsp->fwdata.supported_fec,
 			  OTX2_MODE_SUPPORTED, cmd);
+
+	cmd->base.port = (u8)rsp->fwdata.port;
 	return 0;
 }
 
-- 
2.43.0

