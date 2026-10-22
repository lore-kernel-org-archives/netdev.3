Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670264;
	b=EaiDPOdOj4USvKYrZxQAPIT3M07FAFYf5RgIabASQm4HNjeGee5JPLqq8hm5TyEsXiSu
	 XfmDc08OT9xx9plaNkWVP4pwcBoqWzdgaWOPGnCRiW+B9Mx4ae3LMctb9nkpwcP/Cbj/Y
	 3HiLPNSRL7j7BccUv5XPuH24b9pPBaqOc3pkj5sK/m42QicKcPADBGYCxNPqeTMC1CDQ5
	 Vr6v9Z+M7TywTZGymbTCT8OiO51+hgdHwvpAEhP0Lq4CrlgpyrtTEu3LqIdyOMU4w0L0x
	 6dpPu16Bxa6B6CYp/4MEEkKyVsKWjlPxC+ZS4RphvOlhbQkbQ5pD0MKJV/KMrJTS53g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670264;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Outbound-Client-TLS:
	 X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=sMIcKPJwfbZSsT0tfZLX9zmwok0y7eW3OpwO0VIxwYs=;
	b=rvTWgm6T9Kbf43dcyRasAbgE8BdCMhgOgNmaDNyDKowGsv5IcXh1V45UOsbOPjl0KyWl
	 SFvWuPNU/ftCuWdPedx6s/uZGhikaJ2wGXpw35QXLA4v45MJYsX5yS+jDhTIFfjnoj6aX
	 NB9lzgpy86q0xyA6nrXCDRLrnc7xA+N4VrOc9/mzADDkc9WIrhQrw3cdMRQLXsxe3j5Kw
	 57vndqLLvTzeJvsLR3395s8z6rBl+oUVK/W53zjnUBmRG/CWTXxuvTntKldWEVyucYoqn
	 VPpdczIth157qxcZ60vsMJGC+FRgiRF04guRXIJuQaJodcmyEQnnvaIaRhkg1Tgs7gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=R4Dq8yx0;
	arc=none smtp.remote-ip=173.37.86.79
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC537606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC537606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=R4Dq8yx0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6245; q=dns/txt;
  s=iport01; t=1792670263; x=1793879863;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=sMIcKPJwfbZSsT0tfZLX9zmwok0y7eW3OpwO0VIxwYs=;
  b=R4Dq8yx0KqCTR9YowwkPQKZRtnWSsppez4YO7In/4/KoDq5oOOC+w7An
   4pQtJ6xstgfL+5uBB9wKfEBoE3cTtPbeb1BJbBvJykPNp9b8Z1ITFXY7B
   FAu4CKFEV/3AQypzOmkMy4xekiQQQJErJ8iHV0DLOpsS9KMkBJLPuNJar
   KCsXS1vgANKWXz89s9nvQNJsXpoysghe3P5jC5hkJeXgX2f/oO8W6xYyW
   gvy91ffErLct/aGNC86dnhXcH1wTONfXi/JJjkfYfhzxevZQDlSlkkK+h
   4BkWQmLCyzOQgik+3K3R/pPITOL5sbbOcoK9Mh+l5NjqqjELH0RwixwgN
   A==;
X-CSE-ConnectionGUID: PTMec+g9SyO4EItzvZ9y9w==
X-CSE-MsgGUID: jb0mz0rUQ6mZqzO8/wMTLQ==
X-IPAS-Result: =?us-ascii?q?A0AnAAAG+dlq/5L/Ja1QChwBAQEBAQEHAQESAQEEBAEBT?=
 =?us-ascii?q?IEwBwEBCwGDS2BDSYRXiBuHOIIhgRaQN4xSgX4PAQEBD0oHBAEBhQVRFY0xA?=
 =?us-ascii?q?iY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZPDZAVJ1Y1A?=
 =?us-ascii?q?iYCSCmDAgGCdAMRBQG0W3qBMoEBhH7ZSoFuBhWBCi4BhXGCbQGBcYQIhHwnG?=
 =?us-ascii?q?4FJRIEUAYJzdoQKDAmDf4JqBIEOgRSBDIkChB2JKgk/gQIcA1ksAVUTDQoLB?=
 =?us-ascii?q?wVjgQUDNRIqFW4yHYEjPhcvWBsGBYEdgQcEE4EWIxk2a4EJXYErKWABIYEIg?=
 =?us-ascii?q?XYCglGCAAIBSUEOB0VTCSVDEkckIggSCQETGi4LgRo4PAkmQRUMZggDGgVAA?=
 =?us-ascii?q?iAIAg0MfzkJGA1IESw3FRkEPQFuB5FdghcBcAEBFToIARwGCQsHDBIGUCsWC?=
 =?us-ascii?q?AEaNBUGAQEBAQwGJCEZkmODf4wogTZrgTWfWoQogWaKPJVUM5dnkwiZCI4Ki?=
 =?us-ascii?q?h+LHC0PDE2EaYFoPIFZMxoIGxWDIlMZD44uFocyywgnMgI7AgcCBw4DC4ZGi?=
 =?us-ascii?q?yICDxcHgU8BAQ?=
IronPort-Data: A9a23:UG0CZ6O1MA1W+C3vrR3ilsFynXyQoLVcMsEvi/4bfWQNrUoh0WcHn
 GAXW2DXaamPZTH3edp/OornpEMOuJPQytdiG3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeap1yFjmD9k/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVzlV
 e/a+ZWFZgb9gWQsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj681SKUw9foJJwfdQXUxv6
 e4GGmEcPw/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmIS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMnwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQsi+Cyb4qPIIfiqcN9nEzAo
 3Ce5VnAXBQoLc64mX2a106Iv7qa9c/8cMdIfFGizdZsjUGfy3I7FhIbTx24rOO/h0r4XMhQQ
 3H44QI0pqQ0sUjuRd7nUljg8TiPvwUXXJxbFOhSBByx95c4Kj2xXgAsJgOtovR/3CPqbVTGD
 mO0ou4=
IronPort-HdrOrdr: A9a23:b4gFKqu7svM6Zu79Y6NN0+CI7skD6NV00zEX/kB9WHVpmwKj5q
 STdZMgtSMc6QxxZJhOo7y90cW7K080lqQa3WBuB9iftWDd0QPCEGgI1+bfKlPbakjD398Y/v
 olTrN3At/xClYSt7eY3CCIV/wgyN6I/OSJqI7lvhVQZDAvRq1+4wJ+EwqBVm97VGB9dOMEPa
 vZy8ZZqz+nYHgNKv66CH4MQvTZq7Tw5fTbiGY9dnkawTjLqy+047jnFBXd9BIfXzRThYoGyw
 H+4nTEDmHJiYDA9vcavFWjlKhrpA==
X-Talos-CUID: 9a23:gx5L92CaOJPlk3f6ExFb0UMfWc90SWz6kFrxP12mOzd4GaLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AQRTZLQ7Mp6nNxwXYTBJbq5Qsxoxq6fyrGhgXrKx?=
 =?us-ascii?q?YvvudJwsgfCi4sBCOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,172,1787011200"; 
   d="scan'208";a="530778223"
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Oct 2026 11:57:36 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTPS id 2234F1800023D;
	Thu, 22 Oct 2026 11:57:35 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net v2 0/2] enic: retain admin DMA resources and identify
 V2 VFs
Date: Thu, 22 Oct 2026 04:56:59 -0700
Message-Id: <20261022-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v2-0-8db19b4a714e@cisco.com>
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
X-B4-Tracking: v=1; b=H4sIAAv62WoC/52OwQ6CMBBEf8Xs2TUUKIIn/8NwgLKFNaE1LTYYw
 r9b0PgB3nY2M29mAU+OycPlsICjwJ6tiSI9HkANjekJuYsa0iQtRCISbHMkwwq7scGgkU1HMxq
 asCcTUQo1Oz9hEPiLdFXT6lyKJMskRPDDkeZ5L71BjEL9efpneyc1bXWbbWA/WffapwWxm7/I4
 p8V8Y5T0nMrpS6qssyuir2yJ2VHqNd1fQM15RiHCwEAAA==
X-Change-ID: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335
To: netdev@vger.kernel.org
Cc: Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792670255; l=6311;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=W4fQ2/UFr7tl95yYKYqmcNdhCtVrxWNa1QYGwaoEv+I=;
 b=NXGRN48Liw3+/a2cliZRhH32v1TrdtQrfAza6A13a9rhrvWVHBlxZM+CwZ7ltsL4prRWwIuyG
 3nYut4L3+z2C6MGBXViHNKGtYbEJpzRHEgif1AKfjnFU4x1xaGgf+hq
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-09.cisco.com

Fix premature freeing of admin-channel buffers and set the correct V2 VF
source ID in mailbox messages. This revision replaces the three-patch v1
with two patches. The generic datapath quarantine proposal is withdrawn:
its page-pool/device lifetime and the underlying generic queue-disable
error path need separate work.

The first patch retains the admin WQ/RQ/CQ allocation when queue shutdown
does not establish RUNNING == 0. Both complete disable helpers must
succeed before the graph is released. Give both queues a first attempt,
then retry once only a helper which timed out. The 500 ms polling bound
is local to admin shutdown; ordinary WQ/RQ and DEVCMD2 timeouts are
unchanged. Admin receive buffers are driver-owned mappings, not page-pool
pages which can return later from the networking stack.

Keep PCI bus mastering enabled during runtime admin quarantine so the
independent datapath and DEVCMD2 remain usable. Serialize removal against
open, do not reopen admin after a failed datapath open, and finish normal
generic teardown and required firmware commands before final containment.
A final direct admin queue recheck can release the retained graph. If it
cannot, retain the inert owner and DMA targets until reboot rather than
free memory the device might still reference.

Terminal retention intentionally leaves allocations and a BAR reservation
behind. The reservation prevents ordinary reprobe while the PCI device
remains enumerated; PCI remove/rescan is not a supported recovery method.
Hold the PCI object for the reservation name's lifetime, not as a DMA
fence or a way to preserve IOMMU state. No IRQ, work or other CPU callback
may enter the retained admin objects after module unload. DMA debugging
can report the deliberately pending allocations.

The second patch requires DEVCMD2 for SR-IOV V2 and obtains the VF's
logical mailbox source index from CMD_SRIOV_STATS_GET. This lets a nonzero
VF register with the deployed async PF, which checks the header against
the CQ-derived sender. Keep the statistics target persistent and observe
command posting/completion separately from firmware status. A later
blocking QP-command result fences the earlier target even when that
result reports an error. A pre-post failure, posted timeout or NOWAIT
posting does not establish completion.

Sashiko's v1 feedback prompted the lifetime and command-completion audit.
The fixes follow from the ownership paths and transport behavior; the
review tool's severity labels are not their justification. Source review
and testing were assisted by LLM tools. The author is responsible for the
submitted changes.

Validation:

- Tested Cisco VIC PFs and V2 VFs with all four combinations of in-tree
  and deployed async PF/VF drivers, including a nonzero VF. Traffic tests
  covered bidirectional ICMP, TCP, UDP and jumbo frames over ENIC.

- The full suite passed address and filter changes, administrative-MAC
  policy checks, and multiple cycles of module reload, ring resize,
  interface reopen and VF destroy/recreate.

- Test-only instrumentation checked admin queue retries, delayed queue
  shutdown, cleanup after partial open failures, statistics-command
  success and error replies, late replies and command-result ring wrap.

- Fault-injection tests verified admin quarantine and both removal paths:
  successful cleanup when the final queue check passed, and retention
  when it failed. Module unload preserved the BAR reservation and blocked
  reprobe. After a guest reboot, the driver loaded and traffic passed.
  Statistics-command failures requiring buffer retention were also tested.

- Statistics snapshots across traffic, address/filter changes, interface
  reopen and ring resizing showed a stable VF index and consistent
  resource counts. Free flow-table entries decreased after address
  additions and returned after deletion. Packet and byte counters
  increased consistently with TCP and UDP traffic.

The interoperability and full-suite tests included later VF/PF feature
patches. These two fixes alone do not enable in-tree PF SR-IOV support.

The fault-injection tests allowed the real hardware queues to stop;
they did not reproduce a physically stuck queue. Physical device
removal and IOMMU teardown were not tested.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
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

---
Satish Kharat (2):
      enic: retain admin-channel DMA until queues stop
      enic: require DEVCMD2 and set the V2 VF mailbox source

 drivers/net/ethernet/cisco/enic/enic.h        |  22 ++-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 211 ++++++++++++++++++++------
 drivers/net/ethernet/cisco/enic/enic_admin.h  |   4 +-
 drivers/net/ethernet/cisco/enic/enic_dev.c    |  21 +++
 drivers/net/ethernet/cisco/enic/enic_dev.h    |   2 +
 drivers/net/ethernet/cisco/enic/enic_main.c   | 115 +++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   |  13 +-
 drivers/net/ethernet/cisco/enic/vnic_dev.c    |  85 ++++++++++-
 drivers/net/ethernet/cisco/enic/vnic_dev.h    |  15 ++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  34 +++++
 10 files changed, 464 insertions(+), 58 deletions(-)
---
base-commit: 0df412012a26389582b120844d098e1e961f10a6
change-id: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

