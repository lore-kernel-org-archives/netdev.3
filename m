Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70A391E57
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856262; cv=none; b=i+ui43HWsg556luwynrwnsxgI8s7S8IY+gkteYHE7xEtN75BUpGl5bhEWFyWK5PxM5MINVGzB2OisgcrynsBDGiKEPtm05cyOswbvIMzI9zvAZKMOOy726tmDSJbu4gl+9YmnhB9O3J6h3NY40lRv78Q2P5Odwj3IN7GD1/LxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856262; c=relaxed/simple;
	bh=a5Y2KWWWwAi4V/RQWwZJd/MSE+q2UPPC+lrYmqC0FlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNnguSkp0QQOHepSOqyq7I68KBcDBheNnnHmD8m7yhfBORyX5hoLVCRSnPisj7avNxXsfcbwGkD13Jar8pRHbruKZPrhbLdQ4BtS2YhCTbXGX/O3CzKYwZZ26aowE1Uht9NfgwjPrijrwX+2aIEt7aojOBoxR2NOS2ApIZzkDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLRMjMQH; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLRMjMQH"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc50d1b048eso1590575a12.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856257; x=1790461057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zj1nZb9yBa52W3cqUr6hajKJjyJRC/rB8Hcxjxs1Pyg=;
        b=BLRMjMQH5e+t9Co4fUn+HTuo2zmqpvQUnRLkmUFbcDce+YdIaN/t4OGvYZimZF3z5g
         kqqKgm3cJcH4+JcolWRHbH/wxFsVFdsuXtGyjGn88E8vB7v7b/IAPZAHBL0FxodGQy7N
         XqcQG5vtLyBvFI5d/Rp3JwjdCxhcJfqD/oK+o67h1/b8K9UPxUdKCKhCXcPCQKkPxgJM
         siMG4HqiQhdEhznsNS/y5WEQGXONQ16tQOhY0sIMApfw9Kbhd5fABJX+ujpnmUhOIpZ5
         DuiRm0ojyR+cCOLP/NZ/Fg9228llnQw4Rn3BpOMqda4r3uN9JQFVmXkVThwtZQ+KHfgZ
         CCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856257; x=1790461057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zj1nZb9yBa52W3cqUr6hajKJjyJRC/rB8Hcxjxs1Pyg=;
        b=ZYyHfCLZsyK0ytsPopwWxbSEWo3y05ijAf1uoxmUWA6SFqh5kx07CxutYW9TDjAwY5
         L/+ncsgzj1G6vL6fOngEofJ4mvcWtgN+qtMS0kiUa8eFS3cm6RRuwtsmP+zRw3a/7mU9
         cq31t13JIhvLtZaBqao8riDYzkmmzunvsOno/WNjPLLLMG69vuZpKjV0Df2VaWjs9tbV
         ycUvi8iBrzapeTdylUXejZvM76OMXc1RbvAHv11DLwsXa0ByMMQ/JY0dnTHWtffOye41
         npCJb6/94PFtlRG0NankB25vMfAMS10BYNKKI0qNfSQnxeaVUzgjaqtdoYWlfeO7N0Jb
         coLA==
X-Gm-Message-State: AFuF++nVYGiljpp+fEQDaDqVWL92W+sRgSfbdEKBwK1jbdnP6H3XuNuQ
	PqxRJkrImvTpROem8Er40X/jJqGsTjknrW04RdB9HUd14oNlIx4uoeyu
X-Gm-Gg: AYBFou1FedZQBxGDflbFlCl+ZnMIUgSdt+dFZnEtkMp+FNu3/3oeWxhNV04GqlixC/8
	ZW4GfAf6riDvXpPv8js8Ny4B72rDF/YbRVt98HwIvqz6KN8A/2TD6wlQFdKDwIseDwuW32EhGwH
	jBmNXFxAOjUCJVEYt/HER656LNr10zVkyswYd35870MqoDjNcJ6i2mGqRPujutKIahHjJsTB3mA
	KqXAFq1doSwpCUPrno96+k0lvAanuumRtUDDO4QY9+IuJgnc+QtmPopwtOiRnHzRUq6GnLpj5AE
	vXgJfrMTlpkzdrzYFRgousNu9/Zd3/ur5uiPvgwWyib8dnXk1IBaELAkDZRS6sl0A53KV5qUwBp
	7RM9p/My86NtVYY3EAwmc/NsuwTHCvprk5i3bBeaTaHCuO83dSlqAnaL3WKXIYyqe0C75cj2hpS
	iO2FFfMgwvgCi/LHKR710MxFcaQBP2dRRV1RhgmRMlzkJvlE1+v9l0FXAAdKs2nukfE1+nOAjb8
	zAn7U7c2PjWeBm1/k0Lzb7Uns+5X4bpEqWOPlG1BWNqbnQM7yRj3KPHPMZSdPsk3qDaPgq48I25
	Va2n0FD/vw==
X-Received: by 2002:a17:90a:4c82:b0:39e:6c6a:6580 with SMTP id 98e67ed59e1d1-39e6c6a67d7mr3165966a91.67.1789856256925;
        Sat, 19 Sep 2026 15:17:36 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb3284asm6236175a91.14.2026.09.19.15.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:17:36 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] af_unix: fix u->inq_len accounting in manage_oob() and unix_stream_read_skb()
Date: Sat, 19 Sep 2026 22:17:35 +0000
Message-ID: <20260919221735.3708237-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an old OOB skb is replaced and discarded in manage_oob(), or when a
fully consumed OOB skb is skipped in unix_stream_read_skb(), the
discarded byte count is not subtracted from u->inq_len (or is subtracted
inconsistently), causing SIOCINQ / FIONREAD to report stale positive
byte counts on an empty AF_UNIX stream socket. Properly account
u->inq_len when dropping or skipping consumed OOB skbs.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 42cffeafc8c1..1770af3c2684 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2849,6 +2849,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sk_buff **last,
 		WRITE_ONCE(u->oob_skb, NULL);
 
 		if (!sock_flag(sk, SOCK_URGINLINE)) {
+			WRITE_ONCE(u->inq_len, u->inq_len - 1);
 			__skb_unlink(skb, &sk->sk_receive_queue);
 			unread_skb = skb;
 			skb = skb_peek(&sk->sk_receive_queue);
@@ -2884,6 +2885,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return err;
 
 	mutex_lock(&u->iolock);
+again:
 	spin_lock(&queue->lock);
 
 	skb = __skb_dequeue(queue);
@@ -2893,6 +2895,12 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return -EAGAIN;
 	}
 
+	if (!unix_skb_len(skb)) {
+		spin_unlock(&queue->lock);
+		consume_skb(skb);
+		goto again;
+	}
+
 	WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -2908,6 +2916,11 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 
 	spin_unlock(&queue->lock);
 
+	if (UNIXCB(skb).consumed) {
+		skb_pull(skb, UNIXCB(skb).consumed);
+		UNIXCB(skb).consumed = 0;
+	}
+
 	unix_orphan_scm(sk, skb);
 
 	mutex_unlock(&u->iolock);
