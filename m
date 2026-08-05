Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5F38E8A7
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905517; cv=none; b=CIP1li2I3qPFTKmolqYb3jJOxXpYPyth6PoQ5QcqwJNbEs2SuNyer2uUbFKKOsLHI3yfvoaiQZ2ZMtSrLXxCj6/2TUO9kB4544suQLt8IskYjgBs3cRxdvelmDOQRwpGnXixoHiD0nUcVEK/NagpK1j4rVRyx9wQv4y+v8aPxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905517; c=relaxed/simple;
	bh=bgLe+1HZk5gNYo1CL4eOWjMLKT7sXvEIIxHjvMoLWBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9ZhJaHtdLAQWnJhGqVlwK6n8m6VK7oB0IWMJQz2XSUOdq5QONnOZgCJ1aKqAyHa9oLrR9VFTC/ZjwJClJ8iWGKeDnBGGA7GBRVbXPE4ESDHJQX71tr0Wmz4vgh3Dm4894Xj+AolfnrxRXyZcIXxtTqEvPFAc2TiDenJUVmWZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Jz/OATIH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Jz/OATIH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso527662a91.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 21:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785905515; x=1786510315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxisC83D43/WsjSmlzZQ6gogZ1IhaBnjkknbtT3278k=;
        b=Jz/OATIHcU9MnC/hqFCu90Oenrl85XbYhghcN4ZGZ8c+IZR25mD8D/ifo1WxJ/P7M3
         7+FQDx+DEUZFCjOUPynQ+xXQ7Pt+R3PHy5NU41EZ1O0tngxpG41fN0DyRw3VBgLuJT4T
         qDplWmzt79rpTFvceDNu8LcCgoZIqur4t/OvoQbW5BoZ20r9d2ki7EhTglJoxxlh8Thv
         5ltaONq16QE3ubVRzxFsfjr6Un++SjVrkQu1As7sxOXNPNLgy7LbcknV2gd14Nqpn1AC
         GRvcN4GLl47aeh3eL5f/pcLp5DAxTiFkZ+r2adjpZ9o8hPYf9QdxdVHQklH9VGQXZHC9
         hMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785905515; x=1786510315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxisC83D43/WsjSmlzZQ6gogZ1IhaBnjkknbtT3278k=;
        b=KqH4TkvEhFTUM3mi4DpFWLiyHZWFXpT4qUVLr4zpD+8rIqhmhFx1NMKh3Mhe4sM9G8
         zIc3c3CwQn4fe+GrC+bzY5I1cMF5Tq1FB0Fy2/IOO5Oa8twPLaZ1XsDQ/aYCjOs7klqh
         fE3HYstnDlIzKPc10jugG9BOvydu5FjUz/iZq5TkWInxc9MrxUYxWr18xu/KQ5maqB3Q
         +ci06D5C8Vzu3XisTp+BJDofapRGUisucvZB0hfN9oayehsJkPs2hFYxHT3DoMMHkSqI
         zxOCnsnmBw2yyZ8ZtPW346PDWURysWNLgVdIupj14MmI9u+hvhntpAxEDqsOFfnwh3Nu
         5ksQ==
X-Gm-Message-State: AOJu0YzxNfuYmqukPdEM/vGLVjfyXBvJbUjDzS0vq2IE3q9IfDFUPb0J
	kO5l62qcKohcR/1rMcEAmC2XLn9fkOsp6yiK8UIDLdaUwWNap/Dos8qSLUfhmnm3pZ7cv36KeJe
	2rxuM4HI9
X-Gm-Gg: AR+sD13wxLLzmgSwBgRhf90sF/D6HxtAuKOxJWF/NSOnUa4siyRCBAYkkcz51xErRKL
	t1fgnGDr1MmeNMG5z360rIwy9+HSO4DwmD4EvVlbg1yOFupYtU/6XqUOK20PMz3NLt/R+6Vg+t7
	NX8Il7Z7cAjdAdbmPCxbitKgrplqcWCTRja2jRrVb04z0XwUJ3hc2Nt7v+EGpuBtLvbWbaQo0Ct
	g9VK2rzL1cnqbrBhJ1kHGv3ZqUbdlY4xmIXxjOQZu67jMo9jPsvs/YSESsF1QbGsMQpzSP2GSHW
	8tYt8P1zsMm1DHWa4mPaYXGEsMvnrUvINO01+9fWnLkoIH5zMVPBIhHsCAYrxv/n97l1PSqj2np
	srsXBP5nV2077/xcC4V4isZ4oxpGXk2MaXzG6dE2LAiIrrnznHe1MSrvrmjKY/TLh5D5DYsbgiE
	y7LxmBSP3TFzZTcUkGqawEno1MRNA3B5t34TNmhuXKoeFUA88ZlsyTVcFUvLHAiFdQ07nOmnSDw
	N+KpRaN
X-Received: by 2002:a17:90b:1808:b0:38d:e658:5959 with SMTP id 98e67ed59e1d1-3903c545edamr3529137a91.5.1785905515060;
        Tue, 04 Aug 2026 21:51:55 -0700 (PDT)
Received: from localhost.localdomain ([115.192.251.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38feda512f3sm3160666a91.11.2026.08.04.21.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 21:51:54 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	eyal.birger@gmail.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 0/1] xfrm: avoid lock inversion in nat keepalive work
Date: Wed,  5 Aug 2026 04:51:24 +0000
Message-ID: <cover.1785861392.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/xfrm/xfrm_nat_keepalive.c. The
buggy lock ordering is reachable once an outbound ESP-in-UDP state with
NAT keepalive enabled exists; installing such state through
NETLINK_XFRM requires CAP_NET_ADMIN in the target net namespace. On the
validation kernel used below, the original userspace NETLINK_XFRM
reproducer in the bug directory is rejected by strict attribute
validation before it reaches the buggy path, so local fix-vs-unfix
validation used a temporary in-kernel reproducer for the same root
cause. We've tested it, and it should not affect any other
functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

nat_keepalive_work() walks the state table through xfrm_state_walk()
while xfrm_state_walk() holds net->xfrm.xfrm_state_lock. The original
callback then acquires x->lock. The delete path takes the reverse
order: xfrm_state_delete() acquires x->lock first, and
__xfrm_state_delete() later acquires net->xfrm.xfrm_state_lock. That
creates an AB-BA deadlock between the keepalive worker and the delete
path, and lockdep reports it as a circular dependency when keepalive
work races with SA deletion.

This v2 is rerolled on top of net cf6f8b29befb so it applies after the
nat_keepalive_send() default-case change. It keeps the same root-cause
fix goal as v1: split the walk into two phases, first collecting
candidate states while the walk owns xfrm_state_lock and taking
references on them, then processing the referenced states after the
walk phase so x->lock is no longer nested under xfrm_state_lock.

Compared with v1, this version uses a bounded fixed-size batch together
with the xfrm_state_walk() cursor to resume the scan when the batch
fills up. This avoids per-state GFP_ATOMIC allocations and avoids
aborting a full round on -ENOMEM. The phase-two drain stays in
BH-disabled context, so nat_keepalive_send() keeps its original softirq
assumptions.

The maintainer-side ipsec/master and ipsec/testing branches currently
contain the v1 carried as commit 763fe700b7c5 ("xfrm: avoid lock
inversion in nat keepalive work"). This v2 is therefore intended as a
reroll/replacement candidate for that queued fix if the bounded-batch
version is preferred.

Eyal reviewed v1, but I did not carry the Reviewed-by tag because v2
changes the implementation from an allocated list to a bounded batch.


On the validation kernel used for the logs below, the original
userspace NETLINK_XFRM reproducer in the bug directory is rejected
before it can reach the buggy path, with the kernel reporting
"attribute type 34 has an invalid length". To validate the same root
cause locally, we used a temporary in-kernel reproducer that creates
outbound ESP-in-UDP states with NAT keepalive enabled, explicitly kicks
keepalive work, and then deletes the states. This reproducer was used
only for local validation and is not part of the patch series.

For this reroll, the fix was validated on net cf6f8b29befb with an
incremental lockdep build using CONFIG_PROVE_LOCKING=y and
CONFIG_LOCKDEP=y. The unfixed kernel triggers the lockdep circular
locking dependency with the in-kernel reproducer. The fixed kernel
completes the same reproducer iterations 0..63 and prints "done",
with no "possible circular locking dependency detected" in the fixed
QEMU log.

decode_stacktrace.sh was rerun against the unfixed vmlinux after
normalizing the QEMU serial log to LF line endings. The decoder exited
without stderr in the full-log run, but its output stops immediately
after the lockdep "trying to acquire lock" line; section-only retries
were also attempted and timed out without producing a complete decoded
lockdep report. To avoid inventing a decoded trace, the crash excerpt
below keeps the raw lockdep section from the same LF-normalized QEMU
log, and the key offsets were resolved separately from the same unfixed
vmlinux with nm and addr2line:

    __xfrm_state_delete+0xa4: net/xfrm/xfrm_state.c:819
    xfrm_state_delete+0x23: net/xfrm/xfrm_state.c:857
    xfrm_nat_keepalive_repro_init+0x416:
        net/xfrm/xfrm_nat_keepalive_repro.c:59
    nat_keepalive_work_single+0x15c: net/xfrm/xfrm_nat_keepalive.c:176
    nat_keepalive_work+0xe8: net/xfrm/xfrm_nat_keepalive.c:211
    xfrm_state_walk+0x4ed: net/xfrm/xfrm_state.c:2725

Reproducer:

    # The original userspace NETLINK_XFRM reproducer in the bug
    # directory does not reach the buggy path on this validation kernel.
    # For local fix-vs-unfix validation of the same root cause, we
    # temporarily linked the following in-kernel reproducer and booted
    # QEMU with lockdep enabled.
    make -C <tree> O=<build-dir> -j$(nproc) bzImage

    qemu-system-x86_64 -m 2G -cpu host -smp 2 -machine accel=kvm \
        -kernel verify/bzImage-unfixed-cf6f-incremental2-poc-lockdep \
        -append 'root=/dev/sda rw console=ttyS0 earlyprintk=serial \
        net.ifnames=0 biosdevname=0 panic_on_warn=1 oops=panic \
        slub_debug=FZPU page_poison=1 init_on_alloc=1 init_on_free=1' \
        -drive file=<rootfs>,format=raw,snapshot=on -nographic

    qemu-system-x86_64 -m 2G -cpu host -smp 2 -machine accel=kvm \
        -kernel verify/bzImage-fixed-cf6f-incremental2-poc-lockdep \
        -append 'root=/dev/sda rw console=ttyS0 earlyprintk=serial \
        net.ifnames=0 biosdevname=0 panic_on_warn=1 oops=panic \
        slub_debug=FZPU page_poison=1 init_on_alloc=1 init_on_free=1' \
        -drive file=<rootfs>,format=raw,snapshot=on -nographic

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
// SPDX-License-Identifier: GPL-2.0
#include <linux/delay.h>
#include <linux/init.h>
#include <linux/in.h>
#include <linux/ip.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <net/net_namespace.h>
#include <net/xfrm.h>

static int __init xfrm_nat_keepalive_repro_init(void)
{
	time64_t now;
	int i;

	pr_info("xfrm_nat_keepalive_repro: start\n");
	now = ktime_get_real_seconds();

	for (i = 0; i < 64; i++) {
		struct xfrm_state *x;
		struct xfrm_encap_tmpl *encap;
		int err;

		x = xfrm_state_alloc(&init_net);
		if (!x)
			return -ENOMEM;

		encap = kzalloc(sizeof(*encap), GFP_KERNEL);
		if (!encap) {
			xfrm_state_put(x);
			return -ENOMEM;
		}

		encap->encap_type = UDP_ENCAP_ESPINUDP;
		encap->encap_sport = htons(4500);
		encap->encap_dport = htons(4500);

		x->id.proto = IPPROTO_ESP;
		x->id.spi = htonl(0x100 + i);
		x->id.daddr.a4 = htonl(INADDR_LOOPBACK);
		x->props.saddr.a4 = htonl(INADDR_LOOPBACK);
		x->props.family = AF_INET;
		x->props.mode = XFRM_MODE_TRANSPORT;
		x->props.reqid = 1;
		x->sel.family = AF_INET;
		x->sel.daddr.a4 = htonl(INADDR_LOOPBACK);
		x->sel.saddr.a4 = htonl(INADDR_LOOPBACK);
		x->sel.prefixlen_d = 32;
		x->sel.prefixlen_s = 32;
		x->encap = encap;
		x->dir = XFRM_SA_DIR_OUT;
		x->nat_keepalive_interval = 60;
		x->lastused = now;
		x->km.state = XFRM_STATE_VALID;

		xfrm_state_insert(x);
		xfrm_nat_keepalive_state_updated(x);
		msleep(200);
		err = xfrm_state_delete(x);
		xfrm_flush_gc();
		pr_info("xfrm_nat_keepalive_repro: iter=%d delete err=%d\n",
			i, err);
	}

	pr_info("xfrm_nat_keepalive_repro: done\n");
	return 0;
}

late_initcall_sync(xfrm_nat_keepalive_repro_init);
------END poc.c--------

----BEGIN crash log----
[   49.685255][    T1] xfrm_nat_keepalive_repro: start
[   49.909131][    T1] 
[   49.912451][    T1] ======================================================
[   49.922185][    T1] WARNING: possible circular locking dependency detected
[   49.930762][    T1] 7.2.0-rc4+ #3 Not tainted
[   49.939108][    T1] ------------------------------------------------------
[   49.949736][    T1] swapper/0/1 is trying to acquire lock:
[   49.959492][    T1] ffffffff989fc058 (&net->xfrm.xfrm_state_lock){+...}-{3:3}, at: __xfrm_state_delete+0xa4/0x9d0
[   49.993466][    T1] 
[   49.993466][    T1] but task is already holding lock:
[   50.007066][    T1] ffff88802f1400c8 (&x->lock){+...}-{3:3}, at: xfrm_state_delete+0x1b/0x40
[   50.021592][    T1] 
[   50.021592][    T1] which lock already depends on the new lock.
[   50.021592][    T1] 
[   50.038394][    T1] 
[   50.038394][    T1] the existing dependency chain (in reverse order) is:
[   50.050144][    T1] 
[   50.050144][    T1] -> #1 (&x->lock){+...}-{3:3}:
[   50.058785][    T1]        _raw_spin_lock+0x2d/0x40
[   50.065593][    T1]        nat_keepalive_work_single+0x15c/0x1bf0
[   50.073120][    T1]        xfrm_state_walk+0x4ed/0xb70
[   50.080208][    T1]        nat_keepalive_work+0xe8/0x1b0
[   50.086723][    T1]        process_one_work+0xa76/0x1d00
[   50.093353][    T1]        worker_thread+0x7d0/0x1150
[   50.099921][    T1]        kthread+0x3e0/0x520
[   50.105304][    T1]        ret_from_fork+0x75b/0xdc0
[   50.111879][    T1]        ret_from_fork_asm+0x11/0x20
[   50.117871][    T1] 
[   50.117871][    T1] -> #0 (&net->xfrm.xfrm_state_lock){+...}-{3:3}:
[   50.129416][    T1]        __lock_acquire+0x1593/0x2670
[   50.135575][    T1]        lock_acquire+0x1a6/0x340
[   50.142901][    T1]        _raw_spin_lock+0x2d/0x40
[   50.150073][    T1]        __xfrm_state_delete+0xa4/0x9d0
[   50.157880][    T1]        xfrm_state_delete+0x23/0x40
[   50.164730][    T1]        xfrm_nat_keepalive_repro_init+0x416/0x5f0
[   50.173960][    T1]        do_one_initcall+0x128/0x760
[   50.180472][    T1]        kernel_init_freeable+0x59a/0x910
[   50.188201][    T1]        kernel_init+0x1d/0x2b0
[   50.195434][    T1]        ret_from_fork+0x75b/0xdc0
[   50.205142][    T1]        ret_from_fork_asm+0x11/0x20
[   50.212534][    T1] 
[   50.212534][    T1] other info that might help us debug this:
[   50.212534][    T1] 
[   50.342664][    T1]  Possible unsafe locking scenario:
[   50.342664][    T1] 
[   50.351961][    T1]        CPU0                    CPU1
[   50.359709][    T1]        ----                    ----
[   50.367870][    T1]   lock(&x->lock);
[   50.373541][    T1]                                lock(&net->xfrm.xfrm_state_lock);
[   50.384736][    T1]                                lock(&x->lock);
[   50.393602][    T1]   lock(&net->xfrm.xfrm_state_lock);
[   50.400155][    T1] 
[   50.400155][    T1]  *** DEADLOCK ***
-----END crash log-----

Best regards,
Zihan Xi

---
changes in v2:
  - reroll on top of net cf6f8b29befb so the patch applies after the
    nat_keepalive_send() default-case change
  - replace the unbounded GFP_ATOMIC state list with a bounded batch
  - keep phase-two processing in BH-disabled context with
    local_bh_disable()/local_bh_enable()
  - clarify the validation permission model and reproducer scope
  - refresh the cover letter with cf6f8b29 incremental build and PoC
    validation results
  - rerun decode_stacktrace.sh on an LF-normalized crash log and
    document the decoder truncation in the cover letter
  - add source locations for the key lockdep offsets from the same
    unfixed vmlinux
  - add Eyal Birger to Cc for the v2 reroll
  - v1 Link: https://lore.kernel.org/all/cover.1784645321.git.xizh2024@lzu.edu.cn/

Zihan Xi (1):
  xfrm: avoid lock inversion in nat keepalive work

 net/xfrm/xfrm_nat_keepalive.c | 51 +++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 8 deletions(-)

-- 
2.43.0
