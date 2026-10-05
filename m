Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC94C7558
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227351; cv=none; b=IdQtaPm1j+mV8LCmiIm4eyoqiYC/ZKL2YR3DkQI5HroPanNtpa0TDXEWDQ4URhCMCc3iXN8282wr2OnnO0V3lij1r8lJJ5Ss027ac2hXhDz0xOD40O518HabxeLjy/juAHjMXbCay+1Ej/72WmfOc3u5OmNrK5jNWLPU2MpPB0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227351; c=relaxed/simple;
	bh=PVWVS86MW7l2qNXpZ/rKOLW8knz4QwczGM40y9PhxJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c0n8porVlVXHqxQmqmS3bwmYETXUO5rUfbYTLS4YExTOdoVL+UNSxRI1aFHU5bJhXMmMZgsioAn6IaNG32nEC5/NCGGvxUDCcehS6bB/sW4TqMrCH7BK6jMenaAKJF1yRpcAnIfG94FoVR/y2XquA3gkalekRbbPCZSmatpQ574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKOzN9Ia; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKOzN9Ia"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-451a49abd8aso1231742fac.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791227349; x=1791832149; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6w/VDUTavPvcAfJFthKglKbi0EamFwxsmD0049G0nvY=;
        b=pKOzN9IauPJLf/8+6/Few6r7kEuu2MsM4nL2lyc1JfMlR2IizevXqnpy9idFNltrrC
         +jloDPxZWJd8hSsJU9vjZnl/Js2ReILzxjqp89djJyr3XWoABg3NZfK515YCYR18/Ake
         f4QrObIBAgTUTFyGFOsy72JaxvrEk8LBj4Mf/XrkXI01TIgsDF3NfHH0CzI25zsAzUY4
         BTIkCRA0g5Sgc95zp+4L/+r3ePFFJLjlOskyKIeUlAvzZesNWnzl7Px71fTqrXkPaVvP
         yw0gmk/ZvNfQZy83B9MvwzAPsjaP/7DAUkuuA71lHgK+IMjt/y8gUR0BvX8eMLwNGded
         NAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227349; x=1791832149;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6w/VDUTavPvcAfJFthKglKbi0EamFwxsmD0049G0nvY=;
        b=aoR2B9HW9qqysIJxdpZlD/hKOEY29Ng6NE5Z8qrWk5cbfPOooVuF8/CqYu7Cs4Yg8x
         KCgaoBKU3PX8Pjp4P0pm3jzAJZSgiycThlUe0kGJqlGV6ncBvfI4zLKwPqwIdCqC8OCV
         3ckI35hv56BsgVcEVQta2t8DJr6+X3i/FQc9n6loWYh3q8OCkuqVF8J4nNbwQv0UD/5K
         Nd1bVe6z0SlJ5lA39+92J1UWSbM0f1joIiE5ogFl8aa3whxPMOIhf95eODzJg254AK81
         8h5OZ1NQmAAodMe9v5oiLhOtEOgAZOO0BzgSJDAHJJKvFNC7oKNCwjld/LlxeA7PC5yp
         Bzgw==
X-Gm-Message-State: AFuF++k8MaQdDXWvoSzTJ9izHr0m4XDLZ2Qz8Pc/wRrATTjgUL8HykKK
	Ms1Rej5an7cRduy5U99jDsC6Kr2+Mea5tlnQ3453nFCcGpWJCrmehwBO
X-Gm-Gg: AYBFou14tFdtL3gxA+oSuz4s/fn5V9S6BM6nf5GGLiJXHVmvPc7601oLc7S2hJXp8EU
	CdKV8aTb32FIWCa1oT+N8y9/cadgqIv0E4CmMT0xmzGd8pvk8rR879qvM4hcuX1swfyAzx9C3Rw
	YvriFxK7qQXedYdGxzBuuIgk5/UVm7RZv4BxW+ecJMYT8gTDo2yT8DZbmovpd+p6CghdB9P4CMP
	W/Fvs8VZ3Y1aXY+UwIQ+YA6OOc96fZUEA15xDlepwP+z2c3kGG/yGyNCYw8dvdIIpnkx2NmDm/K
	PJFQQbd5FWwKzDqhnMVDsMUWTdTPFC59CGTEtNPYeGhpVPlNyZobFh9Inda/NkkXrx6a7cyhAMA
	uqmg8DqWYglx+A2MBarqP9fsl67d11Y6JGzLmtL1j6tadUtXXbEfpU78+vMLxrnugtEBdY5mI+m
	4nEgfxGEKetRuYc6g99DRVf8Lc+QJxYeWi0PVOxko4t6p82KS5ATXmI5+NO/FmnnfIlqOOoDN0S
	+rmiAo3r/QVvcY5r7Z3glp+1UIsXex4A3NjiYIym2vnHcCh1oTaLCJC35ijROook/4s6xR4IcWg
	qY7lNFGSTWWBxhhbD8Sjt+wRUfHtgOrG4Mlqzn7ILKshIODh6q78d/HMqmx++LGSyAJRXkUSIy3
	eFPy/7VVtP8KwdCWY5dtCQ8rnoneJpZ8=
X-Received: by 2002:a05:6808:4444:b0:4eb:2671:de62 with SMTP id 5614622812f47-4f67bd75d34mr7294544b6e.68.1791227348628;
        Mon, 05 Oct 2026 12:09:08 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4faca6807ebsm315880b6e.5.2026.10.05.12.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:09:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 05 Oct 2026 13:09:05 -0600
Subject: [PATCH net v2] net: phylink: allow stopping a suspended instance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42PQY7DIAxFrxKxLhWQlISueo9RF4aYhmlDMkCjV
 lXuXk+mBxjLm299Pf//YhlTwMyO1YslXEIOUyShdhVzA8QL8tCTZkooLYWQPN/tGAqfh+ctxCv
 JPGPssee5TDNfJBfGG6tr1L6pGWHmhD48thdfLGJh578jgb7RlV/4x5bw504BysdrISN300jvj
 hXQ+K5FMMZ2rdbOQAcgsJUAjUJtXQeHWomNPgQKk55bqUVusP/np6USWhvf2wZMbU+XEcJtT0n
 YeV3XN2B8FjMzAQAA
X-Change-ID: 20261001-submit-phylink-suspended-stop-v1-09f9b63e6f43
To: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

After a failed MAC resume, a driver must be able to stop phylink without
resuming it and reconfiguring the failed MAC. This is needed when recovery
leaves the interface administratively up but detached until a subsequent
down/up: ndo_stop() must finish the suspended phylink lifetime even though
the MAC could not be restored. The missing transition was identified by
code inspection of the stmmac recovery paths.

For MAC WoL, finish the deferred link-down and clear the WoL disable bit.
Otherwise, avoid repeating PHY, SFP and PCS shutdown, but suspend a PHY
that prepare_resume() powered up for the MAC reset clock.

Retain the saved link state if MAC WoL is suspended again after a failed
resume. For example, fbnic can fail to allocate IRQs on resume and call
phylink_suspend() again on the next system suspend. The carrier is already
off, so taking another snapshot loses the deferred mac_link_down(). Keep
the original snapshot until resume or stop completes, allowing the next
suspend cycle to capture the new link state.

Do not enter MAC WoL suspend on an already stopped instance. The wake
policy can change between a failed resume and the next suspend, for
example when fbnic learns a different BMC presence from firmware. Setting
MAC_WOL alongside STOPPED would leave stop/start gated by MAC_WOL, while
resume would take the MAC-only path without restarting the PHY, SFP or
PCS. Keep the stopped state so resume performs the required full start.

Restore any PHY advertisement reduced by suspend. Track that reduction
separately from explicit driver speed-down requests, so stopping a
suspended instance does not undo a driver's close-time power saving.

Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
Fixes: 4c8925cb9db1 ("net: phylink: fix suspend/resume with WoL enabled and link down")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Keep stopped instances out of MAC-WoL suspend when the wake policy changes
  after a failed resume, so both resume and stop/start can recover.
- Explain the detached-interface recovery requirement for suspended stop.
- Link to v1: https://patch.msgid.link/20261001-submit-phylink-suspended-stop-v1-v1-1-0669fdb4a93b@gmail.com

To: Russell King <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Joakim Zhang <qiangqing.zhang@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/phy/phylink.c | 63 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1bbcf46c8356..0a62ff1bca02 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -78,6 +78,7 @@ struct phylink {
 
 	bool link_failed;
 	bool suspend_link_up;
+	bool suspend_speed_down;
 	bool force_major_config;
 	bool major_config_failed;
 	bool mac_supports_eee_ops;
@@ -2498,6 +2499,14 @@ void phylink_start(struct phylink *pl)
 }
 EXPORT_SYMBOL_GPL(phylink_start);
 
+static void phylink_restore_suspend_speed(struct phylink *pl)
+{
+	if (pl->suspend_speed_down) {
+		phylink_speed_up(pl);
+		pl->suspend_speed_down = false;
+	}
+}
+
 /**
  * phylink_stop() - stop a phylink instance
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -2509,11 +2518,30 @@ EXPORT_SYMBOL_GPL(phylink_start);
  *
  * This will synchronously bring down the link if the link is not already
  * down (in other words, it will trigger a mac_link_down() method call.)
+ * A suspended instance may be stopped without first calling phylink_resume().
+ * In particular, closing a device after a failed resume must not restart the
+ * link or reconfigure the MAC just to finish shutting it down.
+ * Any PHY advertisement reduced by phylink_suspend() is restored as part
+ * of this transition.
+ * If phylink_prepare_resume() powered up an already stopped PHY, suspend
+ * it again when Wake-on-LAN permits.
  */
 void phylink_stop(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	/* Also undo PHY speed control when terminating a suspended instance. */
+	phylink_restore_suspend_speed(pl);
+
+	if (test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state)) {
+		/* A failed MAC resume may have called phylink_prepare_resume()
+		 * and powered the stopped PHY back up to supply its RX clock.
+		 */
+		if (pl->phydev)
+			phy_suspend(pl->phydev);
+		return;
+	}
+
 	if (pl->sfp_bus)
 		sfp_upstream_stop(pl->sfp_bus);
 	if (pl->phydev)
@@ -2526,6 +2554,16 @@ void phylink_stop(struct phylink *pl)
 
 	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
 
+	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
+		/* Finish the link-down deferred by MAC WoL, without restarting. */
+		flush_work(&pl->resolve);
+		mutex_lock(&pl->state_mutex);
+		if (pl->suspend_link_up)
+			phylink_link_down(pl);
+		__clear_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
+		mutex_unlock(&pl->state_mutex);
+	}
+
 	pl->pcs_state = PCS_STATE_DOWN;
 
 	phylink_pcs_disable(pl->pcs);
@@ -2631,14 +2669,22 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 	if (phylink_mac_supports_wol(pl))
 		mac_wol = !!pl->wolopts_mac;
 
-	if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
+	/* A failed resume may leave the instance stopped even if the wake
+	 * policy now requests MAC WoL. There is no running link to preserve;
+	 * resume must still start the PHY, SFP and PCS in that case.
+	 */
+	if (!test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state) &&
+	    mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
 		/* Wake-on-Lan enabled, MAC handling */
 		mutex_lock(&pl->state_mutex);
 
+		/* Preserve the pending link-down if a previous resume failed. */
+		if (!test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state))
+			pl->suspend_link_up = phylink_link_is_up(pl);
+
 		/* Stop the resolver bringing the link up */
 		__set_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
 
-		pl->suspend_link_up = phylink_link_is_up(pl);
 		if (pl->suspend_link_up) {
 			/* Disable the carrier, to prevent transmit timeouts,
 			 * but one would hope all packets have been sent. This
@@ -2657,8 +2703,10 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 		phylink_stop(pl);
 	}
 
-	if (phylink_phy_pm_speed_ctrl(pl))
+	if (phylink_phy_pm_speed_ctrl(pl)) {
 		phylink_speed_down(pl, false);
+		pl->suspend_speed_down = true;
+	}
 }
 EXPORT_SYMBOL_GPL(phylink_suspend);
 
@@ -2698,8 +2746,7 @@ void phylink_resume(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
-	if (phylink_phy_pm_speed_ctrl(pl))
-		phylink_speed_up(pl);
+	phylink_restore_suspend_speed(pl);
 
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
@@ -3616,6 +3663,12 @@ int phylink_speed_down(struct phylink *pl, bool sync)
 
 	ASSERT_RTNL();
 
+	/* An explicit request takes over from suspend-time speed control.
+	 * Restore the original advertisement before saving it again, so a
+	 * repeated speed-down cannot replace it with the reduced advertisement.
+	 */
+	phylink_restore_suspend_speed(pl);
+
 	if (!pl->sfp_bus && pl->phydev)
 		ret = phy_speed_down(pl->phydev, sync);
 

---
base-commit: aaaaf87ea99b8766c9a8aa0e71aa42e6bc8a5320
change-id: 20261001-submit-phylink-suspended-stop-v1-09f9b63e6f43

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

