Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F03DCDA3
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136395; cv=none; b=LSkq7sT/q1HbgvxEdz8V0OhMRoJSvschJdY8TeeONwvJxCMKtLAo+9JiPN5dL5gf12TICLjjh6vnJ/YmkWQu879Wct/Q2bi8YRknlFnCJv2Alj/yrBqc57iOkV20zHXKMUJWqXuHY4Q7rV+uGmV9QdNwKv6crCebzwGRm8z6wiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136395; c=relaxed/simple;
	bh=QM05rrJY85zLcn+2ylIFOtVP0wce8tYDJfOmna9dsgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSo8YU4pnOy5xkTSKomR8I3UmVNyz6F4gRYxC6Wg1zLLFSjyzlFan64SYKkOgv89AKd5FEqEt6m3gcYQTDVjC89mJZBRhRplvBgC7cg3kqFGIw8tQvuRJJC6YYEHjP3n/MzJ942FqJMTsCFVcHwMzkSJ2Rz1UJZiA0Oagm8gu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amvpdB3C; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amvpdB3C"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1695469a91.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 00:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785136393; x=1785741193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pHnrV3czUGHVnAIuseNPjMPOG4r9Mq38crYmq8Ga0JE=;
        b=amvpdB3C5gQ1az/5E7tcrAyyjlPhFVFe02tNZjqt9BBrL10/SReckUZsuo/XH1Rel6
         hN485LDv+xBdY/Cy7h8YLZmzl0gyI0c71rJldARyyjIuKVarx+lVHaxrSMqIBjhtNHLF
         aYJDTVDch7pOPzKSJ96XHtuzjHAJq+oCUmIqNQV1Asds+jQ5J/qJ9vLnkUf5u6zSwq7t
         2cGkFziUYvsDTRkijL/B7cf1Jybw5ei2IbtK1VQDpJI0NyAWq+4lLSuQb+N/anFR+l+x
         nRow0mA101WPDDpyLy90c/OJArZ3jxg5rDZ063HQF9D1COBRvy/TE/XqzXUgvSGJyskX
         +wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136393; x=1785741193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pHnrV3czUGHVnAIuseNPjMPOG4r9Mq38crYmq8Ga0JE=;
        b=cNzGWXj3CRRPedlKg006dwphTprq6Kk9EDZdUn1t8X4Ogbvkw412+2/vTi90Wt3x/9
         DhovvPgzbkyk9j6EMOkzXHIJcJw3/a8DY8xJ9EppmjcV+Ri8jl//gnbeTr0SLwswmna6
         mutCiWT6EFkfuW0wn4NfYvLKTxk6inUqmfJjDz5ZjQncbUgbrBi+1pyNEd1SS2TNANIO
         9iYThGAU8f3sABwXNd9tJcnO22VYA902ILqjAqlnJrTv1YrIpRTPMTqCsT9vFulZLP4w
         0StVgwmFAHgA6OOLbCs8x3y7lKT93ZovMGmQu2gM1VNmCp+r6g+tT8EAvdeuKAhoDmyQ
         7M0g==
X-Forwarded-Encrypted: i=1; AHgh+RrfBVkm7odhLXSMD1Ep0JeeDYEJ/sUgZPzFmDdBcK7DP2C9kCDt0bwFJu+wo5iJiQAQRBPagiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhBN6VCa/pYFH17qjkPrAoxSyx/g0OZg5wrawcmSE7upprBrU
	sIU503djuhRXZM5GtEJj235daxR+eAIubW9vklqXRi1fn5ufd016kbdb
X-Gm-Gg: AR+sD11XlsLUHXn0mqE2lspe/ZPVanl8os7pRCqeOpWgYU5IZyS0zdxEQ7koHX7Esjn
	3LrMmIihlFUpA3AFVmsekJdjSxq5/jNjO39MP9xs5h0YrKCUEoTMi119yV1si4acyAVfik7Rsmu
	9e7vsNNBaH9EvW0AfCyjZl4cmVxHR8/z64VX5fskJxFZVU4QGUOOtiJ+gr6c8H0e4UrBPj4iMyr
	S59el+Ui3dNuCnCT8kBlx4bal8MOP7r+ZE2bEyiIS5cmlIQt5lBZvmxpO7SEMlvRksJ0n3CHL+M
	xE83SSWh5y4XBN0ojsDw+WC6oGVpZrhSmqEzwlNuXNPeuJ7Q0EauOf6iWEZbnHVEq+Y1obnOtL+
	RHgmheEIiqQP0/krt1h3ydLKnrQFV9n9z4XTkfzQATFbtKMl+mmxFCAMtttkf/WAzC83jO7A+bc
	vpbeBK38wXSBB78A==
X-Received: by 2002:a17:90b:4d0f:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-38f293caaddmr6801135a91.9.1785136393137;
        Mon, 27 Jul 2026 00:13:13 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-38f08968de4sm3238840a91.2.2026.07.27.00.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:13:12 -0700 (PDT)
From: phind.uet@gmail.com
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy King <acking@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	George Zhang <georgezhang@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vsock: use sock_error() to consume sk_err after a 
Date: Mon, 27 Jul 2026 15:13:02 +0800
Message-ID: <20260727071305.45826-1-phind.uet@gmail.com>
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
   connect(r0, {VMADDR_CID_LOCAL, PORT})
   listen(r0, backlog)

   r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
   connect(r1, {VMADDR_CID_LOCAL, PORT})
   connect(r0 -> self) -> -1, EPROTO
  
   listen(r0)          -> 0
   connect(r1 -> r0)   -> 0
   accept(r0)          -> -1, EPROTO

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
---
V2: Add reproducer steps to commit message.

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
2.53.0

