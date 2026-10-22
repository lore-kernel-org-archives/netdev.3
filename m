Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659260;
	b=0zgLvnr7mpnHbOkiAiXjDYPKXOZ76fGJrebYlBiDFJmhH8mHHO+gLQGhM8HP26PswLuV
	 xNElD5kpvTUe3Z4LHTXCY2K1KRqLc1aU+UgSpsBwlxeH3D+CQoGjHjOGL6jhIw2OEyL1X
	 LdfOpOAE9OGWu1NOQ9p8WaqKQq1i69FqgKrGxIc3Y5/PV//bYbG6PPwX3Y7/duGYnZymN
	 js/9OTFeC6wSEDIiUrTyDORWYv1NQn5obAS+YEKAbAsZUaa3Gyv1rjgrFsBsJIoPpERoB
	 p+esLOcRI7sOvKao+3zNSV6G0KBKFxr7gk+NEIlJqGs4tOphG+tbVmszo4c7I/g7JIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659260;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=/AICmVWqfrMJ780GqvhcQ3Q9weXbT+oeNC4HrBmA/ww=;
	b=G3nErz7ED9YCnx+h8Bh8DV8AAkAeARSm369AqxPwgiMu4gnvVEzoeed6jNif5zIt7cuM
	 FUZEWJdiODlO+kh3oQuxnorwsVMUXERW+LXgAN0VRyELl6ZXRNgBscerK0WN226uZw5Lo
	 VSWzinZYsNrGoNTu1EmTvWrY2IobHHlJWOZs3q3OYHXaX1dNw6iW+j7q3XyT9A6FX9OfW
	 Uk0iDko6fnb9RPz8NBwaarU+a9Nqr8rINMSTnbo+lLGLz3HjOKJiH2karZeICaQBM5wzv
	 1EnBFE9fEdxcIgcMcuW2ZkQSkmvLzCpgXSZXxFmTepX6AXVcmAnoMPXKLZVao9OEjQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=EkOv9rqa;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AAA606A31A;
	Thu, 22 Oct 2026 08:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67AAA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=EkOv9rqa
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A91B3A0064;
	Thu, 22 Oct 2026 10:54:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792659255; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/AICmVWqfrMJ780GqvhcQ3Q9weXbT+oeNC4HrBmA/ww=;
	b=EkOv9rqaQZa+ZUKmbPBKQkKDWCVlC6Ewg7nr3USCwpAZRj5Z+jzkOmkp2cj9ABawsvf36h
	3uR9WStyGnPzq1yEfyo+QlF1U3Wxc/TUJoUFECma+VzblseTv2jkaguN1NojhAp2/MT0xO
	8AFozERqVeOCb5uA4fDZyafvXiZ+6JiHUkmBTN2+kuR0PfMGXdURRaYiwzDy1SpGA64r1G
	bEe6Asx/JbHIZfCrrlfswPx61iGomw98vlZMutSPZbQTA8EASih74LTDP+oqv8Uvgzffj4
	VAJQ1w61ikqzu2J2cM5IRDHKP/m0Rwso9TQb4hpyHkuXvbxJQEx/EDuf2/JXlQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v3 0/2] net: bcmgenet: fixes for a failed resume and
 the ring rebuild
Date: Thu, 22 Oct 2026 10:54:05 +0200
Message-Id: <20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156@tipi-net.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4V0bQ0tfYAr/8O4KDDAmFhIi0RD+
 Hfb6kIXLO/MveesxIND8OSUrcTBgh5HG0JxyEgzGNsDxTZkwnOuWM4ktTXtwcJMO7RI27uhMSh
 uigqACVCShO3koMNn4l5IKJDr5+gf9Q2aORJjbUA/j+6V7AtL5a9I74gWRnMqNOhG6k6VhTjPO
 GF8HVtIloX/cqo9Dg+cupSdqiuupDD/nG3b3vwpFq4bAQAA
X-Change-ID: 20261015-nb-genet-fini-dma-net-62a39ee14e65
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

This is v3 of my resume and ring fixes for genet.

Mostly findings sashiko raised during my recent review sessions.

Patch 1 is a resume that fails in bcmgenet_init_dma(), which leaves the
interface up with no datapath and the next ifdown hanging in
napi_disable() with RTNL held. It is one patch because nothing that
resume leaves behind is reachable on its own, the second suspend never
returns until the hang is fixed.

Patch 2 (was patch 4 in v1) is the Tx coalescing threshold going back
to the driver default whenever the rings are rebuilt.

Patch 1 fixes the rebuild path, not the root cause. bcmasp for example
parks the PHY in its WoL suspend and has one deinit with a flag, which
looks like the direction for genet too. But one step at a time :)

It is also prep for the next version of my MTU series [1], which
drops the "hallmark of a bad design" flag in favour of the ring pointers
it clears.

[1] https://patch.msgid.link/20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de

For backports: the WoL hunks in patch 1 need 254f3239dd07, on older trees
they can be dropped. The rest should apply on its own.

Tested on BCM2711 (Raspberry Pi CM4) with the resume allocation forced to
fail. BCM2711 has no WoL irq, so I had to force the capability.
With this a magic packet wakes the board and the interface
recovers on the next suspend and resume. Thanks to Florian for pointing
out that s2idle can do this at all.

WoL doesn't wake the board after a failed resume though: as sashiko
pointed out init_umac() left UMAC_CMD at 10 Mb/s and only adjust_link puts
it back, so it arms fine and then misses the packet. But this is
pre-existing, arguably even better since it no longer hangs the system
like before. IMHO the proper fix is to let resume allocate before it
touches the hardware ... I'll do that after the MTU series.

Florian, Justin: if you have a board where the WoL irq is actually
wired, I'd appreciate a run on it too.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Changes in v3:
- Arm only the configured wake filters instead of turning HFB off (sashiko)
- Share that selection with the normal WoL suspend path
- Fix the clock wording in patch 1 (sashiko)
- Tested the WoL paths on a CM4, see above
- Link to v2: https://patch.msgid.link/20261019-nb-genet-fini-dma-net-v2-0-b85f6b92654a@tipi-net.de

Changes in v2:
- Squashed v1 patches 1 to 3 into one, each was either a no-op or left a
  broken tree on its own
- Turn HFB off on the suspend early return, it stayed armed as a wake
  source (sashiko)
- Second Fixes tag for the WoL hunks
- Let PHY_ERROR reach phy_stop() too (sashiko)
- Link to v1: https://patch.msgid.link/20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834@tipi-net.de

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
Nicolai Buchwitz (2):
      net: bcmgenet: recover from a failed resume
      net: bcmgenet: restore the Tx coalescing setting when the rings are rebuilt

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 102 +++++++++++++++++--------
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |   1 +
 2 files changed, 71 insertions(+), 32 deletions(-)
---
base-commit: 82e31923c0553fdbfcddcd910ca07952880ca9b9
change-id: 20261015-nb-genet-fini-dma-net-62a39ee14e65

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

