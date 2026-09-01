Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821249E5C1
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287624; cv=none; b=gp8oPkNqCJbfxZ63XU0QRDrsirrqWzsZDiCzJgsA8JpfxGVW23t2vmKS4Oeu4NA0Snwv50ANKijes4MmRUadI/8Wg660HzT8akQCcI1+kxTmod57AAP3PXFkUV325x1qi1WqgPsGQTDgO7pa3KRKEOZDqhRNp9vq7cWaagMUimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287624; c=relaxed/simple;
	bh=CT7aZm8l2zrchORHs3XVfcnW0XfzcF46CR0gQ1gSaZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uS6VpE6PwcqAPI7JYsvFx8FOFHOPUtkL2l8XjYtE3QetR2E0t04VHoXureaUDdFRQ8iGHqd5BIXqYTHZfZ2z014HeOH9Van/SokYOyGyiNVHNexz8G9F4tQqro9wrmxbvYXPaI2tynNxz7mn6rXGM8+uR5Kajq+Su9F3Dd5BRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxBaUGHo; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxBaUGHo"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso372120a12.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287622; x=1788892422; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOlaIEXUvHQikpLOlYZUo580R3fRoHuCIQ4/2h3QdjM=;
        b=SxBaUGHof2Uq6uN2xpBHtQeDpywyHe1MzUdWZaTndvZ29v/yuc1D4cF7Se0wEOpu/Q
         2WekdPL8OvdBJTURNoEdwgEPcYOIfNh7nF0Dr2h/hnw2QJF+O/b6apTIRvCL2QM/PYkL
         imuXKVOdpLiikpBPiV9LOOnmSW3hSlN7eIlII42BMLC9/iiyIS1jHoDf4qplhZgwmNbR
         xaZw5aXoFMcCn3FkGebkI5pdXyTEi2iBAYt2/WZ5/r+yoqDYDd4aEk3UBe4b2GN8SjQB
         2dX0AlP167kzEhyhTwnIZAnO6XB85JGuX1FbCUKuQ4wacnIVa2GZmphu/LwQa2ISz8/H
         8lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287622; x=1788892422;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOlaIEXUvHQikpLOlYZUo580R3fRoHuCIQ4/2h3QdjM=;
        b=To5iIpkNKNQiAEm9/MeNOdv9qsMHUqv8fTJhbdmxHB1OPmou9mGnjrmBpDx1I5qaV3
         Fxeqj7QosQt23nrbwQjqmDED9TOfLOgYfUPCFs5SF5UlMrg+rlhe9F5lU024QAW2g8Do
         YD9B6uyKSqnHGtu+vYVbO4XETW99GdDh0OienzcE/DeWWd8f/CGeTB4WMxrNr8TxeOrd
         oeKW7zaKDU9Osgp7kConi9LmqebPzrsVrHPFS/4tfmWNLxNHjghNrAVExDpZ1Hxo+Stl
         Qw1mEhjbmG2S8YHNde3v1fX2zSL7QcKgZcDKuQT97X8KMD54sS4CBoHzIysGKrn2h7mx
         1vSg==
X-Forwarded-Encrypted: i=1; AHgh+RpV6fA/b5CJaNZPMqtL7ogIfnjZHVD24CK3hGTGVu+KRWwx0l6Aujh+9DcsTxrmlDSqoiFGKNg=@vger.kernel.org
X-Gm-Message-State: AFuF++nFnUNrYkQRhfNwwnRiBtr7OBwH6GtLYaMXuWEQi2XJJU5irOrC
	34jP1ZqAbmAaSjGNBtyjlxFAhqjvnIz+UFJUGQx+/0J7GfoAyP74uYF3abB98BXzDGsPrzoV5im
	2DvGj3w==
X-Received: from pgca19-n1.prod.google.com ([2002:a05:6a02:6393:10b0:cbe:e160:452d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e97:b0:3cc:3d08:da39
 with SMTP id adf61e73a8af0-3d26246fa2dmr62855854637.0.1788287621885; Tue, 01
 Sep 2026 11:33:41 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:33:04 +0000
In-Reply-To: <20260901183327.3332855-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-16-kuniyu@google.com>
Subject: [PATCH v5 net-next 15/15] selftest: net: Specify netns for ip ntable
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
2.55.0.966.g6673acef38-goog

