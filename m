Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BE43CE71;
	Thu, 27 Aug 2026 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824036; cv=none; b=pRufRWGzqKNG6C6x4/USA0a0zRONJf6esjgPSmCJqSVFg0F1lGwZmWM7TqjujysAaf+Emh8ap7pI4J11/I5Bb7ofxbIgJdeJ19v5tOYjH2B88W9ewGYBGBhlXlX6PZN+1pFxlsaXUzMXpJUaz7/4Dj4b51FkSqPuEiRl+mkfrk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824036; c=relaxed/simple;
	bh=rzAsSBJvncjbwTBZRXPaR6jkYHAWtTCIzT09stG0rjE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cRP4NMg6ESf9OxongSsnHpMdLwXDovusyf7kWi9KQek4MfdFTn5nCK5+CJht5FVmyiARv3wiSp28Exf7pv5rsCD6vxx3HTdQCcUsayRmTsv27SNdDQkSJE7e6FhOquBla4CI3vfVCAVCWUzIqLObv8MtsY0HxWBMt4znoBCB+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NshghwUX; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NshghwUX"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9HKHu3222082;
	Thu, 27 Aug 2026 02:47:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=FSgNrbtbqXZOLFRVarHuyry
	wfDnOt4M+gjocRn3IyLg=; b=NshghwUXR4smJT/GEGgRWpZ6EGvpU9vFWmWJQUb
	Gk+Rrgl68VlP0FCoOo2amFn1edPmPPs2oUA49Dn74tic+n4o5+3R1e1iZyVZDdU7
	LXsC4nQS2NZKE7KoU6vYvNUhYcUnBW/EVpKD4xINtRbCtv/QpEIptO4SgKF4gzJw
	lyihtn8OIPz7QjIxD1rWLEg+7duAgR6cstDGvimSQqQsLxOK0AHmf8uiFXqegDf3
	Pz1JUQqA47VNHtFKS3ejkQxmAFGd/NqBIbUS+iTDLlz0n0FjRoAy14g2AhTvGByu
	3yo8rUUunkedvwV3hNFjrcLJCKLMb9t3SqHdl2ZbvRoQzUA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g9xjqmddt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 02:47:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 27 Aug 2026 02:46:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 27 Aug 2026 02:46:59 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id F12EE3F70C4;
	Thu, 27 Aug 2026 02:46:55 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v5 0/2] octeontx2: Misc fixes for RVU drivers
Date: Thu, 27 Aug 2026 15:16:52 +0530
Message-ID: <20260827094654.1391105-1-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4MCBTYWx0ZWRfX1XskZsi3DlnV
 Y+tMB6f0L9Nj0OE8NbuiO1Lf1HLL6ZbIx+PIYAfzdl2yjnW07shPFXgd44HFWjdKvs8QlhcYzG+
 tB/ctb6z3NpiKQKiYPUBhUkB0skUawE=
X-Proofpoint-ORIG-GUID: z6Iv3hE4XHLf0l682Fic-HZJKVgN2ytH
X-Authority-Analysis: v=2.4 cv=C/jZDwP+ c=1 sm=1 tr=0 ts=6a900794 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=4I0ENqp42E1HAAk-qN4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4MCBTYWx0ZWRfX+e5IMjKmZQFw
 7GMm2TB6VVZUTKfKuPNOnm43WXGmC5VmZExZDCG+OZpiCy94Tp7gXNsFi8RHd2sh2TLzcDCFkDk
 HcS1NkgUjpx1tmhSBRrrVBd6CKwOF69xBlU4OLZ1WzoXrsjRqgJxg0CpQvadyUi+tThEGKT+HqP
 wVO5o/v4uvyTuk8ldr4naEni76aXVSxyiBR8INWPsamoI4fK0p6vENwehxvg+SMWchZFbY1/ekz
 0XS8Jmq33UFJ5bTMO0+XnbH1IUxaHtQn9JQs6dJaE3gNVoIWw6Yaaw4eKozRP7JOUIv5OAprdaw
 quq68DuxRz8T0F8JapAezVASmD2e6er1+/wMiyWrtzHsWRoKRcHwesK3pcnrS+vHNLIyR9ZiXLE
 BGoqzJy+tI+EC/Ar80Hy+t2Zmu8vWaj1Z2nO9i+E8RI2xL53RZg8YxAsF5jVDzyyvv389FOlhE3
 L8EwjTGy7ShBMD0xMOw==
X-Proofpoint-GUID: z6Iv3hE4XHLf0l682Fic-HZJKVgN2ytH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01

A few independent fixes for the Marvell OcteonTX2 (RVU AF/PF) drivers:

 - Fix aura/CQ BPID assignment under CONFIG_DCB, which assumed
   queue_to_pfc_map was always allocated (not true for SDP VFs).
 - Fix the SC resource cleanup loop that iterated over secy.max
   instead of sc.max.

Changes in v5:
 - patch 1: Fixing the compilation issue when CONFIG_DCB is
   disabled.

Changes in v4:
 - patch 1: Add 'inline' qualifier to otx2_get_bpid_idx() helper
   defined in the header.
 - patch 2: Correct commit subject in Fixes: tag to match the actual
   upstream commit title.

Changes in v3:
 - patch 1: Unify the BPID index logic into a shared otx2_get_bpid_idx()
   helper, dropping the per-file #ifdef CONFIG_DCB.
 - patch 2: Extend the sc.max fix to the SC stats loop in
   mcs_clear_all_stats(); add Fixes: tag.

Changes in v2:
 - Dropped "octeontx2-af: Fix mcs string buffer size", will
   re-target it to net-next.

Baha Mesleh (1):
  octeontx2-af: mcs: Fix SC resource cleanup loop

Geetha sowjanya (1):
  octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled

 drivers/net/ethernet/marvell/octeontx2/af/mcs.c  |  4 ++--
 .../net/ethernet/marvell/octeontx2/nic/cn20k.c   | 11 +----------
 .../ethernet/marvell/octeontx2/nic/otx2_common.c | 16 ++++++----------
 .../ethernet/marvell/octeontx2/nic/otx2_common.h |  8 ++++++++
 4 files changed, 17 insertions(+), 22 deletions(-)

-- 
2.43.0

