Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9A3C2774
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788151767; cv=none; b=SQwOn1oNKnWktnWjsGxzliwFirdcn9NHCz7PBmdH+WbD5xZgn5tV16Nt1ne8ARJGaejsggLVfTV+3I6Fr4mP2FSjzoMptPG2HVu2CAGpvQ8PkMR+qC7jnrDDYh5n2V8swHmmYyVEsEE9ouaV8eHrlcdZEl5VfRPo/HiW0uvtKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788151767; c=relaxed/simple;
	bh=rIR5M4CS7GYPcd3YX4roiE1OpfdY2TsQSUR49TdUP2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrWG8MHeumNLDaRfvpWdtFqso8ghRVDxI4B6tlb9hsBowU/Z6+Sv2PgoICP1cO320NoO9vufvPUYWgRMyvRaa4HSzJeS/qigU41Au+hDKN++NefW6x8ZQ9fKplv5W4RZ62QeNf2/Gm0UhxHpFBVtj9jHXs7NSGn1fkP6DMFpo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxgTXcjI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxgTXcjI"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398e9698a70so377327a91.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 21:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788151764; x=1788756564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLZ4hwmcvVsst2mUqlKomDK+CpgaHNA3NnIdsuzvGXo=;
        b=GxgTXcjI9qPFSSOQQdLYDpx0SJZkQjzJhDjpCZsvjKe78U0yO58vZyGrsHpmlW4DMh
         BpsMh1cBLIwH7U19OwlnvGijHZUt7yBJyWbAKdQOpNNBjvjbZy8ino+OeBd589hPu3LJ
         sZKJC/tc5KPDiB2lu8AdyfJxskZx6zgGI3JE72wom6COxkE1tI8o+Au7nlEWdQ120IrN
         oE1t0nh8EPQliMcuDrOnwwHUuYDszpNL1KFJabsf06yIKK6M/srkNqiQyJOCbAWYxHne
         AOpOxDgFxgQ86oxt4O9s6vEt3imX2ktgG5y38CHUg4XD4CxB63qVC/kJk96EEdUahlfE
         ii6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788151764; x=1788756564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLZ4hwmcvVsst2mUqlKomDK+CpgaHNA3NnIdsuzvGXo=;
        b=c2GUN4h1m800yrWaRpsF0A4TkXyIegFYp8WACFm5elQbzjlCY3NqafQJ/mhcJLcayd
         Y2iAjOM1gZq7EDrXlMpFRpPdozB9gXk2vZjJ1hcPj0W2hl35anhQH32xVF/j2r83tkKD
         WFvT7VYdJ9qJHnVb12ZYJDKmfIT8Rguh/bRt0Avn2+BwfCkv6k7byvICWnnHwvj6/JdI
         WdH9n5Cnyx7SytAJ138IxFGjmPHjUKXYOE6YRNPkb/LakJKCO4uYx+AyWo9dZtA8ZF6x
         h7lH2RS0mSUOEaNW6oJZFb+sJimG/6fKZl4pwAcqU2Pkenhn+PGZSRr1GslWLQBKZP8c
         bK4w==
X-Gm-Message-State: AFuF++k+HXycTloXVjbKtobziEn7f54Ao7HL6Qu+y8lJbUxBrBDAos+n
	yefxy0hC98Wbaw/GRLntVjdY7ZfkLi8RuduyG9kTYh1DElYmKOxQR7IgEBqNJw==
X-Gm-Gg: AYBFou2xJpDJSh3kS/tMgvoJOr+wYzXBhc3aV4ODiVDS1M+LwuaPVdQhe7/qXU+29GM
	0/uTxvp4BMbJyNyLV+PYMDuBJBWddZKw4OxkjScgWR94gekFKd9hPv7aBC4Pcs3+vAPTZ2gZorM
	lhWhWOSS6Acn/tU39YmLIv+Okw0Rnf9JvEdWDfSgVHjrUMeKWwKvvnouWIJ7HYbKe3MSlEkiCgt
	VGCS3HpLEXkDMphyl/RR+UHNBKLak/sctWBuCSE5MJ6giVIVruxwizC1kO+h8DnGxi5Q2ttp69R
	TTvI/KeJRV71gKlSJYOOyIXiYJ7XBlt4guS/6kn5JucOtFU8gaysyHbcCPnxUdagYQ8EgkFQ9xf
	ypVOMLcnJMOqDD96h9asjQAaDZqa5mqDS6SoFYRd/kNtjE2F6jzlbQ9/xaD0PWjfmwgfKpkAn2e
	8jJBLU+hxW6W/dG4gkdbeHCYXkVT5+UH91sTSEfw7Ga2TQudxhlnJDMP+/LAOJuD95ML7+0K/JM
	CxI2Kmma0obJ2k=
X-Received: by 2002:a17:90b:3c8c:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-396d0e7255bmr36800230a91.8.1788151763967;
        Sun, 30 Aug 2026 21:49:23 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:2e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm19345763a91.8.2026.08.30.21.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 21:49:23 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v11 4/5] net: dsa: motorcomm: Add LED support
Date: Mon, 31 Aug 2026 12:38:57 +0800
Message-ID: <20260831044818.4103477-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831044818.4103477-1-mmyangfl@gmail.com>
References: <20260831044818.4103477-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each port has at most 3 LEDs connected and can be declared using the
standard LEDs structure.

Currently, only parallel mode and strict 1:1 mapping (i.e. the HW
default) are supported.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/Kconfig  |   9 +
 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   |  19 +-
 drivers/net/dsa/motorcomm/chip.h   |  15 +
 drivers/net/dsa/motorcomm/leds.c   | 641 +++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h   | 118 ++++++
 6 files changed, 801 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h

diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
index 64ff7d07a91b..79cdd79a1fd2 100644
--- a/drivers/net/dsa/motorcomm/Kconfig
+++ b/drivers/net/dsa/motorcomm/Kconfig
@@ -6,3 +6,12 @@ config NET_DSA_YT921X
 	help
 	  This enables support for the Motorcomm YT9215 ethernet switch
 	  chip.
+
+config NET_DSA_YT921X_LEDS
+	bool "LED support for Motorcomm YT9215"
+	default y
+	depends on NET_DSA_YT921X
+	depends on LEDS_CLASS=y || LEDS_CLASS=NET_DSA_YT921X
+	help
+	  This enables support for controlling the LEDs attached to the
+	  Motorcomm YT9215 switch chips.
diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index 9fa24929007c..aeb12cb91f93 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 yt921x-objs := chip.o
+yt921x-$(CONFIG_NET_DSA_YT921X_LEDS) += leds.o
 yt921x-objs += smi.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 6dee25b6754a..d663af010f43 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -26,6 +26,7 @@
 #include <net/pkt_cls.h>
 
 #include "chip.h"
+#include "leds.h"
 #include "smi.h"
 
 struct yt921x_mib_desc {
@@ -151,8 +152,6 @@ static const struct yt921x_info yt921x_infos[] = {
 	{}
 };
 
-#define YT921X_NAME	"yt921x"
-
 #define YT921X_VID_UNWARE	4095
 
 /* The interval should be small enough to avoid overflow of 32bit MIBs.
@@ -4225,6 +4224,15 @@ static int yt921x_edata_read(struct yt921x_priv *priv, u8 addr, u8 *valp)
 	return yt921x_edata_read_cont(priv, addr, valp);
 }
 
+static void yt921x_dsa_teardown(struct dsa_switch *ds)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+	yt921x_leds_remove(priv);
+#endif
+}
+
 static int yt921x_chip_detect(struct yt921x_priv *priv)
 {
 	struct device *dev = to_device(priv);
@@ -4581,6 +4589,12 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	if (res)
 		return res;
 
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+	res = yt921x_leds_setup(priv);
+	if (res)
+		dev_warn(dev, "Failed to setup LEDs: %d\n", res);
+#endif
+
 	return 0;
 }
 
@@ -4661,6 +4675,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.port_add_dscp_prio	= yt921x_dsa_port_add_dscp_prio,
 #endif
 	/* chip */
+	.teardown		= yt921x_dsa_teardown,
 	.setup			= yt921x_dsa_setup,
 };
 
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 5f3b99e189c4..83cd454955dd 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -850,9 +850,14 @@ enum yt921x_fdb_entry_status {
 #define YT921X_ACL_NUM		(YT921X_ACL_BLK_NUM * YT921X_ACL_ENT_PER_BLK)
 #define YT921X_UDF_NUM		8
 
+#define YT921X_LED_GROUP_NUM	3
+#define YT921X_LED_PORT_NUM	10
+
 /* 8 internal + 2 external + 1 mcu */
 #define YT921X_PORT_NUM			11
 
+#define YT921X_NAME	"yt921x"
+
 #define yt921x_port_is_internal(port) ((port) < 8)
 #define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)
 
@@ -938,6 +943,16 @@ struct yt921x_port {
 	struct yt921x_mib mib;
 	u64 rx_frames;
 	u64 tx_frames;
+
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+	unsigned char led_duty;
+	unsigned short led_cycle;
+
+	unsigned char led_duty_mask;
+	unsigned char led_cycle_mask;
+
+	struct yt921x_led *leds[YT921X_LED_GROUP_NUM];
+#endif
 };
 
 struct yt921x_reg_ops {
diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm/leds.c
new file mode 100644
index 000000000000..7d3c0f68d8ff
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/leds.c
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include <linux/uleds.h>
+
+#include "chip.h"
+#include "leds.h"
+#include "smi.h"
+
+#define to_yt921x_led(led_cdev) \
+	container_of_const((led_cdev), struct yt921x_led, cdev)
+#define to_yt921x_port(led) ((led)->port)
+#define to_yt921x_priv(pp) \
+	container_of_const((pp), struct yt921x_priv, ports[(pp)->index])
+#define to_device(priv) ((priv)->ds.dev)
+
+static u32 yt921x_led_regaddr(struct yt921x_priv *priv, int port, int group)
+{
+	switch (group) {
+	case 0:
+	default:
+		return YT921X_LED0_PORTn(port);
+	case 1:
+		return YT921X_LED1_PORTn(port);
+	case 2:
+		return YT921X_LED2_PORTn(port);
+	}
+}
+
+static int
+yt921x_led_force_set(struct yt921x_priv *priv, int port, int group, bool on)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	u32 ctrl;
+	u32 mask;
+
+	/* No reversion - LED is sacrificed in case of IO error */
+	pp->led_duty_mask &= ~BIT(group);
+	pp->led_cycle_mask &= ~BIT(group);
+
+	mask = YT921X_LED2_PORT_FORCEn_M(group);
+	ctrl = on ? YT921X_LED2_PORT_FORCEn_ON(group) :
+	       YT921X_LED2_PORT_FORCEn_OFF(group);
+	return yt921x_reg_update_bits(priv, YT921X_LED2_PORTn(port), mask,
+				      ctrl);
+}
+
+static int
+yt921x_led_blink_select(const struct yt921x_priv *priv, unsigned long on,
+			unsigned long off, unsigned short *cyclep,
+			unsigned char *dutyp)
+{
+	static const unsigned char dutys[] = {
+		YT921X_LED_DUTY(1, 6),
+		YT921X_LED_DUTY(1, 4),
+		YT921X_LED_DUTY(1, 3),
+		YT921X_LED_DUTY(1, 2),
+	};
+	unsigned int cycle_upper;
+	unsigned int cycle_req;
+	unsigned int duty_req;
+	unsigned int cycle;
+	unsigned int duty;
+
+	cycle = YT921X_LED_BLINK_MAX;
+	cycle_upper = cycle * 11585 / 8192 + 1;  /* M_SQRT2 * cycle */
+	if (check_add_overflow(on, off, &cycle_req) || cycle_req >= cycle_upper)
+		return -EOPNOTSUPP;
+
+	for (; cycle > YT921X_LED_BLINK_MIN; cycle_upper >>= 1, cycle >>= 1)
+		if (cycle_req >= cycle_upper >> 1)
+			break;
+	*cyclep = cycle;
+
+	duty_req = DIV_ROUND_CLOSEST(YT921X_LED_DUTY_DENOM *
+				     (on > off ? off : on), cycle_req);
+	for (unsigned int i = ARRAY_SIZE(dutys) - 1;; i--)
+		if (i == 0 || duty_req >= (dutys[i - 1] + dutys[i]) / 2) {
+			duty = dutys[i];
+			break;
+		}
+	if (on > off)
+		duty = YT921X_LED_DUTY_DENOM - duty;
+	*dutyp = duty;
+
+	return 0;
+}
+
+static int
+yt921x_led_blink_set(struct yt921x_priv *priv, int port, int group,
+		     unsigned long *onp, unsigned long *offp)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	unsigned short cycle;
+	unsigned char duty;
+	bool use_cycle;
+	u32 ctrl;
+	u32 mask;
+	u32 val;
+	int res;
+
+	if (!*onp && !*offp) {
+		cycle = YT921X_LED_BLINK_DEF;
+		duty = (pp->led_duty_mask & ~BIT(group)) ? pp->led_duty :
+		       YT921X_LED_DUTY(1, 2);
+
+		use_cycle = false;
+	} else {
+		res = yt921x_led_blink_select(priv, *onp, *offp, &cycle, &duty);
+		if (res)
+			return res;
+
+		use_cycle = cycle < YT921X_LED_BLINK_DEF;
+
+		if (use_cycle && cycle != pp->led_cycle &&
+		    (pp->led_cycle_mask & ~BIT(group)))
+			return -EOPNOTSUPP;
+		if (duty != pp->led_duty && (pp->led_duty_mask & ~BIT(group)))
+			return -EOPNOTSUPP;
+	}
+
+	pp->led_cycle_mask &= ~BIT(group);
+	pp->led_duty_mask &= ~BIT(group);
+
+	/* The chip seems to jam a while if changing duty directly */
+	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &val);
+	if (res)
+		return res;
+
+	ctrl = val & ~YT921X_LED2_PORT_FORCEn_M(group);
+	ctrl |= YT921X_LED2_PORT_FORCEn_OFF(group);
+	if (val != ctrl) {
+		res = yt921x_reg_write(priv, YT921X_LED2_PORTn(port), ctrl);
+		if (res)
+			return res;
+	}
+
+	mask = YT921X_LED1_PORT_BLINK_DUTY_M | YT921X_LED1_PORT_BLINK_DUTY_COMP;
+	switch (duty >= YT921X_LED_DUTY(1, 2) ? duty :
+		YT921X_LED_DUTY_DENOM - duty) {
+	default:
+		duty = YT921X_LED_DUTY(1, 2);
+		fallthrough;
+	case YT921X_LED_DUTY(1, 2):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_1_2;
+		break;
+	case YT921X_LED_DUTY(2, 3):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_2_3;
+		break;
+	case YT921X_LED_DUTY(3, 4):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_3_4;
+		break;
+	case YT921X_LED_DUTY(5, 6):
+		ctrl = YT921X_LED1_PORT_BLINK_DUTY_5_6;
+		break;
+	}
+	if (duty < YT921X_LED_DUTY(1, 2))
+		ctrl |= YT921X_LED1_PORT_BLINK_DUTY_COMP;
+	if (use_cycle) {
+		mask |= YT921X_LED1_PORT_OTHER_BLINK_M;
+		ctrl |= YT921X_LED1_PORT_OTHER_BLINK(9 - __fls(cycle));
+	}
+	res = yt921x_reg_update_bits(priv, YT921X_LED1_PORTn(port), mask, ctrl);
+	if (res)
+		return res;
+
+	ctrl = val & ~(YT921X_LED2_PORT_FORCEn_M(group) |
+		       YT921X_LED2_PORT_FORCE_BLINKn_M(group));
+	ctrl |= YT921X_LED2_PORT_FORCEn_BLINK(group);
+	if (use_cycle)
+		ctrl |= YT921X_LED2_PORT_FORCE_BLINKn_OTHER(group);
+	else
+		ctrl |= YT921X_LED2_PORT_FORCE_BLINKn(group, __fls(cycle) - 9);
+	res = yt921x_reg_write(priv, YT921X_LED2_PORTn(port), ctrl);
+	if (res)
+		return res;
+
+	if (use_cycle) {
+		pp->led_cycle_mask |= BIT(group);
+		pp->led_cycle = cycle;
+	}
+	pp->led_duty_mask |= BIT(group);
+	pp->led_duty = duty;
+
+	*onp = DIV_ROUND_CLOSEST(duty * cycle, YT921X_LED_DUTY_DENOM);
+	*offp = cycle - *onp;
+	return 0;
+}
+
+struct yt921x_led_trigger_map {
+	unsigned long flags;
+	u32 mask;
+};
+
+static const struct yt921x_led_trigger_map yt921x_led_trigger_maps[] = {
+	{BIT(TRIGGER_NETDEV_LINK),
+	 YT921X_LEDx_PORT_ACT_DUPLEX_HALF | YT921X_LEDx_PORT_ACT_DUPLEX_FULL},
+	{BIT(TRIGGER_NETDEV_LINK_10), YT921X_LEDx_PORT_ACT_10M},
+	{BIT(TRIGGER_NETDEV_LINK_100), YT921X_LEDx_PORT_ACT_100M},
+	{BIT(TRIGGER_NETDEV_LINK_1000), YT921X_LEDx_PORT_ACT_1000M},
+	{BIT(TRIGGER_NETDEV_HALF_DUPLEX), YT921X_LEDx_PORT_ACT_DUPLEX_HALF},
+	{BIT(TRIGGER_NETDEV_FULL_DUPLEX), YT921X_LEDx_PORT_ACT_DUPLEX_FULL},
+	{BIT(TRIGGER_NETDEV_TX), YT921X_LEDx_PORT_ACT_TX_BLINK},
+	{BIT(TRIGGER_NETDEV_RX), YT921X_LEDx_PORT_ACT_RX_BLINK},
+	{BIT(TRIGGER_NETDEV_TX_ERR) | BIT(TRIGGER_NETDEV_RX_ERR),
+	 YT921X_LEDx_PORT_ACT_COLLISION_BLINK},
+};
+
+static bool
+yt921x_led_trigger_is_supported(const struct yt921x_priv *priv, int port,
+				int group, unsigned long flags)
+{
+	if (!flags)
+		return true;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(yt921x_led_trigger_maps); i++) {
+		const struct yt921x_led_trigger_map *map = &yt921x_led_trigger_maps[i];
+
+		if ((flags & map->flags) == map->flags) {
+			flags &= ~map->flags;
+			if (!flags)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static int
+yt921x_led_trigger_get(struct yt921x_priv *priv, int port, int group,
+		       unsigned long *flagsp)
+{
+	u32 addr;
+	u32 val;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &val);
+	if (res)
+		return res;
+
+	if ((val & YT921X_LED2_PORT_FORCEn_M(group)) !=
+	    YT921X_LED2_PORT_FORCEn_DONTCARE(group)) {
+		*flagsp = 0;
+		return 0;
+	}
+
+	if (group != 2) {
+		addr = yt921x_led_regaddr(priv, port, group);
+		res = yt921x_reg_read(priv, addr, &val);
+		if (res)
+			return res;
+	}
+
+	*flagsp = 0;
+	for (unsigned int i = 0; i < ARRAY_SIZE(yt921x_led_trigger_maps); i++) {
+		const struct yt921x_led_trigger_map *map = &yt921x_led_trigger_maps[i];
+
+		if ((val & map->mask) == map->mask)
+			*flagsp |= map->flags;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_led_trigger_set(struct yt921x_priv *priv, int port, int group,
+		       unsigned long flags)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	u32 addr;
+	u32 ctrl;
+	u32 mask;
+	int res;
+
+	ctrl = 0;
+	for (unsigned int i = 0; i < ARRAY_SIZE(yt921x_led_trigger_maps); i++) {
+		const struct yt921x_led_trigger_map *map = &yt921x_led_trigger_maps[i];
+
+		if ((flags & map->flags) == map->flags) {
+			flags &= ~map->flags;
+			ctrl |= map->mask;
+			if (!flags)
+				break;
+		}
+	}
+	if (flags)
+		return -EOPNOTSUPP;
+
+	pp->led_duty_mask &= ~BIT(group);
+	pp->led_cycle_mask &= ~BIT(group);
+
+	mask = !group ? YT921X_LED0_PORT_ACT_M : YT921X_LEDx_PORT_ACT_M;
+	if (group == 2) {
+		mask |= YT921X_LED2_PORT_FORCEn_M(group);
+		ctrl |= YT921X_LED2_PORT_FORCEn_DONTCARE(group);
+	}
+	addr = yt921x_led_regaddr(priv, port, group);
+	res = yt921x_reg_update_bits(priv, addr, mask, ctrl);
+	if (res)
+		return res;
+
+	if (group != 2) {
+		mask = YT921X_LED2_PORT_FORCEn_M(group);
+		ctrl = YT921X_LED2_PORT_FORCEn_DONTCARE(group);
+		res = yt921x_reg_update_bits(priv, YT921X_LED2_PORTn(port),
+					     mask, ctrl);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int
+yt921x_cled_brightness_set_blocking(struct led_classdev *led_cdev,
+				    enum led_brightness brightness)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_force_set(priv, pp->index, led->group, brightness);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_cled_blink_set(struct led_classdev *led_cdev, unsigned long *delay_on,
+		      unsigned long *delay_off)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_blink_set(priv, pp->index, led->group, delay_on,
+				   delay_off);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static struct device * __maybe_unused
+yt921x_cled_hw_control_get_device(struct led_classdev *led_cdev)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(&priv->ds, pp->index);
+	if (!dp)
+		return NULL;
+
+	if (dsa_port_is_user(dp))
+		return !dp->user ? NULL : &dp->user->dev;
+	if (dsa_port_is_cpu(dp))
+		return !dp->conduit ? NULL : &dp->conduit->dev;
+
+	return NULL;
+}
+
+static int __maybe_unused
+yt921x_cled_hw_control_is_supported(struct led_classdev *led_cdev,
+				    unsigned long flags)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+
+	if (yt921x_led_trigger_is_supported(priv, pp->index, led->group, flags))
+		return 0;
+	return -EOPNOTSUPP;
+}
+
+static int __maybe_unused
+yt921x_cled_hw_control_get(struct led_classdev *led_cdev, unsigned long *flagsp)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_trigger_get(priv, pp->index, led->group, flagsp);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int __maybe_unused
+yt921x_cled_hw_control_set(struct led_classdev *led_cdev, unsigned long flags)
+{
+	struct yt921x_led *led = to_yt921x_led(led_cdev);
+	struct yt921x_port *pp = to_yt921x_port(led);
+	struct yt921x_priv *priv = to_yt921x_priv(pp);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_led_trigger_set(priv, pp->index, led->group, flags);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int
+yt921x_led_setup(struct yt921x_priv *priv, int port,
+		 struct fwnode_handle *fwnode)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	struct device *dev = to_device(priv);
+	struct led_init_data init_data;
+	struct led_classdev *led_cdev;
+	char name[LED_MAX_NAME_SIZE];
+	enum led_default_state state;
+	struct yt921x_led *led;
+	bool force_high;
+	bool force_low;
+	u32 led2_val;
+	u32 inv_val;
+	u32 group;
+	u32 mask;
+	u32 ctrl;
+	bool on;
+	int res;
+	int ret;
+
+	res = fwnode_property_read_u32(fwnode, "reg", &group);
+	if (res) {
+		dev_err(dev, "Missing LED reg for %pfw\n", fwnode);
+		return res;
+	}
+	if (group >= YT921X_LED_GROUP_NUM) {
+		dev_err(dev, "Invalid LED reg %u for port %d\n", group, port);
+		return -EINVAL;
+	}
+	if (pp->leds[group]) {
+		res = -EEXIST;
+		goto err;
+	}
+
+	force_high = fwnode_property_read_bool(fwnode, "active-high");
+	force_low = fwnode_property_read_bool(fwnode, "active-low");
+	if (force_high && force_low) {
+		dev_err(dev, "Duplicate polarities for LED %02d:%02u\n",
+			port, group);
+		return -EINVAL;
+	}
+
+	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
+	if (!led) {
+		res = -ENOMEM;
+		goto err;
+	}
+	pp->leds[group] = led;
+
+	led->port = pp;
+	led->group = group;
+
+	state = led_init_default_state_get(fwnode);
+
+	mutex_lock(&priv->reg_lock);
+
+	/* Inversion is internal - force on will give low logic.
+	 * In the rest of the file, treat LEDs as if active-low.
+	 */
+	inv_val = U32_MAX;
+	if (force_high || force_low) {
+		res = yt921x_reg_read(priv, YT921X_LED_PAR_INV, &inv_val);
+		if (res)
+			goto revoke_inv;
+
+		mask = YT921X_LED_PAR_INV_INVnm(group, port);
+		ctrl = force_high ? inv_val | mask : inv_val & ~mask;
+		res = yt921x_reg_write(priv, YT921X_LED_PAR_INV, ctrl);
+		if (res)
+			goto revoke_inv;
+	}
+
+	led2_val = U32_MAX;
+	res = yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &led2_val);
+	if (res)
+		goto revoke_led2;
+	mask = YT921X_LED2_PORT_FORCEn_M(group);
+
+	switch (state) {
+	case LEDS_DEFSTATE_OFF:
+	case LEDS_DEFSTATE_ON:
+	default:
+		on = state == LEDS_DEFSTATE_ON;
+		ctrl = on ? YT921X_LED2_PORT_FORCEn_ON(group) :
+		       YT921X_LED2_PORT_FORCEn_OFF(group);
+		res = yt921x_reg_write(priv, YT921X_LED2_PORTn(port),
+				       (led2_val & ~mask) | ctrl);
+		if (res)
+			goto revoke_led2;
+		break;
+	case LEDS_DEFSTATE_KEEP:
+		on = (led2_val & mask) == YT921X_LED2_PORT_FORCEn_ON(group);
+		led2_val = U32_MAX;
+		break;
+	}
+
+	mutex_unlock(&priv->reg_lock);
+
+	led_cdev = &led->cdev;
+	led_cdev->brightness = on;
+	led_cdev->max_brightness = 1;
+	led_cdev->flags = LED_RETAIN_AT_SHUTDOWN;
+	led_cdev->brightness_set_blocking = yt921x_cled_brightness_set_blocking;
+	led_cdev->blink_set = yt921x_cled_blink_set;
+#ifdef CONFIG_LEDS_TRIGGERS
+	led_cdev->hw_control_trigger = "netdev";
+	led_cdev->hw_control_get_device = yt921x_cled_hw_control_get_device;
+	led_cdev->hw_control_is_supported = yt921x_cled_hw_control_is_supported;
+	led_cdev->hw_control_get = yt921x_cled_hw_control_get;
+	led_cdev->hw_control_set = yt921x_cled_hw_control_set;
+#endif
+
+	snprintf(name, sizeof(name), YT921X_NAME "-%u:%02d:%02u",
+		 priv->ds.index, port, group);
+	init_data = (typeof(init_data)){
+		.fwnode = fwnode,
+		.default_label = ":port",
+		.devicename = name,
+		.devname_mandatory = true,
+	};
+	res = devm_led_classdev_register_ext(dev, led_cdev, &init_data);
+	if (res)
+		goto revoke;
+
+	return 0;
+
+revoke:
+	mutex_lock(&priv->reg_lock);
+revoke_led2:
+	if (led2_val != U32_MAX) {
+		ret = yt921x_reg_write(priv, YT921X_LED2_PORTn(port), led2_val);
+		if (ret)
+			dev_err(dev,
+				"Failed to restore %s for LED %02d:%02u: %d\n",
+				"LED2_PORT", port, group, ret);
+	}
+revoke_inv:
+	if (inv_val != U32_MAX) {
+		ret = yt921x_reg_write(priv, YT921X_LED_PAR_INV, inv_val);
+		if (ret)
+			dev_err(dev,
+				"Failed to restore %s for LED %02d:%02u: %d\n",
+				"LED_PAR_INV", port, group, ret);
+	}
+	mutex_unlock(&priv->reg_lock);
+
+	pp->leds[group] = NULL;
+	devm_kfree(dev, led);
+
+err:
+	dev_err(dev, "Failed to initialize LED %02d:%02u: %d\n",
+		port, group, res);
+	return res;
+}
+
+static void yt921x_leds_remove_port(struct yt921x_priv *priv, int port)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	struct device *dev = to_device(priv);
+
+	for (int group = 0; group < YT921X_LED_GROUP_NUM; group++) {
+		struct yt921x_led *led = pp->leds[group];
+
+		if (led) {
+			devm_led_classdev_unregister(dev, &led->cdev);
+			pp->leds[group] = NULL;
+			devm_kfree(dev, led);
+		}
+	}
+
+	pp->led_duty_mask = 0;
+	pp->led_cycle_mask = 0;
+}
+
+static int yt921x_leds_setup_port(struct yt921x_priv *priv, int port)
+{
+	struct device *dev = to_device(priv);
+	struct dsa_switch *ds = &priv->ds;
+	struct device_node *leds_np;
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(ds, port);
+	leds_np = of_get_child_by_name(dp->dn, "leds");
+	if (!leds_np)
+		return 0;
+
+	if (port >= YT921X_LED_PORT_NUM) {
+		dev_err(dev, "Cannot configure LEDs for port %d\n", port);
+		of_node_put(leds_np);
+		return -EINVAL;
+	}
+
+	for_each_child_of_node_scoped(leds_np, led_np) {
+		yt921x_led_setup(priv, port, of_fwnode_handle(led_np));
+		/* Allow partial configuration: LEDs are optional */
+	}
+
+	of_node_put(leds_np);
+	return 0;
+}
+
+void yt921x_leds_remove(struct yt921x_priv *priv)
+{
+	for (int port = 0; port < YT921X_LED_PORT_NUM; port++)
+		yt921x_leds_remove_port(priv, port);
+}
+
+int yt921x_leds_setup(struct yt921x_priv *priv)
+{
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp;
+
+	/* LEDs are always enabled. There is no way to disable them altogether
+	 * (as far as I know).
+	 */
+
+	dsa_switch_for_each_port(dp, ds) {
+		int port = dp->index;
+
+		if (!dp->dn)
+			continue;
+
+		yt921x_leds_setup_port(priv, port);
+		/* Allow partial configuration: LEDs are optional */
+	}
+
+	return 0;
+}
diff --git a/drivers/net/dsa/motorcomm/leds.h b/drivers/net/dsa/motorcomm/leds.h
new file mode 100644
index 000000000000..11df479ee581
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/leds.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_LEDS_H
+#define _YT_LEDS_H
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/kconfig.h>
+#include <linux/leds.h>
+
+#define YT921X_LED_CTRL			0xd0000
+#define  YT921X_LED_CTRL_UNK			BIT(21)
+#define  YT921X_LED_CTRL_LOOPDETECT_BLINK_M	GENMASK(20, 19)	/* cycle = 512 * x ms */
+#define   YT921X_LED_CTRL_LOOPDETECT_BLINK(x)		FIELD_PREP(YT921X_LED_CTRL_LOOPDETECT_BLINK_M, (x))
+#define  YT921X_LED_CTRL_PORT_NUM_M		GENMASK(16, 13)
+#define   YT921X_LED_CTRL_PORT_NUM(x)			FIELD_PREP(YT921X_LED_CTRL_PORT_NUM_M, (x))
+#define  YT921X_LED_CTRL_MODE_M			GENMASK(1, 0)
+#define   YT921X_LED_CTRL_MODE(x)			FIELD_PREP(YT921X_LED_CTRL_MODE_M, (x))
+#define   YT921X_LED_CTRL_MODE_PARALLEL			YT921X_LED_CTRL_MODE(0)
+#define   YT921X_LED_CTRL_MODE_SERIAL			YT921X_LED_CTRL_MODE(2)
+#define YT921X_LED0_PORTn(port)		(0xd0004 + 4 * (port))
+#define  YT921X_LED0_PORT_ACT_M			GENMASK(17, 0)
+#define  YT921X_LED0_PORT_ACT_LINK_TRY_DIS	BIT(17)
+#define  YT921X_LED0_PORT_ACT_COLLISION_BLINK_INDI	BIT(16)
+#define YT921X_LED1_PORTn(port)		(0xd0040 + 4 * (port))
+#define  YT921X_LED1_PORT_OTHER_BLINK_M		GENMASK(31, 30)	/* cycle = 512 >> x ms */
+#define   YT921X_LED1_PORT_OTHER_BLINK(x)		FIELD_PREP(YT921X_LED1_PORT_OTHER_BLINK_M, (x))
+#define  YT921X_LED1_PORT_EEE_BLINK_M		GENMASK(29, 28)	/* cycle = 512 >> x ms */
+#define   YT921X_LED1_PORT_EEE_BLINK(x)			FIELD_PREP(YT921X_LED1_PORT_EEE_BLINK_M, (x))
+#define  YT921X_LED1_PORT_BLINK_DUTY_COMP	BIT(27)
+#define  YT921X_LED1_PORT_BLINK_DUTY_M		GENMASK(26, 25)
+#define   YT921X_LED1_PORT_BLINK_DUTY(x)		FIELD_PREP(YT921X_LED1_PORT_BLINK_DUTY_M, (x))
+#define   YT921X_LED1_PORT_BLINK_DUTY_1_2		YT921X_LED1_PORT_BLINK_DUTY(0)
+#define   YT921X_LED1_PORT_BLINK_DUTY_2_3		YT921X_LED1_PORT_BLINK_DUTY(1)
+#define   YT921X_LED1_PORT_BLINK_DUTY_3_4		YT921X_LED1_PORT_BLINK_DUTY(2)
+#define   YT921X_LED1_PORT_BLINK_DUTY_5_6		YT921X_LED1_PORT_BLINK_DUTY(3)
+#define YT921X_LED2_PORTn(port)		(0xd0080 + 4 * (port))
+#define  YT921X_LED2_PORT_FORCEn_M(grp)		GENMASK(4 * (grp) + 19, 4 * (grp) + 18)
+#define   YT921X_LED2_PORT_FORCEn(grp, x)		((x) << (4 * (grp) + 18))
+#define   YT921X_LED2_PORT_FORCEn_DONTCARE(grp)		YT921X_LED2_PORT_FORCEn(grp, 0)
+#define   YT921X_LED2_PORT_FORCEn_BLINK(grp)		YT921X_LED2_PORT_FORCEn(grp, 1)
+#define   YT921X_LED2_PORT_FORCEn_ON(grp)		YT921X_LED2_PORT_FORCEn(grp, 2)
+#define   YT921X_LED2_PORT_FORCEn_OFF(grp)		YT921X_LED2_PORT_FORCEn(grp, 3)
+#define  YT921X_LED2_PORT_FORCE_BLINKn_M(grp)	GENMASK(4 * (grp) + 17, 4 * (grp) + 16)	/* cycle = 512 << x ms */
+#define   YT921X_LED2_PORT_FORCE_BLINKn(grp, x)		((x) << (4 * (grp) + 16))
+#define   YT921X_LED2_PORT_FORCE_BLINKn_OTHER(grp)	YT921X_LED2_PORT_FORCE_BLINKn(grp, 3)
+#define  YT921X_LEDx_PORT_ACT_M			GENMASK(15, 0)
+#define  YT921X_LEDx_PORT_ACT_EEE_BLINK		BIT(15)
+#define  YT921X_LEDx_PORT_ACT_LOOPDETECT_BLINK	BIT(14)
+#define  YT921X_LEDx_PORT_ACT_ACTIVE_BLINK	BIT(13)
+#define  YT921X_LEDx_PORT_ACT_DUPLEX_FULL	BIT(12)
+#define  YT921X_LEDx_PORT_ACT_DUPLEX_HALF	BIT(11)
+#define  YT921X_LEDx_PORT_ACT_TX_BLINK		BIT(10)
+#define  YT921X_LEDx_PORT_ACT_RX_BLINK		BIT(9)
+#define  YT921X_LEDx_PORT_ACT_TX		BIT(8)
+#define  YT921X_LEDx_PORT_ACT_RX		BIT(7)
+#define  YT921X_LEDx_PORT_ACT_1000M		BIT(6)
+#define  YT921X_LEDx_PORT_ACT_100M		BIT(5)
+#define  YT921X_LEDx_PORT_ACT_10M		BIT(4)
+#define  YT921X_LEDx_PORT_ACT_COLLISION_BLINK	BIT(3)
+#define  YT921X_LEDx_PORT_ACT_1000M_BLINK	BIT(2)
+#define  YT921X_LEDx_PORT_ACT_100M_BLINK	BIT(1)
+#define  YT921X_LEDx_PORT_ACT_10M_BLINK		BIT(0)
+#define YT921X_LED_SER_CTRL		0xd0100
+#define  YT921X_LED_SER_CTRL_UNK		GENMASK(25, 24)	/* delay? */
+#define  YT921X_LED_SER_CTRL_ACTIVE_LOW		BIT(4)
+#define  YT921X_LED_SER_CTRL_GRP_NUM_M		GENMASK(1, 0)	/* #grp - 1 */
+#define   YT921X_LED_SER_CTRL_GRP_NUM(x)		FIELD_PREP(YT921X_LED_SER_CTRL_GRP_NUM_M, (x))
+#define YT921X_LED_SER_MAPnm(grp, port)	(0xd0104 + 8 * (2 - (grp)) + 4 * ((port) / 5))
+#define  YT921X_LED_SER_MAP_DSTn_PORT_M(port)	GENMASK(6 * ((port) % 5) + 5, 6 * ((port) % 5) + 2)
+#define   YT921X_LED_SER_MAP_DSTn_PORT(port, x)		((x) << (6 * ((port) % 5) + 2))
+#define  YT921X_LED_SER_MAP_DSTn_LED_M(port)	GENMASK(6 * ((port) % 5) + 1, 6 * ((port) % 5))
+#define   YT921X_LED_SER_MAP_DSTn_LED(port, x)		((x) << (6 * ((port) % 5)))
+#define YT921X_LED_PAR_PORTS		0xd01c4
+#define YT921X_LED_PAR_INV		0xd01c8
+#define  YT921X_LED_PAR_INV_INVnm(grp, port)	BIT(10 * (grp) + (port))
+#define YT921X_LED_PAR_MAPn(port)	(0xd01d0 + 4 * (port))
+#define  YT921X_LED_PAR_MAP_DSTn_PORT_M(grp)	GENMASK(6 * (grp) + 5, 6 * (grp) + 2)
+#define   YT921X_LED_PAR_MAP_DSTn_PORT(grp, x)		((x) << (6 * (grp) + 2))
+#define  YT921X_LED_PAR_MAP_DSTn_LED_M(grp)	GENMASK(6 * (grp) + 1, 6 * (grp))
+#define   YT921X_LED_PAR_MAP_DSTn_LED(grp, x)		((x) << (6 * (grp)))
+
+#define YT921X_LED_BLINK_MIN	64
+#define YT921X_LED_BLINK_DEF	512
+#define YT921X_LED_BLINK_MAX	2048
+
+/* 2 * lcm(2, 3, 4, 6) */
+#define YT921X_LED_DUTY_DENOM		24
+#define YT921X_LED_DUTY(nom, denom)	(YT921X_LED_DUTY_DENOM * (nom) / (denom))
+
+struct yt921x_priv;
+
+struct yt921x_led {
+	struct led_classdev cdev;
+	struct yt921x_port *port;
+	unsigned char group;
+};
+
+#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
+
+void yt921x_leds_remove(struct yt921x_priv *priv);
+int yt921x_leds_setup(struct yt921x_priv *priv);
+
+#else
+
+static inline void yt921x_leds_remove(struct yt921x_priv *priv) {}
+
+static inline int yt921x_leds_setup(struct yt921x_priv *priv)
+{
+	return 0;
+}
+
+#endif
+
+#endif
-- 
2.53.0

