Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212BC43E9DF
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184718; cv=none; b=dL3nUCBFF7oSbExEObEtIRaTQFizwtgcIKrPb1VCi5GRicItdbGv1JmWVQ4TGO+tx/29218XtKg7a4+P9wCWf4oLIcJXq0MydkJv+XN97kNELzRiCTIW7jmHwQynDXVpOz/8XMRj7pLah9DGmu6xrhd4khy9eGLPeWuwiqcpwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184718; c=relaxed/simple;
	bh=kO2SBoM2HduBCZ3G0ah2IKvrGIVMIfvdAP978Lx5kGE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D3kXNx/DUVE1PMqtIbay2fnVLm9lKELTjp/ORg8rFi2W9pQT1Cssj/tS4nNYfamgKpbm1wz+Kdp0i2DAuXfoG7KfaxdgQE7/YzHKtOq6lVD6lUS8DhwNk3gr+eCQ+hBiTlXtUp6I81r8HQeoiO7absOeX9Fk4nU4k5jaE02dnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a49b13b745so1175337b6e.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788184715; x=1788789515;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+9Q4JXycgzP9TNr6JE85S6uw2DVBsKh+VrvMswmCjDw=;
        b=ZsSYvg6wnhKiviDLbW3gY9xWbn0a1dBth60r64Rs6RnWW8HQuKvwHaDPm/CuaOx5uA
         g3WgTffAuM5UqarhHRtbc0k8lk82ISV3VBKdQ4BUhRV918ZuWaR/x11xb+GsKIv3JmT5
         QI7WAAkd+4dl6PLvGyk/ntcvTfWZAOLOYwpT0EVRRzgnqeuQY0tlo3ioTZE1/iffHD7r
         WBvW2UxE32q2Mjmy6lajW5GeOrlvQvRcNS9NcWsQ53NeuIeAjalpid4MUQYbqAUUBOaP
         KhElmuUUZGVVwFp/GZw5sfw3f+k9gXF/7k+8+tPCzYzCKTPCzVT4OQwxASMdUqw6C/Kr
         ctOA==
X-Forwarded-Encrypted: i=1; AHgh+RqkWxaMG/zeBlOYOpcj3n04RpXupBGKpMX+vo0zG1Od2YuVHic3jaDSmPfYsPF695VbQii50Lc=@vger.kernel.org
X-Gm-Message-State: AFuF++lBnKO/Z/i41ypdUXIZHJ8xugCZA31Jtx26Yd9dYBxsDl2MbmaL
	k67ByklYkI3NjRZq/p6sWybk855UliHOxzChtHZD4VjiHDALbNC307f3B8dyrOOrTF5bgdnKugY
	1C1OrsIQW5c+OhYybzJ6sPSFDAEKwYjf3TESLvFtFmwkKP/kWCb+ae7YGbYU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1520:b0:4a3:26e5:cc02 with SMTP id
 5614622812f47-4b5b824192emr1048981b6e.10.1788184715060; Mon, 31 Aug 2026
 06:58:35 -0700 (PDT)
Date: Mon, 31 Aug 2026 06:58:35 -0700
In-Reply-To: <0000000000009767ec0619fe6a1d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a95888b.4d659fcc.734b4.0051.GAE@google.com>
Subject: Re: [syzbot] [net?] UBSAN: array-index-out-of-bounds in
 llc_conn_state_process (2)
From: syzbot <syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com>
To: contact.kartikn@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kees@kernel.org, krzk@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f1b8fa82cab7 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1092e379580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1128bc53f2ef7f3
dashboard link: https://syzkaller.appspot.com/bug?extid=628f93722c08dc5aabe0
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14407e25580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1492e379580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/932d85a2bda2/disk-f1b8fa82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b6b8fb76e8d/vmlinux-f1b8fa82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c246b61ee396/Image-f1b8fa82.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in llc_qualify_conn_ev net/llc/llc_conn.c:394 [inline]
BUG: KASAN: global-out-of-bounds in llc_conn_service net/llc/llc_conn.c:360 [inline]
BUG: KASAN: global-out-of-bounds in llc_conn_state_process+0xe0/0x115c net/llc/llc_conn.c:66
Read of size 8 at addr ffff800089e50078 by task syz.0.17/4975

CPU: 1 UID: 0 PID: 4975 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xb0/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0x8c/0xc4 mm/kasan/report.c:595
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 llc_qualify_conn_ev net/llc/llc_conn.c:394 [inline]
 llc_conn_service net/llc/llc_conn.c:360 [inline]
 llc_conn_state_process+0xe0/0x115c net/llc/llc_conn.c:66
 llc_conn_rcv net/llc/llc_conn.c:750 [inline]
 llc_conn_handler+0x560/0xca4 net/llc/llc_conn.c:817
 llc_rcv+0x580/0xaa0 net/llc/llc_input.c:206
 __netif_receive_skb_list_ptype net/core/dev.c:6264 [inline]
 __netif_receive_skb_list_core+0x60c/0x67c net/core/dev.c:6306
 __netif_receive_skb_list net/core/dev.c:6358 [inline]
 netif_receive_skb_list_internal+0x748/0xa0c net/core/dev.c:6449
 netif_receive_skb_list+0x70/0x818 net/core/dev.c:6501
 xdp_recv_frames net/bpf/test_run.c:268 [inline]
 xdp_test_run_batch net/bpf/test_run.c:349 [inline]
 bpf_test_run_xdp_live+0x1434/0x1770 net/bpf/test_run.c:378
 bpf_prog_test_run_xdp+0x634/0xe0c net/bpf/test_run.c:1463
 bpf_prog_test_run+0x1e0/0x250 kernel/bpf/syscall.c:4859
 __sys_bpf+0x6bc/0x82c kernel/bpf/syscall.c:6436
 __do_sys_bpf kernel/bpf/syscall.c:6537 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6534 [inline]
 __arm64_sys_bpf+0xd0/0xec kernel/bpf/syscall.c:6534
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590

The buggy address belongs to the variable:
 llc_temp_state_transitions+0x58/0x60

The buggy address belongs to a vmalloc virtual mapping
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21c450
flags: 0x5ffc00000002000(reserved|node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000002000 fffffdffc7711408 fffffdffc7711408 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff800089e4ff00: 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
 ffff800089e4ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9
>ffff800089e50000: f9 f9 f9 f9 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
                                                                ^
 ffff800089e50080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff800089e50100: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 00
==================================================================
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/llc/llc_conn.c:681:8
index -1 is out of range for type 'int[12][5]'
CPU: 1 UID: 0 PID: 4975 Comm: syz.0.17 Tainted: G    B               syzkaller #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 ubsan_epilogue+0x14/0x48 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xd0/0xf8 lib/ubsan.c:455
 llc_find_offset net/llc/llc_conn.c:681 [inline]
 llc_qualify_conn_ev net/llc/llc_conn.c:395 [inline]
 llc_conn_service net/llc/llc_conn.c:360 [inline]
 llc_conn_state_process+0xf64/0x115c net/llc/llc_conn.c:66
 llc_conn_rcv net/llc/llc_conn.c:750 [inline]
 llc_conn_handler+0x560/0xca4 net/llc/llc_conn.c:817
 llc_rcv+0x580/0xaa0 net/llc/llc_input.c:206
 __netif_receive_skb_list_ptype net/core/dev.c:6264 [inline]
 __netif_receive_skb_list_core+0x60c/0x67c net/core/dev.c:6306
 __netif_receive_skb_list net/core/dev.c:6358 [inline]
 netif_receive_skb_list_internal+0x748/0xa0c net/core/dev.c:6449
 netif_receive_skb_list+0x70/0x818 net/core/dev.c:6501
 xdp_recv_frames net/bpf/test_run.c:268 [inline]
 xdp_test_run_batch net/bpf/test_run.c:349 [inline]
 bpf_test_run_xdp_live+0x1434/0x1770 net/bpf/test_run.c:378
 bpf_prog_test_run_xdp+0x634/0xe0c net/bpf/test_run.c:1463
 bpf_prog_test_run+0x1e0/0x250 kernel/bpf/syscall.c:4859
 __sys_bpf+0x6bc/0x82c kernel/bpf/syscall.c:6436
 __do_sys_bpf kernel/bpf/syscall.c:6537 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6534 [inline]
 __arm64_sys_bpf+0xd0/0xec kernel/bpf/syscall.c:6534
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590
---[ end trace ]---
Unable to handle kernel paging request at virtual address dfff800000000000
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
[dfff800000000000] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 4975 Comm: syz.0.17 Tainted: G    B               syzkaller #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/07/2026
pstate: 03400005 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : llc_qualify_conn_ev net/llc/llc_conn.c:396 [inline]
pc : llc_conn_service net/llc/llc_conn.c:360 [inline]
pc : llc_conn_state_process+0x260/0x115c net/llc/llc_conn.c:66
lr : llc_find_offset net/llc/llc_conn.c:681 [inline]
lr : llc_qualify_conn_ev net/llc/llc_conn.c:395 [inline]
lr : llc_conn_service net/llc/llc_conn.c:360 [inline]
lr : llc_conn_state_process+0x194/0x115c net/llc/llc_conn.c:66
sp : ffff800096017020
x29: ffff800096017040 x28: ffff0000ed434000 x27: ffff0000c735702e
x26: dfff800000000000 x25: dfff800000000000 x24: 0000000000000000
x23: 0000000000000004 x22: 0000000000000000 x21: ffff0000ed434000
x20: ffff0000c7357028 x19: ffff0000c7357000 x18: 00000000ffffffff
x17: 3d3d3d3d3d3d3d3d x16: 0000000000000001 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000004
x11: ffff700011467668 x10: ffff700011467668 x9 : ffff80008e879940
x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff80008048c60c
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000020
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 llc_qualify_conn_ev net/llc/llc_conn.c:396 [inline] (P)
 llc_conn_service net/llc/llc_conn.c:360 [inline] (P)
 llc_conn_state_process+0x260/0x115c net/llc/llc_conn.c:66 (P)
 llc_conn_rcv net/llc/llc_conn.c:750 [inline]
 llc_conn_handler+0x560/0xca4 net/llc/llc_conn.c:817
 llc_rcv+0x580/0xaa0 net/llc/llc_input.c:206
 __netif_receive_skb_list_ptype net/core/dev.c:6264 [inline]
 __netif_receive_skb_list_core+0x60c/0x67c net/core/dev.c:6306
 __netif_receive_skb_list net/core/dev.c:6358 [inline]
 netif_receive_skb_list_internal+0x748/0xa0c net/core/dev.c:6449
 netif_receive_skb_list+0x70/0x818 net/core/dev.c:6501
 xdp_recv_frames net/bpf/test_run.c:268 [inline]
 xdp_test_run_batch net/bpf/test_run.c:349 [inline]
 bpf_test_run_xdp_live+0x1434/0x1770 net/bpf/test_run.c:378
 bpf_prog_test_run_xdp+0x634/0xe0c net/bpf/test_run.c:1463
 bpf_prog_test_run+0x1e0/0x250 kernel/bpf/syscall.c:4859
 __sys_bpf+0x6bc/0x82c kernel/bpf/syscall.c:6436
 __do_sys_bpf kernel/bpf/syscall.c:6537 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6534 [inline]
 __arm64_sys_bpf+0xd0/0xec kernel/bpf/syscall.c:6534
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:590
Code: 35006148 b94002c8 8b28cf16 d343fec8 (387a6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	35006148 	cbnz	w8, 0xc28
   4:	b94002c8 	ldr	w8, [x22]
   8:	8b28cf16 	add	x22, x24, w8, sxtw #3
   c:	d343fec8 	lsr	x8, x22, #3
* 10:	387a6908 	ldrb	w8, [x8, x26] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
