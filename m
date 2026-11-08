Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154331;
	b=f5FU2vopV/EHcNBLdLufUz6xX4AK3CG3U294ZxIwKxTloMMI0rzTPdSX/mu5weH2vNVC
	 gstwHGA8GhjmkvdWoDOJQTE70FE99pnd04RMgjiBkpXVvx9gqwqoc/RZ/1BhxO0D+iU5S
	 lngyEeQOOtR3SmzV6cz8hFRnDl7xDkehsMmf6zebZsYwIOXUlP7A1FTwH3YvM/ErrYapU
	 GKtQhQ5yQ8xL5EI32mxwRMeSx140VBaLUi8gdso++OJk0rGBZSjx3N2gQ5jjH+fJWw/Rf
	 IXiEeboS9KwY76B4Bkmcn1rs3sIv/DHqv5CDBAO7LoMtH0h2Rrkqj3BmUg1RcJB7ZmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=89T9eyf/7pt2w5bHMloyOSyIASgmUej+LCY3qWFQwTs=;
	b=a3U46L4koQxCkd8J8Yn2qL+I9y2d8Ke5RkStCreAG7SuZk5jCrwT1oXD45h2/ZMYZ9Q/
	 Xn9R3epRAoiqPtm5BDXWswONEChkXrcsprf7+usByDEEGQdOoAf8mmDlyJWuf6eRfUXUr
	 5S/MC954JLlbf9WS+5wGFgvPG5he+JfXU6xJe/Ik6v2aYrY5OVrXNUlrnrsgmjCAOtHlz
	 rYpbDSSv7jHe/FGG46oYzDw91G0eGzytaz8684GiiDPuBVMSNhz8D6IJqMoCMnJHVsUA4
	 Xbc4Dq07sU4bFfnIY1qoGdhr8hh8Hv57NQOW8qy4lyVscjGu1aTxkDRQQ3JnBtWGjiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JZ4Gby2F;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1241606A322
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 16:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1241606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JZ4Gby2F
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2af4c8d00so357404c88.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794154330; x=1794759130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=89T9eyf/7pt2w5bHMloyOSyIASgmUej+LCY3qWFQwTs=;
        b=JZ4Gby2FvC2DBELHKFx4SybDLlGtuB7SQ5XgQ5eR59R2j4Wg931xxWyqTJsGcWV8FI
         leBHwUTE0i6796d8QedyDtdwFxpDyWOw+9Y4q7WcrU7TRHMlMTw3w76jZSSajMGMDJ4v
         4XdIGavyeSMSmY6yumPOTrqDSGHXfU6Z85RMvzjKYX87Gd4vmexl0CSQ6jbxpB2/YLRC
         NstZsnB6mkmNZ1PoEAGSqdyn6ZZ9Ohhg4+7TwwfTeOLfE+ggP9wOjYQkp8+DdpD+bxW/
         vQi5cFukX7xg1v0XtHq39C7mVEfVv0amHiDB67Ntg0Zh87z0aGO6trfKrcugE6gm+8Qa
         BxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154330; x=1794759130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=89T9eyf/7pt2w5bHMloyOSyIASgmUej+LCY3qWFQwTs=;
        b=TMF+LX5sG5MNX4829OJRUpscTGJGKQCPonFXfYT+iCGjE0zSQoFqiiL7JsEevHgphb
         y+Lx5PlcUjnEIhBpR/xARcdCv6nXX+JZyECe80+BsOELKoNjP5vQbxUx7uA4pKJ2sd1R
         PKId5SoincAkNRbJjlrV8vSJ+NmQBQvZ5RRWiN3QC31l1zUZ8K+XUOInFkMl2/n5tLA9
         CHmhaOs6FdiJHKL6uf0vU0X2noH9jtfmSVDM9kJZCrBmPQptqZRSxW7K2y+BoXias+Al
         R1lHKjnYEu+w4RbDEg2ujZ+ga7WT21SIFIJNCZCy2LzFfaBJeBLkEWCeNSRp/KS8a9tw
         97dg==
X-Forwarded-Encrypted: i=1; AL+hErFTb1s6FKJ4dd14IymZFoeWxieI2D4O2Zuqf8emc/lohVG1U5kDfzAaQbaBshrt7tMKTTXhh+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q426BkD8uF5vtHdY4MUaJhpvIUGw0nLdh3x3ACVqazHzg1yBv
	vsFzNoGvi4ty2OfeId9DNy5x1xHSiIPAbj0L/E4dPbAp9pkm8MyNuivs
X-Gm-Gg: AYBFou1iJ9P+uo62//vixg653+MaxnsSjFRFhk5sogCtmUiuTWLkgE4oXWVLh+YEshZ
	5immGeDmaHWBRkAZy8wUuMt4d8E8h26QNJa1vAiucAEp87WVUO/WpzMCuJ9Dmam5x4wyYTFNqve
	WJna9BKxlo81HuXah9G9Dt1364buawmEjYhcc7uIruzeCfPBiPDrvXlcKhIyuz3+LyeC342xIxl
	3m8BVi1eDD2MYTFnFAg6Yj8C8xhMfUKv1+TNTBBDLZS0dPmfGw6fYFPgoF+gnz0mg9D6kAgX5I8
	tbuJY9HAOCNBxZSUtINcDX/BmLiBsGriIigxIQkYzdnvuwGAcxaCA/GDRZvQrDcPgwBVmLRbAZI
	7OU0uo7ZnQ60zSzkPMP3gwladj8eMpc3/ARcAF22o8lezGRP+mrEx04k/4c7htyLqDkCu+gkPuv
	vOCjKb2t1EN4VJeKnIRDtV3BiKwJBUkZtTLWrjQbKiTDn2hbhUkAnyYEqZLBsbN+0rQT1XMg1HJ
	LEYv1SDVqfquuU9/1gzWsw2NlY3pLmrpt3TK4/6SxSoM+szq9AbHD1hLP44piMnEukvH2GQZchR
	ITvHa+30SG+JfD0CcZYiEbbcGY4h5gxWvp6J/ylYh6pULMUlI0Fs8l8g0b+z/5QBKmX1+15Rsqs
	VX8c=
X-Received: by 2002:a05:701a:ca05:b0:18d:ac5a:89ef with SMTP id a92af1059eb24-1b39fef0c5cmr3037830c88.31.1794154329553;
        Sun, 08 Nov 2026 08:12:09 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3731487edsm7103369c88.2.2026.11.08.08.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:12:08 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yongjun <yjwei@cn.fujitsu.com>,
	Michio Honda <micchie@sfc.wide.ad.jp>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: reset stored flag for each association
Date: Sun,  8 Nov 2026 08:11:49 -0800
Message-ID: <20261108161149.2774119-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

sctp_send_asconf_del_ip() walks every association on an endpoint. The
stored flag records that the current association took the single-homed
deferral path and therefore did not allocate an ASCONF chunk. It is
currently scoped to the whole function. Once one association sets it,
later eligible multihomed associations allocate chunks but skip
sctp_send_asconf(), leaking each chunk and its skb.

Reset stored for every association so only an association taking the
deferral path skips transmission. In an A/B kmemleak test, the
vulnerable kernel reported 210 leaked objects from this call path and the
fixed kernel reported none.

Cc: stable@vger.kernel.org
Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..ed91ceff45a9 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -771,7 +771,6 @@ static int sctp_send_asconf_del_ip(struct sock		*sk,
 	struct sctp_sockaddr_entry *saddr;
 	int 			i;
 	int 			retval = 0;
-	int			stored = 0;
 
 	chunk = NULL;
 	sp = sctp_sk(sk);
@@ -784,6 +783,7 @@ static int sctp_send_asconf_del_ip(struct sock		*sk,
 		 __func__, sk, addrs, addrcnt);
 
 	list_for_each_entry(asoc, &ep->asocs, asocs) {
+		int stored = 0;
 
 		if (!asoc->peer.asconf_capable)
 			continue;
-- 
2.56.0

