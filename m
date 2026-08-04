Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75399443AAD;
	Tue,  4 Aug 2026 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840449; cv=none; b=knQI7Kvr6Y7fLn5Vqu/oN3mAk7tnGD3uj1pae2WBZE8P8zjslsTs8qRKAWhbCtnlAeoaiFlzNamCq05QD9zq1HGMjJ1IhAIYQIHzqpEQtR6JM3incx1qSDNcL9T1zDlglxahkvDq2ujafmvEa5XfpOWSn40pjb5wK9J/BhYa7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840449; c=relaxed/simple;
	bh=H+uUsBbxtY54u2SvsauU6SG3nWcMcxlXxDQNLzBQdHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IlshG2xZ4/VQDrimnO4A5yAe6cTrJefPukb52ewjCVZ1P/jMJq0DphuL814YngnEe/3m7gJ3JxjeU+UT2GFkHFc0+d5z3P26PUrgconC8y5dqcxCuhmc3CXxQRbtbmkGBEeGE5eaq3MDluHSf/sSISs9KPt1UpnlGrNOF2hEu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fCZ09BEI; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fCZ09BEI"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6749c3nf2676682;
	Tue, 4 Aug 2026 03:47:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=VmhXdwV3O6l6BNO6RhwLxtG
	PAUz8ynUIRn6wLtOHyqA=; b=fCZ09BEIvFrg3zLq2/FrywnK9IDnipSua+FXQ3l
	m++vxo9YlQQsqLuxa/OH7cDe6e4AbHIiTBjA93QH4mSPKoywAgwqIelvcTGkLA9Y
	G+zjW9RxqjadAjahv3+Bnduf5SwDgLgxNk60vb/648AGh2D9i0XY+mkkRJGScVr6
	pmpvgkGF9L1mxzdJ/O0bfTC2TrHm/r8a8sxg5zg8JxeF48Tppx/+ycvPPItoPB+A
	pxfECk0YTLqefExVrxiRU6IMvPRqjO1RQoDjdnJ53IMUWL/XE61GJqxo12tAGM4z
	pfTuMlt6Y786FfY7IlAsF9Zgn9ImoQaR/biNAuJ2hFkYgTQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ft5266py4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 03:47:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 4 Aug 2026 03:47:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 4 Aug 2026 03:47:13 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 5A4045B693A;
	Tue,  4 Aug 2026 03:47:10 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v7 net-next 0/9] Switch support
Date: Tue, 4 Aug 2026 16:16:57 +0530
Message-ID: <20260804104706.120996-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VdbH+lp9 c=1 sm=1 tr=0 ts=6a71c332 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=Edpnf-iy1bkNsFY8i2QA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: hiuYd9Ng103liUahvQ-nBCBJiEQ0d8le
X-Proofpoint-GUID: hiuYd9Ng103liUahvQ-nBCBJiEQ0d8le
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfX3XkWG11zCd1s
 kRr9ZdSZioc2ASv3EDZ9Z6iMsIbczv50rUobX3bKvI/Q5faTuXxUH/HyW5XJVY6Fkdf/roAVco1
 YSOv7KLR0k3f1Tm/sesFRKlJtVjpNE8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfX1kz87S+/tA12
 +DYH6qCMbB4oSphD3K9kgBFBm1nbSMU/vku5dImDsdiZ5tBI3l4sMdJyID1td1PpPTl2ik+Tvg6
 ID2C8ZPNojimZl12GIzg3s7UeXbUfu5l1X6gdy/T2SOMcmsvwF8u9f+lxjrPDPFnP1a9LWmbtLo
 YUQb8Unc3/kZQ95nEZ3uw19YSBZzhrD61eKEOWlWYX3ml4q9FJOz6rzBVzyUShTKKyr1e0wxNEq
 VpatcK8d9o9rVBL8Lc5oLdmrknz46+M/skrQDPR5o/BaiJLTipqPv/ucDwa6Tu8ICfOtlRjrrXb
 Ka+7bYgSXKr8a2b7+1/fmQ5CjIpNBJYav+JcTALF8kHixp0kxaBCg9BlCw/8OGM2hEYUeZfAhb8
 o6dluz1CqQHLG0LTBKu7qBCClBGK0bgCC11rX3C5gC8Pk7qZb4KEyeX7jcxXshHOET0NoGbayDf
 a0PL8bFRwt6aPMte4hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01

Marvell OcteonTX2 switch hardware is capable of accelerating L2, L3, and
flow. When representors are enabled through devlink, a logical port is
created in switch hardware for each representor device.

This patch series implements communication from the host OS to the switch
hardware and vice versa.

                 control plane (FDB / FIB / flow over mailbox)
    +---------------------------------------------------------------------+
    |                               HOST OS                               |
    |                                                                     |
    | +------------+  +---------------------+  +---------------+          |
    | | bridge /   |  | PF + notifiers      |  | TC / flower   |          |
    | | routing    |  | (FDB, FIB, flow)    |  | offload       |          |
    | +------+-----+  +-----------+---------+  +-------+-------+          |
    |        ^                     |                      |               |
    |        | slow path           |                      |               |
    |        | (unmatched pkts)    v                      v               |
    | +------+------+       +------+------+        +------+------+        |
    | | rep-eth0    |       | PF / VF     | <----> | RVU AF      |        |
    | +------+------+       +-------------+        +------+------+        |
    |        |                                                |           |
    | +------+------+                                         |           |
    | | rep-eth1    |                                         |           |
    | +-------------+                                         |           |
    |        | slow path (miss / control to host stack)       |           |
    +---------------------------------------------------------------------+
    |      |                                         |                    |
    |      |              mailbox / PCIe             |                    |
    |      v                                         v                    |
    +---------------------------------------------------------------------+
    |                           SWITCH HARDWARE                           |
    |                                                                     |
    |      +---------------------------------------------------+          |
    |      | L2 tables   | L3 tables   | flow TCAM (HW)        |          |
    |      +-------+-------------+---------------+-------------+          |
    |              |       fast path (HW)           |                     |
    |              v                                v                     |
    |           lport0  <========================>  lport1                |
    |             HW forwarding between ports                             |
    |                                                                     |
    | slow path (miss): packets raised to host via representors           |
    +---------------------------------------------------------------------+

When representors are created, corresponding logical ports are created in
switchdev. Matching traffic is accelerated in switch hardware using
installed L2, L3, and flow rules. Packets that do not match offloaded
state, or that require software handling, take the slow path through
representors and the host networking stack. Control updates from the host
(FDB, FIB, TC flower) are sent to the AF over mailbox and programmed into
switch hardware tables.

Notifier callbacks are registered to receive system events such as FDB
add/delete and FIB add/delete. Flow add/delete operations are handled
through the ingress flow-table offload path. These events are captured and
processed by the NIC driver and forwarded to the switch device through the
AF driver. All message exchanges use the mailbox interface.

Bridge acceleration:
FDB add/delete notifications are processed, and learned SMAC information is
sent to the switch hardware. The switch inserts a hardware rule to
accelerate packets destined to the MAC address. Switch-initiated FDB
refresh is propagated back to the host bridge through an AF to PF/VF
mailbox and switchdev notifier.

L3 acceleration:
IPv4 and IPv6 FIB updates observed through netdev and FIB notifiers are
queued on the PF and sent to the AF. The AF batches fib_entry structures
and forwards them to switchdev when firmware is ready.

Flow acceleration:
TC flower rules accepted by the ingress flow-table offload callback are
translated into fl_tuple state, ingress and egress pcifunc are resolved
through FIB lookup, and flow updates are sent to the switch hardware
through the mailbox interface. Per-cookie packet counters are kept in sync
using NPC MCAM multi-stats when the switch requests a flow refresh.

Ratheesh Kannoth (9):
  octeontx2-af: switch: Add AF to switch mbox and skeleton files
  Host to switch mailbox definitions for FDB, FIB, flow, and flow stats;
  AF-side L2/L3/flow skeleton objects.

  octeontx2-af: switch: Add switch dev to AF mboxes
  Switch to AF and AF to switchdev mailbox messages; interface query
  handler and NPC helpers for flow delete/stats/features.

  octeontx2-pf: switch: Add pf files hierarchy
  CONFIG_OCTEONTX_SWITCH and stub PF switch objects for FDB, FIB, flow, and
  notifier plumbing.

  octeontx2-af: switch: Representor for switch port
  Copy devlink switch_id to the AF and map representor pcifunc to a switch
  port id when eswitch mode is enabled.

  octeontx2-af: PAN switch TL1 scheduling and NPC channel control
  Allocate multiple TL1 scheduler queues in PAN mode and honor caller
  supplied NPC channel masks for multi-link steering.

  octeontx2-pf: register switch notifiers for eswitch offload
  Register PF notifier blocks for FIB, neighbour, address, netdev, and
  switchdev FDB events; split IPv4/IPv6 handling.

  octeontx2: plumb bridge FDB updates through AF and switchdev
  End-to-end L2 offload from switchdev FDB notifications to AF to
  switchdev, including firmware gating and FDB refresh to host.

  octeontx2: offload host FIB updates to switch via AF mailbox
  Queue IPv4/IPv6 FIB updates from notifiers and batch fib_entry delivery
  from AF to switchdev.

  octeontx2: add TC flow offload path for switch flows
  Ingress flow-table offload for TC flower rules, AF forwarding to
  switchdev, and flow counter refresh from switch to host.

 .../net/ethernet/marvell/octeontx2/Kconfig    |  13 +
 .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 227 ++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 110 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  53 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  76 +++
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  11 +
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   |   3 +-
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  48 ++
 .../marvell/octeontx2/af/switch/rvu_sw.h      |  14 +
 .../marvell/octeontx2/af/switch/rvu_sw_fl.c   | 294 ++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.h   |  12 +
 .../marvell/octeontx2/af/switch/rvu_sw_l2.c   | 283 +++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.h   |  13 +
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 215 +++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.h   |  11 +
 .../ethernet/marvell/octeontx2/nic/Makefile   |  13 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c   |  17 +
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  11 +
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 144 +++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h     |  14 +
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 132 +++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     |  16 +
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 546 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h      |  15 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 422 ++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.h      |  35 ++
 .../marvell/octeontx2/nic/switch/sw_nb_v4.c   | 335 +++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb_v4.h   |  21 +
 .../marvell/octeontx2/nic/switch/sw_nb_v6.c   | 236 ++++++++
 .../marvell/octeontx2/nic/switch/sw_nb_v6.h   |  21 +
 33 files changed, 3361 insertions(+), 11 deletions(-)

---

v6 -> v7: Addressed Sashiko comments
	https://lore.kernel.org/netdev/20260729045100.2177958-1-rkannoth@marvell.com/

v5 -> v6: Addressed Jakub/Sashiko comments
	https://lore.kernel.org/netdev/20260724094018.3213907-1-rkannoth@marvell.com/

v4 -> v5: Addressed Sashiko comments
	https://lore.kernel.org/netdev/20260721081824.1430607-1-rkannoth@marvell.com/

v3 -> v4: Addressed Sashiko comments
	https://lore.kernel.org/netdev/20260714015331.1801922-1-rkannoth@marvell.com/

v2 -> v3: Addressed Pabolo comments.
	https://lore.kernel.org/netdev/20260702045026.2914748-1-rkannoth@marvell.com/

v1 -> v2: Addressed Jakub comments
	https://lore.kernel.org/netdev/20260630024715.4124281-1-rkannoth@marvell.com/

--
2.43.0
