Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D030675F
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775472; cv=pass; b=rwcrC29Ct2X2+Zwb4fVuNOxqh+BjQBxotN0ejAtQ4nMAV94R4CQpujjWVddvXbMVzfrVAa++Pe9QHLusAlNx8dUXk5JsdhGgdWOLnd8PcXUsC8yDS9VWRq8+hPp4+UH1aD3W2QZ/yihmPk4in3+6GBQe79e/ZeREzj6YMLx2vEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775472; c=relaxed/simple;
	bh=t0gmqSsELkYeAdkrHCvcJgihVwo4xcwTdmB7LfyN9pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbe6q7dykriw8oK5ClXgbKULPHjGdV883pXKIz9ghkJVKkPC7BDFXtzF1kr72yQ17OiMZDcTMhmL3FMd6ItY8ncqdr7aMyTV1IRhivmUZxuj/CkaWpBTGlbNatrtS9e35jxDCUTzUpqJ2Xa8CmDx54GGL+Ldnz54H8WRPgB6PDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=ZPK76V/v; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="ZPK76V/v"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2055573c8cso407346866b.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 03:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788775468; cv=none;
        d=google.com; s=arc-20260327;
        b=Ocai6yEDuIyUNhTZ3pLfzvf6wNKySlqfy4jTnWBQnmx0A9EUj1j4QvU6C0m/ViPUSq
         boJ7f4IV6QvGv9uWrHcpYKDHESkDxyzRTspnGt9K+7l06bDa4cGSc6ZGZJz30K+OHSB2
         aKmXtDqkWjjbrdj0/nZiE7e+Q/OGDndfzYjET6e0kcFFrOhy7U+kg9Qo4VwStFtLhXbJ
         S9P6hwCPdczsMlhy5po+T0hB8EnvfRwhq3roscyMeNy7O+FDJNEzFn5JLGFeO8GWGTqw
         FyiOhhZGD9aRm3KXZ2JVKE9dwUkT1s+W5BaWoeL1B0I1uNT1U8NMeYq1rcqYvXMnbsH+
         tVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zz1BLCyCTXn7C+FlfZxMgF1zGe1NobuOstWz2dxBIQs=;
        fh=68qiuwc0pEkrS8D634zgezTmsLnw9gZX5P5RVHUTzIc=;
        b=dohr1zYmajJFyMSayJxHCKZi4QyCimAUTeM4syoAym3EOirWKizKfiHtj4YxLF3UZy
         YvdGp4wszZR/hh2BGoxaCklKhvCAW91l10T+obUyIMUUqjJk/B+b5wrsVwwR/41gUGf1
         D8uLqpMYxp3L0syaZuI3Epj2LJ4dyRsdbXQrx5lxAVik1XFlE113g3wZhH7jIntYgUcd
         fJFXObGmAdB4x+7IWSkBfoZE7Pd1NwPs03xfjtszM9LgZ/UnYrNWfCKwICBZFnojBHd2
         HZQ9BqAlt6y01JGPalomv0vMr/JmTvLPQQrpCFG2W1s4SpA8wYZYXQehZB7VfKS7KvQS
         jibg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788775468; x=1789380268; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zz1BLCyCTXn7C+FlfZxMgF1zGe1NobuOstWz2dxBIQs=;
        b=ZPK76V/vYPl2HTeiYiMf32JhzmSUIthhElSBmoQc1pa5UFXrw1KFjUVroMqp1oH9Cu
         Q60UK2Oi3gzsvMVopMlsLol1CZjcMdoI7uL7eEWUIig+mLYXGdRw1wKobHBEhto63fl8
         zs5ZauUT3H+pfn68GpPzta6xouc+XCMHFkerQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788775468; x=1789380268;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zz1BLCyCTXn7C+FlfZxMgF1zGe1NobuOstWz2dxBIQs=;
        b=BWW1HGbIq2PWpiMLre0ZmaM6QICY4JZMq8K8AY8JG+yooC4DRu7oTEJIlowjexK9LN
         rH7CsBNjks6fq966ybXbXMaZmouQq5M3O6OqsmImEW9eQzSBG7PfGr5SSpAl3rmHocN9
         4yi7xT1Z2CoLat2crjzJfnNtaKt3nFwqAI7c5yaesGJeb2jADfM44M+0TGYlIJyC71/F
         xQi54lS4Q9JSWvZLuez3P5vJmshA6SpzgeNkCbkfoUIHdWFH6HwNs+wqgAqyVV+6xq/W
         nsT5ZiKpb0xO4R+/3b7E00T/tTzM2nzGZBilgKQCsOWjUfaxtoa+mamlwr07lcqt6rjS
         IA9A==
X-Forwarded-Encrypted: i=1; AKwUvBx7Hzlmkjmyo46y1E0kw9wxWig+lRAY011H4fF7hH2ybDqfzhq86qlhU16kHxaqtuN5Do4JaO4=@vger.kernel.org
X-Gm-Message-State: AFuF++kZdTJ9V9nbxUJt+xCnGJ8oSe14Zei3ITdjMgcx7IlKEeMhARGZ
	7462Jma45xOEJVrRCRAULX0Bd8vPMgBpMC0iTqwLzv1qu5fpM+u/vO33p4Kxjo/zkQHOgwZ+tTL
	RewO98LDUot7vpD10TJkT0Uiy62JXk1qDXVoHJTUyNg==
X-Gm-Gg: AYBFou00Qs+y8Zof6VVaN6rZGkNhL58h6UmBEgX8BGgS1SEA97cm4drnrjwa38JYeBA
	mE4ERG7GqmPvUmGe1R4/lQ2BSsjl68Z5umUrrg//1YAfBwYXJ6Xg26i04cUGYEEfiQ11OwyYeHb
	7NDg5v/+JcUfglJZebWAb1lU/9WHzSYd+mdvQju/yyl6GO/dMZJ0gPD1Du1ZCjOYACMuY3GQaOJ
	knVccH9ljojcaeUDXVo2T+j4LLJIAGleAQAe8Xz/UQmujpisOkk1zmUOEK2KrNtFAHTPwJp/upA
	E7eG+Qp0I0XTuYF+LF1qHijfxFCkGjOgDgKcZBVcNfrzd1FiQKPU3k3GVo94u/ZrjDfBIe8igkA
	=
X-Received: by 2002:a17:907:7243:b0:c26:1649:47b4 with SMTP id
 a640c23a62f3a-c2616495644mr674091266b.42.1788775468318; Mon, 07 Sep 2026
 03:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-4-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-4-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 12:04:16 +0200
X-Gm-Features: AcwNN1U53obUY6edk7tmo2gorb4aQGmQvzBhetE_1I4r8D7MXt3o-Z0oL-9LgKg
Message-ID: <CAJqdLrqZOCdioD47OvrW2GtJ+Mi7=a-PSErmJ21ujqQSNUViCA@mail.gmail.com>
Subject: Re: [PATCH 04/10] selftests/net: SO_PASSPIDFD_THREAD
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 31. Aug. 2026 um 13:21 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Extend the af_unix scm_pidfd selftest with SO_PASSPIDFD_THREAD tests.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  tools/testing/selftests/net/af_unix/Makefile    |   2 +
>  tools/testing/selftests/net/af_unix/scm_pidfd.c | 269 ++++++++++++++++++++++++
>  2 files changed, 271 insertions(+)
>
> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
> index a66f10fb0c23..45b841758f1b 100644
> --- a/tools/testing/selftests/net/af_unix/Makefile
> +++ b/tools/testing/selftests/net/af_unix/Makefile
> @@ -23,6 +23,8 @@ TEST_GEN_FILES := scm_rights_denial_lsm.bpf.o
>  include ../../lib.mk
>  include ../bpf.mk
>
> +$(OUTPUT)/scm_pidfd: CFLAGS += -pthread
> +
>  $(OUTPUT)/scm_rights_denial_lsm: $(BPFOBJ)
>  $(OUTPUT)/scm_rights_denial_lsm: CFLAGS += -I$(SCRATCH_DIR)/include
>  $(OUTPUT)/scm_rights_denial_lsm: LDLIBS += -lelf -lz
> diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
> index 2c18b92a2603..019c48e1cdcd 100644
> --- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
> +++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
> @@ -10,6 +10,7 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <errno.h>
> +#include <pthread.h>
>  #include <sys/un.h>
>  #include <sys/signal.h>
>  #include <sys/types.h>
> @@ -27,6 +28,10 @@
>  #define SCM_PIDFD 0x04
>  #endif
>
> +#ifndef SO_PASSPIDFD_THREAD
> +#define SO_PASSPIDFD_THREAD 86
> +#endif
> +
>  #define CHILD_EXIT_CODE_OK 123
>
>  static void child_die()
> @@ -553,4 +558,268 @@ TEST_F(scm_pidfd, test)
>         close(pfd);
>  }
>
> +struct thread_ids {
> +       pid_t pid;
> +       pid_t tid;
> +};
> +
> +static void *send_ids_thread(void *arg)
> +{
> +       int fd = *(int *)arg;
> +       struct thread_ids ids = {
> +               .pid = getpid(),
> +               .tid = gettid(),
> +       };
> +       char sync;
> +
> +       if (send(fd, &ids, sizeof(ids), 0) != sizeof(ids))
> +               return (void *)1;
> +
> +       /* stay alive until the receiver has looked at our pidfd */
> +       if (read(fd, &sync, 1) != 1)
> +               return (void *)1;
> +
> +       return NULL;
> +}
> +
> +static void *send_ids_creds_thread(void *arg)
> +{
> +       int fd = *(int *)arg;
> +       struct thread_ids ids = {
> +               .pid = getpid(),
> +               .tid = gettid(),
> +       };
> +       struct ucred ucred = {
> +               .pid = getpid(),
> +               .uid = getuid(),
> +               .gid = getgid(),
> +       };
> +       char control[CMSG_SPACE(sizeof(ucred))] = { 0 };
> +       struct iovec iov;
> +       struct msghdr msg = { 0 };
> +       struct cmsghdr *cmsg;
> +       char sync;
> +
> +       iov.iov_base = &ids;
> +       iov.iov_len = sizeof(ids);
> +
> +       msg.msg_iov = &iov;
> +       msg.msg_iovlen = 1;
> +       msg.msg_control = control;
> +       msg.msg_controllen = sizeof(control);
> +
> +       cmsg = CMSG_FIRSTHDR(&msg);
> +       cmsg->cmsg_level = SOL_SOCKET;
> +       cmsg->cmsg_type = SCM_CREDENTIALS;
> +       cmsg->cmsg_len = CMSG_LEN(sizeof(ucred));
> +       memcpy(CMSG_DATA(cmsg), &ucred, sizeof(ucred));
> +
> +       if (sendmsg(fd, &msg, 0) != sizeof(ids))
> +               return (void *)1;
> +
> +       if (read(fd, &sync, 1) != 1)
> +               return (void *)1;
> +
> +       return NULL;
> +}
> +
> +static void thread_client(int fd, int syncfd, void *(*sender)(void *))
> +{
> +       pthread_t thread;
> +       void *ret;
> +       char sync;
> +
> +       /* wait until the receiver enabled SO_PASSPIDFD */
> +       if (read(syncfd, &sync, 1) != 1)
> +               child_die();
> +
> +       if (pthread_create(&thread, NULL, sender, &fd))
> +               child_die();
> +
> +       if (pthread_join(thread, &ret) || ret)
> +               child_die();
> +
> +       exit(0);
> +}
> +
> +static int recv_pidfd(int fd, struct thread_ids *ids)
> +{
> +       char control[CMSG_SPACE(sizeof(int))] = { 0 };
> +       struct iovec iov;
> +       struct msghdr msg = { 0 };
> +       struct cmsghdr *cmsg;
> +       int pidfd = -1;
> +
> +       iov.iov_base = ids;
> +       iov.iov_len = sizeof(*ids);
> +
> +       msg.msg_iov = &iov;
> +       msg.msg_iovlen = 1;
> +       msg.msg_control = control;
> +       msg.msg_controllen = sizeof(control);
> +
> +       if (recvmsg(fd, &msg, 0) != sizeof(*ids)) {
> +               log_err("recvmsg");
> +               return -1;
> +       }
> +
> +       if (msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC)) {
> +               log_err("recvmsg: truncated");
> +               return -1;
> +       }
> +
> +       for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
> +            cmsg = CMSG_NXTHDR(&msg, cmsg)) {
> +               if (cmsg->cmsg_level == SOL_SOCKET &&
> +                   cmsg->cmsg_type == SCM_PIDFD)
> +                       memcpy(&pidfd, CMSG_DATA(cmsg), sizeof(pidfd));
> +       }
> +
> +       return pidfd;
> +}
> +
> +static int thread_pidfd_flow(void *(*sender)(void *), int optname,
> +                            struct thread_ids *ids, struct pidfd_info *info)
> +{
> +       int sk[2];
> +       int syncpipe[2];
> +       int pidfd;
> +       int child_status = 0;
> +       pid_t child;
> +
> +       if (socketpair(AF_UNIX, SOCK_STREAM, 0, sk))
> +               return -1;
> +
> +       if (pipe(syncpipe))
> +               return -1;
> +
> +       child = fork();
> +       if (child < 0)
> +               return -1;
> +
> +       if (child == 0) {
> +               close(sk[0]);
> +               close(syncpipe[1]);
> +               thread_client(sk[1], syncpipe[0], sender);
> +       }
> +       close(sk[1]);
> +       close(syncpipe[0]);
> +
> +       int on = 1;
> +
> +       if (setsockopt(sk[0], SOL_SOCKET, optname, &on, sizeof(on))) {
> +               log_err("Failed to set pidfd passing option");
> +               return -1;
> +       }
> +
> +       if (write(syncpipe[1], "1", 1) != 1)
> +               return -1;
> +       close(syncpipe[1]);
> +
> +       pidfd = recv_pidfd(sk[0], ids);
> +       if (pidfd < 0)
> +               return -1;
> +
> +       info->mask = PIDFD_INFO_PID;
> +       if (ioctl(pidfd, PIDFD_GET_INFO, info)) {
> +               log_err("ioctl(PIDFD_GET_INFO)");
> +               close(pidfd);
> +               return -1;
> +       }
> +       close(pidfd);
> +
> +       /* release the sending thread */
> +       if (write(sk[0], "x", 1) != 1)
> +               return -1;
> +       close(sk[0]);
> +
> +       waitpid(child, &child_status, 0);
> +       if (!WIFEXITED(child_status) || WEXITSTATUS(child_status))
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static int sockopt_set(int fd, int optname, int val)
> +{
> +       return setsockopt(fd, SOL_SOCKET, optname, &val, sizeof(val));
> +}
> +
> +static int sockopt_get(int fd, int optname)
> +{
> +       socklen_t len = sizeof(int);
> +       int val = -1;
> +
> +       if (getsockopt(fd, SOL_SOCKET, optname, &val, &len))
> +               return -1;
> +
> +       return val;
> +}
> +
> +TEST(scm_pidfd_setsockopt_values)
> +{
> +       int sk[2];
> +
> +       ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM, 0, sk));
> +
> +       ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD_THREAD, 1));
> +       ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
> +       ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD));
> +
> +       /* The option set last wins. */
> +       ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD, 1));
> +       ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD));
> +       ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
> +
> +       ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD_THREAD, 1));
> +       ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
> +       ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD));
> +
> +       /* Disabling one option leaves the other alone. */
> +       ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD, 0));
> +       ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
> +       ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD_THREAD, 0));
> +       ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD));
> +       ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
> +
> +       close(sk[0]);
> +       close(sk[1]);
> +}
> +
> +TEST(scm_pidfd_thread)
> +{
> +       struct thread_ids ids;
> +       struct pidfd_info info;
> +
> +       ASSERT_EQ(0, thread_pidfd_flow(send_ids_thread, SO_PASSPIDFD_THREAD,
> +                                      &ids, &info));
> +       ASSERT_NE(ids.pid, ids.tid);
> +       EXPECT_EQ(ids.tid, info.pid);
> +       EXPECT_EQ(ids.pid, info.tgid);
> +}
> +
> +TEST(scm_pidfd_thread_group)
> +{
> +       struct thread_ids ids;
> +       struct pidfd_info info;
> +
> +       ASSERT_EQ(0, thread_pidfd_flow(send_ids_thread, SO_PASSPIDFD,
> +                                      &ids, &info));
> +       ASSERT_NE(ids.pid, ids.tid);
> +       EXPECT_EQ(ids.pid, info.pid);
> +       EXPECT_EQ(ids.pid, info.tgid);
> +}
> +
> +TEST(scm_pidfd_thread_creds)
> +{
> +       struct thread_ids ids;
> +       struct pidfd_info info;
> +
> +       ASSERT_EQ(0, thread_pidfd_flow(send_ids_creds_thread, SO_PASSPIDFD_THREAD,
> +                                      &ids, &info));
> +       ASSERT_NE(ids.pid, ids.tid);
> +       EXPECT_EQ(ids.tid, info.pid);
> +       EXPECT_EQ(ids.pid, info.tgid);
> +}
> +
>  TEST_HARNESS_MAIN
>
> --
> 2.53.0
>
