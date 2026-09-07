Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC54E8E16
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787474; cv=none; b=rGaeFfzRPgcNd5lk00XzWJ6nG5ziQcbLHNQ3Rj77KuTEXKbrowX6aS0A6pMnNadgc7q1ylkWs8quwrW6+J+YCSBu+pFmgvbYG6pF8yFFwN9Fp1N5kkeLqvDeCWW/ukR6fDUxZc29nYBxrX/8LbTBaMDccJknv2HGED2em9xiJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787474; c=relaxed/simple;
	bh=Nagh04+KQAewuDbPwP2YDdNLfRxDNRFuBOQ3mfXIfWs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=teQJiB3FPqlyJ7ymSBmm/7KgXjmca4BNc23hQFJ8XYjzpx/EBYhalNO+ALbQf5EXFPkJSBitDK6jy7BHhbAnWFAEUivohb84A3mHynNtT3kdVoLjoKcgUHeELRNX8/JuQ7CaQ/SRw0lkizhrIxANBecA2SpIY/KYM0Zsm5+2obQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+f5tMm6; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+f5tMm6"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5fc4c7e9so334849185a.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788787465; x=1789392265; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JNpSx6TYD3rjxjaguatGBbeejpPsuGdP72b1vXHlLxA=;
        b=a+f5tMm6MQX55VWttX0q2FiWQiLmwGuU9cKF9rCZDbE0rQ8n0NzuSjeTLPN0nKelgs
         129hJgtP2JSOOOZ2/oBqwoAf5E7oJbsOfBLY9729D4G6WvMejzC+vzw0SzzHCZFiw+NO
         zfZ2ktEmv3gpUBWR7MyaM4W1E8LOaZyN54yC7SwLPn99A/zPg7quzch+ZSNawkJnxDhL
         HkwJfeBo3uVNt7Or5OzsD7SE5LX5IMByAZPWl87PgH38/pJANLL1PCFd2oAvsaJeMq91
         Dkv2+GqqQGUq/rU+WDLHzxMHM8T3ZOPRoTxGaJezBs/glzJ7ddPEkdcWJr0qWbZneVdQ
         Ouew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787465; x=1789392265;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNpSx6TYD3rjxjaguatGBbeejpPsuGdP72b1vXHlLxA=;
        b=q7YpQBwpPrRE8Hc66Uug/Op0KgZUF/xw8bNyyEBiB+aWIoqiiiwK7UIKJNwkO05ALA
         MnrQ09ABzqVMrWCIWu372/4Q9wnn/xF87QG037fcRZNt7YmCg5octm83P/FwG7sCIGsc
         BBych/g5bCpqJeZri3aKOhgiSB7oYJ8Y/UgCCrn79DBUvIvaMHDl8GfD0VCIObUa6JOU
         Io31nOX0uJVuoRLrtuPiKAflF+iD+gV034kuP2sDf2VfdeL1lU+FsnmL8hmIvnSWc38j
         VJNCCrUrV6NkOwG0Nvhwb//pOEu9cltol5lH5w1YddUgU+T3l9zcChlQTmhqdA/0oXDd
         8XBA==
X-Forwarded-Encrypted: i=1; AKwUvBwW0KsHkNxP2hyp15h/+guqLLirFlfelqEZyyYdRMomGhlXz0NTTIol6vFQiUuaMJKqgng63nU=@vger.kernel.org
X-Gm-Message-State: AFuF++m1CM4mWzw5XO6zDnzPyFE5GwlQceHKtmD9smto8nY7oOY7t2gA
	WNUr5/rljW6vQfB4lTnKy1vQ/K3GbWAEXmgooypmcEZxzvjyUsKKJAaV/IjLnEmob/tRqZ7QFzf
	JYkFsoKo2WmsR8Q==
X-Received: from qknur2.prod.google.com ([2002:a05:620a:6f02:b0:92e:6aaa:d1c3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6919:b0:939:6df9:f991 with SMTP id af79cd13be357-93980587869mr2324646585a.52.1788787464839;
 Mon, 07 Sep 2026 06:24:24 -0700 (PDT)
Date: Mon,  7 Sep 2026 13:24:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907132423.3353361-1-edumazet@google.com>
Subject: [PATCH net-next] selftests: icmp_redirect: remove xfail support
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 0a36a75c6818 ("selftests: icmp_redirect: support expected failures")
added xfail support to icmp_redirect.sh because IPv6 redirect tests
(including the VRF variants) were failing due to bugs in the IPv6
redirect logic.

Part of this was addressed in commit 0e02bf5de46a ("selftests:
icmp_redirect: IPv6 PMTU info should be cleared after redirect"), which
updated the test expectation that old PMTU information should be
cleared following a redirect.

Recently, commit cd51b74bdd0b ("ipv6: Fix redirect exception creation for
UDP/RAW sockets") fixed the underlying kernel bug in ip6_sk_redirect():
previously, passing sk->sk_bound_dev_if caused exception creation to
fail for sockets not bound to a device or bound to a VRF. Now that
skb->dev->ifindex is used, redirect exceptions are created properly for
UDP and RAW sockets, including in VRF environments.

With this fix in place, all IPv6 tests in icmp_redirect.sh pass as
expected. Passing xfail=1 to log_test() for all IPv6 tests is no longer
necessary and masks unexpected failures as XFAIL instead of FAIL.

Commit 3748939bce3f ("selftests: icmp_redirect: pass xfail=0 to log_test()")
worked around a bash error caused by empty xfail arguments on IPv4 tests.

Remove the obsolete xfail support from log_test() and restore standard
pass/fail reporting across all tests.

Tested:
Tests passed:  40
Tests failed:   0

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tools/testing/selftests/net/icmp_redirect.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/icmp_redirect.sh b/tools/testing/selftests/net/icmp_redirect.sh
index b13c89a99ecbaa37638c39b12818d2d59a97ec50..35357d02e823bcad7106cd7d628824d1787af4e7 100755
--- a/tools/testing/selftests/net/icmp_redirect.sh
+++ b/tools/testing/selftests/net/icmp_redirect.sh
@@ -64,14 +64,10 @@ log_test()
 	local rc=$1
 	local expected=$2
 	local msg="$3"
-	local xfail=$4
 
 	if [ ${rc} -eq ${expected} ]; then
 		printf "TEST: %-60s  [ OK ]\n" "${msg}"
 		nsuccess=$((nsuccess+1))
-	elif [ ${rc} -eq ${xfail} ]; then
-		printf "TEST: %-60s  [XFAIL]\n" "${msg}"
-		nxfail=$((nxfail+1))
 	else
 		ret=1
 		nfail=$((nfail+1))
@@ -303,7 +299,7 @@ check_exception()
 		ip -netns $h1 ro get ${H1_VRF_ARG} ${H2_N2_IP} | \
 		grep -E -v 'mtu|redirected' | grep -q "cache"
 	fi
-	log_test $? 0 "IPv4: ${desc}" 0
+	log_test $? 0 "IPv4: ${desc}"
 
 	# No PMTU info for test "redirect" and "mtu exception plus redirect"
 	if [ "$with_redirect" = "yes" ] && [ "$desc" != "redirect exception plus mtu" ]; then
@@ -319,7 +315,7 @@ check_exception()
 		ip -netns $h1 -6 ro get ${H1_VRF_ARG} ${H2_N2_IP6} | \
 		grep -v "mtu" | grep -q "${R1_LLADDR}"
 	fi
-	log_test $? 0 "IPv6: ${desc}" 1
+	log_test $? 0 "IPv6: ${desc}"
 }
 
 run_ping()
@@ -485,7 +481,6 @@ which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
 ret=0
 nsuccess=0
 nfail=0
-nxfail=0
 
 while getopts :pv o
 do
@@ -530,6 +525,5 @@ fi
 
 printf "\nTests passed: %3d\n" ${nsuccess}
 printf "Tests failed: %3d\n"   ${nfail}
-printf "Tests xfailed: %3d\n"  ${nxfail}
 
 exit $ret
-- 
2.55.0.979.g7e5102b832-goog

