Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE368253340
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739474; cv=none; b=JmIuDOekk3oQNOdmzidLW4Ah3c8EZSzW2Kjkuoxi/tdeem/BC1K1BIk/BvHLfc7qVene0MPv2vsFGNc9LWvTDxqYM6l+IUnIBJ9jWomJ/vaTgcB8GqEK2GCn/AwxNDvewZTiXsq5G8SBXauFdbWzpsj6heZKwQz3U50lFBlAAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739474; c=relaxed/simple;
	bh=zWz0HFm7WSXvV6EREyQ/osRgOV5NSnXG5mnS0Fdi/Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JIyVufF7Mv1v2xXPxWTkagQnEU2ipBYK21TO2IMQQ7/mLepB5DnNgD8r2LpX7Acoe9/mdMFalbH0HDUELksb/1+sebMo4nE7PhUqFsn3vdVP7nhe16YiqUbQsse6SAx3CP3qlcxBsmpbq7Ik9W3UZcRb9bfp5ip79HNK8EC5m+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zlingsmart.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=QIUPnBuR; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zlingsmart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="QIUPnBuR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uG
	hkCl0Es1lu3akM7R014ggMxD5lICZ+XQi5+v/7g5g=; b=QIUPnBuRweOsHsBO6Z
	UCLN3eFl1ImBeQXJLG9lNDtCHJvdjW1OX2NK7XUZakRIB7Xy9qyY7hIFgdXGwp6A
	XfHWkBP9mKfZPGGC88zg/P/vflbHyNkHscDCgcGDmbc3n7XV3ajNpaWT3SBU3r+E
	WMEaIx6RkzdaIajVV1HCvFx4Y=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnz+ooFrlpgpMwAA--.58550S2;
	Tue, 17 Mar 2026 16:51:52 +0800 (CST)
From: Liu Xiang <liu.xiang@zlingsmart.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Liu Xiang <liu.xiang@zlingsmart.com>
Subject: [PATCH] net: stmmac: avoid repeated devm_gpiod_get_optional in mdio reset on resume
Date: Tue, 17 Mar 2026 16:51:43 +0800
Message-Id: <20260317085143.140376-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz+ooFrlpgpMwAA--.58550S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr48AF18XrWDAryktFy5Arb_yoW8KF45p3
	y5Za4Yvrn7Jr18Jw4kXw48ZF95Kay7tr48u3WfK3ySga17tFZ0vryaqry3XFy7KrZ8uFya
	qr4UCF1Uuan0kwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUxhLUUUUU=
Sender: liuxiang_1999@126.com
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/xtbBrghYCWm5FigMrQAA34

During system resume, stmmac_resume() calls stmmac_mdio_reset().
This results in repeated calls to devm_gpiod_get_optional() for the same
GPIO. The second invocation returns an error since the GPIO descriptor has
already been obtained.

Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c  | 18 +++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 33667a267..34ebc6f3a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -372,6 +372,8 @@ struct stmmac_priv {
 	struct bpf_prog *xdp_prog;
 
 	struct devlink *devlink;
+
+	struct gpio_desc *reset_gpio;
 };
 
 enum stmmac_state {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index a7c2496b3..811ded1c5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -386,15 +386,15 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 
 #ifdef CONFIG_OF
 	if (priv->device->of_node) {
-		struct gpio_desc *reset_gpio;
 		u32 delays[3] = { 0, 0, 0 };
 
-		reset_gpio = devm_gpiod_get_optional(priv->device,
-						     "snps,reset",
-						     GPIOD_OUT_LOW);
-		if (IS_ERR(reset_gpio))
-			return PTR_ERR(reset_gpio);
-
+		if (!priv->reset_gpio) {
+			priv->reset_gpio = devm_gpiod_get_optional(priv->device,
+								   "snps,reset",
+								 GPIOD_OUT_LOW);
+			if (IS_ERR(priv->reset_gpio))
+				return PTR_ERR(priv->reset_gpio);
+		}
 		device_property_read_u32_array(priv->device,
 					       "snps,reset-delays-us",
 					       delays, ARRAY_SIZE(delays));
@@ -402,11 +402,11 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 		if (delays[0])
 			msleep(DIV_ROUND_UP(delays[0], 1000));
 
-		gpiod_set_value_cansleep(reset_gpio, 1);
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 		if (delays[1])
 			msleep(DIV_ROUND_UP(delays[1], 1000));
 
-		gpiod_set_value_cansleep(reset_gpio, 0);
+		gpiod_set_value_cansleep(priv->reset_gpio, 0);
 		if (delays[2])
 			msleep(DIV_ROUND_UP(delays[2], 1000));
 	}
-- 
2.34.1

