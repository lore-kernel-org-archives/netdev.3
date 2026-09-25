Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D423D0C18
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324605; cv=none; b=ZN4dfojJqBnOJqrAmYvW6Ssh/aiRwdAolZfJv9J6K1POPNTQE8SkN1C+BNNdGEoormbdqtm0hm37fn3UtlFmLOrQpWYJwDPx+uKyrLE53w7K3DRIUb7rFzH4OtaVmlVx/7R5QBiR6D8BM45zDkRCspuGRN/u3h0MmxhDsMn/bPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324605; c=relaxed/simple;
	bh=Dw4v6JTx0Usn/ZJ4sCYj1U150VDxILnbuKrTSzqE7i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUyAYORAte+J8y91cBzjEAPqgkBP1AFSh02Qo784cq8WDb7TRmVi9b2DWPWjnxo7DwdiS4ztDN5qHIYf6Q+0tEOXPVpWyJRf1wAY3tY/vPSb4TUK7BVVhEfGqcxN5SKTH9ZPdJIMcbDNmpt0SkjjjNA1DZbI2k7EZxtmV4u6ssI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gV5JhG24; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gV5JhG24"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb767cc97so7408041cf.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790324602; x=1790929402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47mRdp5lPPjFXCfKGuPUegA86O97/a2J/8sFoZV85O0=;
        b=gV5JhG24dUHMKl9akl5bXE/xMMbzn5psxLfC+RW/hkcM5iFiVBcFXr3qE/8b8K+H5m
         cYlZQPQvxZFftblIUa8QdvuqZtgQDZGeOkAbaFVHnqN4Br1RtFDHy7QFhHaFG8o8vOqU
         38PuRQL0RLo/kiMgVZ8EnkfsXxjE5+5eF/02g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790324602; x=1790929402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=47mRdp5lPPjFXCfKGuPUegA86O97/a2J/8sFoZV85O0=;
        b=QNNHvcgaz4PNT4Ne4wv3AQqD4TG2vmKladAKVGfzphKmxiS/uEhh3t2UAkAmHDGTtw
         QGaKhQ/jrEntQHVRqNvozfvTZuRzFkrdkCEuTxiOh4pzmIgaTrfWgkRkDxKEnLC4B+/T
         Q3/uuUkpPX6vtFZQN4peg+LxAs6zJ85nW/47Ds7rI1Tbwg/0/4oll3eAOw/QiEZtSzfu
         u6AF1HhJXrfyjAM052IqUEfQ65nxFd5eSF6QQh5qornXr1U2wcTJFBLJJGes7Ez+xuGO
         dJcO3FHGKT7GAS4MLc+qC42aIrp0U0BaGptQokFsf2VuqwMWx4ur5rMYpTcE1m3hsdm3
         wfsg==
X-Gm-Message-State: AFuF++nRZgP7p0Mj7z74TAoo7Ebis3NCk4x+hZAP5pQQU88srkD9E6qB
	NjzaS/4+cNqAjj0C8kZwUVAUDm5tQKklcq+/Bt6jyRGfAB0+ZbvfQUazSbuTfoPtZiCutZHTghl
	noief7w==
X-Gm-Gg: AYBFou2i5f84LfECFyHf/7yCDjMOzzC1uekrECc+HKEIrJ30pat0p+uTdQ2wQFY4D3b
	RJNR7LtZrADOEzZQ3G5xXp8K1ordAuVkQxovThWtDhgUXprQuhmGGo1wd2o7q1/rdKuuedC6AVc
	vl6YsK2iSNNatoJ6ZiCLVBVEaMp2Xc/LMmDi4CjcTfegpRXgXY3UaxZtpD5Q0HlCmjGNjWFzzMR
	u+77Nbo18vJ6VLizaEGVFM8Al4ergrJlTgsjvZHFlS7VehmM/ycrtB8XfzFr6LtZ5SuawALlBx1
	GhM6edjrVJJsuQO38cE97kaxV8wGGQdXJOfZGEAp3UVT/H9q6ByPUt74v1kNNms+NyI8KYsGtxo
	eN9oKIhjWARp9EqHHuIAkmPqAvGwXs2IiYYrCcKiOoQFzo/T617h2VkSqe8H3qiihsraA2ElNCi
	QkhrmyIteDBI3veB4WducD/zzVO/TpcaAn1dnJ92Ai7h9YCewBOX4RGmjd5AOT8UaPbSQLftldA
	bfRKOV43maHxRNbyHXzJiYbuTFCiYdtikgkxwKvD/vQK7vbZQ==
X-Received: by 2002:ac8:5f88:0:b0:530:f44b:5404 with SMTP id d75a77b69052e-5330b5b15f2mr30745391cf.14.1790324601795;
        Fri, 25 Sep 2026 01:23:21 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5330c0aae6esm10554481cf.26.2026.09.25.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 01:23:21 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	hybris <hybris@mojatatu.ai>,
	sashiko-bot@kernel.org
Subject: [PATCH net 2/2 repost] selftests: tc-testing: add duplicate action delete batch test
Date: Fri, 25 Sep 2026 04:22:38 -0400
Message-ID: <QDISC-K1TH.v1.20260922072206@mojatatu.com.2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-K1TH.v1.20260922072206@mojatatu.com>
References: <QDISC-K1TH.v1.20260922072206@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260925082238.ApYMOyeo4f2cyHtNpBH4bmakwqO17BYdV-HiDQLVM3s@z>

tca_action_gd() takes one reference per nested TCA_ACT_TAB entry while
tcf_action_delete() consumes two per slot, so three duplicate
TCA_ACT_INDEX entries in one RTM_DELACTION free the action mid-walk and
the next slot dereferences it.  Assert a duplicate batch is rejected and
the action survives.

Conditions to recreate the bug:
  tc actions add action pass index 1
  tc actions delete action gact index 1 action gact index 1 \
                     action gact index 1

Testing:
  Case 8135 fails on the unfixed kernel (tdc_8135_unfixed.log) and passes
  with the fix, alongside the batch-delete family (tdc_8135_fixed.log).

Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-tests/actions/batch-delete.json        | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/batch-delete.json b/tools/testing/selftests/tc-testing/tc-tests/actions/batch-delete.json
index ef7ca4a6775b..7620e927ae2c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/batch-delete.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/batch-delete.json
@@ -111,5 +111,38 @@
                 255
             ]
         ]
+    },
+    {
+        "id": "8135",
+        "name": "Reject duplicate action in a delete batch",
+        "category": [
+            "actions",
+            "gact"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            "$TC actions add action pass index 1"
+        ],
+        "cmdUnderTest": "$TC actions del action gact index 1 action gact index 1 action gact index 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC actions ls action gact",
+        "matchPattern": "total acts 1\\b.*index 1 ref 1 bind 0\\b",
+        "matchCount": "1",
+        "teardown": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ]
+        ]
     }
 ]
-- 
2.43.0

