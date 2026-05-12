Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08225B0A4;
	Tue, 12 May 2026 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567997; cv=none; b=qtKu5LsH2JnnmxgLS/OoaSZSI5cDqQ5Olqr948r6bshGz4SkPr0VnecHb+k0YFbr7gj34CKGjk8P7cDvBV+pdhluCX0uDtaxcSpXjO/98Iib4/fmEEkZxfkrVht3IdJbBqyJM1ql+WCkF24xzBiLJSx2zeKMI9zRJ7WFPQcVxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567997; c=relaxed/simple;
	bh=D+wDvenW7MapQOXB7Paf6Xuudjsv1R7BQgOFXRK5LqQ=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=FDnbLVsN8x6pM4PO4ddCwIT9w6tdh+nSjGUrs9qw4HGRhBorMSmSuN+FdXLI99UpMlgOZynrWP3hPekLGXJv+ktCQE5Z/wWR8oDGvY8pm8My4WxCt1apcGpppv/VJEFoIz01IXdyvg/r9SBrwI3J3z+Oc+hKQuIL9j85rGDlkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gF6QH5CCWz4xPSs;
	Tue, 12 May 2026 14:39:35 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 64C6dTLu028700;
	Tue, 12 May 2026 14:39:29 +0800 (+08)
	(envelope-from qiu.yutan@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 12 May 2026 14:39:31 +0800 (CST)
X-Zmail-TransId: 2afb6a02cb236ea-be875
X-Mailer: Zmail v1.0
Message-ID: <20260512143931584Zv3UzxnMq14MaQPmsK3VX@zte.com.cn>
Date: Tue, 12 May 2026 14:39:31 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <qiu.yutan@zte.com.cn>
To: <davem@davemloft.net>, <kuba@kernel.org>
Cc: <dsahern@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.chuan1@zte.com.cn>,
        <huang.jian@zte.com.cn>, <zhou.shizhen@zte.com.cn>,
        <zhang.dongyu1@zte.com.cn>, <ye.guojin@zte.com.cn>,
        <yang.wei20@zte.com.cn>, <zhang.lin16@zte.com.cn>,
        <li.hao40@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0XSBuZXQ6IGFycDogRml4IHRoZSBjb2Rpbmcgc3R5bGUgaXNzdWUgcmVnYXJkaW5nIHNwYWNlcyBpbgogYXJwX3N0YXRlX3RvX2ZsYWdzKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 64C6dTLu028700
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: qiu.yutan@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 12 May 2026 14:39:35 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A02CB27.002/4gF6QH5CCWz4xPSs

From: Qiu Yutan <qiu.yutan@zte.com.cn>

According to the kernel's coding style, the binary operator & should
have a space on each side.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
---
 net/ipv4/arp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 601b98185cf5..18174459a9a9 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1155,9 +1155,9 @@ static int arp_req_set(struct net *net, struct arpreq *r)

 static unsigned int arp_state_to_flags(struct neighbour *neigh)
 {
-	if (neigh->nud_state&NUD_PERMANENT)
+	if (neigh->nud_state & NUD_PERMANENT)
 		return ATF_PERM | ATF_COM;
-	else if (neigh->nud_state&NUD_VALID)
+	else if (neigh->nud_state & NUD_VALID)
 		return ATF_COM;
 	else
 		return 0;
-- 
2.25.1
