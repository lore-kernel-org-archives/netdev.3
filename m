Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942398;
	b=TWgglPM4FKWBD+S3j+OE0oYQE8DM4GeMuVi3aVAAfrEw8hhuKtQOnYc/U7Zx07uenWU7
	 oeRJ9wG/XLCpDU0cAJt1ZMcX1vrH9I/rJgw/GmyHUUSHYllOrKRIo5ZEnbZVBw4CIl82B
	 Nzb5BAi0xOKGA526jnBzJE8+SdFU8hqn4LImys+hr0rMzq3GUCo9Fbx6r6kwDo8Q34wgK
	 8w6a2ipaMzeDIr6lxqbqlOLXTbWWImT4nqDJ9ZmlbWBLASmlhj18wI8QYba2VImUGt9/E
	 Bpy84++jfJgboiCyKkn7qNI4j8tYbktrG3HVWkVTWQ7Ppr1etA+XqAXdk6+a1l7FmkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WyFUIdytZZnZeMSTWUdvYVpPSUKrw8J/dYOPFJEp7Gg=;
	b=nQVKdbyRSnQH186RuHXGU5ziTbQGUe6OKyfAxwbfQy/riCoBSSRFxZIkVFe5wwjBqaAA
	 w5RCPbhBqkZEugMBPgrZOCnE0lIIJzAhU7hrF0xXdOkdDY3sfVvAT7h78cYPn575+MngZ
	 chOXNVO5DsjGx5gZMQe3PqCOTufqh1tLhXuxWmliWi0RV8NOXbqvG/S+laeJAcQ5NXEb3
	 ckkrmZ5p4hAGjkRCuhbIMmBe6juHPXhOOOmnr3/Xyt75ed55yYA6grTT6NEX8ykN2YIuf
	 KNmMIQxOY0hHvFVYqhSchgBNHErm9iXrI8oBqoupjpuOFG5SfAh6WSeAohKL8bhCoFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+Uq06TZ;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB66606A33F
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 05:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CB66606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m+Uq06TZ
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d7791b00so1635205ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 21:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793942397; x=1794547197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WyFUIdytZZnZeMSTWUdvYVpPSUKrw8J/dYOPFJEp7Gg=;
        b=m+Uq06TZrgkYbYCHL9DYUhOfI7OXXGQ/XGe+HIg/Yl/9gU4OVMjrnifav3P7LJN6qS
         Ydh3IxNyIN8QcpJsKLREom6SnbM74H9Axejd87mVVSto6GLRKOgFSAtg7Q2L2yfBk6ca
         o+lC6IIyrOoopaPwo0khtwK6uvAoo54DsRs4MjNIoMx0l9bpE4GKfhIwovF/O8/qy44G
         /68V64cP57nl15tnsUw7pLcqxhNAT1e+UwpkVWEZqlez6ORks/NhMKoKfdKRtnRTTkzL
         vdQsphKoqpSkUQiv5Ox16IQajdouxkv+wRgVzwcCzlXvNKMPGzdxMuhIu2htsiGXqTSb
         C1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793942397; x=1794547197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WyFUIdytZZnZeMSTWUdvYVpPSUKrw8J/dYOPFJEp7Gg=;
        b=fQiHtl35yxdqRLMgTpYxMYrwZ/dOq3hxHlChUPmfH15HmSxOKpCIbbIw4Bg+fIW/F+
         1kSCpjQIPG/ICJLngf9fNvvPqmI6nFoiVC7nZau+yjpwwDjvTOq/QnlHISoBLbXoc2TI
         HpbS/Ezq8ecPtrIwpnKFtogthQmPCDN5POmolTWDJbsLLDFyF6Jcjn7unnBou3nwvsCp
         FPwkkQKeLMXGqlGCEr7Jqm7TBxnHo76GZDTT7wSkXIlbDmKp12LyxZCCvt3PfyiL+kJy
         DEWCNXPxbpA/Sv8PLxmqsJaAqkqmekm3hXN2EVPizETS7LAegNNFhFUll3v6+dw85Zhi
         OoQw==
X-Forwarded-Encrypted: i=1; AKwUvBwrsugs6Qs8UYHG02CXsPk5qp29WXd3j6ebSXh1MC06XmUG7Wr4eZlklyFjYoXQQAiLT8V7Qzo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8laGBgBOF6RY3Zcu+uJhYb5wij8XJZ/YEFQwju1gpHUmCjyHQY
	ImRXNT3bWbWYo0ONL5Ovf7/kB3vf0YaBVG6Zk0+QkmsvbfCHDCkobynz
X-Gm-Gg: AYBFou0QEt/B4Xe1FiP/2lDCRBELwYwTnaykEF2iz3fIGqXK+8TvwjN+83upVPzLUMR
	9AJZ28p8ZSQU8SecOcVWlgMEtXRckt5VI1DYcEiiV9ldhXHi8GAk1iZ0kJJOSN69f/WsGs/KQX8
	SdOFZa3qFsIgMTpOa6vMY6c5eDGuQK7PC8YnbqCIPD/3/L4VBCbNuhw0j2U9Pl+VkFcWrP5yYrb
	E0ji57bgwL+xBudYXPU6bNk8sizIQkZbL8AdBY7PUDo1olJxRryhHY+UJWsLY7sQjY/AKRyfbhx
	JGcDMtv9ZqhlpODaneZ2+oBwEc/eTJYSTMAtBvWKWuUrpI6ur+V3PbJqcoq4G7fRxq8EUhtkzXu
	XZ+2Hea5/dNtWVOiBoScim58azThyZM8Bb3AYNsxMfr0OAOvlLezqGaHu67B7Hu5wt92rXVHxad
	AssR/p8aRuGLEmqx3FfCz1WeHEBB0cReKdtjHjsJNnyukwFCpDZJbhsxaXvw8Cbm+KF3NyJo9J4
	ny9Dkk9o3Uf7rTrP1qjcNwdSPyLK3+uQGQd6bAuXDuTbtmLBNM2MQ1TGcH0cHRwhQ8B5LVxLPwr
	B5T0nqgVGgqKODPRbvCXU19XLwUUz2Kx5KvuQVUtWaaesB7YQ1wLBQJZd6bpDsdMpd821xWL7qD
	aQv/2hIur59A0SRUT8oSwuu0Qa0X0xYYNPM2Ve9iAFxdkqgZUptlgx8lSceIcN07Kt6ud2aZ4gm
	NmgZmuBxNr05WibRkB/dxQl30ZGMeo00v6YrAf0q33
X-Received: by 2002:a17:902:e946:b0:2e9:4bf3:37a1 with SMTP id d9443c01a7336-2ed40dedf76mr21903265ad.63.1793942397302;
        Thu, 05 Nov 2026 21:19:57 -0800 (PST)
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
Subject: [PATCH net 2/4] af_unix: Fix scm_stat.nr_fds leaks for OOB skb.
Date: Fri,  6 Nov 2026 05:19:03 +0000
Message-ID: <20261106051905.218638-3-sidchintamaneni@gmail.com>
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

When queue_oob() enqueues an out-of-band skb carrying SCM_RIGHTS file
descriptors, it accounts the inflight descriptors in u->scm_stat.nr_fds
via scm_stat_add().

However, the paths that later free or skip an OOB skb do not call
scm_stat_del():

1. In manage_oob(), when !sock_flag(sk, SOCK_URGINLINE) and an unconsumed
   u->oob_skb is unlinked as unread_skb and dropped via
   kfree_skb_reason().
2. In manage_oob(), when a consumed OOB skb (read_skb) is unlinked and
   freed via consume_skb().
3. In unix_stream_recv_urg(), when a consecutive MSG_OOB read unlinks and
   frees a previously consumed OOB skb (read_skb).
4. In unix_stream_read_skb() (SOCKMAP), when skb == u->oob_skb, the skb
   is unlinked and dropped via kfree_skb_reason() before reaching
   unix_orphan_scm().

Because unix_destruct_scm() has no reference to the receiving socket when
passed descriptors are not AF_UNIX sockets, u->scm_stat.nr_fds (reported
as scm_fds in /proc/<pid>/fdinfo/<fd>) remains permanently elevated.

Call scm_stat_del() before freeing read_skb or unread_skb in
unix_stream_recv_urg(), manage_oob(), and unix_stream_read_skb().

Fixes: 2aab4b969002 ("af_unix: fix struct pid leaks in OOB support")
Fixes: 32ca245464e1 ("af_unix: Don't leave consecutive consumed OOB skbs.")
Fixes: 965dc93481d1 ("af_unix: Drop all SCM attributes for SOCKMAP.")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 net/unix/af_unix.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index bfaab7c6d720..44c0a81dd423 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2807,7 +2807,10 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	mutex_unlock(&u->iolock);
 
-	consume_skb(read_skb);
+	if (read_skb) {
+		scm_stat_del(sk, read_skb);
+		consume_skb(read_skb);
+	}
 
 	if (chunk < 0)
 		return -EFAULT;
@@ -2867,8 +2870,14 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sk_buff **last,
 unlock:
 	spin_unlock(&sk->sk_receive_queue.lock);
 
-	consume_skb(read_skb);
-	kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
+	if (read_skb) {
+		scm_stat_del(sk, read_skb);
+		consume_skb(read_skb);
+	}
+	if (unread_skb) {
+		scm_stat_del(sk, unread_skb);
+		kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
+	}
 
 	return skb;
 }
@@ -2906,6 +2915,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		spin_unlock(&queue->lock);
 		mutex_unlock(&u->iolock);
 
+		scm_stat_del(sk, skb);
 		kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 		return -EAGAIN;
 	}
-- 
2.43.0

