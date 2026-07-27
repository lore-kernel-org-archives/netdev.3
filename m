Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C9429CE4
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170530; cv=none; b=D2TIn4GnIaAdfMfv+Ay2hmCT9x/eQp3F6/SNNHehXMOdSGzFMZfnUO+2a3Cl/7giTvJq39rZd/JDeBd2kJC94EQL1iuZMYYs7QMXmz0EG0uWTd9JDNYtDDSLMTsc8RgD0COD6mhbdaFjbVgRVX3ZJrFESVaPi+wzp4NygChlDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170530; c=relaxed/simple;
	bh=yevM4t5lGA1loaNIC03oKIXXNdUzs4tCmtanqMJGyu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8MRQE9A3LFITW22Ct/4lz1gk0Cs4ytI7uoVbGTVu6R8U8k0RA+Hxx19zfuesMvISEHKbsj9yaQ0F3ztvAYbpoXhLZHmHu1cER1SUIQFXQyJ/FXf67SRWC9eeZthSOVcqaew/iwj56ojsvqqJvd9CjnLehAd8fPxmNCiEHyRNbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlWDAG1I; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlWDAG1I"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb85186d43so1403454a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785170528; x=1785775328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0LWaGsCYUPNTy5HTUg6xeKDq64bmO3p7cVJSJv0HAI=;
        b=MlWDAG1I4tSKQkDeOXBd1PNv+RPkUXAhywnoUeL5hkO+wgTeoDuhasBJbOIgUdyhbq
         j1EO8PZZYbCxHgBjcU1IB3x11hWQast39RC5s8LtoWtGZRypOqnM6UvOEec+6RPLh9eu
         IPFuA974xmohiksUtKRD/Lky5yJchODVMXrOrOJ0YbBtQiewmrNejqzpsAU7WnpH45N9
         emleuN8ut9XpodrrBeEXhfhUyiYu5UZURCepqqQ8fe9nQcjMvuwlLX3cmEy626y71apG
         DzsYPb/PUAhsezsvusHSGSHR0W4HtyPcSYGrRQEY6+wMt49Ib1365sSc96Z9dzK6JY/u
         Z38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170528; x=1785775328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i0LWaGsCYUPNTy5HTUg6xeKDq64bmO3p7cVJSJv0HAI=;
        b=rGFEPDjqhGdbSwxZiA6ZvXoSC7XIuXsyl+gyajsFl879wis8RchLpbAYJ4oK49cGpM
         tG8B+T6EcXqLGXuLKSo+JhQ7zTLKu7wHaWpOcfjhc2v5DW/pdm9KHD8g759NLVe7aF8b
         2s4R+XBdqLfgx7+akLbQmerB5ktx4L4+g1a3rar5jl69nAnG52DhOHPK2HmYgG8ilaSn
         pcZayDEbCUxPdi1lJ1pda6jq7KwLK4zs5btsZdPJAJqU9JB8776BCJdHAmDEciZmQ4PB
         h/MdIq1ShKz+lbxKd8NdWogFdsQ6ZidPDRLnuTg5Yd+i+kYiwzr1vhs+ucdgA8XRYRsy
         63VQ==
X-Gm-Message-State: AOJu0Yw3Cwb92VhNah9xyadkQ2kqyt15RpEA2FJDuURtphf7Ch6OXnmq
	7WFoDNSVphgeYubWHrPsktQLoVbd1fcsMP7oOFtOig+f9xsCM2pQ2uWrkD2SRm4W
X-Gm-Gg: AR+sD104CfR7PIQRghGaETwRe5Ga7NSFRGVYqCTTdoMviUaPl7BxEroMl9AGXPuR4Rb
	u0RL4AfJL/2hHz3cyN5L8GQVnUxJRV4f2NelWEb8dNzbZn1dA1gXKFI/XSvQWtVvuIcMg0aUNll
	ZQvDPVU3JRmE6A5bkUcnSHUbGDcSzApfD03g/HQrl6gM/dqKLI9KTEuZ8KYMZT7FXdkYigFpwIg
	8vXnXtkwrUEiKkG4TyGbbmSch9VrTSpy+2OFtCaALLQvNfXq+5/XCcWzaN+4J5rjftniZHfVD7K
	chv9h8V7MN/wFNlrPNEgnoY2iE2QBiIX/Kyr8KIxtSF3tST1bCXdjVBElewalNt7cQJPonk++Vm
	uksPyTC7Ux1zoaEGDnh0PdQMqye/ButA0PFQnJY5O0mggi93RDNkGJQLef7sbQ6TnTmhqYOs5Ww
	ciJEZyzGNLFpl+GlZagDzyf6cx64HpPWzk9qIQvcmyUlv+n02JvzFMOzWmupEOGXCIurdfXIDho
	XVISXs=
X-Received: by 2002:a05:6a20:5483:b0:3bf:c126:baf2 with SMTP id adf61e73a8af0-3c67df285efmr10464409637.47.1785170527730;
        Mon, 27 Jul 2026 09:42:07 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:8b84:a60e:2cad:e760])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc59cfb4sm33227566eec.26.2026.07.27.09.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:42:07 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/3] selftests: tc-testing: add fq_pie per-flow class stats test
Date: Mon, 27 Jul 2026 22:10:55 +0530
Message-Id: <20260727164056.106203-3-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727164056.106203-1-hemendranaik@gmail.com>
References: <20260727164056.106203-1-hemendranaik@gmail.com>
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

