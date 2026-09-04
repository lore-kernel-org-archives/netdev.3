Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D623DA7CC
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538676; cv=pass; b=HMcuFjrJcGY39pDKjrJFWvPm2Fc1wf8ghaOV8rCw3nALspuH+3TlYA2SALI+zb2ujerxRooyplZI2d9OBYJvbHhm+WGu5FPI0BTLT9Bv10nLpnkTHy8UPFdGnjlKoWBS7vG1nIpnozxetT/AGpKCiBAhSmTi1S7Vjrgqm+Ol1hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538676; c=relaxed/simple;
	bh=XDhlCCCy4S753j8wU+gcZX4rG1ci9fwEgIlB7NEoF9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcsTzbQ/BQCCo8AWcaW7QmdwgLcKXBUSxjFlmp4dl7JvmQ5EPA8ugZqJ3qRAcRuwXWjv5AMPTGj9knOKwU+5J381yq6Zft1fuJWFSTJhXdt5xfopvJ3x2NbvihdTCYViJqh7MNuNu6HzBDpbC/akQ947F5+OcKRIaW3qPyTPuWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=N0Q0nkNL; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="N0Q0nkNL"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c25366c9b42so126499966b.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788538673; cv=none;
        d=google.com; s=arc-20260327;
        b=h/Bk4quHkK87t1v0NEZ7HVdMe5JQ1H32yFxFZMX7gDAl+Sd4rnOXg6wSM7MOZ7FCU+
         gOKo0CadDQ+3LZfmRWLpWHANmIf9uctJQ6GtSTSyLx3BAuFWLokQBhmG752Z8Q2icslM
         heQZNf+YPtKdsFCfM4h0pmI/VpGTVPtiTMgJuLlPEpBgUdzQ0DTPgrWe1miQJZwKWidw
         QQL7ocGFY5dEkJM61JjsrIqBDbQsWOQiH7g+Zja5HMY2eIgUfN3tiAOf1jBmis5unPmm
         DWuj4WkR+zI2GHKP1OwEvU+3WnYuh2Z5K27QYF2q/deXtgJ+V6DqtD2F+jzmIljXZHU0
         QBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4hR0nqhvj3B1Hd4PIemXkyI2iIG9pnBdbtv9TVtz3qk=;
        fh=tYsCn+hOQSAnQQ95Qx4BT0N31OggkbHxZfv8P0cJtkQ=;
        b=jAvscGHzS2XLK+en094TFEyXDBRxK2qxgPoso6wb/igg9OABZ+ns8Vtb0pdXjaBiGC
         F9CWUt0wLuH2QTIriD+H1WfhkbRBITvHSFzn36MfFGjnUSsmNGG4zwPvUO+LShwX9NdQ
         07chEudnXK3Fvk9zOrWIcSdSMrchSR7piZ2pST83FH4iEx5S2fymFArquO8PM4H8sSxV
         03X7hlANZh6aa+KJ09vSfCKnZrUI4pZhaa7Kmb9F/6xkmSOInQWlZWqWzm2VAA460Mzd
         JvLyt8PES9sglpvjxdJobSNTrTFPimrU+4MTyMaFMQuaiVpKZHjAEkLWIxPLcOOlgsNN
         vrbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1788538673; x=1789143473; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4hR0nqhvj3B1Hd4PIemXkyI2iIG9pnBdbtv9TVtz3qk=;
        b=N0Q0nkNLmiyVSeeOV7cOZrwboMq08UdLFydts4djIMauhZ/ldnYhhuHq3C3KGNY07v
         eGCEnYbndX3XHcJnOV5jHyXwuT5xCJnloGRwF/+KA6c81jYQOuS/bv6OAWZEqyVE20fP
         Au5jnpYB5h7N2xd1bwW7S5K69SRyCFoyuBGRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538673; x=1789143473;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4hR0nqhvj3B1Hd4PIemXkyI2iIG9pnBdbtv9TVtz3qk=;
        b=gyY/kg+7EVRE61tgj43OT9c/00BUJj+raW7xdZILdNOL4F99kBGtrgKAZbANLtYGO5
         JvNzxZ24QzVoo6CacTykT7wmLoDaznbJdtW0pIf7ZR++MrBs3q6dcLFLFg2+oCHXybIP
         py/Tj1jTqNh2LhbGUtrAZTiaV92RfH4d0Y/DuaDfY/LE7Zz9KWwte1sMpCIo+Ppbhr7m
         bYhXpiyFmhfphqgpP/v3HiXfMlpRfXAEdpA9dP+k+DCnTI9EgplxNCJ0cF7/CNmj6cNu
         IHJ9V/tfax664lJE4uo79ecp7sqVRmK4alwrOLe9GpvLdRRrR8MJQ4w7OWKbWvDepwZY
         uU5A==
X-Forwarded-Encrypted: i=1; AKwUvBw8AaeNhRRcTb/tecqPwgpRaYuhYoARUciLtNYGXoBBoyE5EtBrz8EyAKcHeeQ+OnRkVXy4wZU=@vger.kernel.org
X-Gm-Message-State: AFuF++kWcioXI0pI4L0JBiEx2pxvmKvuA2Iu/98YyrWgr081+DHN8MRK
	a0vxsBRhAh6Bu+/ABbU9zbuwJM/5NXLq7nWoZG3AhxiYB+dRxRJgE+1tFNLsClXCVuATSxo6tX3
	Z1ll8QXGB16CWAJW+QpXyO1dc3VOMMvpaLTLpAjeE7Q==
X-Gm-Gg: AYBFou2T5Ty9CzlDTDHbV2Jrb73r8E6zI34vGgG6u2G/+BSQUFUTZ+YMvwiEjiG+mhm
	hJ5q1gEgNEBxcuk6IDjpw4njfMUGu6G+dXkcrJCaqA9xirg05/PtyfrELRe9SUOU/EVFiV0Uw1o
	VCj3UT/52AO0tiupwf+iHvH3wilw6qACcIaNtChwQi963mByrm6pXJwEK4AUXDDRmo+9o5dJ7jm
	6YakwnObk0D0qQQme8hyjHd4H/BqCCLPdmdOnn3v1AK/gindU6CLxZpWAGdszfKBzOR3CCjfU2O
	YWBCEG0+b666/0uIoPez55B+D7OZ9mZe6RPnzQ72rl0Wzed4f1o7naaWCmKCHcgPQNtO4Vwm331
	L
X-Received: by 2002:a17:906:2091:b0:c26:19de:913b with SMTP id
 a640c23a62f3a-c2619dea026mr128536166b.46.1788538672347; Fri, 04 Sep 2026
 09:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPWDnYo=LUD8oC_wCaFZ=PXwHMpKFW3SzV1+peoYnz5sJMjLQQ@mail.gmail.com>
In-Reply-To: <CAPWDnYo=LUD8oC_wCaFZ=PXwHMpKFW3SzV1+peoYnz5sJMjLQQ@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 4 Sep 2026 18:17:40 +0200
X-Gm-Features: AcwNN1X73QhZw0vysx2qp4wGUjcGa4bRsSl3isSoNkb2VxqUWpuvb1fgTYXqDyg
Message-ID: <CAJqdLrrfx8b71rnmjS+1GvvUOd9EpFZ=+oKB-ttqsttY0dKsUw@mail.gmail.com>
Subject: Re: [BUG] net/scm: scm_pidfd_recv() reports pidfd_prepare() failure
 to userspace as a file descriptor
To: Seoah Myeong <astronaut0703@gmail.com>
Cc: kuniyu@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, willemb@google.com, 
	davem@davemloft.net, kuba@kernel.org, horms@kernel.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Fr., 4. Sept. 2026 um 17:56 Uhr schrieb Seoah Myeong
<astronaut0703@gmail.com>:
>
> Hi,

Hi Seoah,

>
> scm_pidfd_recv() does not check the return value of pidfd_prepare().
> When pidfd_prepare() fails, its negative errno is passed to put_cmsg()
> and delivered to userspace in the SCM_PIDFD control message, in the
> field that is specified to hold a file descriptor.  No flag is set to
> tell the receiver that anything went wrong.

no, this is not oversight. We are very limited on our ways to report an error
when user-space received socket control messages. One of the ways
could be fail recvmsg() completely, but
there might be more than SCM. In some special cases we raise flags
like MSG_CTRUNC.
In case of SCM_PIDFD we decided to return errno as pidfd and userspace
*must* check for this (see for example [1]).

Link: https://github.com/systemd/systemd/blob/0b5c330d156e91c21d68f246f92790bf212cbd98/src/shared/notify-recv.c#L156
[1]

P.S. Is this LLM generated stuff?

Kind regards,
Alex

>
> Affected trees
> ==============
>
>   mainline (421066905cbc)  net/core/scm.c:489, call at :510
>   v7.2-rc5                 net/core/scm.c:465, call at :486
>   v6.12.107 (LTS)          include/net/scm.h:136, call at :157
>
> The code is identical in all three; only the location differs, because
> 38b95d588f8f moved the function out of the header after v6.12.
>
> Analysis
> ========
>
> The current code in mainline (421066905cbc), net/core/scm.c:
>
>   489  static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
>   490  {
>   491          struct file *pidfd_file = NULL;
>   492          int len, pidfd;
>   493
>   494          /* put_cmsg() doesn't return an error if CMSG is truncated,
>   495           * that's why we need to opencode these checks here.
>   496           */
>   497          if (msg->msg_flags & MSG_CMSG_COMPAT)
>   498                  len = sizeof(struct compat_cmsghdr) + sizeof(int);
>   499          else
>   500                  len = sizeof(struct cmsghdr) + sizeof(int);
>   501
>   502          if (msg->msg_controllen < len) {
>   503                  msg->msg_flags |= MSG_CTRUNC;
>   504                  return;
>   505          }
>   506
>   507          if (!scm->pid)
>   508                  return;
>   509
>   510          pidfd = pidfd_prepare(scm->pid, PIDFD_STALE, &pidfd_file);
>   511
>   512          if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
>   513                  if (pidfd_file) {
>   514                          put_unused_fd(pidfd);
>   515                          fput(pidfd_file);
>   516                  }
>   517
>   518                  return;
>   519          }
>   520
>   521          if (pidfd_file)
>   522                  fd_install(pidfd, pidfd_file);
>   523  }
>
> pidfd_prepare() returns a file descriptor on success or a negative
> errno on failure.  At line 510 the return value is stored in pidfd, and
> at line 512 it is copied into the cmsg without being checked.
>
> On the failure path pidfd_file remains NULL, so the cleanup at 513-516
> and the install at 521-522 are both skipped.  Nothing is leaked and no
> descriptor is installed; the only consequence is the value that reaches
> userspace.
>
> This looks like an oversight rather than intended behaviour:
>
>   - The comment at 494-496 shows the function deliberately opencodes
>     error checks that put_cmsg() cannot report, so error reporting in
>     this function was considered.
>
>   - The function has already been fixed twice for error-path problems:
>     603fc57ab70c ("af_unix: Skip SCM_PIDFD if scm->pid is NULL.") and
>     718e6b51298e ("af_unix: Fix msg_controllen test in scm_pidfd_recv()
>     for MSG_CMSG_COMPAT.").
>
>   - c679d17d3f2d ("af_unix: enable handing out pidfds for reaped tasks
>     in SCM_PIDFD") modified this very call, changing the flags argument
>     from 0 to PIDFD_STALE, without adding a check.
>
> Reproduction
> ============
>
> The attached program creates an AF_UNIX SOCK_STREAM socket pair with
> SO_PASSPIDFD enabled on the receiver, lowers RLIMIT_NOFILE so that
> pidfd_prepare() fails with -EMFILE, and then calls recvmsg().
>
>   $ ./poc
>   pidfd_val = -24        (-EMFILE)
>   close(-24)  -> EBADF
>   fstat(-24)  -> EBADF
>   msg_flags: MSG_CTRUNC not set
>
> 3000 of 3000 iterations reproduce this as an unprivileged user
> (uid 65534, CapEff = CapPrm = 0).  A root control run reproduces
> 500 of 500 identically, so this does not depend on privilege.
>
> Testing was done on v6.12.107, where the code is in include/net/scm.h.
> I have not run the reproducer on mainline, but the code path is
> character-for-character the same apart from the PIDFD_STALE flag.
>
> Observed vs expected
> ====================
>
> Observed: the SCM_PIDFD cmsg carries a negative errno in the int field
> that is specified to carry a file descriptor, with no MSG_CTRUNC or
> other indication of failure.
>
> Expected: either the cmsg is not emitted, or the failure is signalled
> in a way the receiver can detect.
>
> Impact
> ======
>
> This is a correctness bug, not a security issue.  To be explicit about
> what I checked and did not find:
>
>   - No file descriptor or struct file leak.  pidfd_file stays NULL on
>     the failure path, and /proc/sys/fs/file-nr went from 384 to 352
>     across the run, i.e. it decreased.
>
>   - No memory corruption.  The run was performed with KASAN and lockdep
>     enabled, and neither reported anything.  lockdep was verified to be
>     active throughout: its lock-class and dependency-chain counts
>     increased during the run and the validator was never turned off.
>
>   - No privilege boundary is crossed.
>
> The practical effect is that a receiver which follows the SCM_PIDFD
> contract will store or use a value that is not a descriptor.  In the
> common case this surfaces later as an EBADF from an unrelated call
> site, which is hard to attribute back to the recvmsg() that produced
> it.
>
> Fix direction
> =============
>
> I have not sent a patch because the right behaviour looks like a
> maintainer decision.  Since 38b95d588f8f the function is a static void
> in net/core/scm.c with a single caller in the same file, so changing
> its signature to propagate an error is much more contained than it
> would have been while it was a header inline.  But choosing between
> suppressing the cmsg, setting MSG_CTRUNC, and reporting the error to
> the caller has ABI implications for existing receivers, and that is
> not my call.
>
> I am happy to test any patch, and to send one myself if you tell me
> which behaviour you prefer.
>
> Environment
> ===========
>
>   Kernel:   v6.12.107, x86_64, QEMU
>   Config:   KASAN=y, PROVE_LOCKING=y, DEBUG_LIST=y
>   Repro:    3000/3000 unprivileged, 500/500 as root
>
> Reproducer
> ==========
>
> [PASTE poc.c INLINE HERE]
>
> Thanks,
> Seoah Myeong
