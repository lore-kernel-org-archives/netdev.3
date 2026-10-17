Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E053ADBA4
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255247; cv=none; b=BqdAvI/ZkYoK9bkaCx59f9ZDz4dOt8fAXdOrOenn18slYJ/J1b5burXChitOT6ICvlqkPyhx19uMkUt7aqSIEiCWI1ffeujucLhdQUQW9TqPKjUkxBZHgaIakaMF/ythpss4TMs3cZ8rU3vvr05HRa+7Jl7h/5tnFhYO02ehlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255247; c=relaxed/simple;
	bh=um1/1t7n+I78zolH5NTwTJ2dVIX8lr94rL5OHG9OBdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqXQ87l7e/WbJ6jqI9PTTbcq3cYn78soRv75cQ+mnSI3cndLWyBP+ilphzKc7YA5oixyltwlCzGwlTZDf3B5KpscY1UBj7rLR0PekBEd7TQFOhgFWCgIJXt3/M2x8BTRKMtY7pumrP3fQcDAN5tDOt21cw0n9bGaeaZBFpco4AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TguTudZW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TguTudZW"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8819033dbadso563759b3a.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255246; x=1792860046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R4owM+4UIbkPlzeLvQJYBaaustOiqEzORXd5E7QETKs=;
        b=TguTudZW9HvAwTMXnCh0VVGNCyC2rBv7lK9R40WpS4E3akBmOg4T72MOqhEg55FHa3
         ikctbY7t1mQnoNSP1zY/a9Rmih2V7xUg+Rpkw22mZ4+FnHBOIuwtNbl3U+wPRZU1EsKb
         0qErvwI5gyZwnTaAXhJagpBOWBQHeqpvb7AyrFzD7FUlzK7yUuidxml9sCZ1jOUql8vv
         L0BIx/5AaYsM/18h/e5eQlROArTwCKrj32KZvu6peQQR1Hs7x9fL+HsaSY8CnWpSKLeG
         AeoWchG8uhCtNQSzbClsHJHwK2t2qVtnZhi//B253PZqtseHKJ7JTCAWUoIemWPlUyWl
         +ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255246; x=1792860046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R4owM+4UIbkPlzeLvQJYBaaustOiqEzORXd5E7QETKs=;
        b=A/bJUkb24gT4qkAauAxrwjfVw2I288Ah8cE+5QwbvsAoIdoKwMyuQw/fOho8DIX64N
         VKqYPTd6UQYJgtvU6hZCxBeQV6TGmsn1UZwjKrkirVOoP6894NKMf4JwQQkog+9AV0oM
         g4sPT1mArZ1JZLH/bec6FqlocJKMOKLA/8TTC+02cszBqHBoAiJdJJ7nAkXG/Ed2X4Gh
         XtRvBAplnfoT3o3R+CyygQIVWe4ajvtPDG09TV/ha7L6GPFKdCReaBZZhGchdh4Q8TJC
         RYgOfkTTsbI5RS+GpQzGTLW0qbrjrg3bKEt5dBAg6r7apN3Re0kUTCMo7VdyfXWI7lWQ
         hdvw==
X-Forwarded-Encrypted: i=1; AKwUvByv6hyhi4rqiQxUDsrE1pIdXRikzprpIq1GfkavLPfYY5Q2VsSTEdKZCnh9UC62Gfy6dzZ2+aI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+PyLY69NiJ3gXhjVTl97Wwt5fwA2iILmmzObkeeoW2NLPTuq5
	KW4Jsfm5GpGDhIOQzYjD8HhY3rnG1vuKZkR7CDhv3a69pL4Znht/C0kG
X-Gm-Gg: AYBFou3PHkyTaDzkK7ChIeaOBwfuBq0YxOcGBju9Qz0EU9KjOnWECZ5xMyRC0SxfzpZ
	vMKIBm2a15skjd45Br80DvAEzCsT6cip4W9jMTnjHJJ1Wnaj2Bv+LIysykQp0nETEKY9ehYNDLz
	Js/VVtpE2EOWK8hfeigc4SyGSouKUfEuKVA8PFkpVhIviy1hE+ge/wpdAeEH1I2BCpIY6qi5Njn
	cp8Rvi95gYnmobFAD1C39mpT/BbHStSLY+mSyrFo92EfmevjTqwMy8ZakRVMOJ/9BW3CJPZ7KzW
	6sWxBJdULTP/7pghIRsyqahCPUUb8e1YKZPxdD+0TerGoDr4clkiO4sZmPdGiRfM7+qf6O+OYR3
	/rxE+x2oNECTeeUeAHGPt4d0a6tZJBVT1BXWvWVdqaRxE/viQjkQf+42e0Iu/g2G9RPA8M+AqMZ
	LeheZe9v5ZIVpVIGGUeC71LRhs7HXDH5lA/SpkYC3jsx9Dt6p0dpYPrQpVQN/wpP5V8B/v0Rfj2
	otMk5243U9N/fwvdIo+NgQRy2EExEYz55b4lLyALcGNiw/QtxUrWKGFB9oRtvF4xdrL/pG57qMx
	CRR8HHGEpkgHWb9KwUnJGUzLWmtr7sYfp0C9nqP9yOY=
X-Received: by 2002:a05:6a20:c79b:b0:3dd:85a9:55ac with SMTP id adf61e73a8af0-3e226064b01mr2038186637.37.1792255245692;
        Sat, 17 Oct 2026 09:40:45 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a0cf97sm2370232a12.24.2026.10.17.09.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 29/43] bpf: Keep iterator programs off special map fields
Date: Sat, 17 Oct 2026 16:37:31 +0000
Message-ID: <20261017163745.3341787-30-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

The bpf_map_elem iterator, for all but the per-cpu maps, and the
bpf_sk_storage_map iterator hand the live value of an element to the
program as a writable buffer.  The verifier does not know the map when it
checks the program, so nothing keeps the program from writing over a
bpf_spin_lock, a bpf_timer, a kptr or another special field, which neither
a map update nor a pointer to a map value can touch.  With CAP_BPF and
CAP_PERFMON, or a BPF token, a program can so make the kernel follow a
pointer of its choice: after a write over a bpf_timer the kernel crashes
on the written value when the element is removed.

Offsets into a buffer are constants.  Let the verifier record the range of
bytes that a program may write through a read-write buffer, and refuse the
program with -EACCES, at attach and at a link update, if a special field
of the map lies in that range.

A program that only reads, or that writes beside the special fields, works
as before.  One that writes on both sides of a special field is refused,
since the range covers the field.

Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h       |  5 +++++
 kernel/bpf/map_iter.c     | 36 ++++++++++++++++++++++++++++++++----
 kernel/bpf/verifier.c     | 12 +++++++++---
 net/core/bpf_sk_storage.c |  2 +-
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1823ca3a1d5e..22947fa192e4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1866,6 +1866,9 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	/* [min, max): the bytes of a rdwr buffer that may be written */
+	u32 min_rdwr_write;
+	u32 max_rdwr_write;
 	u32 subprog_start;
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
@@ -3204,6 +3207,8 @@ void bpf_iter_map_show_fdinfo(const struct bpf_iter_aux_info *aux,
 			      struct seq_file *seq);
 int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
 				struct bpf_link_info *info);
+int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
+				   const struct bpf_map *map);
 
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 16537356c1a2..a58c148692e6 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -97,22 +97,50 @@ static struct bpf_iter_reg bpf_map_reg_info = {
 	.seq_info		= &bpf_map_seq_info,
 };
 
+/*
+ * For an iterator that hands the live map value to the program as a writable
+ * buffer: the verifier knows nothing of the map, so the special fields of the
+ * value have to lie outside of what the program may write.
+ */
+int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
+				   const struct bpf_map *map)
+{
+	const struct btf_record *rec = map->record;
+	const struct btf_field *field;
+	u32 i;
+
+	if (IS_ERR_OR_NULL(rec) || !prog->aux->max_rdwr_write)
+		return 0;
+
+	for (i = 0; i < rec->cnt; i++) {
+		field = &rec->fields[i];
+		if (field->offset < prog->aux->max_rdwr_write &&
+		    field->offset + field->size > prog->aux->min_rdwr_write)
+			return -EACCES;
+	}
+
+	return 0;
+}
+
 static int bpf_iter_map_check_prog(const struct bpf_prog *prog,
 				   const struct bpf_iter_aux_info *aux)
 {
 	const struct bpf_map *map = aux->map;
 	u32 value_size = map->value_size;
+	bool is_percpu;
 
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+	is_percpu = map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
+	if (is_percpu)
 		value_size = round_up(value_size, 8) * num_possible_cpus();
 
 	if (prog->aux->max_rdonly_access > map->key_size ||
 	    prog->aux->max_rdwr_access > value_size)
 		return -EACCES;
 
-	return 0;
+	/* the program gets a copy of a per-cpu value */
+	return is_percpu ? 0 : bpf_iter_map_check_value_write(prog, map);
 }
 
 static int bpf_iter_attach_map(struct bpf_prog *prog,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d1b729989d6..2c812a5f1da8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6053,9 +6053,10 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 			       const struct bpf_reg_state *reg,
 			       argno_t argno, int off, int size,
 			       bool zero_size_allowed,
-			       u32 *max_access)
+			       u32 *max_access, bool write)
 {
 	const char *buf_info = type_is_rdonly_mem(reg->type) ? "rdonly" : "rdwr";
+	struct bpf_prog_aux *aux = env->prog->aux;
 	u32 access_end;
 	int err;
 
@@ -6064,6 +6065,11 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 		return err;
 
 	*max_access = max(access_end, *max_access);
+	if (write && size) {
+		if (!aux->max_rdwr_write || access_end - size < aux->min_rdwr_write)
+			aux->min_rdwr_write = access_end - size;
+		aux->max_rdwr_write = max(access_end, aux->max_rdwr_write);
+	}
 
 	return 0;
 }
@@ -7339,7 +7345,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		}
 
 		err = check_buffer_access(env, reg, argno, off, size, false,
-					  max_access);
+					  max_access, t == BPF_WRITE);
 
 		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
@@ -7852,7 +7858,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
 		}
 		return check_buffer_access(env, reg, argno, 0,
 					   access_size, zero_size_allowed,
-					   max_access);
+					   max_access, access_type == BPF_WRITE);
 	case PTR_TO_STACK:
 		return check_stack_range_initialized(
 				env, reg,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 72b9ee4c98de..1c59300af05c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -925,7 +925,7 @@ static int bpf_iter_map_check_prog(const struct bpf_prog *prog,
 	if (prog->aux->max_rdwr_access > aux->map->value_size)
 		return -EACCES;
 
-	return 0;
+	return bpf_iter_map_check_value_write(prog, aux->map);
 }
 
 static int bpf_iter_attach_map(struct bpf_prog *prog,
-- 
2.55.0

