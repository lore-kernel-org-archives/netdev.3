Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0D40B108;
	Wed, 12 Aug 2026 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535593; cv=none; b=TlS1DWzG8dCOuA2X6bRHgAgOAWcN8Y4LG86U9/0onR2KK3ZHS7rozear0qJO4fUpTcya/aWmAPj4/SUxGZf4b/9lOhswggl2ZpIWDYQEkKyN990M9uIu7sgjrOoty0H3oBuv3fMC7gIzJkxyeHLs8bD2ktD2iR0uSLQDA1UA0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535593; c=relaxed/simple;
	bh=w8pNqSecrCVD1pVzBQbjUpPAepybcHZs4khqBXNzeqI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bXMk/eR6Qe76hwzZroloZBS0+FHcfY4cAlDH0o+wwfPBN/wOjzdOJeP9Jw6xBbzzvxUkLvTyOcha5QT9W8iTIOFZXpRf3a8mtlqACPRCNTfjkTXiN21NFxkiAj0ON3Vjf2K/xCrV+osfZ8hRLIxWf35xEM+qM1ccMwTUFMuwVhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FSn1V+CN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FSn1V+CN"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB2ZpT2470202;
	Wed, 12 Aug 2026 04:53:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ryCervEKHoQ5uwWZEEulvc/
	waX+g9Xab0CbXQMJhIBY=; b=FSn1V+CN9u13MbYmym8oPFsqbEfqxPnfdlYbvDT
	uP5JXgb/rHUcB11oMadzRgTI1KgEGHkO7RS5A6Ysp7NmG7pscBoyI9pg1bZ91j5S
	eXv6ZG22icxZtqlaW8MbUzGuPRGKmbs56Rpw/c2Hr0exj+qdM57Fr8XJcu9Op2mK
	5HHfp6wOTjHfF+yvHRgTlUxc/2ZgfA8/f+yultgf/FChNKGzdlRtsj8cM0HB5ntg
	akK51yzFZ9x5N2sN4IuRnu3H50DIqDJqqmcLMkMgPQ1sKk04PO8dKxaIdsvXFQcS
	ByRM+eGH67Y+T2iuUrqOaB6N3FCsRs1XT2hTH0FsoNWupVw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g0deh9nys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 04:53:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Aug 2026 04:53:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Aug 2026 04:53:03 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 798CC3F7041;
	Wed, 12 Aug 2026 04:52:59 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v3 0/2] octeontx2: Misc fixes for RVU drivers
Date: Wed, 12 Aug 2026 17:22:56 +0530
Message-ID: <20260812115258.773319-1-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5NiBTYWx0ZWRfX153bklPT+YoR
 RnLWt03V7fEvzHlVFuPWgyCuMKEcXe09qJhZRtF1KOKWiQ236f5uQuJlfbZU30FMiRBUS6GWv2m
 TYez6OcuPk1hWpIPk0bcnmdof4be+qg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5NiBTYWx0ZWRfX6L/uPmOeymaO
 qUBOjeW47giYBJdnVk7R7eIRocdRpgTQqOzQesPQxQrlkrFa4qzwnm41zkjM26x0W8kgB7AE91e
 H5cWvJjImPyIGV+I+v7KlnLn6waQ5mvR4FAlqxSO4STmLc/lEBH/6SuiB+0Ebiy5yhvf8sz9JP5
 /Aboh5gWlqTec78lhvtA4oq7VwL059S0WCrw+YccWeKeh8zqkHZeqdHCjFgM1yV6wc7+V/f7w+9
 EzwlqpQk//LWRXgPbp6X40ndanUmKvyPO/vMB4U7nCChG8G8s7l6OYsssa5qIkdpRpJtIehZzmr
 +Jnz9RWI2xv/4NjYmLs+no1P99mNS/bDNZ2olWy88zhnxGlKJ8o/kQlWOCl1frAXbGVPguaC5lb
 p9BfG24Z6ftMj1XN0FjfdG5AxJfobbTgekrdsaQumkuK3LYM9ZtQ3ZpOtnbLpK9ekML+MS5aed/
 EWusgvIXe9qMe8McmnQ==
X-Authority-Analysis: v=2.4 cv=crirVV4i c=1 sm=1 tr=0 ts=6a7c5ea0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=4I0ENqp42E1HAAk-qN4A:9
X-Proofpoint-ORIG-GUID: sr62E1ZciSy5tBQAjbMpTzoTOs881lIc
X-Proofpoint-GUID: sr62E1ZciSy5tBQAjbMpTzoTOs881lIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01

A few independent fixes for the Marvell OcteonTX2 (RVU AF/PF) drivers:

 - Fix aura/CQ BPID assignment under CONFIG_DCB, which assumed
   queue_to_pfc_map was always allocated (not true for SDP VFs).
 - Fix the SC resource cleanup loop that iterated over secy.max
   instead of sc.max.

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

