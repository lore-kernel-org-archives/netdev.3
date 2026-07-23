Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4AE3D3CF4
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836434; cv=none; b=CrHNPe459vLAfJJT3lQZw+IBAHhQapqy2pK9r5RBBVzZ/HvuAn80esFf0IfAmb79/+ilbVruRkQc9j0b0685XPB865IdgsWg5qF07756+5AV3rcrE9CR348GA4ar/SZMPup3dF4bBdT7uXfPvrlPyjfndvO5RC+IhM49XSk1JQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836434; c=relaxed/simple;
	bh=sCR7LCduQulp62y3Ouz854y7aYy0BrQ6pXog8+b4Jd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i34mYpfje5IXbRbUGbcRk95VcEImUx74TqeflUrmcE32+UyIbJ1KT60O5xAbEaXEtEaTFLeXuBc3LFclLrkbOKjhaTdVDCJqL0umi3RNrHOdNbQOndbL28T/e45zsTlZAUqOd8gSmXDDLOIBec4dirLFarcDEkMrQ5IJcmURE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHmRnJtq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHmRnJtq"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ced3386430so11396515ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836432; x=1785441232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KHAz6u3wdG+hZ6Dsr9mcpDC869qiGMxaGeFpJqp6Z1Y=;
        b=OHmRnJtq9E7CJP02Ftt14EU2QR/3eUiS3yE7OQUBt+dkKXHlajMgdnpf7xPlhhUzjG
         1+NstEZdDSYLuXtBngymGjKPPr57GVRlxnSXhSfpsWbxDUf3S4vyqbSDkhW5cdMajQEK
         YJOCARb86f25laN61anzk7O/zRulsX5Zz58vLLgK3lm846jMrclgks0tXZt4vAt0Jxc7
         nqjeyvFXf7yrREUroSrmnYu9swC7+qA9AxqNMWTmpjNhxr/4s+f6/yh2xyrQzxSNBZG+
         R2qM9z8sWTfXAAp3lc2O4KZLqz9NQJz+je6+DQWi7OsPjdDcWdxaj+2AcpAh0pMihwjv
         3P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836432; x=1785441232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KHAz6u3wdG+hZ6Dsr9mcpDC869qiGMxaGeFpJqp6Z1Y=;
        b=e/mrzRtXL+HnXKqGEWALWNdcFtOjI7A/BmCM0NGX+ONFk/o0IlpriM6ExW89sSYDSl
         jb41JbGfTvRkY7wjYt22k/CFuINfxPKoPpjU9xPP2b2y6EGQta3BT9JdnOX/Ukyj7Ylp
         msIuEfJ+HXYWI3ohAXjghYyz3xfWcHv2AtYm2z1KbpriASTGCMpRHmy0nn60VKJhiye2
         j73FdA7ffZOQZA3bPTkheD8GZaFny3pxjUDM19DA8GMmBDQYop0yXHFDgLekC0O84+UP
         M4jxGWf19/vxb625aN5vBpod4bY9CDX/Rd2aOPRcS3G4E9VjkTtTBsCWLDBXhriu8TjO
         0llg==
X-Gm-Message-State: AOJu0Yzyb8Q+Abfau4dnu7/2VTYQTE+hogr98Hooo9NDI9iTgULR0amX
	4qjpZUIiPA3Zv4d85O799VW7iOmVIoTKJ7WFykk55TpfdcSEqK/VuCNxV+FZekPp
X-Gm-Gg: AR+sD10V5fHU3vLNIyWFEmPb04Tx6zKaB/sJPc3dwdcBd8LUJYme5rqy0ukllXr8a24
	jhbCpYq54QTNxDbsrgN33N8Xuoq8TM/w3AjnpjTdXl5Grs2nmwNU889/OILvW2ubk2hM45mQkPL
	s31cD3q1k4/EZtAd3acnqHzFsd5etLu8mrtioVsE/oRFLj3hiGtOB/EZLbc5Cuixw09qsZcGtet
	0IIDWKFzTqe/zyu3ebQEMyoprz1SGSipQ+as2nLuVYZCi256CPg4IAcF7XHLQSfHQnnU3lAFdD5
	gx2TDsMVwkpmvyCivBcUaL9EILx900nFunvs67BBB73lXkKdudnEvoVVaiAgCSgQaZWOGdVt2sa
	Y61WjzNhLYOPwDJNl99cimsXrWAi2hFRHs/HMo8skpkv8Phm9pozR7lJNJeoPm+gB5BQyIpyhmc
	E1BtYksWKZFrhwsLvcC+FoB5cJFL3B
X-Received: by 2002:a17:903:26c6:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2cfa71b761amr52254525ad.8.1784836432139;
        Thu, 23 Jul 2026 12:53:52 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f310644sm39106625ad.55.2026.07.23.12.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:53:51 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 2/3] net: dsa: motorcomm: Split SMI module
Date: Fri, 24 Jul 2026 03:53:31 +0800
Message-ID: <20260723195335.806002-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723195335.806002-1-mmyangfl@gmail.com>
References: <20260723195335.806002-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMI operations are going to be used across different modules.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   | 207 +----------------------------
 drivers/net/dsa/motorcomm/smi.c    | 157 ++++++++++++++++++++++
 drivers/net/dsa/motorcomm/smi.h    |  88 ++++++++++++
 4 files changed, 247 insertions(+), 206 deletions(-)
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
index 000000000000..9054896e4cd1
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
+	lockdep_assert_held_once(&priv->reg_lock);
+
+	return priv->reg_ops->read(priv->reg_ctx, reg, valp);
+}
+
+int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
+{
+	lockdep_assert_held_once(&priv->reg_lock);
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
index 000000000000..2e956065eb90
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/smi.h
@@ -0,0 +1,88 @@
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

