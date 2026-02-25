Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFF38734A
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011004; cv=none; b=RK6EWHU0kXp7EXbqhAZnEp34aNgf4LJ2LYwe0A+PUaipnYsEyx+a/54UUOXiWFYM/x2TPL1t+fU16myEJEKy5yzyox3CM6TF9s/VzMoTW7jHzu5p24/4d/zD/G/CGUAwAGHwHMmNTNoBGadD5r/zPUlEpq4iWy3W2xdLateG1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011004; c=relaxed/simple;
	bh=OS3HIAiAl9cuFNPjezz+0nevLqZ4Z3L5TU/f99l7Y/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sPxQKj3IfgwRLnlblT7/YCXcD9rQhk2ligtSqv9SE8Mxd2hRkVgbAUiVdmNbQigotfgqcSAly+xtPrGRFhykkBE3d10vE51nFFfAMjSmPHrhqyqnhBWTINkg+bUzAV6xEzJnyWusNltrw91jc90Mzn3BIqw7VS4XHM7lAahmXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=x+Y07UUN; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="x+Y07UUN"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBC7DA3ECF;
	Wed, 25 Feb 2026 10:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772010996; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Zn+xXznsJbvbUfrQPzNJESFaWy1EgzaoNyj/zbd4pFQ=;
	b=x+Y07UUNN7ebXj7OW1qyu14TMMr17oD5XhGYohUDXEaMnq0jsf+55FqCDxhXH1ovrchOw0
	IHVO7vdW4NbuJSPDAoKAC9u25t+zesgoYIKW2Cw3LEk+1eZ06Ur4PLqwOXnSHhi6TLAWWy
	d8oXM0GjjOcamOKm2Q94I+/mgE32FRW2YEcwkZNPgkE7QnDkoLv0YgPiA/DR6gI9Hte5WB
	bAMwS/1XokXhBSpcelzNL8I75yv4LXQpuSUBZXWTxGKyrLhc2pumuADdlBsQkmbQ8+zK+Y
	hOzkvj+CS5NC4njZpILcSPoXDeRDAOj7bOeaVvRXb1KX9z0km9VuWQAJlw3/7A==
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
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v3 0/5] net: cadence: macb: add IEEE 802.3az EEE support
Date: Wed, 25 Feb 2026 10:15:53 +0100
Message-Id: <20260225091558.51157-1-nb@tipi-net.de>
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
(macb) driver using phylink's managed EEE framework. The GEM MAC has
hardware LPI registers but no built-in idle timer, so the driver
implements software-managed TX LPI using a delayed_work timer while
delegating EEE negotiation and ethtool state to phylink.

Changes from v2:
  - macb_tx_lpi_set() now returns bool indicating whether the register
    value actually changed, avoiding redundant writes.
  - Removed tx_lpi_enabled field from struct macb; LPI state is tracked
    entirely within the spinlock-protected register read/modify/write.
  - macb_tx_lpi_wake() uses the return value of macb_tx_lpi_set() to
    skip the cancel/udelay when TXLPIEN was already clear.
  All changes based on feedback from Russell King.

Changes from v1:
  - Rewrote to use phylink managed EEE (mac_enable_tx_lpi /
    mac_disable_tx_lpi callbacks) instead of the obsolete
    phy_init_eee() approach, as recommended by Russell King.
  - ethtool get_eee/set_eee are now pure phylink passthroughs.
  - Removed all manual EEE state tracking from mac_link_up/down;
    phylink handles the lifecycle.

The series is structured as follows:

  1. Register definitions: LPI counter offsets (0x270-0x27c), TXLPIEN
     bitfield (NCR bit 19), and MACB_CAPS_EEE capability flag.

  2. LPI statistics: Expose the four hardware EEE counters (RX/TX LPI
     transitions and time) through ethtool -S, accumulated in software
     since they are clear-on-read.

  3. TX LPI engine: phylink mac_enable_tx_lpi / mac_disable_tx_lpi
     callbacks with a delayed_work-based idle timer. LPI entry is
     deferred 1 second after link-up per IEEE 802.3az. Wake before
     transmit with a conservative 50us PHY wake delay.

  4. ethtool EEE ops: get_eee/set_eee delegating to phylink for PHY
     negotiation and timer management.

  5. RP1 enablement: Set MACB_CAPS_EEE for the Raspberry Pi 5's RP1
     southbridge (Cadence GEM_GXL rev 0x00070109 + BCM54213PE PHY).

Tested on Raspberry Pi 5 (1000BASE-T, BCM54213PE PHY, 250ms LPI timer):

  iperf3 throughput (no regression):
    TCP TX: 937.8 Mbit/s (EEE on) vs 937.0 Mbit/s (EEE off)
    TCP RX: 936.5 Mbit/s both

  Latency (ping RTT, small expected increase from LPI wake):
    1s interval:  0.273 ms (EEE on) vs 0.181 ms (EEE off)
    10ms interval: 0.206 ms (EEE on) vs 0.168 ms (EEE off)
    flood ping:   0.200 ms (EEE on) vs 0.156 ms (EEE off)

  LPI counters (ethtool -S, 1s-interval ping, EEE on):
    tx_lpi_transitions: 112
    tx_lpi_time: 15574651

  Zero packet loss across all tests. Also verified with
  ethtool --show-eee / --set-eee and cable unplug/replug cycling.

Nicolai Buchwitz (5):
  net: cadence: macb: add EEE register definitions and capability flag
  net: cadence: macb: add EEE LPI statistics counters
  net: cadence: macb: implement EEE TX LPI support
  net: cadence: macb: add ethtool EEE support
  net: cadence: macb: enable EEE for Raspberry Pi RP1

 drivers/net/ethernet/cadence/macb.h      |  20 ++++
 drivers/net/ethernet/cadence/macb_main.c | 136 ++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 1 deletion(-)

-- 
2.51.0

