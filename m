Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83A4FDA5F
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781805; cv=none; b=Ew1CuQuPUzBzK1wt0l2YFiF06+NrP29ygdWLklRqd4sGaCxKqMK7ZqjiCUXcgmuLj/coGbDea6z0TDJdK8J+jpOpIu7f4lLw4bk9sHplix3rqMUfoVzEpDHsy8/yzyzVJBioNlFcxDA3yP6V+/VPACqq6Gux7znRfngkyzjPQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781805; c=relaxed/simple;
	bh=b9y4NXkgYg8B4pqDswquuydxBE3Tjnq/EUwfuU2Enwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWLrNT+1i8+2FBaiChSi4SGlqdnsZSU/ZLwTVQDSrhH0wXkvVmezdClM4Oq0wwQNiu32LFMavKcriUhWDTZ86T4t0BAG4LFM4C7LgyLmSBYHFn6e+mMnhaoQF1CII+Fi8EkNCOQzHSLGSk2CZ6ZMc05POArU0PbZjSmHLH9CR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=TGT+Thhp; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="TGT+Thhp"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e320322edso21804866b.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1790781797; x=1791386597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKz38TwNtR/kCvzhvPBXJpWiMyE9q1ag9Gm3OPI54Dw=;
        b=TGT+Thhpg0Ome/58A2npn/9DZHfV2RSvXLQdydNKZwVHgXJFKU4sxgIwaegEwh/RSK
         44jrC0I6HQcO10IRe1BhsuNFYaxsP+Lu5P4VFYn9Whp1P0f80fmmjyFRm/H05FbxmyLO
         +T62Cp4TlM/AxwFk1hnQuG06ptzNVnLHt2HvbqLfv+6P76fVZqk73SXfnfeRICUFjw6J
         P+n/1VI2ZHUl7P8jPVqiALdJzG4abHjkOsXVCS0lDRJ1gny86iZ+P4sczwu7EyxtEpLk
         3y/FMgjCf7U+NOYWyngLfLIs+MXf6Kl5NwbLiyk7AL1DyX/z+jxUNDJpkBuHz3NHNmi0
         +mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781797; x=1791386597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xKz38TwNtR/kCvzhvPBXJpWiMyE9q1ag9Gm3OPI54Dw=;
        b=radog8Td3IBjh3VS2atxD8N1QeDPwjf7pLAUGkml1XLYrPGvpo9s+wqe10+Bzy5K2O
         +/quXWDR+FeutXa/IZBrbQJf16uhFpND+MpcjEvZOeqIy8wdZKYrIOivkekhOs40rIYO
         3oJhpLJJXvryGulvIBw+s5sVU8GS58UY5iHJJkjZkMVgitUB5sMW5ylVNERaxKnDRZke
         k8uA3ZXuWGjkIkOVHhw3AnfOf7Qa5tPWeQpqQcFMbQPqfLd0vG0DSWj3rw43PzqJdhqQ
         07LO8m6RHty9+d7uH/Ej7u1lh33Iz+5av9neknqCotAYZSt5bEcCnhYvJ4wXWWApxh7o
         skRg==
X-Gm-Message-State: AFq9FYJ2Qn3pmYOWmV3DpOw/5hrzIQNUchi6Wcl6IXzpGXcqtAI2Fnos
	a4cf8UZvgNiK7qC338s5W+yazek2N/biNNUUYYATvwV/B8TEGmAcMveK2TcNbrDcbC4YkcY8PT5
	Jn3ZejeaTbuIsDsILgqCgGW6MSpIeoxUq9Ps27KFyqSZ0VlkaM+dI2Wed+q4mhioHgvL00ja0mY
	FgbINt9GBQEQVNqSXJikDzvhYBkRTXEXqERhu3IsOzooo=
X-Gm-Gg: AYBFou1W5Z+6BfogFvLiSqxjZPKPPX/pBTkqh2cCqjgUkpB9o9bBRQQF2baOD1bMl38
	0EZxvnvx2e7BSkWfABG1rwuhyOaC7/2o4xft55jt6s49Vh4Ncpay+1KK8upr02R+Tpqqmb7qiKA
	isWP7Iub0dO5x8R6Qv439FQX1l+tI0axfGrRwCJYihtRJ8cD3QQuNHlpUIgnTrEL6q6yhHuP8ON
	ZJNEQ7a53fbsPmeHf5agU8uYNvT5fjGnwYkNq3tUXw0ycV0qVI53CkENfWMBEOofua5Yzs9q2Ly
	f1Y+u/W3AUs//GQvKCzUt2QcDkUhtwdGdp3dyQsMVj+s6QWIhuq6XkYUo0qVJ8nM5+BXQvKOTEn
	U7XXeKlJybLc2Q3nZkZBTKESzOGz+3Uy/qd/fjRlGDUzu1mU05fKsoReSa6LzuelFBvQcGkN78n
	v9SCavYL0K1kLULK/Cpz9u0+SbgJbsi0Rj8VJXlLLn00nl4h38WNsYjuXLPqecpEdX/wDw9/EC+
	Xg+uAWT8OkvscAAzcTX3A==
X-Received: by 2002:a17:906:478d:b0:c29:f0a4:a4f8 with SMTP id a640c23a62f3a-c2e233cd0bbmr149280466b.0.1790781797242;
        Wed, 30 Sep 2026 08:23:17 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31ce6499sm23874966b.33.2026.09.30.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:23:16 -0700 (PDT)
From: hengyul@cs.unc.edu
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hengyu Liang <hengyul@cs.unc.edu>
Subject: [PATCH net 2/2] selftests: net: fib_tests: add tests for IPv6 routes via loopback device
Date: Wed, 30 Sep 2026 11:22:29 -0400
Message-ID: <20260930152229.1453929-3-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930152229.1453929-1-hengyul@cs.unc.edu>
References: <20260930152229.1453929-1-hengyul@cs.unc.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengyu Liang <hengyul@cs.unc.edu>

Check that an IPv6 route via the loopback device can be added when the
loopback device is down, when a gateway is specified, including an
IPv4-mapped one, and when IPv6 is disabled on the loopback device. Such
routes are promoted to reject routes, so their nexthop is not validated.

Without the previous patch:

  # ./fib_tests.sh -t ipv6_route_lo

  IPv6 routes via loopback device tests
      TEST: Route via loopback device that is down              [FAIL]
      TEST: Route via loopback device with gateway              [FAIL]
      TEST: Route via loopback device with IPv4-mapped gateway  [FAIL]
      TEST: Route via loopback device with IPv6 disabled        [FAIL]

  Tests passed:   0
  Tests failed:   4

With the previous patch:

  # ./fib_tests.sh -t ipv6_route_lo

  IPv6 routes via loopback device tests
      TEST: Route via loopback device that is down              [ OK ]
      TEST: Route via loopback device with gateway              [ OK ]
      TEST: Route via loopback device with IPv4-mapped gateway  [ OK ]
      TEST: Route via loopback device with IPv6 disabled        [ OK ]

  Tests passed:   4
  Tests failed:   0

Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 tools/testing/selftests/net/fib_tests.sh | 31 +++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index b338bfb196a2..19e55a8630a2 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -14,7 +14,7 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
        ipv4_mpath_balance_preferred ipv4_mpath_oif ipv4_mpath_oif_nh \
        ipv4_mpath_oif_vrf ipv6_mpath_oif ipv6_mpath_oif_nh ipv6_mpath_oif_vrf \
-       fib6_ra_to_static fib6_temp_addr_renewal"
+       fib6_ra_to_static fib6_temp_addr_renewal ipv6_route_lo"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -2466,6 +2466,34 @@ ipv4_route_v6_gw_test()
 	route_cleanup
 }
 
+ipv6_route_lo_test()
+{
+	echo
+	echo "IPv6 routes via loopback device tests"
+
+	setup_ns ns1
+	IP="$(which ip) -netns $ns1"
+
+	# Routes via the loopback device are promoted to reject routes, so
+	# their nexthop is not validated.
+	run_cmd "$IP link set dev lo down"
+	run_cmd "$IP -6 ro add 2001:db8:101::/64 dev lo"
+	log_test $? 0 "Route via loopback device that is down"
+
+	run_cmd "$IP link set dev lo up"
+	run_cmd "$IP -6 ro add 2001:db8:102::/64 via 2001:db8:1::2 dev lo"
+	log_test $? 0 "Route via loopback device with gateway"
+
+	run_cmd "$IP -6 ro add 2001:db8:103::/64 via ::ffff:192.0.2.2 dev lo"
+	log_test $? 0 "Route via loopback device with IPv4-mapped gateway"
+
+	run_cmd "ip netns exec $ns1 sysctl -qw net.ipv6.conf.lo.disable_ipv6=1"
+	run_cmd "$IP -6 ro add 2001:db8:104::/64 dev lo"
+	log_test $? 0 "Route via loopback device with IPv6 disabled"
+
+	cleanup_ns "$ns1"
+}
+
 socat_check()
 {
 	if [ ! -x "$(command -v socat)" ]; then
@@ -3291,6 +3319,7 @@ do
 	ipv6_route_metrics)		ipv6_route_metrics_test;;
 	ipv4_route_metrics)		ipv4_route_metrics_test;;
 	ipv4_route_v6_gw)		ipv4_route_v6_gw_test;;
+	ipv6_route_lo)			ipv6_route_lo_test;;
 	ipv4_mangle)			ipv4_mangle_test;;
 	ipv6_mangle)			ipv6_mangle_test;;
 	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
-- 
2.53.0

