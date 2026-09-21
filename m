Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB547B439
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983692; cv=none; b=kxQCm/1DRLvuGJrPY5PwYKV3ngamTOKD6hvGP+RZC5bb/XXWdJBTPapXStjU1OU5kgMXMQbfQGUGAFvSHVMElKh76qQ0IeZykfteoNn+72ePtqXq4qbQR5rGiknHknI6WQZDAI2p4Pfth3fyebGDIXdsgJDvrxuDvpWU7rXqrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983692; c=relaxed/simple;
	bh=8Y0ieGjoOk3NQHffHGSqBG9S2VJY42ojCB0DdZyh6pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRrWfrfYvXDaBGvkp0T2EDjF/eTgcia0nI7uCyhR/CKZ2DL/DKLh5gFCcfcqQmEyk7Z5JlhIM4HrlZz04mGOSWbgmV6vtHZ0oM/cH4VuSWJQEBAF+nraW0Omjxl3N5cCIz/nsCrvYKpPdGW3ZDTWPWWGns8yJCLodCDwbnw09Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o93yqgJU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o93yqgJU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2dd68a16955so35138485ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789983688; x=1790588488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMfX4UXESdeW6G6btInEL8/FoE+QOLcJTNuBkG5ZRtA=;
        b=o93yqgJU1VqUIRO1RE+u+GR4PN7WT+am3IdZmEq6fSt3bCaDtLJtKOfIeqCXJ8lvin
         7zNpZGmoI8qxQrcbofyTh7HAep9cKCkklqEOxVaUAbatwp0k5sL9D+mnknWN9Wr7x6/I
         KLS89ltnK0Kpv/nVC5KWRbSjJFpWnpzPDL2SX+n1Wjg9mAURffcyUKcrjyTCwirt6/c3
         pEJ7FJQ8PaxafJmvN6tNSMUhzDEafkWQOtRJZ6/gImsx/17bSoe1dXlNOpnIoGFz/4hb
         Vx5isnWn2sJVfkKjmUxeIelNTK6zfUAJKJuUkyT3v1HN+SMb6nZfLmoq6mtVFOhFDRXS
         AsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983688; x=1790588488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EMfX4UXESdeW6G6btInEL8/FoE+QOLcJTNuBkG5ZRtA=;
        b=M8GTs8xijoUg+0Sht3V7NuP8sXqg+/dPNIoKEFztXRLgOdVcwQQTGsQFCgQq/CDIET
         ucn+aq6/JkTd8bujYeg2aW+JD2WZ2agzhGlJneHt4lDqVHPidNZfDy09aasYZ4KtME4J
         7+bmD/Kyjab3c4pMBL1PWC3tsmS/OCJz8ab4xL0VMXCwzY4VxFQH6cCKnwgOq0ZJn7VZ
         6rhdOmmJ6a5BWFR716KSwWH0nVOW5xl/crRiyc15KHqZkxmJ7ohvHCfEqHpeWERpOCen
         HLW5QiltAdhnj9CHToJQtw40IlF1mNKjX8aGfQJWqk8UaYT5sJviffC1wJYkePTu4T+E
         2cNQ==
X-Gm-Message-State: AFuF++lM6qFPRc/qqC5Bi4NG/4c+cVReNQ76KfIAQgF0tMyMf1x8eH8L
	YPmXOSHfwPbzBv1YXCs4Vnlpf4/e9ixNl14GaUGRjDW7uuNnIfy2UyiBF9o/sQ3xETQMag==
X-Gm-Gg: AYBFou0EjltWXwVU5yWiJh91pxxwE29hTVx9zbJChoxe5ef3Yyac4Rb28PsGuEO7pBP
	3wiBox708h/77FYziWJ/0WIIMG7iDgxvjCqTlhU7khbq/Pt2tk+IpAVCrY8lapkSElnESe96cOQ
	ZuW8ai7/n11PtwWpouPjlfs99G56ctJTEq8/cczCEZdqN0XK0N3A0NLg4PKakBsjplGSI7ZPS+m
	rTxpi1WLRdZyxEUizFUcx/Pjg1yTFXLkfXSlZBWrA/Q0NMAylMkxN2i/m5v7cK5eBkut1apo7b/
	lbWBvDvodzgLjcU92pE7E5ikP5PPtCfa1FLOA5ubV6HOTKGvIrS8HWduiLTX/6ncSdnyCGyx4Dn
	3Pj1AVNMsSQ4mnHeErFVMAA1eHBbbkQuI/6alRWoApWmh+T/VqlNRbVqJbrraoM2tv92bZLpg5s
	OvLebOO5DuKi5OEFa0pOj67Lwct0BMENBmWb8ZBh15oHvgPED8aD4YgSF9UttGq4JlLkpktnbdK
	X1GjJrqR86uNh9MyhoTb3CB+jYcqElR2Nh8UGa73JAPQHsxL4A7nmJMgm60fjQTj63YwZ3AlLmW
	dKOH
X-Received: by 2002:a17:902:cecc:b0:2d8:d4d2:d139 with SMTP id d9443c01a7336-2dd9ca3f088mr175298675ad.21.1789983688071;
        Mon, 21 Sep 2026 02:41:28 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n112120123178.netvigator.com. [112.120.123.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17a04afsm31053665ad.42.2026.09.21.02.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:41:27 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>,
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
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH net v2 1/2] tipc: stop the listener before draining connections
Date: Mon, 21 Sep 2026 17:41:14 +0800
Message-ID: <d16573ddc2464277a04274fc12630daf00b8f149.1789960909.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789960909.git.xuyuqiabc@gmail.com>
References: <cover.1789960909.git.xuyuqiabc@gmail.com>
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
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
Changes in v2:
 - Rebased onto the current net/main tip; patch content unchanged.

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

