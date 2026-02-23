Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65D5352C29;
	Mon, 23 Feb 2026 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850481; cv=none; b=XL+TYu+oaZ63zAWSlP9SO33RgwXTZOrC0ThG4AiSipkurUbSmlNu3dL3hLFqj79OmqnlqTOMaG0EXTTLKea5u70zwWpt6nkAHnvvHKh9o3c60fwEcK88cr8rKUaD/apCVonudvV43/xZPPfRd8rm2ChdDIrNzqjJ/B7o8qEqDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850481; c=relaxed/simple;
	bh=16uCU6SU/bjvJzXtjLjxIPDd5tGtDanI9LQUJEW7ng8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPF5H2dAkmaVr4CzFQoNTxpVlsEJfaSAElj4zj3eYh3tiNEJ++hlhz5SYfYI0xWqEqI7uk3dm8Riq5OBjSg5YuYWjCpLx7Nn4YJfkg8fTRBkKA5CjjuCaDJca5fwsCpuI17Sj+sTRvJ8Fyn/kHup2JLRecdjETSmefQ2smjGLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: QlRjXNpSRbe8nAs7y3YahQ==
X-CSE-MsgGUID: SQtk8V6rSKWQyLhCQ8cViw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Feb 2026 21:41:11 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.12])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3C08E41AB637;
	Mon, 23 Feb 2026 21:41:03 +0900 (JST)
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
	matthew.gerlach@altera.com,
	vee.khee.wong@intel.com,
	boon.leong.ong@intel.com,
	kim.tatt.chuah@intel.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: stmmac: Fix VLAN handling when interface is down
Date: Mon, 23 Feb 2026 12:40:58 +0000
Message-ID: <20260223124102.120432-1-ovidiu.panait.rb@renesas.com>
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

Patches 3-4 address this by deferring hardware writes when the
interface is down and reconfiguring the VLAN state on interface up.

Patches 1-2 fix some issues in the existing VLAN implementation.

Ovidiu Panait (4):
  net: stmmac: Fix error handling in VLAN add and delete paths
  net: stmmac: Improve double VLAN handling
  net: stmmac: Add write_hw parameter to VLAN filter operations
  net: stmmac: Defer VLAN HW configuration when interface is down

 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 62 ++++++++++++++++---
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 51 +++++++++------
 4 files changed, 90 insertions(+), 30 deletions(-)

-- 
2.34.1

