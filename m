Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB434752F
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786310518; cv=none; b=lB+hth9J3/pskeg9yqwyaINj6TypAXE0IkVwWxb+fVQxKdahadBpUlpcnf/2wQEcg/WWZ3VpxYc7jfMH94spAWJ84V4NbA9na6TrU8M0f8PGEOf6TaRxy780RDsFJtjMdDMBmD615Lv60mu7kaE3KsykHQPWKKa9PEngDdURep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786310518; c=relaxed/simple;
	bh=EFYhBynMAaNcd1fjC3bL/hTRYOxwE8QB3zNhiLwQt+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfaJQosl30iYXK7/WAtvJnoOmSGzjMNvlhep/Z5LMvsPhMA20PRcUvaPMhelwBzbEWOP1U3bzuP7AB96UGGcyRI8VhPyfLtDtDA66lBowPceWBu0y2sZv5QYP2LCkOXBZkF9VqAmED7ZMiPVOklraqgD5gfD9UYymXzoYyoyK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=I16pKFph; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="I16pKFph"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47db714766aso2125769f8f.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786310514; x=1786915314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WnL626t/uWWQp4KgYZRv7oBKfB6koRg5weJsbODC44A=;
        b=I16pKFphAMCvUGFzjrpJqBigS3szFxLOjx1XtEATVYfUOEEcOwZEIBQfHee4xmpaRh
         bpVyYCj8zm23VZs+dWLr82eApRNk0d2SNIh4/VWTQDkSRYSfxJ+VKp+gA+qwZEUpeICR
         1m9HrobznpvPkxYCsh8LG6xLlk1gRzqP8XnvMEMhwGn4D6yeJPvUZojguldGxA6MMsIk
         6M2dqGBYEQo9NafilqNRC3HUlCB6sFFGXfsT24I3bgWRU/rjE2tbCseg6Ua+zhlmOtth
         qt2rMHyT3jVbTpaOfPLXTcTMHPNUQ0hoqmAoaW9wU5FlmyVQ3EhIBkLl4aABDIP8Cny8
         61Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786310514; x=1786915314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WnL626t/uWWQp4KgYZRv7oBKfB6koRg5weJsbODC44A=;
        b=OHa4H2+8i3hMICY2xFaGtVBgcbkZyhcDyrpnupKVZlCsVm3R+i4LRM2yOXUCAH4dPc
         wSw1Ie/CBXqGPrQ8mIySGiJ/tKu2Ve90TgWs0GuLfsWqnX5VyRt6R8pj2Z0Y63/QMVvN
         L69voKbCVLpRyi6nJ92WgGrrOLv3epszipnW02eyd0StGXHYwdUGwXyCfxlStnytAiM+
         5hen8EMMAXiurZ4pDr6UOwg1NTVL61F2fXFswBVEs/MB9X8jVM1UQcT4hEM37QhlOjDh
         V6zMqTPob0LOQnAgWzNxmqWEcxEQeknhM7pQWIhFXISZFsNPzvCfDW26FXCqDGZcFSf2
         Di3A==
X-Gm-Message-State: AOJu0Ywx9r+Chf/4GS9t+rcwBhInLUoD2XH/eUhNdidUJhANa2YCk0A5
	abGAQfcf7zXI01ipgqAYhm+bW2yFmbUJHychgSbNmZ5HamNhy1wPyAhGKTI8PON9iLk3lJ53ukT
	l2MXgCHJ+w49XzjwCVPBy7ptISPd9ccpR4NdJAjVdbUVTXKEQYkchywdb/mzlTHKs
X-Gm-Gg: AR+sD11/aqCUOCDmUCsnyPDFfvvZRmV4WUoQsH9aGaJzMaSSKR9FkZaMTM7Ldsu7Ng8
	/c1IsKlm37RM/lPVkVDYJJUR2X/G7ySQU2F3j1CgstWSNv4D82yOsEFghGXijQn7TZmRs+q49SO
	WVHvEwMroF17r1AzMp6MVkdBvKTXjdopB0ijImZEhYqhksQrnoQCfOjp959uFZszKRyGm83bGwR
	hOTS+tFF+DvaKK05rHEOa9R5RnfhnDTyZB79DGlwOzKw1C7hCdf3CpgNJudMvjafdpa0T+PwZr0
	czv9XdRTVd1R4SKwrYEPJ5t2OZOLyKQt1wzH9ByIi9FxHq+aRlnrDPb5Gas9ZxTirt6YZdcVXxc
	/zkOiZSgTbNZU8iadvVT6UFtbXgTHVB/29F0oAIsXhYRMnmvb8/8BFdgWpqcA2rq26t1GMEiWk/
	p5yp3CJHD7BE8hku9dLrHJLKHpkqe5qmx0nR3QtSnCRd+DhIIzoieQczgk1tuC2ATuMPB1cBJHR
	Z+xwimJe5zvae2awGD7RbE=
X-Received: by 2002:a5d:64e7:0:b0:47f:8abb:1fd2 with SMTP id ffacd0b85a97d-48131915e9fmr18982841f8f.3.1786310514517;
        Sun, 09 Aug 2026 14:21:54 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:58c9:fa0e:8293:9eba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002206effsm24976651f8f.32.2026.08.09.14.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 14:21:53 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 4/4] ovpn: defer key slot crypto freeing to workqueue
Date: Sun,  9 Aug 2026 23:21:29 +0200
Message-ID: <20260809212142.2249027-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809212142.2249027-1-antonio@openvpn.net>
References: <20260809212142.2249027-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Key slots are released through a kref and the existing release path
frees the AEAD transforms from an RCU callback. That is not safe for all
crypto implementations: crypto_free_aead can sleep, for example when an
async or hardware implementation has teardown work to complete.

Use queue_rcu_work for key-slot release. This keeps the RCU grace period
needed by lockless key-slot readers, but runs the actual crypto teardown
from workqueue context where sleeping is allowed. Once the rcu_work
callback runs, pre-existing RCU readers are gone, and the final kref put
already proves that no transform user remains, so the worker can release
the AEAD transforms and free the slot directly.

The previous patch drains ovpn_wq during module exit, so queued key-slot
teardown work cannot outlive module text.

Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto.c      | 10 +---------
 drivers/net/ovpn/crypto.h      |  4 +++-
 drivers/net/ovpn/crypto_aead.c | 19 ++++++++++++++-----
 drivers/net/ovpn/crypto_aead.h |  1 -
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 2e95f29514fc..7e545428900a 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -18,20 +18,12 @@
 #include "crypto_aead.h"
 #include "crypto.h"
 
-static void ovpn_ks_destroy_rcu(struct rcu_head *head)
-{
-	struct ovpn_crypto_key_slot *ks;
-
-	ks = container_of(head, struct ovpn_crypto_key_slot, rcu);
-	ovpn_aead_crypto_key_slot_destroy(ks);
-}
-
 void ovpn_crypto_key_slot_release(struct kref *kref)
 {
 	struct ovpn_crypto_key_slot *ks;
 
 	ks = container_of(kref, struct ovpn_crypto_key_slot, refcount);
-	call_rcu(&ks->rcu, ovpn_ks_destroy_rcu);
+	queue_rcu_work(ovpn_wq, &ks->free_work);
 }
 
 /* can only be invoked when all peer references have been dropped (i.e. RCU
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 0e284fec3a75..e3feb16d5498 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -10,6 +10,8 @@
 #ifndef _NET_OVPN_OVPNCRYPTO_H_
 #define _NET_OVPN_OVPNCRYPTO_H_
 
+#include <linux/workqueue.h>
+
 #include "pktid.h"
 #include "proto.h"
 
@@ -45,8 +47,8 @@ struct ovpn_crypto_key_slot {
 
 	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
 	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
+	struct rcu_work free_work;
 	struct kref refcount;
-	struct rcu_head rcu;
 };
 
 struct ovpn_crypto_state {
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 8f07c418622b..74eaf6fac2f5 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -9,6 +9,7 @@
 
 #include <crypto/aead.h>
 #include <linux/skbuff.h>
+#include <linux/workqueue.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/udp.h>
@@ -380,13 +381,19 @@ static struct crypto_aead *ovpn_aead_init(const char *title,
 	return ERR_PTR(ret);
 }
 
-void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
+static void ovpn_aead_crypto_key_slot_free(struct ovpn_crypto_key_slot *ks)
 {
-	if (!ks)
-		return;
-
 	crypto_free_aead(ks->encrypt);
 	crypto_free_aead(ks->decrypt);
+}
+
+static void ovpn_aead_crypto_key_slot_free_work(struct work_struct *work)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = container_of(to_rcu_work(work), struct ovpn_crypto_key_slot,
+			  free_work);
+	ovpn_aead_crypto_key_slot_free(ks);
 	kfree(ks);
 }
 
@@ -420,6 +427,7 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 
 	ks->encrypt = NULL;
 	ks->decrypt = NULL;
+	INIT_RCU_WORK(&ks->free_work, ovpn_aead_crypto_key_slot_free_work);
 	kref_init(&ks->refcount);
 	ks->key_id = kc->key_id;
 
@@ -453,7 +461,8 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	return ks;
 
 destroy_ks:
-	ovpn_aead_crypto_key_slot_destroy(ks);
+	ovpn_aead_crypto_key_slot_free(ks);
+	kfree(ks);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index 65a2ff307898..fae3b585a43b 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -22,7 +22,6 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 struct ovpn_crypto_key_slot *
 ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
-void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
 
 enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks);
 
-- 
2.54.0

