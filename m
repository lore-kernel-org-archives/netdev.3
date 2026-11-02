Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606692;
	b=QkqDYgD+oqOKRS2sgdEknoPGFyf8eWw44o/OCRmj7v3c1FgjfPTIS2bEXnfp/C2hGvA7
	 fDEKpk06Lmtd8DsDBjsFU1R71GrIizgXEd8/eJbARZRrGT122HZMc6v5lQgazGCaGBwoE
	 G1p9UY1nkiPfZrPG854vRU5tDvio3caIR9GVG5N4Q9oc7d3ujfvfxKmRGLLT5m4+60O7N
	 /IjB/V5iDyebTKlTQZGT2g4IT5goa70jxRK5a7/FSso/O3H4fTtowRfZ20cG49a6NYh24
	 9cEHww96Jd82F2r1DLONe2uCaQ1rQ/dkVXMPYyphEk6ID0gxHl0Wkbdx385nv4FQGsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606692;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=fs/tI/7GIFfvay52gfHRQyszOipctYdXjIQzABa7pwg=;
	b=Ze1nmPBrUr52+PcnufvF7+hCrcufbswbbxbtRYNaejoUZfLTl/N/ZuswqhbHk+1FVMXd
	 sGR91D+1Cj03f+mgnfvond2RVBIo6okMkLh4sQzFVlMUIqE6gybQ7AlfKd72xhOR1x0ZW
	 A9SN+ymSgXadGO38b42aejatDWXzaHaHVAPVREvSJg2S0CMH3it6wcOaKpiB84Musd4V2
	 pUBkGqRGcN3sdFdqm8GxKOnBicTGznDtj5wo3kOydY8SRSxjQJL4edoMY2U4Zx/SD0Bhg
	 hs/5+kuhVGYpoFGZWYflKI6rnJX7pXmoEmygPn1+K4rDabmMxt3yFgcUiy476684XrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=ipKgWIlF;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EA606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 666EA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=ipKgWIlF
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2715A207E4;
	Mon,  2 Nov 2026 09:04:50 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MSyR7MhZu8nE; Mon,  2 Nov 2026 09:04:49 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 95CA4207B0;
	Mon,  2 Nov 2026 09:04:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 95CA4207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606689;
	bh=fs/tI/7GIFfvay52gfHRQyszOipctYdXjIQzABa7pwg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ipKgWIlFBi/wdpaiiPxdlNMPfNde55NTL0UB/eq97jd26nPTuMZbWOpeqNlE4w9Pb
	 fCELR/SLaDqWyE4QdGAwfb0cEjHOvqQptBsrme67+KoWnjzZiwfleVEy6sOnF9Nmmp
	 xrnYp37Y9NxgK/rkapCNRec/cQj5So48MDFcHb/+bTn4RTC6sSZZJ/gZi2F8TMDtSA
	 BgvM/wVOdcBPPlmKCh02EMUzynKCSc3p9odXqj9hKZ6AF9RS6w0KJLBFWWKhFtRi7s
	 nQP0UMzyO6jvxZBFABGb0j5BwSkJ6MdODSO2zt17adQi2gErmcd9xq/Q0PdZhH5Frn
	 +BlvICsxg+qxA==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:49 +0100
Received: (nullmailer pid 2505918 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/14] xfrm: fix hw offload state leak on xfrm_do_migrate_state() error path
Date: Mon, 2 Nov 2026 10:04:08 +0000
Message-ID: <20261102100451.2505200-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102100451.2505200-1-steffen.klassert@secunet.com>
References: <20261102100451.2505200-1-steffen.klassert@secunet.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

In the error path, the cloned state is dropped without removing its
hardware offload, leaking the offloaded SA entry.

Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 8640838dcda0..4de8c401eb44 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3541,6 +3541,8 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 	xfrm_state_put(x);
 	return err;
 out_xc:
+	if (m.xuo)
+		xfrm_dev_state_delete(xc);
 	xc->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(xc);
 	xfrm_state_put(x);
-- 
2.53.0

