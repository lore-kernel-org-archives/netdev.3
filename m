Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606690;
	b=K9hoxEjBu6bUPhWKdmZFp1FlOEi12yCfQn4051l5FWhV7cBar3eCC3DlMvEdev/Fnoox
	 CcdA8IQr40Ib5GjIINn5lBdpQOtLqhcxwZfHH1uKme9oQ3jSN6p5kPzFUDziav9Ku+0hx
	 ahCa5k8EVv91n+bAEwlWRroD+iBgUweVgBYnRuQUCdrbMmk7jfzV/sJP8om9W033NRrEU
	 x1TYIzCoo5YOTsLqLhC3qXGIDHHqKirw03L624mKE8Un8i4g18ChIjxXUyx//Bc4TUzx+
	 9SpNf4Owf2l94zynU1XyS8CeuVKIUnFyt3GJTJ1dtnhPxTgtW5FdKUmqk68H3/CrLcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606690;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=03UpySPJVCOP8SE2lkZDKNavFgDv2gCSV/B5O7X4m+w=;
	b=3rGYehfjtmUTrUB4zW0YP8UdH8tYbKL0ocN2jm/aOXQzTGV1B3bBWEcOgX9j8DdDIOXL
	 Bnq+LE0ovqB3+iU600MWkXiwOVIkkMcT6blz9AsNYZwEMC5yzUGOjAURpA0pEpwpvXTTZ
	 OhOPMBme9AECJ1c0nopWQXk8TcXjPX8hYw0n/DAdzdapR9f+76RkSaDDIyoNm+lEYJWxt
	 LQiKYJFaIbg7etTz23ub+UjcwGVvRbLiQyVcQoNKmwucHil3TeYpg50oG80swkny53x3p
	 +OXnJarq2Zy4O6iVySdNejutIkzxuBm3fvMeVxk9vlcZeknBLUNTclBtxLVP7VlQamQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=XXsxjKxV;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7609606A33B
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7609606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=XXsxjKxV
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7A759207C6;
	Mon,  2 Nov 2026 09:04:47 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id quBMGhHg-Er7; Mon,  2 Nov 2026 09:04:47 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 02843207B0;
	Mon,  2 Nov 2026 09:04:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 02843207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606687;
	bh=03UpySPJVCOP8SE2lkZDKNavFgDv2gCSV/B5O7X4m+w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=XXsxjKxVBQBw1OOWKUhVjPqld4+u843zuJN8cxYVjj1rVBaC8dQSqnYk38SDfEasj
	 y7aGJKIO1iuNUMtqjjX7mxo4tw15VMWt5KcyWa1hbwJ1zmv8nN7vCcDky5yoyomKbB
	 VPeySvEZyHxCjTzgl3h56SYX/KJcO0gPUVwomJhR6wQT29MlhSJn1a9u4DbqI6FWgE
	 RiHm42Fw1AwtGuPUIioA3KdDRgD/gWbYsCyU+n4DkcuYDXOYphb8K0Vajup1z/olfr
	 bznnWV0IqZw/3ZPj52n62nQIEirMfd+EGOiuR+6QBnRTuWPKEuKbg69DQ1jAFl2Esc
	 9vxeGDKgQj/EA==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:46 +0100
Received: (nullmailer pid 2505906 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/14] xfrm: state: reject mark with bits outside its mask on ALLOCSPI
Date: Mon, 2 Nov 2026 10:04:04 +0000
Message-ID: <20261102100451.2505200-7-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

Like state add and policy add in this series, ALLOCSPI rejects a mark
whose value has bits outside its mask.

Fixes: bd55775c8dd6 ("xfrm: SA lookups signature with mark")
Cc: <stable+noautosel@kernel.org> # avoid breaking existing userspace ABI
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 0723d791b8b7..6b53373168b0 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1916,6 +1916,9 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	x = NULL;
 
+	err = verify_mark(attrs, extack);
+	if (err)
+		goto out_noput;
 	mark = xfrm_mark_get(attrs, &m);
 
 	if (attrs[XFRMA_IF_ID])
-- 
2.53.0

