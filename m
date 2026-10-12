Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDB4A99A7
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828583; cv=none; b=eWgGGg1CEeDzPRkkZs1tZVFQqkk55VnRQ8doALZqEnOlvBZ4I+J45ZjhW6Xf44NKfKNrOXaBmdCIKs91v+CvM46fkJSYUCrOrDWXTwzvqde6qjlOsrTMXMf5wujPHZipRuHLV/EGv8P4vV8+L9I2tNL//olVJ/C7FE4hLkMxRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828583; c=relaxed/simple;
	bh=7dL45bqoQHOpAqBjaboktIEncRFMXqYGop4CZl73qZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nk5+G4WtQxEE7dPsgPiRvkgJtepcDJdUjY2qgj4vDVnSPz1COunsb9NRj8GALpv7/GhZ7L9cp1htR6ydQl43FxYEaffcPVmL3qpx8vz2Ydw1q2yOxqMQYgdXNiQhyO/ARDqqhlnzykB0nv+7jiWfsf7OB3pfa8BzwuOCJxTnfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=AwrPHoIf; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="AwrPHoIf"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-534e6545939so17364501cf.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791828580; x=1792433380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2panEO6FZ8rFQx3OSsMDR8OIAlR+sCRx07G93WCf38=;
        b=AwrPHoIf1Q6T20KEr5f/0TIEdCF7KIFK5bRmGISdBWIXxYAprDtC0Ij0s58Xf2a6QW
         DjXQneiz6g5p00Cq99MIP3Rc7CMH+re6bE8T4gUizOha+gzqRuKmXBLp4uak3c9Fq5xh
         BZxPpPxOc+x0qMnCsy3Jsi4LhyXsC7iRSy+NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791828580; x=1792433380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l2panEO6FZ8rFQx3OSsMDR8OIAlR+sCRx07G93WCf38=;
        b=iFoWdXVoz8rpAjpKuOE1wNR4xyLroJsij3INy023RAOzxQH87Y3znbncFiwI3Lpmjl
         RaDDRkXjr93LV8h1acArP5b+SSOEdNaPrCHnO2FPQE1W3+CRlQqqIIywdX9vwLQWoRu2
         jaMZ6SP67ta5EnbG6/5z5MlRS3Dlu4yMHbTquUMrfPANrGkvBhKgrDpgFJnq/ESOg6eB
         ArSgyMP68R8lMOhFeGbqtOItVDQ2UZfTz9NQkuWD5+8zPOLBGFwjcR5s1TxIDbcDrES9
         WKrYOOe2hlLzAYMwt0ht1LxKrlySz2h6Hi2oqSsao1D4CXcwaWkkOr/qmQe3W/gSuGpr
         HCXQ==
X-Gm-Message-State: AFq9FYKSQe4lq5Z9v06fHPdviGH976F/AfhzAndPGG9jHMREJsKwBJ4o
	+JLnm092qkQIw8j7+4zYjYb6M692o1qLeqCM+THIEc2T3J4sHhPcUnjfzBxJj8fYSnzufjuHUPB
	8lFk=
X-Gm-Gg: AYBFou1MSrZlhRFs0qQGvt4doW5qxACvIb9uWUFd6HY7u6Dxe1ezUXDQIOArVV7iwZ2
	yQuNKaeQ4kGO9oTz3sWpgvTYvUX4uY5D3Etc/rjPhDOp5XwEke5xR4U3Uvf//A2KLxXeG9f44fZ
	0wS73CHc3fC037IdQ+x1p7EWzxUfwnADRNpXaVyWrL/oqfAsstlLsOptk25f0IRzAUoGsdJHbmW
	5WyQRajIHW5OC577lx2Ckm6fkUEASboHjq0ni9nl8RqS9hn6kqwijQpn6/dghVFiIhyjsOogY9E
	gBprfCiIox6xaqXQh+9Me6tzUsgFg5GaVgHPRFhvGjfHcjwDmsqcY4oB+Rp+L0cd7TwZMcXWG9h
	mrNMpViiZGUpo0o755HQqrPJ5jePGUICPRA05sZZIOl96E5K6C2D/pBR3Nz+BDbEdvYfCyQOL5i
	GDCnReIE5gVdRGQ2W4wbBOS/5DDQ5mycXQyuT7VCmNuWf53b1GJ8syMRTnGQbzhATtNBwwP73Gs
	dYjrkBDnZ/C/L99VsFdn7/HWOAotd1OuGmSnDimKy0I/0zxfceZTr8=
X-Received: by 2002:a05:620a:6501:b0:93e:a71a:5de0 with SMTP id af79cd13be357-93ebd21237emr1786785085a.26.1791828579786;
        Mon, 12 Oct 2026 11:09:39 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm43794885a.37.2026.10.12.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:09:37 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Buslov <vladbu@mellanox.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net 2/2 repost3] selftests: tc-testing: add duplicate action delete batch test
Date: Mon, 12 Oct 2026 14:09:26 -0400
Message-Id: <QDISC-K1TH.v1.r3.20261012134653-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-K1TH.v1.r3.20261012134653-1@mojatatu.com>
References: <QDISC-K1TH.v1.r3.20261012134653-1@mojatatu.com>
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

