Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C74A0EFA
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790454634; cv=none; b=vAebdAMc5JiHsJ3/2xuT1lPhFBcE48XkvlNM/YQfB+jJijg/Ji1dVgHXQuhR8v5UNPm2ZyJufWaV6IEP1S4T6WRU1ayqof2ywgaBxs/OA4+r7YZRTcw3nqwNuUJd1mgXegF7QBZtjmvyaM9QDzhXh0EyAmralV18uW3L50gXly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790454634; c=relaxed/simple;
	bh=BLW2WyPLNMwOv1FiQp1Al2W6/NZC3OA99WDZvdfFBbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A55KnfgjsOrmxUhGzmaHUDa9B7d6Okf3iZgPwSraj7TsjnU1ueGDVpWE1vChW5j+otpBSM8j7b/Fcw2rXCidYs+iy58K55FXnwgzIfPWKbKa98WsJbslfX49c8sabv6b0IiUPl/3+PD8g8UtN/eUdJEk+YRF0wZ17awRWx5D23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjdSaZ5V; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjdSaZ5V"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df90e859e8so5820425ad.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790454632; x=1791059432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ivo4BNLteKc5XTbiZYpGvrbG6IkjPUiiYjc06iaG2SM=;
        b=GjdSaZ5VkeDs/Oi5fhPyi+Yun+Zpgr5b7frKsmUGwbAbmAJjIPQzr8YgufJGd5bu6y
         EiWgXBRKqf/CtKf+kbsJoL/ICsqhiNYSlgsYGF7QkIMao9UTq1fk05rr6aH/8BYS0iOp
         +VSOXsOt6oMq83BREKWJ4Rpt/OCDqumeTkWNwIOy0pwVoouujnkHFnJzlvRRYoM+GdjX
         uGf8MxlSocqkN28wHQ8yZz1F95DCWX5GkreWWtnRL930vHncD3DIqhKJTzr+pCw2YMHy
         WcjN/ivTulmnAv8BqFimeNl/2eh1gr6O/iO4bu4SI+us676Mxiv1lp2/ViqwCaJIGgGc
         Ji3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790454632; x=1791059432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ivo4BNLteKc5XTbiZYpGvrbG6IkjPUiiYjc06iaG2SM=;
        b=T/NPXdCLO0ZUEGNaETsuMoQpEjuLOVq5FD4fiQtmM02K1i6n1+rtmstxZAkIFTkEw/
         vRLy+VzkL56KVLLLQjHQu71S20XT6M1g+0J9Voa8zt6mqb4bdw81iICvkD/TG5R63rM1
         CHJZAnprlVRRtseez+Tds1QP+p6c2ofbSfeAwxDA/JmVdIvvmcpX6b+8ioSDZi0rq+Cs
         5md0e4QPGehIn2tMBSaBJM2IHyoxYgm7BhQR/NtPqgQ73qqv4hDujjjK6hrZKr9oub4O
         I1LoAPdWpp9LdUWBXclkEBckO3Sfh4sLlsOWVO0iVBQ3LRALuzmok7iWduXe8XFO7BZn
         cdlw==
X-Gm-Message-State: AFq9FYJEGhIgnAuyBz7RviG821ry24gxHiZ9X2XR/mTu89fofqWnYgVd
	DUO7o8TLXs1nTNzPrxKT7Rjevzdnbh1opk0c4sYxGUDHWz8OX9f2rzultGVLXA==
X-Gm-Gg: AYBFou07oKqpp1Hxt8Ml58GUi0fYWjQc8s4B6sVww30EttyOJLw0wsWdE2h67rm1hlK
	z77nqy7ZjqPn22T1xrJ3CN/Fv82J3KXTrVd7ULB24SjWronGnwNf+EFho7Cl34yGi/ZuVDlYV1u
	mtSXuypIkfkZiAT6BFvXXdNaaASI9d/vOerUDOFZolVVnx4jqnpaRmhwV/qfGvKjvMjniY8NRV2
	GaOz4pcNpigkwjd5oFEH/cV2MY9hsPrh6B21nXyv+BIKq/4FM60B99t+1Frl0ncI8JEaz+3KSmI
	bsf0DKiEExwEFCm0tFZtk/rMUu9fC/0X/0w92NLL39u9NlCEPpP7YmTIH/oPxVHG9nbCeDCU5lq
	T8N7AWiJ01cKlRq2tw3/50LYnXAeOgAbv+4K5/FiMTvZAtFpBoypYKaOV7DrBGs3c2jNL/AKmLn
	YyBsz+O40lKP5TUOHffHDmLPGGRUMIT4Ov+DPIb8XwUjwJdTgIXc7cQ7fNtHITzMmuVxgZsq53K
	1p1NGAbcqbGqz0q5+RpHTLK
X-Received: by 2002:a17:903:3202:b0:2df:69d4:86bf with SMTP id d9443c01a7336-2df7dff3106mr53438245ad.11.1790454631596;
        Sat, 26 Sep 2026 13:30:31 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913e1b6csm23762475ad.29.2026.09.26.13.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 13:30:31 -0700 (PDT)
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
Subject: [PATCH net-next] net: dsa: motorcomm: Fix register rollback in LED setup
Date: Sun, 27 Sep 2026 04:29:53 +0800
Message-ID: <20260926202955.905761-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED error path writes back a stale snapshot of the whole words taken
before the class device registration, silently reverting LED2/INV state
of sibling LED groups already registered and reachable from sysfs.
Although the odd is very small, fix it by reverting this group's fields
only for correctness.

Fixes: 9af9a8168213 ("net: dsa: motorcomm: Add LED support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
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

