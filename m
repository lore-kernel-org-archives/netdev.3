Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084230C63B
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461371; cv=none; b=ERFJfgBxVQfSEI+Rlqp5AKU50ZLPtFNLDy2QLzRvMjQkWwHLI4zsVbS25avJktQNANBqEcRIbJlQuLD2lRpyVqCH8ircyRXmg9PG5Lf5t4lkGGfxz05iRcf0M2vZ36F400Y5EAcpj6D4t9cCJ1rG2J6twIfOwOseLJmCvnSI19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461371; c=relaxed/simple;
	bh=lUzzbv3dGlKec3xqU1FQuAm3IeZcatRFAr7O1wHnHvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGVNjg68fRFLl/9+aExD8BixUu697TzA9X3boermIl78rtAN/f+XUL5CVT77iH6LicbIgvncburhrpN7oGR8iNDZpjtvwHFDvY/QVjBiwhQR0jZJbVwiP0gP7+0W1hCJSuMTZ5n1Q/4EFKtjPEmXPWUXTxsNSP37IdIDo/Orggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aPPK4mg7; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aPPK4mg7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786461368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkDNd23IZq1clyoHdi2tEr6MrS8hPxfhKjXC8RQlYi0=;
	b=aPPK4mg7u1FZ3Ww1k3sjbToVw5UeYNJfnPpaH6ZNDgt80n6CG7sJOVFIELja0zgBDDeswe
	v3AzXmigsofnX48DOD8rtwQRAwlxntWJh8UoSeMyXuCl7HthLugDb813y0P8AUCKRSbnh3
	OntgUFAvPHsnMCuEkb7qXlDGsLC4Y7c=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
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
Subject: [PATCH net v6 3/4] net: phy: dp83640: clear state after PTP registration failure
Date: Tue, 11 Aug 2026 23:13:44 +0800
Message-ID: <20260811151345.73582-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20260811151345.73582-1-xuanqiang.luo@linux.dev>
References: <20260811151345.73582-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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

