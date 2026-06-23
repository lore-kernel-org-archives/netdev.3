Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799538D41F
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237030; cv=none; b=XeT4UdoQBuquwt9JB16hB81RfR6VQhoq/+8sIWJ0EVjOIPp6KyGsYvdqNwnC1Pw3cXODg2yPsNzbFTDAP6/0+0xRxokqZa2hC4+eVIEUQD+cmx1LweIXyXM9uHNj58N1d7H6goDt5WefBxF6CkApDFckiUvHgEN2ixxomvqyPoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237030; c=relaxed/simple;
	bh=ZGL3IJOHyL+7eKXIOY0M3dUqq7I6qK4b8v4URX1L7rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hh3jg05i2TTYk3B2DwwvLRGKsn8b5jjdzm+Q8cp9ko2/+oGDWu6E3yFNIDKiT1Ej3vTPrLzse8ik0hjQOutRlzSwg5sXwCecFmfJrF3NXSgueaiDwtVHzCEUqyi2x58DcRz2nqgLyb6VIMOAyZNtrFib/ntTrg1z36IjShPkAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5TU4hls; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5TU4hls"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-48673dc56a8so173764b6e.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237028; x=1782841828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e5m1RLMouiVWD2h7XRJYeMBk8lfNuj+WNZNkZ0CvIM=;
        b=a5TU4hlsslxawFusNEZa1w5lLiCSiWowcm8YF80cNEYYfb17bSZExmvdGzJlm+Idob
         IMTmdKNmO+MHO5lJXpcqwPBHJcNZP7wdyL15damwIu4UdMYUuJMjFFTQ5yiRSwygqKIB
         KEafvYvBLfUo+FY/MiRy6IA9/juRwfGcP/3Llqw1YpMfRO2ATyKx2TRMZxycP3NcWBKT
         dQ12VCc5vYYTFxwCL6GtYqyV+5d5vENiN1ADn46ue8H0SzTqQKEqPv4R0+sqOsPO2Lia
         jnG8JnMWg5GWZnAo35m9vC0LxbGG7SbK5SwifZqQanykV+ymPNSDkVPBO428VdxE7iz8
         45ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237028; x=1782841828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3e5m1RLMouiVWD2h7XRJYeMBk8lfNuj+WNZNkZ0CvIM=;
        b=iXJTBDI5eTgyIxDV2svU6BRWtzyElPgnCN78l/s9EsaHDh+/+NczBLJaxb1Z0w289y
         yHypKnl9pXRCl60QuTG+jHGLOxpKIaeT+iJAEMcGLpJGk53ueJNeHf3ePaejSYhPGGJX
         9C2uo97a16dL057YMzpYmDmug+l4PSxX9TsymTSNFPUuGE4Thp4Mv7Of6/nZWEXoCzAU
         kH0Wx7/gdZyBHfgnms5fjIPqWOfRnR5EiEYU/XzNiTKDI0x27IAaKTZmsQaq30WJof3f
         BK0XMOeUwMYyrAwQtr6w7FIf/lzTJLJ9m/PY8plUK/lFCzjnIInunfbWliLFi0lGoRym
         UQUw==
X-Gm-Message-State: AOJu0Ywc8L9a70TYmtWXb4Sfc/QE/+WEEfMxCDF1zBkls62x9FcOyNrm
	Ul4AVOQn5YAGDQJb7706C7rnA4sf3nCuYF+0wmk7kY56vvFQ36O5Lnt1
X-Gm-Gg: AfdE7cmbWELFtXVFA9l7A0QcXSSFP+UIEPUZmDfUY47ohFCdHSZJgeUncgEMKbyGO6b
	bmvj2JTQurQ96aSGLpoeaKA1O6onoTI7/wz8b6qAHAiCqhHR2E0hmBlxm6ceuwIelvP0JKNWG0F
	Opu3603ccJgCpcB7LjpA1MuPjkfXPT1JYFFEVxop3p1KuTRpbiT3aYZNenb3tyMwB9f6VeMdXZU
	qUL4kTkG8iRMevhf0tSHnyqO6pJsN7YwqkNiMewlzLoJ6QaZzt9KmqcYMHHXAXvJtSSbsY5qj+i
	yXj+KNiAAkSeT3Bo/7hFesRmz/rcQ0OGWCrfuL1gG+waQ3Wdu5pZo8p7n3XM2Ag18kINolaRPO/
	DQdINAykY5AOn36zw2nnNVYOG8erwtg91Wql5izH+QdWtSUw1qFl0nZuo4ofjcXwbhhxn09OoCa
	dK80qCPLK9uRlH2Q==
X-Received: by 2002:a05:6808:c2ca:b0:48b:5031:1f29 with SMTP id 5614622812f47-48b50312032mr11683198b6e.32.1782237027844;
        Tue, 23 Jun 2026 10:50:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aee43aaf6sm7087671b6e.13.2026.06.23.10.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 13/15] libbpf: Support attaching struct_ops to a cgroup
Date: Tue, 23 Jun 2026 10:50:01 -0700
Message-ID: <20260623175006.3136053-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
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
---
 tools/lib/bpf/bpf.c            |  2 ++
 tools/lib/bpf/bpf.h            |  3 +-
 tools/lib/bpf/libbpf.c         | 59 ++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h         |  3 ++
 tools/lib/bpf/libbpf.map       |  5 +++
 tools/lib/bpf/libbpf_version.h |  2 +-
 6 files changed, 72 insertions(+), 2 deletions(-)

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
index 1368752aa13c..17f8466e33fa 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -14104,6 +14104,65 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
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
index b965ad571540..0e5f4e9bba41 100644
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
index b731df19ae69..1b01d49e58eb 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -462,3 +462,8 @@ LIBBPF_1.8.0 {
 		bpf_program__clone;
 		btf__new_empty_opts;
 } LIBBPF_1.7.0;
+
+LIBBPF_1.9.0 {
+	global:
+		bpf_map__attach_cgroup_opts;
+} LIBBPF_1.8.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index c446c0cd8cf9..57b74ef3618c 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 8
+#define LIBBPF_MINOR_VERSION 9
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.53.0-Meta

