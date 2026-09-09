Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED07345CA8
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952226; cv=pass; b=AEYqRaBCaotEaY04BmHDRcrjXBnDFNkPpR9YAe7ZcMXGYPPycthP2jQwxojSFofM+r2PvAZ2ZNPxMaLEk/R5FFAcANGErwz28ifXVXoqw78WPBgh1N7BzhG9ZKJhpRRgAvNNfneYrpxHtDE8t53W9Jut+OxBLZCggDbUT1DU3vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952226; c=relaxed/simple;
	bh=YkZ9FXYxom6GTJ696R1xgKPjABJ5NoWT2CU+7PuBHFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFpubITgRJCix6wd4R/5Al95IEkplS8a5LBmM+YXjWhYb22NdJ1pD9SwrEeOYJOINFQi43SlFiXv41fkznSjUao3mR4AdimSvkPxow2DyLsvoawhjq528/KSBbnMJdzCPTepFayrp85YnY6gwEpyYCsc5Nt02LagYi5OPcYxVQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=dX0q+oK6; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="dX0q+oK6"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663bfso6620066b.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 04:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788952222; cv=none;
        d=google.com; s=arc-20260327;
        b=U3pprw6Ei5G7KXxs9CxOmyb6IICtOB4hHNNpn7BRG2UCwdUAckw+tvaTTd7udJQY76
         VrZG0iiqvt34dKSqo4loglyXMd+253gXxQOgVM8BibaFTdM1iHIB8TpZ9YMicLmiHE0W
         mVNhHkKG9WV0N6DCFf8f9h4kPvmiSXkTLC4c+7fOho/BMKxlr6Hf4hZwbgvo7P+gYOy2
         2NJhN0U6iFwpZVwZrepk1b2QcMg6pTmnA7jG5uHRz2WBbHUCdTb2wXbeiaqdK1gtGy9P
         H5YFHB5p0eQTA42fRivO/Jn3Roa/t2JTDhKUSCFUF7ThvbBbIVN7qIya4uGkkTSGO8OK
         S5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mgt8XRgHU0466zZJnQp3K3kwl0ZmrdZ791mHZpm+8k4=;
        fh=/iOcqzcy0x9pRJ0jgza1EX91c/pyc2Vr5lJlIA4CgZ4=;
        b=myPxqyiENPS5hUh4s6E9w9ClLc+XaGLdHMBZd3TNzZB+lXarWUKYjJGkxAgXDaVlcA
         739koYJiLECSNiy1K1RN3F3pJBmrKKHtRXsgD8ZdIrpQKIW5VMYDVPAZuTGnXksnzzR8
         l0wyce8EuTSv+NuLDDJ8dpYfq5I/jmAP6xmH/HgI5NPo4OMAJWIrpiDy8VXyViKg5Sxe
         GvA++bm2tfGLmnZBtiHLPGZTu7q+AbxWoNXrD/LY+w/7NcfxyH2p0axAU2e7XH1NrHW9
         RPhLcQtT4O7Ll8xmnY8y2Ze112ZASY1Hu7zCFxAkSRjemghmEc21oCZSpKLIOG8JstdQ
         nQNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788952222; x=1789557022; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mgt8XRgHU0466zZJnQp3K3kwl0ZmrdZ791mHZpm+8k4=;
        b=dX0q+oK6psQKBVWpzPmJNAB/SUPsmrJYjWjuLSDb+yl4yOhVR75twv//YochFw3j4G
         f1fgEdTt7HbsfDGgHZJWplKWqJcs8PvMGOKdA9sM0+Sksnc9ZjRmbk1FTI7+WN+FJyer
         kZJ0GKY23pR7SOJ5QB3rJDr/KexOrL5QPQJp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788952222; x=1789557022;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mgt8XRgHU0466zZJnQp3K3kwl0ZmrdZ791mHZpm+8k4=;
        b=CwX6TO4R2bejeI6aKoN1OLCdqkpx9MY6kjpFsZDdlmQz/xWT/LdL1Dus8UhQWPHnUA
         Yuq/gI0WaQor31aBhORLPxC3i4tYIPphDCzfKcD8U/2d0UW2+NFuVz1n0MhCPgKZbmJb
         mZuMS6RZKCtWymnpphsDARTVA+jWKMzW9XvWAcqMiy/++MQMx6MQF64xDU5QrwmjV3T3
         q1vh57zR1tM4wkQ4NpF8yb2ctrjhY3JNH+4TGxOa8mJ+GHGGar+CkBtxUJ6UW9XCStBo
         Xz77b7rh3b6lR2fgcDMmnMwdKgS2TaaGKxAFtaXnmJPtHvK+QZmQIYVmjPY/fHVBwosX
         rBQA==
X-Forwarded-Encrypted: i=1; AKwUvBzRYzV668hxbwh7yEip5VAfcNLoJdxF6gooqvv7O3g1RVk3NgLyp+yY611goA1TxYw3fzsMFpc=@vger.kernel.org
X-Gm-Message-State: AFuF++mHMTXTjz2AB+YeUQiowjHzIqTsiZI36NVz9C92oB5y6pd/dPX/
	AEw3y5CqAcYceCC9NTquPDoUrADM1Is0FYXTCk46J8k68tljYddWxnlFEaNf2nSIh8MU9U0A2ki
	nGmKx4yUSu0h/oARM1g/2f7If7NtteNMojGo0CYJW0A==
X-Gm-Gg: AYBFou2kvWqZ7WEof9mDHFNv3jkGno86u5BIPK7LxBuj6X7+vlu85txPN0CcNsy8SJ3
	BlU1qkNe662QiQ5FyqG8RTgRCE8nYDByhIBToVyzH4hNSeSRsFOJj1fd/TrW1j45Lk/6dWy/52X
	x70pTaQTlacoSnuiuYW0jdvHKi3TafXyPxECbRGLuB4U6JVkgrTjdI45U0xkWMIkckHdg7QW8YN
	zRwSEaGcoy2Aqdc1UKG2+EYVXbGenfSiVJQbusWkrV+4GV2vtPvqMallO8kJEd1vWkp63Sy+o56
	GDQUKzdC0U7mDzJpfhIOHCgXSNW8qiWyTLgcT016PrGTp3+VPyOg3EL99Cvq6SiG/qUyfulNciU
	nMbFVW5OfS7fhlKq46scTEQ==
X-Received: by 2002:a17:907:c09:b0:c25:c7a9:7b8a with SMTP id
 a640c23a62f3a-c2941ae9193mr12751566b.12.1788952221639; Wed, 09 Sep 2026
 04:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 9 Sep 2026 13:10:10 +0200
X-Gm-Features: AcwNN1XTgvzqLxcVf_sNNwgtEWfE868-Kflp519NXR5vjxPBUXSPcRZwXEOLDjc
Message-ID: <CAJqdLroLH7x1Zrgaa2U=H5v9pFfdzJS4CCcAmSvqShS8Wh+0rw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] net: support thread-specific pidfds for send and connect
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mi., 9. Sept. 2026 um 12:43 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> SO_PASSPIDFD/SCM_PIDFD and SO_PEERPIDFD allow to retrieve a pidfd for
> the thread-group leader. The coredump server using the coredump socket
> cannot get a handle on the task that took the signal and is writing the
> coredump easily. Workloads interested in per-thread authentification
> have similar problems.
>
> Add SO_PASSPIDFD_THREAD and SO_PEERPIDFD_THREAD. We record the sending
> and the connecting thread in addition to the thread-group leader.
>
> SO_PASSPIDFD_THREAD functions like SO_PASSPIDFD but instead of an
> SCM_PIDFD message for the thread-group leader, SCM_PIDFD sends a pidfd
> for the specific thread. SO_PASSPIDFD_THREAD is mutually exclusive with
> SO_PASSPIDFD. The last one set takes precedence and disables the other
> one. Both SO_PASSCRED and SO_PASSPIDFD receivers see one writer per
> process as before.
>
> SO_PEERPIDFD_THREAD allows to retrieve a pidfd for the specific thread
> that called connect(), listen(), or socketpair().
>
> pidfs_coredump() now also stamps the dumping thread's struct pid so a
> pidfd for that thread reports the coredump like the pidfd of the
> thread-group leader does.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
> Changes in v2:
> - Fix a few documentation issues.
> - Link to v1: https://patch.msgid.link/20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org
>
> ---
> Christian Brauner (10):
>       pid: add helpers to operate on a struct pid array
>       af_unix: record the pid of the sending thread
>       net: add SO_PASSPIDFD_THREAD to get a thread-specific SCM_PIDFD
>       selftests/net: SO_PASSPIDFD_THREAD
>       net: turn sk_peer_pid into an array indexed by pid type
>       af_unix: record the pid of the connecting thread
>       net: add SO_PEERPIDFD_THREAD to get a thread-specific pidfd
>       selftests/net: SO_PEERPIDFD_THREAD
>       pidfs: record the coredump on the dumping thread's pid too
>       selftests/coredump: check the dumping thread's pidfd
>
>  arch/alpha/include/uapi/asm/socket.h               |   4 +
>  arch/mips/include/uapi/asm/socket.h                |   4 +
>  arch/parisc/include/uapi/asm/socket.h              |   4 +
>  arch/sparc/include/uapi/asm/socket.h               |   4 +
>  fs/coredump.c                                      |  22 +-
>  fs/pidfs.c                                         |  27 +-
>  include/linux/coredump.h                           |   4 +-
>  include/linux/pid.h                                |  53 +++
>  include/linux/pid_types.h                          |   8 +
>  include/linux/pidfs.h                              |   5 +
>  include/linux/sched/signal.h                       |  18 +
>  include/net/scm.h                                  |   7 +-
>  include/net/sock.h                                 |  14 +-
>  include/trace/events/landlock.h                    |   2 +-
>  include/uapi/asm-generic/socket.h                  |   4 +
>  net/bluetooth/af_bluetooth.c                       |   6 +-
>  net/bluetooth/hci_sock.c                           |   8 +-
>  net/bluetooth/l2cap_sock.c                         |   2 +-
>  net/core/scm.c                                     |  36 +-
>  net/core/sock.c                                    | 120 ++++---
>  net/unix/af_unix.c                                 |  67 ++--
>  net/unix/af_unix.h                                 |   3 +-
>  tools/lib/python/kdoc/xforms_lists.py              |   1 +
>  .../selftests/coredump/coredump_socket_test.c      | 175 ++++++++++
>  tools/testing/selftests/coredump/coredump_test.h   |   2 +
>  .../selftests/coredump/coredump_test_helpers.c     |  49 +++
>  tools/testing/selftests/net/af_unix/Makefile       |   2 +
>  tools/testing/selftests/net/af_unix/scm_pidfd.c    | 366 +++++++++++++++++++++
>  28 files changed, 907 insertions(+), 110 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260825-work-unix-passpidfd-086a1ec09e8a
>
