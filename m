Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFC3655E0
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583751; cv=none; b=eefKeze1oHbkMw/WIHWFmJ98s6AxLGJxIWh+q25TO0mCwFzLojv8MrTDwrjb3LIRq4hbGcu72/GtVkA8sTQSBtlYISCyPgT1XJBlfp5bGhVU62EHn+YyAS8i/teSkpPbXU2JdF+iAEK5rwy2lUx1nk05YCQQu2FiIKSwKzFncUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583751; c=relaxed/simple;
	bh=y/5A4oExzkDVdOs3ToZMMCiwL9Kh46PsSmy8ZWZE5AM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvWA8cQKIuKKYawxWR3vyljFtAJ7dnFDr9/eCfHFRTD6JQMO2WP6Ln9jRH0DckbtnykcGmFPJeW9MYI75C2cfUc1J/GHNdlCCIGfj1AphBteCRCxfDA0P2b7sIx+/Kb/uIYv6OwJrJN3yIChdeqn4/HOmb0lV7ZBkoPcUWWNZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHQs/iDx; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHQs/iDx"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-462c8de7446so413915fac.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583747; x=1788188547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4WYYuHUTr1TvsvQZbyAeodfCziWwiccRptU66x2uPT0=;
        b=CHQs/iDxyP+UJKchN1ZXMXKlKyYyzGTCdt4rQq0iTlBuHq8wohUlbvA5UQ2s/YLwM9
         dCSbNf+k+8tF1kj7IkdSQOEIfC503BGHm5gSpgt197oiXcYM/ZrFXKqdsVuPC+uBcUl3
         f+Z/y5f5Qx7fK3nyitATSQiMLY0o4qfwHuKkCswg6E/90QSP/Yn8DJWoGYyH7ANQJJNR
         KxItb/ymEP8BX+MphM+6i6yPJPrUdmwBpKYSSXM3WoQvCvRFMqNPXQrKKmv8f+1w9fKv
         /28GXA7KvLSrSC5OHoIla3lJ++DvhMwnqrSbk2iqN2fuj1HnmyVd9AQDOS3i64QCVOnj
         KKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583747; x=1788188547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4WYYuHUTr1TvsvQZbyAeodfCziWwiccRptU66x2uPT0=;
        b=nmDEiDxJU5eDRyAlj7IrmEsbEQyxDkDRIMzreyMdpeoDOnNVLB+QROBtfnlc0DZK/q
         w+TjZmxJ34uZ6xPVV+79PwhnnDesESj1VWa7DVoP16s+E2g+5xXM5RGP9rQeJt4uGFLx
         c2o/+MiNvKfOcvq0MJlrDXfiCoobayUQTbg6EjWk8s0IEH0y1/3eaizsMmiQPB75YHQK
         +/RuakFBMw0L/y7AKgB/r0BA2Am/3DsPDwNlEQ5+Qq/VJVKuV3X8BsMze7WK0UztrIM1
         p6AxmXkShQJasSup1xmtB7MX6VlGV5j8kolD2tByoAxbEqj1I58BjHGynVZLXJO/J+Z4
         OkiA==
X-Forwarded-Encrypted: i=1; AHgh+RoOKJLJBCVLXi3IyNdecwriQzAIzTJ1o0ysvhxE1Shn0zL998wtzjXCvXG4c8aNkyF3A25ieLk=@vger.kernel.org
X-Gm-Message-State: AFuF++nYdEDXSGsfZfordk6CUInaPj4aK6AqNFKc6W6Byrl/BCfSTaUB
	bpZUPdBZORnkaOm2LJ2boEgkNZy+QD86u4keu5eSUBiCHpQv0sFLY8Vr
X-Gm-Gg: AR+sD136YA2RbgflrVOa/gLJt7jUs3KT1s//1745v0X1y7Xx2ANMcRujdVrMZKvvSfY
	00NGRKrGAz+zAbiqleQXO/cYaf8ZTN2Q4FE/ejy9eq9zEMxlYXMyhY9r2t+ztsBPJlUO2nXaeWq
	CxBQTfR0Le8cdhkDW/8baPMMkN5AkM7iHbLCDDhQ6GHM9++InEMcwCVigELmG+yag61JLWQOP+4
	GMHaUhSoeXHuGxC7eFOavlyQBSSeZnyKuE8RMgUFiXT+25mKZ5aEsEKGAsIMJ1Py1nfIYacjRCO
	31L1yb+D/2OGqffWjAEfpSAdC63AI5zV0EADykvApUt3Mv7F2WZ41CjqhoibSqUhf9SAF0/jH3J
	WJVL9OCUFcUXg7ftWsL+cmKenBG079CqwVKIWA+VXVGUFlI86z7s48QUylSNsa9fuzrDS07fRsH
	9f8MZG5cFLaDWwaodJvu8DE3ONnre9gCKnJ+wRLJ7melDzFVWf/sA4nLOOUexKdw8F5S4Y70i6j
	+A9n27vBxc1OROlJZiTHM6KR1RIjL1V017/k5LnCNhVa9km1cLH57M=
X-Received: by 2002:a05:6820:400b:b0:6aa:c26c:e4dc with SMTP id 006d021491bc7-6b15939d5d7mr12394392eaf.2.1787583747230;
        Mon, 24 Aug 2026 08:02:27 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186173199sm24978669c88.9.2026.08.24.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:02:26 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net] rxrpc: Take write lock when publishing the initial RxGK key
Date: Mon, 24 Aug 2026 23:02:20 +0800
Message-ID: <20260824150220.216067-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxgk_rekey() updates the transport-key ring under security_use_lock,
and rxgk_get_key() takes a reference under the corresponding read
lock.  The initial publication in rxgk_init_connection_security()
writes conn->rxgk.enctype and conn->rxgk.keys[] without the write
lock.

On a client connection, a second sendmsg can observe
RXRPC_CONN_CLIENT through a lockless load of conn->state, skip
rxrpc_init_client_conn_security(), and call rxgk_get_key() without
ever acquiring security_lock.  Because the initializer never took
the write lock, the reader's read lock provides neither exclusion
nor a matching acquire-release pair.

Concurrent RxGK key consumers were observed in a two-sender
workload.  KCSAN reported:

  BUG: KCSAN: data-race in rxgk_get_key / rxgk_secure_packet

  write to 0xffff8aef4023c318 of 8 bytes by task 1968 on cpu 0:
   rxgk_secure_packet+0x46c/0x820
   rxrpc_send_data+0x562/0x1a20
   rxrpc_do_sendmsg+0x976/0xa80
   rxrpc_sendmsg+0x20f/0x2a0

  read to 0xffff8aef4023c318 of 8 bytes by task 1969 on cpu 1:
   rxgk_get_key+0x209/0x5e0
   rxgk_alloc_txbuf+0xa4/0x2a0
   rxrpc_send_data+0x8e2/0x1a20
   rxrpc_do_sendmsg+0x976/0xa80
   rxrpc_sendmsg+0x20f/0x2a0

  value changed: 0x7fffffffffffffff -> 0x7fffffffffffffee

That report is on the key context's byte counter rather than the
initial publication, but it shows that lookup and secured transmit
already overlap on the same connection.

Take security_use_lock for writing while publishing the initial
enctype and transport key, matching the locking used when rekeying.

Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/rxrpc/rxgk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 77a67ace1d24..b49221f57f67 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -251,8 +251,10 @@ static int rxgk_init_connection_security(struct rxrpc_connection *conn,
 					 GFP_NOFS);
 	if (IS_ERR(gk))
 		return PTR_ERR(gk);
+	write_lock(&conn->security_use_lock);
 	conn->rxgk.enctype = gk->krb5->etype;
 	conn->rxgk.keys[gk->key_number & 3] = gk;
+	write_unlock(&conn->security_use_lock);
 
 	switch (conn->security_level) {
 	case RXRPC_SECURITY_PLAIN:
-- 
2.43.0

