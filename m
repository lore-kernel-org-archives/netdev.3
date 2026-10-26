Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010313;
	b=QcrQVYpw9/Bg94c8OC6Mx2l2/Si4O836pvFd152ZtWhRyjQ/dSC0FxT/xLWhN/z8b0FX
	 gM+ITi6y760o4ehic6x0Xfo4d1yZe4ifFeKExiLM9fojf6xg3rQZe5LiZwH/ltKIASaUA
	 5RTZktEZjxRjLzm49SsaIH66VBn31NX+Dg3/RN4KM5eGYuUbnqRr8AkrucCGAdmesW/J6
	 VohFifYYB0/SRPTNESg3Qiupb4cPVqS7S2HbZM231qubyXLY93iYQPu6/3hCpGqPGmLtY
	 YiXO6tePBpYbkOCLyYAFkWDRxzoRGD5bEaSH6CtN9ZEVcsi0BGthdSGIuSu9yQAWYbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=59acJgaFRxP57eXc6akdfuQXd7riCvSJNlZRLlRhCI8=;
	b=HUA6g5grliqhoyoqQXbJ+PePw9RT3EqnpA0fo8y2zDP4HQOgxbT/P61uvAubJgFJyO8C
	 4S+j3mSJb+eTwBOMTw5hC//WrCJ/LTJJ9MN1BUwrtw/8GAGbGl8yb8wVHcGIFW8flnxv3
	 N4fjyvRDKBg7ddbwacUHf3cCTGklX0DjDLe3+c2Y65Mv8iN9y1AvVktYXHpwL3R33ogPk
	 XQ9qVYCUrkjgc00z98+pqvoelSmMUDhboX/DjERufAHRMdLXHkfABUQKeFGkjzIBZcatW
	 GT9zDEg6nc778GVwayYikl+hql8kI0Mdxpu5pTQq0BcNfOxTrdqmH2++AyOZxG+fZ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K4nPWItR;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD96606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD96606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K4nPWItR
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1454156a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010312; x=1793615112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=59acJgaFRxP57eXc6akdfuQXd7riCvSJNlZRLlRhCI8=;
        b=K4nPWItRtPtProXnsVl8pShe386rtOHDcD3kZzGzkvrKZl07TdiHGFbTTs8lm5TGI+
         ZTneROgkmW+RICHQDOkGo2gwvTKMHy6IxB+BzsZMWt+e1SKfFBYg2YF7jVRzVae458Qn
         Jx1CL9ZYSLxaiZBF1VtWx+6lqw/HQWX02xfAgSm6yeBdad5VY37Tk4VqPLMSIBDokrlh
         f29tWUsos/j0l/hnASpC7E60QP13U5fcKgf47g75eAd5EdtAnZzOHhHs9ODONOk15L/x
         Q9qCyjsRYKZRWh5Kv+VkO7xYQksJCFuEf7PQ3EHWszT6fD8oVmEbk2z/6IV8wh7yPCM1
         m2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010312; x=1793615112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59acJgaFRxP57eXc6akdfuQXd7riCvSJNlZRLlRhCI8=;
        b=b6HpZkG9GNxFY6rfY2mcJoBOqNwJRt1NCYNkS2uOfXJ8YLM4DvreuhITEuILbnnFuy
         +7PY4ANvJ1j3ncyzQF7KML+g64UyaQJKiK7TPbOXcMLyR4ujKLlNX4Xn9eOZVAX5UEzR
         23LJGfrKVw6p8pOswCE5H+0MZmwSZmOHENZE2Cs+HV+RfyleUipHMX2VjtFu+GdhwTJb
         HgahaTSZSNTbCoeIMvHnJbKMXWHgbOe9KTZ0+ywAyAsFE6Pu5AcX2f8hFSN3iYrPFgO+
         hMXQHGZMi/pTSiwRbOiFpf8fxxvEiHdCxkhns2QymqApCb5UTG67n7V/sKrANghl7gaY
         Bnsg==
X-Gm-Message-State: AFq9FYJSdNCU7tgMjEQZass4R2liBA5IjHR4+3u1hVRFSw3/VA/3x2U1
	qYW6uJ2Q4IVRm40n2gkMtvBpox3nIFt8DRVm21K4zcONTq2f7pztW4WaUaex+YA0Nhc=
X-Gm-Gg: AYBFou3qMXvciTJzboDr8jaJMaeuXkXo74gxJDDeurEbf1kAclaC9rPXutTSY+2QG0K
	qdQnucxHmEzBXZZWCWDQK6ZK/4FRWsTlKrMHewovxXOGSdL+CKMSJVzz35IZyonKcP+dyS5T4Kq
	aRiaZuxwnciM91OIrJZtv/cf7mBvJHTZL9jB8LFy7KoJGzev81/ah9GHt5W4vh31crJ5JzGxAAl
	3Pa/qbl5DarHb//tThGb+G/sE2bj5kuT3LyYrL+9MIqvTu4jzGhntGp2657fMGbq1c+a3oXBb7H
	Q1WTZO52soEmpbu9l8loYQwkCh/fuJYZSPly991uzyxsvgG6iq/3RcA4QZ7DpSt3RuVW5IZVj6d
	XOyT/vzh9/sk8uGQuAPkfF+2iH/27/cuwN6qaJISqocHVc0IKMoxKU/J8APdU1Ti4q1uH8FzFC4
	ccbya3D3gDJ/a9FPICuBK1X5wlla01LxInT/6nR7pDkbBdsu8jpqM7jegic3GeqsJLTmHQ7KB/2
	XCt6LGTJ22m1U3tJR0y1rAYhROreVdTlqznaMpJ3ryOVks4WX7S+Y5T9rvzJ4frKSc0QcQuB1AM
	jzINQga3SUMjeb6mvxtVpmOIZITOxG/3VZkC0yJPrMImikbF/8pRS/X7HppzTlKEMmsQ1ju1Zxo
	Tef0PAFy1loUaHw==
X-Received: by 2002:a17:90b:1b0e:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3adea89942bmr5319972a91.18.1793010312029;
        Mon, 26 Oct 2026 03:25:12 -0700 (PDT)
Received: from zypulse-in-radeon-MS-7E24.lan (ec2-18-138-159-236.ap-southeast-1.compute.amazonaws.com. [18.138.159.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb18sm7837448a91.15.2026.10.26.03.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:25:10 -0700 (PDT)
From: Yuen Su <zypulsecore@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 v2] ip: flush nexthop-object routes without compatibility attributes
Date: Mon, 26 Oct 2026 18:24:20 +0800
Message-ID: <20261026102420.612573-1-zypulsecore@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Route dumps can contain RTA_NH_ID plus expanded nexthop attributes.
The kernel rejects that combination on route deletion. Strip the
expansion from the flush copy, keeping the ID and route selectors.
Use the compacted length for batching and retain the dump for display.

IPv4 fib_dump_info() also reports blackhole nexthop objects as
RTN_BLACKHOLE instead of the alias type, independently of
nexthop_compat_mode. Work around this with RTN_UNSPEC only when no
type filter was requested. The kernel then deletes the first alias
matching the remaining selectors; alias order and changes between
dump and deletion can affect that choice. Preserve explicit types.

Add namespace regressions covering ID-based flushes, ordinary routes,
batching and type selection, with a nexthop capability probe.

Signed-off-by: Yuen Su <zypulsecore@gmail.com>
---
v2:
- Document the IPv4 dump workaround and its alias-matching tradeoff.
- Remove the unused namespace guard and probe nexthop availability.
- Rename the delete-request pointer and shorten the submission notes.
- Use git send-email for delivery.

AI assistance was used.

Link: https://lore.kernel.org/netdev/CAC9WPdwmM4=64DH5nY85srnLhRBS7PkjR9vrsALpob-GutbmZw@mail.gmail.com/

 ip/iproute.c                             |  39 ++++++-
 testsuite/tests/ip/route/flush_nexthop.t | 140 +++++++++++++++++++++++
 2 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100755 testsuite/tests/ip/route/flush_nexthop.t

diff --git a/ip/iproute.c b/ip/iproute.c
index 1ce71f7..bd436c1 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -766,6 +766,38 @@ static void print_rta_multipath(FILE *fp, const struct rtmsg *r,
 	close_json_array(PRINT_JSON, NULL);
 }
 
+static void flush_nexthop_compat(struct nlmsghdr *n,
+				const struct nlmsghdr *source)
+{
+	const struct rtmsg *r = NLMSG_DATA(source);
+	struct rtmsg *dr = NLMSG_DATA(n);
+	const struct rtattr *rta = RTM_RTA(r);
+	int len = RTM_PAYLOAD(source);
+	char *dst = (char *)n + NLMSG_LENGTH(sizeof(*r));
+
+	for (; RTA_OK(rta, len); rta = RTA_NEXT(rta, len)) {
+		switch (rta->rta_type & NLA_TYPE_MASK) {
+		case RTA_OIF:
+		case RTA_GATEWAY:
+		case RTA_MULTIPATH:
+		case RTA_VIA:
+		case RTA_ENCAP_TYPE:
+		case RTA_ENCAP:
+			continue;
+		}
+		memcpy(dst, rta, RTA_ALIGN(rta->rta_len));
+		dst += RTA_ALIGN(rta->rta_len);
+	}
+	n->nlmsg_len = dst - (char *)n;
+	/* Work around fib_dump_info() replacing the IPv4 alias type with
+	 * RTN_BLACKHOLE for blackhole nexthop objects, independently of
+	 * nexthop_compat_mode. Keep explicit type constraints.
+	 */
+	if (!filter.typemask &&
+	    r->rtm_family == AF_INET && r->rtm_type == RTN_BLACKHOLE)
+		dr->rtm_type = RTN_UNSPEC;
+}
+
 int print_route(struct nlmsghdr *n, void *arg)
 {
 	FILE *fp = (FILE *)arg;
@@ -810,10 +842,15 @@ int print_route(struct nlmsghdr *n, void *arg)
 		}
 		fn = (struct nlmsghdr *)(filter.flushb + NLMSG_ALIGN(filter.flushp));
 		memcpy(fn, n, n->nlmsg_len);
+		/* Keep the exact nexthop ID; its compatibility expansion conflicts
+		 * with that ID in the delete request.
+		 */
+		if (tb[RTA_NH_ID])
+			flush_nexthop_compat(fn, n);
 		fn->nlmsg_type = RTM_DELROUTE;
 		fn->nlmsg_flags = NLM_F_REQUEST;
 		fn->nlmsg_seq = ++rth.seq;
-		filter.flushp = (((char *)fn) + n->nlmsg_len) - filter.flushb;
+		filter.flushp = (((char *)fn) + fn->nlmsg_len) - filter.flushb;
 		filter.flushed++;
 		if (show_stats < 2)
 			return 0;
diff --git a/testsuite/tests/ip/route/flush_nexthop.t b/testsuite/tests/ip/route/flush_nexthop.t
new file mode 100755
index 0000000..70d09f8
--- /dev/null
+++ b/testsuite/tests/ip/route/flush_nexthop.t
@@ -0,0 +1,140 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+. lib/generic.sh
+
+# The testsuite normally supplies IP and runs each test under unshare -n.
+[ -n "$IP" ] || ts_skip
+if ! LC_ALL=C "$IP" nexthop list > "$STD_OUT" 2> "$STD_ERR"; then
+	if [ "$(cat "$STD_ERR")" = "$(printf '%s\n' \
+		'RTNETLINK answers: Operation not supported' 'Dump terminated')" ]; then
+		ts_skip
+	fi
+	ts_err "$0: nexthop feature probe failed:"
+	ts_err_cat "$STD_ERR"
+	exit 1
+fi
+
+ts_log "[Testing route flush with nexthop objects and compatibility attributes]"
+DEV=nhflush0
+ts_ip "$0" "Bring namespace loopback up" link set lo up
+ts_ip "$0" "Create private dummy device" link add "$DEV" type dummy
+ts_ip "$0" "Bring device up" link set "$DEV" up
+
+for family in 4 6; do
+	if [ "$family" = 4 ]; then
+		addr=192.0.2.2/24
+		gw=192.0.2.1
+		gw2=192.0.2.3
+		prefix=203.0.113.0/24
+		group_prefix=198.51.100.0/24
+		plain_prefix=198.18.0.0/24
+		nh=101
+		nh2=102
+		group=103
+	else
+		addr=2001:db8:1::2/64
+		gw=2001:db8:1::1
+		gw2=2001:db8:1::3
+		prefix=2001:db8:2::/64
+		group_prefix=2001:db8:3::/64
+		plain_prefix=2001:db8:4::/64
+		nh=201
+		nh2=202
+		group=203
+	fi
+	if [ "$family" = 6 ]; then
+		ts_ip "$0" "Assign IPv6 address" -6 addr add "$addr" dev "$DEV" nodad
+	else
+		ts_ip "$0" "Assign IPv4 address" -4 addr add "$addr" dev "$DEV"
+	fi
+	ts_ip "$0" "Create first nexthop" -"$family" nexthop add id "$nh" via "$gw" dev "$DEV" onlink
+	ts_ip "$0" "Create second nexthop" -"$family" nexthop add id "$nh2" via "$gw2" dev "$DEV"
+	ts_ip "$0" "Create nexthop group" nexthop add id "$group" group "$nh/$nh2"
+	ts_ip "$0" "Add selected single-nexthop route" -"$family" route add table 111 "$prefix" nhid "$nh" metric 10 mtu 1400 advmss 1360
+	ts_ip "$0" "Add another metric on same prefix" -"$family" route add table 111 "$prefix" nhid "$nh2" metric 20
+	ts_ip "$0" "Add same route in another table" -"$family" route add table 112 "$prefix" nhid "$nh" metric 10
+	ts_ip "$0" "Flush selected metric only" -"$family" route flush table 111 metric 10
+	ts_ip "$0" "Check other metric survived" -"$family" route show table 111 "$prefix"
+	test_on "nhid $nh2"
+	test_on "metric 20"
+	test_lines_count 1
+	ts_ip "$0" "Check other table survived" -"$family" route show table 112 "$prefix"
+	test_on "nhid $nh"
+	test_lines_count 1
+	ts_ip "$0" "Add multipath nexthop-object route" -"$family" route add table 111 "$group_prefix" nhid "$group" metric 30
+	ts_ip "$0" "Flush group with verbose display of original dump" -"$family" -s -s route flush table 111 to "$group_prefix"
+	test_on "nhid $group"
+	ts_ip "$0" "Check group route was removed" -"$family" route show table 111 "$group_prefix"
+	test_lines_count 0
+	ts_ip "$0" "Check nexthop group itself survived" nexthop show id "$group"
+	test_on "id $group group"
+	ts_ip "$0" "Add ordinary multipath route without ID" -"$family" route add table 111 "$plain_prefix" nexthop via "$gw" dev "$DEV" weight 1 nexthop via "$gw2" dev "$DEV" weight 2
+	ts_ip "$0" "Flush ordinary multipath route" -"$family" route flush table 111 to "$plain_prefix"
+	ts_ip "$0" "Check ordinary route removed" -"$family" route show table 111 "$plain_prefix"
+	test_lines_count 0
+	# One flush batch mixes compacted single/group messages with an unchanged
+	# ordinary route. The next message must start at the new compacted length.
+	ts_ip "$0" "Add group to mixed flush batch" -"$family" route add table 111 "$group_prefix" nhid "$group" metric 30
+	ts_ip "$0" "Add ordinary route to mixed flush batch" -"$family" route add table 111 "$plain_prefix" dev "$DEV" metric 40
+	ts_ip "$0" "Flush mixed batch with original dump display" -"$family" -s -s route flush table 111
+	test_on "nhid $nh2"
+	test_on "nhid $group"
+	ts_ip "$0" "Check no selected routes remain" -"$family" route show table 111
+	test_lines_count 0
+	ts_ip "$0" "Flush second table" -"$family" route flush table 112
+done
+
+# A blackhole object has no compatibility gateway/device fields to strip.
+ts_ip "$0" "Create IPv4 blackhole nexthop" -4 nexthop add id 301 blackhole
+ts_ip "$0" "Add blackhole-object route" -4 route add table 111 192.0.2.0/24 nhid 301
+ts_ip "$0" "Flush ID-only blackhole route" -4 route flush table 111
+ts_ip "$0" "Check blackhole object retained" nexthop show id 301
+test_on "id 301 blackhole"
+for type in blackhole unreachable prohibit; do
+	ts_ip "$0" "Add $type alias using blackhole object" -4 route add "$type" 192.0.2.0/24 table 111 nhid 301
+	ts_ip "$0" "Flush $type alias without relying on synthesized dump type" -4 route flush table 111
+	ts_ip "$0" "Check $type alias removed" -4 route show table 111
+	test_lines_count 0
+done
+ts_ip "$0" "Create IPv6 blackhole nexthop" -6 nexthop add id 302 blackhole
+ts_ip "$0" "Add IPv6 blackhole-object route" -6 route add table 111 2001:db8:5::/64 nhid 302
+ts_ip "$0" "Flush IPv6 ID-only blackhole route" -6 route flush table 111
+ts_ip "$0" "Check IPv6 blackhole object retained" nexthop show id 302
+test_on "id 302 blackhole"
+ts_ip "$0" "Add ordinary blackhole route without ID" -4 route add blackhole 192.0.2.0/24 table 111
+ts_ip "$0" "Flush ordinary blackhole route" -4 route flush table 111
+ts_ip "$0" "Check ordinary blackhole route removed" -4 route show table 111
+test_lines_count 0
+
+# Type filtering must not delete another alias sharing the prefix, metric and ID.
+ts_ip "$0" "Add unicast type-filter sentinel" -4 route add 203.0.113.0/24 table 111 nhid 101 metric 50
+ts_ip "$0" "Append explicit blackhole alias with same nexthop" -4 route append blackhole 203.0.113.0/24 table 111 nhid 101 metric 50
+ts_ip "$0" "Flush only explicit blackhole type" -4 route flush table 111 type blackhole
+ts_ip "$0" "Check unicast alias survived type filtering" -4 route show table 111
+test_on "nhid 101"
+test_lines_count 1
+ts_ip "$0" "Delete remaining unicast sentinel by exact type" -4 route del unicast 203.0.113.0/24 table 111 nhid 101 metric 50
+
+# A blackhole object hides the original IPv4 alias type in dumps. An explicit
+# type request must fail conservatively, rather than delete the unicast alias.
+ts_ip "$0" "Add alias with synthesized dump type" -4 route add 192.0.2.0/24 table 111 nhid 301
+if $IP -4 route flush table 111 type blackhole > "$STD_OUT" 2> "$STD_ERR"; then
+	ts_err "Ambiguous blackhole-object type filter unexpectedly succeeded"
+else
+	ts_log "Ambiguous explicit type failed conservatively:"
+	ts_cat "$STD_ERR"
+fi
+ts_ip "$0" "Check ambiguous unicast alias retained" -4 route show table 111
+test_lines_count 1
+ts_ip "$0" "Delete retained alias by its actual unicast type" -4 route del unicast 192.0.2.0/24 table 111 nhid 301
+
+# IPv4 via an IPv6 nexthop expands to RTA_VIA rather than RTA_GATEWAY.
+ts_ip "$0" "Add cross-family nexthop route" -4 route add table 111 203.0.113.0/24 nhid 201
+ts_ip "$0" "Flush cross-family route" -4 route flush table 111
+ts_ip "$0" "Check cross-family route removed" -4 route show table 111
+test_lines_count 0
+
+ts_ip "$0" "Delete test device and its nexthops" link del "$DEV"
+ts_ip "$0" "Delete blackhole nexthop" nexthop del id 301
+ts_ip "$0" "Delete IPv6 blackhole nexthop" nexthop del id 302

base-commit: fb6f0637f16b974767004f50d5e9905c8401815a
-- 
2.55.0

