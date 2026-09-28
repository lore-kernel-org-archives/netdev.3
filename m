Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7650278C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633228; cv=none; b=qkMKX/+kARpuyirfilKHG6nBZRQhj6c9+cZUSwB4gndfRBdA2Dofq5CEVvKnb/YVGJ9xACyDj3fc8orUdM9trr3dGYw/Ne52jdytkvyhYQi6eQeQi1Tg4uvpfZZtOUwsesx1dQt4a1VlLQoF7l4L8Rrq7UluEIhWEF1FyTWZK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633228; c=relaxed/simple;
	bh=Z6gzYvq99CyQ6LDP3RsBlmE9f9jTdDwxqkn7DxhcnBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+ecM1nlDibkjRq2wM/r6580AgbTiUI3ya8Q0GYGepqIQTw0JkFkSqJmPHAgpb7cfosRxRSu/UIGDTjK4526ACmmSDqUng5SaMjOjnx3yScNoPI2Z9ALnDisnLTDiZvSkAKT8Svt4KJnCj9nAAbG0aRYlMcCHQrdQjQYIXH9nuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMR0JQcP; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMR0JQcP"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so550765066b.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790633223; x=1791238023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RWUPjs15H97jtR6nbaZ4K0Iy2ZfPTyX0aeMyouUk088=;
        b=EMR0JQcPYtV8WS59oC0eoTIbPJqC9GZoYb6q6JkiiMlHUE8VFMnSXTWSykm0xoLj66
         eTturG34NfUyrmGiIHFDEbnFa12eEbZ9aX4Xl5btodRwnnHFjU1ezquNLEaERs+gcm7v
         pm4F8R+w/CcZJ66uXfYmAb0bCmLb4dUJls30BQClIp4NUvBmwuZ8FXB472VBooAxt3ox
         dh7FOGqrKp+vfF1REnpCfdNUYzSV/5Odzdk9gnuD80ZEAJA7xxvqdwl3RMrRz2FNhKE4
         1T+0kMR3EKNiBICmSi1N630aeIDVzU/u0zUxaWgXo4CgO0CAc4gwSspYeQQvv9+R+M38
         s1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790633223; x=1791238023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RWUPjs15H97jtR6nbaZ4K0Iy2ZfPTyX0aeMyouUk088=;
        b=aDDTanh/bdThQsbttj+h2+DUTZV1CG2Ggjre/dhRfT1aMT0+CNJGtRX2s1jXXeOrXC
         5XmHr+mycBhiwuS3B9Wd1JRdv1LDpZmNzAg2Bv0mJpBD2W2UBu2o5o1eY8+yWcFmAmOJ
         g+LksY0KPtE4EJiqbO/yYGfn0lelaBaaX9olphSYPUEj/gelb90uJ2UeMSXQIemAyxDU
         mBtbyLmD5ucEV1Gu5eqLd+lehhAdkZjm5wvZrFlNiTYLG8Mf5Uw0iOgzpZyKgvg9d+AM
         /WcDALmCgSTlvFo4mFR5Ywo5pzsv+EDWrvcf80ov14sqmr4LYRZSby3BAGvd2HLsse8W
         6P8w==
X-Gm-Message-State: AFuF++l4EWZcmBEA9mh5Xz09Hi4I88g0GP6R2hZ+a9mXVNHXjps91qWD
	WEBSD4c0PB8fgniH//Nm4Pt0DJF3+E9xWYPwZ9cNIGLvD349B3NBwQ0HRWiwLrePXIMZiQ==
X-Gm-Gg: AYBFou0k6jnSLpThjRXKJwKriIYhxceTqhKOP3X/OhMWQlfu+3kgY/u8PnqTFGPzLnf
	AoIn2vaJAcJU6PTYyAh48dkm9N0lNmUN6OhFIGiYe1uzDJMN0PUFEGEpTQMJdYyEnWTaHy43xzD
	s3Et81KoyYSf8ABR3DxQbb4mHoG3i/NoiPN250z9llUdnKTZ7uZzg2FmnIApJxFLIJt7xnm7DGX
	mbpO9gMuF9u1t9GGE2fGJn7PEvPdeTNqUAD5eR2HCo6OdSAcLpF8dRDfT1CP7Ps+tycw7jZYLXx
	M+W7DuDJqMbuFDR6wSj128DRVMiDLVnbjFIvXcnmDylICKM6uB+fv1s84VyajQOVMFQMAOT0tND
	An70BOBNfwS6XdlhSpMDoU5vafrEJwnXto9lKbEG9VPiZPc/dGaI6Ktay53huYvG4PNS5gFkE3b
	6KOnXES7aC3vtYHIOKuV2G2aNBn6QVGBXk2CrBXRTgtyZmHK1MbOu2NXWQjW2ro2za3hVh+IhBC
	CYSkMHcq2ta9464QgW+1tqZQcijil/+oni/IwOxpWRBSeMRx1rAt2rh
X-Received: by 2002:a17:907:86a1:b0:c2d:c26e:98f8 with SMTP id a640c23a62f3a-c2dc26edb34mr502489166b.14.1790633223469;
        Mon, 28 Sep 2026 15:07:03 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:c07a:9093:1956:b4bf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b50fsm520177266b.32.2026.09.28.15.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:07:03 -0700 (PDT)
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
Subject: [PATCH net v2 2/3] net: dsa: qca8k: do not clear MASTER_EN after a failed page select
Date: Tue, 29 Sep 2026 00:06:28 +0200
Message-ID: <20260928220629.238-3-yongzhao.derek@gmail.com>
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

qca8k_mdio_write() and qca8k_mdio_read() take the common exit path when
selecting the page of QCA8K_MDIO_MASTER_CTRL fails. That path clears
MASTER_CTRL[31:16] with a raw write to phy 0x10, reg 0x1f, which only
addresses MASTER_CTRL while page 0 is selected. After a failed page
select the switch is still on the previous page, so the write can clear
the upper half of an unrelated register at page * 0x200 + 0x3c.

No MDIO master transaction has been started at that point, so there is
nothing to clean up. Unlock and return the error directly.

qca8k_set_page() also keeps the old cached page when the page write
fails. If the write did reach the switch, a later access to the cached
page skips the page select and reaches the wrong register. Invalidate
the cache on failure so that the next access selects the page again.

Fixes: 759bafb8a322 ("net: dsa: qca8k: add support for internal phy and internal mdio")
Fixes: ba5707ec58cf ("net: dsa: qca8k: handle qca8k_set_page errors")
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
Assisted-by: LLM
---
v2: new patch, addressing the Sashiko review of v1:
https://lore.kernel.org/netdev/179054715863.3145.10179961093285192493@kernel.org/

 drivers/net/dsa/qca/qca8k-8xxx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 0851e4d65b8..00a70c7880e 100644
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

