Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7FA379C5F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130023; cv=none; b=eRzMdZTk8MwGP8l2Atr4l46lAicZh1je2pnuFATQdu9e7t2e1WHoJFkqsO1nyZJGy29OolAZ7mFvAR1PS38O5P7reKP7Qv8R83AYoMkjmGlTHk4Pw4kd0ytEke3fTDoBmaJ5tF/cnsJJilDT5T/UWAhiHLWmbPGXhrsuuBOugt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130023; c=relaxed/simple;
	bh=Xomkn+Srsksc9rJ4hB1Sw80030NagAwzSURN/+X4zrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bj4sJg98M7PWGYEtjW2q/iNjYsOe6v51GP1FYr9eXao/cjRLo16ghtoSgnvOy7vnPP3JqIXWfbTnwHQQBO1QRFc/ZblLeR2gbqWmMmeAGc4WJXN0nKjM/Hjhms4JBdtQaKb4P/UiQykfOyjWKYm7N5MMKhI+hN+rLopCPqyoQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbfMBNmy; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbfMBNmy"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c5so319496b3a.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790130022; x=1790734822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PwBq1Y5sOSoRLLcFFPEkua7arDxpIQDc0k7JtosP1rk=;
        b=QbfMBNmyeQlQj2lae2UC1CT5KCtaayh0tOaY2puZqROPVQYL1XaamNVlEuZRM7iCJq
         8cwKFUB/J4otdK609eG5VNoBbqwbFQzQqTTBZyVQgnRJZ0mauZlFdWu5IHoJx/hUZA20
         KxEo4KIgBSc44gXaLGZWor0OYqntnEQhBq2xtASIYoS59EeYZPBjW2Txv5vnIJPXOUkU
         n178KmGLbzVSnLs+LBAUyjq7/Ms80UE7OfLK6cEJ+ZhJTG9ZXDKPu2PhCnue3ABOIA2P
         NM0NX6ugiXqAfMMGkrDMvsGE6G+nvIpz6i1QZteFF8wSIQVP9//VRzeGtjsejJIoxbrR
         88cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790130022; x=1790734822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PwBq1Y5sOSoRLLcFFPEkua7arDxpIQDc0k7JtosP1rk=;
        b=kLdM0PBCEWfoWv5pPEVavk9QDy0jdEb1hasbTegwLbXEvdnmbCYXmlL3I+Q8Fb07If
         kCwsFdlqP1CuhI6iD1SPbf0V0qaiJOVUt0ZnALEUUnDg3IQuTXvKlytsy/3pdYNNa4x4
         JRnq+zY15DHG7S0WoK5kiDaEwTLxFZsp6JiF6FQyf3ay6JSKYbUvxrgrKrqSOLwhhsM3
         4OA+bg4x1ZzQcMOs8FzT24jfZJcu3bGQVW3meEsGdr7dnieHmEITK/hwyYNH+G5QzfxU
         /2NPxxxQ/uU+usyiHLkwuBWJGQhSYbvX4MaLIZXvTjwRrMx45hlPuSv9mFhQMoX7nykS
         pZdA==
X-Gm-Message-State: AFuF++noqEX/eV27EKF8jWCaIDQh5GVp4Wil5/fQhXiEKzdrPu1wNdpo
	V+dDGWRSlUy9IP3VnsWOoGhFgnkLLSekZYmUnWq3517VnFVrI3d411zb5lup3g==
X-Gm-Gg: AYBFou1MwmdEvGajKhS8sCMPX4dvuiIf5MNnr4r/oAuXL8SBiRn26kub8HWCAFKqor7
	Ir4scApmQ6CgxSagJPF09jjR2rYJ9wANQ8K72fhWE2F2Yq75AV4r7suRZ/6GRy219B1yPbZWfI+
	OqBUW2hDqe6S2tQFZFWyUwiuUW5q/zjI8YBBwcm3/ISh8jwXuUlINgIZhwHGXxu07W9Z47ziVYv
	TkZCvwOX/58/yAEGyd3MJAYVWVxtsb2rxXtn7atQfn3M5Arwa1cp/3gdhqrzC6mNeqJncXhzNCg
	HWIcXMaIa4V2R+d1mc4oUq/CTNBRrojiQekwjqT6Ws9R/ZZecznzwkCJNzQN4nAI3ItxCZcFPu/
	uWvQbapnttbVt2dymVAG8GROkllz0qMILU2zyVUIjTUG36d2X8jThgj4mSKN2NvRMiSzlo2cRI1
	GYkD2Q8Kb+eybbxfdTVPlb4DTcY/+ikBfMwlpnfGgpT367NGMq+p52NzF/dJimfASQwT8q0YWoB
	ppJvHfJqBCg9mnyIyuzEcbgC0GxW9BXxBIvAGwclnVP0Q==
X-Received: by 2002:a05:6a00:bb0e:b0:878:34d7:6a2f with SMTP id d2e1a72fcca58-87d1cdc1447mr1088739b3a.49.1790130021643;
        Tue, 22 Sep 2026 19:20:21 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fe8sm502924b3a.51.2026.09.22.19.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:20:21 -0700 (PDT)
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
Subject: [PATCH net-next v4 6/8] net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
Date: Wed, 23 Sep 2026 10:19:38 +0800
Message-ID: <20260923021945.2203368-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923021945.2203368-1-mmyangfl@gmail.com>
References: <20260923021945.2203368-1-mmyangfl@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c |  3 +--
 drivers/net/dsa/motorcomm/chip.h |  3 +++
 drivers/net/dsa/motorcomm/leds.c | 14 ++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 06e2c60b415f..ee433f1e1b58 100644
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
index 30d131eb9844..6a9fb27ddfb7 100644
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
index 0e8761f37995..6613fe3b0471 100644
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

