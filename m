Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004C3B8124
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808917; cv=none; b=CBNn+y77MrywBP+OrknGyp6QHHUvt7YoPo5s7llpTApEbwU96hdPPKe/3uQM+FjqRdYL3yQwpyPQ8vknyMntrqdALnj5+0sgDuc0mtncWz88JLft4RrJC7hJs0ozZaT2TssElovPEmPqyu7Rjq0r5gjd7hsAfQY7F0lWlpqH8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808917; c=relaxed/simple;
	bh=OelLpbHEdpJZpWvgUPYRAzjQfVmJvj8l77QsNWxzT3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BatO71n7jIUFZVoR0rxqKdtaHVhdf0ATJZ4aggHVRzYQcb+xSrbYHy1rsanQqmZF+VF+2M4/yEttyh1nIiXHXwELlqrZwRfi/7gmOM00CpTPX1D2E1LrebQF2f7cC1v6B6r/yOf9ZfUAWqYTz/G1/d/Fl9tD96poyBWYCTttR1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cIt8vV53; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cIt8vV53"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8726acc5eadso25888727b3.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788808914; x=1789413714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wnv1VkT73C/Qyd3I7Nkg2rbMnLX8mIVt7iuH9fy1zv0=;
        b=cIt8vV53UTU5rt7DohFSkfTxwSY3DxR/IkjCiNOy6hRVS5/U3q+sUDgbkF4p9TcJ6z
         Bd7oeeUCpgwkr6IAd5bwPVtipihhQNq+VCKpfJUQyWn5FiEbsZeyrxef82FXG1cI2o+l
         O2Mt8X6N091rpFbdZagYZF5RkBDTvLdBpvvkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788808914; x=1789413714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wnv1VkT73C/Qyd3I7Nkg2rbMnLX8mIVt7iuH9fy1zv0=;
        b=T+yh/NuA2JuiUNptPgHytKgVawq/LvUbNaxp4Sd7dUqVRVKyxhAGxmIT5mWj7OER8t
         HGHB13FVACrpbs+MmBcQRp/uBLsTY8kudvCn631BL4HxKu7C43ox4vxpM3I3Aq39X/r0
         tpAiDIGRl7HrQOXJPKDlBEE+YA7BwH7IbXCpfkKLsbcXy5bxrBF9GhtcTflgL7zJHx+i
         /7gj+dZJQUY3dCztRhDWx7M8eizzq8Vg5Mp7DTJ6PFFrXKYZclZgwMpX4LFGuQqHfKpr
         KPmcZmV7Jbd817WsQ/MvLkzTo4zHOE9gJcfHfVcMgWwaF9Qe0PaQsupnvzTK0jFU2TH1
         ZHaA==
X-Forwarded-Encrypted: i=1; AKwUvBy4sfFaMsV2rVJf+fimGvA9k21wCf/j/y1X3cV0X8W8TFii8wWye5NbqqPVddtbnSmH8lyCQEg=@vger.kernel.org
X-Gm-Message-State: AFuF++lJxQMWGpuZ0NVPqFt+sEaRNoXea7wh+0U741DNr4PqbOvqfqQ0
	GcAGRAnuyy2zwINGcvz98U5ILMynAJbyYyKY96yINzl0kjVRiQYjH/gPvDv8OhK/tA==
X-Gm-Gg: AYBFou1m+XKie7PlXODB1bk5w60+/JZZDnS4gBbIaVuSEQ3MrIRNzJ7RtUoewwfbnj/
	+Ms4SXY7vmdgIN/sM/5czCajH6Cgl3VRc7J7Ss3z9IHb9Br4j22wPXgDDE/CoF/yoXZV/RdKXhL
	7rWXnPCRQgpmkgDvsaSE30ygCDXw7qauaTUBxrc7Sz9aYPNv4cPJ3Ts1SdD58NjTJN9n5hWM2tY
	zxHJIcwI/UTCl0qJPz38cFbZG6IZsmRzfZStFVq7k/PADx89OYRiOdeV62rwWkNhdqt2gLHw1W/
	yK/4pbjAFpQ782am7AcXTAEvrGkYI34SpLRQH/3mez5E0Kd+ZY1X3zgOwsn8lb72zzPM9mCmpMl
	CZFQuhAaXa4ykWY3C2C8ktr/uEQudRV1o1p7dYiGQxfsWK74wMd2YuNl+dd2RY0uB9mUuVDKAK+
	2UxhQo6BTg5o9dj8swfkzFSK3Px41sO+7A58Q7CnAFNTJ2qEGiBEYa7Q==
X-Received: by 2002:a05:690c:e3ce:b0:871:8a81:a2c8 with SMTP id 00721157ae682-8718a81ba30mr89939177b3.22.1788808914383;
        Mon, 07 Sep 2026 12:21:54 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62bc77sm76546097b3.39.2026.09.07.12.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 12:21:53 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: horms@kernel.org,
	vega@nebusec.ai,
	netdev@vger.kernel.org
Subject: [PATCH net v2 4/4] selftests/tc-testing: Add cls_route bucket move and change tests
Date: Mon,  7 Sep 2026 16:21:33 -0300
Message-ID: <20260907192133.2639067-5-victor@mojatatu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907192133.2639067-1-victor@mojatatu.com>
References: <20260907192133.2639067-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 4 tdc tests for the cls_route bugs fixed earlier in this series:

- Delete a route filter that was moved to another bucket (a7d2):
  Validates that deleting a filter, and making a bucket empty, does not
  leave a dangling empty bucket
- Try to change a route filter onto an already used handle (c05a):
  Validates that attempting to change an existing filter's handle to an
  already taken one fails
- Replace a route filter that shares its key with another filter (3f21):
  Validates that an in-place replace keeps the handle userspace named
  the filter by, rather than dropping the 0x7F00 bits from it
- Replace both route filters sharing a key (9d0e):
  Validates that replacing one of the two does not make the other one
  unreplaceable

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/route.json    | 210 ++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
index 05cedca67cca..2d5843aebd72 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
@@ -202,5 +202,215 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 parent root drr"
         ]
+    },
+    {
+        "id": "a7d2",
+        "name": "Delete a route filter that was moved to another bucket",
+        "category": [
+            "filter",
+            "route"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 100 route from 1 to 1 classid 1:1",
+            "$TC filter change dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10001 route from 1 to 2 classid 1:1",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 200 route from 5 to 5 classid 1:5"
+        ],
+        "cmdUnderTest": "$TC filter del dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10002 route from 1 to 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j filter show dev $DEV1 parent ffff:",
+        "matchJSON": [
+            {
+                "protocol": "ip",
+                "pref": 200,
+                "kind": "route",
+                "chain": 0
+            },
+            {
+                "protocol": "ip",
+                "pref": 200,
+                "kind": "route",
+                "chain": 0,
+                "options": {
+                    "fh": "0x50005",
+                    "flowid": "1:5"
+                }
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "c05a",
+        "name": "Try to change a route filter onto an already used handle",
+        "category": [
+            "filter",
+            "route"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 100 route from 1 to 1 classid 1:1 action ok",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 100 route from 2 to 2 classid 1:2 action drop"
+        ],
+        "cmdUnderTest": "$TC filter change dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10001 route from 2 to 2 classid 1:1 action ok",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j filter show dev $DEV1 parent ffff:",
+        "matchJSON": [
+            {
+                "protocol": "ip",
+                "pref": 100,
+                "kind": "route",
+                "chain": 0
+            },
+            {
+                "protocol": "ip",
+                "pref": 100,
+                "kind": "route",
+                "chain": 0,
+                "options": {
+                    "fh": "0x10001",
+                    "flowid": "1:1",
+                    "actions": [
+                        {
+                            "order": 1,
+                            "kind": "gact",
+                            "control_action": {
+                                "type": "pass"
+                            }
+                        }
+                    ]
+                }
+            },
+            {
+                "protocol": "ip",
+                "pref": 100,
+                "kind": "route",
+                "chain": 0,
+                "options": {
+                    "fh": "0x20002",
+                    "flowid": "1:2",
+                    "actions": [
+                        {
+                            "order": 1,
+                            "kind": "gact",
+                            "control_action": {
+                                "type": "drop"
+                            }
+                        }
+                    ]
+                }
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "3f21",
+        "name": "Replace a route filter that shares its key with another filter",
+        "category": [
+            "filter",
+            "route"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10101 route from 1 to 1 classid 1:1",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10201 route from 1 to 1 classid 1:2"
+        ],
+        "cmdUnderTest": "$TC filter replace dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10101 route from 1 to 1 classid 1:9",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j filter show dev $DEV1 parent ffff:",
+        "matchJSON": [
+            {
+                "protocol": "ip",
+                "pref": 100,
+                "kind": "route",
+                "chain": 0
+            },
+            {
+                "protocol": "ip",
+                "pref": 100,
+                "kind": "route",
+                "chain": 0,
+                "options": {
+                    "fh": "0x10101",
+                    "flowid": "1:9"
+                }
+            },
+            {
+                "protocol": "ip",
+                "pref": 100,
+                "kind": "route",
+                "chain": 0,
+                "options": {
+                    "fh": "0x10201",
+                    "flowid": "1:2"
+                }
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "9d0e",
+        "name": "Replace both route filters sharing a key",
+        "category": [
+            "filter",
+            "route"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10101 route from 1 to 1 classid 1:1",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10201 route from 1 to 1 classid 1:2",
+            "$TC filter replace dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10101 route from 1 to 1 classid 1:9"
+        ],
+        "cmdUnderTest": "$TC filter replace dev $DEV1 parent ffff: protocol ip prio 100 handle 0x10201 route from 1 to 1 classid 1:8",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j filter show dev $DEV1 parent ffff:",
+        "matchJSON": [
+            {
+                "protocol": "ip",
+                "pref": 100,
+                "kind": "route",
+                "chain": 0
+            },
+            {
+                "protocol": "ip",
+                "pref": 100,
+                "kind": "route",
+                "chain": 0,
+                "options": {
+                    "fh": "0x10101",
+                    "flowid": "1:9"
+                }
+            },
+            {
+                "protocol": "ip",
+                "pref": 100,
+                "kind": "route",
+                "chain": 0,
+                "options": {
+                    "fh": "0x10201",
+                    "flowid": "1:8"
+                }
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
     }
 ]
-- 
2.55.0

