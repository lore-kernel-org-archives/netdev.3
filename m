Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CC3905F5
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791048268; cv=none; b=r1Of+NkImxg337Y25dVGtPsC9wnAnwsrdjPJAYwLZONhpiGUw/4IYuP/KCqV27s9+iHy3J+w/M3yJyCWnCmMjsr66PPRBuBUSA+T+UyFXpMDNfFy+tpdAxip43VbGg2lCKoJ9pe92qKz4fGPm2ReJsgvzRYGnt/8fwykSn3ZT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791048268; c=relaxed/simple;
	bh=69pIUI/5/fbnwUFtIz/4iXV/uH+NitRm63o5SGfm3YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fkc7Goxt70loN+Ku9gMoWXV1ADKQvYkmjO7L+sGwVNsHeZ06CgqLYn0iavpYCI9xdS9tfPBl988KUgE5eqetu4mTfB8Du21/neh9L6gkQdy2U656FcTAga2+fcv56j8schLdPXIwfRB3t7kcIX1A6br1rhBffV+0eCJP6tcCyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pI2QtiPz; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pI2QtiPz"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e227422e3so105205666b.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791048265; x=1791653065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dMjI2Sdqf2wHcTdDJrLPNOQcTxfKFFQEHZJyopa8XYE=;
        b=pI2QtiPzsyz1hcueXwX8EUU34laV5XL71EbsENYwpwSjjDizSUq8b6vTBG6OlzJxY6
         D20DtaJug20bTvKxoVU0gDP6BaBxFbCnmS4bdesy1IdMnQaYDmYDZxTJ5Dr5hlviUXj4
         AYBbuBqlfxD4UHlQHKgnwVy9rh3RF5IFGTv4UY76sOSnQya4U8jJUBiZCag9zEgcblxQ
         56v2CJ5E6WgYMi3+h2xrdCdwtMf9x0XsnusyLXXyXHvUDur4Idah9Lpycwm6CZAZOjou
         q1RCY7kHgoVXwSgcBxQ+uQTdnbOco/O9umLfZwM5UAYNKjT8+ctLdiqTjlJg0Hgnhakg
         m+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791048265; x=1791653065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dMjI2Sdqf2wHcTdDJrLPNOQcTxfKFFQEHZJyopa8XYE=;
        b=oFA/lZwWlJHfR3l141Hhy5h6QinSi8pZbpygWW3b7TU/+RdsA9fOkxYqm16CuatQ4p
         74KxLoEBKjwccScGGiWORygwCPJ8b0JoC8NMBYjJB2rCk1jmMn1moqNPKY+YL8iTTxPw
         6/VQ88hr8uerNqMqPisbTkQSMNZw6UeE+9gOIUh5IY0Sv/k/+N6OwCKGEtzlT4y9S5TY
         v2Uft01zECcwVnVZTk2xm372P1AUPBUnSzfFrmuQ3fyieYdPyW2+L0a9IGtnRq9cqmC4
         GlZTk08cTFoL622/visfnS2NWcAWtx6ePnBss+Claf+4HwmoNgK5b2HMcGrIIT/vSiB0
         W4TA==
X-Gm-Message-State: AFuF++n5YG3xyxC/wzEGQP6X/l+4mIGqa7pzov8biD+aDWT7j+Ikqecb
	XGwjDqoImW7eTed/Il7x5ZsO83Hg5//I0UHOnmKrZzbqdNXVCUW4/A/AyvSZ6ob+PgTA1g==
X-Gm-Gg: AYBFou2KMxSI1DwMoairBaNcCkLcTqLHaw+szk0WKO7jC/j4vDe/On9bZ9q6Z//2hHz
	C5FFIrV+e9Z/SNE5zGByb+Xgmkk9GoWdrZZNDPecS7uZ6QSrhNwLaqiYwrZ/5ZRHl2ow0sr/Hue
	6Mwedb26FRjWmgM//hxmHGeTd7/4Wo7dZ/XbKoEcOnybcsdNii9WMLbUXfnJfCMfQdjyt+WwoUY
	YGzLJKYdlIRblccxTTBS0x2YwN8/b8nnVraK6f4oeTXrjc7PlbZLZEFHh2NLIr8Rllie/fTdq/r
	sT+CT90189Nol4AUW4a7OmpNchfmm46ccbekje/PO5HTb9WeUc2uNchvxFzMtuJvH5eGcI4qcAR
	Y19S/qfcvDjsHXHLJ0GsXCZFwHUDT0stFqV2ifgwA8bfuyWadQrqkgwBMiuMTAiD0x10SGUwRi4
	O5PBlkDGWxt3Xm/x1L+wrD032mb8+l757rEq3vnXxi+n2bSOMIuTwiqueHbNxVYie2i6/8i8EUR
	f2T4Km44VZz/+z8QxNaIeOGjYmMJ6QcB0yHdO5mzGOa0FnDRrcfi6/v
X-Received: by 2002:a17:906:c103:b0:c2d:23af:5fcd with SMTP id a640c23a62f3a-c2e4b2b3fefmr550091066b.44.1791048264541;
        Sat, 03 Oct 2026 10:24:24 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:7995:7ccd:ec2b:6712])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf87430sm211407666b.64.2026.10.03.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 10:24:24 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/3] net: dsa: qca8k: do not clear MASTER_EN after a failed page select
Date: Sat,  3 Oct 2026 19:24:03 +0200
Message-ID: <20261003172405.342-3-yongzhao.derek@gmail.com>
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

qca8k_mdio_write() and qca8k_mdio_read() take the common exit path when
selecting the page of QCA8K_MDIO_MASTER_CTRL fails. That path clears
MASTER_CTRL[31:16] with a raw write to phy 0x10, reg 0x1f, which only
addresses MASTER_CTRL while page 0 is selected. After a failed page
select that did not reach the switch, the previous page remains selected.
The write can then clear the upper half of an unrelated register at
page * 0x200 + 0x3c.

No MDIO master transaction has been started at that point, so there is
nothing to clean up. Unlock and return the error directly.

qca8k_set_page() also keeps the old cached page when the page write
fails. If the write did reach the switch, a later access to the cached
page skips the page select and reaches the wrong register. Invalidate
the cache on failure so that the next access selects the page again.

The Sashiko review of v1 identified the stray cleanup write. A userspace
model of the driver's functions reproduces both problems by injecting
page-select failures with and without a hardware page change; these cases
pass after this change.

The cleanup write comes from commit 759bafb8a322 ("net: dsa: qca8k: add
support for internal phy and internal mdio"), and the stale page cache
from commit ba5707ec58cf ("net: dsa: qca8k: handle qca8k_set_page
errors").

Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
v3: Target net-next and drop the Fixes: tags. The commits that
introduced the problems are named in the text.

v2: new patch, addressing the Sashiko review of v1:
https://lore.kernel.org/netdev/179054715863.3145.10179961093285192493@kernel.org/

 drivers/net/dsa/qca/qca8k-8xxx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index b73c7c52e0f..2708430413d 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -153,6 +153,8 @@ qca8k_set_page(struct qca8k_priv *priv, u16 page)
 
 	ret = bus->write(bus, 0x18, 0, page);
 	if (ret < 0) {
+		/* The switch may or may not have switched pages. */
+		*cached_page = 0xffff;
 		dev_err_ratelimited(&bus->dev,
 				    "failed to set qca8k page\n");
 		return ret;
@@ -836,7 +838,7 @@ qca8k_mdio_write(struct qca8k_priv *priv, int phy, int regnum, u16 data)
 
 	ret = qca8k_set_page(priv, page);
 	if (ret)
-		goto exit;
+		goto unlock;
 
 	ret = qca8k_mii_write32(bus, 0x10 | r2, r1, val);
 	if (ret < 0)
@@ -851,6 +853,7 @@ qca8k_mdio_write(struct qca8k_priv *priv, int phy, int regnum, u16 data)
 	if (!ret)
 		ret = ret1;
 
+unlock:
 	mutex_unlock(&bus->mdio_lock);
 
 	return ret;
@@ -877,7 +880,7 @@ qca8k_mdio_read(struct qca8k_priv *priv, int phy, int regnum)
 
 	ret = qca8k_set_page(priv, page);
 	if (ret)
-		goto exit;
+		goto unlock;
 
 	ret = qca8k_mii_write_hi(bus, 0x10 | r2, r1 + 1, val);
 	if (ret < 0)
@@ -896,6 +899,7 @@ qca8k_mdio_read(struct qca8k_priv *priv, int phy, int regnum)
 	if (!ret)
 		ret = ret1;
 
+unlock:
 	mutex_unlock(&bus->mdio_lock);
 
 	if (ret >= 0)
-- 
2.43.0

