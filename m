Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792023C1D71;
	Mon, 14 Sep 2026 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384847; cv=none; b=po7FJw0xBbst4cJoyuXfDaOI0HJFpknHwfpQadt2BPJGLmzNglm3h9n8l95pU6I5c5voyfM5aqIlC+VkDG64sys4cs4g9G+DsmjbUnkZaVPpzaGugfkGTl7FIn+sFFgd+r1EP83jjQZyw6fJgXSc5UxctZ8E0ULEAWHMnL6UWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384847; c=relaxed/simple;
	bh=BK2gSje8Ntak1aO0ck7/sISfvUuuJTb9T2py0KTIaxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QZfnk84SqIcPwHeMVTRoU0Va/03V+SMc0YFmeWNnDHJOf+IPVhv03+ROkl/GM/DPpSK0ptibxsZGQzwGAbTQCBI7m4/Oa0hVXrJu10tICYouPz2TVkcxbDEOeDD6OuUP8ZFQ7ilanzX7GyfX855JnA3rIdDB5DQ/qs10SPQkSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hZ/psEfE; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hZ/psEfE"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9nBH9271386;
	Mon, 14 Sep 2026 04:20:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ut7yXY0OU9Y/iDyP7tdE1eJ
	sQ1JlnvjIivyLM+I0fho=; b=hZ/psEfE5GtUPAjLm/GLDjjb8Tf4l+tNKBOj/MF
	m1eULLKZpabyuLo6flpSMQSClQRGdjHeoOEklWtHBaciAqTkKcH2jZKz+PkIfWsF
	ehTI+zr0WMPBTEFUgGadStxhquDCauc4rwDXCJjiPXc+b+0coPLsSUHR/XUw9RBf
	GGMKMLQBsGj0dYZDY5bJan4/iJFic9jp1Gk70lx4THYy+DJzPz3TLKkSnTk1dbpu
	JNnHuvFYk8sqkvAJw5inWlx9p3/c5st9AA7ZK5jCCMjxybGGQj90xPPBqQ5Qg+Hq
	934DQC+fUz5lrbI5hu+EbgYIebchqFW7IXO/h/LOj5ghiVw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gpdm1ge22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 04:20:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Sep 2026 04:20:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 14 Sep 2026 04:20:33 -0700
Received: from c1illp-saixps-016.eng.marvell.com (c1illp-saixps-016.eng.marvell.com [10.205.40.247])
	by maili.marvell.com (Postfix) with ESMTP id F41F13F70A3;
	Mon, 14 Sep 2026 04:20:29 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <enachman@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <yevhen.orlov@plvision.eu>, <taras.chornyi@plvision.eu>,
        <oleksandr.mazur@plvision.eu>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <error27@gmail.com>
Subject: [PATCH] net: prestera: return error on hash table init failure
Date: Mon, 14 Sep 2026 14:20:26 +0300
Message-ID: <20260914112026.2822222-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX5YEoBD+uCJkR
 En9Ucm93P205YjB5vGussKG+LzrqzKEHdW2kUsrOLgkXo/55N1dsaR1jXX34tFg9M5/eTfBQYDt
 W0tGP5HXl3NUGPKoxV/tKA/wfB4U+oXDsuqtG1MheCMLuFurr/bAeEkWv5O2Ho1Ot97xFM20Ehi
 YjOHSfS0ywtJzl1adkH98zRQfYJtEDu+sJRLijcXIgByK/940bqvSiCZTlFxk8OJWnIaXwoJgBz
 VgYckfX3rspVZMlyDyFiUxIO4Piixq3bYpjBXpn21WWkl/y7O8/uWakvB6guA60tON+jeRpQCj/
 hFzeOtpN5Yk5xMBL+6Htiz14Dn4biHtUo+WWNKuNCyeScZPRNl2jSsVBu8dniAcMGvzRCx/wHmG
 Nz2qCTjQ1evNLp6MqlgmZRnYkMb+Vk2pn891T7f5KLiDBKG0vFQYZ44Cp0m20u8zTzjRnl0nUUI
 rDjGCaw28ywfJQ9Xg+Q==
X-Proofpoint-ORIG-GUID: Q5XdNFhkz1jW-SGRF7zjlw6qUUE0GbU7
X-Authority-Analysis: v=2.4 cv=G8WJgNk5 c=1 sm=1 tr=0 ts=6aa7d881 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=-CJc6eoNAwWmckaBU6oA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Q5XdNFhkz1jW-SGRF7zjlw6qUUE0GbU7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX4VuyPXb8dnh5
 DZc5K8bWfDyDKRTeKfRAsK1ST4Ty47OhsxCx51bzd1R9GY6tow73eaUIGAUY0a5FIWZBb9d6/Dx
 TEHosDcNf8JJLjojteUp7/+q24/jUoc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01

From: Elad Nachman <enachman@marvell.com>

prestera_router_hw_init() calls rhashtable_destroy() on error but then
still returns success. This causes prestera_router_init() to continue
without error, going through line 1623, and call
prestera_router_hw_fini(sw), which will cause dereferencing of freed memory
'sw->router->nexthop_group_ht.tbl' at line 1560.

Fixes: 0a23ae237171 ("net: marvell: prestera: Add router nexthops ABI")
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/kernel-janitors/aqT9h61WBcslE0gJ@stanley.mountain
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_router_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
index ccf6cf98920f..4785fcb62735 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
@@ -93,7 +93,7 @@ int prestera_router_hw_init(struct prestera_switch *sw)
 err_nexthop_grp_ht_init:
 	rhashtable_destroy(&sw->router->nh_neigh_ht);
 err_nh_neigh_ht_init:
-	return 0;
+	return err;
 }
 
 void prestera_router_hw_fini(struct prestera_switch *sw)
-- 
2.25.1

