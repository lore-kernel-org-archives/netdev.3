Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F164E3FCB3D
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725107; cv=none; b=JdQsP1EUkX2V5GY4Nse7U14AEEnvh8CAtqaEJtEEFv+yrTUbycEeiYmWe53Tzt0Bq/xau8oGcWGp2yJMQrZzn/TxI9xS1tfKbGTGRrCCfuKz43perbENprU3Os1joUoMcSJTo5dqkue3Vd1qj+hGsFzGH+MBf9wkrjAv8cMzGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725107; c=relaxed/simple;
	bh=evzl+Hpp+IV7r6sq9RYlAQhlhstCAiZc+kjLirAEVUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTiHBb4YdNsmDNLqhquuD/AF7zMO7grziWP9h5usAsQReajVAYHQa66Ng49PMkZtGHNWh8pfjx8BlNLZrX9xtIvGFG8Y8oDD70zfG+s3e7+HxSuUScwWTsuFcfO3x7tXc9ToTFrfo9O3qNX8yADOTnvOOHBbTOOO3ROT2G2gD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcFU0Iae; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcFU0Iae"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso2916585e9.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789725104; x=1790329904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ISL90nqpfEm1wYjlP2uZ/EAEmky5Z6krLJs1OIlmB5U=;
        b=LcFU0IaeQKk/Uwy9VYasBD54Z7EMSupJUx7b0akDHOXOujRiX6/MZNt+4QCdVn7cBi
         mA9Z+udG27unmzr71W85MSKHeKMIGgIn3wQxH5mtKQqm6W35+vyk7wZ5FzroOIl4nwad
         ru5HN7Mkxf47EuM62LqoledUk1ULBTtMEIhvm4B54+LsKsfg0fuOVPAEwkysV3o0npFR
         0HOu23LhsEoV9Am6tHYvayMo0CJ2bYFGVZJKgTPw3IbBRFnF93ALcqGr4n2+UnNNvyIe
         EB/6rwxXEgjpmDhGTgxVCMSr4mgcvzQjoPfv4nWq5DE93PjaQB5/65IOeGyuzfR0WWoJ
         +9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789725104; x=1790329904;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ISL90nqpfEm1wYjlP2uZ/EAEmky5Z6krLJs1OIlmB5U=;
        b=GUi4L1PWfB7l+M3Ua4MF1AuCsHtjzENl6iW9771re8lk3c3yQN577/0HgmjIKk/y4E
         +N+eXUXcFZL4dzG6eCY09yxzygigBA72e3tOpNv1WETdfNX1fCaFgknCKfBd+J6AL2Hc
         5nMmZLo43Gi220Uvr0fenmFBd/LF8k+x3C7ECrL28+E18QFLf1fDCtH68J7Q38qG6z8P
         LCXudydNuePC4QWU1SMon52Ph1uXxc4YQ6SoQrTcy5/N0CU2X1d4nIwqcdG99WnUUbm9
         ugIyLdUn8hdsWafYMAuginppUwzPYkfDY606RxVHoucAN2Ed8R/lCX6uTEMvX5k4fSSn
         Z5tg==
X-Forwarded-Encrypted: i=1; AKwUvByRLuFYdjqubPKHLvyRLpv1cigwRdXxfEtaLshAQW+ycS0YTk2Tr03twzIReea8XrewuGJ6Lt4=@vger.kernel.org
X-Gm-Message-State: AFuF++ms1/Gh5Sr+8o58HHgn3Lw2LEjmrmklDovkxkweeYi9TnljSVqF
	9RmckhfXIHo0T1yRj96J2LV6BpP3CTuz7QH9GeGscrkniL67Pjj8qMK9
X-Gm-Gg: AYBFou29WBKM8Dq7EIwC3jIAVlYMz1OzeyINSl8TLmmEc3tYh5A9SifSdpnu05iENIU
	0kfMxh/S5qAKAhxPQtlxam3rb3Gvg+i9LuYUjNZmm8R9ztBtje+Wt9kjX3ipYNOwWNnlDpY4KbN
	X21aZjSFeyb0mDXfXiFI50dYSHxWBzXkTrgHkd0AVS/5abaFefMHMCllhT0ypa0qkH8l/oj3hhN
	clvrjKl+YxrGMhur8fbaAUmeebOJUMJVR7HHHKIVw2pxWjfZmdfDIG8la3m/5m2CinO+Hs3O9KC
	FmkIixzp0mSqBlzarqmdb09K1yenbD4rSEgAvl3DoGQWgAK6CnpeUMnGn1YGc2ZWcZMOMlQPpVK
	WbVR3LCtVBSW70/70rogmIPyqK+/Gd7nBLyNGpHWk9NvZ2AzpSZQ6uEpqqpipVdpfaZBdAFTpMG
	4n1tHJIrdEO7kJM7dq8t2yevykKLCQghaxeGCOphN0JAFAFKM+B4o8fKzpngvjAAv8iPtsflSsw
	3QPTULOd4SC+q6iTq8op7tz7HfZGiMNDNzV
X-Received: by 2002:a05:600c:83cd:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49fc56f7a11mr20119345e9.14.1789725104138;
        Fri, 18 Sep 2026 02:51:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7d468b3sm40811125e9.13.2026.09.18.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:51:43 -0700 (PDT)
Date: Fri, 18 Sep 2026 10:51:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Cc: quanyeyang@proton.me, Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Matthieu
 Baerts (NGI0)" <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] tcp: annotate lockless access to
 sk->sk_err
Message-ID: <20260918105142.3dc675eb@pumpkin>
In-Reply-To: <20260917-mptcp-sk-err-net-v4-1-1f04f52f2561@proton.me>
References: <20260917-mptcp-sk-err-net-v4-0-1f04f52f2561@proton.me>
	<20260917-mptcp-sk-err-net-v4-1-1f04f52f2561@proton.me>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 06:41:22 -0700
Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org> wrote:

> From: Quanye Yang <quanyeyang@proton.me>
> 
> BUG: KCSAN: data-race in do_recvmmsg / mptcp_recvmsg
> 
> read-write (marked) to 0xffff8880134d391c of 4 bytes by task 2619 on cpu 1:
>  instrument_atomic_read_write include/linux/instrumented.h:113 [inline]
>  sock_error include/net/sock.h:2565 [inline]
>  do_recvmmsg+0x50c/0x580 net/socket.c:3049
>  __sys_recvmmsg net/socket.c:3144 [inline]
>  __do_sys_recvmmsg net/socket.c:3167 [inline]
>  __se_sys_recvmmsg net/socket.c:3160 [inline]
>  __x64_sys_recvmmsg+0x161/0x180 net/socket.c:3160
>  x64_sys_call+0x19c7/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:300
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff8880134d391c of 4 bytes by task 2620 on cpu 0:
>  tcp_recv_should_stop include/net/tcp.h:3086 [inline]
>  mptcp_recvmsg+0x54d/0xd50 net/mptcp/protocol.c:2466
>  inet_recvmsg+0x204/0x210 net/ipv4/af_inet.c:894
>  sock_recvmsg_nosec net/socket.c:1151 [inline]
>  sock_recvmsg+0x11a/0x140 net/socket.c:1173
>  ____sys_recvmsg+0x14b/0x3c0 net/socket.c:2933
>  ___sys_recvmsg+0x116/0x160 net/socket.c:2975
>  __sys_recvmsg net/socket.c:3008 [inline]
>  __do_sys_recvmsg net/socket.c:3014 [inline]
>  __se_sys_recvmsg net/socket.c:3011 [inline]
>  __x64_sys_recvmsg+0xeb/0x160 net/socket.c:3011
>  x64_sys_call+0x1319/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:48
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x0000006b -> 0x00000000
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 2620 Comm: syz.2.33 Not tainted 7.2.0-g39d4f32c5d53 #76 PREEMPT(full)
> Hardware name: QEMU Ubuntu 26.04 PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
> 
> do_recvmmsg() and getsockopt(SO_ERROR) call sock_error() without the
> socket lock. sock_error() clears sk_err with xchg(), which races with
> unmarked loads of the same field.
> 
> KCSAN reported the unmarked peek in tcp_recv_should_stop(). The same
> lockless writer races with the other plain sk_err reads on the TCP
> send, recv and splice paths.
> 
> Annotate those peeks with READ_ONCE(). No extra ordering is needed:
> the value is only used to decide whether I/O should stop. This does
> not consume sk_err; the check-then-sock_error() TOCTOU on the no-data
> paths is a separate issue. MPTCP peeks are handled in the next patch.

Don't they need annotating with data_race() ?

David
