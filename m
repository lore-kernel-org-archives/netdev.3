Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597187;
	b=2+FjaYx5TdSvkq8klzUNPNEhhxVoOJoynXOYVFS2Hzj+nw7i9PA9IO6yoQvpC3p+zshW
	 wQqyTXZ95OZGVe2RPYQ8KUdEi5aBsnJjnXAFniSpyxM7/SVeGdMkZlKZnvo8P8lWUinr3
	 qJI+6BWu739bD3L17SMKnqwGOy8nHWdGRADnMXe0vWKIAr2tcX8EKfl1gEGX/dR6zH/Ju
	 iUks08smxiWjI2UldpctWVlBObTnwVS3zeCXm3ApfL6BChdux0xouSYwB9tMU8ZZ1pwsJ
	 /dweXWOwYIAIMywgZXKYhO3l0XzUWST8zBWSSvMgXv3kJSeANErkbmze33vL7oHj+nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0gNnFHFiP6Xt7usWAHsHdGVfiCu9ls9/fRWmaFiy7K0=;
	b=m8qt2NEPfQ2mzsYOaYKmufecEY74uJ1oFyKhkUZ4iFf7/LoEAU3bnIAUFnO78Dgcxiq9
	 pURCNTYIoywB9p+K7IRN+tPgn+pYOAk11pyvdB39/XMJVf1mZVJcig3i78AgCHKRjKqcV
	 agSYKLcvsuf0fdzKnj2PxuqLECJJ1nBvV1GJf64wD+tDtNsA89qWOpxgisRsH7NxuQJ6f
	 /m69BQDLyTLtunWpAiZmN151A8DbFSeHj5KQp5D8Fmv1DcC1n6/L5XEd9lM147QFq2Ye3
	 e0yvEkk+SGaB4U/TtPfRMiVRu+0Ft4AcUzEoW6zUWhtBoNhpBezf9Ycdb2VrCaEFtXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="Uk4J/HyS";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254CB606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 254CB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Uk4J/HyS
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d7791b00so4071065ad.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792597186; x=1793201986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0gNnFHFiP6Xt7usWAHsHdGVfiCu9ls9/fRWmaFiy7K0=;
        b=Uk4J/HyS/VoeC77wkMFIiIgWMUiQdPoqtlgUJBqKAVPA+aUA+KSaLNWcT2OsbzSDNf
         +dHmJkn+xFtWAm1O4WX0aAQCvaoUPZBBosOqr78zRWBkPvPT00FsnVqF8WsM47UvHoOJ
         LaJ+kB5TkKI9g2jN6cIPJ+0eRpeFD8UKQjMS1TvHYcyzyGfooLfIiNsPWNq8O+ZUpw8I
         qJUM2MT3x2v6G/G9ScRZXQrVrdV0TixXqZtgASrUGaVZUX0TXw4VQrU2xEQ66Le4hY/h
         ELXyBrqdzLTfyUM7m09V1x7zAK9+8Ho4PoloaNAMxdJkT4xHdVKVLCn88XmeDio71B92
         QKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792597186; x=1793201986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0gNnFHFiP6Xt7usWAHsHdGVfiCu9ls9/fRWmaFiy7K0=;
        b=EzRzDnaW/rM5xoOIiifdUef5iX6JAzYA9SOnud3H2dRb8sR+eb12sxSfboFBP/IjV9
         QkUiLvlVNJSYUTZzZmoqv+Sq+31QR53Hbuk3zKmuaJ9qDDjFb8rqNceOWuC3wSaD9asa
         Wi/RbQZJ7ZaiEUiNyu/gpr/zjCNkLMtsM2Xjnd9pqlUTelFoIE2GNpx9TjMrk6Y33+p5
         QJV3Z1Q/S+ynEZAmy34p1LSG50CjeDm2LFx9BjZbVkwaFIeU49I1kjXHLKZN00tv6ysY
         kKzFGGf7S7sHkW8WMhkIhgHgPjbPxv3X+shHG3YdS+iwbcv56V1eFdL5uSbYQrOw7z3G
         yeSQ==
X-Gm-Message-State: AFq9FYJOzAWyxMPXjyTDoJs/c/BCiX5KlAW7soIdvaU79Zl49ghE9BLR
	Z/f2Y3SorLOh0aMPe3uZQhLxtCMW/Mt3nHeuVeVwZpJlS9vjzQ+BZf7OXR47KkXYd/VkahbhTlG
	3xHHupOc=
X-Gm-Gg: AYBFou1l32n4Wo/A0ISPRw767tEvsNp7J6bwGUDhIGFQmr1oxUMa3iLhZruBjv5EayW
	3Gg9Oba69rgw4Ci03qCnj+AufN08kZgsyjmlx4NNigj9GeI0gcRD6eFVBltppS+TOsnW6+wgmwf
	5P9/pjzh4zUksa8FvmNH8tJM/Did9HgWrHbp8qjvaOTK/+XhJzV/f/EGQjn9zU27BfTi81Pg5Hk
	kzTrdSYpqjM1zfzJ2HotrG7YcQPN0ytVLhZ1d6BltirdQMT7ksfEI+dvbhuErzm3/fbi47wq1O1
	0EcDui91Q68RdshHVPdNgn5pGSiwJKb8/OblRN7NNvGyQ8lCRkBRWUQjCXWivedot849ylbzMnp
	OTauSSz2/KvbRSONf4RDPnMrE+mjFMv6ke+gehwg8sPlLdJSZXPMrEGXTfl3zEjwSbJRHbRZng7
	bAr5JhA/MkyOC9PaGMJn6dQ/GEeI9Hhnpa6DpqxS6W+FyE8BZFkosDvigaLr03/8UBd4tXi84dS
	tWAmm5CIhqjdQSaUIRCUFFuHtge9McvBHNLDl/6Vpo2FG9u7WG4TQ/1FJRh1+8lSDgfT1ttOyJL
	nmyRlHCFW5v//JhuDo1Hge08mT/G9++dy0BjaomQ
X-Received: by 2002:a17:903:35c6:b0:2e9:4bf3:37a1 with SMTP id d9443c01a7336-2ea43d39c1emr20025035ad.63.1792597186465;
        Wed, 21 Oct 2026 08:39:46 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4559cfsm13331775ad.47.2026.10.21.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:39:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] lib/fs: drop unused full argument from get_cgroup2_path
Date: Wed, 21 Oct 2026 08:39:43 -0700
Message-ID: <20261021153943.3754990-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The only caller, cg_id_to_path(), passes false, and no caller has
ever passed true. Remove the argument and always return the path
relative to the cgroup2 mount.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/utils.h |  2 +-
 lib/cg_map.c    |  2 +-
 lib/fs.c        | 21 +++++++++------------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index f0d45bad..5812d1a8 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -310,7 +310,7 @@ int cmd_exec(const char *cmd, char **argv, bool do_fork,
 int make_path(const char *path, mode_t mode);
 char *find_cgroup2_mount(bool do_mount);
 __u64 get_cgroup2_id(const char *path);
-char *get_cgroup2_path(__u64 id, bool full);
+char *get_cgroup2_path(__u64 id);
 int get_command_name(const char *pid, char *comm, size_t len);
 int get_task_name(pid_t pid, char *name, size_t len);
 
diff --git a/lib/cg_map.c b/lib/cg_map.c
index 0feb854f..9c92b2eb 100644
--- a/lib/cg_map.c
+++ b/lib/cg_map.c
@@ -118,7 +118,7 @@ const char *cg_id_to_path(__u64 id)
 	if (cg)
 		return cg->path;
 
-	path = get_cgroup2_path(id, false);
+	path = get_cgroup2_path(id);
 	if (path) {
 		cg = cg_entry_create(id, path);
 		free(path);
diff --git a/lib/fs.c b/lib/fs.c
index 1562d25c..86f9fb65 100644
--- a/lib/fs.c
+++ b/lib/fs.c
@@ -187,7 +187,7 @@ out:
 #define FILEID_INO32_GEN 1
 
 /* caller needs to free string returned */
-char *get_cgroup2_path(__u64 id, bool full)
+char *get_cgroup2_path(__u64 id)
 {
 	char fh_buf[sizeof(struct file_handle) + sizeof(__u64)] = { 0 };
 	struct file_handle *fhp = (struct file_handle *)fh_buf;
@@ -201,6 +201,7 @@ char *get_cgroup2_path(__u64 id, bool full)
 	char fd_path[64];
 	int link_len;
 	char *mnt = NULL;
+	size_t mnt_len;
 
 	if (!id) {
 		fprintf(stderr, "Invalid cgroup2 ID\n");
@@ -238,18 +239,14 @@ char *get_cgroup2_path(__u64 id, bool full)
 	}
 	link_buf[link_len] = '\0';
 
-	if (full) {
-		path = strdup(link_buf);
-	} else {
-		size_t mnt_len = strlen(mnt);
+	/* A cgroup outside our cgroup namespace is not under the
+	 * mount and the link reads as just "/".
+	 */
+	mnt_len = strlen(mnt);
+	if (strncmp(link_buf, mnt, mnt_len) != 0)
+		goto out;
 
-		/* A cgroup outside our cgroup namespace is not under the
-		 * mount and the link reads as just "/".
-		 */
-		if (strncmp(link_buf, mnt, mnt_len) != 0)
-			goto out;
-		path = strdup(link_buf + mnt_len);
-	}
+	path = strdup(link_buf + mnt_len);
 	if (!path)
 		fprintf(stderr,
 			"Failed to allocate memory for cgroup2 path\n");
-- 
2.53.0

