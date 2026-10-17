Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8FB37B41F
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200406; cv=none; b=FYNKk3fq62qzWIqN8QxAql86CzWDdUdajKhVGEYhZbewHxz7TNIEqESnLPSZkywmSYcO8Z3V0RbHSRpfID+IYAdfn/z1NY93eneg/mROB4bh6uYVMtnYhVRa4Kly7Rgv6bworVlm7yTzO3qFvB7raFx1Q9MHTN2GwMWNd+joVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200406; c=relaxed/simple;
	bh=USaL95hk+3EiXq7mhgdzzEOgrpG4vIF6DsEexRYU090=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4xiR8fsi8eWEcQjLGqCkU55ApGHlVYSObQcpAE14DaGFcJswD7j3En2/dF3Nd5x4PIPW5oqECG1C01qMh5VMfjsdqVV8rJsF4jLwjmQ5OCGdBIoHQmcnfvWCVFMyubAYfox4akFbBQcsGEvAys27MPNeZgCcqJPOaSErZtC0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQAEDQgu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQAEDQgu"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e86dce4510so1713475ad.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200404; x=1792805204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhSztm+6IxvHUKooWB8xZKABcaXbWAp2R1NWdjNwj7Q=;
        b=EQAEDQgui+sBIAqX5qF0pL/FIxEM49hRFDbV4pE/T/gbaxSZd/KgJE8rwyVgpG4sMz
         Ybv0VD5W5B4BVNtgLRccpp5l/gg8skUeoDuFPH0s2kJ+EWO41HG7hUpuqKKDcmyXJhMW
         fAmw6obikaXQ4hwAPv3B3WTjnFecPkT6A3wnul+ux9uiQ8jrWT1dihhh8e6y2E2VH9kW
         IaOqc+x+YChyWxbJRDsMPWtQDwd3uzgARWQA8UEFYN4zGJF9H/+/VTm5hAH7Q03DVSAh
         pTfGVFoxJ700C63mlQq40mL/+LJcMAI8BhJ4pXOo854OnmXDWNMRLuC1sLKe6po335iY
         1SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200404; x=1792805204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XhSztm+6IxvHUKooWB8xZKABcaXbWAp2R1NWdjNwj7Q=;
        b=s3qpv9sBuUKrsVxNDndPU2Q0ssSmW60q18dYYpi078NBQMWPE2uSgOS2T5O/auNl4W
         sTmqjDiVHm0ZvVL95SBkhp18bPrKB7T3B/G08ZY9tdZNQjeQM3nC2sQkrUblcLiaH4uC
         eWSEGJhSAYyQN3VL+e8cK/lJNA4C+z3G4Dn01WhuTN9vkER2AJfbpj0tm3vkvOpK6Zya
         +BhIAO5d/B6ZIGUiWjmkAGz8lWPL6gqYRo9VrTUcnRejzS2hhH0wXoh6eNRKJUht5IlJ
         pEH9brHj9fKGg8C3jcACj5wyPiW8PnFuLC8oRFbWvrYVyIlYokP/5NtIpTOfOG2U04rE
         M8UA==
X-Forwarded-Encrypted: i=1; AKwUvBz6YOkCZNiJ3OwEO8B+da2LuZ2AWwTSL9qCg8+cYt7GYrrTUAnaM2tUFd6SqitU8/yp7u4vZzI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3D8MdNknU691QekIDcMclUyydgHTvaixZ+OgdFpOz8YlO/ouU
	hCbWAYswlW32vJpQCgcS2a6WUyFiuTnRd9p4To5UDl+t6N9OLS04oHXz
X-Gm-Gg: AYBFou2P+qlVrdB73VL+Iqyd8RXv/C8YKC3sAziEeWz19DhtRkvp9F57r67gzMh9jqw
	TYNbONpzMoPmeLXGeSYKFur9VWRzeQlUmsaSnAe4jjB7o1i7CyL9RiVT/5e+wZFHcpddYOlf4GO
	0auk0DB2jsyINH3+4pWZTLFrANCUX8/wnBWi66gXLmK0P3NWrIOwrbjR3Ob19F3gDC9bJ/K+oxV
	E9qfXwTrM1Jial45zzTsAKG2xFfmPO5fyreKxSmm7DICLSN0LDlOyDZhLZQnG2R+jZsLBfB9pAZ
	s36ej+e1tWLh1LpIBvn+1Pzno4U56my1mpTYM7uMbTErb72CGi0g5bZvEcTzpvnxRVwcKJyCg+d
	6plhUCxtnt0cVcw7s9g7L7JBWwkLYM2A+9KsVydfSLzrCTPw91D2Vkyrlm0mWu/EF0aVXk2/XLy
	278A50LSgZPRh3KdJYL4dxNQuIM3/9SN2O9NAtWH82gOcGpJZAckKel77bB8IQr1YaM7y+ymC1/
	egreBjaiR08xm+RLcayZ5tj9iRKxYr6yCtlg2K8PhAPccINEvCe3t6Y6I5hUH+Pb/FzsrkbxJCi
	PkWZAoLe4C73iD/zwIm1P6g+QMh7att7pjHCsd2pL1KJ2Sr+9rWr7Q==
X-Received: by 2002:a17:903:19c6:b0:2e9:723a:cf30 with SMTP id d9443c01a7336-2e9a682d710mr13777485ad.2.1792200404475;
        Fri, 16 Oct 2026 18:26:44 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e833f1asm17242335ad.43.2026.10.16.18.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:26:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 14/38] bpf: Clear sk_refcnt of a clone before its storage is linked
Date: Sat, 17 Oct 2026 01:24:27 +0000
Message-ID: <20261017012451.364800-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

sk_clone() sets sk_refcnt of the new socket some lines behind
bpf_sk_storage_clone(). But the elements which that function copies are
linked to their maps at once, and an element leads to its owner: the
iterator over a sk_storage map hands the owner to its program.
bpf_sk_storage_get() with BPF_SK_STORAGE_GET_F_CREATE and
bpf_sk_storage_delete() rely on refcount_inc_not_zero() to tell whether
they may touch the socket.

sk_refcnt is in the part of struct sock which sock_copy() leaves out, and
sk_prot_alloc() does not clear a clone unless init_on_alloc is on. It is
zero in an object which has been a socket before, and anything in one
which has not. If it is not zero, a helper gets a reference which
refcount_set() wipes out, and the helper's sock_put() then drops one of
the two references of the new socket, which is freed too early:

  IPv4: Attempt to release TCP socket in state 1
  BUG: KASAN: slab-use-after-free in __raw_spin_lock_init+0x47/0x90

In the meantime the helper changes a storage which bpf_sk_storage_clone()
fills without taking its lock.

Nothing else can find the clone at this point. Say that it is not alive
yet, before the first element is linked. Sockets whose parent has no
storage are left alone.

Fixes: a50a85e40c59 ("bpf: Expose bpf_sk_storage_* to iterator programs")
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/bpf_sk_storage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1d295a8769fa..b5349bec5695 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -164,6 +164,13 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	if (!sk_storage || hlist_empty(&sk_storage->list))
 		goto out;
 
+	/*
+	 * The maps lead to newsk as soon as an element is linked, but
+	 * sk_clone() sets sk_refcnt only later.  Until then it holds whatever
+	 * the slab object held before: no reference can be had yet.
+	 */
+	refcount_set(&newsk->sk_refcnt, 0);
+
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
 		struct bpf_local_storage_elem *copy_selem;
 		struct bpf_local_storage_map *smap;
-- 
2.55.0

