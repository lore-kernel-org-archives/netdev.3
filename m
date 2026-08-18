Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46C3C2B92;
	Tue, 18 Aug 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044300; cv=none; b=GoQUzv1N+nHfyCTbhXEX92mF3TfGg9aiwnLIrT/xMijFM+4/gBmaSLTVjQWhvbZ5ES9J33kBNEUaJ8vxun1avpni7CwZzni1SCuH6JIi7ALtTdNm14vhTGB+agcepbpTPa2iP4Iu4cX69BjCLsjqG2G4Fa53ZDYQv2kvQCAEeYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044300; c=relaxed/simple;
	bh=b9eB1Jgg/2k5o7orPR7U2jEAOKu16VQitQxcWs/ulM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QNVxSXKjVgxX7iNLoBi1fMkMVwYGIJ6grjbU71YE0YuyeDfqF69ARVN/NFZPgihlz0W80PYjZL9ijnkF83kFapqQejNj6x/MHlrIjhYWWbonZeIstVAJSP245w4Wr1w/dzGmi1YKO5RLBQf8yLD+ASjqcPOELJXcn3TOj3Gin6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TJvhRzmq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TJvhRzmq"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLvu2l3764527;
	Tue, 18 Aug 2026 02:11:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=8+sPdAJBBDmj9Bbt6rH0JAt
	VQ9t7t0fZXUvgp4mIpxM=; b=TJvhRzmqJVDCFSkDDAJco4YtvUAEe5ni1O4MBrL
	UVTpl+aQysXFrTI/6xZp+ROptQHCmjVxvJdw5TYX0Se+AWrwCFv0yFF/866Mbw6d
	6Ka1+llgEkOYXx56aqWktyl6XyFmhMkEy/itBODERltgs2e/UF68y1Ti1HFGo3Fa
	ci275mwLm5skZCs+v0xX6nTGBU401CMUrIoJbi8b4RHxSWlkwdBPlaBeJM63iKpT
	4ItxUvytaklDOMof8ec2zfsXAJ+SXDjXj0D6nsThOHmkjACZYpwdS++udrZnfCxS
	QcH2L7ypChL4dlW3hj63/gsKuEiKfEcRN/klOPA9kh3YwvQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g4ap4heyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 02:11:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 18 Aug 2026 02:11:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 18 Aug 2026 02:11:28 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 488193F707D;
	Tue, 18 Aug 2026 02:11:25 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v4 0/2] octeontx2: Misc fixes for RVU drivers
Date: Tue, 18 Aug 2026 14:41:21 +0530
Message-ID: <20260818091124.1832237-1-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Q7LiJY2a c=1 sm=1 tr=0 ts=6a8421c1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=4I0ENqp42E1HAAk-qN4A:9
X-Proofpoint-ORIG-GUID: 43qX55_83PEteeLBUtxc0HT3rDi5NT2C
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2NyBTYWx0ZWRfXzUSTZAAPlZFL
 0MwRZIXKaEOhJtbOopJ4Qx4g21HKmBNye5X9fvXeNx/MQfqBWlyio6eqBd4kdvh6mzFeEozh1Nf
 0GL9RPbMjCuHq+Ft71Q282ZmopkRc60=
X-Proofpoint-GUID: 43qX55_83PEteeLBUtxc0HT3rDi5NT2C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2NyBTYWx0ZWRfX4B2c3q4PCIVT
 SKYZqPm5GB4Z69ITSjUtPPLdHxMvaaVjaadnclnGjPtfLM0cigLmD47z59zQsdMmf2J/vKJSYiq
 v69CpN1mCBVRF7it1/z4UaL+gu98uF2OukMzqyEjy3y91v5V3Xzq8N7fr8L/XlyJEsQY4vWJo/X
 aoRNbfv073jHXNlwuAHhAQxT9sbmN1eq8q+Y5WuA6xPH+H3yyJJMkhU6qTNGZhJ+C4R8PMA+wNZ
 1vNIZSgUacLNEN+MTY3/VnViExBIq7gxbKd6mk4iIJiYQmpUVAlu0gpIPHyxG5oDQiu60srtPwL
 mi7TIyG+KnW8r5NNFrH9N4is49WBdKLXWKIYnattnOmG/2/bRKd+/A1NhO+iKM5Gc35iBYcNf9F
 zp1Tj8Z/Lgb7DWXZQs+a0/y+MTInGtc9u9WBMBUGo3IXR5zqzQnIq1z7vM+qw1mNmYXAM5cQxuS
 k0FTWiRzf9os3daqSWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01

A few independent fixes for the Marvell OcteonTX2 (RVU AF/PF) drivers:

 - Fix aura/CQ BPID assignment under CONFIG_DCB, which assumed
   queue_to_pfc_map was always allocated (not true for SDP VFs).
 - Fix the SC resource cleanup loop that iterated over secy.max
   instead of sc.max.

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

