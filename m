Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAA531E831
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200298; cv=none; b=CuWjBTWKG7o+w0fDuYWqaHphzOO80kNROJduS4w2yDx2JRjO+as5ajDDs5UJsjZnQaXxSLRQ8G/ya9oKdxe1qp6Y7zfB1fHFltKaX5xCir1WGOQv50jixR7sHTmjN5s3CB++DTpY38NQjEXKioJWLuMJ1KkYAji8lpzY8crDHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200298; c=relaxed/simple;
	bh=uNhcfOVvO5EyhAEQvhBee7dTOn4Fd/svgh9qOCa/V5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6jnKdnwqK6b58ZZlMskgvhjPmH4gHm519m55uCHVcEEFL01/VHGqHY3RRQgiUQ4DiFl6ZQxULRNjPQdTOeKa9metmt62AVTlzdtHc/TrywhMCFleTfvjYP1DwrfxfBtZh9nFcVj2pO9XXXzRHKXg9FxxbnvnA6EBa9XljQ6Xhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho4kGXLM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho4kGXLM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e5378b281aso1877715ad.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200296; x=1792805096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQ5o6CAkHnui4iB7g1UmuXabwwcLJv9UBtrsrOaE95E=;
        b=Ho4kGXLMKTEtNjKCKRho59Vtva+xYm46uXAJt2nSVZINP8u/xjLa9/yBm1NbpGK9jN
         WMAJXmkX4xd00HpJX55cjWHRfKfeR/ur5anIlOXNqxEO41dFjDyAxzRUUJPosHvBgG1o
         SodsNZBexTZn3jmlE0RPrIx4m76E7/tWnWSFj4qGAmbGXWpvz9Dx9B/VIsk/PN6kPCSM
         DCwq8o+9EKg3clcfVX19vP8w61f8BGq8WVf0cUbduAMtFTbZiqMcVNs0xuYxZMnS8vFb
         cL4UWgDfrIUYmbVUU2+Ri+MctlOrM/TU36Nk9TYJ8y/OhTbqzglhCP8BUdOSACQgIVqh
         KRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200296; x=1792805096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQ5o6CAkHnui4iB7g1UmuXabwwcLJv9UBtrsrOaE95E=;
        b=CGwN3Il65QnQBeV0dZUSfchfb3HQlHKj3fhdLjnMgOs6gX1pHQTYLZUo+eVjHSP808
         aa5uhCbDAKQImm81zbTiSJsQ0ALef5I5UGQjLcpueWzW9Fq9owNmbvLpEyNQrKMfM1Tm
         SzBLY9RxBLLmIGIWDiy/B7bRXtr/xPIsjl5slzPSMCteLBs9mkQJwV6P6O/na/f2U1Pm
         51Z0QtgRnWkNNB6yMXQvFLe6VOikyx27DOTZQwiyy1gmvpou7bQfQsLocpmhcSWA2u14
         8kxumP9q6dxkGRntvero8Fwe7IAguADkywD/STJ1bhiWiPc0LFELb0N15peUKYjtD+Kw
         5fDw==
X-Forwarded-Encrypted: i=1; AKwUvBzVb0QhF1TR6HNP1w2fOY5EhI4aocBoG6wcy+WAikFkdHSgeHCt/ZH67HEeydqlHMWuFMPTwDo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjERBSGkHeDdA2rJMou2nnvB7pv+PQX5Sjzl8GgmawKPzzlY5V
	Yaekbn+03XMAk+pA+BCA6TMmZXcwSJGj/mRI4yXn53xjOnhtbAKh4rVji3/NE6IS
X-Gm-Gg: AYBFou0qLr3cro7nQbkh4qdeRpkDHBHwC2Z3YpVvm+6V+uarFXGkqioPdwcneLFe/RR
	GA8OaDEUSA5+pOkoSsCL6cXBSXB08gT3B/ZZZQVLZebuE2D0oCtX13m97yBRFa0WmDKovVclk1k
	LHHk8icI7MA0LmkelBDZzKuISwNjGULgem9aBIa2XeZLYbRGIVV3ThYxIq53JR9H9RW0UPbYMgz
	o6DU37NDbOyJ5rah2HwjUM8QgGbAO8+GF3LWjTVHWDDTuEvlydAqPc40Nn14wZZQz8MQOALUq+k
	ID8BLqngyMUIOTeBzPP9mILpWve2Cus9+sVasXcQM1PNnKc2qsorU/dtDvqiTBbJRKj6Abnulgv
	0Lgf3xopR1pxnnVSkCFeohdA8rWGPq0NpdHPvKAcrhnqTl7RU6pMMadnTrvRtDIgrHOnMqkrmNi
	tnkMXUPOXM+zBK970K6HUiX5MMLdtlVWgRCKJxrGntwr7dmlF9JUDntuhuOwUk0dUjJLHNzxRzY
	HKj6vUeCggonOuYI739Yq0GcUIuQZrcHfCXKFx9mtfjwTeQRJRTcJuw/qlNt1AjY+h5vAAdvNfr
	75iGchTNc6R2eqrWccKrqqVaILoGTyuiaAvpWFE0ow02
X-Received: by 2002:a17:902:e544:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2e9a6833d88mr14646305ad.5.1792200296138;
        Fri, 16 Oct 2026 18:24:56 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e834ef9sm17723785ad.42.2026.10.16.18.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:24:54 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 09/38] bpf: Read the probe of a perf event under event_mutex
Date: Sat, 17 Oct 2026 01:24:22 +0000
Message-ID: <20261017012451.364800-1-alexei.starovoitov@gmail.com>
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

For a perf event on a kprobe or uprobe event which was made in tracefs,
bpf_get_kprobe_info() and bpf_get_uprobe_info() look the probe up by
name in the list of dynamic events, and hand a pointer to its symbol or
file name back to the caller. None of the callers holds event_mutex.

The perf event keeps its trace event alive, nothing else. Other dynamic
events are removed from the list and freed during the walk. And a probe
which shares its event with other probes can be deleted while the event
is in use, so even the probe which is found can be freed, together with
the string, before the caller has measured and copied it. The result is
a use-after-free in the walk, in strlen() and in the copy to user space,
or a NULL pointer dereference.

The readers are BPF_OBJ_GET_INFO_BY_FD and fdinfo of a perf link, for
whoever holds a descriptor of the link, and BPF_TASK_FD_QUERY. The other
side is anybody who may write to dynamic_events, kprobe_events or
uprobe_events.

Take event_mutex in bpf_get_perf_event_info() and give the caller a copy
of the name, which it has to free.

Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c     | 17 +++++++++++------
 kernel/trace/bpf_trace.c | 13 +++++++++++++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 654f896af265..4a9f28131791 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4020,19 +4020,19 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 		*ulenp = 1;
 	}
 	if (!uname)
-		return 0;
+		goto out;
 
 	if (buf) {
 		err = bpf_copy_to_user(uname, buf, ulen, len);
-		if (err)
-			return err;
 	} else {
 		char zero = '\0';
 
 		if (put_user(zero, uname))
-			return -EFAULT;
+			err = -EFAULT;
 	}
-	return 0;
+out:
+	kfree_const(buf);
+	return err;
 }
 
 #ifdef CONFIG_KPROBE_EVENTS
@@ -4089,6 +4089,7 @@ static void bpf_perf_link_fdinfo_kprobe(const struct perf_event *event,
 		   name, offset, missed, addr,
 		   type == BPF_FD_TYPE_KRETPROBE ?  "kretprobe" : "kprobe",
 		   event->bpf_cookie);
+	kfree_const(name);
 }
 #endif
 
@@ -4142,6 +4143,7 @@ static void bpf_perf_link_fdinfo_uprobe(const struct perf_event *event,
 		   name, offset, ref_ctr_offset,
 		   type == BPF_FD_TYPE_URETPROBE ?  "uretprobe" : "uprobe",
 		   event->bpf_cookie);
+	kfree_const(name);
 }
 #endif
 
@@ -4240,6 +4242,7 @@ static void bpf_tracepoint_link_show_fdinfo(const struct perf_event *event,
 		   "event_type:\t%s\n"
 		   "cookie:\t%llu\n",
 		   name, "tracepoint", event->bpf_cookie);
+	kfree_const(name);
 }
 
 static void bpf_probe_link_show_fdinfo(const struct perf_event *event,
@@ -5763,11 +5766,13 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 		err = bpf_get_perf_event_info(event, &prog_id, &fd_type,
 					      &buf, &probe_offset,
 					      &probe_addr, NULL);
-		if (!err)
+		if (!err) {
 			err = bpf_task_fd_query_copy(attr, uattr, prog_id,
 						     fd_type, buf,
 						     probe_offset,
 						     probe_addr);
+			kfree_const(buf);
+		}
 		goto put_file;
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5465e7eba238..304b426bd44d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2209,6 +2209,7 @@ int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *
 	return tracepoint_probe_unregister(btp->tp, (void *)btp->bpf_func, link);
 }
 
+/* On success the caller releases *buf with kfree_const() */
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
 			    u64 *probe_offset, u64 *probe_addr,
@@ -2218,6 +2219,12 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 	struct bpf_prog *prog;
 	int flags, err = 0;
 
+	/*
+	 * The list of dynamic events is walked, and a probe which has siblings
+	 * can be deleted, with its strings, while its event is in use.
+	 */
+	guard(mutex)(&event_mutex);
+
 	prog = event->prog;
 	if (!prog)
 		return -ENOENT;
@@ -2258,6 +2265,12 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 #endif
 	}
 
+	if (!err && *buf) {
+		*buf = kstrdup_const(*buf, GFP_KERNEL);
+		if (!*buf)
+			err = -ENOMEM;
+	}
+
 	return err;
 }
 
-- 
2.55.0

