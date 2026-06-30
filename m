Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668523C6606;
	Tue, 30 Jun 2026 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787659; cv=none; b=LnhHfb9JFyH+djHkI21c1kbl+ppIdA1pPoguptTg88KyCrTqCF43px17rA5E8xF3nvG0oX6JQBylNLFh/nHR/y3GSIKvVW6M+RzGGeeZcTD1yGdYnJvblLP97J7/vLw2hCnYB8jvaXgsPz6ULHIXrftAJyHCoFQrMgvPeGk+EJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787659; c=relaxed/simple;
	bh=xvoYFtB+SS3Z3AfxxeI2uqZ+SQXkmWgI6wXqf/D6i6k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=minXPiKoL2q/3iwXMK8o8QbexkjZLgqBrBnpMsF1yDnGEHqccNvdKk+uZ8YMgbZjtT6bKEbe6zCvf2amwaKdW0svc80Qp6jox4UvKawqe7QuIvky7X9yO8KX904SF7AmToJV+Mz7FyJAdWGEBKWpS0HnzvECJvEqz2W0J8YhR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ELf7Npk4; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ELf7Npk4"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1J8UL3490377;
	Mon, 29 Jun 2026 19:47:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=JKc8bNJQ4AXz6BRVoSdAw7H
	qlrzzuQGaHJfMifmWrjY=; b=ELf7Npk4Ze3XokyN8VwfYCBfNnS2aaKTplxDmFm
	5sJhwHhYUsJGokzDTW6MFnXPxzRyu5Oy7A6mzCr1Wc2zcb21gQ1lC4xFrY+aoCcH
	Ycp1WIxfLPwR5I7LAa8Xj8xxwkQ1SFM2ANJwHRXSqmalVk6Npha75DckOIgxIIsX
	Oo3I9scHTGAy2uqTwU1ULNKYCQASMv6m2EOLv1I3tzoO4enLFjvfpE8EEbvTP/bQ
	CSYs9eWRFBeM+XfSsLBsRHDbhLnt4iTxiwjJN54ScStgMRK7a1y+PkDmC3A/Xbuv
	yqXTVu1ThBzibn00tQkfxlczgyoIS1xCu1/2mBOz2Gss/QA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f2e1h7ynw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 19:47:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 19:47:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 19:47:26 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 71F053F705B;
	Mon, 29 Jun 2026 19:47:24 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next 0/9] Switch support
Date: Tue, 30 Jun 2026 08:17:06 +0530
Message-ID: <20260630024715.4124281-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GHcOG7pQsPc0qA5W2HY5jXPtonXvP-oX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAyNCBTYWx0ZWRfX41VF7GRN9eGY
 +wBSEj2RR8uRUJX1LSGenXCOQyh5ZpUbbaQZNk4N4RxgU+Y3zTG6JYwl27tEMHNcTj0lQCGTmr2
 B1cCQnK3z4kTWq8X3Z+FR+ZkhioVosw=
X-Authority-Analysis: v=2.4 cv=e802j6p/ c=1 sm=1 tr=0 ts=6a432e40 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=Edpnf-iy1bkNsFY8i2QA:9
X-Proofpoint-GUID: GHcOG7pQsPc0qA5W2HY5jXPtonXvP-oX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAyNCBTYWx0ZWRfX34VKsUfVNoY4
 XyJTYKRB7+B9eh6T62IH6Qe4ZnlVHuew5NJ/fcYjTdXZVvfKQjiF/jUmloVLJoD508sFd9M6C2X
 I0grfXjHAW+4UnQxDW2OiO+QGOe9sfi24/ItltoqGOY/4lGLNADaPY6PshcnVpEcn4IU83HsY0a
 9IzU0RJbxMSeX9p2saCGBwM0l3krl84zxIogVV7CcYvJ5LT72S42C+KBlASZbYZq83OrBcwvyH0
 Be77cKeMBme2n3tqDUA/fByJh1NdUT8D2dU0HZPPE5W6Hc/Br2lPBw29Fp3s+lMdmOuY7Nq9JNq
 EKC611kYKThkoQmzMX0QcByTJmymNTDGx0kMv5mEsJvA8WD7KGb2GBeAfEH0TYCzI71ValovRK6
 9bYGUTTkMcNFTjGh877Wkie4ceRrBZxkEz4iPFq8sa12jYEBJNKGuaoP0wbTt5sVvZdznUDt5GR
 fVd4jg86t8hQ+lFikQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01

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
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h

--
2.43.0
