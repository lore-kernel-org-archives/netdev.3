Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4A332610
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228560; cv=none; b=O/bIVuu6Sxj/MvXvCi1da47eAYNOgIKVbP+IhPrsuNSkekvmcx8U4EspoR5ziesuQtwYNKhUdLq0JdEbFtHjfK7UhmSBmmCtxqUxDLEhE3kzdeDjHiCrSzCRGl7nsFsn6RMyngZJ5mzS8PLjrdFNVQQ7t0tnX/+z+3BdUJXKkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228560; c=relaxed/simple;
	bh=YGU38iWOalQgHAWQKQMSTt/fouwTMVhRIBxKh8Ei6vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGEvdKQpLcnj1sAzQbK/6F+WAeeDjjw8DGcXtWa0wQVVxhR34Kh8cGK/xTzgc6grUK9JT/SWBWw1p+XV7iKN6z7fKQK0Sv+I+egUsB7UpQIid7sVujgZ2l4HRo2jo8OGrOHwRJjlvySZOfApXFnm+NhPSy343i9KRoP8bA1T088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWVNKm36; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWVNKm36"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so4674746a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 19:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788228547; x=1788833347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/74I/f6VOp4GuhdP6EPHOwPFDkGuB7KMPs8YM8qiBco=;
        b=QWVNKm36fHzIK+rHmNeWCpRYocMbY6S3q4qwxcgKXqCdFdstk/XOxftDDWer823F81
         Q3uEht86BFJNsEtAxx7tQzEbhUzgd5tL3eRDKmsVvuOkbWROrp+e+mVU4lbrTVk3ZamI
         IMomwVkhnE3Q+ScEJA749e51yk3N9NQ1cyUoGlSpgtGP4ypOeWr13S3NpbsV9tIa6Awm
         +O4FsR2MqIWNiBF+HwD4T1/GILcFPRTyEb6wTGSTopLRtyVhkjQbK9jOjZ/mBW2fYenz
         Q0G0gtNNOzRt+1xv1U1PcUYH7Ha2E/yglVBOPP/xtMeY3tkj9tZwv/slXjpnPWudy9cM
         cLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788228547; x=1788833347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/74I/f6VOp4GuhdP6EPHOwPFDkGuB7KMPs8YM8qiBco=;
        b=LkQdrpNNh4TOVIMmlrRb/XQYVqTem0CCa/6MTVfm5bX75/vAeR98zWLyV23zqBZOle
         x3tIBBFR/Nfw5M2AroJn61GjBSGzC18QuLgsFHoW9lhRJ8lI5HCsDT2wtbZLojWQgj8X
         9m8sQIH3uQwnDW45OHC4G5XTY3WwEtV8kviza+p+0d/5Tncj+A7TPXwSHqntBYIJra/T
         kHemgvq/qIw36zeVNAdpF+ccK64hx+2YKCHbNgZzGfx48uVq+BqVUAMOfRpq62GjxQ5b
         fpPg65X3B3eIu2AptVs/G9g6Tsf/flNl+unYag0WPnWVDbT01ljHZW1ZUYysNKH33v1D
         ZaZA==
X-Forwarded-Encrypted: i=1; AKwUvBz/2b2AV3LcSH1quw0arzECeAZo0MatGnfVjOlxsghWa00zyRGYKPZxrT5VcfU/5Tcp3e+nRms=@vger.kernel.org
X-Gm-Message-State: AFuF++le+lWAkVn6wt/9shy4fMJM/ig6XuLv/ouZ+PPrv24Bv9gtAgni
	q1hFHTf/ovGN0ZliT3cGUUSU9d1YpwuqrEvveKTmLzk6upQxde86y7R/
X-Gm-Gg: AYBFou3G80LpL08Qw7qSwtcgZcVfDZveI5YmZHN/I1FG80ksxBZk577OeV0S3TdT4Fj
	oBdLfL0DXiAj52om3uosAtp3eJUOpbXJfBNl4Bz2u/96ykS7ssvI67XoEgg6Z35kPEF/Segm8lS
	HkpgFuxgZSvh0P/zPfl6ZvTxHKBKAzz2P7cCcIEJV3BuctPQ/g9g+wesqgZ2a6hLcJA74mq4mpH
	HIfhl8hNDmmjSqV/mOFrAyza6WSW2ui62PSHnij31bl3CEnJQ0rPpr+MZKbuw5OvXoWXOAYcgrO
	bvbHidaUTZEkuR8KizalZsIdqY+F0JvQr4+qIv1aRXJL0aro3VsN/3b3xWPHLRY8Kd/b8C5+K6P
	PSrJvrBAuOCQ2/rRbuORFeKBuiafr0VQShajq4TSH5FiUnJToIfPp8n8IZLdddGJMKSB9tqHlOW
	Ep85XcTjn9jkq56aL5ylD1IdZPAw38WCDeOSp74/z839lRT+iZwSUPk973f1mm+ljFChs32l8=
X-Received: by 2002:a17:90b:3904:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-39907ed4294mr5767937a91.23.1788228546808;
        Mon, 31 Aug 2026 19:09:06 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d463798sm2569822a91.6.2026.08.31.19.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 19:09:05 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 01 Sep 2026 11:09:00 +0900
Subject: [PATCH RFC iproute2-next v2 2/2] seg6: add support for the End.MAP
 behavior under seg6mobile encap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-seg6-mobile-end-map-v2-2-05b2ad78b922@gmail.com>
References: <20260901-seg6-mobile-end-map-v2-0-05b2ad78b922@gmail.com>
In-Reply-To: <20260901-seg6-mobile-end-map-v2-0-05b2ad78b922@gmail.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10651;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=YGU38iWOalQgHAWQKQMSTt/fouwTMVhRIBxKh8Ei6vY=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqljO71dBnNyAGKUhpJyMspJFHQ7aGVwhl7G6HP
 DxCqEcR31SJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCapYzuwAKCRAq19F1Kl0b
 TeRREACa6zZtdMnyLv5P6LtXLbJApetmBFwXvd6f+wBsD7+5Pq6ToBF/TiDZwXI+Gh76Jvr/zE3
 8z0K+sbdj6rWES7hfIB1a+et3inhhwT2c0cx9IeQjipd015tBxrX1iQ8xkjjI/ykxBCQCnIuH7l
 XQsKYfvc0XXubMEjv7MUN75wteW62HwWPAd3G0+Oq54f2w85vNKgFxgdsdLd1fGSgT/garnAFlB
 SPYMkz58ySqvhnuSbtSinskzHKmHLwqbpbMsNLbm04uymq5sHBvNOdfI8mmj29EUUWOsAYPhMWa
 Se7fkKt7dgzk/sygYemqHoebYdfiMBgUqsgG/ssDCzqKzT6Z2oOGpgZylMpl9w6haBtblN0zqal
 ddTWiqMe7Zp4hxbwY7yIxyJ77qWx5igW5RY8OaQJQgh0wJ1i04bSszWvbciBFhboRcfR0NnJ5Gl
 PD0eX8/07NOSZTYqUXFYPqEr9MUrZTXCG7JzcEoR4+MaGlkesEC5pRannJ4JANo93qyg3kUtBHq
 pNPGO5wkxrugo8M2TpG8SUIVbwkc/x6FMPG+XgKYzYHIYoBF6brXiliDyAbzmCIY6T9ZRWetEqJ
 LmjYcxhFjesAvu83Y779b32KaVa62L2BBzUVfW/fiMTkIZFpyne8nzuWSmmlTJ4lPC2mTYzYWAm
 0VlLDIrRwyYhGCA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

Wire up a new "seg6mobile" lightweight tunnel encap type that mirrors
the kernel's LWTUNNEL_ENCAP_SEG6_MOBILE namespace, and add parse and
print support for the first RFC 9433 behavior it carries: End.MAP.

End.MAP swaps the IPv6 destination address with the configured mapped SID
and forwards the packet via the IPv6 FIB without consuming the SRH:

    ip -6 route add 2001:db8:f::/64 \
        encap seg6mobile action End.MAP mapped_sid 2001:db8:2::e \
        dev <dev>

Help text and the ip-route(8) man page get the corresponding ENCAPTYPE
and SEG6MOBILE entries.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 ip/iproute.c           |   6 +-
 ip/iproute_lwtunnel.c  | 173 +++++++++++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in |  34 +++++++++-
 3 files changed, 210 insertions(+), 3 deletions(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index 1ce71f78e064..27def3b7e346 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -98,8 +98,8 @@ static void usage(void)
 		"TIME := NUMBER[s|ms]\n"
 		"BOOL := [1|0]\n"
 		"FEATURES := ecn\n"
-		"ENCAPTYPE := [ mpls | ip | ip6 | seg6 | seg6local | rpl | ioam6 | xfrm ]\n"
-		"ENCAPHDR := [ MPLSLABEL | SEG6HDR | SEG6LOCAL | IOAM6HDR | XFRMINFO ]\n"
+		"ENCAPTYPE := [ mpls | ip | ip6 | seg6 | seg6local | seg6mobile | rpl | ioam6 | xfrm ]\n"
+		"ENCAPHDR := [ MPLSLABEL | SEG6HDR | SEG6LOCAL | SEG6MOBILE | IOAM6HDR | XFRMINFO ]\n"
 		"SEG6HDR := [ mode SEGMODE ] segs ADDR1,ADDRi,ADDRn [hmac HMACKEYID] [cleanup]\n"
 		"           [ lookup TABLEID ]\n"
 		"SEGMODE := [ encap | encap.red | inline | l2encap | l2encap.red ]\n"
@@ -112,6 +112,8 @@ static void usage(void)
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME }\n"
 		"FLAVORS := { FLAVOR[,FLAVOR] }\n"
 		"FLAVOR := { psp | usp | usd | next-csid }\n"
+		"SEG6MOBILE := action MOBILE_ACTION mapped_sid ADDR [ count ]\n"
+		"MOBILE_ACTION := { End.MAP }\n"
 		"IOAM6HDR := trace prealloc type IOAM6_TRACE_TYPE ns IOAM6_NAMESPACE size IOAM6_TRACE_SIZE\n"
 		"XFRMINFO := if_id IF_ID [ link_dev LINK ]\n"
 		"ROUTE_GET_FLAGS := ROUTE_GET_FLAG [ ROUTE_GET_FLAGS ]\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 9a1e747c6951..b3a2388906ec 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -28,6 +28,7 @@
 #include <linux/rpl_iptunnel.h>
 #include <linux/seg6_hmac.h>
 #include <linux/seg6_local.h>
+#include <linux/seg6_mobile.h>
 #include <linux/if_tunnel.h>
 #include <linux/ioam6.h>
 #include <linux/ioam6_iptunnel.h>
@@ -55,6 +56,8 @@ static const char *format_encap_type(uint16_t type)
 		return "ioam6";
 	case LWTUNNEL_ENCAP_XFRM:
 		return "xfrm";
+	case LWTUNNEL_ENCAP_SEG6_MOBILE:
+		return "seg6mobile";
 	default:
 		return "unknown";
 	}
@@ -95,6 +98,8 @@ static uint16_t read_encap_type(const char *name)
 		return LWTUNNEL_ENCAP_IOAM6;
 	else if (strcmp(name, "xfrm") == 0)
 		return LWTUNNEL_ENCAP_XFRM;
+	else if (strcmp(name, "seg6mobile") == 0)
+		return LWTUNNEL_ENCAP_SEG6_MOBILE;
 	else if (strcmp(name, "help") == 0)
 		encap_type_usage();
 
@@ -585,6 +590,91 @@ static void print_encap_seg6local(FILE *fp, struct rtattr *encap)
 		print_seg6_local_flavors(fp, tb[SEG6_LOCAL_FLAVORS]);
 }
 
+static const char *seg6_mobile_action_names[SEG6_MOBILE_ACTION_MAX + 1] = {
+	[SEG6_MOBILE_ACTION_END_MAP]	= "End.MAP",
+};
+
+static const char *format_seg6_mobile_action(int action)
+{
+	if (action < 0 || action > SEG6_MOBILE_ACTION_MAX)
+		return "<invalid>";
+
+	return seg6_mobile_action_names[action] ?: "<unknown>";
+}
+
+static int read_seg6_mobile_action(const char *name)
+{
+	int i;
+
+	for (i = 0; i < SEG6_MOBILE_ACTION_MAX + 1; i++) {
+		if (!seg6_mobile_action_names[i])
+			continue;
+
+		if (strcmp(seg6_mobile_action_names[i], name) == 0)
+			return i;
+	}
+
+	return SEG6_MOBILE_ACTION_UNSPEC;
+}
+
+static void print_seg6_mobile_counters(FILE *fp, struct rtattr *encap)
+{
+	struct rtattr *tb[SEG6_MOBILE_CNT_MAX + 1];
+	__u64 packets = 0, bytes = 0, errors = 0;
+
+	parse_rtattr_nested(tb, SEG6_MOBILE_CNT_MAX, encap);
+
+	if (tb[SEG6_MOBILE_CNT_PACKETS])
+		packets = rta_getattr_u64(tb[SEG6_MOBILE_CNT_PACKETS]);
+
+	if (tb[SEG6_MOBILE_CNT_BYTES])
+		bytes = rta_getattr_u64(tb[SEG6_MOBILE_CNT_BYTES]);
+
+	if (tb[SEG6_MOBILE_CNT_ERRORS])
+		errors = rta_getattr_u64(tb[SEG6_MOBILE_CNT_ERRORS]);
+
+	if (is_json_context()) {
+		open_json_object("stats64");
+
+		print_u64(PRINT_JSON, "packets", NULL, packets);
+		print_u64(PRINT_JSON, "bytes", NULL, bytes);
+		print_u64(PRINT_JSON, "errors", NULL, errors);
+
+		close_json_object();
+	} else {
+		print_string(PRINT_FP, NULL, "%s ", "packets");
+		print_num(fp, 1, packets);
+
+		print_string(PRINT_FP, NULL, "%s ", "bytes");
+		print_num(fp, 1, bytes);
+
+		print_string(PRINT_FP, NULL, "%s ", "errors");
+		print_num(fp, 1, errors);
+	}
+}
+
+static void print_encap_seg6mobile(FILE *fp, struct rtattr *encap)
+{
+	struct rtattr *tb[SEG6_MOBILE_MAX + 1];
+	int action;
+
+	parse_rtattr_nested(tb, SEG6_MOBILE_MAX, encap);
+
+	if (!tb[SEG6_MOBILE_ACTION])
+		return;
+
+	action = rta_getattr_u32(tb[SEG6_MOBILE_ACTION]);
+	print_string(PRINT_ANY, "action",
+		     "action %s ", format_seg6_mobile_action(action));
+
+	if (tb[SEG6_MOBILE_MAPPED_SID])
+		print_string(PRINT_ANY, "mapped_sid", "mapped_sid %s ",
+			     rt_addr_n2a_rta(AF_INET6, tb[SEG6_MOBILE_MAPPED_SID]));
+
+	if (tb[SEG6_MOBILE_COUNTERS] && show_stats)
+		print_seg6_mobile_counters(fp, tb[SEG6_MOBILE_COUNTERS]);
+}
+
 static void print_encap_mpls(FILE *fp, struct rtattr *encap)
 {
 	struct rtattr *tb[MPLS_IPTUNNEL_MAX+1];
@@ -900,6 +990,9 @@ void lwt_print_encap(FILE *fp, struct rtattr *encap_type,
 	case LWTUNNEL_ENCAP_XFRM:
 		print_encap_xfrm(fp, encap);
 		break;
+	case LWTUNNEL_ENCAP_SEG6_MOBILE:
+		print_encap_seg6mobile(fp, encap);
+		break;
 	}
 	close_json_object();
 }
@@ -1607,6 +1700,83 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	return ret;
 }
 
+/* for the moment, counters are always initialized to zero by the kernel; so we
+ * do not expect to parse any argument here.
+ */
+static int seg6mobile_fill_counters(struct rtattr *rta, size_t len, int attr)
+{
+	struct rtattr *nest;
+	int ret;
+
+	nest = rta_nest(rta, len, attr);
+
+	ret = rta_addattr64(rta, len, SEG6_MOBILE_CNT_PACKETS, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = rta_addattr64(rta, len, SEG6_MOBILE_CNT_BYTES, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = rta_addattr64(rta, len, SEG6_MOBILE_CNT_ERRORS, 0);
+	if (ret < 0)
+		return ret;
+
+	rta_nest_end(rta, nest);
+	return 0;
+}
+
+static int parse_encap_seg6mobile(struct rtattr *rta, size_t len, int *argcp,
+				  char ***argvp)
+{
+	int action_ok = 0, mapped_sid_ok = 0, counters_ok = 0;
+	char **argv = *argvp;
+	int argc = *argcp;
+	inet_prefix addr;
+	__u32 action = 0;
+	int ret = 0;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "action") == 0) {
+			NEXT_ARG();
+			if (action_ok++)
+				duparg2("action", *argv);
+			action = read_seg6_mobile_action(*argv);
+			if (!action)
+				invarg("\"action\" value is invalid\n", *argv);
+			ret = rta_addattr32(rta, len, SEG6_MOBILE_ACTION,
+					    action);
+		} else if (strcmp(*argv, "mapped_sid") == 0) {
+			NEXT_ARG();
+			if (mapped_sid_ok++)
+				duparg2("mapped_sid", *argv);
+			get_addr(&addr, *argv, AF_INET6);
+			ret = rta_addattr_l(rta, len, SEG6_MOBILE_MAPPED_SID,
+					    &addr.data, addr.bytelen);
+		} else if (strcmp(*argv, "count") == 0) {
+			if (counters_ok++)
+				duparg2("count", *argv);
+			ret = seg6mobile_fill_counters(rta, len,
+						       SEG6_MOBILE_COUNTERS);
+		} else {
+			break;
+		}
+		if (ret)
+			return ret;
+		argc--; argv++;
+	}
+
+	if (!action) {
+		fprintf(stderr, "Missing action type\n");
+		exit(-1);
+	}
+
+	*argcp = argc + 1;
+	*argvp = argv - 1;
+
+	return ret;
+}
+
 static int parse_encap_mpls(struct rtattr *rta, size_t len,
 			    int *argcp, char ***argvp)
 {
@@ -2346,6 +2516,9 @@ int lwt_parse_encap(struct rtattr *rta, size_t len, int *argcp, char ***argvp,
 	case LWTUNNEL_ENCAP_XFRM:
 		ret = parse_encap_xfrm(rta, len, &argc, &argv);
 		break;
+	case LWTUNNEL_ENCAP_SEG6_MOBILE:
+		ret = parse_encap_seg6mobile(rta, len, &argc, &argv);
+		break;
 	default:
 		fprintf(stderr, "Error: unsupported encap type\n");
 		break;
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index fd04432f599b..5a4777153967 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -195,7 +195,8 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .ti -8
 .IR ENCAP " := [ "
 .IR ENCAP_MPLS " | " ENCAP_IP " | " ENCAP_BPF " | "
-.IR ENCAP_SEG6 " | " ENCAP_SEG6LOCAL " | " ENCAP_IOAM6 " ] "
+.IR ENCAP_SEG6 " | " ENCAP_SEG6LOCAL " | " ENCAP_SEG6MOBILE " | "
+.IR ENCAP_IOAM6 " ] "
 
 .ti -8
 .IR ENCAP_MPLS " := "
@@ -258,6 +259,14 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .IR SEG6_ACTION_PARAM " ] [ "
 .BR count " ] "
 
+.ti -8
+.IR ENCAP_SEG6MOBILE " := "
+.B seg6mobile
+.BR action
+.IR SEG6_MOBILE_ACTION " [ "
+.IR SEG6_MOBILE_PARAM " ] [ "
+.BR count " ] "
+
 .ti -8
 .IR ENCAP_IOAM6 " := "
 .BR ioam6 " ["
@@ -764,6 +773,9 @@ is a string specifying the supported encapsulation type. Namely:
 .BI seg6local
 - local SRv6 segment processing
 .sp
+.BI seg6mobile
+- SRv6 Mobile User Plane processing (RFC 9433)
+.sp
 .BI ioam6
 - encapsulation type IPv6 IOAM
 .sp
@@ -1097,6 +1109,26 @@ flavors. The Locator-Node Function length must be greater than 0 and evenly
 divisible by 8. This attribute can be used only with NEXT-C-SID flavor.
 .in -4
 
+.B seg6mobile
+.in +2
+.IR SEG6_MOBILE_ACTION " [ "
+.IR SEG6_MOBILE_PARAM " ] [ "
+.BR count " ]"
+- SRv6 Mobile User Plane operation (RFC 9433) to perform on matching
+packets. The optional \fBcount\fR attribute enables per-CPU packet, byte
+and error counters for this route; the aggregated values are printed by
+the \fB-s\fR flag in the \fBshow\fR command. The following actions are
+currently supported.
+.in +2
+
+.B End.MAP mapped_sid
+.I ADDRESS
+- Replace the IPv6 destination address with the configured mapped SID
+.RI ( ADDRESS )
+and forward via the IPv6 FIB; an SRH, if present, is not modified
+(neither the SID list nor the Segments Left value).
+.in -4
+
 .B ioam6
 .in +2
 .B freq K/N

-- 
2.50.1

