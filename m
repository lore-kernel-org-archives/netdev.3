Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579840;
	b=2pqEXV2Jn107DOHvecoAvOaiDZWmouIOgSluwKiFDv4icbcCx4Fq8TUeNEkStgJia6B/
	 O9lK8BnDrcgynqINgvboXYV0xAXmlBOECRkO0G6cJaocGnviaoNupvVu2FibatydVSVHd
	 mPRb85ZoU/n6IbcVAKCeRqII+a/AXT6cV3fqJ94AfkWFEuZpt7G/YaijyV6VDg85QFn8T
	 q+Q4+YRj+3xOakHeIj4SQsuKlY82QXJahpMdZGQ081EHmaainKSgfQpq5rR/nchozt49K
	 IAsaANbYG1Zlx2SQzFejtfg0lGtDmD/Jpy2WL32vGgfzhTjmvqXdMMtx+7c49yQC0QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8U2P0iAh2BG7KjvPP6wqvmh3hv9L2W1VYLUEiGNWDRM=;
	b=VWvLUDRT4uTs0vL45sVaIdk6SolC89xSDfDk1IdzFvAzcJIsvbHkeeyu+4/axD5pMRhS
	 f4PeKhp/CMmKC8fGxJsx1OY+V6z/jN6REix8zH5nh7vX2vNvzipbIyMACUVPCrE/ok567
	 3dvzwdBIHOmM5QTS63W2LsKSAF6njFx2X739aHJFf705tzGRa6tUIrDbuGAb1lwChrKid
	 DqZbmJa58bY6nzx+IawQ7831bb1mvw7bfnF1lW0W+5aJrGfPft0v2IwyiVDyjY1b4kIeC
	 wPbgEglN6gEFVm+b9EObbJhlqS60tyFedkK0Zf1DpiTpqX1cPPiz5SR2GuquI9X+XDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QcWYu3dF;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B6606A337
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 00:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B0B6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QcWYu3dF
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b8306b9f8so45012856d6.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 16:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793579838; x=1794184638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8U2P0iAh2BG7KjvPP6wqvmh3hv9L2W1VYLUEiGNWDRM=;
        b=QcWYu3dF8fE5k6F25sAPvmrZihimPCxUbC4DFTVaeDf1sMJ7pYu2/tpkP8nXiDa1SB
         shV/LeeL4Y3hhZvtvFQb/YYYgk5J5HuSJOQWh22OoY47Kf/8wag8hjZsPj/eOEucflPR
         NWK6T/gRcP50O/9nH7z2lzsR+kwdrlHY+oo0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793579838; x=1794184638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8U2P0iAh2BG7KjvPP6wqvmh3hv9L2W1VYLUEiGNWDRM=;
        b=QXz4mj3HYpH5zoBJmwNLQiXOXr7oAu61pL4pQlrH/Ilp58OgZ+MYa3na+j4IiB7GDh
         8TfWJSqByU+bGkTMmRSo28GQCwjmk2Itsbo6hg2gVtoXxfb+gF/5sl4tGxSzHJDmvXbs
         WukyXLCF7ISNXymrCWC7DIPnl0HikpAuQL607Y0wVkdFGuknZ9BBp3gbGnuwlGEJjby1
         jPbpH3obZifGKDQ0KejuWuuVQR5Cw2QTgC/oJnmbmQ2fIfCKW2mCaFs4MRWTkUFuwXOm
         ZM/E8Kwck3a+tdMj9LzqXc9zFAIswUB5G9aOxtdAM1d9tTnEg3I4BgFrcVk99EILRQAa
         OKPg==
X-Gm-Message-State: APuU4Z9/CKnHbVDrMgzkugEtogecan/MAL/cUICEM7bCv8aD6jXOdHf4
	ILTBGLKMNWcqq/P9iGDIj3tsZjmRR1Hks8yLuOjzUIz3tNRbtyABUjGCf8wweZgjAbPZ62AoH8r
	IJIk=
X-Gm-Gg: AYBFou3hQSXGARPf6IOIY8RB2o/GeE46AM4xpDCKiZqnhmrOU3yFqIhrclmrz4JyoJ8
	nazNdwvKMlvuIsPCTiz3FlEzthCPC25fD1q6BeRxKvVqp1dFleo43sHGrc1GwACJkBlaFL/XqBu
	z7Bkxh2BTHvaFs9cl3sj4QE+nBfpOEolNft8lLaJ+XfGRNkFl59C6e/zTgwtXewJGw5ELro4EM9
	92zqY5r7gnXkQovHDhRR9ONhpWuGcbM6KrrL/7GxAARhuX1Diaey+23jPDRJUhN3WfPsBi3f2RK
	cAs66I13PS8Bq2lm+2ExFgPUp97seYVy/mb/Ajc6plxx3F0DBHvmuNx/F2MqM8Wj5VCj2arVM0V
	XioaXspcTluOQ6KYaArnhrY05uAawKXR43ROkHVDYhOEoQb3pD1r6wFUyYzRd+HulQ3ZKbgz7h6
	yxaz/pU6Uj+FD+0zSrvpcFeHu1mjZIAiUdkzsXvSPbyOWrHq3ca33kqGbdKeKYOErGGDYX3kiG8
	1J5iAHm7F/qm6/j1Zvt/R3bF7rOh4shz3yYNtlVA4oyo96EWnCY4CYjDpyuwclFiZXDMK6MIyYh
	y7OTIAiIggo7yqI4/OC0qXgGhFxMx6jdNxgaLHnkaJYTKbs/vPrl2ano1Kp4eiPP4k1mbQyQ3tX
	9XQbrZe1V63WSLwk=
X-Received: by 2002:a05:6214:3d0d:b0:90e:8221:f1c7 with SMTP id 6a1803df08f44-91ca49e9c82mr156416236d6.1.1793579838604;
        Sun, 01 Nov 2026 16:37:18 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f23754sm77043066d6.9.2026.11.01.16.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 16:37:18 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 4/4] selftests: tc-testing: teql: reject attach from another netns
Date: Sun,  1 Nov 2026 19:37:06 -0500
Message-Id: <SER-NSBD.v2.r0.20261101171325-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v2.r0.20261101171325@mojatatu.com>
References: <SER-NSBD.v2.r0.20261101171325@mojatatu.com>
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

Found by Sashiko (nipa) while reviewing the previous posting of the
cross-netns rejection fix:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.20261031160050-3%40mojatatu.com

The issue:
Case 124e covers the root-only rejection, but nsPlugin moves the test
device into its own network namespace, so the namespace check answers it
first unless the two checks run in the other order. Nothing else covers
the namespace rejection: the teql0 master is registered in init_net, and
a root qdisc attach from the test namespace must be refused with
-EOPNOTSUPP. Without a case of its own, a later reordering can make the
namespace check answer 124e and leave the root check untested.

The Fix:
Add a case that attaches a root teql0 qdisc from the test namespace. The
attach is a root qdisc as well, so only the namespace check can refuse
it. Without the fix the attach succeeds and the master is mutated from
the foreign namespace.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/teql.json      | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
index 0179c57104ad..3df315629d2f 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
@@ -106,5 +106,32 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1:"
         ]
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
+        ]
     }
 ]
-- 
2.43.0

