Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792E39E9DD
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944379; cv=none; b=Wp2cVKwXcc8cAc8BZ7ov69P26O4hNThHp9lPSFV3qI0Xxm/AlNauMZgubTobX2PvPP5YlRj2NsHWbo2KKZPCz+M0Rea7eCClKKDchqnss18ga1KmcADOsufSaCmUS+h+tP8B+lLTkmoFgwJmK+IFzYggxFsHE8jMdEkRFKYEDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944379; c=relaxed/simple;
	bh=YyQOSsXRXIYUmAs6yTJgxjxjN3JHc2ZYOP21lOxR84I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nd4t/tSvCyFgYaehAka7E+pKCZG990M7NEfPjitSE9bJW20N5PNIm1SyX7xI6voqJ/hco634Vc5gPee+abmUInzQzGYFMwWOHSZI7E82EfJjJYoWvTtJ9aQBGN5LJbQQeH3PkLbk9/fSG4iiaPIdyjOmGh0uQLpXcRg2xdEjE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFt8u2VL; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFt8u2VL"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so3680060a91.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790944375; x=1791549175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fi8LCfhOEjWTjTI9cmO2Knqm1v5fbATScScQCdyRYuE=;
        b=pFt8u2VLp7uUakWBVACLoUDxcPnA3z5LcQ6wKFWTIlSJXDdC28lV3bicBuNNqSdFaa
         k4XgSQvDYwZOLYLAJ7kmaCCAABfzv3ZyR+Eu9LGBNisVFXd7m6EiPwBL8EjNPH5yGIbY
         hrYjK6W9jxypvhpVT5Q0PXohodMkJvKZHMGPZ3IApqs4emIjveoKbmzMvy6qZMWy9gXj
         GjWpaMnu5PNUKsZSx+QQm3p4cDmJlm0RXyqGgjeXEHNi6N8M23KeOuyaxo59+O/0qW4t
         5Z86k3NTM3Cqhe59hJrUSF2WCBv7iZUywULmqi/Sc1V+nCwXkloYoMiOYBP20IUrbXct
         KmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944375; x=1791549175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fi8LCfhOEjWTjTI9cmO2Knqm1v5fbATScScQCdyRYuE=;
        b=LUaFA2xZP9YjILpP4qVn1dobYU0dyMxDfDnwIEZ3nD3gWAkEJEJpA+svmRP6hvHBlL
         46sLkKdblKF6+cd6Y45EvLRJRSws0A9UgvitvtW7vIFRKda2YAP+2HMHKziPbr8w7T1b
         yD8HCA2w4LWusGnmkEOAFZso9UFYnPfjkblOT8PvTxPS7LFrzh/JINAAXBHduPmSikAr
         xRzcGUcW6e1RajemqpWRsxawJbqajEbW5I4/Rzjv6pZz5qEmBDfvNS7tm6DJiiV3KtUU
         DbRAKSg2DUsp6GsmxIQxBnILnf+bHsXAIvPyidqEVIRgo1oa5YVGvmaY6FT/aPzgr5bV
         0lRA==
X-Forwarded-Encrypted: i=1; AKwUvBxjImI7OaCtkSgx8iFdF2LJtapYZoI2ZeNBnXuLLF9V7QUXaoVAd+S+LhmsYgpFEDMDCaqFmzg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwWv1uIQLaV2jkJW9OQowu6/4iRdQUJfpC/CcNSCzNzlULKXXx
	23YVqyhLcb+0nA06AKnNvp1nywYhyxcpH8VdHWv5n2F6jTfJAc+DB1MOO1tbAH7E
X-Gm-Gg: AYBFou1ypVQIBaneqQUUlBCnKZ/uD4CbuJTPV2B0HLZbUh2nWjb7blPRxL4YoamDXWg
	AfWAyQBdWxIcxlVzEkMb6SYak1HhK0qHQ/DZ8fax/noEOkqE8YPUxgYwdcaFhmMgpXoy2r18wuR
	egDuEicz8IiKuKDD38qCY9abz6/5HZHtRay/FYiyreML7kWvd3JhP5sGr7kk3uD4GQj3gc7DDQ6
	yAsb3IBCggm4QW46vab+X/qSUzL3sRd+UOpOg3cdo2gHIgAewi0pJ55J2kdrla6luylaneD44Ct
	cg5dSc9N8kxIUUntjOQ0ZnXUociw4VXSzeTUGZszmbBEn1SFp6me/Y6Ftq8ZxiYX2sMx7KOOjXs
	Rom/0Xxgsp0FePR1xPdAR9GodKEy7o6mU7oKLRCB8JD/oifnB0oikg55UQKaz/e7nKis9ZqED7L
	0BzhG1YJVudhGiu83UbJQqwKjD7LxlSP28A/1SHQ4CE++0Z8hG/Fq288KGZiJmp7SQZMhKMfWFp
	GaDgEI4
X-Received: by 2002:a17:90b:28ce:b0:3a0:b40d:827 with SMTP id 98e67ed59e1d1-3a6f321f4b9mr668202a91.0.1790944374650;
        Fri, 02 Oct 2026 05:32:54 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd1a0c1esm1523877a91.4.2026.10.02.05.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:32:54 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 02 Oct 2026 21:32:49 +0900
Subject: [PATCH RFC iproute2-next v5 2/2] seg6: add support for the End.MAP
 behavior under seg6mobile encap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-seg6-mobile-end-map-v5-2-92ac9b315d23@gmail.com>
References: <20261002-seg6-mobile-end-map-v5-0-92ac9b315d23@gmail.com>
In-Reply-To: <20261002-seg6-mobile-end-map-v5-0-92ac9b315d23@gmail.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10712;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=YyQOSsXRXIYUmAs6yTJgxjxjN3JHc2ZYOP21lOxR84I=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqv6RxdoxqeSK9ZDU5NplG30Qd0q+RhYEiA/KmP
 HpeYB/3uk2JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCar+kcQAKCRAq19F1Kl0b
 Tb0tEACynDEU7DnBxblUCFCNRiCmt/aHkJrbOCUDwtYOsCioCvoA/Q+RHZ6QytaL8tIdqUQuhos
 JEE+LduiiPYPd8j1yqxwOpnVzaAZrjazjEMuKz5gP/p8hMyvx+JJOTNzLBZxqlSQewVnJJQX6As
 bV4sQoVqTdIr4IgDCHAUbwinv4Z8QSp1sBv96YBHmf8xXuD7YcC5pl9IRNNTsuebXeyS0TOB2gS
 o/Qg55wnVU0Q4yjLN84JPPKwpEfqrxyxR6iseBNVtXZ2pqRO7zlH1dNvyeh1V3fS8D2ZAgEYA/V
 cykDpB+xn4weMsVVHTRpNC7OBkAEqTT0fqfEGGzZvY4ifmREUjhIaWoFthw4cyDa6ebVh5WsiFT
 zyNocMdH040PF9r8ckpMtIx5UM3Z9FYhwDjZCakMndYfyOxIInaOHZ0pS1A7tptIOi4ESmkkdUe
 S9Q5qZyP4vRkeqbdLs1uIzcWElASQQz+YrxpeaCu5SVqJGSTPytbtHsmNkLwEEZvHk5Q4Z2/Z1C
 DpkiytUlYjEQfKQJSlSjpdFD42WSnB8rgiq6QVJ4OWJ5Ijv2bDGpw6cdDUJJyVTvlIRWZnt54Ng
 azWYxjFVbMVOPjzJbH0B0nVIkz7r3wjTeUBPZwDc96jsOKJl3SqWzk652FOLkpxtL/ELWXbL2cj
 9JlY+kdZahRfXIw==
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

