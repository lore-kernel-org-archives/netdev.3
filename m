Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116374CCDD7
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381506; cv=none; b=TA89dDBGrB/e/byIzCxt4KVkgecHKudqanlvqHXJidAadi08bBi3Z8IMJlJ85Hdf68sEgP4TaTYqHf1Oa2IgKgBoEZsSYkUYB8NtnaghJK+wUOobEQs/5/IxWr+NIsxjdZF0+RgqBW/DVABbl1xhQoelLuzBSi8rsQYIX85GN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381506; c=relaxed/simple;
	bh=4uCkXKxSSKSenh+RA0ryhTNu5qMU5lMDxpvtoYl0MLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BE4oBjb5J87pm7bBk692MshaAhwE7Riom7+6rYTumL+gUHwJW5K9CD1mO2nLHpmeKSeKrePF2bMrY9nv2sKUVeoYvBsg3Wu8lYB3pVOf/gMT5Z65zgAC9fKIbvvoidZaosHM2vkQHBZadTd6fNQiHTjmu8lBDk6AHnk0aaY6dZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCbppRwF; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCbppRwF"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a67b16217so2537945b3a.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381503; x=1788986303; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMYICztYTCgg+TQURlpV/JPopIeduPXezSdTxHBMSzA=;
        b=GCbppRwFbIA6gJFWDec+dZaPEtFJjiLC1ikr5gUMJJgeImv1UtSTzgCRBDnuDp6H94
         PwoTcKE1c0THIipNzTYMq4CNGJeSrbdzbf0jDUEIKCmcUdxEr/mvHvkwYDXbECncR7QA
         yEtlkX/pYmiLHB2wvaIz1rHGrbi1D5KAmkjPAWDvf6bZSqtO3SVYshLXkbLqlM3V5lFZ
         pro83fhReG6Q6WQF38ZgeKgUwqUk38WFJa08wvz8zyWDZmIuS5DWCJGJsuAHv26q2Kvb
         eKuFuBaACTEVjw3FuHakhxEATOknIm+MyaTAkEY2h/ZWqlzzYxaPbo9Xr/4L+KxvYWzL
         M5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381503; x=1788986303;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gMYICztYTCgg+TQURlpV/JPopIeduPXezSdTxHBMSzA=;
        b=tO/mzqzi5kIHU/ZqBAgp5e3bU5VMnAi07UwM2cWBh9852B3vv2oicEDV5qnToP8+oC
         UMraYyqt4TgUv6T6xsmu65UshJz7zIbPYg3d9WIWDrvIZ5hsla5weXAIFv+oPEGz3WMU
         1vZ2n0wrne4nwbeE12zTX8HtBd1Z7LBgeo+bJsOg8T6BcTMDqQ+QoEHn5Ae/XFPSQroh
         wDlkEE2gy94mXRMtv/tCBL5FzHkGdIhZT42CxMmYLEpJ9R1OOppUj7sAacUhVbHsUOqZ
         QNpqjamtZyXkGkspUyzOZOx8fhTjk1Vrlm+hBB4AUyMpWyo6SGvuHqQBs2hb4oZMI3zf
         Yw8Q==
X-Forwarded-Encrypted: i=1; AKwUvBztY32noj0Q4ZAqoTpI+FdIsBg71VSPcoaGYBYvaeK6/BGmdzSFBQ4TQUPU2PYRbHpIapKGgwg=@vger.kernel.org
X-Gm-Message-State: AFuF++l00an4q3mt1D8igDqaXmfOSdMPNDdVLV03dud8rURLGk3QWpxH
	QP/1oc5/TykXSBY47SoHJOrxE8GcewCLYP2Xq0gYb+Fplmw4atVqI6O2c4DTe6LVHxgLPOLkdqM
	/uTFf0Q==
X-Received: from pfde12.prod.google.com ([2002:aa7:8c4c:0:b0:847:80c0:ec04])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a3:b0:857:7337:5dbc
 with SMTP id d2e1a72fcca58-85ed9f9eea9mr11191755b3a.26.1788381502419; Wed, 02
 Sep 2026 13:38:22 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:36:56 +0000
In-Reply-To: <20260902203722.926528-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902203722.926528-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902203722.926528-16-kuniyu@google.com>
Subject: [PATCH v6 net-next 15/15] selftest: net: Specify netns for ip ntable
 in test_neigh.sh.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

test_neigh.sh configures the following attributes in the root
netns, but now these can be set per netns.

  * NDTA_THRESH1 / NDTA_THRESH2 / NDTA_THRESH3
  * NDTPA_BASE_REACHABLE_TIME

Let's specify netns for "ip ntable".

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v3: Remove stale comments
---
 tools/testing/selftests/net/test_neigh.sh | 41 ++++++++++++-----------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/test_neigh.sh b/tools/testing/selftests/net/test_neigh.sh
index 447423713266..e70e31edf633 100755
--- a/tools/testing/selftests/net/test_neigh.sh
+++ b/tools/testing/selftests/net/test_neigh.sh
@@ -240,9 +240,6 @@ extern_valid_common()
 	# Check that an "extern_valid" entry survives a forced garbage
 	# collection. Add an entry, wait 5 seconds and add more entries than
 	# "thresh3" so that forced garbage collection will run.
-	#
-	# Note that the garbage collection thresholds are global resources and
-	# that changes in the initial namespace affect all the namespaces.
 	local forced_gc_runs_t0
 	local forced_gc_runs_t1
 	local orig_thresh1
@@ -250,18 +247,23 @@ extern_valid_common()
 	local orig_thresh3
 
 	run_cmd "ip -n $ns1 neigh flush dev veth0"
-	orig_thresh1=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
-	orig_thresh2=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh2")) | .["thresh2"]')
-	orig_thresh3=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh3")) | .["thresh3"]')
-	run_cmd "ip ntable change name $tbl_name thresh3 10 thresh2 9 thresh1 8"
+	orig_thresh1=$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
+			jq '.[] | select(has("thresh1")) | .["thresh1"]')
+	orig_thresh2=$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
+			jq '.[] | select(has("thresh2")) | .["thresh2"]')
+	orig_thresh3=$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
+			jq '.[] | select(has("thresh3")) | .["thresh3"]')
+	run_cmd "ip -n $ns1 ntable change name $tbl_name thresh3 10 thresh2 9 thresh1 8"
 	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
 	run_cmd "ip -n $ns1 neigh add ${subnet}3 lladdr $mac nud stale dev veth0"
 	run_cmd "sleep 5"
-	forced_gc_runs_t0=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
+	forced_gc_runs_t0=$(ip -n "$ns1" -j -s ntable show name "$tbl_name" | \
+				jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
 	for i in {1..20}; do
 		run_cmd "ip -n $ns1 neigh add ${subnet}$((i + 4)) nud none dev veth0"
 	done
-	forced_gc_runs_t1=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
+	forced_gc_runs_t1=$(ip -n "$ns1" -j -s ntable show name "$tbl_name" | \
+				jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
 	if [[ $forced_gc_runs_t1 -eq $forced_gc_runs_t0 ]]; then
 		check_err 1 "Forced garbage collection did not run"
 	fi
@@ -272,7 +274,8 @@ extern_valid_common()
 
 	log_test "$af_str \"extern_valid\" flag: Forced garbage collection"
 
-	run_cmd "ip ntable change name $tbl_name thresh3 $orig_thresh3 thresh2 $orig_thresh2 thresh1 $orig_thresh1"
+	run_cmd "ip -n $ns1 ntable change name $tbl_name \
+		thresh3 $orig_thresh3 thresh2 $orig_thresh2 thresh1 $orig_thresh1"
 
 	RET=0
 
@@ -284,10 +287,6 @@ extern_valid_common()
 	# collection. Add an "extern_valid" entry, add more than "thresh1"
 	# regular entries, wait "base_reachable" (longer than "gc_stale")
 	# seconds and check that the "extern_valid" entry was not deleted.
-	#
-	# Note that the garbage collection thresholds and "base_reachable" are
-	# global resources and that changes in the initial namespace affect all
-	# the namespaces.
 	local periodic_gc_runs_t0
 	local periodic_gc_runs_t1
 	local orig_base_reachable
@@ -296,10 +295,13 @@ extern_valid_common()
 	local timeout
 
 	run_cmd "ip -n $ns1 neigh flush dev veth0"
-	orig_thresh1=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
-	orig_base_reachable=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["base_reachable"]')
-	run_cmd "ip ntable change name $tbl_name thresh1 10 base_reachable $base_reachable"
-	orig_gc_stale=$(ip -n "$ns1" -j ntable show name "$tbl_name" dev veth0 | jq '.[]["gc_stale"]')
+	orig_thresh1=$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
+			jq '.[] | select(has("thresh1")) | .["thresh1"]')
+	orig_base_reachable=$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
+				jq '.[] | select(has("thresh1")) | .["base_reachable"]')
+	run_cmd "ip -n $ns1 ntable change name $tbl_name thresh1 10 base_reachable $base_reachable"
+	orig_gc_stale=$(ip -n "$ns1" -j ntable show name "$tbl_name" dev veth0 | \
+			jq '.[]["gc_stale"]')
 	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale 1000"
 	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
 	run_cmd "ip -n $ns1 neigh add ${subnet}3 lladdr $mac nud stale dev veth0"
@@ -325,7 +327,8 @@ extern_valid_common()
 	log_test "$af_str \"extern_valid\" flag: Periodic garbage collection"
 
 	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale $orig_gc_stale"
-	run_cmd "ip ntable change name $tbl_name thresh1 $orig_thresh1 base_reachable $orig_base_reachable"
+	run_cmd "ip -n $ns1 ntable change name $tbl_name \
+		thresh1 $orig_thresh1 base_reachable $orig_base_reachable"
 }
 
 extern_valid_ipv4()
-- 
2.55.0.970.g62bdec98f9-goog

