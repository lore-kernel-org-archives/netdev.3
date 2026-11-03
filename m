Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706646;
	b=gZBDheM9yV80fcaOz1WkkKyo7wPSQpnvSzIx2/QP8+FLtn69ChaXGuCIgbwsCQMQHQJA
	 YR5TS5DNC2HisTPqzipxa0SwQnjc3BgxOseK2RFqVRhfidhYc1VU/OY47whQsinTVq6cP
	 rUNiLBwt7l4ALH/C72h64H66aLfYQhh+ngvVEjeNDQHiaDzi/QLFsUsEhGzeUrcBG0RMb
	 v6OFtsbrixK2hqQ+XgkJbE4YN5PpY/9NaqHuymR3jN6+wardC4+aMy+N126b59BAm0LsV
	 iQ1vJad4x5nDrwAl0HFaKsNILMC1FYSmlHt2VCPd51VouIsodtKAU6yiPIeQeS3zMCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nThnRv+tQWDotBuaHZ0Ov/cwqSLDBqK3gIAiHpLtLQI=;
	b=TZMe997HfngXfLXp/oUn9g1drour7SOh0Q4xiqTymGo3gQOzNqxBUKNjz7o6k/GkIyBr
	 4bAVcKArqZz8tWWO5vn60P61gWXSA5ZaS5mSG+wcHhy6I2tmbeviyTwt8JGnPxhj2IXLA
	 vZqncqKTFwZ9bvpcP9hbW/wOMc6iY6F1jhq+CG3a8Y5xBOPWxyRrMMU3AmrvOOVGVVgSc
	 R5YhsE9uib6cP4+kB0Id5oJAYIERHN2sIWRBJJExG2s9U9A0tfvFgE0GPQTz4ERllnR3/
	 NrgIjmg971toBqr/O+yoMW2hp5QHcWyRQiLm3WKklLJl5TKKaurJZE5pe/ZeBndtgdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=fT6ZHcbN;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B56082BD9
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A32B56082BD9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=fT6ZHcbN
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b300713befso2043627b3.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 03:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793706644; x=1794311444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nThnRv+tQWDotBuaHZ0Ov/cwqSLDBqK3gIAiHpLtLQI=;
        b=fT6ZHcbNxQ0nvZypckGeEvAuNUWNmRFthPNA/j2/pDDVWlc5tTUTQl5h/KHya6UHPY
         yt5h7DrFMFYk1ImiMExJRjqyAbZ3U7PWwZf9Ld5O8a75Hsn0IXmRODj6yfr6NiKHWVi5
         EnOaYjAYFpiLwsscj9h6KEhEWSZy8lUeiqD1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706645; x=1794311445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nThnRv+tQWDotBuaHZ0Ov/cwqSLDBqK3gIAiHpLtLQI=;
        b=eyjRwba+NExDyJHUuW6N6QokQ2EKObMAD/GzqT8ksjptQ883s4EuxqVOVdUPEpKfQs
         /SUPm/L8DZlnsVDTg5GVzkOswZ3GsukD+UkJu9+lo/IUAD1nqiBWHwv8AwHTmDDiPHYe
         vYj71yPKU/Ljim+KAeNehoWoI0/b+8ibRJ8FJ7cHbg60pXbdc/GLPq1ILEwHWQ9f91Qg
         zT8tZZ3cgadXouua4Ld5JbxZ+E7ZnOyiWIjOy60qjMYAxBiuOcP3ApMDOIGN/V8L6jVQ
         nQaAGO1bZdfKbCNvn6wgZpCxfaLbuHRGg9Y+adN/oZqOb+SVOT/NUS+da1X/U8PvNirc
         e7gw==
X-Gm-Message-State: APuU4Z/8n8zHFUXtG6VAJr4NmpNUfs9nzYMkC90A+eFr/j4WgPiX6NKV
	31l6oUXORs9FCQcQ4PD6hJzchH1J9s6DkrZqcLklDfVWXZdpPLdMH9/npEdMBUAoMebyiBEBrhQ
	FH/I=
X-Gm-Gg: AYBFou0MpQ2eUM7vuKEJa1cX8l4Noy0cgp3OuJC5+Mpdx2fVNQX8bCXlPx17Ow/gltZ
	4uPJaXGoT7ZEY8uyltrPxK+7EJKO0/cVIu1tmKN0lriwtBAuKxULXWkP8lN9mhkIRHfoqynYREZ
	AHfnZAD5WPJ2oyE2uJ02qtVnRmba9kpmLXVDGLbN/vMyHV9v2Co0x3Or8z99LWr1BfnhuM9ZRzQ
	SwSiIxLOZTWPnxRzFQ6/Q59zVWW/n8kZ3A9HR+Ky4+mXoSIIClZbhMJN7NUPo86RC3zWCxtnlyj
	vXnYQ70q3qPi9dfa1xH45JK+Nqt0BPA8uyZ1KukM8Ck6+neqNmTgh5afFqtdi+CUfP18FQ4hZJg
	lJXlCcql3LBczUA3E+uVOiYsYDMYcw9/ZIbYsHmp47DeWwURawicekwVc2WGkAPD/BP9Tay4P8h
	0etVq86lyBB75VSm4iMb0fk6jbhrsS1+f2UqU85B9jJkrs7WE2xj5SQNpl5KGy7NU0U0vQFo2NN
	PVLBjwO59fJvZ3D5jJJ/0vmd+B4GkQgwUuT6RI2bgkOcUTQ1ta584lY0mMVNa7xi+yMWlKlay6Z
	fcELiDrUt3C2lEJTjgPX8JnZyluDQL+QsA9U0vpdXe6jb36aV/r2JRjVjYzmd0JBz9jObr78zQ6
	v/RdoOqRKBj50h9RgZuPQQEwLbDX6Chn9QFxm
X-Received: by 2002:a05:690c:f90:b0:8b1:9c2:87d6 with SMTP id 00721157ae682-8b2b66d0066mr98565757b3.17.1793706644511;
        Tue, 03 Nov 2026 03:50:44 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704d699sm70016857b3.5.2026.11.03.03.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:50:43 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 4/4] selftests: tc-testing: teql: cover each attach rejection on its own
Date: Tue,  3 Nov 2026 06:50:32 -0500
Message-Id: <SER-NSBD.v3.r0.20261103064310-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
References: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
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

Found by Sashiko (nipa) while reviewing the previous posting of this
series:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v2.r0.20261101171325-4%40mojatatu.com

The issue:
Case 124e attaches teql as a child qdisc and expects the attach to be
refused. It requires nsPlugin, so its device sits in the test network
namespace while the teql0 master is in init_net. Both the root-only
check and the namespace check refuse the attach with -EOPNOTSUPP, and
the case checks the exit code and an empty dump only, so it passes
whichever check answers it. It no longer proves that a child attach is
refused as such, and the case added in the previous posting covers the
namespace check alone.

The Fix:
Run 124e in the initial namespace, creating its own device the way the
other teql cases do, so that only the root-only check can refuse it.
Attach a root qdisc from the test namespace in the second case, so that
only the namespace check can refuse that one.

Link: https://lore.kernel.org/netdev/179366641863.488856.17368571591466000274@kernel.org/
Link: https://lore.kernel.org/netdev/179366641986.488856.2193313144081673076@kernel.org/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2 -> v3: considers comments from Sashiko (nipa) on the v2 posting:
https://lore.kernel.org/netdev/179366641986.488856.2193313144081673076@kernel.org/

Case 124e now runs in the initial namespace and creates its own device, so
only the root-only rejection can answer it.  The case added in v2 keeps the
namespace rejection covered.  Each case now witnesses exactly one check.

v1 -> v2: new case covering the cross-netns attach rejection, following a
Sashiko (nipa) review of the v2 posting of 3/4:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.20261031160050-3%40mojatatu.com

 .../tc-testing/tc-tests/qdiscs/teql.json      | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
index 0179c57104ad..ab5d0881c007 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
@@ -90,12 +90,8 @@
             "ets",
             "tbf"
         ],
-        "plugins": {
-            "requires": [
-                "nsPlugin"
-            ]
-        },
         "setup": [
+            "$IP link add dev $DUMMY type dummy",
             "$TC qdisc add dev $DUMMY root handle 1: qfq",
             "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 15 maxpkt 16384"
         ],
@@ -104,7 +100,35 @@
         "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:1",
         "matchJSON": [],
         "teardown": [
-            "$TC qdisc del dev $DUMMY root handle 1:"
+            "$TC qdisc del dev $DUMMY root handle 1:",
+            "$IP link del dev $DUMMY"
+        ]
+    },
+    {
+        "id": "6a06",
+        "name": "Reject TEQL attach from a different network namespace",
+        "category": [
+            "qdisc",
+            "teql"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle 3: teql0",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc teql0 3: root",
+        "matchCount": "0",
+        "teardown": [
+            [
+                "$TC qdisc del dev $DUMMY root handle 3:",
+                0,
+                1,
+                2
+            ]
         ]
     }
 ]
-- 
2.43.0

