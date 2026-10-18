Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD78450407;
	Sun, 18 Oct 2026 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311824; cv=none; b=ITNb7ZEf6LJJ4XEn8meYJfsZTeLbXtMY9A7lgsGlZQ7xaTewecQOkReyGK8BvkwXQayA+4b7o8Howl20GGcEkxMzfpfq//TJgOL7dKzdaAghtObdI6F1wtvcd79uYjC/IgnwCzqCaYp5y8NOR4NqVEPk4gq5c0xdsBstQrFtHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311824; c=relaxed/simple;
	bh=qhcrim2BFljtIt/kVk6TVbgLmaplYnp7FByaMsGZSUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPOK3K/owyjE5qsZWJPNBiSVpQfu6jd4vX3Y9F2qOSWortar7dZ85jq8L+K6HGGuN6Mmw7w59Ez0IB0tWmcTyfZYU+JIDoFVyqVUDLX2Riuh9aGXmlSACePcFqDUfbzfQ9LcHbCxZvU/I9ryUg8R+XUuWFaRdEsKpZrCLYH6du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=lsTPRZPa; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="lsTPRZPa"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 20024E8396E;
	Sun, 18 Oct 2026 10:23:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/S7jduktlVD1Ie1lXjH4Y8SQp+D4PZrcDGxgctgviDI=;
	b=lsTPRZPaIoTLS1zPebUcp/yREGf98FN1X/ZLYGxhodmAbXIKZFvCnebNU/g8SLZXe7IO6a
	dT1SHTZW7/32QvfgYfxktUAGAHsrZAPXZGZBOntOUR40+v8rH0Rot3RsPNZl+Uth8aeqde
	5121/DdA9HO0JeQiunramN89qXqjeErgIYQ8xj/na5J5aQbrh1nuxdsVQ8CBluYp2C8q1F
	cciJBFPtVYTQI89284TUoJXobY4FH/RbUXUGHAHwN0vYNmULevW/zRgEMCwRCjp9b+0wYl
	OTdSmyCqq0tgAFkEswh8iI66z+n6WwnkZgYwXeRqFzdlcBKW8UlGv7SrHiBg1g==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id mW2M7koaEnSP; Sun, 18 Oct 2026 10:23:33 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:23:32 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net 10/10] net: pse-pd: reject a power limit whose current does not fit an int
Date: Sun, 18 Oct 2026 10:23:13 +0200
Message-ID: <20261018082314.48950-11-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018082314.48950-1-github@szelinsky.de>
References: <20261018082314.48950-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pse_ethtool_set_pw_limit() turns the power limit into a current as
mW * 10^9 / uV and stores it in an int. For the largest allowed limit,
99900 mW, that overflows below about 46.5 mV. Only 0 V is rejected, and
si3474 reports the measured voltage of each port. A negative result then
hits the BUG_ON() in regulator_check_current_limit().

pse_pi_get_current_limit() does the same conversion and can return a
wrapped value that looks like an error code.

Do the conversion in one helper that returns -ERANGE when the result
does not fit an int.

Fixes: 4a83abcef5f4 ("net: pse-pd: Add new power limit get and set c33 features")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 0d1e5d5039f8..3e333bef4e48 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -741,12 +741,19 @@ static int pse_pi_get_voltage(struct regulator_dev *rdev)
 	return ret;
 }
 
+/* uA = mW * 1000000000 / uV, which does not fit an int for a low uV */
+static int pse_mw_to_ua(unsigned int mW, int uV)
+{
+	u64 uA = DIV_ROUND_CLOSEST_ULL((u64)mW * 1000000000ull, uV);
+
+	return uA > INT_MAX ? -ERANGE : uA;
+}
+
 static int pse_pi_get_current_limit(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	const struct pse_controller_ops *ops;
 	int id, uV, mW, ret;
-	s64 tmp_64;
 
 	ops = pcdev->ops;
 	id = rdev_get_id(rdev);
@@ -769,10 +776,7 @@ static int pse_pi_get_current_limit(struct regulator_dev *rdev)
 		goto out;
 	uV = ret;
 
-	tmp_64 = mW;
-	tmp_64 *= 1000000000ull;
-	/* uA = mW * 1000000000 / uV */
-	ret = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
+	ret = pse_mw_to_ua(mW, uV);
 
 out:
 	mutex_unlock(&pcdev->lock);
@@ -1910,7 +1914,6 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 {
 	int uV, uA, ret, previous_pw_allocated = 0;
 	bool updated;
-	s64 tmp_64;
 
 	if (pw_limit > MAX_PI_PW)
 		return -ERANGE;
@@ -1928,10 +1931,12 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 	}
 	uV = ret;
 
-	tmp_64 = pw_limit;
-	tmp_64 *= 1000000000ull;
-	/* uA = mW * 1000000000 / uV */
-	uA = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
+	uA = pse_mw_to_ua(pw_limit, uV);
+	if (uA < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "PSE voltage read is too low to set the limit");
+		return uA;
+	}
 
 	/* Update power budget only in software power control case and
 	 * if a Power Device is powered.
-- 
2.43.0

