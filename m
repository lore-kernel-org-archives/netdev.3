Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370C3AE715
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641395; cv=none; b=rFI/zm7mek3c5ps8KiKic8tbrhlorkGjchDDNDaP7JZH9v8EZz7hVMcGVEw61OVrmKwCKwsZTi/gn4q3Rg4+ITSPsGOz3xJNWlp4aViFM3J7M3skQCMSyRY0ulmdLG4bHlbbP0QCkwvWQo6TLvHYJ61eYbyrcluBu6ap5TebeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641395; c=relaxed/simple;
	bh=VAR/BMRTpPoFbnpjgp6JOFdYzGK3BwRxWbSW3bzmfYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMM+2Yh/vxhn0m5BQaLx4Fu7Ov+DLzKK5zGgzLudVevNrxWl/zxef2x3ceAGnyJNomQUlKgAG3hETYi/wz1Df906uRadDCEO+YfVhlr3HJP3AqbozGa33LiabCLMp89i05bfsdH6HzIvAB6Uvo/HrPSGUYb7RLbWQbdKw0N6dEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=G8otvOS8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="G8otvOS8"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B35C12065A;
	Wed,  8 Apr 2026 11:43:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tJx6vr6AEFqq; Wed,  8 Apr 2026 11:43:07 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5221B207C6;
	Wed,  8 Apr 2026 11:43:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5221B207C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775641387;
	bh=JJ4iNvdCNS1/fbJSGwNSfED+UdnhPnqYkNZK/EIMfW0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=G8otvOS8RuC1rGKQ2t9/6Iqp7vv+xg8aAR6HUMlRPTvgYgcjj5fefev28OvtHNN2P
	 zvO1QujrlBUhOzNP3Hlje0s2x9EHf0AH3OPX+ijRjTfzcuvi9X6c/2Q1vcWXYHUBgA
	 c56m4QuIzG07DKLwTvGgIj/tCeX1Sl4KF8uSWNEHamVc8VGXHGZ4NtdOfVWX718e6o
	 cAmjTY6tysSC3TDM7trOtp4JlDwx4ZXrsC/ykSEiL1TI143f+3NbLX/CKDtQyMIJsD
	 6z+r/nsZhjsRSKHsp6OOMAP9bfADFXJTfDAjCH3jE/4C1o9drysKHgVUnjh+YhC4Fm
	 S9Kueyr28Z09A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:43:06 +0200
Received: (nullmailer pid 150866 invoked by uid 1000);
	Wed, 08 Apr 2026 09:43:03 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/2] xfrm: update outdated comment
Date: Wed, 8 Apr 2026 11:42:40 +0200
Message-ID: <20260408094258.148555-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408094258.148555-1-steffen.klassert@secunet.com>
References: <20260408094258.148555-1-steffen.klassert@secunet.com>
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

From: kexinsun <kexinsun@smail.nju.edu.cn>

The function __xfrm4_bundle_create() was refactored into
xfrm_bundle_create() (among others) by commit 25ee3286dcbc
("xfrm: Merge common code into xfrm_bundle_create"). The
responsibility for setting dst->obsolete to DST_OBSOLETE_FORCE_CHK
now lives in xfrm_bundle_create(). Update the comment accordingly.

Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..7bcb6583e84c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3910,7 +3910,7 @@ EXPORT_SYMBOL(__xfrm_route_forward);
 
 static struct dst_entry *xfrm_dst_check(struct dst_entry *dst, u32 cookie)
 {
-	/* Code (such as __xfrm4_bundle_create()) sets dst->obsolete
+	/* Code (such as xfrm_bundle_create()) sets dst->obsolete
 	 * to DST_OBSOLETE_FORCE_CHK to force all XFRM destinations to
 	 * get validated by dst_ops->check on every use.  We do this
 	 * because when a normal route referenced by an XFRM dst is
-- 
2.43.0

