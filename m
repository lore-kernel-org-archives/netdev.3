Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499764;
	b=q/+bs2H5cmXaoc7QwBl162Ip7WEfyDeN0896hBazIq67yAucla3lHXCrkkzVAtHxRha9
	 S0QiShNSIouVEZH12Tq+9/6g82A2lxQj5VxP28uejpkkHSaAdiX18tf7EKUETUAbthyGM
	 28JPitywsBXuCyD1RawSBxLb3DmnjpGehP5l7Jm9gn29uGjazt4keSxyXtUmUxOYvTUe8
	 aI40tNMc+ESRqBp0sOSaHpIVQStrAEZWTSFFHipBhwyBMJq1OsKFds39MTNRTDHzbhuxx
	 wLhrLrUz/3A6qY9if8XVMdzOBDbC47DrJuAXGBuGsO3bidXTRsPTgUnI9LNKfrnBEtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID;
	bh=kwHs/QT4Q8au5W0hUdFDBusTL4qVOvTdKK969U4KmFU=;
	b=zvQOpxLcH9zgYIT2mI4zTbZiayINSTwxIRCl6jm+LFs6mqOKoSltQSYxf43yRn0ZQvRF
	 GSz5JLTFVIMQ6mLsSImVAdiNdOYAtn/35zMzUEuAxg3ZwtcdNN30ky3HHYMM1pOvzM+Hh
	 5pnIafNvVjyOtr52pNMCO0St2QFCYH38PMlHRLvJuJSpt3Pg+tZl+Av0tkrxhiIJvY7SL
	 mNuUF0G8j4RlL3dL7Q2XRTU9Jvfzi3GDU3KL+/jArpV6Cj6Qm+feizF3aRCGBEqUOT1Ho
	 MfEB4oVtZ7TKmI2fstykjpK6joEmqjD4HytUm3zFG948cx1YbM8DGqHvN5Bi+RK1lYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4YSvVOR;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD98606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAD98606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4YSvVOR
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso9116a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499763; x=1795104563; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kwHs/QT4Q8au5W0hUdFDBusTL4qVOvTdKK969U4KmFU=;
        b=r4YSvVOR/uwA3ubuYrZrBC+ynnnrP9qdQAnsm9uL8Le5hlSWZEp1vrkpFHwMqaXrkN
         XjNsDlxg86mIUwGLmjYbzDZng2WVeQiQXsiVh5zsvFYcPlwQYdU3oax3formNj0yhd2b
         3RvNk1QcxjNfKDPb4MeeAosEBG/X8hT6Bikvf6RlBdxEzlPxGFXUkiCcObMaqhzDT4H6
         xWDdCnpqOedBqSjamWI6eO1Q9FDHDeruytdwTqVC0TlrMaqJACmeofBND370kvOByrNc
         /vUxR9x8nPTI5A8Kh0ViDlgJU3YwaFn2Z/GbIrGDJfBA7/69mSnQRfFvMya337/4sftC
         0S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499763; x=1795104563;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kwHs/QT4Q8au5W0hUdFDBusTL4qVOvTdKK969U4KmFU=;
        b=VDEEy8ozMqXxhJm5wUSM+xWLPe0SZb9nuWMdRBtBLmJdKwWDkCHbTed7PfQoNgfKWd
         nso6qJjJDIsec3mxi7xnw58Rij9OiOEWjK1O+IBaShx3G5A3yHPo4L1xMRLD9pgES+C4
         +n90Rec69PqNsV0aU1+y0qdStbK8N9dOIOorTHckEx7ZmLTwa82pks1ql0bM9vOPCw5I
         82YtP3BGEaI0pzzFixZ/wlGNV5joqpRt827Ig1CiQa589xzSdoWRR4tQ94QNbuX7uBk7
         BalTuYXN16nwyDygxyT3/ARXmCciMDRbk/VWFyGKWGavMHwu6oS+cc/Z6od6KUeiZSgt
         R3ZQ==
X-Forwarded-Encrypted: i=1; AL+hErHteJx+7of81XqE8yP38JonVniKO6u6w54JWOHaK9eWDUpFnHr/q7xChrb259vKij6mYh7C6bw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qhZe6755NvGmCEBQs8J19NpLySYGiKLe+Kr4RLYvXnE5sT3IT
	YeX05aoS8nglcVX2EvRKdmpnKzCtIa3cW0mRq312KwzR6AblCKsB4QiyIE7FEw==
X-Gm-Gg: AYBFou0VphMin9PvivS9IKZ3gezOQHzaqpzDG4C+y6WdSWW4IHzV9SgsaM64pYJycOw
	aaGCQ5K9/zwFzP3YekcqXiGPvMzKD3Lv5ct+SQh4z9RCQqb8UQ6ncXZTzzcoCD/YtsUL2zxkasE
	f0ar/mJLn/CRw1tWnPMDJjxV9+Hh4xPknis+/jfOn1dMzJEpZlWxkkftdhZpZmf+G8mW4iw+5Y9
	iuL0fZdRH3Q8IjiaGKq40BVJxfOPxKCnZBxALi27cmnngtqyMi6PNNZlmDfcj0fKk3pVw6sAh7J
	286F50pQULLkbjXLH1HqH3zkpr5W8/+w99OE3sYEzi0g8UZ5M4FlGqgN1+KLndTEWIi2BwlggPt
	7kWGVKq8y9jJlwircl+BOOIZnRm3v7TU82AKuQJyDDL1ymXdbngvIoIuwUm1NmF3qIl6T55PVrD
	urepgcEDnlf4+kwEihZBkL6sS2BP491sTHEgD1X+Lj9JPcHINLdYgepJbR6Szo0V04HJ2GkFFDj
	zOqhj3TdXm9V9nA9m6Uvkbz970NZLB56FAyEBKJWO8I9jXDbomCNvJ0eSAqTjTxFtg3pcmPUf8U
	W2bWFsNehyC1MNnV/2Xynqm6f1bRDThDehw=
X-Received: by 2002:a17:90b:2cd0:b0:3ad:6090:a190 with SMTP id 98e67ed59e1d1-3b182f1b0d9mr6717429a91.41.1794499762715;
        Thu, 12 Nov 2026 08:09:22 -0800 (PST)
Received: from [192.168.122.1] ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67f209sm3243661a12.6.2026.11.12.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:09:22 -0800 (PST)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 David S. Miller <davem@davemloft.net>, netdev@vger.kernel.org
Subject:
 [PATCH net] xfrm: espintcp: read the socket error queue for MSG_ERRQUEUE
Date: Fri, 13 Nov 2026 01:09:19 +0900
Message-ID: <179449975985.164761.7508657205685376308.c279-espintcp@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

An ESP-in-TCP socket can have a TX timestamp queued and report POLLERR,
but recvmsg(MSG_ERRQUEUE) returns EAGAIN because espintcp_recvmsg()
reads the IKE queue instead. If an IKE message is pending, the same call
consumes that message as though it were an error-queue result.

Handle MSG_ERRQUEUE through inet_recv_error() before reading the IKE
queue. This exposes queued error metadata and leaves IKE messages for
normal receive calls.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
With the same arm64 QEMU/KVM configuration and loopback fixture, the
original kernel returned EAGAIN for a queued TX timestamp and consumed
IKE data on MSG_ERRQUEUE. The changed kernel returned the timestamp
metadata and preserved IKE data for normal receive, on both IPv4 and
IPv6. Ordinary TCP and normal IKE receive paths were also compared.
No external IKE peer or physical network was tested.

 net/xfrm/espintcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 4052ae5bbb2ea5..3e23900d6446b9 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -148,6 +148,9 @@ static int espintcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int copied;
 	int off = 0;
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return inet_recv_error(sk, msg, len);
+
 	skb = __skb_recv_datagram(sk, &ctx->ike_queue, flags, &off, &err);
 	if (!skb) {
 		if (err == -EAGAIN && sk->sk_shutdown & RCV_SHUTDOWN)
-- 
2.55.0

