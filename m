Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794009050;
	b=DiqvZwcKgXk2ebFjG9VAcIBGEhNktkxT6TQyatfCrnakzTc5n/ff6k9mSfEZtE3bLPVn
	 AjsYKLLjQ7cu0YDM5/IcQA/fJuJZ1aXrLwq5imKz/hwpbaD+Sjoxa1fOKe2tnebwOcCje
	 nsHARvM7JYxLThZAYEnjijXeHr9+NSHFegK/RnPIY+9dwY0WE3Co50dBhT+PdzKIM03xI
	 a1sdWq8tJc7dBxKXijnkIEdcxOal2ZampXMP6LRIo12iI/3sqoGi5EIO0Rd2tnfc4OUbg
	 oyvKnXz9pN1mPqIMmulgs2SXjoK6hPWhD/5omlV+fnHyJaIynAKrEgnOoPrlgHixUfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794009050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=5PzybiuiQkcFi5cN12RhQIKdoWLcgU5vygHaS5A21L4=;
	b=k8pN33rJAnvzenTDRh7fB0UdZs0PBZGGXy6HJiR1T6YDzUEpHuGf4GfZDR7DQzq7dSsC
	 XgwjnJ6Hip24mbOlhLVC07jGVX0FCwGDzt//nkj39dLnk3gsJEoXRBwT9wsIWvfvUleto
	 31E68ozrmUTC81Yi3B2ewHE7t/RhOuP0LOpvZ7l1T2iM2R6Wl6vcxQRNZpEux+4nkNd9w
	 FL6f0PYZ0X1PZ0btwuI+WAlGbjgrFo/XxAHJPIM2hhgk1wyniliTEwOfd+ZfZ3k10XLmC
	 JETadBuVR4ooZhkLMEjSLGvQyV03b6vWpt3SxMfOLSWs93KRPb946mqnIsN6xOR5T/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZAwAw560;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B0606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 23:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A70B0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZAwAw560
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1906017eec.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 15:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794009049; x=1794613849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5PzybiuiQkcFi5cN12RhQIKdoWLcgU5vygHaS5A21L4=;
        b=ZAwAw560MSCOmWFrjTFtcshWILcdGBxA9ec4/QPEPKH3MoTQ0ts5HQsvcOnXrxPFsU
         2wMcHitpLdHdbeVPKH2VXSQE1J6lklENbobUK6dS//3qBKagYFt/v3UzQ+0nMSl4eJ+n
         /YnGxYs3sf+x0udf9nkLtlbOV4A3sB8Yfqeit1yLBwba2s+ynL1k3CzXIHXyq3qIle+h
         UdCVHkRra81QqfY3ug4X1Zuts2lzMqeYTgNaVqO6bjWfDiG8lD9aJdyjeANgmO79G6ww
         suf6KgsoKhRAoeN0WTiI0zRZ9UNR8KvIW082XfqpdkDWlCHjQFpXcW8C3IXZkc5xFNjR
         gpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794009049; x=1794613849;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5PzybiuiQkcFi5cN12RhQIKdoWLcgU5vygHaS5A21L4=;
        b=2SpTW+lNZJ+TDmWV/uagDHlG7Uluc5y3UUyu0EdpK3BezwVO+L/960GaifYBFJffTn
         nbQblWE4ymWAv17SxqFv/fynyRsVlIm+ZPkSI6boJ+XpIFJXqIOOXOR96qb8hMzitoSp
         K17XxH1CB1xt1QcKVgohQiDs5mJ7t74Yb1XhJFmtzdvfbtPWgWHH8T0iscTjxULpS0rJ
         MfTOu55sNs4A8HL8Su+jE1ze14VZ2yZs60r6bD93RixRX45Mdsm0XRqIJq9gnDSpKbnn
         4ajUN3E9KLynd3+WwgTbA/gGyWClSO9iHKu9poaGOmOPMVykkJagdfRZ9tT8FV2yXsBH
         aoQg==
X-Gm-Message-State: APuU4Z+SFfkHohHLiFnZRFYU6Nb44KcIR0nhkMftzX0TNz21G18w/fp+
	RHVCVPc+4Y4nHZlv23qChRE4oPjk+rM2///+myNffZbO8t5WX7DheeMhno6xk+Bl/7metwfnXHM
	C54yAjj8=
X-Gm-Gg: AYBFou2MH/ZFZlZpoxGLsPwUZ+C8nSQZYXUkHJUKqdjWAhplpIbN9G+YMSPjXkY6fzx
	BtfcNsLboIpEk9FoeViS6/03ZQrQ7uaQb/yF4eDGMwfJB7c0+PbkINGLI9jM8yBJ7EVK13TrDHh
	3UpCS9me7eJ9vPsxs/s0084ZasxB9wdlVN0g2EZQG6zplBrn0IR8+/Rnhi95lbz3qzp44gLZSLx
	OiGBm5zXzIngmoq9Axi8AZaDmNGZMJ+Z0A/KHmpm1cEarqzhGZrYRt38VhC1syy5fcsJ41mLgGb
	idt3Zi7QxVWSLEC2jsrYz4ynowhdBmU2RAUt83OoYkuyuSn8E3NNMdcPx8/DLLK40PR3wKGfUSd
	fmNRVMyg/KTgdhKydJhqEhfbpBs/CTviscLjnWOkLI9V1vFmQa1a69vlrQR57gYwBYKiLJzx0NE
	GF0wtVxcNcTSg4T8t7t7pHPApaYgxPZXF5EohEAbLlfOP5/BBpNKRDOJxryoXlUppWg1GdB6VQR
	Y4yTp9ogTmIfnOieMNkRf3eFjzJFNQdmNiXdDi9rrWekWKOmN29SdNbceN4QzoJDQ6AImBZqJoj
	Y+wKSYG1N85e3lM6Cf1NiUPCgk7Mddz242xf186r02eJDCOkPDxI1Np8fmrVPAv/UFaXQQn343e
	ErVlsa6FlSFw=
X-Received: by 2002:a05:7300:de4c:b0:36c:b7b4:407e with SMTP id 5a478bee46e88-36f772fb5b8mr5771871eec.22.1794009048437;
        Fri, 06 Nov 2026 15:50:48 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a47esm12686777eec.6.2026.11.06.15.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 15:50:47 -0800 (PST)
Message-ID: <691880db-d6c6-4147-8509-93fc76125d29@kernel.dk>
Date: Fri, 6 Nov 2026 16:50:46 -0700
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
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH net v2] net: leave O_NONBLOCK to the sendmsg and recvmsg
 syscalls
To: netdev <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Cc: stable@vger.kernel.org
Fixes: 0fa03c624d8f ("io_uring: add support for sendmsg()")
Fixes: aa1fa28fc73e ("io_uring: add support for recvmsg()")
Link: https://lore.kernel.org/io-uring/a5589b66-9a20-4b1c-a0f1-1b5b31af3667@app.fastmail.com/
Reported-by: Lukáš Lalinský <lukas@lalinsky.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

v2: add fixes, CC stable, add link, correct Lukáš, correct subject

 net/socket.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 2e3b5737c481..08658a9b8065 100644
--- a/net/socket.c
+++ b/net/socket.c
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
2.56.0

