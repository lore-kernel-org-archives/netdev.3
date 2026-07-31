Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D664439916
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510881; cv=none; b=lVy6YHLJKfcV7LOoAGthCHXfFXjjsorwYNH7N9NglRmI+3AEFOy/iYcV4Vh7FkG9DOCXMdFHq2N7nAWDmAhLHhy7qQ+hIda2jHgzoy1unIN1RIRKpqK+BoS3oDAJh68HVml/AaW0koCxEPEuOIsNbksjlUgeYlCd7b/jBUkLaUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510881; c=relaxed/simple;
	bh=PxfbufHKEdiZJDcysFDCB9tgJLN7rUY8Stt5mTjWs3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9wQx2MU3jTwv77zRlFzaFwRZXRr1aPmcZEVdNIcjDaP+gpjt/Ece6T1fPKOSUOu8F+gMvmFqAr8gO1OdACYrV87GyCA9Z47NqlgOgQKcJwrAllsAaIRSaSndFkFRlx3WIfYcqFfc+0r50bYZU1aCfXjGN+GwpraVDe+qs9SmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEHxt6oM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEHxt6oM"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38f57e312ecso53288a91.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785510874; x=1786115674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zhZaO4ozJik4n9gTRf7CxEJqzo3QkPue6+aio//Q6Qg=;
        b=oEHxt6oM9fGDbISgZj9YrQRVrTb+39qgGf1PMCfEr274jZHc4rhpaBmNSkPo2zgUtU
         UMWsHZO7P4xsK19GO4Q0P+Na/HXP0kEwDhX/FMabY8kalbdHSN/YjoP6H6QEVID1impt
         U10gO3LXaOsfluPFu+5I7/kJcZsbDamLRsAbVhTYXcWR1NJdB5czCJ8yX8I1/2FFZLPs
         rrud30OhtJHVYDmHtSVElvDx2u2JppV0ud01ZdprUJ1uzUf6AZhwOG10TkHLcDXn8Qlz
         AoQ9Map+tHtx6X8aJhqBsTCZftWWLT/rM7MlqkJT3TtjyhlJpsfAWAAF+kXBjkMkdlXn
         r6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510874; x=1786115674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhZaO4ozJik4n9gTRf7CxEJqzo3QkPue6+aio//Q6Qg=;
        b=q13u3113YBQPu1X4REP6Zv2V7xI71x1q6By9fegsP/W3Whcgv37fCvCvBx7aDt9cZn
         RkAmtKSaps0gCNrrhSQekg974u1Q/A2MGMT1w2YsAq7tvj1B55Nvz2y2NWljsQuYY1oM
         pz/UkW9FXekhYTuzrJqjH5JBVpGVKsuHretUHhWaEHqtWL0Z61cVUioUvAVPNQqI0UQ6
         yKBaJD1OYyizN/XPkIi01I0N3bPuKpaznRg240/zfrVLK9J0MSL8y4wPX6yxR5e8+TCe
         0umTnRlO23j/n8AzNrUkqUSqu0+EACilQcoMuWXbu9GvylILokavs4csYMaZJcCHPc1b
         WRRw==
X-Forwarded-Encrypted: i=1; AHgh+RpU3W69pt4TmJAyu8rAsYlLDGjZS7fZgA7s9lq7UomcqvT2Dbu62tDh3jbUT4OwFVnaIXvOPMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27sN4kWjb/A7UaHDXagsI7pirMklqFHPXeEdYB/KSBKopaiZC
	1GV2Dde0mfP9gsq4ub7MDnRUlXLg4vnkiCVqPQpuUo76SVaNnL0RMFIZ
X-Gm-Gg: AR+sD12yf3tPgxdRzVGe9FQEGHYKaTl0kJi49SQPt7hEOvucKM8pCEphzbtGxG4iN/9
	yDb4fbp86EkgXtjuBtYGGQhGszk3lQtL7FvQl/mQrEck5ShWufUWD8i5EywuzaG9UF7q677UgJF
	rJdl6FahlsXHsYki/+VFTZefguRIa4hmEfucXsY30OU7W+JfRK3i7tjEwz2APDS+8dH6sje+Nov
	C0G16YMV2pOC28tUZTB+GHUmbTlo9UNMevBn4O/e9zO1OeFtxp6WwD6bzyHT3hKaO9a3G6nudGx
	VNNhqzVIpvL4oPb382S3rJG6YP/wV/wUGnHEYiBhkTC99sIC4i1zGpnlNxQxOhcStty3ofLeE1c
	LEGSinU05lwFgNCFHvzkF9RXFhfzJrXq41Y2W01s9YHIch1teoWwualYPx237Ks6nU5h5vt/jRe
	KKSxHuBLiOvo2JHSGBISFr2YHaHWqrS5yn+iMsQHAoTYFgeFatWyTAKNFRrdeTfyxe88B7YeRtt
	9b5MRPNuScl2KQQC7mx1UewftPSjAJGS8J5yvU1Ym08IjSC4aPSTD4=
X-Received: by 2002:a17:90b:562e:b0:36d:b30b:14ed with SMTP id 98e67ed59e1d1-38fbc4ad251mr377334a91.2.1785510873947;
        Fri, 31 Jul 2026 08:14:33 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e107sm7985431eec.27.2026.07.31.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:14:33 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] rxrpc: Prevent poking connections after final put
Date: Fri, 31 Jul 2026 23:14:26 +0800
Message-ID: <20260731151426.3194039-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_poke_conn() unconditionally gets a reference before adding a
connection to conn_attend_q.  This is unsafe for the connection timer
because timer deletion cannot stop a callback that has already started.

The following interleaving can occur:

  I/O thread                         Timer softirq
  rxrpc_put_connection()
    refcount reaches zero
                                     rxrpc_connection_timer()
                                       rxrpc_poke_conn()
                                         rxrpc_get_connection()
                                           increment from zero
                                         list_add_tail()
    timer_delete()
    rxrpc_clean_up_connection()
      timer_delete_sync()
      call_rcu()

The refcount increment saturates instead of resurrecting the connection,
so cleanup continues after the timer callback exits.  The RCU callback can
then free the connection while attend_link remains queued, and the I/O
thread later accesses the stale queue entry.

The kernel reported:

  refcount_t: addition on 0; use-after-free.
  WARNING: lib/refcount.c:25 at refcount_warn_saturate+0xc0/0xe0
  Call Trace:
   <IRQ>
   rxrpc_get_connection+0x185/0x1d0
   rxrpc_poke_conn+0x12e/0x2b0
   call_timer_fn+0x2b/0x220
   __run_timers+0x561/0x8d0
   run_timer_softirq+0x144/0x250
   handle_softirqs+0x18d/0x5b0
   </IRQ>
   <TASK>
   rxrpc_put_connection+0x2fe/0x3f0
   rxrpc_discard_expired_client_conns+0x396/0x670
   rxrpc_io_thread+0xbfc/0x1640
   </TASK>

Use rxrpc_get_connection_maybe() while holding the attend queue lock and
only enqueue the connection if a live reference was acquired.  The normal
path for a live connection is unchanged.

Fixes: 4241a702e0d0 ("rxrpc: Fix the rxrpc_connection attend queue handling")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/rxrpc/conn_object.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0ece717db0f8..3f4516115d37 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -33,10 +33,8 @@ void rxrpc_poke_conn(struct rxrpc_connection *conn, enum rxrpc_conn_trace why)
 
 	spin_lock_irq(&local->lock);
 	busy = !list_empty(&conn->attend_link);
-	if (!busy) {
-		rxrpc_get_connection(conn, why);
+	if (!busy && rxrpc_get_connection_maybe(conn, why))
 		list_add_tail(&conn->attend_link, &local->conn_attend_q);
-	}
 	spin_unlock_irq(&local->lock);
 	rxrpc_wake_up_io_thread(local);
 }
-- 
2.43.0

