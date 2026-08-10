Received: from mta1.migadu.com (out-5.mta1.migadu.com [95.215.58.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BF33D50F
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371377; cv=none; b=lF6FwTjHaZjATW1P0GKSPYTxU+N4UA+tGIoGsWSUaLldvTDX+QAUeRKHSGdo2xk4aBLQ2p0wnregRCwn3F7pEOTIh2irXFcYjoxC4zYxOCRov5V/V4or2PyrYKg0ca/19K46JKfH4n1zWOFAdUO1G4wMH8NjdwusegbkL9d2jX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371377; c=relaxed/simple;
	bh=lUzzbv3dGlKec3xqU1FQuAm3IeZcatRFAr7O1wHnHvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujoQuzcoNPntDj3nuMqJ4GRQW0YTlaA7qY7LdPuh97tHdITkpuApazbI+LsGVbC4kkwSwPhetqt0y+0IaZF3ZWfxnu6QiNPz54+pYte5gtWN5mlCLL0F7iIvq1RLVJx23ELmNPydzkmkivWn+PK4QBE0vGguLl15DyOZNIjJ3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xizpBegm; arc=none smtp.client-ip=95.215.58.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xizpBegm"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lUzzbv3dGlKec3xqU1FQuAm3IeZcatRFAr7O1wHnHvA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786371373; v=1; x=1786976173;
 b=xizpBegmk6dzEsqijFebaRh7yFA0gVvydYnLvdStXDe8NPLNxI8sVGDCMSJU91AcsyHm5WVL
 gw45DXxehLUpGa3yb/b/+9fUe/a+4GMFXmtOjBmHJn4CSK5lxNnBzzLoNICOeG5CeAjRgQBRp4S
 o5JFZw48aMKL8HbLvbBD2gIQ=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by mta10.migadu.com with ESMTPS id 6a6b1013ecee9598;
	Mon, 10 Aug 2026 14:16:13 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org,
	andrew@lunn.ch
Cc: kuba@kernel.org,
	richardcochran@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	luoxuanqiang@kylinos.cn
Subject: [PATCH net v5 3/4] net: phy: dp83640: clear state after PTP registration failure
Date: Mon, 10 Aug 2026 22:15:10 +0800
Message-ID: <20260810141511.73204-4-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810141511.73204-1-xuanqiang.luo@linux.dev>
References: <20260810141511.73204-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

dp83640_probe() publishes its per-PHY state through phydev before
registering the PTP clock. If registration fails, the private data is
freed while phydev->mii_ts and phydev->priv still point to it, and
default_timestamp remains set.

Clear the published PHY state and reset the PTP clock pointer before
freeing the private data.

Fixes: 4715f65ffa05 ("net: Introduce a new MII time stamping interface.")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/dp83640.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index ba39d30b74705..7aa5cf0a7bb03 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1449,6 +1449,10 @@ static int dp83640_probe(struct phy_device *phydev)
 
 no_register:
 	clock->chosen = NULL;
+	clock->ptp_clock = NULL;
+	phydev->default_timestamp = false;
+	phydev->mii_ts = NULL;
+	phydev->priv = NULL;
 	kfree(dp83640);
 no_memory:
 	dp83640_clock_put(clock);
-- 
2.43.0

