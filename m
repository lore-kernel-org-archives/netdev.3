Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D8213E9C
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422293; cv=none; b=P/CxINow5q98nCSkDsR3u4M+DNoj8lrbu+SP2pfR50qy9MUeNXaK2wrwSYs/A6n0CmQEkxhiiVfX0Vav6u7I3qNygXJUkmpTaYOiZ0wjgwiDy2dMWSZfhdLaUWZ2QkGyqL2KPjpHTr7Tos/OdmFKYEj8d+uvbLg9HZqgTIdDzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422293; c=relaxed/simple;
	bh=T5cmr4AS4Mc5RSkaZ65eKN18E4FTywsUwCGNvI0ai1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sY2t+svGJ1rVcztHd7fx5bEYKuLEM8+6kgXG6cHWgfU9bvntt0Wv/myYKKkGp85fEnK2l+NmKMpcEN2rb0VMtW1kXqzER+fWH2zRRJYCZgkXHn5JNsPEV5eg4SFEj5SyjS4u9DQk+7xLncTtiKAYgswlfuYInf3XGEBRLNL7x+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVS1dfXR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVS1dfXR"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so1809761a91.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788422292; x=1789027092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yd20SNdmG7z7W+LdlhedLQwdQEcbKDOr02wLEKBgbwk=;
        b=GVS1dfXRcuszcELA8fxCtlcReDBmnL03gtolFUmcvcSj7sp+b3UgMc/cg7fFeMpNTC
         slzYwnWohlUjIoaCDkwPzTcX6gFH0EdXqV463t5nTO3Jzt8MgTVxe9Jmll41SRvqgUuQ
         OmjyaZlCEotXoDJ2Go1Fsh3avUJzjnK1yaA/NWS6JL2Mt0KBJ45nH7dnlZov4bsKDCNJ
         nZxrYNP81aFBKdwu+plSj/zZfbIlTpYxMBzEiOciRFgfwvO6x3l8Cz359fW5SRqKx3P9
         L5QhPvoz/3crzO8XYGkYHX5/umiZjrQPv3nWz7ZcN1p5utprmKvl/Ek4D2jCbRggOq9J
         shUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422292; x=1789027092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yd20SNdmG7z7W+LdlhedLQwdQEcbKDOr02wLEKBgbwk=;
        b=mrXurdHM1+W1YWCQ2gTlfSkngy4cD9L7kYM5jTjjf+c02pp7LYdQFwbKtM0hECJHMl
         BiVkcnIaQDqJ/bT75oAX8QbdtNkRZEPOD7pRbI30gSIoMzdTQ0VTuPsrSKh/Mny/DdG5
         yiksfR90U1lT31Fd8nZ97vaHfkHlJubO8zA+GkqMjUyEFpv9f1L0mTXstAphnGpw2nGk
         72LDCYA47xw4Q4yEaL7Q9dKULBKGiWHDB6os65geKSl9IBu+Rh87PB0O52BWiTDZ3F3V
         SQSqiLwYib7lmBuh6GGNeaxUYdB3FhCQeaFXtJRuxWwIWmC0oP8OgyZ8YoFQC/b1eExs
         3cww==
X-Forwarded-Encrypted: i=1; AKwUvBxqDCmsf35PA5V22mZXkdGnNaPjyJw/odpZCl7ceKolQQarXfQItb69GxjE6jnxGL6tfcf0WFM=@vger.kernel.org
X-Gm-Message-State: AFuF++n/SljMbcIBvVEop/Qck8JIIu0a0EOCVaeOYsHK6XDv4bN2vi63
	uxp+rOfFotM6a6uFQ78sA1N9yd5ebQJgS2h3MacrJVq6LztdyS1GtvuO
X-Gm-Gg: AYBFou1CYG4NpyWwO5dTyy76B/MuF22k8C8suqP6wdtmLFnshlG304ecFG9myFsjbvR
	IsoH1844u5/Z9n7bn/5m54bOwd9GWC5sSDbkb5gX9Ghr4O+K8RpBUD5Ua7t1xnJ5slePZ0tK9Bl
	WEjWbNojCzkksqJVbObigVVmmHoz1KFqDvxDdeu7OZnuNQJBnUsW4Oy8Dllut1zhA7D7/MIDd9A
	dc2IaX9svQy2+xrQ8FTQCoDqbtGBuRSASmx6iu9NeeTmDARx00bdaLN1o6umcjwWGAVp2Oj6eha
	wP6ptfSzaHF/qEZXLCbG2Sv5vsmlfBvpcVVxKioBrdv+2KNQ+VN0zMO11E3PBkUCSpG7EIy4HLf
	P9ACmnHgotKz15frxldkZ+HbV+Iat0d9ghiMvrjhkwBGzMiU58j30qmRQ/NAjePX+Et/x/fQZid
	KLFFrOUaYTa5AIWcdvdy4L7SPewn3bXARCqSzfi3tUjfXhiAkjf7tT/pDT5XsG86ypuxTPRIwJR
	x854We4xccb46NPV3vbwl8MK6lyL0EGD93R2BnPNnPbIgFACe+6KxRqrUJ331Ubq+sHlRUWY+V7
	aqIj
X-Received: by 2002:a17:90b:3909:b0:398:9c0c:7c72 with SMTP id 98e67ed59e1d1-39aee204517mr13918913a91.25.1788422291920;
        Thu, 03 Sep 2026 00:58:11 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d845sm3826300a91.17.2026.09.03.00.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:58:11 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v2] net: mvpp2: simplify IRQ validity check
Date: Thu,  3 Sep 2026 14:57:53 +0700
Message-ID: <20260903075753.346647-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails.
The current condition also checks for negative values, even though
irq_of_parse_and_map() does not return negative error codes.

Check only for a zero return value to match the semantics of
irq_of_parse_and_map().

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Link v1: 
https://lore.kernel.org/all/20260824100758.31622-1-phucduc.bui@gmail.com/

Changes in v2:
 - Drop the Fixes tag and rework the commit message to describe this
   as a cleanup.
 - Add net-next to the --subject-prefix.

 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index ccc24a1301f2..1c50174c9f1e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5874,7 +5874,7 @@ static int mvpp2_simple_queue_vectors_init(struct mvpp2_port *port,
 	v->sw_thread_mask = *cpumask_bits(cpu_online_mask);
 	v->port = port;
 	v->irq = irq_of_parse_and_map(port_node, 0);
-	if (v->irq <= 0)
+	if (!v->irq)
 		return -EINVAL;
 	netif_napi_add(port->dev, &v->napi, mvpp2_poll);
 
-- 
2.43.0

