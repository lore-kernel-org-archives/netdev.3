Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9B3B9949;
	Tue, 21 Jul 2026 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621920; cv=none; b=dttaTwLGX2akOXPMkbBMlHOEs0wqwXI/F0d62PZvBu2VWpvrwz0GQO6KmY2b2o5Uh6MXcmO36ghS2vH67OOFd3S41UjBZau1Mtk4lnC+Zjhtqo2s5pZH2tf9esAO2Iqt0P8F1L+9ZSDmDdSgcbAPN6Cpyd/FjdZ2m6zmJv5RtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621920; c=relaxed/simple;
	bh=LWNVcWzXe0fl4FjW/FJda3E24B/lEgQ4it97HgnzvQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qm24oLkGOoA8vwmYxBmtjQpQ4u/mWZaX0OQ3DQuLWn8Ejl5aXTWvIcFOz5cF2qy17jI9AgJRXthPDNCUlA3fQc9znYOVRC7mEGPIH6rk/tUoBofPmYYssHk93cTkEuO2pLXt0/vCzf44XBiYPUiJz2q4W1Vo97ym3SblM24pJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KzwKOBFQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KzwKOBFQ"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNcWLa3069960;
	Tue, 21 Jul 2026 01:18:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=yf5Qvqo3WmdG8ycJU3M+OZi
	97bIIY35LrsSLb2AqPpA=; b=KzwKOBFQ24JH0+6rnoX/PQ4mMTnEQaiLMw068fv
	Qracp/R5+YHV7XnVpmRsNDGgbNiTwUJD0pONm6I4hN69twniUBtadJ90cFMbWRa2
	ffYFJuLsS6aYd9naQvaDECwdXfJZUrSRMAZoPCR5qZxFOCmjnyr/YXnydakzN4UD
	F4EcLsXCeqPdIw2TmJwsZv20phPrv0nv0JED0d3uagmX3znI7/JxTIMS2LrQ7juk
	7uMLMCelx6iyQCmfwSiVQmv+Oj41lr76mj5SSlodGhsQ9qqrQ4/FtoDLghEm6l8e
	+5FfBeCfT4mlNsUnkkpym6eFsKCyHu/EIiRFVOFPLQh6bbw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fhwdkh6yd-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 01:18:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 01:18:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 01:18:30 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 95A0B3F7070;
	Tue, 21 Jul 2026 01:18:27 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net-next 0/9] Switch support
Date: Tue, 21 Jul 2026 13:48:15 +0530
Message-ID: <20260721081824.1430607-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8kYYlJ5QaWmVgtCtRGSiyWopapdUcFPj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX6WgRAZyftJfZ
 l66OZE+QPVd2fhoILTp2vzvZGczMNBu/kyVsn0G0o+zh0um3X795ZFer2WU3VhrQBGcIxkKp5L8
 zsRM0cnXZ/aTgiZW4WIVxGti/rLsBjY=
X-Authority-Analysis: v=2.4 cv=TrXWQjXh c=1 sm=1 tr=0 ts=6a5f2b56 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=Q9e_prp1UuIZLeogYfEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 8kYYlJ5QaWmVgtCtRGSiyWopapdUcFPj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX85kHbs6leR1n
 lW2TXPY3U4NOlGcWgqfMnw+pcC3EoZ7X14sS3+F9xEixXD5Y/DeOLx+XmC/IcPBhZv6o9naYeVY
 +Tly5Fp1QEX96+mgfq2hS4aoECfH9yKvT2Z1yzVgXRQvGwKmTlO0Mpd0rf6IfAJX7HVLDFPmga2
 XCR0c5XLtjNBxI754+kjvU7v7Frm8KVYWT0DxNBkt5Y3xXXQmQs3GLLFXNpsQhqDB+eKO1kKbm8
 QlMGaiCJX2sBf7sZWbBagHGt5gCmhn2rKX2gNw4jnlgKq7lVjrNHDLLlfsvj+1z/8uBHS13Ditu
 Dl3Iu/XFwZwMOXDx3tQFsmZxhJCTmJEbs05HxIFph7iON2PX/8fNTtKjavDZmr/kXNriPLj1gxA
 ERTHe9ERr9uivo4bHkNqI3Vsh+yts7t2+btPgQng2M+DUWWuJuTu9Oaqmty930EhrjkhIrhBEWK
 kVXdyA9RVGcoMbxcylg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

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
v3 -> v4: Addressed Sashiko comments
	https://lore.kernel.org/netdev/20260714015331.1801922-1-rkannoth@marvell.com/

v2 -> v3: Addressed Pabolo comments.
	https://lore.kernel.org/netdev/20260702045026.2914748-1-rkannoth@marvell.com/

v1 -> v2: Addressed Jakub comments
	https://lore.kernel.org/netdev/20260630024715.4124281-1-rkannoth@marvell.com/

--
2.43.0
