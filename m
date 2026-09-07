Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723146C4D2
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778844; cv=pass; b=roxmb3cKPMPJ/HdY7TG5n8lDlvoyaD6ETZrZ5FS5ffvwsiYVxWSMGhgt5TFHIrdfOxFIFS73TGyGbYva6m0P2TVQd6+xpz8USZzgEq9AjGkyAXjbH3H5B9qlArBuIt8+A4f2gD7BFTzPOV3drfrYbCDRhzkMqXH6RGNC32vt24A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778844; c=relaxed/simple;
	bh=1W8uvQaYp8lzNksLgoSJuXrmpDkGKXa2H0+Uugp+NpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebuhW3a+v5+/MSklwKpTES95wOQTRxp4W7dAN7QtLIglXLplXpgBx386WUjwMTbUga5/9HEiloLNCvjd+XvIrD295V7QjOjRE2x+3i/4Z1Ch0ed4nGbddvnnuQtIEljI9vbGmAoFrF4XRrImQ1vYkOsqVCV3COIyOyy7Fa5/jls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=fes6b/oi; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="fes6b/oi"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15e2dab83eso563602266b.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 04:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788778840; cv=none;
        d=google.com; s=arc-20260327;
        b=Njb/G6DqV0ZzO5xhRxPb3wuYccZFkWv+wm1fUUR1Fk6f//QDTJpTv6phNzS1XnmhIP
         FBz7/CD+h9U59BNuLebppuA/0TcAEglZ+kaGIsd8ZADxO0J8nlabgMejoXti3z9vikSe
         pEg8E6i6V/ie3knQCDFbJmV4SL02x/sRnmsyxAHtKM79Xq3gk4XSDHyR/AQBF6vgzuLt
         jBuXp6Z/bcWJCE7JH29wkBeKD3+mF0Xf8NU5bpnHjsdF7KkQ5ZqmDRJz6n237gXwNyu3
         eiRw2Ptiqlkz24TW6UL2fp4dNlS8LfKzXVvgWgeOS5uGBBrasJjggQ3xi3S2ythYE4T2
         9aKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zny1KKC/uPX8QbOxaFwPCGHoxMxtpzdiurM7Tl80u1k=;
        fh=cmku/jA6nzXMyZA5oK9Nag5AzbGsH8AGgjpfUBe5nXk=;
        b=mmZvsDE3JsoYMpHFL6IzxrZ8mhOvFVtYNlW/Hy+hdioD6pLMrUkuC6GHpDoKUuKKYQ
         QVrD4nm7JMqL/ZjslMlTKovY0iwb/3sRoNi8TlssPNJTZ1XsqH222Esn6MddtzhYw18Y
         ET81rFa6qTfeCJFKymO8ufFK9y3fmYMWjM93Q33R4jgsNze8QXawzwVsJY+RiBKSSMIN
         5rIC/SIG5Ycf41AqaXSd5KYIg3i9HByTxJlbuC2NuBCpLA+qprjaF/25CDz3u2MQve/v
         wylxPPue7P8Pbup/YqhEcHLB/CpJtHfpMpKAmrKlGzPxZP5Q3rjLFb1L8rPOl9jO/qFi
         RtsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788778840; x=1789383640; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zny1KKC/uPX8QbOxaFwPCGHoxMxtpzdiurM7Tl80u1k=;
        b=fes6b/oi9GNDqVkNavvFasu3Ix6qQF3e72pzkNmozFR13Q4JgFNWmijgUukPPBkTRz
         mQrEGCxy9QYh7qe6aHOtf/mUPiy5NppxysGh2K8i+hcWhce/GGL+YPL6SRJThSmwFrZO
         78adGg/qgqERyN5scyWvT8eWFwajNMyDJe+t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778840; x=1789383640;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zny1KKC/uPX8QbOxaFwPCGHoxMxtpzdiurM7Tl80u1k=;
        b=LGY2JNlqrk/dOzcjOzwcVOl3HGxNeKyTTwYss3HvgBqPKWvUDW7ywvZ0HQsuUyTDS3
         ztB35+XyRbIh1uPCTuXFbcOwkeg+K7I5Qv0vgB6+7rM3JvhAWoHz1g1IbWbxdWDus/sY
         PiquKQ4FINi2WppqEdHP1mFk6CSQrjUukmsnCpP9w6/FOrJnSy3j3nhxd9+vCw2kChia
         fre4ZpBIGr3Tdt1aEznclfeY/fUYdoRig1iLcF5mtpF9ublI/1iu50xD1w/z9GVsHlnY
         /eo1K1PrZk91DLeALzUnSxKyF4YN7vI9/D9e70Ubd7e6fd4swOfWHoLbkOO058iCA0bv
         fpZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvCqsTKbETp8V0s5tvLatyQyLMwXXXZL0fJAhvTqqgFXlWkdsoWIHyjiTsgaUHwDmz3hFP93Q=@vger.kernel.org
X-Gm-Message-State: AFuF++n4EzlAYH783V8QDZEBo0QHRg9/bc2gsqv+VwHqXf2wxXXlQ1Gm
	R/57ChGnKanjqatnNLIC7wNLGyYh+5+5+V+fxLQocjPCSGqhHMv3Jrvlu+HwuHh7JRE1hdSUkkO
	74QOH7jkG6yfyP6xnbQOpezBzw1WyLg/3+FSfTv7skw==
X-Gm-Gg: AYBFou2BXtM54NJwiM/pXitHy/KXao1v18p1x4j2a13pg/99tuOjLSTVanSImyRiE2/
	R3njdyT2VtsGEjLj7tMYFs1Z9MfV9wBifrGl33u5j7aN0csh4zOTHVj19ENAwpq2MOKq+Vo3wNa
	Hp4Aa7V7Vv1HRW/YgrD/Su0HYSpkjGLYCnws8iAxF18SUViGMFLnoKlYv8xiIY9ON6ZLNXqlrkz
	bE2eApJqLC+6orlgA7sfxbzKrkcgrCVyrgWrbSNVCVeQBbmdEW3+whnGDtDTxqZeDGDVvzFmLXf
	YJDNm9kmA6in9dwNAi4M29JQxCXoeQLXWt/4btmAyWlBCg3A+7NA6n5EHH3mEUKG0oysGRz5rFQ
	=
X-Received: by 2002:a17:907:7294:b0:c26:19de:9139 with SMTP id
 a640c23a62f3a-c2619dea0f1mr752175766b.44.1788778839290; Mon, 07 Sep 2026
 04:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-10-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-10-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 13:00:27 +0200
X-Gm-Features: AcwNN1U23yfZ1nAFBhZtDhOey9YcEzK38gF_zORjIDm7e-DTOat32VqriNkwZBM
Message-ID: <CAJqdLrpDz4DAkoK-5+s-KmafRsudctd3OouhXmgV=nNM-Up72w@mail.gmail.com>
Subject: Re: [PATCH 10/10] selftests/coredump: check the dumping thread's pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 31. Aug. 2026 um 13:22 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Crash from a non-leader thread and verify that the pidfd from
> SO_PEERPIDFD_THREAD on the coredump socket refers to that thread and
> reports the coredump like the thread-group leader's pidfd does.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  .../selftests/coredump/coredump_socket_test.c      | 175 +++++++++++++++++++++
>  tools/testing/selftests/coredump/coredump_test.h   |   2 +
>  .../selftests/coredump/coredump_test_helpers.c     |  49 ++++++
>  3 files changed, 226 insertions(+)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index 422728f632ca..ec73bb690bbc 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -592,6 +592,181 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
>         wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
>  }
>
> +static bool check_coredump_info(const struct pidfd_info *info, const char *what)
> +{
> +       if (!(info->mask & PIDFD_INFO_COREDUMP)) {
> +               fprintf(stderr, "%s: PIDFD_INFO_COREDUMP not set in mask\n", what);
> +               return false;
> +       }
> +
> +       if (!(info->coredump_mask & PIDFD_COREDUMPED)) {
> +               fprintf(stderr, "%s: PIDFD_COREDUMPED not set in coredump_mask\n", what);
> +               return false;
> +       }
> +
> +       if (!(info->mask & PIDFD_INFO_COREDUMP_SIGNAL) || info->coredump_signal != SIGSEGV) {
> +               fprintf(stderr, "%s: coredump_signal=%d, expected SIGSEGV=%d\n",
> +                       what, info->coredump_signal, SIGSEGV);
> +               return false;
> +       }
> +
> +       if (!(info->mask & PIDFD_INFO_COREDUMP_CODE) || info->coredump_code != SEGV_MAPERR) {
> +               fprintf(stderr, "%s: coredump_code=%d, expected SEGV_MAPERR=%d\n",
> +                       what, info->coredump_code, SEGV_MAPERR);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +/*
> + * Test: PIDFD_INFO_COREDUMP on the dumping thread's pidfd
> + *
> + * Crash from a non-leader thread and verify that the pidfd from
> + * SO_PEERPIDFD_THREAD refers to that thread and reports the coredump
> + * like the thread-group leader's pidfd from SO_PEERPIDFD does.
> + */
> +TEST_F(coredump, socket_coredump_thread)
> +{
> +       int pidfd, ret, status;
> +       pid_t pid, pid_coredump_server;
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +
> +       ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
> +               int fd_thread_pidfd = -1, fd_core_file = -1;
> +               struct pidfd_info thread_info = {};
> +               int exit_code = EXIT_FAILURE;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
> +               if (fd_server < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: listen socket failed: %m\n");
> +                       goto out;
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: ipc write failed: %m\n");
> +                       goto out;
> +               }
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: accept4 failed: %m\n");
> +                       goto out;
> +               }
> +
> +               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
> +               if (fd_peer_pidfd < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: get_peer_pidfd failed\n");
> +                       goto out;
> +               }
> +
> +               fd_thread_pidfd = get_peer_pidfd_thread(fd_coredump);
> +               if (fd_thread_pidfd < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: get_peer_pidfd_thread failed\n");
> +                       goto out;
> +               }
> +
> +               if (!get_pidfd_info(fd_peer_pidfd, &info) ||
> +                   !get_pidfd_info(fd_thread_pidfd, &thread_info)) {
> +                       fprintf(stderr, "socket_coredump_thread: get_pidfd_info failed\n");
> +                       goto out;
> +               }
> +
> +               /* The peer is the thread-group leader, the dumping thread is not. */
> +               if (info.pid != info.tgid || thread_info.tgid != info.tgid ||
> +                   thread_info.pid == thread_info.tgid) {
> +                       fprintf(stderr, "socket_coredump_thread: unexpected ids %d/%d and %d/%d\n",
> +                               info.pid, info.tgid, thread_info.pid, thread_info.tgid);
> +                       goto out;
> +               }
> +
> +               if (!check_coredump_info(&info, "SO_PEERPIDFD") ||
> +                   !check_coredump_info(&thread_info, "SO_PEERPIDFD_THREAD"))
> +                       goto out;
> +
> +               fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
> +               if (fd_core_file < 0) {
> +                       fprintf(stderr, "socket_coredump_thread: core tmpfile failed: %m\n");
> +                       goto out;
> +               }
> +
> +               for (;;) {
> +                       char buffer[4096];
> +                       ssize_t bytes_read, bytes_write;
> +
> +                       bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                       if (bytes_read < 0) {
> +                               fprintf(stderr, "socket_coredump_thread: core read failed: %m\n");
> +                               goto out;
> +                       }
> +
> +                       if (bytes_read == 0)
> +                               break;
> +
> +                       bytes_write = write(fd_core_file, buffer, bytes_read);
> +                       if (bytes_read != bytes_write) {
> +                               fprintf(stderr, "socket_coredump_thread: core write %zd/%zd: %m\n",
> +                                       bytes_read, bytes_write);
> +                               goto out;
> +                       }
> +               }
> +
> +               exit_code = EXIT_SUCCESS;
> +               fprintf(stderr, "socket_coredump_thread: completed successfully\n");
> +out:
> +               if (fd_core_file >= 0)
> +                       close(fd_core_file);
> +               if (fd_thread_pidfd >= 0)
> +                       close(fd_thread_pidfd);
> +               if (fd_peer_pidfd >= 0)
> +                       close(fd_peer_pidfd);
> +               if (fd_coredump >= 0)
> +                       close(fd_coredump);
> +               if (fd_server >= 0)
> +                       close(fd_server);
> +               _exit(exit_code);
> +       }
> +       self->pid_coredump_server = pid_coredump_server;
> +
> +       EXPECT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
> +       EXPECT_EQ(close(ipc_sockets[0]), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0)
> +               crashing_child_thread();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_EQ(WTERMSIG(status), SIGSEGV);
> +       ASSERT_TRUE(WCOREDUMP(status));
> +
> +       ASSERT_TRUE(get_pidfd_info(pidfd, &info));
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
> +       ASSERT_TRUE(!!(info.coredump_mask & PIDFD_COREDUMPED));
> +       ASSERT_EQ(info.coredump_signal, SIGSEGV);
> +
> +       wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
> +}
> +
>  /*
>   * Test: PIDFD_INFO_COREDUMP_SIGNAL via simple socket coredump with SIGABRT
>   *
> diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
> index ed47f01fa53c..4212656e31f0 100644
> --- a/tools/testing/selftests/coredump/coredump_test.h
> +++ b/tools/testing/selftests/coredump/coredump_test.h
> @@ -27,10 +27,12 @@ FIXTURE(coredump)
>  /* Shared helper function declarations */
>  void *do_nothing(void *arg);
>  void crashing_child(void);
> +void crashing_child_thread(void);
>  int create_detached_tmpfs(void);
>  int create_and_listen_unix_socket(const char *path);
>  bool set_core_pattern(const char *pattern);
>  int get_peer_pidfd(int fd);
> +int get_peer_pidfd_thread(int fd);
>  bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
>
>  /* Inline helper that uses harness types */
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 2a20faf9cb0a..36306069f62e 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -13,6 +13,7 @@
>  #include <string.h>
>  #include <sys/epoll.h>
>  #include <sys/ioctl.h>
> +#include <sys/mman.h>
>  #include <sys/socket.h>
>  #include <sys/types.h>
>  #include <sys/un.h>
> @@ -38,6 +39,10 @@ struct _fixture_coredump_data {
>
>  #define NUM_THREAD_SPAWN 128
>
> +#ifndef SO_PEERPIDFD_THREAD
> +#define SO_PEERPIDFD_THREAD 87
> +#endif
> +
>  void *do_nothing(void *arg)
>  {
>         (void)arg;
> @@ -59,6 +64,36 @@ void crashing_child(void)
>         i = *(volatile int *)NULL;
>  }
>
> +static void *crashing_thread(void *arg)
> +{
> +       int *p;
> +
> +       (void)arg;
> +
> +       /* crash on purpose with SEGV_MAPERR */
> +       p = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
> +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (p == MAP_FAILED)
> +               return NULL;
> +       munmap(p, PAGE_SIZE);
> +       *p = 0;
> +
> +       return NULL;
> +}
> +
> +void crashing_child_thread(void)
> +{
> +       pthread_t thread;
> +       int i;
> +
> +       for (i = 0; i < NUM_THREAD_SPAWN; ++i)
> +               pthread_create(&thread, NULL, do_nothing, NULL);
> +
> +       /* crash from a non-leader thread */
> +       pthread_create(&thread, NULL, crashing_thread, NULL);
> +       pause();
> +}
> +
>  int create_detached_tmpfs(void)
>  {
>         int fd_context, fd_tmpfs;
> @@ -138,6 +173,20 @@ int get_peer_pidfd(int fd)
>         return fd_peer_pidfd;
>  }
>
> +int get_peer_pidfd_thread(int fd)
> +{
> +       int fd_peer_pidfd;
> +       socklen_t fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
> +       int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD_THREAD, &fd_peer_pidfd,
> +                            &fd_peer_pidfd_len);
> +       if (ret < 0) {
> +               fprintf(stderr, "%s: getsockopt(SO_PEERPIDFD_THREAD) failed: %m\n", __func__);
> +               return -1;
> +       }
> +       fprintf(stderr, "%s: successfully retrieved pidfd %d\n", __func__, fd_peer_pidfd);
> +       return fd_peer_pidfd;
> +}
> +
>  bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
>  {
>         int ret;
>
> --
> 2.53.0
>
