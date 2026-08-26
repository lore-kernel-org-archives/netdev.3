Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C6931D39A
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739027; cv=none; b=XBUSBFTfZxwCveb6isuBm3A03OXiykEj9tVeoVMYLq+zhkAs9XNtvHa0Xfwv9kPunPrXzT7YTXw4m5b0aApz3eW7YJVfXSieWnTXxXuK4XRW85mjsdlxDqj2CAp/mQtznQqYZNslpE8Us8berHdhJh2CNYILkMkjcvVUufUPwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739027; c=relaxed/simple;
	bh=57avFade3zuK7/6SQ3eV2ojUUQSJjhGWCjyqA29B4Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FW+iY+jFMl0exgrOuGMxLjHq5NsWOvi6mHMyxpThZfmgGFE6gLQ7af7P5Elo5nbr9kHe6mrjWoqJvfWGdsXOw1PbvF540PPT5k92wG+2ZrwQqTb6AITgIB0au5o9aihLb7mgWR4AC5vhKM9G+1M9PltURhdOqSTIhRnT9bFM4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CuE9nDHt; arc=none smtp.client-ip=95.215.58.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CuE9nDHt"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=57avFade3zuK7/6SQ3eV2ojUUQSJjhGWCjyqA29B4Qg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787739021; v=1; x=1788343821;
 b=CuE9nDHte80mWQmtNvX3zr+RSEqjgOfnNeKRLbGNMfVuQcpcTho2DC1OFHt4VXuQGzw8Kclv
 UzpMl9hpy+GflLoEVn7bO+4r0/U1htvaz85ue1OQZkC/BwGb5mRNHvj4TW3ExAfxMsEfnvq7ybG
 ld/P63cOkQO2jsrFwvMJFqvU=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id d7afdb5e9b644012;
	Wed, 26 Aug 2026 10:10:21 +0000
X-Mizu-Trace-ID: d7afdb5e9b644012
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arnd@arndb.de,
	john.stultz@linaro.org,
	jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1] ptp: fix NULL deref when adjtime/adjfine are missing
Date: Wed, 26 Aug 2026 18:10:04 +0800
Message-ID: <20260826101004.100979-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

ptp_clock_adjtime() invokes ->adjtime and ->adjfine unconditionally,
but both callbacks are optional. clock_adjtime() with ADJ_SETOFFSET
or ADJ_FREQUENCY therefore oopses on a PHC that implements neither.

iavf registers such a read-only clock: no adjtime/adjfine, and
max_adj left at 0. ADJ_SETOFFSET hits the NULL ->adjtime after the
offset is validated. ADJ_FREQUENCY with freq 0 converts to 0 ppb,
passes the max_adj check, and hits the NULL ->adjfine.

Return -EOPNOTSUPP when the requested callback is missing, as the
adjphase path already does, rather than adding driver stubs.

Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
Fixes: 75ab70ec5cef ("ptp: remove the .adjfreq interface function")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 4111342d64f03..b5df120be4d1b 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -158,6 +158,8 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 
 		kt = timespec64_to_ktime(ts);
 		delta = ktime_to_ns(kt);
+		if (!ops->adjtime)
+			return -EOPNOTSUPP;
 		err = ops->adjtime(ops, delta);
 	} else if (tx->modes & ADJ_FREQUENCY) {
 		long ppb;
@@ -174,6 +176,8 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 		ppb = scaled_ppm_to_ppb(tx->freq);
 		if (ppb > ops->max_adj || ppb < -ops->max_adj)
 			return -ERANGE;
+		if (!ops->adjfine)
+			return -EOPNOTSUPP;
 		err = ops->adjfine(ops, tx->freq);
 		if (!err)
 			ptp->dialed_frequency = tx->freq;
-- 
2.43.0

