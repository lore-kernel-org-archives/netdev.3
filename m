Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700329;
	b=jnUrvCi0fAwbszAjLrwH6g8HwRlWMSUQwnC2Ym4dOrasFenrNu8SxyHgOVu4WtUtN4PM
	 MPRLx6AV0K6LtHAphCw4nIkhAQl3xHGuZxpycV9sjHK579dvdzAJA2W1W8+QtCi2zStp0
	 UbAVMsbtfoW95x1hsUXEW+GHuHqrs6VNhaEcBV1z81TLiFm4JXCdrlwmVsf2aS/keVSKa
	 ljNP0uJ4wgepjD+AVE0cprgvM7OdJywFnr+FbhEoZRWi6+ErgUWNC+pn0hWhqOcJCl3I9
	 uRsXKX0qnMvHlfd1J9xoqbOqabc5J02NtT4QEP7y2M2B5juweOPNEoFVcH5euuAWEEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700329;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=3kfM3mR2/9PMnJxa7HtUJSMymaoUCqKqMwpdhQvx6VE=;
	b=RTXXrE4wpKTIEvdIKm2U3mIvHvDi80IP4MJ/rxDu++vo8uhHwt7oq+AQkANxUF69kPA9
	 CZM48Y5Ny0/v25U8kgrhrGGg1eEuFL3oDW1ttPRUVZLh4h3YbVAfORRvZdEpLq82Kfg/1
	 JIF98cosR+aKqNwBFqajRiDsYCaDt/gZfi/5bOdG4Sw2CtYoEVqKz8jl5JZkpDlby+Jy/
	 EFrpXiK0kVW9yUeKN69XRJ4dDA7g3odKO7CdPfEh6t0DrO4VdggwjAu2wAOr/R5WYPO8x
	 e2bfT7ncx8t2Ftybid8tqdqdkWI3zdrqXa1eJyIKk3ANxOSOe8XQT4RLUP8ENorMp6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=MKyqOY0v;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8C606A801;
	Tue,  3 Nov 2026 10:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8A8C606A801
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=MKyqOY0v
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75416A1644;
	Tue, 03 Nov 2026 11:05:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793700324; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=3kfM3mR2/9PMnJxa7HtUJSMymaoUCqKqMwpdhQvx6VE=;
	b=MKyqOY0vL7/BwHCCmNig2SZD00ViNVruWagfpoQowWQRPauBn2NFFOUcMyUCDoP3oxDnTW
	9HraLlqZemAnHuWe2su9P6HYuVcce341s/p4g9stE84d0IRKyIKff4CVKhelgOv0U4Gu3S
	55x2FS0DxkakVmkCcU9rEttgPIjVezHwvn5J5/DUwbjSoALvai2/ZtDFQrXnPXfNuKgwfq
	4B2JxSlaggzfb0QXKsIwa+XeCh6l2J62eakh9wqEzdB3w+11LnL9H+zqZ5e/TRbNfmAPfX
	R3OEfngQOoiCqxpGroRalTa0071yEqABcf0SXIZUwecuOTuSrzwh17Deo39UoQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v6 0/9] net: bcmgenet: support larger MTUs
Date: Tue, 03 Nov 2026 11:04:54 +0100
Message-Id: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PwW7DIAwG4FepOI/KGHCWnfYeUw+BmJZDaZUw1
 KrKu4/lFLWoR8v2598PMfMUeRZfu4eYuMQ5XlIt6GMn/GlIR5ZxrLVAQFIAKJOTR06c5Tn/ypR
 kQWkAnWUKGiiIunidOMTbiv6I/9HEtywOtXOKc75M9/VaUWv/HVyUBNnT6Gm0xjvm7xyvsXJ5P
 /IKFtwi1ESwIt44RqWs6hW+InqLdE1EV6QzQ9eTB9X7RhKzQVT7HVMRZGTtwhA+vX9F7BbRTcR
 WBDpyFDwacE9JlmX5AzHc7lfUAQAA
X-Change-ID: 20261002-nb-genet-mtu-nn-v2-402b5e6f306f
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Justin Chen <justin.chen@broadcom.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

This is v6 of my genet series which adds larger MTU / jumbo packet support.

Larger MTU aka. jumbo frames are requested often by Raspberry Pi users, but
the hardware has its quirks with larger frames. Dave Stevenson's PoC [1] had
the receive side working, and thanks to Justin, who checked the RTL for what
the hardware does with long frames, I could add the missing puzzle pieces.

GENET never sets dev->max_mtu and the packet ready thresholds stay at their
2048 byte reset default, so long frames were dropped on receive and never
sent on transmit.

Patches 1 to 5 prepare the driver, patch 8 sets the MTU, as far as one
descriptor reaches (3564 bytes with 4K pages). Patch 9 reassembles what the
hardware hands up above that, which gets the ceiling to 16347 [2]. Patch 6
splits a frame ending just past the packet ready threshold, which otherwise
stops the transmitter [3]. Patch 7 builds the new rings before dropping the
old ones, so a failed MTU change leaves the interface alone.

Patch 8 needs bcmgenet_fini_dma() to clear rx_cbs and tx_cbs, which landed
in net as 1c1f51c3ee9c.

Tested on a Raspberry Pi CM4 (GENET v5), peer at the same MTU:
- MTU 1500: iperf3 TCP 941/941 Mbit/s, UDP 956 Mbit/s, unchanged
- MTU 9000: iperf3 TCP 990/989 Mbit/s, UDP 993 Mbit/s, no loss
- MTU 1500 to 16347 with traffic and ifdown/ifup's
- pktgen at line rate, 3858/3872/3886 byte frames mixed with 64 byte ones

Pierre-Marin Leclercq tested v5 on a Raspberry Pi 4.

[1] https://github.com/raspberrypi/linux/pull/7614
[2] https://github.com/raspberrypi/linux/pull/7617#issuecomment-5669564355
[3] https://github.com/raspberrypi/linux/pull/7617#issuecomment-5735557324

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Changes in v6:
- Patch 6 splits the frame instead of padding it (Jakub)
- New patch 7 builds the rings before freeing the running ones (Jakub)
- Patch 8 drops the rollback and the datapath_up flag (Jakub)
- Dropped Pierre-Marin's Tested-by on patches 6 and 8, both changed

v5: https://patch.msgid.link/20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de
v4: https://patch.msgid.link/20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de
v3: https://patch.msgid.link/20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de
v2: https://patch.msgid.link/20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de
v1: https://patch.msgid.link/20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de

To: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Nicolai Buchwitz (9):
      net: bcmgenet: ring the doorbell when the last frame of a batch is dropped
      net: bcmgenet: let the caller decide whether to start the PHY
      net: bcmgenet: allow a continuation descriptor without the alignment pad
      net: bcmgenet: rename ENET_MAX_MTU_SIZE to ENET_MAX_FRAME_LEN
      net: bcmgenet: derive the receive buffer length from the MTU
      net: bcmgenet: split frames that end just past the transmit threshold
      net: bcmgenet: build the DMA rings before giving up the running ones
      net: bcmgenet: allow the MTU to be changed
      net: bcmgenet: reassemble jumbo frames from status block fragments

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 727 +++++++++++++++++++------
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  34 +-
 2 files changed, 585 insertions(+), 176 deletions(-)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20261002-nb-genet-mtu-nn-v2-402b5e6f306f

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

