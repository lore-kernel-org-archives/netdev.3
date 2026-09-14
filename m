Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC8331EC7
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373225; cv=none; b=HYS2KtBlS9DUpaV5x4XwmPb0jBWls+B8ycpOaKCOyyyGJdqsYkO8bJ0KZtH8A8y2qdYqEiLlntXlaDrhLmPGIXXGbZk2RaS6IOvgaPXoLHKT/A+j8AZ11407PaTcR+BcMvD/7S3m5S4WFTPH7v4fedpeNeMdl7zBDQLd4YvZwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373225; c=relaxed/simple;
	bh=04SNK0QDwiMS0hopMmeCQs3rvtaAQFQlUKtFVQWJg9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJryhevsBR3XnOSnfZKKO0lXHsCtKC0Lm2sfu/OB1wsq/VfU+x6S1tki3/oWu/wDeRG6KgBZcr9DzuKuMU51C1LjetKHimBEO5HD9xY0GQpWVFE6rCnkxZfM2QTmaS8w/h5pd3MKey2epbseg1pDO9fEERznT/H8IqH3FH4ZU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=n9HmIMwJ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="n9HmIMwJ"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90ceab90152so28968886d6.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789373223; x=1789978023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAnxK47WdqKVeHAyB2VK4UNGW89D+mc244J/y8/1SGc=;
        b=n9HmIMwJoVGV/kc5nWifnTT8xkRkc0VeDxJWJiJzSz1RRhqjR2NVn+4Bq8CYvHmi0j
         +FEU8DHsmpqvvSLsXOXw1kBEz5qUGdxRZ413MYc1Yz89RW6h2sSJzAl6epYpUhHjZhUH
         mXAu3D4e0IWq1Lb8YHJcB30uejQjga/LIDELo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789373223; x=1789978023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TAnxK47WdqKVeHAyB2VK4UNGW89D+mc244J/y8/1SGc=;
        b=flQuGQyZjoC/t79Y0fXxhtJn1Tvox2GV/Nr82MZRpF32cNGjyRjyrvmSiCGW4HLIuI
         94qRc54K6vHEHM0yaqA+ETj2EGqBth/yPPm+QpGdXgWoJrMV81HBeWRcla2yWM6A8jpj
         ZElNw2pig4fRMYiQFB0ZcjNHSU2GXCqUyAOLeS2rgWjJgVc0pysvtTLeoxEq5wo76JC4
         Ti18MaZ+UdMl160EkujlLZUQNGZIRhoD++DxhHWXo4VlNenXJvDZG/6j3gQGXWkLZ2cx
         7votyJqS4R2351FU9Kn9MXSxWo8O3riK8RwGHOYqi79P1tx/7AJsquUvKAnVX/Xlr8sp
         w95w==
X-Gm-Message-State: AFuF++kR3E8fna2jHXvz1IBqJHOg+zHP628rwz6+gb9U0Oyco1+1ypEr
	PRdoJPGdV6IzviWmhy6mdsP5+QqkuHWIgZ9hrHZ/XMFzLNwmWMYczl3kW/gmDgQ0+Ox0Y0v3iUz
	+aR/GBA==
X-Gm-Gg: AYBFou0Dan2EVw8CrCZ1P2sZjdR1+zgLrDdJe0ldIeLIuOWhKqLqA7upUycDVeASqQg
	7jRDTpEoM07pVNqqUw6C8o+VTVfzajlJvPoQrsQgwPAc11RMKcpl2VSJqnDBPOR/Cz30uctmo44
	mtdcibpnA7emkS0yGP54ykqGfNyxzUYYiplRJ5nc6UUPtu5cpWPlNTTkNTXaPiPAmYJkAPudmdY
	oGLqRPYsJoG3YRSwGatapGpNB1dNLDDxDCJx35kmoFI13rDZuEEgkR/KmhG8dtyWKPfKKd9SoSj
	uE75E9TiIkWnqx8In1XRLOdi0hqGVVQcSuB5nGGv14w2syk2UZFZ11D0mpornIu/EjMonCkfetG
	5oOoNP6IBZsPvkZ/jjX46BuI4mFSr23KmvW5/9GC2mlxv+czKw3v0PU3HGA1z4UHq//jG3EnVtd
	iDMbiAJMCbg9FDlhhna64J1pSAskuM8sF8ieIvNNzkAk9eIroKEIWA5HqOtxMIZb2kVtrL7cYA6
	GQkygY+vNPT2Mq6rxGsbux0Ji6bg1m/VkqDWMiQCRZ20NKJcM2yl052G9XdFhIdV0xEa7TE3PyR
	GMLDvY/dvZElV85X11+m/g8=
X-Received: by 2002:a05:622a:5599:b0:530:f986:7d36 with SMTP id d75a77b69052e-5310d026194mr19948351cf.32.1789373223056;
        Mon, 14 Sep 2026 01:07:03 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d51ffsm90187336d6.45.2026.09.14.01.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:07:02 -0700 (PDT)
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
	Sashiko <sashiko-bot@kernel.org>,
	hybris <hybris@mojatatu.ai>
Subject: [PATCH net v2 2/2] selftests: tc-testing: add a lateral-drift hfsc classify-walk test
Date: Mon, 14 Sep 2026 04:06:56 -0400
Message-Id: <QDISC-CTUU.v2.20260913192615@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-CTUU.v2.20260913192614@mojatatu.com>
References: <QDISC-CTUU.v2.20260913192614@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The classify-loop fix bounds the number of consecutive lateral
hops, so the guard must not misfire on a legal
walk that reaches its leaf through a level-drift lateral chain. Add a
case that builds exactly that chain (root -> 1:1 -> 1:2 -> 1:3 ->
leaf 1:31, with 1:2/1:3 deepened to interior level 1 after the binds)
and asserts traffic still reaches the leaf. Passes on the patched
kernel; on a too-tight bound it would drop the packet instead.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/hfsc.json      | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
index c98c339424d4..82d2f8af1460 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hfsc.json
@@ -169,5 +169,39 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "8c39",
+        "name": "HFSC classify walk still reaches leaf after lateral drift",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "ip link set lo up",
+            "$TC qdisc add dev lo handle 1: root hfsc default 31",
+            "$TC class add dev lo parent 1: classid 1:1 hfsc rt m2 100kbit",
+            "$TC class add dev lo parent 1: classid 1:2 hfsc rt m2 100kbit",
+            "$TC class add dev lo parent 1: classid 1:3 hfsc rt m2 100kbit",
+            "$TC class add dev lo parent 1:1 classid 1:10 hfsc rt m2 50kbit",
+            "$TC class add dev lo parent 1:2 classid 1:20 hfsc rt m2 10kbit",
+            "$TC class add dev lo parent 1:3 classid 1:30 hfsc rt m2 10kbit",
+            "$TC class add dev lo parent 1:3 classid 1:31 hfsc rt m2 100kbit",
+            "$TC filter add dev lo parent 1: protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:1",
+            "$TC filter add dev lo parent 1:1 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:2",
+            "$TC filter add dev lo parent 1:2 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:3",
+            "$TC filter add dev lo parent 1:3 protocol ip prio 1 u32 match u8 0 0 at 0 flowid 1:31"
+        ],
+        "cmdUnderTest": "ping -n -c 10 -W 1 127.0.0.1; sleep 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s class show dev lo",
+        "matchPattern": "class hfsc 1:31 parent 1:3 rt.*\\n.*Sent [0-9]+ bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev lo handle 1: root"
+        ]
     }
 ]
-- 
2.43.0

