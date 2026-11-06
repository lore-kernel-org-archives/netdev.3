Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794007156;
	b=ReDN8CL1mBk8mwoootJ7PJi0ieh+zqkbXDalXh+L0vSq23YFKxDi3ovU/tKIaolbU9mW
	 OO8oIK/gSpf2PmMjCI8zLoX15/7OhYz32Hg37S46kzpvgrk6qOja9R37DnURj4ofXiHjB
	 aCvzfNxkQOJVH3Xf5dKu0vJSRzkTgThVA0q7aCCEyPL2McH/+Vd54hevOABYqYD4X6+OR
	 PTaFgR5cBa9wD94n2YChV6ZwKZKfc+gFf3IzFQSgZ28tyPfmGMnfhnXpRR6QID1voW3Z9
	 vqWqy1j/QVhVsiCq9F+tPJ7F4+y1f3SNM0pNUPFZGGS4daK/1gLssUSQ5YC9rbDgLjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:From:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=GF9+6OULTMlTGJjA39dIPk+MMozaszhb0HcBIzRUEhA=;
	b=IZPwNezfHi/7mlkUxkAL6xBCnLxl5zLKHCzZbtXoB6wRGtG97sGeEXeKSUF4cp4rJyMx
	 WMljK8EC0NUEGSN+QM8syUBBUUlMCaAmN1+tAe5pbI84O6QdQNNe93AZIpwAz9NW/eoDq
	 fP+bpjhvNJRPA+mitfPgVgy1U7QBJWcdY2CBnAQF6U9QLsMltewINg2oFCWCel4FO2GAd
	 PWPyqeFrOQEd8QM5JTiS8GPB5s69Xe37/fpXKUDr0P944S7nphxn/A/echkZHP8ldF7hi
	 ek5x240P4EIGgU3SCVBBhz8goNXAEa4u0osL7xrw2T77SYUCFFEunAhlIKI7etNytlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Yp01U+8e;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D3606A33C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 23:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C25D3606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Yp01U+8e
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2463026c88.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 15:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794007154; x=1794611954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GF9+6OULTMlTGJjA39dIPk+MMozaszhb0HcBIzRUEhA=;
        b=Yp01U+8eJCH3J3+UMYkFAhNiaum4yeA+c14nA5l+G0M57xNJUyc9kVw+Hw//VOPO8l
         FOUbyoHqoVEMnVsn4qOV3cBaRroX00XiiTGu+ey08utGLQeGHl9nL2P78diGAQ1H+awB
         MTnOUgumDOdnYeu/QhrDzK2y+Y9uCVHp79pac0bjHDWV4HhCKTXCWtFrPLJeLoXiyMOK
         8Azk+gRGWDFcCkwSfrn/Z/oYUlWQe58c451lLJkctOX2HN3lAMKFH17Z9I6+THfbuWnr
         irfK5i39vENOb8Ha9T+fqsaI+WaGvelaAYOMxsmZ2UM/RHx73eRNi2Xoh2VUROB0b1y/
         JnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794007154; x=1794611954;
        h=content-transfer-encoding:content-type:cc:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GF9+6OULTMlTGJjA39dIPk+MMozaszhb0HcBIzRUEhA=;
        b=OvG6ilBqh0OXB5TLsV2FzdJQmV1tX9zth8euMfQ04BvU798HleUdupdguzAFwm60rC
         uSl8QY3VnaX8+GyZj5jOB9n79sWjVJ/kJtxB3eHoVbbfrN8INAIoJL9zaiKSgDy4vRHO
         HsKkbDSh9iWUcsBg+fOtcGn6e+Evy+glfCLV6FkHZtdj8GESqrZm5cI1lufY7el3ALQc
         9fjwoWWfxjEhHgPLzFDaEGZX10KLM1PxE7yLemiGayBX5B6/Rgx8j3l2Wjcks0gl/McY
         I8mHiokErbfhJLZOIVWf/IuBTEMKBgIGUdNcmt/fWUYE9YhyGLLDS00N5y3cFJqoUabu
         pDXA==
X-Gm-Message-State: APuU4Z92txWLc/012LVZF9uZp5bDQg4K5qHeN3AHN/HHbuI2xsnk/mnF
	w8aFSoNrlsuMnBW77kJRxWcEQ4y/2blg3/4nrAjQOged93zCQTufdifQ3+QNqF8PcLeVfgvlnFP
	oTgR2JO8=
X-Gm-Gg: AYBFou1BXiX99EM+TiJji9O8cae2eQPnOIEMR09h+vUF+66Huk4eopWoQ5FHcwkPodE
	W2itdhz+I+bEt/+lpGsc+lgXglCWbTpdy327Az1sByqrctVT5vBplGYBG7Rxng08C5wr1QiA87K
	8EBr/rGl9oi1XocvDFWzpc/sP5F0lpzbl/rInffJISvNssSz9tkIjbtFcbCGajVlMRdU8j4TsVk
	GBfnafHaUukMBf45qSPN/DZ1rZxv+nxhZnM8dqYVbEqzNJcWbJ5EVNkr/rJtT1VgCdGgyGwUIj6
	0nvmifc/ecO+BNgwDym00N+WnmQvlpV8Cn3DbvnpyVwC5OmAWHBtpgzuKjrIls/elJXfV7k/Mkf
	O/OxgHVUqetIcsaWPbReDfpPMda8Tmmv/2rz+2hXPSIBM0i122mZwmNhJDxRPqNk+w1P9ckIaL2
	vXtNKxlGjOrFu4oitlRo/URgHp87jibnZab3hHZW/GpBg/htFbTlHtzNY5IbFlm4eACvt/VcG8R
	n/seyffZ7nnRDrqIMKnNWAMVxz2Xx2npojsgnAIvAjmwAtg9DyHiYTLGpU+MnSeQ+nVHoW9rcQ1
	To8NnqxISiR0dhdKsA0FYszglztudZJ5MFKCFEOWnt/pmG2VwR1Bms8r1UxITlqANWScSLFczia
	0xuZSjQMmwRhiaso22cnYvLFj/8jzq7YzrQ==
X-Received: by 2002:a05:701b:4542:20b0:166:862b:9bcc with SMTP id a92af1059eb24-1b25d31ede1mr5207026c88.18.1794007153727;
        Fri, 06 Nov 2026 15:19:13 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4e079esm9906096c88.19.2026.11.06.15.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 15:19:13 -0800 (PST)
Message-ID: <f084de67-85b0-4759-845f-513879ebee5f@kernel.dk>
Date: Fri, 6 Nov 2026 16:19:12 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] net: leave O_NONBLOCK to the sendmsg and recvmsg syscalls
To: netdev <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

____sys_sendmsg() and ____sys_recvmsg() turn O_NONBLOCK on the socket
into MSG_DONTWAIT. That is right for the system calls, but io_uring uses
__sys_sendmsg_sock() and __sys_recvmsg_sock() for a blocking attempt
from io-wq as well, after the non-blocking attempts with MSG_DONTWAIT
have failed. On an O_NONBLOCK socket that attempt can't block either and
the request completes with -EAGAIN, unlike IORING_OP_SEND and RECV,
which call sock_sendmsg() and sock_recvmsg() directly and don't look at
O_NONBLOCK at all.

Move the O_NONBLOCK handling to ___sys_sendmsg() and ___sys_recvmsg(),
which the sendmsg, sendmmsg, recvmsg and recvmmsg system calls go
through. The io_uring helpers then pass the flags the caller asked for.

Reported-by: Luk?? Lalinsk? <lukas@lalinsky.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/net/socket.c b/net/socket.c
index 2e3b5737c481..08658a9b8065 100644
--- a/net/socket.c
+++ b/n	
@@ -2697,8 +2697,6 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 	flags &= ~MSG_INTERNAL_SENDMSG_FLAGS;
 	msg_sys->msg_flags = flags;
 
-	if (sock->file->f_flags & O_NONBLOCK)
-		msg_sys->msg_flags |= MSG_DONTWAIT;
 	/*
 	 * If this is sendmmsg() and current destination address is same as
 	 * previously succeeded address, omit asking LSM's decision.
@@ -2762,6 +2760,9 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
 
 	msg_sys->msg_name = &address;
 
+	if (sock->file->f_flags & O_NONBLOCK)
+		flags |= MSG_DONTWAIT;
+
 	err = sendmsg_copy_msghdr(msg_sys, msg, flags, &iov);
 	if (err < 0)
 		return err;
@@ -2926,9 +2927,6 @@ static int ____sys_recvmsg(struct socket *sock, struct msghdr *msg_sys,
 	/* We assume all kernel code knows the size of sockaddr_storage */
 	msg_sys->msg_namelen = 0;
 
-	if (sock->file->f_flags & O_NONBLOCK)
-		flags |= MSG_DONTWAIT;
-
 	if (unlikely(nosec))
 		err = sock_recvmsg_nosec(sock, msg_sys, flags);
 	else
@@ -2970,6 +2968,9 @@ static int ___sys_recvmsg(struct socket *sock, struct user_msghdr __user *msg,
 	struct sockaddr __user *uaddr;
 	ssize_t err;
 
+	if (sock->file->f_flags & O_NONBLOCK)
+		flags |= MSG_DONTWAIT;
+
 	err = recvmsg_copy_msghdr(msg_sys, msg, flags, &uaddr, &iov);
 	if (err < 0)
 		return err;


-- 
Jens Axboe

