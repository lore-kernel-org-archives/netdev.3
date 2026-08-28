Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD02236EE
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919567; cv=none; b=ouPkclxe4DW4Co2loHPjduBiuh4GQWtG2gbuCPBBVgR0LIi61iQsn7q9L3LvzAcUD7cUzVTV7Bb6+LwnGHucEsjN8MHVJRV6Zlpp7EvlzmYztFDQ5p1nEicDmphDb6rGI6vf1ApVSEh5RxlglFV0tcUwVJQIVzH4lq2hjfpO4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919567; c=relaxed/simple;
	bh=bshnzLQtuqK5RsJ+j4asqunOyQeV3NNzp0HpDR+Co9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iigDGqV6ww/h3KWgbjDH0SbqfL7r7fHAc1O/WJK+ARiu9lCLRrCOQP9FaOAP8F5wMnkViS+9gXsLQmE64SZxC5j3CnnbnEUDWfNzREcLe0e2iZ4t95PsigGD76Ad5NvAfMNftebah1n65V1Ex6x6ImW5YXTWc+n8RZwazO91+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gZS5E1YV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gZS5E1YV"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-930f618435cso37820485a.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787919558; x=1788524358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3k0hfFe60nKdt8DGCq8JnmcVepv/kZYgUjKWBiJ3cLw=;
        b=gZS5E1YVj9ED9DcaSoOkEnQfLffUxXZWx0sNqJDKe3hIfWlSStG7DpC4pkWKCKa64B
         UOrXIzRwDb3c6o+7+ISDfol4Y/cmesoKDFEem1+u8bu5Ekzr1b0Y1JQOh3EjdMoBgsdT
         By6Ecft4R6M/8IXMsxY5JrR79O33xo7KUSMBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919558; x=1788524358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3k0hfFe60nKdt8DGCq8JnmcVepv/kZYgUjKWBiJ3cLw=;
        b=cJTuaMXuygXhQ9PFQlZ26zefGBba7jjQS2gvcLeUuh2XXLKoCPJMxM566cdiGEKbBs
         Ph3WqfKyNZevPjBLMnfnS8wDykP47iq0son3tRTy4OYmoFdzE8C6XPmHnGBYQVRhUIsd
         VrUFoQTVPd8tvnaMc1+8Em69gqOfBQMHLiH5MJV7CncEs5CvNB8otRS1+gtydL3wENgR
         FUzMFAkFCGTNWeE6gLwgvxbHuOZe39cPxXn+Dpf8/HO35wYfMfzLO7Z7YBjPsArLWR1h
         NQoOTVOl7dRYLBQVa1yoJhRiCbTYsYxGHYV7KjALpSBSku5XSczH/Ei3wsmPBIe/mLu3
         wpmw==
X-Gm-Message-State: AFuF++nSMS0yuo/dbJdhSnMF+JeXbwcZBGspFqRSe7RcTo6VZWQh9tKm
	ea1LbU8kEmpw5aMueGln3Zkfb3frj5lfko0ociB46qzzBaMXVHrzui9mGjvOo+N1thxH2mkxy2d
	A3AHoVg==
X-Gm-Gg: AR+sD11zJ8lISfO3hbBnckmi4MB0XQMCmlFy/ycybCi8HInthlXXly3z2goqWtWMije
	JPk6PKAbdqGxWKNfdolWMaUuFmVkF2YfFDpXp5vqwydRscMQYhKdHIPNk42On2tps1pf/hcCXCV
	oRwS3wPguTkp5GQKIAQFeH37lhVpH0PKMgfbm+arofek02h2rgcSj41gFfwhRmiPKCtZQktOZbp
	ZHaim8gvTze02u3zG4R3lIj9bqUvi31RD5BwAsdm4YRNBIRIqQZSJd9FpcpBO4HaO+pOu0Y/eJx
	Xo3jqOXaqV3ImAzRX6aBqQCN2rmt06b/Da8JDV6BRIWfjAl3ky0+nXs9XYDC82Eo8nszzZUG2Xb
	XzMlD2tTaRQ52mLuAtcsvDBqrICmsFKYO1HziXJlamb3M5cLMvTh27AM+rGGUbz7MMxbLbxhuPu
	PvnL6Qwspv2g9q2xHnZBdVV6XpxaK9cDJFPWAu2s4ZMFx6w3CXgc9GLGHJDTTY/KvvQ2IO4c1Oi
	2ksKikYwQOsJZFJfxKaZXlg+FpqDlVEparQ4w==
X-Received: by 2002:a05:620a:1722:b0:939:1df9:4970 with SMTP id af79cd13be357-9391df9516amr83484385a.24.1787919558297;
        Fri, 28 Aug 2026 05:19:18 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391740a306sm128672885a.42.2026.08.28.05.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:19:17 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 2/2] selftests: tc-testing: add tx_queue_len cap regression tests
Date: Fri, 28 Aug 2026 08:19:02 -0400
Message-Id: <20260828121902.66837-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828121902.66837-1-jhs@mojatatu.com>
References: <20260828121902.66837-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two test cases for the S16_MAX tx_queue_len cap in
netif_change_tx_queue_len():

1. Set path: set txqueuelen to 100000000. On a fixed kernel the
   change is rejected with -ERANGE (exit code 2) and txqueuelen
   stays at the default 1000.

2. Resize path: set txqueuelen to 500, attach pfifo_fast, then raise
   txqueuelen to 100000000. On a fixed kernel the resize is rejected
   with -ERANGE and txqueuelen rolls back to 500.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-tests/qdiscs/pfifo_fast.json           | 51 ++++++++++++++++---
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
index 30da27fe8806..03668d86bd0a 100644
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
@@ -105,5 +102,47 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "ed33",
+        "name": "Reject tx_queue_len exceeding S16_MAX at set time",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$IP link set dev $DUMMY txqueuelen 100000000",
+        "expExitCode": "2",
+        "verifyCmd": "$IP link show dev $DUMMY",
+        "matchPattern": "qlen 1000$",
+        "matchCount": "1",
+        "teardown": []
+    },
+    {
+        "id": "04b5",
+        "name": "Reject tx_queue_len resize exceeding S16_MAX, rollback to original",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY txqueuelen 500",
+            "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast"
+        ],
+        "cmdUnderTest": "$IP link set dev $DUMMY txqueuelen 100000000",
+        "expExitCode": "2",
+        "verifyCmd": "$IP link show dev $DUMMY",
+        "matchPattern": "qlen 500$",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP link set dev $DUMMY txqueuelen 1000"
+        ]
     }
 ]
-- 
2.43.0

