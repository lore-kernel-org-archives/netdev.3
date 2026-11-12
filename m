Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480328;
	b=17gLPA+Ssv/MAaJCuKBPKo/vz85WjL3GlXZ5d5sHBfxq4C+/DvBB9enaPcNrJ3eRmr74
	 0TQ9yQcbgJo5qhuxnzDOXYUD2zxNvgn7QYRyo83NQq1Ckn6qyQa0Xqw8t/pSVnEaj08OX
	 5pq8gH1Tq1DCbETZ1mgJVNZiGJ1IPjozmdQaqiRxEZO816qOL8F8L3coewH++30MWu1B6
	 ZtpMfkMHLKSxJUf3HA/ngz0VJld9XzfRVOsi1iQg7iEUHxQ7tQ/qc4wPzMyjc4eokLOe5
	 hZ3la+jVXBOs3VF5K59ZX27uTvYq5JZKgypp/4I30E6cIjh0HQUE+TFiybkpKeXr2Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480328;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=rWfeEa0PZ69WDxMC/jfdmA+1QgFkiF6Sosrj8/1XMWI=;
	b=t0mxMBoTSbojf/Ls0BBL8ZJCGZ/wjQdpeyHgPujUveK0WlGV9Uz33lZUfqWP5vWH6fUA
	 Ljdin5Z8Mc7y/JJiC2AJLVuV1Ty3FW7PnTqO0aX50uBpTpX/UkwOnUqx6Rau1IZ9bzJWf
	 WnsSsjyea13ogkCru6cEGSndWQoJQktvm/S8zBJHCiJsxd6aXucWTkg5iiU04RCwgrWgg
	 jgFXnD9qOxW6Khnu8nMYQZrsuquEGl7DhVR9LBsO/4TfQWAjFjhg1J3aWV/8dSeLJHWro
	 3q8JlTdFQxTAugIUYuwfwLFGeluSS5hnzr9TsMpOzK9xAvYqcnR6CEnDYmxNGnK7YrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=jjyhyoHt;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEE606A88A;
	Thu, 12 Nov 2026 10:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67EEE606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=jjyhyoHt
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD5BDA167A;
	Thu, 12 Nov 2026 11:45:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794480324; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=rWfeEa0PZ69WDxMC/jfdmA+1QgFkiF6Sosrj8/1XMWI=;
	b=jjyhyoHt2jfGX5QGZSNQzFH2mpIxmuNeemOa3TililwxFke/2RWB9pJwN1NSZf6hKYd4dj
	N8EbtMHMvOQNteIeNEG2zzplS1RNTKeJ8Bw9VusFqG/FlZnS3Jhn3Mi1PIzB7bV8ZiHn3S
	B106sLEjB7YlUIrKt6J5m47DMfTKX/WGudLBRfRjUslyQHBMkRRhMMH+tBdsT9HJJLWsfU
	OiwJlk298LxB7Mf4kS0KhHI1Ztx6LDL7WnpI34MAoo3J6UX//uqvJT1WJkiSHp3lqRnnmO
	Z+XXFBwSTiP+fPBdreAkCcVsZD6oDArslEIHgu1fIWRJ6Sb6MWm9WUn6VX35pw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v7 0/9] net: bcmgenet: support larger MTUs
Date: Thu, 12 Nov 2026 11:45:14 +0100
Message-Id: <20261112-nb-genet-mtu-nn-v2-v7-0-43a5d90b3256@tipi-net.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PwW7DIAwG4FepOI8JGzBLT3uPaYdATMthtEoY6
 lTl3cdyWaaiHS3bn3/fxcJz4kUcD3cxc01LuuRWuKeDCOcxn1imqdUCFRIohTJ7eeLMRX6UT5m
 zrCiNQm+ZolYURVu8zhzTbUPfxM9o5lsR761zTku5zF/btQpb/z+4glRyoCnQZE3wzK8lXVPjy
 vPEG1hxj1AXwYYE4xkBLAyAj4jeI66L6IY4M7qBgoIhdJKYHQL9d0xDkJG1j2N8CeERsXtEdxH
 bEOXIUwxolO8koV8EVB+hhhBMljSQI7Z/kXVdvwG5TOGmGQIAAA==
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

This is v7 of my genet series which adds larger MTU / jumbo packet support.

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

A split frame takes one descriptor more. Patch 6 adds it to the two limits
which 1e09af397bc7 and fbfd7cfd2019 put on the 32 descriptor rings, so the
queue stops one descriptor earlier and a frame is flattened one fragment
sooner.

Patch 8 needs bcmgenet_fini_dma() to clear rx_cbs and tx_cbs, which landed
in net as 1c1f51c3ee9c.

Tested on a Raspberry Pi CM4 (GENET v5), peer at the same MTU:
- MTU 1500: iperf3 TCP 941/941 Mbit/s, UDP 956 Mbit/s, unchanged
- MTU 9000: iperf3 TCP 991/987 Mbit/s, UDP 993 Mbit/s, no loss
- MTU 1500 to 16347 with traffic and ifdown/ifup's
- pktgen at line rate, 3858/3872/3886 byte frames mixed with 64 byte ones
- raw frames across every receive descriptor boundary, byte exact
- CONFIG_MAX_SKB_FRAGS 31, 29 to 31 fragment frames in the split window

Pierre-Marin Leclercq tested v5 on a Raspberry Pi 4.

[1] https://github.com/raspberrypi/linux/pull/7614
[2] https://github.com/raspberrypi/linux/pull/7617#issuecomment-5669564355
[3] https://github.com/raspberrypi/linux/pull/7617#issuecomment-5735557324

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Changes in v7:
- Patch 1 rings the doorbell on the skb_share_check() exit too (sashiko)
- Patch 6 wakes and stops the transmit queue at the same threshold (sashiko)
- Patch 9 clears frag_drop once the dropped frame has ended (sashiko)
- Dropped Florian's Reviewed-by on patches 1 and 9, both changed
- Dropped Pierre-Marin's Tested-by on patch 9, it changed

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
v6: https://patch.msgid.link/20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de
v5: https://patch.msgid.link/20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de
v4: https://patch.msgid.link/20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de
v3: https://patch.msgid.link/20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de
v2: https://patch.msgid.link/20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de
v1: https://patch.msgid.link/20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de

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

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 737 +++++++++++++++++++------
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  34 +-
 2 files changed, 588 insertions(+), 183 deletions(-)
---
base-commit: c88fd6989aea9237a60a4859139a265bfb7ddc0b
change-id: 20261002-nb-genet-mtu-nn-v2-402b5e6f306f

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

