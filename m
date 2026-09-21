Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B69446853
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022691; cv=none; b=hoe3qTa/Xjwz4/7rPuuNKTk6YdWDoFNMwWxL4qJAD2iGxsccq0RtBA8oeQxs+ofT3NshQvSHNhAjB23gOvdoYZG9dc4N8YvFmgV2Y0cHuLLrsxO22dPbTMMmn7F2ucMb2S9dfB8IHqcxMK7d9PfAvekDKFIK2U+Cll50nyrnXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022691; c=relaxed/simple;
	bh=Hfn/RFfA59PXEqWm88i0jT6Irs15cdflbyXalU9LxMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvG8l3k+t5WAt2XpMjhxaVxIuVRhMAcZgwP/mMCZNj00UlsvBUwz+3nrHQuPd8+c2WyYlfR+I2jZ3Nk8JVA5mglgKr9XmToYKuzlB49rC2GOmflRuDdDUQF+2aDA8Z1d8lhyTyQslKaeEb+sglTZUmbYwkZYd3mDQRHwRkOyLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijRAM+VA; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijRAM+VA"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso3109977a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790022690; x=1790627490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5HDWmpx6LncuH8zbt4GsN7mum7FN5BQZYEBCPrt/7w=;
        b=ijRAM+VAzk08V9yHKvCVvFxGr8roT+X+mI4OtLF4efRTZYi4RkcHwEJfMV79HQrDWI
         2IuYl44NeaqDYUxLlHyYg9pM2FlTbXRiufSBo1oJqBZFOgelS3nd064ZFOf8hJNZH416
         2fJtTm4G0YF5ibxDzGE31mC/naaaBTLLBzuigHOmkYTeUfyJm4JEtvwKa1i5iDDDtmRY
         ut04KsDuEtLf4vAkFZ5Z/o9tOj4MBCaOzQh3xJurEq6w5/rkDFyjxQBPRDfg/0412WQj
         AYZjeWct0oRGCJw+r0tGYDSMZ+uKt83Ln3NNzeuxzUtWEb5fkPrOeaJSYq1Nbz4Rdzzn
         CVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022690; x=1790627490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X5HDWmpx6LncuH8zbt4GsN7mum7FN5BQZYEBCPrt/7w=;
        b=c2iIUuYW1/Dq5cCMxsbidQzi0fb5H6b02CgsjBUE5MHlILk5a771i4BJOKUiXQpqQo
         iKIrbzvdj90GIMhcSGxecWdhL2SF/2gqvNoz7mJJZs9TyDGwHeeyTEINgcOJNPthnDG3
         Rux8Wk9GuJuMWi1s+bh81o2tVigCod6pUCdvIaE9xvjbadrKrwwhDtSv+4ebfvegpdqh
         JSHr178fbSdNyDsMggbpVLBaL7VacRUPNrZTEpVW8yVTMDHm4dX1FJwv4D0mKvA9abAb
         JLa0YboyksT6l02sPSpifIn+TM1SCkpiynO3mPHE4okoWKE3SMal+Q7bmPoM3Ti6eOvO
         QwFg==
X-Gm-Message-State: AFuF++luQ/NgqRZK5IWGZG8x4odIjaHqfXISIbULeLN/oUha7hHXQ5fi
	+EolNLLw2QjbngB1FFOyeRbzoJ6EuOstbpdzkS8J1okhlWw3LzW9I2yCv8Ukxw==
X-Gm-Gg: AYBFou2wXwVtDOU97ZS67/eTP9aqcn0lDeUxib03yOWErgHNvvk9ZirWHxV1zaXEbdk
	S2hMOvGKsiYK3oci3kDMuVJaONbDhjcujV9BYYNHxN0Ng9ivZlUVxctyPYPodLqbOsBvbInOX/5
	1/mXQM+9XALO1Fgoe3fgYr3KC4ZijoKBkNXEtdaZ/t8GEdW9yZ/7gJDD/XJZljQQdys1myX5s4p
	SESBZXutNA98Idq9Up4QMkRsYyrNUSOLPKIfvo2I+PUTbpohWnr5PfyKCHVYHtuT2Ro8Zyspwux
	6QOcuaqxaArBHqzbiN5YZ9vrpFpOOMz0E7BbQMLlCKfjknaT1ZzjoWidLWmFfybuMG7yayknrKg
	dZrc0UngH7gsCzgZeOX3liST+J31b4uqCzJRCsmi23L/pjdXALNjf5/4a2Zj121Y9b2GNujZgoU
	hORPokCFdRiPMEw00BxlEQDDw6LKAnGOXSux6WnpO+gUmqdBdOdrinX+k0CIZHkt5JXLHDUjlvJ
	I3S8aIXaTy+rOQQq9i4Lnhv
X-Received: by 2002:a17:90a:d64f:b0:39e:4c80:44b9 with SMTP id 98e67ed59e1d1-39e54dccbb8mr18482940a91.28.1790022685159;
        Mon, 21 Sep 2026 13:31:25 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a069918587sm447247a91.4.2026.09.21.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:31:24 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/7] net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
Date: Tue, 22 Sep 2026 04:30:18 +0800
Message-ID: <20260921203040.1203911-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921203040.1203911-1-mmyangfl@gmail.com>
References: <20260921203040.1203911-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yt921x_poll_mib() open-codes the same container_of_const() expression
that leds.c defines as to_yt921x_priv(). Move the macro to chip.h as
yt921x_port_to_priv() so both files use one definition.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c |  3 +--
 drivers/net/dsa/motorcomm/chip.h |  3 +++
 drivers/net/dsa/motorcomm/leds.c | 14 ++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 8b0ac5fc8c8b..38e7879a9f1a 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -608,9 +608,8 @@ static void yt921x_poll_mib(struct work_struct *work)
 {
 	struct yt921x_port *pp = container_of_const(work, struct yt921x_port,
 						    mib_read.work);
-	struct yt921x_priv *priv = (void *)(pp - pp->index) -
-				   offsetof(struct yt921x_priv, ports);
 	unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
 	int port = pp->index;
 	int res;
 
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 83cd454955dd..9cd1010eb970 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -989,4 +989,7 @@ struct yt921x_priv {
 	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
 };
 
+#define yt921x_port_to_priv(pp) \
+	container_of_const((pp), struct yt921x_priv, ports[(pp)->index])
+
 #endif
diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm/leds.c
index 87a6b9cf6068..dd5b3684250d 100644
--- a/drivers/net/dsa/motorcomm/leds.c
+++ b/drivers/net/dsa/motorcomm/leds.c
@@ -12,8 +12,6 @@
 #define to_yt921x_led(led_cdev) \
 	container_of_const((led_cdev), struct yt921x_led, cdev)
 #define to_yt921x_port(led) ((led)->port)
-#define to_yt921x_priv(pp) \
-	container_of_const((pp), struct yt921x_priv, ports[(pp)->index])
 #define to_device(priv) ((priv)->ds.dev)
 
 static u32 yt921x_led_regaddr(struct yt921x_priv *priv, int port, int group)
@@ -321,7 +319,7 @@ yt921x_cled_brightness_set_blocking(struct led_classdev *led_cdev,
 {
 	struct yt921x_led *led = to_yt921x_led(led_cdev);
 	struct yt921x_port *pp = to_yt921x_port(led);
-	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -337,7 +335,7 @@ yt921x_cled_blink_set(struct led_classdev *led_cdev, unsigned long *delay_on,
 {
 	struct yt921x_led *led = to_yt921x_led(led_cdev);
 	struct yt921x_port *pp = to_yt921x_port(led);
-	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -353,7 +351,7 @@ yt921x_cled_hw_control_get_device(struct led_classdev *led_cdev)
 {
 	struct yt921x_led *led = to_yt921x_led(led_cdev);
 	struct yt921x_port *pp = to_yt921x_port(led);
-	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
 	struct dsa_port *dp;
 
 	dp = dsa_to_port(&priv->ds, pp->index);
@@ -374,7 +372,7 @@ yt921x_cled_hw_control_is_supported(struct led_classdev *led_cdev,
 {
 	struct yt921x_led *led = to_yt921x_led(led_cdev);
 	struct yt921x_port *pp = to_yt921x_port(led);
-	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
 
 	if (yt921x_led_trigger_is_supported(priv, pp->index, led->group, flags))
 		return 0;
@@ -386,7 +384,7 @@ yt921x_cled_hw_control_get(struct led_classdev *led_cdev, unsigned long *flagsp)
 {
 	struct yt921x_led *led = to_yt921x_led(led_cdev);
 	struct yt921x_port *pp = to_yt921x_port(led);
-	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -401,7 +399,7 @@ yt921x_cled_hw_control_set(struct led_classdev *led_cdev, unsigned long flags)
 {
 	struct yt921x_led *led = to_yt921x_led(led_cdev);
 	struct yt921x_port *pp = to_yt921x_port(led);
-	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
-- 
2.53.0

