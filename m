Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256791;
	b=k58fJ2Hw1yXTZiRunRpkwSvtpO4uYB9w1PE/JyhMHe3a9pHRhm2U48C6Qjw+oEtRNGGt
	 yjVSFwroPGmjcncUAzuibv7OusiX6BDNW+J+evifJ/mN3o53tqJt1Nwm+CJuXhFDsK2Jf
	 eVm/IKPyMXWAh8pV4IaQGYdF+S9tQdtl29KIDvTpi6X0+DGzz0DTIEWFe88dY3hWdqh2k
	 3WNOF+sFTSlzBPBgPbcst+KQvymCqmNA0oRn2S499W9LsjrfN2H+t1IrQJseBqNch5ZON
	 20jWgbpqn2yGVEYm1HuFotjI51NxZRSiRalofBFWaw1gUtXuGCAZlloXmwtKMk5CJ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256791;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Outbound-Client-TLS:
	 X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=O1s/RJK5r8bW10+kgBlMSsV6k34dohCjQ9xhIgUk3Bk=;
	b=SzSnt4BudrLkdORfRNivJTJ9c+DrhlejzXIV2sYBvRnthWHA/ihwkP6MBmIZ6co/+2rv
	 cYSVQOuvlambbK22qEhk6Vswr9h0XOejYI/DhUiIa6KzUcgmXQCP4WEKSwtsYFKjYI4WS
	 5VtQ0qeA4LrtBCxAA24djVMtxj/cuMmxPUTIuHtS1239MS02Smk2fl1KWJ5YhQzu8HUWa
	 IICWjwGj/PbBpHdVm79rrPF/A9XGe0Peg+D4xY0wF97nwYrwFuIfakITlHGqqntyXx4xK
	 8SJshYOzjeSur5TdCDiPEPY9krsFv4c/Jlp08dssUvw4Poa2zSzc4rdUXpSAL+sMqKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=lQ3iCki7;
	arc=none smtp.remote-ip=173.37.86.72
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A1606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 823A1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=lQ3iCki7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10688; q=dns/txt;
  s=iport01; t=1794256790; x=1795466390;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=O1s/RJK5r8bW10+kgBlMSsV6k34dohCjQ9xhIgUk3Bk=;
  b=lQ3iCki79KlP3HDWtmROOsmIH8CWdgV2FdPR8L5sGHtCtY0Vhwqkw+en
   e94ZjjYdX1Ex6y+PMPp2d28OY74/UPtZEbpznXnlKSYifH7SF7A55lcIR
   RxNNLw04OjL0bxEXtNrhDQ+9/CrAs5ZK1M+y3yK/w0BdMYkxwAPcGbXLM
   z1KMmGbD3ss6PhzxHLPo3Pc00qkBiB+a0eTtSPndIYMWsgM6/P6lZq1V1
   Thv/zZhwBNsUoMjIumrFVmmi4VVoU9QB67XkyFjXhm+Nn8/7VTxOMIAuh
   TAlCESFUST8GHuYhfR/6bQlDOh5Vsc42yoCVZwjyZG8y+j4Pvzt4RMNyf
   w==;
X-CSE-ConnectionGUID: v/oD9QwvQ1+kYXDcfBkWUw==
X-CSE-MsgGUID: Yr0MPlMuQlCS+GnYdwS5ow==
X-IPAS-Result: =?us-ascii?q?A0ADAABeLvJq/4v/Ja1QAQkZAQEBAQICAQEBAQEBAQEBF?=
 =?us-ascii?q?AEBAQEBAQEBAQFNgTAEAQEBAQwBg0tgQ0mEV4gbhziCIYEWkDmMVRSBag8BA?=
 =?us-ascii?q?QEPSgcEAQGFBVEVjTkCJjQJDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4Thk8NkBUnVjUCJgJIKYMCAYJ0AxEFAbpjeoEygQGEftlLgW4GFYEKL?=
 =?us-ascii?q?gGFc4JuAYFxhAiEfScbgUlEgRQBgilKdoQWAQgLg3WCagSBDn8VgQyCWIVCh?=
 =?us-ascii?q?ByBN4liCT+BAhwDWSwBVRMNCgsHBWOBBQM1EioVbjIdgSM+Fy9YGwYFgR2BB?=
 =?us-ascii?q?wQTgRKBB12BKyhdASGBCIF2AoJRggACAUlBDgdFUwklQxJHJCIIEgkBExosC?=
 =?us-ascii?q?oEaNTwJJj8VDGQIAxoFQAIfCAINDHQ5EDAeJC8FHCY+GwpLGA1IESw3FRkEP?=
 =?us-ascii?q?QFuB5JPgiABLUMBAQYHCBcjCAEBCRIGCQsHDBIGFzkrBw8HARsRIxUFAQICD?=
 =?us-ascii?q?AYZCxEpkmNDgzyMKIE2a4E1n1yEKoFoijyVVDOXaZMImQiOCoogiy0cDwyFN?=
 =?us-ascii?q?oFoPIFZMxoIGxWDIlMZD5V2yGwmMgI7AgcCBw4DC4ZGiyQPFweBTwEB?=
IronPort-Data: A9a23:G515xqiKyYrzwXsjJPNfmEkVX161QhEKZh0ujC45NGQN5FlHY01je
 htvWjiCOvaDMGP9LtF1PI7goBxU657TnNBnTgBlqipmHntjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FHwdOCn8ikkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeAULOZ82QsaDxNsvrS8E8HUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUGveFbUFhR6
 8VBazM8XjyIici1/4+kH7wEasQLdKEHPasFsX1miDWcBvE8TNWbGePB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWYQZ/5JEWxI9EglHkeiFZs1KWpYI84nPYy0p6172F3N/9J4DXGpsIxBzHz
 o7A11XjWjQiMPmC8D6uyTGDgN7DghimX51HQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVXBCipnOA+BkGVLJ4EPAw4SmOx7DS7gLfAXILJhZIbtA8udB1QzE22
 lKXt9f0Azopu739YWqU/LqSrBuoNCQVJHNEbigBJSMD7sXvrZ8bkB3CVJBgHbSzg9mzHiv/q
 w1mtwAkjLkVyMpO3KKh8BWf2XSnp4PCSUg+4QC/sn+Z0z6VrbWNP+SAgWU3J94ZRGpFZjFtZ
 EQ5pvU=
IronPort-HdrOrdr: A9a23:Ti9s3KwaoFmd8O5D03xmKrPwsr1zdoMgy1knxilNoNJuA6ilfq
 eV/MjztCWUtN9/Yh0dcLy7UpVoIkmzyXcK2+Ys1N6ZNWGMhILCFuxfBOXZsljdMhy73bMY6L
 xpeap/D9OYNykYse/KpCO4G9EvzJ2m3cmT9IXj5kYoYA10Z6Rn9gtjTiSWAiRNNXB7LKt8OZ
 aC6s9Avja6PU4WYMOyG2UfU4H41rv2ferdEHk7Li9izhWShjW177O/OR2Z0hACFw5r+94ZgB
 D4e8iT3NTYjxl9oSWsrFPu0w==
X-Talos-CUID: =?us-ascii?q?9a23=3AzGzeHWqO2KiTdeUSyzfOxq7mUd5idVGM9WjOGhb?=
 =?us-ascii?q?7CldZZLabY1yvxbwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A1OGFSA41M8ADsSt+3QGJnLGfxoxZ+fyLMEQojKw?=
 =?us-ascii?q?CkPLHGipBNyim0TOoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,204,1787011200"; 
   d="scan'208";a="545765227"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Nov 2026 20:39:49 +0000
Received: from [127.0.0.1] (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 917171800035B;
	Mon,  9 Nov 2026 20:39:48 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net v7 0/2] enic: retain admin DMA resources and identify
 V2 VFs
Date: Mon, 09 Nov 2026 12:39:33 -0800
Message-Id: <20261109-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v7-0-30ca6f467673@cisco.com>
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
X-B4-Tracking: v=1; b=H4sIAIUv8moC/53QzU7DMAwH8FeZciYodpKm5cR7IA75cLYgrUVNq
 YamvjteQVCNW29xZPv3l6+i0lioiqfDVYw0l1qGngv3cBDx5PsjyZK4FqiwAQVKBiOpL1Gms5d
 zlqVPdJE9TfJIPa+KMpexTnIG+TuSOh+ysaC0toIXv4+Uy2VFXwSPitfvz/oR3ihON+7Wdip1G
 sbPNdoMa/PPymZPCn5zFHTB2tx0baufY6lxeIzDeQ0w44ZA3EUgE20K0AXjHRi6J/SWcLsIzUT
 wqB0lB2jgnjB/BA/sIgwT3hGqDkEZ++9QdkvoXYRlAq2CBIiacr4nmi2x71ANE2BtakxuFVK3J
 ZZl+QJ7i1Lu+gIAAA==
X-Change-ID: 20261010-b4-enic-dma-vf-index-net-generic-first-v1-20261010-d9abf4510335
To: netdev@vger.kernel.org
Cc: Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794256788; l=10775;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=8D7gDoIhVxJwoxsYUW0v6xodvoGP385Wm+rZC/Deo9w=;
 b=5HO4c2KN7O5zvgpbhb7BT6LEjr2m1VyHQqXHJeWlyDzGuR0N2xqvA68nX5SWthgEU5zpGcm+I
 Pec/HPuMn7aA603rSMcS9sXTodK7/1pQgWMGucK60Z+itUj8QNGcQ2o
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-02.cisco.com

Fix premature freeing of admin-channel buffers and set the correct V2 VF
source ID in mailbox messages. This is v7 of the two-patch admin-only
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
method. Surprise removal can make the final queue state unreadable.
PCI disconnect state alone is not treated as DMA-completion proof, so
the control allocations and reservation are retained until reboot.
A PCI-device reference keeps the reservation name valid, but does
not preserve IOMMU attachment or establish that DMA stopped. No IRQ, work
or other CPU callback may enter retained objects after module unload. DMA
debugging can report pending allocations. Reboot is the supported recovery.

The second patch requires DEVCMD2 for SR-IOV V2 and obtains the VF source
index from CMD_SRIOV_STATS_GET. Firmware vf_index and mailbox src_vnic_id use
0xffff for the PF and zero-based values for VFs. Hardware CQ sender metadata
uses 0 for the PF and vf_index + 1 for a VF; receive handling converts it to
the mailbox identity. PF messages also use the deployed 0xffff source value
instead of the old zero-filled field. After QP enable, obtain and validate the
ID while receive interrupts remain masked. Publish send readiness before
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

- V7 changes only public text; its code is identical to V6. V6 passed build
  and static checks at both patch boundaries. Sparse reported the same
  existing diagnostics as the public base.
- The uninstrumented V6 candidate successfully bound, opened and closed
  a V2 VF.
- A test-only overlay accepted statistics version 2 and rejected version 0
  and 0xffff, which identifies the PF.
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
Changes in v7:
- Correct the identity description: vf_index and src_vnic_id use 0xffff for
  the PF and zero-based VF values, while CQ sender metadata uses 0 for the PF
  and vf_index + 1 for VFs.
- Document the intentional 0xffff PF mailbox source and the common DEVCMD2
  result-ordering barrier.
- Explain conservative retention after surprise removal rather than treating
  PCI disconnect state as DMA-completion proof.
- Link to v6: https://patch.msgid.link/20261107-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v6-0-155d64f802e9@cisco.com

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

To: netdev@vger.kernel.org
Cc: Sesidhar Baddela <sebaddel@cisco.com>
Cc: Aravind Dhanasekaran <aradhana@cisco.com>
Cc: Reese Faucette <rfaucett@cisco.com>
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

