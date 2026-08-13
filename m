Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CAC442B35
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608197; cv=none; b=hE1pUIdQEB9cwPfekA90gi2LvVZYpT+dLfEvBVwKDcNwFzoZjEJuQ/3CFUM3L9e6du2RiNG1cd1JhqBkeV8/6qATWngjkOH8ca6/gWTU9sI0sAcMgCksCJ7aDS2Oj1fPMvo3sNSpGVkWoj9B/K5cq1ED6ZlNxq/j1nMLI45a2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608197; c=relaxed/simple;
	bh=VCpdbD+IkWpETmBXX9b/ydQuHHYr7ZK7anBPRlurS+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nvbicyUfFzimXxkx27tNfbqWpFNY0+Ye0QJqSvbbTX3rN12KZ8cCQQ203fm5ECuSdMP4+G8vt4zwcCh9uSafbosC7SWYz617Kau4engsSfSEH4N4cgx8a7r9IbyHfMQPvTp7x8yJ9p2lixyolKb+b6HhF9HvJhveNqYqixzoBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATL+J0jC; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATL+J0jC"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485d853b08so2725520b3a.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608182; x=1787212982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cfLlpTHOIDzROJiT9zoNyMSzftmDrpgJJ3BBfG/H4YE=;
        b=ATL+J0jCHe3YpNKI1EVk3ZN1moBoJi+asrwl5gPc1Fwj/0ZICse5XoaXc1Xpp0PMG/
         46DunniuAor6aiGE9ntQ4EWq8EQPKTleFR8Py1XThRmXkns3NWmh1vfHif4RAbfi1LnJ
         wbA7p4J9fVVYUo6p7zkH0BgCOLYZqzH+j57sMWCfv3DAOO0B02SVp83fKwHjdCudfwzF
         qEVN2PCnvNdPhglxvFrSS2WozjqPuOCpyeRQ8EWopBomQ/XS2//T4bPOs1MQ+qWkLcfu
         1GrDcFUlGPf/bPC1w8Hc+sNTiRXXj5L9F4Hd9mgSoCnBvLuxIv65j8OXZoYKwNAgbBal
         wpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608182; x=1787212982;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfLlpTHOIDzROJiT9zoNyMSzftmDrpgJJ3BBfG/H4YE=;
        b=lRdEKtH8pp44zRL3IM6RVTtOnWzJIPy8haueVYOeQL7Jyc8Uhqg4PWXTmbEiUo/zpV
         lc+AwTAkfy25/VZ8mc2MVPhjiSKZs+bfkejNq33eyidm4LVmXcWPzDhJ4dB9STbJT/Pm
         /FJYTSfmmNDtWnQ4fqf6U12x5sCHqHuUEMiyAl5qqZ430QkLv409e6A7KMTanQl2XDuA
         suLx0zIrVszHgEUvf+Okf1tXKk2l22mDtlG2pqaVxsk7CHTOlHpKykDTpJ1fm8Pl9pwC
         lN60AviTfJG0IFCBnCLVI2kkw+gbeBmfTNPvGSucK7yNcCrRLOLUcIBDMjaVf94z+3uQ
         qnAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpX08Z1B6mPpM787oIkV0CiCe0ONEzTZsB/5LlGoAkH/6nEZjSp85DVhzqlXHsxj1TGsZO3dDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlqPISwY7GTTF24YS9Q/dIT1S+ODOpwz7sUzijR+jpAFGpB28
	m7veTjMKE/EM8EsYZkPlOosUNeeqNcfzwbmwY7wT1LwJ/RjwRHFArFILNJCVgrTwq5Qi2NlcrrI
	Xs/6taw==
X-Received: from pgww18.prod.google.com ([2002:a05:6a02:2c92:b0:cbe:e032:3b3d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:188b:b0:84e:2f2e:8c4f
 with SMTP id d2e1a72fcca58-84fc6d8c95bmr3916440b3a.10.1786608182154; Thu, 13
 Aug 2026 01:03:02 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:29 +0000
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813080248.407680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-16-kuniyu@google.com>
Subject: [PATCH v4 net-next 15/15] selftest: net: Specify netns for ip ntable
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
  * NDTPA_BASE_REACHABLE_TIME

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

