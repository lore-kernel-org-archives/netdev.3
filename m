Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807BB4718CC;
	Tue, 13 Oct 2026 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858635; cv=none; b=R38gJOMeg2979A4HX6f/b019oNlbCuZUX1ERowjXrzxQ/Bgg0E636SiwJ+ZfAc84qvg6y12zQlqa27KD/rd5VguDGaNivs+3aXp8f+s0BImCQabH9GaeJYc4QyXOKEWRQBbNDEuDJRRNCLXd21J0zVoAw36f2f/Sg4qCBuLIcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858635; c=relaxed/simple;
	bh=F7C1XsH545+pKqOaXB+bpFZDtAsjpma3RaycYhUjIVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYCplhZxoBVPUdi20F2JpnSmxLc/JqDBZG/tFUjQS/CWdO4t9hjlyM7OTlDUjHOIeqJS1WUMRPi2niedjdAhyoXCHYh8NElw9CqZef1xYkIrNFEbqPFGEiAn+bSam+qmsCNc5PfXrtXHT2v/q+NBB+Yb58uyb52MRrBANX0bp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1791858566t295cd495
X-QQ-Originating-IP: +I+3SZ0DWAjMY+EasJbTMw1w5e2rNbP3VUjIaVkE1b8=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:29:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12166885009384017556
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
Subject: [PATCH net-next v16 0/5] net: rnpgbe: Add TX/RX and link status support
Date: Tue, 13 Oct 2026 10:29:20 +0800
Message-ID: <3B42BE25B3696EAE+20261013022920.63529-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NFnMFEz0lTbneC08rxBZoHBbL5jiyvkVdurzG5/ozAdpxNOv0IO/Yk42
	jRfexLgrP0Y+ITOgcrK0OTJYkWg6xFMcZqKnNuCni6HSwSfe2NgJp5PByn1w9UO+jS1bZCx
	Nhnw8gD/cRM7uodtTDvf9gcNtshqbRB0Cea9XLPdGroSQRTNwWy1EUZ279f2vNan8p+if/O
	OWjNIwmBrgKnwKOldJqMrGg+6+0bJhb7WP17v8zyD2ips+uYnnwSQF8NuGBhGvwuZNwUwS6
	3G9A/OsCdl23vsAcojh5S2QjX7rHn2E0uWVY6+KRJ6vR5Y3TJ45c14wHxcSl2WkO/0d3la3
	tbK8y86XMSBi8loQT79u0fAYhiXXGzF9rhYksqgh1Yf10bsjWQabXyGrJKPjDPV23+wdhHT
	AmcKJjP3OIK6RHBtwCEEIzXTWQrkBi1vYupILQzapxJUM8uwu5XIgT+VJxMaNuy9r3eHMcO
	1IpwoQz3wxz4bGs5TLPwSLHZivtVMaW0DopLMJSUhstpQaMkR8zuUt2G7AQg6hBMHd4S0xI
	bOL8PA+5j+ENFMjQFxMBuHdWhauZEEI5ZIE1KQ/OZGMX1YHi8OuHhDeOwF2es4zlecpHEXP
	fWelcozEJjQ/KML1MJLXnO8kJarR1j8oso0cRoLflRzmMLbyoJG/vhYRdl5y5Qbnra/TEr4
	Vn9sWTsOr30Weyzc3OxuOYQDHA8huR4BVMkxXV8rkzHquPkSUTeTy7NSAR/fD7S2nztHwWQ
	JUnwRe3AGlrXcmhCevZbiFWwcZ1IuIyzMQvmX5+ww+7/fJhE00WWQ6JbK29TZxxXUSpz+CP
	XZXkIN+8ddTMsvqh+X09rAto1JPmdMOcecbkCh8el11DDAM9wGYIGBBDFSKyqQC/tpILJtF
	W+M/7DKPtUA9Y8Q6ruj3x9JqY04kSVhpomlhg50chJK6jxXlHm6lHl40cfgX9ZvmlmRQyPc
	7eF77hAJ97qRiLD35wxLQ+3OgihEy69St0z+t4uRng2hIfb6O1QgVWeNIXC8iD9LayZAEe2
	XllS515Kw5mR28ljBpkw0LH7tRP/Yuqwjtc9ekVpDWNZJ/Lm0lqyRvUE1J4vLSOThINdiRD
	WCHMbvOkDOk
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series adds the packet transmission, reception, and link status
management features to the RNPGBE driver, building upon the previously
introduced mailbox communication and basic driver infrastructure.

The series introduces:
- MSI-X interrupt handling with NAPI support
- TX path with scatter-gather DMA and completion handling
- RX path with page pool buffer management
- Unicast/Multicast filter.
- Firmware link-event processing and carrier management

These changes enable the RNPGBE driver to support basic TX/RX
network operations.

---
Changelog:
v15 -> v16:
[patch 2/5]:
1. Clarify that carrier is enabled by the later link-status patch.
[patch 3/5]:
1. Track RX drop reasons across polls and account each packet once at
   EOP, giving length errors precedence over resource drops.
2. Check for pending RX refills before releasing NAPI ownership, and arm
   the retry timer after successful completion.

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
v12: https://lore.kernel.org/netdev/64BE41C2D2C0836A+20260914013019.2262317-1-dong100@mucse.com/
v13: https://lore.kernel.org/netdev/B8AF0FDE24FAFB51+20260920092424.345309-1-dong100@mucse.com/
v14: https://lore.kernel.org/netdev/0A4D45AD9F6A0F14+20260928033701.1033196-1-dong100@mucse.com/
v15: https://lore.kernel.org/netdev/B438B0A83ACCA2DE+20261004065604.224873-1-dong100@mucse.com/
---

Dong Yibo (5):
  net: rnpgbe: Add interrupt handling
  net: rnpgbe: Add basic TX packet transmission support
  net: rnpgbe: Add basic RX data path support
  net: rnpgbe: Add receive mode support
  net: rnpgbe: Add link status handling support

 drivers/net/ethernet/mucse/Kconfig            |    2 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  216 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  167 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   45 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2262 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |   88 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  208 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  179 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |    4 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  283 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |   60 +
 12 files changed, 3478 insertions(+), 39 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

-- 
2.50.1

