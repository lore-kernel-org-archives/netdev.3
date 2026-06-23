Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A839AD3B;
	Tue, 23 Jun 2026 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187602; cv=none; b=FW91m5QIntkjD0AltvDl6YZpW8Pc7uiIcmE6assGZ89ByY+xZHaK+292/zNA507BP7yAB4ZMXpWLlmmE8Lasb2aeYGjorwefanLe3vMiV6pdBoFgOi2INwO9/NhFli6icRufK4tvW60vo/5MOPXdag/2TzcgXxXgtD33GY2WjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187602; c=relaxed/simple;
	bh=HNZ6s79QkoUJZwdKSlKnJjR7kzKUNObyHPsFVmTiaxo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OwtoOdt2wiFKKv+AeFlwrO2nOioxeYXYsIsADjwq9LXK+cB0x9yDMTbbipsLF+B98EwJhoUevE5QeN0IEVzLM3vhZMQJzgCyuIB9HRZM/C3vR2A00Zq429zqLi3XFyb1m0cUBGnf+/rwWiX3DpB7Q/Ks9QpY0o8sTx0BD8QY5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Z0xP3E0Z; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z0xP3E0Z"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0fbnS2739182;
	Mon, 22 Jun 2026 21:06:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=4UAK3G2CXNQOWaUmCpL0Iwu
	Rvfn1CzwJbq0QLgdrECM=; b=Z0xP3E0ZJGw1XjHqz72VBLmNHqpSQ0Br52qylaT
	9It6+BsRTE0fjyKdbyBhlnRZJSLFkhSH13otl/cw5SVWqodzajD44LYVVeyhv3NV
	pdKU+dYMQcmSa3A3ZCKncs30VttS1TskEO4j6vvdmI/j7ev1hAnzsiMkJasgpYxq
	I2AXmREzyn9fgVAL6qBW2pDcvX7fnX2HezzIuIUqi4fx7iilNDK3I+RhutpZIgNP
	N3SwWmqW/POM6YYW1ZdBtushHP/+ScS/6Csn1MwHNuOInI983XYC3qWNoyNXYZit
	xt1B/qK6pZ5V+nyptNCvW4Rac3Kwu2BV79tdIXV5lWI2fgw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eyerdgjsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 21:06:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Jun 2026 21:06:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Jun 2026 21:06:17 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id DBBBA3F7058;
	Mon, 22 Jun 2026 21:06:12 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <rkannoth@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <Sunil.Goutham@marvell.com>,
        <naveenm@marvell.com>, <hkalra@marvell.com>
Subject: [PATCH net v2 0/2] octeontx2-af: Bug fixes for KPU profile and VF RX mode
Date: Tue, 23 Jun 2026 09:36:07 +0530
Message-ID: <20260623040609.3090846-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IvYutr/g c=1 sm=1 tr=0 ts=6a3a063a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=fvdVuazA2oulz7gussAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAyOSBTYWx0ZWRfX3c1rr7anEd9f
 t0bEmpi66aD1CWN3QBFeujTBg57gNKJGItW+QhibsQxWgRXGCuiB74luXbUgqPvX52M/O+14lFO
 t+rjetbNF0G9HD99kC7Qag9f4+p2UDn1zFzfOyaevixT+z8a6HUI1uObQO2aag0+IqYZ6oo2xGC
 Yg4yZrgl45EFaL/X8mm2ly+K8auItbBJL2SounojC7/AEkzr86rTGK8FD59aqkZHiqcoalOf/kA
 W5ouTwJkX+mB7QIABQ7MdQ4NSL/ydT3N7sowB8zq9+jjjgNC/dWf6cZSh709HqRA6wkaZG0uJTk
 ylV63Iif5B1ZcZ3byPrnxarnb+w6vAz3qLIE8FIoz44CcgU6YAvFbWoNXJcGSAv0UKfV2vWxbqk
 M+WPgD4TYmPSsNydVdFMP00B09kFZsg8aeS15EmQVjRqjUJhLsWvfCgDJX8IGxuHRpLhlcObZLt
 +nJluo9XOmdE1dlDKnw==
X-Proofpoint-GUID: DZDbxO1S0lCK4RG_omAPL8CWZHpO8hK3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAyOSBTYWx0ZWRfX4LLHtCZAIoYZ
 1NBjTHU55j1NRy8LLjh4t3pmQslk4CPSEfPgrXnmo4gHq9/5y3XJYgNa0TMY2ZwvwfaBgMFjmVh
 0Aw21xfk1kBN+Yjuw2DI3lKyi76gYGI=
X-Proofpoint-ORIG-GUID: DZDbxO1S0lCK4RG_omAPL8CWZHpO8hK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01

From: Harman Kalra <hkalra@marvell.com>

Hello,

This is version 2 of the patch series targeting the net branch. The second 
patch has been rebased against the current HEAD of the net branch to resolve 
a merge conflict. No logical changes were made to either patch.

The first patch addresses a spurious firmware loading warning by
switching to the non-warning variant of the firmware request API when
falling back to alternative loading methods.

The second patch resolves an issue where a VF changing its interface
state could inadvertently delete the RX promiscuous and all-multicast
MCAM rules belonging to the host PF.

Changes in v2:
- Rebased patch 2/2 to resolve a merge conflict on the net branch.
- Patch 1/2 remains unchanged.

Harman Kalra (2):
  octeontx2-af: fix VF bringup affecting PF promiscuous state
  octeontx2-af: suppress kpu profile loading warning

 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1

