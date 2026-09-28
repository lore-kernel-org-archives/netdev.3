Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC5502794
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633223; cv=none; b=hPM9q7X9clV1ek2uv5A/T2bgzvj3/8EqgpNUUT12BfQFklEAyCFi8VdfkW4DJOt7g6kFjBaYdPohBJqBro7rwv6qNevjUnERH0k0I+diCoHF9N9QA68juVxpPxMxvyZ/rKylUCGZEMKXz4GZqnqo6FCXxYBcEfCQ37yleKGcwPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633223; c=relaxed/simple;
	bh=X41/cIbMvzxPRUI5NOfiDZIbIvjDef8SxPQiIMMnTi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDDNu6Y/EIZpy/kwHvcDTZUDPjL7yHy2+jk5cZ03ciear90a20lRNNbCR5gm3YRRsah3J5WOEZOTit7iL7R0g0rfbgATTb6Al1jXC8LH4ygoQ8KPW+FO96S/P3VzzInFmEjSq3+fHUdx0eO6FXq7+8cPGdmXNWt4OncjfQww2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/N1UpI6; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/N1UpI6"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2dbdcb4f59so330801066b.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790633220; x=1791238020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBXPUjjR8+JdvTG8x+WkgNQCyJpOtYcJ55dEf/OrhJ0=;
        b=Z/N1UpI6wlazl2/eggTKH31+4UEzARtIY8qX3/+G25ttsVOGsXUN/vj34NluSMETCJ
         0dlzDuuhrvTYFn2iIrHyr05Xyc+2YBFWcn5sZOwU1anKXCwsYNp3Na6SXVkwMeDRR3pc
         /BSrrZo7Qwku3H5fKLYaogSYdYF4xrW6M52XkhSm8bKt5EiQBhs541oeZj3sH3V8ERc/
         IUGIomPQTYpyXxA2HjxKe+FN9Vgb50db4bmYtTXrd1uc5uVtGJVoVVwlAGVH9vv+gtkq
         98E15ssYV4B793Uxoj8N8yNCkrCHs3b3imm9pfDWxd33S3D8sGfUUidt8f38ApdFnY31
         3mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633220; x=1791238020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBXPUjjR8+JdvTG8x+WkgNQCyJpOtYcJ55dEf/OrhJ0=;
        b=kRtxYC45e8iIAsOm2xxxGCmy+2yU5rDWeByr6wZ2TAPSB2ymbVW7Nbflf1bDQmOQN3
         AjUDlNXgOay4dDYAOgYpn6JT0k4YvZ54+4fsjodhQohrV6Dl37T3lLsApWn78d3tcTXm
         wa8+oq419LaGi7BiOk7vgdGw0BQWFJ+9Gom3HJ5ODhvY1JNxv4zXMMNDte8bN2X7yryS
         ++xXHuUPevaYJ1PJWPnrB25r/7tuXcZPlH4BMgurblT8UJK2c6HiwR6OPJj04QcqGmIG
         fDX7o0D5DLDuUyM6n1TyTcwXlnx+TNx2tsRae+e7G4nVTqGNcM8Rf9VPUFDKDGSlejK5
         aNcg==
X-Gm-Message-State: AFuF++kIctJJvG4MxW1BNAxi/riItoN/mmFtVbkmCEO2zxAHpPJ3D+/W
	gcH/hKGWPMky2GWPhAv8XsF3WP9Cq0gBCGPawonWtRnHto5Xb1Ty4F7ofuy/5qOQpjo2WA==
X-Gm-Gg: AYBFou3YZ6C1AdWIGs5KTCGs/l6YyQVcs1U3JmVPYimH+0r+2vR4ePxd4jJiknFuHkx
	MF84SfPN/E0l5LFP9p48qRAtBbVosvplOfNpYMIujDv4Qj+yL1cV4NNfg0OIGkB+D1dDEPueVJs
	ZyujtlGRoFLh4fYTMkmFo69qvFSDbWDEabyuthaP5pj4wlvjfLjTAfs7tdw5AIQm8+tFIq6jea1
	b+6JR8BRsgrHlsw6pkEW6ePzIHyjUgd7WmPeMJ083ekDMGjLdA+Gnagns7fHnSalI5K/E8U++Vs
	FNER5Jo59mWFRIaAkMX/q2Y8ZDoX0QDo0OrwFchsE6L7dQOYilPvg1B290/YLcRg6NzvO0Rs8jb
	Q3kY5kY/zSZIssVfsEs5kOPPkynSZfEfByfM+yVw4RZ46ocbsIl9mph3ZbuvDoet9KV0iQKo/hp
	zCX63giFN0aM0049h9YfoysesQ72HVexL1MozHfN8Rw/zWm4GOB4FYfE4F/KTPL/uzu6Bm/n97U
	tBrF92eHi3FbEoHyXUqeojR4dwjmClnwH7v3I13dddTfRIlnAJMddJ8
X-Received: by 2002:a17:906:7946:b0:c26:1648:a06b with SMTP id a640c23a62f3a-c2ac2511a13mr1112807466b.38.1790633219855;
        Mon, 28 Sep 2026 15:06:59 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:c07a:9093:1956:b4bf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b50fsm520177266b.32.2026.09.28.15.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:06:59 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/3] net: dsa: qca8k: propagate MDIO errors
Date: Tue, 29 Sep 2026 00:06:27 +0200
Message-ID: <20260928220629.238-2-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260928220629.238-1-yongzhao.derek@gmail.com>
References: <20260928220629.238-1-yongzhao.derek@gmail.com>
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
v2:
- Removed the blank line between the Fixes: tag and the other trailers.
- Cc John Crispin, author of the commit named in the Fixes: tag.

v1: https://lore.kernel.org/netdev/20260923215748.1336-1-yongzhao.derek@gmail.com/

 drivers/net/dsa/qca/qca8k-8xxx.c | 51 ++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 4c928983b86..0851e4d65b8 100644
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

