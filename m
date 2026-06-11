Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F12D73A6;
	Thu, 11 Jun 2026 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156477; cv=none; b=jeSpDuxfQYBTRGPF5YZZ3zNfYWuh1yKpmQNEGE0SdMC0DgbUrmkpL27MbjCPxmIFo0Ow2SxI31G5+ZLcLev1h+vHZVRvmZ/3opoEtU9igAoD/adlxBj6jKPaRO8WiZ6+++dXDSTZe7riGCuvjKAACGcnTqVo/iTh/kwLdRj1n7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156477; c=relaxed/simple;
	bh=zNhSz9qkj/R/JPKrsHJ/8swefL7yZ533Jy3IcqFSOYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fyys/96uETmQtswDaDH/FR8AguLhl8zRvMqD043hSNCaDFCBPgyOh3mDrf+M5bNxeuha8/uCXnZzd4p0OPNvsbqTm7yrZY132EF+qoSzshW51y2hMBXcR1sZvzDSVE16K8QTmQIJvPmbTWXfxROP7R8wnrgvQY8jATTXk8qRV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Wh62qles; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Wh62qles"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41f34cbf7;
	Thu, 11 Jun 2026 13:35:50 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH net] kcm: use WRITE_ONCE() when changing lower socket callbacks
Date: Thu, 11 Jun 2026 13:35:43 +0800
Message-Id: <20260611053543.2429462-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb52dfb5003a1kunm749f299f151649
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGRlIVh5JSEwaGRgYSRlPS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Wh62qlestxxamE67cnVsrhQBj2GWm00zwRSEc4ypNOLTGZ3yZLCc0RRrKGQS94xnq5edxVWbG7BrkDkbH4u2z/ZCBDV9mwUCmnrofm2pi66Ywfq/BpeNMjQHI9dcuPtleuvZLEirTEl+01G2FarSHVbib3rTlT0QbpfgKQLAi3w=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=ncKks4DbVhQBQ7h7h5aEf/PTg8Wuk4hMQqO7a7tGI2U=;
	h=date:mime-version:subject:message-id:from;

kcm_attach() replaces a live lower TCP socket's sk_data_ready and
sk_write_space callbacks with KCM handlers, and kcm_unattach() restores
them later. Those callback-pointer updates are still plain stores even
though the same fields can be read and invoked concurrently on other
CPUs.

If another CPU observes an older callback snapshot after the live field
has already been restored, callback execution can run with a mismatched
target and sk_user_data state, leading to stale or misdirected wakeups.

Use WRITE_ONCE() for the callback replacement and restore operations so
these shared callback fields follow the same visibility contract already
established by the earlier 4022 fixes.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/kcm/kcmsock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index f6d44481954c..dc126f7f030c 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1304,8 +1304,8 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 	psock->save_write_space = csk->sk_write_space;
 	psock->save_state_change = csk->sk_state_change;
 	csk->sk_user_data = psock;
-	csk->sk_data_ready = psock_data_ready;
-	csk->sk_write_space = psock_write_space;
+	WRITE_ONCE(csk->sk_data_ready, psock_data_ready);
+	WRITE_ONCE(csk->sk_write_space, psock_write_space);
 	csk->sk_state_change = psock_state_change;
 
 	write_unlock_bh(&csk->sk_callback_lock);
@@ -1381,8 +1381,8 @@ static void kcm_unattach(struct kcm_psock *psock)
 	 */
 	write_lock_bh(&csk->sk_callback_lock);
 	csk->sk_user_data = NULL;
-	csk->sk_data_ready = psock->save_data_ready;
-	csk->sk_write_space = psock->save_write_space;
+	WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
+	WRITE_ONCE(csk->sk_write_space, psock->save_write_space);
 	csk->sk_state_change = psock->save_state_change;
 	strp_stop(&psock->strp);
 
-- 
2.34.1
