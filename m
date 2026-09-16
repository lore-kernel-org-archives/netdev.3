Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3DC4AF16E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552904; cv=none; b=bQbw7UCyE2GRhTwwIu8Z5J6uiy69gU4yjSx08VcU6iyiGB8UwP64iBg6QQxadIltC2cNEd8eGFVkReI/1jBehfO4Jou0CMH5oSWy6UVH9KjjXfYeBFH9Gvcv0ebJb3Ugfp5Cpmat5nKQEMpWmPM+xjynOy5bOTwoDyTAg6bQbeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552904; c=relaxed/simple;
	bh=6Y63ypW1o8fSc5npG6Ogumje01PNdZEHgLH/DsEfGOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8IUk5qZ0XHaDYXyw+wrCuViycX0c1/69tQB5JYyVu2534UWRMQhjqiPFl7CwA+9IHdJ1AX3YDdTBdn85xdldlQVA5PyQpJjG+5vVvsusq3ZH7JDrN06eiLpraE9S+ZeHmsRz/WKkqbyprcQyfQXGJ4JbiB3xK0E8kGX/sEK4rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=H7xRn2Gn; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="H7xRn2Gn"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76543e2so2360571cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789552883; x=1790157683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=79RUTy9GyyU8S0QtOXN8RnXRh3vSK+UyTrb4wdm1wK4=;
        b=H7xRn2Gn2ryKxTLVSRACVJ/24kgNOReV8nRaa8Qb5SanMp5gc5tUfodV+KdNZljlsv
         CDe/sFfoIeYWJksth4/N/tyk/mn11BkrnwjXpZbViKjvZc3K5Z1Ffz7kmuhcYG44BJlE
         nA386saKw+prb6me9fI9G3DTyhIWcF9oVKULw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552883; x=1790157683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=79RUTy9GyyU8S0QtOXN8RnXRh3vSK+UyTrb4wdm1wK4=;
        b=ifwMGyasD1lRoUo/TiYtPRUtkVhbGEGOV3AuuQwKg9jyH1JBCNwI5ClmYODOHVDWFB
         WrV5M5x/FRAcIoUGyCCK4QTy2q9eLPmUQdqIRHG3wBROfB72ME/yo++KuhTIxOYaXNRb
         d1BFAymkkC/QulGZcLtIAT5UWdrD1L+ssYRc7wIlweNTb3iMUVxiXFkRJRKOV1wlyiCi
         nsSUtGMg4TaVgKEydb+359eCGxGpCN5LsRVTKpG4ARfgzE0bhMW2gpUqLZ1iKKaXTXa7
         HU/4l776Vn+fOe0kEg74ny1WV859tt0MfpN2TVJpUv0PVBpFrj0pbiru+vodAWAmjY5J
         nszA==
X-Gm-Message-State: AFuF++lKxeDFfCsWAFshhnFgheMHvQB5pSB9VmFnazIHWcRrJRR8HkBw
	5XLAdR9DZcWAL+kAZywaJQtvtFdmL3IZWzKJPUn70dJlN1v72O0GYPXwFN81HOVr1r8JTYeRnf+
	9Tytq9A==
X-Gm-Gg: AYBFou3F5BkPncqmd7PfuNydg5Foqfj5Womddy8cDtvBkvWwnvG2rn3dqOKXVKcFg2b
	Mjfelii32ISjbbH0/U9EYQtt4HF1ad7BcQW/PUcLaTBdzycWSGnFM2WyAm0qoRzbL91kz4XApPN
	73F4xssMDiWLqv0YIVtJJaFLeyEeH46eEk8O9+5wHN9YP4J50BHKeGsbYipwVqDEQwZFa+zaqpu
	Bs79ZZ/m5GyMZrMLFMAbVwfqANx7j/RguS0vFlQ7M+my2FqZTn7UoNJcDh5Rrn+q5SoALHxIyzk
	HMRtvEak+pymRDnjfqj2fR/4Ied8/H1RH/+nF53MgIZiGEP4eGPYR8PjwUzd696CAlx8SwEONjA
	gHvtPu6m1HoTkGN+Cb5V9+OifxTQ+Cpzi3l+csSfBGIQj0Ypt+I8Tvv9C8ofHLKwWLWkava+qdP
	fPoU3px0ILXKwpNGkmw4DRBAicWixCHh/FgSO41mnQv5YErp+weyOFzMalLjLmjcJLeFrwuegUk
	dmOHrOe1enKREGHHTrIIcKoABOp/HArti+cXFYIG2tx1Mc0nZpc29/NBMI=
X-Received: by 2002:ac8:5747:0:b0:530:fbb1:7a92 with SMTP id d75a77b69052e-5327f58d052mr20346921cf.32.1789552883374;
        Wed, 16 Sep 2026 03:01:23 -0700 (PDT)
Received: from mbili.ht.home ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53262021a9esm18026851cf.14.2026.09.16.03.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 03:01:22 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>
Subject: [PATCH net 2/2] selftests/tc-testing: add u32 manual table handle IDR tests
Date: Wed, 16 Sep 2026 06:01:15 -0400
Message-Id: <QDISC-LQFE.v1.20260911041746.2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com>
References: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

35fc: create a manual table with handle 801:, then add an auto-allocated
table. Before the fix, the auto allocation reuses id 1 and hands out the
same handle 0x80100000, aliasing the manual table; the test requires the
manual 801: handle to keep exactly one entry in the dump.

a6e8: with a live u32 table keeping the tc_u_common alive, add and delete
a manual table with handle 901:, then re-add it. Unpatched, the delete
leaks the raw-keyed IDR entry and the re-add fails with -ENOSPC; the
test requires the re-add to succeed.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/u32.json      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
index e2b03f2b5e89..edc5148a8d97 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
@@ -376,5 +376,53 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY clsact"
         ]
+    },
+    {
+        "id": "35fc",
+        "name": "u32 manual table then auto table: auto allocation must not alias a live manual handle",
+        "category": [
+            "filter",
+            "u32"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 ingress protocol ip pref 1 handle 801: u32 divisor 16"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip pref 2 u32 divisor 16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -d filter show dev $DEV1 ingress",
+        "matchPattern": "fh 801:",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "a6e8",
+        "name": "u32 manual table add/del does not leak its idr entry (re-adding the same handle succeeds)",
+        "category": [
+            "filter",
+            "u32"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 ingress protocol ip pref 1 u32 divisor 16",
+            "$TC filter add dev $DEV1 ingress protocol ip pref 5 handle 901: u32 divisor 1",
+            "$TC filter del dev $DEV1 ingress protocol ip pref 5 handle 901: u32"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip pref 6 handle 901: u32 divisor 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -d filter show dev $DEV1 ingress",
+        "matchPattern": "fh 901: ht divisor 1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
     }
 ]
--
2.43.0
