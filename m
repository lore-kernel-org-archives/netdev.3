Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EE38F929
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437269; cv=none; b=aBekOm3kiDTNE3ayW4mnGfnCDQGp/EFtSTNmwnrUzRJgDd812p8C/IujGf1uyvxlj3Pz3APj/O01N8su5hx6ECn3lTogjn6C8gGxaiC+sE3RpPIIvOYBK4GsreBGnB9kwJB8jYIcU2Z9U8WxYYNZuS/Axjmg8Xb3wBaydTFljME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437269; c=relaxed/simple;
	bh=mcRUefXbq2vdLhI9DYOmodziQrFkQso4FtnaoRZk8As=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnufFsxbdeM5yVIkSvSd+cV9N0TRYAPLkmwmMstCiQ823Gydl1pwaQP75P/HDuOjNKfyPXRhpKCc5aC3H2XJnDwx16Hqa9ktaLvqeEXfrnN0ddCELwjUnsIWUvgryDh7IyXya9nO4Z1uQd4/amxy8njBUM19Z913OW315uBiZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=sCb+ISvx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="sCb+ISvx"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f186025973so22917776d6.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787437265; x=1788042065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=io5C1w1GYj6CXvl65B79E+wOaWgBuAynXNmwcVVwEvY=;
        b=sCb+ISvxAZZ5RaXQ4PZjuQ1xxJTuIrv6e6m0jdsxmhmP/luJWy1eY328OxwHOc1izn
         nBtuczwAoVPiPqyfj6EH8+VO1SCAzog3AHOAcbkNnqm4U17wL+9MJt2VPL9yp3sTnEi8
         thnkFoYaWmTeqStItLVtL3fKuvfeHE48EcAAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787437265; x=1788042065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=io5C1w1GYj6CXvl65B79E+wOaWgBuAynXNmwcVVwEvY=;
        b=BOmmB5e8ToPhVQInGnTm3W1HMhEOFbBXd3h7FC4cdmSDt2uoxgTUz/z7+uIXcgRJRu
         s3U22uKta9cTo9lvJE7TbMAtDLdfsGIcUvYWTU8qH3GtS4ZPCCOs5qyi/KVclkez+9xm
         Rtl8v1TYmNsVBcJJJgG3XyO4rQCrAY4wUOpEzuMwzmG77+SLG3QB5CCP6cK2z+0qH+My
         0CfC1ycjWr53E1tZCzlEzz7olniUShNpM8NDlJbTOMZt+npjUJSSyvly8tjn5DdP7fTn
         vKYrL+8G7NlD7ilVakQs7bwqahgHbUUUlBMzP1U0Nhfr2uewedawBKtcbPkug2PFGgsl
         plgw==
X-Gm-Message-State: AFuF++kop+7Tp/cuMs2faL8XtUqMpzp8pIS4FNhL3H33eDdrtRHEEAI/
	7KmGeL/mGc5f8tdWRWz8OyH+Jq7Mom1u7rK9+D+S29sz5JWFocGrNfIQAeriXrBuTanPo3AnVGB
	G+gD7NA==
X-Gm-Gg: AR+sD12xz3rJlB3e0DKrNQb+2GgVHgeBvcd8ZXAL0brDDrv5dFEMQMApl+I0ioVjnpv
	lDMWXX4kkEegcgbeVvYwX6EdXx6P3MkLrqaoZ8dLGyDIGbuK3boWcvbTzS/QQKZEfMmS0RkIAbs
	0l8as/M+0+3SVC3K2vaC3r+PpSqUVw4KqnmiuySYzEYHp5rMcTFCcD3D/jKC/R3K1moH5NX4xh1
	DWOXWdklapJ985C5o6ZbYVzzZ0tcCsO+hrv/FAI2YCIT261hnNZBOLA+9NBuP0X34tvzliIRfuB
	2S/g1SakE4BfLAHhvA9V3goblAh/mcU7m455WwgqDYmx3lwHzif/8WdPRLLWIaLkdRoUQb6t6QQ
	RsgspnYPNN0bJZtQxggBt8trXM4++vkpgaxwEQL/TWDfcC3Q2l29/imoGdnCa5HX8xDRnu7hNQG
	kCieWSNR63o6LwhxDC408yFSlV7qyEFPr71M8NsV9k44nMra1k16ML
X-Received: by 2002:a05:6214:1248:b0:8f2:940e:2423 with SMTP id 6a1803df08f44-90c8f9584e5mr77469296d6.11.1787437265210;
        Sat, 22 Aug 2026 15:21:05 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a8be17sm22573156d6.46.2026.08.22.15.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 15:21:04 -0700 (PDT)
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
Subject: [PATCH net v2 2/2 RESEND] selftests: tc-testing: add u32 node ID pool exhaustion test
Date: Sat, 22 Aug 2026 18:20:49 -0400
Message-Id: <20260822222049.114526-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260822222049.114526-1-jhs@mojatatu.com>
References: <20260822222049.114526-1-jhs@mojatatu.com>
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

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/u32.json      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
index b2ca9d4e991b..039bb8278a60 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
@@ -353,5 +353,29 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 parent root drr"
         ]
+    },
+    {
+        "id": "934a",
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
+            "bash -c 'yes \"filter add dev $DUMMY ingress prio 1 protocol ip u32 match u8 0 0 at 0\" | head -n 4095 > /tmp/u32_batch.txt'",
+            "bash -c '$TC -b /tmp/u32_batch.txt'"
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

