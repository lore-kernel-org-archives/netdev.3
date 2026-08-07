Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC13FA5FD
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117395; cv=none; b=fmNQDHhT/ZARwIWzAypLwoopjgLjPwUErLjhKE7WZggn+0t56kmkdKTcQX2ymIfUVlc3WWE1ctBfrx90dXDuivk/dVcfeWO5oQS3cNGbNNc3f1A1gMX28RxE8cJVXq0ZDSxMwAfkvzwxLo6LmvXq8mkclQH4kv/EtAGiTdU0ljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117395; c=relaxed/simple;
	bh=e7H/c5dgjYHTPUxcgdtLdvN8Tt3hmwHZaaMCCt9Iaeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKRL7zQ48mTXQpKgT7cwAl09sAms2+6VA1vq9Fx5v5BwEyv/XB56Rv0WD1YWikSo0mJFRdUJipQPsDJLzqCqO2LmOYhAjRPRERu14NT+pT4lncB8d3jm1AUamS1cWzc7DcXZRQJfQacHlBHUXskvnrzwhbCq7E/zQ/0Lj9c0oEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=F/czuHFS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="F/czuHFS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d032846c95so44464095ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786117391; x=1786722191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c73/lpQEJHq7fdZfKN53FT3soMonnvpcgZZpvomWjh8=;
        b=F/czuHFSNsyIvlfWZ345m1vRzscEILIvgUkwO8F3wqgdxlQZVP7848tNPETWVXAztq
         TXcm/fXpn3oQGbZGsndWwmnwu/2EI/CWUtnCLol+Uta1mlY54AU7ZIrqK+gaTC6F+mU5
         b3WCB+b3aCp/xyJ4SeCNbPFxSgfRRtUF6qRCrb0jM2hvp/UdVOuEADfkE9BuR5K438n7
         x1m4zhX0SlLUnsxZmxfoJ73gYEZEfTCIDDuNV6FWuitt+16HHQ+Zh86zs+7ugZiTv32Y
         cDhjzm+rP8N3+gi/x+7xhsXg3ihW5S8j+9vxIqvnIvJf4CiRIaXuMw5gbC5CY/FEXOEW
         Cb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117391; x=1786722191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c73/lpQEJHq7fdZfKN53FT3soMonnvpcgZZpvomWjh8=;
        b=B2XOwOhALoKodeRn8mAspsoEDtZsDFxWK2ChnUwK419LPm8ys6Nr2XK7QfQxYiqPTv
         /OyF0B1Pjmi++Hz/ruK/uwjpnmXXIWRzs77cvyTqB8YAPe3m1na5S54bt2TWukqUhf1D
         QJUnudV6ka4V3mt2iwpgxrr1Pop1dX/CZ4git3KBEMhErXpY6xcHYOC8URHmlqsZFyJA
         MHVQIi5gO8WXvZrJtcV+HHeyPyf6KmgInHx5DRloaHlxOdxW0XlfC48vAEo5p5/1zm7+
         MzxsMsakl3E3dHE3m2esSqMETMsp1wBRqLQqcrVZysBx9lVZSUsDWAcpti3hDeeTsFWa
         raEw==
X-Gm-Message-State: AOJu0YwZynqDA8GuYpA/eNqfrjurywKNWfB8zc7uaunQswJ7aKNFVNaT
	Ea+qsk6KtEqeEvx3/aQK38Bxcwcnd9TAHtOuOm6f/Xsjp1POrH/QJ7tpuWIwcmw2GG3xz5M73q5
	rHIeo
X-Gm-Gg: AR+sD13nO6w804eTFa+JOQ8xPSMjFAz8mQDKlHiwGMcwp3Rpo7zYMTdz/cZmIRaPU7q
	E4fLmlCR6giiQNICon7v6Ah5nPc3kBWxRyumYIr5fV2g9pv8uLUmjXFU0hgY43pNmfan+J9xbxX
	5FTK37FwyKo1OaE8Ga+vDCfAVsAYQo8K0cDwGNful2tqWTzlPvCtRS7Hhn7Cc14ZfG9xSrsUmP+
	ZlXH3C5BuO/WmzckjNxNK4OA2X6HqSbNbHULel8/tD1GZGU/z0JKvn/HdOymZ1LvX9wQ42hdXbO
	DGZZi9k9kQdWCG64Ec/zj/gR/N09wiUltu63uvI+OLr6LVL4Bm0D1JSWUWsxRIpMe15Wx9/vBqK
	m0NnAY1p+Eoc4yuygv5rpC4OTSqOILDzUvGdyAf9ljgbg523hYmggsdi0WDjvf/I61AEHlzjVle
	yZzkJ54AzJ7oCnb4OsGCj1VbMBbdyaAbMKzxV2kaazZfHTozm1T7i0Pk1gnbsXjwJXWrWEb6aU4
	RlIPaf03Kt0z4we3R3wpb7psOs=
X-Received: by 2002:a05:6a21:7e0c:b0:3cb:b741:2924 with SMTP id adf61e73a8af0-3cbb7412a8amr7873948637.29.1786117390591;
        Fri, 07 Aug 2026 08:43:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019a0528sm8213083c88.1.2026.08.07.08.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:43:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	Dmitri Seletski <drjoms@gmail.com>
Subject: [PATCH iproute2-next 1/7] ip: follow Linux convention for help vs usage
Date: Fri,  7 Aug 2026 08:42:24 -0700
Message-ID: <20260807154306.111200-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807154306.111200-1-stephen@networkplumber.org>
References: <20260807154306.111200-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux convention is that help text goes to stdout
and exit code is 0 (success). And for case of incorrect arguments
the usage text goes to stderr, and exit code is 1 (failure).

Reported-by: Dmitri Seletski <drjoms@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/ip.c               | 15 ++++++++-------
 ip/ip6tunnel.c        | 12 ++++++------
 ip/ip_common.h        |  4 ++--
 ip/ipaddress.c        | 18 +++++++++---------
 ip/ipaddrlabel.c      | 10 +++++-----
 ip/ipfou.c            | 12 ++++++------
 ip/ipila.c            | 12 ++++++------
 ip/ipioam6.c          | 13 ++++++++-----
 ip/ipl2tp.c           | 21 ++++++++++++---------
 ip/iplink.c           | 40 +++++++++++++++++++++-------------------
 ip/iplink_amt.c       | 15 +++++----------
 ip/iplink_can.c       | 11 +++--------
 ip/iplink_dsa.c       |  4 ++--
 ip/iplink_hsr.c       | 11 +++--------
 ip/iplink_vxcan.c     | 11 +++--------
 ip/ipmacsec.c         | 32 ++++++++++++++++----------------
 ip/ipmaddr.c          | 14 +++++++-------
 ip/ipmonitor.c        | 10 +++++-----
 ip/ipmptcp.c          | 10 +++++-----
 ip/ipmroute.c         | 14 +++++++-------
 ip/ipneigh.c          | 18 +++++++++---------
 ip/ipnetconf.c        | 10 +++++-----
 ip/ipnetns.c          | 10 +++++-----
 ip/ipnexthop.c        | 26 +++++++++++++-------------
 ip/ipntable.c         | 10 +++++-----
 ip/iproute.c          | 20 ++++++++++----------
 ip/iproute_lwtunnel.c | 33 ++++++++++++++++++---------------
 ip/iprule.c           | 12 ++++++------
 ip/ipseg6.c           | 13 ++++++++-----
 ip/iptoken.c          | 13 +++++++------
 ip/iptunnel.c         | 12 ++++++------
 ip/iptuntap.c         | 12 ++++++------
 ip/ipvrf.c            | 10 +++++-----
 ip/ipxfrm.c           | 14 +++++++-------
 ip/link_veth.c        | 14 +++++---------
 ip/rtmon.c            | 10 +++++-----
 ip/tcp_metrics.c      | 12 ++++++------
 ip/xfrm_monitor.c     | 10 +++++-----
 ip/xfrm_policy.c      | 16 +++++++++-------
 ip/xfrm_state.c       | 26 ++++++++++++++------------
 40 files changed, 293 insertions(+), 297 deletions(-)

diff --git a/ip/ip.c b/ip/ip.c
index e4b71bde..feeb5f0a 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -52,11 +52,11 @@ const char *get_ip_lib_dir(void)
 	return lib_dir;
 }
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }\n"
 		"       ip [ -force ] -batch filename\n"
 		"where  OBJECT := { address | addrlabel | fou | help | ila | ioam | l2tp | link |\n"
@@ -72,12 +72,13 @@ static void usage(void)
 		"                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filename] |\n"
 		"                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] | -a[ll] |\n"
 		"                    -c[olor]}\n");
-	exit(-1);
+
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int do_help(int argc, char **argv)
 {
-	usage();
+	usage(true);
 	return 0;
 }
 
@@ -279,7 +280,7 @@ int main(int argc, char **argv)
 			rcvbuf = size;
 		} else if (matches_color(opt, &color)) {
 		} else if (matches(opt, "-help") == 0) {
-			usage();
+			usage(true);
 		} else if (matches(opt, "-netns") == 0) {
 			NEXT_ARG();
 			if (netns_switch(argv[1]))
@@ -321,5 +322,5 @@ int main(int argc, char **argv)
 		return do_cmd(argv[1], argc-1, argv+1, true);
 
 	rtnl_close(&rth);
-	usage();
+	usage(false);
 }
diff --git a/ip/ip6tunnel.c b/ip/ip6tunnel.c
index 347bd46a..922a1873 100644
--- a/ip/ip6tunnel.c
+++ b/ip/ip6tunnel.c
@@ -29,11 +29,11 @@
 
 #define DEFAULT_TNL_HOP_LIMIT	(64)
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip -f inet6 tunnel { add | change | del | show } [ NAME ]\n"
 		"          [ mode { ip6ip6 | ipip6 | ip6gre | vti6 | any } ]\n"
 		"          [ remote ADDR local ADDR ] [ dev PHYS_DEV ]\n"
@@ -52,7 +52,7 @@ static void usage(void)
 		"       KEY       := { DOTTED_QUAD | NUMBER }\n",
 		IPV6_DEFAULT_TNL_ENCAP_LIMIT,
 		DEFAULT_TNL_HOP_LIMIT);
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static void print_tunnel(const void *t)
@@ -267,7 +267,7 @@ static int parse_args(int argc, char **argv, int cmd, struct ip6_tnl_parm2 *p)
 			if (strcmp(*argv, "name") == 0) {
 				NEXT_ARG();
 			} else if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (p->name[0])
 				duparg2("name", *argv);
 			if (get_ifname(p->name, *argv))
@@ -428,7 +428,7 @@ int do_ip6tunnel(int argc, char **argv)
 		    matches(*argv, "list") == 0)
 			return do_show(argc - 1, argv + 1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else
 		return do_show(0, NULL);
 
diff --git a/ip/ip_common.h b/ip/ip_common.h
index 3f55ea33..db6de378 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -41,8 +41,8 @@ int print_addrlabel(struct nlmsghdr *n, void *arg);
 int print_neigh(struct nlmsghdr *n, void *arg);
 int ipaddr_list_link(int argc, char **argv);
 void ipaddr_get_vf_rate(int, int *, int *, const char *);
-void iplink_usage(void) __attribute__((noreturn));
-void iplink_types_usage(void);
+void iplink_usage(bool help) __attribute__((noreturn));
+void iplink_types_usage(FILE *f);
 
 void iproute_reset_filter(int ifindex);
 void ipmroute_reset_filter(int ifindex);
diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 3653fd4e..0293801a 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -42,14 +42,14 @@ enum {
 static struct link_filter filter;
 static int do_link;
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
 	if (do_link)
-		iplink_usage();
+		iplink_usage(help);
 
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip address {add|change|replace} IFADDR dev IFNAME [ LIFETIME ]\n"
 		"                                                      [ CONFFLAG-LIST ]\n"
 		"       ip address del IFADDR dev IFNAME [mngtmpaddr]\n"
@@ -76,9 +76,9 @@ static void usage(void)
 		"LFT := forever | SECONDS\n"
 		"ADDRPROTO := [ NAME | NUMBER ]\n"
 		);
-	iplink_types_usage();
+	iplink_types_usage(help ? stdout : stderr);
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static void print_link_flags(FILE *fp, unsigned int flags, unsigned int mdown)
@@ -2260,7 +2260,7 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 			if (strcmp(*argv, "dev") == 0)
 				NEXT_ARG();
 			else if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (filter_dev)
 				duparg2("dev", *argv);
 			filter_dev = *argv;
@@ -2593,7 +2593,7 @@ static int ipaddr_modify(int cmd, int flags, int argc, char **argv)
 			if (strcmp(*argv, "local") == 0)
 				NEXT_ARG();
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (local_len)
 				duparg2("local", *argv);
 			lcl_arg = *argv;
@@ -2716,7 +2716,7 @@ int do_ipaddr(int argc, char **argv)
 	if (matches(*argv, "restore") == 0)
 		return ipaddr_restore();
 	if (matches(*argv, "help") == 0)
-		usage();
+		usage(true);
 	fprintf(stderr, "Command \"%s\" is unknown, try \"ip address help\".\n", *argv);
 	exit(-1);
 }
diff --git a/ip/ipaddrlabel.c b/ip/ipaddrlabel.c
index 0f49bbee..1d3864e0 100644
--- a/ip/ipaddrlabel.c
+++ b/ip/ipaddrlabel.c
@@ -31,14 +31,14 @@
 
 extern struct rtnl_handle rth;
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip addrlabel { add | del } prefix PREFIX [ dev DEV ] [ label LABEL ]\n"
 		"       ip addrlabel [ list | flush | help ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 int print_addrlabel(struct nlmsghdr *n, void *arg)
@@ -256,7 +256,7 @@ int do_ipaddrlabel(int argc, char **argv)
 	} else if (matches(argv[0], "flush") == 0) {
 		return ipaddrlabel_flush(argc-1, argv+1);
 	} else if (matches(argv[0], "help") == 0)
-		usage();
+		usage(true);
 
 	fprintf(stderr, "Command \"%s\" is unknown, try \"ip addrlabel help\".\n", *argv);
 	exit(-1);
diff --git a/ip/ipfou.c b/ip/ipfou.c
index 8c1e061a..e25da65c 100644
--- a/ip/ipfou.c
+++ b/ip/ipfou.c
@@ -20,9 +20,9 @@
 #include "ip_common.h"
 #include "json_print.h"
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip fou add port PORT { ipproto PROTO  | gue }\n"
 		"		   [ local IFADDR ] [ peer IFADDR ]\n"
 		"		   [ peer_port PORT ] [ dev IFNAME ]\n"
@@ -35,7 +35,7 @@ static void usage(void)
 		"       PORT { 1..65535 }\n"
 		"       IFADDR { addr }\n");
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 /* netlink socket */
@@ -118,7 +118,7 @@ static int fou_parse_opt(int argc, char **argv, struct nlmsghdr *n,
 		} else {
 			fprintf(stderr
 				, "fou: unknown command \"%s\"?\n", *argv);
-			usage();
+			usage(false);
 			return -1;
 		}
 		argc--, argv++;
@@ -329,10 +329,10 @@ static int do_show(int argc, char **argv)
 int do_ipfou(int argc, char **argv)
 {
 	if (argc < 1)
-		usage();
+		usage(false);
 
 	if (matches(*argv, "help") == 0)
-		usage();
+		usage(true);
 
 	if (genl_init_handle(&genl_rth, FOU_GENL_NAME, &genl_family))
 		exit(1);
diff --git a/ip/ipila.c b/ip/ipila.c
index 2590de9a..238fafac 100644
--- a/ip/ipila.c
+++ b/ip/ipila.c
@@ -21,9 +21,9 @@
 #include "ila_common.h"
 #include "json_print.h"
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip ila add loc_match LOCATOR_MATCH loc LOCATOR [ dev DEV ] OPTIONS\n"
 		"       ip ila del loc_match LOCATOR_MATCH [ loc LOCATOR ] [ dev DEV ]\n"
 		"       ip ila list\n"
@@ -31,7 +31,7 @@ static void usage(void)
 		"                         neutral-map-auto | no-action } ]\n"
 		"           [ ident-type { luid | use-format } ]\n");
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 /* netlink socket */
@@ -226,7 +226,7 @@ static int ila_parse_opt(int argc, char **argv, struct nlmsghdr *n,
 			}
 			ifindex_set = true;
 		} else {
-			usage();
+			usage(false);
 			return -1;
 		}
 		argc--, argv++;
@@ -288,10 +288,10 @@ static int do_del(int argc, char **argv)
 int do_ipila(int argc, char **argv)
 {
 	if (argc < 1)
-		usage();
+		usage(false);
 
 	if (matches(*argv, "help") == 0)
-		usage();
+		usage(true);
 
 	if (genl_init_handle(&genl_rth, ILA_GENL_NAME, &genl_family))
 		exit(1);
diff --git a/ip/ipioam6.c b/ip/ipioam6.c
index 118fcd1c..7e5c020f 100644
--- a/ip/ipioam6.c
+++ b/ip/ipioam6.c
@@ -21,9 +21,9 @@
 #include "libgenl.h"
 #include "json_print.h"
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage:	ip ioam { COMMAND | help }\n"
 		"	ip ioam namespace show\n"
 		"	ip ioam namespace add ID [ data DATA32 ] [ wide DATA64 ]\n"
@@ -33,7 +33,7 @@ static void usage(void)
 		"	ip ioam schema del ID\n"
 		"	ip ioam namespace set ID schema { ID | none }\n"
 		"	ip ioam monitor\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static struct rtnl_handle grth = { .fd = -1 };
@@ -270,8 +270,11 @@ int do_ioam6(int argc, char **argv)
 {
 	bool maybe_wide = false;
 
-	if (argc < 1 || strcmp(*argv, "help") == 0)
-		usage();
+	if (argc < 1)
+		usage(false);
+
+	if (strcmp(*argv, "help") == 0)
+		usage(true);
 
 	memset(&opts, 0, sizeof(opts));
 
diff --git a/ip/ipl2tp.c b/ip/ipl2tp.c
index 97f7ff08..e7c092be 100644
--- a/ip/ipl2tp.c
+++ b/ip/ipl2tp.c
@@ -509,11 +509,11 @@ static int get_tunnel(struct l2tp_data *p)
  * Command parser
  *****************************************************************************/
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr, "Usage: ip l2tp add tunnel\n"
+	fprintf(help ? stdout : stderr, "Usage: ip l2tp add tunnel\n"
 		"          remote ADDR local ADDR\n"
 		"          tunnel_id ID peer_tunnel_id ID\n"
 		"          [ encap { ip | udp } ]\n"
@@ -539,7 +539,7 @@ static void usage(void)
 		"       HEXSTR := { 8 or 16 hex digits (4 / 8 bytes) }\n"
 		"       L2SPEC := { none | default }\n");
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int parse_args(int argc, char **argv, int cmd, struct l2tp_parm *p)
@@ -547,7 +547,7 @@ static int parse_args(int argc, char **argv, int cmd, struct l2tp_parm *p)
 	memset(p, 0, sizeof(*p));
 
 	if (argc == 0)
-		usage();
+		usage(false);
 
 	/* Defaults */
 	p->l2spec_type = L2TP_L2SPECTYPE_DEFAULT;
@@ -715,10 +715,10 @@ static int parse_args(int argc, char **argv, int cmd, struct l2tp_parm *p)
 		} else if (strcmp(*argv, "session") == 0) {
 			p->session = 1;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			fprintf(stderr, "Unknown command: %s\n", *argv);
-			usage();
+			usage(false);
 		}
 
 		argc--; argv++;
@@ -823,8 +823,11 @@ static int do_show(int argc, char **argv)
 
 int do_ipl2tp(int argc, char **argv)
 {
-	if (argc < 1 || !matches(*argv, "help"))
-		usage();
+	if (argc < 1)
+		usage(false);
+
+	if (matches(*argv, "help") == 0)
+		usage(true);
 
 	if (genl_init_handle(&genl_rth, L2TP_GENL_NAME, &genl_family))
 		exit(1);
diff --git a/ip/iplink.c b/ip/iplink.c
index c6aee8b6..a765002e 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -31,12 +31,12 @@
 #endif
 
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-void iplink_types_usage(void)
+void iplink_types_usage(FILE *f)
 {
 	/* Remember to add new entry here if new type is added. */
-	fprintf(stderr,
+	fprintf(f,
 		"TYPE := { amt | bareudp | bond | bond_slave | bridge | bridge_slave |\n"
 		"          dsa | dummy | erspan | geneve | gre | gretap | gtp | hsr |\n"
 		"          ifb | ip6erspan | ip6gre | ip6gretap | ip6tnl |\n"
@@ -47,9 +47,11 @@ void iplink_types_usage(void)
 		"          xfrm | virt_wifi }\n");
 }
 
-void iplink_usage(void)
+void iplink_usage(bool help)
 {
-	fprintf(stderr,
+	FILE *fp = help ? stdout : stderr;
+
+	fprintf(fp,
 		"Usage: ip link add [link DEV | parentdev NAME] [ name ] NAME\n"
 		"		    [ txqueuelen PACKETS ]\n"
 		"		    [ address LLADDR ]\n"
@@ -66,7 +68,7 @@ void iplink_usage(void)
 		"			[ { up | down } ]\n"
 		"			[ type TYPE ARGS ]\n");
 
-	fprintf(stderr,
+	fprintf(fp,
 		"		[ arp { on | off } ]\n"
 		"		[ dynamic { on | off } ]\n"
 		"		[ multicast { on | off } ]\n"
@@ -134,18 +136,18 @@ void iplink_usage(void)
 		"	ip link property add dev DEVICE [ altname NAME .. ]\n"
 		"	ip link property del dev DEVICE [ altname NAME .. ]\n");
 
-	fprintf(stderr,
+	fprintf(fp,
 		"\n"
 		"	ip link help [ TYPE ]\n"
 		"\n");
-	iplink_types_usage();
+	iplink_types_usage(fp);
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
-static void usage(void)
+static void usage(bool help)
 {
-	iplink_usage();
+	iplink_usage(help);
 }
 
 static int on_off(const char *msg, const char *realval)
@@ -1253,7 +1255,7 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 				  *argv, strlen(*argv) + 1);
 		} else {
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 
 			if (strcmp(*argv, "dev") == 0)
 				NEXT_ARG();
@@ -1465,7 +1467,7 @@ static int iplink_modify(int cmd, unsigned int flags, int argc, char **argv)
 			addattr_nest_end(&req.n, data);
 		} else if (argc) {
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			fprintf(stderr,
 				"Garbage instead of arguments \"%s ...\". Try \"ip link help\".\n",
 				*argv);
@@ -1681,7 +1683,7 @@ static int iplink_afstats(int argc, char **argv)
 				duparg2("dev", *argv);
 			filter_dev = *argv;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			fprintf(stderr,
 				"Command \"%s\" is unknown, try \"ip link help\".\n",
@@ -1739,7 +1741,7 @@ static int iplink_prop_mod(int argc, char **argv, struct iplink_req *req)
 			addattr_l(&req->n, sizeof(*req), IFLA_ALT_IFNAME,
 				  name, strlen(name) + 1);
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			if (strcmp(*argv, "dev") == 0)
 				NEXT_ARG();
@@ -1777,7 +1779,7 @@ static int iplink_prop(int argc, char **argv)
 	};
 
 	if (argc <= 0) {
-		usage();
+		usage(false);
 		exit(-1);
 	}
 
@@ -1787,7 +1789,7 @@ static int iplink_prop(int argc, char **argv)
 	} else if (matches(*argv, "del") == 0) {
 		req.n.nlmsg_type = RTM_DELLINKPROP;
 	} else if (matches(*argv, "help") == 0) {
-		usage();
+		usage(true);
 	} else {
 		fprintf(stderr, "Operator required\n");
 		exit(-1);
@@ -1800,7 +1802,7 @@ static void do_help(int argc, char **argv)
 	struct link_util *lu = NULL;
 
 	if (argc <= 0) {
-		usage();
+		usage(true);
 		return;
 	}
 
@@ -1808,7 +1810,7 @@ static void do_help(int argc, char **argv)
 	if (lu && lu->print_help)
 		lu->print_help(lu, argc-1, argv+1, stdout);
 	else
-		usage();
+		usage(true);
 }
 
 int do_iplink(int argc, char **argv)
diff --git a/ip/iplink_amt.c b/ip/iplink_amt.c
index 3a35bd9d..bb2966f2 100644
--- a/ip/iplink_amt.c
+++ b/ip/iplink_amt.c
@@ -37,12 +37,7 @@ static void print_usage(FILE *f)
 		);
 }
 
-static char *modename[] = {"gateway", "relay"};
-
-static void usage(void)
-{
-	print_usage(stderr);
-}
+static const char *modename[] = {"gateway", "relay"};
 
 static void check_duparg(__u64 *attrs, int type, const char *key,
 		const char *argv)
@@ -75,7 +70,7 @@ static int amt_parse_opt(struct link_util *lu, int argc, char **argv,
 			} else if (strcmp(*argv, "relay") == 0) {
 				mode = 1;
 			} else {
-				usage();
+				print_usage(stderr);
 				return -1;
 			}
 			addattr32(n, 1024, IFLA_AMT_MODE, mode);
@@ -119,11 +114,11 @@ static int amt_parse_opt(struct link_util *lu, int argc, char **argv,
 				addattr_l(n, 1024, IFLA_AMT_DISCOVERY_IP,
 					  daddr.data, daddr.bytelen);
 		} else if (strcmp(*argv, "help") == 0) {
-			usage();
-			return -1;
+			print_usage(stdout);
+			exit(EXIT_SUCCESS);
 		} else {
 			fprintf(stderr, "amt: unknown command \"%s\"?\n", *argv);
-			usage();
+			print_usage(stderr);
 			return -1;
 		}
 		argc--, argv++;
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index f631aab8..7b5e9a18 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -81,11 +81,6 @@ static void print_usage(FILE *f)
 		);
 }
 
-static void usage(void)
-{
-	print_usage(stderr);
-}
-
 static void set_ctrlmode(char *name, char *arg,
 			 struct can_ctrlmode *cm, __u32 flags)
 {
@@ -374,11 +369,11 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				       *argv);
 			addattr16(n, 1024, IFLA_CAN_TERMINATION, val);
 		} else if (matches(*argv, "help") == 0) {
-			usage();
-			return -1;
+			print_usage(stdout);
+			exit(EXIT_SUCCESS);
 		} else {
 			fprintf(stderr, "can: unknown option \"%s\"\n", *argv);
-			usage();
+			print_usage(stderr);
 			return -1;
 		}
 		argc--, argv++;
diff --git a/ip/iplink_dsa.c b/ip/iplink_dsa.c
index e3f3f8ac..080d6dfe 100644
--- a/ip/iplink_dsa.c
+++ b/ip/iplink_dsa.c
@@ -25,8 +25,8 @@ static int dsa_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("Device does not exist\n", *argv);
 			addattr_l(n, 1024, IFLA_DSA_MASTER, &ifindex, 4);
 		} else if (strcmp(*argv, "help") == 0) {
-			print_usage(stderr);
-			return -1;
+			print_usage(stdout);
+			exit(EXIT_SUCCESS);
 		} else {
 			fprintf(stderr, "dsa: unknown command \"%s\"?\n", *argv);
 			print_usage(stderr);
diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
index d79a4a40..f74a78ff 100644
--- a/ip/iplink_hsr.c
+++ b/ip/iplink_hsr.c
@@ -39,11 +39,6 @@ static void print_usage(FILE *f)
 		"	0 - HSR, 1 - PRP. (default = 0 - HSR)\n");
 }
 
-static void usage(void)
-{
-	print_usage(stderr);
-}
-
 static int hsr_parse_opt(struct link_util *lu, int argc, char **argv,
 			 struct nlmsghdr *n)
 {
@@ -92,11 +87,11 @@ static int hsr_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("No such interface", *argv);
 			addattr_l(n, 1024, IFLA_HSR_INTERLINK, &ifindex, 4);
 		} else if (matches(*argv, "help") == 0) {
-			usage();
-			return -1;
+			print_usage(stdout);
+			exit(EXIT_SUCCESS);
 		} else {
 			fprintf(stderr, "hsr: what is \"%s\"?\n", *argv);
-			usage();
+			print_usage(stderr);
 			return -1;
 		}
 		argc--, argv++;
diff --git a/ip/iplink_vxcan.c b/ip/iplink_vxcan.c
index e0f9bacb..b1d5077f 100644
--- a/ip/iplink_vxcan.c
+++ b/ip/iplink_vxcan.c
@@ -17,13 +17,8 @@
 
 static void print_usage(FILE *f)
 {
-	printf("Usage: ip link <options> type vxcan [peer <options>]\n"
-	       "To get <options> type 'ip link add help'\n");
-}
-
-static void usage(void)
-{
-	print_usage(stderr);
+	fprintf(f, "Usage: ip link <options> type vxcan [peer <options>]\n"
+		"To get <options> type 'ip link add help'\n");
 }
 
 static int vxcan_parse_opt(struct link_util *lu, int argc, char **argv,
@@ -36,7 +31,7 @@ static int vxcan_parse_opt(struct link_util *lu, int argc, char **argv,
 	unsigned int ifi_flags, ifi_change, ifi_index;
 
 	if (strcmp(argv[0], "peer") != 0) {
-		usage();
+		print_usage(stderr);
 		return -1;
 	}
 
diff --git a/ip/ipmacsec.c b/ip/ipmacsec.c
index 1864ffd3..92b81bf2 100644
--- a/ip/ipmacsec.c
+++ b/ip/ipmacsec.c
@@ -87,9 +87,9 @@ static int genl_family = -1;
 		     _cmd, _flags)
 
 
-static void ipmacsec_usage(void)
+static void ipmacsec_usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip macsec add DEV tx sa { 0..3 } [ OPTS ] key ID KEY\n"
 		"       ip macsec set DEV tx sa { 0..3 } [ OPTS ]\n"
 		"       ip macsec del DEV tx sa { 0..3 }\n"
@@ -108,7 +108,7 @@ static void ipmacsec_usage(void)
 		"       SCI  := { sci <u64> | port { 1..2^16-1 } address <lladdr> }\n"
 		"       SALT := 96-bit hex string\n");
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static bool ciphersuite_is_xpn(__u64 cid)
@@ -249,7 +249,7 @@ static int parse_sa_args(int *argcp, char ***argvp, struct sa_desc *sa)
 		} else {
 			fprintf(stderr, "macsec: unknown command \"%s\"?\n",
 				*argv);
-			ipmacsec_usage();
+			ipmacsec_usage(false);
 		}
 
 		argv++; argc--;
@@ -340,7 +340,7 @@ static bool parse_rxsci(int *argcp, char ***argvp, struct rxsc_desc *rxsc,
 	if (*argcp == 0 ||
 	    get_sci_portaddr(&sci, argcp, argvp, false, false) < 0) {
 		fprintf(stderr, "expected sci\n");
-		ipmacsec_usage();
+		ipmacsec_usage(false);
 	}
 
 	rxsc->sci = sci.sci;
@@ -368,7 +368,7 @@ static int parse_rxsci_args(int *argcp, char ***argvp, struct rxsc_desc *rxsc)
 		} else {
 			fprintf(stderr, "macsec: unknown command \"%s\"?\n",
 				*argv);
-			ipmacsec_usage();
+			ipmacsec_usage(false);
 		}
 
 		argv++; argc--;
@@ -504,7 +504,7 @@ static int do_modify_txsa(enum cmd c, int argc, char **argv, int ifindex)
 	txsa.active = 0xff;
 
 	if (argc == 0 || !get_sa(&argc, &argv, &txsa.an))
-		ipmacsec_usage();
+		ipmacsec_usage(false);
 
 	if (c == CMD_DEL)
 		goto modify;
@@ -553,7 +553,7 @@ static int do_modify(enum cmd c, int argc, char **argv)
 	int ifindex;
 
 	if (argc == 0)
-		ipmacsec_usage();
+		ipmacsec_usage(false);
 
 	ifindex = ll_name_to_index(*argv);
 	if (!ifindex) {
@@ -563,14 +563,14 @@ static int do_modify(enum cmd c, int argc, char **argv)
 	argc--; argv++;
 
 	if (argc == 0)
-		ipmacsec_usage();
+		ipmacsec_usage(false);
 
 	if (strcmp(*argv, "tx") == 0)
 		return do_modify_txsa(c, argc-1, argv+1, ifindex);
 	if (strcmp(*argv, "rx") == 0)
 		return do_modify_rxsci(c, argc-1, argv+1, ifindex);
 
-	ipmacsec_usage();
+	ipmacsec_usage(false);
 	return -1;
 }
 
@@ -581,7 +581,7 @@ static int do_offload(enum cmd c, int argc, char **argv)
 	int ifindex, ret;
 
 	if (argc == 0)
-		ipmacsec_usage();
+		ipmacsec_usage(false);
 
 	ifindex = ll_name_to_index(*argv);
 	if (!ifindex) {
@@ -591,11 +591,11 @@ static int do_offload(enum cmd c, int argc, char **argv)
 	argc--; argv++;
 
 	if (argc == 0)
-		ipmacsec_usage();
+		ipmacsec_usage(false);
 
 	offload = parse_one_of("offload", *argv, offload_str, ARRAY_SIZE(offload_str), &ret);
 	if (ret)
-		ipmacsec_usage();
+		ipmacsec_usage(false);
 
 	MACSEC_GENL_REQ(req, MACSEC_BUFLEN, macsec_commands[c][0][1], NLM_F_REQUEST);
 
@@ -1181,17 +1181,17 @@ static int do_show(int argc, char **argv)
 	if (argc == 0)
 		return do_dump(ifindex);
 
-	ipmacsec_usage();
+	ipmacsec_usage(false);
 	return -1;
 }
 
 int do_ipmacsec(int argc, char **argv)
 {
 	if (argc < 1)
-		ipmacsec_usage();
+		ipmacsec_usage(false);
 
 	if (matches(*argv, "help") == 0)
-		ipmacsec_usage();
+		ipmacsec_usage(true);
 
 	if (genl_init_handle(&genl_rth, MACSEC_GENL_NAME, &genl_family))
 		exit(1);
diff --git a/ip/ipmaddr.c b/ip/ipmaddr.c
index 95b703d2..5b16ab84 100644
--- a/ip/ipmaddr.c
+++ b/ip/ipmaddr.c
@@ -31,14 +31,14 @@ static struct {
 	int  family;
 } filter;
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip maddr [ add | del ] MULTIADDR dev STRING\n"
 		"       ip maddr show [ dev STRING ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int parse_hex(char *str, unsigned char *addr, size_t size)
@@ -371,7 +371,7 @@ static int multiaddr_list(int argc, char **argv)
 			if (strcmp(*argv, "dev") == 0) {
 				NEXT_ARG();
 			} else if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (filter.dev)
 				duparg2("dev", *argv);
 			filter.dev = *argv;
@@ -426,7 +426,7 @@ static int multiaddr_modify(int cmd, int argc, char **argv)
 				NEXT_ARG();
 			}
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (ifr.ifr_hwaddr.sa_data[0])
 				duparg("address", *argv);
 			len = ll_addr_a2n(ifr.ifr_hwaddr.sa_data,
@@ -484,7 +484,7 @@ int do_multiaddr(int argc, char **argv)
 	    || matches(*argv, "lst") == 0)
 		return multiaddr_list(argc-1, argv+1);
 	if (matches(*argv, "help") == 0)
-		usage();
+		usage(true);
 	fprintf(stderr, "Command \"%s\" is unknown, try \"ip maddr help\".\n", *argv);
 	exit(-1);
 }
diff --git a/ip/ipmonitor.c b/ip/ipmonitor.c
index 1f4e860f..43e3f672 100644
--- a/ip/ipmonitor.c
+++ b/ip/ipmonitor.c
@@ -20,21 +20,21 @@
 #include "ip_common.h"
 #include "nh_common.h"
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 static int prefix_banner;
 int listen_all_nsid;
 struct rtnl_ctrl_data *ctrl_data;
 int do_monitor;
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip monitor [ all | OBJECTS ] [ FILE ] [ label ] [ all-nsid ]\n"
 		"                  [ dev DEVICE ]\n"
 		"OBJECTS :=  address | link | mroute | maddress | acaddress | neigh |\n"
 		"            netconf | nexthop | nsid | prefix | route | rule | stats\n"
 		"FILE := file FILENAME\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 void print_headers(FILE *fp, const char *label)
@@ -239,7 +239,7 @@ int do_ipmonitor(int argc, char **argv)
 		} else if (matches(*argv, "all-nsid") == 0) {
 			listen_all_nsid = 1;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else if (strcmp(*argv, "dev") == 0) {
 			NEXT_ARG();
 
diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 02cf72ce..37913ef6 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -20,9 +20,9 @@
 #include "libnetlink.h"
 #include "ll_map.h"
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
@@ -36,7 +36,7 @@ static void usage(void)
 		"FLAG  := [ signal | subflow | laminar | backup | fullmesh ]\n"
 		"CHANGE-OPT := [ backup | nobackup | fullmesh | nofullmesh ]\n");
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 /* netlink socket */
@@ -621,10 +621,10 @@ static int mptcp_monitor(void)
 int do_mptcp(int argc, char **argv)
 {
 	if (argc == 0)
-		usage();
+		usage(false);
 
 	if (matches(*argv, "help") == 0)
-		usage();
+		usage(true);
 
 	if (genl_init_handle(&genl_rth, MPTCP_PM_NAME, &genl_family))
 		exit(1);
diff --git a/ip/ipmroute.c b/ip/ipmroute.c
index 164632e6..28019617 100644
--- a/ip/ipmroute.c
+++ b/ip/ipmroute.c
@@ -26,16 +26,16 @@
 #include "ip_common.h"
 #include "json_print.h"
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip mroute show [ [ to ] PREFIX ] [ from PREFIX ] [ iif DEVICE ]\n"
 		"                      [ table TABLE_ID ]\n"
 		"TABLE_ID := [ local | main | default | all | NUMBER ]\n"
 	);
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static struct rtfilter {
@@ -259,7 +259,7 @@ static int mroute_list(int argc, char **argv)
 				if (strcmp(*argv, "all") == 0) {
 					filter.tb = 0;
 				} else if (strcmp(*argv, "help") == 0) {
-					usage();
+					usage(true);
 				} else {
 					invarg("table id value is invalid\n", *argv);
 				}
@@ -277,7 +277,7 @@ static int mroute_list(int argc, char **argv)
 				NEXT_ARG();
 			}
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (get_prefix(&filter.mdst, *argv, preferred_family))
 				invarg("to value is invalid\n", *argv);
 		}
@@ -320,7 +320,7 @@ int do_multiroute(int argc, char **argv)
 	    || matches(*argv, "lst") == 0)
 		return mroute_list(argc-1, argv+1);
 	if (matches(*argv, "help") == 0)
-		usage();
+		usage(true);
 	fprintf(stderr, "Command \"%s\" is unknown, try \"ip mroute help\".\n", *argv);
 	exit(-1);
 }
diff --git a/ip/ipneigh.c b/ip/ipneigh.c
index be537187..475268fd 100644
--- a/ip/ipneigh.c
+++ b/ip/ipneigh.c
@@ -39,11 +39,11 @@ static struct
 	__u8 ndm_flags;
 } filter;
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip neigh { add | del | change | replace }\n"
 		"                { ADDR [ lladdr LLADDR ] [ nud STATE ] proxy ADDR }\n"
 		"                [ dev DEV ] [ router ] [ use ] [ managed ] [ extern_learn ]\n"
@@ -55,7 +55,7 @@ static void usage(void)
 		"\n"
 		"STATE := { delay | failed | incomplete | noarp | none |\n"
 		"           permanent | probe | reachable | stale }\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int nud_state_a2n(unsigned int *state, const char *arg)
@@ -136,7 +136,7 @@ static int ipneigh_modify(int cmd, int flags, int argc, char **argv)
 		} else if (matches(*argv, "proxy") == 0) {
 			NEXT_ARG();
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (dst_ok)
 				duparg("address", *argv);
 			get_addr(&dst, *argv, preferred_family);
@@ -585,7 +585,7 @@ static int do_show_or_flush(int argc, char **argv, int flush)
 				NEXT_ARG();
 			}
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (get_prefix(&filter.pfx, *argv, filter.family))
 				invarg("to value is invalid\n", *argv);
 			if (filter.family == AF_UNSPEC)
@@ -686,7 +686,7 @@ static int ipneigh_get(int argc, char **argv)
 		} else if (matches(*argv, "proxy") == 0) {
 			NEXT_ARG();
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (dst_ok)
 				duparg("address", *argv);
 			get_addr(&dst, *argv, preferred_family);
@@ -698,7 +698,7 @@ static int ipneigh_get(int argc, char **argv)
 				NEXT_ARG();
 
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (dst_ok)
 				duparg2("to", *argv);
 			get_addr(&dst, *argv, preferred_family);
@@ -762,7 +762,7 @@ int do_ipneigh(int argc, char **argv)
 		if (matches(*argv, "flush") == 0)
 			return do_show_or_flush(argc-1, argv+1, 1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else
 		return do_show_or_flush(0, NULL, 0);
 
diff --git a/ip/ipnetconf.c b/ip/ipnetconf.c
index 57bb99d1..269e9596 100644
--- a/ip/ipnetconf.c
+++ b/ip/ipnetconf.c
@@ -28,12 +28,12 @@ static const char * const rp_filter_names[] = {
 	"off", "strict", "loose"
 };
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr, "Usage: ip netconf show [ dev STRING ]\n");
-	exit(-1);
+	fprintf(help ? stdout : stderr, "Usage: ip netconf show [ dev STRING ]\n");
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static struct rtattr *netconf_rta(struct netconfmsg *ncm)
@@ -238,7 +238,7 @@ int do_ipnetconf(int argc, char **argv)
 		    matches(*argv, "list") == 0)
 			return do_show(argc-1, argv+1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else
 		return do_show(0, NULL);
 
diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 587534ae..ec0c567b 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -24,9 +24,9 @@
 #include "ip_common.h"
 #include "namespace.h"
 
-static int usage(void)
+static int usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage:	ip netns list\n"
 		"	ip netns add NAME\n"
 		"	ip netns attach NAME PID\n"
@@ -38,7 +38,7 @@ static int usage(void)
 		"	ip netns monitor\n"
 		"	ip netns list-id [target-nsid POSITIVE-INT] [nsid POSITIVE-INT]\n"
 		"NETNSID := auto | POSITIVE-INT\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 /* This socket is used to get nsid */
@@ -421,7 +421,7 @@ static int netns_list_id(int argc, char **argv)
 				invarg("\"nsid\" value should be >= 0",
 				       argv[1]);
 		} else
-			usage();
+			usage(false);
 		argc--; argv++;
 	}
 
@@ -1013,7 +1013,7 @@ int do_netns(int argc, char **argv)
 	}
 
 	if (matches(*argv, "help") == 0)
-		return usage();
+		return usage(true);
 
 	if (matches(*argv, "add") == 0)
 		return netns_add(argc-1, argv+1, true);
diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index ad8ad0c0..e5a6d775 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -39,11 +39,11 @@ enum {
 static struct hlist_head nh_cache[NH_CACHE_SIZE];
 static struct rtnl_handle nh_cache_rth = { .fd = -1 };
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip nexthop { list | flush } [ protocol ID ] SELECTOR\n"
 		"       ip nexthop { add | replace } id ID NH [ protocol ID ]\n"
 		"       ip nexthop { get | del } id ID\n"
@@ -63,7 +63,7 @@ static void usage(void)
 		"                  [ unbalanced_timer UNBALANCED ]\n"
 		"ENCAPTYPE := [ mpls ]\n"
 		"ENCAPHDR := [ MPLSLABEL ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int nh_dump_filter(struct nlmsghdr *nlh, int reqlen)
@@ -1154,7 +1154,7 @@ static int ipnh_modify(int cmd, unsigned int flags, int argc, char **argv)
 			addattr32(&req.n, sizeof(req), NHA_HW_STATS_ENABLE,
 				  hw_stats);
 		} else if (strcmp(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			invarg("", *argv);
 		}
@@ -1251,7 +1251,7 @@ static int ipnh_list_flush(int argc, char **argv, int action)
 		} else if (!matches(*argv, "fdb")) {
 			filter.fdb = 1;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			invarg("", *argv);
 		}
@@ -1290,13 +1290,13 @@ static int ipnh_get(int argc, char **argv)
 			NEXT_ARG();
 			id = ipnh_parse_id(*argv);
 		} else  {
-			usage();
+			usage(false);
 		}
 		argc--; argv++;
 	}
 
 	if (!id) {
-		usage();
+		usage(false);
 		return -1;
 	}
 
@@ -1330,7 +1330,7 @@ static int ipnh_bucket_list(int argc, char **argv)
 			NEXT_ARG();
 			filter.nhid = ipnh_parse_id(*argv);
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			invarg("", *argv);
 		}
@@ -1414,13 +1414,13 @@ static int ipnh_bucket_get(int argc, char **argv)
 				invarg("invalid bucket index value", *argv);
 			bucket_valid = true;
 		} else  {
-			usage();
+			usage(false);
 		}
 		argc--; argv++;
 	}
 
 	if (!id || !bucket_valid) {
-		usage();
+		usage(false);
 		return -1;
 	}
 
@@ -1441,7 +1441,7 @@ static int do_ipnh_bucket(int argc, char **argv)
 		return ipnh_bucket_get(argc-1, argv+1);
 
 	if (!matches(*argv, "help"))
-		usage();
+		usage(true);
 
 	fprintf(stderr,
 		"Command \"%s\" is unknown, try \"ip nexthop help\".\n", *argv);
@@ -1477,7 +1477,7 @@ int do_ipnh(int argc, char **argv)
 		return do_ipnh_bucket(argc-1, argv+1);
 
 	if (!matches(*argv, "help"))
-		usage();
+		usage(true);
 
 	fprintf(stderr,
 		"Command \"%s\" is unknown, try \"ip nexthop help\".\n", *argv);
diff --git a/ip/ipntable.c b/ip/ipntable.c
index 51fa067c..103ab6e3 100644
--- a/ip/ipntable.c
+++ b/ip/ipntable.c
@@ -27,11 +27,11 @@ static struct
 	const char *name;
 } filter;
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip ntable change name NAME [ dev DEV ]\n"
 		"        [ thresh1 VAL ] [ thresh2 VAL ] [ thresh3 VAL ] [ gc_int MSEC ]\n"
 		"        [ PARMS ]\n"
@@ -45,7 +45,7 @@ static void usage(void)
 		"         [ locktime MSEC ]\n"
 		);
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int ipntable_modify(int cmd, int flags, int argc, char **argv)
@@ -695,7 +695,7 @@ int do_ipntable(int argc, char **argv)
 		    matches(*argv, "list") == 0)
 			return ipntable_show(argc-1, argv+1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else
 		return ipntable_show(0, NULL);
 
diff --git a/ip/iproute.c b/ip/iproute.c
index 1ce71f78..7dd57db6 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -52,11 +52,11 @@ static const char *mx_names[RTAX_MAX+1] = {
 	[RTAX_CC_ALGO]			= "congctl",
 	[RTAX_FASTOPEN_NO_COOKIE]	= "fastopen_no_cookie"
 };
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip route { list | flush } SELECTOR\n"
 		"       ip route save SELECTOR\n"
 		"       ip route restore\n"
@@ -116,7 +116,7 @@ static void usage(void)
 		"XFRMINFO := if_id IF_ID [ link_dev LINK ]\n"
 		"ROUTE_GET_FLAGS := ROUTE_GET_FLAG [ ROUTE_GET_FLAGS ]\n"
 		"ROUTE_GET_FLAG := [ connected | fibmatch | notify ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 
@@ -1566,7 +1566,7 @@ static int iproute_modify(int cmd, unsigned int flags, int argc, char **argv)
 			}
 
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (dst_ok)
 				duparg2("to", *argv);
 			get_prefix(&dst, *argv, req.r.rtm_family);
@@ -1582,7 +1582,7 @@ static int iproute_modify(int cmd, unsigned int flags, int argc, char **argv)
 	}
 
 	if (!dst_ok)
-		usage();
+		usage(false);
 
 	if (d) {
 		int idx = ll_name_to_index(d);
@@ -1851,7 +1851,7 @@ static int iproute_list_flush_or_save(int argc, char **argv, int action)
 				} else if (strcmp(*argv, "cache") == 0) {
 					filter.cloned = 1;
 				} else if (strcmp(*argv, "help") == 0) {
-					usage();
+					usage(true);
 				} else {
 					invarg("table id value is invalid\n", *argv);
 				}
@@ -2078,7 +2078,7 @@ static int iproute_get(int argc, char **argv)
 
 			NEXT_ARG();
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			from_ok = 1;
 			get_prefix(&addr, *argv, req.r.rtm_family);
 			if (req.r.rtm_family == AF_UNSPEC)
@@ -2165,7 +2165,7 @@ static int iproute_get(int argc, char **argv)
 				NEXT_ARG();
 			}
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			get_prefix(&addr, *argv, req.r.rtm_family);
 			if (req.r.rtm_family == AF_UNSPEC)
 				req.r.rtm_family = addr.family;
@@ -2455,7 +2455,7 @@ int do_iproute(int argc, char **argv)
 	if (matches(*argv, "showdump") == 0)
 		return iproute_showdump();
 	if (matches(*argv, "help") == 0)
-		usage();
+		usage(true);
 
 	fprintf(stderr,
 		"Command \"%s\" is unknown, try \"ip route help\".\n", *argv);
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 9a1e747c..513d16e1 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -60,17 +60,18 @@ static const char *format_encap_type(uint16_t type)
 	}
 }
 
-static void encap_type_usage(void)
+static void encap_type_usage(bool help)
 {
+	FILE *fp = help ? stdout : stderr;
 	uint16_t i;
 
-	fprintf(stderr, "Usage: ip route ... encap TYPE [ OPTIONS ] [...]\n");
+	fprintf(fp, "Usage: ip route ... encap TYPE [ OPTIONS ] [...]\n");
 
 	for (i = 1; i <= LWTUNNEL_ENCAP_MAX; i++)
-		fprintf(stderr, "%s %s\n", format_encap_type(i),
+		fprintf(fp, "%s %s\n", format_encap_type(i),
 			i == 1 ? "TYPE := " : "      ");
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static uint16_t read_encap_type(const char *name)
@@ -96,7 +97,7 @@ static uint16_t read_encap_type(const char *name)
 	else if (strcmp(name, "xfrm") == 0)
 		return LWTUNNEL_ENCAP_XFRM;
 	else if (strcmp(name, "help") == 0)
-		encap_type_usage();
+		encap_type_usage(true);
 
 	return LWTUNNEL_ENCAP_NONE;
 }
@@ -2182,11 +2183,13 @@ static int parse_encap_ip6(struct rtattr *rta, size_t len,
 	return ret;
 }
 
-static void lwt_bpf_usage(void)
+static void lwt_bpf_usage(bool help)
 {
-	fprintf(stderr, "Usage: ip route ... encap bpf [ in BPF ] [ out BPF ] [ xmit BPF ] [...]\n");
-	fprintf(stderr, "BPF := obj FILE [ section NAME ] [ verbose ]\n");
-	exit(-1);
+	FILE *fp = help ? stdout : stderr;
+
+	fprintf(fp, "Usage: ip route ... encap bpf [ in BPF ] [ out BPF ] [ xmit BPF ] [...]\n");
+	fprintf(fp, "BPF := obj FILE [ section NAME ] [ verbose ]\n");
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int parse_encap_bpf(struct rtattr *rta, size_t len, int *argcp,
@@ -2223,7 +2226,7 @@ static int parse_encap_bpf(struct rtattr *rta, size_t len, int *argcp,
 					      headroom);
 			headroom_set = 1;
 		} else if (strcmp(*argv, "help") == 0) {
-			lwt_bpf_usage();
+			lwt_bpf_usage(true);
 		} else {
 			break;
 		}
@@ -2240,10 +2243,10 @@ static int parse_encap_bpf(struct rtattr *rta, size_t len, int *argcp,
 	return 0;
 }
 
-static void lwt_xfrm_usage(void)
+static void lwt_xfrm_usage(bool help)
 {
-	fprintf(stderr, "Usage: ip route ... encap xfrm if_id IF_ID [ link_dev LINK ]\n");
-	exit(-1);
+	fprintf(help ? stdout : stderr, "Usage: ip route ... encap xfrm if_id IF_ID [ link_dev LINK ]\n");
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int parse_encap_xfrm(struct rtattr *rta, size_t len,
@@ -2275,7 +2278,7 @@ static int parse_encap_xfrm(struct rtattr *rta, size_t len,
 				exit(nodev(*argv));
 			ret = rta_addattr32(rta, len, LWT_XFRM_LINK, link);
 		} else if (!strcmp(*argv, "help")) {
-			lwt_xfrm_usage();
+			lwt_xfrm_usage(true);
 		}
 		if (ret)
 			break;
@@ -2283,7 +2286,7 @@ static int parse_encap_xfrm(struct rtattr *rta, size_t len,
 	}
 
 	if (!if_id_ok)
-		lwt_xfrm_usage();
+		lwt_xfrm_usage(false);
 
 	/* argv is currently the first unparsed argument,
 	 * but the lwt_parse_encap() caller will move to the next,
diff --git a/ip/iprule.c b/ip/iprule.c
index b56b1b18..6fde6004 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -34,11 +34,11 @@ enum list_action {
 
 extern struct rtnl_handle rth;
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip rule { add | del } SELECTOR ACTION\n"
 		"       ip rule { flush | save | restore }\n"
 		"       ip rule [ list [ SELECTOR ]]\n"
@@ -59,7 +59,7 @@ static void usage(void)
 		"SUPPRESSOR := [ suppress_prefixlength NUMBER ]\n"
 		"              [ suppress_ifgroup DEVGROUP ]\n"
 		"TABLE_ID := [ local | main | default | NUMBER ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static struct
@@ -1189,7 +1189,7 @@ static int iprule_modify(int cmd, int argc, char **argv)
 				NEXT_ARG();
 
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			else if (matches(*argv, "goto") == 0) {
 				__u32 target;
 
@@ -1252,7 +1252,7 @@ int do_iprule(int argc, char **argv)
 	} else if (matches(argv[0], "flush") == 0) {
 		return iprule_list_flush_or_save(argc-1, argv+1, IPRULE_FLUSH);
 	} else if (matches(argv[0], "help") == 0)
-		usage();
+		usage(true);
 
 	fprintf(stderr,
 		"Command \"%s\" is unknown, try \"ip rule help\".\n", *argv);
diff --git a/ip/ipseg6.c b/ip/ipseg6.c
index efd37227..e3e6a1e8 100644
--- a/ip/ipseg6.c
+++ b/ip/ipseg6.c
@@ -27,16 +27,16 @@
 
 #define HMAC_KEY_PROMPT "Enter secret for HMAC key ID (blank to delete): "
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip sr { COMMAND | help }\n"
 		"          ip sr hmac show\n"
 		"          ip sr hmac set KEYID ALGO\n"
 		"          ip sr tunsrc show\n"
 		"          ip sr tunsrc set ADDRESS\n"
 		"where  ALGO := { sha1 | sha256 }\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static struct rtnl_handle grth = { .fd = -1 };
@@ -204,8 +204,11 @@ static int seg6_do_cmd(void)
 
 int do_seg6(int argc, char **argv)
 {
-	if (argc < 1 || matches(*argv, "help") == 0)
-		usage();
+	if (argc < 1)
+		usage(false);
+
+	if (matches(*argv, "help") == 0)
+		usage(true);
 
 	memset(&opts, 0, sizeof(opts));
 
diff --git a/ip/iptoken.c b/ip/iptoken.c
index 8bd9b4dc..4381a56f 100644
--- a/ip/iptoken.c
+++ b/ip/iptoken.c
@@ -30,12 +30,13 @@ struct rtnl_dump_args {
 	int ifindex;
 };
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr, "Usage: ip token [ list | set | del | get ] [ TOKEN ] [ dev DEV ]\n");
-	exit(-1);
+	fprintf(help ? stdout : stderr,
+		"Usage: ip token [ list | set | del | get ] [ TOKEN ] [ dev DEV ]\n");
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int print_token(struct nlmsghdr *n, void *arg)
@@ -146,7 +147,7 @@ static int iptoken_set(int argc, char **argv, bool delete)
 			}
 		} else {
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (!have_token) {
 				get_prefix(&addr, *argv, req.ifi.ifi_family);
 				have_token = true;
@@ -195,7 +196,7 @@ int do_iptoken(int argc, char **argv)
 	} else if (matches(argv[0], "get") == 0) {
 		return iptoken_list(argc - 1, argv + 1);
 	} else if (matches(argv[0], "help") == 0)
-		usage();
+		usage(true);
 
 	fprintf(stderr, "Command \"%s\" is unknown, try \"ip token help\".\n", *argv);
 	exit(-1);
diff --git a/ip/iptunnel.c b/ip/iptunnel.c
index b6da1459..5929e1ef 100644
--- a/ip/iptunnel.c
+++ b/ip/iptunnel.c
@@ -24,11 +24,11 @@
 #include "ip_common.h"
 #include "tunnel.h"
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip tunnel { add | change | del | show | prl | 6rd } [ NAME ]\n"
 		"        [ mode { gre | ipip | isatap | sit | vti } ]\n"
 		"        [ remote ADDR ] [ local ADDR ]\n"
@@ -42,7 +42,7 @@ static void usage(void)
 		"       TOS  := { STRING | 00..ff | inherit | inherit/STRING | inherit/00..ff }\n"
 		"       TTL  := { 1..255 | inherit }\n"
 		"       KEY  := { DOTTED_QUAD | NUMBER }\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static void set_tunnel_proto(struct ip_tunnel_parm *p, int proto)
@@ -166,7 +166,7 @@ static int parse_args(int argc, char **argv, int cmd, struct ip_tunnel_parm *p)
 			if (strcmp(*argv, "name") == 0)
 				NEXT_ARG();
 			else if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 
 			if (p->name[0])
 				duparg2("name", *argv);
@@ -593,7 +593,7 @@ int do_iptunnel(int argc, char **argv)
 		if (matches(*argv, "6rd") == 0)
 			return do_6rd(argc - 1, argv + 1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else
 		return do_show(0, NULL);
 
diff --git a/ip/iptuntap.c b/ip/iptuntap.c
index 0f46fe6a..91de6050 100644
--- a/ip/iptuntap.c
+++ b/ip/iptuntap.c
@@ -31,18 +31,18 @@ static const char drv_name[] = "tun";
 
 #define TUNDEV "/dev/net/tun"
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip tuntap { add | del | show | list | lst | help } [ dev PHYS_DEV ]\n"
 		"       [ mode { tun | tap } ] [ user USER ] [ group GROUP ]\n"
 		"       [ one_queue ] [ pi ] [ vnet_hdr ] [ multi_queue ] [ name NAME ]\n"
 		"\n"
 		"Where: USER  := { STRING | NUMBER }\n"
 		"       GROUP := { STRING | NUMBER }\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int tap_add_ioctl(struct ifreq *ifr, uid_t uid, gid_t gid)
@@ -179,7 +179,7 @@ static int parse_args(int argc, char **argv,
 			if (matches(*argv, "name") == 0) {
 				NEXT_ARG();
 			} else if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (ifr->ifr_name[0])
 				duparg2("name", *argv);
 			if (get_ifname(ifr->ifr_name, *argv))
@@ -460,7 +460,7 @@ int do_iptuntap(int argc, char **argv)
 		    matches(*argv, "list") == 0)
 			return do_show(argc-1, argv+1);
 		if (matches(*argv, "help") == 0)
-			usage();
+			usage(true);
 	} else
 		return do_show(0, NULL);
 
diff --git a/ip/ipvrf.c b/ip/ipvrf.c
index e7c702ab..e2b897d2 100644
--- a/ip/ipvrf.c
+++ b/ip/ipvrf.c
@@ -30,15 +30,15 @@
 
 static struct link_filter vrf_filter;
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage:	ip vrf show [NAME] ...\n"
 		"	ip vrf exec [NAME] cmd ...\n"
 		"	ip vrf identify [PID]\n"
 		"	ip vrf pids [NAME]\n");
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 /*
@@ -585,7 +585,7 @@ static int ipvrf_show(int argc, char **argv)
 	vrf_filter.kind = "vrf";
 
 	if (argc > 1)
-		usage();
+		usage(false);
 
 	if (argc == 1) {
 		__u32 tb_id;
@@ -645,7 +645,7 @@ int do_ipvrf(int argc, char **argv)
 		return ipvrf_show(argc-1, argv+1);
 
 	if (matches(*argv, "help") == 0)
-		usage();
+		usage(true);
 
 	fprintf(stderr, "Command \"%s\" is unknown, try \"ip vrf help\".\n",
 		*argv);
diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
index 586d24fb..1765ec81 100644
--- a/ip/ipxfrm.c
+++ b/ip/ipxfrm.c
@@ -28,14 +28,14 @@
 
 struct xfrm_filter filter;
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip xfrm XFRM-OBJECT { COMMAND | help }\n"
 		"where  XFRM-OBJECT := state | policy | monitor\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 /* This is based on utils.c(inet_addr_match) */
@@ -1556,7 +1556,7 @@ int do_xfrm(int argc, char **argv)
 	memset(&filter, 0, sizeof(filter));
 
 	if (argc < 1)
-		usage();
+		usage(false);
 
 	if (matches(*argv, "state") == 0 ||
 	    matches(*argv, "sa") == 0)
@@ -1566,9 +1566,9 @@ int do_xfrm(int argc, char **argv)
 	else if (matches(*argv, "monitor") == 0)
 		return do_xfrm_monitor(argc-1, argv+1);
 	else if (matches(*argv, "help") == 0) {
-		usage();
+		usage(true);
 		fprintf(stderr, "xfrm Object \"%s\" is unknown.\n", *argv);
 		exit(-1);
 	}
-	usage();
+	usage(false);
 }
diff --git a/ip/link_veth.c b/ip/link_veth.c
index 6da5b64f..222e7f4b 100644
--- a/ip/link_veth.c
+++ b/ip/link_veth.c
@@ -12,15 +12,11 @@
 #include "utils.h"
 #include "ip_common.h"
 
-static void print_usage(FILE *f)
+static void print_usage(FILE *fp)
 {
-	printf("Usage: ip link <options> type veth [peer <options>]\n"
-	       "To get <options> type 'ip link add help'\n");
-}
-
-static void usage(void)
-{
-	print_usage(stderr);
+	fprintf(fp,
+		"Usage: ip link <options> type veth [peer <options>]\n"
+		"To get <options> type 'ip link add help'\n");
 }
 
 static int veth_parse_opt(struct link_util *lu, int argc, char **argv,
@@ -33,7 +29,7 @@ static int veth_parse_opt(struct link_util *lu, int argc, char **argv,
 	unsigned int ifi_flags, ifi_change, ifi_index;
 
 	if (strcmp(argv[0], "peer") != 0) {
-		usage();
+		print_usage(stderr);
 		return -1;
 	}
 
diff --git a/ip/rtmon.c b/ip/rtmon.c
index 470f4ba6..ef49da1e 100644
--- a/ip/rtmon.c
+++ b/ip/rtmon.c
@@ -55,14 +55,14 @@ static int dump_msg2(struct nlmsghdr *n, void *arg)
 	return dump_msg(NULL, n, arg);
 }
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: rtmon [ OPTIONS ] file FILE [ all | OBJECTS ]\n"
 		"OPTIONS := { -f[amily] { inet | inet6 | link | help } |\n"
 		"             -4 | -6 | -0 | -V[ersion] }\n"
 		"OBJECTS := [ link ] [ address ] [ route ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 int
@@ -90,7 +90,7 @@ main(int argc, char **argv)
 			else if (strcmp(argv[1], "link") == 0)
 				family = AF_INET6;
 			else if (strcmp(argv[1], "help") == 0)
-				usage();
+				usage(true);
 			else {
 				fprintf(stderr, "Protocol ID \"%s\" is unknown, try \"rtmon help\".\n", argv[1]);
 				exit(-1);
@@ -122,7 +122,7 @@ main(int argc, char **argv)
 		} else if (strcmp(argv[1], "all") == 0) {
 			groups = ~0U;
 		} else if (matches(argv[1], "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			fprintf(stderr, "Argument \"%s\" is unknown, try \"rtmon help\".\n", argv[1]);
 			exit(-1);
diff --git a/ip/tcp_metrics.c b/ip/tcp_metrics.c
index 6b9e6831..a5fdfb4d 100644
--- a/ip/tcp_metrics.c
+++ b/ip/tcp_metrics.c
@@ -23,14 +23,14 @@
 #include "ip_common.h"
 #include "libgenl.h"
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage:	ip tcp_metrics/tcpmetrics { COMMAND | help }\n"
 		"	ip tcp_metrics { show | flush } SELECTOR\n"
 		"	ip tcp_metrics delete [ address ] ADDRESS\n"
 		"SELECTOR := [ [ address ] PREFIX ]\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 /* netlink socket */
@@ -366,7 +366,7 @@ static int tcpm_do_cmd(int cmd, int argc, char **argv)
 
 			NEXT_ARG();
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (f.saddr.bitlen >= 0)
 				duparg2(who, *argv);
 
@@ -392,7 +392,7 @@ static int tcpm_do_cmd(int cmd, int argc, char **argv)
 				NEXT_ARG();
 			}
 			if (matches(*argv, "help") == 0)
-				usage();
+				usage(true);
 			if (f.daddr.bitlen >= 0)
 				duparg2(who, *argv);
 
@@ -529,7 +529,7 @@ int do_tcp_metrics(int argc, char **argv)
 			return tcpm_do_cmd(cmds[i].code, argc-1, argv+1);
 	}
 	if (matches(argv[0], "help") == 0)
-		usage();
+		usage(true);
 
 	fprintf(stderr, "Command \"%s\" is unknown, try \"ip tcp_metrics help\".\n",
 			*argv);
diff --git a/ip/xfrm_monitor.c b/ip/xfrm_monitor.c
index a96358b0..7f6f088a 100644
--- a/ip/xfrm_monitor.c
+++ b/ip/xfrm_monitor.c
@@ -17,16 +17,16 @@
 #include "xfrm.h"
 #include "ip_common.h"
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 static int listen_all_nsid;
 static bool nokeys;
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	fprintf(help ? stdout : stderr,
 		"Usage: ip xfrm monitor [ nokeys ] [ all-nsid ] [ all | OBJECTS | help ]\n"
 		"OBJECTS := { acquire | expire | SA | aevent | policy | report }\n");
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int xfrm_acquire_print(struct nlmsghdr *n, void *arg)
@@ -361,7 +361,7 @@ int do_xfrm_monitor(int argc, char **argv)
 			lreport = 1;
 			groups = 0;
 		} else if (matches(*argv, "help") == 0) {
-			usage();
+			usage(true);
 		} else {
 			fprintf(stderr, "Argument \"%s\" is unknown, try \"ip xfrm monitor help\".\n", *argv);
 			exit(-1);
diff --git a/ip/xfrm_policy.c b/ip/xfrm_policy.c
index e60acd5b..79fe59f3 100644
--- a/ip/xfrm_policy.c
+++ b/ip/xfrm_policy.c
@@ -32,11 +32,13 @@
 #define XFRM_TMPLS_BUF_SIZE 1024
 #define CTX_BUF_SIZE 256
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	FILE *fp = help ? stdout : stderr;
+
+	fprintf(fp,
 		"Usage: ip xfrm policy { add | update } SELECTOR dir DIR [ ctx CTX ]\n"
 		"	[ mark MARK [ mask MASK ] ] [ index INDEX ] [ ptype PTYPE ]\n"
 		"	[ action ACTION ] [ priority PRIORITY ] [ flag FLAG-LIST ]\n"
@@ -69,18 +71,18 @@ static void usage(void)
 		"TMPL := ID [ mode MODE ] [ reqid REQID ] [ level LEVEL ]\n"
 		"ID := [ src ADDR ] [ dst ADDR ] [ proto XFRM-PROTO ] [ spi SPI ]\n"
 		"XFRM-PROTO := ");
-	fprintf(stderr,
+	fprintf(fp,
 		"%s | %s | %s | %s | %s\n",
 		strxf_xfrmproto(IPPROTO_ESP),
 		strxf_xfrmproto(IPPROTO_AH),
 		strxf_xfrmproto(IPPROTO_COMP),
 		strxf_xfrmproto(IPPROTO_ROUTING),
 		strxf_xfrmproto(IPPROTO_DSTOPTS));
-	fprintf(stderr,
+	fprintf(fp,
 		"MODE := transport | tunnel | beet | ro | in_trigger\n"
 		"LEVEL := required | use\n");
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int xfrm_policy_dir_parse(__u8 *dir, int *argcp, char ***argvp)
@@ -1340,7 +1342,7 @@ int do_xfrm_policy(int argc, char **argv)
 	if (matches(*argv, "getdefault") == 0)
 		return xfrm_spd_getdefault(argc-1, argv+1);
 	if (matches(*argv, "help") == 0)
-		usage();
+		usage(true);
 	fprintf(stderr, "Command \"%s\" is unknown, try \"ip xfrm policy help\".\n", *argv);
 	exit(-1);
 }
diff --git a/ip/xfrm_state.c b/ip/xfrm_state.c
index dcd08d59..d344ddc9 100644
--- a/ip/xfrm_state.c
+++ b/ip/xfrm_state.c
@@ -34,11 +34,13 @@
 #define XFRM_ALGO_KEY_BUF_SIZE 512
 #define CTX_BUF_SIZE 256
 
-static void usage(void) __attribute__((noreturn));
+static void usage(bool help) __attribute__((noreturn));
 
-static void usage(void)
+static void usage(bool help)
 {
-	fprintf(stderr,
+	FILE *fp = help ? stdout : stderr;
+
+	fprintf(fp,
 		"Usage: ip xfrm state { add | update } ID [ ALGO-LIST ] [ mode MODE ]\n"
 		"        [ mark MARK [ mask MASK ] ] [ reqid REQID ] [ dir DIR ] [ seq SEQ ]\n"
 		"        [ replay-window SIZE ] [ replay-seq SEQ ] [ replay-oseq SEQ ]\n"
@@ -59,30 +61,30 @@ static void usage(void)
 		"Usage: ip xfrm state count\n"
 		"ID := [ src ADDR ] [ dst ADDR ] [ proto XFRM-PROTO ] [ spi SPI ]\n"
 		"XFRM-PROTO := ");
-	fprintf(stderr,
+	fprintf(fp,
 		"%s | %s | %s | %s | %s\n",
 		strxf_xfrmproto(IPPROTO_ESP),
 		strxf_xfrmproto(IPPROTO_AH),
 		strxf_xfrmproto(IPPROTO_COMP),
 		strxf_xfrmproto(IPPROTO_ROUTING),
 		strxf_xfrmproto(IPPROTO_DSTOPTS));
-	fprintf(stderr,
+	fprintf(fp,
 		"ALGO-LIST := [ ALGO-LIST ] ALGO\n"
 		"ALGO := { ");
-	fprintf(stderr,
+	fprintf(fp,
 		"%s | %s",
 		strxf_algotype(XFRMA_ALG_CRYPT),
 		strxf_algotype(XFRMA_ALG_AUTH));
-	fprintf(stderr,
+	fprintf(fp,
 		" } ALGO-NAME ALGO-KEYMAT |\n"
 		"        %s", strxf_algotype(XFRMA_ALG_AUTH_TRUNC));
-	fprintf(stderr,
+	fprintf(fp,
 		" ALGO-NAME ALGO-KEYMAT ALGO-TRUNC-LEN |\n"
 		"        %s", strxf_algotype(XFRMA_ALG_AEAD));
-	fprintf(stderr,
+	fprintf(fp,
 		" ALGO-NAME ALGO-KEYMAT ALGO-ICV-LEN |\n"
 		"        %s", strxf_algotype(XFRMA_ALG_COMP));
-	fprintf(stderr,
+	fprintf(fp,
 		" ALGO-NAME\n"
 		"MODE := transport | tunnel | beet | ro | in_trigger\n"
 		"FLAG-LIST := [ FLAG-LIST ] FLAG\n"
@@ -99,7 +101,7 @@ static void usage(void)
 		"ENCAP := { espinudp | espinudp-nonike | espintcp } SPORT DPORT OADDR\n"
 		"DIR := in | out\n");
 
-	exit(-1);
+	exit(help ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static int xfrm_algo_parse(struct xfrm_algo *alg, enum xfrm_attr_type_t type,
@@ -1512,7 +1514,7 @@ int do_xfrm_state(int argc, char **argv)
 		return xfrm_sad_getinfo(argc, argv);
 	}
 	if (matches(*argv, "help") == 0)
-		usage();
+		usage(true);
 	fprintf(stderr, "Command \"%s\" is unknown, try \"ip xfrm state help\".\n", *argv);
 	exit(-1);
 }
-- 
2.53.0

