Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F24346A0A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841479; cv=none; b=MzxAhBdb9Nvq5JOFt/0qX+6FC4oOcUn5dVICWg+9aKiSAHFPtLgtnyfZMSZdmB6rIQKGisHPN71tePsDMtnurkRhs+X3oJj6MtW/O+Z1nTZVM/tKnbv9BJP4QqQ5hwynt1/CNBDWcycZ0l/jMvOZdrR+Ym84v8Q1XXD6Cd+A1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841479; c=relaxed/simple;
	bh=gnB+Mgvb74TdrxITU3xvX+wEDeKwbtVF0k1GbUFXzVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOQJbFf8N+IK7hjaDtoEAb6gbfTzerO9OZuO8hjfA/Z1SL7nH5fegd0RuW0sum9r+T8+37H1msXXSOytYmSRw/gdh14TFOVwOSWohH7EOGvebP3B6NXJOoOhcE59Jx6NsK6oabwxWBQ5oZW5G/6C6Gg/E1eSEJcTuLRITC6Exb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=S2kkubxy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6lxgzoA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="S2kkubxy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6lxgzoA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A528A7A008A;
	Thu,  1 Oct 2026 03:57:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 01 Oct 2026 03:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790841476; x=
	1790927876; bh=XaUThmLowpy0xIGVCViZj684mNeB+k1riRiYrIMnlUs=; b=S
	2kkubxy7BGCjXH8el/ku9gl6geYCisSHhgiIhsdhlLJDRTokhP5XTh3XtilF/Ifm
	28cGB3Vp2UUZQt3h5ZjMCnDuLc6W0LrCX0I6+jt+4NasPgxhNOO944fLvUeoqwLq
	Y2tpzA4LZSkPDTEn/3/ZAiJ+FXXu1XFZMuL7a+oTTMOPVY8KV2QDwZ1G2VQRZbiq
	/A14Sgr9im/cocQBRMxdHGpvxi3RWk+Qc50cvgbJjc2NEjKZcKEiXvJe1mXqJZ1L
	4djGrVpqMcuRXkwZqPr69IFaNc0z8dTrzHiu3v2HyBkCsZK3AthkC8Wd7HnU0JOW
	fBThNUuHudehdgTtgmycA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790841476; x=1790927876; bh=X
	aUThmLowpy0xIGVCViZj684mNeB+k1riRiYrIMnlUs=; b=n6lxgzoAlWA1RvVbr
	svo8kRotUxQygYAuFgsJVtdYOHYCEkvh8nSRvcZMFly7GH/i6XCexM/p27tcBjtI
	gaLfPN+dn5iJOl3a5lB1vT9XcJThp6qAS2uQdemDJYFrnejIBkncqPX39DEQqXjd
	Q+f9zhDR8K38wIDYfUBJ6mMSP1ewZzU2TIua4QfdwAoNuJsAUi12i+VDK69XUEaX
	82Oxqp9bzWH0rRM6VL1MfrDeak9xOIK3griRIstVkmxcPXaiVG/5YD7wugMfPP7c
	yGKlHwf28TkdkTHYu4F0jojMKrqYHrZFzfWwUQLmyXHvQo3WPrgtXXuWL4k64IhQ
	sY67w==
X-ME-Sender: <xms:hBK-aj0C2np6y68oZ4W6slMJNx-TmNK8AyR8PZTfjiyZg73xBlCwEg>
    <xme:hBK-aoFhpfu0P-OSfonWeyaGspZWfAhgPyHn7s7RhVGxICcbf2p7ZcOb3QCCetmEv
    1wQQDYn1KFAHCkdfCsCg4zaNvfi2Nq67ihZwRVtQKjE_56B1LlV5n2G>
X-ME-Received: <xmr:hBK-ahhgObADttpFgY9xckhwDVCwzPJbHlzqa0Z0Db8ujeqW9-HnZUtynjTe>
X-ME-Proxy-Cause: dmFkZTEZ5RaHtCqQHiWZpzmkd36ADglsJsLfXv/Gf3eS1fmkO0zi+qChwTxKps4lBty6w0
    zeqK7UGEXFVAvlORucbzh5SfhgbJCWwbSKEj/GjD34lnUlstUDP5OLpjeTdSABdRecfWYN
    hYWl69ofa27WzcUxFh4Oq379+Eu9lzLDSGmiZXRNBL8/FLQQP4DN90Ry0cau9aQPumsyBs
    JyxZoRcUhtJOR9TSF5CNXr4XmvEUoPVK9qzL9QErk3rMjn1+tcv18ZC1gzYoiK7cKoq/dt
    TAKcfutQW5D7jHeKmE6cFb0+MMqdUz8YRiRzby/jOyHSFyX8U7uPfrCnFTVRoDMHJhw3UF
    PkEy5KhwviBx0G/V5o7lzUK0cIItm8wz2Eo7WILdc0Um3dPjql2IQlzgen5lTQWSY2pNAh
    MrRBsPX72UEXh4BTmHps9whT2p9BDvGyXFxHbveXRkLZ/UqnPeaf3uTqxhERc6wJ4ciwSF
    Z3chUnhVlOUPrGB9mTeecZCpUWYRFgEQV49GTw5fe1JgPOi8JweFXeCar+C4Sb555pPec/
    mJT/2EDaNBY0BS9MHYyDAMOuLcR94N1f4hHqCPaKNBhLmp9ZTKj8qJBF0Gf3fcBN0wjv2W
    YLCzS00hPmW7noaKcnMBhYyEF7fRQUwkbneG0+43lVlzvPGrAx5Kh1gW5e+A
X-ME-Proxy: <xmx:hBK-aj_DvSKusb2jpC3kRmWXIBL9xjq4bZtQrVsE9afFKxhwHiId_g>
    <xmx:hBK-aoo5EdKvr7YTE0YEQzSNO7iDUXwlp8dx_83utouM_Hpr4hsI6Q>
    <xmx:hBK-ai9n1z-kCyt2YxE1Kym68gzm46NF0YmVxVS1YmFmE6wYGobaMw>
    <xmx:hBK-asXbU3JwOIZZ8xWiLLkaejVawOuC3jmJx69mL0LBM7a8P-rpfA>
    <xmx:hBK-avPy1cp519X580RhmxourzloXsCdF57vyoWVhDQMtsifwUQNIyNb>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 03:57:56 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 3/5] net: strparser: remove strp_process()
Date: Thu,  1 Oct 2026 09:57:27 +0200
Message-ID: <04c57c1e928ec2a94a71413b49b6bec68a71c39d.1790702233.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790702233.git.sd@queasysnail.net>
References: <cover.1790702233.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's unused. Then we can revert the changes that commit
bbb03029a899 ("strparser: Generalize strparser") did to extract
__strp_recv().

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/strparser.h   |  3 ---
 net/strparser/strparser.c | 30 ++++--------------------------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/include/net/strparser.h b/include/net/strparser.h
index 78e8e3e12ed3..a72dff8e6a3f 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -160,8 +160,5 @@ void strp_check_rcv(struct strparser *strp);
 int strp_init(struct strparser *strp, struct sock *sk,
 	      const struct strp_callbacks *cb);
 void strp_data_ready(struct strparser *strp);
-int strp_process(struct strparser *strp, struct sk_buff *orig_skb,
-		 unsigned int orig_offset, size_t orig_len,
-		 size_t max_msg_size, long timeo);
 
 #endif /* __NET_STRPARSER_H_ */
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 6cdbd12f41e0..80f7555f9670 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -84,11 +84,11 @@ static inline int strp_peek_len(struct strparser *strp)
 }
 
 /* Lower socket lock held */
-static int __strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
-		       unsigned int orig_offset, size_t orig_len,
-		       size_t max_msg_size, long timeo)
+static int strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
+		     unsigned int orig_offset, size_t orig_len)
 {
 	struct strparser *strp = (struct strparser *)desc->arg.data;
+	long timeo = READ_ONCE(strp->sk->sk_rcvtimeo);
 	struct _strp_msg *stm;
 	struct sk_buff *head, *skb;
 	size_t eaten = 0, cand_len;
@@ -230,7 +230,7 @@ static int __strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
 				}
 				strp_parser_err(strp, len, desc);
 				break;
-			} else if (len > max_msg_size) {
+			} else if (len > strp->sk->sk_rcvbuf) {
 				/* Message length exceeds maximum allowed */
 				STRP_STATS_INCR(strp->stats.msg_too_big);
 				strp_parser_err(strp, -EMSGSIZE, desc);
@@ -312,28 +312,6 @@ static int __strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
 	return eaten;
 }
 
-int strp_process(struct strparser *strp, struct sk_buff *orig_skb,
-		 unsigned int orig_offset, size_t orig_len,
-		 size_t max_msg_size, long timeo)
-{
-	read_descriptor_t desc; /* Dummy arg to strp_recv */
-
-	desc.arg.data = strp;
-
-	return __strp_recv(&desc, orig_skb, orig_offset, orig_len,
-			   max_msg_size, timeo);
-}
-EXPORT_SYMBOL_GPL(strp_process);
-
-static int strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
-		     unsigned int orig_offset, size_t orig_len)
-{
-	struct strparser *strp = (struct strparser *)desc->arg.data;
-
-	return __strp_recv(desc, orig_skb, orig_offset, orig_len,
-			   strp->sk->sk_rcvbuf, READ_ONCE(strp->sk->sk_rcvtimeo));
-}
-
 static int default_read_sock_done(struct strparser *strp, int err)
 {
 	return err;
-- 
2.55.0

