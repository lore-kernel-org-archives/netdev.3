Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B340863A
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409570; cv=none; b=ji1M4T0pBOq8LbzMCh7/76M3TMYulPxLLRuNgD7EF3iTvJz0LZvu/oqFgCiHCasFeu1NLjXdR8PrU3wpDrsKb8QMLosaBUEkOA517oBybPaCsN/0G8pkrKB4R61JIHIcsEe/YBd0WUt7EQlilUju0MJsIb3XD3Xt/aLFZmaB8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409570; c=relaxed/simple;
	bh=Cb1fLXFgbedj/YEAAoR11911QXQg0TtlncEsBz+Pim0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzSz92oCCurRCLJJ1EJrWA2jrhv8gXRsyoHE103V727tIqc5HZmZlQbJc3dIRPsR7tM9wEfTFliuBFUsKcyhtFdDOKb++s4QlSglA/JO9b5bUQTX7B3sUqa5/USxGXDVKrHU2VaEYL7IH7lqm/DkNUPONx3HUQpGnPl2GAJKRNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjioGBHO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjioGBHO"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ce7d2adef4so29725495ad.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 04:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785409568; x=1786014368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n2ed6co16JfSMJoBLM0RMYpPKipd3X7URaBIZ4848UU=;
        b=OjioGBHO+e8K6ThNJymmBkFJtMKt1mAAUtiKeYvGFYkc02NGt0Yumpne7B++U7qvw6
         vI+kpzKUW0cDZNWcJ2DjGvGoSLp3AUPBNrhYo6H9zzUVqd0S7+4i7pNilOZle0oL157h
         0noTtx342NYrMx8pFz0ZiQSj8WbgdbHQf0emriOpQDnHbJ5cbY6Kfn3g4Hck6kDHJMkO
         NRv7zsDDMH0qZaxXE8yi7Yy5D7S3XC+4067e+qZv4oGdBH3llGOi324W31UjQlrygBJK
         sbeS7ppUkgvHIZfjk6pOt8v24Pemh0fJspKk06nUOxPU60+iDTW58m5MpK8JT0BrbmXM
         lx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785409568; x=1786014368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n2ed6co16JfSMJoBLM0RMYpPKipd3X7URaBIZ4848UU=;
        b=Fskj47ZGX6qeRz/uDSPEhS+rBDV0zMKcO19zQPf+ZCpAD7qC4jWIGWws2/wn8icOPP
         Ue7i9+/4fdWxVmAsLo3CjngD0b12VZ4wZFRvoWEfXh/ZMt1tlbUIw8pJTAcUQVLYhyo9
         pK/48B/vM/M3dTGdVWNRUg9xUon/eQvr6qSxEzkkXp4nZtqaEFsgS26urz1jv6ny9R4U
         hi2UOFSnPyfjBRtG2l8PC/h+futRJMIBDJ4PYrXypJl4uvMB/2Alozcl48gbqS7TsvZs
         i40mlETmD5hMC3yXmvS0zapvhzLToMam3sOj0vJP1M2ievSdp+2VkP2zyK2hlAS/+m1t
         GysA==
X-Gm-Message-State: AOJu0Yz5H0Ism8jkdn9YKMoDiS6nQcY7ULL+ZUtZJTZ8xcNKJhDO1fjl
	THmE1Pv6wo/p2IKJCSKqxY2irEDrGB5HCRK12WXzMAkrpnLYoBkXhiEO00lmV1yppIWJwkeJ
X-Gm-Gg: AR+sD12tbEtCe0i2L9jKpVvcDmgmzTdmkvdhUBAt/5dxNNvk+CBaGeAE+sRmPkciAi6
	6DkmkDzUAewvN1thBk9pAjXIWA6X23NSlvu3u2i6WNeaSs69A2OpynOzVrSB1eisGU+r7m2eH4f
	S/40YKarwG6GXLqqF1ZWyIF6Qp5AQg3EtBfqb5A0sJBMOgos1PdkpNc9xTvDyIGJ0alZ/FUuqbE
	2zPrHYYCXpy4FnUqB3/UfuO0tQhvEvP1/kr0G16vJc+5Wx4QdgNv7yCRpCB6PqLEPjbBKIOEiGZ
	OTxCCvNcnz0oxdbPrOqYx8R5iZGw+5GEeXVpPfhQ9Y/4O9lYHrsy77MOezn0o3VRs5GBRyCYut5
	UGnlWDUwVOIfAQfyY1FYQz7mFeCKD0NtZMQeNCeRz46xky+W7K0IBsFQlBmj6TllVdZwwWGHaOx
	4kwnyUekjjBUlP/CsFDKs4IhYBNa/f64PKGPBdw+wOY958S1JOhQK7TSOmZVMV2UuOJ9wSLSR2c
	/oFg/ryXodKBX0QpoLWiSkgevc=
X-Received: by 2002:a17:902:f54e:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d035bcb60amr21647465ad.13.1785409567460;
        Thu, 30 Jul 2026 04:06:07 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc821asm25192555ad.41.2026.07.30.04.06.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 04:06:07 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sctp: re-point the GSO head_skb socket on association migration
Date: Thu, 30 Jul 2026 19:05:22 +0800
Message-ID: <20260730110554.41177-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

sctp_ulpevent_set_owner() stashes the receiving socket on the GSO "cover
letter" skb as a bare pointer (net/sctp/ulpevent.c:90):

	if (chunk && chunk->head_skb && !chunk->head_skb->sk)
		chunk->head_skb->sk = asoc->base.sk;

That store takes no reference and installs no destructor, unlike the
sctp_skb_set_owner_r() applied to the event skb just above it.

When an association is moved to another socket -- SCTP_SOCKOPT_PEELOFF, or
accept() on a TCP-style socket -- sctp_sock_migrate() re-owns the queued
skbs with sctp_skb_set_owner_r_frag().  That walks the receive, lobby and
reassembly queues, but chunk->head_skb is on none of them: it is reachable
only through event->chunk->head_skb.  Its ->sk therefore keeps pointing at
the original socket.  Once that socket is closed and freed, the dangling
pointer is dereferenced on the very next receive, in sctp_recvmsg()
(net/sctp/socket.c:2155):

	sp->pf->skb_msgname(head_skb, msg->msg_name, &msg->msg_namelen);

which for IPv6 reads sctp_sk(skb->sk)->v4mapped (net/sctp/ipv6.c:894).

Re-point the cover-letter skb during migration as well.  The event lives in
skb->cb of the event skb only, so this cannot be folded into
sctp_skb_set_owner_r_frag(), which also recurses over fragment skbs; add a
small wrapper and use it at the three migration call sites.

  BUG: KASAN: slab-use-after-free in sctp_inet6_skb_msgname+0x633/0xb30
  Read of size 2 at addr ff1100010aafc8e0 by task gso_uaf/6387
  CPU: 1 UID: 1000 PID: 6387 Comm: gso_uaf
   sctp_inet6_skb_msgname+0x633/0xb30
   sctp_recvmsg+0x481/0xa00
   sock_recvmsg+0x121/0x170
  Freed by task 0:
   __sk_destruct+0x39d/0x4c0
   sctp_endpoint_destroy_rcu+0x8b/0xc0
  The buggy address belongs to the object at ff1100010aafc380
   which belongs to the cache SCTPv6 of size 1560

Fixes: 90017accff61 ("sctp: Add GSO support")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
 net/sctp/socket.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..ade413bbec56 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9522,6 +9522,27 @@ static void sctp_skb_set_owner_r_frag(struct sk_buff *skb, struct sock *sk)
 	sctp_skb_set_owner_r(skb, sk);
 }
 
+/* Re-own a queued event's skbs, including the GSO "cover letter" skb.
+ *
+ * sctp_ulpevent_set_owner() stashes the socket on chunk->head_skb as a bare
+ * pointer, with no reference and no destructor.  That skb is not on any of the
+ * queues walked during a migration, so it has to be re-pointed explicitly.
+ *
+ * Only the event skb itself carries a struct sctp_ulpevent in ->cb, so this
+ * must not be folded into the recursive helper above, which also visits
+ * fragment skbs.
+ */
+static void sctp_skb_set_owner_r_event(struct sk_buff *skb, struct sock *sk)
+{
+	struct sctp_ulpevent *event = sctp_skb2event(skb);
+
+	sctp_skb_set_owner_r_frag(skb, sk);
+
+	if (event->chunk && event->chunk->head_skb &&
+	    event->chunk->head_skb != skb)
+		event->chunk->head_skb->sk = sk;
+}
+
 /* Populate the fields of the newsk from the oldsk and migrate the assoc
  * and its messages to the newsk.
  */
@@ -9571,7 +9592,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 		if (event->asoc == assoc) {
 			__skb_unlink(skb, &oldsk->sk_receive_queue);
 			__skb_queue_tail(&newsk->sk_receive_queue, skb);
-			sctp_skb_set_owner_r_frag(skb, newsk);
+			sctp_skb_set_owner_r_event(skb, newsk);
 		}
 	}
 
@@ -9600,7 +9621,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 			if (event->asoc == assoc) {
 				__skb_unlink(skb, &oldsp->pd_lobby);
 				__skb_queue_tail(queue, skb);
-				sctp_skb_set_owner_r_frag(skb, newsk);
+				sctp_skb_set_owner_r_event(skb, newsk);
 			}
 		}
 
@@ -9612,7 +9633,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 
 	}
 
-	sctp_for_each_rx_skb(assoc, newsk, sctp_skb_set_owner_r_frag);
+	sctp_for_each_rx_skb(assoc, newsk, sctp_skb_set_owner_r_event);
 
 	/* Set the type of socket to indicate that it is peeled off from the
 	 * original UDP-style socket or created with the accept() call on a
-- 
2.43.7
