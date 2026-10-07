Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9E448382;
	Wed,  7 Oct 2026 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363116; cv=none; b=dVcPpI/qMF551jiMxa3SAknqZOiZOjwH9IqXOUw7bycPB9hoFlZphsRJaSHM+K7oJUS7G3wjPNDRUuXX6I9HFq2zXxm1KPQgMcZ9L83kC4/2cileEpblp+6wRoTO0YA/2i2MkNRvfeQgNg+04fmpYH/qJhUiOdak/cKi4pA29IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363116; c=relaxed/simple;
	bh=MYGuRXy7lGZCB6o6TeVe2fQ7G4jNmPZGrQ8vTB2ziDM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QTYgra14cSKM+JmSgPOpuha7aS+O77vPriInID/mhPtGFg9X2weroZZ9d1zuyCyyjcomvlS8iuuFHZDuWRcaAKK9/BHJwWi1EqlU7QZlP4zrSZaenfwmZEwG58884Vv74mLfgGjjuoO1fpNmB3BUTqGWbfeaR+hUU74TkeZBcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=botISDJ8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="botISDJ8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93259A05A5;
	Wed,  7 Oct 2026 10:51:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791363109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ACvoHAWsETCADGs/MbWJXSMy2xKA39f76uQB4C2XjW8=;
	b=botISDJ8W4AkwIIm0rlJsl2xl55Q5oSAzS5WZ3qHlL7La8PkCoNrD1QkhiMQ9F/rhHQbMh
	0qTR3eKUYfKIqISTCUuZKVl+Vp9mHI2R1H16SZj+g2ENls28rtZHhIhzpnUo5EhucSsefS
	WtB40TB2Basz6oUXABfmucaA/7/oU1K8eFgF1uV9/TKVWWrncOmpJnh+4zf4Qlon2XquW4
	pepV/srph+J6SKrulM63ujDotYlbrrgeedUsuXBKUDuScg/+xfyf8SVTTLSJvwxr3iLQL1
	2ZpaX5Qb4oDfRc9HLpdWavFo6DPND+L3g1sE9N/EQPMMICHy4x/CA15Rwuqw4A==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v3 0/8] net: bcmgenet: support larger MTUs
Date: Wed, 07 Oct 2026 10:51:23 +0200
Message-Id: <20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBAF0KuQrh3TDtAEV97DuLDtALOwEFobD
 OHu1q40MS5//vw3mwi0MAVxqjaxUOLAk8+hPlTCjjc/ELDLWaBEraRE8AYG8hThHh/gPSSERqJ
 pSfe11L3Iw3mhnteCXsT71NMaxTU3I4c4Lc/yLanS/4OTAgmddla7trGG6Bx55szFo6MCJvxE9
 E8EM2IbQ6hUqzqF38i+7y9re36xBQEAAA==
X-Change-ID: 20261002-nb-genet-mtu-nn-v2-402b5e6f306f
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Larger MTU aka. jumbo frames are requested often by Raspberry Pi users, but
the hardware has its quirks with larger frames, so it never got done. Dave
Stevenson's PoC [1] had the receive side working and Justin checked the RTL
what the hardware does with long frames, which got me past the rest.

GENET never sets dev->max_mtu, and the packet ready thresholds cut frames
off at their 2048 byte reset default. With this the receive dropped them as
fragmented and transmit never sent them out. See commit messages of the
patches for more details.

Patch 1 fixes a transmit error exit that left queued frames unpublished,
the padding in patch 6 adds two more of them. Patches 2 to 5 and 7
implement the MTU as far as one descriptor reaches (3564 bytes with 4K
pages). Patch 6 pads around a transmit quirk where a frame ending just past
the threshold stops the transmitter [3]. Patch 8 reassembles the fragments
the hardware produces above it, which gets the ceiling to 16347 [2].

Tested on a CM4 (GENET v5). MTU 1500 is unchanged, MTU 9000 reaches 991/987
Mbit/s. Pierre-Marin Leclercq tested on a Pi 4 (also GENET v5) with various
MTU sizes.

[1] https://github.com/raspberrypi/linux/pull/7614
[2] https://github.com/raspberrypi/linux/pull/7617#issuecomment-5669564355
[3] https://github.com/raspberrypi/linux/pull/7617#issuecomment-5735557324

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Changes in v3 (all from clashiko):
- new patch 1: ring the doorbell on the transmit drop exits, the last
  frame of an xmit_more batch left the earlier ones unpublished
- patch 6 (pad) now precedes the max_mtu change, a bisect between them
  could stall the transmitter on large page kernels, the
  ENET_MAX_FRAME_LEN(mtu) helper moves into patch 5 for that
- patch 6: mention the checksum fallback in the commit message
- patch 8: read the status block before the FCS trim, pskb_trim() can
  release the page it lives in
- patch 8: drop a start descriptor without end that cannot hold the
  Ethernet header
- patch 8: threshold comment, note on the TX descriptor length
- Link to v2: https://lore.kernel.org/r/20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de

Changes in v2:
- patch 5: resync the PHY state machine after the MTU restart, a latched
  link event was lost and an internal PHY is never polled (v1-4)
- patch 6: move the checksum fallback here from patch 7, a bisect between
  them dropped checksummed frames on large page kernels
- patch 6: note the trailer limitation of the padding
- patch 7: pskb_trim() for the FCS trim, a reassembled frame is paged
- patch 7: latch frag_drop on a continuation without a start, the counter
  inflated per descriptor
- comment and commit message corrections in patches 2, 4 and 5
- Link to v1: https://lore.kernel.org/r/20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de

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
Nicolai Buchwitz (8):
      net: bcmgenet: ring the doorbell when the last frame of a batch is dropped
      net: bcmgenet: let the caller decide whether to start the PHY
      net: bcmgenet: allow a continuation descriptor without the alignment pad
      net: bcmgenet: rename ENET_MAX_MTU_SIZE to ENET_MAX_FRAME_LEN
      net: bcmgenet: derive the receive buffer length from the MTU
      net: bcmgenet: pad transmit frames out of the packet ready window
      net: bcmgenet: allow the MTU to be changed
      net: bcmgenet: reassemble jumbo frames from status block fragments

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 368 ++++++++++++++++++++++---
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  21 +-
 2 files changed, 342 insertions(+), 47 deletions(-)
---
base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
change-id: 20261002-nb-genet-mtu-nn-v2-402b5e6f306f

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

