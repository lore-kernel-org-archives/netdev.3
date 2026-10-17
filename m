Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DEE2D0C7E
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200492; cv=none; b=ZP4ht49JS/vGGw4Xsv0osDXjFVqOv2MV/oBjQaj2DZ0J047I58niVyuK+x2gFqAJi0lpap0kJ1wkKonsu/CbZR6KVc2UwamLkojHUtjojhX7f9EeGYLN5QrXVRUK0N4QHYb8KC8NNxY+6Pnj7gl/zPbeN4k7vdIvcOSmYA5EHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200492; c=relaxed/simple;
	bh=Wci1AUQRP0O6zqFQ6ZZ+EeXSWDbKK0xYZRP4naVP85E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrGjZ+qypVuBvja0CVvzFZxAG6Ra8pO3M0u4m1CZZOVpDQzcmp/ul6z2bS6HG8fnlC7fYR1bOfiCxZZbf+1U5CKVB+qM2bPl64mFOVRgYwJnfeNtjyX5pOKd2RSc1SvK2ZSY7MEGvSe9oIus3RaEEKkkxSDPnj/WX5UzHedjVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGusVY7l; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGusVY7l"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so262192a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200490; x=1792805290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IHfvh1ufufjL6pvwM565xof/cBXe43GsfSLo8UXkYQY=;
        b=AGusVY7lRk0MmeYDUPONK7N/1C20R38j1MxhtSRLQbN0SKEyGCsyQi+2p4V1thKCA2
         Uxbeqxyg1KMc7y0DV3t/eLCELQeEMoMJoduvdG2I2Hfc1RWCH1BZ5ohk4MkDjcBMyWrS
         0VICCiEDmnVpAuTvwuXh8EQ3H6j7I2yoGqKYHmartzCsU9bfZG+xmHGomsGBtVOsVy14
         YUecXScDAlKo+IRiBKDt5f2hHqlIVdgMqSNiyRW3+vOcmfOEtSU08CXrh7HNGsp9oNlc
         VNc3fCWbFP1t6Wa2NQqM2GneGFnjUGDQlod1B34GKFJal1voqKWJID6xSXhILI2AM0rc
         aMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200490; x=1792805290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IHfvh1ufufjL6pvwM565xof/cBXe43GsfSLo8UXkYQY=;
        b=2S+wAGa2h/kGlyB7TST3M98EXNGm2mvNjDrSpVi0BOHGmVQpdae3gDutg60zJrXjl0
         cDh9o606vesuTqB6ia4bD+ZYG2pWQYEN5QxVsm7hDUpJ02SJECEDM4bFzGx/FwUyFWmQ
         SFQIv4HODE02O4nNofjgpVo4HHksz1GzP2GfFfdPs2ziYWY8SRTsz/rZQf74nuNLMXry
         4uoXX5CeuyP5cYWzOmhclqDLu1w5CR4rNRFKHxk2NpqzIF1/CLs4zoojr8Sn7zXwSKfz
         ZA8ghAUgT517CSjC2FwhnoHua5K6nJwtJVQ7q3zgPAc0mmhzQwp66paO3SuzUExkG+I2
         i4Uw==
X-Forwarded-Encrypted: i=1; AKwUvBwTKzyEtay+rsVAXahSbKPL/MyYp2lzthiKRUJRZcptPvgMYmhASBzByeUpvxJT6eIrsEy/NKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6z3T3NHFqFyaBLbgfGKLiyGTz6UlUJixgxmXOGYpTha9b5TAm
	SFRBOPmoWf8GDr3ryIDKDp/Nb0w3aHAWzn9YnL/PWOhlAwRm0k1Ky8hla8oggiDV
X-Gm-Gg: AYBFou00fsVfR3oqwgmZorlyn5wwQwhHQHiPKJ0JAsAxRHfr0hQvmz6BdanQaMSYYpS
	VX8nw0+8PLUgzT4uHl2jKBGwsF8ePgPFwC0Inamwb1iH8ZdsRG3pOmknVVJTuiS8aB838TWSvOs
	Hz0Hpe2k7rLwc2/OFMpTFdYZ+WKYy3pjywXlu5EOcNFGUHjFPSoAVrnTYG8FUN05q/esBSzQUTK
	oddbb3lBE4NgbITYffNpbjKo8+j8XW0S6I2cVnDo9f82VI8HXxzUVU1eWmHxNswV6nNDgrvm2cJ
	DpP8FvGOYqA/j+e1vfEIIqQm56XmB1Y7mt8xg3LuSkcPAbNlm08NKrxARrlxwhL+eeiPn0x2+1r
	HiDyXup+3rmxx/qTL+Izmo9Ilh+rfnjCh/80r+mRlrC+W6D2cY/PdFsD8RaXuEh7ZJNLQugthZy
	AswnXYe7hwtjhV8bPiik6SJccP+L5oeMGHaGtrpuO7rtT20Opj1qS7bGOsIvAC428t5dTcofnWE
	bTSp6mCA5azaC6oGoLqtJP+JUTHFkaUGb6+jbp9ZxYCh55bVGirnBOj+7O0sflOyKvoISYRVPFx
	lh6UQAPFPd7954/pXX6ocEZRQqMs1hWg0udgM+z6yOBHErToaLiYxQ==
X-Received: by 2002:a17:90a:e7c6:b0:39e:6c69:34da with SMTP id 98e67ed59e1d1-3acef589938mr1330275a91.62.1792200490320;
        Fri, 16 Oct 2026 18:28:10 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm12736358a91.9.2026.10.16.18.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:28:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 18/38] bpf: Check the new program of an iterator link update
Date: Sat, 17 Oct 2026 01:24:31 +0000
Message-ID: <20261017012451.364800-10-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

The bpf_map_elem, bpf_sk_storage_map and sockmap iterators hand the key
and the value of an element to the program as buffers.  The verifier only
records how far a program reaches into them, and ->attach_target()
compares that with the key and value size of the map.

bpf_iter_link_replace() does not.  BPF_LINK_UPDATE installs a program that
an attach refuses with -EACCES, and the program then reads, and for a
value writes, behind every element that the iterator visits.  It takes
CAP_BPF and CAP_PERFMON, or a BPF token.

Split the test out of the three ->attach_target() and ask it, as
->check_prog(), for the new program of an update as well.  Targets without
such a test take every program of their kind, as before.

Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
Fixes: 0365351524d7 ("net: Allow iterating sockmap and sockhash")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h       |  4 +++
 kernel/bpf/bpf_iter.c     |  7 ++++++
 kernel/bpf/map_iter.c     | 51 ++++++++++++++++++++++-----------------
 net/core/bpf_sk_storage.c | 17 ++++++++++---
 net/core/sock_map.c       | 17 ++++++++++---
 5 files changed, 66 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 46d325aa178e..3fb3c7d22d99 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3128,6 +3128,8 @@ typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
 					union bpf_iter_link_info *linfo,
 					struct bpf_iter_aux_info *aux);
 typedef void (*bpf_iter_detach_target_t)(struct bpf_iter_aux_info *aux);
+typedef int (*bpf_iter_check_prog_t)(const struct bpf_prog *prog,
+				     const struct bpf_iter_aux_info *aux);
 typedef void (*bpf_iter_show_fdinfo_t) (const struct bpf_iter_aux_info *aux,
 					struct seq_file *seq);
 typedef int (*bpf_iter_fill_link_info_t)(const struct bpf_iter_aux_info *aux,
@@ -3146,6 +3148,8 @@ struct bpf_iter_reg {
 	const char *target;
 	bpf_iter_attach_target_t attach_target;
 	bpf_iter_detach_target_t detach_target;
+	/* may the program run on what the link is attached to? */
+	bpf_iter_check_prog_t check_prog;
 	bpf_iter_show_fdinfo_t show_fdinfo;
 	bpf_iter_fill_link_info_t fill_link_info;
 	bpf_iter_get_func_proto_t get_func_proto;
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index fc3a75684ef7..4668c1696a08 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -436,6 +436,13 @@ static int bpf_iter_link_replace(struct bpf_link *link,
 		goto out_unlock;
 	}
 
+	if (iter_link->tinfo->reg_info->check_prog) {
+		ret = iter_link->tinfo->reg_info->check_prog(new_prog,
+							     &iter_link->aux);
+		if (ret)
+			goto out_unlock;
+	}
+
 	old_prog = xchg(&link->prog, new_prog);
 	bpf_prog_put(old_prog);
 
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 2077d46d167c..16537356c1a2 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -97,13 +97,29 @@ static struct bpf_iter_reg bpf_map_reg_info = {
 	.seq_info		= &bpf_map_seq_info,
 };
 
+static int bpf_iter_map_check_prog(const struct bpf_prog *prog,
+				   const struct bpf_iter_aux_info *aux)
+{
+	const struct bpf_map *map = aux->map;
+	u32 value_size = map->value_size;
+
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+		value_size = round_up(value_size, 8) * num_possible_cpus();
+
+	if (prog->aux->max_rdonly_access > map->key_size ||
+	    prog->aux->max_rdwr_access > value_size)
+		return -EACCES;
+
+	return 0;
+}
+
 static int bpf_iter_attach_map(struct bpf_prog *prog,
 			       union bpf_iter_link_info *linfo,
 			       struct bpf_iter_aux_info *aux)
 {
-	u32 key_acc_size, value_acc_size, key_size, value_size;
 	struct bpf_map *map;
-	bool is_percpu = false;
 	int err = -EINVAL;
 
 	if (!linfo->map.map_fd)
@@ -123,30 +139,20 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 		goto put_map;
 	}
 
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
-		is_percpu = true;
-	else if (map->map_type != BPF_MAP_TYPE_HASH &&
-		 map->map_type != BPF_MAP_TYPE_LRU_HASH &&
-		 map->map_type != BPF_MAP_TYPE_ARRAY &&
-		 map->map_type != BPF_MAP_TYPE_RHASH)
+	if (map->map_type != BPF_MAP_TYPE_PERCPU_HASH &&
+	    map->map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH &&
+	    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
+	    map->map_type != BPF_MAP_TYPE_HASH &&
+	    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+	    map->map_type != BPF_MAP_TYPE_ARRAY &&
+	    map->map_type != BPF_MAP_TYPE_RHASH)
 		goto put_map;
 
-	key_acc_size = prog->aux->max_rdonly_access;
-	value_acc_size = prog->aux->max_rdwr_access;
-	key_size = map->key_size;
-	if (!is_percpu)
-		value_size = map->value_size;
-	else
-		value_size = round_up(map->value_size, 8) * num_possible_cpus();
-
-	if (key_acc_size > key_size || value_acc_size > value_size) {
-		err = -EACCES;
+	aux->map = map;
+	err = bpf_iter_map_check_prog(prog, aux);
+	if (err)
 		goto put_map;
-	}
 
-	aux->map = map;
 	return 0;
 
 put_map:
@@ -179,6 +185,7 @@ static const struct bpf_iter_reg bpf_map_elem_reg_info = {
 	.target			= "bpf_map_elem",
 	.attach_target		= bpf_iter_attach_map,
 	.detach_target		= bpf_iter_detach_map,
+	.check_prog		= bpf_iter_map_check_prog,
 	.show_fdinfo		= bpf_iter_map_show_fdinfo,
 	.fill_link_info		= bpf_iter_map_fill_link_info,
 	.ctx_arg_info_size	= 2,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index ea22ec5ef5b1..72b9ee4c98de 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -919,6 +919,15 @@ static void bpf_iter_fini_sk_storage_map(void *priv_data)
 	bpf_map_put_with_uref(seq_info->map);
 }
 
+static int bpf_iter_map_check_prog(const struct bpf_prog *prog,
+				   const struct bpf_iter_aux_info *aux)
+{
+	if (prog->aux->max_rdwr_access > aux->map->value_size)
+		return -EACCES;
+
+	return 0;
+}
+
 static int bpf_iter_attach_map(struct bpf_prog *prog,
 			       union bpf_iter_link_info *linfo,
 			       struct bpf_iter_aux_info *aux)
@@ -936,12 +945,11 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
 		goto put_map;
 
-	if (prog->aux->max_rdwr_access > map->value_size) {
-		err = -EACCES;
+	aux->map = map;
+	err = bpf_iter_map_check_prog(prog, aux);
+	if (err)
 		goto put_map;
-	}
 
-	aux->map = map;
 	return 0;
 
 put_map:
@@ -972,6 +980,7 @@ static struct bpf_iter_reg bpf_sk_storage_map_reg_info = {
 	.target			= "bpf_sk_storage_map",
 	.attach_target		= bpf_iter_attach_map,
 	.detach_target		= bpf_iter_detach_map,
+	.check_prog		= bpf_iter_map_check_prog,
 	.show_fdinfo		= bpf_iter_map_show_fdinfo,
 	.fill_link_info		= bpf_iter_map_fill_link_info,
 	.ctx_arg_info_size	= 2,
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 38df84284328..057e2f3c0265 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1933,6 +1933,15 @@ int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	return ret;
 }
 
+static int sock_map_iter_check_prog(const struct bpf_prog *prog,
+				    const struct bpf_iter_aux_info *aux)
+{
+	if (prog->aux->max_rdonly_access > aux->map->key_size)
+		return -EACCES;
+
+	return 0;
+}
+
 static int sock_map_iter_attach_target(struct bpf_prog *prog,
 				       union bpf_iter_link_info *linfo,
 				       struct bpf_iter_aux_info *aux)
@@ -1951,12 +1960,11 @@ static int sock_map_iter_attach_target(struct bpf_prog *prog,
 	    map->map_type != BPF_MAP_TYPE_SOCKHASH)
 		goto put_map;
 
-	if (prog->aux->max_rdonly_access > map->key_size) {
-		err = -EACCES;
+	aux->map = map;
+	err = sock_map_iter_check_prog(prog, aux);
+	if (err)
 		goto put_map;
-	}
 
-	aux->map = map;
 	return 0;
 
 put_map:
@@ -1973,6 +1981,7 @@ static struct bpf_iter_reg sock_map_iter_reg = {
 	.target			= "sockmap",
 	.attach_target		= sock_map_iter_attach_target,
 	.detach_target		= sock_map_iter_detach_target,
+	.check_prog		= sock_map_iter_check_prog,
 	.show_fdinfo		= bpf_iter_map_show_fdinfo,
 	.fill_link_info		= bpf_iter_map_fill_link_info,
 	.ctx_arg_info_size	= 2,
-- 
2.55.0

