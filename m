Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56535E1AF
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593104; cv=none; b=BpScvB+7o2CL+ypXQyU8/eZRC/oYwhGSpfaZLhkAnYT8NcwWAcDcwB3VX1DnCI4qtPDcu0M8cLLupO537cMIt6I17nZ2z/Oc0iO1zRBOLJwS1wQsFzWXanGsX2Uaw7co3Pdpuefdx3TElagHoBUVnIA8ssSOny8ToUQYA4VLkrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593104; c=relaxed/simple;
	bh=JScBWDIyq3IPjP1nc3ZaCx+Z8gnodJdx4N1fTXUQfSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5mo2+HjZpoS9eqb7witCkYDM15l9Xa3O2yfUUmG2uw5dvquagdCrfhHf7sKneI2oP+R86l6BuuHO7db1GQXJgsDBEVOtD7IfQP/B3p3F1IuYoZzNT/xUTR+kddnmbPEQspKkajJoxeojqRiwLwEXl/kyKQXMbj1ppaascodl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5iNRhV3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5iNRhV3"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-382ef647e20so325554a91.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786593103; x=1787197903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ma6ZbShKO9rAbTtXIbG/48Oqhn/7/NpX4MIE3BGiTqI=;
        b=G5iNRhV3gaI8t2aNDNwg1kvLWVSugu+nC8Hfwb7k/8OYZVHKgqiJtHUek/397QnPdu
         tFAB7e1gknYPWPpRkF6sZE2g8pbGyF1pNcgTuiMhMBGYuYSgmuzEx7ez0tKbgJskWIT4
         emMplJsI5VQSltyv5N9sIOGMlpiSHy3kaxcJpWPJGWIi6il4OYxVXIKqI74/37AmvnO7
         xZwOJ7YQW5cjUH7Ml8fTouJrUILsCMhIXMB85aohn6HZ/n2h2DjVykHpLhQZQRaCmD3C
         2yls+j5zF2AoLWUyIU0HdP4wXtv2tzApGv0/S9pXS+U+Hkr+fwnf1yv8wL6v7AKhhYIz
         lpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786593103; x=1787197903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ma6ZbShKO9rAbTtXIbG/48Oqhn/7/NpX4MIE3BGiTqI=;
        b=TL51g6tnvXVAcLajBuuTGPDla1gyL5XwwK/Rp1oeYUlbRh4y3S2swBoIiO7FnUBVeT
         dKPYat8zKD5TWQXXyCKOqODBtVVxs61cucysqgsOmSxPk+N0NCOpIBBT/QmR3kOGu/xE
         JXpvHORam0Rfm/pmC1ly5EEwPXTAR2gAm/NuMFAgsKFzTK2sBun5TtKgw8pEOLuJwAss
         ovmQaIPy50pLMiVQu1Lf5RFDt6krWGrPqwtrKmdcaMn3kEIw0/hqDvj2sEjFU+x0Wq/T
         vXPk+Fnk6sppCOR7zgH7ocLKlRDnbSnHM/NOIio5HPd3IyAU9KZJGP3xWlLIF0HmpaDA
         WaOg==
X-Forwarded-Encrypted: i=1; AHgh+RqvCoeahhNw4V2hh00jYifgzOo6EjtIxunv96/OMwzKlwlOt8w/YBlsOjlHECeS7/kl7UmjH7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBTUt0C+R0MSf1+EykpYSpCCmTCLDClk6I+i92zxt+3V1fi+l
	8FdIuLT0PhfZuskVmIGgZcAv/VnxQCpYb8RiA/mQfpYhvnfeSxJm5xBy
X-Gm-Gg: AR+sD13Cyr30Aqwg3JMzYhD340R9dMfGh5kTtfhD4OdzKU65KipmpbQqco6XBbDSGT4
	agjE4ySnrAxQkG4dFzBeTA2N10Ji7IiWgX4tL0sR9YPePFOQSG3w6Iei8YgFkpO5CXjRMYF4JfD
	QWTjD1gibNWyRGIIDp6i9b6zIkB/jPkRIliya9DjEg+BqLOy21fekBg3fE8iXdJ+5cmHuzIH465
	d31XpSmdYL49ifnPf3YK10F03Jv2yoYT0mG8Pdyww5uR28oIxq0oY2iV6CYBpWUd35L+6VlC5Za
	lrrC4XLdJOhwHBK7R5GuGMyMP9iCsk1ipXruitMAABa66o5s2/54oeCQMA1Fs4Ht4xljjYJaoz5
	IvYLZRJsxLIIZgL2ZKOJUlcFMnBSL+SrGvaTZCxKCXNFEN4ELDzWVOk4dgBVHaAHuUdF+VJbNUw
	sbiv3XZ8ndDk9t5v/Y8ffz/3nurtMgzwogkvaZbVP/yKWnGyfC468VeL8=
X-Received: by 2002:a17:90b:3805:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-3931e2d5ad3mr3082876a91.18.1786593102550;
        Wed, 12 Aug 2026 20:51:42 -0700 (PDT)
Received: from omen-arch ([147.46.124.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931ca612e7sm1625873a91.0.2026.08.12.20.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 20:51:41 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Tom Herbert <tom@herbertland.com>
Subject: [PATCH net] net: kcm: Hold RCU read lock while running BPF parser
Date: Thu, 13 Aug 2026 12:51:36 +0900
Message-ID: <20260813035136.106167-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcm_parse_func_strparser() calls bpf_prog_run_pin_on_cpu() which
prevents CPU migration, but does not establish an RCU read-side
critical section. Consequently, BPF map operations can trigger
WARN_ON_ONCE(!bpf_rcu_lock_held()) when called from the KCM strparser
program.

Hold the RCU read lock while running the program.

Fixes: 9b73896a81dc ("kcm: Use stream parser")
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
This issue was found by a custom fuzzer developed by
Sechang Lim <rhkrqnwk98@gmail.com>.

The report could not be reproduced locally.  However, the trace shows
the BPF parser being invoked from strp_work without an RCU read-side
critical section.

Below is an excerpt of the warning:

    WARNING: kernel/bpf/hashtab.c:1547 at htab_lru_map_delete_elem+0x604/0x700, CPU#0: kworker/u4:2/28
    CPU: 0 UID: 0 PID: 28 Comm: kworker/u4:2 Not tainted 7.2.0-rc4-dirty #3 PREEMPT(full)
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
    Workqueue: kstrp strp_work
    RIP: 0010:htab_lru_map_delete_elem+0x604/0x700
    Code: 8f d9 03 48 3b 44 24 30 0f 85 b0 00 00 00 4c 89 e0 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 ec a0 dd ff <0f> 0b e9 35 fa ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 54 fa
    RSP: 0018:ffffc900001cf678 EFLAGS: 00010293
    RAX: ffffffff8e8910f4 RBX: ffff888102bf8800 RCX: ffff888100ce8000
    RDX: 0000000000000000 RSI: ffffffff91df4082 RDI: ffffffff91597ac0
    RBP: ffffc900001cf7f8 R08: 0000000000000000 R09: 0000000000000000
    R10: ffff888106cf6180 R11: ffffffffc020540c R12: ffffc900001cf778
    R13: 1ffff1102019d07f R14: ffff888106cf6140 R15: ffffc90020a65000
    FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000001b34521ff8 CR3: 0000000021a28001 CR4: 0000000000370ef0
    Call Trace:
     <TASK>
     bpf_prog_5dda175565b852e0+0x140/0x153
     ? __copy_skb_header+0xba/0x480
     ? __asan_memcpy+0x40/0x70
     ? __skb_clone+0x61/0x8f0
     bpf_prog_run_pin_on_cpu+0xf4/0x330
     kcm_parse_func_strparser+0x60/0xb0
     __strp_recv+0x5d5/0x1880
     __tcp_read_sock+0x181/0x8c0
     ? __pfx_strp_recv+0x10/0x10
     ? __pfx_tcp_read_sock+0x10/0x10
     strp_work+0x20f/0x3c0
     ? __pfx_strp_work+0x10/0x10
     ? lock_acquire+0xf5/0x250
     ? process_scheduled_works+0x9ce/0x13c0
     process_scheduled_works+0xa3f/0x13c0
     ? __pfx_process_scheduled_works+0x10/0x10
     ? assign_work+0x366/0x530
     worker_thread+0x93c/0xe70
     kthread+0x34b/0x460
     ? __pfx_worker_thread+0x10/0x10
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x348/0x700
     ? __pfx_ret_from_fork+0x10/0x10
     ? native_load_tls+0xd/0x40
     ? __switch_to+0x916/0xc30
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x19/0x30
     </TASK>

 
 net/kcm/kcmsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index d469abcd989b..71af69d442f2 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2016 Tom Herbert <tom@herbertland.com>
  */
 
+#include <linux/rcupdate.h>
 #include <linux/bpf.h>
 #include <linux/errno.h>
 #include <linux/errqueue.h>
@@ -391,7 +392,9 @@ static int kcm_parse_func_strparser(struct strparser *strp, struct sk_buff *skb)
 	struct bpf_prog *prog = psock->bpf_prog;
 	int res;
 
+	rcu_read_lock();
 	res = bpf_prog_run_pin_on_cpu(prog, skb);
+	rcu_read_unlock();
 	return res;
 }
 
-- 
2.55.0

