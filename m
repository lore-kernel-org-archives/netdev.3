Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30F41DE11;
	Fri, 16 Oct 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137559; cv=none; b=A+gBGQKbSW8zSkwKxvfpOb3bjY53ZcdI0KGrzej6BntZHr1N7oCyMsZCry4vvMKi+f/TU2wqX8QGAdGKuhJi131vNN3Q7ZWdePXCsnL2qU+t1divaV5pvHwSimbrHAhXZ237Ea6puXovvjDFMMIKGKWTijNVh559CmLVQRc9pk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137559; c=relaxed/simple;
	bh=C6Nad8KCkCFAOts683le8A3yaMLgPuV5KaaLaN7kBqo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qj9pwlPfk5kpQCC1mvE5L95lQWBlwCoF/HiNntU7CLZr6Bg5KeRF67MCDRQE2bdR5iF+Y7c0x7X+pk7RC/6lTTkaQ1TIVTDHqtSKKE4tMkm+JavgrH9xXnla4EKHG1Yo/OfZ23VMETHb5JshXtMuolmAZnlKapuaYEK+s/CO/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=RC1azOPy; arc=none smtp.client-ip=173.37.86.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="RC1azOPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=9366; q=dns/txt;
  s=iport01; t=1792137557; x=1793347157;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=1R2Ks/OJJXb7mc2RGcNgHW2l3A2ub2wiNtJC4dUAVYI=;
  b=RC1azOPy7RZKkQKmV9DmKGdNp//452Stc76T/+Q9oHciahqOSYFRfBiq
   TVet8703syHeHB2ZccR+vz0IrS17Y8K0lm6oUKLRRblKUXSx/9VMHGZfG
   cc2h+VGc+l7obxBEb2Vi/qTpJU+Rk6LztmIYvr1gh7Kh5rfd9Zu4ZDAas
   D9IvaCi++93PYQeXfHMwcH3ImUOspq1L0QO9g+CuA3Agf8p3PE0en3Vkx
   HZ9T3HIK6nwEwI0MXzG6hldJJlzYdyuh7+SNcC/5ehIt9CGJGUwCU3qO6
   DP2JvmRxkPpmpy8MQY4TWmICvtEAABg2t/mrHi+tp6zuzdSVmjFBWJm28
   Q==;
X-CSE-ConnectionGUID: VbBwNZNDSdqnDqg++ffaJg==
X-CSE-MsgGUID: 7zidCPuwQiyux1+7yrVe7w==
X-IPAS-Result: =?us-ascii?q?A0BjAwCT19Fq/4z/Ja1QAQkeAQELEgxMgTkLg0xgQ0mEV?=
 =?us-ascii?q?49SgiGBFpA3jFIUgWoPAQEBD0QNBAEBhQVRFY0xAiY0CQ4BAgQDAgMBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZPDZAVJyQgEjUCJgJIFgESgwIBgnQDE?=
 =?us-ascii?q?QUBvRd6gTKBAYJPgi/ZSoFuBhWBCi6BYYQRgm0BgXGECDuEQRcQG4FJRIEVg?=
 =?us-ascii?q?ilKdoQWAQgLg3SCagSBDn8VgQyCXYQLh0mIcAk/gQIcA1ksAVUTDQoLBwVjU?=
 =?us-ascii?q?jMDIAoLEhIYFQIUHRIPBBYyHXAMJxIsFy9YGwYFgR11FAQTghYjGTZ6gQleg?=
 =?us-ascii?q?SspYAEQF4EJggcCglSCAAIBSUEOB0VTCSVDEkcmIggSCQETGjALgRs4PAkoQ?=
 =?us-ascii?q?RcMcQIJAx0FTgIiCAINCQcpGA1IESw3Bg8ZBD0BbgeSFB6BcgEBPCUPARYJM?=
 =?us-ascii?q?QMFASIDBgsHAgEbBlBBCAEpJRUGAQECDAEFBhIBCSOQJ4JVQoM8jCiBNmuBN?=
 =?us-ascii?q?YEZnkGEKIFmijyVVDOXZ5MImQgjjWeKHotDBg8MTYRpgWg8gVkzGggbFTuCZ?=
 =?us-ascii?q?1MZD44uFocyi2sBvxwnMgI7AgcCBw4DC4ZGiyQPFweBTwEB?=
IronPort-Data: A9a23:LWoeLqPOdJFe3E3vrR13lsFynXyQoLVcMsEvi/4bfWQNrUoqhTEGy
 modWT3TPfiKMGv9c90gPdu18BwD78LTxodrHHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeap1yFjmD9k/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVzlV
 e/a+ZWFZgb9gmAsawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj68tkJl4QD6s0wepuB01X+
 r9bJj4ETB/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmCS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzNHwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQsi+WzbYqKJ4ziqcN9wVSZq
 kn+4nvAAwAHJIXcliufzH/zmbqa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pSJ
 1ER8zgjsYAx+VatQ927WAe3yFaEuQQZQPJTHvc85QXLzbDbiy6aG2INZj1MctorsIkxXzNC/
 laPk8nkGn9pvaGZRGy18qqSq3W5OUA9NWYIaCkFZREI79nqvMc4iRenZtJiFrOly974Azf9x
 xiUoyUkwbYel8gG0+O851+vqzShupTEUCYr6QjNGGGo9AV0YMiifYPA1LTAxexLIIDcShyKu
 2IJ3pDFqusPFpqK0ieKRY3hAY2U2hpMCxWE6XYHInXr323FF6KLFWyI3AxDGQ==
IronPort-HdrOrdr: A9a23:in3TjqDShOzMl4jlHeky55DYdb4zR+YMi2TDGXoBLSC9Ffb5qy
 nOppUmPHDP5Ar5NEtLpTniAse9qA3nmqKdiLN5VdyftWLd1VdAQrsSiLfK8nnKRmnC7eZW16
 dmfcFFeb7NJGk/p8fz5we1V/YMqeP3kpyAtKPyw2hgSAdyZ7olzQtoYzzra3FedU1qCYU0EZ
 yE6tECnTqvfnwLct+2b0N1OdQr3+e7867OUFohGwMt7hWIgHeD7b73FAXd4zIlOgk/uYvLNQ
 P+4nbEDmLJiYDB9iPh
X-Talos-CUID: 9a23:w+ObZ2F8k7vh9J94qmJZ/mQLPPIDXkbR1XH8OkD7SmhnQZ+aHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ApISUhQwLT5icCYaDY70dDPYBxF+aqPu8CUwmqYg?=
 =?us-ascii?q?ZgsiVKDwpeGiMlgq6HZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,161,1787011200"; 
   d="scan'208";a="535658758"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 16 Oct 2026 07:58:08 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 832791800059F;
	Fri, 16 Oct 2026 07:58:07 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net 0/3] enic: fence DMA ownership and identify V2 VFs
Date: Fri, 16 Oct 2026 00:57:50 -0700
Message-Id: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7Y0WoC/z2NywrCMBBFf6XM2oGkD0F/RVzkMakjOEomDYXSf
 zcquDwXzrkbKGUmhXO3QabKyk9pYA8dhJuTmZBjY+hNf7TGGvQjknDA+HBYE7JEWlGo4EzSUgE
 TZy1YLf6VeHI+jZM1wzBBC78yJV6/pxdoKlx/oy7+TqF87mDf38oHFrKbAAAA
X-Change-ID: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792137487; l=9464;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=C6Nad8KCkCFAOts683le8A3yaMLgPuV5KaaLaN7kBqo=;
 b=ovxWWE3kR54k4Shui115tgUesMLhYhUzFQ2gxS0EwUEqFleGRdiMR+5tWYyOYD/mQN5aWEI+M
 VKDGrrhwvTgDj0ZdUTFQvgVgJOJd24p9TUDnOQrG4lYmmgPTbpGdL9I
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-03.cisco.com

An automated Sashiko review of the V2 SR-IOV reset paths prompted a
broader audit of ENIC queue teardown. That audit found three prerequisite
correctness problems in code which is already upstream.

First, a datapath WQ or RQ disable can time out while hardware may still
own descriptors and their DMA mappings. Patch 1 replaces iteration-counted
polling with a bounded 500 ms RUNNING poll for each queue. The RQ keeps its
required two disable-and-poll passes. The datapath graph is released only
after every applicable queue reports RUNNING == 0. Because rings, mapped
buffers, page pools, and shared state form a coupled ownership graph, it is
not partially released when only some queues stop.

The queue-disable helpers can return -ETIMEDOUT without observing
RUNNING == 0. Firmware defines RUNNING == 0 as conclusive evidence that
queue DMA has stopped. A nonzero RUNNING value does not establish that
DMA is active, but it leaves DMA ownership unresolved. The existing error
path can nevertheless release DMA-backed resources without obtaining the
required ownership proof.

This series deliberately retains the complete datapath graph if any
datapath queue does not report RUNNING == 0. This can retain resources
belonging to queues which did stop, but keeps the ownership rule simple
in an exceptional failure path. Reclaiming packet buffers individually for
queues which successfully stop is a possible follow-up optimization; it
is not required to prevent DMA into freed memory.

If a queue does not report RUNNING == 0, the whole datapath graph is
quarantined. A final direct queue recheck runs during device removal,
before terminal containment. The graph is released if every queue reports
RUNNING == 0 by then; otherwise it is retained until reboot. Firmware soft
reset, hang reset, and PCI function reset are not treated as independent
ownership proof for a queue whose stop could not be confirmed.

The terminal path detaches CPU entry points, clears bus mastering, disables
the PCI function, and intentionally retains the netdev, vnic_dev, BAR
mappings and reservations, rings, mapped buffers, page pools, and graph
metadata until reboot. Clearing bus mastering blocks new device-initiated
PCI transactions; it does not cancel DMA already in progress or prevent a
queue from draining to RUNNING == 0. The final remove-time recheck
therefore remains meaningful, but bus-master state alone does not prove
that a queue with unresolved DMA ownership relinquished its old targets.
The BAR reservation may outlive driver unbind and module unload while the
PCI device remains enumerated. The resource subsystem stores the supplied
owner-name pointer rather than copying it, so the reservation uses the PCI
device name instead of module rodata.

A PCI driver's remove callback cannot reject driver unbind. With DMA API
debugging enabled, the driver's deliberate retention therefore produces the
expected "pending DMA allocations while released from device" diagnostic
if the module is unloaded after terminal quarantine. The retained BAR
reservation prevents a normal ENIC rebind; reboot is the supported
recovery.

Ring resizing needs an explicit stop because dev_close() cannot propagate
an ndo_stop() error. Patch 1 returns a queue-disable failure to ethtool and
rejects later reconfiguration after quarantine. It also makes reset, IRQ,
NAPI, notification-buffer, and final-remove ownership transitions
idempotent.

Second, an admin-WQ send can time out while hardware may still own the
descriptor and mapping. Patch 2 applies the same bounded polling,
observed-queue-stop rule, and final remove-time recheck to the admin WQ/RQ
graph. The datapath and admin channel are independent complete graphs: a
clean graph may be released even when the other is quarantined, but an
individual graph is never partially released. Shared objects needed by an
unresolved DMA target remain retained. Putting the generic repair first
makes every committed state independently safe.

Third, the in-tree V2 VF always transmits mailbox source zero. Deployed
async PFs compare that field with sender identity from CQ metadata, so a
nonzero VF cannot register. Patch 3 obtains firmware's logical VF index
with CMD_SRIOV_STATS_GET after the admin channel is live and uses it as the
source of subsequent V2 VF mailbox messages.

Patch 3 also requires DEVCMD2 for SR-IOV V2. A V2 VF without DEVCMD2
fails probe before opening its admin channel. A PF which fell back to
DEVCMD1 keeps ordinary Ethernet operation but does not expose V2 SR-IOV;
V1 and USNIC keep their existing DEVCMD1 fallback. With DEVCMD2, -ENODEV
is detected before a descriptor is posted, so only a timeout can leave
ownership of the persistent statistics-command DMA target uncertain. A
later successful blocking command for the same vNIC proves that target
completed; otherwise it remains retained with the shared vNIC lifetime
envelope until reboot.

The companion V2 VF receive-control v3 series carries explicit prerequisite
patch IDs for all three patches.

AI assistance:

An LLM was used for design review, source review, commit-message drafting,
test automation, and review triage. Sashiko was used as an additional
review tool. All findings and generated changes were manually reviewed, and
the author takes responsibility for the series.

Validation:

- Tests used Cisco VIC PF and V2 VF functions. PF/VF probe, open/close,
  repeated clean module unload/reload, link cycling, ring resizing, jumbo
  MTU, and bidirectional ICMP, TCP, and UDP traffic passed.
- A nonzero V2 VF registered and passed traffic with the deployed async PF.
  Before patch 3, the PF rejected the VF's zero mailbox source because it
  did not match the sender identity obtained from CQ metadata.
- The full no-reboot suite exercised exactly 32 secondary unicast
  addresses, 33-address fallback, address churn, station-address
  multicast-list changes, administrative-MAC policy, 25 module reloads,
  10 ring resize cycles, 10 reopen cycles, and five VF destroy/recreate
  cycles.
- A test-only admin-channel overlay injected one false first-attempt WQ
  disable failure and then one false first-attempt RQ disable failure after
  the corresponding real hardware disable had succeeded. Each failed helper
  alone was retried, each retry succeeded, and the production module
  then passed bidirectional traffic.
- A test-only V2 VF overlay forced exactly one posted mailbox send timeout.
  Serialized reset recovery rebuilt the admin channel, refreshed the
  administrative MAC, restored bidirectional traffic, and completed a later
  exact-filter transaction.
- A disposable-VF-guest test overlay held the selected WQ or RQ's observed
  RUNNING value high without preventing the real hardware disable. A 300 ms
  hold verified that both queue types wait rather than time out early. A
  hold through the 500 ms bound quarantined each datapath and admin queue
  path. Clearing the synthetic condition before removal let the final
  recheck release each complete graph. Leaving it set exercised terminal
  retention. The uninstrumented candidate then bound and passed
  bidirectional ENIC traffic after guest reboot.

Queue-stop failure handling was exercised using instrumentation which
kept the RUNNING value observed by the driver nonzero after the underlying
hardware queue had stopped. This exercised the bounded polling,
quarantine, retained-resource, and final remove-time recheck paths. It
validates the driver's handling when RUNNING == 0 is not observed; it does
not attempt to reproduce or characterize the underlying hardware condition
which produces that result. If ownership remains unresolved at removal,
reboot is the supported recovery.

The DEVCMD2 requirement and pre-admin-channel V2 VF rejection were
verified by source review and exact per-commit builds. The physical test
adapter uses DEVCMD2, so the no-DEVCMD2 rejection path was not exercised
on hardware.

Link: https://patch.msgid.link/20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Satish Kharat (3):
      enic: retain datapath DMA resources until queues stop
      enic: retain admin-channel DMA until queues stop
      enic: require DEVCMD2 and set the V2 VF mailbox source

 drivers/net/ethernet/cisco/enic/enic.h         |  36 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c   | 182 ++++++---
 drivers/net/ethernet/cisco/enic/enic_admin.h   |   4 +-
 drivers/net/ethernet/cisco/enic/enic_dev.c     |  15 +
 drivers/net/ethernet/cisco/enic/enic_dev.h     |   2 +
 drivers/net/ethernet/cisco/enic/enic_ethtool.c |  10 +-
 drivers/net/ethernet/cisco/enic/enic_main.c    | 508 +++++++++++++++++++++----
 drivers/net/ethernet/cisco/enic/enic_mbox.c    |  13 +-
 drivers/net/ethernet/cisco/enic/vnic_dev.c     |  42 ++
 drivers/net/ethernet/cisco/enic/vnic_dev.h     |   5 +
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h  |  34 ++
 drivers/net/ethernet/cisco/enic/vnic_rq.c      |  18 +-
 drivers/net/ethernet/cisco/enic/vnic_wq.c      |  18 +-
 13 files changed, 735 insertions(+), 152 deletions(-)
---
base-commit: 6d25ffca055a77787c21a36b66c253f76239411b
change-id: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

