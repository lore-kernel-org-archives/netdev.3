Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DFE42AFB2
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145387; cv=none; b=Eh2gtNzbLFwWnpJaHaEspaoYs7egZ6gNnyVaYdm5Q1dVpH1E5JaLRsT/Aot0oWKLJbMj6g0oOJkgLsaZR8wCiD0Xe3CZYV/aRIKiMPltdP/K7YZRHyePyEJ0TfubJ05a1nwds7pNB5p37OrE1BYuqhTmS0FgSAdjDzs7MpjSaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145387; c=relaxed/simple;
	bh=vlPpVZM9ggJ+XfKvbAQtQl2Mup01PYgNb3JjLeLDBjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FMI7XUFj5v1HjdOllkcczJlkSCbJD8ahScI+J8v1t5HcDoN5PDm+UvmgdH049pBniYK/biYs2Fk3oIBwBcIKT9lqOLIxPcyBfPRBwOuUzGfT2SxygA6W4fww4nJ2OX84euRmbClaEfs9YMAM4/6i7xHv6eol4QOkpCqhaMdoKms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rViWqNyq; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rViWqNyq"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84859a64079so104085b3a.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786145385; x=1786750185; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHP8N4gF93Sn3d892+Om88mcx9eberIzJuR/Mwj9Npk=;
        b=rViWqNyqcIMx/ybSbK0hnaQIvO/5pED2un8g2aL6BZCGlpLOidQqXhRd49CGTgXezu
         eylx+sPob3T4AjdK6b3KSp120POeegA3DfkvwQuPhI2IfxEwLyPWiWKAlIXHbaN0Trj3
         9iORNvs2wHoCMmurQArNcDmCxnIVJ+jpNUXAxILoCA1xhaYh8qpqqDaOKf724ep+l1e2
         QXEbg7vTdTwKv+XMckEzzYgx3PzIgj66SVmJ672RJFOFkmrg2GdMQ4uNIG0CyJPz6lIt
         gb2xnQHqQZ7kv6nwB04jrv6R5RS2ps3AeFeOr2B0QSbaVkuYGT6EhX258Pjm02nQvPjB
         h9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145385; x=1786750185;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WHP8N4gF93Sn3d892+Om88mcx9eberIzJuR/Mwj9Npk=;
        b=HaP+ysH+jPmfmj1H+W7nRjqixQEf8ZhWHtNVB9JRJHQTo5jhbrT0Oia6rc4Z9PUhiD
         TF5ZcHveFCnvfEQ+K21Own0CU/MH+zlFrpnX/0dGXUD0yTcZt5SidcJyNhPvOX0vooDU
         UM5ugoDM5et9438QpkDi4gsyYkQSpeu+ovbuXDzHcIgI788+TAU1RPD5pK7lvQiOPUTS
         E572tdjfWvJspPG1fjOhVzIdQzOT6VndAY8dINdj0tmOn+9VDxFp/jXtQDvzSWZGWK/C
         kbWaKK2C3yYej8Sxr9eE2S6iN8AHuiR72bEBOuwk1hNpJBzQrOfIX54C3mPnTLe7Ieg/
         mmfA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0Mq4zTuuHM9cK6FDoiiMXHkP8JwmZpbmieyJg5onxHTN+50L6AvviHZAz7/sNu+X0AcRu40U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXQmaxqucRWQOmh/9KGxExU6lhrH8R2kJi8m7tg1WyogHjciD0
	/uzc4ziuV/Cx6m5KV42XqBSlWfXAdIG5jn4scEWQdGTpiiNuD9r4rhFIoviyPBw+QU65Kq8rQsO
	siFTYMg==
X-Received: from pfhz14.prod.google.com ([2002:a05:6a00:240e:b0:847:84b8:2dcf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4293:b0:84e:9257:d0c2
 with SMTP id d2e1a72fcca58-84f2dfd09fbmr31575892b3a.9.1786145384809; Fri, 07
 Aug 2026 16:29:44 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:28:51 +0000
In-Reply-To: <20260807232932.3986667-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807232932.3986667-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807232932.3986667-14-kuniyu@google.com>
Subject: [PATCH v2 net-next 13/13] selftest: net: Specify netns for ip ntable
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
 tools/testing/selftests/net/test_neigh.sh | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/test_neigh.sh b/tools/testing/selftests/net/test_neigh.sh
index 7c594bf6ead0..286da09a2010 100755
--- a/tools/testing/selftests/net/test_neigh.sh
+++ b/tools/testing/selftests/net/test_neigh.sh
@@ -241,18 +241,18 @@ extern_valid_common()
 	local orig_thresh3
 
 	run_cmd "ip -n $ns1 neigh flush dev veth0"
-	orig_thresh1=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
-	orig_thresh2=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh2")) | .["thresh2"]')
-	orig_thresh3=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh3")) | .["thresh3"]')
-	run_cmd "ip ntable change name $tbl_name thresh3 10 thresh2 9 thresh1 8"
+	orig_thresh1=$(ip -n "$ns1" -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
+	orig_thresh2=$(ip -n "$ns1" -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh2")) | .["thresh2"]')
+	orig_thresh3=$(ip -n "$ns1" -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh3")) | .["thresh3"]')
+	run_cmd "ip -n $ns1 ntable change name $tbl_name thresh3 10 thresh2 9 thresh1 8"
 	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
 	run_cmd "ip -n $ns1 neigh add ${subnet}3 lladdr $mac nud stale dev veth0"
 	run_cmd "sleep 5"
-	forced_gc_runs_t0=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
+	forced_gc_runs_t0=$(ip -n "$ns1" -j -s ntable show name "$tbl_name" | jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
 	for i in {1..20}; do
 		run_cmd "ip -n $ns1 neigh add ${subnet}$((i + 4)) nud none dev veth0"
 	done
-	forced_gc_runs_t1=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
+	forced_gc_runs_t1=$(ip -n "$ns1" -j -s ntable show name "$tbl_name" | jq '.[] | select(has("forced_gc_runs")) | .["forced_gc_runs"]')
 	if [[ $forced_gc_runs_t1 -eq $forced_gc_runs_t0 ]]; then
 		check_err 1 "Forced garbage collection did not run"
 	fi
@@ -263,7 +263,7 @@ extern_valid_common()
 
 	log_test "$af_str \"extern_valid\" flag: Forced garbage collection"
 
-	run_cmd "ip ntable change name $tbl_name thresh3 $orig_thresh3 thresh2 $orig_thresh2 thresh1 $orig_thresh1"
+	run_cmd "ip -n $ns1 ntable change name $tbl_name thresh3 $orig_thresh3 thresh2 $orig_thresh2 thresh1 $orig_thresh1"
 
 	RET=0
 
@@ -285,9 +285,9 @@ extern_valid_common()
 	local orig_gc_stale
 
 	run_cmd "ip -n $ns1 neigh flush dev veth0"
-	orig_thresh1=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
-	orig_base_reachable=$(ip -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["base_reachable"]')
-	run_cmd "ip ntable change name $tbl_name thresh1 10 base_reachable 10000"
+	orig_thresh1=$(ip -n "$ns1" -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["thresh1"]')
+	orig_base_reachable=$(ip -n "$ns1" -j ntable show name "$tbl_name" | jq '.[] | select(has("thresh1")) | .["base_reachable"]')
+	run_cmd "ip -n $ns1 ntable change name $tbl_name thresh1 10 base_reachable 10000"
 	orig_gc_stale=$(ip -n "$ns1" -j ntable show name "$tbl_name" dev veth0 | jq '.[]["gc_stale"]')
 	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale 1000"
 	run_cmd "ip -n $ns1 neigh add $ip_addr lladdr $mac nud stale dev veth0 extern_valid"
@@ -297,9 +297,9 @@ extern_valid_common()
 	for i in {1..20}; do
 		run_cmd "ip -n $ns1 neigh add ${subnet}$((i + 4)) nud none dev veth0"
 	done
-	periodic_gc_runs_t0=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
+	periodic_gc_runs_t0=$(ip -n "$ns1" -j -s ntable show name "$tbl_name" | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
 	run_cmd "sleep 10"
-	periodic_gc_runs_t1=$(ip -j -s ntable show name "$tbl_name" | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
+	periodic_gc_runs_t1=$(ip -n "$ns1" -j -s ntable show name "$tbl_name" | jq '.[] | select(has("periodic_gc_runs")) | .["periodic_gc_runs"]')
 	[[ $periodic_gc_runs_t1 -ne $periodic_gc_runs_t0 ]]
 	check_err $? "Periodic garbage collection did not run"
 	run_cmd "ip -n $ns1 neigh get $ip_addr dev veth0 | grep \"extern_valid\""
@@ -310,7 +310,7 @@ extern_valid_common()
 	log_test "$af_str \"extern_valid\" flag: Periodic garbage collection"
 
 	run_cmd "ip -n $ns1 ntable change name $tbl_name dev veth0 gc_stale $orig_gc_stale"
-	run_cmd "ip ntable change name $tbl_name thresh1 $orig_thresh1 base_reachable $orig_base_reachable"
+	run_cmd "ip -n $ns1 ntable change name $tbl_name thresh1 $orig_thresh1 base_reachable $orig_base_reachable"
 }
 
 extern_valid_ipv4()
-- 
2.55.0.679.g6767b8d81c-goog

