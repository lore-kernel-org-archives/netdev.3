Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B483209F43;
	Mon, 14 Sep 2026 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349508; cv=none; b=H+SNsPHLg+rp9VU/LtlWIg9Ryg21rMZ4WbvEpGpLTSRjgXlKar3dGzjNQ6DXpnqeDxkgUPNzBIvL0UtRKjWZ3jhjnnZ7v/fN08nIy1jsUe2A/yZsQmfhKHau7P2E3hWsqOrO//cu3TmQjdJBiMLz/fxhCUTxfuk2AHQMYEiilCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349508; c=relaxed/simple;
	bh=E0aep8HBXW8cl1fp89k4p7f6SKVYtvIUk8Flj86kDoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPYQRNhQgysxcnR1lADZ7urCV54+g7gp6Ul9/7+OW8Bt2qwLGIJsgIBMrPoGgSCcAESQnfPqdhP9pJMA3/B/IacZMXB9C9V8dz/vTOKGDl08NSKllgt3G26EAUZ6us1I/zShn7UaqyzCWYY2mzz9CTeDqSACm+quZUG6OWTGt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz10t1789349427t50064802
X-QQ-Originating-IP: pDXu7/7UhCvwxMkPZqC1VwGIxIFA1y0TKfCzmNh/u48=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Sep 2026 09:30:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13930663857834570154
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
Subject: [PATCH net-next v12 0/5] net: rnpgbe: Add TX/RX and link status support
Date: Mon, 14 Sep 2026 09:30:19 +0800
Message-ID: <64BE41C2D2C0836A+20260914013019.2262317-1-dong100@mucse.com>
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
X-QQ-XMAILINFO: ODrcV9y+CMiQB+wpSrAELauEjOo+Kcqya5lT77/gibKZzbwujTUSVHEY
	uYzUQH3rwFYgYYzLw6CwE/S86kqO+/yDtX38oF7qY+SgKnwKgYGo9Y/YE0AXedRkwA7rJ0p
	zB8WjudEVlbfXNbUDTu+ivQXfyD7hySme6/iqRHtQbJpCQV4aRbowRj44LDZXqMrvroeac3
	x5x1/TTIvFYEf5/gjdABhEc3+j3CO0k5eyv357fwG277X9TiFr4CEwx3Yfl36FGLqMSghMI
	BU54jTwc/fxeZzpksev6afUGybIyJ0t4GxJzTpDzfoomg88pKtI23YUKbyQWYVJl6ysT7Th
	0Ry50QReV8eqA32uYsxlx6B/ZnupdUJSPfiyTktk7GIJ2CINXTW5BjEaNTvL28etQEbTFmr
	MacGvh1cQDazDH2gcLUXgNHySvU4tJLTlx/o4V97z+QKEGeekdr0H1KxrDVgPvNzTPo7UBJ
	wg/RoQhkVpJsdnFZKEf9eyRqTLUtURQGm8ow0TRlP3FG8wQJkMp+zjmUB0su+GgmKo8MHJg
	i/7JjTSs1zV1EPTEyr/14cbxrjj8ClLHut31sEwsxp5mbm7vcWGmc7flSSr+vZ7fMs+DZZz
	+btDfZpwAkpu+CMBynANOyMGjUqAvfghLL94zGULuJ0MyjaMzLdy1DeQqp1zV2Co438zXad
	Bc6skd1KMqVpO+ZqYb+KDLl2c7S0Q2JhnFeTo84WbddsEnB8cvgHB6RSToIvd+/sbL6qfdF
	7lYCfdaPiOpGI00WW9kmFhtQJBFrdsI3w8xdYBGJas5QyuZTz1U4Y2Q2WxaK/M52rWRcyng
	C+QY5tegdwltpI71KCtGC2rp2F9RK5sS1U4uL3iWpWsrGC8lxsA+xIaloTQRuOfy1wQa/b+
	nPEKShD5BfaK2VqchjZ8/FoxRzw8pd563f4LqJJAfh6XWbfeKXt0hGS667NBEHU+aPNBOgF
	MGoc+ByQ8hSMMYS2nHy2NrivXFaHu5IlHr8uLITL6VfzHXu6E1Oe8SkpLd8DWYXihYPXqgV
	xOEzJ/L0xEng1IDmqJkzWMEsscgMnZx5iDqd7E8zPaDu1o9vpwVlGo3F7+UtE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
v11 -> v12:
1. resend with correct In-Reply-To thread.

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
v11: https://lore.kernel.org/netdev/745DADAC2A5786BD+20260911112416.2142101-1-dong100@mucse.com/

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

