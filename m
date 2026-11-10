Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321049;
	b=PZUPHvJNEGQjLWXZUtTdq8ReX5EHq5vm8lgz2yiRWs8Ap+lj8LJRRGAlBrwDvVF71JJE
	 uhTpZl8gh51FsUnGA9qNEgU7Sm+xD4UBNtdyCpgSU0mbYZ4cA0WUKs2Wojdf/4Zvjp0m+
	 eRxv6XD/jh2Rf6oBidbgbxiTrX6YxNqsueRFbiYEuXBa981Q5KRcaaITRaoBWVkab3ggW
	 elwRjO+QMNWtNhzV83YSIZq/ssD68CSP6ZtkKgWEmlCtG/jFW7mKTEWaD59ge4gK93pLL
	 o8LCXB3LPiQa0equd+xNfsPHpQ4S0wWt5Kxnw6DxSVWDYWVKznU88cC/DV9sMlhogIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fNa1xdEpmbFyF+l7+hVWyqNLuHnz9gH2/3mfUuMmMKk=;
	b=icaY3ARfD5u3gwJFSzDJS6Tsz9gdSkUdMckivN1aKCb27AyJcghrGDV9RyNCbPGqxGEe
	 Mb3YSBdFrsN+PAZYYn/3SRaqb9w5hQ8sY7nkpU3g7Rwm1kP1MtSIqaMDeC5cG6D0hOVr4
	 ALUsC3gz4spcKec83m3+rePeS40sOBFkn1s6r1i2HICGloqp2gTzA4xjGSdDEZim13ypM
	 t2eQWSQT8VBoP9+tBSFjt8pmUbYHNiRFQOvcDsitwdTfTDOYKx6mj3e2VA8pni+tw60/8
	 bh5Pz4WNeZN/gw7TDbflng1LHzBjM1sacK7SULCq02XE9qVXJ3gh2a35EhMkf4J7INw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XR6RH6OK;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986AC606A32A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 986AC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XR6RH6OK
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b31ca7e0bcso22495907b3.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794321047; x=1794925847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fNa1xdEpmbFyF+l7+hVWyqNLuHnz9gH2/3mfUuMmMKk=;
        b=XR6RH6OK9rS7MD0YNdgakcDVnUQA5ha7kPxRUv+fVLWrLDa5abyzdfuTKrO+ckSYEP
         VaGI5QlpYPI3RGpGSQcnpeLEIljaIe/4G3rtwEfkDACzvR4waOAzkaFD4hzFoqvGWe4U
         qrQWfVmST04G+ay4UFtzFmY0MiX4qaoEu9Qc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321047; x=1794925847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fNa1xdEpmbFyF+l7+hVWyqNLuHnz9gH2/3mfUuMmMKk=;
        b=KjVl8k5NZm+vitKcoMTg4QSAMEo5yQXmKHMHQHYEXiL4ORGUGc9J3NArayrzQL50Lt
         XFHikuXGjPggoWsSlVgRii71fGmWIAlA7t2gmT2WpXFiDWIKtc0+3IIuE1PZRQcJwaaQ
         34hCu3MEj6DEdGb14JAkp41U/G9usElbPbNxi6Keya7PeZT9UXPiAN6iAt2o71W9+rMH
         EqaYibjCCebLPqI1P4+ZE1173YV+p5WXrZNtGzB2uO1us6LrX5StdC4+NsJqorow2RyC
         Zip/DjnS2+1OerdLeHJsyr7g5FfzjnXQkBlPLSmJCG29tyKPmmYY0OL4DccK8B97O6xo
         6toA==
X-Gm-Message-State: APuU4Z9jDRGrNYKb97/UWDsACtFOnL6i1bLvkyn8l8m4ALcicdi6ze9g
	qKXi5XEuVjgXEqBn0/JIdnhbfiR1HVHhrvPVoU0eKFAde3YSrRO0CaSdVtuONulIlrorKFkJHRr
	RQck=
X-Gm-Gg: AYBFou1h0O2mrR5qPFktmplUFrUIBLx6CFlxn/kCYfexhvGdup6QWgKdrBSwdKZC7j4
	tz/OBMLtYTdAcYDQu9SIVvlQRcBLRMt8na8LYqv3GpJHifyIhI11VlhPxTUB4RKX9UZCdt7hiNJ
	+UQ6m7wf1ZlTy/Zr/DJZRwoKn8XzVqCRcqz5GjX/mJPcMKY7Rym3gXjh+0OOwfm2e+7iNDaxARL
	EHBLm88FXhRdx0A7loV3SuFPtDG3QdnsG/RRn/A9bcbhdSKAUQ6L1PdZrgeFsMxIVn+D97ljhuv
	hu0o/illQ2RbA1bnAu4v/9hmFWVkHpN45mhjqbkV1yKw3+yvlG/dCoQbgKy5gIpDu4dqLD1f2at
	35tAzhQs9cVhAGC12qNHQg1WvrhWsk7EB6dAYNns+qoj+daHR4JOcu0DLqFfycQhq4NLi6SWg67
	r9jK4LuQQhzOSbTLmDXu38k+O+QuooXvM3Almnq+dozWI4L6L4ea+pqMdQcDKEisfJ6qg9V9rij
	3SJV1PD2KOBXjV6lYzbkYYPrFxzlquhP1SUXEaJM61Et1Cxp9JRttIBdE21dBlYmruEnpz0eQ4j
	Idw8eHUQsVKeeQ==
X-Received: by 2002:a05:690c:388:b0:8b1:1daf:a54 with SMTP id 00721157ae682-8b392a6f927mr16383617b3.40.1794321047453;
        Tue, 10 Nov 2026 06:30:47 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4d67::1c9d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393479120sm20091647b3.45.2026.11.10.06.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:30:46 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 3/3] selftests: tc-testing: pin DRR and ETS deficit refill semantics
Date: Tue, 10 Nov 2026 11:30:25 -0300
Message-ID: <QDISC-TIAE.v3.r0.20261109173518-3@mojatatu.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <QDISC-TIAE.v3.r0.20261109173518@mojatatu.com>
References: <QDISC-TIAE.v3.r0.20261109173518@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that check the DRR and ETS deficit refill, so a change to the
refill loop can't silently alter the result.

The cases:
- 3f3e: one DRR class, quantum 256, sends a 1514-byte packet; the
  deficit ends at 22.
- 57a1: two DRR classes with 1514- and 514-byte packets; the 514-byte
  packet goes first.
- 2177: the same as 57a1 under ETS. IPv6 is disabled on the device so
  its router solicitation doesn't land in a band.

57a1 and 2177 put netem under the classful qdisc, so they log the usual
"non-work-conserving?" warning. All three pass with and without the
previous patches.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/drr.json       | 82 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/ets.json       | 54 ++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
index 2b61d8d79bde..d7ac32294738 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
@@ -86,5 +86,87 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
         ]
+    },
+    {
+        "id": "3f3e",
+        "name": "DRR deficit after refilling a 1514-byte packet at quantum 256",
+        "category": [
+            "qdisc",
+            "drr"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP addr add 10.10.11.10/24 dev $DUMMY",
+            "$TC qdisc add dev $DUMMY root handle 1: drr",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr quantum 256",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem delay 2s limit 10",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match u32 0 0 flowid 1:1",
+            "ping -c 2 -s 1472 -i 1 10.10.11.11 -I $DUMMY -W 0.01 >/dev/null 2>&1 &"
+        ],
+        "cmdUnderTest": "sleep 2.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s class show dev $DUMMY",
+        "matchPattern": "deficit 22b",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
+    },
+    {
+        "id": "57a1",
+        "name": "DRR serves the class that fits its deficit first",
+        "category": [
+            "qdisc",
+            "drr"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP addr add 10.10.11.10/24 dev $DUMMY",
+            "$TC qdisc add dev $DUMMY root handle 1: drr",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr quantum 256",
+            "$TC class add dev $DUMMY parent 1: classid 1:2 drr quantum 256",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem delay 3s limit 10",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 20: netem delay 3s limit 10",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dport 1111 0xffff flowid 1:1",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dport 2222 0xffff flowid 1:2",
+            "python3 -c \"import socket; a=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); b=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); a.sendto(b'A'*1472,('10.10.11.11',1111)); b.sendto(b'B'*472,('10.10.11.11',2222))\" >/dev/null 2>&1 &",
+            "sleep 1",
+            "python3 -c \"import socket; a=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); b=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); a.sendto(b'A'*1472,('10.10.11.11',1111)); b.sendto(b'B'*472,('10.10.11.11',2222))\" >/dev/null 2>&1 &"
+        ],
+        "cmdUnderTest": "sleep 2.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s class show dev $DUMMY",
+        "matchJSON": [
+            {
+                "class": "drr",
+                "handle": "1:1",
+                "root": true,
+                "stats": {
+                    "bytes": 0,
+                    "packets": 0,
+                    "backlog": 3028,
+                    "qlen": 2
+                }
+            },
+            {
+                "class": "drr",
+                "handle": "1:2",
+                "root": true,
+                "stats": {
+                    "bytes": 514,
+                    "packets": 1,
+                    "backlog": 514,
+                    "qlen": 1
+                }
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
index d2eab61c099a..ea3adba2f06c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
@@ -1007,5 +1007,59 @@
         "teardown": [
             "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
+    },
+    {
+        "id": "2177",
+        "name": "ETS serves the band that fits its deficit first",
+        "category": [
+            "qdisc",
+            "ets"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP addr add 10.10.11.10/24 dev $DUMMY",
+            "sh -c 'echo 1 > /proc/sys/net/ipv6/conf/$DUMMY/disable_ipv6' || true",
+            "$TC qdisc add dev $DUMMY root handle 1: ets bands 2 quanta 256 256",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem delay 3s limit 10",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 20: netem delay 3s limit 10",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dport 1111 0xffff flowid 1:1",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dport 2222 0xffff flowid 1:2",
+            "python3 -c \"import socket; a=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); b=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); a.sendto(b'A'*1472,('10.10.11.11',1111)); b.sendto(b'B'*472,('10.10.11.11',2222))\" >/dev/null 2>&1 &",
+            "sleep 1",
+            "python3 -c \"import socket; a=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); b=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); a.sendto(b'A'*1472,('10.10.11.11',1111)); b.sendto(b'B'*472,('10.10.11.11',2222))\" >/dev/null 2>&1 &"
+        ],
+        "cmdUnderTest": "sleep 2.5",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s class show dev $DUMMY",
+        "matchJSON": [
+            {
+                "class": "ets",
+                "handle": "1:1",
+                "root": true,
+                "stats": {
+                    "bytes": 1514,
+                    "packets": 1,
+                    "backlog": 3028,
+                    "qlen": 2
+                }
+            },
+            {
+                "class": "ets",
+                "handle": "1:2",
+                "root": true,
+                "stats": {
+                    "bytes": 514,
+                    "packets": 1,
+                    "backlog": 514,
+                    "qlen": 1
+                }
+            }
+        ],
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
     }
 ]
-- 
2.43.0

