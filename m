Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB91A37FF6D
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648899; cv=none; b=fZ7/YU0aBazwFP1v847eBWGIvtZYGLE8nuWaGDSLrVykT12C0dG3306XKyytTs1XMn5qV25blwaRtusn5L3obWkyWOZrYqf/zqv4cQIiI1xIXReNvCuDd/AsJt4AXaA1tE/tr2dSLDfDPSWO+Jntey4TyqlB9Ik4Bbz46GPPaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648899; c=relaxed/simple;
	bh=vv8PV5ubYJpjgCVez8EfNnQ5d2wjNYWxAZbqsZfNvpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WeFTAbltToHoDOtP4kDnu72r6AZPCSoJe449+IK9sejrfxoU9wUi6CVosFlVWKq7zvj5q4mo35KNBs6ZUThnTPMKGpeg9B9Hv63hDX0Y/dlrCLP/o1SguQZJCqI4Asm/pi2NxCFgxDF5AlKaUwaxoMZj0SM2M3iw4vMDu0Hn8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYGS83AU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYGS83AU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so2003405e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786648894; x=1787253694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+7NB8ynmNItA2zqEEd8ZtdSkai2iXlE7wEPBOLcYnsQ=;
        b=gYGS83AURLUwgq7r7T6XZKHBJevWsjxH44GPL6VZJr9+bkpOQL77vVDrUg5qT4BPDV
         QHKC6Wre7EmUlvJ/eiU6QQUVrAJDJ+jLq9F5jpZoKhKDkxrz+3ONdr1yD759csWvSV2F
         2E3A4SrFUYBXwI3GCpHUchVlBd0ybGfBc0qwA0xgQvVXW2UM5nTJyQzL7CATcJYnuRVL
         GyE7GEFQJ0Xn2psjQLvRrtEUlK+MF/D1JVfkT7bcJ+tSnffONrg9AdirDq/Y0uaZh4+j
         w+fkYXbigSEikTkEyuMWrjDiVWxiCmmbjvIkwuSG0d+ynExtkzQKeTSU9rydQbZqWv//
         xijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648894; x=1787253694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+7NB8ynmNItA2zqEEd8ZtdSkai2iXlE7wEPBOLcYnsQ=;
        b=q1ULYVnAhkjMLyXh7h0vWOSaOjSaVXd0kbWfqjrg3m+L9yBTKBxuNCaqOjehOLYivU
         RFVkLKI4UeylaEr/R97dIhQQeIizJB3DUjvXfsWRItRnv+cawUS+f0dQi7IQakQfBDC7
         JEV2pe7kS5MPS7owxptbMyXqN/5/86AfLZruuVKRntnb4mn1jVMUTTxq35fqxZtVhzUO
         DwPpIqRIgy7iLnDKJoBmFLAoJosY7Yx0JwAxdx/ftNn9qsjvH7ZkcaIW5CQT7em3SCAo
         PT0KFhX2LUhvo84GCBGr+82HJ66MrG5QxiW22m3AlS4DIAyI/omXauhQCWISprrNlGcF
         gCFA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1yD4FO0lMrWDDWIh2Sr1VOiJ+5QWUepXivPfRwXyuMdv1+JTFqX4zj2Ltn1PqBkHJ5MJ2Pts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhyIy7EMRl4HaEUHhmJnO7IOlKkP5IGxqEMnUYaAoBFS1FNcjP
	Xx6MCgdXBkIqKFtRmMGimbufA1GWmAKQQIxuVv272eidcfWchUtQ5v7l9q11/+qr
X-Gm-Gg: AR+sD13RvKDp53A2G7oPTfenkK33+oGUM3KhwaqwNewKakwQOP2hp6h2MSflspx70tL
	lmlM6+uTk+nu5FeWcKm9Uubv+3Ocgm9dA4H+ajE7TfTgBWeDzaoixgWIsRIZkZ1Pt9v/cI7LKyp
	dYQcV6H0Lav2GynNriDJTUD/H3sIE6to9WAD17LMh3lWFWkh07fhWQCBBnTb7x4uNskERYue/0G
	X17VHC6cSCwlkyoFKglN043WMDT0Fd7AR7RmyjTxT5IH0O9mJz4xppLEKX8oNoaltTXF7Z8jfo5
	YM0SRLwD3qdFp5/lAmphcwi4Z5Nc+r0WC+tcy+7gXG34cvZdlUXZ0jmA/siRxGy93L5qrW8PF35
	F9MNgPV6yVTnVlhUyEcvirb3YHb919XQvmaic5z8n7t1HzEJ2nCV/Z+44DbPs9by7jgplCh2BNh
	g6sCXM99gnN/PnMnb2E6/O6/1WVpYGANM4dYcJ2tSMGgr4MehhhD3SV7yLNbhKwBP2yz1bh1CDX
	R0mt86WYwyIpvuWI4mhn1xkRZXk4qbO5gsLuzcyQkP9CLVOdNuybBBbAEFYpdQPTvhtlgZq3/yj
	yFEJOIObk4l0u3ZT8BpgfclvG0Z9aOXHPV4MFIA/7JgVfzIBSXI3qUL8f28MmjjXDj2V
X-Received: by 2002:a05:600c:228e:b0:495:4e1d:82df with SMTP id 5b1f17b1804b1-499879774bamr6459735e9.10.1786648894179;
        Thu, 13 Aug 2026 12:21:34 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c79-1f01-1565-573d-10dc-99f9.310.pool.telefonica.de. [2a02:3100:9c79:1f01:1565:573d:10dc:99f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49983f10469sm57977695e9.11.2026.08.13.12.21.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 12:21:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net_shaper: fix net_shaper_ops kernel-doc
Date: Thu, 13 Aug 2026 21:21:31 +0200
Message-Id: <20260813192131.21254-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Everything from the "Driver ops vs uAPI" heading onward is dropped from
the rendered net_shaper_ops documentation. Older Docutils versions do so
silently, while Docutils 0.22 reports the nested headings and adjacent
list as invalid.

Use bold labels and correct the list indentation.

Fixes: 16812d9674d4 ("net_shaper: remove incorrect comment about group leaves")
Fixes: 26bc4cfb1737 ("net_shaper: clarify the kernel API / comments")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The omission is visible in the current linux-next generated documentation:
https://www.kernel.org/doc/html/next/networking/kapi.html#c.net_shaper_ops

Tested with Sphinx 9.1.0 and Docutils 0.22.4:
  make SPHINXDIRS=networking htmldocs

 include/net/net_shaper.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
index 05cb625b0fe54..a2eb616a19fd0 100644
--- a/include/net/net_shaper.h
+++ b/include/net/net_shaper.h
@@ -73,20 +73,21 @@ struct net_shaper {
  * Each shaper is uniquely identified within the device with a 'handle'
  * comprising the shaper scope and a scope-specific id.
  *
- * Driver ops vs uAPI
- * ------------------
+ * **Driver ops vs uAPI**
+ *
  * Members of the driver ops mirror the Netlink uAPI but driver calls do not
  * map 1:1 to user calls. Drivers need to be careful when assuming that calls
  * disallowed at the uAPI level will never be made at the driver level.
  * The shaper core performs automatic reparenting and cleanup, generating
  * additional calls. Notably:
- *  - @group calls in the driver facing API may have nodes as leaves (user is
- *    only allowed to construct groups with queues as leaves)
- *  - @group calls may update leaf's parent if the parent is about
- *    to be removed (re-parenting nodes explicitly is not supported in the uAPI)
  *
- * Implicit creation
- * -----------------
+ * - @group calls in the driver facing API may have nodes as leaves (user is
+ *   only allowed to construct groups with queues as leaves)
+ * - @group calls may update leaf's parent if the parent is about
+ *   to be removed (re-parenting nodes explicitly is not supported in the uAPI)
+ *
+ * **Implicit creation**
+ *
  * Shapers are created implicitly, meaning that @set and @group operations
  * are called both for existing and new shapers. The driver has to infer
  * whether the operation is an update or a creation by tracking the handles.

base-commit: 3205699d79f262412c1be7fc1c04066610d3cd52
-- 
2.53.0
