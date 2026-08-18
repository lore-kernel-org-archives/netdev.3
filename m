Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BE3CB55B
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048264; cv=none; b=OsmxJxrDoQJQr+/ss9ntltWXaEq7KyGXhaBZo/R5z578bItfwLbRZSBSwFnhex4l9vKry9MA3rgOFN4Hn6IrDM1Mmab3EluzcndaBrs+qlFKZ6EnO756pWWoPCwV8zE+z+IP36cOXaqNQdDfDNxlVWxTfsPylV6WeP/D4xy/CUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048264; c=relaxed/simple;
	bh=/I3fqurkIVvuHLg56QKuZbaJJhBk7ENuiTDNDBMN0Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RhpYjlyrWkHGanhnSvj+DUc+8uH7nHVB6tHcyyS9o0xkbTeLlo2DkoUsIefd5HuNahoeAR1qH32qtylVrRThwMO1D4I82jUF9aB0Yj7b5rl3hhOSahzt18QJ8wjqjm1WDIYTULLjv8r7d3dxoo4EUGiaaYuzOpQ0jE061zpseIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=IqIDnPTY; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="IqIDnPTY"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e85499ffbso367930285a.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787048262; x=1787653062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxq5ZSvaEO4ApbVTxKVnsTovrfCAc4uzDIUjvK/vOu4=;
        b=IqIDnPTYJbQiubqEUZk4klKwNvaDAl8UojdlM3oy2w6mcf5aJljMHnIM2cupcmmsx/
         e35at+V7d6BpIbm2QU51LX+u4WjootA8hDBCiYedTliE2ovvDCy7FVmcNoRJoOLVlI2W
         YZ9RqR9ROsZ+NQ+nQzGqwTVJt73M1G02/rhOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787048262; x=1787653062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gxq5ZSvaEO4ApbVTxKVnsTovrfCAc4uzDIUjvK/vOu4=;
        b=nos9md642ADHZ+AjFKcYXHIF2dgFtE7Rb8VNjli97w3gzXT3D+Gq6EnCYzXF5LLiXq
         3EEJjQjFGiQsN8YQioCc5isLtiUO6gK97t8VFoIjMCqc7XBxVbbA/TjJcOopuNU8UWSf
         4hKbStyqMAxgLSKclz0pakTMWtTgVjEEkLtMrN2hrQ2yTG6zGTVuG8c8bRJh8QoWvF1d
         d/FDtxd3BGgBZ+KkDzljmoO/jeeBo5YqiK0IKXV5Rr9IRKHKXYq9HqtvEh/dioQC/SIB
         /UOaV9bqrCrWIkek5sijET/BcYr5XpsBCP3wS2UJUkLJzM0G3XMrw5frdDAr9JczU7It
         JC1w==
X-Gm-Message-State: AOJu0Yz+KZNx/eeLYGJL9xo0nBl6P55FtBao5eEUqtXccK+7xZKtYB2T
	jH1vhGTVXYze8gUsRT/t0wZKlK3SqkqAp0crf8CKv/wQ8RJZZ3TCzwRnrP9nvXXxUFgFT8Sllb8
	p07kRaQ==
X-Gm-Gg: AR+sD130k+wKS4UnIi7JCgnUkaX4oyifNfCsjTHuKuYh5r+QuY0HJ/XmxuuPfn7aG9Y
	hXnIB4HOS14/yWOj0u6fhNCE+EzownARf8H3egqXYOmkeWsY27J5B8j/mPeuxlkeMNdolw5zd5N
	OapVKFx9APlRYsOzCLNT1CQgrIjujAlfIP5iJyTwlnfRSvdknL5MwG+2zY0V3NZ9xbBLaq7WD/S
	CPGLKQ9U3vXRJLKRKGC13ZYcU56iDbtamPum271q/oWzo3JJ4xwjsG6pyWDn9MYDAusOsXmptMA
	2S1aAeoIu1JWJ3BKpBk3Bi4yfA5tkj5EfRf4sAj0fRS8rso8ytGKPp0jv/eLm1gU9a1kSWoxKxB
	LkW8q95Joyb2CWYxTc2AnMvBvFFMooBBUnXBlpc20wO/s0xDl0FGr+jlXsyYvOoVbt/RH8t4IlI
	1H62elFIWf2ivGmYvcRJb7Sw6QgeMWgUGNpXKHf2faXN9qTA+HvjVvzvXVzSSpeQm4jlc0W6j8E
	gQeYh3EoNEjsSskMIYOU+MiKDBJM0Umj+5Mu0x+Z7yxQQ==
X-Received: by 2002:a05:620a:284f:b0:92e:8a8d:ec1f with SMTP id af79cd13be357-936d22ce70emr3509189485a.24.1787048262181;
        Tue, 18 Aug 2026 03:17:42 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010e7fc0sm299346985a.20.2026.08.18.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:17:41 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/2] selftests: tc-testing: add TCA_STAB overhead rejection tests for DRR and ETS
Date: Tue, 18 Aug 2026 06:17:35 -0400
Message-Id: <20260818101735.16655-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818101735.16655-1-jhs@mojatatu.com>
References: <20260818101735.16655-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tdc test cases that verify a qdisc with an oversized TCA_STAB
overhead (2147483000) is rejected. Without the fix, the qdisc is
accepted and a single packet drives the deficit loop into a soft
lockup; with the fix, the add fails with -EINVAL.

Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/drr.json       | 20 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/ets.json       | 20 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
index 2b61d8d79bde..7713eb35aaeb 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
@@ -86,5 +86,25 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
         ]
+    },
+    {
+        "id": "d1e2",
+        "name": "Reject DRR qdisc with oversized TCA_STAB overhead",
+        "category": [
+            "qdisc",
+            "drr"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root stab overhead 2147483000 drr",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc drr",
+        "matchCount": "0",
+        "teardown": [
+        ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
index ee09e6d6fdf3..da7ae626f7e1 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
@@ -1007,5 +1007,25 @@
         "teardown": [
             "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
+    },
+    {
+        "id": "f3a4",
+        "name": "Reject ETS qdisc with oversized TCA_STAB overhead",
+        "category": [
+            "qdisc",
+            "ets"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root stab overhead 2147483000 ets bands 1 strict 0 quanta 1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc ets",
+        "matchCount": "0",
+        "teardown": [
+        ]
     }
 ]
-- 
2.43.0

