Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480996;
	b=c67EUU6YhRHO60bF/7NFYrkkVQuzSKmI+ToGCrCl8zF1VZDeOV2BFqwPVfNiqYkpQM8H
	 0vx733aCTS7S2VzhZJ+BSVrmSmM4mKps/qcQytRRVtVKUlswi9mPMgS1DjXHlJwuDOBGx
	 YW02f2FQ5McHxCoawrR9ZrqN1+pCAxRi8rkU33CJkhwXvs+qu1q6zsnQBuzHEplmMpDEq
	 z+m+sZR8gqbdROOus4OJcK6mgEAlVmvO+nBsAva57jHshCSXmkdSHQUHG5AKKwWfRTG/u
	 G4TcOPCFsdY8jyRl4NNzndLXTBxSPN0Fq0QDRjcEm8LgoOOLJt5Bh9UGpN/MOJl8scw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jtGHs2eqhkMRzNqa6Gcv6/y7Ijx8kqUTG8HewUTMQTc=;
	b=W6UgnJkiBLp4nMSDr5pIw6KkI0Lda57kraKFNYRuBHIoJ72Wy5ctG1sKnz38NmUt/ia+
	 GESHXZYNUKVLe64fn1bZGWunx0GiTi21JalqVlbt42nMQ9cdissTYg0dxcvbbQeFIMXVk
	 1jO6/Ek+QC6Cmu9gklM/3B+LgIp/tauVEuRTjEA4nfR7qqgGGrIy/LPTPAc0exLlUnR28
	 V4Q+ZcheIog9bRcwY/fEXDZXjKXNmzUUQ7UwxELBoU+OPDIHKse1/vW3mfXVsqjesaNSm
	 9w5vYIOGMFe3oemeGs9c0WYfjEvpqC5lFoJLRd64sR5tpQgfD8eaPBZP9updK3Rc++g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrkXU1T+;
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC9F606A33D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FC9F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrkXU1T+
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2e96b8bfb43so17277215ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480995; x=1795085795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jtGHs2eqhkMRzNqa6Gcv6/y7Ijx8kqUTG8HewUTMQTc=;
        b=jrkXU1T+YrLuTQfCjAmR7IxcQeKyuXOPWSQgLpSmcaKR/ycd/j7ErZn2Q9V/OePG6M
         mw0k1g0N/JiJZD07zxm3VaoVtoPwBASHFEOjObAcHSoTfmS19wLeCvIiY5wm92sCDER9
         HhJaCH72PUwGrZ1gfY1m5z4oNsgGE84915pxmwW7yazaKyktie7US8qdBONlXyw9b/Yv
         YLtaUp58Md8tfZlYy2Iai7WVKDpSYuiSx3MnUqAhxlStT/X+DO3LhesPnYDIpqgx4cB1
         wehn6EfRpgZKi5YdQEfNtPQ3qT90lTorr/O9gEOpvTvtwwuu6LzohbAUBu4tKnBByHLP
         uyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480995; x=1795085795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jtGHs2eqhkMRzNqa6Gcv6/y7Ijx8kqUTG8HewUTMQTc=;
        b=aw4TTXxUNahZaxy8K9YVX0WCkYQTia87oKfgoxyYR/+0Yph6QX5pKt4ulxyhi/MyBI
         97e95JY86FoWVMzWNnUatm6ThCrNRNl0f3fx0n8tw1iK5PAr20KmfLGS5SUcA3wBRLNv
         FqzzhTC4SMTlzu8860yg97+5q+RxM0TaMeaqgmGe/DsGExS3CaOKeeCUPsku9dQskdB6
         WNI/TI21W50HGppqSbxGvQHBCEHWqNcAbUF2JjKnCfi0viXYtqz89NalhSRD/G7otsYT
         +tuGqnxnO4GS5+g98Dczx/0hLjVqFz0AU8LtkJ10+aKQNxVcyMcdcBTP92/w4wUkdqvi
         r/4g==
X-Gm-Message-State: APuU4Z8dOsS3ZAWBHewiMel032BcGru2HYHBW8eh0GL0LMc3Dr4YAUXn
	Ht58CXDo9/VBY1xJN3KeN+muVvk/NsudcUtHZXQPPZnQrQpDay7ZW7+S
X-Gm-Gg: AYBFou3v3diOvMrbmN+lSSJ6f5PL+lZ9rMWDgkYhUnVTwt8KRYQmFOCP1FQzlxYxESb
	avKVAHlj68iN4Tf/RLC+Re0F8ujFT2EJscDPXJ+OS4/f5mfBwaEFvtXC98z/Lkqjtz8whNyt6H5
	DUPA84HwzptQH7SxI9dxHUoRFjDe/2A2lWn0DD2jZq3FTZepV2+D25he1Kr+zSSbZYjNZUxlQig
	AoVAzrF5QR2qrDzQEXgmn5UkVv6+iyTK9QlshA9dehBqTSu34ZkDOoeYB/3GzICRFA8dtnIbsjl
	RuWlEKzeSfhsniqE5t/Jq3f4oXsGK63tKjJx+KYQEObnV5WgJXfziufBDXSr5uT5+x3hyePlILb
	Ujn/tc5PvR1mJ7mhLGVzvx2K1SrJW7sddjNPWONHki6ELbbqLyiAahFXN4sWO83ywlcO5tW1uS0
	husT+XGWWXPjVV71yN6qQPANTvRP+vUd7aPKATzKHZl45hJ2wqVQfZ0Jtqo695Rz6QyG2pr4Z6L
	enURQeIK8jeSAXcJqIO5dPnq+o64bihbKEjgbSNUp54xlwBV3W87P2kGjgP1XAw3QmjXeK6GgAD
	tX0ekc9xG/k/WGvrwttzhy9pJZnZAHdj+hHuT2GATUEA2H8=
X-Received: by 2002:a17:90b:1d0b:b0:3b0:8947:fad2 with SMTP id 98e67ed59e1d1-3b182fb2981mr5114945a91.53.1794480994840;
        Thu, 12 Nov 2026 02:56:34 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm4228959a91.10.2026.11.12.02.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:56:34 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH] bpf: Reject offloaded maps as map-in-map inner maps
Date: Thu, 12 Nov 2026 18:56:20 +0800
Message-ID: <20261112105620.57520-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
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

bpf_map_update_elem() on an ARRAY_OF_MAPS or HASH_OF_MAPS map accepts
the fd of an offloaded map.  A program that then looks up the inner map
gets a pointer computed with the software map layout: with an ARRAY
template the write lands in struct bpf_offloaded_map.dev_priv, with a
HASH template __htab_map_lookup_elem() reads bpf_htab fields past the
320-byte offloaded map allocation (KASAN slab-out-of-bounds).  An
offloaded map used as inner_map_fd is accepted as well, and the first
inner lookup jumps to an invalid address because bpf_map_offload_ops
has no map_lookup_elem.

The root cause is that bpf_map_meta_equal() compares map_type,
key_size, value_size, map_flags and the btf record only, and
bpf_map_fd_get_ptr() relies on the template's map_meta_equal() without
comparing ops.  Offloaded maps share map_type (ARRAY/HASH) with the
software maps, but use bpf_map_offload_ops and a different object
layout, while the verifier and the JIT keep using the template's ops
and layout.

Reject offloaded maps in bpf_map_meta_alloc() so they cannot be an
inner-map template, and require inner_map_meta->ops == inner_map->ops
in bpf_map_fd_get_ptr().

Fixes: a38845729ea398 ("bpf: offload: add map offload infrastructure")
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 kernel/bpf/map_in_map.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 0fa3f2ac0f992f..5aa1f8249feb51 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -22,6 +22,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		return ERR_PTR(-EINVAL);
 	if (inner_map->excl_prog_sha)
 		return ERR_PTR(-ENOTSUPP);
+	if (bpf_map_is_offloaded(inner_map))
+		return ERR_PTR(-EOPNOTSUPP);
 	if (!inner_map->ops->map_meta_equal)
 		return ERR_PTR(-ENOTSUPP);
 
@@ -110,7 +112,8 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 		return ERR_PTR(-ENOTSUPP);
 
 	inner_map_meta = map->inner_map_meta;
-	if (inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {
+	if (inner_map_meta->ops == inner_map->ops &&
+	    inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {
 		bpf_map_inc(inner_map);
 		/* Its users are those of the outer maps from now on */
 		WRITE_ONCE(inner_map->was_inner_map, true);
-- 
2.43.0

