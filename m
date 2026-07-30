Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143B3806D9
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425952; cv=none; b=eib57lGgFpQX+8cjkOk/H1NWCWLtVvhRaDCOaMGbAiPjXYX5OvgL9lKvEn70jIwQ+nm4ldJudXtN1MSbhgZa+26BSk/wfR+8qJ8DiNk9u6XzK2jnsBfuvh7UJpaQmsQOBD/kFfRPqg9d1nKEj9IpBisIQ7cF4L2R2jox76knBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425952; c=relaxed/simple;
	bh=TfYjiyxSZQWShWeKuVieNR1hpXAfbNI9JGyEi+hZeA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1DTZYAtBoUbUHKo7CQCM1wZ2CP4fV1u/YdHlPZF9nEhBG19v0+SR7VUn38kxeuFeGDgIKSvtVLTOcqBghgqQecE8h3pEMUVnUAM3wbISg1bdj0KYuoRM9bipUL2BPVeq9AethB57WgRPa7APXloUvv8b8UX9iWJLCOae+GaaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=AmM7Lohd; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="AmM7Lohd"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cabf1f1051so6852505ad.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785425950; x=1786030750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2EIBFtdmD218tgwkiMxBZe+9ZM0XALpaRjTlqLBpcvM=;
        b=AmM7LohdavokgRhj+yTgsGfKges88Du2VbYjSDHU1aB7jHa6Rl0cTLmNaJh26XLG3+
         j3q6tj/pQUnl762MtXewmbqx/uCqGFTZYJG8kEVjXi4m6AgbjmL8BN05Wb8bacsGUqAX
         E9GjR1lPLC9hFwy6613/a5jAvIotdimyanQSn8vAQXbbLY1olLdFvwLjCC6YyGXIJwQk
         DOgPHGXnNTxRm/7Wj6iaQpeP7HOeZa3uen92LQlbWo7VVP8+k2v5NiCbY3OklpdvvdUo
         XrtBypP60SNZsuxgaNk78/Ky5QR5Zq1RH6ScsTse2uP35AouJlbO7H9C+9yqbaSTAWxR
         6Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785425950; x=1786030750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2EIBFtdmD218tgwkiMxBZe+9ZM0XALpaRjTlqLBpcvM=;
        b=m1zOUejRPipRKgw3Ujc0uGEa02VCr/cVU4EqtRErVwtDBlVRFISnIeoUDZuN5nRwqR
         1Fl4bU+swJ/HF0RqawJVoTne39TbIapeMd+rpoouFhbepoFTHlgZophWDY05H6En3AoA
         aQAIy/LmAsSh60ooDG9mVZTb09/S2YgaFBUUfgSroD2DSakTofqLLyNV1di2sqF5vlg7
         LMJ3LiqBHvitrFnWUo//jxcwAG/tZFxJXJJcUbFPoq1u52fCxjrF4c5x6Ig2cJeZAHN7
         NDRzI3dofNWFKjhim6gIdwXg6fxIHMoIPp4oZjeJwNnIl7mW9oyWeyIBAklsbocmkj9X
         /VSA==
X-Gm-Message-State: AOJu0YwATbnhRrPUmEeWCyHVI9IF/EVTJdn4H8kzGxZ4N7uOOsmdOBUr
	xZwwRTWjYSENkI0zMbvUn7MEaTkecB+VDMPf74iTC1VhKJcjM8Pu4JU5lrYgLhntgnnPGuidzi1
	ZHYxOkzgD3e8=
X-Gm-Gg: AR+sD10KFfpO01XdKZwRBH4vcJWle9dqQXI7nm41PCGtmGMJXZwYm/rWZQ8o+K7DdnJ
	IvuisBJtmgkdrO54FLhbP0rTZsp3Twjh+DLfM9F7w1JB5Sl4YyWmcYAnkmzS2BhFOEj8MQJC6/i
	KIOr09CS7kXkL+7t3Ouhv3hS+hkCawSBYOOoNBAurTXXUB5NXtlamK7DMQ+cKgimIfdHf2VYwmk
	800OqayXtm5yKC/KgRnlOVxzbhlD4L93PCujrpkeoErfHQC8rJHrwahMLpBY5DWOHeyie/9Jy6c
	sFcYfjAAN+KNy1NVCTiGYvyjf7Je4sm9c/0llJq69HXtn/kauPpF7M5GHU7nJj2Cv4GbOxrW5Ae
	ufjzu7p52MJtfkbbbtO/tdUPrSZSvPEE1uQVJKRtfVWdoQvruX7WRkSzuQ+9bxiatGo69kJI+m6
	QnfMtj6NMkoscnnvezP63CMJvLvif+5TnmGX/rF7zkpVfBshXDTJYO3LQ8SlLhdZDMUyAjpcY=
X-Received: by 2002:a05:6a21:150c:b0:3c3:b57b:645e with SMTP id adf61e73a8af0-3c900470cf5mr3301025637.5.1785425950026;
        Thu, 30 Jul 2026 08:39:10 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb824f077sm2242214a12.11.2026.07.30.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:39:09 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 1/1] xsk: account ring allocations to RLIMIT_MEMLOCK
Date: Thu, 30 Jul 2026 15:38:32 +0000
Message-ID: <20260730153832.11238-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730153832.11238-1-zihanx@nebusec.ai>
References: <20260730153832.11238-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_XDP lets user space create RX, TX, fill and completion rings via
setsockopt() and mmap them into the process.  xskq_create() allocates the
ring backing memory, but unlike XDP UMEM registration it never accounts
those pages against RLIMIT_MEMLOCK / user->locked_vm.

A process with CAP_NET_RAW in a user and network namespace can therefore
request very large rings and pin a large amount of kernel memory before
bind or any packet I/O.  The later vmalloc_user() conversion changed the
allocation mechanism, but it did not create this missing resource boundary:
the unaccounted mmapable ring allocation already existed in the original
shared xskq_create() helper.

Fix this by accounting AF_XDP ring allocations with the existing
mm_account_pinned_pages() helper and unaccounting them when the queue is
destroyed.  This puts ring memory under the same RLIMIT_MEMLOCK /
user->locked_vm model that AF_XDP already uses for UMEM pages, without
introducing AF_XDP-specific limits or socket lifetime coupling.

Fixes: 423f38329d26 ("xsk: add umem fill queue support and mmap")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - replace the socket optmem limit proposal with RLIMIT_MEMLOCK /
    user->locked_vm accounting via mm_account_pinned_pages()
  - drop the earlier socket/pool lifetime coupling changes and keep the
    final code diff limited to xsk_queue.c and xsk_queue.h
  - retarget Fixes to 423f38329d26, the original mmapable queue
    allocation that introduced the missing resource boundary
  - v1 Link: https://lore.kernel.org/all/cover.1785313094.git.zihanx@nebusec.ai/
 net/xdp/xsk_queue.c | 8 ++++++++
 net/xdp/xsk_queue.h | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
index 4dd01b7d858e..8be251096277 100644
--- a/net/xdp/xsk_queue.c
+++ b/net/xdp/xsk_queue.c
@@ -25,6 +25,7 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 {
 	struct xsk_queue *q;
 	size_t size;
+	int err;
 
 	q = kzalloc_obj(*q);
 	if (!q)
@@ -45,9 +46,15 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 	}
 
 	size = PAGE_ALIGN(size);
+	err = mm_account_pinned_pages(&q->mmp, size);
+	if (err) {
+		kfree(q);
+		return NULL;
+	}
 
 	q->ring = vmalloc_user(size);
 	if (!q->ring) {
+		mm_unaccount_pinned_pages(&q->mmp);
 		kfree(q);
 		return NULL;
 	}
@@ -62,5 +69,6 @@ void xskq_destroy(struct xsk_queue *q)
 		return;
 
 	vfree(q->ring);
+	mm_unaccount_pinned_pages(&q->mmp);
 	kfree(q);
 }
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1bc42c8902f4..b2e96c65f955 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -7,6 +7,7 @@
 #define _LINUX_XSK_QUEUE_H
 
 #include <linux/types.h>
+#include <linux/skbuff.h>
 #include <linux/if_xdp.h>
 #include <net/xdp_sock.h>
 #include <net/xsk_buff_pool.h>
@@ -46,6 +47,7 @@ struct xsk_queue {
 	u64 invalid_descs;
 	u64 queue_empty_descs;
 	size_t ring_vmalloc_size;
+	struct mmpin mmp;
 	/* Mutual exclusion of the completion ring in the SKB mode.
 	 * Protect: when sockets share a single cq when the same netdev
 	 * and queue id is shared.
@@ -532,6 +534,6 @@ static inline u64 xskq_nb_queue_empty_descs(struct xsk_queue *q)
 }
 
 struct xsk_queue *xskq_create(u32 nentries, bool umem_queue);
-void xskq_destroy(struct xsk_queue *q_ops);
+void xskq_destroy(struct xsk_queue *q);
 
 #endif /* _LINUX_XSK_QUEUE_H */
-- 
2.43.0

