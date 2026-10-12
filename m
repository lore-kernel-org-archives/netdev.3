Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48832B9B5;
	Mon, 12 Oct 2026 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795660; cv=none; b=lwqHVkdGe4E3EfFQjpSFGoyu8kvCxSLdICg3pAGtqo4iSw18XmTu+TzKOQJcEh3gQpfG2fYwcIId8Iagi+8FZpgqMC2vi7U+NRXNiACSTwvAi0oROPdvdRvKoK3Oe5OB+a3jQmH7VVKSbw8PnjUgmX0/WKhO9RXjjbit3//PVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795660; c=relaxed/simple;
	bh=KwApZnptsQ3SXL8oofq9r5DsuWIJ6Ywj4PYB6mA9RMY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b0EJ0L+8qcwniYePtLD1c7MndQoLOJJYRRGSg6Q55bruqsYMq+DYA1bRVa/J/VQY6pkP8r9mLVOaJXDx2HEOJu2ahGt6cDFEQ3ymm40RfnHsV+sTo3hlVNen2NH5bVzxzVrKxBlsAbvFeOVyGopAOAPj7s4GBybsZDXXvXbzEcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=mePL8F1C; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="mePL8F1C"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 456F8A0E33;
	Mon, 12 Oct 2026 11:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791795651; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=gfXxUCrcFGKlWkjsjE/A84ByGDsS1C5NauM3gkTg+7c=;
	b=mePL8F1CMltRrHFcTI0R7uugohgKukbPnxqNqKG1iSAMLi4L5gDfjpgUO5eM4F9tXN8VTZ
	RJACB+7ijoJSsH7zw0kho1Y8wtWFAQLuy8Xv4w3L5SLstybasTlCPFKoiNI80CAzSse+p1
	DmgdSX78SRpk9UkUtTzhcf1i0yOOmk5FP62BmGr5J/bBRaqWHNkEpaiBbB7cgI2VCTE4EM
	4FFNGBcVu6Q9AX4IWZ2HZUDgtKsi1MPV74o5BMyOMMTByH9BzHJZO/9votK2vveiNHmPKJ
	0AQedZbdyBjWvhiLyJkvpPXPTvMdLdF5GL9tu4rlaXEozaiJ/tvPLI4Toys82g==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v4 0/8] net: bcmgenet: support larger MTUs
Date: Mon, 12 Oct 2026 11:00:36 +0200
Message-Id: <20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OwQ6CMAwG4FchO1uzlTEyT76H8cBGgR0cBOaCI
 by7kxNR4vHP337twiYaHU3ski1spOgm1/sU5Cljtqt8S+DqlBlyVIJzBG+gJU8BHuEJ3kNEkBx
 NQarJuWpYWhxGaty8oTf2GfU0B3ZPTeem0I+v7VoUW/8PjgI4aFVbVRfSGqJrcINLXDjXtIER9
 4g6RDAhVhpCIQqhBf4i+R4pD5E8IaWsSq0sF9p+fbKu6xtc/GoySgEAAA==
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
the padding in patch 6 adds three more of them. Patches 2 to 5 and 7
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
Changes in v4:
- patch 5:
  - floor UMAC_MAX_FRAME_LEN and the flow period at ETH_DATA_LEN, a lower
    MTU narrowed what the MAC accepts (clashiko)
  - move the TBUF threshold write to patch 6, where the padding needs it
- patch 6:
  - keep the transmit threshold at its reset value up to ETH_DATA_LEN, v3
    raised it on every system at the default MTU
  - unshare the skb before padding or checksumming, ether_setup() leaves
    IFF_TX_SKB_SHARING set
  - note the threshold goes by skb->len and the window is reachable only
    later in the series (clashiko)
- patch 7:
  - skip the restart when both MTUs derive the same values
  - clear datapath_up on the suspend teardown (clashiko)
  - unwind only the Rx NAPI instances a failed ring init added, the retry
    would otherwise re-add a listed NAPI (sashiko)
  - note the one descriptor limit is lifted later in the series (clashiko)
- patch 8:
  - count a reassembled frame once for DIM, not per descriptor
  - require a continuation descriptor to carry payload
  - give the measured TX descriptor length
  - note the checksum fallback is on transmit

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
v3: https://patch.msgid.link/20261007-nb-genet-mtu-nn-v2-v3-0-74a796c019ce@tipi-net.de
v2: https://patch.msgid.link/20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de
v1: https://patch.msgid.link/20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de

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

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 405 ++++++++++++++++++++++---
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  25 +-
 2 files changed, 381 insertions(+), 49 deletions(-)
---
base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
change-id: 20261002-nb-genet-mtu-nn-v2-402b5e6f306f

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

