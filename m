Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D04A483C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868740; cv=none; b=ZSEzInH+J26S/lNNAol2T7FlegEykMLJYGohpdilyILTg+maPtTIjgIyYA4dH0MM3FYboun8NN4Id7SlRP8QQNjj7em3WCLZObSGFRINQPDpqHpCytmxtM1FUTJ1JQP3OpNx20gv8YA6338TPqqgpLykEt2dN24OATrfPxigP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868740; c=relaxed/simple;
	bh=0NgJKro7+ay3ell043opk96SgIkwp3rFoIESVDypmpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNQ+225u+YZrb6uYnkpFlLkJkqNkO5JqVRK1wCQbe3StezH7AU+w9BO0NG89O9HTzm65ZVJq0YBN7jFcVfLyVPO8br9pd/r2bJM6tPqDYjJZsdgQHy3xtSHnCj0n9C+UDh5qKyRJvu1lrov7VfAwuIshjXwp4lJNdl5tJgsmW2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=tCbVGoZF; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="tCbVGoZF"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8ac8c533385so16914667b3.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790868738; x=1791473538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBC9cR5YJ0lwccbst7C+J0UlZRe88Kg57VsGwd5ApQ0=;
        b=tCbVGoZFhxw0i3BW11gScSjXACxmzEjHSGzL962muHULDreHtpAiSjZP1kDD3Y0Jpi
         4pv3z5J79xla5/twCrHpMHHvr9Unb5mnGFeufM0qw6SBjWJpAIfBjjFCMkJSf7v9u8l5
         vogOcFLmeL4R5u5dYkaLrX5fAHcgo0SjqABJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790868738; x=1791473538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XBC9cR5YJ0lwccbst7C+J0UlZRe88Kg57VsGwd5ApQ0=;
        b=Iq9fwjP1JPiAAq87zSjt6NXz224f0dsuARtP+4tW5LxS2bfwTUCsC5xH1G1xEebQMZ
         A2RSKD1ZNB+Fid5E4U1KdAyfvV7+qRYhjd0CF84N053yNesvSWcyL9zKJRmq5v68V3/k
         O3fL1KWEJ1+Fry/OFvpJgiGrKxYTlp62FBJJGbsWtcPGZTfBfU/OzcP17POLfztFuYIx
         kRhGvxdpWk9Bme0U4P60BdoxJR8vf/70HaSap6JbxnkvWmkadCfpyuXC+tn8wQp4iH/2
         gMAplOiRw6wDwWG+JYRcLFlhZ7IJ2zxURsFLfmpu/yBEhuMJeJJNTVqAyvUSwdI8nubI
         SXxA==
X-Forwarded-Encrypted: i=1; AKwUvBxUUt98yQs+jFn+KhNLgoH1WB6yt92+q4wB0lobGBSqiouSTL0SAfdUhC+tHcuGb4DKAKdmr9g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzAifr9Nfm3ry8p5qRjBRZF8UyXXtABsKCAieWow7I+jo+9E6q
	fh7yxRV/C8aIHo1jI9l9Vn4G5VI4vvNJK1GuqzqH4eKm3C7AsydLHuz/7l9qjFnIug==
X-Gm-Gg: AYBFou3cf6BAEQTuwX6Zad57bzCn7HdEUfwqZrauUPWGd35bKY1nBzG6SiGoZHZulct
	+pyEb75mxsxevY6NlzUnqZX+G9jI5/5/v2XqiCzLI5+ktYhmsgwSz4YFZUSFZwNOXxvPLK8iBls
	rBrH6MXNN1/F1L7etUhKyD96lI68jIi2BOD/u1rxRXarFBxuEPmdjwor3pF+Hp9pYlx5vKjylHV
	HsA04kUjjIFs5ATWRWo3D9OLNYBPDuat5NYoOESXilyaftkE+IFUYs+3oQc3MGw1kAQZk2m14EL
	akmtHJC+udajNX8Md5lj4cKjhGJnocSPXmtbT608hOr+lH5VnzjRh2ElD57T5OjOjgteSWcoIfO
	N+oBuIt+8hVZ7Jx8Zq6YBWqHIXi3wZ/SvofiUO0AqxLBh7Qh1qxhFvBHFGrJYtE9E1Ne6Tgu4C0
	lwhsAM2GskVcBWipzYyxuKW4ND6BnWS3QXjxYIVSmxRg5vPUW62zT6a9mqgPekGhHUOWGssQdaM
	AqwphTRq+WJBSA=
X-Received: by 2002:a05:690c:d84:b0:884:c81e:f868 with SMTP id 00721157ae682-8ac9321e144mr28272647b3.13.1790868738199;
        Thu, 01 Oct 2026 08:32:18 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8acdad046b1sm12059277b3.30.2026.10.01.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:32:17 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/2] selftests: tc-testing: add cls_route no-routing-attribute change tests
Date: Thu,  1 Oct 2026 12:32:01 -0300
Message-ID: <QDISC-0JB3.v1.20260923100921@mojatatu.com.2>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <QDISC-0JB3.v1.20260929143022@mojatatu.com>
References: <QDISC-0JB3.v1.20260929143022@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a boundary pair for route4 change without a routing attribute:

- a classid-only change of a wildcard filter (handle 0xffff8000) is a
  metadata-only update and must succeed;
- the same change on a non-wildcard handle (0x10001) would rekey the
  filter to the wildcard bucket, leaving the handle userspace stored stale,
  and must be rejected with -EINVAL.

The change of a wildcard filter is the flow iproute2 uses by default
("tc filter add ... route classid X:Y" gives handle 0xffff8000).

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/route.json    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
index 2d5843aebd72..c3b6ff157d3e 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
@@ -412,5 +412,51 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
         ]
+    },
+    {
+        "id": "4000",
+        "name": "Change a wildcard route filter classid only (no routing attribute)",
+        "category": [
+            "filter",
+            "route"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 100 route classid 1:1"
+        ],
+        "cmdUnderTest": "$TC filter change dev $DEV1 parent ffff: protocol ip prio 100 route classid 1:9",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter ls dev $DEV1 parent ffff:",
+        "matchPattern": "fh 0xffff8000 flowid 1:9",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "907a",
+        "name": "Try to change a route filter with no routing attribute and a non-wildcard handle",
+        "category": [
+            "filter",
+            "route"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 100 route from 1 to 1 classid 1:1"
+        ],
+        "cmdUnderTest": "$TC filter change dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10001 route classid 1:2",
+        "expExitCode": "2",
+        "verifyCmd": "$TC filter ls dev $DEV1 parent ffff:",
+        "matchPattern": "fh 0x00010001 flowid 1:1 to 1 from 1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
     }
 ]
-- 
2.43.0

