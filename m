Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D722A4EE;
	Wed, 28 Jan 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595935; cv=none; b=q7R1XJwYAA++NcX2DiB5dfRdPhq2JxcT/z860Mq7tFTb7NADvVZy5ynuzot944nE5tQNSmTbue3CCtESm/1Ry2sbUMuHKr/5KX3+KXnGsXHlfIKOKncvAbyshpgOtlBqbPadGQckzTU7a8VszvgzxIXmod5q2IqXlLtf0Ruj17s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595935; c=relaxed/simple;
	bh=YIy6M2/AOzp65V88aV0dZ7NcQwMFl2BcAWFhX101+UU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CznfS7AHOf9jojiE0TpncbWuUze9BG92ubTYG5mvwfIOzk90QW1O2wj92SZNfpJ9GWiu1UGE1l6g/y4n5BnRUi0avfYDUiUObNbkZhyAc9QNAPI0ipbAQXEeVhJ13NMmjmfXlbtTf4rZZbk3+h+iTNUTAGoGvYUuKW2/LKNKACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=EMUef2P4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="EMUef2P4"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AB7D320758;
	Wed, 28 Jan 2026 11:25:31 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HPq2c7-Ty6xV; Wed, 28 Jan 2026 11:25:31 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 212A820728;
	Wed, 28 Jan 2026 11:25:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 212A820728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769595931;
	bh=w47EH4sfTJk+vUYce7sc7AiolyK33rRCJj1B95arpUY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=EMUef2P4Ut5c9j2BTF9/xd3b7eKBKBjvuQN+Nev7a0f9JozLwPxjCzcnzVd7CF5il
	 G9c/7GkSfx8uhdTortPto7tnzVKhHihFt94csDKHe4p9HFjyMNA0DX3Db8DG3IPsYo
	 tv5h+XzGpraZuAgvpaL/dCSg/6EyV0zwHd0/8/jG/Aw1I50XYw8+ttfhl8BdPN+DH8
	 qFdlO9d8t4JfRoUHpkJB6do3vEM9/YyEQRfSjPu1HwkwjitZxXXPSIg/OegG8qkkdi
	 QEF4zGvduGlPPPYjR4yM+Wi8aaKugUGt70Ob4jFilc72uUuZIXbt2tXozhVykwuD3D
	 qfsNiJU+VL33A==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 11:25:28 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Jakub Kicinski
	<kuba@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, David Ahern
	<dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan
	<shuah@kernel.org>, <devel@linux-ipsec.org>, Tobias Brunner
	<tobias@strongswan.org>, Simon Horman <horms@kernel.org>,
	<stable+noautosel@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 1/2] icmp: fix ICMP error source address when xfrm policy matches
Date: Wed, 28 Jan 2026 11:25:14 +0100
Message-ID: <f820e0e9f80b1467f97d1408f00f61b1fdb1b986.1769595011.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1769595011.git.antony.antony@secunet.com>
References: <cover.1769595011.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

When an IPsec gateway generates an ICMP error (e.g., Destination Host
Unreachable), the source address incorrectly shows the unreachable
destination instead of the gateway's address. IPv6 behaves correctly.

Before fix:
  ping 10.1.6.3
  From 10.1.6.3 icmp_seq=1 Destination Host Unreachable
  (wrong - 10.1.6.3 is the unreachable host)

After fix:
  ping 10.1.6.3
  From 10.1.5.2 icmp_seq=1 Destination Host Unreachable
  (correct - 10.1.5.2 is the gateway)

The fix removes the memcpy that overwrote fl4 with fl4_dec after
xfrm_lookup(). A follow-up commit adds a selftest.

Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
Cc: stable+noautosel@kernel.org # Avoid false positives in tests
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Acked-by: Tobias Brunner <tobias@strongswan.org>
---
 net/ipv4/icmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 19c9c838967f..4bd421208ce0 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -569,7 +569,6 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 	rt2 = dst_rtable(dst2);
 	if (!IS_ERR(dst2)) {
 		dst_release(&rt->dst);
-		memcpy(fl4, &fl4_dec, sizeof(*fl4));
 		rt = rt2;
 	} else if (PTR_ERR(dst2) == -EPERM) {
 		if (rt)
--
2.39.5

