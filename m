Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE303502A7
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790491523; cv=none; b=NbGcATdQV2q2XQKrHIsoJ224VeKtCfHkZHZNjLDBOseWveypshv/gxOzEqWvETuKoB2IE6YPIyFAg+dIWQPYCkJRvIhnNpFHxux552JuS34vXG4HBUFcCRzTkGocjKlpa9m/4rvUnH/+tDa0qu/ZSSk6U4hw0SJjd5wxcKfXb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790491523; c=relaxed/simple;
	bh=IusPeKAJrDZ46U2jETL99MVTQOKyVY1wsj+XwyjWn8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nr1VDe/pgK774oy0nd4kUSqLKNHyjx7TQ8zBcQeJbFXPimeU7mb5nth+uZLdYrD3fAEDuBj0z2Ujw++oYq0cy3yBgLuS4DcGcGCqWoFRZfOnhPovK7557fUiVTsCmsvYi+hwDGG/TbDbMS99cPRa7mvvnJMKLl3eRWbedd9BIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjpfP9VC; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjpfP9VC"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-141a5d476abso84669c88.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790491520; x=1791096320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HzB52n2hHJSMUa77CwTdg5ONrHIeWBM2nfC/CVriigE=;
        b=FjpfP9VCFTI7RhrRfiv+teakNo0FXor34e2FnXr5S92AP17IkceCIpO0uBmFXZwY05
         kbRiCxxAkWo1gDQK/l+HqGnnYenwbRSjcC5yP1+oJF6wTkp/t09CuUIxd0rJK/vNsRuu
         KoF+85jlxO6yInuPL4GfVGevAYENNGdVC2LNLNEAY+2siIwg7CdrObMvE3ZFcc++mUYw
         G8MQ+ogFmbyldUhRzEK5lRb/Dcbu+OW6yNY9Eu8HFlgYhEp6cyKiMZ0fgivHLS/gRk1w
         UK5MhChqSfWEgbHTUFTvx37TCTlg0Wm89BiZ2sWwsAnmDRJGQkE5lC0qGrKGRadw3okw
         mJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790491520; x=1791096320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HzB52n2hHJSMUa77CwTdg5ONrHIeWBM2nfC/CVriigE=;
        b=0Awr2bs9rTHkxjy+3mY94sKadLtWZK9X84ls9hjfPKnTnL91C30ADt+wzfGlTNqZMC
         0nBysys2YN2xo+tSInjMq6xEcqd/TUYlaLgctsV/9f3AWtagbSLMIeivZVEAE5x8aHyB
         ZPcH73EPFwa3yiiD5gLMgV11B1qiOPhdwjNbPA3aFjU1ytX0RjXN2vvKSKAE7UJqMoVs
         MWGe0jHJ3vvdXuO4iKA/AJXVokWuZqY8y8nkJ33kjI/WU/qrHhj7lQX+jlMUO40Xba2E
         tC1A1l0uqPfhRC05Tf4o/rByFdMnrx2q3yB95XsfqElTspRLpGIIxUXG1Mj/Q5ZtfVfy
         ajDQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8RStp4IcjCsVs0U4slLBY1B3FWa+y7h0zddIxJQNMOqhqpXyVlJV69U9Gu8/DWaKmAIv1VcY=@vger.kernel.org
X-Gm-Message-State: AFuF++nqWbKsBfljn+bUl+70dUdfJqBClj2U4C2Gn27sWW4o4y8ExQRG
	qQowhMvpBZ//MdTdz7FdEI2HGiTqg5tMGtQplZqRtJTiPVjqGZjDRPqj
X-Gm-Gg: AYBFou17UWAA/HvLmfBGo5IAeKEbm2gwP3F/qqIQ6udRIVqIRmXvT3BfK7mtaJwq5ol
	4NlIDuGSi+Zh4hTL/plkZU1712bcC1qNZHSSFwG1U+dyMxRJdlNltfpryZUSWBTh15DdU26qAe7
	fELjRJtmGtd6UM4vRRkp0tgs/V23pjzpB64Nx1Y5Pefl5OaTpPAfyC1814AZVcRt7ppiX8xvlf3
	Onm6PN82cp/WjRzgGa4rv2AU3MJPJWf35yb8jplwOY5wUNhA4gj6cwGiuelHOSlaENgSOvdtGHJ
	7vnAEixtPosUsHMGZVVFtqxR03qsUz5BQXHFqcywhn9WmaWI9AZvxWfqBSlIzOX/U29Zd55lbhC
	UTY/46Xnz/7tpE9+y2UbV/FMBX/ulRSFSEnlYA3jHObhz3nk9s7RpURmPJL6+7/x/EFvRrUPU2M
	feKLue4A05do5HTJ3rvjMfda5W20kivQ7AjGKlLlP8LwFjr4DFcWF4RudL6WRGtnohq1+bUSHEJ
	Hy3dUUw8ErtSQePiEzyMqZP07b/kt1XxHha9kkhmg2deJMVlqGgyS3cv+YanWxMfZN27lY=
X-Received: by 2002:a05:701b:451c:10b0:143:8212:a43 with SMTP id a92af1059eb24-146cf7ee027mr8050559c88.1.1790491519432;
        Sat, 26 Sep 2026 23:45:19 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145adcc5b00sm16702763c88.15.2026.09.26.23.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 23:45:18 -0700 (PDT)
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
Subject: [PATCH net] rxrpc: Prevent reusing service connections marked for reaping
Date: Sun, 27 Sep 2026 14:44:34 +0800
Message-ID: <20260927064434.3692113-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The service connection reaper changes conn->active from 0 to -1 before
unpublishing an idle connection. The I/O thread can have already found
that connection and acquired an input reference. If it then allocates a
new call, rxrpc_alloc_incoming_call() unconditionally increments
conn->active, changing -1 back to 0. This violates the reaper's final
assertion and can panic the kernel:

  I/O thread                           Reaper
  Look up conn and take input ref
                                       Set active from 0 to -1
  Allocate an incoming call
    Increment active from -1 to 0
                                       Assert active == -1

The kernel reported:

  kernel BUG at net/rxrpc/conn_object.c:465!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Workqueue: krxrpcd rxrpc_service_connection_reaper
  RIP: 0010:rxrpc_service_connection_reaper+0x768/0xbc0
  Call Trace:
   process_one_work+0x5f2/0xf20
   worker_thread+0x46e/0xda0
   kthread+0x2b2/0x390
   ret_from_fork+0x36e/0x5a0

Use atomic_inc_unless_negative() before taking the call's connection
reference. If reaping won the race, leave the activity count untouched
and return through the existing BUSY rejection path without consuming a
preallocated call. The caller's input reference keeps the connection
live during this check. If call allocation wins, the positive activity
count prevents the reaper from claiming the connection.

Fixes: 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/rxrpc/call_accept.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 47824120f1da..87bc3af2208b 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -299,8 +299,9 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
 		rxrpc_see_connection(conn, rxrpc_conn_see_new_service_conn);
 		rxrpc_new_incoming_connection(rx, conn, sec, skb);
 	} else {
+		if (!atomic_inc_unless_negative(&conn->active))
+			return NULL;
 		rxrpc_get_connection(conn, rxrpc_conn_get_service_conn);
-		atomic_inc(&conn->active);
 	}
 
 	/* And now we can allocate and set up a new call */
-- 
2.43.0

