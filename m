Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086B2165EA
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062189; cv=none; b=c0FhmLG1kMaGT5OAKIHTtdfe4K9zppPsJfVG7AZgGFWpPXpjh+9PwCL0glIKnWZWbhufdHlGczVAD/yPezeyt54td7+zehk9WBLwpc4OXmlDVnSUkorblSgJJ/5SOwk4MhLfzothZgoAzJDkib7MNfCpT0dzh1PABYbFBiQHpLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062189; c=relaxed/simple;
	bh=EFYhBynMAaNcd1fjC3bL/hTRYOxwE8QB3zNhiLwQt+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jbb5dwU6hwI9PrxzU9n3QBWzbwkHKtWmjZ/UHtda5+nfz8swzetF5CEnJy/frH4X+nQqHdOLm3JusKJ0jquj1ytCDD8IFrktkVhBV72eS0WRkH4eNsr+AMJ6E32c+Xog7E5fB0JncT1XyQxOaAGiAZglvpA5wGDi8qxK9e56sKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=C2qvDALC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="C2qvDALC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so24727125e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786062186; x=1786666986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WnL626t/uWWQp4KgYZRv7oBKfB6koRg5weJsbODC44A=;
        b=C2qvDALCi9vOi8wBTyTuhTbWiJXK/a+zV6vOHXc3bVQnzWTifzOQmq+zblcLEfHHA1
         H9I2fCHcZkL7oK+AUh76oxyfOvusrh0Bz4NvgELHYX+dSrHLpHeOTpowUh53XUZCqzu9
         9L+RdHv+nUuDDE7+MQVzNPui2KZYUVJaVpQRYuTRUoFjdDjr5WX6NhBTPqqbzrWWnJdG
         Rr8527qPUTYLzxqcjMot3vOoCVtQXDUoqysKDiWS7oWtAWLag8gmHzrxMxgpdjqumc6s
         tk5fdAlVwI9rMJsjEjVTqdA3geIb0tfnlm0xQQsC9vmevv/EhCDqIXemWGxhEXzdGBoh
         jIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786062186; x=1786666986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WnL626t/uWWQp4KgYZRv7oBKfB6koRg5weJsbODC44A=;
        b=NCRguuXMn2DS2MgRg7D60BX6r5KCBv9Sj+x2C7LJOEf15UUGX48uIteJA/iexJquRt
         +NI8X5VJk5RsOIGENLXQtRcjGa7J7cQUbi1AOM7KNtWKypNn1WBm7KsBb/Uwds45t0Jp
         LbHW8+Be3EkHiyV6dMB/SyOwKe3LQLCqn2mxPZiXJWuR8jx9XgUcCo/zl/wgowEjoT/E
         jCZ701+VpXKQJ8pUXAGcNKjfF2XnNjrKVtLvzw01tWsQI9a8XFc0zAh0H6/3yyOtKMJ+
         FSHXApYZxo8IYedL5xyAj5BxYCP7ouY8PlKqymKjAlwad7cKOB9YorlSmP3mnVaNqEUD
         oTFQ==
X-Gm-Message-State: AOJu0YwRN7b/BAkz4gPXswIYXXGYRvVga1lyPgWAD6s/DCyyMgZRy+4u
	KHIqvOpGwScnpbPzWcbvKBtqL22kT+VLQzqz5/828RiuE4FmRVONEVB16dV3UyB2q8LjMX6ny8K
	nWfYPDiKKZ9gJ2iCAB9LklS76jbpDWGwY0HaaQ/1K/PvpcNPu6i+UqQX5i0ip9cez
X-Gm-Gg: AR+sD11rKdKh2x2bCZrI0/RdzamIZ2L/J5iKe9Sd/3vtZ1dngz1vQjsnNQ0E58gzEjM
	n/BuRkmGgT1luaLKkt5g1g9VcS6DLL9apTK/zPtpWp6RnFsTb+M3f5hC7m0aNJ3uoBHY2bgI8Ry
	EGU3LqZMT8Qmo4Mm6tt46a/1gvcELPKZlTFfPB3n5JtvmptjCHiefSywTwBArvjwdmgZMZ6Mmau
	l5dq76M/+lzIGtIEMZnDGdayInWbXp7v//y/wLJcOsSZgkA00x/PLJdP9LFLLdEEIUG4dhnicfd
	+eoHuaNVH/mr/fEhwAtB1VUDjBbsJr/aMfeyq4HHkqMV5hVQBQShrJoUCWLh1NXNqb+0xssA0p1
	i8IrEzfhBiiWGKdBDMLOdOd1rg7SDEYAoiLe603LALh+6m99n99vR2iagP4QB7S0jE9ni5fPe2V
	f9wA5bz0NOXGu6RuoYUL3VSu5VC7l93JmTacrfDKdqoYcUevAJxUFBXpN0EQ7a4X/oO64jaSMu+
	kPYqK7nRAWP
X-Received: by 2002:a05:600c:c4a3:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-4994e71eaf3mr240736435e9.7.1786062186364;
        Thu, 06 Aug 2026 17:23:06 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:6db2:29ac:6c1f:5e1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm359215f8f.22.2026.08.06.17.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:23:04 -0700 (PDT)
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
Date: Fri,  7 Aug 2026 02:22:44 +0200
Message-ID: <20260807002250.1817498-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807002250.1817498-1-antonio@openvpn.net>
References: <20260807002250.1817498-1-antonio@openvpn.net>
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

