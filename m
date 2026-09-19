Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07C3955E3
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789854764; cv=none; b=j40ySpshVhRjM3sbtJm2cZQbhARX6npfU8jJ0aoLkUrQ9taTmj57uvbFz/76CZDVNFQXiidgJ1aR2bDTZUn9r5Fq+5Qc5K+2GlQCNyC6pr48ZcxkfP17M6ZmBVdaRntXZUALYTxFXUr4sqacJEs5Wwx9B+MiaIXCk5aTEPcdf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789854764; c=relaxed/simple;
	bh=txCbpLWgUyKMe1eisI8zkvSlDjx+EpTGDcG1tTJR0yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/XpMoOeGw5q/fn8BvDFr4LsCawgnW4a7IDB97xqb70Mu9baYuVWP9Uh0D2nt2A7NAZU12/UnAUd8Ne4WIz94cGS+MWDgBTI+cgVsjvvMuJ/VNzB51WBe5BmelghvQSRSQAWM13CsQoZJJ4BUWo/tu3eShlP0duNofro8rE8FkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxOY1E0V; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxOY1E0V"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso1965197a91.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789854758; x=1790459558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNcubwPDgIsMpA+wtWjaJ/Im3UMGanOHTCSqrN3twUo=;
        b=OxOY1E0Vzx+dDQO5c/GkfrmwXmh4Mrzz0twaKb6pWRX0zajbf3PHNbvkTtZH6Igep+
         yszl7z9S8dIDu6oOUM9wwiXpPK/Y1CUMPz9dwZVdYPjhvgKSSk+lD8T36xqSN0scpklD
         bzOrP31Yjh1ewAYVv7sG6JoYRx+C1pfH2RxTBVuuXEnuv0WZbDM67SywlkBFFH3u8m7Y
         aLWux/g7Pr1ULwiqaOu/br5SNqqMVDiOeyJF8NQAAjRE6j3onHLEDNkF51AnwAI/gAKt
         NV5gNrrpny4vEXJ5dkomoF/RDLqquSsEmUv274gM+V723OMWdh8xvDWGdr0cmrmD7GKX
         vJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789854758; x=1790459558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNcubwPDgIsMpA+wtWjaJ/Im3UMGanOHTCSqrN3twUo=;
        b=gZnScR1dKS6gDbAx4Vu2Mqw7sMsEWR93GzGuLjmKfqzbmJ5aVXyI3eJyPFY0JXWvEA
         5jNmzD4+urb7RDacTbbnlUj9S6G3TmaHL2bYvTR/EjtzzEK48F3WFYxIc/X4Y4RY6h7C
         y8Igk4BlbnEdTcalwCqF++6VaBoMp2cP2oFSGeYS08+5gY7kCdbpo25dBMtrIxaDC+RK
         1ATe8Qh8/4nPeJVaQiBMkg/usPBbEWsI8ZTa9/8e6tYpavjb2CN0uDhMLZ7U6zY2san6
         qTsdFgQcVdAxw9eQDYIWFz04LA1v4zBYBuxfKSleWsb+MRZLwolTRC+zCCGjpbleRlIj
         SGCQ==
X-Gm-Message-State: AFuF++lvKljqrDJquRoL3OrRkv8pIAP+rFGj4/9xGLSxrZp7oiSAdNQ6
	EvRNL2j5TAcANrAzEcxpm8YjQSno23ZoVdcPzOCjAZm0ZWY8DIXtyFwe
X-Gm-Gg: AYBFou00r0/07u+pw91Ga0dS0PefeGKq1jX0MyxrK5pc20EShTzcm0tcumH/ywJhq9I
	vVAUtBcmkjiktf24Hgx3Ku2nuaC9/gdfGDGvMbu+e+jwgHRXx3jqQxMaQ+Im4Bmo7oG6+FRIWNl
	A0YWGCv/ZWLRHpIsqEspGSiseFk/OootVTxThJjcCA2/yWb4/5y6Izj24XQkmdNcx6OhB1hS9z0
	1ootBJ0DGtJ25bjjmLrkpcE8+EG8R6MZVYAVTnrhDUFcU5gVU+423dUjXoQApucdN12/b9HL0em
	aIP6R+GJVblG1TdpG6ThN8Js1TtpMv3b5JPTgFQGauGJ/1ESrXp1P8vV4DdNebjLo82n/IVf7n/
	SQrAl4OksSS8BIBLaK6rzlGl+8nUtYjLvkMn642TyjWmwUlNdP0ygxNx/Az3tiKNwkpysfLUmdE
	+lhHS1EqnZ5Zl5rTiT2WNTHgbeiONP9D8/SZbcp8ldsdHH9Z7+1WefZ50pcHYKUarGT7hYVBgyS
	IrGFiDjkib9ew7urDIm2/gNaZvdQ6yw9jpVk876MI9bcVB4g/xvFimkMSK/sHrSwiSq+mFxeyP+
	ZBApVnuHcNs=
X-Received: by 2002:a17:90b:2fce:b0:3a0:3888:a3f with SMTP id 98e67ed59e1d1-3a038880bd4mr190678a91.16.1789854758222;
        Sat, 19 Sep 2026 14:52:38 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a027ce61cfsm4277091a91.8.2026.09.19.14.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:52:37 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/packet: zero-pad spkt_device and preserve sa.origlen across MSG_PEEK
Date: Sat, 19 Sep 2026 21:52:37 +0000
Message-ID: <20260919215237.3470987-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in net/packet/af_packet.c:

1. In packet_rcv_spkt(), use strscpy_pad() instead of strscpy() when
   populating spkt->spkt_device so trailing bytes after dev->name's NUL
   terminator in the 14-byte buffer are zeroed.
2. In packet_recvmsg(), PACKET_SKB_CB(skb)->sa.origlen aliases
   sll->sll_family and sll->sll_protocol inside the union. Overwriting
   sll->sll_family and sll->sll_protocol in PACKET_SKB_CB(skb) directly
   clobbers sa.origlen for subsequent recvmsg(MSG_PEEK | MSG_TRUNC) calls
   on the same skb. Instead, write sll_family and sll_protocol into the
   destination msg->msg_name buffer after copying PACKET_SKB_CB(skb)->sa.

Fixes: 2472d7613bd3 ("net: packet: use sockaddr_ll fields as storage for skb original length in recvmsg path")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 50cae32ae269..15def2d16806 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1918,7 +1918,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 	 */
 
 	spkt->spkt_family = dev->type;
-	strscpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
+	strscpy_pad(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
 	spkt->spkt_protocol = skb->protocol;
 
 	/*
@@ -3510,15 +3510,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (err)
 		goto out_free;
 
-	if (sock->type != SOCK_PACKET) {
-		struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
-
-		/* Original length was stored in sockaddr_ll fields */
+	if (sock->type != SOCK_PACKET)
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
-		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
-			vlan_get_protocol_dgram(skb) : skb->protocol;
-	}
 
 	sock_recv_cmsgs(msg, sk, skb);
 
@@ -3552,6 +3545,13 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			msg->msg_namelen = copy_len;
 		}
 		memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);
+		if (sock->type != SOCK_PACKET) {
+			struct sockaddr_ll *u_sll = msg->msg_name;
+
+			u_sll->sll_family = AF_PACKET;
+			u_sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+				vlan_get_protocol_dgram(skb) : skb->protocol;
+		}
 	}
 
 	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
