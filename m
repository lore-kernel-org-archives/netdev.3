Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486044137BE;
	Fri, 24 Jul 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886040; cv=none; b=CMnKHtzbRvjqo5rpMAD2X3tZuy7i1wdXoWG9cxetC5YscR3RRzNWjzKLUiU9xiLgL/BOxX281W8hd5iNs52weAjkFz8KYuKUcZuEYPBk+W4MsSEvDlzIadjL4NupwiOXCVyTYR2mUaaJhc6kXc3DU65hLNgoXt+E/hazhXKy7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886040; c=relaxed/simple;
	bh=x9Kc8IlRkUTmFIIyNLAIwdcBdxFceiHkiPKkaw++qC0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uHJFFuYLp8XSQiruiG7qtUsWxbE07OUJliEjXo8czDORl5xUrdmM9zUDpghgMwQfZhBMD8JtYujboGUY2bJrFn8BeY4DjL1swY7QONgXAhLUtRkSF26HzZwCEJYkVMeBO10ZwAAyE9Htp1eurYjcWBadrJaUbx8sXgxq/6qwLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YNO5nQz0; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YNO5nQz0"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4mMtQ907480;
	Fri, 24 Jul 2026 02:40:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=J395ef1jpIgEmDO7zFFsYzn
	76K/RGaqS8xFrQnZxE4M=; b=YNO5nQz06574CRpvLI1HVjQbJbp1GzS6deH3Ae0
	vkrrSMYu+8PqlNQV7732wnTbZ5etYD0Ip44TjV2T3eZm3VOQQDMX2zOCFCIijgDC
	Z9cDNfeJQb/kR8RXGLPqypV6MmL7K07NjLg9lqhvdITQuzcdBufViSz+3CGNRGTo
	hpgltNZ+boGWX+NEbfKVMVut/gKRyjFFj3vi5gHqXVoj8q1CaB8SEkNyFD/rhSK1
	lTVs0u3riVks8GA6RMZHoErbwyzKL1OtaN3d11cuH3xUpghJxlGNDA3ViyE4NX2E
	3VFwIejoYFr0VvTyZH3H3msIRzTwO7mwTWJACF9SCxkjBGw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fka6kcm5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 02:40:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Jul 2026 02:40:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Jul 2026 02:40:29 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 786E33F7081;
	Fri, 24 Jul 2026 02:40:26 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v5 net-next 0/9] Switch support
Date: Fri, 24 Jul 2026 15:10:09 +0530
Message-ID: <20260724094018.3213907-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX7UeOlyCOMGxK
 YCgQwkPrMLnwMuALrEMz+dhr6i47S8XhxJIYfzVu23mVIFO30OviH4Qx+Le9BSiRmdbQwXBL7wV
 ZCEbPCR67sUwpg3cMubTWNwWRRcwyh8=
X-Proofpoint-GUID: 2iC5ppZIf7OgbjGuEG3l7iQ1tbZmVgEY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX1mjFudSQH1iJ
 y9sDJW3PI2zpvsnEG3Te1ELw63F3AFB53aBe6pXb6AAWOcZyWO5Hnh2eWWdGiaCLzLp4AtLT5sz
 t97BH2cl/Iq9uplkXDpAIC3dia05nIFbUf21niiy+aX+qKlFf84AMaPgy3st4NWHlaBZ4KL45dd
 FTW2vo2JxmWa42db/Knla/4/JXHhW4+Fr9c16QVtrJ+gyQknNKCZd1PXRcMHBGFbP7/MjHjNTCB
 XQHbHRo04oha83uOCdVzGGocU0DU3z7eW4qoxPb8TcPpw4YnQwSaIYWq01HlPHekGXf9U5UWnz6
 OXeB6xjui6Yn50GA83zCTHoXWdwsLMnI/VvW1CtyCeImY7tGR3DWtdDQZy2f50Ncq4SW0/63UoG
 lfvw5OLO0qp0tpriQuolC+tYwkwce4mfn06VjXGu/XTneVtgIFvG/pw3teS4bDM0sn5+Xhb3nJU
 2VkEVI/D+biiiCgHbHA==
X-Proofpoint-ORIG-GUID: 2iC5ppZIf7OgbjGuEG3l7iQ1tbZmVgEY
X-Authority-Analysis: v=2.4 cv=Ccs4Irrl c=1 sm=1 tr=0 ts=6a63330e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=Q9e_prp1UuIZLeogYfEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01

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
