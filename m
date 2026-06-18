Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28834250E
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781821351; cv=none; b=X43bNsyabQyXeCVSfL8mfya7K/gBjVNg87cOQAxTrNojqTPZ9M260xAp0SNEan4lIPBtriVM8FLkTBjEBlOVAxUU/V2IFy9UKLRQtEKGPNwI3bO+b5bcwPvQxJPzz1KM6EwVVpU+1aaI+G1i7ckFAC/o/EZP+yxNVEB7++Nbjwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781821351; c=relaxed/simple;
	bh=eno9+JEgpYphh9f0hBUFi2qA975l2eM4UsP+uqTp3CQ=;
	h=Message-ID:Date:Subject:To:Cc:Content-Type:MIME-Version:From; b=s/nQR7qgOrexwfMFm2VP7pPnigKVd26z6PK3OElCnqesT7tA5BunoK0nFaMaQp08qyxW5ZmkBliJZYqbxxwar+WbFz5iyFW8O8U6HQ5hlD+jrYbuHjmT6KbtQYnR0wwEjkDGbs08ep6pf37ypVJIOXRBFr0EcAx1k4Bo6sXiCeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bws+JWd7; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bws+JWd7"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ab02fb66easo50263e0c.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781821349; x=1782426149; darn=vger.kernel.org;
        h=from:mime-version:content-transfer-encoding:cc:to:subject:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wyEMxcL/k0D8dyxIzQC47Ww0m9XxDIq24Zae2rXDLqE=;
        b=Bws+JWd70G0zMCHYGBUEa3Wyu2VyzDhWUnFegCtvOyASyGY8dDr11ibuYSS7Mbzfnl
         w6JPpZzMuMRMZducwPSD2mSfaJlqBv9Kv030r88PqzCsU1IjQf9Heb67kQKwE3LiucgR
         Q08YhiqL0FBqLwSgLkCsvkAT9a6qyv6z5fIaYSb/l86O523cYIQcI6hotNkiYAJiPQ6H
         zz6L0EHUBBKa0301mcxCJmTsAHUgZvx2W77pnYtQe722gjNrcYFAlsb7R/MHo3ZMb1Di
         kjKdaTaVmA7rNgzoKNZEYPHSqZD0BcH7jw12ktGCCcjMiRXtivj7UIa+o8uFZwN6X81P
         Ytfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781821349; x=1782426149;
        h=from:mime-version:content-transfer-encoding:cc:to:subject:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyEMxcL/k0D8dyxIzQC47Ww0m9XxDIq24Zae2rXDLqE=;
        b=Md8xXQznRx1lgPKnbCgwjvUZJqugaA2z2QHucuZVYH+Lnc5v4itEVfvSD6Etev3NH/
         2kkQihsHgj/NxJ734eAkAPijUQUQj6xMOz2xryyyXP608YAcHn+e5pI4/JvgcS9OX1AJ
         DNn3cfxG1+t0F8HaHej/Sr06LKU+s4INxg47WzshdRq0E94nLGo6nHqRZ9BwZ8U50jNZ
         vRl0GyF2bsBkMNk50g6X5qAZu6MK/WFqSBt3jPyjM8zCDEzuInCXt94rjFGq87S+OZlH
         fky0GTjnJ+O0lQtdwbKrp8mIq04hV5syHzPTRcq5IMaxS6pRVFGy1xVzMKKCot4JJX+V
         D6RA==
X-Forwarded-Encrypted: i=1; AFNElJ/bQpFOvxW880PnhF8qDO4Wf13rMgEXX8RrkTH2lB2+gDSl9qhdIAaCGl34DVlLHiU/WKgGjtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPhGrkameiV8/GnZcYbaPtbe+vk6ogT1Z8kRSfX3/mLcj5Cb6
	kDiU0fx4qSIpKxmZSrT2c7JkYdS/ws7QiUgZ4at+ReYc3MT/3ffXfLz+
X-Gm-Gg: AfdE7ck0axurExB2LTq9Rgqja5TUQr9EGManQ2VSpwyrDn2DwwAFAJUYU5oOgVDaIuf
	XZncNbDBnE7UWTKAmewnE7brRPMxCpl6nSsx2+n1N5bOrBDQxRjOkGBm/X/N/5ShOT9e0Ihzq2A
	ELTCk88ojmYYY+vSuTyzH36Pj/bWv5RUfjb43uMV+XRusDWEN7zQxFlnNBNmyfpIIM9fxusBjKI
	PSxpxEnwaGLQXoJ/kPUXyyiZNJZDMJMDItx1IGHg9jnToFVfaAuIKxCOK5+0W7yS6bU48SmdkhB
	Ifx54Os/paisCZTauyxJhK3ZJ3QfvfePw0uefmBlQgHc4SmEK6HWplu/zmp4iS82hFplDnfPtN5
	rYOhRngR4clACYl/YRne+vAuVfUvRjRqYngtqYC2iOyNVKVpTc8Hn4YSsu4NPzGK2iIPkuNQUE3
	2f9n+haWVlb0fc6EM97/y9Ls5N9s7pAZgzwjUykcrUChaQADwjwTUQ+E9BJOunmHXEiVD9FBiTA
	AL6kfHvET9C
X-Received: by 2002:a05:6122:c2c8:20b0:5aa:82ce:d15a with SMTP id 71dfb90a1353d-5bbebcfa876mr100947e0c.3.1781821349456;
        Thu, 18 Jun 2026 15:22:29 -0700 (PDT)
Received: from [192.168.10.115] ([132.170.207.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbea1889e6sm739338e0c.8.2026.06.18.15.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 15:22:28 -0700 (PDT)
Message-ID: <6a346fa4.26cc5c6d.1ace13.9d21@mx.google.com>
Date: Thu, 18 Jun 2026 15:22:28 -0700 (PDT)
Subject: general protection fault in fou_nl_add_doit
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sanan.hasanou@gmail.com

Good day, dear maintainers,

We found a bug using a modified version of syzkaller.

Kernel Branch: 7.0-rc1
Kernel Config: <https://drive.google.com/open?id=1RsqMUgdFUMq9-iREK8DZCvDfjq0RWm5X>
Reproducer: <https://drive.google.com/open?id=1KNnULJOSBve4YaFQT2Z-pK2Ms8LwRN7P>
Thank you!

Best regards,
Sanan Hasanov

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 326872 Comm: syz.6.71753 Tainted: G             L      7.0.0-rc1 #1 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:fou_create net/ipv4/fou_core.c:590 [inline]
RIP: 0010:fou_nl_add_doit+0x236/0xaa0 net/ipv4/fou_core.c:764
Code: 48 89 da 4d 89 2c 24 48 85 d2 0f 84 eb 07 00 00 4c 8b 6c 24 60 49 8d 5d 18 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 48 89 54 24 10 74 0d 48 89 df e8 47 c2 90 f8 48 8b 54
RSP: 0018:ffffc9002b54f260 EFLAGS: 00010216
RAX: 0000000000000003 RBX: 0000000000000018 RCX: dffffc0000000000
RDX: ffff88801aeb8d00 RSI: 00000000000002d1 RDI: 00000000ffffffff
RBP: ffffc9002b54f3d0 R08: ffffffff8ef0f1bf R09: 1ffffffff1de1e37
R10: dffffc0000000000 R11: fffffbfff1de1e38 R12: ffff88801d9a3a38
R13: 0000000000000000 R14: ffff88802440dd00 R15: ffffc9002b54f440
FS:  00007f863f9266c0(0000) GS:ffff88809d305000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c40b6a1 CR3: 0000000026d9b000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 genl_family_rcv_msg_doit+0x20d/0x2f0 net/netlink/genetlink.c:1114
 genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
 genl_rcv_msg+0x60c/0x790 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x206/0x460 net/netlink/af_netlink.c:2550
 genl_rcv+0x31/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0xa42/0xc00 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x7ed/0xb00 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x4dd/0x8e0 net/socket.c:2592
 ___sys_sendmsg+0x1ee/0x260 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x189/0x240 net/socket.c:2681
 x64_sys_call+0x17a2/0x2900 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x110/0x8a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f86416d3b6d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f863f926018 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8641945fa0 RCX: 00007f86416d3b6d
RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000003
RBP: 00007f8641777c3e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8641946038 R14: 00007f8641945fa0 R15: 00007ffce4a75000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fou_create net/ipv4/fou_core.c:590 [inline]
RIP: 0010:fou_nl_add_doit+0x236/0xaa0 net/ipv4/fou_core.c:764
Code: 48 89 da 4d 89 2c 24 48 85 d2 0f 84 eb 07 00 00 4c 8b 6c 24 60 49 8d 5d 18 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 48 89 54 24 10 74 0d 48 89 df e8 47 c2 90 f8 48 8b 54
RSP: 0018:ffffc9002b54f260 EFLAGS: 00010216
RAX: 0000000000000003 RBX: 0000000000000018 RCX: dffffc0000000000
RDX: ffff88801aeb8d00 RSI: 00000000000002d1 RDI: 00000000ffffffff
RBP: ffffc9002b54f3d0 R08: ffffffff8ef0f1bf R09: 1ffffffff1de1e37
R10: dffffc0000000000 R11: fffffbfff1de1e38 R12: ffff88801d9a3a38
R13: 0000000000000000 R14: ffff88802440dd00 R15: ffffc9002b54f440
FS:  00007f863f9266c0(0000) GS:ffff88809d305000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc1ad9e3080 CR3: 0000000026d9b000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	48 89 da             	mov    %rbx,%rdx
   3:	4d 89 2c 24          	mov    %r13,(%r12)
   7:	48 85 d2             	test   %rdx,%rdx
   a:	0f 84 eb 07 00 00    	je     0x7fb
  10:	4c 8b 6c 24 60       	mov    0x60(%rsp),%r13
  15:	49 8d 5d 18          	lea    0x18(%r13),%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
  33:	74 0d                	je     0x42
  35:	48 89 df             	mov    %rbx,%rdi
  38:	e8 47 c2 90 f8       	call   0xf890c284
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	54                   	push   %rsp

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
