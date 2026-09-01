Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3237B3F7
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788239463; cv=none; b=tBRp6NKH9UBQHFSFrwfOp18tQvSXBxra7dz20etRrmRxrg4W5XEGJMRqqdX5cz0T+vyMjwcWovmy6rb9Oyz4m3QzP9fb1ihdgfjwZ6JIPYTSEwpyHO+tAcVayGnVrQHfhBqDNQYNsSDbMBUNgMQH11clXK+X9pmDXEhm74QEk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788239463; c=relaxed/simple;
	bh=vbGlfRyLwZVka6GimJ63pj7KDWdXF7NVcnjDmm7eq8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=piIWtfTRk74854xrdnfVlZpAbsGe+URFhsS47vXWG/06+5ril4DAiVHpFGCpWuqGXE6PhBcrQ3hDU6HBulvttvYbBP2+gnbCsUtWkFSUKG2oQSsYcpiYS4l/CY/JCxFos00pFNgOksRNByNcrXV7KlNgKcJJSfuukEqLQulRnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=pj13ft65; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="pj13ft65"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e27035206so4230657b3a.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 22:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1788239459; x=1788844259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TgIkXpftvvFCVLKDySVWq2yJTLHQ1QmLBt1UAyu0skQ=;
        b=pj13ft65F2NnbnQqFT+U/H/FALlS9iVRk6AfgSQEPpMHQ4QmQdkpXiem1WuuP3UQeS
         qAu4ZQVmhYVZnPH3jSEAgsd88mufjgJ43jpveLfae6YWi2gB14alpcMlM8GFFDirueiW
         NDePlXFEW4EhFlZnDx4mevNnX8IMlRBTXLZLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788239459; x=1788844259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgIkXpftvvFCVLKDySVWq2yJTLHQ1QmLBt1UAyu0skQ=;
        b=nYrkz9O3AWLgWUSZ0FiyU9Fss+wR9CKsVMWz9vB/crLlC5OnZbH3aX7z6415rO7fbG
         x8oZpRWpN6cWcEeHBP2ARWcgODXdCkCT/u3PBvyeBYH4WEnlh5n+l/8R8sKKcdEsyS00
         N7OUAsu3LiP3PE6aL5XYgCHD5vWRKwNkFJlsAxHmkcJEB76Ixc1hhBbV4EaVOMNq9j70
         CG63plk0Lsi9qZofpZqzOEknHLCE48FsWQKbpaAPjbo2SZWQN5XXvwafnjPleqVISCRe
         JwyxRSL+TMm/HX8MMovMpl+adQbC1NmKnSCrta2yuQ3YsRRGZBkR6iHpJLqX7gF0naKm
         P5xA==
X-Forwarded-Encrypted: i=1; AHgh+Rrfeq6agSln+EE1+/DC2BHe5g1fQqYXGEtT/a7i66Tzh/ysyBrk9WRPQdlz1WYEZACqjxCH6h8=@vger.kernel.org
X-Gm-Message-State: AFuF++mHkpsJD/raWjrM9woPbAqgF5w73waBar//nk/zDUowMxbj0JCw
	wX7N2GXzVRV8Dlfqt7zhDtJ7ABQYFL6Tp+oQosSiofr9zRR6f0rglkyf1KxioD1C+U8=
X-Gm-Gg: AR+sD10/sR5UiF+nQmKCyumgqpson076FiBVJxmw6sTaSqDoDYist3I6yddnYHymFxy
	pRrGrLSZUCNpG5Vt8h1YS1hsYBnHLznOnL3glvqlbHPHnG4S1jZ6aLpnpnTxdIVp4/nranWSI8t
	qPGn2hQnextroRMEABaPXhZlts0ZWjskkB6ROXXGZXIrfQ5x/Msz0KT1MKL2VeiKpdwVUDPCdyo
	bPweFoXyEePfrMcHb06z5xejac5UA/mmj+omc+aygKGXuhecFpepRbgyo6IIfFnEnCYS9b2vgju
	QOZEJV6Zhl4OP8d3xgdK8FP1v7WVvcC8aIKfQD1Gll6wDFC1Y7Q6Yr3DJeh4p5A+GT1kGucvc4f
	zvwAPht5XhE01vPylpUSj6Upx2dfW+u2p9zN6Bv2O9CZ4Q4vPWuv7UobCZiD3vF6h/5xWxwd2Tm
	4u6+MwLUAL58N8CToZ2fJyta9yY8ouJM4gWZBUuOTEu6AZ8LW/eG5GACFCdGllnBtAfVn+vVelO
	pHyxfBr1wpJ/vr8m3kuhNbG9EW2Py+SEVt93eOoPvSE
X-Received: by 2002:a05:6a00:94f3:b0:848:2a71:a48a with SMTP id d2e1a72fcca58-85b5b41bb67mr8980750b3a.13.1788239459380;
        Mon, 31 Aug 2026 22:10:59 -0700 (PDT)
Received: from DESKTOP-2P4OM44.localdomain ([175.195.197.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be9348a85sm466880b3a.41.2026.08.31.22.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 22:10:59 -0700 (PDT)
From: Seungwon Bae <qotmddnjs@ajou.ac.kr>
To: dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	Seungwon Bae <qotmddnjs@ajou.ac.kr>
Subject: [PATCH net] rxrpc: fix use-after-free in rxrpc_poke_conn()
Date: Tue,  1 Sep 2026 14:10:45 +0900
Message-ID: <20260901051045.58252-1-qotmddnjs@ajou.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_poke_conn() takes a reference on the connection with no liveness
check, unlike its sibling rxrpc_queue_conn() which gates on
atomic_read(&conn->active) >= 0.  The per-connection timer is armed with
no reference held for it, and rxrpc_put_connection() cancels it with a
non-synchronous timer_delete() only after the refcount reaches 0.
refcount_t saturates rather than resurrecting, so the connection can be
kfree()d while still linked in local->conn_attend_q (nothing in teardown
unlinks attend_link).  The rxrpc I/O thread then performs a UAF write
(list_del_init) plus UAF reads and indirect calls through conn->security.

Reproduced on a KASAN + PREEMPT kernel: 56 "refcount_t: addition on 0"
saturations at load, escalating to

  BUG: KASAN: slab-use-after-free in rxrpc_io_thread   Write of size 8

AF_RXRPC socket creation (rxrpc_create) has no capability check, so this
is reachable by an unprivileged user.

Guard rxrpc_poke_conn() with the same liveness/refcount check the sibling
rxrpc_queue_conn() uses before taking the poke reference, so a connection
past its last-active point is not poked/requeued after teardown began.

Verified before/after on KASAN+PREEMPT at equal timer volume: 56
saturations + 15 KASAN reports unpatched vs 0 and 0 patched.

Signed-off-by: Seungwon Bae <qotmddnjs@ajou.ac.kr>
---
 net/rxrpc/conn_object.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0ece717db..1be50e0c9 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -34,7 +34,10 @@ void rxrpc_poke_conn(struct rxrpc_connection *conn, enum rxrpc_conn_trace why)
 	spin_lock_irq(&local->lock);
 	busy = !list_empty(&conn->attend_link);
 	if (!busy) {
-		rxrpc_get_connection(conn, why);
+		if (!rxrpc_get_connection_maybe(conn, why)) {
+			spin_unlock_irq(&local->lock);
+			return;
+		}
 		list_add_tail(&conn->attend_link, &local->conn_attend_q);
 	}
 	spin_unlock_irq(&local->lock);
-- 
2.43.0

