Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC747126E;
	Fri, 11 Sep 2026 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125943; cv=none; b=FgOCkGbM/qZ+P/G6sK+6SRA+P0sd57kkzSAiIVnC3/gELEA5+HeCv48BtaXMX+UmK/+girPrNRzfTT1D/Nvzi5yHLCBQIu443Ex+nYRl0VxDfFeWu0fMCGgShtymdyATbVcc2wujfiJloPl5lXi4ZE6E99MhUlAj52WDYHf+npQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125943; c=relaxed/simple;
	bh=Rwy0sas9de9i6ogM+sx251G06BSLrY+dpn9PAlD4xRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spJkK4vD7cs6w8MDQtoQSUnkqhx0Gl43UBscjK53jSIaIOrTR9mXeQ8Wg3ItcNx8VrGum8zISrJwwaIAsafQLfIn9F5VNChonNtYpIJSzys7XZzetWzlTA6n+b3EDcJpTGZkvVtaxerD7AOxdusAmpU5EsKueJe1QUc9YebACvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz16t1789125862tc5dd637e
X-QQ-Originating-IP: Ous/dVGm7m+QzRdoJW/NjkwQcc3nPFuP+W4m7SCRITE=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Sep 2026 19:24:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13768595504651496234
EX-QQ-RecipientCnt: 11
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v11 0/5] net: rnpgbe: Add TX/RX and link status support
Date: Fri, 11 Sep 2026 19:24:16 +0800
Message-ID: <745DADAC2A5786BD+20260911112416.2142101-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OQx6vEqF0rNegaJMvFZ38mWBNKi7cQa5f03cAzqA56C00A+sdxKa7RR7
	zeoHPp+2AcSwqWKefaSSk6uCRYWeApo247Izq/8P8pEur4sHOK69uy5J7eP0O+4JnsiCVf/
	O4Il11AWbOQvfvgEsNVFGjNPE4/6UPMwLtbf/wyZrK+RLBLNiMqF6kXmTjYjK4EK2u+x/XV
	to40MM8uLohBDHrRHQgxqGYPYM2S99vW7/j170HMmE3IR6NGwf3dQVPnaMBUIeS9onJqeKQ
	W/2qo0yKZBhwPS0cIqI+Ovfex2L7cmlB/6WhJsCQnRk6OaKhYcQp/7/lMmfGojZnm0UQWoT
	B/QmC9w4p4Esc0NpXe42gTa7F5XxFmbzsAfAak5eSlpWd0YZUe8hF0SPRsf5OhlgcITK63B
	tfjVHCrcGyafvJFaiqaShfr5tFTNCOskkUtbYa2Zy6Ar0FMHVozSf0rEBh8ZcJV/ext0RGy
	k6ykNDcFm6tNXSaPjLZgEYf0CvLxOtE+Q93KZq6ID+HCFvBDCAVwZOEMrv24EUcQy/tlddY
	71riIR7ELwV8kWHW4ABMy3CxCeyo5iPvr+5iPEkqjT96xmw2qQQnYQpvEMWr+D5pbfmjLn3
	RF+4fZjtOaq8IrkyTnpUJeohlN7JKZ4PhooZ3zkzNAJb0/ZCg4X+FucZyLIDrhuEDj4jvtA
	ZphrZCfGY0cXKgGAogb2no5rGwHERLLOSLDFP9YKzd2LV2EusX6s3q9ECXWUJSdFpOwg4d1
	6A2ZnLUa3HyEtKM/BAo1I1CwgMHN3hCjkD6eBfJAahbgiclGkw3ggn//PoyxYrnNH7DEHAg
	BOkbSSsykaNm7fVOZQyeX1PMDbLPa74rsuAgk4BUY7k5v+uOhFjJiy3KAFEKS31WwsmPs61
	rFBho+8xTkAHDgPxZ2ncEujJC3ulMRY31pxygNrNz42DMYsFSjLR9s+cT7uTkiY1CqiyAMf
	kxCIno8xYy933eeBw62VoFsdpovJx6EJvC0Lpws+kF00XJ4Dek52tdQatTrmcGjD3TPp7rj
	bxq41maJwVbUY0jJmqp71s3Tp0O/TdT8AwXsYZAcgsd9SDoIf+osKIthbYZV9w4PBCQ5th1
	nbX0fYEHJ5Fn3b0IOXTZAIis6tT8OrMGw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series adds the packet transmission, reception, and link status
management features to the RNPGBE driver, building upon the previously
introduced mailbox communication and basic driver infrastructure.

The series introduces:
- MSI-X interrupt handling with NAPI support
- TX path with scatter-gather DMA and completion handling
- RX path with page pool buffer management
- unicast/multicast filter.
- Firmware link-event processing and carrier management

These changes enable the RNPGBE driver to support basic TX/RX
network operations.

---
Changelog:
v10 -> v11:
[patch 1/5]:
1. Drop MSI and single-vector MSI-X support. Require at least two MSI-X
   vectors, reserving vector 0 for mailbox events and using the remaining
   vectors for the data path. (Jakub Kicinski)
2. Prevent NAPI from re-enabling queue interrupts after the device is down.
3. Set the real Tx/Rx queue counts before registering the netdev.
4. Preserve the configured Tx/Rx queue counts when tearing down q_vectors.
[patch 2/5]:
1. Treat a Tx DMA timeout as a terminal AXI fault for the current driver
   instance, and document why Tx cleanup ignores the repeated idle-wait error
   after the fault is recorded.
2. Free q_vectors after an RCU grace period, matching the RCU-protected
   statistics collection path.
[patch 3/5]:
1. Arm Rx allocation retry timers only after NAPI has been enabled.
2. Mask queue interrupts again after disabling NAPI and calling
   synchronize_net(), preventing a completed poll from re-enabling them
   during device shutdown.
3. Clarify the hardware guarantee for the first RX descriptor length.
[patch 4/5]:
1. Advertise unicast address filtering support to the networking core.
2. Program receive filters under the netdev address lock before enabling Rx,
   and clarify the hardware multicast hash calculation.
3. Clear the RAR valid bit before changing an address, and set it only after
   the complete new address has been written.
[patch 5/5]:
1. Quiesce Tx DMA before notifying firmware that the port is down.
2. Remove the stale mailbox-event boolean return value and document why a
   failed mailbox read is not retried as transient lock contention.
3. Document the firmware link-event retry rate and mailbox ACK protocol.

Links:
v1:  https://lore.kernel.org/netdev/20260325091204.94015-1-dong100@mucse.com/
v2:  https://lore.kernel.org/netdev/20260403025713.527841-1-dong100@mucse.com/
v3:  https://lore.kernel.org/netdev/20260507081539.171844-1-dong100@mucse.com/
v4:  https://lore.kernel.org/netdev/20260526033539.164061-1-dong100@mucse.com/
v5:  https://lore.kernel.org/netdev/20260528023150.239532-1-dong100@mucse.com/
v6:  https://lore.kernel.org/netdev/20260604112750.769215-1-dong100@mucse.com/
v7:  https://lore.kernel.org/netdev/20260611100036.36370-1-dong100@mucse.com/
v8:  https://lore.kernel.org/netdev/20260731120322.895955-1-dong100@mucse.com/
v9:  https://lore.kernel.org/netdev/20260814111317.1741087-1-dong100@mucse.com/
v10: https://lore.kernel.org/netdev/F44E6669E6C9E7C4+20260831073608.401988-2-dong100@mucse.com/

---

Dong Yibo (5):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add RX packet reception support
  net: rnpgbe: Add receive mode support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    1 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  201 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  118 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   43 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2248 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   84 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  158 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   32 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  235 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   43 +
 12 files changed, 3138 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.50.1

