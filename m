Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68975632B1
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094850; cv=none; b=B/GrEHJmtsN1tdirz1KoEysgiLY4Ew9H7cigGhOrWEXho81GAZL4bexw+eECPxgcTPd2ikEyZYdfH4GEE/ZFiAUD8EQEe/iQBZikYuWQucpTeQNpwbnm1hiR4QtLtgcUlRv9wxFc5NNeIE9z1v612RC4kk8wIX+svtz73h/eqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094850; c=relaxed/simple;
	bh=Dw4v6JTx0Usn/ZJ4sCYj1U150VDxILnbuKrTSzqE7i8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g8umPbx4+6U1LthiUqQaRD1oANUhEtTDOwFBXNvGfwvAj2dFilzgmMZRypsuOEs69cwqLAc2L3+WtAi9r+lXVQcGmwckcpFeAPqOpODJa3dGw6Tpawd3qvnt1ibaFO+g8lmS08bi0Ru7chMmDRlsJc+cX4wEcZ4CtkMBPE5rtrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=TvVXMcHq; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="TvVXMcHq"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93a2a8c29c4so7959485a.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790094847; x=1790699647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=47mRdp5lPPjFXCfKGuPUegA86O97/a2J/8sFoZV85O0=;
        b=TvVXMcHqj5Xpoue63gH6PgeV/If0sHbl7UvVRoDquK4x78QvkIDUgPgTd1fStwFiJd
         l6G4mcAkrB3woNqfeeHgNxzhLJKc3McgSGqz1vW3Cms5RZXdlRQMQMYAZghGHRPHMgTk
         n6WObcpe/oKHv9FvMhOkASnn3PV1DfvYbNC0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094847; x=1790699647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47mRdp5lPPjFXCfKGuPUegA86O97/a2J/8sFoZV85O0=;
        b=r2S+xdWPuwLMc4rdUH1kajo2QYWlgMaoJMpyPZkYdoZQwr8kusBlUePfiHsLc5kJ6f
         0yVUPDulZix4M6LIjNhJ/wRzcK47jCAsGGA7zCIyQjJVpBfcYHPBQOyio/as0kyHcGM8
         PWWqGMz4hunzgt584C0zlqs9NtfRuqPVeH9THKsghTeT9UIJFSNPtY6bm1s+BHgL30kN
         /ZUsg7urLsEcgAS7VnxhXFBU4dxSmdIe/iyVUG1mxZzhyyES5UtGwCcHdPufPW7JovoP
         bT3b19psj2ZehXO3tQbledq+N+xGJrC4GyS1jhuhfhubsZ5ZIYth9q5o7hLyqI6ESkaS
         CRVQ==
X-Gm-Message-State: AFuF++kw5nQ/weB0pV9qG4uOIjH1oV38ydwqf1GeRKH5HUIZMtDTzgoA
	l6zNApGfNC5BeuPjn5JDfWstuFo6FojshPodj+EsfOnEqkw994EQW6FYiJaUm+974MUEjSsI1vE
	ZLTZv+Q==
X-Gm-Gg: AYBFou007fhCXiAAJwcklG8A9ALzm/+Mjb3wqyweACvy/N+JJ2rhtPsH4wHwhI2QZe0
	5INtcb38EL4miFAISRPvhlj57ZfnXh1KMe3efc+VZjQVqef4ShD8ZS5AMpPIz0mciKXKmPLnlES
	b+m+dS260vTzfWumVpcYe/U0tOR0OZEyE78j76c1xs2GH5TuuweovuMmoN5oUwexHKfTk8vwah/
	8XlbW8BBpwHuL2w3oYPxDxJdUh9G5+1MzOE9oL8gEfCD+5YvmpBb6grfJPZVrIiUIAwbwllTmwY
	sl1MbsTBDMFcebkQ7f55I5ZBBBo3CUH8coJoROQltVNZFgPLng+pPK8PW/KYFYulYlXonyJMh9s
	0xd4xkXgfAPie0gzNelD8MiqT6NmkZRR+ZZN3R61MtXnWcFjC4FH8aHgjz0J/oSnKtb/n5Cw20U
	4MIRc8bssIO6oJKChsYxiMKmZ9hDJOG/FRkaeDgTwOl3uTzc4fwnFKXETYSZkar/Y8J+rP2XX0H
	wGXp4L9lmipvu6qY7YzId4Du8R89PwRxk7dsxbbXuxh0q5MTw==
X-Received: by 2002:a05:620a:628a:b0:93b:e82b:a584 with SMTP id af79cd13be357-93c15e7be9amr598167585a.35.1790094846976;
        Tue, 22 Sep 2026 09:34:06 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c248bd54esm11220385a.38.2026.09.22.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:34:04 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>,
	sashiko-bot@kernel.org
Subject: [PATCH net 2/2] selftests: tc-testing: add duplicate action delete batch test
Date: Tue, 22 Sep 2026 12:33:59 -0400
Message-Id: <QDISC-K1TH.v1.20260922072206@mojatatu.com.2>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

