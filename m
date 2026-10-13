Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24D3CEB8A;
	Tue, 13 Oct 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901245; cv=none; b=adQOq/9kNwn3TI5UevAbDOtuVGrzcwziqt1VKJ3hoL9awTFJbGZlpnqvMShNBXqg62UNBiwWOK2F/+BvCl5eLCXNrKJkxjsOYLSkv9Qc7let5wX733HGXXt2ZZ2ZQreeBVBk1Qg/JOFFs4Zor+TlRbJcfmyOyhmSwf77owmzNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901245; c=relaxed/simple;
	bh=h/heYrSdU+2r4S0iyTQUfIUeyUJZPeDuk9ULCl1wCuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WJqoQmGzbHfLBKeBUine0F/xOQK7jFze9FjzpUCFyvCNDb5APITkrkpHbkobCLaL/jT1EksBRUB1dmBKWbMH6zTjHOtlRn6AcXfiytcRsCu2s4JrPfBJKU5Qx2TZXmPiHB/SgOL6/w9RxA49oCYdt+1a4MpsuUxq8HWyjWe+qlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=OBTbxQgU; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="OBTbxQgU"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6D88A154E;
	Tue, 13 Oct 2026 16:20:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791901241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=kjvVsMX8ljJ5FYsacVgJvho8EK/Kn1ITN+3x3YpVMlA=;
	b=OBTbxQgUJpD9/18gUUZpeGvc75q0tfcV7m9knDtHMqC/qITcajUksdwNxqdCA6FDQ6Fee4
	qH160/9siStP0L0ioTgN/qZ2nuQt0HKE2FAsac3TFvQwXsMjwNSng+4WCGdab0+Z9948it
	xl/Q+C0AVnz4LJl9TOTveoeIuzYfG0JUMphSLFuoHltDqH4ZYN6Eml3sbIweOOsSdF3PwL
	1R2iXBiWSvdXgdrau0zuAIlfy9BnpKmU781pFE7Zd5iJLbrUCDSe+oLsiinxeL8Sxgy91q
	RRq0In1pGLLnPXIuiI3oGM6v2Ldjp4vG75j4S18TS2/gLyWme6jLezvQvT4UPw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v5 0/8] net: bcmgenet: support larger MTUs
Date: Tue, 13 Oct 2026 16:20:29 +0200
Message-Id: <20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PwQ6CMAwG4FcxO1uzljHEk+9hPLDR4Q5OA3PRE
 N7dyQkj8fin7dd2FAP3ngdx2Iyi5+QHfws5lNuNsJcmdAy+zVmQJI1SEgQDHQeOcI0PCAESgZJ
 kStaukNqJPHjv2fnnjJ7EpzXwM4pzrlz8EG/9a96WcK7/gxOChFq3Vrelsob5GP3dZy7uWp7BR
 EtEryKUEasME2KJNdIvUiyRahUpMlKppqq1lVjblUvUAsH1d1RGiIkL4xq3t/YbmabpDZT798e
 PAQAA
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
Changes in v5:
- collected Florian's Reviewed-by tags from v4, except on patches 6 and 7
  which changed
- patch 6:
  - move tx_thld_len to the transmit variables (clashiko)
- patch 7:
  - take the no-op path when a failed resume already took the datapath
    down, the restart would otherwise free the rings twice (sashiko)
  - hold the PHY lock across the rebuild, a link event could otherwise
    take the MAC out of reset and enable it (clashiko)
  - reprogram the Rx mode after reattaching, a filter update that arrived
    while the device was detached was dropped (clashiko)

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
v4: https://patch.msgid.link/20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de
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

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 420 ++++++++++++++++++++++---
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  25 +-
 2 files changed, 396 insertions(+), 49 deletions(-)
---
base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
change-id: 20261002-nb-genet-mtu-nn-v2-402b5e6f306f

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

