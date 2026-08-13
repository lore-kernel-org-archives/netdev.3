Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54402361DCB
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642311; cv=none; b=RbHIXE9SpLrx2pmPX20JhOd3vNV8rTK4drz5DRNM27+8QnE4Mg32QgUgZqiVaBPCdWEJtAcrcljPx4qLd5RwdjQfYgk8Zzv051AWKHg7UOW2SMPjBPxOwNbm3FFdIwM+e2P2XOjaHd3aR0vaXY5zqMI7sMO2ImB1oaxbTASKjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642311; c=relaxed/simple;
	bh=OeOX0RoRjBPyIuSi1g0jByNM0OtD/yGNyEiSTE2q4+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMeCi0lzDmH2pN0D978kRTBELPfUPuS3CqDIXY4Oq185lPwKRHOnoWIZ97yHGhrrtgPtjofapDO9QK4fkQgZ224wxQSGtFi3e62RZ6P21kpmhu857+Qa0jMBJhwOWdKbs5SI/Wxjmfl7FFpiIakEMCte7tLOQNgRtC1KY7p2VBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1xFjkNF; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1xFjkNF"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbee846deecso94952a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786642308; x=1787247108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QzQ+02ZArwstq/stXjbk7JGbozF3cjKbB/DHV6r4yWE=;
        b=o1xFjkNFQJYWqFRBi6/M/9tSgWuGBa9i7WK4N6DITZOceIyILHNZAb5kipbmYx0esx
         q3cp8NwLYIPm6rrbiz/p7jrxtcZknf9UayCTgBYzJI0l0l1ZOvq9OSvGE2qKCkKrhOVL
         VAwbPK1byeRPjx/bnbmzjUTrAFza+XIuk2qwjjR15yMQA0Y2t0FCYcLN6LFRdYPw8c2A
         sClzdkiSZcvaycRziuaKm0Lgk9uoTl0fLLYNUYRY9JibVAM0h22KJbIGYLxZywlBxpig
         IZoZjHAuMu3Ja3QZCyCqDUAwQmQrYSuAskhU6IDTT3ELW0vIm6mqetl7sFWhpU18Tt53
         EKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642308; x=1787247108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QzQ+02ZArwstq/stXjbk7JGbozF3cjKbB/DHV6r4yWE=;
        b=VWZaARZ8LzXboi1DbZrVRr+PNwyk6T5yNu39/zYfA9y8t3oQEyz/STSmLr5f3xdF3Q
         Q2RDRysudjaglwbrickm9xPuiqE25KLCNmwnXtKG++ruQmdd5MXkADqByQyzymkBPs1u
         EyOgK+GYAdQNZeKZD/kRm92+rEyUzSDoedU7rQkz9ZHenHEx7hizDKUsFwt3SGCvQEsO
         EOPJPvXXrKyc63GRANc/q/TGw/f+/e18gvt9cxtXRYoLua2DOVKjeHYTfp+d1dFnjHMi
         8n5Xr9h/kvDz9ej5ldNPwKpfaIdlMBin4w/9SKCU8RpEwaPqQlhxV7fgxWUnx6PtN7lt
         ABRA==
X-Forwarded-Encrypted: i=1; AHgh+Rqpa9/ED34N7QklNxBQcwPB4q53Ns0PDPNIN9XtbwTdlA+uv/SJb6wSU2akYSFztv/t219HlzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/StrHy5f68Ep9upR9a4UyVQ8wsG6rew7wZ8GDzoKGaYZvsjQ
	LFyTujJ+xCENAHtrokEIX2TGu8Br+rHpz1U79pucLf7sIWCJV/QypSCC
X-Gm-Gg: AR+sD11WahV/8vXR4rtDCyZwhTqJJ3azLhpSjdTtXtCjJ9Hh2wTwL4ugRTE8E2kdUQt
	gPeQ5COcyAwk+/fCGeD91n0mvaAs4p1aoFr5k6K7O+hs4FkVxnpbScTwITCJ5CokYnWySMuPKZ4
	jIH4nu2LBx04p2cCjR4qDEEpztk6lWqm+8XNAx65OGYcSApfYZi7ygYLFiF+VVzCOO6YtzYeV4s
	fmikKr5Or3NL+7HrfZjKTDOomGuJXRCil/twCTcE5ZVFZXPVixCJMdLdBYPlRWBRi9fv5BIFB5E
	8e7yICmqmm01swexz3ByuE9AdfsbPix8Tc8/uXe8a892Re8mTbOK3ULS8Uafkufe6JVJFVVCOwc
	dlwBbeyL4m9qUT+1URz31RvVRkoG7Wee/cZw4ae84V2hMws0Vb9sMSu81wUYsiyKpocyvistuvF
	vTSsdkKI9vsHOew0kwwWieMuIetDIj5L7pGr1m2qdKZwg/fIACmxSWsxFCybr7AQ==
X-Received: by 2002:a05:6a20:da1b:b0:3c0:278c:6a31 with SMTP id adf61e73a8af0-3cc54ff0e51mr11048975637.11.1786642307657;
        Thu, 13 Aug 2026 10:31:47 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebc75d8casm10961169eec.3.2026.08.13.10.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:31:47 -0700 (PDT)
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
Subject: [PATCH v6 1/3] vsock: don't check the listener's sk_err in vsock_accept()
Date: Fri, 14 Aug 2026 01:30:18 +0800
Message-ID: <20260813173024.2362935-2-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813173024.2362935-1-phind.uet@gmail.com>
References: <20260813173024.2362935-1-phind.uet@gmail.com>
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
index 622dbd046799..3cd5c3561be3 100644
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
@@ -1906,13 +1906,9 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		}
 	}
 
-	if (listener->sk_err) {
-		err = -listener->sk_err;
-	} else if (!connected) {
+	if (!connected) {
 		err = -EAGAIN;
-	}
-
-	if (connected) {
+	} else {
 		sk_acceptq_removed(listener);
 
 		lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
-- 
2.53.0

