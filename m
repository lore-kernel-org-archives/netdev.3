Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793433679;
	b=uMfWrp5/l54aV20DcAbG7nXP/P20LHgV+EVmVtNCKehtsKQEv9LUEyacj1h99rGZqcZX
	 weROV4zwIKI/c9/nOOla7aqb+kwi4/onD5USlrJXuRXOb41+2HMAd0WPbXWiF4MwBxPJ+
	 WfJomEwyC8cOvhZ5AKrOLlCznbgNtWiyesYYoJCmZef5K+stYQOKlGRK6m5FlBTCk1MoE
	 TjWbBMZE691GgGyaQxH7pVfRvplD63umvVvdr5ZsC7rp6M10svSUeirzK1OVT4AmjU+7p
	 9Rgg5eHR3CRQMmuZTcy/7k5OxXggmn/ihn9nEmJ95PP875lDpjQBukCT3IGYZjPE+6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433679;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=78w0KJUtrUJ7P0i9G7rYNKpe5/dgB7AO3neQE5YpKOg=;
	b=NxinMI63gq4GQ/nQxPnr8MwwV9WvEGjGqnTNw9sm+2po0S20kMdG+yiXgdOxw2hg5tZF
	 nX//cIprmnRqezmb8r7zpxOzWgfjeLobNGluzfl7CYVhVX4OPXMEhY84lPTsSvw2V3k0X
	 oVlrnSbCZ2DvyScOfF0cBqIKkSkQfSc1oZpdgDUSt161fP7L1/COJgOLIIhRrqkkhomRC
	 MDSDZtohn5TnyN3iPHxxMB9c4f7vHXg0lTPM6RB4bXFuGfC7i9RRInS17I55run3saKWh
	 1rGPDIr+nIus181InoQ9XeCM4b+F1PTbsx/eBT//ygwFfeu0pg3dnHyx0w6EBOc4MYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vq/YJbnz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220C606A31D;
	Sat, 31 Oct 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vq/YJbnz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793433679;
	b=R1dlaa7VCfVA+bacwmez0dKXzFx3tFJ2pCkNYAdM/RkzjNxllgxZAX1cU9mgXN+QFIBT
	 0V1z8cpPxX4WCi+rd5R53ZJGEzwBFSqFDa/Shjs/bmGJRJ4gr7ILOR2YVYyrhBN5g4ef4
	 rnb1LnSa88GHo0qiMmV224WIMOM0A6kVvpHU/SnQ+y/+Oiwq+QzCaci1/nwDmbU3dzao8
	 zg9pveUm0X2aGtL2lV+iaQGi06H4XAex2jHH0IdgZU2NdvoHklb25hfoMTJ8hlzaEzpFx
	 9sBiZ5cJlu3/VscSaDb9ri9cxBnGqiBee2cQ6VnmVlEVRnutHBSydnD8RMc2sYjFl6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793433679;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=78w0KJUtrUJ7P0i9G7rYNKpe5/dgB7AO3neQE5YpKOg=;
	b=KQarUunXq+uhduX3cCMrPIg/R47J/naplK3k6tiW7bTVM097gUG0A1Sy+ptWZXWrPxoh
	 0CSgu8EKQgV/zxaBh7BgHw9SBjaoz/1cIBUQ8zHLMrvzIWj4tyr/7h+uw+A0fKF9Uku1A
	 6zCC9r9n8mLzZq7pvTtkUdeVk4R3j3nxZ5oO65KcvHJKNgP88bh9zD/bkIkxKygiJjyyr
	 ejWFbgjI2qXZw2IT0xq0SN5/rJnudwvPHcKNPzuMWobs3W6/JQTMdi6S9Dt0NHJKpCyuC
	 PPplFkjwA93tnwKzzgvzj/uP7Pqy4W6z5EzA0SK3Xg4Qt4NOD5c1A42yxMQ+J28RGBw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D18F31F000C1;
	Sat, 31 Oct 2026 08:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793433679;
	bh=78w0KJUtrUJ7P0i9G7rYNKpe5/dgB7AO3neQE5YpKOg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Vq/YJbnzAc0c2mPzEuYmba/UIf9d5h8VgwTzyR6hVzif0e8XxYVL3RmkEnzXTNFMK
	 0yNrUnmkwhuhHQ+apDTTjo1XB6phd9E1VN/Ve32JNbLyXU7YLq+FZUbPskOuXwSsSc
	 32s7W6d8azYnFqMo8quYN9vhqdm23uiH6xZ9yXEefVvn20zCitYOVuHJqK8PPjRm9G
	 KVBpmtfqFYPxw+oWyb7R/7uZBLfFIecQ8eWMAJJiAzP4q0MilFQlwRLzID30ikEpla
	 XWFghnsNcaHnsAqw1MLCjWW8vh7QNHgJyZ+OiZZ4kykcFN9g1pDxnWqZmyQd9RzSm5
	 fvdN16v6RX83A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4BF0E45E46;
	Sat, 31 Oct 2026 08:01:17 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH net v4 0/5] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
Date: Sat, 31 Oct 2026 08:01:11 +0000
Message-Id: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
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
X-B4-Tracking: v=1; b=H4sIAEig5WoC/4WNzQqDMBCEX0X23C0xJin21PcoHjRu6oI/MZFQE
 d+9wRcozOWbYWYOiBSYIjyLAwIljrzMGdStADu084eQ+8wghTSlkDV2Cv2wj9zh1Fr0E3JYMVX
 ojDa9otIa5SC3fSDH32v5DTNt0GRz4LgtYb/eUnVFf4ezBOpaPITSrpKleHGb7mOC5jzPH7TkR
 aTAAAAA
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
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4285; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=e7C/to0n7NCBHms5jCBzvrsKwvHbfa0Cz2zQBv+nlZ8=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFlPF3hKb+HUabmt3bTTdLl8eeg37sVJJw2eXeBi/ez79
 takiWkPOkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBEtD0ZfrP13M8pV7lsm/u/
 V/LE7PlWeVpRi/T3XM9wuMfs3Ppu61WG/86Hn1R+bhO/Y/POMHvFgo8m9QKVp0oXGq6ecVRu1kv
 P9ZwA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

When the MAC driver manages PHY PM, phylib never sets irq_suspended, and
a PHY interrupt during the sleep transition runs the PHY driver's
handler while the MDIO bus may be powered down. On Helios64 (dwmac-rk)
this hangs the board on suspend as well as on resume.

mac_managed_pm hands phy_suspend(), phy_resume() and the state machine
to the MAC driver, since commit fba863b81604 ("net: phy: make PHY PM
ops a no-op if MAC driver manages PHY PM"); the PHY interrupt stays
with phylib, and so does postponing it.

Patches 1-4 fix the postponing that phylib applies to other PHYs, so
that patch 5 can extend it to MAC-managed ones. Patch 1 moves the two
flags out of a bitfield they share with the link state written under
phydev->lock. Patch 2 lets only one run of the handler disable the line
when an edge reruns the IRQ thread. Patch 3 keeps that disable balanced
when phy_free_interrupt() runs during the transition. Patch 4 undoes
the postponing when a PHY PM callback fails. Patch 5 sets
irq_suspended for MAC-managed PHYs too and decides the wakeup event of
a postponed interrupt before the device that owns the MDIO bus
suspends.

Not covered: MDIO accesses from closing or opening the interface
during the transition, and a MAC resume that fails to power the bus
up. On a shared line, a postponed PHY interrupt disables the line for
its other users until the PHY resumes; patch 5 extends that to
MAC-managed PHYs.

With Wake-on-LAN, any postponed interrupt reports a system wakeup, so a
PHY that does not mask its link interrupt in suspend can abort suspend
when the MAC stops it. RTL8211F masks it when it is a wakeup source;
other PHYs were not tested. Tested only on Helios64 (dwmac-rk,
RTL8211F).

Changes in v4:
- new patches 2-4, one pre-existing defect each
- patch 2: an edge that reruns the IRQ thread no longer disables the
  line twice
- patch 3: phy_free_interrupt() during the transition keeps the line
  balanced (Sashiko on v3)
- patch 4: a failing PHY PM callback no longer leaves the interrupt
  postponed (Sashiko on v2 and v3)
- patch 5: the wakeup event is decided in mdio_bus_phy_suspend(), where
  phy_may_wakeup() can still read the PHY (Sashiko on v3); Fixes: now
  points at the stmmac commit that took its PHYs out of postponing
- v3 asked phylib or phylink_suspend(): phylib, as macb sets
  mac_managed_pm but suspends with phylink_stop()
- tests rerun on v4
- Link to v3: https://lore.kernel.org/r/20261029-b4-phylib-mac-pm-irq-v3-v3-0-5907045f3210@iav.lv

Not changed: a nested threaded PHY interrupt is not replayed
(irq_wake_thread() has no thread to wake), as before this series. Not
in this series: mdio_bus_phy_may_suspend() does not ask
phy_may_wakeup() about an attached PHY.

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
- Link to v2: https://lore.kernel.org/r/20261026045343.837889-1-iav@iav.lv

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Igor Velkov (5):
      net: phy: move irq_suspended and irq_rerun out of the bitfield
      net: phy: disable the line of a postponed PHY interrupt only once
      net: phy: balance a postponed PHY interrupt when the interrupt is freed
      net: phy: stop postponing PHY interrupts when a PHY PM callback fails
      net: phy: postpone PHY interrupts during sleep with MAC-managed PM

 drivers/net/phy/phy.c        |  46 ++++++++++++----
 drivers/net/phy/phy_device.c | 125 ++++++++++++++++++++++++++++++++++---------
 include/linux/phy.h          |  36 ++++++++++---
 3 files changed, 164 insertions(+), 43 deletions(-)
---
base-commit: fcc00b15cb21a6de76826e5012b2c758505f5e65
change-id: 20261029-b4-phylib-mac-pm-irq-v3-f656d4e1c64f

Best regards,
-- 
Igor Velkov <iav@iav.lv>


