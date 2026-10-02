Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5633429038;
	Fri,  2 Oct 2026 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953411; cv=none; b=ufDL2Al7zRwvYntCKJwim6UKl1sqSz+gPkcor9q/mitoTumL3AFaWobWKtW/KzKjMDRw7TpfbuR02E8bg3mD4PudvjkAXBipXWo5H+40Xh4HXY5a5EpjcXAhP8zqvF/uzl0W2ZhI9HUOd7sEFo4BG44pNDJx4WXCUTKPKsWnfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953411; c=relaxed/simple;
	bh=9KS8vKruLblAiH9NnFSBjkmQCirDt7L9TPxV4Tpz0MU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RiqZqZeZVhh6TunoKs5rjD7TLOCd4d4W8RNCg/ek7d0YDQA7WuLnMN8SFIlGrCiJRoJ4jZwCXyz0J7PwP94qNRCogLofDuzXPIJVJI5GJTbrjTbmwIl+0xLiGDhxHxTccESw1NRFfmrqXCNCvyHWvadZYORuicC0oxUDMkRAkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=rg3zDtff; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="rg3zDtff"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F19DDA4AC9;
	Fri,  2 Oct 2026 17:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790953407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=x/MJBDqmB30yXiiaaC3oc1LfHicMLmpYGqZN8EI9MmY=;
	b=rg3zDtffUpYW3sJIRbuHNGJ2c82rEtPZwG5+3WSR7UUbvc4HTNWTODhjAO9BUJ01mE4t4A
	iPAoAKNLHmNUkUNP/8g3BjhYyaM42jc9+CflLI+sGkmdYuDMEp7YIfrEMB2oz1n5EVNcqy
	H8HSE+L44wMBKeAE28WxfM5EKIcsMavb+Cah1M1fPUzqhkOGPLAeuBy2ELTZGBSHRhymtq
	E/ODnJcqwtu2g/hdenaaNo4utNIdzY2SKeeFVZ2zXgLX5btzYpOmlc9NVz/y76iFErV7yq
	FR81T52iRXD4pni4vEeK4K53a+1Bp/UxoGTOp4EXm45G2LWrtKfgPHLE0YsdwA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 0/7] net: bcmgenet: support larger MTUs
Date: Fri, 02 Oct 2026 17:03:18 +0200
Message-Id: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQ6CQAwFf4X0bJNScQ/8CvEg+hZ7oJLdlZAQ/
 t2V4yQzs1NGMmTqm50SVsv28QrtpaHn++ET2F6VSUVDK6LsI09wFJ7Ll915Ve5ExxtCvEqIVMM
 lIdp2Tgf6q46t0P04fm/kpyxuAAAA
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
Nicolai Buchwitz (7):
      net: bcmgenet: let the caller decide whether to start the PHY
      net: bcmgenet: allow a continuation descriptor without the alignment pad
      net: bcmgenet: rename ENET_MAX_MTU_SIZE to ENET_MAX_FRAME_LEN
      net: bcmgenet: derive the receive buffer length from the MTU
      net: bcmgenet: allow the MTU to be changed
      net: bcmgenet: pad transmit frames out of the packet ready window
      net: bcmgenet: reassemble jumbo frames from status block fragments

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 303 +++++++++++++++++++++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  19 +-
 2 files changed, 295 insertions(+), 27 deletions(-)
---
base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
change-id: 20261002-nb-genet-mtu-nn-v2-402b5e6f306f

Best regards,
-- 
Nicolai Buchwitz <nb@tipi-net.de>

