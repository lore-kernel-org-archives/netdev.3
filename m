Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606691;
	b=xLi8K8jbCIS16D9dbkdDGpzv8ZoV/93P+2/M6whdCZtMzMiA575+YId1CbZcv+RHgCYj
	 VIvjK2G1iiT4c/qR0SbDOTbkL5sYuSpzkJQhIHavyPCDR2srBSHwMFjq/+pJdcl3nHRdi
	 gT76j6djUAr+LIAea+6wFOEf7Dcfe0LAqLP3quQClBxF5/kPIpWb5qTL4aSTkV5K6EGO3
	 VfXiKo8ZO9OaN+nOF1nwGh3/EGv97oUuK26FI6hKe6f0fSvOptenwr9nRswLbvKVCuK/G
	 B1v9wJXroynseOkmBUgg9g8SAkDBu7Dsy4P1pr8B/+1AXmg5V4yiJERb7OCoG9EI2Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606691;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=JJOfP7vZWx1DyOE/pLYhFXf4iaTgGdCc9z1px/f6kZM=;
	b=oKR8mw/Ue5QwTxOLlMi8CEsVGpL6iv80gpRPnn2JXKObB9UfTTFRVOM73HfbtTB4lgnp
	 VMJoG1EVYJLnFhpMWMNTEhNwMEv/FNlBXXscxOzOUKjBeIOt5ntKsyosP9kcvAYAzwEJw
	 HvvUcmheRrwFJRB+xBzmhjScOsq1/P78xIQrvVKI1VvDVDHgxKZ40JearXVczTpOzIz9y
	 jt+L2I8MbCexZqMCH0xcFZ/xE9q3YB0mYF5C2irxfFViUABntqmhoka07munezlFemBob
	 h1xvZkp4rvqJswH38CtAjUSrHnUFYtSuVagdPlBDJAnWPFhVPfpSWuOqPdg5LXgftuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=bQtHIzSC;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9660A2602
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D9660A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=bQtHIzSC
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E2631207D1;
	Mon,  2 Nov 2026 09:04:48 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m6-uLOdAyCt9; Mon,  2 Nov 2026 09:04:48 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5C12B207B0;
	Mon,  2 Nov 2026 09:04:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5C12B207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606688;
	bh=JJOfP7vZWx1DyOE/pLYhFXf4iaTgGdCc9z1px/f6kZM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=bQtHIzSC+wy1e7QsEZVp214Yok5ICZVd2cwsExsheQ4UGkxP3/0p1mdbS2MEFriCh
	 575vMNzQq55vuwdwVFQfVElHxS8ihUVuTOfyg08KP1Z2ebJzsM6FzopugemWRqZzGL
	 1aI0dGHRwghXz4nAbiRibNeUrUxAa7aZPfJkRgW0kyp39wyrj4z/h4awYIqGW5Q+M5
	 FT9gYlSa3FprR3/XCrRhcekuaDS4eTNx2KNvTolvHTxv9APdIjdg9uSuL/xC9d5hlq
	 Za7v+l8Zp4gNf1MH1/pH4uTzsU5RyHfbyhM/a9nKJYgOkvh+xGr0r8i+8XOn7QDK3h
	 xfwACm5QORs1w==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:47 +0100
Received: (nullmailer pid 2505894 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 02/14] xfrm: interface: validate the IP header on xmit
Date: Mon, 2 Nov 2026 10:04:00 +0000
Message-ID: <20261102100451.2505200-3-steffen.klassert@secunet.com>
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

From: Qihang <q.h.hack.winter@gmail.com>

Packets injected into an xfrm interface (e.g. AF_PACKET on an xfrmi
device) reach the xfrm output path without IP header validation, but
xfrm4_transport_output() uses iph->ihl for __skb_pull() and memmove()
and expects the header to be valid.

vti_tunnel_xmit() already calls pskb_inet_may_pull() before handing
packets to the xfrm output path.  Do the same in xfrmi_xmit() and
perform the header checks ip_rcv_core()/ip6_rcv_core() do on entry
to the IP stack: reject wrong IP versions and malformed IPv4 header
lengths.

Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_interface_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 688306bf62c5..9835fbe63ccb 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -531,8 +531,13 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	memset(&fl, 0, sizeof(fl));
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IPV6):
+		if (ipv6_hdr(skb)->version != 6)
+			goto tx_err;
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET6);
 		if (!dst) {
@@ -548,6 +553,9 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		break;
 	case htons(ETH_P_IP):
+		if (ip_hdr(skb)->version != 4 || ip_hdr(skb)->ihl < 5 ||
+		    !pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
+			goto tx_err;
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET);
 		if (!dst) {
-- 
2.53.0

