Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793249907;
	b=piS+N+sy864ISccnAB5zLcdqBdTeZ/wEIkmwvUf/j4yysukds0xo2x7BcvdLLUC8M23D
	 UGP44PqPspSPT/cFWkFK1+QCtdSklNMeClOeU7gp6sw4jalmSozzfsCImjVaAordwh8dq
	 VYVbS2xLCwYQCEiOgEScJIOxTAY8hIQeC033H9ylQLsDSUYkzByBZBMv3Fyp6Scu3S1WX
	 /OVVl8uoRw5BGCiP+Pfo/AJ+ewTuegw070FBOvwpa3YVk4TApCm1h0vFYQEdr4MBZq2KX
	 88YXeUz6xxrqHOpCMCVPZIVtyU7MaSmR3MhJnPLVqbqPBO8p6BceXlP+NtiGEEr188w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249907;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=yqSiGedxXms6zluZVMmuHhWfM5O0ZptiZvb89qkpmoA=;
	b=f27ck0CY4qGFCPyYk2omvT69iY6Ysm6+vFX7yhKR+vjiealBIHRA4ulxOjMJZeSlD8eh
	 IccSKcrVnTqNdloARPKSZDIcPRx2Red6v0jjVWoTCxixg6imR7szo0S6BW9hMjcAN1E4o
	 O+/q9/6rmueVpfq2C4vAmy9vYJ5f/WLu+0eKWVEsxD531sfPYUj9QahAtJeiA+X7feO0S
	 sLCcKZQiQj/j3/ESF78hNBEnWMdt5j7T9oO9GsjqcGK0ki3RHEPAJqfmQOFs2aoLz6uSu
	 tP1cXJsIirlGOz/HpLS+Mrd6Z4lGyuAEbaw3OBUh+m3Jb9yYlPod/lqK224X5z5jHRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lscBtlwa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E7606A31C;
	Thu, 29 Oct 2026 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lscBtlwa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793249905;
	b=Jv2gjdcIMV7jNduWUNGLG0GJzPtl94Ps3cFribEoYz9zsb1qiFcvmG365p5KWWs9qrX0
	 seE3jNTS7IV2//d1r0nQPLZ4HjRumlhXrIISMK92yPpboBkknoYbEzWtCKqhx6Sf1WpAe
	 pLK8vOkOD6sBJ4KssG3Xx/GF+gc4ku15++lBaFT8L0O6d2BKSwmOAlRV8Cp8yf6pxLXzi
	 ZHPSfzum8Z4A4W93aNFq82sYKm1pEYBIHwcjfhZKKHL9PyRQuG/H2t6jm0hSXg2N/Hnc7
	 nVbMaTf7ZfVQcqjh4qYgtXl/vaENl6pqvKFwed81yXA9pMMOrG6LmlcDB3qNcBnhUwg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793249905;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=yqSiGedxXms6zluZVMmuHhWfM5O0ZptiZvb89qkpmoA=;
	b=yL9CMyd0/Hb23ezRbtIWqtdngy45zn0Aa0Oz+mkr6gRMveEqwtsSkzfI2jL43plx3xJF
	 oE9x4kjDKxi6nfqPkqo2nhBY4DhPSGt9qIMq00F55gp2rO/ySyjhYAuKf6hWx40MBuaEX
	 mRmZjggqIXWabhnRwCdhwsIWAMDffTJwIyp/K/248C8r0Ht60TWxKCEv6cyp/xZ7Ibzbs
	 huHIqu/kz2g+F5iB6eNcmNIoWwoW+BZdFJgy9u5vGDOqCBCZllxDWqCDKlhzu0LFhvvMz
	 C/LVMnvLuaLqgBKDmnzG9fnGV6W7l7i3WhNgIL0Mjr9behTWmLZHKAfDcYnxTl8kHTw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 16D741F01825;
	Thu, 29 Oct 2026 04:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249905;
	bh=yqSiGedxXms6zluZVMmuHhWfM5O0ZptiZvb89qkpmoA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=lscBtlwaaL9gbyhFbliW3UcZfA3/9J6zTO1+ziO5h7SFr1HpnrQJF0u8kNgbOU7jh
	 zVQgcxK8IhkYr6oIEqChpsC//resB+wnHzTHGg96xECvfLDdCym8rKFCLwopJ9RKgK
	 NLGrF65AqvbiOMU9TV1ci0fT+KM7XTlsR6IHs+kxkFrR/m9oPaCPCgpkIa6skzNUdX
	 hbNI7t5aAsg9et4UNi0zUR1COszyNbgVS/Fpr/X7tbT0zS1z1lx8QgVnvmBD9PR0aJ
	 MAtE+QUs+syNSAGUoR8PTvB4RcJ4KCTB6X8Jd1WNs3einoKWvX6fpHvgFd0T60Ii9e
	 /0QxxMYKjPZfA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9ED414570E;
	Thu, 29 Oct 2026 04:58:24 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH net v3 0/2] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
Date: Thu, 29 Oct 2026 04:58:20 +0000
Message-Id: <20261029-b4-phylib-mac-pm-irq-v3-v3-0-5907045f3210@iav.lv>
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
X-B4-Tracking: v=1; b=H4sIAG3S4moC/x3MQQ5AMBBA0avIrE1CVROuIhZVUyahqhUh4u4ay
 7f4/4FIgSlCmz0Q6OTIm0uo8gzMrN1EyGMyiEKoshANDhL9fC884KoN+hU57HhWaFWtRkmlUdJ
 Cqn0gy9d/7sDRAf37fhP5SQhuAAAA
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Wei Fang <wei.fang@nxp.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Paul Barker <paul@pbarker.dev>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=gJPvY9nSBtRKuoslNWP0NOc/ooK8yuUEFk6N66h2ty0=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFmPLuXxcXxlvhV5gXVJX822Be+cm7wLRHYseX/y3Oplu
 juC5jQ1d5SyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJTG1k+Kdi1Pm8on/ug63l
 t3o6tp2s65jFI9zVqnNp3T/+tZosqX8ZGdYxXMlewDepWMg3vjVo49nIBTU929j4bLqCnvd7HF2
 lzwkA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

When the MAC driver manages PHY PM, phylib never sets irq_suspended, and
a PHY interrupt during the sleep transition runs the PHY driver's
handler while the MDIO bus may be powered down. On Helios64 (dwmac-rk)
this hangs the board on suspend as well as on resume.

Patch 1 moves the two flags out of a bitfield they share with the link
state written under phydev->lock; patch 2 sets irq_suspended for these
PHYs too.

Open question on 2/2: a postponed interrupt leaves the PHY line
disabled until resume. With Wake-on-LAN, v3 still signals a wakeup
from it, so suspend would abort when the link changes after
phy_stop(): phylink_suspend() calls phylink_speed_down() after
phylink_stop() when the PHY is the wake source (stmmac sets
wol_phy_speed_ctrl), and a PHY that keeps its link interrupt enabled
raises one there. RTL8211F masks it in suspend when its wakeup is
enabled, so Helios64 woke on a magic packet 3 of 3 times. Never
signalling a
wakeup would let the system sleep with a wake-armed PHY line left
disabled. Is the v3 behaviour acceptable, or should the MAC set
irq_suspended once it has stopped the PHY (phylink_suspend() plus a
phylib helper for MACs without phylink)?

Changes in v3:
- with mac_managed_pm, a postponed interrupt signals a wakeup event only
  with Wake-on-LAN; with MAC power/wakeup enabled and no WoL, v2 aborted
  s2idle on Helios64 3 of 3 times, v3 0 of 3 (reported by Sashiko)
- phy_free_interrupt(): stop postponing and re-enable the line before
  free_irq(), not after it (reported by Sashiko)
- mdio_bus_phy_suspend() comment narrowed to the MDIO bus (reported by
  Sashiko)
- patch 1: Andrew suggested taking phydev->lock in phy_interrupt();
  the commit message says why that does not close the race
- tests rerun on v3

Not changed: the replay does not reach a nested threaded PHY interrupt
(irq_wake_thread() has no thread to wake). That code predates this
series; v3 sends MAC-managed PHYs through it as well.

Link to v2: https://lore.kernel.org/r/20261026045343.837889-1-iav@iav.lv

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Igor Velkov (2):
      net: phy: move irq_suspended and irq_rerun out of the bitfield
      net: phy: postpone PHY interrupts during sleep with MAC-managed PM

 drivers/net/phy/phy.c        | 21 +++++++++++++++++---
 drivers/net/phy/phy_device.c | 46 +++++++++++++++++++++++++++-----------------
 include/linux/phy.h          | 10 ++++++----
 3 files changed, 52 insertions(+), 25 deletions(-)
---
base-commit: fcc00b15cb21a6de76826e5012b2c758505f5e65
change-id: 20261029-b4-phylib-mac-pm-irq-v3-f656d4e1c64f

Best regards,
-- 
Igor Velkov <iav@iav.lv>


