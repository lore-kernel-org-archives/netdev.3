Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD22010EE;
	Mon,  9 Mar 2026 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773024415; cv=none; b=lPx7h9U5w3reLWzlmzDp3eHJzor6bTLFHjsGjX3mBzNDR6v+P2We5AYWVX3Av68WAN/AE66yhmZ3Wo6gy+6xTAMDdQ9foo5Wfi/qsAlX4yyY44gkv+OSPN/VQgR1mkP8OgCmWtfD4YUZmEUJl4Bmlrq5EL7DaEaG0CSK9oL5JBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773024415; c=relaxed/simple;
	bh=Ad+3XjvuS/zLVQGwFB2M5MbeZDXm5B8V/G0N4iDYetY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRqRgHeT4DGvgBATFqU+yNuwzVbkqBnJllhSrABmiF1ifWl2xyNfIKw5tKqc8bdRtli/IchQAK37iAH9CN1YPAsnunml9SErdYCLioq+0nxpka8xgRPSYZCrlkYtCH9MiN4ZOp+Hg+DeVVlKycgRSRyl8j7aBtVVzrKA+A0oZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=debyd+WC; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="debyd+WC"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628N0Ooh3436830;
	Sun, 8 Mar 2026 19:46:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=pbwlJOT20GsujEi0ifa3hu1
	jRY15r1OWSmehcpaIYAY=; b=debyd+WC4kEb+75dMZnOBp1W0OEx/wi3e3uK9ch
	JMwFVMShmGxi0G6mfB25hmYIOhds6T8tRM2Q9jcIzHuOk5TfdeFmz1JgHrixibeu
	ofTlKqyowCQEmMAN1Oy82b5WIu4sDMJw+ZUKN4HlgvCLQa2ASR9E5dYrD8reC81w
	DrcILGspClKPPazkbH0RwFKAYHlW3MJB4PzI/U8gH8sW3+Ix0LqBl1pWEMv3itix
	3cntIc1mHIzixLCWx3mOTF5rHgrdPsCeSAKDhRQnFJumukMvlr4TW3J2jK5oraRW
	Q1JONMjnpaJgUc9NyJ+nw9L6XTYzSwt7eAlV1NQ9G9yQFOg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4crj8qtf7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 19:46:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 8 Mar 2026 19:46:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 8 Mar 2026 19:46:32 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C92CA3F707D;
	Sun,  8 Mar 2026 19:46:27 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net-next 0/5] octeontx2-af: npc: Enhancements.
Date: Mon, 9 Mar 2026 08:16:14 +0530
Message-ID: <20260309024619.898211-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAyNCBTYWx0ZWRfXzHWJVptsxBCp
 HJblynGbvm1c/tc15Bt8Wt2bapnbJlX9eK6kYczFfpILFf8Bjp2oVRGu0bE30JJ/nkCramKm4Y9
 eJ1wj+YBD/YLJm64iGNqvKmC8+KJiWjhjkXsHJMSDAoVQtLknG9b3MUNSOqoNIZ7tx+oRckD0py
 cjNee4m4FFpczIgItDovphfbn3drZ5+K6sFFO4jRl4/CIHE7wF1ZCnKPXCm6MBNYdQrgYRnKKM7
 Dq/T1+wfTwwGtTRT3Lbn3nNuWSTIU3yoPVaoOgzGmw7jVHzie3Kcrg6FDFwx+Rl5cgqm2hXnQyR
 CPePXot8JUeskPsbQgRm1SWFzzZsYLjprEpJw8qIQJhL9SfmiSyYSeM3EnJ72yW5Ikko+YuUlH0
 5d5xCO46Emfj/zxXMGsW/WE5rdTVj1af9CezD7Htw3hX5Q1wUI9FLcVdoVJ0CYVoPjdn3Tg7Ra9
 2Z+qN15vy+8kS+alwMg==
X-Proofpoint-GUID: tksMdlD5J-ZsiJRg7T3WrQYWV3AKZi8s
X-Proofpoint-ORIG-GUID: tksMdlD5J-ZsiJRg7T3WrQYWV3AKZi8s
X-Authority-Analysis: v=2.4 cv=WbwBqkhX c=1 sm=1 tr=0 ts=69ae3488 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=hejfvb9J70K0_1iCNg8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_01,2026-03-06_02,2025-10-01_01

This series adds features in NPC HW block in the OcteonTX2 AF driver
for better observability, configuration, and resource management.

Patch 1 adds debugfs enhancements for CN20K: mcam_layout now shows
enabled/disabled state per MCAM entry; a new "dstats" entry reports hit
counts with delta semantics; and "mismatch" lists entries that are
enabled but not explicitly allocated.

Patch 2 (from Saeed) extends devlink with DEVLINK_PARAM_TYPE_U32_ARRAY
so params can accept multiple u32 values in a single value. This is
used by patch 3 for subbank search order.

Patch 3 adds a devlink parameter "srch_order" for CN20K to control
the order in which NPC subbanks are searched during MCAM allocation,
allowing users to tune rule priority without firmware changes.

Patch 4 ties default MCAM entries (broadcast, multicast, promisc, ucast)
to NIX LF lifetime: they are allocated when a NIX LF is allocated and
freed when it is released, improving MCAM utilization.
NIX_LF_DONT_FREE_DFT_IDXS lets the kernel PF retain default entries
across suspend/resume.

Patch 5 allows loading a custom KPU profile from the filesystem via
a module parameter (kpu_profile=), avoiding firmware flashes for
profile updates.

Ratheesh Kannoth (4):
  octeontx2-af: npc: cn20k: debugfs enhancements
  octeontx2-af: npc: cn20k: Add devlink support for search order
  octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM
    entries
  octeontx2-af: Add support for loading custom KPU profile from
    filesystem

Saeed Mahameed (1):
  devlink: Implement devlink param multi attribute nested data values

 Documentation/netlink/specs/devlink.yaml      |   4 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 120 +++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 192 ++++++++++---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   9 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  14 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  88 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  14 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 269 ++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../marvell/octeontx2/nic/otx2_pf.c          |   6 +-
 include/net/devlink.h                         |   8 +
 include/uapi/linux/devlink.h                 |   1 +
 net/devlink/netlink_gen.c                     |   2 +
 net/devlink/param.c                           |  78 +++--
 16 files changed, 674 insertions(+), 136 deletions(-)

--
v2 -> v3: Addressed Simon comments.
	https://lore.kernel.org/netdev/20260304043032.3661647-1-rkannoth@marvell.com/
v1 -> v2: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260302085803.2449828-1-rkannoth@marvell.com/#t

2.43.0
