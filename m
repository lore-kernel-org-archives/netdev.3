Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546923A6B67
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777742; cv=pass; b=eCdQ2/jDDbSIr065QncF0ern482SWkIrFxHIbTDAyxDyr4yYU4R+dBQX77AlcC3fiPsQV5QNR1ECgm5PX5oAuvK6eGmpR9WdXkQU/iROqLlYkPwmb/SsJSXPi6IYjg2A5bdP+P0Jrbije7dkwz4MWVdAM1sOOUR3uJ3EIzTZ/8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777742; c=relaxed/simple;
	bh=f6uuageFtgTVauYRTMUedjvidsXKNurZTEgeUWtBngA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbHjJPZ7fDi2jZ7dHLo2p6eGseXoBAYzWi5+eJaMHLIgNWjres/Jtwm2kQrSNf5pYE2hxYopfNtOg1q3vHuIIFW7nXzlGuMbdlSXn0qvI8n4YIw1FC5DXc9stNf0o2b/Cn0vtj8xo1zbzLOJ0F4W6AGcd7w/LhQ5t90EOwjo0oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzALZN88; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzALZN88"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3839659f8f.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 03:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788777736; cv=none;
        d=google.com; s=arc-20260327;
        b=nXxhWHaqdfw28okcdp2wvfhEzfb1QmU+1HJMZ9c8Af0LvY9WhpGmSDWcc9iUvYZCcs
         c4aSdVs+i9IP1bM4PM0iM0IhtXG7j6wWsz4DPQwxkL2hs0ynSP+tl6eR7d+Ni1dGZvwO
         Nda8olWZnX4XfPUswvfu4h2J9IEerL8CDtKiJIGl6RU3ec/S2SmTB9ulbBgFSkCzwBn5
         +9NGiYjK7fTr02tz7up89aICMynSpanAmzxyDl6+srAI5p+a9mo+/xBi9yczWliSN+9a
         6O+Upy1eq1hDuQcYlYabx+XD/60RhL7JGtGFwyGYPjq64FTE5B3/r7TuuixiVglbGCfU
         /zHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CjvpUATnLwHb1hgeEYMoJ5n01Iwjh3JPhU2Cj9ZMiJk=;
        fh=+p09OBNRKxjSudfimoSwlkJi5QV38E1dPI39rza30rQ=;
        b=Nw8mPagNSHDdCpC/R5f42JhQWMHYH5lWFc9WcmdNO7pEZ2G77P127s/LoY6VxBpntD
         6YYFIJufQucEvcxB2RYoY7H/o69NOQfMVrQlS9Y+W5bwbErrtOhsMT3yOjla/+j42nt2
         ppmLMyzu1NAaN36tE2BmCx7Y8AnIMk3gRya2n8R1K+rYONfo61/EeiPIhz9we+j2xaBQ
         IlaElqm0R2b8DT9T0bLEwuVOk4XZdLcMcCqiSHEnAqbIaPS8TJ2XsmBt7ZgPRB9BjztM
         x3BVbb0GJPfoeJ2R/6o1ivlhQ7yrKNQ94EDS7iRX6/NYSEtOLtnZ6i8QOz6shqAicE48
         IMbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788777736; x=1789382536; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CjvpUATnLwHb1hgeEYMoJ5n01Iwjh3JPhU2Cj9ZMiJk=;
        b=DzALZN88W886KAwT6LkUFVu8hivWMRTu4jAsOe726g36QieKm6LDFJJZV3Qm4dbTiS
         jZuLJbq406EPGJHgtz9F8DRtbtdr4lmd6PJr6x0/BeN0ImUIzA9iifCuN0Pw23c44vQ/
         i/zmgBah5ioDdX1M4j8gOLgstM5paF3FeQmARLHto/TbRX7p6OnUiQVdKBN6Vxo0ELHS
         ep6otuvDOSjZnRlDQbQ51YAQlOryUViXwgawmnydApSvDfdQQlk/so7wnjEtMmWerP93
         3IwBWWFNAvnzOkErl0WsoeNST0ScrtZr+iycz2ILRgdmUKDZtRm14VgD0EOtOHq4ABjG
         Djvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788777736; x=1789382536;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CjvpUATnLwHb1hgeEYMoJ5n01Iwjh3JPhU2Cj9ZMiJk=;
        b=dNibVK/EULvixcUphUiVUhCKRSgwn6EA2/zkq2LlFjG8M3MOcNVEUBRVENk/Dg08yC
         i4eTRwrUxVp4PBXR4BtIitEBCadCgOf1EKbut6cKq6BbmdXlj3TmSwRpfD7piwQthRR/
         373lPCTIKn34Cs98sqjWvotz5Lp+QCDh3D8ht7UtZSTKM6XbXj+CGWlv/QsMgOM9Pl4O
         +zyv+pOk2a3mf7HUaawj9lBVGTBkH+SMf9mkss50WZqXN9/4BOSGnlXKsWgmttuW7LK4
         0Wbr/QUrGkH4Wui3RcxvHYa8leEl/a5J/omcy603M0d+qm9mYk6DAIPhLvnL4R03dquO
         xoUw==
X-Forwarded-Encrypted: i=1; AKwUvBw8rv2Nneq5g+vTsN2tmS7mdBcVwvGRhu5dDpPEbZ2USs2aWvp+3cs+k5f6PIg2Y30wcsjZgjw=@vger.kernel.org
X-Gm-Message-State: AFuF++k96JtTFIWPl498chEIVURVHF+x4SWLDkXVxBeeKP9H/obA7AoV
	jzL5WxDtsMrw0KMzy5MxJpA1YuyL7BpsNBoggarm8yiIAsMv9+VweZgCsBfiRM0MO8xndWCAt+f
	VqMuKL/Uw4YFqg3fjIjyHUov0MbBkmj4=
X-Gm-Gg: AYBFou1ogJi45Mfkht8VV4oQoWSd8A87isLM+fN8dQAFjA9ebMn40wRiR0d5JqW+tap
	hD/aiW/bVp5sRTbRsfaBsPWJaN9MVYjY4rgzXtWTfQ/tIHi+Fq/mcw1NdhuYbc+Dkzuc40MIcYt
	aGM2dffvNlBEDgMRE2qdfJ3SYpP1hVj6F18Cf0qRFzML45AnF50IagLN1QSOCX46AZ7G2ViwiEq
	1+jns4DnEewefJHqoPaPcdonsRV2C9EMy0XbyNeXG28fxChPX5pGmIRUQ7vVOhda9qxUdVk3o21
	/ZNBxn1mur5vopydsXJCTyI9O7J/RoDbnBjxLxeU6uU4kw==
X-Received: by 2002:a05:6000:18a7:b0:485:a22b:afd8 with SMTP id
 ffacd0b85a97d-485a22bc562mr435104f8f.0.1788777735592; Mon, 07 Sep 2026
 03:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904144636.3443342-1-maoyixie.tju@gmail.com>
 <CANn89iJRG6UbnYX2xo1ZJR4k=Jr+PQEb48qELK9gpKp2QATKyg@mail.gmail.com> <CAJqdLrqGUQ2YFMAg197OrZaHrYg+-ZDkcA3c+wmZs39uxRz78A@mail.gmail.com>
In-Reply-To: <CAJqdLrqGUQ2YFMAg197OrZaHrYg+-ZDkcA3c+wmZs39uxRz78A@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Mon, 7 Sep 2026 18:42:04 +0800
X-Gm-Features: AcwNN1Uh57V9ic9bDIkDeYFTiRJPzqADxE4QnNPIwzCzfdi_JQ-66Xoe1j-WyrE
Message-ID: <CAHPEe=F+3sA+o5+vtHHwnFsTqrQsqtsDWQd+H2RHnqd3DQ3amg@mail.gmail.com>
Subject: Re: [PATCH net] netlink: render SCM_CREDENTIALS pid in the receiver's
 pid namespace
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, brauner@kernel.org, 
	adobriyan@openvz.org, akpm@linux-foundation.org, leitao@debian.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please drop this patch.

Sorry for the time this cost you both. I sent it without a selftest and
without a use case, and that was the wrong order.

Eric Dumazet wrote:
> Please include a dedicated selftest in tools/testing/selftests/net/
> exercising SO_PASSCRED / SCM_CREDENTIALS
> over netlink across PID namespaces to demonstrate the issue and
> validate the proposed changes.

I wrote it as tools/testing/selftests/net/netlink_scm_pidns.c and have
not posted it, since I am asking you to drop the patch. cross_pidns
fails on 66817a979426 and passes with the patch. reader_in_child_ns goes
the other way. It passes on 66817a979426 and fails with the patch
applied. With the patch, an unprivileged sender in the parent pid
namespace makes a NETLINK_USERSOCK reader in a child namespace see pid
0. No userspace sender can produce 0 today, since find_get_pid(0) is
NULL. That is why I am asking you to drop the patch.

Alexander Mikhalitsyn wrote:
> 1. We need to start from use-case here, because netlink sockets are
> quite special in many ways.

What I measured on an unpatched kernel is that a task with no
capabilities, after unshare(CLONE_NEWUSER) and unshare(CLONE_NEWPID),
chooses the number a NETLINK_USERSOCK reader in a sibling pid namespace
is told, by picking its own position in the namespace it created. I have
not found a program that reads that number on NETLINK_USERSOCK and acts
on it. avahi does on NETLINK_ROUTE, where it accepts a message only when
the pid is 0, and an unprivileged sender that shares its netns gets
-EPERM there.

Is the sender-chosen number worth changing at all?

Alexander Mikhalitsyn wrote:
> 2. If you start tracking struct pid (which is a good idea
> theoretically, if we ignore 1.), then we should do it a bit smarter
> and
>     make use pidfs API [pidfs_register_pid() function] like we do it
> in unix_maybe_add_creds() to make sure that we properly support
>     dead pidfds too.

With the patch dropped nothing in netlink stores a struct pid, so I have
not added pidfs_register_pid(). If the answer is yes, I will start from
your point 2.

I will not post again unless one of you says it is worth changing.

Thanks.
