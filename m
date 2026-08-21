Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D33382397
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295866; cv=none; b=eRim0eT3Ej7ehzJGYdU3IyKYsiddD/53T+xXmUxZA5ucwON6TlEKqLdFv7QVS3r2L/9NursQzgS9Mvb9uvWeaDUg/cL3bNNqbbrsjnx+wMZJ5qJ+Jz3inJ80/XP9P+bsN/nqoqm19ZmPwFwMq7XF/CIIPC7CRK6Hgh6p1eVNC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295866; c=relaxed/simple;
	bh=kceR1WD9rU0gLSlXC/8jFxD0IxMnAmNomzwTUhSuZpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClfUJ4mxl1AOoHmxkSvAvAXfhmXopljc/HyKcgkjLN/uBijW2DOaq7gEBaquoMNB1scz99LBMHP0fhRXctbSb9vCs3/zwgq7jE/9Squg9198M0PGyyL0TLXLhInfuV3pLLMZxCUhjGLMYL7i+yra3jMQJplsHUEkrtkWQdZPkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oycgPuzR; arc=none smtp.client-ip=91.218.175.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oycgPuzR"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kceR1WD9rU0gLSlXC/8jFxD0IxMnAmNomzwTUhSuZpg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787295862; v=1; x=1787900662;
 b=oycgPuzRwKh52aLMDsEZGP2B7DNzzLOlimxwAb1WLqbiyUtWS+HKUV3oSi3dbAQyYOe3soit
 exN5SF4zaXkK+z2H1Xod3Q4c26PE2eRiy6HuRsprISWCkwKk9Uw3m/z8QFsTHZySqHHDpR9IoSQ
 Qi0voUwU7ztbWv5I04tNb6mU=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id b72289759244c0af;
	Fri, 21 Aug 2026 07:04:22 +0000
X-Mizu-Trace-ID: b72289759244c0af
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org
Cc: hkallweit1@gmail.com,
	qingfang.deng@siflower.com.cn,
	hao.guan@siflower.com.cn,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v4 3/6] net: phy: set PHY_READY after LED setup
Date: Fri, 21 Aug 2026 15:03:24 +0800
Message-ID: <20260821070327.16147-4-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821070327.16147-1-xuanqiang.luo@linux.dev>
References: <20260821070327.16147-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

phy_probe() sets PHY_READY before calling of_phy_leds(). If LED setup
fails, the error path releases the initialized resources while the PHY
state remains READY even though probing failed.

Set PHY_READY only after LED setup succeeds.

Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 4b9b2300422fb..891df46d0597f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3824,9 +3824,6 @@ static int phy_probe(struct device *dev)
 				 phydev->supported);
 	}
 
-	/* Set the state to READY by default */
-	phydev->state = PHY_READY;
-
 	/* Register the PHY LED triggers */
 	if (!phydev->is_on_sfp_module)
 		phy_led_triggers_register(phydev);
@@ -3840,6 +3837,9 @@ static int phy_probe(struct device *dev)
 			goto out_unreg_led_triggers;
 	}
 
+	/* Set the state to READY by default */
+	phydev->state = PHY_READY;
+
 	return 0;
 
 out_unreg_led_triggers:
-- 
2.43.0

