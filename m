Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D04337100
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330574; cv=none; b=Ti7aavYH4X8E3Ci7bTLm37rPkwKei0htIblqU7kqUvbX56S67nC86rMitUNqpIE3S3UZXkVWw3SnulAvAsR5Uiqixn0Xf02P2FfsmPM3lQn/7l8Q0u6iVzTGWlVdFNEK/xqGmkvEJAnisZT0nec54XETagw77iRdlvN0ki2JBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330574; c=relaxed/simple;
	bh=6kMSHY69ShPBtgu/4LR3AsnJqQKZdPzU1YywkA98ha4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgC61MCnitKVBxRqiHGCLxyRy14eUE9inpQ/7SglzKc88Mf3YdwIAc4YCJO16Y6DZY7UWYAEjB1GzCb/2dDQltg32OfD8WRFtD9ffc3+FpRlXSFbLQGnOk3kz55ktcEQ90oXKlR8yqvXIuEwFVkSZE3bdnoco6OimOxbQ9eMcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjVHy0ye; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjVHy0ye"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81f47610542so1072580b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330573; x=1770935373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=CjVHy0ye4fcWozSh8Nu2ChnHyKNjpBrTMTLFR0JbxKifiAV5ZLwWLBebCUa17IG1AT
         X96gc0+9UjlktMzikrlUDHoNY2VJlBHn8dZjzI2MtuZi5jbkljG73O+j94Z4HsHPEmhC
         /hMcYeFpG2N4MlT1Hfl+9DCfFKIPlXSB9GZRLkknz12b/Oc1dSSPwrp8zUjQHLlTrjMg
         70zfFB8Gllg8cMNIMAgWj7y0dqHKjkImn5270M6sCGa4RZ2UKsC0HdJYm1gK+XBkxVaP
         Ru1peKJcmD3pKulMn4EuWqWUVN8M3uOvBfFyrJRgs7RY+gODTRRs0Mr7x+O/6FpB41NM
         n+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330573; x=1770935373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=rJU5CseUbKqSoGyiEmkWEYNJ3TkFHOPn82R/bqku6o/BCsUANK4l6VqLleYSanJxmt
         fEUH4kHfWqAykSdoG84uFu8sdwC6BkHfaRH1/Qp/qvWhnDH5FFRvTIes7zKRP95TRsOR
         Wf8gS/hQ23MutmavwFQxoF0Mneu3y30cpmglcKBE6Y6/PWgii+JmGNilQJAMJw7xb8XQ
         vQNG/Jrc4q6ZIFcoJvxm1Z2mDzI+ExZAHa/tOJvuLhxMjL5NKFk2MB0IH/IOI7DHXwwZ
         T0e3ade4tbkbHNC3kvMGuh+RvJqHAxUOSDpD78Xh9tvZTuFdGNSxRcse7nI+JTaqQkff
         SsbA==
X-Gm-Message-State: AOJu0YxGMr1nryaKZ4pWj467O2jWsl5zoTnZBeuYDETYZX+XAx1OxZ8F
	kcCNIXoXaNt3LyeBUKpN55U8D70NU29dF92JCjHm9j3mhiYdZgXWMJuB
X-Gm-Gg: AZuq6aK2XvpE+3bY5N00YL1B2pjmjKhCDsDcwMXc7SkGq3Um5q2dg9Vl6uPeJcDb+nx
	Gvluounj1modos2iqlQHaxudx78Nt+WtWAcJINnMOyTsBSWtB+yfw2kBiH5Dwfd/9e7EOKWS6vP
	CMpcaaaiNn74dioTg89zyhTjpLIIJPF2iKBdsLrtbMAt2QrKpIikfG9R3v4WUGSexGgiQc++vkv
	FUBF9PR33KGOp2oEHN56p4fr8jUl/aHAFcEy0876LeEDl0cASebUDzsHTKtCiDLVsWP/i/bbCzI
	aR3Wz12ZTeeOKaxKUTmeEq1ZkRUwpapV/IyFUN2qO8VUDCBRKFmzpGePAt2Rl7978rWGOxkWPY3
	xAHiJcWBG9yQzh0tJLgzeecPTnxBUTdH0TjvX8uSO6FZwSGNKmdgDv4bBCm3gaiU7WJ2338SF0k
	MH7w==
X-Received: by 2002:a05:6a21:648c:b0:38d:f8e6:fc8b with SMTP id adf61e73a8af0-393af24bdf8mr376854637.58.1770330573175;
        Thu, 05 Feb 2026 14:29:33 -0800 (PST)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb52494bsm375742a12.10.2026.02.05.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:32 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 14/17] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
Date: Thu,  5 Feb 2026 14:29:12 -0800
Message-ID: <20260205222916.1788211-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust the error code we are checking against as
bpf_task_storage_delete() now returns -EDEADLK or -ETIMEDOUT when
deadlock happens.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/task_storage_nodeadlock.c  | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
index 986829aaf73a..6ce98fe9f387 100644
--- a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
+++ b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
@@ -1,15 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "vmlinux.h"
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
-#ifndef EBUSY
-#define EBUSY 16
-#endif
-
 extern bool CONFIG_PREEMPTION __kconfig __weak;
 int nr_get_errs = 0;
 int nr_del_errs = 0;
@@ -40,7 +37,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 
 	ret = bpf_task_storage_delete(&task_storage,
 				      bpf_get_current_task_btf());
-	if (ret == -EBUSY)
+	if (ret == -EDEADLK || ret == -ETIMEDOUT)
 		__sync_fetch_and_add(&nr_del_errs, 1);
 
 	return 0;
-- 
2.47.3

