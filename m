Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637615;
	b=5CZCX0hh7vhgpxQo5rPj1d4W3xAL94bVWtsjeXlF0x3FhSmE0LYlP/bWwhziIEDz+SXV
	 hlHAJq/vG0/2+x8vxiAWfNXfc3oXsUt04iBIIMxYn1c0OAZDsIHyDRQ+hM+/eptgqcImj
	 g9VKb22GMD1Dtykd8gr6/gMnl41YOEcFtVgrW/2HD5EF3KhDD58Bz1gqfFbiq0c8mgWjS
	 y7mD0bGzeWzI7vV6b+gE0gFdZrXT7CDXxaonbmt6pgny2weY7hZuDU7wFy7GbxlpLXlkP
	 qi182nO+ycaUoTou3WYe6po9gxbfAUu+1jqt8UlTwIdksbZkk5W2y1gwvuNYeJ3flNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637615;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=V+vcOaCoDLPBFNtk+RYjfvQrB5pE2yYjOy7S2DnCAsE=;
	b=fsCc6sAJ82zE0NaTiyl6OJfPYuad0l++regg0RZIZk/jNX7o3wd8SzqE3tJqcW37bRFu
	 JRipQ/LWRwsXIG8VQdDMd0dVPEGTwVaHdcKXVaPNvLRZOXkcCCC9+E5Uq94d7f3SQT6/C
	 TS/AEhfnuQBiz3Qn02o52V7vCXHApJ7ipI8p9qhf0M4i61hqEvvjjcNocJMvv9ji5c3ht
	 8VpJc93f+fRYOVZQqJL5lS2K7tGjruXHK5y1PhCVHel+YR+sb2HbpR6LtccpaZ1joIPkW
	 Ck5uZVhr7Nn9dY6bPSYNj8owEOQbakGeUSbvOKlWRJ9ZOghzfBV/I6IzvBFZNmeDFHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EdZB8hG7;
	arc=none smtp.remote-ip=95.215.58.57
Received: from mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A50606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A50606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EdZB8hG7
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DZENdIxdxEVjEEelsGvTWold6bU898Lu0B1b0NdbO9s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792637611; v=1; x=1793242411;
 b=EdZB8hG7x37BjimPX6YoXLgvVadxZTpoP8oUiARlyivSWYJ2s3e5k4h6qsLAqBRNEV++sdEm
 SUfVjUAT3hXh4trn13ZQ03lGrtNxQuQH1BumR8VBNtSAWrgSxqfzlJSjX1NR6/rAFM4UZb/GbMI
 5lxCrRM9+cXo9pruX90MDwj4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 8211905b97b66d5e;
	Thu, 22 Oct 2026 02:53:30 +0000
X-Mizu-Trace-ID: 8211905b97b66d5e
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 22 Oct 2026 10:53:16 +0800
Subject: [PATCH iproute2-next] lwt: ioam6: allow options in any order
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-ioam_fix_order-v1-1-6eac1e00455b@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQrCMBAFr1Let4EmiqJXESm1u9EVTMomLYXSu
 7vq5zDMrCiswgWXZoXyLEVyMvC7BsOzTw92QsYIbTj6NngnuX93UZYuK7G6GM90OJndE8GiUdn
 kb3iFjJqnysElXipuf12m+4uH+p1i2z41XipGgQAAAA==
X-Change-ID: 20261021-ioam_fix_order-ff9d472023dd
To: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
 Justin Iurman <justin.iurman@gmail.com>, 
 Justin Iurman <justin.iurman@uliege.be>, 
 Hangbin Liu <hangbin.liu@linux.dev>, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.16.0

From: Hangbin Liu <liuhangbin@kylinos.cn>

The ioam6 encap options must be given in a fixed order (freq, mode,
tunsrc, tundst, trace, prealloc, type, ns, size). If a user uses a
different order, the command fails with a misleading error even
though every option is present:

  # ip -6 route change 2001:db8:2:1::/64 encap ioam6 mode encap \
      trace prealloc tundst 2001:db8:2:1::2 type 0x800000 ns 0 size 12 \
      via 2001:db8:1::3 dev dummy0
  Error: argument "tundst" is required

Parse all options in a single while loop instead, then run the
cross-option and missing-argument checks after the loop, reporting
the missing arguments in the order the options are documented in
ip-route(8).

Use while (argc > 0), same with parse_encap_ip(), so that a
valueless option in the last position (trace, prealloc) is not
skipped, and reject duplicated options the same way type/ns/size
already did.

Rename ns_found and has_src to x_ok to align with other variable names.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
This change fixes one main issue plus several related mirror updates.
I grouped them into a single patch, but the diff is a bit unwieldy for
review. Let me know if you’d prefer I split this into smaller patches.

Run kernel selftest ioam6.sh and all tests passed.
---
 ip/iproute_lwtunnel.c | 142 +++++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 76 deletions(-)

diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 9a1e747c6951..798ef8143ce1 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -1170,7 +1170,8 @@ static int parse_ioam6_freq(char *buf, __u32 *freq_k, __u32 *freq_n)
 static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
 			     char ***argvp)
 {
-	int ns_found = 0, argc = *argcp;
+	int tunsrc_ok = 0, tundst_ok = 0, trace_ok = 0, prealloc_ok = 0;
+	int freq_ok = 0, mode_ok = 0, ns_ok = 0, argc = *argcp;
 	__u16 trace_ns, trace_size = 0;
 	struct ioam6_trace_hdr *trace;
 	inet_prefix saddr, daddr;
@@ -1178,94 +1179,65 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
 	__u32 trace_type = 0;
 	__u32 freq_k, freq_n;
 	char buf[16] = {0};
-	bool has_src;
 	__u8 mode;
 
-	if (strcmp(*argv, "freq") != 0) {
-		freq_k = IOAM6_IPTUNNEL_FREQ_MIN;
-		freq_n = IOAM6_IPTUNNEL_FREQ_MIN;
-	} else {
-		NEXT_ARG();
-
-		if (strlen(*argv) > sizeof(buf) - 1)
-			invarg("Invalid frequency (too long)", *argv);
-
-		strncpy(buf, *argv, sizeof(buf));
-
-		if (parse_ioam6_freq(buf, &freq_k, &freq_n))
-			invarg("Invalid frequency (malformed)", *argv);
-
-		if (freq_k < IOAM6_IPTUNNEL_FREQ_MIN ||
-		    freq_k > IOAM6_IPTUNNEL_FREQ_MAX)
-			invarg("Out of bound \"k\" frequency", *argv);
+	mode = IOAM6_IPTUNNEL_MODE_INLINE;
+	freq_k = IOAM6_IPTUNNEL_FREQ_MIN;
+	freq_n = IOAM6_IPTUNNEL_FREQ_MIN;
 
-		if (freq_n < IOAM6_IPTUNNEL_FREQ_MIN ||
-		    freq_n > IOAM6_IPTUNNEL_FREQ_MAX)
-			invarg("Out of bound \"n\" frequency", *argv);
-
-		if (freq_k > freq_n)
-			invarg("Frequency with k > n is forbidden", *argv);
-
-		NEXT_ARG();
-	}
-
-	if (strcmp(*argv, "mode") != 0) {
-		mode = IOAM6_IPTUNNEL_MODE_INLINE;
-	} else {
-		NEXT_ARG();
-
-		mode = read_ioam6mode_type(*argv);
-		if (!mode)
-			invarg("Invalid mode", *argv);
-
-		NEXT_ARG();
-	}
-
-	if (strcmp(*argv, "tunsrc") != 0) {
-		has_src = false;
-	} else {
-		has_src = true;
+	while (argc > 0) {
+		if (strcmp(*argv, "freq") == 0) {
+			NEXT_ARG();
 
-		if (mode == IOAM6_IPTUNNEL_MODE_INLINE)
-			invarg("Inline mode does not need tunsrc", *argv);
+			if (freq_ok++)
+				duparg2("freq", *argv);
 
-		NEXT_ARG();
+			if (strlen(*argv) > sizeof(buf) - 1)
+				invarg("Invalid frequency (too long)", *argv);
 
-		get_addr(&saddr, *argv, AF_INET6);
-		if (saddr.family != AF_INET6 || saddr.bytelen != 16)
-			invarg("Invalid IPv6 address for tunsrc", *argv);
+			strncpy(buf, *argv, sizeof(buf));
 
-		NEXT_ARG();
-	}
+			if (parse_ioam6_freq(buf, &freq_k, &freq_n))
+				invarg("Invalid frequency (malformed)", *argv);
 
-	if (strcmp(*argv, "tundst") != 0) {
-		if (mode != IOAM6_IPTUNNEL_MODE_INLINE)
-			missarg("tundst");
-	} else {
-		if (mode == IOAM6_IPTUNNEL_MODE_INLINE)
-			invarg("Inline mode does not need tundst", *argv);
+			if (freq_k < IOAM6_IPTUNNEL_FREQ_MIN ||
+			    freq_k > IOAM6_IPTUNNEL_FREQ_MAX)
+				invarg("Out of bound \"k\" frequency", *argv);
 
-		NEXT_ARG();
+			if (freq_n < IOAM6_IPTUNNEL_FREQ_MIN ||
+			    freq_n > IOAM6_IPTUNNEL_FREQ_MAX)
+				invarg("Out of bound \"n\" frequency", *argv);
 
-		get_addr(&daddr, *argv, AF_INET6);
-		if (daddr.family != AF_INET6 || daddr.bytelen != 16)
-			invarg("Invalid IPv6 address for tundst", *argv);
+			if (freq_k > freq_n)
+				invarg("Frequency with k > n is forbidden", *argv);
+		} else if (strcmp(*argv, "mode") == 0) {
+			NEXT_ARG();
 
-		NEXT_ARG();
-	}
+			if (mode_ok++)
+				duparg2("mode", *argv);
 
-	if (strcmp(*argv, "trace") != 0)
-		missarg("trace");
+			mode = read_ioam6mode_type(*argv);
+			if (!mode)
+				invarg("Invalid mode", *argv);
+		} else if (strcmp(*argv, "tunsrc") == 0) {
+			NEXT_ARG();
 
-	NEXT_ARG();
+			if (tunsrc_ok++)
+				duparg2("tunsrc", *argv);
 
-	if (strcmp(*argv, "prealloc") != 0)
-		missarg("prealloc");
+			get_addr(&saddr, *argv, AF_INET6);
+			if (saddr.family != AF_INET6 || saddr.bytelen != 16)
+				invarg("Invalid IPv6 address for tunsrc", *argv);
+		} else if (strcmp(*argv, "tundst") == 0) {
+			NEXT_ARG();
 
-	while (NEXT_ARG_OK()) {
-		NEXT_ARG_FWD();
+			if (tundst_ok++)
+				duparg2("tundst", *argv);
 
-		if (strcmp(*argv, "type") == 0) {
+			get_addr(&daddr, *argv, AF_INET6);
+			if (daddr.family != AF_INET6 || daddr.bytelen != 16)
+				invarg("Invalid IPv6 address for tundst", *argv);
+		} else if (strcmp(*argv, "type") == 0) {
 			NEXT_ARG();
 
 			if (trace_type)
@@ -1276,7 +1248,7 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
 		} else if (strcmp(*argv, "ns") == 0) {
 			NEXT_ARG();
 
-			if (ns_found++)
+			if (ns_ok++)
 				duparg2("ns", *argv);
 
 			if (get_u16(&trace_ns, *argv, 0))
@@ -1296,14 +1268,32 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
 
 			if (trace_size > IOAM6_TRACE_DATA_SIZE_MAX)
 				invarg("Trace size is too big", *argv);
+		} else if (strcmp(*argv, "trace") == 0) {
+			if (trace_ok++)
+				duparg("trace", *argv);
+		} else if (strcmp(*argv, "prealloc") == 0) {
+			if (prealloc_ok++)
+				duparg("prealloc", *argv);
 		} else {
 			break;
 		}
+
+		NEXT_ARG_FWD();
 	}
 
+	if (mode == IOAM6_IPTUNNEL_MODE_INLINE && tunsrc_ok)
+		invarg("Inline mode does not need tunsrc", "tunsrc");
+	if (mode == IOAM6_IPTUNNEL_MODE_INLINE && tundst_ok)
+		invarg("Inline mode does not need tundst", "tundst");
+	if (mode != IOAM6_IPTUNNEL_MODE_INLINE && !tundst_ok)
+		missarg("tundst");
+	if (!trace_ok)
+		missarg("trace");
+	if (!prealloc_ok)
+		missarg("prealloc");
 	if (!trace_type)
 		missarg("type");
-	if (!ns_found)
+	if (!ns_ok)
 		missarg("ns");
 	if (!trace_size)
 		missarg("size");
@@ -1319,7 +1309,7 @@ static int parse_encap_ioam6(struct rtattr *rta, size_t len, int *argcp,
 	if (rta_addattr32(rta, len, IOAM6_IPTUNNEL_FREQ_K, freq_k) ||
 	    rta_addattr32(rta, len, IOAM6_IPTUNNEL_FREQ_N, freq_n) ||
 	    rta_addattr8(rta, len, IOAM6_IPTUNNEL_MODE, mode) ||
-	    (mode != IOAM6_IPTUNNEL_MODE_INLINE && has_src &&
+	    (mode != IOAM6_IPTUNNEL_MODE_INLINE && tunsrc_ok &&
 	     rta_addattr_l(rta, len, IOAM6_IPTUNNEL_SRC, &saddr.data, saddr.bytelen)) ||
 	    (mode != IOAM6_IPTUNNEL_MODE_INLINE &&
 	     rta_addattr_l(rta, len, IOAM6_IPTUNNEL_DST, &daddr.data, daddr.bytelen)) ||

---
base-commit: 204a721033556114c81c47d00375f2d52e98e463
change-id: 20261021-ioam_fix_order-ff9d472023dd

Best regards,
--  
Hangbin Liu <liuhangbin@kylinos.cn>

