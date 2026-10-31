Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793433679;
	b=WVeMVgZlKPaJisnmk6Rpe7VWxcDKfq4qiK/edSROq/NxAG0mH28YVPtivQ1i8MCzc8Ey
	 dBWSo5PLouA2nOEN0sJyVg9SYhzWrN++DZWTRloXH0NfDJgf8oUC+lql/PXI9MLWMkrbo
	 OPLxpHuvIMyVMXXm6ElHEv24i5LRFAnkQbyDBcbyJ/lcbIva6etM02xbq3BzpZxFLjiTy
	 LEbWbKCixMOwS5ernbz331nlBHcxb2acPFbqC3dEjjtYWdRcxNsrA/FmdIyuCdp9glx/F
	 pexR9AZEBGnjHDaaxb9y4nWLEwLhJ0nbugK7wu19+A9DXhdG7HD6yJAFdnioqUOXGcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433679;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cfbrpU3f0JDjh54iypGpXlQS0daRULfgPZLThbv7g18=;
	b=A+tty858GN3B1zOR2fipGDCeO+53hjrLjEva4yMaWsQUtdqvnaTf33o8vy/3tkaFWKBq
	 qQhOAa2Uql4texHiuXEET0H/nwz6djwt9V3GxWsmUs8K5uZzPuDLnvFfbWxzE/qTIheHT
	 5ZR3ySZimVKfF/c/jXdLlO9zBcKtuTOkdTI5Q1MEaCReIpumKITLRd9kcYahN6svF81OS
	 1tMZvOhow5NvmHM1UcVEBSUXk50+k1BwdzeVVCxCvyS/3HsZqUPTeYeMtIHZ3k9Gh5Tm/
	 f4uO1GCMJwJd3dGvm7m08K7uZC9tmgeqVO+aeXXCMnIM6mXcgsnypITw8JzVr9BShiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9zoJNz0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4388606A31A;
	Sat, 31 Oct 2026 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9zoJNz0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793433678;
	b=Lt957BAoSXm82O8UgAHBaag+s3kThkWMhobvMelA9jllVtovG/vgHmUR4MS6EwEdhsbr
	 goXhwY8jPbRjyaizrj+gttkzVflT7qBCJXKaEo1ZWOtZKyTk8+uRXMIbWcN9E2VNj4U/j
	 R2jcAzw2FvdUyDIge8kAau0AilWv2szbHmdCx8uGBB8gP8zdjQHvF71rx87z0XDCqZoeL
	 WSqMRtZfT8STnnlSsO5QKkN0V4gNd89rdj/JAAQHJGz5mUpdZiwgpJRmGxbQvKllcuGXX
	 hBPnmXOHlIlex0W3fM2h/h/hMOmalATe4uHbhqnrxedUVvj4ETZFJvI1Q/v0p96QsIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793433678;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cfbrpU3f0JDjh54iypGpXlQS0daRULfgPZLThbv7g18=;
	b=gRwi4nG4SO9YnaDXYGqxvOv6jQ/pQapoA3XMm6UDLK5t6BhR+F1lB3rmne8oBCUJ9faD
	 qmbw60P1+u8NAbrpREFVG2pSncyFT+rhuDPa91FUGtoX1iAH4ukRtcS/nOlSqgi8K7l0G
	 0Z4CDXziAgYkiXFd5FgfiSxhFLSSlGGxe9vkR2LtK6S39s0TGfdORcNxPPs+QgJgRJ1Co
	 YTy49byYoHFGvceupK2Nj5cbnxzBkIaMM+75PtUvelrq04/gW4u3fCyp46/OGhKVx4tr5
	 nyCJZFR8Vz/c4UsunriABd+ltAf5D0gY4+yzOgm5OkALaj/a3b9R6NmXWdVFgLtiGXg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DFCEC1F0093A;
	Sat, 31 Oct 2026 08:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793433678;
	bh=cfbrpU3f0JDjh54iypGpXlQS0daRULfgPZLThbv7g18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=j9zoJNz0LBbM3FiMbQMwc7nmHR2wDBFEgxa+JD9/9rQ9Ng99OswzekUq5fgBmKj4c
	 FurOme8IVRyQRzUExRSxCWGAlsR4l8dG5cuL2ZLPxlpLYmw7C61yY/IddkjNvCN1uk
	 tlxeS1FaGwqlcSoBQqO5jkmNuoLq+rye2gBQ1y9o8HgsGAC0zlXnvMz9OQXa/PCFDa
	 /z0Y3xVTB95w8ndeoAciyDGoUkYZUOFf6ddWSisQtP47FHD9HSwYoR44gBo3vW3Nuy
	 jokJkJmIJ1iXvqj2cF+BvQlYKfEWbvlNARFpX1IV6Z44TW2C6MQavzvRbBWVse6Q/n
	 uNGGNMSg+j44w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 65F3845E4E;
	Sat, 31 Oct 2026 08:01:17 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sat, 31 Oct 2026 08:01:13 +0000
Subject: [PATCH net v4 2/5] net: phy: disable the line of a postponed PHY
 interrupt only once
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
Message-Id: <20261031-b4-phylib-mac-pm-irq-v3-v4-2-5ba23b3ff9a4@iav.lv>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
In-Reply-To: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4062; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=8zXAet3FysmTNcLxuqPvOqbMTt4jhwFxSje2BLOJunQ=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFlPF3idmVP5ZuGJFTI6xhNNr6mU9/Z9fzSngbvy3K/DE
 +4ztG6b2VHKwiDGxSArpsgy4ZDGrYwlV//6e5g/gJnDygQyhIGLUwAm8msZw/+Mt6LzdE4a7CsP
 9iq+fn/SkZWfO9+93FrpayRgZ/3C5kwKw3+/4xs9XQM/e/BXK904LFQfV7daQcyc+XdfZ5ZT3vo
 Lt1gA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

phy_interrupt() postpones interrupts during a system sleep transition:
it sets irq_rerun and disables the line, and mdio_bus_phy_resume()
re-enables the line once and reruns the handler. On an edge-triggered
line the IRQ core does not mask a ONESHOT interrupt, so an edge that
arrives before disable_irq_nosync() runs the thread again. That second
run disables the line again, and the line stays disabled after resume.

Make irq_rerun atomic, as the next patch adds a second setter, and let
only the run that sets it disable the line. Mark the irq_suspended
accesses with READ_ONCE() and WRITE_ONCE(): the handler reads it while
the PM callbacks write it.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/phy.c        | 7 ++++---
 drivers/net/phy/phy_device.c | 7 +++----
 include/linux/phy.h          | 5 ++---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 9af303d60bd6..b47f0d3d99e5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1416,7 +1416,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 	/* Wakeup interrupts may occur during a system sleep transition.
 	 * Postpone handling until the PHY has resumed.
 	 */
-	if (IS_ENABLED(CONFIG_PM_SLEEP) && phydev->irq_suspended) {
+	if (IS_ENABLED(CONFIG_PM_SLEEP) && READ_ONCE(phydev->irq_suspended)) {
 		struct net_device *netdev = phydev->attached_dev;
 
 		if (netdev) {
@@ -1430,8 +1430,9 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 				pm_wakeup_dev_event(parent, 0, true);
 		}
 
-		phydev->irq_rerun = true;
-		disable_irq_nosync(irq);
+		/* Disable the line only once: an edge can rerun the thread. */
+		if (!atomic_xchg(&phydev->irq_rerun, 1))
+			disable_irq_nosync(irq);
 		return IRQ_HANDLED;
 	}
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 79dba43d703a..d5d0efc10418 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -344,7 +344,7 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	 * has resumed. Wait for concurrent interrupt handler to complete.
 	 */
 	if (phy_interrupt_is_valid(phydev)) {
-		phydev->irq_suspended = true;
+		WRITE_ONCE(phydev->irq_suspended, true);
 		synchronize_irq(phydev->irq);
 	}
 
@@ -394,14 +394,13 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 		return ret;
 no_resume:
 	if (phy_interrupt_is_valid(phydev)) {
-		phydev->irq_suspended = false;
+		WRITE_ONCE(phydev->irq_suspended, false);
 		synchronize_irq(phydev->irq);
 
 		/* Rerun interrupts which were postponed by phy_interrupt()
 		 * because they occurred during the system sleep transition.
 		 */
-		if (phydev->irq_rerun) {
-			phydev->irq_rerun = false;
+		if (atomic_xchg(&phydev->irq_rerun, 0)) {
 			enable_irq(phydev->irq);
 			irq_wake_thread(phydev->irq, phydev);
 		}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index bbe28ff97e51..48b4e852f230 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -651,8 +651,7 @@ struct phy_oatc14_sqi_capability {
  * @interrupts: Flag interrupts have been enabled
  * @irq_suspended: Flag indicating PHY is suspended and therefore interrupt
  *                 handling shall be postponed until PHY has resumed
- * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
- *             requiring a rerun of the interrupt handler after resume
+ * @irq_rerun: Set by the postponed interrupt that disabled the line
  * @default_timestamp: Flag indicating whether we are using the phy
  *		       timestamp as the default one
  * @interface: enum phy_interface_t value
@@ -728,7 +727,7 @@ struct phy_device {
 	unsigned interrupts:1;
 	/* Written without phydev->lock, so not bitfields */
 	bool irq_suspended;
-	bool irq_rerun;
+	atomic_t irq_rerun;
 
 	unsigned default_timestamp:1;
 

-- 
2.43.0


