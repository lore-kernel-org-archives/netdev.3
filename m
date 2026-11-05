Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883017;
	b=aV6vxOMEDJxwn1Wl4jJSSyfTK6cbxIeX9PRKjHyo/U1jlpZeJs9XX5v0SgcQjp90W0jZ
	 nVWoZDAG4rmsty1zNEZSI3W+xuHHC2LaUpK0A5R64SMyAMKp27BCeVv090hC2bf6pGg81
	 MAycacbfXki8bOVof2c9SAkm5UevuQoDmxVUbgvtFHY+pqG201IC4X3w1pBab6M8lzyCN
	 dNvt2F0Hd3eCqCCtdNe+K5uSy1VgFQxyRIphmEeYoIzLQLCGhGFUHkCGG8wiuJfnqeUGB
	 krMyZMjuBwZ9oUezdFVx2yrRhRUxmZ+giVEyRfHqmGUFuH7mAaVk8U/71OxUFWQR76A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uYX+jNZaRfs+bvHwVK4BRtfPAH5zcuBsc3jlvTfSl60=;
	b=xuvsQZ6k0vMJg5M+OSZVWx4Jr0KY67oOHg0OMq6uPmgwfq67d4xVg4W6aCUlzRbD0Il3
	 7+rLCty3K3crgo6W9QDI/jXH/Ufa3Gt6xOxU+9Kvim84jU4WjoprB5mLtplMdepObrzdy
	 dWl6dttUmjL4kdFCmGN3lf2b1F3qKDnih6qSyhTesA+KMMZkS6nCICkUXIWYSqA2f42P4
	 go+iB4xq22YxCoQYK4osu7PP9npinrP4E+MNHOGwNdyh5geB+OWwS2fg3LWxM8gtFFcUO
	 Kd1hrVNm9ByLe1XmiKMQi57Q+/LWmnqnkru8CxgMXlFw5+IoU2Zj6a6QBPdiZLKpiQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=VnXjkUf5;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3B606D815
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E3B606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=VnXjkUf5
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36cad25b8b0so2673189eec.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793883016; x=1794487816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYX+jNZaRfs+bvHwVK4BRtfPAH5zcuBsc3jlvTfSl60=;
        b=VnXjkUf577443xL2H0n/W9uqMxf5yWTTSk/N6wnyJk4NzVZ70b9uQapiwxZsRAx7WX
         zvki1RJKn9daM79FZRvy6FOrVLDgnmkeX5WqDL9+w9gjMFzYWxWwdQyfqM6CiD6PDrd7
         m3yu/C9Z6H6aatfwEinMA6YzhbReq8ZxWYA4hwStnZxllYZdmW+8o9OnLD5Fmf4O+M1y
         g/z2rDglpd0qbsMHNi7keNHpC/6cXAxxbLhmJ6TCTP+6Pbno3IZ3npEq7kXk5e5+aXmZ
         YJ1gcPjOmYAeNpFKLv5RN0XacDHq+Y73SbD2xnYH3jDFEj9AghnEuJoBckZ1oZDOjzpk
         MRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883016; x=1794487816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uYX+jNZaRfs+bvHwVK4BRtfPAH5zcuBsc3jlvTfSl60=;
        b=kgAgpwBPfV3rbba7THwAUYLWquNe3/IHWNEpp9NGCGRRwIp9rHxlcSzu6Mw6LTLX3C
         PORKGReGHBhZizDZSgun8qHIVwb6LjQ7PVnez/ZdA52rM6YNtPky9pRf14JggRgooZlw
         RBracPF2Bjt/IiAMgkwCigPm4V2M/PTTG0EmRyesW72ef8shvBOMRsBglCiscYEsF74Z
         r9pqY6Qe0+UcsrsB57UwUINyKpR03LxjSGq42tH/uZdlfmLrcTSZRgMxPy4b97G43NIz
         r6QD84g2sUddBhfMiRKOuzXbm6Qf6g8U5Fq3LDXaLt6WBP2phF1JK+EOEY6ifSNXOzTy
         Em9Q==
X-Gm-Message-State: APuU4Z9jRLi3YgpTJXSpOVH0I9Wlvb5S2DMOiMso3yK9kb9HHfUcVECk
	t3vymLaWxcNmxzYuRfrEX07Tjc6iUPoZii8htJJb8QLjSo6bpt8ROmH41VuCXUX4uPk=
X-Gm-Gg: AYBFou0mdr2GmFwurrfmMigaI2hwPMY9o+ScW9qOdhE8dXBI10sacbtr0DYR2MUtvSm
	7T3fNvvGzbnAKseAQJBvSStLewNaYTu1QmVmLIwSkifguvXvfhQSkZUpZ7YqSEsXDxztnITqV0o
	fz3AsR6oDviNLtg57/WPMa9kEVYNywCqHI5D7wve0YDCuldrtZ8wyemMhz/zZO7JKUk67nETadb
	GEKMu8mR41LdEKlrA0c+U+OjDweS49Ke3tnZpE25xOlFWERdo2DqnssGUw+GWAofqUN9u5M09iY
	Xqyd/Gp17D7zPaMLs19nDdnE180r+N5CrjivZ5n33DZyjiRZB6P2/eN3yLVWuIEJpR4dpBCwk9n
	IImLehiICubtp1XF72gB1g5s56zNpA85kzpW836V9seXFy5gdDBaGL+VWWWvmFsI3xGfU6zxHmC
	P91nL/Y2JcxtPDwpnueSdgvzaLVWmo+OLI2VReSYPwkqdhqmiaroqg9d9j8GINW03BgUboLnOlL
	WFoItgc0HGuY43oP9xn2P9X+FN7I3+Gi3Dvy0lsU89anUGrjDdBFg1/Wqr4p/T0pNiSRg4L1lHB
	Sh+OQQ6dWsRBF72QbNhkFNqpkKB8g5tqJgxLo875/ffmEizdA4/+Qoo/uk6MSo3CMmfK/lI=
X-Received: by 2002:a05:7300:3b0c:b0:36a:238:1485 with SMTP id 5a478bee46e88-36a4244276cmr39609834eec.37.1793883016164;
        Thu, 05 Nov 2026 04:50:16 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm22527257eec.27.2026.11.05.04.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:50:15 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v5 2/5] amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
Date: Thu,  5 Nov 2026 12:50:07 +0000
Message-ID: <20261105125010.1107546-3-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105125010.1107546-1-omar@blockcast.net>
References: <20261105125010.1107546-1-omar@blockcast.net>
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

A gateway's amt_rcv() admits a Membership Query or Multicast Data message
when "saddr != remote_ip" is false. remote_ip is 0 before discovery has
learned a relay (and is reset to 0 by amt_dev_open() and when discovery
gives up), so a packet whose source is 0.0.0.0 would otherwise pass the
equality check and could spoof a Query or inject multicast data.

Reject both when no relay is learned: a 0 remote_ip must match nothing, so
guard the check with !remote_ip. A Query is queued before its event worker
processes it, so the relay address can also change in that window. Recheck
the packet source against the current remote_ip in the handler and discard
stale Queries. Discovery is unaffected because Relay Advertisements are
validated against discovery_ip, not remote_ip.

Found by code inspection while writing the IPv6 receive path for the
AMT IPv6 outer transport; not triggered at runtime.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index d8914d811..dacfd5524 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2482,6 +2482,10 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	if (amtmq->reserved || amtmq->version)
 		return true;
 
+	/* A deferred query may outlive a relay address change. */
+	if (ip_hdr(skb)->saddr != READ_ONCE(amt->remote_ip))
+		return true;
+
 	if (amtmq->nonce != amt->nonce)
 		return true;
 
@@ -2958,7 +2962,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2969,7 +2973,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
-- 
2.47.3

