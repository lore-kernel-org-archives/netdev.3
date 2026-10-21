Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598426;
	b=c09XFoIRBK7DE+1RA+ExxPtcv0g5Dom5wZg3s9BIfl/a5IbIc/HGrBZWDSxjCMKsCZsP
	 vklkKsrXmBY0uQ9EUHEnvDsGleCIS7pJGD122GQU9ycOJNzlyj+GD475NydiEMGp6iuok
	 mci0pdkdvjrYk5rLvVneX0v5AfLdNwBZVExjkcMfE1lDafcyIfhPeQx2I059v/sDFthKa
	 JI2SXdZxra4Rm0YmU1QzgPpWIpAhHxgv2lT2fCQa6pFfZMtg5jlrj5Sqc/F97+3syx8AH
	 dDqd2+YRSvmlwFJ49bvt3YRiJNS6Q+8/zfiPOMbOKGMuj9X2JxMNIYiMkvVD2vvzlXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MGFvqqn3euXlj3F0laS2ESW93J/sfAW3g+VucUJGjqw=;
	b=IGDeim4CTrE0I0zxQUBysI5B6Fz7D6cj/K4ddHLFPCTt9PJ914m+KsgwXXWGkjOWJSq9
	 ENudz78AoihSmN8WcWkwRp/8ExNcZ+uv2YA6VoJLUB4DCFIGQ78vdLHy4EI4Gfjez4uw+
	 Xmzrr/96QCCmS6q4pUpYQ4QZSDJ/gNemqfDdc3xB7CB31JKxKod7iXu7y1eTuguwCozcj
	 a8FTkSr7caoGJcOAp5jo9oEhPxd3XrMXuxB21LE8wWe4/sqtwR3MhDVtSl7XaSxBkupu8
	 Y78G3XhSOl2/FAS3bl4OSQXanQqtRfQE4fcxrhvKnncQqVTs8MUapXKRvOiSBB16/+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TBZl0kP2;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E5606A31E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E83E5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TBZl0kP2
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e95bd1c14cso7584075ad.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792598425; x=1793203225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGFvqqn3euXlj3F0laS2ESW93J/sfAW3g+VucUJGjqw=;
        b=TBZl0kP2YZzgLgb6bB6Zxv5GHqh4/OXEdZ0sxR7+yc88OHPRm552DohWrm2M3uSc7K
         ADyNFVHBQ5+JeLpoYITWpKaGd4wEp7TpsxYtGfzPyXWemAf0r1dpdC1/29baEG5no9ol
         q/tmeFmda/2hPxPzHRbO3HV8i0L5Yy5gC5r+4z6ne9uBKKFas+EyNeungcArGJ9xWuxl
         an2VhVWYj5P0I0XTfGPUowezn83b7MYgTWNKWkAZP8wcdrPAii3u3nLz3ZHmgZZDuSZX
         NxWzoghnwkOs/UFnlgS9/+R/6Nf+nKYuGgCKzzbSqhalEa49JrrUWnYkoBnU94eijWS5
         wagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598425; x=1793203225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGFvqqn3euXlj3F0laS2ESW93J/sfAW3g+VucUJGjqw=;
        b=QK7HufNwEB7Q3X83YNTICL2YokUl7j7+sRYyvW2AJraZ/4cJ3lmxprWY/zwxN+lDJL
         CCQphoog1fkUhCtS1+1ya9WqHr16F2zDBHd0POIifU/skfLUJ47oaJ/kOVGbznF7qBaS
         7cM0WYoC/TPMJjLBIdDeVpIlzFz3OOdit6FHbMg5/U1BJ03mIwKMH5uVogdkUVv8fnqH
         ARlQpV69Pj64/HtlZ3/1OeRdT0zVKFkIHs0Am+GqtiomIofBravKvn3xOQ2q13inMMoM
         6/kvY85S9VlDnG4a/ZBsE/8tEzYiBeInP6Ko5vyHbLyAdtLabj1jOKFMqwDExPX7V4Ia
         qtUg==
X-Gm-Message-State: AFq9FYLoKaaR8S+d9w2zsikEaXAvdev6LB35z0KB24kmBso/3QHNiok5
	aZirBuxoh8HmVihpdtik2c+cfP5FZIosufudsqcCUs1teEfUHhTUiEVzXWQ4cbRFrADGIvcpgkD
	4Xvcsmes=
X-Gm-Gg: AYBFou2LLI+I2ULf0iLtCrSaRsnYnZUJmBc2//OiF99xI6Fm/9yU2ftMauGxovUk4B0
	94E8ImNd2zUm7J1qyFjjAMe1P3Wi5OE3OIDHJN/VXyF6iADhPeoBNDePpip4Y4GOss1yLBdOGeH
	J0K61Cld3+VdE+e+T9HEom93UKpqUg6Cb9M4IFcZDJA79A1IjfCzQsi/6WjogXFhQKY4hvRmvBO
	ujqW57Txd0lAUVCyMcLeH/Ed17CymJWxPwBO5vuiXGh6KgIVuf+JmWun7LoMzjq0LEZwYaPsZSk
	JPKrBbEuGlKnvnq+7il00xnszHbApy2MXbsNgK3FvirQ2xe2RfQRp3LEu8z4I+XSwxW9iCCYtuW
	HoPjlv2sle9HUSryWPQqVv8ch+2+71S7ksFsyLJ0ZCoD24tyfAcyD0qgY+d3ARmo/QZ8bR3D+6F
	iIRXCd9ENLICNlu+aQ/hMhjbHA4iVKWqDOh/6DGwWjtYHsJ0hKxrxnAlNJX9ki6ATem9kXMiFyu
	kFjVoeB4Avdt+ZhS9j5QIbSfZ6mTNgnhyIh2sVjPfBM6SoxQM6/mOl6w1CeMFnLjgfpw4xHz8YP
	mAWCKKB8s77T6Uqis8o=
X-Received: by 2002:a17:90b:3bc5:b0:3a8:5d1f:59ad with SMTP id 98e67ed59e1d1-3ad8707bb75mr2063008a91.43.1792598425093;
        Wed, 21 Oct 2026 09:00:25 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada493261asm85664a91.12.2026.10.21.09.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:00:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/2] lib: add root path argument to get_task_name
Date: Wed, 21 Oct 2026 08:57:22 -0700
Message-ID: <20261021160020.3838946-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021160020.3838946-1-stephen@networkplumber.org>
References: <20261021160020.3838946-1-stephen@networkplumber.org>
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

Allow callers to read comm from somewhere other than /proc,
so ss can honor PROC_ROOT and look up per-thread names.
Existing callers pass NULL to keep using /proc.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/utils.h | 2 +-
 ip/iptuntap.c   | 2 +-
 lib/fs.c        | 9 +++++++--
 rdma/res-cmid.c | 2 +-
 rdma/res-cq.c   | 2 +-
 rdma/res-ctx.c  | 2 +-
 rdma/res-mr.c   | 2 +-
 rdma/res-pd.c   | 2 +-
 rdma/res-qp.c   | 2 +-
 rdma/res-srq.c  | 2 +-
 rdma/stat.c     | 2 +-
 11 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index 5812d1a8..87b115d9 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -312,7 +312,7 @@ char *find_cgroup2_mount(bool do_mount);
 __u64 get_cgroup2_id(const char *path);
 char *get_cgroup2_path(__u64 id);
 int get_command_name(const char *pid, char *comm, size_t len);
-int get_task_name(pid_t pid, char *name, size_t len);
+int get_task_name(const char *root, pid_t pid, char *name, size_t len);
 
 int get_rtnl_link_stats_rta(struct rtnl_link_stats64 *stats64,
 			    struct rtattr *tb[]);
diff --git a/ip/iptuntap.c b/ip/iptuntap.c
index 0f46fe6a..d1ff48b3 100644
--- a/ip/iptuntap.c
+++ b/ip/iptuntap.c
@@ -315,7 +315,7 @@ static void show_processes(const char *name)
 				SPRINT_BUF(pname);
 
 				open_json_object(NULL);
-				if (get_task_name(pid, pname, sizeof(pname)))
+				if (get_task_name(NULL, pid, pname, sizeof(pname)))
 					print_string(PRINT_ANY, "name",
 						     "%s", "<NULL>");
 				else
diff --git a/lib/fs.c b/lib/fs.c
index 86f9fb65..a7d23498 100644
--- a/lib/fs.c
+++ b/lib/fs.c
@@ -343,7 +343,11 @@ int get_command_name(const char *pid, char *comm, size_t len)
 	return 0;
 }
 
-int get_task_name(pid_t pid, char *name, size_t len)
+/*
+ * Read task name from <root>/<pid>/comm.
+ * If root is NULL, use /proc.
+ */
+int get_task_name(const char *root, pid_t pid, char *name, size_t len)
 {
 	char path[PATH_MAX];
 	FILE *f;
@@ -351,7 +355,8 @@ int get_task_name(pid_t pid, char *name, size_t len)
 	if (!pid)
 		return -1;
 
-	if (snprintf(path, sizeof(path), "/proc/%d/comm", pid) >= sizeof(path))
+	if (snprintf(path, sizeof(path), "%s/%d/comm",
+		     root ? : "/proc", pid) >= sizeof(path))
 		return -1;
 
 	f = fopen(path, "r");
diff --git a/rdma/res-cmid.c b/rdma/res-cmid.c
index 17a89cc4..da783567 100644
--- a/rdma/res-cmid.c
+++ b/rdma/res-cmid.c
@@ -158,7 +158,7 @@ static int res_cm_id_line(struct rd *rd, const char *name, int idx,
 
 	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
 		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
-		if (!get_task_name(pid, b, sizeof(b)))
+		if (!get_task_name(NULL, pid, b, sizeof(b)))
 			comm = b;
 	} else if (nla_line[RDMA_NLDEV_ATTR_RES_KERN_NAME]) {
 		/* discard const from mnl_attr_get_str */
diff --git a/rdma/res-cq.c b/rdma/res-cq.c
index 0cab3fe0..49f3ef6b 100644
--- a/rdma/res-cq.c
+++ b/rdma/res-cq.c
@@ -86,7 +86,7 @@ static int res_cq_line(struct rd *rd, const char *name, int idx,
 
 	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
 		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
-		if (!get_task_name(pid, b, sizeof(b)))
+		if (!get_task_name(NULL, pid, b, sizeof(b)))
 			comm = b;
 	} else if (nla_line[RDMA_NLDEV_ATTR_RES_KERN_NAME]) {
 		/* discard const from mnl_attr_get_str */
diff --git a/rdma/res-ctx.c b/rdma/res-ctx.c
index 235c837a..e44fd8f7 100644
--- a/rdma/res-ctx.c
+++ b/rdma/res-ctx.c
@@ -20,7 +20,7 @@ static int res_ctx_line(struct rd *rd, const char *name, int idx,
 
 	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
 		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
-		if (!get_task_name(pid, b, sizeof(b)))
+		if (!get_task_name(NULL, pid, b, sizeof(b)))
 			comm = b;
 	} else if (nla_line[RDMA_NLDEV_ATTR_RES_KERN_NAME]) {
 		/* discard const from mnl_attr_get_str */
diff --git a/rdma/res-mr.c b/rdma/res-mr.c
index f6c2534a..17b2242f 100644
--- a/rdma/res-mr.c
+++ b/rdma/res-mr.c
@@ -50,7 +50,7 @@ static int res_mr_line(struct rd *rd, const char *name, int idx,
 
 	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
 		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
-		if (!get_task_name(pid, b, sizeof(b)))
+		if (!get_task_name(NULL, pid, b, sizeof(b)))
 			comm = b;
 	} else if (nla_line[RDMA_NLDEV_ATTR_RES_KERN_NAME]) {
 		/* discard const from mnl_attr_get_str */
diff --git a/rdma/res-pd.c b/rdma/res-pd.c
index 8b9f7aa6..f3a17055 100644
--- a/rdma/res-pd.c
+++ b/rdma/res-pd.c
@@ -36,7 +36,7 @@ static int res_pd_line(struct rd *rd, const char *name, int idx,
 
 	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
 		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
-		if (!get_task_name(pid, b, sizeof(b)))
+		if (!get_task_name(NULL, pid, b, sizeof(b)))
 			comm = b;
 	} else if (nla_line[RDMA_NLDEV_ATTR_RES_KERN_NAME]) {
 		/* discard const from mnl_attr_get_str */
diff --git a/rdma/res-qp.c b/rdma/res-qp.c
index 231ae99c..2593b6ed 100644
--- a/rdma/res-qp.c
+++ b/rdma/res-qp.c
@@ -160,7 +160,7 @@ static int res_qp_line(struct rd *rd, const char *name, int idx,
 
 	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
 		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
-		if (!get_task_name(pid, b, sizeof(b)))
+		if (!get_task_name(NULL, pid, b, sizeof(b)))
 			comm = b;
 	} else if (nla_line[RDMA_NLDEV_ATTR_RES_KERN_NAME]) {
 		/* discard const from mnl_attr_get_str */
diff --git a/rdma/res-srq.c b/rdma/res-srq.c
index 8ab2538a..3c6333ad 100644
--- a/rdma/res-srq.c
+++ b/rdma/res-srq.c
@@ -190,7 +190,7 @@ static int res_srq_line(struct rd *rd, const char *name, int idx,
 
 	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
 		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
-		if (!get_task_name(pid, b, sizeof(b)))
+		if (!get_task_name(NULL, pid, b, sizeof(b)))
 			comm = b;
 	} else if (nla_line[RDMA_NLDEV_ATTR_RES_KERN_NAME]) {
 		/* discard const from mnl_attr_get_str */
diff --git a/rdma/stat.c b/rdma/stat.c
index 2c1bf68e..f2c2d173 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -259,7 +259,7 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
 
 	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
 		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
-		if (!get_task_name(pid, b, sizeof(b)))
+		if (!get_task_name(NULL, pid, b, sizeof(b)))
 			comm = b;
 	} else if (nla_line[RDMA_NLDEV_ATTR_RES_KERN_NAME]) {
 		/* discard const from mnl_attr_get_str */
-- 
2.53.0

