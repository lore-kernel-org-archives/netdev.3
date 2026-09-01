Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D20379C2A;
	Tue,  1 Sep 2026 04:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238771; cv=none; b=IY06RlBs568cEf+plf+kJzpKoajMMpW80kosUhl2VVUjL2LlgZWcAorLMOn8rq2lS0XOCVGjmqid32luAOC8cLnIwSn8OrMsxhFcmN0UvNnbVdwB4X6IR4voNRteURPmfHQzBj9EO4zuX5K0krMjgyBla0vY0ahzCG7ZzRRD2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238771; c=relaxed/simple;
	bh=G60oQysCfdKVfM46PuNHuos0LOvhekFgXPEMgQGeYmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X5Ualab5nKYq7uqRNkQn96aLyK70golarhiIL9rA3mkQhHa0c9CzwAPta98peQU3fDnAamc4v/xRJt2u4E3B2u/W954Ed3J3KWKO+x4RCFejmQUug3PcLgg4eKPi2X9lxCNCkKNCpmscdFxkJyIQmgL9xUUtHjKTWzlMDxjiIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Oi2ZiI6y; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Oi2ZiI6y"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6810pSMe2701429;
	Mon, 31 Aug 2026 21:59:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=gX9h4cTszNCqHCMZwWV83B2
	4IyZ1AnAss1lCTVHPMaU=; b=Oi2ZiI6yEBSuq5pWz8sXsk32RX7WjqF2eY6YKJE
	8GzaA3gEfNlO6iM3bJJaI/guinEKcSG3Z/UOjUvbsZh0fqvHoDPGhSzq8WaJC8WF
	jeOV57JCCwVNc9ud5sfjqK1J9Lp6u6pPkPYa3G/GD/I/ds0ARQKJ2PkEPLlNmHMu
	UDk6djUCjEi8AStkHPCSWRrs87e+5h5Qr64LFsBMmR0EY0i5WIc5qjsL8nim3cSZ
	yQWgBhc45lxx1jfsgevKtULbUfjSW/L8xiLzabbE//yTRGfRmMqxd+/ggfbcenWm
	4atGaepKNJSKr3/wSQsB6j88Dzy86At9Gq7BT6ZvZGbrr3A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gbxxj6sb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 21:59:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 21:59:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 21:59:18 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id CDB365B6929;
	Mon, 31 Aug 2026 21:59:15 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Hariprasad
 Kelam" <hkelam@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-pf: report port connector type in ethtool link ksettings
Date: Tue, 1 Sep 2026 10:28:57 +0530
Message-ID: <20260901045857.2779326-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA0MSBTYWx0ZWRfXyTP9GvjsMjJ0
 yqb75K4sQ9CahNGw5fTkcClGNWgA5gMSUIR6aLd0CMMOrodY/gr5i4IidzMM5yoxaui4l8W/w80
 K6vwOhTEbVR6cNW3/QGDFsGXhEjDGIc=
X-Proofpoint-GUID: 6ZRXCxk5yo-sgjaOzSU27CyGhPw763om
X-Proofpoint-ORIG-GUID: 6ZRXCxk5yo-sgjaOzSU27CyGhPw763om
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA0MSBTYWx0ZWRfX5FAYM0YIe06d
 hATUMgxk38JRzeMaF+2oXdfDYpt6SUV5BM8cVXKBr9MipBJRncU9vqN68Vq0zP3PbrawX6SrJFV
 uVip9klmZMeoLV+s5Y0yuXufx4nDUkyiTZR4vNhr7pyinw0u3WqdmSPoYvYGYLabrU44W5L8JLB
 1MUdFK4XtjJXDn8md/BK8eK5hzmSxSApb9iM7h47AEzSWM/FfuKkOq5ZnjD7NBfJ4vZRIuDh4u2
 oyhduO0el2/27gy92K4vMpJZb5gFY4abNK88+SF5qRs+/JkXLMyaTeenyn0KQigdUx+hYiFRPwN
 spSxXlpIyE7LNuBAbWqSnHHpHzxa19syOPPlKhQRQwOtU+gwU38uKyTekN3KPhPWat05qZeKiua
 uZu6oEv3j6oVmBZFYHZhLzstkC1O8uiwwUCRGbIV/mfpMCOikqEIZM5p5POndf6jW1KMDXvXOlD
 hJ9F8YboNth9RhnUNOQ==
X-Authority-Analysis: v=2.4 cv=QuJuG1yd c=1 sm=1 tr=0 ts=6a965ba8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=AgtXlqFZHbNYGzSk6YMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01

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
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 9bee1b91eeaa..65630de43539 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1231,6 +1231,8 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 				OTX2_MODE_SUPPORTED, cmd);
 	otx2_get_fec_info(rsp->fwdata.supported_fec,
 			  OTX2_MODE_SUPPORTED, cmd);
+
+	cmd->base.port = rsp->fwdata.port;
 	return 0;
 }
 
-- 
2.43.0

