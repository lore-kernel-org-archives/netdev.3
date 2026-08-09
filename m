Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698583403E9
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786263121; cv=none; b=urD25a9v33NYI3cTYWV1X2k3lP3Z9RxMYc+lTPksHjtbSvNKntAkZXZ4C2yhErejBD3yYDlUhCzBAug89tyjRu8LicXzZ3Ygm+h/C/eki4mgIyQ0JFE+m0Nwo74G7i8EHWRxj53Gir0+Ni6hK7NgClNX2WH5ilQqF4CSy8gcoa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786263121; c=relaxed/simple;
	bh=InuP/K6z4lopGVGWwZBA/9RBqleRgWdwok4iINWRO9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ig/BuRrvM6Kwho+Jr+pxXV8qyjJMhd7kSdIXPM6peof+nxiwhjUi1KgpFxxBXvwF83QqkJb6z+Wz3VIVQHU7te3E0BMTSWxSatQM8NUeqaZ7cBFhDNNbWEG+AWQJgv83OxeuasbO4zrnpeGIER/tZvLzqhh+BRESXsnJwuLHgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVwDH3y2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVwDH3y2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cca0c5799eso8198665ad.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786263120; x=1786867920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Ez7mz7N4Xfb24oaMUkR35gO1rBs2FfHitMCuilny6Q=;
        b=eVwDH3y27YNESEOc7egYSXqL8geDeiMeM7YRwZgTXRAYmG3zACM6DoiFb7qmFV1xeI
         HiVGo8R354dJ41PoakzeO1/voNqrMYyXelubRhulsTNgo1V+z57PKKfr64ldVlCv5zx1
         RkPnglamzGbwY1IyrS1+V8bU14ynEpifmeWfHi5hpr1CzdYRoXiubt5fOVq0VBxd5WLm
         8dxtep8boaPtWwxPCYu+zsgM4j1NjCwacUllc4K8HJpTtpljIaY7/TwpQohRjDAgRVQS
         Fp1kFBpmEwIcqut98PBGG1PqovMa37Y8Fdxy9eaRyoFneCKRHGxAfIjLrTy9+raOhLs9
         VzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786263120; x=1786867920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Ez7mz7N4Xfb24oaMUkR35gO1rBs2FfHitMCuilny6Q=;
        b=PHVrOK9s4Py/LSNnrewV+GA7doj68wdAOyNoX446hk8PuYwfjVhvMG02Byt7VcOnRx
         jxkxg+5k7JMYv7xfvMFXqOAhC4cPhIkw1XIOHFRVRL2naXzwPRxvLBG9zV1xEi9Ymau3
         8xr8TOkb+viRbFr45A3wxsv7PHjGFii+mIFM3UAIZaydgiH/ue4Jd2BZ73FRI5f4M8vy
         c0gObKPH6JXn79qULe6AIIKuP/zEHyhtwsMHVl0duAuG2VwEpzdntfcmdlB/Cby7liN7
         C7D9NWrxYwDYEQqraQu6RTT3KWFvbmDxsUx3oK/+Q2Op1ziiSkD6h8sMYaLsfSxeaRmS
         kE9w==
X-Gm-Message-State: AOJu0Yx092QkQQit9v671K31w4lMsgVidcvnDSz/tUsKCuV08SH6cL/5
	TMTCxdLdmkc1DBUheaboKoIIu3OONcSFTpBJjFFxQXmC1baB4XgAR2ak
X-Gm-Gg: AR+sD12d1aAdnTYK4N7aPG8nSJANjrMaDamya/EpYoayCVg7hOeslQsrI8zuPgpRIGS
	H4c7oGNAvViZJ9i7D2klgc/sd/zwTbccxbX9iQHDNw5jhSsyPJRf8SdNs69EipAB+YVKOPZr8IN
	gkEaRMAyhVDY+TYxHhg7uByYBEgNcHoQ2/vse3ypLQyOHTe9+bhUNOoAIcmOFGcNz2fOi4ymgOf
	+Xnk6Z1tVOkCVQXXt2RJ8v7HJKY8lZL/qDRjJOg/+jGGabPwQ0+RdVWgbjViZ79Ep8BG6s1h3C2
	iEZGbVP4YBOcwWwofqJxEhjPzYluiazjCqmsZ4kPMvxi+PGsNtefZUGS445mXGmQdGpYLqZg3u7
	MEpW3n8b+CAiVvAW7uhUwc14E3LENnSO1mu3joZ4jmL1fsNMa+xfL9m/O5tSxYbzykj8wybjMPI
	bU7HWJOKRfcZQ/PfGmX909NtRAcDSds50uMrCva6lXZDTriev8e394hIwYpgYyPzvzbnpmIaQ=
X-Received: by 2002:a17:90b:3841:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-3928225dd9emr10661705a91.6.1786263119582;
        Sun, 09 Aug 2026 01:11:59 -0700 (PDT)
Received: from MacBook-Pro ([163.125.147.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff24552sm8288504a91.10.2026.08.09.01.11.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 01:11:59 -0700 (PDT)
From: paulinsider <paulinsider@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	corvus@tencent.com,
	slamhu@tencent.com
Subject: [PATCH net v2] xfrm: hold state while flushing device GC list
Date: Sun,  9 Aug 2026 16:11:49 +0800
Message-ID: <20260809081151.56774-1-paulinsider@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hu EnZe <slamhu@tencent.com>

The device GC list does not hold a reference to the states it
contains. During netdevice teardown, xfrm_dev_state_flush() drops
xfrm_state_dev_gc_lock before calling xfrm_dev_state_free(), so the
regular GC worker can concurrently destroy and free the entire
xfrm_state. Subsequent access through the stale pointer can corrupt
memory and cause a kernel panic.

Pin live states with xfrm_state_hold_rcu() while holding the device GC
lock, and skip states whose reference count has already reached zero.
Drop the acquired reference after the device state cleanup completes.
Also use hlist_del_init() when removing dev_gclist so the node is
marked as unhashed after removal.

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: Codex:GPT-5.6-Sol
Signed-off-by: Hu EnZe <slamhu@tencent.com>
---
v2:
  - rebase onto the latest ipsec tree
  - use Hu EnZe <slamhu@tencent.com> for authorship and Signed-off-by
  - add the Assisted-by trailer for Codex
  - clarify the netdevice teardown trigger in the commit message
  - no code changes

v1: https://lore.kernel.org/netdev/20260801041340.92117-1-paulinsider@gmail.com/

 net/xfrm/xfrm_state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 36a4f6793ede..01138d3d1067 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -785,7 +785,7 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 	if (dev && dev->xfrmdev_ops) {
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		if (!hlist_unhashed(&x->dev_gclist))
-			hlist_del(&x->dev_gclist);
+			hlist_del_init(&x->dev_gclist);
 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
 
 		if (dev->xfrmdev_ops->xdo_dev_state_free)
@@ -1006,8 +1006,13 @@ restart_gc:
 		xso = &x->xso;
 
 		if (xso->dev == dev) {
+			/* The device GC list does not hold a reference to x. */
+			if (!xfrm_state_hold_rcu(x))
+				continue;
+
 			spin_unlock_bh(&xfrm_state_dev_gc_lock);
 			xfrm_dev_state_free(x);
+			xfrm_state_put(x);
 			spin_lock_bh(&xfrm_state_dev_gc_lock);
 			goto restart_gc;
 		}

base-commit: c12cbf56320fb633484ee0ca1fb7d68d6b64b213
-- 
2.55.0

