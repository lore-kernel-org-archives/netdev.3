Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51785388898
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469002; cv=none; b=RMwHrKrm1eeSQLP6rxJFRCvdmHwdMUOVobZxehJ4Js8uW+DfiHu5n/239/luVt533rlcqNcCpsIG+A6NvyMBZDG+/JhymE3QmFuCDwsWxQT4WDeGVkxwqSTXOiqJG9D2gdK4la9zj2GZVpP+oFrEOopEUS68sdlZU5LRi/4b6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469002; c=relaxed/simple;
	bh=iMgmrmeBfySHY5ZM+ZW1tmd+ehN5fp061ezQDwEMvJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tcyfoi/zDsK5ZVk/2rx5wIoUQFySJIDeuyNdiaaDDkj985APyxj+o8ulNZOv+qtavxHIoHp/Oa5MTUDD036v+mQfFyw6d+dk7E1WMPu9YWnC7kx4aWVzaYossJr+rVGvu4mkZhs9XmRrTeDBY+8A3G6B5oDA1vKb3dJE+UX0Kms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=XQ4zXAT8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="XQ4zXAT8"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c0006ea8eso5195561cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788468983; x=1789073783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+nM61jMT2mQop3K/7RN9vY9A4c5ZEECZp4TTfH4j17E=;
        b=XQ4zXAT8prnzntKiMTY8QGpPuXGsKnMvZR9OUFODihaNakHaC/3nX5kCvzRGeNAgoE
         pxJb5J8um9jbjcaEK695br7DsnCRY7AF9QO845dyU5ytPWKLYWGD6JxHfeTrhe72OrIT
         udrKOSbdAIfwbrZtg969HB/XGVnsX0XUT7QR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788468983; x=1789073783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+nM61jMT2mQop3K/7RN9vY9A4c5ZEECZp4TTfH4j17E=;
        b=Tfd/u7dhteH92+ChTu/Hj3AJCDgvSkmu/s3i+vZ7stBF/dlE6jvW5yUZIjuKLs4K8A
         3gdhOiHIUwnfT04/RDle59Rnbc4T/zS4yFBlgRRLTPH6tcE4CncblBvQar2BlZkvsoI5
         TyieJtn2zmG6VBd37DHKJE3LBZdaKyU7wphf6Wn0iKfnDfbRt3DAulNQVIbDMz0KmFK5
         l0VlSSnxGw28BRcBH/fS4zJEwjdP+qhNd7C2y8wg4cv/B+CVeNp5GLgWweu6+4dyNe7T
         mZykKQbWC6tppK1o4Sc8NeRl1XDbHHCGOku/ZYuj1WyJj+05AUCfiZRnCQNR4gSuxupL
         L9Vg==
X-Gm-Message-State: AFuF++lcB7k9kq68nabcp/Cs5Kh1DQKlDuVp76QsDCl56rpQj+4O1oym
	QmU5Ezd995spa7N1su7asP8vO1Kye7Kxett6K9KaYX5WDPg6AIBLYLSQgnL8/gcltKblEvxFVjp
	46W9OpA==
X-Gm-Gg: AYBFou1SJ9xOA1beqUCmDHhHqdM5LT9iu5aYMKxVCMjG6vpGkHuea0wrm5iMD1k05s1
	JB9ftalSyGlgwSVH+5TLQV/S8sQ3B3OPat6j8x6WST/6UfOOdCxhiJd0nnxElc2WaeWFXWUH/9N
	bAAaheDa4B2B3AGK7gH++JebEdgwBMBkGu610Ae1Xbqeaniho46+ioHQZYJCTQw4Ru/XxDgXMAI
	ZSswPAPO6HW37i85H4SZeKZ/kIc1DLOCYOnDKlTuKmR9o9c+wpqTTI6m5bHfEVZtqG9SZiisWvv
	eU5PGOC4/FP3R6H+5XxMDWdamnmcpFdjF/worF2ofsQkKLFMJ8TR6v21OTILAyrp9EiOfZO1eES
	iByMVKkxXqTzSdg9aHEXJ5GVKdhG6M6wFctB97HuTym7+EKeEHTH+jYr1prMHxXI/gfYk3/Ieeu
	8vk8mhxRL+dD8Sk8Q/KNQJOOtgxNdWAuh8MfZViueHbTWo0a1BgVkAcd8N5Arzf4S50dy3UuOWk
	5W1onUKXf9KCSPfnmR7pmKsta5Af89OtNJXav8v416K2EljIBjIdeC8Cv7xYcLgCJ1y4FMM1Vt0
	SnIpiqPpOHZh
X-Received: by 2002:a05:622a:2592:b0:530:3554:6482 with SMTP id d75a77b69052e-530548511c0mr20675521cf.18.1788468983238;
        Thu, 03 Sep 2026 13:56:23 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305422fc07sm5509881cf.31.2026.09.03.13.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:56:22 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Shuah Khan <shuah@kernel.org>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 2/2] selftests/tc-testing: add codel/fq_codel interval boundary cases
Date: Thu,  3 Sep 2026 16:56:16 -0400
Message-Id: <QDISC-1L5H.v1.20260903184552@mojatatu.com.2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-1L5H.v1.20260903184552@mojatatu.com>
References: <QDISC-1L5H.v1.20260903184552@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tdc cases locking the codel/fq_codel small-interval uAPI after
the dropping-loop bound (previous patch): sub-tick and two-tick
intervals are ACCEPTED (the loop bound makes them safe), the
1024us boundary is accepted, and a sub-tick target sojourn delay is
accepted (it does not participate in the control law):

  codel:     6e44/a8c3/a695/9793 - interval 1us/3us/1024us and
             target 1us accepted (rendered 0us/2us/1.02ms/0us by tc)
  fq_codel:  1b4d/3540/49c5/3e0f - interval 1us/3us/1024us and
             target 1us accepted

The positive cases match the full rendered qdisc line (tc renders
interval 1us as 0us, 3us as 2us, 1024us as 1.02ms), mirroring the
existing tests in these files.

These cases do not test the dropping-loop bound itself: tdc cannot
observe per-dequeue drop counts. c797 (fq_codel target 1 interval 1)
passes unmodified on the patched kernel, which is the uAPI evidence
for the previous patch.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/codel.json     | 72 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq_codel.json  | 72 +++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json
index 6d515d0e5ed6..a894e6f0e267 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/codel.json
@@ -213,5 +213,77 @@
         "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1p target 5ms interval 100ms",
         "matchCount": "1",
         "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
+    },
+    {
+        "id": "6e44",
+        "name": "Create CODEL with 1us interval, accepted (sub-tick, uAPI locked)",
+        "category": [
+            "qdisc",
+            "codel"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root codel interval 1us",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1000p target 5ms interval 0us",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DUMMY handle 1: root"]
+    },
+    {
+        "id": "a8c3",
+        "name": "Create CODEL with 3us interval, accepted (two ticks)",
+        "category": [
+            "qdisc",
+            "codel"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root codel interval 3us",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1000p target 5ms interval 2us",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DUMMY handle 1: root"]
+    },
+    {
+        "id": "a695",
+        "name": "Create CODEL with 1024us interval boundary accepted",
+        "category": [
+            "qdisc",
+            "codel"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root codel interval 1024us",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1000p target 5ms interval 1.02ms",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DUMMY handle 1: root"]
+    },
+    {
+        "id": "9793",
+        "name": "Create CODEL with 1us target, accepted (target not in control law)",
+        "category": [
+            "qdisc",
+            "codel"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root codel target 1us",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc codel 1: root refcnt [0-9]+ limit 1000p target 0us interval 100ms",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DUMMY handle 1: root"]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json
index 4ce62b857fd7..de6a1b8d954a 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_codel.json
@@ -316,5 +316,77 @@
         "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 1p flows 1024 quantum.*target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64",
         "matchCount": "1",
         "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
+    },
+    {
+        "id": "1b4d",
+        "name": "Create FQ_CODEL with 1us interval, accepted (sub-tick, uAPI locked)",
+        "category": [
+            "qdisc",
+            "fq_codel"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel interval 1us",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum [0-9]+ target 5ms interval 0us memory_limit 32Mb ecn drop_batch 64",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DUMMY handle 1: root"]
+    },
+    {
+        "id": "3540",
+        "name": "Create FQ_CODEL with 3us interval, accepted (two ticks)",
+        "category": [
+            "qdisc",
+            "fq_codel"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel interval 3us",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum [0-9]+ target 5ms interval 2us memory_limit 32Mb ecn drop_batch 64",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DUMMY handle 1: root"]
+    },
+    {
+        "id": "49c5",
+        "name": "Create FQ_CODEL with 1024us interval boundary accepted",
+        "category": [
+            "qdisc",
+            "fq_codel"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel interval 1024us",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum [0-9]+ target 5ms interval 1.02ms memory_limit 32Mb ecn drop_batch 64",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DUMMY handle 1: root"]
+    },
+    {
+        "id": "3e0f",
+        "name": "Create FQ_CODEL with 1us target, accepted (target not in control law)",
+        "category": [
+            "qdisc",
+            "fq_codel"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq_codel target 1us",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc fq_codel 1: root refcnt [0-9]+ limit 10240p flows 1024 quantum [0-9]+ target 0us interval 100ms memory_limit 32Mb ecn drop_batch 64",
+        "matchCount": "1",
+        "teardown": ["$TC qdisc del dev $DUMMY handle 1: root"]
     }
 ]
-- 
2.43.0

