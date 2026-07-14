Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CF331EB5
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014088; cv=none; b=BlXKw8ti7nm/GOd/8MKn4hLjhVXcjxvRAr3v+kRPu9r+EFCT9Lv0nbsILW6G5NjhGUJesxdDm6goD5uOUMlaH4A93oSokS7igXWntpvgS7TCshmtM1HUov2M/Fp+bR1e5rwqMHR7oww3nSonyiPnyRURVpLgPSL+5ZTFfF1dK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014088; c=relaxed/simple;
	bh=VV6RH/yKbbXGqbCZVlFLWMvC2IkSZjVrbZxP+GH89A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5zBfRkY49T2ut2gIpSQmu3Y3wgvvmUMyXfojVnH3Ks0nT8J5FfVlstBGdoWiM7LpGzThoNQXUMi8Pv8mtZqoJaQEiPwephojU+4zO315hyBUm7UNALz7xhzoEg4ggVo1HfjCwQrdywPdbWcRscV6g17PW3cybm7u7kSl1U2bss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrQKtzVE; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrQKtzVE"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c96739a46acso2409540a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 00:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784014086; x=1784618886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UL4JsWWFy5+1VcD51BCzcQnL+AOhOLYxnY1WLoSce4c=;
        b=MrQKtzVEK6cC864IUWe3vPOz+tNabRozEn2LOjqLNDT7Mv/1qS6ZzvJN0jatk/6BYD
         0aXrWJV2LEUGzI9NhlgvcOd5p4zhDf4cgjbeeI0FWswQnA2/2zKSrCCtP9b3ndmXNqM3
         t4WIyKTou7pBYd+W3WEh+5r9L/B5SwdaHZSODinrUXFSe30b5p5D+nuNkCpZ8YtFaK7K
         yu0y6V3EjupH6oWVGXEOHWbW65pOw8C2Qcne+Vt1YF05S/glcnzK1dXXqVUKI92LL772
         UHPwNy5lO92nmraNgsz7wgHEZjCpICyJmlCJcmsCgLSrcm3gW5rphIFAySpSY1cFQ2BO
         BLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784014086; x=1784618886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UL4JsWWFy5+1VcD51BCzcQnL+AOhOLYxnY1WLoSce4c=;
        b=Yasal6UvE23RZk+UkwJrLzqHEgLWp72RyEuyTSkc62tLeOKefBXWUEqj9NtFsFfrZz
         ng5thOaB9ZeMUP857WDSz87RgP9FSsU/oomMU3UekxytuY0F9boAglzLK0wnK89hD5cZ
         Z6/blb2DzalhMbiHbsmAMqVwzEGZEcKpjdmmK4q7OJz8FKZd78oyT+oXHmXcj0vc5Zfy
         6MpUnCmjQJfA7XZhPOpEl22VF2ee1f9ZRsbvPKkEqgIc/BLrmCuIn/rVzzfUr+4mmYIl
         TkjwnjqizTq1jc7D/7xXNpSoUoG59LJfiUiAezwBd4sEwGqbzuTiEQ0D+RA6Ky5zwYyb
         SoYw==
X-Gm-Message-State: AOJu0YxTAOBho2m0zMfhUNHEKHWv1ZUKXvgH5QGuHHbHhyOPjxTDQXh7
	CRvinYN5GoOYphADAuR22et/ZWHGBhFFDfJPVHEv0Up6z2IXD4pW0VmY1xVK+ZCuUOw3x6cI
X-Gm-Gg: AfdE7cmSOtI9f6CZqmy313NzgkfNwlkSNSgKGDCPV72jgXCj9ewTlzuq1maV2M29JEW
	kwIZ7R2XJDr5mF4ahh/KDtliRA5QAIldNwLyTryhKYW0xqky2pW//7KstpcTLj+K67tFJCBgacW
	fSxBeVcdADEt1gW1kBT3wGyTEmhCO7XbUt4x5TT2Dws6b0cuFtKk8AfDpE7IFZCrHzr82KLCXZl
	YJJXQ6Bax7bqz6zLa8Ed1jSHPv+Qh/ZZ9gpj/M1kb4/UdTIreqe2Qp3t/8TVh+RMOh/JB++IhQZ
	89Cf/wtCgoe/HnNnTRwqndHPDpzGMjTJUDz1t5aIF4YxDd+4LjPJtZCq5DXIzSRZJSrZq1+BBwf
	BBS8JPTAart7FfPe9V+esZ1sR5VrAZI+AfIn+d8V89IAD8WG/wlI411gIbmf3/JP39Au1x9XVp9
	RJbFHyIUcrXkCN4/dGDbXg5JTPWj2yZD8XmQ==
X-Received: by 2002:a05:6a00:1943:b0:841:58b0:82bb with SMTP id d2e1a72fcca58-84a5576ce8cmr1383065b3a.9.1784014086315;
        Tue, 14 Jul 2026 00:28:06 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([2409:8a55:94d0:4771:cc5f:41a5:d797:4728])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f80de8esm975471b3a.56.2026.07.14.00.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:28:05 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] amt: fix use-after-free in AMT delayed works
Date: Tue, 14 Jul 2026 15:27:05 +0800
Message-ID: <20260714072705.129262-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an AMT device is removed, pending delayed works can still access
the freed amt_dev structure, which may result in kernel crashes or
memory corruption.

amt_dev_stop() cancels req_wq and discovery_wq with
cancel_delayed_work_sync(), but these works can be scheduled again
from event_wq after the cancellation. This allows delayed works to
access the freed amt_dev structure after the netdev has been released.

The following is a simple race scenario:

CPU0                         CPU1

amt_dev_stop()
cancel_delayed_work_sync()
                             amt_event_work()
                             mod_delayed_work(req_wq)
free netdev
                             req_wq accesses freed amt_dev

Use disable_delayed_work_sync() in amt_dev_stop() to prevent req_wq and
discovery_wq from being queued again and wait for running work items
to complete.

The delayed works are disabled after initialization in
amt_newlink() and enabled only when the device is successfully opened.
This keeps the delayed work lifecycle synchronized with the lifetime
of the AMT device.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Cc: stable@vger.kernel.org
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/net/amt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 951dd10e192b..7eb871b9b7e1 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2995,9 +2995,15 @@ static int amt_dev_open(struct net_device *dev)
 	amt->event_idx = 0;
 	amt->nr_events = 0;
 
+	enable_delayed_work(&amt->discovery_wq);
+	enable_delayed_work(&amt->req_wq);
+
 	err = amt_socket_create(amt);
-	if (err)
+	if (err) {
+		disable_delayed_work(&amt->req_wq);
+		disable_delayed_work(&amt->discovery_wq);
 		return err;
+	}
 
 	amt->req_cnt = 0;
 	amt->remote_ip = 0;
@@ -3023,8 +3029,8 @@ static int amt_dev_stop(struct net_device *dev)
 	struct sock *sk;
 	int i;
 
-	cancel_delayed_work_sync(&amt->req_wq);
-	cancel_delayed_work_sync(&amt->discovery_wq);
+	disable_delayed_work_sync(&amt->req_wq);
+	disable_delayed_work_sync(&amt->discovery_wq);
 	cancel_delayed_work_sync(&amt->secret_wq);
 
 	/* shutdown */
@@ -3278,6 +3284,8 @@ static int amt_newlink(struct net_device *dev,
 	INIT_DELAYED_WORK(&amt->req_wq, amt_req_work);
 	INIT_DELAYED_WORK(&amt->secret_wq, amt_secret_work);
 	INIT_WORK(&amt->event_wq, amt_event_work);
+	disable_delayed_work(&amt->req_wq);
+	disable_delayed_work(&amt->discovery_wq);
 	INIT_LIST_HEAD(&amt->tunnel_list);
 	return 0;
 err:
-- 
2.43.0

