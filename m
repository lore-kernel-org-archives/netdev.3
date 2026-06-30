Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190E315D53
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832180; cv=none; b=KLjjwYUbYD3wf3xEbknVtdAcGPAibi1F5nsHUCYj7iJdFAWrccLOnHaMDgnkdRuaa9XCmg/d3rfgeLsHvSrKRabafOkxoh4W1zOJWioCOMbARetQ/mtumVafbcn8EXJ4WoJlUsNe/znGe0KKboXx8N8mJq8DXwQNYqPmwOPF0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832180; c=relaxed/simple;
	bh=YhRQsgrY9BW6dV2KAGeOm/WNB/fNfFPuGRQn/UxoMvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XNst6WUCx8bYYTdnavJgynpvB4Us6dXcWPcTOqtpXV7vtJVHay3OeP2yE2KC4wGJ+gQWM3qZI+NHkBYY4CFNku1ld2mE1V+KJShkz3SH/HOxGqKB57W2rZbs2dToJt/k4rjAkWGL14GL8xp/Z1G17iRw/4AqZDlK9aGLfmywls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=QeiIf2/e; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="QeiIf2/e"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e602d2c0fso71483685a.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782832178; x=1783436978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AveCtf1R8zYDdvUZGMGx9qvpwpByoCyBF2y0phdxoE=;
        b=QeiIf2/eLhNHYc6tFrgqqSn/tTMgC7dzj51kEtoAnQ6O5ZAbsVNW8iNcK3pol/Hc6T
         n29RozP+3gln2GtYmhcl8fdVFm7dKYQtduYkjNYeZVtlnxcp6QGAEN70Am/6fZPzSIsA
         VKu5DmMc4f43rSHcqPlviArHZHYJQQ5G5YwM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782832178; x=1783436978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AveCtf1R8zYDdvUZGMGx9qvpwpByoCyBF2y0phdxoE=;
        b=rC/iB7IIpVRlgyGdWrZKCb7YU/utZLTUVuEOAEhU/k/fWfBi/5UYWwBc+QnOu24yCF
         DH4ZDPaqNXBihMalswLVLVO31/iNAWlVwN43ZPc079nyE2SnhvkkJ9weHhn8tpxya15/
         qFXVN1nc8CEmDkONzoJ3HO9ua8tjCus8aclbwgMtZUqyQcipxgW3Snr/g/8eB2HzhtgS
         BxApn2qzHnTojLDKtKCl4CVTBKZpANOrju2AHONW0U30roRAGQR9oBiQ1/5EiyGZfCMO
         s/3pdPraBc8F3Z2Smjcs+ADTITIDZlbhlsB7pqt4CeyVOCLClpaZmTFs+5qaZgsmOKpr
         xxow==
X-Gm-Message-State: AOJu0YzlM2UaeVXye+4yGLD92d6por85nAGD/1S+u++d7uuzzeGGNrkL
	Bq3QpoP2ma/v7f2W8JfpA/jEZwIa6rAXbExpDoHrmG5v1Lu1WgHJJh0+aUtsn6hljd8AGehQ8Sf
	IDsw=
X-Gm-Gg: AfdE7cnAYfNBdz2IJp3/DHkvbDTliXQqJ+pauM8LvTLGQa6uyoNpx21YpfRYnzkObHY
	uF05oLNzC2I2VxDV64Wnkh0kl83JR0tey35WaJdXJlHZbjbpPdtJrAf7XzllKKdnyxqp9UOoy/d
	XsNqDnYKUh+sg3eqESdBDE8SmjPTigxKM3xPE6tx96CPuLUZilFUM108vDdAEB+ou3a40LWs9cI
	8JROQ3zCJL4VxZo6GLlqul+QRIZVQUz9ikrOF2ap/I020DURSztp+leBUFkYeTam7P773WR2yZl
	yGBMvQCBGJgDsxtz6Tr+2nfxiqp8kakjnqI0ZEhkApazez7pkH+3xN9xb1JrDMII17iPfdRLcfG
	WWRGgcbKhB4qR/6lao67NpOwUggixt+/3JJDG7SxLAPrsP2JTZX1cG4kUqQX6OmPF91jrOpctDg
	m5ud9pww==
X-Received: by 2002:a05:620a:2982:b0:927:efb0:3ad1 with SMTP id af79cd13be357-92e69792d18mr275626485a.26.1782832176080;
        Tue, 30 Jun 2026 08:09:36 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e622e8d9fsm261330385a.22.2026.06.30.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:09:35 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net] net/sched: sch_teql: move rcu_read_lock()/spin_lock() from _bh variants
Date: Tue, 30 Jun 2026 11:09:22 -0400
Message-Id: <20260630150922.238714-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a followup based on sashiko comments [1] on commit e5b811fe7931
("net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF")

Use plain rcu_read_lock()/spin_lock() in teql_master_xmit() instead of the
_bh variants, since ndo_start_xmit is already invoked with BH disabled
by the core stack and the _bh primitives can warn in_hardirq() when xmit
is reached through netpoll or a softirq xmit path with hard IRQs disabled.

Moves rcu_read_lock() after restart: label + adds rcu_read_unlock() before
goto restart (fixes the unbounded RCU hold across retries)

[1] https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.com

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 24ba31f8c828..5c42a29a981c 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -311,14 +311,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
-	rcu_read_lock_bh();
-
-	start = rcu_dereference_bh(master->slaves);
-
 restart:
 	nores = 0;
 	busy = 0;
 
+	rcu_read_lock();
+
+	start = rcu_dereference(master->slaves);
+
 	q = start;
 	if (!q)
 		goto drop;
@@ -345,17 +345,17 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
 					__netif_tx_unlock(slave_txq);
-					spin_lock_bh(&master->slaves_lock);
+					spin_lock(&master->slaves_lock);
 					if (rcu_dereference_protected(master->slaves,
 								      lockdep_is_held(&master->slaves_lock)) == q)
 						rcu_assign_pointer(master->slaves,
 								   rcu_dereference_protected(NEXT_SLAVE(q),
 											     lockdep_is_held(&master->slaves_lock)));
-					spin_unlock_bh(&master->slaves_lock);
+					spin_unlock(&master->slaves_lock);
 					netif_wake_queue(dev);
 					master->tx_packets++;
 					master->tx_bytes += length;
-					rcu_read_unlock_bh();
+					rcu_read_unlock();
 					return NETDEV_TX_OK;
 				}
 				__netif_tx_unlock(slave_txq);
@@ -364,37 +364,38 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				busy = 1;
 			break;
 		case 1:
-			spin_lock_bh(&master->slaves_lock);
+			spin_lock(&master->slaves_lock);
 			if (rcu_dereference_protected(master->slaves,
 						      lockdep_is_held(&master->slaves_lock)) == q)
 				rcu_assign_pointer(master->slaves,
 						   rcu_dereference_protected(NEXT_SLAVE(q),
 									     lockdep_is_held(&master->slaves_lock)));
-			spin_unlock_bh(&master->slaves_lock);
-			rcu_read_unlock_bh();
+			spin_unlock(&master->slaves_lock);
+			rcu_read_unlock();
 			return NETDEV_TX_OK;
 		default:
 			nores = 1;
 			break;
 		}
 		__skb_pull(skb, skb_network_offset(skb));
-	} while ((q = rcu_dereference_bh(NEXT_SLAVE(q))) != start);
+	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
 
 	if (nores && skb_res == NULL) {
 		skb_res = skb;
+		rcu_read_unlock();
 		goto restart;
 	}
 
 	if (busy) {
 		netif_stop_queue(dev);
-		rcu_read_unlock_bh();
+		rcu_read_unlock();
 		return NETDEV_TX_BUSY;
 	}
 	master->tx_errors++;
 
 drop:
 	master->tx_dropped++;
-	rcu_read_unlock_bh();
+	rcu_read_unlock();
 	dev_kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
-- 
2.34.1

