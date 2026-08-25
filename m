Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7123DB330
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645477; cv=none; b=qKWSRv3D9sHbcRwfJqZh7r8oZ7cx3TXrhJPMP2Fvj/JvvMhS25UA+tQWbir5UaVdGJw8ZMEOBF+L7gX5CcMaVHxhdTn69q+55r0Z/QahJk9/8S7e4da00PyzK5rKDl86vyZKlEzzawcyk19Unz/i2d+9ua6QzqZ1fi/eZKWMQLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645477; c=relaxed/simple;
	bh=mnbE3j/y4uO7KufvsLA0IDbzqt4v69YBS9OJCvg4IxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SU5uN2kzAUqwZho9JB8DyqQC678AOto35nzQySTkCctJW0iM4LTZcDepM5OYjPynexlnwS7hWghUmWuesk3KbZ6nOdBEeq8lci6IwGhhFA9wb2o5bRiqtElIo4z6TCqOsjtF3Wnzt/aQ2Rpz7V9JN9ZRJhb8BzMXMcmHRpBM7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Q+9AS6F1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Q+9AS6F1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52d5bfa4bafso41687151cf.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787645475; x=1788250275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKMiyC4HcRQYT7jQVt8eOBnM5eFZOvYZ0UfVOnbROiQ=;
        b=Q+9AS6F1o/WgqhOk8pIe9tqDq1IPb8qhqoLklALIER3iXPQoKUSFruVvcLLd7Yx0R+
         ibGwsJ4LMG/b9oAo2sc/XzlerJpSr3L/7yiygfO1u5srerOcZ/pqwJ8Wdd5bxg0qwnVt
         GacpWMUQUcd+Xss1ZQqoHAw21I+v/PakaDn2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645475; x=1788250275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKMiyC4HcRQYT7jQVt8eOBnM5eFZOvYZ0UfVOnbROiQ=;
        b=gbzmd+mL86oJmDhgYaHAjT8Yl4G+ETn7ArSueat34tNMFvui7IQmtxpyLWbwqLkV7M
         GnSqeQwEOthkYyBn4gk6lslVStBiqicxiRGNY6q4iBDKeht4JVEykKsV/WpKPMIQJtbt
         kPA9MfiZZ575RlJDOVs0E+M3hzyOiAiTn6elbIpHqnnkQ0preOjr87+hgCJDigd/Ty5h
         GflnbIGKWrmQ/y96Y8RpA1pjc55o14ZfRS95hYyvNL3n5YCoc8qOF+UuOkGa1OBH+byy
         4eYw8fwE6QDDT1CpE3CVsyHl9kYLMFIAfsUSSYpq0AoRl22NW+keJ5A50f+GWl4GQDTb
         1JGw==
X-Gm-Message-State: AFuF++m0OjWeQPe3o7wSl0zhsS6CRi+FIV+ctVfA25FZCw0fgeDKEh/l
	vueEkiQreU5Q8QNpuuGCpacDQ2CVanm/hUUH17zexzmoMMfk2tJbhhS06YnR/9YUDF4N8qvwn7G
	4IS9T5Q==
X-Gm-Gg: AR+sD137YhV2DvAirCiIQy4jym6eVHQ/ksKWAg7vxlgbpKOSGFuZ5ueHtPyquo2wg4b
	tDL6ZIBFNLJgT8vev/mYcsUXjDqaXUxMJwKNhe67DGAmtnL4fAgm/cdBifzhJryAk+qpcHKR82R
	lBy1stEWEavdTrXHom+w7m8Wz2mSjNuyk4E4XmN00gn+HtX16PVVlG7AIxYXZ4hwNZimD9pHavw
	BA67ZF0meTgG1utwkAIhJfEufeYD81MJRQi8Q28Xo/QZTjPSBd5eNgnJQqclFkw6zPDFqqLbheC
	7o9OPv3mdiPEwtdUpe9v9FmSKNZwBE71CO8YRAsR+sLtjA8K2pp5mvEg3GQWPXXOr63UCjSzGcX
	pf3bFqTDxQpMPWj/ZNT1jCsqy/0mNBuKcVodyc7Gp2whXv3OS1i2DFyzf5W5l69qTeXbkBTPrlc
	3KUYhwlxucru/8/U9wNDE4jLnPkJsxJ1gUauVtohxfuJpYfEcacv7L
X-Received: by 2002:a05:622a:5a14:b0:51c:1568:3a53 with SMTP id d75a77b69052e-52e2f09277bmr56123431cf.16.1787645475038;
        Tue, 25 Aug 2026 01:11:15 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09aae6f4sm64715251cf.16.2026.08.25.01.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:11:12 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 2/2] selftests: tc-testing: add u32 node ID pool exhaustion test
Date: Tue, 25 Aug 2026 04:10:52 -0400
Message-Id: <20260825081052.133898-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825081052.133898-1-jhs@mojatatu.com>
References: <20260825081052.133898-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tdc test case that fills the u32 node ID space with 4095
auto-generated handles, then attempts to add a 4096th. On the fixed
kernel the 4096th filter is rejected with ENOSPC (exit 2). On the
unfixed kernel it silently succeeds with a duplicate handle.

The setup pipes the 4095 add commands directly into `tc -b -` inside a
single bash -c (matching the existing test id 1234 pattern), avoiding
any temp file.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2 -> v3:
- Dropped the /tmp/u32_batch.txt temp file. The setup now pipes the
  4095 add commands directly into `$TC -b -` inside a single bash -c
  (matching the existing test id 1234 pattern), eliminating the
  symlink/TOCTOU risk and the leftover-file cleanup gap flagged by
  both Sashikos (gemini Medium + nipa gpt-5-6-sol-6-9, gpt-5-6-sol-4-7).
  New auto-generated tdc id: 70fd.

v1 -> v2:
- Renewed tdc test (v1 tdc failed in long-running sweep, prompting v2).
---
 .../tc-testing/tc-tests/filters/u32.json      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
index b2ca9d4e991b..e2b03f2b5e89 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
@@ -353,5 +353,28 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 parent root drr"
         ]
+    },
+    {
+        "id": "70fd",
+        "name": "Add u32 filter when node ID pool is exhausted (4096th filter rejected)",
+        "category": [
+            "filter",
+            "u32"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY clsact",
+            "bash -c 'for i in {1..4095}; do echo filter add dev $DUMMY ingress prio 1 protocol ip u32 match u8 0 0 at 0; done | $TC -b -'"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress prio 1 protocol ip u32 match u8 0 0 at 0",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -d filter show dev $DUMMY ingress",
+        "matchPattern": "fh 800::",
+        "matchCount": "4095",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
     }
 ]
-- 
2.43.0

