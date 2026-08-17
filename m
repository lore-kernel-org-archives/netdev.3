Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77253B27F5
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993296; cv=none; b=P8M9F4B6oq8qVtEUsFiwVXc85bymjK7AxDnia8Lzyrr4bRvWUJCEAQ4DgVfjB61iefXwGKu7+7uSpQ2Ca3WVKxPPF//fulmHSvGKwzpZEnXnzJqzujRTRAlXuyYYaBi0tzOfV3TDt6rxPH5jCDCn0d2J9Nh0yye+eU8wg8cuwnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993296; c=relaxed/simple;
	bh=HdGGAV8UQuPPOKZDMix6zTs04UXg4XodXsKaaxJmDn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AeL9zGBNEp24dMdBkMgdIvP8yCyNG1U3DCi7GMOC1qeP/NN4cAdv4xPO0LfYpy3DPpYvrwHsturB/JqDe3T891v2nHYO8jCx5rONNRAh5Qdp6Vw7FtB4MLgcy4TI9Irx8WO3lej1VWyhchIUYtWnuIEJ3TQ/NL0E+En+v9RUlFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=nK2zgyjB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="nK2zgyjB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8486ac3f347so210170b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786993293; x=1787598093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sk/o74C9vXOo9wampxgEppHNHFJScgPFdCROkqbEqgg=;
        b=nK2zgyjBZyYiI1mCk6JFrYCJo7vv8ad13p6ze0ITFlACsDytwIFjs/b9AAoGcJXyv1
         OBxOJrM2jp/0qweSo70ouBClBh8T/H+gW6joXMzG75NzSnTIMCIj7rsn8DFnNE7Bo0DI
         9+BEFa1nj2MO+lje0GRT+l7P1kZsWG288PtW1exyacVHUS7/7aJcPv8FTv6oqPqfr1b/
         6LbVGHL0xfwpE+su9hSvA0VM0NusbtxTrCG9efHvmdoCpb5s/XHBX7xXI2zQYTY12kNq
         fKXmMA6bJ+B1SF6tcUAXu8TJibaI20R+HbI+ejKBPiYSsTQkiMMM4/w7NgbLCAlYZkPd
         zhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786993293; x=1787598093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sk/o74C9vXOo9wampxgEppHNHFJScgPFdCROkqbEqgg=;
        b=I95aF38xkNlXH+uHCXDDhgXi1Re9ByagRk0reqeqvNaE00AEZCA0c2klKKU0ZymzB9
         gbfmXEtU9fzwozYM6PUaxXZYEQXQGu4crkg5Pb7sDbwIWqlNClAX9zsnjwXQpWMUJ6k6
         mRTutKrvtyYCBLpPKDXs6Yu6jT08LeGQeS/Fg91MrVLzuLMr1RkHCUvc7qR9Tnyphao3
         7dwzH2dcjrdzXQpDIqX/9Zbz1BqSm28YcukLWWiw/c88YjDcYNb1kE71PpDmJuAHsY+f
         hQUkN5XHuDpxamRpw/UiEaPstRRu5qRCYP+2g5hVrE9Mk9fwO3SgtkaCUQt05dOcTjjn
         sJ8A==
X-Gm-Message-State: AOJu0YyS/JbA++ZatX9E3CHRJtj1RrHfWJDsday1LPqw0QIYfNdd5G7x
	Z13Hn3KCPxsayWJCpbsnBZRDOd2mNPtAR1xH1oh1dLLD3z308QtOkgHsPXynqbOQlTp7vtPMFNy
	SZuln1m6N
X-Gm-Gg: AR+sD12pEx1oKrqPtn489HHY5QfqfPST21HgPb4Jkjc9PKxC6FyFCn44kY52uyAgH42
	Y2vYbr8++BBkNpBer+7urpZGCOuNLn765V7ShvD47sR593Ea8CIr5JfblzsB/yxLcBzGMjYA87g
	yHatv1YUBTYfV0xYIX5T7lK5CB4YHL06bGXcU15vzDZpefZl52l+KB1ktsgm42X8y6tkpRRx9/q
	q3OUBg/zu/rOYabM9QqxkuDbRV1itCNnJxZufLZJXh+vme+LgCsggtT3ruc8qlU/wBBQOYg74VH
	eoF5mFLCGHUy1tYi5ezEiugUaeFyL5qzBasMjSwKAkkmk9XvqJN0KPS676sBmuuCyGFhMgE5h0e
	lRBFd2xeGjSa7gUmiPuaij9ynR1VPMlMi3s7s9leTAIf6crP8L/MDUYUKPXgLPALkWC1Qlvj7J/
	C8Cr3EFdsWpCry777nnVRuzhZyqe0I1cxXPJIdCArOLeqc2Jgbo90QRA==
X-Received: by 2002:a05:6372:a745:b0:3c3:75c5:48d5 with SMTP id adf61e73a8af0-3ccde6539e4mr879363637.4.1786993292957;
        Mon, 17 Aug 2026 12:01:32 -0700 (PDT)
Received: from gmail.com ([115.196.71.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13bf05584sm1203779a12.4.2026.08.17.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:01:32 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH ipsec v3 0/1] xfrm: bound nat keepalive state collection
Date: Mon, 17 Aug 2026 19:01:00 +0000
Message-ID: <cover.1786987905.git.zihanx@nebusec.ai>
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
original deadlock requires an outbound ESP-in-UDP state with NAT keepalive
enabled; installing such a state through NETLINK_XFRM requires
CAP_NET_ADMIN in the target net namespace. The validation kernel does not
enable user namespaces, so the user+net namespace operation required by
the template command below returns "Invalid argument" before it can run
poc. Running the same userspace request as validation root in a fresh net
namespace reaches NETLINK_XFRM but is rejected by strict attribute
validation ("attribute type 34 has an invalid length") before it reaches
the buggy path. The local fix-vs-unfix evidence below therefore uses a
temporary in-kernel reproducer for the same root cause. The v3 batch path
was validated with 17 simultaneous states on top of the queued v1. It
should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

nat_keepalive_work() originally walked the state table through
xfrm_state_walk() while xfrm_state_walk() held
net->xfrm.xfrm_state_lock. Its callback then acquired x->lock, while the
delete path acquired x->lock before net->xfrm.xfrm_state_lock. The queued
v1 fixed that AB-BA lock ordering by collecting referenced states first
and processing them after the walk.

The queued v1 implementation allocates one GFP_ATOMIC list entry for
every candidate state. This makes temporary memory use grow with the
number of states and lets an allocation failure abort the scan. This
incremental fix replaces that list with a fixed-size batch of 16 state
pointers. When the batch fills, the callback returns a private status;
xfrm_state_walk() leaves its cursor in the state list, the batch is
processed after xfrm_state_lock is released, and the walk resumes from
that cursor. References are held for every collected state and released
after phase-two processing.

The queued v1 also moved nat_keepalive_send() out of the walk callback.
The callback previously ran with bottom halves disabled because
xfrm_state_walk() held xfrm_state_lock with spin_lock_bh(). The phase-two
drain therefore explicitly keeps bottom halves disabled, as required by
the local_lock_nested_bh() locking used by the keepalive sockets. The
existing two-phase ordering still ensures that x->lock is never acquired
while xfrm_state_lock is held.

This v3 is an incremental fix on top of the queued v1 commit
763fe700b7c5 ("xfrm: avoid lock inversion in nat keepalive work"), as
requested by Steffen Klassert. It is not a replacement patch that asks
the maintainer to revert v1. The Fixes tag therefore points to
763fe700b7c5:
this patch fixes the allocation and BH-context issues introduced by that
queued implementation, while v1 retains the original root-cause fix.

Eyal reviewed v1, but I did not carry the Reviewed-by tag because this
fixup changes the implementation from an allocated list to a bounded
batch.

The original userspace NETLINK_XFRM reproducer is not usable on the
validation kernel: it is rejected before the buggy path with
"attribute type 34 has an invalid length". The local reproducer below is
a temporary in-kernel reproducer used only to compare the queued-v1 parent
and v3. It installs 17 outbound ESP-in-UDP states with NAT keepalive,
enables all of them together, flushes the worker, and then deletes them.

The crash block below is from the unpatched cf6f8b29befb baseline. It
records the original AB-BA lock inversion that the queued v1 fixed; it is
not evidence that the v3 bounded-batch or BH-context changes independently
reproduce a new crash. For this v3 reroll, the queued-v1 parent and v3 were
both rebuilt with the same lockdep configuration and run with the 17-state
in-kernel reproducer. Both printed "batch=17" and completed deletion of
all 17 states with "done states=17 err=0", without a circular-dependency
warning, WARNING, BUG, Oops, or kernel panic.

Seventeen candidates force the v3 worker to drain its 16-entry batch and
resume from xfrm_state_walk()'s cursor for the remaining state. The run
does not inject an allocation failure into v1's historical GFP_ATOMIC
collection path; v3 has no corresponding per-state allocation.
A fresh unpatched run produced a complete serial capture: the log contains
the lockdep warning, the full "*** DEADLOCK ***" diagram, and later boot
output. decode_stacktrace.sh was run against the matching unstripped
vmlinux. It resolves the initial frame but times out while repeatedly
scanning the large debug image for every symbol. The complete lockdep
section was therefore decoded in one batch addr2line invocation against
the same vmlinux. The raw report and exact tool output are below; only the
local source-tree prefix was stripped from the decoded paths.

Crash-log provenance:

The crash log below is from a separate earlier revision of the temporary
in-kernel root-cause reproducer on the unpatched cf6f8b29befb baseline. That
revision printed "start" rather than "start states=17", and the decoded
xfrm_nat_keepalive_repro_init() locations correspond to that source snapshot,
not to the 17-state poc.c pasted above. It is included only as evidence of
the original AB-BA lock inversion; it is not claimed as output of the v3
batch validation run.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

The template commands above were attempted against the validation kernel.
The user namespace operation required by "unshare -Urn ./poc" returned
"Invalid argument" because this validation configuration does not enable
user namespaces, so that command could not execute poc. For a separate
userspace reachability check, the same statically built program was run as
root in a fresh net namespace; it returned "add_sa: Invalid argument", and
the kernel reported "attribute type 34 has an invalid length". This failure
occurred before nat_keepalive_work(). The commands therefore do not provide
the fix-vs-unfix evidence. The actual validation reproducer is the
temporary in-kernel source below, and its integration, configuration,
build, and boot steps follow.
The source was integrated only in the validation tree as
net/xfrm/xfrm_nat_keepalive_repro.c, with xfrm_nat_keepalive_repro.o added
to the net/xfrm/Makefile xfrm-y list. The lockdep validation configuration
contained:

    CONFIG_XFRM=y
    CONFIG_PROVE_LOCKING=y
    CONFIG_LOCKDEP=y
    CONFIG_DEBUG_LOCK_ALLOC=y
    CONFIG_DEBUG_SPINLOCK=y
    CONFIG_DEBUG_INFO=y
    # CONFIG_USER_NS is not set

The validation was built and booted as follows in a 2 vCPU, 2 GB RAM x86
QEMU environment:

    make -C linux O=build olddefconfig
    make -C linux O=build -j2 bzImage

    qemu-system-x86_64 -m 2G -cpu host -smp 2 -machine accel=kvm \
        -kernel build/arch/x86/boot/bzImage \
        -initrd initramfs.cpio \
        -append 'root=/dev/ram0 rw console=ttyS0 earlyprintk=serial \
        net.ifnames=0 biosdevname=0 panic_on_warn=1 oops=panic \
        slub_debug=FZPU page_poison=1 init_on_alloc=1 init_on_free=1 \
        rdinit=/init' -nographic

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

#define REPRO_STATE_COUNT 17

static int __init xfrm_nat_keepalive_repro_init(void)
{
	struct xfrm_state *states[REPRO_STATE_COUNT] = {};
	time64_t now;
	int inserted = 0;
	int i;
	int err = 0;

	pr_info("xfrm_nat_keepalive_repro: start states=%d\n",
		REPRO_STATE_COUNT);
	now = ktime_get_real_seconds();

	for (i = 0; i < REPRO_STATE_COUNT; i++) {
		struct xfrm_state *x;
		struct xfrm_encap_tmpl *encap;

		x = xfrm_state_alloc(&init_net);
		if (!x) {
			err = -ENOMEM;
			goto out_delete;
		}

		encap = kzalloc(sizeof(*encap), GFP_KERNEL);
		if (!encap) {
			xfrm_state_put(x);
			err = -ENOMEM;
			goto out_delete;
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
		/*
		 * Keep the worker from running before all states are installed.
		 * xfrm_state_insert() calls xfrm_nat_keepalive_state_updated().
		 */
		x->nat_keepalive_interval = 0;
		x->lastused = now;
		x->km.state = XFRM_STATE_VALID;

		xfrm_state_insert(x);
		states[inserted++] = x;
	}

	for (i = 0; i < inserted; i++)
		WRITE_ONCE(states[i]->nat_keepalive_interval, 60);

	xfrm_nat_keepalive_state_updated(states[0]);
	pr_info("xfrm_nat_keepalive_repro: batch=%d scheduled\n", inserted);

	/*
	 * Wait for the worker to drain the full batch and resume from its cursor
	 * before deleting the states.
	 */
	flush_delayed_work(&init_net.xfrm.nat_keepalive_work);

out_delete:
	for (i = 0; i < inserted; i++) {
		int delete_err;

		delete_err = xfrm_state_delete(states[i]);
		xfrm_flush_gc();
		pr_info("xfrm_nat_keepalive_repro: state=%d delete err=%d\n",
			i, delete_err);
	}

	pr_info("xfrm_nat_keepalive_repro: done states=%d err=%d\n",
		inserted, err);
	return err;
}

late_initcall_sync(xfrm_nat_keepalive_repro_init);
------END poc.c--------

----BEGIN crash log----
[   41.304094][    T1] xfrm_nat_keepalive_repro: start
[   41.530471][    T1] 
[   41.537050][    T1] ======================================================
[   41.555194][    T1] WARNING: possible circular locking dependency detected
[   41.572702][    T1] 7.2.0-rc4+ #3 Not tainted
[   41.584948][    T1] ------------------------------------------------------
[   41.599712][    T1] swapper/0/1 is trying to acquire lock:
[   41.611681][    T1] ffffffff989fc058 (&net->xfrm.xfrm_state_lock){+...}-{3:3}, at: __xfrm_state_delete+0xa4/0x9d0
[   41.635229][    T1] 
[   41.635229][    T1] but task is already holding lock:
[   41.650514][    T1] ffff88802fc400c8 (&x->lock){+...}-{3:3}, at: xfrm_state_delete+0x1b/0x40
[   41.668794][    T1] 
[   41.668794][    T1] which lock already depends on the new lock.
[   41.668794][    T1] 
[   41.691060][    T1] 
[   41.691060][    T1] the existing dependency chain (in reverse order) is:
[   41.709677][    T1] 
[   41.709677][    T1] -> #1 (&x->lock){+...}-{3:3}:
[   41.723650][    T1]        _raw_spin_lock+0x2d/0x40
[   41.733642][    T1]        nat_keepalive_work_single+0x15c/0x1bf0
[   41.746997][    T1]        xfrm_state_walk+0x4ed/0xb70
[   41.756907][    T1]        nat_keepalive_work+0xe8/0x1b0
[   41.767928][    T1]        process_one_work+0xa76/0x1d00
[   41.785979][    T1]        worker_thread+0x7d0/0x1150
[   41.796123][    T1]        kthread+0x3e0/0x520
[   41.805116][    T1]        ret_from_fork+0x75b/0xdc0
[   41.814428][    T1]        ret_from_fork_asm+0x11/0x20
[   41.825070][    T1] 
[   41.825070][    T1] -> #0 (&net->xfrm.xfrm_state_lock){+...}-{3:3}:
[   41.841236][    T1]        __lock_acquire+0x1593/0x2670
[   41.851698][    T1]        lock_acquire+0x1a6/0x340
[   41.860785][    T1]        _raw_spin_lock+0x2d/0x40
[   41.871390][    T1]        __xfrm_state_delete+0xa4/0x9d0
[   41.882047][    T1]        xfrm_state_delete+0x23/0x40
[   41.892192][    T1]        xfrm_nat_keepalive_repro_init+0x416/0x5f0
[   41.907172][    T1]        do_one_initcall+0x128/0x760
[   41.918185][    T1]        kernel_init_freeable+0x59a/0x910
[   41.929536][    T1]        kernel_init+0x1d/0x2b0
[   41.938562][    T1]        ret_from_fork+0x75b/0xdc0
[   41.948640][    T1]        ret_from_fork_asm+0x11/0x20
[   41.959169][    T1] 
[   41.959169][    T1] other info that might help us debug this:
[   41.959169][    T1] 
[   41.979263][    T1]  Possible unsafe locking scenario:
[   41.979263][    T1] 
[   41.993335][    T1]        CPU0                    CPU1
[   42.003391][    T1]        ----                    ----
[   42.013882][    T1]   lock(&x->lock);
[   42.021668][    T1]                                lock(&net->xfrm.xfrm_state_lock);
[   42.036907][    T1]                                lock(&x->lock);
[   42.049296][    T1]   lock(&net->xfrm.xfrm_state_lock);
[   42.059119][    T1] 
[   42.059119][    T1]  *** DEADLOCK ***
----BEGIN decoded stack locations----
0xffffffff8a542003
spin_lock
include/linux/spinlock.h:342
__xfrm_state_delete
net/xfrm/xfrm_state.c:819
0xffffffff8a54294a
spin_lock_bh
include/linux/spinlock.h:348
xfrm_state_delete
net/xfrm/xfrm_state.c:856
0xffffffff8bc3b3ac
__raw_spin_lock
include/linux/spinlock_api_smp.h:158 (discriminator 1)
_raw_spin_lock
kernel/locking/spinlock.c:158 (discriminator 1)
0xffffffff8a589e8b
spin_lock
include/linux/spinlock.h:342
nat_keepalive_work_single
net/xfrm/xfrm_nat_keepalive.c:176
0xffffffff8a53ec9c
xfrm_state_walk
net/xfrm/xfrm_state.c:2725
0xffffffff8a589a07
nat_keepalive_work
net/xfrm/xfrm_nat_keepalive.c:211
0xffffffff81869655
process_one_work
kernel/workqueue.c:3322
0xffffffff8186d2ff
process_scheduled_works
kernel/workqueue.c:3405
worker_thread
kernel/workqueue.c:3486
0xffffffff8189307f
kthread
kernel/kthread.c:436
0xffffffff8164ab4a
ret_from_fork
arch/x86/kernel/process.c:158
0xffffffff812c4330
ret_from_fork_asm
arch/x86/entry/entry_64.S:245
0xffffffff819e1782
check_prev_add
kernel/locking/lockdep.c:3165
check_prevs_add
kernel/locking/lockdep.c:3284
validate_chain
kernel/locking/lockdep.c:3908
__lock_acquire
kernel/locking/lockdep.c:5237
0xffffffff819e3235
lock_acquire
kernel/locking/lockdep.c:5868
lock_acquire
kernel/locking/lockdep.c:5825
0xffffffff8a542952
xfrm_state_delete
net/xfrm/xfrm_state.c:857
0xffffffff912af965
xfrm_nat_keepalive_repro_init
net/xfrm/xfrm_nat_keepalive_repro.c:59
0xffffffff812c25c7
do_one_initcall
init/main.c:1347
0xffffffff910fe8e9
do_initcall_level
init/main.c:1409 (discriminator 1)
do_initcalls
init/main.c:1425 (discriminator 1)
do_basic_setup
init/main.c:1445 (discriminator 1)
kernel_init_freeable
init/main.c:1658 (discriminator 1)
0xffffffff8bc1052c
kernel_init
init/main.c:1548
-----END decoded stack locations-----
-----END crash log-----

Best regards,
Zihan Xi

Changes in v3:
  - send an incremental fix on top of ipsec/master as requested by
    Steffen Klassert instead of replacing the queued v1
  - replace v1's unbounded GFP_ATOMIC list with a bounded batch and
    xfrm_state_walk() cursor resume
  - keep the phase-two drain BH-disabled for local_lock_nested_bh()
  - distinguish the template-only userspace command from the actual
    in-kernel validation integration, configuration, build, and boot steps
  - validate 17 concurrent states so the v3 worker fills its 16-entry
    batch and resumes from its cursor
  - recapture the complete original lockdep report and add its full
    batch addr2line mapping from the matching unstripped vmlinux
  - record the validation-kernel user-namespace limitation and the
    separate NETLINK_XFRM EINVAL result instead of implying that the
    template userspace command reproduced the bug
  - identify the crash log as evidence from a separate earlier root-cause
    reproducer revision, not output from the 17-state v3 batch PoC
  - v2 Link: https://lore.kernel.org/all/cover.1785861392.git.zihanx@nebusec.ai/

Changes in v2:
  - reroll on top of net cf6f8b29befb
  - replace the unbounded GFP_ATOMIC state list with a bounded batch
  - keep phase-two processing in BH-disabled context
  - clarify the validation permission model and reproducer scope
  - v1 Link: https://lore.kernel.org/all/cover.1784645321.git.xizh2024@lzu.edu.cn/

Zihan Xi (1):
  xfrm: bound nat keepalive state collection

 net/xfrm/xfrm_nat_keepalive.c | 46 ++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

-- 
2.43.0

