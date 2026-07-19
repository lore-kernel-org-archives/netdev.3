Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DF358D32;
	Sun, 19 Jul 2026 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450596; cv=none; b=kFZL45TrCgANW3N3i4eqN6o0zbU/SdCJwDLP6nCeY/GCU3Fkk21dnUFGXlcIUv4MawOspKp0ZBlmfw778uymjJpXF1rdWLkOwIuzk3l03M3NPxecTdCOp8DoT8XxWXXRCg3yPoHIqT7dF86K8vuPQ4eETXQ0tVu5N1R33LcpafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450596; c=relaxed/simple;
	bh=JCvCSovmVL4IvX5jztghunfFr17h/VyJdQ3/UmZxUzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=helrPsNAKRzpr69JJicCygsihMWpmCCiYwoNzI1v+HiTOndnsiouDLlg4PPrBxCroyAeKzIKQCu/o1qySidWEeCBlVsIhlLLAXbzPgYN/VZGLRIeobUGUUIWt+SGqt31pmWewZY94k6O7oll04oN4HMKYpcYmSKhnzM8Ev7rlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=C/02n2St; arc=none smtp.client-ip=173.37.86.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="C/02n2St"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=16138; q=dns/txt;
  s=iport01; t=1784450594; x=1785660194;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Ao8ZLckvZ2DxbJWcWSfF3l7rVyg0yq1gv9USZdYP4bM=;
  b=C/02n2StqLr++8L6rPq7dcZmXSxCdJJMdvJQDu6pGmpOrubPmlMvoz64
   KpB81/Mi1EW/YqL8soheQe7Mw1JToiB35gFL2AQX1NTrjYIfkZ6zyoL13
   iWI7BQgz7EuCMORw9dnINkAxN51cKbpEh8P6UqPvVfp460J7URZAVims4
   7KUeygLRfykZyrcc5nsWHiRzWgqFSJA/r0ZCRB4E9R5cgo0ORceo92jzm
   livSgJwnpALGAl3ROQk/CyKmrUDgAGzQ8+RtD2aLNK8EUKiBqdpAxwdpH
   rSuR2Y8MWKROxSh6KmsTXKGs5bdKUbc9M6pc7PGO2bEqquit8tTkHVIQ3
   A==;
X-CSE-ConnectionGUID: gnuFrZMtQpq6d6NrvWvEMQ==
X-CSE-MsgGUID: eHEkTgIzQT2xux7RkpypxA==
X-IPAS-Result: =?us-ascii?q?A0AEAABUjFxq/5H/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBTIEwBQEBAQELAYNKXkNJA4RUiBuHN4IhgRaQN4xRFIFqDwEBA?=
 =?us-ascii?q?Q9EDQQBAYUFURWMbwImNAkOAQIEAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHB?=
 =?us-ascii?q?YEOE4ZPDYZdJwQLATQSNQIRFQJIFgESgwIBgnQDEQUBvHJ6fzOBAYR92UiBb?=
 =?us-ascii?q?AYVgQouAYVwgmsBgXCEBzuEQScbgUlEgRQBgnN2g3wJFQEEC1iDHIJqBIEOf?=
 =?us-ascii?q?4EhgQ2BO4EtfYcghVoJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PB?=
 =?us-ascii?q?BYyHXAMJxIsFzRYGwcFgR1/FgQhgQKEdiMfAzl/gTB1SnctaQESF4EvghSBO?=
 =?us-ascii?q?gIHAwsYDUgRLDcGDhkEPQFuB41AI4FOPBUQDwEBPBsBAQkYCQsHAgoYGAotA?=
 =?us-ascii?q?SMICA4yCgMYFQUFDAEMEgEKIQgPApJGAhsIEwIlgzyMKYIhgTWfWoQngWaKO?=
 =?us-ascii?q?5VUATKXZ5MFmQgjjWeKHosWLgUMBCKFIIFoPIFZMxoIGxU7gmdTGQ+VdYFBy?=
 =?us-ascii?q?UcnMgIFOAcCBw8ChlGLIgEBAgMKFwdvYAEB?=
IronPort-Data: A9a23:wUe/sanSRu/E8CLPK5jh8m/o5gxcJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJKW2GPOvveZGvxf4onad62/UkH7JXQmoJlTgBqpHtkRltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZC31GONgWYubDpLsvPb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FYIe58htM0RSz
 OQBdjxTSAqduPyb5YvuH4GAhux7RCXqFJkUtnclyXTSCuwrBMiTBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZz/7C7pm9AusrmL2bzxDqFGVjaE2+GPUigd21dABNfKII4bXFZ4PwRbwS
 mTu8kTUAS0VFc6m9WCV72LzvOzXjDvrcddHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIqoKku/UuDQtT3XhS+5nmesXY0VtZNFuQo5R2lxa3T7AKUQGMDS1Zpa8Esvec1SCYs2
 1vPmMnmbRRmtrGPRG3e8LqIoT6sESwIK2lEbi9sZRMM6dTloakpgx7PR8olG6mw5vXxGDft0
 3WJoTI4irE7k8EGzeO48ErBjjbqoYLGJiYz6xnbU3yN8Ax0fsimapau5Fyd6uxPRLt1VXGbt
 3QC3szb5+cUANTVxGqGQf4GG/ei4PPt3CDgvGOD1qIJr1yFk0NPt6gKiN2iDC+F6vo5RAI=
IronPort-HdrOrdr: A9a23:ZuLkSajJ9FFxhvarDUEAyNAmIXBQXkQji2hC6mlwRA09TyVXrb
 HLoB1973/JYVcqOU3I9urtBEDtexnhHP1Oj7X5Q43MYOCOggLBR72KhrGO/9SPIVyaysdtkY
 w8N5VkANfzDV915PyKgzWQIpILwdGB/qztpcq29QYOcShaL4xt8At9DB+WCQlVSBkuP+tBKL
 OsoudKuDakf20adYCABncDV/XevNGjruOBXfd/PW9B1CC+yRW19bX9Dx+Umj0aUz9J3PMe1F
 KtqX2A2k1m2MvLsCM1EATonu9rpOc=
X-Talos-CUID: 9a23:MaM5cmDP4subYmH6EyZh6WAOKOU5S2XEknuOBVWmNnhEbYTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Ap5QXlg0GuUcr14MO2I8iRgPHTzUj7oSDC3wCsIc?=
 =?us-ascii?q?/h5OUKDwvATSFnSyna9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; 
   d="scan'208";a="512583278"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jul 2026 08:42:06 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id D0D56180005BA;
	Sun, 19 Jul 2026 08:42:03 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net-next v12 00/12] enic: SR-IOV V2 admin channel and MBOX
 protocol
Date: Sun, 19 Jul 2026 01:41:44 -0700
Message-Id: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMiNXGoC/5XTyWrDMBAG4FcJPldFM6O1p75H6UHW0ggau9jBp
 IS8e2VTiHAOao9a+P4ZRrp2c5xynLuXw7Wb4pLnPA5lAfh06PzRDR+R5VA2OuSouOCCxSF7Nk9
 5XNiCzIVTHth6c4if64bnzlG0xhiiriBfU0z5siW8dUM8syFezt17OTnm+TxO31v0Atv5b4hqh
 SzAODPovdCKlNPm1efZj89+PG30gjVnmhwWLnAZAimkFGjP0f84KhwEYa11nHz0e05UHECTE4V
 LXCKh8uik3nOy4pCanCycd84myYWj8FCdunOStzlVOO6SSL3HYFTYc7rioM3pwinT2yRAQBIP1
 Zk7p7htcmZ9KC6Y3vV9b1DtOVtxoJucLRzpJJMsHXv78FCAVx62ywO+totSWZcMCXiYLVQfQ/9
 hGrD+DNlrsglStFHW4O12+wH7EOKb8QMAAA==
X-Change-ID: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784450523; l=16373;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=JCvCSovmVL4IvX5jztghunfFr17h/VyJdQ3/UmZxUzs=;
 b=fLokQqtfhmS2TPNCORf8R4BDLdJ4/FZ7YjNDzJBn1ZBAnrrXvBII3yshdqBrlMq3Ht/TBTH8q
 Lqx+wZKeXMkBHNzZry0In0Mp1Bbhbi/6r6PoNQoqG2WUWjAL96YHSu8
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-08.cisco.com

This series adds the admin channel infrastructure and mailbox (MBOX)
protocol needed for V2 SR-IOV support in the enic driver.

The V2 SR-IOV design uses a direct PF-VF communication channel built on
dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.

Patch 1 is an independent fix for a pre-existing use-after-free in
enic_remove() (the tx_hang_reset work item was never cancelled on
removal).  It is unrelated to SR-IOV but lives in the same teardown
path the later patches touch, so it is carried at the head of the
series.

Firmware capability and admin channel infrastructure (patches 2-5):
  - Probe-time firmware feature check for V2 SR-IOV support
  - Admin channel open/close, RQ buffer management, CQ service
    with MSI-X interrupt and workqueue-based polling

MBOX protocol and VF enable (patches 6-11):
  - MBOX message types, core send/receive, PF and VF handlers
  - V2 SR-IOV enable wiring with admin channel setup
  - V2 VF probe with admin channel and PF registration

Patch 12 completes reset recovery for V2 VFs: the reset paths added
earlier in the series re-establish the admin channel only for the PF,
which left a VF unregistered and unable to exchange MBOX traffic after
a reset taken on the VF.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Changes in v12:
- Rebased on net-next.
- patch 2: reworded the commit message for accuracy (no code change) and
  added Reviewed-by: Breno Leitao.
- patch 5: return the actual admin CQ interrupt credit count instead of a
  forced minimum of one, and correct the accompanying comment; the MSI-X
  vector is re-armed by the unmask bit independently of the credit value,
  so there is no functional change.
- Link to v11: https://patch.msgid.link/20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com

Changes in v11:
- Set mbox_send_disabled at the start of enic_admin_channel_open() so an
  early error return cannot leave MBOX sends enabled against a half-open
  or freed admin_wq (patch 7)
- Document that enic_sriov_configure() is not yet wired (__maybe_unused)
  and that rtnl serialization vs the reset paths is added when it is
  wired in a follow-up (patch 10)
- Document the admin CQ poll-handler credit return: the pre-drain credit
  snapshot and the minimum one-credit unmask that re-arms the MSI-X
  vector; no functional change (patch 5)
- Improve the VF capability-check log so a PF rejection is not reported
  as "version too old" (patch 9)
- Clarify the enic_remove() teardown comment and note in the commit
  message that a V2 VF without admin WQ/RQ/CQ resources fails probe with
  -ENODEV (patch 11)
- Link to v10: https://patch.msgid.link/20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com

Changes in v10:
- Cancel tx_hang_reset work in enic_remove() to fix a pre-existing
  use-after-free when a TX timeout fires during device removal; carried
  as an independent fix at the head of the series (new patch 1)
  [Sashiko]
- Clarify in the patch 2 commit message that V2 VFs are only enabled via
  .sriov_configure, which rejects firmware without V2 support, so such
  firmware never exposes VFs (patch 2) [Sashiko]
- Track admin-channel up/down state and gate admin/MBOX operations on
  it, fixing a NULL pointer dereference when close() runs after a failed
  open() and when a reset fails to reopen the channel (patch 3)
  [Sashiko]
- Bound the admin message list with ENIC_ADMIN_MSG_MAX (256) to prevent
  a malicious VF from exhausting PF memory (patch 5) [Sashiko]
- Name the admin MSI-X interrupt with pci_name() instead of the
  not-yet-registered netdev name so it no longer appears as
  "eth%d-admin" in /proc/interrupts (patch 5) [Sashiko]
- Document the in-order admin CQ/RQ completion guarantee in a comment
  (patch 5) [Sashiko]
- On a VF, validate that admin MBOX messages are sourced from the PF
  before acting on them, rejecting spoofed link-state messages (patch 9)
  [Sashiko]
- Move the link_notify_work initialisation ahead of the VF setup block
  so a VF probe error path cannot cancel_work_sync() an uninitialised
  work item (patch 11) [Sashiko]
- Cancel link_notify_work in enic_remove() after unregister_netdev() to
  close the narrow window where enic_link_check() could schedule it just
  as SR-IOV was disabled, leaving the work to outlive vf_state (patch 11)
  [Sashiko]
- Re-establish the V2 VF admin channel and re-run PF registration after
  a driver-initiated device reset (the soft reset from a WQ/RQ error and
  the tx-hang reset from a TX timeout); previously only the PF recovered,
  so a reset taken on a VF left it unable to exchange MBOX traffic
  (new patch 12) [Sashiko]

Testing:
- Exercised on a Cisco VIC with multiple V2 VFs under a KASAN + lockdep
  + DMA-API-debug kernel.  VF resets (soft and tx-hang) and PF reset,
  including a 10x reset stress loop, re-established the admin channel and
  re-registered the VFs with no use-after-free, lockdep, or DMA-API
  warnings.  MBOX control-plane operations (VF MAC/VLAN/spoofchk/trust/
  MTU) were verified to survive resets.

- Link to v9: https://patch.msgid.link/20260617-enic-sriov-v2-admin-channel-v2-v9-0-37f5f5af4c93@cisco.com

Changes in v9:
- Use dma_rmb() instead of rmb() when reading admin RQ completion
  descriptors written by DMA (patch 4) [Sashiko]
- Use GFP_KERNEL instead of GFP_ATOMIC for admin RQ refill and for
  received-message allocation; both run in workqueue (process)
  context after the v8 NAPI-to-workqueue switch (patch 4) [Sashiko]
- Correct the enic_admin_msg comment to describe the workqueue
  enqueue path rather than NAPI (patch 4) [Sashiko]
- Set mbox_send_disabled in enic_admin_channel_close() so a MBOX
  send cannot race with channel teardown (patch 6) [Sashiko]
- Send the actual PF carrier state to a VF on registration instead
  of unconditionally reporting link up (patch 7) [Sashiko]
- Call reinit_completion() before setting mbox_expected_reply so a
  reply arriving between the two is not missed (patch 8) [Sashiko]
- Defer PF->VF link state notification to a workqueue and gate it on
  carrier transitions; enic_link_check() runs in the notify (atomic)
  context while the MBOX send sleeps on a mutex/completion (patch 9)
  [Sashiko]
- Clear ENIC_SRIOV_ENABLED and cancel the link-notify work before
  freeing per-VF state in the SR-IOV disable path, closing a
  use-after-free window against a concurrent link notification
  (patch 9) [Sashiko]
- Link to v8: https://patch.msgid.link/20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com

Changes in v8:
- Replace NAPI polling with workqueue for admin CQ service — admin
  channel is low-frequency control traffic, not data path (patch 4)
  [Jakub Kicinski]
- Use explicit enum value (= 4) for VIC_FEATURE_SRIOV instead of
  placeholder VIC_FEATURE_PTP entry (patch 1) [Breno Leitao]
- Remove unnecessary rmb() in WQ CQ service (patch 4) [Jakub Kicinski]
- Remove admin_msg_drop_cnt counter (patch 4) [Simon Horman]
- Drop NAPI reschedule on RQ refill failure — the NAPI-to-workqueue
  switch removes the livelock and budget issues (patch 4) [Simon Horman]
- Remove unnecessary READ_ONCE/WRITE_ONCE on admin_rq_handler — all
  access is serialized by probe/remove (patch 6) [Jakub Kicinski]
- Fix checkpatch line-length warnings (patches 3, 5, 6)
- Rate-limit link state send failure and ACK error warnings (patch 7)
  [Jakub Kicinski]
- Correct enic_link_check comment to describe actual PF link state
  notification flow (patch 7) [Simon Horman]
- Correct mbox_expected_reply comment — serialization is by
  RTNL/probe, not mbox_lock (patch 8) [Jakub Kicinski]
- Wire enic_mbox_send_link_state() from enic_link_check() so PF
  notifies VFs on carrier change (patch 9) [Simon Horman]
- Fix commit message wording about MSI-X reservation (patch 10)
  [Simon Horman]
- Link to v7: https://patch.msgid.link/20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com

Changes in v7:
- Replace magic numbers in admin channel init with named macros
  and inline comments for MBOX descriptor encoding
  (patches 2, 6) [Paolo Abeni]
- Add defense-in-depth bounds check on admin RQ bytes_written (patch 4)
- Force NAPI reschedule on admin RQ refill failure (patch 4)
- Always unmask admin interrupt even with zero credits (patch 4)
- Reorder NAPI init before request_irq in admin channel open (patch 4)
- Remove redundant netdev_warn on admin msg enqueue kmalloc failure
  (patch 4) [Paolo Abeni]
- Add netdev_warn on admin WQ/RQ disable failure in close path
  (patch 2)
- Remove incorrect RES_TYPE_SRIOV_INTR interrupt allocation from
  admin channel open (patch 2); interrupt setup handled entirely
  in patch 4 using RES_TYPE_INTR_CTRL
- Rate-limit VF register/unregister log messages (patch 7) [Paolo Abeni]
- Add __aligned(8) to admin message data[] for strict-alignment
  safety (patch 4)
- Rate-limit MBOX handler error warnings (patch 7)
- Pre-allocate port profile array before pci_disable_sriov in V1
  disable path to avoid half-torn-down state on alloc failure (patch 9)
- Account for admin channel interrupt reservation in
  enic_set_intr_mode() and enic_adjust_resources() (patch 9) [Paolo Abeni]
- Clear admin_rq_handler in enic_admin_channel_close (patch 9)
- Quiesce admin channel (mask interrupt, disable NAPI, block MBOX
  sends) around soft reset (patch 9)
- Use WRITE_ONCE/READ_ONCE for mbox_send_disabled and
  admin_rq_handler across data-path/reset boundaries
  (patches 4, 6, 9)
- Fix commit message: reference enic_adjust_resources() alongside
  enic_set_intr_mode() (patch 10)
Investigated findings from automated review (Simon Horman / Sashiko):
- Race between probe-time feature check and VF proxy: false positive;
  detection runs at probe, enable runs from sriov_configure
- Struct alignment of __le32 after 2-byte mbox_hdr_embed: compiler
  inserts correct padding, no manual alignment needed
- Stale MBOX reply matching / reinit_completion race: single-flight
  design with mutex serialization prevents this
- cancel_work_sync vs MBOX unregister race: work cannot be
  re-triggered during the close window
- Link to v6: https://patch.msgid.link/20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com

Changes in v6:
- Add explanatory comments documenting admin_cq[0] (WQ CQE size) and
  admin_cq[1] (RQ CQE size matching firmware enic_ext_cq() programming)
  allocations (patch 2)
- Enforce bytes_written from CQ descriptor when enqueuing admin RQ
  message; previously buf->len (allocation size) was passed, exposing
  uninitialized buffer memory beyond the real payload (patch 4)
- Drop admin RQ messages with TRUNCATED set or FCS_OK clear, gated by
  netdev_warn_once() (patch 4)
- Disable interrupt_enable on admin_cq[0]: WQ completions are polled
  synchronously inside enic_mbox_send_msg() and never raise an
  interrupt; matches admin_cq[1] (RQ) which does NAPI polling (patch 4)
- Add mbox_expected_reply gating in VF reply handlers (capability,
  register, unregister): drop replies whose type does not match the
  current waiter's expected type, avoiding spurious wakeup of an
  unrelated waiter from a stale reply that arrives after timeout
  (patch 8)
- Distinguish error returns in enic_mbox_vf_unregister(): -ETIMEDOUT
  (no reply received), -EACCES (PF rejected the unregister), 0 on
  success.  Previously all paths collapsed to a single -ETIMEDOUT
  (patch 8)
- Reserve one extra MSI-X slot in enic_set_intr_mode() when
  has_admin_channel is set so enic_admin_setup_intr() always has room
  to allocate at intr_count without exceeding intr_avail bounds when
  data queue count is maxed out (patch 10)
- Clarify in commit messages that .sriov_configure is intentionally
  not yet wired in this series and will be added in a follow-up after
  the necessary devcmd hardening lands (patch 9)
- Link to v5: https://patch.msgid.link/20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com

Changes in v5:
- Fix DMA-into-freed-memory race: call enic_admin_qp_type_set() before
  disabling RQ/WQ in both error and close paths (patch 3)
- Fix DMA mapping leak: enic_admin_wq_buf_clean() now unmaps and frees
  WQ buffers still held at close time after a send timeout (patch 3)
- Log rate-limited warning on admin RQ refill failure (patch 4)
- Add missing linux/types.h and linux/bits.h includes to enic_mbox.h
  (patch 5)
- Guard mbox_lock/mbox_comp init with mbox_initialized flag to prevent
  re-initialization on sriov_configure re-entry (patch 7)
- Clear VF registered state before sending unregister reply so PF does
  not treat a dead VF as still registered (patch 8)
- Gate VF-facing log messages with net_ratelimit() to prevent malicious
  VF from flooding PF dmesg (patch 8)
- Reject VF port profile requests when V2 SR-IOV is active since
  enic->pp is not reallocated for V2 VFs (patch 9)
- Move enic_sriov_detect_vf_type() before auto-enable check; skip
  probe-time auto-enable for V2 VFs (patch 9)
- Move admin channel close and VF unregister before unregister_netdev()
  in enic_remove() to prevent use-after-free on netdev (patch 10)
- Add comment in enic_reset() documenting that admin channel is not
  recovered after soft reset (patch 10)
- Bypass RES_TYPE_SRIOV_INTR check for V2 VFs in admin channel
  capability detection (patch 10)
- Link to v4: https://patch.msgid.link/20260411-enic-sriov-v2-admin-channel-v2-v4-0-f052326c2a57@cisco.com

Changes in v4:
- Fix reverse xmas tree variable ordering (patches 1, 6)
- Use kzalloc_obj instead of kzalloc with sizeof (patch 9)
- Add NULL check for pp allocation in V1 SR-IOV disable path (patch 9)
- Link to v3: https://lore.kernel.org/r/20260408-enic-sriov-v2-admin-channel-v2-v3-0-1d4999a03cec@cisco.com

Changes in v3:
- Use early-return pattern in enic_sriov_detect_vf_type to reduce
  nesting (patch 1) [Breno Leitao]
- Link to v2: https://lore.kernel.org/r/20260408-enic-sriov-v2-admin-channel-v2-v2-0-d05dd3623fd3@cisco.com

Changes in v2:
- Fix lines exceeding 80 columns (patches 4, 6, 7, 8)
- Add __maybe_unused to enic_sriov_configure and enic_sriov_v2_enable;
  .sriov_configure wiring deferred to a later series after devcmd
  hardening is in place (patch 9)
- Guard probe-time auto-enable to skip V2 VFs (patch 9)
- Link to v1: https://lore.kernel.org/r/20260406-enic-sriov-v2-admin-channel-v2-v1-0-82cc47636a78@cisco.com

---
Satish Kharat (12):
      enic: cancel tx_hang_reset work on device removal
      enic: verify firmware supports V2 SR-IOV at probe time
      enic: add admin channel open and close for SR-IOV
      enic: add admin RQ buffer management
      enic: add admin CQ service with MSI-X interrupt and workqueue polling
      enic: define MBOX message types and header structures
      enic: add MBOX core send and receive for admin channel
      enic: add MBOX PF handlers for VF register and capability
      enic: add MBOX VF handlers for capability, register and link state
      enic: wire V2 SR-IOV enable with admin channel and MBOX
      enic: add V2 VF probe with admin channel and PF registration
      enic: re-establish V2 VF admin channel and PF registration after reset

 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic.h        |  40 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 645 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  27 ++
 drivers/net/ethernet/cisco/enic/enic_main.c   | 394 +++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   | 640 +++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h   |  95 ++++
 drivers/net/ethernet/cisco/enic/enic_pp.c     |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c    |   4 +-
 drivers/net/ethernet/cisco/enic/vnic_cq.h     |   9 +
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  13 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h   |   4 +-
 12 files changed, 1859 insertions(+), 20 deletions(-)
---
base-commit: ce6b4d3216b63f902bb8e9695ee6c10c83415f65
change-id: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833

Best regards,
--  
Satish Kharat <satishkh@cisco.com>

