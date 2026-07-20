Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C547083C
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784529933; cv=none; b=mOD3Om7+kllLZ8hljLHMOskGpHMGn2k1GhpB0McQDM4jd7aXKunh7sLTH85L1pkTfaac7/1TI7CHRqbJeJNNMIiUa1KQV4ZRz8MV4S8WWF5nO5ygR/e7EsT0OJaU04dbfpKBMhYoNloEt3dC0+AIJRrcxRsrgHVSvJyXlUuif1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784529933; c=relaxed/simple;
	bh=mglTaEO/sjtxNa6JCMEf2k62GqJxvdh5INi9EDcNquM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUszRMxUOXmDMj+Izk8GtppyAcyVoo8RMmjqfhfadIlgjvft3uMq0e/oRPmbY494lr7yRVjNh21a9FEe88qScRaH3uvslJqnpiqtgM0TMrX9ita1zvouW86Fu2F8fvYdO+/Qomo1fNQOL4gdYM0ob8MGTp29qirpHYr4yQr7i3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vsln3q2Z; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsln3q2Z"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so9749067b3a.3
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784529931; x=1785134731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1e4L9nZHA7afCucBd/lusVP/X6FFvRw4ikQnLjY9jk=;
        b=Vsln3q2ZyWxW9qjsOlQwwAGxUhwELiVJDLXyfwkvTydwLdDdhad6fkwzhCCVgj832O
         PqwMrA+SmSwjqn40EWZqo3bU5B0zzv9ObkkXFhR7Dxct32Fc1BNoYlvIUpv5FSjQaKCt
         jo8ASD3H9WTJLBqbaqw9ZYEICninoR0GT5tthXlCppSJdiw2Rb/jAkjDa4aXT41tVB8U
         YVb8OU9u/9b7NV4vSHwnSKKmJbib+VJYW+1RYijnQc9jIxd1wjoxF5xTfoPCM/xVuHjo
         z6XspfKRLPuGyHDdCSUGD9LXLOFocPHIuIVQEjK1iY9/Z6IBy1EYORHfDgfqg3D6M3QC
         3bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784529931; x=1785134731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1e4L9nZHA7afCucBd/lusVP/X6FFvRw4ikQnLjY9jk=;
        b=Vabq6bzlEfgaow+3F4W3Txxjt9Y3UIDlt6PukaNtQQ6DN10pAkGaxXGTFib+qE5aP4
         gw9ZdOafCLhkCBrPhpMLUFxADov6dmCCeVWwFNHiluBADIB+eGyOP7RiBVI9jQhr+BfE
         JWIGTbBcCxixsU4lm/7PwQanzYaZY34z8gdkd7h3j70UjD1wWM/ynYZa6t39XCNVBlgA
         H9kSrvq6CjqAOUc7TXjjjK7Bv0ncKd+Y7Zg3XPqqYtAfkg2Y64XQYaBdu8CchwVLXq2+
         gp16F4TI1TLsY8YdSku6j30O5GdLrW1bjrL/6haFw3NR7PRkirEQAvjg0pR4gxDNzhDi
         gXGg==
X-Gm-Message-State: AOJu0YzZydJq23/k/fgL/00HvZ/PokzWj9yeV5ziuptQR64nBjPmlbAc
	2s5OnTOC2D2bx0XUW6OWqqW39nY2/vYmRk6NxQ+WlHafOB+kK6XczbHrYmtpZFsG9us=
X-Gm-Gg: AfdE7cn2DZyfJaM3qxHYokGMxTfqhouHYCX6uVf9HUMp5Pr4H07qEQalTuhEoFBdW3f
	6DOjGwpJOuUWJE8oAQI8pZp+PqY+G5udUFWcy1gE7Okb663ESAWHKzIIrhM8XV7jHslWS9YhEZu
	rMDqLETyIJB66ESWPMxfiraAg4IwsGVylOsb60r6rCbtkX8uFC6P28lpF/0z/1KxjGfLMAnVVsE
	Z3yEG60WLr558l4SpwXwwaTG/0fHAWZKb4DHiMd4/GDImTWPgqwR8tO0Cr5Xtn2dc+h6kSwymKY
	G8ZuyWfmhBQV9bz52eO/ZfGjPIonDzXB1Q6ou8ETqYMRMxMOSBBmwYzeEdGCdZ00rBcKhmtHDmv
	o55pVHe4MOYUGQ/8ehxCkP1Bioppqw6JU+B2HaQ5rNZsogKr9gjt2sepBVzz29cmA7cd7RxvhxX
	be4F39C+Uey2LKZERGf4EOobpj5g4s
X-Received: by 2002:a05:6a00:2d92:b0:848:5cf5:5040 with SMTP id d2e1a72fcca58-84c292cfed0mr11662769b3a.10.1784529930683;
        Sun, 19 Jul 2026 23:45:30 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af30c89sm5102834b3a.36.2026.07.19.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 23:45:30 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ying.xue@windriver.com,
	tuong.t.lien@dektech.com.au,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] tipc: avoid use-after-free in trace queue dumps
Date: Mon, 20 Jul 2026 14:45:18 +0800
Message-ID: <b261f5acabf7c07c971e024d0d78aa9ea34f2be6.1784443039.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784443039.git.xizh2024@lzu.edu.cn>
References: <cover.1784443039.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

TIPC trace helpers can dump live socket queues from contexts such as
poll(). tipc_list_dump() walks the write and receive skb queues and dumps
the head, tail or selected skb entries, while tipc_sk_dump() also dumps the
socket backlog head and tail directly.

Those trace paths do not have a reliable skb lifetime guarantee for every
queue they inspect. TIPC socket queues are serialized by socket or other
outer locks, and not all skb lists use the embedded sk_buff_head lock
as the mutator lock. A concurrent dequeue/free can therefore leave the
trace helper dereferencing a stale skb pointer.

Avoid dereferencing queue members from the socket trace dump path. Keep the
trace ABI and buffer sizing unchanged, but report only queue lengths
for the write queue, receive queue, and backlog. This preserves useful
queue state in trace output without pretending that the trace helper can
safely pin or walk all caller-provided lists.

Fixes: b4b9771bcbbd ("tipc: enable tracepoints in tipc")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/tipc/socket.c | 12 +++---------
 net/tipc/trace.c  | 44 +++++---------------------------------------
 2 files changed, 8 insertions(+), 48 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..4b9eb0b401fe 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -4000,15 +4000,9 @@ int tipc_sk_dump(struct sock *sk, u16 dqueues, char *buf)
 		i += tipc_list_dump(&sk->sk_receive_queue, false, buf + i);
 	}
 
-	if (dqueues & TIPC_DUMP_SK_BKLGQ) {
-		i += scnprintf(buf + i, sz - i, "sk_backlog:\n  head ");
-		i += tipc_skb_dump(sk->sk_backlog.head, false, buf + i);
-		if (sk->sk_backlog.tail != sk->sk_backlog.head) {
-			i += scnprintf(buf + i, sz - i, "  tail ");
-			i += tipc_skb_dump(sk->sk_backlog.tail, false,
-					   buf + i);
-		}
-	}
+	if (dqueues & TIPC_DUMP_SK_BKLGQ)
+		i += scnprintf(buf + i, sz - i, "sk_backlog: len = %d\n",
+				       READ_ONCE(sk->sk_backlog.len));
 
 	return i;
 }
diff --git a/net/tipc/trace.c b/net/tipc/trace.c
index 7d2931521e0e..399538d0a369 100644
--- a/net/tipc/trace.c
+++ b/net/tipc/trace.c
@@ -158,49 +158,15 @@ int tipc_skb_dump(struct sk_buff *skb, bool more, char *buf)
 /**
  * tipc_list_dump - dump TIPC skb list/queue
  * @list: list of skbs to be dumped
- * @more: dump more?
- *        - false: dump only the head & tail skbs
- *        - true: dump the first & last 5 skbs
+ * @more: unused; kept for tracepoint ABI compatibility
  * @buf: returned buffer of dump data in format
  */
 int tipc_list_dump(struct sk_buff_head *list, bool more, char *buf)
 {
-	int i = 0;
-	size_t sz = (more) ? LIST_LMAX : LIST_LMIN;
-	u32 count, len;
-	struct sk_buff *hskb, *tskb, *skb, *tmp;
-
-	if (!list) {
-		i += scnprintf(buf, sz, "(null)\n");
-		return i;
-	}
+	size_t sz = more ? LIST_LMAX : LIST_LMIN;
 
-	len = skb_queue_len(list);
-	i += scnprintf(buf, sz, "len = %d\n", len);
+	if (!list)
+		return scnprintf(buf, sz, "(null)\n");
 
-	if (!len)
-		return i;
-
-	if (!more) {
-		hskb = skb_peek(list);
-		i += scnprintf(buf + i, sz - i, "  head ");
-		i += tipc_skb_dump(hskb, false, buf + i);
-		if (len > 1) {
-			tskb = skb_peek_tail(list);
-			i += scnprintf(buf + i, sz - i, "  tail ");
-			i += tipc_skb_dump(tskb, false, buf + i);
-		}
-	} else {
-		count = 0;
-		skb_queue_walk_safe(list, skb, tmp) {
-			count++;
-			if (count == 6)
-				i += scnprintf(buf + i, sz - i, "  .\n  .\n");
-			if (count > 5 && count <= len - 5)
-				continue;
-			i += scnprintf(buf + i, sz - i, "  #%d ", count);
-			i += tipc_skb_dump(skb, false, buf + i);
-		}
-	}
-	return i;
+	return scnprintf(buf, sz, "len = %u\n", skb_queue_len_lockless(list));
 }
-- 
2.43.0
