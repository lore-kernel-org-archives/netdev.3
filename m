Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCC35CB7F
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791048267; cv=none; b=CMFg4Tb+ppyt9ziRXiHwF+bwW6MHaLefmLjIHzHrRCCtzwQiHJ2+eS3OuqSJOrmTepIQM18ex+gjHepPBFbeHCnt1lufzPMMReCDbkePddsQUraUbf/698dTe6m8wKWQg/SHYhqxC4ZFBwGl9Zf2Q4ffVT56tou/AncNinJHGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791048267; c=relaxed/simple;
	bh=gOMtCPDi6onkcwzJ+jBDSH/yuNAb9k/rq56qbrfDWDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuoRe6Xfe9XcCssng6KQY6Kg7jHE1YaOH3cJTkZPeKymI8P7UW/7F6lf6pVG87l7p0yqy3CT0Jtiw1ts4m9dPl5humU2KeBvsa/9UdCdxS+LEW2WSFdePKLh8EB3foPYj5Rdi3+Jnk7CVWwivBWXHlk6u9iZUkD5bdWRvSWpZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyCXlLak; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyCXlLak"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2e69aa07c3so95926966b.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791048263; x=1791653063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MdKWptQSKYr6NILI2rKzv51twkbV2TwD0Olbx7iBa7w=;
        b=GyCXlLaky0TNixlRd3s/SLp6MXRpQWqxMfszkZBfLlY01468e8/JZw151Kh+sNr2rb
         KdQXu/jhTpxE7/ZhQgobtaPYGpJstr6Z9ClD/cGFexA78MgjRgNRgLq2a9cpK9Rz9vs9
         mY8de0SyQA+nPTemoK96oddMC4qsnEh+MWNR98xtzIMdX7kb/oaLxoKuSAvMrY3oRdGg
         EXEDzCVcR51vmUsxA97L0vlt6eAGOk8Ihex9m2Yp4Fr0uzpIpD1iI8BEh7JCQkYQzKFP
         Fix0QWJTSCqKifuOolOAifgB1XJlXzaGqXIP9J0dg52yNLmlRfdVXoD2Z7b/lRuz24N6
         nB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791048263; x=1791653063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MdKWptQSKYr6NILI2rKzv51twkbV2TwD0Olbx7iBa7w=;
        b=LalCUZFtgi0Bl0Ct+CCex3UbBv3bImGtEaEV/AjlYTm0wsys6mbM2MjduTursbwxbz
         QmO4LtOR2qmjoSYN9Rm/fGGEfI7lyMEYIxscN+InYkKkiZqHgqYSL+XaDJzeb6FYInNJ
         mdwkJJxqSvBlZNinlQI6A7M8aUo8oOfLjftmnF+kmwW3uRlLHwdGWBThYg25ns9SPt0P
         sG7ddqtsJGKG7EREKDpv8wgZoP6TdaqwnPjL/OhkkKAi5/kx7eLp8ddZld3U8diMswrg
         Z9MJADShlp3Aw41hKvofI+cLN3/1tMnMXb6gBuIwKWVT/KAo/3C8RmkdmYLsSD7OL7pi
         aUzg==
X-Gm-Message-State: AFuF++kCk8JG69G3T/60xUbu7AtRWHJSkJ6RqdZNHT95Zq8ZdHnnhohj
	IfiZh5vpqcNAmQW7PVbWysy1E6m/yEl2aqGo4mw3RJzrAkjrAz08lo2x3WI9J5wOtib5Xg==
X-Gm-Gg: AYBFou3r0+LUD09J2OttkSVKQNDYAllr9M5u12DAdyX8SkMmSkwa1XKUKBqo/pOIYwI
	uEzb+oI8mEOeFYzG78+GIOawGM+0m0SvZSm1FPyEA2uaHTY5oiaOURit/+CMCr4GOpCund9rL7b
	V79uIG1J6Nx02rmHPS42qjdQljJ1CwQ87vigzaqoP3KSoUtEtLl8OnMDtUEQf5pfIUNj020ycu6
	UKxbDJn2/S5GTT/WIgrtFA5fn9CIHP46S5SdOuWFZQbM2LVLQez63siNOLIkwNacLD54xWLUraL
	rGSGQLuSkDRrYaXcRznkbLS7di605SgoMppbcfhIy3SXpkdC8jncsKdS9ZIh6/8xvPDQSELn79W
	NnuGFtALoRHvhnyt1R1jd+pdhFn2H1R/8N7BodGAyWTDFFZwkWhBh+87WTkE4IVtMf6BeGT+zA+
	pTu3Zp/mGR/UuHkNa4V8U576+7sHxSWkgdyAw/LGM1YEeKt9NJSoqvW8SfUimG7ik5e+9oIubfs
	lFj48h88VizTwwZSCNjnIZ8xBrH3mXq3ciNV87ku5tfLv4E3s9Uv3bAZw==
X-Received: by 2002:a17:906:c107:b0:c25:afb6:2d91 with SMTP id a640c23a62f3a-c2e6e9c9ffbmr234838466b.2.1791048263258;
        Sat, 03 Oct 2026 10:24:23 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:7995:7ccd:ec2b:6712])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf87430sm211407666b.64.2026.10.03.10.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 10:24:22 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/3] net: dsa: qca8k: propagate MDIO errors
Date: Sat,  3 Oct 2026 19:24:02 +0200
Message-ID: <20261003172405.342-2-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20261003172405.342-1-yongzhao.derek@gmail.com>
References: <20261003172405.342-1-yongzhao.derek@gmail.com>
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

Code inspection found these problems. Fault injection into a userspace
model of the driver's functions reproduces them; the corresponding cases
pass after this change.

qca8k_mii_write32() has not returned write errors since its introduction
in commit 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx
family").

Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
v3:
- Target net-next and drop the Fixes: tag: no actual MDIO error has been
  reported. The commit that introduced the problem is named in the text.
- Order local variable declarations in reverse Christmas tree order.

v2:
- Removed the blank line between the Fixes: tag and the other trailers.
- Cc John Crispin, author of the commit named in the Fixes: tag.

v1: https://lore.kernel.org/netdev/20260923215748.1336-1-yongzhao.derek@gmail.com/

 drivers/net/dsa/qca/qca8k-8xxx.c | 53 +++++++++++++++++---------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 60f2a615a5c..b73c7c52e0f 100644
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
@@ -794,19 +797,18 @@ static int
 qca8k_mdio_busy_wait(struct mii_bus *bus, u32 reg, u32 mask)
 {
 	u16 r1, r2, page;
-	u32 val;
 	int ret, ret1;
+	u32 val;
 
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
@@ -817,8 +819,8 @@ qca8k_mdio_write(struct qca8k_priv *priv, int phy, int regnum, u16 data)
 {
 	struct mii_bus *bus = priv->bus;
 	u16 r1, r2, page;
+	int ret, ret1;
 	u32 val;
-	int ret;
 
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
 
@@ -855,8 +861,8 @@ qca8k_mdio_read(struct qca8k_priv *priv, int phy, int regnum)
 {
 	struct mii_bus *bus = priv->bus;
 	u16 r1, r2, page;
+	int ret, ret1;
 	u32 val;
-	int ret;
 
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

