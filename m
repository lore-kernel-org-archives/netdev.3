Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB2C3AAF69
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255126; cv=none; b=h+oh5I6XNRvopyCcJxYTcKwPqdVCECExGsU8bHTvvIqXf/EVqLpXFZ2to/4TQsCzZenM6yeVd4kY7TN3JYpzUQ+idr336wGSTwxXj0bKDA/ZdiKxFgEJyFq78v05zQ1bDPynfzexfbsS2egzGNysG4vqRSjgP7gM9oIVUoLeuf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255126; c=relaxed/simple;
	bh=IP1aThnBSmQRykktz7NQABbJ8bl/Z3C5zEwVeI3o0So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYEsOLZuxXUPaSXAFlW5dhRYgLWGuzrSMmC3qCBvMZ6bMSJcOEvuWzoni5MKQlY1ApcB/nb2TEs3iDzrxQX0+89A51lAa3LHQUEJg2vdCXDFFDwafc3pqZrvNKYRrHNuF6ck8wOj+v1UQ1H2T42Hdlcd6pfLp07cFjwJSBSZ1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0mQB4Re; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0mQB4Re"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e60f9af6e6so5669535ad.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255124; x=1792859924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpttKUVHiqZ3qULCAgZCW27ALQfz3iY7DKYFVb6qa4k=;
        b=I0mQB4ReL6eXhYUseMXMVHWIY04VRj7jlnzvwGhXwswBe6kt8f7JU6iTCAfaPTiyyO
         OZxvBmptEQ6u/08jI7Flsih2j2ki9bEugSnmAF/U1ZUZJaMNI9wmsOfxvgiYlmI/Aqv1
         NAe/lnPXkkMBtWEC8FOUxr5ZFsG3wUkVKmjN5XMvf+CuC/hCVjDLsX+iOroMthKX1Lml
         HGZ8IRtnQb9U7cX4WvT/wkIQ819j8y0u+h/vcflKuOUaDBlF5tUbh1I3V16J/rdp3GMO
         5J6MYmFs7dcUsUN3Wrrilu6pDcPPjQuzWzqitpeghf6nD1RGmP/eyGivC/5J6XkYzJyT
         9JSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255124; x=1792859924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpttKUVHiqZ3qULCAgZCW27ALQfz3iY7DKYFVb6qa4k=;
        b=QVxDgiC5d5uBGRqYP95zNE0r4c0r9BuPkdJzVuO/74YkiKRYnJnMuzK5ETSHJniuwg
         OenrBMOX4MDEn1JdDNyaVgXFFVlPdtDIRTyVKkdmb6xrbKjyfMvwT6K5wPmFa5xxGL51
         5V2OIGs6InRivFiNruh8x71+l0kUDj8p33f2aei+uJ4RO/lP/mcZXZ/vyTi3aucAkOxk
         w6twmt4c6RvrQ9YgFkENzW2rAPHhefv6wwWvuaf4WhFZGftBKmRUno4TJEDIam02YxHK
         KC1hJ8kPpRlIsMVLIKp6s5A/JkTjhL1PkJjv+JZKtXMwOfR5Y42Hrq6Ov/bCd9Zdyp/N
         8Khw==
X-Forwarded-Encrypted: i=1; AKwUvBxLwPHCR8aA5PakR3W/XmLcXnOvBafBmC0doq5T2gn6gjyUK6m55UH2fuCyl8Wq/O0FKMa6kEc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBzJB46MyXQUjSfpxRVwenArcB15EmB8+mWSBVQMzDK/9AhxDy
	zGMsv3/SxbJ/QzaWrt0+WMGXY0pWDdCiIas1/m/6L6mq8LLmBHsoIuTd
X-Gm-Gg: AYBFou0ZUQLjyjfoB66MzTg7fWaPeduNuWAANso7jqgncBGNGgnPjVvIWagaaWP69zz
	9jjIMlZXvK5KtnFEiLQGJt4xNcS7OLMomCSMlXkFFcpAuH5OTmNUDqVpCCuF8XnaRhzXPOv2dob
	cqIOqoVkShHuFAnZ3CQffmrDEjgoszh6uSzVmfwwSteOzRnVSl8Xi3hMRtdGC6tuamJFaSUFdy4
	q6XjxyqVl9FHHIC7Q4afv5toWYQnxyjJUiZsya3zYJXKB3662WbCATzVOoxRENw9T7fcYd4hf+P
	wmpjd7t8dFW5wrCJfDyQwbMWtFu4VB1mZyrWz4FUpm3WA6V9RgIstBstugzh+T9Jc7mEx7i9ol7
	zAa+vpuhC77XGXTEma3pt2d0usz+rdibwWs8dcg4ZOlg6T6fAt95eLZYpU0m+ubroXRVFcSRLfq
	JcxkxfdqVtq73h1RpVaIzJMcbPCZCRLNIMbXNqJN0yoo9+u7g/YLop/mViqDfTnHY+1rx6IfjpO
	6AjOdtJKCLiJmbKb2GSpATjd0H9XqY9yaTw1FQ9hl8a+XX1AOigonyYRqOcnYpDK37z1sbkYzrs
	I1HdgLp771VKkBY1nVRUYdynE2YDcXon7cw9KrDNWBQ=
X-Received: by 2002:a17:90b:582d:b0:3a8:5d1f:59ad with SMTP id 98e67ed59e1d1-3acef14c8femr2726595a91.43.1792255124156;
        Sat, 17 Oct 2026 09:38:44 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487e509sm8692768a91.9.2026.10.17.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 09/43] bpf: Read the probe of a perf event under event_mutex
Date: Sat, 17 Oct 2026 16:37:11 +0000
Message-ID: <20261017163745.3341787-10-alexei.starovoitov@gmail.com>
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
index 0f27604a54aa..0f5eb55d49d6 100644
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
@@ -5767,11 +5770,13 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
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

