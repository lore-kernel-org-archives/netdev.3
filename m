Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C73911AF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415111; cv=none; b=rEuk3WifoV8m8QBn4HFigHTQseJpX1O+4M6er69AJE7ohd6Xwzg9JRB+clkwvcU8j2cLP/bJ9D4d5uzI6Er1tHDBm+mX8HloJwtehhP6Jel5m9hMjdyv8NfK1UG9FXH0+R83t3THoeTj60Xi/w1fW0V266DuzmYcnvuGafVSu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415111; c=relaxed/simple;
	bh=Y4yIWHkZAo6hFkp0ZItMCsRNRRrV18SNaw0wx7tDtLQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=daMg3KVyR3TQruO5+gmzpJHiOmYVBj60XcskzNQ8kmuyhOnhIxi/ikXMokzLHmU+kaa9r+wdUT/8rLMUb15CQFkU61xfuqunDPc/SWcT58KpnAR740Hq77lGTBPrgOCb+GZ/f1JMFniDyn0GX5yjwp4aGMoaUo+yH7lvX6TyREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oaka7CXT; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaka7CXT"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d04908139bso51677505ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415104; x=1787019904; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tQ8b7mc1+u8acAYHfIJ6qopTbH8A4or6kthmEq8U0KM=;
        b=oaka7CXTt2GpEFBEv2EIqkwLdgmcI0YiPpUVtaaC/j5HiBLGd8B4twWM7dfMJQzaLN
         uzvOCcLF2o9X5Gkk2pY0V5v+POE7/mFxM4wFWVJ4AePslP1QG4Ate5pcFsIMm+9u6tCc
         FwG0BC4/lgT0dmwQL/h1dZ0psuOG7XE88ZkZGboDjERQRwX5dsLvKJNLm+Z5s1TNnGo2
         1amBqx3mI2QeMH4Yxp65QZFfAo3XuXlIUoDrIY6CKg5cIZ3D7wMxyIjJowr1rLniLj2l
         fYKKvjj6mOOghXk46UsJlWP9xcgpm4B395S/iIbpfHjTPeEr7edjx709bo14HCcRmhuP
         fQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415104; x=1787019904;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQ8b7mc1+u8acAYHfIJ6qopTbH8A4or6kthmEq8U0KM=;
        b=oyuSxsxJymEMDGPLwft7OJZaLgeA1w+GTqMlllviAHQ5qmVhplwtqI9J9k0BE8UdEL
         aqtAPIXZRdwiAFzffxflcTugWwvkKsOV7IyKIfBGXPtjH4PFl8PZNhU0qgTXthJEwfTm
         UAjd8gqpe+p0KOY5G++BrmeR+1qCgtpmFQCGpJSJvP7F9OQEM3z9I6kPqtM/AcC2+yDL
         4bO4mSbcO+iLdHWZ1iqf2YLwp2fo2BIh/Xs02Ons5rYsml8OFG3bP4Mc3bEysx9Ggkoz
         QzaUfIO6kOSyVIQ9gtbxTIMuVdLisIolpj6ZO5Le4CaR6FaINkBBMGziKBpjiDxBBoxv
         v4oA==
X-Forwarded-Encrypted: i=1; AHgh+RqOB005C8dH0JgkW0SoKyOOj5Vv2J0w2Z7w9AMDqD3Gr5a7ntejGr3EHFoz3dY/Q8lEJ3YlunA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGcQGmgYwq8QTYDpNcCxzJWCgLGeDmFhwf10OGjlJL2HkYMDrh
	/ut5oNogUXwnEQL/ymtUwNNtY7W8reYNK7mJY6V/4BRAOhcA5pz+3PlYbo6/Hjnwe6RZGXRzim5
	jfKhelA==
X-Received: from plbmv16.prod.google.com ([2002:a17:903:b90:b0:2cc:ed0e:f302])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e802:b0:2ca:d151:383a
 with SMTP id d9443c01a7336-2d31799a8acmr1220485ad.20.1786415104120; Mon, 10
 Aug 2026 19:25:04 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:49 +0000
In-Reply-To: <20260811022448.116235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-16-kuniyu@google.com>
Subject: [PATCH v3 net-next 15/15] selftest: net: Specify netns for ip ntable
 in test_neigh.sh.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

test_neigh.sh configures the following attributes in the root
netns, but now these can be set per netns.

  * NDTA_THRESH1 / NDTA_THRESH2 / NDTA_THRESH3
  * NDTA_GC_INTERVAL

Let's specify netns for "ip ntable".

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
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
2.55.0.691.gc56d675ccc-goog

