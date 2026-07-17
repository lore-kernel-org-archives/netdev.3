Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CE6222590
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270741; cv=none; b=SBYHYtBJUNZ4MlaWJ43EzLdIeYg8Ij3wb9hARKA7T8QFQ+9ufMnALqloway+6gb9kRf+BZVLzF/O841mi663zkzjy1CTtNHHuS1wGzizfNNxEOgDJTnnC9naJj4XnLEPCAYak73QVff0205Lpy/MJBeAM/LjPuHen7Ne1p0BpKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270741; c=relaxed/simple;
	bh=HdvJD6U6AZT6Gc6eIdmqO8NWS6WyZ9Y0FP6mOZhzD9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FG3fT5gtHTtK5pA59vpy4yo4j5dlcC6SvZbXW4B2pQmHjKMgE6jDh5TSqh5vreIFINIJ/y2FFz8fED5KlMCHx+0u1vFqtIFcsJtzRmKkY5Q6Q7a6QbYgAvY2wJAtN/f1FdiYW7yskRy6aDrH9NeYPCQUdmzvSmn/SBp1nCc9xFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f71XFf2t; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f71XFf2t"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848743155bcso1763447b3a.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784270727; x=1784875527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGbSiO1fqjnyGYh3XrxntYuCZ2sL4D2PCmE496WiS64=;
        b=f71XFf2t7nqW8Z2MfoaHPt6xScs4fXalTUfbqzfs0pUR/GslY8CO7Do3+vj3CECnUp
         yyy0PNwdbMUEnblkj0ldatz0q/ECfBIwUF/kDHzRQETrzHem2Yht9donVdRg+is5K+fv
         yZPvctV/CE94ceGzA/XF19gkITVdZKd5VcZUvvqrunD4rBo9qHJtnLDk+WCVGmHUBMkT
         3S7GrE/7u6FB3FbR6ZxTdROQL2er01gaqjJJFMOHQpbCMBNp1cO3OJpvHg0Bxev6QiPZ
         7EFO6/tnmpKsTmy0kSVE/+z+pqqoRz+1Zf1EU296xPmUI2rTNU539gGBHciG/EQk3dlV
         pYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784270727; x=1784875527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGbSiO1fqjnyGYh3XrxntYuCZ2sL4D2PCmE496WiS64=;
        b=LNB1j6KQQ+27ZVMks89ckl8FwcUDedWMJrTe13haOxXBe8PAtD1oAF3BCumBstWJ7p
         /gf7Jazy8x6+N7ApsT/MMcgAkWFMuGurzhqknza1Wukfgeecp8Z+Z00Ubow2n6+W5RX8
         Js7woikRsAhi8geo2mZgclTS9soUEd/Nq2BIKFNzkyY/vhCYQEjqmTdhxqDoKf1XkV6o
         3/IC6MqsIY9kavvCaz/NEuzZ8XbgDIf8BYu9p2e4kxLz41Vf2XuUXevCR5fSN6lCk3Nl
         mAfpL8pzzMr3qAa+iVDOBtTYKouZzf0sfCCSf4AkPRH59jcy1ASqJFGxIcDmLCVcCiVT
         P6ZQ==
X-Gm-Message-State: AOJu0Ywy/UvF6zvsuZsUuf65PHMa5my3Ks3T318eGComhdXhgIukoGMO
	E5h5UY/oSVluuMxtYltzrLzHfpNTQ+MoB9c8MyXIi8DNepOJfc9Kdrjw
X-Gm-Gg: AfdE7cl+HIwBOffO0zT4MSwImd3al5HH6u+OoLW1ArmXZ+OvMrp88NEHkY8yxdVYt99
	R0dKS9p8VeB8Bv2TjD+S0WLL1IGp8EUwm8LVJacFUNumMMvDvV8BmSTAqQnDLCohVkkmK+Ep1J+
	yjnaOQu14roopjPs5+gjnGfOyVRIiDe75L+aDaicmxoRptCdfP07FO05SEbrDsUAaekhztE4ZEs
	uhr5tauwo2P1C+HmzwM9mGPYfUAM1ICVo6+NIYHhuvVgpodJ6q0TKLYkndVMHpUSbjRiC9gJ0vL
	+llQW9GG7WWiXYIsVFdhE4+1+vRjwiz5WiamBh1kPKW/z08zc/UC6eb8Xg6BTbKmpdfzaSsTqi7
	nfoPktzZ7BMo12MLkQtEzsH4UQxS9Upr5KWO4WeIIWw8s210Md6gAHDXA6S5BgciAoDSIFlb/Td
	+Bf+iSpq6s3ojEzHw=
X-Received: by 2002:a05:6a00:288d:b0:848:2f74:1d60 with SMTP id d2e1a72fcca58-84c295777f6mr1268231b3a.70.1784270727152;
        Thu, 16 Jul 2026 23:45:27 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.localdomain ([70.37.26.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad8855fsm430531b3a.12.2026.07.16.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:45:26 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
Date: Fri, 17 Jul 2026 06:45:18 +0000
Subject: [PATCH net-next v2 3/3] selftests: net: add coverage for fdb
 nexthop dst port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-b4-vxlan-fdb-port-v2-3-f4862e8fe867@gmail.com>
References: <20260717-b4-vxlan-fdb-port-v2-0-f4862e8fe867@gmail.com>
In-Reply-To: <20260717-b4-vxlan-fdb-port-v2-0-f4862e8fe867@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jack Ma <jack4it@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784270724; l=3980;
 i=jack4it@gmail.com; s=20260712; h=from:subject:message-id;
 bh=HdvJD6U6AZT6Gc6eIdmqO8NWS6WyZ9Y0FP6mOZhzD9U=;
 b=zTZ/Uv5pit4FneIuseQM7CSf9cLsOW0uZli7xlhMP+qPfwOTzIq14VeQVsZJ05ocdBWmd1msK
 qpX3YjJCLG/C6HsF4sSmqvFm8jgfBNo/sFhQ+gsPFimTtTWYPYov/yA
X-Developer-Key: i=jack4it@gmail.com; a=ed25519;
 pk=x8xh2Md9yNDil0xBOA9WA/oqC3O4Eg4rdlIul4YUktU=

Add fib_nexthops_fdb_port.sh, which exercises the NHA_FDB_PORT rules:
accept a port on an fdb nexthop that has a gateway and echo it back on
dump, reject it on non-fdb or gateway-less nexthops, allow a group whose
legs differ only in UDP port, and confirm a portless fdb nexthop omits
the attribute.  The test SKIPs cleanly on kernels or iproute2 without
NHA_FDB_PORT support.

Signed-off-by: Jack Ma <jack4it@gmail.com>
---
 tools/testing/selftests/net/Makefile               |  1 +
 .../testing/selftests/net/fib_nexthops_fdb_port.sh | 78 ++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 708d960ae..c06eb4927 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -36,6 +36,7 @@ TEST_PROGS := \
 	fib_nexthop_multiprefix.sh \
 	fib_nexthop_nongw.sh \
 	fib_nexthops.sh \
+	fib_nexthops_fdb_port.sh \
 	fib_rule_tests.sh \
 	fib_tests.sh \
 	fin_ack_lat.sh \
diff --git a/tools/testing/selftests/net/fib_nexthops_fdb_port.sh b/tools/testing/selftests/net/fib_nexthops_fdb_port.sh
new file mode 100755
index 000000000..8b401c6d2
--- /dev/null
+++ b/tools/testing/selftests/net/fib_nexthops_fdb_port.sh
@@ -0,0 +1,78 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Control-plane selftest for per-nexthop VXLAN fdb destination port
+# (NHA_FDB_PORT).  Verifies the accept/reject rules and the dump roundtrip.
+# No datapath traffic here -- see tests/integ/vxlan-fdb-port-integ.sh for the
+# real forwarding test.
+#
+# Requires: patched kernel (NHA_FDB_PORT) and patched iproute2 (the "port"
+# keyword on "ip nexthop ... fdb").  SKIPs cleanly otherwise.
+
+set -u
+
+ksft_skip=4
+NS="nhfdbport-$$"
+IP="ip -netns $NS"
+ret=0
+
+log_test() {	# $1 actual_rc  $2 expected_rc  $3 name
+	if [ "$1" = "$2" ]; then
+		printf "TEST: %-58s [ OK ]\n" "$3"
+	else
+		printf "TEST: %-58s [FAIL] (rc=$1 want=$2)\n" "$3"
+		ret=1
+	fi
+}
+
+# passes (returns 0) iff the command FAILS
+expect_fail() {
+	if "$@" >/dev/null 2>&1; then return 1; else return 0; fi
+}
+
+cleanup() { ip netns del "$NS" 2>/dev/null; }
+
+command -v ip >/dev/null 2>&1 || { echo "SKIP: iproute2 not found"; exit $ksft_skip; }
+ip nexthop help 2>&1 | grep -q fdb || { echo "SKIP: no fdb nexthop support"; exit $ksft_skip; }
+
+trap cleanup EXIT
+cleanup
+ip netns add "$NS" || { echo "SKIP: cannot create netns"; exit $ksft_skip; }
+$IP link set lo up
+
+# Probe for "port" keyword + kernel NHA_FDB_PORT support; SKIP if missing.
+if ! $IP nexthop add id 1 via 10.0.0.1 fdb port 4790 2>/dev/null; then
+	echo "SKIP: 'ip nexthop ... fdb port' unsupported (needs patched kernel + iproute2)"
+	exit $ksft_skip
+fi
+log_test 0 0 "add fdb nexthop with port"
+
+# Dump roundtrip must echo the port back.
+$IP nexthop show id 1 | grep -qw "port 4790"
+log_test $? 0 "dump shows fdb port 4790"
+
+# Reject: port on a routed (non-fdb) nexthop.
+expect_fail $IP nexthop add id 2 via 10.0.0.1 dev lo port 4790
+log_test $? 0 "reject port on non-fdb nexthop"
+
+# Reject: fdb port without a gateway.
+expect_fail $IP nexthop add id 3 fdb port 4790
+log_test $? 0 "reject fdb port without gateway"
+
+# The HA case: a group whose legs share the gateway but differ in port.
+$IP nexthop add id 10 via 10.0.0.1 fdb port 4789 && \
+$IP nexthop add id 11 via 10.0.0.1 fdb port 5789 && \
+$IP nexthop add id 100 group 10/11 fdb
+log_test $? 0 "add fdb nexthop group with differing ports"
+
+# A fdb nexthop without a port must NOT emit one (backward compat).
+$IP nexthop add id 20 via 10.0.0.1 fdb
+$IP nexthop show id 20 | grep -qw "port"
+log_test $? 1 "fdb nexthop without port omits NHA_FDB_PORT"
+
+if [ $ret -eq 0 ]; then
+	echo "PASS: all NHA_FDB_PORT control-plane checks"
+else
+	echo "FAIL: one or more NHA_FDB_PORT checks failed"
+fi
+exit $ret

-- 
2.43.0

