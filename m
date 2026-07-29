Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3BB3F660E;
	Wed, 29 Jul 2026 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309846; cv=none; b=FO2MZWmRTrLvFgxGhblNGK/NB5xxO0lay2yYVEl+oB6EeM4MRwqtkI6iogDZeO/aqfOe+jfFuxCm2qCzQKkKNVwcPaYTD9H5kje99o6HWdedfF27TaB2EBQJAARP7M/AXTVHfl88RlkiGFKq1olKUTmAdvsFi54KXaCa7yBH2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309846; c=relaxed/simple;
	bh=/ohi82fZYvettL2F23m9X97NlsAFeCvGfwX/HvtEgb4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nSC6PLmoAKMBv/Ze0+8tAVVetXYOXO4t8aae6wXMME74QuCbn9/cPnS66G6aesJzXaFrlsZ8DfsD4lg3ym8wIgCwvSM39Szv1eXtrJD3f02ii7/p+dCYb7QcljvooOhwvo+AS9fGbf/E6P6WiQ818Xcns2llkP3GwTY9vuvZueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Yav1Jd3M; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Yav1Jd3M"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4dwYk3358856;
	Wed, 29 Jul 2026 00:23:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=cMh2n/ExE4X3+btXYMr3Dp3
	m+D8dpjxH/219xQcQ3FU=; b=Yav1Jd3MUhxcZD1Hs3a11kriTrD/NvqKKOTcEjv
	irQg6OO8GJdd3GmZVb67EQwS+KvxelkFsOpc30DTHDA0oUnmcdmMrY1hhM7cIKxG
	Fjtw4dmlsQfVxATY+p/d/7pAnNlOoJ8vr9qYIYToDLLVe6DLTCtPYxF3bmUqkUCO
	U5B3HpWKkxugTWprcPtkIP18loxAWx6l/HCIMvtMWUGuUs9v/kVjHi4rQ8Wcj25w
	srSHBStl0VPHwA060aFz8LMtjn5lhs6MRrC0rdPBirPPNUNN9inzrPbF3SGk5yUg
	XpBqPf4/tzK/Pfo8gv8OgcwlxqJeVOW28UA6iGXCA4u4H8g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fpym7jg1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 00:23:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Jul 2026 00:23:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Jul 2026 00:23:42 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id E03533F704A;
	Wed, 29 Jul 2026 00:23:38 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>
Subject: [PATCH net 0/3] octeontx2: Misc fixes for RVU drivers
Date: Wed, 29 Jul 2026 12:53:34 +0530
Message-ID: <20260729072337.664479-1-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA1OSBTYWx0ZWRfX7GF5Zjxs716R
 d11CqWBq9Kdc0ZNcLfvKqGITosp/3EfcIFAtKYVcP+Bv7z23JaJsqjwAPIvoGy/6aDttpwcbhxk
 +S6uurnFUw/1JT5Mt2Xstzppbf/GpSvt++QPPyJNL+C+cDBUGiA4iwJmdgNcZQ3Js5ZANB6v+CW
 Q3hbTwzR+bcMbrT5QETmsE6Z5Pxaam4qBiCHyNRBC75lvCAzOvUYIr3CuGmNJex3OuERmT5qF+J
 KMtj34aQ9CU/RvIALyW6ttritMCqMqsYZSkGcBvAYdAF7wHY53DJHF2zNH2QM+9X4eTHZdAUDsQ
 jVBkjSWuJDCfU+ppZZ8XcoJ8Rne4ZYsNjgYupIlVzKLTOrmukalbq72lbCzrB4qe/56M3Z+wqwE
 ZGboWbz+Gd8adhfy+ZolOtf837aaJRpvuSVnB2wYfQXKeOgxV3ij7R4+/IYIoLS5xo8g++xQD78
 WdW4NlDySEo56w4Y9Ag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA1OSBTYWx0ZWRfX/LaRi4YK+7Ru
 LK1op6iinEc0jdMueSl/QppwP/iINqAQUagEsU5RS9ZNP34op/xvy5PSqN4gyXLbFmQCkwS07xH
 KGw8dfnJ4NRWJ9HzMMoXR9PMC0uFNN8=
X-Authority-Analysis: v=2.4 cv=YJOvDxGx c=1 sm=1 tr=0 ts=6a69aa7f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=-wSAhxvUdy9TtfyZpAoA:9
X-Proofpoint-ORIG-GUID: mjzhkzNwn15rVyboojAPfbYyh9sEGA_8
X-Proofpoint-GUID: mjzhkzNwn15rVyboojAPfbYyh9sEGA_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01

A few independent fixes for the Marvell OcteonTX2 (RVU AF/PF) drivers:

 - Fix a potential buffer overrun by replacing the unbounded sprintf()
   for the "mcs%d" debugfs name with snprintf().
 - Fix aura/CQ BPID assignment under CONFIG_DCB, which assumed
   queue_to_pfc_map was always allocated (not true for SDP VFs).
 - Fix the SC resource cleanup loop that iterated over secy.max
   instead of sc.max.

Baha Mesleh (1):
  octeontx2-af: mcs: Fix SC resource cleanup loop

Geetha sowjanya (1):
  octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled

Stefan Wiehler (1):
  octeontx2-af: Fix mcs string buffer size

 drivers/net/ethernet/marvell/octeontx2/af/mcs.c     |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c |  4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c  |  8 +++++---
 .../ethernet/marvell/octeontx2/nic/otx2_common.c    | 13 +++++++------
 4 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.43.0

