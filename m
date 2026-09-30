Received: from mail-pj2-f36.google.com (mail-pj2-f36.google.com [74.125.227.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF4521234
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777540; cv=none; b=ME9H1YQDR6RKvVf5w5KY2+MVHpbHSR5UV6X1wu7nXvpxlyZm3pptkhRrjD4rKPpd0BgaCcw5iIcFGsjT2q/pDsw1h1eNe4XgajuAmoIuSX564HQgcHXjCjSpuaiQCqIHNES1MSmKkA2ssYrIehXGh91qqLtkZ9T54ZeeSgC0lSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777540; c=relaxed/simple;
	bh=UI2XZTTAmMT6S6fO82VLI+DGctHWm6fuFI5NTz0VPh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IpzxyE+7lM6DyDwIDoOQE8FMfcn8RQJgiOc8bnqScNnpsrHqTEj2QmmickmaHOGzThl+U631CbatntzwloCmQN4ehL4bt+BroOlosFrW3iWi4BxUWEsYaeL5W9ky4wbOAljz9ToOQdj4hAEklcMpg3g5AXKSvhTRuwv6tXgFpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnoVKPoC; arc=none smtp.client-ip=74.125.227.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnoVKPoC"
Received: by mail-pj2-f36.google.com with SMTP id d9443c01a7336-2e2e35ee682so2620805ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777526; x=1791382326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3QS3HEpc4LkcdODNfPIRR2bjRGT+/U73u7f7QjEG+PU=;
        b=OnoVKPoCLO97EXXagOYMRCy1bXkxniGeH5LOXz0pFNK2txiVq/85FPuL9ifEuoQyyW
         KUY1xqY2raq46bXWIfsNDYShjQ1AkQPhHt70bimt2F6un4pxL8ayjTm8b1jFqC2WZdg0
         S/jiXbHuxS+51/MhyLzOnM+g5b8fb8PWW+VMRo4C/64fkS7IaCom54JU1xpuk8BYc8QP
         xIEJYckeVLncx4NjjLsKku0Wwx2IrXTv6BSelTbRLOmpTdQXDb9ZzJW+ErPu2b7hVBLV
         /yXyEDcOfb9+ua4Qhq/CcthcZKZcuLwuSfDMGma/D5zuJfQ7OHdJ612PvtQN9yTjczZM
         v6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777526; x=1791382326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3QS3HEpc4LkcdODNfPIRR2bjRGT+/U73u7f7QjEG+PU=;
        b=Sqv/AiDF5HDbSH/OZBNhrtmE0TrvhWhxRjzqfRo+MJfpcJoHFYaN6hXj4+htqlct5E
         eoSpxBEoPZA43NBGfwTwSSU9ANYDA/EKQl0lgbo1XHcLyV3oqkmftdR/n8ksLrEIW577
         S16yXYL1m+8YiaLqpB0Wa0dE7/SzWF00gMI1AEoFG2WOuv8fyuoXOKBX3bqS2GVANceK
         GfLw4PXgjwNdn37lNUtf2D30B3zkeLy+iuttZxP9UTtA/Xgo1lQBrowf2F/0oxOatGW5
         46JkLyXwq1T1I3KTuTU7MgHYt3G21WcVJ5HK4N+eqkyeD1lOE6hR5C5aeUr6KwPjnlIx
         cUgw==
X-Gm-Message-State: AFq9FYLkc6SwVTzFZbf+9xodxHTrfZ2OU0IYltOtYWgef+6ucGRbIxMm
	ZFXQN60d70Un5+WQlhV88lYe+6P/aQex8Qb3gb2vMV/pJM+A1ZEeSlmtdGnlcg==
X-Gm-Gg: AYBFou3xM707P6vl97gsOt4TcaqaAlNJdF7SRO8hkoqOWRf2i7gq8iFEwDZYxTQzyPG
	uMCKvMHihG3A60eJCOcE8ZrAW9IQ0GLonI63RIeGODN6ZllKipHP7vHfAKEHk1H8GpnOPMMSBUf
	SwQ6heAVoMNXQXRtyBqa40a7cX+XS6Co93Y3vnXGwKBPHSdKxkBo52rJi/ghU7agxxmO3wBip5l
	2VfDMPuuBJwTrMoW7iNrQITQWbBRjvlmRJkhI1QO68Wo2bGpXKz9aT4DIqvPns6DM2jy1w7hPS7
	DQNzJmrLgFVZA4jR5Ph0OxTPoDUnBt5/g90ANdF1WuSgz4gd444+tYYKdzJMbPw+5Iny7TvATNM
	0NirfjO7ARFci8yvb5hWUv2BMeMsdWlug6TKLKtDYsO8K10g1cPmNKxEgncZCiG+YPEPpZLh9Xr
	4CjNHVtxvjlNuiE+S/WzAj4afJdT2/X89Zh/58KhjS7wKsh2MXFJxBjojbPytmgCvhdDIGb1sYn
	dVJ+LbLeAodPg+G6UIC1ciT
X-Received: by 2002:a17:903:4b0d:b0:2dd:87c7:a907 with SMTP id d9443c01a7336-2e2e4a01156mr12465945ad.15.1790777526423;
        Wed, 30 Sep 2026 07:12:06 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5b897d8sm8307475ad.28.2026.09.30.07.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:12:05 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: dsa: motorcomm: Fix register rollback in LED setup
Date: Wed, 30 Sep 2026 22:11:48 +0800
Message-ID: <20260930141151.3973221-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED error path writes back a stale snapshot of the whole words taken
before the class device registration, silently reverting LED2 state of
sibling LED groups already registered and reachable from sysfs. Although
the odds are very small, fix it by reverting this group's fields only
for correctness.

Fixes: 9af9a8168213 ("net: dsa: motorcomm: Add LED support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2:
  - reword
v1: https://lore.kernel.org/r/20260926202955.905761-1-mmyangfl@gmail.com
 drivers/net/dsa/motorcomm/leds.c | 69 +++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm/leds.c
index 6613fe3b0471..c97b560299d6 100644
--- a/drivers/net/dsa/motorcomm/leds.c
+++ b/drivers/net/dsa/motorcomm/leds.c
@@ -420,13 +420,15 @@ yt921x_led_setup(struct yt921x_priv *priv, int port,
 	char name[LED_MAX_NAME_SIZE];
 	enum led_default_state state;
 	struct yt921x_led *led;
+	int polarity_orig;
 	bool force_high;
 	bool force_low;
-	u32 led2_val;
-	u32 inv_val;
+	u32 led2_orig;
+	int polarity;
 	u32 group;
 	u32 mask;
 	u32 ctrl;
+	u32 val;
 	bool on;
 	int res;
 	int ret;
@@ -452,6 +454,7 @@ yt921x_led_setup(struct yt921x_priv *priv, int port,
 			port, group);
 		return -EINVAL;
 	}
+	polarity = force_high ? 1 : force_low ? -1 : 0;
 
 	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 	if (!led) {
@@ -470,23 +473,27 @@ yt921x_led_setup(struct yt921x_priv *priv, int port,
 	/* Inversion is internal - force on will give low logic.
 	 * In the rest of the file, treat LEDs as if active-low.
 	 */
-	inv_val = U32_MAX;
-	if (force_high || force_low) {
-		res = yt921x_reg_read(priv, YT921X_LED_PAR_INV, &inv_val);
+	polarity_orig = 0;
+	if (polarity) {
+		res = yt921x_reg_read(priv, YT921X_LED_PAR_INV, &val);
 		if (res)
-			goto revoke_inv;
+			goto err_inv;
 
 		mask = YT921X_LED_PAR_INV_INVnm(group, port);
-		ctrl = force_high ? inv_val | mask : inv_val & ~mask;
-		res = yt921x_reg_write(priv, YT921X_LED_PAR_INV, ctrl);
-		if (res)
-			goto revoke_inv;
+		ctrl = polarity > 0 ? val | mask : val & ~mask;
+		if (ctrl != val) {
+			res = yt921x_reg_write(priv, YT921X_LED_PAR_INV, ctrl);
+			if (res)
+				goto err_inv;
+
+			polarity_orig = -polarity;
+		}
 	}
 
-	led2_val = U32_MAX;
-	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &led2_val);
+	led2_orig = U32_MAX;
+	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &val);
 	if (res)
-		goto revoke_led2;
+		goto err_led2;
 	mask = YT921X_LED2_PORT_FORCEn_M(group);
 
 	switch (state) {
@@ -494,16 +501,20 @@ yt921x_led_setup(struct yt921x_priv *priv, int port,
 	case LEDS_DEFSTATE_ON:
 	default:
 		on = state == LEDS_DEFSTATE_ON;
-		ctrl = on ? YT921X_LED2_PORT_FORCEn_ON(group) :
-		       YT921X_LED2_PORT_FORCEn_OFF(group);
-		res = yt921x_reg_write(priv, YT921X_LED2_PORTn(port),
-				       (led2_val & ~mask) | ctrl);
-		if (res)
-			goto revoke_led2;
+		ctrl = (val & ~mask) |
+		       (on ? YT921X_LED2_PORT_FORCEn_ON(group) :
+			YT921X_LED2_PORT_FORCEn_OFF(group));
+		if (ctrl != val) {
+			res = yt921x_reg_write(priv, YT921X_LED2_PORTn(port),
+					       ctrl);
+			if (res)
+				goto err_led2;
+
+			led2_orig = val & mask;
+		}
 		break;
 	case LEDS_DEFSTATE_KEEP:
-		on = (led2_val & mask) == YT921X_LED2_PORT_FORCEn_ON(group);
-		led2_val = U32_MAX;
+		on = (val & mask) == YT921X_LED2_PORT_FORCEn_ON(group);
 		break;
 	}
 
@@ -539,22 +550,26 @@ yt921x_led_setup(struct yt921x_priv *priv, int port,
 
 revoke:
 	mutex_lock(&priv->reg_lock);
-revoke_led2:
-	if (led2_val != U32_MAX) {
-		ret = yt921x_reg_write(priv, YT921X_LED2_PORTn(port), led2_val);
+	if (led2_orig != U32_MAX) {
+		ret = yt921x_reg_update_bits(priv, YT921X_LED2_PORTn(port),
+					     YT921X_LED2_PORT_FORCEn_M(group),
+					     led2_orig);
 		if (ret)
 			dev_err(dev,
 				"Failed to restore %s for LED %02d:%02u: %d\n",
 				"LED2_PORT", port, group, ret);
 	}
-revoke_inv:
-	if (inv_val != U32_MAX) {
-		ret = yt921x_reg_write(priv, YT921X_LED_PAR_INV, inv_val);
+err_led2:
+	if (polarity_orig) {
+		ret = yt921x_reg_toggle_bits(priv, YT921X_LED_PAR_INV,
+					     YT921X_LED_PAR_INV_INVnm(group, port),
+					     polarity_orig > 0);
 		if (ret)
 			dev_err(dev,
 				"Failed to restore %s for LED %02d:%02u: %d\n",
 				"LED_PAR_INV", port, group, ret);
 	}
+err_inv:
 	mutex_unlock(&priv->reg_lock);
 
 	pp->leds[group] = NULL;
-- 
2.53.0

