Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47F31064B
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047127; cv=none; b=E8OzNJH0OmCQsTOx5iFcg2hLgmH/tWiG3QGaBqGtmi0qjzOGgwR+2w3zdetBlcOtOztpIcP+7RDeb37S3LHVOZpWDYVj9i/Ur2BEnAAq+9MKeo5IM6YIIS2mphlo3LR/av+QHTbwGZ48Q0qdhEhRrgyJacyG1JVtD4gWgNlG8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047127; c=relaxed/simple;
	bh=dP3h+hLKsGm5KC/K2M0ypRB2Gy3z0jV1Y4qouUEoGl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRBCIZlXv7QuUrDEoJB8NDK3lI3845pAD9DZ3nvpQadYf2p0kyYFd0g6Y6Ngi+EnvguHKTC1feB9PkzUDAdYe/1sQ0df2P1WgTWZaXRlCqP1OozJbjBW2JFBuHLHcrfOlELI8wMbb4QSnaRCL0yJ9wFX4wSFX//75l9kAXj8QOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=DC8ydt89; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="DC8ydt89"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cace91f112so18405405ad.0
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785047125; x=1785651925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8zGbl4R2Ffos3phLd71l7Q80RIBm+fS5r/cqYD6HXU=;
        b=DC8ydt89KOZEagcMMu3d4p3qXlpjtNzUqC6SBtDRfRRn6IA4UBcJb4vvxeU1S6ongN
         1ocJuhDlGZl4swBGSH26xfWmqGaD45xEZBcvgZPD1OJWRF4r5YPHs13IL5unD+NjrQYR
         6Q3v0SBrClUqt2QfC4jSU3PO/SGza66hq27Z5/1Cpy40Iw4uRBpjpIStNAkju4CHObHN
         ZiKT3PTpvzSAldfxgb8NH4sXuz9luEvKTMSdZH72vYDkqt5ANkT4FTOjvLwv9U9egwoJ
         xKxpHO7qWutYuBH5+4C3gqEPFbunnvZ6bg8aqLgWfGfOwanGdlqM6Lu4ac/YH+HnI+gU
         5JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785047125; x=1785651925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8zGbl4R2Ffos3phLd71l7Q80RIBm+fS5r/cqYD6HXU=;
        b=L6ZN86YA4A4sjV93nyXSizHrSSU13GEnP787N8i9d6c3x6aYNYjBcu1Tm0iNxJ60r5
         dPrVpUN+ps8vkkGklHSSpHXooU1JOMe3kh5w/XqZIrb3QFilW2lCVHxpF8oM+MxMhaUk
         gu1+iY66hoJt9bF4Eo+QbtX5HYU2tmd6/ZNBmYU+7I+wBpHz968EsXIPRcqAO9Lx3Afl
         x1eLhOsH8zHVyntWxijvP6+xWV5m9ERKfEVK+oT+uSuZ+vsSzloydgUQF2KzlUoy2rgO
         wwbVUUeRwqYTFDhF05r61mbxm6LNFrdEfKUgF15/J9+asPaPT9+bmycFO4jtd2hmLK05
         E4vg==
X-Gm-Message-State: AOJu0YyR1Rdps0NDb9+MXxIj6OBH686DET18WyyvVYCcckgDoRWqY9Jp
	jaielGOPAP4NV+1Y81ZhK7bYkxSpQUyenNXcB0yQV6TSIvsCWms5x6ulzkieILLT4/xMeB8kSHQ
	ccJFMjSI=
X-Gm-Gg: AR+sD109TXwKX/+Of3+WzvvRIpz4gi05swzdZspY8yuLDjgAM6+i+nYTk9fu9duN6sC
	9HzGh5jt+6UPvUwM9+qGoW6Ci29a6OTne9zKcIy5b080pqhdkHxeM4A+BMrCsz9/0vCWcqsxUKC
	FIhPTxnbw8138MEjNqfuWFpuXEesUKr0CteysW2dMYfXgyZWq+JhPkbid9uXlHTwgNT73DW25Wr
	s5t706LafQGKhvHzQgz4bF+svNfjMHY4u44HdneJKFg0DXZ43ISfGoTfaO09JfQH/kQUkAwHDLF
	s6nA82O8qCBj7Kv8bbmwbcAGZbx/3CqfpCqqifh96x297dvZVm42Wgk0xtQoshZieumuymqFlPp
	y9kZtLDsywNla8L6dRKxmkNouO2iXnjFOU1lv0DSROrvbY7WFiw9nGfI5Cmv/F5D0/WwXVJM6iE
	kIHXOItiQyUngO3qxEuon5Nq4gqIdxCCGAlWh+pcY0mSHjHZvSLlw8KtD2dEib
X-Received: by 2002:a17:903:2310:b0:2c8:1f56:9fc5 with SMTP id d9443c01a7336-2cfde868609mr35863255ad.35.1785047124945;
        Sat, 25 Jul 2026 23:25:24 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bc413sm16689195ad.44.2026.07.25.23.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:25:24 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: bridge: mrp: fix uninitialised bytes on the wire
Date: Sun, 26 Jul 2026 15:25:18 +0900
Message-ID: <20260726062518.43774-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_mrp_alloc_test_skb() builds MRP test frames on an skb from
dev_alloc_skb(), which does not zero the linear data area.  On the MRA
ring-role branch the sub-option TLV header is appended with

	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;

leaving sub_tlv->length unwritten, and the two trailing alignment bytes
are appended with a bare skb_put() that neither writes nor clears them.
The surrounding oui and sub_opt regions are explicitly memset(0), which
bounds the exposure to exactly these three bytes.

Every MRA MRP_Test frame therefore carries three bytes of stale
page-allocator memory, at frame offsets 65 to 67, to any observer of the
MRP control traffic.  A capture on a kernel without
CONFIG_INIT_ON_ALLOC_DEFAULT_ON shows those bytes varying frame to frame
and, after a page-allocator spray, carrying the sprayed pattern; the
same reproducer on an otherwise identical CONFIG_INIT_ON_ALLOC_DEFAULT_ON
kernel leaks nothing, confirming the source is uninitialised allocation
memory.  Reaching it needs CAP_NET_ADMIN, which is self-satisfiable on a
stock kernel through unprivileged user and network namespaces.

Assign the sub-option TLV length explicitly, which is 0 as the AUTO_MGR
sub-TLV carries no payload, and append the alignment padding with
skb_put_zero().

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/bridge/br_mrp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 3f7126a7d720..a5548f475604 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -226,9 +226,10 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
 
 		sub_tlv = skb_put(skb, sizeof(*sub_tlv));
 		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
+		sub_tlv->length = 0x0;
 
 		/* 32 bit alligment shall be ensured therefore add 2 bytes */
-		skb_put(skb, MRP_OPT_PADDING);
+		skb_put_zero(skb, MRP_OPT_PADDING);
 	}
 
 	br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_END, 0x0);
-- 
2.50.1 (Apple Git-155)

