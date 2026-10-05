Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E04C10FB
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212993; cv=none; b=YCvMnlIXn7mhEZmhsKrGIYQYdSR2B4PW9IupxDNXDxkhxp4WV0UZVnJillO52P+TcFhjAY1iTTITDbFhfMhDufmR6oHA8x6lP1z971MDwBxVFa2nOH8y8SutQoHJIn/QRyV5RN69rjFirp9rRz+uSoKlLp9TtpC2OaGEm52KIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212993; c=relaxed/simple;
	bh=sPq6ow05ESSsLkx19oSJQ6lCxDIUpbRp5B6NmdQYWZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzyN7+YJPoJOP+rJoxdPec8TWGj362AMFDWMbvQPmdlUwkSx3OfNRpJnPc/U/2PwxEt7qWY7jNORn00xxiGKIVJvJRL1w4rYQHG+Kc3WTDUom8u310boxYww3NqwJ4pFZtjgmVex/9vfvqEuCqftSkrLEkPFt4PjCzGHpF+4IWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=ZxJWe7Of; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="ZxJWe7Of"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3e848918so11105257b3.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791212989; x=1791817789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etDmoveWN7n86f77dzpOEQHS7hrjEasSaits5Qio3p0=;
        b=ZxJWe7OfBt6yqdDDQ4BtUirI0klIXheK/jwopSwfBGwkh3YU7HG5ko15gaUYGDIDbl
         I8kAhOL0hWoo9Am2bPfvxa4LQnxMeazwtMXy443KmCG/DqyIbmaMQW0S+9BGCIyUtv+9
         99ZUdkQg150QjFXeUM9f8TbIZ0uxwGjCqPM4w13/Nh7V/4jsNe0rC+5ZC059e8gUmzGf
         aM+fqhq5u3oUyK4zDbE326LdV+pu0wjmt+lQAI8EWty1wrQg5ZRCc03I/eVcBdYk8bNb
         yK8wUZG947Sja6Sm6AgSmE8LOZ6WqKmllGNY2Xf5JhWXQBh2jItPWGs4Cr/OVscTq8gy
         4Ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212989; x=1791817789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etDmoveWN7n86f77dzpOEQHS7hrjEasSaits5Qio3p0=;
        b=qNRBrsd5ioAe/KHz4u/o9CiNmHYm8eSpGIaOnxIh9mMz0nB7zqJSugxEx7t7Fx8IRr
         B3qxhtnaEZRxhCuBrabLp2I3NVTJouLIhDP6Fi1aURI7RT7NFTRw90wh06OQ4ULQaIVF
         NHnQ9Sk57Rn4bSxX5Xyl3MhNQ/qpohYjbNI5Q5+rlEd12fp98W43S/0Jtn8rZGgVRWMh
         IJ40G0iguBVKGRO0qbT9likL+RLGII92qX6lCGGMVpGjrf8EnVRsuTQEfXTrg0SNQ9gP
         XLwvFGsOeAZBHRc3WAUHN1F8jdE4NopBiwvjiPqJbFGz/TJapj35YhtX2ygCXGtwk9nq
         aV9w==
X-Forwarded-Encrypted: i=1; AKwUvBzySaqsni2eMUXzPSxitdcUMyqIzMsJjGYupr15pCSZVpJ9jEgjQTERK55huSJiQeX4MkR4WtY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLppJQWyUtx6vLWh/BE2apD8NtXKbfUHV8LWLMYBgFOTG3hEj/n
	R4GwMI1i4IQVcSGPns3cZlui56BPQ7aJNOxZRMiHqYQfGvlg7kUMY1ondNuIslXi11qP
X-Gm-Gg: AYBFou1Et07yDgrORv7CI83dVOGo1wRSxEqSZ9wyw/hl8enGyHi99Uav3Ixv3fF4cC4
	rL0M1gFQB5jj5o0kgmZxOIP3QYxfcRG/b+1inTUw8cNZKXM0v8+VZCBUkF/+Kzx1Tw9FT0FzCAv
	yDoJx2bgzi0K0eN7b7thK5cJrNAX1BUssElOIc54q1spR9C7UkNaFWPrO8TQK5Lf+WAFklyHhrz
	OURQ/80Extm6zGw/fV3vbtGlDwUU8cXK9VR6xv60LmTCJ5nExEMVG+k9ZyrhR1V8XmLklNFMsfZ
	rvM+RbETW5Z2CX1lVBJsQaW6TAv9BhCA+Uv3t8BHn+GZjcUsULje3DOlMBkjd0JzwBUinrgz8DH
	Kwvpl0Xm9g6+lpHp2vukDVu9KD4t98DUaprn7Rz4T8XUnfYNVzTlBYdnFHgPQcV9/wZrLEAISyL
	z4VUS1KGxnQJq3ekAXqco0BUjrNtvzpW7zzCoj8CgPuN4BLwFVMxGvASzncq1bfdCphIiGigNfW
	fen0yZpy2zz+q2lo12+hUiDMCDSmC9HNbHx9UmMiaSPBuH+GOF9X0g=
X-Received: by 2002:a05:690e:15d7:b0:675:4a9d:4acd with SMTP id 956f58d0204a3-677abdef2c6mr2301121d50.7.1791212988685;
        Mon, 05 Oct 2026 08:09:48 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:48 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:31 -0500
Subject: [PATCH v4 01/10] pid: add helpers to operate on a struct pid array
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-1-350183b6e02a@amutable.com>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Eric Dumazet <edumazet@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

We're about to extend af_unix sockets and coredump code with the ability
to hand out thread-specific pidfds. Add a few simple helpers that allow
to operate on multiple struct pids up to PIDTYPE_MAX with automatic
bounds checking.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 fs/pidfs.c                            | 16 +++++++++++
 include/linux/pid.h                   | 53 +++++++++++++++++++++++++++++++++++
 include/linux/pid_types.h             |  8 ++++++
 include/linux/pidfs.h                 |  5 ++++
 include/linux/sched/signal.h          | 18 ++++++++++++
 tools/lib/python/kdoc/xforms_lists.py |  1 +
 6 files changed, 101 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index a6a643f15d08..586af2e5811c 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -1070,6 +1070,22 @@ int pidfs_register_pid_gfp(struct pid *pid, gfp_t gfp)
 	return 0;
 }
 
+/* Register the pids up to pid type @last of @pids in pidfs. */
+int __pidfs_register_pids(struct pid *const *pids, enum pid_type last)
+{
+	if (WARN_ON_ONCE(last >= PIDTYPE_MAX))
+		return -EINVAL;
+
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++) {
+		int ret = pidfs_register_pid(pids[type]);
+
+		if (unlikely(ret))
+			return ret;
+	}
+
+	return 0;
+}
+
 static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
 					 struct dentry *dentry)
 {
diff --git a/include/linux/pid.h b/include/linux/pid.h
index ddaef0bbc8ba..87635d0cc1f7 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_PID_H
 #define _LINUX_PID_H
 
+#include <linux/array_size.h>
+#include <linux/build_bug.h>
+#include <linux/minmax.h>
 #include <linux/pid_types.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -92,6 +95,56 @@ static inline struct pid *get_pid(struct pid *pid)
 }
 
 extern void put_pid(struct pid *pid);
+
+/*
+ * Helpers for arrays of struct pid indexed by pid type declared with
+ * DECLARE_PIDS(). The array covers PIDTYPE_PID up to the pid type it
+ * was declared with and the helpers take that bound from the array.
+ */
+static inline void __get_pids(struct pid **dst, struct pid *const *src,
+			      enum pid_type last)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
+		dst[type] = get_pid(src[type]);
+}
+
+static inline void __put_pids(struct pid **pids, enum pid_type last)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++) {
+		put_pid(pids[type]);
+		pids[type] = NULL;
+	}
+}
+
+static inline void __swap_pids(struct pid **a, struct pid **b,
+			       enum pid_type last)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
+		swap(a[type], b[type]);
+}
+
+static inline bool __pids_equal(struct pid *const *a, struct pid *const *b,
+				enum pid_type last)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
+		if (a[type] != b[type])
+			return false;
+	return true;
+}
+
+/* The last pid type an array declared with DECLARE_PIDS() covers. */
+#define pids_last(pids)							\
+	((enum pid_type)(ARRAY_SIZE(pids) - 1 +				\
+			 BUILD_BUG_ON_ZERO(ARRAY_SIZE(pids) > PIDTYPE_MAX)))
+
+#define __pids_last2(a, b)						\
+	(pids_last(a) + BUILD_BUG_ON_ZERO(ARRAY_SIZE(a) != ARRAY_SIZE(b)))
+
+#define get_pids(dst, src)	__get_pids(dst, src, __pids_last2(dst, src))
+#define put_pids(pids)		__put_pids(pids, pids_last(pids))
+#define swap_pids(a, b)		__swap_pids(a, b, __pids_last2(a, b))
+#define pids_equal(a, b)	__pids_equal(a, b, __pids_last2(a, b))
+
 extern struct task_struct *pid_task(struct pid *pid, enum pid_type);
 static inline bool pid_has_task(struct pid *pid, enum pid_type type)
 {
diff --git a/include/linux/pid_types.h b/include/linux/pid_types.h
index c2aee1d91dcf..3302690a2a28 100644
--- a/include/linux/pid_types.h
+++ b/include/linux/pid_types.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_PID_TYPES_H
 #define _LINUX_PID_TYPES_H
 
+#include <linux/build_bug.h>
+
 enum pid_type {
 	PIDTYPE_PID,
 	PIDTYPE_TGID,
@@ -10,6 +12,12 @@ enum pid_type {
 	PIDTYPE_MAX,
 };
 
+struct pid;
+
+/* An array of struct pid indexed by pid type, PIDTYPE_PID up to @last. */
+#define DECLARE_PIDS(name, last)					\
+	struct pid *name[(last) + 1 + BUILD_BUG_ON_ZERO((last) >= PIDTYPE_MAX)]
+
 struct pid_namespace;
 extern struct pid_namespace init_pid_ns;
 
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 0abf7da9ab23..3c1e82f1a369 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -3,6 +3,7 @@
 #define _LINUX_PID_FS_H
 
 #include <linux/gfp_types.h>
+#include <linux/pid.h>
 
 struct coredump_params;
 
@@ -32,5 +33,9 @@ static inline int pidfs_register_pid(struct pid *pid)
 }
 
 void pidfs_free_pid(struct pid *pid);
+int __pidfs_register_pids(struct pid *const *pids, enum pid_type last);
+
+/* Register the pids of an array declared with DECLARE_PIDS(). */
+#define pidfs_register_pids(pids)	__pidfs_register_pids(pids, pids_last(pids))
 
 #endif /* _LINUX_PID_FS_H */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index d45a5476b97d..3149cdb976c6 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -674,6 +674,24 @@ struct pid *task_pid_type(struct task_struct *task, enum pid_type type)
 	return pid;
 }
 
+/* Fill @pids with the pid types of @task up to @last, without references. */
+static inline void __task_pids(struct pid **pids, enum pid_type last,
+			       struct task_struct *task)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
+		pids[type] = task_pid_type(task, type);
+}
+
+static inline void __get_task_pids(struct pid **pids, enum pid_type last,
+				   struct task_struct *task)
+{
+	for (enum pid_type type = PIDTYPE_PID; type <= last; type++)
+		pids[type] = get_pid(task_pid_type(task, type));
+}
+
+#define task_pids(pids, task)		__task_pids(pids, pids_last(pids), task)
+#define get_task_pids(pids, task)	__get_task_pids(pids, pids_last(pids), task)
+
 static inline struct pid *task_tgid(struct task_struct *task)
 {
 	return task->signal->pids[PIDTYPE_TGID];
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index e3dda2fe8a53..e792785a15ec 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -45,6 +45,7 @@ class CTransforms:
         (CMatch("DECLARE_HASHTABLE"), r"unsigned long \1[1 << ((\2) - 1)]"),
         (CMatch("DECLARE_KFIFO"), r"\2 *\1"),
         (CMatch("DECLARE_KFIFO_PTR"), r"\2 *\1"),
+        (CMatch("DECLARE_PIDS"), r"struct pid *\1[(\2) + 1]"),
         (CMatch("(?:__)?DECLARE_FLEX_ARRAY"), r"\1 \2[]"),
         (CMatch("DEFINE_DMA_UNMAP_ADDR"), r"dma_addr_t \1"),
         (CMatch("DEFINE_DMA_UNMAP_LEN"), r"__u32 \1"),

-- 
2.55.0

