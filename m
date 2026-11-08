Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166066;
	b=4HDZQPYzY8qssIJiWM2KaTnUUJs3bEE0wZTwT5LN4Bc3n8Hgnxo08kCEbW+R1joh/Sda
	 kHTyel99ykJXjIWnHIELIZhGCIXXRfMMlZe9w2od6iQ8xx0MSWouo17b84om6YZls9zjc
	 pAM7udVrbtCHpNqU5/jF5Ia2o3Cft/om+/XqqwdW0KHVoyckqALdLXube+ZQJVQWYwZFx
	 9NviBcQOqE5ZHxPGAoBOgrUB8JqTPcc1C9daz+skl6srK8Y9+PBkV0IpjmzEmkwRXK0xP
	 eNkrH6xBVpor1wO9VLqkYY1ZVyggsgqbXNO9qGGUlnOvfay8DoueM3Ne3+wgLDrbTaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GyXlmDFP3D+kJWlEExv7B4QAUsixeEYodOjbjRPUa1w=;
	b=f+5aEFePl9kBLqRs6hsG+jilTg5+Iymnm70u5nDCZQh8xU/KwBBuEWRBqVw4jZ3c/Cdj
	 xHqBCwACkAtFrSiA+BT9YwdbB4sP/6fRU3LolhT1LoFSgvYlrU0K7M3NQtRXfZtw2tvlT
	 qpfu0/fDmAVtrF8Mb+N+8tKd4maj2r74TqgbkeKMHhSMkEmJIeGR/J0WGgg+smLcltzZP
	 83mnJCh8gn8Vj8JUlWncxw6+vE151PSLFOtWQf9tmP/Rho0kYLifVE6LrlRfuCTkZSOxj
	 3Ay69DyM2BgcC5vBDz54UqQ9U8jJQxE0v5WP47EUGmQUEElImXO1uxAIxerjoSIgF2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="l8S/ZRg0";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19A606A323
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 19:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A19A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l8S/ZRg0
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so115377a91.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 11:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794166064; x=1794770864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GyXlmDFP3D+kJWlEExv7B4QAUsixeEYodOjbjRPUa1w=;
        b=l8S/ZRg0bgDI3x+j5UInykzAtNv7DIMoBxERXNZgkmkmIv4utyJJYZ3RvrcMTfNiIy
         /v2jD/FkNF2s2nBx+ozC6OHL5N3RRVZ9T6iLqqx4O6NIjzDe8Kx1b2TnJ5bIkb4lVmXb
         UVF4jQofl09Ml+OZYxoqfOLMxj2bkfRyoQEn9Ak2yn8vtxwwQGth+K5+ddPVf7KIvmSs
         vJNOUv/50ab7XOm0kliLpNWlb/qNwWYBPm6bleNhe/34fx+x6jPkH6kA+Xoj26iExiXF
         toZFZEBdGST985j7OlZhfmAoZ0GUZr4agrQHR9WLHL1ywmrIDqJ0Bas05UY+whaBZuF6
         GfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794166064; x=1794770864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GyXlmDFP3D+kJWlEExv7B4QAUsixeEYodOjbjRPUa1w=;
        b=GjpWRGZdpRCzOHhREFF3as/ZgkMY5gMHTSoiDsFYtu5KoBys9tkJAIqSvvmd8pF8eE
         ui1xS+CJWzwzGgZlUX1fN+qTGhK00elXipR3T9052TTIj/BHTpRqtO6azpk5Kh7//qBQ
         jGstyYQZfc8oUpw9VxLKJ1hgX0VRJOs5X4tMDAyoZUy4qFCmpjBonlqcAsWqiMMkvKop
         hy1aKRM2Kb4+qvXKBv+upGNVk49lPmfvYqjmJfWYbNNtvyW3X42sNonIbPzHVySixm+i
         zdH4BdB42Kx8PINJfxIBRAonjrzDVOgwZo1GMtdwNOmUrwKZRlGblFbBzcQqMHTVl4KC
         8J4g==
X-Gm-Message-State: APuU4Z9jh2fTswiwDnpt84wTFwD0OCAS6/Q061eTmOqHHrX4/4Ei+YWc
	Ibmi5u9FV6vUfPauA2z2gwfXPtYey27tYdKFxm/LgHnFqEg52DCEySFOqZq8Ae4EYAefOvNX17S
	a1Ste
X-Gm-Gg: AYBFou3UU9YYkgmJl/Y/5Szj5iIDE3FvtNheV6NQexsOg/xbZXlveS4Sv19deZT7qIf
	UXT30gxsg/Crwcb1r3g+NUAyeoZAUOJEtSm+MyoPtO5jhP8UzI6DouS46wuSwSLKN33PQ+RZUIF
	3xbxlDo3r52VNaOTmva6t5a2PbbdZh/YN83BYyrN+22EaEdL7j0vBQ7UXHb05yN8jWkgtqvhwXF
	H8OEQn5XmrMNprVOiw5/25JXpiEecgmcp8xzVBCYVKXFBTOu/7sezl4fXOLjjCNpK8X9ZUJ9zqx
	y+A2IeQOOcexTOXWh9RCgPLVWTBHRDklr8Tbiwrc+7dYZ5bGm0v4UKsBpC7eTlxj4MuDPryuBP1
	dxUQ1MYEq4LSx/io31Gxfmym86a4eHpVwRi874XUmdpc95SLEsZOQGb4GObEooYUZby7Iqbk8rU
	m4VLW/E4neiWUFiONKqN05DUKfhLTU2yV5TCmT6L9NYoOtNPm8AVIUWOdPPjXsFPAKatxY0+ITY
	YxIZcsY6ag0F8PS+IrJO6HMf+VGrWTd21+sh/6MBMHyXbawDYmkspZS8EjwAYk7VhofYNMGWhhZ
	I2d3dSIntDtAU2x8NLrh9Ays+G5wIF3nUSiZzNjSwT27uNG2sjAdnkfVcM5ji4Pfd1HZ
X-Received: by 2002:a17:90b:3dcf:b0:3ac:9e76:aa9b with SMTP id 98e67ed59e1d1-3b12d0ea196mr1953824a91.7.1794166064108;
        Sun, 08 Nov 2026 11:27:44 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105904951sm7967139a91.16.2026.11.08.11.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:27:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] arpd: remove
Date: Sun,  8 Nov 2026 11:27:40 -0800
Message-ID: <20261108192740.929163-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

arpd, the userspace ARP daemon, passed away quietly in misc/.
Born last century to Alexey Kuznetsov, it spent its youth answering kernel
neighbour solicitations for networks too large for the in-kernel table,
keeping its memories in a Berkeley DB file. In its final years its only
visitors were tree-wide cleanups, who stopped by to add an SPDX tag and
fix its whitespace. It outlived the problem it was built to solve, as
neighbour tables grew up and learned to take care of themselves.

arpd was predeceased by its lifelong companion libdb, which Fedora has
already laid to rest; Debian is making arrangements. Unable to build
without it, arpd chose to go with dignity rather than be kept alive on
a bundled copy. It is survived by ip neigh, which does the job without
a database. In lieu of flowers, please drop libdb from your build
dependencies.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 Makefile        |   1 -
 README          |  11 +-
 man/man8/arpd.8 |  69 ----
 misc/.gitignore |   1 -
 misc/Makefile   |   7 -
 misc/arpd.c     | 841 ------------------------------------------------
 6 files changed, 2 insertions(+), 928 deletions(-)
 delete mode 100644 man/man8/arpd.8
 delete mode 100644 misc/arpd.c

diff --git a/Makefile b/Makefile
index 6f5d4765..8f581a48 100644
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,6 @@ CONF_ETC_DIR?=/etc/iproute2
 CONF_USR_DIR?=$(DATADIR)/iproute2
 DOCDIR?=$(DATADIR)/doc/iproute2
 MANDIR?=$(DATADIR)/man
-ARPDDIR?=/var/lib/arpd
 KERNEL_INCLUDE?=/usr/include
 BASH_COMPDIR?=$(DATADIR)/bash-completion/completions
 
diff --git a/README b/README
index 6ddf6015..7b612870 100644
--- a/README
+++ b/README
@@ -27,21 +27,14 @@ Support (LTS) kernel version.
 
 How to compile this.
 --------------------
-1. libdbm
 
-arpd needs to have the berkeleydb development libraries. For Debian
-users this is the package with a name like libdbX.X-dev.
-DBM_INCLUDE points to the directory with db_185.h which
-is the include file used by arpd to get to the old format Berkeley
-database routines.  Often this is in the db-devel package.
-
-2. make
+1. make
 
 The makefile will automatically build a config.mk file which
 contains definitions of libraries that may or may not be available
 on the system such as: ATM, ELF, MNL, and SELINUX.
 
-3. include/uapi
+2. include/uapi
 
 This package includes matching sanitized kernel headers because
 the build environment may not have up to date versions. See Makefile
diff --git a/man/man8/arpd.8 b/man/man8/arpd.8
deleted file mode 100644
index 5050a98b..00000000
--- a/man/man8/arpd.8
+++ /dev/null
@@ -1,69 +0,0 @@
-.TH ARPD 8 "28 June, 2007"
-
-.SH NAME
-arpd \- userspace arp daemon.
-
-.SH SYNOPSIS
-Usage: arpd [ -lkh? ] [ -a N ] [ -b dbase ] [ -B number ] [ -f file ] [-p interval ] [ -n time ] [ -R rate ] [ <INTERFACES> ]
-
-.SH DESCRIPTION
-The
-.B arpd
-daemon collects gratuitous ARP information, saving it on local disk and feeding it to the kernel on demand to avoid redundant broadcasting due to limited size of the kernel ARP cache.
-
-.SH OPTIONS
-.TP
--h -?
-Print help
-.TP
--l
-Dump the arpd database to stdout and exit. The output consists of three columns: the interface index, the IP address of the interface, and the MAC address of the interface. Negative entries for dead hosts are also shown, in this case the MAC address is replaced by the word FAILED followed by a colon and the most recent time when the fact that the host is dead was proven.
-.TP
--f <FILE>
-Read and load an arpd database from FILE in a text format similar to that dumped by option -l. Exit after load, possibly listing resulting database, if option -l is also given. If FILE is -, stdin is read to get the ARP table.
-.TP
--b <DATABASE>
-the location of the database file. The default location is /var/lib/arpd/arpd.db
-.TP
--a <NUMBER>
-With this option, arpd not only passively listens for ARP packets on the interface, but also sends broadcast queries itself. NUMBER is the number of such queries to make before a destination is considered dead. When arpd is started as kernel helper (i.e. with app_solicit enabled in sysctl or even with option -k) without this option and still did not learn enough information, you can observe 1 second gaps in service. Not fatal, but not good.
-.TP
--k
-Suppress sending broadcast queries by the kernel. This option only makes sense together with option -a.
-.TP
--n <TIME>
-Specifies the timeout of the negative cache. When resolution fails, arpd suppresses further attempts to resolve for this period. This option only makes sense together with option '-k'. This timeout should not be too much longer than the boot time of a typical host not supporting gratuitous ARP. Default value is 60 seconds.
-.TP
--p <TIME>
-The time to wait in seconds between polling attempts to the kernel ARP table. TIME may be a floating point number. The default value is 30.
-.TP
--R <RATE>
-Maximal steady rate of broadcasts sent by arpd in packets per second. Default value is 1.
-.TP
--B <NUMBER>
-The number of broadcasts sent by arpd back to back. Default value is 3. Together with the -R option, this option ensures that the number of ARP queries that are broadcast does not exceed B+R*T over any interval of time T.
-.P
-<INTERFACES> is a list of names of networking interfaces to watch. If no interfaces are given, arpd monitors all the interfaces. In this case arpd does not adjust sysctl parameters, it is assumed that the user does this himself after arpd is started.
-.P
-.SH SIGNALS
-.TP
-When arpd receives a SIGINT or SIGTERM signal, it exits gracefully, syncing the database and restoring adjusted sysctl parameters. On a SIGHUP it syncs the database to disk. With SIGUSR1 it sends some statistics to syslog. The effect of any other signals is undefined. In particular, they may corrupt the database and leave the sysctl parameters in an unpredictable state.
-.P
-.SH NOTE
-.TP
-In order for arpd to be able to serve as ARP resolver, the kernel must be compiled with the option CONFIG_ARPD and, in the case when interface list in not given on command line, variable app_solicit on interfaces of interest should be in /proc/sys/net/ipv4/neigh/*. If this is not made arpd still collects gratuitous ARP information in its database.
-.SH EXAMPLES
-.TP
-arpd -b /var/tmp/arpd.db
-Start arpd to collect gratuitous ARP, but not messing with kernel functionality.
-.TP
-killall arpd ; arpd -l -b /var/tmp/arpd.db
-Look at result after some time.
-.TP
-arpd -b /var/tmp/arpd.db -a 1 eth0 eth1
-Enable kernel helper, leaving leading role to kernel.
-.TP
-arpd -b /var/tmp/arpd.db -a 3 -k eth0 eth1
-Completely replace kernel resolution on interfaces eth0 and eth1. In this case the kernel still does unicast probing to validate entries, but all the broadcast activity is suppressed and made under authority of arpd.
-.PP
-This is the mode in which arpd normally is supposed to work. It is not the default to prevent occasional enabling of too aggressive a mode.
diff --git a/misc/.gitignore b/misc/.gitignore
index d7df0b02..1177605e 100644
--- a/misc/.gitignore
+++ b/misc/.gitignore
@@ -1,4 +1,3 @@
-arpd
 ifstat
 ss
 ssfilter.tab.c
diff --git a/misc/Makefile b/misc/Makefile
index 50dae79c..4736d928 100644
--- a/misc/Makefile
+++ b/misc/Makefile
@@ -6,10 +6,6 @@ TARGETS=ss nstat ifstat rtacct lnstat
 
 include ../config.mk
 
-ifeq ($(HAVE_BERKELEY_DB),y)
-	TARGETS += arpd
-endif
-
 all: $(TARGETS)
 
 ss: $(SSOBJ)
@@ -24,9 +20,6 @@ ifstat: ifstat.c
 rtacct: rtacct.c
 	$(QUIET_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o rtacct rtacct.c $(LDLIBS) -lm
 
-arpd: arpd.c
-	$(QUIET_CC)$(CC) $(CFLAGS) -I$(DBM_INCLUDE) $(CPPFLAGS) $(LDFLAGS) -o arpd arpd.c $(LDLIBS) -ldb
-
 ssfilter.tab.c: ssfilter.y
 	$(QUIET_YACC)$(YACC) -b ssfilter ssfilter.y
 
diff --git a/misc/arpd.c b/misc/arpd.c
deleted file mode 100644
index a42603f6..00000000
--- a/misc/arpd.c
+++ /dev/null
@@ -1,841 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * arpd.c	ARP helper daemon.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-#include <stdio.h>
-#include <syslog.h>
-#include <malloc.h>
-#include <string.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <netdb.h>
-#include <db_185.h>
-#include <sys/ioctl.h>
-#include <poll.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <sys/uio.h>
-#include <sys/socket.h>
-#include <sys/stat.h>
-#include <sys/time.h>
-#include <time.h>
-#include <signal.h>
-#include <linux/if.h>
-#include <linux/if_ether.h>
-#include <linux/if_arp.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <linux/if_packet.h>
-#include <linux/filter.h>
-
-#include "libnetlink.h"
-#include "utils.h"
-#include "rt_names.h"
-
-DB	*dbase;
-char const	default_dbname[] = ARPDDIR "/arpd.db";
-char const	*dbname = default_dbname;
-
-int	ifnum;
-int	*ifvec;
-char	**ifnames;
-
-struct dbkey {
-	__u32	iface;
-	__u32	addr;
-};
-
-#define IS_NEG(x)	(((__u8 *)(x))[0] == 0xFF)
-#define NEG_TIME(x)	(((x)[2]<<24)|((x)[3]<<16)|((x)[4]<<8)|(x)[5])
-#define NEG_AGE(x)	((__u32)time(NULL) - NEG_TIME((__u8 *)x))
-#define NEG_VALID(x)	(NEG_AGE(x) < negative_timeout)
-#define NEG_CNT(x)	(((__u8 *)(x))[1])
-
-struct rtnl_handle rth;
-
-struct pollfd pset[2];
-int udp_sock = -1;
-
-volatile int do_exit;
-volatile int do_sync;
-volatile int do_stats;
-
-struct {
-	unsigned long arp_new;
-	unsigned long arp_change;
-
-	unsigned long app_recv;
-	unsigned long app_success;
-	unsigned long app_bad;
-	unsigned long app_neg;
-	unsigned long app_suppressed;
-
-	unsigned long kern_neg;
-	unsigned long kern_new;
-	unsigned long kern_change;
-
-	unsigned long probes_sent;
-	unsigned long probes_suppressed;
-} stats;
-
-int active_probing;
-int negative_timeout = 60;
-int no_kernel_broadcasts;
-int broadcast_rate = 1000;
-int broadcast_burst = 3000;
-int poll_timeout = 30000;
-
-static void usage(void)
-{
-	fprintf(stderr,
-		"Usage: arpd [ -lkh? ] [ -a N ] [ -b dbase ] [ -B number ] [ -f file ] [ -n time ] [-p interval ] [ -R rate ] [ interfaces ]\n");
-	exit(1);
-}
-
-static int handle_if(int ifindex)
-{
-	int i;
-
-	if (ifnum == 0)
-		return 1;
-
-	for (i = 0; i < ifnum; i++)
-		if (ifvec[i] == ifindex)
-			return 1;
-	return 0;
-}
-
-int sysctl_adjusted;
-
-static void do_sysctl_adjustments(void)
-{
-	int i;
-
-	if (!ifnum)
-		return;
-
-	for (i = 0; i < ifnum; i++) {
-		char buf[128];
-		FILE *fp;
-
-		if (active_probing) {
-			sprintf(buf, "/proc/sys/net/ipv4/neigh/%s/mcast_solicit", ifnames[i]);
-			if ((fp = fopen(buf, "w")) != NULL) {
-				if (no_kernel_broadcasts)
-					strcpy(buf, "0\n");
-				else
-					sprintf(buf, "%d\n", active_probing >= 2 ? 1 : 3-active_probing);
-				fputs(buf, fp);
-				fclose(fp);
-			}
-		}
-
-		sprintf(buf, "/proc/sys/net/ipv4/neigh/%s/app_solicit", ifnames[i]);
-		if ((fp = fopen(buf, "w")) != NULL) {
-			sprintf(buf, "%d\n", active_probing <= 1 ? 1 : active_probing);
-			fputs(buf, fp);
-			fclose(fp);
-		}
-	}
-	sysctl_adjusted = 1;
-}
-
-static void undo_sysctl_adjustments(void)
-{
-	int i;
-
-	if (!sysctl_adjusted)
-		return;
-
-	for (i = 0; i < ifnum; i++) {
-		char buf[128];
-		FILE *fp;
-
-		if (active_probing) {
-			sprintf(buf, "/proc/sys/net/ipv4/neigh/%s/mcast_solicit", ifnames[i]);
-			if ((fp = fopen(buf, "w")) != NULL) {
-				strcpy(buf, "3\n");
-				fputs(buf, fp);
-				fclose(fp);
-			}
-		}
-		sprintf(buf, "/proc/sys/net/ipv4/neigh/%s/app_solicit", ifnames[i]);
-		if ((fp = fopen(buf, "w")) != NULL) {
-			strcpy(buf, "0\n");
-			fputs(buf, fp);
-			fclose(fp);
-		}
-	}
-	sysctl_adjusted = 0;
-}
-
-
-static int send_probe(int ifindex, __u32 addr)
-{
-	struct ifreq ifr = { .ifr_ifindex = ifindex };
-	struct sockaddr_in dst = {
-		.sin_family = AF_INET,
-		.sin_port = htons(1025),
-		.sin_addr.s_addr = addr,
-	};
-	socklen_t len;
-	unsigned char buf[256];
-	struct arphdr *ah = (struct arphdr *)buf;
-	unsigned char *p = (unsigned char *)(ah+1);
-	struct sockaddr_ll sll = {
-		.sll_family = AF_PACKET,
-		.sll_ifindex = ifindex,
-		.sll_protocol = htons(ETH_P_ARP),
-	};
-
-	if (ioctl(udp_sock, SIOCGIFNAME, &ifr))
-		return -1;
-	if (ioctl(udp_sock, SIOCGIFHWADDR, &ifr))
-		return -1;
-	if (ifr.ifr_hwaddr.sa_family != ARPHRD_ETHER)
-		return -1;
-	if (setsockopt(udp_sock, SOL_SOCKET, SO_BINDTODEVICE, ifr.ifr_name, strlen(ifr.ifr_name)+1) < 0)
-		return -1;
-
-	if (connect(udp_sock, (struct sockaddr *)&dst, sizeof(dst)) < 0)
-		return -1;
-	len = sizeof(dst);
-	if (getsockname(udp_sock, (struct sockaddr *)&dst, &len) < 0)
-		return -1;
-
-	ah->ar_hrd = htons(ifr.ifr_hwaddr.sa_family);
-	ah->ar_pro = htons(ETH_P_IP);
-	ah->ar_hln = 6;
-	ah->ar_pln = 4;
-	ah->ar_op  = htons(ARPOP_REQUEST);
-
-	memcpy(p, ifr.ifr_hwaddr.sa_data, ah->ar_hln);
-	p += ah->ar_hln;
-
-	memcpy(p, &dst.sin_addr, 4);
-	p += 4;
-
-	memset(sll.sll_addr, 0xFF, sizeof(sll.sll_addr));
-	memcpy(p, &sll.sll_addr, ah->ar_hln);
-	p += ah->ar_hln;
-
-	memcpy(p, &addr, 4);
-	p += 4;
-
-	if (sendto(pset[0].fd, buf, p-buf, 0, (struct sockaddr *)&sll, sizeof(sll)) < 0)
-		return -1;
-	stats.probes_sent++;
-	return 0;
-}
-
-/* Be very tough on sending probes: 1 per second with burst of 3. */
-
-static int queue_active_probe(int ifindex, __u32 addr)
-{
-	static struct timeval prev;
-	static int buckets;
-	struct timeval now;
-
-	gettimeofday(&now, NULL);
-	if (prev.tv_sec) {
-		int diff = (now.tv_sec-prev.tv_sec)*1000+(now.tv_usec-prev.tv_usec)/1000;
-
-		buckets += diff;
-	} else {
-		buckets = broadcast_burst;
-	}
-	if (buckets > broadcast_burst)
-		buckets = broadcast_burst;
-	if (buckets >= broadcast_rate && !send_probe(ifindex, addr)) {
-		buckets -= broadcast_rate;
-		prev = now;
-		return 0;
-	}
-	stats.probes_suppressed++;
-	return -1;
-}
-
-static int respond_to_kernel(int ifindex, __u32 addr, char *lla, int llalen)
-{
-	struct {
-		struct nlmsghdr	n;
-		struct ndmsg		ndm;
-		char			buf[256];
-	} req = {
-		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ndmsg)),
-		.n.nlmsg_flags = NLM_F_REQUEST,
-		.n.nlmsg_type = RTM_NEWNEIGH,
-		.ndm.ndm_family = AF_INET,
-		.ndm.ndm_state = NUD_STALE,
-		.ndm.ndm_ifindex = ifindex,
-		.ndm.ndm_type = RTN_UNICAST,
-	};
-
-	addattr_l(&req.n, sizeof(req), NDA_DST, &addr, 4);
-	addattr_l(&req.n, sizeof(req), NDA_LLADDR, lla, llalen);
-	return rtnl_send(&rth, &req, req.n.nlmsg_len) <= 0;
-}
-
-static void prepare_neg_entry(__u8 *ndata, __u32 stamp)
-{
-	ndata[0] = 0xFF;
-	ndata[1] = 0;
-	ndata[2] = stamp>>24;
-	ndata[3] = stamp>>16;
-	ndata[4] = stamp>>8;
-	ndata[5] = stamp;
-}
-
-
-static int do_one_request(struct nlmsghdr *n)
-{
-	struct ndmsg *ndm = NLMSG_DATA(n);
-	int len = n->nlmsg_len;
-	struct rtattr *tb[NDA_MAX+1];
-	struct dbkey key;
-	DBT dbkey, dbdat;
-	int do_acct = 0;
-
-	if (n->nlmsg_type == NLMSG_DONE) {
-		dbase->sync(dbase, 0);
-
-		/* Now we have at least mirror of kernel db, so that
-		 * may start real resolution.
-		 */
-		do_sysctl_adjustments();
-		return 0;
-	}
-
-	if (n->nlmsg_type != RTM_GETNEIGH && n->nlmsg_type != RTM_NEWNEIGH)
-		return 0;
-
-	len -= NLMSG_LENGTH(sizeof(*ndm));
-	if (len < 0)
-		return -1;
-
-	if (ndm->ndm_family != AF_INET ||
-	    (ifnum && !handle_if(ndm->ndm_ifindex)) ||
-	    ndm->ndm_flags ||
-	    ndm->ndm_type != RTN_UNICAST ||
-	    !(ndm->ndm_state&~NUD_NOARP))
-		return 0;
-
-	parse_rtattr(tb, NDA_MAX, NDA_RTA(ndm), len);
-
-	if (!tb[NDA_DST])
-		return 0;
-
-	key.iface = ndm->ndm_ifindex;
-	memcpy(&key.addr, RTA_DATA(tb[NDA_DST]), 4);
-	dbkey.data = &key;
-	dbkey.size = sizeof(key);
-
-	if (dbase->get(dbase, &dbkey, &dbdat, 0) != 0) {
-		dbdat.data = 0;
-		dbdat.size = 0;
-	}
-
-	if (n->nlmsg_type == RTM_GETNEIGH) {
-		if (!(n->nlmsg_flags&NLM_F_REQUEST))
-			return 0;
-
-		if (!(ndm->ndm_state&(NUD_PROBE|NUD_INCOMPLETE))) {
-			stats.app_bad++;
-			return 0;
-		}
-
-		if (ndm->ndm_state&NUD_PROBE) {
-			/* If we get this, kernel still has some valid
-			 * address, but unicast probing failed and host
-			 * is either dead or changed its mac address.
-			 * Kernel is going to initiate broadcast resolution.
-			 * OK, we invalidate our information as well.
-			 */
-			if (dbdat.data && !IS_NEG(dbdat.data))
-				stats.app_neg++;
-
-			dbase->del(dbase, &dbkey, 0);
-		} else {
-			/* If we get this kernel does not have any information.
-			 * If we have something tell this to kernel. */
-			stats.app_recv++;
-			if (dbdat.data && !IS_NEG(dbdat.data)) {
-				stats.app_success++;
-				respond_to_kernel(key.iface, key.addr, dbdat.data, dbdat.size);
-				return 0;
-			}
-
-			/* Sheeit! We have nothing to tell. */
-			/* If we have recent negative entry, be silent. */
-			if (dbdat.data && NEG_VALID(dbdat.data)) {
-				if (NEG_CNT(dbdat.data) >= active_probing) {
-					stats.app_suppressed++;
-					return 0;
-				}
-				do_acct = 1;
-			}
-		}
-
-		if (active_probing &&
-		    queue_active_probe(ndm->ndm_ifindex, key.addr) == 0 &&
-		    do_acct) {
-			NEG_CNT(dbdat.data)++;
-			dbase->put(dbase, &dbkey, &dbdat, 0);
-		}
-	} else if (n->nlmsg_type == RTM_NEWNEIGH) {
-		if (n->nlmsg_flags&NLM_F_REQUEST)
-			return 0;
-
-		if (ndm->ndm_state&NUD_FAILED) {
-			/* Kernel was not able to resolve. Host is dead.
-			 * Create negative entry if it is not present
-			 * or renew it if it is too old. */
-			if (!dbdat.data ||
-			    !IS_NEG(dbdat.data) ||
-			    !NEG_VALID(dbdat.data)) {
-				__u8 ndata[6];
-
-				stats.kern_neg++;
-				prepare_neg_entry(ndata, time(NULL));
-				dbdat.data = ndata;
-				dbdat.size = sizeof(ndata);
-				dbase->put(dbase, &dbkey, &dbdat, 0);
-			}
-		} else if (tb[NDA_LLADDR]) {
-			if (dbdat.data && !IS_NEG(dbdat.data)) {
-				if (memcmp(RTA_DATA(tb[NDA_LLADDR]), dbdat.data, dbdat.size) == 0)
-					return 0;
-				stats.kern_change++;
-			} else {
-				stats.kern_new++;
-			}
-			dbdat.data = RTA_DATA(tb[NDA_LLADDR]);
-			dbdat.size = RTA_PAYLOAD(tb[NDA_LLADDR]);
-			dbase->put(dbase, &dbkey, &dbdat, 0);
-		}
-	}
-	return 0;
-}
-
-static void load_initial_table(void)
-{
-	if (rtnl_neighdump_req(&rth, AF_INET, NULL) < 0) {
-		perror("dump request failed");
-		exit(1);
-	}
-
-}
-
-static void get_kern_msg(void)
-{
-	int status;
-	struct nlmsghdr *h;
-	struct sockaddr_nl nladdr = {};
-	struct iovec iov;
-	char   buf[8192];
-	struct msghdr msg = {
-		.msg_name = &nladdr,
-		.msg_namelen = sizeof(nladdr),
-		.msg_iov = &iov,
-		.msg_iovlen = 1,
-	};
-
-	iov.iov_base = buf;
-	iov.iov_len = sizeof(buf);
-
-	status = recvmsg(rth.fd, &msg, MSG_DONTWAIT);
-
-	if (status <= 0)
-		return;
-
-	if (msg.msg_namelen != sizeof(nladdr))
-		return;
-
-	if (nladdr.nl_pid)
-		return;
-
-	for (h = (struct nlmsghdr *)buf; status >= sizeof(*h); ) {
-		int len = h->nlmsg_len;
-		int l = len - sizeof(*h);
-
-		if (l < 0 || len > status)
-			return;
-
-		if (do_one_request(h) < 0)
-			return;
-
-		status -= NLMSG_ALIGN(len);
-		h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
-	}
-}
-
-/* Receive gratuitous ARP messages and store them, that's all. */
-static void get_arp_pkt(void)
-{
-	unsigned char buf[1024];
-	struct sockaddr_ll sll;
-	socklen_t sll_len = sizeof(sll);
-	struct arphdr *a = (struct arphdr *)buf;
-	struct dbkey key;
-	DBT dbkey, dbdat;
-	int n;
-
-	n = recvfrom(pset[0].fd, buf, sizeof(buf), MSG_DONTWAIT,
-		     (struct sockaddr *)&sll, &sll_len);
-	if (n < 0) {
-		if (errno != EINTR && errno != EAGAIN)
-			syslog(LOG_ERR, "recvfrom: %m");
-		return;
-	}
-
-	if (ifnum && !handle_if(sll.sll_ifindex))
-		return;
-
-	/* Validate packet */
-	if (n < sizeof(*a) ||
-	    (a->ar_op != htons(ARPOP_REQUEST) &&
-	     a->ar_op != htons(ARPOP_REPLY)) ||
-	    a->ar_pln != 4 ||
-	    a->ar_pro != htons(ETH_P_IP) ||
-	    a->ar_hln != sll.sll_halen ||
-	    sizeof(*a) + 2*4 + 2*a->ar_hln > n)
-		return;
-
-	key.iface = sll.sll_ifindex;
-	memcpy(&key.addr, (char *)(a+1) + a->ar_hln, 4);
-
-	/* DAD message, ignore. */
-	if (key.addr == 0)
-		return;
-
-	dbkey.data = &key;
-	dbkey.size = sizeof(key);
-
-	if (dbase->get(dbase, &dbkey, &dbdat, 0) == 0 && !IS_NEG(dbdat.data)) {
-		if (memcmp(dbdat.data, a+1, dbdat.size) == 0)
-			return;
-		stats.arp_change++;
-	} else {
-		stats.arp_new++;
-	}
-
-	dbdat.data = a+1;
-	dbdat.size = a->ar_hln;
-	dbase->put(dbase, &dbkey, &dbdat, 0);
-}
-
-static void catch_signal(int sig, void (*handler)(int))
-{
-	struct sigaction sa = { .sa_handler = handler };
-
-#ifdef SA_INTERRUPT
-	sa.sa_flags = SA_INTERRUPT;
-#endif
-	sigaction(sig, &sa, NULL);
-}
-
-#include <setjmp.h>
-sigjmp_buf env;
-volatile int in_poll;
-
-static void sig_exit(int signo)
-{
-	do_exit = 1;
-	if (in_poll)
-		siglongjmp(env, 1);
-}
-
-static void sig_sync(int signo)
-{
-	do_sync = 1;
-	if (in_poll)
-		siglongjmp(env, 1);
-}
-
-static void sig_stats(int signo)
-{
-	do_sync = 1;
-	do_stats = 1;
-	if (in_poll)
-		siglongjmp(env, 1);
-}
-
-static void send_stats(void)
-{
-	syslog(LOG_INFO, "arp_rcv: n%lu c%lu app_rcv: tot %lu hits %lu bad %lu neg %lu sup %lu",
-	       stats.arp_new, stats.arp_change,
-
-	       stats.app_recv, stats.app_success,
-	       stats.app_bad, stats.app_neg, stats.app_suppressed
-	       );
-	syslog(LOG_INFO, "kern: n%lu c%lu neg %lu arp_send: %lu rlim %lu",
-	       stats.kern_new, stats.kern_change, stats.kern_neg,
-
-	       stats.probes_sent, stats.probes_suppressed
-	       );
-	do_stats = 0;
-}
-
-
-int main(int argc, char **argv)
-{
-	int opt;
-	int do_list = 0;
-	char *do_load = NULL;
-
-	while ((opt = getopt(argc, argv, "h?b:lf:a:n:p:kR:B:")) != EOF) {
-		switch (opt) {
-		case 'b':
-			dbname = optarg;
-			break;
-		case 'f':
-			if (do_load) {
-				fprintf(stderr, "Duplicate option -f\n");
-				usage();
-			}
-			do_load = optarg;
-			break;
-		case 'l':
-			do_list = 1;
-			break;
-		case 'a':
-			active_probing = atoi(optarg);
-			break;
-		case 'n':
-			negative_timeout = atoi(optarg);
-			break;
-		case 'k':
-			no_kernel_broadcasts = 1;
-			break;
-		case 'p':
-			if ((poll_timeout = 1000 * strtod(optarg, NULL)) < 100) {
-				fprintf(stderr, "Invalid poll timeout\n");
-				exit(-1);
-			}
-			break;
-		case 'R':
-			if ((broadcast_rate = atoi(optarg)) <= 0 ||
-			    (broadcast_rate = 1000/broadcast_rate) <= 0) {
-				fprintf(stderr, "Invalid ARP rate\n");
-				exit(-1);
-			}
-			break;
-		case 'B':
-			if ((broadcast_burst = atoi(optarg)) <= 0 ||
-			    (broadcast_burst = 1000*broadcast_burst) <= 0) {
-				fprintf(stderr, "Invalid ARP burst\n");
-				exit(-1);
-			}
-			break;
-		case 'h':
-		case '?':
-		default:
-			usage();
-		}
-	}
-	argc -= optind;
-	argv += optind;
-
-	if (argc > 0) {
-		ifnum = argc;
-		ifnames = argv;
-		ifvec = malloc(argc*sizeof(int));
-		if (!ifvec) {
-			perror("malloc");
-			exit(-1);
-		}
-	}
-
-	if ((udp_sock = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
-		perror("socket");
-		exit(-1);
-	}
-
-	if (ifnum) {
-		int i;
-		struct ifreq ifr = {};
-
-		for (i = 0; i < ifnum; i++) {
-			if (get_ifname(ifr.ifr_name, ifnames[i]))
-				invarg("not a valid ifname", ifnames[i]);
-			if (ioctl(udp_sock, SIOCGIFINDEX, &ifr)) {
-				perror("ioctl(SIOCGIFINDEX)");
-				exit(-1);
-			}
-			ifvec[i] = ifr.ifr_ifindex;
-		}
-	}
-
-	if (strcmp(default_dbname, dbname) == 0) {
-		if (mkdir(ARPDDIR, 0755) != 0 && errno != EEXIST) {
-			perror("create_db_dir");
-			exit(-1);
-		}
-	}
-
-	dbase = dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH, NULL);
-	if (dbase == NULL) {
-		perror("db_open");
-		exit(-1);
-	}
-
-	if (do_load) {
-		char buf[128];
-		FILE *fp;
-		struct dbkey k;
-		DBT dbkey, dbdat;
-
-		dbkey.data = &k;
-		dbkey.size = sizeof(k);
-
-		if (strcmp(do_load, "-") == 0 || strcmp(do_load, "--") == 0) {
-			fp = stdin;
-		} else if ((fp = fopen(do_load, "r")) == NULL) {
-			perror("fopen");
-			goto do_abort;
-		}
-
-		buf[sizeof(buf)-1] = 0;
-		while (fgets(buf, sizeof(buf), fp)) {
-			__u8 b1[6];
-			char ipbuf[128];
-			char macbuf[128];
-
-			if (buf[0] == '#')
-				continue;
-
-			if (sscanf(buf, "%u%s%s", &k.iface, ipbuf, macbuf) != 3) {
-				fprintf(stderr, "Wrong format of input file \"%s\"\n", do_load);
-				goto do_abort;
-			}
-			if (strncmp(macbuf, "FAILED:", 7) == 0)
-				continue;
-			if (!inet_aton(ipbuf, (struct in_addr *)&k.addr)) {
-				fprintf(stderr, "Invalid IP address: \"%s\"\n", ipbuf);
-				goto do_abort;
-			}
-
-			if (ll_addr_a2n((char *) b1, 6, macbuf) != 6)
-				goto do_abort;
-			dbdat.size = 6;
-
-			if (dbase->put(dbase, &dbkey, &dbdat, 0)) {
-				perror("hash->put");
-				goto do_abort;
-			}
-		}
-		dbase->sync(dbase, 0);
-		if (fp != stdin)
-			fclose(fp);
-	}
-
-	if (do_list) {
-		DBT dbkey, dbdat;
-
-		printf("%-8s %-15s %s\n", "#Ifindex", "IP", "MAC");
-		while (dbase->seq(dbase, &dbkey, &dbdat, R_NEXT) == 0) {
-			struct dbkey *key = dbkey.data;
-
-			if (handle_if(key->iface)) {
-				if (!IS_NEG(dbdat.data)) {
-					char b1[18];
-
-					printf("%-8d %-15s %s\n",
-					       key->iface,
-					       inet_ntoa(*(struct in_addr *)&key->addr),
-					       ll_addr_n2a(dbdat.data, 6, ARPHRD_ETHER, b1, 18));
-				} else {
-					printf("%-8d %-15s FAILED: %dsec ago\n",
-					       key->iface,
-					       inet_ntoa(*(struct in_addr *)&key->addr),
-					       NEG_AGE(dbdat.data));
-				}
-			}
-		}
-	}
-
-	if (do_load || do_list)
-		goto out;
-
-	pset[0].fd = socket(PF_PACKET, SOCK_DGRAM, 0);
-	if (pset[0].fd < 0) {
-		perror("socket");
-		exit(-1);
-	}
-
-	if (1) {
-		struct sockaddr_ll sll = {
-			.sll_family = AF_PACKET,
-			.sll_protocol = htons(ETH_P_ARP),
-			.sll_ifindex = (ifnum == 1 ? ifvec[0] : 0),
-		};
-
-		if (bind(pset[0].fd, (struct sockaddr *)&sll, sizeof(sll)) < 0) {
-			perror("bind");
-			goto do_abort;
-		}
-	}
-
-	if (rtnl_open(&rth, RTMGRP_NEIGH) < 0) {
-		perror("rtnl_open");
-		goto do_abort;
-	}
-	pset[1].fd = rth.fd;
-
-	load_initial_table();
-
-	if (daemon(0, 0)) {
-		perror("arpd: daemon");
-		goto do_abort;
-	}
-
-	openlog("arpd", LOG_PID | LOG_CONS, LOG_DAEMON);
-	catch_signal(SIGINT, sig_exit);
-	catch_signal(SIGTERM, sig_exit);
-	catch_signal(SIGHUP, sig_sync);
-	catch_signal(SIGUSR1, sig_stats);
-
-#define EVENTS (POLLIN|POLLPRI|POLLERR|POLLHUP)
-	pset[0].events = EVENTS;
-	pset[0].revents = 0;
-	pset[1].events = EVENTS;
-	pset[1].revents = 0;
-
-	sigsetjmp(env, 1);
-
-	for (;;) {
-		in_poll = 1;
-
-		if (do_exit)
-			break;
-		if (do_sync) {
-			in_poll = 0;
-			dbase->sync(dbase, 0);
-			do_sync = 0;
-			in_poll = 1;
-		}
-		if (do_stats)
-			send_stats();
-		if (poll(pset, 2, poll_timeout) > 0) {
-			in_poll = 0;
-			if (pset[0].revents&EVENTS)
-				get_arp_pkt();
-			if (pset[1].revents&EVENTS)
-				get_kern_msg();
-		} else {
-			do_sync = 1;
-		}
-	}
-
-	undo_sysctl_adjustments();
-out:
-	dbase->close(dbase);
-	exit(0);
-
-do_abort:
-	dbase->close(dbase);
-	exit(-1);
-}
-- 
2.53.0

