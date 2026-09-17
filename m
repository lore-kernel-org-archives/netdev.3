Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B34EB870
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675581; cv=none; b=uaUiWddhoq375BCFmDJwKxF/uUEGwxkY7+SQfKHm7Sf0w5fJjmikszLKLjxCRJMZE0YMHegsZC6dfNW4Y92QTVUvNI7YLmy9nH9V/PQ+9BZdDC6OvA0dB0VBDGTExrZHC4xCD9ov5Ji0qa6KdJ9leqAvcHGCSBYalY6thBjJu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675581; c=relaxed/simple;
	bh=RC2+tW4VR4DAhhKfFjUFIbMmCAIhkkge84EG8Fe5/X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZGQV0/U18JTGI+mtDxS7ExNQuejLB84aNfCrr7NL3KFVkEOle7M6G7hnmYYASaaUqDqcftWfS34eHQMx1C+rRrMxyEVa1iV5S0ej//POThoxRIJ7K38LOiKoaMI/vPqZrfLBeykpMBlTIAsR/E+nNaog42InTdTUKGa1uyTrVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHzJKrPF; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHzJKrPF"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6b1ae6c9b72so2529eaf.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675572; x=1790280372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vL9wP24mFmHeGwvfZtLCTzrcqEIhTjmWJiDIIo2LIVs=;
        b=dHzJKrPF4/dtFSy5u9+VM5HIkHb51pvV+1LIIueWpw6dcIVIyM7S/6XIQcKcW7YX6T
         uJum6DJ0opSqitBESPJYDA3loh6Bjs8zc9rD4VKk8+tV3QxBGrEhnFlx05tTM88mvpM0
         l5cXI5jfVxdjeMXQid//H8xPAVTGEMHgg9aVX4ju2Lt1G9bBTDNKZJRsc39DGHsk+/9s
         5tTAavJDMmlhR2MwcZR3mG93LfM0uZ/PVgrqEqDSSX/p99r+SX+dKQu9+FWvQvz8oHz/
         BlGFToUF5RNPfURLHvonaY/O8iVmKMlvX/a+EagT+Hl882AdHw8Do2Pfryk+nLqcrDkY
         GuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675572; x=1790280372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vL9wP24mFmHeGwvfZtLCTzrcqEIhTjmWJiDIIo2LIVs=;
        b=rSYYuA7xPfKa9LADpwWdScu/FalXOLQYGc57oqJBluQAnOxO8Dx3c5BM+ZapGZeRxX
         PbJzM+It3JSODuRJ0JvT0018/W8i7QnfxWkP3zr6WhTCcwBNXINqvr/tpG2z6fhbII+P
         8+FfNuMaVrIhM63Th20ruqLoShMV9Orq+MB4nc2B2rPlhyJhBVl0VtQRXMUeeN0EAnQ5
         GQcuIwsIx1A59VUG772jFFSFkREBeYHiXUgu28vmi3r2KKCVFNsXkWDOnaYGXgGNz09E
         1aqStOVQGV8xqk/ypIkrjDGzI/95n5hB9yqS0Cu57ug8cazG9POAHCKVaThNZ2YSifEE
         tVXg==
X-Gm-Message-State: AFuF++nD6J/HrykRjMv92IpyFgqtnCT9feP8dZdHSFkw8+3E+HRy7OpV
	bPbyPyTS+pP5ZKXCmqzSOHfDAcD/BdtwjfV8PPXAqqSrFjl7U8nlMswa
X-Gm-Gg: AYBFou3DKxLCKtzzbn4Drn/lLCrwl23WnDql6Ud7xHpkDObrSk5c7yQknX1gBnz4EK5
	WgKefGH+5msWlCjG9gHZmF40zYAtMfIAmpCfojHQe144j4rHABFhZ9Nqmv4v1n+N3JRZCg7yNAJ
	EYu9Wi/S2CpQGClLaG/taPkmIjHwcl8vyuqFCaFLFaoFMZm/ZFjbW017VJRmokQmplkcfh3uaIu
	QivSg3ctWxhQaqJqjmnT1PwC743h756DW8/IBJcFB8lpx2CCcK9WCcU+AIYTX8akPScRlmYuAJZ
	xLf/zlO5QyQmzooFzcPAutjOF/spESUqJn3SOViP1BABR1vOHxNEtBobq6/ydyMpQlZpe4XkAcV
	QSPBnpfLbAFltezkeTED1pirdhgI/wTc65R8FPfTjtBypBEFmUIsh8stvaT35kZLg5zz7NTxeyG
	nTatxf9sPcJLHIrdmyyalDkq8VJ8G7F2T7qJCuLQc2NLTkU18tZSBkJvbNdOSJGw==
X-Received: by 2002:a05:6820:4c0e:b0:6bd:b927:672f with SMTP id 006d021491bc7-6ca90d95792mr202275eaf.9.1789675572080;
        Thu, 17 Sep 2026 13:06:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f641b56bsm4156757eaf.7.2026.09.17.13.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:06:11 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 13/15] libbpf: Support attaching struct_ops to a cgroup
Date: Thu, 17 Sep 2026 13:05:39 -0700
Message-ID: <20260917200542.3689605-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

Add bpf_map__attach_cgroup_opts() to attach a struct_ops map to a cgroup
through a BPF link.

Also extend struct bpf_prog_query_opts with a type_id field so a
BPF_STRUCT_OPS query on a cgroup can select the struct_ops type to
enumerate.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/bpf.c      |  2 ++
 tools/lib/bpf/bpf.h      |  3 +-
 tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  3 ++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 96819c082c77..a9de7f107cf7 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -934,6 +934,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_CGROUP_GETSOCKOPT:
 	case BPF_CGROUP_SETSOCKOPT:
 	case BPF_LSM_CGROUP:
+	case BPF_STRUCT_OPS:
 		relative_fd = OPTS_GET(opts, cgroup.relative_fd, 0);
 		relative_id = OPTS_GET(opts, cgroup.relative_id, 0);
 		if (relative_fd && relative_id)
@@ -1056,6 +1057,7 @@ int bpf_prog_query_opts(int target, enum bpf_attach_type type,
 	attr.query.attach_type		= type;
 	attr.query.query_flags		= OPTS_GET(opts, query_flags, 0);
 	attr.query.count		= OPTS_GET(opts, count, 0);
+	attr.query.type_id		= OPTS_GET(opts, type_id, 0);
 	attr.query.prog_ids		= ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
 	attr.query.link_ids		= ptr_to_u64(OPTS_GET(opts, link_ids, NULL));
 	attr.query.prog_attach_flags	= ptr_to_u64(OPTS_GET(opts, prog_attach_flags, NULL));
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7534a593edae..490e8cb4ba53 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -637,9 +637,10 @@ struct bpf_prog_query_opts {
 	__u32 *link_ids;
 	__u32 *link_attach_flags;
 	__u64 revision;
+	__u32 type_id;
 	size_t :0;
 };
-#define bpf_prog_query_opts__last_field revision
+#define bpf_prog_query_opts__last_field type_id
 
 /**
  * @brief **bpf_prog_query_opts()** queries the BPF programs and BPF links
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 613afae26519..247ee90d151a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -14169,6 +14169,70 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 	return &link->link;
 }
 
+struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf_map *map, int cgroup_fd,
+					     const struct bpf_cgroup_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
+	struct bpf_link_struct_ops *link;
+	__u32 relative_id, zero = 0;
+	int err, fd, relative_fd;
+
+	if (!OPTS_VALID(opts, bpf_cgroup_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	if (!bpf_map__is_struct_ops(map)) {
+		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	if (map->fd < 0) {
+		pr_warn("map '%s': can't attach BPF map without FD (was it created?)\n", map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	if (!(map->def.map_flags & BPF_F_LINK)) {
+		pr_warn("map '%s': can't attach to cgroup without BPF_F_LINK\n", map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	relative_id = OPTS_GET(opts, relative_id, 0);
+	relative_fd = OPTS_GET(opts, relative_fd, 0);
+
+	if (relative_fd && relative_id) {
+		pr_warn("map '%s': relative_fd and relative_id cannot be set at the same time\n",
+			map->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	link_create_opts.cgroup.expected_revision = OPTS_GET(opts, expected_revision, 0);
+	link_create_opts.cgroup.relative_fd = relative_fd;
+	link_create_opts.cgroup.relative_id = relative_id;
+	link_create_opts.flags = OPTS_GET(opts, flags, 0);
+
+	link = calloc(1, sizeof(*link));
+	if (!link)
+		return libbpf_err_ptr(-ENOMEM);
+
+	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
+	if (err && err != -EBUSY) {
+		free(link);
+		return libbpf_err_ptr(err);
+	}
+
+	link->link.detach = bpf_link__detach_struct_ops;
+
+	fd = bpf_link_create(map->fd, cgroup_fd, BPF_STRUCT_OPS, &link_create_opts);
+	if (fd < 0) {
+		free(link);
+		return libbpf_err_ptr(fd);
+	}
+
+	link->link.fd = fd;
+	link->map_fd = map->fd;
+
+	return &link->link;
+}
+
 /*
  * Swap the back struct_ops of a link with a new struct_ops map.
  */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 48266e752223..026932f20962 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -960,6 +960,9 @@ bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgroup_fd,
 struct bpf_map;
 
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
+LIBBPF_API struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf_map *map,
+							int cgroup_fd,
+							const struct bpf_cgroup_opts *opts);
 LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
 
 struct bpf_iter_attach_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a811a1b3a085..7a84dd00ce95 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,6 +458,7 @@ LIBBPF_1.7.0 {
 
 LIBBPF_1.8.0 {
 	global:
+		bpf_map__attach_cgroup_opts;
 		bpf_program__add_flags;
 		bpf_program__attach_tracing_multi;
 		bpf_program__clear_flags;
-- 
2.52.0

