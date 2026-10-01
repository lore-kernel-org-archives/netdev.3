Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549249BD8E
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839513; cv=none; b=D6uOe3BhIS+sz50NdvspMnBkLaENqq1b2HbIo1/ViBXaHBzYq08xIlorvGs41OyjvOsZQYcLNsXgAJH/nMVYXA2P4H2zvQXqzHiCUtU/EuLGJbUlKOZmyn7Xyb7Fb1U/SgPEQs34hTFXmZDmXqWR9wbFP6LJziVvFgyCaW38BoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839513; c=relaxed/simple;
	bh=JfBkkHgZiIkkSz4rA7SyKB1ygthlO/1JZwHYjPy8It0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bkD4V3gNjji+Nti0cW4OdidqijJ0QUDP7trFDXlH/gWw4Ehbuckg189FEj6q5Ke9P0aglSqOozvcnROx76Gn6eGJBgipJZ4/OyryS06HqEZG6Ats5DLxLz4xdeSbdS3RcWdNbcoPtSIWDCiJr2w+DgR6UaJEbObvii3Ip1Z3uuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA9zIMur; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA9zIMur"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-81adacb0f81so1099441a34.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790839504; x=1791444304; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kaT9y/FLNptdflfoU99H0BfFB3r6Sc/0PbsEzk52HW8=;
        b=IA9zIMurPQEqUp8O44T+Vbu/3yliKz9Ck6Egl/Y1aJY8/L4kiPfwytiySBd2seFmS3
         g5YNjN6y9XZhs2AHBY/ExJHdJrkj6CzoPjaVnj4JVSp+8u3j8ePfj7ApB3Y44IxyoMYV
         iLkDWR6SqkLEEY1umpnyRZnATgcQGgc5971ZQpfjkSjLcJkG0NH8dciG8n/ji3LET+v8
         jvjEDG3+RQcm5pOv81SrVCi0Aq9kX6EeXaVR//OA3Ia0WGkbzJqWhZoWcX6Jm7UpvoYS
         c2GemxEmA8DWLm3WKyK/+ClcEQkVpGFQHZkWXPgQoNKGm+4Qmh/jAG3AwHk31daN83rj
         Z8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790839504; x=1791444304;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kaT9y/FLNptdflfoU99H0BfFB3r6Sc/0PbsEzk52HW8=;
        b=bz0zdO9qQReZG+b2PvPodnSxxJ49oLqQtWm55HfVE4sXYsZ4LxXRCk8JjgxlXGkrU5
         +E3halFn7z7NVDj3IFwpFpyrYSqlsptND512A3ihOszvcFUR/4v+ETJUJQsx9qviBK/M
         h/zyMGbeIbLjhRHBo/DaU3k7kD1F3ZTkJKTBNDkhKH14hGKoRoLtNru2A8mHrFomtfqV
         gCP2nO5SJF0ah89ytDFYgO60kBWmS4GCiFklFf0n3oQ0qrKaHo/srwsKmkQBFtDxWfqN
         mtsPOh7ftEp/dCLYlu/DpwYhYX/eXatOF6XGwutkc6xu+15I6M+rnRT/jgytgMxey+ca
         Zs/Q==
X-Gm-Message-State: AFuF++k6Yq86SW9qps/HFJGeIgOinjfmyKp9ySS93x4q85oqIMpWUESQ
	t0enGgfLTm2W8nhQnXD0n+E1WfbHfbew8XQMZq0xUXs0YfgeKft1S6shSw7fNB5Z
X-Gm-Gg: AYBFou3qROL4sYvIw+EzhHQxB4f7tC8ehYj/3NGTiQWQ0FtzYsQ47CqiqRx8X65TF0h
	L2haCgV1C10HBZqd2LZIxjqVYgXUdoh23Na0NYY83vrltAzW88an0+ZEcjReLWeNGu8xyaoLx9j
	uslfA1u3yLH6LdW+EOA6+lYv4vU86Zpla2em5+99yio4se+WAiWQszVG36L8EE05qk/zmDE/3sJ
	cBpQV07WJKI2s4xyvuMgshEearjsRuyS3SrJrsiOie1g3EEA7rqGs4YV3S83vouBcTMdKICahdA
	NUw1bEhs/UcRN4t0YZWAgu3xK+jpOWR3Wbr9D0ZMa1Mvymo/dfm6LezLtbmd997ylMImcdqBmz5
	8K/2DYtUnaPVXNVmbi9JgoQLTFjcAv+FYRb3wPt4GOoBufe6WpDLOI25VtmUGdhNGapzl/A8cnP
	5nH3jji8wliA6wN4cGqi+JHX/4Xg33vwnIx8Z085FI4OWvqd0LvzOZC/VqMqUlFay1e/T3AgVMa
	15YCi68FGcU0Xx6lkHwL1zZZt7CK4OjU78eEaBE/Kqtzdq1L9mE+JWbpfbKpYwU1qKbKPojzOsV
	92Y1VIhRKOZklT5kPQO1yVP9X61FEgcOKKNJxkisqQUeajZ5UtuY7cwLeA+moIHK/yvAvPJxJMD
	VW99HKYqEm6bN3UKT4ExJHw==
X-Received: by 2002:a05:6830:4388:b0:804:e0e8:1a86 with SMTP id 46e09a7af769-82120255097mr2048474a34.1.1790839503856;
        Thu, 01 Oct 2026 00:25:03 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212af3bd3fsm1966448a34.20.2026.10.01.00.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:25:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 01 Oct 2026 01:24:53 -0600
Subject: [PATCH net] net: phylink: allow stopping a suspended instance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-submit-phylink-suspended-stop-v1-v1-1-0669fdb4a93b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2Oyw6CMBBFf4XM2iaUYnn8imHRx1SqUmpbiIbw7
 1ZleSYn584GEYPFCH2xQcDVRju7DPRUgBqFuyKxOjNUZcVpWVISFznZRPz4flh3zxg9Oo2axDR
 7slJSdqaTnCE3NYOc8QGNff0mLuAwwfA/5tANVfrGDy3gc8kPpMOVIiJR85Tn+qJhzVmzlvFad
 EJwbiSjDeVSoUHDWoFK6Gy0MOz7B2Q0BsbVAAAA
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
resuming it and reconfiguring the failed MAC.

For MAC WoL, finish the deferred link-down and clear the WoL disable bit.
Otherwise, avoid repeating PHY, SFP and PCS shutdown, but suspend a PHY
that prepare_resume() powered up for the MAC reset clock.

Retain the saved link state if MAC WoL is suspended again after a failed
resume. For example, fbnic can fail to allocate IRQs on resume and call
phylink_suspend() again on the next system suspend. The carrier is already
off, so taking another snapshot loses the deferred mac_link_down(). Keep
the original snapshot until resume or stop completes, allowing the next
suspend cycle to capture the new link state.

Restore any PHY advertisement reduced by suspend. Track that reduction
separately from explicit driver speed-down requests, so stopping a
suspended instance does not undo a driver's close-time power saving.

Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
Fixes: 4c8925cb9db1 ("net: phylink: fix suspend/resume with WoL enabled and link down")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phylink.c | 56 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1bbcf46c8356..08f06ae5213f 100644
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
@@ -2635,10 +2673,13 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
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
@@ -2657,8 +2698,10 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 		phylink_stop(pl);
 	}
 
-	if (phylink_phy_pm_speed_ctrl(pl))
+	if (phylink_phy_pm_speed_ctrl(pl)) {
 		phylink_speed_down(pl, false);
+		pl->suspend_speed_down = true;
+	}
 }
 EXPORT_SYMBOL_GPL(phylink_suspend);
 
@@ -2698,8 +2741,7 @@ void phylink_resume(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
-	if (phylink_phy_pm_speed_ctrl(pl))
-		phylink_speed_up(pl);
+	phylink_restore_suspend_speed(pl);
 
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
@@ -3616,6 +3658,12 @@ int phylink_speed_down(struct phylink *pl, bool sync)
 
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
base-commit: 7375d38364a9aa66fb31716bcefef38aecad75d8
change-id: 20261001-submit-phylink-suspended-stop-v1-09f9b63e6f43

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

