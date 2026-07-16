Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309948CFC;
	Thu, 16 Jul 2026 02:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170291; cv=none; b=cSe27aWtzMp6wtD85G6HlLHgOCAxNrDzNySj1KEBOPWlVJ2/jOjnxPojrBjqLFWXvJnjRrKv4CrlV8vFZ4dcMcY4/iCMoaDFmcQoggLImSu2ZVENgZCs6PqJBBsTyTVwtBBr538zTJOtzqZHnRUT6cRGP7AqsvqDweh57n4cEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170291; c=relaxed/simple;
	bh=EyJWzCmr2BvGBBFwN3zJZLO2lXaTCgu9T71/e+XyzQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOKYiVpfAJI6vwrSZ5zv1eocb+MLhesFpQNqG65srFS8iMN09gZRKZ98X3miksidPkmbOC02NkYShhevLaNP0Hw19B1cX673QsX2N4wyx6alihriyT996GC8APLsH4yjSYQTCk5DgnABdbx4AETJ/NDy6XKMVkHfqityLWhkvcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ccvy8fH2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ccvy8fH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hK
	GfKXx2lf2lzruaLSSHEtaaF+78R3+2qDuy5HSWZDg=; b=Ccvy8fH2ShwjRXgPWd
	6F0SRF5i2HN8UJi6teTSOPsm2qrhNHd7Z9Mf4lINojdlnu9pLKtXi/2kU6XpccsV
	T8XvvkuICnSz1qD0a28vdnAK7w2gV9BV0DhuS75rkSVUZ5fu66znyGozBIXmeGQq
	qaRE5u2eFLEpQV/UAEL82xNDg=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnfyoSR1hq7tr6HQ--.51378S2;
	Thu, 16 Jul 2026 10:50:58 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Weimin Xiong <xiongwm2026@163.com>
Subject: [PATCH] tcp: use kvmalloc_array() for BPF iterator batches
Date: Thu, 16 Jul 2026 10:51:02 +0800
Message-ID: <20260716025102.118174-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnfyoSR1hq7tr6HQ--.51378S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWrCFy3Kw1fCw1fCFyDZFb_yoWxtwb_ur
	4kAF9rtF4Fqwn7Ja1ayr4rAF15Krn3AryFgFySvFZrJw1UJ3Wxu3ykXrs8ZrZ3u3y7CFs8
	Z3Z7ArZ8Ar17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMdgAJUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzhKGFmpYRxIAWgAA3x

Use kvmalloc_array() instead of open-coding the element-size
multiplication when allocating the TCP BPF iterator batch.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
---
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 209ef7522..d184893e5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2926,8 +2926,8 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 {
 	union bpf_tcp_iter_batch_item *new_batch;
 
-	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     flags | __GFP_NOWARN);
+	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
+				   flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 

