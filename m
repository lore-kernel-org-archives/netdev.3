Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F773FE348
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598183; cv=none; b=OGGyK7SF/dGcJGYXFColMjyoWilVoDQ2qui/FYg+S8qNK4yQF0+Fezg+1OqJGlvgy0t0VOR3k9LFHuCaynfkguXCyHZ3iMZrvDkZBHOXFcbjheawYfx9vR8krSANEffY5saz+q4DbSjnskJvyESKbz8MidNstCr+ZEVnH7y4bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598183; c=relaxed/simple;
	bh=mQkScGSrLsYTkQbmAFUS26qOkwVlPQxOZaGXJa9pixQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNRLmVps/xFZKXXWcS0aw7VZSYi5B9TRDeDFu9oEmTxxhPSvJf1h7Jd8mi6aSFYSLrRd88FarluHoa19WX1DG+VQwjJy/Z9XqU40hJtxOBB5kx1Yv7Xgg/K1UqgOi0XpGDKqfP3CHHZNFXogmeDJYkkDwwT38xSVhccjQ2BxZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvaFBOoX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvaFBOoX"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so57899766d6.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784598181; x=1785202981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TIhPn926bcTJS822r3FkEsmh9asbzmZ7+yhUCWhALnw=;
        b=SvaFBOoXceskOKy7qbZJ5kZNOwjrXax6us7iss/zjTMBzR83f5vhliUIkffya5r5p0
         blfiORT+44kMVjMf6JSN4gPyrebCuMjhUmxch1+y4UvupNRCfCfAGqZU7guUqhS73P+v
         TfdYccxyBwV77x4i9zKAlLnRmwxQnZmzwLA7d0ayL/HgzGaTjsUc4QCOoLT8F1JMRFvc
         OF5SGuwp2suCBOVTM/3SAma8rqywCrxSJKzZ+5agE6pRSkT4OrzCYC1bmK1n8MDwnP3f
         ATjzIzjhfKKv+OxtceNqU7mI3anVGgAE/m/9F43a5OL0rN0v8GPtZbzbc09OE1Y4/4/i
         7SXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784598181; x=1785202981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TIhPn926bcTJS822r3FkEsmh9asbzmZ7+yhUCWhALnw=;
        b=NRzvG7v7HeVd0Taw94dETnW4IhWV+m+rag2v6TJZEy+8BYVarvIUJpw6jMMYUlwczF
         z7ttF2WSX0FsbxDimDYpXqNKXVqULOrkJVY1x/6BDFrAQYUlZnOhGEEWu6WhIZjGl0J6
         nMUP97LpjT3NDKpTyuYAsT/rffd6DWsUlIdj9FrZLusfcLC5XhDbyU8i5Bc6UZ3UfQKo
         C5oyO1Hfizdn2007ZWGZ0bGhru3QfbAin4kuiT5FHTFdcFYvw/6yC+6HwOmzGWz5KYWR
         Bn7dejkBNQ7uPkMcoGLE5bXkx3bl/Q4A5voW6r3yoy5X/UBxoNHK8nbsNdJnzqumYFAz
         Ridw==
X-Gm-Message-State: AOJu0Ywbm85GeJWCrxDyBUIVvnio5uBCPhMo53m4GHuC0Wjvfq1AwpWF
	u53rPNUUReamB5IRyRk2g3rl3fQ/9SIoSjZgLmnmbrhGm8Ae8wplMuz5pS9zNwSgC5Y=
X-Gm-Gg: AR+sD10L3nTPHD1/Y1KKs3XKZg2HCnMY6jwYr1ms8H+iWCDpKyOeVmEYhmXhq8injNy
	FyVJTMosWKFnPV7/w06th8A8L+vAV67MEBpWLjsviMgN2taINJgOIS+5/hpfRUjthaxvV4tcHC+
	ugRxyhc3SQa6BcGSRu2YyJ5QUQFk7s75bJ9oLclpJJR1kpqDNvp69CdHttoNGsOziePFEb4eGaf
	US549jYlI3pGjLjug/6af6+mtM7bS4AyTUU7vzD5Tdya+p8PcUWUJFd1dtUeprPsF0N4OCFw126
	OuDwqobs0o8LWFjnR0rjmJMx85fyDTm6Hmrkx0tyIRRwS0xybJa/gZ2wEwg1MZph7Z8ymBXUdVs
	idMk8cqqjCqW+RzZ5VBy2ye9IzYqTbAkGKGOxU9dnfzEUmP0hoiLUiRz6nOm285Qd/hjJSJTPJI
	5eIc8y7SPJzCQhM5odXf+YfjpVnbfQEC2c6NDhpGP9Mnv7cZygVeLfW1/ZCdynQAPNfcLkdu9h4
	SoeHRNVUFNUxDViDWyX+/ucBks=
X-Received: by 2002:ad4:5c43:0:b0:8f1:36c7:497c with SMTP id 6a1803df08f44-907784ddb2dmr181885246d6.33.1784598180883;
        Mon, 20 Jul 2026 18:43:00 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal (ec2-13-222-20-6.compute-1.amazonaws.com. [13.222.20.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871f650sm104418266d6.45.2026.07.20.18.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 18:42:58 -0700 (PDT)
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
Subject: [PATCH v2 net 0/2] ptp: fix scaled_ppm_to_ppb() overflow bypassing the max_adj check
Date: Tue, 21 Jul 2026 01:42:54 +0000
Message-ID: <20260721014256.1876-1-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptp_clock_adjtime() validates an ADJ_FREQUENCY request by converting
tx->freq to ppb and comparing it against ops->max_adj. On 64-bit systems
that conversion can overflow s64 and wrap the result back into range, so
a crafted tx->freq bypasses the check and reaches ->adjfine() unclamped.

Patch 1 rejects the overflow in ptp_clock_adjtime().
Patch 2 adds a regression test that crafts struct timex.freq directly
(testptp's int-ppb path cannot express the value) and confirms it is
rejected with -ERANGE.

Changes in v2:
- patch 1: unchanged, added Reviewed-by from Vadim Fedorenko.
- patch 2 (all from Simon Horman's review):
  - cast fd to unsigned before the shift in FD_TO_CLOCKID (UBSan)
  - only set the 64-bit test value on 64-bit builds (32-bit -Woverflow)
  - save and restore the clock frequency
  - skip instead of fail on -EBUSY (free-running clock)

Link to v1:
https://lore.kernel.org/netdev/20260712040922.6403-1-deepshah146@gmail.com/

Deep Shah (2):
  ptp: reject frequency adjustments that overflow scaled_ppm_to_ppb()
  selftests: ptp: add a regression test for the frequency adjustment
    overflow

 drivers/ptp/ptp_clock.c                       | 14 ++-
 tools/testing/selftests/ptp/Makefile          |  2 +-
 .../testing/selftests/ptp/ptp_freq_overflow.c | 99 +++++++++++++++++++
 3 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ptp/ptp_freq_overflow.c


base-commit: 1c975de3343cdef506f2eecc833cc1f14b0401c4
-- 
2.43.0

