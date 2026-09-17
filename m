Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197224AD7DD
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645475; cv=none; b=tPCcYDh2rTVHf8CroVPmQLj4o7dbYcbojC76tupbw4fVYxpCyXL22xym1tXOxjiVA1X1pHN3PjhXJUj7uuHzZMahbOpgIiH5UOq6MjQEAhxHbhC+mETjcT5XNLJrh3uBKTAhzaJFiWhysECEllmNVuFKwZH2CTFN7dND5ZiKmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645475; c=relaxed/simple;
	bh=38fdMOqqkjVb4+K9xNByEKRCYXqsOUNdTTDvu9cZGqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTWJBMSFxgkkCdUhyRJy/Rhcg6I9zzXhkIKdlm8X2sfjbByDFvNzCM7HSMjTk26W/qgqyNR43uGnRbv49VPfum1Vaev0RhG3wS4Lof1tkVrN9A+KkjoKm1OzzRWKggtsVU8s/ibISrLWmNQcLtSE8YURD9koUrc8Y0xai9/SA7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KL92P6wn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lO1gwWCn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KL92P6wn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lO1gwWCn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789645464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGqmqb/xlGBNH7S3iVpHeaOXNt7kzvMGonuOaCfxMiY=;
	b=KL92P6wnrKKBwk0XYaY+CkV2flDGEUz7v3wkDtazuAq40+ZzkKD6ya1mssTEba/phOvb/d
	VoK2MGxU5tI4MLj0GCicLSynKxQUviGKd03Jb4B+6o+0XZR/XLshdPj6EMJPEgeYgS7xBJ
	FzsCJVbiDNogILwZF+RdgF+e/oGapZo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-1GFaaE9hMjGNpKqJNoD4tw-1; Thu, 17 Sep 2026 07:44:21 -0400
X-MC-Unique: 1GFaaE9hMjGNpKqJNoD4tw-1
X-Mimecast-MFC-AGG-ID: 1GFaaE9hMjGNpKqJNoD4tw_1789645460
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so5489835e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789645460; x=1790250260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jGqmqb/xlGBNH7S3iVpHeaOXNt7kzvMGonuOaCfxMiY=;
        b=lO1gwWCnqIVqH+hHQdN0i+2IO6IW+drHdf8cqm5yd9KHMnj9yc/iPN0cJAwvO8rhaq
         GTRfnSIV1TejpBbkBp/TK5rp+EHXUWThD/CoQtfhLfQvnUybNx+Y1xWpIVa3OndqzCq9
         G+3R0SZLRMiqJfYhI7iwyCD8TMSJJvyS9HJBPnci4K6dMA6WLuic6DzUiAoCCV8LfwOf
         7Jgvqw1uacRMGkTuiSTWl352jkkATtdOMLxja38jtEjchlNKt5l7QaCMwI3AX4iwqkA6
         Ar3Xf1xs1Mqrxrt9usKtpKrfYCOXClU73nqdkRd4NxyzGb4VBRwTF8F07u07P7yZUtJQ
         Txtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789645460; x=1790250260;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGqmqb/xlGBNH7S3iVpHeaOXNt7kzvMGonuOaCfxMiY=;
        b=dLXvldQ0nX4eSXElWfTAfHHrkkgOQGQF+KhXdHgk+Dp5hF6LjIlv0K+PboiaL4zy46
         IeZ2lwZUCiKzLPLnbybPxpFRIROO5muknxr9fAbCwgWxGKQ1ErjCqZVoinDOx1VVBY9G
         9iL/jLLUAoRMPSQKrmxK3ndQ9S1VwNLAswjk4HIU4WX+1A/n+quiwFBQ2htn9aH1YSuS
         ByAFFjI8uDdvAR042yZKBOjxJFC1SWmofnT0yC6Cny5aU0Esofnhy5e1DHIgJKGIk5Ox
         IE9uJFZGAtT64PRuzIPn2er0/jakD3S5+xYabPpuVxilxuP+F0IYAYQElSDes6qxbGQR
         f/6Q==
X-Gm-Message-State: AFuF++mF3bHc3rxcUpHdZmWpbDBDF499/4AgIc1pOw1hBLQxrMnNL2OL
	jW7vgI61knVwQ8wWj4pwVBORz/OlNC634IvOK9yR6HSrKmwywJLUwtRbsU/wXF2HuOizPhDsGcj
	/Bjt2jCwd84c/FqP/uDsZMyZnadsEUbm8ErwM7D1VCsoxf0NK8GQ7Foph6w==
X-Gm-Gg: AYBFou1XrcBjkc3yP+2Tmx+2HfTeORdcrEv+6iPmvKoH0DS/pw+5hQThuQPa47YBcrB
	deP54TS/i8/Ybixhe4s4rpeYenCY088KzjcYcnXSQ1/alTshYRl6TEM7rmcH9ZwOM00VpfW/Cgb
	CAg/BINhJvDlyEJXYKVrSy0WSECK8Tg9G5MzIRRjVbNkIX13Y76loCmMg0N90ACbkXJjJps5B4c
	uFV68cmTBIXvGh7oQe4vPYowWw9RUb4IQrxOVeriHMVduCWxsNC0E7Jcf8eZJMR5dfSaLOk1Vkl
	WhWQTkKwH8B5nu+ESGwqft6gt8oEIj6IfkKVXOZHPGOz6adth/3ONsGsyEwrgnk0oBEn11PIDYW
	ElnCgYufRyGEJGVk73YZPlbIrYzDWTZXGFE084hMmuV++NbHusu7I0mvEFl/dTXyyEwI/89g+sA
	==
X-Received: by 2002:a05:600c:4708:b0:49d:93c:d903 with SMTP id 5b1f17b1804b1-49eb7322de3mr78360065e9.20.1789645459899;
        Thu, 17 Sep 2026 04:44:19 -0700 (PDT)
X-Received: by 2002:a05:600c:4708:b0:49d:93c:d903 with SMTP id 5b1f17b1804b1-49eb7322de3mr78359705e9.20.1789645459493;
        Thu, 17 Sep 2026 04:44:19 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf33d93sm14186498f8f.22.2026.09.17.04.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:44:18 -0700 (PDT)
Message-ID: <8b8de55c-0f97-4048-a759-a59aff74fff6@redhat.com>
Date: Thu, 17 Sep 2026 13:44:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] tcp: annotate lockless access to sk->sk_err
To: Quanye Yang <quanyeyang@proton.me>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260912-mptcp-sk-err-net-v3-1-c41383878bde@proton.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260912-mptcp-sk-err-net-v3-1-c41383878bde@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/26 17:43, Quanye Yang wrote:
> BUG: KCSAN: data-race in do_recvmmsg / mptcp_recvmsg
> 
> read-write (marked) to 0xffff8880134d391c of 4 bytes by task 2619 on cpu 1:
>   instrument_atomic_read_write include/linux/instrumented.h:113 [inline]
>   sock_error include/net/sock.h:2565 [inline]
>   do_recvmmsg+0x50c/0x580 net/socket.c:3049
>   __sys_recvmmsg net/socket.c:3144 [inline]
>   __do_sys_recvmmsg net/socket.c:3167 [inline]
>   __se_sys_recvmmsg net/socket.c:3160 [inline]
>   __x64_sys_recvmmsg+0x161/0x180 net/socket.c:3160
>   x64_sys_call+0x19c7/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:300
>   do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>   do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff8880134d391c of 4 bytes by task 2620 on cpu 0:
>   tcp_recv_should_stop include/net/tcp.h:3086 [inline]
>   mptcp_recvmsg+0x54d/0xd50 net/mptcp/protocol.c:2466
>   inet_recvmsg+0x204/0x210 net/ipv4/af_inet.c:894
>   sock_recvmsg_nosec net/socket.c:1151 [inline]
>   sock_recvmsg+0x11a/0x140 net/socket.c:1173
>   ____sys_recvmsg+0x14b/0x3c0 net/socket.c:2933
>   ___sys_recvmsg+0x116/0x160 net/socket.c:2975
>   __sys_recvmsg net/socket.c:3008 [inline]
>   __do_sys_recvmsg net/socket.c:3014 [inline]
>   __se_sys_recvmsg net/socket.c:3011 [inline]
>   __x64_sys_recvmsg+0xeb/0x160 net/socket.c:3011
>   x64_sys_call+0x1319/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:48
>   do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>   do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
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
> lockless writer races with the other plain sk_err reads on the
> TCP/MPTCP send, recv and splice paths.
> 
> Annotate those peeks with READ_ONCE(). No extra ordering is needed:
> the value is only used to decide whether I/O should stop. This does
> not consume sk_err; the check-then-sock_error() TOCTOU on the no-data
> paths is a separate issue.
> 
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Link: https://lore.kernel.org/netdev/8bbee583-6f21-4817-bfeb-2d60057380a3@linux.dev/
> Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/632
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>
> ---
> Changes in v3:
> - drop the Fixes tag and retarget to net-next
> - annotate the remaining unmarked sk_err peeks on the TCP/MPTCP
>    send, recv and splice paths
> - Link to v2: https://patch.msgid.link/20260909-mptcp-sk-err-net-v2-1-5044abecac90@proton.me
> 
> Changes in v2:
> - add Reported-by and Closes for the MPTCP syzkaller report
> - Link to v1: https://patch.msgid.link/20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me
> ---
>   include/net/tcp.h    | 3 ++-
>   net/core/stream.c    | 2 +-
>   net/ipv4/tcp.c       | 6 +++---
>   net/ipv4/tcp_bpf.c   | 7 +++----
>   net/mptcp/protocol.c | 6 +++---

IMHO you should split the tcp and mptcp changes in separate patches. 
Also the mptcp side has at least one more missing sk->sk_err annotation 
missing, as reported by sashiko.

/P

