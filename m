Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DF35E930
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022048; cv=pass; b=QqV0IdKgkDnpz3Zwcc+HaAaMKcOND9R5wUWNnmvIdXK6lJ4WeKH4VH2L1OxIAlLEQLMnEab9DsAqL1hEflE2rSsxTvTMIFzuObKp5c9yx9fadQ9QyxBwHzj2dHPxyIyyQdch4/67WWr6iP9bdvoGb3XVTxw4Dt5M6fo45UPBifI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022048; c=relaxed/simple;
	bh=v2Ib2MTNHBmW9YmoeK8moKJ46G5ulvBSMcUnWwSOmTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB25HjvMXWMkcdbCCsbX+6DmvXQkjqDfH8rJzlD1+1obXh1r7LJ5twc9fH2SA0WhfPrZSmK7Rp6jxftgzBYs+XnCunh43WPwKnwSKJJkEhkfwpwegU+Re0PgEhb7MlItyWX6wBsREQVAKFCQOcQmdX7zR4KjMei3UDYEX0QWcME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kneA7THk; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kneA7THk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so52096995ad.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 23:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789022038; cv=none;
        d=google.com; s=arc-20260327;
        b=KktT5jH3f/bvNHYQJasf8fbIGBvB9OYDZEvHSQdzWUMatxlfdzD7t5N116JGJVQqHg
         S5KYYviHnNc0O9shPx1kHwRHZCcHHB7XEt0D05GP1sKpwGWRKI3MmZKWeIju27fUwgXM
         lvDG5ho7E4Hnur2P8WzU2HU4XzTSBhsfTRPZesapoxRFw0KcQaU8HngUyop4sse1NcEG
         CjAaaIwQ53bVmyf4RSjGxJPrOsNWsMQJYkGFWbpaokBGmcghUZTzlKTSdKwFnJLuTgoH
         j/cBMejWdi5bQY/yjlpGjkcATAZAo3ayOkQVHTcPzQ7QBxR7QkckM6xsi/NECdwJfA0l
         bRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4xny++sZ96Atr1Ra69lnJNWOCs0ZrC8LE8i2a35qYI=;
        fh=5RdDxfj3nuGXvt6qIYMIwlL6LTehgkBy1eHp53ms6ZA=;
        b=NP3X2OnITZEk3uj4Sww7zYMvzDNJoVhppYdcpCNYc3b3B3y+WYZtkGuJNDwfWT41Em
         RSMS8MaBDwvICc4WwgKWwyU3qwIKdVAaXXvJ5dSBQw7vHu2WzpxsAmHdODro91s6AEBT
         bn7xwsG13Ws7iYsbEOmK3QzQXFdXHdU1ZaC946/KhvHaUsX9eBVoyqnKmH9I3tqScmOy
         jtHVTMYOtHSoPOM+WNNMHxZYRSNc/x3TBYvvBU1fFTedOdi7g9Jn1C5hUgIcrBF6xjcC
         1+2oeJnSlQoPnt0ig4uamOpaqkgUBamA7l0t1NssOI6VKIQlFKi/jH2kgMWOZiGJn1Oj
         lHVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789022038; x=1789626838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h4xny++sZ96Atr1Ra69lnJNWOCs0ZrC8LE8i2a35qYI=;
        b=kneA7THkZnDbOSChClrANzdIg4PQ9C5/0T9AH6xp3goI60FrwmSuvQrQraRnMpdrGY
         KQZWrVOCRDnRQAT0cnIDgM8p6pnJ6qx7jgiv1J9j4iJ5BTCqJe0uMQ/+wgPWoAOGc6cU
         BzyqPqyzDxQfBEUrxWTlaQ20ZTb2lGH/YrTuLWrLB4hXid3NKD7fKDrbkPe0bbzTf6vX
         uWz7BXBwI6maZUfzuPJMNQQOkePZX5oqDHOy9EtLx22lqzscJGxkWT01Q4sCnGXfceyf
         ZCOsbolJ5M0GCGGzuSoRudwTeLe9Bu85HLM8bsP80car+Mz9L4WN/AfwcqQyJ5X3TWmE
         zrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022038; x=1789626838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4xny++sZ96Atr1Ra69lnJNWOCs0ZrC8LE8i2a35qYI=;
        b=DkCVW1/CJhJCQZANQprxMJb2GW/Qy9QUtx3bqKJz2pKFYJNBDn0Z20akKZLL6ftd/Z
         9F7e23KbcLhoV3rOGq4ZgX7hGNM/pBfxG4M/WHtTOzaGH+wXQpZh9fOYH4t5FzkFzr/D
         5zwAcAA8GS/F22QKUI1IFbw2DMY8kpDhaLLpSowaMXtftrxJIgxZJ1lK0w4uHd8peIiS
         BZID9FQktmP/x9iIXdJm8zhqWsBbQr0pAMsCZ3vekpozeGIPhfnHT1jhra+c9eaLA3e2
         dzMoTsKCGJS7O/X8ZOfrXH0FLN6ZgQjyMapCqrMDkrXUMmydbLmXfWXxZRO6jU23yEKz
         0RMg==
X-Forwarded-Encrypted: i=1; AKwUvByDTphgI0sNCLFThRhBv4qedm4AbvMDxVLt9SG3eM4jOy60YeWUHmRIYFfrvJUgtW1tjdZDeKM=@vger.kernel.org
X-Gm-Message-State: AFuF++mDjnJ1VsdvIkqb1EoYB9j2chLXNo4YbwuEg1j8UieKOIHUiDCx
	ctnogyJANexO7KNwHx3Cyx/KIhd1vwqDOWo+LX6ZzWNv1VEC4rnRqvwqWDQGEtVEUFyBi+91hDv
	Gv2eGKGWkV6VqQctpYkNRuyPc6XuxeIkZTM+Z3KwZ
X-Gm-Gg: AYBFou2F0enwwTW721tanBRt8Ve6a0ZNyXltCRDZDQkNFe8dO21RC9AmEjDcwg4ZMlw
	4lj0DwdYHi4y+v4PY+NQlxEigAgvxpG9/MtDYFJE4RIjiTEKmnEZaQly+jYSY9jApXeutcEVR3R
	FkSe88i+PsTqNC5APYuVzaiRNsqW2ocwIWWErzZ6of8vUy6C50ox6YFzgZsFzEKsgcDAlVOtOQ9
	Y2h9maClJdwh5LJTQfIZvDL5wQ7QhFLsWSmQjUrGNLeLh+T1aPOTEwHS1zhRVJ+zbYKDNc+7juJ
	A6lUa2/6LhkhSRW/qfrQ7ZWRfxQQzvekvAtA0/Vfa9npEq5jAyMODyFq1dxAL2wUwYCOca4n/+V
	A+BRcvC/lYpTpxD5mEsgJSIAW5i8+E0w9AUfeKfY/gS5BL1jogG9w/uc4JxfAYj0Hj+lWdCh9+7
	g/dwHL6yb55Y2ebykJAR/z1f8ul6/pssXhgbk=
X-Received: by 2002:a17:90b:50cc:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-39b26202ebamr61816070a91.14.1789022037330; Wed, 09 Sep 2026
 23:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Sep 2026 23:33:45 -0700
X-Gm-Features: AcwNN1XxIc8SXTtu_WcbAxVErbfrYnhss5VT5HaYDUiKJKYuAUZY5pPq8E7OTT4
Message-ID: <CAAVpQUAx2K1Nhj64oEYMfQOzsp35uPhRmRrS4hnp7nd=jvj2kA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] net: support thread-specific pidfds for send and connect
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:43=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
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

systemd-coredump currently uses SO_PEERPIDFD, so
SO_PEERPIDFD_THREAD makes sense to me, but is there
real need/use-case to fetch each thread's pidfd per sendmsg()
via cmsg ?


>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Changes in v2:
> - Fix a few documentation issues.
> - Link to v1: https://patch.msgid.link/20260831-work-unix-passpidfd-v1-0-=
70cbfda0c7ba@kernel.org
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
>  tools/testing/selftests/net/af_unix/scm_pidfd.c    | 366 +++++++++++++++=
++++++
>  28 files changed, 907 insertions(+), 110 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260825-work-unix-passpidfd-086a1ec09e8a
>
