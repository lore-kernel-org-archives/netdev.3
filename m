Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEE43AFCF1
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307852; cv=none; b=J9a0D8crkDWV1feLXeZZYlC6txevhG2xJ7/kCsqr3MDdpYYVTXHFdRXkIZRd6cTr63ZpGVgnP/AOoIUahLUNEyfe6un9SlRW2bsma1owJfVNHMFExaMu3Xt+XdU8JP808ZXJyxgy9d5RfWOkQ8aG1Bq5sh/7WFtPlYVr7EmYUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307852; c=relaxed/simple;
	bh=AvxKvbmvQg5QkquHi81B7VtZw/EpMdlOUBtHjHhnSEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbGPnLUMZ9DL1hU+JDN51mx7tjgjftqJO/8dr8PHKTEPyN8ECdGadaB0W55j+H3HU9FhcOIOZKePUaQguYglMuF9QgeA6R1Jfr7iJVrwqZ9aHtvCyasIDdMErh+HxRNl6oJGtTgCHH0UlUpbhTnkNkFuWjhU5Di/Y2EPNqgLXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=v9J3q7JR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="v9J3q7JR"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DD222206BC;
	Wed, 29 Jul 2026 08:50:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M7q1PiW4eMF0; Wed, 29 Jul 2026 08:50:48 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4D98820754;
	Wed, 29 Jul 2026 08:50:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4D98820754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785307848;
	bh=McULMpt6qvfK9HALOZXQZzOQe2pH6Knhki8rrImlCL8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=v9J3q7JRqFZv9MuZTn4SNHSN18Kh+/1UgvhB6MSUwFgeASea3Ayj+Vb32cSYWd0Wf
	 f/NNsSj5lFGhy+1qfY/IIbM0jDtfYi+3lzeISzpjtaVFTEUQuV+2lC7GYxh8pYITeJ
	 nbkKmBKcgSuuM4FuAXthcStM2Fpu0gxx1BRpJ8vpDN7U8/C5HnQ0KoOaKc8hn8Geiq
	 2DrtwLDumP/vIDEtjDAv8rC11syVBgw14J34Y5MhxQ58JQWpjeM+24uMhc4xMB/d/n
	 8xWHsa/3YgE34nvYVTZnR2mou0uRDy0myTxikukiX22UFuc1jC1TJGXY57JJHZk5+9
	 Mfrziui5MmVTw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 08:50:47 +0200
Received: (nullmailer pid 1592286 invoked by uid 1000);
	Wed, 29 Jul 2026 06:50:38 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/8] xfrm: drop ESP-in-TCP packets with no ingress device
Date: Wed, 29 Jul 2026 08:50:14 +0200
Message-ID: <20260729065035.1591985-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729065035.1591985-1-steffen.klassert@secunet.com>
References: <20260729065035.1591985-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Zhiling Zou <roxy520tt@gmail.com>

ESP-in-TCP receives records through the TCP strparser. handle_esp()
restores skb->dev from the saved skb_iif before passing the packet into
the XFRM input path.

Queued TCP data can be processed after the original ingress device has
been removed, for example during veth or net namespace teardown. In that
case dev_get_by_index_rcu() returns NULL. The XFRM IPv4 and IPv6 input
paths both expect skb->dev to be valid while building the route lookup,
so queued ESP-in-TCP data can dereference a NULL device.

Drop the packet if the saved ingress device can no longer be resolved.
Such a packet can no longer be routed through the normal XFRM receive
path, and this preserves the existing behaviour for packets whose ingress
device still exists.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Assisted-by: Codex:gpt-5.4
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/espintcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index cd817b855ba1..674aedc5af5a 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -37,6 +37,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 
 	rcu_read_lock();
 	skb->dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
+	if (!skb->dev) {
+		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
+		kfree_skb(skb);
+		goto out;
+	}
 	local_bh_disable();
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6)
@@ -45,6 +50,7 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 #endif
 		xfrm4_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
 	local_bh_enable();
+out:
 	rcu_read_unlock();
 }
 
-- 
2.43.0

