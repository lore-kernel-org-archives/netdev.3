Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A6430566A
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918326; cv=none; b=b2P6Ly+5+TMJgW3FwlNfSWnopY00ShiBaZoyjGncAQydR2i8aTGcHC8hA5LRZ1L/D6Qgqjs1gq8y2kJLiM6c7OJn/OGFynHOyglVGQAYBOrYDS4+tIkO7tZbN7btRNAabh9WZgukaSxHqKyqEceY/xDsANsCuVxooWR9UgVcqVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918326; c=relaxed/simple;
	bh=1vBX4q7ojpcugGpkY4PDpKLUTwdTY4Y0bm+vJswlm4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0O9Hkh3f3GhBdbodL5Ay8+cKDIfTCkju/q55rTps1yJDZ3Hk1be8Fjndbf5T9i2m5ySWCoPRDH/pxrIyu5VRB/RlcfD1EfHr/sykVxTLZaDc7m7tparrehsm+xD+DdviXjTmy5VXbIHHxTi0T6KfGeWLfZcBrL0T6+5kW34+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPRF1Euo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPRF1Euo"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so764303a91.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785918325; x=1786523125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sO8zLVEA2ZltNWuNfjgzJEFi3mOfQQ23YawfcZLxY7w=;
        b=PPRF1EuoV6E/4fMkUyT8Ym5e4xdAM/LMuwev31mjii4iyN7CKKiWyTDnkTctZErdqy
         nQRPHYxY8TQK5ANkutJIrh6XqgThMQTSR6dEUxKqtkZI3antH2kO7jWX6RBLE8FgsFM4
         IuZiKl+7GlRmJQkcFiH6kzE/7wHOxs+IvFF7O6KgaC2tiFqOyBpBlw/AF74qFU5I/uAC
         L8iN/9y75PsGfFn8GmcnAYdooL1XYeo9oAjHNrMRnljuBELvsoH4928WPJLMKUmrX8Dr
         qw02nnoFV/h9Y18WShMbTg7EaPIEJFVhe+tTfT8r5vu1j2+5siN6co4p4cPCfLdww/HB
         hfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785918325; x=1786523125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sO8zLVEA2ZltNWuNfjgzJEFi3mOfQQ23YawfcZLxY7w=;
        b=cdBwxlbuN2DhZq7GkszLRw8OHEULLTB5pvMZ4wpO/d9HPjPRrFN81tE1irtSTlGsBZ
         5w2T4TRxP68UK3vZrW+HsuFS3bxHNNf/tiBcXpabX2mukVmn1Pq8GIBbX1qwRE/AQovW
         KrWy7gofDBw090KdwDZA25XeMUhfOzZiK56dPtqMKr8+Frh/B8EHUNJz1zaaRipbKnW+
         j/mz/6lqkbCVlA+BThw6x2rqXF/UDBzljd6Nu7XCklRviZfgAVrCf89/yY8ZGZGrVsbU
         Z9ic7Ov4StMoiDa/rnz4MRSKfXpUKkL2XnFGLqyEaf7Z5xlYKiCWBjwd4MRRriK9SUjW
         0uTA==
X-Forwarded-Encrypted: i=1; AHgh+RrMtJNw6T/DIMMAC2gCybqgzs1o23HgAgteoYZEWtEXhaC2fUDW0WVgWX5zh0aQYvfdy/HoocI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWbFuGDs0yHXcNG15cY4IYIouqH4fXHW3pxMl87GBHvd1KXiW
	SzwFY9sAMF5Et5MhB8p3sR16qJRJ7k9Fsvqwk19wj7Y4PFoO5+wYkNIX
X-Gm-Gg: AR+sD11KjUCDKPvUpuYap6O9mOERTjcTB1JOgYs9J1YO1GIObg+rISfvdXAot5Alwhk
	h0xlNTyuMo5TVeZahFgcKFvN2yW2YVHU92kLI6KET5wrU+1G6+q+KFpd2MoXYO5Cf+EGK2Hpxt0
	Y+R//pFi4fR/G1SurdKPn3c7ju3Rne9uwGFOYBstzApV4onX3eqNYOWqot7wQCw8NvPFYpTZynn
	nuL8Cjd8aU4yQ9i9FPulLU4jLAyxEJyhhXlSBWHYHDX0kMcuLQgTZwBonpgWWe0IRNn80csTa+v
	Qakqn5YKZ5S/635YdF041SLI04LBKeHqRSUH9y8OJzZc9bLelSEaDhHK2AVU6V8aheUB4ITmUVd
	VGTy2Ym6odAwpomrhXTmPrWLd1tb0mEscPjt9MMtjZLxGrYFLX+t74FucwHgayAZSd+yr+uvCBb
	5Ju5SWaPMTosQ53SXJ0bRehCjQdfd33TL+izQgC2EVEl1EDeRVBVPsOSwodBnuw1eeTIYcuGin
X-Received: by 2002:a17:90b:5683:b0:381:26f:8f05 with SMTP id 98e67ed59e1d1-3903c5380f7mr4999150a91.3.1785918324995;
        Wed, 05 Aug 2026 01:25:24 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903f5fdfe5sm1263278a91.4.2026.08.05.01.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:25:24 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH 0/2] wifi: iwlwifi: Fix GP2 to nanoseconds overflow on 32-bit
Date: Wed,  5 Aug 2026 16:25:13 +0800
Message-ID: <20260805082515.4136842-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GP2 is a free-running 32-bit microsecond hardware counter. Both the mvm
and mld PTP code convert a u32 GP2 value to nanoseconds with

	gp2 * NSEC_PER_USEC

NSEC_PER_USEC is a plain 'long' (1000L), so on 32-bit builds the
multiplication is performed in 32-bit arithmetic and overflows once the
GP2 value exceeds ~4.29 million microseconds (~4.3 s). Since GP2 wraps
only every 2^32 microseconds (~71.5 min), the product is truncated for
almost the entire counter range, producing bogus PTP timestamps.

Most conversions in the same files already cast to u64 first
((u64)gp2 * NSEC_PER_USEC); a handful of sites (the adjfine path, the
stored scale_update_gp2 and the monitor/RX timestamp path) simply missed
the cast. These patches add the missing u64 casts so the multiplications
are done in 64-bit, matching the existing call sites. 64-bit builds are
unaffected. The mld driver inherited the same pattern (and bug) from
mvm, so it is fixed in a separate patch with its own Fixes: tags.

Found by code inspection; not tested on 32-bit hardware. The change is a
straightforward u64 cast matching the surrounding code.


Zhan Xusheng (2):
  wifi: iwlwifi: mvm: Fix GP2 to nanoseconds overflow on 32-bit
  wifi: iwlwifi: mld: Fix GP2 to nanoseconds overflow on 32-bit

 drivers/net/wireless/intel/iwlwifi/mld/ptp.c  | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 6 ++----
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c  | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 4 ++--
 4 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.43.0

