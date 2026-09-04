Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44ED4F0541
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537417; cv=pass; b=mi6A7Ym8QgjQiur0eSF9s9hjBmIizTXAVUfKlvJ+yJP/Z3b4+/xE4oezXVPkGXGNF5QcGtlLMJbGB/e1v86qB5/hCaUDDBC2fNZhk7HmIiCcBWC9hoHWuRY5MyXU5M6OfNgQWNQWyJbTCIhnL4aRhVnB825dcYRChkrFpebHkz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537417; c=relaxed/simple;
	bh=ZedpNpdg7Ljc3wUSJIdxjLdYR07WVf7nzAKEFvx1nlk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pXImntOEw8Elsj1owIZ+KD2BAqi28gHpFMtSxpVuLf9mQxP11Yitk/igNB+zMqS1DL+hYiNE9ed7Z613VKILhcDBWBzEr2yWrexvSPdJYiPsHr8yRmtiUdJlwXsyWeOfZBei2hKIcsFc8rrc0iAX4Q59XYp4KUwYTYCCQzUZluA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcAZh8KN; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcAZh8KN"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2544ff970dso157486566b.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 08:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788537414; cv=none;
        d=google.com; s=arc-20260327;
        b=rEcptYSY03sdya3ALJkZvSo7q1DHtBYbjHGCQFvbDYb46VXO08LqpoPyt6Pf4xUHT/
         8vDIdXLwIux6fmMCG356a+BPWmKmmZ4t95aEF8lGOgtIRzzepqhDoqXK1n4cz4Jwigr6
         wfwk5Hi7xRRBu48WezAiZraeIf7w7W3u68Vi7G1Zck85A6Y7oQnMqyha74V1VocViRdj
         50z1NbWtUD3taV9VrpwegqPS6RZW2x7UhYT2qQTzbYCwDiR2W0Hn+hH844GeplMQMFJK
         onyAK7TrvrMK++bMdo/XgUmyGLWBN5wsOrlvPTgIoyWUXwP+tLZE/EmVn83u7SkWwIk+
         n5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=otS+J+bVwv/Qn5hM+1H0O+k7h52oXcfagomMh4dhaxQ=;
        fh=GIvxSPyxG5VFFAFTUXNlKUtD/XlbndUPgzRVVgE0uLo=;
        b=fvOzBCGs0HHTBhzHZHIKie6R4T5auIAo0Mn0hWQ5XIFiJLIPTnpAb8IfhRSWNB9y+W
         ELbb9bBsdUCbtaE31Qm6iKva72WndU/BSCyL/LXay0UWCoged7VZeDtiXdsodixgNlCV
         amrmIsWGrUl+PZVvkJ/XeNXfZqq3vFhywizjRH9QhpXcA54eA3ymaUlRq1dzjykahcy6
         uWIPY0yzfCUJ9wjBm241M4ois6HR4zbNoVJZqw+ct/84KhiHQJQ5EH35jD1/eg0EjevK
         kxieCo5CGQmhBxpWpJhuIj5e9OfhzYVGf4JShRbpfOqM2cLvRFMT+5BjFoPBuhi04lDD
         vFUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788537414; x=1789142214; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=otS+J+bVwv/Qn5hM+1H0O+k7h52oXcfagomMh4dhaxQ=;
        b=IcAZh8KNQeV6v2YZRO+HlBwomH2KtzHTOengyKUKkSOf1UGOaodIB8PGHw2HJ8QnTd
         CAWbXS0DC9+AckbGfA8QGS7XNydpMsuougwAhdWY1pA8/Xv1iKuF22WM7h4n2l5cT9NA
         8j4pTo0VNmnhO8iZDExhpwhGtLRvhse8Vkf9HLnwM8aTd6YxhT6+n+RtmhYR2W7wdyJq
         BmyDkjZRTsrwzSLubpYbBrXRBFZFUqdL3NdqzWZyiniO0NTupSCySm1XYqdFb2kBxVWP
         SKKIKYn2+imD1QaOPAvLMEska0+ZUZ/oTgGIfE3lBQ4g6DNmdJ7ip+dgS4hLlHkmYjRZ
         NKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537414; x=1789142214;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=otS+J+bVwv/Qn5hM+1H0O+k7h52oXcfagomMh4dhaxQ=;
        b=bBaqV69QvzYsIMPDwkT/EyM9Fub5JfqornN0doyiF07Mh6tLW+hRxWL0up9so8Lvou
         IWSrvVey2azs8EJHsWrfitWHDjFU42WFVnJEfylgqfBWijkkVTW4pDamGcrvILLuQfMH
         yqfBZ+T1Qcw7P3ZADoElZg6uWaN5NywIw5LkSIkhlsgu2am0xiCpdfotxGtEiKgus7nr
         2WBnv5j5RJ7nfkSAyyeSHC/76qyeOchtGvlhx0YaxO9jiSiw2arLr/Prc5rWNQSCqte9
         dqZkw/Z1gNXatUcqefoTiSoc/0lsOuQXTuIlXGc/dvDWQEIi9UMfml2onloubCwQw/01
         HOzg==
X-Forwarded-Encrypted: i=1; AKwUvBzLYGqYaUy8UqoSPUms0G8aKI3upPyVyva7zRdCQlPiiHwKaeM4GH+2SwKEEpha7Ied5UWiSpI=@vger.kernel.org
X-Gm-Message-State: AFuF++mg+DOHqDmpVj1hR3ixneM3VLKd19Rkulf478fCArBW/i3D7XqU
	hUl8RuWTSUs/BbCx+aac/YW/aEgNyDrPQ+trzdplJeSiHFlCi2v/OSehljkmZMUBTq4YkbcGD9n
	aiypcw18MiQejz7fPDAu4RM5JROcOWPQ=
X-Gm-Gg: AYBFou2EUSLAZ/vACjyl0So0V9wrPEyV4rYr1YSYit70HSp6/BHdyEgjbmPbEOlJTZY
	76CQCpSaKUSWQ8l9dOBdmYt3ZG7hoDXPRgwr0IDRsdkqgXZuS0W7t8uTaCpfCuBIdsRIkpddFAZ
	C0n8TU/vGncHJ5HHZYpHZ++X1AlpDcJuhloAtfTcPRL2yjF8MAryOFI2Z0Zvb6F6/LVmLmphakY
	TmQuJdV7Eb7uy2ROiPNE3VM7zVSpzuhDeNCCuCpnv+1CGB0F9jYPqrG1QCME5FBZ3Qo4m3b/+1I
	RHJPugi/5VgOnKK1lXeVP+kjzppWNZzZ1mi1b0GNY/zusHO8vriJBGR9eQwz/krUKK4mTktWiAF
	3JQ==
X-Received: by 2002:a17:907:948f:b0:c26:1649:47ac with SMTP id
 a640c23a62f3a-c2616495609mr192663366b.34.1788537413448; Fri, 04 Sep 2026
 08:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Seoah Myeong <astronaut0703@gmail.com>
Date: Sat, 5 Sep 2026 00:56:39 +0900
X-Gm-Features: AcwNN1UK5NEJ2Bk7eXRI025K1HeH0ArV26fhN0qT1HlgaHgmJIXCpvTGpe9309w
Message-ID: <CAPWDnYo=LUD8oC_wCaFZ=PXwHMpKFW3SzV1+peoYnz5sJMjLQQ@mail.gmail.com>
Subject: [BUG] net/scm: scm_pidfd_recv() reports pidfd_prepare() failure to
 userspace as a file descriptor
To: kuniyu@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, willemb@google.com, 
	davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	alexander@mihalicyn.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

scm_pidfd_recv() does not check the return value of pidfd_prepare().
When pidfd_prepare() fails, its negative errno is passed to put_cmsg()
and delivered to userspace in the SCM_PIDFD control message, in the
field that is specified to hold a file descriptor.  No flag is set to
tell the receiver that anything went wrong.

Affected trees
==============

  mainline (421066905cbc)  net/core/scm.c:489, call at :510
  v7.2-rc5                 net/core/scm.c:465, call at :486
  v6.12.107 (LTS)          include/net/scm.h:136, call at :157

The code is identical in all three; only the location differs, because
38b95d588f8f moved the function out of the header after v6.12.

Analysis
========

The current code in mainline (421066905cbc), net/core/scm.c:

  489  static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
  490  {
  491          struct file *pidfd_file = NULL;
  492          int len, pidfd;
  493
  494          /* put_cmsg() doesn't return an error if CMSG is truncated,
  495           * that's why we need to opencode these checks here.
  496           */
  497          if (msg->msg_flags & MSG_CMSG_COMPAT)
  498                  len = sizeof(struct compat_cmsghdr) + sizeof(int);
  499          else
  500                  len = sizeof(struct cmsghdr) + sizeof(int);
  501
  502          if (msg->msg_controllen < len) {
  503                  msg->msg_flags |= MSG_CTRUNC;
  504                  return;
  505          }
  506
  507          if (!scm->pid)
  508                  return;
  509
  510          pidfd = pidfd_prepare(scm->pid, PIDFD_STALE, &pidfd_file);
  511
  512          if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
  513                  if (pidfd_file) {
  514                          put_unused_fd(pidfd);
  515                          fput(pidfd_file);
  516                  }
  517
  518                  return;
  519          }
  520
  521          if (pidfd_file)
  522                  fd_install(pidfd, pidfd_file);
  523  }

pidfd_prepare() returns a file descriptor on success or a negative
errno on failure.  At line 510 the return value is stored in pidfd, and
at line 512 it is copied into the cmsg without being checked.

On the failure path pidfd_file remains NULL, so the cleanup at 513-516
and the install at 521-522 are both skipped.  Nothing is leaked and no
descriptor is installed; the only consequence is the value that reaches
userspace.

This looks like an oversight rather than intended behaviour:

  - The comment at 494-496 shows the function deliberately opencodes
    error checks that put_cmsg() cannot report, so error reporting in
    this function was considered.

  - The function has already been fixed twice for error-path problems:
    603fc57ab70c ("af_unix: Skip SCM_PIDFD if scm->pid is NULL.") and
    718e6b51298e ("af_unix: Fix msg_controllen test in scm_pidfd_recv()
    for MSG_CMSG_COMPAT.").

  - c679d17d3f2d ("af_unix: enable handing out pidfds for reaped tasks
    in SCM_PIDFD") modified this very call, changing the flags argument
    from 0 to PIDFD_STALE, without adding a check.

Reproduction
============

The attached program creates an AF_UNIX SOCK_STREAM socket pair with
SO_PASSPIDFD enabled on the receiver, lowers RLIMIT_NOFILE so that
pidfd_prepare() fails with -EMFILE, and then calls recvmsg().

  $ ./poc
  pidfd_val = -24        (-EMFILE)
  close(-24)  -> EBADF
  fstat(-24)  -> EBADF
  msg_flags: MSG_CTRUNC not set

3000 of 3000 iterations reproduce this as an unprivileged user
(uid 65534, CapEff = CapPrm = 0).  A root control run reproduces
500 of 500 identically, so this does not depend on privilege.

Testing was done on v6.12.107, where the code is in include/net/scm.h.
I have not run the reproducer on mainline, but the code path is
character-for-character the same apart from the PIDFD_STALE flag.

Observed vs expected
====================

Observed: the SCM_PIDFD cmsg carries a negative errno in the int field
that is specified to carry a file descriptor, with no MSG_CTRUNC or
other indication of failure.

Expected: either the cmsg is not emitted, or the failure is signalled
in a way the receiver can detect.

Impact
======

This is a correctness bug, not a security issue.  To be explicit about
what I checked and did not find:

  - No file descriptor or struct file leak.  pidfd_file stays NULL on
    the failure path, and /proc/sys/fs/file-nr went from 384 to 352
    across the run, i.e. it decreased.

  - No memory corruption.  The run was performed with KASAN and lockdep
    enabled, and neither reported anything.  lockdep was verified to be
    active throughout: its lock-class and dependency-chain counts
    increased during the run and the validator was never turned off.

  - No privilege boundary is crossed.

The practical effect is that a receiver which follows the SCM_PIDFD
contract will store or use a value that is not a descriptor.  In the
common case this surfaces later as an EBADF from an unrelated call
site, which is hard to attribute back to the recvmsg() that produced
it.

Fix direction
=============

I have not sent a patch because the right behaviour looks like a
maintainer decision.  Since 38b95d588f8f the function is a static void
in net/core/scm.c with a single caller in the same file, so changing
its signature to propagate an error is much more contained than it
would have been while it was a header inline.  But choosing between
suppressing the cmsg, setting MSG_CTRUNC, and reporting the error to
the caller has ABI implications for existing receivers, and that is
not my call.

I am happy to test any patch, and to send one myself if you tell me
which behaviour you prefer.

Environment
===========

  Kernel:   v6.12.107, x86_64, QEMU
  Config:   KASAN=y, PROVE_LOCKING=y, DEBUG_LIST=y
  Repro:    3000/3000 unprivileged, 500/500 as root

Reproducer
==========

[PASTE poc.c INLINE HERE]

Thanks,
Seoah Myeong
