Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469CB4EB86E
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675555; cv=none; b=U15OUjTkCEgkwZcLrhpri0Z6n5ezOIbPDXaTISw2KDHGMQ3Ae12RKTpgiaZHbDGwuCK4tS8N1c9jWVr7a7PKsGrbWqnUhOgR+wrk7SCtIkA94bA37xTtfQlMORxSfvK0zLoRWdN+sZbgENpXbEjcO0ybz3STRVsk8lssH52BBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675555; c=relaxed/simple;
	bh=1Kuz6tS5Py1WMjbe0MPgCCfqRKMN/UYPaHrtMokGw5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRNHUvxfnBZ6aYccUShiBmqdKGPTx41Wjk8VF6w1dqlzUOFFsbPDDv1t65NilDStYAQKLvpJEH2F2zu9nqDiZxATQFSCJ6NWiJrQDOVY9ef96JRuUN3FSyXFEHbPr5eYeidI+D3JhzLzblywSkW1RtrA9qfcDo8k3I26KeOC6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fofo3AKX; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fofo3AKX"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c6ed1de994so67705b6e.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675551; x=1790280351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mrj/+J6JJhLD0EYx9SyMDWcw43Nzov4qv5yvCmdOUA=;
        b=Fofo3AKXyQE42RM+yzx1j5CkNHvESagmN121jGzH7nvmsvx6R8QV78OrjAynr1YhgV
         bYjdBpVFixJFJ2xrrmIjQDhxrj7h/UeJkXpmv9GjC7R1t31yi1TI8eQsNfTV1JfyjPuz
         JOZGkqNdK+uN8z7x+roj0AAa/Wf120ElGOlMgij3TgxvKDgdX80fSs0Li2FXnfrdfpBz
         kEcElUgSgdlzY3OeNjWOyyRhXp05avkYfgC60sVWO702dbGKKz47Voq1fnEmc00XYr2A
         aa2YTOv1L99RVMDa8r+eEYNxTkJOo+Dyc+HOdJjo6j9cJpBzesRvxVLJu6xShkx581Ci
         soUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675551; x=1790280351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mrj/+J6JJhLD0EYx9SyMDWcw43Nzov4qv5yvCmdOUA=;
        b=2ypiNVe1joK8px5SnHh81zsJg4a6XARvOHzxw7kclsl2k6bmt6xovpcLw9EV3hI7/s
         bob/s9qwfSJu0wn5EyH17xxC3Z5N14k4wO6Sv0PMYwhiygPTfe3uPo8a9bmUIeqCbI95
         FW+bNf5W+9OLVSm309tvLvwfoJjkgOw7oi2aXv2aHmncrAKDzkc8op9McqwcSMoWDSSd
         xQ6QxwewItRO0bYqnufK81hStoQ1LMVCto+8JHMGPAyqpvhrQSR0wkDDPqwyD9GS+p22
         6BSzJytD265yq73RZo7Z5AZb07ohbLM0yYLXOcgl0Y5SzDiDy0jjLWlOBQ5arJw4y2zg
         z9wA==
X-Gm-Message-State: AFuF++kJmIeJdnTIndFTZjBu26HCDNJ10X5iH4JXFFxdwT1f0mRz2+Fs
	S4FrZcK/LpfW6t/HeHCqq5QuaDzEnOn/b5vMjrGasyiS+UfjATXCMa1O
X-Gm-Gg: AYBFou3I9cqrniVVcGIr+uNLjMl3KB1EzoZFR6N9whHzttYBP1xkU2ZAicoALLZTAZi
	ATx2u1mZ6Yd6nX4bA/bolWPRzcvrF+SWRHHdV3V6YAZpsSRD2QpnlMrqeLznMtpY51NXEzqpxsv
	HeUIqq8krU5gOODii00wyVDUexb5cNmWmDAYW2ColLnhK4H+kQ+mcbKW/LcngZbPOlra/QbwLMP
	V8OIpVXXeXV4Fa8nofaRCiFzaOQB/pjRScp4x09b6c1DTsiNwOieUD6EgFtobWUX52//e+0XnGV
	3TL/0Ne5LLHyfUgox4g9xLS/vnXooDU71J+yKJriDHu4GNv2ivCniNK/AnUzyWFckgNn33HeuAe
	9IOJG3SFqo1XnmwdAKYpmj0j1SGnUi4BiVZuV9lYXrSbszVQtJL7q8TgLBJFE7qyEKQVD17bVN8
	M08AK/L8KUWDxMzM0QGNQvR7EdmVyTGh3zg5EyA0Ffv+DlNtTQy7b3vbriiXrFQg==
X-Received: by 2002:a05:6808:3a0b:b0:4c7:43f3:b65 with SMTP id 5614622812f47-4ccf9996a27mr460852b6e.38.1789675550902;
        Thu, 17 Sep 2026 13:05:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cb6c80c75bsm3667697b6e.6.2026.09.17.13.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:05:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 03/15] bpf: Add bpf_struct_ops accessor helpers
Date: Thu, 17 Sep 2026 13:05:29 -0700
Message-ID: <20260917200542.3689605-4-ameryhung@gmail.com>
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

Add the helper functions bpf_struct_ops_map_kdata() and
bpf_struct_ops_map_cfi_stubs() in bpf_struct_ops.c. They will be called
from cgroup.c in the upcoming patch to create a struct_ops to cgroup
attachment link.

bpf_struct_ops_valid_to_reg() is also exposed for the upcoming caller
in cgroup.c.

The link update validation is also refactored into a new function
bpf_struct_ops_link_update_check() such that it can be reused by the
caller in cgroup.c in the upcoming patch.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h         | 27 +++++++++++++++++++
 kernel/bpf/bpf_struct_ops.c | 53 +++++++++++++++++++++++++++----------
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1198404885c8..90ab467d25a2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2290,6 +2290,11 @@ u32 bpf_struct_ops_id(const void *kdata);
 int bpf_struct_ops_for_each_prog(const void *kdata,
 				 int (*cb)(struct bpf_prog *prog, void *data),
 				 void *data);
+void *bpf_struct_ops_map_kdata(struct bpf_map *map);
+void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map);
+bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
+int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct bpf_map *old_map,
+				     struct bpf_map *expected_old_map);
 
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
@@ -2354,6 +2359,28 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
 static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
 {
 }
+static inline u32 bpf_struct_ops_id(void *kdata)
+{
+	return 0;
+}
+static inline void *bpf_struct_ops_map_kdata(struct bpf_map *map)
+{
+	return NULL;
+}
+static inline void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
+{
+	return NULL;
+}
+static inline bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
+{
+	return false;
+}
+static inline int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
+						   struct bpf_map *old_map,
+						   struct bpf_map *expected_old_map)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 7802859eac1e..12ce9654ffdd 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1276,7 +1276,23 @@ int bpf_struct_ops_for_each_prog(const void *kdata,
 }
 EXPORT_SYMBOL_GPL(bpf_struct_ops_for_each_prog);
 
-static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
+void *bpf_struct_ops_map_kdata(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+	return st_map->kvalue.data;
+}
+
+void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+	return st_map->st_ops_desc->st_ops->cfi_stubs;
+}
+
+bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 
@@ -1329,6 +1345,26 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	return 0;
 }
 
+int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
+				     struct bpf_map *old_map,
+				     struct bpf_map *expected_old_map)
+{
+	struct bpf_struct_ops_map *st_map, *old_st_map;
+
+	if (!old_map)
+		return -ENOLINK;
+	if (expected_old_map && old_map != expected_old_map)
+		return -EPERM;
+
+	st_map = container_of(new_map, struct bpf_struct_ops_map, map);
+	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
+	/* The new and old struct_ops must be the same type. */
+	if (st_map->st_ops_desc != old_st_map->st_ops_desc)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map,
 					  struct bpf_map *expected_old_map)
 {
@@ -1347,23 +1383,12 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		return -EOPNOTSUPP;
 
 	mutex_lock(&update_mutex);
-
 	old_map = st_link->map;
-	if (!old_map) {
-		err = -ENOLINK;
-		goto err_out;
-	}
-	if (expected_old_map && old_map != expected_old_map) {
-		err = -EPERM;
+	err = bpf_struct_ops_link_update_check(new_map, old_map, expected_old_map);
+	if (err)
 		goto err_out;
-	}
 
 	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
-	/* The new and old struct_ops must be the same type. */
-	if (st_map->st_ops_desc != old_st_map->st_ops_desc) {
-		err = -EINVAL;
-		goto err_out;
-	}
 
 	err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data, link);
 	if (err)
-- 
2.52.0

