Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F541D116;
	Sat, 29 Aug 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788037255; cv=none; b=XOTfiJQa2G57CrhB4lNyXK6UeZFAVk/fcEjMhbrorRp5X6Ww2UlUAts+IbuX0bPqhTjcdMtusnM4CpIcH0oEo+BRJb6zad0dWU35RNZ8Trl1BoWbBs9xlyKoOrihIBf1RqUPNOmwzP4UE2hf/7sh6AnRf/MZsoR6MtRV0Gy1XNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788037255; c=relaxed/simple;
	bh=TKCr7OG/lYshfVtCoRv8p95wwJwdzysH26/ch54fzCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIeBtf3SfOkHHZSbxCuea2vMQT35D1QAOKvJR8P19Hw6Vv7ROlPxlN86rc6gc8OdhpaAcLiflVnXzTKYzonFiaRBKMWgrGpATtUVP6b9IfJy/eNEHzxuut85w9MDSkKfCd+dh6MxhQvuMlTplc4l039dR0RAJMH8Un/UWqqev/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ttwqpBDu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ttwqpBDu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9SrcFb3IUBwc8U6e4SBmxYhmZooCsNmzygQwY9/RgR0=; b=ttwqpBDuBLzJ1KXoVcdDedEJgP
	cMW14nhlUiwhlZrMCVNgxFrSjOCmf0DmGFb0E75yySviEyJKC7B7eSGAyDEbhMo5Dmp6sJpwzWSQk
	dX4QPnRlkZrXgDeTrB87oklEBghY82t6Wi/B/HPD0fK/PGeqCjOxV846HfzC13U7Hx0cn3eUF6SCH
	9Zl+ddY1pZ6M/nPRNI0ib2WJxFXf7yLmR2d9jDvqX4jxyxs2y0ZwdPPhY60S+bHVpKV4mJE3bkv8u
	LViUyS5CSXqpIvhM4rXMVQ+nTTQGrN2O154q0blkaL8Jbw+1u8EKsu7AsoAU/bcGw1F1cOhRs16hX
	aP7dNrnA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0QAP-0000000H5t9-0BCl;
	Sat, 29 Aug 2026 21:00:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x0QAO-00000000Abe-3H5v;
	Sat, 29 Aug 2026 22:00:44 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Rodolfo Giometti <giometti@enneenne.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v4 2/4] pps: Drop the !NO_HZ_COMMON dependency from NTP_PPS
Date: Sat, 29 Aug 2026 21:57:00 +0100
Message-ID: <20260829210041.40649-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829210041.40649-1-dwmw2@infradead.org>
References: <20260829210041.40649-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

NTP_PPS has been disabled for tickless kernels since it was first
introduced in commit 025b40abe715d ("ntp: add hardpps implementation")
in 2011, with a comment that it "doesn't work on tickless kernels at the
moment".

Whatever the original reasons were, the only *remaining* reason seems to
have been that the accuracy of the time captured by pps_get_ts() was poor
on tickless kernels due to the kernel's per-tick timekeeping mechanism.

A recent change to ktime_get_snapshot_id() which is used by pps_get_ts()
has fixed that problem, by applying a correction to the ::systime field
so that it reports the ideal NTP-corrected time rather than the sanitized
and smoothed version which varies each tick.

Drop the no longer needed dependency.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.8
---
 drivers/pps/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pps/Kconfig b/drivers/pps/Kconfig
index e1651d51cfc9..3a2c457ed9d8 100644
--- a/drivers/pps/Kconfig
+++ b/drivers/pps/Kconfig
@@ -31,13 +31,10 @@ config PPS_DEBUG
 
 config NTP_PPS
 	bool "PPS kernel consumer support"
-	depends on !NO_HZ_COMMON
 	help
 	  This option adds support for direct in-kernel time
 	  synchronization using an external PPS signal.
 
-	  It doesn't work on tickless systems at the moment.
-
 source "drivers/pps/clients/Kconfig"
 
 source "drivers/pps/generators/Kconfig"
-- 
2.55.0

