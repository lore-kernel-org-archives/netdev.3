Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2813016E0
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845523; cv=none; b=g5h+myBgFT/Q4yh2gXm5Elpi1rmRsKzNz00ckb2sDKnzJvxndWUJY/3TxbEEatOO6mcuz6zRCmkOlgCJbAthqWmLf5Zxp/RP8A3HLalBEpzvwuqxmdtl2sljC1LRVesX0HZDeQqxV6GtELyCVKP7vVrJAvsI4KUod1ZrlXa341c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845523; c=relaxed/simple;
	bh=iwnWeb25yE+rfN9kEI49A4U/Q/LIF6dD2bDHyg4G3r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZforwR9TTKygf7EAUPXYJwU6w6ViOQfDfNQSvP7nteBJXgAb1/YUSxkMBltfv/r4l8cAu1b+Gq2rPXnppqET8FIulIGEXUajg6v2JPAoDMNTlI4JEMoRJT+BhNbcj9BMLAc586tqE1WAELD4uLWwjzdTKauEve69WDKJWWjKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=mrhfo5Gl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="mrhfo5Gl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39675172593so3321010a91.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 22:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1788845520; x=1789450320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WhTOX+3txKjY+wR/I/V3MXNzBLpDrt5vGG76ZNsRJD8=;
        b=mrhfo5GlwTXyeDvnjGyeWlEDWgj025c3iITACc5W7RBSILRY6+HA50cIMAlo4YUwnV
         5OFEsTzL9VoGMLLm4rAJvvOsOLIVOX9n3/bUBgyHA5Hn3A1LUN1XXjCJ2F7quf1S5yTZ
         PP0kvsiBRxXENk9JlJQMLrl7+tpi+zpCHkCsdoM8ALO1SWH15TMwcpwkyvht1AqUGzYY
         tUt/2+53T6A9Dm0J31zWOHaIBwvZreTkQU+rsPcadT0Ozq4+iYhURnm9WuZvRABPREeK
         KJw1pztvtdqf/HHy5xwYXK09LiTECnkpCVQ7Swa50uJ+R8yodXhHLqajmtlC7VD0Zz+x
         G0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845520; x=1789450320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhTOX+3txKjY+wR/I/V3MXNzBLpDrt5vGG76ZNsRJD8=;
        b=s3gVjZJQhrzifBoxxfRQfELhSUo3rBcRcPgVavmeOV+waXdDLrYA3lbhAvc1fGf3ev
         KrQgRBiUm1kcSmuW8vu4M75ypVGbej6Nm4LQEJUaQ/+x/5o6uV+uSQsUo708V21PyO66
         RMfD6ikepyECbe4To+cZ2z+e8Oq8EQRhH+6eC6gQTkqzHVxvNHNkP2Kn/JLQHpuJxKO9
         ww9/AfpCzssf1jQTD/IVVgHMWg8IqWQzgtd06aqsKxIaLwSeVX+3z9zA2IUKXit99yhT
         6AZkQI5ijppqAkDM6L1vmLSq9W6fNq8BrtntfsuNtwC6UbNZL1aCfMczx10scUakTQMM
         QFTg==
X-Forwarded-Encrypted: i=1; AKwUvBybZU7tS0ca5ZV+rCoZSh51CVyIv5PUJzm0szZD+/8q34NBP8U1I0ejIVUcCYdGSu/WLtSSomw=@vger.kernel.org
X-Gm-Message-State: AFuF++lu/RWYEUtbhbsu4r78P64aJYu6ynqQB0eewGvN9hsgIi3klnxy
	5F2HUUFdl3T9Xkiy1d+bKjGxHIzx57qqLMbcHHk0DffY3yIly5WJ8+WaOY20QzGHOA==
X-Gm-Gg: AYBFou2Dqs7s2fgG2rPUFAGxo70eNASRP2lpWqKs6WOouUXdv8eS6QQb/1o6hCMy9Ib
	/wuQ8b5WmtrSWq4nOUUx9UuE2zt0aywPehofJuXUrJLHKXg4GcoqimneqZlJHl3ys5zTU6spya0
	qztdoJPD7UIffEt9n0SkzadkA3CP0lG0V+8Jyn8zpjJ5V83ZENuOEAm6osUY8K0kkh+opZAaGOG
	uYwgUOf5zO9iq6E4FgoICnLxCimzUVjbeMDWG6Ead0Psgdxu3Zm9sh0UgD9PNJqcT8njioCBi6E
	PjouoAg0esBldYrWp0x0gEXYypoX2sltFSoqBLHgwYG2jqw5H16hpjS3XO3eF+pC5hd4NQiLnKi
	cTO9I34AV68F3KX9HVoZaZmgBQTUG1KwMDeohBP5H5Z/UghSjvo9FruD8d6TfdqFvIJACtrE+0r
	+2J+ImTs9xDq3Kgc42QLMxS7+EI3pHUY6O6ni3warWBPQswXfajDbWOx8f6sTyjy25xhTc
X-Received: by 2002:a17:90b:57cd:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-39b260fead0mr40465578a91.1.1788845520117;
        Mon, 07 Sep 2026 22:32:00 -0700 (PDT)
Received: from mimolette.lan ([58.136.73.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacba5sm31866443a91.12.2026.09.07.22.31.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:31:59 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net] net: macb: fix ordering around PTP timestamp read
Date: Tue,  8 Sep 2026 12:31:45 +0700
Message-ID: <20260908053150.28694-1-jjc@jclark.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTP_SYS_OFFSET_EXTENDED returns system timestamps that do not correctly
bracket the PHC register read on MACB/GEM. On a Raspberry Pi 5, the
returned interval can be as short as 37 ns, while an ordered register
read takes approximately 1 us. This biases the midpoint used by phc2sys,
causing CLOCK_REALTIME to run approximately 0.5 us ahead when synchronized
to the PHC.

gem_tsu_get_time() reads the nanoseconds register using the driver's
relaxed MMIO accessor. On weakly ordered systems, the subsequent system
timestamp can be taken before the register read completes.

Add rmb() after the bracketed nanoseconds read in both the normal and
seconds rollover paths, ensuring that the read completes before the post
timestamp is taken. With the fix, the minimum interval on the same
Raspberry Pi 5 increases to approximately 1 us.

Fixes: e51bb5c2784c ("net: macb: ptp: Switch to gettimex64() interface")
Signed-off-by: James Clark <jjc@jclark.com>
---
This uses rmb() to preserve the existing accessor and endianness handling.
Would an ordered MMIO accessor be preferable for these two reads?

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

 drivers/net/ethernet/cadence/macb_ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index e5195d7da..8209ec190 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -51,6 +51,8 @@ static int gem_tsu_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts,
 	spin_lock_irqsave(&bp->tsu_clk_lock, flags);
 	ptp_read_system_prets(sts);
 	first = gem_readl(bp, TN);
+	/* Ensure the PHC read completes before taking the post timestamp. */
+	rmb();
 	ptp_read_system_postts(sts);
 	secl = gem_readl(bp, TSL);
 	sech = gem_readl(bp, TSH);
@@ -63,6 +65,8 @@ static int gem_tsu_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts,
 		 */
 		ptp_read_system_prets(sts);
 		ts->tv_nsec = gem_readl(bp, TN);
+		/* Ensure the PHC read completes before taking the post timestamp. */
+		rmb();
 		ptp_read_system_postts(sts);
 		secl = gem_readl(bp, TSL);
 		sech = gem_readl(bp, TSH);
-- 
2.47.3

