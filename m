Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED0A55D897;
	Tue, 29 Sep 2026 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708385; cv=none; b=sVJz3cAJZPumZvHmO0+Yy6uMNMwBpBJBH40pKHSFq6rUVtp4x0KyrlYayQO+vQTmHB98fzbjxDmsYkilcbORhzBZfbVr+74ifDtgswxzYL56aRDZbBLI7ExqWKx0tCYFeLIo2kJqgCF9O+FMmcbjS6CZwnhgg9EcaV4C37B0BQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708385; c=relaxed/simple;
	bh=Jekz/4yMFLlCICjtt4QrF7H6M0ZF4KdSuSKgZpq49m0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XsboBODjpQiNCZTbDrVOcDalEbcXGG39BtNtG0mtxLfpoDJBva8YKc+9WHp50pOdOKetzFi1oDXSZD6mldWzDgeFbx1zoPr8oot7vQjHL0rpdH5H8rCFLA9IscptXzh0CIjuMZmusxW2s7tMkgUReDdQVJpQWjbiJDNBt69Wt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=KQQmhd31; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="KQQmhd31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5261; q=dns/txt;
  s=iport01; t=1790708383; x=1791917983;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=uIbCTW08h42rABK1YivWmm10n/GoyKyR5MMamQkcFFw=;
  b=KQQmhd31etWXO6st4IfTxIg3SAlu0q/949Cxp4Xmhj9OKF9zwwD6hEPA
   AgXvH0TJJnaLc8/ryrqDqO86A5kXj0FSCYNiaQPJfMUg93jXEwDymnoih
   NPFRc6jlD0767K7eAM4KFleqvR2cBgFwbC6beN+QisR6YTpMhCumnXY4z
   CX0y8Q9aJL5Oa0x8kdRwjiacq0wV/99rWYpkg/VR5NMpJnNjjttz6NZO8
   /pmuq76K9+SGLiJT0C+MQe+OISpneezRxaiFuC541kUFjNYZjVKZ0SX8I
   ZdbFjvni1bH2diWOfxetGbNeyRs17cFqxP1LgPOslWRqvpBe2FzbCB8q7
   g==;
X-CSE-ConnectionGUID: UhBZRq9bSomSh56KW4y0zw==
X-CSE-MsgGUID: 4CZKd/7AShOR3XClAn4I4w==
X-IPAS-Result: =?us-ascii?q?A0AnAADCCbxq/4v/Ja1aHAEBAQEBAQcBARIBAQQEAQFMg?=
 =?us-ascii?q?TAHAQELAYIXgTRgQ0mEV4gbhzeCIZFMjFEUgWoPAQEBD0QNBAEBhQVRFY0kA?=
 =?us-ascii?q?iY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZPDZAVJ1Y1A?=
 =?us-ascii?q?iYCSBYBEoMCAYJ0AxEFAcEqeoEygQGEftlKgW4GFYEKLgGFcYJtAYFxhAg7h?=
 =?us-ascii?q?EEnG4FJRIEVg2mEHwuDdIJqBIEOgRSBDIJdi1SGdwk/gQIcA1ksAVUTDQoLB?=
 =?us-ascii?q?wVhUjMDIAoLEhIYFQIUHRIPBBYyHXAMJxIsFy9YGwYFgR11FAQTghkjGTZ6g?=
 =?us-ascii?q?QlegSspYAEQF4EHggcCglSCAAIBSUEOB0VTCSVFEkcmIggSCQETGjALgRs4P?=
 =?us-ascii?q?gkoPRgNSBEsNwYPGQQ9AW4HkDcegW0BcQEWRDUrUAcJIg88BBcaEQEeLJJaI?=
 =?us-ascii?q?ggdg1mNX2uBNZ9ahCiBZogsghCVVDOEBJNjkwiZCCOCNosxih6LShgBT4Rpg?=
 =?us-ascii?q?Wg8gVkzGggbFTuCZ1MZD49YAQGGHItrAbx7JzICOwEBBwIHDgMLgWiEXosiA?=
 =?us-ascii?q?gMMFweBTwEB?=
IronPort-Data: A9a23:sbBRvan92egxgg7cO1xA9UHo5gxTJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIWWWHVbqzfMDbzeo93a9u09k1XscWEyoAxGVNrq3s9EltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4Errav6+/SEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZK31GONgWYubDpFsfPb8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FbAY0NRNGDBEz
 vsdEzBQMDO82/Pu0q3uH4GAhux7RCXqFJkUtnclyXTSCuwrBMiZBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQUaz/7C7pm9AusrmL2bzxDqFGVjaE2+GPUigd21dABNfKIII3THpoMxhvwS
 mTuo0/LIR1da/WkyR2/qUKHgsbJwQKnR9dHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JQFPc/8ymOx7DS7gLfAXILJhZCddYvnMw7Xzon0
 hmOhdyBLTVpvKeYVjGb+6uYoC2aPTUTKykJZUcsVQIP7t/iiJs+ghLGUpBoF6vdptn0Hyzgh
 jOHti4zg50NgsMRkaa251bKh3SrvJehZgg4+gnaQEq74Q5jIo2ofYql7R7c9/koEWqCZkOKs
 H5Bn42V6/oDSMnX0ieMW+4KWrqu4p5pLQHhvLKmJLF5nxzFxpJpVds4DO1WTKuxDvs5RA==
IronPort-HdrOrdr: A9a23:ggf8OqxpZEXCcCZY86NJKrPwsr1zdoMgy1knxilNoNJuA6ilfq
 eV/MjztCWUtN9/Yh0dcLy7UpVoIkmzyXcK2+Ys1N6ZNWGMhILCFuxfBOXZsljdMhy73bMY6L
 xpeap/D9OYNykYse/KpCO4G9EvzJ2m3cmT9IXj5kYoYA10Z6Rn9gtjTiSWAiRNNXB7LKt8OZ
 aC6s9Avja6PU4WYMOyG2UfU4H41rv2ferdEHk7Li9izhWShjW177O/OR2Z0hACFw5r+94ZgB
 D4e8iT3NTYjxl9oSWsrFPu0w==
X-Talos-CUID: 9a23:Hb6APm+jrBXIU+9gHlOVv3MUMPIfayzX93DVGE/lV0VWFKzNW0DFrQ==
X-Talos-MUID: 9a23:PxeF3Ql1HSdyPOCsKB5ddno+H/VL7+PxIXsNtq9di+KAHCosGmuC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,130,1787011200"; 
   d="scan'208";a="529137105"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Sep 2026 18:58:35 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 749A318000356;
	Tue, 29 Sep 2026 18:58:34 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net-next v2 0/6] enic: configure V2 VF addresses and
 receive mode
Date: Tue, 29 Sep 2026 11:58:03 -0700
Message-Id: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADsKvGoC/42OTQ6CMBCFr2Jm7ZhSAcWV9zAs6DDIGG1NWxsM4
 e7ycwGXL+/neyME9sIBLrsRPCcJ4uws9H4H1Df2zijtrEErXaoqK9HkyFYIgxeXMGlMHXomlsR
 IzkbvnmgKypVpGy5MBfPS23Mnw0q5geWIlocI9eaEj3kwxQWyZHsJ0fnveihla2Nj6+wvdspQY
 XlqVFOyOrf58UoSyB3IvaCepukHUU/sYPIAAAA=
X-Change-ID: 20260916-b4-enic-sriov-v2-vf-receive-control-b5c40bdae5b9
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790708314; l=5383;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=Jekz/4yMFLlCICjtt4QrF7H6M0ZF4KdSuSKgZpq49m0=;
 b=y4Qz5ssuu2o9c01ysdCC9XTs6DYBGjixSQKeBzpM1Bh0Qfi3E7QWGx4UXhlaf6O4te2j2hYJ/
 Rec+GTH2aypAbnmAEKBVptRK7Og+HVV5Wk0KMi3iRX0ud3WyQ7rUF4G
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-02.cisco.com

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

The first patch adds a netdev helper for scheduling an immediate
receive-mode update with a new retry budget. Callers which need to replay
lost address state explicitly reset the corresponding synchronization state
before scheduling the update. The second patch serializes only VF requests.
The third patch recovers when a lost or malformed reply means that the VF
does not know which changes the PF applied. A hardware send timeout is
handled separately because the descriptor may still belong to the device.

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

- The exact v2 VF module against the deployed async PF passed 32 secondary
  unicast addresses, station-address add/delete through the multicast list,
  and fixed administrative-MAC enforcement across a close/open.
- Isolated test-only fault and timing controls verified bounded behavior
  under persistent registration rejection, no reconnect after a coherent
  generic MAC-operation rejection, convergence when an address changed
  during receive-mode processing, and synchronous broad-to-exact filter
  completion.
- With all injections disabled, the exact v2 VF passed 20 multicast
  add/delete operations, three close/open cycles, statistics retrieval, and
  bidirectional traffic. Bounded host and guest kernel-health scans found
  no new fault report. The installed kernel was not rebuilt or rebooted.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Changes in v2:
- Rename the netdev helper to netif_rx_mode_schedule_update() and clarify
  that it resets retry state and schedules reconciliation without itself
  forcing a complete address-list replay.
- Stop a failed registration-recovery handshake from requeueing its own
  reset worker indefinitely.
- Keep coherent generic MAC-operation failures as ordinary errors;
  reconnect only after explicit registration loss or an indeterminate reply.
- Enforce a cached fixed administrative MAC while the VF is down and repair
  an actual device-address mismatch during registration.
- Preserve compatibility with deployed async PFs at 32 secondary unicast
  addresses and exclude the station address from both secondary lists.
- Complete receive-mode transitions in one callback so concurrent list
  changes converge and synchronous operations return with filters
  installed.
- Link to v1: https://patch.msgid.link/20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com

---
Satish Kharat (6):
      net: add netif_rx_mode_schedule_update()
      enic: serialize V2 VF mailbox requests
      enic: recover V2 VF mailbox when PF state is unknown
      enic: validate V2 VF configuration replies
      enic: manage V2 VF station and administrative MAC
      enic: configure V2 VF receive mode over mailbox

 drivers/net/ethernet/cisco/enic/enic.h       |   58 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c |   29 +-
 drivers/net/ethernet/cisco/enic/enic_dev.c   |   11 +
 drivers/net/ethernet/cisco/enic/enic_dev.h   |    1 +
 drivers/net/ethernet/cisco/enic/enic_main.c  | 1251 +++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c  |  739 ++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.h  |   84 ++
 drivers/net/ethernet/cisco/enic/enic_rq.c    |   11 +-
 include/linux/netdevice.h                    |    1 +
 net/core/dev_addr_lists.c                    |   21 +
 10 files changed, 2126 insertions(+), 80 deletions(-)
---
base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
change-id: 20260916-b4-enic-sriov-v2-vf-receive-control-b5c40bdae5b9

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

