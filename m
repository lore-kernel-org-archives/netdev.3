Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B33264C8
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980779; cv=none; b=mzGQUYHqZ8WypiKa9DkAnxTIQgBHWL9o8kVIXKyVyu0/UsBeaQfGrzqqWm2da1kVPHS39iu1OsxC/GvnRI8HAUl46g0rfOMV4+YfwaoASr/4OwMIN8s5x6cvJzrkEWvWvIxJ4jS378YvA1VS7rWTdgOwNkHM91OIqSAOKFOysqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980779; c=relaxed/simple;
	bh=AA1XKuFsWbOGhsqN5VhG4cOUMQCdMAYYicvgwb2LxKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG2R1XHla916szIFjX+omfnW+KeJ9MjP14LlUYyAoW1TLYoBBollgoVOqVSsInCvKBHOaaV/cvUQWv2TZNteP/Giru0QMs44vMvYOU8o7339K84mt5SAM8i9fH+Rtu9jW0NzRJ5q4ea0iUJzCSKr4KYbFtUz+gGHiLOhJe5/DPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUwTzPaN; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUwTzPaN"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca06b03so10699315ad.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788980776; x=1789585576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bk+YtOMCSmx0TWEmBa1/4a0coFcVyJrJnWGNi0NAeBU=;
        b=SUwTzPaNK/6JY4fYojzcjkV9k9/cbl+6oYyD2/+x+x06OJyZi3RaWy3mqK3kkm/1Nb
         noaJEylP/wSoMa0CvY8fujp5tCTgHrUpOBiBzuWVB8VAj48PgdjQpvRegae84agvmXg/
         Qsggzk/A2XpfL8CCvDhu1TZNHY5QpLrAotz6969GJryUS9uV5AShH2NVMUXaeGL5bjIP
         F2NiHtPZshT//TF/ar9Zw64Eet5NU731a6K807oI/D5QESiWLBSYlTq6aKQz6fRNbMNC
         vOCWUdfSnKPSFeZvB1CbcxP6TEeFE1VnSPZS1pz6Ga2m2SYFrIO/ALtKmqrB2/yX6gSd
         r8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980776; x=1789585576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bk+YtOMCSmx0TWEmBa1/4a0coFcVyJrJnWGNi0NAeBU=;
        b=jQ8dvtlwsHNKDpUh910fVgetI1di+IPbzhlb8+KW1v/JegzYIQzFuT0U8BKr3TOJmE
         hItwoPGlyylQuqthKGheW9uezz7c8mmDbHUTn9HUhgusUo41YT+sMeqvLxUy8nlEMo9i
         IeFpZgh0CY8bODaREM/FOKVJjpz4IkBZNhXdFCEfMF3GB2iQu5lPqNMRdLhDRXb+UCCw
         wpa++P5TeASNs/CnZt7lRrnzd/mYM6nwr7PRYwV7ko/Ls94fvzf/i5jDZqFcXI3ZmGvM
         uLizjPqu8DZcaU+k/8PirUmFZ5upwZpvd+Tjgpk6w0I3tUC2jcl3pkZRWXtOEhLTTWIS
         mpRA==
X-Gm-Message-State: AFuF++lDhtwiaJGks3Gxk67A/9m5skO6wX+SX3kKlz42T6mY/zBaPYRJ
	ujEfilRl4OH+kjAUKe8fHgwQC9e8BPxTokxvzXrxX7Lxjs9c2He4BrhmjkIBfkr1XqY=
X-Gm-Gg: AYBFou13KsMeGKSWRn4tpOmCIwL1tW1X3dzkna2Ma8eBcn8u/S/KSdN4LFLOI9dFUk0
	Zy4/bDS3+MfpLLj93tbRH+iYDO51kzUvtemhB7kl49tYSJnJw3LuoqWtZeWkHvGu3DqYQ3xwwDW
	rf2Tf8whkVmyn/qNotFFEWATCqL7u6lpOl8tr9j2xcXeJLNZ3NbPKihjuLXYblP5jbjMFB4Xp+C
	mKhCoC1SOgC75GbBYzufIHPp57vW33jogYJhzx7t9U1PJgA+ZmwcEr6jdIQSMLZcviuql96TlHG
	zBuj0a3QvDSVq5ATUxQBT7BXJ+S59dOrW6eEzeoWW2QM9cAkXZEJQ+3C9LO4JiMlkCkTuhAwqDt
	gaw3CqjVCl+kl7DtkJq7360jbNxT0Ve1Gmz1rMdnY9D2KskoTo9pGe4DNf2av5ERko9Yeuz7A7i
	DuYptcGZ/FALoiGkZWe5qIoD1DOCtANrWG8QpcZ5bgXOW+4UGGV9YwidQSOI4QuNhZWuzxTOFh9
	3gkqbhVuT2FqCdUZuRu3QxH
X-Received: by 2002:a17:902:f68c:b0:2cf:7db9:e13e with SMTP id d9443c01a7336-2dd0e8c12bamr6879465ad.3.1788980775465;
        Wed, 09 Sep 2026 12:06:15 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4d0:7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dcffa9827dsm13988515ad.66.2026.09.09.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:06:15 -0700 (PDT)
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
Subject: [PATCH net-next 5/7] net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
Date: Thu, 10 Sep 2026 03:05:33 +0800
Message-ID: <20260909190541.466476-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190541.466476-1-mmyangfl@gmail.com>
References: <20260909190541.466476-1-mmyangfl@gmail.com>
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
index 0635359787db..beeb08f2b000 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -603,9 +603,8 @@ static void yt921x_poll_mib(struct work_struct *work)
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
index dd121ef2cbf5..b9a9e9d22d4b 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -1004,6 +1004,9 @@ struct yt921x_priv {
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

