Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9C361952
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792292431; cv=pass; b=kqLGxkmvteTTzGUnD1x/UxG311HmZj7LBNB3FcnQOKUJc43SzkVGXoKLYzbyIauIMEmxzBUc49hg34ciEjFAxOTdaSswBFiJpRsVbTGp8Rx5UwbsW+wtl6YHV5pfM8zkBqg/RKjlwacfFUENoJsyrxjdDOPjN2PhKWUS9m3PMOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792292431; c=relaxed/simple;
	bh=8PsDH2syP0Hpscvpi/eceGgcmilg47lEgClPlkV2PAI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e6cXcympeNpBJL7TT7RBu9TdHeB4sFMrF0mMMROD5qxKD2tzzbdsH/Hi7fts+P0IP8oOPntmzhFawXxSSv4pFcSD7xNhAT0kwTM4scLlE9tOsElDT0dteJt0BRQAVK9XSzpsV4nrITsoxqm1f7c+h/XtlQtIW2cWl26NEBkYqG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT+Dn/pn; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT+Dn/pn"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so1152914a12.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 20:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792292427; cv=none;
        d=google.com; s=arc-20260327;
        b=QD52jij00oDUlJqxVub1BKLwbuFaTTIA0y4ymiomSg2kRgMKJ5JtFJynTYJlx9HjvM
         JC7J/4KnrnALyMTH17GqUW7FNEmD0/8UNGA4gT6dFCkGIyjB7h7V9nM9FR1hZ1UtnyOR
         pFRRRYMskzAQ9OagLmN/QWLFKOEuOlKOlOqhRzsFEw3fuwSAfnxV7LFTKo3O0RnANBNq
         bYPH+EENVs/An42qjSsgMK4car8Oyd0O8jj81+Iag+ww4H0HSbNisSrnYia2WgL4k9py
         hO+BWX+kKCitWXk4NyAClD9CdpP8yg56Holve/NNNaWhqWdjGOXLmjd9qUaMT3g9xc7D
         sWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=U7B87ZX8dWRQli8yNTgNgWMexmxKijISXNTPTA2Df8o=;
        fh=QfNzxoV9m+7xRk/IxK2MRELiBSpiXn/CtGOrK/o4K7M=;
        b=GKshr6ekBhvSWBFVmWOS9qrf8h/Y6E+v5fWbGQzfTeT2cOw+mZWabRbQbVBaduEAYg
         Fdqdt6c9FDl/M8v/C2kEA9npixXm55vr2a3yVxgqd3le2KtV63DQTDkg0B5jfT/LhrRK
         143ZCnYzHLhSTSNkgdOuo7/8YuLMb12Pbz6XtNBnqD56Ig0wl4QCSPJTciJ9ftjfO7se
         ouKeYMNuE7UL3vFK5IlpUDsVyl/enFvOyfjucSmfjXGPrhpDBM6aMf9ef0WA29jLx+n3
         cElPZ5a41vGUw2f4UM6YFoUBfRwwex2mxIBLAlCF03rMrsp9bJlvrVVqRRRw3maAvl1K
         s+SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792292427; x=1792897227; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U7B87ZX8dWRQli8yNTgNgWMexmxKijISXNTPTA2Df8o=;
        b=DT+Dn/pnI6/SiqTOnx9lkOORoC1Knkl7ZC5O48/HNgX2ESQG1ecDafG94o3ipFUwaP
         7u5LJmjblCyFu1cPuI3ZRqoU+DMhrTQGSBBAyBXS1JL4c1vYg5hckkyEWxzWbB9PZvIm
         IwCcdXVnm4Szje4vFPzTZ32HomOAAU5on7zbyFeAAlplNgKiWTQCvkOVut2o+LS0yUE2
         7e69gZFXH5eowp7/0vj6hGfEwNt6oU8Z4MfQrE1EzQCh1hL9qmhKTgGjd0dSSYR7wOw1
         2MDEyma/pPl5xqA9vSpS79dNKr/xDd9Hfrm5LsbgDSoPgNzHF+8Anw5Uyy8nOg6wqnvT
         YOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792292427; x=1792897227;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U7B87ZX8dWRQli8yNTgNgWMexmxKijISXNTPTA2Df8o=;
        b=ThqqiPQRid9s4h8THuOvrRVyGV9WwDqDPp9WGy0GSKWpnSvOUVei4PLXU53bpcd0Yt
         qUSEwGtRiWMp2ZNNoG2CprBLKbPs68+kVQwSAFwhc0cH4ClTujPCtAKovpIcB8dOEs9f
         s4dkTMtKqzj+21SXer3A+NZmIb5sgZdDNW7lIIYIIFmt7Jq9Sjnb69eYpP49Q08zaE2h
         5+r47ZOOFOy+TX0SHVhg5Z8lYWWHXzYIZsQnv/bv+EknMto/dyjuw9BR1lKnHzUauRBL
         +fKfF/ZD5tYvqaufpI1yyhiwlWk337nFY/RDgb1q2ElNr3KYS18osXDVx9/uj/rWIiRq
         6e2g==
X-Gm-Message-State: AFq9FYLNCr/ocwnfmLIIqMSvo6TOdcmMTJ/Pfy5djCepegQyKCCHg7wz
	lSdl1+O6NGV4c17YXzvipkqM+B3+8Vi5GzyEqDAE+T7LbIyfR2eshqCBhax7wi7wXgLiyek1bMO
	5cy/KcxiuRGxM9Lp55Oml9AOMzzyFFFrVPQ==
X-Gm-Gg: AYBFou1s9YeNFnYftS4Maw7jor5xt2V8zXWtCfUna5BIq9tmFtp8NoVFmpoNWudk5Kr
	8G3THGlggxxjgDUjkhlw83wkDaLjiKEsmoijnamP7uSKu4YW/tXCFXxX2hPt34hcSVZ9jZapAe8
	89smK7SVLs0VDxPG8lbTwtjyFepkywJkbf5eC1pxhSd69HO9lVtI6av5e3Bhwf+gCoH9kWxnwci
	KY8tos/w4Dm+19rd0i97vLajJcM+nVnE79b7sOi3wQpjmuAfwgE5J1qgFdNlqOM80zetDUpFTN4
	m40dqIlik6Nz7fcjdfRv/gsF9eWqzJvJopVmhymUq2kcB7VfamJvfM0=
X-Received: by 2002:a05:6402:5292:b0:6ac:7737:e50d with SMTP id
 4fb4d7f45d1cf-6b3a81a7a5dmr2423811a12.29.1792292426742; Sat, 17 Oct 2026
 20:00:26 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 17 Oct 2026 20:00:26 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 17 Oct 2026 20:00:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yuen Su <zypulsecore@gmail.com>
Date: Sat, 17 Oct 2026 20:00:26 -0700
X-Gm-Features: AclHuK8oATjWxCa-zOph6wGQjzbo6puq2kYXP4uThIxrVdOWy0-mmX3Q9F1SIsg
Message-ID: <CAC9WPdwmM4=64DH5nY85srnLhRBS7PkjR9vrsALpob-GutbmZw@mail.gmail.com>
Subject: [PATCH iproute2] ip: flush nexthop-object routes without
 compatibility attributes
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"

Route dumps carry RTA_NH_ID together with compatibility-expanded nexthop
attributes. Copying both into RTM_DELROUTE is rejected. Compact the
flush copy while preserving the exact ID and route selectors, use its
new length for batching, and leave the original dump intact for verbose
display.

IPv4 blackhole objects synthesize a route type which may differ from the
FIB alias. Without a type selector, omit that synthetic constraint.
Retain explicit type filters so a typed flush cannot delete another
alias sharing the prefix, metric and nexthop ID. An ambiguous typed
request remains a conservative failure.

Add real-kernel regressions for IPv4/IPv6 single nexthops, groups,
ordinary multipath, mixed flush batches, blackhole aliases, cross-family
gateways, exact metric/table retention and type-filter preservation.

Signed-off-by: Yuen Su <zypulsecore@gmail.com>
---

Validation (outside the commit message):
- Native Linux 7.0.0-38: 34 semantic assertions in an isolated netns;
  the same complete ip binary matrix passes ASan/UBSan with default checks.
- Public native/kernel/sanitizer CI:
  https://github.com/ZyPulse-zy/iproute2/actions/runs/39084138700
- Commit-message-only revision; identical whole source tree verified by:
  https://github.com/ZyPulse-zy/iproute2/actions/runs/39084640319
- AArch64/musl full ip cross-build and the same 34 assertions pass using
  QEMU for 68 route/device commands; 14 nexthop-object fixture commands
  use native ip because QEMU nexthop management returned ENOTSUP.
- Explicitly typed ambiguous IPv4 blackhole-object aliases remain a
  conservative failure. No production router or NSS firmware was tested.

Prepared with AI assistance and checked with real-kernel regression tests.

 ip/iproute.c                             |  39 ++++++-
 testsuite/tests/ip/route/flush_nexthop.t | 136 +++++++++++++++++++++++
 2 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100755 testsuite/tests/ip/route/flush_nexthop.t

diff --git a/ip/iproute.c b/ip/iproute.c
index 1ce71f7..22713db 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -766,6 +766,38 @@ static void print_rta_multipath(FILE *fp, const
struct rtmsg *r,
 	close_json_array(PRINT_JSON, NULL);
 }

+static void flush_nexthop_compat(struct nlmsghdr *n,
+				const struct nlmsghdr *source)
+{
+	const struct rtmsg *r = NLMSG_DATA(source);
+	struct rtmsg *flushed = NLMSG_DATA(n);
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
+	/* IPv4 displays a blackhole object as RTN_BLACKHOLE regardless of
+	 * the FIB alias's original type. Without a type selector, omit that
+	 * synthesized constraint. Never weaken an explicit type filter.
+	 */
+	if (!filter.typemask &&
+	    r->rtm_family == AF_INET && r->rtm_type == RTN_BLACKHOLE)
+		flushed->rtm_type = RTN_UNSPEC;
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
diff --git a/testsuite/tests/ip/route/flush_nexthop.t
b/testsuite/tests/ip/route/flush_nexthop.t
new file mode 100755
index 0000000..212643a
--- /dev/null
+++ b/testsuite/tests/ip/route/flush_nexthop.t
@@ -0,0 +1,136 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+. lib/generic.sh
+
+# The testsuite normally supplies IP and runs each test under unshare -n.
+[ -n "$IP" ] || ts_skip
+if [ -n "$IPROUTE_TEST_PARENT_NETNS" ] &&
+   [ "$(readlink /proc/self/ns/net)" = "$IPROUTE_TEST_PARENT_NETNS" ]; then
+	ts_err "Refusing route writes in the parent network namespace"
+	exit 1
+fi
+
+ts_log "[Testing route flush with nexthop objects and compatibility
attributes]"
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
+	ts_ip "$0" "Create first nexthop" -"$family" nexthop add id "$nh"
via "$gw" dev "$DEV" onlink
+	ts_ip "$0" "Create second nexthop" -"$family" nexthop add id "$nh2"
via "$gw2" dev "$DEV"
+	ts_ip "$0" "Create nexthop group" nexthop add id "$group" group "$nh/$nh2"
+	ts_ip "$0" "Add selected single-nexthop route" -"$family" route add
table 111 "$prefix" nhid "$nh" metric 10 mtu 1400 advmss 1360
+	ts_ip "$0" "Add another metric on same prefix" -"$family" route add
table 111 "$prefix" nhid "$nh2" metric 20
+	ts_ip "$0" "Add same route in another table" -"$family" route add
table 112 "$prefix" nhid "$nh" metric 10
+	ts_ip "$0" "Flush selected metric only" -"$family" route flush table
111 metric 10
+	ts_ip "$0" "Check other metric survived" -"$family" route show table
111 "$prefix"
+	test_on "nhid $nh2"
+	test_on "metric 20"
+	test_lines_count 1
+	ts_ip "$0" "Check other table survived" -"$family" route show table
112 "$prefix"
+	test_on "nhid $nh"
+	test_lines_count 1
+	ts_ip "$0" "Add multipath nexthop-object route" -"$family" route add
table 111 "$group_prefix" nhid "$group" metric 30
+	ts_ip "$0" "Flush group with verbose display of original dump"
-"$family" -s -s route flush table 111 to "$group_prefix"
+	test_on "nhid $group"
+	ts_ip "$0" "Check group route was removed" -"$family" route show
table 111 "$group_prefix"
+	test_lines_count 0
+	ts_ip "$0" "Check nexthop group itself survived" nexthop show id "$group"
+	test_on "id $group group"
+	ts_ip "$0" "Add ordinary multipath route without ID" -"$family"
route add table 111 "$plain_prefix" nexthop via "$gw" dev "$DEV"
weight 1 nexthop via "$gw2" dev "$DEV" weight 2
+	ts_ip "$0" "Flush ordinary multipath route" -"$family" route flush
table 111 to "$plain_prefix"
+	ts_ip "$0" "Check ordinary route removed" -"$family" route show
table 111 "$plain_prefix"
+	test_lines_count 0
+	# One flush batch mixes compacted single/group messages with an unchanged
+	# ordinary route. The next message must start at the new compacted length.
+	ts_ip "$0" "Add group to mixed flush batch" -"$family" route add
table 111 "$group_prefix" nhid "$group" metric 30
+	ts_ip "$0" "Add ordinary route to mixed flush batch" -"$family"
route add table 111 "$plain_prefix" dev "$DEV" metric 40
+	ts_ip "$0" "Flush mixed batch with original dump display" -"$family"
-s -s route flush table 111
+	test_on "nhid $nh2"
+	test_on "nhid $group"
+	ts_ip "$0" "Check no selected routes remain" -"$family" route show table 111
+	test_lines_count 0
+	ts_ip "$0" "Flush second table" -"$family" route flush table 112
+done
+
+# A blackhole object has no compatibility gateway/device fields to strip.
+ts_ip "$0" "Create IPv4 blackhole nexthop" -4 nexthop add id 301 blackhole
+ts_ip "$0" "Add blackhole-object route" -4 route add table 111
192.0.2.0/24 nhid 301
+ts_ip "$0" "Flush ID-only blackhole route" -4 route flush table 111
+ts_ip "$0" "Check blackhole object retained" nexthop show id 301
+test_on "id 301 blackhole"
+for type in blackhole unreachable prohibit; do
+	ts_ip "$0" "Add $type alias using blackhole object" -4 route add
"$type" 192.0.2.0/24 table 111 nhid 301
+	ts_ip "$0" "Flush $type alias without relying on synthesized dump
type" -4 route flush table 111
+	ts_ip "$0" "Check $type alias removed" -4 route show table 111
+	test_lines_count 0
+done
+ts_ip "$0" "Create IPv6 blackhole nexthop" -6 nexthop add id 302 blackhole
+ts_ip "$0" "Add IPv6 blackhole-object route" -6 route add table 111
2001:db8:5::/64 nhid 302
+ts_ip "$0" "Flush IPv6 ID-only blackhole route" -6 route flush table 111
+ts_ip "$0" "Check IPv6 blackhole object retained" nexthop show id 302
+test_on "id 302 blackhole"
+ts_ip "$0" "Add ordinary blackhole route without ID" -4 route add
blackhole 192.0.2.0/24 table 111
+ts_ip "$0" "Flush ordinary blackhole route" -4 route flush table 111
+ts_ip "$0" "Check ordinary blackhole route removed" -4 route show table 111
+test_lines_count 0
+
+# Type filtering must not delete another alias sharing the prefix,
metric and ID.
+ts_ip "$0" "Add unicast type-filter sentinel" -4 route add
203.0.113.0/24 table 111 nhid 101 metric 50
+ts_ip "$0" "Append explicit blackhole alias with same nexthop" -4
route append blackhole 203.0.113.0/24 table 111 nhid 101 metric 50
+ts_ip "$0" "Flush only explicit blackhole type" -4 route flush table
111 type blackhole
+ts_ip "$0" "Check unicast alias survived type filtering" -4 route
show table 111
+test_on "nhid 101"
+test_lines_count 1
+ts_ip "$0" "Delete remaining unicast sentinel by exact type" -4 route
del unicast 203.0.113.0/24 table 111 nhid 101 metric 50
+
+# A blackhole object hides the original IPv4 alias type in dumps. An explicit
+# type request must fail conservatively, rather than delete the unicast alias.
+ts_ip "$0" "Add alias with synthesized dump type" -4 route add
192.0.2.0/24 table 111 nhid 301
+if $IP -4 route flush table 111 type blackhole > "$STD_OUT" 2> "$STD_ERR"; then
+	ts_err "Ambiguous blackhole-object type filter unexpectedly succeeded"
+else
+	ts_log "Ambiguous explicit type failed conservatively:"
+	ts_cat "$STD_ERR"
+fi
+ts_ip "$0" "Check ambiguous unicast alias retained" -4 route show table 111
+test_lines_count 1
+ts_ip "$0" "Delete retained alias by its actual unicast type" -4
route del unicast 192.0.2.0/24 table 111 nhid 301
+
+# IPv4 via an IPv6 nexthop expands to RTA_VIA rather than RTA_GATEWAY.
+ts_ip "$0" "Add cross-family nexthop route" -4 route add table 111
203.0.113.0/24 nhid 201
+ts_ip "$0" "Flush cross-family route" -4 route flush table 111
+ts_ip "$0" "Check cross-family route removed" -4 route show table 111
+test_lines_count 0
+
+ts_ip "$0" "Delete test device and its nexthops" link del "$DEV"
+ts_ip "$0" "Delete blackhole nexthop" nexthop del id 301
+ts_ip "$0" "Delete IPv6 blackhole nexthop" nexthop del id 302
-- 
2.53.0
