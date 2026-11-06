Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942397;
	b=Pldqt5cuLOTSL4y+wx6zjgbQWfSWQQCBqYB1b+3cM/wn6D13P0mfKoqscZNEfwSJJ7Q9
	 0P6PQEv/gNKi9CXcywMwzFV7zYCoz+ArVfVjRfqJVLmVnMQ1Q6YnMu3ddlDcD7T+djYTB
	 NFhZ8qoI8VWhKWHLVb7U3GHnheq+CRwW9T4KRmpg/rH8Ks+5RMpFKxH19cII3KRluOHDV
	 OYb0MeP2eTJJrxQhQ9DN2O6LB+VD8Ea8b4efyRfLpV3FCpVRaqyiQOqlK4obGexfbmArt
	 0O8EGrm4g2gUlERe93Cg8oIg5cjp3lyqdoi/ut6/OdyztSpsdAeo9Mo50SOQEFnQ5Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EhvxgM4OU3wkthv1IWxSDKnI9mH3KYqlfOb3SM6sBPU=;
	b=Ln1AKA/IAJA9vHSJEwHp8IeL0RB7Sf/6bCRrlySgoZrMCt5KFKB1JXo38ShKQ68fpGOn
	 wNSfvBkZ0PPMoOPnO57LKFStkYBUb5ZxkmVRDVkJkhnhEYQ4dliNyyg8b/VToh7KwVym7
	 mRi97dHZgELaAB00+wteoCVsRCKrwrIQBJIc/Z9jrvVu0HtgBiCMm8wangVfydGXfrHAL
	 jSYCQtqCa8Dhs4w7r2mOETXEn+GJc1iyTp+lhHmcAvH00BzshhyN7+9aeTRxbqPJyguYK
	 DsWhkd+5UqUGHJ+exsWy8jTYZgSZvljLJ4QVRDq/Qd6ihGJpowrO5i0VCQoYUyiLAcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jNE0BwBp;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF2606A32F
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 05:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52BF2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jNE0BwBp
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9ae391a05so1682925ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 21:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793942397; x=1794547197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhvxgM4OU3wkthv1IWxSDKnI9mH3KYqlfOb3SM6sBPU=;
        b=jNE0BwBpc/e7lmrNSiB0iQ/tyWQZ0whAica8HVjPbf3YT8WinM+PNzp2uUyvLpRxB/
         pWmeMlkaULtOOo2rcPN7mr98adfqyC8rAiDhlL5S08sCeq/u2UhuE6UQNVyIBPFikQtt
         VZ0BJrTbpPsmFqNdKrSVIZyiAvYRTRugZoC49u9eVJAevGNAELm18oNLJJjyY6T226VU
         ZsJWQlUPzaOlU6i9uxXrElJagj5G+2Ox4/Z+OmijG5vxeiFnNRj5dhUlfie1mKesnWAR
         bo/gPr8W3I7XLc18Jn/NQevyBB//FQPXmvEpdcdGgI3Yfk6fi0jkwWiFloZnJJRwQAVW
         fMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793942397; x=1794547197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhvxgM4OU3wkthv1IWxSDKnI9mH3KYqlfOb3SM6sBPU=;
        b=n65Y77CrUttHsmB74O3bFNcI4hJ0Vp16e7+NshLeOBgsr06MiGihi57oYN8K1zhIb2
         tBLqpH+tzwZzadSR7/deGn6YAenJDBYxeUwb61hQl2qm2uu/4jzQaszBL33BU31CZGmB
         ql6XOmnEmVe9nDTUZM0cVyNgXrymUUftQWfm2pcFaHUTfDtRovs46sKJm+OQH6cUy4LA
         xKeXuxdjARcd8MhZV4qLR6IYnJetnBYAL2Wb1eN5+YgBpalsNL7541rTPgdOqCP8hBeC
         yBWFw8esaNHb2dsY4UUVj67+GrfZzNP0QKWJnGywFGzKSjbwm4sr49ZS712vY5siOfwK
         DAQw==
X-Forwarded-Encrypted: i=1; AL+hErFmKpVtNch1UcxKJpI7kYUbwJePG/o2SumZAHEGSruZAUtwdYuTDElKW0rJhX3LU2Ip6G/tFaU=@vger.kernel.org
X-Gm-Message-State: APuU4Z88nx6S4oeVThJLc6TBbT1kXA9YMOAhM6L5IjimQxaSlzcth/Af
	ZB1yefH0Khg45WyKivLSxkGYnnVj6MQy58UobXfHAAtYPkZOcwf6ff88
X-Gm-Gg: AYBFou25D5FPs9Ufr+E9tKUMPmqF07H8pZ9LDMhoeqmsh9vjWjoe3kyry4w+F9WCP7I
	W0DTtc05JEtO2LlG1RPgPK0sLF+D5t7i1jd9acYcFeP3KYIE2e4pkjch5jZZjKn8pq+dVzmTiAl
	20EJFXYcQAMN7avDFs+LXCrVPVLMIGeOYndDMN1lYU/f0caCZhbrrWF7HEn2w2KYIVBbzoxwc51
	U91VWtXLk5DmTMHgd8NnIyv+sgCMknJE4p3r93GwaVxT0EIWi4b1Exsyn7Vuf8xqKMwUbpZdKDN
	k5a+MwZoa4gWuTqrPqPuDPzqo9iPGh/gt9gFCMS1H0yrQhAuOPQUhkZfRm7nbHmLNrBNlZ/01HK
	pCq6XClAdM9AtTs9B6n3t/z0N/V91KOjO6Y5PgO2BzwwntEkbI7BnBN94v5YLul8Au0y7HHwfd8
	wTxIp/fRAa0DjHSeEP0hjqiqam5ctEC2h8v36PDqBp9c0Qf6ZZkcYNlTHgyW1BWjG/t/6C1couj
	pim/aOZ9GY+rWS8dEiZ70ARG5jKBOVIRnCFyclVr+X9QAzzcD8+r/7tA/8fyhpcQ85BSel4M8/n
	YXiHTqB9O7Ru/kA+UjGF2jlHWu7FzneNtgnlGfdkpOoCQ1wEpiZdtMdZpL6hngvYfFLadh2K9jX
	QyaglkfDhnVmgun8Y8PArNQ55h/55mIa8jJ/PlaBL56s6ZdN9G2zu7t8ViapDhEDvkuiwu1kDmw
	B5OTx9r46GBj5VMHzQinU2Fx+fdsXTdUHX5h/GKdp5
X-Received: by 2002:a17:903:2343:b0:2e5:1069:fc11 with SMTP id d9443c01a7336-2ed23e53491mr32343595ad.1.1793942396545;
        Thu, 05 Nov 2026 21:19:56 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d7bd2esm1594465ad.56.2026.11.05.21.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 21:19:56 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jann Horn <jannh@google.com>,
	Kirill Tkhai <tkhai@ya.ru>,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH net 1/4] af_unix: Fix inq_len leak when skipping unread OOB skb.
Date: Fri,  6 Nov 2026 05:19:02 +0000
Message-ID: <20261106051905.218638-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106051905.218638-1-sidchintamaneni@gmail.com>
References: <20261106051905.218638-1-sidchintamaneni@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When queue_oob() enqueues an out-of-band skb onto a stream socket's
receive queue, it increments u->inq_len by 1 for the OOB byte.

If !sock_flag(sk, SOCK_URGINLINE) and the OOB byte has not been consumed
via MSG_OOB, a subsequent normal read in manage_oob() unlinks the
unconsumed u->oob_skb from sk_receive_queue and drops it via
kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB), but fails to
decrement u->inq_len.

As a result, unix_inq_len() (reported via ioctl(SIOCINQ), SCM_INQ, and
sock_diag) remains permanently elevated by 1 for each skipped OOB skb.

Decrement u->inq_len under sk_receive_queue.lock when unlinking
unread_skb in manage_oob().

Fixes: f4e1fb04c123 ("af_unix: Use cached value for SOCK_STREAM in unix_inq_len().")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 98fcfd7301f6..bfaab7c6d720 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2853,6 +2853,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sk_buff **last,
 		WRITE_ONCE(u->oob_skb, NULL);
 
 		if (!sock_flag(sk, SOCK_URGINLINE)) {
+			WRITE_ONCE(u->inq_len, u->inq_len - 1);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			unread_skb = skb;
 			skb = skb_peek(&sk->sk_receive_queue);
-- 
2.43.0

