Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4E4C33DA
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577044; cv=none; b=aTexNYu3Uz8oNIJaPxSgUPMzPSWH6ndF/6fB8SWjMsX2mqoWXdTeD1kXPPzczrlhic7tmaoEhOrJy9rW+twLUBW6jQbXhpRDHGofrVP4GMZYx0E6z5BsP0wH215j+uVtFMof5n/75HvZDsAemSRuKV0dig6Srlpfx5pHJ3xf/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577044; c=relaxed/simple;
	bh=9OzXTV0DA223m5vSCHBBhdaUL4nKz5XYVLsqm8ikMrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwiLkbW54QtJscbiKfym9hPohbPcUYoWCh6nx6S3AtsjdOtp2hTUSy4hVQUd61OeiVcqiH9I/OkClxizfpYrpqfwjnmzQCMZSnhnk+q2HaEL07l+Vys9fpxXMY2Epl8K8NfKv7HyZYaqK+CpGLKTN7qr8qaMPteZAa5IbXIV5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIEe9K3z; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIEe9K3z"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86e6d007703so940683b3a.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577028; x=1790181828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFUZqkMC5HU2RrjnHFq3xM9VTr/hsbrNJYOLEraLd5A=;
        b=DIEe9K3z1S1ReY6ZKBy5guty6474aRlSXzrOpvTTmYqk05p7qmawy/l2j6cIaO42Jy
         6qGOqZQj3l0LELq/Ne8jOciBac8P9vP1sDNopm851EjKMfjPsnIswYQ2PtclkcinCzdt
         R8hmkRWpPl5B+oKeGSBOFxciAbuvDhrYVgE3NFukK0QrReTgxA+eZvLGaJmDnZIEDnrI
         z62cd1dD+IX+tomX7uZPD8dBXUg3brqCjVhHyakcEX2CXd2l4arIjdPv5sj8Nv7W94cH
         yfM+AjgUsCE0XFxYzHLZLDgOcdAFNlSb8NUhBkB1r+9bs0oBY5m2ikihQ6ThjG0U9Dhw
         n+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577028; x=1790181828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MFUZqkMC5HU2RrjnHFq3xM9VTr/hsbrNJYOLEraLd5A=;
        b=GYRhwr/JUvQr82jGAUvvYtw1SyGMj5de+NuX7gNdKzCZT5OLe4mMxaN80VcTjikzn6
         WcER16W7N/G1oNcxVZpUfOEdOiOXblwC1E2ex8fGtFWSQhxnwAl6cSSxOQycXpLk//Rx
         +AbHOtObZF4znxmWBTZzPIKPF6+c+qvaURc0IE9dEevuiVSdOL+YS3LMyFEmfX3A0NYq
         5xOdiP+OVfpSkrPhL8KRa1B77180NcErJ/1/x3WczviJvrOdAr2YapKCca/sO9Y7p2Yf
         FEFUHM2HCnAj18NJN0pTjvOk1kzvCeJyi/2aXbwXfgHW9vwhipxDMFq1jqaiOCKaDsoF
         JdAA==
X-Gm-Message-State: AFuF++mMdgi2Y4VVGjNxii748HgD7zga3wQ+jhxyNzPQjmUDCi5hfQeP
	76azAPUz8ugYBuKt7+HYfMNZ0ZklxVV+tGLyWbFxNB3ReD99r2TNSjqiKxYKgoocjyw=
X-Gm-Gg: AYBFou31B7a78lkLdmoBW4EeqthsPh08s73aUIV0QPmtZt5fGL+GaWsryXK+lydmGyq
	yOV6kC7e/jjzIaIAHAFeC/OSLjVVkbmLwzprcE0QoV6ayoWRVE50bT8VxIIQDqtDLs/p+0bFq2I
	B4fNMSsDckV+/uEzMepjk36h0v1PVuk0W5V7p1T5Bdj33e5SatWvlZC6MsfOlr6lkrKDWg3KeI0
	fjM7CWaBEzszHoJWuPgwXRtWICRXbyly/Ge6zWsSxtP8xTR+PEd07acc3ypoauFBvM0doGB49i4
	N3hDZp3FxNeVA797tf4jBMl8feKGmx0pcz0IIT2JyETd3dje+5E7F1J8NJRuZb1oCAnixLHxYLl
	gJgzom/KxWcbTJn80JMSGPlI5WbL3EkBXBUP5qwMtvM2/gdw5L+/RoVKgWL8003CUukt5ib9MNi
	k6J/1t4dsivf0YEkInHduazcZZTawpcAEWZQ06mZHr36Z3gEyY6uTEd+ksBxvJJRyeT9tlD6EGw
	SJ2WZXaI/dDJuJ6y50FFsqFWA==
X-Received: by 2002:a05:6300:6708:b0:3d3:ae40:51e3 with SMTP id adf61e73a8af0-3dd5f702df7mr8337741637.23.1789577028021;
        Wed, 16 Sep 2026 09:43:48 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc757csm1902278a12.32.2026.09.16.09.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:43:47 -0700 (PDT)
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
Subject: [PATCH net-next v2 6/8] net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
Date: Thu, 17 Sep 2026 00:43:06 +0800
Message-ID: <20260916164310.3168269-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916164310.3168269-1-mmyangfl@gmail.com>
References: <20260916164310.3168269-1-mmyangfl@gmail.com>
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
index aac550bb4f72..e7fa5557ec81 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -598,9 +598,8 @@ static void yt921x_poll_mib(struct work_struct *work)
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
index b3670f1e1427..6652bb4304b7 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -999,6 +999,9 @@ struct yt921x_priv {
 	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
 };
 
+#define yt921x_port_to_priv(pp) \
+	container_of_const((pp), struct yt921x_priv, ports[(pp)->index])
+
 static inline int ethtool_speed_to_yt921x(int speed)
 {
 	switch (speed) {
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

