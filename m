Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE33148B4
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790561070; cv=none; b=P9u6giWfUlpYDNCcVL9Oe4fXClZ6dRd5GjRyhnFUSE7AkTRAFb/CPRYEUgdu2hM9D8x2UwaWeHJ5fYIxkDOZhVzTzKzgojxaFwAdx4u2MFAG/myuJLW0TTIsGoWSDKue3JX6gdpXg4TlQ4cKZdOnClTGTCqE/V1Pi4kcU63V45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790561070; c=relaxed/simple;
	bh=2VMNPPge4HUiW+l8Kc87su6EKy4IJqnl/NwbDwBVz8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTmejNAaAE7sTlP08H4UWeuODBuh3bF4bu2ROEe7j/ykEPEymsDHzCDfmPimh9W/y2VbL5AxNFChhE/MI+/bZZ9/QhCSpbS8MSopqr7+OBbxAY2riYF18DWDe6bcUsv538JQlAa4QmxfP+5AHO/nC4YRm3q7AbXXlzqtT3752mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6t5CbTD; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6t5CbTD"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87be3ca16so16455037b3.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790561067; x=1791165867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ViAye3eG6dN+VEEglQQ1rw9LiYGYREDdQvJkeSJ/lXE=;
        b=k6t5CbTDO0mFV9w28dvBMZj6ptAB9RAudlF9M4eNi/xrfKzSVVFlc4ob8FlRj6L9+S
         zU0xl9mWjxOL3cn6E/bsYPS8V7x20oqh/cR4FXRCwnxe5njOeUbI0B05MKTHUrSMs5r3
         8LpdRHmW91Rs/H5qR0CDEVtUVwEdwAho6NnK88DukdJrl+TKf13tA30kPj/XpWX+NJPc
         WA7PjiSDLvRkqlUAlQMfDI4eVzx/fXeONtiYPDcR25vhewIQmh9rV0JZhPI3ZIRSXfg3
         wjQLavgiMu1r9Pu0ftLKF1ctLEoTFFkg8jrBdMNzmdmMdLlqNqikuW3biRRH7SqcdPgl
         Jxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790561067; x=1791165867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ViAye3eG6dN+VEEglQQ1rw9LiYGYREDdQvJkeSJ/lXE=;
        b=e2ZF1BvfU1eMN/7PNsd5rq1ZU69ZmZjhLuQxQnZSM1elHDfk/kNuKJDnZ9o7oO5bjr
         +70rjNaq2HOjKosrElVCO6ZZw7KRyjyEXLPzszHsxVdwArlFjJIh/H5ZRY75PmrO7hkJ
         XZqe8Ey9Pd5YCZiBZmfvh9QRzghXqsmjWa2nJQSqhiJUKNMrpJvrXVjWj7y2a7IbTU82
         8IfmdtSQ5sXylNAajMM5aXjfD7hHG805adHxhzl8Q5W7kE/j8cF9h0dd/KlVAaqbVVwl
         rt9QUyOjlroxZppOd6Hs8hqr+rwUBXrOqLIpgaJIMjvrI8OKSxShyVdU7fggGuYA9Sb7
         qpqA==
X-Gm-Message-State: AFq9FYIIiT4aNVl+AW2E9tCvh0azadcnUaSV50nw3eRUY6HyuCFWfhiv
	/ZNZBJLJgBXd9Cgz5vYAYIsR1s1fBrHXAGJ1Tt4mVc5dJcldV0wETRpevPinsA==
X-Gm-Gg: AYBFou1OzPCPrZYeGYPC/T9XyCCJweiQ6TVCboB/enLU1xKJMdOxH91f4LsiXqFccsD
	v/cnwN81vdk4lk0CnnQwrsQ8UPlp9m7LQQr2owSsKcJjL3dE3mkDcFREl3MV4ay4R3P6sWWPeXO
	gk0YKcAeIM89NanXwL3VWvwummUVAy8NflLR2tmAY+R0Hbg3mlDaH88z8WDGzFNHt7crHTqGCBx
	+sU2iDxv6QnfGJKiEEp4UlAvpL6As2eYx0WR6V7sboj3sv5hEAZyM7Uf2U0nDgC+bqA2syJ4cil
	5S1OgMSpjt3+ccdv+tWvF5AeO5FNqfowlqox3bE8emwqqmQaSU0DtDzxAGQbyx+Rst2wMWdPUIV
	Aqmz1ksuui+uXcweZ22tOgd74zAzEFLvRtq9cxLcvHem7X9ggxgTJWetviBb6IOnx/rMJjM0rMO
	ybfL3MMI7jfc/3RHwELidSwx7XjHEgk1hMgKppYLagnpgNIhpPQ/IIfPxYx7gIX1T+9XFUr6T/y
	OaRkhtSfex8h2LQfzEPu2AxkqG+cJanySfqTRpZ8PiD+KHwGs6z13k7mhBgRDZV7M3SxaPkiFg=
X-Received: by 2002:a05:690c:c50d:b0:8a8:7e5a:dc4f with SMTP id 00721157ae682-8a87e5af10dmr26063477b3.73.1790561067489;
        Sun, 27 Sep 2026 19:04:27 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860f9cdb0sm36894177b3.24.2026.09.27.19.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 19:04:27 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	ilkka.lappetelainen@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] net: downgrade BUG_ON EIOCBQUEUED in sock_sendmsg_nosec
Date: Sun, 27 Sep 2026 22:03:29 -0400
Message-ID: <20260928020420.3097018-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

sock_sendmsg_nosec() runs in syscall context but calls BUG_ON() if
proto_ops->sendmsg() returns -EIOCBQUEUED. Crashing the kernel on an
unexpected return value is dangerous for production workloads.

This risk is real: any signed integer overflow in a sendmsg handler
that returns 0xfffffdef (-529, -EIOCBQUEUED) triggers this BUG_ON. In
one month, two such bugs were reported in PF_PACKET, reachable by
a local user with CAP_NET_RAW in a user namespace:
- Commit 73e594c19b4f ("af_packet: Don't cast tpacket_hdr.tp_len to int
  in tpacket_parse_header().")
- In review ("net/packet: prevent TX_RING byte count overflow")
  https://lore.kernel.org/netdev/20260925124829.6595-1-ilkka.lappetelainen@gmail.com/

Replace the BUG_ON with DEBUG_NET_WARN_ON_ONCE() to retain debug and
syzbot coverage, and return -EIO so that -EIOCBQUEUED does not leak to
userspace or trigger the BUG_ON(ret == -EIOCBQUEUED) in VFS callers of
sock_write_iter() such as new_sync_write().

Failing gracefully is safe because the original reason for the BUG_ON
is gone. It was added in commit 599bd19bdc4c ("fs: don't allow to complete
sync iocbs through aio_complete") and commit d8725c86aeba ("get rid of the
size argument of sock_sendmsg()") to prevent an async completion from
corrupting a caller's on-stack kiocb. Commit 1b784140474e ("net: Remove
iocb argument from sendmsg and recvmsg") removed that on-stack kiocb.
More recently commit fcc77d33a34c ("net: Remove support for AIO on
sockets") removed socket AIO support entirely.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/socket.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index bb0e1e118ef6..d7a2d2195a07 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -800,7 +800,10 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 	int ret = INDIRECT_CALL_INET(READ_ONCE(sock->ops)->sendmsg, inet6_sendmsg,
 				     inet_sendmsg, sock, msg,
 				     msg_data_left(msg));
-	BUG_ON(ret == -EIOCBQUEUED);
+	if (unlikely(ret == -EIOCBQUEUED)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		ret = -EIO;
+	}
 
 	if (trace_sock_send_length_enabled())
 		call_trace_sock_send_length(sock->sk, ret, 0);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

