Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C03AA9E2
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 04:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448315; cv=none; b=GFGk951YFKyzu5w7n8VDC/O2QSWPZQNRcnu1Jco8Hr2C/+c4/lV1kAtk/5zIhvQ1rOVffc7s0jEM2N8FHpEflyttiGq4BykkMmKZtn/Qvcb+6C4jalRgOdiDqoOScSputvkKhR6AG5vZUsMhSu3+DPm4nyxWD1smnChGMwR+1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448315; c=relaxed/simple;
	bh=C1fXXNHo8UXoCAzodDxhxcKZtEoK+gCFLSDL6HtXi+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pudn30P6qU5yACT5PwGUMXVQxDfEfCIrUCSK73CIu2GjIEoJBOY6uCYIwFi9LAb6UNWlnY2ltuXR1rM6IhYA52vp1MW5+RP1fBgLiz5dPfY9jcnI9ovcoCyjWWp+W2WcIrkRpGQru+Oa92eedDCpkhymuLeDrvDIOLyQ5IcoWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=eIN8lMVM; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="eIN8lMVM"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b355ffso1661982b3a.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1789448313; x=1790053113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYkfKrdykGTTKNXpCcbgVoHk584EaRb8tbI837afgGA=;
        b=eIN8lMVMRpGDi+0NxBXPGaI2D/sLJJvZYZaY451385xm8coxhQilRcVtZD/XTnM0U6
         oHanIMKrEPIFaNjelDbompDAKw/i7ui+lb56xB5ge7u41t7oMHIOoxwU7m3uOOoYbNdZ
         HogwphvEEUYxfY4g45/nBl8yzb2aT+4Nl/xw2j8seV2KWOjVY5mK++pq6lihpv+1pNm0
         mLiwIYYxl1GET7BkWRBKSsvM3dmzdovb0dTIbbt5wnIPEUtO4SHiPkfGcXxbw37VgzFI
         HOKBMucJH7kWd9BThAsPtKuG1RHpFpHWHQ/cNhYez3bpEYjUSDoD4gOVfEIJO633YSts
         Gcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789448313; x=1790053113;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DYkfKrdykGTTKNXpCcbgVoHk584EaRb8tbI837afgGA=;
        b=BLFZZtfq+Q8Q+yAZeAl0UJb8KF4kUWeB7rZmFx5ZnZjSQ5/KKmIzkzYpjFRWJ3AiFs
         Q7gvLQXfQFZrf4hbUxuqPJ4bs3v2c/LyfsG8kt9ORiYynlUoPNWapeiYBMch2gzQRR3X
         pJh8eLlY5HvV88oAvjw44hBv0RrO7FCghGqiocHmGCkN+fB3IA0LXGKHVd8f3BXETv5e
         F+kscCUvvZYGjo5uBZO4XNQKuoPewSknV4I9niFsuOSX8uCge34DG3UvIx+teevmI2la
         TBqc4pzLEEf62mNiYqB51naOW5EGf8Riu6O3enw1pfG4fiWue/wQDDbZIDFqfI0YJ2Ek
         ytfA==
X-Forwarded-Encrypted: i=1; AKwUvBwvTMcr6Nszog8ZulP69SFXDrTxV9kUEv0AwsylSJTx/2gLtraMwoHwkwNVmmFC4clZzTEHaKw=@vger.kernel.org
X-Gm-Message-State: AFuF++kKXD83furBvPGJQ/H6eMThIfv9Bh2MliNRaZe27vN81Ubd919I
	TdKHgR8ccTmn0FJg72mtDzmWmU8zoBnqTHhYLp41l3nH/jyQunKVP3ARXFWA3wZhZA==
X-Gm-Gg: AYBFou1F+Jd3wbQYT5mKVut/rjftjdQFD91oM+Vl7DN9W360+Eu6lk7ddd2yoIWERQ/
	+Lb5Ims7t1IBvTJaiTb4HeREZCvWCklaGSKcIy6zq9Uwkj08l0O7ReYvp+vdvK6/mYPSy4FwwjS
	6zQutNDQcSy1+knOB/4xN08DfCPfbujm4p6V7xjYZ1DPohkGuNfNo47Z1TYL8j/wBPqBrelKC86
	iQ2Zv0WfJS4LaDVK8K+ljHLiarYyZ2z+O0o3pCdNeJMkJl5kmzz+svEiv/4yKY2VRs8PmjihN1U
	mfL3yNq1AA7EDodW3kTPAMKps+hfaXC3qrfwdnPpqdegubfiBn2XNe2KWZ/Xed9TztA1t8vewBf
	PvZHmt0HtOZ2FdysAPKd/ILgd+b+Xj5UEpP2lDECltt9mSsYvVzr39Y5lB0Tb0sAGsGXsE3dkcD
	n/9hwRfANUIq6hlnJ47mYz8cQkQDNIOIVRS69LLjK9OL5xjHxKl5roNlh9PRcAT24vJ1e/nfUSp
	1mvtcqm
X-Received: by 2002:a05:6a00:9087:b0:847:8449:2bb6 with SMTP id d2e1a72fcca58-86f82a5e981mr10610059b3a.4.1789448312906;
        Mon, 14 Sep 2026 21:58:32 -0700 (PDT)
Received: from mimolette.lan ([58.136.228.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c65b5f96sm5917398a12.32.2026.09.14.21.58.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 21:58:32 -0700 (PDT)
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
Subject: [PATCH net v3] net: macb: fix ordering around PTP timestamp read
Date: Tue, 15 Sep 2026 11:58:17 +0700
Message-ID: <20260915045823.76100-1-jjc@jclark.com>
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
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Assisted-by: LLM
Signed-off-by: James Clark <jjc@jclark.com>
---
Changes in v3:
- Guard the barriers with if (sts), following Jakub's feedback.
- Reduce the comments following Théo's feedback, and focus on relevant
  point following Jakub's feedback.
- Add Théo Lebrun's Reviewed-by from v2.
- Add Assisted-by: LLM.

v2: https://lore.kernel.org/netdev/20260910040658.18359-1-jjc@jclark.com/
v1: https://lore.kernel.org/netdev/20260908053150.28694-1-jjc@jclark.com/

Nicolai's testing and review covered v1; Théo's review covered v2.

 drivers/net/ethernet/cadence/macb_ptp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index e5195d7da..a9ac09900 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -50,7 +50,12 @@ static int gem_tsu_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts,
 
 	spin_lock_irqsave(&bp->tsu_clk_lock, flags);
 	ptp_read_system_prets(sts);
+	/* explicit barriers are needed because gem_readl() is relaxed */
+	if (sts)
+		rmb();
 	first = gem_readl(bp, TN);
+	if (sts)
+		rmb();
 	ptp_read_system_postts(sts);
 	secl = gem_readl(bp, TSL);
 	sech = gem_readl(bp, TSH);
@@ -62,7 +67,11 @@ static int gem_tsu_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts,
 		 * (assume all done within 1s)
 		 */
 		ptp_read_system_prets(sts);
+		if (sts)
+			rmb();
 		ts->tv_nsec = gem_readl(bp, TN);
+		if (sts)
+			rmb();
 		ptp_read_system_postts(sts);
 		secl = gem_readl(bp, TSL);
 		sech = gem_readl(bp, TSH);
