Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA13346BE
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540937; cv=none; b=ZdS/qWySIuD/kRpwQoRD5iY7Y8xKNtR+og2E1uHuKEmlQ7Pu0YepRZmOLHlXsabv6M7VKDP8lFgl84pAecRPH5qE44h0kRD+Xj18Mz82n1dMLVtBJgwa7YveQGJuoA+/gKUuiXw2AfTfxh6fRlLWlhXv3srjs0hkGmwVdnFkP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540937; c=relaxed/simple;
	bh=uR7tLD9tHL/cwz88WSK+sk6wlsliROfYasYpTO2rQBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPnJaStOKjEH8BvELIb7OGUN5DpZzTScs1bgowMd92fNaUPhUqSNHavkEWAMvz4A2ctJxMzddWY24U76xagYv5uNMb2K0OWp8otsyYpfd59rFGr6qfbQ6AElyZH0aY4qly8Q/Z6Rgtxj2hnIYK11SdXLgDIB28U3UDslZGYlZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAtmEJj3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAtmEJj3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cacf197759so19323125ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540935; x=1787145735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/5wq8SjRQDnjDD/nj5u1RP7jbzgzqJw5MxXBBo8cxuA=;
        b=BAtmEJj3ds0wfHxedqxZHTKxwnire6fv20IHE9Zv9UN+hkv6jal3gODTlaiwIaAWbm
         UwGBgZrjdMNKbIeX8rFOYB9Y+IoKcuqRcVUguF5QMRnFmJBFKr1fOkSD2AFRveQZTCGf
         CPs6MlW/fOIyyZGNQJEouVfx4GASxzGDGPxdbri2QUsxLKxerPx+RMsJ/M/fkiyK/8va
         /ItqB9UiHFncbMWmSKaPikEVdbx1rd8ZqC4mE4/RgCOMoRFh/JS09WUOQQUKgIigK6HT
         376eKJ9AGjrMeUa8az8ys5xI+aPIoC2tFl1nva1R9wfiP0B3dD+W7gC1LNsG5fBkIdp2
         +mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540935; x=1787145735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/5wq8SjRQDnjDD/nj5u1RP7jbzgzqJw5MxXBBo8cxuA=;
        b=ftwmZr3x7m2pEDCFQuJbKoF/C0Bj8+ndQfMweXRsRQps5y2OIVKMoqMjiPS+uWqQi2
         k6Svz8N56yLAX6rKlAMOL4IGKr0MAmKxGxs6kNoU/zJRt/HJwvDhKyPSK0RAq+Gi9d4X
         FGKn5TVzCeQx+D4fjmLZqdJesYZmm6ryeWxeAnanCCaFs8sxMiQBrS72nCgsW723tMeY
         iaAQvOAF0GVugvqeDOOmeqlMmgxB8yeReDjnK3kolC09PSA6il8apwdA3tLMrAxhk6vi
         Y9siGS3zMPkqrJRLCtf/2kytlP5dnRJkrCietTrtHAwp0H7E2CkEc0bmNS9vHKE+Co9P
         aRBA==
X-Gm-Message-State: AOJu0Yzt4bdqID6GtyNAFQGC/WgRWNJJnwBB4B3B/KrBxnb2zfPZ+R0q
	PuZvZ/lmTeA+gkdlcpKWdXilmZWoIwv0zaWhuf7spW/DErxLhSR+P5gN
X-Gm-Gg: AR+sD12kK2VzMfpDG6nu0dFgantcrQJHdAoab4K/pTF2AYiDprQl3I+HbmzuvcFNe+I
	z5AM/NEHI+xoYH++o/tTcalSjbs2ZtfrStw8sKrZOKWemi48mMlqZAInTm+qBuhB5Kthp662Yu+
	C9oS45FqRZPNCY4bBj6NwyC5XuNHkEbWyuEQUg4NAAg6GsS5JlsTPMmAmGqQS6jYDnIX7ikS4eB
	255L/K+Y2UG3HKhca1fLu03JDTDNrRs7jLnU13VwbtcVqCr/ddAXB5euaHaS2IH7QMo9usHdIq4
	mG5adaH28KyfAiPZ2XmXIAcraq34CGBi6ArHcRW9LvS9frPI5eHu2blga0EyvX1aRXdq35aob1e
	1TXUaO3JJtyBBppS4Uo2SgcO6rvroS0cNbXUvG336GDd/lIZUsdHM7thCEVPaZcL+xQzcouXsJw
	lRhWz14EHZLEYYcFs3bcsj/GxZxE/dTfOU8KlN+GGE9yKvsiNkOQwTzCFQ+8HtMOuwD9vVMyh8h
	8w=
X-Received: by 2002:a17:902:c402:b0:2c7:1200:bd7e with SMTP id d9443c01a7336-2d3455e00cbmr64022565ad.18.1786540935143;
        Wed, 12 Aug 2026 06:22:15 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2d35115726fsm6424415ad.34.2026.08.12.06.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:22:14 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: tung.quang.nguyen@est.tech,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH net-next v2] net: tipc: replace deprecated strcpy with strscpy
Date: Wed, 12 Aug 2026 13:22:03 +0000
Message-ID: <20260812132203.206939-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `strcpy()` function is deprecated and moving towards code-tree
elimination. Replacing it with `strscpy()` fixes potential buffer
overflow vectors by ensuring safe NULL-termination based on the
destination buffer size limit [1][2].

In `tipc_bearer_get_name()`, the 'name' parameter decays into a pointer,
meaning `sizeof()` cannot capture the underlying array bounds directly.
However, all parent callers allocate this buffer using the
TIPC_MAX_BEARER_NAME macro.

Replace strcpy() with strscpy() using TIPC_MAX_BEARER_NAME as the
explicit destination bound length.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
v2:
  - Target net-next tree instead of standard net tree as requested by Tung Quang Nguyen.
  - No code changes from v1.

 net/tipc/bearer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..951bb474c7d4 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -209,7 +209,7 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
 	if (!b)
 		return -EINVAL;
 
-	strcpy(name, b->name);
+	strscpy(name, b->name, TIPC_MAX_BEARER_NAME);
 	return 0;
 }
 
-- 
2.43.0

