Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C898391E43
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789854761; cv=none; b=Wr9mWJrrI329OvKfU+obZYufH9JEZnmqnD4dS+CHaqe3ZOPVVqYKYyiw/HOX+4wOQrTRBYYfjJ66f8KnA9ZVHD9eDAL8UA3MwpPkNGnIF7flp0EnTnk9ghvfnWandQ6vHYc7sj/H7ZsNSUDgB8tTw189E/DoqAbmYiqu6cYbaaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789854761; c=relaxed/simple;
	bh=VQ9Ha0Kv35OQUZIpcPbivRupE8x247MSqdoR4m67+Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DACZJyLihmYSZLKQDodRvZle6vznd9DaYxsop7AqTz8tlP1Nu5hrOW7TLNta0ii6fIzQFyc+ou6/RLphNRgFrXJNQGM4md1E00dbPhOuZmJwXwsOqWJoZ2XU+nSfxj7QevaTvEg9iexek0ht+DGOAPEDSLE226dtY6uZ04jcHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9A5fMSf; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9A5fMSf"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39d654f02baso1612209a91.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789854755; x=1790459555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9aJFCfj2LQ5guspfVFESmNOnFBxFScArLrkp4w4HDqo=;
        b=X9A5fMSf6Ey7j1lhELdG149NMTlNwd1aYMVzCjjErg3oC//sGLBGsDNxovof9rXB0j
         fj1PiEp4qtAYSJn1+7C/FsjFgPDEmRkj2rHt0t/PcvtWdLfpmQny7OanLzpePEK4Cy8L
         YQzIFNL2MR0hn9ekLlOK5qAmfMF8RAFqLYQyn6YfJdCeq03S44En+3wnAxVsiOaparZr
         D61+UX/X2UNXJIJWTKFMgeNq9D+b+RVkLjp4z2MYlw+kRMwtEaxD77Vhf92R+Vqqoba9
         /Yd3vfwWaEMqrGw1+Mt84JM/DnCJpFa2CQoW9ugv37CVgHDkgVCjCmeUWpFZITQ+9i2L
         8aRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789854755; x=1790459555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9aJFCfj2LQ5guspfVFESmNOnFBxFScArLrkp4w4HDqo=;
        b=CmxjFSPLgMfwPgJ/6d05gWEPa/aTbCqP5lkkZAXCvkw0TOlobJ8sSTTxWBWmdaQm9M
         TfdMMJEFPHZlhPWlTzZrkMbsOF5xDAfrbEQl9WcQrF78JVS7LLcGAkxot/pBGoJ2Ys+K
         tztpmK4iTDVZI6JCcNGgi8kQqNHflGFhTWRMQjRC8ozx0vzIdzfzsA6LvjsSYzBe/X/d
         RmiGihzg0Bil/oEw8g4ccSCz8KCDegAz/I3NBGQdN5OkSEU3NgUt+/cvP0watnIadGbh
         GnfItV6IsOCgKoHR7h3X/mIxxfXiKZ//iUpRv14m5gFHaPrJIA3WjiaafRvtdmgeC8/3
         Eozg==
X-Forwarded-Encrypted: i=1; AKwUvBwe4p4Ogz7t438pbIr3xcdQVXk+d5GMeI42BvKIJXjHBJQZTegPff8jHIx3Z+NpwLl+svfHnFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mdqGDwuvQQMLW1EqPhr/h216UGwo5XmdpDTwb1rjYWeSosViwA
	8BXudZ133ZWNUUQ2KvV0pc7o3g59OaYafUjnsxqvULeIpyq/voyDBdRQ
X-Gm-Gg: AYBFou2YRYSS4sWaVCLKNUWNSQYkgJI3RB+fK1hbIGDb8mwDrXZKlEXY3nnUq3M7zDn
	h/fNgVbbrK6vxwplCa2S97feb+tsALMVnZgFEISpnV8JuniS6ushD8RqCgcuV0+xn/Cjjpk+ywW
	Ab4y1MTEIM5VRYeKu9OHSKZlMR8L1ZaSEzbHFHascH8fu1qdsrrryvXv2RpoqgjgqvgxE3MjQ7S
	OoDAfUn3c8S+cDfhVHkA8qXfHd7u5GKj3qJz3xBi+jTeKNhn2/xVvMkVfqRDrUo753Prbz5ZhMm
	pUJ2XAayQt7X/usUeRxiWwCcEGU3mL2QHxvesNEVRfwelgJwZuNMP5VX88xAUykec/jKVzyi17B
	gCIROFkajZzwzJShPlw8LBRFYvRcnQi1TyE2+valBudQTrSlp19H481H9Ny+LLweP5NTXNN33W4
	CyRzd+ZwAsze3tNvW2BtGrF6l+/zCn3NwW2ffkblf8wCPM9ueASJzfp8NeWOHdfBT+CwVGEUGlo
	2D2KWOF9mUL3EF4wBOsrFuzCU3wEXJo9sBRk5U+r1l+NeadGNHb5tSgq3HPEVmIwwJA4F2SAyzK
	GPARVj6FZg==
X-Received: by 2002:a17:90b:5690:b0:398:bee5:61d6 with SMTP id 98e67ed59e1d1-39e54cfabf6mr11253729a91.24.1789854754661;
        Sat, 19 Sep 2026 14:52:34 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0309d5760sm862843a91.4.2026.09.19.14.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:52:34 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ppp: fix bsd_decompress() OOB read and ppp_decompress_frame() headroom check
Date: Sat, 19 Sep 2026 21:52:33 +0000
Message-ID: <20260919215233.3470411-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ppp_decompress_frame(), skb->data - 2 is passed to the decompressor
assuming at least 2 bytes of headroom exist for the PPP Address/Control
fields, and the returned decompressed length is only checked for len < 0
before indexing ns->data[2..3] and calling skb_pull_rcsum(skb, 2).

Ensure 2 bytes of headroom via pskb_expand_head(skb, 2, 0, GFP_ATOMIC),
reject decompressed frames shorter than PPP_HDRLEN (4 bytes), and check
isize >= PPP_HDRLEN + BSD_OVHD in bsd_decompress() before reading the
sequence number and header bytes.

Fixes: 224cf5ad14c0 ("ppp: Move the PPP drivers")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/net/ppp/bsd_comp.c b/drivers/net/ppp/bsd_comp.c
index 63a6d251c746..03ee4ff4ec1b 100644
--- a/drivers/net/ppp/bsd_comp.c
+++ b/drivers/net/ppp/bsd_comp.c
@@ -847,6 +847,8 @@ static int bsd_decompress (void *state, unsigned char *ibuf, int isize,
     int extra;
 
     db       = (struct bsd_db *) state;
+	if (isize < PPP_HDRLEN + BSD_OVHD)
+		return DECOMP_ERROR;
     max_ent  = db->max_ent;
     accm     = 0;
     bitno    = 32;		/* 1st valid bit in accm */
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1a610a18893b..f7af328b7bf8 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2552,7 +2552,8 @@ ppp_decompress_frame(struct ppp *ppp, struct sk_buff *skb)
 	/* Until we fix all the decompressor's need to make sure
 	 * data portion is linear.
 	 */
-	if (!pskb_may_pull(skb, skb->len))
+	if (!pskb_may_pull(skb, skb->len) ||
+	    pskb_expand_head(skb, 2, 0, GFP_ATOMIC))
 		goto err;
 
 	if (proto == PPP_COMP) {
@@ -2576,7 +2577,7 @@ ppp_decompress_frame(struct ppp *ppp, struct sk_buff *skb)
 		/* the decompressor still expects the A/C bytes in the hdr */
 		len = ppp->rcomp->decompress(ppp->rc_state, skb->data - 2,
 				skb->len + 2, ns->data, obuff_size);
-		if (len < 0) {
+		if (len < PPP_HDRLEN) {
 			/* Pass the compressed frame to pppd as an
 			   error indication. */
 			if (len == DECOMP_FATALERROR)
