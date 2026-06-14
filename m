Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A383264CB
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781441463; cv=none; b=cqx1zWQ2LJyfA8GREbTVHe/dcWut7iAXEVwUVzj26YOX40chRhkIL9boP8J+IjT+tLRkpLJ3kDb+9bHMJ6oitTq7u7K5AHo7PUJ+hvQXbcndbOrfuI/YQWCPDjxRtsGIKhKTy44UsyZOMYgOMEEShU+T1Vae7PbaBStQP3CCtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781441463; c=relaxed/simple;
	bh=cJmFCJ92IYSoSzax7fOGA70pUpe8oKCRnIUNCAzpux4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+eT54jAl4j/esu1cCX1RJFyQhk3xwSEGRn9h5ZZE1az4KfHhhtBKeUp5tNyRMLHVlBMcIOmEMcRwnHlALRyjXZfznv7MesbX8Ir/IHt1nBaK1CWZuUeHxEeJj8R7lUSHEuS9jUY6AaaclqIeEZHe2r8tI96HEJ5Ft1AGWrC64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGZVK2fg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGZVK2fg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c3543590so16611195ad.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781441462; x=1782046262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtT+TuK8jetIMA+MPsNEijp3ifUb+mwfZ0dCpHYIdO0=;
        b=dGZVK2fgHVUd967jC5QhH6007RmlsczXs6joJD0W4+r0MRJTNya0V9P5j5s+RTj7tK
         lyoKBg0OEnx+O37GU4KxkLB13/TJ71IpzK/tP12WawFCWxS89H/jnSp3NQ0mQzoVi15l
         x9KwTSVbfKNx+qR2gPAb/54FTIwlE2E4Mi7ntj0nbgXK+JLIXMHoPwiAYuqVixDwwFA3
         mbUi/3c1ymSTyZyWoX6p6zVYfqtpR6hiQmODsXICI50tFDKZ/N5ilLEACg5kZZTjZiu2
         polpY3wn+XDQ7qHHjnHefK+4wsEJ4BZ0lPBbW7RrpH7vMLW2YcqTa91ofFnpEeCd3DiM
         cyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781441462; x=1782046262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MtT+TuK8jetIMA+MPsNEijp3ifUb+mwfZ0dCpHYIdO0=;
        b=Nt50S1ajHL0PLUlOZeT31dvMujOc9z0GjWa+qIhPx38iKPDef5L72UruFGQQpJfx36
         VH3X2zYJ2Kak2gZqBoH6SlNr0LyHIaime8bAAnY/IW4/wjaDhICrkQFyVlJ984R3Hy29
         zJ1SBYaQCnXWXmcMnVUwiBSu5GrcVVc32hXwM7v3HoqoPRlBHuEhJqGKyitnoiwS7g5q
         2bqBOaOI0KEEQMJ/uZN+vihYpfH4O0eHTPaxr2HnxQpSJRecLeyOkidqhinie4o1FDUb
         rBlhNm1g+brYrJ6yswJjcmA5QRvBsb1ajbtHTPNRSeCCqEM0hXqkIJBeN+s2zBDsaFN1
         bIWg==
X-Gm-Message-State: AOJu0Yw0G773x+Q1TPLo0xv8E66+Dfwr3GfcvxS8KZxXN73rUQQZz9Os
	7tNm8UgKL/rHNmp1E1ezypbr6CvuU+Ix6IVQwlxmgvetHHqaQa9+c0U09bBN1BGfFfgdiw==
X-Gm-Gg: Acq92OEybwCk/dElg+SoIANMH5/KkAD+rbT7RQN0Fr/oUMAF5pMqsef+3rSR3vPZ/pp
	ao25OZ791PQqqbrhVCMHSE26S0nIsOXHw8gg6xuUMruRdtgO3N8wfenN4nidKmXW5Nd36kF32L2
	cCbt+x+7yuXrXkR7mRJpaz03cyTK4SGpBX9iyVgmtUt7Ez9F0+LTTrWBQ5cAqKMMHy7uq6o0sHh
	Z7c1gmblWUDXIq6Sej/ET4KqhPLPrBKq4wrT91Aq5oNO928fQbu0N+00241B4eicrUPSfM65Mgr
	2ZGIEpz18rJ9s8oTsAlcn2K1o+o3GlO2Ay8y0DTF6P90VQ9nbYu9MexhoYQvcXfMA6FzidPmc3t
	QqnOZVhf3Fp80xYeVZupBsA9iBlhMffHeswMs4+atFbs6Gy3sAGIRhv9jtKHd7w1QoQJZ8273LV
	T96Hzx3ipsOZ43FJZNe+MaKBrR8p5a+tBo68NjZVC83ikXQXWkKw==
X-Received: by 2002:a17:903:8c4:b0:2c2:5446:30eb with SMTP id d9443c01a7336-2c411b7e5a4mr108765355ad.11.1781441462014;
        Sun, 14 Jun 2026 05:51:02 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:90b2:9957:66e9:8cb4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac79fsm66426825ad.45.2026.06.14.05.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 05:51:01 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v2 2/2] selftests: tc-testing: add fq_pie per-flow class stats test
Date: Sun, 14 Jun 2026 18:20:00 +0530
Message-Id: <20260614125000.6058-3-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260614125000.6058-1-hemendranaik@gmail.com>
References: <20260614125000.6058-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tc-testing entry (id: 83c0) to verify the fq_pie class ops
wired up in the previous patch do not crash and integrate cleanly
with the tc class show path.

The test creates an fq_pie root qdisc on a dummy interface and runs
'tc -s class show'.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
Changelog:
 v2: No changes from v1.

 v1: https://lore.kernel.org/netdev/20260531125314.22492-3-hemendranaik@gmail.com/
---
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
index 229fe1bf4a90..88139f429430 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
@@ -40,5 +40,27 @@
         "matchPattern": "qdisc fq_pie 1: root refcnt [0-9]+ limit 1p",
         "matchCount": "1",
         "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
+    },
+    {
+        "id": "83c0",
+        "name": "FQ-PIE class stats accessible via tc class show",
+        "category": [
+            "qdisc",
+            "fq_pie"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY handle 1: root fq_pie"
+        ],
+        "cmdUnderTest": "$TC -s class show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s class show dev $DUMMY",
+        "matchPattern": "class fq_pie",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.34.1

