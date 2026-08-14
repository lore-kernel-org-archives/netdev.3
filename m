Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9F43BDAE
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714808; cv=none; b=X4ti5PY8Hus1cdP8gDx7UwGRA8yrnZrtstkjrVKWfDKWdBezZCdUdqELu4dv23wtjSDyg39uIA3g7t5eDRJ8/v1AEzzP54JDKiljWZ72DrfttfBPaUsWx3aDOypEOzLTRDJQVnMf0f20bTnwAk9Towpoxhqrhe6/RaIeuSMoeeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714808; c=relaxed/simple;
	bh=+uTgPFg+Azqeb3fY1uWHHNnu/zswUTZ7p3kCBzlM3MI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZE6XrrwjJDEAvYZ3G/k+6Sxr5ZqXausrShrOUjuG5ndll6eYbrDBce5GTd4rX2+omeTOxF1VsJU5xmPkVZLC7MimPUHTKLgTdAL7VETrUnCN/3vF6s1JZzHaGjk7fboBzHpTMZ/IOtSk5g1zJm/DlWx4zNtHe2KWeYUF61jeYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoPnVBHD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoPnVBHD"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceb096e675so12811355ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714806; x=1787319606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFVRGmgn5V4eEChiH9FkFvygFT37YCkX95i3m+2PnEs=;
        b=VoPnVBHD0JZBQU6NbAZx7GUizHI7J17DnR/UzBCgLWQMMoIcGQFZExrWbb9JSHqq5I
         vo3ykEhYt9+sOdz/Jbp7lQwkmGlWUAyO4jrABUQk41OFCuvOnHFfZaQmk4fzQLFhNyo/
         nxIJMguNRWbonQ9z2e8glAlLziIprGvScxccO+PEwVOKEgg7ExmN7yBV9xv0geBPjAIS
         3P9VwJ6zjexcJf8ayQkAi9GT8ZuZFVcfJ/i1aLod0ful7tu9psuRsprvqT1SYd3zItYR
         0bVdP2rXAnePvxVDVJKLFg7bgJq4+tuqcO8V1Tvv+1h9uj81bkI9aY3cpFdy9rwM6iZs
         y4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714806; x=1787319606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFVRGmgn5V4eEChiH9FkFvygFT37YCkX95i3m+2PnEs=;
        b=jh+xzaCT4ei4UQhKRZfGjsK4FLM/UlN2d8XQr/QollJF/IRmzweei/G5XCyxyHlg+M
         x6q467q3+gWEQDDbkYLXoUCy7U4OuNa9wC9be3GdNimycILJ/fju+Y13j1XPyae5AiMr
         oOKsHsY/8pmpmCKL3Shm8hRC1OxnqphWljmBMvdA8V9L6VXSVvARCpGuKt6h7rFiuGYS
         +DYe/KC70Ca6s0SfVfcYDqaNCso7Z3tU88srFZP4XgvU/iSe2tWN/fyoe+ARfgFm4i1+
         tkn4P7wUfYMQLlHK6chlVhZ0MAuedFFG4NabbGgzydl/cR0cUxvcLCMIZcYMZtg8mJMr
         Q9vQ==
X-Gm-Message-State: AOJu0YzXKJdGT5a7OwLcgcZ673t3Msr55MLzS/ofhdMb9XehuJSGBraL
	aM4MqHJyoQ7NDvL1Szga9tE/1QbBWsjS0s053xJHOpk80+lyNtxbDERE
X-Gm-Gg: AR+sD11zGLXD7fxIm95go6U09TW5gjN0dJeg6BLtZoSQOgoIYypxeZ4vrc72UqDi9sz
	jcXqjGBsC6NVH2/fA9YgFomazOkIsKr98LnF3Wa4E0s9bbsrRipUSpITYQq7P6D4ezIcy3bpVGi
	z8AgY1TjryR31xsshgqI9RMfSLU3E4yg12u1XPVh0uWLsYLOhCRuaOpCzUD25D7H00/P4AsZwO4
	HoAjjJ5umsMlqiexj4HfvzqSzxLsre8X0ZduYhTEWdRs5qgF0nDMQizOfrLmfNskassqnJ63LbB
	N/E6YSpQThbhITHcANEFrm+bOzx7B5he64SCYEk10KV76t9iUzppaaoxOBsRYX6kWkcd9lR9Hi+
	9aRLeHrR49NoCXTdz3+L5uEwg2iULgekWcqtuCt/jusms1blE7maHT40ZMaAe+hdpnO57/lh+9c
	jJQU3+tpjvaITzWUoDogVUB/vjEv7W2bQsgRr0vXvHnP/yaOHVmia2lQLwriAw7xyEFhFPHR3wl
	YlOw2z5
X-Received: by 2002:a17:903:390d:b0:2d3:89fb:35fb with SMTP id d9443c01a7336-2d3b04c40a1mr77796015ad.0.1786714806215;
        Fri, 14 Aug 2026 06:40:06 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae7c067asm10234305ad.28.2026.08.14.06.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:40:05 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	Divy Le Ray <divy@chelsio.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] net: cxgb3: Ignore link changes on PHY read errors
Date: Fri, 14 Aug 2026 21:39:59 +0800
Message-ID: <20260814133959.1386234-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PHY link-status callbacks can fail before initializing all their output
parameters. For example, an MI1 timeout in get_link_status_r() leaves
link_ok unset, but t3_link_changed() then uses it to update MAC and
carrier state.

Return without changing link state when the callback fails. A later poll
or PHY event can retry the update with valid values.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 4d22de3e6cc4 ("Add support for the latest 1G/10G Chelsio adapter, T3.")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
index a06003bfa04b9..cc04d21564253 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
@@ -1180,7 +1180,8 @@ void t3_link_changed(struct adapter *adapter, int port_id)
 	struct cmac *mac = &pi->mac;
 	struct link_config *lc = &pi->link_config;
 
-	phy->ops->get_link_status(phy, &link_ok, &speed, &duplex, &fc);
+	if (phy->ops->get_link_status(phy, &link_ok, &speed, &duplex, &fc))
+		return;
 
 	if (!lc->link_ok && link_ok) {
 		u32 rx_cfg, rx_hash_high, rx_hash_low;
-- 
2.51.0
