Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F373EAC6F
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760259; cv=none; b=ek6RaXH2pEbv/WhQuoxj/r9JQ+RLsawgtUFXal0xd3N52xroY1ctR6M66Swi3IiF3rMYJgBR1BrAss9QuAXdv+iXD5G4WpDvxB8NcnoP/3EpmKhj8FXc40UM/1hEoncc2eXwRWhD9FVZgpaK8KeIUKeo46l7dNiJrU4UsSnkngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760259; c=relaxed/simple;
	bh=jgU0tNZFCPmpjlPoVwCDmEoulDWKUBI0FHI3WjFiAqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDdJzzubd9RXdLngNNpQiVovf3D9396dQ4aGBjd0CTeJPMvENut7N9SYM0P1E/nhYhEi5CN+Dtejn2gVA7lifeZZSUaLWnD8Mf10yOth6N/C9T4A3RkPNhEUbM5kke6QRHkBKEN4wXbkMMyI0eET6LNveq6nJc82U4Zmza1RNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5q1FwG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5q1FwG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9Xz0PSB/XVkXUJiTv7pugffYZV6lkgCUnhl2GwakEc=;
	b=G5q1FwG+GGFBYlJCzJ3MSOHo3mqYHz96EncM0P0RlQoCxIztJOrAjqwYs2ubaneDRfNGro
	TeJN1khtqRz8/9siPIQUr+PE9L2a1jgOvqnnxSsqK3smmJ1SvUOUalVUgTrhzUQirEjUYp
	Yl7mL5ecQWnSPEQSDyScuNVa5ybo3IQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-oeKBujoZNsWoWoCsn7-CyQ-1; Tue,
 17 Mar 2026 11:10:52 -0400
X-MC-Unique: oeKBujoZNsWoWoCsn7-CyQ-1
X-Mimecast-MFC-AGG-ID: oeKBujoZNsWoWoCsn7-CyQ_1773760250
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 405A81800591;
	Tue, 17 Mar 2026 15:10:50 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43A1F1955F19;
	Tue, 17 Mar 2026 15:10:46 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v3 3/3] tc-testing: add a test case for ETS offload
Date: Tue, 17 Mar 2026 16:06:10 +0100
Message-ID: <7759f1fffdd0360e28687b660caaedba8ac6bed1.1773759815.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773759815.git.dcaratti@redhat.com>
References: <cover.1773759815.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

While reviewing the fix for unintentional u32 overflows in ets offload
code, Jamal said:

 [...]

 > otherwise a tdc test should cover it fine (when you get to the
 > netdevsim change perhaps)

Add a test case to reproduce the division by zero fixed in [1].

[1] https://lore.kernel.org/all/CAM0EoMm17wsYZmdFLshH3_-GrZtzd=i0xnoO2yiVB=-N4761mw@mail.gmail.com/

Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 .../tc-testing/tc-tests/qdiscs/ets.json       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
index a5d94cdec605..479b866031bb 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
@@ -984,5 +984,28 @@
         "matchCount": "1",
         "teardown": [
         ]
+    },
+    {
+        "id": "41f5",
+        "name": "ETS offload where the sum of quanta wraps u32",
+        "category": [
+            "qdisc",
+            "ets"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "ethtool -K $ETH hw-tc-offload on"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH root ets quanta 4294967294 1 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc ets .*bands 3 quanta 4294967294 1 1",
+        "matchCount": "1",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
     }
 ]
-- 
2.52.0

