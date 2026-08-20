Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780339F16B
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219871; cv=none; b=fTlhog31uV2wlPzo4uz+9sGCtuswKTBngPebdXyZEQhh14cBhuXGbYznYAzytZ8X1a8CiRuM/nsbc9brn9CSt7bMLueKNAckkNdrsO4chhl+IYHLlTewidHXd6cNGyE23mo3todv5nN8SFPN2svmOmUKtezt+9xiEaMP/yRpvUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219871; c=relaxed/simple;
	bh=15Cw9oblK/D1vb486tpmsk9GW0qXeom/MxvsqfjbR04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syKx+E0X8bMNhnADj9+R7/fFPlPDmxST1Y64sZFay2KwvDldtJaBLZn3gypS+j0X8uJ5KE9Q3ZmmteFZ6hxgDx8txJVaIsV9kVTAftpXa5DUaOrM9rsMPTBrs9U2M6oJJ6IVfShqEhHZRWpH2Dntg63IIRHWUe4dRDpxfUDAruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=rseub10l; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="rseub10l"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90a6b298889so16785096d6.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787219868; x=1787824668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yWiRk4eGbnJIOLSDci/J7Dj9lG9H1Q4ou0ubiJm1Mow=;
        b=rseub10lS0f0Y8gtYUfKPx9WxIHqL/psU1Z/DPU/GbBHh9lHt3Je8B+nYTTEgUyQZ7
         ab4ZXd67lFmBnbpHcHyvtCLCVXd6Ie29YMiHleOExr9KotFwjVqCms//tgUicyNTITcU
         Yt/wvmWzXTlPUvu99T767L8M4RSdfITIXkAfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219868; x=1787824668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yWiRk4eGbnJIOLSDci/J7Dj9lG9H1Q4ou0ubiJm1Mow=;
        b=pr1nWaDmYYfU40ah0V+j0H0QqXBBQATNa3eWzEtYvqFhLCZeEy24Tf5pzGuY/smxRC
         /qCtdH//Lp5/0991rhKbf0oGkJgxpb2mri1OHPHzAeXgFcyPKriWG0Yd66UC+bQ740wu
         vj5omIL+hY+jM7V/PJOldAwhdyQMARKpIw9ieImHaZNFqWJFQHhEvIo7QAsAsc0uke0w
         TiS3UboO1+IfCgCyarKX0Uelw0tKOs/iW6TKJbJO8xlfmUi43JMyo7AW2LlaZ95avCwV
         itx+18bw9/eUmMhixBc0uW76UUm/aNYTJAY2ERHmA0RQJLX0+PD5pC6sUi6jXGuxFNc9
         K+Sg==
X-Gm-Message-State: AFuF++ngPrm4oWBiOrV71p7iWVw+DH/rwzjTEYjYwF1vTfgMg+dZnEbt
	RHl5sQQa3iKGuogQqGoO7ZA3lqdwQQ0kp4pDMEHx3fIPY4az0flqzY0di67YCk0DsLtzGptjiXO
	1RsAmQQ==
X-Gm-Gg: AR+sD10JHHD2HpIO4iQZqgBOE6kEB0sBl1jIefAnNZl3+DWXmkDBnqLZ89T9YaaClns
	DfBtTNHBV+hH/i1wnGCmYAPx3jsupIT120YfFv1XN7sjd3LvkE8Fla4U1JkCs6nk40UsdH4g+Av
	NuVd7Cq1Evr2n8aYgO5l4ksCl+BGQLE0tau7QCHbSBKeVrzuUrS6E7srmFN5fRZsaxuv6fzQClY
	9fInjB0hEEgnObypd94GHp8pmYBkJExK+S4s2HWtjRML4xjxxcX5g4dNQycXuXRnfIyBnHGGH4m
	hNayN4nVCYCB3l5y3y47+Ski28Mgws9pPRPb2h7EuQ7AG3qMLHE7mQpjlmVX65yfS7SXb+ugl/Y
	+OWdT1nJyqSaTAr0XiFOXSIUAu2fCktsi48hsb6RHHRfzDcnwv78N2F48FOLFIO/SHkGz/8X8eC
	F0K1AOX5U8hcGyxa8Qus34ynI6D+WQFnLeuLmKpN+XhcSHpqijH3ErWh556viY/O/wbzLXcEnN3
	uEtcR5af6RBhk1DMSX2LU53Wgf0e0BN5IaG5AvoyB3utw==
X-Received: by 2002:a05:6214:4016:b0:8f0:2c80:caa5 with SMTP id 6a1803df08f44-90c5eb91f13mr95769106d6.23.1787219867923;
        Thu, 20 Aug 2026 02:57:47 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2b8164sm34565336d6.48.2026.08.20.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:57:47 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	"Victor Nogueira" <victor@mojatatu.com>
Subject: [PATCH net 2/2] selftests: tc-testing: add pfifo_fast ring cap regression test
Date: Thu, 20 Aug 2026 05:57:42 -0400
Message-Id: <20260820095742.68511-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820095742.68511-1-jhs@mojatatu.com>
References: <20260820095742.68511-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tdc test case (0249) that sets a huge tx_queue_len (100000000)
on a dummy device and attaches pfifo_fast. On the fixed kernel the
ring is internally capped to 65535 entries, so the qdisc is created
successfully (exit 0). On the unfixed kernel the 100M-entry ring
allocation (~2.4GB) fails, causing the qdisc add to fail (exit 2).

Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-tests/qdiscs/pfifo_fast.json           | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
index 30da27fe8806..2cbe9738d699 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
@@ -105,5 +105,28 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "0249",
+        "name": "Create pfifo_fast with huge tx_queue_len (ring cap regression)",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY txqueuelen 100000000"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc pfifo_fast 1: root",
+        "matchCount": "1",
+        "teardown": [
+            "$IP link set dev $DUMMY txqueuelen 1000",
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.43.0

