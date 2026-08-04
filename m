Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C946A5FB
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851568; cv=none; b=F7DeJmbCBizmf78pT36iMtNv9SAtaeeXVxp6vz+2ZSw6kIiBRjDqQI3ZjP5viRdqFInguwpFpKJJYFUuDf3TFGhWRjCVAYQPIXpPPQaQsTA+YA/KhYreCC09sfiZWdH60s9n6DDlHPfmpZ49PLWd+K5nE1CCWgptzOtz1alvyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851568; c=relaxed/simple;
	bh=ych81Sk1AoLZhHC3tJyhITgRXh9uIJo2FFDZgQNhlZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipEsmFC1aNL0gTR8Nc7+TcuVJLavEZM/nxM4j1x9hBuBjycbUPP0ujM9U8bWpDQxWmyBB1T7mY5U5IOSWAk5Xnq0PMgbakOW/VWhW8KXiVnv68J3yz0lm5n2wDPV+XIng9gdrZZ/S5ukAuK6916k6HFbB6RijE9lYz89uqUpQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onLSANnJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onLSANnJ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbb7926836eso3078001a12.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785851566; x=1786456366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/e4D+s9Hhji7feemrfPyi/FIF11qn7GdPSy3sXtOIU=;
        b=onLSANnJoiYKTyRZqz+G/74jaS2FoJI14D/yV5i3F7kT95V/fmRhwCEa1Opn7BV98o
         2QL5pnlbz4nR7kUMRM9IlAvVVw4mlcmbX0jcQizPKLmKC+v3Y1bRAyNwmDO+bK2ZOfL2
         dvm+bm1Z20v12mr4LBK65ZXCNzGwYW+BRLsYCDzOzNHi5NRr47bLjV/dXjSBef8zafjR
         a9tzPb1EE3VlzgiAsdiA8W/7NAreznB57rbjdE6yZ5pz9d+3EFWI98LLHhc6dReaCqWd
         W7lF/O8twh9UH0cNmrhtPH0WiRs4QFAj6tHN38GCD2METRB/N1n5vrJNAOESAnElmhHQ
         bk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851566; x=1786456366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/e4D+s9Hhji7feemrfPyi/FIF11qn7GdPSy3sXtOIU=;
        b=OHK3Fw/MwWHoXVOVI7ddU2RlVSMddeoTsWmDagUOPgtHD/wyrRdn5Nm6YiHSgLmKqc
         zB8E6hV+M5DIVzkjeOlV2J/6nnOmiVyNimM5/DJEEAYaWnOZ2fxOXdIzXWMSa2gEpICG
         +O+wzIpqjSk3EIwUCI0VkjMNtrnQyA1eWgtNpeiX8R16eiTpk2h7oFnP7//pYLLiQKZb
         p9Dg6fcM2QD/NKk3pgrDVHcGqxG5MFE3PLWB4db9HDG51ClDbMrCDfLt0xeeKaXTF4Bj
         0pjBi4sJksS7nqjohwgzgTKikAEX9K1APaF3TTmzvYxZo6V4eMZnBSRDCCl8FRD2wA5+
         x6Vg==
X-Forwarded-Encrypted: i=1; AHgh+RoAyXcrVYKQZZGOOE2aSH8nqYKtEnxvFvdKUiEoNozcL2/xAJQFcRnTNAm2xrBCb2ewDyjziIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43RXq6wkoHm9UvBIGCpUFIG11TeNb45AHhft0YvHc8R1/DNeI
	3/3RWxfh+Ir/E4ryrbSctGnDaqcmbyrimCoMDMevMRr7OXuJJXvi25Hu
X-Gm-Gg: AR+sD10rkEDvRBnZxNb/kDcvD/tut/SlZ8S1d/1QheYZwBpOtiPiS6uHajVpnNae00/
	qTh2x6/cX+ANGdbrADTALExe3QZCthav93Bu5hhm8S8pjbNasbzIEsvDi/A63kXZqvLSCVbLty5
	sSIi3oOsFL18176SWFm7ez7uQOOp985aLE8vRPy2Iond6bvdkKQe0Fr0Hd5pxITaALoBV1+s5mJ
	4rKP+tac8zGcro/LLpBXSI+JIyiPu0oNJROQvrlcte74ItjY+/9xWmLEFlGVZywJ55t2qt2TnzA
	kKPiyf8Ig1pNjasio6Ted7c0uZ69PyTZcXUbHaadrAdaTao5UM0HQqdsvVlOLAOLQOU9mPzRDqO
	3Dz9Yh/hD2LYMnGuTp1pSRV8zfqDz+wEvxQs3PwyLprCABD0OqFSRcp6dJwv5uMagqzJgCZN6gs
	beFXpgp3paPZMnc6qx/57eL+NPkzXzFHTXJtvHJPDvHErRvo8okl40h/G7FiugPPHd+Q0X+QN9
X-Received: by 2002:a05:6a20:244d:b0:3c3:a9e1:a819 with SMTP id adf61e73a8af0-3c92a5e161emr15499625637.24.1785851565307;
        Tue, 04 Aug 2026 06:52:45 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.3])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-315863b0a9csm7551268eec.2.2026.08.04.06.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:52:44 -0700 (PDT)
From: phind.uet@gmail.com
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy King <acking@vmware.com>,
	George Zhang <georgezhang@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	Michal Luczaj <mhal@rbox.co>,
	Wupeng Ma <mawupeng1@huawei.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] vsock: use sock_error() to consume sk_err after a failed connect
Date: Tue,  4 Aug 2026 21:52:36 +0800
Message-ID: <20260804135238.386417-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Syzbot reported an issue which can be reproduced with these steps:

   r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
   bind(r0, {VMADDR_CID_ANY, PORT})
   connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
   listen(r0, backlog)                     -> 0
   r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
   connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
   accept(r0)                              -> -1, EPROTO  (stale sk_err)

Basically, it creates a socket (r0) and triggers a self-connect after
binding it. This self-connect fails with EPROTO because it loops back to
r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
incorrectly dispatched to the connecting-client path. The unexpected
packet type encountered there sets sk_err to EPROTO.

After that, it invokes a listen() call on the same socket. This listen()
call succeeds because the kernel's listening path never inspects or
clears sk_err. Then, a new socket (r1) is created as a normal client and
connects to r0. However, vsock_accept() rejects this incoming connection
because the listener's sk_err still holds the EPROTO error from the
earlier failed self-connect.

This rejection causes the child socket created for r1's connection to
never be freed on virtio or hyperv transports; only the VMCI transport
implements pending_work to revisit and clean up a rejected socket.

Fix the issue in blocking connect() by using sock_error() to read the
sk_err to prevent the rejection branch from occurring in this scenario.

sock_error() atomically reads and clears sk_err, ensuring the error is
consumed when vsock_connect() returns and cannot affect subsequent
operations on the same socket. This matches the established pattern
used by other protocol connect() implementations in the network
stack like __inet_stream_connect(), tipc_wait_for_connect()...

For non-blocking connection, vsock_connect_timeout() may set
sk->sk_err after vsock_connect() has returned. To handle it, we also
remove the sk_err checks from vsock_accept(). Nothing in vsock sets
sk_err on a listening socket, so accept() has no reason to inspect it
at all.

Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
Suggested-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Tested-by: Wupeng Ma <mawupeng1@huawei.com>
---
V2: Add reproducer steps to commit message.
V3: Fix truncated title and add annotations to reproducer steps.
V4: Remove sk_err checks from vsock_accept()

 net/vmw_vsock/af_vsock.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd046799..594fe27d2ebe 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1847,12 +1847,10 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 	}
 
-	if (sk->sk_err) {
-		err = -sk->sk_err;
+	err = sock_error(sk);
+	if (err) {
 		sk->sk_state = TCP_CLOSE;
 		sock->state = SS_UNCONNECTED;
-	} else {
-		err = 0;
 	}
 
 out_wait:
@@ -1893,7 +1891,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
 
 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
-	       listener->sk_err == 0 && timeout != 0) {
+	       timeout != 0) {
 		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 		release_sock(listener);
 		timeout = schedule_timeout(timeout);
@@ -1906,11 +1904,8 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		}
 	}
 
-	if (listener->sk_err) {
-		err = -listener->sk_err;
-	} else if (!connected) {
+	if (!connected)
 		err = -EAGAIN;
-	}
 
 	if (connected) {
 		sk_acceptq_removed(listener);
-- 
2.43.0

