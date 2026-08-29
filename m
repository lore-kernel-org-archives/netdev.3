Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585041E6CE;
	Sat, 29 Aug 2026 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788037259; cv=none; b=GbsBMjNrEOQbpgd3Psu0JPH/Ba0eYT1wSYm4n7Bmbd+l2BGpXIl7shtGFTQjGgUiggWromIRVy/Um4Cm9T5EUUaIr6OItVITAPnUVzWxqO2RSbfbbn87W+bygGNBVgVgAoBFqMZe9fxcLPduS/WEeW76U+BJy7OBMW2xTzesfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788037259; c=relaxed/simple;
	bh=k1fyYJhK4tqshCt8eP0ejcFCppKrGEep25mO33Xr+kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXTF7Sa0WaSMzjz24hGzpOWg8D5bPrMFI1iKCSUaUL5HFQunogmFsf1WZ+br1bOtdDZmdRDSKUBwXK+xqyM/pc0nvJCJCFoa8FRAlFAiFjlb4sEC/frZ9OITrE7WBuBZzKMRv02wr+q17qn6hhOM2/KYvGayw1yWBo/JFZeJ/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JxwjJcNY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JxwjJcNY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sqokai96hXEU7L6t3I+p6gUPCi3QiZOWR1HQ7tILvM8=; b=JxwjJcNYSZbD2TjBUqCcisAvfd
	4u8WRa0kre5ZDprjc+nOLS9eaiYcK4KshyhPnWNiEGtBaVmJsaWGFqX3vHZ8H+Jne4X+nkfCzWVU6
	4FLY5fR/GUOADkc6qPTfxiL/biqu872tQZEdOKOnF1M2Ew5jMplqCJr3yltCGASkKDT+yCUrjA5em
	Vq3acI3tBXHKthqRKgIutlR+I1r1kMfOTkzNWLAj93yPzhsv/lE3xp8Wc7FbNNSaFWIaNBZ12DJIo
	C74wefJ4CLEhEwwjdAuLoRzRqyE/K4JjIjsAlgQjZpJkIIrSHe5AJRlIa2+0GmRP2CM6n7vqcZkZc
	lt9CeWtA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x0QAR-0000000912K-33Cb;
	Sat, 29 Aug 2026 21:00:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x0QAO-00000000Abi-3VGI;
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
Subject: [PATCH v4 3/4] pps: Always use ktime_get_snapshot_id() for pps_get_ts()
Date: Sat, 29 Aug 2026 21:57:01 +0100
Message-ID: <20260829210041.40649-4-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

A recent commit changed ktime_get_snapshot_id() to return a corrected
::systime value which takes into account the divergence of the normal
per-tick timekeeping from the ideal NTP-disciplined clock.

Rather than using that more accurate timestamp *only* in the case where
CONFIG_NTP_PPS is enabled, do so unconditionally.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/pps_kernel.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 00b840970d56..35d6ac06a0c0 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -100,14 +100,12 @@ static inline void timespec_to_pps_ktime(struct pps_ktime *kt,
 
 static inline void pps_get_ts(struct pps_event_time *ts)
 {
-#ifdef CONFIG_NTP_PPS
 	struct system_time_snapshot snap;
 
 	ktime_get_snapshot_id(CLOCK_REALTIME, &snap);
 	ts->ts_real = ktime_to_timespec64(snap.systime);
+#ifdef CONFIG_NTP_PPS
 	ts->ts_raw = ktime_to_timespec64(snap.monoraw);
-#else
-	ktime_get_real_ts64(&ts->ts_real);
 #endif
 }
 
-- 
2.55.0

