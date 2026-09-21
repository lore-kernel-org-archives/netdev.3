Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84E4432F2;
	Mon, 21 Sep 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020891; cv=none; b=WV9GcwIT12O6cV4+5PvmFj2WK5WhzJ2k9ruzOvVpnxhoYKykqglpgYtCapyonlVE8BqXQW8HgKKP3X7c1NAVB3KTFEyVzJQ0iVZlweiiDFtK/QuN1pmqMjlHzx7pXS98eQvzFFAAN1noy5vFdQSy+XRtpzJu/D/tb4J6XXPe8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020891; c=relaxed/simple;
	bh=ohiCbsmehgPhHi4jMihcbiOCuZx+lSCRS0pRf5dyCPs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wrko0gug0XwG5cO/Cu3R0XEXGILc/hRGb0BPvSnep06OJ3UcTF2YL2CS0SpG1B9nd+9b1zeZb0stOgSOWXkpK5/JWH9jy4JLZ36d/icuezTtuQ05a8hdYQEJez6Wk+7I45MY8d3sk2NdgRNzPm1zMM7U+wgQaCoPe5EFy5xYJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=fkWSRADy; arc=none smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="fkWSRADy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3985; q=dns/txt;
  s=iport01; t=1790020890; x=1791230490;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=KSjttxtuYOgF/iTR6bLbLJtfDW806SK6C19fvDC2wpI=;
  b=fkWSRADyFmIGrHOywRfaOeRmbbcOPb+nD42vJodKbv8PXUKEjAPDahQx
   m50rkv6byrmsTlKIYvmgZq7ikPaYm7NDh4kZYh66+NxFONvBiT8+Ft3aM
   qErkXoAR4rBN1WntTmJcAV/PvS54BgCvSFFEnHhivZIGJoyjok/l4Z7i7
   9R9dEdIAJbZ6SoocJx78gXCyVhxVWkPgTZrn6BWFFadkhZYJNvbd8w1xl
   QURFAzPZdEVmUX2G6pDmsB9eburnB0pYj8ZG3ZnOr51m1uW0ge3ONhcSw
   ERkDPdf7OdS5q3x6mv+siunfS8qo9w6s7WS1attzW0HttTq8MNGZWxGnp
   g==;
X-CSE-ConnectionGUID: 8bLqk5csRuSgc2YxIrMayQ==
X-CSE-MsgGUID: PXydF3UuS2aMlEz782Ycjw==
X-IPAS-Result: =?us-ascii?q?A0A5AACvi7Fq/47/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?heCFENJhFeIG4c3giGeHoF+DwEBAQ9RBAEBhQWOCQImNAkOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBCgEBBQEBAQIBBwWBDhOGXJAVJ0QSNQImAkgWARKDAoJ1A8V4e?=
 =?us-ascii?q?oEygQGEftlKgXQVgQouAYVwgm0BgXCECDuEQScbgUlEgRWDaYQfg3+CagSBD?=
 =?us-ascii?q?oEUgQyCYQWLVoYeCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQdEg8EF?=
 =?us-ascii?q?jIdcAwnEiwXL1gbBgWBHXwUBBOCGiMZNnqBCV6BKylgARAXgQeCCAKCVIF/A?=
 =?us-ascii?q?gFJQw4HRVMJJ0EKEkcpIggSCQETGjALgScYDUgRLDcGDxkEPQFuB49eH4FpA?=
 =?us-ascii?q?WsGARZ5gQsiMhkEFxoRAR0BkwYqHYNZjV9roQ+EKIFmiCyXZDOXZ5MGmQgjo?=
 =?us-ascii?q?2cBT4RpgWg8gVkzGggbFTuCZ1MZD49YAQGSBwG8eycyPQEBBwIHDgMLgWiEX?=
 =?us-ascii?q?osiAgMMFweBTwEB?=
IronPort-Data: A9a23:bCCYQqshFsEBcjcGMlN17JpmNOfnVIRfMUV32f8akzHdYApBsoF/q
 tZmKT/XPKncNmfyKNoibtm3oU5SvpKDzt9kTldvpCFhQ3hAgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrb/656yYsjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZzdJ5xYuajhKs/PZ8Us11BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIwquxTGGIT/
 uciNQsCZUqyl8Os5buqc7w57igjBJGD0II3oHpsy3TdSP0hW52GG/iM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtNYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUoHQGJQJzhzH/
 goq+UzBMgAWGoei1AHf+1eoq/2QzXnKU4ANQejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdxK/p3GAs1gXXN84O+098gSW4qnZ+QCUAi4DVDEpQN87vsYeRjEw0
 FKN2dTzClRHubuZU3+CtbGZsT+/JwARMGkEIyQEJSMd6tPupoAblB/DTt9/VqWyi7XdHTD23
 iDPryUkgbgXpdAE2r/9/l3dhT+o4J/TQWYd4AjLUm+7xh12aZTjZIGy71Xfq/FaI+6kokKpp
 nMInY2aqesJF5zIzHHLS+QWF7bv7PGAWNHBvWNS81Aa32zF0xaekUp4ulmS+G8B3h44RALU
IronPort-HdrOrdr: A9a23:pgI2cqhSdGu5QnfpAhLOEzLmXnBQXkQji2hC6mlwRA09TyVXrb
 HLoB1973/JYVcqOU3I9urtBEDtexnhHP1Oj7X5Q43MYOCOggLBR72KhrGO/9SPIVyaysdtkY
 w8N5VkANfzDV915PyKgzWQIpILwdGB/qztpcq29QYOcShaL4xt8At9DB+WCQlVSBkuP+tBKL
 OsoudKuDakf20adYCABncDV/XevNGjruOBXfd/PW9B1CC+yRW19bX9Dx+Umj0aUz9J3PMe1F
 KtqX2A2k1m2MvLsCM1EATonu9rpOc=
X-Talos-CUID: =?us-ascii?q?9a23=3AxMeK92iiHdFN35zjEv+zCgRXcTJuInf51XSNKFS?=
 =?us-ascii?q?CFF1mQ+ekWX6K3ap1qp87?=
X-Talos-MUID: 9a23:2jTMNguNKPXlIS5xMs2nvAFzOOkz3rmVUkkolbgU5JneBCdyJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,115,1787011200"; 
   d="scan'208";a="525948270"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Sep 2026 20:00:21 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPS id AF7B218000236;
	Mon, 21 Sep 2026 20:00:20 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net-next 0/6] enic: configure V2 VF addresses and receive
 mode
Date: Mon, 21 Sep 2026 12:59:43 -0700
Message-Id: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK+MsWoC/yWNwQrCMBAFf6Xs2YW0tIX6K+Kh2b7qimwkiaFQ+
 u9GPQ4DMzslREWic7NTRNGkwSq0p4bkPtsNrEtl6lw3uqkd2fcMU+EUNRQuHZeVIwRawBIsx/B
 kP0jv/DJj8BPV0iti1e13uZAhs2HLdP2b9PYPSP5O6Dg+7rAlYpEAAAA=
X-Change-ID: 20260916-b4-enic-sriov-v2-vf-receive-control-b5c40bdae5b9
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790020820; l=4098;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ohiCbsmehgPhHi4jMihcbiOCuZx+lSCRS0pRf5dyCPs=;
 b=6zVQ/uUqa2Dt938frJYwiPUOTnx10MPh7Bd67vNVjr50ANPQzqs1tAo75sTmoMIq36xDKmKz/
 4UBYKaoLcohDw2BWPobTlStgte1m2Y3flYzeOrdOe/nbrOHVnI7O5bo
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-05.cisco.com

An ENIC V2 VF cannot program its station address or receive filters
directly. The PF owns those resources and exposes mailbox operations for
the VF to request changes. Add the VF control plane needed to use those
operations for station-address, address-list, and packet-filter
configuration.

The mailbox transport remains asynchronous: receive dispatch continues to
process replies and unsolicited PF notifications. The VF allows only one
request/reply transaction at a time because it stores one expected reply
and uses one completion. This serialization applies only to VF requests;
PF-side request processing is unchanged. Notifications and their
acknowledgments remain deferred and asynchronous.

The first patch adds a netdev helper for scheduling an immediate, complete
receive-mode replay. The second patch serializes only VF requests. The third
patch recovers when a lost or malformed reply means that the VF does not
know which changes the PF applied. A hardware send timeout is handled
separately because the descriptor may still belong to the device.

The remaining patches add and validate the configuration operations,
manage station and administrative MAC changes, and install address lists
and packet-filter settings through the sleepable receive-mode path. Replies
are checked against the requested operation. If a station-address
replacement deletes the old address but fails to add the new one, the VF
registers again and rebuilds its mailbox state instead of assuming which
address the PF kept.

This is the VF-side receive-control series. It does not register
.sriov_configure, so the in-tree V2 PF path remains dormant. A later PF
activation series must implement the PF side of the MAC-address and
packet-filter mailbox requests, including the VF policy checks, before
wiring that callback.

AI assistance:

An LLM was used for design review, source review, commit-message
drafting, test automation, and review triage. Sashiko was used as an
additional review tool. All findings and generated changes were manually
reviewed, and the author takes responsibility for the series.

Validation:

- With this 6-patch series, the VF module passed 20 unload/reload cycles,
  10 concurrent PF administrative-MAC versus VF unload/reload race cycles,
  and concurrent 100-unicast/100-multicast address churn with 20 netdev
  reopen cycles. Carrier, the selected address, bidirectional traffic, and
  host/guest kernel health were checked.
- With this 6-patch series folded into the full SR-IOV development stack,
  the final module passed the 20-case cross-DUT PF/VF TCP, UDP, and
  8972-byte jumbo matrix. It also passed 100 unload/reload cycles on each VF
  guest, 25 PF administrative-MAC versus VF unload/reload race cycles, and
  a 30-minute post-stress traffic and kernel-health soak.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Satish Kharat (6):
      net: add netif_rx_mode_schedule_fresh()
      enic: serialize V2 VF mailbox requests
      enic: recover V2 VF mailbox when PF state is unknown
      enic: validate V2 VF configuration replies
      enic: manage V2 VF station and administrative MAC
      enic: configure V2 VF receive mode over mailbox

 drivers/net/ethernet/cisco/enic/enic.h       |   54 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c |   29 +-
 drivers/net/ethernet/cisco/enic/enic_dev.c   |   11 +
 drivers/net/ethernet/cisco/enic/enic_dev.h   |    1 +
 drivers/net/ethernet/cisco/enic/enic_main.c  | 1259 +++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c  |  740 ++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.h  |   84 ++
 drivers/net/ethernet/cisco/enic/enic_rq.c    |   11 +-
 include/linux/netdevice.h                    |    1 +
 net/core/dev_addr_lists.c                    |   21 +
 10 files changed, 2131 insertions(+), 80 deletions(-)
---
base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
change-id: 20260916-b4-enic-sriov-v2-vf-receive-control-b5c40bdae5b9

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

