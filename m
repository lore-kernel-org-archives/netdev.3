Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684203B27D1
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316247; cv=none; b=Z/c8OF3mDdYpBFl6BhHGAHrwRC8F35+EupvG/b9vN4VPS3On1U9xS1KvHM3okTan7385f6i/PyNGG4M8F7yG6JrSmELDnNzPMkFU9AAXssR2PAGHnG2HkygyCbslGxylb+gzwNxub6FVLADyl0vk24oq2+OzXTIsmeSDQ/Mn7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316247; c=relaxed/simple;
	bh=YyQOSsXRXIYUmAs6yTJgxjxjN3JHc2ZYOP21lOxR84I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmPMvCUhayXCGxj67q7/9LdnhCSmN6fP42o5kqyU0i+ddr3OtFuv1ub5crZMMs20+FzRtPthRJJ9CdFlRnzfGJgAYLeC20hOCFqjRaD4ylfl9Pq1wTtDt+HQvO13Bzh7uZfvr2m6yG9JPcj9MxncVsGe0I64QiAwZ1twxdxZRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2OHKesk; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2OHKesk"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0af40d240so310893a91.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790316245; x=1790921045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fi8LCfhOEjWTjTI9cmO2Knqm1v5fbATScScQCdyRYuE=;
        b=J2OHKeskGR/G7qh/7XXAmVYbrl6Vi4zW3ZdnbazZHeHtC7m5bhZoWsapM6+y6Zz85G
         xVyY3Sa79S3qtcm7DNWIquXuiKJXLSeT1efylgYTpj8FHHvcZ19zqoijCDt2bLJmAmHR
         uaL2sfCu66dWG8awzcljfdbvufqhzxaFHTkhgn9rLhacwJNsH/DZIiJxQl5tZV9CUAQE
         lDhM+wS7MmQ0FYZ3RprR9CIL303G0UPz/sJe7V4elSnaVhoUXBlDUbDboe4xy9Ii7QuY
         3+89ASVV2CaJZboFyl8x+xD+C11Bpet07mvm76Uoj3U5Tlg4jyhvgjW6ZDlc51IdC2Im
         3T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790316245; x=1790921045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fi8LCfhOEjWTjTI9cmO2Knqm1v5fbATScScQCdyRYuE=;
        b=ofgw21ZJk76vjwHffYHSXErQFhIrKn3ZSt2eTXAUKcLwm+f4+aUEuVcF+D09+lq3hF
         r4oQKUDCVdJoWKdaQq2Jo6oWAvPxQMJY7Mo1UgKtsvcf9n1vA8FeHPvDyDryxfuGMLXn
         FkTlckX63aim9u5zJrbeLJyp3YvMOgU58r4x4ZysHHnHdcnf/dXTzKmFVFDNweCY1U6y
         7PLDg5L+hBfgY4zio7X3d8Hh8EfLTpHDts0UlDJwZ+z1JNnowgug6nwXAob0wfZMPS7o
         /nVbkOkxjXpv2QcZ3gdv+HYAsZWhyTf2Y/vrsYnKyqTHUnUjCoxRJhjydsm8G7AXGvot
         m0Vw==
X-Forwarded-Encrypted: i=1; AKwUvBwf5M/Ha+9IBAU6wF1SVwrX7dXwIvW0k43E10QpdQhFVIgjqF4gjlrtiPeGZDlWDHoAIE5rvl4=@vger.kernel.org
X-Gm-Message-State: AFuF++kO0y/I8bh3aSHNewK6YXdKFzmWdEaiJtdYQo93QKE/2rsxxkRZ
	fxR0NzG6JkEHdWrfNnShJTyr3cMH8wGdUwEXbh0mpOxTPO43QguJzRIM
X-Gm-Gg: AYBFou3ZETrZp/PSFcBwN2kBHwfruGaOcdqN2jU95obY1N5OyNdoaibvUjfpSL15CbS
	p/4onipi7LSAkhbp3J9ehFFHns9m6d6HcF1AhlH82GImBrp0/NekgIb5giUAkl/b7bnyI4veOgC
	THChBeU8zjCsRB05i/eXEGIGxtM6lPrl96M80eAg5rTD5H9zPWu8updYHY5LARx7Pd4aN39kHGy
	vpWiOtM52pQk1UPySYjlNDftUTfAZiuvaODzLUUn4zwvG5MjvTbZvbIOykacuZeQLqAkWOrJJdT
	j0YGChJW+/V8ej1GxF+Trm1m5a2SKXdVickCzkUP15QCfhfVBmlnOGr3B9lfhw7uO3ZAl64b59o
	lLvxdPv6lUF9d2UQ1q1VrWxe/BUx40VQHTf4dSbL3nHW46B74K7QulIaAY7yRPKUOS0cqWr2iSq
	iml26cUJlItZWO8u4r3IJJwGh8PWIsKZvT6Q2BmeE6TPakrY8/YE9VPNaPk2NoqX/FifY7FvrNh
	7nYllY0
X-Received: by 2002:a17:90b:4fc9:b0:3a0:c5d7:cec with SMTP id 98e67ed59e1d1-3a0c5d713camr150967a91.24.1790316244514;
        Thu, 24 Sep 2026 23:04:04 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b898cabesm2467490a91.0.2026.09.24.23.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:04:03 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 25 Sep 2026 15:03:59 +0900
Subject: [PATCH RFC iproute2-next v4 2/2] seg6: add support for the End.MAP
 behavior under seg6mobile encap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-seg6-mobile-end-map-v4-2-ba4951d28871@gmail.com>
References: <20260925-seg6-mobile-end-map-v4-0-ba4951d28871@gmail.com>
In-Reply-To: <20260925-seg6-mobile-end-map-v4-0-ba4951d28871@gmail.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10712;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=YyQOSsXRXIYUmAs6yTJgxjxjN3JHc2ZYOP21lOxR84I=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqtg7O5yB1W6iaUm9c1Pt8KdK2dAzaD5+FKLrEM
 QJxrXOcyDKJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCarYOzgAKCRAq19F1Kl0b
 TdH1EACgesOW3aaQoiuWcNvZzVx+YU4z6YyASFTm9Mz77uwqmqtp4DKNia1y9OBglEvvnscFyBB
 ymfN7Sb7eyj/RcPqguX7GWkBTywm9sT5YWFTgGampJ9fTCfV8/ScLwNqJZu4rYS6o9jZYmC8XFh
 Yn3C/9KlrIdgoqSgXtqtyMG7mJOGYlfpOchCL7d9TyKaOVUmY+VOZhG0LKQWT9xjxXlLd6d/6qV
 djsxagDfmDW2mF58scn8btdsHkQ4mZFvF9rp9K6nJ3ipcGBPLinV2R+Mzq9fVJ5ZFWNrdDBzFde
 25XrlNsLB9j50wsKtLyEQ1ssxJgmYIF8TAODuS/+0TOovSKMgysZv1sVAXaZ1FpVwJIx1/1DDrW
 rR/LRPGTSDqf0EAjWL6h//JI7jH4x4GFuHJzzS30rUGqsZo0N56uzdmJ4kcl4fj3I46Z2h0uspb
 042TUbmhNU7y3m8Jv/WNnSlUFOPboBrkwIkQtuClEBkm53d5pKXWYWf/AobKsi7ILRFq45jS/nY
 DUwlZU8FHKGzUX1iqQDYPRp8pIfBikE+vypbADHfaykj3SqVEcytYq3KhSS2SdJSRqUSu8WaIRq
 AYTf3crGgY+0YOPBUhiFksfEw3Y09e1We1USZbDH5o9czK0JaY+IQOrKBHUDmSTelhWL69d+uTX
 HfhcSOT7UPJLp+g==
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

Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 ip/iproute.c           |   6 +-
 ip/iproute_lwtunnel.c  | 178 +++++++++++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in |  32 ++++++++-
 3 files changed, 213 insertions(+), 3 deletions(-)

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
index 9a1e747c6951..51c051fbe5cb 100644
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
@@ -1607,6 +1700,88 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
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
+	if (action == SEG6_MOBILE_ACTION_END_MAP && !mapped_sid_ok) {
+		fprintf(stderr, "Missing mapped_sid for End.MAP\n");
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
@@ -2346,6 +2521,9 @@ int lwt_parse_encap(struct rtattr *rta, size_t len, int *argcp, char ***argvp,
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
index 1e6042c427ff..97aa91ea2e85 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -197,7 +197,8 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .ti -8
 .IR ENCAP " := [ "
 .IR ENCAP_MPLS " | " ENCAP_IP " | " ENCAP_BPF " | "
-.IR ENCAP_SEG6 " | " ENCAP_SEG6LOCAL " | " ENCAP_IOAM6 " ] "
+.IR ENCAP_SEG6 " | " ENCAP_SEG6LOCAL " | " ENCAP_SEG6MOBILE " | "
+.IR ENCAP_IOAM6 " ] "
 
 .ti -8
 .IR ENCAP_MPLS " := "
@@ -260,6 +261,13 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .IR SEG6_ACTION_PARAM " ] [ "
 .BR count " ] "
 
+.ti -8
+.IR ENCAP_SEG6MOBILE " := "
+.B seg6mobile
+.BR action
+.IR SEG6_MOBILE_ACTION " [ "
+.BR count " ] "
+
 .ti -8
 .IR ENCAP_IOAM6 " := "
 .BR ioam6 " ["
@@ -776,6 +784,9 @@ is a string specifying the supported encapsulation type. Namely:
 .BI seg6local
 - local SRv6 segment processing
 .sp
+.BI seg6mobile
+- SRv6 Mobile User Plane processing (RFC 9433)
+.sp
 .BI ioam6
 - encapsulation type IPv6 IOAM
 .sp
@@ -1109,6 +1120,25 @@ flavors. The Locator-Node Function length must be greater than 0 and evenly
 divisible by 8. This attribute can be used only with NEXT-C-SID flavor.
 .in -4
 
+.B seg6mobile
+.in +2
+.IR SEG6_MOBILE_ACTION " [ "
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

