Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5052DF12F
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172166; cv=none; b=pWTx863eC5afReBfnboGBBFJJByaUptLr4r/SdE1+TRK+rU1E6MnKk3SYfvw+VCZUSyei3hweeZyShyl6dc0gqITjDx8gJIQCXYmGvB24OflG9OwCBHoeQ9D4IbXU+/eNzW3kE9slESN63Ljh8SNKOOQODIlVSJ4JtoU52KBwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172166; c=relaxed/simple;
	bh=847c3FhB0l8jTGcdvSxeyKniGUpxlU7Seo4UhuXPz9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZuamEVp/pIUwXY4KpsKWg/PQqKT5NO0/0hgdJTq5vCGgE26MRNSxg32PrpK4Z8aR9IDsXweRMEqpaiavwO247yoM+yBMLR5Tyd3rQDvq4ETBIDr7/R0b74Ba2Lqr6rfCS+QwXy2YQt7llyiXAE7wtbiQPk4rJjQKDEJ/gPhgm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3C7E86035B; Wed, 19 Aug 2026 22:42:43 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net 3/4] selftests: tc-testing: add act_ct test for ct reset handling
Date: Wed, 19 Aug 2026 22:42:09 +0200
Message-ID: <20260819204210.23722-4-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819204210.23722-1-fw@strlen.de>
References: <20260819204210.23722-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that skb->nfct is re-set when pedit munges network or transport
header data, else we feed packets to stack where skb might carry
different or invalid headers compared to what conntrack input has
validated earlier.

Also check MAC modifications keep the ct entry as-is.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../tc-testing/tc-tests/actions/ct.json       | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json b/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json
index 8ab48def89b6..18a773748358 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/ct.json
@@ -742,5 +742,173 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 clsact"
         ]
+    },
+    {
+        "id": "c2a9",
+        "name": "Verify conntrack reset after pedit modifies IP protocol",
+        "category": [
+            "actions",
+            "ct",
+            "pedit",
+            "scapy"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            [
+                "$TC qdisc del dev $DEV1 ingress",
+                0,
+                1,
+                2,
+                255
+            ],
+            "iptables -t raw -F",
+            "iptables -t raw -A PREROUTING -i $DEV1 -p icmp -m conntrack --ctstate INVALID -j DROP",
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip prio 1 flower action ct commit pipe action pedit ex munge ip protocol set 1 pipe action csum ip4h continue",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 1,
+            "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20',proto=6)/TCP(sport=1234,dport=80,flags='S')"
+        },
+        "expExitCode": "0",
+        "verifyCmd": "iptables-save -c -t raw | grep 'ctstate INVALID'",
+        "matchPattern": "^\\[1:40\\]",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress",
+            "iptables -t raw -F"
+        ]
+    },
+    {
+        "id": "d3b8",
+        "name": "Verify conntrack reset after TCP port modification",
+        "category": [
+            "actions",
+            "ct",
+            "pedit",
+            "scapy"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            [
+                "$TC qdisc del dev $DEV1 ingress",
+                0,
+                1,
+                2,
+                255
+            ],
+            "iptables -t raw -F",
+            "iptables -t raw -A PREROUTING -i $DEV1 -p tcp -m conntrack --ctstate INVALID -j DROP",
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip prio 1 flower ip_proto tcp action ct commit pipe action pedit ex munge tcp sport set 9999 pipe",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 1,
+            "packet": "Ether(type=0x800)/IP(src='10.0.0.10',dst='10.0.0.20')/TCP(sport=1234,dport=80,flags='S')"
+        },
+        "expExitCode": "0",
+        "verifyCmd": "iptables-save -c -t raw | grep 'ctstate INVALID'",
+        "matchCount": "1",
+        "matchPattern": "^\\[1:40\\]",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress",
+            "iptables -t raw -F"
+        ]
+    },
+    {
+        "id": "a1b2",
+        "name": "Verify conntrack NOT reset when pedit modifies only MAC",
+        "category": [
+            "actions",
+            "ct",
+            "pedit",
+            "scapy"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            [
+                "$TC qdisc del dev $DEV1 ingress",
+                0,
+                1,
+                2,
+                255
+            ],
+            "iptables -t raw -F",
+            "iptables -t raw -A PREROUTING -i $DEV1 -p icmp -m conntrack --ctstate NEW -j DROP",
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip prio 1 flower action ct commit pipe action pedit ex munge eth src set 11:22:33:44:55:66 pipe",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 1,
+            "packet": "Ether(src='aa:bb:cc:dd:ee:ff',type=0x800)/IP(src='10.0.0.11',dst='10.0.0.21')/ICMP()"
+        },
+        "expExitCode": "0",
+        "verifyCmd": "iptables-save -c -t raw | grep 'ctstate NEW'",
+        "matchPattern": "^\\[1:28\\]",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress",
+            "iptables -t raw -F"
+        ]
+    },
+    {
+        "id": "b7f4",
+        "name": "Verify conntrack reset when ETH write extends into IP layer",
+        "category": [
+            "actions",
+            "ct",
+            "pedit",
+            "scapy"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            [
+                "$TC qdisc del dev $DEV1 ingress",
+                0,
+                1,
+                2,
+                255
+            ],
+            "iptables -t raw -F",
+            "iptables -t raw -A PREROUTING -i $DEV1 -m conntrack --ctstate INVALID -j DROP",
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip prio 1 flower action ct commit pipe action pedit ex munge offset 12 u32 set 0x08004500 pipe csum ip4h continue",
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 1,
+            "packet": "Ether(type=0x800)/IP(src='10.0.0.13',dst='10.0.0.23')/ICMP()"
+        },
+        "expExitCode": "0",
+        "verifyCmd": "iptables-save -t raw -c | grep 'ctstate INVALID'",
+        "matchPattern": "^\\[1:28\\]",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress",
+            "iptables -t raw -F"
+        ]
     }
 ]
-- 
2.54.0

