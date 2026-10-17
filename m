Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67B3A0E85
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255156; cv=none; b=pufRvIr/QZ0+BpfHBloipK8Cq578rYExWxuJ3K4jMIDmGWQqflGxlHrYngTS6lrQdcpHl3mHuBvkFEsvL/3gRl+yv/ZWVLgFlnWP2k7XIJwpjQ31/r+TFSZVh2k360qBZ9QqMxEdi+ukYmiy/crqDzX4t+v19zGN1mkt5JaFsII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255156; c=relaxed/simple;
	bh=USaL95hk+3EiXq7mhgdzzEOgrpG4vIF6DsEexRYU090=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjlXhUW+Ti9Bg3ZF4pBNl4oRKtsKSzp75pSLRntn3v7sWDS41qdJsjQMzYEIDtQ4xU9NSF0ciYyUlYUTdf9RwME4he8gIcGRKIyyzn7LWaGPQTInoZE/OE3oaokSCz4ye8smGuZJhyQJwWNxCvlfuO5di+I1iRB3u6FZ165KdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFSvnNKy; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFSvnNKy"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so567609a12.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255154; x=1792859954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhSztm+6IxvHUKooWB8xZKABcaXbWAp2R1NWdjNwj7Q=;
        b=DFSvnNKyzidncYIUvHZFMf+qok2heUGJL/8YJW6iJc7uUTSGxiiDyTgLr2Hz2e8xwo
         MaldKBhdUWk/Hf8L/gQvxJO9rZKLBcTUFF6pbowL7zAzkcGaHqrwYZzDX6nnxHt+6iiF
         sO/TOs1k90Np7mo9jNzTQX7y+erHlo0hSNRVf9SAjqnU9Biwi3hB2ThSGtkzBImzw2OB
         IxOe4gXvyhBEOYI+n50ebFtIcX9NjWYERWceFewaoOHVBvtV5rb3THUuSVwaSjk9NY8s
         rzumIunE5ohftXm5EaT4BpbL7J51P3vwoHF0uiN6OrtNHeJugKwtCKyKEEor3I5X6geA
         IdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255154; x=1792859954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XhSztm+6IxvHUKooWB8xZKABcaXbWAp2R1NWdjNwj7Q=;
        b=SZ7l+Ffa8Xz+DWuDEyJnJlvMYjidP6xlrCKNtjbYOaKJe68vjlaoNPIrW0Rs8ZYPCy
         WvN268EkWPvMopwkfmFyrdgUoZcApmI8YilxG77Q1DU38qToD7M8oWT29BnWlemwDqqz
         GlQ/iHlhE5/noW5QygBx8cBHObCDQZLudl4jS54A5fy/+3jyw7Rl6ANRvRVcXROEyntB
         uuu3w5hfpBiswlTCsx302lv2oUTtIgodAUIhKZs2ysFJiEpFWmo06MHFDVlilctANWho
         uJlBj/MNgiGlSvotqSyRrI0WXna++BoqTRSNBlkDdVjz01yatgU0jdAXRWE/Qmj8wdmF
         smSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLuRDWQPFPzoBXzrzse/PSayHcJPiuzZfhpnm3o0UT1IbH8k7laQ2poYkhmnGllk239D+g7g4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOWMeXSdmyyNw+/dwA7T6cnGkrNX9nvgZ05sFJLSJps+/B6v3d
	zo8bTlGbYSUa4Y6gEpG+XIxDfl5oXPwftg2YZkiAZXWT+ofzuYk1LCLE
X-Gm-Gg: AYBFou2rtP+/pqqnKoRyeMIM8/oynosKCFXzK65jAV1pbc4VdtplZv34GntXEG0ZjMS
	KX5F3a6KpBZx0di2fV2YqYFLwBVQzeNHsC4Yz14CiNzXB5/48YInlkyJCxofWG8GshYLY97YKBt
	80kqBppKgnNzGD7lof2tf/z+etz5BPlCUHzh+CdsephbE6a37vUaDglVRytdmTEbuHS7DscW0al
	an91ujXbZL1vd07O7Y1AvhEj+qebF7b3DaX8ie3TkJDMW7ajy6oaX79HosLF1V+/aKLCGL1UUz1
	nz/qIF9xqFBXdf/p8pa4DgajDoXhg9fCleCorNONN/SU0a+4otUBiNIxsB/ht1caN1rT/Mqc36z
	ryAcHUsy0a+7cWuTRgqA6qZUue2dZT+p4sW1qMlEXmiXRjLNd5rsUoJ7nAk4EpnrEG4v1CFreBw
	a+W/pOMSc/LHPgenl4HIFxCfML3/OsV1bwbHD8NzPF6/NRUGa2YCikidguj8FNU4ADQNJ8BmhCK
	QQmo+Ai/CYja2MQ0AmlM4Qy71DiK014i66XbKtDNJnREl5ydCHHDuvtWzb4GL80u21wArAgdw1b
	BZiz9FfyLoOmdvzjJBvNJn1SyWMzjprvcPkUcF5ge4rA
X-Received: by 2002:a05:6a20:394a:b0:3e2:1218:3ead with SMTP id adf61e73a8af0-3e225fe3496mr2671879637.21.1792255154040;
        Sat, 17 Oct 2026 09:39:14 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a05dd9e5a2sm176987b3a.13.2026.10.17.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 14/43] bpf: Clear sk_refcnt of a clone before its storage is linked
Date: Sat, 17 Oct 2026 16:37:16 +0000
Message-ID: <20261017163745.3341787-15-alexei.starovoitov@gmail.com>
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

