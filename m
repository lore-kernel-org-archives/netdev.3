Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A374D4882
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473037; cv=none; b=WaLimGcqLbV0OalBXlceIuLVfrGtf9CQexBvNXwG8zeJkGokp6WDU9VDx8nM5aEeZHVI0BrBXRyy/wz4qv3A37vzXPn8YTxRNyhAAU/Y2aLaea3V5/yYY20zgj+RY8HSnqZzuPHBJLCL8aqPEpaJ35mNmRfJjGaXj0HGEYojrQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473037; c=relaxed/simple;
	bh=aAr+BrXXPvQgzHPfb246x7NqYokFUQLZsvybNAPGV3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+3a5dWN2GRQx2s6GWuwoAy51cAPBUtB48mCJ/HCzQRXfmOc7u8UDKFANFMJbgd9yj/IqbX8VAyGbwKBWeN9dms7O6Fz9YxpTunwfXSAPDJrbrD/tPziHJKZhslWZf4HQUl6zjSwn9IKxCmveneWXFpxcz55IqYdwuHC+med2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ALD33oJL; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ALD33oJL"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-988c94f1c07so2693071241.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791473033; x=1792077833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4leh7k2ZBf3659CAar74hnPJtaC6j6Ws8Ui6gvx2534=;
        b=ALD33oJLyI3v+xd36LBMi1+u84GIoK3yVrfC6dcbU9a2Pr+rPsJokZHolPh1K2skVi
         TEX/qfmX/lQ/M3mpLGgxyF0sX4WPmv/5MNs2q1nK3YY9A4mlcxUGU+ZepHUE4PXeIYmS
         A0hZUKfoMh4TSUjXAgLo2TT+z27PujQ91lGHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473033; x=1792077833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4leh7k2ZBf3659CAar74hnPJtaC6j6Ws8Ui6gvx2534=;
        b=0RC0a2TP4q1rQ+sPx1ZO5VEay2agP3yZ/JMQlUfKTnWijYxKkjKoslejXdHmCn1GqO
         B4g/Nm5WybscopkOfJ1nRX07GhHbfeORMKtqOvHWvRW5bvj/gAhFMyMQr3y8Pa5aMw0m
         NCKZPNnv3cks3B3oYHYRcPslOmS9MG+fv1QAD6eOZepyOSJjYWAz0JQq+sqyQnVagB+M
         sM5Qx8r7wwdb3s2E95IjLjs+TAMtf0K6DYHCn8Vquo3P+8hybS0Rcol4FvaGOmwP4vnP
         mzlakcSuGmufgsXUbzzbx5tew/V7psVwVjFjoWF6PeL+lhv8AYhzywVwIwX6AUkPem2N
         zIww==
X-Forwarded-Encrypted: i=1; AKwUvBy/3vgDSTgdMpYVFraa/Pmswvcdfk8x1usk14AJoeAyUyY5uIH7ctyHdtrEKDFJQzlLQwBUU7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLv+pGUXHmyjDVYoM3xK5A11YX3jZeGqaIjLmBsSZ4jMn7NT6Dq
	4WjL2wCSpa4dnZaxtFBvPqjUtEIOOSYlb6a9kcPNRbTmeitHAmY5LG5Lk7/r/zbuSQ==
X-Gm-Gg: AYBFou2UrDu0RsbphzQz5JOWrgvBA01ZokAvovUSgJhZtcAtng2HRCLUM5fbmqlOxOJ
	ZH3WICmW8M+1G5NlV2uszaRJdCd63tY/K24Bi1Y/Fj1BWoEFWP0/GyTMsxZSm4BWm4e0lKzWimt
	GyJLiDoKC75lM26wJZ6BWQeLhg97DRoVxfngEblNVTuS798DJoOiBYaY19NyqzQi5bAdtl6HgPd
	4ADrhAp+veh8QYPw+bdFW5AJqD2wGR2ODyeX8mgRADitV/eOQrJL/KiPiCLwg3dOqsb7o70d83X
	SN35JCdm8GYyKIO4tlwdVcFhomDa8/RR23drl5qaOwzMk7+VhE+MYKQmRftVCF+w5CHVJkwD5qk
	rCOm0/HuZWJFWn8o1WCKCHDQJ1IuWkj2kTbpDmD9e+NplqA39CLAT7jmgy0O3tRNaNoXwi1lbA3
	NX0N144ZQzdSh0HORaT8XcKbc0N6ppo1diqg3GF/xcHTwqJZonlmkcrFaDBAxUFYHfl64LX4bo2
	u2rkWuOJJh6sX4=
X-Received: by 2002:a05:6122:1b0c:b0:5de:4a25:f3bb with SMTP id 71dfb90a1353d-5e6d2a2ed82mr2425530e0c.14.1791473032763;
        Thu, 08 Oct 2026 08:23:52 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e6c419e2bfsm4818871e0c.5.2026.10.08.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:23:52 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	sashiko-bot <sashiko-bot@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/2] selftests: tc-testing: add DRR deficit refill regression tests
Date: Thu,  8 Oct 2026 12:23:35 -0300
Message-ID: <QDISC-TIAE.v1.20261008110502-2@mojatatu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <QDISC-TIAE.v1.20261008110502@mojatatu.com>
References: <QDISC-TIAE.v1.20261008110502@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two DRR cases.

The first asserts the post-dequeue deficit of a class with quantum 256
after one 1514-byte packet is serviced: 256 +
DIV_ROUND_UP(1514 - 256, 256) * 256 - 1514 = 22 bytes, read via
'tc -s class show' while a second packet is still queued behind a
netem-delayed child qdisc.

The second guards the service order of a multi-class round: with two
active quantum-256 classes, the list head holding a 1514-byte packet
and the next class a 514-byte one, the small packet becomes eligible
first and is the one dequeued. A per-class bulk refill that advances
each class to its own eligibility point would dequeue the head class
instead.

The two cases verify differently on purpose: the deficit case reads an
xstats field that tc prints only through its FP format string (it is
not present in JSON output at all), so it must use matchPattern; the
order case asserts the class stats and uses matchJSON for the richer
backlog/qlen coverage.

Both cases use a netem child under DRR, which peeks NULL until its
delay expires, so both emit a rate-limited
"drr_dequeue: qdisc ... is non-work-conserving?" line into dmesg.
That is pre-existing behaviour for any netem-under-classful test
(the infra 1f1f case does the same) and is expected, not a failure.

Both cases assert the loop-equivalence invariant (deficit convergence
and service order) and pass on the unpatched kernel by construction;
they pin it against a future rewrite.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/drr.json       | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
index 2b61d8d79bde..bb0995d8358f 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
@@ -86,5 +86,87 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
         ]
+    },
+    {
+        "id": "3f3e",
+        "name": "DRR deficit refill converges to the loop-equivalent value",
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
+        "name": "DRR skips only rounds where no class can dequeue (keeps order)",
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
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem delay 2s limit 10",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 20: netem delay 2s limit 10",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dport 1111 0xffff flowid 1:1",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip dport 2222 0xffff flowid 1:2",
+            "python3 -c \"import socket; a=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); b=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); a.sendto(b'A'*1472,('10.10.11.11',1111)); b.sendto(b'B'*472,('10.10.11.11',2222))\" >/dev/null 2>&1 &",
+            "sleep 1",
+            "python3 -c \"import socket; a=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); b=socket.socket(socket.AF_INET,socket.SOCK_DGRAM); a.sendto(b'A'*1472,('10.10.11.11',1111)); b.sendto(b'B'*472,('10.10.11.11',2222))\" >/dev/null 2>&1 &"
+        ],
+        "cmdUnderTest": "sleep 1.5",
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
-- 
2.43.0

