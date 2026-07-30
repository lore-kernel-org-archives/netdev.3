Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40513793CE
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399540; cv=none; b=TSXDFFXchATFPgABOk0uFTilndK1XJWbhWbS9zZyJ35iwjwA9H1dN5BACJK3Ue4OAPLpYlzs79ZikEZGj/xfsjq0K/zZr59OERdCPwPXKAVNme2Bv0nI5ORvkRvg06RqyU5scVMd4w9HneYQsPvmeBndOFyy/emNrxDlY5v6mOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399540; c=relaxed/simple;
	bh=aQj2lpDoDMr3oTGZoAlSySzMKpl0kzj7UtX+5NrpPp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrFS18WmVQg3gCNGv/NvbsH2PcMrea3cmYSL3EU5KEHEAz/09wc8NaaeNglj5MWldTu90AdVQXknBXIHC/JTSXGDsiuRbXwfjxPqTLY+SBSN44WGqD4rWncUPdSFo7YacAFcOqgtPMcxGZr34nNEHpyw+0NHKvb5vqvKCOyoBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJZgF7M3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJZgF7M3"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e347638adso1971378a91.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785399538; x=1786004338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f2dUIXZ0ftJ9QMv7KKCUkHExqYY5TKyD6DDp/Xnu51Q=;
        b=bJZgF7M3u2a9vq1S9vEm4DerpDF4R0CwLfH0kuR4gbam9hL71dL2hl8rXqwi00vE2p
         n6JfKrz+APi3d5XIKwgp4ustJbB8TAYKorKTcQvCudfgtm5m+nUWCE7r2zI5/IBICGk1
         /U88z0eDJok4buscRKZFw9tjeBEXZzdnLyusxyysoq9KexeysHBR65ncFGLb7Aewt3bg
         tsMzbzodaNYNPEcgednO1Q4Dcu6y9T44+aqdjPwqdK3pvl9dYkDk39DPgdlZF7oDIIBn
         ckdHKvBBe399daXCHlxG15r14rIZJiTr2wnyMYXliBsRfkBTi5emhaQt2Fwn2f8touxo
         CqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399538; x=1786004338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f2dUIXZ0ftJ9QMv7KKCUkHExqYY5TKyD6DDp/Xnu51Q=;
        b=Xi7V/kh26mzS3pk7eE565j5dBft7xEIvb+E727LfCNLIgpx9l+8aBaN1FMSBXnHemm
         7C1Yi4GR2jOFpkQ3h7EYzmqCWgG5ibnQqXU692RwbAhzektpxV/b0W43XvzrX2qTlsb/
         svInK1XfOXOsMJVG9q4bJL4VNyD8HhkBsMkzFBTWEyHfldFXJ5rIO0WHhFIvdw7Is6n9
         3Q4O4cZC33PFFyNhhao0UVRXBkYp+wQQtWLlm2KvfME0T6ZwhMsKX2wpO+/wkVgy/dR3
         8R7wNFNwWkrQpsxYRGM7GP+lBTtinMkFVOXFjIx9dhM6A+CLXYR6KxbZkms1juXjmBE4
         m0eA==
X-Forwarded-Encrypted: i=1; AHgh+Ro++PKp4Qbtet5YA5OQaG3S26a98FammK0ZjesV39ljpQWwiaLJKLHSgWg8uduHVqsWnOlH25Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6paFA0UWR7QMErRnaQuMqNCWM/o75AlXV/pIRUyKH2BJp1La
	JlXtNckqDt+KSRVMYXmOX7nOY+qPj9nfCmC4LDHiNndmui7WBfR6XLWo
X-Gm-Gg: AR+sD12ZcU26ylKh6GyrsoPLMNk04SakUqjSp+OLRFf43SpIMS1eqDRSVW2V8+2mQJa
	EGAdqg5lAGMLYF9dLZBggGHXW1VNWYmQk2wNZdWOJY2yGZxiStkdGNoRC2wqnxsV9hp69TL4GDz
	RcwJC8aXYHKgNg1KQbEFkcOrEAbj7p+UQQpHqweb0CXnB3gZRgn8TIDKZM3LfmikLi/yOmWJ7uW
	jmFgUvWlJCfu4Ch8OOWFaucOqLMJLQtAMk4i/DirlUjrmzeHLffg72jDa8GlOodyu1YAPmFjajf
	aH8MpApt9S8GERGCY7aWMQqD8bwOKpnJgRXLgHHQRkYoeOAWwzNWGYRFoyoGuipaQDk0TS00X1Q
	XcrR28trGg8Fy2y5VBZqI+yeRJ6+C7WJ1A+J6reMHPL882e5SKryfp+JOBCh4QkOS24GWkduW2m
	PWjVBocKDLAMrjHSVEZwL5G5WD+k3ucRofbotIQsWltZqMzPvGAvuTI2kCKGoNX8luzFxz8k97C
	Py+QXbFeyo=
X-Received: by 2002:a17:90b:5745:b0:387:df8f:1408 with SMTP id 98e67ed59e1d1-38f9c08163bmr1533690a91.41.1785399538185;
        Thu, 30 Jul 2026 01:18:58 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-38f9bab61desm636142a91.13.2026.07.30.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:18:57 -0700 (PDT)
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
	Wupeng Ma <mawupeng1@huawei.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] vsock: use sock_error() to consume sk_err after a failed connect
Date: Thu, 30 Jul 2026 16:18:40 +0800
Message-ID: <20260730081843.287563-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Syzbot report an issue which can be reproduced with these steps:

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
implements pending_work to revisit and clean up a rejected socket

Fix the issue by using sock_error() to read the sk_err to prevent the
rejection branch from occurring  in this scenario.

sock_error() atomically reads and clears sk_err, ensuring the error is
consumed when vsock_connect() returns and cannot affect subsequent
operations on the same socket. This matches the established pattern
used by other protocol connect() implementations in the network
stack like __inet_stream_connect(), tipc_wait_for_connect()...

Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Tested-by: Wupeng Ma <mawupeng1@huawei.com>
---
V2: Add reproducer steps to commit message.
V3: Fix truncated title and add annotations to reproducer steps.
 net/vmw_vsock/af_vsock.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd046799..43eddc33ed12 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1847,14 +1847,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
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
-
 out_wait:
 	finish_wait(sk_sleep(sk), &wait);
 out:
-- 
2.43.0

