Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145754F796E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858811; cv=none; b=J259sQ/F27ovvH7Jdmw5K+IM5lWmNhNi6z3EiY4JPXUuaqhpIX3JtUd9TTkdEsrcsJ692m5O+e3+9HU4hJ4ncdal73wt1CvbtzD0Gnn68kBXAMgmENYKNAemMx+aoPcMj0XTBnqm/CzcdTPrRZOg5lyzXQ3XmKrMX7khNCYsDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858811; c=relaxed/simple;
	bh=NZBdoN+D7sICHUIqxIogYo7N8AlMydY+2Xt2KvyagKc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FrAXGaUnXRW81RLpmfYN663eYaEzFNmmaNyw5lEaITFoa69PgZaCX2QQ3E+UrlQ5h9TSTJBKhpszH086Rmk8nhRkyRMJmnZgJpFLMWlDZS1CW4iy5hZkc6RCShNaVgOxErGPgb3dccXb/CMrKOTP4WWiThuSchAHQSxIJ1NPtGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUoOenDr; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUoOenDr"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930b571432fso665985285a.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788858809; x=1789463609; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HshKLMaTr0KDEShsC00Zg99tlRqzwF2XWNzn73Z50Dc=;
        b=iUoOenDr5wdhR/gQWBghnWwvFbPmhgrbsdaJkhWrKsTkiLnQzcE4pX4W75seh3T6K9
         xj3uo16ll8g6uDUrJa/9QpVfZ1ZtSnP/9Gdyr7ioB/LU6+o4+CHPC1kgSSBHJQ056cOx
         6vQURRlKoiFmBFyjXTz0L65M7YBGSldWvylF7ZWFooUnj7uCHKsDJVvfYV65qyEyI7lP
         xuXCesCZtxLOlpguxebclCquD+5fvtxYt+UkajGspgVetBjy18Tnk63/KlnHpQ3Cc2lt
         NGUd4B4rupcMBO92GxAMsBRWRmGqVOgA/tpY7kUUamBMdSWjBCkPOTbdh4aAUekkY2+v
         v6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858809; x=1789463609;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HshKLMaTr0KDEShsC00Zg99tlRqzwF2XWNzn73Z50Dc=;
        b=F7RVRyUoME/TfWW/1Mh4eIpHLvSomdQXlCBpN3Eb/DA+yiJTQu0H1eJ0dCodY83PZx
         uLV3z8HNRew6oiglD/iZFbKb16hPB5nmy7cW0aFB5ajHju60IRpnnl7126bTk2vYsptH
         BieGrDbWn+v1NM9A6dD8kl9hUWKa77G+SBGI4e0RVzq1JppQ+mcxGAIO51lNQMqcKrFC
         Y7nTjjDngLbVz0OCERFbZnNYeiW1R/+v6grbOAWKoRsAM/nnG6pWy0jylZIQfUKnudL0
         NGLW/0lO7abo0Yf1WzKKfjJy/BnjUxITt7qlt56JuI31wKLDwYonEuX26GO0WjRM1Oyk
         UqtA==
X-Forwarded-Encrypted: i=1; AKwUvBz6vhst0r7+8kVwe4ZGYPkf2hzaaz0CA3XOf1HZ2hDAKbRU6gAbWDhwc2waZJm7LcdhzzUej78=@vger.kernel.org
X-Gm-Message-State: AFuF++n4DD5kgj0eTJHhhyYvXaB3CvblB1QSLCVC7FAHy4qXJZdzwiKu
	vPDL6Vc8gtNoaaTrdE6nCrbfZFjX9l1OKop8z3/4RDzGurq2/+DRzPIzo/zGkCSUD9uL4ov7Jom
	OC1c9Tc4szJ3OtQ==
X-Received: from qkoz12.prod.google.com ([2002:a05:620a:260c:b0:934:b322:8e9f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2990:b0:939:a5a0:4a08 with SMTP id af79cd13be357-939a5a0627dmr990828785a.8.1788858808511;
 Tue, 08 Sep 2026 02:13:28 -0700 (PDT)
Date: Tue,  8 Sep 2026 09:13:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908091327.349091-1-edumazet@google.com>
Subject: [PATCH v2 net-next] selftests: icmp_redirect: remove xfail support
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 0a36a75c6818 ("selftests: icmp_redirect: support expected failures")
added xfail support to icmp_redirect.sh because the test "IPv6: mtu
exception plus redirect" was failing at the time due to a perceived
kernel bug described in commit 99513cfa16c6 ("selftest: Fixes for
icmp_redirect test").

However, commit 0e02bf5de46a ("selftests: icmp_redirect: IPv6 PMTU info
should be cleared after redirect") subsequently fixed the test logic:
after redirecting to a new path, the old PMTU information should indeed
be cleared, so the test was adjusted to verify the redirect without the
old PMTU.

Since that fix, the test has been passing and is no longer expected to
fail.

Leaving xfail=1 in log_test() for all IPv6 tests was not only obsolete,
but had the undesirable side effect of masking any future IPv6 failure
as XFAIL instead of FAIL. Furthermore, commit 3748939bce3f ("selftests:
icmp_redirect: pass xfail=0 to log_test()") had to work around a bash
syntax error caused by the empty xfail argument on IPv4 tests.

Remove the obsolete xfail support from log_test() and restore standard
pass/fail reporting across all tests.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
v2: more accurate changelog (Ido)
v1: https://lore.kernel.org/netdev/20260907132423.3353361-1-edumazet@google.com/

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

