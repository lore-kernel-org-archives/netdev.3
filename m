Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7835F609
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658531; cv=none; b=U6Y3D5FlTeAo20qbYW81Hshq32KcjD3e02MGhhyAEbiCqXUBzfeEwaAxSy87A6LRly9Ujf4N2hVstKgnt9Z9Qy3dz7AD1tp7ph0wmMIFMP+OYwPjYrYcY/sAfZ3OOJWKYhWvadWzwwMUZbg6YQEc9+QPgnDvz4NV9vuNDbai+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658531; c=relaxed/simple;
	bh=cTZsfN76uapqxkSYX8K1QmRWON7vxCZjiy3TX0jboC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WcWmNKhONhwMU54cPxKcJlerRjJ1RNFKhaldJ2dUwBiiauhoXyRb/yrKvgvjpI8gZ/s+wM0grvefWpBlWL3NCn1KfVk+C9PtdQVoMOctS75ThFdWZkK3AVNuPhNytZQ1vTLhaKYawMWvwVIhS9u657ZyV3t+51X26zWx2j4FXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=arzYPMPM; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="arzYPMPM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1778658527;
	bh=vU6BJAlA7pm2cjTSAaNXNjdtuhv5bbu4WvAbz1Ch1Lw=;
	h=From:Subject:Date:Message-Id;
	b=arzYPMPM2QYz2a/CHwhf7QVozIk3K+Ez/f73e2mbtnN3a2rBtQupJAFEqqqiMXN1H
	 EeuwHsKixLqGR0w7hiMlYMEIQIP6tvIIWzWD5IeWFnzHO9okEydDgvKPsh86PQ9gkf
	 xUYQSxyL0o4dJ9Ct0dAGprIYFIIR+JM2D3eDa50s=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.21) with ESMTP
	id 6A042CAE000016B9; Wed, 13 May 2026 15:48:05 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 6073283408170
X-SMAIL-UIID: 9BD9D8ED099B4880B846C673BCEF642B-20260513-154805-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sam@bynar.io
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 5.15.y] can: raw: fix ro->uniq use-after-free in raw_rcv()
Date: Wed, 13 May 2026 15:47:58 +0800
Message-Id: <20260513074758.4102262-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Page <sam@bynar.io>

[ Upstream commit a535a9217ca3f2fccedaafb2fddb4c48f27d36dc ]

raw_release() unregisters raw CAN receive filters via can_rx_unregister(),
but receiver deletion is deferred with call_rcu(). This leaves a window
where raw_rcv() may still be running in an RCU read-side critical section
after raw_release() frees ro->uniq, leading to a use-after-free of the
percpu uniq storage.

Move free_percpu(ro->uniq) out of raw_release() and into a raw-specific
socket destructor. can_rx_unregister() takes an extra reference to the
socket and only drops it from the RCU callback, so freeing uniq from
sk_destruct ensures the percpu area is not released until the relevant
callbacks have drained.

Fixes: 514ac99c64b2 ("can: fix multiple delivery of a single CAN frame for overlapping CAN filters")
Cc: stable@vger.kernel.org # v4.1+
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
Link: https://patch.msgid.link/26ec626d-cae7-4418-9782-7198864d070c@bynar.io
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
[mkl: applied manually]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 net/can/raw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index e32ffcd200f3..b489689ada33 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -333,6 +333,14 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 	return NOTIFY_DONE;
 }
 
+static void raw_sock_destruct(struct sock *sk)
+{
+	struct raw_sock *ro = raw_sk(sk);
+
+	free_percpu(ro->uniq);
+	can_sock_destruct(sk);
+}
+
 static int raw_init(struct sock *sk)
 {
 	struct raw_sock *ro = raw_sk(sk);
@@ -358,6 +366,8 @@ static int raw_init(struct sock *sk)
 	if (unlikely(!ro->uniq))
 		return -ENOMEM;
 
+	sk->sk_destruct = raw_sock_destruct;
+
 	/* set notifier */
 	spin_lock(&raw_notifier_lock);
 	list_add_tail(&ro->notifier, &raw_notifier_list);
@@ -405,7 +415,6 @@ static int raw_release(struct socket *sock)
 	ro->bound = 0;
 	ro->dev = NULL;
 	ro->count = 0;
-	free_percpu(ro->uniq);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
-- 
2.34.1

