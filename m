Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D6306B0A
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785591788; cv=none; b=ccXFPIF2r3/lioXL7jWxf1W33ynynUAi6a60ug1bws8YdUNXNQeamaMtK4EZAOJoxtzkerzAIQlXHB1dHOKvOJexxHsWTsJnoVaTTTMdRsuMdBu2eCwQ3+0Io+nPZYyJOsD8T/MnHgFdqa0m8j2ug8BEvff8+v5LQbXx/YdWoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785591788; c=relaxed/simple;
	bh=pb8bhPoTH0rHkw3kmuOdle1bI2sKEr+SbI9ru9+uM84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXRDvg55UWN/NZVPUSFfeYAiz3pN7ChwlqWO+fQ3UI46wOcgxU1yh3DnFdrTv8kkM+VEVCs3OyYOj1gCxSUqmOu757f335aoXvPmDnUZAFUbPhChWDDAt987zqMZUnSUKbRK6UC4MGxM0k5OVX3wN4+q1kGN474bNF/hBqh6mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By8o/p3M; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By8o/p3M"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1716116b3a.3
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785591785; x=1786196585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TqwX7lGfwVTZrv3NkOKGPL2b4D0FBuhrUgvXr3c+0ww=;
        b=By8o/p3Mx7rHNvlCav8tDoI7GD4W3IULH5tv8iOEVPAugRVJDTnMG3fTsu1Cz4NwDV
         Wvf/1ay+jZs8FukkoIiFPcme21HgNS+dX+ncpyxgdpz7R+plZkYDIYGj4XubiBvVqaSF
         COiUfxhrvwt1eeG1I54ssPQJ5weVJlFgNBDdjwhH57xpvYUveFmEC5AE1Sjyyf4RkQXv
         whMUZYrG3nCGnWor9YWn/JwMdsZ4h9vAkJjmBuN2bIk2OWmmjaIdwxQeQZZWHl8J91u7
         ikP+CoPsK8tRBscLRWiiq65UMNlTZF38HoYT/AHVPN3QX4bt7hjjkRf62WaHvUZOi4y2
         Oqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785591785; x=1786196585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TqwX7lGfwVTZrv3NkOKGPL2b4D0FBuhrUgvXr3c+0ww=;
        b=edt2uRpiwqcvAfd7+EcnYSgyxDtba5vhxiK0q7+uaC49m/ahJD8YrVdS1nz2Iu2GLI
         xgWA2NOnMkctIvbHVWrZujLS9HFGYwCcaUfZGzpPaUt4XmEF3r9yr+0WQL64NKsmplhu
         aS3oRX+NDPc5hZhHU3lAvUPYQQqTmYkTKv72B2LMK3Zh1OPJ2nsxPh2fAQPgfTd2YngQ
         lpVC7JjeIWeUUn6krx0Y32wZi4K/Y1Tr7xPN1c0pOP5Fn77LPP6ubbBV5Bv8I70rWWqH
         UhzgCHD6QmQoAbuLiGDHMzAOoiSQFvjZefdiIHotn0txx5LZhDCUFK2W8Y5tLvmo8UKO
         lxXA==
X-Gm-Message-State: AOJu0YyEidzUF6SCh50KZo3O0IYas5I44K/XYHs9VnSsGQAyu1rC0p++
	ygQ+Tf80NA32hwm0irqHJ+7kYJnfIk9M+ppP+BXZ8/hwKRzO1Xpuk5DU40WmfXhc
X-Gm-Gg: AR+sD12bdMZwhKRzFwbzZmsiBkgDIcWmDaVQjzWf/Jw6CgHCvHL5hhW5aXwoiehC32R
	hD8aCyv9JaeOBAPmfgD7Myxsdch+DwfoDsg5ud2MBBWV6++ynCBH83wK/xj0GFIPUTU+/smb+Ng
	CrWZfGrpjXIZlS03XEyzhS1UIgYvVPITGDoYiojlEUWqdJT1cPZA5M4UR9FwnlSpP2Y4noGxdpm
	elODVHvz9Nc7/sRFVOml6NsCNLLniKzDpx5xZRieqsxgVIQInEpd70aXcxuWn8vOirva9ZVMWIQ
	2pHjtPKRaH2euLZVl+c4Ov859YAJbvd0ck30iZ9XAnokgDwBsjvBpMq0XKBFFYxBzA711coGhzX
	fnP/linIoxXYK/8CKVAI/Iqp/mUowXdJ8a5JUgVzCxZJOJPDh36BGBeaUiM0dhhLYTnYUhKL47F
	Su28l43ZL74MQa+HiS9h9uVmfyLzFZyN5RQY9F3oKB8oB80wnr3k8etgC5sk1+y1+DmJrd+/pEl
	L2z
X-Received: by 2002:a05:6a21:10d:b0:3c3:954d:279a with SMTP id adf61e73a8af0-3c92a85c84dmr3413623637.33.1785591785010;
        Sat, 01 Aug 2026 06:43:05 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e5b0sm16077652eec.1.2026.08.01.06.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 06:43:04 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	vega@nebusec.ai,
	milkory@outlook.com,
	enjou1224z@gmail.com
Subject: [PATCH net v2 2/2] selftests/tc-testing: add qdisc hierarchy depth tests
Date: Sat,  1 Aug 2026 21:42:34 +0800
Message-ID: <5cc2d26a7c8e553759cdd29a3116f843fabc25ba.1785434373.git.milkory@outlook.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785434373.git.milkory@outlook.com>
References: <cover.1785434373.git.milkory@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijie Huang <milkory@outlook.com>

Add tdc coverage for the qdisc hierarchy depth limit.

The tests verify that the deepest allowed hierarchy can still be created
and that adding another child qdisc below it is rejected.

Signed-off-by: Zijie Huang <milkory@outlook.com>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 .../tc-testing/tc-tests/qdiscs/depth.json     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/depth.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/depth.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/depth.json
new file mode 100644
index 000000000000..48f8683f0d1a
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/depth.json
@@ -0,0 +1,74 @@
+[
+    {
+        "id": "ad43",
+        "name": "Create qdisc hierarchy at maximum depth",
+        "category": [
+            "qdisc",
+            "depth"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: htb default 1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: htb default 1",
+            "$TC class add dev $DUMMY parent 2: classid 2:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 2:1 handle 3: htb default 1",
+            "$TC class add dev $DUMMY parent 3: classid 3:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 3:1 handle 4: htb default 1",
+            "$TC class add dev $DUMMY parent 4: classid 4:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 4:1 handle 5: htb default 1",
+            "$TC class add dev $DUMMY parent 5: classid 5:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 5:1 handle 6: htb default 1",
+            "$TC class add dev $DUMMY parent 6: classid 6:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 6:1 handle 7: htb default 1",
+            "$TC class add dev $DUMMY parent 7: classid 7:1 htb rate 10mbit"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 7:1 handle 8: htb default 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc htb 8: parent 7:1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
+    },
+    {
+        "id": "c519",
+        "name": "Reject qdisc hierarchy above maximum depth",
+        "category": [
+            "qdisc",
+            "depth"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: htb default 1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: htb default 1",
+            "$TC class add dev $DUMMY parent 2: classid 2:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 2:1 handle 3: htb default 1",
+            "$TC class add dev $DUMMY parent 3: classid 3:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 3:1 handle 4: htb default 1",
+            "$TC class add dev $DUMMY parent 4: classid 4:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 4:1 handle 5: htb default 1",
+            "$TC class add dev $DUMMY parent 5: classid 5:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 5:1 handle 6: htb default 1",
+            "$TC class add dev $DUMMY parent 6: classid 6:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 6:1 handle 7: htb default 1",
+            "$TC class add dev $DUMMY parent 7: classid 7:1 htb rate 10mbit",
+            "$TC qdisc add dev $DUMMY parent 7:1 handle 8: htb default 1",
+            "$TC class add dev $DUMMY parent 8: classid 8:1 htb rate 10mbit"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 8:1 handle 9: htb default 1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc htb 9:",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
+    }
+]
-- 
2.47.2
