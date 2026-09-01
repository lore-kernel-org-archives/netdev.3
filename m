Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB918415B8F
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246850; cv=none; b=Qky+RwKCM9B94FJiIapfaBwixsrW6yP2w2zJWCPaXuww+SMR9a79ag9Vf7fT6/BDUHHWBl2vE8T0eMLv15EVXBRC4uAYL9T98tfPdYms3fJ9xot9zwu3rtQnc+sLldf4Upybo31GlsJFBTTTOf5LDqNr6Zt2wbEmQiOROt82CDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246850; c=relaxed/simple;
	bh=J4RGoZnnRiQoevlGy8lm2wL/d6hz8MOcWCl8s2VRWIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PpN3cTZmuzkNm2D5W+yGn0rNBI58A/JMIplYs7hQnHFHOxp0yUubCdF2VkW77E6bdFRZGF/rSAwuchqc6vUWFCXGwrxgWPZiHuQP4UYdWVZpe8VPCKJUUkgXYviIMPH7kr+mG/iTye37V560yWv0PXiGkrCmrT0bEaB+rHhk2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx7B2w/8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx7B2w/8"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d01663d816so4073665ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788246848; x=1788851648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AhnZnMS1zl6dPRGigIwYLk+xKIiY6xljGos5e3aMaGE=;
        b=Rx7B2w/8tRz6cAHeO+mx+t4X0jgQpoQZ3mJ/trWX6JAjl5BpQGu0Ua1xi4/5Ori4VF
         4sfR2V3rbMrDLT7mVaDLNxiTFHPreue8z8QVqnZZ9Be+OGookjnOn2bHtlpWcDlznweS
         hiDsf6qSB7wb0k/c6yzB5zvL2L62waIl8OnLmCtWMVzGTuEeM+05WnLXxYKPr3FMtjgD
         JGdhak87kZib5lsTVyrarLdeQaUeuiGtmyRVeKwviPbO7Lh6X24YMgAk4dwDmFNmX7U1
         MrWWfjqiiNziQ4wGITOmTBXXu643s9mDUT4xVempFU4Oppf5GYovRfyfDu64UmITMNQ6
         78rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788246848; x=1788851648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AhnZnMS1zl6dPRGigIwYLk+xKIiY6xljGos5e3aMaGE=;
        b=PvU3uRwa8zXSPmOedosodv9gK/jNFmx+Dor6nkp3VMkaVJW3sdoQ2+heE3yv2z/4/l
         mQlBzvRHdalqA7ln6G5M56A0qdEOiNPM16FE6NwL71qbG7tavWGXkuMT/zPKAIeHo7hl
         Z4Fc+yiZGNh4/VPAsEJ2Xe/K4d863Tv3hyOwuzPL47La51izyjFsvf0CbyA488OjO0AF
         a0s1KzKgILpZGm84IV6XgM8mmDRacDBysOcDPmdHuXYdaFxObZQ4Z1TzT2OowuVYmYis
         MEKuh26zUOFK1NIzvlghsW1coagvqk1EalE0yO0eAaR4gB+ccQaymY2O2qcnnIkWlXo6
         B7Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxItPhRrloPMmUWyhB1+ZRsN+82qCiwIehMiFSXFy2ze5g3Q51tn95iCi7/JyCobbpPCbfsfQg=@vger.kernel.org
X-Gm-Message-State: AFuF++neoHVmF4QOTjNfsrEDC/Lb4Nt4kgp265QZlHkS7Ek8qJvd4q4p
	EkTHVARpVDW52C9lsEKYmqEzg6V2GPkeNaGGPlLO8jnIS/y9sOdVsLiA
X-Gm-Gg: AYBFou1+zbgmXVnH5Lv1HaubBlHQbKec1B7kP3zjAacjNHhynBedsxojdu6HueIQ858
	ej57Hw/XJ5T0oJSiLEFaiwEtnMncaMxBU2FuB/kUhMbgn+f2EKFj68UAIh+/blaDyFvyktaal8U
	avDehtj4s+HvFg2obFMOJWZbmxB7M2guWFJJo4s91czYgBF3FJjI95vIfg/PhNgYhYG4PsObOxW
	DhG+7oAIBvzHwBDh8VhtVL9om8mwVRat4tn4G8glCvZPh/eynn2F3sm5D+gj994JCCSrUN1G27o
	GZGk5yaq85TyH4WoR/IxWWQbAHgaubc20b3kTOMXj3hhx4NdVPrWKerxXkjAqYmXJu5+9Z83sDc
	zQJtQ3hMg37ecnWLvAWhlK61QTx++R7+pP94fKmtqK2bLatXYMlkxJri4dD05vysiUol84oL1ih
	tBzDHVOZyKybBBIKRIVnWg0xSV5DycVTdfnnUC2x7HiGrKzmO4ohrStwA9CyKvx5iKNKzsS4Tvh
	g==
X-Received: by 2002:a17:903:228a:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d74ddc705cmr412540935ad.10.1788246848073;
        Tue, 01 Sep 2026 00:14:08 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e2a95sm34374175eec.23.2026.09.01.00.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:14:07 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Subject: [PATCH] selftests: net: ipmr: Avoid memcpy() from NULL in nl_add_rtattr()
Date: Tue,  1 Sep 2026 07:13:53 +0000
Message-ID: <20260901071353.3302900-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nl_add_rtattr() unconditionally does memcpy(RTA_DATA(rta), data, len).
For zero-length attributes the callers pass data == NULL and len == 0,
for example the RTA_PREFSRC attribute added for proxy MFC entries:

	if (mfc_attr->proxy)
		rta = nl_add_rtattr(nlmsg, rta, RTA_PREFSRC, NULL, 0);

Passing a NULL pointer to memcpy() is undefined behaviour even when the
length is zero, because its source parameter is marked
__attribute__((nonnull)); it is flagged by fortify/-Wnonnull.

Only call memcpy() when len is non-zero.

Fixes: 05068eaa67b2 ("selftest: net: Add basic functionality tests for ipmr.")
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
 tools/testing/selftests/net/forwarding/ipmr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/ipmr.c b/tools/testing/selftests/net/forwarding/ipmr.c
index 9cd9f70de132..d3e26341821c 100644
--- a/tools/testing/selftests/net/forwarding/ipmr.c
+++ b/tools/testing/selftests/net/forwarding/ipmr.c
@@ -120,7 +120,8 @@ static struct rtattr *nl_add_rtattr(struct nlmsghdr *nlmsg, struct rtattr *rta,
 
 	rta->rta_type = type;
 	rta->rta_len = RTA_LENGTH(len);
-	memcpy(RTA_DATA(rta), data, len);
+	if (len)
+		memcpy(RTA_DATA(rta), data, len);
 
 	nlmsg->nlmsg_len += NLMSG_ALIGN(rta->rta_len);
 
-- 
2.43.0

