Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB53CA49A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633185; cv=none; b=c5w1o4N/auuPOmkqJhcyuhiPJdAPMk5JhAmqDfjYkfFf2D9CASAIk1sJ63pGODDqr/jFgECsW7kDKxZ548sDQHyNS9cV2XgM1TCPLEKfMyvBWE0GBf538eUruyQkm8Izjafy6Fh1cn8d0yP4TJJQ8v0fvq9vmA8IAZOjdyzAWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633185; c=relaxed/simple;
	bh=xBeXXKixO+4fxzQ5BLEMoh0DC90ck4SdiNRvMyLIHeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RlWNdKMHymNxWEdVVukhbUxmDGg43bxpVpZA1noEfpAZEaAmif5QqMLuZvGpeHTDJ9WO17LwgnywIa0+AOPLTY1fpQDGsWkQU7XnYVy6zPbcLgSIHbTOJ6ycG4klG70KRhNH0aKhyBHSgR+UgYFBjjO0mq32qWQdxOawW3BpjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=MivpS8qd; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MivpS8qd"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506aa68065eso62960481cf.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 06:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772633182; x=1773237982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4EPHxJkTM6rk1zIhdLCVien7vvKWbt0Byh1qE1FeuM=;
        b=MivpS8qdxThevit0758msMxp9zbU6ULaNq511c3oCpdB9WoL/5NUleA26WEogmpXeW
         iP8Y6d6ozJCbh9oYiFitWJmTOqnLjx9a+Ve3d1QBLwum0a/kD6/Nt63ECVLpcMnLS5We
         unzHhgwOGTRtRLBenMEHyPJs27GGgK3s6YFKtI3tnahecO2GL2cYlbH1P42N1XvABXrn
         ximzgxlKGP4BEFCmToqQQjg+fpiyZkMqBCDvvDUYZri7JuFGN8qK43EI/gO5YEYJPQRC
         ZTkmyEKzqJObUsU2G/CSJJ9ilOvvskGBr77f1KwNfZjNhkHN9DNTyJ+CYmjHby6eouZy
         E+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633182; x=1773237982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4EPHxJkTM6rk1zIhdLCVien7vvKWbt0Byh1qE1FeuM=;
        b=EjRAsCCfGxbDMZ0JIa/XUmMDNaPPuOXAWZhuQjT9VZ5A5mD/ZSOK0QWcBXXg2ZPUj6
         F7llYOtnlxKMdbivT5If6i8ZKKAf687cKLiu00rPPp/Vl4Pyt1yLvbbTDP/km4sH2B69
         eSPghAT822KZ7+3HrlDaWhvxYo1aXRKZXDcNk8FSmM6Fm4AjPabggkhU6W3BDa6NVNNe
         W1TYFX67O7/lU+5bpaB98SxbaQicshy3ocW0JppUAgaCcaN/ecGy9htIeLT2E4s312Dh
         puNUYIhZK9aMJGwwX/GiLz4eFt4jMKmQ88+jj4REJjwtYlIOgl61OqfpbG2JoG0MoC5Q
         6oQA==
X-Gm-Message-State: AOJu0YzYzFyOOhZKmhwEjte9iz6OQwssNJ0+LwiPZoHqsTFplhniPSHv
	RZCYtdQjwZvqf3WFNuTAAD1BicM8ku7aQihmvFUUzt1m4J6pqOVwwjsvxC3f4BoYlRMClCvOzqa
	i5WI=
X-Gm-Gg: ATEYQzwtdG4fVTz8XEMAxy3JzOySKk2wOvL0yq7Y9zshPfRSLrx5qRwxXTe0XPfjUTO
	Lsjc7KRoOuqgdGIYIFgZ6v+SFfQwZYIMltFbUYbNR8Vy0XR5CwhJo0XRCr92jpN1eTzaHPOg3Bd
	wblwjyO4Q7f/y/JBdCUQ+9+M5r8ObkSOMOR1n0579aR+pvRUq3LTKCmfPvOraIjucnqJ2a17tz2
	sVtIS2VgOvIyAVwMVNhVmiRDLk/Bb4XIYAMD1APV20b1YjDzrhtrZvt1q71sfRBok16nBL0Q95f
	Yj/6iZQt6HSQjkILruvv7tNDnLB2OYx/2O4vEx1C44rXXP3JfUTj6MVKthBDgrb4GCISGeWFv0a
	gQkxfeaVp+yWpJusfI4kGqDTnrCjYcB+3kzLYr9JSCCYmodBdzLPsIKQO2j0QLDDaTkjlvVMOxF
	TXHRZBhvPJFjyKyPrsSn8/41U=
X-Received: by 2002:a05:622a:241:b0:4f1:b9e1:f08f with SMTP id d75a77b69052e-508db28b16fmr28066261cf.5.1772633181892;
        Wed, 04 Mar 2026 06:06:21 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ad885bsm152429791cf.28.2026.03.04.06.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:06:21 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	cnitlrt@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 2/2] selftests/tc-testing: Add tests exercising act_ife metalist replace behaviour
Date: Wed,  4 Mar 2026 09:06:03 -0500
Message-Id: <20260304140603.76500-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304140603.76500-1-jhs@mojatatu.com>
References: <20260304140603.76500-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Nogueira <victor@mojatatu.com>

Add 2 test cases to exercise fix in act_ife's internal metalist
behaviour.

- Update decode ife action into encode with tcindex metadata
- Update decode ife action into encode with multiple metadata

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/ife.json      | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
index f587a32e44c4..808aef4afe22 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/ife.json
@@ -1279,5 +1279,104 @@
         "teardown": [
             "$TC actions flush action ife"
         ]
+    },
+    {
+        "id": "f2a0",
+        "name": "Update decode ife action with encode metadata",
+        "category": [
+            "actions",
+            "ife"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action ife",
+                0,
+                1,
+                255
+            ],
+            "$TC actions add action ife decode index 10"
+        ],
+        "cmdUnderTest": "$TC actions replace action ife encode use tcindex 1 index 10",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ife index 10",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ife",
+                        "mode": "encode",
+                        "control_action": {
+                            "type": "pipe"
+                        },
+                        "type": "0xed3e",
+                        "tcindex": 1,
+                        "index": 10,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC actions flush action ife"
+        ]
+    },
+    {
+        "id": "d352",
+        "name": "Update decode ife action into encode with multiple metadata",
+        "category": [
+            "actions",
+            "ife"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$TC actions flush action ife",
+                0,
+                1,
+                255
+            ],
+            "$TC actions add action ife decode index 10"
+        ],
+        "cmdUnderTest": "$TC actions replace action ife encode use tcindex 1 use mark 22 index 10",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ife index 10",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ife",
+                        "mode": "encode",
+                        "control_action": {
+                            "type": "pipe"
+                        },
+                        "type": "0xed3e",
+                        "tcindex": 1,
+                        "mark": 22,
+                        "index": 10,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC actions flush action ife"
+        ]
     }
 ]
-- 
2.34.1

