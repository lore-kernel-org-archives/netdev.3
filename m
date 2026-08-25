Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED33DD51D
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645891; cv=none; b=qblrXqouw8JkQXYIDOnqoLT+Me4mzc8vXzD2o0FpXrXpb+VLqTM7dG+EO8+oTycj4HEjYtCFopgzZULpOXl2f6QRVD5jMHRoKoWRZlyl69rZRZ1oMDqNVuCQEw28kYv3tuD2xS2crkT7XgRamprb5Dpe3OAXG5LuASOlpKVr4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645891; c=relaxed/simple;
	bh=74hYJU9tKgBECgZIocH+tgF9kNxduqXS/vlaXeVly/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ta0tlS5d6/mwi4sFV66xEvSyMF4VQjxAmKX7ceKcow0WeuH/dgwGGlng/L4JzSjDETodUoZB9y3HVRzluxqsUzx0db0cx3KsrDd9Oi3uHzEjjTUaSfjS62rwveFp+WvJy0HLr03REVXAfd/27Lok83jRNFIDQeQxxfVr7xP+Gsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Wq2j7wfF; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Wq2j7wfF"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52b3934af3fso48793111cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787645889; x=1788250689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zRsvL/a7RmIm5+NW0n8opbLtTlM8Z82pvRtrMLB8Wr4=;
        b=Wq2j7wfFhyQ7VL6CTZxy7nusYhJlfC8dmBB2hngfGgETWJ/11DSgSLqnLZBm6Ok5bq
         L/tumair1YNzpxR34Vqsc33n7ajRBFaXLWv4Ye4A05SQ/13rm3YJugxy2erB6EUb/Daw
         0VKMGcPyvwObI0FmkSX1Q6pTVXbTdWERlCvqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645889; x=1788250689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zRsvL/a7RmIm5+NW0n8opbLtTlM8Z82pvRtrMLB8Wr4=;
        b=nEEbLrK8RCR6Oo0b1mFBnQLl0NMCFhYJ01hLoGTgA3B6BHgSHKTdk+StHDkXlYqB7f
         qrimbY5xird8lXrTP8JnoiqaOaTi2k7SboacTksCBS1boKZ467hM2SeN7eCcBkN02M7u
         sNwyVAMNr2PxShnPQKTMZHt7BvkFnZ4ZFB2elKLkqNQl2ntpZ7rT9pR5/pxeuGcEkRQE
         Xvuf8LTqrCAs0oE9BFHiPx0VZxaP1gZ6VNCOa6QKiiv9BpL6wWq5cGdII8Ge07WGtu6q
         +fK7OoE5aEIBLRqcPeJNjHumf1SUWBpMm/vpRyTGjrTIU1l/gnJI37BKxbG0nVGK6Vsr
         h5ZQ==
X-Gm-Message-State: AFuF++lQZOvude9138pD+onX9i2gFkqtTzcXwRd3sbydIO8PaIXAHfxo
	t+KIUsheKis1w0AA+c9mD3H2ZVwCnx0ykn40COcJThVp6peTOjfI+PfzJaRUwhJ2V9rMaObJwm/
	m7eyGdg==
X-Gm-Gg: AR+sD12BaJN62PUUKJunGY4hbGWSvRYegNRs8TSD23R6v2Mb4JA/3XmsHO550CusvFU
	arhjqrg6GoUW1iSp+kNhVKJ1hiZhkyAPbKwyV5BJlmvVb2bcfh9aLnXIT8BUK/+HQW5n73edrMf
	rpZU4couEE+2mJEpTWpgT+eN5q8CUrfl0wZcQmTiHJzqUG4xHO5V1C7HOooxb5bRdpM9MV27nZI
	TpXV3Tu1aX/sRJBVZB8Po5j8t14EKGJGxEp9PYs6Ig+h3/EUA0fH4kD5DtHW5cVWUfANrbdVkA8
	YngBAFKf9aSJeh/VQS2IlcMyKJkelGvBKquzVlx51xQu+xhY/+oWB4hoPhImiRnG6u5R1oTN3k8
	U4F7UB8ASDlWOW1r8BBi3PsTAZbVHYLmZSNZUMF0O0r+3DdA/JiuXjGsByzTmEHpbCeLfbybyZ2
	zLTWbfC9we0Yf8hxEo1tamPTE/NasF55qvi9fA6fiAi5G1KRsJdk5/
X-Received: by 2002:a05:622a:3cc:b0:51c:22c5:daf5 with SMTP id d75a77b69052e-52e2f175c1amr51042421cf.38.1787645889381;
        Tue, 25 Aug 2026 01:18:09 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09975f5asm65387341cf.2.2026.08.25.01.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:18:08 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 2/2] selftests: tc-testing: add pfifo_fast ring size cap regression tests
Date: Tue, 25 Aug 2026 04:17:51 -0400
Message-Id: <20260825081751.134086-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825081751.134086-1-jhs@mojatatu.com>
References: <20260825081751.134086-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two test cases for the pfifo_fast ring size cap:

1. Init path: set txqueuelen to 100000000, attempt to attach pfifo_fast.
   On a fixed kernel the qdisc add is rejected with -ERANGE (exit code 2).
   On an unfixed kernel the allocation either succeeds or triggers OOM.

2. Resize path: attach pfifo_fast with default txqueuelen, then raise
   txqueuelen to 100000000. On a fixed kernel the resize is rejected
   with -ERANGE and txqueuelen rolls back to the original value (1000).
   On an unfixed kernel the ring is resized to the oversized value.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-tests/qdiscs/pfifo_fast.json           | 60 +++++++++++++++++--
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
index 30da27fe8806..46b54ae37a91 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
@@ -9,8 +9,7 @@
         "plugins": {
             "requires": "nsPlugin"
         },
-        "setup": [
-        ],
+        "setup": [],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast",
         "expExitCode": "0",
         "verifyCmd": "$TC qdisc show dev $DUMMY",
@@ -30,8 +29,7 @@
         "plugins": {
             "requires": "nsPlugin"
         },
-        "setup": [
-        ],
+        "setup": [],
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast",
         "expExitCode": "0",
         "verifyCmd": "$TC -s qdisc show dev $DUMMY",
@@ -81,8 +79,7 @@
         "verifyCmd": "$TC qdisc show dev $DUMMY",
         "matchPattern": "qdisc pfifo_fast 1: root refcnt [0-9]+ bands 3 priomap",
         "matchCount": "0",
-        "teardown": [
-        ]
+        "teardown": []
     },
     {
         "id": "4385",
@@ -105,5 +102,56 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "7d12",
+        "name": "Reject pfifo_fast init with tx_queue_len exceeding S16_MAX",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY txqueuelen 100000000"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc pfifo_fast 1: root",
+        "matchCount": "0",
+        "teardown": [
+            "$IP link set dev $DUMMY txqueuelen 1000",
+            [
+                "$TC qdisc del dev $DUMMY handle 1: root",
+                0,
+                1,
+                2,
+                255
+            ]
+        ]
+    },
+    {
+        "id": "d09b",
+        "name": "Reject pfifo_fast resize when tx_queue_len exceeds S16_MAX",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast"
+        ],
+        "cmdUnderTest": "$IP link set dev $DUMMY txqueuelen 100000000",
+        "expExitCode": "2",
+        "verifyCmd": "$IP link show dev $DUMMY",
+        "matchPattern": "qlen 1000$",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.43.0

