Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DBA3C661A
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173945; cv=none; b=YRktJ9iKfEVT3pNdIyP2V8tUFaQL5jAtaZd0BsjecjaN2xAgW08eOLHoa2qZLrwiy92C1T5lhrr6y4xXzqaW/Vvl8mUTcpD9DXEkPFw8ecBzoHvxKjXPjR9F4Q+5MsImAmvz+4+/wWC5/3SDbeRmbMbzF6jGOhxJUbRko7QEH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173945; c=relaxed/simple;
	bh=k3QpJN8+I55g8FljqrOCQatYFMgxnbzdJ4RZK6pPUDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atHz7Y0S9AGeTJvHOuANx9D0Xdv59OXceuDEE14dnCyIbZI9SgQYR0rLAarOYJyiuKLXcmOTmKAb/6Xv9+zy6hEnumFJBlVltMWVgQg7oq+2FWecxff6Jj0JVUCUIVYD7Tpn8byGrEby7YtEKM2IY0q8nNyL9jfJPp0Mw9BFBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixG+J5a1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixG+J5a1"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-482fc2b44a7so2788462f8f.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 03:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173941; x=1788778741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dQnrI08QM+nCVE1+dkRjMX2+ccdW5vMfHjCDAg3RBlU=;
        b=ixG+J5a1l2fRVsn861M+crTbHrewieqrh7DuKVfM9vvtAcUHkZg4Nn992xpXrkh/FR
         8hfvKwdHK0cpr886inKlYmPXmKtDm5BWRVPiPbtrpzxCnSctZh0nhJOT7EfLm7ruRJ+C
         q9UYOedMrv9GVZZyHNWOIg817sCHlWLnm4YgyhxOxsZMbN7edz+KDe1HIF5912MVnFMW
         huOBGma66X/P9FYm/6VfU5vm/U6qVr28nrKrU5VbCdl4C6F56zF0JPNuXu8ZRoRkWHQj
         4exOTArhDGFlWWQQ9mVHrB0+nRSgfOC52Wq0BIlOKRA2SIPJ/5SYQa5H2/cZMIHXaY6J
         iH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173941; x=1788778741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQnrI08QM+nCVE1+dkRjMX2+ccdW5vMfHjCDAg3RBlU=;
        b=B4PGufihFVmUXWGCTTxjBKIapQgaX4wrT305u2KWSPtTECHVel4KImGgo1XTEwVTb9
         Uk8iBiknzF52o7S+0RLekzlhvhiMQPu50Gz4yHEi0Dpi5Bi8sjQyKZFZNxLUKeXlk1AZ
         mYhU9dPR/d9GdRyxZDkW29t0Soi/0hyMwSHrkuHHI1a1wUl7UWqARlk3HAaTkxs6zf+a
         wPHAN33QGHr9Y6R7mycv4t9LAPT/G/xMq2FHQQSYotNElpnQIijlzb0iVK5lZv2bHPGd
         BJ+IBTOSzCLj2AnulstaBaxfLICntGsZv6wvtlTGsUpagDI+2zd0IOrpiU7bEHq+1eWF
         ffzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBOh0ThowGKjzbcmm38g69u2EHpo+iSAYDqKbh9/6WrlSwRvzWDIG/dqNP5aJxKnd2ZYUX3cM=@vger.kernel.org
X-Gm-Message-State: AFuF++mJbXEYFVnFXBy6Sc4m5jyPUfT4gEw5Xffkzn4vVD/AACRzqxFd
	AdCqr7qO4knbSr8FvP5BAkQo34XM3XCt9UTbLrevec3uXHojaAjvpr6M
X-Gm-Gg: AYBFou0YDKR1Kmrd18ocbnKU2sMhR4+ZzkjQkx5rGhSWDLetR0MGk/fIkI+sBB9GS12
	uHGy9UtTKIzgiBBIdxOhHNi0ks1FE7+R4mwxvYnNen36x6drYNQMPCJg+8+kSg1v8h2Bye6nJZf
	l3cVbsTD1joyRD5zDCJOxrTcGxUVsM3DHzHCheJksli4EX6sGc8hD7tjOpK6J8Bf4TwJwFthEpe
	CPnnIGTrkz5wWXhztcUcgezKoTr+TcivA0IjLYx+I4LGOq6O6Md5bSAapyfflQ7hQgAkgwa2xlt
	C5rzXJCqMhuCNTwRhcQzrTQt9DuNVUtpdVJ/Bw1qB4EeIsQZj5OuF7KIOBNDKMO7fyE53EhLl5c
	I4JJHwal7osciXea1gToJ59+9Kw3BDbuxLCHgiZc83lrEd2N3kE8HauFohWMVJKDYJvPAkhdOzt
	9Sr1YtvCiE4/URta2YfnKCJ6RCJIeUesF5BIGdFg8LXE4ypXg03Cgxq5Z37zUfW4QXV/8oBdY8z
	7om3FQ=
X-Received: by 2002:a05:6000:4609:b0:482:e451:6810 with SMTP id ffacd0b85a97d-482f7976116mr43355819f8f.1.1788173941076;
        Mon, 31 Aug 2026 03:59:01 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm16110776f8f.19.2026.08.31.03.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:59:00 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf <bpf@vger.kernel.org>,
	lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to more hooks
Date: Mon, 31 Aug 2026 11:09:26 +0000
Message-ID: <20260831110934.241898-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831110934.241898-1-a.s.protopopov@gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF LSM programs are allowed to attach to LSM hooks, all of which
are defined in the <lsm_hook_defs.h> header file.  From BPF's point
of view the set of attachment points is defined in the bpf_lsm_hooks
BTF set. By analogy with existing code, add a new header file
<bpf_lsm_hook_defs.h> which will also be included in the bpf_lsm_hooks
BTF set.

This change allows attaching BPF LSM programs to more functions.
The actual hooks are added in subsequent commits.

Each BPF hook calls a [__weak] noinline function each time a hook is
reached. This may be too expensive for hot paths if a BPF program is
not attached. A future commit will optimize this by adding a per-hook
static key and inc/dec it on attach/detach. This way disabled hooks
will be bypassed efficiently.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 MAINTAINERS                       |  1 +
 include/linux/bpf_lsm.h           | 12 ++++++++++++
 include/linux/bpf_lsm_hook_defs.h |  6 ++++++
 kernel/bpf/bpf_lsm.c              |  2 ++
 4 files changed, 21 insertions(+)
 create mode 100644 include/linux/bpf_lsm_hook_defs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 460cb7268845..d01dd1f096fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5035,6 +5035,7 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	Documentation/bpf/prog_lsm.rst
 F:	include/linux/bpf_lsm.h
+F:	include/linux/bpf_lsm_hook_defs.h
 F:	kernel/bpf/bpf_lsm.c
 F:	kernel/bpf/bpf_lsm_proto.c
 F:	kernel/trace/bpf_trace.c
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index dda272d78f01..1e54c7cca27a 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -16,9 +16,19 @@
 
 extern bool bpf_lsm_initialized __ro_after_init;
 
+/*
+ * Technically, checking bpf_lsm_initialized is not necessary.
+ * But if it is off, then this means that all security_* calls
+ * do not call BPF, and it doesn't look reasonable to enable
+ * only "non-LSM" bpf hooks...
+ */
+#define bpf_lsm_hook(NAME, ...) \
+	(bpf_lsm_initialized ? bpf_lsm_##NAME(__VA_ARGS__) : 0)
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
+#include <linux/bpf_lsm_hook_defs.h>
 #undef LSM_HOOK
 
 struct bpf_storage_blob {
@@ -114,6 +124,8 @@ static inline bool bpf_lsm_hook_returns_errno(u32 btf_id)
 {
 	return true;
 }
+
+#define bpf_lsm_hook(NAME, ...) 0
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/include/linux/bpf_lsm_hook_defs.h b/include/linux/bpf_lsm_hook_defs.h
new file mode 100644
index 000000000000..29bc0b514d16
--- /dev/null
+++ b/include/linux/bpf_lsm_hook_defs.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This is a set of BPF LSM hooks, which are _not_ fully implemented
+ * as LSM hooks. Thus, they only can be used by BPF LSM programs.
+ */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82c5988417a0..add344ea2691 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -28,11 +28,13 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 }
 
 #include <linux/lsm_hook_defs.h>
+#include <linux/bpf_lsm_hook_defs.h>
 #undef LSM_HOOK
 
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
 BTF_SET_START(bpf_lsm_hooks)
 #include <linux/lsm_hook_defs.h>
+#include <linux/bpf_lsm_hook_defs.h>
 #undef LSM_HOOK
 BTF_SET_END(bpf_lsm_hooks)
 
-- 
2.43.0

