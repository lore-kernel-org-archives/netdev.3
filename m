Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0BC3A5E77
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255167; cv=none; b=rA7T08asJi+zfNDFodST1p+h3gskPFeTnOiFlsq+JAQmVQNvBM4Ful4WY4jz1AyXL0WVk4c04bN3dvfunvrmPKxTGackXJEOlT6P/1rFNnLHRsznSz8NMt4yjRs2fZKnYyYDyaUvrjuylvByikI2ImiC/Xrj/jdosJ+Zb6fgCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255167; c=relaxed/simple;
	bh=ONRSxOv0WIrGtolvtQu6QhHo0/j3DkO3AplhmnSjVaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kidd0pUTlFYZLP7w4GYy0I/yh5VdNTx2YS2c8rxMcx80ZDQLYW+FjKyXZFyHbxTJuwzVh97zUwz18bdHp2/6iOW3/NU75LqjqvmbugnPSsxEU3sTi0qhCznVMXme10yCDwwSTzkDPq/SWDwtthE34zzfhGxkiJr2u3rWuHcWbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amYb7yBy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amYb7yBy"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so580857a12.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255166; x=1792859966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V4vQJUQQucPpz0qllVj00ZgJScSPlEDGHaCFRbM3iA4=;
        b=amYb7yByQ20vyz2zGeyWLnbL5uz2DhRfIb9EO7eu8u+2fOoorQMhNA30gwYVZZpV9G
         ZOkBPUJJnMumuK9+4kEWFjWB1awEdFdNpUfSsx7pcX94POtwwD4gM/2KWRRb9gDOQPqn
         NdFh5qNmGnIYphJe1SSnqWckO6lwNj+MD0R90gvv/APLIYZa0Hw7eDNsicyunwy3PwyL
         y7si+V5B4R90ZrL6gU0Q5UixY/lqh879jeZeJPJDLqOBzX/7F11C/rbd1o2drTnSNob0
         44rJB82QMJ0di32Ie6ptxlHIn3+Qkv07kxfA8zyFLy2UmLtYZwvXRPHy3hqeY6oYMr6j
         gXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255166; x=1792859966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V4vQJUQQucPpz0qllVj00ZgJScSPlEDGHaCFRbM3iA4=;
        b=QVvScvkAKR/xIn84skyX5gKs6EAzhkiUBx/svfLpXPCCS5pDqjw3j7ns7Tl7Y5l1E3
         6U8Gs+TpyOukVUuhdIjzLFviTS1boIWYFhub+DPR/qadBZm293aXzHqxz3YUOVbYV04W
         7Hkw0Lv2eSEB9dVffihd62USAiADaA/lvfEiYqacATUN3q4kVvBOY9NfWXZpkA32w7WW
         1LJWijuiE7PcxkfYUc4ez/whkRY51q6QGNwS1jKfHSHu9uJIqcCrHy+X4NBLGxChXNZR
         FEvGolRSCcsvlhHUNAaNc7eqrP1PMIxV/wp6gz1XySdH8/HlbbfpVQaSNirrZZuY3WNq
         VQTQ==
X-Forwarded-Encrypted: i=1; AKwUvByCXPD1YPUZVzFuA+kdHylTzO+Y3REse+z54WY0B5XJeUSwGF++GIIwkDtYgjVfUt5/UqGAe2M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIctEwV5EnBm8kj1YHKzEpbc1kisrkMGzyYgQD77et19b/uFdoN
	9OpDGCSzea4rCn7RloSNmUDwooD7O1ErYJJnATGCkC3AIuZLEvVz9SFr
X-Gm-Gg: AYBFou05sgUHkLuDfS0/0/zH+IE2Xkt3u8mhIT0kPvVQ7ZYBeFz4ZeTJHOYjergnN2l
	ydzB3DX6/gX/22k4xGIlrNaErVQBQDekkVIDc32Jw3c3WrfphEsu2JthhnK7j42sGTiFQEPjUtf
	tjKM1bhwM69iJcKRkMlUjn/MQWEzxPmMEN3iBA5oYeYsvdHf6MAkXHtafnOmOW8LcaJkCwYY0kp
	l+d2HIQF8f3h8Lu8TxzTr2EoUZ0aGHhmBKzqEV4IJAJmbhGydblHsHvo4S5Mkgm2AO8XcdF3yQN
	4DaU1yNMvKVssPAQD5pSqcQStn26AgHTHRyH9TKpCobX8YxwN2AMOnsD1c7oDQLNdw0CVIpabts
	yI93tQk6VICn3GWi9kv9vv833Gde9CLG0phjQnNMokC9TAytVpE13o7Xr17ApG8RnEtMEjqmwe3
	ly89RLglaqiECOglgLhFmnuOZ38ifO/lVIjDF4dXRdOGZF6hYLYjxYBSRfFgcVuX4MQK44Z/owv
	dgwMLm8xkFfsADHuN5w0iIrXBn6xLA7d8fSodMwWLQzfTAmiXLwkijoU3S7tU4CQEaS5EzdkdZq
	mZVRBjjMfIi1C6Sb0wNWwT2CmL6HZRDf1oMwYtc9eJ0=
X-Received: by 2002:a05:6a21:4514:b0:3dd:a007:cb2d with SMTP id adf61e73a8af0-3e22607836emr2260481637.41.1792255166073;
        Sat, 17 Oct 2026 09:39:26 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735e508sm2401682b3a.28.2026.10.17.09.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 16/43] bpf: Link the first element after its storage is published
Date: Sat, 17 Oct 2026 16:37:18 +0000
Message-ID: <20261017163745.3341787-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_local_storage_alloc() links the first element of a new storage to the
bucket of its map, and then publishes the storage in the owner with
cmpxchg().  If another cpu has been faster, the element is taken out of
the bucket again and is freed together with the storage.

In between the iterator over a sk_storage map can find the element.  It
stays linked to a storage that points to the socket, but the socket knows
nothing of that storage: bpf_sk_storage_free() neither unlinks the element
nor waits for anybody who uses the storage.  So nothing tells the iterator
that the socket has gone away.

Three cpus that create the first storage of a new AF_UNIX socket at the
same time, and a fourth that reads the iterator, are enough: in 20 seconds
its program was shown some 4000 elements of storages that had lost.  If the
socket is closed in time, the program is handed a freed socket.

Link the element once the storage is published.  Both happens under the
lock of the bucket, which holds off whoever finds the element through the
owner and wants to unlink it.

Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 7721834e4bff..c08afb33d038 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -509,8 +509,6 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		goto uncharge;
 
-	bpf_selem_link_map_nolock(b, first_selem);
-
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
 	/* Publish storage to the owner.
@@ -525,11 +523,17 @@ int bpf_local_storage_alloc(void *owner,
 	 */
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
-		bpf_selem_unlink_map_nolock(first_selem);
 		raw_res_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 	}
+	/*
+	 * Not before the storage is published: the owner does not wait for
+	 * users of a storage that it knows nothing of, so that nobody may find
+	 * such a storage through the map. b->lock holds off those who find
+	 * first_selem through the owner and want to unlink it.
+	 */
+	bpf_selem_link_map_nolock(b, first_selem);
 	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
-- 
2.55.0

