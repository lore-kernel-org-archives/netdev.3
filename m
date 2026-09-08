Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376CF3F54D1
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911868; cv=none; b=dOkpxRk1DI9zIlTuuv8zyXjXjLddgDPfGMtJ5Irb3NZfcKyI3E4DMhZ6BzpPkJrYwjroSYputPVku1Qk1CiE4YJfYbvl3swfZGApVXK8JumhIVoAXF/s7WNiDF72zVdVvIt5tqpSU9qG9x3fNLk72o3gJKEbGMutiuRL4436SfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911868; c=relaxed/simple;
	bh=VJ0MPbI5xfD3ZMlJEXV8n8SUCJXzZf+olgXKzL2RilU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeERm38gk4coy46mfz4qaLvDrYpzoCJ3+eRHNLC3aORRHfcAhSnjCm01TfF6YU/bysLK4tEQnK7VgdUFek99E9OsDpVwQi622MybyRndFbrz2kgIM23kYo0IwiO/YIbqXq2Qr9KccZpxMXHj+CFXlbaahZ3vrBvfMyJ9VZFXyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEkwvInJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEkwvInJ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so4464301a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788911866; x=1789516666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WKYkqIAghiiLGuffdxjpe98PeRmDzJG3HnH417yBgeQ=;
        b=QEkwvInJIugz31zT7RAvjA27oL5HJPs1ncmheie7xNa2T2GT9WxxpR5T9JQHW4eC1q
         Wb3sobsxL2614npxZq2jrCm1wSwSCYyywA+75pqfUMAD5APyjyD8zi/TFjnhkAX9LQ/k
         aMsbFwr3AtYjOeK5IGUiM95A+Z7ziz2CJZUr8QxNhrhmFnhPJQ7yRe4uQW/SQsO++BRn
         we8AEjroVK3KyHxtQ8DYMZruuhxZYNf/wm3ZP64cxYVXDc+gFVxPH6HsB5THVtXdwknt
         I63PCGDbbxakmfiXT6d9MseWyNF7riG4F0vBJdTCImywnFwwYpbOptchiwJ6KgxeNdLs
         aTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788911866; x=1789516666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WKYkqIAghiiLGuffdxjpe98PeRmDzJG3HnH417yBgeQ=;
        b=RABtgX+BibvUJhULt1BkpDxBrDHb1yXE9FDiOxXOZjYweVMscSLZ7tqnR8zSbfHbZx
         r8ZwYTq8iuu5BF3avYhje4sGtKUqEUYC1v28PWMN2V7uPXaki3CHkfUS0vzVkO7EO9gG
         F7Jhigwe4e/LCETryFik7megmTGm/P6dBlR3H9suiGnVDE8T5SVABp2Vg5b4v46AAjYS
         uhXlxCMQepV7MlpShxj/PbUT7eD76mVE8mCcgQFmqX2le3toqtytxLUBdIRuGSyNAc34
         FzpvT97QaG/RpBTYhqA/b4bLQSOrdOhc1LQ1ENwOxXhLvtBG9XeB99A2KkXGWLceUR79
         wtgA==
X-Forwarded-Encrypted: i=1; AKwUvByZCsd2W4CIs0F/u4FCP6LhCq8k3l1/KZ8LqaCwoezPQBP8hpDu9DwlzzonTjDVWO3kiDYBYmA=@vger.kernel.org
X-Gm-Message-State: AFuF++nPPwimFxaD5RXhGJjrytraldRNhIIY8q6W7e0A2U+x/NhEdJma
	2eOsV+UoicTU8EvyIK9Zs4c4QbR7Vxf/f2YUU8Fu4zTIrbFEzVLXRxc=
X-Gm-Gg: AYBFou1S8Ed8TGaosou8FcbgyVZAmIwl+K2Hzjap5SzbKMlJJMvMD2IpWF5I5dG5Flv
	Vwg8qiqkZRAh/UV5PEjLApbxM+jJ6W4kZtOAYx3pxqOVYYAQLsT/CjklzSL3uIUHZJ6gOu2gVF8
	iewQ/1kR7onTVNe+szfhszSA9SfqlA7FmDyQWcPW51TVqB4lM4jJCRi/K6i+wZh3PPze7s6ThOM
	cCkuFmdfLeDSDuQjUq+y5S4xx4J7kiMXQOpVw77jhpBSsSMUEsusKk61/3j11GDYNG/ZwrBdXEC
	vbyHOs04Uh4sxxj3JhTz3AjoaWbbu8N1S6gsR2OKM0g7LutaIJvnOmURtb/748wRBDaa9rs/X4R
	2jerCF8lrEheT6UzzTdrC+PHlZiOYHLdylv6OaJLn6AWTWxth5AvBxAe8Y6iGPM58FHhW8eOdcP
	xs7QSgh940Jvx6Rj4zg1Ba3TMIEjV8aHW3Jx5QtbUFlxSCmYE//hbl6EClzP9Ofka8N9zYjabyZ
	BnlIcf07mnZpc4N
X-Received: by 2002:a05:6a20:db90:b0:3d3:ad3c:49a9 with SMTP id adf61e73a8af0-3da3a1c8619mr52311925637.23.1788911866396;
        Tue, 08 Sep 2026 16:57:46 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:f6ea:9d29:b387:9ed5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45e15604fsm5686176a12.0.2026.09.08.16.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:57:45 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH net v2] net: phy: dp83867: restore LED configuration after a soft reset
Date: Wed,  9 Sep 2026 08:57:40 +0900
Message-ID: <20260908235740.120112-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED configuration lives in LEDCR1 (the per-LED function nibble) and
LEDCR2 (per-LED driver enable/value and polarity). The driver programs it
through the LED class callbacks -- dp83867_led_brightness_set(),
dp83867_led_hw_control_set() and dp83867_led_polarity_set() -- either once
from device tree at probe, or at runtime from sysfs and the netdev trigger.

dp83867_phy_reset(), the .soft_reset callback, issues a global software
reset (CTRL SW_RESET), which the datasheet defines as resetting all
registers, including the extended registers, to their defaults.
phy_init_hw() runs .soft_reset before .config_init on every attach and
resume -- phy_attach_direct(), mdio_bus_phy_resume() and MAC drivers -- so
the LED configuration is wiped from the first attach onward and never
restored. A device-tree polarity is lost, a manually driven LED goes dark,
and an LED offloaded to the netdev trigger whose link stays down after a
resume keeps the reset-default function until the next link event.

Shadow what the LED callbacks program, as a value and a written-bits mask
per register, and replay it from config_init(), which runs right after the
soft reset. Only bits the driver actually set are restored.

The callbacks run under phydev->lock, but config_init() must not take it:
the cable-test abort path in phy_state_machine() already holds phydev->lock
when it reaches phy_init_hw(), so config_init() taking it would deadlock.
Serialize the shadow and its replay with a dedicated lock instead.

Fixes: 938f65adc420 ("net: phy: dp83867: Add led_brightness_set support")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
v1 restored only the polarity bit. Andrew Lunn pointed out that the soft
reset drops the other LEDCR2 bits too, and the datasheet confirms it also
clears the LEDCR1 function nibble, so v2 shadows and restores the full LED
configuration.

v2:
  - Restore LEDCR1 (function) and the LEDCR2 driver-enable/value bits as
    well as the polarity, via a value-plus-mask shadow updated in the LED
    callbacks and replayed in config_init().
  - Serialize the shadow with a dedicated lock; config_init() cannot take
    phydev->lock because the cable-test abort path already holds it across
    phy_init_hw().
  - A failed LED restore now warns instead of failing phy_init_hw().

Compile-tested with W=1 only; I have no affected hardware.

v1: https://lore.kernel.org/netdev/20260908114901.74637-1-donggeunyoo.kernel@gmail.com/
---
 drivers/net/phy/dp83867.c | 111 +++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 88255e92b4cd..eeb4cd648f74 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/delay.h>
@@ -196,6 +197,16 @@ struct dp83867_private {
 	bool set_clk_output;
 	u32 clk_output_sel;
 	bool sgmii_ref_clk_en;
+
+	/* Shadow of the LED registers, replayed after a soft reset. led_lock
+	 * serializes the shadow and its replay against the LED callbacks,
+	 * because dp83867_config_init() does the replay off phydev->lock.
+	 */
+	struct mutex led_lock;
+	u16 ledcr1;
+	u16 ledcr1_mask;
+	u16 ledcr2;
+	u16 ledcr2_mask;
 };
 
 static int dp83867_ack_interrupt(struct phy_device *phydev)
@@ -722,6 +733,7 @@ static int dp83867_resume(struct phy_device *phydev)
 static int dp83867_probe(struct phy_device *phydev)
 {
 	struct dp83867_private *dp83867;
+	int ret;
 
 	dp83867 = devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83867),
 			       GFP_KERNEL);
@@ -730,9 +742,60 @@ static int dp83867_probe(struct phy_device *phydev)
 
 	phydev->priv = dp83867;
 
+	ret = devm_mutex_init(&phydev->mdio.dev, &dp83867->led_lock);
+	if (ret)
+		return ret;
+
 	return dp83867_of_init(phydev);
 }
 
+/* Update an LED register and mirror the change into the shadow, so that
+ * dp83867_config_init() can replay it after a soft reset. Caller must hold
+ * dp83867->led_lock.
+ */
+static int __dp83867_led_modify(struct phy_device *phydev, u32 reg,
+				u16 mask, u16 val)
+{
+	struct dp83867_private *dp83867 = phydev->priv;
+	int ret;
+
+	ret = phy_modify(phydev, reg, mask, val);
+	if (ret)
+		return ret;
+
+	if (reg == DP83867_LEDCR1) {
+		dp83867->ledcr1 = (dp83867->ledcr1 & ~mask) | (val & mask);
+		dp83867->ledcr1_mask |= mask;
+	} else if (reg == DP83867_LEDCR2) {
+		dp83867->ledcr2 = (dp83867->ledcr2 & ~mask) | (val & mask);
+		dp83867->ledcr2_mask |= mask;
+	} else {
+		WARN_ON_ONCE(1);
+	}
+
+	return 0;
+}
+
+/* Restore the LED registers the driver has programmed, cleared by the soft
+ * reset in dp83867_phy_reset().
+ */
+static int dp83867_led_restore(struct phy_device *phydev)
+{
+	struct dp83867_private *dp83867 = phydev->priv;
+	int ret = 0;
+
+	mutex_lock(&dp83867->led_lock);
+	if (dp83867->ledcr1_mask)
+		ret = phy_modify(phydev, DP83867_LEDCR1,
+				 dp83867->ledcr1_mask, dp83867->ledcr1);
+	if (!ret && dp83867->ledcr2_mask)
+		ret = phy_modify(phydev, DP83867_LEDCR2,
+				 dp83867->ledcr2_mask, dp83867->ledcr2);
+	mutex_unlock(&dp83867->led_lock);
+
+	return ret;
+}
+
 static int dp83867_config_init(struct phy_device *phydev)
 {
 	struct dp83867_private *dp83867 = phydev->priv;
@@ -896,6 +959,10 @@ static int dp83867_config_init(struct phy_device *phydev)
 			       mask, val);
 	}
 
+	ret = dp83867_led_restore(phydev);
+	if (ret)
+		phydev_warn(phydev, "failed to restore LED config: %d\n", ret);
+
 	return 0;
 }
 
@@ -1004,7 +1071,9 @@ static int
 dp83867_led_brightness_set(struct phy_device *phydev,
 			   u8 index, enum led_brightness brightness)
 {
-	u32 val;
+	struct dp83867_private *dp83867 = phydev->priv;
+	u16 val;
+	int ret;
 
 	if (index >= DP83867_LED_COUNT)
 		return -EINVAL;
@@ -1015,10 +1084,13 @@ dp83867_led_brightness_set(struct phy_device *phydev,
 	if (brightness)
 		val |= DP83867_LED_DRV_VAL(index);
 
-	return phy_modify(phydev, DP83867_LEDCR2,
-			  DP83867_LED_DRV_VAL(index) |
-			  DP83867_LED_DRV_EN(index),
-			  val);
+	mutex_lock(&dp83867->led_lock);
+	ret = __dp83867_led_modify(phydev, DP83867_LEDCR2,
+				   DP83867_LED_DRV_VAL(index) |
+				   DP83867_LED_DRV_EN(index), val);
+	mutex_unlock(&dp83867->led_lock);
+
+	return ret;
 }
 
 static int dp83867_led_mode(u8 index, unsigned long rules)
@@ -1069,18 +1141,24 @@ static int dp83867_led_hw_is_supported(struct phy_device *phydev, u8 index,
 static int dp83867_led_hw_control_set(struct phy_device *phydev, u8 index,
 				      unsigned long rules)
 {
+	struct dp83867_private *dp83867 = phydev->priv;
 	int mode, ret;
 
 	mode = dp83867_led_mode(index, rules);
 	if (mode < 0)
 		return mode;
 
-	ret = phy_modify(phydev, DP83867_LEDCR1, DP83867_LED_FN_MASK(index),
-			 DP83867_LED_FN(index, mode));
-	if (ret)
-		return ret;
-
-	return phy_modify(phydev, DP83867_LEDCR2, DP83867_LED_DRV_EN(index), 0);
+	mutex_lock(&dp83867->led_lock);
+	ret = __dp83867_led_modify(phydev, DP83867_LEDCR1,
+				   DP83867_LED_FN_MASK(index),
+				   DP83867_LED_FN(index, mode));
+	if (!ret)
+		ret = __dp83867_led_modify(phydev, DP83867_LEDCR2,
+					   DP83867_LED_DRV_EN(index) |
+					   DP83867_LED_DRV_VAL(index), 0);
+	mutex_unlock(&dp83867->led_lock);
+
+	return ret;
 }
 
 static int dp83867_led_hw_control_get(struct phy_device *phydev, u8 index,
@@ -1141,9 +1219,11 @@ static int dp83867_led_hw_control_get(struct phy_device *phydev, u8 index,
 static int dp83867_led_polarity_set(struct phy_device *phydev, int index,
 				    unsigned long modes)
 {
+	struct dp83867_private *dp83867 = phydev->priv;
 	/* Default active high */
 	u16 polarity = DP83867_LED_POLARITY(index);
 	u32 mode;
+	int ret;
 
 	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
 		switch (mode) {
@@ -1154,8 +1234,13 @@ static int dp83867_led_polarity_set(struct phy_device *phydev, int index,
 			return -EINVAL;
 		}
 	}
-	return phy_modify(phydev, DP83867_LEDCR2,
-			  DP83867_LED_POLARITY(index), polarity);
+
+	mutex_lock(&dp83867->led_lock);
+	ret = __dp83867_led_modify(phydev, DP83867_LEDCR2,
+				   DP83867_LED_POLARITY(index), polarity);
+	mutex_unlock(&dp83867->led_lock);
+
+	return ret;
 }
 
 static unsigned int dp83867_inband_caps(struct phy_device *phydev,
-- 
2.53.0

