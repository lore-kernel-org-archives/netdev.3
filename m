Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D49D466B55
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987425; cv=none; b=mbm5ryXFgybLKndQXrMTIeEakREQfjMkwylD3Lgopl4p/yIHLe7ATz3FLDey5BvoIi18cP/t+rxa0QZ8UbpNhpyjSJZl49H8bJgwucpSxhLUb/xLBcaioniLJATkUhoiYIJOP3ByQ7Z8Ae58qCrLR7+s0iNVbm5yLaDR+GkED1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987425; c=relaxed/simple;
	bh=rCB6DgsShyJygfa//P35LwjvJhkXabk9of/YaR+1F7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lw5mIvYZbzHAazbXFuX23oAT3tlg7vtgxTtx4er/5uXqqfgL1YrqKLZpBQcdiQz+lV3ZnnrBGKAv0HHvlBTV/HG/RQbQ01iOG/rTYMXO+Pd9SctGgbEXhO/Uz51l+PpeNnOsgltrzx2QxJOx0AzIIzp6fX3EnCzSLLoBc2U4gMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=PfUiPzki; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="PfUiPzki"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id F25B820728;
	Tue,  5 May 2026 15:23:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wCywqX1-5zMM; Tue,  5 May 2026 15:23:39 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2B23F206E9;
	Tue,  5 May 2026 15:23:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2B23F206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777987419;
	bh=EPzZvc/63O4SMrBt7XZZ4zy/2MrbFT43W69zfvBdQWo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=PfUiPzkiLaL+S4DJfL842+KLflPOQF9++iLsLoaJkvdmJkVSdjOiDzaY04qEm5rL/
	 6ZOJvBsHkgZy7W5Am9LpXzL4j/sd6pHgmTnhZCds/RPWmYX8UqAojhy/HWvueZYmeJ
	 pnrgWykjfhnkX/Hm5GrKCXmGRpSDYR/mpib0ti8x8y29rs+kR1sFNv5XbxdhJdQU3l
	 eOsEQlSnz0OMrCTq8Kkt2+/EcfhWT2gCMtuOqagpIGxcF1N0ZdhZAF/XvzR1nNPlQv
	 fGoURbRxppMPHaF3QxSR1/qSOmkumMylT94h6+/KbkDEUYsDfbmrEF0hE0q8mx3uu6
	 xPN4fk8V0Ryzg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 15:23:38 +0200
Received: (nullmailer pid 1364095 invoked by uid 1000);
	Tue, 05 May 2026 13:23:30 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 6/8] xfrm: provide message size for XFRM_MSG_MAPPING
Date: Tue, 5 May 2026 15:23:02 +0200
Message-ID: <20260505132326.1362733-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505132326.1362733-1-steffen.klassert@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Ruijie Li <ruijieli51@gmail.com>

The compat 64=>32 translation path handles XFRM_MSG_MAPPING, but
xfrm_msg_min[] does not provide the native payload size for this
message type.

Add the missing XFRM_MSG_MAPPING entry so compat translation can size
and translate mapping notifications correctly.

Fixes: 5461fc0c8d9f ("xfrm/compat: Add 64=>32-bit messages translator")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ruijie Li <ruijieli51@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d56450f61669..38a90e5ee3d9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3323,6 +3323,7 @@ const int xfrm_msg_min[XFRM_NR_MSGTYPES] = {
 	[XFRM_MSG_GETSADINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_NEWSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
+	[XFRM_MSG_MAPPING     - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_mapping),
 	[XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
 };
-- 
2.43.0

