Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4E455623
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112092; cv=none; b=R+ujZMU6gZT7kZMXkaYKt5ofLXQcdbJ6KmB7gY4ruQuDhLlMW38uuI1W58jRjufn0XBTi8fVRtgeCWx0pr+KGCdZnvj412HX+3YQMrXOsbrCDHIDJMo7hhwzEZNca8mE6VVhFmj9RKmtHcpNb9VU3/CEy92UVmwKhUpRhTVycAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112092; c=relaxed/simple;
	bh=ofD9vuZ8WriYaz45r03nVr4VI+oGJALE7F2gieVLqec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pxzd7/HAeqVat/d8V+1PBGAQleZbJtjkn3A3XN+y0w+ZYwB9n5SBF/eZwNdd54xvNP/ppqGYVZAIxg3xZ9tUVwP57TtSc3zahiKNIr57xFKBumQ+v5CHuGfmM3kS2oBIR5gB5H7jjmPoyORtm9tTHeq5eHW9cRU9bqzscxCoQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkQ1Y2fU; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkQ1Y2fU"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so461281a91.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789112088; x=1789716888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W6wVmYC8X8kmr5SDuvDPNWubkvtX+YkviT8aumfGWPQ=;
        b=ZkQ1Y2fUtTtCKjdE5Q1KGflwxOoNneCyA5lRZQdpPLxT0h1BMUgJE0pVHXCpMpK9CK
         JpnLF06X3+n9Io3ct4Ral5nV/3SDCPiXRL3GVKVqWXe16yP+15qH6BCybptEKGwTtVSK
         WcYZVZ3zfcIBUt/5ZQgkVZSgPvjLwVX0A9z2piDFkzTQZXJroRvHJE6wBrJYPhRREbrL
         UGCQD7Gf0hFX/AnwGaQzgtNW6GfC9HLjsO8xUk2V+LayJjsfNNV8uxAH5MnWwIODBcH/
         tDxfthSUVnyzI99AYnGd3N6IXfVZkMjFOyPq0wmUxq2A1M6pUxSOl0hTpHpH/wXbhzv2
         L/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789112088; x=1789716888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6wVmYC8X8kmr5SDuvDPNWubkvtX+YkviT8aumfGWPQ=;
        b=HTqlRl22MstXUg/+PyXTBmIFy3CfH3MZ5aVx4D/8sRRPOPjeN94/yNWww6LXznI4PC
         KlzUxXcJIFCyGw86RZv7B+mDAwgCYxV7nSlKbhKjSXKYRzIDcirb3R3KCXbPfmlfKey1
         df0H3kum3Gt+fC3ziaRsMCI8gYBEKbF9sA1r+LLb/Ij92gm5XaCQTojfaekzR6SYpH7l
         AFV05fLCRgKqPakMQPULIU6x+9p+Fpn6W2xvqrxcc90WvX2haz/s/CuNB27DvS+69CW/
         7s92F4D7ozITCEGuDsLJUeEQ96ziHXn3H34XP0sqgXb4FYHQgizsqIkJG6Wv/Ea8+RLk
         JgTw==
X-Gm-Message-State: AFuF++lqyVVb9WNlgULB9Aut/sa2BUmo/cyptdey2wvE2/Yqdm1SXIrH
	ZdMoImko/wc3BoZpS7Emf3VKSPvOaCpvSzVhM6ZEYE04tXyoW3ywC+PyO8q435VK
X-Gm-Gg: AYBFou0N+8LpfLFdcx3wg8SwT/rRvuLc+AP3jCr1yal4xisnUDftat+Bml5H5VHlhtq
	HowVAEWzvvAmntSalGkUpgacuDXTmbsPQgftLfc61kdDvSKwPOKfaakO1L9wx4E51Lg23hzc9sA
	BzzrP8+bzoGsL8G3ulfiC4gYzC02tnsJg2fKzfzgCsHd49sxSyQqeudnPM+s7i7xKq7LlobibJJ
	b4wyd2qWUplvb8/fdPL6Hr2whACOpfLtTqpl7OgmUIcE21acaCZ5wLf5SvT0mWEqPMnyLf+CHlF
	ibdJ0bZnpJSRmpYr67F/Jq8beHIXF0Gbury6qS6Yz78jrdnMQsUcSy4YsGWeT9yfjs3CJu/IP1Y
	383zC65NwT2Ljg0nxIJi46Gh8pXy0SCNqYk5qPeY4glAn3peXWsns4+DGgxTwMRUVVlxDcWCMX3
	mcpG8kt7z5aQpmy70V28YrVuHjdP/goOZ7KyHmvkHAzEw2Ve18yCiWpQ8AcAsmEyY4m4P3IdlC6
	hG6a/RqCDWZmnno6T57c2Vw6zay8FTlNKAeVA==
X-Received: by 2002:a17:90a:ec8c:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-39d9bf0af3fmr5274805a91.11.1789112087592;
        Fri, 11 Sep 2026 00:34:47 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9947b847sm3357684a91.7.2026.09.11.00.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 00:34:47 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: netdev@vger.kernel.org
Cc: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] rds: ib: use rds_conn_drop() on protocol version mismatch
Date: Fri, 11 Sep 2026 15:34:32 +0800
Message-ID: <20260911073436.3542080-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

rds_ib_cm_connect_complete() runs from the RDMA-CM event handler with
conn->c_cm_lock held.  When the peer negotiates a protocol version
older than RDS_PROTOCOL_COMPAT_VERSION, the handler calls
rds_conn_destroy(), which is only safe in the rmmod path: it
synchronously tears the connection down and flush_work()es the
shutdown work cp_down_w.

That shutdown work (rds_conn_shutdown()) needs cp_cm_lock, which is
the very lock the event handler still holds, so the flush never
completes: the two workers wait on each other and the RDS connection
workqueues stall for good.

All other RDMA-CM failure paths (REJECTED, CONNECT_ERROR,
DISCONNECTED) use rds_conn_drop(), which marks the connection
RDS_CONN_ERROR and schedules the shutdown work asynchronously.  Use
it here as well.

Fixes: f147dd9ecabf ("RDS/IB: Disallow connections less than RDS 3.1")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Reviewed-by: Allison Henderson <achender@kernel.org>
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
v1 -> v2:
- Point Fixes at f147dd9ecabf, which introduced the rds_conn_destroy()
  call in the version check, instead of the later refactor cdc306a5c9cd
  (Allison)
- Add Allison's Reviewed-by
- Link to v1: https://lore.kernel.org/netdev/20260908123356.1163970-1-henrymei@tencent.com/

 net/rds/ib_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index d46146887ba4..2909da8363f3 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -115,7 +115,7 @@ void rds_ib_cm_connect_complete(struct rds_connection *conn, struct rdma_cm_even
 				  &conn->c_laddr, &conn->c_faddr,
 				  RDS_PROTOCOL_MAJOR(conn->c_version),
 				  RDS_PROTOCOL_MINOR(conn->c_version));
-			rds_conn_destroy(conn);
+			rds_conn_drop(conn);
 			return;
 		}
 	}
-- 
2.43.7

