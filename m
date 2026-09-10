Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462E39A057
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013233; cv=none; b=sJRXFpkpBhkZX2k+ZZu6y/QR6+LYPSwLPQbrUmsQmdWNxAGfLmzrlMrgitOywLjxHfXkmaCRPBps5+lUZiCyfDHoFv3oUzHZ6SaLjSHMLyU83TGnMW170tC0hEw07Clr1YlFLZ9N2EXe/PDIsc3RwSVTl6fxgbhbXL2EV293TRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013233; c=relaxed/simple;
	bh=8O7OA7NRtWER2mi1tQYij7c8KguAmXVtwpzGREABKJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BCQ0l25D4RPPZlAdQj3H5PBX823y9BzYKthSqOOUz/SxcEMQBnXSzFjK4yVCvPCz2HtOPSoJiGSXRkv58ohvMvS8B+PK/DzHIqq5zI0givousq+LT7td5w9LqrvV3/gTzIGsNDH0iRUHuXH4AuQk0em54pg6yRd4ZNsqYzB4MZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=NqitI5lq; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="NqitI5lq"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f6so7160355ad.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1789013231; x=1789618031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=065Fs6ol/VHxclK2iJqW35+e9V2WVaXBoq05wBkmxdM=;
        b=NqitI5lqqraeyxaTtJeFIU8Y9O/WfxXwy2uwFDFIwEGiLbffiKw/GTSG+PZq90NkKu
         +XPk8/R/Lt8NQdQjbMENDnCyOS8OTdVJyrad1HMplyChOrPQ0JS7VwtnX1JvxEQjIgiP
         55WvgGWwKDLGtQ3wft27KC03vBEHbyVy5e4YznlVB3+xUtefra+dpqjMX9KSzLH228BZ
         UQC3qu1EaEMYeKbFOmPlt21y6O2zILM4n2at1M02/LcePeoPUHRcY4LzfblNgWJh4VMb
         Jumrh/9iJf0+2YDdlkwG02zAlGpETxpHjfzIvDUXY49renDPpavC3OIhZq9wjO1jS4q8
         W1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789013231; x=1789618031;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=065Fs6ol/VHxclK2iJqW35+e9V2WVaXBoq05wBkmxdM=;
        b=leKptAL5M7V179Rf2bIxotdBx7GHVnEw51ZI/8ypEAMpL5E25iD0xOF64D+mpcw2uO
         /9rZf9t8AKTVymTvJxU4dSvOmKNnrcrzguQQvZfGgEtBmgJAhHhiWAzTdfCIY8J0oCB7
         W02EYNl7ArqdJnmK9Pf7WpD2SEwRixL1xle/3m4zL3mDDudUcT933retfqoErBFzMCts
         fCsZ3U+15cfm7Ug6c6H2M/aldmkaBIc357iwBGPMpz/zpzBtRy/Igi1zTBggdAqiIDXg
         EDVctnJ5O1lQ6NBWnmVqnA8X5Ouluezl3jcmd0ZEH7owoNR/leX6B9bGWFjyduy7I9Xc
         9MLQ==
X-Forwarded-Encrypted: i=1; AKwUvByt+s6JgZv9H9xwETRIpSRlrUMEYYh39j4bAqxItGgBJSDtdjl/Xwbv/3ffHA1LdfGJN4BI+So=@vger.kernel.org
X-Gm-Message-State: AFuF++lHY/RwR5HB+AdnF3b8fE2hoIYGn5aHSSxhb30IBMGNRHRB0XZ0
	u1/AFzyVvc/raB/EVttKZu62yB5PVfTcSdzYW/YeR3eCI6WnBmYB+NK1p0kO6btn1A==
X-Gm-Gg: AYBFou33bJ4blBmjaZN8mwPreoBPf3yDwgNVQC3YNziJf35PRmpFzgAUNpbFJjppVGd
	hTy4fhOYGjMxi+n7CMXma8pMLyWdFAov+bjGx5Z1DHWe/caumA8MifP8Iean6QMCQguI5tmBPXF
	ByoptOiXtbBWc+4LpoShLpDfOwG93UPjDDMBrJUcjpdqYpGbQLzt9znYtvbn+1SBBhZWqurKOs2
	rYypl+qS0Z1WxcWFKvfws2f4uOWazZxH+f1nST20mj+ePVGxrCs9K/4aJrwuyfulLIzTQUNAhbM
	dAAsJ7FJEvX3/KJrPRUXu1PoTqct9AIs75hL30G5iIUcKql1RkioPhFY8ATTfog6ui50j/08XFX
	oVtNQiZla8ZpXPeGp3PH6V9KD3MnRb8qdSh8UNyXhmwreTAGaBD+6nk5xiHnyePy6US76nWbU9T
	VmYKV7/Emr0d+hAJrhEkLCXr9C0OpSLUHTYoW7lCFkWp7lAH2EfV8iOQrCurL9c5+WdGvEHealC
	Tmr8P8=
X-Received: by 2002:a17:903:32c3:b0:2d9:3083:a3ac with SMTP id d9443c01a7336-2dd07cb7e83mr62965985ad.15.1789013230725;
        Wed, 09 Sep 2026 21:07:10 -0700 (PDT)
Received: from mimolette.lan ([58.136.73.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149cd817sm81589045ad.72.2026.09.09.21.07.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 21:07:10 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v2] net: macb: fix ordering around PTP timestamp read
Date: Thu, 10 Sep 2026 11:06:52 +0700
Message-ID: <20260910040658.18359-1-jjc@jclark.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PTP_SYS_OFFSET_EXTENDED returns system timestamps that do not correctly
bracket the PHC register read on MACB/GEM. On a Raspberry Pi 5, the
returned interval can be as short as 37 ns, while an ordered register
read takes approximately 1 us. This biases the midpoint used by phc2sys,
causing CLOCK_REALTIME to run approximately 0.5 us ahead when synchronized
to the PHC.

gem_tsu_get_time() reads the nanoseconds register using the driver's
relaxed MMIO accessor. On weakly ordered systems, the subsequent system
timestamp can be taken before the register read completes. The internal
smp_rmb() in the pre-timestamp path also does not guarantee ordering
against the subsequent MMIO read.

Add rmb() before and after the bracketed nanoseconds read in both the
normal and seconds rollover paths so the system timestamps bracket the
PHC read. Adding the post-read barrier increases the minimum interval on
the same Raspberry Pi 5 to approximately 1 us.

Fixes: e51bb5c2784c ("net: macb: ptp: Switch to gettimex64() interface")
Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # Raspberry Pi CM5, min bracket 37 ns -> 981 ns
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: James Clark <jjc@jclark.com>
---
Changes in v2:
- Add rmb() before the PHC read in both paths, following Théo Lebrun's
  feedback. Explain why the pre-timestamp path's smp_rmb() is insufficient
  for MMIO ordering.
- Wrap the post-read barrier comments.
- Add Nicolai Buchwitz's Tested-by and Reviewed-by tags.
- Drop RFC.

v1: https://lore.kernel.org/netdev/20260908053150.28694-1-jjc@jclark.com/

Nicolai's review and testing were on v1. The additional pre-read barriers
in v2 address Théo's feedback.

Reproducer:

#include <fcntl.h>
#include <linux/ptp_clock.h>
#include <stdio.h>
#include <sys/ioctl.h>

#define DEVICE "/dev/ptp0"

int main(void)
{
	struct ptp_sys_offset_extended ex = { .n_samples = 25 };
	long long min = -1;
	int fd = open(DEVICE, O_RDONLY);

	if (fd < 0) {
		perror(DEVICE);
		return 1;
	}
	for (int batch = 0; batch < 40; batch++) {
		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED, &ex) < 0) {
			perror("PTP_SYS_OFFSET_EXTENDED");
			return 1;
		}
		for (unsigned int i = 0; i < ex.n_samples; i++) {
			long long bracket = (ex.ts[i][2].sec - ex.ts[i][0].sec) * 1000000000LL
				+ (long long)ex.ts[i][2].nsec - ex.ts[i][0].nsec;
			if (min < 0 || bracket < min)
				min = bracket;
		}
	}
	printf("min bracket: %lld ns\n", min);
	return 0;
}

 drivers/net/ethernet/cadence/macb_ptp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index e5195d7da..4fb287608 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -50,7 +50,15 @@ static int gem_tsu_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts,
 
 	spin_lock_irqsave(&bp->tsu_clk_lock, flags);
 	ptp_read_system_prets(sts);
+	/* ptp_read_system_prets() uses smp_rmb() internally,
+	 * which does not guarantee ordering against MMIO reads.
+	 */
+	rmb();
 	first = gem_readl(bp, TN);
+	/* Ensure the PHC read completes before taking
+	 * the post timestamp.
+	 */
+	rmb();
 	ptp_read_system_postts(sts);
 	secl = gem_readl(bp, TSL);
 	sech = gem_readl(bp, TSH);
@@ -62,7 +70,15 @@ static int gem_tsu_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts,
 		 * (assume all done within 1s)
 		 */
 		ptp_read_system_prets(sts);
+		/* ptp_read_system_prets() uses smp_rmb() internally,
+		 * which does not guarantee ordering against MMIO reads.
+		 */
+		rmb();
 		ts->tv_nsec = gem_readl(bp, TN);
+		/* Ensure the PHC read completes before taking
+		 * the post timestamp.
+		 */
+		rmb();
 		ptp_read_system_postts(sts);
 		secl = gem_readl(bp, TSL);
 		sech = gem_readl(bp, TSH);
-- 
2.47.3

