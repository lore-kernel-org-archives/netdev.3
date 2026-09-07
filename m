Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7747ACD2
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778317; cv=pass; b=GFhFSLCFkOn3rjqR4khkV8PymhrZvbcQPdDOYco1kBYhGNjdL+YnZC2AyrvpEFX6B4EMQ/j43mkRiL00Et6KmYpHH9fk/wiofyr7Jbtlh8rp+14ibXZC9l2SdebDVnQ7etJOVKQMhnP2+Rbr9061dNqV7FJyMM8wwB9FTWztnog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778317; c=relaxed/simple;
	bh=W0+b9KvoApA0Cu4KJvDEn2s8LS//dxJC59n6wwetQT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQs3sNMxwtLXaIgZ09XNoF/p3MirdIVWIb2hktBlrd51LU1BXLFpWe+HOzCkil0ef3d8KlqMfh6tZsbwIYdRzu6lFtObII9QFwtBtDgS3lrpjATogOC5wOhCMRZEkZLFbScqiws2EyOnjPi8wi6pvYAbq+FRuEIaP1aSnklUnKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=c0ltu23P; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="c0ltu23P"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2533d83e3bso561599066b.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 03:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788778312; cv=none;
        d=google.com; s=arc-20260327;
        b=i5GrZAriTt173jWL4Z0x/t3/w0HY2c63Ko6QQQGqhRU1OQBhQIHoEef7t5mU+XKtED
         RPHz2/vOHb5NTb5b6kXaQf80SkkLr31DXNGfv8IBooKBJ4EPnj2qrg69B1Sw4vT9Xb0T
         ri2GmIS0BG4GAtK21M2XN10kWyVbGGd9USjF3/+Tjz9MZ3VJ3Y8prpqnshLhJpUZKdrg
         jTEYPQNSlnS8Ctj+I+6dJlMGO90yak3JIF8O6pon0/VY/GO0IJM3LEikATiZiUIhQxmd
         as2sCUYsSV/bjcEK79IOuTLS4rP5N+UEI+SSjT8DgYPZPrLmq/EKn9Pr5Xq47wD4yY+P
         Va3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GKeVIBKeBEiqOVb6fEusAWCMyuo++LHKEtSCxIMKohw=;
        fh=s1yZ3EI6kftMAqIa3s82ErXWxwRs6wcDchjpSOMBcBo=;
        b=QAWqlBEIZbzZn+WI9PxJTk8CsvWRyq39Q4XHo3upT8vw0RypdrUjO3sWi2LqC04Yh7
         b4egPYgQ28xsp91YgzCm4WHT7U1zVOjnCrUWu+aU5JFCBPQk8WyuJRw5jgkxtj8nkzEo
         1w7bsl2KqRxpjAFqu0PmoOpOfjxYJvWKtT4tWQYdiAJhOCHCFdcDt+X4IYeje6mVtEzP
         Oknj34VY+BEohoFkK2bn4ISqTANeCJgG6CJT/11fQkomz6moq8CioOY62qS0Ry4Ng3VD
         CNIa6NTxIvo8bbzbqGEtk57Zd6GgYGRMh+DwUiAzt/5zBZpt4G6v/3qnwQpZh6W87MNu
         7yPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788778312; x=1789383112; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKeVIBKeBEiqOVb6fEusAWCMyuo++LHKEtSCxIMKohw=;
        b=c0ltu23PRE6Vkb70dkQgLopWyERqmVyY4VAevKZB3faJDwTC26STv7TqMJZ8hDC+Vo
         dRXOgDmhA2EKBpBCaDKCmZ3iZbyqlzxvReT4FsIuRxZoRmThb6SrYFZxFUMCaBC9UMc4
         g1dDH2OSaVvI2RuV6lrGWrbP2kkej9bBPSZ98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778312; x=1789383112;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GKeVIBKeBEiqOVb6fEusAWCMyuo++LHKEtSCxIMKohw=;
        b=bLsC/7kn/EcLcPlhyS4sw+pLDYJg2hFPX1Tyi/VohvHeOUNhXNfdMhf4HOXSG5TrIG
         nvQm91U8nGstpGA4UlEpK3eI7rh6/naHLUnfmjbmrR60OKeBtzDzJ/Nv+CbuiJR7ZGK6
         P+SWugJaKEJf0lkuHVSAZFbCjCH0ZS5GBMoF1pDw2Z1eNxLNH3/+x8Qb6vCKZQimPDEt
         8R4lHMbapRVwIOozmu6WjBNgOEiWZAZVSc06TPi5tOVslPEEMdzV7MvU5hYuojhd78pC
         pEO3gwSIz0V/CBeEK/LZqrywGE7xRqY4cznZWhlp2zvE1+io5IWhsLEK7nA+8T46Hsh7
         VrPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPMTqqtTyxDdiPiV9zVmFvxeKqnG03pWzglRs8AYlwni3+wGNwu44pwO0R5POhgGMJOKMdVzU=@vger.kernel.org
X-Gm-Message-State: AFuF++n+OOx8763+CXt0Sj55kTCBlSBuGmEv5s9W3toVi8DlBlOZ6PqM
	FiUvhdPXirrakZ0dJ+9mI/edl1JkhY6pwnPaKNJwH54CMFg9YH4/ZTp7YgHMfaR2vsguT3VGozu
	vA4CRvuGdUnvwn/jzKXEO1s0CN9U1oZ+ABlwTpulMNw==
X-Gm-Gg: AYBFou2ABsYZUkyngXmGP61PwkF5vsWuGBw02f/2AW9HjZMg1uvDHnHm315Pxf1faCI
	hUeMtYwrlPGzx5mDmwsK9DK4VOK3bPd42UQS+AtuGfOJOPX9K6OI5sc3rqqTlqXc+/3MOyC+StX
	333vzPF730EHc3d7hhmbTRHu5yv3GPm8mdqXEnkvJV44kjOhh7SNuGHHZRpwxwIeN/GOjPd6bFO
	jtr7ylglNFrgYnc8HDaz5AZLYDx9NFjPzjsdtqPM3anN+0w8MvrPy7pa2+upq0ZjpVsUntAeLua
	qBInc0UyliACLuPF8KEBE3DJ7n4yFEXGIEQtZ+BLyzl1H4c60wOTdoayo+ktkpdgrIptvwbku+M
	=
X-Received: by 2002:a17:907:3e1a:b0:c24:87e5:6491 with SMTP id
 a640c23a62f3a-c260c971f12mr1411193766b.2.1788778312538; Mon, 07 Sep 2026
 03:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org> <20260831-work-unix-passpidfd-v1-8-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-8-70cbfda0c7ba@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 12:51:40 +0200
X-Gm-Features: AcwNN1XE00oDe9AYh-ifVutenx203jQLfwtnAnzkRMIu2D8-Sqlf4xuqnAwBMnI
Message-ID: <CAJqdLroK2W7N59+96feng5_gPCHca81utJw0KsU5d1hpVMKFqQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] selftests/net: SO_PEERPIDFD_THREAD
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
> Add tests for SO_PEERPIDFD_THREAD.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  tools/testing/selftests/net/af_unix/scm_pidfd.c | 97 +++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>
> diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
> index 019c48e1cdcd..bbbd5e7b4fa7 100644
> --- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
> +++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
> @@ -32,6 +32,10 @@
>  #define SO_PASSPIDFD_THREAD 86
>  #endif
>
> +#ifndef SO_PEERPIDFD_THREAD
> +#define SO_PEERPIDFD_THREAD 87
> +#endif
> +
>  #define CHILD_EXIT_CODE_OK 123
>
>  static void child_die()
> @@ -822,4 +826,97 @@ TEST(scm_pidfd_thread_creds)
>         EXPECT_EQ(ids.pid, info.tgid);
>  }
>
> +static void *peer_connect_thread(void *arg)
> +{
> +       struct sock_addr *sa = arg;
> +       struct thread_ids ids = {
> +               .pid = getpid(),
> +               .tid = gettid(),
> +       };
> +       int fd;
> +       char sync;
> +
> +       fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +       if (fd < 0)
> +               return (void *)1;
> +
> +       if (connect(fd, (struct sockaddr *)&sa->listen_addr, sa->addrlen))
> +               return (void *)1;
> +
> +       if (send(fd, &ids, sizeof(ids), 0) != sizeof(ids))
> +               return (void *)1;
> +
> +       /* stay alive until the server has looked at our pidfd */
> +       if (read(fd, &sync, 1) != 1)
> +               return (void *)1;
> +
> +       close(fd);
> +       return NULL;
> +}
> +
> +static int peer_pidfd_info(int fd, int optname, struct pidfd_info *info)
> +{
> +       int pidfd;
> +       socklen_t len = sizeof(pidfd);
> +
> +       if (getsockopt(fd, SOL_SOCKET, optname, &pidfd, &len)) {
> +               log_err("getsockopt(SO_PEERPIDFD*)");
> +               return -1;
> +       }
> +
> +       info->mask = PIDFD_INFO_PID;
> +       if (ioctl(pidfd, PIDFD_GET_INFO, info)) {
> +               log_err("ioctl(PIDFD_GET_INFO)");
> +               close(pidfd);
> +               return -1;
> +       }
> +
> +       close(pidfd);
> +       return 0;
> +}
> +
> +/* SO_PEERPIDFD_THREAD returns a pidfd for the peer's connecting thread. */
> +TEST(so_peerpidfd_thread)
> +{
> +       struct sock_addr sa;
> +       struct thread_ids ids;
> +       struct pidfd_info info;
> +       pthread_t thread;
> +       void *tret;
> +       int server, cfd;
> +
> +       server = socket(AF_UNIX, SOCK_STREAM, 0);
> +       ASSERT_LE(0, server);
> +
> +       fill_sockaddr(&sa, true);
> +       ASSERT_EQ(0, bind(server, (struct sockaddr *)&sa.listen_addr, sa.addrlen));
> +       ASSERT_EQ(0, listen(server, 1));
> +
> +       ASSERT_EQ(0, pthread_create(&thread, NULL, peer_connect_thread, &sa));
> +
> +       cfd = accept(server, NULL, NULL);
> +       ASSERT_LE(0, cfd);
> +
> +       ASSERT_EQ(sizeof(ids), recv(cfd, &ids, sizeof(ids), MSG_WAITALL));
> +       ASSERT_NE(ids.pid, ids.tid);
> +
> +       /* SO_PEERPIDFD refers to the peer's thread-group. */
> +       ASSERT_EQ(0, peer_pidfd_info(cfd, SO_PEERPIDFD, &info));
> +       EXPECT_EQ(ids.pid, info.pid);
> +       EXPECT_EQ(ids.pid, info.tgid);
> +
> +       /* SO_PEERPIDFD_THREAD refers to the connecting thread. */
> +       ASSERT_EQ(0, peer_pidfd_info(cfd, SO_PEERPIDFD_THREAD, &info));
> +       EXPECT_EQ(ids.tid, info.pid);
> +       EXPECT_EQ(ids.pid, info.tgid);
> +
> +       /* release the connecting thread */
> +       ASSERT_EQ(1, write(cfd, "x", 1));
> +       ASSERT_EQ(0, pthread_join(thread, &tret));
> +       ASSERT_EQ(NULL, tret);
> +
> +       close(cfd);
> +       close(server);
> +}
> +
>  TEST_HARNESS_MAIN
>
> --
> 2.53.0
>
