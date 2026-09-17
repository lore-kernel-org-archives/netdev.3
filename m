Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170634E0B73
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671143; cv=none; b=VTVKjNtyTc6ZeoUdsstdmUg4APdwLovAQEEpng/GIIN8Nbu4iRkw84rn4YCP7P7kKlJpYJ3VLn42nKD+uuqERjMKAv5tYInVZT5CCRrIPID1aLIWkBB74HJ95is/KChPWmR0TsVTL2H77u9LYVo1hkdzJWYu2QyvTHI1qC7G/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671143; c=relaxed/simple;
	bh=wa7JteC3r2unsWotGQCj8RSZpvy8xPFvd+PnrRKfCNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPE8imoTXuZD25c3i1+ToW9R1D4pN1+tQAcoz7YwRH9oAjuUeDLn7PJUrs7bKCt5slH1/u9ZhXKA+VwJUyDKtl2AyQjxqmPC8/Xh44vMIuag1GaR8Pom6JS7zeKhlDzcBzzXYKQMLMvEx9juNk3ylSCS4+6xRpONUWa7aTwzYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9NZcpCR; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9NZcpCR"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd77300825so12501985ad.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789671141; x=1790275941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Kri38BUKnkjofqEF/K1nnadfhRMk27GadV2uegZwdk=;
        b=K9NZcpCRdUc8qJM3IjtkgKDsT0iCpqHVaiIJ634sOtNvSGS9r6aQ6Fy2t12Af7e76z
         ABe51/HlHP8/mNRnKXmKDIkcTt95QBu1GlYxC48qbaVQbyHsCYDTHveotmy8YquM5qPJ
         pUk2CG7Ot7CHb58JCjtU+HAgkb8EGDSHIv9wQtu8k5EAH+1SO5Ekhg3BSxn8KrGXO8Rx
         //9enN/bOpB2IHah99qbZRcMybBYy9hiWZn9ZYOxLKBW61yw/pfkkgk08HQvfI2w+3SR
         Kvr9TRy1srLLlzRIKDBc6gk72VRKAItqjG/zVgw1QD2gbix+J14cSh0xCtv8jeNw9+Eg
         0Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789671141; x=1790275941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Kri38BUKnkjofqEF/K1nnadfhRMk27GadV2uegZwdk=;
        b=cjafL+TUhsub1+b+PK/yRMQTO1tLY4q2/y7K6RjJmcxoWb9+4WFeLpd5i6Mbn33eZ6
         YJTrtTVKqUTgkh756RGWx/rAQztA06OLHCja2eTWLAmwgVYAraS1oOOWOi0duXgxhwV0
         BRTomFoWl5iBzFgcNdpS1Cixx63UkbnxajLkSwKjy0OPioEF3tgvWlwhJ0jy0fJ7J6mZ
         fw3warIeXHAwhhVfRYu3+ZQsCU+dLMwOz9wRki2mF28/7VpJQbgdsa3vDYyDpsBzx5AS
         OVUEv5plIkZOX52npL3cokZbKnF2yoYopuOs3H8gh+L39KmkFHL0o10nsVOtBV0cta4T
         1GIw==
X-Gm-Message-State: AFuF++m3g3NnYlm4RF7gN11Sv0cqPmGZ+hxQ7+p0R96L7Znez2xyO8SR
	SfNVe4+FlnWQJXuvwH0a0+GsC1CGO6/IeeCiEi139iICXbBAgqJLoF0I1S5GxXS6
X-Gm-Gg: AYBFou3p1jSr6eILCvA4AADJrRmGrC7fQNJXG5vvGUAWIkLBA97w/L+ps/Ls+6znIeZ
	8nYzhgUmvuOM9MWX6AhZJWDZoTA7H0zs3UCa8xmzzJcvYMDN5QYqjKu7/B88qlpJFLvg96o0+AN
	rqKl3wjWziYiCwgJuJuCUmuzPjYT8KeVV9THTwC5kDnr/n05FSw/DJ4PjofPr6MQWCyUgxjDvcT
	/0xeytD97bBZLC+rmHVhseZ8SJKmajz3fEYiXV4KU0SSUaOaKEgI4CWjAZLwGRXi/YeiiV5sA4J
	INCzUamc+EFEvOHpyjJaRlng7NdFtcUSWMprMvABleA25Bnr1jTCXI59TLSvTgSJpzP1BpFBWLD
	6t1BP+aD/csT0IZL7yewnvYJRhSKXX/RaN3fN7sFnxyDWFgMGWbbogCft4nototk0HPQTI8Mhlo
	g3+23DX7G4IE7MyY1HlU0ypEMsd0OIn+pZDtvmXJ3JIGoz2dxJMJwsr4Tsnkb2LUIfYZC/6uIfP
	hQT+oat+BP0xH432M951FMnRQ==
X-Received: by 2002:a17:902:ce07:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2ddb1ab3254mr2717395ad.3.1789671141337;
        Thu, 17 Sep 2026 11:52:21 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f331b7sm31032655ad.82.2026.09.17.11.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:52:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 6/8] net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
Date: Fri, 18 Sep 2026 02:49:53 +0800
Message-ID: <20260917185010.3189199-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917185010.3189199-1-mmyangfl@gmail.com>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
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
index c99be2044fa2..7b61cab55e2c 100644
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

