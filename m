Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E258A1632DD;
	Mon,  5 Oct 2026 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239102; cv=none; b=LxsRs0eRyfpxspN54PLfx4+igm/eCyK/cyqb9h6AUk0ve1EKKxg+xB6yV4Bm0Suoul9Xx/rwrYG9ksTHrnYkBNMqfylC5EjYeuDWSs1kdjqd1q2exH8xHaX/dF87SIOko+BDC+ZUAC/lfMgqLrj5b4Y8WSjc+TMfdQvTld78lbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239102; c=relaxed/simple;
	bh=CQ4OesbVs7SOGS2ZnAkXo4/CLzA25O1sPf635IooNKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fp4Fc+uOjITCuoYpVtajuByBYoX0TvOmuyHPF/QgbHVSlvUGl80FP0NtkwX6b9aCRNJGlvJZ7YypFhmEmXMauPZiprhhhVf2jqE8OlDbKNfUJAqkGFHYMvahl8RymAeXU7zxwZrlYDnb+VyfBX+FFqUnw6v2UMiuEJN2uS3+aj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lgyA91k/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="lgyA91k/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02553A08BF;
	Tue,  6 Oct 2026 00:24:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791239097; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=rBfKSqsobll08Ur8D6VfojiGY5rmj2FUd3zTZ3eKyPI=;
	b=lgyA91k/toAFxLovPdYv6R/r87Jc0O9l0cbaF/3b3dtsaH3zGZVtCAa9iOwjmpzaPO96VI
	EPgMGiB9PZuGjzO3+7Dvzb8JzC9Sl9g4Q//n9HOUIsBNyUDR6ZCvivpKAvxQ2V+9EunT4d
	Prhp1F/Q0qMChzX50uaLqh94GA2RLurgBwCBV/VACn06P2HkhXl/6sRAkSRQDU1CWYEEqu
	CssSYjZi8dQbYGS/GfTcIFMNWtVcBKaE59xo9/EkdZgaVY8cipZX35WSo36/8PprZCjwpH
	BQ9JcR5lRwIHt+HuXL1bx4eyQG6iqcgupi5QBOlVOSU8Sw76+oX3/W8Wt2LiPw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v2 0/7] net: bcmgenet: support larger MTUs
Date: Tue, 06 Oct 2026 00:24:39 +0200
Message-Id: <20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7ZhSoYmuvIdhIXQKs3AgbW0wp
 He39gAuf97/7x8QyDMFuDUHeEoceJUS9KmBaXnKTMi2ZNBKm1YpjTLiTEIRX/GNIpg0dkqPPRl
 3UcZBGW6eHO9V+oBfVWiPMBSycIir/9S31Fb+T5xaVHg1djK276aR6B5546KLZ0sw5Jy/SZo5X
 sAAAAA=
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
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Larger MTU aka. jumbo frames are requested often by Raspberry Pi users, but
the hardware has its quirks with larger frames, so it never got done. Dave
Stevenson's PoC [1] had the receive side working and Justin checked the RTL
what the hardware does with long frames, which got me past the rest.

GENET never sets dev->max_mtu, and the packet ready thresholds cut frames
off at their 2048 byte reset default. With this the receive dropped them as
fragmented and transmit never sent them out. See commit messages of the
patches for more details.

Patches 1 to 5 implement the MTU as far as one descriptor reaches (3564
bytes with 4K pages). Patch 6 pads around a transmit quirk where a frame
ending just past the threshold stops the transmitter [3]. Patch 7
reassembles the fragments the hardware produces above it, which gets the
ceiling to 16347 [2].

Tested on a CM4 (GENET v5). MTU 1500 is unchanged, MTU 9000 reaches 991/987
Mbit/s. Pierre-Marin Leclercq tested on a Pi 4 (also GENET v5) with various
MTU sizes.

[1] https://github.com/raspberrypi/linux/pull/7614
[2] https://github.com/raspberrypi/linux/pull/7617#issuecomment-5669564355
[3] https://github.com/raspberrypi/linux/pull/7617#issuecomment-5735557324

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
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

---
Nicolai Buchwitz (7):
      net: bcmgenet: let the caller decide whether to start the PHY
      net: bcmgenet: allow a continuation descriptor without the alignment pad
      net: bcmgenet: rename ENET_MAX_MTU_SIZE to ENET_MAX_FRAME_LEN
      net: bcmgenet: derive the receive buffer length from the MTU
      net: bcmgenet: allow the MTU to be changed
      net: bcmgenet: pad transmit frames out of the packet ready window
      net: bcmgenet: reassemble jumbo frames from status block fragments

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 326 +++++++++++++++++++++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  21 +-
 2 files changed, 315 insertions(+), 32 deletions(-)
---
base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
change-id: 20261002-nb-genet-mtu-nn-v2-402b5e6f306f

Best regards,
-- 
Nicolai Buchwitz <nb@tipi-net.de>

