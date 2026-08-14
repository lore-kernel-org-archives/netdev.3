Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAA2737F9
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786684935; cv=pass; b=jRHRsQsqkkWPzayVz2cBiWAJi1wX45bDznbyv/MN3arQxfpKyvM+CjMZIq862a4L4IM+V6MakrMqhf+AFghlbCHjy6uq3yELgAvmrKfXPgBRgtrWYMb8bOSIzJ7csjq3IIIW3p61uyrOaPAA0X0r6ELyLl/bqQq1LqrDlpGRbiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786684935; c=relaxed/simple;
	bh=ohlmMtYRUDHzK2SRXr8jtcqSs6B3bzuBWR5f8Vws71o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GVuDMuypENNHIaN59Gr28L26TQFmMz5pisy9KNVRS8kxq3xEAM2pEtcaOI0UUphMMqp/2b7xhXRiswtAxazwTC43NpNQfqOfPImNpeZLLF0ZshY7yGye4iEXGZBk+EQiboEcvA4cqAu3XJX3hYs1LEVE/BMMv9GLnoW7nC0zJug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDAc+Fjc; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDAc+Fjc"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c16ac21acso4354051cf.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 22:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786684931; cv=none;
        d=google.com; s=arc-20260327;
        b=qF9RCeHeXMETLlOWjkftViLu6N7a3JxeK7X1M62pu0xTOl132DqPrhO0IErMYV0YcX
         W0ol9MiD1mDn7uVva2F2TvNtzk73fY9hPGnymfg/CsR0DEZ9tGbje+qPO2qMSLM5ICrT
         z+1FYi2mPWibqIWtntoRk733Hhn3qeAglhO5FT53uYEgk/4zWmjeK6wzgvtp8yjhN9/8
         SsCLFUfhIwrvFXy0UaGYPgeLh98rPSEwi5KfM6V0zECfWRWy10HNdsQXyAPQ8bq9OGI6
         8OBY2bsI5NyCU+B/AgD6uj3HedBVGAx4PBfvCWN1IAZReXASb/MZIfRFnKAm7tiAy3+Q
         gy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3JXE+rmvpEkwSkNziwCSQtGp5waZRrqyKerzZGgG2sY=;
        fh=VhJHrUiILU09V2g814CeciQkw6eEF/YpX1SmDx5g63Y=;
        b=W1gUgKI9icAxB86i/sFEk3MnEnAmUUGjqScwQiSHOanNCh1Q8fWWqEQ6Usj/D0E8lp
         RRwnID//vhb4fX/FQjDZyxcq4++lnKiVt+YRXMG21CnlR8LXYyh5SNLgvodOQiGobAZ1
         7e3MjeEVTxNjsXE4cbABPy0w1hE1QAQ2XDxZsT6sFlFvS+d2tXZC7VC8/lEFLupToiz+
         2HWI4LyXN7TuX4VUVw3UKhafKVTnWcOe+g3YakM+l5cOl3hjP8Y5+60svVYKvhP+jsD/
         QDm8RXPzXFmfO8qaPkXWggDxswf2T9fY1oTtQHOh1V48LrXq8FUhpmtp2OuT/mnG7GkI
         rdzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786684931; x=1787289731; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JXE+rmvpEkwSkNziwCSQtGp5waZRrqyKerzZGgG2sY=;
        b=HDAc+FjcNeppvJc8NTCgpcC/yZXXpm5Qk6JcLBuPq0FbJT65ELvxvNJnYFrjxB1xnM
         VERePqHJtM46jtMkD7jc/uWqtaLuGYg1LWE2mU+5EwSrYvvBEMNKsRpu8jZ2jdHZRX2P
         JxaRE/HN99y15TRSJeK/6K/h9PeGfllYEOkbMJYKsjlGKG0JwK2dXHsl+7IWjrOuzQw0
         GfLnkM5ZGMmRJj3J7JjGndpOLMa4B2m0FSnwJD+t62jjmHY5MAZxkdwwExjb1Hs3R93V
         V96d5a3v3B+oPfFn118gy+5dO5ZZMbb4H4BHbRwufExTjbALl5u2CXqwIU6R7dAvwF7u
         nQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786684931; x=1787289731;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3JXE+rmvpEkwSkNziwCSQtGp5waZRrqyKerzZGgG2sY=;
        b=NxHHRfuekYZtt+8WBHxBCTllWcSXGvzS6TTBlndZljVkM9F8jhvKFhAmmF5/BIUXFA
         dF4SgopRb07I53tnPbL2LKQHPUNR6Ndf0BWnZydKiYSTg6xnYmeZrlzP3++fNZfiCa5S
         55MzSybbAGMMNX6kksdUlh1q4TcUpkrqSbmYF8xJ5rEvnw+DoEy0fEcsphcYJK2lRmPZ
         FZzJ/TLSMCHtEOA33gvqHar9oVwDlC2gkQCxO6Id/dLty0F3rqx5adIFWnILF6IyGPnX
         FK92LlytTvbZL7g4kwAOL4gB/fOXaIPerzCQnXBdeFl6GisivpfyoTIKRvf920cDM00J
         yweA==
X-Gm-Message-State: AOJu0Yx1X92kCC6YXboHJLhNUesa2eHfqOxuMEsj6q5lgYJmLUSRXcQr
	jYGLMyPn8+EPv0nPN2bxCG4SFwqyYDhmYUqvRnW3GvtzGF5ojfGXJsN30KaHcVyjpyTj5DSmRix
	j2dlhKQxqBhqMFdeUZrP5koirtOjvDG4=
X-Gm-Gg: AR+sD10RHKdTg0vPzzsBwdfsbha6PztECj5j2ThOiDQ1uSjRlMIP/QoH5MPkE4YoIGi
	gImiymFDkFloQg/lIe11OsLaihZvP9jsOrgcgXJjVnnH08eImhvKvm8GmH8HNlvDgN2FlooFA+O
	8pqM8l3xpEnZjft3FFexJWMYMYAIaGr93RHi7aTvj3FWf6BjLvsCW8JGCDLEq7DJnHMYQYstVG1
	kvQwHBz8kPULcpVrT8G/cEULPHtvlTz3O5sJD3i044dhS/arbaud4Lpzfu4NudrTDp2IyFfmnUm
	QRe5U7JnIY+zBjzZeYXrw2Tiyb/41eUbomA+SOFegLM=
X-Received: by 2002:a05:622a:4185:b0:528:3882:386a with SMTP id
 d75a77b69052e-52d8534fbbcmr45236501cf.11.1786684931381; Thu, 13 Aug 2026
 22:22:11 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Aug 2026 22:22:10 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Aug 2026 22:22:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: diegomancera.dev@gmail.com
Date: Thu, 13 Aug 2026 22:22:10 -0700
X-Gm-Features: AUfX_mwI94UpPhk7GoTpsv7_OM87DrWKt8F-iw2PwKxn6igkpnk3x07qqidsnKw
Message-ID: <CALruWrVTmdRYoCQ9kh7n2KJ_HjGKhMkhX5_ybMYwCgeCJiTnKQ@mail.gmail.com>
Subject: [PATCH] net: stmmac: restore XDP configuration when reopen fails
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Exit code: 0
Wall time: 0.3 seconds
Output:
From 7691567e29d241f28d1525d99b11faa2d5831f3f Mon Sep 17 00:00:00 2001
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Date: Thu, 13 Aug 2026 23:03:56 -0600
Subject: [PATCH] net: stmmac: restore XDP configuration when reopen fails

stmmac_xdp_set_prog() tears down the datapath of a running interface,
replaces priv->xdp_prog and then ignores the return value of
stmmac_xdp_open().  If reopening fails, the interface is left running
without DMA descriptors, IRQs and queues while userspace is told the
attach/detach succeeded.

Propagate the reopen error and roll back the program swap on failure:
quiesce the partially reopened datapath, restore the previous program,
release the reference moved in for the new one, recompute the SPH state
and try to reopen the device with the old configuration so the interface
remains usable.  Preserve the original reopen error and only log the
failed restore attempt.  Also update the XDP redirect-target feature only
once the request succeeded.

Fixes: ac746c8520d9 ("net: stmmac: enhance XDP ZC driver level
switching performance")
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index d7e4db7224b0..c90a1eb2ed31 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -104,8 +104,10 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv,
struct bpf_prog *prog,
 {
 	struct net_device *dev = priv->dev;
 	struct bpf_prog *old_prog;
+	struct bpf_prog *new_prog;
 	bool need_update;
 	bool if_running;
+	int ret = 0;

 	if_running = netif_running(dev);

@@ -117,25 +119,48 @@ int stmmac_xdp_set_prog(struct stmmac_priv
*priv, struct bpf_prog *prog,
 		return -EOPNOTSUPP;
 	}

-	if (!prog)
-		xdp_features_clear_redirect_target(dev);
-
 	need_update = !!priv->xdp_prog != !!prog;
 	if (if_running && need_update)
 		stmmac_xdp_release(dev);

 	old_prog = xchg(&priv->xdp_prog, prog);
-	if (old_prog)
-		bpf_prog_put(old_prog);

 	/* Disable RX SPH for XDP operation */
 	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);

-	if (if_running && need_update)
-		stmmac_xdp_open(dev);
+	if (if_running && need_update) {
+		ret = stmmac_xdp_open(dev);
+		if (ret) {
+			/* stmmac_xdp_release() tore down the datapath and
+			 * reopening failed. A failed open may leave the MAC
+			 * and DMA running, so quiesce the device again,
+			 * restore the previous program and try to reopen
+			 * with it, while preserving the original error.
+			 */
+			stmmac_xdp_release(dev);
+			new_prog = xchg(&priv->xdp_prog, old_prog);
+			if (new_prog)
+				bpf_prog_put(new_prog);
+			old_prog = NULL;
+
+			priv->sph_active = priv->sph_capable &&
+					  !stmmac_xdp_is_enabled(priv);
+
+			if (stmmac_xdp_open(dev))
+				netdev_err(dev, "failed to restore the previous XDP configuration\n");
+		}
+	}
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	if (ret)
+		return ret;

 	if (prog)
 		xdp_features_set_redirect_target(dev, false);
+	else
+		xdp_features_clear_redirect_target(dev);

 	return 0;
 }
-- 
2.54.0.windows.1
