Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE1369D59;
	Mon, 22 Jun 2026 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163124; cv=none; b=aZhlnbS/fjEymebOdtZIBBbPDv4FYGjDWhHC/+GusfxlYIEtie5TNec5KFk44cgvK36BgYEC1FLRKyaCQm4n69QUBeIL+JSLlm2LSMc5CkHyfGVtZ24U2ZPjZITpZ9OLu+1+2AGeyyficV8YEJk9d9eZ5dycJXvPMTVa4JVhu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163124; c=relaxed/simple;
	bh=XrqHhhGljxZqPrtvgqypJ4nFaxF3X/db1AiTstBagR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzL90HS1ckpJ3LkTYSLmSzMKJL5k8bcUw6MUNQDSYLzm8LYDmYWCDKlgp+5cYlDt+rmR7MCs2Gc87D/1jK/RpjbJumBHo40vf78QLw1gN165YKc9pRK7vKbYuBuCFeB9GfIYJ8mBquyEzFTyEy5piXBTQL+5yDI8Y1BEIsw32Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GcDFvMTX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GcDFvMTX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1PYRfZz7nurdplavpgu+gUymp/rM8bjZy32eyBkD6vA=; b=GcDFvMTX8HgJPRznQ67jjKYnXY
	46XrlLiaV4ioFhI66Z5XCl/B1l0Bqc8HB2KWdbCUgl1xlr92GXB6PRXDrw3cmOdWNgSzYufqXjr+R
	2QUM0LHbCH8HpOTZc7LAvoVcvuH84whdfunA9YBQsGax221k7+PV/X54rmJbHfSsH/j98ZOtOmhGn
	IgfYbRkNOOUsHyrfgfakdXNo2MplwAHmkRRQm3Ymad3KAT+MmkT3WKy1D7JoUvhMXwuyLshTyCruG
	GtfeQw4//V/r28yb0F8fnwqIv4SMs/1WNhCnj0H5iyU8mFfSG3E5r5XOhVVJalLex5STRl3leparB
	I5R1mZxw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbm2G-00000000KDu-0VDF;
	Mon, 22 Jun 2026 21:18:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbm2D-00000004R56-0jRv;
	Mon, 22 Jun 2026 22:18:25 +0100
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
Subject: [RFC PATCH v3 2/4] pps: Drop the !NO_HZ_COMMON dependency from NTP_PPS
Date: Mon, 22 Jun 2026 21:36:19 +0100
Message-ID: <20260622211822.1056437-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622211822.1056437-1-dwmw2@infradead.org>
References: <20260622211822.1056437-1-dwmw2@infradead.org>
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
2.54.0

