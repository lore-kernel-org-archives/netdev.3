Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560049;
	b=Tu0LklMsijefkXjLmcU4Q5M5ronJZ1aw7LQK948Mf94ofjre/qtLx1VyVZEQsnEXkIZ8
	 pl2NHjJuNmVACkiYDyrf/55S53PuDtYX8y7OzHOalQg5LdK6utz31nG13UIbCPcnfpQjT
	 3668+JC9wjhDnAAD4Jkf3tTj7NyY7bbVFY23TfFYEDfb2Ndt/huWNeT2vuXRNnqCFLrVs
	 sOFPwB3HSi4OqtHUsYBkbod7JDyL4yxwhf8jAUvmS/E1/Cg12EvHyR3xiw+WWCRi/1Ydw
	 4+eZBxcqxIcnplZnEnkqKcFZdAA44cD+6PptKtHeAkiBfBmmLr+zsDEb44Rht8fC4dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560049;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Outbound-Client-TLS:
	 X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=qzpFMmI3gj1bTDwNfjkdeHlyfBVREpgBuaMaIuUMM2Q=;
	b=dfgKdm7wm1mRLYYlvJy7whhXtL6Y2slzvTsp+NT3KJSO8ErWDIBk1z4Fhah5ArAx/U1s
	 CasaATu7UKzj/lzhAL3MCQBXaJxm3d+IXkv18E9Vyb/I5jJ9G0ONMtFul7UjGMqKI+xHS
	 LNVMv1z0kE3HUkIBM4INDEIE67Zq1cneZ0UdhV2HhkAnOvWD8Wuf9rAGpfLTHANZX/BmA
	 nA4A67yQUY0zG7v3fOLQWCubDdJbRuwUF2dnpTbKEtKP63mTgRLmo3XXRWs8zkADSVCGd
	 zWjUGgbrKj6t6nWRNyes0cn5CxUAkDhany+tMQE8tG/XiophGR3xpDwrjlWy4URyJeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=I9z0So4U;
	arc=none smtp.remote-ip=173.37.86.78
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80481606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80481606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=I9z0So4U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8503; q=dns/txt;
  s=iport01; t=1793560048; x=1794769648;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=qzpFMmI3gj1bTDwNfjkdeHlyfBVREpgBuaMaIuUMM2Q=;
  b=I9z0So4Uyach2r7ztmbtV+aEib8ZExAT72PKYcc6SOOmPOB5TG6Ehibl
   aC5t1NPF7fWb92CzX7ttcK7j+5axJwSa/ZGwUL3+ynF/50KtnjlZcaXed
   D/yemYZLpM8U9oso44RkF4QtrNNXsSTIVvbAciFdngIblP5tr+7U7uwOE
   yO32+tSxgf1FZozi7QVLblm52Zk7j9k+AzE/2RFuNsLowGmGgbLsBVfTf
   ukWcsMtRc1HcYMbA5FV8UeM0R3LR860tjo9Mf0File6ke1et0016fFuWt
   MymMTWiTsuZDPoVM1gDLOA2MLc4FERit0BvU2h76kNqUItjeBEkxU6mYH
   Q==;
X-CSE-ConnectionGUID: wH1Inp5NTcmpTL3Ixs7Xwg==
X-CSE-MsgGUID: csL1f9XYSuK4hn3Ormg19Q==
X-IPAS-Result: =?us-ascii?q?A0ADAAAKjedq/5X/Ja1QChkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBTIEwBAEBAQEBCwGDS2AaKUmEV4gbhziCIYEWkDiMV?=
 =?us-ascii?q?BSBag8BAQEPSgcEAQGFBVEVjTgCJjQJDgECBAMCAwEBAQEBAQEBAQEBAQoBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4Thk8NkBUnVjUCJgJIKYMCAYJ0AxEFAbs3eoEygQGEftlLg?=
 =?us-ascii?q?W4GFYEKLgGFcYJtAYFxhAiEfScbgUlEgRQBgnN2hBYJC4N1gmoEgQ6BFIEMg?=
 =?us-ascii?q?liFUYQdgTiJDQk/gQIcA1ksAVUTDQoLBwVjgQUDNRIqFW4yHYEjPhcvWBsGB?=
 =?us-ascii?q?YEdgQcEE4EZgQddgSspYAEhgQiBdgKCUYIAAgFJQQ4HRVMJJUMSRyQiCBIJA?=
 =?us-ascii?q?RMaLAuBGjU8CSZBFQxkCAMaBUACIAgCDQx2ORAwICYwBR0mHRgNSBEsNxUZB?=
 =?us-ascii?q?D0BbgeSAYIeAS1DAQEGBwgXIwgBARsGCQsHDBIGFzkrBw8IGxEjFQUBAgIMB?=
 =?us-ascii?q?hkLERAZkmODf4wogTZrgTWfWoQpgWeKPJVUM5dokwiZCI4KiiCLLRwPDIU2g?=
 =?us-ascii?q?Wg8gVkzGggbFYMiUxkPji4WhzLLCSYyAjsCBwIHDgMLhkaLJA8XB4FPAQE?=
IronPort-Data: A9a23:kvEbm619G/wZPfP/bPbD5fFwkn2cJEfYwER7XKvMYLTBsI5bp2APm
 2QcWGCOPareamH9edEjbdyzpBsOvZSHnIBgQFRp3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yEzmE4Ej9atANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 rsen+WFYAX7gmcsazpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGE2FvHIsAp8BLCmRWy
 dhDCSAWMSCciLfjqF67YrEEasULNsLnOsYb/3pn1zycVKxgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUiRC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+OWxaoGMI4TVHK25mG6Tv
 Uaf8TXJMyoHF4Cfz2Gi6Hej3772yHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0EY5y8nv6Uu3E+mVN/wW1u/unHslh0BUdN4EOAg7gyJjK3O7G6xD24IVDNeK9orqMM7WxQuy
 1mP2djpbRR3ubeYT3O17LqYrTqufyMSKAcqYyIYQQYby8fsrZt1jR/VSNtnVqmvgbXI9SrY2
 TuGqm06wr4Ul8NOjv/99lHciDXqrZ/MJuIo2jjqsquexlsRTOaYi0aAsDA3Md4owF6lc2S8
IronPort-HdrOrdr: A9a23:xJ8QSq4nfNA1oL3NJQPXwFbXdLJyesId70hD6qm+c20wTiX+ra
 CTdZUgtCMc5wx8ZJhNo7q90cq7L080i6Qb3WB5B97LNzUO01HEEGgN1/qG/xTQXwaistNH3a
 1jc69xYeeAbmRSvILR4QG+Hdpl4PTvytHLuc7ui1pgUg1ubbht9ENaBhbzKDwOeCB2Qbc0C5
 aY4NNKvH6beXoRZtmmHXVtZZmkmzSyruOAXTc2Qzg69QKJkTSkrJT+ExSew1Midgkn+8ZbzY
 AA+DaJnJlKdJqAu2Th61M=
X-Talos-CUID: =?us-ascii?q?9a23=3ANzLRamlYLdb28oym3WS7tk0eBuvXOWL9lVbWOxK?=
 =?us-ascii?q?eNW1sUIGxEn6A4/xUjMU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A9wk8uQ/MZJlu9TOu9nqxMfSQf8xzx/2gWXA8qog?=
 =?us-ascii?q?l58mCbgtqPjjE3Q3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,190,1787011200"; 
   d="scan'208";a="542311071"
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 01 Nov 2026 19:07:27 +0000
Received: from [127.0.0.1] (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-12.cisco.com (Postfix) with ESMTPS id 87AB1180001F2;
	Sun,  1 Nov 2026 19:07:26 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net v4 0/2] enic: retain admin DMA resources and identify
 V2 VFs
Date: Sun, 01 Nov 2026 11:07:22 -0800
Message-Id: <20261101-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v4-0-a7e209210453@cisco.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqN52oC/53Oy27CMBAF0F9BXndQ/EicsOI/KhZ+jGEq4SA7t
 UAo/16ToirqMjuPNXPPfbKMiTCzw+7JEhbKNMY6qI8dcxcTzwjk68xEIzre8AasAozkwF8NlAA
 UPd4h4gRnjDXKQaCUJygc/k78YGxQLW+kbFkNviUMdF/QT1ZP2en3M3/bL3TTi3utXShPY3os1
 Qpflt+R3ZYW9V2rCG3bNnRD38ujo+zGvRuvS4EiVoQQmwhRid5bPlhlNFf4n5BrQm8iZCWsEVK
 j11wovibmef4BoZ8IK9EBAAA=
X-Change-ID: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335
To: netdev@vger.kernel.org
Cc: Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793560046; l=8578;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=FauP4lXzVn0YDzLA3SrJGsv3oMPUjJxUEl3Ve0vG6pw=;
 b=RL3t4akjEHdjLzAOzRYLIFKP8wVT0olj1pwHaadkAm3SUiW9d/O1+ezvEHbDa+WNoXI6hzvmp
 yFLuygE2zvFB2unK8ff/AKyEpBTWlsLhiVxjSHJjlgUUIGXpA3nrvjS
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-12.cisco.com

Fix premature freeing of admin-channel buffers and set the correct V2 VF
source ID in mailbox messages. This is v4 of the two-patch admin-only
series. The generic datapath quarantine proposal withdrawn in v2 remains
out of scope, including its page-pool/device lifetime problem.

The first patch releases the admin WQ/RQ/CQ allocation only after both
complete queue-disable helpers succeed. Give both queues a first attempt,
then retry once only a helper which timed out. The 500 ms polling bound
is local to admin shutdown, and both RQ disable/check passes are preserved.
Ordinary datapath and DEVCMD2 queue timeouts are unchanged. Admin receive
buffers are driver-owned mappings, not page-pool pages returned later
from the networking stack.

Keep PCI bus mastering enabled during runtime admin quarantine so command
transport and ordinary teardown can continue. An affected V2 VF is closed
and cannot reopen while its control channel is quarantined. Detach the
netdev under RTNL during removal, then perform the VF unregister handshake
and admin close after releasing RTNL. Skip admin reopen after a failed
datapath open. Clear local VF registration after channel replies have been
drained, including after a failed re-registration closes the channel.

Removal makes a final direct admin queue check. If it still fails, finish
normal generic teardown and attempt CMD_CLOSE before final containment. Retain
the inert owner and unresolved DMA targets rather than free memory the
device might still reference. This intentionally leaves allocations and
a BAR reservation behind. It blocks ordinary reprobe while the PCI device
remains enumerated; PCI remove/rescan is not a supported recovery method.
A PCI-device reference keeps the reservation name valid, but does not
preserve IOMMU attachment or establish that DMA stopped. No IRQ, work or
other CPU callback may enter retained objects after module unload. DMA
debugging can report pending allocations. Reboot is the supported recovery.

The second patch requires DEVCMD2 for SR-IOV V2 and obtains the VF source
index from CMD_SRIOV_STATS_GET. A deployed async PF compares that source
against the CQ-derived sender. After QP enable, obtain and validate the ID
while receive interrupts remain masked. Publish send readiness before
unmasking, so queued notifications can be processed and acknowledged with
a valid source. Sends remain disabled until the ID is valid, using the
existing send gate. Notification handling does not rely on PF retransmission.

Keep the statistics target persistent and observe command completion
separately from firmware status. A later blocking QP or close result
fences earlier statistics DMA, including an error result. A pre-post
failure, posted timeout or NOWAIT posting does not establish completion.
This command ordering does not replace admin queue-stop proof.

Sashiko's feedback prompted this audit. The pre-existing failed-reset
reopen lifecycle and generic queue-disable error paths remain separate
follow-up work; this revision does not claim to fix them. Source review
and testing were assisted by LLM tools. The author is responsible for
the submitted changes.

Validation:

- V4 passed build and static checks at both patch boundaries. Sparse
  reported the same existing diagnostics as the public base.
- Focused V4 tests verified that a late registration reply is cleared after
  failed re-registration closes the channel. During an injected five-second
  VF-unregister delay after detach, an unrelated RTNL operation completed.
- Full functional and interoperability tests passed with Cisco VIC PFs
  and V2 VFs, including a nonzero VF and all four combinations of the
  development ENIC and deployed async PF/VF drivers. Traffic covered
  bidirectional ICMP, TCP, UDP and jumbo frames.
- Tests covered station/address/filter and administrative-MAC policy
  changes, concurrent address updates and reopen, and multiple module
  reload, ring resize, interface reopen and VF destroy/recreate cycles.
- A test-only mailbox-send failure exercised reset recovery. The real
  send completed before the failure was injected; recovery restored
  traffic, and the uninstrumented candidate then reloaded successfully.
- Focused V3 tests verified queued PF notification delivery after VF-ID
  discovery, discovery-failure cleanup and statistics-buffer cleanup
  after a completed close. Fault injection let real DMA complete.
- Earlier fault-injection tests covered admin queue retry, quarantine,
  final removal cleanup and terminal retention. They let the real queues
  stop; they did not reproduce a physically stuck queue.

The functional and interoperability tests included later VF/PF feature
patches. These two fixes alone do not enable in-tree PF SR-IOV support.
Physical device removal was not tested; a physical DMA-engine failure
was not reproduced.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Changes in v4:
- Clear vf_registered after closing the channel on both failed VF
  re-registration paths; a late reply may have set it before the send
  reported a timeout.
- Hold RTNL only while detaching the netdev during removal. Perform the VF
  unregister handshake and admin close after releasing RTNL.
- Keep the valid pre-existing generic datapath repeated-stop problem as
  separate follow-up work rather than adding a partial fix to this series.
- Link to v3: https://patch.msgid.link/20261027-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v3-0-ba237ed71241@cisco.com

Changes in v3:
- Use observed blocking CMD_CLOSE completion, including an error result,
  to fence earlier statistics DMA in probe unwind and removal.
- Obtain the VF source ID after QP enable but before receive interrupts
  are unmasked, and permit sends before delivering queued notifications.
  Use the existing send gate instead of a redundant invalid-ID check.
- Validate delayed notifications, discovery failures and completed-close
  cleanup on a VF.
- Rerun the full functional suite and all four PF/VF driver pairings
  with the v3 fixes in the later VF/PF feature compositions.
- Clear local VF registration after channel close in both reset workers.
- Correct comments and explain quarantine, recovery and retention limits.
- Link to v2: https://patch.msgid.link/20261022-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v2-0-8db19b4a714e@cisco.com

Changes in v2:
- Withdraw v1 patch 1's generic datapath quarantine proposal. Rewrite v1
  patch 2 as the first patch here, followed by the VF mailbox-source fix.
- Keep the admin buffers' lifetime separate from generic page pools and
  notification teardown. Keep bus mastering enabled at runtime.
- Bound longer polling to the two admin queues, preserve both RQ passes,
  and retry only a complete disable helper returning -ETIMEDOUT.
- Serialize remove/open and skip admin reopen after datapath-open failure.
- Observe DEVCMD2 transport completion independently of command success,
  including a completed QP error, without treating pre-post errors or
  NOWAIT posting as a fence.
- Clarify final remove recheck, terminal retention and reprobe limits.
- Link to v1: https://patch.msgid.link/20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883@cisco.com

Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>

---
Satish Kharat (2):
      enic: retain admin-channel DMA until queues stop
      enic: require DEVCMD2 and set the V2 VF mailbox source

 drivers/net/ethernet/cisco/enic/enic.h        |  22 ++-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 247 +++++++++++++++++++++-----
 drivers/net/ethernet/cisco/enic/enic_admin.h  |   4 +-
 drivers/net/ethernet/cisco/enic/enic_dev.c    |  44 +++++
 drivers/net/ethernet/cisco/enic/enic_dev.h    |   3 +
 drivers/net/ethernet/cisco/enic/enic_main.c   | 113 +++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   |  13 +-
 drivers/net/ethernet/cisco/enic/vnic_dev.c    |  85 ++++++++-
 drivers/net/ethernet/cisco/enic/vnic_dev.h    |  15 ++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  34 ++++
 10 files changed, 513 insertions(+), 67 deletions(-)
---
base-commit: 0df412012a26389582b120844d098e1e961f10a6
change-id: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

