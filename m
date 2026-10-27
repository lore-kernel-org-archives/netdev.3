Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114135;
	b=tqxEZUu4xeu+wz8DOS7IOCi5AQ4Bh5OskwWNyhmzl9MQZ+xBn6oI8C7B/tMF07DiK+M4
	 9HK6NZD41AfwU6f8kp/LujzMIpBjiwLCMaONlxNNSjgfIh/dIUFSaCRfhcgg8nnsMEPJ+
	 t6gtqyBhVwmCrHdC2wy7KtBSOEmRaJDSGatCPg7IWWKnYlraKrI3gE7fMZYJx6SHo8iDI
	 uCJvms6m2CEstvIxQO8yKTLs2k19OEXJ11Lh9gce6YqZXAJOqNjgoTKNUXNsic791Rqmo
	 6uDaL3XWgsvF0A5NCH8CF+Rt8bByUAS/7NLjYc24/Zte71QlH4MokTR90MkxP2eFGvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114135;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Outbound-Client-TLS:
	 X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=SGZ5v8jYfs09yX68TlPxrVHyGxDYPI+9BJCitLuEo6k=;
	b=kfKonOH5e7XDEvYjX1unerO7EtPlAZlpns/jwFNVPQO2jzBBW5M/btBx9hKKWN4cpfXx
	 vUalBQlayNfJdyfu3hcM3urImZbPoDaLURNglLupIi1lSMKUtFZiezCojEETCUkPJUOXg
	 6cQdGZaG4P7FooKZ+XeTkI7i6S+16q7E0OC/pm4CemSMiLYbGr/F6vG1gs5TrtZSkqtZp
	 UVbLn//Zqum8dQWJO7hZgO0a/1+Z0KGF34ZFrnQUwJFuEUioX21tCHWPQpZTIQaqa9vB7
	 3O5bp+W2g88y9jZLeHFTpsOnrRnV8jFh1kdDNk7+MUHItDWSLqUXR8GYe+szILEztqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=CVNR2JED;
	arc=none smtp.remote-ip=173.37.86.78
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6E606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16D6E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=CVNR2JED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7598; q=dns/txt;
  s=iport01; t=1793114135; x=1794323735;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=SGZ5v8jYfs09yX68TlPxrVHyGxDYPI+9BJCitLuEo6k=;
  b=CVNR2JEDcPUVrlRcQfHAepKabKlp5xG3ctNtjyCXYtVUzAUriZZMPBUC
   i0536vPJz2EODyiWmTWF+ys2u98ybuPWH8P9DrmuNWy1Jt7r3VzCqNLb1
   X7bKRf6GvgRuMVvP6S73EXeGGahwED0sCVpPQ74+hTpT2XeOLGghI52yb
   QEXL29or1ADs0RjYGVmhtLDNRNKnY6NZXm1CAoNqxwhT5mmBBjikWozwl
   ws6sadyl1MXMSGwRqXm3o3rNfsImGxrDmgRAzkvRxvdkQ1mq5VuumolpM
   69cazdn4E7LndvcWgSO0M5okbAdFWXNirvj0wzvZJf3DR1UlzdGvdQJ1+
   g==;
X-CSE-ConnectionGUID: 02sn1CQ+QvSKPkduCB3uUg==
X-CSE-MsgGUID: xfT3lDECRUyt9pMQ7WLn4Q==
X-IPAS-Result: =?us-ascii?q?A0AEAADyvuBq/5T/Ja1QChoBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUyBMAUBAQEBCwGDS2BDSYRXiBuHOIIhgRaQN4xSFIFqDwEBA?=
 =?us-ascii?q?Q9KBwQBAYUFURWNMwImNAkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBB?=
 =?us-ascii?q?wWBDhOGTw2QFSdWNQImAkgpgwIBgnQDEQUBtX96gTKBAYR+2UuBbgYVgQouA?=
 =?us-ascii?q?YVxgm0BgXGECIR9JxuBSUSBFAGCc3aEFgkLg3SCagSBDoEUgQyCWIVahB2BO?=
 =?us-ascii?q?IglCT+BAhwDWSwBVRMNCgsHBWOBBQM1EioVbjIdgSM+Fy9YGwYFgR2BBwQTg?=
 =?us-ascii?q?T6BB12BKylgASGBCIF2AoJRggACAUlBDgdFUwklQxJHJCIIEgkBExouC4EaN?=
 =?us-ascii?q?TwJJkEVDGQIAxoFQAIgCAINDHc5EDEgJBgNSBEsNxUZBD0BbgeROoIYAS1DA?=
 =?us-ascii?q?QEGBwgXIwgBARsGCQsHDBgXOSsHDwgbESMVBgICDAYZCxEQGZJjg3+MKIE2a?=
 =?us-ascii?q?4E1n1qEKIFmijyVVDOXZ5MImQiOCoofiy0cDwyFNoFoPIFZMxoIGxWDIlMZD?=
 =?us-ascii?q?44uFocyywgnMgI7AgcCBw4DC4ZGiyQPFweBTwEB?=
IronPort-Data: A9a23:CjUFG6LACYK0JdYJFE+R85QlxSXFcZb7ZxGr2PjKsXjdYENS3mBVn
 WZLWDqDM/yDN2bxftoiaY6x8B5Vv5LUz99hSgEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea+Uf1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH8g2Qrajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN02VlowZKYhud9pOkJ29
 vAFAxpWcy2M0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSAVLAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MESojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZjeS1aoSPJYXVLSlTtlaWm
 jnC00nSOCwLKI2H7APazVaq2taayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa90GxSNT5GRqirxasvQMWUvJTHvc85QXLzbDbiy6QAGQeQyECbtE6uMIobTg30
 FnPlNOBLSRmurCTSFqH+7uUpC/0Mi8QRUcEaDMIQBUt/dbuuscwgwjJQ9IlF7S65uAZAhnqy
 DyM6Sx7jLIJgItSjuOw/EvMhHSnoZ2hohMJ2zg7l1mNtmtRDLNJraTxgbQHxZ6s9Lqkc2Q=
IronPort-HdrOrdr: A9a23:cnhiqKgZRYtiR8nkDJt5rRs6GXBQXkQji2hC6mlwRA09TyVXrb
 HLoB1973/JYVcqOU3I9urtBEDtexnhHP1Oj7X5Q43MYOCOggLBR72KhrGO/9SPIVyaysdtkY
 w8N5VkANfzDV915PyKgzWQIpILwdGB/qztpcq29QYOcShaL4xt8At9DB+WCQlVSBkuP+tBKL
 OsoudKuDakf20adYCABncDV/XevNGjruOBXfd/PW9B1CC+yRW19bX9Dx+Umj0aUz9J3PMe1F
 KtqX2A2k1m2MvLsCM1EATonu9rpOc=
X-Talos-CUID: =?us-ascii?q?9a23=3APBHnC2mSJ0AaqLfAAhaDbOWc4+XXOSWH13GJCHb?=
 =?us-ascii?q?7MHhSa4WWRUK70vh5rsU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A888E0A9ZV58VbDzjMbdXUe6Qf9dm3/+qJG0mq6g?=
 =?us-ascii?q?Xp5icEBUvBBOb0A3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,181,1787011200"; 
   d="scan'208";a="540262717"
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Oct 2026 15:15:28 +0000
Received: from [127.0.0.1] (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTPS id A3C831800026C;
	Tue, 27 Oct 2026 15:15:27 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net v3 0/2] enic: retain admin DMA resources and identify
 V2 VFs
Date: Tue, 27 Oct 2026 08:15:15 -0700
Message-Id: <20261027-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v3-0-ba237ed71241@cisco.com>
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
X-B4-Tracking: v=1; b=H4sIAAPA4GoC/52OzQ6CMBCEX4X07BpafgRPvofxQNstrgmtabHRG
 N7dgsZw5razmZlv3iygJwzsmL2Zx0iBnE2i2GVMXTvbI5BOmolc1DznOcgS0JICPXQQDZDV+AS
 LI/RoU5UCQz6MEDn8I7rtpCkrnhdFxVLx3aOh5wI9sxRll+8zPOQN1TjjZtuVwuj8a5kW+WL+V
 dZbVqQ7TREHWVWmbpumOCkKyu2VG5YBUawQQmxCiIRotOStLLsDL3GNmKbpA788mGVuAQAA
X-Change-ID: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335
To: netdev@vger.kernel.org
Cc: Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793114127; l=7667;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=tF0VxSdecSTumJX1V5+XRM6FN29ypyowy8JUVLT4B1Q=;
 b=YHxQNa3wqoLHuquZ+aUc5gDwNDfgHrk3wmFoRYEVUv56NoB7s7I5ZvBD05loe6fyIgn4FUMVD
 XZaf4U8cshrCPQx6iO2ZgQT1V/cXnEw60+MQVvNdwbO5VCcPUEOCLCI
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-11.cisco.com

Fix premature freeing of admin-channel buffers and set the correct V2 VF
source ID in mailbox messages. This is v3 of the two-patch admin-only
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
and cannot reopen while its control channel is quarantined. Serialize
removal against open and skip admin reopen after a failed datapath open.
Clear local VF registration after channel replies have been drained so
an early recovery exit cannot leave stale registration state.

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

- V3 passed build and static checks at both patch boundaries. Sparse
  reported the same existing diagnostics as the public base.
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
 drivers/net/ethernet/cisco/enic/enic_main.c   | 111 +++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   |  13 +-
 drivers/net/ethernet/cisco/enic/vnic_dev.c    |  85 ++++++++-
 drivers/net/ethernet/cisco/enic/vnic_dev.h    |  15 ++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  34 ++++
 10 files changed, 511 insertions(+), 67 deletions(-)
---
base-commit: 0df412012a26389582b120844d098e1e961f10a6
change-id: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

