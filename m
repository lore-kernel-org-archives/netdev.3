Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135DC1A0BD0
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837524; cv=none; b=s+eNDPVkTi+Kgm5Cw20jrqIcxIiTD93+RJYyIYGcnyuY4wVfsB1WBKZrDelgNbDKEnkKP6xssnuSu9Hfllftf+GOO9GcAKVwFBa9TYmd4vXGUpQ3OO5sBe+SucFVoSfAVHxkntMKo/Jar6QY+XIpYKDA1t4IQEDmWlj/feYIjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837524; c=relaxed/simple;
	bh=E08hAb9w67hwn9dt5/EMdwAY4rwJmZc1l/mcPcvqoaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JLQL4dU0FQhvqjNw9JPypVoO9wgsNoQ0rSDXzj2PGG1uzrsDw8QrJrOpYL61Cd+eNRbPEU4VUIp68FEt2o6HCLUM/QOXnUUuNxzwJuOnfnKrQEBXgHTxeIaNcIR1XjYJRWgLjdo6mEgYddBeuCTXl07N5Ghx4y42mnWKIWtqrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=VWYgjYj4; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="VWYgjYj4"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69123A3DBC;
	Mon, 23 Feb 2026 10:05:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771837520; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=5QHY0nbh+VkAoIweIpD2dL1a4IsJKdPqWvjA0BEgR5E=;
	b=VWYgjYj4g2UCcuqIhnSrqIK71sNIZroneC4nuEC+DzoVU0ZaZWMQpsPmQFlS2SoQG2KRr8
	zOmbBTQS2d3DWCm+rtevEctKOHJJLjTCDhtbfGJt8VAfomHQ1q6SKDi2FDspBGugbm2sks
	o68g9uzsf+x7IT3rto1e4YckX9KQ7MnVkqKCjsBQumP5yjSjGcItoB2VNpz7Xz2gShWGUw
	0bEZceuB8M2RIScU2r6aI9sNHxwBTbo6NqQewaR1OSaclDK+CW1lh76apOoaTzATqfLWEa
	0ELwnSm3xGpLLR/8cYZU4TxW2M6u3fPZUsSvkh5Qb4bDHTUvoHa6VQqYeti7VA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 0/5] net: cadence: macb: add IEEE 802.3az EEE support
Date: Mon, 23 Feb 2026 10:04:07 +0100
Message-Id: <20260223090412.44070-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add Energy Efficient Ethernet (IEEE 802.3az) support to the Cadence GEM
(macb) driver. The GEM MAC has hardware LPI registers but no built-in
idle timer, so the driver implements software-managed TX LPI using a
delayed_work timer, as recommended by Microchip's GMAC documentation.

The series is structured as follows:

  1. Register definitions: LPI counter offsets (0x270-0x27c), TXLPIEN
     bitfield (NCR bit 19), and a MACB_CAPS_EEE capability flag.

  2. LPI statistics: Expose the four hardware EEE counters (RX/TX LPI
     transitions and time) through ethtool -S, accumulated in software
     since they are clear-on-read.

  3. TX LPI engine: A delayed_work-based idle timer that enters LPI
     after 250ms of TX inactivity and wakes before transmit with a
     conservative 50us PHY wake delay. LPI entry is deferred 1 second
     after link-up per IEEE 802.3az.

  4. ethtool EEE ops: get_eee/set_eee delegating to phylink for PHY
     negotiation; the MAC-level TXLPIEN is controlled only from the
     phylink mac_link_up/mac_link_down callbacks.

  5. RP1 enablement: Set MACB_CAPS_EEE for the Raspberry Pi 5's RP1
     southbridge (Cadence GEM_GXL rev 0x00070109 + BCM54213PE PHY).

Tested on Raspberry Pi 5 with iperf3 throughput/latency benchmarks,
ethtool --show-eee / --set-eee, ethtool -S LPI counter verification,
and cable unplug/replug cycling.

Nicolai Buchwitz (5):
  net: cadence: macb: add EEE register definitions and capability flag
  net: cadence: macb: add EEE LPI statistics counters
  net: cadence: macb: implement EEE TX LPI support
  net: cadence: macb: add ethtool EEE support
  net: cadence: macb: enable EEE for Raspberry Pi RP1

 drivers/net/ethernet/cadence/macb.h      |  23 ++++
 drivers/net/ethernet/cadence/macb_main.c | 160 ++++++++++++++++++++++-
 2 files changed, 180 insertions(+), 3 deletions(-)

-- 
2.39.5

