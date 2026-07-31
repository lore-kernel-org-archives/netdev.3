Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D135DA6D;
	Fri, 31 Jul 2026 05:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477209; cv=none; b=XwGnM65gjLGIEREbaNwRKpSzAwOSEB9yuu1AxQHySfKV7JYhfJnF/I+3H5Itg7+/u6PxcQSsNXSFONPcVOuMZP8DQdhPzbl5AqFLcZNVd0QwFLYQ7m2Uu9G/UrLK3Cz8wdNebKrK1LyQQ7z51cWW6xYNVin6UwAhdWyoxOdjASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477209; c=relaxed/simple;
	bh=69uOx4/OQIhnrkwTv6I6/6UE4PxWVfeb/j5TxGZZ0tk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQDjwPXoZ52JzU60uAipcN9X+Bf35AXKZBvUrIvI1UtbUHNEgEmZlnFGdgFc8AqLh6UtDtBJVSbGc7q9AEmlnkLtb0KiET6fUaKoLu43LEFrR5kWg1BoMhV/3PrN94d1IpT/n7dZUoYgtZ6bYUkW6EWk8jx5xzxKV4NljixBrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=i6bNeSji; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="i6bNeSji"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V50DX42827536;
	Thu, 30 Jul 2026 22:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ymX/0NTWABe4b0APqNLH3RX
	wruAXfMqiBvwVduHCKqk=; b=i6bNeSjiX9UxbJieEGNvWqE7fxlxr8iVFbPfzkk
	O/5rQkU+u2NNyma7131yeVCLwoEXwyDaIblR3qYARLl4E/I1Vgy9FDE4SUm0TQIX
	ZMQYpUxclR24leekuSG4rUrMldYhNgZOdNoCMsIqYmZ7PSgXrJYVTJtI63eH5z3k
	ruejwtzIA2fkUkEZdSa78xFr7JvxL2oW8tt2cn5oZy2PPXf90ENQKYg096snquPN
	3v72flfdyqRqFVQcoa74SDS0lV8FGVvkqOXBplRWUAL2BPduo3UmsKgD3pKmLPME
	0rGCEa+kxuEY62F2wWA7UQLg1yjrH1MX7IxMCBg8k7ERfyA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4frcw59gxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 22:53:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 30 Jul 2026 22:53:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 30 Jul 2026 22:53:16 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 32B703F7072;
	Thu, 30 Jul 2026 22:53:11 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v2 0/2] octeontx2: Misc fixes for RVU drivers
Date: Fri, 31 Jul 2026 11:23:08 +0530
Message-ID: <20260731055310.1229213-1-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfX98f4z2uKQ5cy
 7rImPJRNSzI9U2x96tsgPBJAf/9KEXdopJTtbZPdvQ0SGViR+zqPUDpGcn6hrKXqJb/d/G2oUH7
 jTwz3TxeaBx1UP4umvE5CqaaVhlSqbI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfX+zxtRPLovgo5
 3DAd6B4M4xkib/8u75joCWoc6FMtd+FKMm4ENq6fTSWsuCEGMEsW+/I8teyxdzECnEeyZYv741r
 uBSFkmCZEgjlKIACyUlNlDo3J+XQo9hYW7oyo316yDW3TDmUthmjFVCezkqbT6gCzcZg6hXHdVM
 1/9NeHjePYyVC0tRpJ539V4rFV+8LJYOBYzwsverx26Pu9T1spAikdh8rTqsi7yILqPRLQFi8o/
 kCEbIsF+nzQZvIAGVmIi0Humis/5NGuz2qy8ywSRrLH+5wFcCZDoF1gfvDflbgro9Meu82jabMz
 RtZcwb4GlHFL5zNg7WXEkJR+/g7FitPjKaHylJc2X2TWPi2ldyjR+Ejo3a62xXmMcID/GDmNl1e
 FaAG4mBfoYnlMkroyonk6aOjZzUE9FRVNr43y8aApcTK5q8LubcN+fFLPhKn+z8wYebY5hjKcmA
 ZVIvKx16Vh1lLCOhhrg==
X-Proofpoint-ORIG-GUID: JEcrZ9m2DhggnWT5CCbDbAsuixH28X4K
X-Authority-Analysis: v=2.4 cv=C5bZDwP+ c=1 sm=1 tr=0 ts=6a6c384d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=HBixzOeNlgMMZFUHzFwA:9
X-Proofpoint-GUID: JEcrZ9m2DhggnWT5CCbDbAsuixH28X4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01

A few independent fixes for the Marvell OcteonTX2 (RVU AF/PF) drivers:

 - Fix aura/CQ BPID assignment under CONFIG_DCB, which assumed
   queue_to_pfc_map was always allocated (not true for SDP VFs).
 - Fix the SC resource cleanup loop that iterated over secy.max
   instead of sc.max.

Changes in v2:
 - Dropped "octeontx2-af: Fix mcs string buffer size", will
   re-target it to net-next.

Baha Mesleh (1):
  octeontx2-af: mcs: Fix SC resource cleanup loop

Geetha sowjanya (1):
  octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled

 drivers/net/ethernet/marvell/octeontx2/af/mcs.c     |  2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c  |  8 +++++---
 .../ethernet/marvell/octeontx2/nic/otx2_common.c    | 13 +++++++------
 3 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.43.0

