Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563428;
	b=wrheg5aJuCqpHJhZZq3MIv4fRmNrrTSmxV0MBJA1lapep5YGsgZPCOVOIROQMfjJWays
	 Jo6xFawdAxyqdQaFFBIHs1oVSBRWjGKHVbU2bvsf/7iLSZYm7XxytVcAl2UaQFkAXKo49
	 twNOH2cnx8xJKqiTSkZ4cNHvaFpEl3AF9zgiSiO944Nk6hrP3jLmHWq6v/f+o9oim42N/
	 ChNCy+IwRckMENmKy5OVEom05cr8Vzg1HMDOgvd5D/o+puDgFHczWm1Zqo9Svw2OM6JzK
	 e2Y1yGtM1o87z2An4kbe8yEHCrWsl9MrY/33vJP1+kg+0ETfDFPe2Wd9FiRcEDVTY5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563428;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Desert-Share:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=twrovwkisuWHeA+hGeSowB1A1+M8W4ArMTje1ckj7P4=;
	b=OK0Xzl5KuPIhqfJAM3YJmDVtOxmNWqiCfQm0k7zd27E29EV7NFiavG54pMDSMFIUmB5W
	 ZfrNz1uiy/jfWjjcuSZSi3g2YFwPt06hV0a9FPH5MJuPELgnujipc8c5Wmro3K19dhCtE
	 2Jwh/vGeOFtqjQKBVTequrawTfz9rEX47ESSOrR8j9EgL0loOYe854T80QrRvLIEU11la
	 wgMI7mK/KAMp1FrL2gvrriQ9cbVkeV3ZmBEOJLpQnZ0G3AxRJeUL75GsHBAcwD+6+hA2c
	 HU6rGXb5V50/xk15Ba7TqBxE5IdaikhXJPNUn6b45ra3rkQ/tpOIwqRRBUt6dTOEuug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b="KiCyJ8/0";
	arc=none smtp.remote-ip=23.83.222.44
Received: from crimson.ash.relay.mailchannels.net (crimson.ash.relay.mailchannels.net [23.83.222.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26592606A324;
	Sun,  1 Nov 2026 20:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26592606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=KiCyJ8/0
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 627C0460A5F;
	Sun, 01 Nov 2026 20:03:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.99.180.32])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D342F46086B;
	Sun, 01 Nov 2026 20:03:39 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Share: 40ee79c8278133a1_1793563420106_1682441540
X-MC-Loop-Signature: 1793563420106:220483257
X-MC-Ingress-Time: 1793563420105
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.180.32 (trex/8.0.2);
	Sun, 01 Nov 2026 20:03:40 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4jHm4C1hTLz2l;
	Sun,  1 Nov 2026 12:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793563419;
	bh=twrovwkisuWHeA+hGeSowB1A1+M8W4ArMTje1ckj7P4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=KiCyJ8/0g7uHk3/o5RRKkMQ8FX6ukey6J3ji3gM+q6blmCjzCyWwHpyug4EwT+Vk2
	 JPSGF0lk+jSIMZXFN/LE9s2b6yS6ZppjMXGVhICnaEi7316+DheRXGz1NgDdB1pAxP
	 rsjwdrkpgBDesRxkTEmTGkJUgf9rk5cCBeU1O5Xz2U874PfmrlyKw7UvgkEj5iafac
	 77Lc60QEP0275/5+MowuU05ou4gUNWahRwSf6IZJ9qFFp06CKz3EFfrZzibDNujbgb
	 M10ufZopKzEjW6Szlfy4SP0NKA993bMeym4+drtrSaS1I1As99Er1iabUNcMIRLRaA
	 gw6FynCAk2SSA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: anisa.su@samsung.com,
	dave@stgolabs.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mctp: accept MSG_CMSG_COMPAT in recvmsg
Date: Sun,  1 Nov 2026 12:03:31 -0800
Message-Id: <20261101200331.1956836-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
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

32-bit userspace running on a 64-bit kernel is unable to receive MCTP
messages on an AF_MCTP socket, even though sending succeeds. There is
nothing for MCTP to do with it beyond not rejecting it, as af_packet,
af_key and can/isotp already do, for example.

Fixes: 833ef3b91de6 ("mctp: Populate socket implementation")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 net/mctp/af_mctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 8af5e2b3c8d1..aa22c0860712 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -292,8 +292,7 @@ static int mctp_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	u8 type;
 	int rc;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
+	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
 		return -EOPNOTSUPP;
 
 	skb = skb_recv_datagram(sk, flags, &rc);
--
2.39.5

