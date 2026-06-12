Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B733E1682
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250495; cv=none; b=WSaPpK5e9DflVBfHy3v9NTzz61VuJ/WA9v72DpadWu0tCYtuA+pDa8T1QZRD+5cS0A3KmC5dLDBAWHCsX1rYu6yyMiOGtlFXRW5h01lI/ciOsK0Z6oQzljwsaPt9x8n0X/Y45d2DPh0GWgZFmtprSRmQJpAR0o3DVjDer/ezNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250495; c=relaxed/simple;
	bh=KmgA9UF7usNUoDvoGOyOO5iGZm84ubgvLst4+SrsoiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZQ/PWfN7YoK1pXb7yd6g0f62wpka1YplMTPQVd2ygdOjHrOtCi61XIZnYdqZqO4xwplnEgYOMNqGra4g6r2H/rRV5vWGy3yFKJpPC7aU/KKBPd7/Fr5ESjMwuxidwyrKTU520IIX6g4Z0LmDOK31FrgvSe+GKtpqOxxRnlK5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QPHJqU6M; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QPHJqU6M"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 348D520820;
	Fri, 12 Jun 2026 09:48:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PQ-I8UlcZ_Hh; Fri, 12 Jun 2026 09:48:04 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7420F206D2;
	Fri, 12 Jun 2026 09:48:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7420F206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250484;
	bh=aSSLBfYTUs5eYpQNAK/Jq0KEjzgtmzjIIgrtgQix6YQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=QPHJqU6Mt1Dh8mJOOXubjqR6PtjdY3CrmpamD5Bi/JjmsEDjKxdk0YaWUVJAtlk4j
	 IDAulEIJMP0bRsEobDTlqNn6fRT1LbacUCwOTksL2Cmt+PUl6QrgVmthqMAiIy0FmC
	 yExd2YwkWMSDsamT1wPiMfcxD8JvsPL5vyCXm3412BfOOr1oged1eKNqPhwtNcps4I
	 SIvVq48kHxYaxQKgjYnTkqQRasIc87bM0MJblgnYRB7TLWhFllTshmQDGvmpyoSqKq
	 lyKwyaWdiNseEfF535QZhdfIk2JEwW6VwqBn8dcK/af5HNAymh8lyj4zm27M93kAFy
	 S4RKx9fjYCt7A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:48:03 +0200
Received: (nullmailer pid 1768293 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/18] xfrm: add state synchronization after migration
Date: Fri, 12 Jun 2026 09:46:26 +0200
Message-ID: <20260612074725.1760473-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612074725.1760473-1-steffen.klassert@secunet.com>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

Add xfrm_migrate_sync() to copy curlft and replay state from the old SA
to the new one before installation. The function allocates no memory, so
it can be called under a spinlock. In preparation for a subsequent patch
in this series.

A subsequent patch calls this under x->lock, atomically capturing the
latest lifetime counters and replay state from the original SA and
deleting it in the same critical section to prevent SN/IV reuse
for XFRM_MSG_MIGRATE_STATE method.

No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h    | 46 ++++++++++++++++++++++++++++++++++---------
 net/xfrm/xfrm_state.c | 11 ++++-------
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 4137986f15e2..be22c26e4661 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2024,23 +2024,51 @@ static inline unsigned int xfrm_replay_state_esn_len(struct xfrm_replay_state_es
 
 #ifdef CONFIG_XFRM_MIGRATE
 static inline int xfrm_replay_clone(struct xfrm_state *x,
-				     struct xfrm_state *orig)
+				    const struct xfrm_state *orig)
 {
+	/* Counters synced later in xfrm_replay_sync() */
 
-	x->replay_esn = kmemdup(orig->replay_esn,
+	x->replay = orig->replay;
+	x->preplay = orig->preplay;
+
+	if (orig->replay_esn) {
+		x->replay_esn = kmemdup(orig->replay_esn,
 				xfrm_replay_state_esn_len(orig->replay_esn),
 				GFP_KERNEL);
-	if (!x->replay_esn)
-		return -ENOMEM;
-	x->preplay_esn = kmemdup(orig->preplay_esn,
-				 xfrm_replay_state_esn_len(orig->preplay_esn),
-				 GFP_KERNEL);
-	if (!x->preplay_esn)
-		return -ENOMEM;
+		if (!x->replay_esn)
+			return -ENOMEM;
+		x->preplay_esn = kmemdup(orig->preplay_esn,
+				xfrm_replay_state_esn_len(orig->preplay_esn),
+				GFP_KERNEL);
+		if (!x->preplay_esn)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
 
+static inline void xfrm_replay_sync(struct xfrm_state *x, const struct xfrm_state *orig)
+{
+	x->replay = orig->replay;
+	x->preplay = orig->preplay;
+
+	if (orig->replay_esn) {
+		memcpy(x->replay_esn, orig->replay_esn,
+				xfrm_replay_state_esn_len(orig->replay_esn));
+
+		memcpy(x->preplay_esn, orig->preplay_esn,
+				xfrm_replay_state_esn_len(orig->preplay_esn));
+	}
+}
+
+static inline void xfrm_migrate_sync(struct xfrm_state *x,
+					  const struct xfrm_state *orig)
+{
+	/* called under lock so no race conditions or mallocs allowed */
+	memcpy(&x->curlft, &orig->curlft, sizeof(x->curlft));
+	xfrm_replay_sync(x, orig);
+}
+
 static inline struct xfrm_algo_aead *xfrm_algo_aead_clone(struct xfrm_algo_aead *orig)
 {
 	return kmemdup(orig, aead_len(orig), GFP_KERNEL);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 327a855253e6..fcf6f0c6400d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2027,10 +2027,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 			goto error;
 	}
 
-	if (orig->replay_esn) {
-		if (xfrm_replay_clone(x, orig))
-			goto error;
-	}
+	if (xfrm_replay_clone(x, orig))
+		goto error;
 
 	memcpy(&x->mark, &orig->mark, sizeof(x->mark));
 	memcpy(&x->props.smark, &orig->props.smark, sizeof(x->props.smark));
@@ -2043,11 +2041,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	x->tfcpad = orig->tfcpad;
 	x->replay_maxdiff = orig->replay_maxdiff;
 	x->replay_maxage = orig->replay_maxage;
-	memcpy(&x->curlft, &orig->curlft, sizeof(x->curlft));
 	x->km.state = orig->km.state;
 	x->km.seq = orig->km.seq;
-	x->replay = orig->replay;
-	x->preplay = orig->preplay;
 	x->lastused = orig->lastused;
 	x->new_mapping = 0;
 	x->new_mapping_sport = 0;
@@ -2193,6 +2188,8 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	if (!xc)
 		return NULL;
 
+	xfrm_migrate_sync(xc, x);
+
 	if (xfrm_state_migrate_install(x, xc, m, xuo, extack) < 0)
 		return NULL;
 
-- 
2.43.0

