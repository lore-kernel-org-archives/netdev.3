Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817249482E
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587673; cv=none; b=H6nx/R1UWhZNsGlgRU515S3itU33IKckf6iHU9fn/XgN4c05hr5dvgL0HG5ySEmDDLeCv51CjPthjbHR7tt9cVF6abfTUspD6Sj98MdgqZkMCSpGMXiWHlGDpTes5QXbHZYt0hPqnS5wpZIT3fjdyyFn82TlcGG4kCJpbLIJS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587673; c=relaxed/simple;
	bh=dGHrchG/abitpSpPzVzh/aTSFCY3Ku7xR5Cg+X5z2GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jY1POPp7sJIlRn5Ho/Y5RyNMB+HEbj8QgiZKzd+mUcNpph5T7xrwN4t9QP9FaPm0bJmFX2kDrB9QyIWZj5KBXNN/ikbJcXdopHQUOprVh1vrNXbCIxMeqomUz4ZqvjFJzeA4SZxtjZ7PGcSGCGQ45XwvP/E4BeGSE5EjmH1Vqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=Gause42G; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="Gause42G"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso4382309a12.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587667; x=1791192467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dbq2DM657UXRUZrUM+7dawOTBHr08M0XClPpfaZ9skM=;
        b=Gause42GxbcGCxT33S8IvWnH5MBVnxzuNkdbIrEoUbdYFdjp7kXoUYURpBnZ+51CeO
         y88LzPkoD39gJLQ/8XNkC4YFCCW74xF2PWUVSmRcRWJMsRkJ/c6hEFEyrFBUhIhFXPl9
         nHqbzZHMJCvKtGOZboRYQwYh8fLXxg5Gw+2WYvgeKziJ/TL16AgdE11bxNoxValyAM0L
         ASlcelH0aFTH0jzMYi7QFmTilFlgEmqvGkf92bqmEAo0p2Ij5eLiQ6ctfrFRJm80pLFf
         QiSF70xgZxyVJJFXrXl9Dj63B2BRAaExMjyI2X2jCb4v9ylyXK0bgFLDwHEDqUOU97L0
         26eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587667; x=1791192467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dbq2DM657UXRUZrUM+7dawOTBHr08M0XClPpfaZ9skM=;
        b=zcS/XnG5Xq6bU8F7PK6Ln8Xf5NjfpuzxpJM10dB6kuzNq+2NiX8nt8ujEI/uCoRu9H
         JnYk3+hkIfHdMx++74uDMvFZ6m9w4D1G0rDYilgM8bERnXtit6pnficwzOiUT6DkTseA
         l+cfWeSdgiQ5hccyPFu0nhCy6C1HOuW+MP/kIH9U/UtMWDeyMHkem3JrYdQMmc1ZIA7C
         2CGo9YM7RUdVEJJbB8OkjecA7FIJDR2qnsvBAemUfVF5vc7EYHwz3SOzicfWet9+EP4T
         Qu3f2QJMJT5Nk8cPYt85phLSSQoFSq/HbNrpLULIcZbTbmoRAXYDHlQ9vX7b/DRpz2gk
         808g==
X-Forwarded-Encrypted: i=1; AKwUvBzKCwwGUF4U0pnkRh3cEU2lcbEwk3FOelIV8HcPpKQlCiOnCQcS0nwToA2c642A/bT2dO1Qo7M=@vger.kernel.org
X-Gm-Message-State: AFuF++nMTSLAqlfRuIcU0mN1VM754ucuhPgLwXNbbQQrfAJuOZdRkzqU
	zc1ha4JOLEN0ZSIy3RhwklQgOrpwEdXdtq4lh3cOCxnc2/vQoHtBNygTCIFdoMbqIYTB
X-Gm-Gg: AYBFou1w+HN1Si2G3Irm+nCwXNg0mNEiEjPfj7799dUuANEbmWh9xJhquzUSE7D3ipx
	FrAn9iDGf2CnLgjLrCcEAt4qoLbsYyJO+oCmr4DU8jsLEGsmHWCxIVgldeY4aO0jcVTYGXCSgQO
	rq2CC0+zCKUbFAooZ+k6vsiBWE22VaXR2mB+u1DweVb4qLRqeizKc1JDoSDGM/YyKwT3ldgxLyE
	zRdfik/QlIaOOl7OLBwul6PcHTx62IekzuUpK/2pFfUrID7bZdtdkY4LHWZlc8w35yMfZiyNlhQ
	5mCXZNT4VzvUZCCKq9Xao7WECe8LQbNU+Qmx6lEReHM9RDemsn3gv9S7KqPr/Tubqo0KBwr0B/W
	fHCDDuMAweU+Ep8WyB2uNkqiwTUWBJloPWdZh1e0v4FscDrzTgxLYf2mgiQSEpSX92E/UT+g/2I
	ZeNHpGjKgWDF0FDmqAvb120yLQXfmIoMBpR/URcvgIi0B57avaac+ZRY8rmHQe6ep1IYbP0c0gg
	HW0eZBWDkcV9UUpQHdJgmPR3CPX3I9AMTTQyjqDYQ==
X-Received: by 2002:a17:907:6091:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c2ac23d6040mr1047117566b.20.1790587666848;
        Mon, 28 Sep 2026 02:27:46 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:46 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 28 Sep 2026 11:27:17 +0200
Subject: [PATCH v3 10/10] selftests/coredump: check the dumping thread's
 pidfd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-work-unix-passpidfd-v3-10-532018a91b21@amutable.com>
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

Crash from a non-leader thread and verify that the pidfd from
SO_PEERPIDFD_THREAD on the coredump socket refers to that thread and
reports the coredump like the thread-group leader's pidfd does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 .../selftests/coredump/coredump_socket_test.c      | 175 +++++++++++++++++++++
 tools/testing/selftests/coredump/coredump_test.h   |   2 +
 .../selftests/coredump/coredump_test_helpers.c     |  49 ++++++
 3 files changed, 226 insertions(+)

diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index 422728f632ca..ec73bb690bbc 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -592,6 +592,181 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
 
+static bool check_coredump_info(const struct pidfd_info *info, const char *what)
+{
+	if (!(info->mask & PIDFD_INFO_COREDUMP)) {
+		fprintf(stderr, "%s: PIDFD_INFO_COREDUMP not set in mask\n", what);
+		return false;
+	}
+
+	if (!(info->coredump_mask & PIDFD_COREDUMPED)) {
+		fprintf(stderr, "%s: PIDFD_COREDUMPED not set in coredump_mask\n", what);
+		return false;
+	}
+
+	if (!(info->mask & PIDFD_INFO_COREDUMP_SIGNAL) || info->coredump_signal != SIGSEGV) {
+		fprintf(stderr, "%s: coredump_signal=%d, expected SIGSEGV=%d\n",
+			what, info->coredump_signal, SIGSEGV);
+		return false;
+	}
+
+	if (!(info->mask & PIDFD_INFO_COREDUMP_CODE) || info->coredump_code != SEGV_MAPERR) {
+		fprintf(stderr, "%s: coredump_code=%d, expected SEGV_MAPERR=%d\n",
+			what, info->coredump_code, SEGV_MAPERR);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Test: PIDFD_INFO_COREDUMP on the dumping thread's pidfd
+ *
+ * Crash from a non-leader thread and verify that the pidfd from
+ * SO_PEERPIDFD_THREAD refers to that thread and reports the coredump
+ * like the thread-group leader's pidfd from SO_PEERPIDFD does.
+ */
+TEST_F(coredump, socket_coredump_thread)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int fd_thread_pidfd = -1, fd_core_file = -1;
+		struct pidfd_info thread_info = {};
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_coredump_thread: listen socket failed: %m\n");
+			goto out;
+		}
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_coredump_thread: ipc write failed: %m\n");
+			goto out;
+		}
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_coredump_thread: accept4 failed: %m\n");
+			goto out;
+		}
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_coredump_thread: get_peer_pidfd failed\n");
+			goto out;
+		}
+
+		fd_thread_pidfd = get_peer_pidfd_thread(fd_coredump);
+		if (fd_thread_pidfd < 0) {
+			fprintf(stderr, "socket_coredump_thread: get_peer_pidfd_thread failed\n");
+			goto out;
+		}
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info) ||
+		    !get_pidfd_info(fd_thread_pidfd, &thread_info)) {
+			fprintf(stderr, "socket_coredump_thread: get_pidfd_info failed\n");
+			goto out;
+		}
+
+		/* The peer is the thread-group leader, the dumping thread is not. */
+		if (info.pid != info.tgid || thread_info.tgid != info.tgid ||
+		    thread_info.pid == thread_info.tgid) {
+			fprintf(stderr, "socket_coredump_thread: unexpected ids %d/%d and %d/%d\n",
+				info.pid, info.tgid, thread_info.pid, thread_info.tgid);
+			goto out;
+		}
+
+		if (!check_coredump_info(&info, "SO_PEERPIDFD") ||
+		    !check_coredump_info(&thread_info, "SO_PEERPIDFD_THREAD"))
+			goto out;
+
+		fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
+		if (fd_core_file < 0) {
+			fprintf(stderr, "socket_coredump_thread: core tmpfile failed: %m\n");
+			goto out;
+		}
+
+		for (;;) {
+			char buffer[4096];
+			ssize_t bytes_read, bytes_write;
+
+			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+			if (bytes_read < 0) {
+				fprintf(stderr, "socket_coredump_thread: core read failed: %m\n");
+				goto out;
+			}
+
+			if (bytes_read == 0)
+				break;
+
+			bytes_write = write(fd_core_file, buffer, bytes_read);
+			if (bytes_read != bytes_write) {
+				fprintf(stderr, "socket_coredump_thread: core write %zd/%zd: %m\n",
+					bytes_read, bytes_write);
+				goto out;
+			}
+		}
+
+		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_coredump_thread: completed successfully\n");
+out:
+		if (fd_core_file >= 0)
+			close(fd_core_file);
+		if (fd_thread_pidfd >= 0)
+			close(fd_thread_pidfd);
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child_thread();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGSEGV);
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
+	ASSERT_TRUE(!!(info.coredump_mask & PIDFD_COREDUMPED));
+	ASSERT_EQ(info.coredump_signal, SIGSEGV);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
 /*
  * Test: PIDFD_INFO_COREDUMP_SIGNAL via simple socket coredump with SIGABRT
  *
diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
index ed47f01fa53c..4212656e31f0 100644
--- a/tools/testing/selftests/coredump/coredump_test.h
+++ b/tools/testing/selftests/coredump/coredump_test.h
@@ -27,10 +27,12 @@ FIXTURE(coredump)
 /* Shared helper function declarations */
 void *do_nothing(void *arg);
 void crashing_child(void);
+void crashing_child_thread(void);
 int create_detached_tmpfs(void);
 int create_and_listen_unix_socket(const char *path);
 bool set_core_pattern(const char *pattern);
 int get_peer_pidfd(int fd);
+int get_peer_pidfd_thread(int fd);
 bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
 
 /* Inline helper that uses harness types */
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 2a20faf9cb0a..36306069f62e 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -13,6 +13,7 @@
 #include <string.h>
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/un.h>
@@ -38,6 +39,10 @@ struct _fixture_coredump_data {
 
 #define NUM_THREAD_SPAWN 128
 
+#ifndef SO_PEERPIDFD_THREAD
+#define SO_PEERPIDFD_THREAD 87
+#endif
+
 void *do_nothing(void *arg)
 {
 	(void)arg;
@@ -59,6 +64,36 @@ void crashing_child(void)
 	i = *(volatile int *)NULL;
 }
 
+static void *crashing_thread(void *arg)
+{
+	int *p;
+
+	(void)arg;
+
+	/* crash on purpose with SEGV_MAPERR */
+	p = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED)
+		return NULL;
+	munmap(p, PAGE_SIZE);
+	*p = 0;
+
+	return NULL;
+}
+
+void crashing_child_thread(void)
+{
+	pthread_t thread;
+	int i;
+
+	for (i = 0; i < NUM_THREAD_SPAWN; ++i)
+		pthread_create(&thread, NULL, do_nothing, NULL);
+
+	/* crash from a non-leader thread */
+	pthread_create(&thread, NULL, crashing_thread, NULL);
+	pause();
+}
+
 int create_detached_tmpfs(void)
 {
 	int fd_context, fd_tmpfs;
@@ -138,6 +173,20 @@ int get_peer_pidfd(int fd)
 	return fd_peer_pidfd;
 }
 
+int get_peer_pidfd_thread(int fd)
+{
+	int fd_peer_pidfd;
+	socklen_t fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
+	int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD_THREAD, &fd_peer_pidfd,
+			     &fd_peer_pidfd_len);
+	if (ret < 0) {
+		fprintf(stderr, "%s: getsockopt(SO_PEERPIDFD_THREAD) failed: %m\n", __func__);
+		return -1;
+	}
+	fprintf(stderr, "%s: successfully retrieved pidfd %d\n", __func__, fd_peer_pidfd);
+	return fd_peer_pidfd;
+}
+
 bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
 {
 	int ret;

-- 
2.55.0

