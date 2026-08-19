Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79344480350
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154863; cv=none; b=cHk+sAXk4DCQXOh7NZxVoxujaqgqD4hwgnybu/FMh80/7QVivHgv+GRsj1mCUjvTcqNPHuGoF3xDP24YYABmbpUTHzaxxvW6inbvuPinee15BDMmS0o5wBMYmJywtHoQ5RO1Dn/Y5s1EFhTBxnPQrzHJPR+1GXyg0WWi9pGkE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154863; c=relaxed/simple;
	bh=12a99CZooZeh/6Zr18YkATcXoZorOGreI5XGbpZ6hCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4G0xJ65i4nuM1RMh+4P9g9NQmntZaHZP52Yf62kK9bF4ADzh2Q8WeWRf+X7wLpVTy4UeFZy0W8WektE1CgpiTjbMiIo+YpGyZwHJVo02WLpGfYMM2qCtaeUaj2uSyrxiiw03kn0lpRKe9UiQSUsoIbKZBmUu4vL3DMGMSWv+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=WLhbtjEm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="WLhbtjEm"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1005591a12.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1787154857; x=1787759657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUQjv6WFeC4LVm2DLMuaaoqz/KN+oBl4j8XX94n8WlQ=;
        b=WLhbtjEmH5E+ddO5Szs40pFqxQd1YnYSWL5FilCO7aiCWIGLfxsHKcPqrFTS0lJyWa
         roEJjgfm8mNVKgOwGgWESCoMvsScfAs0PnvrJu6bMqNhbYe8w1EI4aQMsYCZ9+EU4/M5
         ZG4JiNGnywYncc5nGc3DvUOXb2OP24tv/w+8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787154857; x=1787759657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUQjv6WFeC4LVm2DLMuaaoqz/KN+oBl4j8XX94n8WlQ=;
        b=FjkdGpZgO8VEZ6qfUcp21VGcAFbjEO3NuTIyILJsaYOsjKVPSIONJPGpEbtHUe9QP7
         iBGivB0c8Pr+f3oEnDIr7nBc0ETHZoFXfHYcTs0Vs10mJxc8OwWsJM57eavrdrpvQS5l
         i7FD5VhSfEs8FIrqAx0UyVXeoCFmGLlqa9foVNOPZIVan44xhAq6dMOcAEhcToBxt5ps
         kd1LeVPRINZOEOV3mEQY6ud53KoSi22oGhGsQCTIFHccuXm/oSVlYw4aDMMyUHEigWks
         /qMtTdEM4FUEGGgbPAYziMMrD0HZNOgLPyC/R5C0eEqqJhwzI+SV/MZDzqzGXni29XGC
         AUng==
X-Forwarded-Encrypted: i=1; AHgh+Rqx5t3Sz84kHoSse/zyRQ8gJzPVHQQnIKrketZ4HisDzR883cuuOuNXLhqOdf3u3ETQx/fodmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCr1qs55fIBGfU2EbjSqSFG2Plhq7AP2DZC6nL9vwQ7IW8f1/P
	jKEsvjdfDd5KJ4AkU2FHEHQ793LObMBQqtzfTell4rCOZlj4PpieuYRZaRQBCbMoNHE=
X-Gm-Gg: AR+sD13NQwGNnEZeU0Kv+zMP3Cncpn7Fvm1TwBv4yGIiKTMifi2Jdr8bF2P1uJqwoyN
	S40WTO/uYnikcC1Ae1XdMxxtLcKatxjJWTIQyi0zGEV+CmR4nRzvQjuJBrFu2L6fe6bfEnxGItI
	y/4bFjRWjeZwRi5jhL7V9pKzR4hrPOvX0grIE3DcbtltjD0aW5OtcJwbSFhzBgYFP3r2wKA7EOK
	hiNjQES0wOCDy2lzq1JUgLhwhX1o8B9N1HRPnCWNsC/hNt6TbKNowyUPTjC9TzIoZMOW1fvfYjk
	zVWoRc5i9WV15x8encAAAmRQV5+T8UZQmg9HKxgGhr+fV32vcZYqTX377PaFy+9+6FLJkldwF0u
	gc1zYaGRmCxZJbKs2ovuOrbCSPByNFyGoPD6qUB1uoH4bC3iUKjw3Ohf9s7uc+xN5FhVtdyL9iy
	TAB1pPoGepVXwf/Fdll4yoqUcBySpeK3lqkQg3AvpO68MtgQ+CXiDHibsLm9yE5jcDmLTD0xyVM
	42rw52qF/JZ2T3AXS35Idc1ADdxibzTrR9b+rtrlc/sHiP54YrQmDP3wwzC2M3k7+qmTIU6O1i0
	usaNpF9dUKPjDoIPfq8a69oK5aLDahaEFVi4OSv8nH8a5o8AInpP4A==
X-Received: by 2002:a05:6a20:9d90:b0:3c3:b57b:6285 with SMTP id adf61e73a8af0-3cd011b1b55mr11597196637.13.1787154856560;
        Wed, 19 Aug 2026 08:54:16 -0700 (PDT)
Received: from leesin ([147.46.121.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1593060e8sm679663a12.32.2026.08.19.08.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:54:15 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	eulgyukim@snu.ac.kr
Subject: [BUG] general protection fault in espintcp_sendmsg
Date: Thu, 20 Aug 2026 00:53:47 +0900
Message-ID: <20260819155349.3555804-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We found a "general protection fault in espintcp_sendmsg" on Linux v7.2.
The issue was found by our own race fuzzer. We have not analyzed the root
cause, so we do not have a proposed fix to offer.

To reproduce the race reliably, we applied the delay patch below to the
kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
crash log we observed, the delay patch and the reproducer are all included
below.

The following kernel config options are required to reproduce the issue:
	CONFIG_XFRM=y
	CONFIG_XFRM_USER=y
	CONFIG_INET_ESP=y
	CONFIG_INET_ESPINTCP=y
	CONFIG_KASAN=y

We hope this report is useful. Please let us know if any further
information would help.

Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Kernel delay patch:
==================================================================
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 374e1b964438..333760567aa8 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -8,6 +8,8 @@
 #include <net/inet_common.h>
 #include <trace/events/sock.h>
 #include <net/hotdata.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
 
 static void handle_nonesp(struct espintcp_ctx *ctx, struct sk_buff *skb,
 			  struct sock *sk)
@@ -478,6 +480,9 @@ static int espintcp_init_sk(struct sock *sk)
 	sk->sk_data_ready = espintcp_data_ready;
 	sk->sk_write_space = espintcp_write_space;
 	sk->sk_destruct = espintcp_destruct;
+	if (strncmp(current->comm, "syzrepro0", 9) == 0) {
+		mdelay(100);
+	}
 	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	INIT_WORK(&ctx->work, espintcp_tx_work);
 
==================================================================

C reproducer:
==================================================================
#define _GNU_SOURCE
#include <netinet/in.h>
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/prctl.h>
#include <sys/socket.h>
#include <unistd.h>

#define SYSCHK(x) ({ long __r = (long)(x); if (__r == -1L) { perror(#x); exit(1); } __r; })
#define TCP_ULP 31

static volatile int g_fd = -1;
static volatile int g_stop;

static void *writer_fn(void *idx)
{
	unsigned char payload = 0xf7;
	char name[16];
	int fd;

	snprintf(name, sizeof(name), "syzrepro%ld", (long)idx);
	prctl(PR_SET_NAME, name, 0, 0, 0);
	while (!g_stop) {
		fd = g_fd;
		if (fd < 0) {
			usleep(200);
			continue;
		}
		write(fd, &payload, 1);
	}
	return NULL;
}

int main(void)
{
	pthread_t th[3];
	long i;
	int it, fd;

	signal(SIGPIPE, SIG_IGN);
	prctl(PR_SET_NAME, "syzrepro0", 0, 0, 0);

	for (i = 0; i < 3; i++)
		pthread_create(&th[i], NULL, writer_fn, (void *)(i + 1));

	for (it = 0; it < 200; it++) {
		fd = SYSCHK(socket(AF_INET, SOCK_STREAM, IPPROTO_TCP));
		g_fd = fd;
		usleep(3000);
		setsockopt(fd, IPPROTO_TCP, TCP_ULP, "espintcp", sizeof("espintcp"));
		g_fd = -1;
		usleep(1000);
		close(fd);
	}

	g_stop = 1;
	for (i = 0; i < 3; i++)
		pthread_join(th[i], NULL);
	return 0;
}
==================================================================

Crash log:
==================================================================
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000080: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000400-0x0000000000000407]
CPU: 1 UID: 0 PID: 415 Comm: syzrepro1 Not tainted 7.2.0-dirty #4 PREEMPT 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:espintcp_sendmsg+0x1de/0x5d0 net/xfrm/espintcp.c:331
Code: 00 48 8b 44 24 10 8b 30 83 e6 40 4c 89 ff e8 99 f6 ff ff 85 c0 0f 88 ce 00 00 00 4d 8d bc 24 04 04 00 00 4d 89 fc 49 c1 ec 03 <41> 0f b6 04 1c 84 c0 0f 85 2b 03 00 00 c7 44 24 0c 97 ff ff ff 41
RSP: 0018:ffff888103e679c0 EFLAGS: 00010203
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 1ffff110207ccf14
RDX: 0000000000000001 RSI: 0000000000000000 RDI: dffffc0000000000
RBP: ffff888103e67b38 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffed10207cceec R12: 0000000000000080
R13: ffff888103e67ab0 R14: 1ffff110207ccf44 R15: 0000000000000404
FS:  00007be5667d06c0(0000) GS:ffff88818c759000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007be5668cc340 CR3: 000000010caea000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg+0x157/0x1a0 net/socket.c:790
 sock_write_iter+0x1d3/0x2c0 net/socket.c:1241
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x4c8/0xa50 fs/read_write.c:687
 ksys_write fs/read_write.c:739 [inline]
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __x64_sys_write+0x153/0x220 fs/read_write.c:747
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7be5668cc38f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 a9 d4 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 fc d4 f8 ff 48
RSP: 002b:00007be5667cfe70 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007be5667cfeaf RCX: 00007be5668cc38f
RDX: 0000000000000001 RSI: 00007be5667cfeaf RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000064
R10: 0000000000000000 R11: 0000000000000293 R12: ffffffffffffff80
R13: 0000000000000000 R14: 00007ffe83852980 R15: 00007be565fd0000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:espintcp_sendmsg+0x1de/0x5d0 net/xfrm/espintcp.c:331
Code: 00 48 8b 44 24 10 8b 30 83 e6 40 4c 89 ff e8 99 f6 ff ff 85 c0 0f 88 ce 00 00 00 4d 8d bc 24 04 04 00 00 4d 89 fc 49 c1 ec 03 <41> 0f b6 04 1c 84 c0 0f 85 2b 03 00 00 c7 44 24 0c 97 ff ff ff 41
RSP: 0018:ffff888103e679c0 EFLAGS: 00010203
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 1ffff110207ccf14
RDX: 0000000000000001 RSI: 0000000000000000 RDI: dffffc0000000000
RBP: ffff888103e67b38 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffed10207cceec R12: 0000000000000080
R13: ffff888103e67ab0 R14: 1ffff110207ccf44 R15: 0000000000000404
FS:  00007be5667d06c0(0000) GS:ffff88818c759000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007823930e8b58 CR3: 000000010caea000 CR4: 00000000000006f0
==================================================================
