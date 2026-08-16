Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99C3C8C65
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786909188; cv=none; b=MokAdpdI5BIuW2S2rGWlQ765qq8aKFPkxRX9H8WIVqQTc3j6HmJF9mX6de+dSkHpk6fz8IpurPP6BIjo4aZcDQ30awUW1RSQBPJtQg8B/NCbw8aufGfR+0IRQVnBg8H9/urLCGaJa8QHQ//bB6vzOMBE777Zj2GUVC3MVUtcPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786909188; c=relaxed/simple;
	bh=eEcN1HXPyBaQGvYWryjFTWu7HvxXkOWR9Ns4Hw2kwNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIP8dTkzcb8HOdecercncs2FtWmIWigO4oHgbl3s0V7FtYyfcwm185iZmG9efN3RbRJithZY884O9vX5ykjwNeYmtr2dBZ17O0AemQ/fcHDuQYvjX8nFJ8F5OXEVCE7SrRnTeoHEJRarDS8ImXBiuuU4rh75FtfQmAuq4oDyjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h++h8zO1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h++h8zO1"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2563525a12.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786909183; x=1787513983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fr1adCZarShVnf0lDmjhW7xvO8QbtTma3JXt+bfZWsA=;
        b=h++h8zO1PAMGT9xJauZYAnQm/R/lW0KlpcHe13MXu0ptLo7150EaI/RhbDXEnqtw7H
         VhI0K0GOhanbNLI9K3H/TaafxWaDEQE3WSgcxzaxadBjVxYCyqf8e3LMpTlx1FQw9N+C
         x0ECms3zX5wGO1WiBXp+U/lDtZJYhba5mW8E60OYz1d57jBr1jDtGjP+4kl9rGdMTIri
         yPqetHejaIw3jGJBPrGdI09e4nRucxFQUuQRqSRvrMu/ZTMCmYWI7HEXQlqmbifwcBJf
         LiV0gWXt3M+4uQDL6n4zN8//fGchCbeKzWBswog7TUrLyPIVWc9hI+eXASq0YfsicZID
         eZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786909183; x=1787513983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fr1adCZarShVnf0lDmjhW7xvO8QbtTma3JXt+bfZWsA=;
        b=TOksTyUMASxblOhglIYG3coHwiw/2t5LLRJS9ZrcJvWldfy8NFKa2VYJdDWAZYH8/O
         tsCzT0WRxplTMPwSHVJ8OC47bzOmbesYkCL5dkAOA21iYlEGN8dYLm0ooVDqzDYXwTI4
         oi9fF1u9Xkary5Lf/BgBy5weO/tn86KIBXTaTXWonDq+xWUJth2VdUsiFLOuolGwn40g
         ZK1ZSAv/s057p1QGciQmaRm57xZmGAhkcAbKbgTWqM9Z9FuTzqCMKsn0ulZftRTo+h3X
         ePdbt9rqZ5HfcDwxkxtz8gx7FJNQnUtReONJ0CXzatGkjxY3+1CxOG+osyEnTxHldSOK
         ejcw==
X-Gm-Message-State: AOJu0YwP9AWc++hOvHeqW21nGTHlSKJ5naDgMpGoDioVFC//sHmiHXGq
	VNhj4MjnexFt3wrJMgDn5L7mP6tYIxA+unA2UoRmSCQlRVVf7vlY+baEohALpQ==
X-Gm-Gg: AR+sD10RnfvRXpKtY6MudlsEnZLtWFZC6bIw7Hrf09QdLNYisKEntOFw12Flg9B9FHU
	uQzQuQhNKkFLequ7tzqjOg4xvJeR3wJ9oE/OI78ubac0wEVQYMeeaDTD4Ki6xnfB4oTEVsKuB9v
	Ta+LHb2rA2lrj0wR2AgnhE0kz2qBPU72xogH1Hj/CU7MO+xlMd/77u3hT2ZqmxZkgN/KmuO2IUf
	wl6RRb6xlVsq0l10VwXZzgh9DPZMkFN6YuB/mDWFcGnpzL2O25cm2ET9+4m+C8EZ2U7wxvNJvBi
	StuHSbOXRHiHRqBeykRFBBptnQiip+2YQuy12jPlAron7HFk3JAaLGUMaYEs1vVPl+DcOu+ejn3
	/fJXnzU0WHpCjH0Spkgrxo10rtVU8MPT9uL0TWYhyh6Iam3WipWdiUaed0aspmkPLq6DaCFhImg
	pNdXxtd8Hk/D0yCudc77DaIT2qQSaItP8kPAfJ54VlNAa88E+bh2+a9fu1IUlaxw3C/WCyihHGx
	7FVSCUmiyAaBg==
X-Received: by 2002:a17:90a:d610:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-3933af03952mr15499145a91.2.1786909182974;
        Sun, 16 Aug 2026 12:39:42 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:1a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e10d9fsm2244065a91.3.2026.08.16.12.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 12:39:42 -0700 (PDT)
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
Subject: [PATCH net-next v10 2/4] net: dsa: motorcomm: Split SMI module
Date: Mon, 17 Aug 2026 03:38:57 +0800
Message-ID: <20260816193905.218112-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816193905.218112-1-mmyangfl@gmail.com>
References: <20260816193905.218112-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMI operations are going to be used across different modules. Minor
changes are applied to fix build errors.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   | 207 +----------------------------
 drivers/net/dsa/motorcomm/smi.c    | 157 ++++++++++++++++++++++
 drivers/net/dsa/motorcomm/smi.h    |  92 +++++++++++++
 4 files changed, 251 insertions(+), 206 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h

diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index afd03be9fa35..6cea5313a444 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: ISC
 obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 yt921x-objs := chip.o
+yt921x-objs += smi.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index f070732845eb..6dee25b6754a 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -13,7 +13,6 @@
 #include <linux/if_bridge.h>
 #include <linux/if_hsr.h>
 #include <linux/if_vlan.h>
-#include <linux/iopoll.h>
 #include <linux/mdio.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -27,6 +26,7 @@
 #include <net/pkt_cls.h>
 
 #include "chip.h"
+#include "smi.h"
 
 struct yt921x_mib_desc {
 	unsigned int size;
@@ -155,9 +155,6 @@ static const struct yt921x_info yt921x_infos[] = {
 
 #define YT921X_VID_UNWARE	4095
 
-#define YT921X_POLL_SLEEP_US	10000
-#define YT921X_POLL_TIMEOUT_US	100000
-
 /* The interval should be small enough to avoid overflow of 32bit MIBs.
  *
  * Until we can read MIBs from stats64 call directly (i.e. sleep
@@ -196,208 +193,6 @@ static u32 ethaddr_lo2_to_u32(const unsigned char *addr)
 	return (addr[4] << 8) | addr[5];
 }
 
-static int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
-{
-	WARN_ON(!mutex_is_locked(&priv->reg_lock));
-
-	return priv->reg_ops->read(priv->reg_ctx, reg, valp);
-}
-
-static int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
-{
-	WARN_ON(!mutex_is_locked(&priv->reg_lock));
-
-	return priv->reg_ops->write(priv->reg_ctx, reg, val);
-}
-
-static int
-yt921x_reg_wait(struct yt921x_priv *priv, u32 reg, u32 mask, u32 *valp)
-{
-	u32 val;
-	int res;
-	int ret;
-
-	ret = read_poll_timeout(yt921x_reg_read, res,
-				res || (val & mask) == *valp,
-				YT921X_POLL_SLEEP_US, YT921X_POLL_TIMEOUT_US,
-				false, priv, reg, &val);
-	if (ret)
-		return ret;
-	if (res)
-		return res;
-
-	*valp = val;
-	return 0;
-}
-
-static int
-yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
-{
-	int res;
-	u32 v;
-	u32 u;
-
-	res = yt921x_reg_read(priv, reg, &v);
-	if (res)
-		return res;
-
-	u = v;
-	u &= ~mask;
-	u |= val;
-	if (u == v)
-		return 0;
-
-	return yt921x_reg_write(priv, reg, u);
-}
-
-static int yt921x_reg_set_bits(struct yt921x_priv *priv, u32 reg, u32 mask)
-{
-	return yt921x_reg_update_bits(priv, reg, 0, mask);
-}
-
-static int yt921x_reg_clear_bits(struct yt921x_priv *priv, u32 reg, u32 mask)
-{
-	return yt921x_reg_update_bits(priv, reg, mask, 0);
-}
-
-static int
-yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
-{
-	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
-}
-
-/* Some multi-word registers, like VLANn_CTRL, should be treated as a single
- * long register. More specifically, writes to parts of its words won't become
- * visible, until the last word is written.
- *
- * Here we require full read and write operations over these registers to
- * eliminate potential issues, although partial reads/writes are also possible.
- */
-
-static void update_ctrls_unaligned(u32 *lo, u32 *hi, u64 mask, u64 val)
-{
-	*lo &= ~lower_32_bits(mask);
-	*hi &= ~upper_32_bits(mask);
-	*lo |= lower_32_bits(val);
-	*hi |= upper_32_bits(val);
-}
-
-static int
-yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
-		 unsigned int num_regs)
-{
-	int res;
-
-	for (unsigned int i = 0; i < num_regs; i++) {
-		res = yt921x_reg_read(priv, reg + 4 * i, &vals[i]);
-		if (res)
-			return res;
-	}
-
-	return 0;
-}
-
-static int
-yt921x_regs_write(struct yt921x_priv *priv, u32 reg, const u32 *vals,
-		  unsigned int num_regs)
-{
-	int res;
-
-	for (unsigned int i = 0; i < num_regs; i++) {
-		res = yt921x_reg_write(priv, reg + 4 * i, vals[i]);
-		if (res)
-			return res;
-	}
-
-	return 0;
-}
-
-static int
-yt921x_regs_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
-			const u32 *vals, unsigned int num_regs)
-{
-	bool changed = false;
-	u32 vs[4];
-	int res;
-
-	BUILD_BUG_ON(num_regs > ARRAY_SIZE(vs));
-
-	res = yt921x_regs_read(priv, reg, vs, num_regs);
-	if (res)
-		return res;
-
-	for (unsigned int i = 0; i < num_regs; i++) {
-		u32 u = vs[i];
-
-		u &= ~masks[i];
-		u |= vals[i];
-		if (u != vs[i])
-			changed = true;
-
-		vs[i] = u;
-	}
-
-	if (!changed)
-		return 0;
-
-	return yt921x_regs_write(priv, reg, vs, num_regs);
-}
-
-static int
-yt921x_regs_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
-		       unsigned int num_regs)
-{
-	bool changed = false;
-	u32 vs[4];
-	int res;
-
-	BUILD_BUG_ON(num_regs > ARRAY_SIZE(vs));
-
-	res = yt921x_regs_read(priv, reg, vs, num_regs);
-	if (res)
-		return res;
-
-	for (unsigned int i = 0; i < num_regs; i++) {
-		u32 u = vs[i];
-
-		u &= ~masks[i];
-		if (u != vs[i])
-			changed = true;
-
-		vs[i] = u;
-	}
-
-	if (!changed)
-		return 0;
-
-	return yt921x_regs_write(priv, reg, vs, num_regs);
-}
-
-static int
-yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
-{
-	return yt921x_regs_write(priv, reg, vals, 2);
-}
-
-static int
-yt921x_reg64_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
-			 const u32 *vals)
-{
-	return yt921x_regs_update_bits(priv, reg, masks, vals, 2);
-}
-
-static int
-yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks)
-{
-	return yt921x_regs_clear_bits(priv, reg, masks, 2);
-}
-
-static int
-yt921x_reg96_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
-{
-	return yt921x_regs_write(priv, reg, vals, 3);
-}
-
 static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
 {
 	struct yt921x_reg_mdio *mdio = context;
diff --git a/drivers/net/dsa/motorcomm/smi.c b/drivers/net/dsa/motorcomm/smi.c
new file mode 100644
index 000000000000..164c25ef494a
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/smi.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include <linux/iopoll.h>
+
+#include "chip.h"
+#include "smi.h"
+
+#define YT921X_POLL_SLEEP_US	10000
+#define YT921X_POLL_TIMEOUT_US	100000
+
+int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
+{
+	WARN_ON(!mutex_is_locked(&priv->reg_lock));
+
+	return priv->reg_ops->read(priv->reg_ctx, reg, valp);
+}
+
+int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
+{
+	WARN_ON(!mutex_is_locked(&priv->reg_lock));
+
+	return priv->reg_ops->write(priv->reg_ctx, reg, val);
+}
+
+int yt921x_reg_wait(struct yt921x_priv *priv, u32 reg, u32 mask, u32 *valp)
+{
+	u32 val;
+	int res;
+	int ret;
+
+	ret = read_poll_timeout(yt921x_reg_read, res,
+				res || (val & mask) == *valp,
+				YT921X_POLL_SLEEP_US, YT921X_POLL_TIMEOUT_US,
+				false, priv, reg, &val);
+	if (ret)
+		return ret;
+	if (res)
+		return res;
+
+	*valp = val;
+	return 0;
+}
+
+int yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask, u32 val)
+{
+	int res;
+	u32 v;
+	u32 u;
+
+	res = yt921x_reg_read(priv, reg, &v);
+	if (res)
+		return res;
+
+	u = v;
+	u &= ~mask;
+	u |= val;
+	if (u == v)
+		return 0;
+
+	return yt921x_reg_write(priv, reg, u);
+}
+
+int
+yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
+		 unsigned int num_regs)
+{
+	int res;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		res = yt921x_reg_read(priv, reg + 4 * i, &vals[i]);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+int
+yt921x_regs_write(struct yt921x_priv *priv, u32 reg, const u32 *vals,
+		  unsigned int num_regs)
+{
+	int res;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		res = yt921x_reg_write(priv, reg + 4 * i, vals[i]);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+int
+yt921x_regs_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			const u32 *vals, unsigned int num_regs)
+{
+	bool changed = false;
+	u32 vs[4];
+	int res;
+
+	if (WARN_ON_ONCE(num_regs > ARRAY_SIZE(vs)))
+		return -EINVAL;
+
+	res = yt921x_regs_read(priv, reg, vs, num_regs);
+	if (res)
+		return res;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		u32 u = vs[i];
+
+		u &= ~masks[i];
+		u |= vals[i];
+		if (u != vs[i])
+			changed = true;
+
+		vs[i] = u;
+	}
+
+	if (!changed)
+		return 0;
+
+	return yt921x_regs_write(priv, reg, vs, num_regs);
+}
+
+int
+yt921x_regs_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+		       unsigned int num_regs)
+{
+	bool changed = false;
+	u32 vs[4];
+	int res;
+
+	if (WARN_ON_ONCE(num_regs > ARRAY_SIZE(vs)))
+		return -EINVAL;
+
+	res = yt921x_regs_read(priv, reg, vs, num_regs);
+	if (res)
+		return res;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		u32 u = vs[i];
+
+		u &= ~masks[i];
+		if (u != vs[i])
+			changed = true;
+
+		vs[i] = u;
+	}
+
+	if (!changed)
+		return 0;
+
+	return yt921x_regs_write(priv, reg, vs, num_regs);
+}
diff --git a/drivers/net/dsa/motorcomm/smi.h b/drivers/net/dsa/motorcomm/smi.h
new file mode 100644
index 000000000000..2995e91f3b3d
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/smi.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_SMI_H
+#define _YT_SMI_H
+
+#include <linux/types.h>
+#include <linux/wordpart.h>
+
+struct yt921x_priv;
+
+int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp);
+int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val);
+int yt921x_reg_wait(struct yt921x_priv *priv, u32 reg, u32 mask, u32 *valp);
+int yt921x_reg_update_bits(struct yt921x_priv *priv, u32 reg, u32 mask,
+			   u32 val);
+
+static inline int
+yt921x_reg_set_bits(struct yt921x_priv *priv, u32 reg, u32 mask)
+{
+	return yt921x_reg_update_bits(priv, reg, 0, mask);
+}
+
+static inline int
+yt921x_reg_clear_bits(struct yt921x_priv *priv, u32 reg, u32 mask)
+{
+	return yt921x_reg_update_bits(priv, reg, mask, 0);
+}
+
+static inline int
+yt921x_reg_toggle_bits(struct yt921x_priv *priv, u32 reg, u32 mask, bool set)
+{
+	return yt921x_reg_update_bits(priv, reg, mask, !set ? 0 : mask);
+}
+
+/* Some multi-word registers, like VLANn_CTRL, should be treated as a single
+ * long register. More specifically, writes to parts of its words won't become
+ * visible, until the last word is written.
+ *
+ * Here we require full read and write operations over these registers to
+ * eliminate potential issues, although partial reads/writes are also possible.
+ */
+
+static inline void update_ctrls_unaligned(u32 *lo, u32 *hi, u64 mask, u64 val)
+{
+	*lo &= ~lower_32_bits(mask);
+	*hi &= ~upper_32_bits(mask);
+	*lo |= lower_32_bits(val);
+	*hi |= upper_32_bits(val);
+}
+
+/* yt921x_regs_*() are exported for linkage only. Do not use them directly. Use
+ * yt921x_reg64_*() or yt921x_reg96_*() instead.
+ */
+
+int yt921x_regs_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
+		     unsigned int num_regs);
+int yt921x_regs_write(struct yt921x_priv *priv, u32 reg, const u32 *vals,
+		      unsigned int num_regs);
+int yt921x_regs_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			    const u32 *vals, unsigned int num_regs);
+int yt921x_regs_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			   unsigned int num_regs);
+
+static inline int
+yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
+{
+	return yt921x_regs_write(priv, reg, vals, 2);
+}
+
+static inline int
+yt921x_reg64_update_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks,
+			 const u32 *vals)
+{
+	return yt921x_regs_update_bits(priv, reg, masks, vals, 2);
+}
+
+static inline int
+yt921x_reg64_clear_bits(struct yt921x_priv *priv, u32 reg, const u32 *masks)
+{
+	return yt921x_regs_clear_bits(priv, reg, masks, 2);
+}
+
+static inline int
+yt921x_reg96_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
+{
+	return yt921x_regs_write(priv, reg, vals, 3);
+}
+
+#endif
-- 
2.53.0

