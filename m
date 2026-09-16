Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EDA45D19F
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594770; cv=none; b=cM4Elsl6HSRd3wrz6rxyuksne7TQhcBI+tANoVBNTRSjILNHcQwWcqkxj8iWcINbiOb85ErrsnwdTaSSLpGtZ9Ffp16J399VQ3iiSAI0ft89WIdxSyfctZ+L0HP3YP18ZE9JnV57D5wks+jlDb/t0GFZydl7UELwS+u7kPn0rF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594770; c=relaxed/simple;
	bh=YGU38iWOalQgHAWQKQMSTt/fouwTMVhRIBxKh8Ei6vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGby9UXvGRHL6Dv9CJqj7j95N1/Fl28twzKj8kMJue1uHWYlTjjymOkMEndHanR0FOE/i3fyYaISQw/yz9DBOpD8SJezTHy6A8+iuAVkfxbgyqNKiOMiGRIph/yj5ZfJOOX9CVtZHCMjhNkICikFnQLuP/g+qfnTlsOxkhezb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm0E6ilo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm0E6ilo"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91ede8035so2039955ad.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789594748; x=1790199548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/74I/f6VOp4GuhdP6EPHOwPFDkGuB7KMPs8YM8qiBco=;
        b=cm0E6ilobI1+OZDlb+Z3XtA0tm0QF4mDMCkRudPAbl12PzRInn1iqiJk+k8BDxsFRU
         efJ9MauD9uuSrmFhJ/IGlBa8837zx5qcZvFsfevhg1qC3SckkI9mbx0L3wdLul0Sq61O
         Xlf6YLcblrw+PwFJ34Xdwwcy2yaFYK6fSdNAZoMB5A8DTkZ1aWc0YoTpTQrKVHNIne21
         V4gGe4eCfJEyU/UEWRZHpu2oIVGQ5xhxuOUWpnsbbHRtpBOm+Hbcm4tsEclBEtHWCzBr
         Ic6v5bDgFsJKb39G+kzYcBX4zPmwoEKKprYz//2XFuHDSVOyf/gVPchBaI1NsOHdcxcj
         +uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789594748; x=1790199548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/74I/f6VOp4GuhdP6EPHOwPFDkGuB7KMPs8YM8qiBco=;
        b=vX/Lb8tVQ9D9mqD8Lm+S5StEX37VdTtuo6YEUNqfxFQuIS6OTWK0ud4/2b3Tt2U+pe
         BbnfYP/N5EG1gR54LeGpZ7RKvaDKJ4f2qw5Z+elR1IeipWoKCi99CzJgSGUk3raCSkX+
         GbNJgik+hBZI6TQjSwIH5CqzX1TDPp6EzwN1grLATicTKe3FDP7fjmWyNksFAcOJwAd1
         /g+5fAMTvIzxB6/jDVj35K1cs2X4L4lRsdiO/+wZ5pp796BmFJkamhHDMnvsPYaND+FY
         JWOo9Wg/UrKOk1thOCMV4iWunAXlUIQ/iYpD09u4m6eLqoqQLOE/cIZsRQzpXHNl/+an
         IbFg==
X-Forwarded-Encrypted: i=1; AKwUvByXxzmdoD7S6KCla3W0gZIPyfrPw4nv/f+z972mwAr9eFAPxcHLeMQQMuvPMtNOeBrxQP5FIW4=@vger.kernel.org
X-Gm-Message-State: AFuF++loCVuK3uo4AsmA9Sf45UGLhYAffVFDNtmexSuhJDoU90ttMnPo
	W/Ymmy4hf1tIpABmmfSi9CqAfO1Dyyor71cFa+9uyS7OqlzblNbB25vCccBHvlUu
X-Gm-Gg: AYBFou3L9RkmOL98KuS4sE+Z7iD/P2VmdDJLhjlrec8bK53zmORRiZKQ9+/ffs68A9j
	l34ndblS9Br6BS2D78yZVQ44IHOP5jUarf9k/oNAItBrxpPSKXAGSpmrCP4IZe0p5X0p/LwTnaI
	JfMZ3NooAXCQSRpvlBIhsyQTZMcgjmpJ8i/tbT9MYqgeoOaHEiWiDHZtVjIGcy8FPtGgxj3IKbL
	9fU/clE5/uOLaImmXgZPa1+ygDlO1KWCDwsl0wFrbGEEmf2OTVAK+L9BP/hIuDb+ixXByc1KwRl
	GuwtrdHnK1sAKjwv5MuloFMZNnrHkF/JhZiTwo6cI9aNgdg00gTtmG88j9LnGSZ2xTeQfiMNu7e
	4MLnVaBiS2dujAmLHJbK3JD/IJpDmaD4fqLxl8hCFxdN9LzghGtbWLW9DRMoTBMLkX7pvXnd6ML
	ZojclgkDOpUGMdrkraXCWOTuuAAFTlZe8vkeIFHV2fBgY2LI4nkOa2wtQawdBN1qPjDiG37nt7g
	tMPR03aKw==
X-Received: by 2002:a17:903:2451:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2dd8dd1a7bcmr90242835ad.5.1789594747545;
        Wed, 16 Sep 2026 14:39:07 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8fe15sm17650445ad.1.2026.09.16.14.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:39:06 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Thu, 17 Sep 2026 06:39:01 +0900
Subject: [PATCH RFC iproute2-next v3 2/2] seg6: add support for the End.MAP
 behavior under seg6mobile encap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-seg6-mobile-end-map-v3-2-7fd02b8b0577@gmail.com>
References: <20260917-seg6-mobile-end-map-v3-0-7fd02b8b0577@gmail.com>
In-Reply-To: <20260917-seg6-mobile-end-map-v3-0-7fd02b8b0577@gmail.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10651;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=YGU38iWOalQgHAWQKQMSTt/fouwTMVhRIBxKh8Ei6vY=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqqwx111KOfHFfSBp13BptpPAHcdjvnAa+sI3ig
 nb8nxmdXAGJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCaqsMdQAKCRAq19F1Kl0b
 TYaLD/9d0PnVFCTYUMXQrPW/QSr8KD95jAQv5q9vLgswfFYpHBMHKMSU6IM3NrgwXUhdCxGB3AK
 1uuQrG/7p9LD7YU/UjUpRonZh1QkMBtbQi8FUgLDgCPf0+9z7qd9pr9N6PKGjz4/g9NjVEFpWbi
 I/WJw8SukqiEUenq26IcXTM1w6FUTaSfamDNK4mru0y1UFhjcHquE0HNf3oAOCPAkWod4XVMHMy
 V78+5mRaCBsPEb4VkiaUFSch2gZmqxG4k82h4M0qZTefQETMfiG6LfTIhjOAOVzulZnlv+x5jk3
 B1Mrd/g6iSkZqMc1KhIr2FRahCx3qQ3EQmmPl74Gu7qZCSWZMqMN96uiisuHIXqklw/h1nteQlf
 5bYkFffrDHgO74ALcJvJQ8NG9kcNuwOTfP8lGoj+8U5qto25xelFa++WpOv391WPSxIpd8fd5sk
 THiK6zaLRJoRdNITmMs+9zacerYaGQBicMp1deZNMnlfrzffuwnmaWityXePYJ8voV5TrGetaeB
 JFvdzjReKM2fYBT27Y0Sun+KSHRFKTEB/hYfTMqpYSmUfzhtu3dTH4opEa1mKhpXrxY+7gUYPc1
 6ylLlOYMu7Cns+U1U0kthfDakr14fqOPSairlbukgJUmioSuulV4NKD6GbDtdBDy9q8Hs4jO/cp
 gHuRa/MDDCQ8hnQ==
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

