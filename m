Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410D48BD46
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135191; cv=none; b=Pn2tk7fCSM9QbysKMmxGNPTyQL4ksLdGiWs4swEasrnwq0MJdTwScoVHEIf2vMiAdHNXvPBOuPysoGwqB2j8sOynHI7BeoKSor0dGZ8StB5YCmbkC8rHIuTfIy+bgVhqJJPhCPdO626lqeA7Y7ABnzt0lx4rfbtB3cpFi8wWlxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135191; c=relaxed/simple;
	bh=9NzkkeJIC1gI957bIMNPTqjNnQNaFzgoibDIOA3Ag7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWNlnrndwV4p7tZtgGGaIcNZCTwiz/McBNUce/l8BbuTezfbb9nlscGXOaJbbAb9PR+dmutB3wi3uRngsG6bfcSwLik9P5Dn5UuHzeexYBhayqiWywxzGKNOHEB31pWJkRsdeaPXeXbAWAUXByGCeffsfFK3GK+A7VWAuAX8WKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyP6xAJR; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyP6xAJR"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so302152a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789135186; x=1789739986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rOeitkour1l8Dq3e7NE1rrMsSjA05zIKyiXuF35rlM=;
        b=CyP6xAJRxnbrsufulFVchjeZKfntOrkD1Tl8phYBSmcxFeLw8vHSQEwzUtNZF0R1CQ
         DnfinrJgTjNaRnkMdQ4aKEW/0EETY6Y+x07+fpDkz48f3SxXlAxsyqwuQbkRnQGKPjhw
         ZIFZHckQwngxRceJizdki8MJE2SEnKiiLiFt3ioZsQDHzQQNMTkJL9KwEYDytUX62fUr
         85PwP4a8+zQV+a9RXLb7dyyD9aFyAto0+TpSyu3RY34Qt9be8h9AqyOLODUqraS7Wyf0
         xq0QmYMRMIhSWv+AWzrg9DMY//AFRI25j+20pWT2QnoesYeO/Xbr1NG5ZpuHP2HAliju
         wi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135186; x=1789739986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rOeitkour1l8Dq3e7NE1rrMsSjA05zIKyiXuF35rlM=;
        b=guXTVKPH9yqyowiS1mKnvbbYIml4OploaeR9dqF21ndWnEJinNC6B06kQArmVym5om
         iaCeB9AsoryBQqb/GUcjJDzytQu0SnDLTuPedJ6fsqQ7fw8+HhrcFaNTU7HpF4Eh+j/C
         6Coyxe+X9+2ahA3cto1Fv73d3bd684lb8d38kr5b4dviT29rk9WDUqcLaQeTC/sau0OQ
         DYK0GR0If9yjonsCyuIwsFYQvW4QKeov7gsPkp47kt8NOHg+64hpfoWeBM3/9pxsVdek
         2dHGTyGV4ohuO/8TEuITKB72rwyo1zyTZvOmNKUQQlhGrkh3Qm/nmFAwa7VUwIPSDIC0
         PFzQ==
X-Gm-Message-State: AFuF++kS3Pj+6NcVHK0Bs9ikpO90ze0X8EhjVCGoqJhtuzqiz6oF07pu
	wsbR+R6roqE213RMPa7JU8EuehhIc3lvdnDenUzDfSeM879G+3lUfViv3Qa31saIQzg=
X-Gm-Gg: AYBFou1xvLkQg3fyt+59Dyw6EymSBjDjBodPfBfqoK4SUvaZbCZfuNsPG1g0zRTLKpY
	3ZtEU4FRFYhS3NKLaWnf8d6bDSzM3NtI1n1zZ3uZwJUDyi/jO3cE9acVmHbP9bKa5kUpBAIpqGv
	Ac4ip7u4KLt9TXVRJJH6y7Ehzb2JmHSm7lFU4jZhHDkbi+gyFSqCBO1KEpBnZqhowr/tnd2GynQ
	AmM2NnuLOkakSBh0/QxILGzJFObhsYt0bMizBWCqCtugB5rebeoNN/BxZ1z+OK1YeeLzhSl6jg8
	CdGtx0X/mMCFIfc9/NDazTgHGEuXSXYqgZq56QlhmpjVMamcyl0Mv6UdzDkrLFnzMs7gY7Qqzz9
	AYwRLX605D861zS3HU8PejzdDPXLYpvFCGu/5Y+iUZNn0w5mlpF/PnudD6mEdf4NTqoOd85RoYV
	pWhKy6qXQkodQrku+w4vOSggAQ2SGIYIVfK+dLeINjDNpudyHRYsh97k1lFeO3ENfm1B+V/gs2C
	D6kPScKd7fBooiydLdWdtY=
X-Received: by 2002:a17:90b:2741:b0:398:e436:384 with SMTP id 98e67ed59e1d1-39d9bbd7b60mr7767890a91.1.1789135186115;
        Fri, 11 Sep 2026 06:59:46 -0700 (PDT)
Received: from dell-r530-61.gsslab.pnq2.redhat.com ([182.66.90.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4b1f409sm8040073eec.0.2026.09.11.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:59:45 -0700 (PDT)
From: Prijesh Patel <prijeshpatel.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	prpatel@redhat.com,
	Prijesh Patel <prijeshpatel.dev@gmail.com>
Subject: [PATCH iproute2-next] man: ip-route: document tcp_usec_ts route feature
Date: Fri, 11 Sep 2026 09:59:25 -0400
Message-ID: <20260911135925.147934-1-prijeshpatel.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip route supports a "tcp_usec_ts" per-route feature
(RTAX_FEATURE_TCP_USEC_TS) to request microsecond-resolution TCP
timestamps for connections to/from a given destination, but this was
never added to the ip-route(8) man page or its FEATURES synopsis.

Document tcp_usec_ts alongside the existing ecn feature.

Signed-off-by: Prijesh Patel <prijeshpatel.dev@gmail.com>
---
 man/man8/ip-route.8.in | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index fd04432f..ed901fb9 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -186,7 +186,7 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 
 .ti -8
 .IR FEATURES " := [ "
-.BR ecn " | ]"
+.BR ecn " | " tcp_usec_ts " ]"
 
 .ti -8
 .IR PREF " := [ "
@@ -569,16 +569,26 @@ Actual window size is this value multiplied by the MSS of the connection.
 The default value is zero, meaning to use Slow Start value.
 
 .TP
-.BI features " FEATURES " (Linux 3.18+ only)
-Enable or disable per-route features. Only available feature at this
-time is
+.BI features " FEATURES "
+Enable or disable per-route features. Available features are
 .B ecn
-to enable explicit congestion notification when initiating connections to the
+and
+.B tcp_usec_ts.
+.in +8
+.B ecn
+.RI ( "Linux 3.18+ only" )
+Enables explicit congestion notification when initiating connections to the
 given destination network.
 When responding to a connection request from the given network, ecn will
 also be used even if the
 .B net.ipv4.tcp_ecn
 sysctl is set to 0.
+.sp
+.B tcp_usec_ts
+.RI ( "Linux 6.7+ only" )
+Enables microsecond-resolution TCP timestamps for connections to/from the
+given destination network, instead of the default millisecond resolution.
+.in -8
 
 .TP
 .BI quickack " BOOL " "(Linux 3.11+ only)"
-- 
2.52.0

