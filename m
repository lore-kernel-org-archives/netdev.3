Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392831F986
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785623368; cv=none; b=RiNnvx2IMie4QKeq4emLQStFov47iOKuWmiivYT9cBSkrIVtotX4am64/V3Yz7Q3P1VX5GYorDo4pH5F2pFu4+PQO2uVl4zPDpxfPQ5vFTFgVIgUUcqnKI0GYdktWtXiMfNJo0Lg+y2g2BO5iIVPfMKekC99x/+RjOCqbTnN/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785623368; c=relaxed/simple;
	bh=0UFkvjNv0bQt5HrSYPmeTIaP939CNyqwdnq4nzsrZPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYZ73veYGkc9+kBUdvua3FBV1/QcZrbEA6nJuPlPCPoGTeSQOFYch0lZdP/jewOpIJ+NNeil2Vejmzz+3eHXfQKB/XKHqv4SecMKP/kE/wRiIStOo9Q7NFFHv0it30boYemC3DAmNj/I66U1nz2Xt+cNg01CXktAvMKVSAO8L3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNLaW7lz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNLaW7lz"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c8e2e39easo19331881cf.0
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785623366; x=1786228166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TOfcCbWV+8AiSnf47MNeISZ41ODzpJCZxK60zqEsNHY=;
        b=JNLaW7lzExiAsoN2R9FX+sdU+NTXrjjZfGdDrdWalQXszj8DbgXe4tvf1SdIitj4gV
         34dz08WGZsv/SGH8QtCAPkWtP02OVXybs2K6iBb3MT/M4uKk5a+Ha6KMD/BlZqYPIvaq
         1hSZsdb+/B7RBiws4L9Xd4lieNXTFTYTN3SLC/xtjbWgZg9vLpNjEHLenJ2y95XqMfnY
         mkJ0Gzkk1JOz3xBwe0O36hXUjT6amgdBzIGMUDiAkcqjezl49t4+/QNFcU1/MiRxsa+v
         JAQ3s8ZOq7C8VyJXIc4ZKPM6BwI0KOAYwr1w8qKcRs8l508MgcvZzH801kPohqJ3JSoM
         nDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785623366; x=1786228166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TOfcCbWV+8AiSnf47MNeISZ41ODzpJCZxK60zqEsNHY=;
        b=W+uYat2DqbxDHmMK36Xk3g89TSrKj8rjYKVLnGS2AWSuOp2gr+oXWcW+INsVFoPCKo
         AtBol0mMUHdJYcKcZOUT2IP+N3n1uCuxH7drbfcaE5vgGj9zb8PtvjtB1jhVulDQuF2a
         mBNTLZ3WHrHqOmVUmQh0jKxBOtr2nArtbMHZ1pZyMNiXtsFssvzJIh19i7LV/sqowqid
         jHCeXuOfQ0ppVa75p/dfDbGo3ajgZrMTJ2IvUP0fP2FyAa/6xTexo59YGmTSCRAvufvt
         vTORZu2yXnVlV7onPNjRiv8I7kSqoifpTopD0BuwwrLwTERehvBnQea5CRHz3X/efya8
         jD8A==
X-Gm-Message-State: AOJu0YzR3RK/wHRAH9UK2kOvtwXUXxt9HhwZ/K2bezAswWhoHhABM68E
	eJ+xoQlzngAYujsunxgpjRaXYlVjxS7v2pD+VOjMqfGf7VrtVawwO4xrAPydRUYz5Yc=
X-Gm-Gg: AR+sD1084pNkVLkH3X6vzIjWTrLtcZ8LuDPP2Ts6mncUPyl5W3i0msIJkuSj9un6Jlp
	ZNZZ73oa8zZdb9TUP7akrfBtc5naawbSgNUxXEcKChLcIEBZL9G63H20wL6TcpURpi3FcKzjE/k
	iHu+Rg/xZPPtW33elcZTLllOf0j7IwLW0QpEqA3lfchdCpttl8SF4w9wc0RhOHFJxs2D/IT9yKB
	35dzQeiDgYRCGWgPGqLFWpirddN4NG44taRt/YRnMazYVre7jeQTad+xO5RsxVEG+0P+AXyYOQ2
	4XeD47Puu8OWnXh78revIGZ6y/o8PKQ3Ihd948fNaGlW8utorPX1ajMmJD83mMxCE4JdoDEqfu1
	t8E6C6jcQBQnZcw5o5dZx31vXJvfT5Ru5ernVdCEpKT8mGMQ8XswUAr+K4YrxHCYsaap0V0ohl5
	2sEWj2u9YXYAOKL6eBtzKd8jBmp4gcQ8GAUuSEKDZMI/eNVWLK80N+X1mTqM8bxNeedB0Wh6XLC
	KIBQ1IIYiwsIQAbAG8vWtr3XPNJqTrRPPbGdqy+QjetLY/PlO1dDwGRSZPOMZTy6GfpKpBCKqk3
	UaFIs67nRRF4x5I=
X-Received: by 2002:a05:622a:34a:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-52b567b2834mr97453361cf.37.1785623366012;
        Sat, 01 Aug 2026 15:29:26 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal (ec2-32-195-55-166.compute-1.amazonaws.com. [32.195.55.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4eb956c3sm33403831cf.22.2026.08.01.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:29:25 -0700 (PDT)
From: Deep Shah <deepshah146@gmail.com>
To: netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Deep Shah <deepshah146@gmail.com>
Subject: [PATCH net-next v3 1/2] ptp: reject frequency adjustments that overflow scaled_ppm_to_ppb()
Date: Sat,  1 Aug 2026 22:29:22 +0000
Message-ID: <20260801222923.39017-2-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801222923.39017-1-deepshah146@gmail.com>
References: <20260801222923.39017-1-deepshah146@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptp_clock_adjtime() validates an ADJ_FREQUENCY request by converting the
requested scaled ppm to ppb and comparing it against ops->max_adj:

	long ppb = scaled_ppm_to_ppb(tx->freq);
	if (ppb > ops->max_adj || ppb < -ops->max_adj)
		return -ERANGE;

scaled_ppm_to_ppb() computes (1 + ppm) * 125 >> 13 in s64.  For a
sufficiently large tx->freq the multiplication overflows s64 and wraps,
so the resulting ppb can fall back within [-max_adj, max_adj] and pass
the check.  The unclamped tx->freq is then handed to ->adjfine(), where
drivers scale it again (e.g. scaled_ppm * 762939453125 in ptp_idt82p33)
and program a bogus frequency word.

For example tx->freq = 147573952589676412 makes (1 + ppm) * 125 equal
2^64 + 9, which wraps to ppb == 0 and is accepted.

The caller already has write access to the PHC, so this hardens the
max_adj sanity check rather than crossing a privilege boundary, and
well-behaved user space (e.g. ptp4l) never requests such values.  It is
a follow-up to commit 475b92f93216 ("ptp: improve max_adj check against
unreasonable values"), which handled the analogous s32 narrowing but not
this multiplication overflow.

Detect the overflow with check_*_overflow() and reject the request in
ptp_clock_adjtime() instead of acting on the wrapped value.

Signed-off-by: Deep Shah <deepshah146@gmail.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/ptp/ptp_clock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index d6f54ccaf93b..4111342d64f0 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/posix-clock.h>
 #include <linux/pps_kernel.h>
 #include <linux/property.h>
@@ -159,7 +160,18 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 		delta = ktime_to_ns(kt);
 		err = ops->adjtime(ops, delta);
 	} else if (tx->modes & ADJ_FREQUENCY) {
-		long ppb = scaled_ppm_to_ppb(tx->freq);
+		long ppb;
+		s64 tmp;
+
+		/*
+		 * scaled_ppm_to_ppb() multiplies (1 + freq) by 125 in s64;
+		 * reject a ->freq large enough to overflow that, which would
+		 * otherwise wrap the result back into the max_adj range.
+		 */
+		if (check_add_overflow((s64)tx->freq, (s64)1, &tmp) ||
+		    check_mul_overflow(tmp, (s64)125, &tmp))
+			return -ERANGE;
+		ppb = scaled_ppm_to_ppb(tx->freq);
 		if (ppb > ops->max_adj || ppb < -ops->max_adj)
 			return -ERANGE;
 		err = ops->adjfine(ops, tx->freq);
-- 
2.43.0

