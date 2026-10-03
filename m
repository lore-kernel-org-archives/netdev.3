Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199E37B00E
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021304; cv=none; b=GKnDuioEADyFnt1BUl5SVLOEUm9I+7sFAUDfzCfaeqG5OM3mLDUgAOjcXoA0V235Kttbe+fYUR5xnKB0lpxAFj9T3vC3Ij4+ElyTnVZtRZMxmruc8LEQinGtUxSkROKfdQpm2ijnYlaSZ9DtJqvy/JeJVoGbzAEiS6Q9aO3/vX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021304; c=relaxed/simple;
	bh=cqoC/mpI00uBeyIZHK4KcDf5NQYVnPkZr/zaNcMKN1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Slw1H+wP1BBPb2oKOk3DsmWThJqkj/H4g3YPLlJw2VNP639thZGmY05nGn6fBBwJB/c/X0rvwvKToh24arE5G5aSDIOKeXAUIHiO1suiDmBkTLVZ8hCRGvTJOY4Vq9KgXXpD/5loVPa1CyYnM1y0ZpHFu5VX2Hhye2sXSHIz/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cNAvFfEv; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cNAvFfEv"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-9144e8021d3so9197306d6.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791021302; x=1791626102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXMN+/zb28CkK1fnScLZHRvDxt7URwPd+oZeBLTFd18=;
        b=cNAvFfEvJN3glHvogLgb/ErlbpKdYjEB8LMFyRIN7S8fjViCYfZ9rgaUBrf/oUcat1
         6QHZMz6yBI2W0rfo8lw3119KHPCY8aaswpbjmLfqSJFwyBHfJW1DT5Ag0NCxSLgGYEv3
         ql+pJHcsY0RddurdH9hzInm/dmCZAosLI8sKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021302; x=1791626102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yXMN+/zb28CkK1fnScLZHRvDxt7URwPd+oZeBLTFd18=;
        b=xfO37wwq3Jmy1czqQvZ8evxzZNc8GLUEUPq0T7HrpAkfPmH82wxZQ4YCRKarWi8wqp
         o8gbUQoj6NS8ztjkUHyrH/kwCEsUN3IX2KchLGUZGeO6XgrubDT/vfOu44NefcleXX2x
         zLrMaHh5pQsbnvQaO0en1e6tkb2UVBznLSWt0KL1mDJSFAXmdglB4kqgHDlLTX0IS7SN
         uYtPp59FfJDbH32bv1Xf0pB4kQHM0WPys/o3OvIuX7dL+q+gXhWV9oZi8FYS9gg9/tkG
         XSg2Aku6V+EcwgEqMyqjExK28D1pKXLQRehHK+/zcGBc8Y3iIbo2NFlBdmI+8Akb3efr
         FwWw==
X-Gm-Message-State: AFuF++npOh54C0H3ZmAikpqCAY3NNz9GqHbAt2xVaISX92ZEqxF7SURC
	dbHYf6Z964ouWSBgKo+Y4T2qMUNDNnzuJJZyX5DNEILhHtdOhbAd3rHLngUYuCB321IaOQDYsi0
	/15g=
X-Gm-Gg: AYBFou1EvunAbpJE2RCn9razgkablECYiixW+rbmS3m7VKr18GmsKb2i+cA0Ve5P4Xj
	VIj9zCFiwQpwWRFfoh+cKjm9twZ+82QgJQqtNcUbtGRJGoXZPBijdT22SmOTqwjZYOGvqVWyRia
	3qi1t/Ie2mNyBlU3NLRtXfpxv4WkSTukRXCnSJyzs0O3b4S1wNFZ7CkHrB7mjexFdx9ylxAfAv9
	Bysa+IbrQWiExaxQEWiVzXcZ8fDWWDtHC15wWpcxZp2rusqxE6I5zbgmOj5pbx7iE+C9+qcvWdm
	OGHC5ZbiIfi7I4aJuUmBVR7xTTfbRKlrLasRh9BxLfxFYL/Y5K48aa7YHlCuabCTi3Q7xhx89GD
	0uoqCjcobfMu/d5RUX1BBJkUU2n7mPaZZRsIUEJDVAOyKd1iE6FlRjcJGAad9P0lkEYxlY6u1EJ
	HMSIiSMNw+NNfjbAEiczayQ8LsiLG/atbzw6ts0DGqcR8tWbDaSTsQUNT0fD4EU+ndeNjcdYBcy
	0uyxbC1NpdECsSPmQr5DAxXcVXTQ7rp61PnPP4lVbOiBS+H+QcJ1Zb1Lub7
X-Received: by 2002:a05:620a:29c8:b0:93a:2bdc:cd57 with SMTP id af79cd13be357-93e50e0820emr341771285a.2.1791021301991;
        Sat, 03 Oct 2026 02:55:01 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c3e2bdsm40853956d6.49.2026.10.03.02.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:55:00 -0700 (PDT)
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
Subject: [PATCH net 2/2 repost2] selftests: tc-testing: add duplicate action delete batch test
Date: Sat,  3 Oct 2026 05:54:54 -0400
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
Message-ID: <20261003095454.A4i__8DE05M3wQB_gihs9BDHXVQXu0XpMHEs0y-k3Ow@z>

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

