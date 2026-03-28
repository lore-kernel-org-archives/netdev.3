Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74EAD5A
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774668374; cv=none; b=jLsFPeJVlfmfCyPNTmtCJayvW5NvaL4MjQBpWvuoWxXloCrWNYRR9GWdjnKZF9gR8W1phKwtaCPfj/7UfgM4+VlysZHiSnZvOzX0nrlfm4v+A45Ajtz1mTg3Nd9ZUmSC6JIUN4MKRo45yq+RLnIHodVFzOCKUXaNUefvi4aVmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774668374; c=relaxed/simple;
	bh=aGtM2G5H18NF180Q4acaKdPup6THs6S4PMVKe0ioDP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=liN3uw8x28uje4i7V/+5DQT3YC1byVyk5+Bdl+FXMtGzb6w0Ej1x1U50H8NzbSRTU1KW4LX26FRbrPz/KFejvLXYkDicsV/C+xGdliiGKVHPlMYPURJPK4MF81oI/04m9teCfuOSu4dw5eR8u8hXMHA3FQDHOWILV+ifMv+Et1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zlingsmart.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Pcw8yPbg; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zlingsmart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Pcw8yPbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=q3
	HwY57EtocswjGOeQJnWlQI9NRdeSFs2nUATsbjDBI=; b=Pcw8yPbgMS1Xb/FHiM
	z/f56L25E6nIgGDAOEnRseU77pSnJWK2KAdgRbIP2LmrU5Crr1iHpzkNTbJFbK8e
	k7/XbS3xXqMSk4IvyYyzlnkCTAx45/w4YhDvQxf4NuhbptTc3huJqYT9M9oKGI+z
	2ww8SErAEpNgepcuhmRP8Crn0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_1ojSsdp1ZpTAw--.16206S2;
	Sat, 28 Mar 2026 11:25:23 +0800 (CST)
From: Liu Xiang <liu.xiang@zlingsmart.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Liu Xiang <liu.xiang@zlingsmart.com>
Subject: [PATCH v2] net: stmmac: avoid repeated devm_gpiod_get_optional in mdio
Date: Sat, 28 Mar 2026 11:25:20 +0800
Message-Id: <20260328032520.7866-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_1ojSsdp1ZpTAw--.16206S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr48AF18XrWDAryktFy5Arb_yoW8KFyfp3
	y5Aa4Yqrn7Jr18tw4kXw48ZF95Kay7tr48u3WfG3ySga1UtrZ0vryaqry5XFyUKrZ8uFya
	qr4UCF1Uuan0kwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf-PUUUUUU=
Sender: liuxiang_1999@126.com
X-CM-SenderInfo: xolx5x5dqjsiqzzzqiyswou0bp/xtbBrgPml2nHSiNYwQAA3C

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
index a7c2496b3..d85cfb044 100644
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
+		if (IS_ERR_OR_NULL(priv->reset_gpio)) {
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

