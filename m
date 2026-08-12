Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD584028C4
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526245; cv=none; b=UpgSWJDs+Iffz3rQOmCZ9M9QMmmraXBgHS2ZWjlwglwzywBqlcebIUb6JstIoZR1ne2KsBqGZlpab4zgaUug7VcTmfJc1RG2Syiy9zUdUIV+iLdcTJ3l1e9N6iNHL3fDrMMKDkCJPJE0vhoOGha92X8JUTuCwca/Q+f80WnL2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526245; c=relaxed/simple;
	bh=3pDy7ZawyB/PDbJyqWDUosIh8hYLV9i7c1SKIQGytFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5/wXHyG7B1UWjBXSRqdPLwCVy7Axh8zCusI3eMeUhx3uX8xhL8+lPZ9vUDWFXJDWWZOz9gS5MPfKPu+VFdCHCcMUQxu+Pvc/sErBpIFwA9437W6V0CGmngacvQl0Bt2KSaFS+D9Yr9BqffkepLd/19U4mzIfiQoxXCGWoHm18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3BADMQs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3BADMQs"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caea3f742bso9699095ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526243; x=1787131043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xULuiWh1KrpeQHM+3Drt9WpY27igzO1L4lGjE3eeQTI=;
        b=h3BADMQsChU2gNuYoGFgsZzzwhvvUFXV01zu78D0LCZW+lD3b5taCt+UWmIM1YGD6P
         k4RT5j5ayZct/+XO9BFCwhBp3dY5OmlH12TVen/+A7cDQneSJzSmewQBGWTJnq/hthQ9
         lSeLr2Nba12R4P4TOkMES0tLxFXV9e0UTiM7WqjjUJHviytC0Ad2M5rTN7cq6ZT3hPjF
         8wkFaqZlp2IOC9vP9mESNbXL/uljbhCG+pGl2GB2XY2wGMI1k7EM/hhv8prBbOdwZIQt
         7VZAv8xA0fcxgx3lud8DV1qs4X+4LWPrSotQpSAW19NS0Wh2AHZByD7DApPa1c4UYKR6
         m3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526243; x=1787131043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xULuiWh1KrpeQHM+3Drt9WpY27igzO1L4lGjE3eeQTI=;
        b=djpdO57OWZ8NL9bc/JMapQx/hffj3saEoGd7WkdiUUHcVYhAUqgIQnYwGNzroRMNEb
         OTwywHhBLHllm3wN4T3oU4kQPdhybufFRREevs8Zj59znsKZ8SH+K+Cl3DsfDliomqQV
         elGn1czyjwvksT1kYx9fQ7aj+8B4usAyV9MXFZFHqqVH6PcSsGTLP0+1odYAidmAC9yJ
         4CXS4C3EuGWUY7px/fUs7DlSSzJjru92sDRfDHVZuuYwpimRqwSYcVmun/8xVHFvpv8I
         dHDCbWF4B2QIhvknXbQI7fNww1Cu029eJeHgMaCg4KmzPqqNUy75tmwJEOeNiyk4x5hc
         NhSA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7rR9JhDtQq1k2fNoF8et7FENYZ1+qXZDyfrjipODSJh7MLrJKXH3yKJM18EfXtm6IMPoRjhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgS5bt6FDKylOTbLneZchIVymKENhvAq0zCxyGqICbSrpsQvOx
	JhfZPw6aJ8V8qnGMvGZxEGSLFsoKeuIyHpggmoZWdlSfJr4vJXpQ1Y2c
X-Gm-Gg: AR+sD12/bxO58eqEAMD4UNf+fZOrlQNirfDTovCwwQ2kiRgldnMbqhGCbi+88yvjf+o
	ucpRfNExWnA+xt29eA97lZEu1SQ9sLoMlAxtFsouE8693EW4t712BziC1fdpJNUQIrzyMCyl51u
	GGrGgcBipQHXACfwjJVeah6N6FPsHkfBZZX1z38BGRLcJFpo6HcBWCrXeClkXl3YcGUqmwEfdTi
	7Tgy4qeZobpUNdfUi2mdgc1PRM8tyWF1Ya0px1iECbXVjJRkIxXYrWl0cG4dukbqGZJPD2UOi4G
	ia4VNsxwe3EOY4om5HyufX8bCKXTGGxZvZ8M2c2lnc5+e762JJt6eZ50WZVncB9c/Bi3woRqKQw
	xQTAbd/Dbj1K9HQxwnBT9Xm/nsfiHBG5BYE+j3ZeHHbreVj4iYQo/r/Fi8PQKvFowdf9b4uAzR8
	cjj7nr7za0I3N1wKkBhHhbw/67vY2obJLz1vxBg+2MNxw+NXnWIDab8w==
X-Received: by 2002:a05:6a21:4603:b0:3c3:7f50:fc3a with SMTP id adf61e73a8af0-3cc3f821173mr4351966637.33.1786526243132;
        Wed, 12 Aug 2026 02:17:23 -0700 (PDT)
Received: from omen-arch ([147.47.133.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee797c623sm383086a12.3.2026.08.12.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:17:22 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH bpf] bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX getname hooks
Date: Wed, 12 Aug 2026 18:16:54 +0900
Message-ID: <20260812091654.244752-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_bpf_setsockopt() and _bpf_getsockopt() call sock_owned_by_me() for
full sockets, so these helpers expect the socket lock to be held.

BPF_CGROUP_UNIX_GETPEERNAME and BPF_CGROUP_UNIX_GETSOCKNAME run BPF
programs without acquiring the socket lock. A program attached to
either hook can therefore trigger the sock_owned_by_me() warning by
calling bpf_setsockopt() or bpf_getsockopt().

Disallow bpf_setsockopt() and bpf_getsockopt() for CGROUP_UNIX_GETPEERNAME
and CGROUP_UNIX_GETSOCKNAME.

Fixes: 859051dd165e ("bpf: Implement cgroup sockaddr hooks for unix sockets")
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
BPF_CGROUP_RUN_SA_PROG_LOCK() acquires the socket lock around the BPF
program invocation:

#define BPF_CGROUP_RUN_PROG_UNIX_CONNECT_LOCK(sk, uaddr, uaddrlen)		\
	BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, uaddrlen, CGROUP_UNIX_CONNECT, NULL)

In contrast, the UNIX getname hooks use BPF_CGROUP_RUN_SA_PROG():

		if (peer)
			BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
					       CGROUP_UNIX_GETPEERNAME);
		else
			BPF_CGROUP_RUN_SA_PROG(sk, uaddr, &err,
					       CGROUP_UNIX_GETSOCKNAME);

So, another possible patch is to take the lock at these call sites,
but I am unsure about the locking semantics in AF_UNIX.

Below is an excerpt of the warning:

	WARNING: ./include/net/sock.h:1799 at bpf_sock_addr_setsockopt+0x12f/0x160, CPU#0: syz.5.18/253
	Call Trace:
	<TASK>
	bpf_prog_55ed9fb09f700adf+0xc0/0xd3
	__cgroup_bpf_run_filter_sock_addr+0x464/0xc80
	unix_getname+0x35e/0x510
	do_getsockname+0x122/0x1c0
	__sys_getsockname+0xc0/0x140
	__x64_sys_getsockname+0x74/0xb0
	do_syscall_64+0xae/0x5e0
	entry_SYSCALL_64_after_hwframe+0x76/0x7e

This issue was found by a custom fuzzer developed by
Sechang Lim <rhkrqnwk98@gmail.com>.

 net/core/filter.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 16845987b244..1e80a52ef86d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8350,10 +8350,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_UNIX_SENDMSG:
 		case BPF_CGROUP_INET4_GETPEERNAME:
 		case BPF_CGROUP_INET6_GETPEERNAME:
-		case BPF_CGROUP_UNIX_GETPEERNAME:
 		case BPF_CGROUP_INET4_GETSOCKNAME:
 		case BPF_CGROUP_INET6_GETSOCKNAME:
-		case BPF_CGROUP_UNIX_GETSOCKNAME:
 			return &bpf_sock_addr_setsockopt_proto;
 		default:
 			return NULL;
@@ -8373,10 +8371,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		case BPF_CGROUP_UNIX_SENDMSG:
 		case BPF_CGROUP_INET4_GETPEERNAME:
 		case BPF_CGROUP_INET6_GETPEERNAME:
-		case BPF_CGROUP_UNIX_GETPEERNAME:
 		case BPF_CGROUP_INET4_GETSOCKNAME:
 		case BPF_CGROUP_INET6_GETSOCKNAME:
-		case BPF_CGROUP_UNIX_GETSOCKNAME:
 			return &bpf_sock_addr_getsockopt_proto;
 		default:
 			return NULL;
-- 
2.55.0

