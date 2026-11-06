Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947331;
	b=wnG/s6Ch1ch98rOvCjbzy6seDZAWOCKyPeIxPi0HheKUNbD04hiyo7BPPRsKDHCslLQ5
	 jiaAAeZr7OHBb1EXfb3+hRfJbgXmVqpcz0g8KEq28pmS4SLs0QV9WPL6zaBfySNf+/O31
	 bvqjwvqNuGzOrcN6OV1nIsYJUA09+uPbuDPiJLO9an5j33BbwRaGaMV3ICrGcC0hiC96e
	 NBoChhCuv0zT57dript9e8Aubu0KyFN6ZlRv6k70d8nCG5UXSVV8SZw5oZueZvjhzwzJ9
	 ykGEdJQeJCwGtt7A49WPotwXtqOLS3bmYmST2fJQpubyxS+xyh6qI5R89fUUqP1Sikg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947331;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=0bUMKH9d0uJfnXeq5eKB6jEiDxTQUE7bE1foO+3EmWM=;
	b=QEPGovWYBvkra2wDsviS59jSBMkcTeQ22KAYIBtuy1CWWBHpWvBYqFHiGpoDrYQ7iEhW
	 0q63WmdSkuCfKmCbYC6Oaus2HOTB77FwZZUtTFw8jr27Y5HeWJIBlBls0IJh2eRrrIite
	 qmIyD0JrVTBIZTb53tTB/2Ym9p1gn1ifDP62ge1JqGYE7IdkCRNM8bCukz6vE4OZKnhjz
	 iQ7tsU3rM6aieTIXxgfFSl/Xb5HrYvQfmWGuoUNrWEggOhbsLjHZN9BFHPYGA9wxLfyQh
	 PTcLwbiRLWyZwu1lwPDUYKbUC5mihkQWl7yToY9PigOnAbHjTYycefmYLALWNSJKY4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=mghFzSbn;
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A0606A33B;
	Fri,  6 Nov 2026 06:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F1A0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=mghFzSbn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0b
	UMKH9d0uJfnXeq5eKB6jEiDxTQUE7bE1foO+3EmWM=; b=mghFzSbnoNlsdG8RNe
	XIydCP3Dx2KP8tXBKzzyI43XCX0+mRWfJgP9IlErvNRb+NU6UaNNrtu6s6UGphFr
	82AFzZL608UdUDxueycuFFgsvnWgbJ4tUOq5xxwufCKtozdpnoN2G7nKIvOCzdHZ
	LStG2AuN6umz4scWX2lyT9X1c=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnR+uMdu1qZ7kzCw--.3170S5;
	Fri, 06 Nov 2026 14:41:23 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net-next 3/3] selftests: tc-testing: add gact probability dump tests
Date: Fri,  6 Nov 2026 14:41:14 +0800
Message-Id: <20261106064114.3592670-4-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261106064114.3592670-1-xiaolinkui@126.com>
References: <20261106064114.3592670-1-xiaolinkui@126.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnR+uMdu1qZ7kzCw--.3170S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4ruF1Dury3tF1xAryfXrb_yoWrXF4rpr
	ySyF1Yyrn8tr97Aw1UurWrXF4a93WkCw4UJry5JrW7u3WUKa4ktFZ7tF4Iva4jyrZYvw43
	ZFn093Z7ZrZrA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQa9fUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRPXrmrtdpN4mgAA3D

From: Linkui Xiao <xiaolinkui@kylinos.cn>

gact probability attributes are emitted by tcf_gact_dump() only when
tcfg_ptype is set, and budgeted for by tcf_gact_get_fill_size().  The
only gact cases that look at a probability today are 8e47 and ca89, and
both check it through `tc actions list`, which is served by the netlink
dump machinery and never consumes the get_fill_size() budget.  The one
case that uses `tc actions get`, 525f, runs against an action with no
probability, so the RTM_GETACTION reply path -- tcf_get_notify(), which
does size its skb from get_fill_size() -- is never exercised with a
probability, and the netrand random type is not exercised anywhere.

Add three cases: adding an action with a netrand probability and getting
it back; replacing a probability-less action with a deterministic one
and getting it back, covering the tcfg_ptype 0 -> non-zero transition
that the unconditional TCA_GACT_PROB budget in patch 1 has to cover; and
getting a probability-less action, whose dump must report no probability.

These are coverage for the dump and sizing paths that nothing tested
before, not reproducers: RTM_NEWACTION, RTM_DELACTION and RTM_GETACTION
all take
rtnl, so sizing and dumping always run in the same critical section
and a replace cannot interleave between them from userspace.  They pass
both before and after patches 1 and 2.

Verified by running the tdc gact suite (38 cases, including these
three) against a kernel with CONFIG_GACT_PROB=y and this series
applied; all passed.

Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 tools/testing/selftests/tc-testing/tc-tests/actions/gact.json | 83 +++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/gact.json b/tools/testing/selftests/tc-testing/tc-tests/actions/gact.json
index 0fcd52742939..94f032aeab68 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/gact.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/gact.json
@@ -761,5 +761,88 @@
                 1
             ]
         ]
+    },
+    {
+        "id": "b4f8",
+        "name": "Add gact action with random netrand and get it",
+        "category": [
+            "actions",
+            "gact"
+        ],
+        "plugins": {
+           "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action pass random netrand drop 20 index 91",
+        "expExitCode": "0",
+        "verifyCmd": "$TC actions get action gact index 91",
+        "matchPattern": "action order [0-9]*: gact action pass.*random type netrand drop val 20.*index 91 ref",
+        "matchCount": "1",
+        "teardown": [
+            "$TC actions flush action gact"
+        ]
+    },
+    {
+        "id": "e3d7",
+        "name": "Replace gact action without probability with random determ and get it",
+        "category": [
+            "actions",
+            "gact"
+        ],
+        "plugins": {
+           "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            "$TC actions add action pass index 92"
+        ],
+        "cmdUnderTest": "$TC actions replace action pass random determ drop 5 index 92",
+        "expExitCode": "0",
+        "verifyCmd": "$TC actions get action gact index 92",
+        "matchPattern": "action order [0-9]*: gact action pass.*random type determ drop val 5.*index 92 ref",
+        "matchCount": "1",
+        "teardown": [
+            "$TC actions flush action gact"
+        ]
+    },
+    {
+        "id": "c2a9",
+        "name": "Get gact action without probability",
+        "category": [
+            "actions",
+            "gact"
+        ],
+        "plugins": {
+           "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            "$TC actions add action pass index 93"
+        ],
+        "cmdUnderTest": "$TC actions get action gact index 93",
+        "expExitCode": "0",
+        "verifyCmd": "$TC actions get action gact index 93",
+        "matchPattern": "action order [0-9]*: gact action pass.*random type none.*index 93 ref",
+        "matchCount": "1",
+        "teardown": [
+            "$TC actions flush action gact"
+        ]
     }
 ]
-- 
2.25.1

