Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABF357CE0
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295893; cv=none; b=B8sVs2lBhCvxEdkyuDtjyxh2Kythenq22coV/sMcyP3ye4b685RsoKtQO8le1nr6qv/QYSbzw/bGqox+XGmR2vFbhaUeFtTtaYthUkZpfMVRfsmi3aS922qOv3Eoapa97SAUUI2zQJIbSROsIuhYna3kbnSfhIi5C4JkcsMtkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295893; c=relaxed/simple;
	bh=DPdelFgodIfEtmagZl8+Evmyjeurak0kZ5Io6d7ielI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I07DST82jkADI+KLD6vh6LVpr4fBH+5fsTrG+0OUkzLI0s9iRi2jw/XdG4fIQ6OamUyAgJY7j1FFu89kHH32K+ekXrCbe+7YAZs9773VQYKNHxDVQRiwa9Gs4mWj9ACAfICqWCTkl3V0oxkJO3BGiZov+XNHrjFTlLva+d+Eujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SREtXM3p; arc=none smtp.client-ip=91.218.175.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SREtXM3p"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DPdelFgodIfEtmagZl8+Evmyjeurak0kZ5Io6d7ielI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787295889; v=1; x=1787900689;
 b=SREtXM3pyTyDHbTiWPVU+wSrLg84N31GVxa4umXzGlZMPj2ElXMX5FqYr8NgJh441s4oB89H
 PEMAUxNCUq0MqAGB1Zgi/K349F5P6+g4p+bH6J89Zc9eAYlYigqJ7tsCgHB7RHuf2Mi31RDyxbm
 Uf3PIp3VUDMFOtx07NUdGluQ=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 9b0adc2a607b779f;
	Fri, 21 Aug 2026 07:04:49 +0000
X-Mizu-Trace-ID: 9b0adc2a607b779f
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
Subject: [PATCH net v4 6/6] net: phy: avoid double-free after LED trigger registration failure
Date: Fri, 21 Aug 2026 15:03:27 +0800
Message-ID: <20260821070327.16147-7-xuanqiang.luo@linux.dev>
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

When a speed trigger registration fails, phy_led_triggers_register() frees
phy_led_triggers but leaves the pointer set to the freed allocation. It
then clears phy_num_led_triggers.

phy_probe() ignores this error. If device-tree LED setup then fails, its
error path calls phy_led_triggers_unregister(). The zero trigger count
skips the per-trigger unregister loop, but the helper still frees the
dangling pointer.

Clear the pointer after partial registration cleanup and make
phy_led_triggers_unregister() walk and free the array only while it is
present.

Fixes: b7f0ee992adf ("net: phy: leds: fix memory leak")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_led_triggers.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index 4eb7716bb9d6c..ff6e518395be0 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -126,6 +126,7 @@ int phy_led_triggers_register(struct phy_device *phy)
 	while (i--)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
 	kfree(phy->phy_led_triggers);
+	phy->phy_led_triggers = NULL;
 out_unreg_link:
 	phy_led_trigger_unregister(phy->led_link_trigger);
 out_free_link:
@@ -141,10 +142,12 @@ void phy_led_triggers_unregister(struct phy_device *phy)
 {
 	int i;
 
-	for (i = 0; i < phy->phy_num_led_triggers; i++)
-		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
-	kfree(phy->phy_led_triggers);
-	phy->phy_led_triggers = NULL;
+	if (phy->phy_led_triggers) {
+		for (i = 0; i < phy->phy_num_led_triggers; i++)
+			phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
+		kfree(phy->phy_led_triggers);
+		phy->phy_led_triggers = NULL;
+	}
 
 	if (phy->led_link_trigger) {
 		phy_led_trigger_unregister(phy->led_link_trigger);
-- 
2.43.0

