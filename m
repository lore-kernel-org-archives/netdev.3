Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4B24886E
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351874; cv=none; b=kfPLRGbqz8Y+8UR4z8u/vv2h3rxWsIaKmV3AgsqS6mzW/+SxStkynr8+e06/3ReSi7wRvWaPzLPJNkS//LMTn2G0FNhdToqGVvzZbypJBNzWjCfQ7vHOaohrmY3mSwacXli9Xi6tfziEj9sBBV/jWrQmzbVIVVyzyRZ/I5U9KvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351874; c=relaxed/simple;
	bh=0Ogw8BtodmC5Ix5C8J/zAjlS7sfRNaRzfBzPc4lLIIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNFtuyKiQB+wF+5E8yOLGvxN0VYDIdn/OKkQcDw0hWzW0ywHd+PNNoV20vrJ4AnIMI6zYoFla0q9fPuyV2Hk3MJMlphFbQ7kMsncPgC970+/jxqFqn3KFMHoHi2/fKDbojdwxsoR4sUZFgdZoQJA85rc6yFEod2tVBZtzwoBf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUMnXOxi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUMnXOxi"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a706146559so1304251a91.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 22:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791351872; x=1791956672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=daz3eZUr/IMYFuGgbc7Ro1q4cyp0U5dHFhBK7vBFCxE=;
        b=QUMnXOxiB/9M/d1nLjhE6zeHOF9EMCFsB16bcPn4ulDusppRUfBULsHrB0744NLiAu
         Bz6p5K4E1oJTAeAHUTsGrEfopktN2/TADnjHLOmhvTfmIzaMMVWBmq2nFVRNpfxUr5o5
         y9IX7ekCoXXrvrN2YTZS8ORDQFsOK3lfG3EuTogCPxghe814oqeGjYEe0f3ozE0lNhdP
         IPcZ4lC72byaQ0CF4V4zBSCx+fSyKajRdBINZtS40byD0EZUkclTvPV42FWJTqLCgPzW
         4/DUAMK5Yaz7Su48QjQDmcNF8UAuBzi2Xq+DEmgsz8r70ze3JSkp3xxBVyN3+7YhRuwk
         d57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791351872; x=1791956672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=daz3eZUr/IMYFuGgbc7Ro1q4cyp0U5dHFhBK7vBFCxE=;
        b=uXIuVf4Pr+8xApZQZtsAJO5mEFkTb123EYEMyv4tkDEbY9SAdNlNHS09ECVYP105lL
         lGXd4V8asFdfzEe1fLVT4FNpK94VFJRe9N96jQA4dTy3MWPJn/JfGk2n3O8OIU/RxEdz
         MUQb8+ZJSBd9qDduRkXw0agpLhnBxKlYsVOslzHUetG6pxgPDK9N8xSHp8UvHkAfsyMf
         DpcN7+RoCSQ0y1NnSLvXAWI4gdiKpCzc7IOy9g80mze2jLiNTLYDUQSUGCAPsX78roJV
         4D8yw1CJQN8GNKJjQDyPkHC/GvBq1IayDpmXb5JTA6lZ8aESgwIhVuAVRJu586BpdA1+
         IYGg==
X-Gm-Message-State: AFq9FYL8i3/7x39bULMZWJckpuHwtXEz7mGxnOum/F0SSlYvX821IIPD
	00wP/sjMxg0K8YpEoFB6O6vRNF1uATihHDUjhNyMXp1jekg93s9i6M6i
X-Gm-Gg: AYBFou2riHweaHnBqXxQBv2Xp00hZp1vTlHZPiUGv1rdKBtAqaqufPVn4Ybd+iRxjMA
	gKXV7izAZQz8tGimnSsgpFLajQDljmujI12Ogt6HTokA5a80w9R457LxVaOi6lYSZNsUIMOrFcL
	W7NijMcBm2M39oD5/mUVGpCpp+HpI1JnxFx9+1wb/k7jXjH4BqMm3lFeJcc28FaY/A4wyKMHG62
	W85TWQN9j2XmKuDFKIzdxUcv8wGDjDmO11Rsp9yDx7pplqnsXkeqPnLFPBuHIDgOQkDw4Fw0JWX
	pYeRASJLy+9n5xYddXoBSWMwyw8pGVKq+4769UogS9fDQCZ/XnDqA2jQt30l1Mk4aM7VJti8qfd
	IisAkv/YvY3isvALz36a6wk/c2vUEramvGHaujVZ9rfiDK5TBTrk3T8jtFopL/kB6l9MEc+lrsB
	YdDxwsN+H+We4dU9tI3UaVHVjdCI0f7k6Ek7T++XM3sruH0VXFl8hsM8q08xNCvexe0JU4sOJz0
	eWpcRUYIdlqjFem5Y/tmloS4dnrAEAylg==
X-Received: by 2002:a17:90b:1344:b0:3a7:f45:5cb4 with SMTP id 98e67ed59e1d1-3a8a0ba9767mr1087881a91.26.1791351872273;
        Tue, 06 Oct 2026 22:44:32 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([167.103.3.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89b3a2b36sm3161155a91.9.2026.10.06.22.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 22:44:31 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: test tcp_rmem lower bound
Date: Wed,  7 Oct 2026 11:15:08 +0530
Message-ID: <20261007054508.1059927-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise a tcp_rmem default below 4096 and verify that it is rejected.
A tiny default can make TCP receive-window accounting space zero and
trigger a divide-by-zero when the receive buffer grows.

Run the test in a fresh network namespace and verify that rejection
leaves the setting unchanged.

Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
---
 tools/testing/selftests/net/.gitignore     |  1 +
 tools/testing/selftests/net/Makefile       |  1 +
 tools/testing/selftests/net/tcp_rmem_min.c | 78 ++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_rmem_min.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index dacd36ed8455..44de061e3eef 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -48,6 +48,7 @@ tcp_fastopen_backup_key
 tcp_inq
 tcp_mmap
 tcp_port_share
+tcp_rmem_min
 tfo
 timestamping
 tls
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 590b33e16d9f..595f0e6c38b0 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -198,6 +198,7 @@ TEST_GEN_PROGS := \
 	so_incoming_cpu \
 	tap \
 	tcp_port_share \
+	tcp_rmem_min \
 	tls \
 	udp_splice_checksum \
 # end of TEST_GEN_PROGS
diff --git a/tools/testing/selftests/net/tcp_rmem_min.c b/tools/testing/selftests/net/tcp_rmem_min.c
new file mode 100644
index 000000000000..dd2305d7e599
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_rmem_min.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "kselftest.h"
+
+#define TCP_RMEM_PATH "/proc/sys/net/ipv4/tcp_rmem"
+
+static int read_tcp_rmem(char *buf, size_t size)
+{
+	int fd = open(TCP_RMEM_PATH, O_RDONLY | O_CLOEXEC);
+	ssize_t len;
+
+	if (fd < 0)
+		return -1;
+
+	len = read(fd, buf, size - 1);
+	close(fd);
+	if (len < 0)
+		return -1;
+
+	buf[len] = '\0';
+	return 0;
+}
+
+int main(void)
+{
+	/* tcp_rmem is min, default, max; keep min valid and lower the default. */
+	static const char invalid_default[] = "4096 1 6291456";
+	char before[128], after[128];
+	ssize_t len;
+	int fd, write_errno;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	if (unshare(CLONE_NEWNET)) {
+		if (errno == EPERM || errno == EACCES)
+			ksft_exit_skip("network namespace unavailable\n");
+		ksft_exit_fail_perror("unshare(CLONE_NEWNET)");
+	}
+
+	if (read_tcp_rmem(before, sizeof(before)))
+		ksft_exit_fail_perror("read tcp_rmem before write");
+
+	fd = open(TCP_RMEM_PATH, O_WRONLY | O_CLOEXEC);
+	if (fd < 0)
+		ksft_exit_fail_perror("open tcp_rmem");
+
+	len = write(fd, invalid_default, sizeof(invalid_default) - 1);
+	write_errno = errno;
+	close(fd);
+
+	if (len >= 0) {
+		ksft_test_result_fail("tcp_rmem accepted a default below 4096\n");
+		ksft_finished();
+	}
+	if (write_errno != EINVAL && write_errno != ERANGE) {
+		errno = write_errno;
+		ksft_exit_fail_perror("write tcp_rmem");
+	}
+
+	if (read_tcp_rmem(after, sizeof(after)))
+		ksft_exit_fail_perror("read tcp_rmem after rejected write");
+	if (strcmp(before, after)) {
+		ksft_test_result_fail("tcp_rmem changed after rejecting invalid input\n");
+		ksft_finished();
+	}
+
+	ksft_test_result_pass("tcp_rmem rejects a default below 4096\n");
+	ksft_finished();
+}
-- 
2.43.0

