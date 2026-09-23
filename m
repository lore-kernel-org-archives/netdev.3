Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84647C101
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200687; cv=none; b=RatngLgQnyGXtedu3htnqY7a64nbbXgqHpNrncvzjmb18WRKtE15SY3c75G7iMUBSU6osoO19pNkYxSBvVH5bfFrTNcODiczW2QYYs4SogUsJJtjJRC2szsj821wdPH8+7avmJx8ozSxNlL/JES80/8peyv0HgHtKyuXru0dBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200687; c=relaxed/simple;
	bh=59GcBbsmvDaiPsvB1gNrks06qF+u1TwcNO4QE9BQcu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulsOf4Y3anLhnVGXvYOA4UkywyXyiXBO2Hi0W+GOQEIZDzzLpBh44e/bqFElIs3WFNG8yrdqiREoyk/j+xhwh4NIPLsJz7k4YtaZ7hncliRZrMJUlZtu9AfLNYdwGzptP8bYHLIMvD9bUF8CVluLw0qfu109m4/oKTketKwvJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhPrkACU; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhPrkACU"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a9edfc851so209000466b.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200684; x=1790805484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6wXl9kDIHvkBOlMWPi5UbEM/iw7w5+qrkwtBtIFjgjg=;
        b=RhPrkACUVpkIv7kXMQU0uVKx5GS757qVgh83ukME5A8piuk9M6Dz+j5x/1wIO31jub
         4VUkLfmq0+gXbcoeJ0t4Fq/PEaSd+HLr5mh5iSZiNCuyhBW3S2Nic2OcgIDnRoArXotI
         a10Bnf7LOku0eIutNvAChBei1PYjni2vAaHEC+8hyvNpd6eaHd5ZolVo7bgzw2NV1MN5
         dJMAkq1fyoqxbyTT573BwHqBu1aNZs5ADJhEZ5+dYsvMhLxv6xFzQr/dyOr6+iDkv815
         P3TnZV5qwQrRf7/bdCo2mNSwciu1QhlZB56XGA0X3IXOuBptp8ZYafHjVPkvtIbJDNL6
         DO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200684; x=1790805484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6wXl9kDIHvkBOlMWPi5UbEM/iw7w5+qrkwtBtIFjgjg=;
        b=XunK2wbZbOUeXMXyH/xsu8lF5hbvp+V0+A/QgmFHK9l+jI4+qLk1eMA5hJsb0zfqvv
         mw/FHAJc6Z3KJJLTj5Obx0RywLD/Xvd0txbKCz7i836cuBduObdO1kkenDwmkIIUkc6J
         QO9ws4UoKNssMUDe+G93FjleWqI01ncFs1ZJK2XbkIXn0SO1Y2sb325AwJF7rxE8TteA
         jT6S7g17WmJ6MMiHKC7kW9NTdBsc1eJ1k+IsUUkoH9EAXcOfW63pk+0mGkMrOE5BH51l
         wXpipiU/bLEleSciHgo1eSkOQkOYHLl+vipTfrpLQUG1HyOyT7QOYHMCWnhKcCOuzZ1U
         Pxgg==
X-Gm-Message-State: AFuF++lAKj+KqjHramG9HgLyexd0fIiaS2f2s45W7m2ET8ryhTXXWjwJ
	Y0Tr50K8Ad9hiCY7E/U6Tw6F98Y7FBDstlp5Rq3Zch/tkdrxJKaOxzz1ykucKwyl3kKTyw==
X-Gm-Gg: AYBFou3gFyeNXKFeE0iERPFaKodnS1jRZugNdcjknnEnnfNEjfyDr86Mjfh6L94gfQQ
	NeTT71UQMKHngEDJMPZPenvoMkQ2dNZIuooG/04hRtihJk17UF7rh/Ikg2bIjBS2IqKbydB1gkm
	s/5boer8KZX6utZS+fgxF/RcVgEWj32N6xBGcEPFifeQcolmt+hixURhzFmRZ+THVZMxDvCDzwf
	apcuKGMJTIxFcItMW71rVSUSYy1refvnTGwi3HttaFXvPCLvoq5PNQ74nbghoz1gFOlfwOlsMVu
	yjOxDLwN2Y/UoFePQGuzcNCiIDGx52zEJob06kMt30d+mvX8oEqgWxYIZmunLLgSMyW4t37lSRl
	UVhmIlpxzJKeriswHNlhQFhE15sqxcxW9aymJK1JACOE6upyqJtihqwpikHv26hoUPzcnVtp7hs
	8TESUPCUSmoVpHE8CMAbcniO26Jp29yYExauH1L2zeXqpZKgVukM+BdQsbx5J1ThOtw5OXueOU9
	b6xgUhR9mZSGUeHclccvQWTxKLxWDw+WJi23Tmle/R10GvGgaO9nxlqj6Qdh1eywYEQ6oiHMVmD
	luqGN/KJyIb+qNryuEJ6
X-Received: by 2002:a17:907:a890:b0:c29:6291:e37c with SMTP id a640c23a62f3a-c2ac22abccemr39709366b.24.1790200684048;
        Wed, 23 Sep 2026 14:58:04 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e57csm2384010a12.6.2026.09.23.14.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:58:03 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: qca8k: propagate MDIO errors
Date: Wed, 23 Sep 2026 23:57:48 +0200
Message-ID: <20260923215748.1336-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qca8k_mii_write32() ignores errors from both 16-bit half-word writes.
Its callers (register writes and read-modify-write helpers) then return
the earlier successful page selection or read result, incorrectly
reporting success even when writing the switch register failed.

Propagate write errors from both the low and high half-words through the
regmap paths and internal MDIO master transactions. Attempt to clear
MASTER_EN even if a transaction fails, preserving the initial error, and
report a cleanup failure if the transaction itself succeeded. Preserve
the existing Ethernet-to-MDIO fallback order.

Propagate read errors through the internal and legacy MDIO bus callbacks
instead of masking them as 0xffff. Returning 0xffff causes PHY
read-modify-write callers to treat the failed read as valid register
data, which can corrupt unrelated bits on writeback.

Stop polling when reading the MDIO busy status fails, and return the
error immediately. Because the read helper clears its output on failure,
checking only the BUSY bit mistakes an unsuccessful read for transaction
completion.

Fixes: 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx family")

Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 51 ++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 60f2a615a..f9e2eb0b9 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -129,13 +129,16 @@ qca8k_mii_read32(struct mii_bus *bus, int phy_id, u32 regnum, u32 *val)
 	return ret;
 }
 
-static void
+static int
 qca8k_mii_write32(struct mii_bus *bus, int phy_id, u32 regnum, u32 val)
 {
-	if (qca8k_mii_write_lo(bus, phy_id, regnum, val) < 0)
-		return;
+	int ret;
+
+	ret = qca8k_mii_write_lo(bus, phy_id, regnum, val);
+	if (ret < 0)
+		return ret;
 
-	qca8k_mii_write_hi(bus, phy_id, regnum + 1, val);
+	return qca8k_mii_write_hi(bus, phy_id, regnum + 1, val);
 }
 
 static int
@@ -462,7 +465,7 @@ qca8k_write_mii(struct qca8k_priv *priv, uint32_t reg, uint32_t val)
 	if (ret < 0)
 		goto exit;
 
-	qca8k_mii_write32(bus, 0x10 | r2, r1, val);
+	ret = qca8k_mii_write32(bus, 0x10 | r2, r1, val);
 
 exit:
 	mutex_unlock(&bus->mdio_lock);
@@ -492,7 +495,7 @@ qca8k_regmap_update_bits_mii(struct qca8k_priv *priv, uint32_t reg,
 
 	val &= ~mask;
 	val |= write_val;
-	qca8k_mii_write32(bus, 0x10 | r2, r1, val);
+	ret = qca8k_mii_write32(bus, 0x10 | r2, r1, val);
 
 exit:
 	mutex_unlock(&bus->mdio_lock);
@@ -799,14 +802,13 @@ qca8k_mdio_busy_wait(struct mii_bus *bus, u32 reg, u32 mask)
 
 	qca8k_split_addr(reg, &r1, &r2, &page);
 
-	ret = read_poll_timeout(qca8k_mii_read_hi, ret1, !(val & mask), 0,
+	ret = read_poll_timeout(qca8k_mii_read_hi, ret1,
+				ret1 < 0 || !(val & mask), 0,
 				QCA8K_BUSY_WAIT_TIMEOUT * USEC_PER_MSEC, false,
 				bus, 0x10 | r2, r1 + 1, &val);
 
-	/* Check if qca8k_read has failed for a different reason
-	 * before returnting -ETIMEDOUT
-	 */
-	if (ret < 0 && ret1 < 0)
+	/* Preserve an MDIO read error instead of treating it as ready. */
+	if (ret1 < 0)
 		return ret1;
 
 	return ret;
@@ -818,7 +820,7 @@ qca8k_mdio_write(struct qca8k_priv *priv, int phy, int regnum, u16 data)
 	struct mii_bus *bus = priv->bus;
 	u16 r1, r2, page;
 	u32 val;
-	int ret;
+	int ret, ret1;
 
 	if (regnum >= QCA8K_MDIO_MASTER_MAX_REG)
 		return -EINVAL;
@@ -836,14 +838,18 @@ qca8k_mdio_write(struct qca8k_priv *priv, int phy, int regnum, u16 data)
 	if (ret)
 		goto exit;
 
-	qca8k_mii_write32(bus, 0x10 | r2, r1, val);
+	ret = qca8k_mii_write32(bus, 0x10 | r2, r1, val);
+	if (ret < 0)
+		goto exit;
 
 	ret = qca8k_mdio_busy_wait(bus, QCA8K_MDIO_MASTER_CTRL,
 				   QCA8K_MDIO_MASTER_BUSY);
 
 exit:
 	/* even if the busy_wait timeouts try to clear the MASTER_EN */
-	qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, 0);
+	ret1 = qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, 0);
+	if (!ret)
+		ret = ret1;
 
 	mutex_unlock(&bus->mdio_lock);
 
@@ -856,7 +862,7 @@ qca8k_mdio_read(struct qca8k_priv *priv, int phy, int regnum)
 	struct mii_bus *bus = priv->bus;
 	u16 r1, r2, page;
 	u32 val;
-	int ret;
+	int ret, ret1;
 
 	if (regnum >= QCA8K_MDIO_MASTER_MAX_REG)
 		return -EINVAL;
@@ -873,7 +879,9 @@ qca8k_mdio_read(struct qca8k_priv *priv, int phy, int regnum)
 	if (ret)
 		goto exit;
 
-	qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, val);
+	ret = qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, val);
+	if (ret < 0)
+		goto exit;
 
 	ret = qca8k_mdio_busy_wait(bus, QCA8K_MDIO_MASTER_CTRL,
 				   QCA8K_MDIO_MASTER_BUSY);
@@ -884,7 +892,9 @@ qca8k_mdio_read(struct qca8k_priv *priv, int phy, int regnum)
 
 exit:
 	/* even if the busy_wait timeouts try to clear the MASTER_EN */
-	qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, 0);
+	ret1 = qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, 0);
+	if (!ret)
+		ret = ret1;
 
 	mutex_unlock(&bus->mdio_lock);
 
@@ -919,12 +929,7 @@ qca8k_internal_mdio_read(struct mii_bus *slave_bus, int phy, int regnum)
 	if (ret >= 0)
 		return ret;
 
-	ret = qca8k_mdio_read(priv, phy, regnum);
-
-	if (ret < 0)
-		return 0xffff;
-
-	return ret;
+	return qca8k_mdio_read(priv, phy, regnum);
 }
 
 static int
-- 
2.43.0

