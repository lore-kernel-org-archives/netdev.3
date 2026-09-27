Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9630CD81
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546403; cv=none; b=c8gijYmZVZHc43Fk+WUHfagDwOvwJYIMEKEbLkcut5E2yUM/atW2i609tUY/YeLCrhyRnwK+ZC8DURj8X/sQ4q1pxn0a2L9qAt4V5FBMSkpxkZJfa2R/xH9Lu5RctrivNCd2Rq2ByGlc6fcUoSErIF+48fNjC3dLB9VGi4rAkSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546403; c=relaxed/simple;
	bh=rzqz19tdKiIDsU7aWYdQjxQohn7bMOmaxt0Fu4XDk60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kOY6i/sn3IiRDUPb3GSu+ZTnn4NtIIVRqjl/qyX88bDrabW7ufnX/3RxUsbKoUybH1Da+APq5lWW68H/395e1wx6EfKEOGAb7cSQmcW3gqwPSrxmRneTU9Z1sjCBy64lgwWNAf3kwHoztD1pKAapSJG6He9tG0H5zMpEw0BiheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFmoIsvM; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFmoIsvM"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so1604829a34.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546393; x=1791151193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sgAVUUxDB8OVhc+RGqtGQd2Cq3Rragg7xi0varaDwWI=;
        b=AFmoIsvMVsRaFchT0Hav9KSeMsYmE7ZHJEQKKPk6/sPyqfpozZXm458O6OnH+3GCMt
         qxsfWbYVv8lFuMiPuZXwa6cf3yaQ8H21WnALEwe7qnB7Km9WaDEqMd4Vrcu77VY5p2K7
         p4SUWY3UKwdaAFUfieq1uR0HgnaYrEViYgdotbs5WdvQbCrY5Rcr0oCRwUA7b3pD0zs/
         YbQkKCDrR+AAv5OUDyV7PoNQ6tgek8YNsW8N5yZjgHX9xZ/PNNJCi8RVdtVJZIthLFgp
         eWg+9CvEhL94jNvi4GfiFBHbSxDdVImZsRh22iMHg27jG7A2GwtbqVX43L4iXdOINuo2
         +pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546393; x=1791151193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sgAVUUxDB8OVhc+RGqtGQd2Cq3Rragg7xi0varaDwWI=;
        b=JR/QVYK4krU6pmRWmPAcne8e85aiJZIRkw2zJRtkUUxtqewdx3mbUdt0xwIbx6cePO
         TpvCH4uWuy8i89ZyiG1ZQQHn1HsN+2uAOZYF+aX+6MU7aOvLPdpbxWrlmzQyjiQDpqR8
         sbr/ZvTIuWWczE+Z+usk0I/q3y3ioiRNNv7epjf4BlkRIZwmpoHypc9oP5xrmQyKzOs9
         DRaU/fNZx3JgHjnzKxGKKm4yJScm0IzYK/N6q4XJa0azrs8Xk4fT8mKS6tQyTaFGPliy
         yuxQ8c9lQaxOZpNr8U0Nn3po53u1fSWK3A8WfOgW93d9Cw3qNFsy3rgoTZMhI3Hf2u4c
         2iRQ==
X-Forwarded-Encrypted: i=1; AKwUvByuoIk0DMlE87F/ICa4vy9uLeVsV0jkwF14XSwVytmcqSszdnW2m5dtB5Qy2qSXdr2ew4DdOb0=@vger.kernel.org
X-Gm-Message-State: AFuF++kwijXsgpZN8roA03O7dXLC1WA0XkH54jJkkuFVhXVvIZi+gwYO
	x5eRZr7YXigngx0Ee0U44R11umovOT2Mt+tEVALJoUUrfV3KZfgwlh1i
X-Gm-Gg: AYBFou29uJTbIhovDvB34qFLAloy/3r488jqF+haMJKIm29FDl+ZLXyGrX/rJC1vCym
	2HE1Wn/X3SrUAaOi+tzve+7BqbwuomDg4l62HD9MLuuNWMZR7Cn8sC3BHbgO3TLmSwNLyweA+Xa
	JtbfpWvrVU5jgPCuDrTFtcoyxUdMc+NnzwPVa6aBYMYD/RuRe4bh7qGwUJ8ViiZAv7ONWaZ5v4B
	aXbVY1vQCiPMDi71kTCA+fOwkhNoW1qFN+oSxWtxw7b/y9rza9cxrDemTZGCIG/+zeN5H4imuuK
	2IhCnSG9I00VtgpAFaPFafStPT1xKw089WtiYZvYeQ39DlCXvA226WkcXx6bf6K6lUqyrGojEQa
	JyIktV2JDBXj1RFwAdvdSzfmTzXbApFksMzR6UbN+PPKGStCp7b1MGlO01f0ROqDPL+mEz6Y+om
	lzzf2HRj+1n8wk0hSOca9+GqXqwtUZmE33SAItSVKteLN2trYsZixnlDMZt2oI2Cu7fd9MgIZdw
	vAXbMuxutm/5Z5NrX88wZmuJEpgmL9KHRKN9IbWw7ifr35xcJYWRn0VaMlR92VRi8N/mADI+3H4
	OasaL6K02xd4ftldAAjovKE7bs3GTAgtGyHunn58/sWp1pM/FxRUj5mnztkW91isr+GYhNeGp9i
	EwNcMd2skEc9oGkZg+qhO
X-Received: by 2002:a05:6820:4b97:b0:6b7:46e9:96f5 with SMTP id 006d021491bc7-6d43fe7118cmr10987249eaf.37.1790546393220;
        Sun, 27 Sep 2026 14:59:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.14.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:59:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:38 -0600
Subject: [PATCH net-next v5 03/19] net: phylink: allow stopping a suspended
 instance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-3-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>, 
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

If a network driver's system resume fails before phylink_resume(), the
network device can remain administratively up with phylink suspended.
Closing the interface then needs to terminate that suspended instance.
Calling phylink_resume() merely to make phylink_stop() work is not a
safe substitute: resume reconfigures the MAC and restarts link
resolution, although the driver has not successfully restored the MAC.

This is a missing suspend-to-stop transition, independent of the reason
hardware restoration failed. No MAC recovery policy belongs in phylink;
the driver still decides whether to retry resume or wait for an ordinary
administrative down/up cycle.

Without MAC Wake-on-LAN, phylink_suspend() has already called
phylink_stop(). Do not repeat PHY, SFP and PCS shutdown. However,
phylink_prepare_resume() may have powered that stopped PHY back up to
provide the receive clock for MAC reset. Suspend it again if WoL
permits, without repeating phy_stop() on a PHY which is already halted.

With MAC Wake-on-LAN, suspend deliberately defers mac_link_down() and
sets PHYLINK_DISABLE_MAC_WOL. Finish that deferred link-down, drain
resolution work and clear the WoL disable bit while retaining
PHYLINK_DISABLE_STOPPED. Otherwise a subsequent start cannot resolve the
link.

Also undo PHY speed control performed by phylink_suspend(). As Andrew
Lunn pointed out, phylink_start() does not restore the advertised speeds
that phylink_resume() normally restores. Track suspend-owned speed
control and restore the saved advertisement from either resume or
suspended stop, including when PHY shutdown has already completed.

An explicit driver speed-down request, such as stmmac's close-time power
saving, must remain in effect until its matching speed-up. Restore any
suspend-owned reduction before applying that request, so it cannot save
the reduced advertisement over the original one. The following stop must
not undo the driver's new reduction.

Document that a suspended instance can be stopped directly. This neither
resumes the PHY nor reconfigures or brings up the MAC.

Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phylink.c | 51 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a7d086cdc9b2..f97fee908df6 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -78,6 +78,7 @@ struct phylink {
 
 	bool link_failed;
 	bool suspend_link_up;
+	bool suspend_speed_down;
 	bool force_major_config;
 	bool major_config_failed;
 	bool mac_supports_eee_ops;
@@ -2618,6 +2619,14 @@ void phylink_start(struct phylink *pl)
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
@@ -2629,11 +2638,30 @@ EXPORT_SYMBOL_GPL(phylink_start);
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
@@ -2646,6 +2674,16 @@ void phylink_stop(struct phylink *pl)
 
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
@@ -2777,8 +2815,10 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 		phylink_stop(pl);
 	}
 
-	if (phylink_phy_pm_speed_ctrl(pl))
+	if (phylink_phy_pm_speed_ctrl(pl)) {
 		phylink_speed_down(pl, false);
+		pl->suspend_speed_down = true;
+	}
 }
 EXPORT_SYMBOL_GPL(phylink_suspend);
 
@@ -2818,8 +2858,7 @@ void phylink_resume(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
-	if (phylink_phy_pm_speed_ctrl(pl))
-		phylink_speed_up(pl);
+	phylink_restore_suspend_speed(pl);
 
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
@@ -3687,6 +3726,12 @@ int phylink_speed_down(struct phylink *pl, bool sync)
 
 	ASSERT_RTNL();
 
+	/* An explicit request takes over from suspend-time speed control.
+	 * Restore the original advertisement before saving it again, so a
+	 * repeated speed-down cannot replace it with the reduced advertisement.
+	 */
+	phylink_restore_suspend_speed(pl);
+
 	if (!pl->sfp_bus && pl->phydev)
 		ret = phy_speed_down(pl->phydev, sync);
 

-- 
2.53.0

