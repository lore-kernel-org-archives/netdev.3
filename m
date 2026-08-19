Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829DE3A83AC
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157941; cv=none; b=Nqeer4hKzlMWnjiyny998zlbUAHU/ZZzHnpn8XeVEgHbSa/cz+1YdujMALs/6DmSOMJlI+WCTLK356Yj63KxmN74qj32S74c4OAWy03w+DoGy6S7hqHcYfk4AVJ9MK9UXB4zOXxsXEs74Re/gWs4a1Isnhe5VgZ4nTNbjVg6bNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157941; c=relaxed/simple;
	bh=5kkmFfH711lNvWXg4V3CAOjWV8XOjMev2w1KKDZXlsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3+ctIf2tk+i6gsVIkOO/WgaY6+7+gt5vuZOoAQuslCamtBlAEchSweU7QgtkWtS1MqEPcIXzfc+U5Y2DPGioAPZ4hElUUVgFrGF14w017y+SLqFtwH+N7p0MX+Bv3pvh9wTBnt/vvN5HkBkiwuHFu15AtsaDRh3A6fsMNEAeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=wusquMty; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="wusquMty"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1199860a91.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1787157936; x=1787762736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6+F0JPBSt9cKGf5XJ12jNBccdDX6ARMkXNsOHsmOWPY=;
        b=wusquMtym549WLxktc+j6NwHlj53vGD4ag5CybmrgJPCjsjM34hgnoyduToUEoYl4t
         fIntbKH5NshFQsPKvkfQl6lt1a7Jt5d2GKWudK50fC0TCmJHr61YiQbBdyVwvvqEWwPE
         jQNL/LcmneDXH9Pb3ZlfX8rrSfI9dq4v/TOpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157936; x=1787762736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6+F0JPBSt9cKGf5XJ12jNBccdDX6ARMkXNsOHsmOWPY=;
        b=URh7HS7mxQ/vbpCEdcIY8o5QPof0RY4IWyPmfg9U1PMJplk5tR5J2pHRCHxSwm7V6P
         IKOKA+IP8JT/jmynrkoE/GhajaS5s/JK8CF0VoWOJGrUxUHkdN9FVRIR4qFlZMKmvhru
         x3VDP+pdpl6IHXRLo12V/EAPIz3V4Ss7httohTqGlwblFxkrtvW6+q8CxSaROktJLNoj
         wumXK+2hW1b8YHU//R8k2Zx4ZdhD0V3TPx3Ltc7Y/c+Utw3Qj8W4UT9xmLSwCJ7H+FyV
         NDiuPgH85SEOm7G81nmxQTA4q7reIffMxsNdFrUQKBftFU7fZlgnnpjNYXdfLOZUNuur
         G5sA==
X-Forwarded-Encrypted: i=1; AHgh+Rq02rtPUypXy+atiWhUnBI70x0axCC0Dmcu8czWXeZ0eCDzs5T+PkoLQFJ4gSNnrTxK+SUHkgs=@vger.kernel.org
X-Gm-Message-State: AFuF++nBmVsT5dK3p2r8Ea1cbrjtUUtZWw5XE/kNR0Y0w9f4HjhJ9rVI
	bXwNVMlJPK9bvBO2PcZWDrP4/Hqi+O4Bz5P8BXMClW5aX3MXgxWBg6oCtXac3rGnMUg=
X-Gm-Gg: AR+sD11f+1j2+jGT0Ws39jyiLPNzk0W0Px1BkA85ZjgtZxYMsZvDpMNViDiOj4fLY1O
	mdS+V+wjR/4qptP5l1cQT9W5dWW9dBDhix0Wrvrp8z5CtddL20N5EeWYxit9luaiAjHdBatJrh9
	TaejgMEXIDFPQwz9PwKOCPiH6gS7I9hGYbhE/GLyzVbXujOCC4QOqSvULB4G95X19CCEBBaT2sL
	ow2EPnqTi0Hbq3vosTz6lCn7cOTm3LiyjqZ6MkGfmMmN3/MmdGgeWfgWvDgyj6RE5PzI0tha1Ra
	QoAyHjT4tGtzJD4IR2kFvnEHE/Pynwqjw4OVphbyqzbFtptCM1liTRH9H1rSGRvStMNSO9JACPX
	Ugd7kbgVKKff9Uyv7yBXDJNz6u895VVuKw6eXTNMf9r0Ok3BXN9PK+lfYMjn+L+eANGPzWN+dBs
	I9xslOfyNTy1r7XnpyoIpsY6IVBz6UivQOucq/I9E7CyNIM5Omw0GUZqO2RORTtJrk4/yXMzPA8
	qo1kQs35OV4yZ1jFIMOj7G+tbXd1lcX3iAFrxypXSTSGQkYP0IFX4kFt90q6fWAQr2wrmeYK3+t
	O7nWmovzTxSvNj+VFNlOts/Bg5rrDCPTyBvXoxhPzTb16ejoXz6EPw==
X-Received: by 2002:a17:90b:50c5:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-3958125af57mr11445852a91.1.1787157935515;
        Wed, 19 Aug 2026 09:45:35 -0700 (PDT)
Received: from leesin ([147.46.121.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f875f38sm1445522a91.4.2026.08.19.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:45:34 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	eulgyukim@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] KASAN: slab-use-after-free Read in __ip_append_data
Date: Thu, 20 Aug 2026 01:45:25 +0900
Message-ID: <20260819164528.3761320-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We found a "KASAN: slab-use-after-free Read in __ip_append_data" on Linux v7.2.
The issue was found by our own race fuzzer. We have not analyzed the root cause,
so we do not have a proposed fix to offer.

To reproduce the race reliably, we applied the delay patch below to the
kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
crash log we observed, the delay patch and the reproducer are all included
below.

The following kernel config options are required to reproduce the issue:
	CONFIG_NET=y
    CONFIG_INET=y
    CONFIG_UNIX=y
    CONFIG_DUMMY=y
	CONFIG_KASAN=y

We hope this report is useful. Please let us know if any further
information would help.

Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Kernel delay patch:
==================================================================
diff --git a/net/core/dev.c b/net/core/dev.c
index ece6700536d9..bd4c5e74bd71 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11746,6 +11746,9 @@ void netdev_run_todo(void)
 		WARN_ON(rcu_access_pointer(dev->ip_ptr));
 		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
 
+		if (!strncmp(current->comm, "syzrepro1", 9)) {
+			mdelay(1);
+		}
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 		netdev_do_free_pcpu_stats(dev);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e6dd1e5b8c32..5e192d354dbd 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -47,6 +47,8 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -946,6 +948,7 @@ ip_generic_getfrag(void *from, char *to, int offset, int len, int odd, struct sk
 }
 EXPORT_SYMBOL(ip_generic_getfrag);
 
+static unsigned long syz_rg_bh_rt;
 static int __ip_append_data(struct sock *sk,
 			    struct flowi4 *fl4,
 			    struct sk_buff_head *queue,
@@ -980,6 +983,12 @@ static int __ip_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
 	paged = !!cork->gso_size;
 
+	if (rt->dst.dev == blackhole_netdev &&
+	    syz_rg_bh_rt != (unsigned long)rt &&
+	    !strncmp(current->comm, "syzrepro", 8)) {
+		syz_rg_bh_rt = (unsigned long)rt;
+		mdelay(1);
+	}
 	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
 
 	fragheaderlen = sizeof(struct iphdr) + (opt ? opt->optlen : 0);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b82401a6baed..3a45217c5166 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -63,6 +63,8 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
 #include <linux/socket.h>
@@ -1592,6 +1594,9 @@ void rt_flush_dev(struct net_device *dev)
 		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
 			if (rt->dst.dev != dev)
 				continue;
+			if (!strncmp(current->comm, "syzrepro1", 9)) {
+				mdelay(10);
+			}
 			rt->dst.dev = blackhole_netdev;
 			netdev_ref_replace(dev, blackhole_netdev,
 					   &rt->dst.dev_tracker, GFP_ATOMIC);

==================================================================

C reproducer:
==================================================================
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/if.h>
#include <linux/if_link.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <pthread.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <sys/socket.h>
#include <time.h>
#include <unistd.h>

#define SYSCHK(x) ({ long __r = (long)(x); if (__r == -1L) { perror(#x); exit(1); } __r; })

#define DEVNAME   "syzdev0"
#define DEVADDR   "172.20.20.100"
#define MCAST_DST "224.0.0.1"
#define NL_BUFSZ  512
#define BURST_NS  (90ULL * 1000 * 1000)
#define GAP_NS    (15ULL * 1000 * 1000)
#define MSGS      16
#define CALLS     256

struct thread_arg { const char *name; int cpu; };

static volatile int stop;

static unsigned long long now_ns(void)
{
	struct timespec ts;

	clock_gettime(CLOCK_MONOTONIC, &ts);
	return (unsigned long long)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
}

static void name_and_pin(const char *n, int cpu)
{
	cpu_set_t set;

	prctl(PR_SET_NAME, n, 0, 0, 0);
	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	sched_setaffinity(0, sizeof(set), &set);
}

static void addattr(struct nlmsghdr *nlh, int type, const void *data, size_t dlen)
{
	size_t len = RTA_LENGTH(dlen);
	struct rtattr *rta = (struct rtattr *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));

	rta->rta_type = type;
	rta->rta_len = len;
	if (dlen)
		memcpy(RTA_DATA(rta), data, dlen);
	nlh->nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len);
}

static int nl_open(void)
{
	struct sockaddr_nl local;
	int fd = SYSCHK(socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE));

	memset(&local, 0, sizeof(local));
	local.nl_family = AF_NETLINK;
	SYSCHK(bind(fd, (struct sockaddr *)&local, sizeof(local)));
	return fd;
}

static int nl_talk(int fd, struct nlmsghdr *nlh)
{
	struct sockaddr_nl kernel;
	struct iovec iov = { nlh, nlh->nlmsg_len };
	struct msghdr msg;
	char rsp[4096];
	int left;
	ssize_t n;

	memset(&kernel, 0, sizeof(kernel));
	kernel.nl_family = AF_NETLINK;
	memset(&msg, 0, sizeof(msg));
	msg.msg_name = &kernel;
	msg.msg_namelen = sizeof(kernel);
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;

	if (sendmsg(fd, &msg, 0) < 0)
		return -errno;
	n = recv(fd, rsp, sizeof(rsp), 0);
	if (n < 0)
		return -errno;
	left = n;
	for (nlh = (struct nlmsghdr *)rsp; NLMSG_OK(nlh, left);
	     nlh = NLMSG_NEXT(nlh, left))
		if (nlh->nlmsg_type == NLMSG_ERROR)
			return ((struct nlmsgerr *)NLMSG_DATA(nlh))->error;
	return -EPROTO;
}

static void init_nlmsg(struct nlmsghdr *nlh, unsigned type, unsigned flags, size_t payload)
{
	static unsigned seq = 1;

	memset(nlh, 0, NL_BUFSZ);
	nlh->nlmsg_len = NLMSG_LENGTH(payload);
	nlh->nlmsg_type = type;
	nlh->nlmsg_flags = flags;
	nlh->nlmsg_seq = seq++;
}

static int link_add(int fd)
{
	char req[NL_BUFSZ];
	struct nlmsghdr *nlh = (struct nlmsghdr *)req;
	struct ifinfomsg *ifi;
	struct rtattr *nest;

	init_nlmsg(nlh, RTM_NEWLINK,
		   NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL, sizeof(*ifi));
	ifi = NLMSG_DATA(nlh);
	ifi->ifi_family = AF_UNSPEC;
	addattr(nlh, IFLA_IFNAME, DEVNAME, sizeof(DEVNAME));
	nest = (struct rtattr *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));
	addattr(nlh, IFLA_LINKINFO, NULL, 0);
	addattr(nlh, IFLA_INFO_KIND, "dummy", sizeof("dummy"));
	nest->rta_len = (char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len) - (char *)nest;
	return nl_talk(fd, nlh);
}

static int link_set(int fd, unsigned type, int idx, int up)
{
	char req[NL_BUFSZ];
	struct nlmsghdr *nlh = (struct nlmsghdr *)req;
	struct ifinfomsg *ifi;

	init_nlmsg(nlh, type, NLM_F_REQUEST | NLM_F_ACK, sizeof(*ifi));
	ifi = NLMSG_DATA(nlh);
	ifi->ifi_family = AF_UNSPEC;
	ifi->ifi_index = idx;
	if (up) {
		ifi->ifi_flags = IFF_UP;
		ifi->ifi_change = IFF_UP;
	}
	return nl_talk(fd, nlh);
}

static int addr_add(int fd, int idx)
{
	char req[NL_BUFSZ];
	struct nlmsghdr *nlh = (struct nlmsghdr *)req;
	struct ifaddrmsg *ifa;
	unsigned addr = inet_addr(DEVADDR);

	init_nlmsg(nlh, RTM_NEWADDR,
		   NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL, sizeof(*ifa));
	ifa = NLMSG_DATA(nlh);
	ifa->ifa_family = AF_INET;
	ifa->ifa_prefixlen = 24;
	ifa->ifa_index = idx;
	addattr(nlh, IFA_LOCAL, &addr, sizeof(addr));
	addattr(nlh, IFA_ADDRESS, &addr, sizeof(addr));
	return nl_talk(fd, nlh);
}

static int get_ifindex(int sock)
{
	struct ifreq ifr;

	memset(&ifr, 0, sizeof(ifr));
	strncpy(ifr.ifr_name, DEVNAME, IFNAMSIZ - 1);
	if (ioctl(sock, SIOCGIFINDEX, &ifr) < 0)
		return -1;
	return ifr.ifr_ifindex;
}

static int device_setup(int nl, int hs)
{
	int idx;

	link_add(nl);
	idx = get_ifindex(hs);
	if (idx <= 0)
		return -1;
	addr_add(nl, idx);
	link_set(nl, RTM_NEWLINK, idx, 1);
	return idx;
}

static void *victim_thread(void *p)
{
	struct thread_arg *a = p;
	struct sockaddr_in src, dst;
	struct mmsghdr mv[MSGS];
	struct iovec iov;
	char payload[8];
	int i, fd, k;

	name_and_pin(a->name, a->cpu);

	memset(payload, 0x41, sizeof(payload));
	iov.iov_base = payload;
	iov.iov_len = sizeof(payload);

	memset(&src, 0, sizeof(src));
	src.sin_family = AF_INET;
	src.sin_addr.s_addr = inet_addr(DEVADDR);

	memset(&dst, 0, sizeof(dst));
	dst.sin_family = AF_INET;
	dst.sin_port = htons(20000);
	dst.sin_addr.s_addr = inet_addr(MCAST_DST);

	memset(mv, 0, sizeof(mv));
	for (i = 0; i < MSGS; i++) {
		mv[i].msg_hdr.msg_name = &dst;
		mv[i].msg_hdr.msg_namelen = sizeof(dst);
		mv[i].msg_hdr.msg_iov = &iov;
		mv[i].msg_hdr.msg_iovlen = 1;
	}

	while (!stop) {
		fd = socket(AF_INET, SOCK_DGRAM, 0);
		if (fd < 0) {
			usleep(2000);
			continue;
		}
		if (bind(fd, (struct sockaddr *)&src, sizeof(src)) < 0) {
			close(fd);
			usleep(1000);
			continue;
		}
		for (k = 0; k < CALLS && !stop; k++)
			if (sendmmsg(fd, mv, MSGS,
				     MSG_MORE | MSG_NOSIGNAL | MSG_DONTWAIT) < 0 &&
			    (errno == ENETUNREACH || errno == EPERM ||
			     errno == EINVAL || errno == EADDRNOTAVAIL))
				break;
		close(fd);
	}
	return NULL;
}

static void *killer_thread(void *p)
{
	int nl, hs, idx;

	name_and_pin("syzrepro1", 0);
	nl = nl_open();
	hs = SYSCHK(socket(AF_INET, SOCK_DGRAM, 0));

	while (!stop) {
		idx = get_ifindex(hs);
		if (idx > 0)
			link_set(nl, RTM_DELLINK, idx, 0);
		device_setup(nl, hs);
		usleep(2000);
	}
	close(nl);
	close(hs);
	return NULL;
}

static void *preemptor_thread(void *p)
{
	struct thread_arg *a = p;
	struct sched_param sp = { .sched_priority = 50 };
	struct timespec gap = { 0, GAP_NS };
	unsigned long long t0;

	name_and_pin(a->name, a->cpu);
	sched_setscheduler(0, SCHED_FIFO, &sp);

	while (!stop) {
		t0 = now_ns();
		while (now_ns() - t0 < BURST_NS && !stop)
			;
		nanosleep(&gap, NULL);
	}
	return NULL;
}

int main(void)
{
	static struct thread_arg va0 = { "syzrepro0", 1 };
	static struct thread_arg va2 = { "syzrepro2", 1 };
	static struct thread_arg va3 = { "syzrepro3", 2 };
	static struct thread_arg va4 = { "syzrepro4", 2 };
	pthread_t t_v0, t_v3, t_k, t_p2, t_p4;
	int nl, hs;

	prctl(PR_SET_NAME, "syzmain", 0, 0, 0);

	nl = nl_open();
	hs = SYSCHK(socket(AF_INET, SOCK_DGRAM, 0));
	if (device_setup(nl, hs) <= 0)
		SYSCHK(-1);

	pthread_create(&t_p2, NULL, preemptor_thread, &va2);
	pthread_create(&t_p4, NULL, preemptor_thread, &va4);
	pthread_create(&t_v0, NULL, victim_thread, &va0);
	pthread_create(&t_v3, NULL, victim_thread, &va3);
	pthread_create(&t_k, NULL, killer_thread, NULL);

	sleep(900);
	stop = 1;

	pthread_join(t_v0, NULL);
	pthread_join(t_v3, NULL);
	pthread_join(t_k, NULL);
	pthread_join(t_p2, NULL);
	pthread_join(t_p4, NULL);
	close(nl);
	close(hs);
	return 0;
}
==================================================================

Crash log:
==================================================================
BUG: KASAN: slab-use-after-free in __ip_append_data+0xed5/0x35a0 net/ipv4/ip_output.c:992
Read of size 2 at addr ffff888104ec803c by task syzrepro0/405

CPU: 1 UID: 0 PID: 405 Comm: syzrepro0 Not tainted 7.2.0-dirty #1 PREEMPT 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5e/0x80 lib/dump_stack.c:120
 print_address_description+0x77/0x200 mm/kasan/report.c:378
 print_report+0x64/0x70 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __ip_append_data+0xed5/0x35a0 net/ipv4/ip_output.c:992
 ip_append_data+0xd5/0x170 net/ipv4/ip_output.c:1385
 udp_sendmsg+0x240/0x1bb0 net/ipv4/udp.c:1469
 sock_sendmsg_nosec+0x11c/0x160 net/socket.c:775
 ____sys_sendmsg+0x4cf/0x660 net/socket.c:2681
 ___sys_sendmsg+0x15e/0x1a0 net/socket.c:2738
 __sys_sendmmsg+0x167/0x230 net/socket.c:2827
 __do_sys_sendmmsg net/socket.c:2854 [inline]
 __se_sys_sendmmsg net/socket.c:2851 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2851
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7d012f970106
Code: 10 89 7c 24 0c 89 4c 24 1c e8 36 a7 f7 ff 44 8b 54 24 1c 8b 54 24 18 41 89 c0 48 8b 74 24 10 8b 7c 24 0c b8 33 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 32 44 89 c7 89 44 24 0c e8 86 a7 f7 ff 8b 44
RSP: 002b:00007d012e85ea40 EFLAGS: 00000293 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 000000000000001f RCX: 00007d012f970106
RDX: 0000000000000010 RSI: 00007d012e85eaa0 RDI: 0000000000000008
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000c040 R11: 0000000000000293 R12: 00007d012e85eaa0
R13: 00007d012e85ea80 R14: 00007ffd2852a1c0 R15: 00007d012e05f000
 </TASK>

Allocated by task 407:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kvmalloc_node_noprof+0x36a/0x620 mm/slub.c:6905
 alloc_netdev_mqs+0x8c/0x1170 net/core/dev.c:12062
 rtnl_create_link+0x3ac/0xc00 net/core/rtnetlink.c:3721
 rtnl_newlink_create+0x1ca/0x820 net/core/rtnetlink.c:3903
 __rtnl_newlink net/core/rtnetlink.c:4044 [inline]
 rtnl_newlink+0x13ce/0x1740 net/core/rtnetlink.c:4159
 rtnetlink_rcv_msg+0x616/0x720 net/core/rtnetlink.c:7076
 netlink_rcv_skb+0x168/0x310 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x652/0x880 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x5a1/0x870 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg+0x18f/0x1a0 net/socket.c:790
 ____sys_sendmsg+0x468/0x660 net/socket.c:2684
 ___sys_sendmsg+0x15e/0x1a0 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x11e/0x170 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 407:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x3a/0x60 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x16c/0x3e0 mm/slub.c:6692
 device_release+0xbc/0x1b0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x142/0x1c0 lib/kobject.c:737
 netdev_run_todo+0x392/0x10e0 net/core/dev.c:11763
 rtnl_unlock net/core/rtnetlink.c:157 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:135 [inline]
 rtnl_dellink+0x4a2/0x610 net/core/rtnetlink.c:3651
 rtnetlink_rcv_msg+0x616/0x720 net/core/rtnetlink.c:7076
 netlink_rcv_skb+0x168/0x310 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x652/0x880 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x5a1/0x870 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:775 [inline]
 __sock_sendmsg+0x18f/0x1a0 net/socket.c:790
 ____sys_sendmsg+0x468/0x660 net/socket.c:2684
 ___sys_sendmsg+0x15e/0x1a0 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x11e/0x170 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff888104ec8000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 60 bytes inside of
 freed 4096-byte region [ffff888104ec8000, ffff888104ec9000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x104ec8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888104ec9011
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff88810004a280 dead000000000100 dead000000000122
raw: 0000000000000000 0000200000040004 00000000f5000000 ffff888104ec9011
head: 0200000000000040 ffff88810004a280 dead000000000100 dead000000000122
head: 0000000000000000 0000200000040004 00000000f5000000 ffff888104ec9011
head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888104ec7f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888104ec7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888104ec8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888104ec8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888104ec8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


