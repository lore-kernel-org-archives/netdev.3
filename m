Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004C4E73C9
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935026; cv=none; b=sd3QwYipN6oBx7XtsbCR5/JGQmKKEZqMp+5bhMgFlUK65a9qpVaxHrwGeRdvciHzspwb9yIrPPjE9na/EuXrzwuARZCeK+O+wbGgVZ4zANSAkLJzBDGpqTz6tYcgYb1fPWSlsjlPECBLQI1TkFaexoRbn+FA6la8bMHJDjzdY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935026; c=relaxed/simple;
	bh=pu77nZyIUar100gpOhUPSXced2gQdBLKeiefnIOpVkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rymLiHcS1ptAi1ig2a3N1wGD9FQcdE7Tcp7brxqY5RMZIk4e0OZIcJao/sUZiAbkSjgltMmHYs2qzHLk36QN1NX50y3xKR1FmXHjBL6MkIFAVHvfg0+5etBmDEPHzkNHQ75KGjbLbRw+PLnVGM5+rxsnre3cOiGXjKR+XLrXOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc6046ok; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc6046ok"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso25141285e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791935023; x=1792539823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GnbAP7N1RyJiK5m9bEWbTrSCsSD6YeM52u+b8qkpc4Y=;
        b=Xc6046okAlBlm+Wfc7/XqZOni+4/LS1nYV3XBqDYJ+THFFxNmk0H8ycqSzzBew9bG7
         +MGf6efLybqne39t0y5l8Z9CR3eguHZ+Zwj9VXwpDLoquZUE/m3cXT0EjGn3ZSm+1foY
         jfRKAE6cRvnRrg6cDLb9vv+DfeyxV3bflTZPHGDc9vHRwU9rE6F6z/laD5Twjp7iJJZ+
         ZIk7OrUMsu3aKs3exo60wTcBcUZHk3rytd3W6q9cgnAxSINe430dymikpwBfM6c20KSP
         m9YtYovw5hQx+jR7/aPQqR+Z5C8FjATpMMI8xWIuRZsKU54iYoOCE10MyZbgHyBq/0ag
         FxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935023; x=1792539823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GnbAP7N1RyJiK5m9bEWbTrSCsSD6YeM52u+b8qkpc4Y=;
        b=cWNjDjUd7y3tTzbFi3CrTlhWTq04BTa43P6yMtP+YieCP7Up79+ZSE+WNjdXtAk96w
         Zg9nszwlyUucfY4T5cleXCjKkzCtI2NF1I0dORhE7buDm+rKHlsOBFsIMm+EtzmWRCUv
         v4ixs3BQFXhzd/4spl6vOCpViy3Hl5bGbh+3hI8ovRxuNBH6GWLmNuw3jf3ksvLBqec4
         W4mepkQP/30iXeH8eaiHCFad4mTVdsYYSLc8s0UDOsRO8kfsmPMLXQBTwEXJTq1jg2Il
         vNrhzhZUn+i5Kc8nGOZsdcnHi6TA70ywpfjuugJijTlxQ2oY810Ps2T/d9THUvt5W46E
         W0Rw==
X-Forwarded-Encrypted: i=1; AKwUvBwET8UUK0W3w0N+Bt9ayFv/LVldkHsm9AKEQxBrL25Y44EYYsJNP7ZADa3aauv8nUX2/SF9kJY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgDy/xnVENmdIHOp/LmM6CPwA2nFOC57JtEt0gWUmA7QoLdpPD
	VuuT+3+vuazLxNBByX4lR5Vt2Q2M9jNofVOwL41BzvZWvPzWVeSvNQA=
X-Gm-Gg: AYBFou3Iavw6Pl4xmpMNlGmE/aeXWMdT1qxSMEL01cmWios4w1SY9rrKBICqnrA8sA6
	a8Q6/vSEggLbrvF79lld1Lqou6kug1poycTAmL9xzaqrz9iWQXNMStINwIqGO9Yx/xaQCTb+7o6
	sNkPh6sxKg58NA/mHvrjWPiDvFJfsYX5p7TJ/zyACvBRgdAOVcGROpqQZo3x0yoECJV4eMbwOhU
	3dzeYmVhe3keOkYg1TjEMKTCc8s/P+Ouw+ZvvzruZWXCTj64eXk7rtWIv8YaxAUqMdqgVuS7SPo
	oJgDox+j7BE/1js1mVFq7TEZcphZzD1lrWAsP4x+gdcA3vSOWe7H49AJObKTfYSzMc8rDa1BubN
	dcbnO24lGrFGMhDDGHBsRCjWJ0wBoF+jHXpqvF+FWbWBZBtd67o8GDV+bk7HwyAy0d35m+HXtuo
	2g9vmUBkAHr9hDkdIFYu5R4s6vzkrYcR9M81LRqO/QEDwQ/OVRKg==
X-Received: by 2002:a05:600c:4708:b0:4a0:258a:b25c with SMTP id 5b1f17b1804b1-4a18e4da3c8mr279580775e9.29.1791935023379;
        Tue, 13 Oct 2026 16:43:43 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm390372155e9.13.2026.10.13.16.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:43:40 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Christian Brauner <brauner@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH nf 4/5] netfilter: nfnetlink_queue: pin file with get_file_rcu() before reading f_cred
Date: Tue, 13 Oct 2026 23:43:27 +0000
Message-ID: <20261013234329.2797868-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013234329.2797868-1-tristmd@gmail.com>
References: <20261013234329.2797868-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Since commit 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU"),
struct file objects can have their slab slot reused while RCU readers
still hold pointers to them. The NFQUEUE UID/GID metadata construction
reads file->f_cred without pinning the file, which could lead to
reporting credentials from an unrelated file if the slab slot is reused.

Use get_file_rcu() to take a reference on the file before reading
credentials, and fput() to release it after extracting the cred pointer.

Fixes: 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/netfilter/nfnetlink_queue.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index a3bc002800510..ebf9c9a8a9f98 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -566,8 +566,8 @@ nfqnl_put_packet_info(struct sk_buff *nlskb, struct sk_buff *packet,
 
 static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 {
-	const struct socket *sock;
-	const struct file *file;
+	struct socket *sock;
+	struct file *file;
 	const struct cred *cred;
 
 	if (!sk_fullsock(sk))
@@ -575,14 +575,19 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 
 	/* The sk pointer remains valid as long as the skb is.
 	 * The sk_socket and file pointer may become NULL
-	 * if the socket is closed.
-	 * Both structures (including file->cred) are RCU freed
-	 * which means they can be accessed within a RCU read section.
+	 * if the socket is closed. Since struct file uses
+	 * SLAB_TYPESAFE_BY_RCU, pin the file with
+	 * get_file_rcu() to ensure f_cred is not from a
+	 * reused slab slot.
 	 */
 	sock = READ_ONCE(sk->sk_socket);
-	file = sock ? READ_ONCE(sock->file) : NULL;
+	if (sock)
+		file = get_file_rcu(&sock->file);
+	else
+		file = NULL;
 	if (file) {
 		cred = file->f_cred;
+		fput(file);
 		if (nla_put_be32(skb, NFQA_UID,
 		    htonl(from_kuid_munged(&init_user_ns, cred->fsuid))))
 			goto nla_put_failure;
-- 
2.47.3

