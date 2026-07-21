Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566045BD4E
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651110; cv=none; b=NHW3rV+K/K1c6CHLlAh0VslUCODGLMTxOyNsZ46f87oZ07DhpxNi4Az5AqJ3RHfDwQcPRu5dkAeV7tsE67xodfh615foBcilADgM9Xe3bxcLTr1P+dD9Wh0qBo6S0Zma509Uooj8N587Bk77cbHrVj2Q67DX2z7AOOR0Ruk//Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651110; c=relaxed/simple;
	bh=U7C784crcEPbDrh79YM3VK4c1Sg3otpD5Vp+xQPVcFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWGKsYbdLjOZi08zP34ooqfHDVX1pW3W5uDnZ+VTNLKiZRlrLvk6bj70v+6adKqHKHEDe5A71CwcnaXX0Plf7rh61HocXLFv2BuVlAOuMVzi+RLt9y7NWab2dqAf8HmA4qaI3UbRCPfza40E9GLwCP0nCh7G96AVIpT0XcSGkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L44nUZGo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L44nUZGo"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacf197759so133398705ad.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784651108; x=1785255908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hwn3D3StrukneWS3ilqBxZ7Z391KBO37xUeJwrm2AX0=;
        b=L44nUZGokIClfe9cZv/KB68PULPfE7QVcmxl8E9I7rQd0xFrG+EY4YL8c4UiJaEWrP
         z+8GSp4Jt2F5IjrXwL0SpvO0tdDGdLB4DZ+Vy64vVCbAvk1DqsIkXMqrXktlg8wXvN4g
         aNnLLnRkUWBUg7DicSvz0j8uohsinyoBE6e5T0H1OnWux3Mo2+xmtMYK7L4s7Weh68vl
         L/YT+C1c9hdCGPFKL+tpx/T3di18u9OqrczTfed2gF4VYPr4rlKPyRfCWJPJ8DQPv2TE
         NtBO11m5gvqj3gzeuYmPZViLFWPWkBKSQMghtrJgdKIpaFqQzz7x3UBvMuV5yIj6IjPz
         XiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651108; x=1785255908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hwn3D3StrukneWS3ilqBxZ7Z391KBO37xUeJwrm2AX0=;
        b=hy6oFY3X2pXmuXPnXCElwWSCcpYu17aoq9aXw7ShH+JYkZ3K4oLkHK11jnp+OLl1C0
         6BuLmPa9IuG4+5WV8goH754NlkE0+oD9gZcI8cSpYtkXBEUtagiiUMdBIjmlJX/GAMs0
         YRVJ61ik9GFLqsMYcciaMrbciySGitob7oms6gw6jlMsPK4PSCNpqA8xpTvx2AzhGMl3
         qmsvn4LUpTgGF144FVj0hdgi9RVslfJXQDc+G3O7R4NR+RdCksLs3Ogr7sXjsDkO2oui
         KDStv4/95v2N/d7NqAx2zLZes86d9YxDU61S/+ztmePmaDBoh5xsqmuBI0X4OJthmkGa
         GSBQ==
X-Gm-Message-State: AOJu0Yw9CfzjhNGWgtlUOiv/gaXdMQoY7vq9J5sPjFOvqzfyXn8oRE6N
	XJrO/JklJNwDLAmLro3jh1auaBJy9WBwxgih5BOV1LqLO5dFDXicgjuOjGF0Y09e
X-Gm-Gg: AR+sD11ww9+oRs56cCkT5plWBT/S+RD6sjX7C9fTfs7fRVMSjjazPY3h1zAiB9gRQG/
	IVizgW9v5/jML71TasrnBtkdZ4y+ft5dUxyxBMPwtlKSp7K9D0QBZEDe/gKhbbQ2l1q/Fl6/FOZ
	Muedd2+aL/6+VQNHmaDKVeSpxKmICk+h9dszQjge++l5jtq5jX46qBmtcDCi+MMVOIpCRSqlyWy
	JsXhzMzik35Vt6Un1abgBgsgU1a5BlcuR4iRg96LHFiBPnUtr9DSxllpfrE55+hDLRocAfp7KzU
	05KAKYni+F4bjubSJZWPsMhFTNQ/qpgDNPPhIDDTqcGGJe/koSrtpYQA2H+LDJOf/SouFPzQg0C
	2iMCpJbpPhT+S4ENaOGgYTCyL5lB5oHyZG20Auwa9tklqjLH0mTwfIEU7Ie0lBCVbD8QPp9Cwm3
	oDn5FO2yHsFlFsKL2a1w==
X-Received: by 2002:a17:903:3807:b0:2ce:9439:59a5 with SMTP id d9443c01a7336-2cf349a15c6mr197282425ad.36.1784651108142;
        Tue, 21 Jul 2026 09:25:08 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3471f42csm78836985ad.61.2026.07.21.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:25:07 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	tuong.t.lien@dektech.com.au,
	ying.xue@windriver.com,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH net v2 1/1] tipc: avoid use-after-free in poll trace queue dumps
Date: Wed, 22 Jul 2026 00:24:54 +0800
Message-ID: <b0e80e22320459e0f4a3afb30c0c02ab2df03003.1784642230.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784642230.git.xizh2024@lzu.edu.cn>
References: <cover.1784642230.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

TIPC socket tracepoints dump queue state through tipc_sk_dump(). Most
queue-dump callsites already serialize that walk under the socket lock or
sk->sk_lock.slock, but tipc_poll() calls trace_tipc_sk_poll(...,
TIPC_DUMP_ALL, ...) without holding either lock.

That lets the poll trace path reach tipc_list_dump() and backlog head/tail
dumping while another context dequeues and frees an skb, leaving the trace
helper dereferencing a stale queue entry.

Keep the existing trace output, but serialize the poll trace snapshot with
the socket lock. Gate the locking on trace_tipc_sk_poll_enabled() so the
hot poll path does not take the lock when the tracepoint is disabled.

Fixes: b4b9771bcbbd ("tipc: enable tracepoints in tipc")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
changes in v2:
  - Keep the existing queue and backlog trace output intact.
  - Serialize the poll trace snapshot under the socket lock.
  - Gate the new locking on trace_tipc_sk_poll_enabled().
  - v1 Link: https://lore.kernel.org/all/24f7311aed0c9ff06b8ea982647b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn/
 net/tipc/socket.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..51692c4a0e47 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -794,8 +794,14 @@ static __poll_t tipc_poll(struct file *file, struct socket *sock,
 	struct tipc_sock *tsk = tipc_sk(sk);
 	__poll_t revents = 0;
 
+	bool slow;
+
 	sock_poll_wait(file, sock, wait);
-	trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_ALL, " ");
+	if (trace_tipc_sk_poll_enabled()) {
+		slow = lock_sock_fast(sk);
+		trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_ALL, " ");
+		unlock_sock_fast(sk, slow);
+	}
 
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		revents |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
-- 
2.43.0
