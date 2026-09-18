Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5DA3B0ACE
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723296; cv=none; b=R5f95CDZGGSBtTEUUefbWul1bKwI/CZAwmjwCgIKrp3zva7EHNHW+KvdSl1m23LPSH1JClrph7fkbCBeuy9y9drT3Ed/trHShVL8+YHowbWV9ZuIey32iw2eQVp6sP4/4FWHAObiQLUwZ3jday8tov0mhws41hoaUawcMRSk//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723296; c=relaxed/simple;
	bh=LgQwq0lqcthkLYGKPObYEllQc/Znk/K8NYI2hj7hZzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrxHBXo5HSKmJrClRv4kbELbNP/5XCt6gdf9f8u6pC7xrNu0NualoltNplD5hGul+LnyQQLs+6iNyqcv56ybIvMc1L23d14Zd+1zTcbYKb/74p1Xg7tJojYWoIKrQsW8oTf0saQgFsCDqsLFuoDEb3a1rNF9tBfyp/wYvu/cYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFF2hfp3; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFF2hfp3"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so462572a91.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789723294; x=1790328094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5470ZJyWN3bHAzgTPv/D/YMrDeBQ3kUcDTovrPyBs0I=;
        b=HFF2hfp3n9RYwkiKPnbempJf+cb1WnGUFIyB2ZPgqwmAwpm8IzVAURAw/Wzm1+tN+2
         o6pkViOkHn+j520oFF6gZOPf3wXm6/5FEifUL1AlxEVPFzEb5kQ6+8FQ60hn4TB3N62N
         f1BHzPqanP/p3/mQJKX+NCoiFNd8ZPvLy9w7fpSOqn9cCi04nT/2IMGJ935G0TDs0F9r
         cqRs8S0O1Dgu+P3TWBII/Hu/uad3uKwcx3Ua1+L82cLaMW7Cdg5WGLE/2Q6PmXdskz2N
         r1n/XVcXJPSoTx2LHq8LIm0DoWjv3BW3sM5ZnDfSWrIcTRu1WD77Ae4J9qDIie2h9+GA
         T1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789723294; x=1790328094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5470ZJyWN3bHAzgTPv/D/YMrDeBQ3kUcDTovrPyBs0I=;
        b=gyPAM0y0wSxoowwmz8ys9HfwF0Bxlyrx245MJ8OycKho0obPPZ1k5uKCAt4lwjyHPr
         yODeud/6NJTpGVqfgY4cgftuQGqVG0QoIi/VXuuOzwhZy1BGXysUvp/wjYblBcaE/MY6
         5gE/hw+P+TDJSSHkLD/fl1tSwcy0ZKXp9nmYcisxlY4uFg0CTjKSzSTHSa12YEwe54E0
         RLiZsVZdOjXchLriYsXsgN2RN1JfLAl2mWB2qreIZhdG9zZPI6LVkYcCGd2FsIxXTly3
         fTZ8oMmjTdxoyo9VeY62lugrTFdauuhcB4YsKX6Pi1L3ef2y0x+eIfk1EeqXcbtvQacv
         PJ5w==
X-Gm-Message-State: AFuF++l9Ujcmu7gtiLXhRUScIth2/zW/v5a3lYQCGlplx5qr8G7dIXO5
	a2BRDToTKNa88yxeDWm21PKkV4acolRt8qlc2Sw9kIeY5qubTa0NCoiYQQb8LJb3IS1x3R7Z
X-Gm-Gg: AYBFou0GGJG89HM24337ZdIr6QpyDYQHdkPyDVSwwQ8mR8fQEftaTxrMi5WaUDi6g2Z
	4zSBAdhgLmIvgopesURD9Ilf+52OMYLhHJohFNqefYdxSzO9r4Z2PZ9kjAFICqkPe1yuxQBZV1m
	zMlWk1H24hqhB2Sf7NcZ5N0KYbAD9h3nSgeiiNPZ/TkbSYakVCm5P6MqOl34iCWe1Z4jbqvND9A
	cJqivEeT5n2qF6f3R3eWN1f06hIUXIshJuWonrYHzIW6KtiaxbfJX1Sh/Aq/srxOW+yamQM2oEm
	ma6W8Z/TfAF3B04kuh7bX5ZrH8fn0Zp+4XZrKQzHPYvJFddD5VEMNfCVZst+CpaSgMSemuert6W
	sgu4utOIQgnLIQvKG/cCeWAb9HV7PQjOducSWuAtrbeRQMTh5q5dxmdcRxJVUvtCXBk3xcbqYEf
	FpZ3AO0bPQNX7B0U+ThkqrLxmW8uTmjXULHMqrFejBSb8BDEXKRlFBROD6WSWgRzHwg7ep5T00q
	9r+E4J/dC5UnG16Jt7H6ZcDx43FXeCmhUcnw82cYSVI+YaoSvwiY/XmHlzUaLEeF9ZnTS43rVYo
X-Received: by 2002:a17:90b:5623:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-39e54d160b7mr4950618a91.12.1789723294171;
        Fri, 18 Sep 2026 02:21:34 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n11212025079.netvigator.com. [112.120.25.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6137e111sm677341a91.1.2026.09.18.02.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:21:33 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <enjou1224z@gmail.com>
Subject: [PATCH net 1/2] tipc: stop the listener before draining connections
Date: Fri, 18 Sep 2026 17:21:12 +0800
Message-ID: <48f16f41da6ece5aa646c28617031d00a126411d.1789722780.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789722780.git.xuyuqiabc@gmail.com>
References: <cover.1789722780.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_topsrv_stop() destroyed the receive workqueue while the listener
socket still had its data-ready callback and sk_user_data installed.
An incoming connection request could then queue srv->awork on the freed
workqueue from tipc_topsrv_listener_data_ready().

Reject new accepts, clear sk_user_data under sk_callback_lock and cancel
pending accept work before the workqueues are torn down.

Fixes: 0ef897be12b8 ("tipc: separate topology server listener socket from subcsriber sockets")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/tipc/topsrv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index af530c9ed840..908622a3d0fc 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -700,6 +700,15 @@ static void tipc_topsrv_stop(struct net *net)
 	struct tipc_conn *con;
 	int id;
 
+	spin_lock_bh(&srv->idr_lock);
+	srv->listener = NULL;
+	spin_unlock_bh(&srv->idr_lock);
+
+	write_lock_bh(&lsock->sk->sk_callback_lock);
+	lsock->sk->sk_user_data = NULL;
+	write_unlock_bh(&lsock->sk->sk_callback_lock);
+	cancel_work_sync(&srv->awork);
+
 	spin_lock_bh(&srv->idr_lock);
 	for (id = 0; srv->idr_in_use; id++) {
 		con = idr_find(&srv->conn_idr, id);
@@ -713,7 +722,6 @@ static void tipc_topsrv_stop(struct net *net)
 	}
 	__module_get(lsock->ops->owner);
 	__module_get(lsock->sk->sk_prot_creator->owner);
-	srv->listener = NULL;
 	spin_unlock_bh(&srv->idr_lock);
 
 	tipc_topsrv_work_stop(srv);
-- 
2.55.0

