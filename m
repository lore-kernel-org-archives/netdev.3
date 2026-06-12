Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD4375F8E;
	Fri, 12 Jun 2026 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781298008; cv=none; b=OyVV+z2QWDgChqzwWDtnXwG0tYv20G0/8nMw3r/d8tvdsxcXMJGtw/m0MYiTH9Q4176x0M5gaGQd0lvFGacTek7XZKZFP5YfkDp70u8UIHs8bM8iOJIBQ3K63zTE1cueg61XnQaMs0eqlzrHWA6dW4SIDg1KiokXs1Lyqbu8/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781298008; c=relaxed/simple;
	bh=iE7R31d6Vw3xhwPeEcUffSLCObrWgpbGuK7GyGc13hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Omlv7e+V0P+W1EZO6VS2MxBiuVgzp5xtLhXsMnZN3l/E1TPbIxHPF2f6YlnwBuO8FYDypMgIUx2ASlGOC0H2D3UBZT2i0QdN8MoXN8+UA12G1sGBkR+oq5D7iqhGN1LGss1yazqRRvdN3dicmzUFJhiUmnqRWpC7BuX6gMpa5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=GgVpFRkK; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="GgVpFRkK"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4614A4D39;
	Fri, 12 Jun 2026 22:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781298001; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=8WwPMoEet8iC2sxpAvMEv7cqNr3RbumxxBq5EouUnGo=;
	b=GgVpFRkKrgOKdlWzp80bSWm0tqYdKUC6aH0++FDPDEbX367fwyHcONDgFbsBmDCFu0wF/4
	tij3ABjmOFCMZFLdRKCm9np6d37SboScjv5XFufRvXUqvrUZiwoxHLZ3DXV5Y9HrGq+cJ6
	vZaQ1CFK7yDgVusM3bk1VAu6UhEnlv1sWpm9P5ihr2BwYZ0K10hcmSh+CqtabYm9+Noo6A
	N1fbaoPdIlx6K3QHICyWLcqdcdXMiHePeSt5R+icYZ8ws+khMlEAuLXPw0lZ6XaJ5vMqa+
	9dtnhdHXs03iS8AkxoANEExA9qMn3gIk2NdReOwjZGPkG86a3ABXWYhqcSGenQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 0/3] net: bcmgenet: collapse TX priority queues
Date: Fri, 12 Jun 2026 22:59:12 +0200
Message-ID: <20260612205915.3156127-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The strict-priority TX queues can starve under multi-queue load and
trip NETDEV_WATCHDOG. Justin's earlier series [1] tried to mitigate
the timeouts but kept the multi-queue design. Ovidiu Panait recently
proposed a WRR stop-gap [2]. This series drops the priority queues
entirely. Justin confirmed they are no longer required.

Patch 1 collapses v2-v4 hw_params to the same single-queue path v1
already uses. Patch 2 removes the now-dead priority register writes,
helper macros, and the dead "flow period for ring != 0" branch in
bcmgenet_init_tx_ring(); the DMA_ARBITER_{RR,WRR,SP} and
DMA_RING_BUF_PRIORITY_* HW defines are kept as register
documentation. Patch 3 switches the netdev allocation from
alloc_etherdev_mqs(., 5, 5) to alloc_etherdev(), since only one
TX/RX queue is ever used.

Tested on Raspberry Pi CM4 (BCM2711):
  - Ovidiu's reproducer (iperf3 -u -b0 -P16 -t60) no longer trips
    NETDEV_WATCHDOG.
  - UDP sustains 956 Mbit/s line rate over 60 s with 0 datagrams
    lost (0/4952890).
  - Single-stream TCP throughput unchanged at 943 Mbit/s.

[1] https://lore.kernel.org/netdev/20260406175756.134567-1-justin.chen@broadcom.com/
[2] https://lore.kernel.org/netdev/20260610085238.56300-1-ovidiu.panait.rb@renesas.com/

Nicolai Buchwitz (3):
  net: bcmgenet: collapse TX priority queues to a single queue
  net: bcmgenet: remove dead priority queue plumbing
  net: bcmgenet: allocate a single-queue netdev

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 100 +++---------------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   2 -
 2 files changed, 16 insertions(+), 86 deletions(-)

-- 
2.53.0

