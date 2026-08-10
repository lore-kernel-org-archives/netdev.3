Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366163382E8
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381849; cv=none; b=sQUsobe5TnKgjBh2JVmAb+gSwHp2/ICKE9v4DU6ZayhyGxtjUuv4hF4EErjCqOviUYL6DiHg+qOFICCQtQApbKITJCZFiVyetTegOfFWGCngVLo0CZ0ReyhRVJtzF9JsvSmg3njOnjHWT/dbfciw929u/TLjdomZOuuyyLEYC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381849; c=relaxed/simple;
	bh=j+tqaF49vVrcAgCqivH0Q0gH+G4z0Uw2YSxLSLYQ6dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXqsF1lAH5cn0zj80rkCV1B+zuRZcqigqfJ1arDo9HD+2Lule6ZEKnVK/5g3l3sDVbot24cUWir86AwLtQpRqGbDLUS11v3VukQTLlyVpLkbo3YQ5NcTKnKPCLel59WR0+TVOqabCAt5xnwg4jjzIPFTMjjwPrY75NfGqjOUP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2ektfiN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2ektfiN"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84eb992a881so1555208b3a.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786381847; x=1786986647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o17hX9psIIM1rya7TZerzwkpY1R4GKMlzn2vF2QyCKI=;
        b=C2ektfiN94yCBjhkL/mjM+Dpb9Uqj0uRcDTvOMp1VPZAQp0B06RRE2DXc9hU2wYIOV
         mgKSpnILRm9v1AZvOtijFG114SUUBGLZgyO9gexQBQuOzR9kf1Fks6wA+RV/UmLsdB6Q
         jpVI6fmD6QYuILwlFTWhXesySsTMpe706NcAcASlnXz9IQB2WOBQtUrbPmUJLaC3pFPZ
         nIwTesGiPTaVrt4XTMkRgCxKbp7CNry494xcjPhZVW+74dd7uhER5Vl9BjQJezQf7Tz8
         EaDUFnN/JsKQbtv0sPkJ9246hQJDGWXtNr5cvg/zcCbphy6P1jffbF5o6nZ9eMfrBXuT
         j9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381847; x=1786986647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o17hX9psIIM1rya7TZerzwkpY1R4GKMlzn2vF2QyCKI=;
        b=FCuDlHaabhrjT8q87iC/EUOUBSCLr9T67Fy0x3DcC1kSSvImQOZr2eW7FqoUVXXp5A
         sgM4ntneZg6lLueQSCk1LGz2XnZM4hcQNi3pPEDa/XNtPMRRC5+lQ8rQ6LkHej5z5kSW
         lpOZCs4M+KnXRpW1RFtrh6vYaLCoJ77wxeiQuXKngEB2RARIu+t2r2/tQnZD4K5zmse3
         mP88mrReRvMUcPNiRYOun1c5BIxGfShbXrDdkzGWpnPFtobbSnzJLAxGYGum9q1etduX
         d0No5jxUVTLRda0pSTugb7Tc27HvsJr6ptIhOWHKMH6A03YUJQF5NA+CbTkwg/3wkuR2
         kFMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/0rkeWCZnaCAvW4QNasjqjws28vd/rEnCr5OPihCNWcCW5DctxzJuFZac6IN558tsgW8jaeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaawjqowe3aSMnRBsHguzVy1atHQwiBI2asFoqvK4pe7Pd5a1X
	w5F41jZTloDUdOBXA7lBez/rdpyOGI/5FI9LzOfElHm7JT7wjvaJkaxH
X-Gm-Gg: AR+sD13pa7oQPonUO4XrZkWn0R6q9CZZLWe0Xqo0WoCjA6UMQCUUW2G7mbzQFKrtT8w
	Frvlo0emxQqBRRYhgztVjNsfEO/+/uWUxxq+zXLdsyB+bud7QBsnbkmwlOK8cO36N78/2LMg+QT
	eAPy59LSZCvpDPkYYSHCS/9XmyXB0vimzYApqSY2YNrlN9NPyAIEjhKxYeHXXf25XWD0w/zXP00
	asK+1aLdHz6Sj0kzjMd0WayJSezp4x+Dok7j+UUUWzOfXUpJygZLkNBlceXxQvalYSrUMw724qW
	EmM0ab6Ur3QaJ+1YtkLgmzZXTlr3zPAG5bVqWy1aR3ZBqIgavAOkV7hLGED1PkkiKXo953cjY9c
	RLlm4HO+DH+khstekmgdglJlTd/txay5ua3hr3u+/e5UWNU/xLsYNG15RGT6eOkflZ+3Y+S/Yow
	E46JjP3qQ4ee3xHXDxFfe0J50MzmALYNGm97q5SHv3cPWl+CZTWOF5TQyYBWa0QQ==
X-Received: by 2002:a05:6a20:db92:b0:3c4:147e:98f1 with SMTP id adf61e73a8af0-3cbadcfd00emr37452298637.31.1786381847406;
        Mon, 10 Aug 2026 10:10:47 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199cf49sm37194663c88.3.2026.08.10.10.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:10:46 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	George Zhang <georgezhang@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	Andy King <acking@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] vsock: don't check the listener's sk_err in vsock_accept()
Date: Tue, 11 Aug 2026 01:09:30 +0800
Message-ID: <20260810170935.2242314-2-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810170935.2242314-1-phind.uet@gmail.com>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported an issue which can be reproduced with these steps:
	r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
	bind(r0, {VMADDR_CID_ANY, PORT})
	connect(r0, {VMADDR_CID_LOCAL, PORT}) -> -1, EPROTO (self-connect)
	listen(r0, backlog)                   -> 0
	r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
	connect(r1, {VMADDR_CID_LOCAL, PORT}) -> 0
	accept(r0)                            -> -1, EPROTO (stale sk_err)

Basically, it creates a socket (r0) and triggers a self-connect after
binding it. This self-connect fails with EPROTO because it loops back
to r0 while the socket is still in the TCP_SYN_SENT state, causing it
to be incorrectly dispatched to the connecting-client path. The
unexpected packet type encountered there sets sk_err to EPROTO.

After that, it invokes a listen() call on the same socket. This
listen() call succeeds because the kernel's listening path never
inspects or clears sk_err. Then, a new socket (r1) is created as a
normal client and connects to r0. However, vsock_accept() rejects this
incoming connection because the listener's sk_err still holds the
EPROTO error from the earlier failed self-connect.

This rejection causes the child socket created for r1's connection to
never be freed on virtio or hyperv transports; only the VMCI transport
implements pending_work to revisit and clean up a rejected socket.

For a non-blocking connect(), vsock_connect() may return -EINPROGRESS
immediately, and vsock_connect_timeout() can later set sk->sk_err
asynchronously.

Since no vsock transport ever sets sk_err on a socket while it is in
TCP_LISTEN state, checking it in vsock_accept() serves no purpose and
only carries forward errors left behind by earlier, unrelated
connection attempts on the same socket. Remove the checks so accept()
no longer rejects valid incoming connections because of a stale
error, which also avoids the resource leak described above.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Suggested-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd046799..ff507761f472 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1893,7 +1893,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
 
 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
-	       listener->sk_err == 0 && timeout != 0) {
+		timeout != 0) {
 		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 		release_sock(listener);
 		timeout = schedule_timeout(timeout);
@@ -1906,12 +1906,6 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		}
 	}
 
-	if (listener->sk_err) {
-		err = -listener->sk_err;
-	} else if (!connected) {
-		err = -EAGAIN;
-	}
-
 	if (connected) {
 		sk_acceptq_removed(listener);
 
@@ -1941,6 +1935,8 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 
 		release_sock(connected);
 		sock_put(connected);
+	} else {
+		err = -EAGAIN;
 	}
 
 out:
-- 
2.53.0

