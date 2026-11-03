Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709374;
	b=5jkP7+piSGyl/ExCErT2OSbAkH7RHK8T7o7xXgMqe/c/fAFEdVGWwEAkMQ1jP6kGtnkk
	 cR4mmNcJ0nC1XsoAbWgBV7epiUh2rpWGvobrIKmcWJ3qJ7b9H/G0h8ZqSDTTuHs/tQC67
	 6cMvKrAhITVUlFwd/HGa3y+hQ5qDprSKvsNDMvlVrTSHZODU5LQflv/3D4mK7n0ITFX5B
	 UJnFIJd6D/ZU8ueW5ONs0ghwv5J04VcqLMF9Raux/m+xUmsry7fLnADHn7Jz0CUjOSRsU
	 45/BcaQlgxOjcdVnHSzzEQhIJ78A7kbyQYpM+bh/NLcorCQAw4FFYPXjl29c9llThTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709374;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Outbound-Client-TLS:
	 X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=09qP2VjkRnFhMEMUCsTLL0oKnwwj8d25ssKU29TPNH4=;
	b=IcigF6+3zNC/C71MfnfGtVPV2EidZIlIH+1uW4fl1otj+G1XVZRiIZ+tZTBbQWLUiyeC
	 58HF91oAagzDzITWZdZKWr0pczQLhTDsJeqnlejkdqRMEQ6D8aeuxCSd2WSpFtBM2hGFq
	 xA7f9AlxdHfrghtwjPES467AJweU7+eFRISpg8MpTwFC+hExa5vlwjDm49fLJseJKSo5x
	 MErFt2wHv30OaP3YNu5LupBeGk/a4lhKz5cdwJaBSIPHMDFoaVE0HPHWYIWbaFH0NgFN8
	 o5bkPrO+dwwq9kVs8l0sD7V/6xWBpKg+QR3gfw/9yNjECTBEADJDUOIg4BpqOLgWloA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=AJJCWagC;
	arc=none smtp.remote-ip=173.37.86.75
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F901606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F901606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=AJJCWagC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8987; q=dns/txt;
  s=iport01; t=1793709373; x=1794918973;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=09qP2VjkRnFhMEMUCsTLL0oKnwwj8d25ssKU29TPNH4=;
  b=AJJCWagCnpFgRcFCc8YS8S1yTjIBngprtSCWIVTw+cN4J3UL+oM9yaL1
   HtSOgVwXDHI1viGiCRgJtGWyet1pWKl2QkhnBmxrwr1ZtW+bgOUwQrMGf
   nklTfojhFa+ZYtr1WhylzcTR4nOtg1chMCrqVsumfNZqvUlgCe9dLDw8E
   cl4sRL/1w/wXB09O85ji/sRZdQR0tLFYLUTzE+8xv8KE7nIljs1R/mZvR
   s+4WiXRuGxYpToSpG5Tz+1wle5+BiQljW02LOqZZTm+qu9STjErGE0Sl3
   /gV/l7jerE/dp6c/uQ7Df69A5RWPCP3zaukY/4X0hyiOD1hlNmpvl1ucx
   A==;
X-CSE-ConnectionGUID: BKlMz3G4Rs+W49q3lhuKkw==
X-CSE-MsgGUID: +S8mDXdWR7ewkY87y0UFSA==
X-IPAS-Result: =?us-ascii?q?A0ADAACg0+lq/4r/Ja1QChkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAQEBAQEBAQEBAQEBTIEwBAEBAQEBCwGDS2BDSYRXiBuHOIIhgRaQOIxUF?=
 =?us-ascii?q?IFqDwEBAQ9KBwQBAYUFURWNOAImNAkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBB?=
 =?us-ascii?q?QEBAQIBBwWBDhOGTw2QFSdWNQImAkgpgwIBgnQDEQUBuwR6gTKBAYR+2UuBb?=
 =?us-ascii?q?gYVgQouAYVxgm0BgXGECIR9JxuBSUSBFAGCKUp2hBYJC4N1gmoEgQ6BFIEMg?=
 =?us-ascii?q?liFQoQcgTqJIgk/gQIcA1ksAVUTDQoLBwVjgQUDNRIqFW4yHYEjPhcvWBsGB?=
 =?us-ascii?q?YEdgQcEE4ESgQddgSsoXQEhgQiBdgKCUYIAAgFJQQ4HRVMJJUMSRyQiCBIJA?=
 =?us-ascii?q?RMaLAqBGjU8CSY/FQxmCAMaBUACHwgCDQx0ORAwHiQvBRwmQBAYDUgRLDcVG?=
 =?us-ascii?q?QQ9AW4Hkg2CHAEtQwEBBgcIFyMIAQEbBgkLBwwSBhc5KwcPBwEbESMVBQECA?=
 =?us-ascii?q?gwGGQsRKZJjg3+MKIE2a4E1n1yEKYFnijyVVDOXaJMImQiOCoogiy0cDwyFN?=
 =?us-ascii?q?oFoPIFZMxoIGxWDIlMZD5V2ywkmMgI7AgcCBw4DC4ZGiyQPFweBTwEB?=
IronPort-Data: A9a23:G0eJqqkO/ohovfuprxbrTTbo5gyjJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbX2CBb6zZNDH1c9xwaYq09xlUuMDUx99lGQJqrHxgE1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4Errav6+/SEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZK31GONgWYubDtNs/nb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05Fac7/sNlWk4Sz
 +dbF2xcd0uHh/+Vw63uH4GAhux7RCXqFJkUtnclyXTSCuwrBMiaBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQUaj/7C7pm9AusrmL2bzxDqFGVjaE2+GPUigd21dABNfKIJofUG50Kzx/wS
 mTuvF+pBz0qOOOlljea8UP82f6XoA3AcddHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvH+Uge+rXrCuQQTM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ0I/9XuvqktgR/VCNVuCqi4ipvyAz6Y/
 tyRhDI1i7NWiYsA0L+2uAiexTmtvZPOCAUy4207Q16Y0++wX6b9D6TA1LQRxa8owFqxJrVZg
 EU5pg==
IronPort-HdrOrdr: A9a23:DdCIJKyebAnVKaPq56f1KrPwsr1zdoMgy1knxilNoNJuA6ilfq
 eV/MjztCWUtN9/Yh0dcLy7UpVoIkmzyXcK2+Ys1N6ZNWGMhILCFuxfBOXZsljdMhy73bMY6L
 xpeap/D9OYNykYse/KpCO4G9EvzJ2m3cmT9IXj5kYoYA10Z6Rn9gtjTiSWAiRNNXB7LKt8OZ
 aC6s9Avja6PU4WYMOyG2UfU4H41rv2ferdEHk7Li9izhWShjW177O/OR2Z0hACFw5r+94ZgB
 D4e8iT3NTYjxl9oSWsrFPu0w==
X-Talos-CUID: =?us-ascii?q?9a23=3Av65Jn2iVHJ7IpyUjFyZSY4tfEDJuWF7Z6WWLDBO?=
 =?us-ascii?q?CEiVWFOyMEluQ5YBnjJ87?=
X-Talos-MUID: 9a23:JufxvAuljHa4Tnk1E82nxwoyMetY75uUV00SkqRW5NjcCAJLEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,193,1787011200"; 
   d="scan'208";a="543660791"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Nov 2026 12:36:12 +0000
Received: from [127.0.0.1] (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id EB8DD180001C4;
	Tue,  3 Nov 2026 12:36:10 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net v5 0/2] enic: retain admin DMA resources and identify
 V2 VFs
Date: Tue, 03 Nov 2026 04:36:02 -0800
Message-Id: <20261103-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v5-0-2501d1223eff@cisco.com>
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
X-B4-Tracking: v=1; b=H4sIADLV6WoC/53QzU7DMAwH8FeZcsYocZKm5cR7TDvkw92CtBQ1p
 Rqa+u54BcHYsbc4sv37y1dRacxUxcvuKkaac81D4cI+7UQ8+XIkyIlrgRIbJZWEYIBKjpDOHuY
 eckl0gUITHKnwqgh9HusEs4LfkdT50BurpNZW8OL3kfp8WdG94FFx+P6sH+GN4nTjbm2nXKdh/
 FyjzWpt/lnZbEnBb46CLljbN13b6teYaxye43BeA8x4RyBuIpCJNgXVBeOdMvRI6HvCbSI0E8G
 jdpScQqMeCfNH8MAmwjDhHaHsUElj/x1qWZYvRKWHPzQCAAA=
X-Change-ID: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335
To: netdev@vger.kernel.org
Cc: Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709370; l=9066;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=17QYndtG3zUpXETIdAyFnOjzKLiCrIRluU2W1xeF2Nw=;
 b=v/kidlOJF7yR1VsBIuwgBw/tIXxbZU7Gvr6+SAf9dSH9zJgP/W+TnBQQmiXrBd3PvaD/Sjv3S
 fIOuYmXAff6DC95yuwuga2MlBPVYvvbbggCmSMFhXqZUh9kdk8wrcrK
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-01.cisco.com

Fix premature freeing of admin-channel buffers and set the correct V2 VF
source ID in mailbox messages. This is v5 of the two-patch admin-only
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

- V5 passed build and static checks at both patch boundaries. Sparse
  reported the same existing diagnostics as the public base.
- The uninstrumented V5 candidate successfully bound, opened and closed a V2
  VF.
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

 drivers/net/ethernet/cisco/enic/enic.h        |  20 ++-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 239 ++++++++++++++++++++------
 drivers/net/ethernet/cisco/enic/enic_admin.h  |   4 +-
 drivers/net/ethernet/cisco/enic/enic_dev.c    |  44 +++++
 drivers/net/ethernet/cisco/enic/enic_dev.h    |   3 +
 drivers/net/ethernet/cisco/enic/enic_main.c   | 115 ++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   |  12 +-
 drivers/net/ethernet/cisco/enic/vnic_dev.c    |  85 ++++++++-
 drivers/net/ethernet/cisco/enic/vnic_dev.h    |  15 ++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  34 ++++
 10 files changed, 504 insertions(+), 67 deletions(-)
---
base-commit: 0df412012a26389582b120844d098e1e961f10a6
change-id: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

