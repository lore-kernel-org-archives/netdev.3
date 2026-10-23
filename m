Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792719959;
	b=gaQQ/dINlYnLktpLYzb9Z4CVjxXHgul2lbHm0X5GTCZhErCoMggi/7VOsBnfOjsFXwqs
	 rOlDL7QYoLWtF8lYgybIkwuv86AdQReod/IfgsiyIVcG7e17akAmLtbMDOw/g7A322K/B
	 coAWRbTlyyost43jNUrn0+rtMR+oeVlThqvFt1CveLG4QLQucG1o+NvFus0lknmtpslXI
	 4d7YsrQTH5PhHD/loeSQ0wI8M70JVbRVgFXhr08FFWKoPxc6Eg6hRA5SfkZ6Z6PKdNI45
	 XomHMDG5gaNoZ///yD5RhCy/maCK5RHf4llZse4Nqj2SdHkuzL1AIZ4X6YrDDAyEVtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792719959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+2nBh2hTg9GyHqgEIUG/XcZolp0eeZD3+vc0j5AmUsg=;
	b=kASwxdbZ3/pC+FWtVE2vpsYh3qQhhjg+Ti6OzpH8xwXJYmoQxv+iaijyB61yzRP1Clj2
	 pQRtfiYR4ui9Ok3lGAQm5zSOJJYyiAOYnEj74cY8Gnqt+fOeFx04vYcPmpD+JmU/RDjUt
	 KOnSt6cqmYe74bzPKuhzOuF8sq0MMJ5GtffPH+JxPXXSuV6Q9CW0yfDe3qmygxxzz13yv
	 UGLWQzxLBmAbMn6R2du06fag1AgX0MgEkavRogI1k+rQTGaXoapXBB8hQ/k610p3EDCnr
	 BOK6Ae2zHNGfp+RbDeXO+PIjArN74bQyYqSCLktP07DG8p4jb9PiEsl1wTMzsXYAabw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corvaglia.dev;
	spf=pass smtp.mailfrom=corvaglia.dev;
	dkim=pass header.d=corvaglia.dev header.i=@corvaglia.dev header.a=rsa-sha256 header.s=google header.b="dk/5OzYE";
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB7606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79FB7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corvaglia.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=corvaglia.dev header.i=@corvaglia.dev header.a=rsa-sha256 header.s=google header.b=dk/5OzYE
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-679e86015e2so1768270d50.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corvaglia.dev; s=google; t=1792719958; x=1793324758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2nBh2hTg9GyHqgEIUG/XcZolp0eeZD3+vc0j5AmUsg=;
        b=dk/5OzYEkOickaCx1hnswEJdwKSiDOEwfv4hJWo7DfTah6nItgJP2Z5K9Lpj6PFbYa
         5s9mXQJZusreJ8yJj/0xRN7u4bd+oHtNECadgyakMML8IHFW5/2PRascJqWODb6Sug4c
         bK55siCkNzTkfXqOAUWJ+iM48VCgcWpQtTHPjdWHNTqmT8RlGMDzmzk6FhturKh1n/Ux
         F9M1/++QmlFLwqGyF5z1n0iRF9T5qiiFVC2620L3IJGEyYYHTQFQMHhlM0j7mcKO0DAA
         XwAzOMDVLP2JJIpX5HkV1GoaDfat0jNpCuBQwk+fsOPaRIji6TI6LkX8Q8wFAY0gAY2I
         eGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792719958; x=1793324758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2nBh2hTg9GyHqgEIUG/XcZolp0eeZD3+vc0j5AmUsg=;
        b=etvwcBUliPEWPUpCVbRb1ciA4x+0akV1FkHCwBdBqQQVjfXWuKeH+mqtpnSly+BDUx
         h+uE8wjNgKGMfJdXCH85g6dxbhDYjhZOlM5SNzS9KssK7O8yc1ofa6nyV0xC1Ql9gjwa
         st2kPUAJBuROKkFzGpWARjwPYt3q2Jy7A0UswNUoOGXq4So931M65BgF7xJdfzBrrwzk
         C4cqrQwg21mcP8Ya8R74y2mzM3gC5XaoPkBBzju6LG9maB4eDigzftvbhYHDLySARX8t
         YjGEyzHvtKyER+k//ZfAizzfug5LL4P1W4ChBxwn/1S4KBTmRvhSCzZFEeSvKt6LgLv3
         wHjQ==
X-Gm-Message-State: AFq9FYLVDAdrbZ6WUGDtSi/Fr8xt/xZyxMQwizkt3fAy82yfly3nQWbO
	unQrz/io3DTuMe5/aUUtHN/XFqtpoV80XFoq9dX8KL/n3trHEWmf+y+DUnsQbq4XAk/9sHQfqBZ
	FNMFgm6Mo4oM=
X-Gm-Gg: AYBFou0prXBkZ/QiURApsUeNm7R4tUHurm4rMi0h7XmNc1TrAf3q0PMLrdizOgio3RU
	wS1EGyX4kquFoN4WoMaSCOiZ5zQKCPJuPOy/9Q6qVBj2VFNgx3/tn5yAOlGB6e8z+PosFH2tAyZ
	6E11L1ZtQgcmVbanyT4WFe2W73ucj/Phj69S868I8z7zuevrJ7GaJnmVwPe6ah8zF3WYt9NarFz
	prWsccfZITZTRYEh1lQNC/rBM7TlKKEXpYDcb9ujph4l5mRbnM5ew1bF+Li2iD7+Knd9fs3FEVW
	tNzL+hbOOUtIHxX2vXC/88renf8jBf5bGYiA6cMb0vVp63yJB08A61WBGizbykF/0YbVdpZcaZQ
	xfjhuverTUxxhjhkuzXbOuFGGQHRKg/ot2LpTnhkIWgtSB9dJ7tZ3m0JxMfLKQva1SDASwrowOa
	dJKqSxYl79n1S4YkgNQX8BqO5LjeIWitgaVcouLAnCaUoNXQiAXfUu2LvdB49Cexmt2wdtCGL/7
	swmz+TrezJGsCrKKyydgCxXDoEJHnduInuDVS4/2cpmy0pESoL7rp177IdHSu8E
X-Received: by 2002:a05:690e:12c7:b0:679:9e81:e51b with SMTP id 956f58d0204a3-67a21ae6a1amr2754679d50.0.1792719958345;
        Thu, 22 Oct 2026 18:45:58 -0700 (PDT)
Received: from voyager.localdomain ([47.160.132.81])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a33fd8997sm628743d50.4.2026.10.22.18.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:45:57 -0700 (PDT)
From: David Corvaglia <david@corvaglia.dev>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Corvaglia <david@corvaglia.dev>
Subject: [PATCH net] bridge: mrp: fix silent truncation of IN_ID
Date: Thu, 22 Oct 2026 18:45:36 -0700
Message-ID: <20261023014536.72444-1-david@corvaglia.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IFLA_BRIDGE_MRP_IN_STATE_IN_ID and IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID
are NLA_U32, but these values are stored as u16 in their respective
structs. Values above U16_MAX are silently truncated instead of being
rejected.

Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
Signed-off-by: David Corvaglia <david@corvaglia.dev>
---
 net/bridge/br_mrp_netlink.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index 39f07e13fba5..5abad1cb3914 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -6,6 +6,11 @@
 #include "br_private.h"
 #include "br_private_mrp.h"
 
+static const struct netlink_range_validation br_mrp_in_id_range = {
+	.min = 0,
+	.max = U16_MAX,
+};
+
 static const struct nla_policy br_mrp_policy[IFLA_BRIDGE_MRP_MAX + 1] = {
 	[IFLA_BRIDGE_MRP_UNSPEC]	= { .type = NLA_REJECT },
 	[IFLA_BRIDGE_MRP_INSTANCE]	= { .type = NLA_NESTED },
@@ -241,7 +246,8 @@ static int br_mrp_start_test_parse(struct net_bridge *br, struct nlattr *attr,
 static const struct nla_policy
 br_mrp_in_state_policy[IFLA_BRIDGE_MRP_IN_STATE_MAX + 1] = {
 	[IFLA_BRIDGE_MRP_IN_STATE_UNSPEC]	= { .type = NLA_REJECT },
-	[IFLA_BRIDGE_MRP_IN_STATE_IN_ID]	= { .type = NLA_U32 },
+	[IFLA_BRIDGE_MRP_IN_STATE_IN_ID]	=
+		NLA_POLICY_FULL_RANGE(NLA_U32, &br_mrp_in_id_range),
 	[IFLA_BRIDGE_MRP_IN_STATE_STATE]	= { .type = NLA_U32 },
 };
 
@@ -315,7 +321,8 @@ static int br_mrp_in_role_parse(struct net_bridge *br, struct nlattr *attr,
 static const struct nla_policy
 br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] = {
 	[IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]	= { .type = NLA_REJECT },
-	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	= { .type = NLA_U32 },
+	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	=
+		NLA_POLICY_FULL_RANGE(NLA_U32, &br_mrp_in_id_range),
 	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
 	[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]	= { .type = NLA_U32 },
 	[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]	= { .type = NLA_U32 },
-- 
2.56.0

