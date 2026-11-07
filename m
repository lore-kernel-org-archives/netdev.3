Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078149;
	b=xgs7PjN1ZpQ/mre//gzaiW3u8mgz5YOlUZh7IUbJXCtvIn+CeuYXV9bnMZMztNKCuKe9
	 fBKHPzFEOSfuRoemchprUcY9cXgpJjjGlpoMLZ2X3vSvCXRaEZQDER9no/C9OdmauchnF
	 JYu3TJYo6IKVy6LcfS0n7e9KszUkp459V2PievK6dt1phreer4US2jWDaOAv5cSFd1gDL
	 ds8PYWlAx0wOKBRDDHdqJ6y0o1g2aZDTw1SpkXqzQZnPUk6IA8/b7OjAAab0D1XTmIjj6
	 FsC+7WmYUMO067Y75QOzjlyhjCWtLwF9lWH66z7EZIQTPHfYerWU10f86PCjJCBjfpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078149;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Outbound-Client-TLS:
	 X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=iAqDSSG7sZ3/HBtszUZOrMU3ODK18x+X4kP9kRDDMLU=;
	b=hiKkR4ER/kwTVrr5AzycKLUDao88QM25bRObqObtPWNGPsXJLst3eQhWX/sqsQBckN+N
	 c5zTfSH5je1wL1dvKWfLqAocGYM2IERxtzzwwXPX0HSHlhX5TqpD1BYiZdlZQ2hRZuF1V
	 R2XKee53wiofThll7UlbKKmjvvpmOwMTi+U9oMueCYuCo6roFLzbm9KjP9IU2u70NwFpu
	 ozVjyU5WSbt8IF2vXhXmY2nlxSE+095BnbmE7oDKQU/ZrzkXBqG6LHfiYpqp4p9pxNP1f
	 IRiTCX38WHxnusjzSrayn/p+bBdzcRJQvEpOi1u1Fu6uJM2alhGyXhviP4Xd4K8UJbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=Truo7ahF;
	arc=none smtp.remote-ip=173.37.86.76
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C1606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 19:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB7C1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=Truo7ahF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=9475; q=dns/txt;
  s=iport01; t=1794078148; x=1795287748;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=iAqDSSG7sZ3/HBtszUZOrMU3ODK18x+X4kP9kRDDMLU=;
  b=Truo7ahF0h1lJGObKmErXmXQaS6fM1SGIyFRUP3IeRzafWdPCL94sSOr
   VRRUtZqh76QqrLq2LjqIvnqsdHWWsTvdP5M4bBrJQUaTsZenB5q9xHu1u
   +jKlN8jK009jzr387u3N4tygXBQdReZoKlPpx2ECZzs8QMBHfLNpPlqcU
   qNfqPU3ikcG4lMNLG/g/Ylbbviz+dJ5vt0LNTYklDLN18xi9xJ54MRTu4
   36FIdYCrFZzl2Ub8WcrlcKK6b+lZFUvth0LI1gwLxuT50JQbJRDew0wyP
   xzstwZvJJCdmbxfVxxBA8YTCUHrQ10MLBrsQYiMOS69sO6YDDiaw/uthy
   Q==;
X-CSE-ConnectionGUID: UlBJISiESQKmb7GenIb3tQ==
X-CSE-MsgGUID: X30CgvZDR9aaK1M8cZni0Q==
X-IPAS-Result: =?us-ascii?q?A0ADAAAGdO9q/5L/Ja1QChkBAQEBAgIBAQEBAQEBAQEUA?=
 =?us-ascii?q?QEBAQEBAQEBAU2BMAQBAQEBDAGDS2BDSYRXiBuHOIIhgRaQOYxVFIFqDwEBA?=
 =?us-ascii?q?Q9KBwQBAYUFURWNOQImNAkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBB?=
 =?us-ascii?q?wWBDhOGTw2QFSdWNQImAkgpgwIBgnQDEQUBvC96gTKBAYR+2UuBbgYVgQouA?=
 =?us-ascii?q?YVzgm4BgXGECIR9JxuBSUSBFAGCKUp2hBYJC4N1gmoEgQ5/FYEMgliFQoQcg?=
 =?us-ascii?q?TeJUwk/gQIcA1ksAVUTDQoLBwVjgQUDNRIqFW4yHYEjPhcvWBsGBYEdgQcEE?=
 =?us-ascii?q?4ESgQddgSsoXQEhgQiBdgKCUYIAAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBG?=
 =?us-ascii?q?jU8CSY/FQxkCAMaBUACHwgCDQx0ORAwHiQvBRwmPhsKNhgNSBEsNxUZBD0Bb?=
 =?us-ascii?q?geSQoIgAS1DAQEGBwgXIwgBAQkSBgkLBwwSBhc5KwcPBwEbESMVBQECAgwGG?=
 =?us-ascii?q?QsRKZJjQ4M8jCiBNmuBNZ9chCqBaIo8lVQzl2mTCJkIjgqKIIstHA8MhTaBa?=
 =?us-ascii?q?DyBWTMaCBsVgyJTGQ+Vdsd5JjICOwEBBwIHDgMLgWiEXoskDxcHgU8BAQ?=
IronPort-Data: A9a23:JE/gM66QBZ5YI9+QfkS+vAxRtBrGchMFZxGqfqrLsTDasY5as4F+v
 jMZDWCGa/6PajOmL913bIXg8RhQ78CEztEyHABvriFnZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOex9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/KUzBHf/g2QqaztMtPrawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eAIky2MdMAEx1z
 N8dIm8iYxaijbmq+efuIgVsrpxLwMjDJogTvDRkiDreF/tjGcGFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkERUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIeJJ4LbHZsFxC50o
 Er2pDzSDQ8oGObOwDOmq1f8jd3JnHvCDdd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3ZtrwRRu1pDiDpBF0c9lNGeQS6wyXzKfQpQGDCQAsRzhNctE598k7WTAny
 HeNgtXvQzdv2JWNQHiQ8La8tz6+OSEJa2QFYEcsSwYZ79T9iJ88gwiJTdt5FqOxyNrvFlnNL
 yuitiMygfAXyMUMzaj+pQGBiDO3rZ+PRQkwjunKYl+YAspCTNbNT+SVBZLztJ6s8K7xooG9g
 UU5
IronPort-HdrOrdr: A9a23:zCqO7q/ioWV7saUFkNNuk+BGI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rPoB17737JYVkqNE3I9errBEDiex3hHOBOjrX5VI3KNGLbUQCTQb2Kg7GSpgHIKmnUq6phzq
 9rcah4BrTLfDtHpPe/ygixFNgthPmrmZrY59v2/jNBQR5nbqd44xw8KAqKe3cGPTVuNN4VGI
 WR48xfqyHlQ3QYacynGmIINtKzweEj7KiWBiIuNloA9BSEiy+u5frRFhiV2QpbbhZ0qI1SiV
 QsV2fCl9+eWzbR8G6m61Pu
X-Talos-CUID: =?us-ascii?q?9a23=3A2en7UmobKWYasJX/VVPrg1zmUf0hWF/893b9GHa?=
 =?us-ascii?q?bDGw2Z7CTaFXL5Joxxg=3D=3D?=
X-Talos-MUID: 9a23:dqSqEAqqTAXyS/4vRywezwE5bOxn/ZaCMhEEmLZfnpmPBypxYw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,200,1787011200"; 
   d="scan'208";a="545690682"
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Nov 2026 19:02:22 +0000
Received: from [127.0.0.1] (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTPS id 5963618000238;
	Sat,  7 Nov 2026 19:02:21 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net v6 0/2] enic: retain admin DMA resources and identify
 V2 VFs
Date: Sat, 07 Nov 2026 11:02:15 -0800
Message-Id: <20261107-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v6-0-155d64f802e9@cisco.com>
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
X-B4-Tracking: v=1; b=H4sIALd172oC/53QzU7DMAwH8FeZciYodpKm5cR7IA75cLYgrUVNq
 YamvjteQVCNW29xZPv3l6+i0lioiqfDVYw0l1qGnovm4SDiyfdHkiVxLVBhAwqUDEZSX6JMZy/
 nLEuf6CJ7muSRel4VZS5jneQM8nckdT5kY0FpbQUvfh8pl8uKvggeFa/fn/UjvFGcbtyt7VTqN
 Iyfa7QZ1uaflc2eFPzmKOiCtbnp2lY/x1Lj8BiH8xpgxg2BuItAJtoUoAvGOzB0T+gt4XYRmon
 gUTtKDtDAPWH+CB7YRRgmvCNUHYIy9t+h7JbQuwjLBFoFCRA15bwllmX5Au7yp/yXAgAA
X-Change-ID: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335
To: netdev@vger.kernel.org
Cc: Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794078141; l=9557;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=vDWAdtwOrUAdNevM0mZwrcF/w1J+yBUHuLWCV1uWWV0=;
 b=0ZikuOkimxjQf+EcMQ982wjYBtVRDQBInJggrLigKguJJKp5aqLhS3Onv9As4y40WolpVWDlv
 MKQm2AUaUwWDtQlJOsum6EJc+ZtUtXDiq0woe6Qsf5twDWBp4VaduUR
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-09.cisco.com

Fix premature freeing of admin-channel buffers and set the correct V2 VF
source ID in mailbox messages. This is v6 of the two-patch admin-only
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

Probe unwind and removal finish normal generic teardown and attempt
CMD_CLOSE before one final direct admin queue check. If that check fails,
retain the inert owner and unresolved DMA targets rather than free memory
the device might still reference. This intentionally leaves allocations
and a BAR reservation behind. It blocks ordinary reprobe while the PCI
device remains enumerated; PCI remove/rescan is not a supported recovery
method. A PCI-device reference keeps the reservation name valid, but does
not preserve IOMMU attachment or establish that DMA stopped. No IRQ, work
or other CPU callback may enter retained objects after module unload. DMA
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

- V6 passed build and static checks at both patch boundaries. Sparse
  reported the same existing diagnostics as the public base.
- The uninstrumented V6 candidate successfully bound, opened and closed
  a V2 VF.
- A test-only overlay accepted statistics version 2 and rejected version 0
  and VF index 0, which is reserved for the PF.
- A test-only overlay exercised admin quarantine during probe failure
  and removal. Generic teardown and CMD_CLOSE completed before the final
  queue check released the admin graph, and a clean reprobe succeeded.
  Keeping the synthetic timeout through that check exercised terminal
  retention. Guest reboot restored the original module and configuration,
  after which traffic passed.
- Full functional and interoperability tests on V4 passed with Cisco VIC
  PFs and V2 VFs, including a nonzero VF and all four combinations of the
  development ENIC and deployed async PF/VF drivers. Traffic covered
  bidirectional ICMP, TCP, UDP and jumbo frames.
- Tests covered station/address/filter and administrative-MAC policy
  changes, concurrent address updates and reopen, and multiple module
  reload, ring resize, interface reopen and VF destroy/recreate cycles.
- Earlier fault-injection tests covered admin queue retry, reset recovery,
  queued PF notification delivery after VF-ID discovery and completed-close
  statistics-buffer cleanup. They let real DMA complete; no test reproduced
  a physically stuck queue.

The functional and interoperability tests included later VF/PF feature
patches. These two fixes alone do not enable in-tree PF SR-IOV support.
Physical device removal was not tested; a physical DMA-engine failure
was not reproduced.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Changes in v6:
- Accept statistics ABI version 1 or later because newer versions preserve
  the version-1 prefix.
- Document that the statistics command is mandatory for V2 VF probe and
  correct the reset and DMA-fence comments.
- Link to v5: https://patch.msgid.link/20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-0-2501d1223eff@cisco.com

Changes in v5:
- Remove the redundant mbox_tx_poisoned flag. The channel state owns the
  allocation lifetime, while mbox_send_disabled gates new sends.
- Run the final direct admin queue recheck after generic teardown and
  CMD_CLOSE in both probe unwind and removal.
- Keep all-ones MMIO reads and recoverable PCI channel-offline states
  conservative; neither is accepted as queue-stop proof.
- Validate final release and terminal retention on the exact V5 tree.
- Link to v4: https://patch.msgid.link/20261101-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v4-0-a7e209210453@cisco.com

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

 drivers/net/ethernet/cisco/enic/enic.h        |  21 ++-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 240 ++++++++++++++++++++------
 drivers/net/ethernet/cisco/enic/enic_admin.h  |   4 +-
 drivers/net/ethernet/cisco/enic/enic_dev.c    |  44 +++++
 drivers/net/ethernet/cisco/enic/enic_dev.h    |   3 +
 drivers/net/ethernet/cisco/enic/enic_main.c   | 129 ++++++++++++--
 drivers/net/ethernet/cisco/enic/enic_mbox.c   |  12 +-
 drivers/net/ethernet/cisco/enic/vnic_dev.c    |  85 ++++++++-
 drivers/net/ethernet/cisco/enic/vnic_dev.h    |  15 ++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  34 ++++
 10 files changed, 512 insertions(+), 75 deletions(-)
---
base-commit: 0df412012a26389582b120844d098e1e961f10a6
change-id: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

