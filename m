Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE73FF886
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598186; cv=none; b=axsXwxxKnWHi+UqOdZjKXocnteJajvG9MX+XCYPGZde9ZeMuMAoTh1iafJzAi7Lk9jpzJ5vfT3M2Kx1UgqN/0tLCBqrXUnsSKXX7jagdGU7LV26guuiEH5FjaShIkF6zuFiyA8fDGGrIORia+MpX9X3TjYkb322WXITa2gjxbwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598186; c=relaxed/simple;
	bh=1rIoBB/Hj7ieSJ/Og+6Ie/CT2YnBkpcryhJf4qTc/Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwUgU39z+zkui3FEoQTNjLsu9Lj76QBd0EYHPyw23pIBc4BisTI7MJH9xWxQUEVqJjwr3cck6vt9cFem1wtk79r3GSpLDAEWTDZNeF6I8Efv/RP015+QL69NYo+CBkSVonrxYmocEP5JV+OuXZysKZLYczJucWg/mRwik/GStBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndVOhet3; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndVOhet3"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9034b6b7674so88556856d6.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784598183; x=1785202983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4imDhb+13AEPLffOEeCuWK/Th0FJ7Kuf5u7NQv38orc=;
        b=ndVOhet3urzYZNmDWYYKSI181wEk/ZLbIqHNh0CLGNUHh0JIgp7/O+r6K/W+JGkKwi
         AehwQIztwUGEzYiXe/QmFBw0hfYwTyXIGjtUKBqorfi0y/IqkttdteyoPQJIgjnTikyb
         jVngBYqnvso0arM8+snXcc1DDl/rrQbiIE17OSONT6gOTAWCmvS/Z58IWXjZbKotxz7D
         tBoNnl8PaSwoOCeCZb2fohdyMO2aGFPQ6phIbISkaPUGcQvAcYCOzkcD2yN2JcjijJ/i
         jzmbqbziq608/AHMN2CgQEq2zOl4mxafGjRtG4ck0vJThw2Y4ZdAX7NQ5pnG3djxfC4q
         0p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784598183; x=1785202983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4imDhb+13AEPLffOEeCuWK/Th0FJ7Kuf5u7NQv38orc=;
        b=CLK+gItdiYVYb2khwKPxhm2mHODGX676ykO9zpPPZV1rEnHyJmE6Ml8dJw0K+OBbnK
         2ko5Sg7Nb+eTv9oaCBPneNkpcbE0jbm/1wE9o35Pe07D9+DEgxztsScIg6Ywa6cgwXDy
         LrOyOqdknLHTTof0dhAAPhtH5Jlpv7oRgaz6ekzHICCj/rxfWSZTHXt1v7yWGbEUMFnJ
         ylYnEBNpZpNAm9BqXGMAaXZm3oxqdF249HFbZvuF7FKOzOwT7qBYB56+lGDzsCsp6Tro
         t7h52Z6Vy7tgCJt35PYFducnlbqy92kn/DN7i6ZDgL/k+vmFLeXaJjqtfJGwvlWfJwSk
         111g==
X-Gm-Message-State: AOJu0YwM5gnxY7K7b2hoCrFRtQSrdqZAXus2/JseBylyZ3pqyMNyPrvk
	TEqE4/qMRv6gl8MK4G3jFa2nFM0mkGpCdzuctH35njFegCIJ2aHSSBADoPJIb1ScOsU=
X-Gm-Gg: AR+sD105Wd+sqHQ/yIBZUgwR1MlYlvhDxwjj/cMqNHeliHnLtHiqrVG/xzaesdPlmTW
	NmSCPVXrNVcdiQ1l9JhS+jvQRn/PKKFIaNHPX0wuQ2rE8lkewhAxJnurjkUxl9/1+3gV72sbLou
	1U2hvGlsz6x6VXskrNsREK5HGFaIjoW4UOi8VWouAbyFZDyX+BbmU+8TgO2EVUwzdxjCmepiQPT
	Q5vsOVqQnAxvN8tuTfN2LTPricemNrVZhMU28npaOZo7TJDW1VaNYCXjpDSWwNoQ6/fhl1ZQemF
	shaHxUKIeIrwYZI5SPGpzZL3AeHhxSq6GB4awEbX//JP0GIDnB6mtq3owoq3s16O8BRIRUwGvap
	BrnJXqecJA1xpnI/OU+3dFntPE2HoLrzxTa0iED+i/CZt899ScsoqK0I/iS21jdLzblLHC+tADk
	CDoRxmoudHQw8/2XYMykiousS6pIYpdvATNhc9cLCSNBiItDgm3E7b60cY9u8WL/vK+flfPMtB6
	P9jDztkAVTmtTugbqafr+pWqURpFJb9TpkvV2ku2+s07zFN
X-Received: by 2002:a05:6214:500f:b0:8cc:ee2e:8d9c with SMTP id 6a1803df08f44-907783184b2mr167578256d6.5.1784598182984;
        Mon, 20 Jul 2026 18:43:02 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal (ec2-13-222-20-6.compute-1.amazonaws.com. [13.222.20.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871f650sm104418266d6.45.2026.07.20.18.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 18:43:01 -0700 (PDT)
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
Subject: [PATCH v2 net 1/2] ptp: reject frequency adjustments that overflow scaled_ppm_to_ppb()
Date: Tue, 21 Jul 2026 01:42:55 +0000
Message-ID: <20260721014256.1876-2-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721014256.1876-1-deepshah146@gmail.com>
References: <20260721014256.1876-1-deepshah146@gmail.com>
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

Fixes: d39a743511cd ("ptp: validate the requested frequency adjustment.")
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

