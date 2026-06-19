Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8B18B0A
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854349; cv=none; b=K1whgFUIK3ZA6NgjWyehpe+I9X4c1S5yDUGLLZYpH7YtYprSV0XFMI1cLDQsnHOZiYFQvM95W8R+0qqxc3hQ9aOVeeLh3IVaXMlRnnsxGrkchWBTKvXxt0nW0X2PB9BWSNT43MV2R5JGnDPNH3+LhGMlhEB5iH1ZdZCsQmKPV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854349; c=relaxed/simple;
	bh=gC6rE+j5K/xrhgUSSLb8kAPiL4LVtnMAtpCxQRU0bpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp7Ec63CFeBwBsdw4lt9FGjKyqNgqu0eTa8lV5AZQqCWQFHL0wcIk9VQkE+2mqY7sGnxAUUrJiZvv6Y7olwWd0cgrV8IwVeWyuTZfFjI4zEUtNlVHFFLHHtrBp5RdOYXaMn6KpbHomfERcHVPhvPDTe50S/3DrceXjddn/fZeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=lGB8+Le3; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="lGB8+Le3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1781854346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBNHTKP/8oD1NV2fylK17AcfrBEDQlRz5wursCKcRFw=;
	b=lGB8+Le3bz1vm7q+emB1np8wbMLEQr5tZkBzNHcKDG7e42TbqT4yK+ZTxfyUbdKQowC++B
	cmxCsO4jLJuKg97nqlXkxJn0RtdOHNIZQJnVmYkD6t3l1QmdSap+eN8q3Wrm4RYHqa3BN+
	/zqLyDQonAnrGk3QHlRrbQYihCl8492865ymWvKxAbYFoQ7wPPGAfGMhf0ih1egJpu1xne
	SDEkaVO1hG+5f9OoI0q4eXy38SfKnNWXMRHJTwFnvM7+FQDQHRKQn8G+RT7PE16hImmrHK
	PlpZSbWS5xux1whbUM94sc6+/1FpPnIc2I1Zaz08vABo/uGO6tJGBppB6Ul0jw==
From: Xingquan Liu <b1n@b1n.io>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Xingquan Liu <b1n@b1n.io>
Subject: [PATCH v2 2/2] selftests/tc-testing: Add DualPI2 GSO backlog accounting test
Date: Fri, 19 Jun 2026 03:31:44 -0400
Message-ID: <20260619073211.637928-2-b1n@b1n.io>
In-Reply-To: <20260619073211.637928-1-b1n@b1n.io>
References: <20260619073211.637928-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a regression test for DualPI2 GSO backlog accounting when it is
used as a child qdisc of QFQ.

The test sends one UDP GSO datagram through a QFQ class with DualPI2 as
the leaf qdisc. DualPI2 splits the skb into two segments. After the
traffic drains, both QFQ and DualPI2 must report zero backlog and zero
qlen.

On kernels with the broken accounting, QFQ can keep a stale non-zero
qlen after all real packets have been dequeued.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
index cd1f2ee8f354..ffd6fd5ba8f7 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
@@ -250,5 +250,49 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "891f",
+        "name": "Verify DualPI2 GSO backlog accounting with QFQ parent",
+        "category": [
+            "qdisc",
+            "dualpi2",
+            "qfq",
+            "gso"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 1 maxpkt 4096",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: dualpi2",
+            "$TC filter add dev $DUMMY parent 1: matchall classid 1:1"
+        ],
+        "cmdUnderTest": "python3 -c 'import socket,struct; SOL_UDP=getattr(socket,\"SOL_UDP\",socket.IPPROTO_UDP); UDP_SEGMENT=getattr(socket,\"UDP_SEGMENT\",103); s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); s.bind((\"10.10.10.10\",0)); p=b\"X\"*2400; n=s.sendmsg([p],[(SOL_UDP,UDP_SEGMENT,struct.pack(\"=H\",1200))],0,(\"10.10.10.1\",9000)); raise SystemExit(n != len(p))'",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY",
+        "matchJSON": [
+            {
+                "kind": "qfq",
+                "handle": "1:",
+                "packets": 2,
+                "backlog": 0,
+                "qlen": 0
+            },
+            {
+                "kind": "dualpi2",
+                "handle": "2:",
+                "packets": 2,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
Xingquan Liu

