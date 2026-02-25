Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30C43D333F;
	Wed, 25 Feb 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029472; cv=none; b=Z8o8AS6X0RyPXtApUtmZNzmzr7VRBZXgtMHZsl46SR3SlqyRH7yvmqb0acD1OPFWQufK3/T1iMnw1/eOSJPC5eb3FvKek8mFRNfm0wt2O6QNAG8I/LxMb3zlq2olmIi5HT8gt+9YrJ4ZM1rE+nHpRLh0ZjVse2Zym+w5jIX1YlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029472; c=relaxed/simple;
	bh=VMijrzf89uXX6Ubc9sFcEL1P+V4NwL+Dgc1irFQHpM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aa444PcmwLhT0WOMsX1g6vn52scmkjRtbCxe/dasbQMoG2+8hQ6nmvGjRUQ/yEwvqDV/Du8nrcQ2WARkOnkBeYDLYSNLUXALeuiLfZKIUutHRDQMD9UYNlhwgB0oqkvBV5xaKCCkadDGjPeWbOTnC8NXDJP+Dokkq60rgHfXZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: +8TAYdAwTPaelwMGJZmlZg==
X-CSE-MsgGUID: KjOJs05XQfSIFJwTP+XVRQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Feb 2026 23:24:21 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9D30F4017D8D;
	Wed, 25 Feb 2026 23:24:15 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux@armlinux.org.uk,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	boon.khai.ng@altera.com,
	rohan.g.thomas@altera.com,
	vladimir.oltean@nxp.com,
	hayashi.kunihiko@socionext.com,
	boon.leong.ong@intel.com,
	kim.tatt.chuah@intel.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/5] net: stmmac: Fix VLAN handling when interface is down
Date: Wed, 25 Feb 2026 14:24:09 +0000
Message-ID: <20260225142414.130144-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VLAN register accesses on the MAC side require the PHY RX clock to be
active. When the network interface is down, the PHY is suspended and
the RX clock is unavailable, causing VLAN operations to fail with
timeouts.

The VLAN core automatically removes VID 0 after the interface goes down
and re-adds it when it comes back up, so these timeouts happen during
normal interface down/up:

    # ip link set end1 down
    renesas-gbeth 15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    renesas-gbeth 15c40000.ethernet end1: failed to kill vid 0081/0

Adding VLANs while the interface is down also fails:

    # ip link add link end1 name end1.10 type vlan id 10
    renesas-gbeth 15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    RTNETLINK answers: Device or resource busy

Patches 4-5 address this by deferring hardware writes when the
interface is down and reconfiguring the VLAN state on interface up.

Patches 1-3 fix some issues in the existing VLAN implementation.

v2 changes:
- Added a new commit that fixes VLAN restore on the resume and open paths.

v1: https://lore.kernel.org/all/20260223124102.120432-1-ovidiu.panait.rb@renesas.com/


Ovidiu Panait (5):
  net: stmmac: Fix error handling in VLAN add and delete paths
  net: stmmac: Improve double VLAN handling
  net: stmmac: Fix VLAN HW state restore
  net: stmmac: Add write_hw parameter to VLAN filter operations
  net: stmmac: Defer VLAN HW configuration when interface is down

 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 69 ++++++++++++++++---
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 61 ++++++++--------
 4 files changed, 95 insertions(+), 42 deletions(-)

-- 
2.51.0

