Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496759;
	b=NR9O2/wk5JFn5f5bE9Yt8Gho92EQmIMUfKkgiNfWVpD4BuM7o0n68Mt4f5QukxH3TmdJ
	 f4QZai9+46P6SQk6jjUVLnPR+fFrYMEHdoQ3jdLP9rkRKTCfkNVW69PjFb0Ap8NzrZfBG
	 B4wl6qN/zUYhxk+gyUggjnxPfi04GqZSSWHyg1DLc3Ts2FrcbUq86MsIwMLZU3Czd4kVh
	 EGCUQGxLybscBwCmtfXvz7fsafGj3GSUi40svL0M6Duqkl0FLNFaKpz5/y+EsJjtiuStw
	 MRy/aeFgGeZX7uLZ+neJcfj0RB6uUx7T3B1RuORmbLZT7UXayOhZFJGYuiymV31MOlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bVz0nCc5afIp7yKYzKmpM0hWVwwb4Yybj240J3meRN8=;
	b=X8nsCaepXGl3aPPL8QkUEPiABi0gcnCsZS28yzNX3GJr03Y6msbhfVN/jcmwJmbcPKst
	 B8kDCqI461JkXhksbl8rVk2dYlTKoV5IgeDIEPet2MhqFFTELDySQcGhPBbMq0R+CoeVV
	 GspRA/cmrtz424ZLZKbshfII+lru4G+FNpDpkoWvIhvyxEnAoQc07TanjJcRVYcxdRzrg
	 6TpTO2zJ+TqxI+BwDWbGEt4GwjFv3r6aKOycFkG2mhrSfoYj3uuR3Prj+uADFGHJ0vSUN
	 NLG0YJ09fT4df6RDKSql1v2J+v6quFSw6lnIXdkgUSCswGWa/WRD3r/sftNIHDSZ3rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=FJqELn3T;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4060A2607
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B4060A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=FJqELn3T
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so2643815b3a.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 07:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794496758; x=1795101558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bVz0nCc5afIp7yKYzKmpM0hWVwwb4Yybj240J3meRN8=;
        b=FJqELn3TjjgzCRHB5Tv9ZsBsWhZZ44T7kd+peGbjRQrm8v+y+H4L98I1kRshx+zt+D
         zlppWgtef6feCKNfqB1TqZdZWq1rx1QBvvK2Njv+jQ52/SEM3DWBSAS3FCj3BaiEegjC
         FyTTZbe1g+VdJoFHUye+w+7ueJPlnY96vN1kaIcgEWMBEt+tWYvvDKCG+CDEHyComunu
         mTxGXnwPfHaZeL9kbdkiPBSGZDyYBaC2cUMw3R9wL+MTS0YLwNPzLHUgQgMn5m61sTwf
         xDsp5rPgJY/Mh1DbFw5h6OYqQboLKg2f0YIvXEsPPtYxcN1c7koZCc3IeWxjt3Guudgd
         UTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496758; x=1795101558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bVz0nCc5afIp7yKYzKmpM0hWVwwb4Yybj240J3meRN8=;
        b=w1ExXloKsh2OPJo8xIKoalyxZw2RjLJG749jTlJpgtg86zPU2unhycCQEY90pUoMri
         81AIXK79nj2tJ+EQx6VhL/HsLxMUiuA2rGwB8jTh93rN2NikYfGtE/gs/IKNdbWwFa39
         YCtekyvPXeMEqFPEr2PlbWREAkuvHvIIu0SYkf5Z/NoUbgTJ57x9hUb8HxdcDZLOelCq
         nYD3kNS/tR8cQBAO44aHlDM2Y5H/ALAE6mt1jBl8agM5LZ9hdSpwzrKG0p2p739Mqt8z
         S5aFyh0h/Y9VaiXpzVJ/fnpouJbb1gChy+eYsOqi+DQdBW0xMchC6oEXmwTz/hMO+TwP
         WJHg==
X-Gm-Message-State: APuU4Z/20tgOVQYYryLN7MkMPs96u2uwBZdOOtZQUqzOWdTh5x3Gb/XP
	T/2lVoQTotHDAm9bxF89Ng1voN4OSPr4VDhJPf6gEk3JMNu7eyie8r7XWL39fmKBiLx9dVPAHWZ
	FKLbzdEbP
X-Gm-Gg: AYBFou0Obof/kuxNT77lHPNBpzGcn66GNoIiiUZDI/BBD0l5GuU142XAbq/cU2AriI0
	4eACZRS9J8AwmrBVUXEz9Qc0yy/+L7DfTjLumwI147BqYUNp6E3SPVXOIsn7ITHGmWITSLJQPnM
	t6C9uoKLXupA0Y15urEgodtkTr609xUJq2EFfuVO7IJLfHvQEEwGq2ag5tb5y6clxHvJmhpwsmp
	x+uQ2HeH9dTENaFhrX7MKEg9+qtcMz9LmG265c1DZNNTVUls/IPS9tGK+PMguViCLqoG90164iI
	Y7BoogEkZTuDy77D8cj0qpHDZQLlTIQZw8BaZaYEmMkUIMFm/yKsDL0ptD6TMHo53fYRJIsPRXo
	lgy4zjlia3Sm71s6T3dFPp9158kwn+sc1ZLL9vHBFmk2e2Y3sYMxi2J0mKHfmkikSkstMJmDnvs
	EUL6V6PmrWY82Ir0q4C6+xzKc+C3v0xPwEOzltYcrLYUnkywTBAFouRPKjuS/t9ZU9gVxaL5m4I
	B/z/rSRr3Ypg/0OexOvjZZY5SI6s1E0k+UlB5iXblBreU+YLEVLs+W4ISzjTcm7jOVMh/KMYOep
	/RBEn80OQ5zdYsZ0aNa2nOnfuaK+2F02Joied78AnLpbC41dFMlw/kmBqplb27kPNKGVHu3Wbw4
	t691WAUBPP0V9VuJ6VMq4uDR7dYhCFYUS/vcz/djjOw==
X-Received: by 2002:a05:6a00:1d93:b0:886:46c:8a1f with SMTP id d2e1a72fcca58-8bc1d33251cmr5112349b3a.35.1794496752822;
        Thu, 12 Nov 2026 07:19:12 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3a55sm3561480b3a.3.2026.11.12.07.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:19:12 -0800 (PST)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 0/1] ipv6: mcast: fix default-interface source filter selection
Date: Thu, 12 Nov 2026 15:19:03 +0000
Message-ID: <cover.1794492711.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
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

We found an issue in net/ipv6/mcast.c. The bug is reachable by an
unprivileged process using the IPv6 multicast source-filter socket API.
The relevant details are provided below.

---- details below ----

An LLM was used to help create this patch.

This bug is tracked at: https://bugtracker.nebusec.ai/f/Z8p (Z8p)

Bug details:

When gsr_interface is zero, ip6_mc_source() resolves the multicast route
to a device but previously searched socket memberships with a wildcard
interface index. With the same group joined on multiple interfaces, the
socket filter could be updated on one interface while the aggregate
filter was updated on the route-selected interface. The patch uses the
resolved interface index for both membership lookup and last-source
membership removal.

Reproducer:

Build and run as an unprivileged user in a Linux guest where ff0e::1234
routes through eth0 and lo is available:

    gcc -O2 -Wall -Wextra -o mini_poc mini_poc.c
    ip -6 route get ff0e::1234
    ./mini_poc

The test used a 2 vCPU, 2 GiB x86 QEMU/KVM environment. On the baseline,
the source appeared in socket[lo] while socket[eth0] stayed empty. With
the patch, it appeared in socket[eth0] while socket[lo] stayed empty.
No kernel crash was observed.

------BEGIN PoC------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <net/if.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

#ifndef GROUP_FILTER_SIZE
#define GROUP_FILTER_SIZE(n) \
	(sizeof(struct group_filter) - sizeof(struct sockaddr_storage) + \
	 (n) * sizeof(struct sockaddr_storage))
#endif

static void set_group(struct sockaddr_storage *ss, const char *addr)
{
	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)ss;

	sin6->sin6_family = AF_INET6;
	if (inet_pton(AF_INET6, addr, &sin6->sin6_addr) != 1) {
		perror("inet_pton");
		exit(EXIT_FAILURE);
	}
}

static void show_filter(int fd, unsigned int ifindex, const char *ifname)
{
	struct group_filter *gf = calloc(1, GROUP_FILTER_SIZE(1));
	struct sockaddr_in6 *sin6;
	socklen_t len = GROUP_FILTER_SIZE(1);

	if (!gf) {
		perror("calloc");
		exit(EXIT_FAILURE);
	}
	gf->gf_interface = ifindex;
	gf->gf_numsrc = 1;
	set_group(&gf->gf_group, "ff0e::1234");
	if (getsockopt(fd, SOL_IPV6, MCAST_MSFILTER, gf, &len)) {
		perror("getsockopt(MCAST_MSFILTER)");
		exit(EXIT_FAILURE);
	}
	printf("%s: mode=%s sources=%u", ifname,
	       gf->gf_fmode == MCAST_INCLUDE ? "INCLUDE" : "EXCLUDE",
	       gf->gf_numsrc);
	if (gf->gf_numsrc) {
		char source[INET6_ADDRSTRLEN];

		sin6 = (struct sockaddr_in6 *)&gf->gf_slist[0];
		inet_ntop(AF_INET6, &sin6->sin6_addr, source, sizeof(source));
		printf(" first-source=%s", source);
	}
	putchar('\n');
	free(gf);
}

int main(void)
{
	const char *group = "ff0e::1234";
	const char *source = "2001:db8::1";
	unsigned int route_if = if_nametoindex("eth0");
	unsigned int shadow_if = if_nametoindex("lo");
	struct ipv6_mreq mreq = { 0 };
	struct group_source_req gsr = { 0 };
	int fd;

	if (!route_if || !shadow_if) {
		fprintf(stderr, "eth0 or lo is unavailable\n");
		return EXIT_FAILURE;
	}
	fd = socket(AF_INET6, SOCK_DGRAM, 0);
	if (fd < 0) {
		perror("socket");
		return EXIT_FAILURE;
	}
	if (inet_pton(AF_INET6, group, &mreq.ipv6mr_multiaddr) != 1) {
		perror("inet_pton(group)");
		return EXIT_FAILURE;
	}
	mreq.ipv6mr_interface = route_if;
	if (setsockopt(fd, SOL_IPV6, IPV6_ADD_MEMBERSHIP, &mreq, sizeof(mreq))) {
		perror("IPV6_ADD_MEMBERSHIP(eth0)");
		return EXIT_FAILURE;
	}
	mreq.ipv6mr_interface = shadow_if;
	if (setsockopt(fd, SOL_IPV6, IPV6_ADD_MEMBERSHIP, &mreq, sizeof(mreq))) {
		perror("IPV6_ADD_MEMBERSHIP(lo)");
		return EXIT_FAILURE;
	}

	gsr.gsr_interface = 0;
	set_group(&gsr.gsr_group, group);
	set_group(&gsr.gsr_source, source);
	show_filter(fd, route_if, "eth0 before");
	show_filter(fd, shadow_if, "lo before");
	if (setsockopt(fd, SOL_IPV6, MCAST_BLOCK_SOURCE, &gsr, sizeof(gsr))) {
		perror("setsockopt(MCAST_BLOCK_SOURCE)");
		return EXIT_FAILURE;
	}
	show_filter(fd, route_if, "eth0 after");
	show_filter(fd, shadow_if, "lo after");
	close(fd);
	return 0;
}

------END PoC--------

Best regards,
Zihan Xi


Zihan Xi (1):
  ipv6: mcast: use resolved interface for source filters

 net/ipv6/mcast.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.43.0

