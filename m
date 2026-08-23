Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EEB25D530
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787457403; cv=none; b=DWHKZfDI6ZVtBziJkcoBqugnckQKbH4ESAjrs6OHeN3r7o37MDKkecdK7jJ6xfL+58QOz+n6gmhJs60eddekKq0Oo3H4fvHVhaLzu3GvLfexrkoy59XDUSZZNixVfuK3XUyLSkzD0oB6sZVIGO7K8fFnigb/QAmsbji7m7wM+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787457403; c=relaxed/simple;
	bh=kceR1WD9rU0gLSlXC/8jFxD0IxMnAmNomzwTUhSuZpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZ3j92flVI+xJIRtL3Djrm5HW8D0THWtBzlqxvt59WJsoI6HpWYf42R+WeAN1N8x8sOHIaJ4JOS+xJeyKUN/GJjKa1DAEMPG9wYSLbbovfD5T2B6Yh4l77ljaS2jKzNrIJEOH09eSpwEqpYgM3ToD58elO2+GdxJ8aga3+xGgBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OZ/Jj2Dp; arc=none smtp.client-ip=95.215.58.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OZ/Jj2Dp"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kceR1WD9rU0gLSlXC/8jFxD0IxMnAmNomzwTUhSuZpg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787457400; v=1; x=1788062200;
 b=OZ/Jj2DpaNGFLDO2frg6VbFamdIdTSE6bH9koxfnkySpX9UXlWaBI4lAftYyT7BZOC1THMLu
 Cw5CRvmAT3M1WUjkHQnD4EGqf2lDXMfOy+hczfBjAKR3dER4gii/gaJs9/aT0K3BKq0xvr8I6Em
 3RbZPnonVAm/Bi4k+S+8qd6A=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id c291d9e0db372878;
	Sun, 23 Aug 2026 03:56:40 +0000
X-Mizu-Trace-ID: c291d9e0db372878
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	kuba@kernel.org
Cc: hkallweit1@gmail.com,
	chleroy@kernel.org,
	qingfang.deng@siflower.com.cn,
	hao.guan@siflower.com.cn,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v5 3/6] net: phy: set PHY_READY after LED setup
Date: Sun, 23 Aug 2026 11:55:57 +0800
Message-ID: <20260823035600.188864-4-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
References: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
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

