Received: from mta1.migadu.com (out-153.mta1.migadu.com [95.215.58.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA033CB546
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119391; cv=none; b=MrNZNuPEm7nEUdYkeGQQRI0q6Wcsns03oOIhBUtJqynaeqLE4PxU2Nnlp15RGyhLVbrbcJ7oOoaho5h974i3TXsCHWrGhi/6eLI2O4cF3CHauR78QWJTzfXYT+fPmVHLaNPd+KgEZSXtty1vIsJlEf+8D10J1+Ie0tMMCyYXGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119391; c=relaxed/simple;
	bh=7fd8iX7HvFHjWIPbWAckzSULKH2drvaBAS9xUkB+rj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPOV3CGeSFRhYR/PJVV0Jcb9T9MEA455lgwh4c0e2DpuGcfJmW/QP8k/9nY8Wdwjuc/UqgoBrzdtiFvz4PLpV3WEnS/4+z5yHqUbvwmWsVbDsoQ907Wh7+g5R8MBrXpFgXnr+UOotthc9ZwGEC1vf4gs8nXANHNe4msDz8/+A/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iysYbjrM; arc=none smtp.client-ip=95.215.58.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iysYbjrM"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7fd8iX7HvFHjWIPbWAckzSULKH2drvaBAS9xUkB+rj8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787119387; v=1; x=1787724187;
 b=iysYbjrMFsv9rAXPLYv8kp120sA+XtURNjbig3l0/C5BJJyjh7fPnP36Uqtgk1zZ+JhsS+xd
 rhOgZgRWt0sByeNTTS7/QeBUNHEUNMD/s03oIrS0Sp9vc9sYzZWcz9e6QuWzpckmew29ikt3MpK
 YqGWQdlrzjcDKc3LvIBql9VU=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 896faae294527483;
	Wed, 19 Aug 2026 06:03:07 +0000
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v3 3/5] net: phy: set PHY_READY after LED setup
Date: Wed, 19 Aug 2026 14:02:34 +0800
Message-ID: <20260819060236.24665-4-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
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
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 538e9ca44d093..8fd6fbf378f0a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3799,9 +3799,6 @@ static int phy_probe(struct device *dev)
 				 phydev->supported);
 	}
 
-	/* Set the state to READY by default */
-	phydev->state = PHY_READY;
-
 	/* Register the PHY LED triggers */
 	if (!phydev->is_on_sfp_module)
 		phy_led_triggers_register(phydev);
@@ -3815,6 +3812,9 @@ static int phy_probe(struct device *dev)
 			goto out_unreg_led_triggers;
 	}
 
+	/* Set the state to READY by default */
+	phydev->state = PHY_READY;
+
 	return 0;
 
 out_unreg_led_triggers:
-- 
2.43.0

